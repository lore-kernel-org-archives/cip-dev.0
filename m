Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82138C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.57])
 by mx.groups.io with SMTP id smtpd.web11.48798.1743417957423731296
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DuE4DbDB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbZHuWQx9Yt5p3LtKzjsVUYkDhNuJOPAdN/GBvX0Z/lHFCQWgWtZEfCRyunp4JDsZof1y1CWUu+EwXIYIzAf9tVb+QwbTf0ZYkZKAIgLFZxzJ5b91HuQ95rngiuUcEbqUAJ1vQ5Wna00Q3PTlMbsMZikGOjCxb10Hd11VRqVGgy14LsZmgCbzUwXi4SQ9FkVwopYTV4EIHrSxerGa57RaY04tsyIK0ooRwXWZO8bS3Zynx694fu0YeKycZ0oD4aTgizrd/mzUO9j9ZrLzmuV+MTUN9EeL+iUnWP2BtHAvYcQmsVlpsx8oDVZWugVi2E3j0iNpqlo4/RXa3d5SfebtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cGxZBQvS5euAlGQduBDvDXniAfzgRUFF3m/XwfBjsQ=;
 b=vCNf1/BHlmPhR2fjiFj5k+flgVpzF77ORSnw0LLOI+O71ld021eFa7sUGzdnDIiZMy8i/hA1xOteX4c3cLZfYeICKLSEExCPi36byo0YjbZD5FNh4flu/IddgrtGmxCf+Vs6/BUQVGH5pXtzbb1rkUE8DISlbaqTZpePplqls2poWG6SksWXACOOPFkvIgkny/Fx3uG+8ggJ/gQVjK3YiyYqMr3zFeGbNzql8wiXOMRPCXEhCbwgsSVxfzb6K8yPmrgwPF4/h3qTwnscr3CXjPSgP6ns/ppVjH81R7eqq1PEAdVLDrHzbtwEGiv8uBh5CJzOO3anOKySGGTCNkKOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cGxZBQvS5euAlGQduBDvDXniAfzgRUFF3m/XwfBjsQ=;
 b=DuE4DbDBXmBCo0JiOFVGQi3fU2rXHcVUBtz5+FH07c84gmS1nt3uReL95zIgIPqtCb20HeP28NqoXMXMqWbZcUsUmA7sYfAfIrKAh+LfHwFJ/yoObG4fknV9rUV8aRB+ED/7yASi8O0ecYarxtlMVkH+x+rhFRBRr9K8vTsuJS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/43] pinctrl: renesas: rzg2l: Drop struct rzg2l_variable_pin_cfg
Date: Mon, 31 Mar 2025 12:44:39 +0200
Message-ID: <20250331104514.79090-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ca43af-f248-4d97-2983-08dd704136e9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KegENfgBledG1at82wXyQWjV+bHbJkab183xi+/9W32qRA4fpBVR+hEAusxm?=
 =?us-ascii?Q?3sOxEIPEi2PupeyjmqJn0Q2iiJOGH0bayRhUvoTqpfq0xp2JAYayW689XGfp?=
 =?us-ascii?Q?WmVZCvCT34gtH2R1fh0InnKHcOFg0/N1O36uwgTSPh93xlVP2tBVtlAwEuXy?=
 =?us-ascii?Q?SW1SWlNMrN6OnOdesp4z4uFOfQZpnEfzZ2pCnTMZKdeujk6ElLWVn9HqaIVB?=
 =?us-ascii?Q?ABIOdyT6tQKHwoxvUXUGjada89HOE9SeOCsTJ+lM4zVxO+PRNkmYF+Ep2qK+?=
 =?us-ascii?Q?h+mflzOLb9QMm9ZVQ6PU26PrgTYOjBzrEZmpgBDPB1BrceyRgT7X51mHCBxj?=
 =?us-ascii?Q?RpT210oLsh3elxMtcWnRxgSCJis4nHpSBzd/i9T9lE2m0ARODapdhbHgK/lV?=
 =?us-ascii?Q?TJS6AE4ctCfzwwGcHycDJNKFHC+1sYHFQyKSMoRG5XO8kOgx64niIY0b7BI4?=
 =?us-ascii?Q?JXTPblvLkSC0JyT72F+3e7By0t1H7s1RTg7EeTtck26IufosNPgSmjgIOLTt?=
 =?us-ascii?Q?3KOfNexkoY4fF5iLSWC7+jFi5/rF7n5kVYXhfgG1JR3HXp/BlAOVm+4xRPQG?=
 =?us-ascii?Q?c5PZw6LOsjFEP4sKX74NMZtdcVkVesTWurrsO929cZOAGO/MFd66KpEFKp1D?=
 =?us-ascii?Q?8boaJRdEg0jpp168/8HTSF+O4BWAHBOROQCtyZTHzYXuiK+CSSWuGWE9Q+6d?=
 =?us-ascii?Q?zkhc1FxHmusFQ55QuLoTbvwMdL4jCh66pm4xu6kdWgbfQn+850ftijan/MlE?=
 =?us-ascii?Q?vbuXpYwBp33y3u+jN0xRIa9fLQHS3n2gmE7NFZg2vFgJrvTBVjOW+qBWKkzF?=
 =?us-ascii?Q?JmRYKP9tz0Cryu2TbWrnza243m84EfM/TY8y7nWF8xKz0XY2sNvAsnUrTL/p?=
 =?us-ascii?Q?No2XHZE1bQwdtRkQVHX5ATVuLbJYVMZ8QKlYd6t9wCQrM6iKRdwjPUjedTGk?=
 =?us-ascii?Q?hCtU6l5OXuBmAICnM0JIM+74XOoUTO4RJNUdZnWTnGyFfB2EWDx4ptN4omBt?=
 =?us-ascii?Q?w2gg99Su9Mz4JYq0IaTxwqkDoZBOOXCT0vkFtQ3yKYr2fAMf/KVZZo3uMGum?=
 =?us-ascii?Q?h5B3nizbNAo4kMuZ6PdI5fjOBWHsBGoo7ATW53YL0VU5qa0BW4JbR+RIaSdZ?=
 =?us-ascii?Q?kP6RaxgZr1sQ8KxWs9BWT5PhDVlyHgnjC01l8yeCgfzdaEpUmPvQj3LD7aVe?=
 =?us-ascii?Q?q88vHgoJpDnO3KOWWIRMDn8aIcY25L63lRunwWpuK9vDuiK4rcv2m4Un9WnO?=
 =?us-ascii?Q?V/stREobR6wiWrCvJjtkGv+rQ4PZmmHkqlPV39DfNdof5hCQNC/H3rVPXytI?=
 =?us-ascii?Q?INLSlUItm2Plw9FFwt+WE2WqMa9+eMmY73FuZYD98CSeQu4wG5zDv3R1LqBg?=
 =?us-ascii?Q?LO2GcWKD/BzWquRV2v9qDNY+clUb4mneR03s11+W6ALfudfr01eDcY9FTcua?=
 =?us-ascii?Q?RKuYGvKFeIdrYHQ5LjHulo1GFPKWqfbp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jgKS2gC4P/OfrVFc58NTgR6QyGmu4urhoK87PXYWtwL5rT9PYVy/KpMUTBNh?=
 =?us-ascii?Q?/1ZMtUpzG3b996XpIgQ6dytsqM0Z+vPC3rmHdg39Q8RB3qhICdRdQ7LB8IZv?=
 =?us-ascii?Q?GHIb6luLmL2rm/UV0hugt+BkAwJRa0cSUO3h+TbRrl0dbvJdEX7HDq1/wwa+?=
 =?us-ascii?Q?Ye+9fA2CONvseWxJPu3K/haWfzoWk/oLHlaT2Wec3VY4FZNF0TfqOAWflCh6?=
 =?us-ascii?Q?PH1k8e5upaYmwAiekp3IZ5M1rJaEzqlD3So99Kt3sAJanVjT57hha/xIt40P?=
 =?us-ascii?Q?QyrVu6/ZKc7G5CyJmv9WCpGj/Txn4/nbqikQoWEjSOs3qKz/GI8wwoV0w+Y4?=
 =?us-ascii?Q?qnGjQhgQJt80vJaBJQhRdZQ6TYJH5y31ZFaLbk8sxUkevsch6HjIyUmX4HmJ?=
 =?us-ascii?Q?v9507MjZ2owHNe3KNF/q3tNvaVYFjg16AGomteXF3uihnld/6TgWa0DvQt2l?=
 =?us-ascii?Q?99Fw8UWP19zMBy9jq4TS5KjfUyo0p0tFLt8L4wwF2WUeKLYAL6Lh7YROxCOd?=
 =?us-ascii?Q?egmR1lCH8cKGH9j2xtdmjSWhlc/fuqh3dLbU1VudfK8BWWtTLVuhSpWPBQYA?=
 =?us-ascii?Q?YxjfGhz5UFGMEGTp0koRWCXb/AkUhX6GntiM05cr3BCoSLZjNeQKyixqnCzC?=
 =?us-ascii?Q?iPGtaBxQkRRy4a7N1bJXMjewfrqFuZt1KlRn3E91qIQdQFKzYbElsgbIJlL4?=
 =?us-ascii?Q?0jShWVlum+1eTLj22xoSfofcm5CUGKzm/ydanCPxnuxbjzdEpMSRmNKVraW5?=
 =?us-ascii?Q?cSN0iNaDSrMXkb9LyoGq7fD9hB1Mh/bZo/XHdpOk4mxUG+i7vWRdv2nziRnp?=
 =?us-ascii?Q?f7hsZRVyyWpzYbwXrPnK4VRQNxSq3GVEeY8ZCFqJJ+2EJRDiwtDmlr9qgGi1?=
 =?us-ascii?Q?5Nrn9Mx7vKcLPPxeZmyYdG3DlqCW8/3k367L339lLVtstQ7xjFIRxS+8sT9t?=
 =?us-ascii?Q?efn+XI461rA/DAidIBIcuiYwSWS3BZg7AWxpCfYWlw7gkoBwxlO+jYtt397g?=
 =?us-ascii?Q?YbgKD4ANVLdwqCLwEnlE5I/23ZPQVo44hw8jxBO+joTp03zKedNWiFpHWrGR?=
 =?us-ascii?Q?OckOkjFvNFZcefRYRrWdUoy7yPF3O+hY0kVTY1Pxfkw5muA4+pDtIKSIUvl2?=
 =?us-ascii?Q?O8zy2da8BiUwSoeIAO4/TJuZWaoSmWV9svytlmia4pZknTnPKKt1B27OZuzK?=
 =?us-ascii?Q?MkbMnFUyAGJ+/PBRe7Nk/xAkT+vJnmw5YqWx2GKVYdiYdizEFb66ttOzo3rj?=
 =?us-ascii?Q?CxXvdL32bKHitjJh9186H60YsSoNnqk6lm7wpzUm1GXZjcWmpAzXmgg9CGUF?=
 =?us-ascii?Q?NaPYrRMW4Pgqic4gQu24nbemA8pfnU8JSvqjFZzpsSVjGlcyPRZjDo/DOYFt?=
 =?us-ascii?Q?XRkFBc6g3spFQQ/EL0P+BvnD23MXgdrJRsMumvbmZ9kLO4kzmKCdcP8DMnrf?=
 =?us-ascii?Q?q6IiQsKU5dtSFUZocR7c9DI6yX/PJKRUtW/lzXKzxw3xG3RTP/+UCigiNOP8?=
 =?us-ascii?Q?888Ny34w9g9/R4oPs+XsXU0D3EDK3Unx/3uJPWbvu1HJiuQIXMIUZL5s7wqS?=
 =?us-ascii?Q?eUwUm9fCz9RTrlY0gfdSJO9YdAlhmRmUl1hZh8sqIijfFfcfwEGotnKE2tf1?=
 =?us-ascii?Q?yuIkUZFgHA70XOYTJdV0T54=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ca43af-f248-4d97-2983-08dd704136e9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:55.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TmvxFIxTdp/Lnnw7cIXNeI/3QaT/3FIV9HJ67VupqqAUJUJc8ocCCqtKvOH3Ebd1m+lUoy+PIgE9oladp4kHqpg0zrwIEP5GxPUxiHCe5pshcOLTAeu2EycJydDAEVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18396

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 187 +++++++-----------------
 1 file changed, 54 insertions(+), 133 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 33eff02c6206e..24eb4a375ce5f 100644
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


