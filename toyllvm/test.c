#include <stdint.h>

int64_t foobar;

long add2(long base) {
	if (base > 22) {
	  foobar = base;
	}
	return base + 2;
}

void _start() {

}
