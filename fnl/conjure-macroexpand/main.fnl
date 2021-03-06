(module conjure-macroexpand.main
  {require {a aniseed.core
            nvim aniseed.nvim
            bridge conjure.bridge
            client conjure.client
            eval conjure.eval
            extract conjure.extract
            log conjure.log
            mapping conjure.mapping}})

;; Adapted from conjure.eval/current-form
(defn- current-form []
  (let [form (extract.form {})]
    (when form
      (let [{: content} form]
        content))))

(defn- clj-client [f args]
  (client.with-filetype "clojure" f args))

(defn- output-expanded [orig]
  (fn [r]
    (log.append [(.. "; " orig) r] {:break? true})))

(defn clj-macroexpand [expand-cmd]
  (let [form (current-form)
        me-form (.. "(" (or expand-cmd "clojure.walk/macroexpand-all") " '" form ")")]
    (clj-client eval.eval-str
                {:origin :conjure-macroexpand
                 :code me-form
                 :passive? true
                 :on-result (output-expanded me-form)})))

(defn add-buf-mappings []
  (mapping.buf :n nil "cm" ":ConjureCljMacroexpand<CR>")
  (mapping.buf :n nil "c0" ":ConjureCljMacroexpand0<CR>")
  (mapping.buf :n nil "c1" ":ConjureCljMacroexpand1<CR>"))

(defn init []
  (nvim.ex.command_
    "ConjureCljMacroexpand"
    (bridge.viml->lua :conjure-macroexpand.main :clj-macroexpand))
  (nvim.ex.command_
    "ConjureCljMacroexpand0"
    (bridge.viml->lua :conjure-macroexpand.main :clj-macroexpand {:args "\"clojure.core/macroexpand\""}))
  (nvim.ex.command_
    "ConjureCljMacroexpand1"
    (bridge.viml->lua :conjure-macroexpand.main :clj-macroexpand {:args "\"clojure.core/macroexpand-1\""}))

  (when (or (not nvim.g.conjure_macroexpand_disable_mappings)
            (= 0 nvim.g.conjure_macroexpand_disable_mappings))
    (nvim.ex.autocmd
      :FileType "clojure"
      (bridge.viml->lua :conjure-macroexpand.main :add-buf-mappings))))
