package net.switcher.game.components
{
    import flash.geom.Point;

    public class WillMove
    {
        public function WillMove(destinationPoint:Point)
        {
            this.destinationPoint = destinationPoint;
        }

        public var destinationPoint:Point;
    }
}
