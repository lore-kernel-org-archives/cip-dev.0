From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:13 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 02/10] rtc: pcf85363: add .max_register
	in regmap_config
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit c57849dde003db3e21d33eab906dba2202f9294e upstream.

This helps debugging as it allows reading registers from debugfs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/rtc-pcf85363.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 54fc1a7..5fbc6df 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -139,6 +139,7 @@ static const struct rtc_class_ops rtc_ops = {
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0x7f,
 };
 
 static int pcf85363_probe(struct i2c_client *client,
-- 
2.7.4
