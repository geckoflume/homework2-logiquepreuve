#include <stdlib.h>
#include <stdio.h>

int palindrome_iter(const char *w, int n) {
  int i = 0;

  while (i < n && w[i] == w[n-i-1]) {
    i++;
  }

  if (i < n) {
    return 0;
  } else {
    return 1;
  }
}

int palindrome_rec(const char *w, int i, int j) {
  if (i >= j) {
    return 1;
  } else if (w[i] != w[j]) {
    return 0;
  } else {
    return palindrome_rec(w, i + 1, j - 1);
  }
}

int palindrome_iter2(const char *w, int n) {
  int i = 0;
  int palindrome = 1;

  while (i < n && palindrome) {
    if (w[i] != w[n-1-i]) {
      palindrome = 0;
    } else {
      i++;
    }
  }

  return palindrome;
}

int main(int argc, char const *argv[]) {
  /* Init and parse args */
  if (argc != 4) {
    printf("Usage : %s <word> <lower pos in word> <upper pos in word>\n", argv[0]);
    return 1;
  }
  const char *w = argv[1];
  int lower = atoi(argv[2]);
  int upper = atoi(argv[3]);

  /* Run */
  int ret_it = palindrome_iter(w, upper);
  int ret_rec = palindrome_rec(w, lower, upper-1);
  int ret_it2 = palindrome_iter2(w, upper);

  printf("palindrome_iter : %s\n", (ret_it == 1) ? "true": "false");
  printf("palindrome_rec : %s\n", (ret_rec == 1) ? "true": "false");
  printf("palindrome_iter2 : %s\n", (ret_it2   == 1) ? "true": "false");

  return 0;
}
