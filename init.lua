vim.cmd('filetype plugin indent on')
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = false
vim.opt.autoindent = true
vim.opt.smartindent = false

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.scrolloff = 10
vim.opt.cc = "120"

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 100
vim.opt.swapfile = false
vim.opt.errorbells = false

vim.opt.encoding = "utf-8"

vim.opt.cmdheight = 0

vim.opt.timeoutlen = 100

-- plugins
require("packer").startup(function(use)
    use 'wbthomason/packer.nvim';

    use 'sainnhe/gruvbox-material';
    use 'ellisonleao/gruvbox.nvim'
    use 'navarasu/onedark.nvim';
    use 'EdenEast/nightfox.nvim';
    use { 'catppuccin/nvim', as='catppuccin' };

    use 'neovim/nvim-lspconfig';
    use 'hrsh7th/cmp-nvim-lsp';
    use 'hrsh7th/cmp-buffer';
    use 'hrsh7th/cmp-path';
    use 'hrsh7th/cmp-cmdline';
    use 'hrsh7th/nvim-cmp';
    use 'L3MON4D3/LuaSnip';
    use 'saadparwaiz1/cmp_luasnip';

    use 'williamboman/mason.nvim';
    use 'williamboman/mason-lspconfig.nvim';
    use 'jose-elias-alvarez/null-ls.nvim';
    use 'jayp0521/mason-null-ls.nvim';

    use 'windwp/nvim-autopairs';

    use 'tpope/vim-commentary';
    use 'tpope/vim-surround';

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };
    use 'nvim-treesitter/nvim-treesitter-context';

    use 'nvim-lua/plenary.nvim';
    use 'nvim-telescope/telescope.nvim';

    use 'folke/which-key.nvim';

    use 'tpope/vim-fugitive';
    use 'lewis6991/gitsigns.nvim';
    use 'kdheepak/lazygit.nvim';

    use 'kyazdani42/nvim-web-devicons';
    use 'kyazdani42/nvim-tree.lua';

    use 'lukas-reineke/indent-blankline.nvim';

    use 'nvim-lualine/lualine.nvim';

    use 'simeji/winresizer';

    use 'iamcco/markdown-preview.nvim';

    use { 'akinsho/toggleterm.nvim', tag='*' }
end)

-- colorscheme
-- vim.cmd [[silent! colorscheme gruvbox-material]]
-- vim.cmd [[silent! colorscheme gruvbox]]
-- vim.opt.background = "dark"
-- vim.g.gruvbox_material_diagnostic_virtual_text = 1

-- require('onedark').setup{
--     style = 'cool',
--     transparent = false,
--     diagnostics = {
--         background = false,
--     }
-- }
-- require('onedark').load()

require('catppuccin').setup {
    flavour = "frappe",
    dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.3
    },
    integrations = {
        mason = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { 'italic' },
                hints = { 'italic' },
                warnings = { 'italic' },
                information = { 'italic' }
            },
            underline = {
                errors = { 'underline' },
                hints = { 'underline' },
                warnings = { 'underline' },
                information = { 'underline' }
            }
        },
        treesitter = true,
        treesitter_context = true,
        gitsigns = true,
        telescope = true,
        cmp = true,
        which_key = true,
        nvimtree = true,
    }
}
vim.cmd [[silent! colorscheme catppuccin-frappe]]

local map = vim.api.nvim_set_keymap

-- leader
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- indent
map('v', '>', '>gv', { noremap = true, silent = true })
map('v', '<', '<gv', { noremap = true, silent = true })

-- remove search highlighting
-- map('n', '<CR>', ':noh<CR>', {noremap = true, silent = true})

-- comment
map('v', '<leader>cc', 'gc', { noremap = false, silent = true })
map('n', '<leader>cc', 'gcc', { noremap = false, silent = true })

-- window management
map('n', '<leader>h', ':wincmd h<CR>', { noremap = false, silent = true })
map('n', '<leader>j', ':wincmd j<CR>', { noremap = false, silent = true })
map('n', '<leader>k', ':wincmd k<CR>', { noremap = false, silent = true })
map('n', '<leader>l', ':wincmd l<CR>', { noremap = false, silent = true })

-- tab management
map('n', '<C-t>o', ':tabnew <CR>', { noremap = false, silent = true })
map('n', '<C-t>1', '1gt', { noremap = false, silent = true })
map('n', '<C-t>2', '2gt', { noremap = false, silent = true })
map('n', '<C-t>3', '3gt', { noremap = false, silent = true })
map('n', '<C-t>4', '4gt', { noremap = false, silent = true })
map('n', '<C-t>5', '5gt', { noremap = false, silent = true })
map('n', '<C-t>6', '6gt', { noremap = false, silent = true })
map('n', '<C-t>7', '7gt', { noremap = false, silent = true })
map('n', '<C-t>8', '8gt', { noremap = false, silent = true })
map('n', '<C-t>9', '9gt', { noremap = false, silent = true })
map('n', '<C-t>0', '0gt', { noremap = false, silent = true })
map('n', '<C-t>d', ':tabclose <CR>', { noremap = false, silent = true })
map('n', '<C-t>n', ':tabnext <CR>', { noremap = false, silent = true })
map('n', '<C-t>p', ':tabNext <CR>', { noremap = false, silent = true })

-- lsp and autocomplete
vim.cmd [[set completeopt=menu,menuone,noselect]]

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-h>', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        name = 'buffer'
    }),
    window = {
        completion = {
            border = 'rounded'
        },
        documentation = {
            border = 'rounded'
        }
    }
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
    }, {
        name = 'cmdline'
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        'tsserver',
        'sumneko_lua',
        'marksman',
        'pyright',
        'rust_analyzer'
    }
}
require('mason-lspconfig').setup_handlers {
    function(server)
        require('lspconfig')[server].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end,
    ['sumneko_lua'] = function ()
        require('lspconfig')['sumneko_lua'].setup {
            on_attach = on_attach,
            capabilities = capabilities,

            diagnostics = {
                globals = { 'vim' }
            }
        }
    end
}

-- null-ls
require('null-ls').setup {
    sources = {
        require('null-ls').builtins.formatting.eslint,
        require('null-ls').builtins.formatting.autopep8,
        require('null-ls').builtins.formatting.gofumpt
    }
}
require('mason-null-ls').setup {}

-- treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'cmake',
        'go',
        'html',
        'javascript',
        'json',
        'markdown',
        'python',
        'rust',
        'sql'
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    autotag = {
        enable = true,
    }
}

require('treesitter-context').setup {
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case'
        }
    }
}

-- autopairs
local autopairs = require('nvim-autopairs.completion.cmp')
require('nvim-autopairs').setup({
    check_ts = true,
})
cmp.event:on('confirm_done', autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true });
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true });

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
            "__pycache__",
            "lib",
        },
    }
}

-- which key
require('which-key').setup {}

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

-- lazygit nvim
map('n', '<C-g>', ':LazyGit<CR>', { noremap = true, silent = true });

-- diagnostic sings
local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Nvim tree
require('nvim-tree').setup {
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            }
        }
    }
}

map('n', '<leader>nt', ':NvimTreeToggle<CR>', { noremap = true, silent = true });
map('n', '<leader>nr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true });
map('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true });

-- lualine
require('lualine').setup {
    options = {
        theme = 'catppuccin'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                path = 1
            }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

-- winresizer
vim.g.winresizer_vert_size = 5
vim.g.winresizer_horiz_resize = 1

-- toggleterm
require('toggleterm').setup {}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
