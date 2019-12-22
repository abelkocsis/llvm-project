//===--- SpuriouslyWakeUpFunctionsCheck.cpp - clang-tidy ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SpuriouslyWakeUpFunctionsCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include <iostream> //atm!

using namespace clang::ast_matchers;

namespace clang {
namespace tidy {
namespace bugprone {

void SpuriouslyWakeUpFunctionsCheck::registerMatchers(MatchFinder *Finder) {

    auto hasUniqueLock = hasDescendant(declRefExpr(hasDeclaration(
        varDecl(hasType(asString("std::unique_lock<std::mutex>"))))));

    auto hasWaitDescendantCPP = hasDescendant(
        cxxMemberCallExpr(
            anyOf(
                allOf(hasDescendant(memberExpr(hasDeclaration(functionDecl(
                          allOf(hasName("std::condition_variable::wait"),
                                parameterCountIs(1)))))),
                      onImplicitObjectArgument(declRefExpr(to(varDecl(
                          hasType(asString("std::condition_variable &")))))),
                      hasUniqueLock),
                allOf(hasDescendant(memberExpr(hasDeclaration(functionDecl(
                          allOf(hasName("std::condition_variable::wait_for"),
                                parameterCountIs(2)))))),
                      onImplicitObjectArgument(declRefExpr(to(varDecl(
                          hasType(asString("std::condition_variable &")))))),
                      hasUniqueLock),
                allOf(hasDescendant(memberExpr(hasDeclaration(functionDecl(
                          allOf(hasName("std::condition_variable::wait_until"),
                                parameterCountIs(2)))))),
                      onImplicitObjectArgument(declRefExpr(to(varDecl(
                          hasType(asString("std::condition_variable &")))))),
                      hasUniqueLock)

                    ))
            .bind("wait"));

    auto hasWaitDescendantC = hasDescendant(
        callExpr(callee(functionDecl(hasName("cnd_wait")))).bind("wait"));
    Finder->addMatcher(
        ifStmt(
            anyOf(
            // Check for `CON54-CPP`
            allOf(hasWaitDescendantCPP,
                  unless(anyOf(hasDescendant(ifStmt(hasWaitDescendantCPP)),
                               hasDescendant(whileStmt(hasWaitDescendantCPP)),
                               hasDescendant(forStmt(hasWaitDescendantCPP)),
                               hasDescendant(doStmt(hasWaitDescendantCPP))))),
            // Check for `CON36-C`
            hasDescendant(compoundStmt(
            allOf(hasWaitDescendantC,
                  unless(anyOf(hasDescendant(ifStmt(hasDescendant(
                                   compoundStmt(hasWaitDescendantC)))),
                               hasDescendant(whileStmt(hasWaitDescendantC)),
                               hasDescendant(forStmt(hasWaitDescendantC)),
                               hasDescendant(doStmt(hasWaitDescendantC)))))))     )                 ),
        this);
}

void SpuriouslyWakeUpFunctionsCheck::check(
    const MatchFinder::MatchResult &Result) {
  const auto *MatchedWait = Result.Nodes.getNodeAs<CallExpr>("wait");
  diag(
      MatchedWait->getExprLoc(),
      "'%0' should be placed inside a while statement or used with a condition "
      "parameter")
      << MatchedWait->getDirectCallee()->getName();
}
} // namespace bugprone
} // namespace tidy
} // namespace clang
