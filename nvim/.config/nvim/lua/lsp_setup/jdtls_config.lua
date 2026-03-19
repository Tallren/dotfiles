local home = os.getenv("HOME")
local java_home = os.getenv("JAVA_HOME")

require("lspconfig").jdtls.setup({
    cmd_env = {
        JDTLS_JVM_ARGS = "-javaagent:" .. home .. "/.local/share/java/lombok-1.18.42.jar",
    },
    settings = {
        java = {
            home = java_home,
            jdt = { ls = { lombokSupport = { enabled = true } } },
            configuration = {
                runtimes = { { name = "JavaSE-17", path = java_home } },
                updateBuildConfiguration = "interactive",
            },
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            gradle = { downloadSources = true },
            import = {
              gradle = { enabled = true, wrapper = { enabled = true } },
              maven = { enabled = true },
            },
            autobuild = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
            references = { includeDecompiledSources = true },
        }
    },
    init_options = {
      bundles = { home .. "/.local/share/java/lombok-1.18.42.jar" },
      extendedClientCapabilities = { classFileContentsSupport = true },
    },
    flags = { debounce_text_changes = 150 }
})

