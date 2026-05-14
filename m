Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C835CD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7021.1778751762099845206
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=E0dso2a7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.38, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VywSIyuiKxKIjGd9ShTSjgqAtqhnIaoC+KTZSzq4jpZrBaWeU6TAy0ceCUQpO1cx5+/pOk7NXZujC1Rd+4u7SonlgfzkbcxxELMDz58978dNDoc3vAZWLB4fBwDjqcJ02Zt24FlDoyUK277fn55EOZPVBhhuRLcjYhZ78bOd1KjwAgVzw6vqmT1pY8GibOH8CT/gNY4hV0D6eCiRjfPxZYmvFukJ4Ubwref0oQUinPQnsI4Z38VCmnHJoK/7cnxLCRs1chE6uzCxdvpMnuG5EiplnQ6qEZqlqO3cZejln5tVMgt3TzH/mT68eXZcHL9EqMy7Fq7J8m7RkpLyizN94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8keWkDsCYgTkYryZ46Ek65yLMbAYfCcx29hF3Gjej8=;
 b=ZhvUyLJlBQQZo1miElQkDylCLeu0wcsU1ih/F+oHk1l3mj202y2Py29IA8nV6DqEbG4RthAaKhDeqstjC3kuvBNs+uZX/Jq6ei6AG70tM9EXh4gPKNJNz6lggx7UDCLspvGff6yXOTDlKv0tkEvZfSH8QnYJDcNDikLyKeWlpZF/QBi4VVKoweEHfGOjGlBlgIl8hanPQ5Ck4HDhUtCRm7iClC0LrnHEbsvYmfw4HF7BkmLH5mpSOTaZM82MuGIir8i5mUyCnNlFEw4oy2mtHcNhL6u6OhqdodV2hAZdmjxh3tairBJ5/pxjEcTeGUqHMZUs+afl5kvI8JQIxEyHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8keWkDsCYgTkYryZ46Ek65yLMbAYfCcx29hF3Gjej8=;
 b=E0dso2a7g402mhjPK8CeE11QVTy2ZNsGwCh/TZ8UM2ABc1vM5FzwDbGoyTtNpgbrSkF7Vc+jm/0KnlBVsNFPq5ZNr5QMLQB1kmfUCHFfLtKoRebDJIFcHNQkKA9WeaExx7OWucJdWW+tHKznrg3QbCFbF/fumrlrkSHUJR9I1V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:39 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:38 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 06/17] PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E SoC
Date: Thu, 14 May 2026 09:41:41 +0000
Message-ID: <20260514094152.2215176-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 43583a7a-5515-42ad-c9e3-08deb19d22d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|3023799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	SkJHDJlormGTHZ/sRG7yTIRYHuT52R15n26pFCIXTEdbnLvT0Wm0UONzRROu6j/Aru+suyZMHkLdFHKkgHR6YJgQqsREEDe4IJIkj8+RbPSJ4wzFJsEi2Y+vfJvvGQ+6b+xa9MCiqUS2II8phcfTDfTj2rOlO3wJ11WkAeFWvfpTBRweA/8GqOa54zQXJBAUEuUwn7y3WrUcL/vPuI2FGUnWcdb80O3ZUI9ruiXlzs9uZuy788cS63DCTFL6Q6iZiNzksS+o2e8x9pNbTGtylOmjNGTXaPNCuqquzrun07P8W0puSdrrDkpXJtyQJqgh8QBa5Nex5F9LdPN1H4wELc6yzqF4WcMXDaloK/HoMGz/PofoIIKaPsSzH0vG9JMbSVB+osMPnfwCcdaDRLr7XHNuiAth3VfWPzpKejkduhpM2ZAEKub2EIeUm3dfwIWVagZn+Fc0k70DGOMDy2GgZfrJTnj7UKQgcpViHE788HY04xxceHJl6e0gIyb6RCrwOo5PsKSg2qfYZADDT0z/T4FecKQ+ux0ri42FR9YSQ5c8TzQjIjc/4FK0CSf2oqpATsYDzHD0hxwYsQ62F2MMEFksWXGw2gWFa7RvWkaCEe1aJiR9sMza+uukYJZkDKVWhAlCCpr+9FJHD335KW4vaZteNd01MnbjarfJhf7s5wu0TjW9DijfqoIY24jJx9SH9XiTzKQBZh5t0z7JPzSlkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uMzpXP2JuHCU0tzclYzgzada23yTk0sKsSAYs/wCK3wPcAnhP0vnnyjFof3w?=
 =?us-ascii?Q?zzp1C1aJ9vwMvm4efIq2C7ZVyJ4dwueEBnItfdPKL13gP7BdJ9iZcM7Fuyw2?=
 =?us-ascii?Q?sh26b/nbhtehE2YHuZnPsPujl+blQ91C4lgXM3mpohMQP8qdRXCQlaoDcuXz?=
 =?us-ascii?Q?OSnOT/mwO/U9b7AifPpEQGhqK2ka0ZAcSZZa5tY0kjoFNDhqZ31nBVyajCq2?=
 =?us-ascii?Q?UXHfLw9gbDJaftuJcyopSebbB5uBnTENrroxwYERi9f2hF6I5R9vCvFQCwCQ?=
 =?us-ascii?Q?tUn3CILmvHec7MJ8eW1iC4ZOUso8yni8zYow4mmuzvPqenr2js7bY5swNyk5?=
 =?us-ascii?Q?239mLb0mToAe1f+xju3Sdodpd/Wj9AJHCOulVOzWR6auA+y4cSkrKOpL9LmO?=
 =?us-ascii?Q?ZnpJt4IAb2rX2nYDx3BvNb1P4cB5zBgtJ76GNBKHg5EWnUyab1r8ldrDzKKP?=
 =?us-ascii?Q?AWm/tvSCyVyF9VQ6nL+pTd6BlAUjlNuLuKGmHGP9kUfuy1A0gNFIsobQKvMj?=
 =?us-ascii?Q?7xKefHhkoLra0/XFYEBrpVars33dyqQhdeqQzvXOdT/O1uQG7JL+h9ehxsLG?=
 =?us-ascii?Q?e7inIoT+Fg00qjHdjTtdHLoyMD9xsZf6HBVIHAyOEqp0WYRg5NlYriddRogU?=
 =?us-ascii?Q?bROcj0GzTlW4WMXm2jdC1ZncXV1phUAjBfn3UXzhz1UiZGyPf4vu4GUl5xei?=
 =?us-ascii?Q?QGuBeLahJvH0VEgnNjNoj/5STYmhZD7w7/CUXP8TnW9tUF3rzjQhEHAx532R?=
 =?us-ascii?Q?/hSwnPHNE9OVAzpYqFC7O39miCaxDlZYMzMMJmHPt/7w9Qwqoeu+rs9zHI2t?=
 =?us-ascii?Q?Gz2jX7I0DeY0AqyQsH8V4kdsPumsEX2GLa/sKMPuxQIa9KD2xNL2U6nKcRbB?=
 =?us-ascii?Q?QRGYYGQ+wOdDepYbPFzZh2nTz03IRx+TpRnFBAALvjemewTcuRIAciqjR4q0?=
 =?us-ascii?Q?Ot4Hphm+0Howb51QS2dzq5kideIQdoACSYTLcfvbLo4CraNRDa8qh9izZRs7?=
 =?us-ascii?Q?bfwZi0AGqOQ6klzzYGgtB6UL0tT+AZfyzLrB9Iuq03BjIsEI3bcuzW5ZF+6G?=
 =?us-ascii?Q?UIbm6ovyjdsCc1Xhaamu3bZ6mn9cWM0TMBTo+jMAmfk3GBC2FmXa92SdnORr?=
 =?us-ascii?Q?ApBVDqI2+Y5JnSVNVX1ShzXkiIZC/GzKAzrIcpczyx1SAgtWmBCrEQOzHLuT?=
 =?us-ascii?Q?yTF1fE5tOOBC/abi2I5A65E+2nrNbguarDQYCf0Z3Ka+FLtlL9yIw4TzXOdA?=
 =?us-ascii?Q?tIx/pjfnhMmfPGm3qEho7+2bQul/zMngPB/eeB/nTxX3gwNWJ8zoN9WZVC2F?=
 =?us-ascii?Q?gPgRy1rR5sOysURaiG0gk2+g2H31I7APN0Be5LbJCPrujyYIvZHumePbP0nX?=
 =?us-ascii?Q?Ni/MKNxIuvXr6nkIsuYvZt9NSmGEHDT/cEk32lLc2cUeuAPO6aMuG0yGaQXq?=
 =?us-ascii?Q?aS//7FAphlwWJ4wAZusAE3SyGDbuLTSvHZLanlJrJ5wi4Ppbph9Jh8o3EbW+?=
 =?us-ascii?Q?x75y78kwvHgYLgWtLu0IYCYLkgLoNJg8WRuM5ktP67MCdvwIwFCZL+i56MlP?=
 =?us-ascii?Q?DBpogCgEyhLNzgJr53BOnjFO2IO+z5zD7SbKnaWmxzY3ysGTU/aQgpCMgnZW?=
 =?us-ascii?Q?WI/H5nhHVuzC2p1yHPimdVbKWqF+wO9xzaL5FtTFv4OHTaAUnpQ1KbNv1phf?=
 =?us-ascii?Q?BehIChpEpk2BEDttZkg0Cs0vYN/+w1feJf9GjL5i0R6nElJlcjJd34Vx1W+9?=
 =?us-ascii?Q?D0ovlQ6ETZb8Xe3jGoFvKoHY3nNH9vs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43583a7a-5515-42ad-c9e3-08deb19d22d1
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:38.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caXZa5NfpDC5J731UtrQSegESc2CN2NDEwWTHgNU518Oh8bwKoHyRjxywk40tfW/pVbz2qRmikARbBoa9EJoijiRUt5h0rWKFSpHL7b78Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22958

[ Upstream commit d17a200a747b01e05bb0fc14d62fbb5ad6653869 ]

The existing inbound window configuration algorithm has two issues that
prevent proper operation on RZ/G3E:

1. Over-mapping: Using roundup_pow_of_two() on the remaining region size
   can result in windows that extend beyond the intended memory region.

2. Alignment violation: Addresses are only aligned to 4K regardless of
   the actual window size. According to the RZ/G3S HW manual (Rev.1.10,
   section 34.6.6.7) and RZ/G3E HW manual (Rev.1.15, section 6.6.7.6),
   bit carry must not occur when adding AXI Window Base and AXI Window
   Mask registers. This effectively requires the base address to be
   aligned to the window size.

RZ/G3E strictly enforces these constraints and requires precise window
boundaries with properly aligned addresses.

Rework the algorithm to properly handle arbitrary region sizes and
alignment constraints by splitting non-power-of-2 regions into multiple
windows. The new approach iteratively selects the largest power-of-2
size that:
 - Fits within the remaining region (__fls of remaining size)
 - Does not exceed the natural alignment of the CPU address (__ffs)
 - Does not exceed the natural alignment of the PCI address (__ffs)

This ensures windows never over-map beyond the intended region and
satisfies the hardware requirement that base address + mask must not
cause bit carry, while maintaining the 4K * 2^N byte window size
constraint.

The reworked algorithm is required for RZ/G3E support and remains
fully compatible with RZ/G3S.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-4-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 53 +++++++++++++-----------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 1afccfb6d3ee..f47a9a9427b4 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1293,50 +1293,55 @@ static int rzg3s_pcie_set_inbound_windows(struct rz=
g3s_pcie_host *host,
 	u64 pci_addr =3D entry->res->start - entry->offset;
 	u64 cpu_addr =3D entry->res->start;
 	u64 cpu_end =3D entry->res->end;
-	u64 size_id =3D 0;
 	int id =3D *index;
 	u64 size;
=20
-	while (cpu_addr < cpu_end) {
+	/*
+	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.6.6.7) and
+	 * RZ/G3E HW manual (Rev.1.15, section 6.6.7.6):
+	 * - Each window must be a single memory size of power of two
+	 * - Mask registers must be set to (2^N - 1)
+	 * - Bit carry must not occur when adding base and mask registers,
+	 *   meaning the base address must be aligned to the window size
+	 *
+	 * Split non-power-of-2 regions into multiple windows to satisfy
+	 * these constraints without over-mapping.
+	 */
+	while (cpu_addr <=3D cpu_end) {
+		u64 remaining_size =3D cpu_end - cpu_addr + 1;
+		u64 align_limit;
+
 		if (id >=3D RZG3S_MAX_WINDOWS)
 			return dev_err_probe(host->dev, -ENOSPC,
 					     "Failed to map inbound window for resource (%s)\n",
 					     entry->res->name);
=20
-		size =3D resource_size(entry->res) - size_id;
+		/* Start with largest power-of-two that fits in remaining size */
+		size =3D 1ULL << __fls(remaining_size);
=20
 		/*
-		 * According to the RZ/G3S HW manual (Rev.1.10,
-		 * section 34.3.1.71 AXI Window Mask (Lower) Registers) the min
-		 * size is 4K.
+		 * The "no bit carry" rule requires base addresses to be
+		 * aligned to the window size. Find the maximum window size
+		 * that both addresses can support based on their natural
+		 * alignment (lowest set bit).
 		 */
-		size =3D max(size, SZ_4K);
+		align_limit =3D min(cpu_addr ? (1ULL << __ffs(cpu_addr)) : ~0ULL,
+				  pci_addr ? (1ULL << __ffs(pci_addr)) : ~0ULL);
=20
-		/*
-		 * According the RZ/G3S HW manual (Rev.1.10, sections:
-		 * - 34.3.1.69 AXI Window Base (Lower) Registers
-		 * - 34.3.1.71 AXI Window Mask (Lower) Registers
-		 * - 34.3.1.73 AXI Destination (Lower) Registers)
-		 * the CPU addr, PCIe addr, size should be 4K aligned and be a
-		 * power of 2.
-		 */
-		size =3D ALIGN(size, SZ_4K);
-		size =3D roundup_pow_of_two(size);
-
-		cpu_addr =3D ALIGN(cpu_addr, SZ_4K);
-		pci_addr =3D ALIGN(pci_addr, SZ_4K);
+		size =3D min(size, align_limit);
=20
 		/*
-		 * According to the RZ/G3S HW manual (Rev.1.10, section
-		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
-		 * 12 LSB bits to be 0xfff. Subtract 1 from size for this.
+		 * Minimum window size is 4KB.
+		 * See RZ/G3S HW manual (Rev.1.10, section 34.3.1.71) and
+		 * RZ/G3E HW manual (Rev.1.15, section 6.6.4.1.3.(74)).
 		 */
+		size =3D max(size, SZ_4K);
+
 		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr,
 					      size - 1, id);
=20
 		pci_addr +=3D size;
 		cpu_addr +=3D size;
-		size_id =3D size;
 		id++;
 	}
 	*index =3D id;
--=20
2.25.1


