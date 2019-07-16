From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:14 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] rtc: pcf85363: set time accurately
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 188306ac9536ec47674ffa9dd330f69927679aeb upstream.

As per 8.2.6 Setting and reading the time in RTC mode, first stop the clok,
then reset it before setting the date and time registers. Finally, start
the clock.

This uses register address wrap around from 0x2f to 0x00 for efficiency.

This allows to set the clock with a millisecond accuracy (drift is not
corrected in this example):

RTC        System
1325388767 1325388767.000029180
1325388768 1325388768.000018362
1325388769 1325388769.000006544
1325388770 1325388769.999992725
1325388771 1325388770.999974544

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/rtc-pcf85363.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 5fbc6df..dc57a6f 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -73,6 +73,10 @@
 #define CTRL_RESETS	0x2f
 #define CTRL_RAM	0x40
 
+#define STOP_EN_STOP	BIT(0)
+
+#define RESET_CPR	0xa4
+
 #define NVRAM_SIZE	0x40
 
 static struct i2c_driver pcf85363_driver;
@@ -115,8 +119,12 @@ static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
-	unsigned char buf[DT_YEARS + 1];
-	int len = sizeof(buf);
+	unsigned char tmp[11];
+	unsigned char *buf = &tmp[2];
+	int ret;
+
+	tmp[0] = STOP_EN_STOP;
+	tmp[1] = RESET_CPR;
 
 	buf[DT_100THS] = 0;
 	buf[DT_SECS] = bin2bcd(tm->tm_sec);
@@ -127,8 +135,12 @@ static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[DT_MONTHS] = bin2bcd(tm->tm_mon + 1);
 	buf[DT_YEARS] = bin2bcd(tm->tm_year % 100);
 
-	return regmap_bulk_write(pcf85363->regmap, DT_100THS,
-				 buf, len);
+	ret = regmap_bulk_write(pcf85363->regmap, CTRL_STOP_EN,
+				tmp, sizeof(tmp));
+	if (ret)
+		return ret;
+
+	return regmap_write(pcf85363->regmap, CTRL_STOP_EN, 0);
 }
 
 static const struct rtc_class_ops rtc_ops = {
-- 
2.7.4
