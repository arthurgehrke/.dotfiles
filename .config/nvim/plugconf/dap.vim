lua << EOF

-- /Users/arthurrodrigues/dev/microsoft/vscode-node-debug2
require("dap-vscode-js").setup({
   node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
   debugger_path = '/Users/arthurrodrigues/dev/vscode-js-debug',
   adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

local dap = require('dap')

dap.adapters.node2 = {
   type = 'executable',
   command = 'node',
   args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
   {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
   },
   {
      name = "Attach to node process",
      type = "pwa-node",
      request = "attach",
      rootPath = "${workspaceFolder}",
      processId = require("dap.utils").pick_process,
   },
}
dap.configurations.typescript = {
   {
      name = 'Launch',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
      skipFiles = { "<node_internals>/**" },
      program = "${file}",
   },
   {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      reAttach = true,
      request = 'attach',
      console = 'integratedTerminal',
      host = function()
      local value = vim.fn.input "Host [127.0.0.1]: "
      if value ~= "" then
         return value
      end
      return "127.0.0.1"
      end,
      port = function()
      local val = tonumber(vim.fn.input("Port: ", "54321"))
      assert(val, "Please provide a port number")
      return val
      end,
   },
   {
      name = "Nope - Run npm run dev",
      command = "npm run dev",
      request = "launch",
      type = "node-terminal",
      cwd = "${workspaceFolder}",
      console = 'integratedTerminal',
   },
   {
      type = "pwa-node",
      request = "launch",
      name = "Nope - Node - Launch with pwa-node",
      program = "${file}",
      cwd = "${workspaceFolder}",
      port = 9229,
   },
   {
      type = "pwa-node",
      request = "launch",
      name = "Launch file 9229",
      program = "${file}",
      cwd = "${workspaceFolder}",
      port = 9229,
   },
   {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
   },
   {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
   }
}

dap.configurations.javascript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.typescript

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
   return
end

dapui.setup {
   controls = {
      element = "repl",
      enabled = false,
      icons = {
         pause = "",
         play = "",
         step_into = "",
         step_over = "",
         step_out = "",
         step_back = "",
         run_last = "",
         terminate = "",
      },
   },
   force_buffers = true,
   icons = { expanded = "▾", collapsed = "▸" },
   mappings = {
      -- Use a table to apply multiple mappings
      expand = "<cr>",
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
   },
   expand_lines = false,
   layouts = {
      {
         elements = {
            { id = "scopes", size = 0.25 },
            -- { id = "watches", size = 0.5 },
            -- { id = "breakpoints", size = 0.45 },
            "breakpoints",
            "stacks",
            "watches",
         },
         size = 40,
         position = "left",
      },
      {
         elements = { "repl", "console" },
         size = 0.25,
         position = "bottom",
      },
   },
   floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "solid", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
         close = { "q", "<Esc>" },
      },
   },
   windows = { indent = 1 },
   render = {
      -- indent = 1,
      max_type_length = nil,
      max_value_lines = 100,
   },
   element_mappings = {
      stacks = {
         open = "<CR>",
         expand = "o",
      },
   },
}

dap.defaults.typescript.auto_continue_if_many_stopped = true
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
dap.defaults.fallback.focus_terminal = false

-- disable dap events that are created
dap.listeners.after.event_initialized["dapui_config"] = nil
dap.listeners.before.event_terminated["dapui_config"] = nil
dap.listeners.before.event_exited["dapui_config"] = nil

vim.keymap.set('n', '<space>ui', require 'dapui'.toggle)
vim.keymap.set('n', '<space>dc', function() require"dap".terminate() end)
vim.keymap.set('n', '<space>dR', function() require"dap".clear_breakpoints() end)
vim.keymap.set('n', '<space>de', function() require"dap".set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<space>dh', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<space>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<space>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<space>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<space>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<space>du', ':lua require"dapui".toggle()<CR>')
vim.api.nvim_set_keymap('n', '<space>do', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.keymap.set('n', '<space>dC', function() require("dapui").close() end)
vim.keymap.set('n', '<F5>', require 'dap'.continue)
-- vim.keymap.set('n', '<F10>', require 'dap'.step_over)
-- vim.keymap.set('n', '<F11>', require 'dap'.step_into)
-- vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<space>b', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<sapce>B', function()
require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)

require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, _buf, _stackframe, _node)
      return variable.name .. ' = ' .. variable.value
    end,
    -- experimental features:
    virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
}
EOF
nnoremap <silent> <space>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <space>dx <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <space>di <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <space>do <Cmd>lua require'dap'.step_out()<CR>
