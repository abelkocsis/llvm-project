namespace std {
class mutex;
template <class Mutex>
class unique_lock {
public:
  typedef Mutex mutex_type;

  unique_lock() noexcept;
  explicit unique_lock(mutex_type &m);
};

class mutex {
public:
  constexpr mutex() noexcept;
  ~mutex();
  mutex(const mutex &) = delete;
  mutex &operator=(const mutex &) = delete;
};
} // namespace std