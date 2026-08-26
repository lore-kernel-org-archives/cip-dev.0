Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32379C61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:43:31 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7945.1787733802360920401
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 01:43:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yQ3ZQApg;
 spf=pass (domain: siemens.com, ip: 40.107.159.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpROzgN9tqxSsFhL6UlxPhHDBdTIA565rYiqAmEHCoq+Oia97/mEUuwPMFoHX55B5ZEhBsA9/8hjWYAiPhPPd6Laf6FL5ptxwIKsCxanxBkG1IQ3QLTsuYrXtCApJ1FqcjBfoaZQwWQNzJdY5anRm5Kq2PRRQsTJtA/+R/6hckOurYJTriJW2dxvmDA22yfzLSZPANuvJ5dMwkq7SEs1OUqUfIRvDL8evPYR8BApKndhSvbRSKqvOBx3tjce7ZQOxGF2BZot1uQepoi8QKvkUS1PoX1bgFZoGeoALZCW6Gq1BcH+SIlO5KHQggTeJXWIRGNEKuLr+f60cvawcP/pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXPrNN6clIo6zR7JskC5U5Cl5Az4aG5MWbKIHbYA0Ek=;
 b=PW4GUFNIQ6eMPHma596TUmipV+kbUirdOCZivcS1Jem7EU+8sMlo//gf1ZsmKbnaBXv0uJRFaF65BqbQu08GmtagcSejNiNLukFY9xdWYKuebR2x3tfpvqFvONfkLNNyh7Rs4cjN1BrQ5PVxm7NcTaUwHVo84ftINVHS3OXShD1U4hvH8ka3ZrZziXtz3evBPF7Nc9eusWblNTp08grcCqgNO37oDYo+ZgF1/+6pno/3+y63E0sX6ks7W4HGXxS6pyBTrHz71ekV7K4aWtTmmN1lz8eqTq5jqFb9rv2ChaQO+/DIANFKtMNMAT+kcdnjl8qHPnhXFBR7XBDsiwQY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXPrNN6clIo6zR7JskC5U5Cl5Az4aG5MWbKIHbYA0Ek=;
 b=yQ3ZQApgOBohYQVtNtqprAqPZTMFZEe7AfnnIY4/9BH3SEJhN4lOwd9uI8GsVql2ybojml+oWXvWpEIFdFGSYI4A93JHMoG/0WTr6y23UNv4n2MAAlDxI+vjDU4tJdVTRAeftYG2+3fFfHparbhKjhuKHaJLLXq0Ed2D3UqnOH8h1XMM6TK5p3x1+AoS9j+xJ/00iDeoT/6oliLf7FPuS1aSvDyMszXmPUFX58ZeRBf+0iIGxCRCWQA9m7qzlpo8XXCN7ZMekxtTg+8oIqnrvQgxoblgPHYi4qPKlbNWKRmrLFOCO49L0nZOs6FJDMQAzawkc1n8EAgrPw6TRNLzRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 08:43:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:43:17 +0000
Message-ID: <ec62bbb3-42ad-45d1-b80f-dd5bf8cb0861@siemens.com>
Date: Wed, 26 Aug 2026 10:43:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/7] cip-core-initramfs: Automatically
 deploy secure boot keys on first boot
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <abb609c5b84dcb501c10737f47fe3a903dc09630.1787722904.git.jan.kiszka@siemens.com>
 <6ac309bf-4031-4140-a91f-201364052d94@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6ac309bf-4031-4140-a91f-201364052d94@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e336de-8a02-4d62-4df1-08df034e1355
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FqijeVgwNVgDplsfzxYBbtrlT8Y/Nnz8JpkjNr33qyRCnrk5R6KZuFxyKFtHianPo7DRnmor/w0BA91dYmSDH9FboOyHajxlq4vvoKjbt5P6ytx7ckTsLpgzWBcw8W1j5IXb/g6PpcZtHbPCuVnXXcKiG0GQpNWTDhtYTYT3y4gN1IVeYdqIleXjb+DlSMSEvMdhTxt8cQ8el+CzDtcDL6TdXo6Phm+wshDMH25d5hRdbceK1eFtDOnc+UGadR2Z8iFOQgYN0Ytx5mk0ivfcU17g9jhcZ++4iQxH85av9DCDAP8Go5PFip+Xyerlo1A/c77K/oKLK6BCbp+pYCHCqi0Adpv9UhYEEun/PYaca5sHyWGwFbu2HedG6ISx3aVSjq1W+0vPpzDvcFHiob8cccdddXRgKPbVCN8S8T3wFxJeRYlqGcpF/EAl16oq2o2LwMaRkxiZU2wkAwsMDJE2ZA9QyoVJGf20swPoTbzAtgYeBvy9W11RPr2pWC8rpm5Z8zhpgEkdxYR+mZeZTQHpvvY9+7ZTZ8aAEoCfh9Lz/gsr1ml/ed5KgWhvMpos53dsu6SjuMOtdZAnDAP7K4c/iHrsf9PGc4CjB5x+ARhdP36olreBvcfVPj1GNeNFXqry
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xj1ZfMbjKRI15/gysZdi1iVVdG6h51rPz3LLzXsPiCf+PvdiKbIV/wIvO6RH?=
 =?us-ascii?Q?vN129Gnz+dXgFzCpDTtf/+0rX2/710n2EhJK0aVzHVzb+ak8PW1EzSXqGxcV?=
 =?us-ascii?Q?XNxIDM32KEwcTXtiXbF87w+H3CtL2kFS+uTP+4cHTsQMjIuYpLHNSuSg8r60?=
 =?us-ascii?Q?Cl/zmLpH3Mb1gP+oioDcx/96Nm00yzCw5jOwNPYyKwEC83UKIylN48uTfAlK?=
 =?us-ascii?Q?5FbX4YyOzGbYRu57n2/hbmiEb2DtCG1B6Aqv82UDojyhoooOtz8qUqfTeapH?=
 =?us-ascii?Q?Nm19CjueDjIeCkB6DFyskvSGx4yjuBwCOu7WJPE0Xhd9IyNC8vLTYxXh+ARp?=
 =?us-ascii?Q?+Np1gprV1eHIxwCsVlwKv7EQVWQsCJb/o8QpVcMd+KrtgKZZstfvsI0+mDFA?=
 =?us-ascii?Q?YDWjAF11uhJEVh6hZS3xlR3fxZj8GLxZSideNbUb/8HTOODCaR/0zJVkXo/o?=
 =?us-ascii?Q?5n6S3bitdOiY6xwjwMc5ym+1ywE8oAMnPn7RWJrZWXmtH8ll7Ms9K6gK+7rU?=
 =?us-ascii?Q?do/cbTRfixPdjDLnfJ6B5KoVayC6GAbMcx0O1t0UfYvLjC8zXHT6lqAEsg89?=
 =?us-ascii?Q?O/WT15r52ZyM110Rh8H8TzM7UMPhgWUXFGutxzlhyJz7+RwCX+ajINH2ey4a?=
 =?us-ascii?Q?bn2pFbBqRorH9mXVbP0RHTqvBxkbbuAVnZCDeO9F0zSnkbFA6xyD51ZpvZQN?=
 =?us-ascii?Q?MiBdMIta3JxfFd1VhM4TQY/SOxToeM1kMa8ew+02dUlvXolKU52BkUq54+PD?=
 =?us-ascii?Q?kxj8bQTKimyqsKw8msXP9nkCNnhYOF0IhUsor98O/AHsZTobL/ptljdGgB8m?=
 =?us-ascii?Q?Jxt515EA50ZPz/DHuLZ+7HFMRJCSR2NKFPKfYki/sraDiK6PbihmRLHeVS65?=
 =?us-ascii?Q?0eID0IPKMT57sTQ4BiegL01sex7CRVLT0H15pDj1ckYjqayEbTx79uOZzWoL?=
 =?us-ascii?Q?jVkI7WlFxxK0qlvTYPXkI3LC44NazB79WXtsHFcd/B5/kPWGrwCLO5JTKFGS?=
 =?us-ascii?Q?Q5nNXXBs3Eazy9UJ8cYJAucOGVBWrbFnf1OmXm4pcmJjja6NDTjoiucpqtBP?=
 =?us-ascii?Q?xRT7ufHgiudwCM+c0eM5vN44jM5WmB6qWGSpknM+8Q4gGqpMOzSW/8OcDrAC?=
 =?us-ascii?Q?qVnnG5QtimNWPkN0c8lZLiEymTkh9/xFC2VWciU0FtJdqSSjp1wf/QZFk7Mt?=
 =?us-ascii?Q?GQ3UWwbV8wjU9VyJQB7Z2Y10gxZ5pyl1HzRSUo6wJTrgSpSE2zp5uWC8x6zW?=
 =?us-ascii?Q?+J5lzIORzdrFOZe7E4MB+lA5IFgNljgspHfpgnu8DsyafjmCH4fzipAhoxpp?=
 =?us-ascii?Q?TwCXIYFYhblFMb4BwX3GkBAoHyka2/Oc19BaQ4EVy6Uc+UFV78l1WbVQ+mzw?=
 =?us-ascii?Q?6R2NQzQ6dYuzzTi/qNBHIaxbBYpqPSZ7mUX0Jw1NDc5/E6oaNtggUHpmILn0?=
 =?us-ascii?Q?Hn7P5Rblf+7XumG0XyTojPZG4+uBtvOh+h5QZcj+64E22/8gVfEChvqKdQLe?=
 =?us-ascii?Q?L/bJCeKRMdqF70c80tSmwJNkudvlDSOanOw4rq81+Qg8y/wdxgpbTCoYKZpc?=
 =?us-ascii?Q?UV8Y6ZFDsbYcJKRMcBiYgxjX0w4BO94pEc2GJAjuKCAL8gFoWSGjAURwUIEe?=
 =?us-ascii?Q?4EFa7GG8ZhXomaWZNl74hcHWfvgAJKOW2bS2mT6wn0RBGQd0J3EutORJkyTU?=
 =?us-ascii?Q?lhLEQta3m85HWNbzVNX3hRJx5vjCPavWiSSUbRXSg0D1i5j+KhuAA98Y9JyZ?=
 =?us-ascii?Q?WYJ4j95erA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e336de-8a02-4d62-4df1-08df034e1355
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:43:17.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPrHOWblVUugNimUVOBOOc9fsKkiigt7a4xsSPEv+kjOYsciqxCRb0XAg4qVxP5ggupo3vDDUgwCiv38d+QPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 08:43:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24018

On 26.08.26 10:17, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This both simplifies the initial deployment of secure boot to a device
>> as well as makes sure that we will always seal the disk encryption key
>> against the right state.
>>
>> We only deploy if secure boot is off and the db is found empty. So this
>> hook is not intended to be used for key exchange or key db extensions.
>> The former will be once handled via SWUpdate packages, the latter might
>> be considered given a concrete use case.
>>
>> Note that due to the primitive implementation of efivarfs detection in
>> efitools, we need to deploy a horrible hack to make it work against the
>> mount implementation of busybox in the initramfs. A patch to improve
>> that issue is pending upstream.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 .../cip-core-initramfs/cip-core-initramfs.bb=C2=A0 |=C2=A0 1 +
>> =C2=A0 .../initramfs-sbkeys-hook/files/hook=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++
>> =C2=A0 .../initramfs-sbkeys-hook/files/local-top=C2=A0=C2=A0=C2=A0=C2=A0=
 | 34 +++++++++++++++++++
>> =C2=A0 .../initramfs-sbkeys-hook/files/mount-stub=C2=A0=C2=A0=C2=A0 | 13=
 +++++++
>> =C2=A0 .../initramfs-sbkeys-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 +++++++++++++++++
>> =C2=A0 5 files changed, 96 insertions(+)
>> =C2=A0 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/=
hook
>> =C2=A0 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/
>> local-top
>> =C2=A0 create mode 100755 recipes-initramfs/initramfs-sbkeys-hook/files/
>> mount-stub
>> =C2=A0 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/
>> initramfs-sbkeys-hook_0.1.bb
>>
>> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-
>> initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.b=
b
>> index b686185c..241e6af6 100644
>> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> @@ -22,6 +22,7 @@ INITRAMFS_INSTALL:append:factory-reset =3D "
>> initramfs-factory-reset-hook"
>> =C2=A0 INITRAMFS_INSTALL:append:ftpm-stmm =3D " initramfs-tee-ftpm-hook"
>> =C2=A0 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-abrootfs-hook"
>> =C2=A0 INITRAMFS_INSTALL:append:swupdate =3D " initramfs-${RO_ROOTFS_TYP=
E}-hook"
>> +INITRAMFS_INSTALL:append:secureboot =3D " initramfs-sbkeys-hook"
>> =C2=A0 INITRAMFS_INSTALL:append:secureboot =3D " initramfs-verity-hook"
>> =C2=A0 # abrootfs cannot be installed together with verity
>> =C2=A0 INITRAMFS_INSTALL:remove:secureboot =3D "initramfs-abrootfs-hook"
>> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/hook b/
>> recipes-initramfs/initramfs-sbkeys-hook/files/hook
>> new file mode 100644
>> index 00000000..770d4454
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/hook
>> @@ -0,0 +1,16 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +copy_file binary /usr/share/secure-boot-efi-keys/db.auth
>> +copy_file binary /usr/share/secure-boot-efi-keys/KEK.auth
>> +copy_file binary /usr/share/secure-boot-efi-keys/PK.auth
>> +
>> +copy_file binary /usr/share/initramfs-sbkeys-hook/mount
>> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/local-top
>> b/recipes-initramfs/initramfs-sbkeys-hook/files/local-top
>> new file mode 100644
>> index 00000000..48fe45d4
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/local-top
>> @@ -0,0 +1,34 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +. /scripts/cip-initramfs-functions
>> +
>> +if secure_boot_enabled; then
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +fi
>> +
>> +ORIG_PATH=3D"$PATH"
>> +export PATH=3D"/usr/share/initramfs-sbkeys-hook:$PATH"
>> +
>> +if ! efi-readvar -v db | grep -q "has no entries"; then
>> +=C2=A0=C2=A0=C2=A0 export PATH=3D"$ORIG_PATH"
>> +=C2=A0=C2=A0=C2=A0 log_warning_msg "Not securely booting, but keys alre=
ady deployed"
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +fi
>> +
>> +log_begin_msg "Deploying EFI secure boot keys"
>> +efi-updatevar -f /usr/share/secure-boot-efi-keys/db.auth db
>> +efi-updatevar -f /usr/share/secure-boot-efi-keys/KEK.auth KEK
>> +efi-updatevar -f /usr/share/secure-boot-efi-keys/PK.auth PK
>> +log_end_msg
>> +
>> +log_success_msg "Rebooting after key deployment..."
>> +reboot
>> diff --git a/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
>> b/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
>> new file mode 100755
>> index 00000000..408b584e
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
>> @@ -0,0 +1,13 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +echo "none on /sys/firmware/efi/efivars type efivarfs"
> what about "cat /proc/mounts" to get the actual systems mount points
> instead of mocking expected behaviour?
>=20

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/lib/=
kernel_efivars.c#n69

Was my first try as well, before reading that.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

