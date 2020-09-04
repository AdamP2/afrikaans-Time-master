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
            x=5,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00006
            x=475,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00012
            x=945,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00018
            x=1415,
            y=5,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00024
            x=5,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00030
            x=475,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00036
            x=945,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00042
            x=1415,
            y=275,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00048
            x=5,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00054
            x=475,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00060
            x=945,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00066
            x=1415,
            y=545,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00072
            x=5,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00078
            x=475,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00084
            x=945,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00090
            x=1415,
            y=815,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00096
            x=5,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00102
            x=475,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00108
            x=945,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00114
            x=1415,
            y=1085,
            width=460,
            height=260,

        },
        {
            -- Xander-Tyd-Scene-School 01_00120
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
