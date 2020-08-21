Return-Path: <SRS0=kOM7=B7=lists.cip-project.org=bounce+64572+5195+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A66C43445
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A5920656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XaKu7y4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A5920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5195+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NvgoYY4521723xnDRtVGYgfI; Fri, 21 Aug 2020 03:58:36 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:42 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954575"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:41 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 61AFC423206F;
	Fri, 21 Aug 2020 18:43:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 14/36] dt-bindings: clock: renesas,cpg-mssr: Document r8a774e1
Date: Fri, 21 Aug 2020 10:42:50 +0100
Message-Id: <20200821094312.3249-15-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ItFUD4SyxMJ9cAynbd5cq4FAx4520388AA=
Content-Type: multipart/mixed; boundary="EZpDELNbxLevwKxfnu2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007516;
 bh=UgZPXJqMKQisNHUL9ARfU5Ddb6H5AHzWgt+e6Uf5JII=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XaKu7y4hzPxQ3If5PFnan5XisQpN99SNj1OIyXcCLymPjA2S1jGNvoN8KWUc5LGsR4v
 s7oHi3qBOgz88+kybSaY9cUrgbv2dfwRGWAb6HKXpwFMVpOFY5Y4nkgRapESjzdhuCkQT
 mlrahOC80qGFlnrzp7SMMpOiyHyFLrcX62A=

--EZpDELNbxLevwKxfnu2e

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 668a8187e8b7875d515eacab88cef7f97fb4a1b3 upstream.

Add binding documentation for the RZ/G2H (R8A774E1) Clock Pulse Generator
driver.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index 113d45be1e37..6b565779ded3 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -19,6 +19,7 @@ Required Properties:
       - "renesas,r8a774a1-cpg-mssr" for the r8a774a1 SoC (RZ/G2M)
       - "renesas,r8a774b1-cpg-mssr" for the r8a774a1 SoC (RZ/G2N)
       - "renesas,r8a774c0-cpg-mssr" for the r8a774c0 SoC (RZ/G2E)
+      - "renesas,r8a774e1-cpg-mssr" for the r8a774e1 SoC (RZ/G2H)
       - "renesas,r8a7790-cpg-mssr" for the r8a7790 SoC (R-Car H2)
       - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC (R-Car M2-W)
       - "renesas,r8a7792-cpg-mssr" for the r8a7792 SoC (R-Car V2H)
-- 
2.17.1


--EZpDELNbxLevwKxfnu2e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5195): https://lists.cip-project.org/g/cip-dev/message=
/5195
Mute This Topic: https://lists.cip-project.org/mt/76326734/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--EZpDELNbxLevwKxfnu2e--
