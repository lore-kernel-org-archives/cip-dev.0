Return-Path: <SRS0=9Zp2=BB=lists.cip-project.org=bounce+64572+4963+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98CC433DF
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FF3207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jliLO4/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FF3207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4963+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KKU3YY4521723xv6zkgaJsqd; Wed, 22 Jul 2020 10:47:06 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23008.1595435694445769823
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:34:56 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832217"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:34:56 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA1E340078CA;
	Thu, 23 Jul 2020 01:34:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/17] drm: bridge: Add dual_link field to the drm_bridge_timings structure
Date: Wed, 22 Jul 2020 17:34:34 +0100
Message-Id: <20200722163449.3513-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cemgB2qKqekrMe3MaqLMFhXxx4520388AA=
Content-Type: multipart/mixed; boundary="5Xnj4a0kPXOLKo2hAHrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440026;
 bh=KaGGbwVGrzYccMWusGGpGBBOZXPUDBHO4wWLUZZ31Mw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jliLO4/lmVt/AK4EtMmC5BVNhkNFFCdaqZ6tUUAvBBxi3VRfdi37RT+JUhaUgZOteG6
 5u7jaVkDepgGfOXfhRLLQeHgyEa0+end+CCJIxSDCGAEO7NFwWrudiGyfS1LQto2XlAcH
 Ql5hhLGNkALGz5CH1Ese0gDOWOYyljIoPfs=

--5Xnj4a0kPXOLKo2hAHrB

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit b0a6b94027c85857f768a586cbcf1e96ee1d04ae upstreaam.

Extend the drm_bridge_timings structure with a new dual_link field to
indicate that the bridge's input bus carries data on two separate
physical links. The first use case is LVDS dual-link mode where even-
and odd-numbered pixels are transferred on separate LVDS links.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/drm/drm_bridge.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..d26eaa317fc2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -266,6 +266,14 @@ struct drm_bridge_timings {
 	 * input signal after the clock edge.
 	 */
 	u32 hold_time_ps;
+	/**
+	 * @dual_link:
+	 *
+	 * True if the bus operates in dual-link mode. The exact meaning is
+	 * dependent on the bus type. For LVDS buses, this indicates that even-
+	 * and odd-numbered pixels are received on separate links.
+	 */
+	bool dual_link;
 };
 
 /**
-- 
2.17.1


--5Xnj4a0kPXOLKo2hAHrB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4963): https://lists.cip-project.org/g/cip-dev/message=
/4963
Mute This Topic: https://lists.cip-project.org/mt/75730025/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5Xnj4a0kPXOLKo2hAHrB--
