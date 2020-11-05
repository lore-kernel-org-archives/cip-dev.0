Return-Path: <SRS0=lZ3u=EL=lists.cip-project.org=bounce+64572+5742+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD164C00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F63F2083B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="R2PJbQ9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F63F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5742+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w5fDYY4521723xGxESHCRcdn; Thu, 05 Nov 2020 01:50:43 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5373.1604569843133406010
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:43 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61754447"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:42 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 60B7B425F28D;
	Thu,  5 Nov 2020 18:50:41 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] dt-bindings: phy: renesas,usb2-phy: Add r8a774e1 support
Date: Thu,  5 Nov 2020 09:50:34 +0000
Message-Id: <20201105095039.4751-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f8v6O28QomepQPqwDmpSZZLBx4520388AA=
Content-Type: multipart/mixed; boundary="GD2bpFUwhk9Xjq47Dyu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569843;
 bh=rVkOr5r6MRnj/5IXUpNW/J8LDXbF8dOLJazWsXIvY90=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=R2PJbQ9wm/Bl+w0FFl465V/kVNx4G2mvPGlROWxJF7N64ZcFn8G01mj3xpTmmFc4r76
 A2mBNj9L+YRPq1YhJDZ7M7098kMxxiwsDTA21gpxxjQ1idqa9VLx6CUjrEo/WD6An6b7l
 zOlEfrk0+rWoi8atUy1EFtFgQEwEB1UuIKk=

--GD2bpFUwhk9Xjq47Dyu5

upstream f199d6a296dce05ba3de40865251320371e68e3d commit.

Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index e88755b14b75..39ba99302d3c 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -10,6 +10,8 @@ Required properties:
 	      SoC.
 	      "renesas,usb2-phy-r8a774c0" if the device is a part of an R8A774C0
 	      SoC.
+	      "renesas,usb2-phy-r8a774e1" if the device is a part of an R8A774E1
+	      SoC.
 	      "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
-- 
2.17.1


--GD2bpFUwhk9Xjq47Dyu5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5742): https://lists.cip-project.org/g/cip-dev/message=
/5742
Mute This Topic: https://lists.cip-project.org/mt/78047671/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GD2bpFUwhk9Xjq47Dyu5--
