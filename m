Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00401C3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:42 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web11.67706.1742914600947369189
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bqIeiHnB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBmWj0vl3BiE9F2ZwQSaP/1tS1XFJivTUmU3mRlRZHo0pNQfObREhfD1pR396je29cbCE0GcpTgeTk6efM/neqMdlshXZYwATPGyBTvIpazbJRtt1h04gSV8fCB5JB6M2NFicsq5nxDbkdMmtzo6iBg6MXYQ/7ZC+o7FP9LEEyr+RzuLp5Ay6nsVGdYat8GPOfUaQpEFQdce2w+tAlo1iZjqC219RS/ePdgVCwuCk2M7swFxd9uvadjG1LLvIJQb41H9Yqc145xHzYeCsmBz8IIzspft3nh4QU127gcqT4SC1q0dJIMRHJWSqv2XAaNcAEkdoyJ2c4vK+u6Gg7zEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTX1FVhv25DmH8fOlPn3O4Lq0XsTskSwTxtxHp67sbs=;
 b=Ht6BMb5K6tPFP242qiVmrWPOzAhv1kVYCvGk4Dmu5VsqyjgPPp7kgQg3NOU2nK3R27cnzOQUsh77/ZodM5tzIbyKrW6hm1BGpDMtSXBI/l/Mjt7kIeqerxG9nLWCZnnHHgaKJp7z6/UX6bN2N5k4e11LwxDYtGfk5jgymmKky9Tx6xEl2s0KwnBJ2ofpeanFt+6ysgS+Gf+E3aHMRbi3IGH+tm8Ynk0zCLIHw1rtwW+Cpt+z69zimH1PRpZGusKmW/ZfqkQZPouvDqUU2kZ5jxZIdsoQbU9ibjgqei1Z+jr5k6X2NX6eG8RBi5dZgztF+gcg8soaYaJ249pZu+uMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTX1FVhv25DmH8fOlPn3O4Lq0XsTskSwTxtxHp67sbs=;
 b=bqIeiHnBHpFNIFHYFVT24hQcihnVzOc1u6TwpmWTkoZzg6JpEi/rofkIrIlGXPXtWWylJetVdMcYnIlmYvGAHMN65hgXFuKc8ZtlRWDPu/uwDaQgLLn9pTHnDOoRv6dtX/VD4LSxaKgTT/s7Pg1qshgt7xWRgG1L2R8Xw5bQlO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:36 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/16] dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
Date: Tue, 25 Mar 2025 15:55:55 +0100
Message-ID: <20250325145611.3595454-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc0a041-31e0-4fae-ac44-08dd6bad3d3e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p9P3/iJngzS0mPNK1QZmbW4341RGCs7bdEJnerGBZBBLn7vPSjT/u4TdeBi3?=
 =?us-ascii?Q?UZxFWoMup13BKKEG+v3iFpm5KgQCfRcnEqO18zGdyDh30lavIcvwyj/Z5PPS?=
 =?us-ascii?Q?qUI7Z9DfUhY69o10aE0gwodV7V8u9yfRcuUpprSrY0C0lAndSVoRv/Rz+iPk?=
 =?us-ascii?Q?9rN8jIhUeDuDCjBmycn4zBHJSNvi2n6sdh+1D58E3IF4DihsAjTONJoDaDOo?=
 =?us-ascii?Q?Id1DMjFMBF9KID/KLGSg18TRuxEmh4doAtBJZ7TS40p+xyD55qHiSmho1706?=
 =?us-ascii?Q?tUrXZY8hiqRXNcGTDmYOTJRfF08tRZl5Zq1lb+0lSqNAM63MI4DAr2X3fqFu?=
 =?us-ascii?Q?pPM+T9bK4mDTyjYaOleQ7S8vVOXCTEtggXAJKjyxYQNPHE6NG8pymjgFKDb6?=
 =?us-ascii?Q?JjXYtZyT1qqLY0zPXSx0ksSw2Np+i9afgPXLLDPf8zzhVzmol48b49mi6gXS?=
 =?us-ascii?Q?EW4fTBb3zxVwSqQuTaAhMrO49Y2nekaOCdvWmkTlQdcEHWrONMRmJ349akdp?=
 =?us-ascii?Q?O/42WhOltnidnjqzNA2PMkk6hpUSbW8nyjnH23z3gFPu4og8XAxdS1y62q4U?=
 =?us-ascii?Q?/ZXW6Bqm7gF17KDtN+vrnjArxWnx1Witr4rVqJlHGWSsNusuNZDDON4UTDUg?=
 =?us-ascii?Q?xavcTakhfO27vzcS5QcdvEsTXmWn9Tg6/NQbT16Xmjw6OJQTb8mnYK5Oi1+7?=
 =?us-ascii?Q?/XdQfmLgAxu7CDg2SoXm5JLg8ZMF5UfGdJJh56APogi7vu8n5U2G0bBxvV0x?=
 =?us-ascii?Q?Z1B2wlrOz6Z/l/lEF25ljjh7yFp3i7bnOLZufGaoHrD/7QAbYzKuhKo8wVR0?=
 =?us-ascii?Q?JedSknDri34VlwsxWVcxSKjRlCdkgoxtfdYxLVd4F464nK5uprMtBDjcao4U?=
 =?us-ascii?Q?otLvO/Xenhba22/4WE4C67CfHkG3busApMrSBe8p0y7lq6huoXtQtWYN42QH?=
 =?us-ascii?Q?vlltnJ6fVGFesp9DfPwBgcetoMpQTs6UlMtu2+ppciapWyl075FrKwQXbFzo?=
 =?us-ascii?Q?ga7q9h3JmY4v7aOzoJqilR9/8sLCxRR0FfJLJjlYaFBIPWORJ4R4+XNDhFBU?=
 =?us-ascii?Q?4cl0aTemxrZgT/+uo49GTC96aLTnR3vgDh/OZ+6JiHblTF4SPlCLshC7I4YC?=
 =?us-ascii?Q?c+n0WH/XuWIdUy/BfG5uGgEtk8NLf/ibcreM5iGqZ7WyEem2hxji3xw82L8e?=
 =?us-ascii?Q?NiQi/matT6sA6AyQVCk+M1+L1uoEry2DUDsSsWtjtLYlxuLUwgytqZTnm8dJ?=
 =?us-ascii?Q?jwgweBdhbc3AN7sy2SRMarR2H+o4CpDOhu7k87akjaGAypsfH1phPsV7ctNH?=
 =?us-ascii?Q?MH8yo7qP4aR4ZAemp6aqj0vtXd+bCkarKugs1bMlEusSJ6shK65DU/h9/zXM?=
 =?us-ascii?Q?g0sX3KYnnPfm10zWmnw2wq9LtmcNhxjLDNQ8nl5SW+nyMiZIej4vtX0Gh/+W?=
 =?us-ascii?Q?4ac5eSgCG1AiMM29Uxv4uMsOvqLTF+2o?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IKvoMBpciAz1Ju+SZbTS/iPr9xHO3vI+8C8Ci1BRfnKEvBl9fW8K8ckUU4D8?=
 =?us-ascii?Q?XXBQdWtFO1UHwQEhkYblFHEZpeDutiHylprlsu0E+/JYuwdbOBEqSpdKEW4F?=
 =?us-ascii?Q?Sf1mAorRU7BnIU0x7pjfqEMIdnWHR8xfQLHuhjAl5tMgS2FRA+PVgocnFYsv?=
 =?us-ascii?Q?AFJg8joL+HVRVnwgZDdFY7A+3UuXvSTgGllBVQ3LqA/DDd852RcQz4YLxTJj?=
 =?us-ascii?Q?/+oH6C9KL7tEtwyDeU32/GQzdcoztytCrMR2JxWbYfOa25oS/gOccLXLCCnv?=
 =?us-ascii?Q?jYfvSuB2P9bkq3axuWA5A+hukvjhYgR4mh5dbGOY3Dfz+UUOxkkKjGF+LkDO?=
 =?us-ascii?Q?RMtwJxEv8oVR0igdD58LD9AmB/bd+zGftMrMpTjL4AmTWW9VpwNhsgyUX6dM?=
 =?us-ascii?Q?YOWSLC/MdkxAY+kkZpXfcMg7VDQ3XT1eYYYq8oTz92t0jbe74SoQUg2rM3y+?=
 =?us-ascii?Q?grGWjLEfq3QRloMERUymKfWSphC0+jeTpqpOnug7Beev67hwViH73hEuXqm8?=
 =?us-ascii?Q?0TNxWryww45zbjqv3W3ILcGwX+FQf39St9He35m6ho5QtkBc7ch6TD4kdehQ?=
 =?us-ascii?Q?RLutV4X1iGQyQ6TCTk+gTO0dFTj0KGrAcwAwHIqcSicx+7Fi/Eg0P/BzGZlH?=
 =?us-ascii?Q?amn4h3QXQlqEo3TZ6jIIo0O+/QKIEtzrLvgTF2uwJFVooLIwNbVRhYrGrRS1?=
 =?us-ascii?Q?ybXSYIZXTY6v6XWw2cSbhCFsOzrjO7c8wvWimNLIHB5E8psQv9uF4XDbdeyc?=
 =?us-ascii?Q?K4Ji/40VRvRn6sUBL2uxBDWmKMKrSFnWgLk6qdcktdnobc1abrNnW86pXyrX?=
 =?us-ascii?Q?t5a9w6Ltl0lb66oo3beZlKXqxXnDc8ILGLq3kXxi5o1HLRn5bb7mWQ8Ejktr?=
 =?us-ascii?Q?1665P4TnxWaBApiYb3K7xf4QeHRcJxo7ph2zVRKv7P1Cc7M+8BvsLLkaO7O0?=
 =?us-ascii?Q?g9pyf+RdzCVrQ9b1Txgk6PYehdKjfyELdtDSe6raDEmvzvLCgLF1J2UQ0Ozh?=
 =?us-ascii?Q?Z9O8nkBaqaEfi7KxOcLYYzS+VmbuvEvP11zgGnlqpmJWbkfWC9MT+p5ycylS?=
 =?us-ascii?Q?YksVobW+SfaTLW/h/8XKW0/VGP5lRF6qh0JoLHXxzzQruK2+CW9KLC4XpNrq?=
 =?us-ascii?Q?4+OZOWY9wXAAaDQIPKNoqPLq2JGvXR27wVqJQwQ4mmTh6IqPi0NgXNAPMt79?=
 =?us-ascii?Q?bhNfJ3D6nDKwlYTkmb9S4n9bFH5Cy/RHRO9UB+45boolwFSjx5PUUd4zYfGE?=
 =?us-ascii?Q?apEUAdENENmo5E4mQVHayC1jSjZ9EGB9kP5gqMtFUKqr4+zLpmq3Ez8aFBLa?=
 =?us-ascii?Q?3vhYT0t91GsevGn0lPyIbrThrZCaIVK2BjAf5gyStCLBTt8pkqy8Dv1YPDeO?=
 =?us-ascii?Q?hHhRLImuuFZwHt7BlRKo1n8ZMlL5zlc21PQEVgrHvPHN0fFsOzv5aEBznufW?=
 =?us-ascii?Q?EB99mFxasX93DqpGLQJFp0eWsdLmdtakjbjW9dPZAGH46LbeiEhWLgOYtKh6?=
 =?us-ascii?Q?VXdoAoChcKVLbU4I4W9B0F1gA3x7pe2j/TWWCi7ejkhCAwKa+rZPYm2YOGNs?=
 =?us-ascii?Q?fem3Y/hC4RcJsd3AiubZSUUUXsG4JCnQLEHsnocK549xaoZMCiX7vyVjg2H1?=
 =?us-ascii?Q?1l9f7b9tyjo8c16uV6So5Hc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc0a041-31e0-4fae-ac44-08dd6bad3d3e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:36.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQbTHUNS39IoHDtUCpB7hSsQ3NZN3U+wCvghkK5iokrd4lt+AXW2plsHKjsHra+5+RXczQNXY1LQug27qXRYiakytjst13PSIJw42z8wqpRdMieiS/9Q4rXFcmwaQ4uF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:56:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18350

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ceaa1428e197d9d273ceaf60b8a7bbb3a60565b3 upstream.

Document Renesas RZ/G3E (R9A09G047) SoC variants.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/D=
ocumentation/devicetree/bindings/soc/renesas/renesas.yaml
index b7acb65bdecd2..984718402d662 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -535,6 +535,19 @@ properties:
               - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 su=
pport
           - const: renesas,r9a09g057
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


