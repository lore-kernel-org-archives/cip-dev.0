Return-Path: <SRS0=CgoS=BX=lists.cip-project.org=bounce+64572+5120+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24419C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:08 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F520771
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Y/C0siW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F520771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5120+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sSqjYY4521723xbNlMRraMeg; Thu, 13 Aug 2020 04:42:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.6054.1597307972834019613
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 01:39:33 -0700
X-IronPort-AV: E=Sophos;i="5.76,307,1592838000"; 
   d="scan'208";a="54503603"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2020 17:39:30 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.189])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9521741F86D1;
	Thu, 13 Aug 2020 17:39:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/2] drm: atomic helper: fix W=1 warnings
Date: Thu, 13 Aug 2020 09:39:25 +0100
Message-Id: <20200813083925.7830-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
References: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cni8UZVIzVFrFdGsRBhnlJBJx4520388AA=
Content-Type: multipart/mixed; boundary="ewSCA4AltHB6W8djZCOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318979;
 bh=w2AJoChGDT1jkUvEQ+qoIUqsi+pICkYTuv8RaFq2yzA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Y/C0siW0Lj2VQhLKD8Q45z+Ukwn2VgCl93UkJR7teyy6b9lnDwARjeDq7rJZOhmsKAN
 UWUkOq22W5Wg1SGo8vu5VSb2R7f/mCtgV4injnGPOXC6jPYC/4QgrIDmfsuqEUYbGhzrU
 QjXkWTbNW7zNsKBH9kzmCCH7BfbcVMB0D1Y=

--ewSCA4AltHB6W8djZCOa

From: Benjamin Gaignard <benjamin.gaignard@st.com>

commit bf5d837a0a4ced7cc223befc9e76d4ad30697d27 upstream.

Few for_each macro set variables that are never used later which led
to generate unused-but-set-variable warnings.
Add (void)(foo) inside the macros to remove these warnings

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20191008124254.2144-1-benjamin.gaignard@st.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/drm/drm_atomic.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 6329ed4af310..9042fdae9211 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -662,6 +662,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
 			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
 
@@ -683,6 +684,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
 
 /**
@@ -703,7 +705,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
-			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
+			     (new_connector_state) = (__state)->connectors[__i].new_state, \
+			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
@@ -723,7 +727,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
+			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
+			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
 			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
 
 /**
@@ -762,7 +768,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
-			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
+			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
+			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
+			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
@@ -782,6 +790,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
 			      (old_plane_state) = (__state)->planes[__i].old_state,\
 			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
 
@@ -842,7 +851,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_private_obj_in_state - iterate over all private objects in an atomic update
-- 
2.17.1


--ewSCA4AltHB6W8djZCOa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5120): https://lists.cip-project.org/g/cip-dev/message=
/5120
Mute This Topic: https://lists.cip-project.org/mt/76165489/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ewSCA4AltHB6W8djZCOa--
