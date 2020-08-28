Return-Path: <SRS0=Jv/6=CG=lists.cip-project.org=bounce+64572+5317+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751A8C2D0A6
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C89B20872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WMsnT9oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C89B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5317+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NhijYY4521723xWeCHpXCtaO; Fri, 28 Aug 2020 09:07:54 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.45863.1598629376077307550
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:56 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804759"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:55 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E12C3400C4F0;
	Sat, 29 Aug 2020 00:42:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 27/30] dt-bindings: arm: renesas: Document iW-RainboW-G21M-Qseven-RZG1H SoM
Date: Fri, 28 Aug 2020 16:41:52 +0100
Message-Id: <20200828154155.5827-28-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fk6gnxkSZ4HRHFJqteAiQLETx4520388AA=
Content-Type: multipart/mixed; boundary="gzWrgp5fs0pEw4brAEzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630874;
 bh=XpEsTMerqme8Tb0+T8+pEPMTk127VakEQ9q2sQBQGMM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WMsnT9ohNHXlBdCgJ1pKc+u+JynGO25F5scLyzM6QbE9fNkyuIh7/QKKVg2kS0ns/3R
 U0QH0XLPCipJZJZooSs7nQo6DJQilp+/kB2kc4sdL2SZVBCz8EgmIojchkJ4nf+RcEugs
 3iaq22WZDlTGANc1WwL/ZZOvGbFmHRpFbE0=

--gzWrgp5fs0pEw4brAEzN

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 844beed47182903212d8230ac6d729be1287733e upstream.

Document the iW-RainboW-G21M-Qseven-RZG1H device tree bindings,
listing it as a supported system on module.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1588542414-14826-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 1f894d9a2d0f..0afd43e6764d 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -61,6 +61,8 @@ Boards:
     compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
     compatible = "iwave,g22m", "renesas,r8a7745"
+  - iWave Systems RZ/G1H Qseven System On Module (iW-RainboW-G21M-Qseven)
+    compatible = "iwave,g21m", "renesas,r8a7742"
   - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
     compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
   - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
-- 
2.17.1


--gzWrgp5fs0pEw4brAEzN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5317): https://lists.cip-project.org/g/cip-dev/message=
/5317
Mute This Topic: https://lists.cip-project.org/mt/76477106/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gzWrgp5fs0pEw4brAEzN--
