/**
 * Created by Alexander on 7/8/2014.
 */
package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import com.greensock.TweenMax;
    import com.greensock.data.TweenMaxVars;

    import flash.display.DisplayObject;
    import flash.geom.Point;

    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.Moving;
    import net.switcher.game.components.PieceFall;
    import net.switcher.game.enum.GridDirection;
    import net.switcher.game.helpers.BoardHelper;
    import net.switcher.game.nodes.PieceFallNode;

    public class PieceFallSystem extends ListIteratingSystem
    {
        public function PieceFallSystem(grid:Grid)
        {
            super(PieceFallNode, updateNode);
            this.grid = grid
        }

        protected var grid:Grid;

        private function updateNode(node:PieceFallNode, time:Number):void
        {
            var piece:Entity = node.entity;
            piece.remove(PieceFall);
            piece.add(new Moving());
            var pieceSprite:DisplayObject = node.display.displayObject;
            var startPosition:GridPosition = node.gridPosition;
            var endPosition:GridPosition = startPosition.positionPlusDirection(GridDirection.GridDirectionDown);
            var endPoint:Point = BoardHelper.gridPositionToPoint(endPosition);

            piece.remove(GridPosition);
            piece.add(endPosition);

            var vars:TweenMaxVars = new TweenMaxVars()
                    .y(endPoint.y)
                    .onComplete(function ():void
                    {
                        grid.removePieceAtPosition(startPosition);
                        grid.setPieceAtPosition(piece, endPosition);
                        piece.remove(Moving);
                    });

            var tween:TweenMax = new TweenMax(pieceSprite, 0.08, vars)
        }
    }
}
