-- load luasnip plugin
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets(
  "markdown",
  {
    s(
      "minutes",
      {
        t({"---", ""}),
        t({"title: \""}), i(1, "Title"), t({"\"", ""}),
        t({"date: \""}), i(2, "2000-01-01"), t({"\"", ""}),
        t({"author: \""}), i(3, "Author"), t({"\"", ""}),
        t({"participants:", "- \""}), i(4, "Participant 1"), t({"\"", ""}),
        t({"lang: \""}), i(5, "ngerman"), t({"\"", ""}),
        t({"...", "", "", ""}), i(0),
      }
    ),
  }
)

