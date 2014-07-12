package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import com.greensock.TimelineMax;
    import com.greensock.TweenMax;
    import com.greensock.data.TweenMaxVars;

    import net.switcher.game.EntityCreator;
    import net.switcher.game.components.Exploding;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
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
            if (!piece.has(Exploding))
            {
                piece.add(new Exploding());

                var pieceSprite:PieceSprite = node.display.displayObject as PieceSprite;
                var position:GridPosition = node.position;

                var vars:TweenMaxVars = new TweenMaxVars()
                        .onComplete(function ():void
                        {
                            grid.removePieceAtPosition(position);
                            pieceSprite.removeFromParent();
                            creator.destroyEntity(piece);
                        }
                );
                new TimelineMax(vars)
                        .append(TweenMax.to(pieceSprite, 0.1, {scaleX: 1.2, scaleY: 1.2}))
                        .append(TweenMax.to(pieceSprite, 0.4, {scaleX: 0, scaleY: 0}));
            }
        }
    }
}
