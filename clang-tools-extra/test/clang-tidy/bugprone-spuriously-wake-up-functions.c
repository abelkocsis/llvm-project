// RUN: %check_clang_tidy %s bugprone-spuriously-wake-up-functions %t -- -- -I %S/Inputs/bugprone-spuriously-wake-up-functions/ -std=c11
//#include <threads.h>
#define NULL 0

struct node_t {
  void *node;
  struct node_t *next;
};

typedef struct mtx_t {} mtx_t;
typedef struct cnd_t {} cnd_t;

struct node_t list;
static mtx_t lock;
static cnd_t condition;
  
void consume_list_element(void) {
  
  if (list.next == NULL) {
    if (0 != cnd_wait(&condition, &lock)) {
      // CHECK-MESSAGES: :[[@LINE-1]]:14: warning: 'cnd_wait' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
    }
  }
  if (list.next == NULL) {
      cnd_wait(&condition, &lock);
      // CHECK-MESSAGES: :[[@LINE-1]]:14: warning: 'cnd_wait' should be placed inside a while statement or used with a condition parameter [bugprone-spuriously-wake-up-functions]
    }
  
  while (list.next == NULL) {
    if (0 != cnd_wait(&condition, &lock)) {
    }
  }
  while (list.next == NULL) {
     cnd_wait(&condition, &lock);
  }
}