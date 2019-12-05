// RUN: %check_clang_tidy %s bugprone-spuriously-wake-up-functions %t -- -- -I %S/../../../libcxx/include/

#include "chrono"
#include "condition_variable"
#include "mutex"

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
    condition.wait_until(lk, now + dur);
    // CHECK-MESSAGES: :[[@LINE-1]]:15: warning: 'wait_until' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
  }
  if (list.next == nullptr) {
    condition.wait_until(lk, now + dur, [] { return 1; });
  }
}
