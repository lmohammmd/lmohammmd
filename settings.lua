function settings(msg, chat)



	if base:get(TD_ID .. "sg:locktabalpha" .. chat) == "lock" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    dozdanti = "Aᴄᴛɪᴠᴇ |☑️|"
	   else
		dozdanti = "فعال |☑️|";
	end
	else
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	   dozdanti = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	    else
		dozdanti = "غیرفعال |⬜️|";
	end;
	end;
	
	
	
	if base:sismember(TD_ID .. "Gp2:" .. chat, "forceadd") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forceadd = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        forceadd = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forceadd = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        forceadd = "غیرفعال |⬜️|"
    end
end
	
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Del:force_NewUser") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Ramin = "Aʟʟ Usᴇʀs"
    else
        Ramin = "همه کاربران"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Ramin = "Nᴇᴡ Usᴇʀs"
    else
        Ramin = "کاربر جدید"
    end
end	
	
	
	if base:sismember(TD_ID .. "Gp2:" .. chat, "forcejoin") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forcejoin = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        forcejoin = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forcejoin = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        forcejoin = "غیرفعال |⬜️|"
    end
end
	
	if base:sismember(TD_ID .. "Gp2:" .. chat, "forcejoinduc") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forcejoinduc = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        forcejoinduc = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        forcejoinduc = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        forcejoinduc = "غیرفعال |⬜️|"
    end
end

	if base:sismember(TD_ID .. "Gp2:" .. chat, "automuteall") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        auto = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        auto = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        auto = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        auto = "غیرفعال |⬜️|"
    end
end


	if base:sismember(TD_ID .. "Gp2:" .. chat, "PanelPv") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        pvpnl = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        pvpnl = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        pvpnl = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        pvpnl = "غیرفعال |⬜️|"
    end
end
	

	if base:sismember(TD_ID .. "Gp2:" .. chat, "kickbotpm") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        botpm = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        botpm = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        botpm = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        botpm = "غیرفعال |⬜️|"
    end
end

	if base:sismember(TD_ID .. "Gp2:" .. chat, "MsgCheckPm") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        lockpm = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        lockpm = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        lockpm = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        lockpm = "غیرفعال |⬜️|"
    end
end

	if base:sismember(TD_ID .. "Gp2:" .. chat, "MsgCheckService") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        lockser = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        lockser = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        lockser = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        lockser = "غیرفعال |⬜️|"
    end
end

	if base:sismember(TD_ID .. "Gp2:" .. chat, "MsgCheckService") then
		lockser = "غیرفعال |⬜️|";
	else
		lockser = "فعال |☑️|";
	end;




if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Command") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Commanddel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Commanddel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Commanddel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Commanddel = "غیرفعال |⬜️|"
    end
end

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Flood") then
    if base:sismember(TD_ID .. "Gp2:" ..chat, "Telebotlang") then
        Flood = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Flood = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Flood = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Flood = "غیرفعال |⬜️|"
    end
end

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:FloodMedia") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        FloodMedia = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        FloodMedia = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        FloodMedia = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        FloodMedia = "غیرفعال |⬜️|"
    end
end

	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Fake") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fake = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Fake = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fake = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Fake = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:StickerVideo") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        StickerVideodel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        StickerVideodel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        StickerVideodel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        StickerVideodel = "غیرفعال |⬜️|"
    end
end		

	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Spoiler") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        StickerVideodel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        StickerVideodel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        StickerVideodel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        StickerVideodel = "غیرفعال |⬜️|"
    end
end	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Spoiler") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Spoilerdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Spoilerdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Spoilerdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Spoilerdel = "غیرفعال |⬜️|"
    end
end		
	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Caption") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Capdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Capdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Capdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Capdel = "غیرفعال |⬜️|"
    end
end		
		
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Videomsg") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        V_notdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        V_notdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        V_notdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        V_notdel = "غیرفعال |⬜️|"
    end
end		
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Title") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Title = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Title = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Title = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Title = "غیرفعال |⬜️|"
    end
end		
	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:ForwardChannel") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardChannel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        ForwardChannel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardChannel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        ForwardChannel = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:ForwardHidden") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardHidden = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        ForwardHidden = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardHidden = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        ForwardHidden = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:ForwardUser") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardUser = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        ForwardUser = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        ForwardUser = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        ForwardUser = "غیرفعال |⬜️|"
    end
end	


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Sticker") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Stdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Stdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Stdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Stdel = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Stickers") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Stsdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Stsdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Stsdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Stsdel = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Contact") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Condel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Condel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Condel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Condel = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Document") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Docdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Docdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Docdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Docdel = "غیرفعال |⬜️|"
    end
end


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Voice") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Voicedel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Voicedel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Voicedel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Voicedel = "غیرفعال |⬜️|"
    end
end
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Photo") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Photodel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Photodel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Photodel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Photodel = "غیرفعال |⬜️|"
    end
end	

	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Game") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Gamedel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Gamedel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Gamedel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Gamedel = "غیرفعال |⬜️|"
    end
end		
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Video") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Videodel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Videodel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Videodel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Videodel = "غیرفعال |⬜️|"
    end
end	
	
	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Audio") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Musicdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Musicdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Musicdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Musicdel = "غیرفعال |⬜️|"
    end
end		
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Gif") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Gifdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Gifdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Gifdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Gifdel = "غیرفعال |⬜️|"
    end
end		
		
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:EditMedia") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        EditMedia = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        EditMedia = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        EditMedia = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        EditMedia = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Edit") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Editdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Editdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Editdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Editdel = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:MsgPv") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Pvdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Pvdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Pvdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Pvdel = "غیرفعال |⬜️|"
    end
end		



if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Fosh") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Foshdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Foshdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Foshdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Foshdel = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Weblink") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        LinkWebdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        LinkWebdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        LinkWebdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        LinkWebdel = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Font") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fontdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Fontdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fontdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Fontdel = "غیرفعال |⬜️|"
    end
end		
	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Link") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Linkdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Linkdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Linkdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Linkdel = "غیرفعال |⬜️|"
    end
end		
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Username") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Userdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Userdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Userdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Userdel = "غیرفعال |⬜️|"
    end
end		
	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Tag") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Tagdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Tagdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Tagdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Tagdel = "غیرفعال |⬜️|"
    end
end

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Inline") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Inlinedel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Inlinedel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Inlinedel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Inlinedel = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Porn") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Porndel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Porndel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Porndel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Porndel = "غیرفعال |⬜️|"
    end
end	
		
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Forward") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fwddel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Fwddel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fwddel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Fwddel = "غیرفعال |⬜️|"
    end
end		

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Bots") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Botdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Botdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Botdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Botdel = "غیرفعال |⬜️|"
    end
end	


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Spam") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Spamdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Spamdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Spamdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Spamdel = "غیرفعال |⬜️|"
    end
end		


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Persian") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fadel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Fadel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Fadel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Fadel = "غیرفعال |⬜️|"
    end
end	
	


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:English") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Endel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Endel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Endel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Endel = "غیرفعال |⬜️|"
    end
end	


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Text") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Textdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Textdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Textdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Textdel = "غیرفعال |⬜️|"
    end
end	
	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Location") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Locdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Locdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Locdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Locdel = "غیرفعال |⬜️|"
    end
end	


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Flood") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Flooddel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Flooddel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Flooddel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Flooddel = "غیرفعال |⬜️|"
    end
end		
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Mention") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Mentiondel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Mentiondel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Mentiondel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Mentiondel = "غیرفعال |⬜️|"
    end
end	
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Hyper") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Hyperdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Hyperdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Hyperdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Hyperdel = "غیرفعال |⬜️|"
    end
end		
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Channelpost") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Channelpostdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Channelpostdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Channelpostdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Channelpostdel = "غیرفعال |⬜️|"
    end
end	
	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Biolink") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Biolinkdel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Biolinkdel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Biolinkdel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Biolinkdel = "غیرفعال |⬜️|"
    end
end	

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Number") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Number = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Number = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Number = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Number = "غیرفعال |⬜️|"
    end
end	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Malware") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Malwaredel = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        Malwaredel = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        Malwaredel = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        Malwaredel = "غیرفعال |⬜️|"
    end
end		
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Welcomeon") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        welcome = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        welcome = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        welcome = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        welcome = "غیرفعال |⬜️|"
    end
end		


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Cmd") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        cmd = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        cmd = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        cmd = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        cmd = "غیرفعال |⬜️|"
    end
end
	
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:TGservice") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        tg = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        tg = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        tg = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        tg = "غیرفعال |⬜️|"
    end
end
	
if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Poll") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        poll = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        poll = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        poll = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        poll = "غیرفعال |⬜️|"
    end
end

if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Dice") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        tas = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        tas = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        tas = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        tas = "غیرفعال |⬜️|"
    end
end




if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Reply") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        reply = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        reply = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        reply = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        reply = "غیرفعال |⬜️|"
    end
end


if base:sismember(TD_ID .. "Gp:" .. chat, "Del:Dozd") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        dozd = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        dozd = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        dozd = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        dozd = "غیرفعال |⬜️|"
    end
end

if base:sismember(TD_ID .. "Gp2:" .. chat, "Mute_All") then
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        muteall = "Aᴄᴛɪᴠᴇ |☑️|"
    else
        muteall = "فعال |☑️|"
    end
else
    if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
        muteall = "Dɪsᴀʙʟᴇᴅ |⬜️|"
    else
        muteall = "غیرفعال |⬜️|"
    end
end






	if base:get(TD_ID .. "sg:link" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_link = "Dᴇʟ |❌|";
	else
		settings_link = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:link" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_link = "Mᴜᴛᴇ |📵|";
	else
		settings_link = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:link" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_link = "Wᴀʀɴ |⚠|";
	else
		settings_link = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:link" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_link = "Bᴀɴ |⛔️|";
	else
		settings_link = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:link" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_link = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_link = "غیرفعال |⬜️|";
	end;
	end;
	
	
	if base:get(TD_ID .. "sg:hyper" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_hyper = "Dᴇʟ |❌|";
	else
		settings_hyper = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:hyper" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_hyper = "Mᴜᴛᴇ |📵|";
	else
		settings_hyper = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:hyper" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_hyper = "Wᴀʀɴ |⚠|";
	else
		settings_hyper = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:hyper" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_hyper = "Bᴀɴ |⛔️|";
	else
		settings_hyper = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:hyper" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_hyper = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_hyper = "غیرفعال |⬜️|";
	end;
	end;
	
	
	if base:get(TD_ID .. "sg:biolink" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_biolink = "Dᴇʟ |❌|";
	else
		settings_biolink = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:biolink" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_biolink = "Mᴜᴛᴇ |📵|";
	else
		settings_biolink = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:biolink" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_biolink = "Wᴀʀɴ |⚠|";
	else
		settings_biolink = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:biolink" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_biolink = "Bᴀɴ |⛔️|";
	else
		settings_biolink = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:biolink" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_biolink = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_biolink = "غیرفعال |⬜️|";
	end;
	end;
	
	if base:get(TD_ID .. "sg:bot" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_bot = "Dᴇʟ |❌|";
	else
		settings_bot = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:bot" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_bot = "Mᴜᴛᴇ |📵|";
	else
		settings_bot = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:bot" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_bot = "Wᴀʀɴ |⚠|";
	else
		settings_bot = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:bot" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_bot = "Bᴀɴ |⛔️|";
	else
		settings_bot = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:bot" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_bot = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_bot = "غیرفعال |⬜️|";
	end;
	end;
	
	
	
	if base:get(TD_ID .. "sg:edit" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_edit = "Dᴇʟ |❌|";
	else
		settings_edit = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:edit" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_edit = "Mᴜᴛᴇ |📵|";
	else
		settings_edit = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:edit" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_edit = "Wᴀʀɴ |⚠|";
	else
		settings_edit = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:edit" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_edit = "Bᴀɴ |⛔️|";
	else
		settings_edit = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:edit" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_edit = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_edit = "غیرفعال |⬜️|";
	end;
	end;
	
	
	if base:get(TD_ID .. "sg:fwd" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_fwd = "Dᴇʟ |❌|";
	else
		settings_fwd = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:fwd" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_fwd = "Mᴜᴛᴇ |📵|";
	else
		settings_fwd = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:fwd" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_fwd = "Wᴀʀɴ |⚠|";
	else
		settings_fwd = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:fwd" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_fwd = "Bᴀɴ |⛔️|";
	else
		settings_fwd = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:fwd" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_fwd = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_fwd = "غیرفعال |⬜️|";
	end;
	end
	
	
	if base:get(TD_ID .. "sg:post" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_post = "Dᴇʟ |❌|";
	else
		settings_post = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:post" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_post = "Mᴜᴛᴇ |📵|";
	else
		settings_post = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:post" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_post = "Wᴀʀɴ |⚠|";
	else
		settings_post = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:post" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_post = "Bᴀɴ |⛔️|";
	else
		settings_post = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:post" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_post = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_post = "غیرفعال |⬜️|";
	end;
	end
	
	
	
	if base:get(TD_ID .. "sg:tag" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_tag = "Dᴇʟ |❌|";
	else
		settings_tag = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:tag" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_tag = "Mᴜᴛᴇ |📵|";
	else
		settings_tag = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:tag" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_tag = "Wᴀʀɴ |⚠|";
	else
		settings_tag = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:tag" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_tag = "Bᴀɴ |⛔️|";
	else
		settings_tag = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:tag" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_tag = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_tag = "غیرفعال |⬜️|";
	end;
	end
	
	
	if base:get(TD_ID .. "sg:user" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_user = "Dᴇʟ |❌|";
	else
		settings_user = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:user" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_user = "Mᴜᴛᴇ |📵|";
	else
		settings_user = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:user" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_user = "Wᴀʀɴ |⚠|";
	else
		settings_user = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:user" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_user = "Bᴀɴ |⛔️|";
	else
		settings_user = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:user" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_user = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_user = "غیرفعال |⬜️|";
	end;
	end	
	
	
	if base:get(TD_ID .. "sg:sticker" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_sticker = "Dᴇʟ |❌|";
	else
		settings_sticker = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:sticker" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_sticker = "Mᴜᴛᴇ |📵|";
	else
		settings_sticker = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:sticker" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_sticker = "Wᴀʀɴ |⚠|";
	else
		settings_sticker = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:sticker" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_sticker = "Bᴀɴ |⛔️|";
	else
		settings_sticker = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:sticker" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_sticker = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_sticker = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:stickers" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_stickers = "Dᴇʟ |❌|";
	else
		settings_stickers = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:stickers" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_stickers = "Mᴜᴛᴇ |📵|";
	else
		settings_stickers = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:stickers" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_stickers = "Wᴀʀɴ |⚠|";
	else
		settings_stickers = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:stickers" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_stickers = "Bᴀɴ |⛔️|";
	else
		settings_stickers = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:stickers" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_stickers = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_stickers = "غیرفعال |⬜️|";
	end;
	end
	
	
	
	
	
	if base:get(TD_ID .. "sg:voice" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_voice = "Dᴇʟ |❌|";
	else
		settings_voice = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:voice" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_voice = "Mᴜᴛᴇ |📵|";
	else
		settings_voice = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:voice" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_voice = "Wᴀʀɴ |⚠|";
	else
		settings_voice = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:voice" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_voice = "Bᴀɴ |⛔️|";
	else
		settings_voice = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:voice" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_voice = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_voice = "غیرفعال |⬜️|";
	end;
	end




	if base:get(TD_ID .. "sg:music" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_music = "Dᴇʟ |❌|";
	else
		settings_music = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:music" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_music = "Mᴜᴛᴇ |📵|";
	else
		settings_music = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:music" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_music = "Wᴀʀɴ |⚠|";
	else
		settings_music = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:music" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_music = "Bᴀɴ |⛔️|";
	else
		settings_music = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:music" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_music = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_music = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:mention" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_mention = "Dᴇʟ |❌|";
	else
		settings_mention = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:mention" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_mention = "Mᴜᴛᴇ |📵|";
	else
		settings_mention = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:mention" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_mention = "Wᴀʀɴ |⚠|";
	else
		settings_mention = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:mention" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_mention = "Bᴀɴ |⛔️|";
	else
		settings_mention = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:mention" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_mention = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_mention = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:self" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_self = "Dᴇʟ |❌|";
	else
		settings_self = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:self" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_self = "Mᴜᴛᴇ |📵|";
	else
		settings_self = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:self" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_self = "Wᴀʀɴ |⚠|";
	else
		settings_self = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:self" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_self = "Bᴀɴ |⛔️|";
	else
		settings_self = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:self" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_self = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_self = "غیرفعال |⬜️|";
	end;
	end




	if base:get(TD_ID .. "sg:photo" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_photo = "Dᴇʟ |❌|";
	else
		settings_photo = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:photo" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_photo = "Mᴜᴛᴇ |📵|";
	else
		settings_photo = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:photo" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_photo = "Wᴀʀɴ |⚠|";
	else
		settings_photo = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:photo" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_photo = "Bᴀɴ |⛔️|";
	else
		settings_photo = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:photo" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_photo = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_photo = "غیرفعال |⬜️|";
	end;
	end




	if base:get(TD_ID .. "sg:gif" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_gif = "Dᴇʟ |❌|";
	else
		settings_gif = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:gif" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_gif = "Mᴜᴛᴇ |📵|";
	else
		settings_gif = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:gif" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_gif = "Wᴀʀɴ |⚠|";
	else
		settings_gif = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:gif" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_gif = "Bᴀɴ |⛔️|";
	else
		settings_gif = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:gif" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_gif = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_gif = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:film" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_film = "Dᴇʟ |❌|";
	else
		settings_film = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:film" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_film = "Mᴜᴛᴇ |📵|";
	else
		settings_film = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:film" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_film = "Wᴀʀɴ |⚠|";
	else
		settings_film = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:film" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_film = "Bᴀɴ |⛔️|";
	else
		settings_film = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:film" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_film = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_film = "غیرفعال |⬜️|";
	end;
	end




	if base:get(TD_ID .. "sg:contact" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_contact = "Dᴇʟ |❌|";
	else
		settings_contact = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:contact" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_contact = "Mᴜᴛᴇ |📵|";
	else
		settings_contact = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:contact" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_contact = "Wᴀʀɴ |⚠|";
	else
		settings_contact = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:contact" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_contact = "Bᴀɴ |⛔️|";
	else
		settings_contact = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:contact" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_contact = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_contact = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:game" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_game = "Dᴇʟ |❌|";
	else
		settings_game = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:game" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_game = "Mᴜᴛᴇ |📵|";
	else
		settings_game = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:game" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_game = "Wᴀʀɴ |⚠|";
	else
		settings_game = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:game" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_game = "Bᴀɴ |⛔️|";
	else
		settings_game = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:game" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_game = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_game = "غیرفعال |⬜️|";
	end;
	end

	
	
	if base:get(TD_ID .. "sg:file" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_file = "Dᴇʟ |❌|";
	else
		settings_file = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:file" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_file = "Mᴜᴛᴇ |📵|";
	else
		settings_file = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:file" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_file = "Wᴀʀɴ |⚠|";
	else
		settings_file = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:file" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_file = "Bᴀɴ |⛔️|";
	else
		settings_file = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:file" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_file = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_file = "غیرفعال |⬜️|";
	end;
	end




	if base:get(TD_ID .. "sg:loc" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_loc = "Dᴇʟ |❌|";
	else
		settings_loc = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:loc" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_loc = "Mᴜᴛᴇ |📵|";
	else
		settings_loc = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:loc" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_loc = "Wᴀʀɴ |⚠|";
	else
		settings_loc = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:loc" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_loc = "Bᴀɴ |⛔️|";
	else
		settings_loc = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:loc" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_loc = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_loc = "غیرفعال |⬜️|";
	end;
	end



	if base:get(TD_ID .. "sg:caption" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_caption = "Dᴇʟ |❌|";
	else
		settings_caption = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:caption" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_caption = "Mᴜᴛᴇ |📵|";
	else
		settings_caption = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:caption" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_caption = "Wᴀʀɴ |⚠|";
	else
		settings_caption = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:caption" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_caption = "Bᴀɴ |⛔️|";
	else
		settings_caption = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:caption" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_caption = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_caption = "غیرفعال |⬜️|";
	end;
	end
	
	
	
	
	if base:get(TD_ID .. "sg:inline" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_inline = "Dᴇʟ |❌|";
	else
		settings_inline = "حذف |❌|";
	end
	elseif base:get(TD_ID .. "sg:inline" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_inline = "Mᴜᴛᴇ |📵|";
	else
		settings_inline = "سکوت |📵|";
	end
	elseif base:get(TD_ID .. "sg:inline" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_inline = "Wᴀʀɴ |⚠|";
	else
		settings_inline = "اخطار |⚠|";
	end
	elseif base:get(TD_ID .. "sg:inline" .. chat) == "ban" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_inline = "Bᴀɴ |⛔️|";
	else
		settings_inline = "مسدود |⛔️|";
	end
	elseif not base:get((TD_ID .. "sg:inline" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_inline = "Dɪsᴀʙʟᴇᴅ |⬜️|"
	else
		settings_inline = "غیرفعال |⬜️|";
	end;
	end
	
	
	
	

	
	if base:get(TD_ID .. "Del:Spam" .. chat) == "del" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_spam = "Dᴇʟ Sᴘᴀᴍ |🗑|";
	    else
		settings_spam = "حذف اسپم |🗑|";
		end
	elseif base:get(TD_ID .. "Del:Spam" .. chat) == "mute" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_spam = "Mᴜᴛᴇ Sᴘᴀᴍ |📵|";
	    else
		settings_spam = "سکوت اسپم |📵|";
		end
	elseif base:get(TD_ID .. "Del:Spam" .. chat) == "warn" then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_spam = "Wᴀʀɴ Sᴘᴀᴍ |⚠️|";
	    else
		settings_spam = "اخطار اسپم |⚠️|";
		end
	elseif not base:get((TD_ID .. "Del:Spam" .. chat)) then
	if base:sismember(TD_ID .. "Gp2:" .. chat, "Telebotlang") then
	    settings_spam = "Dɪsᴀʙʟᴇᴅ |⬜️|";
	    else
		settings_spam = "غیرفعال |⬜️|";
		end
	end;
	
	
	

	if not base:get((TD_ID .. "FloodMedia:Time:" .. chat)) then
		TIME_CHECKM = "2";
	else
		TIME_CHECKM = base:get(TD_ID .. "FloodMedia:Time:" .. chat);
	end;
	if not base:get((TD_ID .. "FloodMedia:Max:" .. chat)) then
		MSG_MAXM = "6";
	else
		MSG_MAXM = base:get(TD_ID .. "FloodMedia:Max:" .. chat);
	end;
	
	
	if base:get(TD_ID .. "Mute:Attack" .. chat) == "mute" then
		settings_attack = "سکوت |📵|";
	elseif base:get(TD_ID .. "Mute:Attack" .. chat) == "ban" then
		settings_attack = "مسدود |⛔️|";
	elseif not base:get((TD_ID .. "Mute:Attack" .. chat)) then
		settings_attack = "غیرفعال |⬜️|";
	end;
	
	
	
	if not base:get((TD_ID .. "Attack:Time:" .. chat)) then
		TIME_Attack = "5";
	else
		TIME_Attack = base:get(TD_ID .. "Attack:Time:" .. chat);
	end;
	if not base:get((TD_ID .. "Attack:Max:" .. chat)) then
		MSG_Attack = "6";
	else
		MSG_Attack = base:get(TD_ID .. "Attack:Max:" .. chat);
	end;
	if not base:get((TD_ID .. "JoinMSG:Time:" .. chat)) then
		TIME_JoinMSG = "15";
	else
		TIME_JoinMSG = base:get(TD_ID .. "JoinMSG:Time:" .. chat);
	end;
	if not base:get((TD_ID .. "Flood:Time:" .. chat)) then
		TIME_CHECK = "2";
	else
		TIME_CHECK = base:get(TD_ID .. "Flood:Time:" .. chat);
	end;
	if not base:get((TD_ID .. "checkservicetime:" .. chat)) then
		checkservicetime = "20";
	else
		checkservicetime = base:get(TD_ID .. "checkservicetime:" .. chat);
	end;
	if not base:get((TD_ID .. "checkpmtime:" .. chat)) then
		checkpmtime = "20";
	else
		checkpmtime = base:get(TD_ID .. "checkpmtime:" .. chat);
	end;
	if not base:get((TD_ID .. "Flood:Max:" .. chat)) then
		MSG_MAX = "6";
	else
		MSG_MAX = base:get(TD_ID .. "Flood:Max:" .. chat);
	end;
	if not base:get((TD_ID .. "Kheyanat:Time:" .. chat)) then
		KheyanatTime = "60";
	else
		KheyanatTime = base:get(TD_ID .. "Kheyanat:Time:" .. chat);
	end;
	if not base:get((TD_ID .. "Kheyanat:Max:" .. chat)) then
		KheyanatMax = "10";
	else
		KheyanatMax = base:get(TD_ID .. "Kheyanat:Max:" .. chat);
	end;
	if not base:get((TD_ID .. "Warn:Max:" .. chat)) then
		warn = "5";
	else
		warn = base:get(TD_ID .. "Warn:Max:" .. chat);
	end;
	if not base:get((TD_ID .. "NUM_CH_MAX:" .. chat)) then
		CH_MAX = "400";
	else
		CH_MAX = base:get(TD_ID .. "NUM_CH_MAX:" .. chat);
	end;
	
	
	

	
	
	
	
	
	if not base:get((TD_ID .. "Force:Max:" .. chat)) then
		Add_MAX = "10";
	else
		Add_MAX = base:get(TD_ID .. "Force:Max:" .. chat);
	end;
	if not base:get((TD_ID .. "Force:Pm:" .. chat)) then
		forcepm = "3";
	else
		forcepm = base:get(TD_ID .. "Force:Pm:" .. chat);
	end;

	
	if not base:get((TD_ID .. "joinwarn:" .. chat)) then
		JoinWarn = "4";
	else
		JoinWarn = base:get(TD_ID .. "joinwarn:" .. chat);
	end;
	
	
end;
