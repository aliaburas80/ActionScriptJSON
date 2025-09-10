package com.events {
    import flash.events.Event;
    import flash.display.Bitmap;

    public class LoadedImageFile extends Event {
        public static const IMAGE_FILE:String = 'Image file bitmap';
        public var imageFile:Bitmap;

        public function LoadedImageFile(type:String, _imageFile:Bitmap, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            imageFile = _imageFile
        }

        override public function clone():Event {
            return new LoadedImageFile(type, imageFile, bubbles, cancelable);
        }

        override public function toString():String {
            return formatToString("LoadedImageFile", "type", "imageFile", "bubbles", "cancelable");
        }
    }
}
