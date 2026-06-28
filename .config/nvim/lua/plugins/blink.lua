return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      local function to_pascal(str)
        return str
          :gsub("[-_](%a)", function(c)
            return c:upper()
          end)
          :gsub("^%a", string.upper)
      end

      local function filename_pascal()
        return to_pascal(vim.fn.expand("%:t:r"))
      end

      ls.add_snippets("typescriptreact", {
        s("rfcp", {
          t("type "),
          f(filename_pascal),
          t("Props = {"),
          t({ "", "  " }),
          i(1),
          t({ "", "}", "", "export default function " }),
          f(filename_pascal),
          t("({ "),
          i(2),
          t(" }: "),
          f(filename_pascal),
          t("Props) {"),
          t({ "", "  return (", "    <div>", "      " }),
          i(0),
          t({ "", "    </div>", "  )", "}" }),
        }),
        s("rfci", {
          t("type "),
          f(filename_pascal),
          t("Props = InertiaProps<{"),
          t({ "", "  " }),
          i(1),
          t({ "", "}>", "", "export default function " }),
          f(filename_pascal),
          t("({ "),
          i(2),
          t(" }: "),
          f(filename_pascal),
          t("Props) {"),
          t({ "", "  return (", "    <div>", "      " }),
          i(0),
          t({ "", "    </div>", "  )", "}" }),
        }),
        s("rfc", {
          t("export default function "),
          f(filename_pascal),
          t("() {"),
          t({ "", "  return (", "    <div>", "      " }),
          i(0),
          t({ "", "    </div>", "  )", "}" }),
        }),
      })
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = { "lsp", "snippets" },
        providers = {
          snippets = {
            module = "blink.cmp.sources.snippets",
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      },
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
    },
  },
}
