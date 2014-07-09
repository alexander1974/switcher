package net.switcher.game.display
{
    import flash.display.Bitmap;

    import net.switcher.game.enum.PieceType;
    import net.switcher.util.assert;

    public class SpriteFactory
    {
        [Embed(source="../../../../../assets/Blue.png")]
        public static var bluePiece:Class;

        [Embed(source="../../../../../assets/Green.png")]
        public static var greenPiece:Class;

        [Embed(source="../../../../../assets/Purple.png")]
        public static var purplePiece:Class;

        [Embed(source="../../../../../assets/Red.png")]
        public static var redPiece:Class;

        [Embed(source="../../../../../assets/Yellow.png")]
        public static var yellowPiece:Class;

        [Embed(source="../../../../../assets/BackGround.jpg")]
        public static var bgImage:Class;

        public static function getPieceSpriteForType(pieceType:PieceType):PieceSprite
        {
            var bitmap:Bitmap;

            switch (pieceType)
            {
                case PieceType.PieceTypeBlue:
                    bitmap = new bluePiece();
                    break;
                case PieceType.PieceTypeGreen:
                    bitmap = new greenPiece();
                    break;
                case PieceType.PieceTypePurple:
                    bitmap = new purplePiece();
                    break;
                case PieceType.PieceTypeRed:
                    bitmap = new redPiece();
                    break;
                case PieceType.PieceTypeYellow:
                    bitmap = new yellowPiece();
                    break;
                default:
                    assert(false, "Error: unrecognized PieceType");
            }

            return new PieceSprite(bitmap);
        }

        public static function getBackground():Bitmap
        {
            return new bgImage();
        }
    }
}
