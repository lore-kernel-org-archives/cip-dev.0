From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:21 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] rtc: nvmem: remove nvmem from
	struct rtc_device
In-Reply-To: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200245-30331-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 41c9e132c5cc3e5f28cf44032ff82f7614a42989 upstream.

Using devm_nvmem_register allows to avoid tracking the nvmem pointer in the
rtc_device structure.
This ultimately allows to register multiple nvmem devices from an RTC
driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/nvmem.c | 24 ++++++++++--------------
 include/linux/rtc.h |  1 -
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 2a7220d..ebdfe8e 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -25,11 +25,9 @@ rtc_nvram_read(struct file *filp, struct kobject *kobj,
 	       struct bin_attribute *attr,
 	       char *buf, loff_t off, size_t count)
 {
-	struct rtc_device *rtc = attr->private;
-
 	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
 
-	return nvmem_device_read(rtc->nvmem, off, count, buf);
+	return nvmem_device_read(attr->private, off, count, buf);
 }
 
 static ssize_t
@@ -37,14 +35,13 @@ rtc_nvram_write(struct file *filp, struct kobject *kobj,
 		struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct rtc_device *rtc = attr->private;
-
 	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
 
-	return nvmem_device_write(rtc->nvmem, off, count, buf);
+	return nvmem_device_write(attr->private, off, count, buf);
 }
 
-static int rtc_nvram_register(struct rtc_device *rtc, size_t size)
+static int rtc_nvram_register(struct rtc_device *rtc,
+			      struct nvmem_device *nvmem, size_t size)
 {
 	int err;
 
@@ -56,7 +53,7 @@ static int rtc_nvram_register(struct rtc_device *rtc, size_t size)
 
 	rtc->nvram->attr.name = "nvram";
 	rtc->nvram->attr.mode = 0644;
-	rtc->nvram->private = rtc;
+	rtc->nvram->private = nvmem;
 
 	sysfs_bin_attr_init(rtc->nvram);
 
@@ -85,21 +82,20 @@ static void rtc_nvram_unregister(struct rtc_device *rtc)
 int rtc_nvmem_register(struct rtc_device *rtc,
 		       struct nvmem_config *nvmem_config)
 {
-	if (!IS_ERR_OR_NULL(rtc->nvmem))
-		return -EBUSY;
+	struct nvmem_device *nvmem;
 
 	if (!nvmem_config)
 		return -ENODEV;
 
 	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
-	rtc->nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
-	if (IS_ERR(rtc->nvmem))
-		return PTR_ERR(rtc->nvmem);
+	nvmem = devm_nvmem_register(rtc->dev.parent, nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
 
 	/* Register the old ABI */
 	if (rtc->nvram_old_abi)
-		rtc_nvram_register(rtc, nvmem_config->size);
+		rtc_nvram_register(rtc, nvmem, nvmem_config->size);
 
 	return 0;
 }
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6aedc30..6e9cb05 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -138,7 +138,6 @@ struct rtc_device {
 
 	bool registered;
 
-	struct nvmem_device *nvmem;
 	/* Old ABI support */
 	bool nvram_old_abi;
 	struct bin_attribute *nvram;
-- 
2.7.4
