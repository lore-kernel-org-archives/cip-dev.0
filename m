Return-Path: <SRS0=O+/5=BB=lists.cip-project.org=bounce+64572+4972+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC358C433EC
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FB720787
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="X42G4AsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FB720787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4972+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HrJLYY4521723xuZ6XYzl7kq; Wed, 22 Jul 2020 10:47:08 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23009.1595435695048125216
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:34:58 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620945"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:34:57 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 883F340078CA;
	Thu, 23 Jul 2020 01:34:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/17] dt-bindings: display: renesas: lvds: Add renesas,companion property
Date: Wed, 22 Jul 2020 17:34:35 +0100
Message-Id: <20200722163449.3513-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3ppzGSDLYa2qIVjNHnxBPDcyx4520388AA=
Content-Type: multipart/mixed; boundary="9qaTTujyaJL0uB5un85j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440028;
 bh=vxaT0rz8/aDVt3GQD1svpLBAAfLfxOCCa9ylxMUb0Zk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=X42G4AsQxqZJZQ2tPmT49BGNqccQCnPbOsNTyJ6uviX9+VF4eQoKtVETlxn07Cy+uGB
 p6DXk5Z375HJVZdJqpRa4ePGaEhWMS0Xrmb3kVFF943p46lyVlwSUqqTDfcYBQtzrD1GS
 7p1y6KIdJRp8M5Up8RFq5OtbqF/osEiiueY=

--9qaTTujyaJL0uB5un85j

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit f54b4df6b14fb5858bec605aee4356a2e801dddb upstream.

Add a new optional renesas,companion property to point to the companion
LVDS encoder. This is used to support dual-link operation where the main
LVDS encoder splits even-numbered and odd-numbered pixels between the
two LVDS encoders.

The new property doesn't control the mode of operation, it only
describes the relationship between the master and companion LVDS
encoders.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/display/bridge/renesas,lvds.txt   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index d06c25e51e9a..10e2e8e9eb20 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -41,14 +41,24 @@ OF graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
 Each port shall have a single endpoint.
 
+Optional properties:
+
+- renesas,companion : phandle to the companion LVDS encoder. This property is
+  mandatory for the first LVDS encoder on D3 and E3 SoCs, and shall point to
+  the second encoder to be used as a companion in dual-link mode. It shall not
+  be set for any other LVDS encoder.
+
 
 Example:
 
 	lvds0: lvds@feb90000 {
-		compatible = "renesas,r8a7790-lvds";
-		reg = <0 0xfeb90000 0 0x1c>;
-		clocks = <&cpg CPG_MOD 726>;
-		resets = <&cpg 726>;
+		compatible = "renesas,r8a77990-lvds";
+		reg = <0 0xfeb90000 0 0x20>;
+		clocks = <&cpg CPG_MOD 727>;
+		power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+		resets = <&cpg 727>;
+
+		renesas,companion = <&lvds1>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.17.1


--9qaTTujyaJL0uB5un85j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4972): https://lists.cip-project.org/g/cip-dev/message=
/4972
Mute This Topic: https://lists.cip-project.org/mt/75730034/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9qaTTujyaJL0uB5un85j--
