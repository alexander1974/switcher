package net.switcher.game.enum
{
    public class GridDirection
    {
        public static const GridDirectionUp:GridDirection = new GridDirection("Up");
        public static const GridDirectionDown:GridDirection = new GridDirection("Down");
        public static const GridDirectionLeft:GridDirection = new GridDirection("Left");
        public static const GridDirectionRight:GridDirection = new GridDirection("Right");

        public function GridDirection(value:String)
        {
            _value = value;
        }

        private var _value:String;

        public function get value():String
        {
            return _value;
        }

        public function toString():String
        {
            return "GridDirection" + value;
        }
    }
}
