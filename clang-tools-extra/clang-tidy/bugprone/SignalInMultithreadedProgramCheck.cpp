//===--- SignalInMultithreadedProgramCheck.cpp - clang-tidy ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SignalInMultithreadedProgramCheck.h"
#include "../utils/Matchers.h"
#include "../utils/OptionsUtils.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include "clang/Basic/TargetInfo.h"
#include "clang/Lex/Preprocessor.h"

using namespace clang::ast_matchers;
using namespace clang::ast_matchers::internal;

namespace clang {
namespace tidy {
namespace bugprone {

static Preprocessor *PP;

Matcher<FunctionDecl> hasAnyListedName(const std::string &FunctionNames) {
  const std::vector<std::string> NameList =
      utils::options::parseStringList(FunctionNames);
  return hasAnyName(std::vector<StringRef>(NameList.begin(), NameList.end()));
}

void SignalInMultithreadedProgramCheck::storeOptions(
    ClangTidyOptions::OptionMap &Opts) {
  Options.store(Opts, "ThreadList", ThreadList);
}

void SignalInMultithreadedProgramCheck::registerMatchers(MatchFinder *Finder) {

  auto threadCall = anyOf(
      hasDescendant(callExpr(ignoringImpCasts(hasDescendant(declRefExpr(
          hasDeclaration(functionDecl(hasAnyListedName(ThreadList)))))))),
      hasDescendant(varDecl(hasType(recordDecl(hasName("::std::thread")))))

  );
  Finder->addMatcher(
      callExpr(
          ignoringImpCasts(hasDescendant(declRefExpr(hasDeclaration(
              functionDecl(allOf(hasName("::signal"), parameterCountIs(2),
                                 hasParameter(0, hasType(isInteger())))))))),
          hasAncestor(compoundStmt(threadCall)))
          .bind("signal"),
      this);
}

void SignalInMultithreadedProgramCheck::check(
    const MatchFinder::MatchResult &Result) {
  bool IsPosix = PP->isMacroDefined("_POSIX_C_SOURCE") ||
                 Result.Context->getTargetInfo().getTriple().getVendor() ==
                     llvm::Triple::Apple;
  if (IsPosix)
    return;
  const auto *MatchedSignal = Result.Nodes.getNodeAs<CallExpr>("signal");
  diag(MatchedSignal->getExprLoc(),
       "signal function should not be called in a multithreaded program");
}

void SignalInMultithreadedProgramCheck::registerPPCallbacks(
    const SourceManager &SM, Preprocessor *pp, Preprocessor *ModuleExpanderPP) {
  PP = pp;
}

} // namespace bugprone
} // namespace tidy
} // namespace clang
