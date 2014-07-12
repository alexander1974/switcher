package net.switcher.game.systems.grid
{
    import ash.core.Engine;
    import ash.core.Entity;

    import flash.utils.getTimer;

    import net.switcher.game.components.PulsePossibleMoves;
    import net.switcher.game.display.MouseInputController;
    import net.switcher.game.nodes.MovingNode;
    import net.switcher.game.nodes.WillMoveNode;

    public class UserInputControlSystem extends BaseGridOperatingSystem
    {
        private static const TIME_TO_DISPLAY_HINT:int = 6000;

        public function UserInputControlSystem(engine:Engine, mouseInputController:MouseInputController)
        {
            super();
            this.engine = engine;
            this.mouseInputController = mouseInputController;
        }

        private var engine:Engine;
        private var mouseInputController:MouseInputController;
        private var lastMoveTime:Number;

        override public function update(time:Number):void
        {
            var gameBoard:Entity = engine.getEntityByName("gameBoard");

            if (engine.getNodeList(MovingNode).empty && engine.getNodeList(WillMoveNode).empty)
            {
                mouseInputController.unblockInteraction();
                if (getTimer() - lastMoveTime > TIME_TO_DISPLAY_HINT)
                {
                    (gameBoard.get(PulsePossibleMoves) as PulsePossibleMoves).displayPulse = true;
                }
            }
            else
            {
                mouseInputController.blockInteraction();

                (gameBoard.get(PulsePossibleMoves) as PulsePossibleMoves).displayPulse = false;
                lastMoveTime = getTimer();
            }
        }
    }
}
