package net.switcher.game.systems.grid
{
    import ash.core.Engine;

    import net.switcher.game.display.MouseInputController;
    import net.switcher.game.nodes.MovingNode;
    import net.switcher.game.nodes.WillMoveNode;

    public class UserInputControlSysytem extends BaseGridOperatingSystem
    {
        public function UserInputControlSysytem(engine:Engine, mouseInputController:MouseInputController)
        {
            super();
            this.engine = engine;
            this.mouseInputController = mouseInputController;
        }

        private var engine:Engine;
        private var mouseInputController:MouseInputController;

        override public function update(time:Number):void
        {
            if (engine.getNodeList(MovingNode).empty && engine.getNodeList(WillMoveNode).empty)
            {
                mouseInputController.unblockInteraction();
            }
            else
            {
                mouseInputController.blockInteraction();
            }
        }
    }
}
