From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:36:21 +0000
Subject: [cip-dev] [PATCH 4.4-cip 13/23] batman-adv: Fix integer overflow in
 batadv_iv_ogm_calc_tq
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243781.1860.169.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

commit d285f52cc0f23564fd61976d43fd5b991b4828f6 upstream.

The undefined behavior sanatizer detected an signed integer overflow in a
setup with near perfect link quality

    UBSAN: Undefined behaviour in net/batman-adv/bat_iv_ogm.c:1246:25
    signed integer overflow:
    8713350 * 255 cannot be represented in type 'int'

The problems happens because the calculation of mixed unsigned and signed
integers resulted in an integer multiplication.

      batadv_ogm_packet::tq (u8 255)
    * tq_own (u8 255)
    * tq_asym_penalty (int 134; max 255)
    * tq_iface_penalty (int 255; max 255)

The tq_iface_penalty, tq_asym_penalty and inv_asym_penalty can just be
changed to unsigned int because they are not expected to become negative.

Fixes: c039876892e3 ("batman-adv: add WiFi penalty")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
[bwh: Backported to 4.4: adjust context]

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 912d9c36fb1c..3fb6e9e8df7e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1140,9 +1140,10 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
+	int if_num, ret = 0;
+	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
-	int tq_iface_penalty;
+	unsigned int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
