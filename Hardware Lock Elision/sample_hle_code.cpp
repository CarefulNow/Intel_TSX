#include "immintrin.h" 

volatile int lock_var = 0;
#define OPSTR       "Test, Test and Set Lock with Hardware Lock Elision"
#define ACQUIRE_LOCK()   {                                                                           							\
                        do {                                                                    								\
                            while(lock_var == 1) {                                              								\
                                _mm_pause;                                                    									\
                            }                                                                   								\
                        } while(__atomic_exchange_n(&lock_var, 1, __ATOMIC_ACQUIRE | __ATOMIC_HLE_ACQUIRE) == 1);              	\
                    }
#define RELEASE_LOCK()   __atomic_store_n(&lock_var, 0, __ATOMIC_RELEASE | __ATOMIC_HLE_RELEASE)

int main() {
	ACQUIRE_LOCK();
	RELEASE_LOCK();
	return 0;
}