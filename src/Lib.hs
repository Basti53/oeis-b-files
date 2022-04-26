module Lib where 

import qualified Data.Text as T 
import qualified Data.Text.IO as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Builder as B
import qualified Data.Text.Lazy.Builder.Int as B

lineOK :: T.Text -> Bool 
lineOK line = T.length line <= 1000

-- Fast integral to text conversion, see https://github.com/haskell/text/issues/218
intToText :: Integral a => a -> T.Text
intToText = TL.toStrict . B.toLazyText . B.decimal

toLines :: (Integral a, Integral b) => a -> [b] -> [T.Text]
toLines offset theSequence = do 
    (n, an) <- zip [offset..] theSequence
    return $ intToText n `T.append` T.pack " " `T.append` intToText an `T.append` T.pack "\n"

writebFile1 :: (Integral a, Integral b) => String -> a -> Int -> [b] -> IO ()
writebFile1 fileName offset maxbFileLength theSequence = 
    mapM_ (T.appendFile fileName) $ takeWhile lineOK $ take maxbFileLength $ toLines offset theSequence

writebFile2 :: (Integral a, Integral b) => String -> a -> Int -> (a -> b) -> IO () 
writebFile2 fileName offset maxbFileLength f = 
    writebFile1 fileName offset maxbFileLength $ map f [offset..]