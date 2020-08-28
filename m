Return-Path: <SRS0=nqvw=CG=lists.cip-project.org=bounce+64572+5308+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C92C47424
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1722208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V3tkXEan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1722208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5308+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GUqmYY4521723xXyLrhkrVvJ; Fri, 28 Aug 2020 09:07:47 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.45771.1598629350683270340
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:36 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804738"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B816400C4F0;
	Sat, 29 Aug 2020 00:42:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 18/30] dt-bindings: mmc: renesas,mmcif: Document r8a7742 DT bindings
Date: Fri, 28 Aug 2020 16:41:43 +0100
Message-Id: <20200828154155.5827-19-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FUcSHI2RDzoyErxxPYSwNFMYx4520388AA=
Content-Type: multipart/mixed; boundary="mWOmXcFLD36jQcrT0w1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630867;
 bh=nX/ywoFWslhCkCxG9ulfVAZSf5N9dNvIYKY95by1DoQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=V3tkXEanfg+zEOR9ySdGu7RGJtnChp1j8gabBNSkbZPhUJvWSWbBdCjMk3YhMikK+Yb
 EV+8KWPwtxmkkQ2Rb+8N6NiU/VKYEQwg7ZVXR8Ze69+ravMZOr30/GpJiTvCMZTJh3ZzI
 41RldWz79eMWspgx0N/K6u2KTkVvdwdiJpk=

--mWOmXcFLD36jQcrT0w1i

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 194f9b21ad64740eb9675703037fe42113cea65c upstream.

Add support for r8a7742 SoC. Renesas RZ/G1H (R8A7742) MMCIF is identical
to the R-Car Gen2 family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1588794695-27852-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: removed interrupt related changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index ccbcd765a6ec..6aeb67f5131d 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
   fallback. Examples with <soctype> are:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
+	- "renesas,mmcif-r8a7742" for the MMCIF found in r8a7742 SoCs
 	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
 	- "renesas,mmcif-r8a7744" for the MMCIF found in r8a7744 SoCs
 	- "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
-- 
2.17.1


--mWOmXcFLD36jQcrT0w1i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5308): https://lists.cip-project.org/g/cip-dev/message=
/5308
Mute This Topic: https://lists.cip-project.org/mt/76477091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mWOmXcFLD36jQcrT0w1i--
