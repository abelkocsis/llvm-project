#include "cstdint.h"

namespace std {

template <intmax_t N, intmax_t D = 1>
class ratio {
public:
  static constexpr intmax_t num = 0;
  static constexpr intmax_t den = 0;
  typedef ratio<num, den> type;
};

template <class R1, class R2>
struct ratio_equal;
template <class R1, class R2>
struct ratio_not_equal;
template <class R1, class R2>
struct ratio_less;
template <class R1, class R2>
struct ratio_less_equal;
template <class R1, class R2>
struct ratio_greater;
template <class R1, class R2>
struct ratio_greater_equal;

typedef ratio<1, 1000> milli;

} // namespace std