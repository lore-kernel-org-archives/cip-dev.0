Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E1CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7015.1778751767293413678
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=phKxcQRE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.28, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9zQAjHBRBKNu5ADEKG348mPuosRTtCSj77U70zPHv8ifVZL4LtfBznIXIN1Kil7hsRkBWA+oyYJOIm4gUNxonSgDc/7nMPRANuO2LuNjyorAgCB1oUJ7FUSMw3NLbg4RN4LhSsWUmf3gKcVOKRoge1Age8PD9LU4Y/x5kN3xDnoXOSeP0hG/KBsjTY5dxDif48ty0HGjFyzwDkI3fI+U9ypHaolMF4A6o/CRTNmU7jqOWSyfdMSf+kHQMuZSZFJD/pQElKmdeuaDDll0rGAxXsqlOvo3QOiBJDiHM3IrG/Co8sYcGxaiVjACK1EseKHX6h03iCLWlPngzBRM/DCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgsL7JR7w+A37Lz8wfGYo2mqc9yGNBp9468TOZ9iIT4=;
 b=ISh3xKLRDKoNwaL2e4TxPb9M8kGSHVTIoMAXX6i39Fie+k/ZPbkkjYfsiwPoDhCTQdQ8wW78TZpCfz8FntiHJiM8peJEKpRXf/zoCF2UuDZbmoQUExT7Hl8+6Famz6DjwY/6R+yglCqDatcSCmRvJdMog0aoiXcUKBQ6XEqkbonYFn/Og3zSd58DK36rW5+F6A4THdunu7nuu431VGhFpUMocLVVEktWHrJQbfkpfgwU6uvqlwgCAFwvIeuzbZOJX7I9m1xztbAdi5er3gd2XOY8K9+YekyoQ+m7IjT39GkxUoMqBf+AD07DCfjdm+lutcJTpsLaFJIjxUNfeFubbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgsL7JR7w+A37Lz8wfGYo2mqc9yGNBp9468TOZ9iIT4=;
 b=phKxcQREQWdg3YWmp+CT37ONmsRW3x+xfI5FXt0YSJ9P73vKfpE/Qi95ze5HBEPX8cU9utC+ks5LXM0jRIqdhr0v1/nrm4aP02bgVd3uonTL980e2c+HJNt/OFpeqiAdqpIWeWUgMnTV4SvAj1z6NZbhaiGFkmAroVo6dWjUSXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:44 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:44 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 08/17] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
Date: Thu, 14 May 2026 09:41:43 +0000
Message-ID: <20260514094152.2215176-9-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dabed7-9142-424a-84e7-08deb19d264d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|3023799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	oMT57ruxAIcppmqTuQYW44ACwiTaCW7EBrZrekh+dwbuhYMbu93ekAK1uRV50eGcyYVgBE2iXk2ed8TUWGi5r4K9R0OK6leauishE7Q8afKwQZid/YZfTKU3aMKwM2N5Wjpa9R/PchNcF6TRNNx6zLLxTsSLzfU/sJLvKhyv3+hZZElW99iiDycPiXeX4r9zzU/bt+S/5WNSh78e2X3eFoN7HYrZ1I8b82+bPyvd/SWYAdStf8e9RizMMLAo5sq1bAWF5pVmoLCROfL1yK7TzwYpX31vHBeaI/wh51P06XROYDKg6Fj4VfQByGfY+4gDrgKHn4wV5dhHazlDXTMhyB0kXvMbUSs7tgODBljeMyxAN+iAd48Pz9Xl3MyQ7oaDBpFYo+8TZOY11k1kwmyRoOFkOinQav7ByC+pBq7u+Ctk5XK/YHq6cuNda8bMj84HIKOzamVCNd/OcYkB1peygRmwCH4BXQGj4x3EdQKs4GXZ1n3b3aKetaXIQ93BBYgRDoDMmzTVauviUyrQLbErHNk7a25sZtZXNvQAYd1DNVUbwl9/9enXuRJ2l9RxyagXQUSfh8T5oJlLn6xph0N3KNR1VXZm9/25cdHxvpDw6PvML1/FTVcOc2WIX3JmqyWKYrFCFYPb0K8r/TcEc71WTpcL7dwopANpnZqU2HbhCw1RbhtCmSkuFitjQIYLE3tbhu2CZlh78eDysiPxn9x1Uw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E0aOsJY+9XcK4S7XLcjeyCssw3OBAag8lcPtLj3YeeMjk5yMXxX1QtwLNxVm?=
 =?us-ascii?Q?QW0HKo05MQ82MsD6LM1F+ltGdncxPH2S3v3YrJrq1WRdOIYmqsvo+zVZJJXq?=
 =?us-ascii?Q?ep/8Mrskcg3YunRnYTUL5KzhFRIUTLLCV2iUU+qM6fDqpH/jutXEe5p30LPm?=
 =?us-ascii?Q?83VOWt/tCotxJu1Aj/ynbuNSQIrixAe4nbi3a1UHgqV62ZygMkGnZYGRzq18?=
 =?us-ascii?Q?bSUXvLHL4TrJXlcWff75hb0qChQcGyKCeQH9zSgbUej3iAIq6K65MF6+cAfR?=
 =?us-ascii?Q?V85ZyDxv6ZN2HEeAL8YXJmg/VzkCgcNdlbmR6nxuO7Ro/FQelOkCnhHAjo1u?=
 =?us-ascii?Q?F0HYCXZxK1E0RlZk5QnDEuI3R57K7+N8D0WvWjuWzw8JlytSe60zEB/GDRK+?=
 =?us-ascii?Q?Op6hirFAdHNGv1cIBv30TmTKWvo2Iz7/DVdxWlPmAfOxs9sVqwZ8Zq48GCgO?=
 =?us-ascii?Q?TI8mrJ/g9VIN5rb5m9lD9DbEkboTrp4jiZcpu7DYAq81ttkmpvOt/j5dV0Tt?=
 =?us-ascii?Q?bsa2H8N75RFm5R02f3SFX+oetXWWT/H7lfd7hqOaGaUQwuNi5s36HnunXda/?=
 =?us-ascii?Q?7NQFu7dbYLfgP7vQRUfnouH8d3WVoTtUz3CGcBD0rmaxstzN61L2g5z1xQKN?=
 =?us-ascii?Q?6aGIxf7A+iGtgqdtWHMhXybPZWjUnJ5ke+UZg3c/MdaqlwB7o0QFLKZYZLjQ?=
 =?us-ascii?Q?nwL//IL2m+Hfmu/FyuxypelbZNOqTF10KvGVYUCFHDsiUlSaQzWY3QzmVlNM?=
 =?us-ascii?Q?/7Tuuzs8Lx5Zk+gRk+j1J5Lkr9hG/bxyDiHumYx7OaKN73xazo691hrsYUhD?=
 =?us-ascii?Q?WMyKfWytSUzjlfYLjElHc48w5y8jE9qBE7iOCAZdTgT/P+DTrg99Wn2glEuU?=
 =?us-ascii?Q?NOjdKaLx8T9PNpPEiLQ8m4kHea7FPzv38x0FAhfNso55fIWzHKEYUWtud99I?=
 =?us-ascii?Q?0gTtxoG3Z39g/RlccwNuqhEvxomasmNi+nZcUsp1GSQAsLU7yFGeU2rNxj9A?=
 =?us-ascii?Q?MvkS0lQPZWQ1WrC03tmOdyRzh/psKloGJ5L8fAEX9NgXkOEx24y6ZqzrtElZ?=
 =?us-ascii?Q?FqqwDbC/o83mTJMlZF6b56j4NUte3F1WwAbZ3Iy0dNgMXYFbE76JG0H7cxec?=
 =?us-ascii?Q?/gVJFNCXopHjI8Z5SQqPUVzzpWxRgscoV0gp/QNLSYoGlKT1Z+5mXPmkLiAC?=
 =?us-ascii?Q?k/dyFtLo69qL1wq8r9PibcdkWDVCxsTysoWsx9jAedREckPW3JOu0TZ5vlk9?=
 =?us-ascii?Q?O36UJn0pTkfxgx5uz/O5JjaRANqMUQo07qNz/svpoBv1Pz6jtzwXc6XeZmnf?=
 =?us-ascii?Q?ODwILkEwzE1TC5TQyCJw0nkPj/FWsoYgBohNiKKy32hODSZskYRpw86KqNcn?=
 =?us-ascii?Q?bnym9Mq9YzNqK2beEOtk+Opx7p6OvYU2FNR/LVkVeTmEJ3cPiZf58KkfT8VW?=
 =?us-ascii?Q?3FPXRR1njx0Vx750rLr+408sIzUQM4coaZxPhro7eJCBXXkVP4pCuDymTvtT?=
 =?us-ascii?Q?0PLH97Chdrw43iDGL/SxAVtY1zw2Yyk5l4E249CT3XypAwUdPckmYTmVaHei?=
 =?us-ascii?Q?rS45E6ts0xWryIpgCuHT3KyNmOHnlbt3KbFwIzDxn2NvNBKt8ya3BWQtv5o+?=
 =?us-ascii?Q?adPMC42BhNFbwGajX3tC6T9LHTO8Ecvnu5QBvPfkYH7C5Ysz6o2U+6AFa0LL?=
 =?us-ascii?Q?ee90RqvAHrEWcpPj8T1uxvw4WRPcTpXqxqot5MOR+Lz8omXMb70VBuKa4bFs?=
 =?us-ascii?Q?NRx1TsMvu1nIdpYuB+VKFGSAm0otfds=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dabed7-9142-424a-84e7-08deb19d264d
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:44.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s8yWDSG67LAMZI66Ae+twGp/srxbPZgX8K/eMqqxUksgAGOIHc/7uue7gHdyyqG4SxC0qYCVNlVI5g8HBO8qGJ1YLBnT52Q+NXzhU0rx/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22960

[ Upstream commit fabce18494e5a4f388c70a40fa8351c911790d8d ]

Extend the existing device tree bindings for Renesas RZ/G3S PCIe
controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie)
PCIe controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has
some key differences:

 - Uses a different device ID
 - Supports PCIe Gen3 (8.0 GT/s) link speeds
 - Uses a different clock naming (clkpmu vs clkl1pm)
 - Has a different set of interrupts, interrupt ordering, and reset
   signals

Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-7-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 73 +++++++++++++++++--
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.y=
aml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index d1eb92995e2c..a67108c48feb 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -10,17 +10,21 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
=20
 description:
-  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specificatio=
n
-  4.0 and supports up to 5 GT/s (Gen2).
+  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
+  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
+  up to 8 GT/s (Gen3) for RZ/G3E.
=20
 properties:
   compatible:
-    const: renesas,r9a08g045-pcie # RZ/G3S
+    enum:
+      - renesas,r9a08g045-pcie # RZ/G3S
+      - renesas,r9a09g047-pcie # RZ/G3E
=20
   reg:
     maxItems: 1
=20
   interrupts:
+    minItems: 16
     items:
       - description: System error interrupt
       - description: System error on correctable error interrupt
@@ -38,8 +42,16 @@ properties:
       - description: PCIe event interrupt
       - description: Message interrupt
       - description: All interrupts
+      - description: Link equalization request interrupt
+      - description: Turn off event interrupt
+      - description: PMU power off interrupt
+      - description: D3 event function 0 interrupt
+      - description: D3 event function 1 interrupt
+      - description: Configuration PMCSR write clear function 0 interrupt
+      - description: Configuration PMCSR write clear function 1 interrupt
=20
   interrupt-names:
+    minItems: 16
     items:
       - const: serr
       - const: serr_cor
@@ -57,20 +69,28 @@ properties:
       - const: pcie_evt
       - const: msg
       - const: all
+      - const: link_equalization_request
+      - const: turn_off_event
+      - const: pmu_poweroff
+      - const: d3_event_f0
+      - const: d3_event_f1
+      - const: cfg_pmcsr_writeclear_f0
+      - const: cfg_pmcsr_writeclear_f1
=20
   interrupt-controller: true
=20
   clocks:
     items:
       - description: System clock
-      - description: PM control clock
+      - description: PM control clock or clock for L1 substate handling
=20
   clock-names:
     items:
       - const: aclk
-      - const: pm
+      - enum: [pm, pmu]
=20
   resets:
+    minItems: 1
     items:
       - description: AXI2PCIe Bridge reset
       - description: Data link layer/transaction layer reset
@@ -81,6 +101,7 @@ properties:
       - description: Configuration register reset
=20
   reset-names:
+    minItems: 1
     items:
       - const: aresetn
       - const: rst_b
@@ -128,7 +149,9 @@ patternProperties:
         const: 0x1912
=20
       device-id:
-        const: 0x0033
+        enum:
+          - 0x0033
+          - 0x0039
=20
       clocks:
         items:
@@ -167,6 +190,44 @@ required:
=20
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 16
+        interrupt-names:
+          maxItems: 16
+        clock-names:
+          items:
+            - const: aclk
+            - const: pm
+        resets:
+          minItems: 7
+        reset-names:
+          minItems: 7
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-pcie
+    then:
+      properties:
+        interrupts:
+          minItems: 23
+        interrupt-names:
+          minItems: 23
+        clock-names:
+          items:
+            - const: aclk
+            - const: pmu
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
=20
 unevaluatedProperties: false
=20
--=20
2.25.1


