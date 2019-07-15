From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:20 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] rtc: nvmem: use
	devm_nvmem_register()
In-Reply-To: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200245-30331-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 461e557b97277b693cd8008c32a9d01c7f8f453b upstream.

Use the resource managed variant of nvmem_register().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/nvmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 36ab183..2a7220d 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -93,7 +93,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 
 	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
-	rtc->nvmem = nvmem_register(nvmem_config);
+	rtc->nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
 	if (IS_ERR(rtc->nvmem))
 		return PTR_ERR(rtc->nvmem);
 
@@ -107,12 +107,7 @@ EXPORT_SYMBOL_GPL(rtc_nvmem_register);
 
 void rtc_nvmem_unregister(struct rtc_device *rtc)
 {
-	if (IS_ERR_OR_NULL(rtc->nvmem))
-		return;
-
 	/* unregister the old ABI */
 	if (rtc->nvram)
 		rtc_nvram_unregister(rtc);
-
-	nvmem_unregister(rtc->nvmem);
 }
-- 
2.7.4
