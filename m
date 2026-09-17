Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45091C982D6
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 16:14:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43616.1789661685153000358
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 09:14:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uu3U1SzJ;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHmpQWN1niT1WL5dZwQe2cAq+ZfiS+7BvFjVv6ryFJbKRGQ/siIB+55sY+QOCbvCg+s3g8mG2n2xFDnqu6mLYdMppYKa9Jtp+PqDi8tj32xG1Nm2fBmUGsKcUBcinQvC3vQwsH3HjMkJqQmTSFTTdCOaW9cwbcgWhPQ2JoeuZYT3tc/dueDRZdZJMTl+uheHXwBpdahg0j9ECO5j3KJvKJorpPPOxTfNVnRUu+3NGzPW9ugUep8NY58zDUGjSPsSk6zktnA7gvUkSM4ZO4XEGiADA5H7HvyNkHM95hUbxX1TxpJiEU1X3dMdu+VAyPpWoxztHhEhXWEQ37nnLw3acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuPSo6UYflmMa3ptZGC8W8JPFQ/9U62uALf30Squabk=;
 b=jlJow+P9cFDFghhm3E/ytP/HBh+qMMth+dOB4oKOdoALjWddBqd6TnI9wo2OP8JmsC9rdYy5rljKiJSppGPNhL2FhhDZrZ5z6jzJ5OxLInxwsmXfBFeZNA5UKi+xQFj1hv20pjQGp3hlznxtF/UdhrgwKF83NQlmrsEz312NrUa1pp0puDQVMVtBTdrUBDEV+tEo2HchEa5lLkMDL7HUoWHb3ZUUOZXbPWm50gyhnVVC87T/gH7x/VYvJdO42FtS4PWc16WNeLxrlIVuntFqHWWwQlsvj1JsWMC6Q1cRhi5LFvwZALeR1kLI+kLYvjqS7gsfHcSOmSw70YCFNiOZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuPSo6UYflmMa3ptZGC8W8JPFQ/9U62uALf30Squabk=;
 b=uu3U1SzJuhtEp1r73+7+C+TRE5OwM15CfQgIvktGLEMGO4sR9ZpFqwM/b416/fWplXmV0j6WIOtyBmrGAwvasXEkfylXINdlG9amjOsGiy1Iq4s6B7lJ7WysI7GyGwIJTN8GSKMp3JRXSsNqo4Wrs+s5YqCVuCHmpdTtwN7EjzCs6r2UE27jffmEwiXQveJffYSlqBwQ/WZkmq8KqGui5VEUe+pJf+fRHPwLQxj4PcKe4gDXKhOTGVjkQzscOFeGrTZypa3JkdWZuRybU9mLGpYysz5fmNwtfcdmJvCDvHrP1V97xtxROde7tWe6ZFhnvrgjOiRIUEJQgBD3tPGVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV1PR10MB7598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:14:40 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 16:14:40 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Add wiping of hard disk to factory reset
Date: Thu, 17 Sep 2026 18:14:04 +0200
Message-ID: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV1PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fba2562-a957-4575-2fee-08df14d6c6d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|6133799003|11063799006|56012099006|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	9F1ei3SY7GR5FTL6grrYLBmEsejlRE38bym4n5HX9mdxQT7lk7N+w/K2HaDxvIrw050qoVsUO2QABMtJQvSTtg8ZtTLeqctCqYtELQ+R//RBCx5WP116FNFBx8/x1/W22Y+JXw320Ym1NM60uGT63Kf272/ppko/qfHlDelKxli8gxo0jPdXLyee/HzcOSGOu4CTfI8LT113JOHC5kyzoqfSrO03Kf1b1ksgs6jV2NyWQKqVBFXiiVqfPVJBwZwyK1wvfQn67OFwdl6jVzljB96rEQbAeV/Wbq+UHunRuXSpvJTDJP/b7aUUCwz6TrqRkNPBu2JL8qBfsNlFHz4+Ti7pFvdqXzWovV6FJ5AA2b2wPnGK16Sx8C4i+v5HrNfmzgMy3sdLtnJRBqyQtaTx4yc73BefycJWUGgphkE2CbGpQ2GtUd+enrm9G3pYHCnab+e9aYf5lhRtStLWvSVuvojY/XtT/lg2JI9pq3MIlffzsst2uGRgVaAJSKA7F0utkh0mLMIzG/4IwnbZVpAXl4D6OuIkmo0ndU0J63VrraYl3OHW4FNbFH3LDDj4hXw8KPGbZhJkpJ64KAJbjSneMYrjTEFR+BDNqMtA4LDnjbv8lDd1H5f2sbahouUycae8G5wsqVde16nQtcl2EWyTz+4xlG3W4cvRlntFl+b3xrQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?07O77p719CpIfpOI4qOO3W3yFe79TaKfFlFrq6k4Oci/ZtAIGQPuWg8sygak?=
 =?us-ascii?Q?h+I7LfNVxkiY/K32ic+C41WcpWq1b5D52gRJWR/SaaT6tgACl8/PD4t3HOOX?=
 =?us-ascii?Q?5mD29js4OUs0T3kAwFMmjGLmRdNr+m724ceWN3KlQE88VmiHCqn90C/hNYFE?=
 =?us-ascii?Q?OgYqRFZ2BJ4Kz5Xo41Thh3ll0nmx8+giUM0c/gAvrvOWmpTxQNfxBF2RHNAx?=
 =?us-ascii?Q?yfnOC1FxK+k6HzEKe8tTqahIY3swCZyRlZ7HFwIKKAhYBB6iwQyZCoTT2XPP?=
 =?us-ascii?Q?t0K2yrEhGM62/1OMBt3vf5H57ufr5kdcJaKLvG4jcxcr9FFcRIP3b6aE7TO7?=
 =?us-ascii?Q?n0CHmwdrSkSTdaHpVqsI/VsB0FpkRrzmKOe3gVS2DINSqCN8VrSIm3Ckbp9X?=
 =?us-ascii?Q?4ImA/cUtXPm2qusqM6wYxQL4K2EdSs8bWZy8RDxA8jXomQpHxxopH0Is4NAi?=
 =?us-ascii?Q?5K2XQ9bFqAEiGg8JvtvOzU495awVoNRu5Jxn2cEskbYwrTYadFhNY74i4rSd?=
 =?us-ascii?Q?cI2geij6B+7Aq0tkvfoT06mV/YsCMl77unWl4BkCdZo+Np5kx6gFHkfkFvTq?=
 =?us-ascii?Q?UgjSzjKrfy7peHSGtH0ONvNYizDj2eCjGod3sfJmePCDU/2FnMnf93RQoCmx?=
 =?us-ascii?Q?85PplXhX/pehXGb9MHiGc+HWtasX3aFAL4kpBTCRZyh+gIxWxyCaT1EzL5cX?=
 =?us-ascii?Q?FiCXHrvwm/HKhdQ8kkPEHHv/At93x5hDPZ1EF3rxyqPUpSDxEMFopKu7KHwY?=
 =?us-ascii?Q?3Ya1yh4cGU75Q5tZqGR4Edh4w957HDlt+RNh4sG3/M0TSzXb+lP1UVoK6BKn?=
 =?us-ascii?Q?Zyz74QBc3+NmLGfKlqE7OEG3C7GjitTI8FuO7tvp8B7ebeXuVt4J7BZq8iNQ?=
 =?us-ascii?Q?MWHWQFNCUsSQ81rIW7NBtYy8F6MxM8K8gFmLbhopjZdsJv5aCffDEmwWwJcW?=
 =?us-ascii?Q?RMi8sFvFF3wge4O78O2raTD1o4jj3+CWsWi6/UvCzaxkH0GzmYZRdYsXPD60?=
 =?us-ascii?Q?skaSphF2uAa410R0dpCpmJ4WY3kybrnMJXRkxkcY68HneMWk5twqci1q71jp?=
 =?us-ascii?Q?Cs9eDEp/c2YmbMQInof7FTDSUY5vWAAimN6A3Y4mmJG5+iXYckkWK99mfHZW?=
 =?us-ascii?Q?y9khVoohDHYWaAljnbyV9mQu3Xksv4rmRaylJqfVTrvL+/yVnuUt7nCv9DJE?=
 =?us-ascii?Q?2A5bu8Rf3isI06IS87W8BoBwwnc6k3FsR0E9CpzDt5gHOZnSaCeDIzGWgWQv?=
 =?us-ascii?Q?2+/vozQfK2fKlJkQIz2e/oaPxuJh2z6WK76jflpTftFsZjhdhGySF4pb0WDq?=
 =?us-ascii?Q?jV7AoaNFWageGgr3Bh8KrbUKT39//F3xciRbKnK/GnyFAGoWsw882OVe5EkU?=
 =?us-ascii?Q?CM1RSRwHPh25egLZ076uJianOBhkC6uMoppDrXR0KzBRAhZa62wnU8yO/8ru?=
 =?us-ascii?Q?Tcv3K66LrOKRyoqEKWICme0IwRnwAolnSrSKr4S3uDVDSKLv4Lgf58jZ0in3?=
 =?us-ascii?Q?aDVnYWxRks51xSritL2f+IlNmLdyLiR8KkTBMskn0hu/t2mqWxDoi00mJL4y?=
 =?us-ascii?Q?D8mGDvuNySxStJ5KDvYu/QqRTvwYY4c2+WBFN7tkecDLxcibbUt3SG+CTzzN?=
 =?us-ascii?Q?DuyQF5SuLNPNcG7gjZeYUf18AwATvZi1+EeHZgExbCEvYw/+0kLD964bTLSY?=
 =?us-ascii?Q?r+7MyL+5oNy+UTsbrEdV9TIA/QMRVgFeT0O6I6LUT7oE55uaLQpkIlDqNEi2?=
 =?us-ascii?Q?ZKgMqbqCofajcjzwpmOH6cLL9lyOAF0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fba2562-a957-4575-2fee-08df14d6c6d2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:14:40.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wap0Q1k5i185Yul4GFWNn/rfz81TP/aEJErACWCHaPjLSENQyW9L3oSvnfeZMj+pYZBO4tYJx85vtkWacHYEpyp0s3WjECR53yVrgElazPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 16:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24224

With this patch set a partition marked for factory reset is wiped if
- disk encryption is disabled, or
- disk encryption is enabled and the TPM is *not* cleared.

If the TPM is cleared, the LUKS key is gone and the old data is
inaccessible anyway, so the partition is only reformatted.

This fixes the missing wiping from issue [1].

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/164=
#2-no-proper-wiping-of-disks-if-not-encrypted

Changes since v1 (RFC):
 - Wipe automatically depending on disk encryption and on whether the
   TPM is cleared, instead of requiring an opt-in ':clear' suffix in
   INITRAMFS_FACTORY_RESET_DEVICES.
 - start_watchdog(): check both parameters, use log_warning_msg()
   instead of echo.
 - Drop /run/watchdog.pid. start_watchdog() and stop_watchdog() are
   always called from the same script, so the shell variable
   watchdog_pid is sufficient (verified with dash and busybox ash).
   The pid file was also a hazard: a script dying before
   stop_watchdog() leaves it behind and the next script would then
   silently run without a watchdog.
 - Do not add the psmisc dependency and do not copy fuser into the
   initramfs, both were unused.
 - Keep the blank line after wait_30sec_for_condition.
 - Added patch 3/3 to fix that the TPM clear was enabled instead of
   disabled when setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0'.
 - Dropped the RFC prefix.

Quirin Gylstorff (3):
  initramfs-crypt-hook: Move service watchdog to cip functions
  initramfs-factory-reset: Add option to clear partition before new fs
  initramfs-factory-reset: Ensure that '0' disables the TPM clear
    instead of enabling it

 .../files/cip-initramfs-functions             | 36 ++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/encrypt_partition.env.tmpl          |  2 +-
 .../files/local-top-complete                  | 23 +--------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} |  4 +-
 .../files/factory-reset-script.tmpl           | 50 +++++++++++++------
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 17 ++++---
 8 files changed, 88 insertions(+), 46 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (97%)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (74%)

--=20
2.55.0


