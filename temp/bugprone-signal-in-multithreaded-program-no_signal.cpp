// RUN: %check_clang_tidy %s bugprone-signal-in-multithreaded-program %t \
// RUN: -config='{CheckOptions: \
// RUN:  [{key: bugprone-signal-in-multithreaded-program.ThreadList, value: "thrd_create"}]}'

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

  std::thread threadObj(threadFunction);

  return 0;
}