Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4EE674A3
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78205.1766402239906818588
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BcimXpxL;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79f98adea4so565153566b.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402238; x=1767007038; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yS4f97N1lNUgSFRpiYOR9Fo1S8DXTsFVnhbdmp0FPs=;
        b=BcimXpxLcQDh2FFL0IeYkS50xStr2NAgHtdZZ4xBf3WYGOq0zTe41AjPSSaxBOhjFq
         fiehWwzXN6eJIlf1SQ0J6aey0/twUJh6KaX18YOO9ZU29uF2V41TUbbz5uWX3Jjr9PTZ
         4xzTE6scVdQvRTU/cb0vo7pt1MGAlSTQUAKtMslu18xXVsIlf/Qr4RN3buCdAMIvcqKn
         Tat9XcCgdNPJExKp9FKtgN2rrXATHo3FQoO3ovSntjN6A7QBM9wCHXnJloPmyyJ0wFo9
         qSMR4g7y7ueE8d3jebQa3ZAH0VEWpnf2CsmMR0iY86W2QeV6ekfmH+zDn01wpKRf452t
         vL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402238; x=1767007038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yS4f97N1lNUgSFRpiYOR9Fo1S8DXTsFVnhbdmp0FPs=;
        b=aK0Zg2wOYRtb58yESXoYbjCXRhKionXOQOpdSjQusJUWU049oDGGoCP9+awXDrw5HW
         xdTzBJedGWq6eBGKOIcquEtPGCq6wUsgQwr/gqoDYEmGXE1ypJPnZ0cZ4Q4Xm3SyTRaO
         ZN1i09UTCZhsZ+/f3Nv778iGIN2m6UkwihlqDK1h9/mUCwvbwocfiNy1Wh3Rf/PbXGrZ
         wtvcY0cQ8lCvVNa5Gdii5rB8TOzilQRj96rwxRwztrp7sc5QBoPW7RDBwiWiNQKpWxD3
         SgBKJsIxidge42MVJd+fFxBeTs1ebhCfAAziBqwJeDerx8t8Nfz+QKUvu97riFnlEzT/
         jrEg==
X-Gm-Message-State: AOJu0YwtPFc/j0mqbR6jtSIIZnvgC6BRojLXmkfZkDLEKJSgwWnBZ9/8
	kMUw/Bjt2ews5ZCxLzDUVCrSy99zqucFQvyntak2vZvRQulXXirAFlxEEe90gA==
X-Gm-Gg: AY/fxX6ZDRAyW6XvHFefxBB69EJKWlnzUbX4Wc6VbUGsD+cRxaGW+hz6qPaNPmuqsZu
	TkqMgPfL30LkVQ5+uDnUDFOgMplyv2ahrOl9PL2LortR+vbArkWZGiX2gjqnwqm+auwuXl+iYvG
	hi0uWoXOLhwZoo6IQw9utdJ/WCp/VadwfJXvzbUJUhtg450AwZ2nN6Z9a1h3RCrerKjuYjDFUHj
	02R3yCrvk6Cfzct9+YY5JQoNv/rULIBKy+68IvKHkMrpKY/pyiOCpMKoO4phMlazYPZEpRSYjO4
	saCbhouKhzaHSbvnAiN+NlBu7yjDbLnQzF7hVuGF2fZFvbbfBGWyfVKgmmfZKVF+aKFipu4LnJj
	/Hd0eeHzPlfBrS7SL/wjgIWB08gCQ5WbGh4jyASlNtg29rsawPvHqr4H2WizlK5nNfeSfx41WA4
	ilVY2dydj7I0RR4Y/UTt+hnt7JBxiCjXSpNps=
X-Google-Smtp-Source: AGHT+IEmCZy8dZcfJWaDPGKUM0ruU5HyXwhAlalIoL0EWswCVY3BpYehfi6Ed9Td71ll1blmhGl5hw==
X-Received: by 2002:a17:907:cc81:b0:b80:40fe:92c with SMTP id a640c23a62f3a-b8040fe2351mr560288566b.24.1766402237882;
        Mon, 22 Dec 2025 03:17:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/24] can: rcar_canfd: Add suspend/resume support
Date: Mon, 22 Dec 2025 11:16:55 +0000
Message-ID: <20251222111705.27028-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21209

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
index a8f7096ac818..fc38c87f0574 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2258,11 +2258,64 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
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


