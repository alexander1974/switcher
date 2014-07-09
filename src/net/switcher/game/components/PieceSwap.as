package net.switcher.game.components
{
    import net.switcher.game.enum.GridDirection;

    public class PieceSwap
    {
        public function PieceSwap(direction:GridDirection)
        {
            this.direction = direction;
        }

        public var direction:GridDirection;
    }
}
