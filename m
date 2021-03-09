Return-Path: <SRS0=hK+6=IH=lists.cip-project.org=bounce+64572+6244+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1DC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E9964FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E9964FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6244+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xE4hYY4521723xXTAbHIZfkU; Tue, 09 Mar 2021 08:37:38 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:37 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342260"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:36 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9DD1340A2DC7;
	Wed, 10 Mar 2021 01:37:35 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 28/40] media: rcar-vin: Enable support for R8A774B1
Date: Tue,  9 Mar 2021 16:36:44 +0000
Message-Id: <20210309163656.20944-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zTyZiOp5phNrGEEEOeh4rLIKx4520388AA=
Content-Type: multipart/mixed; boundary="DqYUvK9MQbv6Fkqyc6Rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307858;
 bh=tXc3w6xKVqZ5KntYYQr29iqgnb+RDFbWwoPantAFwAI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uRT/W/u+Pu8aB039k/2GzUZmCHrRy9TUEDkWWy+IxbyM0y9dO1dtqupWtlLI7AjW5+P
 bN3PxxQOBllEP7zTmnI8FGNMjg/8Jb1rRDkYRM1zoiGBLcn95uLqZTLeg09+NuvRgr80u
 o6PBi5tYpb+J6O1D9ID1bIJi+Z4WgiI/lv8=

--DqYUvK9MQbv6Fkqyc6Rw

From: Biju Das <biju.das@bp.renesas.com>

commit 3f9402a09f212c321f65eda926555e8448b9c365 upstream.

Add the SoC specific information for RZ/G2N(R8A774B1) SoC.
The VIN module of RZ/G2N is similar to R-Car M3-N.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index c8856fed737f..734686810438 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -1122,6 +1122,10 @@ static const struct of_device_id rvin_of_id_table[] = {
 		.compatible = "renesas,vin-r8a774a1",
 		.data = &rcar_info_r8a7796,
 	},
+	{
+		.compatible = "renesas,vin-r8a774b1",
+		.data = &rcar_info_r8a77965,
+	},
 	{
 		.compatible = "renesas,vin-r8a774c0",
 		.data = &rcar_info_r8a77990,
-- 
2.17.1


--DqYUvK9MQbv6Fkqyc6Rw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6244): https://lists.cip-project.org/g/cip-dev/message=
/6244
Mute This Topic: https://lists.cip-project.org/mt/81205377/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DqYUvK9MQbv6Fkqyc6Rw--
