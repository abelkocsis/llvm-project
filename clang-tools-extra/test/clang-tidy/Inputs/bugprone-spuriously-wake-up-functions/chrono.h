namespace std {
  namespace chrono {
    // class template duration
    template <class Rep, class Period = ratio<1>>
class duration {
public:
  using rep = Rep;
  using period = Period;
private:
  rep rep_; // exposition only
public:
  // construct/copy/destroy
  constexpr duration() = default;
  template <class Rep2>
  constexpr explicit duration(const Rep2& r);
  template <class Rep2, class Period2>
  constexpr duration(const duration<Rep2, Period2>& d);
  ~duration() = default;
  duration(const duration&) = default;
  //duration& operator=(const duration&) = default;
  // observer
  //constexpr rep count() const;
  // arithmetic
  /*
  constexpr duration operator+() const;
  constexpr duration operator-() const;
  constexpr duration& operator++();
  constexpr duration operator++(int);
  constexpr duration& operator--();
  constexpr duration operator--(int);
  constexpr duration& operator+=(const duration& d);
  constexpr duration& operator-=(const duration& d);
  constexpr duration& operator*=(const rep& rhs);
  constexpr duration& operator/=(const rep& rhs);
  constexpr duration& operator%=(const rep& rhs);
  constexpr duration& operator%=(const duration& rhs);
  */
  // special values
  /*
  static constexpr duration zero();
  static constexpr duration min();
  static constexpr duration max();
  */
};
    // class template time_point
    template <class Clock, class Duration = typename Clock::duration>
class time_point {
public:
  using clock = Clock;
  using duration = Duration;
  //using rep = typename duration::rep;
  //using period = typename duration::period;
private:
  //duration d_; // exposition only
public:
  // construct
  constexpr time_point(); // has value epoch
  constexpr explicit time_point(const duration& d); // same as time_point() + d
  template <class Duration2>
  constexpr time_point(const time_point<clock, Duration2>& t);
  // observer
  //constexpr duration time_since_epoch() const;
  // arithmetic
  //constexpr time_point& operator+=(const duration& d);
  //constexpr time_point& operator-=(const duration& d);
  // special values
  //static constexpr time_point min();
  //static constexpr time_point max();
};
  }
  // common_type specializations
  /*
  template <class Rep1, class Period1, class Rep2, class Period2>
  struct common_type<chrono::duration<Rep1, Period1>,
                     chrono::duration<Rep2, Period2>>;
  template <class Clock, class Duration1, class Duration2>
  struct common_type<chrono::time_point<Clock, Duration1>,
                     chrono::time_point<Clock, Duration2>>;
  */                   
  namespace chrono {
    // customization traits
    /*
    template <class Rep> struct treat_as_floating_point;
    template <class Rep> struct duration_values;
    template <class Rep>
    constexpr bool treat_as_floating_point_v = treat_as_floating_point<Rep>::value;
    */
    // duration arithmetic
    /*
    template <class Rep1, class Period1, class Rep2, class Period2>
    common_type_t<duration<Rep1, Period1>, duration<Rep2, Period2>>
    constexpr operator+(const duration<Rep1, Period1>& lhs,
                        const duration<Rep2, Period2>& rhs);
    */                    
    /*
    template <class Rep1, class Period1, class Rep2, class Period2>
    common_type_t<duration<Rep1, Period1>, duration<Rep2, Period2>>
    constexpr operator-(const duration<Rep1, Period1>& lhs,
                        const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period, class Rep2>
    duration<common_type_t<Rep1, Rep2>, Period>
    constexpr operator*(const duration<Rep1, Period>& d,
                        const Rep2& s);
    template <class Rep1, class Rep2, class Period>
    duration<common_type_t<Rep1, Rep2>, Period>
    constexpr operator*(const Rep1& s,
                        const duration<Rep2, Period>& d);
    template <class Rep1, class Period, class Rep2>
    duration<common_type_t<Rep1, Rep2>, Period>
    constexpr operator/(const duration<Rep1, Period>& d,
                        const Rep2& s);
    template <class Rep1, class Period1, class Rep2, class Period2>
    common_type_t<Rep1, Rep2>
    constexpr operator/(const duration<Rep1, Period1>& lhs,
                        const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period, class Rep2>
    duration<common_type_t<Rep1, Rep2>, Period>
    constexpr operator%(const duration<Rep1, Period>& d,
                        const Rep2& s);
    template <class Rep1, class Period1, class Rep2, class Period2>
    common_type_t<duration<Rep1, Period1>, duration<Rep2, Period2>>
    constexpr operator%(const duration<Rep1, Period1>& lhs,
                        const duration<Rep2, Period2>& rhs);
    */
    // duration comparisons
    /*
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator==(const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator!=(const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator< (const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator<=(const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator> (const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    template <class Rep1, class Period1, class Rep2, class Period2>
    constexpr bool operator>=(const duration<Rep1, Period1>& lhs,
                              const duration<Rep2, Period2>& rhs);
    */
    // duration_cast
/*
    template <class ToDuration, class Rep, class Period>
    constexpr ToDuration duration_cast(const duration<Rep, Period>& d);
    template <class ToDuration, class Rep, class Period>
    constexpr ToDuration floor(const duration<Rep, Period>& d);
    template <class ToDuration, class Rep, class Period>
    constexpr ToDuration ceil(const duration<Rep, Period>& d);
    template <class ToDuration, class Rep, class Period>
    constexpr ToDuration round(const duration<Rep, Period>& d);
    */
    // convenience typedefs
    
    //using nanoseconds = duration</*signed integer type of at least 64 bits*/ , nano>;
    //using microseconds = duration</*signed integer type of at least 55 bits*/ , micro>;
    using milliseconds = duration<int , milli>;
    //using seconds = duration</*signed integer type of at least 35 bits*/ >;
    //using minutes = duration</*signed integer type of at least 29 bits*/ , ratio< 60>>;
    //using hours = duration</*signed integer type of at least 23 bits*/ , ratio<3600>>;
    
    // time_point arithmetic
    /*
    template <class Clock, class Duration1, class Rep2, class Period2>
    constexpr time_point<Clock, common_type_t<Duration1, duration<Rep2, Period2>>>
    operator+(const time_point<Clock, Duration1>& lhs,
              const duration<Rep2, Period2>& rhs);
    
    template <class Rep1, class Period1, class Clock, class Duration2>
    constexpr time_point<Clock, common_type_t<duration<Rep1, Period1>, Duration2>>
    operator+(const duration<Rep1, Period1>& lhs,
              const time_point<Clock, Duration2>& rhs);
    */
    /*
    template <class Clock, class Duration1, class Rep2, class Period2>
    constexpr time_point<Clock, common_type_t<Duration1, duration<Rep2, Period2>>>
    operator-(const time_point<Clock, Duration1>& lhs,
              const duration<Rep2, Period2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr common_type_t<Duration1, Duration2>
    operator-(const time_point<Clock, Duration1>& lhs,
              const time_point<Clock, Duration2>& rhs);
    */
    // time_point comparisons
    /*
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator==(const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator!=(const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator< (const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator<=(const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator> (const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    template <class Clock, class Duration1, class Duration2>
    constexpr bool operator>=(const time_point<Clock, Duration1>& lhs,
                              const time_point<Clock, Duration2>& rhs);
    */
    // time_point_cast
    /*
    template <class ToDuration, class Clock, class Duration>
    constexpr time_point<Clock, ToDuration>
    time_point_cast(const time_point<Clock, Duration>& t);
    template <class ToDuration, class Clock, class Duration>
    constexpr time_point<Clock, ToDuration>
    floor(const time_point<Clock, Duration>& tp);
    template <class ToDuration, class Clock, class Duration>
    constexpr time_point<Clock, ToDuration>
    ceil(const time_point<Clock, Duration>& tp);
    template <class ToDuration, class Clock, class Duration>
    constexpr time_point<Clock, ToDuration>
    round(const time_point<Clock, Duration>& tp);
    // specialized algorithms
    template <class Rep, class Period>
    constexpr duration<Rep, Period> abs(duration<Rep, Period> d);
    // clocks
    */
    class system_clock {
public:
  typedef milliseconds                     duration;
    typedef duration::rep                    rep;
    typedef duration::period                 period;
    typedef chrono::time_point<system_clock> time_point;
  //using duration = chrono::duration<rep, period>;
  //using time_point = chrono::time_point<system_clock>;
  //static constexpr bool is_steady = /*unspecified*/ ;
  static time_point now() noexcept;
  // Map to C API
  //static time_t to_time_t (const time_point& t) noexcept;
  //static time_point from_time_t(time_t t) noexcept;
};
    /*
    class steady_clock;
    class high_resolution_clock;
    */
  }


}