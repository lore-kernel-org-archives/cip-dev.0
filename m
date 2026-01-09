Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F46D1A608
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8763.1767960987957835683
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: FGUl8yATTE2mJ9FlW3+sew==
X-CSE-MsgGUID: PTqX24FrRBCYYsyzAtsAjg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:32 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 08556401DE03;
	Fri,  9 Jan 2026 21:16:30 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 4/8] rtc: renesas-rtca3: stop setting max_user_freq
Date: Fri,  9 Jan 2026 12:16:18 +0000
Message-ID: <20260109121622.46030-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21511

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 358867b551660ac7d0987fe5fad8518cbfd5e415 upstream.

max_user_freq has not been related to the hardware RTC since commit
6610e0893b8b ("RTC: Rework RTC code to use timerqueue for events"). Stop
setting it from individual driver to avoid confusing new contributors.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251101-max_user_freq-v1-4-c9a274fd6883@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index bd9f809a04ad..b9630c800343 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -772,7 +772,6 @@ static int rtca3_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->rtc_dev);
 
 	priv->rtc_dev->ops = &rtca3_ops;
-	priv->rtc_dev->max_user_freq = 256;
 	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
 
-- 
2.51.0


