// RUN: %check_clang_tidy %s bugprone-do-not-refer-atomic-twice %t
#define _Bool bool
typedef _Atomic _Bool atomic_bool;
typedef _Atomic int atomic_int;
#define offsetof(type, member) 0

namespace std {
template <class T>
struct atomic {
  atomic(T t) {}
  T operator=(const T t) { return t; }
  T operator+(const T t) { return t; }
  T operator*(const T t) { return t; }
  void operator+=(const T t) {}
  T operator++(const T t) { return t; }
  operator T() const { return 0; }
};
} // namespace std

atomic_bool b = false;
atomic_int n = 0;
_Atomic int n2 = 0;
_Atomic(int) n3 = 0;
std::atomic<int> n4(0);

struct S {
  atomic_bool b;
  atomic_int n;
  _Atomic int n2;
  _Atomic(int) n3;
  std::atomic<int> n4();
};

void warn1() {
  n = (n + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:8: warning: Do not refer to atomic variable 'n' twice in an expression [bugprone-do-not-refer-atomic-twice]
  n2 = (n2 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:9: warning: Do not refer to atomic variable 'n2' twice in an expression [bugprone-do-not-refer-atomic-twice]
  n3 = (n3 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:9: warning: Do not refer to atomic variable 'n3' twice in an expression [bugprone-do-not-refer-atomic-twice]
  n4 = (n4 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:9: warning: Do not refer to atomic variable 'n4' twice in an expression [bugprone-do-not-refer-atomic-twice]
  b = b && true;
  // CHECK-MESSAGES: :[[@LINE-1]]:7: warning: Do not refer to atomic variable 'b' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

int warn2_1() {
  return n * (n + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:15: warning: Do not refer to atomic variable 'n' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

int warn2_2() {
  return n2 * (n2 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:16: warning: Do not refer to atomic variable 'n2' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

int warn2_3() {
  return n3 * (n3 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:16: warning: Do not refer to atomic variable 'n3' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

int warn2_4() {
  return n4 * (n4 + 1) / 2;
  // CHECK-MESSAGES: :[[@LINE-1]]:16: warning: Do not refer to atomic variable 'n4' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

int warn2_5() {
  return (b && true) || b;
  // CHECK-MESSAGES: :[[@LINE-1]]:25: warning: Do not refer to atomic variable 'b' twice in an expression [bugprone-do-not-refer-atomic-twice]
}

void good1() {
  n = 12;
  n2 = 12;
  n3 = 12;
  n4 = 12;
  b = true;
}

int good2_1() {
  return n;
}

int good2_2() {
  return n2;
}

int good2_3() {
  return n3;
}

int good2_4() {
  return n4;
}

bool good2_5() {
  return b;
}

void good3() {
  n += 12;
  n2 += 12;
  n3 += 12;
  n4 += 12;
  b ^= 1;
}

void good4() {
  n++;
  n2++;
  n3++;
  n4++;
}

void good5() {
  int a = sizeof(atomic_int);
  int a2 = sizeof(_Atomic int);
  int a3 = sizeof(_Atomic(int));
  int a4 = sizeof(std::atomic<int>);
  int a5 = sizeof(atomic_bool);
}

void good6() {
  int a = offsetof(S, b);
  int a2 = offsetof(S, n);
  int a3 = offsetof(S, n2);
  int a4 = offsetof(S, n3);
  int a5 = offsetof(S, n4);
}
