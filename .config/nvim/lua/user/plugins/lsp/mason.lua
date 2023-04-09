-- load mason plugin
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- setup plugins
mason.setup({
    ui = {
        border = "rounded"
    },
})
