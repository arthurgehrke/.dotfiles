lua << EOF
-- require("dap-vscode-js").setup({
--   debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
--   adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
-- })

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
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/usr/bin/firefox",
      firefoxArgs = { "-start-debugger-server 6000" },
  },
  {
      name = "Debug with Firefox - Attach",
      type = "firefox",
      request = "attach",
      reAttach = true,
      host = "127.0.0.1",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
  },
  {
      name = "Run",
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      outFiles = { "${workspaceFolder}/lib/**/*.js" },
  },
  {
      name = "Attach to 9229",
      type = "node2",
      request = "attach",
      port = 9229,
      sourceMaps = true,
      outDir = "${workspaceRoot}/lib",
      outFiles = { "${workspaceRoot}/lib/**/*.js" },
  },
  {
      name = "Attach to process",
      type = "node2",
      request = "attach",
      sourceMaps = true,
      processId = require("dap.utils").pick_process,
  },
  {
      name = "Nope - Run npm run dev",
      command = "npm run dev",
      request = "launch",
      type = "node-terminal",
      cwd = "${workspaceFolder}",
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
      name = "Nope - Node - Debug Jest Tests with pwa-node",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
  },
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
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = ""
		}
		},
	force_buffers = false,
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
					{ id = "watches", size = 0.5 },
					{ id = "scopes", size = 0.5 },
					{ id = "breakpoints", size = 0.45 },
					-- { id = "stacks", size = 0.25 },
				},
				size = 40,
				position = "left",
		},
		{
				elements = { "repl", "console" },
				size = 10,
				position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		indent = 1,
		max_value_lines = 100
	},
}

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open({})
-- end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

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

require('nvim-dap-virtual-text').setup()

EOF
nnoremap <silent> <space>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <space>dx <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <space>di <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <space>do <Cmd>lua require'dap'.step_out()<CR>
