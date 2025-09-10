package com {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import com.util.URLoader;
    import flash.net.URLLoaderDataFormat;
    import com.events.ProgressValueEvent;
    import com.events.LoadedImageFile;
    import flash.display.Shape;
    import flash.display.Bitmap;

    public class Main extends Sprite {

        private var loader:URLoader
        private var progressBar:Shape;

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

            createProgressBar();

            loadSimpleTxt();
            loadSimpleImage();
        }

        private function createProgressBar(width:int = 0):void {
            trace(width)
            progressBar = new Shape();
            progressBar.graphics.clear();
            progressBar.graphics.beginFill(0xFF0000);
            progressBar.graphics.drawRoundRect(0, 0, stage.stageWidth, 10, 15, 15);
            progressBar.graphics.endFill();
            progressBar.scaleX=0;
            this.parent.addChild(progressBar)
        }

        private function loadSimpleImage():void {
            loader = new URLoader('assets/1.png', URLLoaderDataFormat.BINARY);
            loader.loadImg();
            loader.addEventListener(LoadedImageFile.IMAGE_FILE, loadedImageFileHandler)
            loader.addEventListener(ProgressValueEvent.PROGRESS, updateProgress)
        }

        private function loadSimpleTxt():void {
            loader = new URLoader('assets/message.txt', URLLoaderDataFormat.TEXT);
        }

        private function loadedImageFileHandler(e:LoadedImageFile):void {
            var bitmap:Bitmap = e.imageFile;
            bitmap.alpha=0.5;
            bitmap.x=10;
            bitmap.y=10;
            bitmap.width=300;
            bitmap.height=400;
            this.parent.addChild(bitmap)
        }

        private function updateProgress(e:ProgressValueEvent):void {
            // createProgressBar(e.value)
             progressBar.scaleX = e.value/100;
        }

    }
}
