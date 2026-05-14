Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CF5CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:33 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6973.1778751623948804403
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ke7aE4W2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEWZvkcK1vBZMDs7RppKjD19XOUGPgKbXW5tL82PKsvzsXUsPSdbNxpoz3zKmStWH4+X0g2bMxwPqrpjhR8eAYPE85ZCzeSAtAQWWTYK8Ruly6V+95lNNTcmVwvz/SHO5beVe2BVDjM8u9ZRXilgt0sCn5UWxn2p4Anijn2Rl3ZYxxVh8fE+9FMvzXwA7iXdxpNOJhFWdkjE64XU3VHZQbIDTbRz8/xqrRtebR4pQSO7E0Q7aT2ownpkopGeofeEbB/0jJLcn5lywGyptqa79txDVcLpfvV3GkI55Swdgn9bbmqEFokVM2p4IP6DLDk4AGe60BeC56z+dOIqh37wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8keWkDsCYgTkYryZ46Ek65yLMbAYfCcx29hF3Gjej8=;
 b=QJqU9GB9UfaHyTgfFRoXWwcAiSsLhBeTTR0YhdC0U8QUHi/BG87RE13svzA7U64V+sfGshys50W/vYaRAUkn+9jedJJ0LGnhPv/+OsoY3ToucJHpu/cqnE59PfpPO+C78jQB21ZLfamGhJHgO1qxnxJrgt8HLapFc5O0BtaQZkPBEEXQrLkxBBOmy4+ICFV0J1AvoDezOAWZb+cOZq2x+J6iWD6Tzs1o/FRJNMJ8sCUjLpZGgYLFxRjlzd1jkjxvnqSADPuA/j3+jvKgYTeVGtvgBJQ4HmvEdWNK9dzV7SeJImtWzq3OE2JCiJ7qKLGvVPFxsiPdGGQfsQXRoIfA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8keWkDsCYgTkYryZ46Ek65yLMbAYfCcx29hF3Gjej8=;
 b=Ke7aE4W2G41j/Lc6Z0npavnyJ5MV8TrDnFVSzNja3V2WZawcqYfRnhmHHYbfFsK3YbCYwZ4LoTeTAz8r/zU+EIpY2RKg4+0Y0qPmMtAXgTg3P/stNZbp1L2LArHAWV3GfS95XbqnJe8+Q1uv0pthwyOt2j4fyFzymvMoT8APUGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:21 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:21 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 06/17] PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E SoC
Date: Thu, 14 May 2026 09:39:24 +0000
Message-ID: <20260514093935.2212718-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e348b7-5d04-47cf-f6e8-08deb19cd0fc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|3023799003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	TY6npdAYBjfGIhXMX/7JLht/b1UsRXgN3wFhxQ52n1Ah4CARPwBLDLeiaIQa9bK+OHwhsFKyFd4Uumkx+9DIHyp2Gzd28FmDClwmHLHCp0fnh5fj9Gky/U53RJH7gauIIA43e8d3BpFYzvtFdPA6O36hRZNZYae12CvdawmXrQ0MCkpijG+NciFPHrQb8iEk26uBDwuIyzBQ0w13gyITVZ7r+/90lSENuM9qD02Blq9EtEhyMw/48z6xM2gSwNOi83IWNz0oW+FdDKj90MQ4kEgZ8Rh32hCLztvkCe2VzKxixX9O8OV/GR/eBzv/FrkDcX9qfD5NPYT1A+M5zgSy2yCpzCe5eLUSf9jlgTBtF8SwRNiE3FZTHQidPZcPhrc/SCRYc3xhPyNgHS2/0iS2tVPnFnM5Z448+g4PaaY/+izu52q3OYsyhL3P+XOmc4ZzzPdEcPtc8FUDaZKvkN9yh05ilx4W4zbD8nv6uo3jUvlRUeLMmgJcvvWglo98DPAusbiHPYJ+c6dZcy1ms4Yp1FjzwjkUONJdQ0euF464nAsylGY/P8hL5Xh0/oN1V54xdHIOuICbyjU+UmZg6Kx2IIVRlTu5N0O8iW4ieOUW6FLiySGWf7wOHcuTsp1GIJ0fYIGR8cMGeQaFaW/d8Tn6utFK9BK3Bd5c22kKVuuQDg3SpB8vVgoRpFceQokAHCv7giyuuSHAL7UnNpq8MHgZIQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(3023799003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9ToOTHnz2D1z1FLhCVZdHu642BWIteYCJ3Pe8FPXwtplbGQZi6da8f1vxRNZ?=
 =?us-ascii?Q?9Gw61FSdCEoCRUsrTLLYP0GGTai0gYOfL9FpyBOLkTT5M8OqNWY4L9kESX5O?=
 =?us-ascii?Q?RXEIhyIpEs0Z5fbYWKkLAWW9b8TmHWN41G4+DH9l0r4f36yG/AT5cTlIiiZ5?=
 =?us-ascii?Q?oPxPL17wc4YVDixCfTzEtXGmggKBSck/reo0FfV3cq77YISJRsUtohQrZg12?=
 =?us-ascii?Q?Qp9ZZqk8cpmLZVwr0+LqtbEQuD+PcS6uS492VoaBByvBysETx+H29cIiga05?=
 =?us-ascii?Q?xjqhDfJcoJmZKmoGOQAAQl7JrUu3rI/N5TsKcjltXJ0AasrvAdW5cpsxNnE0?=
 =?us-ascii?Q?3P7iHyoQVBTz1RhXwpCQwarUo448XC299RcN7NRb4o3Mz4yHM3JuTEvGl0G4?=
 =?us-ascii?Q?W3ZPS3FhqdeGMDgh69HS9JCE6yjrsoNb+jvIyLQGrWH03U194fCjaTAc3QnZ?=
 =?us-ascii?Q?oRPVV6o/mPzVF00+Bu7khDcZDsfzHrabSL1CtCeNRLLQM8l3poQeQYt/SVEH?=
 =?us-ascii?Q?LqqYAJVhDJO15yJ8/V3GfUguY1y8ih4AOEkTYbUTt0VFeJEw/tVI4mzSGjZN?=
 =?us-ascii?Q?cgfr2KZEB9M3YiKX0rGchMMdJUlseLUCA4wlkn5hagoAzR9isjqx1w1IlqAL?=
 =?us-ascii?Q?LzIMy3ZJOlaGN8BZp6m8d/F/pA+Ps60PGHVXgyDpr03UnWZrl6N5pJAGYMKX?=
 =?us-ascii?Q?6Z1+CD6W1u7w5QMTUadA85gORFAMf6P/bpXAVAZZsXW8jH/p4HAAxrDtvqBy?=
 =?us-ascii?Q?2q3mwbSV3HUIpvpuO7Rb4xO1DCtf6RzFKH0qjLH0hDLhm40Ek4MhaycZ9Ana?=
 =?us-ascii?Q?78q48R6apHOWcFEEACRo98b74C/5qdFr2jC9JVU2vSiFqA4D9BsfmGP/g5ia?=
 =?us-ascii?Q?Ut/p/LjW1W0KGsQFGXvccjL91P74nRM71uV4V8it66SPSMR3KtKWmp6nbf84?=
 =?us-ascii?Q?SR3NgZxCsXAPTCvUcmnmm6FlnlN6D3LLa2apEzQ9KRaLS6AmipM2MLl+d4WN?=
 =?us-ascii?Q?CvKQUZw8XqXBX1x4/txWv5BPy7w1BbRjEKNHwVgX9Ir/2llbB9m32c1mL/it?=
 =?us-ascii?Q?njz9KG73PwegxEpj0j80ukQIJEKpSHIgMBBBHNh+rMfpvNqo7J9IKgO53Ib3?=
 =?us-ascii?Q?CPemYEZLTVrB9BITBlrsYz4dY5/YQh1me7kWDmY1EZW1Xi0SjN+E0kZUiZP9?=
 =?us-ascii?Q?I1yyccMcYzKhFi1AWMQf8NyVOFMPByuSjw/4DJZRczgdTnzCT04ukK/YsVby?=
 =?us-ascii?Q?Xxd9DkZOWvTRCCIGZk7kOcIeC/HhKhKzfBjU3SnH/eJYSHadMnaLAxMxpofX?=
 =?us-ascii?Q?wSFilvAX3S7OG1sSoUy6ulR6EQEWsU5NBouP1Wibz8c5Qa2tTN1TyKO+CzwA?=
 =?us-ascii?Q?ANMg18iUHlxcVDUOp+Xp2LjuOI8qA5sMs6aCXVNpU9GEup9bz3Q8XFZPxO+W?=
 =?us-ascii?Q?YU2ynGI483bFE+OR0F9TGCQ7qeJpzsA1/29SISamxg4dkbJmQe4kZoy7h9ar?=
 =?us-ascii?Q?5L5nCpxrYJAsuJtSosp/+As0/h09cKbTaV4sE/uqITrDohsTYrzy6dku4O/h?=
 =?us-ascii?Q?l58sdTtxVNIrfYXKM5dw2N0XIuuDdwiad3Z5mth9zsQgd/A2Wa9BRtBGHFLk?=
 =?us-ascii?Q?ezA8m/6+86VjZytcipRyjqi3la+PcQKHApduLwzq+dlrd1DCDr9X1TF5XxPh?=
 =?us-ascii?Q?JEmNDCvwttQPWnRR8T5KEcZkrdKxh+WLpkaY5cJF7aN53fLJqTU9qNaGFglR?=
 =?us-ascii?Q?n249wv2O5K6biMgRO4IJZpoGK0jIjVc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e348b7-5d04-47cf-f6e8-08deb19cd0fc
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:21.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ms20OlnIFfTi9y6TeArq4/JHFa0roar752dN1OpkRMdyO1BF0XF01Xf+d86aCz5nAuJhB7XpLoaRiBp488gP62bBwVA7u1DBxXSN4vLUpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22940

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


