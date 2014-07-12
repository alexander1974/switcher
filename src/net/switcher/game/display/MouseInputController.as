package net.switcher.game.display
{
    import ash.core.Entity;

    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import net.switcher.game.Constants;
    import net.switcher.game.components.Display;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceSwap;
    import net.switcher.game.enum.GridDirection;
    import net.switcher.game.helpers.GridHelper;

    public class MouseInputController
    {
        private var displayObjectContainer:DisplayObjectContainer;
        private var gameBoard:Entity;
        private var userInteractionEnabled:Boolean;
        private var touchedPiece:Entity;
        private var touchBeganLocation:Point;
        private var lastClickedPiece:Entity;
        private var lastClickedPiecePosition:Point;

        public function MouseInputController(displayObjectContainer:DisplayObjectContainer, gameBoard:Entity)
        {
            this.displayObjectContainer = displayObjectContainer;
            this.gameBoard = gameBoard;

            this.displayObjectContainer.mouseChildren = false;
        }

        public function blockInteraction():void
        {
            userInteractionEnabled = false;
            displayObjectContainer.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
        }

        public function isUserInteractionEnabled():Boolean
        {
            return userInteractionEnabled;
        }

        public function unblockInteraction():void
        {
            userInteractionEnabled = true;
            displayObjectContainer.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
        }

        private function handleMouseDown(event:MouseEvent):void
        {
            displayObjectContainer.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);

            var pos:GridPosition = GridHelper.mouseEventToGridPosition(event);
            var grid:Grid = gameBoard.get(Grid) as Grid;
            var piece:Entity = grid.getPieceAtPosition(pos);

            if (piece)
            {
                var pieceSprite:PieceSprite = (piece.get(Display) as Display).displayObject as PieceSprite;
                pieceSprite.highlight();

                touchedPiece = piece;
                touchBeganLocation = new Point(event.stageX, event.stageY);
            }
        }

        private function handleMouseUp(event:MouseEvent):void
        {
            displayObjectContainer.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);

            var piece:Entity = touchedPiece;
            touchedPiece = null;

            if (piece == null)
            {
                return;
            }

            var pieceSprite:PieceSprite = (piece.get(Display) as Display).displayObject as PieceSprite;
            var piecePosition:GridPosition = piece.get(GridPosition) as GridPosition;
            var center:Point = GridHelper.gridPositionToPoint(piecePosition);

            var oldLoc:Point = touchBeganLocation;
            var newLoc:Point = new Point(event.stageX, event.stageY);

            if (lastClickedPiece && piecePosition.isNextTo(lastClickedPiece.get(GridPosition) as GridPosition))
            {
                oldLoc = new Point(event.stageX, event.stageY);
                newLoc = lastClickedPiecePosition;
            }

            if (lastClickedPiece)
            {
                var lastSprite:PieceSprite = (lastClickedPiece.get(Display) as Display).displayObject as PieceSprite;
                lastSprite.removeHighlight();
            }

            lastClickedPiece = piece;
            lastClickedPiecePosition = touchBeganLocation;

            var xdiff:Number = newLoc.x - oldLoc.x;
            var ydiff:Number = newLoc.y - oldLoc.y;

            var distanceSquared:Number = xdiff * xdiff + ydiff * ydiff;

            if (distanceSquared > Constants.MIN_SWIPE_DISTANCE * Constants.MIN_SWIPE_DISTANCE)
            {
                var direction:GridDirection;
                if (Math.abs(xdiff) > Math.abs(ydiff))
                {
                    if (xdiff > Constants.PIECE_SIZE)
                    {
                        xdiff = Constants.PIECE_SIZE;
                    }
                    if (xdiff < -Constants.PIECE_SIZE)
                    {
                        xdiff = -Constants.PIECE_SIZE;
                    }
                    if (xdiff > 0)
                    {
                        direction = GridDirection.GridDirectionRight;
                    }
                    else
                    {
                        direction = GridDirection.GridDirectionLeft;
                    }
                }
                else
                {
                    if (ydiff > Constants.PIECE_SIZE)
                    {
                        ydiff = Constants.PIECE_SIZE;
                    }
                    if (ydiff < -Constants.PIECE_SIZE)
                    {
                        ydiff = -Constants.PIECE_SIZE;
                    }

                    if (ydiff > 0)
                    {
                        direction = GridDirection.GridDirectionDown;
                    }
                    else
                    {
                        direction = GridDirection.GridDirectionUp;
                    }
                }
                piece.add(new PieceSwap(piecePosition.positionPlusDirection(direction)));

                pieceSprite.removeHighlight();
                lastClickedPiece = null;
                lastClickedPiecePosition = null;
            }
            else
            {
                pieceSprite.x = center.x;
                pieceSprite.y = center.y;
            }
        }
    }
}
