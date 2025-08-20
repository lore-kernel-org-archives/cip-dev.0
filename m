Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A3CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web11.863.1755705887237728655
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MXbogo1V;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW50XyOaTGPstL8oVQ4aMLorOL2TkjlkIQDY8TdCS/Vy44EogGnzprA1mM0lvuA5VlA+FSLhENvQF9WCgawEV3ctbuQ9dlKWoz6S85mDaXtD1SKvvDbVyhn8R7K2uio540aXg7YL++/n4IPrxb2anw+q9ZE7TsYSere8kbqZssfFyWKZNlxMvHysM+4MPxA9l3NYNW0wHTB1c+bMTa6vjrHp1uomAqer+yV9IbEf7waVQ66Fr/M2iFfC/MFxLR4rKTCQYZ8Hq/PVlR/yfxGh8iXpLbSusER0NREeVuN1Wi//0/v5VwwyIRsR7hGtXQVM2aXGJYtAMVxypsuleWRPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni5vl0R3QT78pmovQtbvMqqu1jj40nN/20GUD95eRpU=;
 b=e8XPHeyMQji6uENLW3NN4lv7uwAGLC8qhfafKEIvCVAsxIra+4IIiYglGPzDb5AlZSHU3H2kAmApkDKsbW3CR1flkIsCW2Eg2G8MGN3lXQT9jYkNs6ygXL1tDXaPAhWtldnzsSW5tGqYGM8HuJMJoRxN1ZCqsNibPQpdnJz1Cfhk4V7OMQIE3kXvZxVjA/0hLq6hrMuduMw+Gq5sSPjDL/OEh/eamLNM7iiCIW9hU6Y5z5XXZbhdGz/vVDtIS+VDnHm3IJMHEibzn5JKFuvq+Te0/4+GwQo430JjGGLPgT0zFIzfSoCVfXdYA4ugWT1wWA5TyYCV4LnLCc9dqhNw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni5vl0R3QT78pmovQtbvMqqu1jj40nN/20GUD95eRpU=;
 b=MXbogo1VOOzIxVReSrU1W/e/5SbNcnDbu1xmk+62uUR1S2MBvQjVK94vlArQuZOJraI4yAz/7oDYnt/ezJONYkFfzg9Kl96l4CDqxi3s7WqzbTuHj7FlLP56N2t616T382Q2m+drCqAbwcJnVd4K4gZdPosO8la7lIIoRq/BbFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/55] media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G3E SoC
Date: Wed, 20 Aug 2025 18:03:19 +0200
Message-ID: <20250820160413.801341-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fa59e3-70ab-42c4-d806-08dde00349bc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B7HRoUGEHhszVyi3WgBhRz8sBkLvaf55DgYc5itn3CLz9/0SXFwvH+o8Z+5C?=
 =?us-ascii?Q?Eit7jchGEOIWemNYudESOb0Pf6oQHkZtSe1KEy1zWCbleOJ6Wkj+Fbq/i31U?=
 =?us-ascii?Q?NICJYxckgzDvOjKt9VCJmwURqg6kzW0zigMgYAS07CQ04KO6ymt9RPxLSW2V?=
 =?us-ascii?Q?5ttL6EMj0iqKBKHLc71eQFJRnxhqCXhyr9Rrz65u3O9/XYdMZ1YEueOmBcav?=
 =?us-ascii?Q?eQTJpac5IWCWQRDTcNjas7h4V6k0Ec5qM9+nqaqAlRH4zmPE0+pNKy3YvLYh?=
 =?us-ascii?Q?pd1vVnNeZK7b6LBXjW3fsn0ZGN+7CsQJ254ErZPwytkD6e+OErck1Ge66xPI?=
 =?us-ascii?Q?DpYsmx4ZaN82Sh4COXECj2Q6cSDgjYdHN8CtWTPAcX+08o+pxe20x0lDUMUF?=
 =?us-ascii?Q?P6xkuiah3a/RKeBPSP7XxJnSUm8MqeuVezOrqN035Jb+dLuPicJ0PXLP+Fg5?=
 =?us-ascii?Q?X9VM8DZzHBfxZYCivnMhgEdO4vyS7NuLfcWa2J6KVVStVQ3BDpV7CQcxuZ/J?=
 =?us-ascii?Q?/mS500cT+70uQFBh27/iH/gPxzmIpKIR6ylf4Rao0TCKeMt9/D/jf4UJO+S0?=
 =?us-ascii?Q?2WUHUseDO+t0a+zOgCDyOYK1PI82C05fD6H9FcN5i38O6uX+cI00UGXf0O4H?=
 =?us-ascii?Q?DiYMLtmmMPc5KZCXl2SZeq6M/1OKf8LWekLuXrsUZ2puRB+dy6ZIVjxBcGf1?=
 =?us-ascii?Q?7ViaulxtqtBGgjHLW8T4nZ/QmugRsFpGucRqczPyaOpyqlXwcWFfuVQ9USp6?=
 =?us-ascii?Q?uQ+27XVUDyydgou5+Y6WM8+R2M8vUMQVwFAa2dd3A8nNmLnoAE0ArDUs7E3B?=
 =?us-ascii?Q?oDrzA594f6QryVX7JKQE6rFYoXj0JbnOwt0f4jnZ3iVbkNHmOXqBvBEUzV4c?=
 =?us-ascii?Q?GQGIMRIyNsQZ/6jAlvyGNa3rwr6TMo9zd3Sfvh7U43fuUaYe8AxyGRpEkNq6?=
 =?us-ascii?Q?/2cy/8pClWJ3PD79BwRjqThBxNB2ZbB6gLcE6Fh5694HOH0oALPFUXEbD0fH?=
 =?us-ascii?Q?UW8iU17YOXOTH/r84QhubQcABmg7menhrMr0qbpqQmUfYONMeqSvGZ2kFz9v?=
 =?us-ascii?Q?G5F+3qL/ijjFKg0QBzadrN8JQpeu5jK5JBrzksoaI+q3uuTQ35UvsGVuhds9?=
 =?us-ascii?Q?c0fCw3sS0zSxloOa6jon9QXBaJo+aLShWPWMNszD6JxLLEAQsTlw6B+QDfKO?=
 =?us-ascii?Q?TvFbQLJuJFimh7Ix5DUjAF/NjnnQheAsYP5oHdpQb+hPXNeq9bZhsaUfKSHE?=
 =?us-ascii?Q?IawnbfGAzyi26W1MfrwjHP0U6gYesUlWhtVGxGPb0N6mlTQ+YDuiGzMWIYKj?=
 =?us-ascii?Q?LPE1+QzqMw2R6DCC/lCRFvP0AYmgK1GsibjjyoEgl+2hLf3exwrJIkArlXxt?=
 =?us-ascii?Q?p54B0Y7s3szvdejhtRS3psStaP2r6XWG9RXluplDaOALidzc3QpuI9gSeI2O?=
 =?us-ascii?Q?3bUmH62SPCk08hxzmmpeph54X2BIqItDqx+3gjEg7nzw5drjCBYb3ZIx5Z4U?=
 =?us-ascii?Q?j6Suyp9MTHlZf+A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wtol2gWVSQjVlA4cXu5R7rnPUp0UUK1fQ/5Zez6VqbJy3ISjLTDIxK9CYUP1?=
 =?us-ascii?Q?U3u93KZtGnNYAoG2wLXsT966xrNN+nmkt1xBr/oOc6gkUcXn5cTsfn4DFptV?=
 =?us-ascii?Q?V940gEuEdYcsCDu6C48skFWZkSPXJs5UmFp4tJ0fZihe8EFQmhPp824bE7Q0?=
 =?us-ascii?Q?xd0eq5R8ZykA6MJzOQtko5wmrT0hrs7/F3FR0MKW3Fj7w3SZ0WpbBm2QhR2Y?=
 =?us-ascii?Q?9b5gn4kzE6KC3qvPEhi9NOvBo934sVcJNqRfwtoZ1SwJdmOEQEvBsJiKHfRj?=
 =?us-ascii?Q?+MuZ44BGNVFlrL0g9DS+1RCbnybk0vJ/wfRApOE/cYqAXk9B+87mxMc94ifU?=
 =?us-ascii?Q?D21GgAF+8X9+hVkNHV4Dqh3HzW/qEUGNzl+jluDPZTkcqAKin59/r8vihhSd?=
 =?us-ascii?Q?T0CTfj8l/SAI9OhAY6icq3yrBI0A4xiiDKKio2VNWJaxDGJ+kD47ENYWAJwp?=
 =?us-ascii?Q?hqLPne2rTbhgtSSxH4QB0SxS7pFHrXkJvY0HJX19O7z24HYEYrYHjv5HLokE?=
 =?us-ascii?Q?OdmJqfODB5F9EQxXCnsmM0Dut5F8BGqtqvn25uXPaIR0q/IPzimHNmDuHkh2?=
 =?us-ascii?Q?2uxQ+UfUMqbnd01oNS7eihNh3QhhVvX21OcDQx1Djpbv8ND7UUfB3jqe6V4z?=
 =?us-ascii?Q?Nk36fNIZtdNiTbUSUSPQTcVjtTDGGzqCpK3+oPfO56D07uFZg+bagSMDUYE+?=
 =?us-ascii?Q?TsW71QLQfDAMN92DQfHuOH9tDQPkv+7UAlcipXI8rRmVvLQNOBPpyAK2gCDC?=
 =?us-ascii?Q?ncuDjof96CWUjs+j+0G6jPxTs+TUyxHWXFRSKJuNET5YgD+Er7+4C2eMGhmH?=
 =?us-ascii?Q?Y8ANKkKrrdWcoDXsTNtssnCF/0HObl8pDQ9fN2IDwXAM7dfVnQsuTYf0obkH?=
 =?us-ascii?Q?y3xEWRzp6rJTnCUGMd8CtnupRB9GH88nO5Gl+CJ4wwjJqKD8mCR6nFitxHKl?=
 =?us-ascii?Q?bFr2xUFb79ImOE/T6HE7nk4ydWRNfyTvk4tE1ftE/KX2uNF0FkYl2fMqJoTV?=
 =?us-ascii?Q?24uTy6GH2BEp/CbBk7wCpTqhW2+2whjn1ZlfuXBuyoSxsfD32Mk7z1Oj24V5?=
 =?us-ascii?Q?Y7FWOm/bV8IyU3qQ95zaj4ed6GomPFF9fEy+KD2pKiZu/MDXMuP+4TzJe/wO?=
 =?us-ascii?Q?nd/h2oTbnIldUBIUuEswS25ji9tXt8+oLaeeOQJ9JJpeXjMzCT3EMc70dwzG?=
 =?us-ascii?Q?xSfqfwq9oUnBPdPxe2gxfVwAYnCLdymjkks2/Ph6BTLjJK9wuA2sy3Ixn5f2?=
 =?us-ascii?Q?iGIp99sUe/2PZ5C9t/GHjh07xSHxA7EujDDnzqkjRWmZNLmQYb9qL6wUPg3Q?=
 =?us-ascii?Q?nv4XcuGFn8r7GM0j35QQ9L+2TIvnukMewC/mQJiPmLeMDm/QMC+CdWAx+wzl?=
 =?us-ascii?Q?PhIGeY0+g9sRwY+d71L6/HSp6RcqMOTEYRVlaH1kIWLWUWYOjJy+VPxxVG0T?=
 =?us-ascii?Q?+6ZmYi5BZvk1jwGzmTvDtjirTCwopri3eaivpxYyUTSwQCBKfhCz+mwbCTi6?=
 =?us-ascii?Q?xK2ezeLSQkRNSnz52EKaY6tFxHQKGZWNWjCc1RM+FJhCmbGhOepVOqV3Lgjx?=
 =?us-ascii?Q?xrel0OQWZZ5o6miOKXFxQ9fAPjaGsvy8MU9bbxh86Ap0n8kOIMV+wVvVGBma?=
 =?us-ascii?Q?J9LLEHZcVMCFrCuy61GpG70=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa59e3-70ab-42c4-d806-08dde00349bc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:48.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6+N4RizY3wMut73MQHusMESgKlhQuLhcnvdbJYecjEXXbUuTaVt4qHAYEsPw2g2A6xm1epQL3kSg1d6OmgkaNdy0XNrx0VEfqqCquji304ae9umVNwacW/PHROtheM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19828

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
index 0aebdcaffaba..f856053cb841 100644
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


