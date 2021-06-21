Return-Path: <SRS0=Kr1z=LP=lists.cip-project.org=bounce+64572+6560+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71DC48BC2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAF260E0B
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAF260E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6560+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VDfkYY4521723xD0Wfv0Ozxh; Mon, 21 Jun 2021 10:09:53 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.50318.1624295388440408484
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957107"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:47 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E98D6400C4D4;
	Tue, 22 Jun 2021 02:09:46 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 15/16] dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
Date: Mon, 21 Jun 2021 18:09:24 +0100
Message-Id: <20210621170925.11328-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: twCgKlKL3Mwa48XG47zKXpmMx4520388AA=
Content-Type: multipart/mixed; boundary="SRTdFPyMvznXpfrMwKvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295393;
 bh=F8LBPGnyv10WvJqnAJ5SO2hbgL+F730zI3EDmhGk5cg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SMo27AAxhK2sJ7AD8cDy9Vz1+9cj/xuhnFV1qkrcWoMGDRElU/KcSkqFWa/xBH66eDR
 PUIX+7wJNeaeNRBzA+QnF7/Tp5jFB9GmEMO/5dJ9eL90WbVV+/0okIwQmdIIiujUExU40
 R1+IHuMDAEkLo5UFxmhs+GuUpPlOuSfmO4o=

--SRTdFPyMvznXpfrMwKvY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit db08e6c0e2513d1341369ec6a4f1774ee20b290b upstream.

Document RZ/G2H (R8A774E1) SoC in the Renesas TMU bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201110162014.3290109-2-geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 29159f4e65ab..a36cd61e74fb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,tmu-r8a774a1" for the r8a774A1 TMU
     - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
     - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
+    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu-r8a77970" for the r8a77970 TMU
-- 
2.17.1


--SRTdFPyMvznXpfrMwKvY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6560): https://lists.cip-project.org/g/cip-dev/message=
/6560
Mute This Topic: https://lists.cip-project.org/mt/83693891/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SRTdFPyMvznXpfrMwKvY--
