Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA1C35FF2
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.34852.1741778792613951897
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LmtHB82H;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxL7/zk/aLQ8j3UNIy+4Iza6LUaHnz3cVYOV1k54bYvw4ryMfWoyOAg+kI8V6UTF6b7SU3ME/ZN0wnMFtodoEwBSh2Q7wJEL4CXorJmtDJgdTt7OwYJiiNNBQ137wgetF9Stkys9wIDhCalCwmOV3rGSEJV3yRs9kh9AxkexDwqnZH3JxVXJkas/mFgVKuHIWrZDpcK9HMvDYnojsvgxblA6RJMA5muQYfk9+GW2wjiviC0TYOR4M9bJhzb4X0R+zmMrdl+/pEOjg9NHVLTSdhlwQPVmhecSLwWQaz9CaAQxqZtutlyKoUfapjkFHSD/B3LNhgGVzF9N48EW0z/jCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkT50gS0gTKrEv3WkaYo2ubp/+vzFw4YzLw73BO/Flc=;
 b=Yr7W43i4G0rrBn7xxFd18CRwqShVlnNMyhzqWatX1nN3fPKo1O4j+u9+/45nPv9XTg0+oF53c15Jh/j1JGibQcN7SQQaSddP4JZdy66iV6rf4bJubjcofG9cYaQQRilyWqgNfvPcT7uaVDCdbgs77lhClIqNrt0WHFwkhjlkuxFTCgYmlbASHqegsuuFqkEFXfvTgCqcXCwt/w45MHaEsIviQSCAhywdbAAnHHASmxK02O8FRF8lPStnXUdvuG9jpTCTWT03zIIR2glranAOA6AyJUUP/VLM1Y7GFO8z7gZkLWL9OlOYLapF0vrhUMg6VT9NwP4vXeTuiTlQC4Sv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkT50gS0gTKrEv3WkaYo2ubp/+vzFw4YzLw73BO/Flc=;
 b=LmtHB82HRMahaA7TwowpMXvKbymmTc/r0SaP4wpFrDP4f/0e/RnjZqdByPbSD50+yI39gSHJ6Ow8mVJxKUq8HrETLvkpGGq21byntMNiYsYlD6grvLKNFhNKSSQ5YgYa4339ZUio4QdQOcBeUu1vqMBv5slllXUQCgN8PZ0JP+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:29 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 59/85] pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
Date: Wed, 12 Mar 2025 12:22:36 +0100
Message-ID: <20250312112302.1605750-60-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: edae0972-a91d-4514-4d9b-08dd6158bbbb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9xdgz0/NCm5XEG94MFiUu8mllJXOMHZAW8vcYVIrJO9OUDs4Sryt2y7j+rZ+?=
 =?us-ascii?Q?hDyMHBgJRqfU0c4So9oMWnz05kP6b4RmPDnopOQWrfMrumA+XG4Tbi74zORx?=
 =?us-ascii?Q?crI9o+aMmOZB7VzDILPMWTyVn700SSnTtdGSzs3hwRUvTZX7tw4L7s5GZPSS?=
 =?us-ascii?Q?IpTm2rzFi1usuilhuz9ijqYfXw0hUyy8Ep9kBO3MSIaQR05c3Rpm1rReQyua?=
 =?us-ascii?Q?535nmKaVzaFIhqzQBWs7RhgwKOhW0TFUUxRUaheNqXS6gH+PpeVQ+NDhsTQu?=
 =?us-ascii?Q?+j6tGeRv5botm1DjGhfEhy5ZxE5Iaj5gqivz2KbGsiUV+r1bcx77w1v0I6HF?=
 =?us-ascii?Q?k65C7W5N0an+kYRTgMFuA+uAx0X/9PDkzWVawGpkgWK+d+N6S8+vmUEB+i6B?=
 =?us-ascii?Q?XnK2HYOGBVo6VgK7vkCYXE+eiltCaG8GfA6ABBeuu4mmGvQ0Jy5+QBySOjj6?=
 =?us-ascii?Q?Iz+aIyJso9ulBUIvOy8ROGczVNH6F/RcUYrl3sCBmeg30pgFZwPhz7TsEKGA?=
 =?us-ascii?Q?dLWnurq5cazE1jYOX1kayPIqUMaeQIxtZ6x5qjW+5KpIIqmFLLb2V/TR/io4?=
 =?us-ascii?Q?QzioWm2kT2vtJD+p7oW63MuzRm+9KgeavPNSCFIdTPObAhYId4f4rHdqv/d3?=
 =?us-ascii?Q?zT9qY0uXzs7KD/O27v8SWH07Oc+ROR8C0HmQM184s5g5q3hCkIEbJtm3/1jb?=
 =?us-ascii?Q?wpsFq76K1EoP3wH9gZtCgIlKs+1EgOOnfBzkG+mx0yqzc/I/I1tgM7mieQq5?=
 =?us-ascii?Q?x/Yx/0Fkr8vekQY1XnoTZcJIKQ3YQYAVXkdDuPv+ee8naDiEfpM/Xuxlv3FU?=
 =?us-ascii?Q?PbXVOmJ5DsT4Wzzr6uxskeRCoiZDJwA4ijOeHEUAQjccJfHJi7/Q72WJxgzs?=
 =?us-ascii?Q?KVPpL5YA/sp8mYo16jFTCBE2EPw69qy+NaU3A8YCGr/r7XEwbD89pWbvz7De?=
 =?us-ascii?Q?WRIptRe5+aLJqrEElOydDDuFqIRwlwYl55Gf8aDXqgNyXxVdF/XqqiYogg1/?=
 =?us-ascii?Q?HVU0o9kuDX8Hwr533XeNgMMJnjejTvPs2MjY1qacsC4KCJqcckwRF1bno3mH?=
 =?us-ascii?Q?jGqbn6xSluniSQvgsNhrM3hftoBsU3fDMZq0Kn+ga8UBu0O/JqeU9crvk6+G?=
 =?us-ascii?Q?cfVYqGMGhZkdQM5u0UDhnKWUQ+hRWC9ZASjKTjpUsX2ds3KCxVSkckymjm27?=
 =?us-ascii?Q?uoeL66k01yEECilVKHAtSsbwyHjHQOtFY6eYwE1qBtIC0UMLFOY8WIxVfNZt?=
 =?us-ascii?Q?J1tmYr1OMVurgfQkFVF1P0/rsN+3Z8AxHBe6O3YEbDGtHEg3alCfrNMKi1Fm?=
 =?us-ascii?Q?kXNWCa5dUNTWfwTKTXrwUjGgxchKD4vZwClFmodLiYEHtgeC3Ra6l5XhCNBi?=
 =?us-ascii?Q?XCyma91exOeahDFW+iXNg33B/AYfQFf8UC8NgfdNC3PdXBZdVGNlNe8CSnFs?=
 =?us-ascii?Q?xUxfgWLv/tiFHvPz8Ltmtm4jAwqC8S3M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OWs244fSd3NDUZxiLBnjBwA9uNroQRNV8ihfMlVM1Cu+KNG6k0AyI1hJK+yx?=
 =?us-ascii?Q?4U0+4F8tgQ13wlPR5qlyH/UxcILqHq7RPXGWE9+YWb2sS5ci1jggnKcaxZf/?=
 =?us-ascii?Q?b1kbLQ2kUefAiJKu8rebYZva4cgZuLULxvqag9qr4FuFdthVyspuVZVLrPWz?=
 =?us-ascii?Q?FvQtUSSO28zaBhaRFi+wIOjU4OpVr3a69N0YbTn0hp16GqWmzUIy+wQqX6X5?=
 =?us-ascii?Q?pygIQ4Az2+eUQcltW49EYUR8gaNySkItqBwAirSdNsGvyvaSxmyrkTz0u85+?=
 =?us-ascii?Q?a/X0BlnxYQeR6LB0m/T2m7wWBsvKovBUWTXwGv/aQ90qxDDUWVInHL+T0gwo?=
 =?us-ascii?Q?aEP68h2oKUKtp/dUSiI3lxk4IVZBd65XWRIgS+zOuwuUkab/sM4xJ644h1j6?=
 =?us-ascii?Q?PzfuRWz1Gp+Ogw+NRGo3Zd4fLAuVqbAcNkWbpRpjzK58Kzb7G6JKYsvkpJqJ?=
 =?us-ascii?Q?UBAuYPWmn22OFezluFYVJAmFNs+GlLJK5IC7o9dkMS7m+oNqWftqxW4C4F9c?=
 =?us-ascii?Q?LFi36IpTbzEcmmHMOXDHDnJXIKVRolunbF3mNFx0ouGOk/Sn3H1WBZq9ghKt?=
 =?us-ascii?Q?SPV5TBY5kqFkwQtQawqmv1sDS8yhv0AZSjmW+TtbLo5PXqeQP3Rx0YvWo/Rf?=
 =?us-ascii?Q?vUCm5s7UtdFPRB16W/G7MW5/tqhLb3COohBtP3AGroga0p8Csp2cxe4oBkHK?=
 =?us-ascii?Q?FoGMAF48/1L+xKbGKMHFztw+CWGPGhwDoA8yvX7NE7biV+743T2g105xLVEg?=
 =?us-ascii?Q?eeXoXVVPLtF3GkC7BW0JZD18sJJzn02f/nii2Hj3rzzK7vngKJBgK80tl33d?=
 =?us-ascii?Q?sE7KhsWmReiuTbfSpx2rkA51UwvAA+2iBylStXUqzrRCbwC/Yi3kGLtXsL/C?=
 =?us-ascii?Q?o0IH9TBDK/oRdf0nExmSAru/cP1EDR6XY4LQsEb2g/o5j6di5o8lfIGk/pxV?=
 =?us-ascii?Q?nlSYvxSKVXItf/MhsXS/oK2XVdGbVExOMvzjvRSZkbjFJxrhfgHCzI2B46HW?=
 =?us-ascii?Q?QW9HmkhNohkDe8BuH1oOLziRUpu5E17GzaDEa5yFHcKzUz81NklHMc7jcMIT?=
 =?us-ascii?Q?hLDzovXF9Y+oH5P8Pb4usHR1p37Jf2/YEcPs87GvzM7CjfrBBaHOVLxyFPG/?=
 =?us-ascii?Q?/OVSpIdKZg4yj81DM695BLmUqPbFSebW7E3aUwJfORIpo85/mm7ycN3M8i+4?=
 =?us-ascii?Q?hERBVqguIE+z06qowHJW1DAeHnWN2fOHD3nlDe+tLxZOH/tmnB0Txd5xMgev?=
 =?us-ascii?Q?Ygf4nd+coHYU4qQR++v95APlaenh3tJaJrI/jFXXtrbE2KBtq0aVOf0klOic?=
 =?us-ascii?Q?bItSs4mB8hvgjZe9xnkwq2DYAY3anwsM6G/iUTnIwQtYxF6Hy+pDCvPCTgtg?=
 =?us-ascii?Q?y1hqa4WfLfvRXgCUftuPybsoDAsgXI23h3S8EaTzdecQdzlSjWVfq81YNc28?=
 =?us-ascii?Q?RENd0bWgedqcBVSx6WVjGVDHVcdEYixOdE+o5K7cSjg/5xa/5VZnc55vVMqO?=
 =?us-ascii?Q?U1c883XOC1FBdH5PrONkH1VeIPWXUM3vrTE4MEBUuLOEcxAacCl0cHBlxDZ9?=
 =?us-ascii?Q?mi6Xbx1ySiHagSGVPxRdWINxnIy8/QOB41ffQrH8lY9fJSxg4ha9Hlv+Pzme?=
 =?us-ascii?Q?TTaPAZ27j/c20IZ89qniz0U=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae0972-a91d-4514-4d9b-08dd6158bbbb
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:29.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBS41t/pWOaIT8F3JKtib4Dr3AUyWxP34RzLJAgbNRDcpTaPEBQ9OLPpGw0W9f5aXTWqEcaY7HwHWBEu6RVnWpOk2Hw0EEEmwfdZfuiBJCmbrTjkoWo7FzCvumolB2WT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18151

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 725933a54f718af5362ec39971b2933d8bdf6994 upstream.

Add support for configuring the multiplexed pins as schmitt-trigger
inputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 834fac5db21e..36f1a82352fb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -139,6 +139,7 @@
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define NOD(off)		(0x3000 + (off) * 8)
+#define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -161,6 +162,7 @@
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
 #define NOD_MASK		0x01
+#define SMT_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1352,6 +1354,15 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 			return -EINVAL;
 		break;
=20
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		if (!(cfg & PIN_CFG_SMT))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, SMT(off), bit, SMT_MASK);
+		if (!arg)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1490,6 +1501,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
 			break;
=20
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			if (!(cfg & PIN_CFG_SMT))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SMT(off), bit, SMT_MASK, arg);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


