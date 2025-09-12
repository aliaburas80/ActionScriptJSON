package com.factory {
    import flash.display.Sprite;
    import com.util.ENUM;
    import com.util.Console;

    public class ShapeFactory extends Sprite {

        private var _shapeType:String = '';
        private var _properties:Object = new Object();
        private var console:Console = new Console('ShapeFactory');

        public function ShapeFactory(type:String, prop:Object) {
            super();
            shapeType = type;
            properties = prop;
            addChild(drawShape());
        }

        private function set properties(prop:Object):void {
            _properties = prop
        }

        private function get properties():Object {
            return _properties
        }

        private function set shapeType(type:String):void {
            _shapeType = type
        }

        private function get shapeType():String {
            return _shapeType
        }

        private function drawShape():Sprite {
            var shape:Sprite = new Sprite();
            shape.graphics.clear();
            shape.graphics.beginFill(properties.color);
            switch (shapeType) {
                case ENUM.RECT:
                    shape.graphics.drawRect(properties.x, properties.y, properties.width, properties.height);
                    break;
                case ENUM.CIRCLE:
                    shape.graphics.drawCircle(properties.x, properties.y, properties.radius);
                    break;
                case ENUM.LINE:
                    shape.graphics.moveTo(properties.x, properties.y);
                    shape.graphics.lineTo(properties.toX, properties.toY);
                    break;
                case ENUM.ELLIPSE:
                    shape.graphics.drawEllipse(properties.x, properties.y, properties.width, properties.height)
                    break;
                case ENUM.ROUND_RECT:
                    shape.graphics.drawRoundRect(properties.x, properties.y, properties.width, properties.height, properties.ellipseWidth, properties.ellipsHeight)
                    break;
                case ENUM.ROUND_RECT_COMPLEX:
                    shape.graphics.drawRoundRectComplex(properties.x, properties.y, properties.width, properties.height, properties.topLeftR, properties.topRightR, properties.bottomLeftR, properties.bottomRightR);
                    break;
                default:
                    console.log('Unsupported shape!')
                    break;
            }
            graphics.endFill();
            return shape;
        }


    }
}
