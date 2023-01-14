(ns day01_test
  (:require [clojure.test :refer [deftest, is]]))

(deftest addition-tests
  (is (= 5 (+ 3 2)))
  (is (= 10 (+ 5 6))))

(clojure.test/run-tests 'day01)