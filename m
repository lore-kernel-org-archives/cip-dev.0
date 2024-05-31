Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF75C25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 06:19:33 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.67])
 by mx.groups.io with SMTP id smtpd.web11.5281.1717136362761866393
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 23:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GjE6M2hM;
 spf=pass (domain: siemens.com, ip: 40.107.241.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV41zuf847wwou1LBoavGP4V1LwA0iPcosKf04S+H07jpD+OCaGYzqRB4Q0Tn8MWTO46unats6gUa+oWNt9dtuX76ts4Ma09CIh9hRtKXY+X2KORpkrNZNiFxUzPaNqhI6hRLFmLoSoiJylPpOQ6/QAivbtEZ5jVruFrDWVJK0cCdChXZZBR5IzLpCvZs4gfH1R7K1CAoguGVS1dS3z5n+ZhBkZyKKifb1Rp5koN+72pT9H5+ltsQDngEIhHPMDTFR5/i6Bwdyd+ej5AchXhIoh8McH3Gago1Jg6WTeAJ6zpidVmvA70lqFGNDfY2YSz97h+hNEvZM41w2VCpgCbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTwEhV6WdLLKXdU6gxO84MrrdVzw2LSvdOUTGDugXFM=;
 b=mTI+j9XLYjz6Q6/b47XRhy4Q9VpNkJvD2gzV/oqdxBG+Y38/O1uTrmC7/Zfrsmq5NM4yj+1vZLDd/jCKenHW5OAIK/uJNjEGBHHKgO7x8gRKsqatWwFT8w/ktKzMZQZQ7Ia5775/MqMkSebuJj+fUatyUWNjL5gQ0yQrUIbNb2WqLEOjXaksydIprkv+Q3aEL7T0SIF6jwu6jPOrRjHVMw2hETFq/hnJSmsHxiaihudwCVwZ8Wti5Mo5FpyUqp34wRj2CKgTqQLu9xKwaq23KPmJIQ35nabVLXuaUUheteVPgYUr6z0g3RfTbCTpfZWS3Os0uzhnQcYgunLr9c3cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTwEhV6WdLLKXdU6gxO84MrrdVzw2LSvdOUTGDugXFM=;
 b=GjE6M2hMmQzZwBfMAqyfbEdYTfWBvxU02q2gprdahRhqZYugdUixp1vZynXgQE2cc4MFHj1AxBJqOv79p1a6kEmRJTTDKmDmG/cadYrG1bVdw5TnfH/liE89aUqpb1znwWcJkk6rgFCMcoyAakbILpT6KxwXWI8E86PgpcIdy3srKGDtc9JlqBCE2K7zhL2C74qJbYpsvkeMdez7FWSRPaCffTJW3fwz/qXhrFm+BwdC+H56jqzvoQwLoND+08ZyLfZidyVUgqTvUcDUNlKolSkgQYpJ5euakJi/8bS5gT7rewRhtCMUYGegxrtenTAlQVlTPYiaiyW9LJ6XbSG+cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 06:19:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:19:19 +0000
Message-ID: <711de341-e2d0-46a3-a814-39f50276fa3e@siemens.com>
Date: Fri, 31 May 2024 08:19:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Enable secureboot and tpm2
 encryption for generic x86
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, cip-security@lists.cip-project.org,
 schilling.benjamin@siemens.com, dinesh.kumar@toshiba-tsip.com
References: <20240529080954.1080468-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240529080954.1080468-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3895:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c0fe91-02ab-48d8-e28c-08dc81399ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?umF01fGC03JFe4d7egQ+iMOvoB7ebcAYdwRnIxLaqmUujQj3x9sxHxOK79/C?=
 =?us-ascii?Q?mqK53U2yNqxZqOWX3FrO4Z6b8ERJHAX33OySoZB9T72bwmThf8rHo05aFYcN?=
 =?us-ascii?Q?OGXD+lUHR69S77cB9jHINfIQLLy+bFtBxNRJM3q/J0DtrnuUNGpsVlAMyRSV?=
 =?us-ascii?Q?bqni13FoC+Eb87RNkzyl8EsXagEAk3EEoYxTX1nL3yI2ZtNmxdHixwdwxY97?=
 =?us-ascii?Q?LCee8OwnxLcNrssVyyp8YrbvzeD3+BGWSN2ipdNR5Zk+BnGzZs5zJGsBzBvJ?=
 =?us-ascii?Q?4BElXu1FfDLpzCSIqHq0+IYYZelQm/q9n7Mban2yKL60jeklcaUupyXa6ems?=
 =?us-ascii?Q?zDuols8qt+Y57MG1PykZ7b33SejG2nW5In4ZYiCr6zp2yImBzALvPdlvr6hQ?=
 =?us-ascii?Q?H6SvffL/BmzPl+oFuCTy5CLy6nKIj3hFzT+mMIJFN32eWC5/v/RoYrEmr/uA?=
 =?us-ascii?Q?NBl0zolHuEORdiyPstQ5C8TkKaS23psFgkZzqLBVU8dH1M+U75tkn6rk+dTQ?=
 =?us-ascii?Q?Tc3FPIUK84zq9Qx5C8uqIKdknuNZjgP8WJxfuQYnVi7xtcRFuFmcmBE3GW39?=
 =?us-ascii?Q?NQ7EYMHyrRqu2fL3S/dRrYCXMbdtCvOrI7iQIPkRr4uQodnCydMFN+cbHNmS?=
 =?us-ascii?Q?ymW9ZNIOW9jCQ4NfIyNTs/Af5+DEnPagmVqOgVT/fevj9SFLAIW5FK15MFnL?=
 =?us-ascii?Q?wtiLqGTxnlikxlQQJsP+VNnUFzQkeLi7CkmRkj0VzeIUZZtGal5ghl39OHBh?=
 =?us-ascii?Q?1GsPEjWWPfCYdR+1Ea8ppx+494mRtGn8ebs52J9uEnVEkg35QxvfA36ZxEVr?=
 =?us-ascii?Q?DDFkfzfodo/8XZUDU/bA1bFTVe4gNNTD20bjDDvLGEmXDZYzf1SIZKpuKqMA?=
 =?us-ascii?Q?ha7wH/IsUWpSoHeu2e2/8ujgs8CFSXHTB9WsTxuoFFxoK3dJo1wMg83MScbU?=
 =?us-ascii?Q?P6q2EoV807obl2HhaKGJsf+gA20hRXSlZ6t66IUsSeDJGBJrk4oYrm0ABtjR?=
 =?us-ascii?Q?AJdOoUSMHlQp0NEikpz8JJ+keoAo8xUiC97c4sRhy5aAFmpE1MZ7xYWU2Bqb?=
 =?us-ascii?Q?yQzHofamKcsZhLlLZ2iBjBZbWHfAWK9DOSyUjVdeIWa+UEYUHqiv2xtsD/tm?=
 =?us-ascii?Q?BPYxHt5DNXOyUrSdZkyUpGvT75VHmNBMpGe03U7M3KQ98cR1M9UX8oFXqKU5?=
 =?us-ascii?Q?737GgNk6NHOkEEgMKAYUZO4zhKqPtGxtohl7ozBQZ/QPcb/RsUlLoIE4Axw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?asH+pO9Ovoy52eNbBvvWdPMyY+oI5G/WdgO8OYQH4Cyz/Tbj+FfMaK0FGReP?=
 =?us-ascii?Q?kdnzLGfKyjyU9I4joDkryJUcBFXWHdcXQyMFIXnZI5iOH3ufYLLiy67WJQX4?=
 =?us-ascii?Q?ivC65cSl5NuC1thIjPznyIz2hW/zzTpPPf4qaRDjKXdaFLdeuCTOUtBaDt2j?=
 =?us-ascii?Q?bLCS78s9nxjj++XJvyCKl+w0vq8ZU9Ea2wnYo1odi/ey9ePjvc6sTo7xXIUq?=
 =?us-ascii?Q?rGMJ8oI2/ikTcsvmkKwbvnprZIIf+GD/cR7/CDNTwwAhs8ZzA14X5UennZLW?=
 =?us-ascii?Q?Gr1AobCHRSK9Se6aHPz9I9bqipat45uEFRWgDC8NcKRlr502q4sTOXkW9zYu?=
 =?us-ascii?Q?bv3MIMJmlMIqLtDlYkJuP2SswIGLEMHa4hZUtw+eSQWGPXP8PkPLK8tAEhjb?=
 =?us-ascii?Q?kpqScTKlmhp8ur806QiOmwcDmf9BHzWVv9bgW+hF7NgSocAfWVO0qZ2+118l?=
 =?us-ascii?Q?Dzdp0LCzIusiWzqtJiXb5hAZcY/+5z4ib6cQlv4tP5JKYL6OcvEcfTbk8R5J?=
 =?us-ascii?Q?CpjZFgBb7QMoSnU+/VntYRnKBTPTYxMux1Qy+hapbxs6y/M/X2CfnGJOdXyh?=
 =?us-ascii?Q?fF9r53g+DVcE8tKehIuLZy1OncIQE86GeHgoAmYZXBQj/Rt7OKu7FdbjPgvG?=
 =?us-ascii?Q?mAbYyJcI2y2gy68UW/mrXr/f6qe1B6t4J56hMzUZK+6puGpUq2JQSvVbrUl/?=
 =?us-ascii?Q?o7DXTgcRfdW3MSH+CfjLfir0XZOrlgmKWSmFDYoGO9jre5ez3pTWnLaCEEjz?=
 =?us-ascii?Q?5BHP/qNEY1+wVD/mAaDdxe52gxRqBD5IXO919+I/ilHc6qs8PJpTT2AuR94Q?=
 =?us-ascii?Q?c9SPLUDV1luwN04En6ka/kgFDmXjPdDNUncPcMuxArR3+5Yk3esE6MUFxQ+i?=
 =?us-ascii?Q?32EZFjgQ1H8uvnYg0ZKAqLOyOaPlZM/JJV3It6EMa7Wj+/LgIkdGfc9j02RK?=
 =?us-ascii?Q?iz8FqN9UGdUOI2FEnzdPxZN9oD009qPdtaCTqMeY7+XGKPe5qr9JO4rDOVbP?=
 =?us-ascii?Q?RzUf/ZqLB099C26U2604evkj1iBS5+qZIPwGUOgDzGLMyufxqQLdWwdU358O?=
 =?us-ascii?Q?PC2PwLXQ35bDKwaSbKSidYqrG3Vy25r9Tj1WsuhOJopRxJhn73qSNPp3Wjwi?=
 =?us-ascii?Q?JajU+EPkrqvJ2idenN57jCEbMih4onF9emGo3i4pbkWaJFHF+NN7lob+NIpR?=
 =?us-ascii?Q?Kv8YQFKLSxWqUgNIvX/7/FDEZTIh9nlqOpqIW8PemSZSZ0I1VsIXVjF7vxFf?=
 =?us-ascii?Q?388hvyYlHpIiFtWzAR93VziulPc1RNSEJl70ohDPyuYaDBWgN2CIho0HlF/g?=
 =?us-ascii?Q?jrAU3EbPgv8ia6eCvqCDudSakUlOjdMSCNI132otdYJ5FUr4wgmWr00TZYU4?=
 =?us-ascii?Q?b/GcXELu/yW3ZqqIAgW3LerF5L6e1wh2xsky2MrcedgQNVC5YlewwfhuhlXO?=
 =?us-ascii?Q?j/W3gxXt4iiHrdsZQcHwChDH/sV3PjviCIJhdTO+QFhE+RVGroNJj4AHq2HW?=
 =?us-ascii?Q?8c3+XDW6D44wfZo5eMIYLmW56AXHr/foA71JSrcpoZq81dv2yxtap/Z57Shi?=
 =?us-ascii?Q?JQKQdr5txEcC4nHBC3mXwc2347e3ezfBWznDSuRi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c0fe91-02ab-48d8-e28c-08dc81399ae0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:19:19.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRYx6BmZ+GioNJi82Wh1qo4o3iNootiO0DWuGugoZ5309n2QeigELfEt1nVWlQw5tWpeDY7HS6jA4Alf+kQdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3895
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 May 2024 06:19:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16073

On 29.05.24 10:08, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to build generic x86 targets with disk encryption
> and secure boot.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - add section about ebg-secure-boot-signer
>=20
>  Kconfig                       |  6 +++---
>  doc/README.secureboot.md      | 30 ++++++++++++++++++++++++++++++
>  doc/README.tpm2.encryption.md | 12 ++++++++++++
>  3 files changed, 45 insertions(+), 3 deletions(-)
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
> index e93266d..f0c46ca 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -290,3 +290,33 @@ sda              8:0    0     6G  0 disk
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
> +

There is actually a standardized way, see
https://manpages.org/efi-updatevar.

Jan

> +Use the recipes [secure-boot-key](###secure-boot-key) to provided the ke=
ys
> +to the signing script contained in
> +[ebg-secure-boot-signer](###ebg-secure-boot-signer).
> +
> +### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/e=
bg-secure-boot-signer_0.2.bb)
> +
> +During building a efibootguard based wic image the scripts contained in
> +the recipe ebg-secure-boot-signer can be used to sign the bootloader and
> +unified kernel image(UKI). If the keys are stored in a HSM the script ca=
n
> +be exchanged to sign the artifacts in a more secure way.
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

--=20
Siemens AG, Technology
Linux Expert Center


