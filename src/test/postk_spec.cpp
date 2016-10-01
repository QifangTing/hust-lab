/*!
 * \file postk_spec.cpp
 * \brief test file for postk struct
 *
 * \author sabertazimi, <sabertazimi@gmail.com>
 * \version 1.0
 * \date 2016-09-30
 */

#include <iostream>
#include <cstdlib>
#include "spec.h"
#include "postk.h"  // added include/ path into g++ flag

using namespace std;

/* functions to test */

extern void initPOSTK(POSTK *const p, int m);
extern void initPOSTK(POSTK *const p, const POSTK &s);
extern int size(const POSTK *const p);
extern int howMany(const POSTK *const p);
extern int getelem(const POSTK *const p, int x);
extern POSTK *const push(POSTK *const p, int e);
extern POSTK *const pop(POSTK *const p, int &e);
extern POSTK *const assign(POSTK *const p, const POSTK &s);
extern void print(const POSTK *const p);
extern void destroyPOSTK(POSTK *const p);

/* functions to test */

int postk_spec(void) {

    POSTK *p = NULL;

    int *elems = (int *)malloc(sizeof(int) * 5);
    elems[0] = 0;
    elems[1] = 1;
    elems[2] = 2;
    POSTK s = {
        elems,
        5,
        3
    };

    int elem = 0;

    /* NULL pointer test */

    initPOSTK(p, 0);
    ASSERT("initPOSTK", p == NULL, "when p is null, initPOSTK(p, 0) should keep p NULL");
    initPOSTK(p, s);
    ASSERT("initPOSTK", p == NULL, "when p is null, initPOSTK(p, s) should keep p NULL");
    ASSERT("size", size(p) == 0, "when p is null, size(p) should return 0");
    ASSERT("howMany", howMany(p) == 0, "when p is null, howMany(p) should return 0");
    ASSERT("getelem", getelem(p, 1) == 0, "when p is null, getelem(p, 1) should return 0");
    ASSERT("push", push(p, 3) == NULL && p == NULL, "when p is null, push(p, 3) should keep p NULL and return NULL");
    ASSERT("pop", pop(p, elem) == NULL && p == NULL && elem == 0, "when p is null, pop(p, elem) should keep p NULL, keep elem 0 and return NULL");
    ASSERT("assign", assign(p, s) == NULL && p == NULL, "when p is null, assign(p, s) should keep p NULL and return NULL");
    print(p);
    ASSERT("print", p == NULL, "when p is null, print(p) should do nothing but keep p NULL");
    destroyPOSTK(p);
    ASSERT("destroyPOSTK", p == NULL, "when p is null, destroyPOSTK(p) should do nothing but keep p NULL");

    /* NULL pointer test */

    return 1;
}
