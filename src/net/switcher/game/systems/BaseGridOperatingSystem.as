package net.switcher.game.systems
{
    import ash.core.Engine;
    import ash.core.NodeList;
    import ash.core.System;

    import net.switcher.game.nodes.GridNode;

    public class BaseGridOperatingSystem extends System
    {
        protected var nodes:NodeList;

        override public function addToEngine(engine:Engine):void
        {
            nodes = engine.getNodeList(GridNode);
        }

        override public function removeFromEngine(engine:Engine):void
        {
            nodes = null;
        }
    }
}
