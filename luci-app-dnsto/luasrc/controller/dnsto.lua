module("luci.controller.dnsto",package.seeall)
function index()
if not nixio.fs.access("/etc/config/dnsto")then
return
end
entry({"admin","services","dnsto"},cbi("dnsto/global"),_("Ddnsto内网穿透"), 61).dependent = true
entry({"admin","services","dnsto_status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("pgrep -f dnsto >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)

end