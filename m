Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95290C43602
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66273.1782987855570662189
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SiKtI450;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.52, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhmjRWbrsa8x85WgJ6eNRKjQu7+WkiV3eSyoW1nmsal0GV8fz0Cu71pBf+27SN0NSApGD+xvvCCrnJPHbFptocQ5QgWXyFqnl8seQ6M0b4PN5Sl8gaK/x5nAWBvIRiI0DKFzJkY6NU+W8R+B+mtVLvTgyTYmIzIy51zFtV+HiZyK3PCekcgz6/x7ND6JDP0ozurCohgDDRMAEVT5popQWyXg4ZGO/7BTz/xyR7PUGUaGg0lsEuyLl2MeJNYQ+mcSD1ph4zb4gaTdtUXDYK60Mm8hRX+y/4y6W/uzEZcM7YVaKc1xp+e2AyNWMArxbO2mi7nEBicHHbEzlUt7NKIc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH2jiy5bkP8Ei6A/jT99XgZUy3SGLy5nTn/DQ+QTxj0=;
 b=eLXkfCga3ePZvDkqZ3xevVVrSBgXCoA3EC4veNhIG5VI0Wi5enUKDoLIosdgCu5RDsGuX5htWFzrLJ9me4SayL91Vuc8cMRfuoOI3J+E9FDoBRh66QPG2vkecdNHkWHbpX1ZJ61pSN1bNnG17gEvx+CO5y89gNCWHptmlvaEEz6VBAqhBtZaLeNRPxTXTJAvt+S9Zg5JnDYJIlFomML4jxIETVtLfj0QTrK/kmZBpnVQz95biKBUgpjLomlhkIJ2dqGFtei4Ep65jHNPxId0muZKkYf6U7Xy2+kMLZTuNH21YZzaamoq4xGN6YPOLs3E6DJBF+gccfeWADOi/Hem0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH2jiy5bkP8Ei6A/jT99XgZUy3SGLy5nTn/DQ+QTxj0=;
 b=SiKtI450nWy3TqnYPV5rH0Sywwab1puGfI/j/UWG/I+qWVSRfGovqk7BxHGwtA1pX94Q1Q/yQcAONX/rIAXABWy09OeyPcfJPq2L8muQwb54vxJUq2pA1wz1Z9kz5/UauaGIwoFXLsWHA3Y4f83YewE+uEjf9Nn3iaC5V6Viacc=
Received: from TY4PR01CA0040.jpnprd01.prod.outlook.com (2603:1096:405:2bd::15)
 by TYCPR01MB8852.jpnprd01.prod.outlook.com (2603:1096:400:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 10:24:10 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::89) by TY4PR01CA0040.outlook.office365.com
 (2603:1096:405:2bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:10 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C465C300024A;
	Thu,  2 Jul 2026 19:24:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 07/10] dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration properties
Date: Thu,  2 Jul 2026 11:23:46 +0100
Message-ID: <20260702102349.23431-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TYCPR01MB8852:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6a6af2f-7027-4879-93e4-08ded8240e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|3023799007|18002099003|22082099003|56012099006|11063799006|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	s4w6DgiPhJARH/CRLGgaPGGkwA2CtvxiWsiaSdJBCCfUrLc8TQy/yTEFH5aDm9tvxtK+XRn9Y8UNowxoZTMP5HV7JiJsOIN5DkWia3VUloWMmVyCLrfQj8N5JWKnyk1VRLGX6J9qn0AE8Z/+3kVtn2SLruxlsBqiEZN2jMUb9RRGEqRFW5mekl4jTn/yw+iykZzb8JCJ++VbDt4i3raOxHuDiDXmPT7olYRjbSjHMouJZRHcc/5EiYz0r08QoGF7QH90VCSmN9gw0bskmgJ+oAmENfz3DvT+7PTNm00F1eGvWecCzzS4wJZbXcafTGmO/D7M29fozoIFS2P48Kl+UZ/L9DOWMTe2FhduEdsSuAFVTZuDlOwyC/G7GR3eQ16hn8lBiQCl+aEPfM5CJ/AQaGYbVjAvDLrBWP/alpdiS0hmVzCfs0SiXYebm2jD2uSfPdg7m2vNlJto0NkCPpdDs2hZ/EbBOWwiN3d/hC+w+RYanY+bKg7zeBh9lNYJfdECDdHhC0SBX3KecNgWVknynLaupRTr6/olEOMy4cm74ErJPZqOr7vLeyNO/iC53f0SuzStQ0DrKVsNKAi1KAE4d3Taq5tlS6O31xoGbOIm/xq3GodT5GRFDmj12mrAy3/y3DjmiIZw06DWxMUMwgv1PC+Cf72wrZZyTH3IMJZIIO0=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	/Fiprt55gvlg0ful+mEz3zGU/3Fdz3qCZnLKcTezCJXoJ7WSIN2Fbmr5sGjgBtw+Rp8vjENbhT/VbmbtsFTFx4nhTrQIsWYLpHI41MnwTgU1/PtMQaTfNQyzZLMXZxhHPeGiDbXNfHvjcPpYTLo3JPnvnWfYfnGAouKHyEsQdW+L+z3N6+bf4XXkRp7gCm1TxdGpUbtkdUsIKq3BV/yuPbeQrQy0Eph+dqQn/vuZOqCDwFuqUxVUsjSesUQCmouiM+5z1+jUYNLKy3ipyhzpsjLxlvZUA9YsVuhivSn4Y0XoJ1DpW0CPV4oRESFSCCmdNWDPmZ9EsXHfa1xzz9LBk2I+BHEVP0R855ldhhjpfcEcOYhkCQ5l0ZMHID7OjaTpUZ2dAX9BBTVabyVNg1RvToUaMWev7v0tz0nEf3s8wFdWR6zFdMHQKYtUYUfLaSLx
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:10.6467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a6af2f-7027-4879-93e4-08ded8240e82
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8852
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23388

commit 9efe63b74e9c30777db9815dc5d38d667576ac6f upstream.

Document the pin configuration properties supported by the RZ/T2H
pinctrl driver.

The RZ/T2H SoC allows configuring several electrical characteristics
through the DRCTLm (I/O Buffer Function Switching) registers. These
registers control drive strength, bias configuration, Schmitt trigger
input, and output slew rate.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260319141515.2053556-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- New patch
---
 .../pinctrl/renesas,r9a09g077-pinctrl.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pi=
nctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pi=
nctrl.yaml
index 36d6659714842..d622cd94340ab 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.y=
aml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.y=
aml
@@ -72,6 +72,23 @@ definitions:
       input: true
       input-enable: true
       output-enable: true
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      input-schmitt-enable: true
+      input-schmitt-disable: true
+      slew-rate:
+        description: 0 is slow slew rate, 1 is fast slew rate
+        enum: [0, 1]
+      drive-strength-microamp:
+        description: |
+          Four discrete levels are supported (via registers DRCTLm), corre=
sponding
+          to the following nominal values:
+          - 2500  (Low strength)
+          - 5000  (Middle strength)
+          - 9000  (High strength)
+          - 11800 (Ultra High strength)
+        enum: [2500, 5000, 9000, 11800]
     oneOf:
       - required: [pinmux]
       - required: [pins]
--=20
2.43.0


