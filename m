Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EDC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.53])
 by mx.groups.io with SMTP id smtpd.web11.5806.1743752353693609646
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=c5Xl4TnT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.53, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWdIIey7WyuL/Y/WSHOqh/NHLI1MbZiAjcfrh8BYZ90TZkymfvOqHXKXw8v/ToFES7nt7G2BEtrhkL9F4PN+I0NEdibO+6ZE9evckEzxgyhuJ/Irbt27Hn0kIZ8kFbYIMVnANHNDZzkBg0lmeAVUK3GQ8eswNHL5glrzsoF80sl0TTLmG8xwpWSJG6gYrWVJEQ78v2LJcrDXvfwCwLAsgSPTK4LvWzisPW6H7aJWiFBYUyzWvKYpUFQhsOkkPy5+0Q3Cy3MI9Lwyok/vWBmFCpDBsO1SHkCbl8cyEevuOGMfOP0HERattttNLMvCfJSm5qdzWaybDobEWIMrSx9Y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N74QqTyFMYKY9bpb8L9VJ4cQJRwQEqnXESHKf6wdGhg=;
 b=QLFyXHxKG0sG2HZ/s/X1WNRwfkkNSo3CKufMGLHR6Ezo6sfrjJlXZZ3zmaOYhHui0kqSGVT64pILKFEAYviqwv/2BrpySArZvF0l0E5KX8BhJ7+7GfvkqFoATCbuyPNez4iL1Gh87mAy8+TjYA+jfg/uMGuLsRLwnBvwOlFO0HAfTVsxBfARXR8abcM2eETqS1gYUlaUTJx+lDllzSH3zF64eX5ndjih54qEsr0rx/k3plFjvqb+ZZisHqHMiqTksct3Hl+L8ioQDEBkIrRuRMDio/s8ymh34000ayJWO4sI4GJ7xh6esl7aKZnG5PSrkhpPXQ8ZnJCGC9LVaT707A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N74QqTyFMYKY9bpb8L9VJ4cQJRwQEqnXESHKf6wdGhg=;
 b=c5Xl4TnTfcUwfbUBnLaLpE2TEtvjTad1egmBZ7psBOOlIGjJSTNk2e/mzLJRWFqKReG18rCv4/+fI9AMOyby0TVE0yIpLjSiVerfI/hKgMbeAs++cIN4+j/hKwy4yBNtr43RyiKoMvdHHe6AeImeVfnWHYlM8bTI3a9RZ5UsiD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:39:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:39:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 8/9] i2c: riic: Add support for R9A09G057 SoC
Date: Fri,  4 Apr 2025 09:38:18 +0200
Message-ID: <20250404073819.173272-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc7d7e3-3ce9-43d9-4ce3-08dd734bc803
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DlipVXHZUFy6JfvsAHZbgX51inVptBHGXxcw0hQwTwuJYmcUaTS1NmZ7hDUf?=
 =?us-ascii?Q?tgxzi+nx/5iW1OyGs1nDrO1r4XTnT/MBp9jUXCGeP+ilw+qVcAaphm6QtCpu?=
 =?us-ascii?Q?LUY9vHddz/Cgms4Ne3JoxsxqIDLNRSsgNCxyrSqlJImmdoGA4nQgSQC2RRmp?=
 =?us-ascii?Q?aAXBtSBTsC1mjtL31L5tX8aeei+1EdsIvI0CwaxXASn3NO8pJiKjYGob3Oem?=
 =?us-ascii?Q?irPqSPKTEpvaDZWSos3Z7zlt6mdxrPFcNumhuZq7Iv5R3fD9G+pbAI6l3l9R?=
 =?us-ascii?Q?psKRSyowC7yY7VK0Xq95VJVtVCnN9O8DBHpkJ/Jgp0ySQlgfzxJU5OuQnUZb?=
 =?us-ascii?Q?avAmZnDMRWWt65NaX+iXNihP+DZIqRVBF0D3wQz6OvbPtstby5MALMzwIVm+?=
 =?us-ascii?Q?6sz7T42RtwFjhl8SFWChftWuWuXbQSWrwug+6TbZDkyZDXV5BUeX7pV3lJ+u?=
 =?us-ascii?Q?l2LvQHDQmnTa3HM8QG201FOc2TyzFrUsEwIZ70t9rQMn/9HSQiEp337VAaEy?=
 =?us-ascii?Q?MPB2sZr2MLBUdZ2OmhG9DE5MCFykh8PMj2+HRXECqC38InFSuyj9BFUlFSIf?=
 =?us-ascii?Q?XjonO9PJjo9juOB8JmteNmGN8GWQ+5vKzPWJTeDmJa58KzDevXUIGUhMnlFr?=
 =?us-ascii?Q?syAddCU9SksAX8An43CCm3ZHVBpLpR/ViDlP4rVSgi1GWxf5Z3O3jq/5qXjk?=
 =?us-ascii?Q?6m0JKWgNxKnFqJRxfp9xZ1VHZtZmLeKBF1TBaiSAf8WmJ+xfoho/sUIJRJMS?=
 =?us-ascii?Q?/ZxIHPj77Li7hPUvOD+Hw9Zg3vWEh0ffGudYMuT84wvVBlSowu/9Ef9ZfNmn?=
 =?us-ascii?Q?WehqQVrywNGheZD87x1pe72wyBXzhPMXnz3R7wAP25dXvqyuUYNyRRJOr2so?=
 =?us-ascii?Q?zhnutzYftcCa3E6vKilBk4ILTpzV1O1AkxgvmUX7Nl9ylIgFvulctNvbea0r?=
 =?us-ascii?Q?K+7l5IX5gjfH6KNMj/ACWuuYDsWVBj0OgpIXHlZNQLi819Pnc1vtgm5r3xvp?=
 =?us-ascii?Q?w6IvLW3IoglB+L2XMu4WsAmv2l+/PViJ2cMEPFCW7cRzNvO+jhaXnQ0dZN5g?=
 =?us-ascii?Q?iSZ1q5ZL2crQyEVORT2O9PKJZzQjmPfRv3HIsA/fIZkOBwCDwtDx63XSpD9Z?=
 =?us-ascii?Q?gS+6Zqd58sPtZXGvwWSPAp12buvvQ/slfyLFirULB93/kTDUikx7qrdVDMgL?=
 =?us-ascii?Q?GmI1cks0c+7oq/o01FBewALDt9QOXNXbqV4aF0vBFabuLkeZCFlqHoKNRZiR?=
 =?us-ascii?Q?iSURj5gemTqnkcJnv8DqVtjO/fHDrCC0O8vw3Y34zaeSgTGXYPzAyOs7kOzO?=
 =?us-ascii?Q?UmrHE2oMP7xUPS/MRK0Byxv+P2aOl+rsGAaWB/3EBnoEyy+8pVKSn7nfB4+v?=
 =?us-ascii?Q?P4BKbWEM8e/o3I4K1fTobEI9ss4CaOFCd/6U6HCFcyPc+uxZPi2wbvFa0Tjf?=
 =?us-ascii?Q?ArhuN8EhnSj6GbsjjfLZbt/BHcot6UFB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NjjoxTut/pcZQB+2fdV6QstmlQnYC7xfz7hU0sWWETHt1PrdjHh/Y1z51zbc?=
 =?us-ascii?Q?fbmwg8m+PDYcvwKLIlZXg7T91RvWWE7woJmnboDQFPkbKCY1JydrD8PdWGWt?=
 =?us-ascii?Q?Oz3w5FQR+6Hi4rAwQuZIBapSOu6s7BQFarBxZ7Dytwsy2KPqUPmnKEz79D/Y?=
 =?us-ascii?Q?2cKS5D5CluDkpZPnZGoU4Bh//3y7ymdk4d+r7Vz6/CT8c+ntrJfWDRHE119f?=
 =?us-ascii?Q?FFCuL7sQJBmEDq4m6bZQhUVnv8RPdYptCnJ6sNJ1EmBgRc8sFabZ3azHY6dK?=
 =?us-ascii?Q?BpLvmudWj+f4hiOxAzcD+yugONQaHJjej2DtzxJaEfkl7JsoKZ50o1uPm6As?=
 =?us-ascii?Q?wpfcRyeuLcL3dVhUNoWKzR4Zx5weQsLW7W0BoMv41fTSdGqm0a6all6bFScR?=
 =?us-ascii?Q?0XiVFMVJzI52mL9/ZZEaDnk6b6H2QH4M8JmphyxO/fLQhO9MQVQvpMu6sPb+?=
 =?us-ascii?Q?bE62DADlQYXL/q1sHraxKIl5SUHXnJ/V0eW/lSqaTb+i8yUlC2Hg7euwy50n?=
 =?us-ascii?Q?Chnlp+oJOm9l638jIPfLz5Nn+JhH87OxY6FHdMPMmbHd+PQhpnvosljdHgPI?=
 =?us-ascii?Q?9rL8lPNc0GUqRufSvbV1EXkI+lu+hlxqfL0dTARf4SS5Nx7m5SdV0GRdfRjS?=
 =?us-ascii?Q?wPdDwiu08b1Q17Fc98GtRzWQI+2Q56kc6SWvCeClz8JzrDN3KuGmc0XU8OKV?=
 =?us-ascii?Q?vjO+h8wMHu21xe743PkjT7JlKA+qyY9CC+kZDmhRPAYceSeJA7DD2B9eOvjC?=
 =?us-ascii?Q?SKXgtZAFEZU1UGSG+40N7cNZ3rIdINSf/iehFDw7BCkYwTywDMO1TN5+FB4/?=
 =?us-ascii?Q?dtlX1tgsZwlmg2GWEo8CtQpp4tFs03HEUzHWMkfD7qZGWZAdyo2UyIEFXJeE?=
 =?us-ascii?Q?+vFvF42CxJuNdr4+9TUXDLOPs4sYKzPrijOfcxuwJHUKl2e/YTuoXfNBet2n?=
 =?us-ascii?Q?TpYKfvDNPCbRoB2fQ2CVX+KMxdDrz7LUIqTpRfBqS4Ji/irLU3/Wt1Cl5du3?=
 =?us-ascii?Q?3sY2CKi3x2eb65CEplWPj2cAG46VDhmnB3ms5rTJB93sRqhjo9Q3PLyCH9uB?=
 =?us-ascii?Q?a7fky0OzfulFepWroM0fdJQsfUFg9DLDNPIey3Pip4bZx00kBXcNUE9I5kN6?=
 =?us-ascii?Q?siSxUECFYcpMnwuE7r83ctw5Ppi3tY3R94FS1Qd9DPft4gv+xS8nCh+9tQ/d?=
 =?us-ascii?Q?ghBHjhvSt3fLkxBHMXaqaOO/BVcqK7rJ/oFFJk94PN+zfbn2lsYCLsjiQEqH?=
 =?us-ascii?Q?bcFc28KCGvrWLI+e+YkrnuA9REdosS1H1HriXekeToU6BUwFdxFmoeDMJNUL?=
 =?us-ascii?Q?+zvN3jz8mDZ+nuERZ0adU/JuZPUxhOr20BETswUeHT7CSC62zkOUDRjEfUY1?=
 =?us-ascii?Q?Bq3uTAolHsPCgDku+av2eST566QeFDMWuBgl7ZbpFB7At3afuBsnELFfBhJ4?=
 =?us-ascii?Q?LvPXQZ2xQHe5Aj3iiojFEW6QcqxlgbYRh0uqKfoXx4ctvUo+N2Na8Ya2oTX/?=
 =?us-ascii?Q?UXt9wRzLgB1O+T5FUWwCyGtBH6x46nxkKMD5hV0zfqN/HBfKqZG2MKdGQeSF?=
 =?us-ascii?Q?GoWZu7/CvTKE/ac3jn1YgmvyuIQQNQniMguCZu968qCSRDX0vqTQfAvkoUlU?=
 =?us-ascii?Q?KHqaZ9oYKyrRUgyWmdnR5nU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc7d7e3-3ce9-43d9-4ce3-08dd734bc803
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:39:07.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE5AmFX7CxgmZAS+siYQf5VCnqpdCCNr8i5T2DMyYxWjvO/ioVMqw6UsbS8PNpZ6Vcn3Ag1s29Pm7fHNCXgVrFssrij4LGh6oz1xzFyc3KapNTcEB5jJ0lPVBlzmBAMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18472

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a45f95d7480544fdaa9d566cb4956d0ca5d0dc33 upstream.

Extend the RIIC driver to support the RZ/V2H(P) ("R9A09G057") SoC. It
accomplishes this by appending the compatible string list and passing
the RZ/V2H-specific OF data.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 3dc806f72b785..9df80c4c2b5bf 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -526,8 +526,25 @@ static const struct riic_of_data riic_rz_a_info =3D {
 	},
 };
=20
+static const struct riic_of_data riic_rz_v2h_info =3D {
+	.regs =3D {
+		[RIIC_ICCR1] =3D 0x00,
+		[RIIC_ICCR2] =3D 0x01,
+		[RIIC_ICMR1] =3D 0x02,
+		[RIIC_ICMR3] =3D 0x04,
+		[RIIC_ICSER] =3D 0x06,
+		[RIIC_ICIER] =3D 0x07,
+		[RIIC_ICSR2] =3D 0x09,
+		[RIIC_ICBRL] =3D 0x10,
+		[RIIC_ICBRH] =3D 0x11,
+		[RIIC_ICDRT] =3D 0x12,
+		[RIIC_ICDRR] =3D 0x13,
+	},
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] =3D {
 	{ .compatible =3D "renesas,riic-rz", .data =3D &riic_rz_a_info },
+	{ .compatible =3D "renesas,riic-r9a09g057", .data =3D &riic_rz_v2h_info }=
,
 	{ /* Sentinel */ },
 };
=20
--=20
2.43.0


