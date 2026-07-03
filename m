Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0F1C44511
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90777.1783076370874367259
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=et2m0Gsm;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4629051c946so286866f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076369; x=1783681169; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0ikge4Ltl97yJ34zNSsymCdVOz1OJrqYl4a3szhAgc=;
        b=et2m0GsmuZoHaWEJmQ5UFqHckiwp/rThMznKY/wQzsNwMr+ysjoKjfcuA+zjeR6h9T
         G+4465bI21JIl31LBbZyvIcEhrkCFzm9+1MvzOP2SVxQIKStKPJXHC3iqsm8djrEXS2j
         9OgeCPVjWHpPKFeN1UO4/+R2X5YSgyrsBBk0sruxjABztK1NtDNUk0xHs7YApG5W671x
         5idVzYoLw4zRoW6ktfZPo90HWRQVtnEQkXNyV/qe+R8VYmvRVMAKpz5lNTDtppOFQv+2
         5Kka+KJkOi0Irlgy6aCKHmo+oCYAiy8CO6NDnsQc2/KF9ftbvNWtfJJGTHZv0k3Hp8xF
         pDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076369; x=1783681169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0ikge4Ltl97yJ34zNSsymCdVOz1OJrqYl4a3szhAgc=;
        b=HHcOgwqKDflVbuvFFYVMvZCvgBLlOQhbvocez0IRZSx0kFZq5NT7HGe4bWXwqVWUIZ
         LSend2hFZ2Sf05oZAklcGr1TT1IgAhCVkzr/rMatNU3ikwdQI49suJ7Fjzpnp4ICal6c
         amnWf/pRcUFYU3LRqOqk3YCC85bW2KgAiHY616y9ZW6GjJTu2W4kTlZr+ZldyFwQj74D
         WVyekwuj17HseUL0w9Xl6BzOak4658Du8b/GFyYmH3CTO/Yjnq5+9yJhj9BH7aBYScA5
         5IZsRmLYMafc9cSZgZ2T+Udt1mE1KomtvewRgxSqenzc0Au+aCxUueP+4zKN3xTQ7LHs
         M0aQ==
X-Gm-Message-State: AOJu0YwzH1s/pLXgRvw7+kZA1joLp1hJWGXFC+hoHPKfs7i1PVXdEr0Y
	25lgAlCp3rnDeWpdQ9Ho7jziWKFJvBdu7vHFJp21yQyoGUtWmbQweJWXaigyKzAO
X-Gm-Gg: AfdE7cm36sbmC2LRhPLtbO9gXnv4I7WDF1R0lkVmfv9qmh32P6tSVDdii9T0QQIlkhY
	XuKWgR289s/RuenNlkIsx6ML1Z8EMUkSE00A7rC0HdmnLtmOu4Yu58hprXribAtHrwS2OnsFIq+
	LS57dEzSxr2eElC9biYPEu279ooyjCmhMWyTUbCRO2nYcyBcDIhPbWIrw2g76JuXhsMmZIdlfT+
	+88Z90KtgwQm3fkXQsHgQ5inkQPKzUvoGUATgGXjgNDarY9CQHPyWAHrFtB7/nfBeF68hMfBcmV
	aeiN1IlK0s73KEcgNVaOtIVR1LG+N0hNfX0B25TrJE5s8vjkyyhqTkuOMxk5uRHgxF36o9BVtjz
	ETAJhxX5X5hXSrJMhEvKFZzs2aj9PRspK6q0jqmo3hpb29let7VRdvnFSWuLAH+HBC8zp4PewER
	5X6bMnRifOnTljY6uC37M1
X-Received: by 2002:a05:6000:5c3:b0:475:c578:b62f with SMTP id ffacd0b85a97d-479343d1df5mr5175779f8f.5.1783076368948;
        Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/23] pinctrl: renesas: rzg2l: Make QSPI register handling conditional
Date: Fri,  3 Jul 2026 11:59:00 +0100
Message-ID: <20260703105923.251255-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23428

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 55793d3ddf774e9bbeed3c940fb19d6c1124b6d3 ]

The QSPI register at offset 0x3008 is not present on all SoCs supported by
the RZ/G2L pinctrl driver. Unconditionally reading and writing this
register during suspend/resume on hardware that lacks it can cause
undefined behaviour.

Add a qspi field to rzg2l_register_offsets to allow per-SoC declaration of
the QSPI register offset, and guard the suspend/resume accesses with a
check on that field. Populate the offset only for the RZ/{G2L,G2LC,G2UL,
Five} hardware configuration, which is where the register is known to
exist.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f7cb57e26f90..1525dedca76e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -145,7 +145,7 @@
 #define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
-#define QSPI			(0x3008)
+#define QSPI			(0x3008) /* known on RZ/{G2L,G2LC,G2UL,Five} only */
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -220,12 +220,14 @@ static const struct pin_config_item renesas_rzv2h_conf_items[] = {
  * @sd_ch: SD_CH register offset
  * @eth_poc: ETH_POC register offset
  * @oen: OEN register offset
+ * @qspi: QSPI register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
 	u16 eth_poc;
 	u16 oen;
+	u16 qspi;
 };
 
 /**
@@ -3306,7 +3308,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 			cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
 
-	cache->qspi = readb(pctrl->base + QSPI);
+	if (regs->qspi)
+		cache->qspi = readb(pctrl->base + regs->qspi);
 	cache->oen = readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
 
 	if (!atomic_read(&pctrl->wakeup_path))
@@ -3332,7 +3335,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 			return ret;
 	}
 
-	writeb(cache->qspi, pctrl->base + QSPI);
+	if (regs->qspi)
+		writeb(cache->qspi, pctrl->base + regs->qspi);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
@@ -3390,6 +3394,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 		.sd_ch = 0x3000,
 		.eth_poc = 0x300c,
 		.oen = 0x3018,
+		.qspi = QSPI,
 	},
 	.iolh_groupa_ua = {
 		/* 3v3 power source */
-- 
2.43.0


