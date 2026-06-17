return {
  'folke/neoconf.nvim',
  config = function()
    require('neoconf').setup()

    local orig = vim.lsp.handlers['textDocument/publishDiagnostics']
    vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
      if result and result.diagnostics then
        local ignored = require('neoconf').get('diagnostics.ignore') or {}
        result.diagnostics = vim.tbl_filter(function(d)
          for _, pattern in ipairs(ignored) do
            if d.message:match(pattern) then return false end
          end
          return true
        end, result.diagnostics)
      end
      orig(err, result, ctx, config)
    end
  end,
}
