;;; pytest-el-test.el --- Tests for pytest-el

;;; pytest-el-test.el ends here
(require 'pytest)

(defun locate-test (name)
  (should (search-forward name)))


(ert-deftest detect-single-function-name ()
  (find-file "test/data/test_sample.py")
  (locate-test "def test_func")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func$" (pytest-test-name)))
    (should (eq start (point)))))


(ert-deftest test-with-inner-func ()
  (find-file "test/data/test_sample.py")
  (locate-test "def inner_func")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func_with_inner$" (pytest-test-name)))
    (should (eq start (point))))

  (locate-test "inside_inner")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func_with_inner$" (pytest-test-name)))
    (should (eq start (point)))))


(ert-deftest test-class-method ()
  (find-file "test/data/test_sample.py")
  (locate-test "inside_class_method")
  (let ((start (point)))
    (should (string-match "test_sample.py::TestA::test_func$" (pytest-test-name)))
    (should (eq start (point)))))


(ert-deftest test-single-class ()
  (find-file "test/data/test_sample.py")
  (locate-test "inside_class")
  (let ((start (point)))
    (should (string-match "test_sample.py::TestA$" (pytest-test-name)))
    (should (eq start (point)))))
