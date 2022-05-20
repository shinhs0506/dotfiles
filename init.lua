vim.cmd('filetype plugin indent on')
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=0
vim.opt.expandtab=true
vim.opt.smarttab=true

vim.opt.ignorecase=true
vim.opt.incsearch=true
vim.opt.hlsearch=false

vim.opt.scrolloff=10
vim.opt.cc="80"
vim.opt.textwidth=100

vim.opt.cursorline=true
vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.wrap=false

vim.opt.splitright=true
vim.opt.splitbelow=true

vim.opt.updatetime=100
vim.opt.swapfile=false
vim.opt.errorbells=false

vim.opt.encoding="utf-8"

-- plugins
require("packer").startup(function (use)
    use 'wbthomason/packer.nvim'

    use 'sainnhe/gruvbox-material';

    use 'neovim/nvim-lspconfig';
    use 'williamboman/nvim-lsp-installer';
    use 'hrsh7th/cmp-nvim-lsp';
    use 'hrsh7th/cmp-buffer';
    use 'hrsh7th/cmp-path';
    use 'hrsh7th/cmp-cmdline';
    use 'hrsh7th/nvim-cmp';
    use 'L3MON4D3/LuaSnip';
    use 'saadparwaiz1/cmp_luasnip';

    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'};

    use 'windwp/nvim-autopairs';

    use 'tpope/vim-commentary';

    use 'nvim-lua/plenary.nvim';
    use {'nvim-telescope/telescope.nvim', tag='nvim-0.6', commit='d88094f'};

    use 'sindrets/diffview.nvim';

    use 'akinsho/toggleterm.nvim';

    use 'tpope/vim-fugitive';
    use 'lewis6991/gitsigns.nvim';

    use 'kyazdani42/nvim-tree.lua';

    use 'nvim-lualine/lualine.nvim';
end)

-- colorscheme
vim.cmd [[silent! colorscheme gruvbox-material]]
vim.opt.background="dark"
vim.g.gruvbox_material_diagnostic_virtual_text=1

local map = vim.api.nvim_set_keymap

-- leader
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- indent
map('v', '>', '>gv', {noremap = true, silent = true})
map('v', '<', '<gv', {noremap = true, silent = true})

-- remove search highlighting
-- map('n', '<CR>', ':noh<CR>', {noremap = true, silent = true})

-- comment
map('v', '<leader>cc', 'gc', {noremap = false, silent = true})
map('n', '<leader>cc', 'gcc', {noremap = false, silent = true})

-- window management
map('n', '<leader>h', ':wincmd h<CR>', {noremap = false, silent = true})
map('n', '<leader>j', ':wincmd j<CR>', {noremap = false, silent = true})
map('n', '<leader>k', ':wincmd k<CR>', {noremap = false, silent = true})
map('n', '<leader>l', ':wincmd l<CR>', {noremap = false, silent = true})

-- lsp and autocomplete
vim.cmd[[set completeopt=menu,menuone,noselect]]
local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-h>', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return false
    else
        return true
    end
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_back_space() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's'}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    },{
        name = 'buffer'
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    },{
        name = 'cmdline'
    })
})

local enhance_server_opts = {
    ["sumneko_lua"] = function(options)
        options.settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'require' }
                }
            }
        }
    end
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_installer.on_server_ready(function(server)
    local server_opts = {}

    server_opts.on_attach = on_attach
    server_opts.capabilities = capabilities
    
    if enhance_server_opts[server.name] then
        enhance_server_opts[server.name](server_opts)
    end

    server:setup(server_opts)
end)

-- treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    }
}

-- autopairs
local npairs = require('nvim-autopairs')
require('nvim-autopairs').setup { map_bs = false, map_cr = false}

_G.cr = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({'selected'}).selected ~= -1 then
            return npairs.esc('<c-y>')
        else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
    else
        return npairs.autopairs_cr()
    end
end

_G.bs = function()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({'mode'}).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end

map('i', '<cr>', 'v:lua.cr()', {noremap = true, expr = true, silent = true})
map('i', '<bs>', 'v:lua.bs()', {noremap = true, expr = true, silent = true})

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap=true, silent=true});
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap=true, silent=true});

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-h>"] = "select_horizontal",
                ["<C-s>"] = "select_vertical",
                ["<Tab>"] = "move_selection_previous",
                ["<S-Tab>"] = "move_selection_next",
            }
        },
        file_ignore_patterns = {
            "node_modules",
            "build",
        },
    }
}

-- diffview
require('diffview').setup {}

map('n', '<leader>fd', ':DiffviewOpen <CR>', { noremap=true, silent=true});
map('n', '<leader>fdu', ':DiffviewOpen upstream/main...HEAD <CR>', { noremap=true, silent=true});
map('n', '<leader>fdo', ':DiffviewOpen origin/main...HEAD <CR>', { noremap=true, silent=true});
map('n', '<leader>fc', ':DiffviewClose <CR>', { noremap=true, silent=true});
map('n', '<leader>fh', ':DiffviewFileHistory <CR>', { noremap=true, silent=true});

-- toggleterm
require('toggleterm').setup {
    open_mapping = [[<C-t>]],
    direction = 'float'
}

-- git sign
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '*' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelet = { text = '~' },
    }
}

-- Nvim tree
require('nvim-tree').setup {}
map('n', '<leader>nt', ':NvimTreeToggle<CR>', { noremap=true, silent=true});
map('n', '<leader>nr', ':NvimTreeRefresh<CR>', { noremap=true, silent=true});
map('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap=true, silent=true});


-- lualine
require('lualine').setup {
    options = {
        theme = 'gruvbox'
    }
}
