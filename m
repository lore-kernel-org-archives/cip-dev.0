Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA088C982D4
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35095.1789636459600659406
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=l32m7thS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.3, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaeB+GluiDz1S0gIwzWRe+nBsOEJFUrnSOzJjTSA/UUeI4ddn5NgsaB3jd6Re55pQIU+0jPWi3qhxNwcWSadsCfJRyzs/WLmtj6LNNuzbwuDiiGGRWL42gTdj8gZvOgOIiQnFPvbwkz9b2MSElDkeKWCdQzYNYxrYU7hy/pHVPq62J8eXnNuX16rokP/sohojB2stdgFyi+SfHY6BAWPXgR+23CJ7qEhrdf6twgqBFhBYHQGGtC18Uktgf3ZIEariaQzSPIMm/B4x7dg6i+VsKTAJdzn75qakhjhURNBKrMETX9bzaLi38cmBstk83bGAjpPXNwsbYRLTovtxSR4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD2PxFPAJWlP+an7ipmVLrqbA8G73If+M1NCEkEif30=;
 b=he2JqXkSDbpII+KJuOGTQbAo2ZBqJGit/ilminvNS+Ha+zSxLzagqBD6OpSQWul9Ud7EROOAKKjtUzdl79rWQh9X+Z+KFjmPbfx7M3ouw1XnFNCGUoxVIA6kABeTIpKvpY+3zkbowIaYGeweK1KH1RynBKjtxQxz4bjXOZ/qYwIY5StDChIeUTflqX49sGF9JxCbZqQplEFgPnmUaSyNztfuyqUX2QhUrpAEUcBW4Nw0Tazcyj4EN8woqP7QH59xru0Aajqnx+Skoj2GG33L5IEOdCoR+kMKjfoonNHHPOHFvhvoyYrmJlZOHP0Mx2mDroQtk23P0FjV7Jw4ai9sQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2PxFPAJWlP+an7ipmVLrqbA8G73If+M1NCEkEif30=;
 b=l32m7thSrK3GH0YG5y6jte0fFvlK/XsbtnZJs80taXIm4vi0B1sU68yA7gl4C50mauqmg5byYymE6kqTxkoreiyYS9glD94somWKmUVsJlnUcV46YhXnowUVpkaQg4njq2psRXekieD0RTroVb7+fUN5jODZla3zaIRLtQd/dlc=
Received: from TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::6)
 by TYYPR01MB15191.jpnprd01.prod.outlook.com (2603:1096:405:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:14:13 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::33) by TYCP286CA0294.outlook.office365.com
 (2603:1096:400:3c8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:12 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8CDCF30001E3;
	Thu, 17 Sep 2026 18:14:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/10] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
Date: Thu, 17 Sep 2026 10:13:55 +0100
Message-ID: <20260917091359.18445-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYYPR01MB15191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1846b053-1d9c-4a9d-c0aa-08df149c0a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|13003099007|6133799003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	cQRi32qgtjzF2rjHvSDuQUK5Vrh8fPQTLb6Esb5Kazuxf/ft9KnW0bFHXam+I+xzBflOT09FidV7z+rs1iknuEIhjpMdrhFggGu8Se0lu1fq6uH247QqccwcceujIqBUXdt9+gKOQA/L1XTIXKhDPWZPDetFmFABc+KvSY0vBnM7VkzsIufgiR6d9CGACHYUuImNKnjcEBC4eOM2v98tHWvhw6jDMOp3BSpCtnRkIVKXTk9/IirPQURLJimRlB+BwwjVtPoCeYrWrt4Dwo0L94VeNiw9/spLbcW4DrmqGYC7D0EamAvhxeHH44Bwl1nChFyQUJY1rpF12M7ASAmx94T3tzAynvzwRWPOq3A8MZYkeRkSSbvFRbUnl3XBR/hrkOtSH2+jZ++L29GY0Xo7OBxAGgRGhOum0hIdYDvRKsNu+apQ0kUDlamgZQj3ZWs9WgU2svbkaxtdQNdRwtUQW3XLliy1wxP3ufj+k9PCHtLEnbHDs5Pvr8tvbD8VTDEZzwxg6XX+yTcm9/IDLnGTzb+TB0q3nh9JOI5yiIZXG8jHeG7Z6n1lT6xDhWyQvGs/Zt9L1WES+Cl27KYfDRY6ORg2MkL6TuHUCrs0gd6d872KUTXW7RG4dv+bG+pyIbvWaubcvHhPgEdnXWHF0qW4e6P5pHsxrDbv2y/gPVFZqtE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(13003099007)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	eyBgz0BZOC1Ul5C4qRbQ+u0TAQJDUj8B30jS3BcWDEIQo6c677R1MWoJgjmeUTtSV+Q8TIzCP4km+uum/C5hXv86rcU2HTjW69M+3hStEfAlv2dpnwaWtb0sHHwN3+EBBB7o+FHXM5h2ot72Zz9pd1SyoyQuh009NmbfGtMHLRAUtNpwDwMnsZgvBP5BmWPSzEalZ4EAzaIgbmhAFPwm+zWBV6eSudvpJjm8tX83gsUnHaI770fC4my8NvjbiMLBwAj/jrIa/RjpzzkHtGgBkMJ7JdpMgaDyKMbWGDwzUfFaS/GPKaf5L2D6jJqEzl/rqP8sTS3LcSInQ6boKv6kDGRfNCMtX/PBNSaJPZTuuiJ/Te0UA9bDByO26kYp4PqN2YG6ACgGKljcGrlddSkGolPLoiNNAs58zOpWoFUe7Bz/3MyMteLyBp6f68+eLG09
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:12.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1846b053-1d9c-4a9d-c0aa-08df149c0a3e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15191
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24204

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit f3ac75cfacc66f48523e730646dbbc2f19844799 upstream.

The Renesas RZ/V2N (r9a09g056) RTC is identical to the RZ/V2H
(r9a09g057) variant. Add the compatible string for RZ/V2N and
extend the existing RZ/V2H reset configuration to cover both
variants.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-4-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml b/=
Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
index ccb1638c35b9b..988bb9fa81434 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - renesas,r9a08g045-rtca3 # RZ/G3S
+          - renesas,r9a09g056-rtca3 # RZ/V2N
           - renesas,r9a09g057-rtca3 # RZ/V2H
       - const: renesas,rz-rtca3
=20
@@ -82,7 +83,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g057-rtca3
+            enum:
+              - renesas,r9a09g056-rtca3
+              - renesas,r9a09g057-rtca3
     then:
       properties:
         resets:
--=20
2.43.0


