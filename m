Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8764C35FF6
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web10.34471.1741778750358293288
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qFgnWYwZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4ra7wgZSHRdUz5/dLZgXKtBfxsNZ6Of1ZcqD8VQCxG6pr25yz46ohmfWBk8HiT1mkPbk6S0bRE6PZ6LNSq6zX9sEkQiSk+EWkFb2Ui3SlacWnn8HlernK5cgFFXA7cqyMr6uvHrOz4mTniQF9OHY4t+Od10CMSkKPI8aBmzhhggZfPkriAf2tLongCO7EmaWf9n34q52hMegWk9Gf5G7YeGDwky+qPsM8qj6Aq9F/leX8Kqjm154Iihk1euzo0TGZchW8Nvrkub7hK43REFgvDiqFNHqr3otXKRvog5b+YjgcZ3kvCl46H9KynWnreuH7w/4TgRcXlhElfqFdXR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyDsecBNFPb0BdVWIZtctHnBTqi3/ookZCJ0tkSdAsY=;
 b=SgmtxzRR5huhzn3K8MjXTzZ0ZzgBh54vrdtdPEZ95C3I69TDBtJUX/saGCRJXRFbdv4hdIozrEVSXu2H6FUSf9mqJhMOqCJuHDuIQxWzqXgrzgL1SzvtCFWXcwJxR3lRfA/v1M76e0Mq/oNCa5UQLD3DPmgyFijunotPMXhHZJz0Mc2XSBsFbfucsJIZGBLZHv/VoMmss7HjR6ldOy7f5IpCF8xNPpuP1wDCAzyRjsW8KYvUnXlrydb7kCWmpk7KWCr2bLSAHehBUyCLDUhCtixC9LXkF4WZCUhHC4JgEvj3wyhoaYUBrq1p+Vndplo3JG/UcIC5KAsHNmOPOwNlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyDsecBNFPb0BdVWIZtctHnBTqi3/ookZCJ0tkSdAsY=;
 b=qFgnWYwZ6RSXjGbTiEZY3CVcvCvjnSYY2LqJJgJEtasQVh0fm0i6L2qbvrFfxT+zVouYOcrGEc7FDPJMCQpG2WoZ1Gjym9QQQL/MWXsS1Z1dQCJaYFK/YqSRDsaUMcAdDBX/0Zg79wgNsGvMbiCm3BS9Jt61C84eUMJPQSp4+Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:48 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 45/85] pinctrl: renesas: rzg2l: Reorganize variable configuration macro
Date: Wed, 12 Mar 2025 12:22:22 +0100
Message-ID: <20250312112302.1605750-46-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8563706a-23a2-44f5-0c80-08dd6158a36b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oDnCSJVPa2ggYdjIetVJTReM88z2vFYxkqc/UYOhJ5oi/jcs30OybqVmlj6t?=
 =?us-ascii?Q?jUOsvDgUSMIzRl3ixTekqCoKXGtkl14nIgHs48MVMmEtp161F+eiyMEdUag5?=
 =?us-ascii?Q?C6iWUm2CrfY39lzoAncuU+U7OhZ5mXjkZL2lx87OvrQct1aeV4+hPZoZeb9w?=
 =?us-ascii?Q?XKePsDZAurgeQkbRO/OTkA2LhvKJkgJs5qFpTE08z0US1oXI2n+DYkBdB/p/?=
 =?us-ascii?Q?W+OVlJT0NI0ckcNHs26A2VuUtsoJT66FpgnyuLnjiV0mxjM7ttwC99J4QrIe?=
 =?us-ascii?Q?fXkVXftVf6J0rFGeF3Pg0tZwki7YbaRioYQO2CvBiEnbeB5xmuE43rob2AEX?=
 =?us-ascii?Q?friBFgKpiQy7hCWSdqPCe3gmReRlcrWRN7AZULpmDz5z+p4qqIWVSNjhchfP?=
 =?us-ascii?Q?Qtgn0V2py4S5roxILjzuhomlSSdjvCZUeQQUEGda5wi6hJU4HwTsK9se0sWp?=
 =?us-ascii?Q?5ko4DfeDn8KsG7buhTRXi2+1M4qfNz0btYutlKxwdr1fLexaJx7glnYltV9/?=
 =?us-ascii?Q?I4kGwIJP1KLZhuMmvdQV2QN6GkSYrRaOAmumGZOScEpS6FhwQtZmysh3zS0e?=
 =?us-ascii?Q?48OReKL8cEbVJHkPbXD2gIwyLj2485ZQT+MrTv6XNfjtPUZODzaXM9Bvn9ME?=
 =?us-ascii?Q?JbU58x3NmMBC0TZtFm+WAaHUdOOMqrYBXVFz6faKrTnwO8v1VdFH3/x0igZT?=
 =?us-ascii?Q?ZPqD/U4/R5Ue1gFvk9G76rSXuPgdZIVbcrkl57TJePuYPavvQQwF1R0DXSaV?=
 =?us-ascii?Q?/ZExGNu7K36oyZSBSXrSHf7CvrUBnLu9qaUOtpqS4Fwx/0my2+2TjaeCjlO8?=
 =?us-ascii?Q?spS3aGkA4THrpwSmeQNARPxXZiWQadLAdH3jAa+XAdTzdbR4lZo8nJspgXiN?=
 =?us-ascii?Q?Dcmtu5CY3JLaKKQj8MdVI6IsUaFM/zOC6XwxbPyDJaSe9JnEx0o4ewa/D2dC?=
 =?us-ascii?Q?lrDyJO0L6Ak3gAnnlTPy9jSh4dIV0o1qqzB7hb/gJDw14pl9qjvJr88sKD3Z?=
 =?us-ascii?Q?yQr8TROIXCDNVqlHaYz3Gjz0GmwiB0J1sB5o1iJfktn1qaidNP1d1pRXVebB?=
 =?us-ascii?Q?UzOfs/M2kILucen6TKEQk0Oy6LFSeQxzZGXzaDGdH6pDiXhewxGOZnIu1MsS?=
 =?us-ascii?Q?aT/SVZ0u+4D4od+wot6hnRjipEYnbyqIFk8gLCdQLgv2IWuGO/mo76BM0b8c?=
 =?us-ascii?Q?zYM3pcT8QjRUkGaUcve4hkMpPodiYDdVkjSs0SA/saDBi9N1vXD4GeW0r/Vz?=
 =?us-ascii?Q?tDYxKl0byEGNBiKJk4VKfeXhnqijuX6m1rVhJrV03WDzmJqYIzlWrKclc4QX?=
 =?us-ascii?Q?S3CJoBviLjxoPdc1Pj1fvqMQ+VOGRvI7syugzU/a0IEIS3QNyEQppNXl+dhV?=
 =?us-ascii?Q?V5CMUKrGrha84eVInYe0E0KQ4TKWkVhmwAI8I0pGj5ILSDen1fNS/j0nZRtO?=
 =?us-ascii?Q?E3ZGTK6CFHe60GpWod+kMTUyJqTiRfAv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ciOLQ9T7KlfFINnlULqRAEatQ97+xVKrHJimQZpJa+HwPTbN5t5KPI4dPD6A?=
 =?us-ascii?Q?Z2WPCWWWAxOa4xwCDNaUsJKnihn+3kSlQkUMSZE992eRmth46gP7f/YpAz11?=
 =?us-ascii?Q?e4yixXXp7zrvq6LwFtIEccfeCOzhJb/USJi0r/ACoOTOe3rw0XSUmQY4FXL4?=
 =?us-ascii?Q?FueIM989BWntpgn2VpXdcvF+bLqSKvsurZheJDG3Gmbg2srlkz1vHqmCdo2C?=
 =?us-ascii?Q?R/Jvt0/0sb/mdAS3worAd5ucQtyGVnfmIGf2FrXTGwZsNxhLAOIe6mIrh9rJ?=
 =?us-ascii?Q?UTMAve+NQAEtlVlxiN4omwo1HZs3nMcR631eaIq1w0z1RCxVwbRi6XNuwLTB?=
 =?us-ascii?Q?pCtHiAo4Brcu+wFru6rn9sxugWicHinHiQeQUD0CNsO5SxaCcqLz1VSM9DMH?=
 =?us-ascii?Q?LYqt4m/aRwPSrECNV3tolP3as8Z06bUGxn3ex/bFtxppHb+EWfRZH6DmO7mE?=
 =?us-ascii?Q?Fdh7qebCAEdVH4BbK24y92m4uFI+gkFHdVOMookEp7ynmp7pzn7d6HUQTBq0?=
 =?us-ascii?Q?tEXEzm+WASBrkyYs/nOM6Er4UzZXBpNGL0tVzEkZV242TJBaHYtKoFG39JBd?=
 =?us-ascii?Q?CaeZkRlRqjbmo0UyQOWtpeidHV9NzOZFlKHixn3DL4ArOyBQ7BFR2AyjFClu?=
 =?us-ascii?Q?cJG9axDzegWxicd/pGQ9Gqusqzq+s5btLnG0BWb0ncDqEqH+VLv0jJbmZSk6?=
 =?us-ascii?Q?OSnfWF7mn6NOpOpHnBfIu3OVLAOsZAVW6nMMXin82hlkwQrk4aomlLuX6Iy3?=
 =?us-ascii?Q?DtZSGji5q6VW/H75wmCN1ayrqwOoFV4CUK9WxkFVYgUhpk16iy7odbkULYfd?=
 =?us-ascii?Q?DreI0KAOxgX4L+us/D4d0gvXXy2MwB3jOkR1m56T7n7WAwR/SgK1PYZm+Yn7?=
 =?us-ascii?Q?jTcVz4r9uV2iDsxKdP/qgKtQ2Gl/bxLCIH7kJOo1hGjodsBCY8V5TdgxnZTM?=
 =?us-ascii?Q?OFvDOOQy2lUg5ZY2tkaPOkcRVD/4l1ldqkrR8bhp2aw8IFrITfD4M2ZXBaZJ?=
 =?us-ascii?Q?lpdCVB75LCnN+6xsW7BkY2z7ZvT3eUFqyAYUSZK21REAyPE+P+F13I/A7Hqv?=
 =?us-ascii?Q?RkaAlvBb6OooLuG13vPZLQxBaaJqTYSB2ZnOwQg+8/s1ldaLtPsXVFXxWVFG?=
 =?us-ascii?Q?LJSJE8u+gA+CES7DyAUIPnTAqLkOYqb/AmXtuJpIFGTDCDzqM6pZ/pMXJVkT?=
 =?us-ascii?Q?39IYndfqb5pwhSx4XzWELdKDuNqgougN9ohRbrySYNXzchEm2UD1GHOe44oY?=
 =?us-ascii?Q?E+jtUry3mGh/bd+GduaqmApIfscYKCLkggm0LQuCCqQo8/7Qncj7KoEwpOZS?=
 =?us-ascii?Q?0DERdOmu1acxyx7uLiO4TRanSrQgTWXICwRy4pL2l+zVnZdwYa7Itc9IuMHL?=
 =?us-ascii?Q?NBWu1A5vvpM9GdPqPEiUkkC//qp4F+7ssh3z71fu6VlAGpH9Kms5W43BNZgA?=
 =?us-ascii?Q?aDhHqY/ptymPEcAG2Qs81wv4Dj2CxpiLfObAMXmr8GBK92K1n6bqZnyZXxmH?=
 =?us-ascii?Q?7ONo6T8zFFsf3612PBK08QTYTqr+awA7PZd+1AIca0unYiebXGmTf6Lm0xF5?=
 =?us-ascii?Q?8yKzOlI8NLUApT2v74G564rAY2DqZ0ESSwM6ZrCC0273OW+dMhTHw8Iyt2ds?=
 =?us-ascii?Q?J8PiubQURtfnL9D8Cji5hr0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8563706a-23a2-44f5-0c80-08dd6158a36b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:48.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moFvRjuI6wo9pTme3q6uR7P3vn6W8xa8dl7Y+7z16yRwhdXBRxNJY5MDFhAkyeBWO+AHNZOQSP6Em15fk9AXnKnP4vlIuYOd5Yeca4Z8e0MNfTZHKbtLdW/mLiAiSu0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18137

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 87d084bcbf1e8dbe97753e20d30fe9d56a97e6be upstream.

The `PIN_CFG_VARIABLE` macro did not indicate the capabilities of a pin
but served as a flag indicating that the pins of a port have different
capabilities.

To better reflect its purpose, move the `PIN_CFG_VARIABLE` macro beside
`RZG2L_SINGLE_PIN` and rename it to `RZG2L_VARIABLE_CFG`. Additionally,
introduce new macros for packing variable port configurations:
  - `RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)`: Combines `RZG2L_VARIABLE_CFG`
    with `RZG2L_GPIO_PORT_PACK` to handle variable pin configurations
    for a packed port.
  - `RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)`: Combines
    `RZG2L_VARIABLE_CFG` with `RZG2L_GPIO_PORT_SPARSE_PACK` to handle
    variable pin configurations for a sparse port.

Due to the above change the configuration macros have been reorganized
as follows:
- Shift the bit positions of `PIN_CFG_NOGPIO_INT`, `PIN_CFG_NOD`,
  `PIN_CFG_SMT`, `PIN_CFG_ELC`, and `PIN_CFG_IOLH_RZV2H` down by one
  to accommodate the removal of `PIN_CFG_VARIABLE`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618174831.415583-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index d38df51c7118..7d76e0962e5c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -56,14 +56,14 @@
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
 #define PIN_CFG_OEN			BIT(15)
-#define PIN_CFG_VARIABLE		BIT(16)
-#define PIN_CFG_NOGPIO_INT		BIT(17)
-#define PIN_CFG_NOD			BIT(18)	/* N-ch Open Drain */
-#define PIN_CFG_SMT			BIT(19)	/* Schmitt-trigger input control */
-#define PIN_CFG_ELC			BIT(20)
-#define PIN_CFG_IOLH_RZV2H		BIT(21)
+#define PIN_CFG_NOGPIO_INT		BIT(16)
+#define PIN_CFG_NOD			BIT(17)	/* N-ch Open Drain */
+#define PIN_CFG_SMT			BIT(18)	/* Schmitt-trigger input control */
+#define PIN_CFG_ELC			BIT(19)
+#define PIN_CFG_IOLH_RZV2H		BIT(20)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
+#define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
=20
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -99,12 +99,17 @@
 #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN=
_MAP_MASK, (m)) | \
 						 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
 						 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
+#define RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(m, a)	\
+						(RZG2L_VARIABLE_CFG | \
+						 RZG2L_GPIO_PORT_SPARSE_PACK(m, a, 0))
=20
 /*
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL <<=
 (n)) - 1, (a), (f))
+#define RZG2L_GPIO_PORT_PACK_VARIABLE(n, a)	(RZG2L_VARIABLE_CFG | \
+						 RZG2L_GPIO_PORT_PACK(n, a, 0))
=20
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
@@ -370,7 +375,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rz=
g2l_pinctrl *pctrl,
=20
 		if (FIELD_GET(VARIABLE_PIN_CFG_PORT_MASK, cfg) =3D=3D port &&
 		    FIELD_GET(VARIABLE_PIN_CFG_PIN_MASK, cfg) =3D=3D pin)
-			return (pincfg & ~PIN_CFG_VARIABLE) | FIELD_GET(PIN_CFG_MASK, cfg);
+			return (pincfg & ~RZG2L_VARIABLE_CFG) | FIELD_GET(PIN_CFG_MASK, cfg);
 	}
=20
 	return 0;
@@ -1835,13 +1840,13 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
-	RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),				/* P20 */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x07),						/* P20 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
 	RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD =
|
 			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
-	RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),			/* P23 */
-	RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),				/* P24 */
+	RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(0x3e, 0x0a),				/* P23 */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x0b),						/* P24 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_FILONOFF |
 				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
 				    PIN_CFG_NOGPIO_INT),				/* P25 */
@@ -1913,7 +1918,7 @@ static const u64 r9a09g057_gpio_configs[] =3D {
 				      PIN_CFG_ELC),		/* P8 */
 	RZG2L_GPIO_PORT_PACK(8, 0x29, RZV2H_MPXED_PIN_FUNCS),	/* P9 */
 	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS),	/* PA */
-	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),	/* PB */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x2b),			/* PB */
 };
=20
 static const struct {
@@ -2637,7 +2642,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctr=
l *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] =3D pctrl->data->port_pin_configs[j];
-		if (pin_data[i] & PIN_CFG_VARIABLE)
+		if (pin_data[i] & RZG2L_VARIABLE_CFG)
 			pin_data[i] =3D rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
--=20
2.43.0


