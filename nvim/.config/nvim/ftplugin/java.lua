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

-- Handle jdt:// URIs by synchronously loading decompiled content before Neovim
-- tries to position the cursor. Without this, Neovim 0.11's LSP handler sets the
-- cursor before the async content arrives, causing "Cursor position outside buffer".
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "jdt://*",
    callback = function(ev)
        local buf = ev.buf
        local uri = ev.match
        vim.bo[buf].modifiable = true
        vim.bo[buf].swapfile = false
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].filetype = "java"

        local client = vim.lsp.get_clients({ name = "jdtls" })[1]
        if not client then
            vim.wait(5000, function()
                return vim.lsp.get_clients({ name = "jdtls" })[1] ~= nil
            end)
            client = vim.lsp.get_clients({ name = "jdtls" })[1]
        end
        if not client then
            vim.notify("No jdtls client found for jdt:// URI", vim.log.levels.ERROR)
            return
        end

        vim.lsp.buf_attach_client(buf, client.id)

        local content
        client:request("java/classFileContents", { uri = uri }, function(err, result)
            assert(not err, vim.inspect(err))
            content = result or ""
            local lines = vim.split(content:gsub("\r\n", "\n"), "\n", { plain = true })
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.bo[buf].modifiable = false
        end, buf)

        -- Block until content is loaded so cursor positioning works
        vim.wait(5000, function() return content ~= nil end)
    end,
})

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
      bundles = vim.fn.glob(vim.fn.stdpath("config") .. "/jdtls-plugins/dg.jdt.ls.decompiler.*.jar", false, true),
      extendedClientCapabilities = { classFileContentsSupport = true },
    },
    flags = { debounce_text_changes = 150 },
}

vim.lsp.start(config)

