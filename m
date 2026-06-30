Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B4C44508
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19429.1782820132077653689
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RzSUnAJv;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-463f1165e16so4461200f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820130; x=1783424930; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMo7MjWtKZUCp5t4Ny1+y2MiHTuWtGp3dEjdtMtrp3o=;
        b=RzSUnAJv521Un+MVu7wa4BVt0AbuB/YskQ/0RWc8lEfx3wXuF6eqcOowT5vEJjw1WD
         G3PnUdqpxbEj0ISdgp2G1V1i0iZZsRlJW+SoA9hjOh/RS5Z6a5cmr2bO1ctv+NlPtqu3
         85dN2YZwtqLYECO9sieQ0OWgKuSvBbEnnw1Grvkb5oGaVd2o+aBF2ueejGGsU6wys2dD
         etpVzp32ji5LhOPCQT0b2s+UZpqKtqR0Z59xTC+mtM6vAPt04/GHbZdDpf1eZ9IsruCJ
         LToDw/fX3MnPTXJT/Wx+CUTd84O+qcLeVx1bC/cSS8oeru9ctab2EA0YfeayowpAqujH
         8ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820130; x=1783424930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMo7MjWtKZUCp5t4Ny1+y2MiHTuWtGp3dEjdtMtrp3o=;
        b=BmTsSns46drXkrHzNhM9t1kJXBctONe028q5vcp+UImlMmcitKYeiS/vw8hqA1jbfI
         Kc/MqENTu/2jU35o5oFy7wjZH3p2ELPsCSezOlHLaa+DpP4t7GQ162cbyQhGp0mm7/Og
         3lbikttdhwLHaekxwXB/wnie4uI/qh8E2+RoRcNgGIwxdYZM3Y/Gzdr72DZsg2Ve730R
         Y8qrXTBN563aaJuoURzp1wcLMZImaC6RCwjaZA9E057zQRlpH0PmueZBH44WyjzZm9JQ
         v+VAtIP82Uw1ezFQbjXtNZdPxvTeAmEjrb6/K9M0+6XHFvNzfqdQYsNgKluS+HlJFiAD
         Gy+w==
X-Gm-Message-State: AOJu0YzfWjpqwDruY3n3EisQeJtW+y244OkjVmCoMdXdPHauGKcjuXxS
	5KooIiM3eVY3+igU8yu21gXYlt6Dhhumwayes0WYf1kaIAXs54dUGxwMQu2HCIpz
X-Gm-Gg: AfdE7ckc+2odYPoOeU3x9I6XsxWkaqS7cS12Y0AsD45U0YFJF+W2xqfVK2e0pbT0Eea
	2XFc9DSZ29tUCWSdeDsFX/8H9j9I/X79OCsPg7Nk4URoc2JTvvBwZPiYOvmgrfWzDOYAHeFnknU
	mfYj7mzaZfKVfBjQV14FEYBc7xSFTdxEhE4Yqs2h1xJ4xzmUJjQ10lsGxoUmVTkGsFLnvsZTt8B
	e8E1yOIAgvRTw8r+jsNr5TBcQ1CRG1nws1/Nwqe4lr6LP6dMyY2JEmW1g4kI/1pmWw6uSWV1aON
	kWaIn1kpLLUP3P6uloElkJvfIZXeA7eRjUW5efJUUHqqJX3dUjE/+opLERg7RDkV/bOqQB3Y/un
	LoG/PYI2cpQi24sd6Cnvwh+/a4v9qUzLjfU3Jb4TnuF4EbXSXXmIf0UauReFAHzE+x0LXL13R5g
	XuYJ+L8swAXSuQlmz/oTs5S6r9zT7SWGYSYX+9Yw==
X-Received: by 2002:a05:6000:240c:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-475f10036efmr2156979f8f.54.1782820130212;
        Tue, 30 Jun 2026 04:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:49 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/39] clk: renesas: rzg2l: Add rzg2l_mod_clock_init_mstop_helper()
Date: Tue, 30 Jun 2026 12:47:36 +0100
Message-ID: <20260630114813.92739-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23341

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fa3e973ca2d7a46b9f4ad5611b42d1885d7a77b6 ]

Refactor the mstop initialisation logic in rzg2l_mod_clock_init_mstop()
into a dedicated helper function rzg2l_mod_clock_init_mstop_helper().
This decouples the logic for setting module stop state on disabled
clocks from the iteration loop, allowing it to be reused during resume
to re-enable critical clocks.

No functional change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260324114329.268249-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 840147ca601f..408e76c31424 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1595,6 +1595,20 @@ static struct mstop *rzg2l_mod_clock_get_mstop(struct rzg2l_cpg_priv *priv, u32
 	return NULL;
 }
 
+static void rzg2l_mod_clock_init_mstop_helper(struct rzg2l_cpg_priv *priv,
+					      struct mod_clock *clk)
+{
+	/*
+	 * Out of reset all modules are enabled. Set module state in case
+	 * associated clocks are disabled at probe. Otherwise module is in
+	 * invalid HW state.
+	 */
+	scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
+		if (!rzg2l_mod_clock_is_enabled(&clk->hw))
+			rzg2l_mod_clock_module_set_state(clk, true);
+	}
+}
+
 static void rzg2l_mod_clock_init_mstop(struct rzg2l_cpg_priv *priv)
 {
 	struct mod_clock *clk;
@@ -1604,15 +1618,7 @@ static void rzg2l_mod_clock_init_mstop(struct rzg2l_cpg_priv *priv)
 		if (!clk->mstop)
 			continue;
 
-		/*
-		 * Out of reset all modules are enabled. Set module state
-		 * in case associated clocks are disabled at probe. Otherwise
-		 * module is in invalid HW state.
-		 */
-		scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
-			if (!rzg2l_mod_clock_is_enabled(&clk->hw))
-				rzg2l_mod_clock_module_set_state(clk, true);
-		}
+		rzg2l_mod_clock_init_mstop_helper(priv, clk);
 	}
 }
 
-- 
2.43.0


