Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5DC3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:40:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.70])
 by mx.groups.io with SMTP id smtpd.web10.6123.1743752427376949511
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dUch54dC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDLoIZx8o6NJDLT+NPL3P3mNmw1ari8C9ASPPuv7iEKZM2Cnhauv9XyY9g3i6v4CUzjwdLvaXpHkwzTy5oOo0+G+g9ePkaGPXyWjKnn4l9W9MMjltYLiVA1FAbIh9c6v6Fon0Gc/Dd8UmgSSXvvQvN6YpM49NmNMG3nqJBLyWei6whM874LbV3hpqH0IGT9WmkdgJKUW+LHKOZ7o5B7bf6hxIyG8pDNHXIJNBKCsCoXqv85/pxX5/gTTFzGopVKluViVD3+9tD6wCS9BLTckgVF2M41RH2SWTqj79YNOfgqe8mtCPL3lzi4RU/rN0OLLsJ/sw0cpwLoEYXv/TGe6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1tELA4N5gPEs7nQlGw0hDvswb4+ex3pwIqJz615OEQ=;
 b=ql7FIbVUuSWJq1Bpe//m4M99GQYhfH9vImGNgAPyYLyvQyOaYAgKU6Rx9FBz+U/9ECJrZUCF8jsTWWjauI9yp/ihK9vjdIiSMbH2t69QerxiqM8RR2CnnIRNhz4C7iwMu+ydbD2Axb2n2NdJhsp9aSl0GeAzJUO0aJQ7t0jOjW53iGeQwGjOZ/fzyTDfRNC2hA1Lf0a7xKYDAab7Fpe0q45jQjDiZflytT48F6U6kRExH4W5UP3sC+8aD+4wTNiRmHuQg4YVAqMbpkrOpqCOwZyp0bUQw7iyIh4xgGSZ7rsOT/4jY3G9ZKMH/LmKIBpy2GSdX6fYywUInGpz2HVVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1tELA4N5gPEs7nQlGw0hDvswb4+ex3pwIqJz615OEQ=;
 b=dUch54dCtVzUzD/e8BO5hTaRGwilLd7oaBgltUnjdU43I1kq3LGVRwXOVQFOQi4Z+FQ/cRKzFF4owLLZWSWQxnkSpug+V/T8IfyJdbhFaKxdoNouegmdSvThtFxHDV+C9JgF0J2cNBhD8R7yMd8mSQNYNcFCB8jfa+FslGZxmwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB11793.jpnprd01.prod.outlook.com (2603:1096:604:236::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 07:40:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:40:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/3] dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
Date: Fri,  4 Apr 2025 09:39:53 +0200
Message-ID: <20250404073954.173387-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB11793:EE_
X-MS-Office365-Filtering-Correlation-Id: babccc4f-30f5-43f1-31c8-08dd734bf286
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Q8SH4cXkhdc9BwIAW3Y0BcAyVuBN+/G/oilMy4nMI1q+vhZpfbVt/fIkXHnR?=
 =?us-ascii?Q?ff0lCxhHFq9Rj8pvYNeoHDpAEEnLaBE/TsXOe4szGiYZWeHYOQV0th2ElCvp?=
 =?us-ascii?Q?bEzXIwNe+0ew6P4FXoPBvIfrP8i51AiDT5h3PtN2eXIjxKM8XOTn+1oLV1uQ?=
 =?us-ascii?Q?sb2qIrRCHDlQ+m2+4hu4yzz1PBMuUhBy4QkF+gwKtrfNgMs0ll/hRwnE5gE6?=
 =?us-ascii?Q?rSvHHoYS356ex6vUiIxVcO8ssLds+rG68do6FxtMJAZ7iOvOQgRxmE0KAs29?=
 =?us-ascii?Q?ii9astk7h47LgIpW/Vv4V5h0uH0lzfT8FHiuTNg0kTRCXfzDEQEiKbiwQ/9k?=
 =?us-ascii?Q?bqoH5smyJ+czvVOzpvn7vgH2vGGubIQTsjDYXxOZ1dizo2bU8cScEyy+R3+e?=
 =?us-ascii?Q?W1dLD/N7F6l0Ke4XA9XXUL3ZFFpRptXIoImWMhQdueUUZ7UJgAeRXokueD2/?=
 =?us-ascii?Q?IMKFFTvGoXTsTLiCH9TpShkq32I9eqLtyZcLtwIy+0xy3c9gY6LiFVMpV8Uv?=
 =?us-ascii?Q?ui8lIdf1tSKIHQL/ahGec5W8dzXcNV3UW50mjlR4d88m+Q9p2fcNl9T9aHCY?=
 =?us-ascii?Q?bFPjLQO+yAbF5hH0DturC751KZJlcb01D3zQPi+pr3sf7RklEPyw5qykQ7jG?=
 =?us-ascii?Q?5duCTmlSwJJqFQmbiMQZ7gzrx7WjSJTC4/7JI47LeaUolUA+2x86VRy3KeH7?=
 =?us-ascii?Q?jYFdTyLTsVawk/eJsIP3PXuYdTXnqu6RbRA1Xq8UbSo/xp4occOFZSyc/nI/?=
 =?us-ascii?Q?cLxtwTY8I0aT07m9XxTJ31eD0nRu1fcBkQuFiH8c2v8h8yPSkxflTMjKE/pv?=
 =?us-ascii?Q?tv/EY9uPP+WJFILpyV7F4tfGocvJrE2J1voD+h1gyQB0z0WcmSdtsVNDO+Rn?=
 =?us-ascii?Q?c0Jy5V6sYgY0lTd1tDgvoCqu2DO/264slvG7JU7llNpp4ABRRlAHK6Ea9SsR?=
 =?us-ascii?Q?W5y3AamHKigQc5pR2hEau2CPh71XhcQNHYT4tCxUmYKtQqS7spEvDDZ+HLzR?=
 =?us-ascii?Q?NrdfOPeqjRKpreUvG5XMgAX3jpJzPzI6MH9yezP4e1Vk7dEaL9SE/poBc9RD?=
 =?us-ascii?Q?8rGgGSpQcG8vlP5jgCnqHaC++NXy2RM/0+0IRB/GbBSG07PdBVIV84caSjvR?=
 =?us-ascii?Q?qo9y/DYJZVlUqViIeb5FxNjP5h86yQ/UxPXpUdkJ7R+5wUuFuotd+HPwZzWN?=
 =?us-ascii?Q?l9IENUYnjmLgVBl1cuHzg3kjFcKuGpkhy+LVPpRFQsLUu6tPKRcucT/isa0Q?=
 =?us-ascii?Q?iTzgXmHtI5L+IUI7WZcYYaXZVbmsh2q1hzZpkBCHvg3HO7FsS8rsiBLY7Sg5?=
 =?us-ascii?Q?Vm/d/PAKtxnnSozt21O4nLJyHJnsTsgyAqqfo8+IyyrEpPuzzsIZHaz7oRyJ?=
 =?us-ascii?Q?1teApkUYWjvtkT5Vb2YBrAX8eV4wlQNhaCU+7AafScN/FP+8XB7gzP6tI8M/?=
 =?us-ascii?Q?WajwVbgz34dJekHpM78CboJnkgiukWwX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3PFxKtQEelbSqneFzTmp+HdjYtzjxLds5QW29+tuYXNwDnmK+ftc1Qb88vf5?=
 =?us-ascii?Q?12oiU8eNY2rAA+Q4NWPfwceNCCt3JqhJa91HKfS5p1T89Ab7Vx78NEpKagQU?=
 =?us-ascii?Q?fjGa7PHYMgkm+C4/5Yo1nV4KDVhURi3xxLblPELg5AlW7HFWB10OfphT1CV1?=
 =?us-ascii?Q?MrHXaGDQVviMvcaNManLlIhZKrisLGV7H4ZYVJjI/PoqNzCHKWPDJHk/3X8O?=
 =?us-ascii?Q?WdMd2cESV1sjORdGSsJe0CM9vX6sF3+UVU0JgFcaFeCSDv2DY9oI5QruuaKr?=
 =?us-ascii?Q?KTNoftJQ1hDB5tSbcSXhwxFzaBoTrBpFrBWZlMMDGafbkK3XlgNFXDOa+ju9?=
 =?us-ascii?Q?2K3lBRZrrFSb+oh0Jp/kT32838wSnUTxjPebF9Q+xi4EuS3gVqqq2NLErIwM?=
 =?us-ascii?Q?aidJIzLO7ckWuiThOacGVaTMaxXl904XwKn/G28WeiaQW4l7W2BJjC76AefP?=
 =?us-ascii?Q?Fv0Ah4tP9t6C12D+kUq8ZY40ct9GBv4saFU/d8hDJhWxvSTcCxY4ZyR/LdIC?=
 =?us-ascii?Q?yfLgjRIFgex0KjHeNd7Q3oWVgWtTujUqWT3HepDO5C4vSITRK5o88txq7lKQ?=
 =?us-ascii?Q?r088bkeGgLoeLF3RaAEzq0yawvV7pxUhJSPLyVfY2YB09oO8yLvTIT0jF9uT?=
 =?us-ascii?Q?0eXw+rtKyQRciFEQ6RM/1cpoDvUUH53mV/yI/FVyhTJkCZR/tOhkcEzSfAks?=
 =?us-ascii?Q?JRO50yfyIrxR19pdT8uvevHpqR1cu6806tgULT6Wandq+hmVxqEYJ2biNI6W?=
 =?us-ascii?Q?imv52wF9qfpCgbt5eaYZvLlS6la5EoV470+sHIkNgv3keXDbbOrRSvAHODT9?=
 =?us-ascii?Q?z2KfLPOhqHBC1V4dsaTYo5UruUUm+vMy5cxX6tjtm+geT/S0TYkaRzKaTgEQ?=
 =?us-ascii?Q?1/83Dkew2wqTZTXNYUVWSpMaN2rsSSsFsoDJm910QoTfQ8hHyLtZkmKmOXkT?=
 =?us-ascii?Q?gVG7bNH069oq6NRU611phwyabijdZKiVlP6goC5Z8K8ooVIXO0b903R9sBXb?=
 =?us-ascii?Q?JYToUmT7U4zLnLT8YcmnoX7DS4D+pYCWigwJIsy6niKC41KPXgBeiMzsmdS2?=
 =?us-ascii?Q?b2gz4ayrXmObJWZ7dzYHVqOKN+Nykno27Nd6FsElOLZVCorfPDrJWiZ1Bb0A?=
 =?us-ascii?Q?DdqyzR80ndqb3DlgJJdYr3QattPSIpqvX4qjVgG1es2qXXFu/Z74yU/oDxoP?=
 =?us-ascii?Q?SihCfumj0nv/q7l/hJaEmG3uAnEE6KOLcFiG+9pMxN1mxGcAkmURUsUaKnpR?=
 =?us-ascii?Q?g0G2Om4VGphcKRt0ljWf+jXitrX/G2go4Rb6YYoF9xqek4g98+vJwqNNnC8l?=
 =?us-ascii?Q?+ZoV3Hue2Rc35E27gHA3R4hffJXlyF3hEu0q6+GCIf/MXDPW9anUFui15zWE?=
 =?us-ascii?Q?EnjP+uDX4xbocz3DfGIqV8/Aqb2mrginrgSpL7iGJTwefY4g529C1nQUUyec?=
 =?us-ascii?Q?pGiDlSEoE1kUT/yvf0EZRw/xnfCnNS9zlWNYFb9tupBnvJem8xOix2VQ6gL8?=
 =?us-ascii?Q?53QBi4OmLZ0XwhRDju7DT8ESmDhfbQazuA5G5iTOvQuv2Lkz54FDmWDgtvXY?=
 =?us-ascii?Q?3e47P3iX0UxXI9OO1N576BhcqpahGHUc4UcYRfnz1Fv+2FcfUEMpdJlro2g6?=
 =?us-ascii?Q?Qd4HJ0Zno4u4x5o1nVEhEhg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babccc4f-30f5-43f1-31c8-08dd734bf286
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:40:18.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFIIqB6HLH6kD93KaCS665heZ79TZfEY+WhL2wH3eGk0bh0rerzZg+YLAYFhCQx/ln5PGucFBejPW4ZcgX4wYHZqUedujhGrWIr6oOvhJsRRGq+2YREayIQHeyDUkW1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:40:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18476

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 567ef9035f820ecd3e6fcc142003f396848b31f7 upstream.

Document support for the I2C Bus Interface (RIIC) found in the Renesas
RZ/G3E (R9A09G047) SoC. This IP is compatible with Renesas RZ/V2H
(R9A09G057) RIIC IP.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20241216202436.185773-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 505a8ec922668..1b7fed2326423 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -26,7 +26,9 @@ properties:
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
=20
       - items:
-          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - enum:
+              - renesas,riic-r9a08g045   # RZ/G3S
+              - renesas,riic-r9a09g047   # RZ/G3E
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
@@ -89,6 +91,7 @@ if:
           - renesas,riic-r9a07g043
           - renesas,riic-r9a07g044
           - renesas,riic-r9a07g054
+          - renesas,riic-r9a09g057
 then:
   required:
     - resets
--=20
2.43.0


