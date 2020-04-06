// RUN: %check_clang_tidy %s bugprone-signal-in-multithreaded-program %t

typedef unsigned long int thrd_t;
typedef int (*thrd_start_t)(void *);
typedef int sig_atomic_t;
#define SIGUSR1 30
#define NULL 0

void (*signal(int sig, void (*handler)(int)))(int);

int thrd_create(thrd_t *thr, thrd_start_t func, void *arg) { return 0; };
enum {
  thrd_success = 0,
};

volatile sig_atomic_t flag = 0;

void handler(int signum) {
  flag = 1;
}

int func(void *data) {
  while (!flag) {
  }
  return 0;
}

int main(void) {
  signal(SIGUSR1, handler);
  // CHECK-MESSAGES: :[[@LINE-1]]:3: warning: signal function should not be called in a multithreaded program [bugprone-signal-in-multithreaded-program]
  thrd_t tid;

  if (thrd_success != thrd_create(&tid, func, NULL)) {
  }
  return 0;
}
