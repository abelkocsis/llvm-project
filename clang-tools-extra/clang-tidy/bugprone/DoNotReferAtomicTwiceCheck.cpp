//===--- DoNotReferAtomicTwiceCheck.cpp - clang-tidy ----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "DoNotReferAtomicTwiceCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace bugprone {

void DoNotReferAtomicTwiceCheck::registerMatchers(MatchFinder *Finder) {
  Finder->addMatcher(
      declRefExpr(hasType(hasUnqualifiedDesugaredType(atomicType())),
                  to(varDecl().bind("atomic")),
                  hasAncestor(binaryOperator(
                      unless(hasDescendant(atomicExpr())),
                      hasRHS(hasDescendant(
                          declRefExpr(to(varDecl(equalsBoundNode("atomic"))))
                              .bind("rhs"))))),
                  unless(equalsBoundNode("rhs"))),
      this);
}

void DoNotReferAtomicTwiceCheck::check(const MatchFinder::MatchResult &Result) {
  const auto *MatchedVar = Result.Nodes.getNodeAs<VarDecl>("atomic");
  const auto *MatchedRef = Result.Nodes.getNodeAs<DeclRefExpr>("rhs");
  if (!MatchedRef || !MatchedVar)
    return;
  diag(MatchedRef->getExprLoc(),
       "Do not refer to atomic variable '%0' twice in an expression")
      << MatchedVar->getName();
}

} // namespace bugprone
} // namespace tidy
} // namespace clang
