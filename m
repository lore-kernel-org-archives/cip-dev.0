Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5560DC36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.web10.4019.1742377714365169766
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZYvY8u/O;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJaWIbg70avGPuh2hydh9UHK+p9cpy6+Ct7X95C9fzPudThH1rHIVXHR9LHme1n/clecUIqpONqi5Uwu4p/AwL1aOtZd8PPXRXa93OePlnX4sPrK/tOx616KYHaekTZxzCvLzCtpzRuxoxKDjeQFk0DhTu85Li3UJF5naVyrvphundztb5gPqeLmH0Ms4T3fxK6bbyfg+FiY2YGJkmIwjCfD2UMWujk2aWYbVZHx8kFuLreXDZwrjkl+40togKABGtXqjyhoYDNTz3M7z1GfhCiqQoeID+rLnPxp9bDd54+aIfS2KyodQDvxee5temwUBKJcSXBzbvIJR02/z+2dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9NKOTPT02DupfiT58dEJI6/19k2V4/vx3Y7d61jaEo=;
 b=PKly57MMVCPn8DwsZwaJRo36IbY4McA0G8Yp8w9QM6+KzrkHhfXx7UPrajiAklnXYIQUG1gyhvncppJ2/8cqMlqDjJca5qu/+G06Bpqume3XdEOpFf1gniJmvzQf1NtCNOVnx3NqocSPLF7Y7x2oLwAAzXRcpSoPkhu0HQWlwONoTG0FzBgH/tzkFXE7K8JZxQyVzfJbpFLEyao1MJyIOBjlOSfmBdUDzB6pQBxIKrwjpGbGUZ9ZOUz5t8H3kKjmlBf3RdEmN2K75rGn4eQCW1/2wIN/6PZ64SuSBR7TFXeGMB9ou48IZaaK9SEOize8P2iJtl3hetLcMVq6i6wWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NKOTPT02DupfiT58dEJI6/19k2V4/vx3Y7d61jaEo=;
 b=ZYvY8u/OZ84aMvmxrwf0r1wysVnJsBdmHF+0HVZFt/tt+CIxhgVbb90U5ljAXB18PlKf+00K+BeVNH/AgG1/+Kyv/kbt42pDMYV5f9KMTFXNwK7yb64MIoKOMmgpTanr1CcorGJf0yzX/IBONC/0wtu0lQUXqC6Rd32qL+dK8fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/12] serial: sh-sci: Add support for RZ/G3E serial driver
Date: Wed, 19 Mar 2025 10:47:42 +0100
Message-ID: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: 3593d02c-dbfd-4f7f-8fec-08dd66cb3317
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZxK2E6QLAe1Yh1M8MwzludOJANjv5VagurCWDXNYEVph/MFuzFT4p6VUvRqY?=
 =?us-ascii?Q?9J2oBEmr4aZZw5ULT1N0NXqnoJ7Nm7+Yzr/zkHmjyLUkQcphxsOK6iTL3nQ3?=
 =?us-ascii?Q?trOFWh3Ii9YDLRx9UntKomo6SsLYOJJE6OSbDc5fPwqw8NAg0nLl/JTMe5SF?=
 =?us-ascii?Q?PK9utVQSVImz0NEEEtW7Nimsk3+VuWw0Lo2PwJRVlTJF3EILwwrMeWKEBMnv?=
 =?us-ascii?Q?5/SHNIYBQpVrqYS/4c0MPre3pIBDcK3FPSWR/FJ480kakmud/NjlSXZqHnsQ?=
 =?us-ascii?Q?OOMzYaP+4iIW8B28QV+HhTYI2ua7/1MJH+sfcEpKENhOfT2OCmiTBAHbtTbK?=
 =?us-ascii?Q?LZUNaSq1HFsoIjEMObIDHpv8OLZlWD+528auhvbPWu5sEyZoRfK9J8eSue/5?=
 =?us-ascii?Q?XG0Y4fzrdxnnZvHjPQt1rebyGEZAGh6Ab3+JjlcuYborsqtDBGqHWFU0q9nZ?=
 =?us-ascii?Q?VVtkn27bch5G+QIx3nMdSakaF+OrIAzfI6u6EZyIdKdc2OA5BZhxvZ4/sYRC?=
 =?us-ascii?Q?bWPNv059I6rxsotsJ50pO9ZTqO2QjezM2Q1G1t2dfIYI+uqhOkrRyhm6pjVq?=
 =?us-ascii?Q?bI62YwE0j2INhvYuAFu6zf7Uf9Tbuo5ykVgFZXj8KQBONXGr/3Azr32RWroD?=
 =?us-ascii?Q?ZfUIZOHkaenvHs3hJF+zDm8TCJZ1VXXEWp98VGi6rJsSR5U44kQQNS7s6G8+?=
 =?us-ascii?Q?aBDl96mwu1n8iHjsCtprzc+QcY3o/RA/tuCl5d266+97cYbvxCwdx9NWWPus?=
 =?us-ascii?Q?9xWAqUpxGMJaoalLHQjj2E9cOq0aEn2fb2o4dL3CyyiB9lzS0XvqeYbVawMg?=
 =?us-ascii?Q?okbKpjqsCIDStujZjvzSJyTsfSY1HOV6M23qGC/WV6CInXHR3IqnCZdorBum?=
 =?us-ascii?Q?QRoEb8AUGb4EbBpKzw1WhzCJoEGRhOC7ocC6lrzd9yJqLdtdfYQdLh47p1kK?=
 =?us-ascii?Q?BzWww3PGCcTbXElOD8FiMuZufRl4yI2HHwZpYKD2ABS0Po+ljqBeTCo1l/Yh?=
 =?us-ascii?Q?W63O0A8jVT9xa/by55ZQoDZ8gChuRheYXQBqiT+ssb6kVe3oFF2LYFMMhNE9?=
 =?us-ascii?Q?we7RjmFb3sQe22T1zL9LFeh9foGBF/dz717J9gnCYevU3sTAnTSPof5LqY1J?=
 =?us-ascii?Q?NfNWRDnN9MLlpxCP/azqoHUrjcNkEwlclf+6QITQzq92VmNV9NCzggjqxUw/?=
 =?us-ascii?Q?zeAq0Hw55/5zLVl43NjShSwnhcNINl9eykb7xvjHVBU+6zSt7B9yOLhZbH3f?=
 =?us-ascii?Q?+s/OhPlhMyDlROyOGvuKUN7FH7Yj2fZ2T5Hv6pDNl79B/H0SBZWfAYG5QwPb?=
 =?us-ascii?Q?1+NXUzCDHUV7Q2UXSFrVW0FeKF5aYLtX2UwRJBg8htXq53PuWoBREYQ1lkqU?=
 =?us-ascii?Q?Op2InIKp81D2O5fzQEmAk6VrcXlZNRLA+HlG/b//IfaDfChSlR+AuGgK2Tr8?=
 =?us-ascii?Q?GgZSR61J5TL7dre1ii8VifNj7ggobsj4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UbT7WK9n8iEHmmXCRSHyweyurBAQ2C0V8tA2u50jW/Z+a20C8CuyztNlj9gB?=
 =?us-ascii?Q?TJFGY6W3wR5DXYDiqSqlc2lA6XHB/XI70/XVivbfaaWRo3JKHi2cw8MfWS+R?=
 =?us-ascii?Q?u7Jn9zt4fReVg1vaA89QqY4uP8vIPCBkVIbMF3z/ibarTag63udtXyklGLCQ?=
 =?us-ascii?Q?a2B7WZcjaTXkIgqqRvgiiG5X26UXzA8vp34AMS2B5zOuYfDjtNlHTA90yLAz?=
 =?us-ascii?Q?iGsLpM9fMjmuesZNhdNMdasjh/BT1+1QOkQINWt7Frc7WJu0TUegdxfSOSQK?=
 =?us-ascii?Q?tNH4I/TkZQfDrM3HfiZPPv277Rc6XWE61ftj9zqCDPI/1wXW8zqBBqoMk0Hf?=
 =?us-ascii?Q?nxQJ2jpC8AArlx1QHNpz8RAAbDzXbCmTaJlLdIlgETJOaGiQdCfAZERfHjWk?=
 =?us-ascii?Q?XSitlOsNAQhgyLKZdxGEZ+96005z6MAzT79a+EFeqVEtnSYxHvO92SZAE4SW?=
 =?us-ascii?Q?mhOpC5JXm+SEEmqVU7ITKsr/tAV92t8m3lam2TDY/2Krdw068qwkx8zK8MfN?=
 =?us-ascii?Q?jCDZaCttKOdJ/9KE/5ZCrxFP5FyAHJ/q8iOgX0U6mbsRFz9g+GfgBqN9h6zt?=
 =?us-ascii?Q?P16FZY3cT8kLSQa/80lpH3f9WrzS1Uv+kUsyq8EljKEKKewjVx53ysdW/5pA?=
 =?us-ascii?Q?xRkTJAHnhwCUkCk+QvsoLnxcxIYPnZmNdeY4CrrWQhLUrsTXzZplgVRyBiGp?=
 =?us-ascii?Q?xQ4L4HX5aFNn7i1/Av7qupN+Uuhg57U1Erbm+Aqdg/KYYBTNZ4VlQE+bxCxK?=
 =?us-ascii?Q?exAitu+N3ORBqHB3UJ0Yk1ufFQbpWLdyhQ8IOa294CzY0zhCi4BdsclMHwLF?=
 =?us-ascii?Q?CkXDTBEw15KYfO3Alt6u7o3RDfwHS5NckReH6P4zEm5nFN8pZuGJ8PJrSfOB?=
 =?us-ascii?Q?zjDgp4x6CoDspaOmdNE6A3DGKQzJyyA94UOVmFu2nXoQxMHhxAjXmHq6X+ye?=
 =?us-ascii?Q?bxRaO3kNFjC4Vm8VNcmTqt9LrKg3bjrFx8u+SeHZve1H0iR8GqM2e/baCX1S?=
 =?us-ascii?Q?RgB8aLjqu2rM1/s9CJM0MClom7FcEYGc0RbkZulKMewJNrmSky00qIfLclck?=
 =?us-ascii?Q?OaaLOlprbn1qQjzigaGi2YFZqK3SVFF92+IZ4ND8lX8JgvDCMLx9fPUfOnwn?=
 =?us-ascii?Q?QheXckZtH2hrXYhPl28x7xhx2M1xJB/DPgMZLfxEviGjpFS76FaD8iFu/twk?=
 =?us-ascii?Q?2PaZhfpKa9qkKPoPYO8wqvVUGVdiCzCUVV0bO+vD8V2LcdF1uwlXoaKPcoGP?=
 =?us-ascii?Q?Gb+CU+YR660qTfyeC9Hz93w8B7lXz7tD6JKdyFQhRUtLugcS/+ifboa49k8/?=
 =?us-ascii?Q?abMq9rL6RcpAR+m5pVIOAS82zGvZsr/9d4ovrAevPX+3N4eKh7wOy+qd8Bnz?=
 =?us-ascii?Q?m40/0THNWOddf4n2Fq0nJuUliml2pC26JqL4nUbHAxAklP3geTlpLtA3KEme?=
 =?us-ascii?Q?h5yjXD6p3X6V2XMCC9UBqcG3uFYMRGdYOwmeKRbWLxzNuhKwNBmpSSHfCfkH?=
 =?us-ascii?Q?z2RVokiKGWoOSNw6nrEt2jyaSab2FrwnWq5I5TLrzxYmfsqBit2N3AfD52Fh?=
 =?us-ascii?Q?TJhhlNKfoI96LczoyGMn4komyeXXbJ5zMRvN+6O39g01rgpknYO+/j1KYgL6?=
 =?us-ascii?Q?1GM5pCiFlNRg9OcnvOXafLc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3593d02c-dbfd-4f7f-8fec-08dd66cb3317
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:27.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34YNK8CSefV2mEKyHUYNSik/rEol54IMaIvGP/nFWlqQ60iOkLSDEL9e4LXudJv+HUHCvnpJ9jbvSF06GHJLOvyMhXjJZzAps+LYquLSGRYgHN2lGJMxLZXyUag+7M2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18247

Dear All,

This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip kernel=
.
SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/G2L.
This series add also some fixes found during SoC bring up stage.

All patches are cherry-picked from mainline kernel.

base commit: 8da62141b20b (tag: v6.1.129-cip38, linux-cip/linux-6.1.y-cip)

Thanks & Regards,
Tommaso

Biju Das (1):
  dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif

Claudiu Beznea (4):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

Geert Uytterhoeven (1):
  serial: sh-sci: Use plain struct copy in early_console_setup()

Lad Prabhakar (5):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'
  dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as
    required
  dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
    (R9A09G057) SCIF support
  serial: sh-sci: Add support for RZ/V2H(P) SoC

Wolfram Sang (1):
  serial: sh-sci: describe locking requirements for invalidating RXDMA

 .../bindings/serial/renesas,scif.yaml         | 141 +++++++++++----
 drivers/tty/serial/sh-sci.c                   | 160 +++++++++++++++---
 include/linux/serial_sci.h                    |   1 +
 3 files changed, 242 insertions(+), 60 deletions(-)

--=20
2.43.0


