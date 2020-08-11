s="$1"
gcc -c add.c -o add.o
gcc -c sub.c -o sub.o
ar rcs libas.a add.o sub.o
gcc  -c mpy.c  -o mpy.o
gcc -c div.c -o div.o
gcc -shared -o libmd.so mpy.o div.o
#gcc -c main1.c -o main1.o
gcc main1.c -o main1 libas.a ./libmd.so
./main1 $s
