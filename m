Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ABDC46CC5
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.35262.1702041614073951457
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="185800341"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E7308400297E;
	Fri,  8 Dec 2023 22:20:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 05/25] drm: of: Mark empty drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep static
Date: Fri,  8 Dec 2023 13:19:47 +0000
Message-Id: <20231208132007.108762-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13948

From: Marek Vasut <marex@denx.de>

commit eb6b94db2f4a585d4a9b8e503d7377d2a23c1104 upstream.

Mark empty implementations of drm_of_get_data_lanes_count and
drm_of_get_data_lanes_ep as static inline, just like the rest
of empty implementations of various functions in drm_of.h .
Add missing comma to drm_of_get_data_lanes_count_ep() .

Fixes: fc801750b197 ("drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
To: dri-devel@lists.freedesktop.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20220612132152.91052-1-marex@denx.de
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/drm/drm_of.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 5a6bf7146028..7d7744934be9 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -105,16 +105,18 @@ drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 	return -EINVAL;
 }
 
-int drm_of_get_data_lanes_count(const struct device_node *endpoint,
-				const unsigned int min, const unsigned int max)
+static inline int
+drm_of_get_data_lanes_count(const struct device_node *endpoint,
+			    const unsigned int min, const unsigned int max)
 {
 	return -EINVAL;
 }
 
-int drm_of_get_data_lanes_count_ep(const struct device_node *port,
-				   int port_reg, int reg
-				   const unsigned int min,
-				   const unsigned int max)
+static inline int
+drm_of_get_data_lanes_count_ep(const struct device_node *port,
+			       int port_reg, int reg,
+			       const unsigned int min,
+			       const unsigned int max)
 {
 	return -EINVAL;
 }
-- 
2.25.1


