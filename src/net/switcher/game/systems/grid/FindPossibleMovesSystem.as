package net.switcher.game.systems.grid
{
    import ash.core.Engine;
    import ash.core.Entity;

    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PossibleMove;
    import net.switcher.game.enum.GridDirection;
    import net.switcher.game.nodes.MovingNode;
    import net.switcher.game.nodes.PulsingNode;
    import net.switcher.game.nodes.WillMoveNode;

    public class FindPossibleMovesSystem extends BaseGridOperatingSystem
    {
        public function FindPossibleMovesSystem(engine:Engine)
        {
            super();
            this.engine = engine;
        }

        private var engine:Engine;
        private var grid:Grid;

        override public function update(time:Number):void
        {
            grid = nodes.head.grid;

            if (engine.getNodeList(MovingNode).empty && engine.getNodeList(WillMoveNode).empty && engine.getNodeList(PulsingNode).empty)
            {
                for each (var row:Vector.<Entity> in grid.cells)
                {
                    for each(var piece:Entity in row)
                    {
                        if (piece.has(PossibleMove))
                        {
                            piece.remove(PossibleMove);
                        }

                        var possibleMove:PossibleMove = new PossibleMove();
                        possibleMove.canSwapRight = canSwapPieceInDirection(piece, GridDirection.GridDirectionRight);
                        possibleMove.canSwapUp = canSwapPieceInDirection(piece, GridDirection.GridDirectionUp);
                        if (possibleMove.canSwapRight || possibleMove.canSwapUp)
                        {
                            piece.add(possibleMove);
                        }
                    }
                }
            }
        }

        private function canSwapPieceInDirection(piece:Entity, dir:GridDirection):Boolean
        {
            var pos:GridPosition = piece.get(GridPosition);
            var otherPiece:Entity = grid.getPieceAtPosition(pos.positionPlusDirection(dir));
            return grid.canSwapPieceWithPiece(piece, otherPiece);
        }
    }
}
