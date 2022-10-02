-- set the class a dummy name, since creator is the same name
-- eg. class name Point, creator name also Point will work
--     but will result in messy suggestions
---@class cPoint
---@field X number
---@field Y number

-- creator
---@type fun( x:number, y:number ) : cPoint
Point = {};

---@class Shapes
---@field Origin cPoint
local Shapes = nil;

---@type fun( x:number, y:number )
function Shapes:Move( x, y ) end

---@class cCircle : Shapes
---@field Radius number
local cCircle = {};           -- define to be able to ...

---@type fun( angle:number )
function cCircle:Roll( angle ) end  --    ... add methods

---@type fun( x:number, y:number, r:number ) : cCircle
Circle = {};

---@class cRectangle:Shapes
---@field Width number
---@field Height number
local cRectangle = {};

---@type fun( origin:cPoint, w:number, h:number ) : cRectangle
Rectangle = nil;

-- no method overload, so just force it
---@type fun( x:number, y:number, w:number, h:number ) : cRectangle
Rectangle = nil;