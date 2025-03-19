Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC7C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.web11.4367.1742379420457296674
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:17:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Jv/PhGpm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ5MCzWujJQrV04Qssc00y0zigIGY0tjBXRgkiQVDeGoF+QuaraRU6LrdG6EQ0N/qoHjt5SiEnxcCjOwdUTx2OzGmZEXAAVsGMGgNHuBavCF0aODDqMNaOv5zr3cZ5VBvzeuwWyDx8yQEV0Rf+Wkjr90kBwEfPj/Qa8en6394n/BRZU3d6m1KmtRg6geMTtUp9CI8doHfWVdXersQ1PHybnZhKnWvKEddb+tOdVm48uR6/nnrb3GsYVGDxwKOG7wCoaOOWBHgIeffGDJAYEN+dsWTgLx3UPtWEPHSAoUGFCUyRunADSUb6rqox9nNn24LL+HCAumrtuD4iyjVKHa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdONxlAsILrqpfJRrv82XY++OO6bOlB99oZHTdbar2s=;
 b=xb/Zy0e3ZKAYBLQIzm4eyEsTQChBNCeH+csGcuAJ4q0Gph6fye/CFJERF9/1bFFeC6Q6xJfuhe4QAAJAaPMC4WyiI3QX8T6guiMEzFn1CUnmSkFkWIZydYRRp73IFxgws1kN++P2Vvn0jYycGyvf8u/ZRNfU59xBgrkAE+p4vWDWFnoJjH1plaBQG6YItM4tN++nr/AijNx6BJBHv3Ftb/sNFScCRZ0pe4OLOczAqcZXMvXcHiExC+gN9Wj9+HuR5v+uIOEm5dbkRyFbspn95GSjf1P0uGifEce6+B8B83x//pPywfzvbIGX3K6AyQKy02bDS2NS44HVuNEHXxHxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdONxlAsILrqpfJRrv82XY++OO6bOlB99oZHTdbar2s=;
 b=Jv/PhGpmUXdFvEHcH2DlM6O75QW0Ck32ITQkTZh+mJ/eJZHEqfLQtcyXwXYMw3e/vaEnImA+NmkOmqs4hNPxbm9EHhZBJ6AEH1c3ZybZquzI9CWskzl2N+VQNUdyBicFiDmh1al4CJhuCoHFJOK5GwNSDl71QjXgoqlj3FhOFUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:17:00 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:17:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 05/12] dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
Date: Wed, 19 Mar 2025 11:16:22 +0100
Message-ID: <20250319101629.2407727-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e36a899-3cad-406b-c069-08dd66cf2f7a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fsCr1p4he+EOPucUWS/0/ev73gA+Y6/U8epTwyBHRY3JTFdmNPcF3OLEQ4hx?=
 =?us-ascii?Q?1YvcNdc6TZUcFZzMGB/mApVrzD01gLxR4phd7pAPxlm47E0puTHs19vLPJVZ?=
 =?us-ascii?Q?gUyBad5wQwtfEhDna60EhDLR1YMtHujukRt8letNeepS0jZYErJ+c6aaYxIv?=
 =?us-ascii?Q?Us4H5KkZIXXSCddJQOgcQjCy41TkVT82H3HNTYiIswfVV5fxoRm4Cmhp/HrD?=
 =?us-ascii?Q?EcK8OPJhcqmrl4IRNXfz8uon3ixWute+Arz5wEkC1lpijnVk6+6aO/zVIG9c?=
 =?us-ascii?Q?uwmitWPGC3/8ldmZH+kFollhLc6qjBZf43YaNoCdM8H1aGAuIgsL8QK5wWsW?=
 =?us-ascii?Q?x0gap/SGEfS7BsFas5UNMsRd75akmLFYsy6Q3Jy7WVndPW224AUo0FT4Alh/?=
 =?us-ascii?Q?RVzCN7IdhfmpgB+wB/K5IPKIZ4OMXOM/8bf+NemhN5VTcf8pyxwYlotoljkL?=
 =?us-ascii?Q?0T2RjGSYkzAuprSRK0Z269WxpQhqA1xyelTHf+uhGxVCw53GEd/TuwU6LGLB?=
 =?us-ascii?Q?h7RzM3HAfZ07JGC38s2n5dJ5yWSGvluLmOhHtDL1HoVVo6jWmIXVG85PBIQG?=
 =?us-ascii?Q?bqoIg9bRzDZfYv7MIXTVs4qK0vfkM1y12o1p7H8Esl4giWCAkbP0wnmlxlCp?=
 =?us-ascii?Q?nSGNKtVT/awZ3sRWeBeUjqzNXKjIMB+8/kotqkj9hSVIqnxX1GLjXMWolvbR?=
 =?us-ascii?Q?/0HNcgiD70XlgDF1reMpxUIoMIQcG+PTzA6ovQymk3gjuedlbPeAFGrw1HfF?=
 =?us-ascii?Q?AoMmhQXDqIbtpPZmWQ9pbLVvG1ccUwPW/ROEJpKTZNrWRkQVfLTRSWe8N+JI?=
 =?us-ascii?Q?5aUw3I2LVPwyWUqbOwu7eyMYcUyQ2lrZeT5aRZymMmJUEgokxcuzLyB99HfV?=
 =?us-ascii?Q?Gy/ePY1dikLrKudPbH3m6APeSOEu8kVScZo7XUxhXGIgJEZ2jqpp8U2l7tn0?=
 =?us-ascii?Q?YbxrNQR/Fo9odFV567XY4VApQHwiWZk6s4bYqUW0mLE/xKhyEoeR13ObpWAq?=
 =?us-ascii?Q?qNDqUaC5GlayyzqYEM1w8/KX4yJB+a0+E2332F7gjmTjAjl+26uiAtKmJntP?=
 =?us-ascii?Q?RMMVhCven4UF/2tr07O0dBSmN1Xq3ZvckcCLyW0REsmwIHpMbIB0hDnk2Njj?=
 =?us-ascii?Q?XnGZrs85tfbrkbobGMXEKgBCE+OWgDJVKUjvyBC3Ya2J83Y+Px6Pwp6J4VTQ?=
 =?us-ascii?Q?jyNWbTaR1wBRa+Og4qF7L0DV9Ko+4mltVOXIPgREVE2q2y9S09+2WcM0ccFk?=
 =?us-ascii?Q?zFYg++NI+TxxXFJmoZtYDbR1UDX2+pYMHQiD0/1XdWQBYGu6n9LFChZLsvMR?=
 =?us-ascii?Q?Zs0DyGnL4Y9ZpERSpK7hS+3lTcYiTBdZtT2Jn1B9l6bnDthkM65jm1evgD2w?=
 =?us-ascii?Q?UL6ZfFf7SId+szfKrVRnWUSS2gIIdpktQBu63yav480Zz5/1V3J3bXbEPNYk?=
 =?us-ascii?Q?SNdvF0Sp1KJyhiAHs2ifvTuNry+WhUA6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gqa0bv1Ec1i/0nYW4ymG+ONDhK+u3mLU231f0H3PeWgmsUf4vP8IZybF6LOW?=
 =?us-ascii?Q?KWET+ZEAGKUzoGZzAh8Agk9cSPDYMtSJJE+A98+3/nU9jXgF0uN+qr2wpGQm?=
 =?us-ascii?Q?2/XSU1cU77Pu+ZieFihQtNYJI0spHzj+eodUgPfiRq/Af/aXaVZpMjijlTD8?=
 =?us-ascii?Q?5LqP5dEPL0S/hAnWIukApnA3XINStGdqgkq9OP6bCXnR2Pg2Dtfyp3dgrpbr?=
 =?us-ascii?Q?FyKBAEw2dU+O78Y5P+HOtdRNhg+qSo7bWdEp0RioIjKHGsjfkbwHK9LChb++?=
 =?us-ascii?Q?Jeb3erRLwwHAZrMzUDx32reipQVB1Ay6XFBoZe9cDkccSvXMJpprt0T3gyNm?=
 =?us-ascii?Q?n9rDcfmyeAwGcgPT6jUueAPRl5xxxmhUtH6ckb896VTSnHJVAzJGvgQg/6Wg?=
 =?us-ascii?Q?KJ52A05vFZndWk7dEK1og8FtdTIaZu0LqLV6ObCEgpcUoRMcF++3hsumXnkQ?=
 =?us-ascii?Q?n2pD6TKj10p4hl0HNJt79ViBrKjMYJJ4zUwDiZJFed7Jd4/g7FOYfZtO2nz8?=
 =?us-ascii?Q?aSXsJBcZSO7e5WJS0pT48pqMORHf5oHsKBH8jmzag3Gux4Oqme2fX5fjbn6L?=
 =?us-ascii?Q?/ZF5pkuDBZu8JRi4BE90tf5mC/4qfdH/Of/zbhQL8K+RL5laIYlUAWwyzaj5?=
 =?us-ascii?Q?eww64WLkewThTgw5k2BOXzv6lS0Y2fs7sLMhTBnR9MrPVF4tji1W2+gogYKQ?=
 =?us-ascii?Q?sC1cAkvb2IShAkjDyfB3qx1f+h/oCHH6wGjLlyOIKavQGzE6Ro7+9cvWCvfP?=
 =?us-ascii?Q?Rp+I3pVvlIIY5bG2BoVttpOq26aNEpAwiLvhHcf3hHRgSDeD8orL4Q0q5hEs?=
 =?us-ascii?Q?eyGf0GFFkJEBppPWnzbO+OJ9FDUR555vD5KIPRGFerEpeKVYXWRS9xf6IEqo?=
 =?us-ascii?Q?2Neh5R1c+5KIY+QhSr1lYWq6sXs+oX5+pCCdBbVAGsyI+uPBPHxfcWb9VGN3?=
 =?us-ascii?Q?qOT50EUH49m8HkjJWm0W4Mfx942Io9b+3MJUhvzNxyxnCyyW3iAlQjce3ERg?=
 =?us-ascii?Q?Akp5kLSYTOgV2oPiqAl7YZcGswcWtRW7dMzxAlWz6T0kUPSdz4gfas2rRUHL?=
 =?us-ascii?Q?RD2oUXC0ZoDeVHmx28oQ91Vl+DrrP+bFhrQNCFQ4VjAuMUgcc2iLIa71hcbQ?=
 =?us-ascii?Q?fkmYcSQ2nJDkmAHYbcSsQY1Gjj8PM9RoNB/00Q7xM0Ocu8AVIpE9R7cbG/pj?=
 =?us-ascii?Q?YrNJyZ6Bq1Fe4gED2Z5CmoLTY0tSQE3TkyAMsWrbLLKz5HX2Pd/6mj95air7?=
 =?us-ascii?Q?zCK1MfxSMzhtBZCFwV5Hpro+Wkfzy644pDukCcuSiXWGgRTHHliHaGVinyJz?=
 =?us-ascii?Q?zggEoEbRAnOsOyENDhmHHlwZB38AvojAoi5u5D8+193W/z5siX8+bqP1D3VT?=
 =?us-ascii?Q?DD+1KpQKDfrjZhrzDddGjbNE3l/cRF3xb/G7AC1vLQlpnhuqVeFJYHdpNJ47?=
 =?us-ascii?Q?AxRFtaiojxCesH83cjXSpgUk85/JfsbS2uC6xlijFikUjJ0dpUmbaLpiKpKF?=
 =?us-ascii?Q?R/SxNfRu3gl2a1T2TDOxzlghsEhjjwCh8+9MBiLg69r2KPPwekM1iBTp2/CY?=
 =?us-ascii?Q?2hGiZvWtuqGGILHahrxy6U1SWnenGjb0nTLU/mETsPkGxib4tRGqCyxS5fwb?=
 =?us-ascii?Q?iUsMVExZ77v1zffqaKQymgw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e36a899-3cad-406b-c069-08dd66cf2f7a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:17:00.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Doq059xXaARm4V9BHURmub+/fGaDYX2DGQWyMqZZ6v36wEfkCzav38kpEOkdb+l0v/q+AFWlnhEGXm0laJdSSPbQIM1NRjRKYrELAQ4HBy2YGuceIr0UPW588YypPPB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18266

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d828c6726fe5642d1c71e9edbc4799c959b471cf upstream.

Document scif bindings for the Renesas RZ/G3E (a.k.a r9a09g047) SoC.
SCIF interface in Renesas RZ/G3E is similar to the one available in
RZ/V2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20241122124558.149827-2-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 7b997adec92f..8fb7fcc99720 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -80,6 +80,11 @@ properties:
=20
       - const: renesas,scif-r9a09g057       # RZ/V2H(P)
=20
+      - items:
+          - enum:
+              - renesas,scif-r9a09g047      # RZ/G3E
+          - const: renesas,scif-r9a09g057   # RZ/V2H fallback
+
   reg:
     maxItems: 1
=20
--=20
2.43.0


