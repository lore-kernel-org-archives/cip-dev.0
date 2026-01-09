Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822AD232FF
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8762.1767960986846098294
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: OzF1ai7bSDePf+MsINOJRQ==
X-CSE-MsgGUID: i2zGiWghTPeq7Mea8JFvXQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:33 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9916401DE03;
	Fri,  9 Jan 2026 21:16:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 5/8] rtc: renesas-rtca3: Add support for multiple reset lines
Date: Fri,  9 Jan 2026 12:16:19 +0000
Message-ID: <20260109121622.46030-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21512

commit 6ada8e24238dd57b38faca503b09757e17819b05 upstream.

Switch from devm_reset_control_get_shared() to
devm_reset_control_array_get_shared() when retrieving resets.

The RZ/V2H SoC requires two resets for the RTC block instead of one,
so this will allow to handle multiple resets without additional changes.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251107210706.45044-3-ovidiu.panait.rb@renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index b9630c800343..3c677790d8fa 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -726,7 +726,7 @@ static int rtca3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->rstc = devm_reset_control_get_shared(dev, NULL);
+	priv->rstc = devm_reset_control_array_get_shared(dev);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
-- 
2.51.0


