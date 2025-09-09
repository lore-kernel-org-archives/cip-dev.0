Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1871CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 10:13:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.48])
 by mx.groups.io with SMTP id smtpd.web10.9615.1757412776637081987
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Sep 2025 03:12:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WN28159F;
 spf=pass (domain: siemens.com, ip: 40.107.130.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6JxoAtWFPpDHm29j0HM0r7DBFk10T2J0nCgHgqqoxZa+lf2I6QlH0kmXarKPlT0jQx4EDAMrwacCwWbA9f1yc5FJRNvYUcqiPlCAYrMAuExH/wo/vhgdFUjXkXJfiSUB486AD6p0FA+DcaQvk55G0OLDS6RB0sUL0wX6qw9qwwJ9faQ+DOqTchQEGeZ/7TCbODVtGcWKDJnpx5PDZSOA2bMSMTBrL7fj7+7DJ9Tu5P0k7ETZptxA9mTPhZdwgr/8y+2GR7moeBka3jnMFwOzjdPSxuo3WiG4XJpRYQ9K7k+Yl7TOKirqKg7FAWT49rLY3dTVMUeibACI6Ui2P/9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8nt38O+OBXA3XmWZXC6VTedAq+OsVf073GqV6ZGTpw=;
 b=uXBvTRHpaYcNhouB87GUe/2936GSYt0AFI31MQ7iJ3Mkfu71+iRMCqa0pgGXhnXsafD3ds1lPGFqSuyZ9FjYEPtobumELzVz+Bc4/cFfqMvvDHY8gfmw+pUShwRcltNe/ZWZvp4IZ0rxmPvU2Zxh3ThpUvMZ/Dacu9wo1kXf2IPApjqZeENOZxd0OYaBDDI+scwZZwKIe8JeZvas1aXCLHAv7mVX6GQ3sPYOJI1w9JlYsbvnpcea/NtzcI9gxwifOpXo/lIwOfcdQvfhxHQEc8alSsahbxAV/fLNcUoDd6GYfCi3ghtBnsyD05dNrysqBHqEeQwLF7XGM47YBa5T+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8nt38O+OBXA3XmWZXC6VTedAq+OsVf073GqV6ZGTpw=;
 b=WN28159FMFNIdPwuGqD3tPvI0un6qovp4Etzh0z1OThAjnvYyVgWNzb7FkxUBJn7TfBW7el4RTbUHlEFLIKgzgX2t7lPoU6MclQ3asCJjSPj6xHES1Qa3sYez36WeAIzrw0WRujOKg0TiB/tOMOA3DXjmnxuYYyRBISiJo4Rb/U3AEmTXNGyO9jMWURk+tykbd0gic0u4arHDgboaNx2X/OwiwbnGfgezrwkYULF/lQrL8nSLQ1zyopoEVx4gzg8Tnowo+0sMIh7OtCjSi2ZjpjppGfu3gWkPNW1rA41e4Q1a76ew88hph5viykW1WVggNAuOx1ocB28uZGhm/s++A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:12:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:12:43 +0000
Message-ID: <c271caac-1b1f-4992-845c-51cd1224d125@siemens.com>
Date: Tue, 9 Sep 2025 12:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5Bisar-cip-core=5D=5BPATCH=5D_initramfs-crypt-hook?=
 =?UTF-8?Q?=3A_add_tpm=5Ftis=5Fspi_module_=C3=82_support?=
To: david.kauschke.ext@zeiss.com, cip-dev@lists.cip-project.org
References: <UQTq.1757403895402017236.iyck@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <UQTq.1757403895402017236.iyck@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:610:b3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 677cdc0c-ed6a-4957-a0ae-08ddef896a6e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b2XApdefd5UNMZPFQ9y29FeB5XHqQniG95E8exOHZdmKq7Qh2/rJUAyRuWka?=
 =?us-ascii?Q?4nHsitX1YjYPSZY1NfLunyl1GbTYqTvFHll8ktyCIPx733u/VVZdPdG0fpTm?=
 =?us-ascii?Q?DBlmXHfCOAUv/PPlDWo8U64cFUNfgi3lsPUabvIVZElOEJycHAA9o8ikq7+g?=
 =?us-ascii?Q?wNzpjdiC3cNWSyN2v903bUJEdPVGjRGMIQZcCYYh05m2sfHXZCfJEU2XKoAH?=
 =?us-ascii?Q?ih1D5PA4OsG1ZG7RUIW8OOt2ZH8TLCnMZrdQhgLzHzwT0H9dIuyWuQX33YQc?=
 =?us-ascii?Q?/No6uItBxk+byrYaEYRJmDApbJvT6UXnCuqKO/LaGwxoYGuVjQbHPZcC61Aa?=
 =?us-ascii?Q?45kYA3toXyG2w7Wuv19IrgVSdZU29jP4VWl8p+iMXPEbbXz2BZkcIpqbMGJE?=
 =?us-ascii?Q?OObJCMphESrtuLCn/4tfy+zbrwTvmUVRZLA8BeKTtS3/+vy9brWAnmrgYYkO?=
 =?us-ascii?Q?aLFFDSGt5qV89Pl2DjNCouvbT49X2TkZcUrY3VPF49ysZ3r77qI3gV50u0AO?=
 =?us-ascii?Q?B94DNg6l0kexpzGnctxxR3WPeSxJCjS2LPcgF0QGXcPAdkNrPbiLakOKMmEs?=
 =?us-ascii?Q?xIn0KNQP22Ek6VB0UzVx6ge0s4cZYBH+3v/suxR7BZl9d1o0f87U8+PlUNQW?=
 =?us-ascii?Q?SazXeRWtS5bIc4w910BO35aBAM0tCPvI4d7OyvUGqgS66vUNOzYpieyIGUS8?=
 =?us-ascii?Q?2Te3AyB5rRTHbitlrI73TsgW4N4DlVicLKHORy+XAx0spE/WWxbQ3EvFpe9O?=
 =?us-ascii?Q?zP0U/orhOPgecobvavbOQFcRzvaTTAikXPUTAxeU9xGg50beYc3h7mLoLlbF?=
 =?us-ascii?Q?phF2wEERvauu9NcL9B0Dzxn5Zylh20JUPOVG63UfG25pExUb2mXNZRay3RdA?=
 =?us-ascii?Q?zGOT9AbzDHXLV51Ybt2mHb5vS3Stzc9fdqjEdnuKMZ28wi6Y0Q2FZWzijSj/?=
 =?us-ascii?Q?l3gpOx0uhz9Dwb6txF65EW3rmmc9pkHWVW8yj1niS4A8tOIxMdbICZwpIVlt?=
 =?us-ascii?Q?xTNdNjqXK6Dbh1c7o6c9pD3rw2oqQuClnZ1YhhtxEYQWwS8Dp2kRmlaS0VeQ?=
 =?us-ascii?Q?7mUawpf+1k1mR1H69tNJwToWM3gJjpQxFMjOt9+hPUmAfAkMPLc88mSvbgNS?=
 =?us-ascii?Q?OA0ggaKPhZI7EDGr0JfDMsToGfKEWe6iZTS4ALnBi/da2x9nxJtjeHXYqeVq?=
 =?us-ascii?Q?JRQDb3YhdaMmZH5sTTnx5xfFFdwKheOnhVuqYM4andDKAVcIWHyoO0mgaz+J?=
 =?us-ascii?Q?Tmc7LgkoT+1chHm8L/4s8k5+cSAdLbtDAv5j8MVydqJ+bY6u4fY9xyrphyeW?=
 =?us-ascii?Q?8remE4tzhhSTSFk30OGa884Vehfbz9gAq35IjayvHx5+XFMtdx9dY5SYrvJ8?=
 =?us-ascii?Q?3Wf8ldQ8jc0qKthn/3FzjFtN7Wn+9zyvH7uSOBCiSnUqxqQb6D59vLZV8u8K?=
 =?us-ascii?Q?z+5jP1gdMIM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9fEUl+8OgClFbZ5Lp90YlGCijcIGaUOLHuAK2PuaV0HFxM5LWh4fvyZ9cAAf?=
 =?us-ascii?Q?aUfjya2Gnzn+58SZyWPwiAkCum6zJAPgomuo8QNSv+Yg7XvaK0yaAN0PF6iW?=
 =?us-ascii?Q?84TZ4dwQhQwOE60RiPkZq+64pKzsaskaLimWwp+W6ONKj+wB7HrDlpRkDvZZ?=
 =?us-ascii?Q?AN83Kzsu9WMp9ojy2Bucx2lSRFlXrU63XN8TRMwDIlH6NrToDlUe6lBMadXt?=
 =?us-ascii?Q?v+q0Fzl3gGeI5m+0HLyKwu2WsP1EjUXBjIgsZ1V2TdbR7yd1f+xRYtCwCYY1?=
 =?us-ascii?Q?vsElXEIV2fN3thDbeF/Fy+OBqw4sYuWyIxJxOE4s1mKI8RKnpq/4PG4IKOIn?=
 =?us-ascii?Q?ctvTYVQcoype7ztfZtkZn7y5rqnAG6hcHHyAvCvwaShUc9n46Va4eW+6JjOn?=
 =?us-ascii?Q?KVftJHnHG8gsZQrJPpUKRlEi/EwuZZAVJbb369zBspdHWJmzkZ+szKklTUvH?=
 =?us-ascii?Q?JjBoh71DoN9thSgILAo2DCta/RgxFmEmgBnA7QGwOdPNAZduSTjJttP4LobI?=
 =?us-ascii?Q?KYEtTrZNqk3L0UUNAOgZst+V6VPjiajj/A+9l/9n22/yo/0elGXygHwK/TdU?=
 =?us-ascii?Q?CulQ6xJJx6uT094pGg1DSB4nF07hWBa+M1AZF1o4mDzrxvZV5Za1ujv6RkbE?=
 =?us-ascii?Q?DfDcFDpbnf9tRg49LLz+S0jDCi5EpLT+BFm/WXRnKlyNdcUaJMNdA1yRiQfb?=
 =?us-ascii?Q?66nQcp5aCn3KwlVsvbz/MWt+s1PWR1YNf6VwT2xF6Ot3W5sGApwMEK6pi0GC?=
 =?us-ascii?Q?7lWqLprVWXSjmI25k9eyGczqwEIZDtXaJl8K38AH4JCKeuXzamklAKMisykq?=
 =?us-ascii?Q?I5K5mUtYQ8AHumToPqfKMC9amZ4b/gvA512BtSgC95F97nt7C/2QzIHWOXi/?=
 =?us-ascii?Q?g6urj/jzAI2HdHaevFZvCMTeRgntdZqoB4hrXbkGa6jAdaLDGIOxRHCaFyiZ?=
 =?us-ascii?Q?hUBfhDs6qrBw/tHz7FT2raLXsw8V1MGq9Cwk4Qoim1MDb/LoyjVK6BsI7Zfh?=
 =?us-ascii?Q?MTl1px2tf+AspOi/wGkAj7CLOAX95Gu09Q73T9cd/QcPl1YV7qyQHK5Yw3Wu?=
 =?us-ascii?Q?Xkkd7LWQpGvjorxpVJZdaVMui3kpCJMckwMw5+OAPH2E1cJniP71Owv+YCJZ?=
 =?us-ascii?Q?rDPMaDnb0spoFqwdeYPEkNie5wMzcuwe4QWsQEnwfVvliONRWS+DUe/wrlcA?=
 =?us-ascii?Q?gHvxWLcXzKAAKNrqO3joCidnIovxlrpED/9zvPyx92F+I0sFviUT4C+vjLyQ?=
 =?us-ascii?Q?8VWqkdKxtQrd03rL7HpXMRmHCM0Itt1Has/olCf9f2GtCkI5+zMgv2V4+Q9b?=
 =?us-ascii?Q?CcC1YX+b/bYkUTfPT2R/V2/Nghc4MFI8UDktY+pp5t+vQfqSKI07yR1ZGMr7?=
 =?us-ascii?Q?7JCajSmTrcCPJl8FRCpFxda8kgGpq0cLpz0CqWvJ10ky1bKHKXH2TeI/CdjZ?=
 =?us-ascii?Q?mZ+VozVYIMUPVb1ilnTmFpoq+PC7yFmwoiVcOzj5NGvMczybY/xSeN4aDL/i?=
 =?us-ascii?Q?qgIciX7ssMbrBXRyi4KTH9MAyNtw7IJsZjSzKf75KVTUExNQlbv1XMHplJBP?=
 =?us-ascii?Q?9axGsqwCBUXsooxIL6zpIB4K/i79pdifESfragY3UI0ZunWwQjNExFER/rzD?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677cdc0c-ed6a-4957-a0ae-08ddef896a6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:12:43.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O9nzr23cW8TyDMgC+pZ8e+Jol48BfX0aMjAOesDH9J8d2I2RMftSd51qkA09BTVtvGz++vCuR126nyNmt4qIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 10:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20026

On 09.09.25 09:44, david.kauschke.ext@zeiss.com wrote:
> Hello Jan, hello Quirin,
> =C2=A0
> this patch provides TPM SPI support in the initramfs.
> =C2=A0

The patch was mangled and was not sent stand-alone. Could you use "git
sendemail" instead?

> Best regards,
> David
> =C2=A0
> =C2=A0
> From ae2d177c83ad9384b287e7cd9b6de3fa5c637ef3 Mon Sep 17 00:00:00 2001
> From: David Kauschke <david.kauschke.ext@zeiss.com>
> Date: Tue, 9 Sep 2025 07:07:43 +0000
> Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: add tpm_tis_spi mod=
ule
> =C2=A0support
> The initramfs crypt hook currently loads tpm_tis and tpm_crb but not
> tpm_tis_spi. On systems where TPM is connected over SPI, such as with
> the Infineon OPTIGA TPM SLB 9672, the absence of this module prevents
> TPM initialization during early boot.
> Signed-off-by: David Kauschke <david.kauschke.ext@zeiss.com>
> ---
> =C2=A0recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 1=
 +
> =C2=A0.../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e
> index 0d42bd4..664124d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -42,6 +42,7 @@ esac
> =C2=A0
> =C2=A0# load necessary kernel modules:
> =C2=A0modprobe tpm_tis
> +modprobe tpm_tis_spi
> =C2=A0modprobe tpm_crb

All these make me wonder why auto-probing is not working here. Do we
know why?

> =C2=A0
> =C2=A0modprobe ecb
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
> hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
> hook_0.9.bb
> index e2d55f9..e107575 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
> @@ -39,7 +39,7 @@ DEBIAN_DEPENDS:append:systemd:trixie =3D ", systemd-
> cryptsetup"
> =C2=A0DEBIAN_DEPENDS:append:systemd =3D ", systemd (>=3D 251)"
> =C2=A0
> =C2=A0HOOK_ADD_MODULES =3D " \
> - =C2=A0 =C2=A0tpm tpm_tis_core tpm_tis tpm_crb dm_mod dm_crypt \
> + =C2=A0 =C2=A0tpm tpm_tis_core tpm_tis tpm_tis_spi tpm_crb dm_mod dm_cry=
pt \
> =C2=A0 =C2=A0 =C2=A0ecb aes_generic xts"
> =C2=A0
> =C2=A0HOOK_COPY_EXECS =3D " \
> --=C2=A0
> 2.43.0
> =C2=A0

Leaving that generic question aside, the change looks good.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

