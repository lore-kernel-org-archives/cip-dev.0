Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F2CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10929.1781685101084910918
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IdANSDVl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQp89wLmoXMdrXi3tUgsbtBOcKdR4mcVFqQhpBs7XGWSevqA9vUIs34vYJs4uo7PXwRSTmpm+EEV3tMhCG4cc8D9MWkyJG8bbvSlJLaVSngGlloXwJG3psgsCJnAKD9DzD92MdcQkvAy49skLLl3KKqtEynaR7A5eXQCrx6NEhcupZvyDDJZ4ovIEG6vq2AH/H+/eanh4c8N1rRO2HntUblynA2puTVgD0sQWFZ38EBZ2TqApkYrCJ9DAjYbnQGdlDYwIAFwlSDgO5RfjLZV7vgW+VJ2EbzWpPDjXwE5tDoyenCUUbYQU7Vi8fiUYEFnTa/yOWIPn1pXBVcKElSL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p81Q2q5Uiuv9zbdBiw2nVjn3gz4+JLXb/4HiP3oQa8k=;
 b=U8omC8Te1e+fG1KBRn5ndphvR/ksk9hIzU5mzkOPmxtA+shFv6buUV2C/FLwNjrX34D67pevatwTmJneEGMuTBFIvY7I0HC9eDh2UGb0E8EUbSMwiR55trrpKe+dQv54Ln8+jGosbzkmL5VMi+3MU8+JGOekL5iunXUb5oVHlQaGU2mxg8JAqphcWKmvhUJnYk/S+SiVEneS2zBl7gDzg6Bnzt/BrNm31iZUFHQnZejp1UjwDzeGcUBoDAY+T4+DrwL/gdieTViX6zGmu3cVj1pkTTRVmvLaTMM/vwXno84+49EV7mQLp6XxQ5cThmibEDZ6qiC7GqKcuBDmK1ojTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p81Q2q5Uiuv9zbdBiw2nVjn3gz4+JLXb/4HiP3oQa8k=;
 b=IdANSDVlEijRypxura9DpE0HDG3mXGfR8yDT9KVy/gsyVi0fNOsl2oqFtYvuSkZ9HkY9s6Gu/HfUc4waNHkdpWYYWlvJ4T8QWpw38B6gdjWDvySIh6oFCY4VMYVhTj7uJd30RrHMRUmD0+NwCDe9ENyt/Wf/8WBlrSZbGeLqs3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 24/32] spi: rzv2h-rspi: enable TX buffer empty interrupt
Date: Wed, 17 Jun 2026 10:29:55 +0200
Message-ID: <20260617083003.1071543-25-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b055dc-cf94-4ff8-f687-08decc4ad9a6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	cu21Yuwzl/2llJ7ZqUQ+r8zziijIyHM+YFH2gHcrtFwSGpRVBLgoyp8toRoZAmk79rz/YLZiuIaySE7P6ZWRb7q0QykrjsC1LUZzdGIeQMW3ZUfslSk2sUxAmecBVlRvbsahFyouZpVfECMQgfn3xgrP1kGpZW48yg51aW+eMamNLZjnxRQ3LSMPQHFRSdldnYQM8EmysMJ8mji+Ehpoks9g+3phdzsDUdKgIbCRi9wMhYZGow4vHsHrXuc84vjv5wIYL3O/6TWenn+7czqh2h7eTKxSy8rWNW2viLkTuGH2mDkQ0QgR//LmYfmtZjoI0xJgGEN0DkfxjCVO1YF7TakN6v/8NZscEgfhkFpTqiyHl0qkSbpW9k/R29xqgo0YD4TbvDPC8gq6aBt9Z+5S3P+H6gcoBGC35yGbrs8stjkwEfH6Cg42PSnnlIgTqUGgcsIOIWuRc84bOww3JmXo7OL1w55rzucOXVi6wGmc36Ul8gLA8KtczhpdejRef3WR2pSMUKZRr8XYhxKZz3o0R4USXDYkGaawfmHvoWge1DNYhAT9eAyn/wp4D4NJfORFfGDGaIq6fQK8qV5h6J/C1R661KDXxe2N9HFLEUwhF+sW2hEMNV+PJvt/Zh4CeSA3hL4teXMSbua9w5BNqWvoz/SHSV2tZ51PfU89ZV6fomMF3lguVFA6g+YSQFKLMYBRdWvEWvVtQxX05qsbudIPzQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3p3yl6QmicRgkQWxs4cXslIhlPDQ0tKPGDKhZGM3JCcx5VHZmBMdGH1O11G+?=
 =?us-ascii?Q?Cbsh2s5Vslor3QRY+rb5amTVa3L6nNdAOOBDVvw1CF2FPl2nO3aKlMuEpocA?=
 =?us-ascii?Q?ysdRotoXoJzqKxeFoR3PWqsNXHMq3aOgCQRwRmzyBFGeEAkmPDg1apyHNTKw?=
 =?us-ascii?Q?TfcRmTygdcnKpIPE5ec5aez/myWYGsXfZZY0lmRu1Qvn3wBMhOEOKTwVLZpK?=
 =?us-ascii?Q?FAn94IcpXfRUFs3oSocLxQbF6uU27Nbnm8OYtxnEt/zGDttwuUGE/saZ09B6?=
 =?us-ascii?Q?wQxyupZp88kfAp4t/vBFF6doXqhcBDV1AG86ATbPI834UyIpb3nJjG5H1yup?=
 =?us-ascii?Q?SQ3IqxjdyDU4R979u6dKdDD6ui+mq/1fH//1FdH9Oy6tnLq/p7huLjpTDDjk?=
 =?us-ascii?Q?HesphqOiScMUvBjeDHuKwvOerMzPyiGQnrP+zmJRzDBChBfRq05i1EH+Y+ul?=
 =?us-ascii?Q?Gw4AbK3DG94M0Ws4yzDHuaNm4dXqdwY2BNJy2EOHeRQfj86RnFMndMbJb3ZP?=
 =?us-ascii?Q?Ut8xdxK5z546hYaWo5xuwY/q5ZOx2vzpjjfW3qVhimuYkC0QsHLpn2HzHPxr?=
 =?us-ascii?Q?2Ck1o0RHJNUSW7ENqoMSpGJFqvvRsZLhfGa6l6LGacRiaLV0IzqIWntXI78P?=
 =?us-ascii?Q?sJ4xLP0ySagmai03wYdMCtHlXf7/Gq0iaUFDUBETsRdcy4Kxo/ywLSunouiM?=
 =?us-ascii?Q?EeV7tyohDXuCi0Z/ylhiCVYqSU/eqhYxHpjQ9S2sZcqA/Jz1hM4XKT340jR3?=
 =?us-ascii?Q?BtdosTm6BXAXpLzUEB6TKM3H8esgz5Juhshl28/dcBUjymGOIIU5QyH8iXeh?=
 =?us-ascii?Q?7nAzdWorWWehSLYLlF6UByBnSj9nQ1g66vYf2Okh/k8FzPsjDPXB3Yid/OjP?=
 =?us-ascii?Q?fY+2vre7EPPwnbhmUKtDi3cn10djRApat0EdU6UOunQaOb3tV2/Cg9WDfSDr?=
 =?us-ascii?Q?zg3y7y5mqbrUeNM1cUaasHLpvovBcm8wWL4Z6YL3qvoYmTjG+VVXmjLTDW0A?=
 =?us-ascii?Q?6ylvJsPnB/mfBV4Q54KgsmUTYppytCDuviUxCRtQ4ztzy9TrW1cbjla9yJ0I?=
 =?us-ascii?Q?/ygeK7b4De3IOs1wkmbcb1CPiL2bHvteX5K1baZmtLAZTAivGm8sfZY6IqNb?=
 =?us-ascii?Q?hyNHo73jQPUTitit1lBVZqY8qH7Y5qAWFMO0n5XHwt68F+oyl0hbXA3iAyau?=
 =?us-ascii?Q?1CnSy9t1m26+mmJ6QtiR+If+ax4edCDg296FW6PW7eBaUULx6HxjuPMs9TqD?=
 =?us-ascii?Q?ln1v8nNrYJN5Evc8W4w9vTX9eCvEcm4TtN9LL7NpT9qwYdLMMSorMwoa0l7g?=
 =?us-ascii?Q?x5afFG6yvu7dq827+Z+MM4khzViVJJDzv6dWepNbS+vCoinAKM2SQOFcpW1b?=
 =?us-ascii?Q?bf73jlM/pxBfKE4owoRd0CFhkNKl9xO+kg2/CrmZyESuq3xPfv2JagyEYwoT?=
 =?us-ascii?Q?MqvprF9GjZpMgYRaNhrSWRsfo5dB79nGu0u5jPNeuxNI6FEJXW47KYF4Rfee?=
 =?us-ascii?Q?qHS8Fswg/hq/qIN39PoclBxkxpAp5D/zKaL6bxA5eVnGwbGcBlGOsqn0wtIi?=
 =?us-ascii?Q?5Q/X7s6PLN4lW1dnXMK3Wiz31c0ipj6IPavSQopPfLW6Zb4h+F/xN8Sprtjc?=
 =?us-ascii?Q?2DTrk3tMLgGg4HW+zccW34Xr7LVUYP6CrWLetb6cBAitntgFHSWsInC/GrUr?=
 =?us-ascii?Q?B9ybhyku7giz1MyKmHnNW44zoC86i5gU9X11F9MlgyCiPlV8LaD7vrl+e9LN?=
 =?us-ascii?Q?3LkSsy5sjtk+w5o0xVDL1MHeXYNASTlzXJ8+6eWMNdy/uI8olHTE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b055dc-cf94-4ff8-f687-08decc4ad9a6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:38.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Y+KWexTWeoMtZIUArC3V/nCehcvTX3acj5Fb5qCfp7r395CXb6k/IA8ngnJnMlzfUY7pQ4KUPL6O0v49igYfnqiu4pYvKZinoIKgBAKmXe2EV2IQzmz0MF2MB6qQOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23183

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit d49eea07de5851e1b8941ad6b6179be7ec36a986 upstream.

In preparation for implementing DMA support, enable the transmit buffer
empty interrupt, which is necessary for DMA to write more data to the
FIFO.

This does not affect the PIO mode as we do not even request the TX
interrupt line.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-9-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f4ebfcd1470b..ffdf8d8c490c 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -37,6 +37,7 @@
 /* Register SPCR */
 #define RSPI_SPCR_BPEN		BIT(31)
 #define RSPI_SPCR_MSTR		BIT(30)
+#define RSPI_SPCR_SPTIE		BIT(20)
 #define RSPI_SPCR_SPRIE		BIT(17)
 #define RSPI_SPCR_SCKASE	BIT(12)
 #define RSPI_SPCR_SPE		BIT(0)
@@ -474,6 +475,9 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 	/* SPI receive buffer full interrupt enable */
 	conf32 |=3D RSPI_SPCR_SPRIE;
=20
+	/* SPI transmit buffer empty interrupt enable */
+	conf32 |=3D RSPI_SPCR_SPTIE;
+
 	/* Bypass synchronization circuit */
 	conf32 |=3D FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
=20
--=20
2.54.0


