//===--- SignalInMultithreadedProgramCheck.cpp - clang-tidy ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SignalInMultithreadedProgramCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace bugprone {

void SignalInMultithreadedProgramCheck::registerMatchers(MatchFinder *Finder) {

  auto signalCall =
      callExpr(
          ignoringImpCasts(hasDescendant(declRefExpr(hasDeclaration(
              functionDecl(allOf(hasName("signal"), parameterCountIs(2),
                                 hasParameter(0, hasType(isInteger())))))))))
          .bind("signal");

  auto threadCall = callExpr(ignoringImpCasts(
      hasDescendant(declRefExpr(hasDeclaration(functionDecl(hasAnyName(
          "thrd_create", "::thread", "boost::thread", "dlib::thread_function",
          "dlib::thread_pool", "dlib::default_thread_pool", "pthread_t")))))));

  Finder->addMatcher(translationUnitDecl(allOf(hasDescendant(signalCall),
                                               hasDescendant(threadCall))),
                     this);
}

void SignalInMultithreadedProgramCheck::check(
    const MatchFinder::MatchResult &Result) {
  const auto *MatchedSignal = Result.Nodes.getNodeAs<CallExpr>("signal");
  diag(MatchedSignal->getExprLoc(),
       "singal function should not be called in a multithreaded program");
}

} // namespace bugprone
} // namespace tidy
} // namespace clang
