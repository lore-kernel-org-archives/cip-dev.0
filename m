Return-Path: <SRS0=UXDl=B7=lists.cip-project.org=bounce+64572+5203+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA4CC433E8
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF542078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RfLc9CWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF542078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5203+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bs0WYY4521723xtxxRMRSUhl; Fri, 21 Aug 2020 03:58:45 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130439.1598003056666915018
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:20 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170387"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:19 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 76ADF4232071;
	Fri, 21 Aug 2020 18:44:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 34/36] dt-bindings: arm: renesas: Add HopeRun RZ/G2H boards
Date: Fri, 21 Aug 2020 10:43:10 +0100
Message-Id: <20200821094312.3249-35-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mLsRrV9GvjojyUGgOX3jJmxnx4520388AA=
Content-Type: multipart/mixed; boundary="u0vG8CjCmcbytMFEyNE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007525;
 bh=UacJiEubV1sSnQg3EuHCHkWJjERe2Rito3pMUYj8u8g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RfLc9CWnpl5HlQ69TFDSfvieXg4qvv1DU9BfSrbo8bXg6OcjMQ/RcZG+VVhrwfABVwk
 oiJeeg/AnLT6c47l7Wy6n7DjRO38YmQYUaUg9xNwopsdcXN+JhKGRraX0iSoT6YNR/Hnw
 KA7DcIJhCs2O8mz9DAh1Pd95aHdhGmzXT1A=

--u0vG8CjCmcbytMFEyNE8

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 6dfb9f369c00fe90f982eaf28032a889a89ee4b8 upstream.

This patch adds board HiHope RZ/G2H (the main board, powered by the
R8A774E1) and board HiHope RZ/G2 EX (the expansion board that sits on top
of the HiHope RZ/G2H). Both boards are made by Jiangsu HopeRun Software
Co., Ltd. (a.k.a. HopeRun).

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 58a9c5194c36..5da33a737023 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -94,9 +94,12 @@ Boards:
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
   - HopeRun expansion board for HiHope RZ/G2 platforms
-    compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1",
+    compatible = "hoperun,hihope-rzg2h", "renesas,r8a774e1",
+                 "hoperun,hihope-rzg2m", "renesas,r8a774a1",
                  "hoperun,hihope-rzg2n", "renesas,r8a774b1",
                  "hoperun,hihope-rzg2-ex"
+  - HopeRun HiHope RZ/G2H platform
+    compatible = "hoperun,hihope-rzg2h", "renesas,r8a774e1"
   - HopeRun HiHope RZ/G2M platform
     compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1"
   - HopeRun HiHope RZ/G2N platform
-- 
2.17.1


--u0vG8CjCmcbytMFEyNE8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5203): https://lists.cip-project.org/g/cip-dev/message=
/5203
Mute This Topic: https://lists.cip-project.org/mt/76326743/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--u0vG8CjCmcbytMFEyNE8--
