// RUN: %check_clang_tidy %s bugprone-signal-in-multithreaded-program %t \
// RUN: -config='{CheckOptions: \
// RUN:  [{key: bugprone-signal-in-multithreaded-program.ThreadList, value: "::thread"}]}'

typedef unsigned long int thrd_t;
typedef int (*thrd_start_t)(void *);
typedef int sig_atomic_t;
#define SIGUSR1 30
#define NULL 0

void (*signal(int sig, void (*handler)(int)))(int);

volatile sig_atomic_t flag = 0;

void handler(int signum) {
  flag = 1;
}

void threadFunction() {}

namespace std {
class thread {
public:
  thread() noexcept;
  template <class Function, class... Args>
  explicit thread(Function &&f, Args &&... args);
  thread(const thread &) = delete;
  thread(thread &&) noexcept;
};
} // namespace std

int main(void) {
  signal(SIGUSR1, handler);
  // CHECK-MESSAGES: :[[@LINE-1]]:3: warning: signal function should not be called in a multithreaded program [bugprone-signal-in-multithreaded-program]

  std::thread threadObj(threadFunction);

  return 0;
}