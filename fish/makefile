CXX = ccache g++
OUTPUT_FILE=bin/fish

define INCLUDE
	v8/include/
endef

define INCLUDEUV
	libuv/include/
endef

define APP
	app/index.cpp
endef

define OBJ
	v8/.libs/libv8_monolith.a
	libuv/.libs/libuv.a
endef

export INCLUDE
export INCLUDEUV
export OUTPUT_FILE

export APP
export LIB
export OBJ
export APP


build:
	mkdir -p bin
	$(CXX) $$APP -I $$INCLUDE -I $$INCLUDEUV  -std=c++17 -pthread -o $$OUTPUT_FILE -DV8_COMPRESS_POINTERS $$OBJ -Wl,--no-as-needed -ldl

clean:
	rm -rf bin