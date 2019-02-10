;;; pytest-el-test.el --- Tests for pytest-el

;;; pytest-el-test.el ends here
(require 'pytest)

(defun locate-test (name)
  (find-file "test/data/test_sample.py")
  (goto-char 1)
  (should (search-forward name)))

(ert-deftest detect-single-function-name ()
  (locate-test "def test_func")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func$" (pytest-test-name)))
    (should (eq start (point)))))

(ert-deftest test-with-inner-func ()
  (locate-test "def inner_func")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func_with_inner$" (pytest-test-name)))
    (should (eq start (point))))

  (locate-test "inside_inner")
  (let ((start (point)))
    (should (string-match "test_sample.py::test_func_with_inner$" (pytest-test-name)))
    (should (eq start (point)))))

(ert-deftest test-single-class ()
  (locate-test "inside_class")
  (let ((start (point)))
    (should (string-match "test_sample.py::TestA$" (pytest-test-name)))
    (should (eq start (point)))))

(ert-deftest test-nested-class ()
  (locate-test "inside_inner_class")
  (let ((start (point)))
    (should (string-match "test_sample.py::TestA::TestInner$" (pytest-test-name)))
    (should (eq start (point)))))

(ert-deftest test-nested-class-method ()
  (locate-test "inside_innerclass_func")
  (let ((start (point)))
    (should (string-match
             "test_sample.py::TestA::TestInner::test_false$"
             (pytest-test-name)))
    (should (eq start (point)))))

(ert-deftest test-class-method ()
  (locate-test "inside_class_method")
  (let ((start (point)))
    (should (string-match "test_sample.py::TestA::test_func$" (pytest-test-name)))
    (should (eq start (point)))))

;;TODO: If definition after class
;; (ert-deftest test-under-flag ()
;;   (locate-test "under_flag")
;;   (let ((start (point)))
;;     (should (string-match "test_sample.py::test_under$" (pytest-test-name)))
;;     (should (eq start (point)))))
