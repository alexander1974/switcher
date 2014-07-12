package net.switcher.game.nodes
{
    import ash.core.Node;

    import net.switcher.game.components.Display;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PossibleMove;

    public class PossibleMoveNode extends Node
    {
        public var gridPosition:GridPosition;
        public var possibleMove:PossibleMove;
        public var display:Display;
    }
}
