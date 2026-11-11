Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5738.1794388779784219419
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GS7eEjnB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.60, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGdgRWEw69QqQhaXiNc3+hmt0bI9kmkw5VHe+48kjPIVrpWCC1JUfwF6nkbQn5E/LoxcSpoxbOF1x0BDZP3RdQhf2SfkADpD59vjiCFtKzO9iBnq7xhomKmrjXrkXAnbu8hqHcAnWB6OtZ+q0XD4Hmhii6ynDa7gSxPp5i594vzklsMGMLvsN+xK08YZ5ZCGQogH+5ML9UcwR8WbZ6Wmch5fP+c6mv6qF4IkcJYN+N6qqC0POBA3ZVVdRSCJ0QCd0VJ8UVzTlVk52p7PejPUV7sbgFVmy1c6U4+dYLUg9wnE/4N03COgsh5LYbexKbl6H3glikkZUXUKRcIuInJcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r51lM7lPMM2Pru7SFW816d56edR6GO+bazWW0LnEcvE=;
 b=VnagEK4IJcMjmxowOx2PfXGfQDZjVNCI0eyo++fAdyaFvvH8jjyHOu56eT2eXnnrDireIucHMl4yQXr446l5bQI+twy/ANjSL0HDW2Xx8xKx9NeUkbRD0jzWYeJUYuhZLp1uLhZ52RR8IsEDYiSBAo8ynA5q39ZZdox5IEz0whTpfvRNM5uTlsCEVw9JjD4reBEcKivz9s4zqQkLOmmaRRWkcZawwlA6OpzsbEMnKkoW6PxyVKtwe1GhK6VRnZ86sy97YZ30fUh5bVqcQms7hh1G1Pw7vt3PDggHK3RoFdA2hR1mnnwgNJDus9hxIcV8oV1+nUF6BDu1fC4GZNfcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r51lM7lPMM2Pru7SFW816d56edR6GO+bazWW0LnEcvE=;
 b=GS7eEjnBucvLqA6rAnzpZGXxLdHrGoDGXkMCn5EsgmMkYvM8VW7eor5hjQvjgx6AVUGIlflq7B6hf/c3vEdQC9QnAJ+e8B7ilO+D8QIzhhkSAZkR45AoNSF/O6CZgEdZD4JlHmT9XQFU/o9Eo+oelhw0QClAkJPJlNghdJAfpj4=
Received: from OS7P286CA0020.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:26d::7)
 by TY1PR01MB10627.jpnprd01.prod.outlook.com (2603:1096:400:31c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:33 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d:cafe::52) by OS7P286CA0020.outlook.office365.com
 (2603:1096:604:26d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:33 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1501C3001DE8;
	Wed, 11 Nov 2026 18:19:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/21] rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Wed, 11 Nov 2026 09:18:57 +0000
Message-ID: <20261111091901.41995-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TY1PR01MB10627:EE_
X-MS-Office365-Filtering-Correlation-Id: cca7d286-b744-4378-3834-08df3fd4e609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p/LwdxgNCYqszfCe41T3lGUeiJNsXn/PMo/380LzE12yOnbL6zymcUcDOjxrtE8CeQslgQ+uKE0zNJGSg5LsbdxUz6kAoz4x6m1B/zSXH+D2LIhOZSmpQiuAZyIsz85nCrf2ojocdtVZlEFoH0QU1gLJoXhEsUqLE1yWsB9mSf4V78q9YtqNvwH1ovkIb96CSMXlj4wGei7Y7ZrfY3y8Odm9AiDGzV9Ul86T0IOhEhmRckQA01J9Pq0FMXX/mxPCVUfwlwDgAd4L+rsLZDM4QdlDEzzWTYUZBdxrWijJJuP1n0ZLclR2MJEaJWoylKVfrnovwE9oM3SP0A3KqbOlmBRcfmZTJMY6jWBJVZdPZgJvTI1Tt/NU8JEbmO9p6OH+GxCZDDiEG9Rd5S60Cu4li8t6MTgyKCWvDruAyyqdSyREf6tKXpHfCDlKiosqNmNkW6zk88cgLzmlYIrbmbt+SJgXeTjmuiFKToBI/mJOqRHnnjUlppZWSwj2nT+e2GKnfu24H4bLw20UaKLRZOO8zg9Ez4iO83QhXIK5Ny4z2B6fqcn1L9rJ43N8Kt2PvCbrYFnTJJ7Dnoo944AjpSljmFx5ktH6OmPPVpNyE6m+7UqjnDlYwtB2aUcDGUprpj61SDXYWbNTvQBDHqzlQ8EInpXoK/zwG7vhSV/ap6btzaY=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z/kTt57nv6+F3pxjIzChREdZ9yZ7AZS78rxvkqM7aO/Gg8PFF9pTvz9NOcYBb2dBeHZfcQJUZ2kqHwZ2QAbPwOnJPGen17gBvdBj0pYz4a5wem6pLxiDgewEZiA6RUKzkMWFXq5FdAiaqo0b3nOMumj6RzLCAqrVwkIDZdkVtR6bNlFEbWsuqi8hHy9CHyATIBvIt8XUte6NcuXJHV6HOej1xIR4pUY4DJWRwFT8h0f/tk5v9WODVLVj0kXU56ZDYXBeUIDG5axK6fI0ku1wmO51b8HZbk1RIEnmkDvOuga4UU4eQs2kZfzV42iir5HkhcKNqtFtGj6lOQB5RNA9UA0w2oKW+lBPIFctQo0fxwX8+wLYDGRmXdueUAQZ1qnpXaVRWOIu1jJG5A3pBxanHS4VdwbAh1fUwBcK/iCKOiZKQ4C0Q8a/KQkYZ49BK9e6
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:33.4249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca7d286-b744-4378-3834-08df3fd4e609
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24759
Content-Type: text/plain; charset="utf-8"

commit b418fa370ea69fc5824e70b63d9f4c93249762e7 upstream.

Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
and RZ/N2H (R9A09G087) SoCs.

These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
do not implement the RTCA0SUBU register. Use variant-specific match data
to disable SUBU support for these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-18-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index be872315b3f8e..718e16fce7e5a 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -523,11 +523,16 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
=20
+static const struct rzn1_rtc_data rzn1_rtc_rzt2h_data =3D {
+	.has_subu =3D false,
+};
+
 static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =3D {
 	.has_subu =3D true,
 };
=20
 static const struct of_device_id rzn1_rtc_of_match[] =3D {
+	{ .compatible	=3D "renesas,r9a09g077-rtc", .data =3D &rzn1_rtc_rzt2h_data=
 },
 	{ .compatible	=3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_data },
 	{ /* sentinel */ }
 };
--=20
2.43.0

