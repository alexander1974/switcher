package net.switcher.game.display
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.Point;

    public class PieceSprite extends Sprite
    {
        public function PieceSprite(asset:DisplayObject)
        {
            super();

            cacheAsBitmap = true;
            _anchorPoint = new Point(0.5, 0.5);
            setTexture(asset);
        }

        private var asset:DisplayObject;
        private var _anchorPoint:Point;

        public function removeFromParent():void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
        }

        public function setTexture(asset:DisplayObject):void
        {
            if (this.asset)
            {
                removeChild(this.asset);
            }
            asset.x = -asset.width * _anchorPoint.x;
            asset.y = -asset.height * (1 - _anchorPoint.y);
            this.asset = asset;
            addChildAt(asset, 0);
        }

        public function getTexture():DisplayObject
        {
            var asset:DisplayObject = this.asset;
            removeChild(asset);
            this.asset = null;
            return asset;
        }

        /**
         * Sets the anchor point of the sprite the same way it's done in Objective-C
         * anchor.x and anchor.y are in relation to the Sprite size
         * the 0:0 point is in the bottom left corner, 1:1 is in the top right.
         * @param anchor
         */
        public function setAnchorPoint(anchor:Point):void
        {
            _anchorPoint.x = anchor.x;
            _anchorPoint.y = anchor.y;
            setTexture(asset);
        }
    }
}
