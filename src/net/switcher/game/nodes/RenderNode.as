package net.switcher.game.nodes
{
    import ash.core.Node;

    import net.switcher.game.components.Display;
    import net.switcher.game.components.GridPosition;

    public class RenderNode extends Node
    {
        public var position:GridPosition;
        public var display:Display;
    }
}
