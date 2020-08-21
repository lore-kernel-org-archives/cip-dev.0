Return-Path: <SRS0=C+Qp=B7=lists.cip-project.org=bounce+64572+5193+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3021C433FC
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B581820656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PsTI/1JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B581820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5193+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c75JYY4521723xNdLOoXvEvC; Fri, 21 Aug 2020 03:58:36 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130424.1598002997752220163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:20 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954525"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:20 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9EB514231AD9;
	Fri, 21 Aug 2020 18:43:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 02/36] dt-bindings: power: renesas,rcar-sysc: Document r8a774e1 SYSC binding
Date: Fri, 21 Aug 2020 10:42:38 +0100
Message-Id: <20200821094312.3249-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qI1QvbnVkC09INtydpltfJ5sx4520388AA=
Content-Type: multipart/mixed; boundary="pCxRKZzzzcDem2NNyTeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007516;
 bh=118noBSF6oAfP3alq2sgwqL+lPKXbz7W2kD8jOk43G8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PsTI/1JPpOHcJ/b/biynHvyRfrz8TgiA9DY8NZcb62QLCNLQrXS/VqjTxvXoCWmEQW5
 NRjjIpL+0nI22ecQnseCERtvgdH1pugKi+RWslIZrFbt/cOBI4PptrePRUO0A8GlqK+L2
 OEK4lS2tHArdpz4yMIdppZLh85lJkEe6bt4=

--pCxRKZzzzcDem2NNyTeB

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit f639fb66d17e2e25049503b7c2c568457a9b5c6f upstream.

Document bindings for the RZ/G2H (aka R8A774E1) SYSC block.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index 20008c8d33d3..9194e696a9b7 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -13,6 +13,7 @@ Required properties:
       - "renesas,r8a774a1-sysc" (RZ/G2M)
       - "renesas,r8a774b1-sysc" (RZ/G2N)
       - "renesas,r8a774c0-sysc" (RZ/G2E)
+      - "renesas,r8a774e1-sysc" (RZ/G2H)
       - "renesas,r8a7779-sysc" (R-Car H1)
       - "renesas,r8a7790-sysc" (R-Car H2)
       - "renesas,r8a7791-sysc" (R-Car M2-W)
-- 
2.17.1


--pCxRKZzzzcDem2NNyTeB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5193): https://lists.cip-project.org/g/cip-dev/message=
/5193
Mute This Topic: https://lists.cip-project.org/mt/76326732/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pCxRKZzzzcDem2NNyTeB--
