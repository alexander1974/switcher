package net.switcher.game.display
{
    import com.greensock.TimelineMax;
    import com.greensock.TweenMax;
    import com.greensock.data.TweenMaxVars;

    import flash.display.DisplayObject;
    import flash.display.MovieClip;

    import net.switcher.game.Constants;

    public class PieceSprite extends MovieClip
    {
        private var asset:DisplayObject;

        public function PieceSprite(asset:DisplayObject)
        {
            super();

            cacheAsBitmap = true;
            setCanvas();
            setTexture(asset);
        }

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

        public function highlight():void
        {
            TweenMax.to(asset, 0, {glowFilter: {color: 0xFFFFFF, blurX: 10, blurY: 10, strength: 2, alpha: 1}});
        }

        public function removeHighlight():void
        {
            asset.filters = [];
        }

        public function pulse():void
        {
            TweenMax.to(asset, 0, {glowFilter: {color: 0xFFFFFF, blurX: 10, blurY: 10, strength: 2, alpha: 0}});

            var vars:TweenMaxVars = new TweenMaxVars()
                    .repeat(-1);
            new TimelineMax(vars)
                    .append(TweenMax.to(asset, 1, {glowFilter: {alpha: 1}}))
                    .append(TweenMax.to(asset, 1, {glowFilter: {alpha: 0}}));
        }

        public function stopPulsing():void
        {
            TweenMax.killTweensOf(asset);
            removeHighlight();
        }

        private function setCanvas():void
        {
            graphics.beginFill(0xFFFFFF, 0);
            graphics.drawRect(-Constants.PIECE_SIZE / 2, -Constants.PIECE_SIZE / 2, Constants.PIECE_SIZE, Constants.PIECE_SIZE);
        }
    }
}
