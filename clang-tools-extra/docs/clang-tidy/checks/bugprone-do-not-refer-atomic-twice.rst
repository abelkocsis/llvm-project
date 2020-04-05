.. title:: clang-tidy - bugprone-do-not-refer-atomic-twice

bugprone-do-not-refer-atomic-twice
==================================

Finds atomic variable which is referred twice in an expression.

.. code-block:: c

    atomic_int n = ATOMIC_VAR_INIT(0);
    int compute_sum(void) {
        return n * (n + 1) / 2;
    }

This check corresponds to the CERT C Coding Standard rule
`CON40-C. Do not refer to an atomic variable twice in an expression
<https://wiki.sei.cmu.edu/confluence/display/c/CON40-C.+Do+not+refer+to+an+atomic+variable+twice+in+an+expression>`_.
