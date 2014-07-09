package net.switcher.game
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.tick.FrameTickProvider;

    import flash.display.DisplayObjectContainer;

    import net.switcher.game.components.Grid;
    import net.switcher.game.display.MouseInputController;
    import net.switcher.game.enum.SystemPriorities;
    import net.switcher.game.systems.ExplodePiecesSystem;
    import net.switcher.game.systems.FindGapsSystem;
    import net.switcher.game.systems.FindMatchesSystem;
    import net.switcher.game.systems.PieceFallSystem;
    import net.switcher.game.systems.PieceSpawnerSystem;

    public class SwitcherGame
    {
        public function SwitcherGame(container:DisplayObjectContainer)
        {
            this.container = container;
            prepare();
        }

        private var container:DisplayObjectContainer;
        private var engine:Engine;
        private var tickProvider:FrameTickProvider;
        private var creator:EntityCreator;
        private var mouseInput:MouseInputController;

        public function start():void
        {
            tickProvider = new FrameTickProvider(container);
            tickProvider.add(engine.update);
            tickProvider.start();
        }

        private function prepare():void
        {
            engine = new Engine();
            creator = new EntityCreator(engine);
            var gameBoard:Entity = creator.createGame();

            engine.addSystem(new FindMatchesSystem(engine), SystemPriorities.makeMatches);
            engine.addSystem(new ExplodePiecesSystem(gameBoard.get(Grid), container, creator), SystemPriorities.explodePieces);
            engine.addSystem(new FindGapsSystem(), SystemPriorities.findGaps);
            engine.addSystem(new PieceFallSystem(gameBoard.get(Grid)), SystemPriorities.fall);
            engine.addSystem(new PieceSpawnerSystem(creator, container), SystemPriorities.spawn);
            mouseInput = new MouseInputController(container, gameBoard);
        }
    }
}
