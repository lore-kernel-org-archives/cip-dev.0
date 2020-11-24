Return-Path: <SRS0=VS1o=E6=lists.cip-project.org=bounce+64572+5845+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ADFC63798
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E8720857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mlDSyR3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E8720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5845+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cpGHYY4521723xqUPstGls9c; Tue, 24 Nov 2020 09:11:37 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15.1606237784446827976
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:44 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63522777"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:43 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7FA4F40ABFEE;
	Wed, 25 Nov 2020 02:09:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/9] dt-bindings: usb: usb-xhci: Document r8a7742 support
Date: Tue, 24 Nov 2020 17:09:28 +0000
Message-Id: <20201124170932.13588-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k03DJzOHahObx65RmZoR08wEx4520388AA=
Content-Type: multipart/mixed; boundary="48G7Jveoz8AC4RfOl9E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237897;
 bh=h6Q+2ch5iwwrf9tA0LL9KxJbvGvKzySrC8XI+wzuGXw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mlDSyR3KW1F5n6Nf44BBBF/td/8qH41j+Vk3t2MJ3h+j/pdS2L6Juot9I3X8v0za7fv
 b1b4rJ6nD1s78AGl9ONuQzTXKZZbqLyQ/y5ha6t27E9ON8DlWlamqUjewe4OV19eMHwLl
 XqyZsnoyC0hx8Q58Bs7u0AJ7KiEIdCbbKyU=

--48G7Jveoz8AC4RfOl9E5

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 935796968ff8b69cb0c9f18c427899ebafd83509 upstream.

Document r8a7742 xhci support. The driver will use the fallback
compatible string "renesas,rcar-gen2-xhci", therefore no driver
change is needed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index bf5192b7348e..2cd959287fe9 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,8 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7743",
-    "renesas,xhci-r8a7744"
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7742"
+    "renesas,xhci-r8a7743", "renesas,xhci-r8a7744"
     (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
-- 
2.17.1


--48G7Jveoz8AC4RfOl9E5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5845): https://lists.cip-project.org/g/cip-dev/message=
/5845
Mute This Topic: https://lists.cip-project.org/mt/78481727/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--48G7Jveoz8AC4RfOl9E5--
