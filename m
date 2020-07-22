Return-Path: <SRS0=JH3N=BB=lists.cip-project.org=bounce+64572+4970+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E86C433ED
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1CA207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cNdFyy9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1CA207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4970+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WFiWYY4521723xtxV5GbNs3L; Wed, 22 Jul 2020 10:47:08 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.23134.1595435708098355441
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:15 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620974"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:15 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 946044006CC9;
	Thu, 23 Jul 2020 01:35:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 12/17] drm: rcar-du: lvds: Get dual link configuration from DT
Date: Wed, 22 Jul 2020 17:34:44 +0100
Message-Id: <20200722163449.3513-13-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IvK0tFa4PILLQt36WSbnP8kFx4520388AA=
Content-Type: multipart/mixed; boundary="8L3qhKVwqycs2Hn4sXUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440028;
 bh=niOh+7qVMnhiIWcEJZcWwHttnezuEElIbcqYvG6ImsM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cNdFyy9dRFlFFIX3Et3bOGU4AObAvxgNZ53HFp85Rk0tsVY5gRgVYr1wew5ZyyJKNpP
 tdA5wa0yOo8RW6QCvt1U+EYnvZcIeWU/lORxnMhsNrYJnE3HNN5KJQuBUrsZM9rPgWLi5
 neJ1wwgHKFsR3Vjfmd5IVXJazd5dFFx/GXc=

--8L3qhKVwqycs2Hn4sXUQ

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 65112cfa56c32030a7f04a8a4c28251b89b5cf26 upstream.

For dual-LVDS configurations, it is now possible to mark the
DT port nodes for the sink with boolean properties (like
dual-lvds-even-pixels and dual-lvds-odd-pixels) to let drivers
know the encoders need to be configured in dual-LVDS mode.

Rework the implementation of rcar_lvds_parse_dt_companion
to make use of the DT markers while keeping backward
compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 54 ++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index f81a0d730db8..12d2bbbb02f0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -670,7 +670,10 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 {
 	const struct of_device_id *match;
 	struct device_node *companion;
+	struct device_node *port0, *port1;
+	struct rcar_lvds *companion_lvds;
 	struct device *dev = lvds->dev;
+	int dual_link;
 	int ret = 0;
 
 	/* Locate the companion LVDS encoder for dual-link operation, if any. */
@@ -689,13 +692,54 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 		goto done;
 	}
 
+	/*
+	 * We need to work out if the sink is expecting us to function in
+	 * dual-link mode. We do this by looking at the DT port nodes we are
+	 * connected to, if they are marked as expecting even pixels and
+	 * odd pixels than we need to enable vertical stripe output.
+	 */
+	port0 = of_graph_get_port_by_id(dev->of_node, 1);
+	port1 = of_graph_get_port_by_id(companion, 1);
+	dual_link = drm_of_lvds_get_dual_link_pixel_order(port0, port1);
+	of_node_put(port0);
+	of_node_put(port1);
+
+	if (dual_link >= DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS)
+		lvds->dual_link = true;
+	else if (lvds->next_bridge && lvds->next_bridge->timings)
+		/*
+		 * Early dual-link bridge specific implementations populate the
+		 * timings field of drm_bridge, read the dual_link flag off the
+		 * bridge directly for backward compatibility.
+		 */
+		lvds->dual_link = lvds->next_bridge->timings->dual_link;
+
+	if (!lvds->dual_link) {
+		dev_dbg(dev, "Single-link configuration detected\n");
+		goto done;
+	}
+
 	lvds->companion = of_drm_find_bridge(companion);
 	if (!lvds->companion) {
 		ret = -EPROBE_DEFER;
 		goto done;
 	}
 
-	dev_dbg(dev, "Found companion encoder %pOF\n", companion);
+	dev_dbg(dev,
+		"Dual-link configuration detected (companion encoder %pOF)\n",
+		companion);
+
+	/*
+	 * FIXME: We should not be messing with the companion encoder private
+	 * data from the primary encoder, we should rather let the companion
+	 * encoder work things out on its own. However, the companion encoder
+	 * doesn't hold a reference to the primary encoder, and
+	 * drm_of_lvds_get_dual_link_pixel_order needs to be given references
+	 * to the output ports of both encoders, therefore leave it like this
+	 * for the time being.
+	 */
+	companion_lvds = bridge_to_rcar_lvds(lvds->companion);
+	companion_lvds->dual_link = true;
 
 done:
 	of_node_put(companion);
@@ -712,13 +756,7 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 	if (ret)
 		goto done;
 
-	if ((lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK) &&
-	    lvds->next_bridge)
-		lvds->dual_link = lvds->next_bridge->timings
-				? lvds->next_bridge->timings->dual_link
-				: false;
-
-	if (lvds->dual_link)
+	if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK)
 		ret = rcar_lvds_parse_dt_companion(lvds);
 
 done:
-- 
2.17.1


--8L3qhKVwqycs2Hn4sXUQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4970): https://lists.cip-project.org/g/cip-dev/message=
/4970
Mute This Topic: https://lists.cip-project.org/mt/75730032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8L3qhKVwqycs2Hn4sXUQ--
