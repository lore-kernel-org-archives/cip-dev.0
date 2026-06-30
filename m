Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29566C4450A
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19423.1782820127839142755
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lznSgEWa;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b779003fso5594725e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820126; x=1783424926; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0RHqrYgZ3W9Qf75JUQlbR5/5W+oUae/zlih+XFLcPI=;
        b=lznSgEWaQi83CKrbYf7+31SgXhXpPzpq+xavKqBaiRSa/XnoVb6BdFLM554gl5R6GN
         GaJ7Lb2vyzgyHjSUP7OFuctOF1CuU/X/2dJfsyLsUOFUQy+c2SUv32cFujiPT2nZ3anN
         Cj5IL5L8NYPsmVQlD8hrcTiLhpGyMiQ8nhViePo+1H1BDP/Ij2udZbmr1cHorzqI6oTc
         JNk82GJdEO7nqrqeT+j+IQZw7tUFVzesh7Vip1ttDY0Sv/uYBQc1B1Mqmd7PrNfeqd9A
         O9+PWHzW/ZLjphFz5BiHkfJ/UCe3TcMFJwfBlLqhenR6ANZ0P/WA9+KImQ9mIxyjkwxv
         7sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820126; x=1783424926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0RHqrYgZ3W9Qf75JUQlbR5/5W+oUae/zlih+XFLcPI=;
        b=PUZjpyZyF+LukGubxo1EXVmk2wg6ehu6Xj04c2F6/gS4Wbz4ZvkCAyZHcnXxyYtu4q
         NtE1guXzJdnOmQ2DGdyvbV/+Y4vDtjoFCEOPNYgloG/w1RLSqhAX4i8VwQbs6wgOWr5l
         V2icdTT2nycazTBPx00Tn5UKV+h17Fv4tyGTvGSsuxGIzE2nE/vx2JFzpGgFGfynj24n
         6ChsHWCKviVDYCXgvApeQDnvS3NCoIrecz05XezxtC4zJMg3oux8PPtNWFAZnC7v2mtS
         ujMlnmpDjZBztF0ymn9Yl0h6UdHnQ8KBQdHZh+qJsL/YHkYmYsYvsVaZKbALkRsHdOKf
         O29w==
X-Gm-Message-State: AOJu0YyqdjBRrJucRiKtMjcugTMlM4yZC51buJb9W3Ej9UvtCvSdW40D
	uVqed2wDnWPQeEhf7xK4Q0hQxMlIYpyHa2wztUh0vSmc4uhVy5pt+fdOUYEW/yj8
X-Gm-Gg: AfdE7cmnAH1lXlGHyDzRrK2enRQyPMT8aFez/ULlRGsk8ufD7TDA8rdPEsaygahN8SV
	wyxtJKfQ320/ECRMwzrxB60MgALW1qTasdwNR7khph6efHj2d1NkmZGU6AhnpZM6+sp83foBcjR
	GBauA2XUfE/uWQf3T/+Putv2odNvJiKnf+bqmPed/q8gpU/2I3Jev9JxaW9bwRwx6bIv+3cjmpI
	4jqeIINsq3/g3PaTXL9QejWgS66eImiFX0PkJoJiGDwkShkdHau94IiTWMmsoc4V2gJN+0IuKgS
	dW8nJ4hyxlfhGCboQQLuKYvlH7UZrmmpFQ/FtEbtRcdzu2x+OMmYp8C5YC7+lUiErGjkKoOuaYx
	M7e/HsMksYbOLvTSugFrw2wxhlPmZZE+ZEpoBM0VRgOmTJbr7z/qB6AIMm9y0v/3bry0tPg8Ir4
	wpXimlL+xsJXeGv+Rt2BVLxdDqkOjOor2bPNnsoQ==
X-Received: by 2002:a05:600c:540f:b0:492:62d9:4e57 with SMTP id 5b1f17b1804b1-493b827dee8mr51676155e9.2.1782820125789;
        Tue, 30 Jun 2026 04:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:45 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/39] clk: renesas: rzg2l: Remove unneeded nullify checks
Date: Tue, 30 Jun 2026 12:47:29 +0100
Message-ID: <20260630114813.92739-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23334

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 653395e63d53723f29b8cc1aa6bc4cbb873c7b7b ]

RZ/G2L family clock drivers never had a need to nullify clocks.
Remove the unneeded checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/64702c33396dde2689b44d3e326aa1727ef1557a.1740126560.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 7d9d41f4f439..0852fb27e039 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1238,11 +1238,6 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 	WARN_DEBUG(id >= priv->num_core_clks);
 	WARN_DEBUG(PTR_ERR(priv->clks[id]) != -ENOENT);
 
-	if (!core->name) {
-		/* Skip NULLified clock */
-		return;
-	}
-
 	switch (core->type) {
 	case CLK_TYPE_IN:
 		clk = of_clk_get_by_name(priv->dev->of_node, core->name);
@@ -1672,11 +1667,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	WARN_DEBUG(mod->parent >= priv->num_core_clks + priv->num_mod_clks);
 	WARN_DEBUG(PTR_ERR(priv->clks[id]) != -ENOENT);
 
-	if (!mod->name) {
-		/* Skip NULLified clock */
-		return;
-	}
-
 	parent = priv->clks[mod->parent];
 	if (IS_ERR(parent)) {
 		clk = parent;
-- 
2.43.0


