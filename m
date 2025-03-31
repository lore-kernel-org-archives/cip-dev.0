Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85676C36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.web11.48803.1743417972400699426
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bT0wF2cD;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3dGTn3hRgJd63Rpj1njTrckV4uznLSgvnaDi7COZsthxaI7NzYts5RfyCbVSG7VabN+XhE1mFsqu6Lafyu5PEMQJGvdEd8r5EHaACF7oU9tQZ5JDZqSPYs45dvWxfopM9h9vts/dopOM2LZJOiF7nPuQYO3rMa7z6KyUT36ksRNLFj9fUknuIDha1Bv6TVasBsNyKdRnEvHdsQ8D+QBipbG8Gau8Rl2LI/VBlYWZuvlI5CIwlrkwHWaM+2JxDsCr0NRCixpSA94aHw0BShvjweQDZzEHk13n1jQHcUBoKFOc/oqZRPmqvUj6Qtg7pQzkq96DYjmmpzrv9MAt/AiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKRZBadYpFdn1OPfsQWfiipoljOXzZQozya1DbZ8xEk=;
 b=NVxLH2Wy8o9LOK3xiwMS0PvK7Kz3UIB7MiP+gkFXD2TBi4W1bX8as9tssJQWHhAdH1COc9GKAj61Qx2s1hjCqJyJG1TfFX6nDowB9nwzR83Cd7K5rRTAjytTfvsxsv35SiPx/8f7/F9Kd57W64SLgVGyZL3XEGGKTU14p3uR2f2iWzz5+v9tPjHQIF0qb7BLjnKvCexyuBO8nE9L/94tTB303kpreThvH0mCI+7TRbn3WgST8QxMElIRY9utp2EkVN/t8WuoQsDzlmtSgZ0D9qcbfKCyy33R0d4d6mZV3hI4FFvlxpesD3LahTNK7lyS847HA9Mo+IZRDLpDVVKKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKRZBadYpFdn1OPfsQWfiipoljOXzZQozya1DbZ8xEk=;
 b=bT0wF2cDWZ07ysg0dSef0fP9R8UkSFNHFZG70zASWIQWvNvLGi08gyUXU1gCsbcJgJc96gShDor4ELD2BvSf1crxF2iWj5BtAxDYh0KgEHxzqyKhgzwDECX+uhISRdXxtcaW5NHo6edK8O2nnyKlXXSHCSHNQAE/GrJhByIrpn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/43] pinctrl: renesas: rzg2l: Add function pointers for OEN register access
Date: Mon, 31 Mar 2025 12:44:44 +0200
Message-ID: <20250331104514.79090-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5518f523-c22a-44fa-7426-08dd70413fbc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?85gBpJnSXWPJS/tXpkYGHkqw8qrwleqbOgE7yUDqmvstkosK2wLv5LOf1e4R?=
 =?us-ascii?Q?gUuNcMeNpYp6QZRFirvEu3Vb35dUTdbwt5TNT8AbdYYLtC7IBrr69u2hkOFR?=
 =?us-ascii?Q?4+96bjxysU4croBBuwD+XzJdXxAm9w6fQpFfQ3N0MX9Opj7gG52bt5Lngf9A?=
 =?us-ascii?Q?yFNULN1xC8HcYsb4ipM4HQPi5Tq+jOmlMEKz7T9mZip5TrTjRCbk65R04BzR?=
 =?us-ascii?Q?eC22vjybnef9LhKM5lTPwE/fq01XaFbg58CoJm4B9tBdprFNfQbS3HBtvVYX?=
 =?us-ascii?Q?QWNzTwtuz34MyNaHk1444iEQanD6grtW1ob6SjrU+Kax2joHlyjXqE2Gpnj6?=
 =?us-ascii?Q?GLE/TSVl7RaAfBOKeQvk2zlYZYtfGxULDa3E9ONdVdleUkXXvuKPnOKWuXTD?=
 =?us-ascii?Q?hOjgSE3/bA9wzcVFJ5yFhMs0SGNNoXC6YhTjmeep08T1Ub+3EAy8/FsXoRk0?=
 =?us-ascii?Q?M7vyB6LyKZ5z4cO5xtv6fg1YZ8qy53mV9amcYIuwr66qyglZJxX3S5GoD4QP?=
 =?us-ascii?Q?gfpLkyEnNSSvpO7HGzNLjIBTHjKAHnCXlFNikaid0meuOOI9VwQN3ZwOLCZq?=
 =?us-ascii?Q?NobyOmFgzhfCcydNsYHEg3zZEOLrRydEM7bwZso71ksm8Rtfcyxs9S/LhI97?=
 =?us-ascii?Q?YIaRgdbSMqta0wa+wetTzje4HorQoaDhBRAN7oimhB9LnE9MA2bP0gzl/cuF?=
 =?us-ascii?Q?tT2IIihIElNneflqwYuW2FDKXOKEIcpAycuQkTKMtUZ4yW/w1DFo1vbj0iZs?=
 =?us-ascii?Q?zGps2XhxETOEemM8Gqy1OVw9WEwmhXackTWjdR2HDzZNtMtEJSBW5uthTmMp?=
 =?us-ascii?Q?x+C7voq8vUyQUG1Jio89cpW8S5C4oP8G16Ijx2Dfzq/4h6iTH1u6Ew3apT6U?=
 =?us-ascii?Q?vFOPgPqpyoz++LJlqSObVsUnqeuCVGVP3S0Y6LK4JiK77pPSGc1u49zQWNSV?=
 =?us-ascii?Q?5yMcq8sxdYMAamEkklFOFeZLP5R9tzQsooCO2oXO0Ycg5q+dwGnhGQThKaEL?=
 =?us-ascii?Q?4VTJ2jmtYp4d97/BwzkRTtx3e0ozaSKdCBysyyHoN31VCx1lCtv26cpbqs/P?=
 =?us-ascii?Q?iGjS2l65zw+tdoCwhS92ifjmNpl18BGDOUQ3vQFV42IVVY3Lsq1KjUlVwkUs?=
 =?us-ascii?Q?LnBpH+2rB/kDWG0pdgKYzqK7r6j+NWF47bORC5XW29YeFkYpk4CGID0LtDm1?=
 =?us-ascii?Q?WzXWf2k77HJ/+1TRFxfmoA7jl1XDSaUY+zUW1Vyv6F3TnGad6brjEdjNYcWs?=
 =?us-ascii?Q?5M/bAV3tBB8LKHJBOZCoZtG8eeA5lLXEUI2cIMvFXuOK3NknFvLEnP6XY5Z5?=
 =?us-ascii?Q?8PFIKGK5hGdq/eJ8Oyjvdnss5QfPR+c9bwnbSywZcVJCFDdrJS6JTrpLcx9U?=
 =?us-ascii?Q?d26D624bHCWWMXXzOPtdBXfWQ43MT0zaPgPzCpLqQx1keX+er6r5OUYv/LVy?=
 =?us-ascii?Q?T8ixeYTAeubxYEwvPyQrpBUfZ7NiguLJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J65oX9e5TNntV3UKfTaGmap/7PxVX0jgryqu8VZQCnm1NN9k2Vfwjw/U0Pgo?=
 =?us-ascii?Q?6N97ClK+q1sz10+6oYnE86opp+IA0jYX5AgdIFXv7fGu+WAd4X9bQUT5WHzE?=
 =?us-ascii?Q?4pjG6cjaEBBPaZ2S7flJkaVm5VeRJtua+Ogk2G7JnnGp9FIId5dvFVeH2kCa?=
 =?us-ascii?Q?kHaSV/SfmStnVDOMBZ3m1Cy+9LEGWUvyfIJO+fmGr3wNlrgO4ZYQChA9mOoV?=
 =?us-ascii?Q?dBGnmqejl97QJAFQkTI0pFGDGRTDxbOdAu5/UYHo0ZIscThW2/KuklNAnvyn?=
 =?us-ascii?Q?xgxWHyR3xN3mM2mGx1nbe93+/vYTMGQchf+jonynn0D9F87G8RqUK5qiTH84?=
 =?us-ascii?Q?AC+de4qYFCia/MUE12tXYcgqzu8fUt0DAgDFgLAb5K1BhxvRvh6FUtmL515K?=
 =?us-ascii?Q?74feUnV8mbR8rA5S0e7oEZGtjKbN/EgL1u/ZTVKITT+hgTWTFUTee7QWqAiU?=
 =?us-ascii?Q?3R+4oV+CcklJkXyPppYcWJWxAAvIaer97OQtANtr2yUriANKBLSqXZZ8xe9n?=
 =?us-ascii?Q?CG7yBZ1RPnHTFXDT1PyITo7DeJByFDnqVfVxX45xjYPqF8APe1viFJ9o0e1F?=
 =?us-ascii?Q?TmYKwPyp2qJ3xB4oxzO6GKh3gsT18wfkFL99g0Rpc6vpVpYaDkxRIvwB/2Zm?=
 =?us-ascii?Q?AC4auYxNHDkFkb1xKp9c0/GV+9uCzlYWsJWHDHOUlc9ak5IFGsbHZVl3ODaB?=
 =?us-ascii?Q?paJ19REWrn0JnqCZrJFAXz1GOqGTkWt8sF8BYaWx07a9WrWii9Hvqb/E4v4Z?=
 =?us-ascii?Q?2eVKH+4fK8fgcUCPG1hS+0+EXMRcwO3cxvp2aPA8ljgvKG3vVlbh2t1NBPGE?=
 =?us-ascii?Q?BQL5fILPcbX3j+k1JjKoWp/azPdeXLElPwRZ92QElNb0f3/fk4wvNLlCQHmb?=
 =?us-ascii?Q?mE39qS36Ge8AFU79FsWI5nYcUhJWtzpRr/A7r/yR3z6LgQAroUiw8J0jNJ2I?=
 =?us-ascii?Q?aLjgcHgGt2ZmzHLsizW6beCQbEPq4yWq4xSJCX72Dk/ZiqFsJDJtA8CDpQ1w?=
 =?us-ascii?Q?aEG4KqL2eXLEnqU9I/y/YNVCri8nI7NDmeo2uDvT6i1pStY1oiOLkBxzojWp?=
 =?us-ascii?Q?kvEuV/j3jP0ihN1kio0MF+SpA05l8bkH26sktxwJD326zdcNUAB8g90XC3k5?=
 =?us-ascii?Q?QCemGesCFSgg6au6BBFNiLayMHRAUkQwKlCmZAPe6g7OGj23OUXzbrD76vcS?=
 =?us-ascii?Q?mhlSDeVbf5Jl64CvDZU/ax4BOs4pXdaG9rii1djASV4z9pm6WloDfP+8R8YN?=
 =?us-ascii?Q?mEQv7ohNseRWAojpmUGRP4eJ2BIboA8+E8VNsb1EPx4RVjAuKh/oXbSD2Q7E?=
 =?us-ascii?Q?oj+D5TtbUWOG+phcOz8sGOOPyc/t6M6D0SPXv4vEZZBhkQTOghA97KpTsWJc?=
 =?us-ascii?Q?VvYe2qGWtDmzl2OGe17WKMfGbl8YLdZvEVzQG78qre0zPdBcnxH3crzexSwQ?=
 =?us-ascii?Q?LG+tBfnHHF33SY4oBJODWEz9BSGol3GsorYXar//t/v5hYmUpDXzjtmoB23X?=
 =?us-ascii?Q?Mz0e+M1Cr5JzpLBXEyKgCxOBu2yMHK12BjLYuIjZ09CfB8PdJ9cHvXGSfiqe?=
 =?us-ascii?Q?qP3/6iCgQoVJR1sSOPFbrK5mys7xvgPiURsoFFdTrZ7x3s1GFCUFMijtIMpQ?=
 =?us-ascii?Q?bb++wDL7YndkQTooE+25w04=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5518f523-c22a-44fa-7426-08dd70413fbc
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:10.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6PnLHnq+wfIoM/WxTkw+8E8vOQfUr9jCJlugfnBGaELETBla7Rn7BTUqg5DEubMphvs6YO2RwfTQDSlg2VgWCiubqyTEC+qaollV5DcofJRWgeEpx8WLeB6pskRcvgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18401

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7d566a4d270c52ffffd04b78b753bb3ce8cbb867 upstream.

Introduce function pointers oen_read() and oen_write(), in the struct
rzg2l_pinctrl_data to facilitate reading and writing to the PFC_OEN
register.  On the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_B bit before
writing to the PFC_OEN register is necessary, and the PFC_OEN register
has more bits compared to the RZ/G2L family.  To handle these
differences between RZ/G2L and RZ/V2H(P) and to reuse the existing code
for RZ/V2H(P), these function pointers are introduced.

Additionally, populate these function pointers with appropriate data for
existing SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-10-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 947fcd39b1683..430a7638a9d39 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -254,6 +254,8 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_variable_pin_cfg;
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
+	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin=
);
+	int (*oen_write)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pi=
n, u8 oen);
 };
=20
 /**
@@ -1035,7 +1037,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		arg =3D rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		arg =3D pctrl->data->oen_read(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -1144,7 +1146,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
-			ret =3D rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			ret =3D pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
 			break;
@@ -2623,6 +2625,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2636,6 +2640,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2648,6 +2654,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.hwcfg =3D &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
+	.oen_read =3D &rzg2l_read_oen,
+	.oen_write =3D &rzg2l_write_oen,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


