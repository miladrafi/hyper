# <p align="center">**وان هایپر : ربات هایپر ساز**
<p align="center">**سورس رایگان و فارسی ساخت ربات هایپر ساز تلگرام**
<p align="center">ساخته شده با ♥ در ایران

***
####<p align="right">**: راهنمای نصب**

```bash
# ابتدا با کد زیر بسته پیش نیاز زبان برنامه نویسی لوآ را نصب میکنیم
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev
sudo apt-get install lua-socket
sudo apt-get install lua-sec
```

```bash
# حالا سورس را کلون میزنیم
git clone https://github.com/amirhmz/OneHyper.git
```

```bash
# توکن ربات را وارد میکنیم bot.lua سپس در فایل
local bot_api_key = "محل قرارگیری توکن ربات" -- token
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
local BASE_FOLDER = "" -- do not set this
```

```bash
# حالا ربات را اجرا میکنیم
cd OneHyper
lua bot.lua
```
***

####<p align="right">**: ارتباط با ما**
| Bot | Telegram Channel | Telegram Support | Email |
|---------|--------|-------| ----- |
| [Bot](https://telegram.me/OneHyperBot) | [Join](https://telegram.me/DarkTeam) | [AmirDark (Sudo)](http://telegram.me/AmirDark) :trollface: | [Email](mailto:amdark77@gmail.com) 

####<p align="center">**♥ !لذت ببرید**
