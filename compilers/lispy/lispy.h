/*
 * lispy.h
 * Copyright (C) 2016 sabertazimi <sabertazimi@gmail.com>
 *
 * Distributed under terms of the MIT license.
 */

#ifndef LISPY_H
#define LISPY_H

#include "mpc.h"

#define LASSERT(args, cond, fmt, ...)                   \
    do {                                                \
        if (!(cond)) {                                  \
            lval *err = lval_err(fmt, ##__VA_ARGS__);   \
            lval_del(args);                             \
            return err;                                 \
        }                                               \
    } while (0)                                         \

struct lval;
struct lenv;
typedef struct lval lval;
typedef struct lenv lenv;

enum {
    LVAL_ERR,
    LVAL_NUM,
    LVAL_SYM,
    LVAL_FUN,
    LVAL_SEXPR,
    LVAL_QEXPR
};

/* Function pointer */
typedef lval*(*lbuiltin)(lenv *, lval*);

struct lval {
    int type;

    /* Basic */
    long num;
    char *err;
    char *sym;

    /* Function */
    lbuiltin builtin;
    lenv *env;
    lval *formals;
    lval *body;

    /* Expression */
    int count;
    lval **cell;
};

struct lenv {
    lenv *par;
    int count;
    char **syms;
    lval **vals;
};

char *ltype_name(int t);

/* Contruct new lval node */
lval *lval_err(char *fmt, ...);
lval *lval_num(long x);
lval *lval_sym(char *s);
lval *lval_fun(lbuiltin func);
lval *lval_sexpr(void);
lval *lval_qexpr(void);
lval *lval_lambda(lval *formals, lval *body);

/* Basic operator for lval list */
void lval_del(lval *v);
lval *lval_add(lval *v, lval *x);
lval *lval_pop(lval *v, int i);
lval *lval_join(lval *x, lval *y);
lval *lval_take(lval *v, int i);
lval *lval_copy(lval *v);

/* Environment functions */
lenv *lenv_new(void);
void lenv_del(lenv *e);
lval *lenv_get(lenv *e, lval *k);
void lenv_def(lenv *e, lval *k, lval *v);
void lenv_put(lenv *e, lval *k, lval *v);
lenv *lenv_copy(lenv *e);
void lenv_add_builtin(lenv *e, char *name, lbuiltin func);
void lenv_add_builtins(lenv *e);

/* Read info from AST generated by mpc, then construct lval_list */
lval *lval_read_num(mpc_ast_t *t);
lval *lval_read(mpc_ast_t *t);

/* Built in functions */
lval *builtin_list(lenv *e, lval *a);
lval *builtin_head(lenv *e, lval *a);
lval *builtin_tail(lenv *e, lval *a);
lval *builtin_eval(lenv *e, lval *a);
lval *builtin_join(lenv *e, lval *a);
lval *builtin_cons(lenv *e, lval *a);
lval *builtin_len(lenv *e, lval *a);
lval *builtin_init(lenv *e, lval *a);
lval *builtin_last(lenv *e, lval *a);
lval *builtin_add(lenv *e, lval *a);
lval *builtin_sub(lenv *e, lval *a);
lval *builtin_mul(lenv *e, lval *a);
lval *builtin_div(lenv *e, lval *a);
lval *builtin_lambda(lenv *e, lval *a);
lval *builtin_def(lenv *e, lval *a);
lval *builtin_put(lenv *e, lval *a);

/* Evaluation Functions */
lval *lval_call(lenv *e, lval *f, lval *a);
lval *lval_eval_sexpr(lenv *e, lval *v);
lval *lval_eval(lenv *e, lval *v);

/* Screen display functions */
void lval_print(lval *v);
void lval_expr_print(lval *v, char open, char close);
void lval_println(lval *v);

#endif /* !LISPY_H */
