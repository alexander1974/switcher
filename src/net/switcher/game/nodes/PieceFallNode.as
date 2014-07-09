package net.switcher.game.nodes
{
    import ash.core.Node;

    import net.switcher.game.components.Display;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceFall;

    public class PieceFallNode extends Node
    {
        public var pieceFall:PieceFall;
        public var gridPosition:GridPosition;
        public var display:Display;
    }
}
