.. title:: clang-tidy - bugprone-signal-in-multithreaded-program

bugprone-signal-in-multithreaded-program
========================================

Finds ``signal`` function calls when the program is multithreaded. It founds a
program multithreaded when it finds at least one function call of the 
following: ``thrd_create``, ``std::thread``, ``boost::thread``,
``dlib::thread_function``, ``dlib::thread_pool``,
``dlib::default_thread_pool``, ``pthread_t``.

.. code-block: c

    signal(SIGUSR1, handler);
    thrd_t tid;

This check corresponds to the CERT C++ Coding Standard rule
`CON37-C. Do not call signal() in a multithreaded program
<https://wiki.sei.cmu.edu/confluence/display/c/CON37-C.+Do+not+call+signal%28%29+in+a+multithreaded+program>`_.
