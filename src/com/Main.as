package com {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import com.util.URLoader;
    import flash.net.URLLoaderDataFormat;

    public class Main extends Sprite {

        private var loader:URLoader

        public function Main():void {
            super();
            if (stage)
                onAddedToStage();
            else
                addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
        }

        private function onAddedToStage(e:Event = null):void {
            if (e)
                removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.focus = this;
            loadSimpleTxt();
            loadSimpleImage();
        }

        private function loadSimpleImage():void {
            loader = new URLoader('assets/1.png', URLLoaderDataFormat.BINARY);
            loader.loadImg();
            addChild(loader)
        }

        private function loadSimpleTxt():void {
            loader = new URLoader('assets/message.txt', URLLoaderDataFormat.TEXT);
            // loader.loadAssest();
        }

    }
}
