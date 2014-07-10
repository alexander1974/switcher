package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import net.switcher.game.EntityCreator;
    import net.switcher.game.components.Grid;
    import net.switcher.game.display.PieceSprite;
    import net.switcher.game.nodes.ExplodingNode;

    public class PiecesExplodeSystem extends ListIteratingSystem
    {
        public function PiecesExplodeSystem(grid:Grid, creator:EntityCreator)
        {
            super(ExplodingNode, updateNode);
            this.grid = grid;
            this.creator = creator;
        }

        private var grid:Grid;
        private var creator:EntityCreator;

        private function updateNode(node:ExplodingNode, time:Number):void
        {
            var piece:Entity = node.entity;

            grid.removePieceAtPosition(node.position);
            (node.display.displayObject as PieceSprite).removeFromParent();
            creator.destroyEntity(piece);
        }
    }
}
