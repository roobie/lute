
(let [Tap (require :tap)
      fmt (require :fmt)
      tap (Tap.new {:name :fmt.lua})]

  (tap:addTest "fmt"
               (fn [test]
                 (let [str (fmt "%s!%d" "A" 10)]
                   (test:equal str "A!10"))))

  tap)
