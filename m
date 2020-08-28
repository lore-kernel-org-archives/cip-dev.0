Return-Path: <SRS0=8lG+=CG=lists.cip-project.org=bounce+64572+5319+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16976C2D0A7
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA069207DF
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Bsf4xFC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA069207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5319+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y1uwYY4521723x3ybfjHRFSj; Fri, 28 Aug 2020 09:07:54 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45506.1598629371850471017
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:43:00 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587907"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:59 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 14044400C4F0;
	Sat, 29 Aug 2020 00:42:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 29/30] dt-bindings: arm: renesas: Document iW-RainboW-G21D-Qseven-RZG1H board
Date: Fri, 28 Aug 2020 16:41:54 +0100
Message-Id: <20200828154155.5827-30-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ub6iOzlS9l4wFNnJUATxE9WHx4520388AA=
Content-Type: multipart/mixed; boundary="n5BOUIHZb7waCXvKbIME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630874;
 bh=INvCbv+flUmJEeXuttiE7P/2nvlCX/W0D1tsctDwQ5s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Bsf4xFC8MjCFfQXGwr0KqV6gjzCnR9xlwpL8LK4FLPCkEduaxau3W+Hd32rtUdBf8ZX
 DXHrbgMRrGXyL8RMTmMk6LGnUO1r6rwaDIj2RzMSQILmfHDXdUCFZnBZ7p5f7mUYFvbpp
 9pPs0N1QTqQgdClifFHFaAec+D9Y6Uk7W+w=

--n5BOUIHZb7waCXvKbIME

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0b5832238d369a71f90a221d17b92761595c8067 upsream.

Document the iW-RainboW-G21D-Qseven-RZG1H device tree bindings,
listing it as a supported board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 0afd43e6764d..066eabf49d57 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -61,6 +61,8 @@ Boards:
     compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
     compatible = "iwave,g22m", "renesas,r8a7745"
+  - iWave Systems RZ/G1H Qseven Development Platform (iW-RainboW-G21D-Qseven)
+    compatible = "iwave,g21d", "iwave,g21m", "renesas,r8a7742"
   - iWave Systems RZ/G1H Qseven System On Module (iW-RainboW-G21M-Qseven)
     compatible = "iwave,g21m", "renesas,r8a7742"
   - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
-- 
2.17.1


--n5BOUIHZb7waCXvKbIME
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5319): https://lists.cip-project.org/g/cip-dev/message=
/5319
Mute This Topic: https://lists.cip-project.org/mt/76477108/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--n5BOUIHZb7waCXvKbIME--
