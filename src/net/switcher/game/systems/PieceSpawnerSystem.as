package net.switcher.game.systems
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
    import net.switcher.game.helpers.BoardHelper;

    public class PieceSpawnerSystem extends BaseGridOperatingSystem
    {
        public function PieceSpawnerSystem(entityCreator:EntityCreator, container:DisplayObjectContainer)
        {
            super();
            this.entityCreator = entityCreator;
            this.container = container;
        }

        private var entityCreator:EntityCreator;
        private var container:DisplayObjectContainer;

        override public function update(time:Number):void
        {
            var grid:Grid = nodes.head.grid;
            var piece:Entity;

            for (var col:int = 0; col < Constants.BOARD_WIDTH; col++)
            {
                piece = grid.cells[Constants.BOARD_HEIGHT - 1][col];
                if (!piece)
                {
                    piece = entityCreator.createRandomPiece();

                    var position:GridPosition = new GridPosition(col, Constants.BOARD_HEIGHT - 1);
                    piece.add(position);
                    grid.setPieceAtPosition(piece, position);

                    var displayObject:DisplayObject = (piece.get(Display) as Display).displayObject;
                    var point:Point = BoardHelper.gridPositionToPoint(position);

                    displayObject.x = point.x;
                    displayObject.y = point.y;

                    container.addChild(displayObject);
                }

            }
        }
    }
}
