package net.switcher.game.helpers
{
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import net.switcher.game.Constants;
    import net.switcher.game.components.GridPosition;

    public class GridHelper
    {
        public static function gridPositionToPoint(pos:GridPosition):Point
        {
            return new Point(pos.x * Constants.PIECE_SIZE, Constants.PIECE_SIZE * (Constants.BOARD_HEIGHT - 1) - pos.y * Constants.PIECE_SIZE);
        }

        public static function mouseEventToGridPosition(event:MouseEvent):GridPosition
        {
            return new GridPosition(int((event.localX + Constants.PIECE_SIZE / 2) / Constants.PIECE_SIZE),
                    int((((Constants.BOARD_HEIGHT) * Constants.PIECE_SIZE) - (event.localY + Constants.PIECE_SIZE / 2)) / Constants.PIECE_SIZE));
        }


    }
}
