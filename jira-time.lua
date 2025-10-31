return {
  'ZGltYQ/jira-time.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('jira-time').setup({
      oauth = {
        client_id = '',
        client_secret = '',
      },
      statusline = {
        enabled = true,
        mode = 'custom', -- Use custom mode for heirline integration
        format = '[%s] ⏱ %s',
        show_when_inactive = false,
      }
    })
  end,
}
