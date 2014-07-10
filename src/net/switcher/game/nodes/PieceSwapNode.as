package net.switcher.game.nodes
{
    import ash.core.Node;

    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceSwap;

    public class PieceSwapNode extends Node
    {
        public var pieceSwap:PieceSwap;
        public var position:GridPosition;
    }
}
