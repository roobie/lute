(fn reduce [iterator tbl initial-value transform]
  (var accumulator initial-value)
  (each [k v (iterator tbl)]
    (transform accumulator v k))
  accumulator)

(fn mutate [root key transform]
  (let [result (transform (. root key))]
    (tset root key result)
    result))

(fn [configuration]
  (local cfg (or configuration {}))
  (local csv {:separator (or cfg.separator ",")
              :newline (or cfg.newline "\n")})

  (fn csv.keys [atable]
    (reduce pairs
            atable
            {}
            (fn [a _ k]
              (table.insert a k))))

  (fn csv.string-sink []
    {:buffer ""
     :write (fn [self data]
              (mutate self :buffer (fn [v] (.. v data))))
     })
  ;; for use in lua code
  (tset csv :stringSink csv.string-sink)

  (fn is-last [index itable]
    (= index (length itable)))

  (fn csv.encode-headers [destination headers]
    (each [i header (ipairs headers)]
      (destination:write header)
      (when (not (is-last i headers))
        (destination:write csv.separator)))
    (destination:write csv.newline))
  (tset csv :encodeHeaders csv.encode-headers)

  (fn csv.encode-table [destination headers source]
    (each [i header (ipairs headers)]
      (destination:write (. source header))
      (when (not (is-last i headers))
        (destination:write csv.separator))))
  (tset csv :encodeTable csv.encode-table)

  (fn csv.encode-tables [destination headers sequence]
    (each [i source (ipairs sequence)]
      (csv.encode-table destination headers source)
      (when (not (is-last i sequence))
        (destination:write csv.newline))))
  (tset csv :encodeTables csv.encode-tables)

  csv)
