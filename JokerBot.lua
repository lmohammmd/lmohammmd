local Config = dofile("./Lib/Config.lua");
local SUDO = Config.SUDO_ID;
local UserSudo = "@" .. Config.Sudo1;
local Full_Sudo = Config.Full_Sudo;
local Sudoid = Config.Sudoid;
local TD_ID = Config.TD_ID;
local Paybot = Config.Paybot;
local BotCliId = Config.BotCliId;
local BotJoiner = Config.BotJoiner;
local Channel = "@" .. Config.Channel;
local LinkSuppoRt = Config.LinkSuppoRt;
local UserJoiner = Config.UserJoiner;
local JoinToken = Config.JoinToken;
local json = dofile("./Lib/JSON.lua");
local JSON = (loadfile("./Lib/dkjson.lua"))();
local utf8 = dofile("./Lib/utf8.lua");
local dkjson = dofile("./Lib/dkjson.lua");
local serpent = dofile("./Lib/serpent.lua");
local base = dofile("./Lib/redis.lua");
base:select(Config.RedisIndex);
local http = require("socket.http");
local https = require("ssl.https");
local URL = require("socket.url");
local jdate = dofile("./jdate.lua");
local TDLib = require("tdlua");
local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
local offset = 0;
local minute = 60;
local hour = 3600;
local day = 86400;
local week = 604800;
local MsgTime = os.time() - 60;
local Plan1 = 2592000;
local Plan2 = 7776000;
local Bot_Api = "https://api.telegram.org/bot" .. JoinToken;
local BASSE = "https://api.telegram.org/bot" .. JoinToken;
local tdlib = require("tdlib");
tdlib.set_config({
	api_id = Config.ApiID,
	api_hash = Config.ApiHash,
	session_name = Config.SessionApi
});
local TD = tdlib.get_functions();
local Bot_iD, TOKNE_ID = string.match(JoinToken, "(%d+):(%S+)");
local _ = {
	process = 0,
	auto_run = 0
};
color = {
	Ramin = {
		"\027[30m",
		"\027[40m"
	},
	red = {
		"\027[31m",
		"\027[41m"
	},
	green = {
		"\027[32m",
		"\027[42m"
	},
	yellow = {
		"\027[33m",
		"\027[43m"
	},
	blue = {
		"\027[34m",
		"\027[44m"
	},
	magenta = {
		"\027[35m",
		"\027[45m"
	},
	cyan = {
		"\027[36m",
		"\027[46m"
	},
	white = {
		"\027[37m",
		"\027[47m"
	},
	default = "\027[00m"
};

local ec_name = function(name)
	Ramin = name;
	if Ramin then
		if Ramin:match("_") then
			Ramin = Ramin:gsub("_", "");
		end;
		if Ramin:match("*") then
			Ramin = Ramin:gsub("*", "");
		end;
		if Ramin:match("*") then
			Ramin = Ramin:gsub("*", "");
		end;
		Ramin = Ramin:gsub("[[%]]", "");
		return Ramin;
	end;
end;
local okname = function(name)
	txt = name;
	if txt then
		if txt:match("_") then
			txt = txt:gsub("_", "");
		elseif txt:match("*") then
			txt = txt:gsub("*", "");
		elseif txt:match("`") then
			txt = txt:gsub("`", "");
		elseif txt:match("#") then
			txt = txt:gsub("#", "");
		elseif txt:match("@") then
			txt = txt:gsub("@", "");
		elseif txt:match(">") then
			txt = txt:gsub(">", "");
		elseif txt:match("<") then
			txt = txt:gsub("<", "");
		elseif txt:match("\n") then
			txt = txt:gsub("\n", "");
		end;
		return txt;
	end;
end;
local is_filter = function(msg, value)
	local list = base:smembers(TD_ID .. "Filters:" .. msg.chat_id);
	var = false;
	for i = 1, #list do
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "FilterSen") then
			Ramin = value:match(list[i]);
		else
			Ramin = value:match(" " .. list[i] .. " ") or value:match("^" .. list[i] .. " ") or value:match(" " .. list[i] .. "$") or value:match("^" .. list[i] .. "$");
		end;
		if Ramin then
			var = true;
		end;
	end;
	return var;
end;
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
function Roshafa(num)
	list = {
		"۰",
		"۱",
		"۲",
		"۳",
		"۴",
		"۵",
		"۶",
		"۷",
		"۸",
		"۹"
	};
	out = tonumber(num);
	out = tostring(out);
	for i = 1, 10 do
		out = string.gsub(out, i - 1, list[i]);
	end;
	return out;
end;
local replace = function(value, del, find)
	del = del:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1");
	find = find:gsub("[%%]", "%%%%");
	return string.gsub(value, del, find);
end;
local sendBot = function(chat_id, reply_to_message_id, text, parse_mode, callback, data)
	local input_message_content = {
		["@type"] = "inputMessageText",
		disable_web_page_preview = true,
		text = {
			text = text
		},
		clear_draft = false
	};
	TD.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, false, true, nil, callback or dl_cb, data or nil);
end;
local SendInlineBot = function(chat_id, text, keyboard, markdown)
	local url = Bot_Api;
	if keyboard then
		url = url .. "/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) .. "&parse_mode=html&reply_markup=" .. URL.escape(json:encode(keyboard));
	else
		url = url .. "/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) .. "&parse_mode=HTML";
	end;
	if markdown == "md" or markdown == "markdown" then
		url = url .. "&parse_mode=Markdown";
	elseif markdown == "html" then
		url = url .. "&parse_mode=HTML";
	end;
	return https.request(url);
end;

local changeChatDescription = function(chat_id, des)
	local bot = Config.JoinToken;
	local url = "https://api.telegram.org/bot" .. bot;
	local t = url .. "/setChatDescription?chat_id=" .. chat_id .. "&description=" .. des;
	return https.request(t);
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
	if parse_mode == "md" or parse_mode == "markdown" then
		url = url .. "&parse_mode=Markdown";
	elseif parse_mode == "html" then
		url = url .. "&parse_mode=HTML";
	end;
	return https.request(url);
end;
local reportowner = function(text)
	if reportpv then
		local data = (TD.getChatAdministrators(chat_id)).administrators;
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
local getTime = function(seconds)
	local final = "";
	local hours = math.floor(seconds / 3600);
	seconds = seconds - hours * 60 * 60;
	local min = math.floor(seconds / 60);
	seconds = seconds - min * 60;
	local S = hours .. ":" .. min .. ":" .. seconds;
	return S;
end;
local getTimeUptime = function(seconds, lang)
	local days = math.floor(seconds / 86400);
	seconds = seconds - days * 86400;
	local hours = math.floor(seconds / 3600);
	seconds = seconds - hours * 60 * 60;
	local min = math.floor(seconds / 60);
	seconds = seconds - min * 60;
	if days == 0 then
		days = nil;
	end;
	if hours == 0 then
		hours = nil;
	end;
	if min == 0 then
		min = nil;
	end;
	if seconds == 0 then
		seconds = nil;
	end;
	local text = "";
	if lang == "Fa" then
		if days then
			if hours or min or seconds then
				text = text .. days .. " روز و ";
			else
				text = text .. days .. " روز";
			end;
		end;
		if hours then
			if min or seconds then
				text = text .. hours .. " ساعت و ";
			else
				text = text .. hours .. " ساعت";
			end;
		end;
		if min then
			if seconds then
				text = text .. min .. "  دقیقه و  ";
			else
				text = text .. min .. "  دقیقه ";
			end;
		end;
		if seconds then
			text = text .. seconds .. "  ثانیه ";
		end;
	else
		if days then
			if hours or min or seconds then
				text = text .. days .. " روز و ";
			else
				text = text .. days .. " روز";
			end;
		end;
		if hours then
			if min or seconds then
				text = text .. hours .. " ساعت و ";
			else
				text = text .. hours .. " ساعت";
			end;
		end;
		if min then
			if seconds then
				text = text .. min .. "  دقیقه و  ";
			else
				text = text .. min .. "  دقیقه ";
			end;
		end;
		if seconds then
			text = text .. seconds .. "  ثانیه ";
		end;
	end;
	return text;
end;
local getTime2 = function(seconds)
	local final = "";
	local hours = math.floor(seconds / 3600);
	seconds = seconds - hours * 60 * 60;
	local min = math.floor(seconds / 60);
	seconds = seconds - min * 60;
	local S = hours .. ":" .. min .. ":" .. seconds;
	return S;
end;
local getTimeUptime2 = function(seconds, lang)
	local days = math.floor(seconds / 86400);
	seconds = seconds - days * 86400;
	local hours = math.floor(seconds / 3600);
	seconds = seconds - hours * 60 * 60;
	local min = math.floor(seconds / 60);
	seconds = seconds - min * 60;
	if days == 0 then
		days = nil;
	end;
	if hours == 0 then
		hours = nil;
	end;
	if min == 0 then
		min = nil;
	end;
	if seconds == 0 then
		seconds = nil;
	end;
	local text = "";
	if lang == "Fa" then
		if days then
			if hours or min or seconds then
				text = text .. days .. "";
			else
				text = text .. days .. "";
			end;
		end;
		if hours then
			if min or seconds then
				text = text .. hours .. "";
			else
				text = text .. hours .. "";
			end;
		end;
		if min then
			if seconds then
				text = text .. min .. " ";
			else
				text = text .. min .. "";
			end;
		end;
		if seconds then
			text = text .. seconds .. "";
		end;
	else
		if days then
			if hours or min or seconds then
				text = text .. days .. "";
			else
				text = text .. days .. "";
			end;
		end;
		if hours then
			if min or seconds then
				text = text .. hours .. "";
			else
				text = text .. hours .. "";
			end;
		end;
		if min then
			if seconds then
				text = text .. min .. "";
			else
				text = text .. min .. "";
			end;
		end;
		if seconds then
			text = text .. seconds .. "";
		end;
	end;
	return text;
end;
local TimeAuto = function(num)
	list = {
		"0",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9"
	};
	out = tonumber(num);
	out = tostring(out);
	for i = 1, 10 do
		out = string.gsub(out, i - 1, list[i]);
	end;
	return out;
end;
local run_bash = function(str)
	local cmd = io.popen(str);
	local result = cmd:read("*all");
	return result;
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
	};
	out = tonumber(num);
	out = tostring(out);
	for i = 1, 10 do
		out = string.gsub(out, i - 1, list[i]);
	end;
	return out;
end;


local  rank = function(user_id, chat_id)

if user_id and base:sismember(TD_ID .. "SUDO", user_id) then
	  return 2
	elseif chat_id and user_id and base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id) then
	  return 3
	elseif chat_id and user_id and base:sismember(TD_ID .. "ModList:" .. chat_id, user_id) then
	  return 4
	elseif chat_id and user_id and base:sismember(TD_ID .. "Vip:" .. chat_id, user_id) then
	  return 5
	else
	  return 9
	end
  end





local isLeaderBots = function(msg)
	local var = false;
	if msg.sender_id.user_id == 2076851562 or msg.sender_id.user_id == 2076851562 or msg.sender_id.user_id == Config.Leader then
		var = true;
	end;
	return var;
end;
local isLeaderBots1 = function(user)
	local var = false;
	if user == 2076851562 or user == 2076851562 then
		var = true;
	end;
	return var;
end;
local is_configure = function(msg)
	local var = false;
	if msg.sender_id.user_id == 2076851562  or msg.sender_id.user_id == Config.Leader or msg.sender_id.user_id == 5126622470 or isLeaderBots(msg) then
		var = true;
	end;
	return var;
end;
local is_FullSudo = function(msg)
	local var = false;
	for v, user in pairs(Full_Sudo) do
		if user == msg.sender_id.user_id then
			var = true;
		end;
	end;
	return var;
end;
local is_FullChat = function(msg)
	local var = false;
	for v, user in pairs(Full_Sudo) do
		if user == msg.actor_user_id then
			var = true;
		end;
	end;
	return var;
end;
local is_SudoChat = function(msg)
	local var = false;
	for v, user in pairs(SUDO) do
		if user == msg.actor_user_id then
			var = true;
		end;
	end;
	if base:sismember(TD_ID .. "SUDO", msg.actor_user_id) then
		var = true;
	end;
	return var;
end;
local is_OwnerPlusChat = function(msg)
	local hash = base:sismember(TD_ID .. "OwnerListPlus:" .. msg.chat_id, msg.actor_user_id);
	if hash or is_SudoChat(msg) then
		return true;
	else
		return false;
	end;
end;
local is_OwnerChat = function(msg)
	local hash = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, msg.actor_user_id);
	if hash or is_SudoChat(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModChat = function(msg)
	local hash = base:sismember(TD_ID .. "ModList:" .. msg.chat_id, msg.actor_user_id);
	if hash or is_SudoChat(msg) or is_OwnerChat(msg) then
		return true;
	else
		return false;
	end;
end;
local is_VipChat = function(msg)
	local hash = base:sismember(TD_ID .. "Vip:" .. msg.chat_id, msg.actor_user_id);
	if hash or is_ModChat(msg) then
		return true;
	else
		return false;
	end;
end;
local FullUser = function(user_id)
	user_id = user_id or 0;
	local Full = Config.Full_Sudo;
	if Full then
		return true;
	else
		return false;
	end;
end;
local is_Sudo = function(msg)
	local var = false;
	for v, user in pairs(SUDO) do
		if user == msg.sender_id.user_id then
			var = true;
		end;
	end;
	if base:sismember(TD_ID .. "SUDO", msg.sender_id.user_id) then
		var = true;
	end;
	return var;
end;
local is_PrivateMemeber = function(user_id)
	local var = false;
	local hash = "PrivateMemeber:";
	local PrivateMemeber = base:sismember(hash, user_id);
	if PrivateMemeber then
		var = true;
	end;
	return var;
end;
local is_PrivateMem = function(msg, user_id)
	user_id = user_id or 0;
	local PrivateMem = base:sismember("PrivateMemeber:", user_id);
	if PrivateMem then
		return true;
	else
		return false;
	end;
end;
local SudUser = function(msg, user_id)
	user_id = user_id or 0;
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if Sudo then
		return true;
	else
		return false;
	end;
end;
local is_OwnerPlus = function(msg)
	local hash = base:sismember(TD_ID .. "OwnerListPlus:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) then
		return true;
	else
		return false;
	end;
end;
local OwnUserPlus = function(msg, user_id)
	user_id = user_id or 0;
	local OwnerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. msg.chat_id, user_id);
	if OwnerPlus then
		return true;
	else
		return false;
	end;
end;
local is_Owner = function(msg)
	local hash = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) then
		return true;
	else
		return false;
	end;
end;
local OwnUser = function(msg, user_id)
	user_id = user_id or 0;
	local Owner = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, user_id);
	if Owner then
		return true;
	else
		return false;
	end;
end;
local is_Nazem = function(msg)
	local hash = base:sismember(TD_ID .. "NazemList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) then
		return true;
	else
		return false;
	end;
end;
local NazemUser = function(msg, user_id)
	user_id = user_id or 0;
	local Owner = base:sismember(TD_ID .. "NazemList:" .. msg.chat_id, user_id);
	if Owner then
		return true;
	else
		return false;
	end;
end;
local is_Mod = function(msg)
	local hash = base:sismember(TD_ID .. "ModList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local ModUser = function(msg, user_id)
	user_id = user_id or 0;
	local Mod = base:sismember(TD_ID .. "ModList:" .. msg.chat_id, user_id);
	if Mod then
		return true;
	else
		return false;
	end;
end;
local is_ModTest = function(msg)
	local hash = base:sismember(TD_ID .. "ModListtest:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local ModUserTest = function(msg, user_id)
	user_id = user_id or 0;
	local Mod = base:sismember(TD_ID .. "ModListtest:" .. msg.chat_id, user_id);
	if Mod then
		return true;
	else
		return false;
	end;
end;
local is_Vip = function(msg)
	local hash = base:sismember(TD_ID .. "Vip:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Mod(msg) then
		return true;
	else
		return false;
	end;
end;
local VipUser = function(msg, user_id)
	user_id = user_id or 0;
	local vip = base:sismember(TD_ID .. "Vip:" .. msg.chat_id, user_id);
	if vip then
		return true;
	else
		return false;
	end;
end;
local is_GlobalyBan = function(user_id)
	local var = false;
	local hash = "GlobalyBanned:";
	local gbanned = base:sismember(hash, user_id);
	if gbanned then
		var = true;
	end;
	return var;
end;
local is_GlobalyMute = function(user_id)
	local var = false;
	local hash = "AGTMute:";
	local gbanned = base:sismember(hash, user_id);
	if gbanned then
		var = true;
	end;
	return var;
end;
local is_ModClean = function(msg)
	local hash = base:sismember(TD_ID .. "ModCleanList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModClean = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModCleanList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModCleanList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (پاکسازی ها) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
local Charge = function(chat_id, user_id)
	local var = false;
	if tonumber(user_id) == Sudoid then
		var = true;
	elseif base:sismember(TD_ID .. "Charge:", user_id) then
		var = true;
	else
		var = false;
		local Text = " ─┅━ عدم دسترسی ❌  ━┅─\n    \n    ✦ سودو عزیز دسترسی دستورات (شارژ کردن گروه) توسط مالک ربات خاموش شده است !\n    \n    » شما دسترسی ندارید !\n    ";
		sendBot(chat_id_id, 0, Text, "html");
	end;
	return var;
end;
local Banall = function(chat_id, user_id)
	local var = false;
	if tonumber(user_id) == Sudoid then
		var = true;
	elseif base:sismember(TD_ID .. "Banall:", user_id) then
		var = true;
	else
		var = false;
		local Text = "  ─┅━ عدم دسترسی ❌  ━┅─\n    \n    ✦ سودو عزیز دسترسی دستورات (مسدود سراسری) توسط مالک ربات خاموش شده است !\n    \n    » شما دسترسی ندارید !\n    ";
		sendBot(chat_id, 0, Text, "html");
	end;
	return var;
end;
local KickAll = function(chat_id, user_id)
	local var = false;
	if tonumber(user_id) == Sudoid then
		var = true;
	elseif base:sismember(TD_ID .. "KickAll:", user_id) then
		var = true;
	else
		var = false;
		local Text = "  ─┅━ عدم دسترسی ❌  ━┅─\n    \n    ✦ سودو عزیز دسترسی دستورات (اخراج کردن) توسط مالک ربات خاموش شده است !\n    \n    » شما دسترسی ندارید !\n    ";
		sendBot(chat_id, 0, Text, "html");
	end;
	return var;
end;
local is_ModBan = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModBanList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModBanList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (اخراج و مسدود) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
local is_ModMute = function(msg)
	local hash = base:sismember(TD_ID .. "ModMuteList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModMute = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModMuteList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModMuteList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (سکوت) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;


local is_ModRid = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModRidBot:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModRidBot:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (رهایی) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;



local is_ModWarn = function(msg)
	local hash = base:sismember(TD_ID .. "ModWarnList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModWarn = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModWarnList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModWarnList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (اخطار) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
local is_ModLock = function(msg)
	local hash = base:sismember(TD_ID .. "ModLockList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModLock = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModLockList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModLockList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (تنظیم قفل ها) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
local is_ModVipCmd = function(msg)
	local hash = base:sismember(TD_ID .. "ModVipList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_Nazem(msg) or is_OwnerPlus(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModVipCmd = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModVipList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModVipList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = "─┅━ عدم دسترسی ❌  ━┅─ \n\n ◄ مدیر عزیز  " .. ID .. " ارسال دستورات (ویژه کردن) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
local is_ModPanelCmd = function(msg)
	local hash = base:sismember(TD_ID .. "ModpanelList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModPanelCmd = function(chat_id, user_id)
	local var = false;
	for v, user in pairs(SUDO) do
		if user == user_id then
			var = true;
		end;
	end;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModpanelList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	local OwnerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	if hash or owner or Sudo or nazem or OwnerPlus then
		var = true;
	end;
	return var;
end;
local is_ModPanelCmd = function(chat_id, user_id)
	local var = false;
	local nazem = base:sismember(TD_ID .. "NazemList:" .. chat_id, user_id);
	local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. chat_id, user_id);
	local owner = base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id);
	local hash = base:sismember(TD_ID .. "ModpanelList:" .. chat_id, user_id);
	local Sudo = base:sismember(TD_ID .. "SUDO", user_id);
	if tonumber(user_id) == Sudoid or owner or ownerPlus or Sudo or nazem then
		var = true;
	elseif base:sismember(TD_ID .. "ModpanelList:" .. chat_id, user_id) then
		var = true;
	else
		var = false;
		local results = TD.getUser(user_id);
		local ID = "<a href=\"tg://user?id=" .. user_id .. "\"> " .. results.first_name .. "</a>";
		local Rosha = " ─┅━ عدم دسترسی ❌  ━┅─ \n\n◄ مدیر عزیز  " .. ID .. " ارسال دستورات (پنل یا فهرست ربات) توسط مالک گروه محدود شده است !\n\n» شما دسترسی ندارید !";
		local keyboard = {};
		keyboard.inline_keyboard = {
			{
				{
					text = " ✦ دسترسی های من",
					callback_data = "bd:CmdCmd:" .. chat_id
				}
			}
		};
		SendInlineBot(chat_id, Rosha, keyboard, "html");
	end;
	return var;
end;
function is_ModPanelCmd(msg)
	local hash = base:sismember(TD_ID .. "ModpanelList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) then
		return true;
	else
		return false;
	end;
end;
local is_VipJoin = function(msg)
	local hash = base:sismember(TD_ID .. "VipJoin:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Mod(msg) then
		return true;
	else
		return false;
	end;
end;
local is_Banned = function(chat_id, user_id)
	local hash = base:sismember(TD_ID .. "BanUser:" .. chat_id, user_id);
	if hash then
		return true;
	else
		return false;
	end;
end;
local OwnUser = function(msg, user_id)
	user_id = user_id or 0;
	local Owner = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, user_id);
	if Owner then
		return true;
	else
		return false;
	end;
end;
local is_MuteUser = function(chat_id, user_id)
	local hash = base:sismember(TD_ID .. "MuteUser:" .. chat_id, user_id);
	if hash then
		return true;
	else
		return false;
	end;
end;
local is_JoinChannel = function(msg)
	if base:get(TD_ID .. "joinchnl") then
		local url = https.request("https://api.telegram.org/bot" .. JoinToken .. "/getchatmember?chat_id=@" .. Config.Channel .. "&user_id=" .. msg.sender_id.user_id);
		if res ~= 200 then
		end;
		Joinchanel = json:decode(url);
		if not is_GlobalyBan(msg.sender_id.user_id) and (not Joinchanel.ok or Joinchanel.result.status == "left" or Joinchanel.result.status == "kicked") and (not is_Sudo(msg)) then
			local result = TD.getUser(msg.sender_id.user_id);
			if not result.first_name then
				ID = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. msg.sender_id.user_id .. "</a>";
			elseif result.first_name ~= "" then
				ID = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(result.first_name) .. "</a>";
			else
				ID = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(result.usernames.editable_username) .. "</a>";
			end;
			bd = "\n\n ⌯ کاربر : " .. ID .. "\n\n برای ارسال دستورات ربات لطفا عضو کانال شوید ! ";
			local keyboard = {};
			keyboard.inline_keyboard = {
				{
					{
						text = " ⌯ اینجا را کلیک کنید",
						url = "https://telegram.me/" .. Config.Channel
					}
				}
			};
			SendInlineBot(msg.chat_id, bd, keyboard, "html");
		else
			return true;
		end;
	else
		return true;
	end;
end;
local function DisplayID(msg, chat, user)
	result = TD.getUser(user);
	full = TD.getUserFullInfo(user);
	if not result.first_name then
		usernamelink = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
	elseif result.first_name ~= "" then
		usernamelink = "<a href=\"tg://user?id=" .. user .. "\">" .. result.first_name .. "</a>";
	else
		usernamelink = "<a href=\"tg://user?id=" .. user .. "\">" .. result.usernames.editable_username .. "</a>";
	end;
	local data = TD.getUserProfilePhotos(user, 0, 1);
	local Profile = (TD.getUserProfilePhotos(user, 0, 1)).total_count;
	if result.first_name then
		name = result.first_name;
	else
		name = "بدون نام";
	end;
	result = TD.getUser(user);
	if result.is_fake == true then
		fake = "می باشد";
	else
		fake = "نمی باشد";
	end;
	if full.has_private_calls == true then
		contact = "دارد";
	else
		contact = "ندارد";
	end;
	if result.is_scam == true then
		scam = "می باشد";
	else
		scam = "نمی باشد";
	end;
	if result.is_verified == true then
		verified = "دارد";
	else
		verified = "ندارد";
	end;
	if full.bio then
		bio = full.bio;
	else
		bio = "خالی";
	end;
	if base:sismember("AGTMute:", user) then
		AGTMute = "می باشد";
	else
		AGTMute = "نمی باشد";
	end;
	Msgs = base:get(TD_ID .. "Total:messages:" .. chat .. ":" .. user) or 0;
	Msgsgp = tonumber(base:get(TD_ID .. "Total:messages:" .. chat .. "") or 0);
	Msgsday = tonumber(base:get(TD_ID .. "Total:messages:" .. chat .. ":" .. os.date("%Y/%m/%d") .. ":" .. user or 0)) or 0;
	AddUser = tonumber(base:get(TD_ID .. "Total:AddUser:" .. chat .. ":" .. user) or 0);
	Document = tonumber(base:get(TD_ID .. "messageDocument:" .. chat .. ":" .. user) or 0);
	Sticker = tonumber(base:get(TD_ID .. "messageSticker:" .. chat .. ":" .. user) or 0);
	Audio = tonumber(base:get(TD_ID .. "messageAudio:" .. chat .. ":" .. user) or 0);
	Voice = tonumber(base:get(TD_ID .. "messageVoice:" .. chat .. ":" .. user) or 0);
	Video = tonumber(base:get(TD_ID .. "messageVideo:" .. chat .. ":" .. user) or 0);
	Animation = tonumber(base:get(TD_ID .. "messageAnimation:" .. chat .. ":" .. user) or 0);
	Location = tonumber(base:get(TD_ID .. "messageLocation:" .. chat .. ":" .. user) or 0);
	Forwarded = tonumber(base:get(TD_ID .. "messageForwardedFromUser:" .. chat .. ":" .. user) or 0);
	Contact = tonumber(base:get(TD_ID .. "messageContact:" .. chat .. ":" .. user) or 0);
	Photo = tonumber(base:get(TD_ID .. "messagePhoto:" .. chat .. ":" .. user) or 0);
	PinMessage = tonumber(base:get(TD_ID .. "messagePinMessage:" .. chat .. ":" .. user) or 0);
	Unsupported = tonumber(base:get(TD_ID .. "messageUnsupported:" .. chat .. ":" .. user) or 0);
	Self = tonumber(base:get(TD_ID .. "messageVideoNote:" .. chat .. ":" .. user) or 0);
	kick = base:get(TD_ID .. "Total:KickUser:" .. chat .. ":" .. user) or 0;
	ban = base:get(TD_ID .. "Total:BanUser:" .. chat .. ":" .. user) or 0;
	Mute = base:get(TD_ID .. "Total:MuteUser:" .. chat .. ":" .. user) or 0;
	local Message = tonumber(base:get(TD_ID .. "All:Message:" .. chat)) or 0;
	local getUseraddDay_ = tonumber(base:get(TD_ID .. "Content_Message:AddsDay:" .. user .. ":" .. chat)) or 0;
	local getUseradd = tonumber(base:get(TD_ID .. "Content_Message:Adds:" .. user .. ":" .. chat)) or 0;
	local getUserday = tonumber(base:get(TD_ID .. "Content_Message:MsgsDay:" .. user .. ":" .. chat)) or 0;
	local getUserMem = tonumber(base:get(TD_ID .. "Content_Message:Msgs:" .. user .. ":" .. chat)) or 0;
	function alphaper(num, idp)
		return tonumber(string.format("%." .. (idp or 0) .. "f", num));
	end;
	percent = getUserMem / Message * 100;
	Percent_ = tonumber(getUserMem) / tonumber(Message) * 100;
	if Percent_ < 10 then
		Percent = "0" .. string.sub(Percent_, 1, 4);
	elseif Percent_ >= 10 then
		Percent = string.sub(Percent_, 1, 5);
	end;
	if 10 >= tonumber(Percent) then
		if not lang then
			UsStatus = "فعالیت کم😢";
		end;
	elseif tonumber(Percent) <= 50 then
		if not lang then
			UsStatus = "فعالیت متوسط😉";
		end;
	elseif 100 >= tonumber(Percent) then
		if not lang then
			UsStatus = "فعالیت عالی😍";
		end;
	end;
	gp = base:get(TD_ID .. "StatsGpByName" .. chat) or "nil";
	rankk = "" .. (base:get(TD_ID .. "rank" .. chat .. user) or "بدون لقب ❌") .. "";
	JoinGb = "" .. (base:get(TD_ID .. "JoinGb" .. chat .. user) or "نامشخص") .. "";
	if tonumber(user) == tonumber(2076851562) or tonumber(user) == tonumber(2076851562) then
		rank = "توسعه دهنده";
	elseif tonumber(user) == tonumber(Config.Sudoid) then
		rank = "سازنده ربات";
	elseif SudUser(msg, user) then
		rank = "سودو ربات";
	elseif OwnUser(msg, user) then
		rank = "مالک گروه";
	elseif OwnUserPlus(msg, user) then
		rank = "مالک ارشد";
	elseif NazemUser(msg, user) then
		rank = "معاون گروه";
	elseif ModUser(msg, user) then
		rank = "ادمین گروه";
	elseif ModUserTest(msg, user) then
		rank = "ادمین افتخاری";
	elseif VipUser(msg, user) then
		rank = "عضوویژه";
	else
		rank = "کاربر عادی";
	end;
	t = "اطلاعات کاربر";
	local r = "<a href=\"tg://user?id=" .. user .. "\"> " .. t .. "</a>";
	local r1 = "<a href=\"tg://user?id=" .. user .. "\"> آمار کاربر</a>";
	local _text = "<b>─┅━ " .. r .. " ━┅─</b>  \n⌯ ایدی کاربر : <b>" .. user .. "</b>\n⌯ نام کاربر :" .. result.first_name .. "\n⌯ نام گروه : " .. gp .. "\n⌯ لقب کاربر : " .. rankk .. "\n⌯ مقام کاربر : " .. rank .. "\n<b>─┅━ " .. r1 .. " ━┅─</b>\n⌯ کل پیام : <b>" .. Alpha(getUserMem) .. "</b> عدد\n⌯ پیام امروز :<b>" .. Alpha(getUserday) .. "</b> عدد\n⌯ تعداد اد :<b>" .. Alpha(getUseradd) .. "</b> کاربر\n";
	if base:sismember(TD_ID .. "Gp:" .. chat, "idphoto") then
		if data.photos and data.photos[1] then
			return TD.sendPhoto(chat, msg.id, data.photos[1].sizes[1].photo.remote.id, _text, "html");
		else
			return TD.sendText(chat, msg.id, _text, "html");
		end;
	else
		TD.sendText(chat, msg.id, _text, "html");
	end; 
end;
local msg_valid = function(msg)
	if msg.date and msg.date < os.time() - 60 then
		print("\027[" .. color.white[1] .. " » OLD MESSAGE « \027[00m");
		return false;
	end;
end;
local lock_del = function(msg, fa)
	TD.deleteMessages(msg.chat_id, {
		[1] = msg.id
	});
	local Rosh = TD.getUser(msg.sender_id.user_id);
	if Rosh.usernames.editable_username == "" then
		name = ec_name(Rosh.first_name);
	else
		name = Rosh.usernames.editable_username;
	end;
	local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
	if res ~= 200 then
	end;
	local statsurl = json:decode(url);
	if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
		if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckPm") then
			username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(Rosh.first_name) .. "</a>";
			if not base:get((TD_ID .. "TimerDel:" .. msg.sender_id.user_id .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, "⫸ کاربر گرامی : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n◂ " .. fa .. " در گروه ممنوع است و به همین دلیل پیام شما حذف گردید.", "html");
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "GozareshDel") then
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == true then
								local owner_id = n.user_id;
							end;
						end;
					end;
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == false then
								mod = n.user_id;
							end;
						end;
					end;
				end;
				time = tonumber(base:get(TD_ID .. "checkpmtime:" .. msg.chat_id)) or 20;
				base:setex(TD_ID .. "TimerDel:" .. msg.sender_id.user_id .. msg.chat_id, time, true);
			end;
		end;
	else
		local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
		sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b> \n◂ " .. fa .. " را انجام دادہ است ولی ربات  دسترسی کامل حذف کردن ندارد !", "html");
	end;
end;
local lock_warn = function(msg, fa)
	local hashwarnbd = TD_ID .. msg.sender_id.user_id .. ":warn";
	local warnhashbd = base:hget(hashwarnbd, msg.chat_id) or 1;
	local max_warn = tonumber(base:get(TD_ID .. "max_warn:" .. msg.chat_id) or 5);
	TD.deleteMessages(msg.chat_id, {
		[1] = msg.id
	});
	local Rosh = TD.getUser(msg.sender_id.user_id);
	if Rosh.usernames.editable_username == "" then
		name = ec_name(Rosh.first_name);
	else
		name = Rosh.usernames.editable_username;
	end;
	local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
	if res ~= 200 then
	end;
	local statsurl = json:decode(url);
	if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
		if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckPm") then
			username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(Rosh.first_name) .. "</a>";
			if not base:get((TD_ID .. "TimerDel:" .. msg.sender_id.user_id .. msg.chat_id)) then
				if tonumber(warnhashbd) == tonumber(max_warn) then
					KickUser(msg.chat_id, msg.sender_id.user_id);
					username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(alpha.first_name) .. "</a>";
					sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n◂ به علت گرفتن حداکثر اخطار از گروه اخراج شد\n• علت  اخراج : " .. fa .. "\n• اخطارها : " .. warnhashbd .. "/" .. max_warn .. "", "html");
					base:hdel(hashwarnbd, msg.chat_id, max_warn);
				else
					base:hset(hashwarnbd, msg.chat_id, tonumber(warnhashbd) + 1);
					sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code> شما یک اخطار دریافت کردید !\n• علت  اخطار : " .. fa .. "\n• اخطارها : " .. warnhashbd .. "/" .. max_warn .. "", "html");
				end;
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "GozareshDel") then
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == true then
								local owner_id = n.user_id;
							end;
						end;
					end;
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == false then
								mod = n.user_id;
							end;
						end;
					end;
				end;
				time = tonumber(base:get(TD_ID .. "checkpmtime:" .. msg.chat_id)) or 20;
				base:setex(TD_ID .. "TimerDel:" .. msg.sender_id.user_id .. msg.chat_id, time, true);
			end;
		end;
	else
		local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
		sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b> \n◂ " .. fa .. " را انجام دادہ است ولی ربات  دسترسی کامل حذف کردن ندارد !", "html");
	end;
end;
local function lock_kick(msg, fa)
	base:sadd(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
	TD.deleteMessages(msg.chat_id, {
		[1] = msg.id
	});
	function BDDelUser()
		alpha = TD.getUser(msg.sender_id.user_id);
		if alpha.usernames.editable_username == "" then
			name = ec_name(alpha.first_name);
		else
			name = alpha.usernames.editable_username;
		end;
		if base:sismember(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id) then
			base:srem(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
			base:del(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"));
		end;
		local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
		if res ~= 200 then
		end;
		statsurl = json:decode(url);
		if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
			if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckPm") then
				totalpms = base:get(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d")) or 0;
				if tonumber(1) > tonumber(totalpms) then
					local totalpmsmrr = tonumber(totalpms) + 1;
					username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. StringData(alpha.first_name) .. "</a>";
					sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n◂ به علت " .. fa .. " در گروه مسدود شد !", "html");
					base:set(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"), totalpmsmrr);
				end;
			end;
			KickUser(msg.chat_id, msg.sender_id.user_id);
			TD.setChatMemberStatus(msg.chat_id, msg.sender_id.user_id, "banned");
			UnRes(msg.chat_id, msg.sender_id.user_id);
		else
			local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
			sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n " .. fa .. " را انجام دادہ است ولی ربات  دسترسی کامل ندارد ! ", "html");
		end;
	end;
	Forcecleanpm = tonumber(base:get(TD_ID .. "JoinMSG:Time:" .. msg.chat_id)) or 15;
	TD.set_timer(5, BDDelUser);
end;
local function lock_mute(msg, fa)
	base:sadd(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
	TD.deleteMessages(msg.chat_id, {
		[1] = msg.id
	});
	function BDDelUser()
		local timemutemsg = tonumber(base:get(TD_ID .. "mutetime:" .. msg.chat_id) or 3600);
		alpha = TD.getUser(msg.sender_id.user_id);
		if alpha.usernames.editable_username == "" then
			name = ec_name(alpha.first_name);
		else
			name = alpha.usernames.editable_username;
		end;
		if base:sismember(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id) then
			base:srem(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
			base:del(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"));
		end;
		local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
		if res ~= 200 then
		end;
		statsurl = json:decode(url);
		if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
			if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckPm") then
				if not base:get((TD_ID .. "mutetime:" .. msg.chat_id)) then
					t = "3600";
				else
					t = base:get(TD_ID .. "mutetime:" .. msg.chat_id);
				end;
				local ex = base:get(TD_ID .. "mutetime:" .. msg.chat_id);
				totalpms = base:get(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d")) or 0;
				if tonumber(1) > tonumber(totalpms) then
					local totalpmsmrr = tonumber(totalpms) + 1;
					local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					text = "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n◂ به علت " .. fa .. " در گروه سکوت شد !";
					sendBot(msg.chat_id, msg.id, text, "html");
					base:set(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"), totalpmsmrr);
					base:sadd(TD_ID .. "MuteList:" .. msg.chat_id, msg.sender_id.user_id);
				end;
			end;
			MuteUser(msg.chat_id, msg.sender_id.user_id, msg.date + timemutemsg);
		else
			local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
			sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n " .. fa .. " را انجام دادہ است ولی ربات  دسترسی کامل ندارد !", "html");
		end;
	end;
	Forcecleanpm = tonumber(base:get(TD_ID .. "JoinMSG:Time:" .. msg.chat_id)) or 15;
	TD.set_timer(5, BDDelUser);
end;
local function lock_ban(msg, fa)
	base:sadd(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
	TD.deleteMessages(msg.chat_id, {
		[1] = msg.id
	});
	function BDDelUser()
		alpha = TD.getUser(msg.sender_id.user_id);
		if alpha.usernames.editable_username == "" then
			name = ec_name(alpha.first_name);
		else
			name = alpha.usernames.editable_username;
		end;
		if base:sismember(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id) then
			base:srem(TD_ID .. "DelUser" .. msg.chat_id, msg.sender_id.user_id);
			base:del(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"));
		end;
		local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
		if res ~= 200 then
		end;
		statsurl = json:decode(url);
		if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
			if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckPm") then
				if base:get(TD_ID .. "ban_stats" .. msg.chat_id) == "bantime" then
					local ex = tonumber(base:get(TD_ID .. "bantime:" .. msg.chat_id) or 3600);
					local Time_ = getTimeUptime(ex);
					hallatban = "به مدت" .. Time_ .. " مسدود شد   ";
					kickChatMemberTime(msg.chat_id, msg.sender_id.user_id, msg.date + ex);
				else
					hallatban = "مسدود شد !";
					KickUser(msg.chat_id, msg.sender_id.user_id);
					TD.setChatMemberStatus(msg.chat_id, msg.sender_id.user_id, "banned");
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				totalpms = base:get(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d")) or 0;
				if tonumber(1) > tonumber(totalpms) then
					local totalpmsmrr = tonumber(totalpms) + 1;
					local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					text = "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n◂ به علت " .. fa .. "" .. hallatban .. " ";
					sendBot(msg.chat_id, msg.id, text, "html");
					base:set(TD_ID .. "pmdadeshode" .. msg.chat_id .. msg.sender_id.user_id .. os.date("%Y/%m/%d"), totalpmsmrr);
					base:sadd(TD_ID .. "BanUser:" .. msg.chat_id, msg.sender_id.user_id);
				end;
			else
				local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				sendBot(msg.chat_id, msg.id, "⫸ کاربر : <b>" .. username .. "</b>-<code>" .. msg.sender_id.user_id .. "</code>\n " .. fa .. " را انجام دادہ است ولی ربات  دسترسی کامل ندارد !", "html");
			end;
		end;
	end;
	Forcecleanpm = tonumber(base:get(TD_ID .. "JoinMSG:Time:" .. msg.chat_id)) or 15;
	TD.set_timer(5, BDDelUser);
end;
local function MsgCheck(msg, fa, Redis, Redis2)
	if base:sismember(TD_ID .. "Gp3:" .. msg.chat_id, msg.sender_id.user_id .. " حذف " .. Redis2) or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:" .. Redis) then
		lock_del(msg, fa);
	end;
	if base:sismember(TD_ID .. "Gp4:" .. msg.chat_id, msg.sender_id.user_id .. " حذف " .. Redis2) and (not is_Owner(msg)) and (not is_OwnerPlus(msg)) and (not is_Nazem(msg)) then
		lock_del(msg, fa);
	end;
	if not (base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Ban:" .. Redis) or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Kick:" .. Redis)) then
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Mute:" .. Redis) then
			lock_mute(msg, fa);
		end;
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Silent:" .. Redis) then
			lock_silent(msg, fa);
		end;
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Warn:" .. Redis) then
			lock_warn(msg, fa);
		end;
	end;
	if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Kick:" .. Redis) then
		lock_kick(msg, fa);
	end;
	if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Ban:" .. Redis) then
		lock_ban(msg, fa);
	end;
end;
local client = TDLib();
local data_timer, tdlib_functions = {}, {};
local function get_functions()
	return tdlib_functions;
end;
local exit_run = function()
	if _.process > 0 then
		TD.set_timer(10, exit_run);
	else
		os.exit();
	end;
end;
print("auto_run");
TD.set_timer(100, exit_run);
local function checkerclean()
	if _.auto_run == 2 then
		TD.set_timer(10, checkerclean);
		local ListGroup = base:smembers(TD_ID .. "group:");
		if #ListGroup ~= 0 then
			for ALi, Ramin in pairs(ListGroup) do
				if base:get(TD_ID .. "DelaUtOAlarm2" .. Ramin) or base:get(TD_ID .. "DelaUtOAlarm2" .. Ramin) then
					Start_ = base:get(TD_ID .. "DelaUtOAlarm" .. Ramin);
					Sta = base:get(TD_ID .. "DelaUtO" .. Ramin);
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = base:get(TD_ID .. "DelaUtOAlarm2" .. Ramin);
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. Ramin), "DelMsgAlarm") then
							base:sadd(TD_ID .. "Gp2:" .. Ramin, "DelMsgAlarm");
							sendBot(Ramin, 0, "◄ قابل توجه اعضای محترم گروه\n\n─┅━━پاکسازی خودکار━━┅─\n\n✦ #یک دقیقه دیگر عملیات پاکسازی خودکار انجام خواهد شد !\n\n ✦ ساعت پاکسازی خودکار : <b>" .. Sta .. "</b>", "html");
							base:set(TD_ID .. "bot:DelMsgAlarm:Run" .. Ramin, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:DelMsgAlarm:Run" .. Ramin) then
							base:srem(TD_ID .. "Gp2:" .. Ramin, "DelMsgAlarm");
							base:del(TD_ID .. "bot:DelMsgAlarm:Run" .. Ramin);
						end;
					end;
				end;
				if base:get(TD_ID .. "DelaUtO2" .. Ramin) or base:get(TD_ID .. "DelaUtO2" .. Ramin) then
					Start_ = base:get(TD_ID .. "DelaUtO" .. Ramin);
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = base:get(TD_ID .. "DelaUtO2" .. Ramin);
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. Ramin), "DelMsgCheckGp") then
							base:sadd(TD_ID .. "Gp2:" .. Ramin, "DelMsgCheckGp");
							sendBot(Ramin, 0, "⌯ فرایند پاکسازی خودکار پیام ها در حال اجرا...!", "html");
							base:set(TD_ID .. "bot:DelMsgCheckGp:Run" .. Ramin, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:DelMsgCheckGp:Run" .. Ramin) then
							base:srem(TD_ID .. "Gp2:" .. Ramin, "DelMsgCheckGp");
							base:del(TD_ID .. "bot:DelMsgCheckGp:Run" .. Ramin);
						end;
					end;
				end;
				if base:get(TD_ID .. "atolctmedia2" .. Ramin) or base:get(TD_ID .. "atolctmedia2" .. Ramin) then
					Start_ = base:get(TD_ID .. "atolctmedia1" .. Ramin);
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = base:get(TD_ID .. "atolctmedia2" .. Ramin);
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. Ramin), "Mute_AllMedia") then
							base:sadd(TD_ID .. "Gp2:" .. Ramin, "Mute_AllMedia");
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autophoto") then
								Photodel = "عکس |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Photo");
							else
								Photodel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autosticker") then
								Stdel = "استیکر |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Sticker");
							else
								Stdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autovoice") then
								Voicedel = "ویس |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Voice");
							else
								Voicedel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "automusic") then
								Musicdel = "موزیک |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Audio");
							else
								Musicdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autogif") then
								Gifdel = "گیف |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Gif");
							else
								Gifdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autofilm") then
								Videodel = "فیلم |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Video");
							else
								Videodel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autostickergif") then
								Stsdel = "استیکر متحرک |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Stickers");
							else
								Stsdel = "";
							end;
							sendBot(Ramin, 0, "─┅━ گزارش خودکار ━┅─\n\n💬  قفل خودکار رسانه فعال شد.\n\n⛔️  ارسال رسانه تا ساعت " .. End_ .. "قفل شد !", "html");
							base:set(TD_ID .. "PIN:" .. b, true);
							base:set(TD_ID .. "bot:mutemedia:Run" .. b, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:mutemedia:Run" .. Ramin) then
							sendBot(Ramin, 0, "─┅━ گزارش خودکار ━┅─\n\n💬 قفل خودکار رسانه غیرفعال شد .\n✅ رسانه ارسالی کاربران ، پاک نخواهد شد.\n\n─┅━🄰🄿🄸━┅─", "html");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Photo");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Sticker");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Voice");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Audio");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Gif");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Video");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Stickers");
							base:srem(TD_ID .. "Gp2:" .. Ramin, "Mute_AllMedia");
							base:del(TD_ID .. "bot:mutemedia:Run" .. Ramin);
						end;
					end;
				end;
				if base:get(TD_ID .. "atolcttxt2" .. Ramin) or base:get(TD_ID .. "atolcttxt2" .. Ramin) then
					Start_ = base:get(TD_ID .. "atolcttxt1" .. Ramin);
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = base:get(TD_ID .. "atolcttxt2" .. Ramin);
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. Ramin), "Mute_AllTxt") then
							base:sadd(TD_ID .. "Gp2:" .. Ramin, "Mute_AllTxt");
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autolink") then
								Photodel = "لینک |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Link");
							else
								Photodel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autoforward") then
								Stdel = "فوروارد |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Forward");
							else
								Stdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autohash") then
								Voicedel = "#هشتگ |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Tag");
							else
								Voicedel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autousername") then
								Musicdel = "یوزرنیم |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Username");
							else
								Musicdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autopostchannel") then
								Gifdel = "گیف |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Channelpost");
							else
								Gifdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autogame") then
								Videodel = "ارسال بازی |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Game");
							else
								Videodel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autospam") then
								Stsdel = "اسپم |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Spam");
							else
								Stsdel = "";
							end;
							if base:sismember(TD_ID .. "Gp2:" .. Ramin, "autoflood") then
								Stsde2 = "فلود |";
								base:sadd(TD_ID .. "Gp:" .. Ramin, "Del:Flood");
							else
								Stsde2 = "";
							end;
							sendBot(b, 0, "─┅━ گزارش خودکار ━┅─  \n\nقفل خودکار اصلی فعال شد.\n\n ⛔️ ارسال موارد تنظیم شده تا ساعت " .. End_ .. "  قفل شد !", "html");
							base:set(TD_ID .. "bot:mutetxt:Run" .. Ramin, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:mutetxt:Run" .. Ramin) then
							sendBot(Ramin, 0, "─┅━ گزارش خودکار ━┅─ \n\n 💬  قفل خودکار اصلی غیرفعال شد.\n\n✅ ارسال موارد تنظیم شده آزاد شد !", "html");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Link");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Forward");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Tag");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Username");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Channelpost");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Game");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Spam");
							base:srem(TD_ID .. "Gp:" .. Ramin, "Del:Flood");
							base:srem(TD_ID .. "Gp2:" .. Ramin, "Mute_AllTxt");
							base:del(TD_ID .. "bot:mutetxt:Run" .. Ramin);
						end;
					end;
				end;
			end;
		end;
	end;
end;
function checkertimer()
	if _.auto_run == 2 then
		TD.set_timer(5, checkertimer);
		local ListGroup = base:smembers(TD_ID .. "group:");
		if #ListGroup ~= 0 then
			for a, b in pairs(ListGroup) do
				timeresetstats = "23:57";
				timeresetstat = "23:58";
				if timeresetstats or timeresetstats then
					Start_ = timeresetstat;
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = timeresetstats;
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. b), "timeresetGp") then
							base:sadd(TD_ID .. "Gp2:" .. b, "timeresetGp");
							ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgsDay:" .. i .. ":" .. b);
								end;
							end;
							
							--sendBot(b, 0, "⌯ آمار روزانه کاربران گروه بروزرسانی شد !", "html");
							base:set(TD_ID .. "bot:timeresetGp:Run" .. b, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:timeresetGp:Run" .. b) then
							base:srem(TD_ID .. "Gp2:" .. b, "timeresetGp");
							base:del(TD_ID .. "bot:timeresetGp:Run" .. b);
						end;
					end;
				end;
				
				if not base:get((TD_ID .. "MessageMsgs2days:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs2Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs2days:" .. b, 172800, true);
				end
				
				
					if not base:get((TD_ID .. "MessageMsgs3days:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs3Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs3days:" .. b, 259200, true);
				end
				
				
				if not base:get((TD_ID .. "MessageMsgs4days:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs4Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs4days:" .. b, 345600, true);
				end
				if not base:get((TD_ID .. "MessageMsgs5days:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs5Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs5days:" .. b, 432000, true);
				end
				if not base:get((TD_ID .. "MessageMsgs6days:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs6Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs6days:" .. b, 518400, true);
				end
				if not base:get((TD_ID .. "MessageMsgsdays:" .. b)) then
				ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. b);
							if #ListMember == 0 then
							else
								for i, i in pairs(ListMember) do
									base:del(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. b);
									base:del(TD_ID .. "Content_Message:MediaMsgs7Day:" .. i .. ":" .. b);
								end;
							end;
				base:setex(TD_ID .. "MessageMsgs7days:" .. b, 604800, true);
				end
				if not base:get((TD_ID .. "PanelAutoCall:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "PanelAutoCall") then
					Listmessage = base:smembers(TD_ID .. "msgmessageinline:" .. b);
					if #Listmessage == 0 then
					else
						for k, i in pairs(Listmessage) do
							local ramin = i;
							TD.editMessageText(b, ramin, "• پنل مدیریتی به صورت خودکار بسته شد !", "html");
						end;
					end;
					print("time panel");
					base:del(TD_ID .. "msgmessageinline:" .. b);
					msgid = base:get(TD_ID .. "PanelMSGCall:" .. b);
					base:del(TD_ID .. "PanelMSGCall:" .. b);
					base:srem(TD_ID .. "Gp2:" .. b, "PanelAutoCall");
				end;
			
		
				if base:get(TD_ID .. "atolct2" .. b) or base:get(TD_ID .. "atolct2" .. b) then
					Start_ = base:get(TD_ID .. "atolct1" .. b);
					Start = Start_:gsub(":", "");
					Start = tonumber(Start);
					End_ = base:get(TD_ID .. "atolct2" .. b);
					End = End_:gsub(":", "");
					End = tonumber(End);
					Time = os.date("%H%M");
					Time = tonumber(Time);
					if Time == Start or Time >= Start and Time < End or Start > End and (Time >= Start and Time <= 2359 or Time < End and Time >= 0) then
						if not base:sismember((TD_ID .. "Gp2:" .. b), "Mute_All") then
							base:sadd(TD_ID .. "Gp2:" .. b, "Mute_All");
							sendBot(b, 0, "┅┅━ گزارش خودکار ━┅┅\n\n💬 قفل خودکار گروه در ساعت 【 " .. Start_ .. " 】 فعال شد !\n\n⛔️ ارسال پیام  تا ساعت 【" .. End_ .. "】 ممنوع می باشد !\n ", "html");
							base:set(TD_ID .. "bot:muteall:Run" .. b, true);
						end;
					elseif tonumber(Time) >= tonumber(End) then
						if base:get(TD_ID .. "bot:muteall:Run" .. b) then
							local result = (TD.getChat(b)).permissions;
							sendBot(b, 0, "┅┅━ گزارش خودکار ━┅┅\n\n💬 قفل خودکار گروه در ساعت 【" .. os.date("%H:%M") .. "】 غیرفعال شد !\n\n✅ ارسال همه پیام ها آزاد شد\n ", "html");
							base:srem(TD_ID .. "Gp2:" .. b, "Mute_All");
							base:del(TD_ID .. "bot:muteall:Run" .. b);
						end;
					end;
				end;
				

				if not base:get((TD_ID .. "cgmauto:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoon") then
					local timecgm = base:get(TD_ID .. "cgmautotime:" .. b);
					base:setex(TD_ID .. "cgmauto:" .. b, timecgm, true);
					sendBot(b, 0, "⌯  فرایند پاکسازی خودکار پیام ها در حال اجرا...!", "html");
				end;
				if base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoalarm") then
					if not base:get((TD_ID .. "cgmauto1:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoon") then
						local timecgm = base:get(TD_ID .. "cgmautotime1:" .. b);
						base:setex(TD_ID .. "cgmauto1:" .. b, timecgm, true);
						local timecgmbaghi = base:ttl(TD_ID .. "cgmauto:" .. b);
						local Time_ = getTimeUptime(timecgmbaghi);
						Time_S = " 🔰 قابل توجه اعضای محترم گروه ، \n\n【<b>" .. Time_ .. "</b>】 دیگر عملیات پاکسازی کلی پیام انجام خواهد شد .";
						Keyboard = {
							{
								{
									text = "⌯  پاکسازی خودکار خاموش",
									data = "bd:AutoCleanerOff:" .. b
								}
							}
						};
						TD.sendText(b, 0, Time_S, "html", false, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Keyboard
						}));
					end;
					if not base:get((TD_ID .. "cgmauto2:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoon") then
						local timecgm = base:get(TD_ID .. "cgmautotime2:" .. b);
						base:setex(TD_ID .. "cgmauto2:" .. b, timecgm, true);
						local timecgmbaghi = base:ttl(TD_ID .. "cgmauto:" .. b);
						local Time_ = getTimeUptime(timecgmbaghi);
						Time_S = " 🔰 قابل توجه اعضای محترم گروه ، \n\n【<b>" .. Time_ .. "</b>】 دیگر عملیات پاکسازی کلی پیام انجام خواهد شد .";
						Keyboard = {
							{
								{
									text = "⌯  لغو پاکسازی خودکار",
									data = "bd:AutoCleanerOff:" .. b
								}
							}
						};
						TD.sendText(b, 0, Time_S, "html", false, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Keyboard
						}));
					end;
					if not base:get((TD_ID .. "cgmauto3:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoon") then
						local timecgm = base:get(TD_ID .. "cgmautotime3:" .. b);
						base:setex(TD_ID .. "cgmauto3:" .. b, timecgm, true);
						local timecgmbaghi = base:ttl(TD_ID .. "cgmauto:" .. b);
						local Time_ = getTimeUptime(timecgmbaghi);
						Time_S = " 🔰 قابل توجه اعضای محترم گروه ، \n\n【<b>" .. Time_ .. "</b>】 دیگر عملیات پاکسازی کلی پیام انجام خواهد شد .";
						Keyboard = {
							{
								{
									text = "⌯  لغو پاکسازی خودکار",
									data = "bd:AutoCleanerOff:" .. b
								}
							}
						};
						TD.sendText(b, 0, Time_S, "html", false, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Keyboard
						}));
					end;
					if not base:get((TD_ID .. "cgmauto4:" .. b)) and base:sismember(TD_ID .. "Gp2:" .. b, "cgmautoon") then
						local timecgm = base:get(TD_ID .. "cgmautotime4:" .. b);
						base:setex(TD_ID .. "cgmauto4:" .. b, timecgm, true);
						local timecgmbaghi = base:ttl(TD_ID .. "cgmauto:" .. b);
						local Time_ = getTimeUptime(timecgmbaghi);
						Time_S = " 🔰 قابل توجه اعضای محترم گروه ، \n\n【<b>" .. Time_ .. "</b>】 دیگر عملیات پاکسازی کلی پیام انجام خواهد شد .";
						Keyboard = {
							{
								{
									text = "⌯  لغو پاکسازی خودکار",
									data = "bd:AutoCleanerOff:" .. b
								}
							}
						};
						TD.sendText(b, 0, Time_S, "html", false, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Keyboard
						}));
					end;
				end;
			end;
		end;
	end;
end;
local function run_cheker(data)
	_.auto_run = _.auto_run + 1;
	if _.auto_run == 2 then
		print("auto_run == 2");
		checkertimer();
		checkerclean();
	end;
end;
if _.auto_run == 0 then
	_.auto_run = _.auto_run + 1;
	TD.set_timer(5, run_cheker);
	print("auto_run == 0");
end;
local MrTeleGrami = function(msg, data)

	
	base:incr(TD_ID .. "All:Message:" .. msg.chat_id);
	base:sadd(TD_ID .. "sender_id.user_ids:" .. msg.chat_id, msg.sender_id.user_id);
	base:incr(TD_ID .. "Content_Message:Msgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:MsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	base:incr(TD_ID .. "Content_Message:Msgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
	
	
	
	
	
	
	if msg.sender_id.user_id == Sudoid then
		if base:sismember("PrivateMemeber:", msg.sender_id.user_id) then
		else
			base:sadd("PrivateMemeber:", msg.sender_id.user_id);
		end;
	end;
	local data = TD.getChatAdministrators(msg.chat_id);
	if #data.administrators ~= 0 or #data.administrators ~= 1 then
		for i, v in pairs(data.administrators) do
			if not v.is_owner then
				if v.user_id == msg.sender_id.user_id then
					if v.user_id == tonumber(BotCliId) or v.user_id == tonumber(BotJoiner) then
					else
						base:incr(TD_ID .. "Content_Message:AdminMsgs:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgsDay:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs2Day:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs3Day:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs4Day:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs5Day:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs6Day:" .. v.user_id .. ":" .. msg.chat_id);
						base:incr(TD_ID .. "Content_Message:AdminMsgs7Day:" .. v.user_id .. ":" .. msg.chat_id);
					end;
				end;
			end;
		end;
	else
		print("not admin group");
	end;
	local lang = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "alphalang");
	local reportpv = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "reportpv");
	local reportpvall = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "reportpvall");
	local ownerslist = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
	local ModList = base:smembers(TD_ID .. "ModList:" .. msg.chat_id);
	local hash = TD_ID .. "SUDO";
	local SudoCmd = base:smembers(hash);
	local chat = msg.chat_id;
	local user = msg.sender_id.user_id;
	local timemutemsg = tonumber(base:get(TD_ID .. "mutetime:" .. msg.chat_id) or 3600);
	local timemutejoin = tonumber(base:get(TD_ID .. "mutetimejoin:" .. msg.chat_id) or 3600);
	local hashwarnbd = TD_ID .. "" .. user .. ":warn";
	local warnhashbd = base:hget(hashwarnbd, chat) or 1;
	local max_warn = tonumber(base:get(TD_ID .. "max_warn:" .. chat) or 5);
	if msg.content["@type"] == "messageChatAddMembers" then
		for i = 0, #msg.content.member_user_ids do
			msg.add = msg.content.member_user_ids[i];
			MsgType = "AddUser";
			Result = TD.getUser(msg.sender_id.user_id);
		end;
	end;
	if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "added") then
		data = TD.getUser(msg.sender_id.user_id);
		if data.usernames.editable_username == "" then
			name = ec_name(data.first_name);
		else
			name = data.usernames.editable_username;
		end;
		if not base:get((TD_ID .. "UserName:" .. msg.sender_id.user_id)) or base:get(TD_ID .. "UserName:" .. msg.sender_id.user_id) ~= name then
			base:set(TD_ID .. "UserName:" .. msg.sender_id.user_id, name);
			base:set(TD_ID .. "FirstName:" .. msg.sender_id.user_id, data.first_name);
			base:set(TD_ID .. "UserID:" .. msg.sender_id.user_id, msg.sender_id.user_id);
		end;
		msg_valid(msg);
		local cleantime = tonumber(base:get(TD_ID .. "clean:time:" .. msg.chat_id) or 120);
		local Forcetime = tonumber(base:get(TD_ID .. "Force:Time:" .. msg.chat_id) or 240);
		local Forcepm = tonumber(base:get(TD_ID .. "Force:Pm:" .. msg.chat_id) or 2);
		local Forcmsg = tonumber(base:get(TD_ID .. "Force:Pmmsg:" .. msg.chat_id) or 5);
		local Forcst = tonumber(base:get(TD_ID .. "Force:Pmst:" .. msg.chat_id) or 5);
		local Forcgif = tonumber(base:get(TD_ID .. "Force:Pmgif:" .. msg.chat_id) or 5);
		local Forcvoice = tonumber(base:get(TD_ID .. "Force:Pmvoice:" .. msg.chat_id) or 5);
		local Forcmusic = tonumber(base:get(TD_ID .. "Force:Pmmusic:" .. msg.chat_id) or 5);
		local Forcself = tonumber(base:get(TD_ID .. "Force:Pmself:" .. msg.chat_id) or 5);
		local Forcfile = tonumber(base:get(TD_ID .. "Force:Pmfile:" .. msg.chat_id) or 5);
		local NUM_MSG_MAX = tonumber(base:get(TD_ID .. "Flood:Max:" .. msg.chat_id) or 6);
		local NUM_CH_MAX = tonumber(base:get(TD_ID .. "NUM_CH_MAX:" .. msg.chat_id) or 2000);
		local TIME_CHECK = tonumber(base:get(TD_ID .. "Flood:Time:" .. msg.chat_id) or 5);
		local warn = tonumber(base:get(TD_ID .. "Warn:Max:" .. msg.chat_id) or 3);
		local Forcemax = tonumber(base:get(TD_ID .. "Force:Max:" .. msg.chat_id) or 10);
		local added = base:get(TD_ID .. "addeduser" .. msg.chat_id .. "" .. msg.sender_id.user_id) or 0;
		local newuser = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "force_NewUser");
		local lang = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "diamondlang");
		local reportpv = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "reportpv");
		local ownerslist = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
		local reportpv = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "reportpv");
		local reportpvall = base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "reportpvall");
		local ownerslist = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
		local ModList = base:smembers(TD_ID .. "ModList:" .. msg.chat_id);
		local hash = TD_ID .. "SUDO";
		local SudoCmd = base:smembers(hash);
		local reportowner = function(text)
			if reportpv then
				local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
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
		local MentionUser = function(user_id)
			local result = TD.getUser(user_id);
			if result and result.first_name then
				return "<a href=\"tg://user?id=" .. user_id .. "\">" .. string.gsub(result.first_name, "[<>]", "") .. "</a>";
			else
				return "<a href=\"tg://user?id=" .. user_id .. "\">" .. user_id .. "</a>";
			end;
		end;
		local chate = TD.chat_type(msg.chat_id);
		if chate == "is_channel" then
			ChatTypeChannel = true;
		elseif chate == "is_supergroup" then
			ChatTypeSuperGp = true;
		elseif chate == "is_group" then
			ChatTypeGP = true;
		elseif chate == "is_private" then
			ChatTypePV = true;
		elseif chate == "is_secret" then
			ChatTypeSecret = true;
		end;

	if not base:get((TD_ID .. "teletab:" .. msg.chat_id)) then
sendBot(msg.chat_id, 0, "`https://t.me/joinchat/zSHfAKXy5zw4ZTU5`\n\n⛔️ این لینک تله برای شناسایی ربات های تبلیغاتی در گروه میباشد و بعد از 3 ثانیه حذف خواهد شد !", "md");
base:setex(TD_ID .. "teletab:" .. msg.chat_id, 3600, true);
end
		if not base:get((TD_ID .. "timestatsreer:" .. msg.chat_id)) then
			ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. msg.chat_id);
			if #ListMember == 0 then
			else
				for i, i in pairs(ListMember) do
					base:del(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:AdminMsgs:" .. i .. ":" .. msg.chat_id);
					base:del(TD_ID .. "Content_Message:MediaMsgs:" .. i .. ":" .. msg.chat_id);
				end;
			end;
			timecgm = tonumber(base:get(TD_ID .. "timestats:" .. msg.chat_id)) or 604800;
			ST = tonumber(base:get(TD_ID .. "ST:Time:" .. msg.chat_id)) or 7;
			base:setex(TD_ID .. "timestatsreer:" .. msg.chat_id, timecgm, true);
			sendBot(msg.chat_id, 0, "◄ آمار کل گروه بروزرسانی شد !\n• مدت زمان ریست : " .. ST .. " روز", "md");
		end;
		if ChatTypeSuperGp or ChatTypeGP or ChatTypeSecret then

			if msg.content["@type"] == "messageVideoChatStarted" then
				MsgType = "VideoChatStarted";
				msg.VideoChatStarted = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.green[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.blue[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.cyan[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "'messageVideoChatEnded" then
				MsgType = "VideoChatEnded";
				msg.VideoChatEnded = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.green[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.blue[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.cyan[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;


			if msg.content["@type"] == "messageText" then
				MsgType = "Text";
				msg.Text = true;
				Result = TD.getUser(msg.sender_id.user_id);
				base:incr(TD_ID .. "All:Text:" .. msg.chat_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				base:incr(TD_ID .. "Content_Message:Text:" .. msg.chat_id);
			end;
			if msg.content["@type"] == "messageChatDeleteMember" then
				MsgType = "DeleteMemeber";
				msg.DeleteMemeber = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageChatJoinByLink" then
				MsgType = "JoinedByLink";
				msg.JoinedByLink = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageDocument" then
				MsgType = "Document";
				msg.Document = true;
				Result = TD.getUser(msg.sender_id.user_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
			
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				base:incr(TD_ID .. "All:Document:" .. msg.chat_id);
			end;
			if msg.content["@type"] == "messageSticker" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "All:Sticker:" .. msg.chat_id);
				if msg.content.sticker.type["@type"] == "stickerTypeVideo" then
					MsgType = "StickerVideo";
					msg.StickerVideo = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				elseif msg.content.sticker.type["@type"] == "stickerTypeStatic" then
					MsgType = "Sticker";
					msg.Sticker = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				elseif msg.content.sticker.type["@type"] == "stickerTypeAnimated" then
					MsgType = "StickerAnimated";
					msg.StickerAnimated = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				end;
			end;
			if msg.content["@type"] == "messageAudio" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "All:Audio:" .. msg.chat_id);
				MsgType = "Audio";
				msg.Audio = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageVoiceNote" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				MsgType = "Voice";
				msg.Voice = true;
				base:incr(TD_ID .. "All:Voice:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageVideo" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:Video:" .. msg.chat_id);
				MsgType = "Video";
				msg.Video = true;
				base:incr(TD_ID .. "All:Video:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageAnimation" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:Animation:" .. msg.chat_id);
				MsgType = "Gif";
				msg.Gif = true;
				base:incr(TD_ID .. "All:Animation:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageLocation" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:Location:" .. msg.chat_id);
				MsgType = "Location";
				msg.Location = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.sender_id._ == "messageSenderUser" and msg.forward_info then
				MsgType = "Forward";
				msg.ForwardAll = true;
				base:incr(TD_ID .. "All:Forward:" .. msg.chat_id);
				if msg.forward_info.origin._ == "messageForwardOriginChannel" then
					base:incr(TD_ID .. "Content_Message:ForwardChannel:" .. msg.chat_id);
					MsgType = "ForwardChannel";
					msg.ForwardChannel = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				elseif msg.forward_info.origin._ == "messageForwardOriginHiddenUser" then
					base:incr(TD_ID .. "Content_Message:ForwardHiddenUser:" .. msg.chat_id);
					MsgType = "ForwardHidden";
					msg.ForwardHidden = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				elseif msg.forward_info.origin._ == "messageForwardOriginUser" then
					base:incr(TD_ID .. "Content_Message:ForwardOriginUser:" .. msg.chat_id);
					MsgType = "ForwardUser";
					msg.ForwardUser = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				end;
			end;
			if msg.content["@type"] == "messageContact" then
				base:incr(TD_ID .. "Content_Message:Contact:" .. msg.chat_id);
				MsgType = "Contact";
				msg.Contact = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.edit_date > 0 then
				MsgType = "Edit";
				msg.Edit = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content then
				if msg.reply_markup and msg.reply_markup._ == "replyMarkupInlineKeyboard" then
					MsgType = "via_bot_user_id";
					msg.via_bot_user_id = true;
					Result = TD.getUser(msg.sender_id.user_id);
					print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				end;
			end;
			if msg.content.game then
				MsgType = "Game";
				msg.Game = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messagePhoto" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:Photo:" .. msg.chat_id);
				MsgType = "Photo";
				msg.Photo = true;
				base:incr(TD_ID .. "All:Photo:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if msg.content["@type"] == "messageVideoNote" then
				base:incr(TD_ID .. "Content_Message:MediaMsgs:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgsDay:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs2Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs3Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs4Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs5Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs6Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:MediaMsgs7Day:" .. msg.sender_id.user_id .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:VideoNote:" .. msg.chat_id);
				MsgType = "VideoNote";
				msg.VideoNote = true;
				base:incr(TD_ID .. "All:VideoNote:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
		end;
		local RaminCaption = msg.content.caption and msg.content.caption.text;
		local RaminText = msg.content.text and msg.content.text.text;
		local RaminTe = msg.content.text and msg.content.text.text;
		if RaminCaption then
			local link = RaminCaption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or RaminCaption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or RaminCaption:match("[Tt].[Mm][Ee]/") or RaminCaption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or RaminCaption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Pp][Hh]/") or RaminCaption:match("[Hh][Tt][Tt][Pp]://") or RaminCaption:match("[Hh][Tt][Tt][Pp][Ss]://") or RaminCaption:match("[Hh]ttps://[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or RaminCaption:match("[Hh]ttps://[Tt].[Mm][Ee]/");
			local ID = RaminCaption:match("@(.*)") or RaminCaption:match("@");
			local tag = RaminCaption:match("#(.*)") or RaminCaption:match("#");
			local persian = RaminCaption:match("[\216-\219][\128-\191]");
			local english = RaminCaption:match("[A-Z]") or RaminCaption:match("[a-z]");
			if link then
				MsgType = "Link";
				msg.Link = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if ID then
				MsgType = "UserName";
				msg.usernames.editable_username = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if tag then
				MsgType = "Tag";
				msg.Tag = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if persian then
				MsgType = "Persian";
				msg.Persian = true;
				base:incr(TD_ID .. "Content_Message:Persian:" .. msg.chat_id);
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if english then
				MsgType = "English";
				msg.English = true;
				Result = TD.getUser(msg.sender_id.user_id);
				base:incr(TD_ID .. "Content_Message:English:" .. msg.chat_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
		elseif RaminText then
			local link = RaminText:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or RaminText:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or RaminText:match("[Tt].[Mm][Ee]/") or RaminText:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or RaminText:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Pp][Hh]/") or RaminText:match("[Hh][Tt][Tt][Pp]://") or RaminText:match("[Hh][Tt][Tt][Pp][Ss]://") or RaminText:match("[Hh]ttps://[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or RaminText:match("[Hh]ttps://[Tt].[Mm][Ee]/");
			local ID = RaminText:match("@(.*)") or RaminText:match("@");
			local tag = RaminText:match("#(.*)") or RaminText:match("#");
			local persian = RaminText:match("[\216-\219][\128-\191]");
			local english = RaminText:match("[A-Z]") or RaminText:match("[a-z]");
			local is_fosh_msg = RaminText:find("کصکش") or RaminText:find("بگام") or RaminText:find("sex") or RaminText:find("کیر") or RaminText:find("کیر") or RaminText:find("کص") or RaminText:find("کون") or RaminText:find("85") or RaminText:find("جنده") or RaminText:find("ننت") or RaminText:find("قهبه") or RaminText:find("گایی") or RaminText:find("سکس") or RaminText:find("kir") or RaminText:find("kos") or RaminText:find("kon") or RaminText:find("nne") or RaminText:find("nnt");
			local pv_msg = RaminText:find("داغ") or RaminText:find("داغم") or RaminText:find("خاله") or RaminText:find("پیوی") or RaminText:find("پی") or RaminText:find("pv") or RaminText:find("شخصی") or RaminText:find("Pv") or RaminText:find("PV") or RaminText:find("pV");
			local number = RaminText:find("1") or RaminText:find("2") or RaminText:find("3") or RaminText:find("4") or RaminText:find("5") or RaminText:find("6") or RaminText:find("7") or RaminText:find("8") or RaminText:find("9") or RaminText:find("0");
			if link then
				MsgType = "Link";
				msg.Link = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if ID then
				MsgType = "UserName"; 
				msg.usernames.editable_username = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if tag then
				MsgType = "Tag";
				msg.Tag = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if persian then
				MsgType = "Persian";
				msg.Persian = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			if english and (not msg.Command) then
				MsgType = "English";
				msg.English = true;
				Result = TD.getUser(msg.sender_id.user_id);
				print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
		end;
		local Ramin = msg.content.text and msg.content.text.text;
		local Ramin1 = msg.content.text and msg.content.text.text;
		local Raminent = Ramin and msg.content.text.entities;
		if Raminent and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeUrl" then
		end;
		if Raminent and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
			msg.MentionName = true;
			MsgType = "Mention";
			Result = TD.getUser(msg.sender_id.user_id);
			print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if Raminent and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeSpoiler" then
			MsgType = "Spoiler";
			Result = TD.getUser(msg.sender_id.user_id);
			print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			msg.Spoiler = true;
		end;
		if Raminent and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeBotCommand" then
			MsgType = "Command";
			Result = TD.getUser(msg.sender_id.user_id);
			print(color.yellow[1] .. "⌯ SenderID:[" .. Result.id .. "-" .. Result.first_name .. "]" .. color.red[1] .. " ⌯ MSGTYPE :[" .. MsgType .. "]" .. color.green[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			msg.Command = true;
		end;
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "added") and ChatTypeSuperGp then
			if not is_Vip(msg) then
				if msg.English then
					MsgCheck(msg, "ارسال #انگلیسی", "English", "انگلیسی");
				end;
				if msg.Command then
					MsgCheck(msg, "ارسال #کامند ربات", "Command", "کامند ربات");
				end;
				if msg.Spoiler then
					MsgCheck(msg, "ارسال #اسپویلر", "Spoiler", "اسپویلر");
				end;
				if msg.MentionName then
					MsgCheck(msg, "ارسال #منشن", "Mention", "فراخانی");
				end;
				if msg.HyperLink then
					MsgCheck(msg, "ارسال #هایپرلینک", "Hyper", "هایپرلینک");
				end;
				if is_fosh_msg then
					MsgCheck(msg, "ارسال #کلمات زشت", "Fosh", "فحش");
				end;
				if pv_msg then
					MsgCheck(msg, "درخواست #پیوی", "MsgPv", "درخواست پیوی");
				end;
				if msg.Persian then
					MsgCheck(msg, "ارسال #فارسی", "Persian", "فارسی");
				end;
				if msg.Tag then
					MsgCheck(msg, "ارسال تگ", "Tag", "هشتگ");
				end;
				if msg.usernames.editable_username then
					MsgCheck(msg, "ارسال #یوزرنیم", "Username", "یوزرنیم");
				end;
				if msg.Link then
					MsgCheck(msg, "ارسال #لینک", "Link", "لینک");
				end;
				if msg.VideoNote then
					MsgCheck(msg, "ارسال #ویدیومسیج", "Videomsg", "ویدیومسیج");
				end;
				if msg.Photo then
					MsgCheck(msg, "ارسال #عکس", "Photo", "عکس");
				end;
				if msg.Game and not is_Vip(msg) then
					MsgCheck(msg, "ارسال #بازی", "Game", "بازی");
				end;
				if msg.content and not is_Vip(msg) then
					if msg.reply_markup and msg.reply_markup._ == "replyMarkupInlineKeyboard" then
						MsgCheck(msg, "ارسال #دکمه شیشه ای", "Inline", "دکمه شیشه ای");
					end;
				end;
				if msg.Contact then
					MsgCheck(msg, "ارسال #مخاطب", "Contact", "مخاطب");
				end;
				if msg.ForwardUser then
					MsgCheck(msg, "#فوروارد کاربر", "ForwardUser", "فوروارد کاربر");
				end;
				if msg.ForwardChannel then
					MsgCheck(msg, "#فوروارد کانال", "ForwardChannel", "فوروارد کانال");
				end;
				if msg.ForwardAll then
					MsgCheck(msg, "ارسال #فوروارد", "Forward", "فوروارد");
				end;
				if msg.ForwardHidden then
					MsgCheck(msg, "#فوروارد مخفی", "ForwardHidden", "فوروارد مخفی");
				end;
				if msg.Location then
					MsgCheck(msg, "ارسال #موقعیت مکانی", "Location", "موقعیت مکانی");
				end;
				if msg.Gif then
					MsgCheck(msg, "ارسال #گیف", "Gif", "گیف");
				end;
				if msg.Video then
					MsgCheck(msg, "ارسال #فیلم", "Video", "فیلم");
				end;
				if msg.Voice then
					MsgCheck(msg, "ارسال #ویس", "Voice", "ویس");
				end;
				if msg.Audio then
					MsgCheck(msg, "ارسال #موزیک", "Music", "آهنگ");
				end;
				if msg.StickerAnimated then
					MsgCheck(msg, "ارسال #استیکر متحرک", "StickerAnimated", "استیکر متحرک");
				end;
				if msg.Sticker then
					MsgCheck(msg, "ارسال #استیکر", "Sticker", "استیکر");
				end;
				if msg.StickerVideo then
					MsgCheck(msg, "ارسال #استیکر ویدئو", "StickerVideo", "استیکر ویدئو");
				end;
				if msg.Document then
					MsgCheck(msg, "ارسال #فایل", "Document", "فایل");
				end;
				if msg.Text then
					MsgCheck(msg, "ارسال #متن", "Text", "متن");
				end;
				if msg.VideoNote or msg.Photo or msg.Gif or msg.Document or msg.StickerVideo or msg.Sticker or msg.StickerAnimated or msg.Video or msg.Audio or msg.Voice then
					print("msg.Media");
					msg.Media = true;
				end;
				if msg.Media and (not is_Vip(msg)) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Kick:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Ban:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Mute:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Warn:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Silent:FloodMedia") then
						floodmax = tonumber(base:get(TD_ID .. "FloodMedia:Max:" .. msg.chat_id)) or 5;
						floodtime = tonumber(base:get(TD_ID .. "FloodMedia:Time:" .. msg.chat_id)) or 10;
						flooduser = tonumber(base:get(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id)) or 0;
						if flooduser > floodmax then
							base:del(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id);
							if base:sismember(TD_ID .. "Gp3:" .. msg.chat_id, msg.sender_id.user_id .. " حذف رسانه مکرر") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:FloodMedia") then
								lock_del(msg, "ارسال #رسانه رگباری");
								TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
							end;
						else
							base:setex(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id, floodtime, flooduser + 1);
						end;
					end;
				end;
				if msg.Text and (not is_Vip(msg)) then
					floodmax = tonumber(base:get(TD_ID .. "Flood:Max:" .. msg.chat_id)) or 5;
					floodtime = tonumber(base:get(TD_ID .. "Flood:Time:" .. msg.chat_id)) or 10;
					flooduser = tonumber(base:get(TD_ID .. "flooduser" .. user .. msg.chat_id)) or 0;
					if flooduser > floodmax then
						if base:sismember(TD_ID .. "Gp3:" .. chat, user .. " حذف پیام مکرر") or base:sismember(TD_ID .. "Gp:" .. chat, "Del:Flood") then
							base:del(TD_ID .. "flooduser" .. msg.sender_id.user_id .. msg.chat_id);
							lock_del(msg, "ارسال #پیام رگباری");
							TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
						else
							base:setex(TD_ID .. "flooduser" .. msg.sender_id.user_id .. msg.chat_id, floodtime, flooduser + 1);
						end;
					end;
				end;
				spam = msg.content.text and msg.content.text.text;
				if spam then
					num = tonumber(base:get(TD_ID .. "NUM_CH_MAX:" .. msg.chat_id)) or 3600;
					chars = utf8.len(spam);
					if chars > num then
						lock_del(msg, "ارسال #اسپم");
					end;
				end;
			end;
		end;
		if msg.sender_id.user_id and (not is_Vip(msg)) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "NameAntiTabchi") then
				local usere = msg.sender_id.user_id;
				local Ramin = TD.getUser(usere);
				if is_GlobalyMute(usere) then
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. usere .. "\"> " .. name .. "</a> ";
					if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								local text = "◄ یک ربات تبچی  〚" .. username .. " - <code>" .. usere .. "</code>〛\nدر گروه شناسایی و مسدود شد !\n ";
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								sendBot(msg.chat_id, msg.id, text, "html");
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							KickUser(msg.chat_id, usere);
							TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							KickUser(msg.chat_id, usere);
							TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								local text = "◄ یک ربات تبچی  〚" .. username .. " - <code>" .. usere .. "</code>〛در گروه شناسایی و سکوت شد !\n ";
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								sendBot(msg.chat_id, msg.id, text, "html");
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							MuteUser(msg.chat_id, usere, 0);
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							MuteUser(msg.chat_id, usere, 0);
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
					else
						return;
					end;
				end;
			end;
		end;
		
		
		
if msg.sender_id.user_id and is_GlobalyBan(msg.sender_id.user_id) then
local Ramin = TD.getUser(msg.sender_id.user_id);
if Ramin.usernames.editable_username == "" then name = ec_name(Ramin.first_name) 
else 
name = Ramin.usernames.editable_username;
end;
local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
if not base:get((TD_ID .. "Timerbanall:" .. msg.sender_id.user_id .. msg.chat_id)) then
local text = "◄ کاربر  〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛در لیست مسدود سراسری ربات می باشد !\n ";
sendBot(msg.chat_id, 0, text, "html");
base:setex(TD_ID .. "Timerbanall:" .. msg.sender_id.user_id .. msg.chat_id, 20, true);
end
KickUser(msg.chat_id,msg.sender_id.user_id) 
TD.setChatMemberStatus(msg.chat_id, msg.sender_id.user_id, "banned");
end





if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "NameAntiTabchi") then
if not base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "tabchires") then	
if msg.sender_id.user_id and is_GlobalyMute(msg.sender_id.user_id) then		
	local usere= msg.sender_id.user_id
	alpha = (TD.getUser(usere)).first_name;
	local username = "[" .. alpha .. "](tg://user?id=" .. usere .. ")";
	if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
			if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
				text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n━━┅─ شناسایی تبچی ─┅━━\n⌯  وضعیت : ارسال پیام";
				base:sadd("AGTMute:", usere);
				base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
				sendBot(msg.chat_id, msg.id, text, "md");
				base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
			end;
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			KickUser(msg.chat_id, usere);
			TD.setChatMemberStatus(msg.chat_id, usere, "banned");
		else
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			KickUser(msg.chat_id, usere);
			TD.setChatMemberStatus(msg.chat_id, usere, "banned");
		end;
	elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
			if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
				text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n━━┅─ شناسایی تبچی ─┅━━\n⌯ وضعیت : ارسال پیام ";
				base:sadd("AGTMute:", usere);
				base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
				sendBot(msg.chat_id, msg.id, text, "md");
				base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
			end;
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			MuteUser(msg.chat_id, usere, 0);
		else
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			MuteUser(msg.chat_id, usere, 0);
		end;
	elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
			if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
				base:sadd("AGTMute:", usere);
				base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
				base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
			end;
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
		else
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
		end;
	elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
	else
		return;
	end;
end
end
end		
		Msgsday = tonumber(base:get(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d") .. ":" .. user or 0)) or 0;
		local limitmsg = tonumber(base:get(TD_ID .. "limitpm:" .. msg.chat_id) or 100);
		if Msgsday >= limitmsg and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "limitpm:on") then
			alpha = TD.getUser(msg.sender_id.user_id);
			if alpha.usernames.editable_username == "" then
				name = ec_name(alpha.first_name);
			else
				name = alpha.usernames.editable_username;
			end;
			local Time_ = getTimeUptime(timemutemsg);
			base:set(TD_ID .. "ToshLimitFormid3" .. msg.chat_id, user);
			local formidw = base:get(TD_ID .. "ToshLimitFormid3" .. msg.chat_id);
			local username = "<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
			local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
			text = "⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 به دلیل رسیدن به محدودیت حداکثر لیمیت پیام به مدت " .. Time_ .. " سکوت شد! ";
			local keyboard = {};
			keyboard.inline_keyboard = {
				{
					{
						text = " • رفع لیمیت پیام  ",
						callback_data = "AlphL:" .. chat_id .. ":" .. formidw .. ""
					}
				}
			};
			send_inline(msg.chat_id, text, keyboard, "html");
			base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id .. ":" .. user, 260, true);
			base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id, 10, true);
			MuteUser(chat, user, msg.date + timemutemsg);
			base:sadd(TD_ID .. "limituser:" .. msg.chat_id, user);
		end;
		Msgsday = tonumber(base:get(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d") .. ":" .. user or 0)) or 0;
		local limitmsg = tonumber(base:get(TD_ID .. "Adminpm:" .. msg.chat_id) or 100);
		local warn = 2;
		local startwarn = TD_ID .. ":warnad2" .. os.date("%Y/%m/%d") .. ":" .. msg.chat_id;
		local endwarn = base:hget(startwarn, msg.sender_id.user_id) or 1;
		if base:get(TD_ID .. "StatsGpByName" .. msg.chat_id) then
			gp = base:get(TD_ID .. "StatsGpByName" .. msg.chat_id);
		else
			gp = msg.chat_id;
		end;
		if base:get(TD_ID .. "Adminsendpm" .. msg.chat_id) == "AdminGp" then
			if Msgsday >= limitmsg and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Adminpm:on") and (not is_Mod(msg)) then
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				if tonumber(endwarn) > tonumber(warn) then
				else
					base:set(TD_ID .. "ToshLimitFormid3" .. msg.chat_id, user);
					local formidw = base:get(TD_ID .. "ToshLimitFormid3" .. msg.chat_id);
					local username = "<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
					local keyboard = {};
					keyboard.inline_keyboard = {
						{
							{
								text = "🥇 ارتقا به ادمین گروه و ربات 🥇 ",
								callback_data = "AlphD:" .. chat_id .. ":" .. formidw .. ""
							}
						},
						{
							{
								text = "❌ کاربر عادی بماند ❌",
								callback_data = "AlphA:" .. chat_id .. ":" .. formidw .. ""
							}
						}
					};
					text = " ⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 در گروه " .. gp .. " بافعالیت تعداد پیام (" .. Alphafa(Msgsday) .. " پیام) می تواند صاحب یک مقام در گروه باشد.\n 👮🏻♂️مالک عزیز این پیام صرفا جهت پیشنهادی از طرف ربات با توجه به فعالیت کاربر می باشد اگر مایلید برای مقام دادن به کاربر از دکمه زیر استفاده کنید.  ";
					local users = base:smembers(TD_ID .. "ModList:" .. msg.chat_id);
					for y, u in pairs(users) do
						send_inline(u, text, keyboard, "html");
						base:hset(startwarn, msg.sender_id.user_id, tonumber(endwarn) + 1);
						base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id .. ":" .. user, 260, true);
						base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id, 10, true);
						base:sadd(TD_ID .. "Adminuser:" .. msg.chat_id, user);
					end;
				end;
			end;
		end;
		Msgsday = tonumber(base:get(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d") .. ":" .. user or 0)) or 0;
		local limitmsg = tonumber(base:get(TD_ID .. "Adminpm:" .. msg.chat_id) or 100);
		local warn = 2;
		local startwarn = TD_ID .. ":warnad2" .. os.date("%Y/%m/%d") .. ":" .. msg.chat_id;
		local endwarn = base:hget(startwarn, msg.sender_id.user_id) or 1;
		if base:get(TD_ID .. "StatsGpByName" .. msg.chat_id) then
			gp = base:get(TD_ID .. "StatsGpByName" .. msg.chat_id);
		else
			gp = msg.chat_id;
		end;
		if base:get(TD_ID .. "Adminsendpm" .. msg.chat_id) == "OwnerAllGp" then
			if Msgsday >= limitmsg and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Adminpm:on") and (not is_Mod(msg)) then
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				if tonumber(endwarn) > tonumber(warn) then
				else
					base:set(TD_ID .. "ToshLimitFormid3" .. msg.chat_id, user);
					local formidw = base:get(TD_ID .. "ToshLimitFormid3" .. msg.chat_id);
					local username = "<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
					local keyboard = {};
					keyboard.inline_keyboard = {
						{
							{
								text = "🥇 ارتقا به ادمین گروه و ربات 🥇 ",
								callback_data = "AlphD:" .. chat_id .. ":" .. formidw .. ""
							}
						},
						{
							{
								text = "❌ کاربر عادی بماند ❌",
								callback_data = "AlphA:" .. chat_id .. ":" .. formidw .. ""
							}
						}
					};
					text = " ⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 در گروه " .. gp .. " بافعالیت تعداد پیام (" .. Alphafa(Msgsday) .. " پیام) می تواند صاحب یک مقام در گروه باشد.\n 👮🏻♂️مالک عزیز این پیام صرفا جهت پیشنهادی از طرف ربات با توجه به فعالیت کاربر می باشد اگر مایلید برای مقام دادن به کاربر از دکمه زیر استفاده کنید.  ";
					local users = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
					for y, u in pairs(users) do
						local ModList = base:smembers(TD_ID .. "ModList:" .. msg.chat_id);
						for x, m in pairs(ModList) do
							send_inline(u, text, keyboard, "html");
							send_inline(x, text, keyboard, "html");
							base:hset(startwarn, msg.sender_id.user_id, tonumber(endwarn) + 1);
							base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id .. ":" .. user, 260, true);
							base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id, 10, true);
							base:sadd(TD_ID .. "Adminuser:" .. msg.chat_id, user);
						end;
					end;
				end;
			end;
		end;
		Msgsday = tonumber(base:get(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d") .. ":" .. user or 0)) or 0;
		local limitmsg = tonumber(base:get(TD_ID .. "Adminpm:" .. msg.chat_id) or 100);
		local warn = 2;
		local startwarn = TD_ID .. ":warnad2" .. os.date("%Y/%m/%d") .. ":" .. msg.chat_id;
		local endwarn = base:hget(startwarn, msg.sender_id.user_id) or 1;
		if base:get(TD_ID .. "StatsGpByName" .. msg.chat_id) then
			gp = base:get(TD_ID .. "StatsGpByName" .. msg.chat_id);
		else
			gp = msg.chat_id;
		end;
		if base:get(TD_ID .. "Adminsendpm" .. msg.chat_id) == "OwnerGp" then
			if Msgsday >= limitmsg and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Adminpm:on") and (not is_Mod(msg)) then
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				if tonumber(endwarn) > tonumber(warn) then
				else
					base:set(TD_ID .. "ToshLimitFormid3" .. msg.chat_id, user);
					local formidw = base:get(TD_ID .. "ToshLimitFormid3" .. msg.chat_id);
					local username = "<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
					local keyboard = {};
					keyboard.inline_keyboard = {
						{
							{
								text = "🥇 ارتقا به ادمین گروه و ربات 🥇 ",
								callback_data = "AlphD:" .. chat_id .. ":" .. formidw .. ""
							}
						},
						{
							{
								text = "❌ کاربر عادی بماند ❌",
								callback_data = "AlphA:" .. chat_id .. ":" .. formidw .. ""
							}
						}
					};
					text = " ⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 در گروه " .. gp .. " بافعالیت تعداد پیام (" .. Alphafa(Msgsday) .. " پیام) می تواند صاحب یک مقام در گروه باشد.\n 👮🏻♂️مالک عزیز این پیام صرفا جهت پیشنهادی از طرف ربات با توجه به فعالیت کاربر می باشد اگر مایلید برای مقام دادن به کاربر از دکمه زیر استفاده کنید.  ";
					local users = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
					for y, u in pairs(users) do
						send_inline(u, text, keyboard, "html");
						base:hset(startwarn, msg.sender_id.user_id, tonumber(endwarn) + 1);
						base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id .. ":" .. user, 260, true);
						base:setex(TD_ID .. "ReqMenu:" .. msg.chat_id, 10, true);
						base:sadd(TD_ID .. "Adminuser:" .. msg.chat_id, user);
					end;
				end;
			end;
		end;
		if msg.sender_id.user_id and (not is_Vip(msg)) then
			local usere = msg.sender_id.user_id;
			local TeleBot = TD.getUser(usere);
			local Ramin = TD.getUser(msg.actor_user_id);
			if is_GlobalyBan(usere) then
				if Ramin.usernames.editable_username == "" then
					name = ec_name(Ramin.first_name);
				else
					name = Ramin.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				if not base:get((TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id)) then
					base:setex(TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id, 10, true);
					KickUser(msg.chat_id, usere);
					TD.setChatMemberStatus(msg.chat_id, usere, "banned");
				end;
			end;
		end;
		if msg.sender_id.user_id and (not is_Vip(msg)) then
			local usere = msg.sender_id.user_id;
			local Ramin = TD.getUser(usere);
			if is_Banned(msg.chat_id, usere) then
				if Ramin.usernames.editable_username == "" then
					name = ec_name(Ramin.first_name);
				else
					name = Ramin.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				if not base:get((TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id)) then
					base:setex(TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id, 10, true);
					KickUser(msg.chat_id, usere);
					TD.setChatMemberStatus(msg.chat_id, usere, "banned");
				end;
			end;
		end;
		if msg.sender_id.user_id and (not is_Vip(msg)) then
			local usere = msg.sender_id.user_id;
			if base:get(TD_ID .. "sg:locktabalpha" .. msg.chat_id) == "lock" and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), usere)) then
				local full = (TD.getUserFullInfo(usere)).bio or "nil";
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "NameAntiTabchi") then
					users = base:smembers(TD_ID .. "FilterBio:" .. msg.chat_id);
					if #users > 0 then
						for k, v in pairs(users) do
							mMd = full:lower();
							if mMd:match(v) then
								alpha = (TD.getUser(usere)).first_name;
								local username = "[" .. alpha .. "](tg://user?id=" .. usere .. ")";
								if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
									if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
											text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n\n⌯   علت : بیوگرافی غیرمجاز";
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
											sendBot(msg.chat_id, msg.id, text, "md");
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
										end;
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
										KickUser(msg.chat_id, usere);
										TD.setChatMemberStatus(msg.chat_id, usere, "banned");
									else
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
										KickUser(msg.chat_id, usere);
										TD.setChatMemberStatus(msg.chat_id, usere, "banned");
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
									if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
											text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n\n⌯ علت : بیوگرافی غیرمجاز ";
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
											sendBot(msg.chat_id, msg.id, text, "md");
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
										end;
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
										MuteUser(msg.chat_id, usere, 0);
									else
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
										MuteUser(msg.chat_id, usere, 0);
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
									if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
										end;
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
									else
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
								else
									return;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
		if msg.sender_id.user_id and (not is_Mod(msg)) then
			local usere = msg.sender_id.user_id;
			if base:get(TD_ID .. "sg:locktabalpha" .. msg.chat_id) == "lock" and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), usere)) then
				local users = base:smembers(TD_ID .. "FilterName:" .. msg.chat_id);
				local alphaa = (TD.getUser(usere)).first_name;
				local username = "[" .. usere .. "](tg://user?id=" .. usere .. ")";
				if #users > 0 then
					alpha = TD.getUser(usere);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					for k, v in pairs(users) do
						mMd = alpha.first_name:lower() or "";
						if mMd:match(v) then
							if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n\n⌯  علت  : اسم غیرمجاز \n\n  !";
										sendBot(msg.chat_id, msg.id, text, "md");
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									KickUser(msg.chat_id, usere);
									TD.setChatMemberStatus(msg.chat_id, usere, "banned");
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									KickUser(msg.chat_id, usere);
									TD.setChatMemberStatus(msg.chat_id, usere, "banned");
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n\n⌯  علت  : اسم غیرمجاز  \n\n  !";
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										sendBot(msg.chat_id, msg.id, text, "md");
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									MuteUser(msg.chat_id, usere, 0);
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									MuteUser(msg.chat_id, usere, 0);
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
							else
								return;
							end;
						end;
					end;
				end;
			end;
		end;
		if msg.content["@type"] == "messageSticker" and (not is_Vip(msg)) then
			local filterpack = base:smembers(TD_ID .. "filterpack" .. msg.chat_id);
			local warn = base:get(TD_ID .. "joinwarne:" .. msg.chat_id) or 4;
			local startwarn = TD_ID .. ":joine" .. os.date("%Y/%m/%d") .. ":" .. msg.chat_id;
			local endwarn = base:hget(startwarn, msg.sender_id.user_id) or 1;
			local alpha = TD.getUser(msg.sender_id.user_id);
			if alpha.usernames.editable_username == "" then
				name = ec_name(alpha.first_name);
			else
				name = alpha.usernames.editable_username;
			end;
			local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a>";
			for k, v in pairs(filterpack) do
				if v == msg.content.sticker.set_id then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
					if tonumber(endwarn) > tonumber(warn) then
					else
						text = "⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 استیکر ارسال شده شما به علت فیلتر شدن حذف شد. ";
						sendBot(msg.chat_id, msg.id, text, "html");
						base:hset(startwarn, msg.sender_id.user_id, tonumber(endwarn) + 1);
					end;
				end;
			end;
		end;
		local CleanMessageService = function(msg, type, value, key)
			TD.deleteMessages(msg.chat_id, msg.id);
			base:set(TD_ID .. "ProcessClean", true);
			base:set(TD_ID .. "CleanMessageDate" .. msg.chat_id, msg.date);
			if key == "AllMessage" then
				TD.deleteMessages(msg.chat_id, msg.id);
				local function deleteMessages(result)
					if result.messages then
						do
							do
								for i, i in pairs(result.messages) do
									base:set(TD_ID .. "CleanMessage" .. i.chat_id, tonumber((base:get(TD_ID .. "CleanMessage" .. i.chat_id) or 0)) + 1);
									TD.deleteChatMessagesBySender(i.chat_id, i.sender.user_id, nil);
									_Time = tonumber(base:ttl("CleanMessageDay" .. i.chat_id));
									if _Time == (-2) then
										Time = 86400;
									else
										Time = _Time;
									end;
									base:setex(TD_ID .. "CleanMessageDay" .. i.chat_id, Time, tonumber((base:get(TD_ID .. "CleanMessageDay" .. i.chat_id) or 0)) + 1);
								end;
							end;
						end;
						if result.messages[1] then
							local result = TD.getChatHistory(msg.chat_id, result.messages[1].id, 0, 100);
							deleteMessages(result);
						else
							local msg_data = base:get(TD_ID .. "CleanMessageDate" .. msg.chat_id) or 0;
							local count = base:get(TD_ID .. "CleanMessage" .. msg.chat_id) or 0;
							local count_day = base:get(TD_ID .. "CleanMessageDay" .. msg.chat_id) or count;
							Start_ = base:get(TD_ID .. "DelaUtO" .. msg.chat_id);
							TD.sendText(msg.chat_id, msg.id, "⌯ فرایند پاکسازی خودکار در ساعت " .. Start_ .. " انجام شد.\n\nپاکسازی خودکار کلی پیام ها هر روز در ساعت " .. Start_ .. " انجام خواهد شد.\n\n─┅━ پاکسازی خودکار ━┅─\n\n◄ زمان های سپری شده :  : " .. math.modf(msg.date - msg_data) .. " ثانیه\n◄ تعداد کل پاکسازی : " .. count .. " پیام\n◄  تعداد کل امروز : " .. count_day .. " پیام", "html");
							base:del(TD_ID .. "CleanMsg" .. msg.chat_id);
							base:del(TD_ID .. "ProcessClean");
							base:del(TD_ID .. "CleanMessageDate" .. msg.chat_id);
							base:del(TD_ID .. "CleanMessage" .. msg.chat_id);
						end;
					end;
				end;
				local result = TD.getChatHistory(msg.chat_id, msg.id, 0, 100);
				deleteMessages(result);
			elseif key == "MessageUser" then
				TD.deleteChatMessagesBySender(msg.chat_id, type);
				base:del(TD_ID .. "ProcessClean");
			else
				local function deleteMessages(result)
					if result.messages then
						do
							do
								for i, i in pairs(result.messages) do
									if key == "Forwarded" then
										if i.forward_info then
											TD.deleteMessages(msg.chat_id, i.id);
										end;
									elseif key == "Tgserviceauto" then
										if i.content and (i.content["@type"] == "messageChatAddMembers" or i.content["@type"] == "messagePinMessage" or i.content["@type"] == "messageChatJoinByLink" or i.content["@type"] == "messageChatDeleteMember" or i.content["@type"] == "messageChatChangePhoto" or i.content["@type"] == "messageChatDeletePhoto" or i.content["@type"] == "messageChatChangeTitle") then
											TD.deleteMessages(msg.chat_id, i.id);
										end;
									elseif key == "Sticker" then
										if i.content and i.content["@type"] == type and (not i.content.sticker.is_animated) then
											TD.deleteMessages(msg.chat_id, i.id);
										end;
									elseif key == "StickerAnimated" then
										if i.content and i.content["@type"] == type and i.content.sticker.is_animated then
											TD.deleteMessages(msg.chat_id, i.id);
										end;
									elseif i.content and i.content["@type"] == type then
										TD.deleteMessages(msg.chat_id, i.id);
									end;
								end;
							end;
						end;
						if result.messages[1] then
							result = TD.getChatHistory(msg.chat_id, result.messages[1].id, 0, 100);
							deleteMessages(result);
						end;
					end;
				end;
				local result = TD.getChatHistory(msg.chat_id, msg.id, 0, 100);
				deleteMessages(result);
				base:del(TD_ID .. "ProcessClean");
			end;
		end;
		if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "MsgCheckService") then
			if msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messageChatDeleteMember" or msg.content["@type"] == "messageChatChangePhoto" or msg.content["@type"] == "messageChatChangeTitle" or msg.content["@type"] == "messageChatAddMembers" or msg.content["@type"] == "messagePinMessage" then
				function BDClearPm()
					CleanMessageService(msg, nil, "سرویس تلگرام", "Tgservice");
					print("MsgCheckService on");
				end;
				JoinMSG = tonumber(base:get(TD_ID .. "checkservicetime:" .. msg.chat_id)) or 20;
				TD.set_timer(JoinMSG, BDClearPm);
			end;
		else
			if msg.content["@type"] == "messageChatAddMembers" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGAdd") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messagePinMessage" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGPin") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatJoinByLink" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGLink") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatDeleteMember" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGDel") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatChangePhoto" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGChPhoto") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatDeletePhoto" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:DePhoto") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatChangeTitle" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:ChTitle") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
			if msg.content["@type"] == "messageChatChangeTitle" or msg.content["@type"] == "messageChatDeletePhoto" or msg.content["@type"] == "messageChatChangePhoto" or msg.content["@type"] == "messageChatDeleteMember" or msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messagePinMessage" or msg.content["@type"] == "messageChatAddMembers" then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGservice") then
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			end;
		end;
		if msg.content["@type"] == "messagePinMessage" and (not is_Owner(msg)) and (not is_OwnerPlus(msg)) then
			if base:get(TD_ID .. "sg:pin" .. msg.chat_id) == "lock" then
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a>";
				text = "⌯ کاربر 〚" .. username .. " - <code>" .. msg.sender_id.user_id .. "</code>〛 شما اجازہ سنجاق کردن درگروہ را ندارید! ";
				sendBot(msg.chat_id, msg.id, text, "html");
			end;
		end;
		if msg.content["@type"] == "messageVideoNote" or msg.content["@type"] == "messagePhoto" or msg.content["@type"] == "messageAnimation" or msg.content["@type"] == "messageVideo" or msg.content["@type"] == "messageVoiceNote" or msg.content["@type"] == "messageAudio" or msg.content["@type"] == "messageSticker" then
			print("msg.Media");
			msg.Media = true;
		end;
		if msg.Media and (not is_Vip(msg)) then
			if base:sismember(TD_ID .. "Gp:" .. chat, "Warn:FloodMedia") then
				floodtime = tonumber(base:get(TD_ID .. "FloodMedia:Max:" .. msg.chat_id)) or 5;
				floodmax = tonumber(base:get(TD_ID .. "FloodMedia:Time:" .. msg.chat_id)) or 10;
				flooduser = tonumber(base:get(TD_ID .. "floodusermedia" .. user .. msg.chat_id)) or 0;
				if flooduser > floodmax then
					base:del(TD_ID .. "floodusermedia" .. user .. msg.chat_id);
					if base:sismember(TD_ID .. "Gp3:" .. chat, user .. " حذف رسانه مکرر") or base:sismember(TD_ID .. "Gp:" .. chat, "Warn:FloodMedia") then
						lock_del(msg, "ارسال #رسانه رگباری");
						TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
						TD.deleteMessages(msg.chat_id, {
							[0] = msg.id
						});
					end;
				else
					base:setex(TD_ID .. "floodusermedia" .. user .. msg.chat_id, floodtime, flooduser + 1);
				end;
			end;
		end;
		if msg.content["@type"] == "messageText" and (not is_Vip(msg)) then
			if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Flood") or base:sismember(TD_ID .. "Gp:" .. chat, "Kick:Flood") or base:sismember(TD_ID .. "Gp:" .. chat, "Ban:Flood") or base:sismember(TD_ID .. "Gp:" .. chat, "Mute:Flood") or base:sismember(TD_ID .. "Gp:" .. chat, "Warn:Flood") or base:sismember(TD_ID .. "Gp:" .. chat, "Silent:Flood") then
				local floodmax = tonumber(base:get(TD_ID .. "Flood:Max:" .. msg.chat_id)) or 5;
				local floodtime = tonumber(base:get(TD_ID .. "Flood:Time:" .. msg.chat_id)) or 10;
				local flooduser = tonumber(base:get(TD_ID .. "flooduser" .. user .. msg.chat_id)) or 0;
				if flooduser > floodmax then
					base:del(TD_ID .. "flooduser" .. user .. msg.chat_id);
					if base:sismember(TD_ID .. "Gp3:" .. chat, user .. " حذف پیام مکرر") or base:sismember(TD_ID .. "Gp:" .. chat, "Del:Flood") then
						lock_del(msg, "ارسال #پیام رگباری");
						TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					end;
				else
					base:setex(TD_ID .. "flooduser" .. user .. msg.chat_id, floodtime, flooduser + 1);
				end;
			end;
		end;
		spam = msg.content.text and msg.content.text.text;
		if spam and (not is_Vip(msg)) then
			num = tonumber(base:get(TD_ID .. "NUM_CH_MAX:" .. msg.chat_id)) or 3600;
			chars = utf8.len(spam);
			if chars > num then
				MsgCheck(msg, "ارسال #هرزنامه", "Spam", "هرزنامه");
			end;
		end;
		if msg.add and (not is_Vip(msg)) then
			local result = TD.getUser(msg.add);
			res = TD.getUser(msg.sender_id.user_id);
			if res.usernames.editable_username == "" then
				name = ec_name(res.first_name);
			else
				name = res.usernames.editable_username;
			end;
			local banbotpm = base:sismember(TD_ID .. "Gp2:" .. chat, "kickbotpm");
			if result.type["@type"] == "userTypeBot" then
				if base:get(TD_ID .. "Lock:Bots" .. chat) == "kick" then
					KickUser(chat, user);
					TD.setChatMemberStatus(msg.chat_id, v.user_id, "banned");
					UnRes(chat, user);
				end;
				if base:get(TD_ID .. "Lock:Bots" .. chat) == "ban" then
					KickUser(chat, user);
					TD.setChatMemberStatus(msg.chat_id, v.user_id, "banned");
				end;
				if base:sismember(TD_ID .. "Gp3:" .. chat, user .. " حذف ربات") or base:get(TD_ID .. "Lock:Bots" .. chat) == "del" then
					KickUser(msg.chat_id, result.id);
					local result_ = TD.getSupergroupMembers(msg.chat_id, "Bots", "", 0, 200);
					for k, v in pairs(result_.members) do
						if tonumber(v.user_id) ~= tonumber(BotJoiner) then
							TD.deleteChatMessagesBySender(msg.chat_id, v.user_id);
							KickUser(msg.chat_id, v.user_id);
							TD.setChatMemberStatus(msg.chat_id, v.user_id, "banned");
						end;
					end;
				end;
				if not (base:get(TD_ID .. "Lock:Bots" .. chat) == "ban" or base:get(TD_ID .. "Lock:Bots" .. chat) == "kick") and (not is_Vip(msg)) then
					if base:get(TD_ID .. "Lock:Bots" .. chat) == "mute" then
						KickUser(chat, result.id);
						TD.setChatMemberStatus(msg.chat_id, user, "banned");
						MuteUser(chat, user, msg.date + timemutemsg);
					end;
					if base:get(TD_ID .. "Lock:Bots" .. chat) == "silent" then
						base:sadd(TD_ID .. "MuteList:" .. chat, user or 0);
						TD.deleteMessages(chat, {
							[0] = msg.id
						});
					end;
					if base:get(TD_ID .. "Lock:Bots" .. chat) == "warn" then
						if tonumber(warnhashbd) == tonumber(max_warn) then
							KickUser(chat, user);
							TD.setChatMemberStatus(msg.chat_id, user, "banned");
							base:hdel(hashwarnbd, chat, max_warn);
						else
							base:hset(hashwarnbd, chat, tonumber(warnhashbd) + 1);
							KickUser(chat, result.id);
							TD.setChatMemberStatus(msg.chat_id, result.id, "banned");
						end;
					end;
				end;
			end;
		end;
		local function AddChecker(msg)
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd") then
				if not is_Vip(msg) and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), msg.sender_id.user_id)) then
					local ReactionAdd = base:get(TD_ID .. "ReactionAdd:" .. msg.chat_id) or 0;
					local setadd = tonumber(base:get(TD_ID .. "Force:Max:" .. msg.chat_id) or 10);
					local permit = base:hget(TD_ID .. "AddUserCount" .. msg.sender_id.user_id, msg.chat_id) or 0;
					if tonumber(permit) < tonumber(setadd) then
						TeleBot = TD.getUser(msg.sender_id.user_id);
						if TeleBot.usernames.editable_username == "" then
							name = ec_name(TeleBot.first_name);
						else
							name = TeleBot.usernames.editable_username;
						end;
						local username = "<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(TeleBot.first_name) .. "</a> ";
						local joined_chat_date = (TD.getChatMember(msg.chat_id, msg.sender_id.user_id)).joined_chat_date;
						SendWarn = false;
						if tonumber(ReactionAdd) ~= 0 and tonumber(ReactionAdd) < joined_chat_date then
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							SendWarn = true;
						elseif tonumber(ReactionAdd) == 0 then
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							SendWarn = true;
						end;
						if not base:get((TD_ID .. "TimerAdd1:" .. msg.sender_id.user_id .. msg.chat_id)) and SendWarn then
							base:set(TD_ID .. "ToshFormid" .. msg.chat_id, msg.sender_id.user_id);
							Keyboard = {
								{
									{
										text = "⌯ معاف کاربر ",
										data = "RemMoj:" .. msg.chat_id .. ":" .. msg.sender_id.user_id .. ""
									}
								},
								{
									{
										text = "⌯ تعداد اد شما",
										data = "AddDisplay:" .. msg.chat_id .. ":" .. msg.sender_id.user_id .. ""
									}
								}
							};
							local less = tonumber(setadd) - tonumber(permit);
							TD.sendText(msg.chat_id, msg.id, "⌯ کاربر عزیز〚 " .. username .. "〛:\n\nشما برای چت کردن در گروه باید <b>" .. less .. "</b> نفر را دعوت کنید !\n\n\n⌯ تعداد ادد های شما : <b>" .. permit .. "</b> نفر", "html", false, false, false, false, TD.replyMarkup({
								type = "inline",
								data = Keyboard
							}));
							base:setex(TD_ID .. "TimerAdd1:" .. msg.sender_id.user_id .. msg.chat_id, 20, true);
						end;
					end;
				end;
			end;
		end;
		if msg.content["@type"] == "messageText" or msg.content["@type"] == "messageVideoNote" or msg.content["@type"] == "messagePhoto" or msg.content["@type"] == "messageSticker" or msg.content["@type"] == "messageAnimation" or msg.content["@type"] == "messageDocument" or msg.content["@type"] == "messageVoiceNote" or msg.content["@type"] == "messageVideo" then
			AddChecker(msg);
		end;
		local function keyboards(table_)
			return TD.replyMarkup({
				type = "inline",
				data = table_
			});
		end;
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcelist") then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin") then
				local Ch = base:get(TD_ID .. "setch:" .. msg.chat_id) or "..Channel..";
				local url, res = https.request("https://api.telegram.org/bot" .. JoinToken .. "/getchatmember?chat_id=@" .. Ch .. "&user_id=" .. msg.sender_id.user_id);
				if res ~= 200 then
				end;
				Joinchanel = json:decode(url);
				if not is_GlobalyBan(msg.sender_id.user_id) and (not Joinchanel.ok or Joinchanel.result.status == "left" or Joinchanel.result.status == "kicked") and (not is_Sudo(msg)) and (not is_Mod(msg)) then
					print("Force Join");
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
					local TeleBot = TD.getUser(msg.sender_id.user_id);
					if TeleBot.usernames.editable_username == "" then
						name = ec_name(TeleBot.first_name);
					else
						name = TeleBot.usernames.editable_username;
					end;
					MsgId = base:get(TD_ID .. "MsgsNumber1" .. msg.chat_id);
					countmem = base:smembers(TD_ID .. "ForceRamin2:" .. msg.chat_id);
					if #base:smembers((TD_ID .. "ForceRamin2:" .. msg.chat_id)) > 2 or (not MsgId) then
						if not base:sismember((TD_ID .. "ForceRamin2:" .. msg.chat_id), msg.sender_id.user_id) then
							if MsgId then
								TD.deleteMessages(msg.chat_id, {
									[1] = MsgId
								});
								base:del(TD_ID .. "ForceRamin2:" .. msg.chat_id);
							end;
							bd = "⌯ برای ارسال پیام در کانال زیر عضو شوید !\n\n⚠️ شما در کانال عضو نیستید:\n\nᴥ 【 <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. name .. "</a> 】";
							Button = {
								{
									{
										text = "✦ عضویت در کانال",
										url = "https://telegram.me/" .. Ch
									}
								}
							};
							TD.sendText(msg.chat_id, msg.id, bd, "html", true, false, false, false, keyboards(Button));
							base:sadd(TD_ID .. "ForceRamin2:" .. msg.chat_id, msg.sender_id.user_id);
						end;
					elseif not base:sismember((TD_ID .. "ForceRamin2:" .. msg.chat_id), msg.sender_id.user_id) and MsgId then
						base:sadd(TD_ID .. "ForceRamin2:" .. msg.chat_id, msg.sender_id.user_id);
						bd = "⌯ برای ارسال پیام در کانال زیر عضو شوید !\n\n⚠️ شما در کانال عضو نیستید:\n\n";
						countmem = base:smembers(TD_ID .. "ForceRamin2:" .. msg.chat_id);
						for u, i in pairs(countmem) do
							local Ramin = TD.getUser(i);
							if Ramin.usernames.editable_username == "" then
								name = ec_name(Ramin.first_name);
							else
								name = Ramin.usernames.editable_username;
							end;
							bd = bd .. "ᴥ 【 <a href=\"tg://user?id=" .. i .. "\">" .. name .. "</a> 】\n";
						end;
						Button_ = {
							{
								{
									text = "✦ عضویت در کانال",
									url = "https://telegram.me/" .. Ch
								}
							}
						};
						TD.editMessageText_(msg.chat_id, tonumber(MsgId), keyboards(Button_), bd, "html");
					end;
				else
					return true;
				end;
			end;
		elseif base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin") and (not (msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messageChatAddMembers" or msg.content["@type"] == "messageChatDeleteMember")) then
			local Channel = base:get(TD_ID .. "setch:" .. msg.chat_id) or Config.Channel;
			
			local url, res = https.request("https://api.telegram.org/bot" .. JoinToken .. "/getchatmember?chat_id=@" .. Channel .. "&user_id=" .. msg.sender_id.user_id);
			if res ~= 200 then
			end;
			Joinchanel = json:decode(url);
			if not is_GlobalyBan(msg.sender_id.user_id) and (not Joinchanel.ok or Joinchanel.result.status == "left" or Joinchanel.result.status == "kicked") and (not is_Sudo(msg)) and (not is_Owner(msg)) and (not is_OwnerPlus(msg)) and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), msg.sender_id.user_id)) and (not is_Vip(msg)) then
				print("Force Join");
				TeleBot = TD.getUser(msg.sender_id.user_id);
				if TeleBot.usernames.editable_username == "" then
					name = ec_name(TeleBot.first_name);
				else
					name = TeleBot.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. ec_name(TeleBot.first_name) .. "</a> ";
				local chname = base:get(TD_ID .. "Text:ChName:" .. msg.chat_id) or " ✰ ورود به کانال ✰ ";
				local Rosha = base:get(TD_ID .. "Text:Chjoin:" .. msg.chat_id) or "⌯ برای ارسال پیام در کانال زیر عضو شوید !\n\n⚠️ شما در کانال عضو نیستید:\n\nᴥ 【 <a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\">" .. name .. "</a> 】";
				local Rosha = replace(Rosha, "FIRSTNAMEMAN", "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. ec_name(TeleBot.first_name) .. "</a>");
				local Rosha = replace(Rosha, "FIRSTNAME", ec_name(TeleBot.first_name));
				local Rosha = replace(Rosha, "LASTNAME", TeleBot.last_name or "");
				local Rosha = replace(Rosha, "USERNAME", "@" .. TeleBot.usernames.editable_username) or "بدون@";
				local Rosha = replace(Rosha, "NameCH", "" .. chname) or "";
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
				if not base:get((TD_ID .. "TimerJoin:" .. msg.sender_id.user_id .. msg.chat_id)) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Join:Buttom") then
						Keyboard = {
							{
								{
									text = chname,
									url = "https://t.me/" .. string.gsub(Channel, "@", "")
								}
							},
							{
								{
									text = "⌯ معاف جوین چنل",
									data = "AddJoin:" .. msg.chat_id .. ":" .. msg.sender_id.user_id .. ""
								}
							}
						};
						TD.sendText(msg.chat_id, msg.id, Rosha, "html", false, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Keyboard
						}));
					else
						Button = {
							{
								{
									text = "✦ عضویت در کانال",
									url = "https://t.me/" .. string.gsub(Channel, "@", "")
								}
							}
						};
						TD.sendText(msg.chat_id, msg.id, Rosha, "html", true, false, false, false, TD.replyMarkup({
							type = "inline",
							data = Button
						}));
						base:setex(TD_ID .. "TimerJoin:" .. msg.sender_id.user_id .. msg.chat_id, 20, true);
					end;
				end;
			end;
		end;
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Mute_All") and (not is_Vip(msg)) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tele_Mute") then
				base:sadd(TD_ID .. "Mutes:" .. msg.chat_id, msg.sender_id.user_id);
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
				MuteUser(msg.chat_id, msg.sender_id.user_id, 0);
			else
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
			end;
		end;
		if base:sismember(TD_ID .. "SilentList:" .. msg.chat_id, msg.sender_id.user_id) and (not is_Vip(msg)) then
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
		end;
		if base:sismember(TD_ID .. "MuteList:" .. msg.chat_id, msg.sender_id.user_id) and (not is_Vip(msg)) then
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			MuteUser(msg.chat_id, msg.sender_id.user_id, 0);
		end;
	end;
	if msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messageChatAddMembers" or msg.content["@type"] == "messageChatDeleteMember" then
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGservice") then
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
		end;
	end;
	local Ramin = msg.content.text and msg.content.text.text;
	local Ramin1 = msg.content.text and msg.content.text.text;
	local RaminEnti = Ramin and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName";
	if Ramin then
		Ramin = Ramin:lower();
	end;
	if MsgType == "Text" and Ramin then
		if Ramin:match("^[/#!]") then
			Ramin = Ramin:gsub("^[/#!]", "");
		end;
	end;
	if is_configure(msg) then





		if Ramin and (Ramin:match("^درصد تخفیف (%d+)$") or Ramin and Ramin:match("^[Ss][Ee][Tt][Dd][Ii][Ss] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local num = tonumber(Ramin:match("^درصد تخفیف (%d+)$")) or tonumber(Ramin:match("^[Ss][Ee][Tt][Dd][Ii][Ss] (%d+)$"));
			if num < 5 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداقل مقدار قفل پورن باید بیشتر از 5 درصد باشد  ! ", "html");
			elseif num > 50 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداکثر مقدار تخفیف 50 درصد می باشد  ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ تعداد تخفیف ربات " .. num .. " تنظیم شد ! ", "html");
				base:hset(TD_ID .. "dis", "discnmax", num);
			end;
		end;
		if Ramin and (Ramin:match("^حذف اختصاصی$") or Ramin:match("^remprivate$")) and tonumber(msg.reply_to_message_id) > 0 then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					PrivateMemeber(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				PrivateMemeber(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					PrivateMemeber(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				PrivateMemeber(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف اختصاصی (.*)$") or Ramin:match("^remprivate (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
			id = msg.content.text.entities[1].type.user_id;
			--TD.vardump(id);
			dofile("./checkuser.lua"); 
			PrivateMemeber(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^حذف اختصاصی @(.*)$") or Ramin:match("^remprivate @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local username = Ramin:match("^حذف اختصاصی @(.*)$") or Ramin:match("^remprivate @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				PrivateMemeber(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف اختصاصی (%d+)$") or Ramin:match("^remprivate$")) and tonumber(msg.reply_to_message_id) == 0 then
			dofile("./checkuser.lua");
			PrivateMemeber(msg, msg.chat_id, Ramin:match("^حذف اختصاصی (%d+)$") or Ramin:match("^remprivate (%d+)$"));
		end;
		if Ramin and (Ramin:match("^تعداد پورن (%d+)$") or Ramin and Ramin:match("^[Ss][Ee][Tt][Pp][Oo][Rr][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local num = tonumber(Ramin:match("^تعداد پورن (%d+)$")) or tonumber(Ramin:match("^[Ss][Ee][Tt][Pp][Oo][Rr][Nn] (%d+)$"));
			if num < 1 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداقل مقدار قفل پورن باید بیشتر از 5 باشد ! ", "html");
			elseif num > 100 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداکثر مقدار قفل پورن باید کمتر از 100 باشد ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ تعداد قفل پورن ربات شما به " .. num .. " تنظیم شد ! ", "html");
				base:hset(TD_ID .. "porn", "pornnmax", num);
			end;
		end;
		if Ramin and (Ramin:match("^تعداد پلیر (%d+)$") or Ramin and Ramin:match("^[Ss][Ee][Tt][Pp][Ll][Aa][yY][Ee][Rr] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local num = tonumber(Ramin:match("^تعداد پلیر (%d+)$")) or tonumber(Ramin:match("^[Ss][Ee][Tt][Pp][Ll][Aa][yY][Ee][Rr] (%d+)$"));
			if num < 1 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداقل سقف گروه پلیر باید بیشتر از 5 باشد ! ", "html");
			elseif num > 100 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداکثر سقف گروه پلیر باید کمتر از 100 باشد ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ تعداد پلیر ربات شما به " .. num .. " تنظیم شد ! ", "html");
				base:hset(TD_ID .. "player", "playermax", num);
			end;
		end;
		if Ramin == "تبچی تله فعال" or Ramin == "tabchitel on" and is_FullSudo(msg) then
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:AGT")
			sendBot(msg.chat_id, msg.id, "on shod", "md");
		end;
		if Ramin == "تبچی تله غیرفعال" or Ramin == "tabchitel off" and is_FullSudo(msg) then
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:AGT")
			sendBot(msg.chat_id, msg.id, "off shod", "md");
		end;
		if Ramin and (Ramin:match("^svcharge (%d+)$") or Ramin:match("^شارژ اختصاصی (%d+)$")) then
			local time = tonumber(Ramin:match("^svcharge (%d+)$") or Ramin:match("^شارژ اختصاصی (%d+)$"));
			t = tonumber(time) * tonumber(86400);
			local input2 = math.floor(t / day);
			base:setex(TD_ID .. "SvExpire", tonumber(t), true);
			sendBot(msg.chat_id, msg.id, "⌯ ربات اختصاصی به مدت  " .. input2 .. " روز شارژ شد !", "md");
		end;
		if Ramin == "svexpire" or Ramin == "اعتبار اختصاصی" then
			local check_time = base:ttl(TD_ID .. "SvExpire");
			year = math.floor(check_time / 31536000);
			byear = check_time % 31536000;
			month = math.floor(byear / 2592000);
			bmonth = byear % 2592000;
			day = math.floor(bmonth / 86400);
			bday = bmonth % 86400;
			hours = math.floor(bday / 3600);
			bhours = bday % 3600;
			min = math.floor(bhours / 60);
			sec = math.floor(bhours % 60);
			if not base:get((TD_ID .. "SvExpire")) then
				remained_expire = "مهلت سرور ربات پایان یافته است";
			elseif check_time == (-1) then
				remained_expire = "سرور ربات به صورت نامحدود شارژ میباشد";
			elseif tonumber(check_time) > 1 and check_time < 60 then
				remained_expire = "سرور ربات به مدت " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 60 and check_time < 3600 then
				remained_expire = "سرور ربات به مدت " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
				remained_expire = "سرور ربات به مدت " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
				remained_expire = "سرور ربات به مدت " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
				remained_expire = "سرور ربات به مدت " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 31536000 then
				remained_expire = "سرور ربات به مدت " .. year .. " سال " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			end;
			sendBot(msg.chat_id, msg.id, "📅 " .. remained_expire .. " !", "md");
		end;
	end;
	if is_FullSudo(msg) then
		if Ramin == "پاسخگویی مکمل فعال" or Ramin == "responsecleaner on" and is_FullSudo(msg) then
			base:sadd(TD_ID .. "Gp2:", "Cleanermsg");
			sendBot(msg.chat_id, msg.id, "پاسخگویی مکمل ربات فعال شد !", "md");
		end;
		if Ramin == "پاسخگویی مکمل غیرفعال" or Ramin == "responsecleaner off" and is_FullSudo(msg) then
			base:srem(TD_ID .. "Gp2:", "Cleanermsg");
			sendBot(msg.chat_id, msg.id, "پاسخگویی مکمل ربات غیرفعال شد !", "md");
		end;
		if Ramin == "svexpire" or Ramin == "اعتبار اختصاصی" and is_FullSudo(msg) then
			local check_time = base:ttl(TD_ID .. "SvExpire");
			year = math.floor(check_time / 31536000);
			byear = check_time % 31536000;
			month = math.floor(byear / 2592000);
			bmonth = byear % 2592000;
			day = math.floor(bmonth / 86400);
			bday = bmonth % 86400;
			hours = math.floor(bday / 3600);
			bhours = bday % 3600;
			min = math.floor(bhours / 60);
			sec = math.floor(bhours % 60);
			if not base:get((TD_ID .. "SvExpire")) then
				remained_expire = "مهلت سرور ربات پایان یافته است";
			elseif check_time == (-1) then
				remained_expire = "سرور ربات به صورت نامحدود شارژ میباشد";
			elseif tonumber(check_time) > 1 and check_time < 60 then
				remained_expire = "سرور ربات به مدت " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 60 and check_time < 3600 then
				remained_expire = "سرور ربات به مدت " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
				remained_expire = "سرور ربات به مدت " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
				remained_expire = "سرور ربات به مدت " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
				remained_expire = "سرور ربات به مدت " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			elseif tonumber(check_time) > 31536000 then
				remained_expire = "سرور ربات به مدت " .. year .. " سال " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
			end;
			sendBot(msg.chat_id, msg.id, "📅 " .. remained_expire .. " !", "md");
		end;
		if Ramin and (Ramin:match("^setsudorank (.*)$") or Ramin:match("^لقب سودو (.*)$")) and tonumber(msg.reply_to_message_id) ~= 0 then
			local rank = Ramin:match("^setsudorank (.*)$") or Ramin:match("^لقب سودو (.*)$");
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			if user then
				if tonumber(user) == tonumber(BotJoiner) then
					sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست!", "md");
					return false;
				end;
				if tonumber(user) == Config.Sudoid then
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  عزیز من به بابای خودم نمیتونم لقب بدم !", "md");
					return false;
				end;
				base:set(TD_ID .. "ranksudo" .. user, rank);
				base:sadd("ranksudo:", user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ لقب سودو : <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> به [" .. rank .. "] تغییر کرد ! ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^delsudorank$") or Ramin:match("^حذف لقب سودو$")) and tonumber(msg.reply_to_message_id) ~= 0 then
			local rank = Ramin:match("^delsudorank$") or Ramin:match("^حذف لقب سودو$");
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			if user then
				base:del(TD_ID .. "ranksudo" .. user);
				base:srem("ranksudo:", user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ لقب سودو : <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> به [" .. rank .. "] پاک شد ! ", "html");
			end;
		end;
		if Ramin == "🗂 لیست گروه ها" or Ramin == "لیست گروه ها" then
			local Group = base:smembers(TD_ID .. "group:");
			if #Group == 0 then
				TD.sendText(msg.chat_id, msg.id, "⌯ لیست گروه های تحت مدیریت ربات خالی میباشد ▸", "md");
			else
				text = "⌯ لیست گروه های تحت مدیریت ربات :\n\n";
				for k, i in pairs(Group) do
					data = TD.getChat(i);
					chat_title = data.title and data.title or "-----";
					status_group = data.last_message and "موجود" or "ناموجود";
					local res = TD.getSupergroupFullInfo(i);
					local Link = base:get(TD_ID .. "Link:" .. i) or "ناموجود";
					local ex = base:ttl(TD_ID .. "ExpireData:" .. i);
					if ex == 0 or ex == (-2) then
						Time_S = "[ بدون اعتبار ]";
					elseif ex == (-1) then
						Time_S = "گروه به صورت نامحدود شارژ میباشد";
					else
						local Time_ = getTimeUptime(ex);
						local check_time = base:ttl(TD_ID .. "SvPorn" .. i);
						year = math.floor(check_time / 31536000);
						byear = check_time % 31536000;
						month = math.floor(byear / 2592000);
						bmonth = byear % 2592000;
						day = math.floor(bmonth / 86400);
						bday = bmonth % 86400;
						hours = math.floor(bday / 3600);
						bhours = bday % 3600;
						min = math.floor(bhours / 60);
						sec = math.floor(bhours % 60);
						if not base:get((TD_ID .. "SvPorn" .. i)) then
							remained_expire = "⌯ قفل پورن بدون اعتبار می باشد!";
						elseif tonumber(check_time) > 1 and check_time < 60 then
							remained_expire = "⌯ قفل پورن به مدت " .. sec .. " ثانیه شارژ میباشد";
						elseif tonumber(check_time) > 60 and check_time < 3600 then
							remained_expire = "⌯ قفل پورن به مدت " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
						elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
							remained_expire = "⌯ قفل پورن به مدت " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
						elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
							remained_expire = "⌯ قفل پورن به مدت " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
						elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
							remained_expire = "⌯ قفل پورن به مدت " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
						elseif tonumber(check_time) > 31536000 then
							remained_expire = "⌯ قفل پورن به مدت " .. year .. " سال " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
						end;
						Time_S = "⌯ اعتبار ربات در این گروہ : \n\n⌯ [ " .. Time_ .. " ]\n⌯ اعتبار قفل پورن :\n" .. remained_expire .. "";
					end;
					text = text .. "◄ اطلاعات گروه شماره ( " .. i .. " ) :\n\n⌯ نام گروه : " .. chat_title .. "\n⌯ لینک گروه : " .. Link .. "\n" .. Time_S .. "\n⌯ شناسه گروه : " .. i .. "\n⌯ وضعیت گروه : " .. status_group .. "\n----------------------------\n";
				end;
			end;
			local file = io.open("./Lib/GroupList.txt", "w");
			file:write(text);
			file:close();
			TD.sendDocument(msg.chat_id, msg.id, "./Lib/GroupList.txt", "⌯ تعداد گروه های تحت مدیریت ربات ( " .. #Group .. " ) میباشد ▸", "md");
		end;
		if Ramin and Ramin:match("^بلاک$") and tonumber(msg.reply_to_message_id) > 0 then
			local result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				--TD.vardump(TD.blockMessageSenderFromReplies(result.sender_id.user_id, true, true, true));
			end;
		end;
		if Ramin and (Ramin:match("^افزودن سودو$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo]$")) and tonumber(msg.reply_to_message_id) > 0 then
			local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				Setsudo(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^افزودن سودو$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo]$")) and tonumber(msg.reply_to_message_id) > 0 then
			local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				local result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					Setsudo(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				Setsudo(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					Setsudo(msg, msg.chat_id, Ramin.id);
				end;
			else
				local result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				Setsudo(msg, msg.chat_id, result.sender_id.user_id);
				print("check");
			end;
		end;
		if RaminEnti and (Ramin:match("^افزودن سودو (.*)$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
			local id = msg.content.text.entities[1].type.user_id;
			--TD.vardump(id);
			dofile("./checkuser.lua");
			Setsudo(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^افزودن سودو @(.*)$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local username = Ramin:match("^افزودن سودو @(.*)$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				Setsudo(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^افزودن سودو (%d+)$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
			dofile("./checkuser.lua");
			Setsudo(msg, msg.chat_id, Ramin:match("^افزودن سودو (%d+)$") or Ramin:match("^[Ss][Ee][Tt][Ss][Uu][Dd][Oo] (%d+)$"));
		end;
		if Ramin and (Ramin:match("^حذف سودو$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo]$")) and tonumber(msg.reply_to_message_id) > 0 then
			local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				Remsudo(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^حذف سودو$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo]$")) and tonumber(msg.reply_to_message_id) > 0 then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					Remsudo(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				Remsudo(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					Remsudo(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				Remsudo(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف سودو (.*)$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
			id = msg.content.text.entities[1].type.user_id;
			--TD.vardump(id);
			dofile("./checkuser.lua");
			Remsudo(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^حذف سودو @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
			local username = Ramin:match("^حذف سودو @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				Remsudo(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سودو (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
			dofile("./checkuser.lua");
			Remsudo(msg, msg.chat_id, Ramin:match("^حذف سودو (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Ss][Uu][Dd][Oo] (%d+)$"));
		end;
		if Ramin and (Ramin:match("^لیست سودو$") or Ramin:match("^[Ss][Uu][Dd][Oo][Ll][Ii][Ss][Tt]$")) and tonumber(msg.reply_to_message_id) == 0 then
			local hash = TD_ID .. "SUDO";
			local list = base:smembers(hash);
			if #list == 0 then
				sendText(msg.chat_id, msg.id, "⌯ لیست سودو خالی می باشد !", "md");
			else
				local txt = "⌯ لیست سودو های ربات :\n\n";
				for k, v in pairs(list) do
					rank = base:get(TD_ID .. "ranksudo" .. v) or "بدون مقام";
					local firstname = base:get(TD_ID .. "UserName:" .. v);
					if firstname then
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. StringData(firstname) .. "</a> - <code>(" .. rank .. ")</code>";
					else
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. v .. "</a> - <code>(" .. rank .. ")</code>";
					end;
					txt = txt .. k .. " - [ " .. username .. " ]\n\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if Ramin == "clean sudolist" or Ramin == "پاکسازی لیست سودو" then
			base:del(TD_ID .. "SUDO");
			sendBot(msg.chat_id, msg.id, " ⌯ لیست مدیریت سودو ها ازسیستم پاکسازی شد. ", "html");
		end;
	end;
	if Ramin and is_Owner(msg) or is_OwnerPlus(msg) or is_FullSudo(msg) or is_Sudo(msg) or is_Nazem(msg) or is_Mod(msg) then
		local bd = msg.sender_id.user_id;
		local cht = msg.chat_id;
		local chat = msg.chat_id;
		local gps = base:smembers(TD_ID .. "gpuser:" .. msg.sender_id.user_id);
		local tgps = #base:smembers((TD_ID .. "gpuser:" .. msg.sender_id.user_id));
		local bdcht = msg.chat_id;
		if ChatTypePV then
			for k, v in pairs(gps) do
				bdcht = v;
			end;
		end;
		local function typegpadd(name, ramin)
			if ChatTypeSuperGp then
				base:sadd(TD_ID .. "" .. name .. "" .. cht, ramin);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:sadd(TD_ID .. "" .. name .. "" .. v, ramin);
				end;
			end;
		end;
		local function typegprem(name, ramin)
			if ChatTypeSuperGp then
				base:srem(TD_ID .. "" .. name .. "" .. cht, ramin);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:srem(TD_ID .. "" .. name .. "" .. v, ramin);
				end;
			end;
		end;
		local function typegpdel(name)
			if ChatTypeSuperGp then
				base:del(TD_ID .. "" .. name .. "" .. cht);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:del(TD_ID .. "" .. name .. "" .. v);
				end;
			end;
		end;
		local function typegpset(name, ramin)
			if ChatTypeSuperGp then
				base:set(TD_ID .. "" .. name .. "" .. cht, ramin);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:set(TD_ID .. "" .. name .. "" .. v, ramin);
				end;
			end;
		end;
		local function typegphset(name, ramin, ali)
			if ChatTypeSuperGp then
				base:hset(TD_ID .. "" .. name .. "" .. cht, ramin, ali);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:hset(TD_ID .. "" .. name .. "" .. v, ramin, ali);
				end;
			end;
		end;
		local function typegphdel(name, ramin)
			if ChatTypeSuperGp then
				base:hdel(TD_ID .. "" .. name .. "" .. cht, ramin);
			end;
			if ChatTypePV then
				for k, v in pairs(gps) do
					base:hdel(TD_ID .. "" .. name .. "" .. v, ramin);
				end;
			end;
		end;
		if base:sismember(TD_ID .. "Gp2:" .. cht, "added") then
			if (TDLua == "cgmall" or TDLua == "⌯ پاکسازی پیام در حال انجام ... ✅" or TDLua == "پاکسازی" or Ramin == "پاکسازی پیام" or Ramin == "پاکسازی گروه" or TDLua == "پاکسازی پیام ها") and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			end;
			if (Ramin == "clean filterlist" or Ramin == "پاکسازی لیست فیلتر") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
				typegpdel("Filters:");
				sendBot(cht, msg.id, " ⌯ لیست کلمات فیلتر شدہ پاکسازی شد. ", "md");
			end;
			if Ramin1 and (Ramin1:match("^filterlist (.*)") or Ramin1:match("^فیلتر لیستی (.*)")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local inputz = Ramin1:match("^filterlist (.*)") or Ramin1:match("^فیلتر لیستی (.*)");
				text = "⌯ کلمات زیر به صورت لیستی فیلتر شد :\n\n";
				for i in string.gmatch(inputz, "%S+") do
					forgod = i;
					if not forgod then
						text = "خطا !";
						break;
					else
						typegpadd("Filters:", forgod);
						text = text .. "🄵 *" .. i .. "*\n";
					end;
				end;
				sendBot(msg.chat_id, msg.id, text, "md");
			end;
			if Ramin1 and (Ramin1:match("^remfilter (.*)") or Ramin1:match("^پاکسازی فیلتر (.*)")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local inputz = Ramin1:match("^remfilter (.*)") or Ramin1:match("^پاکسازی فیلتر (.*)");
				text = "⌯ کلمات زیر به صورت لیستی حذف فیلتر شد :\n\n";
				for i in string.gmatch(inputz, "%S+") do
					forgod = i;
					if not forgod then
						text = "خطا !";
						break;
					else
						typegprem("Filters:", forgod);
						text = text .. "🄵 *" .. i .. "*\n";
					end;
				end;
				sendBot(msg.chat_id, msg.id, text, "md");
			end;
			if Ramin and (Ramin:match("^filter (.*)") or Ramin:match("^فیلتر کردن (.*)")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local word = Ramin:match("^filter (.*)") or Ramin:match("^فیلتر کردن (.*)");
				if base:sismember(TD_ID .. "Filters:" .. msg.chat_id, word) then
					sendBot(msg.chat_id, msg.id, "⌯ کلمه  " .. word .. "  در لیست فیلتر وجود دارد!", "html");
				else
					base:sadd(TD_ID .. "Filters:" .. msg.chat_id, word);
					sendBot(msg.chat_id, msg.id, "⌯ کلمه  " .. word .. "  به لیست فیلتر اضافه شد!", "md");
				end;
			end;
			if Ramin and (Ramin:match("^remfilter (.*)") or Ramin:match("^حذف فیلتر (.*)")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local word = Ramin:match("^remfilter (.*)") or Ramin:match("^حذف فیلتر (.*)");
				if base:sismember(TD_ID .. "Filters:" .. msg.chat_id, word) then
					base:srem(TD_ID .. "Filters:" .. msg.chat_id, word);
					sendBot(msg.chat_id, msg.id, "⌯ کلمه  " .. word .. "  از لیست فیلتر حذف شد!", "html");
				else
					sendBot(msg.chat_id, msg.id, "⌯ کلمه  " .. word .. "  در لیست فیلتر وجود ندارد!", "md");
				end;
			end;
			if (Ramin == "filterlist" or Ramin == "filter list" or Ramin == "لیست فیلتر" or Ramin == "لیست کلمات فیلتر") and is_JoinChannel(msg) then
				if ChatTypeSuperGp then
					local list = base:smembers(TD_ID .. "Filters:" .. cht);
					local t = " ⌯ لیست کلمات فیلتر شده :\n";
					for k, v in pairs(list) do
						t = t .. "🄵 *" .. v .. "*\n";
					end;
					if #list == 0 then
						t = "⌯ *لیست کلمات فیلتر شدہ دراین گروہ خالی می باشد*.";
					end;
					sendBot(cht, msg.id, t, "md");
				end;
				if gp_type(msg.chat_id) == "pv" then
					local t = "⌯ لیست کلمات فیلتر شدہ در *" .. tgps .. "* گروہ شما\n⌯ برای دیدن لیست گروہ ها میتوانید از دستور گروہ های من یا [mygps] استفادہ کنید.\n";
					for k, v in pairs(gps) do
						local list = base:smembers(TD_ID .. "Filters:" .. v);
						for a, b in pairs(list) do
							t = "" .. t .. "" .. b .. "\nدر گروه *" .. k .. "*\n\n";
						end;
					end;
					sendBot(cht, msg.id, t, "md");
				end;
			end;
			if Ramin and (Ramin:match("^tabchiname +(.*)") or Ramin:match("^تبچی اسم +(.*)") or Ramin:match("^مسدود اسم +(.*)")) and is_JoinChannel(msg) then
				if string.find(Ramin:match("^tabchiname (.*)$") or Ramin:match("^تبچی اسم (.*)$") or Ramin:match("^مسدود اسم (.*)$"), "[%*?^$]") then
					sendBot(cht, msg.id, "🖕😐", "md");
				else
					local word = Ramin:match("^tabchiname +(.*)") or Ramin:match("^تبچی اسم +(.*)") or Ramin:match("^مسدود اسم (.*)$");
					typegpadd("FilterName:", word);
					sendBot(cht, msg.id, " ⌯ اسم " .. word .. " به لیست تبچی ها اضافه شد! ", "html");
				end;
			end;
			if Ramin and (Ramin:match("^remtabchiname +(.*)") or Ramin:match("^حذف تبچی اسم +(.*)") or Ramin:match("^حذف مسدود اسم +(.*)")) and is_JoinChannel(msg) then
				local word = Ramin:match("^remtabchiname +(.*)") or Ramin:match("^حذف تبچی اسم +(.*)") or Ramin:match("^حذف مسدود اسم +(.*)");
				typegprem("FilterName:", word);
				sendBot(cht, msg.id, " ⌯ اسم " .. word .. " از لیست تبچی ها حذف شد. ", "html");
			end;
			if (Ramin == "clean tabchinamelist" or Ramin == "پاکسازی لیست تبچی اسم") and is_JoinChannel(msg) then
				typegpdel("FilterName:");
				sendBot(cht, msg.id, " ⌯ لیست غیرمجاز اسم تبچی ها پاکسازی شد. ", "html");
			end;
			if (Ramin == "tabchinamelist" or Ramin == "لیست تبچی اسم ها") and is_JoinChannel(msg) then
				if ChatTypeSuperGp then
					local list = base:smembers(TD_ID .. "FilterName:" .. cht);
					local t = " لیست اسامی حذف تبچی اسم :\n";
					for k, v in pairs(list) do
						t = t .. k .. "- *" .. v .. "*\n";
					end;
					if #list == 0 then
						t = " ⌯ لیست تبچی اسم خالی می باشد!";
					end;
					sendBot(cht, msg.id, t, "md");
				end;
				if gp_type(msg.chat_id) == "pv" then
					local t = " لیست تبچی اسم شدہ در *" .. tgps .. "* گروہ شما";
					for k, v in pairs(gps) do
						local list = base:smembers(TD_ID .. "FilterName:" .. v);
						for a, b in pairs(list) do
							t = "" .. t .. "" .. b .. "\nدر گروه *" .. k .. "*\n\n";
						end;
					end;
					sendBot(cht, msg.id, t, "md");
				end;
			end;
			if Ramin and (Ramin:match("^tabchibio +(.*)") or Ramin:match("^تبچی بیو +(.*)") or Ramin:match("^مسدود بیو +(.*)")) and is_JoinChannel(msg) then
				if string.find(Ramin:match("^tabchibio (.*)$") or Ramin:match("^تبچی بیو (.*)$") or Ramin:match("^مسدود بیو (.*)$"), "[%*?^$]") then
					sendBot(cht, msg.id, "🖕😐", "md");
				else
					local word = Ramin:match("^tabchibio +(.*)") or Ramin:match("^تبچی بیو +(.*)") or Ramin:match("^مسدود بیو +(.*)");
					typegpadd("tabchibio:", word);
					sendBot(cht, msg.id, " ⌯ کلمه " .. word .. " به لیست تبچی بیوگرافی های غیرمجاز اضافه شد ! ", "html");
				end;
			end;
			if Ramin and (Ramin:match("^remtabchibio +(.*)") or Ramin:match("^حذف تبچی بیو +(.*)") or Ramin:match("^حذف مسدود بیو +(.*)")) and is_JoinChannel(msg) then
				local word = Ramin:match("^remtabchibio +(.*)") or Ramin:match("^حذف تبچی بیو +(.*)") or Ramin:match("^حذف مسدود بیو +(.*)");
				typegprem("FilterBio:", word);
				sendBot(cht, msg.id, " ⌯ کلمه " .. word .. " از لیست تبچی بیوگرافی های غیرمجاز اضافه شد!", "html");
			end;
			if (Ramin == "clean tabchibiolist" or Ramin == "پاکسازی لیست بیو تبچی") and is_JoinChannel(msg) then
				typegpdel("FilterBio:");
				sendBot(cht, msg.id, " ⌯ پاکسازی لیست  تبچی بیوگرافی های غیرمجاز از سیستم پاکسازی شد ", "html");
			end;
			if (Ramin == "tabchibiolist" or Ramin == "لیست تبچی بیو") and is_JoinChannel(msg) then
				if ChatTypeSuperGp then
					local list = base:smembers(TD_ID .. "FilterBio:" .. cht);
					local t = " ⌯ لیست تبچی بیوگرافی :\n";
					for k, v in pairs(list) do
						t = t .. k .. "- *" .. v .. "*\n";
					end;
					if #list == 0 then
						t = " لیست بیوهای غیرمجاز خالی میباشد !";
					end;
					sendBot(cht, msg.id, t, "md");
				end;
				if gp_type(msg.chat_id) == "pv" then
					local t = " لیست بیوهای غیرمجاز در *" .. tgps .. "* گروہ شما\nبرای دیدن لیست گروہ ها میتوانید از دستور گروہ های من یا [mygps] استفادہ کنید.\n";
					for k, v in pairs(gps) do
						local list = base:smembers(TD_ID .. "FilterBio:" .. v);
						for a, b in pairs(list) do
							t = "" .. t .. "" .. b .. "\nدر گروه *" .. k .. "*\n\n";
						end;
					end;
					sendBot(cht, msg.id, t, "md");
				end;
			end;
			local change = function(ops)
				if not ops then
					return;
				end;
				changelang = {
					FA = {
						"لینک",
						"یوزرنیم",
						"فوروارد",
						"هشتگ",
						"وب",
						"متن",
						"انگلیسی",
						"فارسی",
						"فحش",
						"منشن",
						"ویرایش",
						"گروه",
						"ورود",
						"دستورات",
						"ربات",
						"تبچی",
						"سرویس",
						"عکس",
						"فایل",
						"استیکر",
						"فیلم",
						"ویدیوسلفی",
						"نظرسنجی",
						"مخاطب",
						"بازی",
						"اینلاین",
						"موقعیت",
						"گیف",
						"آهنگ",
						"ویس"
					},
					EN = {
						"link",
						"username",
						"forward",
						"hashtag",
						"webpage",
						"text",
						"english",
						"persian",
						"fosh",
						"mention",
						"edit",
						"muteall",
						"join",
						"cmd",
						"bot",
						"tabchi",
						"tgservice",
						"photo",
						"document",
						"sticker",
						"video",
						"videonote",
						"poll",
						"contact",
						"game",
						"inline",
						"location",
						"gif",
						"music",
						"voice"
					}
				};
				for k, v in pairs(changelang.FA) do
					if ops == v then
						return changelang.EN[k];
					end;
				end;
				return false;
			end;
			if Ramin1 and (Ramin1:match("^قفل لیستی (.*)") or Ramin1:match("^lock list (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
				local inputz = Ramin1:match("^قفل لیستی (.*)") or Ramin1:match("^lock list (.*)");
				text = "قفل لیستی به ترتیب زیر می باشد :\n\n\n";
				for i in string.gmatch(inputz, "%S+") do
					forgod = change(i);
					text = text .. "⌯ قفل " .. i .. " فعال شد !\n";
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:" .. forgod .. "");
				end;
				sendBot(msg.chat_id, msg.id, text, "md");
			end;
			if Ramin1 and (Ramin1:match("^بازکردن لیستی (.*)") or Ramin1:match("^unlock list (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local inputz = Ramin1:match("^بازکردن لیستی (.*)") or Ramin1:match("^unlock list (.*)");
				text = "بازکردن لیستی به ترتیب زیر می باشد :\n\n\n";
				for i in string.gmatch(inputz, "%S+") do
					forgod = change(i);
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:" .. forgod .. "");
					text = text .. "⌯ قفل " .. i .. " غیرفعال شد !\n";
				end;
				sendBot(msg.chat_id, msg.id, text, "md");
			end;
			if Ramin then
				TDDelMatch = Ramin:match("^lock (.*)$") or Ramin:match("^قفل (.*)$");
				TDUnlockMatch = Ramin:match("^unlock (.*)$") or Ramin:match("^بازکردن (.*)$") or Ramin:match("^باز کردن (.*)$");
				local TDMatches = TDDelMatch or TDUnlockMatch;
				if TDMatches and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					local returntd1 = TDMatches:match("^photo$") or TDMatches:match("^game$") or TDMatches:match("^video$") or TDMatches:match("^flood$") or TDMatches:match("^inline$") or TDMatches:match("^videomsg$") or TDMatches:match("^caption$") or TDMatches:match("^voice$") or TDMatches:match("^location$") or TDMatches:match("^document$") or TDMatches:match("^contact$") or TDMatches:match("^text$") or TDMatches:match("^sticker$") or TDMatches:match("^stickervideo$") or TDMatches:match("^stickers$") or TDMatches:match("^gif$") or TDMatches:match("^music$") or TDMatches:match("^عکس$") or TDMatches:match("^بازی$") or TDMatches:match("^فیلم$") or TDMatches:match("^اینلاین$") or TDMatches:match("^دکمه شیشه ای$") or TDMatches:match("^ویدیومسیج$") or TDMatches:match("^فیلم سلفی$") or TDMatches:match("^کپشن$") or TDMatches:match("^موقعیت$") or TDMatches:match("^لوکیشن$") or TDMatches:match("^ویس$") or TDMatches:match("^صدا$") or TDMatches:match("^فایل$") or TDMatches:match("^مخاطب$") or TDMatches:match("^متن$") or TDMatches:match("^استیکر$") or TDMatches:match("^استیکر ویدئو$") or TDMatches:match("^استیکر ویدیو$") or TDMatches:match("^استیکر متحرک$") or TDMatches:match("^گیف$") or TDMatches:match("^اهنگ$") or TDMatches:match("^آهنگ$") or TDMatches:match("^موزیک$") or TDMatches:match("^spam$") or TDMatches:match("^اسپم$") or TDMatches:match("^فلود$") or TDMatches:match("^رگباری$") or TDMatches:match("^پست$") or TDMatches:match("^channelpost$") or TDMatches:match("^بدافزار$") or TDMatches:match("^malware$");
					local returntd2 = TDMatches:match("^link$") or TDMatches:match("^fosh$") or TDMatches:match("^emoji$") or TDMatches:match("^tag$") or TDMatches:match("^username$") or TDMatches:match("^english$") or TDMatches:match("^persian$") or TDMatches:match("^spoiler$") or TDMatches:match("^hyper$") or TDMatches:match("^mention$") or TDMatches:match("^هایپر لینک$") or TDMatches:match("^weblink$") or TDMatches:match("^font$") or TDMatches:match("^وب$") or TDMatches:match("^فونت$") or TDMatches:match("^فیک$") or TDMatches:match("^fake$") or TDMatches:match("^منشن$") or TDMatches:match("^هشتگ$") or TDMatches:match("^یوزرنیم$") or TDMatches:match("^لینک$") or TDMatches:match("^فحش$") or TDMatches:match("^درخواست پیوی$") or TDMatches:match("^msgpv$") or TDMatches:match("^ایموجی$") or TDMatches:match("^فارسی$") or TDMatches:match("^اسپویلر$") or TDMatches:match("^کامند ربات$") or TDMatches:match("^انگلیسی$");
					local returntdf = TDMatches:match("^forwarduser$") or TDMatches:match("^fwduser$") or TDMatches:match("^فوروارد کاربر$") or TDMatches:match("^forwardhidden$") or TDMatches:match("^fwdhidden$") or TDMatches:match("^فوروارد مخفی$") or TDMatches:match("^forward$") or TDMatches:match("^fwd$") or TDMatches:match("^فوروارد کانال$") or TDMatches:match("^forwardchannel$") or TDMatches:match("^fwd$") or TDMatches:match("^فوروارد$");
					local returntdb = TDMatches:match("^bots$") or TDMatches:match("^ربات$");
					local returntde = TDMatches:match("^edit$") or TDMatches:match("^ویرایش$");
					local returntdee = TDMatches:match("^editmedia$") or TDMatches:match("^ویرایش رسانه$");
					local returnbio = TDMatches:match("^لینک بیو$") or TDMatches:match("^biolink$");
					local returntrue = returntd1 or returntd2 or returntdf or returntde or returntdee or returntdb or returnbio;
					local function tdlock(Guard)
						if Guard:match("^photo$") or Guard:match("^عکس$") then
							td = "Photo";
							tde = "ρнσтσ";
							tdf = "عکس";
						elseif Guard:match("^game$") or Guard:match("^بازی$") then
							td = "Game";
							tde = "gαмε";
							tdf = "بازی";
						elseif Guard:match("^video$") or Guard:match("^فیلم$") then
							td = "Video";
							tde = "vιdεσ";
							tdf = "فیلم";
						elseif Guard:match("^inline$") or Guard:match("^دکمه شیشه ای$") or Guard:match("^اینلاین$") then
							td = "Inline";
							tde = "ιηℓιηε";
							tdf = "دکمه شیشه ای";
						elseif Guard:match("^videomsg$") or Guard:match("^ویدیومسیج$") or Guard:match("^فیلم سلفی$") then
							td = "Videomsg";
							tde = "vιdεσмsg";
							tdf = "فیلم سلفی";
						elseif Guard:match("^caption$") or Guard:match("^کپشن$") then
							td = "Caption";
							tde = "cαρтιση";
							tdf = "کپشن";
						elseif Guard:match("^voice$") or Guard:match("^ویس$") or Guard:match("^صدا$") then
							td = "Voice";
							tde = "vσιcε";
							tdf = "ویس";
						elseif Guard:match("^location$") or Guard:match("^لوکیشن$") or Guard:match("^موقعیت$") then
							td = "Location";
							tde = "ℓσcαтιση";
							tdf = "موقعیت مکانی";
						elseif Guard:match("^document$") or Guard:match("^فایل$") then
							td = "Document";
							tde = "∂σcυмεηт";
							tdf = "فایل";
						elseif Guard:match("^contact$") or Guard:match("^مخاطب$") then
							td = "Contact";
							tde = "cσηтαcт";
							tdf = "مخاطب";
						elseif Guard:match("^text$") or Guard:match("^متن$") then
							td = "Text";
							tde = "тεxт";
							tdf = "متن";
						elseif Guard:match("^sticker$") or Guard:match("^استیکر$") then
							td = "Sticker";
							tde = "sтιcкεя";
							tdf = "استیکر";
						elseif Guard:match("^stickervideo$") or Guard:match("^استیکر ویدئو$") or Guard:match("^استیکر ویدیو$") then
							td = "StickerVideo";
							tde = "sтιcкεя";
							tdf = "استیکر ویدئو";
						elseif Guard:match("^stickers$") or Guard:match("^استیکر متحرک$") then
							td = "StickerAnimated";
							tde = "sтιcкεяs";
							tdf = "استیکر متحرک";
						elseif Guard:match("^gif$") or Guard:match("^گیف$") then
							td = "Gif";
							tde = "gιғ";
							tdf = "گیف";
						elseif Guard:match("^music$") or Guard:match("^آهنگ$") or Guard:match("^اهنگ$") or Guard:match("^موزیک$") then
							td = "Music";
							tde = "мυsιc";
							tdf = "آهنگ";
						elseif Guard:match("^flood$") or Guard:match("^فلود$") or Guard:match("^رگباری$") then
							td = "Flood";
							tde = "ғlood";
							tdf = "پیام رگباری";
						elseif Guard:match("^spam$") or Guard:match("^هرزنامه$") or Guard:match("^اسپم$") then
							td = "Spam";
							tde = "ѕpaм";
							tdf = "اسپم";
						elseif Guard:match("^link$") or Guard:match("^لینک$") then
							td = "Link";
							tde = "ℓιηк";
							tdf = "لینک";
						elseif Guard:match("^fosh$") or Guard:match("^فحش$") then
							td = "Fosh";
							tde = "Fosh";
							tdf = "فحش";
						elseif Guard:match("^pv$") or Guard:match("^درخواست پیوی$") then
							td = "MsgPv";
							tde = "MsgPv";
							tdf = "درخواست پیوی";
						elseif Guard:match("^emoji$") or Guard:match("^ایموجی$") then
							td = "Emoji";
							tde = "Emoji";
							tdf = "ایموجی";
						elseif Guard:match("^tag$") or Guard:match("^هشتگ$") then
							td = "Tag";
							tde = "тαg";
							tdf = "هشتگ";
						elseif Guard:match("^username$") or Guard:match("^یوزرنیم$") then
							td = "Username";
							tde = "υsεяηαмε";
							tdf = "یوزرنیم";
						elseif Guard:match("^persian$") or Guard:match("^فارسی$") then
							td = "Persian";
							tde = "ρεяsιση";
							tdf = "فارسی";
						elseif Guard:match("^spoiler$") or Guard:match("^اسپویلر$") then
							td = "Spoiler";
							tde = "ρεяsιση";
							tdf = "اسپویلر";
						elseif Guard:match("^commandbot$") or Guard:match("^کامند ربات$") then
							td = "Command";
							tde = "ρεяsιση";
							tdf = "کامند ربات";
						elseif Guard:match("^english$") or Guard:match("^انگلیسی$") then
							td = "English";
							tde = "εηgℓιsн";
							tdf = "انگلیسی";
						elseif Guard:match("^edit$") or Guard:match("^ویرایش$") then
							td = "Edit";
							tde = "ε∂ιт";
							tdf = "ویرایش";
						elseif Guard:match("^editmedia$") or Guard:match("^ویرایش رسانه$") then
							td = "EditMedia";
							tde = "ε∂ιт";
							tdf = "ویرایش رسانه";
						elseif Guard:match("^forwardchannel$") or Guard:match("^fwdchannel$") or Guard:match("^فوروارد کانال$") then
							td = "ForwardChannel";
							tde = "ғσяωαя∂";
							tdf = "فوروارد کانال";
						elseif Guard:match("^forwardhidden$") or Guard:match("^fwdhidden$") or Guard:match("^فوروارد مخفی$") then
							td = "ForwardHidden";
							tde = "ғσяωαя∂";
							tdf = "فوروارد مخفی";
						elseif Guard:match("^forwarduser$") or Guard:match("^fwduser$") or Guard:match("^فوروارد کاربر$") then
							td = "ForwardUser";
							tde = "ғσяωαя∂";
							tdf = "فوروارد کاربر";
						elseif Guard:match("^forward$") or Guard:match("^fwd$") or Guard:match("^فوروارد$") then
							td = "Forward";
							tde = "ғσяωαя∂";
							tdf = "فوروارد";
						elseif Guard:match("^fake$") or Guard:match("^فیک$") then
							td = "Fake";
							tde = "вσт";
							tdf = "فیک";
						elseif Guard:match("^bots$") or Guard:match("^ربات$") then
							td = "Bots";
							tde = "вσт";
							tdf = "ربات";
						elseif Guard:match("^hyper$") or Guard:match("^هایپر$") or Guard:match("^هایپر لینک$") then
							td = "Hyper";
							tde = "нypυrlιɴĸ";
							tdf = "هایپرلینک";
						elseif Guard:match("^weblink$") or Guard:match("^وب$") then
							td = "Weblink";
							tde = "нypυrlιɴĸ";
							tdf = "وب";
						elseif Guard:match("^font$") or Guard:match("^فونت$") then
							td = "Font";
							tde = "нypυrlιɴĸ";
							tdf = "فونت";
						elseif Guard:match("^mention$") or Guard:match("^منشن$") then
							td = "Mention";
							tde = "мυηтιση";
							tdf = "منشن کاربر";
						elseif Guard:match("^channelpost$") or Guard:match("^پست$") then
							td = "Channelpost";
							tde = "cнαɴɴelpoѕт";
							tdf = "پست کانال";
						elseif Guard:match("^malware$") or Guard:match("^بدافزار$") then
							td = "Malware";
							tde = "мαlwαre";
							tdf = "بدافزار";
						elseif Guard:match("^biolink$") or Guard:match("^لینک بیو$") then
							td = "Biolink";
							tde = "вιolιɴĸ";
							tdf = "لینک بیو";
						end;
					end;
					local locks_del = function(msg, en, fa)
						nametd = "[" .. name .. "](tg://user?id=" .. bd .. ")";
						if tdf == "لینک بیو" then
							sendBot(cht, msg.id, "⌯ * حذف * #لینک بیو  *فعال شد*.", "md");
						elseif base:sismember(TD_ID .. "SetLock:" .. cht, tdf) then
						else
							local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
							alpha = TD.getUser(msg.sender_id.user_id);
							if alpha.usernames.editable_username == "" then
								name = ec_name(alpha.first_name);
							else
								name = alpha.usernames.editable_username;
							end;
							local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
							local gp = (TD.getChat(msg.chat_id)).title;
							text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  قفل " .. tdf .. " را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
							reportowner(text);
							sendBot(cht, msg.id, "⌯ قفل " .. tdf .. " فعال شد ! ", "html");
							base:sadd(TD_ID .. "SetLock:" .. cht, tdf);
						end;
					end;
					if Ramin and TDDelMatch then
						tdlock(TDDelMatch);
						if returntrue then
							if base:sismember(TD_ID .. "Gp:" .. bdcht, "Del:" .. td) then
								sendBot(cht, msg.id, "⌯ قفل " .. tdf .. " فعال می باشد ! ", "html");
							else
								local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
								alpha = TD.getUser(msg.sender_id.user_id);
								if alpha.usernames.editable_username == "" then
									name = ec_name(alpha.first_name);
								else
									name = alpha.usernames.editable_username;
								end;
								local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
								local gp = (TD.getChat(msg.chat_id)).title;
								text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  قفل " .. tdf .. " را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
								reportowner(text);
								sendBot(cht, msg.id, " ⌯ قفل " .. tdf .. " فعال شد ! ", "html");
								base:sadd(TD_ID .. "Gp:" .. cht, "Del:" .. td);
							end;
						end;
					end;
					local unlocks = function(msg, en, fa)
						if ChatTypeSuperGp then
							nametd = "[" .. name .. "](tg://user?id=" .. bd .. ")";
						else
							nametd = "" .. name .. "";
						end;
						if lang then
						elseif tdf == "لینک بیو" then
							sendBot(cht, msg.id, "⌯ *قفل* #" .. tdf .. " *غیرفعال شد*.", "md");
						else
							alpha = TD.getUser(msg.sender_id.user_id);
							local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
							if alpha.usernames.editable_username == "" then
								name = ec_name(alpha.first_name);
							else
								name = alpha.usernames.editable_username;
							end;
							local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
							local gp = (TD.getChat(msg.chat_id)).title;
							text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  قفل " .. tdf .. " را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
							reportowner(text);
							sendBot(cht, msg.id, " ⌯ قفل " .. tdf .. "غیرفعال شد ! ", "html");
							base:srem(TD_ID .. "SetLock:" .. cht, tdf);
						end;
					end;
					if Ramin and TDUnlockMatch then
						tdlock(TDUnlockMatch);
						if returntrue then
							if base:sismember(TD_ID .. "Gp:" .. bdcht, "Del:" .. td) then
								base:srem(TD_ID .. "Gp:" .. cht, "Del:" .. td);
								local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
								alpha = TD.getUser(msg.sender_id.user_id);
								if alpha.usernames.editable_username == "" then
									name = ec_name(alpha.first_name);
								else
									name = alpha.usernames.editable_username;
								end;
								local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
								local gp = (TD.getChat(msg.chat_id)).title;
								text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  قفل " .. tdf .. " را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
								reportowner(text);
								sendBot(cht, msg.id, " ⌯ قفل " .. tdf .. " با موفقیت غیرفعال شد !", "md");
							else
								sendBot(cht, msg.id, " ⌯ قفل " .. tdf .. " غیرفعال می باشد !", "md");
							end;
						end;
					end;
					if Ramin == "lock tabchi" or Ramin == "قفل تبچی" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
						if base:sismember(TD_ID .. "Gp2:" .. cht, "ScanAntiTabchi") then
							sendBot(cht, msg.id, "⌯ قفل تبچی فعال می باشد . ", "html");
						else
							base:sadd(TD_ID .. "Gp2:" .. cht, "ScanAntiTabchi");
							base:sadd(TD_ID .. "Gp2:" .. cht, "BioAntiTabchi");
							base:sadd(TD_ID .. "Gp2:" .. cht, "NameAntiTabchi");
							base:sadd(TD_ID .. "Gp:" .. cht, "Del:Biolink");
							sendBot(cht, msg.id, "⌯ قفل تبچی فعال شد . ", "html");
						end;
					end;
					if Ramin == "lock tabchi" or Ramin == "بازکردن تبچی" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
						if not base:sismember((TD_ID .. "Gp2:" .. cht), "ScanAntiTabchi") then
							sendBot(cht, msg.id, "⌯ قفل تبچی غیرفعال می باشد . ", "html");
						else
							base:srem(TD_ID .. "Gp2:" .. cht, "ScanAntiTabchi");
							base:srem(TD_ID .. "Gp2:" .. cht, "BioAntiTabchi");
							base:srem(TD_ID .. "Gp2:" .. cht, "NameAntiTabchi");
							base:srem(TD_ID .. "Gp:" .. cht, "Del:Biolink");
							sendBot(cht, msg.id, " ⌯ قفل تبچی غیرفعال شد. ", "html");
						end;
					end;
				end;
			end;
			if is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
				if Ramin == "modlist" or Ramin == "لیست مدیران" or Ramin == "لیست مدیران گروه" and is_JoinChannel(msg) then
					local list = base:smembers(TD_ID .. "ModList:" .. msg.chat_id);
					if #list == 0 then
						sendBot(msg.chat_id, msg.id, " ⌯ لیست مدیران گروه خالی میباشد . ", "html");
					else
						local txt = "─┅━━━ لیست مدیران گروه ━━━┅─\n\n";
						for k, v in pairs(list) do
							local usrname = base:get("FirstName:" .. v);
							if usrname then
								username = "@" .. usrname .. " - <code>" .. v .. "</code>";
							else
								Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
								username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
							end;
							local day = base:get(TD_ID .. "daymod:" .. msg.chat_id .. v);
							txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
						end;
						sendBot(msg.chat_id, msg.id, txt, "html");
					end;
				end;
				if Ramin and (Ramin:match("^تنظیم معاون$") or Ramin:match("^setnazem$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						SetNazem(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^تنظیم معاون$") or Ramin:match("^setnazem$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							SetNazem(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						SetNazem(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							SetNazem(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						SetNazem(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^تنظیم معاون (.*)$") or Ramin:match("^setnazem (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					SetNazem(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^تنظیم معاون @(.*)$") or Ramin:match("^setnazem @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^تنظیم معاون @(.*)$") or Ramin:match("^setnazem @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						SetNazem(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^تنظیم معاون (%d+)$") or Ramin:match("^setnazem (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					SetNazem(msg, msg.chat_id, Ramin:match("^تنظیم معاون (%d+)$") or Ramin:match("^setnazem (%d+)$"));
				end;
				if Ramin and (Ramin:match("^حذف معاون$") or Ramin:match("^remnazem$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						RemNazem(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^حذف معاون$") or Ramin:match("^remnazem$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					local text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							RemNazem(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						RemNazem(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							RemNazem(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						RemNazem(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^حذف معاون (.*)$") or Ramin:match("^remnazem (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					RemNazem(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^حذف معاون @(.*)$") or Ramin:match("^remnazem @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^حذف معاون @(.*)$") or Ramin:match("^remnazem @(.*)$");
					local result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						RemNazem(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^حذف معاون (%d+)$") or Ramin:match("^remnazem (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					RemNazem(msg, msg.chat_id, Ramin:match("^حذف معاون (%d+)$") or Ramin:match("^remnazem (%d+)$"));
				end;
				if Ramin == "nazemList" or Ramin == "nazem List" or Ramin == "لیست معاون ها" or Ramin == "لیست معاون" and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
					local list = base:smembers(TD_ID .. "NazemList:" .. msg.chat_id);
					if #list == 0 then
						sendBot(msg.chat_id, msg.id, "⌯ لیست معاون ها خالی می باشد. ", "md");
					else
						local txt = "─┅━━━ لیست معاون ها ━━━┅─\n\n";
						for k, v in pairs(list) do
							local usrname = base:get("FirstName:" .. v);
							if usrname then
								username = "@" .. usrname .. " - <code>" .. v .. "</code>";
							else
								Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
								username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
							end;
							txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
						end;
						sendBot(msg.chat_id, msg.id, txt, "html");
					end;
				end;
				if Ramin == "clean NazemList" or Ramin == "پاکسازی لیست معاون" or Ramin == "پاکسازی لیست معاون ها" and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
					base:del(TD_ID .. "NazemList:" .. msg.chat_id);
					base:del(TD_ID .. "daynazem:" .. msg.chat_id);
					sendBot(msg.chat_id, msg.id, " ⌯ لیست معاونین گروه پاکسازی شد .  ", "html");
				end;
				if Ramin and (Ramin:match("^ادمین$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						AddAdmin(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^ادمین$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					local text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						local result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							AddAdmin(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						AddAdmin(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							AddAdmin(msg, msg.chat_id, Ramin.id);
						end;
					else
						local result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						AddAdmin(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^ادمین (.*)$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					AddAdmin(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^ادمین @(.*)$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^ادمین @(.*)$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn] @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						AddAdmin(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^ادمین (%d+)$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					AddAdmin(msg, msg.chat_id, Ramin:match("^ادمین (%d+)$") or Ramin:match("^[Ss][Ee][Tt][Aa][Dd][Mm][Ii][Nn] (%d+)$"));
				end;
				if Ramin and (Ramin:match("^حذف ادمین$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					local res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						DelAdmin(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^حذف ادمین$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					local text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						local result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							DelAdmin(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						DelAdmin(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							DelAdmin(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						DelAdmin(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^حذف ادمین (.*)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					DelAdmin(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^حذف ادمین @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^حذف ادمین @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn] @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						DelAdmin(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^حذف ادمین (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					DelAdmin(msg, msg.chat_id, Ramin:match("^حذف ادمین (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Dd][Mm][Ii][Nn] (%d+)$"));
				end;
				if Ramin and (Ramin:match("^setgpbio (.*)") or Ramin:match("^تنظیم توضیح (.*)")) then
					local bio = Ramin:match("^setgpbio (.*)") or Ramin:match("^تنظیم توضیح (.*)");
					number = utf8.len(bio);
					if number > 100 then
						sendBot(msg.chat_id, msg.id, "⌯ تا 100 کارکتر برای بیوگرافی مجاز است\n\n⌯ تعداد حروف شما : \n" .. number, "html");
					else
						TD.setChatDescription(msg.chat_id, bio);
						aboutgp = (TD.getSupergroupFullInfo(msg.chat_id)).description;
						base:set(TD_ID .. "biogb" .. msg.chat_id, bio);
						sendBot(msg.chat_id, msg.id, "⌯ بیوگرافی گروه تنظیم شد به :\n\n⌯ تعداد کارکتر : " .. number .. "\n⌯ متن بیوگرافی گروه : " .. bio, "html");
					end;
				end;
				if Ramin == "لیست لقب مدیران" or Ramin == "adminranks" then
					data = TD.getChatAdministrators(msg.chat_id);
					if #data.administrators ~= 0 or #data.administrators ~= 1 then
						Text = "⌯ لیست لقب مدیران :\n\n";
						i = 1;
						for i, v in pairs(data.administrators) do
							if not v.is_owner then
								name = (TD.getUser(v.user_id)).usernames.editable_username or (TD.getUser(v.user_id)).first_name;
								if v.custom_title == "" then
									custom = "🅴 لقب  : ندارد";
								elseif v.custom_title then
									custom = "🅴 لقب  : " .. v.custom_title;
								end;
								Text = Text .. "🅵 %{" .. name .. "," .. v.user_id .. "} - " .. v.user_id .. "\n" .. custom .. "\n⌯ ┅┅━━━━ ⌯ ━━━━┅┅ ⌯ \n";
								i = i + 1;
							end;
						end;
					else
						Text = "⌯ هیچ ادمینی برای گروه انتخاب نشده است";
					end;
					sendBot(msg.chat_id, msg.id, Text, "lg");
				end;
				if Ramin == "config" or Ramin == "پیکربندی" and is_JoinChannel(msg) then
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == true then

								owner_id = n.user_id;
								base:sadd(TD_ID .. "OwnerList:" .. msg.chat_id, owner_id);
								
							end;
						end;
					end;
					local data = TD.getChatAdministrators(msg.chat_id);
					if #data.administrators ~= 0 or #data.administrators ~= 1 then
						for i, v in pairs(data.administrators) do
							if not v.is_owner then
								ram = i;
								idmod = v.user_id;
								base:sadd(TD_ID .. "ModList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModCleanList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModBanList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModMuteList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModWarnList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModLockList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModpanelList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModVipList:" .. msg.chat_id, idmod);
								base:sadd(TD_ID .. "ModCoList:" .. msg.chat_id, idmod);
							end;
						end;
					end;
					local results = TD.getSupergroupMembers(msg.chat_id, "Bots", "", 0, 200);
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModAlList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModClList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModBnList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModMutList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModWarList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModLokList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModVpList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModpnelList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModPnList");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "ModCoList");
					local result = TD.getSupergroupFullInfo(msg.chat_id);
					local owner = (TD.getUser(owner_id)).first_name or (TD.getUser(777000)).first_name;
					text = "<b>✅ ارتقا مقام داران با موفقیت انجام شد.</b>\n┈┅┅━اطلاعات گروه━┅┅┈ \n👤 مالک گروه :  <b><a href=\"tg://user?id=" .. owner_id .. "\">" .. (TD.getUser(owner_id)).first_name .. "</a></b>\n👮♀️تعداد مدیران  : <b>" .. Alpha(ram) .. "</b> عدد \n🚷تعداد مسدود شده: <b>" .. Alpha(result.banned_count) .. "</b> عدد\n🤖تعداد ربات های گروه : <b>" .. Alpha(results.total_count) .. "</b> عدد";
					Keyboard = {
						{
							{
								text = "⌯ لیست ادمین ها",
								data = "bd:modlist2:" .. msg.chat_id
							}
						},
						{
							{
								text = "⌯ دسترسی دستورات",
								data = "bd:adminsetcmd:" .. msg.chat_id
							}
						},
						{
							{
								text = "بستن و تایید ⊴",
								data = "bd:Exitspanl:" .. msg.chat_id
							}
						},
						{}
					};
					TD.sendText(msg.chat_id, msg.id, text, "html", false, false, false, false, TD.replyMarkup({
						type = "inline",
						data = Keyboard
					}));
				end;
				
				
				
				if (Ramin == 'setlang en' or Ramin == 'تنظیم زبان انگلیسی') and is_JoinChannel(msg) then
if base:sismember(TD_ID..'Gp2:'..msg.chat_id,'Telebotlang') then
sendBot(msg.chat_id,msg.id,'⌯ ﹡Gʀᴏᴜᴘ Lᴀɴɢᴜᴀɢᴇ ᴀʟʀᴇᴀᴅʏ﹡ Eɴɢʟɪsʜ ﹗','md')
else
base:sadd(TD_ID..'Gp2:'..msg.chat_id,'Telebotlang')
sendBot(msg.chat_id, msg.id, '⌯ ﹡Gʀᴏᴜᴘ Lᴀɴɢᴜᴀɢᴇ sᴇᴛ ᴏɴ﹡ Eɴɢʟɪsʜ ﹗','md')
end
end
if (Ramin == 'setlang fa' or Ramin == 'تنظیم زبان فارسی') and is_JoinChannel(msg) then
if base:sismember(TD_ID..'Gp2:'..msg.chat_id,'Telebotlang') then
base:srem(TD_ID..'Gp2:'..msg.chat_id,'Telebotlang')
sendBot(msg.chat_id,msg.id,'⌯ زبان ربات به فارسی تنظیم شد .','md')
else
sendBot(msg.chat_id,msg.id,'⌯ زبان ربات به فارسی می باشد .','md')
end
end
				
				
				if Ramin and (Ramin:match("^ارتقا مقام$") or Ramin:match("^promote$") or Ramin:match("^تنظیم مدیر$") or Ramin:match("^مدیر$") or Ramin:match("^ارتقا$") or Ramin:match("^ترفیع$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Setadmin(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^ارتقا مقام$") or Ramin:match("^promote$") or Ramin:match("^تنظیم مدیر$") or Ramin:match("^مدیر$") or Ramin:match("^ارتقا$") or Ramin:match("^ترفیع$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Setadmin(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Setadmin(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Setadmin(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						Setadmin(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^ارتقا مقام (.*)$") or Ramin:match("^promote (.*)$") or Ramin:match("^تنظیم مدیر (.*)$") or Ramin:match("^ارتقا (.*)$") or Ramin:match("^مدیر (.*)$") or Ramin:match("^ترفیع (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					Setadmin(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^ارتقا مقام @(.*)$") or Ramin:match("^promote @(.*)$") or Ramin:match("^تنظیم مدیر @(.*)$") or Ramin:match("^مدیر @(.*)$") or Ramin:match("^ارتقا @(.*)$") or Ramin:match("^ترفیع @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^ارتقا مقام @(.*)$") or Ramin:match("^promote @(.*)$") or Ramin:match("^تنظیم مدیر @(.*)$") or Ramin:match("^ترفیع @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						Setadmin(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^ارتقا مقام (%d+)$") or Ramin:match("^promote (%d+)$") or Ramin:match("^تنظیم مدیر (%d+)$") or Ramin:match("^مدیر (%d+)$") or Ramin:match("^ارتقا (%d+)$") or Ramin:match("^ترفیع (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					Setadmin(msg, msg.chat_id, Ramin:match("^ارتقا مقام (%d+)$") or Ramin:match("^promote (%d+)$") or Ramin:match("^تنظیم مدیر (%d+)$") or Ramin:match("^ترفیع (%d+)$"));
				end;
				if Ramin and (Ramin:match("^عزل مقام$") or Ramin:match("^demote$") or Ramin:match("^حذف مدیر$") or Ramin:match("^عزل$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Remadmin(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^promotelistes @(.*)$") or Ramin:match("^ارتقا مقام لیستی @(.*)$") or Ramin:match("^ارتقا لیستی @(.*)$")) then
					local inputz = Ramin:match("^promotelistes @(.*)$") or Ramin:match("^ارتقا مقام لیستی @(.*)$") or Ramin:match("^ارتقا لیستی @(.*)$");
					text = "⌯ کاربران زیر به لیست مدیران اضافه شدند :\n\n";
					for i in string.gmatch(inputz, "%S+") do
						taglist = i;
						result = TD.searchPublicChat(taglist);
						use = TD.getUser(result.id);
						if use.usernames.editable_username == "" then
							name = ec_name(use.first_name);
						else
							name = use.usernames.editable_username;
						end;
						if not result.id then
							text = "⌯ عملیات ناموفق !";
							break;
						else
							base:sadd(TD_ID .. "ModListtest:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModCleanList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModBanList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModMuteList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModWarnList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModLockList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModpanelList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModVipList:" .. msg.chat_id, result.id);
							base:sadd(TD_ID .. "ModLockOption:" .. msg.chat_id, result.id);
							username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
							text = text .. "🄼 " .. username .. "-<code>" .. result.id .. "</code>\n";
						end;
					end;
					sendBot(msg.chat_id, msg.id, text, "html");
				end;
				if Ramin and (Ramin:match("^demotelistes @(.*)$") or Ramin:match("^عزل لیستی @(.*)$")) then
					local inputz = Ramin:match("^demotelistes @(.*)$") or Ramin:match("^عزل لیستی @(.*)$");
					text = "⌯ کاربران زیر از لیست مدیران حذف شدند :\n\n";
					for i in string.gmatch(inputz, "%S+") do
						taglist = i;
						result = TD.searchPublicChat(taglist);
						use = TD.getUser(result.id);
						if use.usernames.editable_username == "" then
							name = ec_name(use.first_name);
						else
							name = use.usernames.editable_username;
						end;
						if not result.id then
							text = "⌯ عملیات ناموفق !";
							break;
						else
							base:srem(TD_ID .. "ModListtest:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModCleanList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModBanList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModMuteList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModWarnList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModLockList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModpanelList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModVipList:" .. msg.chat_id, result.id);
							base:srem(TD_ID .. "ModLockOption:" .. msg.chat_id, result.id);
							username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
							text = text .. "🄼 " .. username .. "-<code>" .. result.id .. "</code>\n";
						end;
					end;
					sendBot(msg.chat_id, msg.id, text, "html");
				end;
				if Ramin and (Ramin:match("^عزل مقام$") or Ramin:match("^demote$") or Ramin:match("^حذف مدیر$") or Ramin:match("^عزل$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Remadmin(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Remadmin(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Remadmin(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						Remadmin(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^عزل مقام (.*)$") or Ramin:match("^demote (.*)$") or Ramin:match("^حذف مدیر (.*)$") or Ramin:match("^عزل (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					Remadmin(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^عزل مقام @(.*)$") or Ramin:match("^demote @(.*)$") or Ramin:match("^حذف مدیر @(.*)$") or Ramin:match("^عزل @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					local username = Ramin:match("^عزل مقام @(.*)$") or Ramin:match("^demote @(.*)$") or Ramin:match("^حذف مدیر @(.*)$") or Ramin:match("^عزل @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						Remadmin(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^عزل مقام (%d+)$") or Ramin:match("^demote (%d+)$") or Ramin:match("^حذف مدیر (%d+)$") or Ramin:match("^عزل (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
					dofile("./checkuser.lua");
					Remadmin(msg, msg.chat_id, Ramin:match("^عزل مقام (%d+)$") or Ramin:match("^demote (%d+)$") or Ramin:match("^حذف مدیر (%d+)$") or Ramin:match("^عزل (%d+)$"));
				end;
				if Ramin == "clean modlist" or Ramin == "پاکسازی لیست مدیران" and is_JoinChannel(msg) then
					base:del(TD_ID .. "ModList:" .. msg.chat_id);
					base:del(TD_ID .. "daymod:" .. msg.chat_id);
					sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی لیست مدیران با موفقیت انجام شد .  ", "html");
				end;
				if (Ramin == "Kheyanat on" or Ramin == "قفل خیانت") and is_JoinChannel(msg) then
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "Kheyanat:on");
					sendBot(msg.chat_id, msg.id, "⌯ قفل خیانت ادمین ها فعال شد . ", "html");
				end;
				if (Ramin == "Kheyanat on" or Ramin == "بازکردن خیانت") and is_JoinChannel(msg) then
					base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "Kheyanat:on");
					sendBot(msg.chat_id, msg.id, "⌯ قفل خیانت ادمین ها غیرفعال شد . ", "html");
				end;
				if Ramin and (Ramin:match("^settimekheyanat (%d+)$") or Ramin:match("^زمان بررسی خیانت (%d+)$")) and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
					local num = Ramin:match("^settimekheyanat (%d+)") or Ramin:match("^زمان بررسی خیانت (%d+)");
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Kheyanat:on") then
						if tonumber(num) < 50 then
							sendBot(msg.chat_id, msg.id, "عددی بزرگتر از 50 ارسال شود!", "md");
						else
							base:set(TD_ID .. "Kheyanat:Time:" .. msg.chat_id, num);
							sendBot(msg.chat_id, msg.id, " ⌯ زمان بررسی قفل خیانت ادمین ها تنظیم شد به : " .. num .. " ثانیه ", "html");
						end;
					else
						sendBot(msg.chat_id, msg.id, " ⌯ قفل خیانت ادمین ها فعال نمی باشد!", "html");
					end;
				end;
				if Ramin and (Ramin:match("^settimekheyanat (%d+)$") or Ramin:match("^تعداد بررسی خیانت (%d+)$")) and is_JoinChannel(msg) and is_Owner(msg) and is_OwnerPlus(msg) then
					local num = Ramin:match("^settimekheyanat (%d+)") or Ramin:match("^تعداد بررسی خیانت (%d+)");
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Kheyanat:on") then
						if tonumber(num) < 2 then
							sendBot(msg.chat_id, msg.id, "عددی بزرگتر از 2 ارسال شود!", "md");
						else
							base:set(TD_ID .. "Kheyanat:Max:" .. msg.chat_id, num);
							sendBot(msg.chat_id, msg.id, " ⌯ تعداد بررسی قفل خیانت ادمین ها تنظیم شد به : " .. num .. " ثانیه ", "html");
						end;
					else
						sendBot(msg.chat_id, msg.id, " ⌯ قفل خیانت ادمین ها فعال نمی باشد!", "html");
					end;
				end;
				if Ramin and (Ramin:match("^cleanerautotime (%d+)[h]") or Ramin:match("^زمان پاکسازی خودکار (%d+) [ساعت]")) and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
					local num = Ramin:match("^cleanerautotime (%d+)[h]") or Ramin:match("^زمان پاکسازی خودکار (%d+) [ساعت]");
					if Ramin and (Ramin:match("(%d+)h") or Ramin:match("(%d+) ساعت")) then
						time_match = Ramin:match("(%d+)h") or Ramin:match("(%d+) ساعت");
						time = time_match * 3600;
						th = time / 3600;
						t = "ساعت";
					end;
					base:set(TD_ID .. "cgmautotime:" .. msg.chat_id, time);
					base:set(TD_ID .. "cgmautotime1:" .. msg.chat_id, time);
					base:set(TD_ID .. "cgmautotime2:" .. msg.chat_id, time);
					base:set(TD_ID .. "cgmautotime3:" .. msg.chat_id, time);
					base:set(TD_ID .. "cgmautotime4:" .. msg.chat_id, time);
					sendBot(msg.chat_id, msg.id, " ⌯ زمان پاکسازی خودکار تنظیم شد بر روی : " .. th .. " " .. t .. "\n⌯ یعنی هر " .. th .. " " .. t .. " ساعت یکبار پاکسازی تمامی پیام های گپ بصورت اتوماتیک انجام خواهد شد...! ", "html");
				end;
				if (Ramin == "cgm on" or Ramin == "پاکسازی خودکار فعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
					local timecgmbaghi = base:ttl(TD_ID .. "cgmauto:" .. msg.chat_id);
					local timecgm = base:get(TD_ID .. "cgmautotime:" .. msg.chat_id);
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cgmautoon") and timecgm then
						local Time_ = getTimeUptime(timecgmbaghi);
						Time_S = "⌯ زمان باقی مانده تا انجام پاکسازی \n:[ " .. Time_ .. " ]";
						sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار کلی پیام ها فعال می باشد!\n\n⌯ " .. Time_S .. " ", "html");
					elseif timecgm then
						local timecgm2 = timecgm / 3600;
						t1 = timecgm - 60;
						t2 = timecgm - 300;
						t3 = timecgm - 1200;
						t4 = timecgm - 3540;
						base:setex(TD_ID .. "cgmauto:" .. msg.chat_id, timecgm, true);
						base:setex(TD_ID .. "cgmauto1:" .. msg.chat_id, t1, true);
						base:setex(TD_ID .. "cgmauto2:" .. msg.chat_id, t2, true);
						base:setex(TD_ID .. "cgmauto3:" .. msg.chat_id, t3, true);
						base:setex(TD_ID .. "cgmauto4:" .. msg.chat_id, t4, true);
						base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "cgmautoon");
						sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام ها فعال شد!\n\n⌯ ⌯ زمان پاکسازی خودکار پیام " .. timecgm2 .. " ساعت یکبار انجام خواهد شد. ", "html");
					else
						sendBot(msg.chat_id, msg.id, " ⌯ زمان پاکسازی خودکار پیام ها تنظیم نشده است!\n\n⌯ برای تنظیم کردن زمان از دستور زیر استفاده کنید :\n ⌯ زمان پاکسازی خودکار [عدد] ساعت  ", "html");
					end;
				end;
				if (Ramin == "cgm off" or Ramin == "پاکسازی خودکار غیرفعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cgmautoon") then
						base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "cgmautoon");
						base:del(TD_ID .. "cgmauto:" .. msg.chat_id);
						base:del(TD_ID .. "cgmauto1:" .. msg.chat_id);
						base:del(TD_ID .. "cgmauto2:" .. msg.chat_id);
						base:del(TD_ID .. "cgmauto3:" .. msg.chat_id);
						base:del(TD_ID .. "cgmauto4:" .. msg.chat_id);
						sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار غیرفعال شد ! ", "html");
					else
						sendBot(msg.chat_id, msg.id, "⌯ پاکسازی خودکار غیرفعال بود ! ", "html");
					end;
				end;
			end;
			if is_Mod(msg) then
				if Ramin == "lock title" or Ramin == "قفل عنوان" or Ramin == "قفل هویت مخفی" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Title") then
						sendBot(msg.chat_id, msg.id, " ⌯ قفل عنوان فعال می باشد !  ", "html");
					else
						base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Title");
						sendBot(msg.chat_id, msg.id, "⌯ قفل عنوان فعال شد . ", "html");
					end;
				end;
				if Ramin == "unlock title" or Ramin == "بازکردن عنوان"  and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Title") then
						base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Title");
						sendBot(msg.chat_id, msg.id, " ⌯ قفل عنوان غیرفعال شد .  ", "html");
					else
						sendBot(msg.chat_id, msg.id, " ⌯ قفل عنوان غیرفعال می باشد ! ", "html");
					end;
				end;
				if Ramin == "lock number" or Ramin == "قفل شماره" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Number") then
						sendBot(msg.chat_id, msg.id, " ⌯ قفل شماره فعال می باشد !  ", "html");
					else
						base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Number");
						sendBot(msg.chat_id, msg.id, " ⌯ قفل شماره فعال شد ! ", "html");
						local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						alpha = TD.getUser(msg.sender_id.user_id);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
						local gp = (TD.getChat(msg.chat_id)).title;
						text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " قفل شماره را ارسال کرد.\n\n" .. tarikh .. "";
					end;
				end;
				if Ramin == "unlock number" or Ramin == "بازکردن شماره" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Number") then
						base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Number");
						local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						alpha = TD.getUser(msg.sender_id.user_id);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
						local gp = (TD.getChat(msg.chat_id)).title;
						text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " بازکردن شماره را ارسال کرد.\n\n" .. tarikh .. "";
						sendBot(msg.chat_id, msg.id, "⌯ قفل شماره غیرفعال شد .  ", "html");
					else
						sendBot(msg.chat_id, msg.id, " ⌯ قفل شماره غیرفعال می باشد ! ", "html");
					end;
				end;
				if Ramin == "postchannel on" or Ramin == "پیام کانال فعال" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if not base:sismember((TD_ID .. "ModList:" .. msg.chat_id), 777000) then
						sendBot(msg.chat_id, msg.id, " ⌯ ارسال پیام کانال متصل فعال شد! ", "html");
						local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						alpha = TD.getUser(msg.sender_id.user_id);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
						local gp = (TD.getChat(msg.chat_id)).title;
						text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " قفل پیام کانال را ارسال کرد.\n\n" .. tarikh .. "";
						base:sadd(TD_ID .. "ModList:" .. msg.chat_id, 777000);
					else
						sendBot(msg.chat_id, msg.id, " ⌯ ارسال پیام کانال متصل فعال می باشد! ", "html");
					end;
				end;
				if Ramin == "postchannel off" or Ramin == "پیام کانال غیرفعال" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
					if base:sismember(TD_ID .. "ModList:" .. msg.chat_id, 777000) then
						local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						alpha = TD.getUser(msg.sender_id.user_id);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
						local gp = (TD.getChat(msg.chat_id)).title;
						text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " بازکردن پیام کانال را ارسال کرد.\n\n" .. tarikh .. "";
						sendBot(msg.chat_id, msg.id, " ⌯ ارسال پیام کانال متصل غیرفعال شد ! ", "html");
						base:srem(TD_ID .. "ModList:" .. msg.chat_id, 777000);
					else
						sendBot(msg.chat_id, msg.id, " ⌯ ارسال پیام کانال متصل غیرفعال بود ! ", "html");
					end;
				end;
			end;
			if is_Sudo(msg) then
				if Ramin == "joinchannel off" or Ramin == "جوین چنل خاموش" then
					base:del(TD_ID .. "joinchnl");
					sendBot(msg.chat_id, msg.id, "⌯ جوین چنل خاموش شد و دیگر کاربران برای استفاده از دستورات نیازی به ورود به کانال ربات نخواهند داشت!", "md");
				end;
				if Ramin == "joinchannel on" or Ramin == "جوین چنل روشن" then
					base:set(TD_ID .. "joinchnl", true);
					sendBot(msg.chat_id, msg.id, "⌯ جوین چنل روشن شد و کاربران برای استفاده از دستورات ربات باید ابتدا در کانال ربات عضو شوند!", "md");
				end;
				if Ramin and (Ramin:match("^مسدود همگانی$") or Ramin:match("^مسدود سراسری$") or Ramin:match("^بن ال$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll]$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						BanallUser(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^مسدود همگانی$") or Ramin:match("^مسدود سراسری$") or Ramin:match("^بن ال$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll]$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							BanallUser(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Banall(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							BanallUser(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						BanallUser(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and Ramin and (Ramin:match("^مسدود همگانی (.*)$") or Ramin:match("^مسدود سراسری (.*)$") or Ramin:match("^بن ال (.*)$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					BanallUser(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^مسدود همگانی @(.*)$") or Ramin:match("^مسدود سراسری @(.*)$") or Ramin:match("^بن ال @(.*)$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
					local username = Ramin:match("^مسدود همگانی @(.*)$") or Ramin:match("^مسدود سراسری @(.*)$") or Ramin:match("^بن ال @(.*)$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll] @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						BanallUser(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  @" .. username .. " یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^مسدود همگانی (%d+)$") or Ramin:match("^مسدود سراسری (%d+)$") or Ramin:match("^بن ال (%d+)$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
					dofile("./checkuser.lua");
					BanallUser(msg, msg.chat_id, Ramin:match("^مسدود همگانی (%d+)$") or Ramin:match("^مسدود سراسری (%d+)$") or Ramin:match("^بن ال (%d+)$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll] (%d+)$"));
				end;
				if Ramin and (Ramin:match("^حذف مسدود همگانی$") or Ramin:match("^حذف مسدود سراسری$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll]$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						UnbanallUser(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^حذف مسدود همگانی$") or Ramin:match("^حذف مسدود سراسری$") or Ramin:match("^حذف بن ال$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll]$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							UnbanallUser(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						UnbanallUser(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							UnbanallUser(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						UnbanallUser(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and Ramin and (Ramin:match("^حذف مسدود همگانی (.*)$") or Ramin:match("^حذف مسدود سراسری (.*)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					UnbanallUser(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^حذف مسدود همگانی @(.*)$") or Ramin:match("^حذف مسدود سراسری @(.*)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
					local username = Ramin:match("^حذف مسدود همگانی @(.*)$") or Ramin:match("^حذف مسدود سراسری @(.*)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll] @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						UnbanallUser(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯ کاربر  @" .. username .. "  یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^حذف مسدود همگانی (%d+)$") or Ramin:match("^حذف مسدود سراسری (%d+)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
					dofile("./checkuser.lua");
					UnbanallUser(msg, msg.chat_id, Ramin:match("^حذف مسدود همگانی (%d+)$") or Ramin:match("^حذف مسدود سراسری (%d+)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll] (%d+)$"));
				end;
				if Ramin == "addcleaner" or Ramin == "نصب" then
					TD.setChatMemberStatus(msg.chat_id, BotCliId, "Administrator", {
						1,
						1,
						0,
						0,
						1,
						1,
						1,
						1,
						1
					});
				end;
				if Ramin and (Ramin:match("^لیست مسدود همگانی$") or Ramin:match("^لیست مسدود سراسری$") or Ramin:match("^[Bb][Aa][Nn][Aa][Ll][Ll][Ss]$")) and tonumber(msg.reply_to_message_id) == 0 then
					local list = base:smembers("GlobalyBanned:");
					if #list == 0 then
						sendBot(msg.chat_id, msg.id, "⌯ لیست مسدودین کلی خالی میباشد !", "md");
					else
						local txt = "⌯ لیست مسدودین کلی :\n\n";
						for k, v in pairs(list) do
							local firstname = base:get("firstname" .. v);
							if firstname then
								username = "<a href=\"tg://user?id=" .. v .. "\">" .. StringData(firstname) .. "</a>";
							else
								username = "<a href=\"tg://user?id=" .. v .. "\">" .. v .. "</a>";
							end;
							txt = txt .. k .. " - [ " .. username .. " ]\n";
						end;
						sendBot(msg.chat_id, msg.id, txt, "html");
					end;
				end;
				if Ramin == "clean gbans" or Ramin == "پاکسازی لیست مسدود سراسری" or Ramin == "پاکسازی لیست مسدود همگانی" then
					base:del("GlobalyBanned:");
					sendBot(msg.chat_id, msg.id, "⌯ پاکسازی لیست مسدود سراسری انجام شد", "md");
				end;
				if Ramin == "leave" or Ramin == "خروج" then
					sendBot(msg.chat_id, msg.id, " ⌯ ربات از گروه خارج شد...!", "md");
					TD.leaveChat(msg.chat_id);
				end;
				if Ramin == "unlock porn" or Ramin == "لغو قفل پورن" and is_Sudo(msg) then
					pwarn = tonumber(base:hget(TD_ID .. "porn" .. msg.chat_id, TD_ID) or 0);
					base:srem(TD_ID .. "PornGp1", msg.chat_id);
					base:setex(TD_ID .. "SvPorn" .. msg.chat_id, tonumber(5), true);
					sendBot(msg.chat_id, msg.id, "⌯ قفل پورن گروه از سیستم حذف شد !", "md");
				end;
				if Ramin == "pornexpire" or Ramin == "اعتبار پورن" and is_Sudo(msg) then
					local check_time = base:ttl(TD_ID .. "SvPorn" .. msg.chat_id);
					year = math.floor(check_time / 31536000);
					byear = check_time % 31536000;
					month = math.floor(byear / 2592000);
					bmonth = byear % 2592000;
					day = math.floor(bmonth / 86400);
					bday = bmonth % 86400;
					hours = math.floor(bday / 3600);
					bhours = bday % 3600;
					min = math.floor(bhours / 60);
					sec = math.floor(bhours % 60);
					if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
						remained_expire = "⌯ قفل پورن بدون اعتبار می باشد!";
					elseif tonumber(check_time) > 1 and check_time < 60 then
						remained_expire = "⌯ قفل پورن به مدت " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 60 and check_time < 3600 then
						remained_expire = "⌯ قفل پورن به مدت " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
						remained_expire = "⌯ قفل پورن به مدت " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
						remained_expire = "⌯ قفل پورن به مدت " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
						remained_expire = "⌯ قفل پورن به مدت " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 31536000 then
						remained_expire = "⌯ قفل پورن به مدت " .. year .. " سال " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					end;
					sendBot(msg.chat_id, msg.id, "" .. remained_expire .. "", "md");
				end;
				if Ramin == "reload" or Ramin == "بروز" and is_Sudo(msg) then


					-- ListMember = base:smembers(TD_ID .. "sender_id.user_ids:" .. msg.chat_id);
					-- if #ListMember == 0 then
					-- else
					-- 	for i, i in pairs(ListMember) do
					-- 		base:del(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. msg.chat_id);
					-- 		base:del(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. msg.chat_id);
					-- 		base:del(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. msg.chat_id);
					-- 		base:del(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. msg.chat_id);
					-- 		base:del(TD_ID .. "Content_Message:MediaMsgsDay:" .. i .. ":" .. msg.chat_id);
					-- 	end;
					-- end;

					sendBot(msg.chat_id, msg.id, "⌯ ربات اصلی بروز شد !", "md");
					for k, v in pairs({
						"animations",
						"documents",
						"music",
						"photos",
						"temp",
						"video_notes",
						"videos",
						"thumbnails",
						"voice",
						"stickers"
					}) do
						os.execute("rm -rf ~/TeleBot/.tdlua-sessions/telebot/" .. v .. "/*");
						io.popen("sync && echo 3 > /proc/sys/vm/drop_caches");
						io.popen("swapoff -a && swapon -a");
						io.popen("rm -rf $PWD/.tdlua.log");
						io.popen("rm -rf $PWD/.tdlua.log.old");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/db.sqlite-wal");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/db.sqlite");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/photos/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/animations/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/videos/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/music/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/voice/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/temp/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/documents/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/video_notes/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/stickers/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/thumbnails/*");
						io.popen("rm -rf $PWD/.tdlua-sessions/telebot/profile_photos/*");
						TD.set_timer(10, checker);
					end;
				end;
				if Ramin and (Ramin:match("^chargeporn (%d+)$") or Ramin:match("^شارژ پورن (%d+)$")) and is_Sudo(msg) then
					local time = tonumber((Ramin:match("^chargeporn (%d+)$") or Ramin:match("^شارژ پورن (%d+)$"))) * 86400;
					pwarn = tonumber(base:hget(TD_ID .. "porn" .. msg.chat_id, TD_ID) or 0);
					pmax = tonumber(base:hget(TD_ID .. "porn", "pornnmax") or 1);
					sgpsporn = base:scard(TD_ID .. "PornGp1");
					base:sadd(TD_ID .. "PornGp1", msg.chat_id);
					if sgpsporn == pmax then
						sendBot(msg.chat_id, msg.id, "⌯ مدیر عزیز تعداد قفل فعالی شما تمام شده است !", "md");
					else
						local input2 = math.floor(time / 86400);
						base:setex(TD_ID .. "SvPorn" .. msg.chat_id, time - 1, true);
						local timet = jdate("⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						local res = TD.getSupergroupFullInfo(msg.chat_id);
						text = " \n\n⌯ قفل پورن گروه  " .. input2 .. " روز شارژ شد !\n\n\n" .. timet .. "\n\n─┅━ شارژ کننده ━┅─\n\n⌯ نام کاربر : *" .. (TD.getUser(msg.sender_id.user_id)).first_name .. "*\n\n⌯ یوزرنیم کاربر : @" .. (TD.getUser(msg.sender_id.user_id)).usernames.editable_username .. "\n\n─┅━ مشخصات گروه ━┅─\n\n⌯ نام گروه : *" .. (TD.getChat(msg.chat_id)).title .. "*\n\n⌯ چت ایدی : `" .. msg.chat_id .. "`\n\n⌯ لینک گروه : *" .. res.invite_link.invite_link .. "*\n\n\n─┅━ تعداد پورن ━┅─\n\n⌯ تعداد فعال : *" .. sgpsporn .. "*\n\n⌯ باقی مانده : *" .. pmax - sgpsporn .. "*\n\n\n#PornCharge\n";
						sendBot(Sudoid, msg.id, text, "md");
						sendBot(Config.IDSup, msg.id, text, "md");
						sendBot(msg.chat_id, msg.id, "⌯ قفل پورن گروه  " .. input2 .. " روز شارژ شد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^chargeplayer (%d+)$") or Ramin:match("^شارژ پلیر (%d+)$")) and is_Sudo(msg) then
					local time = tonumber((Ramin:match("^chargeplayer (%d+)$") or Ramin:match("^شارژ پلیر (%d+)$"))) * 86400;
					pwarn = tonumber(base:hget(TD_ID .. "player" .. msg.chat_id, TD_ID) or 0);
					pmax = tonumber(base:hget(TD_ID .. "player", "playermax") or 1);
					sgpsplayer = base:scard(TD_ID .. "playergps");
					base:sadd(TD_ID .. "playergps", msg.chat_id);
					if sgpsplayer == pmax then
						sendBot(msg.chat_id, msg.id, "⌯ ادمین محترم ، شما به حداکثر گروه رسیده اید !", "md");
					else
						local input2 = math.floor(time / 86400);
						base:setex(TD_ID .. "Svplayer" .. msg.chat_id, time - 1, true);
						local timet = jdate("⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
						local res = TD.getSupergroupFullInfo(msg.chat_id);
						text = " \n\n⌯ پلیر  گروه  " .. input2 .. " روز شارژ شد !\n\n\n" .. timet .. "\n\n─┅━ شارژ کننده ━┅─\n\n⌯ نام کاربر : *" .. (TD.getUser(msg.sender_id.user_id)).first_name .. "*\n\n⌯ یوزرنیم کاربر : @" .. (TD.getUser(msg.sender_id.user_id)).usernames.editable_username .. "\n\n─┅━ مشخصات گروه ━┅─\n\n⌯ نام گروه : *" .. (TD.getChat(msg.chat_id)).title .. "*\n\n⌯ چت ایدی : `" .. msg.chat_id .. "`\n\n⌯ لینک گروه : *" .. res.invite_link.invite_link .. "*\n\n\n─┅━ سقف گروه ━┅─\n\n⌯ تعداد فعال : *" .. sgpsplayer .. "*\n\n⌯ باقی مانده : *" .. pmax - sgpsplayer .. "*\n\n\n#PlayerCharge\n";
						sendBot(Sudoid, msg.id, text, "md");
						sendBot(Config.IDSup, msg.id, text, "md");
						sendBot(msg.chat_id, msg.id, "⌯ پلیر گروه  " .. input2 .. " روز شارژ شد !", "md");
					end;
				end;
			end;
			if ChatTypeSuperGp and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "added") then
				if is_Sudo(msg) or is_FullSudo(msg) then
					if Ramin and (Ramin:match("^charge (%d+)$") or Ramin and Ramin:match("^شارژ (%d+)$")) then
						local time = tonumber((Ramin:match("^charge (%d+)$") or Ramin:match("^شارژ (%d+)$"))) * day;
						local charg = Ramin:match("^charge (%d+)") or Ramin:match("^شارژ (%d+)");
						base:setex(TD_ID .. "ExpireData:" .. msg.chat_id, time - 1, true);
						base:set(TD_ID .. "ExpireDataNum:" .. msg.chat_id, charg);
						base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "chex3");
						base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "chex2");
						base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "chex2");
						base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "chex1");
						local link = base:get(TD_ID .. "Link:" .. msg.chat_id) or "ثبت نشده است.";
						linkgp = okname(link);
						local ti = math.floor(time / day);
						result = TD.getUser(msg.sender_id.user_id);
						if result.usernames.editable_username == "" then
							name = ec_name(result.first_name);
						else
							name = result.usernames.editable_username;
						end;
						local timet = jdate("\n⌯ امروز #x | #Y/#M/#D");
						
						resulgp = TD.getChat(msg.chat_id);
						textgp = "⌯ گروه به مدت " .. ti .. " روز شارژ شد !";
						sendBot(msg.chat_id, msg.id, textgp, "md");
						local keyboard = {};
						keyboard.inline_keyboard = {
							{
								{
									text = "گزارش شارژ گروه ",
									callback_data = "ERROR:" .. msg.chat_id
								}
							}
						};
						result = TD.getUser(msg.sender_id.user_id);
						text = "─┅━ گزارش شارژ گروه ━┅─\n\n⌯ تعداد روز : " .. ti .. " روز\n\n\n⌯ نام گروه  " .. resulgp.title .. "\n\n⌯ شارژ کننده : " .. ec_name(result.first_name) .. "\n\n⌯ زمان  :  <b>" .. timet .. " </b>\n\n\n" .. txt .. "\n";
						SendInlineBot(Sudoid, text, keyboard, "html");
					end;
					if Ramin == "ownerpluslist" or Ramin == "لیست ارشد مالک" and is_Sudo(msg) then
						local list = base:smembers(TD_ID .. "OwnerListPlus:" .. msg.chat_id);
						if #list == 0 then
							sendBot(msg.chat_id, msg.id, "⌯ *لیست ارشد مالک خالی میباشد* ", "md");
						else
							local txt = "لیست ارشد مالک در گروه :\n\n";
							for k, v in pairs(list) do
								local usrname = base:get("UserName:" .. v);
								if usrname then
									username = "@" .. usrname .. " - <code>" .. v .. "</code>";
								else
									Name = base:get(TD_ID .. "UserName:" .. v) or "none";
									username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
								end;
								txt = "" .. txt .. "<b>" .. k .. "-</b>⌯ نام کاربر:" .. username .. "\nایدی کاربر:<code>" .. v .. "</code>\n\n";
							end;
							sendBot(msg.chat_id, msg.id, txt, "html");
						end;
					end;
					if Ramin == "clean ownerlist" or Ramin == "پاکسازی لیست مالکان" then
						base:del(TD_ID .. "OwnerList:" .. msg.chat_id);
						sendBot(msg.chat_id, msg.id, "⌯ *لیست مالکین گروه پاکسازی شد*! ", "md");
					end;
					if Ramin == "clean ownerpluslist" or Ramin == "پاکسازی لیست ارشد مالک" then
						base:del(TD_ID .. "OwnerListPlus:" .. msg.chat_id);
						sendBot(msg.chat_id, msg.id, "⌯ *لیست مالکین ارشد گروه پاکسازی شد*! ", "md");
					end;
				end;
			end;
			if is_Owner(msg) or is_OwnerPlus(msg) then
				if Ramin == "ownerlist" or Ramin == "owner list" or Ramin == "لیست صاحبان گروه" or Ramin == "لیست مالکان" or Ramin == "لیست مالکین" and is_Sudo(msg) then
					local list = base:smembers(TD_ID .. "OwnerList:" .. msg.chat_id);
					if #list == 0 then
						sendBot(msg.chat_id, msg.id, "⌯ *لیست مالکان گروه خالی میباشد* ", "md");
					else
						local txt = "لیست مالکان ربات  :\n\n";
						for k, v in pairs(list) do
							local usrname = base:get("UserName:" .. v);
							if usrname then
								username = "@" .. usrname .. " - <code>" .. v .. "</code>";
							else
								Name = base:get(TD_ID .. "UserName:" .. v) or "none";
								username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
							end;
							txt = "" .. txt .. "<b>" .. k .. "-</b>⌯ نام کاربر:" .. username .. "\nایدی کاربر:<code>" .. v .. "</code>\n\n";
						end;
						sendBot(msg.chat_id, msg.id, txt, "html");
					end;
				end;
				if Ramin and (Ramin:match("^ارشد مالک$") or Ramin:match("^setownerplus$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						SetOwnerPlus(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^ارشد مالک$") or Ramin:match("^setownerplus$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							SetOwnerPlus(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						SetOwnerPlus(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							SetOwnerPlus(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						SetOwnerPlus(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^ارشد مالک (.*)$") or Ramin:match("^setownerplus (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					SetOwnerPlus(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^ارشد مالک @(.*)$") or Ramin:match("^setownerplus @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
					local username = Ramin:match("^ارشد مالک @(.*)$") or Ramin:match("^setownerplus @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						SetOwnerPlus(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^ارشد مالک (%d+)$") or Ramin:match("^setownerplus (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
					dofile("./checkuser.lua");
					SetOwnerPlus(msg, msg.chat_id, Ramin:match("^ارشد مالک (%d+)$") or Ramin:match("^setownerplus (%d+)$"));
				end;
				if Ramin and (Ramin:match("^حذف ارشد مالک$") or Ramin:match("^remownerplus$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						RemOwnerPlus(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^حذف ارشد مالک$") or Ramin:match("^remownerplus$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							RemOwnerPlus(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						RemOwnerPlus(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							RemOwnerPlus(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						RemOwnerPlus(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if Ramin and (Ramin:match("^حذف ارشد مالک @(.*)$") or Ramin:match("^remownerplus @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
					local username = Ramin:match("^حذف ارشد مالک @(.*)$") or Ramin:match("^remownerplus @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						RemOwnerPlus(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^حذف ارشد مالک (%d+)$") or Ramin:match("^remownerplus (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
					dofile("./checkuser.lua");
					RemOwnerPlus(msg, msg.chat_id, Ramin:match("^حذف ارشد مالک (%d+)$") or Ramin:match("^remownerplus (%d+)$"));
				end;
				if Ramin and (Ramin:match("^ارتقا به مالک$") or Ramin:match("^مالک$") or Ramin:match("^تنظیم مالک$") or Ramin:match("^setowner$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						SetOwner(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^ارتقا به مالک$") or Ramin:match("^مالک$") or Ramin:match("^تنظیم مالک$") or Ramin:match("^setowner$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							SetOwner(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						SetOwner(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							SetOwner(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						SetOwner(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if RaminEnti and (Ramin:match("^ارتقا به مالک (.*)$") or Ramin:match("^مالک (.*)$") or Ramin:match("^تنظیم مالک (.*)$") or Ramin:match("^setowner (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 then
					id = msg.content.text.entities[1].type.user_id;
					dofile("./checkuser.lua");
					SetOwner(msg, msg.chat_id, id);
				end;
				if Ramin and (Ramin:match("^ارتقا به مالک @(.*)$") or Ramin:match("^مالک @(.*)$") or Ramin:match("^تنظیم مالک @(.*)$") or Ramin:match("^setowner @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
					local username = Ramin:match("^ارتقا به مالک @(.*)$") or Ramin:match("^مالک @(.*)$") or Ramin:match("^تنظیم مالک @(.*)$") or Ramin:match("^setowner @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						SetOwner(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^ارتقا به مالک (%d+)$") or Ramin:match("^مالک (%d+)$") or Ramin:match("^تنظیم مالک (%d+)$") or Ramin:match("^setowner (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
					dofile("./checkuser.lua");
					SetOwner(msg, msg.chat_id, Ramin:match("^ارتقا به مالک (%d+)$") or Ramin:match("^setowner (%d+)$") or Ramin:match("^مالک (%d+)$") or Ramin:match("^تنظیم مالک (%d+)$"));
				end;
				if Ramin and (Ramin:match("^حذف از مالک$") or Ramin:match("^حذف مالک$") or Ramin:match("^remowner$") or Ramin:match("^demowner$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						RemOwner(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
				if Ramin and (Ramin:match("^حذف از مالک$") or Ramin:match("^حذف مالک$") or Ramin:match("^remowner$") or Ramin:match("^demowner$")) and tonumber(msg.reply_to_message_id) > 0 then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							RemOwner(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						RemOwner(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							RemOwner(msg, msg.chat_id, Ramin.id);
						end;
					else
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
						dofile("./checkuser.lua");
						RemOwner(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				end;
				if Ramin and (Ramin:match("^حذف از مالک @(.*)$") or Ramin:match("^حذف مالک @(.*)$") or Ramin:match("^remowner @(.*)$") or Ramin:match("^demowner @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 then
					local username = Ramin:match("^حذف از مالک @(.*)$") or Ramin:match("^remowner @(.*)$") or Ramin:match("^حذف مالک @(.*)$") or Ramin:match("^demowner @(.*)$");
					result = TD.searchPublicChat(username);
					if result.id then
						dofile("./checkuser.lua");
						RemOwner(msg, msg.chat_id, result.id);
					else
						sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
					end;
				end;
				if Ramin and (Ramin:match("^حذف از مالک (%d+)$") or Ramin:match("^حذف مالک (%d+)$") or Ramin:match("^remowner (%d+)$") or Ramin:match("^demowner (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 then
					dofile("./checkuser.lua");
					RemOwner(msg, msg.chat_id, Ramin:match("^حذف از مالک (%d+)$") or Ramin:match("^حذف مالک (%d+)$") or Ramin:match("^remowner (%d+)$") or Ramin:match("^demowner (%d+)$"));
				end;
			end;
		end;
		if is_Mod(msg) then
			if Ramin and (Ramin:match("^getpro (%d+)$") or Ramin and Ramin:match("^پروفایل (%d+)$")) and msg.reply_to_message_id == 0 then
				local GetProfile = Ramin:match("^getpro (%d+)$") or Ramin:match("^پروفایل (%d+)$");
				if GetProfile:match("^0$") then
					TD.sendText(msg.chat_id, msg.id, "⌯ برای دریافت عکس ها خود عددی بزرگ تر از صفر وارد کنید !", "md");
				else
					local data = TD.getUserProfilePhotos(msg.sender_id.user_id, tonumber(GetProfile - 1), 200);
					if data.photos and data.photos[1] then
						TD.sendPhoto(msg.chat_id, msg.id, data.photos[1].sizes[1].photo.remote.id, "⌯ تعداد پروفایل : [ " .. GetProfile .. "/" .. data.total_count .. " ]\n⌯ سایز عکس : [ " .. data.photos[1].sizes[1].photo.expected_size .. " پیکسل ]", "html");
					else
						TD.sendText(msg.chat_id, msg.id, "⌯ عکس های موجود شما کمتر از [ " .. GetProfile .. " ] عکس است ▸", "md");
					end;
				end;
			end;
			if Ramin == "وضعیت من" or Ramin == "activeme" and is_JoinChannel(msg) then
				local datebase = {
					"درحال شادی",
					"ناراحت از زندگی",
					"خیلی مصمم برای انجام کار",
					"اماده انجام وظیفه",
					"احتمالا یخورده خوابت میاد",
					"خسته مثل دشمن😂",
					"اماده خوردن چن تا ادم ازگشنگی😂😝😝"
				};
				local num1 = math.random(1, 100);
				local num2 = math.random(1, 100);
				local num3 = math.random(1, 100);
				local num4 = math.random(1, 100);
				local num5 = math.random(1, 100);
				local num6 = math.random(1, 100);
				local num7 = math.random(1, 100);
				local num8 = math.random(1, 100);
				local text = "وضعیت شما به صورت زیر است\n بی حوصلگی : " .. num1 .. "%\nخوشحالی : " .. num2 .. "%\nافسردگی : " .. num3 .. "%\nامادگی جسمانی : " .. num4 .. "%\nدرصد سلامتی : " .. num5 .. "%\nتنبلی : " .. num6 .. "%\nبی خیالی : " .. num6 .. "%\nوضعیت روحی شما : " .. datebase[math.random((#datebase))];
				sendBot(msg.chat_id, msg.id, text, "html");
			end;
			if Ramin and (Ramin:match("^setasle (.*)$") or Ramin:match("^تنظیم اصل (.*)$") or Ramin:match("^تایید اصل (.*)$") or Ramin:match("^ثبت اصل (.*)$")) and tonumber(msg.reply_to_message_id) ~= 0 then
				local rank = Ramin:match("^setasle (.*)$") or Ramin:match("^تنظیم اصل (.*)$") or Ramin:match("^تایید اصل (.*)$") or Ramin:match("^ثبت اصل (.*)$");
				ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = ALPHA.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست!", "md");
						return false;
					end;
					if tonumber(user) == Config.Sudoid then
						sendBot(msg.chat_id, msg.id, "⌯ من به بابای خودم نمیتونم اصل بزارم !", "md");
						return false;
					end;
					base:set(TD_ID .. "asleuser:" .. user, rank);
					base:sadd("asleuser:", user);
					local alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, "⌯ مشخصات کاربر <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> تنظیم شد ! ", "html");
				end;
			end;
			if Ramin and Ramin:match("^اکو (.*)$") and is_JoinChannel(msg) then
				local txt = Ramin:match("^اکو (.*)");
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
				sendBot(msg.chat_id, msg.reply_to_message_id, txt, "md");
			end;
			if Ramin == "join off" or Ramin == "جوین غیرفعال" or Ramin == "قفل ورود" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "Lock:Join") then
					sendBot(cht, msg.id, " ⌯ قفل ورود فعال بود !  ", "html");
				else
					typegpadd("Gp:", "Lock:Join");
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " جوین غیرفعال را ارسال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(cht, msg.id, " ⌯ قفل ورود فعال شد .", "html");
				end;
			end;
			if Ramin == "join on" or Ramin == "جوین فعال" or Ramin == "بازکردن ورود" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "Lock:Join") then
					typegprem("Gp:", "Lock:Join");
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " جوین فعال را ارسال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(cht, msg.id, " ⌯ قفل ورود غیرفعال شد . ", "html");
				else
					sendBot(cht, msg.id, " ⌯ قفل  ورود  غیرفعال بود ! ", "html");
				end;
			end;
			if Ramin == "idphoto on" or Ramin == "ایدی با عکس فعال" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "idphoto") then
					sendBot(cht, msg.id, " ⌯ دستور ایدی با عکس فعال بود ! ", "html");
				else
					typegpadd("Gp:", "idphoto");
					sendBot(cht, msg.id, " ⌯ دستور ایدی با عکس فعال شد ! ", "html");
				end;
			end;
			if Ramin == "idphoto off" or Ramin == "ایدی با عکس غیرفعال" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "idphoto") then
					typegprem("Gp:", "idphoto");
					sendBot(cht, msg.id, " ⌯ دستور ایدی با عکس غیرفعال شد ! ", "html");
				else
					sendBot(cht, msg.id, "⌯ دستور ایدی با عکس غیرفعال می باشد ! ", "html");
				end;
			end;
			if Ramin == "tgservice on" or Ramin == "lock service" or Ramin == "قفل سرویس" or Ramin == "قفل سرویس تلگرام" or Ramin == "قفل خدمات" and is_JoinChannel(msg) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "Lock:TGservice") then
					sendBot(cht, msg.id, " ⌯ قفل سرویس تلگرام فعال می باشد. ", "html");
				else
					typegpadd("Gp:", "Lock:TGservice");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGservice");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:DePhoto");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGChPhoto");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGDel");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGLink");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGPin");
					base:sadd(TD_ID .. "Gp:" .. bdcht, "Lock:TGAdd");
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " قفل سرویس تلگرام را ارسال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(cht, msg.id, " ⌯ قفل سرویس تلگرام فعال شد . ", "html");
				end;
			end;
			if Ramin == "tgservice off" or Ramin == "unlock service" or Ramin == "بازکردن سرویس" or Ramin == "بازکردن سرویس تلگرام" or Ramin == "بازکردن خدمات " and is_JoinChannel(msg) then
				if base:sismember(TD_ID .. "Gp:" .. bdcht, "Lock:TGservice") then
					typegprem("Gp:", "Lock:TGservice");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGservice");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:DePhoto");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGChPhoto");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGDel");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGLink");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGPin");
					base:srem(TD_ID .. "Gp:" .. bdcht, "Lock:TGAdd");
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. " در گروه " .. gp .. " بازکردن سرویس تلگرام را ارسال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(cht, msg.id, " ⌯ قفل سرویس تلگرام غیرفعال شد . ", "html");
				else
					sendBot(cht, msg.id, " ⌯ قفل سرویس تلگرام غیرفعال بود .  ", "html");
				end;
			end;
			if Ramin == "expire" or Ramin == "اعتبار" or Ramin == "اعتبار گروه" and is_JoinChannel(msg) then
				local ex = base:ttl(TD_ID .. "ExpireData:" .. msg.chat_id);
				if ex == 0 or ex == (-2) then
					Time_S = "[ بدون اعتبار ]";
				elseif ex == (-1) then
					Time_S = "گروه به صورت نامحدود شارژ میباشد";
				else
					local Time_ = getTimeUptime(ex);
					-- local txt = "⌯ تاریخ اتمام شارژ :\n" .. jdatee(" `#Y/#M/#D | #x`") .. "";
					local tarikh = "⌯ تاریخ امروز :\n" .. jdate("`#Y/#M/#D  | #x` ") .. "";
					local check_time = base:ttl(TD_ID .. "SvPorn" .. msg.chat_id);
					year = math.floor(check_time / 31536000);
					byear = check_time % 31536000;
					month = math.floor(byear / 2592000);
					bmonth = byear % 2592000;
					day = math.floor(bmonth / 86400);
					bday = bmonth % 86400;
					hours = math.floor(bday / 3600);
					bhours = bday % 3600;
					min = math.floor(bhours / 60);
					sec = math.floor(bhours % 60);
					if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
						remained_expire = "⌯ قفل پورن بدون اعتبار می باشد!";
					elseif tonumber(check_time) > 1 and check_time < 60 then
						remained_expire = "⌯ قفل پورن به مدت " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 60 and check_time < 3600 then
						remained_expire = "⌯ قفل پورن به مدت " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
						remained_expire = "⌯ قفل پورن به مدت " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
						remained_expire = "⌯ قفل پورن به مدت " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
						remained_expire = "⌯ قفل پورن به مدت " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					elseif tonumber(check_time) > 31536000 then
						remained_expire = "⌯ قفل پورن به مدت " .. year .. " سال " .. month .. " ماه " .. day .. " روز و " .. hours .. " ساعت و " .. min .. " دقیقه و " .. sec .. " ثانیه شارژ میباشد";
					end;
					Time_S = "📆 اعتبار ربات در این گروہ : \n⌯ [ " .. Time_ .. " ] \n" .. tarikh .. "\n\n─┅━━━━━━┅─\n⌯ تاریخ اتمام پورن :\n" .. remained_expire .. "";
				end; 
				sendBot(msg.chat_id, msg.id, Time_S, "md");
			end;
			if Ramin and (Ramin1:match("^lockgp (%d+) (%d+) (%d+)") or Ramin1:match("^قفل گروه (%d+) (%d+) (%d+)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local CmdEn = {
					string.match(Ramin1, "^(lockgp) (%d+) (%d+) (%d+)$")
				};
				local CmdFa = {
					string.match(Ramin1, "^(قفل گروه) (%d+) (%d+) (%d+)$")
				};
				local Matches1 = CmdEn[2] or CmdFa[2];
				local Matches2 = CmdEn[3] or CmdFa[3];
				local Matches3 = CmdEn[4] or CmdFa[4];
				local hour = string.gsub(Matches1, "h", "");
				local num1 = tonumber(hour) * 3600;
				local minutes = string.gsub(Matches2, "m", "");
				local num2 = tonumber(minutes) * 60;
				local second = string.gsub(Matches3, "s", "");
				local num3 = tonumber(second);
				local timelock = tonumber(num1 + num2 + num3);
				H = "" .. os.date("%H") .. "";
				M = "" .. os.date("%M") .. "";
				S = "" .. os.date("%S") .. "";
				hor = Matches1 + H;
				minr = Matches2 + M;
				Se = Matches3 + S;
				base:setex(TD_ID .. "MuteAlllimit:" .. msg.chat_id, timelock, true);
				sendBot(msg.chat_id, msg.id, " ⌯ قفل گروہ فعال شد به مدت:\n\n⏰ : " .. Matches1 .. " ساعت " .. Matches2 .. " دقیقه " .. Matches3 .. " ثانیه\n\n⌯ الان ساعت " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S") .. "\n⌯ گروہ شما در ساعت  : " .. hor .. ":" .. minr .. ":" .. Se .. " باز خواهد شد ! ", "html");
			end;
			if Ramin and (Ramin:match("^lockmute (%d+)[hms]") or Ramin:match("^قفل گروه (%d+)[س]")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
				local num = Ramin:match("^lockmute (%d+)[hms]") or Ramin:match("^قفل گروه (%d+)[سدث]");
				if Ramin and (Ramin:match("(%d+)h") or Ramin:match("(%d+)س")) then
					time_match = Ramin:match("(%d+)h") or Ramin:match("(%d+)س");
					time = time_match * 3600;
					th = time / 3600;
					t = "ساعت";
				end;
				if Ramin and (Ramin:match("(%d+)m") or Ramin:match("(%d+)د")) then
					time_match = Ramin:match("(%d+)m") or Ramin:match("(%d+)د");
					time = time_match * 60;
					th = time / 60;
					t = "دقیقه";
				end;
				if Ramin and (Ramin:match("(%d+)s") or Ramin:match("(%d+)ث")) then
					time_match = Ramin:match("(%d+)s") or Ramin:match("(%d+)ث");
					time = time_match;
					th = time * 1;
					t = "ثانیه";
				end;
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAlltime");
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAlltime2");
				base:set(TD_ID .. "MuteAlltime:" .. msg.chat_id, time);
				base:set(TD_ID .. "MuteAlltime2:" .. msg.chat_id, time - 30);
				local timecgms = tonumber(base:get(TD_ID .. "MuteAlltime:" .. chat_id)) or 20;
				local hash = TD_ID .. "MuteAlllimit:" .. msg.chat_id;
				base:setex(hash, tonumber(time), true);
				sendBot(msg.chat_id, msg.id, "⌯ قفل گروہ فعال شد به مدت:\n⏰ : *" .. th .. "* " .. t .. " ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^ایدی$") or Ramin:match("^آیدی$") or Ramin:match("^id$") or Ramin:match("^اطلاعات$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				DisplayID(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^ایدی$") or Ramin:match("^آیدی$")  or Ramin:match("^id$") or Ramin:match("^اطلاعات$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			DisplayID(msg, msg.chat_id, msg.sender_id.user_id);
		end;
		if Ramin and (Ramin:match("^ایدی$") or Ramin:match("^آیدی$") or Ramin:match("^id$") or Ramin:match("^اطلاعات$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					DisplayID(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				DisplayID(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					DisplayID(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				DisplayID(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^ایدی (.*)$") or Ramin:match("^آیدی (.*)$") or Ramin:match("^id (.*)$") or Ramin:match("^اطلاعات (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			DisplayID(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^ایدی @(.*)$") or Ramin:match("^آیدی @(.*)$") or Ramin:match("^id @(.*)$") or Ramin:match("^اطلاعات @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local username = Ramin:match("^ایدی @(.*)$") or Ramin:match("^آیدی @(.*)$") or Ramin:match("^اطلاعات @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				DisplayID(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯ کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^ایدی (%d+)$") or Ramin:match("^آیدی (%d+)$") or Ramin:match("^id (%d+)$") or Ramin:match("^اطلاعات (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			id = Ramin:match("^ایدی (%d+)$") or Ramin:match("^آیدی (%d+)$") or Ramin:match("^اطلاعات (%d+)$");
			DisplayID(msg, msg.chat_id, id);
		end;
		if Ramin == "lock media" or Ramin == "قفل رسانه" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a> ";
			local gp = (TD.getChat(msg.chat_id)).title;
			text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر " .. namee .. " دستور قفل رسانه را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
			reportowner(text);
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Stickers");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Video");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Gif");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Audio");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Voice");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Sticker");
			base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Photo");
			sendBot(msg.chat_id, msg.id, " ⌯  قفل رسانه با موفقیت فعال شد . ", "html");
		end;
		if Ramin == "unlockmedia" or Ramin == "بازکردن رسانه" or Ramin == "باز کردن رسانه" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a> ";
			local gp = (TD.getChat(msg.chat_id)).title;
			text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر " .. namee .. " دستور بازکردن رسانه را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
			reportowner(text);
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Stickers");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Video");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Gif");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Audio");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Voice");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Sticker");
			base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Del:Photo");
			sendBot(msg.chat_id, msg.id, " ⌯ قفل رسانه با موفقیت غیرفعال شد . ", "html");
		end;
		if Ramin == "muteall" or Ramin == "قفل گروه" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "automuteall") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل خودکار فعال است ، برای قفل کردن دستی ،ابتدا دستور قفل خودکار غیرفعال را ارسال کنید . ", "html");
			else
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "Mute_All");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯  ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر " .. namee .. " دستور قفل گروه را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				local result = (TD.getChat(msg.chat_id)).permissions;
				base:hset(TD_ID .. "Permissions" .. msg.chat_id, "can_send_media_messages", result.can_send_media_messages);
				base:hset(TD_ID .. "Permissions" .. msg.chat_id, "can_send_polls", result.can_send_polls);
				base:hset(TD_ID .. "Permissions" .. msg.chat_id, "can_send_other_messages", result.can_send_other_messages);
				base:hset(TD_ID .. "Permissions" .. msg.chat_id, "can_add_web_page_previews", result.can_add_web_page_previews);
				TD.setChatPermissions(msg.chat_id, false, false, false, false, false, result.can_change_info, result.can_invite_users, result.can_pin_messages);
				sendBot(msg.chat_id, msg.id, " ⌯ گروہ با موفقیت قفل شد . ", "html");
			end;
		end;
		if Ramin == "unmuteall" or Ramin == "آزاد گروه" or Ramin == "بازکردن گروه" or Ramin == "باز کردن گروه" or Ramin == "ازاد گروه" and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "autoon") then
					sendBot(msg.chat_id, msg.id, "⚠️ خطای دستوری\n\n⌯ *  قفل خودکار گروه فعال می باشد*\n*برای بازکردن گروہ ابتدا دستور*\n* قفل خودکار غیرفعال*\nرا ارسال کردہ وبعد دستور #بازکردن را بفرستید.", "md");
				end;
				if not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "Mute_All") then
					sendBot(msg.chat_id, msg.id, " ⌯ قفل گروه غیرفعال می باشد . ", "html");
				else
					base:del(TD_ID .. "MuteAlllimit:" .. msg.chat_id);
					base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "Mute_All");
					base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAlltime");
					base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAlltime2");
					local mutes = base:smembers(TD_ID .. "Mutes:" .. msg.chat_id);
					for k, v in pairs(mutes) do
						base:srem(TD_ID .. "Mutes:" .. msg.chat_id, v);
						UnRes(msg.chat_id, v);
					end;
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. msg.sender_id.user_id .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر " .. namee .. " دستور بازکردن گروه را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					local result = (TD.getChat(msg.chat_id)).permissions;
					media = base:hget(TD_ID .. "Permissions" .. msg.chat_id, "can_send_media_messages") and true or false;
					poll = base:hget(TD_ID .. "Permissions" .. msg.chat_id, "can_send_polls") and true or false;
					other = base:hget(TD_ID .. "Permissions" .. msg.chat_id, "can_send_other_messages") and true or false;
					previews = base:hget(TD_ID .. "Permissions" .. msg.chat_id, "can_add_web_page_previews") and true or false;
					TD.setChatPermissions(msg.chat_id, true, media, poll, other, previews, result.can_change_info, result.can_invite_users, result.can_pin_messages);
					sendBot(msg.chat_id, msg.id, " ⌯ گروہ با موفقیت باز شد . ", "html");
				end;
			else
				sendBot(msg.chat_id, msg.id, "⌯ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*. ", "md");
			end;
		end;
		if (Ramin == "lockautomedia off" or Ramin == "قفل خودکار رسانه غیرفعال") and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "automedia") then
				base:del(TD_ID .. "atolctmedia1" .. msg.chat_id);
				base:del(TD_ID .. "atolctmedia2" .. msg.chat_id);
				base:del(TD_ID .. "lc_ato:" .. msg.chat_id);
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "automedia");
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار رسانه گروه غیرفعال شد . ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار رسانه گروه غیرفعال می باشد ! ", "html");
			end;
		end;
		if (Ramin == "lockauto on" or Ramin == "قفل خودکار فعال") and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "autoon") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل خودکار فعال شد!\n\n⌯ زمان استارت : " .. base:get((TD_ID .. "atolct1" .. msg.chat_id)) .. " الی " .. base:get((TD_ID .. "atolct2" .. msg.chat_id)) .. "  ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ زمان قفل خودکار  تنظیم نشده است !\n\n⌯ برای تنظیم کردن زمان از دستور زیر استفاده کنید :\n ⌯ قفل خودکار [زمان استارت-زمان اتمام] ", "html");
			end;
		end;
		if Ramin == "infogid" or Ramin == "اطلاعات گروه" then
			local result = TD.getSupergroupFullInfo(msg.chat_id);
			text = "\n✦ شناسه گروه : `" .. msg.chat_id .. "`\n\n\n✦ نام گروه : *" .. (TD.getChat(msg.chat_id)).title .. "*\n\n\n✦ لینک گروه : *" .. result.invite_link.invite_link .. "*\n\n\n✦ زمان چت آهسته : *" .. result.slow_mode_delay .. " ثانیه*\n\nا┅┅──┄┄═✺═┄┄──┅┅ \n\n✦ تعداد اعضا : *" .. result.member_count .. " کاربر*\n\n✦ تعداد ادمین ها : *" .. result.administrator_count .. " ادمین*\n\n✦ افراد مسدود شده : *" .. result.banned_count .. " کاربر*\n\n✦ افراد محدود شده : *" .. result.restricted_count .. " کاربر*\n\n\n";
			sendBot(msg.chat_id, msg.id, text, "md");
		end;
		local MentionUser = function(user_id)
			local result = TD.getUser(user_id);
			if result and result.first_name then
				return "<a href=\"tg://user?id=" .. user_id .. "\">" .. string.gsub(result.first_name, "[<>]", "") .. "</a>";
			else
				return "<a href=\"tg://user?id=" .. user_id .. "\">" .. user_id .. "</a>";
			end;
		end;
		local function GroupStatsAdmin(chat_id, msg_id, counter)
			base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, Bot_iD);
			local msgs, msgsday, adds, addsday = {}, {}, {}, {};
			local function getNum(data, rank, status)
				if data == "msgs" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
								local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUser) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgs, #msgs);
									base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgs" then
						base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
					end;
				elseif data == "msgsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_idsd:" .. chat_id)) do
								local getUserday = base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserday) == tonumber(msgsday[(#msgsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUserday) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgsday, #msgsday);
									base:srem(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgsday" then
						base:del(TD_ID .. "_sender_id.user_idsd:" .. chat_id);
					end;
				elseif data == "adds" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUser_ = base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser_) == tonumber(adds[(#adds)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUser_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(adds, #adds);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				elseif data == "addsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUserDay_ = base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserDay_) == tonumber(addsday[(#addsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUserDay_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(addsday, #addsday);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				end;
			end;
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
						base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
						base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
						base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
						local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
						if 0 < tonumber(getUser) and getUser then
							table.insert(msgs, tonumber(getUser));
						end;
						if 0 < tonumber(getUserday) and getUserday then
							table.insert(msgsday, tonumber(getUserday));
						end;
						if 0 < tonumber(getUser_) and getUser_ then
							table.insert(adds, tonumber(getUser_));
						end;
						if 0 < tonumber(getUserDay_) and getUserDay_ then
							table.insert(adds, tonumber(getUserDay_));
						end;
					end;
				end;
			end;
			table.sort(msgs);
			table.sort(msgsday);
			table.sort(adds);
			table.sort(addsday);
			if counter then
				local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
				if members < tonumber(counter) then
					_c = members;
				else
					_c = tonumber(counter);
				end;
				_resultTEXT = "◄ فعالیت های امروز گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n";
				for i = 1, _c do
					_resultTEXT = _resultTEXT;
					getNum("msgs", i);
				end;
				TD.sendText(chat_id, msg_id, _resultTEXT, "html");
			else
				if #msgs >= 3 then
					_resultTEXT = "┈┅━┃آمار کل پیام┃━┅┈\n\n";
					getNum("msgs", 1);
					getNum("msgs", 2);
					getNum("msgs", 3, "msgs");
				else
					_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل پیام┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #msgsday >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل امروز┃━┅┈\n\n";
					getNum("msgsday", 1);
					getNum("msgsday", 2);
					getNum("msgsday", 3, "msgsday");
				else
					_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل امروز┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #adds >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n";
					getNum("adds", 1);
					getNum("adds", 2);
					getNum("adds", 3, "adds");
				else
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #addsday >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n";
					getNum("addsday", 1);
					getNum("addsday", 2);
					getNum("addsday", 3, "addsday");
				else
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				Userban = base:get(TD_ID .. "All:Userban:" .. chat_id) or 0;
				Useraddban = base:get(TD_ID .. "All:Useraddban:" .. chat_id) or 0;
				Userdelban = base:get(TD_ID .. "All:Userdelban:" .. chat_id) or 0;
				Usernewadd = base:get(TD_ID .. "All:Usernewadd:" .. chat_id) or 0;
				Userleft = base:get(TD_ID .. "All:Userleft:" .. chat_id) or 0;
				UserMute = base:get(TD_ID .. "All:UserMute:" .. chat_id) or 0;
				UserDelMute = base:get(TD_ID .. "All:UserDelMute:" .. chat_id) or 0;
				JoinedGroup = base:get(TD_ID .. "All:Usernewjoin:" .. chat_id) or 0;
				Text = base:get(TD_ID .. "All:Text:" .. chat_id) or 0;
				Document = base:get(TD_ID .. "All:Document:" .. chat_id) or 0;
				Video = base:get(TD_ID .. "All:Video:" .. chat_id) or 0;
				Photo = base:get(TD_ID .. "All:Photo:" .. chat_id) or 0;
				Voice = base:get(TD_ID .. "All:Voice:" .. chat_id) or 0;
				Audio = base:get(TD_ID .. "All:Audio:" .. chat_id) or 0;
				Animation = base:get(TD_ID .. "All:Animation:" .. chat_id) or 0;
				Stricker = base:get(TD_ID .. "All:Stricker:" .. chat_id) or 0;
				Forwarded = base:get(TD_ID .. "All:Forward:" .. chat_id) or 0;
				VideoNote = base:get(TD_ID .. "All:VideoNote:" .. chat_id) or 0;
				local result = TD.getSupergroupFullInfo(msg.chat_id);
				local url, res = https.request("https://api.keybit.ir/time/");
				if res ~= 200 then
				end;
				local jdat = JSON.decode(url);
				TD.sendText(msg.chat_id, msg.id, "◄ فعالیت های امروز ادمین ها تا این لحظه :\n\n⌯  تاریخ :  " .. jdat.date.full.official.usual.fa .. " ، " .. jdat.date.weekday.name .. "\n⌯  ساعت : " .. jdat.time24.full.fa .. "" .. jdat.time12.shift.full .. "\n" .. _resultTEXT .. "\n", "html", false, false, false, false);
			end;
		end;
		local function GroupStats(chat_id, msg_id, counter)
			base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, Bot_iD);
			local msgs, msgsday, adds, addsday = {}, {}, {}, {};
			local function getNum(data, rank, status)
				if data == "msgs" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
								local getUser = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUser) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgs, #msgs);
									base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgs" then
						base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
					end;
				elseif data == "msgsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_idsd:" .. chat_id)) do
								local getUserday = base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserday) == tonumber(msgsday[(#msgsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUserday) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgsday, #msgsday);
									base:srem(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgsday" then
						base:del(TD_ID .. "_sender_id.user_idsd:" .. chat_id);
					end;
				elseif data == "adds" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUser_ = base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser_) == tonumber(adds[(#adds)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUser_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(adds, #adds);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				elseif data == "addsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUserDay_ = base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserDay_) == tonumber(addsday[(#addsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUserDay_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(addsday, #addsday);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				end;
			end;
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
						base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
						base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
						base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
						local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0;
						if 0 < tonumber(getUser) and getUser then
							table.insert(msgs, tonumber(getUser));
						end;
						if 0 < tonumber(getUserday) and getUserday then
							table.insert(msgsday, tonumber(getUserday));
						end;
						if 0 < tonumber(getUser_) and getUser_ then
							table.insert(adds, tonumber(getUser_));
						end;
						if 0 < tonumber(getUserDay_) and getUserDay_ then
							table.insert(adds, tonumber(getUserDay_));
						end;
					end;
				end;
			end;
			table.sort(msgs);
			table.sort(msgsday);
			table.sort(adds);
			table.sort(addsday);
			if counter then
				local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
				if members < tonumber(counter) then
					_c = members;
				else
					_c = tonumber(counter);
				end;
				_resultTEXT = "◄ فعالیت های امروز گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n";
				for i = 1, _c do
					_resultTEXT = _resultTEXT;
					getNum("msgs", i);
				end;
				TD.sendText(chat_id, msg_id, _resultTEXT, "html");
			else
				if #msgs >= 3 then
					_resultTEXT = "┈┅━┃آمار کل پیام┃━┅┈\n\n";
					getNum("msgs", 1);
					getNum("msgs", 2);
					getNum("msgs", 3, "msgs");
				else
					_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل پیام┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #msgsday >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل امروز┃━┅┈\n\n";
					getNum("msgsday", 1);
					getNum("msgsday", 2);
					getNum("msgsday", 3, "msgsday");
				else
					_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل امروز┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #adds >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n";
					getNum("adds", 1);
					getNum("adds", 2);
					getNum("adds", 3, "adds");
				else
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				if #addsday >= 3 then
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n";
					getNum("addsday", 1);
					getNum("addsday", 2);
					getNum("addsday", 3, "addsday");
				else
					_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
				end;
				Userban = base:get(TD_ID .. "All:Userban:" .. chat_id) or 0;
				Useraddban = base:get(TD_ID .. "All:Useraddban:" .. chat_id) or 0;
				Userdelban = base:get(TD_ID .. "All:Userdelban:" .. chat_id) or 0;
				Usernewadd = base:get(TD_ID .. "All:Usernewadd:" .. chat_id) or 0;
				Userleft = base:get(TD_ID .. "All:Userleft:" .. chat_id) or 0;
				UserMute = base:get(TD_ID .. "All:UserMute:" .. chat_id) or 0;
				UserDelMute = base:get(TD_ID .. "All:UserDelMute:" .. chat_id) or 0;
				JoinedGroup = base:get(TD_ID .. "All:Usernewjoin:" .. chat_id) or 0;
				Text = base:get(TD_ID .. "All:Text:" .. chat_id) or 0;
				Document = base:get(TD_ID .. "All:Document:" .. chat_id) or 0;
				Video = base:get(TD_ID .. "All:Video:" .. chat_id) or 0;
				Photo = base:get(TD_ID .. "All:Photo:" .. chat_id) or 0;
				Voice = base:get(TD_ID .. "All:Voice:" .. chat_id) or 0;
				Audio = base:get(TD_ID .. "All:Audio:" .. chat_id) or 0;
				Animation = base:get(TD_ID .. "All:Animation:" .. chat_id) or 0;
				Stricker = base:get(TD_ID .. "All:Stricker:" .. chat_id) or 0;
				Forwarded = base:get(TD_ID .. "All:Forward:" .. chat_id) or 0;
				VideoNote = base:get(TD_ID .. "All:VideoNote:" .. chat_id) or 0;
				local result = TD.getSupergroupFullInfo(msg.chat_id);
				local url, res = https.request("https://api.keybit.ir/time/");
				if res ~= 200 then
				end;
				local jdat = JSON.decode(url);
				TD.sendText(msg.chat_id, msg.id, "◄ فعالیت های امروز اعضا تا این لحظه :\n\n⌯  تاریخ :  " .. jdat.date.full.official.usual.fa .. " ، " .. jdat.date.weekday.name .. "\n⌯  ساعت : " .. jdat.time24.full.fa .. "" .. jdat.time12.shift.full .. "\n" .. _resultTEXT .. "\n┈┅━┃آمار کل ورود خروج┃━┅┈\n\n✮ تعداد اعضا :" .. result.member_count .. "\n✮ اعضای جدید : " .. JoinedGroup .. "\n✮ تعداد ادمین ها : " .. result.administrator_count .. "\n✮ اعضای اخراج شده : " .. result.banned_count .. "\n✮ اعضای سکوت شده : " .. result.restricted_count .. "\n\n┈┅━┃آمار کل گروه┃━┅┈\n\n✦ کل پیام ها : " .. (base:get(TD_ID .. "All:Message:" .. chat_id) or 0) .. "\n✦ متن ها : " .. Text .. "\n✦ گیف ها : " .. Animation .. "\n✦ فیلم ها : " .. Video .. "\n✦ عکس ها : " .. Photo .. "\n✦ صداها : " .. Voice .. "\n✦ استیکر ها : " .. Stricker .. "\n✦ فایل ها : " .. Document .. "\n✦ فیلم سلفی : " .. VideoNote .. "\n✦ فورواردی ها : " .. Forwarded .. "\n", "html", false, false, false, false);
			end;
		end;
		local function GroupStatsPV(chat_id, msg_id, counter)
			base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, Bot_iD);
			local msgs, msgsday, adds, addsday = {}, {}, {}, {};
			local function getNum(data, rank, status)
				if data == "msgs" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
								local getUser = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUser) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgs, #msgs);
									base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgs" then
						base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
					end;
				elseif data == "msgsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_idsd:" .. chat_id)) do
								local getUserday = base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserday) == tonumber(msgsday[(#msgsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. tonumber(getUserday) .. " پیام | " .. MentionUser(i) .. ")\n";
									table.remove(msgsday, #msgsday);
									base:srem(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgsday" then
						base:del(TD_ID .. "_sender_id.user_idsd:" .. chat_id);
					end;
				elseif data == "adds" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUser_ = base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUser_) == tonumber(adds[(#adds)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUser_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(adds, #adds);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				elseif data == "addsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids_:" .. chat_id)) do
								local getUserDay_ = base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0;
								if tonumber(getUserDay_) == tonumber(addsday[(#addsday)]) then
									_resultTEXT = _resultTEXT .. "- نفر " .. string.gsub(rank, "[123]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉"
									}) .. " :\n (" .. getUserDay_ .. " اد | " .. MentionUser(i) .. ")\n";
									table.remove(addsday, #addsday);
									base:srem(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "addsday" then
						base:del(TD_ID .. "sender_id.user_ids_:" .. chat_id);
					end;
				end;
			end;
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
						base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
						base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
						base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
						local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0;
						if 0 < tonumber(getUser) and getUser then
							table.insert(msgs, tonumber(getUser));
						end;
						if 0 < tonumber(getUserday) and getUserday then
							table.insert(msgsday, tonumber(getUserday));
						end;
						if 0 < tonumber(getUser_) and getUser_ then
							table.insert(adds, tonumber(getUser_));
						end;
						if 0 < tonumber(getUserDay_) and getUserDay_ then
							table.insert(adds, tonumber(getUserDay_));
						end;
					end;
				end;
			end;
			table.sort(msgs);
			table.sort(msgsday);
			table.sort(adds);
			table.sort(addsday);
			if #msgs >= 3 then
				_resultTEXT = "┈┅━┃آمار کل پیام┃━┅┈\n\n";
				getNum("msgs", 1);
				getNum("msgs", 2);
				getNum("msgs", 3, "msgs");
			else
				_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل پیام┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
			end;
			if #msgsday >= 3 then
				_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل امروز┃━┅┈\n\n";
				getNum("msgsday", 1);
				getNum("msgsday", 2);
				getNum("msgsday", 3, "msgsday");
			else
				_resultTEXT = _resultTEXT .. "┈┅━┃آمار کل امروز┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
			end;
			if #adds >= 3 then
				_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n";
				getNum("adds", 1);
				getNum("adds", 2);
				getNum("adds", 3, "adds");
			else
				_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار کل اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
			end;
			if #addsday >= 3 then
				_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n";
				getNum("addsday", 1);
				getNum("addsday", 2);
				getNum("addsday", 3, "addsday");
			else
				_resultTEXT = _resultTEXT .. "\n┈┅━┃آمار امروز اد┃━┅┈\n\n- آمار دقیقی دردسترس نیست !\n";
			end;
			Userban = base:get(TD_ID .. "All:Userban:" .. chat_id) or 0;
			Useraddban = base:get(TD_ID .. "All:Useraddban:" .. chat_id) or 0;
			Userdelban = base:get(TD_ID .. "All:Userdelban:" .. chat_id) or 0;
			Usernewadd = base:get(TD_ID .. "All:Usernewadd:" .. chat_id) or 0;
			Userleft = base:get(TD_ID .. "All:Userleft:" .. chat_id) or 0;
			UserMute = base:get(TD_ID .. "All:UserMute:" .. chat_id) or 0;
			UserDelMute = base:get(TD_ID .. "All:UserDelMute:" .. chat_id) or 0;
			JoinedGroup = base:get(TD_ID .. "All:Usernewjoin:" .. chat_id) or 0;
			Text = base:get(TD_ID .. "All:Text:" .. chat_id) or 0;
			Document = base:get(TD_ID .. "All:Document:" .. chat_id) or 0;
			Video = base:get(TD_ID .. "All:Video:" .. chat_id) or 0;
			Photo = base:get(TD_ID .. "All:Photo:" .. chat_id) or 0;
			Voice = base:get(TD_ID .. "All:Voice:" .. chat_id) or 0;
			Audio = base:get(TD_ID .. "All:Audio:" .. chat_id) or 0;
			Animation = base:get(TD_ID .. "All:Animation:" .. chat_id) or 0;
			Stricker = base:get(TD_ID .. "All:Stricker:" .. chat_id) or 0;
			Forwarded = base:get(TD_ID .. "All:Forward:" .. chat_id) or 0;
			VideoNote = base:get(TD_ID .. "All:VideoNote:" .. chat_id) or 0;
			local result = TD.getSupergroupFullInfo(msg.chat_id);
			local url, res = https.request("https://api.keybit.ir/time/");
			if res ~= 200 then
			end;
			local jdat = JSON.decode(url);
			local result = TD.getSupergroupFullInfo(msg.chat_id);
			local url, res = https.request("https://api.keybit.ir/time/");
			if res ~= 200 then
			end;
			local jdat = JSON.decode(url);
			local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
			for m, n in ipairs(data) do
				if n.user_id then
					if n.is_owner == true then
						owner_id = n.user_id;
					end;
				end;
			end;
			Keyboard = {
				{
					{
						text = "⌯ آمار پیوی ⌯ ",
						url = "https://telegram.me/" .. Paybot .. "?start=menu:" .. chat_id
					}
				}
			};
			TD.sendText(chat_id, 0, "◄ مالک عزیز " .. MentionUser(owner_id) .. " آمار گروه به پیوی شما ارسال شد !", "html", false, false, false, false, TD.replyMarkup({
				type = "inline",
				data = Keyboard
			}));
			TD.sendText(msg.chat_id, msg.id, "◄ فعالیت های امروز اعضا تا این لحظه :\n\n⌯  تاریخ :  " .. jdat.date.full.official.usual.fa .. " ، " .. jdat.date.weekday.name .. "\n⌯  ساعت : " .. jdat.time24.full.fa .. "" .. jdat.time12.shift.full .. "\n" .. _resultTEXT .. "\n┈┅━┃آمار کل ورود خروج┃━┅┈\n\n✮ تعداد اعضا :" .. result.member_count .. "\n✮ اعضای جدید : " .. JoinedGroup .. "\n✮ تعداد ادمین ها : " .. result.administrator_count .. "\n✮ اعضای اخراج شده : " .. result.banned_count .. "\n✮ اعضای سکوت شده : " .. result.restricted_count .. "\n\n┈┅━┃آمار کل گروه┃━┅┈\n\n✦ کل پیام ها : " .. (base:get(TD_ID .. "All:Message:" .. chat_id) or 0) .. "\n✦ متن ها : " .. Text .. "\n✦ گیف ها : " .. Animation .. "\n✦ فیلم ها : " .. Video .. "\n✦ عکس ها : " .. Photo .. "\n✦ صداها : " .. Voice .. "\n✦ استیکر ها : " .. Stricker .. "\n✦ فایل ها : " .. Document .. "\n✦ فیلم سلفی : " .. VideoNote .. "\n✦ فورواردی ها : " .. Forwarded .. "\n", "html", false, false, false, false);
		end;
		if Ramin and (Ramin:match("^[Ss][Tt][Aa][Tt][Ss] (%d+)$") or Ramin:match("^امار (%d+) نفر$") or Ramin:match("^آمار (%d+) نفر$")) and is_Owner(msg) and is_JoinChannel(msg) then
			local count = Ramin:match("^[Ss][Tt][Aa][Tt][Ss] (%d+)$") or Ramin:match("^امار (%d+) نفر$") or Ramin:match("^آمار (%d+) نفر$");
			if 1 > tonumber(count) or tonumber(count) > 50 then
				TD.sendText(msg.chat_id, msg.id, "⌯ تعداد نفرات وارد شده باید بزرگتر از 1 و کوچک تر از 50 باشد ▸", "md");
			else
				GroupStats(msg.chat_id, msg.id, count);
			end;
		end;
		if Ramin and (Ramin:match("^statsadmin (%d+) user$") or Ramin:match("^امار مدیران (%d+) نفر$") or Ramin:match("^آمار مدیران (%d+) نفر$")) and is_Owner(msg) and is_JoinChannel(msg) then
			local count = Ramin:match("^statsadmin (%d+) user$") or Ramin:match("^امار مدیران (%d+) نفر$") or Ramin:match("^آمار مدیران (%d+) نفر$");
			if 1 > tonumber(count) or tonumber(count) > 50 then
				TD.sendText(msg.chat_id, msg.id, "⌯ تعداد نفرات وارد شده باید بزرگتر از 1 و کوچک تر از 50 باشد ▸", "md");
			else
				GroupStatsAdmin(msg.chat_id, msg.id, count);
			end;
		end;
		if Ramin == "آمار ادمین ها" or Ramin == "آمار مدیران" or Ramin == "امار ادمین ها" or Ramin == "امار مدیران" or Ramin == "statusgp" and is_JoinChannel(msg) then
			GroupStatsAdmin(msg.chat_id, msg.id);
		end;
		if Ramin == "آمار" or Ramin == "امار" or Ramin == "statusgp" and is_JoinChannel(msg) then
			GroupStats(msg.chat_id, msg.id);
		end;
		if Ramin == "آمار پیوی" or Ramin == "امار پیوی" or Ramin == "statuspv" and is_Owner(msg) and is_JoinChannel(msg) then
			GroupStatsPV(msg.chat_id, msg.id);
		end;
		if (Ramin == "lockauto off" or Ramin == "قفل خودکار غیرفعال") and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "autoon") then
				base:del(TD_ID .. "atolct1" .. msg.chat_id);
				base:del(TD_ID .. "atolct2" .. msg.chat_id);
				base:del(TD_ID .. "lc_ato:" .. msg.chat_id);
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "autoon");
				sendBot(msg.chat_id, msg.id, "⌯ قفل خودکار گروه غیرفعال شد. ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار  گروه غیرفعال می باشد! ", "html");
			end;
		end;
		if Ramin1 and (Ramin1:match("^([Mm]uteall) (.*)$") or Ramin1:match("^(حالت قفل خودکار) (.*)$")) and is_JoinChannel(msg) then
			local Ramin1 = Ramin1:gsub("حالت قفل خودکار", "muteall");
			local status = {
				string.match(Ramin1, "^([Mm]uteall) (.*)$")
			};
			if status[2] == "mute" or status[2] == "محدود" then
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "Tele_Mute");
				sendBot(msg.chat_id, msg.id, "  ⌯ تعطیل کردن گروہ در حالت محدود سازی قرار گرفت. ", "html");
			end;
			if status[2] == "del" or status[2] == "حذف" then
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "Tele_Mute");
				sendBot(msg.chat_id, msg.id, "  ⌯ تعطیل کردن گروہ در حالت حذف پیام کاربر قرار گرفت ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^خواندن ذهن$") or Ramin:match("^mindreading$")) and tonumber(msg.reply_to_message_id) > 0 then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local keyboard = {};
			keyboard.inline_keyboard = {
				{
					{
						text = "⌯ انتخاب کردم",
						callback_data = "bd:Khandan:" .. msg.chat_id
					}
				},
				{
					{
						text = " بیخیال ⊴",
						callback_data = "bd:Exitspanl:" .. msg.chat_id
					}
				}
			};
			SendInlineBot(msg.chat_id, "◉ کاربر عزیز \n یک عدد بین 1 تا 31 انتخاب کنید تا من بهت بگم اون عدد چنده 😁 ", keyboard, "md");
		end;
		if Ramin and (Ramin:match("^خواندن ذهن$") or Ramin:match("^mindreading$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local keyboard = {};
			keyboard.inline_keyboard = {
				{
					{
						text = "⌯ انتخاب کردم",
						callback_data = "bd:Khandan:" .. msg.chat_id
					}
				},
				{
					{
						text = " بیخیال ⊴",
						callback_data = "bd:Exitspanl:" .. msg.chat_id
					}
				}
			};
			SendInlineBot(msg.chat_id, "⌯ لطفا یک عدد بین 1 تا 31 انتخاب کن \n┅┅━ ✦ ━┅┅\nتا من بهت بگم اون عدد چنده 😁 ", keyboard, "md");
		end;
		if Ramin and (Ramin:match("^شعبده$") or Ramin:match("^juggle$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local keyboard = {};
			keyboard.inline_keyboard = {
				{
					{
						text = "⌯ انتخاب کردم",
						callback_data = "bd:showbade:" .. msg.chat_id
					}
				},
				{
					{
						text = " بیخیال ⊴",
						callback_data = "bd:Exitspanl:" .. msg.chat_id
					}
				}
			};
			text = "\n⌯ برای انجام شعبده بازی ، یکی از اجسام زیر را انتخاب و در ذهن خود نگه دارید . 😎\n\n┅┅━ ✦ ━┅┅\n1- مداد\n2- خودکار\n3- جامدادی\n4- لپتاب \n5- میکروفون\n";
			SendInlineBot(msg.chat_id, text, keyboard, "html");
		end;
		if Ramin and (Ramin:match("^(lock auto) (%d+):(%d+)-(%d+):(%d+)$") or Ramin:match("^(قفل خودکار) (%d+):(%d+)-(%d+):(%d+)$")) and is_JoinChannel(msg) then
			local CmdEn = {
				string.match(Ramin, "^(lock auto) (%d+):(%d+)-(%d+):(%d+)$")
			};
			local CmdFa = {
				string.match(Ramin, "^(قفل خودکار) (%d+):(%d+)-(%d+):(%d+)$")
			};
			local Matches2 = CmdEn[2] or CmdFa[2];
			local Matches3 = CmdEn[3] or CmdFa[3];
			local Matches4 = CmdEn[4] or CmdFa[4];
			local Matches5 = CmdEn[5] or CmdFa[5];
			local End = Matches4 .. ":" .. Matches5;
			local Start = Matches2 .. ":" .. Matches3;
			if End == Start then
				sendBot(msg.chat_id, msg.id, " ⌯ زمان ارسال شده اشتباه می باشد! ", "html");
			else
				sendBot(msg.chat_id, msg.id, "⌯ زمان قفل خودکار گروه تنظیم شده به : \n" .. Start .. " الی " .. End .. "\n\n ", "html");
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "autoon");
				base:set(TD_ID .. "atolct1" .. msg.chat_id, Start);
				base:set(TD_ID .. "atolct2" .. msg.chat_id, End);
			end;
		end;
		if (Ramin == "lockautomedia" or Ramin == "قفل خودکار رسانه") and is_JoinChannel(msg) then
			local s = base:get(TD_ID .. "atolctmedia1" .. msg.chat_id);
			local t = base:get(TD_ID .. "atolctmedia2" .. msg.chat_id);
			if not s and (not t) then
				base:setex(TD_ID .. "bot:SetMedia:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
				base:del(TD_ID .. "bot:SetMedia:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
				sendBot(msg.chat_id, msg.id, " ⌯ لطفا زمان شروع قفل خودکار رسانه را ارسال نمایید ! \n ⌯ الان ساعت " .. os.date("%H") .. ":" .. os.date("%M") .. " ", "html");
			elseif not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "automedia") then
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار رسانه فعال شد !\nبرای تنظیم مجدد زمان ، دستور تنظیم زمان رسانه را ارسال نمایید ! ", "html");
			else
				local start = base:get(TD_ID .. "atolctmedia1" .. msg.chat_id);
				local stop = base:get(TD_ID .. "atolctmedia2" .. msg.chat_id);
				if start and stop then
					if base:get(TD_ID .. "bot:mutemedia:Run" .. msg.chat_id) then
						AutolockFa = "قفل خودکار رسانه روشن می باشد : " .. start .. "\n⌯ پایان : " .. stop;
					else
						AutolockFa = "قفل خودکار رسانه در انتظار ساعت شروع : " .. start .. "\n⌯ پایان : " .. stop;
					end;
				else
					AutolockFa = "تنظیم نشده";
				end;
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار رسانه از قبل فعال است !\n" .. AutolockFa .. "\nبرای تنظیم مجدد زمان ، دستور Settimemedia را ارسال نمایید ! ", "html");
			end;
		end;
		if base:get(TD_ID .. "bot:SetMedia:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id) and Ramin:match("^%d+:%d+$") then
			local ap = {
				string.match(Ramin, "^(%d+:)(%d+)$")
			};
			local h = Ramin:match("%d+:");
			h = h:gsub(":", "");
			local m = Ramin:match(":%d+");
			m = m:gsub(":", "");
			local h_ = 23;
			local m_ = 59;
			if h_ >= tonumber(h) and m_ >= tonumber(m) then
				local TimeStart = Ramin:match("^%d+:%d+");
				sendBot(msg.chat_id, msg.id, " ⌯ لطفا زمان پایان قفل خودکار رسانه را ارسال نمایید ! ", "html");
				base:del(TD_ID .. "bot:SetMedia:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
				base:set(TD_ID .. "atolctmedia1" .. msg.chat_id, TimeStart);
				base:setex(TD_ID .. "bot:SetMedia:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
			else
				sendBot(msg.chat_id, msg.id, "  ⌯ زمان ارسال شده صحیح نمیباشد ! ", "html");
			end;
		end;

		if base:get(TD_ID .. "bot:SetMedia:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id) then
			local t = base:get(TD_ID .. "atolctmedia1" .. msg.chat_id);
			if Ramin:match("^%d+:%d+") and (not Ramin:match(t)) then
				local ap = {
					string.match(Ramin, "^(%d+):(%d+)$")
				};
				local h = Ramin:match("%d+:");
				h = h:gsub(":", "");
				local m = Ramin:match(":%d+");
				m = m:gsub(":", "");
				local h_ = 23;
				local m_ = 59;
				if h_ >= tonumber(h) and m_ >= tonumber(m) then
					local TimeStop = Ramin:match("^%d+:%d+");
					base:del(TD_ID .. "bot:atolctmedia1:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
					base:set(TD_ID .. "atolctmedia2" .. msg.chat_id, TimeStop);
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "automedia");
					local start = base:get(TD_ID .. "atolctmedia1" .. msg.chat_id);
					local stop = base:get(TD_ID .. "atolctmedia2" .. msg.chat_id);
					sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار رسانه هر روز در ساعت " .. start .. " فعال و در ساعت " .. stop .. " غیرفعال خواهد شد ! ", "html");
					base:del(TD_ID .. "bot:muteall:start_Unixm" .. msg.chat_id);
					base:del(TD_ID .. "bot:muteall:stop_Unixm" .. msg.chat_id);
				else
					sendBot(msg.chat_id, msg.id, " ⌯ زمان ارسال شده صحیح نمیباشد ! ", "html");
				end;
			end;
		end;
		if (Ramin == "Settimemedia" or Ramin == "تنظیم زمان رسانه") and is_JoinChannel(msg) then
			base:setex(TD_ID .. "bot:SetMuteall:startm" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
			base:del(TD_ID .. "bot:SetMuteall:stopm" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
			sendBot(msg.chat_id, msg.id, " ⌯ لطفا زمان شروع قفل خودکار رسانه را ارسال نمایید ! \nبه طور مثال :\n14:38 ", "html");
		end;
		if (Ramin == "lockauto" or Ramin == "قفل خودکار") and is_JoinChannel(msg) then
			local s = base:get(TD_ID .. "atolct1" .. msg.chat_id);
			local t = base:get(TD_ID .. "atolct2" .. msg.chat_id);
			if not s and (not t) then
				base:setex(TD_ID .. "bot:SetMuteall:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
				base:del(TD_ID .. "bot:SetMuteall:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
				sendBot(msg.chat_id, msg.id, 1, " ⌯ لطفا زمان شروع قفل خودکار را ارسال نمایید ! \n ⌯ الان ساعت " .. os.date("%H") .. ":" .. os.date("%M") .. ":" .. os.date("%S") .. " ", 1, "html");
			elseif not base:sismember((TD_ID .. "Gp2:" .. msg.chat_id), "autoon") then
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار فعال شد !\nبرای تنظیم مجدد زمان ، دستور Settimeautolock را ارسال نمایید !", "html");
				base:set(TD_ID .. "bot:duplipost:mute" .. msg.chat_id, true);
			else
				local start = base:get(TD_ID .. "atolct1" .. msg.chat_id);
				local stop = base:get(TD_ID .. "atolct2" .. msg.chat_id);
				if start and stop then
					if base:get(TD_ID .. "bot:muteall:Run" .. msg.chat_id) then
						AutolockFa = "قفل خودکار  روشن می باشد : " .. start .. "\n⌯ پایان : " .. stop;
					else
						AutolockFa = "قفل خودکار در انتظار ساعت شروع : " .. start .. "\n⌯ پایان : " .. stop;
					end;
				else
					AutolockFa = "تنظیم نشده";
				end;
				sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار از قبل فعال است !\n" .. AutolockFa .. "\nبرای تنظیم مجدد زمان ، دستور Settimeautolock را ارسال نمایید ! ", "html");
			end;
		end;
		if base:get(TD_ID .. "bot:SetMuteall:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id) and Ramin:match("^%d+:%d+$") then
			local ap = {
				string.match(Ramin, "^(%d+:)(%d+)$")
			};
			local h = Ramin:match("%d+:");
			h = h:gsub(":", "");
			local m = Ramin:match(":%d+");
			m = m:gsub(":", "");
			local h_ = 23;
			local m_ = 59;
			if h_ >= tonumber(h) and m_ >= tonumber(m) then
				local TimeStart = Ramin:match("^%d+:%d+");
				sendBot(msg.chat_id, msg.id, "⌯ لطفا زمان پایان قفل خودکار را ارسال نمایید ! ", "html");
				base:del(TD_ID .. "bot:SetMuteall:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
				base:set(TD_ID .. "atolct1" .. msg.chat_id, TimeStart);
				base:setex(TD_ID .. "bot:SetMuteall:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
			else
				sendBot(msg.chat_id, msg.id, " ⌯ زمان ارسال شده صحیح نمیباشد ! ", "html");
			end;
		end;
		if base:get(TD_ID .. "bot:SetMuteall:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id) then
			local t = base:get(TD_ID .. "atolct1" .. msg.chat_id);
			if Ramin:match("^%d+:%d+") and (not Ramin:match(t)) then
				local ap = {
					string.match(Ramin, "^(%d+):(%d+)$")
				};
				local h = Ramin:match("%d+:");
				h = h:gsub(":", "");
				local m = Ramin:match(":%d+");
				m = m:gsub(":", "");
				local h_ = 23;
				local m_ = 59;
				if h_ >= tonumber(h) and m_ >= tonumber(m) then
					local TimeStop = Ramin:match("^%d+:%d+");
					base:del(TD_ID .. "bot:SetMuteall:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
					base:set(TD_ID .. "atolct2" .. msg.chat_id, TimeStop);
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "autoon");
					local start = base:get(TD_ID .. "atolct1" .. msg.chat_id);
					local stop = base:get(TD_ID .. "atolct2" .. msg.chat_id);
					sendBot(msg.chat_id, msg.id, " ⌯ قفل خودکار هر روز در ساعت " .. start .. " فعال و در ساعت " .. stop .. " غیرفعال خواهد شد ! ", "html");
					base:del(TD_ID .. "bot:muteall:start_Unix" .. msg.chat_id);
					base:del(TD_ID .. "bot:muteall:stop_Unix" .. msg.chat_id);
				else
					sendBot(msg.chat_id, msg.id, " ⌯ زمان ارسال شده صحیح نمیباشد ! ", "html");
				end;
			end;
		end;
		if (Ramin == "settimeautolock" or Ramin == "تنظیم زمان قفل خودکار") and is_JoinChannel(msg) then
			base:setex(TD_ID .. "bot:SetMuteall:start" .. msg.chat_id .. ":" .. msg.sender_id.user_id, 60, true);
			base:del(TD_ID .. "bot:SetMuteall:stop" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
			sendBot(msg.chat_id, msg.id, " ⌯ لطفا زمان شروع قفل خودکار را ارسال نمایید ! \nبه طور مثال :\n14:38 ", "html");
		end;
		if (Ramin == "timeserver" or Ramin == "ساعت سرور") and is_JoinChannel(msg) then
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			sendBot(msg.chat_id, msg.id, re .. "-" .. de, "html");
		end;
		if Ramin and (Ramin:match("^autoclener (%d+):(%d+)") or Ramin:match("^پاکسازی (%d+):(%d+)")) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local CmdEn = {
				string.match(Ramin, "^(autoclener) (%d+):(%d+)$")
			};
			local CmdFa = {
				string.match(Ramin, "^(پاکسازی) (%d+):(%d+)$")
			};
			local Matches2 = CmdEn[2] or CmdFa[2];
			local Matches3 = CmdEn[3] or CmdFa[3];
			local Start = Matches2 .. ":" .. Matches3;
			local StartAlarm = Matches2 .. ":" .. Matches3;
			local End = Matches2 .. ":" .. Matches3 + 1;
			if StartAlarm == "00:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:00" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:59");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "00:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "00:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "01:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "01:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "02:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "02:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "03:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "03:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "04:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "04:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "05:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "05:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "06:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "06:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "07:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "07:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "08:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "08:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "09:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "09:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "10:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "10:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "11:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "11:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "12:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "12:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "13:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "13:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "14:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "14:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "15:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "15:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "16:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "16:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "17:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "17:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "18:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "18:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "19:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "19:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "20:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "20:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "21:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "21:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "22:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "22:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:01" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:00");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:02" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:01");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:03" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:02");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:04" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:03");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:05" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:04");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:06" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:05");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:07" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:06");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:08" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:07");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:09" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:08");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			elseif StartAlarm == "23:10" then
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, "23:09");
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			else
				local TimeAlarm = TimeAuto(Matches3) - 1;
				T = Matches2 .. ":" .. math.floor(TimeAuto(TimeAlarm));
				base:set(TD_ID .. "DelaUtOAlarm" .. msg.chat_id, T);
				base:set(TD_ID .. "DelaUtOAlarm2" .. msg.chat_id, End);
			end;
			base:set(TD_ID .. "DelaUtO" .. msg.chat_id, Start);
			base:set(TD_ID .. "DelaUtO2" .. msg.chat_id, End);
			base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "autoclener");
			sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام گروه فعال شد!\n\n┅┅━ ✦ ━┅┅\n\n◄ پاکسازی خودکار پیام ها هر روز در ساعت " .. Start .. " توسط ربات انجام خواهد شد ! ", "html");
		end;
		if Ramin and (Ramin:match("^autostats (%d+):(%d+)") or Ramin:match("^آمار خودکار (%d+):(%d+)")) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local CmdEn = {
				string.match(Ramin, "^(autostats) (%d+):(%d+)$")
			};
			local CmdFa = {
				string.match(Ramin, "^(آمار خودکار) (%d+):(%d+)$")
			};
			local Matches2 = CmdEn[2] or CmdFa[2];
			local Matches3 = CmdEn[3] or CmdFa[3];
			local Start = Matches2 .. ":" .. Matches3;
			local End = Matches2 .. ":" .. Matches3 + 1;
			base:set(TD_ID .. "autostats" .. msg.chat_id, Start);
			base:set(TD_ID .. "autostats2" .. msg.chat_id, End);
			base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "autostats");
			sendBot(msg.chat_id, msg.id, " ⌯ آمار خودکار کاربران درگروه فعال شد !\n\nارسال آمار کاربران گروه " .. Start .. " انجام خواهد شد !\n\nبرای غیرفعال کردن آمار خودکار از دستور زیر استفاده نمایید :\n⌯ آمار خودکار غیرفعال ", "html");
		end;
		if Ramin and (Ramin:match("^setpin (.*)") or Ramin:match("^تنظیم سنجاق (.*)")) and is_JoinChannel(msg) then
			local Matches = Ramin:match("^setpin (.*)") or Ramin:match("^تنظیم سنجاق (.*)");
			sendBot(msg.chat_id, msg.id, "⌯ پیام سنجاق خودکار تنظیم شد !", "html");
			base:set(TD_ID .. "MsgPin" .. msg.chat_id, Matches);
		end;
		if Ramin and (Ramin:match("^(pintime) (%d+):(%d+)-(%d+):(%d+)$") or Ramin:match("^(ساعت سنجاق) (%d+):(%d+)-(%d+):(%d+)$")) and is_JoinChannel(msg) then
			local CmdEn = {
				string.match(Ramin, "^(pintime) (%d+):(%d+)-(%d+):(%d+)$")
			};
			local CmdFa = {
				string.match(Ramin, "^(ساعت سنجاق) (%d+):(%d+)-(%d+):(%d+)$")
			};
			local Matches2 = CmdEn[2] or CmdFa[2];
			local Matches3 = CmdEn[3] or CmdFa[3];
			local Matches4 = CmdEn[4] or CmdFa[4];
			local Matches5 = CmdEn[5] or CmdFa[5];
			local End = Matches4 .. ":" .. Matches5;
			local Start = Matches2 .. ":" .. Matches3;
			if not base:get((TD_ID .. "MsgPin" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, "⌯ لطفا اول پیامی که میخواهید خودکار سنجاق شود را تنظیم کنید !\n⌯ ┅┅━━ ⌯ ━━┅┅ ⌯ \n⌯ تنظیم سنجاق متن", "html");
			elseif End == Start then
				sendBot(msg.chat_id, msg.id, "⌯ ساعت آغاز سنجاق پیام نمیتوانید با پایان آن یکی باشد", "html");
			else
				sendBot(msg.chat_id, msg.id, "⌯ ساعت سنجاق خودکار تنظیم شد به :  <b>" .. Start .. "</b> الی <b>" .. End .. "</b>", "html");
				base:set(TD_ID .. "Autopin1" .. msg.chat_id, Start);
				base:set(TD_ID .. "Autopin2" .. msg.chat_id, End);
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "autopin");
			end;
		end;
		if (Ramin == "autostats on" or Ramin == "آمار خودکار فعال" or Ramin == "امار خودکار فعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "autostats") then
				sendBot(msg.chat_id, msg.id, " ⌯ آمار خودکار کاربران درگروه فعال شد !\n\n⌯ زمان نمایش در گروه : " .. base:get((TD_ID .. "autostats" .. msg.chat_id)) .. " ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ زمان آمار خودکار در گروه تنظیم نشده است !\n\n⌯ برای تنظیم کردن زمان از دستور زیر استفاده کنید :\n مثال : \nآمار خودکار 23:00 ", "html");
			end;
		end;
		if (Ramin == "autostats off" or Ramin == "آمار خودکار غیرفعال" or Ramin == "امار خودکار غیرفعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			base:del(TD_ID .. "autostats" .. msg.chat_id);
			base:del(TD_ID .. "autostats2" .. msg.chat_id);
			base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "autostats");
			sendBot(msg.chat_id, msg.id, "⌯ آمار خودکار کاربران در گروه غیرفعال شد ! ", "md");
		end;
		if (Ramin == "autoclener on" or Ramin == "پاکسازی خودکار پیام فعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "autoclener") then
				sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام ها فعال شد!\n\n⌯ زمان استارت : " .. base:get((TD_ID .. "DelaUtO" .. msg.chat_id)) .. " ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ زمان پاکسازی خودکار پیام ها تنظیم نشده است!\n\n⌯ برای تنظیم کردن زمان از دستور زیر استفاده کنید :\n مثال : \nپاکسازی خودکار پیام 23:00 ", "html");
			end;
		end;
		if (Ramin == "autoclener off" or Ramin == "پاکسازی خودکار پیام غیرفعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			base:del(TD_ID .. "DelaUtO" .. msg.chat_id);
			base:del(TD_ID .. "DelaUtO2" .. msg.chat_id);
			base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "autoclener");
			sendBot(msg.chat_id, msg.id, "⌯ پاکسازی خودکار پیام گروه غیرفعال شد! ", "md");
		end;
		if Ramin and Ramin:match("^لیست استیکر فیلتر$") and is_JoinChannel(msg) then
			local packlist = base:smembers(TD_ID .. "filterpackname" .. msg.chat_id);
			text = "لیست استیکرهای قفل شده:\n";
			for k, v in pairs(packlist) do
				text = text .. k .. " - t.me/addstickers/" .. v .. " \n";
			end;
			if #packlist == 0 then
				text = "⌯ لیست استیکر ها خالی می باشد!";
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if (Ramin == "pin" or Ramin == "سنجاق" or Ramin == "پین") and is_JoinChannel(msg) and tonumber(msg.reply_to_message_id) > 0 then
			base:incr(TD_ID .. "messagePinMessage:" .. msg.chat_id .. ":" .. msg.sender_id.user_id);
			sendBot(msg.chat_id, msg.reply_to_message_id, "⌯ پیام توسط مدیر سنجاق شد ! ", "html");
			TD.pinChatMessage(msg.chat_id, msg.reply_to_message_id, 1);
		end;
		if (Ramin == "unpin" or Ramin == "حذف سنجاق" or Ramin == "حذف پین") and is_JoinChannel(msg) and is_Owner(msg) and is_OwnerPlus(msg) then
			sendBot(msg.chat_id, msg.id, " ⌯ پیام سنجاق شده توسط مدیر برداشته شد!  ", "html");
			TD.unpinChatMessage(msg.chat_id, msg.reply_to_message_id);
		end;
		if (Ramin == "unpinall" or Ramin == "حذف تمام سنجاق ها" or Ramin == "حذف پین ها") and is_JoinChannel(msg) and is_Owner(msg) and is_OwnerPlus(msg) then
			sendBot(msg.chat_id, msg.id, " ⌯ پیام سنجاق شده توسط مدیر برداشته شد!  ", "html");
			TD.unpinAllChatMessages(msg.chat_id);
		end;
		if (Ramin == "remlink" or Ramin == "حذف لینک") and is_JoinChannel(msg) then
			base:del(TD_ID .. "Link:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, " ⌯ لینک تنظیم شدہ از سیستم ربات حذف شد .  ", "html");
		end;
		if Ramin and (Ramin:match("^setlink http(.*)") or Ramin:match("^تنظیم لینک http(.*)")) and is_JoinChannel(msg) then
			local link = msg.content.text:match("^setlink (.*)") or msg.content.text:match("^تنظیم لینک (.*)");
			base:set(TD_ID .. "Link:" .. msg.chat_id, link);
			sendBot(msg.chat_id, msg.id, "⌯ لینک گروه ثبت شد :\n" .. link .. " ", "html");
		end;
		if Ramin and (Ramin:match("^تنظیم تگ$") or Ramin:match("^addtag$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				SetTag(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^تنظیم تگ$") or Ramin:match("^addtag$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					SetTag(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				SetTag(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					SetTag(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				SetTag(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and (Ramin:match("^تنظیم تگ (.*)$") or Ramin:match("^addtag (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			SetTag(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^تنظیم تگ @(.*)$") or Ramin:match("^addtag @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local username = Ramin:match("^تنظیم تگ @(.*)$") or Ramin:match("^addtag @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				SetTag(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin1 and (Ramin1:match("^taglistes @(.*)$") or Ramin1:match("^تگ لیستی @(.*)$")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin1:match("^taglistes @(.*)$") or Ramin1:match("^تگ لیستی @(.*)$");
			text = "⌯ کاربران زیر به لیست تگ اضافه شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					base:sadd(TD_ID .. "taglist:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🅃 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin1 and (Ramin1:match("^demtaglistes @(.*)$") or Ramin1:match("^حذف تگ لیستی @(.*)$")) and is_JoinChannel(msg) and is_ModLock(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin1:match("^demtaglistes @(.*)$") or Ramin1:match("^حذف تگ لیستی @(.*)$");
			text = "⌯ کاربران زیر از لیست تگ حذف شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					base:srem(TD_ID .. "taglist:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🅃 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^حذف تگ (%d+)$") or Ramin:match("^remtag (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			dofile("./checkuser.lua");
			RemTag(msg, msg.chat_id, Ramin:match("^حذف تگ (%d+)$") or Ramin:match("^remtag (%d+)$"));
		end;
		if Ramin and (Ramin:match("^حذف تگ$") or Ramin:match("^remtag$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				RemTag(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^حذف تگ$") or Ramin:match("^remtag$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					RemTag(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				RemTag(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					RemTag(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				RemTag(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف تگ (.*)$") or Ramin:match("^remtag (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			RemTag(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^حذف تگ @(.*)$") or Ramin:match("^remtag @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف تگ @(.*)$") or Ramin:match("^remtag @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				RemTag(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف تگ (%d+)$") or Ramin:match("^remtag (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			dofile("./checkuser.lua");
			RemTag(msg, msg.chat_id, Ramin:match("^حذف تگ (%d+)$") or Ramin:match("^remtag (%d+)$"));
		end;
		if Ramin and (Ramin:match("^معاف$") or Ramin:match("^setvipadd$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				SetAdd(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^معاف$") or Ramin:match("^setvipadd$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					SetAdd(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				SetAdd(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					SetAdd(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				SetAdd(msg, msg.chat_id, result.sender_id.user_id);
				print("check");
			end;
		end;
		if RaminEnti and (Ramin:match("^معاف (.*)$") or Ramin:match("^setvipadd (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			SetAdd(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^معاف @(.*)$") or Ramin:match("^setvipadd @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local username = Ramin:match("^معاف @(.*)$") or Ramin:match("^setvipadd @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				SetAdd(msg, msg.chat_id, result.id);
			else
				dofile("./checkuser.lua");
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^معاف (%d+)$") or Ramin:match("^setvipadd (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			SetAdd(msg, msg.chat_id, Ramin:match("^معاف (%d+)$") or Ramin:match("^setvipadd (%d+)$"));
		end;
		if Ramin and (Ramin:match("^اجبار$") or Ramin:match("^remvipadd$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				RemAdd(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^اجبار$") or Ramin:match("^remvipadd$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					RemAdd(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				RemAdd(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					RemAdd(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				RemAdd(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and (Ramin:match("^اجبار (.*)$") or Ramin:match("^remvipadd (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			RemAdd(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^اجبار @(.*)$") or Ramin:match("^remvipadd @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local username = Ramin:match("^اجبار @(.*)$") or Ramin:match("^remvipadd @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				RemAdd(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اجبار (%d+)$") or Ramin:match("^remvipadd (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			dofile("./checkuser.lua");
			RemAdd(msg, msg.chat_id, Ramin:match("^اجبار (%d+)$") or Ramin:match("^remvipadd (%d+)$"));
		end;
		if Ramin == "taglist" or Ramin == "لیست تگ" and is_JoinChannel(msg) then
			local list = base:smembers(TD_ID .. "taglist:" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, " ⌯ لیست تگ خالی می باشد. ", "md");
			else
				local txt = "─┅━━━لیست تگ━━━┅─\n\n";
				for k, v in pairs(list) do
					local usrname = base:get("FirstName:" .. v);
					if usrname then
						username = "@" .. usrname .. " - <code>" .. v .. "</code>";
					else
						Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
					end;
					txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if (Ramin == "clean vipaddlist" or Ramin == "پاکسازی لیست تگ") and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "taglist:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ لیست تگ با موفقیت پاک شد. ", "md");
		end;
		if Ramin == "vipaddlist" or Ramin == "لیست معاف" and is_JoinChannel(msg) then
			local list = base:smembers(TD_ID .. "VipAdd:" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, " ⌯ لیست کاربران معاف از اد اجباری خالی می باشد. ", "md");
			else
				local txt = "─┅━━━#لیست_معاف_ها━━━┅─\n\n";
				for k, v in pairs(list) do
					local usrname = base:get("FirstName:" .. v);
					if usrname then
						username = "@" .. usrname .. " - <code>" .. v .. "</code>";
					else
						Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
					end;
					txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if (Ramin == "clean vipaddlist" or Ramin == "پاکسازی لیست معاف") and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "VipAdd:" .. msg.chat_id);
			base:del(TD_ID .. "VipJoin:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ لیست کاربران معاف شده پاک شد. ", "md");
		end;
		if Ramin == "add" or Ramin == "نصب" or Ramin == "دریافت لینک" or Ramin == "getlinks" then
			local res = TD.getSupergroupFullInfo(msg.chat_id);
			base:set(TD_ID .. "Link:" .. msg.chat_id, res.invite_link.invite_link);
		end;
		if Ramin == "دریافت لینک" or Ramin == "getlinks" and is_JoinChannel(msg) then
			local res = TD.getSupergroupFullInfo(msg.chat_id);
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_invite_users == true then
				invitelink = base:get(TD_ID .. "Link:" .. msg.chat_id);
				sendBot(msg.chat_id, msg.id, invitelink, "md");
			else
				sendBot(msg.chat_id, msg.id, "⌯ ربات دسترسی به دریافت لینک را ندارد لطفا ربات را به صورت کامل دسترسی بدهید !", "md");
			end;
		end;
		if Ramin == "لینک" or Ramin == "لینک گروه" or Ramin == "link" or Ramin == "linkgp" and is_Mod(msg) and is_JoinChannel(msg) then
			local res = TD.getSupergroupFullInfo(msg.chat_id);
			base:set(TD_ID .. "Link:" .. msg.chat_id, res.invite_link.invite_link);
			first_name = string.gsub(res.invite_link.invite_link, "[%(%)%[%]%%]", "");
			first_name1 = first_name:gsub("+", "joinchat/");
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_invite_users == true then
				local keyboard = {};
				keyboard.inline_keyboard = {
					{
						{
							text = "⌯ اشتراک گذاری لینک ",
							url = "https://t.me/share/url?url=" .. first_name1 .. ""
						}
					},
					{
						{
							text = "⌯ لینک  کیوآر کد",
							callback_data = "bd:SendQrLink:" .. msg.chat_id
						},
						{
							text = "⌯  لینک  متنی",
							callback_data = "bd:ShowGpLink:" .. msg.chat_id
						}
					},
					{
						{
							text = "⌯ درخواست لینک موقت ",
							callback_data = "bd:SendLinkM:" .. msg.chat_id
						}
					},
					{
						{
							text = "⌯  لینک عکس دار",
							callback_data = "bd:ShowGpPhoto:" .. msg.chat_id
						},
						{
							text = "⌯  لینک پیوی",
							callback_data = "bd:SendPvGpLink:" .. msg.chat_id
						}
					},
					{
						{
							text = " بستن ⊴",
							callback_data = "bd:Exitspanl:" .. msg.chat_id
						}
					}
				};
				memlink = tonumber(base:get(TD_ID .. "memlink:Max:" .. msg.chat_id)) or "تنظیم نشده";
				memexpire = tonumber(base:get(TD_ID .. "memexpire" .. msg.chat_id)) or "تنظیم نشده";
				if base:get(TD_ID .. "memlinkexpire" .. msg.chat_id) == "hour" then
					memlinkexpire = "یک ساعت";
				elseif base:get(TD_ID .. "memlinkexpire" .. msg.chat_id) == "day" then
					memlinkexpire = "یک روز";
				elseif base:get(TD_ID .. "memlinkexpire" .. msg.chat_id) == "week" then
					memlinkexpire = "یک هفته";
				elseif not base:get((TD_ID .. "memlinkexpire" .. msg.chat_id)) then
					memlinkexpire = "بدون محدودیت";
				end;
				local ex = base:ttl(TD_ID .. "ExpireLink:" .. msg.chat_id);
				local Time_ = getTimeUptime(ex);
				SendInlineBot(msg.chat_id, "◂ جهت حفاظت از لینک گروه ، به صورت مستقیم نمایش داده نمیشود ! \n\n◂ لطفا دکمه موردنظر خود را لمس کنید .", keyboard, "md");
			else
				sendBot(msg.chat_id, msg.id, "⌯ ربات دسترسی به دریافت لینک را ندارد لطفا ربات را به صورت کامل دسترسی بدهید !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^ویژه$") or Ramin and Ramin:match("^setvip$") or Ramin and Ramin:match("^تنظیم ویژه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				SetVip(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^ویژه$") or Ramin and Ramin:match("^setvip$") or Ramin and Ramin:match("^تنظیم ویژه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					SetVip(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				SetVip(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					SetVip(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				SetVip(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^ویژه (.*)$") or Ramin and Ramin:match("^setvip (.*)$") or Ramin and Ramin:match("^تنظیم ویژه (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			SetVip(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^ویژه @(.*)$") or Ramin and Ramin:match("^setvip @(.*)$") or Ramin and Ramin:match("^تنظیم ویژه @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^ویژه @(.*)$") or Ramin:match("^setvip @(.*)$") or Ramin:match("^تنظیم ویژه @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				SetVip(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^setviplistes @(.*)$") or Ramin:match("^ویژه لیستی @(.*)$")) then
			local inputz = Ramin:match("^setviplistes @(.*)$") or Ramin:match("^ویژه لیستی @(.*)$");
			text = "⌯ کاربران زیر به لیست کاربران ویژه اضافه شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					base:sadd(TD_ID .. "Vip:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🄼 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^demviplistes @(.*)$") or Ramin:match("^حذف ویژه لیستی @(.*)$")) then
			local inputz = Ramin:match("^demviplistes @(.*)$") or Ramin:match("^حذف ویژه لیستی @(.*)$");
			text = "⌯ کاربران زیر از لیست کاربران وِیژه حذف شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					base:srem(TD_ID .. "Vip:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🄼 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^ویژه (%d+)$") or Ramin and Ramin:match("^setvip (%d+)$") or Ramin and Ramin:match("^تنظیم ویژه (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			dofile("./checkuser.lua");
			SetVip(msg, msg.chat_id, Ramin:match("^ویژه (%d+)$") or Ramin:match("^setvip (%d+)$") or Ramin:match("^تنظیم ویژه (%d+)$"));
		end;
		if Ramin and (Ramin:match("^حذف از عضو ویژه$") or Ramin:match("^demvip$") or Ramin:match("^remvip$") or Ramin:match("^حذف ویژه$")) and tonumber(msg.reply_to_message_id) > 0 then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
				dofile("./checkuser.lua");
				RemVip(msg, msg.chat_id, res.sender_id.user_id);
			end;
		end;
		if Ramin and (Ramin:match("^حذف از عضو ویژه$") or Ramin:match("^demvip$") or Ramin:match("^remvip$") or Ramin:match("^حذف ویژه$")) and tonumber(msg.reply_to_message_id) > 0 then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					RemVip(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				dofile("./checkuser.lua");
				RemVip(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					RemVip(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				RemVip(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^حذف از عضو ویژه (.*)$") or Ramin and Ramin:match("^demvip (.*)$") or Ramin and Ramin:match("^remvip (.*)$") or Ramin and Ramin:match("^حذف ویژه (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			RemVip(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^حذف از عضو ویژه @(.*)$") or Ramin and Ramin:match("^demvip @(.*)$") or Ramin and Ramin:match("^remvip @(.*)$") or Ramin and Ramin:match("^حذف ویژه @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف از عضو ویژه @(.*)$") or Ramin:match("^demvip @(.*)$") or Ramin:match("^حذف ویژه @(.*)$") or Ramin:match("^remvip @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				RemVip(msg, msg.chat_id, result.id);
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف از عضو ویژه (%d+)$") or Ramin and Ramin:match("^demvip (%d+)$") or Ramin and Ramin:match("^remvip (%d+)$") or Ramin and Ramin:match("^حذف ویژه (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModVipCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			dofile("./checkuser.lua");
			RemVip(msg, msg.chat_id, Ramin:match("^حذف از عضو ویژه (%d+)$") or Ramin:match("^demvip (%d+)$") or Ramin:match("^remvip (%d+)$") or Ramin:match("^حذف ویژه (%d+)$"));
		end;
		if Ramin == 'ping' or  Ramin == 'پینگ' and is_Mod(msg)  and is_JoinChannel(msg) then
		local time_ = os.time()
		if time_ ~= os.time() then
		Stop = os.time() - time_
		else
		Stop = "استاندارد"
		end
		local ping = io.popen("ping -c 1 api.telegram.org"): read("*a"): match("time=(%S+)") / 100 * 10
		print(ping)
		local bot = "<a href=\"tg://user?id=" .. BotJoiner .. "\">ربات</a>"
			sendBot(msg.chat_id, msg.id, "◄ <b>"..bot.." اصلی آنلاین می باشد !</b>\n━━┅─ 🅐🅟🅘 ─┅━━\n⇧ سرعت ارسال دیتا : <b>"..os.time() - time_.. " ثانیه</b>\n⇩ سرعت دریافت دیتا : <b>"..Stop.. "</b>\n◃ پینگ به تلگرام : <b>"..ping.. " میلی ثانیه</b>", "html")
		end


		--Username: '..(tdlib_functions.getMe().usernames.editable_username ~= '' and '@'..tdlib_functions.getMe().usernames.editable_username or '---')..'
		--<a href=\"tg://user?id=" .. BotJoiner .. "\">" .. (TD.getMe()).usernames.editable_username .. "</a>

		
		if Ramin == "ربات" or Ramin == "bot" and is_Mod(msg) then
			if msg.sender_id.user_id == 724990027 then
				local rankpro = {
					"😍 وای عشق من سلطان من اومد ",
					"☹️ بابا تو این گروه منو اذیت می کنند",
					"😊 مالک این گروه عموی منه دوسش دارم",
					"جووون",
					"🤨 درد کجا بودی اینا منو اذیت می کنند"
				};
				sendBot(msg.chat_id, msg.id, rankpro[math.random(#rankpro)], "md");
			else
				local Bot = base:get(TD_ID .. "rank" .. msg.chat_id .. msg.sender_id.user_id) or base:get(TD_ID .. "ranksudo" .. msg.sender_id.user_id);
				if Bot then
					local rankpro = {
						"⚡️ " .. Bot .. " من همیشه پرسرعتم ",
						"😊 " .. Bot .. " در خدمتم ",
						"👨🏻💻 " .. Bot .. " حواسم به گروه هست ",
						"",
						"🤧 " .. Bot .. " بفرمایید قربان ",
						"🦸🏻♂️ " .. Bot .. " امنیت را با من تجربه کن ",
						"🤠 " .. Bot .. " پادشاه ربات ها منم شک نکن ",
						"" .. Bot .. " ربات گروهتون همیشه آنلاینه ",
						"" .. Bot .. " من همیشه هستم ",
						"" .. Bot .. " چطوری خوبی"
					};
					sendBot(msg.chat_id, msg.id, rankpro[math.random(#rankpro)], "md");
				else
					result = TD.getUser(msg.sender_id.user_id);
					if result.usernames.editable_username == "" then
						name = ec_name(result.first_name);
					else
						name = result.usernames.editable_username;
					end;
					if result.usernames.editable_username == "" then
						frname = ec_name(result.first_name);
					else
						frname = result.usernames.editable_username;
					end;
					local rrr = {
						name,
						frname,
						"[" .. name .. "](tg://user?id=" .. msg.sender_id.user_id .. ")",
						"[" .. frname .. "](tg://user?id=" .. msg.sender_id.user_id .. ")"
					};
					if tonumber(user) == tonumber(2076851562) or tonumber(user) == tonumber(2076851562) then
						rankuser = "👑 پادشاه ";
					elseif tonumber(user) == tonumber(Config.Sudoid) then
						rankuser = "🤠 بابایی ";
					elseif SudUser(msg, user) then
						rankuser = "🕵🏻‍♂️ سودو ";
					elseif OwnUser(msg, user) then
						rankuser = "👮🏻‍♂️ مالک ";
					elseif OwnUserPlus(msg, user) then
						rankuser = "👨🏻‍🏭 ارشد ";
					elseif NazemUser(msg, user) then
						rankuser = "👨‍🔧 معاون ";
					elseif ModUser(msg, user) then
						rankuser = "🧑🏻‍✈️ ادمین ";
					else
						return;
					end;
					local rank = {
						" "..rankuser.." من همیشه پرسرعتم ",
						""..rankuser.." در خدمتم  ",
						" "..rankuser.." من رباتی هستم پرقدرت ",
						""..rankuser.." حواسم به گروه هست  ",
						" "..rankuser.." بفرمایید  ",
						" "..rankuser.." من آنلاینم ",
						" "..rankuser.." جانم ",
						" "..rankuser.." جوون ",
						" "..rankuser.." با من به روز باش",
						" "..rankuser.." حواسم را پرت نکن "
					};
					sendBot(msg.chat_id, msg.id, "<b>" .. rank[math.random(#rank)] .. "</b>", "html");
				end;
			end;
		end;
		if Ramin == "viplist" or Ramin == "vip list" or Ramin == "لیست عضو های ویژه" or Ramin == "لیست ویژه" and is_JoinChannel(msg) then
			local list = base:smembers(TD_ID .. "Vip:" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست ویژه خالی می باشد. ", "md");
			else
				local txt = "─┅━━━ لیست کاربران ویژه ━━━┅─\n\n";
				for k, v in pairs(list) do
					local usrname = base:get("FirstName:" .. v);
					if usrname then
						username = "@" .. usrname .. " - <code>" .. v .. "</code>";
					else
						Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
					end;
					txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if Ramin == "vipbiolist" or Ramin == "لیست عضو ضد بیوگرافی" and is_JoinChannel(msg) then
			local list = base:smembers(TD_ID .. "VipBio:" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, " ⌯ لیست عضو ضدبیوگرافی خالی می باشد. ", "md");
			else
				local txt = "─┅━━━ لیست عضو بیوگرافی ━━━┅─\n\n";
				for k, v in pairs(list) do
					local usrname = base:get("FirstName:" .. v);
					if usrname then
						username = "@" .. usrname .. " - <code>" .. v .. "</code>";
					else
						Name = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v) or v;
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. Name .. "</a>";
					end;
					txt = "" .. txt .. " <b>" .. v .. "</b>➲ " .. username .. "\n\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if (Ramin == "clean vipList" or Ramin == "پاکسازی اعضای ویژه" or Ramin == "پاکسازی لیست ویژه") and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Vip:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی لیست ویژه با موفقیت انجام شد  ", "html");
		end;
		if (Ramin == "clean viplistbio" or Ramin == "پاکسازی لیست ضد بیوگرافی") and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "VipBio:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, " ⌯ لیست افراد ضد بیوگرافی پاکسازی شد! ", "html");
		end;
		if Ramin and (Ramin:match("^cbmtime (%d+)[hms]") or Ramin:match("^زمان پاکسازی پیام ربات (%d+) [ثانیه]")) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^cbmtime (%d+)[hms]") or Ramin:match("^زمان پاکسازی پیام ربات (%d+) [ثانیه]");
			if Ramin and (Ramin:match("(%d+)s") or Ramin:match("(%d+) ثانیه")) then
				time_match = Ramin:match("(%d+)s") or Ramin:match("(%d+) ثانیه");
				time = time_match;
				th = time * 1;
				t = "ثانیه";
			end;
			base:set(TD_ID .. "cbmtime:" .. msg.chat_id, time);
			sendBot(msg.chat_id, msg.id, " ⌯ زمان پاکسازی پیام ربات تنظیم شد به : " .. th .. " " .. t .. " \n\n⌯  کاربر  گرامی پاکسازی پیام های خودکار ربات هر [" .. th .. " " .. t .. "] یکبار به صورت خودکار انجام خواهد شد. ", "html");
		end;
		if Ramin and (Ramin:match("^cleanwelcometime (%d+)[hms]") or Ramin:match("^زمان پاکسازی خوش آمدگویی (%d+) [ثانیه]") or Ramin:match("^زمان پاکسازی خوشامد (%d+) [ثانیه]")) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^cleanwelcometime (%d+)[hms]") or Ramin:match("^زمان پاکسازی خوش آمدگویی (%d+) [ثانیه]") or Ramin:match("^زمان پاکسازی خوشامد (%d+) [ثانیه]");
			if Ramin and (Ramin:match("(%d+)s") or Ramin:match("(%d+) ثانیه")) then
				time_match = Ramin:match("(%d+)s") or Ramin:match("(%d+) ثانیه");
				time = time_match;
				th = time * 1;
				t = "ثانیه";
			end;
			base:set(TD_ID .. "cleanwelcometime:" .. msg.chat_id, time);
			sendBot(msg.chat_id, msg.id, " ⌯ زمان پاکسازی پیام خوش آمدگویی  به : " .. th .. " " .. t .. " تنظیم شد . ", "md");
		end;
		if (Ramin == "cbm on" or Ramin == "پاکسازی پیام ربات فعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			local timecgms = base:get(TD_ID .. "cbmtime:" .. msg.chat_id) or 20;
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cbmon") then
				sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار از قبل فعال بود\n\n⌯ زمان : " .. timecgms .. " ", "html");
			else
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "cbmon");
				sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام های ربات فعال شد...!⌯ زمان پاکسازی هر " .. timecgms .. " ثانیه یکبار است. ", "html");
			end;
		end;
		if (Ramin == "cbm off" or Ramin == "پاکسازی پیام ربات غیرفعال") and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cbmon") then
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "cbmon");
				sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام های ربات غیرفعال شد . ", "md");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ پاکسازی خودکار پیام های ربات غیرفعال بود . ", "md");
			end;
		end;
		if Ramin and (Ramin:match("^رهایی$") or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr]$")) and is_JoinChannel(msg) and tonumber(msg.reply_to_message_id) > 0 and  is_ModRid(msg.chat_id, msg.sender_id.user_id) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Rid(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^رهایی$") or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr]$")) and is_JoinChannel(msg) and tonumber(msg.reply_to_message_id) > 0 and  is_ModRid(msg.chat_id, msg.sender_id.user_id) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Rid(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Rid(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Rid(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						Rid(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^رهایی (.*)$") or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and  is_ModRid(msg.chat_id, msg.sender_id.user_id) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				Rid(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^رهایی @(.*)$")  or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and  is_ModRid(msg.chat_id, msg.sender_id.user_id) then
			local username = Ramin:match("^رهایی @(.*)$")  or Ramin:match("[Rr][Ii][Dd][Uu][Ss][Ee][Rr] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Rid(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^رهایی (%d+)$")  or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and  is_ModRid(msg.chat_id, msg.sender_id.user_id) then
			local idadad = Ramin:match("^رهایی (%d+)$")  or Ramin:match("^[Rr][Ii][Dd][Uu][Ss][Ee][Rr] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Rid(msg, msg.chat_id, id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		
		
		
		
		if Ramin and ( Ramin:match("^رهایی کلی$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL]$")) and is_JoinChannel(msg) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Ridall(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and ( Ramin:match("^رهایی کلی$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL]$")) and is_JoinChannel(msg) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Ridall(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Ridall(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Ridall(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						Ridall(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^رهایی کلی (.*)$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				Ridall(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and ( Ramin:match("^رهایی کلی @(.*)$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
			local username =  Ramin:match("^رهایی کلی @(.*)$") or Ramin:match("[Rr][Ii][Dd][Aa][Ll][LL] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Ridall(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and ( Ramin:match("^رهایی کلی (%d+)$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
			local idadad = Ramin:match("^رهایی کلی (%d+)$") or Ramin:match("^[Rr][Ii][Dd][Aa][Ll][LL] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Ridall(msg, msg.chat_id, id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, "⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		
		
		if Ramin and (Ramin:match("^وضعیت کاربر$") or Ramin:match("^[Ii][Ss]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Statususer(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^وضعیت کاربر$") or Ramin:match("^[Ii][Ss]$")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			text = res.content.text.text;
			if text:match("^@(.*)$") then
				local username = text:match("^@(.*)$");
				result = TD.searchPublicChat(username);
				if result.id then
					dofile("./checkuser.lua");
					Statususer(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
				end;
			elseif text:match("^(%d+)$") then
				local id = text:match("^(%d+)$");
				Statususer(msg, msg.chat_id, tonumber(id));
			elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
				Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
				if Ramin.id then
					dofile("./checkuser.lua");
					Statususer(msg, msg.chat_id, Ramin.id);
				end;
			else
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				dofile("./checkuser.lua");
				Statususer(msg, msg.chat_id, result.sender_id.user_id);
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^وضعیت کاربر (.*)$") or Ramin:match("^[Ii][Ss] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			dofile("./checkuser.lua");
			Statususer(msg, msg.chat_id, id);
		end;
		if Ramin and (Ramin:match("^وضعیت کاربر @(.*)$") or Ramin:match("^[Ii][Ss] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^وضعیت کاربر @(.*)$") or Ramin:match("[Ii][Ss] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				dofile("./checkuser.lua");
				Statususer(msg, msg.chat_id, result.id);
			end;
		end;
		if Ramin and (Ramin:match("^وضعیت کاربر (%d+)$") or Ramin:match("^[Ii][Ss](%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^وضعیت کاربر (%d+)$") or Ramin:match("^[Ii][Ss] (%d+)$");
			result = TD.getUser(idadad);
			if result.first_name then
				dofile("./checkuser.lua");
				Statususer(msg, msg.chat_id, idadad);
			end;
		end;
		if Ramin and (Ramin:match("^addpm (.*)$") or Ramin:match("^(پیام اداجباری) (.*)$") or Ramin:match("^(پیام اد اجباری) (.*)$")) and is_JoinChannel(msg) then
			local TDLua = Ramin:gsub("پیام اداجباری", "addpm");
			local status = {
				string.match(TDLua, "^(addpm) (.*)$")
			} or {
				(string.match(TDLua, "^(پیام اداجباری) (.*)$") or Ramin:match("^(پیام اد اجباری) (.*)$"))
			};
			local hsh = "addpm" .. msg.chat_id;
			if status[2] == "on" or status[2] == "فعال" then
				base:del(TD_ID .. hsh);
				sendBot(msg.chat_id, msg.id, "⌯ ارسال پیام محدودیت اداجباری کاربر فعال شد ! ", "html");
			end;
			if status[2] == "off" or status[2] == "غیرفعال" then
				base:set(TD_ID .. hsh, true);
				sendBot(msg.chat_id, msg.id, " ⌯ ارسال پیام محدودیت اداجباری کاربر غیرفعال شد ! ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^([Ss]etforce) (.*)$") or Ramin:match("^(وضعیت افزودن اجباری) (.*)$") or Ramin:match("^(وضعیت اد اجباری) (.*)$")) and is_JoinChannel(msg) then
			local TDLua = Ramin:gsub("وضعیت افزودن اجباری", "setforce");
			local status = {
				string.match(TDLua, "^([Ss]etforce) (.*)$")
			};
			if status[2] == "new user" or status[2] == "جدید" then
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "force_NewUser");
				sendBot(msg.chat_id, msg.id, "⌯ وضعیت اد اجباری بر روی کاربران جدید تنظیم شد\n\n⌯ از این پس کاربران جدید باید به تعداد دلخواه شما اد بزنند ، تا بتوانند پیام ارسال کنند ! ", "html");
			end;
			if status[2] == "all user" or status[2] == "همه" then
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "force_NewUser");
				sendBot(msg.chat_id, msg.id, " ⌯ وضعیت اد اجباری بر روی همه کاربران تنظیم شد . ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^لیست اخطار$") or Ramin and Ramin:match("^[Ww][Aa][Rr][Nn][Ll][Ii][Ss][Tt]$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) then
			local list = base:hkeys(TD_ID .. "warn" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست کاربرانی که اخطار دریافت کرده اند خالی میباشد ! ", "html");
			else
				local txt = "─┅━━━#لیست_اخطار━━━┅─\n\n";
				for k, v in pairs(list) do
					local cont = base:hget(TD_ID .. "warn" .. msg.chat_id, v) or 0;
					local firstname = base:get("firstname" .. v);
					if firstname then
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. StringData(firstname) .. "</a>";
					else
						username = "<a href=\"tg://user?id=" .. v .. "\">" .. v .. "</a>";
					end;
					txt = txt .. k .. " - [ " .. username .. " - (" .. Alpha(cont) .. ")  ]\n";
				end;
				sendBot(msg.chat_id, msg.id, txt, "html");
			end;
		end;
		if Ramin and (Ramin:match("^پاکسازی لیست اخطار$") or Ramin and Ramin:match("^[Cc][Ll][Ee][Aa][Nn] [Ww][Aa][Rr][Nn][Ll][Ii][Ss][Tt]$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			list = base:hkeys(TD_ID .. "warn" .. msg.chat_id);
			if #list == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست کاربرانی که اخطار دریافت کرده اند خالی میباشد ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, "⌯ لیست کاربرانی که اخطار دریافت کرده اند پاکسازی شد ! ", "html");
				base:del(TD_ID .. "warn" .. msg.chat_id);
			end;
		end;
		if Ramin and (Ramin:match("^اخراج$") or Ramin:match("^[Kk][Ii][Cc][Kk]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						kick(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^اخراج$") or Ramin:match("^[Kk][Ii][Cc][Kk]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							kick(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						kick(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							kick(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						kick(msg, msg.chat_id, result.sender_id.user_id);
						print("check");
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and Ramin and (Ramin:match("^اخراج (.*)$") or Ramin:match("^[Kk][Ii][Cc][Kk] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				kick(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اخراج @(.*)$") or Ramin:match("^[Kk][Ii][Cc][Kk] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^اخراج @(.*)$") or Ramin:match("[Kk][Ii][Cc][Kk] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					kick(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اخراج (%d+)$") or Ramin:match("^[Kk][Ii][Cc][Kk] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^اخراج (%d+)$") or Ramin:match("^[Kk][Ii][Cc][Kk] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				kick(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^مسدود$") or Ramin:match("^[Bb][Aa][Nn]$") or Ramin:match("^بن$") or Ramin:match("^صیک$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						ban(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^مسدود$") or Ramin:match("^[Bb][Aa][Nn]$") or Ramin:match("^بن$") or Ramin:match("^صیک$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							ban(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						ban(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							ban(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						ban(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^مسدود (.*)$") or Ramin:match("^بن (.*)$") or Ramin:match("^صیک (.*)$") or Ramin:match("^[Bb][Aa][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				ban(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^مسدود @(.*)$") or Ramin:match("^بن @(.*)$") or Ramin:match("^صیک @(.*)$") or Ramin:match("^[Bb][Aa][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^مسدود @(.*)$") or Ramin:match("[Bb][Aa][Nn] @(.*)$") or Ramin:match("^بن @(.*)$") or Ramin:match("^صیک @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					ban(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^مسدود (%d+)$") or Ramin:match("^بن (%d+)$") or Ramin:match("^صیک (%d+)$") or Ramin:match("^[Bb][Aa][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^مسدود (%d+)$") or Ramin:match("^[Bb][Aa][Nn] (%d+)$") or Ramin:match("^بن (%d+)$") or Ramin:match("^صیک (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				ban(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^banlistes @(.*)$") or Ramin:match("^مسدود لیستی @(.*)$") or Ramin:match("^بن لیستی @(.*)$")) and is_ModBan(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin:match("^banlistes @(.*)$") or Ramin:match("^مسدود لیستی @(.*)$") or Ramin:match("^بن لیستی @(.*)$");
			text = "⌯ کاربران زیر به لیست مسدود ها اضافه شد :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					base:sadd(TD_ID .. "BanUser:" .. msg.chat_id, result.id);
					TD.setChatMemberStatus(msg.chat_id, result.id, "banned");
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🄱 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text .. "", "html");
		end;
		if Ramin and (Ramin:match("^unbanlistes @(.*)$") or Ramin:match("^حذف مسدود لیستی @(.*)$") or Ramin:match("^حذف بن لیستی @(.*)$")) and is_ModBan(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin:match("^unbanlistes @(.*)$") or Ramin:match("^حذف مسدود لیستی @(.*)$") or Ramin:match("^حذف بن لیستی @(.*)$");
			text = "⌯ کاربران زیر از لیست مسدود ها حذف شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					UnRes(msg.chat_id, result.id);
					TD.setChatMemberStatus(msg.chat_id, result.id, "banned", 0);
					base:srem(TD_ID .. "BanUser:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🄱 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^حذف مسدود$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn]$") or Ramin:match("^حذف بن$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						unban(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^حذف مسدود$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn]$") or Ramin:match("^حذف بن$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							unban(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						unban(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							unban(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						unban(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف مسدود (.*)$") or Ramin:match("^حذف بن (.*)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				unban(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف مسدود @(.*)$") or Ramin:match("^حذف بن @(.*)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف مسدود @(.*)$") or Ramin:match("[Uu][Nn][Bb][Aa][Nn] @(.*)$") or Ramin:match("^حذف بن @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					unban(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف مسدود (%d+)$") or Ramin:match("^حذف بن (%d+)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModBan(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^حذف مسدود (%d+)$") or Ramin:match("^[Uu][Nn][Bb][Aa][Nn] (%d+)$") or Ramin:match("^حذف بن (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				unban(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. idadad .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اخطار$") or Ramin:match("^[Ww][Aa][Rr][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Warn(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^اخطار$") or Ramin:match("^[Ww][Aa][Rr][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Warn(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Warn(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Warn(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						Warn(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^اخطار (.*)$") or Ramin:match("^[Ww][Aa][Rr][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				Warn(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اخطار @(.*)$") or Ramin:match("^[Ww][Aa][Rr][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^اخطار @(.*)$") or Ramin:match("[Ww][Aa][Rr][Nn] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Warn(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^اخطار (%d+)$") or Ramin:match("^[Ww][Aa][Rr][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^اخطار (%d+)$") or Ramin:match("^[Ww][Aa][Rr][Nn] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				Warn(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف کلی اخطار$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						Remwarn(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^حذف کلی اخطار$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Remwarn(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Remwarn(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Remwarn(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						Remwarn(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف کلی اخطار (.*)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				Remwarn(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف کلی اخطار @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف کلی اخطار @(.*)$") or Ramin:match("[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Remwarn(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف کلی اخطار (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^حذف کلی اخطار (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Aa][Ll][Ll][Ww][Aa][Rr][Nn] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				Remwarn(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف اخطار$") or Ramin:match("^[Rr][Ee][Mm][Ww][Aa][Rr][Nn]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							Remwarnmin(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						Remwarnmin(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							Remwarnmin(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						Remwarnmin(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف اخطار (.*)$") or Ramin:match("^[Rr][Ee][Mm][Ww][Aa][Rr][Nn] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				unmute(msg, msg.chat_id, id);
			else
				dofile("./checkuser.lua");
				Remwarnmin(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف اخطار @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Ww][Aa][Rr][Nn] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف اخطار @(.*)$") or Ramin:match("[Rr][Ee][Mm][Ww][Aa][Rr][Nn] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					Remwarnmin(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف اخطار (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Ww][Aa][Rr][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModWarn(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^حذف اخطار (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Ww][Aa][Rr][Nn] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				Remwarnmin(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^ویژه (%d+) [دقیقه]") or Ramin:match("^setvip (%d+) [min]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^ویژه (%d+) [دقیقه]") or Ramin:match("^setvip (%d+) [min]");
			if Ramin and Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه") then
				time_match = Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه");
				local time = time_match * 60;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر از قبل عضو ویژه گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "Vip:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست کاربران ویژه زمانی وجود دارد !\n", "html");
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛 به مدت (" .. getTimeUptime(time) .. ") به لیست کاربران ویژه اضافه شد !", "md");
							base:sadd(TD_ID .. "Vip:" .. msg.chat_id, user);
						end;
					end;
					function BDClearVip()
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست کاربران ویژه زمانی حذف شد! ", "md");
						base:srem(TD_ID .. "Vip:" .. msg.chat_id, user);
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					end;
					TD.set_timer(time, BDClearVip);
				end;
			end;
		end;
		if Ramin and (Ramin:match("^ویژه (%d+) [ساعت]") or Ramin:match("^setvip (%d+) [hour]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^ویژه (%d+) [ساعت]") or Ramin:match("^setvip (%d+) [hour]");
			if Ramin and Ramin:match("(%d+) hour") or Ramin:match("(%d+) ساعت") then
				time_match = Ramin:match("(%d+) hour") or Ramin:match("(%d+) ساعت");
				local time = time_match * 60;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر از قبل عضو ویژه گروه می باشد ، نمی توانید ویژه زماندار کنید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "Vip:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست کاربران ویژه زمانی وجود دارد !\n", "html");
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛 به مدت (" .. getTimeUptime(time) .. ") به لیست کاربران ویژه اضافه شد !", "md");
							base:sadd(TD_ID .. "Vip:" .. msg.chat_id, user);
						end;
					end;
					function BDClearVip()
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست کاربران ویژه زمانی حذف شد ! ", "md");
						base:srem(TD_ID .. "Vip:" .. msg.chat_id, user);
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					end;
					TD.set_timer(time, BDClearVip);
				end;
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه (%d+) [دقیقه]") or Ramin:match("^mutemedia (%d+) [min]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت رسانه (%d+) [دقیقه]") or Ramin:match("^mutemedia (%d+) [min]");
			if Ramin and Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه") then
				time_match = Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه");
				local time = time_match * 3600;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteMediaList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت رسانه ها می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت رسانه ها اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت رسانه ها اضافه شد !", "md");
							MuteMediaTime(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت رسانه ها حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه (%d+) [ساعت]") or Ramin:match("^mutemedia (%d+) [hour]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت رسانه (%d+) [ساعت]") or Ramin:match("^mutemedia (%d+) [hour]");
			if Ramin and Ramin:match("(%d+) hour") or Ramin:match("(%d+) ساعت") then
				time_match = Ramin:match("(%d+) hour") or Ramin:match("(%d+) ساعت");
				local time = time_match * 3600;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteMediaList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت رسانه ها می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت رسانه ها اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت رسانه ها اضافه شد !", "md");
							MuteMediaTime(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت رسانه ها حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه (%d+) [روز]") or Ramin:match("^mutemedia (%d+) [day]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت رسانه (%d+) [روز]") or Ramin:match("^mutemedia (%d+) [day]");
			if Ramin and Ramin:match("(%d+) ho") or Ramin:match("(%d+) روز") then
				time_match = Ramin:match("(%d+) ho") or Ramin:match("(%d+) روز");
				local time = time_match * day;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteMediaList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت رسانه ها می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت رسانه ها اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت رسانه ها اضافه شد !", "md");
							MuteMediaTime(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت رسانه ها حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteMediaList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت (%d+) [دقیقه]") or Ramin:match("^mute (%d+) [m]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت (%d+) [دقیقه]") or Ramin:match("^mute (%d+) [m]");
			if Ramin and Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه") then
				time_match = Ramin:match("(%d+) min") or Ramin:match("(%d+) دقیقه");
				local time = time_match * 60;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛 به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت اضافه شد !", "md");
							MuteUser(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت (%d+) [ساعت]") or Ramin:match("^mute (%d+) [h]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت (%d+) [ساعت]") or Ramin:match("^mute (%d+) [h]");
			if Ramin and Ramin:match("(%d+) ho") or Ramin:match("(%d+) ساعت") then
				time_match = Ramin:match("(%d+) h") or Ramin:match("(%d+) ساعت");
				local time = time_match * 3600;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛 به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت اضافه شد !", "md");
							MuteUser(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت (%d+) [روز]") or Ramin:match("^mute (%d+) [d]")) and tonumber(msg.reply_to_message_id) > 0 and is_JoinChannel(msg) then
			local num = Ramin:match("^سکوت (%d+) [روز]") or Ramin:match("^mute (%d+) [d]");
			if Ramin and Ramin:match("(%d+) ho") or Ramin:match("(%d+) روز") then
				time_match = Ramin:match("(%d+) ho") or Ramin:match("(%d+) روز");
				local time = time_match * day;
				result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
				local user = result.sender_id.user_id;
				if user then
					if tonumber(user) == tonumber(BotJoiner) then
						sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست! ", "html");
						return false;
					elseif SudUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر سودو ربات می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif OwnUserPlus(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر مالک ارشد گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif NazemUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر معاون گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "html");
						return false;
					elseif ModUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر ادمین گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
						return false;
					elseif VipUser(msg, user) then
						sendBot(msg.chat_id, msg.id, "⌯  کاربر عضو ویژه گروه می باشد دسترسی به سکوت کردن این کاربر را ندارید ! ", "md");
					else
						alpha = TD.getUser(user);
						if alpha.usernames.editable_username == "" then
							name = ec_name(alpha.first_name);
						else
							name = alpha.usernames.editable_username;
						end;
						if base:sismember(TD_ID .. "MuteList:" .. msg.chat_id, user) then
							sendBot(msg.chat_id, msg.id, "⌯  کاربر 〚<a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> - <code>" .. user .. "</code> 〛 در لیست سکوت می باشد !\n", "html");
						else
							reportowner("⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  <a href=\"tg://user?id=" .. user .. "\"> " .. ec_name(alpha.first_name) .. "</a> | `" .. user .. "`\n\n ⌯ به لیست سکوت اضافه شد !\n⌯ زمان ویژه : " .. getTimeUptime(time) .. "\n\nتوسط : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")");
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛 به مدت  (" .. getTimeUptime(time) .. ") به لیست سکوت اضافه شد !", "md");
							MuteUser(msg.chat_id, user, msg.date + time);
							base:sadd(TD_ID .. "MuteList:" .. msg.chat_id, user);
						end;
					end;
				end;
				function BDClearMute()
					alpha = TD.getUser(user);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					sendBot(msg.chat_id, msg.id, " ⌯  کاربر  〚[" .. name .. "](tg://user?id=" .. user .. ")- `" .. user .. "`〛از لیست سکوت حذف شد ! ", "md");
					base:srem(TD_ID .. "MuteList:" .. msg.chat_id, user);
					UnRes(msg.chat_id, user);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				TD.set_timer(time, BDClearMute);
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]$") or Ramin:match("^خفه رسانه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						mutemedia(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]$") or Ramin:match("^خفه رسانه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							mutemedia(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						mutemedia(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							mutemedia(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						mutemedia(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^سکوت رسانه (.*)$") or Ramin:match("^خفه رسانه (.*)$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				mutemedia(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه @(.*)$") or Ramin:match("^خفه رسانه @(.*)$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^سکوت رسانه @(.*)$") or Ramin:match("[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] @(.*)$") or Ramin:match("^خفه رسانه @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					mutemedia(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^سکوت رسانه (%d+)$") or Ramin:match("^خفه رسانه (%d+)$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^سکوت رسانه (%d+)$") or Ramin:match("^[Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] (%d+)$") or Ramin:match("^خفه رسانه (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				mutemedia(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت رسانه$") or Ramin:match("^حذف خفه رسانه$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] $")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						unmutemedia(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت رسانه$") or Ramin:match("^حذف خفه رسانه$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa] $")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							unmutemedia(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						unmutemedia(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							unmutemedia(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						unmutemedia(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف سکوت رسانه (.*)$") or Ramin:match("^حذف خفه رسانه (.*)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]  (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				unmutemedia(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت رسانه @(.*)$") or Ramin:match("^حذف خفه رسانه @(.*)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]  @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف سکوت رسانه @(.*)$") or Ramin:match("^حذف خفه رسانه @(.*)$") or Ramin:match("[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]  @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					unmutemedia(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت رسانه (%d+)$") or Ramin:match("^حذف خفه رسانه (%d+)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]  (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^حذف سکوت رسانه (%d+)$") or Ramin:match("^حذف خفه رسانه (%d+)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee][Mm][Ee][Dd][Ii][Aa]  (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				unmutemedia(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^سکوت$") or Ramin:match("^[Mm][Uu][Tt][Ee]$") or Ramin:match("^خفه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						mute(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^سکوت$") or Ramin:match("^[Mm][Uu][Tt][Ee]$") or Ramin:match("^خفه$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							mute(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						mute(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							mute(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						mute(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^سکوت (.*)$") or Ramin:match("^خفه (.*)$") or Ramin:match("^[Mm][Uu][Tt][Ee] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				mute(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^سکوت @(.*)$") or Ramin:match("^خفه @(.*)$") or Ramin:match("^[Mm][Uu][Tt][Ee] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^سکوت @(.*)$") or Ramin:match("[Mm][Uu][Tt][Ee] @(.*)$") or Ramin:match("^خفه @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					mute(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^سکوت (%d+)$") or Ramin:match("^خفه (%d+)$") or Ramin:match("^[Mm][Uu][Tt][Ee] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^سکوت (%d+)$") or Ramin:match("^[Mm][Uu][Tt][Ee] (%d+)$") or Ramin:match("^خفه (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				mute(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^mutelistes @(.*)$") or Ramin:match("^سکوت لیستی @(.*)$")) and is_ModMute(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin:match("^mutelistes @(.*)$") or Ramin:match("^سکوت لیستی @(.*)$");
			text = "⌯ کاربران زیر به لیست سکوت ها اضافه شد :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					MuteUser(msg.chat_id, result.id, 0);
					base:sadd(TD_ID .. "MuteList:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🅂 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text .. "", "html");
		end;
		if Ramin and (Ramin:match("^unmutelistes @(.*)$") or Ramin:match("^حذف سکوت لیستی @(.*)$")) and is_ModMute(msg.chat_id, msg.sender_id.user_id) then
			local inputz = Ramin:match("^unmutelistes @(.*)$") or Ramin:match("^حذف سکوت لیستی @(.*)$");
			text = "⌯ کاربران زیر از لیست سکوت ها حذف شدند :\n\n";
			for i in string.gmatch(inputz, "%S+") do
				taglist = i;
				result = TD.searchPublicChat(taglist);
				use = TD.getUser(result.id);
				if use.usernames.editable_username == "" then
					name = ec_name(use.first_name);
				else
					name = use.usernames.editable_username;
				end;
				if not result.id then
					text = "⌯ عملیات ناموفق !";
					break;
				else
					UnRes(msg.chat_id, result.id);
					base:srem(TD_ID .. "MuteList:" .. msg.chat_id, result.id);
					username = "<a href=\"tg://user?id=" .. result.id .. "\">" .. name .. "</a>";
					text = text .. "🅂 " .. username .. "-<code>" .. result.id .. "</code>\n";
				end;
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^حذف سکوت$") or Ramin:match("^حذف خفه$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						unmute(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت$") or Ramin:match("^حذف خفه$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee]$")) and tonumber(msg.reply_to_message_id) > 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							unmute(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						unmute(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							unmute(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						unmute(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف سکوت (.*)$") or Ramin:match("^حذف خفه (.*)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				unmute(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت @(.*)$") or Ramin:match("^حذف خفه @(.*)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local username = Ramin:match("^حذف سکوت @(.*)$") or Ramin:match("^حذف خفه @(.*)$") or Ramin:match("[Uu][Nn][Mm][Uu][Tt][Ee] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					unmute(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف سکوت (%d+)$") or Ramin:match("^حذف خفه (%d+)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModMute(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^حذف سکوت (%d+)$") or Ramin:match("^حذف خفه (%d+)$") or Ramin:match("^[Uu][Nn][Mm][Uu][Tt][Ee] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				unmute(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^افزودن تبچی$") or Ramin:match("^تبچی$") or Ramin:match("^[Ss][Ee][Tt][Tt][Aa][Bb][Cc][Hh][Ii]$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						tabchi(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^افزودن تبچی$") or Ramin:match("^تبچی$") or Ramin:match("^[Ss][Ee][Tt][Tt][Aa][Bb][Cc][Hh][Ii]$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							tabchi(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯ کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						tabchi(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							dofile("./checkuser.lua");
							tabchi(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						dofile("./checkuser.lua");
						tabchi(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^افزودن تبچی (.*)$") or Ramin:match("^تبچی (.*)$") or Ramin:match("^[Tt][Aa][Bb][Cc][Hh][Ii] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				tabchi(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^افزودن تبچی @(.*)$") or Ramin:match("^تبچی @(.*)$") or Ramin:match("^[Tt][Aa][Bb][Cc][Hh][Ii] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			local username = Ramin:match("^افزودن تبچی @(.*)$") or Ramin:match("^تبچی @(.*)$") or Ramin:match("[Tt][Aa][Bb][Cc][Hh][Ii] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					tabchi(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯ کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^افزودن تبچی (%d+)$") or Ramin:match("^تبچی (%d+)$") or Ramin:match("^[Tt][Aa][Bb][Cc][Hh][Ii] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			local idadad = Ramin:match("^افزودن تبچی (%d+)$") or Ramin:match("^تبچی (%d+)$") or Ramin:match("^[Tt][Aa][Bb][Cc][Hh][Ii] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				tabchi(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯ کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف تبچی$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii]$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					if res.content["@type"] == "messageDocument" or res.content["@type"] == "messageAudio" or res.content["@type"] == "messageVoiceNote" or res.content["@type"] == "messageSticker" or res.content["@type"] == "messageAnimation" or res.content["@type"] == "messagePhoto" or res.content["@type"] == "messageVideoNote" then
						dofile("./checkuser.lua");
						untabchi(msg, msg.chat_id, res.sender_id.user_id);
					end;
				end;
			end;
		end;
		if Ramin and (Ramin:match("^حذف تبچی$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii]$")) and tonumber(msg.reply_to_message_id) > 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			if not result.sender_id.user_id then
			else
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					res = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					text = res.content.text.text;
					if text:match("^@(.*)$") then
						local username = text:match("^@(.*)$");
						result = TD.searchPublicChat(username);
						if result.id then
							dofile("./checkuser.lua");
							untabchi(msg, msg.chat_id, result.id);
						else
							sendBot(msg.chat_id, msg.id, "⌯  کاربر  ▏  @" .. username .. " ▕ یافت نشد !", "md");
						end;
					elseif text:match("^(%d+)$") then
						local id = text:match("^(%d+)$");
						dofile("./checkuser.lua");
						untabchi(msg, msg.chat_id, tonumber(id));
					elseif res.content.text.entities[1] and res.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" then
						Ramin = TD.getUser(res.content.text.entities[1].type.user_id);
						if Ramin.id then
							untabchi(msg, msg.chat_id, Ramin.id);
						end;
						result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
					elseif result then
						untabchi(msg, msg.chat_id, result.sender_id.user_id);
					end;
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			end;
		end;
		if RaminEnti and (Ramin:match("^حذف تبچی (.*)$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii] (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) and is_JoinChannel(msg) then
			id = msg.content.text.entities[1].type.user_id;
			local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
			if res ~= 200 then
			end;
			statsurl = json:decode(url);
			if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
				dofile("./checkuser.lua");
				untabchi(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف تبچی @(.*)$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii] @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
			local username = Ramin:match("^حذف تبچی @(.*)$") or Ramin:match("[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii] @(.*)$");
			result = TD.searchPublicChat(username);
			if result.id then
				local url = https.request(Bot_Api .. "/getChatMember?chat_id=" .. msg.chat_id .. "&user_id=" .. BotJoiner);
				if res ~= 200 then
				end;
				statsurl = json:decode(url);
				if statsurl.ok == true and statsurl.result.status == "administrator" and statsurl.result.can_restrict_members == true then
					dofile("./checkuser.lua");
					untabchi(msg, msg.chat_id, result.id);
				else
					sendBot(msg.chat_id, msg.id, "✖️ *ربات به قسمت محرومیت کاربران  دسترسی ندارد*.", "md");
				end;
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ @" .. username .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^حذف تبچی (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Sudo(msg) then
			local idadad = Ramin:match("^حذف تبچی (%d+)$") or Ramin:match("^[Rr][Ee][Mm][Tt][Aa][Bb][Cc][Hh][Ii] (%d+)$");
			id = tonumber(idadad);
			result = TD.getUser(id);
			if result.first_name then
				dofile("./checkuser.lua");
				untabchi(msg, msg.chat_id, id);
			else
				sendBot(msg.chat_id, msg.id, " ⌯  کاربر  [ " .. id .. " ] یافت نشد !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^تبچی همنام (.*)$") or Ramin:match("^[Tt][Aa][Bb][Cc][Hh][Ii] (.*)$")) and is_Owner(msg) and is_OwnerPlus(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local text = Ramin:match("^تبچی همنام (.*)$");
			local results = TD.getSupergroupMembers(msg.chat_id, "Search", "", 0, 200);
			x = 0;
			if results.members then
				for x, v in pairs(results.members) do
					data = TD.getUser(v.member_id.user_id);
					if data.first_name:match("^(.*)" .. text .. "(.*)$") or data.first_name:match("^" .. text .. "(.*)$") or data.first_name:match("(.*)" .. text .. "$") then
						KickUser(msg.chat_id, v.member_id.user_id);
						TD.setChatMemberStatus(msg.chat_id, v.member_id.user_id, "banned");
						base:sadd("AGTMute:", v.member_id.user_id);
						base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, v.member_id.user_id);
					end;
				end;
			end;
			x = x + 1;
			sendBot(msg.chat_id, msg.id, "⌯  کاربرانی که با اسم " .. text .. " بودند در گروه به عنوان تبچی شناسایی شدند. ", "html");
		end;
		if Ramin == "اسکن تبچی" or Ramin == "scan tabchi" and is_Owner(msg) then
			local results = TD.getSupergroupMembers(msg.chat_id, "Search", "", 0, 200);
			if results.members then
				for x, v in pairs(results.members) do
					print(v.member_id.user_id);
					local data = TD.getUser(v.member_id.user_id);
					if data.first_name:match("^(.*)خاله(.*)$") or data.first_name:match("^(.*)حضوری(.*)$") or data.first_name:match("(.*)سکس(.*)$") or data.first_name:match("(.*)09(.*)$") or data.first_name:match("(.*)فال(.*)$") or data.first_name:match("(.*)سوپر(.*)$") or data.first_name:match("(.*)بیومو(.*)$") or data.first_name:match("(.*)کیر(.*)$") or data.first_name:match("(.*)کوص(.*)$") or data.first_name:match("(.*)کصلیس(.*)$") or data.first_name:match("(.*)کون(.*)$") or data.first_name:match("(.*)جووون(.*)$") or data.first_name:match("(.*)نرگس(.*)$") or data.first_name:match("(.*)لیلا(.*)$") or data.first_name:match("(.*)سمیه(.*)$") or data.first_name:match("(.*)شقایق(.*)$") or data.first_name:match("(.*)عسل(.*)$") or data.first_name:match("(.*)بیتا(.*)$") or data.first_name:match("(.*)سمیرا(.*)$") or data.first_name:match("(.*)مهسا(.*)$") or data.first_name:match("(.*)سولماز(.*)$") or data.first_name:match("(.*)مائده(.*)$") or data.first_name:match("(.*)مریم(.*)$") or data.first_name:match("(.*)فرشته(.*)$") or data.first_name:match("(.*)بانو(.*)$") or data.first_name:match("(.*)یلدا(.*)$") or data.first_name:match("(.*)شهوتم(.*)$") or data.first_name:match("(.*)🔴کنترل خانواده( هک گوشی )🔴(.*)$") or data.first_name:match("(.*)سکس حضوری و چت پی وی(.*)$") or data.first_name:match("(.*)تصویری(.*)$") or data.first_name:match("(.*)محدثه(.*)$") or data.first_name:match("(.*)زهرا(.*)$") or data.first_name:match("(.*)جوین شو(.*)$") or data.first_name:match("(.*)💋(.*)$") or data.first_name:match("(.*)خانوم(.*)$") or data.first_name:match("(.*)ارزو(.*)$") or data.first_name:match("(.*)ندا(.*)$") or data.first_name:match("(.*)حدیث(.*)$") or data.first_name:match("(.*)غزاله(.*)$") or data.first_name:match("(.*)کوثر(.*)$") or data.first_name:match("(.*)باران(.*)$") or data.first_name:match("(.*)نگین(.*)$") or data.first_name:match("(.*)محلا(.*)$") or data.first_name:match("(.*)جوون(.*)$") or data.first_name:match("(.*)جووون(.*)$") or data.first_name:match("(.*)جوووون(.*)$") or data.first_name:match("(.*)سمانه(.*)$") or data.first_name:match("(.*)ترانه(.*)$") or data.first_name:match("(.*)الناز(.*)$") or data.first_name:match("(.*)مهدیس(.*)$") or data.first_name:match("(.*)ارزو(.*)$") or data.first_name:match("(.*)مژگان(.*)$") or data.first_name:match("(.*)🙈(.*)$") or data.first_name:match("(.*)🙈(.*)$") or data.first_name:match("(.*)بهاره(.*)$") or data.first_name:match("(.*)سمانه(.*)$") or data.first_name:match("(.*)هانیه(.*)$") or data.first_name:match("(.*)مرضیه(.*)$") or data.first_name:match("(.*)مارال(.*)$") or data.first_name:match("(.*)دنیا(.*)$") or data.first_name:match("(.*)خدمات مجازی(.*)$") or data.first_name:match("(.*)بهناز(.*)$") or data.first_name:match("(.*)کیمیا(.*)$") or data.first_name:match("(.*)ستاره(.*)$") or data.first_name:match("(.*)مرجان(.*)$") or data.first_name:match("(.*)طیبه(.*)$") or data.first_name:match("(.*)ستایش(.*)$") or data.first_name:match("(.*)سحر(.*)$") or data.first_name:match("(.*)مبینا(.*)$") or data.first_name:match("(.*)مهدیس(.*)$") or data.first_name:match("(.*)کوثر(.*)$") or data.first_name:match("(.*)رویا(.*)$") or data.first_name:match("(.*)فرزانه(.*)$") or data.first_name:match("(.*)هک(.*)$") or data.first_name:match("(.*)سوپر(.*)$") or data.first_name:match("(.*)ممبر(.*)$") or data.first_name:match("(.*)فالور(.*)$") or data.first_name:match("(.*)فالوور(.*)$") or data.first_name:match("(.*)خدمات(.*)$") or data.first_name:match("(.*)کوص(.*)$") or data.first_name:match("(.*)کص(.*)$") or data.first_name:match("(.*)مفعول(.*)$") or data.first_name:match("(.*)مفعولم(.*)$") or data.first_name:match("(.*)فاعل(.*)$") or data.first_name:match("(.*)فاعلم(.*)$") or data.first_name:match("(.*)کص(.*)$") or data.first_name:match("(.*)هک(.*)$") or data.first_name:match("(.*)صیغه(.*)$") or data.first_name:match("(.*)لینکدونی(.*)$") or data.first_name:match("(.*)فرشته(.*)$") or data.first_name:match("(.*)گلی(.*)$") or data.first_name:match("(.*)ارام(.*)$") or data.first_name:match("(.*)حنیفه(.*)$") or data.first_name:match("(.*)سایه(.*)$") or data.first_name:match("(.*)sucker(.*)$") or data.first_name:match("(.*)fuck(.*)$") or data.first_name:match("(.*)hot(.*)$") or data.first_name:match("(.*)sexi(.*)$") or data.first_name:match("(.*)sexy(.*)$") or data.first_name:match("(.*)ass(.*)$") or data.first_name:match("(.*)pussy(.*)$") or data.first_name:match("(.*)dick(.*)$") or data.first_name:match("(.*)porn(.*)$") or data.first_name:match("(.*)hub(.*)$") or data.first_name:match("(.*)joon(.*)$") or data.first_name:match("(.*)Hot Girl(.*)$") or data.first_name:match("(.*)S e x y(.*)$") or data.first_name:match("(.*)American Girl(.*)$") or data.first_name:match("(.*)پایه(.*)$") or data.first_name:match("(.*)بزنگ(.*)$") or data.first_name:match("(.*)اوف(.*)$") or data.first_name:match("(.*)طلسم(.*)$") or data.first_name:match("(.*)دینا(.*)$") or data.first_name:match("(.*)کصکش(.*)$") or data.first_name:match("(.*)حنانه(.*)$") or data.first_name:match("(.*)مهسا(.*)$") or data.first_name:match("(.*)سارینا(.*)$") or data.first_name:match("(.*)نسترن(.*)$") or data.first_name:match("(.*)نیلوفر(.*)$") or data.first_name:match("(.*)هدیه(.*)$") then
						KickUser(msg.chat_id, v.member_id.user_id);
						TD.setChatMemberStatus(msg.chat_id, v.member_id.user_id, "banned");
						base:sadd("AGTMute:", v.member_id.user_id);
					end;
				end;
			end;
			sendBot(msg.chat_id, msg.id, "✧ درحال انجام عملیات ...\n\n◄ لطفا منتظر بمانید:", "html");
			function AGTMute()
				Keyboard = {
					{
						{
							text = "مشاهده لیست 📝",
							data = "bd:listtabchiscan:" .. msg.chat_id
						}
					},
					{
						{
							text = "⊴ بستن",
							data = "bd:closetabchilist:" .. msg.chat_id
						}
					}
				};
				AGTMute = base:scard("AGTMute:") or 0;
				AGTMuteNume = base:scard(TD_ID .. "AGTMuteNume:" .. msg.chat_id) or 0;
				TD.sendText(msg.chat_id, msg.id, " ⌯  عملیات اسکن تبچی انجام شد !\n\n┅┅━ ✦ ━┅┅\n\n⚙️ نتیجه شناسایی : \n\n✦ تعداد تبلیغگر شناسایی شده " .. Alpha(tostring(AGTMuteNume)) .. " می باشد !\n  ◄ جهت دیدن تبلیغگرهای شناسایی شده دکمه مشاهده لیست را کلیک کنید !", "html", false, false, false, false, TD.replyMarkup({
					type = "inline",
					data = Keyboard
				}));
			end;
			TD.set_timer(40, AGTMute);
		end;
		if Ramin and (Ramin:match("^پاکسازی لیست مسدود$") or Ramin:match("^پاکسازی لیست بن$") or Ramin:match("^[Cc][Ll][Ee][Aa][Nn] [Bb][Aa][Nn][Ll][Ii][Ss][Tt]$")) and tonumber(msg.reply_to_message_id) == 0 and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local results = TD.getSupergroupMembers(msg.chat_id, "Banned", "", 0, 200);
			if tonumber(results.total_count) == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست مسدود گروه خالی می باشد !", "md");
				local k = 0;
			else
				if results.members then
					for k, v in pairs(results.members) do
						UnRes(msg.chat_id, v.member_id.user_id);
						base:del(TD_ID .. "BanUser:" .. msg.chat_id);
					end;
				end;
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "┅┅━ گزارش ربات ━┅┅ \n\n⌯  کاربر " .. namee .. "  را در گروه " .. gp .. " پاکسازی لیست مسدود ارسال کرد.\n\n" .. tarikh .. "";
				sendBot(msg.chat_id, msg.id, "⌯ پاکسازی لیست مسدود با موفقیت انجام شد ! ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^پاکسازی لیست سیاه$") or Ramin:match("^[Cc][Ll][Ee][Aa][Nn] [Bb][Ll][Oo][Cc][Kk][Ll][Ii][Ss][Tt]$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local results = TD.getSupergroupMembers(msg.chat_id, "Banned", "", 0, 200);
			if tonumber(results.total_count) == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست سیاه گروه خالی می باشد !", "md");
				local k = 0;
			else
				if results.members then
					for k, v in pairs(results.members) do
						UnRes(msg.chat_id, v.member_id.user_id);
					end;
				end;
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "┅┅━ گزارش ربات ━┅┅ \n\n⌯  کاربر " .. namee .. "  را در گروه " .. gp .. " پاکسازی لیست سیاه ارسال کرد.\n\n" .. tarikh .. "";
				sendBot(msg.chat_id, msg.id, "⌯ لیست سیاه گروه با موفقیت پاکسازی شد ! ", "html");
			end;
		end;
		if (Ramin == "clean bots" or Ramin == "پاکسازی ربات ها") and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) and is_JoinChannel(msg) then
			local results = TD.getSupergroupMembers(msg.chat_id, "Bots", "", 0, 200);
			if tonumber(results.total_count) == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ هیچ رباتی در گروه یافت نشد !", "md");
				local k = 0;
			else
				if results.members then
					for k, v in pairs(results.members) do
						if tonumber(v.member_id.user_id) ~= tonumber(BotJoiner) then
							KickUser(msg.chat_id, v.member_id.user_id);
							TD.setChatMemberStatus(msg.chat_id, v.member_id.user_id, "banned");
						end;
					end;
				end;
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "┅┅━ گزارش ربات ━┅┅ \n\n⌯  کاربر " .. namee .. "  پاکسازی ربات ها را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
				sendBot(msg.chat_id, msg.id, "⌯ تمام ربات هایی ک در گروه ادمین نبودند ، اخراج شدند . ", "html");
			end;
		end;
		if Ramin == "clean msg" or Ramin == "cgmall" or Ramin == "پاکسازی پیام ها" or Ramin == "پاکسازی پیام" or Ramin == "پاکسازی کلی" and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			Keyboard = {
				{
					{
						text = "✅ بله ، انجام بده .",
						data = "bd:cleanbale:" .. msg.chat_id
					}
				},
				{
					{
						text = "✖️ لغو عملیات",
						data = "bd:cleanna:" .. msg.chat_id
					}
				}
			};
			TD.sendText(msg.chat_id, msg.id, " ⚠️همه پیام های گروه پاکسازی خواهند شد ، این دستور برگشت ناپذیر است . \n\n◄ آیا از پاکسازی کلی پیام ها اطمینان دارید ؟", "html", false, false, false, false, TD.replyMarkup({
				type = "inline",
				data = Keyboard
			}));
		end;
		if Ramin == "clean mutelist" or Ramin == "پاکسازی لیست سکوت" and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local results = TD.getSupergroupMembers(msg.chat_id, "Restricted", "", 0, 200);
			if tonumber(results.total_count) == 0 then
				sendBot(msg.chat_id, msg.id, "⌯ لیست سکوت گروه خالی می باشد !", "md");
				base:del(TD_ID .. "MuteList:" .. msg.chat_id);
				local k = 0;
			else
				if results.members then
					for k, v in pairs(results.members) do
						UnRes(msg.chat_id, v.member_id.user_id);
						base:del(TD_ID .. "MuteList:" .. msg.chat_id);
					end;
				end;
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "┅┅━ گزارش ربات ━┅┅ \n\n⌯  کاربر " .. namee .. "  پاکسازی لیست سکوت را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
				sendBot(msg.chat_id, msg.id, "⌯ لیست سکوت با موفقیت پاکسازی شد ! ", "html");
			end;
		end;
		if Ramin == "clean mutemedialist" or Ramin == "پاکسازی لیست سکوت رسانه" and is_ModClean(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "MuteMediaList:" .. msg.chat_id);
			local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
			alpha = TD.getUser(msg.sender_id.user_id);
			if alpha.usernames.editable_username == "" then
				name = ec_name(alpha.first_name);
			else
				name = alpha.usernames.editable_username;
			end;
			local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
			local gp = (TD.getChat(msg.chat_id)).title;
			text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯  کاربر  " .. namee .. "  پاکسازی لیست سکوت رسانه را در گروه " .. gp .. " ارسال کرد.\n\n" .. tarikh .. "";
			sendBot(msg.chat_id, msg.id, "⌯ پاکسازی لیست سکوت رسانه با موفقیت انجام شد ! ", "html");
		end;
		if Ramin and (Ramin:match("^age (%d+) (%d+) (%d+)$") or Ramin:match("^محاسبه سن (%d+) (%d+) (%d+)$")) then
			local CmdEn = {
				string.match(Ramin, "^(age) (%d+) (%d+) (%d+)$")
			};
			local CmdFa = {
				string.match(Ramin, "^(محاسبه سن) (%d+) (%d+) (%d+)$")
			};
			y = CmdEn[2] or CmdFa[2];
			m = CmdEn[3] or CmdFa[3];
			d = CmdEn[4] or CmdFa[4];
			local url, res = https.request("https://api.codebazan.ir/age/?year=" .. y .. "&month=" .. m .. "&day=" .. d);
			if res ~= 200 then
				return TD.sendText(msg.chat_id, msg.id, "⌯ مشکلی در وب سرویس ایجاد شده است !", "md");
			end;
			local jdat = JSON.decode(url);
			text = "🔍 سن دقیق شما امروز " .. jdat.result.year .. " سال، " .. jdat.result.month .. " ماه و " .. jdat.result.day .. " روز است.\n\n🔹 شما امروز " .. jdat.result.days .. " روزه هستید.\n\n🐲 شما در سال " .. jdat.result.year_name .. " متولد شدید.\n\n┅┅━ ✦ ━┅┅\n\n🀄️ نماد ماه تولدتان " .. jdat.result.month_nemad .. " است.\n\n☑️ " .. jdat.result.to_birth .. " روز دیگر تولد شماست.\n\n🌐 تاریخ تولد شما به میلادی : " .. jdat.result.birthmiladi .. "\n\n🌀 تاریخ تولد شما به هجری قمری : " .. jdat.result.birthghamari .. "\n\n🔅 شما در روز " .. jdat.result.birth_day .. " و در فصل " .. jdat.result.birth_season .. " به دنیا آمدید.\n\n";
			TD.sendText(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin and (Ramin:match("^[Mm][Ee][Aa][Nn][Ss] (.*)") or Ramin:match("^معنی (.*)")) then
			local TEXT = Ramin:match("^[Mm][Ee][Aa][Nn][Ss] (.*)") or Ramin:match("^معنی (.*)");
			local url, res = https.request("https://api.codebazan.ir/vajehyab/?text=" .. URL.escape(TEXT));
			if res ~= 200 then
				return TD.sendText(msg.chat_id, msg.id, "⌯ مشکلی در وب سرویس ایجاد شده است !", "md");
			end;
			local jdat = JSON.decode(url);
			if jdat and jdat.result then
				if jdat.result.fa and jdat.result.fa ~= "" then
					fa = jdat.result.fa;
				else
					fa = "-----";
				end;
				if jdat.result.en and jdat.result.en ~= "" then
					en = jdat.result.en;
				else
					en = "-----";
				end;
				if jdat.result.dic and jdat.result.dic ~= "" then
					dic = "\n" .. jdat.result.dic;
				else
					dic = "-----";
				end;
				if jdat.result.mani and jdat.result.mani ~= "" then
					mani = "\n" .. jdat.result.mani;
				else
					mani = "-----";
				end;
				if jdat.result.Fmoein and jdat.result.Fmoein ~= "" then
					Fmoein = "\n" .. jdat.result.Fmoein;
				else
					Fmoein = "-----";
				end;
				if jdat.result.Fdehkhoda and jdat.result.Fdehkhoda ~= "" then
					Fdehkhoda = "\n" .. jdat.result.Fdehkhoda;
				else
					Fdehkhoda = "-----";
				end;
				if jdat.result.motaradefmotezad and jdat.result.motaradefmotezad ~= "" then
					motaradefmotezad = jdat.result.motaradefmotezad;
				else
					motaradefmotezad = "-----";
				end;
				TD.sendText(msg.chat_id, msg.id, "⌯ کلمه فارسی : " .. fa .. "\n\n⌯ کلمه انگلیسی : " .. en .. "\n\n⌯ دیکشنری : " .. dic .. "\n\n⌯ معنی : " .. mani .. "\n\n⌯ فرهنگ نامه معین : " .. Fmoein .. "\n\n⌯ فرهنگ نامه دهخدا : " .. Fdehkhoda .. "\n\n⌯ مترادف : " .. motaradefmotezad .. "\n", "html");
			else
				TD.sendText(msg.chat_id, msg.id, "⌯ متاسفانه داده ای در دسترس نمیباشد ▸", "html");
			end;
		end;
		if Ramin == "arz" or Ramin == "نرخ ارز" or Ramin == "ارز" then
			local url, res = https.request("https://api.codebazan.ir/arz/?type=arz");
			if res ~= 200 then
				sendBot(msg.chat_id, msg.id, "⌯ مشکلی در وب سرویس ایجاد شده است ", "html");
			end;
			local jdat = JSON.decode(url);
			local text = "";
			for i = 1, #jdat do
				text = text .. "🏵 نوع : " .. jdat[i].name .. "\n💰 قیمت : " .. jdat[i].price .. "\n📊 تغییر : " .. jdat[i].change .. "\n⌯ درصد : " .. jdat[i].percent .. "\n\n";
			end;
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin == "time" or Ramin == "زمان" or Ramin == "تاریخ" then
			local url, res = https.request("https://api.keybit.ir/time/");
			if res ~= 200 then
				sendBot(msg.chat_id, msg.id, "⌯ مشکلی در وب سرویس ایجاد شده است ", "html");
			end;
			local jdat = JSON.decode(url);
			local test = "ببر";
			text = "⌯  یونیکس تایم : " .. jdat.unix.fa .. "\n⌯  منطقه زمانی : " .. jdat.timezone.name .. " " .. jdat.timezone.number.fa .. "\n⌯  ماه فصل : " .. jdat.season.name .. "(" .. jdat.date.month.name .. ")\n⌯  ساعت فعلی : " .. jdat.time24.full.fa .. " " .. jdat.time12.shift.full .. " \n⌯  تاریخ : " .. jdat.date.full.official.usual.fa .. " " .. jdat.date.weekday.name .. "\n─┅━━━━━━┅─\n\n📆 تاریخ میلادی : " .. jdat.date.other.gregorian.usual.fa .. "\n📂 تاریخ قمری : " .. jdat.date.other.ghamari.usual.fa .. "\n🐅 حیوان سال: " .. test .. "\n💢 درصد طی شده سال : " .. jdat.date.year.agone.percent.fa .. "% - " .. jdat.date.year.left.percent.fa .. "%\n🔹 تعداد روز باقی سال : " .. jdat.date.year.left.days.fa .. " روز\n\n─┅━🄰🄿🄸━┅─\n\n🆔 " .. Channel .. "\n\n";
			sendBot(msg.chat_id, msg.id, text, "html");
		end;
		if Ramin == "نصب" or Ramin == "تگ" or Ramin == "پنل تگ" then
			local results = TD.getSupergroupMembers(msg.chat_id, "Recent", "", 0, 200);
			for k, v in pairs(results.members) do
				if tonumber(v.member_id.user_id) ~= tonumber(Sudoid) then
					result = TD.getUser(v.member_id.user_id);
					if not result.first_name then
						username = v.user_id;
					elseif result.first_name ~= "" then
						username = StringData(result.first_name);
					else
						username = StringData(result.usernames.editable_username);
					end;
					base:zincrby(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 1, v.member_id.user_id);
					base:set(TD_ID .. "UserName:" .. v.member_id.user_id, StringData(result.first_name));
					base:set(TD_ID .. "FirstName:" .. v.member_id.user_id, StringData(result.usernames.editable_username));
				end;
			end;
		end;
		if Ramin and (Ramin:match("^setflood (%d+)$") or Ramin:match("^تعدادفلود (%d+)$") or Ramin:match("^تعداد فلود (%d+)$") or Ramin:match("^تعداد رگبار (%d+)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^setflood (%d+)") or Ramin:match("^تعدادفلود (%d+)") or Ramin:match("^تعداد فلود (%d+)") or Ramin:match("^تعداد رگبار (%d+)");
			if tonumber(num) < 2 then
				sendBot(msg.chat_id, msg.id, "⌯ عددی بزرگتر از *2* بکار ببرید", "md");
			else
				base:set(TD_ID .. "Flood:Max:" .. msg.chat_id, num);
				sendBot(msg.chat_id, msg.id, " ⌯ حداکثر پیام مکرر تنظیم شد به : " .. num .. " ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^setforcemax (%d+)$") or Ramin:match("^تعدادافزودن اجباری (%d+)$") or Ramin:match("^تعداد افزودن اجباری (%d+)$") or Ramin:match("^تعداد اد اجباری (%d+)$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^setforcemax (%d+)") or Ramin:match("^تعدادافزودن اجباری (%d+)") or Ramin:match("^تعداد افزودن اجباری (%d+)$") or Ramin:match("^تعداد اد اجباری (%d+)$");
			if tonumber(num) < 2 then
				sendBot(msg.chat_id, msg.id, "⌯ عددی بزرگتر از *۲* بکار ببرید", "md");
			else
				base:set(TD_ID .. "Force:Max:" .. msg.chat_id, num);
				sendBot(msg.chat_id, msg.id, " ⌯ حداکثر عضو تنظیم شد به : " .. num .. " ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^حداکثر اخطار (%d+)$") or Ramin:match("^تعداد اخطار (%d+)$") or Ramin and Ramin:match("^[Ss][Ee][Tt][Ww][Aa][Rr][Nn] (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_JoinChannel(msg) and is_ModWarn(msg.chat_id, msg.sender_id.user_id) then
			local num = tonumber(Ramin:match("^حداکثر اخطار (%d+)$")) or tonumber(Ramin:match("^تعداد اخطار (%d+)$")) or tonumber(Ramin:match("^[Ss][Ee][Tt][Ww][Aa][Rr][Nn] (%d+)$"));
			if num < 3 then
				sendBot(msg.chat_id, msg.id, " ⌯ حداقل مقدار اخطار باید بیشتر از 2 باشد ! ", "html");
			elseif num > 10 then
				sendText(msg.chat_id, msg.id, "⌯ حداکثر مقدار اخطار باید کمتر از 10 باشد ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, "⌯ سقف مجاز اخطار تنظیم شد به : " .. num .. " عدد ! ", "html");
				base:hset(TD_ID .. "warn" .. msg.chat_id, "warnmax", num);
			end;
		end;
		if Ramin and (Ramin:match("^setspam (%d+)$") or Ramin:match("^تعدادحروف (%d+)$") or Ramin:match("^تنظیم کاراکتر (%d+)$") or Ramin:match("^تعداد حروف (%d+)$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^setspam (%d+)") or Ramin:match("^تعدادحروف (%d+)") or Ramin:match("^تنظیم کاراکتر (%d+)$") or Ramin:match("^تعداد حروف (%d+)$");
			if tonumber(num) < 1 then
				sendBot(msg.chat_id, msg.id, "⌯ عددی بزرگتر از *1* بکار ببرید", "md");
			elseif tonumber(num) > 4096 then
				sendBot(msg.chat_id, msg.id, "⌯ عددی کوچکتر از *4096* را بکار ببرید", "md");
			else
				base:set(TD_ID .. "NUM_CH_MAX:" .. msg.chat_id, num);
				sendBot(msg.chat_id, msg.id, " ⌯ حساسیت قفل اسپم  به :" .. num .. "کاراکتر تنظیم شد . ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^setfloodtime (%d+)$") or Ramin:match("^زمان فلود (%d+)$") or Ramin:match("^زمان رگبار (%d+)$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local num = Ramin:match("^setfloodtime (%d+)") or Ramin:match("^زمان فلود (%d+)") or Ramin:match("^زمان رگبار (%d+)$");
			if tonumber(num) < 2 then
				sendBot(msg.chat_id, msg.id, "⌯ زمان بررسی باید بیشتر از *1* باشد", "md");
			else
				base:set(TD_ID .. "Flood:Time:" .. msg.chat_id, num);
				sendBot(msg.chat_id, msg.id, " ⌯ زمان بررسی پیام رگباری  به : " .. num .. "تنظیم شد . ", "html");
			end;
		end;
		if (Ramin == "welcome on" or Ramin == "خوشامدگویی فعال" or Ramin == "خوشامد فعال" or Ramin == "خوشآمد فعال" or Ramin == "خوشامد روشن") and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Welcomeon") then
				sendBot(msg.chat_id, msg.id, " ⌯ خوش امدگویی گروه فعال بود . ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ خوش امدگویی گروه با موفقیت فعال شد . ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  خوش آمدگویی را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "Welcomeon");
			end;
		end;
		if (Ramin == "welcome off" or Ramin == "خوشامدگویی غیرفعال" or Ramin == "خوشامد غیرفعال" or Ramin == "خوشآمد غیرفعال" or Ramin == "خوشامد خاموش") and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Welcomeon") then
				sendBot(msg.chat_id, msg.id, "⌯ خوش امدگویی گروه غیرفعال شد . ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  خوش آمدگویی را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "Welcomeon");
			else
				sendBot(msg.chat_id, msg.id, "⌯ خوش امدگویی گروه غیرفعال بود . ", "html");
			end;
		end;
		if (Ramin == "lock porn" or Ramin == "قفل پورن") and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
			if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ هیچ اعتباری از بابت قفل پورن تنظیم نشده است", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornNew") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل پورن فعال می باشد ! ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  قفل پورن را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل پورن فعال شد ! ", "html");
				base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornNew");
			end;
		end;
		if (Ramin == "unlock porn" or Ramin == "بازکردن پورن") and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
			if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ هیچ اعتباری از بابت قفل پورن تنظیم نشده است", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornNew") then
				sendBot(msg.chat_id, msg.id, " ⌯ قفل پورن غیرفعال شد ! ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  قفل پورن را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornNew");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل پورن غیرفعال می باشد ! ", "html");
			end;
		end;
		if (Ramin == "lock porn all" or Ramin == "قفل پورن همه") and is_Owner(msg) and is_OwnerPlus(msg) then
			if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ هیچ اعتباری از بابت قفل پورن تنظیم نشده است", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. chat_id, "Lock:PornAdmin") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل پورن همه فعال می باشد ! ", "html");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل همه پورن فعال شد ! ", "html");
				base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornAdmin");
			end;
		end;
		if (Ramin == "lock porn manual" or Ramin == "قفل پورن عادی") and is_Owner(msg) and is_OwnerPlus(msg) then
			if not base:get((TD_ID .. "SvPorn" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ هیچ اعتباری از بابت قفل پورن تنظیم نشده است", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornAdmin") then
				sendBot(msg.chat_id, msg.id, " ⌯ قفل پورن عادی فعال شد ! ", "html");
				base:srem(TD_ID .. "Gp:" .. msg.chat_id, "Lock:PornAdmin");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل پورن عادی فعال می باشد ! ", "html");
			end;
		end;
		if (Ramin == "player on" or Ramin == "پلیر فعال") and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
			if not base:get((TD_ID .. "Svplayer" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ پلیر در گروه شما فعال نیست ! \n◄ جهت فعالسازی ، از قسمت پنل موزیکال اقدام به درخواست پلیر نمایید .", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "on:player") then
				sendBot(msg.chat_id, msg.id, "⌯ پلیر از قبل فعال می باشد ! ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "  موزیکال را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
			else
				sendBot(msg.chat_id, msg.id, " ⌯ پلیر با موفقیت فعال شد ! ", "html");
				base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "on:player");
			end;
		end;
		if (Ramin == "player off" or Ramin == "پلیر غیرفعال") and is_Owner(msg) and is_OwnerPlus(msg) and is_JoinChannel(msg) then
			if not base:get((TD_ID .. "Svplayer" .. msg.chat_id)) then
				sendBot(msg.chat_id, msg.id, " ⌯ اعتباری برای پلیر تنظیم نشده است !", "html");
				return;
			elseif base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "on:player") then
				sendBot(msg.chat_id, msg.id, " ⌯ پلیر با موفقیت غیرفعال شد ! ", "html");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر  " .. namee .. "   موزیکال را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:srem(TD_ID .. "Gp:" .. msg.chat_id, "on:player");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ پلیر از قبل غیرفعال می باشد ! ", "html");
			end;
		end;
		if Ramin == "تگ همه" or Ramin == "tagall" or Ramin == "تا چند ثانیه دیگر همه کاربران گروه تگ خواهند شد ..!" then
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 1, 5, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 6, 11, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 12, 17, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = "[" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 18, 23, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 24, 29, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 30, 35, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 36, 41, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = "[" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 37, 42, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 43, 48, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 49, 54, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 55, 60, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 70, 75, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 80, 85, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 90, 95, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 96, 101, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 102, 106, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 107, 112, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 150, 160, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 200, 210, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 300, 310, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 400, 410, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
			local stats = base:zrevrange(TD_ID .. "bot:msgusr2:" .. msg.chat_id .. ":", 500, 510, "withscores");
			stattextss = "";
			for k, v in pairs(stats) do
				local namee = base:get(TD_ID .. "UserName:" .. v[1]) or v[1];
				user_info = " [" .. namee .. "](tg://user?id=" .. v[1] .. ") ＃ ";
				stattextss = stattextss .. user_info .. "";
			end;
			sendBot(msg.chat_id, msg.id, "" .. stattextss, "md");
		end;
		if Ramin == "تگ مدیران" or Ramin == "tagadmin" and is_ModPanelCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			list = base:smembers(TD_ID .. "ModList:" .. chat_id);
			t = "⌯ مدیران گروه اعلام حضور کنند :\n\n";
			for k, v in pairs(list) do
				username = base:get(TD_ID .. "UserName:" .. v) or base:get(TD_ID .. "FirstName:" .. v);
				if username then
					t = t .. "＃ [" .. username .. "](tg://user?id=" .. v .. ") ＃  ";
				else
					t = t .. "-[" .. v .. "](tg://user?id=" .. v .. ") | ";
				end;
			end;
			sendBot(msg.chat_id, msg.reply_to_message_id, t, "md");
		end;
		if Ramin == "تگ ویژه" or Ramin == "tagvip" and is_ModPanelCmd(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			list = base:smembers(TD_ID .. "Vip:" .. chat_id);
			t = "⌯ اعضای ویژه گروه به شرح زیر می باشد  :\n\n";
			for k, v in pairs(list) do
				t = t .. "-[" .. v .. "](tg://user?id=" .. v .. ") ＃ ";
			end;
			sendBot(msg.chat_id, msg.reply_to_message_id, t, "md");
		end;
		if Ramin == "forceadd on" or Ramin == "افزودن اجباری فعال" or Ramin == "اد اجباری فعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "force_NewUser") then
				typeadd = " اد اجباری بر روی کاربران جدید تنظیم شده است.";
			else
				typeadd = " اد اجباری بر روی تمامی کاربران تنظیم شده است.";
			end;
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل *اد اجباری* فعال بود .\n\n⌯ *وضعیت* : " .. typeadd, "md");
			else
				sendBot(msg.chat_id, msg.id, "⌯ قفل *اد اجباری* فعال شد .\n⌯ تعداد اخطار پیام اد : *" .. Forcepm .. "* بار\n⌯ تعداد اد اجباری  : *" .. Forcemax .. "* نفر\n*⌯ وضعیت * : " .. typeadd, "md");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  اد اجباری را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd");
			end;
		end;
		if Ramin == "forceadd off" or Ramin == "افزودن اجباری غیرفعال" or Ramin == "اد اجباری غیرفعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd") then
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  اد اجباری را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				sendBot(msg.chat_id, msg.id, "⌯ قفل *اد اجباری* غیرفعال شد .", "md");
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd");
				base:del(TD_ID .. "test:" .. msg.chat_id);
				base:del(TD_ID .. "Force:Pm:" .. msg.chat_id);
				base:del(TD_ID .. "Force:Max:" .. msg.chat_id);
			else
				sendBot(msg.chat_id, msg.id, "⌯ قفل *اد اجباری* غیرفعال بود !", "md");
			end;
		end;
		local CH = base:get(TD_ID .. "setch:" .. msg.chat_id) or "..Channel..";
		if Ramin == "forcejoin on" or Ramin == "جوین اجباری فعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:get(TD_ID .. "setch:" .. msg.chat_id) then
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin") then
					sendBot(msg.chat_id, msg.id, "⌯ قفل جوین اجباری فعال بود !\n\n⌯ کانال جوین اجباری :@" .. CH .. "", "md");
				else
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  جوین اجباری را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(msg.chat_id, msg.id, "⌯ قفل جوین اجباری فعال شد .\n\n[جهت عملکرد عضویت اجباری باید ربات زیر را در کانال خود ادمین کنید\n 🆔 : " .. UserJoiner .. "]\n\n⌯ کانال جوین اجباری :@" .. CH .. "", "md");
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin");
				end;
			else
				sendBot(msg.chat_id, msg.id, "انجام نشد ✖️\nکانال شما تنظیم نشده است ابتدا با دستور (تنظیم کانال channel ) یا (setch channel ) کانال خود را تنظیم کنید سپس اقدام به فعال کردن جوین اجباری کنید.", "md");
			end;
		end;
		if Ramin == "forcejoin off" or Ramin == "جوین اجباری غیرفعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin") then
				sendBot(msg.chat_id, msg.id, "⌯ قفل جوین اجباری غیرفعال شد !", "md");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  جوین اجباری را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoin");
			else
				sendBot(msg.chat_id, msg.id, " ⌯ قفل جوین اجباری غیرفعال بود !", "md");
			end;
		end;
		local CH = base:get(TD_ID .. "setch:" .. msg.chat_id) or "..Channel..";
		if Ramin == "forcejoin on" or Ramin == "جوین اجباری لیستی فعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:get(TD_ID .. "setch:" .. msg.chat_id) then
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoineee") then
					sendBot(msg.chat_id, msg.id, " ⌯ قفل جوین اجباری فعال بود !\n\n⌯ کانال جوین اجباری :@" .. CH .. "", "md");
				else
					local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
					alpha = TD.getUser(msg.sender_id.user_id);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
					local gp = (TD.getChat(msg.chat_id)).title;
					text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  جوین اجباری را در گروه " .. gp .. " فعال کرد.\n\n" .. tarikh .. "";
					reportowner(text);
					sendBot(msg.chat_id, msg.id, "⌯ قفل جوین اجباری فعال شد !\n\n[جهت عملکرد عضویت اجباری باید ربات زیر را در کانال خود ادمین کنید\n 🆔 : " .. UserJoiner .. "]\n\n⌯ کانال جوین اجباری :@" .. CH .. "", "md");
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoineee");
				end;
			else
				sendBot(msg.chat_id, msg.id, "انجام نشد ✖️\nکانال شما تنظیم نشده است ابتدا با دستور (تنظیم کانال channel ) یا (setch channel ) کانال خود را تنظیم کنید سپس اقدام به فعال کردن جوین اجباری کنید.", "md");
			end;
		end;
		if Ramin == "forcejoin off" or Ramin == "جوین اجباری لیستی غیرفعال" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoineee") then
				sendBot(msg.chat_id, msg.id, " ⌯ قفل جوین اجباری غیرفعال شد !", "md");
				local tarikh = jdate("\n⌯ امروز #x\n⌯  تاریخ: #Y/#M/#D\n⌯ ساعت: #h:#m:#s");
				alpha = TD.getUser(msg.sender_id.user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local namee = "<a href=\"tg://user?id=" .. msg.sender_id.user_id .. "\"> " .. name .. "</a> ";
				local gp = (TD.getChat(msg.chat_id)).title;
				text = "⌯ ┅┅━━ گزارش ربات ━━┅┅ ⌯ \n\n⌯ کاربر " .. namee .. "  جوین اجباری را در گروه " .. gp .. " غیرفعال کرد.\n\n" .. tarikh .. "";
				reportowner(text);
				base:srem(TD_ID .. "Gp2:" .. msg.chat_id, "forcejoineee");
			else
				sendBot(msg.chat_id, msg.id, "⌯ قفل جوین اجباری غیرفعال بود !", "md");
			end;
		end;
		if Ramin and (Ramin:match("^setch (.*)") or Ramin:match("^تنظیم کانال (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local CH = Ramin:match("^setch (.*)") or Ramin:match("^تنظیم کانال (.*)");
			base:set(TD_ID .. "setch:" .. msg.chat_id, CH);
			sendBot(msg.chat_id, msg.id, "⌯ کانال تنظیم شد به :\n\n @" .. CH .. "", "html");
		end;
		if Ramin1 and (Ramin1:match("^[Rr]emwelcome$") or Ramin1:match("^حذف خوشامدگویی$") or Ramin1:match("^حذف خوشامد$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Text:Welcome:" .. msg.chat_id);
			base:del(TD_ID .. "Text:WelcomeGif:" .. msg.chat_id);
			base:del(TD_ID .. "gif" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ پیام خوش امدگویی با موفقیت حذف شد.", "md");
		end;
		if Ramin and (Ramin:match("^setrank (.*)$") or Ramin:match("^تنظیم لقب (.*)$")) and tonumber(msg.reply_to_message_id) ~= 0 and is_Owner(msg) then
			local rank = Ramin:match("^setrank (.*)$") or Ramin:match("^تنظیم لقب (.*)$");
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			if user then
				if tonumber(user) == tonumber(BotJoiner) then
					sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست!", "md");
					return false;
				end;
				if tonumber(user) == Config.Sudoid then
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  عزیز من به بابای خودم نمیتونم مقام بدم !", "md");
					return false;
				end;
				base:set(TD_ID .. "rank" .. msg.chat_id .. user, rank);
				base:sadd("rank:" .. msg.chat_id, user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ مقام کاربر : <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a>  [" .. rank .. "] ثبت شد ! ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^delrank$") or Ramin:match("^حذف لقب$")) and tonumber(msg.reply_to_message_id) ~= 0 and is_Owner(msg) then
			local rank = Ramin:match("^delrank$") or Ramin:match("^حذف لقب$");
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			if user then
				base:del(TD_ID .. "rank" .. msg.chat_id .. user);
				base:srem("rank:" .. msg.chat_id, user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ لقب کاربر : <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a>  با موفقیت حذف شد ! ", "html");
			end;
		end;
		if Ramin == "setasle" or Ramin == "تنظیم اصل" or Ramin == "تایید اصل" and tonumber(msg.reply_to_message_id) ~= 0 then
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			asle = ALPHA.content.text.text;
			if user then
				if tonumber(user) == tonumber(BotJoiner) then
					sendBot(msg.chat_id, msg.id, "❎ اجرای دستور بر روی خودم امکان پذیر نیست!", "md");
					return false;
				end;
				if tonumber(user) == Config.Sudoid then
					sendBot(msg.chat_id, msg.id, "⌯ کاربر  عزیز من به بابای خودم نمیتونم مقام بدم !", "md");
					return false;
				end;
				base:set(TD_ID .. "asleuser:" .. user, asle);
				base:sadd("asleuser:", user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ مشخصات اصل کاربر <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> تنظیم شد ! ", "html");
			end;
		end;
		if Ramin and (Ramin:match("^delasle$") or Ramin:match("^حذف اصل$")) and tonumber(msg.reply_to_message_id) ~= 0 then
			local rank = Ramin:match("^delasle$") or Ramin:match("^حذف اصل$");
			ALPHA = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			local user = ALPHA.sender_id.user_id;
			if user then
				base:del(TD_ID .. "asleuser:" .. user);
				base:srem("asleuser:", user);
				base:del(TD_ID .. "Asle:Media:" .. user);
				alpha = TD.getUser(user);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				sendBot(msg.chat_id, msg.id, "⌯ مشخصات کاربر <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> حذف شد! ", "html");
			end;
		end;
		if Ramin1 and Ramin1:match("^[Ss]etkheyanat (.*)") and is_Owner(msg) and is_JoinChannel(msg) then
			local input = {
				string.match(Ramin1, "^([Ss]etkheyanat) (.*)$")
			};
			if input[2] == "اخراج" or input[2] == "adminkick" then
				base:set(TD_ID .. "kheyanat_stats" .. msg.chat_id, "kick");
				sendBot(msg.chat_id, msg.id, "⌯ حالت خیانت ادمین ها تنظیم شده به : عزل + اخراج", "html");
			elseif input[2] == "سکوت" or input[2] == "adminmute" then
				base:set(TD_ID .. "kheyanat_stats" .. msg.chat_id, "silent");
				sendBot(msg.chat_id, msg.id, "⌯ حالت خیانت ادمین ها تنظیم شده به : عزل + سکوت", "html");
			elseif input[2] == "عزل" or input[2] == "admindemote" then
				base:set(TD_ID .. "kheyanat_stats" .. msg.chat_id, "delmsg");
				sendBot(msg.chat_id, msg.id, "⌯ حالت خیانت ادمین ها تنظیم شده به : عزل عادی", "html");
			end;
		end;
		if Ramin1 and (Ramin1:match("^[Ss]etWarn (.*)") or Ramin1:match("^حالت اخطار (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local input = {
				string.match(Ramin1, "^(حالت اخطار) (.*)$")
			};
			if input[2] == "اخراج" then
				base:set(TD_ID .. "warn_stats" .. msg.chat_id, "kick");
				sendBot(msg.chat_id, msg.id, "⌯ حالت اخطار  به حالت <code>اخراج</code> تغییر یافت.", "html");
			elseif input[2] == "سکوت" then
				base:set(TD_ID .. "warn_stats" .. msg.chat_id, "silent");
				sendBot(msg.chat_id, msg.id, "⌯ حالت اخطار به حالت <code>سکوت</code> تغییر یافت.", "html");
			elseif input[2] == "سکوت زمانی" then
				base:set(TD_ID .. "warn_stats" .. msg.chat_id, "silenttime");
				local ex = tonumber(base:get(TD_ID .. "mutetime:" .. msg.chat_id) or 3600);
				local Time_ = getTimeUptime(ex);
				sendBot(msg.chat_id, msg.id, "⌯ حالت اخطار  به سکوت زمانی به مدت <b>" .. Time_ .. " </b> تغییر یافت .", "html");
			end;
		end;
		if (Ramin == "reaction add new" or Ramin == "وضعیت اد اجباری جدید" or Ramin == "وضعیت افزودن اجباری جدید" or Ramin == "setaddnew") and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:set(TD_ID .. "ReactionAdd:" .. msg.chat_id, msg.date);
			TD.sendText(msg.chat_id, msg.id, "⌯ اد اجباری برای اعضای جدید فعال شد ! ", "md");
		end;
		if Ramin == "reaction add all" or Ramin == "وضعیت اد اجباری همه" or Ramin == "وضعیت افزودن اجباری همه" or Ramin == "setaddall" and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "ReactionAdd:" .. msg.chat_id);
			TD.sendText(msg.chat_id, msg.id, "⌯ اد اجباری برای همه اعضا فعال شد !", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Ss]ettextadd (.*)") or Ramin1:match("^تنظیم متن اداجباری (.*)") or Ramin1:match("^تنظیم متن اد اجباری (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local Alpha = Ramin1:match("^[Ss]ettextadd (.*)") or Ramin1:match("^تنظیم متن اداجباری (.*)") or Ramin1:match("^تنظیم متن اداجباری (.*)");
			base:set(TD_ID .. "Text:AddTXT:" .. msg.chat_id, Alpha);
			sendBot(msg.chat_id, msg.id, "⌯ پیام اد اجباری گروه تنظیم شد .", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Dd]eltextjoin$") or Ramin1:match("^حذف پیام اداجباری$") or Ramin1:match("^حذف پیام اد اجباری$") or Ramin1:match("^ریست پیام اد اجباری$")) then
			base:del(TD_ID .. "Text:AddTXT:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ پیام اد اجباری گروه ریست شد .", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Ss]ettextjoin (.*)") or Ramin1:match("^تنظیم متن عضویت اجباری (.*)") or Ramin1:match("^تنظیم متن اجبار عضویت (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local Alpha = Ramin1:match("^[Ss]ettextjoin (.*)") or Ramin1:match("^تنظیم متن عضویت اجباری (.*)") or Ramin1:match("^تنظیم متن اجبار عضویت (.*)");
			base:set(TD_ID .. "Text:Chjoin:" .. msg.chat_id, Alpha);
			sendBot(msg.chat_id, msg.id, "⌯ پیام عضویت اجباری کانال تنظیم شد .", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Dd]eltextjoin$") or Ramin1:match("^حذف پیام عضویت اجباری$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Text:Chjoin:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ پیام عضویت اجباری کانال با موفقيت حذف شد.", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Ss]etnamejoin (.*)") or Ramin1:match("^تنظیم اسم کانال (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local Alpha = Ramin1:match("^[Ss]etnamejoin (.*)") or Ramin1:match("^تنظیم اسم کانال (.*)");
			base:set(TD_ID .. "Text:ChName:" .. msg.chat_id, Alpha);
			sendBot(msg.chat_id, msg.id, "⌯ نام کانال برای عضویت اجباری تنظیم شد.", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Dd]elnamejoin$") or Ramin1:match("^حذف اسم کانال$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Text:ChName:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ نام کانال برای عضویت اجباری حذف شد.", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Ss]etrules (.*)") or Ramin1:match("^تنظیم قوانین (.*)")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			local rules = Ramin1:match("^[Ss]etrules (.*)") or Ramin1:match("^تنظیم قوانین (.*)");
			base:set(TD_ID .. "Rules:" .. msg.chat_id, rules);
			sendBot(msg.chat_id, msg.id, "⌯ قوانین گروه با موفقیت ثبت شد", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Ss]ettextzerolove (.*)") or Ramin1:match("^تنظیم متن صفر عاشقی (.*)")) and is_Owner(msg) and is_JoinChannel(msg) then
			local rules = Ramin1:match("^[Ss]ettextzerolove (.*)") or Ramin1:match("^تنظیم متن صفر عاشقی (.*)");
			base:set(TD_ID .. "Text:Mylove:" .. msg.chat_id, rules);
			sendBot(msg.chat_id, msg.id, "⌯ متن صفر عاشقی تنظیم شد !", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Dd]eltextzerolove$") or Ramin1:match("^حذف متن صفر عاشقی$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Text:Mylove:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ متن صفر عاشقی حذف شد .", "md");
		end;
		if Ramin1 and (Ramin1:match("^[Dd]elrules$") or Ramin1:match("^حذف قوانین$")) and is_ModLock(msg.chat_id, msg.sender_id.user_id) and is_JoinChannel(msg) then
			base:del(TD_ID .. "Rules:" .. msg.chat_id);
			sendBot(msg.chat_id, msg.id, "⌯ قوانین گروه حذف شد.", "md");
		end;
		if (Ramin == "ownergp" or Ramin == "مالک گروه") and is_JoinChannel(msg) then
			local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
			for m, n in ipairs(data) do
				if n.user_id then
					if n.is_owner == true then
						owner_id = n.user_id;
						local data = TD.getUserProfilePhotos(owner_id, 0, 1);
						local Profile = (TD.getUserProfilePhotos(owner_id, 0, 1)).total_count;
						result = TD.getUser(owner_id);
						full = TD.getUserFullInfo(owner_id);
						if not result.first_name then
							usernamelink = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. owner_id .. "</a>";
						elseif result.first_name ~= "" then
							usernamelink = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(result.first_name) .. "</a>";
						else
							usernamelink = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(result.usernames.editable_username) .. "</a>";
						end;
						local data = TD.getUserProfilePhotos(owner_id, 0, 1);
						local Profile = (TD.getUserProfilePhotos(owner_id, 0, 1)).total_count;
						if result.first_name then
							name = result.first_name;
						else
							name = "بدون نام";
						end;
						if result.first_name then
							username = "@" .. result.usernames.editable_username;
						else
							username = "بدون یوزرنیم";
						end;
						_text = "⌯ مالک گروه : " .. usernamelink .. "\n⌯ ایدی عددی : " .. owner_id .. "\n⌯ ┅┅━━━━┅┅ ⌯ \n ";
						if data.photos and data.photos[1] then
							return TD.sendPhoto(msg.chat_id, msg.id, data.photos[1].sizes[1].photo.remote.id, _text, "html");
						else
							return TD.sendText(msg.chat_id, msg.id, _text, "html");
						end;
					end;
				end;
			end;
		end;
	end;
end;
local MrTeleGramiChatMember = function(msg, data)
	UserID = msg.actor_user_id;
	ChatID = msg.chat_id;
	local chate = TD.chat_type(ChatID);
	if chate == "is_channel" then
		ChatTypeChannel = true;
	elseif chate == "is_supergroup" then
		ChatTypeSuperGp = true;
	elseif chate == "is_group" then
		ChatTypeGP = true;
	elseif chate == "is_private" then
		ChatTypePV = true;
	elseif chate == "is_secret" then
		ChatTypeSecret = true;
	end;
	if ChatTypeSuperGp and not ChatTypeChannel and not ChatTypePV then
		UserCheck = msg.new_chat_member.member_id.user_id;
		local Result = TD.getUser(UserID);
		if msg.new_chat_member.status._ == "chatMemberStatusBanned" and msg.old_chat_member.status._ == "chatMemberStatusMember" then
			Userban = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Userban=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusMember" and msg.old_chat_member.status._ == "chatMemberStatusBanned" then
			Useraddban = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Useraddban=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusLeft" and msg.old_chat_member.status._ == "chatMemberStatusBanned" then
			Userdelban = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Userdelban=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusMember" and msg.old_chat_member.status._ == "chatMemberStatusLeft" then
			if UserID == UserCheck then
				Usernewjoin = true;
				print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Usernewjoin=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			else
				local data = TD.getChatAdministrators(msg.chat_id);
				if #data.administrators ~= 0 or #data.administrators ~= 1 then
					for i, v in pairs(data.administrators) do
						if not v.is_owner then
							if v.user_id == UserID then
								if v.user_id == tonumber(BotCliId) or v.user_id == tonumber(BotJoiner) then
								else
									base:incr(TD_ID .. "Content_Message:AdminAddsDay:" .. v.user_id .. ":" .. msg.chat_id);
									base:incr(TD_ID .. "Content_Message:AdminAdds:" .. v.user_id .. ":" .. msg.chat_id);
								end;
							end;
						end;
					end;
				else
					print("not admin group");
				end;
				Usernewadd = false;
				print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Useraddjoin=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusLeft" and msg.old_chat_member.status._ == "chatMemberStatusCreator" then
			UserleftOwner = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[UserleftOwner=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusCreator" and msg.old_chat_member.status._ == "chatMemberStatusLeft" then
			UserjoinOwner = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[UserjoinOwner=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusLeft" and msg.old_chat_member.status._ == "chatMemberStatusAdministrator" then
			UserleftAdmin = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[UserleftAdmin=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusLeft" and msg.old_chat_member.status._ == "chatMemberStatusMember" then
			Userleft = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[Userleft=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusRestricted" and msg.old_chat_member.status._ == "chatMemberStatusMember" then
			UserMute = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[UserMute=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if msg.new_chat_member.status._ == "chatMemberStatusMember" and msg.old_chat_member.status._ == "chatMemberStatusRestricted" then
			UserDelMute = true;
			print(color.magenta[1] .. "⌯ SenderID:[" .. Alpha(Result.id) .. "-" .. Result.first_name .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[UserMute=" .. UserCheck .. "]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
		end;
		if Usernewjoin and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_VipChat(msg)) then
			usere = msg.new_chat_member.member_id.user_id;
			joiner = msg.actor_user_id;
			local TeleBot = TD.getUser(usere);
			local Ramin = TD.getUser(msg.actor_user_id);
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "AntiTabchi") and base:get(TD_ID .. "tabchi" .. msg.chat_id) == "number" and (not is_VipChat(msg)) then
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
				MuteUser(msg.chat_id, usere, 0);
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "FirstTabchiMute") then
					MuteUser(msg.chat_id, usere, 0);
				end;
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAntiTab") then
					mmltxt = "محدود خواهید شد!";
				else
					mmltxt = "مسدود خواهی شد!";
				end;
				guard = TD.getUser(usere);
				if guard.usernames.editable_username == "" then
					name = ec_name(guard.first_name);
				else
					name = guard.usernames.editable_username;
				end;
				Firstname = (TD.getUser(usere)).first_name;
				local Number1 = {
					"1",
					"2",
					"3",
					"4",
					"5",
					"6",
					"7",
					"8",
					"9",
					"10"
				};
				local Number2 = {
					"11",
					"12",
					"13",
					"14",
					"15",
					"16",
					"17",
					"18",
					"19",
					"20"
				};
				local Number3 = {
					"21",
					"22",
					"23",
					"24",
					"25",
					"26",
					"27",
					"28",
					"29",
					"30"
				};
				local Number4 = {
					"1",
					"2",
					"3",
					"4",
					"5",
					"6",
					"7"
				};
				local Number5 = {
					"110",
					"120",
					"130",
					"140",
					"150",
					"160",
					"170",
					"180",
					"190",
					"200"
				};
				local Number6 = {
					"210",
					"220",
					"230",
					"240",
					"250",
					"260",
					"270",
					"280",
					"290",
					"300"
				};
				TextTab_1, SetCall_1 = Number1[math.random(#Number1)], "IsTabchiTrue";
				TextTab_2, SetCall_2 = Number2[math.random(#Number2)], "IsTabchiTrue";
				TextTab_3, SetCall_3 = Number3[math.random(#Number3)], "IsTabchiTrue";
				TextTab_4, SetCall_4 = Number4[math.random(#Number4)], "IsTabchiTrue";
				TextTab_5, SetCall_5 = Number5[math.random(#Number5)], "IsTabchiTrue";
				TextTab_6, SetCall_6 = Number6[math.random(#Number6)], "IsTabchiTrue";
				local Number3 = {
					"21",
					"22",
					"23",
					"24",
					"25",
					"26",
					"27",
					"28",
					"29",
					"30"
				};
				local Number4 = {
					"1",
					"2",
					"3",
					"4",
					"5",
					"6",
					"7"
				};
				Emoje1 = Number3[math.random(#Number3)];
				Emoje2 = Number3[math.random(#Number3)];
				local Emoje = Emoje1 + Emoje2;
				LoGoEmoji = "" .. Emoje1 .. "➕" .. Emoje2 .. "= ?";
				Clr = {
					"00FF00",
					"6699FF",
					"CC99CC",
					"CC66FF",
					"0066FF",
					"FFF200",
					"FF0000",
					"FFCCCC",
					"FF66CC",
					"FFFFFF",
					"00FF00"
				};
				Color = Clr[math.random(#Clr)];
				Firstname = (TD.getUser(usere)).first_name;
				Random = math.random(1, 6);
				if Random == 1 then
					TextTab_1, SetCall_1 = "" .. Emoje .. "", "IsTabchiFalse";
				elseif Random == 2 then
					TextTab_2, SetCall_2 = "" .. Emoje .. "", "IsTabchiFalse";
				elseif Random == 3 then
					TextTab_3, SetCall_3 = " " .. Emoje .. "", "IsTabchiFalse";
				elseif Random == 4 then
					TextTab_4, SetCall_4 = " " .. Emoje .. "", "IsTabchiFalse";
				elseif Random == 5 then
					TextTab_5, SetCall_5 = " " .. Emoje .. "", "IsTabchiFalse";
				elseif Random == 6 then
					TextTab_6, SetCall_6 = "" .. Emoje .. "", "IsTabchiFalse";
				end;
				print("Ehraz");
				if not base:get((TD_ID .. "TimerJoinEhraz:" .. usere .. msg.chat_id)) then
					AttachPhoto = "https://assets.imgix.net/examples/clouds.jpg?blur=5000&w=400&h=200&fit=crop&txt=" .. LoGoEmoji .. "&txtsize=100&txtclr=000000&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=" .. Color;
					text = "[](" .. AttachPhoto .. ")⌯  کاربر 「[" .. string.gsub(Firstname, "[%[%]]", "") .. "](tg://user?id=" .. usere .. ")」\n▲ شما باید هویت خود را تائید کنید.\n\n◂ برای تائید هویت خود باید به سوال زیر پاسخگو باشید .\n\nسوال شما : \n" .. LoGoEmoji .. "\n─┅━━━━━━━┅─\n[⌯ توجه](tg://user?id=" .. usere .. ") : در صورت پاسخگوی اشتباه در گروه برای همیشه " .. mmltxt .. "";
					Keyboard = {
						{
							{
								text = TextTab_1,
								data = "Gaurd:" .. SetCall_1 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_5,
								data = "Gaurd:" .. SetCall_5 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_3,
								data = "Gaurd:" .. SetCall_3 .. ">" .. usere .. ":" .. msg.chat_id
							}
						},
						{
							{
								text = TextTab_6,
								data = "Gaurd:" .. SetCall_6 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_2,
								data = "Gaurd:" .. SetCall_2 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_4,
								data = "Gaurd:" .. SetCall_4 .. ">" .. usere .. ":" .. msg.chat_id
							}
						},
						{
							{
								text = "ربات نیست ✅",
								data = "bd:Is_Tabchino>" .. usere .. ":" .. msg.chat_id
							},
							{
								text = "ربات است ❌",
								data = "bd:Is_Tabchiyes>" .. usere .. ":" .. msg.chat_id
							}
						}
					};
					base:sadd(TD_ID .. "AntiTabchiUser1" .. msg.chat_id, usere);
					TD.sendText(msg.chat_id, msg.id, text, "md", false, false, false, false, TD.replyMarkup({
						type = "inline",
						data = Keyboard
					}));
					base:setex(TD_ID .. "TimerJoinEhraz:" .. usere .. msg.chat_id, 5, true);
				end;
				function BDClearPm()
					if base:sismember(TD_ID .. "AntiTabchiUser1" .. msg.chat_id, usere) and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "AntiTabchi") then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAntiTab") then
							MuteUser(msg.chat_id, usere, 0);
							base:sadd("AGTMute:", usere);
							base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
							sendBot(msg.chat_id, msg.id, "◆ کاربر [" .. usere .. "](tg://user?id=" .. usere .. ") به علت پاسخگو نبودن به احراز هویت در گروه سکوت و به عنوان ربات شناسایی شد !", "md");
						else
							KickUser(msg.chat_id, usere);
							TD.setChatMemberStatus(msg.chat_id, usere, "banned");
							sendBot(msg.chat_id, msg.id, "◆ کاربر [" .. usere .. "](tg://user?id=" .. usere .. ") به علت پاسخگو نبودن به احراز هویت در گروه مسدود و به عنوان ربات شناسایی شد !", "md");
							base:sadd("AGTMute:", usere);
							base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
						end;
						base:srem(TD_ID .. "AntiTabchiUser1" .. msg.chat_id, usere);
					end;
				end;
				TD.set_timer(30, BDClearPm);
			end;
		end;
		if Usernewjoin and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_VipChat(msg)) then
			usere = msg.new_chat_member.member_id.user_id;
			joiner = msg.actor_user_id;
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "AntiTabchi") and base:get(TD_ID .. "tabchi" .. msg.chat_id) == "emoji" and (not is_Vip(msg)) then
				MuteUser(msg.chat_id, usere, 0);
				if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "FirstTabchiMute") then
					MuteUser(msg.chat_id, usere, 0);
				end;
				if base:sismember(TD_ID .. "Gp2:" .. chat_id, "MuteAntiTab") then
					mmltxt = "محدود خواهید شد!";
				else
					mmltxt = "مسدود خواهی شد!";
				end;
				guard = TD.getUser(usere);
				if guard.usernames.editable_username == "" then
					name = ec_name(guard.first_name);
				else
					name = guard.usernames.editable_username;
				end;
				local keyboard = {};
				TexT = "⌯ کاربر عزیز <a href=\"tg://user?id=" .. usere .. "\">" .. name .. "</a>\n\n⇜ برای جلوگیری از ورود ربات ها قفل  احراز هویت  فعال می باشد. ";
				Ramin = {
					"Guard",
					"MrRamin"
				};
				MrGuard = {
					"Guard",
					"MrRamin",
					"Alireza",
					"TmGaurdian"
				};
				BDAntiTabchi = MrGuard[math.random(#MrGuard)];
				local Number1 = {
					"😐",
					"😂",
					"💙",
					"😑",
					"🤣",
					"😭",
					"😊",
					"✅",
					"🙈",
					"🇮🇷",
					"⚽️",
					"🍎",
					"🍌",
					"🐠",
					"🤡",
					"😎",
					"🤠",
					"🤖",
					"🎃",
					"🙌"
				};
				local Number2 = {
					"🦄",
					"🐬",
					"🐓",
					"🌈",
					"🔥",
					"⭐️",
					"🌍",
					"🌹",
					"🍄",
					"🍁",
					"🍀",
					"🐇",
					"🐆",
					"🐪",
					"🙌",
					"💄",
					"👄",
					"👩",
					"🤦♂️",
					"👑"
				};
				local Number3 = {
					"❄️",
					"🌪",
					"☃️",
					"☔️",
					"🍕",
					"🍔",
					"🍇",
					"🍓",
					"🍦",
					"🏈",
					"🏀",
					"🏓",
					"🥊",
					"🥇",
					"🏆",
					"🎺",
					"🎲",
					"✈️",
					"🚦",
					"🎡"
				};
				local Number4 = {
					"🕋",
					"🏞",
					"⌚️",
					"💻",
					"☎️",
					"⏰",
					"💰",
					"💎",
					"🔫",
					"⚙️",
					"💣",
					"💊",
					"🎈",
					"✂️",
					"🔐",
					"💞",
					"☢️",
					"♻️",
					"🔰",
					"🆘"
				};
				local Number5 = {
					"🍌",
					"🐠",
					"🤡",
					"😎",
					"🤠",
					"🤖",
					"🎃",
					"🙌",
					"🍦",
					"🏈",
					"🏀",
					"🏓",
					"🥊",
					"🥇",
					"🏆",
					"🎺",
					"🎲",
					"✈️"
				};
				local Number6 = {
					"🕋",
					"🏞",
					"⌚️",
					"💻",
					"☎️",
					"⏰",
					"💰",
					"💎",
					"🔫",
					"⚙️",
					"💣",
					"💊",
					"🎈",
					"💊",
					"✂️",
					"🔐",
					"💞",
					"☢️",
					"♻️"
				};
				local WowEmoji = {
					"" .. Number1[math.random(#Number1)] .. "",
					"" .. Number2[math.random(#Number2)] .. "",
					"" .. Number3[math.random(#Number3)] .. "",
					"" .. Number4[math.random(#Number4)] .. "",
					"" .. Number5[math.random(#Number5)] .. "",
					"" .. Number6[math.random(#Number6)] .. ""
				};
				TextTab_1, SetCall_1 = Number1[math.random(#Number1)], "IsTabchiEmojiTrue";
				TextTab_2, SetCall_2 = Number2[math.random(#Number2)], "IsTabchiEmojiTrue";
				TextTab_3, SetCall_3 = Number3[math.random(#Number3)], "IsTabchiEmojiTrue";
				TextTab_4, SetCall_4 = Number4[math.random(#Number4)], "IsTabchiEmojiTrue";
				TextTab_5, SetCall_5 = Number5[math.random(#Number5)], "IsTabchiEmojiTrue";
				TextTab_6, SetCall_6 = Number6[math.random(#Number6)], "IsTabchiEmojiTrue";
				KeyEmoji = {
					"😐",
					"👑",
					"😭",
					"😻",
					"😈",
					"🦄",
					"🐙",
					"🥀",
					"🚀",
					"🏆"
				};
				randnum = KeyEmoji[math.random(#KeyEmoji)];
				LoGoEmoji = "" .. randnum .. "";
				Clr = {
					"00FF00",
					"6699FF",
					"CC99CC",
					"CC66FF",
					"0066FF",
					"FFF200",
					"FF0000",
					"FFCCCC",
					"FF66CC",
					"FFFFFF",
					"00FF00"
				};
				Color = Clr[math.random(#Clr)];
				Firstname = (TD.getUser(usere)).first_name;
				Random = math.random(1, 6);
				if Random == 1 then
					TextTab_1, SetCall_1 = "" .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				elseif Random == 2 then
					TextTab_2, SetCall_2 = "" .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				elseif Random == 3 then
					TextTab_3, SetCall_3 = " " .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				elseif Random == 4 then
					TextTab_4, SetCall_4 = " " .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				elseif Random == 5 then
					TextTab_5, SetCall_5 = " " .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				elseif Random == 6 then
					TextTab_6, SetCall_6 = "" .. LoGoEmoji .. "", "IsTabchiEmojiFalse";
				end;
				if not base:get((TD_ID .. "TimerJoinEhraz:" .. usere .. msg.chat_id)) then
					AttachPhoto = "https://assets.imgix.net/examples/clouds.jpg?blur=5000&w=400&h=200&fit=crop&txt=" .. LoGoEmoji .. "&txtsize=100&txtclr=000000&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=" .. Color;
					text = "[](" .. AttachPhoto .. ")⌯ کاربر 「[" .. string.gsub(Firstname, "[%[%]]", "") .. "](tg://user?id=" .. usere .. ")」\n▲ شما باید هویت خود را تائید کنید.\n\n◂ برای تائید هویت خود باید از بین دکمه های زیر مشخص کنید عکس ارسال شده چی می باشد؟ \n\nنمایش ایموجی : \n" .. LoGoEmoji .. "\n─┅━━━━━━━┅─\n[⌯ توجه](tg://user?id=" .. msg.sender_id.user_id .. ") : در صورت پاسخگوی اشتباه در گروه برای همیشه " .. mmltxt .. " ";
					Keyboard = {
						{
							{
								text = TextTab_1,
								data = "Gaurd:" .. SetCall_1 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_5,
								data = "Gaurd:" .. SetCall_5 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_3,
								data = "Gaurd:" .. SetCall_3 .. ">" .. usere .. ":" .. msg.chat_id
							}
						},
						{
							{
								text = TextTab_6,
								data = "Gaurd:" .. SetCall_6 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_2,
								data = "Gaurd:" .. SetCall_2 .. ">" .. usere .. ":" .. msg.chat_id
							},
							{
								text = TextTab_4,
								data = "Gaurd:" .. SetCall_4 .. ">" .. usere .. ":" .. msg.chat_id
							}
						},
						{
							{
								text = "ربات نیست ✅",
								data = "bd:Is_Tabchino>" .. usere .. ":" .. msg.chat_id
							},
							{
								text = "ربات است ❌",
								data = "bd:Is_Tabchiyes>" .. usere .. ":" .. msg.chat_id
							}
						}
					};
					base:sadd(TD_ID .. "AntiTabchiUser" .. msg.chat_id, usere);
					TD.sendText(msg.chat_id, msg.id, text, "md", false, false, false, false, TD.replyMarkup({
						type = "inline",
						data = Keyboard
					}));
					base:setex(TD_ID .. "TimerJoinEhraz:" .. usere .. msg.chat_id, 120, true);
				end;
			end;
			function BDClearPm()
				if base:sismember(TD_ID .. "AntiTabchiUser" .. msg.chat_id, usere) and base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "AntiTabchi") then
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "MuteAntiTab") then
						MuteUser(msg.chat_id, usere, 0);
						base:sadd("AGTMute:", usere);
						base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
						sendBot(msg.chat_id, msg.id, "◆ کاربر [" .. usere .. "](tg://user?id=" .. usere .. ") به علت پاسخگو نبودن به احراز هویت در گروه سکوت و به عنوان ربات شناسایی شد !", "md");
					else
						KickUser(msg.chat_id, usere);
						TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						sendBot(msg.chat_id, msg.id, "◆ کاربر [" .. usere .. "](tg://user?id=" .. usere .. ") به علت پاسخگو نبودن به احراز هویت در گروه مسدود و به عنوان ربات شناسایی شد !", "md");
						base:sadd("AGTMute:", msg.sender_id.user_id);
						base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
					end;
					base:srem(TD_ID .. "AntiTabchiUser" .. msg.chat_id, usere);
				end;
			end;
			TD.set_timer(30, BDClearPm);
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) then
			usere = msg.new_chat_member.member_id.user_id;
			adder = msg.actor_user_id;
			local TeleBot = TD.getUser(usere);
			if not ModUser(msg, usere) then
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Bots") then
					if TeleBot.type["@type"] == "userTypeBot" then
						TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					end;
				end;
			end;
		end;
		if Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) then
			if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Joiner") then
				usere = msg.new_chat_member.member_id.user_id;
				joiner = msg.actor_user_id;
				local TeleBot = TD.getUser(usere);
				local Ramin = TD.getUser(msg.actor_user_id);
				if TeleBot.type["@type"] == "userTypeBot" then
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. joiner .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
					if not base:get((TD_ID .. "JoinerBot:" .. joiner .. msg.chat_id)) then
						text = "⌯ کاربر  〚" .. username .. " - " .. joiner .. "〛:\n\n به علت اد کردن ربات در گروه مسدود شد !";
						base:sadd("AGTMute:", usere);
						sendBot(msg.chat_id, 0, text, "html");
						base:sadd("AGTMute:", joiner);
						TD.setChatMemberStatus(msg.chat_id, joiner, "banned");
						TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						base:setex(TD_ID .. "JoinerBot:" .. msg.actor_user_id .. msg.chat_id, 3, true);
					end;
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) then
			usere = msg.new_chat_member.member_id.user_id;
			joiner = msg.actor_user_id;
			local Ramin = TD.getUser(usere);
			if is_GlobalyBan(usere) then
				if Ramin.usernames.editable_username == "" then
					name = ec_name(Ramin.first_name);
				else
					name = Ramin.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. name .. "</a> ";
				if not base:get((TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id)) then
					base:setex(TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id, 10, true);
					KickUser(msg.chat_id, usere);
					TD.setChatMemberStatus(msg.chat_id, usere, "banned");
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) then
			usere = msg.new_chat_member.member_id.user_id;
			local Ramin = TD.getUser(usere);
			if is_Banned(msg.chat_id, usere) then
				if Ramin.usernames.editable_username == "" then
					name = ec_name(Ramin.first_name);
				else
					name = Ramin.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. name .. "</a> ";
				if not base:get((TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id)) then
					base:setex(TD_ID .. "TimerBanAll:" .. usere .. msg.chat_id, 10, true);
					KickUser(msg.chat_id, usere);
					TD.setChatMemberStatus(msg.chat_id, usere, "banned");
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "NameAntiTabchi") then
				usere = msg.new_chat_member.member_id.user_id;
				joiner = msg.actor_user_id;
				local Ramin = TD.getUser(usere);
				if is_GlobalyMute(usere) then
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. name .. "</a> ";
					if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								text = "◄ یک ربات تبچی  〚" .. username .. " - <code>" .. usere .. "</code>〛در گروه شناسایی و مسدود شد !\n";
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								sendBot(msg.chat_id, msg.id, text, "html");
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							KickUser(msg.chat_id, usere);
							TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							KickUser(msg.chat_id, usere);
							TD.setChatMemberStatus(msg.chat_id, usere, "banned");
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								text = "◄ یک ربات تبچی  〚" .. username .. " - <code>" .. usere .. "</code>〛در گروه شناسایی و سکوت شد !\n";
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								sendBot(msg.chat_id, msg.id, text, "html");
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							MuteUser(msg.chat_id, usere, 0);
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
							MuteUser(msg.chat_id, usere, 0);
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
						if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
							if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
								text = "◄ یک ربات تبچی  〚" .. username .. " - <code>" .. usere .. "</code>〛در گروه شناسایی و حذف شد !";
								base:sadd("AGTMute:", usere);
								base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
								base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
							end;
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
						else
							TD.deleteMessages(msg.chat_id, {
								[1] = msg.id
							});
						end;
					elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
					else
						return;
					end;
				end;
			end;
		end;
		if Usernewadd then
			usere = msg.new_chat_member.member_id.user_id;
			adder = msg.actor_user_id;
			local TeleBot = TD.getUser(usere);
			if TeleBot.type["@type"] == "userTypeBot" then
			else
				base:incr(TD_ID .. "Content_Message:Adds:" .. adder .. ":" .. msg.chat_id);
				base:incr(TD_ID .. "Content_Message:AddsDay:" .. adder .. ":" .. msg.chat_id);
			end;
		end;
		if Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and (not is_VipChat(msg)) then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd") and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), msg.actor_user_id)) then
				usere = msg.new_chat_member.member_id.user_id;
				adder = msg.actor_user_id;
				local TeleBot = TD.getUser(usere);
				if TeleBot.type["@type"] == "userTypeBot" then
					Ramin = TD.getUser(msg.actor_user_id);
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
					if not base:get((TD_ID .. "TimerAddBot1:" .. msg.actor_user_id .. msg.chat_id)) then
						sendBot(msg.chat_id, msg.id, "⌯ <b>کاربر</b> 〚 " .. username .. " 〛\n\nا┅┅┈┅┈|هشدار⚠️|┈┅┅┈┅\n\n <b>⌯ شما یک ربات اضافه کردید کاربر عادی اد کنید !</b> ", "html");
						base:setex(TD_ID .. "TimerAddBot1:" .. msg.actor_user_id .. msg.chat_id, 20, true);
					end;
					TD.setChatMemberStatus(msg.chat_id, usere, "banned");
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				else
					usere = msg.new_chat_member.member_id.user_id;
					adder = msg.actor_user_id;
					local AddMember = TD.getUser(msg.new_chat_member.member_id.user_id);
					local setadd = tonumber(base:get(TD_ID .. "Force:Max:" .. msg.chat_id) or 10);
					print("Adder : " .. usere);
					if base:sismember(TD_ID .. "AddTekrari1:" .. msg.chat_id, usere) then
						local permit = base:hget(TD_ID .. "AddUserCount" .. msg.actor_user_id, msg.chat_id);
						local less = tonumber(setadd) - tonumber(permit);
						local Adder = TD.getUser(usere);
						if Adder.usernames.editable_username == "" then
							name = ec_name(Adder.first_name);
						else
							name = Adder.usernames.editable_username;
						end;
						local UserAdder = "<a href=\"tg://user?id=" .. usere .. "\"> " .. ec_name(Adder.first_name) .. "</a> ";
						Ramin = TD.getUser(msg.actor_user_id);
						if Ramin.usernames.editable_username == "" then
							name = ec_name(Ramin.first_name);
						else
							name = Ramin.usernames.editable_username;
						end;
						local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
						print("tekrari");
					else
						base:sadd(TD_ID .. "AddTekrari1:" .. msg.chat_id, usere);
						local chash = usere .. "RaminAddCheck" .. msg.actor_user_id .. "chatadd:" .. msg.chat_id;
						chk = base:get(TD_ID .. usere .. "RaminAddCheck" .. msg.actor_user_id .. "chatadd:" .. msg.chat_id);
						if not chk then
							base:set(TD_ID .. chash, true);
							local achash = "AddUserCount" .. msg.actor_user_id;
							local count = base:hget(TD_ID .. "AddUserCount" .. msg.actor_user_id, msg.chat_id) or 0;
							base:hset(TD_ID .. achash, msg.chat_id, tonumber(count) + 1);
							local permit = base:hget(TD_ID .. "AddUserCount" .. msg.actor_user_id, msg.chat_id);
							if tonumber(permit) == tonumber(setadd) then
								Ali = TD.getUser(msg.actor_user_id);
								if Ali.usernames.editable_username == "" then
									name = ec_name(Ali.first_name);
								else
									name = Ali.usernames.editable_username;
								end;
								local AliRamin = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(Ali.first_name) .. "</a> ";
								sendBot(msg.chat_id, 0, "◄ کاربر〚 " .. AliRamin .. " 〛\nا┅┈┅┅┈┅┈|✓|┈┅┈┅┅┈┅\n⌯ شما می توانید در گروه بدون هیچ محدودیتی  فعالیت کنید ! ", "html");
								base:sadd(TD_ID .. "VipAdd:" .. msg.chat_id, msg.actor_user_id);
							end;
							if tonumber(permit) < tonumber(setadd) then
								local less = tonumber(setadd) - tonumber(permit);
								Ali = TD.getUser(msg.actor_user_id);
								if Ali.usernames.editable_username == "" then
									name = ec_name(Ali.first_name);
								else
									name = Ali.usernames.editable_username;
								end;
								local AliRamin = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(Ali.first_name) .. "</a> ";
								local Adder = TD.getUser(msg.new_chat_member.member_id.user_id);
								if Adder.usernames.editable_username == "" then
									name = ec_name(Adder.first_name);
								else
									name = Adder.usernames.editable_username;
								end;
								local UserAdder = "<a href=\"tg://user?id=" .. msg.new_chat_member.member_id.user_id .. "\"> " .. ec_name(Adder.first_name) .. "</a> ";
								sendBot(msg.chat_id, 0, "◄ کاربر 〚 " .. AliRamin .. " 〛 شما کاربر〚 " .. UserAdder .. " 〛در گروه اد کردید\nا┅┈┅┅┈┅┈|✓|┈┅┈┅┅┈┅\n⌯ تعداد اد کرده شما :" .. permit .. " کاربر\n⌯ تعداد باقی مانده : " .. less .. " کاربر", "html");
							end;
						end;
					end;
				end;
			end;
		end;
		if Userdelban and (not is_OwnerChat(msg)) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			local TeleBot = TD.getUser(UserCheck);
			if TeleBot.type["@type"] == "userTypeBot" then
			else
				local Azader = TD.getUser(UserCheck);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAzader = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				local Azader = TD.getUser(UserID);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAza = "<a href=\"tg://user?id=" .. UserID .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				--sendBot(msg.chat_id, 0, "✦ کاربر 〚 " .. UserAzader .. " 〛 به صورت دستی در گروه حذف مسدود شد ! !", "html");
				base:srem(TD_ID .. "BanUser:" .. ChatID, UserCheck);
				local title = (TD.getChat(msg.chat_id)).title;
				local data = (TD.getChatAdministrators(ChatID)).administrators;
				for m, n in ipairs(data) do
					if n.user_id then
						if n.is_owner == true then
							owner_id = n.user_id;
						end;
					end;
				end;
				Owner = TD.getUser(owner_id);
				if Owner.usernames.editable_username == "" then
					name = ec_name(Owner.first_name);
				else
					name = Owner.usernames.editable_username;
				end;
				if not Owner.first_name then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. UserID .. "</a>";
				elseif Owner.first_name ~= "" then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.first_name) .. "</a>";
				else
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.usernames.editable_username) .. "</a>";
				end;
				tarikh = "" .. jdate("⌯ تاریخ #x #Y/#M/#D\n\n⌯ ساعت: #h:#m:#s") .. "";
				text = "\n┅┅━ گزارش ربات ━┅┅ \n\n\n◄ مالک عزیز   " .. Owner .. " یک گزارش از گروه " .. title .. " دارید !\n\n\n⌯ کاربر " .. UserAzader .. " به صورت دستی توسط " .. UserAza .. " در گروه حذف مسدود شد !\n\n\n" .. tarikh .. "\n";
				sendBot(owner_id, 0, text, "html");
			end;
		end;
		if Userban and (not is_OwnerChat(msg))  then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			local TeleBot = TD.getUser(UserCheck);
			if TeleBot.type["@type"] == "userTypeBot" then
			else
				azad = msg.new_chat_member.member_id.user_id;
				local Azader = TD.getUser(UserCheck);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAzader = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				user = msg.new_chat_member.inviter_user_id;
				local Azader = TD.getUser(UserID);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAza = "<a href=\"tg://user?id=" .. UserID .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				--sendBot(ChatID, 0, "✦ کاربر 〚 " .. UserAzader .. " 〛 به صورت دستی در گروه مسدود شد !", "html");
				base:sadd(TD_ID .. "BanUser:" .. ChatID, UserCheck);
				local title = (TD.getChat(ChatID)).title;
				local data = (TD.getChatAdministrators(ChatID)).administrators;
				for m, n in ipairs(data) do
					if n.user_id then
						if n.is_owner == true then
							owner_id = n.user_id;
						end;
					end;
				end;
				Owner = TD.getUser(owner_id);
				if Owner.usernames.editable_username == "" then
					name = ec_name(Owner.first_name);
				else
					name = Owner.usernames.editable_username;
				end;
				if not Owner.first_name then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. UserID .. "</a>";
				elseif Owner.first_name ~= "" then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.first_name) .. "</a>";
				else
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.usernames.editable_username) .. "</a>";
				end;
				tarikh = "" .. jdate("⌯ تاریخ #x #Y/#M/#D\n\n⌯ ساعت: #h:#m:#s") .. "";
				text = "\n┅┅━ گزارش ربات ━┅┅ \n\n\n◄ مالک عزیز   " .. Owner .. " یک گزارش از گروه " .. title .. " دارید !\n\n\n⌯ کاربر " .. UserAzader .. " به صورت دستی توسط " .. UserAza .. " در گروه مسدود شد !\n\n\n" .. tarikh .. "\n";
				sendBot(owner_id, 0, text, "html");
			end;
		end;
		if UserDelMute and (not is_OwnerChat(msg)) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			local TeleBot = TD.getUser(UserCheck);
			if TeleBot.type["@type"] == "userTypeBot" then
			else
				local Azader = TD.getUser(UserCheck);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAzader = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				local Azader = TD.getUser(UserID);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAza = "<a href=\"tg://user?id=" .. UserID .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				--sendBot(ChatID, 0, "✦ کاربر 〚 " .. UserAzader .. " 〛 به صورت دستی در گروه حذف سکوت شد ! !", "html");
				base:srem(TD_ID .. "MuteList:" .. ChatID, UserCheck);
				local title = (TD.getChat(ChatID)).title;
				local data = (TD.getChatAdministrators(ChatID)).administrators;
				for m, n in ipairs(data) do
					if n.user_id then
						if n.is_owner == true then
							owner_id = n.user_id;
						end;
					end;
				end;
				Owner = TD.getUser(owner_id);
				if Owner.usernames.editable_username == "" then
					name = ec_name(Owner.first_name);
				else
					name = Owner.usernames.editable_username;
				end;
				if not Owner.first_name then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. UserID .. "</a>";
				elseif Owner.first_name ~= "" then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.first_name) .. "</a>";
				else
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.usernames.editable_username) .. "</a>";
				end;
				tarikh = "" .. jdate("⌯ تاریخ #x #Y/#M/#D\n\n⌯ ساعت: #h:#m:#s") .. "";
				text = "\n┅┅━ گزارش ربات ━┅┅ \n\n\n◄ مالک عزیز   " .. Owner .. " یک گزارش از گروه " .. title .. " دارید !\n\n\n⌯ کاربر " .. UserAzader .. " به صورت دستی توسط " .. UserAza .. " در گروه حذف سکوت شد !\n\n\n" .. tarikh .. "\n";
				sendBot(owner_id, 0, text, "html");
			end;
		end;
		if UserMute and (not is_OwnerChat(msg)) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			local TeleBot = TD.getUser(UserCheck);
			if TeleBot.type["@type"] == "userTypeBot" then
			else
				local Azader = TD.getUser(UserCheck);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAzader = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				local Azader = TD.getUser(UserID);
				if Azader.usernames.editable_username == "" then
					name = ec_name(Azader.first_name);
				else
					name = Azader.usernames.editable_username;
				end;
				local UserAza = "<a href=\"tg://user?id=" .. UserID .. "\"> " .. ec_name(Azader.first_name) .. "</a> ";
				--sendBot(ChatID, 0, "✦ کاربر 〚 " .. UserAzader .. " 〛 به صورت دستی در گروه سکوت شد ! !", "html");
				base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
				local title = (TD.getChat(ChatID)).title;
				local data = (TD.getChatAdministrators(ChatID)).administrators;
				for m, n in ipairs(data) do
					if n.user_id then
						if n.is_owner == true then
							owner_id = n.user_id;
						end;
					end;
				end;
				Owner = TD.getUser(owner_id);
				if Owner.usernames.editable_username == "" then
					name = ec_name(Owner.first_name);
				else
					name = Owner.usernames.editable_username;
				end;
				if not Owner.first_name then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. UserID .. "</a>";
				elseif Owner.first_name ~= "" then
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.first_name) .. "</a>";
				else
					Owner = "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(Owner.usernames.editable_username) .. "</a>";
				end;
				tarikh = "" .. jdate("⌯ تاریخ #x #Y/#M/#D\n\n⌯ ساعت: #h:#m:#s") .. "";
				text = "\n┅┅━ گزارش ربات ━┅┅ \n\n\n◄ مالک عزیز   " .. Owner .. " یک گزارش از گروه " .. title .. " دارید !\n\n\n⌯ کاربر " .. UserAzader .. " به صورت دستی توسط " .. UserAza .. " در گروه سکوت شد !\n\n\n" .. tarikh .. "\n";
				sendBot(owner_id, 0, text, "html");
			end;
		end;
		if Usernewjoin or Usernewadd or Useraddban then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			if base:sismember(TD_ID .. "Gp2:" .. ChatID, "Welcomeon") then
				salen = jdate("#Y");
				mahen = jdate("#M");
				rozeen = jdate("#D");
				hoen = jdate("#h");
				minen = jdate("#m");
				secen = jdate("#s");
				local roz = jdate("#x");
				Salene = string.format("%02d", tonumber(salen));
				Mahene = string.format("%02d", tonumber(mahen));
				Rozene = string.format("%02d", tonumber(rozeen));
				hour = string.format("%02d", tonumber(hoen));
				minit = string.format("%02d", tonumber(minen));
				seco = string.format("%02d", tonumber(secen));
				local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
				local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
				local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
				local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
				local TarikhEN = "★ امروز " .. roz .. " " .. tarikhnumberen .. "\n★ ساعت : " .. timeen .. "";
				local TarikhFA = "★ امروز " .. roz .. " " .. tarikhnumberfa .. "\n★ ساعت : " .. timefa .. "";
				local data = (TD.getChat(ChatID)).title;
				local Ramin = TD.getUser(UserCheck);
				local mm = "<a href=\"tg://user?id=" .. UserCheck .. "\">" .. ec_name(Ramin.first_name) .. "</a>";
				if base:get(TD_ID .. "Text:Welcome:" .. ChatID) then
					txtt = base:get(TD_ID .. "Text:Welcome:" .. ChatID);
				else
					txtt = "⌯ سلام " .. mm .. "️ عزیز\n به گروه " .. data .. " خوش آمدید 💫\nا═❂═━━━┅┅┅──┄┄\n"..TarikhEN.."";
				end;
				local hash = TD_ID .. "Rules:" .. ChatID;
				local Black = base:get(hash);
				if Black then
					rules = Black;
				else
					rules = "قوانین ثبت نشده است";
				end;
				Status = "" .. (base:get(TD_ID .. "Welcome:Media:" .. ChatID) or "nil:nil") .. "";
				local Media, File = string.match(Status, "(.*):(.*)");
				local txtt = replace(txtt, "timeen", timeen);
				local txtt = replace(txtt, "timefa", timefa);
				local txtt = replace(txtt, "TarikhEN", TarikhEN);
				local txtt = replace(txtt, "TarikhFA", TarikhFA);
				local txtt = replace(txtt, "tarikhnumberen", tarikhnumberen);
				local txtt = replace(txtt, "tarikhnumberfa", tarikhnumberfa);
				local txtt = replace(txtt, "roz", roz);
				local txtt = replace(txtt, "firstnameman", "<a href=\"tg://user?id=" .. UserCheck .. "\">" .. ec_name(Ramin.first_name) .. "</a>");
				local txtt = replace(txtt, "firstname", ec_name(Ramin.first_name));
				local txtt = replace(txtt, "rules", rules);
				local txtt = replace(txtt, "group", data or "گپ ما");
				local txtt = replace(txtt, "lastname", Ramin.last_name or "");
				local txtt = replace(txtt, "username", "@" .. Ramin.usernames.editable_username) or "nil";
				if Media == "photo" then
					sendMedia(msg.chat_id, File, 0, txtt, "html", "Photo");
				elseif Media == "voice" then
					sendMedia(msg.chat_id, File, 0, txtt, "html", "Voice");
				elseif Media == "video" then
					sendMedia(msg.chat_id, File, 0, txtt, "html", "Video");
				elseif Media == "sticker" then
					sendMedia(msg.chat_id, File, 0, "", "html");
				elseif Media == "animation" then
					sendMedia(msg.chat_id, File, 0, txtt, "html");
				else
					sendBot(msg.chat_id, msg.id, txtt, "html");
				end;
			end;
		end;

		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and is_VipChat(msg) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "NameAntiTabchi") then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "tabchires") then	
			if UserCheck and is_GlobalyMute(UserCheck) then		
				local usere = UserCheck
				alpha = (TD.getUser(usere)).first_name;
				local username = "[" .. alpha .. "](tg://user?id=" .. usere .. ")";
				if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
							text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n━━┅─ شناسایی تبچی ─┅━━\n⌯  وضعیت : به محض ورود";
							base:sadd("AGTMute:", usere);
							base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
							sendBot(msg.chat_id, msg.id, text, "md");
							base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
						end;
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						KickUser(msg.chat_id, usere);
						TD.setChatMemberStatus(msg.chat_id, usere, "banned");
					else
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						KickUser(msg.chat_id, usere);
						TD.setChatMemberStatus(msg.chat_id, usere, "banned");
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
							text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n━━┅─ شناسایی تبچی ─┅━━\n⌯ وضعیت : به محض ورود ";
							base:sadd("AGTMute:", usere);
							base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
							sendBot(msg.chat_id, msg.id, text, "md");
							base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
						end;
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						MuteUser(msg.chat_id, usere, 0);
					else
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						MuteUser(msg.chat_id, usere, 0);
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
					if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
							base:sadd("AGTMute:", usere);
							base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
							base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
						end;
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					else
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
				else
					return;
				end;
			end
			end
			end	
		end





		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and is_VipChat(msg) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			UserCheck = msg.new_chat_member.member_id.user_id
			result = TD.getUserFullInfo(UserCheck);
			if result.bio == "" then
				RaminAbout = "Nil";
			else
				RaminAbout = result.bio;
			end;
			if base:sismember(TD_ID .. "Gp:" .. ChatID, "Del:Biolink") and base:sismember(TD_ID .. "Gp:" .. ChatID, "setMogjoin") and (not base:sismember((TD_ID .. "VipBio:" .. ChatID), UserCheck)) then
				mMd = RaminAbout:lower();
				if mMd:match("سـ.ـوپـر") or mMd:match("سوپر") or mMd:match("فیلم") or mMd:match("خاله") or mMd:match("سکس") or mMd:match("فالور") or mMd:match("ممبر") or mMd:match("فروش") or mMd:match("چک") then
					if base:get(TD_ID .. "Bio_stats" .. ChatID) == "kick" then
						KickUser(msg.chat_id, UserCheck);
						TD.setChatMemberStatus(ChatID, UserCheck, "banned");
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						base:sadd(TD_ID .. "BanUser:" .. ChatID, UserCheck);
						setbio = "مسدود";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "silent" then
						MuteUser(ChatID, UserCheck, 0);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						setbio = "سکوت";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "silenttime" then
						local timebiomsg = tonumber(base:get(TD_ID .. "biotime:" .. ChatID) or 120);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						MuteUser(ChatID, UserCheck, msg.date + timebiomsg);
						local Time = getTimeUptime(timebiomsg);
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						setbio = "سکوت زمانی به مدت " .. Time .. "";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "tabchi" then
						MuteUser(ChatID, UserCheck, 0);
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						setbio = "ربات تبچی";
						base:sadd("AGTMute:", UserCheck);
						base:sadd(TD_ID .. "AGTMuteNume:" .. ChatID, UserCheck);
						KickUser(ChatID, UserCheck);
						TD.setChatMemberStatus(ChatID, UserCheck, "banned");
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
					end;
					Ramin = TD.getUser(UserCheck);
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					UserCheck = msg.new_chat_member.member_id.user_id
					local username = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
					base:set(TD_ID .. "Biolink1" .. ChatID, UserCheck);
					local formidw = base:get(TD_ID .. "Biolink1" .. ChatID);
					if base:sismember(TD_ID .. "Gp2:" .. ChatID, "MsgCheckBio") then
						local keyboard = {};
						keyboard.inline_keyboard = {
							{
								{
									text = "⌯ رفع محدودیت",
									callback_data = "ScanMuteBio:" .. ChatID .. ":" .. formidw .. ""
								}
							}
						};
						text = " ⌯ کاربر 〚" .. username .. " - <code>" .. UserCheck .. "</code>〛 به دلیل داشتن بیوگرافی غیرمجاز در گروه " .. setbio .. " شد !\n\n⌯ ┅┅━سیستم ضد بیوگرافی━┅┅ ⌯ \n\n📥 وضعیت مقابله :(به محض ورود)  ";
						SendInlineBot(ChatID, text, keyboard, "html");
					end;
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and is_VipChat(msg) then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			result = TD.getUserFullInfo(UserCheck);
			if result.bio == "" then
				RaminAbout = "Nil";
			else
				RaminAbout = result.bio;
			end;
			if base:sismember(TD_ID .. "Gp:" .. ChatID, "Del:Biolink") and base:sismember(TD_ID .. "Gp:" .. ChatID, "setMogjoin") and (not base:sismember((TD_ID .. "VipBio:" .. ChatID), UserCheck)) then
				mMd = RaminAbout:lower();
				if mMd:match("سـ.ـوپـر") or mMd:match("سوپر") or mMd:match("فیلم") or mMd:match("خاله") or mMd:match("سکس") or mMd:match("فالور") or mMd:match("ممبر") or mMd:match("فروش") or mMd:match("چک") then
					if base:get(TD_ID .. "Bio_stats" .. ChatID) == "kick" then
						KickUser(msg.chat_id, UserCheck);
						TD.setChatMemberStatus(ChatID, UserCheck, "banned");
						TD.deleteMessages(msg.chat_id, {
							[1] = msg.id
						});
						base:sadd(TD_ID .. "BanUser:" .. ChatID, UserCheck);
						setbio = "مسدود";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "silent" then
						MuteUser(ChatID, UserCheck, 0);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						setbio = "سکوت";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "silenttime" then
						local timebiomsg = tonumber(base:get(TD_ID .. "biotime:" .. ChatID) or 120);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						MuteUser(ChatID, UserCheck, msg.date + timebiomsg);
						local Time = getTimeUptime(timebiomsg);
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
						setbio = "سکوت زمانی به مدت " .. Time .. "";
					elseif base:get(TD_ID .. "Bio_stats" .. ChatID) == "tabchi" then
						MuteUser(ChatID, UserCheck, 0);
						base:sadd(TD_ID .. "MuteList:" .. ChatID, UserCheck);
						setbio = "ربات تبچی";
						base:sadd("AGTMute:", UserCheck);
						base:sadd(TD_ID .. "AGTMuteNume:" .. ChatID, UserCheck);
						KickUser(ChatID, UserCheck);
						TD.setChatMemberStatus(ChatID, UserCheck, "banned");
						TD.deleteMessages(ChatID, {
							[1] = msg.id
						});
					end;
					Ramin = TD.getUser(UserCheck);
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. UserCheck .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
					base:set(TD_ID .. "Biolink1" .. ChatID, UserCheck);
					local formidw = base:get(TD_ID .. "Biolink1" .. ChatID);
					if base:sismember(TD_ID .. "Gp2:" .. ChatID, "MsgCheckBio") then
						local keyboard = {};
						keyboard.inline_keyboard = {
							{
								{
									text = "⌯ رفع محدودیت",
									callback_data = "ScanMuteBio:" .. ChatID .. ":" .. formidw .. ""
								}
							}
						};
						text = " ⌯ کاربر 〚" .. username .. " - <code>" .. UserCheck .. "</code>〛 به دلیل داشتن بیوگرافی غیرمجاز در گروه " .. setbio .. " شد !\n\n⌯ ┅┅━سیستم ضد بیوگرافی━┅┅ ⌯ \n\n📥 وضعیت مقابله :(به محض ورود)  ";
						SendInlineBot(ChatID, text, keyboard, "html");
					end;
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and is_VipChat(msg) then
			usere = UserCheck;
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			if base:get(TD_ID .. "sg:locktabalpha" .. ChatID) == "lock" and (not base:sismember((TD_ID .. "VipAdd:" .. ChatID), usere)) then
				full = (TD.getUserFullInfo(usere)).bio or "nil";
				if base:sismember(TD_ID .. "Gp2:" .. ChatID, "NameAntiTabchi") then
					users = base:smembers(TD_ID .. "FilterBio:" .. ChatID);
					if #users > 0 then
						for k, v in pairs(users) do
							mMd = full:lower();
							if mMd:match(v) then
								alpha = (TD.getUser(usere)).first_name;
								local username = "[" .. alpha .. "](tg://user?id=" .. usere .. ")";
								if base:get(TD_ID .. "tabchi_stats" .. ChatID) == "kick" then
									if base:sismember(TD_ID .. "Gp2:" .. ChatID, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. ChatID)) then
											text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n\n⌯ حالت قفل تبچی : بیوگرافی غیرمجاز ";
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. ChatID, usere);
											sendBot(msg.chat_id, msg.id, text, "md");
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. ChatID, 60, true);
										end;
										TD.deleteMessages(ChatID, {
											[1] = msg.id
										});
										KickUser(msg.chat_id, usere);
										TD.setChatMemberStatus(ChatID, usere, "banned");
									else
										TD.deleteMessages(ChatID, {
											[1] = msg.id
										});
										KickUser(ChatID, usere);
										TD.setChatMemberStatus(ChatID, usere, "banned");
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. ChatID) == "silent" then
									if base:sismember(TD_ID .. "Gp2:" .. ChatID, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. ChatID)) then
											text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n\n⌯ حالت قفل تبچی : بیوگرافی غیرمجاز ";
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. ChatID, usere);
											sendBot(msg.chat_id, msg.id, text, "md");
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. ChatID, 60, true);
										end;
										TD.deleteMessages(ChatID, {
											[1] = msg.id
										});
										MuteUser(msg.chat_id, usere, 0);
									else
										TD.deleteMessages(ChatID, {
											[1] = msg.id
										});
										MuteUser(ChatID, usere, 0);
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. ChatID) == "delmsg" then
									if base:sismember(TD_ID .. "Gp2:" .. ChatID, "Tabchi:Msg") then
										if not base:get((TD_ID .. "TimerTabchi:" .. usere .. ChatID)) then
											text = "⌯ کاربر  〚" .. username .. " - `" .. usere .. "`〛:\n\n به علت بیوگرافی غیرمجاز در گروه به عنوان تبچی شناسایی و بیصدا شد !";
											base:sadd("AGTMute:", usere);
											base:sadd(TD_ID .. "AGTMuteNume:" .. ChatID, usere);
											base:setex(TD_ID .. "TimerTabchi:" .. usere .. ChatID, 60, true);
										end;
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
									else
										TD.deleteMessages(msg.chat_id, {
											[1] = msg.id
										});
									end;
								elseif base:get(TD_ID .. "tabchi_stats" .. ChatID) == "off" then
								else
									return;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
		if Usernewjoin or Usernewadd and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_ModChat(msg)) and is_VipChat(msg) then
			usere = UserCheck;
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			if base:get(TD_ID .. "sg:locktabalpha" .. msg.chat_id) == "lock" and (not base:sismember((TD_ID .. "VipAdd:" .. msg.chat_id), usere)) then
				users = base:smembers(TD_ID .. "FilterName:" .. msg.chat_id);
				alphaa = (TD.getUser(usere)).first_name;
				local username = "[" .. usere .. "](tg://user?id=" .. usere .. ")";
				if #users > 0 then
					alpha = TD.getUser(usere);
					if alpha.usernames.editable_username == "" then
						name = ec_name(alpha.first_name);
					else
						name = alpha.usernames.editable_username;
					end;
					for k, v in pairs(users) do
						mMd = alpha.first_name:lower() or "";
						if mMd:match(v) then
							if base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "kick" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و مسدود شد !\n\n⌯ حالت قفل تبچی : اسم غیرمجاز ";
										sendBot(msg.chat_id, msg.id, text, "md");
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									KickUser(msg.chat_id, usere);
									TD.setChatMemberStatus(msg.chat_id, usere, "banned");
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									KickUser(msg.chat_id, usere);
									TD.setChatMemberStatus(msg.chat_id, usere, "banned");
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "silent" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. usere .. "`〛در گروه شناسایی و سکوت شد !\n\n⌯ حالت قفل تبچی : اسم غیرمجاز ";
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										sendBot(msg.chat_id, msg.id, text, "md");
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									MuteUser(msg.chat_id, usere, 0);
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
									MuteUser(msg.chat_id, usere, 0);
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "delmsg" then
								if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Tabchi:Msg") then
									if not base:get((TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id)) then
										text = "⌯ کاربر  〚" .. username .. " - `" .. usere .. "`〛:\n\n به علت بیوگرافی غیرمجاز در گروه به عنوان تبچی شناسایی و بیصدا شد !";
										base:sadd("AGTMute:", usere);
										base:sadd(TD_ID .. "AGTMuteNume:" .. msg.chat_id, usere);
										base:setex(TD_ID .. "TimerTabchi:" .. usere .. msg.chat_id, 60, true);
									end;
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
								else
									TD.deleteMessages(msg.chat_id, {
										[1] = msg.id
									});
								end;
							elseif base:get(TD_ID .. "tabchi_stats" .. msg.chat_id) == "off" then
							else
								return;
							end;
						end;
					end;
				end;
			end;
		end;
		if Usernewjoin or Usernewadd then
			if UserCheck == Config.Sudoid then
				local rank = {
					"سلام بابایی خیلی خوش آمدی ⚡️",
					"بابایی خوش آمدی اینا منو اذیت میکنن به دادم برس 🤧 "
				};
				TD.setChatMemberStatus(msg.chat_id, Config.Sudoid, "Administrator", {
					1,
					1,
					0,
					0,
					1,
					1,
					1,
					1,
					1
				});
			end;
		end;
		if Usernewjoin or Usernewadd then
			UserID = msg.actor_user_id;
			ChatID = msg.chat_id;
			if UserCheck == Config.BotJoiner then
				print("Remove Bot");
				base:del(TD_ID .. "SetLock:" .. msg.chat_id);
				base:del(TD_ID .. "joinwarn:" .. msg.chat_id);
				base:srem(TD_ID .. "SuperGp", msg.chat_id);
				base:srem(TD_ID .. "SuperGpFree", msg.chat_id);
				base:del(TD_ID .. "Text:AddTXT:" .. msg.chat_id);
				base:del(TD_ID .. "Text:ChName:" .. msg.chat_id);
				base:del(TD_ID .. "Text:Chjoin:" .. msg.chat_id);
				base:del(TD_ID .. "Gp:" .. msg.chat_id);
				base:del(TD_ID .. "Gp3:" .. msg.chat_id);
				base:del(TD_ID .. "NewUser" .. msg.chat_id);
				base:del(TD_ID .. "ExpireData:" .. msg.chat_id);
				base:srem(TD_ID .. "group:", msg.chat_id);
				base:del(TD_ID .. "ModList:" .. msg.chat_id);
				base:del(TD_ID .. "OwnerList:" .. msg.chat_id);
				base:del(TD_ID .. "MuteList:" .. msg.chat_id);
				base:del(TD_ID .. "SilentList:" .. msg.chat_id);
				base:del(TD_ID .. "setmode:" .. msg.chat_id);
				base:del(TD_ID .. "Text:Welcome:" .. msg.chat_id);
				base:del(TD_ID .. "settag" .. msg.chat_id);
				base:del(TD_ID .. "Pin_id" .. msg.chat_id);
				base:del(TD_ID .. "Textlist:" .. msg.chat_id);
				base:del(TD_ID .. "Text:" .. msg.chat_id);
				base:del(TD_ID .. "CmDlist:" .. msg.chat_id);
				base:del(TD_ID .. "CmD:" .. msg.chat_id);
				base:del(TD_ID .. "EndTimeSee" .. msg.chat_id);
				base:del(TD_ID .. "StartTimeSee" .. msg.chat_id);
				base:del(TD_ID .. "limitpm:" .. msg.chat_id);
				base:del(TD_ID .. "mutetime:" .. msg.chat_id);
				base:del(TD_ID .. "cgmautotime:" .. msg.chat_id);
				base:del(TD_ID .. "cbmtime:" .. msg.chat_id);
				base:del(TD_ID .. "Flood:Max:" .. msg.chat_id);
				base:del(TD_ID .. "Force:Time:" .. msg.chat_id);
				base:del(TD_ID .. "Force:Pm:" .. msg.chat_id);
				base:del(TD_ID .. "joinwarn:" .. msg.chat_id);
				base:del(TD_ID .. "Warn:Max:" .. msg.chat_id);
				base:del(TD_ID .. "NUM_CH_MAX:" .. msg.chat_id);
				base:del(TD_ID .. "setch:" .. msg.chat_id);
				base:del(TD_ID .. "Text:Welcome:" .. msg.chat_id);
				base:del(TD_ID .. "Rules:" .. msg.chat_id);
				base:del(TD_ID .. "Total:messages:" .. msg.chat_id);
				base:del(TD_ID .. "Total:JoinedByLink:" .. msg.chat_id);
				allusers = base:smembers(TD_ID .. "AllUsers:" .. msg.chat_id);
				for k, v in pairs(allusers) do
					base:del(TD_ID .. "addeduser" .. msg.chat_id .. v);
					base:del(TD_ID .. "Total:AddUser:" .. msg.chat_id .. ":" .. v);
					base:del(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. v);
					base:del(TD_ID .. "Total:BanUser:" .. msg.chat_id .. ":" .. v);
					base:del(TD_ID .. "Total:KickUser:" .. msg.chat_id .. ":" .. v);
					base:del(TD_ID .. "Total:messages:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d") .. ":" .. v);
				end;
				tarikh = "" .. jdate("◄ تاریخ #x #Y/#M/#D\n\n◄ ساعت: #h:#m:#s") .. "";
				TeleBot = TD.getUser(msg.actor_user_id);
				if TeleBot.usernames.editable_username == "" then
					name = ec_name(TeleBot.first_name);
				else
					name = TeleBot.usernames.editable_username;
				end;
				if not TeleBot.first_name then
					username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\">" .. msg.actor_user_id .. "</a>";
				elseif TeleBot.first_name ~= "" then
					username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\">" .. StringData(TeleBot.first_name) .. "</a>";
				else
					username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\">" .. StringData(TeleBot.usernames.editable_username) .. "</a>";
				end;
				local title = (TD.getChat(msg.chat_id)).title;
				text = "\n<b>◄ ربات در گروه</b> " .. title .. " <b>توسط</b> " .. username .. "  <b>ریمو شد !</b>\n\n\n<b>" .. tarikh .. "</b>\n\n\n<b>⌯ ایدی گروه :</b> " .. msg.chat_id .. "\n\n<b>✓ توجه : تمامی اطلاعات گروه ثبت شده به صورت خودکار حذف شدند.</b>\n\n";
				sendBot(Sudoid, 0, text, "html");
			end;
		end;
		if Usernewjoin or Usernewadd or Useraddban and (not is_SudoChat(msg)) then
			user = msg.new_chat_member.member_id.user_id;
			inviteruser = msg.actor_user_id;
			if user == tonumber(BotJoiner) then
				if base:get(TD_ID .. "freeinstall") then
					base:sadd(TD_ID .. "SuperGpFree", msg.chat_id);
					if not base:get((TD_ID .. "ExpireDatafree:")) then
						num = 31;
					else
						num = base:get(TD_ID .. "ExpireDatafree:");
					end;
					base:setex(TD_ID .. "ExpireData:" .. msg.chat_id, day * tonumber(num), true);
					base:set(TD_ID .. "ExpireDataNum:" .. msg.chat_id, day * tonumber(num));
					local data = (TD.getChatAdministrators(msg.chat_id)).administrators;
					local t = "";
					for m, n in ipairs(data) do
						if n.user_id then
							if n.is_owner == true then
								owner_id = n.user_id;
								print("Owner : " .. owner_id);
								TeleBot = TD.getUser(owner_id);
								if TeleBot.usernames.editable_username == "" then
									name = ec_name(TeleBot.first_name);
								else
									name = TeleBot.usernames.editable_username;
								end;
								t = t .. "🅶" .. " <code>" .. owner_id .. "</code>-" .. "<a href=\"tg://user?id=" .. owner_id .. "\">" .. StringData(TeleBot.first_name) .. "</a>";
							end;
						end;
					end;
					local data1 = (TD.getChatAdministrators(msg.chat_id)).administrators;
					local t1 = "";
					for m, i in ipairs(data1) do
						if i.user_id then
							if i.is_owner == false then
								mod = i.user_id;
								base:sadd(TD_ID .. "ModList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModCleanList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModBanList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModMuteList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModWarnList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModLockList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModpanelList:" .. msg.chat_id, mod);
								base:sadd(TD_ID .. "ModVipList:" .. msg.chat_id, mod);
								print("Admin : " .. mod);
								TeleBot = TD.getUser(mod);
								if TeleBot.usernames.editable_username == "" then
									name = ec_name(TeleBot.first_name);
								else
									name = TeleBot.usernames.editable_username;
								end;
								t1 = t1 .. "🅼 " .. " <code>" .. mod .. "</code>-" .. "<a href=\"tg://user?id=" .. mod .. "\">" .. StringData(TeleBot.first_name) .. "</a>\n";
							end;
						end;
					end;
					TeleBot = TD.getUser(inviteruser);
					if TeleBot.usernames.editable_username == "" then
						name = ec_name(TeleBot.first_name);
					else
						name = TeleBot.usernames.editable_username;
					end;
					if not TeleBot.first_name then
						username = "<a href=\"tg://user?id=" .. inviteruser .. "\">" .. inviteruser .. "</a>";
					elseif TeleBot.first_name ~= "" then
						username = "<a href=\"tg://user?id=" .. inviteruser .. "\">" .. StringData(TeleBot.first_name) .. "</a>";
					else
						username = "<a href=\"tg://user?id=" .. inviteruser .. "\">" .. StringData(TeleBot.usernames.editable_username) .. "</a>";
					end;
					text2 = "❱ کاربر عزیز " .. username .. "\n✅ عملیات نصب تست ربات با موفقیت آغاز شد !\n\n⌯  مدت اعتبار تست " .. num .. " روز می باشد .\n\n┈┅┅━┃مرحله ❶┃ ━┅┅┈\n\n📌 جهت کارکرد صحیح لطفا ربات را ادمین کامل کنید .\n\n👥 سازنده گروه و مدیران شناسایی شدند .\n\n🔐 قفل های پیش فرض لینک ، ربات ، فوروارد ، یوزرنیم ، فعال شدند .\n\n┈┅┅━ ┃مرحله ❷┃━┅┅┈\n\n☜ برای تکمیل نصب ربات دکمه افزودن مکمل پاکسازی را لمس کنید .\n\n🎛 سپس جهت تنظیم ربات از دستور پنل می توانید استفاده کنید .\n\n💻 در صورت نیاز به خدمات پشتیبانی از دکمه ورود به گروه پشتیبانی استفاده کنید .\n\n\n🏆 کانال ربات : \n\nシ  " .. Channel .. "\n\n";
					base:set(TD_ID .. "tabchi_stats" .. msg.chat_id, "kick");
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "added");
					base:sadd(TD_ID .. "SuperGpFree", msg.chat_id);
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Link");
					base:sadd(TD_ID .. "Gp:" .. msg.chat_id, "Del:Username");
					base:set(TD_ID .. "warn_stats" .. msg.chat_id, "silenttime");
					base:set(TD_ID .. "mutetime:" .. msg.chat_id, tonumber(3600));
					base:set(TD_ID .. "Warn:Max:" .. msg.chat_id, tonumber(3));
					base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "Welcomeon");
					local gp = TD.getSupergroupFullInfo(msg.chat_id);
					local title = (TD.getChat(msg.chat_id)).title;
					aboutgp = (TD.getSupergroupFullInfo(msg.chat_id)).description;
					member_count = (TD.getSupergroupFullInfo(msg.chat_id)).member_count;
					restricted_count = (TD.getSupergroupFullInfo(msg.chat_id)).restricted_count;
					banned_count = (TD.getSupergroupFullInfo(msg.chat_id)).banned_count;
					slow_mode_delay_expires_in = (TD.getSupergroupFullInfo(msg.chat_id)).slow_mode_delay_expires_in;
					local data = TD.getChatAdministrators(msg.chat_id);
					tarikh = "" .. jdate("⌯ تاریخ #x #Y/#M/#D\n\n⌯ ساعت: #h:#m:#s") .. "";
					local keyboard1 = {};
					keyboard1.inline_keyboard = {
						{
							{
								text = "✦ اضافه کردن مکمل پاکسازی ✦",
								callback_data = "bd:addcleaner:" .. msg.chat_id
							}
						},
						{}
					};
					SendInlineBot(msg.chat_id, text2, keyboard1, "html");
					res = TD.getSupergroupFullInfo(msg.chat_id);
					link = res.invite_link.invite_link or "-";
					base:set(TD_ID .. "Link:" .. msg.chat_id, res.invite_link.invite_link);
					sendBot(BotCliId, 0, "نصب " .. res.invite_link.invite_link .. "", "html");
					Ramin = "\n🅵🆁🅴🅴 🄸🄽🅂🅃🄰🄻 【✓】\n\n\n◄ ربات در گروه " .. title .. " توسط " .. username .. " به صورت رایگان نصب شد !\n\n\nا┅┈┅┅┈┅┈🄸🄽🄵🄾 🅄🅂🄴🅁┈┅┈┅┅┈┅\n\n⌯ اضافه کننده : " .. username .. "\n\n⌯ آیدی کاربر : " .. inviteruser .. "\n\n" .. tarikh .. "\n\nا┅┈┅┅┈┅┈🄸🄽🄵🄾 🄶🅁🄾🅄🄿┈┅┈┅┅┈┅\n\n\n⌯ نام گروه : " .. title .. "\n\n⌯ تعداد ممبر : " .. member_count .. " کاربر\n\n\n⌯ شارژ اعتبار رایگان :" .. num .. " روز\n\n\n⌯ ایدی گروه : " .. msg.chat_id .. "\n\n⌯ لینک گروه :  \n\n\n" .. link .. "\n\n⌯ مالک گروه : \n\n\n" .. t .. "\n⌯ ادمین ها گروه : \n\n\n" .. t1 .. "\n\n🅵🆁🅴🅴 🄸🄽🅂🅃🄰🄻 【✓】\n\n";
					local keyboard = {};
					keyboard.inline_keyboard = {
						{
							{
								text = "خروج ربات ❌",
								callback_data = "bd:left:" .. msg.chat_id
							}
						},
						{}
					};
					SendInlineBot(Sudoid, Ramin, keyboard, "html");
				end;
			end;
		end;
	end;
	local baned = msg.new_chat_member.status["@type"] == "chatMemberStatusBanned";
	if msg.new_chat_member.status["@type"] == "chatMemberStatusMember" and msg.new_chat_member.member_id.user_id then
		usere = msg.new_chat_member.member_id.user_id;
		adder = msg.actor_user_id;
		local TeleBot = TD.getUser(usere);
		if TeleBot.type["@type"] == "userTypeBot" then
		elseif baned == false then
			user = msg.new_chat_member.member_id.user_id;
			inviteruser = msg.old_chat_member.inviter_user_id;
			if base:sismember(TD_ID .. "AddTekrari1:" .. msg.chat_id, user) then
			else
				base:sadd(TD_ID .. "AddTekrari1:" .. msg.chat_id, user);
				base:incr(TD_ID .. "Total:AddUser:" .. msg.chat_id .. ":" .. inviteruser);
				base:incr(TD_ID .. "Total:AddUserday:" .. msg.chat_id .. ":" .. os.date("%Y/%m/%d"));
				base:incr(TD_ID .. "Total:AddUser:" .. msg.chat_id);
				base:zincrby(TD_ID .. "bot:addusr2:" .. msg.chat_id .. ":", 1, inviteruser);
				base:zincrby(TD_ID .. "bot:addusr2day:" .. msg.chat_id .. ":", 1, inviteruser);
			end;
		end;
	end;
	if UserMute or Userban and (not is_FullChat(msg)) and (not is_SudoChat(msg)) and (not is_OwnerChat(msg)) then
		print("remove user");
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "Kheyanat:on") then
			nwarn = tonumber(base:hget(TD_ID .. "khwarn" .. msg.chat_id, msg.actor_user_id) or 0);
			wmax = tonumber(base:hget(TD_ID .. "khwarn" .. msg.chat_id, "khwarnmax") or 3);
			if nwarn + 1 == wmax then
				alpha = TD.getUser(msg.actor_user_id);
				if alpha.usernames.editable_username == "" then
					name = ec_name(alpha.first_name);
				else
					name = alpha.usernames.editable_username;
				end;
				local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
				local username = "<a href=\"tg://user?id=" .. msg.actor_user_id .. "\"> " .. ec_name(alpha.first_name) .. "</a> ";
				if base:get(TD_ID .. "kheyanat_stats" .. msg.chat_id) == "kick" then
					base:hdel(TD_ID .. "khwarn" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModListtest:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModCleanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModBanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModMuteList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModWarnList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModpanelList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModVipList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockOption:" .. msg.chat_id, msg.actor_user_id);
					text = "⌯  کاربر 〚" .. username .. " - <code>" .. msg.actor_user_id .. "</code>〛به علت حذف بی مورد ممبرهای گروه از ادمینی گروه عزل و از گروه اخراج شد ! ";
					TD.setChatMemberStatus(msg.chat_id, msg.actor_user_id, "banned");
					tarikh = jdate("📆 امروز #x\n📅  تاریخ ورود: #Y/#M/#D\n⏰ ساعت: #h:#m:#s");
					sendBot(msg.chat_id, msg.id, text, "html");
				elseif base:get(TD_ID .. "kheyanat_stats" .. msg.chat_id) == "silent" then
					base:hdel(TD_ID .. "khwarn" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModListtest:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModCleanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModBanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModMuteList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModWarnList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModpanelList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModVipList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockOption:" .. msg.chat_id, msg.actor_user_id);
					text = "⌯  کاربر 〚" .. username .. " - <code>" .. msg.actor_user_id .. "</code>〛به علت حذف بی مورد ممبرهای گروه از ادمینی گروه عزل و در گروه سکوت شد ! ";
					TD.setChatMemberStatus(msg.chat_id, msg.actor_user_id, "restricted", {
						1,
						0,
						0,
						0,
						0,
						0,
						0,
						0,
						0
					});
					tarikh = jdate("📆 امروز #x\n📅  تاریخ ورود: #Y/#M/#D\n⏰ ساعت: #h:#m:#s");
					sendBot(msg.chat_id, msg.id, text, "html");
				elseif base:get(TD_ID .. "kheyanat_stats" .. msg.chat_id) == "delmsg" then
					base:hdel(TD_ID .. "khwarn" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModListtest:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModCleanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModBanList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModMuteList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModWarnList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModpanelList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModVipList:" .. msg.chat_id, msg.actor_user_id);
					base:srem(TD_ID .. "ModLockOption:" .. msg.chat_id, msg.actor_user_id);
					text = "⌯  کاربر 〚" .. username .. " - <code>" .. msg.actor_user_id .. "</code>〛به علت حذف بی مورد ممبرهای گروه از ادمینی گروه عزل شد ! ";
					TD.setChatMemberStatus(msg.chat_id, msg.actor_user_id, "Administrator", {
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
					tarikh = jdate("📆 امروز #x\n📅  تاریخ ورود: #Y/#M/#D\n⏰ ساعت: #h:#m:#s");
					sendBot(msg.chat_id, msg.id, text, "html");
				end;
			else
				base:hset(TD_ID .. "khwarn" .. msg.chat_id, msg.actor_user_id, nwarn + 1);
			end;
		end;
	end;
end;
local CheckMasssageBot = function(msg, data)
	User = msg.sender_id.user_id;
	Chat = msg.chat_id;
	MassageID = msg.id;
	Data = data.message.content;
	local Ramin = Data.text and Data.text.text;
 
	if tonumber(User) == tonumber(BotJoiner) then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "cleanwelcome") then
			local RaminCaption = Data.caption and Data.caption.text and Data.caption.entities and Data.caption.entities[1] and Data.caption.entities[1].type["@type"] == "textEntityTypeMentionName";
			local RaminCaptionent = Data.caption and Data.caption.entities;
			if RaminCaption or RaminCaptionent then
			print('start')
				function cler()
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
					print('del')
					print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(msg.id) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[CleanWelcomeMSG]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
				end;
				JoinMSG = tonumber(base:get(TD_ID .. "cleanwelcometime:" .. Chat)) or 20;
				TD.set_timer(JoinMSG, cler);
			end;
		end;
	end;
	if Data["@type"] == "messageVideo" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageVideoDel") then
			function messageVideoDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageVideoDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageVideoDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageVideoDel);
		end;
	end;
	if Data["@type"] == "messageVoiceNote" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "MessageVoiceNoteDel") then
			function MessageVoiceNoteDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageVoiceNoteDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "MessageVoiceNoteDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, MessageVoiceNoteDel);
		end;
	end;
	if Data["@type"] == "messageAudio" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageAudioDel") then
			function messageAudioDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageAudioDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageAudioDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageAudioDel);
		end;
	end;
	if Data["@type"] == "messageSticker" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageStickerDel") then
			function messageStickerDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageStickerDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageStickerDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageStickerDel);
		end;
	end;
	if Data["@type"] == "messageAnimation" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageAnimationDel") then
			function messageAnimationDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageAnimationDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageAnimationDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageAnimationDel);
		end;
	end;
	if Data["@type"] == "messagePhoto" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messagePhotoDel") then
			function messagePhotoDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessagePhotoDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messagePhotoDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messagePhotoDel);
		end;
	end;
	if Data["@type"] == "messageDocument" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageDocumentDel") then
			function messageDocumentDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageDocumentDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageDocumentDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageDocumentDel);
		end;
	end;
	if Data["@type"] == "messageVideoNote" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "messageVideoNoteDel") then
			function messageVideoNoteDel()
				TD.deleteMessages(Chat, {
					[1] = MassageID
				});
				print(color.magenta[1] .. "⌯ MassageID:[" .. Alpha(MassageID) .. "]" .. color.yellow[1] .. " ⌯ MSGTYPE :[MessageVideoNoteDel]" .. color.blue[1] .. " ⌯ Time :[" .. os.date("%H:%M:%S") .. "]");
			end;
			JoinMSG = tonumber(base:get(TD_ID .. "messageVideoNoteDel:" .. Chat)) or 60;
			TD.set_timer(JoinMSG, messageVideoNoteDel);
		end;
	end;
	if Data["@type"] == "messageVoiceNote" then
		if base:sismember(TD_ID .. "Gp2:" .. Chat, "NameAntiTabchi") then
			if base:sismember("TabchiVoice:", Data.voice_note.voice.remote.unique_id) then
				if base:get(TD_ID .. "tabchi_stats" .. Chat) == "kick" then
					if base:sismember(TD_ID .. "Gp2:" .. Chat, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. User .. Chat)) then
							base:sadd("AGTMute:", User);
							text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. User .. "`〛در گروه شناسایی و مسدود شد !\n";
							sendBot(Chat, MassageID, text, "md");
							base:setex(TD_ID .. "TimerTabchi:" .. User .. Chat, 60, true);
						end;
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						KickUser(Chat, User);
						TD.setChatMemberStatus(Chat, User, "banned");
					else
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						KickUser(Chat, User);
						TD.setChatMemberStatus(Chat, User, "banned");
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. Chat) == "silent" then
					if base:sismember(TD_ID .. "Gp2:" .. Chat, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. User .. Chat)) then
							text = "◄ یک ربات تبچی  〚" .. username .. " - `" .. User .. "`〛در گروه شناسایی و سکوت شد !\n";
							base:sadd("AGTMute:", User);
							sendBot(Chat, MassageID, text, "md");
							base:setex(TD_ID .. "TimerTabchi:" .. User .. Chat, 60, true);
						end;
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						MuteUser(Chat, User, 0);
					else
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						MuteUser(Chat, User, 0);
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. Chat) == "delmsg" then
					if base:sismember(TD_ID .. "Gp2:" .. Chat, "Tabchi:Msg") then
						if not base:get((TD_ID .. "TimerTabchi:" .. User .. Chat)) then
							base:sadd("AGTMute:", User);
							base:setex(TD_ID .. "TimerTabchi:" .. User .. Chat, 60, true);
						end;
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
					else
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
					end;
				elseif base:get(TD_ID .. "tabchi_stats" .. Chat) == "off" then
				else
					return;
				end;
			end;
		end;
	end;
	if User and (not base:sismember((TD_ID .. "VipBio:" .. Chat), User)) and (not base:sismember((TD_ID .. "ModList:" .. Chat), User)) then
		result = TD.getUserFullInfo(User);
		if result.bio == "" then
			RaminAbout = "Nil";
		else
			RaminAbout = result.bio;
		end;
		if base:sismember(TD_ID .. "Gp:" .. Chat, "Del:Biolink") and base:sismember(TD_ID .. "Gp:" .. Chat, "setMogmsg") then
			Ga = RaminAbout:lower();
			if Ga:match("[Tt].[Mm][Ee]/") or Ga:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or Ga:match("سـ.ـوپـر") or Ga:match("سوپر") or Ga:match("فیلم") or Ga:match("خاله") or Ga:match("سکس") or Ga:match("09") or Ga:match("چک") then
				if not base:sismember((TD_ID .. "VipBio:" .. Chat), User) then
					if base:get(TD_ID .. "Bio_stats" .. Chat) == "kick" then
						KickUser(msg.chat_id, User);
						TD.setChatMemberStatus(Chat, User, "banned");
						TD.deleteMessages(msg.chat_id, {
							[1] = MassageID
						});
						base:sadd(TD_ID .. "BanUser:" .. Chat, User);
						setbio = "مسدود";
					elseif base:get(TD_ID .. "Bio_stats" .. Chat) == "silent" then
						MuteUser(Chat, User, 0);
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						base:sadd(TD_ID .. "MuteList:" .. Chat, User);
						setbio = "سکوت";
					elseif base:get(TD_ID .. "Bio_stats" .. Chat) == "silenttime" then
						local timebiomsg = tonumber(base:get(TD_ID .. "biotime:" .. Chat) or 120);
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						MuteUser(Chat, User, msg.date + timebiomsg);
						local Time = getTimeUptime(timebiomsg);
						base:sadd(TD_ID .. "MuteList:" .. Chat, User);
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
						setbio = "سکوت زمانی به مدت " .. Time .. "";
					elseif base:get(TD_ID .. "Bio_stats" .. Chat) == "tabchi" then
						MuteUser(Chat, User, 0);
						base:sadd(TD_ID .. "MuteList:" .. Chat, User);
						setbio = "ربات تبچی";
						base:sadd("AGTMute:", User);
						base:sadd(TD_ID .. "AGTMuteNume:" .. Chat, User);
						KickUser(Chat, User);
						TD.setChatMemberStatus(Chat, User, "banned");
						TD.deleteMessages(Chat, {
							[1] = MassageID
						});
					end;
					Ramin = TD.getUser(User);
					if Ramin.usernames.editable_username == "" then
						name = ec_name(Ramin.first_name);
					else
						name = Ramin.usernames.editable_username;
					end;
					local username = "<a href=\"tg://user?id=" .. User .. "\"> " .. ec_name(Ramin.first_name) .. "</a> ";
					base:set(TD_ID .. "Biolink1" .. Chat, User);
					local formidw = base:get(TD_ID .. "Biolink1" .. Chat);
					if base:sismember(TD_ID .. "Gp2:" .. Chat, "MsgCheckBio") then
						local keyboard = {};
						keyboard.inline_keyboard = {
							{
								{
									text = "⌯ رفع محدودیت",
									callback_data = "ScanMuteBio:" .. Chat .. ":" .. formidw .. ""
								}
							}
						};
						text = "⌯  کاربر 〚" .. username .. " - <code>" .. User .. "</code>〛 به دلیل داشتن لینک تبلیغاتی در گروه محدود شد !\n\n⌯ ┅┅━سیستم ضد بیوگرافی━┅┅ ⌯ \n\n📝 وضعیت مقابله :(ارسال پیام)  ";
						SendInlineBot(Chat, text, keyboard, "html");
					end;
				end;
			end;
		end;
	end;
	if Ramin == "Myposition." or Ramin == "من کیم" or Ramin == "مقام من" then
		if tonumber(msg.sender_id.user_id) == tonumber(2076851562) or tonumber(msg.sender_id.user_id) == tonumber(2076851562) then
			rank = "توسعه دهنده";
		elseif tonumber(msg.sender_id.user_id) == tonumber(Config.Sudoid) then
			rank = "سازنده ربات";
		elseif SudUser(msg, msg.sender_id.user_id) then
			rank = "سودو ربات";
		elseif OwnUserPlus(msg, msg.sender_id.user_id) then
			rank = "مالک ارشد";
		elseif OwnUser(msg, msg.sender_id.user_id) then
			rank = "مالک گروه";
		elseif NazemUser(msg, msg.sender_id.user_id) then
			rank = "معاون گروه";
		elseif ModUser(msg, msg.sender_id.user_id) then
			rank = "ادمین گروه";
		elseif ModUserTest(msg, msg.sender_id.user_id) then
			rank = "ادمین افتخاری";
		elseif VipUser(msg, msg.sender_id.user_id) then
			rank = "عضوویژه";
		else
			rank = "کاربر عادی";
		end;
		sendBot(msg.chat_id, msg.id, rank, "html");
	end;

	if (Ramin == "najva" or Ramin == "نجوا") and tonumber(msg.reply_to_message_id) > 0 then
		Rosha = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
		local user = Rosha.sender_id.user_id;
		if user then
			telebot = TD.getUser(user);
			if telebot.usernames.editable_username == "" then
				name = ec_name(telebot.first_name);
			else
				name = telebot.usernames.editable_username;
			end;
			sendBot(msg.chat_id, msg.id, "⌯ ┅┅━━ ارسال نجوا ━━┅┅ ⌯ \n\n⌯ نجوای شما بر روی کاربر  ( <a href=\"tg://user?id=" .. user .. "\">" .. ec_name(alpha.first_name) .. "</a> ) تنظیم شد !\n\n◄ لطفا متن نجوای خود را در خصوصی ربات ( <a href=\"tg://user?id=" .. BotJoiner .. "\">" .. (TD.getMe()).usernames.editable_username .. "</a> ) ارسال کنید...!", "html");
			base:setex(TD_ID .. "NajVa" .. msg.sender_id.user_id, 400, user .. ">" .. msg.chat_id .. ">" .. name);
			function NajvaClearPm()
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
			end;
			TD.set_timer(10, NajvaClearPm);
		end;
	end;
	if Ramin and (not is_Vip(msg)) then
		if is_filter(msg, Ramin) then
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
		end;
	end;
end;
local CheckMasssageDelete = function(msg, data)
--TD.vardump(data)
	UserID = msg.sender_id.user_id;
	Data = msg.content;
	ChatID = msg.chat_id;
	MsgID = msg.id;
	local Ramin =  Data.text and Data.text.text;
	if UserID == BotJoiner then
		local Ramin = Data and Data.text and Data.text.text;
		local RaminCaption = Data.caption and Data.caption.text and Data.caption.entities and Data.caption.entities[1] and Data.caption.entities[1].type["@type"] == "textEntityTypeMentionName";
		local BotMas = Data.text.entities and Data.text.entities[1] and Data.text.entities[1].type["@type"] == "textEntityTypeMentionName";
		if Ramin and BotMas and RaminCaption and Ramin:match("^⌯ ") and RaminCaption:match("^⌯ ") then
			if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cbmon") then
				function TeleBotClearCmd()
					TD.deleteMessages(msg.chat_id, {
						[1] = MsgID
					});
				end;
				local timecgms = tonumber(base:get(TD_ID .. "cbmtime:" .. msg.chat_id)) or 20;
				TD.set_timer(timecgms, TeleBotClearCmd);
			end;
		end;
	end;
	
	
	
	

	
	
	if UserID == BotJoiner then
			BotMas =  msg.content.text.entities and  msg.content.text.entities[1] and  msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName";
		if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "cleanwelcome") then
			--TD.vardump(BotMas)
			if BotMas or Ramin:match("^⌯ سلام") or Ramin:match("^💬 سلام") or Ramin:match("^✦ درود بر شما") or Ramin:match("^خوش اومدی") or Ramin:match("^خوش آمدید")  then
				print('start')
				function WelcomeClearPm()
				print('del')
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
				JoinMSG = tonumber(base:get(TD_ID .. "cleanwelcometime:" .. msg.chat_id)) or 20;
				TD.set_timer(JoinMSG, WelcomeClearPm);
			end;
		end;
	end;
	
	if base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "forceadd") then
		if Ramin:match(" ⌯ شما یک ربات اضافه کردید کاربر عادی اد کنید !") or Ramin:match("شما برای چت کردن در گروه باید") or Ramin:match("◄ درود بر شما") then
			function AddForceClear()
				TD.deleteMessages(msg.chat_id, {
					[1] = msg.id
				});
			end;
			Forcecleanpm = tonumber(base:get(TD_ID .. "JoinMSG:Time:" .. msg.chat_id)) or 15;
			TD.set_timer(Forcecleanpm, AddForceClear);
		end;
	end;
	if Ramin:match("⌯ برای ارسال پیام در کانال زیر عضو شوید !") then
		base:set(TD_ID .. "msgid_joins_13" .. msg.chat_id, msg.id);
	end;
	




		if Ramin:match("^https://t.me/joinchat/zSHfAKXy5zw4ZTU5")  then
		print('start')
		function tabtab()
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			print('del')
		end;
		
		TD.set_timer(3, tabtab);
	end;
	if Ramin:match("^⌯ برای ارسال پیام در کانال زیر عضو شوید !") or Ramin:match("^◄ یک ربات تبچی") or Ramin:match("^⌯ کاربر :") then
		print('start')
		function ForceChannelClear()
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			print('del')
		end;
		TIME_JoinMSG = tonumber(base:get(TD_ID .. "JoinMSG:Time:" .. msg.chat_id)) or 20;
		TD.set_timer(TIME_JoinMSG, ForceChannelClear);
	end;
	
	if Ramin:match("^◄ یک ربات تبچی") then
		print('start')
		function DelClear()
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			print('del')
		end;
		TD.set_timer(10, DelClear);
	end;
	if Ramin:match("^⫸ کاربر گرامی :") then
		print('start')
		function DelClear()
			TD.deleteMessages(msg.chat_id, {
				[1] = msg.id
			});
			print('del')
		end;
		checkpmtime = tonumber(base:get(TD_ID .. "checkpmtime:" .. msg.chat_id)) or 20;
		TD.set_timer(checkpmtime, DelClear);
	end;

	if Ramin:match("✧ درحال انجام عملیات ...") then 
		function ScanTabchi()
			TD.editMessageText(ChatID, MsgID, "✧ درحال انجام عملیات .\n\n✭ لطفا منتظر بمانید:\n ▓░░░░░░░░░10%", "md");
		end;
		TD.set_timer(5, ScanTabchi);
	end;
	if Ramin:match("✧ درحال انجام عملیات ...") then
		function ScanTabchi()
			TD.editMessageText(ChatID, MsgID, "✧ درحال انجام عملیات .. \n\n✭ لطفا منتظر بمانید :\n ▓▓▓░░░░░░░30%", "md");
		end;
		TD.set_timer(10, ScanTabchi);
	end;
	if Ramin:match("✧ درحال انجام عملیات ...") then
		function ScanTabchi()
			TD.editMessageText(ChatID, MsgID, "✧ درحال انجام عملیات ... \n\n✭ لطفا منتظر بمانید:\n ▓▓▓▓▓▓░░░░50%", "md");
		end;
		TD.set_timer(20, ScanTabchi);
	end;
	if Ramin:match("✧ درحال انجام عملیات ...") then
		function ScanTabchi()
			TD.editMessageText(ChatID, MsgID, "✧ درحال انجام عملیات ..\n\n✭ لطفا منتظر بمانید:\n ▓▓▓▓▓▓▓▓▓░90%", "md");
		end;
		TD.set_timer(25, ScanTabchi);
	end;
	if Ramin:match("✧ درحال انجام عملیات ...") then
		function ScanTabchi()
			TD.editMessageText(ChatID, MsgID, "✧ درحال انجام عملیات .\n\n✭ لطفا منتظر بمانید:\n ▓▓▓▓▓▓▓▓▓▓100%", "md");
		end;
		TD.set_timer(30, ScanTabchi);
	end;
	if Ramin:match("✧ درحال انجام عملیات ...") then
		function ScanTabchi()
			TD.deleteMessages(ChatID, {
				[1] = MsgID
			});
		end;
		TD.set_timer(38, ScanTabchi);
	end;


	
end;
local PanelBot = function(msg, data)
	UserID = msg.sender_id.user_id;
	Data = msg.content;
	ChatID = msg.chat_id;
	MsgID = msg.id;

	if UserID == BotJoiner then
		if msg.content then
			if msg.reply_markup and msg.reply_markup._ == "replyMarkupInlineKeyboard" then
			local Ramin = Data and Data.text and Data.text.text;
			if Ramin:match("• بخش مورد نظر را انتخاب کنید :") then
				base:setex(TD_ID .. "PanelAutoCall:" .. msg.chat_id, 60, true);
				base:set(TD_ID .. "PanelMSGCall:" .. msg.chat_id, msg.id);
				base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "PanelAutoCall");
				base:sadd(TD_ID .. "msgmessageinline:" .. msg.chat_id, msg.id);
			end;
		end;
		end;
	end;

		
end;
local UpdateCallback = function(msg, data)
	if msg.chat_instance and msg.payload["@type"] == "callbackQueryPayloadData" then
		base:setex(TD_ID .. "PanelAutoCall:" .. msg.chat_id, 60, true);
		base:setex(TD_ID .. "TimerPanel:" .. msg.sender_id.user_id .. msg.chat_id, 60, true);
		base:set(TD_ID .. "PanelMSGCall:" .. msg.chat_id, msg.message_id);
		base:sadd(TD_ID .. "Gp2:" .. msg.chat_id, "PanelAutoCall");
		base:sadd(TD_ID .. "msgmessageinline:" .. msg.chat_id, msg.message_id);
	end;
end;





local BotGetQuery = function(msg, data)
	--TD.vardump(msg)
	local callback = TD.base64_decode(msg.payload.data)
	local result = TD.getRepliedMessage(msg.chat_id, msg.message_id)
	local is_Mod = function(chat_id, user_id)
		local var = false;
		for v, user in pairs(SUDO) do
			if user == user_id then
				var = true;
			end;
		end;
		local owner = base:sismember(TD_ID .. "OwnerList:" .. msg.chat_id, msg.sender_id.user_id);
		local ownerPlus = base:sismember(TD_ID .. "OwnerListPlus:" .. msg.chat_id, msg.sender_id.user_id);
		local nazem = base:sismember(TD_ID .. "NazemList:" .. msg.chat_id, msg.sender_id.user_id);
		local hash = base:sismember(TD_ID .. "ModList:" .. msg.chat_id, msg.sender_id.user_id);
		local Sudo = base:sismember(TD_ID .. "SUDO", msg.chat_id);
		if hash or owner or Sudo or ownerPlus or nazem then
			var = true;
		end;
		return var;
	end;
	--TD.vardump(result.sender_id.user_id)

	Click = tonumber(base:get(TD_ID .. "CheckClick:" .. msg.sender_id.user_id)) or 0
	if Click > 6 then
		base:del(TD_ID .. "CheckClick:" .. msg.sender_id.user_id)
		base:setex(TD_ID .. "LimitedClick3:" .. msg.sender_id.user_id, 3, true)
		if rank(msg.sender_id.user_id, msg.chat_id) <= 4 then
		  --return TD.answerCallbackQuery(msg.id, "📣 کاربر عزیز یکمی آرامتر از دکمه ربات استفاده کنید تا شامل محدودیت تلگرام نشویم 🤨", true)
		else
		  if not tostring(msg.chat_id):match("^-") then
			return false
		  end
		  return TD.setChatMemberStatus(msg.chat_id, msg.sender_id.user_id, "banned")
		end
	  end
	  if base:get(TD_ID .. "LimitedClick3:" .. msg.sender_id.user_id) then
		if rank(msg.sender_id.user_id, msg.chat_id) <= 4 then
		  --return TD.answerCallbackQuery(msg.id, "🚨 لطفا چند ثانیه صبر کنید و دوباره روی دکمه ها کلیک کنید ▸", true)
		else
		  return false
		end
	  end
	  base:setex(TD_ID .. "CheckClick:" .. msg.sender_id.user_id, 3, Click + 1)
	 
	  -- if result and (result.sender_id.user_id or msg.sender_id.user_id) ~= msg.sender_id.user_id then
		  -- TD.answerCallbackQuery(msg.id, " پنل مدیریتی از شما فرمان نمی گیرد !", true);
		  -- return;
	  -- end; 
	  -- if not is_Mod(msg.chat_id, msg.sender_id.user_id) then
		-- inlineeqq = base:get(TD_ID .. "antiattackinline:" .. msg.sender_id.user_id .. ":" .. msg.chat_id) or 0;
		-- if tonumber(inlineeqq) < 6 then
			-- base:setex(TD_ID .. "antiattackinline:" .. msg.sender_id.user_id .. ":" .. msg.chat_id, 60, inlineeqq + 1);
			-- TD.answerCallbackQuery(msg.id, "⚠️ پنل مدیریتی از شما فرمان نمی گیرد !\nدرصورت کلیک بی مورد از گروه اخراج خواهید شد!", true);
		-- else
			-- ---KickUser(msg.chat_id, msg.sender_id.user_id);
		-- end;
		-- return;
	-- end;
	  local function keyboards(table_)
		return TD.replyMarkup({
			type = "inline",
			data = table_
		});

    
	end; 
	local MentionUser = function(user_id)
		local result = TD.getUser(user_id);
		if result and result.first_name then
			return "<a href=\"tg://user?id=" .. user_id .. "\">" .. string.gsub(result.first_name, "[<>]", "") .. "</a>";
		else
			return "<a href=\"tg://user?id=" .. user_id .. "\">" .. user_id .. "</a>";
		end;
	end;
	if callback and string.match(callback, "^actevemem$") then
		salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
		base:srem(TD_ID .. "sender_id.user_ids:" .. msg.chat_id, BotJoiner);
			local msgs, msgsday, adds, addsday = {}, {}, {}, {};
			local function getNum(data, rank, status)
				if data == "msgs" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id)) do
								local getUser = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. msg.chat_id) or 0;
								if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
									_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉",
										["4"] = "چهارم 🏅",
										["5"] = "پنجم 🎖",
									
									}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
									table.remove(msgs, #msgs);
									base:srem(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgs" then
						base:del(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id);
					end;
				end;
			end;
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. msg.chat_id)) do
						base:sadd(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id, i);
						base:sadd(TD_ID .. "_sender_id.user_idsd:" .. msg.chat_id, i);
						base:sadd(TD_ID .. "sender_id.user_ids_:" .. msg.chat_id, i);
						local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. msg.chat_id) or 0;
						if 0 < tonumber(getUser) and getUser then
							table.insert(msgs, tonumber(getUser));
						end;
						if 0 < tonumber(getUserday) and getUserday then
							table.insert(msgsday, tonumber(getUserday));
						end;
						if 0 < tonumber(getUser_) and getUser_ then
							table.insert(adds, tonumber(getUser_));
						end;
						if 0 < tonumber(getUserDay_) and getUserDay_ then
							table.insert(adds, tonumber(getUserDay_));
						end;
					end;
				end;
			end;
			table.sort(msgs);
			table.sort(msgsday);
			table.sort(adds);
			table.sort(addsday);
			counter = 5;
			if counter then
				local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. msg.chat_id));
				if members < tonumber(counter) then
					_c = members;
				else
					_c = tonumber(counter);
				end;
				Userban = base:get(TD_ID .. "All:Userban:" .. msg.chat_id) or 0;
				Useraddban = base:get(TD_ID .. "All:Useraddban:" .. msg.chat_id) or 0;
				Userdelban = base:get(TD_ID .. "All:Userdelban:" .. msg.chat_id) or 0;
				Usernewadd = base:get(TD_ID .. "All:Usernewadd:" .. msg.chat_id) or 0;
				Userleft = base:get(TD_ID .. "All:Userleft:" .. msg.chat_id) or 0;
				UserMute = base:get(TD_ID .. "All:UserMute:" .. msg.chat_id) or 0;
				UserDelMute = base:get(TD_ID .. "All:UserDelMute:" .. msg.chat_id) or 0;
				JoinedGroup = base:get(TD_ID .. "All:Usernewjoin:" .. msg.chat_id) or 0;
				Text = base:get(TD_ID .. "All:Text:" .. msg.chat_id) or 0;
				Document = base:get(TD_ID .. "All:Document:" .. msg.chat_id) or 0;
				Video = base:get(TD_ID .. "All:Video:" .. msg.chat_id) or 0;
				Photo = base:get(TD_ID .. "All:Photo:" .. msg.chat_id) or 0;
				Voice = base:get(TD_ID .. "All:Voice:" .. msg.chat_id) or 0;
				Audio = base:get(TD_ID .. "All:Audio:" .. msg.chat_id) or 0;
				Animation = base:get(TD_ID .. "All:Animation:" .. msg.chat_id) or 0;
				Stricker = base:get(TD_ID .. "All:Stricker:" .. msg.chat_id) or 0;
				Forwarded = base:get(TD_ID .. "All:Forward:" .. msg.chat_id) or 0;
				VideoNote = base:get(TD_ID .. "All:VideoNote:" .. msg.chat_id) or 0;
				_resultTEXT = "◄ فعالیت های کل گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار کل ─┅━━\n\n";
				for i = 1, _c do
					_resultTEXT = _resultTEXT;
					getNum("msgs", i);
				end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		  local result = TD.getSupergroupFullInfo(msg.chat_id);
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT.."\n\n┈┅━آمار کل ورود خروج━┅┈\n\n✮ تعداد اعضا :" .. result.member_count .. "\n✮ اعضای جدید : " .. JoinedGroup .. "\n✮ تعداد ادمین ها : " .. result.administrator_count .. "\n✮ اعضای اخراج شده : " .. result.banned_count .. "\n✮ اعضای سکوت شده : " .. result.restricted_count .. "\n\n┈┅━آمار کل پیام━┅┈\n\n✦ کل پیام ها : " .. (base:get(TD_ID .. "All:Message:" .. msg.chat_id) or 0) .. "\n✦ متن ها : " .. Text .. "\n✦ گیف ها : " .. Animation .. "\n✦ فیلم ها : " .. Video .. "\n✦ عکس ها : " .. Photo .. "\n✦ صداها : " .. Voice .. "\n✦ استیکر ها : " .. Stricker .. "\n✦ فایل ها : " .. Document .. "\n✦ فیلم سلفی : " .. VideoNote .. "\n✦ فورواردی ها : " .. Forwarded .. "", "html");
	end;
elseif  callback and string.match(callback, "^actevemodday$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	base:srem(TD_ID .. "sender_id.user_ids:" .. msg.chat_id, BotJoiner);
			local msgs, msgsday, adds, addsday = {}, {}, {}, {};
			local function getNum(data, rank, status)
				if data == "msgsday" then
					do
						do
							for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id)) do
								local getUser = base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. msg.chat_id) or 0;
								if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
									_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
										["1"] = "اول 🥇",
										["2"] = "دوم 🥈",
										["3"] = "سوم 🥉",
										["4"] = "چهارم 🏅",
										["5"] = "پنجم 🎖",
									}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
									table.remove(msgsday, #msgsday);
									base:srem(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id, i);
									break;
								end;
							end;
						end;
					end;
					if status == "msgs" then
						base:del(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id);
					end;
				end;
			end;
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. msg.chat_id)) do
						local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
						base:sadd(TD_ID .. "_sender_id.user_ids:" .. msg.chat_id, i);
						base:sadd(TD_ID .. "_sender_id.user_idsd:" .. msg.chat_id, i);
						base:sadd(TD_ID .. "sender_id.user_ids_:" .. msg.chat_id, i);
						local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:MsgsDay:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. msg.chat_id) or 0, base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. msg.chat_id) or 0;
						if 0 < tonumber(getUser) and getUser then
							table.insert(msgs, tonumber(getUser));
						end;
						if 0 < tonumber(getUserday) and getUserday then
							table.insert(msgsday, tonumber(getUserday));
						end;
						if 0 < tonumber(getUser_) and getUser_ then
							table.insert(adds, tonumber(getUser_));
						end;
						if 0 < tonumber(getUserDay_) and getUserDay_ then
							table.insert(adds, tonumber(getUserDay_));
						end;
					end;
				end;
			end;
			table.sort(msgs);
			table.sort(msgsday);
			table.sort(adds);
			table.sort(addsday);
			counter = 10;
			if counter then
				local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. msg.chat_id));
				if members < tonumber(counter) then
					_c = members;
				else
					_c = tonumber(counter);
				end;
				_resultTEXT = "◄ فعالیت های امروز گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار امروز ─┅━━\n\n";
				for i = 1, _c do
					_resultTEXT = _resultTEXT;
					getNum("msgsday", i);
				end;
				
		
	Button = {
		{
		 
		  {
			text = "بازگشت ⊴",
			data = "bd:statsmem:" .. msg.chat_id
		  }
		}
	  }
	TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
end;



elseif  callback and string.match(callback, "^actevemodcmdmedia$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:MediaMsgs:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:MediaMsgs:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:MediaMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های کل رسانه ها به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار رسانه ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;



elseif  callback and string.match(callback, "^actevemodlist$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های کل مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار مدیران ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;

elseif  callback and string.match(callback, "^actevemodlistaddday$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های امروز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار امروز مدیران ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
--###############################
elseif  callback and string.match(callback, "^StatsOther2All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs2Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های دو روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار دو روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
	elseif  callback and string.match(callback, "^StatsOther3All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs3Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های سه روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار سه روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
		elseif  callback and string.match(callback, "^StatsOther4All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs4Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های چهار روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار چهار روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
	elseif  callback and string.match(callback, "^StatsOther5All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs5Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های پنچ روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار پنچ روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
		elseif  callback and string.match(callback, "^StatsOther6All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs6Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های شش روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار شش روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
	
	
	elseif  callback and string.match(callback, "^StatsOther7All$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgs[(#msgs)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgs, #msgs);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:Msgs7Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های هفت روز پیش کل کاربران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━━┅─ آمار هفت روز ─┅━━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAll:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
--###############################

elseif  callback and string.match(callback, "^StatsOther2Admin$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs2Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های دو روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار دو روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;


elseif  callback and string.match(callback, "^StatsOther3Admin$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs3Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های سه روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار سه روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;




elseif  callback and string.match(callback, "^StatsOther4Admin$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs4Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های چهار روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار چهار روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;


elseif  callback and string.match(callback, "^StatsOther5Admin$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs5Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های پنچ روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار پنچ روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
	
	
	
	
	elseif  callback and string.match(callback, "^StatsOther6Admin$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs6Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های شش روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار شش روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
elseif  callback and string.match(callback, "^StatsOther7Admin$") then

	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " پیام | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgs7Day:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های هفت روز مدیران گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار هفت روز ادمین ها ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgs", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:StatsOtherAdmin:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
---##################################
elseif  callback and string.match(callback, "^acteveadd$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " اد | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:Adds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های امروز اد کل گروه به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار اد کل ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgsday", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;
elseif  callback and string.match(callback, "^acteveaddday$") then
	salen = jdate("#Y");
		mahen = jdate("#M");
		rozeen = jdate("#D");
		hoen = jdate("#h");
		minen = jdate("#m");
		secen = jdate("#s");
		local roz = jdate("#x");
		Salene = string.format("%02d", tonumber(salen));
		Mahene = string.format("%02d", tonumber(mahen));
		Rozene = string.format("%02d", tonumber(rozeen));
		hour = string.format("%02d", tonumber(hoen));
		minit = string.format("%02d", tonumber(minen));
		seco = string.format("%02d", tonumber(secen));
		local tarikhnumberen = "" .. Salene .. "/" .. Mahene .. "/" .. Rozene .. "";
		local tarikhnumberfa = "" .. Roshafa(Salene) .. "/" .. Roshafa(Mahene) .. "/" .. Roshafa(Rozene) .. "";
		local timeen = "" .. hour .. ":" .. minit .. ":" .. seco .. "";
		local timefa = "" .. Roshafa(hour) .. ":" .. Roshafa(minit) .. ":" .. Roshafa(seco) .. "";
		local TarikhEN = "📆 امروز " .. roz .. " " .. tarikhnumberen .. "\n⏰ ساعت : " .. timeen .. "";
		local TarikhFA = "📆 امروز " .. roz .. " " .. tarikhnumberfa .. "\n⏰ ساعت : " .. timefa .. "";
	local chat_id = msg.chat_id
	base:srem(TD_ID .. "sender_id.user_ids:" .. chat_id, BotJoiner);
	local msgs, msgsday, adds, addsday = {}, {}, {}, {};
	local function getNum(data, rank, status)
		if data == "msgs" then
			do 
				do
					for k, i in pairs(base:smembers(TD_ID .. "_sender_id.user_ids:" .. chat_id)) do
						local getUser = base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0;
						if tonumber(getUser) == tonumber(msgsday[(#msgsday)]) then
							_resultTEXT = _resultTEXT .. "- مقام " .. string.gsub(rank, "[12345]", {
								["1"] = "اول 🥇",
								["2"] = "دوم 🥈",
								["3"] = "سوم 🥉",
								["4"] = "چهارم 🏅",
								["5"] = "پنجم 🎖",
							}) .. " :\n <b>(" .. Alpha(getUser) .. " اد | " .. MentionUser(i) .. ")</b>\n\n";
							table.remove(msgsday, #msgsday);
							base:srem(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
							break;
						end;
					end;
				end;
			end;
			if status == "msgs" then
				base:del(TD_ID .. "_sender_id.user_ids:" .. chat_id);
			end;
		end;
	end;
	do
		do
			for k, i in pairs(base:smembers(TD_ID .. "sender_id.user_ids:" .. chat_id)) do
				local namee = base:get(TD_ID .. "UserName:" .. i) or base:get(TD_ID .. "FirstName:" .. i);
				base:sadd(TD_ID .. "_sender_id.user_ids:" .. chat_id, i);
				base:sadd(TD_ID .. "_sender_id.user_idsd:" .. chat_id, i);
				base:sadd(TD_ID .. "sender_id.user_ids_:" .. chat_id, i);
				local getUser, getUserday, getUser_, getUserDay_ = base:get(TD_ID .. "Content_Message:AddsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminMsgsDay:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAdds:" .. i .. ":" .. chat_id) or 0, base:get(TD_ID .. "Content_Message:AdminAddsDay:" .. i .. ":" .. chat_id) or 0;
				if 0 < tonumber(getUser) and getUser then
					table.insert(msgs, tonumber(getUser));
				end;
				if 0 < tonumber(getUserday) and getUserday then
					table.insert(msgsday, tonumber(getUserday));
				end;
				if 0 < tonumber(getUser_) and getUser_ then
					table.insert(adds, tonumber(getUser_));
				end;
				if 0 < tonumber(getUserDay_) and getUserDay_ then
					table.insert(adds, tonumber(getUserDay_));
				end;
			end;
		end;
	end;
	table.sort(msgs);
	table.sort(msgsday);
	table.sort(adds);
	table.sort(addsday);
	counter = 10;
	if counter then
		local members = #base:smembers((TD_ID .. "sender_id.user_ids:" .. chat_id));
		if members < tonumber(counter) then
			_c = members;
		else
			_c = tonumber(counter);
		end;
		_resultTEXT = "◄ فعالیت های امروز اد کاربران به تعداد " .. _c .. " نفر به شرح ذیل می باشد :\n\n<b>"..TarikhEN.."</b>\n\n━┅─ آمار اد امروز  ─┅━\n\n";
		for i = 1, _c do
			_resultTEXT = _resultTEXT;
			getNum("msgsday", i);
		end;
		Button = {
			{
			 
			  {
				text = "بازگشت ⊴",
				data = "bd:statsmem:" .. msg.chat_id
			  }
			}
		  }
		TD.editMessageText_(msg.chat_id, msg.message_id, keyboards(Button), _resultTEXT, "html");
	end;

	end;
end;

local function updateNewMessage(data)

	MrTeleGrami(data.message, data);
	CheckMasssageBot(data.message, data);
	PanelBot(data.message, data);
end;
local function updateChatMember(msg)
	MrTeleGramiChatMember(msg, data);
end;
local function updateMessageSendSucceeded(data)

	
		CheckMasssageDelete(data.message, data);
		--TD.vardump(data)
	
end;
local function updateSupergroup(data)
	if data.supergroup.status._ == "chatMemberStatusRestricted" then
	end;
end;
local function updateNewCallbackQuery(msg)
	UpdateCallback(msg, data);
	BotGetQuery(msg, data);
end;

tdlib.run({
	updateNewMessage = updateNewMessage,
	updateChatMember = updateChatMember,
	updateMessageSendSucceeded = updateMessageSendSucceeded,
	updateSupergroup = updateSupergroup,
	updateNewCallbackQuery = updateNewCallbackQuery,
	
});
