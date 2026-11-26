Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.301.1795708151170523017
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OECmI9E8;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohH7WhTY+FvgO2TzR9M2wUImf0/tmWql15/C09KFhivxJT2Rd3BsypCpJ+tfu4oVw+RWO5R6NAiTZJt5O9t61oVyph6ySyciOGOZozaKsPHlACj9qsvi6+DP3GIyvIIUxj5ysT/2OlTT1FaIzIQjf4Y5RRcft0xERXTAJtGbHaL5YJC4/WGb/pI7WgXFpqH2ysaWrMJCA2CUXHjriMOjAtYSzfIiqXr5RK6/TffbCeRm7GxqfNJkSsNwingbMOMjY9a1bbpFfxI3qHryalUFr03kwAzjNPLb9p+V3MkH8y0eC1ecX7AI9ILIVmgGlyQe3wwqoAAwJQDe6RfwQuIbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWqTXJ5iLFhlRSE6ztQQzcenLBsGbphUc76BHek4+AA=;
 b=SOtN5z3BtXaMipp/lHFpcII97/k0NIdz8a12cLMN3U4TWfXeGFC3MI9JllfquS7YlE6ngbJ0MUGnYI+38LXe82DoGlPYDf2hVLzDQkdDDoTNeFM6IjlZQS7fw1h4nAT0PKbhQd1GADCAPd3Oov1Wrrq4OXNnuuB2stFUR/B3YTfPhnTROIzGYdzDnlnyyYaR/P0cVQDwu5wq94AymqVRclADEARWt1wsWIu7Beij7zoHzMcu0x2Vya882knWUEJm+wxRF/y5TTddl7Bo9zPSYURuSjqcqg01HGR6cSlzSEQfMFDKDmM+FjpHL7+v5AJ5pMWBcCs/oSsjsrjAAW7Btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWqTXJ5iLFhlRSE6ztQQzcenLBsGbphUc76BHek4+AA=;
 b=OECmI9E8NfWAEixIqIC02koGTHbqh7R/UKiwPZ7mPmWVtCZYCtS+NNQO6zUFegjGXOUUfkowUyLZWGBhj3TefTpAZZcX+TXxCH/wJtF1IjnQENAMlvjPL7zvYxw4qAEjlNDAzU9c4rhz48Hajj00KJqOwXQfNXGbE9rGZ+GuW1I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:08 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/27] dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with CHCTRL_SETEN
Date: Thu, 26 Nov 2026 16:47:41 +0100
Message-ID: <20261126154747.3832917-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cda5ba-6ffe-4e7c-e998-08df4bd4cecb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022115727099003|261021133027099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261026135527099003|261021135927099003|261021130227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: JjY4/CAOKp9tucHka66X00zH2V/oNvtcvyN0uHfeu8lVp40CtiXce7DyzAHxfLwzS74QKTFvmoue54D/Vb0OJKayu7iF/8bi409x9fLodQ4/aYXJT0RW/TD2xSAd4v7tjz3FMo/iDjpx/wjE+xecPC8yD0kxtdBSO4R4Mte2OeTmbATxCkWFR+slkl1CNLmWeDhHCoXoj3iAU1wC121gfxu6jFm17b0prFFdBB/aMnr3jl7KZa97ldDB8nwLWiwZ/xDaKMJlci6Sarb4V2m+V9EZ4zghYN7D9P8qOW3rFAUohoilVCJW0WkmBOzlhw21X2SY79VKDgW2AZjI5wQlxHwnd3yLCVscqjc2XrvCAMKB8y/coGXQYeI4XlikCIF3wV1wECR1Z4oYZdfa07OK1wRaL8xi8Y8YaSoqYME69YO/FnctunjFvwayCqe2HBHqFbc+4pbgbe5NBIC/OOUQlUFi2xDAgR+b2ddHIXrJfnLX+JlicN2f5evJ4c/G+BIUrcHQKueiTNr7XjwsIvNjaYoS5fwRsNBRdDWIYtVh0rJLZm1SaLKglxTkoL0BQFTQ/r4zCH6F2oZjEJroAsf+kv/gGsIGlZqbSRpL70bO5iodmRwjJjaY9r4LrJw42b1kU1il6EcK3GfBzdfG9J+Z4z+X8JkC7MjxRcqgiJMpRAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022115727099003)(261021133027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021130227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYTFjvkItQ4WrgHUvcj9OPza3VNx2KdvKjI4DS4pLv6Sv7XCvj/DJJd+w2gp?=
 =?us-ascii?Q?dmr/k2uY+airFVgekDRKHrx54/CfnjKQWlUq2OK2bJOkvXT6nTU2zuwiorU8?=
 =?us-ascii?Q?r8qcJ4YjH7tqcH9UfHb8XZoO+KW58VLKyxM08lCj8oRSjfEPIduF4khIkuqc?=
 =?us-ascii?Q?7OtNHltc7ksRDYsTQHvFLinN8LKzUhSUxvoRTCDQ0/iqSqkO6IRIFk+DHDMg?=
 =?us-ascii?Q?LGS0ACcPIidweUHafLTX7jZWRRA/UGm7J4cD38zt9nOPQ9/7yukY3bmN9MoC?=
 =?us-ascii?Q?rvEl29ORzRaLiYLY8u1BSYO5v81VSrKVWIP91JB15iIG1pDCbv+ZiF6ma7MZ?=
 =?us-ascii?Q?0c4jn5fMHXnPyvDqqEagQVphUdZ7zVn4OQm/5UedgSE7kmWF1Uul88fPRUN6?=
 =?us-ascii?Q?tuomP0vDXfoMOfWF3c0s0tJM7fY22HOZZxQPxH5XEvP0lZkTlos1h4B1iWp9?=
 =?us-ascii?Q?RKobTjpBBIoGp7iSFECmzGKrG+ucUAFtaxxZhyjVWMrFr2LmqdgkcxGBoAQb?=
 =?us-ascii?Q?mjGenIHpIqK1B9LLItrHHoHR5En3zVkWazWrWZHOYg+95lnnw5sPm01Xe7sN?=
 =?us-ascii?Q?cJH0LurPro3NTsuVkd2jpfdLq3876S7awEZ38z0Ms8TSb+hVXhDCWO11jESp?=
 =?us-ascii?Q?2Wk2hRN7Q6sAkYzy1rZPoOn3tvNm9EbxY6rA3mvLh4boJBm+t4Ntsj3kaB3A?=
 =?us-ascii?Q?Yw1b/JF4w1hAu2C8UPgHwe/68Iu+Bhehc1tSCOY/xTMBgg6i7YYvf2w6MEgJ?=
 =?us-ascii?Q?CTOH+bti2txwshLlKaR36TZsYpbJONuefJsr7GgAADuYtq/Oj/B5m27ejnSV?=
 =?us-ascii?Q?LtpMIvSPnY+Nk2bRK1FyuJ2RfdGF6gOzIb2wCtX36ylAOydqRsqYpnzgIotX?=
 =?us-ascii?Q?Jy5jfkH93Uq5lTB5JUtSFZvUeE0oCad3SNTPOFJmZdSUyaFUoIQiA5scoQF5?=
 =?us-ascii?Q?bFEZadQyi5vuknVYb/WgHwSQO89UbtcGToM+Hc7brMzGiiE+tTOupUFZsPKK?=
 =?us-ascii?Q?qEHt+3V175vJjXWbYEaGOeJwvc2KWaU3dSeVEVKdDHfpY3w+P6AE2CoOitPM?=
 =?us-ascii?Q?SZXQWeVNydKuRnsKvnivrgT+CbTUQknn3xeJ9Nd1WH6ukdTzm/F/0eYffhyS?=
 =?us-ascii?Q?hTmvPVUjjqQ+SIOIh+7PaWkcHpZYyqJdfHDPNeP6oQxKwmLWY17zPBHzNXRy?=
 =?us-ascii?Q?GuDtj0WusS01mSlUhS6R3aXQomzbtTzpdEXWGWyOaiOjPwmRxmI8hr4hBJlR?=
 =?us-ascii?Q?h1VodoWsC0ruU5a9k30eGqF/jNxAvaz2/hlNjE2GebC2Gs7l7kAglO7Djey9?=
 =?us-ascii?Q?93PRYC26QQzZWamhE1WINCnamLlrbjXV7tWj0U9/Nrecus02XzTNXnSvKZHI?=
 =?us-ascii?Q?Dqh0PL4oeZDA3RmZ7zRU0+WM1hEGmMVUf4K5SXc/IDZzTIedVE9Q1TZWxgxp?=
 =?us-ascii?Q?C1dVYY6znyOYxYhm3PpgtuaF5GBSEjEEaQXw3g/kp6EYBsRL7urOc7OTbze+?=
 =?us-ascii?Q?c2ROMGc7oI1IxhtZ9prtLewaR+ixPJzVGFefbB/iNQVci2lYlWWE6C67oP1a?=
 =?us-ascii?Q?CJay6DNXT7hQIgQCVfke/Bg3w62OE/S5BEEXurvhCp3snvpEtYA7gpRLxUDk?=
 =?us-ascii?Q?Mk2hIAeS1lV9gxCyAGOy78JSCj+DVokQCcxeU9lWX3P6y+JXuuxMcsRk1u0H?=
 =?us-ascii?Q?aJLhtmsTLPPcetDaPs/t75/0kWsDv78FDT2FfZU8mnZx8f7gh7P1937tG5ii?=
 =?us-ascii?Q?C2qBlWb/NZnsSDQQwtrBDrRvyY9GQYkNwiIVrGDDRllqHAUx0EgX?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cda5ba-6ffe-4e7c-e998-08df4bd4cecb
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:08.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0dGJvSDhDtMfqrRKFq6BMvH7Giifb11qbFEBlUEur6FqAqmdwBiATNSQYXje6hZzfRmlsMYGTUuxNSpLTywp5iXHSgnA3cH8RwOj+9NLJErK/2Uzps3xLn3n5b4dUIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25171
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e8baee1d1cddc8e2be7bc362d6dc3fcb2021e873 upstream.

The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
struct rz_dmac_chan::chctrl with this bit in
rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
is unnecessary in the current code base. Moreover, it conflicts with the
configuration sequence that will be used for cyclic DMA channels during
suspend to RAM. Cyclic DMA support will be introduced in subsequent
commits.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-12-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f96d1ce45271..1ebac606bb4b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -376,7 +376,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
=20
 	channel->chcfg =3D chcfg;
-	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
+	channel->chctrl =3D CHCTRL_STG;
 }
=20
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channe=
l)
@@ -427,7 +427,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
=20
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
=20
-	channel->chctrl =3D CHCTRL_SETEN;
+	channel->chctrl =3D 0;
 }
=20
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
--=20
2.54.0

