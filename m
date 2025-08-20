Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE294CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:33 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.web11.937.1755705992044249304
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=blP5dVvY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuLX+wpxomF7m3abBVrMH+lM5cFa0/EiFTJzJSfzvHpnJZnM08YU6K4CF4RMs6YkHUZGuhj7YohttRVcI6fH4BWrfua2PAI+ueGzjo/GNRr2XSJG5sam+UdblrqfPAuMuikez4xmJ2iPKhcfeb03p/H7moG1x8hT9Elrf32Hln2yJ6XpIHhBqPloKXAf8UdfiRntRiZIg5NTtpUeCmC1EjQXlcPA8ZpPUyK9s1MFZAwVjZ2fVrpbVlISQ6rjSEHqpuANSCTCSFApD/6VSQQoqmz53dSADXBqK1ouViUpyjzlbwUbdC/m5F8uoUnDolRwtgvnZI7xkR4PiQfD+qCm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JId3FJKYzdZVqwS1sUiYClUedr3Kg0LSjZFxmN6tqKk=;
 b=OPvM6oL94LXQhRDBHQHagehGcEG1eutg1szIu5skWI70mOVmy21NpmQYCEwjkfEFu8lFrIErLLTBlsKZwlnI/eZQey9N9yEZv5BVUB1PZ2P46WGYmizSOhcYAZVvo80WzNyk1RY7HmpCenTQm74dYY2kOOuMlsn59TLDlUeHs3SIZdxjtfTWB3TK2y+jdccW32lHMHsdiLRXR/JFLwjgPErUyiRGJkaqeQCthABWzulGvvKF8/PfgB3bBddPJgCQ0mP7f5HKpg+NYY5CpwjNmzRabml2P6bQguAI1xHBjPjgMJWfv5nvof6kuNhrYQQKlfUQVRMpK8hzt5gaJSr6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JId3FJKYzdZVqwS1sUiYClUedr3Kg0LSjZFxmN6tqKk=;
 b=blP5dVvYnYFJuGXZ6waQYyGdfMV1YFrpSmAzYwn8ii3JfE/jbBT2GykZRhCz6p3Q4mWt1+6iQlCnxfUJcVYAlXmnz28dPsym8poW28yNjc8fBWYs8MJz2PQES5FLSumXuzQwDhEwG8vpkhLU9bChvkgFTwFfzspQPciwu9ZFPAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:27 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 43/55] media: rzg2l-cru: Add support for RZ/G3E SoC
Date: Wed, 20 Aug 2025 18:03:59 +0200
Message-ID: <20250820160413.801341-44-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d9e371-1d5c-4dfb-e339-08dde00384d7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3VZZcFnlF2d/AqFBlaPDWa++ZmnW73GPgAygk6UqJbIrsi8aVnKGC+5p7vgC?=
 =?us-ascii?Q?2yS9Ej+ubTTy0TX3lKp1aZlGYwpvmYciF/oaJOk+12el4RSwb0SDzfvfqvYc?=
 =?us-ascii?Q?D4p2o4H1bmmPGNCHV5QdTy7szxW+AcHGoBHZ8ZlX6VZ1mhE/T6LKj7nH/91W?=
 =?us-ascii?Q?BoIDfwHwZY/awyLeDe4sXx1Zs3HWO7K8nBT+fNRr586HI4x2bYIVdGW92+8W?=
 =?us-ascii?Q?6h+S68/yNrBBFO+6MIeiYncEbhtTj5s+GZUASUhCiDyA9mhDg6S9Rib4BDBX?=
 =?us-ascii?Q?x0xQr15J38SaoV/qfvWYbE3I3+4+1/VvCzwmsuMplujVmpsvmj5x0OFa51by?=
 =?us-ascii?Q?HPeMC4sJFvWBfw1J/xRYa2mYTyeOfj2+SB9PEhgIvVzdYhWKoFQ4rLJSv5K/?=
 =?us-ascii?Q?HQPmxUYPUo4gbkeOp9aOLXdfSPXgJ5bXv7uDNhS7qTrVb4846lgU2IvvLN+i?=
 =?us-ascii?Q?Qei+JmUwgVUj84+79yuxQIMnhDagnkI4lh4rWCtDKcgYmQVg8K19t+QXAMBw?=
 =?us-ascii?Q?9n3tUi0bRbTop0MG0noLiH0DSuQgy6K4jNRKX4Y72MS96kY3NZrtvPLDdxsw?=
 =?us-ascii?Q?yBv2BsS45MH6xpL2o/9YMcu0gSK4FDAms/QQouO/sFRknG1axCOSsvsgNaPX?=
 =?us-ascii?Q?dWt1GjNy7sP1kDFK9KAwIu/irS6yQWpyN9v95yIfJYwUGsJsb8GX8e+Salik?=
 =?us-ascii?Q?1fftNKjm07OdZGIs52cBj5eixQ33+7kovAWMjlbfEulZbD/vl7TyWzmWdgaE?=
 =?us-ascii?Q?FkYAyd11i8EorsV6WCiVPUAkC1XB0awYwuiUkRDmD9/qqLMFzXA5oTNf61b/?=
 =?us-ascii?Q?JRqel+b+VbduqzvtHRjPiTAq3e2y5U+BWYUHkNDl/fqBRuV8tgOpMYC8Mhk5?=
 =?us-ascii?Q?LhsvU8/cvVyN7lR9jPOuNz29bcyRU2C/mDmeO28nG6va2siFbaZFdUHMuvqU?=
 =?us-ascii?Q?yNwS8s0+U1SUgTrECgaGnA/UXXw6velsNeRddLW8AAe0bX8FVTfC6eW0HRCO?=
 =?us-ascii?Q?lygJwkOIKguWNbJNW8nNWa2a8VXqxKDLFkkdOJKr+UB6cAO6dEaZF4tZkYD5?=
 =?us-ascii?Q?JU3dbz3IgHHZ0e5Q+7PSMmhDj8ru78kdY6OXw2SzmGi39QW0BKlc5aWHPmKq?=
 =?us-ascii?Q?qOLg8ZkeIoPBqZVpAGGxAbkHb50v7aS/41g5Pf2cAfEL/WZRjdqRovM695b4?=
 =?us-ascii?Q?C2eHRu/kIdRKfoX9Pb27sshYh9jfQAFuNUV+XH7ly4SsR+vDtsvami1mc0R1?=
 =?us-ascii?Q?tIzOxn3qs+1m6hROlE3MuzWiMnAqPZi+VKnjEKGhFwcIGNZfqnhGqjbjaAF4?=
 =?us-ascii?Q?kx4Z3tnv9l5MNP0aoqjCD9n7LMuBV1/P42cVzFjT9HLrOUu/mvZgf3XfeHwo?=
 =?us-ascii?Q?yiiGn25y2OIfYZbUrsPfzBPVn8yfKNvKy0rFkO1tVbiS7XvWmNnULi3pJXSf?=
 =?us-ascii?Q?Pvsmg48AROueQ+u35Nul4nmPCCP5kH/Qo+JPQs/5UaeI5euqDuvXX2XYLl7m?=
 =?us-ascii?Q?2uOwrtHs+19HFwc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KmzNs7X+TU91gWrrqg9wTKE0MeK16AEqSdHjJ6srZhD65jRCiuqAJXB0/S10?=
 =?us-ascii?Q?FAADprYdr7DgkOHEm252LlI2l8SeRuUzDeX2HrCKN6UAPlILuBmuFnt00Yza?=
 =?us-ascii?Q?suu4JC55S77jarHmAi6b6ub1+v6MJJYlp5ryB5FdFilEH1qqzfAveTRk6vhi?=
 =?us-ascii?Q?QNpHO1v+RY7COf7djZi/DHEXnvDq0PxNUvi1yjjXv6NXWElsQHhl6zGpBdAZ?=
 =?us-ascii?Q?I8PqTiXl9UrjIrdHewXy/KycjWGlDSblYwpEa6GSYGnLGosGyKzZveB0IQmj?=
 =?us-ascii?Q?22sr5EEdW+ut/hN0gkgxQD+REslFsmpRu2mYjMdxfi/8PlkStXChk0/vXZrQ?=
 =?us-ascii?Q?BtLND4mJ+Tx5SusybkRD3YLVhj+H4kFfgEinGmnYW0dwt2s+4n3G1AlmoadM?=
 =?us-ascii?Q?VF9LTjW/9YRau5M+evuyl4Q8z84KXjWqav/ES1j2tS5msO5eOJVPme/6AjY0?=
 =?us-ascii?Q?kjvKHPHw8IEQR6KzuaMgGXNmQXfhX9nUX5ZAxk97rpOP9yheoq3Hm2zVlkPp?=
 =?us-ascii?Q?WU1x5rW3Juz3/bxEW2hMQKcthHsxyXC3aIgpOJv+1UgA7OGtS8IEuv86/5Dm?=
 =?us-ascii?Q?B1ylw8Elvc7l7Na6ryx99Eq15iLMywynfDactyKKc/guqqm++ZafKc6QbPfB?=
 =?us-ascii?Q?hgkwryqzqmEk3wpqiMPEb9pT6wYxaD2xMF9nsWhuAA+1XOlcJTVkTtqE911S?=
 =?us-ascii?Q?AAB1bATsLj2q+NojvyQRbsu4wFWJmmQNsqdOeelncCUHSRBY8HXKSWiaxDWb?=
 =?us-ascii?Q?pNNuUM9b37QlipYLvQwjPR4hRAlxIGXv+XJPSDxs96sKACalIKs/QYHNCIGZ?=
 =?us-ascii?Q?yEIYLZ1mNHIhiIcUrEtxk2iUROH5pzP6JZymNwfJ1nfZdOC5FDVuS5532i0y?=
 =?us-ascii?Q?17bGMLbkP1xX7JPsad/22Dh0m8pFhlPy1LbTRCIlgssFfcxzHL3iR/D4zdaA?=
 =?us-ascii?Q?Hfuk02GOoCyyiQWNlJriR/q2Sezj6Y/Od/38S9exojUkd9xa9X+SYsKOL2jU?=
 =?us-ascii?Q?AQF8svSI7Wkbl8A8s1wMNWNRaffJPzBBl5KdvtkaclZ4DByM5tSLOKiaVCMa?=
 =?us-ascii?Q?2Q2eZ+AohAChWuXTB9Qq+lztKJGJ7mTxJO2ToyBCfKKFruswOw9taxlitdim?=
 =?us-ascii?Q?47XKBD5hSIkWsWKm2v+hOQ+ck4mkKsAEKpJkJ4tTsP/hiCm5GhEuhx4FOBQf?=
 =?us-ascii?Q?A59oL+Dt77I2JWHLR00qaVnTE/udbyi1LQBiJ7m+epqycbU8YOW5W8L7NUNf?=
 =?us-ascii?Q?Zby6OtyjxNvhjrS4WRn/BR+wW2EcsyL7aVJEQxXz0FP9oyEbaDs2WHdWeOGt?=
 =?us-ascii?Q?yBndTy7SFuc/EirZG0woX02p9vwozbzFevs9DACQjDVG2N6R8s9ZDdj292i8?=
 =?us-ascii?Q?mPcxojb9FMbJxwNpVBIqROysqfTcQFR2EL0udGqPnCKR2Nfgq0/dC6cdoJWr?=
 =?us-ascii?Q?YnfAfinzzql8JoWNerwEHM/lmoZK7L6pcWBmoN0NXrS15qfTC6cpun0C4vOA?=
 =?us-ascii?Q?tWr7UuLY1uTOC66qyDC1aZr2LCGmIQ53rSBQkEtM45dQ4bFK1IKXSjtjuOzU?=
 =?us-ascii?Q?onwXZ3ftJetFKTpYBHNVKsQnrlyAKfWGU2KZbuInaQtx7EfJsaIbymgVLPWY?=
 =?us-ascii?Q?a9ZrLJq7fQyBWlB8cazGh8g=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d9e371-1d5c-4dfb-e339-08dde00384d7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:27.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6HDCz6215wUV3OB5WZ4uoJ8qnhtjl+D4G40VLdbfgU1l8Q7o1CTurzTj+NFgvpVkByR5OMZGyvkstDy4tB5kGEuENm3nVK3SYLpA2ipkDN2/utx9/W7ze3cK4JWGhr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19868

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1d1e564fce1bc361af1a1980a7f915a0475a008a upstream.

The CRU block on the Renesas RZ/G3E SoC is similar to the one found on
the Renesas RZ/G2L SoC, with the following differences:

- Additional registers rzg3e_cru_regs.
- A different irq handler rzg3e_cru_irq.
- A different rzg3e_cru_csi2_setup.
- A different max input width.
- Additional stride register.

Introduce rzg3e_cru_info struct to handle differences between RZ/G2L
and RZ/G3E and related RZ/G3E functions:

 - rzg3e_cru_enable_interrupts()
 - rzg3e_cru_enable_interrupts()
 - rz3e_fifo_empty()
 - rzg3e_cru_csi2_setup()
 - rzg3e_cru_get_current_slot()

Add then support for the RZ/G3E SoC CRU block with the new compatible
string "renesas,r9a09g047-cru".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-18-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[Tommaso: Squashed the commits e5dd01ea9610("media: renesas: rzg2l-cru:
	  Fix typo in rzg3e_fifo_empty name") and 095e5d400cbf("media:
	  rzg2l-cru: Fix typo in rzg2l_cru_of_id_table struct") and
	  9e6038904151("media: renesas: rzg2l-cru: Simplify FIFO empty
	  check")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  60 ++++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        |  25 +++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  13 ++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 170 +++++++++++++++++-
 4 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 459644e5af0c..0274873c5fe9 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -321,6 +321,58 @@ static int rzg2l_cru_remove(struct platform_device *pd=
ev)
 	return 0;
 }
=20
+static const u16 rzg3e_cru_regs[] =3D {
+	[CRUnCTRL] =3D 0x0,
+	[CRUnIE] =3D 0x4,
+	[CRUnIE2] =3D 0x8,
+	[CRUnINTS] =3D 0xc,
+	[CRUnINTS2] =3D 0x10,
+	[CRUnRST] =3D 0x18,
+	[AMnMB1ADDRL] =3D 0x40,
+	[AMnMB1ADDRH] =3D 0x44,
+	[AMnMB2ADDRL] =3D 0x48,
+	[AMnMB2ADDRH] =3D 0x4c,
+	[AMnMB3ADDRL] =3D 0x50,
+	[AMnMB3ADDRH] =3D 0x54,
+	[AMnMB4ADDRL] =3D 0x58,
+	[AMnMB4ADDRH] =3D 0x5c,
+	[AMnMB5ADDRL] =3D 0x60,
+	[AMnMB5ADDRH] =3D 0x64,
+	[AMnMB6ADDRL] =3D 0x68,
+	[AMnMB6ADDRH] =3D 0x6c,
+	[AMnMB7ADDRL] =3D 0x70,
+	[AMnMB7ADDRH] =3D 0x74,
+	[AMnMB8ADDRL] =3D 0x78,
+	[AMnMB8ADDRH] =3D 0x7c,
+	[AMnMBVALID] =3D 0x88,
+	[AMnMADRSL] =3D 0x8c,
+	[AMnMADRSH] =3D 0x90,
+	[AMnAXIATTR] =3D 0xec,
+	[AMnFIFOPNTR] =3D 0xf8,
+	[AMnAXISTP] =3D 0x110,
+	[AMnAXISTPACK] =3D 0x114,
+	[AMnIS] =3D 0x128,
+	[ICnEN] =3D 0x1f0,
+	[ICnSVCNUM] =3D 0x1f8,
+	[ICnSVC] =3D 0x1fc,
+	[ICnIPMC_C0] =3D 0x200,
+	[ICnMS] =3D 0x2d8,
+	[ICnDMR] =3D 0x304,
+};
+
+static const struct rzg2l_cru_info rzg3e_cru_info =3D {
+	.max_width =3D 4095,
+	.max_height =3D 4095,
+	.image_conv =3D ICnIPMC_C0,
+	.has_stride =3D true,
+	.regs =3D rzg3e_cru_regs,
+	.irq_handler =3D rzg3e_cru_irq,
+	.enable_interrupts =3D rzg3e_cru_enable_interrupts,
+	.disable_interrupts =3D rzg3e_cru_disable_interrupts,
+	.fifo_empty =3D rzg3e_fifo_empty,
+	.csi_setup =3D rzg3e_cru_csi2_setup,
+};
+
 static const u16 rzg2l_cru_regs[] =3D {
 	[CRUnCTRL] =3D 0x0,
 	[CRUnIE] =3D 0x4,
@@ -354,7 +406,7 @@ static const u16 rzg2l_cru_regs[] =3D {
 	[ICnDMR] =3D 0x26c,
 };
=20
-static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+static const struct rzg2l_cru_info rzg2l_cru_info =3D {
 	.max_width =3D 2800,
 	.max_height =3D 4095,
 	.image_conv =3D ICnMC,
@@ -367,9 +419,13 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D =
{
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
+	{
+		.compatible =3D "renesas,r9a09g047-cru",
+		.data =3D &rzg3e_cru_info,
+	},
 	{
 		.compatible =3D "renesas,rzg2l-cru",
-		.data =3D &rzgl2_cru_info,
+		.data =3D &rzg2l_cru_info,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
index fc0fd0c97c86..a5a57369ef0e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -14,8 +14,13 @@
=20
 #define CRUnIE_EFE			BIT(17)
=20
+#define CRUnIE2_FSxE(x)			BIT(((x) * 3))
+#define CRUnIE2_FExE(x)			BIT(((x) * 3) + 1)
+
 #define CRUnINTS_SFS			BIT(16)
=20
+#define CRUnINTS2_FSxS(x)		BIT(((x) * 3))
+
 #define CRUnRST_VRESETN			BIT(0)
=20
 /* Memory Bank Base Address (Lower) Register for CRU Image Data */
@@ -32,7 +37,14 @@
 #define AMnAXIATTR_AXILEN		(0xf)
=20
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
+#define AMnFIFOPNTR_FIFOWPNTR_B0	AMnFIFOPNTR_FIFOWPNTR
+#define AMnFIFOPNTR_FIFOWPNTR_B1	GENMASK(15, 8)
 #define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
+#define AMnFIFOPNTR_FIFORPNTR_B0	AMnFIFOPNTR_FIFORPNTR_Y
+#define AMnFIFOPNTR_FIFORPNTR_B1	GENMASK(31, 24)
+
+#define AMnIS_IS_MASK			GENMASK(14, 7)
+#define AMnIS_IS(x)			((x) << 7)
=20
 #define AMnAXISTP_AXI_STOP		BIT(0)
=20
@@ -40,6 +52,11 @@
=20
 #define ICnEN_ICEN			BIT(0)
=20
+#define ICnSVC_SVC0(x)			(x)
+#define ICnSVC_SVC1(x)			((x) << 4)
+#define ICnSVC_SVC2(x)			((x) << 8)
+#define ICnSVC_SVC3(x)			((x) << 12)
+
 #define ICnMC_CSCTHR			BIT(5)
 #define ICnMC_INF(x)			((x) << 16)
 #define ICnMC_VCSEL(x)			((x) << 22)
@@ -52,7 +69,9 @@
 enum rzg2l_cru_common_regs {
 	CRUnCTRL,	/* CRU Control */
 	CRUnIE,		/* CRU Interrupt Enable */
+	CRUnIE2,	/* CRU Interrupt Enable(2) */
 	CRUnINTS,	/* CRU Interrupt Status */
+	CRUnINTS2,	/* CRU Interrupt Status(2) */
 	CRUnRST,	/* CRU Reset */
 	AMnMB1ADDRL,	/* Bank 1 Address (Lower) for CRU Image Data */
 	AMnMB1ADDRH,	/* Bank 1 Address (Higher) for CRU Image Data */
@@ -72,12 +91,18 @@ enum rzg2l_cru_common_regs {
 	AMnMB8ADDRH,    /* Bank 8 Address (Higher) for CRU Image Data */
 	AMnMBVALID,	/* Memory Bank Enable for CRU Image Data */
 	AMnMBS,		/* Memory Bank Status for CRU Image Data */
+	AMnMADRSL,	/* VD Memory Address Lower Status Register */
+	AMnMADRSH,	/* VD Memory Address Higher Status Register */
 	AMnAXIATTR,	/* AXI Master Transfer Setting Register for CRU Image Data */
 	AMnFIFOPNTR,	/* AXI Master FIFO Pointer for CRU Image Data */
 	AMnAXISTP,	/* AXI Master Transfer Stop for CRU Image Data */
 	AMnAXISTPACK,	/* AXI Master Transfer Stop Status for CRU Image Data */
+	AMnIS,		/* Image Stride Setting Register */
 	ICnEN,		/* CRU Image Processing Enable */
+	ICnSVCNUM,	/* CRU SVC Number Register */
+	ICnSVC,		/* CRU VC Select Register */
 	ICnMC,		/* CRU Image Processing Main Control */
+	ICnIPMC_C0,	/* CRU Image Converter Main Control 0 */
 	ICnMS,		/* CRU Module Status */
 	ICnDMR,		/* CRU Data Output Mode */
 	RZG2L_CRU_MAX_REG,
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 0c73e1ee415b..cd14ac40408c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -85,6 +85,7 @@ struct rzg2l_cru_info {
 	unsigned int max_height;
 	u16 image_conv;
 	const u16 *regs;
+	bool has_stride;
 	irqreturn_t (*irq_handler)(int irq, void *data);
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
@@ -108,6 +109,8 @@ struct rzg2l_cru_info {
  * @vdev:		V4L2 video device associated with CRU
  * @v4l2_dev:		V4L2 device
  * @num_buf:		Holds the current number of buffers enabled
+ * @svc_channel:	SVC0/1/2/3 to use for RZ/G3E
+ * @buf_addr:		Memory addresses where current video data is written.
  * @notifier:		V4L2 asynchronous subdevs notifier
  *
  * @ip:			Image processing subdev info
@@ -144,6 +147,9 @@ struct rzg2l_cru_dev {
 	struct v4l2_device v4l2_dev;
 	u8 num_buf;
=20
+	u8 svc_channel;
+	dma_addr_t buf_addr[RZG2L_CRU_HW_BUFFER_DEFAULT];
+
 	struct v4l2_async_notifier notifier;
=20
 	struct rzg2l_cru_ip ip;
@@ -175,6 +181,7 @@ void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru=
);
 int rzg2l_cru_video_register(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_video_unregister(struct rzg2l_cru_dev *cru);
 irqreturn_t rzg2l_cru_irq(int irq, void *data);
+irqreturn_t rzg3e_cru_irq(int irq, void *data);
=20
 const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
=20
@@ -188,10 +195,16 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_=
to_fmt(u32 index);
=20
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg3e_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg3e_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+bool rzg3e_fifo_empty(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
 			  const struct rzg2l_cru_ip_format *ip_fmt,
 			  u8 csi_vc);
+void rzg3e_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
=20
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a1d4ef07a00f..a3c7c8fac337 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -31,6 +31,9 @@
 #define RZG2L_CRU_DEFAULT_FIELD		V4L2_FIELD_NONE
 #define RZG2L_CRU_DEFAULT_COLORSPACE	V4L2_COLORSPACE_SRGB
=20
+#define RZG2L_CRU_STRIDE_MAX		32640
+#define RZG2L_CRU_STRIDE_ALIGN		128
+
 struct rzg2l_cru_buffer {
 	struct vb2_v4l2_buffer vb;
 	struct list_head list;
@@ -184,6 +187,8 @@ static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_de=
v *cru,
 	/* Currently, we just use the buffer in 32 bits address */
 	rzg2l_cru_write(cru, AMnMBxADDRL(slot), addr);
 	rzg2l_cru_write(cru, AMnMBxADDRH(slot), 0);
+
+	cru->buf_addr[slot] =3D addr;
 }
=20
 /*
@@ -224,6 +229,7 @@ static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev=
 *cru, int slot)
=20
 static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	unsigned int slot;
 	u32 amnaxiattr;
=20
@@ -236,12 +242,39 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru=
_dev *cru)
 	for (slot =3D 0; slot < cru->num_buf; slot++)
 		rzg2l_cru_fill_hw_slot(cru, slot);
=20
+	if (info->has_stride) {
+		u32 stride =3D cru->format.bytesperline;
+		u32 amnis;
+
+		stride /=3D RZG2L_CRU_STRIDE_ALIGN;
+		amnis =3D rzg2l_cru_read(cru, AMnIS) & ~AMnIS_IS_MASK;
+		rzg2l_cru_write(cru, AMnIS, amnis | AMnIS_IS(stride));
+	}
+
 	/* Set AXI burst max length to recommended setting */
 	amnaxiattr =3D rzg2l_cru_read(cru, AMnAXIATTR) & ~AMnAXIATTR_AXILEN_MASK;
 	amnaxiattr |=3D AMnAXIATTR_AXILEN;
 	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
+void rzg3e_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc)
+{
+	const struct rzg2l_cru_info *info =3D cru->info;
+	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
+
+	icnmc |=3D rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_INF_MASK;
+
+	/* Set virtual channel CSI2 */
+	icnmc |=3D ICnMC_VCSEL(csi_vc);
+
+	rzg2l_cru_write(cru, ICnSVCNUM, csi_vc);
+	rzg2l_cru_write(cru, ICnSVC, ICnSVC_SVC0(0) | ICnSVC_SVC1(1) |
+			ICnSVC_SVC2(2) | ICnSVC_SVC3(3));
+	rzg2l_cru_write(cru, info->image_conv, icnmc);
+}
+
 void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
 			  const struct rzg2l_cru_ip_format *ip_fmt,
 			  u8 csi_vc)
@@ -290,6 +323,19 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 	return 0;
 }
=20
+bool rzg3e_fifo_empty(struct rzg2l_cru_dev *cru)
+{
+	u32 amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
+
+	if ((((amnfifopntr & AMnFIFOPNTR_FIFORPNTR_B1) >> 24) =3D=3D
+	     ((amnfifopntr & AMnFIFOPNTR_FIFOWPNTR_B1) >> 8)) &&
+	    (((amnfifopntr & AMnFIFOPNTR_FIFORPNTR_B0) >> 16) =3D=3D
+	     (amnfifopntr & AMnFIFOPNTR_FIFOWPNTR_B0)))
+		return true;
+
+	return false;
+}
+
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 {
 	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
@@ -299,8 +345,6 @@ bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 	amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
 	amnfifopntr_r_y =3D
 		(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
-	if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
-		return true;
=20
 	return amnfifopntr_w =3D=3D amnfifopntr_r_y;
 }
@@ -401,6 +445,20 @@ static int rzg2l_cru_get_virtual_channel(struct rzg2l_=
cru_dev *cru)
 	return fd.entry[0].bus.csi2.vc;
 }
=20
+void rzg3e_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE2, CRUnIE2_FSxE(cru->svc_channel));
+	rzg2l_cru_write(cru, CRUnIE2, CRUnIE2_FExE(cru->svc_channel));
+}
+
+void rzg3e_cru_disable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnIE2, 0);
+	rzg2l_cru_write(cru, CRUnINTS, rzg2l_cru_read(cru, CRUnINTS));
+	rzg2l_cru_write(cru, CRUnINTS2, rzg2l_cru_read(cru, CRUnINTS2));
+}
+
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
 {
 	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
@@ -423,6 +481,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	if (ret < 0)
 		return ret;
 	csi_vc =3D ret;
+	cru->svc_channel =3D csi_vc;
=20
 	spin_lock_irqsave(&cru->qlock, flags);
=20
@@ -601,6 +660,104 @@ irqreturn_t rzg2l_cru_irq(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
=20
+static int rzg3e_cru_get_current_slot(struct rzg2l_cru_dev *cru)
+{
+	u64 amnmadrs;
+	int slot;
+
+	/*
+	 * When AMnMADRSL is read, AMnMADRSH of the higher-order
+	 * address also latches the address.
+	 *
+	 * AMnMADRSH must be read after AMnMADRSL has been read.
+	 */
+	amnmadrs =3D rzg2l_cru_read(cru, AMnMADRSL);
+	amnmadrs |=3D (u64)rzg2l_cru_read(cru, AMnMADRSH) << 32;
+
+	/* Ensure amnmadrs is within this buffer range */
+	for (slot =3D 0; slot < cru->num_buf; slot++) {
+		if (amnmadrs >=3D cru->buf_addr[slot] &&
+		    amnmadrs < cru->buf_addr[slot] + cru->format.sizeimage)
+			return slot;
+	}
+
+	dev_err(cru->dev, "Invalid MB address 0x%llx (out of range)\n", amnmadrs)=
;
+	return -EINVAL;
+}
+
+irqreturn_t rzg3e_cru_irq(int irq, void *data)
+{
+	struct rzg2l_cru_dev *cru =3D data;
+	u32 irq_status;
+	int slot;
+
+	scoped_guard(spinlock, &cru->qlock) {
+		irq_status =3D rzg2l_cru_read(cru, CRUnINTS2);
+		if (!irq_status)
+			return IRQ_NONE;
+
+		dev_dbg(cru->dev, "CRUnINTS2 0x%x\n", irq_status);
+
+		rzg2l_cru_write(cru, CRUnINTS2, rzg2l_cru_read(cru, CRUnINTS2));
+
+		/* Nothing to do if capture status is 'RZG2L_CRU_DMA_STOPPED' */
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STOPPED) {
+			dev_dbg(cru->dev, "IRQ while state stopped\n");
+			return IRQ_HANDLED;
+		}
+
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STOPPING) {
+			if (irq_status & CRUnINTS2_FSxS(0) ||
+			    irq_status & CRUnINTS2_FSxS(1) ||
+			    irq_status & CRUnINTS2_FSxS(2) ||
+			    irq_status & CRUnINTS2_FSxS(3))
+				dev_dbg(cru->dev, "IRQ while state stopping\n");
+			return IRQ_HANDLED;
+		}
+
+		slot =3D rzg3e_cru_get_current_slot(cru);
+		if (slot < 0)
+			return IRQ_HANDLED;
+
+		dev_dbg(cru->dev, "Current written slot: %d\n", slot);
+		cru->buf_addr[slot] =3D 0;
+
+		/*
+		 * To hand buffers back in a known order to userspace start
+		 * to capture first from slot 0.
+		 */
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STARTING) {
+			if (slot !=3D 0) {
+				dev_dbg(cru->dev, "Starting sync slot: %d\n", slot);
+				return IRQ_HANDLED;
+			}
+			dev_dbg(cru->dev, "Capture start synced!\n");
+			cru->state =3D RZG2L_CRU_DMA_RUNNING;
+		}
+
+		/* Capture frame */
+		if (cru->queue_buf[slot]) {
+			struct vb2_v4l2_buffer *buf =3D cru->queue_buf[slot];
+
+			buf->field =3D cru->format.field;
+			buf->sequence =3D cru->sequence;
+			buf->vb2_buf.timestamp =3D ktime_get_ns();
+			vb2_buffer_done(&buf->vb2_buf, VB2_BUF_STATE_DONE);
+			cru->queue_buf[slot] =3D NULL;
+		} else {
+			/* Scratch buffer was used, dropping frame. */
+			dev_dbg(cru->dev, "Dropping frame %u\n", cru->sequence);
+		}
+
+		cru->sequence++;
+
+		/* Prepare for next frame */
+		rzg2l_cru_fill_hw_slot(cru, slot);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int=
 count)
 {
 	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
@@ -784,7 +941,14 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_de=
v *cru,
 	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
 			      &pix->height, 240, info->max_height, 2, 0);
=20
-	pix->bytesperline =3D pix->width * fmt->bpp;
+	if (info->has_stride) {
+		u32 stride =3D clamp(pix->bytesperline, pix->width * fmt->bpp,
+				   RZG2L_CRU_STRIDE_MAX);
+		pix->bytesperline =3D round_up(stride, RZG2L_CRU_STRIDE_ALIGN);
+	} else {
+		pix->bytesperline =3D pix->width * fmt->bpp;
+	}
+
 	pix->sizeimage =3D pix->bytesperline * pix->height;
=20
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
--=20
2.43.0


