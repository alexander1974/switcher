package net.switcher.game.enum
{
    public class PieceType
    {
        public static const PieceTypeBlue:PieceType = new PieceType("Blue");
        public static const PieceTypeGreen:PieceType = new PieceType("Green");
        public static const PieceTypePurple:PieceType = new PieceType("Purple");
        public static const PieceTypeRed:PieceType = new PieceType("Red");
        public static const PieceTypeYellow:PieceType = new PieceType("Yellow");

        public static const AllTypes:Vector.<PieceType> = new <PieceType>[
            PieceTypeBlue,
            PieceTypeGreen,
            PieceTypePurple,
            PieceTypeRed,
            PieceTypeYellow
        ];

        public function PieceType(value:String)
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
            return "PieceType" + value;
        }
    }
}
