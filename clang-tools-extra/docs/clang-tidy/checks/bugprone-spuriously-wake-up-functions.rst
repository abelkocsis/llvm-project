.. title:: clang-tidy - bugprone-spuriously-wake-up-functions

bugprone-spuriously-wake-up-functions
=================================

Finds ``cnd_wait`` or ``wait`` function calls in an ``IfStmt`` and tries to 
replace it with ``WhileStmt``.

.. code-block: c++

    if (condition_predicate) {
        condition.wait(lk);
    }

.. code-block: c

    if (condition_predicate) {
        if (thrd_success != cnd_wait(&condition, &lock)) {
        }
    }

This check corresponds to the CERT C++ Coding Standard rule
`CON54-CPP. Wrap functions that can spuriously wake up in a loop
<https://wiki.sei.cmu.edu/confluence/display/cplusplus/CON54-CPP.+Wrap+functions+that+can+spuriously+wake+up+in+a+loop>`_.
and CERT C Coding Standard rule
`CON36-C. Wrap functions that can spuriously wake up in a loop
<https://wiki.sei.cmu.edu/confluence/display/c/CON36-C.+Wrap+functions+that+can+spuriously+wake+up+in+a+loop>`_.
