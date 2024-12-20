vim.g.mapleader = " "
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
local function nmap(key, map)
  keymap('n', key, map, opts)
end

--- Standard Neovim ---
nmap('<leader>bn', ':bnext<CR>')
nmap('<leader>bp', ':bprevious<CR>')
nmap('<leader>nh', ':noh<CR>')

--- Telescope ---
nmap('<leader>ff', ':Telescope find_files<CR>')
nmap('<leader>fg', ':Telescope git_files<CR>')
nmap('<leader>fb', ':Telescope buffers<CR>')
nmap('<leader>qf', ':Telescope quickfix<CR>')

--- Buffer Manager ---
nmap('bm', ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>')

--- mason ---
nmap('gd' ,':lua vim.lsp.buf.definitions()<cr>')
nmap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

--- Ouroboros ---
nmap('fc', ':Ouroboros<CR>')

--- CMake Tools ---
nmap('<leader>cm', ':CMakeRun<CR>')
--- DAP (Debugger) ---
nmap('<leader>di', ':CMakeDebug<CR>')
nmap('<leader>db', ':lua require("dap").toggle_breakpoint()<CR>')
nmap('<leader>dc', ':lua require("dap").continue()<CR>')
nmap('<leader>ds', ':lua require("dap").step_over()<CR>')

-- Oil
nmap('-', '<CMD>Oil<CR>')
-- LSP
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
nmap("<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
-- Trouble 
nmap('<leader>tt', ':Trouble diagnostics toggle pinned=true win.relative=win win.position=bottom<CR>')
nmap('<leader>ts', ':Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>')

