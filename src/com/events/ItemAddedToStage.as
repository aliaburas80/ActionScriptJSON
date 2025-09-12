package com.events {
    import flash.events.Event;

    public class ItemAddedToStage extends Event {
        public static const ITEM_ADDES_TO_STAGE:String = 'ItemAddedToStage'

        public function ItemAddedToStage(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        override public function clone():Event {
            return new ItemAddedToStage(type, bubbles, cancelable);
        }

        override public function toString():String {
            return formatToString("ItemAddedToStage", "type", "bubbles", "cancelable");
        }
    }
}
