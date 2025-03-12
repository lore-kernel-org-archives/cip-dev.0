Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC16C28B2F
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.34779.1741778625533897542
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VFjWNxvY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMsKvpLBwE7tVWQ33Ire5KfUer/8bcxVMgTCmPLDzlDgdmZSon8QnGO2B7PDNZ4HelupdQxtb62h9II5/jTf0/eUUrZVAOovUKKW0ppnpYDN6d48x17aFSP9gQYSJBPZdivILNQ8Yd3u+s/BhQOMFIeEdFhAMOeDn+Qhy19lQVB2LE43DFWyRPd7MTYdMGfJfOwZ74SbQ5HvIbhdEzxh6oouYm2y0ughimLdZEZ/ZTHJwPKMc8r8mPE5QXGBGtiQn6k1FC7XF6A7ZAZ38G5MmQs0A1vDQIPZR6uetTypqnyP/iOjsMTH591WVpJUTds+jFdypT2vu1yvsf1oZ75kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgSp/4jLnpXoVlt/qMxCz7Ba+v+JH8HO8ZeFsUpW+lk=;
 b=Fj55SEWNdtR6ln1HIyIr1HsuZsVh3n4RQBPQMb4HISQHfIUCRYKCwWvd/9y4y8kXGDMc8sphyZiTcWqkIo2uk1tnqSZrqgQ0iFCiDQEKEYSkkYAbpQPmrGwpK/g50HmFgQSYCulTU3A04Bo8wX/JO+NIRnYbvaWWt1jXiMVIR87gCRgMcxcjhFtnrJL/u+142LREso1rAIoMtNao0nK+uOl9aVWWhzif2Y3VaN8ai03V93xL5zFuVO2mltritbtOcMeghUjJUPuRkMXaThcLNYRe8vvSrz8mhdoM3kgjMIg3eKdyX99+DKPBCef8hvJc9J4gGf8cuEradWTZqzva4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgSp/4jLnpXoVlt/qMxCz7Ba+v+JH8HO8ZeFsUpW+lk=;
 b=VFjWNxvYN8UHB6xIhD32V7XzaSuZZB277hQ1hJDi85FBmangSkqtOxzOtUfGQWIlaect0NGlKcUcBFhFNRR+zzbGm1Iu/Jp/Y9vDptS6akooke8RWvhh324d+eM/UClNZHJv0FQJZR0I1GSqs66BQSDZrbbqZeA6tsp1ys/Ej70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10581.jpnprd01.prod.outlook.com (2603:1096:400:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:23:40 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/85] dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
Date: Wed, 12 Mar 2025 12:21:38 +0100
Message-ID: <20250312112302.1605750-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10581:EE_
X-MS-Office365-Filtering-Correlation-Id: cf13d0cd-28f6-40fe-6cf8-08dd61585755
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tp8pYd492y07LE74wSZs2Qx63g8MKLj7rNwtMKd+e6i/NGGPS/EMs6n5tf0z?=
 =?us-ascii?Q?w3UfOd59cPZHFdDSXoWKFjUQhvtHsQoOBQmNHqBFTAIgrJY9D5cZDVU0kiGB?=
 =?us-ascii?Q?yAJ6fJakA6tnP5NnZnZDSkLCUwUh2YltWgnqIRRQOVgPEhblLxkmRMXpKJbu?=
 =?us-ascii?Q?SItFOKlsedHzce+hY6Rz266WTqYmgLf7lIUw9x/fh2mPIP9FKaVj/fJWrAki?=
 =?us-ascii?Q?zQ6jU1ViyNYc5bbJyfWR6eCBHnCCDxU9MJttMZtz2EG8hLYvzAElQl6Toss9?=
 =?us-ascii?Q?qYpDrBld9GQ6rKXS9iTMQfChP6AUS8B4NdxK5SQQ/W8n3vmspP1OVN+aP2uL?=
 =?us-ascii?Q?nI/RxKH9h7z+AjDdYY/dLVW1uQW8eVBIrqdEhyik/4p32Gb9dOGcl9dtzcBN?=
 =?us-ascii?Q?3oA25VvBrUDz7WrRG9hOUVOROj6HYTHd4R7mmNPhhN4UHISqgppa0quwvjji?=
 =?us-ascii?Q?3+WTZtMpE23vGUH9Lh7KKec+5LO4K00cHdoSonkgNl2c51v88V0mRT2M+9Kr?=
 =?us-ascii?Q?KP/1jWBfw9hdhgtoi1buZ4oIT8ElIgGHdx5FJamVemx2+RX4IMwlJc2j/OvB?=
 =?us-ascii?Q?s0fe1e0VUqLH75JO1rbFoilc9SO1hNbLWmVddqycOvjhR+qSKseO0jr1VzlE?=
 =?us-ascii?Q?ynkwHPjJboJGxwimpOGxYLtMuIIRAGEwQJBd1wvRD4SIYHxxd7T4SQIewi9A?=
 =?us-ascii?Q?aLgcI95OKhKasICpJqeyZ5nCekDVSR8qqp3Uj9rHagPg6JgRBx0W83jBqCwi?=
 =?us-ascii?Q?hA8tyCBqcHAGSkaYcuZgiNr9d3o807+Q26FSpWFB0MsiOP55gyL/N1K1UwBk?=
 =?us-ascii?Q?5158246Jpwo6NvC4l94sNL4ULXqmMbB0Ajzdnr+uaE/i8/dvOJrgmGSTQZNv?=
 =?us-ascii?Q?j7gJ3GxuI67kd8NXVoH5VPTp+2vUvA1a2L5UWY9PvTkyR6ftOBZMxdBs+56N?=
 =?us-ascii?Q?Xw63zf7S3uh/VGPvVCqE6sGUr1FpSinK0dz/6w1Jl+Ox4vmZsNx5cOo6q1oG?=
 =?us-ascii?Q?aUAmk9c1BMFvf02A/bm2I2wnnsDMkNSdo+tzndHEalQJGfB/Pn+oUhoJbYFW?=
 =?us-ascii?Q?51Wjocy/STxmVn3z5Nw8d7mTOul4mnx8Ij31RqZMlCY2RwBmH5snWWxKKdYM?=
 =?us-ascii?Q?XFJZe6I3YCMgqXDykVRILEDbfM/BPapTI7wO5sHT8NDotSZFBAzeU/rJ3jd3?=
 =?us-ascii?Q?jU3mEPu0Z34ORFbVoHEAETKkJalkjtT6qtZFJt5KFlDhVymXEX2z74fV+YgA?=
 =?us-ascii?Q?ruqiW9mCkHiBtQX8SIINXakrdOdAwp4aEVGlNhVBOGIIzsJR17/pg9tqjvpg?=
 =?us-ascii?Q?C/nAmyCop15Q1dMzvXqeKm5yUidJlC5cWhQb96YY/gOPY98aXBipE7WG22zZ?=
 =?us-ascii?Q?jAAbxrSwKwVvLAcUb4bxaJ+wxPcIg31/gOpTnzVSUqrVRkIrv1FGtiowsC1E?=
 =?us-ascii?Q?6grRy0nMFP564iaAM3qIaNkG1ER1qiMV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z9skDjBE5WxdqOqGuH8BUFUD/O2j4akgASjDp6VwqagKXJRcglh1zud/ymiV?=
 =?us-ascii?Q?mwSB5lBsoObFQ11/6Hnht6FOHV6OjGNZr1jlgyDDBbSUVU13nCLdZc5eVApo?=
 =?us-ascii?Q?Q6a0vJcnnMwpeUk4VMf1CLnQafKlHuKZ8JzKfZReiNvL+EJklRlk0aeymsI2?=
 =?us-ascii?Q?N1nc1C5aeHxNVE/yIp7mcAdNvmr/WJv1NvJ/Ffq8l3vffJhuuQ47V9bqdUmL?=
 =?us-ascii?Q?KCziRITt3wUz1ABRkqPC1kzd80dve5JAG+9Nz63lnCRkwuteSlR5n3J1Eu88?=
 =?us-ascii?Q?YPnLecSD6wvn3RBsDuo4r+RDT62gVFTSZdcojAu8NJQ3EIFbIxinAmMNpM4C?=
 =?us-ascii?Q?lN2N48nUMZsMzbob2lGa49dGaS4LfkxOoxgIHuDt1O/6MOhie0au1qBsESG7?=
 =?us-ascii?Q?CgJ/6GV9D1Uwr9BWcqOWfIxIdb9ix5U228ozWYQShsBoxXTbx/9F68DMWIyV?=
 =?us-ascii?Q?NuDNnYhNCNPV4nHSuJ0YlqmAnpi5DWiB8C3NKQ3dGcti1cVSRw34A9tOrdgf?=
 =?us-ascii?Q?P+8fG5puj+r1Obvo2oe32xGY/NkUxGw6Ozb0f3yT26RUGB5qgINMDlJdKLZc?=
 =?us-ascii?Q?w650fl19ZBen2il6w7PzKdzQaloMRUE9H/BZV5Tl9mUFz15QWrSjbr7Kw+9y?=
 =?us-ascii?Q?NmWubsmt3Dl2d3JthpYKZbkupqyd0c+uUOGKw0JmtswrwBzQs3a8KFbyIEPT?=
 =?us-ascii?Q?RjOLLkmer5ISlAsT42dZqgzqUY9UuQgB5kQxPYerDNl1PCxKP77mslbtQbdP?=
 =?us-ascii?Q?owOsQyax6PHkB8PQixvCXRFib/xhU6p+S9ztKiDV9CxdENAoAToLO7q2lJNs?=
 =?us-ascii?Q?hcScpo80EQx1/Zpm8ogUfGItTpVBd9guTHlEnIGIWv5FjWiH0JfTxN+PfXwm?=
 =?us-ascii?Q?5SoaQrcy1DmJvsQf1t4cFaQkTcVxTiScFUcAsx9zWiTw5sUUVthHwZlZ+56c?=
 =?us-ascii?Q?/eqGfC70k1qy3khrI3SpIDzQk2jVHSx+p4J/r/U30ulLqTBwF4PNrNXKwR1O?=
 =?us-ascii?Q?aRIIlGf4veP/T6Kjg85P8zhZEpM9+I9DilOJ5FWVyoKH+84h1wCk9lnCeRpA?=
 =?us-ascii?Q?trQoZLjYXmJAdyOOIXqrN4Q1JjZsGooiUhpTUquiv6gLuxVabgnAjh4YZJJu?=
 =?us-ascii?Q?jtYEQzGTWPnR9+xnFjlCFpJogs+4+ZYLkrrMhN+khIvpsgZp8e8g2/9cpl1J?=
 =?us-ascii?Q?7ajYzBYiUh5efVuCtVYJGecU4FTMnB1hlNjgGzKm5lEF54sbk5znpL8e4ri/?=
 =?us-ascii?Q?gD4nAZq9usciF2xGQmBK0TZX4LbyaDXdQqKhtCUmhWYQ4POVR/huTlezWjmu?=
 =?us-ascii?Q?aYg6NWODGXznCQJe74/H6HKV4PMNEtLmJi4ulYOp/6v2Wwr+eLs+MgehbRWp?=
 =?us-ascii?Q?PL3zIdLp8lzOV6JgLw98RZGmbrirZosy4eUpd2V+w53dJEa5tIz5vnUqnQXn?=
 =?us-ascii?Q?XjWlGxz2BPE0PfFYojDMMmG6q2NgdZgerMo3B7tRj0miy7ZkOa9xj1gkEXPd?=
 =?us-ascii?Q?NzQZYJqkrolKPCaShlR3frSy2vwmdhPhyi1SY1ocvTWIPhhoRFJN8KUj8Snc?=
 =?us-ascii?Q?Zhn1zYMu9kR2hiB1a9LXm5AQTE1n/2wCXxkCWJNFjn4JKdzlZMYWKBQ0akJz?=
 =?us-ascii?Q?qeATvRW7FIWGn5990LWZpV8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf13d0cd-28f6-40fe-6cf8-08dd61585755
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:40.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZbQJSmzLLhwrGPvEs09r0DwdUqq7cL8Lu42aRGVcM4cFT9vBqA2Grqi6BGZlMyTZ217VsB6MoQ3SkwzJDXnIx/6pheV8Tyx25K9vcn3F+tgFI9aweseZec3TuNLQ5p2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18093

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ceaa1428e197d9d273ceaf60b8a7bbb3a60565b3 upstream.

Document Renesas RZ/G3E (R9A09G047) SoC variants.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documenta=
tion/devicetree/bindings/arm/renesas.yaml
index 4eee12b5d67c..8de30b478d18 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -485,6 +485,19 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
=20
+      - description: RZ/G3E (R9A09G047)
+        items:
+          - enum:
+              - renesas,r9a09g047e27 # Dual Cortex-A55 + Cortex-M33 (15mm =
BGA)
+              - renesas,r9a09g047e28 # Dual Cortex-A55 + Cortex-M33 (21mm =
BGA)
+              - renesas,r9a09g047e37 # Dual Cortex-A55 + Cortex-M33 + Etho=
s-U55 (15mm BGA)
+              - renesas,r9a09g047e38 # Dual Cortex-A55 + Cortex-M33 + Etho=
s-U55 (21mm BGA)
+              - renesas,r9a09g047e47 # Quad Cortex-A55 + Cortex-M33 (15mm =
BGA)
+              - renesas,r9a09g047e48 # Quad Cortex-A55 + Cortex-M33 (21mm =
BGA)
+              - renesas,r9a09g047e57 # Quad Cortex-A55 + Cortex-M33 + Etho=
s-U55 (15mm BGA)
+              - renesas,r9a09g047e58 # Quad Cortex-A55 + Cortex-M33 + Etho=
s-U55 (21mm BGA)
+          - const: renesas,r9a09g047
+
 additionalProperties: true
=20
 ...
--=20
2.43.0


