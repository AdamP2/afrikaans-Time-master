--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0e0c6bf055bf3aafcf35d6bf5ef725be:2113d811abcb1d3818e7a34946b777e5:d69723878875735c5bb390d064237575$
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
            -- Xander-Type-Scene-Bath-01_00000
            x=3,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00006
            x=285,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00012
            x=567,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00018
            x=849,
            y=3,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00024
            x=3,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00030
            x=285,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00036
            x=567,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00042
            x=849,
            y=165,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00048
            x=3,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00054
            x=285,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00060
            x=567,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00066
            x=849,
            y=327,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00072
            x=3,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00078
            x=285,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00084
            x=567,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00090
            x=849,
            y=489,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00096
            x=3,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00102
            x=285,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00108
            x=567,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00114
            x=849,
            y=651,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00120
            x=3,
            y=813,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00126
            x=285,
            y=813,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00132
            x=567,
            y=813,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00138
            x=849,
            y=813,
            width=276,
            height=156,

        },
        {
            -- Xander-Type-Scene-Bath-01_00144
            x=3,
            y=975,
            width=276,
            height=156,

        },
    },
    
    sheetContentWidth = 1130,
    sheetContentHeight = 1138
}

SheetInfo.frameIndex =
{

    ["Xander-Type-Scene-Bath-01_00000"] = 1,
    ["Xander-Type-Scene-Bath-01_00006"] = 2,
    ["Xander-Type-Scene-Bath-01_00012"] = 3,
    ["Xander-Type-Scene-Bath-01_00018"] = 4,
    ["Xander-Type-Scene-Bath-01_00024"] = 5,
    ["Xander-Type-Scene-Bath-01_00030"] = 6,
    ["Xander-Type-Scene-Bath-01_00036"] = 7,
    ["Xander-Type-Scene-Bath-01_00042"] = 8,
    ["Xander-Type-Scene-Bath-01_00048"] = 9,
    ["Xander-Type-Scene-Bath-01_00054"] = 10,
    ["Xander-Type-Scene-Bath-01_00060"] = 11,
    ["Xander-Type-Scene-Bath-01_00066"] = 12,
    ["Xander-Type-Scene-Bath-01_00072"] = 13,
    ["Xander-Type-Scene-Bath-01_00078"] = 14,
    ["Xander-Type-Scene-Bath-01_00084"] = 15,
    ["Xander-Type-Scene-Bath-01_00090"] = 16,
    ["Xander-Type-Scene-Bath-01_00096"] = 17,
    ["Xander-Type-Scene-Bath-01_00102"] = 18,
    ["Xander-Type-Scene-Bath-01_00108"] = 19,
    ["Xander-Type-Scene-Bath-01_00114"] = 20,
    ["Xander-Type-Scene-Bath-01_00120"] = 21,
    ["Xander-Type-Scene-Bath-01_00126"] = 22,
    ["Xander-Type-Scene-Bath-01_00132"] = 23,
    ["Xander-Type-Scene-Bath-01_00138"] = 24,
    ["Xander-Type-Scene-Bath-01_00144"] = 25,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
