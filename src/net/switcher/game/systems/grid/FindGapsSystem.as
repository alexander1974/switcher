package net.switcher.game.systems.grid
{
    import ash.core.Engine;
    import ash.core.Entity;

    import net.switcher.game.Constants;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.Moving;
    import net.switcher.game.components.WillMove;
    import net.switcher.game.enum.GridDirection;
    import net.switcher.game.helpers.BoardHelper;
    import net.switcher.game.nodes.MovingNode;
    import net.switcher.game.nodes.WillMoveNode;

    public class FindGapsSystem extends BaseGridOperatingSystem
    {
        public function FindGapsSystem(engine:Engine)
        {
            super();
            this.engine = engine;
        }

        private var engine:Engine;

        override public function update(time:Number):void
        {
            if (engine.getNodeList(MovingNode).empty && engine.getNodeList(WillMoveNode).empty)
            {
                var grid:Grid = nodes.head.grid;
                var piece:Entity;
                var position:GridPosition;
                var destinationPosition:GridPosition;

                for (var rowIndex:int = 0; rowIndex < Constants.BOARD_HEIGHT - 1; rowIndex++)
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
                                if (piece && !piece.has(WillMove) && !piece.has(Moving))
                                {
                                    destinationPosition = position.positionPlusDirection(GridDirection.GridDirectionDown);
                                    grid.removePieceAtPosition(position);
                                    grid.setPieceAtPosition(piece, destinationPosition);
                                    piece.add(new WillMove(BoardHelper.gridPositionToPoint(destinationPosition)));
                                    piece.remove(GridPosition);
                                    piece.add(destinationPosition);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
