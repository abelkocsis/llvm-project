.. title:: clang-tidy - misc-bad-signal-to-kill-thread

misc-bad-signal-to-kill-thread
==============================

Warn on uses of the ``pthread_kill`` function when thread is 
terminated by ``SIGTERM`` signal.
.. code-block: c++

    pthread_kill(thread, SIGTERM);