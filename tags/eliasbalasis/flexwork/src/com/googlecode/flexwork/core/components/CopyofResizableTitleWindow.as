package com.googlecode.flexwork.core.components
{	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.effects.*;
	import mx.effects.easing.*;
	import mx.managers.*;
	import mx.states.*;

	use namespace mx_internal;
	//http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1729526
//	<!-- reference: http://www.wietseveenstra.nl/files/flex/SuperPanel/v1_5/srcview/index.html -->
//	<!-- reference: http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1207017 -->

    public class CopyofResizableTitleWindow extends TitleWindow
    {
        private var stateMin:State;
        private var handleEdge:Number;
        private var fullTitle:String = "";
        private var origPerDimensions:Point;
        private var cursorId:Number = 0;
        private var dCursorSymbol:Class;
        private var stateMax:State;
        private var hCursorSymbol:Class;
        private var maximizeButton:Button;
        private var vCursorSymbol:Class;
        private var statePseudoMax:State;
        private var origPosition:Point;
        private var origDimensionsCached:Boolean = false;
        private var _closeable:Boolean = true;
        private var _maximizable:Boolean = true;
        private var stateNormal:State;
        private var rdCursorSymbol:Class;
        private var isHandleDragging:Boolean = false;
        private var origDimensions:Point;
        private var lastEdge:Number = 0;
        private static const RESTORE_BUTTON:Class = ResizableTitleWindow_RESTORE_BUTTON;
        private static const MAXIMIZE_BUTTON:Class = ResizableTitleWindow_MAXIMIZE_BUTTON;
        private static var EDGE_LEFT_BOTTOM:Number = 6;
        private static var EDGE_LEFT:Number = 3;
        private static const MINIMIZE_BUTTON:Class = ResizableTitleWindow_MINIMIZE_BUTTON;
        private static var EDGE_BOTTOM:Number = 1;
        private static var EDGE_RIGHT_TOP:Number = 8;
        private static var EDGE_NONE:Number = 0;
        private static var EDGE_TOP:Number = 4;
        private static var EDGE_CORNER:Number = 5;
        private static var EDGE_RIGHT:Number = 2;
        private static var EDGE_LEFT_TOP:Number = 7;
		//TODO:private var resizeEffect:Resize = new Resize();
        public function ResizableTitleWindow()
        {
        	this.setStyle("headerColors", [0xCCDBF6,0x99BAF3]);
        	this.setStyle("borderColor", 0x99BAF3);
			//TODO:this.setStyle("resizeEffect", resizeEffect);
            vCursorSymbol = ResizableTitleWindow_vCursorSymbol;
            hCursorSymbol = ResizableTitleWindow_hCursorSymbol;
            dCursorSymbol = ResizableTitleWindow_dCursorSymbol;
            rdCursorSymbol = ResizableTitleWindow_rdCursorSymbol;
            handleEdge = EDGE_NONE;
            isPopUp = true;
            doubleClickEnabled = true;
            setStyle("headerHeight", 27);
            setStyle("cornerRadius", 4);
            setStyle("borderAlpha", 1);
            setStyle("dropShadowEnabled", true);
            setStyle("resizeAffordance", 6);
            addEventListener(Event.CLOSE, closeHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, true);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false);
            addEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler);
            addEventListener(MouseEvent.ROLL_OUT, systemManager_mouseMoveHandler);
            return;
        }

        private function isCursorOnEdge(event:MouseEvent) : void
        {
            var _loc_2:Point = null;
            var _loc_3:Point = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:* = getStyle("resizeAffordance") as Number;
            _loc_2 = new Point(x, y);
            _loc_2 = this.parent.localToGlobal(_loc_2);
            _loc_3 = new Point(event.stageX, event.stageY);
            _loc_4 = _loc_3.x - this.width - _loc_2.x;
            _loc_5 = _loc_3.x - _loc_2.x;
            _loc_6 = _loc_3.y - this.height - _loc_2.y;
            _loc_7 = _loc_3.y - _loc_2.y;
            if (event.type == "rollOut")
            {
                handleEdge = EDGE_NONE;
            }
            else
            {
                handleEdge = EDGE_NONE;
                if (handleEdge == EDGE_NONE)
                {
                    if (Math.abs(_loc_4) < _loc_8 && Math.abs(_loc_6) < _loc_8)
                    {
                        handleEdge = EDGE_CORNER;
                    }
                    else if (Math.abs(_loc_4) < _loc_8 && Math.abs(_loc_7) < _loc_8)
                    {
                        handleEdge = EDGE_RIGHT_TOP;
                    }
                    else if (Math.abs(_loc_5) < _loc_8 && Math.abs(_loc_7) < _loc_8)
                    {
                        handleEdge = EDGE_LEFT_TOP;
                    }
                    else if (Math.abs(_loc_5) < _loc_8 && Math.abs(_loc_6) < _loc_8)
                    {
                        handleEdge = EDGE_LEFT_BOTTOM;
                    }
                    else if (Math.abs(_loc_6) < _loc_8)
                    {
                        handleEdge = EDGE_BOTTOM;
                    }
                    else if (Math.abs(_loc_4) < _loc_8)
                    {
                        handleEdge = EDGE_RIGHT;
                    }
                    else if (Math.abs(_loc_5) < _loc_8)
                    {
                        handleEdge = EDGE_LEFT;
                    }
                    else if (Math.abs(_loc_7) < _loc_8)
                    {
                        handleEdge = EDGE_TOP;
                    }
                }
            }
            return;
        }

        private function systemManager_mouseDownHandler(event:MouseEvent) : void
        {
            if (handleEdge != EDGE_NONE)
            {
                isHandleDragging = true;
                event.stopPropagation();
            }
            return;
        }

        private function toPseudoMax() : void
        {
            if (currentState == "maximized")
            {
                pushStateProperties(statePseudoMax, x, y, width, height, NaN, NaN);
            }
            return;
        }

        private function populateProperty(param1:DisplayObject, param2:String, param3:Number) : SetProperty
        {
            var _loc_4:* = new SetProperty();
            new SetProperty().target = param1;
            _loc_4.name = param2;
            _loc_4.value = param3;
            return _loc_4;
        }

        public function get maximizable() : Boolean
        {
            return _maximizable;
        }

        override protected function createChildren() : void
        {
            var _loc_1:ISystemManager = null;
            super.createChildren();
            if (parent is ISystemManager)
            {
                _loc_1 = ISystemManager(parent);
            }
            else if (parent is IUIComponent)
            {
                _loc_1 = IUIComponent(parent).systemManager;
            }
            if (_loc_1)
            {
                _loc_1.addEventListener(Event.RESIZE, resizeHandler, false, -5);
            }
            setEffects();
            fullTitle = title;
            storeOrigDimensions();
            if (titleBar)
            {
                titleBar.height = getHeaderHeight();
                titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBar_mouseClickHandler);
                if (closeable)
                {
                    showCloseButton = true;
                }
                if (!maximizeButton)
                {
                    maximizeButton = new Button();
                    maximizeButton.setStyle("upIcon", MAXIMIZE_BUTTON);
                    maximizeButton.setStyle("overIcon", MAXIMIZE_BUTTON);
                    maximizeButton.setStyle("downIcon", MAXIMIZE_BUTTON);
                    maximizeButton.setStyle("disabledIcon", MAXIMIZE_BUTTON);
                    maximizeButton.explicitWidth = 16;
                    maximizeButton.explicitHeight = 16;
                    maximizeButton.visible = false;
                    maximizeButton.enabled = enabled;
                    maximizeButton.focusEnabled = false;
                    maximizeButton.addEventListener(MouseEvent.CLICK, titleBar_mouseClickHandler);
                    titleBar.addChild(maximizeButton);
                    maximizeButton.owner = this;
                }
            }
            return;
        }

        public function set closeable(param1:Boolean) : void
        {
            _closeable = param1;
            invalidateDisplayList();
            return;
        }

        private function setSize(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = explicitMinWidth;
            if (isNaN(_loc_5))
            {
                _loc_5 = 100;
            }
            var _loc_6:* = explicitMinHeight;
            if (isNaN(_loc_6))
            {
                _loc_6 = 35;
            }
            param3 = Math.max(_loc_5, param3);
            param4 = Math.max(_loc_6, param4);
            var _loc_7:* = new Point(param1, param2);
            _loc_7 = this.parent.globalToLocal(_loc_7);
            x = _loc_7.x;
            y = _loc_7.y;
            width = param3;
            height = param4;
            storeOrigDimensions();
            return;
        }

        private function pushStateProperties(param1:State, param2:int, param3:int, param4:uint, param5:uint, param6:uint, param7:uint) : void
        {
            var _loc_8:SetProperty = null;
            _loc_8 = populateProperty(this, "x", param2);
            param1.overrides.push(_loc_8);
            _loc_8 = populateProperty(this, "y", param3);
            param1.overrides.push(_loc_8);
            if (param6)
            {
                _loc_8 = populateProperty(this, "percentWidth", param6);
            }
            else
            {
                _loc_8 = populateProperty(this, "width", param4);
            }
            param1.overrides.push(_loc_8);
            if (param7)
            {
                _loc_8 = populateProperty(this, "percentHeight", param7);
            }
            else
            {
                _loc_8 = populateProperty(this, "height", param5);
            }
            param1.overrides.push(_loc_8);
            setCurrentState(param1.name);
            return;
        }

        private function storeOrigDimensions() : void
        {
            origPosition = new Point();
            origDimensions = new Point();
            origPerDimensions = new Point();
            if (parent is ISystemManager)
            {
                origPosition.x = parent.x;
                origPosition.y = parent.y;
                origPosition = this.localToGlobal(origPosition);
            }
            else
            {
                origPosition.x = x;
                origPosition.y = y;
            }
            if (percentWidth)
            {
                origPerDimensions.x = percentWidth;
            }
            else
            {
                origDimensions.x = getExplicitOrMeasuredWidth();
            }
            if (percentHeight)
            {
                origPerDimensions.y = percentHeight;
            }
            else
            {
                origDimensions.y = getExplicitOrMeasuredHeight();
            }
            return;
        }

        private function closeHandler(event:Event) : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            event.stopPropagation();
            return;
        }

        private function resize(event:MouseEvent) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:* = new Point(x, y);
            _loc_4 = this.parent.localToGlobal(_loc_4);
            var _loc_5:* = new Point(event.stageX, event.stageY);
            if (handleEdge == EDGE_BOTTOM)
            {
                setSize(_loc_4.x, _loc_4.y, width, _loc_5.y - _loc_4.y);
            }
            else if (handleEdge == EDGE_RIGHT)
            {
                setSize(_loc_4.x, _loc_4.y, _loc_5.x - _loc_4.x, height);
            }
            else if (handleEdge == EDGE_LEFT)
            {
                setSize(_loc_5.x, _loc_4.y, _loc_4.x - _loc_5.x + width, height);
            }
            else if (handleEdge == EDGE_TOP)
            {
                setSize(_loc_4.x, _loc_5.y, width, _loc_4.y - _loc_5.y + height);
            }
            else if (handleEdge == EDGE_CORNER)
            {
                setSize(_loc_4.x, _loc_4.y, _loc_5.x - _loc_4.x, _loc_5.y - _loc_4.y);
            }
            else if (handleEdge == EDGE_LEFT_TOP)
            {
                setSize(_loc_5.x, _loc_5.y, _loc_4.x - _loc_5.x + width, _loc_4.y - _loc_5.y + height);
            }
            else if (handleEdge == EDGE_LEFT_BOTTOM)
            {
                setSize(_loc_5.x, _loc_4.y, _loc_4.x - _loc_5.x + width, _loc_5.y - _loc_4.y);
            }
            else if (handleEdge == EDGE_RIGHT_TOP)
            {
                setSize(_loc_4.x, _loc_5.y, _loc_5.x - _loc_4.x, _loc_4.y - _loc_5.y + height);
            }
            return;
        }

        private function setResizeCursor(event:MouseEvent) : void
        {
            var _loc_2:Class = null;
            isCursorOnEdge(event);
            if (handleEdge != EDGE_NONE && currentState == "normal")
            {
                if (cursorId == 0 || lastEdge != handleEdge)
                {
                    if (lastEdge != handleEdge)
                    {
                        CursorManager.removeCursor(cursorId);
                        cursorId = 0;
                    }
                    _loc_2 = null;
                    if (handleEdge == EDGE_CORNER || handleEdge == EDGE_LEFT_TOP)
                    {
                        _loc_2 = dCursorSymbol;
                    }
                    else if (handleEdge == EDGE_LEFT_BOTTOM || handleEdge == EDGE_RIGHT_TOP)
                    {
                        _loc_2 = rdCursorSymbol;
                    }
                    else if (handleEdge == EDGE_RIGHT || handleEdge == EDGE_LEFT)
                    {
                        _loc_2 = hCursorSymbol;
                    }
                    else if (handleEdge == EDGE_BOTTOM || handleEdge == EDGE_TOP)
                    {
                        _loc_2 = vCursorSymbol;
                    }
                    if (_loc_2 != null)
                    {
                        cursorId = CursorManager.setCursor(_loc_2, CursorManagerPriority.HIGH, -16, -16);
                    }
                    lastEdge = handleEdge;
                }
            }
            else if (cursorId != 0)
            {
                CursorManager.removeCursor(cursorId);
                cursorId = 0;
                lastEdge = EDGE_NONE;
            }
            return;
        }

        public function set maximizable(param1:Boolean) : void
        {
            _maximizable = param1;
            invalidateDisplayList();
            return;
        }

        private function titleBar_mouseClickHandler(event:MouseEvent) : void
        {
            if (this.parent != null && event is MouseEvent)
            {
                if (event.type == MouseEvent.DOUBLE_CLICK && event.currentTarget == titleBar)
                {
                    if (currentState == "normal")
                    {
                        toMaximized();
                    }
                    else if (currentState == "maximized")
                    {
                        toNormal();
                    }
                }
                else if (event.type == MouseEvent.CLICK)
                {
                    if (event.target == maximizeButton)
                    {
                        if (currentState == "maximized")
                        {
                            toNormal();
                        }
                        else if (currentState == "normal")
                        {
                            toMaximized();
                        }
                    }
                    event.preventDefault();
                }
            }
            return;
        }

        override protected function layoutChrome(param1:Number, param2:Number) : void
        {
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_13:Number = NaN;
            super.layoutChrome(param1, param2);
            var _loc_3:uint = 0;
            var _loc_4:* = getHeaderHeight();
            var _loc_5:* = borderMetrics;
            var _loc_6:* = borderMetrics.right;
            var _loc_7:uint = 0;
            _loc_6 = 3;
            maximizeButton.visible = maximizable;
            if (maximizable)
            {
                _loc_3 = Math.max(_loc_3, maximizeButton.getExplicitOrMeasuredHeight());
            }
            if (closeable)
            {
                _loc_3 = Math.max(_loc_3, closeButton.getExplicitOrMeasuredHeight());
            }
            var _loc_8:* = Math.round((_loc_4 - _loc_3) / 2);
            _loc_7 = param1 - _loc_5.right;
            if (closeable)
            {
                _loc_9 = closeButton.getExplicitOrMeasuredWidth();
                _loc_10 = closeButton.getExplicitOrMeasuredHeight();
                closeButton.setActualSize(_loc_9, _loc_10);
                _loc_7 = _loc_7 - (_loc_9 + _loc_6);
                closeButton.move(_loc_7, _loc_8);
            }
            if (maximizable)
            {
                _loc_9 = maximizeButton.getExplicitOrMeasuredWidth();
                _loc_10 = maximizeButton.getExplicitOrMeasuredHeight();
                maximizeButton.setActualSize(_loc_9, _loc_10);
                _loc_7 = _loc_7 - (_loc_9 + _loc_6);
                maximizeButton.move(_loc_7, _loc_8);
            }
            var _loc_11:Number = 10;
            var _loc_12:* = param1 - _loc_5.right - _loc_7;
            if (titleIconObject)
            {
                _loc_10 = titleIconObject.height;
                _loc_13 = (_loc_4 - _loc_10) / 2;
                titleIconObject.move(_loc_11, _loc_13);
                _loc_11 = _loc_11 + (titleIconObject.width + 4);
            }
            _loc_10 = titleTextField.textHeight;
            _loc_13 = (_loc_4 - _loc_10) / 2;
            var _loc_14:* = _loc_5.left + _loc_5.right;
            titleTextField.move(_loc_11, _loc_13--);
            titleTextField.setActualSize(Math.max(0, param1 - _loc_11 - _loc_12 - _loc_14), _loc_10 + UITextField.TEXT_HEIGHT_PADDING);
            _loc_10 = statusTextField.textHeight;
            _loc_13 = (_loc_4 - _loc_10) / 2;
            var _loc_15:* = param1 - _loc_12 - 4 - _loc_14 - statusTextField.textWidth;
            if (_showCloseButton)
            {
                _loc_15 = _loc_15 - (closeButton.getExplicitOrMeasuredWidth() + 4);
            }
            statusTextField.move(_loc_15, _loc_13--);
            statusTextField.setActualSize(statusTextField.textWidth + 8, statusTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING);
            var _loc_16:* = titleTextField.x + titleTextField.textWidth + 8;
            if (statusTextField.x < _loc_16)
            {
                statusTextField.width = Math.max(statusTextField.width - (_loc_16 - statusTextField.x), 0);
                statusTextField.x = _loc_16;
            }
            return;
        }

        private function setEffects() : void
        {
            stateNormal = new State();
            stateNormal.name = "normal";
            states.push(stateNormal);
            stateMax = new State();
            stateMax.name = "maximized";
            states.push(stateMax);
            statePseudoMax = new State();
            statePseudoMax.name = "pseudoMax";
            states.push(statePseudoMax);
            var _loc_1:* = new Move();
            _loc_1.duration = 200;
            _loc_1.easingFunction = Bounce.easeInOut;
            var _loc_2:* = new Resize();
            _loc_2.duration = 200;
            _loc_2.easingFunction = Linear.easeIn;
            var _loc_3:* = new Parallel();
            _loc_3.children.push(_loc_1);
            _loc_3.children.push(_loc_2);
            _loc_3.target = this;
            var _loc_4:* = new Sequence();
            new Sequence().children.push(_loc_3);
            var _loc_5:* = new Transition();
            new Transition().effect = _loc_4;
            _loc_5.fromState = "normal";
            _loc_5.toState = "maximized";
            transitions.push(_loc_5);
            _loc_5 = new Transition();
            _loc_5.effect = _loc_4;
            _loc_5.fromState = "maximized";
            _loc_5.toState = "normal";
            transitions.push(_loc_5);
            currentState = "normal";
            return;
        }

        private function toNormal() : void
        {
            pushStateProperties(stateNormal, origPosition.x, origPosition.y, origDimensions.x, origDimensions.y, origPerDimensions.x, origPerDimensions.y);
            maximizeButton.setStyle("upIcon", MAXIMIZE_BUTTON);
            maximizeButton.setStyle("overIcon", MAXIMIZE_BUTTON);
            maximizeButton.setStyle("downIcon", MAXIMIZE_BUTTON);
            maximizeButton.setStyle("disabledIcon", MAXIMIZE_BUTTON);
            dispatchEvent(new Event("restore"));
            return;
        }

        protected function setState(param1:String) : void
        {
            if (param1 == "maximized" && currentState != "maximized")
            {
                toMaximized();
            }
            else if (param1 == "normal" && currentState != "normal")
            {
                toNormal();
            }
            return;
        }

        override public function move(param1:Number, param2:Number) : void
        {
            trace("Setting x,y to " + param1 + "," + param2);
            super.move(param1, param2);
            return;
        }

        public function get closeable() : Boolean
        {
            return _closeable;
        }

        private function toMaximized() : void
        {
        	var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            var _loc_5:Rectangle = null;
            storeOrigDimensions();
            var _loc_1:* = new Point(0, 0);
            var _loc_4:* = new EdgeMetrics(0, 0, 6, 8);
            if (parent is Application)
            {
                _loc_5 = ISystemManager(root).screen;
                _loc_2 = _loc_5.width + 4;
                _loc_3 = _loc_5.height + 4;
            }
            else
            {
                _loc_2 = parent.width + 4;
                _loc_3 = parent.height + 4;
                _loc_1 = parent.localToGlobal(_loc_1);
                _loc_1 = parent.globalToLocal(_loc_1);
            }
            pushStateProperties(stateMax, _loc_1.x, _loc_1.y, _loc_2 - _loc_4.right, _loc_3 - _loc_4.bottom, NaN, NaN);
            maximizeButton.setStyle("upIcon", RESTORE_BUTTON);
            maximizeButton.setStyle("overIcon", RESTORE_BUTTON);
            maximizeButton.setStyle("downIcon", RESTORE_BUTTON);
            maximizeButton.setStyle("disabledIcon", RESTORE_BUTTON);
            dispatchEvent(new Event("maximize"));
            return;
        }

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = measureHeaderText();
            var _loc_2:* = _loc_1.width;
            var _loc_3:* = _loc_1.height;
            var _loc_4:* = borderMetrics;
            _loc_2 = _loc_2 + (_loc_4.left + _loc_4.right);
            var _loc_5:Number = 5;
            _loc_2 = _loc_2 + _loc_5 * 2;
            measuredMinWidth = Math.max(_loc_2, measuredMinWidth);
            measuredWidth = Math.max(_loc_2, measuredWidth);
            if (maximizable)
            {
                measuredWidth = measuredWidth + (maximizeButton.getExplicitOrMeasuredWidth() + 6);
                measuredMinWidth = measuredMinWidth + (maximizeButton.getExplicitOrMeasuredWidth() + 6);
                measuredHeight = Math.max(measuredHeight, maximizeButton.getExplicitOrMeasuredHeight());
            }
            return;
        }

        private function measureHeaderText() : Rectangle
        {
            var _loc_1:Number = 20;
            var _loc_2:Number = 14;
            if (titleTextField && titleTextField.text)
            {
                titleTextField.validateNow();
                _loc_1 = titleTextField.textWidth;
                _loc_2 = titleTextField.textHeight;
            }
            if (statusTextField)
            {
                statusTextField.validateNow();
                _loc_1 = Math.max(_loc_1, statusTextField.textWidth);
                _loc_2 = Math.max(_loc_2, statusTextField.textHeight);
            }
            return new Rectangle(0, 0, Math.round(_loc_1), Math.round(_loc_2));
        }

        private function mouseDownHandler(event:MouseEvent) : void
        {
            systemManager.addEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            systemManager.addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager_mouseDownHandler(event);
            return;
        }

        private function systemManager_mouseUpHandler(event:MouseEvent) : void
        {
            systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            systemManager.removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager.removeEventListener(MouseEvent.MOUSE_DOWN, systemManager_mouseDownHandler, true);
            isHandleDragging = false;
            return;
        }

        override public function set x(param1:Number) : void
        {
            trace("Setting x to " + x);
            super.x = param1;
            return;
        }

        private function systemManager_mouseMoveHandler(event:MouseEvent) : void
        {
            if (this.parent != null)
            {
                if (isHandleDragging)
                {
                    resize(event);
                }
                else
                {
                    setResizeCursor(event);
                }
            }
            return;
        }

        private function resizeHandler(event:Event) : void
        {
            if (currentState == "maximized")
            {
                toPseudoMax();
                toMaximized();
            }
            return;
        }

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (!origDimensionsCached)
            {
                storeOrigDimensions();
                origDimensionsCached = true;
            }
            return;
        }

        private function bringToFront(event:MouseEvent) : void
        {
            if (event.currentTarget == this && parent)
            {
                parent.setChildIndex(this, parent.numChildren-1);
            }
            return;
        }

    }
}
