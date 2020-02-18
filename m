From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:00 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/23] usb: typec: mux: Fix unsigned
	comparison with less than zero
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-4-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: YueHaibing <yuehaibing@huawei.com>

commit 4e46f271c37415323f2b650d02ef50c87ff8d092 upstream.

The return from the call to fwnode_property_read_u16_array is int,
it can be a negative error code however this is being assigned to
an size_t variable 'nval', hence the check is always false.
Fix this by making 'nval' an int.

Detected by Coccinelle ("Unsigned expression compared with
zero: nval < 0")

Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 0c4e0b5..e49c138 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -126,7 +126,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
 	struct typec_mux *mux;
-	size_t nval;
+	int nval;
 	bool match;
 	u16 *val;
 	int i;
-- 
2.7.4
