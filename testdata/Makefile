build:
	gcc basic-cpp.cpp -o out/basic-cpp
	gcc basic-cpp-plt.cpp -o out/basic-cpp-plt
	gcc basic-cpp.cpp -o out/basic-cpp-no-fp -fomit-frame-pointer

	gcc -Wall -fPIC -c cpp-dynlib.cpp
	gcc -shared -Wl,-soname,libcpp-dynlib.so -o libcpp-dynlib.so cpp-dynlib.o
	gcc -Wall -pedantic -Werror -Wextra -L. basic-cpp-uses-dynlib.cpp -lcpp-dynlib
	#[javierhonduco@fedora testdata]$ LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PWD/"  ./a.out

validate: build
	../dist/eh-frame --executable out/basic-cpp > tables/ours_basic-cpp.txt
	../dist/eh-frame --executable out/basic-cpp-plt > tables/ours_basic-cpp-plt.txt
	../dist/eh-frame --executable out/basic-cpp-no-fp > tables/ours_basic-cpp-no-fp.txt
	../dist/eh-frame --executable libc.so.6 > tables/ours_libc_so_6.txt
	../dist/eh-frame --executable libpython3.10.so.1.0 > tables/ours_libpython3.10.txt
	../dist/eh-frame --executable systemd > tables/ours_systemd.txt
	../dist/eh-frame --executable parca-agent > tables/ours_parca-agent.txt
	../dist/eh-frame --executable ruby > tables/ours_ruby.txt
	../dist/eh-frame --executable libruby > tables/ours_libruby.txt

all: validate
