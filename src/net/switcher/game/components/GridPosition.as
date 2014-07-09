package net.switcher.game.components
{
    import net.switcher.game.enum.GridDirection;
    import net.switcher.util.assert;

    public class GridPosition
    {
        public function GridPosition(x:int, y:int)
        {
            this.x = x;
            this.y = y;
        }

        public var x:int;
        public var y:int;

        public function isNextTo(other:GridPosition):Boolean
        {
            return manhattanDistanceFromPosition(other) == 1;
        }


        public function isEqual(other:*):Boolean
        {
            if (other === this)
            {
                return true;
            }
            if (!other || !(other is GridPosition))
            {
                return false;
            }
            return x == GridPosition(other).x && y == GridPosition(other).y;
        }


        public function inVector(vector:Object):Boolean
        {
            var element:GridPosition;
            for each(element in vector)
            {
                if (element.isEqual(this))
                {
                    return true;
                }
            }
            return false;
        }

        public function manhattanDistanceFromPosition(other:GridPosition):int
        {
            return Math.abs(other.x - x) + Math.abs(other.y - y);
        }

        public function positionPlusDirection(direction:GridDirection):GridPosition
        {
            var result:GridPosition = new GridPosition(x, y);
            switch (direction)
            {
                case GridDirection.GridDirectionUp:
                    result.y++;
                    break;
                case GridDirection.GridDirectionDown:
                    result.y--;
                    break;
                case GridDirection.GridDirectionLeft:
                    result.x--;
                    break;
                case GridDirection.GridDirectionRight:
                    result.x++;
                    break;
                default:
                    assert(false, "Unimplemented direction " + direction);
            }

            return result;
        }

        public function positionMinusDirection(direction:GridDirection):GridPosition
        {
            var result:GridPosition = new GridPosition(x, y);
            switch (direction)
            {
                case GridDirection.GridDirectionUp:
                    result.y--;
                    break;

                case GridDirection.GridDirectionDown:
                    result.y++;
                    break;

                case GridDirection.GridDirectionLeft:
                    result.x++;
                    break;

                case GridDirection.GridDirectionRight:
                    result.x--;
                    break;

                default:
                    assert(false, "Unimplemented direction " + direction);
            }

            return result;
        }
    }
}
