Return-Path: <SRS0=Ey25=BB=lists.cip-project.org=bounce+64572+4969+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35710C433EA
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0A2207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PYqO4Kau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0A2207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4969+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G5XoYY4521723xdZtBnjGu83; Wed, 22 Jul 2020 10:47:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23014.1595435704158275348
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:11 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832242"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:11 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C96FC40078CA;
	Thu, 23 Jul 2020 01:35:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 10/17] drm: rcar-du: lvds: Improve identification of panels
Date: Wed, 22 Jul 2020 17:34:42 +0100
Message-Id: <20200722163449.3513-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IhJ26BxWNXfy3hTB8wVUh32Ox4520388AA=
Content-Type: multipart/mixed; boundary="sBeJT7K9BWzNRAnm2hIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440027;
 bh=hVAvajCwQYbnqjirp77qkS7CpgSwDPiu2f7oK0Vjnz0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PYqO4KauWF6CdKWGtr26RVCOdGhtymRXmaE8E2PTvhyJG/0+1t4n0ZU4mCtLqF1ZiQi
 koy+Z6geSV44maIOCYcgHtBoNlM9oiu8zMvOoflTWjPlxjmiMQdmW8sEAvUXCVASPyxTs
 98UAQxHBI6usX1O6IGBi2cCNd1cGp17aqT8=

--sBeJT7K9BWzNRAnm2hIa

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 990e378db4450f930aefbe8c31a50b8504fe0e8b upstream.

Dual-LVDS panels are mistakenly identified as bridges, this
commit replaces the current logic with a call to
drm_of_find_panel_or_bridge to sort that out.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 75 ++++-------------------------
 1 file changed, 10 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index aa07af7d944f..f81a0d730db8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -20,6 +20,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include "rcar_lvds.h"
@@ -704,79 +705,23 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 
 static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 {
-	struct device_node *local_output = NULL;
-	struct device_node *remote_input = NULL;
-	struct device_node *remote = NULL;
-	struct device_node *node;
-	bool is_bridge = false;
-	int ret = 0;
-
-	local_output = of_graph_get_endpoint_by_regs(lvds->dev->of_node, 1, 0);
-	if (!local_output) {
-		dev_dbg(lvds->dev, "unconnected port@1\n");
-		ret = -ENODEV;
-		goto done;
-	}
-
-	/*
-	 * Locate the connected entity and infer its type from the number of
-	 * endpoints.
-	 */
-	remote = of_graph_get_remote_port_parent(local_output);
-	if (!remote) {
-		dev_dbg(lvds->dev, "unconnected endpoint %pOF\n", local_output);
-		ret = -ENODEV;
-		goto done;
-	}
+	int ret;
 
-	if (!of_device_is_available(remote)) {
-		dev_dbg(lvds->dev, "connected entity %pOF is disabled\n",
-			remote);
-		ret = -ENODEV;
+	ret = drm_of_find_panel_or_bridge(lvds->dev->of_node, 1, 0,
+					  &lvds->panel, &lvds->next_bridge);
+	if (ret)
 		goto done;
-	}
 
-	remote_input = of_graph_get_remote_endpoint(local_output);
-
-	for_each_endpoint_of_node(remote, node) {
-		if (node != remote_input) {
-			/*
-			 * We've found one endpoint other than the input, this
-			 * must be a bridge.
-			 */
-			is_bridge = true;
-			of_node_put(node);
-			break;
-		}
-	}
-
-	if (is_bridge) {
-		lvds->next_bridge = of_drm_find_bridge(remote);
-		if (!lvds->next_bridge) {
-			ret = -EPROBE_DEFER;
-			goto done;
-		}
-
-		if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK)
-			lvds->dual_link = lvds->next_bridge->timings
-					? lvds->next_bridge->timings->dual_link
-					: false;
-	} else {
-		lvds->panel = of_drm_find_panel(remote);
-		if (IS_ERR(lvds->panel)) {
-			ret = PTR_ERR(lvds->panel);
-			goto done;
-		}
-	}
+	if ((lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK) &&
+	    lvds->next_bridge)
+		lvds->dual_link = lvds->next_bridge->timings
+				? lvds->next_bridge->timings->dual_link
+				: false;
 
 	if (lvds->dual_link)
 		ret = rcar_lvds_parse_dt_companion(lvds);
 
 done:
-	of_node_put(local_output);
-	of_node_put(remote_input);
-	of_node_put(remote);
-
 	/*
 	 * On D3/E3 the LVDS encoder provides a clock to the DU, which can be
 	 * used for the DPAD output even when the LVDS output is not connected.
-- 
2.17.1


--sBeJT7K9BWzNRAnm2hIa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4969): https://lists.cip-project.org/g/cip-dev/message=
/4969
Mute This Topic: https://lists.cip-project.org/mt/75730031/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sBeJT7K9BWzNRAnm2hIa--
