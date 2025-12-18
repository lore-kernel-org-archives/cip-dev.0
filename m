Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE95DD6E2D2
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1400.1766076973973196810
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J5EZcSnx;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6366815e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076972; x=1766681772; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ohfftRdW2s9lvdS/dzOpHaz8RwuYFhnJVyLoGkOk8=;
        b=J5EZcSnx0ACLCqQfM5bNDVCixqcLlRM+iEIYJef/kTjxvsFVRrUAtmLLrtbJuNhrj7
         xRU5FUYZVhsql3HHoPltf+yM0vvdPfs+29Fi+cM0ks9Y2Hm7gjEPcUOqTzPT4OGstZQC
         5t+ukPIVo84pKyXammc7LX/725JCHFXm7PgtrgjVuaeApxkWMa7D6CQ1jHkaYW0ChsL/
         DZCLv4hSrNRlNfvTy+B+/7a3zQWgSBDwZZGZbzhlefJbUfAwT9sBKia62+ApG8R6pmbt
         paxlw4a2CfdwTTqQFU5eTEXVzcFVgU7Vmm6SSksMct1m8MBtZmajH4XlaXhP7D9iWP79
         wnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076972; x=1766681772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9ohfftRdW2s9lvdS/dzOpHaz8RwuYFhnJVyLoGkOk8=;
        b=U+3FPAyQpKqyNDC3afqdhSxw9qSkUuSFVKcJvResyh5aVOaGZy/nXhTDMN9mm4qDHE
         uQKHT1+GnWxf5dm6dHz6IQPJFDEM1zUl6rZPsUpB6bXDiXTqLmSaK9mkwEga/N+mlGjX
         mIl1V2kzjQIi1qXzoxfYMO5Sdq1cFx5M4aq8OmWm5Q8a4PW5ZxNC0fz7374+Ae63yT/2
         rq4ySk8nze44PsjAP9gV3Z1hZZ+oXQoYKSZ3Jm3kSn2kvZXvvXP5oHDfWETDxfD0TGi6
         /mGcQCHRIR6/2BwKS/hKuL63E5walmAP7KvYImbDIVZSJdzMEPisL/H7KmBwBkN1PVPR
         hmRw==
X-Gm-Message-State: AOJu0YyJlDPzJMNLgqpkqTKv9yF9vnFtwJx2FgOyunPs9tSFDKzVk8wx
	arWHKEab573g9lTgbLidCIWwEABaFrRSP/H2h9IImZgdOd7qccYVh2B9PX3c2w==
X-Gm-Gg: AY/fxX5l5bolQYQCrkzzrK4F/U+w1w5exvTCH+VMfGAsETXG76N/AIzkQt3NP+hMS9+
	K6lbnY4jUg9DdlKbppb7lLMyL4E55gZ5DbyelOxo7IXRFuT2UfT/TnHU2OfqLMSCin1wzdpjb0z
	jQuhgoHjyXufdIw9DuKc8fK2CGJfTR8d+TxMg9QCNbOMzb+KmZ0YXaqYpfoOtwQQ1ApLcNyp5i2
	CX5qTg7Zqq2itpQW38sjeabg1UTc97SJCYp1SU0/rpKARGTWhwld0tl/23wQ/ISMOl56qcugKs7
	e8qqB2P6IEiXLFgemo682FPa9C3GXSF/jd0OmkL9FFK53fBsEnhTz1B5yI36WC53AiBjxeD5/mk
	FMcTwVrceM6iEWPbzR1oDh+N/spZD52Ql1XnwXZsFhXlozV1Hk0cfvypvNWS9JeGyO3FNqTfuua
	6qxRyfb9T9ibanCPVziOqVt5027OHj
X-Google-Smtp-Source: AGHT+IENA4y9bzG+XnL8fNjsC2BF6Se0iEM++W3dnw4gP0feFJV0yUJz7VShT/fdlw5Y3Me9sIqBug==
X-Received: by 2002:a05:600c:470a:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-47a8f916db9mr220495655e9.36.1766076972098;
        Thu, 18 Dec 2025 08:56:12 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:11 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 23/24] can: rcar_canfd: Add suspend/resume support
Date: Thu, 18 Dec 2025 16:55:22 +0000
Message-ID: <20251218165600.258194-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21161

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
index bb17e96d7cb7..5503c2c14bef 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2261,11 +2261,64 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 
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


