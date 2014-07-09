/**
 * Created by Alexander on 7/9/2014.
 */
package net.switcher.game.systems
{
    import ash.core.Engine;
    import ash.core.Entity;

    import net.switcher.game.components.Grid;
    import net.switcher.game.components.GridPosition;
    import net.switcher.game.components.PieceMatch;
    import net.switcher.game.components.TypeComponent;
    import net.switcher.game.nodes.MovingNode;

    public class FindMatchesSystem extends BaseGridOperatingSystem
    {
        public function FindMatchesSystem(engine:Engine)
        {
            super();
            this.engine = engine;
        }

        private var engine:Engine;
        private var grid:Grid;

        override public function update(time:Number):void
        {
            grid = nodes.head.grid;

            if (engine.getNodeList(MovingNode).empty)
            {
                var matches:Vector.<PieceMatch> = findMatches();

                if (matches.length > 0)
                {
                    matches = intersectMatches(matches);

                    var match:PieceMatch;
                    var pos:GridPosition;
                    var piece:Entity;

                    for each(match in matches)
                    {
                        for each(pos in match.positions)
                        {
                            piece = grid.getPieceAtPosition(pos);
                            piece.add(match);
                        }
                    }
                }
            }
        }

        private function findMatches():Vector.<PieceMatch>
        {
            var matches:Vector.<PieceMatch> = new <PieceMatch>[];
            for each(var row:Vector.<Entity> in grid.piecesAsRows())
            {
                addMatchesInLineToMatches(matches, row);
            }
            for each(var col:Vector.<Entity> in grid.piecesAsCols())
            {
                addMatchesInLineToMatches(matches, col);
            }
            return matches;
        }

        private function addMatchesInLineToMatches(matches:Vector.<PieceMatch>, haystack:Vector.<Entity>):void
        {
            var curMatch:PieceMatch = new PieceMatch();
            curMatch.pieceType = "";
            curMatch.positions = new Vector.<GridPosition>();

            var piece:Entity;
            for each(piece in haystack)
            {
                var typeComponent:TypeComponent = piece.get(TypeComponent);
                if (typeComponent)
                {
                    var pos:GridPosition = piece.get(GridPosition);
                    if (curMatch.positions.length == 0)
                    {
                        curMatch.positions.push(pos);
                        curMatch.pieceType = typeComponent.pieceType.value;
                    }
                    else if (typeComponent.pieceType.value == curMatch.pieceType && pos.isNextTo(curMatch.positions[curMatch.positions.length - 1]))
                    {
                        curMatch.positions.push(pos);
                    }
                    else
                    {
                        // remove this match and save it if it's big enough
                        if (curMatch.positions.length >= 3)
                        {
                            matches.push(curMatch);
                        }

                        // start a new match
                        curMatch = new PieceMatch();
                        curMatch.pieceType = typeComponent.pieceType.value;
                        curMatch.positions = Vector.<GridPosition>([pos]);
                    }
                }
            }
            if (curMatch.positions.length >= 3)
            {
                matches.push(curMatch);
            }
        }

        private function intersectMatches(matches:Vector.<PieceMatch>):Vector.<PieceMatch>
        {
            var intersection:Vector.<PieceMatch> = new <PieceMatch>[];
            var otherMatch:PieceMatch;
            var pieceMatch:PieceMatch;

            while (matches.length > 0)
            {
                pieceMatch = matches.pop();
                var intersects:Boolean = false;
                for each(otherMatch in matches)
                {
                    if (matchIntersectsMatch(pieceMatch, otherMatch))
                    {
                        intersects = true;
                        mergeIntoMatch(pieceMatch, otherMatch);
                        break;
                    }
                }
                if (!intersects)
                {
                    intersection.push(pieceMatch);
                }
            }

            return intersection;
        }

        private function matchIntersectsMatch(match:PieceMatch, otherMatch:PieceMatch):Boolean
        {
            var pos:GridPosition;
            for each(pos in match.positions)
            {
                if (pos.inVector(otherMatch.positions))
                {
                    return true;
                }
            }
            return false;
        }

        private function mergeIntoMatch(match:PieceMatch, otherMatch:PieceMatch):void
        {
            var pos:GridPosition;
            for each(pos in match.positions)
            {
                if (!pos.inVector(otherMatch.positions))
                {
                    otherMatch.positions.push(pos);
                }
            }
        }
    }
}
