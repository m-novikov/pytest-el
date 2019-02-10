def test_func():
    pass


def test_func_with_inner():
    def inner_func():
        # inside_inner
        pass

    # after_inner
    def foo():
        pass


class TestA:
    # inside_class
    def test_func(self):
        # inside_class_method
        pass

    class TestInner:
        # inside_inner_class

        def test_false(self):
            # inside_innerclass_func
            assert False


if True:
    def test_under():
        # under_flag
        pass
