Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1BAC3F6B0
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.15195.1660653257535484541
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,241,1654527600";
   d="scan'208";a="131578397"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:34 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E91C402D0A4;
	Tue, 16 Aug 2022 21:34:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 13/31] dt-bindings: soc: renesas: Move
 renesas,rzg2l-sysc from arm to soc
Date: Tue, 16 Aug 2022 13:33:48 +0100
Message-Id: <20220816123406.27553-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9232

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 033a26dcbe10476c5203f590dce0537fac802d03 upstream.

The Renesas RZ/{G2L,V2L} System Controller (SYSC) DT binding is not
really a power-related DT binding, hence it does not belong under
Documentation/devicetree/bindings/power/.
Move it to Documentation/devicetree/bindings/soc/renesas/.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/a47015888f99476a5206a556dce93503494d9a73.1651495078.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/{power => soc/renesas}/renesas,rzg2l-sysc.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{power => soc/renesas}/renesas,rzg2l-sysc.yaml (96%)

diff --git a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
rename to Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index bb433e75a0ee..f6182fd17200 100644
--- a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/renesas,rzg2l-sysc.yaml#"
+$id: "http://devicetree.org/schemas/soc/renesas/renesas,rzg2l-sysc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Renesas RZ/{G2L,V2L} System Controller (SYSC)
-- 
2.17.1


