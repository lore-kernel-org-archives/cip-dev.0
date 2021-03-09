Return-Path: <SRS0=xchB=IH=lists.cip-project.org=bounce+64572+6224+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B96EC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CAE64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CAE64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6224+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9ADpYY4521723xO9zqxgCZ1v; Tue, 09 Mar 2021 08:37:10 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:10 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342226"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:09 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E7E5540A2DC7;
	Wed, 10 Mar 2021 01:37:08 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 08/40] media: rcar-csi2: Update V3M and E3 start procedure
Date: Tue,  9 Mar 2021 16:36:24 +0000
Message-Id: <20210309163656.20944-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dvJCHoY1A9cvB6XxvwDKNIslx4520388AA=
Content-Type: multipart/mixed; boundary="KMolM8J7zTyQgybXTkgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307830;
 bh=xfsYAa8dDY8CuQ+UbpbdauCSbKf0FzbRVRh8gG84Kk0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Cv1SEtYZTg/F8HEk15Y9V6yxkclL6lCQSsSs79YlBV4C8weKCmZUsy+lY0dT0Ijldfz
 WkRCS0PndgzRRCqUiUWk+Z6WDs8KSAZiAaQkQP0EKa+292ebCLCzeNNC5NGLm8vXChFp/
 70AuLU6yJ+CnU7vo1YX+ci+ZboX6ctZ/PBo=

--KMolM8J7zTyQgybXTkgi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit c1421f1d6c29d6b6234e5b0894ef16b3f2a172e0 upstream.

The latest datasheet (rev 1.50) updates the start procedure for V3M and
E3. Update the driver to match these changes.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 007e2383d34e..1c910fdbf4c0 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -898,11 +898,11 @@ static int rcsi2_init_phtw_v3m_e3(struct rcar_csi2 *priv, unsigned int mbps)
 static int rcsi2_confirm_start_v3m_e3(struct rcar_csi2 *priv)
 {
 	static const struct phtw_value step1[] = {
-		{ .data = 0xed, .code = 0x34 },
-		{ .data = 0xed, .code = 0x44 },
-		{ .data = 0xed, .code = 0x54 },
-		{ .data = 0xed, .code = 0x84 },
-		{ .data = 0xed, .code = 0x94 },
+		{ .data = 0xee, .code = 0x34 },
+		{ .data = 0xee, .code = 0x44 },
+		{ .data = 0xee, .code = 0x54 },
+		{ .data = 0xee, .code = 0x84 },
+		{ .data = 0xee, .code = 0x94 },
 		{ /* sentinel */ },
 	};
 
-- 
2.17.1


--KMolM8J7zTyQgybXTkgi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6224): https://lists.cip-project.org/g/cip-dev/message=
/6224
Mute This Topic: https://lists.cip-project.org/mt/81205349/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KMolM8J7zTyQgybXTkgi--
