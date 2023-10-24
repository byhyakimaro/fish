#include <libplatform/libplatform.h>
#include <uv.h>
#include "v8.h"

#include "./src/fish.hpp"

int main(int argc, char *argv[])
{
  char *filename = argv[1];
  auto *fish = new Fish();
  std::unique_ptr<v8::Platform> platform =
    fish->initializeV8(argc, argv);

  fish->initializeVM();
  fish->InitializeProgram(filename);
  fish->Shutdown();

  return 0;
}