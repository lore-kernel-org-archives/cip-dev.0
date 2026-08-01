Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDDDC55182
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2477.1785575706855744738
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eA+BYKLT;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso6333725e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575705; x=1786180505; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZDjyUQIjfnSBuc1kNDjK7QK9hy0MxgIaqzqXMYomww=;
        b=eA+BYKLTiKttMGnyhspJ3f00cZCz4fOblv4GBEN0F+ufA49y8ZdNWy9mGh0ffqhj6L
         6sMQb6wyFBRDPyrolH3Uwwp5KrD2n46Py3RqGbWgD8b71Q0g2X/46+/JOVxqP+nvrOxi
         4vcMqTd690i05lUkAoW8VPlGSG3PTDyQMVAJI1szzrZFc63j03mp5DVyjvYWir65KwW6
         0C9pqzKyAV4YlnBHNZnx/i0WmHQA12G8iH487bkDxMlR4nadUK/wedAy3QqQ0zveSSfF
         f9GNxaU/Jb2UFpTY/V8g97KYoMGOmIiw9vB7OZVNpUffyMiCgnUiGLni2BfMM9jpLQX0
         PAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575705; x=1786180505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZDjyUQIjfnSBuc1kNDjK7QK9hy0MxgIaqzqXMYomww=;
        b=bE1lHrxeoXz6AMnfbEHuuvLE8oB8M3E/Pn/qQN9v99Us3rfutIvzhCpW9yaAhThFs4
         wsUnLDsbXLaem9F//0FlwHi0mF4gb/DwiJ1TAubQInve7KTX3TBr89qBCCNrPuipRb5V
         jLNqVoCH1lBxl1Ob96t9LsX0obqIJEswc2WtWfRyg1OJbBwT4UX7+Eo+SobXPaFKvvWD
         ys7KfvGiHMjHUhPdKMOSG1Ooa2/B6B8JVHNWwbF4oC2VCIetJegeMmrY1ltVFir6QIDJ
         L1qzTsEyXVg4sytY+cdRxahKP78SkpOYu6oq2rPskj+v2CiaFOi6xJd3Ft89S9LLdRBa
         vriQ==
X-Gm-Message-State: AOJu0Yzbc+BEBbNk/HWaRUdCE8ouObJDrBNZgEfcHmTemtkLE3jpjsq6
	eyjBiYVZ7W14H72reP2dDQm5GyHbnU+mYrNx9BlRLh0VH1YkFkYRmHHFtvYqhg==
X-Gm-Gg: AR+sD10sRyRoRrWhac+tpuLtCqIGdQ1BUSIk7NMxxWta2YPoFediyFkVR0yQGkhVYz8
	eAGFQCWRVd54O+Pj+uIRt5xhtFhlvHhNfb3+LPReF6qHee+7cW3NPtUqo+ysC7PVCynqZHQZWel
	YnHtWoG3f1YWVAnTntefKcwjMsM0q/lriw3SA4RnsB+Q34kUKVP3NSPrDuoKwKm0iIysMcLl2cS
	wUFxENgRzhmmOYden7zf6vvXj/OOecaFvJ5Idu6vaAMSdHAg80qK80o/5jvrrce6K7iXs0EZ0A7
	mijfBNllS//OwGn6NrY5DAEA6Ido4N976eISPAuv9ISMQoNC22IGeW5P8TVRpNEoIoXgIeT9UCl
	RABSk89/iPvbetmAV+5nIkHGgIkFT83rjR/wSoYsuaXzUvHKIcN2VE4wzE8PqAnPfT7UgSlLnnv
	uldjASEAcTpKZ4R3MbmnYqFazR76CM1qfJnGZhnumorVOidEt/LDxha9I+f99o+/duLdxtQ8Ois
	U8kj8ZDNXA4qQ==
X-Received: by 2002:a05:600c:c113:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4980c674e1dmr29961875e9.10.1785575705061;
        Sat, 01 Aug 2026 02:15:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/19] clk: renesas: rzg2l: Rename RZG3L-prefixed PLL macros to CPG-prefixed ones
Date: Sat,  1 Aug 2026 10:14:38 +0100
Message-ID: <20260801091458.14026-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23834

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c94433be057ba23071215a4cd6f743cb2757431c ]

Rename RZG3L_PLL_STBY_OFFSET(), RZG3L_PLL_STBY_RESETB,
RZG3L_PLL_STBY_RESETB_WEN, RZG3L_PLL_MON_OFFSET(), RZG3L_PLL_MON_RESETB,
and RZG3L_PLL_MON_LOCK to their CPG_PLL_* equivalents to reflect that
these macros are not RZG3L-specific and are shared across SoCs.

Also fold CPG_PLL_MON_OFFSET() into rzg2l-cpg.c alongside the other
CPG_PLL_*_OFFSET() helpers introduced in previous patches.

No functional changes.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260519141518.389670-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index bb63404922e5..cfa7aa82d4bc 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -60,15 +60,13 @@
 
 #define CPG_PLL1_SETTING_OFFSET(conf)	FIELD_GET(GENMASK(11, 0), (conf))
 #define CPG_PLL_STBY_OFFSET(conf)	FIELD_GET(GENMASK(23, 12), (conf))
+#define CPG_PLL_STBY_RESETB_WEN		BIT(16)
+#define CPG_PLL_STBY_RESETB		BIT(0)
 #define CPG_PLL_CLK1_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0x4)
 #define CPG_PLL_CLK2_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0x8)
-
-#define RZG3L_PLL_STBY_OFFSET(x)	(CPG_PLL_STBY_OFFSET(x))
-#define RZG3L_PLL_STBY_RESETB		BIT(0)
-#define RZG3L_PLL_STBY_RESETB_WEN	BIT(16)
-#define RZG3L_PLL_MON_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0xc)
-#define RZG3L_PLL_MON_RESETB		BIT(0)
-#define RZG3L_PLL_MON_LOCK		BIT(4)
+#define CPG_PLL_MON_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0xc)
+#define CPG_PLL_MON_LOCK		BIT(4)
+#define CPG_PLL_MON_RESETB		BIT(0)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
@@ -1189,8 +1187,8 @@ static int rzg3l_cpg_pll_clk_is_enabled(struct clk_hw *hw)
 {
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
-	u32 val = readl(priv->base + RZG3L_PLL_MON_OFFSET(pll_clk->conf));
-	u32 mon_val = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
+	u32 val = readl(priv->base + CPG_PLL_MON_OFFSET(pll_clk->conf));
+	u32 mon_val = CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK;
 
 	/* Ensure both RESETB and LOCK bits are set */
 	return (mon_val == (val & mon_val));
@@ -1200,17 +1198,17 @@ static int rzg3l_cpg_pll_clk_endisable(struct clk_hw *hw, bool enable)
 {
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
-	u32 mon_mask = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
-	u32 val = RZG3L_PLL_STBY_RESETB_WEN;
+	u32 mon_mask = CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK;
+	u32 val = CPG_PLL_STBY_RESETB_WEN;
 	u32 stby_offset, mon_offset;
 	u32 mon_val = 0;
 	int ret;
 
-	stby_offset = RZG3L_PLL_STBY_OFFSET(pll_clk->conf);
-	mon_offset = RZG3L_PLL_MON_OFFSET(pll_clk->conf);
+	stby_offset = CPG_PLL_STBY_OFFSET(pll_clk->conf);
+	mon_offset = CPG_PLL_MON_OFFSET(pll_clk->conf);
 
 	if (enable) {
-		val |= RZG3L_PLL_STBY_RESETB;
+		val |= CPG_PLL_STBY_RESETB;
 		mon_val = mon_mask;
 	}
 
-- 
2.43.0


