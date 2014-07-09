/**
 * Created by Alexander on 7/9/2014.
 */
package net.switcher.game.systems
{
    import ash.core.Entity;

    import net.switcher.game.Constants;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.Moving;
    import net.switcher.game.components.PieceFall;
    import net.switcher.game.enum.GridDirection;

    public class FindGapsSystem extends BaseGridOperatingSystem
    {
        override public function update(time:Number):void
        {
            var grid:Grid = nodes.head.grid;
            var piece:Entity;
            var position:GridPosition;

            for (var rowIndex:int = 0; rowIndex < Constants.BOARD_HEIGHT; rowIndex++)
            {
                for (var colIndex:int = 0; colIndex < Constants.BOARD_WIDTH; colIndex++)
                {
                    position = new GridPosition(colIndex, rowIndex);
                    piece = grid.getPieceAtPosition(position);
                    if (!piece)
                    {
                        while (position.y < Constants.BOARD_HEIGHT - 1)
                        {
                            position = position.positionPlusDirection(GridDirection.GridDirectionUp);
                            piece = grid.getPieceAtPosition(position);
                            if (piece && !piece.has(PieceFall) && !piece.has(Moving))
                            {
                                piece.add(new PieceFall());
                            }
                        }
                    }
                }
            }
        }
    }
}
