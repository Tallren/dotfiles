local home = os.getenv("HOME")
local java_home = os.getenv("JAVA_HOME")

-- Find project root directory
local root_markers = {'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle'}
local found_files = vim.fs.find(root_markers, { upward = true })
local root_dir = found_files[1] and vim.fs.dirname(found_files[1]) or nil

-- Use a project-specific workspace directory
local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.local/share/nvim/jdtls-workspace/' .. project_name

local launcher_jar = vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')

if launcher_jar == "" then
    vim.notify("Could not find jdtls launcher jar!", vim.log.levels.ERROR)
    return
end

-- Use Java 21 for jdtls server, but Java 17 for project builds
local jdtls_java = '/opt/homebrew/opt/openjdk@21/bin/java'

local config = {
    name = 'jdtls',
    cmd = {
        jdtls_java,  -- Use Java 21 for jdtls server
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. home .. '/.local/share/java/lombok-1.18.42.jar',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher_jar,
        '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
        '-data', workspace_dir,
    },
    root_dir = root_dir,
    settings = {
        java = {
            home = java_home,  -- Keep Java 17 for project builds
            jdt = { ls = { lombokSupport = { enabled = true } } },
            configuration = {
                runtimes = { { name = "Temurin-17.0.14+7", path = java_home } },
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
}

vim.lsp.start(config)

