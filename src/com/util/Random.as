package com.util {

    import flash.geom.Point;
    import flash.display.Stage;

    public class Random {
        public function Random() {

        }

        public static function RandomePosition(BOX_W:uint, BOX_H:uint, inset:Number = 0):Point {
            var maxX:Number = Math.max(0, BOX_W - inset * 2);
            var maxY:Number = Math.max(0, BOX_H - inset * 2);
            var x:Number = inset + Math.floor(Math.random() * (maxX + 1));
            var y:Number = inset + Math.floor(Math.random() * (maxY + 1));
            return new Point(x, y);
        }


        public static function RandomeColor():uint {
            return uint(Math.random() * 0xFFFFFF);
        }
    }
}
