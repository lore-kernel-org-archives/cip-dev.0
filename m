Return-Path: <SRS0=p6HH=CG=lists.cip-project.org=bounce+64572+5292+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C49C2BB84
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A39C208D5
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LOLFwRn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A39C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5292+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qD51YY4521723xK6jtXbQYO0; Fri, 28 Aug 2020 09:07:46 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45487.1598629321421552654
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:03 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804692"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:02 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2BF7D400C4F0;
	Sat, 29 Aug 2020 00:42:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 02/30] dt-bindings: reset: rcar-rst: Document r8a7742 reset module
Date: Fri, 28 Aug 2020 16:41:27 +0100
Message-Id: <20200828154155.5827-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Pdm26upUAm9GHb15SL1Tb2Imx4520388AA=
Content-Type: multipart/mixed; boundary="y6kF31sex9wj7IelWsDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630866;
 bh=zfYRmv+EE8NRs6piAvif3p4AFENgi73ZwZccVOFamHI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LOLFwRn1VvpO87aEQ6jQzPY1TERd2hYsEV0wH9t+j0CuJf69rYWXe4SE0ABLQ23M+Dx
 X7xIrqUFAWlcNF4VNyYqI3tYKwsJuSVjncqxfEizszEn8buf3C0Xl6DGm3UEF+SATicWK
 +hJdZg7f1vtvgvvn1NQKyBI1grz5ViKxkQE=

--y6kF31sex9wj7IelWsDF

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9e01d74ce0a154411c8991d6e34f4c470958eac3 upstream.

Document bindings for the RZ/G1H (R8A7742) reset module.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1587678050-23468-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index 270f54b5c6cd..e3ea9be09968 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -6,6 +6,7 @@ Required properties:
   - compatible: Should be
 		  - "renesas,<soctype>-rst" for R-Car Gen2 and RZ/G
 		Examples with soctypes are:
+		  - "renesas,r8a7742-rst" (RZ/G1H)
 		  - "renesas,r8a7743-rst" (RZ/G1M)
 		  - "renesas,r8a7744-rst" (RZ/G1N)
 		  - "renesas,r8a7745-rst" (RZ/G1E)
-- 
2.17.1


--y6kF31sex9wj7IelWsDF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5292): https://lists.cip-project.org/g/cip-dev/message=
/5292
Mute This Topic: https://lists.cip-project.org/mt/76477075/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--y6kF31sex9wj7IelWsDF--
