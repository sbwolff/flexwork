package com.googlecode.flexwork.core.components.toolWindowClasses
{ 
import flash.display.DisplayObject;   
       
    import mx.containers.DividedBox;   
    import mx.containers.DividerState;   
    import mx.containers.dividedBoxClasses.BoxDivider;   
    import mx.core.mx_internal;   
    import mx.skins.ProgrammaticSkin;   
       
    use namespace mx_internal;   
	public class ToolWindowDivider extends BoxDivider   
    {   
                
        private var divider:DisplayObject = null;   
           
        private var knob:DisplayObject = null;   
           
        public function ToolWindowDivider()   
        {   
            super();   
        }   
      
        override protected function updateDisplayList(unscaledWidth:Number,    
                unscaledHeight:Number):void  
        {   
            if (isNaN(width) || isNaN(height))   
                return;   
            if (!parent)   
                return;   
            graphics.clear();   
            var color:Number = 0;   
            var alpha:Number = 1.0;   
            var thickness:Number = getStyle("dividerThickness");   
            var vertical:Boolean = DividedBox(owner).isVertical();   
            var gap:Number = vertical ?    
                    DividedBox(owner).getStyle("verticalGap") :    
                    DividedBox(owner).getStyle("horizontalGap");   
            var dividerSkinClass:Class = null;   
            //var knobClass:Class = null;   
            if (state != DividerState.DOWN)   
            {   
                dividerSkinClass = getStyle("dividerSkin");  
                if (!dividerSkinClass )   
                {   
                    super.updateDisplayList(unscaledWidth, unscaledHeight);   
                    return;   
                }   
                if (!divider)   
                {   
                    if (dividerSkinClass)   
                        divider = new dividerSkinClass();   
                    if (divider)   
                        addChildAt(divider, 0);   
                }   
                else  
                {   
                    if (dividerSkinClass && !(divider is dividerSkinClass))   
                    {   
                        removeChild(divider);   
                        divider = new dividerSkinClass();   
                        if (divider)   
                            addChildAt(divider, 0);   
                    }   
                }   
                if (divider)   
                {   
                    divider.width = unscaledWidth;   
                    divider.height = unscaledHeight;   
                    if (divider is ProgrammaticSkin)   
                    {   
                        (divider as ProgrammaticSkin).invalidateSize();   
                        (divider as ProgrammaticSkin).invalidateDisplayList();   
                    }   
                }
                return;   
            }   
            color = getStyle("dividerColor");   
            alpha = getStyle("dividerAlpha");   
            graphics.beginFill(color, alpha);   
            if (vertical)   
            {   
                var visibleHeight:Number = thickness;   
                if (visibleHeight > gap)   
                    visibleHeight = gap;   
                var y:Number = (height - visibleHeight) / 2;   
                graphics.drawRect(0, y, width, visibleHeight);   
            }   
            else  
            {   
                var visibleWidth:Number = thickness;   
                if (visibleWidth > gap)   
                    visibleWidth = gap;   
                var x:Number = (width - visibleWidth) / 2;   
                graphics.drawRect(x, 0, visibleWidth, height);   
            }   
            graphics.endFill();   
        }   
           
    }   
       
}  