// RUN: %check_clang_tidy %s bugprone-spuriously-wake-up-functions %t -- -- -I %S/Inputs/bugprone-spuriously-wake-up-functions/
#include "condition_variable.h"
#define NULL 0

struct Node1 {
  void *Node1;
  struct Node1 *next;
};

static Node1 list;
static std::mutex m;
static std::condition_variable condition;

void consume_list_element(std::condition_variable &condition) {
  std::unique_lock<std::mutex> lk(m);

  if (list.next == nullptr) {
    condition.wait(lk);
    // CHECK-MESSAGES: :[[@LINE-1]]:15: warning: 'wait' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
  }

  while (list.next == nullptr) {
    condition.wait(lk);
  }

  if (list.next == nullptr) {
    while (list.next == nullptr) {
      condition.wait(lk);
    }
  }
  using durtype = std::chrono::duration<int, std::milli>;
  durtype dur = std::chrono::duration<int, std::milli>();
  if (list.next == nullptr) {
    condition.wait_for(lk, dur);
    // CHECK-MESSAGES: :[[@LINE-1]]:15: warning: 'wait_for' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
  }
  if (list.next == nullptr) {
    condition.wait_for(lk, dur, [] { return 1; });
  }
  auto now = std::chrono::system_clock::now();
  if (list.next == nullptr) {
    condition.wait_until(lk, now);
    // CHECK-MESSAGES: :[[@LINE-1]]:15: warning: 'wait_until' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
  }
  if (list.next == nullptr) {
    condition.wait_until(lk, now, [] { return 1; });
  }
}

typedef struct mtx_t {
} mtx_t;
typedef struct cnd_t {
} cnd_t;

int cnd_wait(cnd_t *cond, mtx_t *mutex){};

struct Node1 list_c;
static mtx_t lock;
static cnd_t condition_c;

void consume_list_element(void) {

  if (list_c.next == NULL) {
    if (0 != cnd_wait(&condition_c, &lock)) {
      // CHECK-MESSAGES: :[[@LINE-1]]:14: warning: 'cnd_wait' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
    }
  }
  while (list_c.next == NULL) {
    if (0 != cnd_wait(&condition_c, &lock)) {
    }
  }
  if (list_c.next == NULL) {
    cnd_wait(&condition_c, &lock);
    // CHECK-MESSAGES: :[[@LINE-1]]:5: warning: 'cnd_wait' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
  }
  while (list.next == NULL) {
    cnd_wait(&condition_c, &lock);
  }
}
