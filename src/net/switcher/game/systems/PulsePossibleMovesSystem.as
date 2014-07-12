package net.switcher.game.systems
{
    import ash.core.Engine;
    import ash.core.Entity;
    import ash.core.NodeList;
    import ash.core.System;

    import net.switcher.game.components.PulsePossibleMoves;
    import net.switcher.game.components.Pulsing;
    import net.switcher.game.display.PieceSprite;
    import net.switcher.game.nodes.PossibleMoveNode;

    public class PulsePossibleMovesSystem extends System
    {
        public var engine:Engine;
        private var nodes:NodeList;
        private var piece:Entity;

        override public function addToEngine(engine:Engine):void
        {
            nodes = engine.getNodeList(PossibleMoveNode);
            this.engine = engine;
        }

        override public function removeFromEngine(engine:Engine):void
        {
            nodes = null;
        }

        override public function update(time:Number):void
        {
            if (!nodes.empty)
            {
                var gameBoard:Entity = engine.getEntityByName("gameBoard");
                var pulse:PulsePossibleMoves = gameBoard.get(PulsePossibleMoves) as PulsePossibleMoves;
                var node:PossibleMoveNode = nodes.head;
                var pieceSprite:PieceSprite = node.display.displayObject as PieceSprite;

                piece = node.entity;

                if (pulse.displayPulse)
                {
                    if (!piece.has(Pulsing))
                    {
                        piece.add(new Pulsing());
                        pieceSprite.pulse();
                    }
                }
                else
                {
                    piece.remove(Pulsing);
                    pieceSprite.stopPulsing();
                }
            }

        }
    }
}
