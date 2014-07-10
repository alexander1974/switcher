package net.switcher.game
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.tick.FrameTickProvider;

    import flash.display.DisplayObjectContainer;

    import net.switcher.game.components.Grid;
    import net.switcher.game.display.MouseInputController;
    import net.switcher.game.enum.SystemPriorities;
    import net.switcher.game.systems.PieceMovingSystem;
    import net.switcher.game.systems.PieceSwapSystem;
    import net.switcher.game.systems.PiecesExplodeSystem;
    import net.switcher.game.systems.grid.FindGapsSystem;
    import net.switcher.game.systems.grid.FindMatchesSystem;
    import net.switcher.game.systems.grid.PieceSpawnerSystem;
    import net.switcher.game.systems.grid.UserInputControlSysytem;

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
            mouseInput = new MouseInputController(container, gameBoard);

            engine.addSystem(new PieceSpawnerSystem(creator, container), SystemPriorities.spawn);
            engine.addSystem(new FindMatchesSystem(engine), SystemPriorities.makeMatches);
            engine.addSystem(new PiecesExplodeSystem(gameBoard.get(Grid), creator), SystemPriorities.explodePieces);
            engine.addSystem(new FindGapsSystem(engine), SystemPriorities.findGaps);
            engine.addSystem(new PieceSwapSystem(gameBoard.get(Grid)), SystemPriorities.swap);
            engine.addSystem(new PieceMovingSystem(gameBoard.get(Grid)), SystemPriorities.move);
            engine.addSystem(new UserInputControlSysytem(engine, mouseInput), SystemPriorities.mouseController);
        }
    }
}
