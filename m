Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1232CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:33 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6977.1778751632092072139
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JAkZT/GB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.68, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cor/8CUY6ZMz2UfYEynpMvddEUsNm+iXEwGdx3UlJo3s7icjXTpTZ24NTnUOow+Dmoh7L2lhvwoXik9C94G0XTzKouumFsXk+DSBVpgSCcpqjtn/XgWm9oMq11iCelCmi6fdSAAkDJJ2Ao4tTXtUs6tIrLqf33syBxRKWT5lYqm8w1jG9i9yQEkTJjlkSiNbwoOh0XY614HKODqEph0HEYDqCAnUaU1Ib0q8AhMqBJUNrzxDbsoXJT0kTJg3V+DA0MljL6H22gBAssaGw+38HgOXD4csppVGa/4tGpbgvCpVAkDik4BHMmhKjx4mfBRSRQKR8qlJUf1UkyeQr6ySjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgsL7JR7w+A37Lz8wfGYo2mqc9yGNBp9468TOZ9iIT4=;
 b=GMouVv1mnThHW5nQoyluJvzLpbV2+OUp2OsPLIRPb5IlWkLCLwkj4469aB1oTc8pm15ahsSs47IDE+tQL3adY8LAzisjRGQr3JQWrzpLPqhUKwdgLutIBcEipB/GL04QpatppDo8Lj4K27nx6G6viVaLWhpVqEX8r3dWfpNGAn0L0h36eMaiIBJq/aCd9Zs6T8Nm8nyT7P7CZKcnr4ZltKkdUviUuVlRoe1JI/I7LdA0APJPiD/oyrb9HLkPa72RcjdrQyYuy+yJqZ4Bh+llPAg2XgAR1KuPwZyynhdBcM5ArnkIl2qGamiJNvtNHEdg0p69P1Ff89AO+UZL3ckbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgsL7JR7w+A37Lz8wfGYo2mqc9yGNBp9468TOZ9iIT4=;
 b=JAkZT/GBY/stJ7ehyEY2WEJE+4G/wVxqRZZ7D4Bc2kPFFLdS17ES/1uyPbIHN8Xu2Qcl4Dg4r8++EvpFWMdhV7TnEt47yiQbqhe8lwKi8FUmYQe4Zz6Q0atubkKLPpUgp3p821+i/SgXoLGz9pUMGTnHTs/CCDWpWb3Y2Rf5VUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:27 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 08/17] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
Date: Thu, 14 May 2026 09:39:26 +0000
Message-ID: <20260514093935.2212718-9-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f41a1d2-fcbe-482d-fe33-08deb19cd488
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|3023799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	omk9SVoIJ39pZC/x/VaZLbmjOSgKH6z1GRJn8wc0N2nbTCtyw2iDmSEXs7lvH3qZzOzZay4l+QNZY9TicU/q6N3JNnHfvHVNW42OU9U85p6vEIWwSB6x5qA30OAR7MjRMwDjFLlLiThWYZOTqmE0kaDEI7dD8BeL+AF98V0JTPqcMmyJdYPYUr/6E1hV++u56rJjLYZRmPZptSVrz8gpUx+eRd06kEbBHJpalXiEvP+J5vDVPvt9y0RzD3T9csbO4fkuEMp/MEKRFFYUC8xqZeykR2I3yH21AVWOd2YUwuhdX5stzo+kT2Fj3qc3YZU8M/Zm9sGw4OaoXJGekcu0eWdd9fJ2MsCU05tdXzvp7SNgv1DFMDe+3u/FaUmwK2l0ywyCnktht6oYN1IFfEt3vt97t9OhNjjbRh7ND3pw4QUQ6ZpbPCPijErwDMUM++IK1YXhVbEu9ukRw4ggMjtLfzbcoqDnNf0/lvLLORTBZid8tbYKUTozBA4VYBceMYzeLUb8ew91HsRqETsua1xQxMEL6g9imJABibUtPdfIDLcWP4vyLNkIGAmTJlZlj02MGvF0DpgEkTIsDQFZhoEDI/EJLH6IGwdEBbWdHPs/6Jk953uLYappk5Yy5akE3l0hcFbObDO9aQtO4d0OaVIzFRvLItbpzkfLH7nsy2OBIgvqvwNYuRwJ118MQ3UK9N0sG0GDD8362ydvCMhAYp4Sng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lVsUha9q/nMqEfuZ7JgvIM/Ol0h5b2obGvVeRk4b5mLkYSGfBVdHlEIhNwG1?=
 =?us-ascii?Q?S1Q/oHF2yI6Al1A4ciO4u6XnDC1L+g589DoGQMu1mHeXmv8fWVjVOptaAjrT?=
 =?us-ascii?Q?aqv0Vtlt61j1giVI+FUQVjkdCiOB4XMNCadRTKajcqotmLauspdRUlOinz47?=
 =?us-ascii?Q?mbwZoMUI4axXeDX9sISlhijS/UJGS59AbR0zv66K0VgwxrtqaqU2AYVj94eq?=
 =?us-ascii?Q?27+xUxVEab6fA4j7LOCdLidKdne9BEtzaN2Z9mh9kFpV83Mdrf0eCTYyPnF0?=
 =?us-ascii?Q?Mzksll9PfmMBMOxIiwd3TbyOBdVMNFZ7jlu9/xc5FZmpkgeUNQ+uO/pcEKdY?=
 =?us-ascii?Q?GLFvxsr1g4tUJJJLTs0HVXcNp3GWYQJg6RCA9Isai7ydkhyFRmIedKKtVLFh?=
 =?us-ascii?Q?MlGORo6/GkqSQ5vsR97Q/p9+Li7ECPhAdte6gVUbtnwq2pI3jyFElcYTBpYQ?=
 =?us-ascii?Q?7plOc1l2BS4zq4EqosSUzXI/S9r1auDwIHUpjxggzJ54tjVpBsjelYL2sUTO?=
 =?us-ascii?Q?O9vBrxGL9KKPKPXrAqWNxj1Xbsgh0Hx++kA5FCPOLhoMQ5zoMrm8yM5xpIF0?=
 =?us-ascii?Q?k5NLY1vC6Zb+RaKqLXHVcRib5rbyMFIR4imYELommMdlOJjH5C0B1DMRhPcs?=
 =?us-ascii?Q?+/7iEc4g96bjyBYifrfN76In7YGK5OQx+3aqcRnnbItuawFsElklcn1tjV/B?=
 =?us-ascii?Q?ucvSu7k03bi5yBQSEB7bE3FsLrWE5RDEHGc67FtaKBD+9JesurzcvjM6sbDY?=
 =?us-ascii?Q?rUCTZQ1elkI55Ay1TTrWc3hd22u8y66XC27AqZoV46HPRrL+1xuguSRGvoT/?=
 =?us-ascii?Q?GVo6v33/Tgiz+fNBseTsmGZ07x3uLV+x6R3zbbUlrVDvG5N1UNm0Zmkkp4bC?=
 =?us-ascii?Q?v1uClP02JBAKjfNrdtDCPtYOvUkrBKCKAc0c/CLsGn/RJ1P4yVkRFzBi/8bU?=
 =?us-ascii?Q?FPAHAr4HAdM4BMTubIqFWspBzhIs5ZLw/+tiu9yzfXcVCkjVi4JzWyc2RVve?=
 =?us-ascii?Q?eV/UWiRj0kyIDFE1PDH6OgNZtdNK9GHkbUSA166AXLzRvQTjr+DuCX23iqPl?=
 =?us-ascii?Q?LGaBS4nB0ul8EC8kVJZ3sN3yksm0wdjahd+YSW+TO9zjHq+6obsC25CNrhST?=
 =?us-ascii?Q?NJV5sKcQDcbynSbEvuIRixQKlsY1oyp7fjuyqwlkYEha0afdBVncqtzULtiu?=
 =?us-ascii?Q?ZUIGPsO8tg9/pqXibW9wdFlbPv9WKl01OXkmKO/uHCtNNkKTBaSwqqWdwJy7?=
 =?us-ascii?Q?CSaZMg4BRF2h0olNebtLA8lJmn9A6NczkZeK3ne0DUTsYBxEfcqglXcIVLHG?=
 =?us-ascii?Q?mrB8b0cuc3jq0lAJ6w0CmIgz4EBeYCrjWUcn1K2DuPjFovIc07bjBVucAjXO?=
 =?us-ascii?Q?QgydS63lu8O4gP9k68uR7FUpqOaDwmp/VfoI1dG8WuwsFdjitxtbfe+10xL5?=
 =?us-ascii?Q?J0lRKR8kuNhMaa75eFYhHTGbMJbul6NFz+owU5zmyf9uMsgfrnSyKJCMAsIf?=
 =?us-ascii?Q?O4tCbVewVl9PdVjBgDcD37CQ60di7khQf7/iv3fVm4x/A57iUnlthMbb9JMd?=
 =?us-ascii?Q?pVHrd5gUrTnOsPDRwZuwzNkZHZhFIuScUf2bCti6oArlpsvCSSD2sNbm5uvs?=
 =?us-ascii?Q?uiopPbSmr4VkDd5uVoNj0RfD7HAdCNfH1/WVum0zBqUOlIGvP4szik2iFjM3?=
 =?us-ascii?Q?vPRfwCX3jKxxlquwl3aoTmxZ+mtKmanfdHd6dL3wLj3c92PDa89Z5toMt41X?=
 =?us-ascii?Q?IQDAP61raaJwEiuAg1k5VkcGvwkKrWg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41a1d2-fcbe-482d-fe33-08deb19cd488
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:27.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9myi7KFm8UhhcCKtPdt/5J3+wLU1dDVs8oeLUaPuhOJ1h1/yJcanOdRBCkVVR+tseeXHwtwVjljRw9okJXNTkG4SXhKEmzeAybSlgiMm1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22942

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


