#include "immintrin.h" 

volatile int lock_var = 0;
#define OPSTR       "Test, Test and Set Lock"
#define ACQUIRE_LOCK()   {                                                                           \
                        do {                                                                    \
                            while(lock_var == 1) {                                              \
                                _mm_pause;                                                    \
                            }                                                                   \
                        } while(__sync_val_compare_and_swap(&lock_var, 0, 1) == 1);              \
                    }
#define RELEASE_LOCK()   lock_var = 0

int main() {
    unsigned int transaction = 1;                                                                      
    unsigned int status = 0;                                                
    unsigned int attempts = 8;                                              
    while(true) {
        while(lock_var) {
        	_mm_pause;
        }
        if(transaction == 1) {                                              
            status = _xbegin();                                             
        } else {                                                            
            ACQUIRE_LOCK();                                                 
            status = _XBEGIN_STARTED;                                      
        }                                                                   
        if(status == _XBEGIN_STARTED) {                                    
            if(_xtest() && lock_var) _xabort(0x01);                         
                                                                          
    			/*UPDATE SHARED DATA STRUCTURE*/

            if(_xtest()) _xend();                                           
            else RELEASE_LOCK();                                            
            break;                                                          
        } else {                                                            
            if (attempts > 0) {                                             
                attempts--;                                                 
            } else transaction = 0;                                        
            while(lock_var) {                                                           
                _mm_pause;                                                
            }                                              
        }                                                                   
    }  
    return 0;
}