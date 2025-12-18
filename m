Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78CD6E2C7
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1405.1766076966022217049
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WEorZBpG;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso9145095e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076964; x=1766681764; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfwuzrJirc5oPRZoLbvPMmgigQrMs1L8WvD1lhuKHCU=;
        b=WEorZBpGtjGrI1SMz5xdZ/B3DMCNFfAIPxOtzAbyFhOS9j0Rf5//LAUKPf9YxGz5WW
         XAizjAouf2EtqZGduc377WO4ttnw78YGhM3WP1WgBr7521NuPcmpQWecNVtsnp/bU5Cu
         XDM6Uxy3HwADKverulQypQzZI9ElRCLMHdylalw5n15af6KBAuoaoOQ5CpIuAG1XTgIW
         wSIU+WtFyKKp7cA7VHcnu8AvUxxhRcncwyZFCJHjPyhaCZs/8MXSqn1OFuY3XxdoCR5n
         C21K+MYrvfhGPNdWhUj27wjpOWH3s2HySvyqiDJABB2htbyJlCc2isw6PKi/ATtVNh09
         RHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076964; x=1766681764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfwuzrJirc5oPRZoLbvPMmgigQrMs1L8WvD1lhuKHCU=;
        b=UeamNfG3jBoGBp8XDhzwB6iKThwf93htxlZFRTJmEWzE9JnTp9qqJr9BndZ2L/IKgp
         5K5togOmyWqwtVwdxJfEr4qzws+g8bm5AHoeKNKEizF6SoXzDJdI9P/31CbKq0IgcwFI
         4jKPfQHhpT0dQslO19j1jz0mWikARcUSeQ0Ti3QhMSebXpdeSTBL4gLd6qwTkbxIFbq4
         cA2i0tMJynj+zGDagidIS9mSmuRC+7wjwo1GNF3wik923vhYGP+9W9641JcNnwiVhKGQ
         OU4LPY/wWeeu/w9Fxk/8543IxBB+ccavwnPyD8ZaqrU8UAZnANSNGWZuD2x9z5w1NMY9
         ytbg==
X-Gm-Message-State: AOJu0YwYRmLUmF89KhCb7/jIw1odKnRlHPy6q7VrMqQZViS9LSg6RZAs
	1pRCzraCbZjUse2TryueclvoJvQ8zAP2WFHvpkXfz2hNpyKDneVMnoiOv7+Ygg==
X-Gm-Gg: AY/fxX4gBWUfXKvCf/n2vi8ILFXOvjPRZpGqmOx/4MBxy5tMy5ZLj2F7trfYh6e1VDW
	UzgBJNS3MeZZNZfwe+wYVKLRLPHkEOxp+8LV2a1L6J9qjtzGS1TjO1yccs+OAhGWXDZsdBy8Udf
	+tzhcWE969aTC6aI5/E0YqzX9EZvvhw8WvsGZaFIYAtQrVi83NejhgE8wtFJRnLNaP/Qt1JH+UH
	Io72dqCvkrUV5psOlScpM9q7flM2Co99wV9s1APXjDFMGNgoKkuZ34lXzkhaY58LXpzEEsuNKys
	qP2LH64opggvIAib5SqTWCVsW6ReY/b4xg3//suzROnUs6W9BvqhS5qHZwAqaRPqIHIj3yXb+D+
	8rt18D4tcCZ2Ki3+lqHkilVaQQ1Yq3/JsZPpR+Hcv8eHYRmnybdjhPlhAvSDbDosBDJItR5QqYo
	+rLdV2jBjH1FsdWwCnMg==
X-Google-Smtp-Source: AGHT+IHfr1njHtp8qZEXOjfJQ3a40Cqg4Wle55/vd86PBGYA8q6nHPB2yvbaemEGbrZyvUMXb+sQpA==
X-Received: by 2002:a05:600c:5296:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47a8f89ba4amr186994405e9.4.1766076964129;
        Thu, 18 Dec 2025 08:56:04 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:03 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/24] can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
Date: Thu, 18 Dec 2025 16:55:06 +0000
Message-ID: <20251218165600.258194-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21145

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
index b86ab6d3e9b1..6a3e1b06f4e8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -831,8 +831,8 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
-static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
-			      unsigned int num_rules)
+static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			       unsigned int num_rules)
 {
 	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
 	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
@@ -962,7 +962,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_setrnc(gpriv, ch, num_rules);
+	rcar_canfd_set_rnc(gpriv, ch, num_rules);
 	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


