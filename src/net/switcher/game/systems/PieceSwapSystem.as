package net.switcher.game.systems
{
    import ash.core.Entity;
    import ash.tools.ListIteratingSystem;

    import flash.geom.Point;

    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceSwap;
    import net.switcher.game.components.WillMove;
    import net.switcher.game.helpers.BoardHelper;
    import net.switcher.game.nodes.PieceSwapNode;

    public class PieceSwapSystem extends ListIteratingSystem
    {
        public function PieceSwapSystem(grid:Grid)
        {
            super(PieceSwapNode, updateNode);
            this.grid = grid;
        }

        private var grid:Grid;

        private function updateNode(node:PieceSwapNode, time:Number):void
        {
            var startPosition:GridPosition = node.position;
            var endPosition:GridPosition = startPosition.positionPlusDirection(node.pieceSwap.direction);

            var piece1:Entity = grid.removePieceAtPosition(startPosition);
            var piece2:Entity = grid.removePieceAtPosition(endPosition);

            var point1:Point = BoardHelper.gridPositionToPoint(startPosition);
            var point2:Point = BoardHelper.gridPositionToPoint(endPosition);

            piece1.remove(PieceSwap);
            piece1.add(new WillMove(point2));
            piece1.remove(GridPosition);
            piece1.add(endPosition);

            piece2.add(new WillMove(point1));
            piece2.remove(GridPosition);
            piece2.add(startPosition);

            grid.setPieceAtPosition(piece1, endPosition);
            grid.setPieceAtPosition(piece2, startPosition);
        }
    }
}
