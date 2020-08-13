Return-Path: <SRS0=cdJa=BX=lists.cip-project.org=bounce+64572+5119+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D473BC433E1
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:24 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E9B21744
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hDZM1C0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E9B21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5119+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id W9YZYY4521723x4NQ2jCLPHb; Thu, 13 Aug 2020 04:43:16 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.6052.1597307971727151403
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 01:39:32 -0700
X-IronPort-AV: E=Sophos;i="5.76,307,1592838000"; 
   d="scan'208";a="54503598"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2020 17:39:28 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.189])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C4DD541F86D1;
	Thu, 13 Aug 2020 17:39:26 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] drm: Add drm_atomic_get_old/new_private_obj_state
Date: Thu, 13 Aug 2020 09:39:24 +0100
Message-Id: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4DdaLpuqgre56oWEXIJzH6b9x4520388AA=
Content-Type: multipart/mixed; boundary="fyyMJIBK68shYmCwfQUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318996;
 bh=EbgANxjr8DQs/zA2OiKqHczwN9Zlzk1ClGCvEIz3O4k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hDZM1C0fUFA2ol1cPOWCj21HUssc9fMFx8gVRzUaU4ADl2fHRLef9bbfS9QwZz2l3mP
 PnLVu7uvyuIJQhbPZMbayzWk28ej5RlaLoi/ECqZKoEEO+EHWaDLlj8hM6Ox2Tk/wYAZI
 +FC25iYz8yA3sfDVB6YZmtxqNVmL/ZnTwzI=

--fyyMJIBK68shYmCwfQUl

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

commit 9801a7eadf4cc29cdc90583a49f12decbb832ced upstream.

This pair of functions return the old/new private object state for the
given private_obj, or NULL if the private_obj is not part of the global
atomic state.

Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[removed changes in drivers/gpu/drm/drm_atomic.c, since the same changes
are already present as part of the commit 60b4667275b6]
---
 include/drm/drm_atomic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index c0b48e25a620..6329ed4af310 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -402,6 +402,12 @@ void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
 
 struct drm_connector *
 drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
-- 
2.17.1


--fyyMJIBK68shYmCwfQUl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5119): https://lists.cip-project.org/g/cip-dev/message=
/5119
Mute This Topic: https://lists.cip-project.org/mt/76165488/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fyyMJIBK68shYmCwfQUl--
