Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4623FC0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:40 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.41874.1737546695151288386
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pRAUCD9b;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso5029595e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546693; x=1738151493; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT4ugj+vgOIbDsSf9z3BiB9BhfXPYtcur1XNMe2FGYA=;
        b=pRAUCD9bUubvWXx0RYqswvXGyd3RBzbCi1aWmUcCuTTvYsICRkNVA9VFOv8p+5kM+3
         VQb9REIe6oA/d06UgQ4pZZqUYDcfVLU/i2W+9VHf8mGM83BK5+ye6Uao5K7cwluvEN5Y
         q4ks0C6yqotLnSnaxYiI2DdYHXlxS6T+UGRz+ZuIlsffdtSBcEaLHk9JFlV3P3t4aF9B
         C/YLDLhxd3KSmuq/s1s8N4xHx7GhsRd5xGaPzFBQoFO6G1wJaOR2xA1lTawZVarBE1Q5
         uikj7Vq6q7FegrRFRvAZzJUrYFJcC1XYNoDTlrVQsw8zlnRNeCb0x/XRckYQrGGJb8NA
         M4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546693; x=1738151493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT4ugj+vgOIbDsSf9z3BiB9BhfXPYtcur1XNMe2FGYA=;
        b=CxE6Y9ZBmBJ2stphq1uzX9EgwtYc7ASS2LjxpTLcQ/5x6FIqarDqkzOAeIoReK2cd3
         2iScRflhDV3NXO4tFnqaPTFg+EY0LAYF88/teiMDF2Z68zjL9aCmM2oZvxtcswF7LDxq
         OLe9oQH2ZsdJeX47a2KOn7D6Bl57HoVxf9C35RI6iTZi7gpUZQ3sHjtJvG1o4skTTIZ/
         jUGCOxj/wRlnjzqrY7TLG+g9Gozmn9daOlLhnLYmMiAgxdd8Lc4t3NipiDqWMc/Nln3b
         EkdXxBPPohhY+vL+AiF9piQ/qz68F6DK3k7cC0xiMzoyYok63RzoqjUDr1QQqGy0VN+d
         UDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUq3Oopc7SuDle4wa0KwRNBtwLPr6vy7HqB4lMHV3wbtTnncFiHPp1Ic1/SAJ62iKGRuSFLMBw1@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy43egE2N6NQ9IyzwXW0QdjbteCa5DHCg6AdaSPu5XOeUfKxFkV
	3yLV6sBQwTr9t9CHHzCutr8A3ht8UlMez2fPJ4FfTEnqOHxHOMeQfp8QHTV5A04=
X-Gm-Gg: ASbGncvQs4iIWCOS/Rs6ef8h4v3HwiX/SjqC0NrkUooUAGVAw3TjVyZNw5OOHqitVOI
	QCA1hQ9anzjRY8bwt2E8B0Azl/2/wid1XWbAspwEZ9IMJ+/vS6Ht1RLNJG5Mf2QjdkPB8oE4qGi
	gJbsro8Goc68RGn6adGSvAysthwyusyR4tnmQ89jg5MoD1WnNLCCctYs09i/2MQ6V0IRz64u5hr
	02Ve671pqfF8ZdybMqd34NZCWVYM0NjCajO1lCUvDMhVpUBj1bHxyaLiXtNKuiuKiFx8hXin0/x
	yeWpfXiE5vlPq/mP8jKdp/4=
X-Google-Smtp-Source: AGHT+IEXbbscWQKIj9vg9IcrTeZmFT8JruBPpooULvlTHrO/2n/FqnL9AzYhLF8En8rfDjb+is5obw==
X-Received: by 2002:a05:600c:35cf:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-438918c6162mr162657195e9.6.1737546693215;
        Wed, 22 Jan 2025 03:51:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 08/14] rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S SoC
Date: Wed, 22 Jan 2025 13:51:13 +0200
Message-ID: <20250122115120.2885015-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17571

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d4488377609e36cd9785533c29ccea4b86c292b9 upstream.

The RTC IP (RTCA-3) available on the Renesas RZ/G3S SoC has calendar count
mode and binary count mode (selectable though RCR2.CNTMD) capabilities,
alarm capabilities, clock error correction capabilities. It can generate
alarm, period, carry interrupts.

Add a driver for RTCA-3 IP. The driver implements calendar count mode (as
the conversion b/w RTC and system time is simpler, done with bcd2bin(),
bin2bcd()), read and set time, read and set alarm, read and set
an offset.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241030110120.332802-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea:
 - dropped references to RTC_DRV_MA35D1 as it is not
   present in v6.1 cip
 - changed return type of rtca3_remove() to int and return 0]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 MAINTAINERS                     |   8 +
 drivers/rtc/Kconfig             |  10 +
 drivers/rtc/Makefile            |   1 +
 drivers/rtc/rtc-renesas-rtca3.c | 901 ++++++++++++++++++++++++++++++++
 4 files changed, 920 insertions(+)
 create mode 100644 drivers/rtc/rtc-renesas-rtca3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90366b990f11..4f5f924124d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17629,6 +17629,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 F:	drivers/counter/rz-mtu3-cnt.c
 
+RENESAS RTCA-3 RTC DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-rtc@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
+F:	drivers/rtc/rtc-renesas-rtca3.c
+
 RENESAS RZ/N1 A5PSW SWITCH DRIVER
 M:	Clément Léger <clement.leger@bootlin.com>
 L:	linux-renesas-soc@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 87dc050ca004..d0ae7f805c84 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1942,6 +1942,16 @@ config RTC_DRV_TI_K3
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-ti-k3".
 
+config RTC_DRV_RENESAS_RTCA3
+	tristate "Renesas RTCA-3 RTC"
+	depends on ARCH_RENESAS
+	help
+	  If you say yes here you get support for the Renesas RTCA-3 RTC
+	  available on the Renesas RZ/G3S SoC.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-rtca3".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index aab22bc63432..4fc1de1987f7 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_RTC_DRV_RX8010)	+= rtc-rx8010.o
 obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
 obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
 obj-$(CONFIG_RTC_DRV_RZN1)	+= rtc-rzn1.o
+obj-$(CONFIG_RTC_DRV_RENESAS_RTCA3)	+= rtc-renesas-rtca3.o
 obj-$(CONFIG_RTC_DRV_S35390A)	+= rtc-s35390a.o
 obj-$(CONFIG_RTC_DRV_S3C)	+= rtc-s3c.o
 obj-$(CONFIG_RTC_DRV_S5M)	+= rtc-s5m.o
diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
new file mode 100644
index 000000000000..7683df87eafa
--- /dev/null
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -0,0 +1,901 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * On-Chip RTC Support available on RZ/G3S SoC
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#include <linux/bcd.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+
+/* Counter registers. */
+#define RTCA3_RSECCNT			0x2
+#define RTCA3_RSECCNT_SEC		GENMASK(6, 0)
+#define RTCA3_RMINCNT			0x4
+#define RTCA3_RMINCNT_MIN		GENMASK(6, 0)
+#define RTCA3_RHRCNT			0x6
+#define RTCA3_RHRCNT_HR			GENMASK(5, 0)
+#define RTCA3_RHRCNT_PM			BIT(6)
+#define RTCA3_RWKCNT			0x8
+#define RTCA3_RWKCNT_WK			GENMASK(2, 0)
+#define RTCA3_RDAYCNT			0xa
+#define RTCA3_RDAYCNT_DAY		GENMASK(5, 0)
+#define RTCA3_RMONCNT			0xc
+#define RTCA3_RMONCNT_MONTH		GENMASK(4, 0)
+#define RTCA3_RYRCNT			0xe
+#define RTCA3_RYRCNT_YEAR		GENMASK(7, 0)
+
+/* Alarm registers. */
+#define RTCA3_RSECAR			0x10
+#define RTCA3_RSECAR_SEC		GENMASK(6, 0)
+#define RTCA3_RMINAR			0x12
+#define RTCA3_RMINAR_MIN		GENMASK(6, 0)
+#define RTCA3_RHRAR			0x14
+#define RTCA3_RHRAR_HR			GENMASK(5, 0)
+#define RTCA3_RHRAR_PM			BIT(6)
+#define RTCA3_RWKAR			0x16
+#define RTCA3_RWKAR_DAYW		GENMASK(2, 0)
+#define RTCA3_RDAYAR			0x18
+#define RTCA3_RDAYAR_DATE		GENMASK(5, 0)
+#define RTCA3_RMONAR			0x1a
+#define RTCA3_RMONAR_MON		GENMASK(4, 0)
+#define RTCA3_RYRAR			0x1c
+#define RTCA3_RYRAR_YR			GENMASK(7, 0)
+#define RTCA3_RYRAREN			0x1e
+
+/* Alarm enable bit (for all alarm registers). */
+#define RTCA3_AR_ENB			BIT(7)
+
+/* Control registers. */
+#define RTCA3_RCR1			0x22
+#define RTCA3_RCR1_AIE			BIT(0)
+#define RTCA3_RCR1_CIE			BIT(1)
+#define RTCA3_RCR1_PIE			BIT(2)
+#define RTCA3_RCR1_PES			GENMASK(7, 4)
+#define RTCA3_RCR1_PES_1_64_SEC		0x8
+#define RTCA3_RCR2			0x24
+#define RTCA3_RCR2_START		BIT(0)
+#define RTCA3_RCR2_RESET		BIT(1)
+#define RTCA3_RCR2_AADJE		BIT(4)
+#define RTCA3_RCR2_ADJP			BIT(5)
+#define RTCA3_RCR2_HR24			BIT(6)
+#define RTCA3_RCR2_CNTMD		BIT(7)
+#define RTCA3_RSR			0x20
+#define RTCA3_RSR_AF			BIT(0)
+#define RTCA3_RSR_CF			BIT(1)
+#define RTCA3_RSR_PF			BIT(2)
+#define RTCA3_RADJ			0x2e
+#define RTCA3_RADJ_ADJ			GENMASK(5, 0)
+#define RTCA3_RADJ_ADJ_MAX		0x3f
+#define RTCA3_RADJ_PMADJ		GENMASK(7, 6)
+#define RTCA3_RADJ_PMADJ_NONE		0
+#define RTCA3_RADJ_PMADJ_ADD		1
+#define RTCA3_RADJ_PMADJ_SUB		2
+
+/* Polling operation timeouts. */
+#define RTCA3_DEFAULT_TIMEOUT_US	150
+#define RTCA3_IRQSET_TIMEOUT_US		5000
+#define RTCA3_START_TIMEOUT_US		150000
+#define RTCA3_RESET_TIMEOUT_US		200000
+
+/**
+ * enum rtca3_alrm_set_step - RTCA3 alarm set steps
+ * @RTCA3_ALRM_SSTEP_DONE: alarm setup done step
+ * @RTCA3_ALRM_SSTEP_IRQ: two 1/64 periodic IRQs were generated step
+ * @RTCA3_ALRM_SSTEP_INIT: alarm setup initialization step
+ */
+enum rtca3_alrm_set_step {
+	RTCA3_ALRM_SSTEP_DONE = 0,
+	RTCA3_ALRM_SSTEP_IRQ = 1,
+	RTCA3_ALRM_SSTEP_INIT = 3,
+};
+
+/**
+ * struct rtca3_ppb_per_cycle - PPB per cycle
+ * @ten_sec: PPB per cycle in 10 seconds adjutment mode
+ * @sixty_sec: PPB per cycle in 60 seconds adjustment mode
+ */
+struct rtca3_ppb_per_cycle {
+	int ten_sec;
+	int sixty_sec;
+};
+
+/**
+ * struct rtca3_priv - RTCA3 private data structure
+ * @base: base address
+ * @rtc_dev: RTC device
+ * @rstc: reset control
+ * @set_alarm_completion: alarm setup completion
+ * @alrm_sstep: alarm setup step (see enum rtca3_alrm_set_step)
+ * @lock: device lock
+ * @ppb: ppb per cycle for each the available adjustment modes
+ * @wakeup_irq: wakeup IRQ
+ */
+struct rtca3_priv {
+	void __iomem *base;
+	struct rtc_device *rtc_dev;
+	struct reset_control *rstc;
+	struct completion set_alarm_completion;
+	atomic_t alrm_sstep;
+	spinlock_t lock;
+	struct rtca3_ppb_per_cycle ppb;
+	int wakeup_irq;
+};
+
+static void rtca3_byte_update_bits(struct rtca3_priv *priv, u8 off, u8 mask, u8 val)
+{
+	u8 tmp;
+
+	tmp = readb(priv->base + off);
+	tmp &= ~mask;
+	tmp |= (val & mask);
+	writeb(tmp, priv->base + off);
+}
+
+static u8 rtca3_alarm_handler_helper(struct rtca3_priv *priv)
+{
+	u8 val, pending;
+
+	val = readb(priv->base + RTCA3_RSR);
+	pending = val & RTCA3_RSR_AF;
+	writeb(val & ~pending, priv->base + RTCA3_RSR);
+
+	if (pending)
+		rtc_update_irq(priv->rtc_dev, 1, RTC_AF | RTC_IRQF);
+
+	return pending;
+}
+
+static irqreturn_t rtca3_alarm_handler(int irq, void *dev_id)
+{
+	struct rtca3_priv *priv = dev_id;
+	u8 pending;
+
+	guard(spinlock)(&priv->lock);
+
+	pending = rtca3_alarm_handler_helper(priv);
+
+	return IRQ_RETVAL(pending);
+}
+
+static irqreturn_t rtca3_periodic_handler(int irq, void *dev_id)
+{
+	struct rtca3_priv *priv = dev_id;
+	u8 val, pending;
+
+	guard(spinlock)(&priv->lock);
+
+	val = readb(priv->base + RTCA3_RSR);
+	pending = val & RTCA3_RSR_PF;
+
+	if (pending) {
+		writeb(val & ~pending, priv->base + RTCA3_RSR);
+
+		if (atomic_read(&priv->alrm_sstep) > RTCA3_ALRM_SSTEP_IRQ) {
+			/* Alarm setup in progress. */
+			atomic_dec(&priv->alrm_sstep);
+
+			if (atomic_read(&priv->alrm_sstep) == RTCA3_ALRM_SSTEP_IRQ) {
+				/*
+				 * We got 2 * 1/64 periodic interrupts. Disable
+				 * interrupt and let alarm setup continue.
+				 */
+				rtca3_byte_update_bits(priv, RTCA3_RCR1,
+						       RTCA3_RCR1_PIE, 0);
+				readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, val,
+							  !(val & RTCA3_RCR1_PIE),
+							  10, RTCA3_DEFAULT_TIMEOUT_US);
+				complete(&priv->set_alarm_completion);
+			}
+		}
+	}
+
+	return IRQ_RETVAL(pending);
+}
+
+static void rtca3_prepare_cntalrm_regs_for_read(struct rtca3_priv *priv, bool cnt)
+{
+	/* Offset b/w time and alarm registers. */
+	u8 offset = cnt ? 0 : 0xe;
+
+	/*
+	 * According to HW manual (section 22.6.4. Notes on writing to and
+	 * reading from registers) after writing to count registers, alarm
+	 * registers, year alarm enable register, bits RCR2.AADJE, AADJP,
+	 * and HR24 register, we need to do 3 empty reads before being
+	 * able to fetch the registers content.
+	 */
+	for (u8 i = 0; i < 3; i++) {
+		readb(priv->base + RTCA3_RSECCNT + offset);
+		readb(priv->base + RTCA3_RMINCNT + offset);
+		readb(priv->base + RTCA3_RHRCNT  + offset);
+		readb(priv->base + RTCA3_RWKCNT  + offset);
+		readb(priv->base + RTCA3_RDAYCNT + offset);
+		readw(priv->base + RTCA3_RYRCNT  + offset);
+		if (!cnt)
+			readb(priv->base + RTCA3_RYRAREN);
+	}
+}
+
+static int rtca3_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	u8 sec, min, hour, wday, mday, month, tmp;
+	u8 trials = 0;
+	u32 year100;
+	u16 year;
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	tmp = readb(priv->base + RTCA3_RCR2);
+	if (!(tmp & RTCA3_RCR2_START))
+		return -EINVAL;
+
+	do {
+		/* Clear carry interrupt. */
+		rtca3_byte_update_bits(priv, RTCA3_RSR, RTCA3_RSR_CF, 0);
+
+		/* Read counters. */
+		sec = readb(priv->base + RTCA3_RSECCNT);
+		min = readb(priv->base + RTCA3_RMINCNT);
+		hour = readb(priv->base + RTCA3_RHRCNT);
+		wday = readb(priv->base + RTCA3_RWKCNT);
+		mday = readb(priv->base + RTCA3_RDAYCNT);
+		month = readb(priv->base + RTCA3_RMONCNT);
+		year = readw(priv->base + RTCA3_RYRCNT);
+
+		tmp = readb(priv->base + RTCA3_RSR);
+
+		/*
+		 * We cannot generate carries due to reading 64Hz counter as
+		 * the driver doesn't implement carry, thus, carries will be
+		 * generated once per seconds. Add a timeout of 5 trials here
+		 * to avoid infinite loop, if any.
+		 */
+	} while ((tmp & RTCA3_RSR_CF) && ++trials < 5);
+
+	if (trials >= 5)
+		return -ETIMEDOUT;
+
+	tm->tm_sec = bcd2bin(FIELD_GET(RTCA3_RSECCNT_SEC, sec));
+	tm->tm_min = bcd2bin(FIELD_GET(RTCA3_RMINCNT_MIN, min));
+	tm->tm_hour = bcd2bin(FIELD_GET(RTCA3_RHRCNT_HR, hour));
+	tm->tm_wday = bcd2bin(FIELD_GET(RTCA3_RWKCNT_WK, wday));
+	tm->tm_mday = bcd2bin(FIELD_GET(RTCA3_RDAYCNT_DAY, mday));
+	tm->tm_mon = bcd2bin(FIELD_GET(RTCA3_RMONCNT_MONTH, month)) - 1;
+	year = FIELD_GET(RTCA3_RYRCNT_YEAR, year);
+	year100 = bcd2bin((year == 0x99) ? 0x19 : 0x20);
+	tm->tm_year = (year100 * 100 + bcd2bin(year)) - 1900;
+
+	return 0;
+}
+
+static int rtca3_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	u8 rcr2, tmp;
+	int ret;
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	/* Stop the RTC. */
+	rcr2 = readb(priv->base + RTCA3_RCR2);
+	writeb(rcr2 & ~RTCA3_RCR2_START, priv->base + RTCA3_RCR2);
+	ret = readb_poll_timeout_atomic(priv->base + RTCA3_RCR2, tmp,
+					!(tmp & RTCA3_RCR2_START),
+					10, RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/* Update time. */
+	writeb(bin2bcd(tm->tm_sec), priv->base + RTCA3_RSECCNT);
+	writeb(bin2bcd(tm->tm_min), priv->base + RTCA3_RMINCNT);
+	writeb(bin2bcd(tm->tm_hour), priv->base + RTCA3_RHRCNT);
+	writeb(bin2bcd(tm->tm_wday), priv->base + RTCA3_RWKCNT);
+	writeb(bin2bcd(tm->tm_mday), priv->base + RTCA3_RDAYCNT);
+	writeb(bin2bcd(tm->tm_mon + 1), priv->base + RTCA3_RMONCNT);
+	writew(bin2bcd(tm->tm_year % 100), priv->base + RTCA3_RYRCNT);
+
+	/* Make sure we can read back the counters. */
+	rtca3_prepare_cntalrm_regs_for_read(priv, true);
+
+	/* Start RTC. */
+	writeb(rcr2 | RTCA3_RCR2_START, priv->base + RTCA3_RCR2);
+	return readb_poll_timeout_atomic(priv->base + RTCA3_RCR2, tmp,
+					 (tmp & RTCA3_RCR2_START),
+					 10, RTCA3_DEFAULT_TIMEOUT_US);
+}
+
+static int rtca3_alarm_irq_set_helper(struct rtca3_priv *priv,
+				      u8 interrupts,
+				      unsigned int enabled)
+{
+	u8 tmp, val;
+
+	if (enabled) {
+		/*
+		 * AIE, CIE, PIE bit indexes in RSR corresponds with
+		 * those on RCR1. Same interrupts mask can be used.
+		 */
+		rtca3_byte_update_bits(priv, RTCA3_RSR, interrupts, 0);
+		val = interrupts;
+	} else {
+		val = 0;
+	}
+
+	rtca3_byte_update_bits(priv, RTCA3_RCR1, interrupts, val);
+	return readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp,
+					 ((tmp & interrupts) == val),
+					 10, RTCA3_IRQSET_TIMEOUT_US);
+}
+
+static int rtca3_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	return rtca3_alarm_irq_set_helper(priv, RTCA3_RCR1_AIE, enabled);
+}
+
+static int rtca3_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	u8 sec, min, hour, wday, mday, month;
+	struct rtc_time *tm = &wkalrm->time;
+	u32 year100;
+	u16 year;
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	sec = readb(priv->base + RTCA3_RSECAR);
+	min = readb(priv->base + RTCA3_RMINAR);
+	hour = readb(priv->base + RTCA3_RHRAR);
+	wday = readb(priv->base + RTCA3_RWKAR);
+	mday = readb(priv->base + RTCA3_RDAYAR);
+	month = readb(priv->base + RTCA3_RMONAR);
+	year = readw(priv->base + RTCA3_RYRAR);
+
+	tm->tm_sec = bcd2bin(FIELD_GET(RTCA3_RSECAR_SEC, sec));
+	tm->tm_min = bcd2bin(FIELD_GET(RTCA3_RMINAR_MIN, min));
+	tm->tm_hour = bcd2bin(FIELD_GET(RTCA3_RHRAR_HR, hour));
+	tm->tm_wday = bcd2bin(FIELD_GET(RTCA3_RWKAR_DAYW, wday));
+	tm->tm_mday = bcd2bin(FIELD_GET(RTCA3_RDAYAR_DATE, mday));
+	tm->tm_mon = bcd2bin(FIELD_GET(RTCA3_RMONAR_MON, month)) - 1;
+	year = FIELD_GET(RTCA3_RYRAR_YR, year);
+	year100 = bcd2bin((year == 0x99) ? 0x19 : 0x20);
+	tm->tm_year = (year100 * 100 + bcd2bin(year)) - 1900;
+
+	wkalrm->enabled = !!(readb(priv->base + RTCA3_RCR1) & RTCA3_RCR1_AIE);
+
+	return 0;
+}
+
+static int rtca3_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	struct rtc_time *tm = &wkalrm->time;
+	u8 rcr1, tmp;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &priv->lock) {
+		tmp = readb(priv->base + RTCA3_RCR2);
+		if (!(tmp & RTCA3_RCR2_START))
+			return -EPERM;
+
+		/* Disable AIE to prevent false interrupts. */
+		rcr1 = readb(priv->base + RTCA3_RCR1);
+		rcr1 &= ~RTCA3_RCR1_AIE;
+		writeb(rcr1, priv->base + RTCA3_RCR1);
+		ret = readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp,
+						!(tmp & RTCA3_RCR1_AIE),
+						10, RTCA3_DEFAULT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		/* Set the time and enable the alarm. */
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_sec), priv->base + RTCA3_RSECAR);
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_min), priv->base + RTCA3_RMINAR);
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_hour), priv->base + RTCA3_RHRAR);
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_wday), priv->base + RTCA3_RWKAR);
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_mday), priv->base + RTCA3_RDAYAR);
+		writeb(RTCA3_AR_ENB | bin2bcd(tm->tm_mon + 1), priv->base + RTCA3_RMONAR);
+
+		writew(bin2bcd(tm->tm_year % 100), priv->base + RTCA3_RYRAR);
+		writeb(RTCA3_AR_ENB, priv->base + RTCA3_RYRAREN);
+
+		/* Make sure we can read back the counters. */
+		rtca3_prepare_cntalrm_regs_for_read(priv, false);
+
+		/* Need to wait for 2 * 1/64 periodic interrupts to be generated. */
+		atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_INIT);
+		reinit_completion(&priv->set_alarm_completion);
+
+		/* Enable periodic interrupt. */
+		rcr1 |= RTCA3_RCR1_PIE;
+		writeb(rcr1, priv->base + RTCA3_RCR1);
+		ret = readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp,
+						(tmp & RTCA3_RCR1_PIE),
+						10, RTCA3_IRQSET_TIMEOUT_US);
+	}
+
+	if (ret)
+		goto setup_failed;
+
+	/* Wait for the 2 * 1/64 periodic interrupts. */
+	ret = wait_for_completion_interruptible_timeout(&priv->set_alarm_completion,
+							msecs_to_jiffies(500));
+	if (ret <= 0) {
+		ret = -ETIMEDOUT;
+		goto setup_failed;
+	}
+
+	scoped_guard(spinlock_irqsave, &priv->lock) {
+		ret = rtca3_alarm_irq_set_helper(priv, RTCA3_RCR1_AIE, wkalrm->enabled);
+		atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_DONE);
+	}
+
+	return ret;
+
+setup_failed:
+	scoped_guard(spinlock_irqsave, &priv->lock) {
+		/*
+		 * Disable PIE to avoid interrupt storm in case HW needed more than
+		 * specified timeout for setup.
+		 */
+		writeb(rcr1 & ~RTCA3_RCR1_PIE, priv->base + RTCA3_RCR1);
+		readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp, !(tmp & ~RTCA3_RCR1_PIE),
+					  10, RTCA3_DEFAULT_TIMEOUT_US);
+		atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_DONE);
+	}
+
+	return ret;
+}
+
+static int rtca3_read_offset(struct device *dev, long *offset)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	u8 val, radj, cycles;
+	u32 ppb_per_cycle;
+
+	scoped_guard(spinlock_irqsave, &priv->lock) {
+		radj = readb(priv->base + RTCA3_RADJ);
+		val = readb(priv->base + RTCA3_RCR2);
+	}
+
+	cycles = FIELD_GET(RTCA3_RADJ_ADJ, radj);
+
+	if (!cycles) {
+		*offset = 0;
+		return 0;
+	}
+
+	if (val & RTCA3_RCR2_ADJP)
+		ppb_per_cycle = priv->ppb.ten_sec;
+	else
+		ppb_per_cycle = priv->ppb.sixty_sec;
+
+	*offset = cycles * ppb_per_cycle;
+	val = FIELD_GET(RTCA3_RADJ_PMADJ, radj);
+	if (val == RTCA3_RADJ_PMADJ_SUB)
+		*offset = -(*offset);
+
+	return 0;
+}
+
+static int rtca3_set_offset(struct device *dev, long offset)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	int cycles, cycles10, cycles60;
+	u8 radj, adjp, tmp;
+	int ret;
+
+	/*
+	 * Automatic time error adjustment could be set at intervals of 10
+	 * or 60 seconds.
+	 */
+	cycles10 = DIV_ROUND_CLOSEST(offset, priv->ppb.ten_sec);
+	cycles60 = DIV_ROUND_CLOSEST(offset, priv->ppb.sixty_sec);
+
+	/* We can set b/w 1 and 63 clock cycles. */
+	if (cycles60 >= -RTCA3_RADJ_ADJ_MAX &&
+	    cycles60 <= RTCA3_RADJ_ADJ_MAX) {
+		cycles = cycles60;
+		adjp = 0;
+	} else if (cycles10 >= -RTCA3_RADJ_ADJ_MAX &&
+		   cycles10 <= RTCA3_RADJ_ADJ_MAX) {
+		cycles = cycles10;
+		adjp = RTCA3_RCR2_ADJP;
+	} else {
+		return -ERANGE;
+	}
+
+	radj = FIELD_PREP(RTCA3_RADJ_ADJ, abs(cycles));
+	if (!cycles)
+		radj |= FIELD_PREP(RTCA3_RADJ_PMADJ, RTCA3_RADJ_PMADJ_NONE);
+	else if (cycles > 0)
+		radj |= FIELD_PREP(RTCA3_RADJ_PMADJ, RTCA3_RADJ_PMADJ_ADD);
+	else
+		radj |= FIELD_PREP(RTCA3_RADJ_PMADJ, RTCA3_RADJ_PMADJ_SUB);
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	tmp = readb(priv->base + RTCA3_RCR2);
+
+	if ((tmp & RTCA3_RCR2_ADJP) != adjp) {
+		/* RADJ.PMADJ need to be set to zero before setting RCR2.ADJP. */
+		writeb(0, priv->base + RTCA3_RADJ);
+		ret = readb_poll_timeout_atomic(priv->base + RTCA3_RADJ, tmp, !tmp,
+						10, RTCA3_DEFAULT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		rtca3_byte_update_bits(priv, RTCA3_RCR2, RTCA3_RCR2_ADJP, adjp);
+		ret = readb_poll_timeout_atomic(priv->base + RTCA3_RCR2, tmp,
+						((tmp & RTCA3_RCR2_ADJP) == adjp),
+						10, RTCA3_DEFAULT_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
+
+	writeb(radj, priv->base + RTCA3_RADJ);
+	return readb_poll_timeout_atomic(priv->base + RTCA3_RADJ, tmp, (tmp == radj),
+					 10, RTCA3_DEFAULT_TIMEOUT_US);
+}
+
+static const struct rtc_class_ops rtca3_ops = {
+	.read_time = rtca3_read_time,
+	.set_time = rtca3_set_time,
+	.read_alarm = rtca3_read_alarm,
+	.set_alarm = rtca3_set_alarm,
+	.alarm_irq_enable = rtca3_alarm_irq_enable,
+	.set_offset = rtca3_set_offset,
+	.read_offset = rtca3_read_offset,
+};
+
+static int rtca3_initial_setup(struct clk *clk, struct rtca3_priv *priv)
+{
+	unsigned long osc32k_rate;
+	u8 val, tmp, mask;
+	u32 sleep_us;
+	int ret;
+
+	osc32k_rate = clk_get_rate(clk);
+	if (!osc32k_rate)
+		return -EINVAL;
+
+	sleep_us = DIV_ROUND_UP_ULL(1000000ULL, osc32k_rate) * 6;
+
+	priv->ppb.ten_sec = DIV_ROUND_CLOSEST_ULL(1000000000ULL, (osc32k_rate * 10));
+	priv->ppb.sixty_sec = DIV_ROUND_CLOSEST_ULL(1000000000ULL, (osc32k_rate * 60));
+
+	/*
+	 * According to HW manual (section 22.4.2. Clock and count mode setting procedure)
+	 * we need to wait at least 6 cycles of the 32KHz clock after clock was enabled.
+	 */
+	usleep_range(sleep_us, sleep_us + 10);
+
+	/* Disable all interrupts. */
+	mask = RTCA3_RCR1_AIE | RTCA3_RCR1_CIE | RTCA3_RCR1_PIE;
+	ret = rtca3_alarm_irq_set_helper(priv, mask, 0);
+	if (ret)
+		return ret;
+
+	mask = RTCA3_RCR2_START | RTCA3_RCR2_HR24;
+	val = readb(priv->base + RTCA3_RCR2);
+	/* Nothing to do if already started in 24 hours and calendar count mode. */
+	if ((val & mask) == mask)
+		return 0;
+
+	/* Reconfigure the RTC in 24 hours and calendar count mode. */
+	mask = RTCA3_RCR2_START | RTCA3_RCR2_CNTMD;
+	writeb(0, priv->base + RTCA3_RCR2);
+	ret = readb_poll_timeout(priv->base + RTCA3_RCR2, tmp, !(tmp & mask),
+				 10, RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set 24 hours mode. According to HW manual (section 22.3.19. RTC Control
+	 * Register 2) this needs to be done separate from stop operation.
+	 */
+	mask = RTCA3_RCR2_HR24;
+	val = RTCA3_RCR2_HR24;
+	writeb(val, priv->base + RTCA3_RCR2);
+	ret = readb_poll_timeout(priv->base + RTCA3_RCR2, tmp, (tmp & mask),
+				 10, RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/* Execute reset. */
+	mask = RTCA3_RCR2_RESET;
+	writeb(val | RTCA3_RCR2_RESET, priv->base + RTCA3_RCR2);
+	ret = readb_poll_timeout(priv->base + RTCA3_RCR2, tmp, !(tmp & mask),
+				 10, RTCA3_RESET_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/*
+	 * According to HW manual (section 22.6.3. Notes on writing to and reading
+	 * from registers) after reset we need to wait 6 clock cycles before
+	 * writing to RTC registers.
+	 */
+	usleep_range(sleep_us, sleep_us + 10);
+
+	/* Set no adjustment. */
+	writeb(0, priv->base + RTCA3_RADJ);
+	ret = readb_poll_timeout(priv->base + RTCA3_RADJ, tmp, !tmp, 10,
+				 RTCA3_DEFAULT_TIMEOUT_US);
+
+	/* Start the RTC and enable automatic time error adjustment. */
+	mask = RTCA3_RCR2_START | RTCA3_RCR2_AADJE;
+	val |= RTCA3_RCR2_START | RTCA3_RCR2_AADJE;
+	writeb(val, priv->base + RTCA3_RCR2);
+	ret = readb_poll_timeout(priv->base + RTCA3_RCR2, tmp, ((tmp & mask) == mask),
+				 10, RTCA3_START_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/*
+	 * According to HW manual (section 22.6.4. Notes on writing to and reading
+	 * from registers) we need to wait 1/128 seconds while the clock is operating
+	 * (RCR2.START bit = 1) to be able to read the counters after a return from
+	 * reset.
+	 */
+	usleep_range(8000, 9000);
+
+	/* Set period interrupt to 1/64 seconds. It is necessary for alarm setup. */
+	val = FIELD_PREP(RTCA3_RCR1_PES, RTCA3_RCR1_PES_1_64_SEC);
+	rtca3_byte_update_bits(priv, RTCA3_RCR1, RTCA3_RCR1_PES, val);
+	return readb_poll_timeout(priv->base + RTCA3_RCR1, tmp, ((tmp & RTCA3_RCR1_PES) == val),
+				  10, RTCA3_DEFAULT_TIMEOUT_US);
+}
+
+static int rtca3_request_irqs(struct platform_device *pdev, struct rtca3_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	int ret, irq;
+
+	irq = platform_get_irq_byname(pdev, "alarm");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get alarm IRQ!\n");
+
+	ret = devm_request_irq(dev, irq, rtca3_alarm_handler, 0, "rtca3-alarm", priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request alarm IRQ!\n");
+	priv->wakeup_irq = irq;
+
+	irq = platform_get_irq_byname(pdev, "period");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get period IRQ!\n");
+
+	ret = devm_request_irq(dev, irq, rtca3_periodic_handler, 0, "rtca3-period", priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request period IRQ!\n");
+
+	/*
+	 * Driver doesn't implement carry handler. Just get the IRQ here
+	 * for backward compatibility, in case carry support will be added later.
+	 */
+	irq = platform_get_irq_byname(pdev, "carry");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get carry IRQ!\n");
+
+	return 0;
+}
+
+static void rtca3_action(void *data)
+{
+	struct device *dev = data;
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		dev_err(dev, "Failed to de-assert reset!");
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_err(dev, "Failed to runtime suspend!");
+}
+
+static int rtca3_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rtca3_priv *priv;
+	struct clk *clk;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	priv->rstc = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return PTR_ERR(priv->rstc);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret) {
+		pm_runtime_put_sync(dev);
+		return ret;
+	}
+
+	dev_set_drvdata(dev, priv);
+	ret = devm_add_action_or_reset(dev, rtca3_action, dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * This must be an always-on clock to keep the RTC running even after
+	 * driver is unbinded.
+	 */
+	clk = devm_clk_get_enabled(dev, "counter");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	spin_lock_init(&priv->lock);
+	atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_DONE);
+	init_completion(&priv->set_alarm_completion);
+
+	ret = rtca3_initial_setup(clk, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup the RTC!\n");
+
+	ret = rtca3_request_irqs(pdev, priv);
+	if (ret)
+		return ret;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	priv->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(priv->rtc_dev))
+		return PTR_ERR(priv->rtc_dev);
+
+	priv->rtc_dev->ops = &rtca3_ops;
+	priv->rtc_dev->max_user_freq = 256;
+	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
+
+	return devm_rtc_register_device(priv->rtc_dev);
+}
+
+static int rtca3_remove(struct platform_device *pdev)
+{
+	struct rtca3_priv *priv = platform_get_drvdata(pdev);
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	/*
+	 * Disable alarm, periodic interrupts. The RTC device cannot
+	 * power up the system.
+	 */
+	rtca3_alarm_irq_set_helper(priv, RTCA3_RCR1_AIE | RTCA3_RCR1_PIE, 0);
+
+	return 0;
+}
+
+static int rtca3_suspend(struct device *dev)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	/* Alarm setup in progress. */
+	if (atomic_read(&priv->alrm_sstep) != RTCA3_ALRM_SSTEP_DONE)
+		return -EBUSY;
+
+	enable_irq_wake(priv->wakeup_irq);
+
+	return 0;
+}
+
+static int rtca3_clean_alarm(struct rtca3_priv *priv)
+{
+	struct rtc_device *rtc_dev = priv->rtc_dev;
+	time64_t alarm_time, now;
+	struct rtc_wkalrm alarm;
+	struct rtc_time tm;
+	u8 pending;
+	int ret;
+
+	ret = rtc_read_alarm(rtc_dev, &alarm);
+	if (ret)
+		return ret;
+
+	if (!alarm.enabled)
+		return 0;
+
+	ret = rtc_read_time(rtc_dev, &tm);
+	if (ret)
+		return ret;
+
+	alarm_time = rtc_tm_to_time64(&alarm.time);
+	now = rtc_tm_to_time64(&tm);
+	if (alarm_time >= now)
+		return 0;
+
+	/*
+	 * Heuristically, it has been determined that when returning from deep
+	 * sleep state the RTCA3_RSR.AF is zero even though the alarm expired.
+	 * Call again the rtc_update_irq() if alarm helper detects this.
+	 */
+
+	guard(spinlock_irqsave)(&priv->lock);
+
+	pending = rtca3_alarm_handler_helper(priv);
+	if (!pending)
+		rtc_update_irq(priv->rtc_dev, 1, RTC_AF | RTC_IRQF);
+
+	return 0;
+}
+
+static int rtca3_resume(struct device *dev)
+{
+	struct rtca3_priv *priv = dev_get_drvdata(dev);
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	disable_irq_wake(priv->wakeup_irq);
+
+	/*
+	 * According to the HW manual (section 22.6.4 Notes on writing to
+	 * and reading from registers) we need to wait 1/128 seconds while
+	 * RCR2.START = 1 to be able to read the counters after a return from low
+	 * power consumption state.
+	 */
+	mdelay(8);
+
+	/*
+	 * The alarm cannot wake the system from deep sleep states. In case
+	 * we return from deep sleep states and the alarm expired we need
+	 * to disable it to avoid failures when setting another alarm.
+	 */
+	return rtca3_clean_alarm(priv);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rtca3_pm_ops, rtca3_suspend, rtca3_resume);
+
+static const struct of_device_id rtca3_of_match[] = {
+	{ .compatible = "renesas,rz-rtca3", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtca3_of_match);
+
+static struct platform_driver rtca3_platform_driver = {
+	.driver = {
+		.name = "rtc-rtca3",
+		.pm = pm_ptr(&rtca3_pm_ops),
+		.of_match_table = rtca3_of_match,
+	},
+	.probe = rtca3_probe,
+	.remove = rtca3_remove,
+};
+module_platform_driver(rtca3_platform_driver);
+
+MODULE_DESCRIPTION("Renesas RTCA-3 RTC driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


