Return-Path: <SRS0=sk4v=CK=lists.cip-project.org=bounce+64572+5355+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB86FC433E7
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F63206FA
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E2O9aIEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F63206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5355+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lMBvYY4521723xCVBPg5H5P8; Tue, 01 Sep 2020 04:45:10 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11107.1598960480272809138
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:29 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="56086794"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:28 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4790F400618C;
	Tue,  1 Sep 2020 20:41:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 06/10] dt-bindings: net: renesas, ravb: Add support for r8a7742 SoC
Date: Tue,  1 Sep 2020 12:41:10 +0100
Message-Id: <20200901114114.3465-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lXoZKYlVn4Sqs3K10uYyRt4ux4520388AA=
Content-Type: multipart/mixed; boundary="96AwNXoaZHAJOAz9OxJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960710;
 bh=6RdizWcI+Yx5ha7+0t+F5i7C41IaaEKu0Jjr8o13puQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E2O9aIEK/meo7YTuiBAnIQJPIYXSTeXIUWH3QGM2DWOQcwVu6Dq3T9aoO/lQnCu0Bl2
 X820g3Y7lqApPqESObXhBMax194ToxSGYCu0WGC3yxI4n2DlP8L62RhD/8P8LezGK8oTp
 GSrsm4ntTxmQSoYCBGvj4I9DU5J3uAtL/JM=

--96AwNXoaZHAJOAz9OxJW

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9c95312aad21bf5c6f23a5158d1cd7f42d4560e2 upstream.

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 0a8e8df01f4b..132d6c72c4d3 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -5,6 +5,7 @@ interface contains.
 
 Required properties:
 - compatible: Must contain one or more of the following:
+      - "renesas,etheravb-r8a7742" for the R8A7742 SoC.
       - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
       - "renesas,etheravb-r8a7744" for the R8A7744 SoC.
       - "renesas,etheravb-r8a7745" for the R8A7745 SoC.
-- 
2.17.1


--96AwNXoaZHAJOAz9OxJW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5355): https://lists.cip-project.org/g/cip-dev/message=
/5355
Mute This Topic: https://lists.cip-project.org/mt/76554011/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--96AwNXoaZHAJOAz9OxJW--
