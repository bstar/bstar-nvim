-- require('harpoon').setup()
-- vim.keymap.set('n', '<leader>hh', [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]], { noremap = true, silent = true, desc = 'open harpoon menu' })
-- vim.keymap.set('n', '<leader>hm', [[:lua require("harpoon.mark").add_file()<CR>]], { noremap = true, silent = true, desc = 'add file to harpoon' })
-- vim.keymap.set('n', '<leader>hb', [[:lua require("harpoon.ui").nav_prev()<CR>]], { noremap = true, silent = true, desc = 'open prev harpoon' })
-- vim.keymap.set('n', '<leader>hn', [[:lua require("harpoon.ui").nav_next()<CR>]], { noremap = true, silent = true, desc = 'open next harpoon' })

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
