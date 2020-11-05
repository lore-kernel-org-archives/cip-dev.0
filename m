Return-Path: <SRS0=N6Ql=EL=lists.cip-project.org=bounce+64572+5744+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD09C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304562083B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Q5cE7BZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304562083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5744+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KWMgYY4521723xYMzHjtbmnC; Thu, 05 Nov 2020 01:50:46 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5373.1604569843133406010
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:45 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61754454"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:44 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 013FD41572DE;
	Thu,  5 Nov 2020 18:50:43 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: dma: renesas,usb-dmac: Add binding for r8a774e1
Date: Thu,  5 Nov 2020 09:50:36 +0000
Message-Id: <20201105095039.4751-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9wAMOA5Qw6xS7Ey1VtUXQmavx4520388AA=
Content-Type: multipart/mixed; boundary="Dd46wJ11mO3XLADb763x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569846;
 bh=uYHgIuhfDV6SseieYO1r0hMEDQnYlL1jso1IIbMr8xA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q5cE7BZI5Rv1hNgG+h78yrndbWWaWNGT5uZBHKB99oprYgNiK93XWx4MyQ0cOhj9P4/
 /ABwTqcVd1fT9JjVoqbeR+fq+LFYbLBQDEsJ2LSgJlL2Bj5+UMAEQFHyv9njNtMPy+K7k
 c/GSLpZRIsYRUUr3HjPvZrvJv9Akmx9KpgU=

--Dd46wJ11mO3XLADb763x

commit 4b545ebfc371552cda7ce97a4beb485da9ef89cd upstream.

Add binding for R8A774E1 SoC (RZ/G2H).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
index f36552344582..7f96e2a8e463 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -8,6 +8,7 @@ Required Properties:
 	  - "renesas,r8a774a1-usb-dmac" (RZ/G2M)
 	  - "renesas,r8a774b1-usb-dmac" (RZ/G2N)
 	  - "renesas,r8a774c0-usb-dmac" (RZ/G2E)
+	  - "renesas,r8a774e1-usb-dmac" (RZ/G2H)
 	  - "renesas,r8a7790-usb-dmac" (R-Car H2)
 	  - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
 	  - "renesas,r8a7793-usb-dmac" (R-Car M2-N)
-- 
2.17.1


--Dd46wJ11mO3XLADb763x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5744): https://lists.cip-project.org/g/cip-dev/message=
/5744
Mute This Topic: https://lists.cip-project.org/mt/78047673/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dd46wJ11mO3XLADb763x--
