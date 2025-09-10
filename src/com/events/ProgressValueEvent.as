package com.events {
    import flash.events.Event;

    public class ProgressValueEvent extends Event {

        public static const PROGRESS:String = "Progress updated"
        public var value:int = 0;

        public function ProgressValueEvent(type:String, value:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.value = value;
        }

        override public function clone():Event {
            return new ProgressValueEvent(type, value, bubbles, cancelable);
        }

        override public function toString():String {
            return formatToString("ProgressValueEvent", "type", "value", "bubbles", "cancelable");
        }
    }
}
