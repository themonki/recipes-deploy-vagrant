#include <stdlib.h>
  #include <sys/types.h>
  #include <unistd.h>

  int
  main (int argc, char *argv[])
  {
     setuid (0);

     /* WARNING: Only use an absolute path to the script to execute,
      *          a malicious user might fool the binary and execute
      *          arbitary commands if not.
      * */
     for(int i = 0; i < argc ; i++){

	}
     system ("/bin/sh /path/to/php_root.sh");

     return 0;
   }

