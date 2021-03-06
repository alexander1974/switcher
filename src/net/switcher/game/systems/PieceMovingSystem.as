package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import com.greensock.TweenMax;
    import com.greensock.data.TweenMaxVars;

    import flash.display.DisplayObject;
    import flash.geom.Point;

    import net.switcher.game.Constants;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.Moving;
    import net.switcher.game.components.PieceSwap;
    import net.switcher.game.components.PieceSwapBack;
    import net.switcher.game.components.WillMove;
    import net.switcher.game.nodes.WillMoveNode;

    public class PieceMovingSystem extends ListIteratingSystem
    {
        private var grid:Grid;

        public function PieceMovingSystem(grid:Grid)
        {
            super(WillMoveNode, updateNode);
            this.grid = grid;
        }

        public function updateNode(node:WillMoveNode, time:Number):void
        {
            var destinationPoint:Point = node.willMove.destinationPoint;
            var piece:Entity = node.entity;
            var pieceSprite:DisplayObject = node.display.displayObject;

            piece.remove(WillMove);
            piece.add(new Moving());
            var vars:TweenMaxVars = new TweenMaxVars()
                    .x(destinationPoint.x)
                    .y(destinationPoint.y)
                    .onComplete(function ():void
                    {
                        piece.remove(Moving);
                        if (piece.has(PieceSwapBack))
                        {
                            var swapBack:PieceSwapBack = piece.remove(PieceSwapBack);
                            piece.add(new PieceSwap(swapBack.destination, true));
                        }
                    });

            var tween:TweenMax = new TweenMax(pieceSprite, Constants.MOVE_DURATION, vars);
        }
    }
}
