#include <stdint.h>

int64_t foobar = 0;

long add2(long base) {
	if (base > 22) {
	  foobar = base;
	}
	return base + 2;
}

void _start() {

}
