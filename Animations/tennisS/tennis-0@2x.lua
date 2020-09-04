--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1e9e53aba6ee60ec72b720d62cb486de:902327e7cef1227b5e77e57ae0bd8600:ab6e54a077648e775f38276965ed13b7$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Xander-Tyd-Scene-Tennis-01_00000
            x=5,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00007
            x=475,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00014
            x=945,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00021
            x=1415,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00028
            x=5,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00035
            x=475,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00042
            x=945,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00049
            x=1415,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00056
            x=5,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00063
            x=475,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00070
            x=945,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00077
            x=1415,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00084
            x=5,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00091
            x=475,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00098
            x=945,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00105
            x=1415,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00112
            x=5,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00119
            x=475,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00126
            x=945,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00133
            x=1415,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-Tennis-01_00140
            x=5,
            y=1355,
            width=460,
            height=260,

        },
    },
    
    sheetContentWidth = 1884,
    sheetContentHeight = 1620
}

SheetInfo.frameIndex =
{

    ["Xander-Tyd-Scene-Tennis-01_00000"] = 1,
    ["Xander-Tyd-Scene-Tennis-01_00007"] = 2,
    ["Xander-Tyd-Scene-Tennis-01_00014"] = 3,
    ["Xander-Tyd-Scene-Tennis-01_00021"] = 4,
    ["Xander-Tyd-Scene-Tennis-01_00028"] = 5,
    ["Xander-Tyd-Scene-Tennis-01_00035"] = 6,
    ["Xander-Tyd-Scene-Tennis-01_00042"] = 7,
    ["Xander-Tyd-Scene-Tennis-01_00049"] = 8,
    ["Xander-Tyd-Scene-Tennis-01_00056"] = 9,
    ["Xander-Tyd-Scene-Tennis-01_00063"] = 10,
    ["Xander-Tyd-Scene-Tennis-01_00070"] = 11,
    ["Xander-Tyd-Scene-Tennis-01_00077"] = 12,
    ["Xander-Tyd-Scene-Tennis-01_00084"] = 13,
    ["Xander-Tyd-Scene-Tennis-01_00091"] = 14,
    ["Xander-Tyd-Scene-Tennis-01_00098"] = 15,
    ["Xander-Tyd-Scene-Tennis-01_00105"] = 16,
    ["Xander-Tyd-Scene-Tennis-01_00112"] = 17,
    ["Xander-Tyd-Scene-Tennis-01_00119"] = 18,
    ["Xander-Tyd-Scene-Tennis-01_00126"] = 19,
    ["Xander-Tyd-Scene-Tennis-01_00133"] = 20,
    ["Xander-Tyd-Scene-Tennis-01_00140"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
