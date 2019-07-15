From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:23 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] rtc: rx8581: Add support for Epson
	rx8571 RTC
In-Reply-To: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200245-30331-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 51f896ffd1a5aacbda82ed82552c4077e3cc3b68 upstream.

Add support for Epson rx8571 real-time clock. rx8571 rtc is compatible
with rx8581,except that rx8571 has additional 16 bytes of RAM.

16 bytes of nvmem is supported and exposed in sysfs (# is the instance
number,starting with 0): /sys/bus/nvmem/devices/rx8571-#/nvmem

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig      |   5 ++-
 drivers/rtc/rtc-rx8581.c | 114 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7d7be60..ec2cba4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -600,9 +600,10 @@ config RTC_DRV_RX8010
 	  will be called rtc-rx8010.
 
 config RTC_DRV_RX8581
-	tristate "Epson RX-8581"
+	tristate "Epson RX-8571/RX-8581"
 	help
-	  If you say yes here you will get support for the Epson RX-8581.
+	  If you say yes here you will get support for the Epson RX-8571/
+	  RX-8581.
 
 	  This driver can also be built as a module. If so the module
 	  will be called rtc-rx8581.
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index eac8821..776e3a2 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/log2.h>
@@ -51,11 +53,19 @@
 #define RX8581_CTRL_STOP	0x02 /* STOP bit */
 #define RX8581_CTRL_RESET	0x01 /* RESET bit */
 
+#define RX8571_USER_RAM		0x10
+#define RX8571_NVRAM_SIZE	0x10
+
 struct rx8581 {
 	struct regmap		*regmap;
 	struct rtc_device	*rtc;
 };
 
+struct rx85x1_config {
+	struct regmap_config regmap;
+	unsigned int num_nvram;
+};
+
 /*
  * In the routines that deal directly with the rx8581 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -181,25 +191,103 @@ static const struct rtc_class_ops rx8581_rtc_ops = {
 	.set_time	= rx8581_rtc_set_time,
 };
 
-static int rx8581_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int rx8571_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
 {
-	struct rx8581	  *rx8581;
-	static const struct regmap_config config = {
+	struct rx8581 *rx8581 = priv;
+
+	return regmap_bulk_read(rx8581->regmap, RX8571_USER_RAM + offset,
+				val, bytes);
+}
+
+static int rx8571_nvram_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct rx8581 *rx8581 = priv;
+
+	return regmap_bulk_write(rx8581->regmap, RX8571_USER_RAM + offset,
+				 val, bytes);
+}
+
+static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct rx8581 *rx8581 = priv;
+	unsigned int tmp_val;
+	int ret;
+
+	ret = regmap_read(rx8581->regmap, RX8581_REG_RAM, &tmp_val);
+	(*(unsigned char *)val) = (unsigned char) tmp_val;
+
+	return ret;
+}
+
+static int rx85x1_nvram_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct rx8581 *rx8581 = priv;
+	unsigned char tmp_val;
+
+	tmp_val = *((unsigned char *)val);
+	return regmap_write(rx8581->regmap, RX8581_REG_RAM,
+				(unsigned int)tmp_val);
+}
+
+static const struct rx85x1_config rx8581_config = {
+	.regmap = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.max_register = 0xf,
+	},
+	.num_nvram = 1
+};
+
+static const struct rx85x1_config rx8571_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x1f,
+	},
+	.num_nvram = 2
+};
+
+static int rx8581_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct rx8581 *rx8581;
+	const struct rx85x1_config *config = &rx8581_config;
+	const void *data = of_device_get_match_data(&client->dev);
+	static struct nvmem_config nvmem_cfg[] = {
+		{
+			.name = "rx85x1-",
+			.word_size = 1,
+			.stride = 1,
+			.size = 1,
+			.reg_read = rx85x1_nvram_read,
+			.reg_write = rx85x1_nvram_write,
+		}, {
+			.name = "rx8571-",
+			.word_size = 1,
+			.stride = 1,
+			.size = RX8571_NVRAM_SIZE,
+			.reg_read = rx8571_nvram_read,
+			.reg_write = rx8571_nvram_write,
+		},
 	};
+	int ret, i;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
+	if (data)
+		config = data;
+
 	rx8581 = devm_kzalloc(&client->dev, sizeof(struct rx8581), GFP_KERNEL);
 	if (!rx8581)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, rx8581);
 
-	rx8581->regmap = devm_regmap_init_i2c(client, &config);
+	rx8581->regmap = devm_regmap_init_i2c(client, &config->regmap);
 	if (IS_ERR(rx8581->regmap))
 		return PTR_ERR(rx8581->regmap);
 
@@ -213,7 +301,14 @@ static int rx8581_probe(struct i2c_client *client,
 	rx8581->rtc->start_secs = 0;
 	rx8581->rtc->set_start_time = true;
 
-	return rtc_register_device(rx8581->rtc);
+	ret = rtc_register_device(rx8581->rtc);
+
+	for (i = 0; i < config->num_nvram; i++) {
+		nvmem_cfg[i].priv = rx8581;
+		rtc_nvmem_register(rx8581->rtc, &nvmem_cfg[i]);
+	}
+
+	return ret;
 }
 
 static const struct i2c_device_id rx8581_id[] = {
@@ -223,8 +318,9 @@ static const struct i2c_device_id rx8581_id[] = {
 MODULE_DEVICE_TABLE(i2c, rx8581_id);
 
 static const struct of_device_id rx8581_of_match[] = {
-	{ .compatible = "epson,rx8581" },
-	{ }
+	{ .compatible = "epson,rx8571", .data = &rx8571_config },
+	{ .compatible = "epson,rx8581", .data = &rx8581_config },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rx8581_of_match);
 
@@ -240,5 +336,5 @@ static struct i2c_driver rx8581_driver = {
 module_i2c_driver(rx8581_driver);
 
 MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com>");
-MODULE_DESCRIPTION("Epson RX-8581 RTC driver");
+MODULE_DESCRIPTION("Epson RX-8571/RX-8581 RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4
