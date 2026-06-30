Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FDC4450A
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19439.1782820141159328919
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VlmfsPkm;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46ed4f66256so3504917f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820139; x=1783424939; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHKUb4YAJl7gujKLwPMdG/S4d+sHombaCL0sDycZjZ4=;
        b=VlmfsPkm9AFqvE3NNNkH3zeMpPYRKKSmwjI39Q2xkgVWcraQ9IVYtwy6VY4YXT5PZ0
         p5B7IKEmlS9A9brYIcamwALoGeZA/59fAOqVa86G9zgZJtmd8OAVU1xpbfXwJugmeeuF
         NpkjkEEh2WYhMrANgEGQNWIBLL6D8XaV9n4r1kwhx2Vq0+Ucn2ak1TN8u9LG72xsDkCG
         rKZBbQJcHgkiGBLR9r/L33hQ8tEax60DYimusTd69mWJH85DhTAU0lCz0Xc5EEfYXZir
         X+JzjBVuKCdT3c3vkMdAxCvbRBEYVFe4HJNPSi+LzAJT1qoIwq5najiGsiMxenyu3jb0
         fHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820139; x=1783424939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHKUb4YAJl7gujKLwPMdG/S4d+sHombaCL0sDycZjZ4=;
        b=mNYOTz6VDMqtZiA2SK7V/rj881FFtYTlRsfg1PbAki9fCOTZtQio/M7BSs6NMqpZ7F
         1EbkkCfkxjktQkWlnCuTJcOPMqj3sNwf0w2xx+44mPSJ422PdOP1jPe6zASsSpsq41w4
         sI0c1jRZ7wJpNaL7jgE1+SvB2j7hoVTnZtbNJ2LJWp4fNP5XiQ/w5ZwVFB7YuDIcJPjm
         SMVYBc87Ktc3Ru5UG7lsF7ihDA+esfWOtv/1W5/6C8ROJPdTk8QtJEH7tck1kgiK/yom
         R6uuGnH2079QMidvqGhuUp7BHenvpmNJRnb6LymwNnBmtgq1/pgiI8wV1+xefUXTxPru
         eNOA==
X-Gm-Message-State: AOJu0YxSTAaswgt5BGFspH9TshIAMLJdPxzZfE7nr6TVuROvhwBHDlgW
	gX4cEj2K8oo5UmIUoRy1gX4ISd4j8u9nczls/jLO1z1a8WWmB6NqP7Rk89yJMmPT
X-Gm-Gg: AfdE7clh4Qx0SMQsZUDeVjaGMgC3/zz63gnam/YxSj0rx8jPylK7gpApuJ6XH+phCWB
	reesonN8IW4JsubN4u+zHvK/MAOJoLqlgYJnNsnBCf6Kx8f8r62mgsoZjag49SU5m0wdqKxMOtP
	GKArKSMSvtgvfwWhKpZBQ7MyaJL5rqFbdzlrfAIrXlGwtPD4nA3tVCsX/rOno46MrZG9nknQyNc
	KP5+7ppOoh4ngG+axhWzTiveEeITNDefADJYLKRH8zx7Ul090obhLryIh8dDCMSuRGRVYx8P4ng
	ti7ur6T7or7De9By6BWExWEoRW1VmCBZjgjRkR6x/DR+nOwcgbURBjhhBOjh8/Id5tNEbylM2KU
	Ax+hOWspGNrDZY4PY0xpoCo0GLxBXfYVLx4BAphFDbLHW7/+jzRWA0bMvm47BLkri3FbmLh3Rb4
	Ut4WjWdwU4dfxdDt+qTabkHJ8xqICIuza+ZIPEJxD8lRkKAzFl
X-Received: by 2002:a05:6000:2884:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-475530280ccmr4569716f8f.28.1782820139394;
        Tue, 30 Jun 2026 04:48:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 30/39] clk: renesas: r9a08g046: Add IA55_PCLK to critical module clocks
Date: Tue, 30 Jun 2026 12:47:49 +0100
Message-ID: <20260630114813.92739-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23354

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 01a20f1c46ed8fdbc9c4c97de60fae1a49f81b48 ]

Add R9A08G046_IA55_PCLK to the critical module clocks list to prevent
the clock from being gated during suspend, as it is required for the
interrupt controller (IA55) to function correctly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430100838.157306-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index ce9503c3cfd1..0004b9516fdf 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -312,6 +312,7 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 
 static const unsigned int r9a08g046_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G046_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A08G046_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G046_IA55_CLK,
 	MOD_CLK_BASE + R9A08G046_DMAC_ACLK,
 };
-- 
2.43.0


