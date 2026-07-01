Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F71C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 08:02:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39747.1782892922707240381
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 01:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=b5fFSmTf;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoT2onoeirgtYmD/yoAbq3ApgmAVDC5im91z2S8NyblKPjPnq5Ea3Zjl2u/+s/PLBEgzTquK5nIXKKmz4FBqCzq8Qwgm5w0vkA2ju7bm04NBU8ExDeY+Y2sWkn0NNQ5YD/uCbWh3nYV+XNq1MMO7IwiiK4l2rTtO91JcQBKie1qcEfEnuhCpvPDMjF5t2rtcsoSvaAmqONEHvwQMIsxyqYdzFdl22NlRHEq/2JXS6WzbfDga7hYXPL8JMZVM863RzwuaHnGMBmnhjQlXktco5DlNHYVMz3ogq/jlQ9bjGQ3lGowB03v8qMWvStoOXfrlQiTQHlvAE1rxHNkW9SA3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTXDdrAuT7jjtx1WJGbDStmQmmVwxhn5uCkxdPdEa1g=;
 b=s5u8M18HyLfy4ZQrjs2ODhNl384WrhrtTvsK9vaU4bSnkXMeLh0/ahUBuZ1x1OOSw7CxNZXjc/j1FZFjUreZG9HNTEn42Ab6lbWhoIukxU+ANOUcUZYYzdP7TO0632Ss7mrsDePpWyXb7rsSZVtXIWMIxeWc1o+leWnPvBVYYAtfDecQv7Yc7BPliR8yvsrEWrVx+1+DXpz7YKGu9u7GROqJ9tAoMR5OHZ5Xa2w7CyJExXInqsB3TMrYLDgUzX1AG9USR1BNwgETL7BDEUyjQXb+VaasiMBhyFi9XeX2e1r5pm1cr0k/hHKEnSb0Mmku7INgRg31/fSMZub7Y3kHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTXDdrAuT7jjtx1WJGbDStmQmmVwxhn5uCkxdPdEa1g=;
 b=b5fFSmTfh90Y6PKYd5GfKw9llYCpHb/itpXVRIKgLKiQjRfedP4FbdP0MfezBB14fdIm+20gOrOP+vNdSHOmHHAwGTKLAs+3PJy4xR2rCfln47/NMZEuf/0lQyh8bRp8gDvG7scvJx60Pkc/ftNFj+mXUJBK09TJCx+hhNj3PXhl3XBHXBiWttUnrooEUMVhP6cyI1Gr3EvngAlRfmO7CnOGbn0gywLCdDxbfZnbt4BTgl9BhDMhZWSg2N2HGY5gyQnJXe/tJEIgycndpkOKjqRPa9LI7QvMtLvl/jm5RwWwtYmakrFI4P9pSwzDM6vqPwZ7a1Ce1lU5NEslI8tVug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 08:01:58 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 08:01:57 +0000
Message-ID: <811c2a12-02e3-40d5-afd9-09805c200d2f@siemens.com>
Date: Wed, 1 Jul 2026 10:01:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] Revise README files to reflect the
 latest changes
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
CC: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260630133132.2429510-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260630133132.2429510-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abbe19e-ae6a-417f-9b6f-08ded74705f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: 
	C+hGzoz47BYdEfh7sCZI1vtYkAVBLzOIT+sqZ0edL6ryC8MpiPWsYzXyzWASBH+FntMxTEJ6VZcA0rcNNWKztNT4S2mpWLD42qH4kEMvF6s3sQ0y9/nz89TjjCfaBqXioRWg/LY9BNEV8llU0Qp9sUM5dPAJ4nZohaXkGEN4+Bs62v6URIkiuo9vOQnUcT1dR9qJMOAlW2a2BbfVvSYp/UdfY6zHeFbHDu8ADcwzocDSvlwCsh08Ziv/7MAc8W1MQ58LZMTcXTq9QxdQrXasNS6NItOUrdLAEwEvtWchYhyOp+DmPv7gZZxi+LjDgfGSav9M1M5uujQkwD6tkXrMr8J+wIK5UHHKIMpEpM70MuU47hdGD0gYKg4hWbVA4U9rAilHVKbOVxepmQhp9ya+etsQViiu3gV5gsPOCIiS3FTCZ3JZojime7oXtIPNEuTUOChqUhU+4nYtrzPL+KPAf2V25pe7KwISTAxwgs4pVNrCfdaxp+E/sAJQgtj8khH3YnVHg/2KsuMOCf5pfj74I1dyABA71wlvdJJCaYGw18tSiJ5PmVJRVyJ+8bLDDfF1GDY3QmLFgkVGkBJ/0DY5/fL7AZnSs8UTRn2kiSoFW/U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PbMDbZeopP1C2xQPhPMJH5AOjkwYYcPAmcCUH06r7F0cIJxUhmP/8J/g5zLK?=
 =?us-ascii?Q?jsPp2zxesE8Xq/wnY2uVOMiSeII0DC/z064kj9I0fi7hjowFZEDaENHoNGZ2?=
 =?us-ascii?Q?lwDg6I7k1jHDlvIsizKAMjZ1Z8jnvPpK29Qk+6rlxR5/2kmlBddYh0hPdKPp?=
 =?us-ascii?Q?atehF1RY/KH9fGlCBSz+SRaik6mjrNk03VuHX3Ypr/WkIBKRCCGoLlFd8lG3?=
 =?us-ascii?Q?PT7T+jyRgLiWhC76QFYFUyr9k/PfIPfZ2Ggd2pl3JyDpMHdx7pxgPAopkF47?=
 =?us-ascii?Q?rd8hsbPfpj5HNrEc+cIkoN/lf89coPiBJWhf+3zhCy7oBtsl7Opz+o24shY2?=
 =?us-ascii?Q?1fq9LJudaIBfRsP2bZX1qK4vJ3eVwBcmBW6IlmwtT0p7MyF1w80jAbMS69Ur?=
 =?us-ascii?Q?2EMbya7N7paFG0XQyF72g70tylLlCkGIpY5rK2RCHUGr9l031CgPYuDBiNBO?=
 =?us-ascii?Q?2GUBAnVysNwwooJIX19uw+70hNph5U3XMFzrfDjIWlet/5dWp33ECfayaZfy?=
 =?us-ascii?Q?DhyPoHD+rVBNEBMs2LDwo719xRdqBSG0gR7w5noqa+lYUaS+CqgVxVBkFpxq?=
 =?us-ascii?Q?R8+lVhTfGeDrREkRAZtggYnObWgEsn8N4HN7DdLkEBNl0KH1guqvK8rCPKru?=
 =?us-ascii?Q?FhWm+JFh5lKUQX0g/gdiCnZ+s7y3Wks71vW9SUSYpZyC+iqfmtdvJKStkDKG?=
 =?us-ascii?Q?DUwRJjYpn7kV6RMjUiVwRd0DaIfrlWClf9EeKOLidSsgzOiBuWr+z1SRwRIE?=
 =?us-ascii?Q?qp+ntN/0cQerbilyyLh40hDG7i0h2rqFQT6kFXSFIffzufcNpFxjNEVJB820?=
 =?us-ascii?Q?BixWueDxlx90AHc2oEf7dyVSBuLYEU/O6Net9KnOvMFkqt9PQ3gJsUFr18HD?=
 =?us-ascii?Q?JGVlhA8DBqR0jtb6l2HFXmJN3SFMuSLoQIfi8VZOhyt4Wqz3+o3ZDW3AgSBA?=
 =?us-ascii?Q?JGyagHiHCp62rtHj108kP0ldKpYUcQG+1xn0z+/TBroJwOF6oX1rhOsovnlm?=
 =?us-ascii?Q?DIxpxQDbYZCB3KAYcYmLLb8cxCHD7fGH4+5FY23cpe18OJkHfC4QvUz70weI?=
 =?us-ascii?Q?IvjzO58JRiP8yVYI34Dp5w+NcmVBJF4VKTMzbCqawP3Mt5vzRG1WnhSqm4Hp?=
 =?us-ascii?Q?6iRPeXmbcp1pxHqc7zp8QG4NgCwpy8IJqQ/q4B/f2vWwjjMu4L3v44Ftuwct?=
 =?us-ascii?Q?ll448VguxcwjaMuzCHXVnSHCXny4YErp6MdiXCj2I0mbsns3cSXgwaYGWNvU?=
 =?us-ascii?Q?ny9xbfGTepOQtCEg3FWdklcJfK6X0pt+3ikTP3cuwotA8Ufyo+wMfQpOIZ87?=
 =?us-ascii?Q?4WCQh/P+o3paDJp6+rzuSY+4BRO17arVr9T1jNgdYsBBEEIOwig34qvLSQ1N?=
 =?us-ascii?Q?Vx3yONNWj2XA8Jj0j92KfBNVfHnMuWeVrpVMWaDFWdJrjUl9vFil13t5asEE?=
 =?us-ascii?Q?onaMNdcK98Z3z1XAE1oRMk+MN9zLe/PVLTD0SenB6rXQ8V3RbkRSD5k+5Ist?=
 =?us-ascii?Q?0Wlsxg4zmcX+lKziYVpaG4PNr1+LLv+aBCLxj/z0FRNR+MNfEJI3rhSlJtpm?=
 =?us-ascii?Q?fN473Q61i6KOHQ0962M7mwK6W289AQWJof+xrFV40AK5gADnXb+EZd+L4ltc?=
 =?us-ascii?Q?R6YREgz58WMyzghgazIwjXht/C+mlUNl/ZMqEwdjzAzr8XgpId/a6aV+Zrup?=
 =?us-ascii?Q?u8Ct/itkEQbRKSnWfIb1z0JaKDJWpTIw62pbYUKVIlbYmt90MIH24HQzkOkF?=
 =?us-ascii?Q?kOhP/9IwvA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abbe19e-ae6a-417f-9b6f-08ded74705f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:01:57.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HogywNhE2rG7uZl2D0OsAfyZwkVYIpzg46gQeu28gQ485doXf7M4pBlGO91+BDXxQKQZ+N5Tg53L9sXEJv6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 08:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23365

On 30.06.26 15:31, Shivanand Kunijadar wrote:
> The SWUpdate & Secure boot readme files are outdated, adjust these files
> to reflect the current changes and debian version based on the master
> branch.
>=20
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 69 +++++++++++---------------------
>  doc/README.swupdate.md   | 86 ++++++++++++++++++++--------------------
>  2 files changed, 65 insertions(+), 90 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 8ab67a8..3bcb3f5 100644
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
> @@ -196,22 +196,14 @@ kas-container build kas-cip.yml:kas/board/qemu-amd6=
4.yml:<path to the new option
>  Start the image with the following command:
> =20
>  ```bash
> -SECURE_BOOT=3Dy \
> +DISTRO_RELEASE=3Dtrixie SECURE_BOOT=3Dy \
>  ./start-qemu.sh amd64
>  ```
> -
> -The image configuration menu will set default values for start-qemu.sh f=
or secureboot
> -and the following command is sufficient:
> -
> -```bash
> -./start-qemu.sh amd64
> -```
> -
>  #### User-generated keys
>  Start the image with the following command:
> =20
>  ```bash
> -SECURE_BOOT=3Dy \
> +DISTRO_RELEASE=3Dtrixie SECURE_BOOT=3Dy \
>  OVMF_CODE=3D./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secbo=
ot.fd \
>  OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
>  ./start-qemu.sh amd64
> @@ -233,62 +225,47 @@ EFI stub: UEFI Secure Boot is enabled.
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
> +DISTRO_RELEASE=3Dtrixie SECURE_BOOT=3Dy \
> +./start-qemu.sh amd64
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
> -- check which partition is booted, e.g. with `lsblk`:
> +- check which is the root partition and it should be `/dev/sda4`
> =20
>  ```bash
> -root@demo:~# lsblk
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
> +root@demo:~# ls -l /sys/block/dm-0/slaves/
> +total 0
> +lrwxrwxrwx 1 root root 0 Jun 30 12:56 sda4 -> ../../../../pci0000:00/000=
0:00:1f.2/ata6/host5/target5:0:0/5:0:0:0/block/sda/sda4
>  ```
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
> -- check which partition is booted, e.g. with `lsblk`. The rootfs should =
have changed:
> +- check which is the root partition now, the rootfs should have changed =
(i.e `/dev/sda5`):
> =20
>  ```bash
> -root@demo:~# lsblk
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
> +root@demo:~# ls -l /sys/block/dm-0/slaves/
> +total 0
> +lrwxrwxrwx 1 root root 0 Jun 30 13:20 sda5 -> ../../../../pci0000:00/000=
0:00:1f.2/ata6/host5/target5:0:0/5:0:0:0/block/sda/sda5
>  ```
> =20
>  ## Secure boot on Generic UEFI x86
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index affb85b..a335eb6 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -192,7 +192,7 @@ Then build the image which will later serve as update=
 package:
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-trixie-qemu-amd64.swu` into a separate folder (ex: /tmp).
> =20
>  Next, rebuild the image, switching to the RT kernel as modification:
>  ```
> @@ -201,12 +201,12 @@ host$ ./kas-container build kas-cip.yml:kas/board/q=
emu-amd64.yml:kas/opt/ebg-swu
> =20
>  Now start the image which will contain the RT kernel:
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
> @@ -305,7 +303,7 @@ Build the image for swupdate with a service which cau=
ses kernel panic during sys
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/kernel-panic.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-trixie-qemu-amd64.swu` in a separate folder.
>  Then build the image without `kernel-panic.yml` recipe using below comma=
nd:
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
> @@ -313,17 +311,17 @@ host$ ./kas-container build kas-cip.yml:kas/board/q=
emu-amd64.yml:kas/opt/ebg-swu
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
> @@ -419,7 +417,7 @@ The build system looks for the reference artifact in =
a directory named `previous
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
> @@ -428,25 +426,25 @@ KAS_BUILD_DIR=3Dbuild-v2 ./kas-container build kas-=
cip.yml:kas/board/qemu-amd64.ym
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
> =20
>  Currently zchunk based delta updates are supported only in trixie images=
. Make sure to build the first image with trixie as the distribution with t=
he following command:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/trixie.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
>  ```
>  For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the =
URL of the zck file that is hosted in a http server and set the `DELTA_UPDA=
TE_TYPE` to `zchunk` in `delta-update.yml` file.
> =20
>  Build the second image with the modification as shown above with the fol=
lowing command:
>  ```
> -KAS_BUILD_DIR=3Dbuild-v2 ./kas-container build kas-cip.yml:kas/board/qem=
u-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/delta-update.yml
> +KAS_BUILD_DIR=3Dbuild-v2 ./kas-container build kas-cip.yml:kas/board/qem=
u-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
>  ```
>  Now start the first image. Run the following commands:
>  ```
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

Thanks, merged - likely now the last commit before the release.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

