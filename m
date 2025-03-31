Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97648C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.web11.48856.1743418056594779596
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FmuOoLSS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo0S+yLLu0yQdycd444xgnedkBUxpFncYigrNH9U/jam/EVJfyIQd2xU1LAU7DvD9OVjdiS+VJpivdrYQwYoL6BOp/QnlI7iOVp/3VWi9mNuq+TMZr/ySp/s3jg4H3/JSAsAXK46Dol+yYOcIaaqj+zZV6s0lo0nSInKuPCyo+piSUhTilCvc4YIMtJeXg9x1TGG1bLr373klHobxeLbtZEOemo3pY+h2vj072BSi19vFs9qzIXNE2PXw3vmq92W1GBusFbRk0RE7j2u5WcEKZ1k9SP7USFoLyN7TQvtGMIF39TruJdVxlC/BVS/DaBYRXVMexvwztV1osO8lJLTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WIp7aWVTjzgOwAeJb1quSACcHV5RiJVmzdzQTCJpjI=;
 b=OTJSvIdTXrJedqHVGluYnTwD6A7bzgGRyjjHCQXqPBMwZeeSxbg3ozLY0W0YoXBcm5RDTAQudnMgEPfOt4Bvst3LDYyoM8PxnNd7D1NYHKeJ/k8053pyA237TAAOcnxZybU9bYXnmTzbYg582iAWJeSoSIqN/TFs6+B9jDwhNwos3wABHhtYXR+UsjAWXql7M4y20nm3DKQ4+eO9oI4i8Op76v4nz3CUnp0KRGMP5BsSmk8rE2zjvfuLtvXcxeorD0Ixxt8mBxAp1oMxP5ASGTn2kAILukIzQ2dj+RMG80mW2JkxmBBQPJjs3eF0xMZc5ZtCBciimy18bogycZ5UzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WIp7aWVTjzgOwAeJb1quSACcHV5RiJVmzdzQTCJpjI=;
 b=FmuOoLSS/ImZoCwNkt/sM7t8pdEHgb4Qt4562r/2qVJYSVCo35vuOUCJR3GR/9Dqw7eUnZ67CyD8Wh+7xHIm5v0TGqk4Me8eEBd6sXXiJMdPENapT9vnzSeOzf4hkyvKHVP6JwK2S7wpL/cTz9A8ZMDsZbP5d55XamIwZlFM4Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB13299.jpnprd01.prod.outlook.com (2603:1096:604:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Mon, 31 Mar
 2025 10:47:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 41/43] pinctrl: renesas: rzg2l: Fix PFC_MASK for RZ/V2H and RZ/G3E
Date: Mon, 31 Mar 2025 12:45:12 +0200
Message-ID: <20250331104514.79090-42-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB13299:EE_
X-MS-Office365-Filtering-Correlation-Id: 179182d7-da0d-4f11-b237-08dd704171ee
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zw9o8j7vwPwgZppBE+o3tReAMjRwAGwPMkOla1RHaJU42Iv17QWmd0wVfcMI?=
 =?us-ascii?Q?YOrgeitV6Uo3kPTT333IqJ1pPLsWoVAe+I4/7jHUtuDwYkJ5KWEovTuvFVzL?=
 =?us-ascii?Q?L1szx1pi6voW5VxDofJTR1D7NnefEOtNK65hn0mdfcSDRMCj0XkDKVdrycO3?=
 =?us-ascii?Q?rSl48OLxpx6DtEdTxZsw+lpqIucE3jNJHdoXK4xsvrW0us8vMRqk3p/rZJxE?=
 =?us-ascii?Q?Bn6IkWK4nPynVW8rqqP0gsSQ2bMAmDFt4ivFmTIP1l7dQ5ExsvLJhQSK0QIe?=
 =?us-ascii?Q?3IChzWTVPlBZu58s5fK9+XSCTdTvqzqk5NIO2fUnmHxlRppbFOy3x4PkDwXa?=
 =?us-ascii?Q?cm8JUTezMgdaLydYq0SYMW0aOOVklLUoYJwIoae7ck+MMtue8+uWu8IIQUbF?=
 =?us-ascii?Q?5+MbcLCbvVsrIQe5FsxBMWCg6lzPnTvbUQ6UMgQsBneI5ZHnyMEz34WTvVLW?=
 =?us-ascii?Q?OUTa4gm9wV8B8B3kqxSQRJWp7sPyP/2UCpET7aXRYz16JVkD9nOfGiHdXpxz?=
 =?us-ascii?Q?/ZZwWh1H4XG9wrJr/ctm26b65GXzxCvhU+nqIkBmVR/Nnbm8kSD1+0Wq2hV8?=
 =?us-ascii?Q?N8OEje0vHJsmtPCvvWdHIU3g5FxYJO83VM3oJvl33Y0NSqlXpw/xoAXj/El4?=
 =?us-ascii?Q?0yB/DQ/u8kv0ELeHEOr1v2xNyZ2eD8Vj3gufQXTsXqp3XQ9su0svbgF+QPaP?=
 =?us-ascii?Q?3n+IjXZtxqNuydKOSmYRZtJX+UZbAbasE0ZRK0QbwPESb3nM44EYpylW0ZcH?=
 =?us-ascii?Q?UgvAihgg9Am9My9Y/cnX9eCJ2yHz+j7EQzmDYm/xSLlJxyaDkCod/C7hWPSd?=
 =?us-ascii?Q?8lnOfX7N+19uPlnog6ctsr7keh9VAk9CfGQ3026WgcCWEQFPaQseNiyyjTgm?=
 =?us-ascii?Q?Cpe9l85Zo3/Nms4l4StaAVIhdVNrGNbNjhCrqwFgCN/PZ3fxlpW9pTtG8C6P?=
 =?us-ascii?Q?XPxS394u2H3wUxy5XEFLDUH1GVZmVgi4UAfLq7gLWTUvfBy2LJCbofwzTMJD?=
 =?us-ascii?Q?u+ovKnPHREHTVxX9/O4R2IZK5fjwxcVKX9ujBMtC8PoVvuBV1bOYz2HZp7qU?=
 =?us-ascii?Q?2Z+ptbdccay5ryi0VYyb1sMBlkkx1vkr7HpABbnk2jqFmkPVq4D+fHQ+aYoc?=
 =?us-ascii?Q?u35MNUWn3UdmAmJrASezHKKK+4wYC9qMqwFncmfKwDlPCSLtOg9FQifCyjqD?=
 =?us-ascii?Q?kY9E36UOuyIBNzNzofN3TpYNZ9UIvRmNDYPGJ674c4PdiXWV0+5hzgflBfw6?=
 =?us-ascii?Q?Q07VrJyO3tH8LcIKAwrp+mGjLE4Co7DkGwgiWhIYvp25k/KOioBJohyr4lYF?=
 =?us-ascii?Q?wql+6tNchngfBXf+GvcoQPmI7GtGWfOPVdUyOWawHP+9AK79P4utcs0lCOM5?=
 =?us-ascii?Q?ODo0UosXUx1f6iuR54vs3EVeRY1375WMRsIsM7V3J5V3iFndxF1X92z5iIwH?=
 =?us-ascii?Q?L3IuEhBZ9OAlRG7NUKFC5rbr4YXlDJQA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7tuU/HP57KkTii7nEnmxKUekLsR+YEsPiTnMOidevpOlbDNW++Rv6iGw0ATh?=
 =?us-ascii?Q?QcTJGPqguchn/ViwmDCW14tbGZStWeqHP7B398MuLbGBWtFUJilaI7RLOon1?=
 =?us-ascii?Q?SDuvFWUFswheX6rlmyEdVAzhJzZJZcYv8B1D1oWNAj8CXoA3vY2/FU+dcz5N?=
 =?us-ascii?Q?gxqaMEuOsaRIvkD2irrGS9OO7DzxdTKSI1aRtVIHuXbkIi7TXpKSK2Nx1NLA?=
 =?us-ascii?Q?Hqqm2lz9dT+VeUOLbWLcRpWnGXo+T1fBEsJbdgNeqdm/YBWOQgs2dCsLeNNF?=
 =?us-ascii?Q?j1xL+kA/07d0f2sQyFEQStena4x3hqEdtMQ6VngV5eOfBnKQQ/KHOuyaUpRi?=
 =?us-ascii?Q?h8q8M1bXxy6Mnz9zoYwJRvME3Qlpydvq7C4hqn4GvjQIaqtIzNg9FlNQgHLA?=
 =?us-ascii?Q?hFp9d2d/PJ/AApgp2WY1XxXFCvxBn7+wCuKe4UBOg4kFp1jw3nAB93ia0wE4?=
 =?us-ascii?Q?YOFwuHsv3wps9vijft2sNQMw2idM/C1nYDb1oqUmUd/AUGt4j5iMItBQ90sA?=
 =?us-ascii?Q?wZYNoRPZuuUA6Ve+j4YaltFkwJ0tAAaS4yOQRURqJXWaHc06c+LbnrgkqBS0?=
 =?us-ascii?Q?6Z5OKApnyEWjQh2Ifbh2A4G9JwJKL9uqGQLq50QcCrksgrLo7dFiSun3IGlQ?=
 =?us-ascii?Q?FTkkTh3SfnZcQ2Mup0TFU+DsFmdL+zeL9KeKclQub4hqWwR9TBNYG5Bl/2R9?=
 =?us-ascii?Q?qTJFZ2Pxoh3qNrOABwELBC9lJBmI8pIPQUR2gJ4VozWG6SksxUGdsRYAUGhl?=
 =?us-ascii?Q?kNknz1Sjnpqdqi+yY1ujofprLxOxY5FCrFhSmDJ9zV3V5WwsfPrS/Tpj1ctX?=
 =?us-ascii?Q?eHMGGOHtjRAdqYP5QMza/CwYjAohyEFWYynQqW6FfpXe6zHah579zZG5IZiE?=
 =?us-ascii?Q?GKwhcytt/kPDcrmVpmeGcDkFq6+MWkkroV8iRicdgiMgUvW2ULl1OjhrL6xk?=
 =?us-ascii?Q?EqCVWis8L5iQ4X25YIBfMwyJoSyJ2MfBgAgAIzJ4A4v78cQsaCS6D7EGrSib?=
 =?us-ascii?Q?q55JXFquXmiuwOrcWD0ENrxoL5a/bo3/5pd1gC+esMZqbHXYCFkpSl0Njw78?=
 =?us-ascii?Q?9FYRw+kXXKQ/5NfRZhHj2c6d0kalJvNuJr2vw7allKjF39JeLYybg5JF2lqP?=
 =?us-ascii?Q?8Vkah2D3ZsCsvK2ZsumZ6+05t/jwvrPaYRGasECEIyTbb/ytUTHPQmNzb7bt?=
 =?us-ascii?Q?vF2v6zgjqTOGi6BNQ1giOD8dy4LWdmQINqD3xzOuScqUbb9jTXV9p3lju8HU?=
 =?us-ascii?Q?BY3nqTmiW4J8MfNug5O0n8nljlrluwtN7vtPGfz4IXVWehdgYJKjN8Xnfl3Q?=
 =?us-ascii?Q?CSUl670jJqk+6BmuCAnikmUk5iyy70Nl0IN6Ru+Y8aQl6LMeWz4tEd9EzYsM?=
 =?us-ascii?Q?E09kJe6QZRNCK0h0YF0GvgP+CavOTCPqgqZzSpbGry29bKA5GEfa+dm2Rt+c?=
 =?us-ascii?Q?1ExK+h49NFh1W8fn/4nCOLbv/sFL3y31Ac2ihG0UrMP8dM65NaRJ0VXFUnYv?=
 =?us-ascii?Q?mVixPRKIhKsMxQEPcYaz5ltslkpIVwgbZPqOtMkENt0+6kqIx022Dsr+3Vb7?=
 =?us-ascii?Q?53FsWxyHcuM/wuqFAGidw/Pu7crVaE1QiXwawTe0YPWd1spLezGR4+XgYEZ3?=
 =?us-ascii?Q?ODY1btXEJkrQXrdjkoqjAW8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179182d7-da0d-4f11-b237-08dd704171ee
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:34.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IunoxkcJz0+2hIUP/9LvW706+zQ6c6ebKHu3ddnEtVEQHba/gKHoA8Y1/54AdPaoFM3Gh7hXll90ZdApwNwrAwEelcHXlOrS3C04n3GYnCtxlAoiOIKvJ+6uRd976TG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13299
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18429

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit accabfaae0940f9427c782bfee7340ce4c15151c upstream.

The PFC_MASK value for the PFC_mx registers is currently hardcoded to
0x07, which is correct for SoCs in the RZ/G2L family, but insufficient
for RZ/V2H and RZ/G3E, where the mask value should be 0x0f.  This
discrepancy causes incorrect PFC register configuration on RZ/V2H and
RZ/G3E SoCs.

On RZ/G2L, the PFC_mx bitfields are also 4 bits wide, with bit 4 marked
as reserved.  The reserved bits are documented to read as zero and be
ignored when written.  Updating the PFC_MASK definition from 0x07 to
0x0f ensures compatibility with both SoC families while maintaining
correct behavior on RZ/G2L.

Fixes: 9bd95ac86e70 ("pinctrl: renesas: rzg2l: Add support for RZ/V2H SoC")
Cc: stable@vger.kernel.org
Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250110221045.594596-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 36ef1b558ae34..6e57153286828 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -158,7 +158,7 @@
 #define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable, known only in R=
Z/V2H(P) */
=20
 #define PM_MASK			0x03
-#define PFC_MASK		0x07
+#define PFC_MASK		0x0f
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
--=20
2.43.0


