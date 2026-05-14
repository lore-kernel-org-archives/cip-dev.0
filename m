Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC15CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:04 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7030.1778751781740561560
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=biMTGStQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJRK9thFbR2lLglNFy+zepvC2oOFIIq+53gDtS0UCbTY5GbQbA00U1c/CcDZzdQxqIm2QCadAM4eNG0tFJTvwb5Tk8jnnSW1DesHoU9sgZJsesdJ22eOLXtrp2OyeZjNfKufO4+OQb+lxmNOyE0myPpSBPUrInnEwbd1OF2dN0lyWKvOP2aSVpWzRqS1rlTGfCs2LhtrRQuHEsFkF5NOxWA4rHgEwu6onVVtM6H2sI2/I6cHdRyGjSZZmakEO51oQUDLKRqo7YktyFH62Sum1Z3/s6+PdRioYegwCIPGTOHWRFXKzR9WUgi18VYlNtbr0fMQT0j+K25mAAgmY3MR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qft2dpVV7mpsCe1g6bhNMHSu6MNH0ZQc22hTSxYGCvk=;
 b=oH6YYqajTLl9oe6AT9T+nmzpjRZTk3iw5/s3T/tZ1/3dikynOHYJTbo9aqLYbGqueovvL/geXy5BllWWnLbqGaaYaZUsJWKgKkjPZtLpvb1ybrxDaaFQ7PY+6/iOLoqC3R9NoZMmovRijAM3syj0C+tYtQ4PFs98zI6qWtDTVKXlbe6hLrxQeQ24999Mj20vtiIyUVXb67eFy4DdamoJrW17waBlqOlN1OsEQiAd6bGyeKjwd6nPMdqdlFfD0EOWvw0f9cAJC/QgmruMFYJqauXINAPhZU9FHPAJQHs45ov2wS+gToOhfYt/AZ+8gnpkC91MWyA+2Q7x74vKJl4A4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qft2dpVV7mpsCe1g6bhNMHSu6MNH0ZQc22hTSxYGCvk=;
 b=biMTGStQiUYGfDGQJA725viYvSuaP4pACCeXoSrWQjre9VfL4Jsbo4CEoWjJxGYI95Jg7jEOg6ecHp3BJ7TABjSDYJaQZgTVRIBjkFkGgZBKuMuS7/lMS7aGqxGqR3mDEFhXGZ1IE9n2lkAHiX2qpPJrBxnw6c3h8zJbSUsQY4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:59 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:59 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 13/17] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
Date: Thu, 14 May 2026 09:41:48 +0000
Message-ID: <20260514094152.2215176-14-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 737e6b16-8423-489b-8947-08deb19d2edf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|10063799003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	wNMfau+boVDuRTpyPKr171YZSoDgU2JqVQihTmE5xkSMwRp1bkZCuiTXnTWsN9Vz3O7HPkK81MHjXOGDDAjgBGQSJJTXMDzeu1nHKmfg4OR/06suxRYCYgRu3yvp1wdljYEZfWLM+CRJICWU6KA8vtoWLui+G9/CTiFHH6xVDE32DJuKjuP+U2T3yur4IsyQQ2DwFklZTv5Z4yS7WNZkXv9PontVYmGq8AK0yRYuOYdfYiAO6X7ksZBm3Lm6vrB7y5Dbb17t/6w8Jn3P+nfUQ+oDHV6IuAX8DQpfg6lOoyLf6rezlUOgvjmrPApo3teq28mmRhHa/3bBxTRFKwezTWjlMa5vuTd4vAoZifn/2MtKync4QBwSPpR3w2/92+17wrtO4xCUQ0iKYWreYTQh0WEVEaTL+36zJgI230aBXirODf54Tt1XORzP8112J3xuaKfYdp+V9DzmZsksoXOAxxxxzlWkPNM1mazpOJTZ+5pB/OB4+eL57Bp26hC+C56OnzGIpEXr1GhpOBoI7RLJguajA9HXLSMKh21ZiCDf3xuYV9YLD/jGpl9KXioP6CEcm/0RZqM+zSyxZEFSFLqh3xLmSeFVmoBHWvEju/Y8HNplAHoleNt71v3wI9DECvpBV0SRWJbjeVO+NBjU9lOFt3JkBYYLybUV8+IH93M0H7Nh1RZ2dKuIfDoZLMg3eD3hLnGnJkT28bV+CDqHBNGn8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(10063799003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HrumkQEDjpO4o1UCJSJx7YqtFTn3gd9AHHtRp8EA71xkIsjzrcDdMhY3urd7?=
 =?us-ascii?Q?KJM5klo6wf/ZMcPDwvpp7qMXP6Bz5plsmGWFt/lj37fz98QmGsyPDzb/8xSC?=
 =?us-ascii?Q?8hcC1W+qG9wvJGjzDvi1owcIlL8+iPTrGCj6eUN+ldTEY8q10/84kdjv5rtg?=
 =?us-ascii?Q?2558migGGe9fglZbvWejElEQL7sLYrEfOYgyFDNVpU+K7jB/+Wl0uSPML0eS?=
 =?us-ascii?Q?cWXmaravVCjPBR4oM4n+03lQAhYFKu8zYhOupm2fQnPwuI5ZbF5QRyQdwWTY?=
 =?us-ascii?Q?xJ3GAXdbXuPRZYd+4Ahbb3vpNQgOVqSIfv01J1Hpy+W5F/IAB8AQ5pX2zZTj?=
 =?us-ascii?Q?BZxChn5FSZk9M1x2hpX6rY0VYCbWgcVLlBK5ljshA1uLm2maT3sFy0mY4J8R?=
 =?us-ascii?Q?o3syJ0Wwen0K3QrBMIHrpExVc7zzrOFGmXQsDY5SCoehAk7QDTebytYrp7yX?=
 =?us-ascii?Q?wfVgpgzvRlO8Rtvtjc3gVdpio7Xz5vPag/FVueP/Go9zlZnsMJvep4F4x9Jm?=
 =?us-ascii?Q?t0rz2Sb4HESCI8uDpx5KUtPeJT+wLhnt0iVOZYVq1HxU+4itYHzt7qtGpz/T?=
 =?us-ascii?Q?SClgxOu8Yjrhx3YtNgmJBiuVbNyqGaY2xi8sbBqwAoa8IW1nZDZZFXureRGn?=
 =?us-ascii?Q?9qbIYx0KQnznrasXHVom3HrrpEtHgPxnCBPZZwVlpQ+N674heW7ngvt3Zjbv?=
 =?us-ascii?Q?hgS6MrUoMmCnN9+4e2q/S9SXAKfm0kvkI7FVNGXV9UJRNbDjb59c31X7+ega?=
 =?us-ascii?Q?ECd+sapoS/1eYkc4IzY69kHZd7H2jZE77ySf/DxbosNPIYI4p8e8tZ0uvZ7u?=
 =?us-ascii?Q?ryYem3u3yPZ2TrdWYiEISFA9OT8a8IfgqF2t0AJiq4REjbAF5OPPOodaVhgS?=
 =?us-ascii?Q?Hll+C3ssvkXr45Em0m2q7xckzHY21CV1FFlXH5hIH009F40xXSBQc230sqse?=
 =?us-ascii?Q?5JH15H7nUy8zDba4YqyhPgAXJFPLc1vi8f/z+lUnWNR+laBeTXiHMQBf2QQ8?=
 =?us-ascii?Q?BXdjZTzR3F7qfVg3UeDE1/9OH0xccM+pc+4s5YtakvxQIdIEmSbnE6RCCJs9?=
 =?us-ascii?Q?Pd2VcY+IpaBfvg400C2mwOS5IH91U4l1n5XAGKJU/q3/SCIlCENvEvyQ4xpE?=
 =?us-ascii?Q?pubI3ZN72bzPK604yczmRpV7DWxH31rYn1mIdb8pMHRhPQ+tprVzdwaLwnBc?=
 =?us-ascii?Q?RK+feDp+DHma00nLIU+g6GOJFwLO3KBhI2g3QWFVH5WNqWo03+3l0LpxeFh0?=
 =?us-ascii?Q?a+TSda+ERNqzBSSjy4egi8ZG31GfbFm6LODJK+i9zX6Zaijnpm08dlb3elyb?=
 =?us-ascii?Q?Yi4eILRt7SS7EMBpaI552HEyawulbThRY3s1lw9/A3GkIkBjD3gsNEMn3ouE?=
 =?us-ascii?Q?38dRjfEXKqgMZiPNrLs+0a5Wa3nrTNA+8mvC/Y7N6T0xo4tRVAlgw36ZdHyC?=
 =?us-ascii?Q?8L8Lay+O+a6QILD2YjYyCd4K8azVs9cUb019Y4c5Fw7BXyYnGzOisHeNyzPJ?=
 =?us-ascii?Q?vXyrIqcPVJMmTQTon7xbF4Er0PC6iHY9gMkO/nUL64dhKBijeTkaFm+6xIRK?=
 =?us-ascii?Q?fWNJ9phj2taUuA+0vVjrqV17/DrLhUcwC3eDwGeFOkhw56lUqipXhkmRCZtf?=
 =?us-ascii?Q?OMG6rMWM81kGjtTFLeLonWJZfQVhMgKuZOp6RDHcWol7bVz0tqgjG6WZXa0A?=
 =?us-ascii?Q?Nj0fzAsq2owrIS1os1zcy65tH6NTwH3HMlP3ikqBIXs3jpJwlgTZnsvI75rX?=
 =?us-ascii?Q?SjmSTINBOOjhdHn62vDvB8ajOS0lYcs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737e6b16-8423-489b-8947-08deb19d2edf
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:59.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhZknaEuIfdqYUOCUkfFMCBn3WGASLflLJuUMbm3EfbZ3Co85b6G8wfMOdcKFFfWCpMRaoHYe5mMsiacsM9cvnxFFi/O3wQoRJhIsDeEOOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22965

[ Upstream commit 5e9a5af5c9a2797a5e41e8ee565ce8108588f956 ]

Extend the link speed configuration to support Gen3 (8.0 GT/s) in
addition to Gen2 (5.0 GT/s). This is required for RZ/G3E PCIe host
support, which is Gen3 capable.

Instead of relying on DT max-link-speed for configuration, read the
hardware capabilities from the PCI_EXP_LNKCAP register to determine the
maximum supported speed. The DT max-link-speed property is now only used
as an optional limit when explicitly specified, which aligns with PCIe
subsystem expectations.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-12-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index b3fade8443db..39828d8f4e0c 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1026,8 +1026,9 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s=
_pcie_host *host)
 {
 	u32 remote_supported_link_speeds, max_supported_link_speeds;
 	u32 cs2, tmp, pcie_cap =3D RZG3S_PCI_CFG_PCIEC;
-	u32 cur_link_speed, link_speed;
+	u32 cur_link_speed, link_speed, hw_max_speed;
 	u8 ltssm_state_l0 =3D 0xc;
+	u32 lnkcap;
 	int ret;
 	u16 ls;
=20
@@ -1047,7 +1048,22 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3=
s_pcie_host *host)
 	ls =3D readw_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKSTA);
 	cs2 =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
=20
-	switch (pcie_link_speed[host->max_link_speed]) {
+	/* Read hardware supported link speed from Link Capabilities Register */
+	lnkcap =3D readl_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKCAP);
+	hw_max_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, lnkcap);
+
+	/*
+	 * Use DT max-link-speed only as a limit. If specified and lower
+	 * than hardware capability, cap to that value.
+	 */
+	if (host->max_link_speed > 0 && host->max_link_speed < hw_max_speed)
+		hw_max_speed =3D host->max_link_speed;
+
+	switch (pcie_link_speed[hw_max_speed]) {
+	case PCIE_SPEED_8_0GT:
+		max_supported_link_speeds =3D GENMASK(PCI_EXP_LNKSTA_CLS_8_0GB - 1, 0);
+		link_speed =3D PCI_EXP_LNKCTL2_TLS_8_0GT;
+		break;
 	case PCIE_SPEED_5_0GT:
 		max_supported_link_speeds =3D GENMASK(PCI_EXP_LNKSTA_CLS_5_0GB - 1, 0);
 		link_speed =3D PCI_EXP_LNKCTL2_TLS_5_0GT;
@@ -1063,10 +1079,10 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg=
3s_pcie_host *host)
 	remote_supported_link_speeds &=3D max_supported_link_speeds;
=20
 	/*
-	 * Return if max link speed is already set or the connected device
+	 * Return if target link speed is already set or the connected device
 	 * doesn't support it.
 	 */
-	if (cur_link_speed =3D=3D host->max_link_speed ||
+	if (cur_link_speed =3D=3D hw_max_speed ||
 	    remote_supported_link_speeds !=3D max_supported_link_speeds)
 		return 0;
=20
@@ -1654,8 +1670,6 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
 	host->pcie =3D host->axi + RZG3S_PCI_CFG_BASE;
=20
 	host->max_link_speed =3D of_pci_get_max_link_speed(np);
-	if (host->max_link_speed < 0)
-		host->max_link_speed =3D 2;
=20
 	ret =3D rzg3s_pcie_host_parse_port(host);
 	if (ret)
--=20
2.25.1


