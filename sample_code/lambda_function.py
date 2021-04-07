from time import sleep

from selenium import webdriver
from selenium.webdriver.chrome.options import Options


def lambda_handler(event,context):
    # Headless Chromeを使うための設定を追加
    options = Options()
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument("--disable-application-cache")
    options.add_argument("--disable-infobars")
    options.add_argument("--no-sandbox")
    options.add_argument("--hide-scrollbars")
    # options.add_argument("--enable-logging")
    # options.add_argument("--log-level=0")
    # options.add_argument("--v=99")
    options.add_argument("--single-process")
    options.add_argument("--ignore-certificate-errors")


    # Headless Chromeを起動
    options.binary_location = "/opt/bin/headless-chromium"
    driver = webdriver.Chrome(executable_path="/opt/bin/chromedriver", chrome_options=options)
    driver = webdriver.Chrome(chrome_options=options)

    query = "プログラミング"
    url = "https://search.yahoo.co.jp/image/search?p={}".format(query)
    driver.get(url)

    driver.implicitly_wait(3)

    # 画像URLなどを取得する
    elements = driver.find_elements_by_class_name("sw-Thumbnail")

    d_list = []
    for i, e in enumerate(elements, start=1):
        name = f"{query}_{i}"
        raw_url = e.find_element_by_class_name("sw-ThumbnailGrid__details").get_attribute("href")
        yahoo_image_url = e.find_element_by_tag_name("img").get_attribute("src")
        title = e.find_element_by_tag_name("img").get_attribute("alt")

        d = {
            "filename": name,
            "raw_url": raw_url,
            "yahoo_image_url": yahoo_image_url,
            "title": title
        }

        d_list.append(d)

    # Chromeを閉じる
    driver.close()
    # ChromeDriverを終了する
    driver.quit()

    return d_list
