Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB6E674A2
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78276.1766402234888409423
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AZgVg++I;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so872426266b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402233; x=1767007033; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq8VMGZRY53B54VQ5jDdKunoMYQqAS5nHK/2xY6JBPw=;
        b=AZgVg++IXoinKTLr1ak0Pn72LtkDQThCzHWV/yr5XA51HMtw4X7CbPkfJPOVvqAu2L
         psVMzRJ0enyrEcN5p516P9iw2Nc1E3Tn4TeQftTBlBFkas0MpXaAx5kWRTi4feLX9g+W
         luKnDn6D8m0IfkXil79i77aQNZlKc39RlQK95Qsy1oHJq/alDygarqFrtGEysikrQ2jf
         gI7KpcdktrDK1IInyBXCC4magPL/iJIaupACck2DtAybjRWB3y/7NhpmVIzbOwACnlZu
         JM8DqJ0MmzrblLhPTdr2S058K/+hbY+qjsVKTgF7UqLz5t+4wVEsDuou4k35jcK+IBCI
         6w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402233; x=1767007033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kq8VMGZRY53B54VQ5jDdKunoMYQqAS5nHK/2xY6JBPw=;
        b=INKAcvsvhq7T5rsU/oYF/N9026dYSfgikm38yO+L2wTHZK1RVdY9pl/TkOe+h6Ntcs
         QxDzU+Y7dYD1Z+3zILyBORYSBDmGMnl5GAnBQClnc9Kd1GtN6/W7DCjeMLDWAw2pdII+
         2lCWbCzdm68i1/OwgpUWlU3QEsRzpPrpUXWgSb0JRZdrFJ3c0RrO0CSJAT6xyBhLO5Ze
         madmtuSH4NlpIAGu5DfLh0NC3M592ncOnxNqU1Z76KGzSnXuHzzuTm1qDDUCFIwHQqYg
         JffqAFXwk4A0h3KhBmMpTtHvXBO8F3DeXzm/CLGLVcIChzgrjYqqPvCwYvcDBFwVHHCM
         VmHQ==
X-Gm-Message-State: AOJu0YwUU5j3NNK8d2hPO9aW3mwuR4Y6NcwwpYTAKSFrY/1xcApkePIv
	HWGKPtRoATfgrjBZgm3AVFaXzAtyZUsmyTXVKr17w1yhSS9MJzUBws0S02j+2A==
X-Gm-Gg: AY/fxX7dTcN/5djXsbDEPyANWiSkUs0L3/yF3rNJuT/awWApfswSjndrcg6v6a/j7BQ
	58rOJ6hZ7mZMYEaOG1D46uim7YyMZGG89AQAreYA4NhhwNtRFCuNU3iCp8TVf53O65KHsVV3RPF
	cEpDpDvYC6NVuBIYULKXF1w1TREFRyIHiCDeImNIY3ljrjkeeSZAN/rp+bhan5bMWW+5mQ2rgQI
	nMFbIYIfqS8Z3oK3zW2vpt0VMFbyaapady6bncCDpN7cjKA+urysQ6E3EWjBGj4Nf7esaYOwOmT
	iZ3vRS6ozMtu6Beyv6uXYpAC6qs8ADzwtJShTNQ1blBr8S8vZWT8uusLPo8xLGHiyPiOngXAfti
	PN95JdmhdK0KWp8qp9weJFDIReslCio5w+yLPRTsih5BvThimeLFqweINZP3AGnJiR0WP4t+OHw
	LFlfmqrxH3GRsx9ib73WesiOC902o7WSbV+b4=
X-Google-Smtp-Source: AGHT+IHdf4Ffl2W56TRz+rHdg9c5okoOX4j/johLILd4/kFyoxuycgqjugq+QyHvvfs2Yuja62Ck6Q==
X-Received: by 2002:a17:906:9f88:b0:b73:6d3c:e0f2 with SMTP id a640c23a62f3a-b8037152a24mr1193286366b.37.1766402232889;
        Mon, 22 Dec 2025 03:17:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:12 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/24] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
Date: Mon, 22 Dec 2025 11:16:45 +0000
Message-ID: <20251222111705.27028-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21199

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
index 51bdeb8ef3a2..fb089a9d42ed 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1913,7 +1913,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
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


