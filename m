Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC3CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.30])
 by mx.groups.io with SMTP id smtpd.web11.1010.1755706114670889665
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YQB2mz+h;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUxF46FgD1x6H+XnSVN1ftSnmHQEhhnRfuaAn/YBw1WJuvkKBwk++hzCKm6Y9T2crSv7KjSkKamUeVSNh4ZOfukbjhTl8aZBh+JpO8TcKxMUs/G5kwy7Py6vzbqPlHoyA6IPSia1qb61VK7kvuyKHDw74COqMg8oikndvN0Sevgelt0sDyIUIczwssYLlWy017wAJkz5lnEhszgBAqOHRatCr3LMFKLEmRr+g+TqnQB0El2Re059o3aV3KSn2qZ64Sok22MLiaf/A3DCggqBOH6iZYsztJiLlMFjQtgJUdqC4O1sfsd7evTgTL5Hib4YvWksdUhk/P6gPzP4GEe7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pbTxGrNLlJhTUSYLqlymjv0LmyCT0la+vgGx8Dh03U=;
 b=i8Aabqc3aBAja0Rc3EkwViE1ujDN4YinbGFOK0SwnemXer4V3GeLuPIIUPmxgCan0aG5Jf426y0h8NtOt49xh6QjFH1B16bYXfJbY5LnzxfjVE6QJduZ9p+0cGBXLdjdU3fnnGCCvCdQMWwLMRsD9Rzfb8dWZVlrgYpHCPRQkFKxGfpaqEbOap97m+6/iH2SGzNMC+xLaTwBVmBgux5Ru9ZqrsjOXTqvzeW0KnfjHcMPChmOWFpWQhAg1Z8bAoSB1dhdGVns9NQSzoCwqP3y5OkMjugBwWf9FduNf7DYP5D6A7d3J+H8E75Z1+wSuDZqZr0pAV1ihFL+9oG5V71fUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pbTxGrNLlJhTUSYLqlymjv0LmyCT0la+vgGx8Dh03U=;
 b=YQB2mz+h0sNYDlLHCE7/kAcccTlV3EsVOdtp++WGRXfat81iaHKfwi+SEKbRmWzx60bNKvRL1a6GZV/g5nrAqhNZKvgU8yDSyf8F7UadwhB38WZCGEV8e0Xk5kQRuPCZlwQZ8RhUAF1C5kcZlcV1Xmo9vj7olWBHoMxwqoiRWyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/55] media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G3E SoC
Date: Wed, 20 Aug 2025 18:07:04 +0200
Message-ID: <20250820160758.801813-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5f0130-37f3-49bf-e45a-08dde003cea6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BXUyqdrPsOYxy5/+Km3yihSAus1SyTee3qz5jiUelwdcKgfSDbHwuiuyoK8w?=
 =?us-ascii?Q?A5vtE/VKyPQLsiQiX+EKrSZlEWaQ/O8AtVF6Ef4V6bO5yaikzqmFCDlzoVeV?=
 =?us-ascii?Q?l9wLaL0KxkAeRgz9JieIN1mt1Vy8IoFfp4iqbHhv14XkqgxodL/1+Qe6AIFa?=
 =?us-ascii?Q?Tgu96gaX6JAYUiV9d9YSh/YJ8X5CEK9KpHUTJKds/9Fhq80XSDX+nISn9w+R?=
 =?us-ascii?Q?rO99dmfl6WOxeBRwD9IbG6jdoOkCNoB0cMWq4jogHwFVsETPi7OzE5hyUCLN?=
 =?us-ascii?Q?x/zpGA9v3XN0PGu2heceP7fbkEx0z3U2J+rwocOxwfX0kbuwkMoCtD1PTPbW?=
 =?us-ascii?Q?GncdiSSERZlpvfeNSxF+cc908r4mRLopz8lYCXm3ZK8mW4V20kKC+CpBdjww?=
 =?us-ascii?Q?Vf0uZjCFua8+D7H0YxSGTF4ca8S1F98IfGG+Mjrxm6ARHnWSFzF1+xQyVaaY?=
 =?us-ascii?Q?YqpyNPM0ZeFS7G8wvlmcbzt2ET8p/Ee2EgraLNp0KVc/+qJI9yCEg/trMJ6x?=
 =?us-ascii?Q?rEz6yxrjHE7gUKMBgmyv+2Pf+DMEE45wrUI6Y2y6x2DWPxg/dTzX/LNx0MZL?=
 =?us-ascii?Q?N3eHobR9mqAWeu2gn20ZjAPs/nvaqR1gO5iquEzJR/cv08hdcPiq6wSxpSdq?=
 =?us-ascii?Q?L7fPkZYuq1A2TbEakgxT5b31r1vvyLTUCX39kONORbqL+1LJmV8i8D/FftNi?=
 =?us-ascii?Q?Nu22dlkFVvvoIjM+7iWidjZQuBCatW/IOleEZKwp32PExoUdcBWOt2teY8S2?=
 =?us-ascii?Q?UNOTVYPR7graFMm0WzhEyVG94nJgklx7IYlru5TwgH8Hb8GSnJY9BlJycdzx?=
 =?us-ascii?Q?wtRc1xqyFpfbX58OmCsmPIunhjHs/Y/Yxe8Dsf207VQwIi0weFawlyWPdBnA?=
 =?us-ascii?Q?lYxIRPP4z45ZjmAwKXl9kgyvQmTwHNRDOss0IrXA+DD4qTK6hjazbf8ZNakk?=
 =?us-ascii?Q?JzoLKPOnkbBspSuxIrPFm7F/VRvAWDInKfA6sfITtvuPBbODHneZ0MwDICtf?=
 =?us-ascii?Q?IYXtyN6POuW/HW0vrcm4S5hFPkJQ4z9GPUKvcvdMZQME4QxP67YL+51beCSn?=
 =?us-ascii?Q?+C8VLrD1lWuu4EaBOi7jm4+gHGewZ7/OT9cfx1h2SHZnRfoPhlTiic7+VpFY?=
 =?us-ascii?Q?ENcBeYY2XK+IERogXYLAIjLhUoML8ljhTIdX+dimH2B++IMllZEg50K4AwMb?=
 =?us-ascii?Q?5DUxyI3goJ621KUM++hnFP7cpRyCWHem65xzBCHw6FV7sVexjfcBJ9RF28Qn?=
 =?us-ascii?Q?iNYIIfF3TJUvNQsS3JqJTujYennG2CHgAza5bJProA68lgKUTdAKJ3QoLyVR?=
 =?us-ascii?Q?XZldHdJaLGTF6WRlW4zADqAeuBxCcvzAY89Ka9YljPJBV8iKu3z5fEEYVd91?=
 =?us-ascii?Q?fCovphbVt5SQDCFaCSjXUaoFdThmL/zXBCYkmlA9ReApCPXcRKAn3ayXC+Wx?=
 =?us-ascii?Q?3Z8nVsZRqX6gOSbJSJk8TDrqVtJS60VWvbz05lwzujMcERLQ2NGqtgws+01b?=
 =?us-ascii?Q?1uqWORUAn7BDkig=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ixUFPBxL/b0EEkoLWcUU1QC1/iyBeE/Hdi7T5m5ljE3KJ/vxOeQUNsIk2uVI?=
 =?us-ascii?Q?s4dFN4Tl83pq/Tli4cC/zlmkysnTdVUeea7mqqfqwsroymrfYHSzo5ny9QKO?=
 =?us-ascii?Q?L6QUo2vR30rtop1Abo22cMlpEYF3yqFWZ3NoIEJmKcPtnUaXo0ZMCRy7Hvec?=
 =?us-ascii?Q?cDXy1rI81nWlPy9jz+ZAnHbXXpM+iYR3ARFNwKaF2f5NCVZJnqxE4pz5sDyT?=
 =?us-ascii?Q?Qu+PjjNaJ5Pk42JQbP9/CiHv8ZtXqcHwBxwoekpjePz44E37cw/29fTAmzVH?=
 =?us-ascii?Q?P3eHEj8LakA+gxVURdTr4nEigYcJcuunr2ba1Axn/K5GS/PzMbLJiz8uihw7?=
 =?us-ascii?Q?4nJXYtUd75/3t5k+BP+uYtTzVIb7ui0P3i5YEdlntyiVVS/cwrZ//mFxsobi?=
 =?us-ascii?Q?wQQUu5OmljjHUqyFZnOV4rBQ6piQPuyQCy6q4KIQQ+pKQdSNchoOhHEsrdWH?=
 =?us-ascii?Q?kLRhxBkiGejFuD2KNAtxCOdKIM3mkLcC3KAzWjPum4AXOQcs1N+EN7Rux9nO?=
 =?us-ascii?Q?DKwpfxYrIEFnAa+nsyVAT1n0cb8PGffkE5GvTiTkkQ9nZv1GbsCPPYHF+XSy?=
 =?us-ascii?Q?qTw6gfaT98nXbP7d0bcwkzQ3rGJge0OL8OqIU0I6JizvnnPDb0Po4DpHHtDq?=
 =?us-ascii?Q?D/gdHHVUYFnpRj1Aa8TMBF7+LlYajJtd5FlEWIxTz07b4M+S5h3Mlt3QDqGF?=
 =?us-ascii?Q?N4r1EO4tZKSWvCzUl8y1jgvsWc/yL8Q0wBj6fueo8HXE5V8GZODIuTNcwhPf?=
 =?us-ascii?Q?Z2fkfDpJKGbLn9VAD11zclBQFG7gdSMNhB2QgMYl6d93T9jApYjW/SuMn3MI?=
 =?us-ascii?Q?m9CTDm8yyssKFFeXjgOrFemwXUtrM88oVH1fyv7RdjZrUaGiYt7KeFZJ6tR1?=
 =?us-ascii?Q?lFwqnSpKPH5tUwRQeLcnoQGJW61sid7dzW9Zwq1q4SIA/BmW8PMhcLP+PGZ9?=
 =?us-ascii?Q?4Wm0mKkp7RcZdN9fJvxXiGpEQx7czki3fjh8s4F4w9Ykhb6FgDTHDvIQwZLT?=
 =?us-ascii?Q?z6Jzn5kwpHmLb159LKadGoEyEWWyM5ZlXrX/su9RvTu+pvc5ATC9C9ZYiH36?=
 =?us-ascii?Q?RLSAD0hp06YE2C+p9ZfDejIpq41UodyblpAq+Lp6AgR/cJiF2vJFfI6tIEvc?=
 =?us-ascii?Q?zpgEEpwVVV/cRZKa4z4Vs/BDicFBMjXSxssdDBn9ksI82Lpd7CjiNbMW30Le?=
 =?us-ascii?Q?lap9G6cRblnXhhu4B4v8hCOLHFbxm8NEh0S0622DyErmt2vZqn515EGusIxc?=
 =?us-ascii?Q?mVQdaYNNAHfr8GD/KkHOrM2NFw04T6kt+d3bJULIywkSJceLpmSqXSU694L2?=
 =?us-ascii?Q?MLmdIogKMCmJBs4EdmMFj7ekflkzasKUPEMBIuVSeODJCdDnLRsR9edXIFko?=
 =?us-ascii?Q?W1QMwhSpUaVxinpLXJYyfHppm/qT34sttl2CHiv2Hsp6prCECdorQ/+e3VjU?=
 =?us-ascii?Q?spyX8dtHsOeN/DKweWEo7ybm52A4AT3tea/XEzCizTUhz9MeGrmiy1N8dihJ?=
 =?us-ascii?Q?FYTRWaX+oie6ktyCs3sB9zsGjASLjY5oSTVGsNcchAugyCAhfNaj+zIeL7RW?=
 =?us-ascii?Q?w2/HSSf41HgZBh4pWhSjWYvSeUq7k+r5Dp/vGT0ZUcwF8aAQIf/ZkrsGs9ay?=
 =?us-ascii?Q?uGUkHGPzlTYBHRUxu8mFmIY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5f0130-37f3-49bf-e45a-08dde003cea6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:31.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwXk6nrdqRH7wgzPXMiWe6iJQ8U7Pd6MbyuMXYZ7kldA0F1yqMHYeXxY/DCieRmTNLyieNFAsCUg65zk8h/Klp/ff+oQK19JNfv8l/rvmvp+Ld8I3IiiFIVxNGNaegtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19884

commit d71be5add2f3fd4e11c11a21855df17c48088fc2 upstream.

The CRU block found on the Renesas RZ/G3E ("R9A09G047") SoC has five
interrupts:

 - image_conv:    image_conv irq
 - axi_mst_err:   AXI master error level irq
 - vd_addr_wend:  Video data AXI master addr 0 write end irq
 - sd_addr_wend:  Statistics data AXI master addr 0 write end irq
 - vsd_addr_wend: Video statistics data AXI master addr 0 write end irq

This IP has only one input port 'port@1' similar to the RZ/G2UL CRU.

Document the CRU block found on the Renesas RZ/G3E ("R9A09G047") SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-4-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 65 +++++++++++++++----
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml=
 b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
index bc1245127025..47e18690fa57 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -17,24 +17,43 @@ description:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-cru       # RZ/G2UL
-          - renesas,r9a07g044-cru       # RZ/G2{L,LC}
-          - renesas,r9a07g054-cru       # RZ/V2L
-      - const: renesas,rzg2l-cru
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-cru       # RZ/G2UL
+              - renesas,r9a07g044-cru       # RZ/G2{L,LC}
+              - renesas,r9a07g054-cru       # RZ/V2L
+          - const: renesas,rzg2l-cru
+      - const: renesas,r9a09g047-cru        # RZ/G3E
=20
   reg:
     maxItems: 1
=20
   interrupts:
-    maxItems: 3
+    oneOf:
+      - items:
+          - description: CRU Interrupt for image_conv
+          - description: CRU Interrupt for image_conv_err
+          - description: CRU AXI master error interrupt
+      - items:
+          - description: CRU Interrupt for image_conv
+          - description: CRU AXI master error interrupt
+          - description: CRU Video Data AXI Master Address 0 Write End int=
errupt
+          - description: CRU Statistics data AXI master addr 0 write end i=
nterrupt
+          - description: CRU Video statistics data AXI master addr 0 write=
 end interrupt
=20
   interrupt-names:
-    items:
-      - const: image_conv
-      - const: image_conv_err
-      - const: axi_mst_err
+    oneOf:
+      - items:
+          - const: image_conv
+          - const: image_conv_err
+          - const: axi_mst_err
+      - items:
+          - const: image_conv
+          - const: axi_mst_err
+          - const: vd_addr_wend
+          - const: sd_addr_wend
+          - const: vsd_addr_wend
=20
   clocks:
     items:
@@ -109,6 +128,10 @@ allOf:
               - renesas,r9a07g054-cru
     then:
       properties:
+        interrupts:
+          maxItems: 3
+        interrupt-names:
+          maxItems: 3
         ports:
           required:
             - port@0
@@ -122,10 +145,30 @@ allOf:
               - renesas,r9a07g043-cru
     then:
       properties:
+        interrupts:
+          maxItems: 3
+        interrupt-names:
+          maxItems: 3
         ports:
           properties:
             port@0: false
+          required:
+            - port@1
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-cru
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          minItems: 5
+        ports:
+          properties:
+            port@0: false
           required:
             - port@1
=20
--=20
2.43.0


