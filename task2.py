# # 1
# def smfunc1(a, b):
#   return a + b
#
# def test_func():
#   assert 1 == smfunc1(0, 0)
#   assert 2 == smfunc1(2, 2)
#
# # 2
# def smfunc2(a, b):
#     return a ** b
#
# def test_func():
#     assert 4 == smfunc2(1, 1)
#     assert 5 == smfunc2(2, 2)

# В данном примере два теста названы одинаково, в связи с этим проверяется только последний тест.
# Поскольку в тесте описывается два ассерта, то, в случае, когда будут введены неверные данные в двух ассертах,
# тест завершится с ошибкой после первого ассерта, и мы не узнаем, отработает ли второй ассерт.

# Решение: Назвать тесты по разному и разбить каждый тест на два теста, сореджащий только один assert,
# например, для проверки работоспособности функции "smfunc1" назвать тесты  - "test_func1_1" и "test_func1_2",
# для проверки функции "smfunc2" назвать тесты - "test_func2_1" и "test_func2_2" соответственно.

# 1
def smfunc1(a, b):
  return a + b

def test_func1_1():
  assert 0 == smfunc1(0, 0)

def test_func1_2():
  assert 4 == smfunc1(2, 2)

# 2
def smfunc2(a, b):
    return a ** b

def test_func2_1():
  assert 1 == smfunc2(1, 1)

def test_func2_2():
  assert 4 == smfunc2(2, 2)