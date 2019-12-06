#include "ratio.h"

namespace std {
namespace chrono {

template <class Rep, class Period = ratio<1>>
class duration {
public:
  using rep = Rep;
  using period = Period;

public:
  constexpr duration() = default;
  template <class Rep2>
  constexpr explicit duration(const Rep2 &r);
  template <class Rep2, class Period2>
  constexpr duration(const duration<Rep2, Period2> &d);
  ~duration() = default;
  duration(const duration &) = default;
};

template <class Clock, class Duration = typename Clock::duration>
class time_point {
public:
  using clock = Clock;
  using duration = Duration;

public:
  constexpr time_point();
  constexpr explicit time_point(const duration &d);
  template <class Duration2>
  constexpr time_point(const time_point<clock, Duration2> &t);
};

using milliseconds = duration<int, milli>;

class system_clock {
public:
  typedef milliseconds duration;
  typedef duration::rep rep;
  typedef duration::period period;
  typedef chrono::time_point<system_clock> time_point;

  static time_point now() noexcept;
};
} // namespace chrono

} // namespace std