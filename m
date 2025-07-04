Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61278C83F05
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:26 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.4])
 by mx.groups.io with SMTP id smtpd.web10.8431.1751620104671520533
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=E3IkUp61;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b56PqXRRfnoYDfsNQw89tcdGYGOwghUtT4xumB1VOSm45tUJ8+p1/9s9I1suZQsVUWE4dUAwkt7QqQRpj45P5Pi/rOXQ+OmE2NwJMv4Sr1X4hbgSixPoREWERiyXX4nZ7OqLm4eGuo/Y4bOYtfpR+izuVH7pdHqo33TUykQNEpC4qPwd9a4I/nLyCOhEQE69ISaQmj2kh3IXoz5YsKrCC3j3f/xHhwDzVD13NTHlIS+KkDPrqch0ZWTjEyHDsNYaJgY0/cU6mUPyA96l2EKveKiWf9RgHbygHFDus1SsZ13xXBNWScqbvGQLZcNY5idHo0M7rSErceLU+zvl4yCFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pDSvKwBkGELdkbznbc0r0CoH3G8CcwjQDjpz3ALAwM=;
 b=yHNhpFMXF9Ne8my7OBqIkbuK9hZTAbHeVaFtilV3uewMhWYuy7fjD5LTwbtZ+rgo9ey0yiPgI8xQFeLVwCv2hwEaPV+JpwEpivZhKRXvVu8/lpun/AT1aL/kBFkbUXVCILagdtebdSW+oxXGYFphbgWz80ySJ9F0o/PE9a9ZyaVu5i1JZHWfaqIZ2iflcqCdTRC9/JgacN2RqsqIrUso3T7O6VqNbvaFNJRtjd2MVVVq1wSXYYNDrkFVY4Qv0ggpSYsnXOnLScXf62HdUYmATI/MkSFt7ycI4kVA5kN8b96M2A+iAQpSEmqNkeRvaXaqtlMmCaTYwanGC3UU0Sfcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pDSvKwBkGELdkbznbc0r0CoH3G8CcwjQDjpz3ALAwM=;
 b=E3IkUp61AFsPvniYK7nf8KuJS/idIl33jpI5JBNPITJmYEsUxDgIcezb1A1YJZWCqhehwChqsvdE7tCUBxWqoIRiEPUi+jpylMIJWZoBfNpz9fyU/DXceVG+eNySoRGQ/N3KcNvWR3N5lbSBhJuY1dXheuvbStiq/yRmtxQ7OZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/18] irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
Date: Fri,  4 Jul 2025 11:07:18 +0200
Message-ID: <20250704090724.669848-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a4d28b-9456-4d3e-e176-08ddbada52e9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ndbn5aVI9MhyQ6JqNkML0OQDAmDKi3qyUTHX2Fnkqe6cryEEOHfb4HaLHG8C?=
 =?us-ascii?Q?kP8zsI/aSmTxFJtfjxeuH6eUQBJxBchBxs9JAYuE7yr58HI7xv12zEtCNvjb?=
 =?us-ascii?Q?3uswf5dt72S27XIZRDNdpnUbbm5J3/Sq5ryJv6wu+hk99mcXWb111I1G4lNu?=
 =?us-ascii?Q?7VNXZVDq9WI4iNMT8qesarNSZc+1L2/dbSHGKF316UKMMXxy6JT8EcjXq4XK?=
 =?us-ascii?Q?yzJF8usEbBcQf8jAl8EFLntzWR8tJmbHezRlIGGb4IT+/zuMsQFeGeEWscYL?=
 =?us-ascii?Q?KTpyQfXS/OUQeZmsv6YaNGA1GNnMASBZdJN3aflKMmqd+ONtryEQivtJ0H2e?=
 =?us-ascii?Q?++NqLjSi9EQ8NoSwW96kP9gPxklQhnGEKOzRcewN3rix78/K/M5hU2ej0bvu?=
 =?us-ascii?Q?f4eNjOhXPnOs60ygjdGkmHiAVb2Jwt4rhMy4CNyPNa1T+BkIGxq2M88Kgm4u?=
 =?us-ascii?Q?TCrFEYnURhGpyRL5Ue0/Y/VOr0c+orD1ThnCfj1a5BydfRmrFNvNnJyg1dw6?=
 =?us-ascii?Q?wmhU/6YDCcPr9aMShxOYt2iDOZ9nCTewW9iHAunqk8R8//mqGS5wcI8S1i3j?=
 =?us-ascii?Q?NhtDvb9N9dnJoNOLKz1+pUCWTtqXVlZWLiswjNab7lnQxYqCJX2ivz5G3yB0?=
 =?us-ascii?Q?/R9ehSBYEDLUhXWoMn95wiu1mYA3o5aCPeCzUzu4vLwl+O6e3dDbb0idq61Q?=
 =?us-ascii?Q?Baw+93kkL7B3xIhfr056Myjw0o5JJ7PS91Me9Ah/hM2i+CPMpnzwXKXKT0zG?=
 =?us-ascii?Q?Mp0kzTWBIFUyBJVbl57kRE6QLEnGm/s19aJOU5DlCT3AB233bhAIBEdrUwen?=
 =?us-ascii?Q?0D2MAc/eQXyR4ube5aCYmfboPeJ+bRn+S1kgLUvtYIehcAbhRhlySxUL9mOG?=
 =?us-ascii?Q?AuULuYTHdfR649oBsxVkscmNtFP/a1/+DxARxXVdyiVSD4tAQHS2PmpjYj/0?=
 =?us-ascii?Q?BLOYYDUtnCXqdHwyzB9eODqvlcTIq6TRkEQSrQDEOGsq+qnbPuguJFkHlqiB?=
 =?us-ascii?Q?rokQKErIxoeyEtfkHcpRDqU5IVIA5KaqoolCynqNMm9Ktq0FfwmVRvh6675W?=
 =?us-ascii?Q?nXxUbkJnNgHKBizm9yOjqkocbZrCxt6dZ6YPYLkaGHqTV1NAzuXgH90JKY06?=
 =?us-ascii?Q?UV90zuW4rgALLhhisXvstwkCtI0ZFnspOz7VHMmBBNq3FiT3VuoFa7libuaq?=
 =?us-ascii?Q?bWr74lvsJTwJofBiYm1jxvfX2e4sVGs1zDqLzMVIOUO2vsja/Ge90BTX1ciK?=
 =?us-ascii?Q?IFakiUkSdP6K+mMYx/HBkF6BtxphtwjGEcEt1iir/aI/mSPo/snq95wC5hS1?=
 =?us-ascii?Q?rGSAW3QL8pwrn/cpk+NE08j7PEXr9ti/uGc7LGYurVW2KhTNEtvsliw/PaOr?=
 =?us-ascii?Q?mM0DVacp6yKDnfVdCV+g9CRiCCDDKiJS+iN+NIYyo+kXNXjRZS1HyblC2InI?=
 =?us-ascii?Q?/wC6qCFGVzYM3mQfVmZz7u0MwZ0jMWvxcsMIxUyN4ynU04MPMLDIZI3N51K4?=
 =?us-ascii?Q?OXbzpH4yDou7IjY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FzXOnQ+NXwN1eLWn1Te5Oi9RHTRl5YyRb4P586K8vvh5+HZOAJnEtdKIEqBE?=
 =?us-ascii?Q?2tvS/vV/6ChJlPaRkIQuyzix/f/LpRTFXnSgSJSLPAMjWFidebBVLzVjNSz1?=
 =?us-ascii?Q?Po1enTohlle8L2s6t6QlhudctDE9m9SUjPhuSnPJufTnAagTcB73A9ysVMvH?=
 =?us-ascii?Q?EY0ZPGtEkZ88QYk9gNg3zUfUwaC9ka5eCPqq3ETkhk66PRiCp0ip9twQjtTy?=
 =?us-ascii?Q?gnLpCtcPkavmlurSIFmAqQ3YnjxcJvirXc3OuxfRnByL9XZTK9UTVsxcFWhW?=
 =?us-ascii?Q?PxaUcd13mNzSp9eyolsbvunn1xTrYkdkCUA97i+xhhgeHo54seOzFKAx+CzZ?=
 =?us-ascii?Q?nofsXxq9Sbnl0qmWg7szyfyEke7civzJzCSvUnQWKH5Of/XqZ6ioMm6f44cc?=
 =?us-ascii?Q?eCtzvPzmfwkHDSXpAqlX/Fh0VOPcJ12NV6UjfFrCuJRSUw6p3FW8bion5ZNC?=
 =?us-ascii?Q?yg6PpSHak8EUkGsGdJjDtNg3iSoHh//vOPZK7GffPX5tPFMURLdxIYowYa5K?=
 =?us-ascii?Q?ApxykcgZwpPnXxOtAmSlNtufEwqgVWty4TcVFy/+KrGG7Jz0EjxaUN+nquO4?=
 =?us-ascii?Q?BBSGAbegX/OXIXfOGmun0Px6HR3F6kOlkWq+AL0QF+g0AcV/ib3zQY69GhmC?=
 =?us-ascii?Q?ZmMOOsi/Jy4yj+ntLthWB+jg2iP0pQAl3ZbjuZlGNOPeUVZzk/ftYSSmmXqa?=
 =?us-ascii?Q?jQSby4K0qe9qfjIoPhLbrbCUp+fy0pRq7daT/eOc4wocDPjNzs5R2nLdtdDj?=
 =?us-ascii?Q?vpzZwdYCnz0p1W91UV4noOwEUGwmaz8WJRoBhmOjx/VdonYVFCmAQ0Mz4qhE?=
 =?us-ascii?Q?s2OPlgUBEZYq5puK0DDK4oxj60veT+sIoF+ZzmZw/U1F3BBMwrYW/M/ScNwd?=
 =?us-ascii?Q?ZxfYGxvqsJZ8C4xBsJH3A2ZG1m7LjEO0qbpOsFsSQQdumda5N3Y1TXjoCxPW?=
 =?us-ascii?Q?MzRZINdZh0snZNC+8+0dKy+GKsD70i5RLWnFAH7kcY8Rc0Q2/HuZzeuMSph7?=
 =?us-ascii?Q?XvA5CvDjUlabQytldkFJb+M2UbkA6+9LiBSdaIol8SPQr6xbtUbLX+KT+WhK?=
 =?us-ascii?Q?nYyMSAcLqdHdJEalypusFVkErrmfwGAQIJiYMZNB216n2j4nviEzUXzB2bG9?=
 =?us-ascii?Q?SQHL6x8b98xK2xgTV4AmlAunHGZa2qXzfVIXt3UwJGRUfXcl7cUXBYs8fUQa?=
 =?us-ascii?Q?8bhxYvVBKOQWgf3beb1+44KGffeTJLm9Fp9dnvWVLPWjpWzhBweNlAuzz8DS?=
 =?us-ascii?Q?94aY+EiYOuXgfc7czscyXhpDSm1SnTWXWwhc85l5M4xYXntDvgQSJu44aJJ8?=
 =?us-ascii?Q?fQUioVDhAS65r6RzqQqSqfi7bfTT/7jkHq3WHqvGt/EpOAptx9tKiat3mAXQ?=
 =?us-ascii?Q?ZDVDvQ2jJrlzcbYY8ujO8UOWuT4PuJ2M5teC1vAV2pscXc08X6+UHoX6Y7fw?=
 =?us-ascii?Q?6pBmmdW+G1gx9Nx9aUQGrxPuyPZk/VyKo1h9mbeLLsbo7ayKNlNBVRaKF0mz?=
 =?us-ascii?Q?Dr75S5H71eZ1UAt6YS29+rkp/xXKMhz+Xy4dPkZ3+iohzl9746U1+DwQvrX3?=
 =?us-ascii?Q?7O6hSqPsE+LFu96FTuj4khXBTcagRzRCAl/h64byV8fvJBFr9Dli/MXmievH?=
 =?us-ascii?Q?NnzzlXsGJF2SCqWMT6wIyTc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a4d28b-9456-4d3e-e176-08ddbada52e9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:21.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLhShQMMsHtR13kN2HEXnm7IL23GwSnyYgvbsLtQL+SgAlH/ddxh3/TxhK9s2Oc6FS/JAyKFijrJwdAJbnZFKIhuVdQdOtHI04gDWbeBZZk4Z3Rk9x3enZFLFc/KuMPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19356

From: Biju Das <biju.das.jz@bp.renesas.com>

commit eb23d23d082d097e2a8154a57da72061cb7e33b3 upstream.

The number of GPIO interrupts on RZ/G3E for TINT selection is 141 compared
to 86 on RZ/V2H. Rename the macro ICU_PB5_TINT->ICU_RZV2H_TSSEL_MAX_VAL to
hold this difference for RZ/V2H.

Add max_tssel to struct rzv2h_hw_info and replace the hardcoded constants
in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-9-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 43b805b6df94..2fae3274c015 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -78,14 +78,16 @@
=20
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
-#define ICU_PB5_TINT				0x55
+#define ICU_RZV2H_TSSEL_MAX_VAL			0x55
=20
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info =
structure.
  * @t_offs:		TINT offset
+ * @max_tssel:		TSSEL max value
  */
 struct rzv2h_hw_info {
 	u16		t_offs;
+	u8		max_tssel;
 };
=20
 /**
@@ -298,13 +300,12 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
 		return -EINVAL;
 	}
=20
+	priv =3D irq_data_to_priv(d);
 	tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
-	if (tint > ICU_PB5_TINT)
+	if (tint > priv->info->max_tssel)
 		return -EINVAL;
=20
-	priv =3D irq_data_to_priv(d);
 	hwirq =3D irqd_to_hwirq(d);
-
 	tint_nr =3D hwirq - ICU_TINT_START;
=20
 	tssr_k =3D ICU_TSSR_K(tint_nr);
@@ -517,6 +518,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
=20
 static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.t_offs		=3D 0,
+	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
 };
=20
 static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
--=20
2.43.0


