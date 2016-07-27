-- |

module HL.Controller.Announcements where

import           Data.List
import           Data.Ord
import           Data.Time
import           HL.Controller
import           HL.View
import           HL.View.Announcements
import qualified Text.Blaze.Html.Renderer.Utf8 as BlazeUtf8
import           Yesod.Feed

-- | Announcements controller.
getAnnouncementsR :: C (Html ())
getAnnouncementsR =
  do feeds <- fmap appFeedEntries getYesod
     lucid (announcementsFromMarkdown
              (mapM_ (\entry ->
                        do h1_ (toHtml (feedEntryTitle entry))
                           p_ (strong_ (toHtml (formatTime defaultTimeLocale "%B %d %Y" (feedEntryUpdated entry))))
                           toHtmlRaw (BlazeUtf8.renderHtml (feedEntryContent entry))
                           hr_ [])
                     (sortBy (flip (comparing feedEntryUpdated)) feeds)))
