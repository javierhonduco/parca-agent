int __attribute__((noinline)) top1() {
  for (int i = 0; i < 1000; i++) {
  }

  return 0;
}

int __attribute__((noinline)) top2() {

  for (int i = 0; i < 1000; i++) {
  }

  return 0;
}

// ones
int __attribute__((noinline)) c1() { return top1(); }

int __attribute__((noinline)) b1() { return c1(); }

int __attribute__((noinline)) a1() { return b1(); }

// twos
int __attribute__((noinline)) c2() { return top2(); }

int __attribute__((noinline)) b2() { return c2(); }

int __attribute__((noinline)) a2() { return b2(); }

int do_stuff() {
  while (true) {
    a1();
    a2();
  }
  return 0;
}