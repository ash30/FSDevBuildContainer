print("hello ccls1"); require("lspconfig").ccls.setup { init_options = { clang =  { pathMappings = { "/usr/src/freeswitch/>%ROOT%/", "/usr/bin/aarch64-linux-gnu-gcc-10>%STD_ENV%" } } } } 
