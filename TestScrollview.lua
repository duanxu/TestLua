require "Cocos2d"
require "Cocos2dConstants"

-- 避免内存泄漏
collectgarbage( "setpause", 100)
collectgarbage( "setstepmul", 5000)
local TestScrollview = class("TestScrollview",function()
    return cc.Scene:create()
end)

function TestScrollview:create()
    local scene = TestScrollview.new()
    scene:addChild(scene:createLeftView())
--    scene:addChild(createRightView())
    local person_pb = require("person_pb");
    local msg = person_pb.Person()  
    msg.id = 100   
    msg.name = "foo"   
    msg.email = "bar"   

    local pb_data = msg:SerializeToString()  -- Parse Example  
    print("create:", msg.id, msg.name, msg.email, pb_data)  


    local msg = person_pb.Person()   
    msg:ParseFromString(pb_data)   
    print("parser:", msg.id, msg.name, msg.email, pb_data)  
    return scene
end

function TestScrollview:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
end


function TestScrollview:createLeftView()
    local layer = cc.Layer:create();
--    layer:setContentSize(self.visibleSize.width, self.visibleSize.height)
    local sp1= cc.Sprite:create("farm.jpg");
    sp1:setAnchorPoint(0,0)
    sp1:setPosition(0,0)
    local sp2= cc.Sprite:create("farm.jpg");
    sp2:setAnchorPoint(0,0)
    sp2:setPosition(800,0)
    layer:addChild(sp1)
    layer:addChild(sp2)
    local leftScroll = cc.ScrollView:create(cc.size(self.visibleSize.width/2,800),layer);
	leftScroll:setDelegate()
    leftScroll:setBounceable(false)
--    leftScroll:setTouchEnabled(false);
    leftScroll:setContentSize(sp1:getTexture():getContentSize().width*2,sp1:getTexture():getContentSize().height);
	leftScroll:setAnchorPoint(0,0)
	leftScroll:setPosition(0,0)
	return leftScroll
	
end

return TestScrollview