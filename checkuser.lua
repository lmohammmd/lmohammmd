local tdlib = require("tdlib");
tdlib.set_config({
	api_id = Config.ApiID,
	api_hash = Config.ApiHash,
	session_name = Config.SessionApi
});
local TD = tdlib.get_functions();
local Bot_iD, TOKNE_ID = string.match(Config.JoinToken, "(%d+):(%S+)");
local _ = {
	process = 0,
	auto_run = 0
};
local Bot_Api = "https://api.telegram.org/bot" .. Config.JoinToken;
local BASSE = "https://api.telegram.org/bot" .. Config.JoinToken;
local json = dofile("./Lib/JSON.lua");
local JSON = (loadfile("./Lib/dkjson.lua"))();
local utf8 = dofile("./Lib/utf8.lua");
local dkjson = dofile("./Lib/dkjson.lua");
local serpent = dofile("./Lib/serpent.lua");
local base = dofile("./Lib/redis.lua");
local http = require("socket.http");
local https = require("ssl.https");
local URL = require("socket.url");
local BotJoiner = Config.BotJoiner
local TD_ID = Config.TD_ID;
base:select(Config.RedisIndex);
local StringData = function(str)
	local BadChars = {
		"%",
		"$"
	};
	local rstr = "";
	for k in string.gmatch(str, ".") do
		for x, y in pairs(BadChars) do
			if y == k then
				if k == "%" then
					k = "٪";
				elseif k == "$" then
					k = "&&";
				end;
				break;
			end;
		end;
		rstr = rstr .. k;
	end;
	return rstr;
end;
local Alpha = function(num)
	list = {
		"０",
		"１",
		"２",
		"３",
		"４",
		"５",
		"６",
		"７",
		"８",
		"９"
	}
	out = tonumber(num)
	out = tostring(out)
	for i = 1, 10 do
		out = string.gsub(out, i - 1, list[i])
	end
	return out
end
local sendBot = function(chat, reply_to_message_id, text, parse_mode, callback, data)
	local input_message_content = {
		["@type"] = "inputMessageText",
		disable_web_page_preview = true,
		text = {
			text = text
		},
		clear_draft = false
	};
	TD.sendMessage(chat, reply_to_message_id, input_message_content, parse_mode, false, true, nil, callback or dl_cb, data or nil);
end;
local is_PrivateMem = function(msg, user_id)
	user_id = user_id or 0
	local PrivateMem = base:sismember("PrivateMemeber:", user_id)
	if PrivateMem then
		return true
	else
		return false
	end
end

function promotemember(chat_id, user_id, canchangeinfo, canpostmessages, caneditmessages, candeletemessages, caninviteusers, canrestrictmembers, canpinmessages, canpromotemembers,canmanagevideochats)
	local Rep = Bot_Api .. "/promoteChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_change_info=" .. canchangeinfo .. "&can_post_messages=" .. canpostmessages .. "&can_edit_messages=" .. caneditmessages .. "&can_delete_messages=" .. candeletemessages .. "&can_invite_users=" .. caninviteusers .. "&can_restrict_members=" .. canrestrictmembers .. "&can_pin_messages=" .. canpinmessages .. "&can_promote_members=" .. canpromotemembers .."&can_manage_video_chats=" .. canmanagevideochats;
	return https.request(Rep);
end;

local MuteUser = function(chat_id, user_id, time)
	local Rep = Bot_Api .. "/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_post_messages=false&until_date=" .. time;
	return https.request(Rep);
end;
local kickChatMemberTime = function(chat_id, user_id, time)
	local Rep = Bot_Api .. "/kickChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&until_date=" .. time;
	return https.request(Rep);
end;
local KickUser = function(chat_id, user_id)
	local Rep = Bot_Api .. "/kickChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id;
	return https.request(Rep);
end;
local UnRes = function(chat_id, user_id)
	local Rep = Bot_Api .. "/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_post_messages=true&can_add_web_page_previews=true&can_send_other_messages=true&can_send_media_messages=true";
	return https.request(Rep);
end;
local MuteUser2 = function(chat_id, user_id, time)
	local Rep = Bot_Api .. "/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_send_media_messages=false&until_date=" .. time;
	return https.request(Rep);
end;
local MuteMedia = function(chat_id, user_id)
	local Rep = Bot_Api .. "/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_post_messages=true&can_add_web_page_previews=true&can_send_other_messages=false&can_send_media_messages=false";
	return https.request(Rep);
end;
local MuteMediaTime = function(chat_id, user_id, time)
	local Rep = Bot_Api .. "/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_post_messages=true&can_add_web_page_previews=true&can_send_other_messages=false&can_send_media_messages=false&until_date=" .. time;
	return https.request(Rep);
end;
local SetAdmins = function(chat_id, user_id)
	local Rep = Bot_Api .. "/promoteChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_change_info=true&can_pin_messages=true&can_restrict_members=true&can_invite_users=true&can_delete_messages=true";
	return https.request(Rep);
end;
local membersCount = function(chat_id)
	local Rep = Bot_Api .. "/getChatMembersCount?chat_id=" .. chat_id;
	return https.request(Rep);
end;
local Forward = function(chat_id, from_chat_id, message_id)
	local url = Bot_Api .. "/forwardMessage?chat_id=" .. chat_id .. "&from_chat_id=" .. from_chat_id .. "&message_id=" .. message_id;
	return https.request(url);
end;
local remadmins = function(chat_id, user_id)
	local Rep = Bot_Api .. "/promoteChatMember?chat_id=" .. chat_id .. "&user_id=" .. user_id .. "&can_change_info=false&can_pin_messages=false&can_restrict_members=false&can_invite_users=false&can_delete_messages=false";
	return https.request(Rep);
end;
local sendMedia = function(chat_id, file_id, reply_to_message_id, caption, parse_mode, media)
	if media and string.lower(media) == "video" then
		Method, Parameter = "sendVideo", "video";
	elseif media and string.lower(media) == "videonote" then
		Method, Parameter = "sendVideoNote", "video_note";
	elseif media and string.lower(media) == "voice" then
		Method, Parameter = "sendVoice", "voice";
	elseif media and string.lower(media) == "photo" then
		Method, Parameter = "sendPhoto", "photo";
	else
		Method, Parameter = "sendDocument", "document";
	end;
	local url = BASSE .. "/" .. Method .. "?chat_id=" .. chat_id .. "&reply_to_message_id=" .. reply_to_message_id .. "&" .. Parameter .. "=" .. file_id .. "&caption=" .. URL.escape(caption);
	if parse_mode == "html" or parse_mode == "markdown" then
		url = url .. "&parse_mode=Markdown";
	elseif parse_mode == "html" then
		url = url .. "&parse_mode=HTML";
	end;
	return https.request(url);
end;
local reportowner = function(text)
	if reportpv then
		local data = (TD.getChatAdministrators(chat)).administrators;
		for m, n in ipairs(data) do
			if n.user_id then
				if n.is_owner == true then
					owner_id = n.user_id;
					sendBot(owner_id, 0, text, "html");
				end;
			end;
		end;
	end;
end;
local SudUser = function(msg,user_id)
	user_id = user_id or 0;
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if Sudo then
		return true;
	else
		return false;
	end;
end;
local OwnUser = function(msg,user_id)
	user_id = user_id or 0;
	local Owner = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, user_id);
	if Owner then
		return true;
	else
		return false;
	end;
end;
local NazemUser = function(msg,user_id)
	user_id = user_id or 0;
	local Owner = base:sismember(TD_ID .. "NazemList:" .. msg.chat_id, user_id);
	if Owner then
		return true;
	else
		return false;
	end;
end;
local OwnUserPlus = function(msg,user_id)
	user_id = user_id or 0;
	local OwnerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. msg.chat_id, user_id);
	if OwnerPlus then
		return true;
	else
		return false;
	end;
end;
local ModUser = function(msg,user_id)
	user_id = user_id or 0;
	local Mod = base:sismember(TD_ID .. "ModList:" .. msg.chat_id, user_id);
	if Mod then
		return true;
	else
		return false;
	end;
end;
local VipUser = function(msg,user_id)
	user_id = user_id or 0;
	local vip = base:sismember(TD_ID .. "Vip:" .. msg.chat_id, user_id);
	if vip then
		return true;
	else
		return false;
	end;
end;
local ModUserTest = function(msg,user_id)
	user_id = user_id or 0;
	local Mod = base:sismember(TD_ID .. "ModListtest:" .. msg.chat_id, user_id);
	if Mod then
		return true;
	else
		return false;
	end; 
end;
function Setsudo (msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if base:sismember(TD_ID .. "SUDO", user) then
		sendBot(chat, msg.id, "<b>✅ کاربر 〚 " .. ID .. " 〛 در لیست سودو ها می باشد!</b>\n┈┅┅━تنظیم سودو━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
	else
		sendBot(chat, msg.id, "<b>✅ کاربر 〚 " .. ID .. " 〛 به لیست سودو اضافه شد.</b>\n┈┅┅━تنظیم سودو━┅┅┈\n 👮‍♀️توسط : "..IDsender.."", "html");
		base:sadd(TD_ID .. "SUDO", user);
	end;
end;
 function Remsudo(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if not base:sismember((TD_ID .. "SUDO"), user) then
		sendBot(chat, msg.id, " <b>☑️ کاربر 〚 " .. ID .. " 〛 در لیست سودو ها نمی باشد!</b> \n┈┅┅━حذف سودو━┅┅┈\n 👮‍♀️توسط : "..IDsender.."", "html");
	else
		sendBot(chat, msg.id, " <b>☑️ کاربر 〚 " .. ID .. " 〛 از لیست سودو حذف شد.</b>\n┈┅┅━حذف سودو━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
		base:srem(TD_ID .. "SUDO", user);
	end;
end;

function Rid(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if not base:sismember("AGTMute:", user) and (not base:sismember((TD_ID .. "messageDocument:" .. chat), user)) and (not base:sismember((TD_ID .. "messageVideo:" .. chat), user)) and (not base:sismember((TD_ID .. "messageVideoNote:" .. chat), user)) and (not base:sismember((TD_ID .. "messageAudio:" .. chat), user)) and (not base:sismember((TD_ID .. "messageAnimation:" .. chat), user)) and (not base:sismember((TD_ID .. "messageSticker:" .. chat), user)) and (not base:sismember((TD_ID .. "BanUser:" .. chat), user)) and (not base:sismember((TD_ID .. "SilentList:" .. chat), user)) and (not base:sismember((TD_ID .. "MuteList:" .. chat), user)) and (not base:sismember(("GlobalyBanned:"), user)) and (not base:sismember((TD_ID .. "MutemediaList:" .. chat), user)) then
		sendBot(chat, msg.id, " <b>✅ کاربر 〚 "..ID.." 〛 از تمام محدودیت ها رهایی یافت.</b>\n┈┅┅━رهایی کلی━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		UnRes(chat, user);
				base:srem("AGTMute:", user);
		base:srem(TD_ID .. "messageSticker:" .. chat, user);
		base:srem(TD_ID .. "messageAnimation:" .. chat, user);
		base:srem(TD_ID .. "messageAudio:" .. chat, user);
		base:srem(TD_ID .. "messageVideoNote:" .. chat, user);
		base:srem(TD_ID .. "messageVideo:" .. chat, user);
		base:srem(TD_ID .. "messageDocument:" .. chat, user);
		base:srem(TD_ID .. "BanUser:" .. chat, user);
		base:srem(TD_ID .. "SilentList:" .. chat, user);
		base:srem(TD_ID .. "MuteList:" .. chat, user);
		base:srem(TD_ID .. "MutemediaList:" .. chat, user);
		base:srem( "GlobalyBanned:", user);
		UnRes(chat, user);
	else
		sendBot(chat, msg.id, " <b>✅ کاربر 〚 "..ID.." 〛 از تمام محدودیت ها رهایی یافت.</b>\n┈┅┅━رهایی کلی━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		base:srem("AGTMute:", user);
		base:srem(TD_ID .. "messageSticker:" .. chat, user);
		base:srem(TD_ID .. "messageAnimation:" .. chat, user);
		base:srem(TD_ID .. "messageAudio:" .. chat, user);
		base:srem(TD_ID .. "messageVideoNote:" .. chat, user);
		base:srem(TD_ID .. "messageVideo:" .. chat, user);
		base:srem(TD_ID .. "messageDocument:" .. chat, user);
		base:srem(TD_ID .. "BanUser:" .. chat, user);
		base:srem(TD_ID .. "SilentList:" .. chat, user);
		base:srem(TD_ID .. "MuteList:" .. chat, user);
		base:srem(TD_ID .. "MutemediaList:" .. chat, user);
		base:srem( "GlobalyBanned:", user);
		UnRes(chat, user);
	end;
end;

function Ridall(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if not base:sismember("AGTMute:", user) and (not base:sismember((TD_ID .. "messageDocument:" .. chat), user)) and (not base:sismember((TD_ID .. "messageVideo:" .. chat), user)) and (not base:sismember((TD_ID .. "messageVideoNote:" .. chat), user)) and (not base:sismember((TD_ID .. "messageAudio:" .. chat), user)) and (not base:sismember((TD_ID .. "messageAnimation:" .. chat), user)) and (not base:sismember((TD_ID .. "messageSticker:" .. chat), user)) and (not base:sismember((TD_ID .. "BanUser:" .. chat), user)) and (not base:sismember((TD_ID .. "SilentList:" .. chat), user)) and (not base:sismember((TD_ID .. "MuteList:" .. chat), user)) and (not base:sismember(("GlobalyBanned:"), user)) and (not base:sismember((TD_ID .. "MutemediaList:" .. chat), user)) then
		sendBot(chat, msg.id, " <b>✅ کاربر 〚 "..ID.." 〛 از تمام محدودیت ها رهایی یافت.</b>\n┈┅┅━رهایی━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		UnRes(chat, user);
		
		base:srem(TD_ID .. "messageSticker:" .. chat, user);
		base:srem(TD_ID .. "messageAnimation:" .. chat, user);
		base:srem(TD_ID .. "messageAudio:" .. chat, user);
		base:srem(TD_ID .. "messageVideoNote:" .. chat, user);
		base:srem(TD_ID .. "messageVideo:" .. chat, user);
		base:srem(TD_ID .. "messageDocument:" .. chat, user);
		base:srem(TD_ID .. "BanUser:" .. chat, user);
		base:srem(TD_ID .. "SilentList:" .. chat, user);
		base:srem(TD_ID .. "MuteList:" .. chat, user);
		base:srem(TD_ID .. "MutemediaList:" .. chat, user);
	
		UnRes(chat, user);
	else
		sendBot(chat, msg.id, " <b>✅ کاربر 〚 "..ID.." 〛 از تمام محدودیت ها رهایی یافت.</b>\n┈┅┅━رهایی کلی━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		
		base:srem(TD_ID .. "messageSticker:" .. chat, user);
		base:srem(TD_ID .. "messageAnimation:" .. chat, user);
		base:srem(TD_ID .. "messageAudio:" .. chat, user);
		base:srem(TD_ID .. "messageVideoNote:" .. chat, user);
		base:srem(TD_ID .. "messageVideo:" .. chat, user);
		base:srem(TD_ID .. "messageDocument:" .. chat, user);
		base:srem(TD_ID .. "BanUser:" .. chat, user);
		base:srem(TD_ID .. "SilentList:" .. chat, user);
		base:srem(TD_ID .. "MuteList:" .. chat, user);
		base:srem(TD_ID .. "MutemediaList:" .. chat, user);
		
		UnRes(chat, user);
	end;
end;

function BanallUser(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "  <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان بن ال کردن ندارید! ", "html");
	elseif tonumber(user) == tonumber(2076851562) then
		sendBot(chat, msg.id, "  <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 توسعه دهنده ربات می باشد امکان بن ال کردن ندارید! ", "html");
	
	elseif is_PrivateMem(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 شما دسترسی به انجام این کار را ندارید ! ", "html");
		return false;
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد امکان عزل بن ال ندارید!  ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 افتخاری می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر 〚 "..ID.." 〛عضو ویژه گروه می باشد امکان بن ال کردن ندارید! ", "html");
		return false;
	else

		if base:sismember("GlobalyBanned:", user) then
			sendBot(chat, msg.id, "<b>✅ کاربر 〚"..ID.." 〛 در لیست مسدودین کلی وجود دارد !</b>\n┈┅┅━بن ال━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
		else
			sendBot(chat, msg.id, " <b>✅ کاربر 〚 "..ID.." 〛از همه گروه های ربات مسدود شد !</b>\n┈┅┅━بن ال━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
			base:sadd("GlobalyBanned:", user);
			KickUser(chat, user);
			TD.setChatMemberStatus(chat, user, "banned");
		end;
	end;
end;
function UnbanallUser(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:sismember("GlobalyBanned:", user) then
		sendBot(chat, msg.id, " <b>☑️ کاربر 〚 "..ID.." 〛 مسدود سراسری نمی باشد !</b> \n┈┅┅━حذف بن ال━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
	else
		sendBot(chat, msg.id, "<b>☑️ کاربر 〚 "..ID.." 〛 از لیست مسدود سراسری حذف شد !</b>\n┈┅┅━حذف بن ال━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		base:srem("GlobalyBanned:", user);
	end;
end;
function PrivateMemeber(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:sismember("PrivateMemeber:", user) then
		sendBot(chat, msg.id, " <b>✅ کاربر 〚 " .. ID.. " 〛 در لیست کاربران اختصاصی نمی باشد !</b>\n┈┅┅━اختصاصی━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
	else
		sendBot(chat, msg.id, "<b>✅ کاربر 〚 " .. ID .. " 〛 از لیست کاربران اختصاصی حذف شد !</b>\n┈┅┅━اختصاصی━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
		base:srem("PrivateMemeber:", user);
	end;
end;




 function Statususer(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(Config.Sudoid) then
		Sudoide = "✓";
	else
		Sudoide = "✗";
	end;
	if not base:sismember("AGTMute:", user) then
		AGTMute = "✗";
	else
		AGTMute = "✓";
	end;
	if not base:sismember(("GlobalyBanned:"), user) then
		GlobalyBanned = "✗";
	else
		GlobalyBanned = "✓";
	end;
	if not base:sismember((TD_ID .. "BanUser:" .. chat), user) then
		BanUser = "✗";
	else
		BanUser = "✓";
	end;
	if not base:sismember((TD_ID .. "MuteList:" .. chat), user) then
		MuteList = "✗";
	else
		MuteList = "✓";
	end;
	if not base:sismember((TD_ID .. "MuteMediaList:" .. chat), user) then
		MuteMediaList = "✗";
	else
		MuteMediaList = "✓";
	end;
	if not base:sismember((TD_ID .. "SUDO"), user) then
		SUDOid = "✗";
	else
		SUDOid = "✓";
	end;
	if not base:sismember((TD_ID .. "OwnerListPlus:" .. chat), user) then
		OwnerListPlus = "✗";
	else
		OwnerListPlus = "✓";
	end;
	if not base:sismember((TD_ID .. "OwnerList:" .. chat), user) then
		OwnerList = "✗";
	else
		OwnerList = "✓";
	end;
	if not base:sismember((TD_ID .. "NazemList:" .. chat), user) then
		NazemList = "✗";
	else
		NazemList = "✓";
	end;
	if not base:sismember((TD_ID .. "ModList:" .. chat), user) then
		ModList = "✗";
	else
		ModList = "✓";
	end;
	if not base:sismember((TD_ID .. "Vip:" .. chat), user) then
		Vip = "✗";
	else
		Vip = "✓";
	end;
	if not base:sismember((TD_ID .. "messageSticker:" .. chat), user) then
		messageSticker = "✗";
	else
		messageSticker = "✓";
	end;
	if not base:sismember((TD_ID .. "messageAnimation:" .. chat), user) then
		messageAnimation = "✗";
	else
		messageAnimation = "✓";
	end;
	if not base:sismember((TD_ID .. "messageVideo:" .. chat), user) then
		messageVideo = "✗";
	else
		messageVideo = "✓";
	end;
	if not base:sismember((TD_ID .. "messageDocument:" .. chat), user) then
		messageDocument = "✗";
	else
		messageDocument = "✓";
	end;
	if not base:sismember((TD_ID .. "messageAudio:" .. chat), user) then
		messageAudio = "✗";
	else
		messageAudio = "✓";
	end;
	if not base:sismember((TD_ID .. "messageVoiceNote:" .. chat), user) then
		messageVoiceNote = "✗";
	else
		messageVoiceNote = "✓";
	end;
	rankk = "" .. (base:get(TD_ID .. "rank" .. chat .. user) or "بدون لقب ❌") .. "";
	nwarn = tonumber(base:hget(TD_ID .. "warn" .. chat, user) or 0);
	wmax = tonumber(base:hget(TD_ID .. "warn" .. chat, "warnmax") or 3);
	sendBot(chat, msg.id, "❂ نمایش وضعیت کاربر " .. ID .. "\n\n─┅━ وضعیت محدودیت کلی ━┅─\n\n✮ لیست تبچی : " .. AGTMute .. "\n✮ لیست بن ال : " .. GlobalyBanned .. "\n✮ لیست مسدود : " .. BanUser .. "\n✮ لیست سکوت : " .. MuteList .. "\n✮ سکوت رسانه : " .. MuteMediaList .. "\n✮ اخطار کاربر : " .. Alpha(wmax) .. " از " .. Alpha(nwarn) .. "\n\n─┅━ وضعیت محدودیت رسانه ━┅─\n\n✦ محدود استیکر : " .. messageSticker .. " \n✦ محدود گیف : " .. messageAnimation .. "\n✦ محدود فیلم : " .. messageVideo .. "\n✦ محدود ویس : " .. messageVoiceNote .. "\n✦ محدود فایل : " .. messageDocument .. " \n✦ محدود موزیک : " .. messageAudio .. "\n\n─┅━ وضعیت مقامی ━┅─\n\n◈ رئیس ربات : " .. Sudoide .. "\n◈ سودو ربات : " .. SUDOid .. "\n◈ مالک گروه : " .. OwnerList .. " \n◈ مالک ارشد : " .. OwnerListPlus .. "\n◈ معاون گروه : " .. NazemList .. "\n◈ ادمین گروه : " .. ModList .. "\n◈ عضو ویژه : " .. Vip .. "\n\n◈ لقب کاربر : " .. rankk .. "", "html");
end;



   function Setadmin(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  رئیس ربات می باشد امکان ارتقا دادن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  سودو می باشد امکان ارتقا دادن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  مالک گروه می باشد امکان ارتقا دادن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  مالک ارشد گروه می باشد امکان ارتقا دادن ندارید!  ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  معاون گروه می باشد امکان ارتقا دادن ندارید! ", "html");
		return false;
	else
	
		if base:sismember(TD_ID .. "ModList:" .. chat, user) then
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست ادمین ها وجود دارد !\n┈┅┅━ارتقا━┅┅┈\n 👮‍♀️توسط : "..IDsender.."  ", "html");
		else
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n به لیست ادمین ها اضافه شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, "⌯ کاربر 〚 " .. ID .. " 〛 به لیست ادمین ها اضافه شد .\n┈┅┅━ارتقا━┅┅┈\n 👮‍♀️توسط : "..IDsender.." ", "html");
			base:sadd(TD_ID .. "ModList:" .. chat, user);
			base:sadd(TD_ID .. "ModCleanList:" .. chat, user);
			base:sadd(TD_ID .. "ModBanList:" .. chat, user);
			base:sadd(TD_ID .. "ModMuteList:" .. chat, user);
			base:sadd(TD_ID .. "ModWarnList:" .. chat, user);
			base:sadd(TD_ID .. "ModLockList:" .. chat, user);
			base:sadd(TD_ID .. "ModpanelList:" .. chat, user);
			base:sadd(TD_ID .. "ModVipList:" .. chat, user);
			base:sadd(TD_ID .. "ModLockOption:" .. chat, user);
		end;
	end;
end;
 function Remadmin(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");

		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان عزل دادن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان عزل دادن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان عزل دادن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد امکان عزل دادن ندارید!  ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  معاون گروه می باشد امکان عزل دادن ندارید! ", "html");
		return false;
	else

		if not base:sismember((TD_ID .. "ModList:" .. chat), user) then
			sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 در لیست ادمین ها وجود ندارد !\n┈┅┅━عزل━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
		else
			local result = TD.getUser(user);
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n از لیست ادمین ها حذف شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست ادمین ها حذف شد.\n┈┅┅━عزل━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
			base:srem(TD_ID .. "ModListtest:" .. chat, user);
			base:srem(TD_ID .. "ModList:" .. chat, user);
			base:srem(TD_ID .. "ModCleanList:" .. chat, user);
			base:srem(TD_ID .. "ModBanList:" .. chat, user);
			base:srem(TD_ID .. "ModMuteList:" .. chat, user);
			base:srem(TD_ID .. "ModWarnList:" .. chat, user);
			base:srem(TD_ID .. "ModLockList:" .. chat, user);
			base:srem(TD_ID .. "ModpanelList:" .. chat, user);
			base:srem(TD_ID .. "ModVipList:" .. chat, user);
			base:srem(TD_ID .. "ModLockOption:" .. chat, user);
		end;
	end;
end;
 function SetNazem(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان معاون دادن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان معاون دادن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالگ گروه می باشد امکان معاون دادن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد امکان معاون دادن ندارید!  ", "html");
		return false;
	else

		if base:sismember(TD_ID .. "NazemList:" .. chat, user) then
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 در لیست معاون ربات وجود دارد !\n┈┅┅━تنظیم معاون━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		else
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n به لیست معاون ها اضافه شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 به لیست معاون ربات اضافه شد.\n┈┅┅━تنظیم معاون━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
			base:sadd(TD_ID .. "NazemList:" .. chat, user);
		end;
	end;
end;
function RemNazem(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان عزل معاون ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان عزل معاون ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالگ گروه می باشد امکان عزل معاون ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد امکان عزل معاون ندارید!  ", "html");
		return false;
	else

		if not base:sismember((TD_ID .. "NazemList:" .. chat), user) then
			sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 در لیست معاون ربات وجود ندارد !\n┈┅┅━حذف معاون━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		else
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n از لیست معاون ها حذف شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛〛 از لیست معاون ربات حذف شد. \n┈┅┅━حذف معاون━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
			base:srem(TD_ID .. "NazemList:" .. chat, user);
		end;
	end;
end;
 function SetAdd(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if base:sismember(TD_ID .. "VipAdd:" .. chat, user) then
		sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست معاف  وجود دارد!\n┈┅┅━معاف کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
	else
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n به لیست معاف اجباری اضافه شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
		sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به لیست معاف  اضافه شد.\n┈┅┅━معاف کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
		base:sadd(TD_ID .. "VipAdd:" .. chat, user);
	end;
end;
function RemAdd(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if not base:sismember((TD_ID .. "VipAdd:" .. chat), user) then
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 در لیست معاف وجود ندارد !\n┈┅┅━اجبار کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."   ", "html");
	else
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n از لیست معاف ها حذف شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 از لیست معاف حذف شد !\n┈┅┅━اجبار کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		base:srem(TD_ID .. "VipAdd:" .. chat, user);
	end;
end;
function SetTag(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if base:sismember(TD_ID .. "taglist:" .. chat, user) then
		sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست تگ وجود دارد !\n┈┅┅━تگ کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
	else
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n به لیست معاف اجباری اضافه شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
		sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛〛 به لیست تگ اضافه شد .\n┈┅┅━تگ کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		base:sadd(TD_ID .. "taglist:" .. chat, user);
	end;
end;
 function RemTag(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if not base:sismember((TD_ID .. "taglist:" .. chat), user) then
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست تگ وجود ندارد !\n┈┅┅━تگ کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
	else
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n از لیست معاف ها حذف شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 از لیست تگ حذف شد !\n┈┅┅━تگ کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."    ", "html");
		base:srem(TD_ID .. "taglist:" .. chat, user);
	end;
end;
function SetVip(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان ویژه کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان ویژه کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان ویژه کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به ویژه کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان ویژه کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان ویژه کردن ندارید! ", "html");
		return false;
	else

		if base:sismember(TD_ID .. "Vip:" .. chat, user) then
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست  ویژه وجود دارد !\n┈┅┅━ارتقا ویژه━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ به لیست کاربران ویژه اضافه شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به لیست  ویژه اضافه شد .\n┈┅┅━ارتقا ویژه━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:zincrby(TD_ID .. "bot:vip:" .. chat .. ":", 1, msg.sender_id.user_id);
			base:incr(TD_ID .. "Total:VipUser:" .. chat);
			base:sadd(TD_ID .. "Vip:" .. chat, user);
		end;
	end;
end;
function RemVip(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان حذف ویژه ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان حذف ویژه ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان حذف ویژه ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به حذف ویژه کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان حذف ویژه ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان حذف ویژه ندارید! ", "html");
		return false;
	else

		if not base:sismember((TD_ID .. "Vip:" .. chat), user) then
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست ویژه وجود ندارد !\n┈┅┅━حذف ویژه━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ از لیست کاربران ویژه حذف شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست ویژه حذف شد !\n┈┅┅━حذف ویژه━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:srem(TD_ID .. "Vip:" .. chat, user);
		end;
	end;
end;
 function SetOwner(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان مالک کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان مالک کردن ندارید! ", "html");
		return false;
	else
		if tonumber(user) == tonumber(BotJoiner) then
			return false;
		end;

		if base:sismember(TD_ID .. "OwnerList:" .. chat, user) then
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 در لیست مالکان ربات وجود دارد !\n┈┅┅━ارتقا مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 به لیست مالکان ربات اضافه شد .\n┈┅┅━ارتقا مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:sadd(TD_ID .. "OwnerList:" .. chat, user);
		end;
	end;
end;
 function RemOwner(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان حذف مالک ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان حذف مالک ندارید! ", "html");
		return false;
	else
		if tonumber(user) == tonumber(BotJoiner) then
			return false;
		end;

		if not base:sismember((TD_ID .. "OwnerList:" .. chat), user) then
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست مالکان ربات وجود ندارد !\n┈┅┅━عزل مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست مالکان ربات حذف شد.\n┈┅┅━عزل مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:srem(TD_ID .. "OwnerList:" .. chat, user);
		end;
	end;
end;
function SetOwnerPlus(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛رئیس ربات می باشد امکان مالک کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان مالک کردن ندارید! ", "html");
		return false;
	else
		if tonumber(user) == tonumber(BotJoiner) then
			return false;
		end;


		if base:sismember(TD_ID .. "OwnerListPlus:" .. chat, user) then
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 در لیست ارشد مالکین  وجود دارد !\n┈┅┅━ارشد مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 به لیست ارشد مالکین اضافه شد .\n┈┅┅━ارشد مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:sadd(TD_ID .. "OwnerListPlus:" .. chat, user);
		end;
	end;
end;
function RemOwnerPlus(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان حذف مالک ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو می باشد امکان حذف مالک ندارید! ", "html");
		return false;
	else
		if tonumber(user) == tonumber(BotJoiner) then
			return false;
		end;

		if not base:sismember((TD_ID .. "OwnerListPlus:" .. chat), user) then
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست ارشد مالکین وجود ندارد !\n┈┅┅━ارشد مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست ارشد مالکین حذف شد !\n┈┅┅━ارشد مالک━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:srem(TD_ID .. "OwnerListPlus:" .. chat, user);
		end;
	end;
end;
function AddAdmin(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		return false;
	end;

	local Keyboard = {
		{ 
	  
		  {
			text = "👮‍♂️ تنظیم ادمین",
			data = "bd:canchange:" .. chat .. ":" .. user .. ":" .. user
			 
		  }
		}
	  }
	  TD.sendText(chat, msg.id, " <b>✅ کاربر 〚 " .. ID .. "〛 در گروه ادمین شد.</b>\n┈┅┅━ارتقا ادمین━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html", false, false, false, false, TD.replyMarkup({type = "inline", data = Keyboard}))


	-- sendBot(chat, msg.id, " <b>✅ کاربر 〚 " .. ID .. "〛 در گروه ادمین شد.</b>\n┈┅┅━ارتقا ادمین━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
	reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ با موفقیت به مدیریت گروه ترفیع یافت !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
	promotemember(chat, user, 1, 1, 1, 1, 1, 1, 1, 1, 1);
	base:sadd(TD_ID .. "ModList:" .. chat, user);
end;
function DelAdmin(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then 
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		return false;
	end;

	sendBot(chat, msg.id, " <b>☑️ کاربر 〚 " .. ID .. "〛 در گروه حذف ادمین شد.</b>\n┈┅┅━حذف ادمین━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
	reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ با موفقیت از مدیریت گروه عزل شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>");
	base:srem(TD_ID .. "ModList:" .. chat, user);
	TD.setChatMemberStatus(chat, user, "Administrator", {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	});
end;
function kick(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان اخراج کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به اخراج کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان اخراج کردن ندارید! ", "html");
		return false;
	else

		local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ از گروه اخراج شد!\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
		sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 از گروه اخراج شد!\n┈┅┅━اخراج━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		base:zincrby(TD_ID .. "bot:kick:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:incr(TD_ID .. "Total:KickUser:" .. chat);
		base:incr(TD_ID .. "Total:KickUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
		KickUser(chat, user);
		TD.setChatMemberStatus(chat, user, "banned");
	end;
end;
function ban(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان مسدود کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به مسدود کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان مسدود کردن ندارید! ", "html");
		return false;
	else

		if base:sismember(TD_ID .. "BanUser:" .. chat, user) then
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 از قبل مسدود شده است!\n┈┅┅━بن کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			if base:get(TD_ID .. "ban_stats" .. chat) == "bantime" then
				local ex = tonumber(base:get(TD_ID .. "bantime:" .. chat) or 3600);
				local Time_ = getTimeUptime(ex);
				local hallatban = "به مدت" .. Time_ .. "از گروه مسدود شد";
				kickChatMemberTime(chat, user, msg.date + ex);
			else
				hallatban = "از گروه مسدود شد";
				KickUser(chat, user);
				TD.setChatMemberStatus(chat, user, "banned");
			end;
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n مسدود شد.\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
			sendBot(chat, msg.id, " ✅ کاربر 〚 " .. ID .. "〛 " .. hallatban .. "!\n┈┅┅━بن کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
			base:sadd(TD_ID .. "BanUser:" .. chat, user);
			base:incr(TD_ID .. "Total:MuteUser:" .. chat);
			base:incr(TD_ID .. "Total:MuteUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
		end;
	end;
end;
function unban(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:sismember((TD_ID .. "BanUser:" .. chat), user) then
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 در لیست مسدود نمی باشد !\n┈┅┅━حذف بن━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		UnRes(chat, user);
	else
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛 از لیست مسدود حذف  شد.\n┈┅┅━حذف بن━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ از لیست مسدودین حذف شد\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
		UnRes(chat, user);
		TD.setChatMemberStatus(chat, user, "banned", 0);
		base:srem(TD_ID .. "BanUser:" .. chat, user);
		base:zincrby(TD_ID .. "bot:unban:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:incr(TD_ID .. "Total:BanUser:" .. chat);
		base:incr(TD_ID .. "Total:BanUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
	end;
end;
function mute(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان سکوت کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	else

		if base:sismember(TD_ID .. "MuteList:" .. chat, user) then
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست سکوت می باشد !\n┈┅┅━سکوت کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		else
			if base:get(TD_ID .. "mute_stats" .. chat) == "mutetime" then
				local ex = tonumber(base:get(TD_ID .. "mutetime:" .. chat) or 3600);
				local Time_ = getTimeUptime(ex);
				hallatmute = "  به مدت " .. Time_ .. "سکوت شد";
				MuteUser(chat, user, msg.date + ex);
			else
				hallatmute = "در حالت سکوت قرار گرفت";
				MuteUser(chat, user, 0);
			end;
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n سکوت شد.\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 " .. hallatmute .. ".\n┈┅┅━سکوت کاربر━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
			base:sadd(TD_ID .. "MuteList:" .. chat, user);
			base:zincrby(TD_ID .. "bot:mute:" .. chat .. ":", 1, msg.sender_id.user_id);
			base:incr(TD_ID .. "Total:MuteUser:" .. chat);
			base:incr(TD_ID .. "Total:MuteUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
		end;
	end;
end;
 function unmute(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:sismember((TD_ID .. "MuteList:" .. chat), user) then
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست سکوت نمی باشد !\n┈┅┅━حذف سکوت━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
	else
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست سکوت حذف شد. \n┈┅┅━حذف سکوت━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
		local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ از حالت سکوت خارج شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
		UnRes(chat, user);
		base:srem(TD_ID .. "MuteList:" .. chat, user);
		base:zincrby(TD_ID .. "bot:unban:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:zincrby(TD_ID .. "bot:unmute:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:incr(TD_ID .. "Total:MuteUser:" .. chat);
		base:incr(TD_ID .. "Total:MuteUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
	end;
end;
 function mutemedia(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان سکوت کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان سکوت کردن ندارید! ", "html");
		return false;
	else

		if base:sismember(TD_ID .. "MuteMediaList:" .. chat, user) then
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست سکوت از ارسال رسانه می باشد !\n┈┅┅━سکوت رسانه━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		else
			if base:get(TD_ID .. "mute_stats" .. chat) == "mutetime" then
				local ex = tonumber(base:get(TD_ID .. "mutetime:" .. chat) or 3600);
				local Time_ = getTimeUptime(ex);
				local hallatmute = " به مدت " .. Time_ .. " در گروه سکوت رسانه شد";
				MuteMediaTime(chat, user, msg.date + ex);
			else
				local hallatmute = "در گروه سکوت رسانه شد";
				MuteMedia(chat, user);
			end;
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n در گروه سکوت رسانه شد.\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 " .. hallatmute .. ".\n┈┅┅━سکوت رسانه━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
			base:sadd(TD_ID .. "MuteMediaList:" .. chat, user);
			base:zincrby(TD_ID .. "bot:mute:" .. chat .. ":", 1, msg.sender_id.user_id);
			base:incr(TD_ID .. "Total:MuteUser:" .. chat);
			base:incr(TD_ID .. "Total:MuteUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
		end;
	end;
end;
function unmutemedia(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:sismember((TD_ID .. "MuteMediaList:" .. chat), user) then
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست سکوت رسانه قرار ندارد!\n┈┅┅━سکوت رسانه━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
	else
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست سکوت رسانه خارج شد.\n┈┅┅━سکوت رسانه━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
		local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ از حالت سکوت رسانه خارج شد! !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
		UnRes(chat, user);
		base:srem(TD_ID .. "MuteMediaList:" .. chat, user);
		base:zincrby(TD_ID .. "bot:unban:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:zincrby(TD_ID .. "bot:unmute:" .. chat .. ":", 1, msg.sender_id.user_id);
		base:incr(TD_ID .. "Total:MuteUser:" .. chat);
		base:incr(TD_ID .. "Total:MuteUserday:" .. chat .. ":" .. os.date("%Y/%m/%d"));
	end;
end;
function tabchi(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان تبچی کردن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	elseif is_PrivateMem(msg, user) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 شما دسترسی به انجام این کار را ندارید ! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  مالک گروه می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به تبچی کردن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛  ادمین گروه می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان تبچی کردن ندارید! ", "html");
		return false;
	else

		if base:sismember("AGTMute:", user) then
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 در لیست تبچی ها(TUT) می باشد !\n┈┅┅━تبچی━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		else
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n ⌯ به لیست تبچی ها اضافه شد!.\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به لیست تبچی ها (TUT) اضافه شد !\n┈┅┅━تبچی━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
			sendBot(Sudoid, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به لیست تبچی ها (TUT) اضافه شد !\n\n  توسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>", "html");
			sendBot(2076851562, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به لیست تبچی ها (TUT) اضافه شد !\n\n  توسط :  <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>", "html");
			base:sadd("AGTMute:", user);
			KickUser(chat, user);
			TD.setChatMemberStatus(chat, user, "banned");
		end;
	end;
end;
function untabchi(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
		
	end;

	if not base:sismember("AGTMute:", user) then
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 در لیست تبچی ها نمی باشد !\n┈┅┅━حذف تبچی━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
	else
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست تبچی ها حذف شد!\n┈┅┅━حذف تبچی━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		sendBot(Sudoid, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست تبچی ها حذف شد!\n\n  توسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>", "html");
		sendBot(2076851562, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 از لیست تبچی ها حذف شد!\n\n  توسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a> ","html");
		local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
		reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ از حالت سکوت خارج شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
		UnRes(chat, user);
		base:srem("AGTMute:", user);
	end;
end;
function Warn(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	result = TD.getUser(user);
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 رئیس ربات می باشد امکان اخطار دادن ندارید! ", "html");
	elseif SudUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 سودو ربات می باشد امکان اخطار دادن  ندارید! ", "html");
		return false;
	elseif OwnUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک گروه می باشد امکان اخطار دادن ندارید! ", "html");
		return false;
	elseif OwnUserPlus(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 مالک ارشد گروه می باشد دسترسی به اخطار دادن این کاربر را ندارید ! ", "html");
		return false;
	elseif NazemUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 معاون گروه می باشد امکان اخطار دادن ندارید! ", "html");
		return false;
	elseif ModUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین گروه می باشد امکان اخطار دادن ندارید! ", "html");
		return false;
	elseif ModUserTest(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 ادمین افتخاری می باشد امکان اخطار دادن ندارید! ", "html");
		return false;
	elseif VipUser(msg, user) then
		sendBot(chat, msg.id, "<b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 کاربر〚 "..ID.." 〛 عضو ویژه گروه می باشد امکان اخطار دادن ندارید! ", "html");
		return false;
	else

		nwarn = tonumber(base:hget(TD_ID .. "warn" .. chat, user) or 0);
		wmax = tonumber(base:hget(TD_ID .. "warn" .. chat, "warnmax") or 3);
		if nwarn + 1 == wmax then
			if base:get(TD_ID .. "warn_stats" .. chat) == "silent" then
				Hallat = "سکوت";
				sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به دلیل دریافت حداکثر اخطار مجاز سکوت شد !\n┈┅┅━اتمام اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ به دلیل دریافت حداکثر اخطار مجاز سکوت شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
				base:hdel(TD_ID .. "warn" .. chat, user);
				MuteUser(chat, user, 0);
				base:sadd(TD_ID .. "MuteList:" .. chat, user);
			elseif base:get(TD_ID .. "warn_stats" .. chat) == "kick" then
				Hallat = "اخراج";
				sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به دلیل دریافت حداکثر اخطار مجاز اخراج شد !\n┈┅┅━اتمام اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ به دلیل دریافت حداکثر اخطار مجاز اخراج شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
				base:hdel(TD_ID .. "warn" .. chat, user);
				base:sadd(TD_ID .. "BanUser:" .. chat, user);
				KickUser(chat, user);
				TD.setChatMemberStatus(chat, user, "banned");
			elseif base:get(TD_ID .. "warn_stats" .. chat) == "silenttime" then
				Hallat = "سکوت زمانی";
				local timemutemsg = tonumber(base:get(TD_ID .. "mutetime:" .. chat) or 3600);
				MuteUser(chat, user, msg.date + timemutemsg);
				local Time_ = getTimeUptime(timemutemsg);
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a> | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ به دلیل دریافت  حداکثر اخطار مجاز به مدت " .. Time_ .. " سکوت شد !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
				sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 به دلیل دریافت  حداکثر اخطار مجاز " .. Time_ .. " سکوت شد .\n┈┅┅━اتمام اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
				base:hdel(TD_ID .. "warn" .. chat, user);
			end;
		else
			if base:get(TD_ID .. "warn_stats" .. chat) == "silent" then
				Hallat = "سکوت";
			elseif base:get(TD_ID .. "warn_stats" .. chat) == "silenttime" then
				Hallat = "سکوت زمانی";
			elseif base:get(TD_ID .. "warn_stats" .. chat) == "kick" then
				Hallat = "اخراج";
			end;
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. result.first_name .. "</a>  | `" .. user .. "`\n─┅━━🄰🄿🄸━━┅─\n⌯ شما " .. nwarn + 1 .. " از " .. wmax .. " اخطار دریافت کردید !\nتوسط : <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a>\n\n" .. tarikh .. "");
			sendBot(chat, msg.id, "✅ کاربر 〚 " .. ID .. "〛 یک اخطار گرفت ! \n🚨 وضعیت اخطار :"..Alpha(nwarn + 1).."/" .. Alpha(wmax) .. "\n┈┅┅━دریافت اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
			base:hset(TD_ID .. "warn" .. chat, user, nwarn + 1);
		end;
	end;
end;
 function Remwarnmin(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");

		return false;
	end;

	if not base:hget((TD_ID .. "warn" .. chat), user) then
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 اخطاری دریافت نکرده است ! \n┈┅┅━حذف اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."", "html");
		warnhash = base:hget(TD_ID .. "warn" .. chat, user);
	else
		nwarn = tonumber(base:hget(TD_ID .. "warn" .. chat, user) or 0);
		base:hset(TD_ID .. "warn" .. chat, user, nwarn - 1);
		wmax = tonumber(base:hget(TD_ID .. "warn" .. chat, "warnmax") or 3);
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 یک اخطار شما حذف شد.\n🚨 وضعیت اخطار :"..Alpha(nwarn).."/" .. Alpha(wmax) .. "\n┈┅┅━حذف اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.." ", "html");
	end;
end;
function Remwarn(msg, chat, user)
	local result = TD.getUser(user);
	if not result.first_name then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.first_name) .. "</a>";
	else
		ID = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(result.username) .. "</a>";
	end;
	local resultsender = TD.getUser(msg.sender_id.user_id);
	if not resultsender.first_name then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif resultsender.first_name ~= "" then
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.first_name) .. "</a>";
	else
		IDsender = "<a href=\"tg://user?id=" .. user .. "\">" .. StringData(resultsender.username) .. "</a>";
	end;
	if tonumber(user) == tonumber(BotJoiner) then
		sendBot(chat, msg.id, " <b>⚠️ کاربر عزیز :〚 "..IDsender.." 〛</b>\n┈┅┅━خطا━┅┅┈\n📵 اجرای دستور بر روی〚 "..ID.." 〛 امکان پذیر نیست!\n ", "html");
		return false;
	end;

	if not base:hget((TD_ID .. "warn" .. chat), user) then
		sendBot(chat, msg.id, " ☑️ کاربر 〚 " .. ID .. "〛  اخطاری دریافت نکرده است !\n┈┅┅━حذف اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		warnhash = base:hget(TD_ID .. "warn" .. chat, user);
	else
		sendBot(chat, msg.id, "☑️ کاربر 〚 " .. ID .. "〛 اخطارهای شما با موفقیت حذف شد !\n┈┅┅━حذف اخطار━┅┅┈\n👮‍♀️توسط : "..IDsender.."  ", "html");
		base:hdel(TD_ID .. "warn" .. chat, user);
	end;
end;





