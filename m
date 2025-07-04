Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538CFC83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.47])
 by mx.groups.io with SMTP id smtpd.web11.8493.1751620109482704508
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SYjtHuOK;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nITKerL9v7NO+0g2D+w4JJVNabo/dKCahusZY870ytOJOcXp92USHTVYAPmz/rRNIdGjOnWm1QKSx76+yJKgk6vIdlCdDR09wwH1ygzrtz11Hyv9RuRNaK9MTvZLsP9134XQ+M39Z+rDMAq4IyXLWdCFZUfUi1ZAKn/mS7fIgmjD5hj8BHxsu2IcntZxuKzhAqN5ttY9yxcmgE/H3HfQkqawG6t45jfx51VTw0In2Huj+fg+DVP7IzFqh7bLhDXw+9t4eNGdz6kwGBq8k6uxQeDsmM5QNB4Sw+4J61thPWtOg+dUld1GXDSFQqjBohvWabGbljHOqDnXi12ZjFTVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l11/QqhPvOSE29qk2q+48NX/IZpKLlHC4S89nHVNny4=;
 b=ZE4GZNK858XRI4K7rKGXWwfEKdqCH//jpXNwGRs6HA7mGCksvPEHVIBWZ3eEONWX/FGRUZuOQ7Vala+SyiE3IMm3ccwKqpMj/mTTHqiDu9LcTwrAbFelZygWiSKEUf2RijQc7b1ITfbe9wDRYN6d7Szgk2gf0QPs9zxBG99kW7Xmtwz/WE4JkPSHX/k6iEyXPMer43WYEWIEkx7DclQmSQQMlc/uuikOedR8K7KDNZwc2VWdhgvAQy54yu3Wpgup6eO5R9nvXOJ30ceA1htQygz75gsw2HZ/XxY0NH4TpQvwZyo3fBdB4Y/KNK5QFI2rQuhMKlgFxB2CJLoOykQe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l11/QqhPvOSE29qk2q+48NX/IZpKLlHC4S89nHVNny4=;
 b=SYjtHuOK+zpiLgAGjDTYkCrfiC2bjC5COXrQRdn8MqWHjSgSyxAWBsL1HDeMd2ac9LVT09tMrkycc9rcNxVofWXUiyDDeHRJKLuLpSWBXvFQQ9mpPrfoYue1lS8UJJbtSM+imDNETadj4NBZ7de1K4zPN1Lzrgz26knNWOlOsx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:27 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/18] irqchip/renesas-rzv2h: Update TSSR_TIEN macro
Date: Fri,  4 Jul 2025 11:07:20 +0200
Message-ID: <20250704090724.669848-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb0b209a-edfc-4e5b-a70d-08ddbada5649
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LaaLGIB1GicpAtKcI8EOxJ0bz5TeREiOVNsM3+S0dYqHQl0SV6bhJyua34+H?=
 =?us-ascii?Q?yRevFGJRzmuT8VVG0XklInyDhYPMQIK/CVkgiSWv06gODtAN8G29Aam7zn6Z?=
 =?us-ascii?Q?C8QILu2j/JM/kDgrnsSdcxP31L9KQSRA7seSK/fLqT2GhWisBdOTGZJK/8EM?=
 =?us-ascii?Q?TP67F2gGXJ3OhhcBrzrXOoKRuw60567PCDOFaqurFDiaX/edck30IPI1rudq?=
 =?us-ascii?Q?fWelgLzFqmZOgTXzuRfuAF0AyTlzFbnJCGnJ7Pkdi3OM6/tv8TFrf6wkAhiC?=
 =?us-ascii?Q?vNFYRJJkLmYHEQSzk9nzwIWGJ5Ft43W4eQeC8JYSYMxZVimXx1RRzlZwz6D0?=
 =?us-ascii?Q?ufn89p02TeC2GqNjk63sX1MyQihEGFYJHRrXkpfMhbllZi1OJiZHY/Zk4Izg?=
 =?us-ascii?Q?BxFqyyQ9uItf6j068TOJQL2tm1k8gK4s1ImjKVP6OHhPSuZP9jsFCquVCF4O?=
 =?us-ascii?Q?owSuU4IOCrlCvFHQ84wwy8DRTLI6r+B+0C+D6adf8D1XN4Yl/YbTmxIxmClC?=
 =?us-ascii?Q?jUTp/lK3WjinnnvfgZh9Twk/+JmRe+qlPIPEPqIa2JbiaWas1mjmjjrqdJIZ?=
 =?us-ascii?Q?aUtJnfu6QKpKmZcXxJEs5v60ZCUyHqT3joDx55NF1ymAqKEJlzsuqlivCd2h?=
 =?us-ascii?Q?SgUi9xXQE+UqYELCxzHoDQEZHWWbgrDuGxjN+f9XAEgwiXHVQJij5PK6mcql?=
 =?us-ascii?Q?DiRGmvvBNDr+HRHxRHFh5EAgRjkKpzI7LgVBVwhpFnA+kajOdw/hEU4HYcUA?=
 =?us-ascii?Q?2RuYzfaJ/E78yqQIzj4TGCojNwCeuPoJ9Wwx8lSyZTVdf8UVWszOYSPkPxcP?=
 =?us-ascii?Q?b+FBQ+sqFzyXND+bHr7RxC6W45NBlcv7CA+BUrZ9B63X/oXr1kLQSgbNeOO3?=
 =?us-ascii?Q?59Xagi7f1kh6b+nwwYWORHUovRnkDmzoD6FkodLzCJ0zM6fIfZnTB2NfBJ/Q?=
 =?us-ascii?Q?dOKkGvnue7TbI8aWcsv++5n29rSPhf9m+S4xzfLhzOi3K4vJgTPBy+lTAXHg?=
 =?us-ascii?Q?l50QDFqqeuaDvuP8GoST7eQ1ESzs6VZ0P5CizZMlF56un5t968o5m74dp25H?=
 =?us-ascii?Q?u5RNnLl9c2emUnpC+8kQBnvDW/8BrpUkxUMlqWI0jMtMtFVd6p7XvyJjjfXk?=
 =?us-ascii?Q?cZ+0Y3rhOhCd3GdxsPRJaChow4DOBDbMpJ5kkyHbSyytN2/SOGnI6RjUNQbA?=
 =?us-ascii?Q?1XnFddjfY2xYu1YfjxaDAdtoJJwK5js3NPaRq+NBB7Ncr1GvXlOzEuafLY6t?=
 =?us-ascii?Q?V4o8ILgDEAi2v7nhauDVuJmX9Q5UY/x+Ud4a4U7kAop9sH1IiAxAMggVVyP/?=
 =?us-ascii?Q?YKH4TltTPMmng08K8IWzOC0mBiTzS8MzzEG3bxNqo6aSsmEdcloJkffoxXpR?=
 =?us-ascii?Q?q2kk4FGEeS2X5kQPBnUROUPxF+HoG3ZzS47Z6CFduKqxaoH62eFuhpiDYxVg?=
 =?us-ascii?Q?lrgwxLu4Aj+4IYNYbQOygouH7/E7UbFmoT5OoTt9RokjD18a0nFUguNW3hJb?=
 =?us-ascii?Q?ovxpJ6AWjSkoboI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g+Nv0tzobd21FhBrS5c5lpNfhkqMyhxsYq2pcdAUcjsGRWIp8tck4mtOg6Mt?=
 =?us-ascii?Q?DJ48mBadCrfzJSR2sMVgsigoJGNrldQHMcUfrMKjVyDEWjQSa+u5p500MCEr?=
 =?us-ascii?Q?+ISOcRVw3GecgxqaWqhSlXg8zpnaqfwV6d8UR+mhiPcG6NDX9YpsAVbWEV/7?=
 =?us-ascii?Q?0YatKOPcBcgkzrxdJL1kRbhO//3pptLe6/9+mAdqqyxkJV3pHbMUrjqTTKS/?=
 =?us-ascii?Q?IBJYjImg3i5uCaOy2LoOXgQxbq8udBEPy0DC8FQ+fQGD2V82+Ijk2EKbWXbT?=
 =?us-ascii?Q?KznkcV9kkxcb/EVDpMYmFz2WJVzJhZ2z9PPq23P7N6byKvA/PJQ7sWJmYK6y?=
 =?us-ascii?Q?78D/WchXeZvs/WjE7/vNku48UcD08cMlB8HqXnVRuJJ7oZSe62DmxtaFOWfq?=
 =?us-ascii?Q?jcIcH2R67YPc9PlN+SaroETORxEAknSZfvD5LBR81DL+dFtNg3Bgqvzk8fn3?=
 =?us-ascii?Q?i3xn0GWQbe6EILFcGqPTP+f0YQkiojCm9Cho/i4apik0Ow6c6F7FOAGFEsCT?=
 =?us-ascii?Q?wz0tnsUVWCjpTxNY1IT0kXHei9MbQ/FEnOY6yXRF0r0ADm8Kn3Fp3vO7BsDX?=
 =?us-ascii?Q?moxsm74JLQCYy6FHhrvvXDe9MWSGf+oK5FAUbBf4ppSwGAzlWqKlP6tP2fNG?=
 =?us-ascii?Q?jn4QHTY34mxWi+yX+hMkT4y9Yk/e+xzIQo2LArpwhg+AgLX5pTf4U7Zn1XFk?=
 =?us-ascii?Q?TMydHE520WiJYetRQlStp2zgAJE6IiuvEc64b9ldDk5eseOEQv1zJhVyMLLA?=
 =?us-ascii?Q?HmOh+S1W3mcfH3uRvtdT1Pl+VFot8LLFs8nXGnkDLVOBx0AUuhKnepFlhebO?=
 =?us-ascii?Q?fw7zMb/Q0JR6VMO3n9fe2CWTNOn7bzP7uYztymjEthZQVhHxBYZssxUR1bEh?=
 =?us-ascii?Q?QVji+DOpdAhD/6PivglvkAGCPXruCyybne89XgdmhxS2mFkNmAWjz6rMTJ+l?=
 =?us-ascii?Q?NPaerTedYfb/wPjmeRcy1ymVewDeMxz72t3wm54lE58/ZU7R8nO8RwvLNXgU?=
 =?us-ascii?Q?yt64XRGBYhfnw/5zK5B7hFpN15+62ntRtDAYNvzmQFtyYMwy5YnPC9EbEgdH?=
 =?us-ascii?Q?cv+0lWQapslK1DJop7UIgeylQV4earHSTHB5Kx/x7rfsEvVGSi2E2xcPL/aT?=
 =?us-ascii?Q?oM/u4Ekl4pfXY7oVgbeGtcV84wMRHy5xOnynoQRUmY8r9O0H+7b3/mVfOY7Z?=
 =?us-ascii?Q?7advqOATZa5GJH18XjJQZdkwrzbwzGz/4pXtBLu7HDD488N5hw+TK4EfhZgu?=
 =?us-ascii?Q?59e4QY0Bdg88h3Gs48KKQWLktIrYZzv70kB/VLlKSxAYBx6MiZdFL2bm/hCu?=
 =?us-ascii?Q?w6rQWme+9OVVbl7p6Ctf6MGCITF/vKil7vsPVKWARUbZIwFUNVzTBT3Djqcu?=
 =?us-ascii?Q?8JmfOjIsS+l7CgmZ2Rywc80fT3veDeQ9rcB6MYDuNsE8AmBL1tH1PM2rYFnO?=
 =?us-ascii?Q?3c7fwGeicLwGYM4gf0N0PWgFnTQy3cvb46WZTs7TyAufgIqO+FxuAvSmCEkr?=
 =?us-ascii?Q?EZMEAFYz7OM+fdpUP3rnyEs0IwXJTxLZamAO++jw++Qx+HGTNMO6OQ2bc2RI?=
 =?us-ascii?Q?WtzyoyOkCc2ux9gLjRwleKoP2I3/qtGs57aIi5Q2VFr1n0mVjtmounQdaYce?=
 =?us-ascii?Q?Y0M5i43iE2QCqDvN3z2cbh4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0b209a-edfc-4e5b-a70d-08ddbada5649
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:27.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvFKWw8vwRwtStTQuCNmouZB/AiUtrn7L+Z06eZRkXKiY0cRwevX+y+xTo4/qpC4RO6YkpGkNycC6nl+5zF4tY2hlUD7KDxS0kKyIso8+L60DBQVnIlqPSxyHiz0U0dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19358

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 76c3b774734feb8224b78721e0c67a54760a75c5 upstream.

On RZ/G3E, TIEN bit position is at 15 compared to 7 on RZ/V2H. Replace the
macro ICU_TSSR_TIEN(n)->ICU_TSSR_TIEN(n, _field_width) for supporting both
these SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-11-biju.das.jz@bp.r=
enesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 98a6a7cd3611..8d0bd4d69de2 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -66,7 +66,11 @@
=20
 #define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
 #define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
-#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+#define ICU_TSSR_TIEN(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) =3D (field_width); \
+		BIT((_field_width) - 1) << ((n) * (_field_width)); \
+})
=20
 #define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
 #define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
@@ -153,9 +157,9 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d=
, bool enable)
 	guard(raw_spinlock)(&priv->lock);
 	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
-		tssr |=3D ICU_TSSR_TIEN(tssel_n);
+		tssr |=3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	else
-		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
+		tssr &=3D ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
=20
@@ -314,7 +318,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	nr_tint =3D 32 / priv->info->field_width;
 	tssr_k =3D tint_nr / nr_tint;
 	tssel_n =3D tint_nr % nr_tint;
-	tien =3D ICU_TSSR_TIEN(tssel_n);
+	tien =3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
--=20
2.43.0


