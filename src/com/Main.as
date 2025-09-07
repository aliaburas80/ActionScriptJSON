package com {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.text.TextField;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import com.util.JsonLoader;

    public class Main extends Sprite {

        private var tf:TextField;
        private var box:Shape;
        private var localUrl:String;
        private var onlineUrl:String; // set this to your hosted JSON URL

        public function Main():void {
            super();
            if (stage)
                onAddedToStage();
            else
                addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)

            log('ALI')
        }

        private function onAddedToStage(e:Event = null):void {
            if (e)
                removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.focus = this;
            //https://microsoftedge.github.io/Demos/json-dummy-data/

            // localUrl = rootPath() + "assets/config.json";

            localUrl = "assets/config.json";
            onlineUrl = "https://microsoftedge.github.io/Demos/json-dummy-data/64KB.json"; // TODO: replace with your URL

            buildUI();
            loadLocalThenOnline();
            stage.addEventListener(MouseEvent.CLICK, function(_:MouseEvent):void {
                loadOnlineThenFallback();
            });
        }

        private function buildUI():void {
            graphics.beginFill(0x14161A);
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
            tf = new TextField();
            tf.defaultTextFormat = new TextFormat("_sans", 14, 0xEAEAEA);
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.selectable = false;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.x = 12;
            tf.y = 12;
            addChild(tf);
            box = new Shape();
            addChild(box);
        }

        private function loadLocalThenOnline():void {
            log("Loading LOCAL: " + localUrl);
            new JsonLoader(onLocalOk, onLocalErr).load(localUrl);
        }

        private function onLocalOk(data:Object):void {
            trace(data)
            applyConfig(data, "LOCAL");
            // then try online to override values
            loadOnline(false);
        }

        private function onLocalErr(code:String, msg:String):void {
            log("LOCAL error [" + code + "]: " + msg);
            // still try online
            loadOnline(false);
        }

        // Strategy 2: explicit online attempt with fallback
        private function loadOnlineThenFallback():void {
            log("Click: try ONLINE first");
            loadOnline(true);
        }

        private function loadOnline(fallbackToLocal:Boolean):void {
            log("Loading ONLINE: " + onlineUrl);
            new JsonLoader(function(d:Object):void {
                applyConfig(d, "ONLINE");
            }, function(code:String, msg:String):void {
                log("ONLINE error [" + code + "]: " + msg);
                if (fallbackToLocal) {
                    log("Fallback → LOCAL");
                    new JsonLoader(onLocalOk, onLocalErr).load(localUrl);
                }
            }).load(onlineUrl);
        }

        private function applyConfig(cfg:Object, source:String):void {
            var title:String = (cfg && cfg.title) ? String(cfg.title) : "(no title)";
            var ver:String = (cfg && cfg.version) ? String(cfg.version) : "?";
            var msg:String = (cfg && cfg.message) ? String(cfg.message) : "";

            if (cfg && cfg.box) {
                var w:Number = Number(cfg.box.w || 100);
                var h:Number = Number(cfg.box.h || 100);
                var c:uint = uint(cfg.box.color || 0x39A0FF);
                box.graphics.clear();
                box.graphics.beginFill(c);
                box.graphics.drawRect(0, 0, w, h);
                box.graphics.endFill();
                box.x = 32;
                box.y = 80;
            }

            tf.text = "Source: " + source + "\n" + "Title : " + title + "\n" + "Version: " + ver + "\n" + (msg ? ("Msg : " + msg + "\n") : "") + "Click stage → try ONLINE with fallback to LOCAL.";
        }


// Root URL of the SWF (handles file vs http)
        private function rootPath():String {
            var base:String = loaderInfo.url; // e.g., file:///…/day1.swf or https://…/day1.swf
            var i:int = base.lastIndexOf("/");
            return (i >= 0) ? base.substring(0, i + 1) : "";
        }

        private function log(s:String):void {
             trace(s);
            // if (tf) {
            //     tf.appendText((tf.length ? "\n" : "") + s);
            //     tf.scrollV = tf.maxScrollV;
            // } else {
            //     trace(s);
            // }
        }
    }
}
