Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF92C35FFA
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.70])
 by mx.groups.io with SMTP id smtpd.web11.34817.1741778706981418923
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VmcJZrub;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHAAP95qp26frwVcBwTLhbIrZ1Cmxz5X6Mu2p20jWFqXz2eVWLrXkGDqL6DEe6m+k+aUqVwXE60VLcEH9Hi6Oqz2gUGEa3wscD0pEnkRTMH0XdUE8Mmq0+5nF3o+Of1hRR0CVhgljG5zpQhwxOc62w23I8SsylrdaTMilJH8Rq7m0ub4J2GbAHEUgJ+fd3SFqA/rtCfgtJsrJ0Fb5s0Foeq4DB8Vp898CZYr0yLrf7bREFNtO63htkVEoIMeMt2EVtiT/UP2pDWVNIiynBK7BINOXxqDUGdUbLIty5zHYOM1SEg8+GAJ4SHcVpJBu8WC+6bB3qMdSMXYj1G4xiw3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfrIm/W5TIAFwwJNMZTcfBJTucWT1u5KhLZyIoWpVfQ=;
 b=ZaAmYG/fOVxoplxp/yOf+GR4bmtSkWKjcsDQhcm+Pa9QQRMcKDQ1loTdQh2Ed0Lpi5d7TIFj9HBbIqiJwVZIAXGvL0oJBVgcX0ni6mcs4a5DRri498ePTjwudUhzW0xVtnFSNaEHdcc39pGpsQuWP4fOHerycGj2jnpdVt5oLlTF6QXGsf9zvrqBo3tfgi6KyD9FpL+r7Z4QOJnHy9EiegZlpRZ+v1QEMOjjxtcv7vAzv8J/z3FPkmN5EtTwjUK63JFROa4mgWj5223ezRiDEFhj2zeduh8/aO3UWV8p5dNT3SL0cZ9Yl+dU7UJK000o8WpOS4pdOTfT0goQrerWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfrIm/W5TIAFwwJNMZTcfBJTucWT1u5KhLZyIoWpVfQ=;
 b=VmcJZrubfryYxQBJhLKsyovELvJGI+mXIRQMf+2VMm0LvEVxi6GeS9g9HukdAxuMXqdckg/e8GMPlNFBs18eFeljdP1jAqd4VAW/V385hVwv0kL7JtYcy6do5bMS9pQ/K/Ad3HlDak46hkU84YzPBZfO/yKj4bq323lHUqoC87U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 30/85] pinctrl: renesas: rzg2l: Drop struct rzg2l_variable_pin_cfg
Date: Wed, 12 Mar 2025 12:22:07 +0100
Message-ID: <20250312112302.1605750-31-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d513d7-0ad3-4590-2cf8-08dd61588919
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7Ba0PurXFYq9GVKu0ADRSLXFZQn5h5yQnw26/Bn9VuzgLMQ17dpNaMCzGEGt?=
 =?us-ascii?Q?MGHI668I3d/CiD5tw02WDr/FolQAJAG/JjqhPjHI6K8hQVzjRjyu2VYc3RjV?=
 =?us-ascii?Q?FEa5+mWOufne+HeCnVWMG2Tb2A6rth7Tr+P0K3qHtfjV+UBl6X/cIyfxRIlS?=
 =?us-ascii?Q?+RfjuzFhP49z5YBZlqpBqQ+o4wlCt64hTEU716/jtxuvXJKvcE8/GUC06i4h?=
 =?us-ascii?Q?wD3zLb8zFMEUvLbHAQYOuMnEtCfZV7xS4p/1BZ+NZm3PcN6rR/6ADbs+tmew?=
 =?us-ascii?Q?oJkXp6lktCkpSiIiXk3NyYJ4B+A5Okn9PCaurFQKiiINJNSOrdi+wN7PgEJq?=
 =?us-ascii?Q?Qyh8Xep0HYfz3Q0kBQXD2g36bZcVdEm7FsOj/TxpqE7esD25Zyr/sMLh2xzy?=
 =?us-ascii?Q?QlJb/ex8OsHqkGjAh6uOO3ieHbAg2PTfYlDbqgpmQo2SdPID5ct34lWDty7N?=
 =?us-ascii?Q?U9Yp6nG4B9xzwrxfrFZeUNGIi7J/3NuM3XP4CgNVahBtv5ECX7Jdt+6cBkOa?=
 =?us-ascii?Q?mGT5N5NsoJhNb1qRA3B7wRlgKhERCxq4c4sGP0umhnf4GV/u/oJa8IUIW/Uz?=
 =?us-ascii?Q?yrHMq+JEMjlvW5zZcscjjHuyiRxLBATOrpsBR8gDKv8MmVgK+JlyFtVBEniy?=
 =?us-ascii?Q?HMXNydvJ2dD6OaMd+cbvBQrQRno+rs4vwxrPlRbr/VXrfZJE8n/Mvv2v2cNy?=
 =?us-ascii?Q?AmyCqen1VHacz/QW5UlKRvb03HEREmv2OaUvY4ewTSuroYlcOQ7kaYZSlnQJ?=
 =?us-ascii?Q?+9SPdA4XGFaMIb882B0j6BcGLWmuWTRs+Y1NXFc19ZOo9LFsvfzuPRdgOrJ+?=
 =?us-ascii?Q?+LYSvAE3NF57jkjOuKmTDLSyFYTtqIg4IJNh/75ZlqesjRuDV4KbMYoK/9tt?=
 =?us-ascii?Q?fb9YHAgM2MtzYsW6ChnpETtlqHdXtc0yQZvLPLdqOkn9Pj7ECXqUroH+7VXU?=
 =?us-ascii?Q?ylHZvXEZkkN/is0O9kITl2YuWQfRcpw/B0N3+O8W/9t/mk5dpPkOqBHyXNG4?=
 =?us-ascii?Q?NH4ki7kxPaG0wFb2wyqFD/TaRHD23i8ZV0pt9rIWn+GKqfsm9+nxTfbfcNWl?=
 =?us-ascii?Q?dd7iLgXPSQ29D+VRWE32173do/c35D2ktKhoPvB/71WkvBSb7rhFGCiIXcd1?=
 =?us-ascii?Q?uCkeIdZmmml9A+HlDYmnb/g/qwNhP9sY4FF19KokCRWTLgX9edYuo+tU05qH?=
 =?us-ascii?Q?ja8u3sJJtRb/I6xOp4+XcRn0wedkgN9ElYU/3GbNA658Eayl4ZlXQceSi1Hg?=
 =?us-ascii?Q?WiW58UCXSHjKgoO67iNM7qbsCiz/o31+Fk+zeWxGo6krSoq12ZJA5mxs0taq?=
 =?us-ascii?Q?YbRcVGv+64G3vsHzu1+oM32KgOyViOWzDhuf41TGqDbHqRYmNlbCFNfnmixk?=
 =?us-ascii?Q?HFr/Z90WhGeEGT7vDNu2e/7Wtt/af2ulou55nvaIbtBlk/sfdas05PZw8ecj?=
 =?us-ascii?Q?qMkqRkmcSxERwUPKPZrKz/tcwJDZEry0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TpNYVNhHr6NjefVFnckuc6ExoaXM3g7JE/XxTYk2j5tn9Ch8NvpDpn1PBGsA?=
 =?us-ascii?Q?y/ErUzSjdo3gTWEijuzijr4KVRXHhIrFpinEs7ujceApUjo0/BrZhvvA12Sb?=
 =?us-ascii?Q?pqHheNmeR9nAy/X2LNXRCBZMz2yww8mjGC9WW/nehhfQD3WHMRZzVyFU7HtV?=
 =?us-ascii?Q?2YvyEeUHjlDzay+iqiKWJXtRHBTk+HXMO1arnBEO8pyuEsNeQQkSjdfEJVA3?=
 =?us-ascii?Q?S0TLfWcDPyBlz7WhMBBgBQU865M7bbhUGzRgwzZK1YpelmCygrUSVc9CCvXE?=
 =?us-ascii?Q?IVazUddE9XxMfF900nahiXHDs1VBLWSZpKf+afluiIQbPMWfQe4v3adkywFw?=
 =?us-ascii?Q?dtzCUrZjy/1Xzj24TyMvXL/Xugeuo5vCTSjZZHC1xst3XcsN3nw59Nk295kW?=
 =?us-ascii?Q?IYwzPcrSyBgbE3EqZd4fjhsBK2Fx8AZWNFfjARjIKSIc2CZ2yz3wyR75gqnX?=
 =?us-ascii?Q?Kj7nl2ccbJ77ZJxf28bZltaGaKZdPXzzu/2nlWyCLEzgH8A4Y3U0QHnDqYVb?=
 =?us-ascii?Q?AC7htxeu32GWgvAETripKZt6tVTg8kSL/O3TeYhviRTaitQ8oZa4L2b7dnZ3?=
 =?us-ascii?Q?3mls8zkRC7nIKckCRXdOGf2Ys4tFs21jQWQVhUcOo7aZ58jQvzLMS/VvYvpL?=
 =?us-ascii?Q?4LP8AcaGy0RKrC0bmAWr+c1R1bI8es/0KptCUu/2z55u5mitjlTCYd49zvcl?=
 =?us-ascii?Q?Ln1gVvXCwv9gJWeVheMB1KZDjD9VTIIVlbyDQrlk8J23KasJmwetM2bcZeio?=
 =?us-ascii?Q?qV+1xPSk+dD6P8zRRnVi64f5E3JMsMDWYtF5lSKyfz18/+pFlkg48/ihknKS?=
 =?us-ascii?Q?L4wuGqkpVhZb0FoSpjllZhx5sn+ySwgU58xGapupVq9iYoMyoiRG/3mgrssf?=
 =?us-ascii?Q?KlUTLBiFwexwWlbW+wFoHRTTUy/fPoMSeXabL6gkK4XRmmoSU5nYN4Bv3qlM?=
 =?us-ascii?Q?JYurJvZC0e4nJdg8l84chdMQSpNHt/fjjmROuwMLms6LuRJYBaETIVzoM5gi?=
 =?us-ascii?Q?vEs6uzIlW3S+kljux8GWM0OaESy0IZjYQ58CBUlLycDlW7qbDDU5LpTpxhgv?=
 =?us-ascii?Q?A7ONgaXc/RH/5QDiRl1T44HcMBV2q1PbqdmWLe3FoXV8yZvjwlAdCQlosEzC?=
 =?us-ascii?Q?TJeDGoiGpr/+uPCU7B1vHyEoUCb5piPUkSbiMZQqPYNYL930+eQD+9DA0Jrn?=
 =?us-ascii?Q?eNnsQkqX5rNRg1jvmPF4kuhBzDvlIsZ24fZf7mSzx6iLb+MfY5S6qufuXZom?=
 =?us-ascii?Q?IFTPWVrNjDMCzL3/iDxD0qpWNPqp2v5MkFFlIZWt3g/3Em3hnpymoSmj7zzP?=
 =?us-ascii?Q?/I04M5lxyVJhrA7AMat/v6KOQx5grEftPUThpCoF7n534zDGjjLScc8ZkY+q?=
 =?us-ascii?Q?+LAC8bwOeG9osWeUvXquMMuAqWkzhdRosKDrDBdTyrysJdcLmL4yEm9MnwKL?=
 =?us-ascii?Q?ifF6up1SB4RXGPl+td4O/Gajuk9zQu8auZA2ipL+enaWXCwYrkPenn9gHl46?=
 =?us-ascii?Q?arh73hOHRPATk/v7JGTZMWELxBv7yOhjxA15jF6Br8pd+Tkxr4JkKsF8l7Fs?=
 =?us-ascii?Q?djBrI4284FI/x6EfCwlspQ6LkSLS/VmwDhp6doMwVC5UzPifm6RfneMWybk7?=
 =?us-ascii?Q?2sQIHnvccTtx7HVNQLQzvYc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d513d7-0ad3-4590-2cf8-08dd61588919
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:04.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8EUPq7QwJNVU+Mr9L3NK7ZGhTbMfc3iIro1q3Zbh0B34Uc/9ubj9EQUAnel/GZAQWNTbli9qAwPZfcBeVUuHAqnPP2S87on/bx4HW3tE3wM9qSHy+MV+MQfn7VzPDRh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18122

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 13a8cae6e561d607474f905028781a5aee7205cb upstream.

Drop the rzg2l_variable_pin_cfg struct and instead use the
RZG2L_VARIABLE_PIN_CFG_PACK() macro for the variable pin configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 187 +++++++-----------------
 1 file changed, 54 insertions(+), 133 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 33eff02c6206..24eb4a375ce5 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -113,6 +113,13 @@
 						 FIELD_GET(RZG2L_SINGLE_PIN_INDEX_MASK, (cfg)) : \
 						 FIELD_GET(PIN_CFG_PIN_REG_MASK, (cfg)))
=20
+#define VARIABLE_PIN_CFG_PIN_MASK		GENMASK_ULL(54, 52)
+#define VARIABLE_PIN_CFG_PORT_MASK		GENMASK_ULL(51, 47)
+#define RZG2L_VARIABLE_PIN_CFG_PACK(port, pin, cfg) \
+	(FIELD_PREP_CONST(VARIABLE_PIN_CFG_PIN_MASK, (pin)) | \
+	 FIELD_PREP_CONST(VARIABLE_PIN_CFG_PORT_MASK, (port)) | \
+	 FIELD_PREP_CONST(PIN_CFG_MASK, (cfg)))
+
 #define P(off)			(0x0000 + (off))
 #define PM(off)			(0x0100 + (off) * 2)
 #define PMC(off)		(0x0200 + (off))
@@ -233,18 +240,6 @@ struct rzg2l_dedicated_configs {
 	u64 config;
 };
=20
-/**
- * struct rzg2l_variable_pin_cfg - pin data cfg
- * @cfg: port pin configuration
- * @port: port number
- * @pin: port pin
- */
-struct rzg2l_variable_pin_cfg {
-	u64 cfg:47;
-	u64 port:5;
-	u64 pin:3;
-};
-
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -253,7 +248,7 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 	const struct rzg2l_hwcfg *hwcfg;
-	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
+	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
 };
=20
@@ -330,131 +325,57 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct=
 rzg2l_pinctrl *pctrl,
 	unsigned int i;
=20
 	for (i =3D 0; i < pctrl->data->n_variable_pin_cfg; i++) {
-		if (pctrl->data->variable_pin_cfg[i].port =3D=3D port &&
-		    pctrl->data->variable_pin_cfg[i].pin =3D=3D pin)
-			return (pincfg & ~PIN_CFG_VARIABLE) | pctrl->data->variable_pin_cfg[i].=
cfg;
+		u64 cfg =3D pctrl->data->variable_pin_cfg[i];
+
+		if (FIELD_GET(VARIABLE_PIN_CFG_PORT_MASK, cfg) =3D=3D port &&
+		    FIELD_GET(VARIABLE_PIN_CFG_PIN_MASK, cfg) =3D=3D pin)
+			return (pincfg & ~PIN_CFG_VARIABLE) | FIELD_GET(PIN_CFG_MASK, cfg);
 	}
=20
 	return 0;
 }
=20
-static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] =
=3D {
-	{
-		.port =3D 20,
-		.pin =3D 0,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 1,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 2,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-		       PIN_CFG_IEN  | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 3,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 4,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 5,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 6,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 20,
-		.pin =3D 7,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 23,
-		.pin =3D 1,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT
-	},
-	{
-		.port =3D 23,
-		.pin =3D 2,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 23,
-		.pin =3D 3,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 23,
-		.pin =3D 4,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 23,
-		.pin =3D 5,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 0,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 1,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 2,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 3,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 4,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_NOGPIO_INT,
-	},
-	{
-		.port =3D 24,
-		.pin =3D 5,
-		.cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
-		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-		       PIN_CFG_NOGPIO_INT,
-	},
+static const u64 r9a07g043f_variable_pin_cfg[] =3D {
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 1, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 2, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_IEN  | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 3, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 4, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 5, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 6, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(20, 7, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(23, 1, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(23, 2, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(23, 3, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(23, 4, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(23, 5, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 1, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 2, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 3, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 4, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_NOGPIO_INT),
+	RZG2L_VARIABLE_PIN_CFG_PACK(24, 5, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
+					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NOGPIO_INT),
 };
 #endif
=20
--=20
2.43.0


