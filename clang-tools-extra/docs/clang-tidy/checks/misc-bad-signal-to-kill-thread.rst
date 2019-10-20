.. title:: clang-tidy - misc-bad-signal-to-kill-thread

misc-bad-signal-to-kill-thread
==============================

Finds ``pthread_kill`` function calls when thread is terminated by uncaught
``SIGTERM`` signal and the signal kills the entire process, not just the
individual thread. Use any signal except ``SIGTERM`` or ``SIGKILL``.
To learn more about this rule please visit the following page:
https://wiki.sei.cmu.edu/confluence/display/c/POS44-C.+Do+not+use+signals+to+terminate+threads

.. code-block: c++

    pthread_kill(thread, SIGTERM);
