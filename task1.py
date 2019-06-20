from selenium import webdriver

driver = webdriver.Chrome('E:\\bi_zone\\chromedriver_win32\\chromedriver.exe')
driver.get("http://localhost")

content = driver.find_element_by_css_selector('input.Login[type="text"]')

# Чтобы тест был более стабильным,
# в элемент можно добавить уникальный в пределах страницы атрибут id
# и искать его на странице по этому атрибуту

