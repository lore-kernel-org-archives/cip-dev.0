Return-Path: <SRS0=f0wo=B7=lists.cip-project.org=bounce+64572+5198+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558FC433E8
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEED20656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w2ucUVj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEED20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5198+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6dcnYY4521723xxaYbut0mmu; Fri, 21 Aug 2020 03:58:40 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131167.1598003052343639956
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:14 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954634"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:13 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2BEBA4232071;
	Fri, 21 Aug 2020 18:44:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 31/36] dt-bindings: pinctrl: sh-pfc: Document r8a774e1 PFC support
Date: Fri, 21 Aug 2020 10:43:07 +0100
Message-Id: <20200821094312.3249-32-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nW0IztPKk53XvvrOsWcHCqNxx4520388AA=
Content-Type: multipart/mixed; boundary="2cL2YMPDixnAfi4BD3Hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007520;
 bh=z3g7iUWI8jaVGeUYdbyRD3b6a4UCaa4OLwfPWb70RL8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=w2ucUVj6zJFvUsJH2b6ultn1EQZ56K0OZdlwDY4sFVknjkkuKkUKWOVLEp5xVU19+u+
 AYsYYx/tnZy42JRbFZk5WlOcbjPeVMjnQhiufIPzaI6lKDCh/pU9EJlzZn81hMP82Xe1J
 +ZB3NEddKlm/iWyKV22QmI/zvMN28wPcgxI=

--2cL2YMPDixnAfi4BD3Hw

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit d33cfc2e591a90f540cd696240ff953b8aaba17d upstream.

Document PFC support for the RZ/G2H (R8A774E1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index 62ef37aa1e18..a06e0e88a3d8 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -19,6 +19,7 @@ Required Properties:
     - "renesas,pfc-r8a774a1": for R8A774A1 (RZ/G2M) compatible pin-controller.
     - "renesas,pfc-r8a774b1": for R8A774B1 (RZ/G2N) compatible pin-controller.
     - "renesas,pfc-r8a774c0": for R8A774C0 (RZ/G2E) compatible pin-controller.
+    - "renesas,pfc-r8a774e1": for R8A774E1 (RZ/G2H) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Car M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
-- 
2.17.1


--2cL2YMPDixnAfi4BD3Hw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5198): https://lists.cip-project.org/g/cip-dev/message=
/5198
Mute This Topic: https://lists.cip-project.org/mt/76326738/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--2cL2YMPDixnAfi4BD3Hw--
