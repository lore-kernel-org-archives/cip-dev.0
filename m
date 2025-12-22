Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A719E6749C
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78196.1766402231649976670
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VZVc3k0f;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72b495aa81so630944866b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402230; x=1767007030; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T7MIJmR8c6UOEXgObUx7RIK0M1f4EhhCQkQjcIcD1Q=;
        b=VZVc3k0fCfoPcCKJP7EHHUBDQ6XMYIJHBMZ6ZgIBznKlZ0Wq/sMcuiLnPHJE8o4sdQ
         t6A8sKy5wfUoDA+eI/O9OZO/UvBiEImYs/M9qH/qmRzh4+QHg6C/ZB1rYLZsItYdLgt5
         eAcXd5QXWQ/DqKTRpbZUYVhpYLGyHIxAfErnQvGa1z/q6Mg0WcCT3ISshhCjivmW+0RO
         jO6GDmbfv4cDEOr34lymoG4cRpxAlMOFu81YQMltHjU6MwuxW7LiarG0geRwQZclg5W6
         VgnSK9VnkDo0G6GfN7Gp/eT4O1zcA2CJLJeYdfUcKMhOyNc7yoCRiCmh7TWr2jEY3rbS
         RqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402230; x=1767007030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9T7MIJmR8c6UOEXgObUx7RIK0M1f4EhhCQkQjcIcD1Q=;
        b=aZX91EIgHYuO5y/La2HBMbdf+ZA8CN6exYj9BM6dNaST5XxigWrNztlm1OLsMdoHei
         I/4ZyEK/vlc/8kJIB0VO/V1YSAld05reL8Jp9NgExwc1pzv30lnCmlBjAeYg4E3+mR+W
         04WQnZIvOWltBe4CX2IHQ0Ey4dS4sonogKBAFvIsEwjB8tlX1O1lL3ikk0ZNb5XJA8NN
         kFAGp1j9w24S4ZduMD3uqYShSETj5DN+9HtpECWF/Wgq9Eg94Q0LQo9ce/b09zogE5yW
         3DoCsghEB88DfkDYUhDPr1f4mW4AK0egoEEcmB5p3k0+fPJU0CTEmkCer/aLnLijQk2v
         nV9g==
X-Gm-Message-State: AOJu0YztWaeGY84UIYKLNl7PQgtKymk1R7wNPb7HleaiwnIXKhxCrDNU
	La5eKrJ5EiGmyE6fLD5+tksVck9UQ/oRQf2hFi4Cxyk0nzDzNxgDTZk9Sf3dRw==
X-Gm-Gg: AY/fxX6SESlZXKKBG2mtq7xWisyXnyT4WCMQpmc3YjgtCMxMHxIaPhvn2uXpLlegE/8
	o9yBRfDhX/rXPYiJVgFUXI8qZPqwCosouGQw3v6KUjO76vlUW4YMPEaawS+r5AXy7uATO9daHFU
	zYtCMGf+NTE4cZBg5r6QED1zfkcWILtvlMmIxY5543ZfhmHkS+CTVOtLORjGknBP22Kq+HIes7S
	+yYQ+ERlxApViGzim3DMSU29WV7TlOYMbMH2VPrCBujem949fBi6v4OMp1lUdPqA5jXAmb5PNOI
	+HmTFf3fyhAcpo1Q+iVqyZaxwk4riSBJn1Gkodhz6UGp3zyArlKvsgLFC+76STk68DERgc69rKc
	VVQrOOFaIOCd7GGBIaXTf7O0HSsg7QHdeu2w438t+cXbEMKVtiidQOMJIPwWmm7JTErxOB5MRJ9
	Xx1jvq8ikknEVrXsyaXHaKXSZ28/dsVTcIxPM=
X-Google-Smtp-Source: AGHT+IGA9pvA/GjyQKIveQjoGi4BxXn1ST1dfvjTisoOj3m8LwovKSsk7GNFjctlkAyTwxWRTE7AQA==
X-Received: by 2002:a17:907:7fa5:b0:b76:d548:f85b with SMTP id a640c23a62f3a-b8036f2d2demr922440166b.11.1766402229718;
        Mon, 22 Dec 2025 03:17:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/24] can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
Date: Mon, 22 Dec 2025 11:16:39 +0000
Message-ID: <20251222111705.27028-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21193

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1b76dca8fd892a8ced41d980e123b4701ad3cf10 ]

Insert an underscore in the function's name, for consistency with other
getter and setter helper functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/9fdc2584ce27b2784ecea76390d2a81eab289d0d.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6bdac418795c..d125b416a8bc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -830,8 +830,8 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
-static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
-			      unsigned int num_rules)
+static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			       unsigned int num_rules)
 {
 	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
 	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
@@ -961,7 +961,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_setrnc(gpriv, ch, num_rules);
+	rcar_canfd_set_rnc(gpriv, ch, num_rules);
 	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


