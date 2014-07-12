package net.switcher.game.components
{
    public class PieceSwap
    {
        public var destination:GridPosition;
        public var isSwapingBack:Boolean;

        public function PieceSwap(destination:GridPosition, isSwappingBack:Boolean = false)
        {
            this.destination = destination;
            this.isSwapingBack = isSwappingBack;
        }
    }
}
