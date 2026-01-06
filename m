Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB271CDC166
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88217.1767699908261948819
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WnaKsErb;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8284725e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699906; x=1768304706; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hj7g5cgkGZoOMFO4LibSHlRFUmn89N33XyQWIETuU4=;
        b=WnaKsErbSnO/7q1pUtio5JemilrnvdVtKZFcif0eThEHHKUaMzCNqAoTm0Vwrhcnr9
         +dR8ldnaZQXxAVUNTDT6yRcwlyFMTWfSx6mK6I+Bo6yOUEOTPfYz2zDeqop1HbB+Y5fB
         YyDg4Df1qthh4SimVqgZvvR/1HYm/3S9aHwha0pfCwIKjGr4gKyFvgPpMkJT+4WIzNb/
         xegMMTtBXSDvxIt15CibAClT1l5iBZvGywXpbE4JHg7RMXmWXzNoWDQoGHaLK2aiiArq
         Yib1G2SOwNdXoqkSLtOGJ0rLfYXdW9yKPeut1+lyx+WnfmTGzSSb7dcEul0zHOEtruwM
         RLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699906; x=1768304706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hj7g5cgkGZoOMFO4LibSHlRFUmn89N33XyQWIETuU4=;
        b=KH97Xk41GpaEh5OJPeTP9lrNDjd5g6ZhzfvDFcfBKCE7Q5IKQx3Jyvu2E2P9NS+B2Q
         5mfr2CwGc/2tuFXApP3SrINsPB5Abtok2nYasJCLlX+tSq+DebKpxuf1yQhKsiBbf883
         xHsPJLffz7+oD6mUdpaw1iVi0wEpkKgwYK4so8mNpbQ9NKuYxP7YDAdx5A6wCfXL9EQZ
         LROSY8qO/g2j3Vlyl3CWCoM7V6HM58jyTTfrsi5nh89zydEpE/QwqvSX+tgYEr3Wf+8a
         kzr8hJNJOSM/cY1BvBIR2JKMp8xhj3oewGBy5K/yTp/nD5hlCHiDT4BCCV7nKzv6I0H8
         IVxA==
X-Gm-Message-State: AOJu0YyTs642PnGLUZdYIjo7IW16AAILZdeez754USqX/c2QznikcprU
	a8lVaaojGoJoAwcNh5S2UsfpAAzRcS7t0vNvOh+BOezDqqoU6qP2Yi0DWi9vpQ==
X-Gm-Gg: AY/fxX6NTULSkqUl/H72w9e0rQTdLQSsssADP4CybjGxMQ9+dg+o8GzvohKtbhCIZGI
	yur8ouvjvUCis8Srb7IHrgMUzY9Dvg3tTRRyaSr0DiYySVe81whVl4VF3gKJiveIL9udF+R82Y+
	VRC6txW3ddwFbV1+Mo5WJO1Eab8WuHUnaAGU82beDjY1qOGCuNnd7+k9iYaHrkOvjEPHlNmG69R
	ogDglypt32tLtvJxQpoPclLnEQWAiwQOszt2fgPnXuzMQjFv1P8Ee3qi6bOhWQMX1GKwLstfUlK
	BGueX+/qSZvR5gRkDKsIISduWhLqq4UgIRNh/TYrKLkBOFwignX83AIHjKcFQ8Uj4GKwMsXbef2
	Wf0IH0Fdqxntxd1siECpA/9Oj1v1AI6G0F2SE4lTSXz5mwaLymujiYv+16lQQabzh2eWTA/EDsT
	YJjaG9Q+HJxCUQeT4Z9w0/iFwGMcnk
X-Google-Smtp-Source: AGHT+IHLtByODV5p3+Uc91asT0noF26VyT+0MgWtuU17zaZ3C0quQNfd/hf+XCeDGsIUoS3naofyXQ==
X-Received: by 2002:a05:600c:4fd3:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d7f41f018mr28882215e9.13.1767699906303;
        Tue, 06 Jan 2026 03:45:06 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 14/24] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Tue,  6 Jan 2026 11:44:37 +0000
Message-ID: <20260106114458.122333-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21346

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 726213c8e79a615497816b76c9d236aaf8a47053 ]

Update RCANFD_CFG_* macros to give a meaning to the magic number using
GENMASK macro and extract the values using FIELD_PREP macro.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e67a808c7fa0..7b17845e9b0f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -103,10 +103,10 @@
 /* Channel register bits */
 
 /* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_CFG_SJW		GENMASK(25, 24)
+#define RCANFD_CFG_TSEG2	GENMASK(22, 20)
+#define RCANFD_CFG_TSEG1	GENMASK(19, 16)
+#define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
@@ -1420,8 +1420,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
+		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.43.0


