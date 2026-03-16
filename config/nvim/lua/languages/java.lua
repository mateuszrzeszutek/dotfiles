local function setup(capabilities)
  local mason = require('utils.mason')

  mason.ensure_installed({ 'java-debug-adapter', 'java-test' })

  local bundles = mason.glob_registry('/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar')

  local java_test_jars = mason.glob_registry('/java-test/extension/server/*.jar', {
    'com.microsoft.java.test.runner-jar-with-dependencies.jar',
    'jacocoagent.jar',
  })
  vim.list_extend(bundles, java_test_jars)

  vim.lsp.config('jdtls', {
    capabilities = capabilities,
    init_options = {
      bundles = bundles
    }
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
      "*.java"
    },
    callback = function(ev)
      local opts = { buffer = ev.buf }
      local jdtls = require('jdtls')

      -- TODO: neotest integration
      vim.keymap.set('n', '<leader>lt', jdtls.test_nearest_method, opts)
      vim.keymap.set('n', '<leader>lT', jdtls.test_class, opts)
    end
  })
end

return {
  treesitter = { 'java' },
  lsp = { 'jdtls' },
  neotest = require('neotest-gradle'),
  setup = setup
}
