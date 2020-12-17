import requests
import codecs
from parsel import Selector
from multiprocessing import Lock

user_agent = 'curl/1.0'

files_url_list = []
files_url_list_mutex = Lock()


def get_sub_urls(__url__):
    print('==>', __url__)
    req = requests.get(__url__, headers={'User-Agent': user_agent})
    content = codecs.decode(req.content, 'utf-8', 'ignore')
    selector = Selector(content)
    urls_result = selector.xpath('//tr/td[@class="link"]/a/@href').extract()
    urls = []
    for url_result in urls_result:
        if url_result not in ['..', '../']:
            urls.append(__url__ + url_result)
    for url in urls:
        if url[len(url) - 1] == '/':
            get_sub_urls(url)
        else:
            files_url_list.append(url)
            print(url)


def main():
    get_sub_urls('https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/')
    files_url_list.sort()
    urls_file = open('urls.txt', 'w')
    for url in files_url_list:
        urls_file.write(url + '\n')
    urls_file.close()


if __name__ == '__main__':
    main()
