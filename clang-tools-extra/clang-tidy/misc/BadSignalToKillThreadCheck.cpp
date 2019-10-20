//===--- BadSignalToKillThreadCheck.cpp - clang-tidy ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "BadSignalToKillThreadCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace misc {

void BadSignalToKillThreadCheck::registerMatchers(MatchFinder *Finder) {
  Finder->addMatcher(
      callExpr(allOf(callee(functionDecl(hasName("::pthread_kill"))),
                     argumentCountIs(2)),
               hasArgument(1, integerLiteral().bind("integer-literal")))
          .bind("thread-kill"),
      this);
}

static Preprocessor *PP;

void BadSignalToKillThreadCheck::check(const MatchFinder::MatchResult &Result) {
  auto It = PP->macro_begin();
  while (It != PP->macro_end() && !SigtermValue.hasValue()) {
    if (It->first->getName() == "SIGTERM") {
      const MacroInfo *MI = PP->getMacroInfo(It->first);
      const Token &T = MI->tokens().back();
      StringRef ValueStr = StringRef(T.getLiteralData(), T.getLength());
      llvm::APInt IntValue;
      ValueStr.getAsInteger(10, IntValue);
      SigtermValue = IntValue.getZExtValue();
    }

    ++It;
  }
  if (!SigtermValue)
    return;

  const auto *MatchedExpr = Result.Nodes.getNodeAs<Expr>("thread-kill");
  const auto *MatchedIntLiteral =
      Result.Nodes.getNodeAs<IntegerLiteral>("integer-literal");
  if (MatchedIntLiteral->getValue() == *SigtermValue) {
    diag(MatchedExpr->getBeginLoc(),
         "Thread should not be terminated by SIGTERM signal.");
  }
}

void BadSignalToKillThreadCheck::registerPPCallbacks(
    const SourceManager &SM, Preprocessor *pp, Preprocessor *ModuleExpanderPP) {
  PP = pp;
}

} // namespace misc
} // namespace tidy
} // namespace clang
