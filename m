Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D7C44500
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19430.1782820132811312650
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RRyS9R/W;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493a7bd27c2so20495475e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820131; x=1783424931; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY7z7h7X+6/G4LKykoP+h8R6jGR9OXBkchjOpDpa7qo=;
        b=RRyS9R/Waoz8tGhOQoKr8+BanifH3K7InaJmI8NLTbV5WmI3VYQdcFpyXXOoYKk63l
         SOZGGa++0ukOC6uljsuLiklZyT+cU4USY5ATg67haMsPBfuc89geVgjb2bHA4bvUxlsY
         EA+PTMF5Ie3i5OO8lSxsNOEarZKoXsjqCApG+F0FhT1ud1JjKtu7nUzGC8x1dauXXb8F
         +6M2t8/Pf54PTU+DkgDafArRJKqBJPZY5CeO9flJ6zVJ8VH9SlfPpbt75y93KoTEm+7u
         pQUkTe2xViW+I5c3oCfT7ffyBEq9iXzuDCmnxzkdHQMJPXIsANAN0ptYN4aeJyCisB90
         NvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820131; x=1783424931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jY7z7h7X+6/G4LKykoP+h8R6jGR9OXBkchjOpDpa7qo=;
        b=H7xMCdqdon95H3ea12MQzQtiCUydum2ujgwBlTpr1IYHYs86bvo2BUMDAoqXJPUdbr
         v/e7rA6AN8Ezerg8ZC9Km5G9GH09gGvCyCwilgvbRzJ+26s87+SbX+maiay4xgxNPJrT
         B3dU5gY7ElhDcmHj6109m79p+DW32uAZUepX6M0jmvHd9TmHu6ukq0dxIeiqnFGMN6xC
         F4DQcpshLgHf3Yd4WuxihRuqc57tj+0PEj/8eELKHENVLgYmCEZ7rEQPV9Gig/kFVMlz
         xp2rawdyjC2MgwASHZLwJM5CawFPMa5JGS4AmAD+fnMEPgLEL+gpBju07/fRuo02Ns+A
         Z7yw==
X-Gm-Message-State: AOJu0YwKyDzNMww7OUHn+vGiyUjUbhnHVNZxG/Nia+fWyVntlPHUwby+
	rHYyhI7ntxhpq0IU/bqI0Z4SMbe2fUtMvFLQX0AydW4S8QLvbpR0js9eJi54RIPJ
X-Gm-Gg: AfdE7cmML8lITbCvRbIM0G3hgWGonV9HpKF6CBkWHDjHYQ6GKfG2WN+ioH6fOHKkw4i
	a5rvwnPCYbwCk7zn3gree1myIhOTWeCnQBEs0QRgM924jTmIngomPxhfndc7xONzo+xYa9oiKGj
	vODKvDKx/9vvWZEr1xXB+JJhxfYMV4aSUsayl8/wmEroZ5krSRMtUYAy80cVZV4yMu77ZR/FxXg
	65b6XTZvjMGnCsxcy+WaWDUTCU2v8OmmS1LpSGvXKXu8hFlEeOWS/JVg7lbO1Wx2TY1R+PtxTwP
	DNAYqOlDpm1VLbYDvmJ52EJhMrO4Ly0YVz6PORDENEnwZ+dNerrci88W76X9XzV2xylV5Nvbow9
	mC4dkWciJ077sCtTCQsciLTiipCHI/bfZuPEY7KRc7hS+oRx6Tr+Prl4uU/byh+3hAEg+Rf59ed
	ao7/nbf0XGyik47M8Uvhc3sxGqwbqob1CX7z3Nxw==
X-Received: by 2002:a05:6000:1881:b0:472:22b4:fd6c with SMTP id ffacd0b85a97d-47551179a47mr4479268f8f.8.1782820130883;
        Tue, 30 Jun 2026 04:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/39] clk: renesas: rzg2l: Re-enable critical module clocks during resume
Date: Tue, 30 Jun 2026 12:47:37 +0100
Message-ID: <20260630114813.92739-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23342

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bf497e7babb5d14570b18b5d2c8a6bb14d4a733b ]

After a suspend/resume cycle, critical module clocks (CLK_IS_CRITICAL)
may be left disabled as there is no owning driver to restore them,
unlike regular clocks.
Add rzg2l_mod_enable_crit_clock_init_mstop() which walks all module
clocks on resume, re-enables any critical clock found disabled, and then
restores the MSTOP state for clocks that have one via the existing
helper.  This replaces the direct call to rzg2l_mod_clock_init_mstop()
in rzg2l_cpg_resume(), preserving the correct clock-before-MSTOP restore
ordering.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260324114329.268249-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 408e76c31424..3e41ed90a7eb 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1600,8 +1600,8 @@ static void rzg2l_mod_clock_init_mstop_helper(struct rzg2l_cpg_priv *priv,
 {
 	/*
 	 * Out of reset all modules are enabled. Set module state in case
-	 * associated clocks are disabled at probe. Otherwise module is in
-	 * invalid HW state.
+	 * associated clocks are disabled at probe/resume. Otherwise module
+	 * is in invalid HW state.
 	 */
 	scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
 		if (!rzg2l_mod_clock_is_enabled(&clk->hw))
@@ -1609,6 +1609,21 @@ static void rzg2l_mod_clock_init_mstop_helper(struct rzg2l_cpg_priv *priv,
 	}
 }
 
+static void rzg2l_mod_enable_crit_clock_init_mstop(struct rzg2l_cpg_priv *priv)
+{
+	struct mod_clock *clk;
+	struct clk_hw *hw;
+
+	for_each_mod_clock(clk, hw, priv) {
+		if ((clk_hw_get_flags(&clk->hw) & CLK_IS_CRITICAL) &&
+		    (!rzg2l_mod_clock_is_enabled(&clk->hw)))
+			rzg2l_mod_clock_endisable_helper(&clk->hw, true, false);
+
+		if (clk->mstop)
+			rzg2l_mod_clock_init_mstop_helper(priv, clk);
+	}
+}
+
 static void rzg2l_mod_clock_init_mstop(struct rzg2l_cpg_priv *priv)
 {
 	struct mod_clock *clk;
@@ -2104,7 +2119,7 @@ static int rzg2l_cpg_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	rzg2l_mod_clock_init_mstop(priv);
+	rzg2l_mod_enable_crit_clock_init_mstop(priv);
 
 	return 0;
 }
-- 
2.43.0


