Return-Path: <SRS0=wg9Y=B7=lists.cip-project.org=bounce+64572+5216+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B433C433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B43B204FD
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rr3WLQY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B43B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5216+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5sGXYY4521723xwF9qaAc6DN; Fri, 21 Aug 2020 07:17:58 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.135295.1598019427382928687
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:17:12 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55184982"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 23:17:12 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E1F4240065C6;
	Fri, 21 Aug 2020 23:17:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 4/7] dt-bindings: dma: renesas,rcar-dmac: Document R8A774E1 bindings
Date: Fri, 21 Aug 2020 15:16:59 +0100
Message-Id: <20200821141702.3977-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TdlAXKh6907UEzLRU173GprVx4520388AA=
Content-Type: multipart/mixed; boundary="LyhnssGZ5n8tBGTzmo26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598019478;
 bh=2Wo6rzsh/tjqsYLZ1UGrrcvEiJijBw6S3rt9rpwATuw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rr3WLQY+okuYpJtsEI6C6I1S71A0ESW+9vVWJLP/+91KtQflMYk5Ahw3W1yYCbWPZVe
 Bi7REmtQLyxxc9+11zr24wtBxDFu6a4hlMJFaEjkAAMySRj+9/+Go+BxYneHyqSxJzOWp
 F1Zm1wEyQjYr7esqowF4+Dopf1t8NZkO+Fg=

--LyhnssGZ5n8tBGTzmo26

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 09b4db279758dd3d5bb235605e985b99e7bc1a93 upstream.

Renesas RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible
DMA controllers, therefore document RZ/G2H specific bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index b6927eb3e6f2..59d2ad3d39dd 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -22,6 +22,7 @@ Required Properties:
 		- "renesas,dmac-r8a774a1" (RZ/G2M)
 		- "renesas,dmac-r8a774b1" (RZ/G2N)
 		- "renesas,dmac-r8a774c0" (RZ/G2E)
+		- "renesas,dmac-r8a774e1" (RZ/G2H)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
 		- "renesas,dmac-r8a7792" (R-Car V2H)
-- 
2.17.1


--LyhnssGZ5n8tBGTzmo26
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5216): https://lists.cip-project.org/g/cip-dev/message=
/5216
Mute This Topic: https://lists.cip-project.org/mt/76329799/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LyhnssGZ5n8tBGTzmo26--
