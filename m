Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D1CDC16B
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88222.1767699912319707570
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fr5Z1GAw;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477770019e4so7349945e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699910; x=1768304710; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnTMdKuuR6sgfpqMf1xBNK0HftY10LQ/IqmXbl3AzQc=;
        b=Fr5Z1GAwiJtYoxlJuWJrLeEt7C8+/UnOIcGS32YKnJv/KXPQcjEooUEsT2oNIa3Bpr
         XWFJ54iYjK2273l9nTNhja+kFY0lYBFE5PnEQYbPnVi/v+O094NeVdAS1dfFEQ+jWckH
         +lI2xXtNKqt9DWcHXEMW5pyLA6XOHbWzAYw9QfchWXXBnw4FeHCvkPghDgEXiGzhvzFp
         APJLpYUp21JlAC44iYcQ0UtJp8o5TmGncUiH1zmzhhZw5lIWGJnJ9f+p4Jij+uBRQQ8G
         cLJExG9s1rgJws22ILJUlxp6KtebTGcAiw7qZTR8Ba4QCNW0bm9DWe1VOQqt9IHUM4Eh
         928g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699910; x=1768304710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnTMdKuuR6sgfpqMf1xBNK0HftY10LQ/IqmXbl3AzQc=;
        b=rcR96yjUxVDOgDF6zwISoAYsKnijxtVSCSocEXKX8h9i8/xA0x9URBUIo5f78M9s/X
         PC860XmipNIbf+GAvO8YJw/6t46eVntfDYufTQJf2b4NlRb1KBdAycq1xFy2Zqt9J56w
         RW3WKYwV0sdP+kTMFGAoQCUqdwJauNxvPxcaqTN0SMhdRVtj0kyLJSJxKEx6bahzZRUj
         4pGtMZrZf9Sbj+hIT5ZExKIQHSo5ah4Z6/CzjBhhoc8Au9TAe7cvZZWgg+rxvSPirddk
         nrlfeVXskaa6gtoBES8mr9AmoTT3srCXFhrSfBKc+Ty+v9L5/gyW3on9OfdhCmF31IeV
         XcbQ==
X-Gm-Message-State: AOJu0YxtBuW0aX8uUt2xd/hdX+grqwu99k1irvjYQFQy4hQNrtAhWTP2
	0fHwetw2PXXP467myVW7ZltxFXZn33XafEU5otXDTYyGhwqy3qfOCGHVyraFQw==
X-Gm-Gg: AY/fxX5Xs2G0VtaeQY0Rhi6XrV/lVH5N4hFL2e7N/ubT7dgOGsOjMMn7JHCFtqGgLRD
	lhUrLYcnOfXWa+CyiK5UbAZxPqDZYPetaF04fAD3ZpL4nhz0SErs2FzOBWdXLaNHIs03UbPta86
	NxUiciqZSuJ3DM9jyIgkQX00yZRoDnJ/+cyfFsunGn/xBvFWWqaaiR0v0584uXw7amOUxU2cjxp
	CzkhU/bMi2QyQzsgL8Jkqa3A9u7QFr/yccWr5cxA1X399b7BHQA8mJfM2R4g3v/XgWoMOZkIdhh
	TjnWw8Wig756ja6RWPjm6RnyXbuYJW20JXeWZr/hiSpoZAoxfT30p2TexTKCpalYXyjm4S5FJ4K
	QNnI/S6P1xbVFqC7dA74gvSTCppBtr/WcLuEi8x0pFOviCZxaI8Yj0qnpCFQk79mUbjrqScTx+a
	k6vyOqf0Cl9pyXmQXLwg==
X-Google-Smtp-Source: AGHT+IHN/ZXdQQCyGI5gelPo5y3derDtoODBZ3VNIIElwKPyaMT4GZPYRux5UQTb3KqAVVKkqi6qyw==
X-Received: by 2002:a05:600c:1d19:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47d7f09ed9fmr27592545e9.28.1767699910461;
        Tue, 06 Jan 2026 03:45:10 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:10 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 23/24] can: rcar_canfd: Add suspend/resume support
Date: Tue,  6 Jan 2026 11:44:46 +0000
Message-ID: <20260106114458.122333-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21355

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3a34330f6339641b7f5b76b066385f56c114490f ]

On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
CAN-FD interface no longer works.  Trying to bring it up again fails:

    # ip link set can0 up
    RTNETLINK answers: Connection timed out

    # dmesg
    ...
    channel 0 communication state failed

Fix this by populating the (currently empty) suspend and resume
callbacks, to stop/start the individual CAN-FD channels, and
(de)initialize the CAN-FD controller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-8-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f6bc3f1cbd63..1cd4835a4742 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2266,11 +2266,64 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 static int rcar_canfd_suspend(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		netif_device_detach(ndev);
+
+		err = rcar_canfd_close(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		priv->can.state = CAN_STATE_SLEEPING;
+	}
+
+	/* TODO Skip if wake-up (which is not yet supported) is enabled */
+	rcar_canfd_global_deinit(gpriv, false);
+
 	return 0;
 }
 
 static int rcar_canfd_resume(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	err = rcar_canfd_global_init(gpriv);
+	if (err) {
+		dev_err(dev, "rcar_canfd_global_init() failed %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		err = rcar_canfd_open(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		netif_device_attach(ndev);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


