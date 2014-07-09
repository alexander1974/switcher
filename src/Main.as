package
{

    import com.greensock.plugins.AutoAlphaPlugin;
    import com.greensock.plugins.ColorMatrixFilterPlugin;
    import com.greensock.plugins.GlowFilterPlugin;
    import com.greensock.plugins.TweenPlugin;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;

    import net.switcher.game.Constants;
    import net.switcher.game.SwitcherGame;
    import net.switcher.game.display.SpriteFactory;

    [SWF(width='755', height='600', backgroundColor='0xcccccc', frameRate='30')]
    public class Main extends Sprite
    {
        public function Main()
        {
            addEventListener(Event.ENTER_FRAME, init);
        }

        private var switcherGame:SwitcherGame;

        private function init(event:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, init);
            TweenPlugin.activate([AutoAlphaPlugin, ColorMatrixFilterPlugin, GlowFilterPlugin]);

            var backgroundLayer:Bitmap = SpriteFactory.getBackground();
            var gameLayer:Sprite = new Sprite();
            gameLayer.x = Constants.GRID_X;
            gameLayer.y = Constants.GRID_Y;

            addChild(backgroundLayer);
            addChild(gameLayer);
            switcherGame = new SwitcherGame(gameLayer);
            switcherGame.start();
        }
    }
}
