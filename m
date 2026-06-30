Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4FC44501
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19075.1782820131416189195
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JIroF7CL;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1273383f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820130; x=1783424930; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZbBoQaw7xHntlmNQ9XmA8djHvgMAqdhU/gDTgwoCDs=;
        b=JIroF7CLdttt9HXiJmHCrwJEqtOUceWa94QSlwRv/R73ewGRwnyR/+GH34yw5qsVwA
         nEyCE2RE66OWVM9UGcJAb38ES/fMw/HdrDN31soqiSefIepxx1YBqpUfw0CW4+Y8Uga2
         FNDFs5Ti53WjZnntRkDnMFpXbfI561kDNelatLyiQgRlPo5kZQhlY1JCCuaTWPaAgJXI
         Rw4bErxTjQt+S2tY+i1kGmclM9Ygyo/SCwYDMAR0WWT2KShxfbcrSGPuivW/3/5kTG1l
         LFC8ZHcxm3PZbF/Qp4RZ81ivB0Q9UgGx5xALvUVjh4PHj31PxUO0qT7rqplilHcsU4nz
         OQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820130; x=1783424930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZbBoQaw7xHntlmNQ9XmA8djHvgMAqdhU/gDTgwoCDs=;
        b=eWTJlKpUkDoiS73rThgTWwlo+pgH1l5lLP9APXhA824dQnU84hTO7QLfTsCb4uEM48
         tUzvfoMrQMkyrAD1JbQ5RrO/qQmsMNqs7saRqnfimf1j7vcLZDsGEsmEmFxRCRcvMzsK
         KbQuqCk1UPB/vQwmj6UeSKgbqsdj5eHtXBkCqRVQkoLnMrZ9WnkmNP0T3Yj+w7oKjbUv
         7LdLPSTkf96vFN3pWoWtKkLsxH1o+q3cOlgMggv1Xs/3QegeETTr35ut4kUUrTwREgTc
         mCogiO2JGPPtNOtXKFhgK4XYNkj/E6ffrMBWbfL/yHDzBQPTt8m5BTICEfI5FmlyLMpo
         8zPg==
X-Gm-Message-State: AOJu0Yxp2a8nEFnW13ev0uzq13u1D9n0xjqxdwas5AX6NAnW5w2R/4Cs
	UwH6FOPKqnPnvDa/aHMqQPQfHKIMbpVohG22t45Ijc6LIYyJ4Fs2iIog9p9gYEQL
X-Gm-Gg: AfdE7cmpZsgtI4r5u57GuR9/1+4sdj4Yh3gsVdaJBYcemo6sGXZYUuUlvZO5KvYs0lY
	SZ7jvj+neBBvL740mlXri1RT2N+M9co39wQJpBi/7dqHmuO7CCE8Kkwp8us+I366tBOZRCAds7V
	XDlePgD+vV8GYgFjdWO9QBZWABNUY/Hg73NMCBBJm54osBkWUScC2HXvk6ozBr9RN5o2zNFAQ0e
	V0jYn273pOfaFyym1G44IpZCAKLi5AMqcNFIOt61OcsejAQlabQVLH2p6BDP3GYYzoilzLnrVgb
	wGmAxPx/lZYzL73yXLQJ7O84/5Po7HrdtB6lGPMMnzUbuOiU5TyBd/Ib8xxGSjxKsJxoFGj1DZC
	qXaJ9Y5olF1UfTslEt4TD7VquBJzRaW4XL+pcCyOs0gEDFYnaiSLRtpmQ3nnP0DDaY+m2WlYBGA
	CM1tcjLnDhI5hnLIdjqBQpor7BkudcAH4QENPdqA==
X-Received: by 2002:a05:6000:4028:b0:472:9bf7:2f58 with SMTP id ffacd0b85a97d-475527896cemr4094129f8f.36.1782820129597;
        Tue, 30 Jun 2026 04:48:49 -0700 (PDT)
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
Subject: [PATCH 6.12.y-cip 16/39] clk: renesas: rzg2l: Add helper for mod clock enable/disable
Date: Tue, 30 Jun 2026 12:47:35 +0100
Message-ID: <20260630114813.92739-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23340

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 867fb0bc60602cb3c2458fcd25c841650d37563f ]

Refactor rzg2l_mod_clock_endisable() by extracting its logic into a new
helper function rzg2l_mod_clock_endisable_helper(), which accepts an
additional set_mstop_state boolean parameter.  This allows callers to
control whether the module stop state is updated alongside the clock
enable/disable operation.  No functional change for existing callers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260324114329.268249-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index da211010d2ba..840147ca601f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1440,7 +1440,8 @@ static int rzg2l_mod_clock_mstop_show(struct seq_file *s, void *what)
 }
 DEFINE_SHOW_ATTRIBUTE(rzg2l_mod_clock_mstop);
 
-static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
+static int rzg2l_mod_clock_endisable_helper(struct clk_hw *hw, bool enable,
+					    bool set_mstop_state)
 {
 	struct mod_clock *clock = to_mod_clock(hw);
 	struct rzg2l_cpg_priv *priv = clock->priv;
@@ -1465,9 +1466,11 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
 		if (enable) {
 			writel(value, priv->base + CLK_ON_R(reg));
-			rzg2l_mod_clock_module_set_state(clock, false);
+			if (set_mstop_state)
+				rzg2l_mod_clock_module_set_state(clock, false);
 		} else {
-			rzg2l_mod_clock_module_set_state(clock, true);
+			if (set_mstop_state)
+				rzg2l_mod_clock_module_set_state(clock, true);
 			writel(value, priv->base + CLK_ON_R(reg));
 		}
 	}
@@ -1487,6 +1490,11 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	return error;
 }
 
+static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
+{
+	return rzg2l_mod_clock_endisable_helper(hw, enable, true);
+}
+
 static int rzg2l_mod_clock_enable(struct clk_hw *hw)
 {
 	struct mod_clock *clock = to_mod_clock(hw);
-- 
2.43.0


