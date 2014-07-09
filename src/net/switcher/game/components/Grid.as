package net.switcher.game.components
{
    import ash.core.Entity;

    import net.switcher.game.Constants;

    public class Grid
    {
        public function Grid()
        {
            _cells = new <Vector.<Entity>>[];
            var row:Vector.<Entity>;

            for (var rowIndex:int = 0; rowIndex < Constants.BOARD_HEIGHT; rowIndex++)
            {
                row = new <Entity>[];
                for (var colIndex:int = 0; colIndex < Constants.BOARD_WIDTH; colIndex++)
                {
                    row.push(null);
                }
                _cells.push(row);
            }
        }

        private var _cells:Vector.<Vector.<Entity>>;

        public function get cells():Vector.<Vector.<Entity>>
        {
            return _cells;
        }

        public function setPieceAtPosition(piece:Entity, position:GridPosition):void
        {
            if (position.x < Constants.BOARD_WIDTH && position.y < Constants.BOARD_HEIGHT)
            {
                _cells[position.y][position.x] = piece;
            }
        }

        public function getPieceAtPosition(position:GridPosition):Entity
        {
            if (position.x < Constants.BOARD_WIDTH && position.y < Constants.BOARD_HEIGHT)
            {
                return cells[position.y][position.x];
            }
            else
            {
                return null;
            }
        }

        public function removePieceAtPosition(position:GridPosition):Entity
        {
            var piece:Entity = null;

            if (position.x < Constants.BOARD_WIDTH && position.y < Constants.BOARD_HEIGHT)
            {
                piece = _cells[position.y][position.x];
                _cells[position.y][position.x] = null;
            }

            return piece;
        }

        public function piecesAsRows():Vector.<Vector.<Entity>>
        {
            var rows:Vector.<Vector.<Entity>> = new <Vector.<Entity>>[];
            var row:Vector.<Entity>;
            var piece:Entity;

            for (var y:int = 0; y < Constants.BOARD_HEIGHT; y++)
            {
                row = new <Entity>[];
                for (var x:int = 0; x < Constants.BOARD_WIDTH; x++)
                {
                    piece = getPieceAtPosition(new GridPosition(x, y));
                    if (piece)
                    {
                        row.push(piece);
                    }
                }
                rows.push(row);
            }
            return rows;
        }

        public function piecesAsCols():Vector.<Vector.<Entity>>
        {
            var cols:Vector.<Vector.<Entity>> = new <Vector.<Entity>>[];
            var col:Vector.<Entity>;
            var piece:Entity;

            for (var x:int = 0; x < Constants.BOARD_WIDTH; x++)
            {
                col = new <Entity>[];
                for (var y:int = 0; y < Constants.BOARD_HEIGHT; y++)
                {
                    piece = getPieceAtPosition(new GridPosition(x, y));
                    if (piece)
                    {
                        col.push(piece);
                    }
                }
                cols.push(col);
            }
            return cols;
        }
    }
}
