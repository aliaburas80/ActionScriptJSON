package com.util {
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.display.Stage;

    public class LoaderUI extends Sprite {

        private var loaderShap:Shape;
        private var _stage:Stage;

        public function LoaderUI(stage:Stage):void {
            super();
            _stage = stage;
        }

        public function createLoader():void {
            loaderShap.graphics.beginFill(0xFF0000);
            loaderShap.graphics.drawRoundRect(0, 0, 0, 10, 15, 15);
            loaderShap.graphics.endFill()
            _stage.addChild(loaderShap)
        }

        public function updateLoader(value:int):void {
            loaderShap.graphics.clear()
            loaderShap.graphics.beginFill(0xFF0000);
            loaderShap.graphics.drawRoundRect(0, 0, value / 100, 10, 15, 15);
            loaderShap.graphics.endFill()
        }
    }
}
