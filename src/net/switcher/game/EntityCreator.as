package net.switcher.game
{
    import ash.core.Engine;
    import ash.core.Entity;

    import net.switcher.game.components.Display;
    import net.switcher.game.components.Grid;
    import net.switcher.game.components.TypeComponent;
    import net.switcher.game.display.PieceSprite;
    import net.switcher.game.display.SpriteFactory;
    import net.switcher.game.enum.PieceType;
    import net.switcher.util.shuffle;

    public class EntityCreator
    {
        public function EntityCreator(engine:Engine)
        {
            this.engine = engine;
        }

        private var engine:Engine;

        public function destroyEntity(entity:Entity):void
        {
            engine.removeEntity(entity);
        }

        public function createGame():Entity
        {
            var gameBoard:Entity = new Entity()
                    .add(new Grid());

            engine.addEntity(gameBoard);
            return gameBoard;
        }

        public function createRandomPiece():Entity
        {
            var pieceTypes:Vector.<PieceType> = PieceType.AllTypes.concat();

            shuffle(pieceTypes);

            var randomType:PieceType = pieceTypes.pop();

            var pieceSprite:PieceSprite = SpriteFactory.getPieceSpriteForType(randomType);

            var piece:Entity = new Entity()
                    .add(new TypeComponent(randomType))
                    .add(new Display(pieceSprite));

            engine.addEntity(piece);

            return piece;
        }
    }
}
