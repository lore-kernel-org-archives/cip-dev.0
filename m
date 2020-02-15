From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 15 Feb 2020 20:54:07 +0100
Subject: [cip-dev] [backport 4.4] mac80211: Fix TKIP replay protection
 immediately after key setup
Message-ID: <20200215195407.GA10344@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

So... this is first backport patch. I'll need to reformat a changelog.

The patch should pass our tests on gitlab, but I somehow don't think
those tests involved wifi at all... At least it compiles.

Can someone test it easily? Should I just submit it to stable
explaining I did not test it?

Do you have other patches that should go to 4.4/4.19?

Best regards,
								Pavel

commit 911e21ed055f6700fa80d0f7a818ba223999bb2a
Author: Pavel Machek <pavel@ucw.cz>
Date:   Thu Feb 13 22:56:46 2020 +0100

    Author: Jouni Malinen <j@w1.fi>
    Date:   Tue Jan 7 17:35:45 2020 +0200
    
    commit fa73f24d1b119b85b32cd8f217a73d108888097e
    
        mac80211: Fix TKIP replay protection immediately after key setup
    
            TKIP replay protection was skipped for the very first frame received
            after a new key is configured. While this is potentially needed to avoid
            dropping a frame in some cases, this does leave a window for replay
            attacks with group-addressed frames at the station side. Any earlier
            frame sent by the AP using the same key would be accepted as a valid
            frame and the internal RSC would then be updated to the TSC from that
            frame. This would allow multiple previously transmitted group-addressed
            frames to be replayed until the next valid new group-addressed frame
            from the AP is received by the station.
    
            Fix this by limiting the no-replay-protection exception to apply only
            for the case where TSC=0, i.e., when this is for the very first frame
            protected using the new key, and the local RSC had not been set to a
            higher value when configuring the key (which may happen with GTK).
    
    Signed-off-by: Jouni Malinen <j@w1.fi>
    Link: https://lore.kernel.org/r/20200107153545.10934-1-j at w1.fi
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    [pavel at ucw.cz: port to 4.4]
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/net/mac80211/tkip.c b/net/mac80211/tkip.c
index 0ae207771a58..d09d24d04f8a 100644
--- a/net/mac80211/tkip.c
+++ b/net/mac80211/tkip.c
@@ -265,10 +265,21 @@ int ieee80211_tkip_decrypt_data(struct crypto_cipher *tfm,
 	if ((keyid >> 6) != key->conf.keyidx)
 		return TKIP_DECRYPT_INVALID_KEYIDX;
 
-	if (key->u.tkip.rx[queue].state != TKIP_STATE_NOT_INIT &&
-	    (iv32 < key->u.tkip.rx[queue].iv32 ||
-	     (iv32 == key->u.tkip.rx[queue].iv32 &&
-	      iv16 <= key->u.tkip.rx[queue].iv16)))
+	/* Reject replays if the received TSC is smaller than or equal to the
+	 * last received value in a valid message, but with an exception for
+	 * the case where a new key has been set and no valid frame using that
+	 * key has yet received and the local RSC was initialized to 0. This
+	 * exception allows the very first frame sent by the transmitter to be
+	 * accepted even if that transmitter were to use TSC 0 (IEEE 802.11
+	 * described TSC to be initialized to 1 whenever a new key is taken into
+	 * use).
+	 */
+	if (iv32 < key->u.tkip.rx[queue].iv32 ||
+	    (iv32 == key->u.tkip.rx[queue].iv32 &&
+	     (iv16 < key->u.tkip.rx[queue].iv16 ||
+	      (iv16 == key->u.tkip.rx[queue].iv16 &&
+	       (key->u.tkip.rx[queue].iv32 || key->u.tkip.rx[queue].iv16 ||
+		key->u.tkip.rx[queue].state != TKIP_STATE_NOT_INIT)))))
 		return TKIP_DECRYPT_REPLAY;
 
 	if (only_iv) {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200215/0eba15fd/attachment.sig>
