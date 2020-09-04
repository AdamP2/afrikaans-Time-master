--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:ddb4661d764bb0d2f128b3af6643b2bd:f497b594ab9ef5ab076fe5f53f93c11c:6328cd8ac6e897d36a0780eef5468788$
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
            -- Xander-Tyd-Scene-School 01_00000
            x=3,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00006
            x=285,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00012
            x=567,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00018
            x=849,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00024
            x=3,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00030
            x=285,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00036
            x=567,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00042
            x=849,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00048
            x=3,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00054
            x=285,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00060
            x=567,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00066
            x=849,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00072
            x=3,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00078
            x=285,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00084
            x=567,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00090
            x=849,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00096
            x=3,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00102
            x=285,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00108
            x=567,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00114
            x=849,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Tyd-Scene-School 01_00120
            x=3,
            y=813,
            width=276,
            height=156,

        },
    },
    
    sheetContentWidth = 1130,
    sheetContentHeight = 972
}

SheetInfo.frameIndex =
{

    ["Xander-Tyd-Scene-School 01_00000"] = 1,
    ["Xander-Tyd-Scene-School 01_00006"] = 2,
    ["Xander-Tyd-Scene-School 01_00012"] = 3,
    ["Xander-Tyd-Scene-School 01_00018"] = 4,
    ["Xander-Tyd-Scene-School 01_00024"] = 5,
    ["Xander-Tyd-Scene-School 01_00030"] = 6,
    ["Xander-Tyd-Scene-School 01_00036"] = 7,
    ["Xander-Tyd-Scene-School 01_00042"] = 8,
    ["Xander-Tyd-Scene-School 01_00048"] = 9,
    ["Xander-Tyd-Scene-School 01_00054"] = 10,
    ["Xander-Tyd-Scene-School 01_00060"] = 11,
    ["Xander-Tyd-Scene-School 01_00066"] = 12,
    ["Xander-Tyd-Scene-School 01_00072"] = 13,
    ["Xander-Tyd-Scene-School 01_00078"] = 14,
    ["Xander-Tyd-Scene-School 01_00084"] = 15,
    ["Xander-Tyd-Scene-School 01_00090"] = 16,
    ["Xander-Tyd-Scene-School 01_00096"] = 17,
    ["Xander-Tyd-Scene-School 01_00102"] = 18,
    ["Xander-Tyd-Scene-School 01_00108"] = 19,
    ["Xander-Tyd-Scene-School 01_00114"] = 20,
    ["Xander-Tyd-Scene-School 01_00120"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
