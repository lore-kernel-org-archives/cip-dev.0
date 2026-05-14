Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FBACD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6981.1778751644786602955
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FtdCFzdg;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.59, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpuAC7Dh70U/c2LBWrwp4t4e0/0xUn+8onWu/jmFaujg2YgpLoHFEJI+Gb1C0YfW1d7h88P52BLKduA7gbKnhEt1st6C7cdHfJ7iVVMZJNYPd7DJKp/v7jydmWAHejsBnpZNrQrDuQxo/pDPqEkFf8weBkt3NBF36nF1KYbsrXkCvlYw7tuTtSuB6knArDRcVkb/S7vwGV5OpnkuFaZCG1xR6CBAWWGxKDY7RXhDRnzQn9hEqqSkggVgV9GXV8lUyGk8hF3m1BBjKLMXyuqX3VLBtYWgJCTmNxOamUikoqee+Eo/2erMy88joC5hzdwjlAUvNipZ2NImoU4+6rpnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qft2dpVV7mpsCe1g6bhNMHSu6MNH0ZQc22hTSxYGCvk=;
 b=lx5/7cmjMpDY6i9yu4Mtot/HRNYMiji4nSqQM754FwOZ98v60wdZF1Eok8vNxLYYf8EnPAX7NiaxmOcboMBS2uBhPxMnXoxaHlXDAo/BCFRVDemyVYeydufLfruhenjNl9nHjlz0h8rC0FUyPiEP/T7/i5Qlydk+0XNGLifvmASiQOnd8/QSsv4jCPTgcsDxfEGf0J1Ue89FCbYePZK5e0QCu36mVlNth4NpaITVevCOi/KjR5gIGD0C0MZ/hNtUlvareLAwGU2i0yA9BNoB8pM8ibPROmYVG5cEDc/ZvNJdd84UJZXA7QAUPyDuLj2W/mmYpatxWlAjZFvjPtYtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qft2dpVV7mpsCe1g6bhNMHSu6MNH0ZQc22hTSxYGCvk=;
 b=FtdCFzdgyTARgA6hXIyquU2wBqs7p42jE35cNnD1a+XdmOH/S3QSTijSjU7SwfoKzxJZmpPZdY12FwYlLhIUdm+3wcsBql7UbdYNCY/urO9JhgsXnUbFh64YlJjj7zN1ARDzbxmhsBNNq1wpkL3jiCFHSLU+NbSTzaK46OI33WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:42 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:42 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 13/17] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
Date: Thu, 14 May 2026 09:39:31 +0000
Message-ID: <20260514093935.2212718-14-john.madieu.xa@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: 375634f9-5ca8-4205-477b-08deb19cdd78
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	3nKR5gxIGooOiPPi3jH9ZYh0wKYoqs9LqbOQKs8NpLiPvtC8bh2lcYH/cPin+nXAH/187l/xDlgMNcIWyMI5JajnGz/O0SuP5v1V4M7yz5/KIVuT/TmwAhmFh/PQmvEG0NMJs6ESMPJy+ZTVgpxUyXw2cDmtVmChs0kO7246J19UJEKSqBedvPWNETlDt9ylzWFAqWa9DsFbpKUPdQfx7rov/gY7i48KTF/3RtWr6vrURrmd1LtA65VdoWlROJG8Tl712aN4rncIt4tiPBy/tUHJgVV2SJIkm6xw8h+KIa79Jotom/0rXQpVj+XUvpeGZntluHAABHn3Nhn7Utpml2UqS813Bn78vPyJv8adszL9M1/5Ks9LrV0tumeb50G8FhxJxS2BPe2K/RiL3HtZNZxTktFiQq+KApltpFhs2WBrKXL0WquJsuerj0oJlIniMbSprefFCv7aSE2zGpF6oplQf0R0M0SG8XLrDedPmHzROztzCy57SEqOVvEE6eOmaLwimEx88LrG25Mc+GWMx0o4BUcu93z9w9Tvf1hlGvE5+h/PjUpT7AunmW/zzhNu4Z5uypdvQa+P33Lstem/6UOngbVO9PXlwoIlhF+k4GkVy56ex8KCGDsNU425M4cbWypn9kp6FvxOHNeRBAUdohuK4vBpgDBfo6gatMMNnWOZ1CiNRNtjSrLPDkWWWHJAu4UK7z+PGkslE9dNVPUnHg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3xJtTQ4edchFyJj1HqnasNUa/9piIvANfhiB9RQXU+YxsQv1xlMiApopbHuF?=
 =?us-ascii?Q?D+EYo8CIxNyAbC9KE+RckieKfzNrDC3H6NLAFq6cXcN9ZHuLVvT0h6Ec+lRW?=
 =?us-ascii?Q?xtU3ZsFippalxfKdDAghmePwpMtcTrqQ0YsMYx7A21XNc7dDoT+EGLmYdhdZ?=
 =?us-ascii?Q?rY092q1zcqgnUgOpfk8eF3UaQPxP55WRrVlMVG5Z4T0n1pN/NbqlBjnx2Zpq?=
 =?us-ascii?Q?j6vr7HCDjBFMgw4C27/gMIAKLjYvkIhpldtZBVR3lLEp8wtGvQdQsI697+Ol?=
 =?us-ascii?Q?8cYTudVvOCRkRw6DSfq9tqeVeHGgxPWnufL46PaOsFYn7OWUBurf1LVqQaUQ?=
 =?us-ascii?Q?ECsDkZMwt+GkhePinHzRpHaTS7HMCvGvpYjj4N762zWy3Kn2K1HoSyFrIkt8?=
 =?us-ascii?Q?Og87hl+mQHXHZIO4IFZOAVHTAd2PtX31SfGRu1fH9jB56jnyuKcI0vVPEhqr?=
 =?us-ascii?Q?CTUGmZr2LakvhbQcGsAhLSRUp4lsAcgCyl6JJI8sc/Z8YqH7c1Zye0eNR6F/?=
 =?us-ascii?Q?xXbHNk4VS4AK4M2jppgY/et8U3An3R2y2JB6E8VUny1TAX5GHevPrpGIdVqw?=
 =?us-ascii?Q?xc8Wnh8b5A9Ev09YVb0TCD5yFjJelN+TnwNeEJrJBwpeP8O8FXlAz64MDmlQ?=
 =?us-ascii?Q?xIIKTVge+InS2IjYGbjm+bJcoMx2YoL6cK2JzEz5VZLKRDXynEs2IviJ7t+M?=
 =?us-ascii?Q?dszFy8BWRfwXQyuVMcbuvTX/pi8Rgq9PCKquTfFRWh7CACT0u8TJu/Zes7Vt?=
 =?us-ascii?Q?LlQwH/imXQdb+8Q0pf530sVt6CbxbILwKBB4B84HNRLRukw9hHzdhtnAeggz?=
 =?us-ascii?Q?XnQZwnFBf8Dhbl1KC9WvrrRjfWCDMW0rjUbuYnP2VbB+BF+it/8vHVcB5aJf?=
 =?us-ascii?Q?cZqOJ1t/Yukv/dddNlnqeSkaRLX0gZ75BVuOQkLK71oOGmxsBYPh4LSQMK3E?=
 =?us-ascii?Q?8hiAqhEtCLXPtkdXBzPWXCLmCmcsDFDw5Df2wPWgVwE907viVfU0E7Ka+XTt?=
 =?us-ascii?Q?T+Db0fYAyXYm0cpcxiFQmpUT4p5Ag6hV+EgsK7oJ/aoVanHpuDaXR1CM/QQq?=
 =?us-ascii?Q?uMwTTdViEFqY5efIsIt6/OLr5y9/LhTSJKIyG70jcb3CBEBPDhiRzwyUmPXQ?=
 =?us-ascii?Q?C1bsJpgTpb2/rHdQdU6i7T7yt/CWLqxwxNxKz4LjkwDotolcoBIatL5dx/1k?=
 =?us-ascii?Q?hgAYsH2Bj/YXZmEaC8Cyiu2CUIhRW+ogVqPXiislXSkdkR91vd5ruEU09yzs?=
 =?us-ascii?Q?ubtxMv5ICR5iVmFbk3iDbxfUIOXhdw9zuyVs11+ta8lGVJNWzw9mfefQZD1i?=
 =?us-ascii?Q?bO8oipBPFDfGQ39tOHyWry7AQZG7zNaTXi3px36uir4eGeDVG3QgjyY00UBW?=
 =?us-ascii?Q?UGpDXLfS+VsUjgHtiuynj1gq6exjYAkTVi7L5yGCJzIURi0dbsnKzjogdGkP?=
 =?us-ascii?Q?Ki5jtC8iR9yiuvi9mQqbwdAfPCnKBajsLoLL3AnBVgdZoBzf3OZUTSVy9oBs?=
 =?us-ascii?Q?9Q8AMxhf1jIXomlRZ9O9hpKd/QDVgrCxyZP2wVdYpPWisnWgiXHiKB1ZrP9U?=
 =?us-ascii?Q?+UPzmeNA/YEEhXlDPgmVGOea6hJMZLIfbUPOYUWBFo7iasrkPc8Q7DFoeShh?=
 =?us-ascii?Q?tIsVRAxhLE9XVEF1D2MH0kTS6P2ikUd5vw1EDcz9XNPuCgmV3MbDcc0RB8sC?=
 =?us-ascii?Q?C3PVrCsUl7cOiw+lsOJmIrNJT4OJnAHrQenJUZSP7cDjO0jNJICzVocmIWUm?=
 =?us-ascii?Q?JnxxhNj8YIEQ3u3zEEBM4C9BdJgyzc4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375634f9-5ca8-4205-477b-08deb19cdd78
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:42.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0EGeeeTqfvPT8+tLQHfcoko3y0bBfm0jIJIpO8tHjVmFM2sEAYyXu45BjGLO4XFzTb5hGC8qyVMuEdSWW0C8P5ydPgkyMy0aRPuKCNJxC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22947

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


