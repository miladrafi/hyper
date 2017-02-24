package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
JSON = require('dkjson')
HTTPS = require('ssl.https')
----config----
local bot_api_key = "371083291:AAHuXe2jO7mjlRQuRpuyc5oXl-SNjM0J_3g"--توکن بوت را درون " قرار دهید --
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
local BASE_FOLDER = ""
local start = [[
سلامـ 😊✋
من ربات هایپر ساز  هستم :)

به کمک من متن های تبلیغاتی
هایپر دار ایجاد و شیر کنید 🤔

درضمن علاوه بر ساخت هایپر میتوانید استیکر به عکس و عکس به استیکر را به راحتی تبدیل کنید :
*🔸 ارسال استیکر برای من*
🌋 تحویل به صورت تصویر

*🔸 ارسال تصویر برای من*
🏙 تحویل به صورت استیکر


📝 دستورات جهت ساخت متن های هایپر :

/hyper [test]
- test

/hyper [*test*]
- *test*

/hyper [_test_]
- _test_

/hyper [[text](url)](url)
- [OneHyper](OneHyper.com)

*🏵 مثال :*

/hyper [Hi]
[*I'm a api bot* ]
[_M.r bot  created me_]
[[M.r bot admin](test)][(http://t.me/hyper_mr_bot)]

*🏵 نتیجه :*

Hi
*I'm a bot* 
_M.r bot  created me_
[M.r bot admin](http://t.me/hyper_mr_bot)





_ساخته شده توسط M.r_
]] 

-------

----utilites----

function is_admin(msg)-- Check if user is admin or not
  local var = false
  local admins = {94746365}-- put your id here
  for k,v in pairs(admins) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end

function sendRequest(url)
  local dat, res = HTTPS.request(url)
  local tab = JSON.decode(dat)

  if res ~= 200 then
    return false, res
  end

  if not tab.ok then
    return false, tab.description
  end

  return tab

end

function getMe()--https://core.telegram.org/bots/api#getfile
    local url = BASE_URL .. '/getMe'
  return sendRequest(url)
end

function getUpdates(offset)--https://core.telegram.org/bots/api#getupdates

  local url = BASE_URL .. '/getUpdates?timeout=20'

  if offset then

    url = url .. '&offset=' .. offset

  end

  return sendRequest(url)

end
sendSticker = function(chat_id, sticker, reply_to_message_id)

	local url = BASE_URL .. '/sendSticker'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'
-- 
	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	io.popen(curl_command):read("*all")
	return end

sendPhoto = function(chat_id, photo, caption, reply_to_message_id)

	local url = BASE_URL .. '/sendPhoto'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end

	io.popen(curl_command):read("*all")
	return end

forwardMessage = function(chat_id, from_chat_id, message_id)

	local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id

	return sendRequest(url)

end

function sendMessage(chat_id, text, disable_web_page_preview, reply_to_message_id, use_markdown)--https://core.telegram.org/bots/api#sendmessage

	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	if disable_web_page_preview == true then
		url = url .. '&disable_web_page_preview=true'
	end

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	if use_markdown then
		url = url .. '&parse_mode=Markdown'
	end

	return sendRequest(url)

end
function sendDocument(chat_id, document, reply_to_message_id)--https://github.com/topkecleon/otouto/blob/master/bindings.lua

	local url = BASE_URL .. '/sendDocument'

	local curl_command = 'cd \''..BASE_FOLDER..currect_folder..'\' && curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end
	io.popen(curl_command):read("*all")
	return

end
function download_to_file(url, file_name, file_path)--https://github.com/yagop/telegram-bot/blob/master/bot/utils.lua
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = BASE_FOLDER..currect_folder..file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
--------

function bot_run()
	bot = nil

	while not bot do -- Get bot info
		bot = getMe()
	end

	bot = bot.result

	local bot_info = "نام کاربری = @"..bot.username.."\nنام ربات = "..bot.first_name.."\nیوزر آی دی = "..bot.id.." \nسورس هایپر\nسازنده : @mr_bot_admin"

	print(bot_info)

	last_update = last_update or 0

	is_running = true

	currect_folder = ""
end

function msg_processor(msg)
	if msg.new_chat_participant or msg.new_chat_title or msg.new_chat_photo or msg.left_chat_participant then return end
	if msg.audio or msg.document or msg.video or msg.voice then return end -- Admins only !
	if msg.date < os.time() - 5 then -- Ignore old msgs
		return
    end

  if msg.sticker then
  local matches = { (msg.sticker) }
	file = msg.sticker.file_id
	local url = BASE_URL .. '/getFile?file_id='..file
	local res = HTTPS.request(url)
	local jres = JSON.decode(res)
	filename = "sticker.png"
	file = download_to_file("https://api.telegram.org/file/bot"..bot_api_key.."/"..jres.result.file_path, filename)
	sendPhoto(msg.chat.id, file)

  

  elseif msg.photo then
	local matches = { (msg.photo) }
	file = msg.photo[3].file_id
	local url = BASE_URL .. '/getFile?file_id='..file
	local res = HTTPS.request(url)
	local jres = JSON.decode(res)
	filename = "photo.jpg"
	file = download_to_file("https://api.telegram.org/file/bot"..bot_api_key.."/"..jres.result.file_path, filename)
	sendSticker(msg.chat.id, file)
  
  if msg.text then return end
  
 
 elseif msg.text:match("/hyper (.*)") then
 local matches = { string.match(msg.text, "/hyper (.*)") }
 local text = ''..matches[1]..''
 sendMessage(msg.chat.id, text, true, false, true)

elseif msg.text:match("^/[sS]tart") or msg.text:match("^/[Hh]elp") then
 sendMessage(msg.chat.id, start, true, false, true)

elseif msg.text:match("^/[aA][bB][oO][uU][tT]") or msg.text:match("^/[aA]bout") then
  sendMessage(msg.chat.id, [[این ربات برای استفاده عمومی کاربران تلگرام راه اندازی شده است .
محتوای تولید شده توسط این ربات , توسط کاربران تولید شده و ربات  *هیچ مسئولیتی* ندارد. 
سازنده ربات :[میلاد رفیع](https://t.me/mr_bot_admin)]], true, false, true) 
elseif msg.text:match("^/[aA][dD][mM][iI][nN]") or msg.text:match("^/[rR][aA][fF][iI]") then
  sendMessage(msg.chat.id, [[[جهت ارتباط با مدیر ضربه بزنید. ](https://t.me/pvadmin_mr_bot)]], true, false, true)

return end


end
bot_run() -- Run main function
while is_running do -- Start a loop witch receive messages.
	local response = getUpdates(last_update+1) -- Get the latest updates using getUpdates method
	if response then
		for i,v in ipairs(response.result) do
			last_update = v.update_id
			msg_processor(v.message)
		end
	else
		print("Conection failed")
	end

end
print("Bot halted")
