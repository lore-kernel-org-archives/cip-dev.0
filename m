Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F8CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:32:05 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10935.1781685116743012114
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mpVUOJK3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5GIYR99yuc0gK9KZAgNOMcAE/dk5MeVNGoGfSSSo98NqgXfcfA08flvVAFmKDaeMkto7XVo/uJntcxviRNIZyqIxFyy8zHlPT/4SIZD47s9YKT35FvZ8s3XVkHkSMI0BNqHJTPhcXt7qoyPSmKz8izLOoSpPnJhiXgnG4B2wrZMAkSWuSTuClyNUsjL4/WqOnb9fdPWxduEKQ/OBvzTPWrIM8bqaClUbT4/90AZt5O7j4nnJgDV5xru34pYHzcN5P2iyERqj8Y/rVlB0LejPp2WWzV0FptbawiQcwG/LXxyielozrVXvXoa/oRhuixZukiwxC99UThvrERLyOGXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2NDuqzezCrlfy4EXmkIqC7yFUFZ03BGrYImfn/3+/Y=;
 b=UizVLxCusyF56g8FspSNvGVJahi1qqA+lByznUF+/9Od3Ep6VukDBMYpMXpRZHUrB40u+4VeI6KthLKtEOiWMr2qy7SoSyEWndsK/Mn22Iq88BXpIu1sw6rFz2M5X+ikSUhJQkybyRZ48w4uUXz+NsOPRO69oCOCQxZbcPf3v+tgFciOc0ejPiHbUPb+FKCcphf6qIckc/cD3e30Eqn5PrhExS14neB6H4YceU9HqpK6j1Ka83xDH3x1Nef4IZfd1c6PC22D2uQ2PO1/MYAkNgeNkEyVOynaDJqGDxwWcThdqsyhdnbTemRJ3H6AI8yWrB+L+B/Z/HkZ1wthdyOsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2NDuqzezCrlfy4EXmkIqC7yFUFZ03BGrYImfn/3+/Y=;
 b=mpVUOJK3EfAT1T1LwmoNC+AnDDhutAaEv/wDC4ZKk8EyS0EzfafSkeXixLjFcWhRSsDaIPz2572SJCisbaKp8Q1LbyZxQmljH6tmJ4lr2gB6oTlir7jCRhWs+Jm9ZGF7RLvfiTDFzOf3zsBER1MSGHZpUo4UYtnE4dEf2phd2rA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 28/32] spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
Date: Wed, 17 Jun 2026 10:29:59 +0200
Message-ID: <20260617083003.1071543-29-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8807e042-d3b3-456e-8e8a-08decc4ae241
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	OqWwQiDqbaTJJwV8+OJurTjCgvAWP/tUG3ry4/jmF4hg3y3sH2umEvTzCb3OaJ7StvsnwwsPz8iQhMi39qsT7G75QNfXa7GLmkBVY7VgrI3rx+sRTAEGQfdYZdBdctzwkaI6TuBakoE6HXYAl/WwW+2o60HktbE184fVs+tKg6WFCgmTviki4YpyJBbjwlP694F2GfHk5qGV1J4BkCdQ3Zg6h/XGarxbhg9aGShTh7BnDrMSuQhwYsRXW8lJNlQxwkA8TuRsrT5U1UU8ea4PmeJvXCpG+GxYl+dIlceyKaTtZnwA/rwS5Z58mNlTDNoEHE4VCcInELfyZhs4lacDeVs9xC+gd6SUoeyqPHByKuT/j9P/WJ2DA4X+PTTS+3zBGeb2WdNtzzYmdQsTgExCVOhTYqXCFe6cd2zL4VMq9Dc7g16vHm7bLwkADC06E8xDGLBcNN0MWa11jkbZ6tIYnxL4rFnAvXfojf3X1W3VkeS7+R6R1wgNZ19CDunpWhcEue+KA43x3iBNK+OZUZt+n+68mb9BjUWXy/fgTYQrVEcZjtnNjxhgE68iOS57H9B55cZtqXHTda0Hlmff3Zdg/nW7H/q6Y55qwKycqolNhNKqK0/oIu6+pqk/pYLoPD8nFifyyQ2z0o1Lavjcn5oUPcf1K9Arr/l0LqfXg5/4NNK4NGeBRyEEufqVzwkPYqH7yj6T+BUUcD8sZBCLUbIk+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZkzPg2egsQSUCs/y27c6SSk8wWt5qmf3mRM1znt3iZmkgncbKlyM+EGhr4Qz?=
 =?us-ascii?Q?VfuoEy0QH9UnKjnT6YlGVYjDG4e1LU6+9YknG7XoT//C+PwPVMcR15aV1tiQ?=
 =?us-ascii?Q?dwYJjjtGO85TmfGJCIGJaZVEaIj02QX01IkMyotAermxWcNWDVv/AWkWT7IR?=
 =?us-ascii?Q?jcCuX3gqkGp+4nv33F876EHLutqvLz767I6E4aZ5fpk+QM4zAJBvFVI5oBjh?=
 =?us-ascii?Q?+0sLBpFdN6OhdMb4OujTikTKzpMuCLe4RVJgV2PJC7yovXBG9WgZRcsM8vnB?=
 =?us-ascii?Q?ExvhLrNnEETkH/Q5PtZIDCwerm5COS5A7u3GYSIO3cJZkf7G7j5OT2OPFMQm?=
 =?us-ascii?Q?Z07RieiSBdXjYTPqJFvnT4lY8m++O9P2hPkX0wPCXSOk9RI3PY2bIH3rL7lp?=
 =?us-ascii?Q?xf+m5Nwh5y2vje2kWs8Ei5U4gO5lDaVcOKckdj+/dzCbptOJgRz/RtOeuM0v?=
 =?us-ascii?Q?brBIp4EJp/gfFlgkdZYKegaiSx14nWreyNPZCsSwh7O4qITP1dv/TYq/oogC?=
 =?us-ascii?Q?nbELjS0s1WwBbbOEdguUS+1ZMNyN9vLHYgG52Gt7XCHxYWD/D9yctQSHPXml?=
 =?us-ascii?Q?pXRLf/O65bJgBYTGjw6ccIMKK8WVnPfX3WqSK4jUi/i9BJ1W1rdb0pQtIi1b?=
 =?us-ascii?Q?xJbUdrQNWpbKbzVuiNmSfr76Kb4vSjJLCfyL2VOnPdMXOYCnc2/BN+aW2OcA?=
 =?us-ascii?Q?skNHZVP5VCcFuhcLnznLZZklnLRDSEWjB4KogCzP+Njtw09UH4HRMVw4GSJC?=
 =?us-ascii?Q?/bmHNvWAxgLQjrfL94HfsGJITEK7hSvz1ffKPlSq2M5Dn5+Ajszj/f9vYkcL?=
 =?us-ascii?Q?3Uc/8v1sgvtaeeRzfgpMtBJeoLBmoG3ldiB2qaj84a6kd+RAgjJVQfSgHL3s?=
 =?us-ascii?Q?inWilXpvtcIrYnR82txEPuJ+nvE09cYtrwu3s9eOQo8uJRYvQXJFduL/ZBSA?=
 =?us-ascii?Q?QtczuP4x9ejoNrdguAcGvKWCFxd4u8mzl2GTak9zavRYSDerB9JcS8rxkepg?=
 =?us-ascii?Q?eFjxUYjsVwYMVfxNRz/OvRmIXTAXqZGmpq/1piDPU5BeRxsKetUk/z8mN7e1?=
 =?us-ascii?Q?sU/wUM4YLJFXhlxTT3l4NOP64fS+hx1DhOWHoKw1dganFV+T3jMCCvGtovi7?=
 =?us-ascii?Q?rla0Wj7siGJNARBf0Bn6RuQrfM+u94QSTv6gh/00lBdpqt/gb+aXT5EpC7bd?=
 =?us-ascii?Q?E2okE0M6uOxNpgySf2qHYCqCm/SC32Td95VNpjCw2Srxw9PQqJIP1w+Z26WU?=
 =?us-ascii?Q?+PXA2q+kZUux73k0ubLn/CcDypQiuNgdKz2ThG/sEeCMZ1K6km+LNH9c1uzp?=
 =?us-ascii?Q?T24uG2FkHprlQxBoYLWhzWcAbIAyVCsB1ugrQTC6ACzU4hF1IqLEO7+agjbo?=
 =?us-ascii?Q?WsCyMSgBD0ha3188/zjC7cdvM5LdjCwi4wv+gN08jyh9iSMx3qy4ULkgcqmj?=
 =?us-ascii?Q?J6CiIpSvVwxYV2vXzlOYlj+NmTHjfBC/nPidjP4HV4nJ+otWl2y/WqATCQgY?=
 =?us-ascii?Q?g13fITxfarrNGJ+MCtZKybOp6dtzgcW/Y25QF2fRV01b80+KX9Ys6xv4YNJW?=
 =?us-ascii?Q?GjPKcrp2LKsHvHglz1J+fyHmVpHQlc8RnYuA1oi3Y49RwVnQE9I6t262qmAt?=
 =?us-ascii?Q?7eSTeD2PUSRDJTSPc1pSMip57P8XX6oG7FO8WbqiqN8YBX2miS5ti56nJ7AS?=
 =?us-ascii?Q?7prv+nSBNEqxrGBcXk1xY2sX4/8J+rUiapUrHl3kJAI4TSPr89CBm0X0mmtr?=
 =?us-ascii?Q?lEU0soDqP19GVnsNlglRC0mzehfOspNMRFqlThKAZsYjRyUe6KEz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8807e042-d3b3-456e-8e8a-08decc4ae241
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:53.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11zBvVFxmbBLw5/lLWewFTXnzkfxeK0QoV8PBafCkV60oWgtID/sAM0YmG23mNkyAoiZShuCyDW+PABZn+VvgWgXeiEIrk25YInzR0ttitoRbpvO66MH51tgB3ypIrgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23187

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0335767dd8e7ade8a8e3028d08c4621515d47388 upstream.

The combination of SPR=3D0 and BRDV=3D0 results in the minimum division
ratio of 2, producing the maximum possible bit rate for a given clock
source. This combination is not supported in two cases:

- On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is fixed at
  200MHz, which would yield 100Mbps. The next hardware manual update
  will explicitly state that since the maximum frequency of the
  RSPICKn clock signal is 50MHz, settings with N=3D0 and n=3D0 resulting
  in 100Mbps are prohibited.

- On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as the clock
  source, SPR=3D0 and BRDV=3D0 is explicitly listed as unsupported in
  the hardware manual (Table 36.7).

Skip the SPR=3D0/BRDV=3D0 combination in rzv2h_rspi_find_rate_fixed() to
prevent the driver from selecting an invalid clock configuration on the
affected SoCs.

Additionally, remove the now redundant RSPI_SPBR_SPR_PCLK_MIN define
which was previously set to 1 to work around the PCLK restriction, but
was overly broad as it incorrectly blocked valid combinations such as
SPR=3D0/BRDV=3D1 (31.25Mbps on PCLK=3D125MHz).

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Fixes: 1ce3e8adc7d0 ("spi: rzv2h-rspi: add support for using PCLK for trans=
fer clock")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260410080517.2405700-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 1b3127812d50..fec389233d42 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -50,7 +50,6 @@
=20
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
-#define RSPI_SPBR_SPR_PCLK_MIN	1
 #define RSPI_SPBR_SPR_MAX	255
=20
 /* Register SPCMD */
@@ -535,6 +534,17 @@ static void rzv2h_rspi_find_rate_fixed(struct clk *clk=
, u32 hz,
 	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv++)=
 {
 		spr =3D DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
+		/*
+		 * Skip SPR=3D0 and BRDV=3D0 as it is not a valid combination:
+		 * - On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is
+		 *   fixed at 200MHz and SPR=3D0 and BRDV=3D0 results in the maximum
+		 *   bit rate of 100Mbps which is prohibited.
+		 * - On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as
+		 *   the clock source, SPR=3D0 and BRDV=3D0 is explicitly listed
+		 *   as unsupported in the hardware manual (Table 36.7).
+		 */
+		if (!spr && !brdv)
+			continue;
 		if (spr >=3D spr_min && spr <=3D spr_max)
 			goto clock_found;
 	}
@@ -568,12 +578,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pr=
iv *rspi, u32 hz)
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
=20
-	/*
-	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
-	 * when both SPR and BRDV are 0.
-	 */
 	if (best_clock.error && rspi->info->find_pclk_rate)
-		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
+		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_MIN,
 					   RSPI_SPBR_SPR_MAX, &best_clock);
=20
 	if (!best_clock.clk_rate)
--=20
2.54.0


