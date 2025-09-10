package com.util {

    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.LoaderInfo;
    import flash.display.Loader;
    import com.greensock.events.LoaderEvent;
    import flash.events.ProgressEvent;
    import flash.events.EventDispatcher;
    import com.events.LoadedImageFile;
    import com.events.ProgressValueEvent;

    public class URLoader extends EventDispatcher {
        private var _URL:String = '';
        private var _format:String = URLLoaderDataFormat.TEXT;
        private var loaderUI:LoaderUI;

        public function URLoader(url:String, type:String) {
            _URL = url;
        }

        private function set format(value:String):void {
            _format = value;
        }

        private function get format():String {
            return _format;
        }

        private function set URL(url:String):void {
            _URL = url
        }

        private function get URL():String {
            return _URL
        }

        public function loadAssest():void {
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.dataFormat = format;
            urlLoader.load(new URLRequest(URL));
            urlLoader.removeEventListener(Event.COMPLETE, completeLoadingImage);
            urlLoader.addEventListener(Event.COMPLETE, completeLoadingData);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHadler);

        }

        public function loadImg():void {
            var urlLoader:Loader = new Loader();
            urlLoader.load(new URLRequest(URL));
            // urlLoader.removeEventListener(Event.COMPLETE, completeLoadingData);
            urlLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeLoadingImage);
            urlLoader.contentLoaderInfo.addEventListener(LoaderEvent.PROGRESS, progressHandler);
            urlLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHadler);
        }

        private function progressHandler(e:ProgressEvent):void {
            var persentage:int = Math.round((e.bytesLoaded / e.bytesTotal) * 100);
            dispatchEvent(new ProgressValueEvent(ProgressValueEvent.PROGRESS, persentage))
        }

        private function completeLoadingImage(e:Event):void {
            var li:LoaderInfo = e.currentTarget as LoaderInfo;
            var bmp:Bitmap = li.content as Bitmap; // smoothing if bitmap
            if (bmp)
                bmp.smoothing = true;
            dispatchEvent(new LoadedImageFile(LoadedImageFile.IMAGE_FILE, bmp))
        }

        private function completeLoadingData(e:Event):void {
            trace(e.target.data)
        }

        private static function IOErrorHadler(e:IOErrorEvent):void {
            trace('Error')
        }

        private static function completeLoadingDatbmpa(e:Event):void {
            // trace(e.target.data)
        }
    }
}
