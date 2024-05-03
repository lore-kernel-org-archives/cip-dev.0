Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D6C4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 07:24:37 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.40])
 by mx.groups.io with SMTP id smtpd.web11.7164.1714721076093538195
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 00:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hNB1CmUm;
 spf=pass (domain: siemens.com, ip: 40.107.247.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzZlx0NoDoYVNKdo2hPZHSGE6T7xA2uM76A4kaUtaHdn+5onwXQVNVdwXaYzXjo5VjHhgf+ba7qMQhkoaQPfS5cNk4kBmGTtbthdWiPOhgVMHteFdCF32Fn9NHQnDe+EReAXviD1kh282YPDgO2LtASKjYE5Hz2ph89z0GBMPohNKd+bZWv8uTcwYC5Q2aK7IBGYnx4vgDcEO6VZxk/v5bIFjr5hlzXbwsZjnRlImLLZUvnCuN8hcskUy2x0Xkeub+hHCRIXBUuEiu/Xn3yiaDr/i+gGlVHDnebxsDGNVMlA871BcEnwz363CeQfBoy1V40WVOOOzBSvqIdI/VwJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siVzsWBQLkh98xXn2fS5TEn8q3xxeI0Lz7Whh/YyZu8=;
 b=nhEUAiXREX82AVYT8a4NaG5OklVNFfnfkpHpOXpGbuRjJZWRm18T92zXN29P3VPi2mkyeFzNreXFlJk/4GkCk8bKe2zKqWrom2B9aVSqbfD7TTp33o5m3bhaqczsdaTUagqCz0OiF4ySDJd5F4BV5bWBmgcEGFCOK62nA1VtCxw5/AahgS12Mzc0I9wh+iXA5ib9i/7sWanP1sOGwBNWNhqTBv8DEpnw31GUc5ZuBlK2pr9SpnJNY4gGt/cxwfnv5yEdeY89OkGAZOXJIEJG6CGlBCTMhzVZ6uqEoPUkLbzb0tlrpd0MxRS7qavQY6rhXasviI2mc8Il+85JkamV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siVzsWBQLkh98xXn2fS5TEn8q3xxeI0Lz7Whh/YyZu8=;
 b=hNB1CmUmaSjMgMKZPDl0aNU3jevbIAXnpsP3Rk+J0RjdS11XnROeOq6sZkxurTimxcHnbQnrIeFCaCAzVIZoq9L/einy8bhI51NqqhjvkqUMDvXyqudeqUT9BMjhoQWBBqjjRSSGpGkTtFzaWpot2R7nQFBdBdTT9h4kpVh4fwuAldZjzH8+P+uDBGFuIbEx6/k3gNj5kgK4bS8AOLtmq/zhdPUZF84ZVWdj6qrZCVRPf0LqOO2M5gbcgg9q6j8VTyCDFniRsTTkZMWWZnmSfR4zYRm0/JTffi8WECFum/JB479FtcJLfxWjOARAO55vModRxy6Z/uCjz3xGUwyhIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 07:24:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 07:24:32 +0000
Message-ID: <0f2f4e54-db09-496d-9223-94fe108f104f@siemens.com>
Date: Fri, 3 May 2024 09:24:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/9] Add option to encrypt the
 rootfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com,
 felix.moessbauer@siemens.com
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1648b6-4849-4367-bff6-08dc6b4213c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aAb0UoP1QyBn6N9tfXYwq0JWElVySnxV5AgBGRS/niMiO7TWM4VXg0u/Qmxk?=
 =?us-ascii?Q?4r4d7tDCeZwWCtc30frb9hIVU6ePeYdr7xtjN+YlgytyNUk0QnHNn++aZBMK?=
 =?us-ascii?Q?Y4Id7NEkntbhl7FYMwkCZkmKCS3/nYqZQ43iPEhtn7KMP7QJCihA31yoyUqN?=
 =?us-ascii?Q?nb8dizkpuT/p9SoPnR02YggMN3KgZ/I8ld2PI1MbrjQDSXDXSsMjZCw+f7rP?=
 =?us-ascii?Q?kzSZv8nk5dZHfQGq9IcgxlQu4Ma+jfKig+jALtk2Lluk4Pd3QVk9pdeh+9CA?=
 =?us-ascii?Q?HQAODh95leIX1Ofi7lN9KAijZ0Pi2NQtDnp4pu+S0OKI7Kn0DlJiJXDe4cAW?=
 =?us-ascii?Q?He/me5QJwijug8M/cXz6p37eDnZHLjMrvwFWQOGjvYjZMOz02SQxIg9yAg6q?=
 =?us-ascii?Q?vzQ7ey9m8AU88e8cCSSTonqoU6fFLtqVRBd+/H903oQO4fOTOaHXIvOiBpw1?=
 =?us-ascii?Q?cL5X7V8nAIZgBhNhBsSTOthBeUMioOw6HOM597LLo7G6sEkzmmmlGisE/HSB?=
 =?us-ascii?Q?cbPjDmWyU9rRjn/Y9vxt6m8jByv5eXiCCkdUZWj5cBLsnE8w6qxltAbzIff/?=
 =?us-ascii?Q?JWuw1fGBvIhCJPONRyGOuXxYGlO8ZHbjdYzoBcmsVySBdy8K/EXbMHmasXw/?=
 =?us-ascii?Q?tK2cxZRl8jgzCTdnX8W9xkX2CARuqd76bamN7oa6WAdIao3ov8JO3H+oSh9b?=
 =?us-ascii?Q?qubzqmyuUTzj8Goxxc4Kv1OtSYwtQVMMgG+k67gWxaoCViHkKHK2N14xC684?=
 =?us-ascii?Q?XCWycgM3QLG3fhbrjUbP87IKZK9g3aa6e0Wt/AvDC7f7ix4hbo6gkPuUwYCn?=
 =?us-ascii?Q?f8OBf6hJr2uzfr2/jd4InfXqOSuqH1x/mTUfmPGsabPjjSoXv6YsWQVhfv+o?=
 =?us-ascii?Q?P9FiX4wcP1ghd0QM0avWSs2pRd4bLrWAOFDAAkZyQkM33yZqNTfgxLYfcnC6?=
 =?us-ascii?Q?KYDehw2ZSG25st1NjpbkeEp3c4M1XYRkltGmmHOBmIn4EeF5uirX8DuNtdyc?=
 =?us-ascii?Q?ZIymwnAco6HP3xET0YWMM65q/5ZodQss8qUieuT+mE/TTlfrpqGxci22jTXr?=
 =?us-ascii?Q?zSz5FBeV58xI4CAlJkMsXwzjQkPpxabs7WnvzF/1X8ues9O9WY1ZK/xg0hjY?=
 =?us-ascii?Q?FV74t7YGoiHv6GlwVuwRqyjkNb5L1REeTSxCdWdzzRCbEd/wGlwgi70ruyH1?=
 =?us-ascii?Q?afvlla58KQMnf5wckkHjlfKtVUCRW2W5Dtwd6wxx4Yg3R3r/gJPCtMg6ls4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?73cKNeRe+5ymfuiZK10sIi1r/cW8O5R3Zy+fX+pS70hbCbMFhH1W9U4HIpYo?=
 =?us-ascii?Q?6i3Z1Zn9o/zB6YDsOuO0sg3sRFBk8Ps1JP98UecE7c1gwiLSLY8ItWqiPE/e?=
 =?us-ascii?Q?SLQUsW3qmgfj75pShK46mTzoTChA896jS9d5FLXXyeR1DJk/x+EEY8tn7l3w?=
 =?us-ascii?Q?9UdfTxakq9RWZwdWBD9t+GSs2H+iAf6B+bA1GniCnN76lKg7KOT+QxkKnhFD?=
 =?us-ascii?Q?aDC8+24FZBtEI6GV4eDf8dli9FfGx/3+pDgAthEjJj+lDXZVvfooiRiSXYI5?=
 =?us-ascii?Q?OoO48nlyBt04+jP8NC/qW1rgGne1IdTOMWPavHAkwVxS41+A+mqShYnLtd3i?=
 =?us-ascii?Q?swdQj2rbJXenYQqtqWJcx5P1ySxUrLEdABFe8fa4NuoSkJlcXQMnYRtZQQ05?=
 =?us-ascii?Q?zkqCwWl1UiXouzJarCvRojFDx9MRCAbd5Awc38TOn0fcA1AAoNHVyF4SyDsF?=
 =?us-ascii?Q?PmcwMLoz23UH5YLSDyyV/+2Wl4AY0NH8ynZdLig//c4lJ9FehXWcj9ptEBqT?=
 =?us-ascii?Q?pzVpveIR3ozO136O69SRfBLKLHhi9VoAf+3tHNVXZTNxHHbdnOBIDAPrBqRD?=
 =?us-ascii?Q?B1PX+r1m7e+5cymPscpElvGmxy9P5OZEYP00DmHopDk8Z+KYqD8hD7/cww7o?=
 =?us-ascii?Q?y0jELOkpiDtbr9EvMxplmaJrFjdk8wmELgL+KiTqMG2VBw8GptlrBZB7nQ/Y?=
 =?us-ascii?Q?V0P06cbVepQV6JINLi1gqBbsqnFCT+TEHyc7gHd+yn5UTvsZA8uNT2hqEcTI?=
 =?us-ascii?Q?NRJ1jGXUQiAuNl881o3q8iIkRZ3C8Bvy3tXmWstS2bMvJoBiPyOOmD1HX7am?=
 =?us-ascii?Q?dSC9qXkd78Tr7YKZvTAX2P4m8TmLLISj/yYMAsTc8KlnCCraQRfUxIBr5ULT?=
 =?us-ascii?Q?OVyuWq9ULBdhdtsfvarEoOsm3k08JyIpsGpV/nR7wh9eD1jY4VUaFv++szi0?=
 =?us-ascii?Q?c3cBbrjwNRnAU17DmdGvOsQe6+4qcFvCJ9lch0sa4YCAwceB/dj+ZoLo8qYk?=
 =?us-ascii?Q?IZTcdqh9EJOlx4hSnTMa6eXgPiK/Hos8gg5kofU9wDp/9RaFdiRpBp+4T4aC?=
 =?us-ascii?Q?xT5Jpdf6U6ZiwP9/7pFPm3QM0W4KGF0mFtXmifiQSHdDi5FY788+FRSB+47/?=
 =?us-ascii?Q?PQdWtHdbeDVyzBh9azZagKOB7l4DcMNJKKTLBJRUwheOxDAJSrV42DDUfYor?=
 =?us-ascii?Q?JARJxGentJgN12rJZgXniv2UNRNdHeXsX5SrTo6l0FvVdgUUY/d3Yp3pWQUn?=
 =?us-ascii?Q?5yIwD/JK8utVNMiEV/K0+s5iLxpUJ7ErgpYT1aJwlRdw2oIqed/b4c3Knb2+?=
 =?us-ascii?Q?2QsbE3Ms84JUObzcGrvly7nqrh9eTwmU3wWbEEzrT9oxn6HsJAgZFrCnlscZ?=
 =?us-ascii?Q?AfnQZuEw/PI+p+cv+q3c5zKGeE/ONURSmcVNhymc9mES6cPEB4bLIvjywMvy?=
 =?us-ascii?Q?QJc7EetQm1rWXojEVlHk2e93mZbhf+w7GZG9RoxHZfP4k5BmeNehstKrMd8e?=
 =?us-ascii?Q?/4+2YX44ctv1Nz5frJcGXYxIUrblSPtZmn2xEeovgWbbnNYX3sGm6BN/NSfv?=
 =?us-ascii?Q?rEgGVs2Ux9e9o2Ur0CSFEYnqYCRLmRPhbNmXtao/3a6gB8Mixt08SZs1IE2F?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1648b6-4849-4367-bff6-08dc6b4213c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:24:32.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuuKoTjebVagduIpeQFBdo2o3p3MTiIIDRuUW5yJ0oJYSCRGCXmfSvmnVkpT/RhlIBhS5eql7o5MTCQ90vhYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 07:24:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15812

On 02.05.24 11:31, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This adds the option to encrypt both root file system partitions.
> The encrypted partition can be updated with SWUpdate.
>=20
> The disk encryption is indepented of the selected boot method and
> could also be used to encrypt a single writable root file system.
>=20
> To simplify the handling of the swupdate the encrypted partition use
> the uuid as the device mapper name.
>=20
>=20
> If all partitions are encrypted the partition layout looks similar to
> this:
>=20
> ```
> root@demo:~# lsblk
> NAME                                     MAJ:MIN RM   SIZE RO TYPE  MOUNT=
POINTS
> sda                                        8:0    0   5.4G  0 disk
> =E2=94=9C=E2=94=80sda1                                     8:1    0  16.1=
M  0 part
> =E2=94=9C=E2=94=80sda2                                     8:2    0    42=
M  0 part
> =E2=94=9C=E2=94=80sda3                                     8:3    0    42=
M  0 part
> =E2=94=9C=E2=94=80sda4                                     8:4    0     1=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80fedcba98-7654-3210-cafe-5e0710000001 252:0   =
 0  1008M  0 crypt
> =E2=94=9C=E2=94=80sda5                                     8:5    0     1=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80fedcba98-7654-3210-cafe-5e0710000002 252:1   =
 0  1008M  0 crypt
> =E2=94=82   =E2=94=94=E2=94=80verityroot                         252:4   =
 0 115.3M  1 crypt /
> =E2=94=9C=E2=94=80sda6                                     8:6    0   1.3=
G  0 part
> =E2=94=82 =E2=94=94=E2=94=80encrypted_home                       252:2   =
 0   1.3G  0 crypt /home
> =E2=94=94=E2=94=80sda7                                     8:7    0     2=
G  0 part
>   =E2=94=94=E2=94=80encrypted_var                        252:3    0     2=
G  0 crypt /var
> ```
> Changes v4:
>  - Clarify that only non-boot partitions are encrypted
>  - Fix typos
>  - Add note for encryptition in secure environment
>=20
> Changes v3:
>  - Update the encrypted partition instead of the underling device
>  - Use uuids instead of labels for the partitions.
>  - Allow uuids and absolute path to select the partition to be
>    encrypted.
>  - Add Readme for partition selection.
>=20
> Changes v2:
>  - Rewrite commit messages
>  - Rename kas/opt/encrypt-partitions.yml to kas/opt/encrypt-data.yml
>  - Rename kas/opt/encrypt-rootfs.yml to kas/opt/encrypt-all.yml
>  - Fix assignment of CRYPT_PARTITIONS
>=20
> Changes from https://lists.cip-project.org/g/cip-dev/message/15512:
>  - add partition labels for a/b partitions
>  - use a/b rootfs configuration instead seperate wks file
>=20
>=20
> Quirin Gylstorff (9):
>   wic/*: Add part-labels to system partition
>   initramfs: allow empty mountpoint for crypt hooks
>   initramfs-crypt: Only resize partition if ext* formatted
>   fix: use luks2 to identify encrypted partition
>   Rename encrypt-partitions to encrypt-data
>   Kconfig: Add option to encrypt the rootfs
>   crypt-hook: Extend partition selection
>   README: Add rootfs encryption
>   README.swupdate: Add section about partition selection
>=20
>  .gitlab-ci.yml                                |  2 +-
>  Kconfig                                       | 24 +++++++--
>  doc/README.swupdate.md                        | 16 ++++++
>  doc/README.tpm2.encryption.md                 | 22 +++++++--
>  kas/opt/encrypt-all.yml                       | 23 +++++++++
>  ...ncrypt-partitions.yml =3D> encrypt-data.yml} |  0
>  kas/opt/security.yml                          |  2 +-
>  .../files/encrypt_partition.clevis.hook       |  2 +
>  .../files/encrypt_partition.script            | 49 ++++++++++++++-----
>  .../files/encrypt_partition.systemd.hook      |  2 +
>  .../files/mount_crypt_partitions.script       | 24 +++++++--
>  .../initramfs-crypt-hook_0.2.bb               |  3 +-
>  wic/bbb-efibootguard.wks.in                   |  4 +-
>  wic/hihope-rzg2m-efibootguard.wks.in          |  4 +-
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard.wks.in            |  4 +-
>  wic/qemu-riscv64-efibootguard.wks.in          |  4 +-
>  wic/x86-efibootguard.wks.in                   |  4 +-
>  19 files changed, 157 insertions(+), 40 deletions(-)
>  create mode 100644 kas/opt/encrypt-all.yml
>  rename kas/opt/{encrypt-partitions.yml =3D> encrypt-data.yml} (100%)
>=20

Just tested in qemu-amd64. It works, but there are many suspicious
warnings and messages during first boot:

Warning: keyslot operation could fail as it requires more than available me=
mory.
Progress:  52.4%, ETA 00m06s,  528 MiB written, speed  78.8 MiB/s
Finished, time 00m11s, 1008 MiB written, speed  83.5 MiB/s
New TPM2 token enrolled as key slot 1.
/scripts/local-top/encrypt_partition: 55: /scripts/local-top/encrypt_partit=
ion: -: not found
Device /dev/sda5 is not a valid LUKS device.
skip disk resize as it not support or unnecessary for fstype: ''
Warning: keyslot operation could fail as it requires more than available me=
mory.
Finished, time 00m11s, 1008 MiB written, speed  83.7 MiB/s
New TPM2 token enrolled as key slot 1.
/scripts/local-top/encrypt_partition: 55: /scripts/local-top/encrypt_partit=
ion: -: not found
Device /dev/sda6 is not a valid LUKS device.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


