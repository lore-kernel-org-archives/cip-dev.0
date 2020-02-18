From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:13 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 16/23] usb: typec: hd3ss3220_irq() can
	be static
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-17-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: kbuild test robot <lkp@intel.com>

commit dd3fd317e2beb899cbffcf364de049b9f9a02db5 upstream.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Signed-off-by: kbuild test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20191005215727.qfypxoswkiyu45ak at 332d0cec05f4
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/hd3ss3220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 0ece5ed..658e6aa 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -120,7 +120,7 @@ static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
 	}
 }
 
-irqreturn_t hd3ss3220_irq(struct hd3ss3220 *hd3ss3220)
+static irqreturn_t hd3ss3220_irq(struct hd3ss3220 *hd3ss3220)
 {
 	int err;
 
-- 
2.7.4
