package net.switcher.util
{
    /**
     * Shuffles object with Fisher-Yates shuffle algorithm using Math.random
     * @param obj
     * example code to shuffle a vector: ObjectUtils.shuffleObject(myVector);
     */
    public function shuffle(obj:Object):void
    {
        var i:int = obj.length;
        while (i > 0)
        {
            var j:int = Math.floor(Math.random() * i);
            i--;
            var temp:* = obj[i];
            obj[i] = obj[j];
            obj[j] = temp;
        }
    }
}
