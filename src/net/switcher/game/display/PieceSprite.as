package net.switcher.game.display
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;

    import net.switcher.game.Constants;

    public class PieceSprite extends MovieClip
    {
        public function PieceSprite(asset:DisplayObject)
        {
            super();

            cacheAsBitmap = true;
            setCanvas();
            setTexture(asset);
        }

        private var asset:DisplayObject;

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
            asset.x = Math.round(-asset.width / 2);
            asset.y = Math.round(-asset.height / 2);
            this.asset = asset;
            addChildAt(asset, 0);
        }

        private function setCanvas():void
        {
            graphics.beginFill(0xFFFFFF, 0);
            graphics.drawRect(-Constants.PIECE_SIZE / 2, -Constants.PIECE_SIZE / 2, Constants.PIECE_SIZE, Constants.PIECE_SIZE);
        }
    }
}
