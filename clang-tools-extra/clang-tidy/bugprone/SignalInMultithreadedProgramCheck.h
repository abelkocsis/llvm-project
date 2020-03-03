//===--- SignalInMultithreadedProgramCheck.h - clang-tidy -------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_BUGPRONE_SIGNALINMULTITHREADEDPROGRAMCHECK_H
#define LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_BUGPRONE_SIGNALINMULTITHREADEDPROGRAMCHECK_H

#include "../ClangTidyCheck.h"
#include "clang/AST/ASTContext.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include <string>
#include <vector>

namespace clang {
namespace tidy {
namespace bugprone {

/// Finds ``signal`` function calls when the program is multithreaded. It
/// founds a program multithreaded when it finds at least one function call
/// of the following: ``thrd_create``, ``std::thread``, ``boost::thread``,
/// ``pthread_t``.
///
/// For the user-facing documentation see:
/// http://clang.llvm.org/extra/clang-tidy/checks/bugprone-signal-in-multithreaded-program.html
class SignalInMultithreadedProgramCheck : public ClangTidyCheck {
public:
  SignalInMultithreadedProgramCheck(StringRef Name, ClangTidyContext *Context)
      : ClangTidyCheck(Name, Context),
        ThreadList(Options.get(
            "ThreadList", "thrd_create;::thread;boost::thread;pthread_t")) {}
  void storeOptions(ClangTidyOptions::OptionMap &Opts) override;
  void registerMatchers(ast_matchers::MatchFinder *Finder) override;
  void check(const ast_matchers::MatchFinder::MatchResult &Result) override;

private:
  const std::string ThreadList;
};

} // namespace bugprone
} // namespace tidy
} // namespace clang

#endif // LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_BUGPRONE_SIGNALINMULTITHREADEDPROGRAMCHECK_H
