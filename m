Return-Path: <SRS0=5rDK=GH=lists.cip-project.org=bounce+64572+5986+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826BC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:04:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10DE20780
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10DE20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5986+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sYYaYY4521723xZqGNzyFqDJ; Mon, 04 Jan 2021 02:04:56 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.11573.1609754695267426631
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:04:55 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67766990"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jan 2021 19:04:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C556F40083E8;
	Mon,  4 Jan 2021 19:04:53 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
Date: Mon,  4 Jan 2021 10:04:52 +0000
Message-Id: <20210104100452.7424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gC1WgR9aYMukNAEWw57ZoCLzx4520388AA=
Content-Type: multipart/mixed; boundary="Lmgow7QNRK1URA5eXlqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609754696;
 bh=m+iHrA4/D0GSa4Wdes8bJEI8b0Fk/7wwmzAczeyQqWY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eea5rpSSfJPZTfegiNHv8FLgYGhxCdJP7VBn+KOHy1n9/gQaWM5rYlWd1XU+27B+nPN
 v26pdM831aDGUd0Q9Icusp93cfli63OpYs/V3c1ZKZ+CxhvOvvQyWYM3fEMdJWK+brZcN
 pcQ397l42osDdxdK56UD7cxKM0LhhzXICW0=

--Lmgow7QNRK1URA5eXlqW
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
Hi All,

This patch has been cherry picked from v5.11-rc2, note the DT nodes have
been already added into CIP for r8a774e1 SoC, hence this single patch.

Cheers,
Prabhakar
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 02be83e0084e..7109f3c65e3d 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -12,6 +12,7 @@ Required Properties:
     - "renesas,tmu-r8a7740" for the r8a7740 TMU
     - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
     - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
+    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu" for any TMU.
-- 
2.17.1


--Lmgow7QNRK1URA5eXlqW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5986): https://lists.cip-project.org/g/cip-dev/message=
/5986
Mute This Topic: https://lists.cip-project.org/mt/79421040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Lmgow7QNRK1URA5eXlqW--
