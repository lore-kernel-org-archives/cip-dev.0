Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01410C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.web11.16542.1750674479269778632
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DMVD2eJZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esliiLYmor+JWcWskzJOg5WTKGdSaMr35YUEHW+Ko+qYzW5nuDmAhZV8l+wWTVRbObdjhJxoFlhZL81t5S6nHnLd+8ufuGpBhLkrxL8l1iDzJn4irW7we+T3D7/V+TKafNRDYTvg7GOZTaMcZShe8eQS5zCJtVZ4J1n5BpFtb3/+2u+liI7cU+37X8ZuJJH1fsc6wtTfiqeY2gRWMwCgobrJXEP6z+kzI1z/XhEhQNZlrrUFeM9xepNff8Y6RKvOZCdlhBJrqYxM+rOUE11RSdirS4AnVZrrY8sZh8CsS+GNDXnpJkuhVQBsPV2t13QTgHT1xtSBoj+HlWEAcKUPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te122pJxbLifRMsumUQ+T6mQVcrwjhXuy00XD8h3VEs=;
 b=l1FMIvdDupE2DvtfN7KPwLhxOYyGbG8LJLdV91cMoNIcfLUy2k7kl5BzcDEY8H/7xs4SrwlnmNHPp//cxbSB/PwuZDeVevPPz7DZwSu+0+OcuixcofOk1ICWp34/1LO4W19I3bdKr+1E2wRRaqN7blgyb9yk4caEZyVi6Ms6YxR2azTKXEJTM82Qjl3hSt/T3osJFxaxpPfFpdxgT+/7VOOa4FsJPD8jlpUG/auEYdXCUKZG+bOmnaCEWKSHeC2sTpeJYLFzvfADJNalW/6+y3ZVm6P7D+1u9lSkNn1aYzAEElng56UQyaPvXMtbTMfoEbl+8g3JQTMZLgaNU+4PTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te122pJxbLifRMsumUQ+T6mQVcrwjhXuy00XD8h3VEs=;
 b=DMVD2eJZgHDF9G5+EbOXuKzoHnM85Y6/QBnF6fQdRlXyj2EQS5BA9Rb1mDJsTA/RNBCgopeU6/I8fvcjuz9B83oyhWsKkU/L4YL8OLLfsFpKSMr0eUtaBIS7JjTj/j0+WbRSgwsoNfzYV7DE/PRL60C1nJejkf+qy4kUDeLQiXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:27:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:27:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 0/8] Add support for RZ/G3E WDT
Date: Mon, 23 Jun 2025 12:27:22 +0200
Message-ID: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b09ad0-8f03-48b3-a79c-08ddb2409c4f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TrDRJB9bFfIqsKyVAQR96eW/JbWqqiReKYZ+/VDAjaOK35O7TNJ/AtWSy+EG?=
 =?us-ascii?Q?EU9tiJTVmqXOUTpv3MSB5KHeOIAscNiqK/lbqsiP6hQ1uxt9/0gt9cV78NSd?=
 =?us-ascii?Q?dUvojmWwRcx2WlaeBec+xQXimarTqYGZKVOSDsETw/dl1GBxY0b+FI0LRzFG?=
 =?us-ascii?Q?2K4p1BzqsnE/ZPvjAls0rdvwNwgGWgil+wXE+4qBiz+P7Ya0OeiZB8q/e2oV?=
 =?us-ascii?Q?0wQq2eFJdnHZEDArNqgY94UyW6XMvj4v2EXWMzmRUmJiZYDE4OwC3FKLNfAQ?=
 =?us-ascii?Q?811d7Gj4SHMBY3uDuJVzPe5scVh43AiWDG8qNbYW+rX5lsqNOCe7N0w3LFwE?=
 =?us-ascii?Q?YZRpoGKdMCcjFYBkuu3lIVbTkETwWzOhrEWZp5AJ3HQGykodM0Nm4yssvNQ9?=
 =?us-ascii?Q?pa57rNQlnXNe9EvYt1W3iRltyI8Ya6iJswc2ChC0Y4XBSOgUpqvEZY6eb/Np?=
 =?us-ascii?Q?v6xJt6xCu9J2yZxmb/fes50hlHVWztJHGUQ1LgFthVT9VvOfNXhVKBkTYio9?=
 =?us-ascii?Q?8tRLvcdnEZpeMaWQRx7aSSYxFtkzTbYe3up6PRPARAYb0KW67m/kMHmS5iwd?=
 =?us-ascii?Q?FFbX5DWaxPPm4xJ7+lM63/nQNBYw+Y0EgevKFsThfzNR57GV+84/vgh39mMF?=
 =?us-ascii?Q?5QGoL1FH3OYWdAyjjeKd4wHLxGgpHPeXJEjZAYSCgoaKVTlk2G7JnhuPMmyp?=
 =?us-ascii?Q?vdIJL+DE0eIoQvkd+LLokX0HPRHScCtvX2Euc9BOzK23EPUL2+zL6hJhmEtq?=
 =?us-ascii?Q?N+0lWxhTV/lnabAXnNGI0QrV5EjWsNBMX6SdKNCspyuEkScYIG6sSYgNpoxs?=
 =?us-ascii?Q?oMh6WT7qvYbxDZAL5392KIPoIYUrI2N+5UM5ZdVUN9dKhBrjsmuv5ElBwVjP?=
 =?us-ascii?Q?g4JCzaCnY8thKd6SReynWZV1OZWULKrQoCx4CH9K2mjv4+pJ84BXJwdVditN?=
 =?us-ascii?Q?+1rLrycbh4wwHNI8doqvCAcgZPr9dFcQA75W+xCD7wld3zYj2V6W7D/bCh4J?=
 =?us-ascii?Q?7Bi0ZDkP8+S1bxm1uNeGJZWNneCKVrj3l8td+B36Vz+OVIpeOopwRG24mrK3?=
 =?us-ascii?Q?mId2gaarjHYSfNp61/OzTsIbG0xOuejCRdHgvKTTZv1CRMpT7lkqJBzZz8sv?=
 =?us-ascii?Q?eViSHAZpMYbcL08KJLdfkz/VRa1Zv6HLOCPcw8TnlDsqW6uyo3pdEzSgrsAl?=
 =?us-ascii?Q?VdInDnU63E+n18JDuY/IQIPzkdnP5LwWkpuqB+LRqsOe66hktAqjWgv4O1Eh?=
 =?us-ascii?Q?GD4Yh/zwOzlPaNc+Zi8aLUoIz2kn+pqX37upHxw2iAqotRH8SVU92ELSjjJa?=
 =?us-ascii?Q?b1tZzwTscM3u8iBwYwA5rUPzMlsTQ/c98Hr0kTw6PgbrQMICNMIR7ai6zlef?=
 =?us-ascii?Q?NjAFYiTevGJMalxU/t/LqmS55D4bVZzGx2//p7lkLxawnOedOMwuS2feI8in?=
 =?us-ascii?Q?gakfnyYn0kgK6JHx7r4/i8Hb1DP+bPG4lTS0nPqqccofF+PztFWRTuel6XPI?=
 =?us-ascii?Q?uQpTlclh0SUglrc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5iwFQ27UXPXb1SpYc8WECpXGQ3s4jDP+5+WY1XOQDmnqlV/eRCxc/2vRy0mq?=
 =?us-ascii?Q?j63n4+7vAFHkoHQPShvfDXjwTpnM/GkWtwOVQQQgqvKyUgBtG6wQzysg3BAt?=
 =?us-ascii?Q?2TTx5mhlcDwSHNC5XCHhdhai1//7zkc8uKnxQad54BezED1ob0S1lo6UiQSZ?=
 =?us-ascii?Q?Rx1wWeFNLOuwMAYgy+op+QqO9lY4AcaKPJkMG9WyxlHqakeVo8JRNTWvej9L?=
 =?us-ascii?Q?bD7El2LiGUqj8A0D7mK1bF2+eYSr53J4nf00Vza5bXaxtTNG/fgf7gq0YZEN?=
 =?us-ascii?Q?ID2NFy/KXxD2vT4c16Hy5z1uk46EINrBxth38ByKmWlMiVdtE/Nx29HoDhli?=
 =?us-ascii?Q?RjcYeVl0PjUp//5Ngymr2dP/zf/dkK3dfwu3mlNXv+pzK3ZZVc9tHhuX+iR5?=
 =?us-ascii?Q?zersZxTWnwz4UQvMCtKKdbRrcRPtgxw4rnGfpCPtba+Vu2rhlfQq9baI6jMn?=
 =?us-ascii?Q?Oui1BCaBZxdrkBPk9YK4GpTwtXR1gASrj5Yjlpo6p9ZaRddt3wtoVxqv/2HC?=
 =?us-ascii?Q?b5d/Yts5T+eMQ/+SfKEu7B8uVq4HnaEPIaGpfe1wvNeNVmFugRHgz27ESW9Y?=
 =?us-ascii?Q?4xWPoUuEKhUvHdbqnX4ROj/7PuzBMLnS3vTpA/R+mAUjvAG/wNRXTdYaKCT+?=
 =?us-ascii?Q?VWb+A73hPu1JSD5OqDS9muZcGL5iTdacr18Dwaqx8j3W1hO2XYFqhxNX0pBs?=
 =?us-ascii?Q?56HMdahnVWobUxPDUzsiDCTfAEQb4kj6zUumS5K809P7g4C6uQIqccC8UVzi?=
 =?us-ascii?Q?fzJz4goPLhkLTQRAIjfz2N2248FGhwJM/T6wdpIrOa8VK8QFQ7/YLuo5e03+?=
 =?us-ascii?Q?rRiV6yYA/GptS7tkkyB6mfhFIf/pypgAZSFyZ6chKuV4ofPWpFvFDuxOC+K9?=
 =?us-ascii?Q?hC8q5UyIA40xGmVLep5FZ0/8LCUteYEFENTkdK7sJxSdmixQEYoufXq92ZX/?=
 =?us-ascii?Q?0pkQ7RvIIvXuwbnSTKK7an8KuULu9fEHTRysnun85vGmL76WyPmrYwd7iige?=
 =?us-ascii?Q?36r5ct90a/7GDylVUf7hcUf26Ub0mZtT6lrPLcitFZz4VKoVhV4dEqtGqaru?=
 =?us-ascii?Q?0A3FrDksCtPS3RNi1/bPdyzb1NLpz8LN16vm4HTd0YKZDIkaDv2DzixNyEMr?=
 =?us-ascii?Q?FQVWE4N8KNJUM7Z/F47heg8qdSBCZGbqKjJz18lQ3mdYbr/HmBKFSs5wv08D?=
 =?us-ascii?Q?dSQ26ZumeJHWrV8+DY/4bnqZ5CJ6PX3g9i2z+ujzfr9npBEKHC7DS4Hv6yB2?=
 =?us-ascii?Q?GfCVM/KlgcPWwmaqamCZGcQ/4uqHdYT3JObntMDCzfdQwKvkMkR6qY4kA/GI?=
 =?us-ascii?Q?ZAGv+4kWwPkludl4FDAroR7QxkuyKjP0rxkbBGyxVOeqPEzkyRgnKbfanNvj?=
 =?us-ascii?Q?RI/x2os2NXhwMmRH4CIIH5fFaF0bfxpq1a2KjeKJZkZiTI0jJXCmn1sJuQRJ?=
 =?us-ascii?Q?Vgv+PBy2bnSSUYIDXPh8WTmCwuISpZKnFYMFYHd3ij8crySkx7kLmckKD+Lt?=
 =?us-ascii?Q?E+GQOhv1wN+/bf5vrTxH/NH3wtVvshYATpvGb9Yx1Msj186Zxz4Z1HuFXK8g?=
 =?us-ascii?Q?5V86/EeBMsAdQAUolxTRrCjtRLahi5jgEiAYiuXuOYWFjxj10TdNYFaTp/yw?=
 =?us-ascii?Q?tgEtyI4uIOQol5+POiGrL0s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b09ad0-8f03-48b3-a79c-08ddb2409c4f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:27:52.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFszCpeolYHN0Qx1XWPVaYf6prL/3Lx5oBI+//2YWsgYbG6Ysxg0+9CrSAI/Me+JwL8K8TvbHCp9ku0SNMU13FPwt3PX7NpwzOD+prqk19JhAwCQh9pl93dU/S3O1V07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19165

Hi All,

This patch series aims to add Watchdog Timer (WDT) support for the
Renesas RZ/G3E SoCs.

The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33 cold
reset, system reset and asserting WDTUDFCM pin where as WDT1 can be used
for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other 2
watchdogs can be used for system reset. So define WDT{1..3} in SoC dtsi.

Thanks & Regards,
Tommaso

Biju Das (5):
  clk: renesas: r9a09g047: Add WDT clocks and resets
  dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
  watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
  arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
  arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog

Lad Prabhakar (3):
  dt-bindings: watchdog: renesas,wdt: Document RZ/V2H(P) SoC
  watchdog: Add Watchdog Timer driver for RZ/V2H(P)
  arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |  21 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |   4 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c           |  15 +
 drivers/watchdog/Kconfig                      |  10 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzv2h_wdt.c                  | 273 ++++++++++++++++++
 8 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/rzv2h_wdt.c

--=20
2.43.0


