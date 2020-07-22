Return-Path: <SRS0=jX5D=BB=lists.cip-project.org=bounce+64572+4962+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFBC433E3
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130C1207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vQhe5gMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C1207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4962+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7uz3YY4521723xz3rAitCbZe; Wed, 22 Jul 2020 10:47:06 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.23009.1595435695048125216
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620941"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:34:54 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C792E4006CC9;
	Thu, 23 Jul 2020 01:34:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/17] drm: rcar-du: lvds: Remove LVDS double-enable checks
Date: Wed, 22 Jul 2020 17:34:33 +0100
Message-Id: <20200722163449.3513-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5g4zo0ZRO7D3DEG0jKmHXLidx4520388AA=
Content-Type: multipart/mixed; boundary="yOIZ5LzWvzWEmZx51SEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440026;
 bh=4X16FVJmtTakXpGDUR7jZCkAL+uMiBCTDV9XgYvbXLI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vQhe5gMSr9M8i6A4mrVuszG8xggzJ9QLS42Iza/7k4t1aM0CdBSVEYQUQh0mxMZd1i1
 LZEJ5nAon+YwOpDNaZFDucgWuHaKbV/V4h4fdMCJLxhajQbSs59DM4U2jPmQdm7G4SgOT
 RvQ1m+3NcfThuP/jCh1QyYb5TnkqsXftOAM=

--yOIZ5LzWvzWEmZx51SEa

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 968328496b0fbee42abb6fae98ba0dc720bda977 upstream.

The DRM core and DU driver guarantee that the LVDS bridge will not be
double-enabled or double-disabled. Remove the corresponding unnecessary
checks.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 21fd248e5cbf..067017d25993 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -62,7 +62,6 @@ struct rcar_lvds {
 		struct clk *extal;		/* External clock */
 		struct clk *dotclkin[2];	/* External DU clocks */
 	} clocks;
-	bool enabled;
 
 	struct drm_display_mode display_mode;
 	enum rcar_lvds_mode mode;
@@ -367,15 +366,12 @@ int rcar_lvds_clk_enable(struct drm_bridge *bridge, unsigned long freq)
 
 	dev_dbg(lvds->dev, "enabling LVDS PLL, freq=%luHz\n", freq);
 
-	WARN_ON(lvds->enabled);
-
 	ret = clk_prepare_enable(lvds->clocks.mod);
 	if (ret < 0)
 		return ret;
 
 	__rcar_lvds_pll_setup_d3_e3(lvds, freq, true);
 
-	lvds->enabled = true;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rcar_lvds_clk_enable);
@@ -389,13 +385,9 @@ void rcar_lvds_clk_disable(struct drm_bridge *bridge)
 
 	dev_dbg(lvds->dev, "disabling LVDS PLL\n");
 
-	WARN_ON(!lvds->enabled);
-
 	rcar_lvds_write(lvds, LVDPLLCR, 0);
 
 	clk_disable_unprepare(lvds->clocks.mod);
-
-	lvds->enabled = false;
 }
 EXPORT_SYMBOL_GPL(rcar_lvds_clk_disable);
 
@@ -416,8 +408,6 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 	u32 lvdcr0;
 	int ret;
 
-	WARN_ON(lvds->enabled);
-
 	ret = clk_prepare_enable(lvds->clocks.mod);
 	if (ret < 0)
 		return;
@@ -502,16 +492,12 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 		drm_panel_prepare(lvds->panel);
 		drm_panel_enable(lvds->panel);
 	}
-
-	lvds->enabled = true;
 }
 
 static void rcar_lvds_disable(struct drm_bridge *bridge)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
 
-	WARN_ON(!lvds->enabled);
-
 	if (lvds->panel) {
 		drm_panel_disable(lvds->panel);
 		drm_panel_unprepare(lvds->panel);
@@ -522,8 +508,6 @@ static void rcar_lvds_disable(struct drm_bridge *bridge)
 	rcar_lvds_write(lvds, LVDPLLCR, 0);
 
 	clk_disable_unprepare(lvds->clocks.mod);
-
-	lvds->enabled = false;
 }
 
 static bool rcar_lvds_mode_fixup(struct drm_bridge *bridge,
@@ -587,8 +571,6 @@ static void rcar_lvds_mode_set(struct drm_bridge *bridge,
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
 
-	WARN_ON(lvds->enabled);
-
 	lvds->display_mode = *adjusted_mode;
 
 	rcar_lvds_get_lvds_mode(lvds);
@@ -788,7 +770,6 @@ static int rcar_lvds_probe(struct platform_device *pdev)
 
 	lvds->dev = &pdev->dev;
 	lvds->info = of_device_get_match_data(&pdev->dev);
-	lvds->enabled = false;
 
 	ret = rcar_lvds_parse_dt(lvds);
 	if (ret < 0)
-- 
2.17.1


--yOIZ5LzWvzWEmZx51SEa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4962): https://lists.cip-project.org/g/cip-dev/message=
/4962
Mute This Topic: https://lists.cip-project.org/mt/75730024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--yOIZ5LzWvzWEmZx51SEa--
