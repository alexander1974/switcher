package net.switcher.game.components
{
    import net.switcher.game.enum.PieceType;

    public class TypeComponent
    {
        public function TypeComponent(pieceType:PieceType)
        {
            this.pieceType = pieceType;
        }

        public var pieceType:PieceType;
    }
}
