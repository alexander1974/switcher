package net.switcher.game.nodes
{
    import ash.core.Node;

    import net.switcher.game.components.Display;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceMatch;

    public class ExplodingNode extends Node
    {
        public var pieceMatch:PieceMatch;
        public var position:GridPosition;
        public var display:Display;
    }
}
