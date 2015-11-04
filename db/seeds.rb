# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Link.destroy_all!

begin

  links = Link.create!([{ full_url: "http://google.com", access_count: rand(0..50) }, { full_url: "http://Facebook.com", access_count: rand(0..50) }, { full_url: "http://Youtube.com", access_count: rand(0..50) }, { full_url: "http://Baidu.com", access_count: rand(0..50) }, { full_url: "http://Yahoo.com", access_count: rand(0..50) }, { full_url: "http://Amazon.com", access_count: rand(0..50) }, { full_url: "http://Wikipedia.org", access_count: rand(0..50) }, { full_url: "http://Qq.com", access_count: rand(0..50) }, { full_url: "http://Twitter.com", access_count: rand(0..50) }, { full_url: "http://Google.co.in", access_count: rand(0..50) }, { full_url: "http://Taobao.com", access_count: rand(0..50) }, { full_url: "http://Live.com", access_count: rand(0..50) }, { full_url: "http://Sina.com.cn", access_count: rand(0..50) }, { full_url: "http://Linkedin.com", access_count: rand(0..50) }, { full_url: "http://Yahoo.co.jp", access_count: rand(0..50) }, { full_url: "http://Weibo.com", access_count: rand(0..50) }, { full_url: "http://Ebay.com", access_count: rand(0..50) }, { full_url: "http://Google.co.jp", access_count: rand(0..50) }, { full_url: "http://Yandex.ru", access_count: rand(0..50) }, { full_url: "http://Bing.com", access_count: rand(0..50) }, { full_url: "http://Vk.com", access_count: rand(0..50) }, { full_url: "http://Hao123.com", access_count: rand(0..50) }, { full_url: "http://Google.de", access_count: rand(0..50) }, { full_url: "http://Instagram.com", access_count: rand(0..50) }, { full_url: "http://T.co", access_count: rand(0..50) }, { full_url: "http://Msn.com", access_count: rand(0..50) }, { full_url: "http://Amazon.co.jp", access_count: rand(0..50) }, { full_url: "http://Google.co.uk", access_count: rand(0..50) }, { full_url: "http://Tmall.com", access_count: rand(0..50) }, { full_url: "http://Pinterest.com", access_count: rand(0..50) }, { full_url: "http://Wordpress.com", access_count: rand(0..50) }, { full_url: "http://Ask.com", access_count: rand(0..50) }, { full_url: "http://Reddit.com", access_count: rand(0..50) }, { full_url: "http://Blogspot.com", access_count: rand(0..50) }, { full_url: "http://Google.fr", access_count: rand(0..50) }, { full_url: "http://Mail.ru", access_count: rand(0..50) }, { full_url: "http://Paypal.com", access_count: rand(0..50) }, { full_url: "http://Google.com.br", access_count: rand(0..50) }, { full_url: "http://Apple.com", access_count: rand(0..50) }, { full_url: "http://Onclickads.net", access_count: rand(0..50) }, { full_url: "http://Tumblr.com", access_count: rand(0..50) }, { full_url: "http://Aliexpress.com", access_count: rand(0..50) }, { full_url: "http://Google.ru", access_count: rand(0..50) }, { full_url: "http://Microsoft.com", access_count: rand(0..50) }, { full_url: "http://Sohu.com", access_count: rand(0..50) }, { full_url: "http://Imgur.com", access_count: rand(0..50) }, { full_url: "http://Xvideos.com", access_count: rand(0..50) }, { full_url: "http://Google.it", access_count: rand(0..50) }, { full_url: "http://Imdb.com", access_count: rand(0..50) }, { full_url: "http://Google.es", access_count: rand(0..50) }, { full_url: "http://Netflix.com", access_count: rand(0..50) }, { full_url: "http://Gmw.cn", access_count: rand(0..50) }, { full_url: "http://Amazon.de", access_count: rand(0..50) }, { full_url: "http://360.cn", access_count: rand(0..50) }, { full_url: "http://Fc2.com", access_count: rand(0..50) }, { full_url: "http://Alibaba.com", access_count: rand(0..50) }, { full_url: "http://Stackoverflow.com", access_count: rand(0..50) }, { full_url: "http://Go.com", access_count: rand(0..50) }, { full_url: "http://Google.com.mx", access_count: rand(0..50) }, { full_url: "http://Ok.ru", access_count: rand(0..50) }, { full_url: "http://Google.ca", access_count: rand(0..50) }, { full_url: "http://Amazon.in", access_count: rand(0..50) }, { full_url: "http://Google.com.hk", access_count: rand(0..50) }, { full_url: "http://Tianya.cn", access_count: rand(0..50) }, { full_url: "http://Amazon.co.uk", access_count: rand(0..50) }, { full_url: "http://Craigslist.org", access_count: rand(0..50) }, { full_url: "http://Naver.com", access_count: rand(0..50) }, { full_url: "http://Rakuten.co.jp", access_count: rand(0..50) }, { full_url: "http://Blogger.com", access_count: rand(0..50) }, { full_url: "http://Diply.com", access_count: rand(0..50) }, { full_url: "http://Google.com.tr", access_count: rand(0..50) }, { full_url: "http://Flipkart.com", access_count: rand(0..50) }, { full_url: "http://Xhamster.com", access_count: rand(0..50) }, { full_url: "http://Espn.go.com", access_count: rand(0..50) }, { full_url: "http://Soso.com", access_count: rand(0..50) }, { full_url: "http://Outbrain.com", access_count: rand(0..50) }, { full_url: "http://Nicovideo.jp", access_count: rand(0..50) }, { full_url: "http://Cnn.com", access_count: rand(0..50) }, { full_url: "http://Google.co.id", access_count: rand(0..50) }, { full_url: "http://Googleadservices.com", access_count: rand(0..50) }, { full_url: "http://Dropbox.com", access_count: rand(0..50) }, { full_url: "http://Googleusercontent.com", access_count: rand(0..50) }, { full_url: "http://Google.co.kr", access_count: rand(0..50) }, { full_url: "http://Github.com", access_count: rand(0..50) }, { full_url: "http://Bongacams.com", access_count: rand(0..50) }, { full_url: "http://Xinhuanet.com", access_count: rand(0..50) }, { full_url: "http://Kat.cr", access_count: rand(0..50) }, { full_url: "http://Bbc.co.uk", access_count: rand(0..50) }, { full_url: "http://Ebay.de", access_count: rand(0..50) }, { full_url: "http://Google.pl", access_count: rand(0..50) }, { full_url: "http://Google.com.au", access_count: rand(0..50) }, { full_url: "http://Pixnet.net", access_count: rand(0..50) }, { full_url: "http://Ebay.co.uk", access_count: rand(0..50) }, { full_url: "http://Popads.net", access_count: rand(0..50) }, { full_url: "http://Sogou.com", access_count: rand(0..50) }, { full_url: "http://Tradeadexchange.com", access_count: rand(0..50) }, { full_url: "http://Dailymotion.com", access_count: rand(0..50) }, { full_url: "http://Adobe.com", access_count: rand(0..50) }, { full_url: "http://Adnetworkperformance.com", access_count: rand(0..50) }, { full_url: "http://Nytimes.com", access_count: rand(0..50) }])


rescue ActiveRecord::RecordInvalid => invalid
  puts "ActiveRecord::RecordInvalid: #{invalid}" 
  p invalid.record
end