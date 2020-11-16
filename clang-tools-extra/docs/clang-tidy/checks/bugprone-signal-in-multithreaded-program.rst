.. title:: clang-tidy - bugprone-signal-in-multithreaded-program

bugprone-signal-in-multithreaded-program
========================================

Finds ``signal`` function calls when the program is multithreaded. The
check considers the analyzed program multithreaded if it finds at least
one function call of the following: ``thrd_create``, ``std::thread``, 
``boost::thread``, ``pthread_t``, ``CreateThread``, ``CreateRemoteThread``,
``_beginthread``, ``_beginthreadex`` or a user-defined function added as a
parameter.

.. code-block:: c

    signal(SIGUSR1, handler);
    thrd_t tid;

This check corresponds to the CERT C++ Coding Standard rule
`CON37-C. Do not call signal() in a multithreaded program
<https://wiki.sei.cmu.edu/confluence/display/c/CON37-C.+Do+not+call+signal%28%29+in+a+multithreaded+program>`_.

Options
-------

.. option:: ThreadList

   Semicolon-separated list of fully qualified names of thread call functions.
   Defaults to ``thrd_create;::thread;boost::thread;pthread_t``.
