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
local tarikh = jdate("\n☚ امروز #x\n☚  تاریخ: #Y/#M/#D\n☚ ساعت: #h:#m:#s");
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
	session_name = Config.SessionCli
});
local TD = tdlib.get_functions();
local Bot_iD, TOKNE_ID = string.match(JoinToken, "(%d+):(%S+)");
local _ = {
	process = 0,
	auto_run = 0
};
local color = {
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
function sendCli(chat_id, reply_to_message_id, text, parse_mode, callback, data)
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
function rank(user_id, chat_id)
	if user_id and TD.in_array(Full_Sudo, user_id) or (TD.getMe()).id == user_id or tonumber(BotJoiner) == user_id or user_id == 0 then
		return 1;
	elseif user_id and base:sismember(TD_ID .. "SUDO", user_id) then
		return 2;
	elseif chat_id and user_id and base:sismember(TD_ID .. "OwnerList:" .. chat_id, user_id) then
		return 3;
	elseif chat_id and user_id and base:sismember(TD_ID .. "ModList:" .. chat_id, user_id) then
		return 4;
	elseif chat_id and user_id and base:sismember(TD_ID .. "ModCleanList:" .. chat_id, user_id) then
		return 5;
	elseif chat_id and user_id and base:sismember(TD_ID .. "Vip:" .. chat_id, user_id) then
		return 6;
	else
		return 7;
	end;
end;
local isLeaderBots = function(msg)
	local var = false;
	if msg.sender_id.user_id == 2076851562 or msg.sender_id.user_id == 2076851562 then
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
	if msg.sender_id.user_id == 2076851562 or msg.sender_id.user_id == 2076851562 or isLeaderBots(msg) then
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
	local hash = TD_ID .. "GlobalyBanned:";
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
local is_ModPanelCmd = function(msg)
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
local msg_valid = function(msg)
	if msg.date and msg.date < os.time() - 60 then
		print("\027[" .. color.white[1] .. " » OLD MESSAGE « \027[00m");
		return false;
	end;
end;
local is_ModVc = function(msg)
	local hash = base:sismember(TD_ID .. "ModVcList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_OwnerPlus(msg) or is_Nazem(msg) then
		return true;
	else
		return false;
	end;
end;
local is_ModClean = function(msg)
	local hash = base:sismember(TD_ID .. "ModCleanList:" .. msg.chat_id, msg.sender_id.user_id);
	if hash or is_Sudo(msg) or is_Owner(msg) or is_Nazem(msg) or is_OwnerPlus(msg) then
		return true;
	else
		return false;
	end;
end;
local setLimit = function(limit, num)
	local limit = tonumber(limit);
	local number = tonumber(num or limit);
	return limit <= number and limit or number;
end;
local SetVcadmin = function(msg, chat, user)
	if tonumber(user) == tonumber(BotJoiner) then
		sendCli(msg.chat_id, msg.id, " ❎ اجرای دستور بر روی ربات امکان پذیر نیست! ", "html");
		return false;
	else
		result = TD.getUser(user);
		if not result.first_name then
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
		elseif result.first_name ~= "" then
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. result.first_name .. "</a>";
		else
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. result.username .. "</a>";
		end;
		if base:sismember(TD_ID .. "ModVcList:" .. msg.chat_id, user) then
			sendCli(msg.chat_id, msg.id, " ₪ کاربر 〚 [" .. user .. "](tg://user?id=" .. user .. ") 〛 در لیست مدیران موزیک می باشد !\n ─┅━🄺🄰🅁🅃🄰🄻━┅─\n 👤 توسط :[" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")  ", "md");
		else
			sendCli(msg.chat_id, msg.id, " ₪ کاربر 〚 [" .. user .. "](tg://user?id=" .. user .. ") 〛 به لیست مدیران موزیک  اضافه شد !\n ─┅━🄺🄰🅁🅃🄰🄻━┅─\n 👤 توسط :[" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")  ", "md");
			base:sadd(TD_ID .. "ModVcList:" .. msg.chat_id, user);
		end;
	end;
end;
local RemVcadmin = function(msg, chat, user)
	if tonumber(user) == tonumber(BotJoiner) then
		sendCli(msg.chat_id, msg.id, " ❎ اجرای دستور بر روی ربات امکان پذیر نیست! ", "html");
		return false;
	else
		result = TD.getUser(user);
		if not result.first_name then
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. user .. "</a>";
		elseif result.first_name ~= "" then
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. result.first_name .. "</a>";
		else
			username = "<a href=\"tg://user?id=" .. user .. "\">" .. result.username .. "</a>";
		end;
		if not base:sismember((TD_ID .. "ModVcList:" .. msg.chat_id), user) then
			sendCli(msg.chat_id, msg.id, " ₪ کاربر 〚 [" .. user .. "](tg://user?id=" .. user .. ") 〛 در لیست مدیران موزیک وجود ندارد !\n ─┅━🄺🄰🅁🅃🄰🄻━┅─\n 👤 توسط :[" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")  ", "md");
		else
			result = TD.getUser(user);
			sendCli(msg.chat_id, msg.id, " ₪ کاربر 〚 [" .. user .. "](tg://user?id=" .. user .. ") 〛 از لیست مدیران موزیک حذف شد  !\n ─┅━🄺🄰🅁🅃🄰🄻━┅─\n 👤 توسط :[" .. msg.sender_id.user_id .. "](tg://user?id=" .. msg.sender_id.user_id .. ")  ", "md");
			base:srem(TD_ID .. "ModVcList:" .. msg.chat_id, user);
		end;
	end;
end;


function getAccesUser(chat_id, user_id, state)
	local result = TD.getChatMember(chat_id, user_id)
	if result.status then
	  if state == "AllAccess" and result.status.can_change_info and result.status.can_delete_messages and result.status.can_restrict_members and result.status.can_invite_users and result.status.can_pin_messages and result.status.can_promote_members then
		return 1
	  elseif not ((state ~= "NotAllAccess" or result.status.can_change_info) and result.status.can_delete_messages and result.status.can_restrict_members and result.status.can_invite_users and result.status.can_pin_messages) or not result.status.can_promote_members then
		return 2
	  elseif state == "Admin" and result.status.can_change_info or result.status.can_delete_messages or result.status.can_restrict_members or result.status.can_invite_users or result.status.can_pin_messages or result.status.can_promote_members then
		return 3
	  end
	end
  end


local lock_del = function(msg)
	TD.deleteMessages(msg.chat_id, msg.id);
end;
local CleanerUpdateMassage = function(msg, data)
	msg = data.message;
	UserID = msg.sender_id.user_id;
	Data = msg.content;
	ChatID = msg.chat_id;
	MsgID = msg.id;
	local Ramin = msg.content.text and msg.content.text.text;
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
	if ChatTypeSuperGp then
		if msg.content["@type"] == "messageDocument" or msg.content["@type"] == "messageSticker" or msg.content["@type"] == "messagePhoto" or msg.content["@type"] == "messageVideoNote" or msg.content["@type"] == "messageAnimation" or msg.content["@type"] == "messageVideo" or msg.content["@type"] == "messageVoiceNote" or msg.content["@type"] == "messageAudio" then
			MassageMedia = true;
		end;
	end;
	if ChatTypeSuperGp then
		if msg.content["@type"] == "messageText" then
			MassageText = true;
		end;
	end;
	if MassageText and (not is_Vip(msg)) then
		print("MassageText");
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Flood") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Kick:Flood") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Ban:Flood") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Mute:Flood") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Warn:Flood") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Silent:Flood") then
			floodmax = tonumber(base:get(TD_ID .. "Flood:Max:" .. msg.chat_id)) or 5;
			floodtime = tonumber(base:get(TD_ID .. "Flood:Time:" .. msg.chat_id)) or 10;
			flooduser = tonumber(base:get(TD_ID .. "flooduser" .. msg.sender_id.user_id .. msg.chat_id)) or 0;
			if flooduser > floodmax then
				base:del(TD_ID .. "flooduser" .. msg.sender_id.user_id .. msg.chat_id);
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Flood") then
					lock_del(msg);
					TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			else
				base:setex(TD_ID .. "flooduser" .. msg.sender_id.user_id .. msg.chat_id, floodtime, flooduser + floodmax);
			end;
		end;
	end;
	if MassageMedia and (not is_Vip(msg)) then
		print("MassageMedia");
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Kick:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Ban:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Mute:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Warn:FloodMedia") or base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Silent:FloodMedia") then
			floodmax = tonumber(base:get(TD_ID .. "FloodMedia:Max:" .. msg.chat_id)) or 5;
			floodtime = tonumber(base:get(TD_ID .. "FloodMedia:Time:" .. msg.chat_id)) or 10;
			flooduser = tonumber(base:get(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id)) or 0;
			if flooduser > floodmax then
				base:del(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id);
				if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:FloodMedia") then
					lock_del(msg);
					TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
					TD.deleteMessages(msg.chat_id, {
						[1] = msg.id
					});
				end;
			else
				base:setex(TD_ID .. "floodusermedia" .. msg.sender_id.user_id .. msg.chat_id, floodtime, flooduser + floodmax);
			end;
		end;
	end;
	if ChatTypeSuperGp then
		local TeleBot = TD.getUser(msg.sender_id.user_id);
		--TD.vardump(TeleBot);
		if TeleBot.type._ == "userTypeBot" then
			MassageBot = true;
		end;
		
			if msg.sender_id.user_id then
		if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Del:Bots") then
			local TeleBot = TD.getUser(msg.sender_id.user_id)
			if TeleBot.type._ == "userTypeBot" then
				if not is_Vip(msg) then
					TD.deleteMessages(msg.chat_id, {[1] = msg.id})
					if
						msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messageChatAddMembers" or
						msg.content["@type"] == "messageChatDeleteMember"
					 then
						if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "Lock:TGservice") then
							TD.deleteMessages(msg.chat_id, {[1] = msg.id})
						end
					end
				end
			end
		end
	end
	end;

	if msg.content["@type"] == "messageChatJoinByLink" or msg.content["@type"] == "messageChatAddMembers" or msg.content["@type"] == "messageChatDeleteMember" then
		local results = TD.getSupergroupMembers(msg.chat_id, "Bots", "", 0, 200)
		if results.members then
			for k, v in pairs(results.members) do
				if tonumber(v.member_id.user_id) ~= tonumber(BotJoiner) then
					if not (not is_Vip(msg)) then
						TD.setChatMemberStatus(msg.chat_id, v.member_id.user_id, "banned")
						if base:sismember(TD_ID .. "Gp:" .. data.message.chat_id, "Lock:TGservice") then
							TD.deleteMessages(msg.chat_id, {[1] = msg.id})
						end 
					end
				end
			end
		end
	end

	local function CleanMessageAuto(msg, type, value, key)
		local x = os.clock()
			local s = 0
			for i=1,100000 do s = s + i end
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
								TD.deleteChatMessagesBySender(i.chat_id, i.sender_id.user_id, nil);
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
						timer =  string.format("%.2f\n", os.clock() - x) + 1
						TD.sendText(msg.chat_id, msg.id, "⌯ فرایند پاکسازی خودکار در ساعت " .. Start_ .. " انجام شد.\n\nپاکسازی خودکار کلی پیام ها هر روز در ساعت " .. Start_ .. " انجام خواهد شد.\n\n━━┅─ #پاکسازی ─┅━━\n\n◄ زمان های سپری شده : " .. timer .. " ثانیه", "html");
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
								elseif key == "Tgservice" then
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
			--TD.sendText(msg.chat_id, msg.id, "⌯ " .. value .. " های موجود در گروه تا حد امکان پاکسازی شد !", "html");
			base:del(TD_ID .. "ProcessClean");
		end;
	end;
	local function CleanMessage(msg, type, value, key)
		TD.deleteMessages(msg.chat_id, msg.id);
		base:set(TD_ID .. "ProcessClean", true);
		base:set(TD_ID .. "CleanMessageDate" .. msg.chat_id, msg.date);
		if key == "AllMessage" then
			local x = os.clock()
			local s = 0
			for i=1,100000 do s = s + i end
		
			TD.deleteMessages(msg.chat_id, msg.id);
			local function deleteMessages(result)
				if result.messages then
					do
						do
							num = 0;
							for k, i in pairs(result.messages) do
								if i.content and (i.content["@type"] == "messageChatAddMembers" or i.content["@type"] == "messagePinMessage" or i.content["@type"] == "messageChatJoinByLink" or i.content["@type"] == "messageChatDeleteMember" or i.content["@type"] == "messageChatChangePhoto" or i.content["@type"] == "messageChatDeletePhoto" or i.content["@type"] == "messageChatChangeTitle") then
									TD.deleteMessages(msg.chat_id, i.id);
								end;
								base:set(TD_ID .. "CleanMessage" .. i.chat_id, tonumber((base:get(TD_ID .. "CleanMessage" .. i.chat_id) or 0)) + 1);
								TD.deleteChatMessagesBySender(i.chat_id, i.sender_id.user_id, nil);
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
						local time_ = os.time();
						if time_ ~= os.time() then
							Stop = os.time() - time_;
						else
							Stop = "0";
						end;
						timer =  string.format("%.2f\n", os.clock() - x) + 1
						local ping = io.popen("ping -c 1 google.com"): read("*a"): match("time=(%S+)") 
						TD.sendText(msg.chat_id, msg.id, "◄ عملیات پاکسازی کلی پیام انجام شد !\n━━┅─ #پاکسازی ─┅━━\n⌯ زمان های سپری شده :  : " .. timer .. " ثانیه", "html");
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
								elseif key == "Tgservice" then
									if i.content and (i.content["@type"] == "messageChatAddMembers" or i.content["@type"] == "messagePinMessage" or i.content["@type"] == "messageChatJoinByLink" or i.content["@type"] == "messageChatDeleteMember" or i.content["@type"] == "messageChatChangePhoto" or i.content["@type"] == "messageChatDeletePhoto" or i.content["@type"] == "messageChatChangeTitle" or i.content["@type"] == "messageVideoChatStarted" or i.content["@type"] == "messageVideoChatEnded") then
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
			--TD.sendText(msg.chat_id, msg.id, "⌯ " .. value .. " های موجود در گروه تا حد امکان پاکسازی شد !", "html");
			base:del(TD_ID .. "ProcessClean");
		end;
	end; 
	local function CleanMemberFilter(msg, key, value)
		local data = TD.getSupergroupMembers(msg.chat_id, "Search", "", 0, 200);
		local total_count = 0;
		if data.members then
			do
				do
					for i, i in pairs(data.members) do
						result = TD.getUser(i.user_id);
						if result and result.status and result.status["@type"] == key then
							total_count = total_count + 1;
							TD.setChatMemberStatus(msg.chat_id, i.user_id, "banned");
						end;
					end;
				end;
			end;
			if total_count ~= 0 then
				TD.sendText(msg.chat_id, msg.id, "⌯ تمام کاربران " .. value .. " از گروه اخراج شدند !\n\n◄ تعداد کاربران : [ " .. total_count .. "]", "html");
			else
				TD.sendText(msg.chat_id, msg.id, "⌯ در حال حاضر کاربری " .. value .. " در گروه وجود ندارد !", "html");
			end;
		end;
	end;




	if base:get(TD_ID .. "MarkRead:on") then
		TD.viewMessages(msg.chat_id, {
			[0] = msg.id
		});
	end;


	local TDLua = msg.content.text and msg.content.text.text;
	local TDLua1 = msg.content.text and msg.content.text.text;
	local Diamondent = TDLua and msg.content.entities and msg.content.entities[1] and msg.content.entities[1].type["@type"] == "textEntityTypeMentionName";
	local TDLuaEnti = Ramin and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName";
	if TDLua then
		TDLua = TDLua:lower();
	end;
	if MsgType == "text" and TDLua then
		if TDLua:match("^[/#!]") then
			TDLua = TDLua:gsub("^[/#!]", "");
		end;
	end;

	if TDLua and (TDLua:match("^start @(.*)") or TDLua:match("^استارت @(.*)")) and (is_Sudo(msg)) then
		local username = TDLua:match("^start @(.*)") or TDLua:match("^استارت @(.*)");
		RES = TD.searchPublicChat(username);
		if RES.id then
			TD.sendBotStartMessage(RES.id, RES.id, "new");
			sendCli(msg.chat_id, msg.id, "⌯ مکمل اصلی  @" .. username .. " با موفقیت استارت شد !", "html");
		else
			text = "⌯ ربات مورد نظر یافت نشد!";
			sendCli(msg.chat_id, msg.id, text, "html");
		end;
	end;
	if TDLua == "addapi" or TDLua == "افزودن ربات اصلی" and (is_Sudo(msg)) then
		data = TD.addChatMember(msg.chat_id, BotJoiner, 1);
		if getAccesUser(msg.chat_id, BotJoiner, "Admin") == 3 then
			text = "⌯ ربات مکمل از قبل در گروه وجود داشت !";
		elseif data._ == "ok" then
			text = "⌯ ربات مکمل با موفقیت به گروه اضافه شد !";
			TD.setChatMemberStatus(msg.chat_id, BotJoiner, "administrator", {
				0,
				1,
				0,
				0,
				1,
				1,
				1,
				1,
				1
			});
		elseif data.message and data.message == "USER_KICKED" then
			text = "⌯ ربات مکمل در لیست سیاه گروه میباشد !";
		elseif data.message and data.message == "BOTS_TOO_MUCH" then
			text = "⌯ لیست ربات های این گروه تکمیل میباشد لطفا یکی از ربات ها را اخراج کنید و مجدد تلاش کنید !";
		end;
		sendCli(msg.chat_id, msg.id, text, "md");
	end;
	if ChatTypePV and TDLua then
		if not base:get((TD_ID .. "block:on")) and (not is_Sudo(msg)) then
			if TDLua then
				local spam = TD_ID .. "user:" .. msg.sender_id.user_id .. ":spamer";
				local msgs = tonumber(base:get(spam) or 0);
				local autoblock = base:get(TD_ID .. "autoblocknumber") or 5;
				if msgs > tonumber(autoblock) then
					TD.blockUser(msg.sender_id.user_id);
				end;
				base:setex(spam, tonumber(5), msgs + 1);
			end;
		end;
	end;

	if ChatTypeSuperGp and (is_ModClean(msg)) and (base:sismember(TD_ID .. "Gp2:" .. msg.chat_id, "added"))  then
	print('true'..msg.sender_id.user_id)
		if TDLua == "⌯ فرایند پاکسازی خودکار پیام ها در حال اجرا...!" and (is_Sudo(msg)) then
			CleanMessageAuto(msg, nil, "پیام", "AllMessage");
			CleanMessage(msg, nil, "سرویس تلگرام", "Tgservice");
		end; 
		if TDLua == "cgmall" or TDLua == "• پاکسازی پیام در حال انجام ... ✅" or TDLua == "⌯ پاکسازی پیام در حال انجام ... ✅" then
			CleanMessage(msg, nil, "پیام", "AllMessage");
			CleanMessage(msg, nil, "سرویس تلگرام", "Tgservice");
		end;
		if TDLua == "clean sticker" or TDLua == "پاکسازی استیکر ها" or TDLua == "پاکسازی استیکرها" or TDLua == "• پاکسازی استیکر ها در حال انجام ... ✅" then
			CleanMessage(msg, "messageSticker", "استیکر", "Sticker");
		end;
		if TDLua == "clean stickers" or TDLua == "پاکسازی استیکر متحرک" or TDLua == "• پاکسازی استیکر متحرک ها در حال انجام ... ✅" or TDLua == "پاکسازی استیکرها" then
			CleanMessage(msg, "messageSticker", "استیکر متحرک", "StickerAnimated");
		end;
		if TDLua == "clean video" or TDLua == "پاکسازی فیلم ها" or TDLua == "• پاکسازی فیلم ها در حال انجام ... ✅" then
			CleanMessage(msg, "messageVideo", "فیلم");
		end;
		if TDLua == "clean text" or TDLua == "پاکسازی متن ها"  then
			CleanMessage(msg, "messageText", "متن");
		end;
		if TDLua == "clean document" or TDLua == "پاکسازی فایل ها" then
			CleanMessage(msg, "messageDocument", "فایل");
		end;
		if TDLua == "clean photo" or TDLua == "پاکسازی عکس ها" or TDLua == "• پاکسازی عکس ها در حال انجام ... ✅" then
			CleanMessage(msg, "messagePhoto", "عکس");
		end;
		if TDLua == "clean animation" or TDLua == "پاکسازی گیف ها" or TDLua == "• پاکسازی گیف ها در حال انجام ... ✅" then
			CleanMessage(msg, "messageAnimation", "گیف");
		end;
		if TDLua == "clean audio" or TDLua == "پاکسازی اهنگ ها" or TDLua == "پاکسازی آهنگ ها" or TDLua == "• پاکسازی آهنگ ها در حال انجام ... ✅" then
			CleanMessage(msg, "messageAudio", "اهنگ");
		end;
		if TDLua == "clean voice" or TDLua == "پاکسازی ویس ها" or TDLua == "• پاکسازی ویس ها در حال انجام ... ✅" then
			CleanMessage(msg, "messageVoiceNote", "ویس");
		end;
		if TDLua == "clean game" or TDLua == "پاکسازی بازی ها"  then
			CleanMessage(msg, "messageGame", "بازی");
		end;
		if TDLua == "clean tgservice" or TDLua == "پاکسازی سرویس تلگرام" or TDLua == "• پاکسازی سرویس تلگرام در حال انجام ... ✅" then
			CleanMessage(msg, nil, "سرویس تلگرام", "Tgservice");
		end;
		if TDLua == "clean forward" or TDLua == "پاکسازی فوروارد ها" or TDLua == "• پاکسازی فوروارد ها در حال انجام ... ✅" then
			CleanMessage(msg, nil, "فوروارد", "Forwarded");
		end;
		if TDLua == "clean lastweek" or TDLua == "پاکسازی بازدید یک هفته پیش" or TDLua == "• پاکسازی بازدید یک هفته پیش در حال انجام ... ✅" then
			CleanMemberFilter(msg, "userStatusLastWeek", "با بازدید یک هفته");
		end;
		if TDLua == "clean lastmonth" or TDLua == "پاکسازی بازدید یک ماه پیش" or TDLua == "• پاکسازی بازدید یک ماه پیش در حال انجام ... ✅" then
			CleanMemberFilter(msg, "userStatusLastMonth", "با بازدید یکماه");
		end;
		if TDLua == "clean lastempty" or TDLua == "پاکسازی فیک ها"  or TDLua == "• پاکسازی فیک ها در حال انجام ... ✅" then
			CleanMemberFilter(msg, "userStatusEmpty", "فیک");
		end;

		if TDLua == "clean deleted" or TDLua == "پاکسازی دلیت اکانت ها" or TDLua == "• پاکسازی دلیت اکانت ها در حال انجام ... ✅" then
			local data = TD.getSupergroupMembers(msg.chat_id, "Search", nil, 0, 200);
			local total_count = 0;
			if data.members then
				do
					do
						for i, i in pairs(data.members) do
							result = TD.getUser(i.user_id);
							if result.type and result.type["@type"] == "userTypeDeleted" then
								total_count = total_count + 1;
								TD.setChatMemberStatus(msg.chat_id, result.id, "banned");
							end;
						end;
					end;
				end;
				if total_count ~= 0 then
					TD.sendText(msg.chat_id, msg.id, "⌯ تعداد ( " .. total_count .. " ) کاربر دلیت اکانتی از گروه اخراج شد ! ", "html");
				else
					TD.sendText(msg.chat_id, msg.id, "⌯ کاربر دلیت شده ای یافت نشد !", "html");
				end;
			end;
		end;
		if TDLua == "clean restriced" or TDLua == "پاکسازی لیست محدود ها" or TDLua == "• پاکسازی لیست محدود ها در حال انجام ... ✅" then
			local data = TD.getSupergroupMembers(msg.chat_id, "Restricted", "", 0, 200);
			local total_count = 0;
			if data.members then
				do
					do
						for i, i in pairs(data.members) do
							total_count = total_count + 1;
							TD.setChatMemberStatus(msg.chat_id, i.user_id, "restricted", {
								1,
								1,
								1,
								1,
								1,
								1,
								1,
								1,
								1 
							});
						end;
					end;
				end;
				if total_count ~= 0 then
					TD.sendText(msg.chat_id, msg.id, "⌯ لیست کاربران محدود شده پاکسازی شد !\n\n◄ تعداد کاربران : [ " .. total_count .. "]", "html");
				else
					TD.sendText(msg.chat_id, msg.id, "⌯ لیست کاربران محدود شده گروه خالی میباشد !", "html");
				end;
			end;
		end;
		if TDLua == "clean blocklist" or TDLua == "پاکسازی لیست سیاه" or TDLua == "• پاکسازی لیست سیاه در حال انجام ... ✅"  then
			local data = TD.getSupergroupMembers(msg.chat_id, "Banned", "", 0, 200);
			local total_count = 0;
			if data.members then
				do
					do
						for i, i in pairs(data.members) do
							total_count = total_count + 1;
							TD.setChatMemberStatus(msg.chat_id, i.user_id, "restricted", {
								1,
								1,
								1,
								1,
								1,
								1,
								1,
								1,
								1
							});
						end;
					end;
				end;
				if total_count ~= 0 then
					TD.sendText(msg.chat_id, msg.id, "⌯ لیست کاربران مسدود شده پاکسازی شد ▸\n\n» تعداد کاربران : [ " .. total_count .. "]", "html");
				else
					TD.sendText(msg.chat_id, msg.id, "⌯ لیست کاربران مسدود شده گروه خالی میباشد ! ", "html");
				end;
			end;
		end;
		if TDLua == "cumme" or TDLua == "delallme" or TDLua == "حذف پیام من" and tonumber(msg.reply_to_message_id) == 0 then
			txt = "⌯ پیام های کاربر : [" .. msg.sender_id.user_id .. "](tg://user?id=" .. result.sender_id.user_id .. ") پاک شدند !";
			TD.deleteChatMessagesBySender(msg.chat_id, msg.sender_id.user_id);
			sendCli(msg.chat_id, msg.id, txt, "md");
		end;
		if TDLua == "cum" or TDLua == "حذف پیام ها" and tonumber(msg.reply_to_message_id) > 0 then
			local result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
			txt = " ⌯ پیام های کاربر : [" .. result.sender_id.user_id .. "](tg://user?id=" .. result.sender_id.user_id .. ") پاک شدند ! ";
			TD.deleteChatMessagesBySender(msg.chat_id, result.sender_id.user_id);
			sendCli(msg.chat_id, msg.id, txt, "md");
		end;
		if TDLuaEnti and (TDLua:match("^cum (.*)") or TDLua:match("^حذف پیام ها (.*)")) or TDLua and (TDLua:match("^cum @(.*)") or TDLua:match("^حذف پیام ها @(.*)") or TDLua:match("^cum (%d+)") or TDLua:match("^حذف پیام ها (%d+)")) then
			local TeleBotSource = TDLua:match("^cum (.*)") or TDLua:match("^حذف پیام ها (.*)");
			result = TD.searchPublicChat(TeleBotSource);
			if not TDLuaEnti and TDLua:match("^cum @(.*)") or TDLua:match("^حذف پیام ها @(.*)") then
				MrTeleGrami = result.id;
			elseif not Diamondent and TDLua:match("^cum (%d+)") or TDLua:match("^حذف پیام ها (%d+)") then
				MrTeleGrami = TeleBotSource;
			elseif Diamondent and TDLua:match("^cum (.*)") or TDLua:match("^حذف پیام ها (.*)") then
				MrTeleGrami = msg.content.entities[0].type.user_id;
			end;
			if MrTeleGrami then
				txt = "⌯ پیام های کاربر : [" .. TeleBotSource .. "](tg://user?id=" .. MrTeleGrami .. ") پاک شدند !";
				sendCli(msg.chat_id, msg.id, txt, "md");
				TD.deleteChatMessagesBySender(msg.chat_id, MrTeleGrami);
			else
				sendCli(msg.chat_id, msg.id, "⌯ کاربر |" .. TeleBotSource .. "| یافت نشد ...!", "md");
			end;
		end;
		if TDLua and (TDLua:match("^cgm (%d+)$") or TDLua:match("^پاکسازی (%d+)$") or TDLua:match("^حذف (%d+)$")) then
			local count_message = tonumber(TDLua:match("^cgm (%d+)$") or TDLua:match("^پاکسازی (%d+)$") or TDLua:match("^حذف (%d+)$"));
					local x = os.clock()
					local s = 0
					for i=1,100000 do s = s + i end
					
					if tonumber(count_message) < 1 or tonumber(count_message) > 10000 then
				sendCli(msg.chat_id, msg.id, "⌯ میزان حذف پیام باید بزرگتر از 1 و کوچک تر از 10000 باشد !", "html");
			else             
				base:set(TD_ID .. "StartClean", true);
				for i = 1, tonumber(count_message) do
					TD.deleteMessages(msg.chat_id, math.modf(msg.id - i * 1048576));
				end;
				base:del(TD_ID .. "StartClean");   
				local NumberClean = base:smembers(TD_ID..'CleanNumber:'.. msg.chat_id)
				if #NumberClean == 0 then
				  num = '0'
				else 
				 timer =  string.format("%.2f\n", os.clock() - x) + 1
				 sendCli(msg.chat_id, msg.id, "◄ عملیات پاکسازی انجام شد !\n━━┅─ #پاکسازی ─┅━━\n⌯ تعداد درخواست شده : "..tonumber(count_message).." پیام \n⌯ تعداد پاکسازی شده : " .. #NumberClean .. " پیام\n⌯ زمان سپری شده : "..timer.." ثانیه", "html");
				 base:del(TD_ID..'CleanNumber:'.. msg.chat_id)
			end;
			end;
		end;

	else
		
	end

	if ChatTypeSuperGp and (is_Sudo(msg)) then
		print('true'..msg.sender_id.user_id)
	if TDLua == "botnumber" or TDLua == "شماره ربات" then
		result = TD.getMe();
		TD.sendContact(msg.chat_id, msg.id, result.phone_number, result.first_name, result.last_name or "");
	end;
	if TDLua == "markread on" or TDLua == "تیک دوم فعال" then
		if base:get(TD_ID .. "MarkRead:on") then
			sendCli(msg.chat_id, msg.id, "⌯ تیک دوم فعال بود !", "md");
		else
			sendCli(msg.chat_id, msg.id, "⌯ تیک دوم فعال شد !", "md");
			base:set(TD_ID .. "MarkRead:on", true);
		end;
	end;
	if TDLua == "markread off" or TDLua == "تیک دوم غیرفعال" then
		if base:get(TD_ID .. "MarkRead:on") then
			sendCli(msg.chat_id, msg.id, "⌯ تیک دوم غیرفعال شد !", "md");
			base:del(TD_ID .. "MarkRead:on");
		else
			sendCli(msg.chat_id, msg.id, "⌯ تیک دوم غیر فعال بود !", "md");
		end;
	end;
	if TDLua == "⌯ پیام های متخلف در گروه پاکسازی شد !" and is_Sudo(msg) then
		chat = base:get(TD_ID .. "delreportedchat1:");
		chatrepo = base:get(TD_ID .. "delreportedchat:" .. chat);
		print(chat);
		user = tonumber(base:get(TD_ID .. "delreporteduser:" .. chat));
		res = TD.getUser(user);
		TD.deleteChatMessagesBySender(chat, user);
		txt = "⌯ پیام های کاربر : [" .. res.first_name .. "](tg://user?id=" .. user .. ") متخلف در گروه پاکسازی شد !";
		sendCli(chat, 0, txt, "md");
	end;
	if TDLua and (TDLua:match("^setautoblock (%d+)") or TDLua:match("^تنظیم بلاک خودکار (%d+)")) then
		local spm = TDLua:match("^setautoblock (%d+)") or TDLua:match("^تنظیم بلاک خودکار (%d+)");
		if tonumber(spm) < 5 then
			sendCli(msg.chat_id, msg.id, "⌯ عددی بزرگتر از 5 تنظیم شود !", "md");
			return false;
		end;
		base:set(TD_ID .. "autoblocknumber", spm);
		sendCli(msg.chat_id, msg.id, "⌯ تعداد اسپم در پیوی ربات ها تنظیم شد به :" .. spm .. "", "md");
	end;
	if TDLua == "reload" or TDLua == "ریلود" or TDLua == "بروز" and is_Sudo(msg) then
		sendCli(msg.chat_id, msg.id, "⌯ ربات مکمل بازنگری شد !", "md");
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
			os.execute("rm -rf ~/TeleBot/.tdlua-sessions/ClIBot/" .. v .. "/*");
			io.popen("sync && echo 3 > /proc/sys/vm/drop_caches");
			io.popen("swapoff -a && swapon -a");
			io.popen("rm -rf $PWD/.tdlua.log");
			io.popen("rm -rf $PWD/.tdlua.log.old");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/db.sqlite-wal");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/db.sqlite");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/photos/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/animations/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/videos/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/music/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/voice/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/temp/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/documents/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/video_notes/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/stickers/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/thumbnails/*");
			io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/profile_photos/*");
		end;
	end;
	local GroupsInCommon = function(msg, chat, user)
		if tonumber(user) == tonumber(BotJoiner) then
			return false;
		end;
		data = TD.getGroupsInCommon(user, 0, 100);
		local list = data.chat_ids;
		local count = data.total_count;
		local result = TD.getUser(user);
		if result.username and result.username ~= "" then
			username = "" .. result.username;
		elseif result.first_name and result.first_name ~= "" then
			username = "" .. result.first_name;
		else
			username = "یافت نشد";
		end;
		if result.phone_number and result.phone_number ~= "" then
			phone_number = "+" .. result.phone_number;
		else
			phone_number = "یافت نشد";
		end;
		if result.status and result.status["@type"] == "userStatusOnline" then
			ProfileStatus = "آنلاین";
		elseif result.status and result.status["@type"] == "userStatusOffline" then
			ProfileStatus = "آفلاین";
		elseif result.status and result.status["@type"] == "userStatusRecently" then
			ProfileStatus = "اخیرا";
		elseif result.status and result.status["@type"] == "userStatusLastWeek" then
			ProfileStatus = "یک هفته";
		elseif result.status and result.status["@type"] == "userStatusLastMonth" then
			ProfileStatus = "یک ماه";
		else
			ProfileStatus = "ناموجود";
		end;
		if tonumber(user) == tonumber(1413225001) then
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
			rank = "عضو ویژه";
		else
			rank = "کاربر عادی";
		end;
		text = "⌯ گزارش رهگیری کاربر  [" .. username .. "](tg://user?id=" .. user .. ")  :\n\n";
		for k, i in pairs(list) do
			result = TD.getChat(i);
			local res = TD.getSupergroupFullInfo(i);
			link = "[ورود به گروه](" .. res.invite_link.invite_link .. ")" and "[ورود به گروه](" .. res.invite_link.invite_link .. ")" or "ناموجود";
			local chat_title = result.title and result.title or "ناموجود";
			local status_group = result.last_message and "موجود" or "ناموجود";
			local Id = result.id;
			t = "⊳ تعداد گروه ردیابی شده : *" .. count .. "*\n ⊳ شماره کاربر : *" .. phone_number .. "*";
			text = text .. "◄  گروه  ( `" .. i .. "` ) :\n\n⌯ نام گروه : `" .. chat_title .. "`\n⌯ لینک گروه : " .. link .. "\n⌯ وضعیت گروه : " .. status_group .. "                        \n                        ┅┅━ ✦ ━┅┅\n                        \n                        ";
		end;
		sendCli(msg.chat_id, msg.id, text .. t, "md");
	end;
	if TDLua and (TDLua:match("^رهگیری$") or TDLua:match("^detect$")) and tonumber(msg.reply_to_message_id) > 0 and is_FullSudo(msg) then
		result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
		GroupsInCommon(msg, msg.chat_id, result.sender_id.user_id);
	end;
	if TDLuaEnti and (TDLua:match("^رهگیری (.*)$") or TDLua:match("^detect (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_FullSudo(msg) then
		id = msg.content.text.entities[1].type.user_id;
		GroupsInCommon(msg, msg.chat_id, id);
	end;
	if TDLua and (TDLua:match("^رهگیری @(.*)$") or TDLua:match("^detect @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_FullSudo(msg) then
		local username = TDLua:match("^رهگیری @(.*)$") or TDLua:match("^detect @(.*)$");
		result = TD.searchPublicChat(username);
		if result.id then
			GroupsInCommon(msg, msg.chat_id, result.id);
		else
			sendCli(msg.chat_id, msg.id, "⌯ کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
		end;
	end;
	if TDLua and (TDLua:match("^رهگیری (%d+)$") or TDLua:match("^detect (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_FullSudo(msg) then
		GroupsInCommon(msg, msg.chat_id, TDLua:match("^رهگیری (%d+)$") or TDLua:match("^detect (%d+)$"));
	end;
	if TDLua == "autoblock on" or TDLua == "بلاک خودکار فعال" then
		base:del(TD_ID .. "block:on");
		sendCli(msg.chat_id, msg.id, "⌯ بلاک خودکار پیوی فعال شد !", "md");
	end;
	if TDLua == "autoblock off" or TDLua == "بلاک خودکار غیرفعال" then
		base:set(TD_ID .. "block:on", true);
		sendCli(msg.chat_id, msg.id, "⌯ بلاک خودکار پیوی غیرفعال شد !", "md");
	end;
	if TDLua == "leave" or TDLua == "خروج" or TDLua == "❌ربات از گروہ خارج شد...!" or TDLua == "⌯ ربات توسط سازنده گروه خارج شد!" then
		sendCli(msg.chat_id, msg.id, "⌯ مکمل پاکسازی از گروه خارج شد !", "md");
		TD.leaveChat(msg.chat_id);
	end;
	if TDLua and (TDLua:match("^import http(.*)") or TDLua:match("^ورودربات http(.*)") or TDLua:match("^نصب http(.*)")) then
		local link = msg.content.text.text:match("^import (.*)") or msg.content.text.text:match("^ورودربات (.*)") or msg.content.text.text:match("^نصب (.*)");
		local linkt = base:get(TD_ID .. "Link:" .. msg.chat_id) or "";
		TD.joinChatByInviteLink(link);
		sendCli(msg.chat_id, 0, "⌯ ربات با موفقیت وارد گروه " .. link .. " شد !", "html");
	end;


else
	
end

if ChatTypeSuperGp and (is_Owner(msg)) then
	print('true'..msg.sender_id.user_id)

	if TDLua and (TDLua:match("^ارتقا موزیک$") or TDLua:match("^vcpromote$") or TDLua:match("^ترفیع موزیک$")) and tonumber(msg.reply_to_message_id) > 0 and is_Owner(msg) then
		result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
		SetVcadmin(msg, msg.chat_id, result.sender_id.user_id);
	end;
	if ALPHAent and (TDLua:match("^ارتقا موزیک (.*)$") or TDLua:match("^vcpromote (.*)$") or TDLua:match("^ترفیع موزیک (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		id = msg.content.text.entities[1].type.user_id;
		SetVcadmin(msg, msg.chat_id, id);
	end;
	if TDLua and (TDLua:match("^ارتقا موزیک @(.*)$") or TDLua:match("^vcpromote @(.*)$") or TDLua:match("^ترفیع موزیک @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		local username = TDLua:match("^ارتقا موزیک @(.*)$") or TDLua:match("^vcpromote @(.*)$") or TDLua:match("^ترفیع موزیک @(.*)$");
		result = TD.searchPublicChat(username);
		if result.id then
			SetVcadmin(msg, msg.chat_id, result.id);
		else
			sendCli(msg.chat_id, msg.id, "⌯ کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
		end;
	end;
	if TDLua and (TDLua:match("^ارتقا موزیک (%d+)$") or TDLua:match("^vcpromote (%d+)$") or TDLua:match("^ترفیع موزیک (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		SetVcadmin(msg, msg.chat_id, TDLua:match("^ارتقا موزیک (%d+)$") or TDLua:match("^vcpromote (%d+)$") or TDLua:match("^ترفیع موزیک (%d+)$"));
	end;
	if TDLua and (TDLua:match("^عزل موزیک$") or TDLua:match("^vcdemote$")) and tonumber(msg.reply_to_message_id) > 0 then
		result = TD.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id));
		RemVcadmin(msg, msg.chat_id, result.sender_id.user_id);
	end;
	if ALPHAent and (TDLua:match("^عزل موزیک (.*)$") or TDLua:match("^vcdemote (.*)$")) and msg.content.text.entities and msg.content.text.entities[1] and msg.content.text.entities[1].type["@type"] == "textEntityTypeMentionName" and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		id = msg.content.text.entities[1].type.user_id;
		RemVcadmin(msg, msg.chat_id, id);
	end;
	if TDLua and (TDLua:match("^عزل موزیک @(.*)$") or TDLua:match("^vcdemote @(.*)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		local username = TDLua:match("^عزل موزیک @(.*)$") or TDLua:match("^vcdemote @(.*)$");
		result = TD.searchPublicChat(username);
		if result.id then
			RemVcadmin(msg, msg.chat_id, result.id);
		else
			sendCli(msg.chat_id, msg.id, "⌯ کاربر ▏  @" .. username .. " ▕ یافت نشد !", "md");
		end;
	end;
	if TDLua and (TDLua:match("^عزل موزیک (%d+)$") or TDLua:match("^vcdemote (%d+)$")) and tonumber(msg.reply_to_message_id) == 0 and is_Owner(msg) then
		RemVcadmin(msg, msg.chat_id, TDLua:match("^عزل موزیک (%d+)$") or TDLua:match("^vcdemote (%d+)$"));
	end;
	if TDLua == "modlistmusic" or TDLua == "لیست مدیران موزیک" and is_Owner(msg) then
		local list = base:smembers(TD_ID .. "ModVcList:" .. msg.chat_id);
		if #list == 0 then
			sendCli(msg.chat_id, msg.id, " ⌯ لیست مدیران موزیک خالی می باشد. ", "md");
		else
			local txt = "─┅━━━ لیست مدیران موزیک ━━━┅─\n\n";
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
			sendCli(msg.chat_id, msg.id, txt, "html");
		end;
	end;
	if TDLua == "clean modlistmusic" or TDLua == "پاکسازی مدیران موزیک" and is_Owner(msg) then
		base:del(TD_ID .. "ModVcList:" .. msg.chat_id);
		sendCli(msg.chat_id, msg.id, " ⌯ پاکسازی لیست مدیران موزیک با موفقیت انجام شد !", "html");
	end;
 
	if base:sismember(TD_ID .. "Gp:" .. msg.chat_id, "on:player") then
		if TDLua and (TDLua:match("^پخش") or TDLua:match("^play")) and tonumber(msg.reply_to_message_id) > 0 and is_ModVc(msg) then
			TD.sendText(msg.chat_id, msg.reply_to_message_id, "/play", "html");
		end;
	
			if TDLua and TDLua:match("^پخش (.*)") and is_ModVc(msg) then
			local TEXT = TDLua:match("^پخش (.*)"); 
			TD.sendText(msg.chat_id, 0, "/play " .. TEXT .. "", "html");
		end;
		if TDLua and TDLua:match("^ویدیو پخش  (.*)") and is_ModVc(msg) then
			local TEXT = TDLua:match("^ویدیو پخش (.*)");
			TD.sendText(msg.chat_id, 0, "/vplay " .. TEXT .. "", "html");
		end;
		if TDLua and TDLua:match("^دانلود آهنگ (.*)") and is_ModVc(msg) then
			local TEXT = TDLua:match("^دانلود آهنگ (.*)");
			TD.sendText(msg.chat_id, 0, "/music " .. TEXT .. "", "html");
		end;
		if TDLua and (TDLua:match("^دانلود ویدئو (.*)") or TDLua:match("^دانلود کلیپ (.*)")) and is_ModVc(msg) then
			local TEXT = TDLua:match("^دانلود ویدئو (.*)") or TDLua:match("^دانلود کلیپ (.*)");
			TD.sendText(msg.chat_id, 0, "/video " .. TEXT .. "", "html");
		end;
		-- if TDLua == " تنظیمات موزیکال" and is_ModVc(msg) then
			-- TD.sendText(msg.chat_id, 0, "/settings", "html");
		-- end; 
		if TDLua == "بعدی" and is_ModVc(msg) then
			TD.sendText(msg.chat_id, 0, "/skip", "html");
		end; 
		if TDLua == "اتمام" and is_ModVc(msg) then
			TD.sendText(msg.chat_id, 0, "/stop", "html");
		end;
		if TDLua == "توقف" and is_ModVc(msg) then
			TD.sendText(msg.chat_id, 0, "/pause", "html");
		end;
		if TDLua == "ادامه" and is_ModVc(msg) then
			TD.sendText(msg.chat_id, 0, "/resume", "html");
		end;
		if TDLua == "لیست پخش" and is_ModVc(msg) then
			TD.sendText(msg.chat_id, 0, "/playlist", "html");
		end;
		if TDLua == "شروع ویدیو چت" and is_ModVc(msg) then
			local time = 1 * 60;
			title = (TD.getChat(msg.chat_id)).title;
			
			tim = msg.date + 3600
			TD.createVideoChat(msg.chat_id, title, msg.date);
			sendCli(msg.chat_id, msg.id, "◄ ویدئو چت با موفقیت در گروه شروع شد !", "html");
		end;
		if TDLua == "خاموش ویدیو چت" and is_ModVc(msg) then
			title = (TD.getChat(msg.chat_id)).title;
			TD.createVideoChat(msg.chat_id, title, 0);
			sendCli(msg.chat_id, msg.id, "◄ ویدئو چت در گروه خاموش شد !", "html");
		end;
	end;


else
	
end
if ChatTypeSuperGp and (is_Mod(msg)) then
	print('true'..msg.sender_id.user_id)
if TDLua == "ping" or TDLua == "پینگ" and is_Mod(msg) then
	local time_ = os.time();
	if time_ ~= os.time() then
		Stop = os.time() - time_;
	else
		Stop = "استاندارد";
	end;
	local x = os.clock();
	local s = 0;
	for i = 1, 100000 do
		s = s + i;
	end;
	print(string.format("elapsed time: %.0f\n", os.clock() - x));
	ping = ((io.popen("ping -c 1 api.telegram.org")):read("*a")):match("time=(%S+)") / 100 * 10;
	local bot = "<a href=\"tg://user?id=" .. TD.getMe().id .. "\">ربات</a>"
	sendCli(msg.chat_id, msg.id, "◄ <b>"..bot.." مکمل آنلاین می باشد !</b>\n━━┅─ 🅒🅛🅘 ─┅━━\n⇧ سرعت ارسال دیتا : <b>"..string.format("%.0f", os.clock() - x).. " ثانیه</b>\n⇩ سرعت دریافت دیتا : <b>"..Stop.. "</b>\n◃ پینگ به تلگرام : <b>"..ping.. " میلی ثانیه</b>", "html")
	-- sendCli(msg.chat_id, msg.id, " ◄  ربات پاکسازی روشن می باشد! \n↑ سرعت ارسال : " .. string.format("%.0f", os.clock() - x) .. " ثانیه\n↓ سرعت دریافت : " .. Stop .. "\n ✦ پینگ سرور : " .. ping .. "", "html");
end;
else
	
end
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
	TD.set_timer(100, exit_run);
	local function checkercleaner()
		if _.auto_run == 2 then
			if not base:get((TD_ID .. "cgmautoerererr1:")) then
				local timecgm = tonumber(86400);
				base:setex(TD_ID .. "cgmautoerererr1:", 86400, true);
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
					os.execute("rm -rf ~/TeleBot/.tdlua-sessions/ClIBot/" .. v .. "/*");
					io.popen("sync && echo 3 > /proc/sys/vm/drop_caches");
					io.popen("swapoff -a && swapon -a");
					io.popen("rm -rf $PWD/.tdlua.log");
					io.popen("rm -rf $PWD/.tdlua.log.old");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/db.sqlite-wal");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/db.sqlite");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/photos/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/animations/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/videos/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/music/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/voice/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/temp/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/documents/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/video_notes/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/stickers/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/thumbnails/*");
					io.popen("rm -rf $PWD/.tdlua-sessions/ClIBot/profile_photos/*");
				end;
			end;
			TD.set_timer(5, checkercleaner);
			local ListGroup = base:smembers(TD_ID .. "group:");
			if #ListGroup ~= 0 then
				for ALi, Ramin in pairs(ListGroup) do
					if base:get(TD_ID .. "Autopin1" .. Ramin) or base:get(TD_ID .. "Autopin2" .. Ramin) then
						local time = os.date("%H%M");
						local time2 = base:get(TD_ID .. "Autopin1" .. Ramin);
						time2 = time2.gsub(time2, ":", "");
						local time3 = base:get(TD_ID .. "Autopin2" .. Ramin);
						time3 = time3.gsub(time3, ":", "");
						TextPin = base:get(TD_ID .. "MsgPin" .. Ramin);
						if tonumber(time3) < tonumber(time2) then
							if tonumber(time) <= 2359 and tonumber(time) >= tonumber(time2) then
								if not base:get((TD_ID .. "PinMsgCheckGp:" .. Ramin)) then
									base:set(TD_ID .. "PinMsgCheckGp:" .. Ramin, true);
									base:set(TD_ID .. "PINMSGID:" .. Ramin, true);
									print("PinMsgCheckGp");
									sendCli(b, 0, TextPin, "html");
								end;
							elseif tonumber(time) >= 0 and tonumber(time) < tonumber(time3) then
								if not base:get((TD_ID .. "PinMsgCheckGp:" .. Ramin)) then
									sendCli(b, 0, TextPin, "html");
									print("PinMsgCheckGp");
									base:set(TD_ID .. "PINMSGID:" .. Ramin, true);
									base:set(TD_ID .. "PinMsgCheckGp:" .. Ramin, true);
								end;
							elseif base:get(TD_ID .. "PinMsgCheckGp:" .. Ramin) then
								base:del(TD_ID .. "PinMsgCheckGp:" .. Ramin, true);
								print("unpinChatMessage");
								sendCli(b, 0, "⌯ سنجاق خودکار با موفقیت به اتمام رسید !", "html");
								TD.unpinAllChatMessages(b);
							end;
						elseif tonumber(time3) > tonumber(time2) then
							if tonumber(time) >= tonumber(time2) and tonumber(time) < tonumber(time3) then
								if not base:get((TD_ID .. "PinMsgCheckGp:" .. Ramin)) then
									sendCli(b, 0, TextPin, "html");
									print("PinMsgCheckGp");
									base:set(TD_ID .. "PINMSGID:" .. Ramin, true);
									base:set(TD_ID .. "PinMsgCheckGp:" .. Ramin, true);
								end;
							elseif base:get(TD_ID .. "PinMsgCheckGp:" .. Ramin) then
								base:del(TD_ID .. "PinMsgCheckGp:" .. Ramin, true);
								print("unpinChatMessage");
								sendCli(b, 0, "⌯ سنجاق خودکار با موفقیت به اتمام رسید !", "html");
								TD.unpinAllChatMessages(b);
							end;
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
			checkercleaner();
		end;
	end;
	if _.auto_run == 0 then
		_.auto_run = _.auto_run + 1;
		TD.set_timer(5, run_cheker);
		print("auto_run == 0");
	end;
local CleanerDeleteMessages = function(msg, data)
	clean = data.message_ids[1];
	base:sadd(TD_ID .. "CleanNumber:" .. data.chat_id, clean);
end;
local function updateNewMessage(data)
	CleanerUpdateMassage(data.message, data);
end;
local function updateDeleteMessages(data)
	CleanerDeleteMessages(data.message, data);
end;
local function updateMessageSendSucceeded(data)
	--CheckMasssageDelete(data.message, data);
end;
tdlib.run({
	updateNewMessage = updateNewMessage,
	updateChatLastMessage = updateChatLastMessage,
	updateMessageEdited = updateMessageEdited,
	updateSupergroup = updateSupergroup,
	updateDeleteMessages = updateDeleteMessages,
	updateMessageSendSucceeded = updateMessageSendSucceeded
});
