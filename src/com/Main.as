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
    import com.factory.ShapeFactory;
    import com.util.ENUM;
    import com.util.Console;
    import com.events.ItemAddedToStage;
    import com.util.Random;
    import flash.display.Stage;
    import flash.utils.setTimeout;
    import flash.geom.Point;
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;
    import com.greensock.easing.Quad;

    public class Main extends Sprite {

        private var loader:URLoader
        private var progressBar:ShapeFactory;
        private var randomLine:ShapeFactory;
        private var console:Console = new Console('MAIN');
        private var _stage:Stage;
        private var stageProp:Object;
        private var startPoint:Point;
        private var state:Object = {t: 0}; // progress 0..1

        private const BMP_WIDTH:int = 450;
        private const BMP_HEIGHT:int = 400;

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
            _stage = stage;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.focus = this;
            stageProp = {width: stage.stageWidth,
                    height: stage.stageHeight}
            createProgressBar();
            loadSimpleTxt();
            loadSimpleImage();
            addEventListener(ItemAddedToStage.ITEM_ADDES_TO_STAGE, drawLines)
        }

        private function createProgressBar(width:int = 0):void {
            progressBar = new ShapeFactory(ENUM.ROUND_RECT, {color: 0xFF0000, x: 0, y: 0, width: stage.stageWidth, height: 10, ellipseWidth: 15, ellipseHeight: 15})
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
            bitmap.alpha = 0;
            bitmap.width = BMP_WIDTH;
            bitmap.height = BMP_HEIGHT;
            bitmap.x = stage.stageWidth / 2 - bitmap.width / 2;
            bitmap.y = stage.stageHeight / 2 - bitmap.height / 2;
            this.parent.addChildAt(bitmap,1);
            TweenLite.to(bitmap, 1, {alpha: 1, ease: Back.easeOut, onComplete: function():void {
                dispatchEvent(new ItemAddedToStage(ItemAddedToStage.ITEM_ADDES_TO_STAGE))
            }})
        }

        private function updateProgress(e:ProgressValueEvent):void {
            // createProgressBar(e.value)
            progressBar.scaleX = e.value / 100;
        }

        private function drawLines(e:ItemAddedToStage):void {
            var xyTo:Point = Random.RandomePosition(stageProp.width, stageProp.height);
            if (!startPoint) {
                startPoint = Random.RandomePosition(stageProp.width, stageProp.height)
            }
            // randomLine = new ShapeFactory(ENUM.LINE, {color: Random.RandomeColor(), x: startPoint.x,
            //         y: startPoint.y,
            //         toX: xyTo.x,
            //         toY: xyTo.y});
            // this.parent.addChild(randomLine);
            // setTimeout(function timeOUt():void {
            //     startPoint = xyTo;
            //     dispatchEvent(new ItemAddedToStage(ItemAddedToStage.ITEM_ADDES_TO_STAGE))
            // }, 100);

            state.t = 0;
            TweenLite.to(state, 0.5, {t: 1, ease: Quad.easeOut,
                    onUpdate: function():void {
                        randomLine = new ShapeFactory(ENUM.LINE, {color: Random.RandomeColor(), x: startPoint.x,
                                y: startPoint.y,
                                toX: xyTo.x,
                                toY: xyTo.y,
                                thikness: Math.round(Math.random() * 3) + 1});
                        stage.addChildAt(randomLine,0);
                    },
                    onComplete: function():void {
                        startPoint = xyTo;
                        dispatchEvent(new ItemAddedToStage(ItemAddedToStage.ITEM_ADDES_TO_STAGE))
                    }});

        }

    }
}
