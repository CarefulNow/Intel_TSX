unsigned int transaction = 1;                                                                      
unsigned int status = 0;                                                
unsigned int attempts = 8;                                              
while(1) {
    while(lock_var) {
    	_mm_pause();
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
            _mm_pause();                                                
        }                                              
    }                                                                   
}  
