(local view (require :fennel.fennelview))
(fn pp [a]
  (print (view a)))

(fn cli-with-subcommands [configuration]
  (fn table? [a]
    (= "table" (type a)))

  (fn find [predicate enumerator collection]
    (each [k v (enumerator collection)]
      (when (predicate v k collection)
        (lua "return v"))))

  (fn find-index [predicate enumerator collection]
    (each [k v (enumerator collection)]
      (when (predicate v k collection)
        (lua "return k"))))

  (fn populate-defaults [result subcommand-configuration]
    (each [k v (pairs subcommand-configuration)]
      (let [dv (. v :default-value)]
        (when (not (= nil dv))
          (tset result k dv)))))

  (assert (table? configuration)
          "argument for parameter `configuration` must be a table")

  (fn parse [commandline-arguments]
    (local result {:subcommand (. commandline-arguments 1)})
    (local subcommand-configuration (. configuration result.subcommand))
    (when (not (table? subcommand-configuration))
      (local errmsg (string.format "Subcommand '%s' is not defined" result.subcommand))
      (lua "return nil, errmsg"))

    (populate-defaults result subcommand-configuration)
    (when (= 1 (length commandline-arguments))
      (lua "return true, result"))

    (fn default? [a] a.is-default)
    (local default-arg-index (find-index default? pairs subcommand-configuration))
    (local default-arg (find default? pairs subcommand-configuration))
    (local first-subcommand-arg (. commandline-arguments 2))
    (when (not (= "-" (string.sub first-subcommand-arg 1 1)))
      (tset result default-arg-index first-subcommand-arg))

    (values true result)))

;; normal
;; flag
;; switch
;; array
;; [sub-command] [arg1]
(local argparser
       (cli-with-subcommands {:substitute {:path {:is-default true
                                                  :default-value "."
                                                  :short "p"
                                                  :long "path"}
                                           :no-recursion {:default-value false
                                                          :flag true
                                                          :short "N"
                                                          :long "no-recursion"}}
                              :check {}
                              }))

(local args [...])
(let [(ok result) (argparser args)]
  (pp [ok result]))

;; == ;;

(fn perform-substitutions [line filename line-number]
  (local result
         (-> line
             (string.gsub "__FILE__" (tostring filename))
             (string.gsub "__LINE__" (tostring line-number))))
  result)

(let [source-filename (. args 1)
      destination-filename (. args 2)]
(with-open [source (io.open source-filename :rb)
            destination (io.open destination-filename :w+)]
  (local accumulator [])
  (var line-counter 0)
    (each [line (source:lines)]
      (set line-counter (+ 1 line-counter))
      (table.insert accumulator (perform-substitutions line source-filename line-counter)))
    (pp accumulator)
    (destination:write (table.concat accumulator "\n"))))
