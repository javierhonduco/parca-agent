build:
	gcc basic-cpp.cpp -o out/basic-cpp
	gcc basic-cpp-plt.cpp -o out/basic-cpp-plt
	gcc basic-cpp.cpp -o out/basic-cpp-no-fp -fomit-frame-pointer

validate: build
	../dist/eh-frame --executable out/basic-cpp > tables/ours_basic-cpp.txt
	../dist/eh-frame --executable out/basic-cpp-plt > tables/ours_basic-cpp-plt.txt
	../dist/eh-frame --executable out/basic-cpp-no-fp > tables/ours_basic-cpp-no-fp.txt
	../dist/eh-frame --executable libc.so.6 > tables/ours_libc_so_6.txt
	../dist/eh-frame --executable libpython3.10.so.1.0 > tables/ours_libpython3.10.txt
	../dist/eh-frame --executable systemd > tables/ours_systemd.txt

all: validate