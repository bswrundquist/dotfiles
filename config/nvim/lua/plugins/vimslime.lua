return {
  -- Add vim-slime plugin
  {
    "jpalardy/vim-slime",
    config = function()
      -- Custom settings for Vim Slime
      vim.g.slime_target = "tmux"
      vim.g.slime_python_ipython = 1  -- Set this to use IPython if available
      vim.g.slime_default_config = {
        socket_name = "default",  -- Tmux socket name (can usually be left as "default")
        target_pane = "{last}",    -- Target pane where the slime should be sent
      }
      vim.g.slime_dont_ask_default = 1 -- Don't ask for confirmation each time
    end
  }
}

