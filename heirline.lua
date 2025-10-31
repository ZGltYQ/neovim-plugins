-- Heirline statusline configuration for AstroNvim
-- This adds the jira-time timer component to the statusline

---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")

    -- Create jira-time statusline component
    local jira_component = status.component.builder({
      {
        provider = function()
          local ok, jira = pcall(require, 'jira-time.statusline')
          if ok then
            local jira_status = jira.get_status()
            if jira_status ~= '' then
              return ' ' .. jira_status .. ' '
            end
          end
          return ""
        end,
        hl = status.hl.get_attributes("git_branch", true),
        on_click = {
          callback = function()
            vim.cmd("JiraTimeStatus")
          end,
          name = "jira_time_click",
        },
      },
    })

    -- Find the position to insert (before the last fill component)
    -- AstroNvim statusline structure: [mode, git, file, diagnostics, ...fill..., lsp, position]
    -- We want to insert just before the fill
    local insert_pos = nil
    for i, component in ipairs(opts.statusline) do
      if component.provider and component.provider == status.provider.fill() then
        insert_pos = i
        break
      end
    end

    if insert_pos then
      table.insert(opts.statusline, insert_pos, jira_component)
    else
      -- If we can't find fill, just append it
      table.insert(opts.statusline, jira_component)
    end

    return opts
  end,
}
