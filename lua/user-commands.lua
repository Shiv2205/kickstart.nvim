
vim.api.nvim_create_user_command(
    "Theme",
    function (opts)
        if opts.args == "" then
            print("Command requires one argument from: dark, darker, cool, deep, warm, warmer")
        else
            require('onedark').setup{
              style = opts.args
            }
            require('onedark').load()
        end
    end,
    {
        desc = 'Switch OneDark theme',
        nargs = '?'
    }
)
