Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02ACDB466
	for <webhook@archiver.kernel.org>; Sun, 21 Jun 2026 08:47:16 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20770.1782031625895624291
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Jun 2026 01:47:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=A5qvL6/y;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlAUKPidPffyWw5x/Hq5ehJFUfwobTzC5Jq6gzYoFbm4lSq6YOjiSorft9Toh8I/SoBXxkIv/4OpO8M/4vUb4JGITj97dMeE5WDZHIa4L0ZZpJUnec4xS7dl7VdQv39w71AGpvkIDdJrt430brEQaLmlp7DbE72VMMod713dsWyfREAdkhFEwMBmoUpIse9u/8So4bqMvs8QBqRe9z90SFNQnegVfc/Q8iQA+LDDU/uvrPw0fomk9kMnCJ6o9jFuYNSOcf/mQFirWfrlm3V7uXZhg1Gbkcl9bq/OQBLfERmCKCgakd/YjYdncvgEhysy+PgD0j5wsIuX3WNKhQjJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6IYKcYapCidIY9sY3ElO5K6e/bDX34mPYvpVV5JENA=;
 b=PK8NyirHbF4Dqwf8CZkbHl6InvB/S/6kl1zJAGQHTAjr4cvRZCdOiETgPWfGDU9ZAOC440BGgEen1kCDfNJltIM4LKvn9hZoiq9L5qRqi7YRBa95n/QSK53eQj+lXxAL8/tr/AxPOXpQTQbkLZTAn0jr+kVzVa9wqokO6DOLIUgFIqQjT32Qg8nVlQpcZu1GaTOytnpVMmPWoSH4FtlrnrQJyL5wlukcvnTdth260U6QoW8bRqaE6RZe5C6HmCO3k/sThVZycb3vydPMvMiWZsnxOnctVS6M+3RfotBQc5sOD52RO2FY5Ksr13Ng+hiz2v3IFYpA7cxbb4OFrWJD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6IYKcYapCidIY9sY3ElO5K6e/bDX34mPYvpVV5JENA=;
 b=A5qvL6/yDC2YZPpX7+VqaGEZAe4EFpdrqkBab6mZopmR+fzTIpJvtC6Cya/gj/XIC3O4it9J0m1njD27X3OOcs5hF551Ar6xEcdkNNMg2qY433W2i0w60uWZoiZ/Fsag4HRIJ2PeYgayikr7cYwuqj5/T7fq9KvZXK5h56VKb+Z/Fv+0aWN4uajx7GFrgxBjx24RG8aRKQz9nXNl94sRGOreKE9ZNai8ZReaIYhWPXAAoqNmj63nS++OXWHpg90sfqaOGciydPv4y9vsGJlY8SlUmDp9n7bYYMQNVkjBFCvrgL5kLjm93HgfOo6rzaCnfSzM5MjpYA2DVI/u4tHCIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Sun, 21 Jun
 2026 08:47:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 08:47:00 +0000
Message-ID: <8b2cfa70-08fe-45ff-8695-7564b37f36b8@siemens.com>
Date: Sun, 21 Jun 2026 10:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Revise README files to reflect the latest
 changes
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
CC: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a91b09-577e-4a26-ac51-08decf71a885
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|6133799003|18002099003|3023799007|22082099003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: 
	RmcmhMqEZLh5J8ZvXfvgINNXL7XskHEdcgoFMGdapIUFNG5ughN8tpRVqFHuPouHBtsFoxJKv/+mQXDX/F5XNV1WIeEsto69Quo7odlPAXj5DScLFNIzk6UYgeYCcyLX6lhDVZdyIcS10CUK8N08uhjMfPdV29WnywbdlLNZWIDHLIQs/d/hSprEgUZUIidRLJJc5oh4N9ttIoWsGBXNc7a4Oc26Xs8mp48dwLORU4X1Y6Ww82FH1czbm0KS4YjWWEebxvG1HyTtsahdjNSEGHU3Grl6xwu8CHwcu2nbCyToEn8/CMHutSlzddMFazudO6UiDBNklBHRv9M8xY9+gH+SGijVSsWXxNAYxIXtKs7UAihMy/FSiukatqsdapbtJgMdfZn0uXyA346Za1ndEnaZRPuHTYypCyc/UM2J2xyX7fRl+5W9X0RUtZcoPtoEzHw5OYcrOXu9x24k2+Q1VNXqimC1Ery2v704WvuF6VG4jyV5kHdyLvOsAbxpUmBYTa2Kh6lfwAy+S9Q1gIwAvkQHykrJLFhmUN+lrnEsO+ZQwNI7Dx7cKnao4YdAWhSpQQn7eFNaPK18U4k25xGyf5M31zMX11FTszJe7tJ8j9w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(6133799003)(18002099003)(3023799007)(22082099003)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aN4RjElO9cL+jDaM7JCCOTtb2GHtSlsXq/Wl1i8XMvktWar+zxka6Ok+gh6p?=
 =?us-ascii?Q?yM9PoDu1XWfG/Xs24Q3hfkMAnnEOQTtgeqGQsnRathE6Ffl5/1n4QfwjH5kt?=
 =?us-ascii?Q?8P0D5lYHuzFWLfW6KGlfbWD0Pc+Lrz6S9pB3877J6IZbK5QtY8Z+3+DmKB4P?=
 =?us-ascii?Q?zSY6Cyj1ieiOkI19AS6U0ysyIf4rbPL3owplyVDgVGHCr4mPIuZrVgjHGpgO?=
 =?us-ascii?Q?F9E7uA3bv1yhayQ5dyKf81S8KWhTShEVt8f5RFds6Wfg2ISpsly8f3ehAkAw?=
 =?us-ascii?Q?0IrfLB3wWRJhM8nxVsLfIKEn2G8Jbtm8LOWvEYd/4A3hVfIWIEBWsW2lDY/4?=
 =?us-ascii?Q?Q9HoW2FyFN0OKq2zTV/5w4TMAugWjMZMj7o4MhnPyc+ushDLGPmwk51jw2ud?=
 =?us-ascii?Q?nbbFDSk1Y4bjmR+PE+IJ3iZxoao5IqRMfga6uQwM0LvEeUIIyfpejsZW1j0b?=
 =?us-ascii?Q?4jlqULIWGCNus5Nxz0M1onzKKuVBDqO9zvjtzWAJUPuMMTLvzl9hVAvUX0ca?=
 =?us-ascii?Q?UtKmprkoKdREwLZlKRm/Aofqg2T0MRYJR9Z5MM3ZsVOGHW9s6lHRlArAYcb4?=
 =?us-ascii?Q?9MZpsQMXoQ9Iz3zvoAVRJJVZu/5JZ87WAdEUNUNrGwAcAsrBzzcmIiHtme/9?=
 =?us-ascii?Q?QgLogDuMnAIAJxuWcomYppGrAK3xEAoMlLYqJpwwz8BEUHQeamFdYgKZWg7T?=
 =?us-ascii?Q?NLlOiTklVfLbG5/L75ryRhA4jSz/Ouoe25aaRpu6l5JwDsNcZoriNitFT9LH?=
 =?us-ascii?Q?KRMhz6bWurzfWixtovtMkx/KYxCQM31/aqxoeoMzVP+lwJZpHM2iQPLDwOCI?=
 =?us-ascii?Q?axacOE0kmMwW4H9PCirFfGUGABW3WTCqBohWZHDyvbBZlH0uEKnV/w9AovMu?=
 =?us-ascii?Q?A2NMQwbbF1GRMhxqXeemGz/rkYBj1ozjRoVCY7RXZN65nBAUXiDv55XuZA4O?=
 =?us-ascii?Q?sGtIPCt9s42khBU97jOjpRwQuX2SbXIngNWZHzDeHuAw/xtlsXIIB+avpfnW?=
 =?us-ascii?Q?p5rWZ1U3r2dVzlPvH4E1SmnXq2+dL8Wo3MpfjOydYtwtQDsjba5a9AbN/QmU?=
 =?us-ascii?Q?VJJRIcbkiCtzSXqw1JoZl17Xdpl5oMi6N1QmDKVwCU/s4Pz762lr50Bx6lzC?=
 =?us-ascii?Q?xAMpsTQ61w5XHblhMIs1OIMk6HEzSPXDuZIALSnDfj/uYzQZO6rM6UTG5/YK?=
 =?us-ascii?Q?GnuQXVL2zpD938vdVQj2H7v6NR3C23TLvk72k3HvOgbvNJOG4Vzby8d/zGNY?=
 =?us-ascii?Q?vHRA1vxw143hh/STwS2dxcCTjgA7gJRoSDwxaGbTZ1M4lmzX9Ob48FeXjQql?=
 =?us-ascii?Q?Vgi3GOvcPJpRrX7K5tXTZXZ/59hR8eK/E441XIOgI95ffVhP90Mok56MEJH5?=
 =?us-ascii?Q?7IPn0RrvAfbReQvIyXiFQv48eLJABD6j9LKeMhixAatx2OyPyp7vI6BUwOPJ?=
 =?us-ascii?Q?ljDffIColzHIInF1TetGCgKc7B3DVpF9uTKuoYdwgB9f/CSAD3OR0HLPaUbI?=
 =?us-ascii?Q?zC5SrzOfL8a72IFacemckz8jZX3yu/AI1Nj2JhXDq9l8RVaJ+wEs2H1YEIek?=
 =?us-ascii?Q?sAEdf+nV0DbSWh9v9NBYH2KdAOJlUwX55N6f1QPSDZU8p7UaiOAttfAP5ACE?=
 =?us-ascii?Q?iXyhfgxDE2rdBpSFJzV9A5bzyDdUC4hfW5qKZ5qRnW0SoOjTnKX1whnspZgw?=
 =?us-ascii?Q?ifwCps3cUA8L/MS+ASOGl/qxDvFOXlGXH+zICxYk7ud4O1zLGX/swNmtXj+q?=
 =?us-ascii?Q?6vJ662yrsQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a91b09-577e-4a26-ac51-08decf71a885
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 08:47:00.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6owejUHdzHGO8SHJmlZjtX8peziDTV5bic489s1YjZw3x0ualYXq5r4/DQ1Xc8AHlkh8gdaH/SRli9aqXG84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Jun 2026 08:47:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23238

On 19.06.26 12:56, Shivanand Kunijadar wrote:
> The SWUpdate & Secure boot readme files are outdated, adjust these files
> to reflect the current changes and debian version based on the master
> branch.
>=20
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 63 +++++++++++++--------------
>  doc/README.swupdate.md   | 92 ++++++++++++++++++++--------------------
>  2 files changed, 75 insertions(+), 80 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 8ab67a8..5ac8611 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -48,7 +48,7 @@ Supply the script name and path to wic by adding
>  #### secure-boot-snakeoil
> =20
>  This package uses the snakeoil key and certificate from the ovmf package=
 from
> -Debian bullseye or later for signing the image.
> +Debian trixie or later for signing the image.
> =20
>  #### secure-boot-key
> =20
> @@ -66,10 +66,10 @@ Set up a secure boot test environment with [QEMU](htt=
ps://www.qemu.org/)
> =20
>  ### Prerequisites
> =20
> -- OVMF from edk2 release edk2-stable201911 or newer
> -  - This documentation was tested under Debian 11 with OVMF (2020.11-2+d=
eb11u1) from Debian bullseye
> +- OVMF from edk2 release 2025.02-8+deb13u1 or newer
> +  - This documentation was tested under Debian 13 with OVMF (2025.02-8+d=
eb13u1) from Debian trixie
>  - efitools for KeyTool.efi
> -  - This documentation was tested under Debian 11 with efitools (1.9.2-2=
~deb11u1) from Debian bullseye
> +  - This documentation was tested under Debian 13 with efitools (1.9.2-3=
.5) from Debian trixie
>  - libnss3-tools
> =20
>  ### Debian Snakeoil keys
> @@ -144,7 +144,7 @@ Build the image with a signed EFI Boot Guard and unif=
ied kernel image
>  with the snakeoil keys by executing:
> =20
>  ```bash
> -kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml
> +./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixi=
e.yml:kas/opt/ebg-secure-boot-snakeoil.yml
>  ```

Do we really want to hard-code the release here and below? We are always
testing the default one, and that is trixie right now.

> =20
>  For user-generated keys, create a new option file in the repository. Thi=
s option file could look like this:
> @@ -186,7 +186,7 @@ need to stored in the folder `recipes-devtools/secure=
-boot-secrets/files`.
>  Build the image with user-generated keys by executing the command:
> =20
>  ```bash
> -kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the ne=
w option>.yml
> +./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixi=
e.yml:<path to the new option>.yml
>  ```
> =20
>  ### Start the image
> @@ -196,7 +196,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.=
yml:<path to the new option
>  Start the image with the following command:
> =20
>  ```bash
> -SECURE_BOOT=3Dy \
> +DISTRO_RELEASE=3Dtrixie SECURE_BOOT=3Dy \

Ok, in the absence of a .config.yaml, we do need these explicit
assignments. But you use an inconsistent format, here vs. below.

>  ./start-qemu.sh amd64
>  ```
> =20
> @@ -211,6 +211,7 @@ and the following command is sufficient:
>  Start the image with the following command:
> =20
>  ```bash
> +DISTRO_RELEASE=3Dtrixie \
>  SECURE_BOOT=3Dy \
>  OVMF_CODE=3D./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secbo=
ot.fd \
>  OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
> @@ -233,45 +234,43 @@ EFI stub: UEFI Secure Boot is enabled.
> =20
>  For updating the image, the following steps are necessary:
>  - [Build the image with snakeoil keys](#build-image)
> -- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-bullseye-qemu-amd64.swu` to /tmp
> +- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-trixie-qemu-amd64.swu` to /tmp
>  - modify the image for example, switch to the RT kernel as modification:
> =20
>  ```bash
> -kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml:kas/opt/rt.yml
> +./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixi=
e.yml:kas/opt/ebg-secure-boot-snakeoil.yml:kas/opt/rt.yml
>  ```
> =20
>  - start the new target
> =20
>  ```bash
> -SECURE_BOOT=3Dy ./start-qemu.sh amd64
> +DISTRO_RELEASE=3Dtrixie SECURE_BOOT=3Dy ./start-qemu.sh amd64

Yet another way of formatting this line.

>  ```
> =20
> -Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the runn=
ing system
> +Copy the swu cip-core-image-cip-core-trixie-qemu-amd64.swu to the runnin=
g system
> =20
>  ```bash
> -scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@1=
27.0.0.1:/home/
> +scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu root@127=
.0.0.1:/
>  ```
> =20
>  - check which partition is booted, e.g. with `lsblk`:
> =20
>  ```bash
>  root@demo:~# lsblk
> -NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
> -sda              8:0    0     6G  0 disk
> -=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
> -=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
> -=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> -=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> -=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
> -=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
> -=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> -=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> +sda      8:0    0  2.8G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 20.8M  0 part /boot
> +=E2=94=9C=E2=94=80sda2   8:2    0  128M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0  128M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part
> +=E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part
> +=E2=94=94=E2=94=80sda6   8:6    0  512M  0 part /var
>  ```

Your dump is missing the verityroot container. Does lsblk no longer list
it by default, or were/are there inconsistencies what was configured vs.
what was run?

> =20
>  - install the swupdate and reboot the image
> =20
>  ```bash
> -root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-amd=
64.swu`
> +root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
>  root@demo:~# reboot
>  ```
> =20
> @@ -279,16 +278,14 @@ root@demo:~# reboot
> =20
>  ```bash
>  root@demo:~# lsblk
> -NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
> -sda              8:0    0     6G  0 disk
> -=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
> -=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
> -=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> -=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> -=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
> -=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
> -=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> -=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> +sda      8:0    0  2.8G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 20.8M  0 part /boot
> +=E2=94=9C=E2=94=80sda2   8:2    0  128M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0  128M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part
> +=E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part
> +=E2=94=94=E2=94=80sda6   8:6    0  512M  0 part /var
>  ```
> =20
>  ## Secure boot on Generic UEFI x86
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index affb85b..10ce1cc 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -190,23 +190,23 @@ write it to `/etc/hwrevision`.
>  Set up `kas-container` as described in the [top-level README](../README.=
md).
>  Then build the image which will later serve as update package:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/trixie.yml:kas/opt/ebg-swu.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-trixie-qemu-amd64.swu` into a separate folder (ex: /tmp).
> =20
>  Next, rebuild the image, switching to the RT kernel as modification:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/rt.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
>  ```
> =20
>  Now start the image which will contain the RT kernel:
>  ```
> -host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +host$ DISTRO_RELEASE=3Dtrixie SWUPDATE_BOOT=3Dtrue ./start-qemu.sh amd64
>  ```
> =20
> -Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` f=
older into the running system:
> +Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `tmp` fol=
der into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu =
root@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu ro=
ot@localhost:
>  ```
> =20
>  ## SWUpdate verification
> @@ -214,28 +214,27 @@ host$ scp -P 22222 /tmp/cip-core-image-cip-core-bul=
lseye-qemu-amd64.swu root@loc
>  Check which partition is booted, e.g. with lsblk:
>  ```
>  root@demo:~# lsblk
> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    6G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.1M  0 part
> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> +sda      8:0    0  2.8G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0   16M  0 part /boot
> +=E2=94=9C=E2=94=80sda2   8:2    0  128M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0  128M  0 part
>  =E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part /
>  =E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part
> -=E2=94=9C=E2=94=80sda6   8:6    0  1.3G  0 part /home
> -=E2=94=94=E2=94=80sda7   8:7    0  2.6G  0 part /var
> +=E2=94=94=E2=94=80sda6   8:6    0  512M  0 part /var
>  ```
> =20
> -Also check that you are running the RT kernel:
> +Also check that you are running the RT kernel (i.e PREEMPT_RT):
>  ```
>  root@demo:~# uname -a
> -Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC=
 2022 x86_64 GNU/Linux
> +Linux demo 6.12.85-cip22 #1 SMP PREEMPT_RT Thu, 01 Jan 1970 06:30:00 +05=
30 x86_64 GNU/Linux
>  root@demo:~# ls /lib/modules
> -4.19.233-cip69-rt24
> +6.12.85-cip22
>  ```
> =20
>  Now apply swupdate and reboot
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
>  root@demo:~# reboot
>  ```
>  Use the `-v` flag when running swupdate for verbose logs of any errors.
> @@ -243,23 +242,22 @@ Use the `-v` flag when running swupdate for verbose=
 logs of any errors.
>  Check which partition is booted, e.g. with lsblk and the rootfs should h=
ave changed
>  ```
>  root@demo:~# lsblk
> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    6G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.1M  0 part
> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> +sda      8:0    0  2.8G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0   16M  0 part /boot
> +=E2=94=9C=E2=94=80sda2   8:2    0  128M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0  128M  0 part
>  =E2=94=9C=E2=94=80sda4   8:4    0    1G  0 part
>  =E2=94=9C=E2=94=80sda5   8:5    0    1G  0 part /
> -=E2=94=9C=E2=94=80sda6   8:6    0  1.3G  0 part /home
> -=E2=94=94=E2=94=80sda7   8:7    0  2.6G  0 part /var
> +=E2=94=94=E2=94=80sda6   8:6    0  512M  0 part /var
>  ```
> =20
>  Check the active kernel:
>  ```
>  root@demo:~# uname -a
> -Linux demo 4.19.235-cip70 #1 SMP Tue Apr 12 09:08:39 UTC 2022 x86_64 GNU=
/Linux
> +Linux demo 6.12.85-cip22 #1 SMP PREEMPT_DYNAMIC Thu, 01 Jan 1970 06:30:0=
0 +0530 x86_64 GNU/Linux
>  root@demo:~# ls /lib/modules
> -4.19.235-cip70
> +6.12.85-cip22
>  ```
> =20
>  Check bootloader ustate after swupdate
> @@ -272,7 +270,7 @@ in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           0 (OK)
> =20
>  user variables:
> @@ -285,7 +283,7 @@ in_progress:      no
>  revision:         3
>  kernel:           C:BOOT1:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           2 (TESTING)
> =20
>  user variables:
> @@ -303,27 +301,27 @@ root@demo:~# bg_setenv -c
>  Build the image for swupdate with a service which causes kernel panic du=
ring system boot using below command:
> =20
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/kernel-panic.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-trixie-qemu-amd64.swu` in a separate folder.
>  Then build the image without `kernel-panic.yml` recipe using below comma=
nd:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/trixie.yml:kas/opt/ebg-swu.yml
>  ```
> =20
>  Start the target on QEMU:
>  ```
> -host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +host$ DISTRO_RELEASE=3Dtrixie SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>  ```
> =20
> -Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` f=
older into the running system:
> +Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `tmp` fol=
der into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu =
root@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-trixie-qemu-amd64.swu ro=
ot@localhost:
>  ```
> =20
>  Apply swupdate as below:
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-trixie-qemu-amd64.swu
>  ```
> =20
>  Check bootloader ustate after swupdate. If the swupdate is successful th=
en **revision number** should be **3** and status should be changed to **IN=
STALLED** for Partition #1.
> @@ -336,7 +334,7 @@ in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           0 (OK)
> =20
>  user variables:
> @@ -349,7 +347,7 @@ in_progress:      no
>  revision:         3
>  kernel:           C:BOOT1:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           1 (INSTALLED)
> =20
>  user variables:
> @@ -377,7 +375,7 @@ in_progress:      no
>  revision:         2
>  kernel:           C:BOOT0:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           0 (OK)
> =20
>  user variables:
> @@ -390,7 +388,7 @@ in_progress:      no
>  revision:         0
>  kernel:           C:BOOT1:linux.efi
>  kernelargs:
> -watchdog timeout: 60 seconds
> +watchdog timeout: 120 seconds
>  ustate:           3 (FAILED)
> =20
>  user variables:
> @@ -419,21 +417,21 @@ The build system looks for the reference artifact i=
n a directory named `previous
>  Copy the reference artifacts to the mentioned directory with the followi=
ng commands:
>  ```
>  mkdir -p build-v2/previous-image
> -cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-q=
emu-amd64.squashfs build-v2/previous-image
> +cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qem=
u-amd64.squashfs build-v2/previous-image
>  cp build/tmp/deploy/images/qemu-amd64/linux.efi build-v2/previous-image
>  ```
>  Build the second image with `build-v2` as the build directory with the f=
ollowing command:
>  ```
> -KAS_BUILD_DIR=3Dbuild-v2 ./kas-container build kas-cip.yml:kas/board/qem=
u-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
> +KAS_BUILD_DIR=3Dbuild-v2 ./kas-container build kas-cip.yml:kas/board/qem=
u-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
>  ```
>  Now start the first image. Run the following commands:
>  ```
> -host$ DISTRO_RELEASE=3Dbookworm SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +host$ DISTRO_RELEASE=3Dtrixie SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>  ```
> -Copy `cip-core-image-cip-core-bookworm-qemu-amd64.swu` file from `build-=
v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
> +Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `build-v2=
/tmp/deploy/images/qemu-amd64/` folder into the running system:
>  ```
>  host$ cd build-v2/tmp/deploy/images/qemu-amd64/
> -host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu roo=
t@localhost:
> +host$ scp -P 22222 ./cip-core-image-cip-core-trixie-qemu-amd64.swu root@=
localhost:
>  ```
> =20
>  ## Delta Software Update using zchunk handler
> @@ -520,7 +518,7 @@ Next, rebuild the image using the Kconfig menu, switc=
hing to the RT kernel as mo
> =20
>  Now start the image which will contain the RT kernel:
>  ```
> -host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +host$ DISTRO_RELEASE=3Dtrixie SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>  ```
> =20
>  By default, SWUpdate uses the machine-id from `/etc/machine-id` as the `=
client-id` (configurable via `WFX_DEVICE_ID` in the `swupdate-config-wfx` r=
ecipe). This `client-id` is later used to create `wfx` job for the client:
> @@ -604,14 +602,14 @@ Follow the steps mentioned in the section [Building=
 and testing the CIP Core ima
> =20
>  Flash the BeagleBone Black RT kernel image into SDcard
>  ```
> -host$ dd if=3Dbuild/tmp/deploy/images/bbb/cip-core-image-cip-core-bullse=
ye-bbb.wic \
> +host$ dd if=3Dbuild/tmp/deploy/images/bbb/cip-core-image-cip-core-trixie=
-bbb.wic \
>     of=3D/dev/<medium-device> bs=3D1M status=3Dprogress
>  ```
> =20
>  After flashing the BBB RT kernel image into SD card, mount the SD card o=
n host PC and copy .swu file from `tmp` folder to root partition like below=
.
> =20
>  ```
> -host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu /<mnt>/home/r=
oot/
> +host$ sudo cp tmp/cip-core-image-cip-core-trixie-bbb.swu /<mnt>/root/
>  ```
> =20
>  Connect a serial port cable between host PC and BBB.

Thanks for taking care of this "minor" but then highly confusing details!

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

