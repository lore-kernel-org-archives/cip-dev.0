Return-Path: <SRS0=0s86=IH=lists.cip-project.org=bounce+64572+6251+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6891C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EABE65237
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EABE65237
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6251+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pAAVYY4521723x4cvIPOy4yU; Tue, 09 Mar 2021 08:37:47 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:46 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342271"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:45 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05D3E40A2DC7;
	Wed, 10 Mar 2021 01:37:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 35/40] media: rcar-csi2: Enable support for R8A774E1
Date: Tue,  9 Mar 2021 16:36:51 +0000
Message-Id: <20210309163656.20944-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BQC0Y0fhXldnbUeQzCyL42ZSx4520388AA=
Content-Type: multipart/mixed; boundary="QOLR1Xs2lYVJHxgAui9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307867;
 bh=r4HsskLerJkDRonzcdqCfOkUlgDtTNJpA79IZ9oDFuA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=u3LKfQkO80ijtiWj6r/sECCi6jMyeliDVPOWXSVuSp1e79CBXvkNXcgIW2uVcP6Dhzg
 N0WBvwyizilhl3jlM84lgYaAuoROO60o1sYIl4Cv/hHQGVG+mkOH2+XLWJf9O6jfN5ZVC
 1FhSt0bGsGUE0E+Q0k24jH3q8v7JL9TmKZ0=

--QOLR1Xs2lYVJHxgAui9R
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit bc39d306450d0725dc82ac32a4d7a31588d3928e upstream.

Add the MIPI CSI-2 driver support for RZ/G2H (R8A774E1) SoC.
The CSI-2 module of RZ/G2H is similar to R-Car H3.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 852a70bf2957..64cdee7b1e7d 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -987,6 +987,10 @@ static const struct of_device_id rcar_csi2_of_table[] = {
 		.compatible = "renesas,r8a774c0-csi2",
 		.data = &rcar_csi2_info_r8a77990,
 	},
+	{
+		.compatible = "renesas,r8a774e1-csi2",
+		.data = &rcar_csi2_info_r8a7795,
+	},
 	{
 		.compatible = "renesas,r8a7795-csi2",
 		.data = &rcar_csi2_info_r8a7795,
-- 
2.17.1


--QOLR1Xs2lYVJHxgAui9R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6251): https://lists.cip-project.org/g/cip-dev/message=
/6251
Mute This Topic: https://lists.cip-project.org/mt/81205391/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QOLR1Xs2lYVJHxgAui9R--
