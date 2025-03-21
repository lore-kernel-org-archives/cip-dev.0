Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE221C36008
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.web10.18676.1742554849009449281
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=we+1F3Gy;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaYte4nmrUU0BwDVPNSdX99fxpAakctpyvdDN3SZbCjeH+5wJaqkT0bvbKT+FPebhW9ZkK4RmkkCol6+QxiYQcOgCgQPFsIf8QByoQIE+v4elSVZKPpht8DosQIr3EvfUf+kTQz/vdl8pyKcqKMtLNig9WbWi7o6Ex+0qlBVCVuHBGLCnMz89bWNAixRpsivywMsRVjAsT0462t4U4TVkbTv8bSI7t3i5aKDIpaZkUjXjCX8JGhJeI+EI1P40KMjjrtQICpy2cQqCHD40VeJj07V5Jf3UeZ/MPHdJTx7oasQ1LqdXmdKYemOPgVXyhR1GvKWz6ollIpStzYd8mrA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odDyNab1zAY9plImPUmUS5UOHg39Oo2/+invodfbTuI=;
 b=Y/4kWYfAUSPpPfy2+h+feB2K9qOhaLZ4TtSNcfYzA/lHBS3iHe4ckrcsZt+lhRUtgHDxdiu6VvtneXVZBmen1ySAWLhf2U3LytInLR2EDeGu3bW36XbgO/VKYVoNuKSAlzIeoR+j2emQOFQhjg/2YzRKNRoyL/Gjif3mZjL3YGc6fTAo58PFf5XUz1LVJLPpMuEe/1w2h4HBX007ldw4N/FQmhmS7oauXVM7p5tjdkIShj7fbBARSZIV6S3OcfW2dy+L9FwEwT9k1dMXaKIP3XYsK20EObko2X04cbHSi+r/VGNOwpx4g6cJuwNCGjWyXXLw3MG072D1aGJhVoycGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odDyNab1zAY9plImPUmUS5UOHg39Oo2/+invodfbTuI=;
 b=we+1F3GyYzHVghlhjbPdlvhIhxUvqRowI9x0hbAcTcsMangNJ8UIL2AVol11o2E0hkKNXNsV1ByEF8fZGlXhGpJ69mH/Ad7ju08tEmMEZv1tBOJ8w3Bp2tKpsl7EblI7NLgthLVaGO6FBdNoBkFMjV9I/n6v5RNBcYiXfo81sdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/21] dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
Date: Fri, 21 Mar 2025 12:00:01 +0100
Message-ID: <20250321110021.3612805-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da63724-663a-445e-48ae-08dd6867a0ec
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xGG/yV3huYl5FsWNCw/DuSAIPBdySvE38DqsUAY8TKvVPvOGivmbJTbEaRNh?=
 =?us-ascii?Q?bzLb8BTsAspOe3na4Rb1t5if1Qz2mi+JVjx+CkLpFH6N8biDPAsamQyC9mS2?=
 =?us-ascii?Q?5IH2/O+TkZs9HeounjjE6Fy9FjhlTRiKgcWLLmitUUrIJOiH/YThM8EsVseA?=
 =?us-ascii?Q?quJopz94vXvg4yHVT6qDZ2jQluj8vWQp7tfpy2fxl6QDbIbBTWsyYrvnoKE1?=
 =?us-ascii?Q?9J/s9tlGgUj2yo5Qxqs52gb102pPLNiJ0AUUHL4/2h0dXZEvj4ahjzllAlNg?=
 =?us-ascii?Q?L89uuyf8RIZoNxbl6agZQEGQFjAZmO170p8ydaWo2CjTl7KVCPEhor1BUG7N?=
 =?us-ascii?Q?YE+Jyk8hBR+RjpCH+/T7hYwsomZ+svRIMp4mXcunnnbaj7iPXYaK7IjBgnG3?=
 =?us-ascii?Q?rPzk4xh2wZOkSERR5ckSPNc1ne2H3/yRsSHtJ5e//u62dXdidG5mMdQbTwCF?=
 =?us-ascii?Q?bTLUgTTSLP7FuyLtgFUV/DWCxG/js5n32GtOgDEwT1/HZvxtUtBeoiTfkAIw?=
 =?us-ascii?Q?yKEtB0YgzFhQoq3N0nDZ/U2vLds4e51xe7lb9vssnpvONIfni9iqZJNqYfqG?=
 =?us-ascii?Q?kQY58ot+ifO4iWuC6AkQ9uOUGw6XWElYjNlqnCR+StkbbO/nBiRoZA3Jma+A?=
 =?us-ascii?Q?VaCcQY0ExjYHKGVzjxqDfuZ872EJxC2EsS5SgerRkxF+yl6vg9dWjdOnd4WK?=
 =?us-ascii?Q?fv98wKhesLCJAqvhGQOs1AbdLcTt8p23IYKsrsEXpErMpFErpJ7nUGC8uHdV?=
 =?us-ascii?Q?2IJxFkgxVTmRWoB2qJncbrREE8pQs16W/2ODmIt4kG5jMgQXas3a2g6yGl+Y?=
 =?us-ascii?Q?6TIKGwvQn2K1sHbyq2Y1sTg0iLqAS3ozwADBQA6+rV2jgG2JbwZV1LlNsspQ?=
 =?us-ascii?Q?A32N6lyth678UAfTQUc4n6+A6D15ZJpK0EzRsFrzDlxnY8ERX7xDJImirAMr?=
 =?us-ascii?Q?1bT1kqjpwN1nImk7uyLuHgzreweFCJ+G/CIQcuD9JMKoTdGux6MM4vwKU4ql?=
 =?us-ascii?Q?1SO4E+PUWTBVwGWNPcI6aanfkRE+W4O9b2keCwjXSX7kN1Tb7vPO+Ws3kbzp?=
 =?us-ascii?Q?TCUnj36EWSSodv5y04NYShCQqx3E29yzghHETh6TdIlnONb7h90R3hRBOrA0?=
 =?us-ascii?Q?k1bnD6ybyYEuLT/Athqs3yllOPNAqf+5q+iqrayanieknT6MkW3zkwwqNnBv?=
 =?us-ascii?Q?KtG9/GGK30oo5DmfjMw+Ue4aPdifd9UuZtWs5AujRqd05FYVdasPoyhAebPb?=
 =?us-ascii?Q?+RWUE/CPCdv/yqvk0SsflVHZHEZFcCFRiWNK4E40t9VqU1VNP1nmrmzTEZNd?=
 =?us-ascii?Q?RwWd7T9s3aDHqGBDaASU4p+WBQh+0GymXvCUhmSo4oD1B0KAFTZAwh+oNr55?=
 =?us-ascii?Q?e3Xs42oZpcKBob7Fr7LMf6kE258MqkTgPQwC6tO13V35ow0dj6m0ekDJngJ7?=
 =?us-ascii?Q?pgpYEJjqVVDgpQIgKy34G5d1V2+TVWxv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WroT7OMWXRU5IeMEk9hBLJjgdhf0iVBGb2BNLh3AXeDgPflI7H6tH0bAuQ6S?=
 =?us-ascii?Q?n+OwFv5carkJgHvdQJACwZiyrCIH3WJ3jMD0VDynM13F2uFgn64Sv4pWXgxn?=
 =?us-ascii?Q?Bp04xuZwfBJZlVn5++JViEeOWbJ86qT2Pkhxbqe4hs/ZXKZhhRUJ7qoSux2m?=
 =?us-ascii?Q?t0fY5KZVs/3i5bR5cvi4d9gc/+pIgdeFtPVuzdMFL5ocVMKrN/fSE037di96?=
 =?us-ascii?Q?R63GwE+fplSI4V5L7Pu5hg/XhWRIu9h2zStcBmZZc99aW+o8ZmK65D2x2keO?=
 =?us-ascii?Q?MGWf2fTzu99XKaVg+DLjNhNqRovio1DimCKwfz3ijpfDLXdApJU3Sd/lbpt4?=
 =?us-ascii?Q?8ZvmmOsrCYYVgWa+/rkBb4sJfac3A2jntOsx4zUj2X5LiXrVKyTpeJ04evGJ?=
 =?us-ascii?Q?aj1ZNvnpqPV/sDVtTzg6kNSajLTw1Jknb+XwXr/82HNAgyJFOtMl0iZTsqt8?=
 =?us-ascii?Q?claEeHf+r86gFqc7tLQCAhy2B3ELRc5KYKODX8dvbwlq3+tnLCygXhvm/I4e?=
 =?us-ascii?Q?cMHqbBB1gKO7UiKFlI1kkXSrbhmZqSNzAGOgmXjMvORPvkbhKnXapnl28MK2?=
 =?us-ascii?Q?VY0PQJ8AfPwnRJ5diQn/RDmU5ZS7SEfKssYjW/6NuvBykRLWBaB6iknNibiZ?=
 =?us-ascii?Q?PUyFmgbd6zaRPfUHyXQlk2iSWJ3JW4UVkIM+khFIhLn4/UXoAVH3+jiirkNX?=
 =?us-ascii?Q?uGFy0NpvbaMT8aLGvAY8CSxKX8neLDWkomiP8XPE9CWpWzCO0018Z/wBAi0M?=
 =?us-ascii?Q?mOfSffC4eDkPrGCUtM1Err8E+4IXMJpA/4saCbdZLOdvbJMhedRYfgANF9Oy?=
 =?us-ascii?Q?VhWjWP0/cGj/BA/2TDD8UmPpPgrweUcBjQ5gGaPh7Qlxdt5KdKiBzgoz6GKp?=
 =?us-ascii?Q?2a+z9bKtggt9WKoulrvEw0DrcIztTkd7O53KjfLJJYU12kK4QnyuAzn6q2OI?=
 =?us-ascii?Q?+nZgvq1rCRw90LmtPZEYRuJDgYKyN8ICjdbdOFDjYcLs2346oY2/5MdzdPxd?=
 =?us-ascii?Q?/dz5OVOO4iMUZa/859WAoBcZwv4xXu0hTWwy/trcdLT54z7gW0b7uJSYgiFa?=
 =?us-ascii?Q?g5evaZWQU8obPK2uzXkcFlVhwtg1+7aNFSjTC7CmPnp8HoDBxuYHEy8mAnQD?=
 =?us-ascii?Q?1L//JmtUeIyPy8QjeY3S8Wu3wL+ZEgdBXBgrzXCnVHzPdS6gpCjMgq+PVJFZ?=
 =?us-ascii?Q?lUpVwSte1UAjlbENqlau78TptqQUP2CKNF6nixub9nsGfVBo9jFtwcNej5GM?=
 =?us-ascii?Q?EhPukIVCQwRxYzIk9WZVMQI+MkXyF8cA7TAH+j5DmySHewNxZ4BRrIo4i0LC?=
 =?us-ascii?Q?TxmR7YsXw+SSGtbJZkxiqaszCl1KBv/vGzRyPVDtQG0kfiH2DTqDliHlZdJu?=
 =?us-ascii?Q?101aimOamTlKFXDc7AIWMfYJgpSWQQZjLKB7n5SEr5AmQ5gm8Vk/FIviOvS5?=
 =?us-ascii?Q?FvfJzwHOxt0oZUp8CspGeLzS2vSNI77aQF66LrXf/fuIXySjw3M2mkCKRJTt?=
 =?us-ascii?Q?Er8+VKZhY+ZQH2E64AV1yVKTexf9rWtdq75B3finAgkKmjytlDOzfaw+5qIa?=
 =?us-ascii?Q?r3xTFoAfTPYiM6RaMCxgax8NnR2L/55KA9yiNcU80Inckxxiaclob2PudFxR?=
 =?us-ascii?Q?P6LbACmeT7sZZgZIN6MLCbQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da63724-663a-445e-48ae-08dd6867a0ec
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:44.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO0vhfYYeWQMqg8G2+FgidOYRKJTq5y4FdVe8jBvnWNHfh8/Z94x4restC/+40RWlhlI2UvdNT1li4q0EZ/8ZN3ccvDYCh/4fs2CdxMQyxwmjGNmheI8CR1wfE0yfnsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18308

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


