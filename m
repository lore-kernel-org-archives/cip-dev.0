Return-Path: <SRS0=bvAp=6E=lists.cip-project.org=bounce+64572+4588+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE9C3A5A0
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B110820857
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nPgde7Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4588+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bXuKYY4521723xJWPjrGddPg; Mon, 20 Apr 2020 12:50:55 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1916.1587412254363223901
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 12:50:54 -0700
X-IronPort-AV: E=Sophos;i="5.72,407,1580742000"; 
   d="scan'208";a="45013031"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2020 04:50:53 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B974840CC760;
	Tue, 21 Apr 2020 04:50:52 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Subject: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr binding
Date: Mon, 20 Apr 2020 20:50:49 +0100
Message-Id: <1587412250-16752-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4trUO2VB6R9aeGT2rN3gcdqUx4520388AA=
Content-Type: multipart/mixed; boundary="0KYFF3lzH277AD6IjT4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587412255;
 bh=R5oYCbgVSh6Gc6OF6cc5g2mTCjaEwo0zcpXw2WH59lY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nPgde7PkWqsby96RhuXOL93UzAwJ9aglafbKiVPqAMpAYFXO8BXSQk86UvnvKl+K0GV
 6SM+JlYsCkg5dCMraoetvoBt/OqCogkLidka2nZWZZsGzLpSsdOzp4RjFzB0wvfhhMTvX
 yMNyDFYfdPoTumF3y5ahxYpIwYDWVBfRiXI=

--0KYFF3lzH277AD6IjT4V

Add binding for the idk-1110wr LVDS panel from Advantech.

Some panel-specific documentation can be found here:
https://buy.advantech.eu/Displays/Embedded-LCD-Kits-LCD-Kit-Modules/model-IDK-1110WR-55WSA1E.htm

This patch is based on commit d26087162857b12bd9d0424f2dea2cd9654e50a0
upstream ("dt-bindings: display: Add idk-1110wr binding") which adds yaml
bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../display/panel/advantech,idk-1110wr.txt         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.txt

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.txt b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.txt
new file mode 100644
index 0000000..c5388b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.txt
@@ -0,0 +1,45 @@
+Advantech IDK-1110WR 10.1" WSVGA LVDS Display Panel
+===================================================
+
+The Advantech IDK-1110WR is a 10.1" industrial grade LCD display with
+4-wire resistive touch.
+
+These DT bindings follow the LVDS panel bindings defined in panel-lvds.txt
+with the following device-specific properties.
+
+Required properties:
+
+- compatible: Shall contain "advantech,idk-1110wr" and "panel-lvds", in that
+  order.
+
+
+Example
+-------
+
+panel {
+	compatible = "advantech,idk-1110wr", "panel-lvds";
+
+	width-mm = <223>;
+	height-mm = <125>;
+
+	data-mapping = "jeida-24";
+
+	panel-timing {
+		/* 1024x600 @60Hz */
+		clock-frequency = <51200000>;
+		hactive = <1024>;
+		vactive = <600>;
+		hsync-len = <240>;
+		hfront-porch = <40>;
+		hback-porch = <40>;
+		vsync-len = <10>;
+		vfront-porch = <15>;
+		vback-porch = <10>;
+	};
+
+	port {
+		panel_in: endpoint {
+			remote-endpoint = <&lvds_encoder>;
+		};
+	};
+};
-- 
2.7.4


--0KYFF3lzH277AD6IjT4V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4588): https://lists.cip-project.org/g/cip-dev/message=
/4588
Mute This Topic: https://lists.cip-project.org/mt/73158052/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0KYFF3lzH277AD6IjT4V--
