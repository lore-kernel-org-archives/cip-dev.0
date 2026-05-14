Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DFCCD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7018.1778751773077539868
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GNHKHvoY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.7, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl/4ZJl1OT+Z6QOYTsY0CszO0YDutuK33YVXV/o0WcwsaO+S2QR8wd5vOi3wcbOywt73BEMFlcVPh5oKBpkYqPtWqIbt2CGJD7ogtNDY6sdRnnOZ3DhJHXSYlraaSzleLnq4oz8EU1keV43pEzfztUPSe/n7VcGI1zghTz61brpP9pEl2ctDcPziHs3gTLmwVcJWtxcmWoVj9Ta88K49hTumxSIgGhBoBFpXMUrrB6SRCwgJ9pdoJlmPG9QLXwooNd3Bl3z5I3hENMa77KnRCaTZYxPlZh2zW0lGdLg2M7BvdEOfRypOuupjKliT1DcTDMXflIhlgFXdtV9NADtlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9LDo2hchL+IoBIHSHR3CDagB5UGk+tq5SvgK4r4sX8=;
 b=XKQqmfwYSrPzjvQr9ppjXDV3L5o6qvnf6Yh+xbUc3Hz/30YZ7DxpELlQd4a91pHW1fjtjYJpKZew5xlamyD29iDbD18YUGesN7yHx2F7XHtS+OlJzFzj/Y0rX7F7LAkCYFgbUjLw9IJymTaX376bMwELN62V0Ww9JbXKGSVz3zeRja2LHTr3DH/4UhNeOY5m11+/fafQ/DyRqZjtMqbwPQPBB7DOHV+JYqBOCT5mEHQYqQGpTMMozhym+3skkH78y80lR1kpPYRN+HrhleCsU8ycOi/OeCVRn2L2l+2AjgmfPNZxz8Cw3w7GiK+AXCUkzPxobgD58MXFaQ4THir25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9LDo2hchL+IoBIHSHR3CDagB5UGk+tq5SvgK4r4sX8=;
 b=GNHKHvoYDxTYRXeYue2DnzPnMEFjf5R3Szt+Ki1EGXyZJMjvsTJei2fWxzuwxenZHgb/qp7QoCKEe+k86Z6wdMwQoBbQ+QxdFDfexLS0bQLodTQHeIqf4QxgXobLsu5ywdX51vkX0nSz531Z4fkT0HMiBuJk0D2pGGdgqDJWstk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:50 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:50 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 10/17] PCI: rzg3s-host: Make configuration reset lines optional
Date: Thu, 14 May 2026 09:41:45 +0000
Message-ID: <20260514094152.2215176-11-john.madieu.xa@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f47ffc5b-f0db-40b2-b7e4-08deb19d29bf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	xDPH+j8M77Zey8V6Z1suCqSXBW1QSUA776Wk7JFBPqAfnJu7ZjPTYLu/bT/KqbAwUnp7j6RdRU0nRz1mEucI45gME/zHKqI0cQwapz9ks7cq+qEHB/sddZ/t6rkpNJ7PDrE/rYe+VIEr1RM7UEGGZcAzQUINe8hHKqH0FOdrVF+D+fZKjRPVZ+A1k8CyaP5oyC3InYJFOmmVSfZbVyClQXUI9TNZkW6GAWp50Tol9Ud8eNM5qyET75SANtOfwDSH4LVAYqETitwwCb+bBZd9y4Esn1iy5gDdaQlMFaPCAMsYl7qAYV1Pmi6gKnh2VevKqMXurQ5z6k/l689O6K/4YWQiZ+xiMSW2f9Cw9TwMsGteYcdoZOOtEzHjMMU4eNVVLw+ZMB+W6ieOO4fy6R2He1NBwP+UjChM+E+CG6MIKAiyC6M97v6+28oiP75wk1wC/liq1G4ZduYX9Kk74CQHWgkHonLyvxPzCDBlwm9aYbw0+F0YMTtre631AN2Q6/wgFedOuGMFayec3KREwfvUB9RMIAgEy0puadMXns04GkJvajoglzuVgAW8zQGyLfBwNEuL44aD2BOtrFxR5I+gFspKgYmarcLZL2wvoivV4jgK6MdLtCCjaayM4AKOlxD8C6u1ibhdXVDKj7/lalBEqnIaLL+YmImFNKHkE1EwS/TPxPuHQM4Z6e5vcSuqFP+k1jgtnF9VDXPjNL0/N6Whig==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OB7V2pgnsFe4xx5eGUppmDNLwhpHer/IFW4lf2jpXPF8jtuiDkx+LWGq+VKC?=
 =?us-ascii?Q?2P3OPLFz4GzhhTvtO59M96YIlB8XVTUttw6XetWVp+UM8nM4eawmtV/1Ooy7?=
 =?us-ascii?Q?WxiNn6t/tZRmc4FINASp+bzVFWO02oZO4CXDFjhlZKl7w982vEjnarEikmej?=
 =?us-ascii?Q?Do4YHzjE2kUzkWm+AJEcmDcEtgTU6k3sCfql+yRFHHLmjlxTNl+WODaiCcBE?=
 =?us-ascii?Q?WS3bXDDnNIQk4yjXhh6kR5Z5l34gUPRr0LgQAcdQ1ad45tdxmALdYfe6mljh?=
 =?us-ascii?Q?KaqdrfClGEW6dSU560m0nF/WsSea7QJTd9ootfJ/Icvd1FyJWsBxR0oM2yOa?=
 =?us-ascii?Q?yBsjHFyraWy8A67z9VdAe7gGAgSUvjf21QjlpDNSFGaV+wb0hqmH7Z9U/IpA?=
 =?us-ascii?Q?gUk1nRZjbtrhCoc4fqXxf9nPWCyBgblqBL1KqKQ0M9yV60pVCywbzqfEuTUO?=
 =?us-ascii?Q?f6chxHwJTkgET1C/S/YltWiGjmRKqv8c+6Q1F/6iM/USp5RdAVcLfbB5M0bq?=
 =?us-ascii?Q?LFMlt4MkK3xp9AcDH2ylm7G+laRgErcb0eKyZNR+piEC7qxK+Uc1ZUIEl14l?=
 =?us-ascii?Q?PfeN1MHQmYmBgiRk4AgHEz7xxhwuHNht4KRf9b2ivxUikIG9BSZcnXXKcaKP?=
 =?us-ascii?Q?PZWwhl7QebAjDSeW9IshHY74USPPdGnnySPmkrndJ2/JO5O890PVrab4LHi8?=
 =?us-ascii?Q?rGH4TvPmRvdaIhPhx9FRw3NPUdClr0wA2eBk0rMhyT6QrWjBgQA7fWZN7YrO?=
 =?us-ascii?Q?mdHK7JQrCLiPUkhniabt/bJQ+PmrEqK/xyG/qZrPxUwYk5sI1n3sD9EuO2Df?=
 =?us-ascii?Q?8P89/JTxx63uwX84Jf4qJsSNpNC0KZ0NdkUzFVW5dbUcCGOm8Gtn9RTF15q8?=
 =?us-ascii?Q?GfZ30lFklZ/fckKSGFtVfeLqtCCFsvpxSV2MLPJCJUvxRBGmv+uBsimAuha2?=
 =?us-ascii?Q?qqk1LODaB+AUfKTg+/UhuZd9tAzqDDy1fo/WNxRIzM3ZlkxoRqE14ziIxSdH?=
 =?us-ascii?Q?HSUhzT7RjL4iDpLIRXWtbBBC6/YqhXKo7qgIhcmFdej9iRb37YAmHYitGNTH?=
 =?us-ascii?Q?Xty7IyaPJhKi34IS7HcfqrICHAHMEOYeimeDxRMGiegGGOkXiXPyUja+2131?=
 =?us-ascii?Q?DAG6S3StcOFtLLKkNwx85NhyAuVC39Po+eeb1qyQc+FSmqb97ujGgiKARgF2?=
 =?us-ascii?Q?2RwPt2sFy2zjV0u6GPeV4VU1euG+J7PDAdUW8NZoXHwCleiHYl9KQjPHBzF1?=
 =?us-ascii?Q?cYUAuYXpTuTi04da39EtbIvwMBm9N1dqRD2Udz9tx89VwJvSGRm6nsOTK9PJ?=
 =?us-ascii?Q?Dysv/QGlrTJUgqVW+hTOlsmxR+HlTrKK1AMob4kg9LihLkCEG/+RVQi48gvu?=
 =?us-ascii?Q?KJCyHJ26bxI2QrN1bIKQf6HNIPJYzMQSss/12IeKIVXzPt06uI90MSYbksaD?=
 =?us-ascii?Q?szPNkkIgtzwTLq5JFnlpYs6s6v4kZscgMjwXY5lglyDV2pTitBdbRHM1Gz9F?=
 =?us-ascii?Q?OHA5Yu/F3xdkU8VNLzelAxOsxBk3r+NNp51Mp+DwRE/kPYzVAJguzo+KHCbQ?=
 =?us-ascii?Q?v2dnhXW6ByNZ9zd2tQ2fU+OrMqnD8W/p6cp1HucCl/hcWNLQDN6/72bgQRVx?=
 =?us-ascii?Q?qP1div+DiaXXDHYkRk2nWrlFFzJowGP/f/hgddOWpCxgpSpEBLYE4AJsOXxd?=
 =?us-ascii?Q?Qd25F8aSBj65Jw1/cJqZno7tpunUS1WWzzzAxDJTxYaWX6SVI5silw3QiUwe?=
 =?us-ascii?Q?NWFEy/8wuhbkCYXAKZsWhlJPWJwXzRQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ffc5b-f0db-40b2-b7e4-08deb19d29bf
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:50.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWKscGgI4hmLWB5aOBi14I9oIrvnxNxyTdceEvKbLHRmeDnyURXt4/UIwDeYqEpiTql7vFtOkK2uBl+MLKL4GOpl2L7OE6Gc6gwViaMic/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22962

[ Upstream commit 4ec4ccdaace40397638c305c0a36b423d2142a93 ]

Some SoC variants such as RZ/G3E handle configuration reset control through
PCIe AXI registers instead of dedicated reset lines. Make cfg_resets
optional by using devm_reset_control_bulk_get_optional_exclusive() to allow
SoCs to use alternative or complementary reset control mechanisms.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-9-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index e4102744aab4..8620d8d31137 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1210,9 +1210,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct r=
zg3s_pcie_host *host)
 	if (ret)
 		return ret;
=20
-	return devm_reset_control_bulk_get_exclusive(host->dev,
-						     data->num_cfg_resets,
-						     host->cfg_resets);
+	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
+							      data->num_cfg_resets,
+							      host->cfg_resets);
 }
=20
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
--=20
2.25.1


