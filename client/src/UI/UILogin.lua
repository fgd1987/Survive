local UILogin = class("UILogin", function()
    return require("UI.UIBaseLayer").create()
end)

function UILogin.create()
    local layer = UILogin.new()
    return layer
end

function UILogin:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil

    self.createSprite("UI/login/login_bk.png", 
        {x = self.visibleSize.width/2, y = self.visibleSize.height/2 + 50}, {self})
        
    local nodeMid = cc.Node:create()
    self.nodeMid = nodeMid
    nodeMid:setPositionX((self.visibleSize.width - 960)/2)
    self:addChild(self.nodeMid)
    
    local function btnHandle(sender, event)
        print("pre connect")
        Connect("121.40.90.61", 8010)
        --cc.Director:getInstance():replaceScene(require("SceneLoading.lua").create())
    end
    
    self.createButton{pos = {x = 500, y = 180},
        icon = "UI/login/enterGame.png",
        handle = btnHandle,
        parent = nodeMid
    }
    
    self.createButton{pos = {x = 380, y = 200},
        icon = "UI/login/vistorLogin.png",
        handle = btnHandle,
        parent = nodeMid
    }
    
    self.createButton{pos = {x = 250, y = 205},
        icon = "UI/login/Register.png",
        handle = btnHandle,
        parent = nodeMid
    }

    local function onTextHandle(typestr)
        if typestr == "began" then
        elseif typestr == "changed" then

        elseif typestr == "ended" then
        elseif typestr == "return" then
        end
        --return true
    end
    
    self.txtUserName = ccui.EditBox:create({width = 255, height = 60},
        "UI/login/txtInput.png")
        --self.createScale9Sprite("UI/login/txtInput.png", nil, {widht = 255, height = 55}, {}))
    self.txtUserName:setPosition(410, 370)
    self.txtUserName:setAnchorPoint(0, 0.5)
    self.txtUserName:registerScriptEditBoxHandler(onTextHandle)
    nodeMid:addChild(self.txtUserName)
    
    self.txtPass = ccui.EditBox:create({width = 255, height = 60},
        "UI/login/txtInput.png")
        --self.createScale9Sprite("UI/login/txtInput.png", nil, {widht = 255, height = 55}, {}))
    self.txtPass:setPosition(410, 310)
    self.txtPass:setAnchorPoint(0, 0.5)
    self.txtPass:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
    self.txtPass:registerScriptEditBoxHandler(onTextHandle)
    nodeMid:addChild(self.txtPass)

    RegHandler(function (rpk)     
        print("CMD_CC_CONNECT_SUCCESS")    
        local userName = self.txtUserName:getText()
        local pass = self.txtPass:getText()
        CMD_LOGIN(userName, pass, 1)
    end, CMD_CC_CONNECT_SUCCESS)

    --beginButton:registerControlEventHandler(btnHandle, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)
end
    
RegHandler(function (rpk) 
    print("CMD_CC_CONNECT_FAILED")
end, CMD_CC_CONNECT_FAILED)
    
RegHandler(function (rpk) 
    print("CMD_CC_DISCONNECTED")
end, CMD_CC_DISCONNECTED)
    
return UILogin