Return-Path: <SRS0=u4B3=E6=lists.cip-project.org=bounce+64572+5843+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949F5C6379D
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D6420715
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WB9+GDar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D6420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5843+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q5XOYY4521723x9fmISfvJgS; Tue, 24 Nov 2020 09:11:34 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.20.1606237777285940741
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:40 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63738822"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:40 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C5F4A40AC3B2;
	Wed, 25 Nov 2020 02:09:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/9] dt-bindings: usb: renesas,usbhs: Add support for r8a7742
Date: Tue, 24 Nov 2020 17:09:26 +0000
Message-Id: <20201124170932.13588-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qUL9Iy3vL0HBq3iNsVwaclwyx4520388AA=
Content-Type: multipart/mixed; boundary="q0AeLHGAuiaDSIpmfIiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237894;
 bh=6gu99DlsZeBFncJrrWWn4KTTToAJ3f8iQtITQMkLkfI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WB9+GDarwnN6h2mlv/oY0raOYqy5DLrpQwHqhYXTdcTdoMGvM/t6QWilAMXATPK4Q/P
 T4GjT+BaV9bVP/pLNEiaW+5yqZGRGo7bIIRSNP6UaQb/ygwGd1lh7sPGb5IFywEVUuDxM
 d2epc2ckGTRr81oC2ks4jUPGCachYxqj+Pg=

--q0AeLHGAuiaDSIpmfIiZ

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c092e1356b378e8567f9d6404ac27b57a4f47ae6 upstream.

Document support for RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 5a26deea5b97..d0516953b9d2 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -3,6 +3,7 @@ Renesas Electronics USBHS driver
 Required properties:
   - compatible: Must contain one or more of the following:
 
+	- "renesas,usbhs-r8a7742" for r8a7742 (RZ/G1H) compatible device
 	- "renesas,usbhs-r8a7743" for r8a7743 (RZ/G1M) compatible device
 	- "renesas,usbhs-r8a7744" for r8a7744 (RZ/G1N) compatible device
 	- "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
-- 
2.17.1


--q0AeLHGAuiaDSIpmfIiZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5843): https://lists.cip-project.org/g/cip-dev/message=
/5843
Mute This Topic: https://lists.cip-project.org/mt/78481725/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--q0AeLHGAuiaDSIpmfIiZ--
