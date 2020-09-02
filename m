Return-Path: <SRS0=9LTa=CL=lists.cip-project.org=bounce+64572+5364+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E34C2BBD0
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A2F20829
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gfh6LdC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A2F20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5364+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xWWyYY4521723xHHhJWiIH5p; Wed, 02 Sep 2020 05:46:08 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.2331.1599033039663673523
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 00:50:40 -0700
X-IronPort-AV: E=Sophos;i="5.76,381,1592838000"; 
   d="scan'208";a="55947284"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2020 16:50:40 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BE2914007F44;
	Wed,  2 Sep 2020 16:50:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/5] dt-bindings: mmc: renesas,sdhi: Document r8a7742 support
Date: Wed,  2 Sep 2020 08:50:31 +0100
Message-Id: <20200902075035.4445-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: J3ksmsrJXbqNeF5EliwxDB5Ox4520388AA=
Content-Type: multipart/mixed; boundary="bn1h2XkDRS9sCiPRFxr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599050768;
 bh=w9uvKfRQmWS8f4O6povJHxMVJc6Y2VMmUq415cHIcN0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gfh6LdC7BR/+zhZGH5Rxz5YAi8N95FTOeuijkUeLnGYF9Qxosfi6F1HhYEBn0v8+ebk
 9IzE0oq9/b/JugW5vEUyPsGmD8NZ0zunsyvW3/sKx0slILtMKqhuM//X4IFGLkkHLSj9W
 HcmMP4aEOu9vCoY1EIJFB9VaObwhlUWS0Rg=

--bn1h2XkDRS9sCiPRFxr0

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1f8153ee031d0d4756daa985788bf0a960e588a6 upstream.

Document SDHI controller for RZ/G1H (R8A7742) SoC, which is compatible
with R-Car Gen2 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1589555337-5498-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: Ported the changes from renamed bindings file renesas,sdhi.txt to here]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 94bb00b0f4ef..874ffc99d798 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -15,6 +15,7 @@ Required properties:
 		"renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
 		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
+		"renesas,sdhi-r8a7742" - SDHI IP on R8A7742 SoC
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7744" - SDHI IP on R8A7744 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
-- 
2.17.1


--bn1h2XkDRS9sCiPRFxr0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5364): https://lists.cip-project.org/g/cip-dev/message=
/5364
Mute This Topic: https://lists.cip-project.org/mt/76581045/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bn1h2XkDRS9sCiPRFxr0--
