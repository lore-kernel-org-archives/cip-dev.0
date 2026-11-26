Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.504.1795708588960936951
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZJzyQ7Hs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDAlXNQYxN5JzAc2tsXiMFZ343PUrUG9O35N131WipRRXfpREV7mMCenUo0pjU6EpJx3Uq49DlUWrnIpIgkYYo5ylyTV+wYzQ9cUJt8jK7LJCszJ7DEQNuDivrh2p2mCENfIo7OO5izwZLPooU2WwAxm/rsydClPjDw/xKp+DzeRHFi0CRdXaJFUJ5FUG0qjP3dmMhlXDJuVKw6UtlnRwZUznUvf9aTjJWKrxEqDslIagqjEZZkeI+7Wkvfdvc4zvKWedY3Sqbj6yunccEHE9qWYX3wU4uyuLwtb3LCs3GmFnYz0LC2h5Zf/iZZpyhmU8j/ak/wYjvO4Nc9nsBoqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+WwOtD3HmvlBNOKknDuD5+OVgaCJP+2ogIyflxjpmQ=;
 b=Nc3bhhC/SMKJ6OP+E95FYFQTgoLRpRtp2L5hs2rDGGxcem8sOaoNC781hPNpRs6YDwWu1M3U+enFwnCzom4Dw+DSpkD8dgJK9MyKt0CkvS9vAQOivF/y39qgohuRiu6qHPXNAd5ivQZfKO8e9brrfJbOz6zP9bWjK0LV1CEjNvlL/HLC/J5QuVdI4eLi8lZg/3IeBxkJjM+oFnQbFIFKTknu1pi1NPlxj6sXUqJgPIdk3gSf6ZHmXaQff1Sv6P5h0YxijIueGWQd5rwMgRM0BQ1AVF3aqkmRNt4DTX7PamWE+h18JQOpbgto/7DSj4XXIZ6BfchqMfzGTX608pWpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+WwOtD3HmvlBNOKknDuD5+OVgaCJP+2ogIyflxjpmQ=;
 b=ZJzyQ7HsbgUnO9CBb/48V1nF8LrDLeuM23hZiISIclDNQjRPNGv5/GIxaavCQ/9ft0FDyg97YImia/EPEhyFnqeLKzxfgvsmVNlHvG10qWbpoRy/IXbXvIP1wafUKNY7FBTJUjeruMXiLgR8bxUGCx9EDOA4WhAtpZ+nJf27iCg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:28 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/23] dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()
Date: Thu, 26 Nov 2026 16:55:30 +0100
Message-ID: <20261126155545.3834937-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b45519-f2a2-4611-c0e5-08df4bd5d4bc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hxm+WhdbE0oPMCM/YR6pQe9CRGKCO2gbz5i/7pOXltBZ7gK4fDJQ0nokClkYiNuDWQT6WV6Gamn2zceTbAbeM7QGPdp22+nzEt4tkKnr+QMgaHi6WSXruraL8s0JVwemPu8/lEfcZr2mZpvXMwhCNC3yr0pmwF80aBdMJLKRJeo2G20PdQ2GOa8b6UYJB+yOuindSYvshjEeSi7DISomhoSvw3QoH/dMZHKIcrQchaKakecqBXzX03HMdPgrHDbpW2OusFWOo93W3J4sKSS0yZKA0ahY7rTRv9I/lKIHCJQBk2Vvgns+t3rXHstKGzIcwCaxIQOVKvnUMu7bgq/CFUzvlEYwYM0ZNTYKAFlDNMKc88sy4aR+ArhrON3JctGAo3rfF5va7tCnaaEIYrr8kN3Ds/REEo3pvmIcqi1wtSdKosVAHXya7p+m+dR1ZmsFceFi3aDsblm3KaLqftimuEtachtQIUmGZ6BhtyyPiURznRNMPJXSoDcBJ5eWJrqaqZeaQ2Nm3JA9W+G8mAxOrtOLKDs+NuKVdzg4H2eQhUQyGt8AItMy0Ojt6HlwO08rxIL1fzNFYRsCDE2LkUECmNAydUn0jbw5UT00xGlNJc22EK+dgV/NqQ1TplwCvXS83sAylIwxniO5phB+lReeExLMG0rHcLRUKaljJvKlY8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2lIGDfJXS7x1J+0aQ/HfvkxGljiAv85gcAQcae4OhhKY1RRCT0kCRkPWMqn?=
 =?us-ascii?Q?tQHQV6Cgd4xLkkhfWGunaOL9u0Jr2FgT4vY12soANNWNK3LPreqzRlr+lpMY?=
 =?us-ascii?Q?zGoVhW8z236JHok3t7aq0pooouUhsuwCN1qRWJNE/WSUYGZHDguzwZCmk7Pu?=
 =?us-ascii?Q?ZJVKKBc2FVOZU+DI8yxQSZ/vnImKT25AYI8eUUjKdUHwDPqY4/5mEyZpkWI2?=
 =?us-ascii?Q?UPZD3T5rYmvZ1fpCkirWblwNHsd1ZLBEyr3kt38wyv4ozOUQBHjdaPDTSJgn?=
 =?us-ascii?Q?teudgapLkljR6LTohdO8cbU8DdDvrJ+BqoEQEtUfDMzP5iVJrXxW0cGbk99P?=
 =?us-ascii?Q?k24LC4BcvjywIEnUx5O2tATn3jrvkkAqGifo1pJ9pnxV5fvW9yCa3CNyS6fU?=
 =?us-ascii?Q?f0cnqQWkfHZXRlxgfww12r8ek63Nsv/82YWP4nBgMcGU2rQcQWoKmW9zGaK1?=
 =?us-ascii?Q?jmNI0pgJ5uGPWiqqTDps2G0PiuAc6WFoHaFc6zuNvqzzNo+Ihcn9SxaDVA0J?=
 =?us-ascii?Q?e0jId/WRXOtkefflzrqcclZZ+mMxS5EEKfUla7vvP3N09HNj/ZmklXoCkcIE?=
 =?us-ascii?Q?9rhIKKK5KyGZk/rVR6ynRjke6rJiScbtYYc/JiQHdNW2XHURg3qx5m1f1RUM?=
 =?us-ascii?Q?OkHryBvlKHqBOnhV7AvJl74jlJG4YWNupuRi3Oayj64fk8JmYgyv3Q9oKO4n?=
 =?us-ascii?Q?ox/8XnZMfwINPkCAr4ewDZYkXR/1Ccp01SKjWVulY+OXWnzKUTCqi2t3AgNQ?=
 =?us-ascii?Q?52kAL6o5RrNwCcHTHb0FYpfHgG7T+wICokSqSH0nGL9ofL/kyuk8WDjxEcpX?=
 =?us-ascii?Q?0iJR+1uPLpc9qxHAk4Tm7s8YxeRCbYkYq4AnZQyymp3zPj+d21nUagBWRZfA?=
 =?us-ascii?Q?xqpY+/fDZen1/oafRSSfKQdUiQib8tvhJ6brpf1o+p2yFRfX8JHlcFyMJ4gT?=
 =?us-ascii?Q?tgQDX6RZrwIxEEYYYGXKKSbGiokwi1FkRqsWxtK7HfEc4fTUt4CCjsvIU6cS?=
 =?us-ascii?Q?+sIUbSmn7N+V4yXyekgV1xgyb3TL4AZ/t/F3JSKzsHNZq4WwymAPoafgMBHf?=
 =?us-ascii?Q?Y6M3FgiFAZCW2rbcQGdCe2otRuntv5Fm2MqYcFP+nOV3b+sutG6W9oRoQC1V?=
 =?us-ascii?Q?DofpHJ5MUEnYDLrH+hIF5jKISCKKy9AhN4qFGTUKrzxW0U/srrWMF67He2Ol?=
 =?us-ascii?Q?XQKNXxOeVSHSph3R0Pu+RG7P4hOzlDcw1z33G8lwrKNzEX/InRoGhvY4RI3R?=
 =?us-ascii?Q?yqyeTYqzr3JqSxh9/DfHnfiQBNnMm5jZeuPyWGl3MPHqfxtBHtQDM5CybFht?=
 =?us-ascii?Q?hPBymzFfEM2qPsUB1yKlzKs/1sKMJmi+nBdP3GgOGbNvxwP9lePtvWBIS4Zn?=
 =?us-ascii?Q?b0MjWee8g7tb9cmEmWwWU8+89u14KeC7Rzin+HNV5waFo5uIcZ2usiE2qPfY?=
 =?us-ascii?Q?S4AI4P3RR5p93b/1Dx4KTmhF23tLcoYGqVFWzpdy8MKMuSFNdSPWZ7cAURT0?=
 =?us-ascii?Q?lLISiNM6vfYg3xwc21hyAmXIrdtCT/WBnwuyu3iFqWVFwuTsVfHhd2ah8LNh?=
 =?us-ascii?Q?05x4B6IZhOd+7LE46EYzXBPIPp0WgoEkDvD6VIFJ3OlSTf5hANow8gaLkRUM?=
 =?us-ascii?Q?vLB7+ptj/fJxCxeU+wXZN+xtzO8V317yRMVlhtxQKd7XmgYH5I3KCfe3Fyh+?=
 =?us-ascii?Q?dyPkaESbSPy2uFzj3VvdDd1Mdls6meAv63xalswVXABZTDULF3g8tesgX8Xe?=
 =?us-ascii?Q?y8GJD8EE9wFr8gL4i0Ve9F4KAEOh66VaETLSW5KagcKOMQVmjvRF?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b45519-f2a2-4611-c0e5-08df4bd5d4bc
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:27.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMrtBTRmYGd/q7pTGrMsgfgCqpetPF3e/EErQ6Fu3z9zV+aG2VkDULOkKmj+cjDaVqiiB6JHi9hmChYZJHox1SI91RYTc64qJ44F3BwmOXDcU1t/S7JMIRTZul85Nwxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25199
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5fbf3a2a3b96ef5810e6e0fbc601f82067629bc5 upstream.

list_first_entry() does not return NULL when the list is empty,
making the existing NULL check invalid. Use list_first_entry_or_null()
instead.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callba=
ck")
Cc: stable@vger.kernel.org
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-3-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 2959bea7aa3f..d01e3f89da4b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	u32 crla, crtb, i;
=20
 	/* Get current processing virtual descriptor */
-	current_desc =3D list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc =3D list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
=20
--=20
2.54.0

