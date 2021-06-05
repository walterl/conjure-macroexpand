local _2afile_2a = "fnl/conjure-macroexpand/main.fnl"
local _0_
do
  local name_0_ = "conjure-macroexpand.main"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  do end (module_0_)["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  do end (package.loaded)[name_0_] = module_0_
  _0_ = module_0_
end
local autoload
local function _1_(...)
  return (require("conjure-macroexpand.aniseed.autoload")).autoload(...)
end
autoload = _1_
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {require("conjure-macroexpand.aniseed.core"), require("conjure.bridge"), require("conjure.client"), require("conjure.eval"), require("conjure.extract"), require("conjure.log"), require("conjure.mapping"), require("conjure-macroexpand.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {require = {a = "conjure-macroexpand.aniseed.core", bridge = "conjure.bridge", client = "conjure.client", eval = "conjure.eval", extract = "conjure.extract", log = "conjure.log", mapping = "conjure.mapping", nvim = "conjure-macroexpand.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local bridge = _local_0_[2]
local client = _local_0_[3]
local eval = _local_0_[4]
local extract = _local_0_[5]
local log = _local_0_[6]
local mapping = _local_0_[7]
local nvim = _local_0_[8]
local _2amodule_2a = _0_
local _2amodule_name_2a = "conjure-macroexpand.main"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local current_form
do
  local v_0_
  local function current_form0()
    local form = extract.form({})
    if form then
      local _let_0_ = form
      local content = _let_0_["content"]
      return content
    end
  end
  v_0_ = current_form0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["current-form"] = v_0_
  current_form = v_0_
end
local clj_client
do
  local v_0_
  local function clj_client0(f, args)
    return client["with-filetype"]("clojure", f, args)
  end
  v_0_ = clj_client0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["clj-client"] = v_0_
  clj_client = v_0_
end
local output_expanded
do
  local v_0_
  local function output_expanded0(orig)
    local function _3_(r)
      return log.append({("; " .. orig), r}, {["break?"] = true})
    end
    return _3_
  end
  v_0_ = output_expanded0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["output-expanded"] = v_0_
  output_expanded = v_0_
end
local conjure_macroexpand
do
  local v_0_
  do
    local v_0_0
    local function conjure_macroexpand0(expand_cmd)
      local form = current_form()
      local me_form = ("(" .. (expand_cmd or "clojure.walk/macroexpand-all") .. " '" .. form .. ")")
      return clj_client(eval["eval-str"], {["on-result"] = output_expanded(me_form), ["passive?"] = true, code = me_form, origin = "conjure-macroexpand"})
    end
    v_0_0 = conjure_macroexpand0
    _0_["conjure-macroexpand"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["conjure-macroexpand"] = v_0_
  conjure_macroexpand = v_0_
end
local init
do
  local v_0_
  do
    local v_0_0
    local function init0()
      nvim.ex.command_("ConjureMacroexpand", bridge["viml->lua"]("conjure-macroexpand.main", "conjure-macroexpand"))
      nvim.ex.command_("ConjureMacroexpand0", bridge["viml->lua"]("conjure-macroexpand.main", "conjure-macroexpand", {args = "\"clojure.core/macroexpand\""}))
      nvim.ex.command_("ConjureMacroexpand1", bridge["viml->lua"]("conjure-macroexpand.main", "conjure-macroexpand", {args = "\"clojure.core/macroexpand-1\""}))
      if (not nvim.g.conjure_macroexpand_disable_mappings or (0 == nvim.g.conjure_macroexpand_disable_mappings)) then
        mapping.buf("n", nil, "cm", ":ConjureMacroexpand<CR>")
        mapping.buf("n", nil, "c0", ":ConjureMacroexpand0<CR>")
        return mapping.buf("n", nil, "c1", ":ConjureMacroexpand1<CR>")
      end
    end
    v_0_0 = init0
    _0_["init"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["init"] = v_0_
  init = v_0_
end
return nil