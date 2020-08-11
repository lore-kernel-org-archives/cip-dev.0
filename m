Return-Path: <SRS0=58HZ=BV=lists.cip-project.org=bounce+64572+5109+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20335C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7672076B
	for <cip-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="b44buvqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7672076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5109+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w6ZWYY4521723xfRAOZ4yioT; Tue, 11 Aug 2020 07:42:47 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.16438.1597156846473846667
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2020 07:40:46 -0700
X-IronPort-AV: E=Sophos;i="5.75,461,1589209200"; 
   d="scan'208";a="54374513"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Aug 2020 23:40:43 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.148])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 010984005E34;
	Tue, 11 Aug 2020 23:40:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH] drm: of: Fix linking when CONFIG_OF is not set
Date: Tue, 11 Aug 2020 15:40:40 +0100
Message-Id: <20200811144040.4398-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sKfZzkUpl82krYNnMMmxAvA4x4520388AA=
Content-Type: multipart/mixed; boundary="roOWA75eHBGOgEseOOVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597156967;
 bh=MMSybbP7aWS0wCI+4TNHkzvc8R9OJ8b05XiXV2ysobM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=b44buvqUVi4rULwiQUzF/DyoY3/1dzImp1ipl/KD49MKm2IvHgefqmwnfrqoXUWcv92
 KhjTKawk9AKib81dVqzkV8HQyQ/JgxPHgbodGoyBkY0mXUCftigO9LoVpUKufFuDCjoCM
 OcdRO6du7CGCTc5iGm1tnMcY/9yuVRDJfSQ=

--roOWA75eHBGOgEseOOVO

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 528d06d41b80a4acb2a9efd33bfc87495147f75e upstream.

The new helper drm_of_lvds_get_dual_link_pixel_order() introduced in
commit 6529007522de has a fallback stub when CONFIG_OF is not set, but
the stub is declared in drm_of.h without a static inline. This causes
multiple definitions of the function to be linked when the CONFIG_OF
option isn't set. Fix it by making the stub static inline.

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191219103703.8547-1-laurent.pinchart+renesas@ideasonboard.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/drm/drm_of.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 8ec7ca6d2369..b9b093add92e 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -92,8 +92,9 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return -EINVAL;
 }
 
-int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
-					  const struct device_node *port2)
+static inline int
+drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+				      const struct device_node *port2)
 {
 	return -EINVAL;
 }
-- 
2.17.1


--roOWA75eHBGOgEseOOVO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5109): https://lists.cip-project.org/g/cip-dev/message=
/5109
Mute This Topic: https://lists.cip-project.org/mt/76127518/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--roOWA75eHBGOgEseOOVO--
