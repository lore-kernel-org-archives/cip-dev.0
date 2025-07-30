Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B9C87FC9
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 07:36:28 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.web10.29868.1753860984895122691
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 00:36:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KxLVz+T9;
 spf=pass (domain: siemens.com, ip: 52.101.69.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emhwL8V3Jos7On/3oesntReYLa9QAOkVMvrpQWL2XGR4ybtypSjakUztyS0tGSWJiQMsgCnXiV/sRSUW00vzZ8v8RrnFyDCwnXKcIXz9eGUFpYhHhC46oW3vA9p/6EcEMdfgY6XPDQaqs9AsTnadlT27x2iXiuHrdXW72WrOywvLSuF3SCcU6Q4ZSRKniE1PhWCy2DzvEuk5qY7fkEtYo2jAmTO/1J/T4/fuvrsOlSltWGRrq0mOf3gQ7aZmPGwa2xaXmRexqi1lEsor5D3XRmSafAhe+I47K5kUGKmyUUDCm8u+MxefKXMO+6IiQmpYj8IH7LA8REpizYCG9sQ8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmDR2QzqCTxKjQJqsDgII+Fb4rkolR/mMrz0zFehYZ8=;
 b=DcOFkddendiT7WSjkyNarxME+zwctMYW2zwcAOLpHxjaW4LOnDkNPv01ySlmMx0HHT8tGosgDIZzSD8qH9lvzyZ9/88k6BUSJbA+1mQrZ25MXssVoLcb6JUMxGJGMUbAE6j3B7HLqm/UnJfaPzKh6/BjJTeM9pPzGCzG4H0wJf0kK8+S9hQCS7OCWO6NA1FfstQMfJRu2pbInoOFbGrNF5QLW6tttIXqvubOdluH0gG4JHYwTFDvgn8C1rgYK3CCs3WYSTIjuUYoo1f+wz38g7C4qxpje3At1PoX2+EcMIR3V6niCOGd83Ens8pkvt7c5z2IKPGV/udMXRBiujdEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmDR2QzqCTxKjQJqsDgII+Fb4rkolR/mMrz0zFehYZ8=;
 b=KxLVz+T9VialGZTZd52ObgSinudpnncoYNQBeyNZYJcku+GKUJKeS8nLTe8o3Y+4XIkXzDGw69eNJsAVRs9R15Y5IakOQdRcwVw9PuGBYlJV17thtr+BxVwcmk60I5EXHwoX6Fo5IZ86V5jeMZ0d/3Io5nS7xehOxRUgWfB5Flm07xuCtIe8PV0ZMmxtKf6Q/F9T1MV5EgUIGq8UxH19NnvUBRj4HlstNJHPGVKK/sLR2cPFol8Xxw2I0aSWGkM0RtB92JPT2nt89Yl8XOrPjFxp4pbswnW06fjmN2cTpSOnQmxGbcZ9M0yVJeJA8Xkzcf/+dBsLM56L2T1K6nH5pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 07:36:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 07:36:20 +0000
Message-ID: <2e2c2d2b-fa99-4235-b0fb-59c6cc1b6d18@siemens.com>
Date: Wed, 30 Jul 2025 09:36:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.8
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3676:EE_
X-MS-Office365-Filtering-Correlation-Id: ec33ead9-74cb-4c97-5525-08ddcf3bc6a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dWiaLXG+rr3qC2dO2Hh7HjZHU6EM2raugLXqFjT8paf7cvrsrFXps18eg7uf?=
 =?us-ascii?Q?lSnj+2I0SOLqSMsSmFjKVCpdl1YCWYfe+W7kt1p7rYtsORI7fXNgyW3iyM+h?=
 =?us-ascii?Q?kjqj5MsMRoUVdtGk3i3FAxub1r12dZj7+sCZOzSm44TcTdDeLrpTDMybLlsb?=
 =?us-ascii?Q?LJuZ7382Y1rVoJWqC995MZcZGqKTBbatrgSwISBzW3lQ+ksiTpNKn0G1aavs?=
 =?us-ascii?Q?D4gH06OjKHOPKTCD/xd6UbStedetFUqa6khBI3zjqdX4N9x1BwRGG7mzhB/K?=
 =?us-ascii?Q?1qSh9HamKEM3xqRg/Seuonlqvp3vxLU8v6FD+aWSFb/VQzejHL9MIleY++ZS?=
 =?us-ascii?Q?8ImVFLCeNGFFrKba04vsg9h8gJQc4B1VKsc6BqZjp92/UwLZ8ndYstGpFJqT?=
 =?us-ascii?Q?I6oSDk2C85/pSBNGZIZr/NbEPxMPHXezSqbldEQPJuloivU6B8eMYLUFrtBJ?=
 =?us-ascii?Q?Mw3FHALpgy5lRIxn9vCNiNiANw7Q/+IrafVMosuWe0st/ENLEgncDxd4Ovxz?=
 =?us-ascii?Q?PyOdehO43xeJhmaIxWZQB2HAD4mNOC9pEOT58YFf63lCosWYc3F/v04fLVB5?=
 =?us-ascii?Q?UmlPaZJnIPAFrlkgb6leORe4dp2byInW5yrnuYduiGOZISnyPUilLwwlgV8G?=
 =?us-ascii?Q?0FLwinSV8ZV3FjwrcwJiMKwoFG6nJ0gyrxiOvwknSP6CD+yJ+GK39zsFLv6T?=
 =?us-ascii?Q?OEfEu/cwBTLUjAYFSNaApKksJNPWZPhpgb74BmONzq1Z2j2hZjbRDpwvJipn?=
 =?us-ascii?Q?EvQqV278nWeVjUyGU9LIA1ePopGIyYPWl+B4yKGhLobrD8r+SAUTFA1NrnYO?=
 =?us-ascii?Q?TQq3fRt/q8R4NUzMPlqUlQZDdnzAq19NikC42Ng+SIo+EmPCxzK7UbP/waOB?=
 =?us-ascii?Q?IoMtZnPMxHsUvZBD9iNzzlM7ShkstxNiFlc1iojDqISlp8MffxhMYGiKoHDZ?=
 =?us-ascii?Q?yEMWULcc19Y9YA39xzS+TuMBbihJaGkuF2Z9OkoKYPa6cs7CHbK8TpmyQYvJ?=
 =?us-ascii?Q?SsUo0Wh4HkvKCU6i0YLot1Qv+oQ1PzGN+l/Oa968vi9gm59wPVoeW+gPa839?=
 =?us-ascii?Q?v2gKB67FTO0UwhmPnQ38rUdpLog6NKCsYkjQTsi606T+LBqAQhUnsqlEn5Fh?=
 =?us-ascii?Q?+ZFJM64/Q3uo4ROyCSu9Rev3IlQNe/6vgYfLGFuvFsteONFLwSd1Du4EruKJ?=
 =?us-ascii?Q?eWGpPZwwLeQQzoi82re9kK+6y5EAIZuyu4ugCfWmbAxS4NmFbI7M7iIFKpNh?=
 =?us-ascii?Q?weSw7LRyXRNP132rqfM4XP1oZlPZBjfrBj0DVQm3PyjeSm5BwrZyx7CKX9FT?=
 =?us-ascii?Q?7BpzOHjGw6YGcl14OprWWGcnIJuULISpKdeJRJGtcvd9rCtkrSFbOdcpQWMj?=
 =?us-ascii?Q?PDzoTrwaAPh5zWTs34/oXuQCJCGwSH3vSCcd1dDIQDAauPFVqXdJU9DO9jWU?=
 =?us-ascii?Q?5oy0pLow//g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sED0BHnb72sj4pk+eAtT8tP/7856KJkkXYpGCLh++HB4gHDqZLF9oLwkw8Rt?=
 =?us-ascii?Q?TEHU3sGZJFIO5NoZPvl2Q+cR5QxPMvk6Xmh5RcME6Trc/ZjTwC+JJL1cbxAw?=
 =?us-ascii?Q?0NK5J0dqwWchHS13Nl8b4X31efbhbv659USSiYrQfD7Q0TvYOI4rVv26phrv?=
 =?us-ascii?Q?cdj63O0+6Pkx0Q0MZFHvDKD7Q7LW4npIDfqrIHrRHla6XqtvZPZPiclX+/O3?=
 =?us-ascii?Q?WcYCxsM6y/ROPsszx62CmpXvNsT2CHjyAb7U6pokyw44Dm1WZkSuVM10Rx/Y?=
 =?us-ascii?Q?LhhGi42KhkWwlXvl+mwavI1aVExSBLfWGM/I3Uv+bVmSwbdDt9hxcHLbVT3J?=
 =?us-ascii?Q?53I1uXuM+0KD04JOAaHjt6207hQGrhZtVZL/GtmTnKoVQQDdkBT08UuM7Bzq?=
 =?us-ascii?Q?LFYqoUjGDj9uMctzfP2ci/it+kJLwbzL55Uxm83QAryZvW8ypWYYdWPWlh+p?=
 =?us-ascii?Q?YG1IR4VYX1fLYXjDxx2d6srBgLmq2gZVZ5NB1Fwe/rCLlZW6C9FswgqFo1Xn?=
 =?us-ascii?Q?S+4AVamQKbxeLFHezyk0dSi16bhg3Xvp79BZn2fYyUkQvBYDd6+IjH46eRUi?=
 =?us-ascii?Q?uoQW2Wyvt3l+Hxlnv8k+MTRjTkz01KH4E1pJ/gFu/h+r0BvXoPPl1R/k7DeG?=
 =?us-ascii?Q?NiTH6zdEeQXsnBVEjmbzCyBHbpG2h5r36/fZb1Z8bOEAfiR/2pgGDmjh0IGS?=
 =?us-ascii?Q?QROkfFJwpD9vqawpLafMR5IQQ819kwqDiWX/cVRZlzg0NuetKYF2WqSVQFgP?=
 =?us-ascii?Q?97jWs2ZPYvYIRp4N9N4uoAbBec4ZNhUOjcORff4Wt/cyjq9f8Asb80g/esAD?=
 =?us-ascii?Q?3emhy3ALO0uDWrkveYX1UgeYvg/smE00CLlZFjnahCfbvlamdDxJaI3n/hxa?=
 =?us-ascii?Q?1K71h51PqbIHCEhrzx+dlBX0uffuui5T1nlMJkUWUsvNa03XOayJnlBNTXF8?=
 =?us-ascii?Q?lqUYAPxRwIz+wgI+5ScQvCsmlNiTTqxQDbGEI6NWUE8orN5wt58NRF7FjiKk?=
 =?us-ascii?Q?2QxVUVrCNZQNwAiVehMonnFHEltdAbxiUxGtdOr68MP+YM4u+HPRALC3Y1ii?=
 =?us-ascii?Q?QjVYd4nVUNGMqsk4E6l30BSMldRueMrtiXWm5ec3pJ3CYF97woFk4E8Z40SH?=
 =?us-ascii?Q?oe1OOGRvk/YALASxWeHJoWqhvBntWU7+I8W6AuJ3J2DuIo0/PxEmniaq47yN?=
 =?us-ascii?Q?Bqp47fGXF16EUmFFoCxDEkuwkZe5VSnCg8MHxrQro0gIlBJ5gzMmBhvRRSkH?=
 =?us-ascii?Q?RRDNZpbIaqEZqkL4CCK3KTEdEpgZFqyuY3/7CBOftFc4fOJNXsjifxAjqVQI?=
 =?us-ascii?Q?bHmUPImzz2hmXvCLe4GDSl8bdJ9T2GM8RcE4VoGQJ6r2vE0kPZ6ng/8pvoFT?=
 =?us-ascii?Q?gEiWBcNb342BmTSaZezimw3iAR5ztRHNfPhfmpWcLXj3shaJpXLBuX0dyR7u?=
 =?us-ascii?Q?AnyAaTwx+IOx7n16TRlAY7u98RXiTeVQxAqRCyYIiRv76+qH5bER1qyUC02Z?=
 =?us-ascii?Q?dmAFyeBy3nDQBqiv9jVXIl/ofkP8GnXbEMpwVx9vzTmI+eLmcmukJ6Sp9G7H?=
 =?us-ascii?Q?Ua5AMYLDOzemhMTF5Fk9YqKFtZXiCYqJBMB3aReF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec33ead9-74cb-4c97-5525-08ddcf3bc6a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 07:36:20.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW6OaFm0oHrVqbnhVlZcqF1ajiSnUi3gYIEIDvy9fRYaH2feV85m36FxvzPQPskwst3nI8B9f1Crg/ox7rDDJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3676
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 07:36:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19618

A new release of isar-cip-core is available. Finally.=20

71 changesets, 9 contributors, 79 files changed, 1017 insertions(+), 365=20
deletions(-), these are the stats for v1.8. Numbers look fairly similar=20
to the v1.7 release - except that this one took several weeks longer to
settle.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.8?ref_ty=
pe=3Dtags

The new release brings support for our new CIP kernel kernel based on=20
6.12. This update was also the primary reason for its delay as the=20
number of variants further increased and testing many of them still=20
involves manual steps. Further highlights are (widely) power-cut safe=20
initial disk encryption, infrastructure for in-field disk encryption,
a/b rootfs selection via kernel command line parameter and various=20
fixes, including TPM lock-down prevention by properly shutting it down=20
after disk unlock.

Thanks a lot to all the contributors!

Jan


Alexander Heinisch (1):
      gitignore: added .kas_shell_history

Claudius Heine (4):
      initramfs-crypt-hook: store initial encryption key in TPM2
      initramfs-crypt-hook: add re-encryption recovery
      initramfs-crypt-hook: implement 'noencrypt' option
      initramfs-crypt-hook: add 'format-if-empty' feature

Enes =C3=87olpan (1):
      change-root-homedir: fix /home/root path to relative

Felix Moessbauer (7):
      swupdate: add vardep on SWU_HW_COMPAT
      ebg-efi: add support to deploy additional files on boot partition
      immutable-home: create relative symlink in rootfs_postprocess
      wic(ebg): add support to add verity env to cmdline
      port verity env handling to new kernel cmdline infrastructure
      create apt directory as needed by apt-daily
      immutable-rootfs: disable daily package update checks

Gokhan Cetin (1):
      swupdate.bbclass: fix forgotten whitespace in assignment

Jan Kiszka (43):
      linux-cip: Update to 6.1.132-cip40[-rt21]
      initramfs-crypt-hook: Ajust misleading comment
      linux-cip: Update to 4.4.302-cip97-rt54, 4.4.302-cip98, 4.19.325-cip1=
19, 5.10.236-cip59, 6.1.134-cip41
      linux-cip: Update to 4.4.302-cip98-rt55, 4.19.325-cip120, 6.1.134-cip=
41-rt22, 6.1.137-cip42
      Update to latest isar
      linux-cip: Update to 4.4.302-cip99, 5.10.237-cip60-[rt26]
      linux-cip: Fold rt-specific include into a single file
      linux-cip: Bump cip-kernel-config revision
      Add support for CIP kernel 6.12
      trixie: Drop pinning on snapshot version
      Kconfig: Permit 6.12-rt for RISCV
      linux-cip: Prepare for building from git branches
      linux-cip: Add support for building head of development branches
      Expose kernel branch head recipes via kas option and Kconfig
      scripts/update-linux-cip.sh: Address shellcheck findings
      linux-cip: Update to 4.19.325-cip120-rt42
      linux-cip: Update to 4.19.325-cip121 and 6.12.32-cip2
      Kconfig: Improve modeling of SWUpdate availability
      Kconfig: Allow erofs also with kernel 6.12
      doc: Update image file names
      wic: Fix boot by PARTUUID for bbb, hihope-rzg2m and iwg20m
      Kconfig: Exclude building 6.12-based images for the IWG20D
      Update isar revision
      kas: Update to 4.8.1
      linux-cip: Update cip-kernel-config revision
      linux-cip: Update to 4.302-cip100[-rt56], 5.10.238-cip61, 6.1.141-cip=
43, 6.12.34-cip3
      initramfs-crypt-hook: Use pwgen instead of openssl for initial passph=
rase
      initramfs-crypt-hook: Drop redundant copy-execs for systemd-cryptenro=
ll
      initramfs-crypt-hook: Only use resource-managed TPM instances
      initramfs-crypt-hook: Factor out tpm2_functions script
      linux-cip: Update cip-kernel-config revision
      linux-cip: Update to 6.1.141-cip43-rt23 and 6.12.36-cip4
      linux-cip: Update to 5.10.239-cip62 and 6.1.145-cip44
      Add isar patch to pull buster from archive.d.o
      linux-cip: Update cip-kernel-config revision
      linux-cip: Update to 4.19.325-cip122
      linux-cip: Update to 5.10.239-cip62-rt27
      linux-cip: Update cip-kernel-config
      Pull bullseye-backports from archive.d.o
      linux-cip: Update to 6.12.39-cip5
      Pull buster-backports from archive rather than snapshot
      Update isar revision
      linux-cip: Update to 4.19.325-cip122-rt43

Quirin Gylstorff (7):
      Add documentation to provide project specific signing methods
      wic: Add the variable `UKI_FILENAME` to change the UKI name.
      wic(ebg): add support to abrootfs env to cmdline
      port abrootfs env handling to new kernel cmdline infrastructure
      fix: overlay-hook: add missing dependency to e2fsprogs
      fix: Shutdown the TPM after disk are decrypted
      Enable persistent storage of journald

Shivanand Kunijadar (5):
      submit_lava.sh: Update script to prepare job for amd64 secure boot ke=
ys mismatch case
      scripts/submit_lava.sh: Remove passing readonly=3Don for amd64 OVMF V=
ARS file
      .gitlab-ci.yml: Add job to verify amd64 secure boot keys mismatch cas=
e
      IEC_template.yml: Update IEC layer tests revision
      .gitlab-ci.yml: Increase IEC test timeout for real hardware(M-COM).

sai ashrith sathujoda (2):
      .gitlab-ci.yml: Set timeout value to run IEC layer tests for differen=
t targets.
      IEC_template.yml: Update IEC layer tests revision

