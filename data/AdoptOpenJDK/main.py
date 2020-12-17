#!/usr/bin/env python3.9

"""
Get all files' url from a link
"""

import requests
import codecs
from parsel import Selector
import time
import threading
from multiprocessing import Lock

user_agent = 'curl/1.0'

files_url_list = []
files_url_list_mutex = Lock()


def get_sub_urls(__url__):
    req = requests.get(__url__, headers={'User-Agent': user_agent})
    content = codecs.decode(req.content, 'utf-8', 'ignore')
    selector = Selector(content)
    urls_result = selector.xpath('//tr/td[@class="link"]/a/@href').extract()
    urls = []
    for url_result in urls_result:
        if url_result not in ['..', '../']:
            urls.append(__url__ + url_result)
    threads = []
    for url in urls:
        if url[len(url) - 1] == '/':
            t = threading.Thread(target=get_sub_urls, args=(url,))
            t.start()
            threads.append(t)
        else:
            files_url_list_mutex.acquire()
            files_url_list.append(url)
            files_url_list_mutex.release()
    for t in threads:
        t.join()


def main():
    get_sub_urls('https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/')
    files_url_list.sort()
    urls_file = open('urls.txt', 'w')
    for url in files_url_list:
        urls_file.write(url + '\n')
    urls_file.close()


if __name__ == '__main__':
    main()
