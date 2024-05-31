Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899EBC25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 06:33:33 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web11.5426.1717137206542798720
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 23:33:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dN9boK0i;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbQZPrhmVCVjYBoyOMIzFJOK+PguVBi3PHPLxCTI4qbp5hQRP5nXd6gaygxhSw5/VsLDigFaxPqYF9F1m9ZVybow2kcNow4RvejzIYPOYTipLF150toAHiAkECqVgADzTa396uNkS7qjr+DjavhLOcDQqrHEnp3zpqn8MPbhtqi7xrEddSf4W+X8Jh6NPtR9OeCR2c2uVaDHb+FrOLx+npA8sNcvSH+on3ak34KNu6ldbwg3FTSCLENKFLg0xdh57Q+YGPlUj1LEhBlbMDB3Svkx+OpYy2R9CA0lqtW2aqPpAIoDBMNEQAEe1Ie5daSAGiC+H0VhVomiLn00JyNWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHPPO9HbHVYkel6DzIYYa+AGJ+76zuu7xJYXaJ2cf+c=;
 b=TXmB/idAe70KtuMof1x4AX6Sj5qWMQZC4i5ybHj4cL4XVLx+xdc04bxleUfEvW/1ZYDYFNN3FZ3meoTEwrGmYLjDtw74NfhmTB5KaAYcG5o1ZAQ52+PA2PweNy9zNFb/7nd7Kx0TJARdvYogP4YinXuaV3Hslvz14sKmQ5Cl94y5EIAJjpB1eOtMnSgFrdXHKVLyfTRQ8N1Ygmwd+pbW76cqPiZdAy7SBWjHdq6U3d4CRVczXLZoYD3z0nq29eTSTfiWreGbCrsj2RLezbuUOL5oTEFUIlmQ2wEs1LPhHP0osEyQJrfgoYK9g3T6VZCegw0NqEpf0MxrTj0pGGCj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHPPO9HbHVYkel6DzIYYa+AGJ+76zuu7xJYXaJ2cf+c=;
 b=dN9boK0ikTaMsNj8YTt8by2H0p5ALW1j3GIvgl1op/N3WMQyOAmUj/MRUJt2NN1RgB1veicGhAWzCIM5wRJrr/RpRz7OiJT/FHtW/fD8mjotFeKE4rruc9SymO6jBrgPlci9Vnsq0QvYDeWpasjnhjHYFFT2DHUd39I2gxFg5v8QAuuSiNudU9dnJoRFZ+V/1gRM5aI5MSDyDwYI9hgqzPGI1xdy9ei9PDK5XKZIP1Y6HaWJEXjYMYaoH69phquJY/h5E8ZYZStXsBNsB+LoJxRDdp31UxCbMMHyPRyjNGrFOz4Jv1+CTiFLGHdXfp97Wzb4+EXbtMUNwf9IKXOHLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:33:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:33:22 +0000
Message-ID: <06ab7353-552a-49bc-9620-124691cdc65c@siemens.com>
Date: Fri, 31 May 2024 08:33:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-security] [cip-dev][isar-cip-core][PATCH v2] Enable
 secureboot and tpm2 encryption for generic x86
To: cip-security@lists.cip-project.org,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, schilling.benjamin@siemens.com,
 dinesh.kumar@toshiba-tsip.com
References: <20240529080954.1080468-1-Quirin.Gylstorff@siemens.com>
 <17D47E6CD4B3040A.21428@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <17D47E6CD4B3040A.21428@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1264931a-8995-48af-a1f0-08dc813b918d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X90vwqHRA/kaRxlOIVN8LqUbAEgQU3Hygc3ly6jHQNf8u27CxYMRWrvd5b1e?=
 =?us-ascii?Q?GSe5L7zFfCKywNQhreYN6HvdZFHu931nvAhRl9LO2q1DW8c4odXCAw40w/XM?=
 =?us-ascii?Q?KpiPFjuWuVGMaV/45yh/ly3oND77PBTPIGSoORsZya1WckIu3P22Iv+Dmqmx?=
 =?us-ascii?Q?g3QVYRfCEI3xtfqYpB3MLrCHwLv0/Pkou9AXRV2WZ7aUuNesenQyZgs/YI1q?=
 =?us-ascii?Q?0wq+g+4FSAhMbgEpIkPSowz6/Wrun+6GhFvJW79qpCQeKU/kxXeFAsxwWPg9?=
 =?us-ascii?Q?ea6JWjdJn/qh8VNGrP/Sugvmzy4ddzZAwIBP2oajt8apKnCKIBU5n/ElCfE3?=
 =?us-ascii?Q?GpChkl22ce0JvNPu6MZuMoHGq9JV6vTurg9+KW2ehwMwZyxMOqZQ0ixEYNNx?=
 =?us-ascii?Q?uTwwJf8/59WLU0fgTlFaRf2OZPOuz9QnwSNnwJqrJMsSu4i0KJRVg7rBJ1LC?=
 =?us-ascii?Q?gxGb8/ub1yjbMjX8U0nReXhDOtZBL95XTdIHzr19zOFN1HuHJvG8kE+5Fz64?=
 =?us-ascii?Q?gkwUNAmvLMOSc4DJ62twj6zmbSga4wTJf1Q3OjBRRWbhl39Cd7aunnDL7WXD?=
 =?us-ascii?Q?dQAn/lwhpNRs0C9ofM6965N9pt9zogjBaO944K5E3B8zkqyqfRcHrBW53oZC?=
 =?us-ascii?Q?PbYauN8D/NgQr3eHBekGq8VpPGivkoGGFF6NdR419aeDhp7VapnCB3cmUmkq?=
 =?us-ascii?Q?FxcCyqVES3HCVjYOQhercT5pm0dts+afp1jGFK9R6IDud/kkHN8moDnOaJsq?=
 =?us-ascii?Q?eEX1tyxj0adSZ5reopIsUg8h2Is6zUpwckf79xQ2uCNW2gveGI7M9Ng82Lxv?=
 =?us-ascii?Q?A9xk84eQVAk29jMIbDl/gt3wWojV/HTTqPZJQ/nmqcHFJSF3fNupOgGUOzNn?=
 =?us-ascii?Q?HtMo4V2UxtNoUpF9c82J+FFnaErLdpM0vqLHfyez1zsQkiMHolEECl+6EK76?=
 =?us-ascii?Q?W8UNFaAPe1ArXDEXGc8Hv3TBY8fzzY1YtuPA1+xn4y/uLwikYNSAnkSefI4X?=
 =?us-ascii?Q?oSIHyl5bAhylpkCggo6GLqAwOBiLEwCZd6/u3WAMlgy5RX2i+osU5aLSGPqS?=
 =?us-ascii?Q?mAopMcZ8eEeeflONN1zPlxo3U2eRAhv6PCIvY5f6KADIPU4dZJjbUmnHYdiT?=
 =?us-ascii?Q?3FkUqChm6NNSbyCL4Z8FD75UMMKWHcHi8dyrvuwi4Pa0DYCTc9mnRF21xmZE?=
 =?us-ascii?Q?+Yw+XAO+GQa370Cl0KGK5Xa52L0C2GCyflHniqfW5Zj+0EvdqjfyneOCXf4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ov9kmbgjuWvj+1y3qenI/3ItpdnDYEL/etgCEU7L0+qBRsO5ZI1IDN+PHE/z?=
 =?us-ascii?Q?ilaxP5ru6DMSQISAlQiWhMO0dri2DnsMGA1csaoCvqYLIjDuj2pAUQtBHYX/?=
 =?us-ascii?Q?N0RhFedkoC1Aru/z6QHP1v/Pm7KP8pCtXPbcYQudBt/aE7/qYmcE8SXps8IP?=
 =?us-ascii?Q?wxv6Iw6L6ltMQjRX7IbTTgGHOdFDH04b7zvUq3ClwMX9xK+OgxSHwvVaTui5?=
 =?us-ascii?Q?8P4JDuyK/W8CVlSTa1KBCiSlHkNOx8Y6vW2VPJd5uCm9Upj5/pmMwfVpKjZ6?=
 =?us-ascii?Q?eDVKoIOdoXkDfPLG+CkXdJZ6v67g7F1jE6+v+aV1UplkcU9jiMjKWKVcWW7Z?=
 =?us-ascii?Q?q/jgofvNM9V+/jKT+Et+nW5Dsyp1hVssr1zQqbxhF7fckz/yT5Un3q0e2p7f?=
 =?us-ascii?Q?EcaNbrxCSoi4ubGpQre5djA82TGqaXFH6J4Bp289HNMu936wp/zVN3pf2Qa3?=
 =?us-ascii?Q?M7PcDGU+AvsG8xl0rkzlK6qzpvWPhBJ8SFXmgZzbYulHxRR+cllV3gZKYhmy?=
 =?us-ascii?Q?7PxKe6LuAb1hBzJW8OtQbhLR+0zU1f5I/UmkQadMc+ll3cWfvNzP72X5pL6S?=
 =?us-ascii?Q?yE+oLxZJ+AGbLXyJf3wwVSQ8XNnOmlVLFN/APb3TWw6gYU0Xie/1lZyPfo8u?=
 =?us-ascii?Q?nnbK2jamVXb2mHBlIGT5nQe5nYMlJrwdVH887DLZxiD7ac0yzmo9iQcTiTQL?=
 =?us-ascii?Q?x9cKTwkbUaC7KXvz1zR637fNQd7BQ/BRutg2xDhOnuF22JMXA+40/WRZCNNa?=
 =?us-ascii?Q?vpCswbUHN5tJNBowvEyoSfCi/9wT6wrUojwKjVpdgrz4n1YD57KejSYpFcUY?=
 =?us-ascii?Q?9pTzl6o9f5u7czpqJomPiP5qYkxlPo7/qONrl0FtNSyaILBABIYO6BLMiBHp?=
 =?us-ascii?Q?+aXYpLEWJmjKi/I3iZuBa7uEPNhXL3jpBl0rLA4O9t4Ezq5mfZC1Pw+6PuVp?=
 =?us-ascii?Q?UZ+1VnRE3OTrh/qHblhLsvTB80o5fN9ehg3qj1iLl1+jMYUwuTfOrgcDMS9G?=
 =?us-ascii?Q?2qUHmzvBRRC9NkE7FuoJsMG6Tp3zkeC7Sm0o5ScftKATqkel8M7svprILNA2?=
 =?us-ascii?Q?by5ZwMy6wtXJswzf0K/MTHk8KjmP48RNq45zZdXkLD2hhsRxw36R07SegVsX?=
 =?us-ascii?Q?n9FujFDtcvWkjzsfX/vcnafoxa9rWegPswpuCKYHYtmZsqyoS+0KlS4qvxGv?=
 =?us-ascii?Q?4xJplW8S6rKZdeqijlB8eic7zXrJBhGukqVOgN/tjhuBd7D0MHCK8tVzKEzK?=
 =?us-ascii?Q?uTEJLwyCyA05vojEs84gl/fdeUO9kA/STuUh1McNQA8bpehEQSGzPObouIMo?=
 =?us-ascii?Q?4JDU9P+jyGjKVbTgBsRX/OKiqk7CGtlOPVSGSoEfFA+k2S5CbtzPF35IhI74?=
 =?us-ascii?Q?8GlxXCaAfACEvu84ydq2lUr/8kxu6XwZjbBm6v4GLKNgnMTPYy125oh6AlGm?=
 =?us-ascii?Q?9LNODJslO7NqDDGbp1b4MI4Armc7icsjfM2HnIa/SV2vDdVail32EEgeNLbh?=
 =?us-ascii?Q?ZnENJXJSSyrW4a/J1KkFgEfFiHuz6/TluO3x1MIycBUYQyzNgff9i4Cro2Mx?=
 =?us-ascii?Q?4bau5EawZ9PneMvI/w/A3jYyYHdgIpaOQ0bUjjA5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1264931a-8995-48af-a1f0-08dc813b918d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:33:22.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOqIRh3w64js5V5kFugxFgX4Y/qYZD0EbgW6Om24H9hrVWp8CdiWnGHegOPHzB6DjnBUnnS2TgKf+HuTazM/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 May 2024 06:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16076

On 31.05.24 08:19, Jan Kiszka via lists.cip-project.org wrote:
> On 29.05.24 10:08, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to build generic x86 targets with disk encryption
>> and secure boot.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>  - add section about ebg-secure-boot-signer
>>
>>  Kconfig                       |  6 +++---
>>  doc/README.secureboot.md      | 30 ++++++++++++++++++++++++++++++
>>  doc/README.tpm2.encryption.md | 12 ++++++++++++
>>  3 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 334b5c6..364a84e 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -190,7 +190,7 @@ endchoice
>> =20
>>  config IMAGE_SECURE_BOOT
>>  	bool "Secure boot support"
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM |=
| TARGET_X86_UEFI
>> =20
>>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>>  	string
>> @@ -203,13 +203,13 @@ config KAS_INCLUDE_DELTA_UPDATE
>> =20
>>  config IMAGE_DATA_ENCRYPTION
>>  	bool "Encrypt data partitions on first boot"
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM |=
| TARGET_X86_UEFI
>>  	help
>>  	  This enables LUKS encryption for the partitions /var and /home.
>> =20
>>  config IMAGE_FULL_ENCRYPTION
>>  	bool "Encrypt rootfs and data partitions"
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM |=
| TARGET_X86_UEFI
>>  	select IMAGE_DATA_ENCRYPTION
>>  	help
>>  	  This enables LUKS encryption for all non-boot partitions on first bo=
ot.
>> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
>> index e93266d..f0c46ca 100644
>> --- a/doc/README.secureboot.md
>> +++ b/doc/README.secureboot.md
>> @@ -290,3 +290,33 @@ sda              8:0    0     6G  0 disk
>>  =E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
>>  =E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>>  ```
>> +
>> +## Secure boot on Generic UEFI x86
>> +
>> +Secureboot for a generic UEFI x86 target works similar to the QEMU targ=
et,
>> +except the enrollment of the secure boot keys.
>> +
>> +### Secure boot key enrollment
>> +
>> +> :exclamation:**IMPORTANT** This document is not for generating a Mach=
ine Owner Key(MOK).
>> +
>> +> :exclamation:**IMPORTANT** Enrollment of secure boot keys must occur
>> +> in a secure environment.
>> +
>> +The following keys need to be enrolled onto the device:
>> + - The Platform Key (PK)
>> + - The Key Exchange Key (KEK)
>> + - Allowed Signatures Database
>> +
>> +The enrollment must occur according to the manual of the UEFI Firmware.
>> +
>=20
> There is actually a standardized way, see
> https://manpages.org/efi-updatevar.
>=20

I've tuned that like this while merging:

"The enrollment can typically be achieved with the help of
[efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-updatevar=
.1.en.html)
on the device. Otherwise, consult the manual of the specific UEFI Firmware.=
"

Thanks,
Jan

--=20
Siemens AG, Technology
Linux Expert Center


