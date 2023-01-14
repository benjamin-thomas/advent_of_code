(require '[clojure.string :as str])

(def input "1
2

3
4

5")

(def consume (fn [str] (->>
                        (str/split str #"\n\n")
                        (map #(->>
                               (str/split %1 #"\n")
                               (map read-string)
                               (reduce +)))
                        (sort)
                        (reverse))))

(defn consume2 [str] (->>
                      (str/split str #"\n\n")
                      (map #(->>
                             (str/split %1 #"\n")
                             (map read-string)
                             (reduce +)))
                      (sort)
                      (reverse)))

(consume2 input)
(ns day01
  (:require [clojure.test :refer [deftest, is]]))

(deftest addition-tests
  (is (= 5 (+ 3 2)))
  (is (= 10 (+ 5 5))))

