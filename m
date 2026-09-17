Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC7C982D7
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35315.1789636598001237655
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PbPwE2EW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.3, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZunONyFpKeZWCzP0/+HnexPFcu8Kdkp8cgQX0x8ERJSm4Jyc8KDEIXe83Fc5MR4wj0cdQOLU2+Oj6GdONXnF6DnWTqyrJpn8Ib+4uLoasfXtHBv4uY2Ks74WUkQoikfDci/3RXF7tStUiOXYsn5WJxvaAhLzJX0aW7kHPZ+Nx2l0IjoG+OnmnZarTrGjr07KAM33A6qs1Veb81mgyKNl9iUVsjKcViR3ThzR8a+RsxXHWw0jgPIFEFiaGsZgotzUXISe/iCEJmg6Jh1AmUZY3neKe6iD1SSBE0em4wLxgOvRYMSViRoKV82mtC8+aymVjrR+rLV3hUze0z4h2kDs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD2PxFPAJWlP+an7ipmVLrqbA8G73If+M1NCEkEif30=;
 b=Gcze2Lf7Yj1IHLDzStzanhPcsrs0LSNV9YNPOkYBR5DT7EvkbdtTqpmgfpwHNtFMaO7BqfFM3+SvuMHesuC3wbZxZEvhFGI4r0TnMeQB+Kksl14Rg6/NXIt47/7DKYwwww1wugZQjsMMgcB2CAqTudI8LyRFEqgTXzpKqc+oMoqEDfxjGLd5abhbfxl2ZpfXn12pTpdm4QjGskw3VencYUyZ5OGkbuXRClbwcp42F79ilBIFFFgrJSgh8zzEbXdIUHcie48oMmOezk7H1LmoN+dpZp8CCXPDNqoaVeG7KbvfPiW7f5cOjzu4T4n3bEesnlrmdu0PPyfx5g99mUkEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2PxFPAJWlP+an7ipmVLrqbA8G73If+M1NCEkEif30=;
 b=PbPwE2EWm048DHCrkPlJ01O+6MeF7lov9kmjl6iczLnCZrTTPMAZVZKftpmK4daLTAadqLp3jiPvj0ZwKqduMhc2tKpEqLBsaFLNmdPy8F2V53HsLZmelzjkWfnsG3UWle6F805es80B3taAgt2BCq/KEH5BmmGs0nxckUw+jS4=
Received: from TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::11)
 by OSCPR01MB14551.jpnprd01.prod.outlook.com (2603:1096:604:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:16:34 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::52) by TYCP286CA0283.outlook.office365.com
 (2603:1096:400:3c9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:34 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 3A77530001E3;
	Thu, 17 Sep 2026 18:16:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/10] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
Date: Thu, 17 Sep 2026 10:16:17 +0100
Message-ID: <20260917091621.18551-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|OSCPR01MB14551:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d226e77e-6687-4748-af40-08df149c5eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	8RZFCkyHaXLo+Drnx/paG6C4zmFC8zMDStQzjPc4Q4ibw+iZWtOmOethBZd/qSlZoL6dQ1Xy51CJtKOUguAv2xtUYPALO5If/bcIRX1qq4DwCP4eWS+4008q4HpitnIg6BXBb4qPpoHsxTH8otOnP//ITzvNdTKypVsB/IM4qDHGiDf9DPc1a+vP9mZUeJLEJ8bNcfc+D9Qw4TW1ErhxUqyIouWD/WBWPl5RDoQQAfhQbcoE3hrEfgM75291RwqQXaG8mf9I/EeuAAuWqOlptBAcDIRMo1hiN+rfhO4LoaUGaeQZpysqWhYkyk2dxenpn/GTLHSKO2VVhY4qaHIEEETTEJG9MCkJgRx4zYQspGu13rEOdMXsoZxXG3Y4dwJcJf6AOlpTsG0UjTefh9Hauxt0CWuBKZkWd5mIFXWRFmHuaSIGFs19INS60wb28lO+f4giYUGEShhX51syNJ4ROTXSr+8B0H6+rQuP95BdyEW+tVi/GknH3sph/bpWhCC3Nfx7vAyksGMKUoZnlvHkbUmUQVZTRzS7QxGitB6TKXkxcJpKwTTW/jV0bBdQ+shQpcn94zCSrqf7b3OJCpFWq8wjlPnJmts9NDaZdpbbeqRxnfbH9T1QnRF5g2NIdoYCQ3Ij0JJ4uTTfB1/9fVzOPVuWZQ8bGUZjnuxukF2C9wI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0aY6n9zGa6x6IBDRo59NvWcyLgR6KJs261D+SlK4OsuvF4XUSckycWzmbj0xyIBSxjttBalsmBLUtQAaHPlVwlG/DIlm0/o2O/ds58uDdPmymTNUEX9jdIHe3aWTwBMb3tBrySYe3xIa/ZwEkO5JVnmyAKDaoqerXylxnS8/90oQ1GBMapcTJA+bHYM3MBNYNbhj75ULoAvoQy0WlDEDXjv1HlXeX+ffDXLubDpYORGv2ZvH9mMLwDPtiRQDyfnTEP93u5ZePDE7nBBLzm3cnymqESj1OTFD3P228idbzqK9xHNiJ6jsKwWXb3QsJyL1rOTZwN9pzvdV1DDxCxXf7OYjPrv5/2EC46LYtv0KEtK/5+YOm9Eb2CAHj328OlumcIsbmFU3hqX0GDMfqGdcmi5j1hzSCal6IdPmkrqKnK/3/8s4buJaSdg8Fn8yEvtw
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:34.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d226e77e-6687-4748-af40-08df149c5eb5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14551
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24213

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


