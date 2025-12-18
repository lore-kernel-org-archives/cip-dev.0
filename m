Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B1D6E2CC
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1395.1766076968878402264
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P8jZdmVK;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso3863365e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076967; x=1766681767; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2sIfVeQqv0CI6B3kBn+dOyxjjd0dLcJRQ6EHHz2d48=;
        b=P8jZdmVKI4tOHayn4BRS8l7Cim3VRozXvkseIPY+JVhu4twK2/b0r/agLTRhTSLpYd
         Vg2RIVOd3gGRQkjJP+kLq8Dp+Gr44qZ3ZbUV4PVsxRST73CTQnZWBGolYL1AxgPnwhH8
         v3habwMsZyrmgiCeKLoK/rlaa/4FQ63sggk65+ZT480CnqqHDDmjchMjzYZl5dPvZRmT
         TNEvpLdpTzkK/YrSVbm1O/AfZeriKRO9cBBEJr9WQEZpP/G+i+SwDqxF99kvPpAzx72y
         tfcnP4D1tG0L+1VqlmBjpgM7WcJSvmtFa1/cNxyPJiDc/hqBVpPKyBmo+c+WXlA8qndS
         ImzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076967; x=1766681767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2sIfVeQqv0CI6B3kBn+dOyxjjd0dLcJRQ6EHHz2d48=;
        b=fsFb188FmIAJEpAFkRY9CIgMAKbeFnYYW8RnGTmknaW1BDch8JSBjKSUcPVR4FGcrS
         bvZPxHdPpl3CEk+ToO3FHVYLCrkuOArs5UmrXsKb8FQ0PlJ8Ege4eqjRvKnZiRLTgJyA
         nt9CCXBXkPnWJ9xq/Ad31FueMdkQ+50pu8EoiLWyn8EvLXv7GAkMOw0FVPEeh9n5wAt4
         cT2nXj0/7el8uHNRm7MrRZ/v4phhCJksM03VWpEzqzxypZZ2rPZPwqs7PiqkKAESthOE
         V9HVS6ltYZeHjIG464zDd7u46hUw9iqoUEOPS5keTTJJ5lHR/nZIRBiGkLCfCw4c+eOb
         k2Ag==
X-Gm-Message-State: AOJu0YzB7NZUQTcZl+e2ZA2LUrhEUi88UFH8Qmg25RlUFKSjf/xnspMw
	dfI5AlNgBV19M7nq3RTbTEAk2AVdtX7XQWanZe2XjGmn13ViznOtc8vT4LLq9w==
X-Gm-Gg: AY/fxX6p9rZC4b69/h1411xXMq/JfIUaCTSzi/pAYrzA4OC8sAE2NxMQaDOOFC1Ddik
	Vmi3XuwIYfkVaA/nArI0JxM+GHGPX/OU7/yxq7u51FoIY8C2C8lMv5qciqPvPxKLCvo/rc+zPzA
	JKeqNqoliPRRX22bkGTrLBFz5JVz1pHlzKD3+hWeyngbEwyluidUgoX7K9cUscymArNEBtkVs8n
	+acTkxHuD/LyyewI7liZB68ZczYsniRQmcP2R0MiRnkncb4CCUTGv71qlmyfDtC4sV26pVXGoob
	y4wrKyfgfZQJBezMmYMut1AMJDHePAZMBvc2R+JKVn9zCUYPDoqRSIqfrvKlHrslKbIBcRXi2iN
	5SZ1dadvk+YaQ0TPgmYnWyS5ArQbYx5itpnxvQ2xDqEZ3t+VIAu/6zKHtfwrf85KQ2Cjr41HUVA
	/nDEjZ5DlK6zrE6sEdog==
X-Google-Smtp-Source: AGHT+IHJ0p10OzRGcMu3gSakEbMjHWNEHKMFOeoitdqy9s0vlqrUpQL11CVaF2JbYRpJ5RwBMTqeMg==
X-Received: by 2002:a05:600c:8b0c:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-47d17f7f4d9mr9684295e9.16.1766076966944;
        Thu, 18 Dec 2025 08:56:06 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 13/24] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
Date: Thu, 18 Dec 2025 16:55:12 +0000
Message-ID: <20251218165600.258194-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21151

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 100fafc3e46138cb5a6526ddc03dcede8b020c8c ]

The calculation formula for nominal bit rate of classical CAN is the same as
that of nominal bit rate of CANFD on the RZ/G3E and R-Car Gen4 SoCs
compared to other SoCs. Update nominal bit rate constants.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250908120940.147196-2-biju.das.jz@bp.renesas.com
[mkl: slightly improve wording of commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a7e34a262d48..a9b72e95464b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1914,7 +1914,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		priv->can.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
-		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
+		if (gpriv->info->shared_can_regs)
+			priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		else
+			priv->can.bittiming_const = &rcar_canfd_bittiming_const;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	}
 
-- 
2.43.0


