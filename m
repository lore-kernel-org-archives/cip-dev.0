Return-Path: <SRS0=ZCH/=B7=lists.cip-project.org=bounce+64572+5188+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16503C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7C1207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="If0bvfXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7C1207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5188+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cBXAYY4521723xfwIiTW97SE; Fri, 21 Aug 2020 03:58:35 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130424.1598002997752220163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:26 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954536"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:25 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 17D784232061;
	Fri, 21 Aug 2020 18:43:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 05/36] dt-bindings: arm: renesas: Document RZ/G2H SoC DT bindings
Date: Fri, 21 Aug 2020 10:42:41 +0100
Message-Id: <20200821094312.3249-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CAOTcMe5SOwWAegQGmCAZTayx4520388AA=
Content-Type: multipart/mixed; boundary="wYHpFXrfyxEbD1qtrkwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007515;
 bh=ebQAcYmDFq222iypky5ovRzDYUaE2vIWLXPh0c8XDDI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=If0bvfXR4yv1Jgd+Z39DHOC+xHl/kMJ09W06ouEMc7B8+j9Jc2ybZZqFel0gg2/OxvF
 XRU8t17pWM9fTj/RpvgfswoU5PD+iyBaqFniEDgUPSJXN7wtwRJUdZoRNKDg5TNuXBHl/
 MhU5C7qVJuP7VJLhglTV8xUGqpoE7AK/64U=

--wYHpFXrfyxEbD1qtrkwW

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 1f52719bb71f6ead0bcf19c212a30f05c2237058 upstream.

Add device tree bindings documentation for the Renesas RZ/G2H (r8a774e1)
SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138368-16449-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched to shmobile.txt]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 7b83c02998d4..58a9c5194c36 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -29,6 +29,8 @@ SoCs:
     compatible = "renesas,r8a774b1"
   - RZ/G2E (R8A774C0)
     compatible = "renesas,r8a774c0"
+  - RZ/G2H (R8A774E1)
+    compatible = "renesas,r8a774e1"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
-- 
2.17.1


--wYHpFXrfyxEbD1qtrkwW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5188): https://lists.cip-project.org/g/cip-dev/message=
/5188
Mute This Topic: https://lists.cip-project.org/mt/76326727/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wYHpFXrfyxEbD1qtrkwW--
