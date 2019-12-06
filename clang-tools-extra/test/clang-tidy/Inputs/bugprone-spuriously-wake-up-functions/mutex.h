namespace std {
    class mutex;
    /*
    class recursive_mutex;
    class timed_mutex;
    class recursive_timed_mutex;
 
    struct defer_lock_t { explicit defer_lock_t() = default; };
    inline constexpr defer_lock_t defer_lock { };
 
    struct try_to_lock_t { explicit try_to_lock_t() = default; };
    inline constexpr try_to_lock_t try_to_lock { };
 
    struct adopt_lock_t { explicit adopt_lock_t() = default; };
    inline constexpr adopt_lock_t adopt_lock { };
 
    template <class Mutex> class lock_guard;
    */
    template <class Mutex>
class unique_lock {
 public:
    typedef Mutex mutex_type;
 
    // construct/copy/destroy:
    unique_lock() noexcept;
    explicit unique_lock(mutex_type& m);
    /*unique_lock(mutex_type& m, defer_lock_t) noexcept;
    unique_lock(mutex_type& m, try_to_lock_t);
    unique_lock(mutex_type& m, adopt_lock_t);
    template <class Clock, class Duration>
    unique_lock(mutex_type& m, const chrono::time_point<Clock, Duration>& abs_time);
    template <class Rep, class Period>
    unique_lock(mutex_type& m, const chrono::duration<Rep, Period>& rel_time);
    ~unique_lock();
    unique_lock(unique_lock const&) = delete;
    unique_lock& operator=(unique_lock const&) = delete;
    unique_lock(unique_lock&& u) noexcept;
    unique_lock& operator=(unique_lock&& u) noexcept;
    */
 
    // locking:
    /*
    void lock();
    bool try_lock();
    template <class Rep, class Period>
    bool try_lock_for(const chrono::duration<Rep, Period>& rel_time);
    template <class Clock, class Duration>
    bool try_lock_until(const chrono::time_point<Clock, Duration>& abs_time);
    void unlock();
    */
 
    // modifiers:
    /*
    void swap(unique_lock& u) noexcept;
    mutex_type *release() noexcept;
    */
 
    // observers:
    /*
    bool owns_lock() const noexcept;
    explicit operator bool () const noexcept;
    mutex_type* mutex() const noexcept;
    */
 
 private:
    /*mutex_type *pm; // exposition only
    bool owns; // exposition only
    */
};
 /*
    template <class Mutex>
    void swap(unique_lock<Mutex>& x,
              unique_lock<Mutex>& y) noexcept;
 
    template <class L1, class L2, class... L3>
    int try_lock(L1&, L2&, L3&...);
 
    template <class L1, class L2, class... L3>
    void lock(L1&, L2&, L3&...);
 
    struct once_flag;
 
    template<class Callable, class ...Args>
    void call_once(once_flag& flag, Callable func, Args&&... args);
*/
    class mutex {
 public:
    constexpr mutex() noexcept;
    ~mutex();
    mutex(const mutex&) = delete;
    mutex& operator=(const mutex&) = delete;
 /*
    void lock();
    bool try_lock();
    void unlock();
    */
    //typedef /*implementation-defined*/ native_handle_type;
    //native_handle_type native_handle();
};
}