Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5588CC28B2F
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.web11.34801.1741778680570756537
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hV3NK2VJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxRJaAdwmLJk9e2GBrdCAwERaFxWVx2kcls4tXVReC2482ftc33iD81otOb+ktqQ8cNI15OLny9VOaiBnSTiM52ssdKNQlYAHG1WM0KlSkH8rLRG51ysJp1tNHA+yMoys/QJJvu0mkpSngqN9/zeUQmAZrAak69GwRmIFQujrnQVVgGSj7LDWdiYRjg0oW8UmbCoQ5K0/vBr0kij//8755LXQpDwz7bdEwcIwXNYJ121iJQJPm/CS9wyjHenF3o5RMlVER6pqREOixLA9/yK8QAoF3VAGRzV3NftTTFfWujcjIvCQ03fh2IhMR/+onNK6w6hp0ydKka1FlJp3qvuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+MTedw1FwHaVo3h5Tj1G8YkaSF1P/OUwCKfmjRjMUA=;
 b=eX7pfwSAENZfmVgJFvVGASNatZxuYxKsFMy/phS9gRBKXoMa8ovIG/hLBEuj89Gc5bMqvQuWSwwVy2EnB9xPH8MO8W1qDrTleuLEKWfnMP7y/b9UdNS/BsQTgFPMmTTWoa5Garo3nhkXwgvVyoxXY4EmT6N0ZqubnhMiRvTT0Hh8nHiLW9dFtsCUbz9xu15u8toG+UCp34VmCTWhwh0Fca2EYqk6ixt2FBFO3xegIjtONK5Ni7tTjxeOc34asdBxcd099KvkrfRo06kWBcjEAXRUlMOoA4hjlR+GaGgSH9c/nO9J9fUZ+ikWFvBjW+mVyavy3Pgwbnz2J5HR0b0tSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+MTedw1FwHaVo3h5Tj1G8YkaSF1P/OUwCKfmjRjMUA=;
 b=hV3NK2VJGBZ2jPPNv4RboCEDAWDw3x4HJyvpSSRX27nPBOUorpTS7/GQujFgdjbXobxqu05FVrbgfGo2IGnabNJYSCaoquGfqRqFVKoXAyyRViOcgahCcYMbwGKlCLS4OLS5f/UG9+AHU7R+C1hOQFAD4YUOWjubDGDEaUZlzbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/85] soc: renesas: Add RZ/G3E (R9A09G047) config option
Date: Wed, 12 Mar 2025 12:21:58 +0100
Message-ID: <20250312112302.1605750-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 117c15c9-fb17-422f-f20d-08dd6158796f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vJ+AhRRgTzsnIoOSDQGCzovhGt4g5L4kQmtS7Ey46MYYmM2I/zPSrdTPNEND?=
 =?us-ascii?Q?lB1Ev0YnT6Dy7sVq4KLgFCMdn+UFQBjGKfCL3W3PtzYYIMz2m0G5CqN2Gvi4?=
 =?us-ascii?Q?Kyh7kLnnkKs2txaCyea05KoA5vAeuzHT2GWWZHy/zzadojRY46FLQ6ZzR8Wa?=
 =?us-ascii?Q?SYhd+NDL3/DkyTUVrdU6Dmv1pV6vb0JH4Uble3x82flnWFaky/sJH3bXMlwG?=
 =?us-ascii?Q?VG5qRo2dHkDUVYmrqfN/9MPLDrPDPOi5TQkXZ/knGQgcbOdooq15zJg4ZxLP?=
 =?us-ascii?Q?DT6ep7z8NL4oqs5v85UJkm+fohvpZOrWFuzIsyksdLgb77hbx2Sp91niZ6gI?=
 =?us-ascii?Q?ewAo0qq2p1jm9oDUApU4gGhHBGfx5znRffdxEPdQE98n1q70ImpAsAw9tXBH?=
 =?us-ascii?Q?3M5yIpiqh08xDhM7LNjOc8a8s9En26pE0Rk8sXG5L6a7uaGCp+Y6bHpUDFNo?=
 =?us-ascii?Q?wA65kMmO6cOcsSjAjgEBWMpN1rCzgxZt0NiJ5hRDogXHb9jYg/0WKcNWghjy?=
 =?us-ascii?Q?m8xfl6VJwT+uKAlzJ5WrjstnWHvVbEy12IDO6hcjaC3WHlbfzsdVVUT61NcR?=
 =?us-ascii?Q?nRpsm9toE8an8I0L2Td+e4m81FL2+X48OgYFl7G+bbXPmiKXwCdJMdIF7ges?=
 =?us-ascii?Q?23vZ15BClX4uQXU9vD4cYyqovfLZUBGgnXvZkSUp1Fmaa0HzaKf6YY/P2x2k?=
 =?us-ascii?Q?q+ejOXCoCYiK71qVycvKh3GVBPq3GntufOOnb3SbG0i2qXEPehI+31N9pw0+?=
 =?us-ascii?Q?Kz1cXjPVYfl5XSIkA2qGDYeicQ+rBHM8xX3kay28KalqLZZfW/JPAaCPRtkS?=
 =?us-ascii?Q?zYWEjYxl2D2a2Hm/mDi+5g3fhebKshlsCEHN9uSNjmTk0ucXDedMAmGrM0he?=
 =?us-ascii?Q?jBuAUGTntQrgWDNC7Vm+YD4+vZlecRZXXGT3m3icdXVi1G1B3RkOnvDYcPHV?=
 =?us-ascii?Q?deYxCFV4DmF4x/TpKZd+merXzmTTHrVQTWGw573NEgpZ1bggBIHrQ1qtqm0H?=
 =?us-ascii?Q?7pcfhSsLXNjzsbDPAtAlzB6xbEKtjN/e9KhxHvgPZxsaW094pfQD33Ew1eOp?=
 =?us-ascii?Q?XMSCI17Ecoao0bCODCUrUdWOWnwxS8m8E8T8HTh/C7qF88NInap8v0DDN7kN?=
 =?us-ascii?Q?Fzij+3WFKRxiDHgd75K967lp8c2nz1bMz0JJMv8891TnsCEFK9re7dhjqsoy?=
 =?us-ascii?Q?gUZaN6h4Dlmo9wIa0OFMbbmAKJZIfqEZlYEQOGLGZuQodRXI5IvRnCAkQS6K?=
 =?us-ascii?Q?lnQOmbBi4z8hnHf7FI7WMEsH6uZ8RKQWX6TPlBdj1cegKFaFnhudX7O34P5n?=
 =?us-ascii?Q?m3ZYsZSSbcDK1dnkCjvKsHX8mLgdNcn9ZLl3du2/zR/t3QMi9CS7kiZbtVfK?=
 =?us-ascii?Q?CzjWHD86XKz8gh9WzgjCjuQcOPRH98BEhiYxs/As/AdTN1vioai1Xlb2EK1r?=
 =?us-ascii?Q?NiF0BWBpfJzd8MYNHAn42o+kiI0BHroU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?osGaZXE6akuGQQIJuLyVnvv+zgw8PJO8zmtg/QeLhPD9e/84qL4eW2CphpXg?=
 =?us-ascii?Q?xGoHGNviSTwirycYL4nSvIkDbvfiiU7aGcne6SdUMmCSV/7C5KsYvur2aj1h?=
 =?us-ascii?Q?V8SfN8QdUj3zp5i2h5bqbCGcxX15c27IQpL59+HbGbeoYJMhM6CHsFVMIaYd?=
 =?us-ascii?Q?Cvx0FRR8AOwGoSOltvFSTwvWDxbsQ6ugL5taKpladSnVE6Q16qw9oxfvJsjW?=
 =?us-ascii?Q?N4sPF07eNxhP2Zx0yPuXcuS8rAq3INaGaTJjVwHxItBYGEdsJcyIG6Y/z5T8?=
 =?us-ascii?Q?mpJy6naqTnCDifmJDEiwbkTH+OJ1iNzxJUhpXlkmv23PLYsviSZjE5wGGIHP?=
 =?us-ascii?Q?SzgYObiYNDYDGb31N3QKTu13pHMrhuJPdgUztPSFalFBSL3zLlGGuRGmVlYg?=
 =?us-ascii?Q?JkLNcvsktdPCDuOWV+tQ1qB+0ItumHrmeFuWaaThMxSORcs2OMzL5EBti/14?=
 =?us-ascii?Q?mxAWSJS0W32d05oMT6ttiV3JjvvNeeinACRX3+0VfGJ/vm2Vu4nsY+K4LlbN?=
 =?us-ascii?Q?+r8SgXT3xoYZ0NcnqcbmJZ0KGPtEjEMdzuZqxcZNBbgRHPvo39LhPJDk0egu?=
 =?us-ascii?Q?aj/I1ChhQs8In38N1gb7GUFtCU6uPUt2/jDgLs4JStQmjpMV5cUUOJ3IBQnj?=
 =?us-ascii?Q?w8n360H1+5FhKOM/F3fb1kfeljy99DnyP7IjxtBni/YC6QLEW0qiSpYt8Fd6?=
 =?us-ascii?Q?dR6XrPbzV1b5vpDZ/TzPK/lE2SH5FxPzbqp7cbbINAP/JCspVjGA/1Ql+s9t?=
 =?us-ascii?Q?QGe5Gnbgpw2MIAtv9l+uAXWejni0ohoGbDjrnPq6ZSRO9PsZlxO97khq1JmN?=
 =?us-ascii?Q?gUAF3qj/LR9E/3alCuJKRLuOk4qkkq26azvb3CDg0hAiegKSz9Vwaglc1zUS?=
 =?us-ascii?Q?3oetmLSEST5H+zHm4u2ptVJBYOd8VvomKGY0Ja/wNWvvnqJprZ1WoLH03FYS?=
 =?us-ascii?Q?8jOa4fwn+7zWaIL6EvaNayigh087e/nKC6qYweUZnmHbrjXvmhx9nvdjfRhC?=
 =?us-ascii?Q?3Rd5MBGySxrksmctxsZpXV9+SIxfbwvxZ1qC8jWuCG+kcGcEbw6pSwJdiruz?=
 =?us-ascii?Q?FDIvO/+kf7hJ0oypOVb9Bdxy3jG1XaHvgBp4x+Nf5DMvHunVNy9x2cIyuFkT?=
 =?us-ascii?Q?7Jz7C3GVVoK7km5Ooe7T27+ieu2nbngpHsBxrs4PfQlGcJ5gZVWIxS+0cYT7?=
 =?us-ascii?Q?GUkNIPjDWjHHd7wnPSGBq73dyMkRpUIy3oOh0tLF9kFUn5k8E2Q0LOuz8mtv?=
 =?us-ascii?Q?fp499i94a/JNo1y+HLP+u6FcsQ7gt0tXrRMJxK92PfjrqEaeEcaVHulJ9mcL?=
 =?us-ascii?Q?JcaOgM1jgzx5YEbf+Jsu5eMLcSg2uT8QXnAn0C7guOz/6hlOk69QoWiQjoV1?=
 =?us-ascii?Q?IiLNf041SkMuqXk4d7wyDAD37Q00XUlZ/KqDILTMH5irHu561BwCB5yRuB6d?=
 =?us-ascii?Q?9HZ/gbuJEPYrOh7dcUYy/w3LLlLdxV33ym00QDhKXctzB2GMwTczzREn++rW?=
 =?us-ascii?Q?DE0bxsw1OCt9w2/5oxT2V8jwnLKejJa1iQpRAQlU4H9qFherxhch7oY0oMDN?=
 =?us-ascii?Q?E3KsmBEEds1SwN6SaSyaV1bkWjAyzicwbM9scA1ufX0NxzAjgV4eIzsTd3ys?=
 =?us-ascii?Q?ktt3qXSooJ7s28pUh2s8eIk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117c15c9-fb17-422f-f20d-08dd6158796f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:38.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7bt/L7iSaJwTWoMwoPhnppjX+NjGvvulpS9PTZ+whJ74QZ5kX81sxze6NlG6Q5v5V2h0R9LMKslLhxi2wHZ0uQc+XupgrVeHvKpWEkXWKlm3UR2UAptdrvj28nJZP1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18113

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 	12e0bd600e3c2f33f9db0e3b91f6b8d8d95b7dbe upstream.

Add a configuration option for the RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-6-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 171be915cdac..e0eb3fbc3ca6 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -338,6 +338,11 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
=20
+config ARCH_R9A09G047
+	bool "ARM64 Platform support for RZ/G3E"
+	help
+	  This enables support for the Renesas RZ/G3E SoC variants.
+
 endif # ARM64
=20
 if RISCV
--=20
2.43.0


