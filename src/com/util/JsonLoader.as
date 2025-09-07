package com.util {

    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLLoaderDataFormat;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class JsonLoader extends EventDispatcher {
        private var _loader:URLLoader;
        private var _onOk:Function;
        private var _onErr:Function;

        public function JsonLoader(onSuccess:Function, onError:Function = null) {
            _onOk = onSuccess;
            _onErr = onError;
        }

        public function load(url:String, bust:Boolean = true):void {
            cleanup();
            if (bust)
                url = appendBust(url);
            _loader = new URLLoader();
            _loader.dataFormat = URLLoaderDataFormat.TEXT;
            _loader.addEventListener(Event.COMPLETE, onComplete);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
            try {
                _loader.load(new URLRequest(url));
            } catch (e:Error) {
                fail("LOAD_THROW", e.message);
            }
        }

        private function onComplete(e:Event):void {
            try {
                var text:String = String(_loader.data);
                var obj:Object = JSON.parse(text);
                ok(obj);
            } catch (e:Error) {
                fail("PARSE_ERROR", e.message);
            }
        }

        private function onIOError(e:IOErrorEvent):void {
            fail("IO_ERROR", e.text);
        }

        private function onSecError(e:SecurityErrorEvent):void {
            fail("SECURITY_ERROR", e.text);
        }

        private function ok(data:Object):void {
            cleanup();
            if (_onOk != null)
                _onOk(data);
        }

        private function fail(code:String, msg:String):void {
            cleanup();
            if (_onErr != null)
                _onErr(code, msg);
        }

        private function cleanup():void {
            if (_loader) {
                _loader.removeEventListener(Event.COMPLETE, onComplete);
                _loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
                _loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
                _loader = null;
            }
        }

        private static function appendBust(url:String):String {
            var sep:String = (url.indexOf("?") == -1) ? "?" : "&";
            return url + sep + "cb=" + new Date().time;
        }
    }
}
