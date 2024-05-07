Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15651C10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 15:58:17 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.58])
 by mx.groups.io with SMTP id smtpd.web11.15566.1715097490214649892
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 08:58:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nZbeXpc0;
 spf=pass (domain: siemens.com, ip: 40.107.14.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqCSyeKvY1+a2ycW2uPtKCX9FmcbRMvbzb4rid8vl0CZfAJDFHCpDe9nOvezVZMp/Gfglj6wsj0gIXusx6y3peK+jWExHbuz5nbSjARmSoxx/G6XcvDg/hBqZhMCnCzX1oGugkEpug2bq26sh08Aq+RdvLnXuk2SSYp6wSgAi4dtz9E3nUvXj6dmDg5vHHWU+5ng2l5gk5j/nR+cZvJaVtt9nBeDBwhk8e2ubRAFTxkOE8kr+Zbt2OGO0bAatPqJPD+mjC/Ie2KYAw7RlLUWY4PPcPFV8SFXg0U6FZHp3Cdmcscy4XSEvnIbPmRK2Xwpr+xNsm29GhhPC1GLzd6n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoNfqntE9yKAn1WnB/EtJihwx2sFhIWW6xa+V759bjA=;
 b=FF+Xb+ofY8FQwV2sO5LS2WCsN7FHRDzfeLAJrqTIj5OyTx/ucTc622ufLB4z0e0vLZTihE+GQAXSeXse4ce6pALlpgyM8u+smTTSkaYUaW6riaxNYwnn59ghU1bjOlEKazPUju0wZ5cC4xhkSmyLpfUDlwV/etSe2Sr/sTSU0efXF5GdPTtT6azI1RDpWjHuMKpDrgX3BMhWmVrhyFI7XWFKOo8PVw423v7y59ifgKlQlff3yKR4u7CVVw9EH9avjGgNIEd8FN4zkN/ck9N5wFu/o0/0oUJZ9DLncQnK9dKN7lFG3A/pTXtXECmTXbMvL89r64tES2F4BSt44DTzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoNfqntE9yKAn1WnB/EtJihwx2sFhIWW6xa+V759bjA=;
 b=nZbeXpc0pYQ1iCr0NeMxuOp53t7cavL8iSLANM76aKEzNLkdkAlY1dNsu7GSd1mA4LHAN2jaaY94bD8VZ+zaUBjrwqOL4pZOLu+jD1rnyU3aXXvBnmqt3oLgQnc6JM2szsEzDQn/6wQ9PYfHWKmvIGyaJm9G86jZtBIQPNsPzYNvY86WKYwx7w/9iCV+e3O3op+qLh2KnckdejU0nBK9+SeLO2ohzHJNMn0JennxhkZo3E/p4jZGGhK3cSjTrbG41tiKHUSvTEnt7lEqHiE3Hk4jthBxCMmvhKgJpsX/cIab/mkioJwuD14cOASTxr05n72e2qgnjOCoYtc2vtTa6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8553.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:58:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:58:06 +0000
Message-ID: <3fb197b9-2128-47e2-8cf0-f515dd0160ec@siemens.com>
Date: Tue, 7 May 2024 17:58:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 00/11] Add option to encrypt
 the rootfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com,
 felix.moessbauer@siemens.com
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eb9c80-3e99-4a25-df58-08dc6eae7c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j/uXdOiBxKLKx+OU22ek3vMNLH2NdrgufkdrNO1YTDdWEOjbZsZx2OHVgx3m?=
 =?us-ascii?Q?rbf5pNwtJDnizm9M1g12XmMMEhSuJgOYWVeXcVOeYzoYW7BYNAZLvKQd/Nv3?=
 =?us-ascii?Q?2xlgWxxSGcQZDDcuLy7BqRSyO9iKfa8DJWNK85kGmmLE8UN0aNA1/S6hbzle?=
 =?us-ascii?Q?OERtuirQzuzjTB0z19Vfw1K8mUW5urKl7xpIM/Jko/AgvoETdoVfBsn5mwx9?=
 =?us-ascii?Q?UtpLRPbvtZ9diqBGqrsH8o14Un7N7aH/XyBxf2CRt9AYC4eHUvRdkeWFEmst?=
 =?us-ascii?Q?6dJZta55Nmyc1GIE1bSPZP9+st3StsXE3q3/EwYwPv3YXbKDpZzGYXYKCGQv?=
 =?us-ascii?Q?2Z+dDwv3SD8vRW2g1YK8UP/afsFlzE+QT2n42/vKA0hMkgIEtQNPAfLUih94?=
 =?us-ascii?Q?9ve4617trX5KdFmYbJbv1bNxJxTTwLGIiFFb2fhHUndd1K9VID5uhjvO7egS?=
 =?us-ascii?Q?bezEtx6qSgwRJX3hgJsetni+zj1hqOXsVk8bTiZRH75fU6AGvHxnpU6gIZpD?=
 =?us-ascii?Q?EnCGEdjDLa0EjE9z8PDoz4354U8V5xDh67ZfCA7PgVF2wWuY9P7XZ1Z5rqT7?=
 =?us-ascii?Q?UhQ5NY9jsn42wbYT2GFLoc+VyovpJF6pxpwbTLhmaWmxqT2u4dXfRTLX6j1S?=
 =?us-ascii?Q?i7GC1otjZe41BMFNC8+1C7Am3r2/biEFHQqf88BHLn42YNwKWIPXtErwViuG?=
 =?us-ascii?Q?eAsUX2c95Q9BN6Aa7++K/ZVbk7i+0TcnS2AmJtsa22cRlETcdgP/axI4hUmv?=
 =?us-ascii?Q?+h1ZSOU22I+tYVorfzy9immDQ8UQLzUHzYPCfggTDOgNcHRHBm4/BLjLzEuT?=
 =?us-ascii?Q?Z8o1Nk25BVv8BlLRM0DXExlXsoDdTzCCBdNi9kMzuh9Tj0d0E2gMwkeCzBE0?=
 =?us-ascii?Q?4/hIiH5QURiMey2ohCxrnZ1DrN5JOVIv0i+Xr+wOQviUZ4pP+wu/gBVxqlXl?=
 =?us-ascii?Q?HmAO/jJ2WckriWIh3s2TdaQEmFyFCXMy7mhdKmXMyBoySGSJyDjR1wn2OuGW?=
 =?us-ascii?Q?zwnPpMctZsaTSZB8SZpmMKuelrFepJ5wI0QCODZ64ZYG2bx5aL2YHPQ5SWHR?=
 =?us-ascii?Q?UmRgnP+l74jFp4OpBRuCjEi7J2OhA53tooKP1yr5dOAcefIIZVCkqSKbQbVF?=
 =?us-ascii?Q?BJSLTGSyyWtRQk9P4tYrq9pdrWRqTVsr05XxYgFwKKaTmo6Js7OUH3+dfjiw?=
 =?us-ascii?Q?LUDmKrh/yGFPlSy9ecjKma+QbYWGNeVAKIh0zRyN1tJ3/Cx4t5zuRZuXN5g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3nI/kAnOy6sB2Mhgvv4oY78zncqWh7deFFrrtkQ0M6E8aYWb3FEPbu7tzU6a?=
 =?us-ascii?Q?FtjvV4hCAV9O56xjvskchVaXa3HaB7SXoqthgl5JTv9yrFHX5qvV3Bzlu8CN?=
 =?us-ascii?Q?042Espy3c68McK9xcgCBL6q/tTci0514C79ZzEdoaqjo3mfsZIDioW855SLN?=
 =?us-ascii?Q?zVVZuym+0PtKsdIGxt9l+sz5bDL8cxfkzGmpdRvLkkypil1zPCuZsWp28mZL?=
 =?us-ascii?Q?ZwYaLRsYW3w4Xi3rPDpKPbJzLk/kT0k81GvxMatIw4N9/3F0MpR+HNZW3h2S?=
 =?us-ascii?Q?1oUPXHAOjOXD+sH6Tmmut21zF7uIY0Q+Mv2UnUYHEgjAPaZ3+iXh+yTNESNo?=
 =?us-ascii?Q?d/nqN+LYvnwesFvnJ8/SZaD2cDCCTVmCy2txQdzRfs6G/T8SpME8XmUJpHWh?=
 =?us-ascii?Q?ddLdOsYEFkP0ToZIZgE7nUKPBXV1XzB4uKt6YQSy1Q0BHBQR+ntTKwdXTsYm?=
 =?us-ascii?Q?zWlyW0mc1RgLj0JDoyigQPAT4MPvSqtmNabowfuAV9wU1NHPDvM8sfvzaV5N?=
 =?us-ascii?Q?A29CkBnbPcr8uMf/khg7+CVc//4CTkXGSohhLD1r3/0p7eQ94ZwrTkTIGaEL?=
 =?us-ascii?Q?BWqt1nZHuO7tFlcYPhArn7RwXt5z4XEnJpQIx3vGgUDRVF7b1i/L0SM4l+MK?=
 =?us-ascii?Q?ZwAgg3IsZF5qbiShcAoKygIf31IEI7rG01sVG9i9sqxQ7V+JexD0it+nrcZE?=
 =?us-ascii?Q?JXVn5ac8fzyj4XCOsGr9cQDybvT9jZQB+DQvYnZ8ctUk6y6yS2i/CboMwYVY?=
 =?us-ascii?Q?xQN7oa/3yh/xtgBbmpsiniOUHLN1DVpmc4FV4HJYKoCUn5Awh0L0h5IDV0Nw?=
 =?us-ascii?Q?llbvP+Bf4rinc3XfotUqXcBXyVMN62KKbNGOg9ijzLnR0sxrjLygO7baW3vZ?=
 =?us-ascii?Q?Cni80lbrBgjCdz+6cz2tPQwakf+c3dISydLELtPLqcsnmscErhNIO8i78Snw?=
 =?us-ascii?Q?P2jNI1IHYFq7IlIfoiluwA967IHonqI3qkYLkFfIZ1S3ztpD1JWgjGa/ajm7?=
 =?us-ascii?Q?4FvPBgxHNmxqCua65rTUv9tjjvbfcGQ3Wfj2yChhvmmC1ZICdRcRdcmaV3TV?=
 =?us-ascii?Q?qzhZASbJaZbfkxcaGGzsNE4itQC+0n67emtcl7p/JfvmEuC5WX+Q/xaGeghO?=
 =?us-ascii?Q?xZ6UEmKSA7UUgDiKizGYdzAXoSCxbJEN2SHtE9KRsjX+Pl2g38skJKyVSewb?=
 =?us-ascii?Q?yRZTFiQaQcvAXS4/XpEqZb+sl6qCl/A8CkT6jzP7mWkKKoZ7GJZUPkEVxP1T?=
 =?us-ascii?Q?VFgL7mSg/mpi7mtdSp9jRDHw8eaRHgwSAdrX/uNW6oe/ivInlEH7FVmgRbov?=
 =?us-ascii?Q?sjji4A0bL/pGBt9oDLmYystUwxJSoho1jNFkYTyroKai4qT46FCigJ/eSkmg?=
 =?us-ascii?Q?BNl0O4RBmdMPzJxHOp5kNPCKJnEyMi1l+jM6rhGZ+5m7YSppHBbPXL79bFba?=
 =?us-ascii?Q?TT+vRGp3WeAAxEKyaFOGvtzvmaYrh23Tbwngob6Sme8+FPq+x6p7NRkSLJdh?=
 =?us-ascii?Q?fJkAqWyfFUb8t4MrkU9KXXnKIr7G902Hbhcy3KGzOa0ow8cV4uadEdvN2GUd?=
 =?us-ascii?Q?WmuEXFTcOMrBHp9M6VELt83rH8uav+3TUxSPIbLZ98v7EFJvVRx+aN07sqZb?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eb9c80-3e99-4a25-df58-08dc6eae7c2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:58:06.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVXhR61jxUy0deemPYcSFxmLytlMpT9PqcTF8jZPWTA8GjBn2xZiYVUBSvkS9kx2SxYRLlJ0XCXKNZPVky+dCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8553
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 15:58:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15858

On 06.05.24 16:17, Quirin Gylstorff wrote:
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
>=20
> Changes v5:
>  - README and commit messages fix typos
>  - README: Use must instead of should for secure environment in case of
>    encryptition
>  - Remove encryption menu from Kconfig
>  - fix warning about '-'
>  - use "log_*_message" functions
>  - reduce log message
>=20
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
> Quirin Gylstorff (11):
>   wic/*: Add part-labels to system partition
>   initramfs: allow empty mountpoint for crypt hooks
>   initramfs-crypt: Only resize partition if ext* formatted
>   fix: use luks2 to identify encrypted partition
>   Rename encrypt-partitions to encrypt-data
>   Kconfig: Add option to encrypt the rootfs
>   crypt-hook: Extend partition selection
>   README: Add rootfs encryption
>   README.swupdate: Add section about partition selection
>   fix: Remove spurious '-'
>   initramfs-crypt-hook: cleanup logging
>=20
>  .gitlab-ci.yml                                |  2 +-
>  Kconfig                                       | 16 +++++-
>  doc/README.swupdate.md                        | 16 ++++++
>  doc/README.tpm2.encryption.md                 | 22 +++++--
>  kas/opt/encrypt-all.yml                       | 23 ++++++++
>  ...ncrypt-partitions.yml =3D> encrypt-data.yml} |  0
>  kas/opt/security.yml                          |  2 +-
>  .../files/encrypt_partition.clevis.hook       |  2 +
>  .../files/encrypt_partition.script            | 57 ++++++++++++++-----
>  .../files/encrypt_partition.systemd.hook      |  2 +
>  .../files/encrypt_partition.systemd.script    |  2 +-
>  .../files/mount_crypt_partitions.script       | 26 +++++++--
>  .../initramfs-crypt-hook_0.2.bb               |  3 +-
>  wic/bbb-efibootguard.wks.in                   |  4 +-
>  wic/hihope-rzg2m-efibootguard.wks.in          |  4 +-
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard.wks.in            |  4 +-
>  wic/qemu-riscv64-efibootguard.wks.in          |  4 +-
>  wic/x86-efibootguard.wks.in                   |  4 +-
>  20 files changed, 158 insertions(+), 43 deletions(-)
>  create mode 100644 kas/opt/encrypt-all.yml
>  rename kas/opt/{encrypt-partitions.yml =3D> encrypt-data.yml} (100%)
>=20

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


