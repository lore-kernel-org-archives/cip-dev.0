Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A7C25B7C
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 16:09:53 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.75])
 by mx.groups.io with SMTP id smtpd.web10.26232.1716912589684979251
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 09:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FP64kPRh;
 spf=pass (domain: siemens.com, ip: 40.107.7.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMQ36/wlSPjIPU62UJuf4gbA/ofm4TApPMytDZJPpiNeZ1epnE44KO20UudAkhXAkY8CLhRmX06BfOkPlFqrARLC3nZd0iBhmSjCUJ2Zse+Au9m1eztGRgYob2eBw+fmiyD8eOh+m0bfdq3rcL+zx/RosMKZuZAK6aRD3JBP2T3PizB8M3bIlDJi9siT+ha8O3gZKCDiCq+7WwUbF7jOQ4i45MFNO0iACXbpkurDLU5adLSu08Eam486Y/8ENdpkWUU7RDLsgWQVy9qaltqOJ48m5e0hWMRLHLvd92G0t9W2QSSOnwYK0T0sQi1o5l2x7joTE2kgQ2t0j3vAVZmI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D10LFpcgxg1D1lW/GPt24n4/hrhkwWcP+Zv1rfIeLd8=;
 b=fxnbtU6OhWgpcBw9XFs8Oba5LPbJZqlye6B3cQtR0XUHOkbIe4dGFMgSL9ps6xAEDxNwNuRlEo3jD7Nage921zPASCNbsWc0RWl860sPALWxz/fgqB2Ir2QKfOQlKznfppRvap1b/jZ8h77jpPPQjtro0eW9RVXrXA6Jdse9fuIcns//qyy8qcf/+2nORLE55/xYzyrbvSgiQe5YrOvo7bDJDx5CNeTnSm3++0LyBFdn6cYD0Clwkd6M8wK/GvO/KhjoGpStleu1aJ4P8H2RNbYUb7GFKy9lJWbJ6TKIVieMyT+eXBliM0vYTC9qgkitYIpNybsu0xynW8Gd79Rv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D10LFpcgxg1D1lW/GPt24n4/hrhkwWcP+Zv1rfIeLd8=;
 b=FP64kPRhf41tvlR/qGpGFGaK60M3RNdXiHqQSG8X/xBZ3pX29/56lEq3108eVwjNVGMBAHW/NQ0nOtGHbZH6TXfsLXOvk7UCZjPO6G4J8RV2RXgI849MFrVqq8p/N1Xj27H6jzPEIa484C0+SPC8nTqgaolw9ssJlMXfiuv1cBtDTCCuVu3jyNXbdEyc15ahZrY4gBuojA5pw99n8kdl/XIe2STb3s6IrPUoit+17loeTjt6vmdqwF6vbJ2EmBXohPDp9MTEbgwkVV4dYnKakEkdqRYd/uryNbmuznULol4PF3QPFdj45CBVrSEHWv2zlkMM9kywDm3GReMQXCzqbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 16:09:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 16:09:43 +0000
Message-ID: <ee8a2021-edd8-4bd6-9438-a58c740c86a5@siemens.com>
Date: Tue, 28 May 2024 18:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] enable secureboot and tpm2
 encryption for generic x86
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org,
 "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "Schilling, Benjamin (MO MM VT)" <schilling.benjamin@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <20240528155435.925718-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240528155435.925718-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:610:4f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 438f496f-137b-4f7a-ee92-08dc7f3095ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Cy2FuYXU7CUfOXPzDHA9FLKKR9AtEDyx+0dQnztmqZ/nH5K+eJmPdHlGbuTD?=
 =?us-ascii?Q?RRYP+qKLkMmbW1ioxeH+ZelwXnXFjnS3kB0BzIlnd55vdW5HxgH/zxWkAMzG?=
 =?us-ascii?Q?IInAwW6Zxh2YF1Ro9qSikoA71tcMDJGamaQnllJY02kd+RZkJlcQWNlNuC9t?=
 =?us-ascii?Q?LKFdIbtDj0yF+Es7Z4EWpEG+lh8tUJgfSOssJKOEVSFDNeEW1mHK8OIbRlms?=
 =?us-ascii?Q?qRCeZQHzcCD/DEBgmzFdm0M03dcDmjtyervKNKIIF1UBQhoitKE8+HvYZXip?=
 =?us-ascii?Q?GLLUMm+rLwfk0HnDMbbmLbXtxrg0Uaf4K/88z7RU2ynL1sCO5cYXLDCuOiUf?=
 =?us-ascii?Q?fNdqE0n8SBzrU0K9c+r7+HcBKEDyE3qaZ7MhqFyKmE80L+JpMelgU78WqHso?=
 =?us-ascii?Q?x42CLmc55hW5GAkaLfTlAIGWSFSiLg1b7CZRpSj5GFGVHt4Yk8Nxqc6BC7cR?=
 =?us-ascii?Q?2L5hWBEnkxdksreWqaweUGKvoUeXTXdhXGepsi4IizP7ssCHB7w/RZmmkaAF?=
 =?us-ascii?Q?meoCLV/iFF5EYc4L7sD6zhuPVNMN0j169MQKS4JinJhB+XNCtWa3JhPHK3ce?=
 =?us-ascii?Q?2MDeQ7xk2gcmX6WF8COgrfaAgFLjZWkuJy4sBrJb5jRfbMuSfMudd3eSwQHX?=
 =?us-ascii?Q?KmpgwoNzKE7LNDM0VR4Mwlvrr8dF3UQIpJTaziZGAMhC7IMciO9hIh2a3RKn?=
 =?us-ascii?Q?qaGTvLDTJRE2Q9/mgiUgate1dhunxjG3OcZNbE563aBXp+w7DHj7UBv4xoOm?=
 =?us-ascii?Q?V2BLmaLTW5mKhtfvsVPslajPH6tkNLXhDIBmDHi2Y0SZUYcCjzR+xSGuA9wv?=
 =?us-ascii?Q?3VXCxzDFO7I/pfizSnBMQQsRsOjEaSlMaLmBHpAggLagzDlHVPClaiSEF9MJ?=
 =?us-ascii?Q?LBA3rVeKvn3MbCT4nRUZ4yMfZj8EVz9bgMWRfSVMQJr5JXVw2lX/0RGwBv5F?=
 =?us-ascii?Q?Xn21MGEtNNDkQfis456lqfRcRAmvbb9nMgrpW2x0I4K0wbcqNFnZoY97GZir?=
 =?us-ascii?Q?q2lWPs5gm6JZdrMrAcnCHdQbh1fmpdnuwFJHRj9G83T6YCc+Wn3G/DaFkNOB?=
 =?us-ascii?Q?vnbhIcnE834kTZNZTLjBKuKUQInGIb9J+ABZIyUYcxqSFQMiwHpYKdSEXwh+?=
 =?us-ascii?Q?wFSL4RrxjsOfklTmnYIcU+qkc5MMLcCK2QH0bSatMlPqjjjD70ZA/R459HyQ?=
 =?us-ascii?Q?3JI8ynjwZv/oJrkUiGhUx15HCLcB+s7Soi3rp1egEC6x3pMIzS2G/r+rdmvf?=
 =?us-ascii?Q?gGA8zMRqGTzmtu7ZAwLWOPasTdxlEQHCdLXsIytLgQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ytjeW+3ZIeAp81/MYzvh42R5BumYo5zIxDWsMJJZ5T+n/5YyY5ygv5eVSSvd?=
 =?us-ascii?Q?fe4o663/ZFSOybh8nC6d42BRvab9y1oAgSVvbuY6B8EsdwQ+ftBp8//cDWAE?=
 =?us-ascii?Q?v3WF43J5RecF8DnEbUQT2acxX/mv9K8WMFGoXkJj9PP9VJCQdQbY/k3Rhosf?=
 =?us-ascii?Q?NQYRqI0LagVCPwLqiOelU8oyy0wuADyt7rj6XHmRWKJAlHE426h9SewsztYv?=
 =?us-ascii?Q?CQ7q6Bm6kTL3bqrBue3vEOfUbJV5oTPWEVOL+pIYpb1wc1KwRHL4yuVziT2F?=
 =?us-ascii?Q?wJKBJlvWcpXTZgCpDjg/El0AZtHC0QZu/Wpb67uQ4hlfcGE7+w/dPCarq1K/?=
 =?us-ascii?Q?52FNLrchvJaRvBP8gEHNMViyWT4LcWjg2hcRW7vjff5AzXcW+wc7AX6MLs+D?=
 =?us-ascii?Q?8f2jsN1jcVqv/l61XR2EF9PQMU6njSN5M5+O3KAIcYiQagDbdBTXXvPo8bxA?=
 =?us-ascii?Q?5jRcfMIS+aNw8UtDVJmczyGMdn5M6n0/2gWenBDd+DlURwbEdaaRS+R/vyza?=
 =?us-ascii?Q?6BS3BhiINcKQC5LqLg/yT+AiWWQlyMfk3h9IhcPL8yB4ObJpjGsP5mf2d70o?=
 =?us-ascii?Q?2WR5IqofWoEJ3qNgQg6qPe0pNa1GtC+ZcZ8xUOK4+0mJkBJat34NWE7A2JSQ?=
 =?us-ascii?Q?vZDsnbwQKHW0AxUm+t/lVaLCl6xc2stxUsu2Rfrx0R67/TgoID3gFcbTTHzO?=
 =?us-ascii?Q?mhXwxNruhA1gE7XJFKJp/BO2fCAepkKC2TEwCu/3upoF5n88rdPFtuPZNnBV?=
 =?us-ascii?Q?8bpFc6gALYZXGuLkSaJSFAYgjt60keq34rY0tRfxdZ832Sslrqrv/ms9uUnj?=
 =?us-ascii?Q?hn0K9syPJG+3DRFm+grxNM7FnetMDlnYHBvd5ZJAWkDd+95oIsvOzzMg1cO0?=
 =?us-ascii?Q?HJ3Eof8x77hg80RCwqRqHDYiEd0v7DJbVEdJ3UjhL0pqNDyndMqPIOEx+etv?=
 =?us-ascii?Q?jWyo4+Ha0ijSwyxlWrYpSW5KyFCCL9zukDesH/J+3HWZPfLYVd67+UdURBWf?=
 =?us-ascii?Q?a4xt6R+PTfNJd8uuX3ETJxLDIbNEtRv1V74rxk4CNUS+5eQ2jt7QqRK/7aZi?=
 =?us-ascii?Q?VQjt8kOWTRit1Z03wQeSbVkXlTlagTXj5+W2epxrZgf6ouC2aM5vLuvexCRF?=
 =?us-ascii?Q?WDt1eJ0nml6p+9gQexWB0PBbwoW4wcoN/4bL9YLqLeF3a+ih52wyE/buApIM?=
 =?us-ascii?Q?2/8kKZkHWkOcJf679KK5S+JCrWpoqKwJRnlbC+EzkEOJbprg1JJnttB5DNBG?=
 =?us-ascii?Q?TfGX9EkC+xruzrQgN9UKPKXE+XVDBypgCxfgWS+OQd6QyTLGdWFI5yUX74Hl?=
 =?us-ascii?Q?09ERG8H/DK2iZMxwBqE/0Vhazj/Wbc9recWrH8MRTyIZxfRIzdHLkS/jAdPz?=
 =?us-ascii?Q?2F38FWmFfinxSlZpyc8aXsclORfuXluHRtSmjNxSHISuGSes1BiaU0L8lpFh?=
 =?us-ascii?Q?mfMR0EUcQm+BLFra1ZG1XCrNT04ywsIBucYgziQ7ZVciheaqJeBbgIMyU/ku?=
 =?us-ascii?Q?j/lXWQ0wbxE+iVRdteEkx9wKRAe/1rVSm4Z7la6zf7oRWewAfL3/KqR6TlAl?=
 =?us-ascii?Q?4X/vDcyEjJWDYouoUVl00O4oIa/NvK82Na/kv6Tkx02GKCaG4hDfshWR9gto?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438f496f-137b-4f7a-ee92-08dc7f3095ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:09:43.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy1EXaS1oBdQ0TRIBbCmHe4K0PTzaNIS+owHQPG5nFkFz8xRfKq5DSlNlP/3q+A4UUKjSnQcC+atKcLNKw1eFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 16:09:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15973

On 28.05.24 17:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to build generic x86 targets with disk encryption
> and secure boot.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>=20
>  Kconfig                       |  6 +++---
>  doc/README.secureboot.md      | 19 +++++++++++++++++++
>  doc/README.tpm2.encryption.md | 12 ++++++++++++
>  3 files changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index 334b5c6..364a84e 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -190,7 +190,7 @@ endchoice
> =20
>  config IMAGE_SECURE_BOOT
>  	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM ||=
 TARGET_X86_UEFI
> =20
>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	string
> @@ -203,13 +203,13 @@ config KAS_INCLUDE_DELTA_UPDATE
> =20
>  config IMAGE_DATA_ENCRYPTION
>  	bool "Encrypt data partitions on first boot"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM ||=
 TARGET_X86_UEFI
>  	help
>  	  This enables LUKS encryption for the partitions /var and /home.
> =20
>  config IMAGE_FULL_ENCRYPTION
>  	bool "Encrypt rootfs and data partitions"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM ||=
 TARGET_X86_UEFI
>  	select IMAGE_DATA_ENCRYPTION
>  	help
>  	  This enables LUKS encryption for all non-boot partitions on first boo=
t.
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index e93266d..13e4512 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -290,3 +290,22 @@ sda              8:0    0     6G  0 disk
>  =E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
>  =E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>  ```
> +
> +## Secure boot on Generic UEFI x86
> +
> +Secureboot for a generic UEFI x86 target works similar to the QEMU targe=
t,
> +except the enrollment of the secure boot keys.
> +
> +### Secure boot key enrollment
> +
> +> :exclamation:**IMPORTANT** This document is not for generating a Machi=
ne Owner Key(MOK).
> +
> +> :exclamation:**IMPORTANT** Enrollment of secure boot keys must occur
> +> in a secure environment.
> +
> +The following keys need to be enrolled onto the device:
> + - The Platform Key (PK)
> + - The Key Exchange Key (KEK)
> + - Allowed Signatures Database
> +
> +The enrollment must occur according to the manual of the UEFI Firmware.
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.m=
d
> index 7dc97c0..3f7e89f 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -82,3 +82,15 @@ if [ -n "$keyslot" ]; then
>    systemd-cryptenroll --tpm2-device=3D"$tpm_device" --tpm2-pcrs=3D7 "$de=
vice"
>  fi
>  ```
> +# TPM2 based encryption on generic x86
> +
> +For a generic x86 platform with TPM2  module the build can be started wi=
th:
> +
> +```bash
> +kas-container menu
> +```
> +
> +The TPM2 module should support:
> + - a sha256 pcr bar with the ecc algorithm.
> +
> +If only a sha1 pcr bar is avaiable the variable `CRYPT_HASH_TYPE` needs =
to be set to `sha1`.

Heads-up to security WG as well: this should also work on M-COM, at
least with 5.10 kernel (hope we sort out the remaining issue on 6.1 soon).

Jan

--=20
Siemens AG, Technology
Linux Expert Center


