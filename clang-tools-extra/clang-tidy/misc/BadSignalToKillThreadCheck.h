//===--- BadSignalToKillThreadCheck.h - clang-tidy --------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_MISC_BADSIGNALTOKILLTHREADCHECK_H
#define LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_MISC_BADSIGNALTOKILLTHREADCHECK_H

#include "../ClangTidyCheck.h"

namespace clang {
namespace tidy {
namespace misc {

/// Do not send an uncaught signal to kill a thread because the signal kills the
/// entire process, not just the individual thread. To learn more about this
/// rule see:
/// https://wiki.sei.cmu.edu/confluence/display/c/POS44-C.+Do+not+use+signals+to+terminate+threads
/// For the user-facing documentation see:
/// http://clang.llvm.org/extra/clang-tidy/checks/misc-bad-signal-to-kill-thread.html
class BadSignalToKillThreadCheck : public ClangTidyCheck {
public:
  BadSignalToKillThreadCheck(StringRef Name, ClangTidyContext *Context)
      : ClangTidyCheck(Name, Context) {}
  void registerMatchers(ast_matchers::MatchFinder *Finder) override;
  void check(const ast_matchers::MatchFinder::MatchResult &Result) override;
  void registerPPCallbacks(const SourceManager &SM, Preprocessor *PP,
                           Preprocessor *ModuleExpanderPP) override;
  Optional<unsigned> SigtermValue;
};

} // namespace misc
} // namespace tidy
} // namespace clang

#endif // LLVM_CLANG_TOOLS_EXTRA_CLANG_TIDY_MISC_BADSIGNALTOKILLTHREADCHECK_H