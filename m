Return-Path: <SRS0=MnQw=IH=lists.cip-project.org=bounce+64572+6246+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993EBC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6426C64FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6426C64FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6246+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uEPlYY4521723xnXhRog3811; Tue, 09 Mar 2021 08:37:40 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:39 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342263"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:39 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E44140A3D20;
	Wed, 10 Mar 2021 01:37:38 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 30/40] media: rcar-csi2: Enable support for R8A774B1
Date: Tue,  9 Mar 2021 16:36:46 +0000
Message-Id: <20210309163656.20944-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AhzmDMIyHOJK6FmscaSwyf4jx4520388AA=
Content-Type: multipart/mixed; boundary="1Y5jN8xBMzk8toE3gunC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307860;
 bh=qDityquNK3bI457ioV//1kHbZUAgn/72cccCMlQj1ZA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cXEmKljZ8gC0p4ol/rNdOjmUGe3vpWHJipNSCk4VfozxW3Ts2xGGtNzwvP6lsyqbJj/
 z/4P92YkclxkiecHPAkZnbB/vm248q+CnJxj5HrajSbEW1nqQvrz+IfEkggZkEPvtZXZT
 i7xfTj2x/aNw5RMtXwY1X8TudAVyNEA/qJI=

--1Y5jN8xBMzk8toE3gunC

From: Biju Das <biju.das@bp.renesas.com>

commit 5ebc4b2eb4338e3c936bf095d688141bf916daf2 upstream.

Add the MIPI CSI-2 driver support for RZ/G2N(R8A774B1) SoC.
The CSI-2 module of RZ/G2N is similar to R-Car M3-N.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index fa13e3ab0709..852a70bf2957 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -979,6 +979,10 @@ static const struct of_device_id rcar_csi2_of_table[] = {
 		.compatible = "renesas,r8a774a1-csi2",
 		.data = &rcar_csi2_info_r8a7796,
 	},
+	{
+		.compatible = "renesas,r8a774b1-csi2",
+		.data = &rcar_csi2_info_r8a77965,
+	},
 	{
 		.compatible = "renesas,r8a774c0-csi2",
 		.data = &rcar_csi2_info_r8a77990,
-- 
2.17.1


--1Y5jN8xBMzk8toE3gunC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6246): https://lists.cip-project.org/g/cip-dev/message=
/6246
Mute This Topic: https://lists.cip-project.org/mt/81205380/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1Y5jN8xBMzk8toE3gunC--
