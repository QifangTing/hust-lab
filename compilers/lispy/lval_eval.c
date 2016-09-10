/*
 * lval_eval.c
 * Copyright (C) 2016 sabertazimi <sabertazimi@gmail.com>
 *
 * Distributed under terms of the MIT license.
 */

#include "lispy.h"


lval *builtin_list(lenv *e, lval *a) {
    a->type = LVAL_QEXPR;
    return a;
}

lval *builtin_head(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'head' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'head' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[0]->count != 0,
        "Function 'head' passed {}.");

    lval *v = lval_take(a, 0);

    while (v->count > 1) {
        lval_del(lval_pop(v, 1));
    }

    return v;
}

lval *builtin_tail(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'tail' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'tail' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[0]->count != 0,
        "Function 'tail' passed {}.");

    lval *v = lval_take(a, 0);
    lval_del(lval_pop(v, 0));
    return v;
}

lval *builtin_eval(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'eval' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'eval' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));

    lval *x = lval_take(a, 0);
    x->type = LVAL_SEXPR;
    return lval_eval(e, x);
}

lval *builtin_join(lenv *e, lval *a) {
    for (int i = 0; i < a->count; i++) {
        LASSERT(a, a->cell[i]->type == LVAL_QEXPR,
            "Function 'join' passed incorrect type for argument %i: "
            "Got %s, Expected %s.",
            i, ltype_name(a->cell[i]->type), ltype_name(LVAL_QEXPR));
    }

    lval *x = lval_pop(a, 0);

    while (a->count) {
        lval *y = lval_pop(a, 0);
        x = lval_join(x, y);
    }

    lval_del(a);
    return x;
}

lval *builtin_cons(lenv *e, lval *a) {
    LASSERT(a, a->count == 2,
        "Function 'cons' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 2);
    LASSERT(a, a->cell[0]->type == LVAL_NUM,
        "Function 'cons' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_NUM));
    LASSERT(a, a->cell[1]->type == LVAL_QEXPR,
        "Function 'cons' passed incorrect type for argument 1: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[1]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[1]->count != 0,
        "Function 'cons' passed {}.");

    lval *v = lval_pop(a, 0);
    lval *x = lval_qexpr();

    x = lval_add(x, v);
    x = lval_join(x, lval_pop(a, 0));

    lval_del(a);
    lval_del(v);
    return x;
}

lval *builtin_len(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'len' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'len' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));

    lval *v = lval_pop(a, 0);
    lval *x = lval_num(v->count);

    lval_del(a);
    lval_del(v);
    return x;
}

lval *builtin_init(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'init' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'init' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[0]->count != 0,
        "Function 'init' passed {}.");

    lval *x = lval_pop(a, 0);
    lval_del(lval_pop(x, x->count - 1));

    return x;
}

lval *builtin_last(lenv *e, lval *a) {
    LASSERT(a, a->count == 1,
        "Function 'last' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 1);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'last' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[0]->count != 0,
        "Function 'last' passed {}.");

    lval *v = lval_pop(a, 0);
    lval *x = lval_pop(v, v->count - 1);

    lval_del(a);
    lval_del(v);
    return x;
}

static lval *builtin_op(lenv *e, lval *a, char *op) {
    for (int i = 0; i < a->count; i++) {
        if (a->cell[i]->type != LVAL_NUM) {
            int type = a->cell[i]->type;
            lval_del(a);
            return lval_err("Function '%s' passed incorrect type for argument %i: "
                    "Got %s, Expected %s.",
                    op, i, ltype_name(type), ltype_name(LVAL_NUM));
        }
    }

    lval *x = lval_pop(a, 0);

    if ((strcmp(op, "-") == 0) && a->count == 0) {
        x->num = -x->num;
    }

    while (a->count > 0) {
        lval *y = lval_pop(a, 0);

        if (strcmp(op, "+") == 0) {
            x->num += y->num;
        }
        if (strcmp(op, "-") == 0) {
            x->num -= y->num;
        }
        if (strcmp(op, "*") == 0) {
            x->num *= y->num;
        }
        if (strcmp(op, "/") == 0) {
            if (y->num == 0) {
                lval_del(x);
                lval_del(y);
                x = lval_err("Division By Zero.");
                break;
            }

            x->num /= y->num;
        }

        lval_del(y);
    }

    lval_del(a);
    return x;
}

lval *builtin_add(lenv *e, lval *a) {
    return builtin_op(e, a, "+");
}

lval *builtin_sub(lenv *e, lval *a) {
    return builtin_op(e, a, "-");
}

lval *builtin_mul(lenv *e, lval *a) {
    return builtin_op(e, a, "*");
}

lval *builtin_div(lenv *e, lval *a) {
    return builtin_op(e, a, "/");
}

lval *builtin_lambda(lenv *e, lval *a) {
    LASSERT(a, a->count == 2,
        "Function '\\' passed too many arguments: "
        "Got %i, Expected %i.",
        a->count, 2);
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function '\\' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));
    LASSERT(a, a->cell[1]->type == LVAL_QEXPR,
        "Function '\\' passed incorrect type for argument 1: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[1]->type), ltype_name(LVAL_QEXPR));

    for (int i = 0; i < a->cell[0]->count; i++) {
        LASSERT(a, a->cell[0]->cell[i]->type == LVAL_SYM,
            "Cannot define non-symbol: "
            "Got %s, Expected %s.",
            ltype_name(a->cell[0]->cell[i]->type), ltype_name(LVAL_SYM));
    }

    lval *formals = lval_pop(a, 0);
    lval *body = lval_pop(a, 0);
    lval_del(a);

    return lval_lambda(formals, body);
}

static lval *builtin_var(lenv *e, lval *a, char *func) {
    LASSERT(a, a->cell[0]->type == LVAL_QEXPR,
        "Function 'def' passed incorrect type for argument 0: "
        "Got %s, Expected %s.",
        ltype_name(a->cell[0]->type), ltype_name(LVAL_QEXPR));

    lval *syms = a->cell[0];

    for (int i = 0; i < syms->count; i++) {
        LASSERT(a, syms->cell[i]->type == LVAL_SYM,
            "Function 'def' cannot define non-symbol: "
            "Got %s, Expected %s.",
            ltype_name(a->cell[i]->type), ltype_name(LVAL_SYM));
    }

    LASSERT(a, syms->count == a->count - 1,
        "Function 'def' cannot define incorrect number of values to symbols: "
        "Got %i, Expected %i.",
        a->count - 1, syms->count);

    for (int i = 0; i < syms->count; i++) {
        if (strcmp(func, "def") == 0) {
            lenv_def(e, syms->cell[i], a->cell[i + 1]);
        }
        if (strcmp(func, "=") == 0) {
            lenv_put(e, syms->cell[i], a->cell[i + 1]);
        }
    }

    lval_del(a);
    return lval_sexpr();
}

lval *builtin_def(lenv *e, lval *a) {
    return builtin_var(e, a, "def");
}

lval *builtin_put(lenv *e, lval *a) {
    return builtin_var(e, a, "=");
}

void lenv_add_builtin(lenv *e, char *name, lbuiltin func) {
    lval *k = lval_sym(name);
    lval *v = lval_fun(func);
    lenv_put(e, k, v);
    lval_del(k);
    lval_del(v);
}

void lenv_add_builtins(lenv *e) {
    lenv_add_builtin(e, "list", builtin_list);
    lenv_add_builtin(e, "head", builtin_head);
    lenv_add_builtin(e, "tail", builtin_tail);
    lenv_add_builtin(e, "eval", builtin_eval);
    lenv_add_builtin(e, "join", builtin_join);
    lenv_add_builtin(e, "cons", builtin_cons);
    lenv_add_builtin(e, "len", builtin_len);
    lenv_add_builtin(e, "init", builtin_init);
    lenv_add_builtin(e, "last", builtin_last);
    lenv_add_builtin(e, "+", builtin_add);
    lenv_add_builtin(e, "-", builtin_sub);
    lenv_add_builtin(e, "*", builtin_mul);
    lenv_add_builtin(e, "/", builtin_div);
    lenv_add_builtin(e, "\\", builtin_lambda);
    lenv_add_builtin(e, "def", builtin_def);
    lenv_add_builtin(e, "=", builtin_put);
}

lval *lval_call(lenv *e, lval *f, lval *a) {
    if (f->builtin) {
        return f->builtin(e, a);
    }

    int given = a->count;
    int total = f->formals->count;

    while (a->count) {
        if (f->formals->count == 0) {
            lval_del(a);
            return lval_err(
                    "Function passed too many arguments: "
                    "Got %i, Expected %i",
                    given, total);
        }

        lval *sym = lval_pop(f->formals, 0);

        if (strcmp(sym->sym, "&") == 0) {
            if (f->formals->count != 1) {
                lval_del(a);
                return lval_err(
                        "Function format invalid. "
                        "Symbol '&' not followed by single symbol.");
            }

            lval *nsym = lval_pop(f->formals, 0);
            lenv_put(f->env, nsym, builtin_list(e, a));
            lval_del(sym);
            lval_del(nsym);
            break;
        }

        lval *val = lval_pop(a, 0);

        lenv_put(f->env, sym, val);

        lval_del(sym);
        lval_del(val);
    }

    lval_del(a);

    // all arguments have been injected into f->env
    if (f->formals->count > 0 &&
        strcmp(f->formals->cell[0]->sym, "&") == 0) {
        if (f->formals->count != 2) {
            return lval_err(
                    "Function format invalid. "
                    "Symbol '&' not followed by single symbol.");
        }

        /* Pop and delete '&' symbol */
        lval_del(lval_pop(f->formals, 0));

        lval *sym = lval_pop(f->formals, 0);
        lval *val = lval_qexpr();

        lenv_put(f->env, sym, val);

        lval_del(sym);
        lval_del(val);
    }

    if (f->formals->count == 0) {
        f->env->par = e;
        return builtin_eval(f->env, lval_add(lval_sexpr(), lval_copy(f->body)));
    } else {
        return lval_copy(f);
    }
}

lval *lval_eval_sexpr(lenv *e, lval *v) {
    for (int i = 0; i < v->count; i++) {
        v->cell[i] = lval_eval(e, v->cell[i]);
    }

    for (int i = 0; i < v->count; i++) {
        if (v->cell[i]->type == LVAL_ERR) {
            return lval_take(v, i);
        }
    }

    if (v->count == 0) {
        return v;
    }
    if (v->count == 1) {
        return lval_take(v, 0);
    }

    lval *f = lval_pop(v, 0);

    if (f->type != LVAL_FUN) {
        lval* err = lval_err(
            "S-Expression starts with incorrect type. "
            "Got %s, Expected %s.",
            ltype_name(f->type), ltype_name(LVAL_FUN));

        lval_del(f);
        lval_del(v);
        return err;
    }

    lval *result = lval_call(e, f, v);
    lval_del(f);
    return result;
}

lval *lval_eval(lenv *e, lval *v) {
    if (v->type == LVAL_SYM) {
        lval *x = lenv_get(e, v);
        lval_del(v);
        return x;
    }
    if (v->type == LVAL_SEXPR) {
        return lval_eval_sexpr(e, v);
    }

    return v;
}
