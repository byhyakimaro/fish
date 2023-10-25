apt-get install -y curl \
  ccache cmake nodejs python3 pkg-config ninja-build time && npm i -g nodemon

# cmake --version
# # cmake version 3.24.1

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=`pwd`/depot_tools:$PATH

# echo "export PATH=`pwd`/depot_tools:\$PATH" >> ~/.zshrc

# cd depot_tools && git checkout 787e71ac && cd ..

# add patch
mkdir -p lib/v8 && cd lib/v8
gclient
fetch v8

cd v8
# git checkout 4ec5bb4f26

tools/dev/v8gen.py list
tools/dev/v8gen.py x64.release.sample -vv

# # echo 'v8_target_cpu = "arm64"' >> out.gn/x64.release.sample/args.gn
# sed -ie '/v8_enable_sandbox/d' out.gn/x64.release.sample/args.gn
# echo 'cc_wrapper="ccache"' >> out.gn/x64.release.sample/args.gn

cat <<EOF > "out.gn/x64.release.sample/args.gn"
target_os = "linux"
is_debug = false
target_cpu = "x64"
use_custom_libcxx = false
clang_use_chrome_plugins = false
is_component_build = false
is_clang = true
v8_static_library = true
v8_monolithic = true
v8_use_external_startup_data = false
v8_enable_test_features = false
v8_enable_i18n_support = false
treat_warnings_as_errors = false
symbol_level = 0
EOF

# export CCACHE_CPP2=yes
# export CCACHE_SLOPPINESS=time_macros

# # Optionally, add this to your ~/.zshrc if you are using zsh, or any
# # other equivalents
# echo "export CCACHE_CPP2=yes" >> ~/.zshrc
# echo "export CCACHE_SLOPPINESS=time_macros" >> ~/.zshrc

time ninja -C out.gn/x64.release.sample v8_monolith

mkdir ../../../v8
cp out.gn/x64.release.sample/obj/*.a ../../../v8/
cp -r include ../../../v8/

# clean up
cd ../../../ && rm -rf depot_tools lib