package net.switcher.game.systems.grid
{
    import ash.core.Entity;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;

    import net.switcher.game.Constants;
    import net.switcher.game.EntityCreator;
    import net.switcher.game.components.Display;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.Moving;
    import net.switcher.game.components.WillMove;
    import net.switcher.game.enum.GridDirection;
    import net.switcher.game.helpers.GridHelper;

    public class PieceSpawnerSystem extends BaseGridOperatingSystem
    {
        private var entityCreator:EntityCreator;
        private var container:DisplayObjectContainer;

        public function PieceSpawnerSystem(entityCreator:EntityCreator, container:DisplayObjectContainer)
        {
            super();
            this.entityCreator = entityCreator;
            this.container = container;
        }

        override public function update(time:Number):void
        {
            var grid:Grid = nodes.head.grid;
            var piece:Entity;
            var pieceUnder:Entity;
            var gridPosition:GridPosition;

            for (var col:int = 0; col < Constants.BOARD_WIDTH; col++)
            {
                gridPosition = new GridPosition(col, Constants.BOARD_HEIGHT - 1);
                piece = grid.getPieceAtPosition(gridPosition);
                pieceUnder = grid.getPieceAtPosition(gridPosition.positionPlusDirection(GridDirection.GridDirectionDown));

                if (!piece && (!pieceUnder || !(pieceUnder.has(Moving) || pieceUnder.has(WillMove))))
                {
                    piece = entityCreator.createRandomPiece();

                    piece.add(gridPosition);
                    grid.setPieceAtPosition(piece, gridPosition);

                    var displayObject:DisplayObject = (piece.get(Display) as Display).displayObject;
                    var point:Point = GridHelper.gridPositionToPoint(gridPosition);

                    displayObject.x = point.x;
                    displayObject.y = point.y;

                    container.addChild(displayObject);
                }

            }
        }
    }
}
