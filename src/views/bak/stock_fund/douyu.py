import time

from selenium import webdriver

class Douyu(object):
    def __init__(self):
        self.url = 'https://www.douyu.com/directory/all'
        self.driver = webdriver.Chrome()
    def parse_data(self):
        room_list = self.driver.find_elements_by_xpath('//*[@id="listAll"]/section[2]/div[2]/ul/li/div')
        print(len(room_list))
        # 遍历房间列表 从每1节点取数
        for room in room_list:
            temp = {}
            # //*[@id="listAll"]/section[1]/div[2]/ul/li/div/a
            # //*[@id="listAll"]/section[1]/div[2]/ul/li[1]/div/a/div[2]/div[1]/h3
            # //*[@id="listAll"]/section[1]/div[2]/ul/li[1]/div/a/div[2]/div[1]/h3
            temp['title'] = room.find_element_by_xpath('./a/div[2]/div[1]/h3').text
            print(temp)
    def run(self):
        self.driver.get(self.url)
        self.parse_data()
if __name__ == '__main__':
    douyu = Douyu()
    douyu.run()