;;; This module contains general utility functions.
(local bluefin {})


(fn bluefin.reduce [iterator collection initial-value transform]
  "Reduce a collection, such that each element in the `collection' is processed
and possibly integrated into the outcome (return value). It uses the supplied
`iterator' to step through the `collection'. The most common iterators are
probably `pairs' and `ipairs'. The `collection' can be anything that the
`iterator' can enumerate, but most often, it's a simple `table'. `initial-value'
is the value used to initialize the accumulator. This is rebinded for each
iteration. The `transform' is a function of the following
signature: (accumulator value key) -> next-accumulator"
  (var accumulator initial-value)
  (each [k v (iterator collection)]
    (transform accumulator v k))
  accumulator)

(fn bluefin.mutate [root key transform]
  "Mutate the value found at root[key] by invoking `transform' with the value
and assigning the result to root[key], i.e. root[key] = transform(root[key]).
`transform' is supplied with the root and key too, for good measure."
  (let [result (transform (. root key) root key)]
    (tset root key result)
    result))

bluefin
