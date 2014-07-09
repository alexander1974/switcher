package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import flash.display.DisplayObjectContainer;

    import net.switcher.game.EntityCreator;
    import net.switcher.game.components.Grid;
    import net.switcher.game.nodes.ExplodingNode;

    public class ExplodePiecesSystem extends ListIteratingSystem
    {
        public function ExplodePiecesSystem(grid:Grid, container:DisplayObjectContainer, creator:EntityCreator)
        {
            super(ExplodingNode, updateNode);
            this.grid = grid;
            this.container = container;
            this.creator = creator;
        }

        private var grid:Grid;
        private var container:DisplayObjectContainer;
        private var creator:EntityCreator;

        private function updateNode(node:ExplodingNode, time:Number):void
        {
            var piece:Entity = node.entity;

            grid.removePieceAtPosition(node.position);
            container.removeChild(node.display.displayObject);
            creator.destroyEntity(piece);
        }
    }
}
