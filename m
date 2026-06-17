Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B1CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:32:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10779.1781685122228541494
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:32:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=awsN3uqn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjM7mGXz+KYrBfID4ImaL5RSx6ZaiyyUXTDgc2I/JjpgE/Hltacn7poobE3GRsBihohiRNJ6BqcnTV5lTR0xiQg3Qj3z2SgCHAfyTKYup0QJfAtuUdwMr0WC5u9qhWQD3Ad6QPIKs2YokHL1TBIbjqC3tdB9uRR2OtL8LXTrqvTnm+TUjwocQGCs2lHsHA2onuu3EfxwLc1+nI4A0F6LKxawtYKOIfSOHRBQd/efsGafry09HutIlXLnQSn4ViO7IgINeyAjTI5GM4Pl17GpDjcH5lAgHb2mIBi/HV6u3PvsA78Gj3HvkConN3mChUeQAYtkMickaplFJwuKXsQctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjnupYyiPiEZVB63Sx6v4z3r+yJQ3oGpRmf6ZkmDnGg=;
 b=vQusy9jAhsvC5zr9/B265cj+lhR5HWYcYicMr0v95yYLOrOWqOKGaCkCO9sanepo95LAstCV0LHgguPWUGwGK/p7IFbVCSsMHDaceQaD56QMDQPIowLH4cTz4Ftwiq9/9AKCh26iQeNsuHQyrYux3tGpyCA+4qYYP3liTJiLYiBnL0fdjxKoPOEY7Hu1jYZYAGn05VfGTMYaHNoQ/KdUSrNSzqqJwVbo2GqRQKMk51ZfNNfNpTTn98g+zieed5YKtOucejDJ1tDlb68aeyyKOiXlc+Di2kiD4ud/rxX5C4nHVXca/7gw4JJHdNU7BfvAKS/TOKdzv7b4fzzK4mxMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjnupYyiPiEZVB63Sx6v4z3r+yJQ3oGpRmf6ZkmDnGg=;
 b=awsN3uqn4bYzMXimTnyjk10ay+RsEN0S4oFzGiARp5geb3Q3uJG3s1OoX1+QMhlqZlXHYo2vNd6j4o7JhQMRqeUeJBhZZfuPu3Rblgb3rH8M5D86ftZf1PjmWkdkaXsec4Dzughd6cES/3r7tUEFzS053oVwzsNifRhC1LYZ5Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:59 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 30/32] spi: rzv2h-rspi: Fix silent failure in clock setup error path
Date: Wed, 17 Jun 2026 10:30:01 +0200
Message-ID: <20260617083003.1071543-31-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70566269-2e27-429d-ed2f-08decc4ae649
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 
	OQ000iA+nf7xtKkUm9wniSsRlqZGJhYcEQeDOrJi2je2J0+26SiMyel6I0/vp6FliCIu9nIr0Zt7OVCFO3La9oLkqM3HtvRNmKBlycEbkLx8FGnPo6YAAbYkaAWFuopgjvq4CsPBIZUrjnKji5TjcM6EviN418A1QsCXbqAL0Hvc9wGsYCxdJlLwwfC9E+t2p4pxPROQpfKSYNqWocr6z4ek6pfo7lrL6eW8eavsX0I4Hd4WilrdXOoC13/q9dmrqreBcwNVRoc0vaeMEW3DdVa2T5WleLqieIWzXHkGnAw9CWgV7lmid/x2cYplF6sE0r6igT1EO5YRJvo3BhmOaSAHRr6J0Nk0+VlYEq91uSSgj4PKm8AXlZwcU+ADIxx6vGNeBvaTD/wgOm/NnOx3rBSOTsCInk0PivUl89a7ennRq3z9M9WO/08cJsUZcgJd831bHdMzlpbl0QHILZBnM0g8rlzo+wf012cYsYwnVmnRVh9+1FnbU0t/v/+c1NioddCt0XPLJUi7GrQ9vTlC15RUW64INKllnR+jFM4hDEEX7IA6Gbgc97v9xIc7krXEbAYtvP2b7PRtseWyvZ+yaBETb71bIrn1ojmB4Tb66D/5gROwxa9q2mFKDpyZJCMSckWYHDBUeaEM9B+fpXa0qFZ8dnn1hzJO7EUlyaXyi78V+fkgYtlTFNgDs55MJPZ5+QBYYtO57zmgCir6OK3OzA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q7e2AHOJSZAs5Wqih68Auowt726gQ13j72hkYHKSoBTTTgqKIZ2xi9RIav0x?=
 =?us-ascii?Q?FB6P6Fe7VUt68UlxFsqGlbucMO+XZ/a1r7UAmSzHTCq09WqC0BM4+C/XqxSb?=
 =?us-ascii?Q?HczJuRNi7hOidE9+ReG8BCmKYW47V03qOklwKjBMwNM/fVb94G9bjyEo2b+I?=
 =?us-ascii?Q?ItA8f3hYqmI36A9ZGxz8cAmSOABp8XPA5GHJi8ru4jIjwbBvt65g83dG2/Nt?=
 =?us-ascii?Q?2NPdiEXi0U8ksB5v/pYDUhsd7tpAzXLtS2JxQoBsJOlKoCjgMxmWmdHA8Mum?=
 =?us-ascii?Q?HqC3oP9sNiMzLrylAFEigHgxg41NsghSFxlMeXG4mBRvsF5jy1Dge/ffLrZI?=
 =?us-ascii?Q?T6Hc7aBMxVIYt1EJTUOQpFDgFOhnpPWT+GTR9w0MrfKr5Z5oZYB5vnU0kTAg?=
 =?us-ascii?Q?1tUxvqp5CrN5sJ2nYBvnRajJbo2E0BVEtS10fC85HoBAsw3KdxU5OO5vR0hO?=
 =?us-ascii?Q?i1oUsyjfycUb1ypnR157lTQ3ac/Kj01DDYv4zM1l9LViNaQ8k5H5RGzreK8n?=
 =?us-ascii?Q?3h+PGDfQaelDlyGc+70DaG7S0js3GKvq07x42bPkIPWzUDe/0f3RPHeYOR4o?=
 =?us-ascii?Q?fwwBmcFkVF2Ru+gQBaw5ih+ffdANCoTb8rZEbCSZDnBbWeZOYBIlD/Yac+GB?=
 =?us-ascii?Q?HSgDwHxeSNBvQpCSqij+ftAFtoI7xauJVfZDP6A5tCOQiq+DY8TAD5t32dLK?=
 =?us-ascii?Q?DMo69PZVcd8+xiXlDGkirgSzmfQR2Idcr+9ALBNtAgdnD+7J5EzNMPLHbN8y?=
 =?us-ascii?Q?kfvUrW9oN8kAALovUwgB6r/IFG1uQopsaiPCGrKfywxlyfpFwDHaOovXfIQS?=
 =?us-ascii?Q?tPb2chJEutElW3t5NRdE1YhU2nF0IkRdIFDIhz7BJzzBSAmkNldIuuZGaqvX?=
 =?us-ascii?Q?t6BhIn6KO6Evpy0qDK0ntOz1WkCBuJNxPHxAxKhVwXm7qojY64vIk2bDYJJ5?=
 =?us-ascii?Q?Mxdrh6GL79B6mJqaxLSyrSyQ17LvenkZERp5iTwg6W813SX/Ik8Y5AZcwNjS?=
 =?us-ascii?Q?8figC4s27xuJBXC9TaCEa5sRe5SnmElznMf5h45xAHIvdhzgD/CHn8O0LsYX?=
 =?us-ascii?Q?u5eP97MM8dIiwqMOaY0A+1H18wts+CzNuttbJ3s2y4vZit5Je2Slp5uhNZK0?=
 =?us-ascii?Q?NbYFwBynnYyUzSQJjMC5zHWNJOwh+Eg6piDnQkAfxd82i1YCn6gIguIN4twJ?=
 =?us-ascii?Q?enfwCgeljD7xsY+ZrTN/87ebdr/yCn4qJQvoWzKN0AD5/FDXZ81avMLef8Aq?=
 =?us-ascii?Q?5AlZgaXv1XZanGGzb81He5bsj1YACA7WO08v1IOiPZU4/pWpVEB5FDZdorzx?=
 =?us-ascii?Q?IIfSSbAtl1Kkio9Kn7rfcbKMFKgumTT7DR0SKz7pB5gi8Ul6TyW1UpAaew4w?=
 =?us-ascii?Q?1CXoJLGgmQ+pZzscYCs6uITtmSBY4w63/+0NgE68m4aDp+D/QuhNp30+Ykhl?=
 =?us-ascii?Q?4nSvkYV1JUqyCgaDTbbjt/6BmT7QS/sU43rF18HUU1wMT6M4R+dbXrypAUG1?=
 =?us-ascii?Q?NW3YMeeKIxmWkG8CxZkWzftJAgs4TEtgHB+nU7Sh1UVHOZDMzjq47L5ljgH5?=
 =?us-ascii?Q?tIKEB9Vl+QSGlD0qc4h6I10PtQcCB7A3/p8ez5TdwSMEEAs9wOAh/worxEhK?=
 =?us-ascii?Q?+KARrRtI8mfAe1Mz6mQUZhZbNtBobPYTdJvquZKc5BmaDXrbZzOaeWNwyYLJ?=
 =?us-ascii?Q?fWkXwgFVgMSMYynAZgWk09PiMEtHmht3g4XzrrN+T4JQY2fcSyw8HgVSGv1i?=
 =?us-ascii?Q?AiJcGWqQLJJea4cR4SrSMB/KucroMku+JCJ7X2YoxDqre4AJm0TI?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70566269-2e27-429d-ed2f-08decc4ae649
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:59.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DyTuWCxuJj0cGJUmq1Rp+XaqoF6Xf+7C6y6+gc+sShh7CbWkpoOCwAU4BG2zrYo3F57X0y5jfFmwsLu9IvahLwXz8mgDo9Zx+hcsFtSR9eriu2hjStCGWOhcFtHdaE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23189

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 54900126ae0a2671f8790a7f95706b9ea95fac4e upstream.

rzv2h_rspi_setup_clock() is declared to return u32 but returns -EINVAL
when no valid clock parameters are found. Cast to u32, -EINVAL becomes
0xffffffea, which is a non-zero value. The caller in
rzv2h_rspi_prepare_message() guards against failure with:

	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
	if (!rspi->freq)
		return -EINVAL;

Because 0xffffffea is non-zero, the check is bypassed and the controller
proceeds to program SPBR/SPCMD with stale values, leading to an unknown
bit rate.

Return 0 on the failed-search path, consistent with the existing
clk_set_rate() failure path which already returns 0.

Fixes: 77d931584dd3 ("spi: rzv2h-rspi: make transfer clock rate finding chi=
p-specific")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20260425024725.2393632-1-john.madieu.xa@bp.r=
enesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 09d80a31ed4e..3049521ec61f 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -579,7 +579,7 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pri=
v *rspi, u32 hz)
 		rspi->info->find_pclk_rate(rspi->pclk, hz, &best_clock);
=20
 	if (!best_clock.clk_rate)
-		return -EINVAL;
+		return 0;
=20
 	ret =3D clk_set_rate(best_clock.clk, best_clock.clk_rate);
 	if (ret)
--=20
2.54.0


