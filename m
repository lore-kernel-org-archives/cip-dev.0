Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97287CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 11:05:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14293.1763982330345717659
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 03:05:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=P/VbvqIR;
 spf=pass (domain: siemens.com, ip: 52.101.83.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FybAfJskVwLcfHuqIIm34xJrSdV+ytfhgGl3YwvZhJaAyFfdVWBWWkpUxoWmVKhywfpBJJleVghqaEH0sY58NjisEdhjA9N0NlTncX5jwa+8jiDnBhaofQror3paZaFe5iiuqrXZGpMRFDYXRdc5ikmWZuQqOpNRG2g8yiDN278uowCKbZsNPjTheBaAuwc2Tr//biIBfSDR23sY+t1eeoaVsRqU06/zhoG0A8cS+AHtlEMGOrMo8XEKEArPaNZjvCtbQTUEZGpDl4SyMx37uoUE0IAJCxhSFn/+EuL16/FSQPxk8b43xCnJbS0lw5+uiPnBBCPGasDd3cT66/KQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Azf6xHwLOYOwKcrsDMQtMWY8CacLFmdo4GqJQKnc40=;
 b=cTtQ514UlO2IcsdXa8aNvbrqWx1tjNKP+H12ZPaVrTLSR1c2kWvd9WIm80Ew08NGxZUmIp/ym2tzmCNPWe4xatYZxdAzbk9AqdWLoSjIpQUIy6mif27Pj8ODkyGtbjB841d2a16JvoXHbhCOvvqLpPzHL2bt7hTtL28vs7WS+Z0LVvNJcVCQ0PDG701+XvDfg/gp5t+DBMta9VcnZ9V29Rb+PnYjmuT68Vt88+KzUDv798lPewND7YVQVS4qX2cG4qDbKMm47myI1nQzOcXvVRDSSKjPAR6QV3q3CLNN2aZb5EhwIEFHo8gnaDAoH/1PZrJplpky+URwwF2wQnmmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Azf6xHwLOYOwKcrsDMQtMWY8CacLFmdo4GqJQKnc40=;
 b=P/VbvqIRvWu0Xu3/bkTJbnhZ2V74Tb5W5ppkZ02XL1dGdOwz7IZ4onVVi7cCpn0+6U3oF+a+8726mYktK5t/VlQB9MCnrkt3YToqACRT8ZlB4KmNej2VSgZTChrcKHgUvSHvFJ6jTIpaidtZdc/YgI97DDZxllcoF44k7yeDKyUnbZ0jgmQ+0f3FHqZ5WUZEzycrdITaGhhdHYvt5x+Alii6VGbYcEwd0jL91KDJDZeSc0nRWSW4lt0PYAEOFPh9D81GUo2iWAzRzJRXGjuaCvP4+E4o85KTPklhnKeI9t97fr54MKrZ6foe0KkE5TLREJceujzR3T1y6etJXlIaIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 11:05:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 11:05:26 +0000
Message-ID: <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
Date: Mon, 24 Nov 2025 12:05:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
 <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 348d30de-9b36-4d94-1956-08de2b495f04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iZlXTo4VvYbhKdFJC2LoTaTPSB5xguI2l8A454fa/8MOIxe/psynwO4HUZA5?=
 =?us-ascii?Q?ZW4JPWB5rcoxzPtuON+LWPfl4zxFa3+1ncn7y5xiLeNOqOLCaO+rnuBpFptV?=
 =?us-ascii?Q?6nQJehaa54iQ/KMbmPx4ha+Dft9qHYk0Dc/+ueXwIzVinsCrZOA4VHNFzejW?=
 =?us-ascii?Q?NzqcwrvtPKE3lPDGTXT30Z62JDngK/ZD9C+Z5cPv7EMfJkwCgARlWVBrSM8T?=
 =?us-ascii?Q?u49y0SHB1rc2nvj/FKHV9dSBUPVpUaUxUO/tS428KVKlcs25t6BPu+96XNyA?=
 =?us-ascii?Q?svvN7c1ay82ik36U/eN2XSWxuZxiqVCOuwCIZA1GP9wGjEofKic/gx6XeBBH?=
 =?us-ascii?Q?XyNJmXpX+35gwqDvmizT4HZRAhxFJej9K3bnAVgLIkZa7xqg/dBSQO9qz4RL?=
 =?us-ascii?Q?NjevvYgc/RllThaEshO9f7WTFCVdz+yeWeL411g01P7zZHM59LdJqYfcKj6N?=
 =?us-ascii?Q?2/QLXygHCLnHXDRSc+Anmb7gyoU6WXFG/kRO1+noQQ5oJZKy8XlOpqS6Y2Mp?=
 =?us-ascii?Q?ndHxOHBEgfGEV25vpX+f4l0KwfRwqTzPJXjllmzUJD5DOw/D7R+vFQEwxDaT?=
 =?us-ascii?Q?0LH4Pc0X9TOuxGwZJCUv2eVhlEUsyLYBVa+RugAAxfV/YIMRsAM9Ne2XU6Qa?=
 =?us-ascii?Q?EAUD+S3ioKLWkgtU4UKiI4oTdMArDYy3f8hgYwvw13wd69n0iW2zigX4cred?=
 =?us-ascii?Q?cAMROC/ed2/RUI3KkUeak/51tp9+jOcA+NClySkntGDFAevDOrJPnKRtKU0M?=
 =?us-ascii?Q?nHj/CqWlYAq2tZDY6Zkvo7gv9daiJV78dgSYBIC403BXo4UbElwSpSOfnh07?=
 =?us-ascii?Q?NjU5Efznu3gV2IuHDyxCBFJAb64O6pBCKwZpvduSXRVdXuMI0k3n3W5pVRk7?=
 =?us-ascii?Q?2PQGspQ+GiLoqr3LQOsAA0N5QHU6i3n3XDZpAT8wCOL/xooW1ROj1K500qKz?=
 =?us-ascii?Q?VSnM2XU6UOiDRzKIRwdz1cxbwWQ1n5uSkmGWg0KST5/6cTErWzYpxUZyXR71?=
 =?us-ascii?Q?pDloRlszaHSYKmS/ejd4ZU6qyPFUQkfhL3WFfJCA4XxUxxdEP3s6rpfPKp6L?=
 =?us-ascii?Q?w8KlBS+N7gJI0KLXmzWWCcVxlu9i5Xh1Z//pSKJoPir1SX3SWEocgOwOOlNO?=
 =?us-ascii?Q?WySP4yWkkxKmM/4h5PY7covm6XAuv7F4Jz6C0bNXwN3bc5TIeB6n3kzhiZlS?=
 =?us-ascii?Q?1ML5wnfF7vXhPSFHPoYA7WBKnXy4x3yFTxxiN0moqVRsuoeLib7927Fha2RJ?=
 =?us-ascii?Q?XquyJXrySjHVIuHmXQJJzIPqwC9PK5e5Z5plJmDTpbkJ1Q01DxkvuqZqXXKe?=
 =?us-ascii?Q?vp3fNuEsi9nw1e+zswYWHy4i3k5fqSvFyxlf5HbdOFjcqFJKuzY1H8ePW6xS?=
 =?us-ascii?Q?izZuh6RZjL9QDjBYb+CKxsMPBVqkoJp/snKvg0ceeywoge55iiOmE385d1tg?=
 =?us-ascii?Q?7Yb+K9gEPbKNK6zAWuPd7lgard5ftd6m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SRtTcO6lhA9EuLTQ/3LmtjXFc4f+QnGsxuIBFxpZimfW5k+Ir68kx0wEcRBn?=
 =?us-ascii?Q?Adl0eZDJuy2Q7wz3N0GJnjn57ttFj0chqQ0PVRh1R6Ilmv+DNIge9rDe9cZy?=
 =?us-ascii?Q?YnBdMpn5RGj3oPgoWXmW1ihUcGjG6DN/kSsSs9SOKr44ZrjYC38wjCMPl4UA?=
 =?us-ascii?Q?FkAg1zfmGd39FQHJXp7Jdq8jbzw9nxOslukJzX54cApSTUk2dseqlaJQqEcJ?=
 =?us-ascii?Q?6tt6JBd0hDX5GRWbjUGin8pp4mOM5serhQ6Cf7LgAJcpAKYguE1A4RACUSUS?=
 =?us-ascii?Q?HXYcfYtWpu/8dWSEfGgUEdz8MWOnhz4XZD5eqKexBatpx00H0MXemXP5+U74?=
 =?us-ascii?Q?IZagx4pMZqwtw1uUxqKKITmfDiOeDQWOldjVFym25dvCps9LHhbhjZdhvaLZ?=
 =?us-ascii?Q?JNZN6ZbD3D8bEtw3eBCvJHH/UxhsIjAFtK6nyXEE9nf6dhiyncSGCIeYgV9s?=
 =?us-ascii?Q?q/D/0OUcko5knRoKa80m06vBE0osT+FPqIBRmvlzp+8/tjVdjI8++tDUZezz?=
 =?us-ascii?Q?i9bVRFR202Wg4+Eo1zBTQtavs1VQOPAkcteKcLCKHhZTwz81eYsiCwnm2h+U?=
 =?us-ascii?Q?avprGNwHd4t67dR2jEIgZX7agxSwbFsIEk3nmiaPFN+uLcJQxz336vBoWTfd?=
 =?us-ascii?Q?zkH602i5y8MNgSSfK80kUvaVDwg3WFVrV6UTPuMZBj0MzQW+BzAbuQZXx+Zm?=
 =?us-ascii?Q?lsSQg7LlhbstXv4aAGlwvBTAV0WpW0YShyp8YYMDz4361atXA/GT2OlDupnF?=
 =?us-ascii?Q?bzBevNfCFOWnr/vwlHU9coLNeS6CrH0Z442Lj4QgdwzjEKkC2gwRrDngdu4y?=
 =?us-ascii?Q?2SKQm4vne74LNtUt1mQJlexpUL2f32f8pTK9l5A+Py6PSGdbJ56Ok76MApIv?=
 =?us-ascii?Q?KaLbfQhz6vZm875TTT2otLT8RlcAhAy75i+R01wvyVI5B8TY1pJkGf+OhLRT?=
 =?us-ascii?Q?582nxuActjk54S8kiOR3JH37vhEgXSwlFjoN+XKfwREaieJjGdcl6Gq1Wegg?=
 =?us-ascii?Q?OVKbPpygfcQpcwD3WPGkXy9avIImn5w952GrSLzDWWJHF8Ea1SOyry8ZxydB?=
 =?us-ascii?Q?MHMOxdbsZTUMA48nvpSaoAwyRx3/4pqDJ8q+ScKLSLKVwaPuiLKWesYM6Wkz?=
 =?us-ascii?Q?99AtuyVFZPAI3m9NMOxYgDM6kZXm9KU7cEA/j9OlSlbB7f0o+NQfnm2/+3H5?=
 =?us-ascii?Q?izACImhXaI4dJ7OQOSGfK0m1Hb+RkFuzSFPjWQyb36eMjrJL66eGdGnia/LE?=
 =?us-ascii?Q?xS5zTN2FFQuZnHrdfGmIvZoq1WXBh2tjuJLyX6sE1t3ivoYkvHWbKATmLRu4?=
 =?us-ascii?Q?67ziVCmWY3PD5M4stLGrRWYMCClsdqyeYFPHb1ebYXk7xsw3TSUKpMDAxbc6?=
 =?us-ascii?Q?tiYg05IIZ+T3pePTsrAittO6x7SWbVT7Z7t0fDHnX8terpd8LIk67fEXT33C?=
 =?us-ascii?Q?EgiSWzyBkkFbUkfTaKOV8SgEvb3lPDSh0mV5KD6XRBmvd537fbQRybelBVUz?=
 =?us-ascii?Q?Q6JQgwcGWkE5udIL+iF6lU1a0GK6utqyldJ6A25FbyDKYE7lS5+G8SJhwRCM?=
 =?us-ascii?Q?SrSLYsqWkN5K2NFe3/x6+9Bb3Uec/vVIhuuAfNtbDjtuimXyzxxZfTarOKRV?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348d30de-9b36-4d94-1956-08de2b495f04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 11:05:26.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfCQiTu3Vxe0RyTLJ7fX1TqLO0SPo8F+St1sVhu4Ks88q5abWb2SyaGl4kuashNSLxZQFaIw/mziPE7FTznnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6328
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 11:05:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20711

On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/24/25 15:27, Jan Kiszka wrote:
>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>
>>>
>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Allows to use the same kernel for all arm64 targets.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>> =C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>> =C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>> =C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>>> rzg2m.conf
>>>> index 0b3acf49..485683b2 100644
>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>> @@ -1,7 +1,7 @@
>>>> =C2=A0=C2=A0 #
>>>> =C2=A0=C2=A0 # CIP Core, generic profile
>>>> =C2=A0=C2=A0 #
>>>> -# Copyright (c) Siemens AG, 2019
>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>> =C2=A0=C2=A0 #
>>>> =C2=A0=C2=A0 # Authors:
>>>> =C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>> =C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>> =C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONF=
IG_VERSION}/
>>>> arm64/renesas_defconfig"
>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>> arm64/cip_merged_defconfig"
>>>> =C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>> =C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>> =C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-
>>>> sk.conf
>>>> index 589f071e..bf3cf9ab 100644
>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tiboot=
3-am62px-hs-fs-
>>>> evm.bin;tiboot3.bin"
>>>> =C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>> arm64/ti_defconfig"
>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>> arm64/cip_merged_defconfig"
>>>
>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>> initramfs with the following log
>>>
>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
>>> create a encrypted device!
>>>
>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>> command confirms that the device supports sha256 and ecc.
>>>
>>> It's working with ti_defconfig. So looks like there is some timing
>>> issue / race condition when the tpm support is built as inbuilt instead
>>> of module.
>>
>> And there is no other module missing in the initramfs that might be
>> built-in with your config? If you re-run the encryption hook manually
>> from the initramfs later, that will work then?
>=20
> yes. Once after the boot stops at initramfs with above error, running
> `/scripts/local-top/crypt` manually starts encryption without any issues.
>=20
>>
>>>
>>> I'll run some more tests to properly identify the issue and post a fix
>>> in here or cip-kernel-config repo.
>>>
>>>> =C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>
>>
>> Thanks for reporting. Finding the root cause will be important to avoid
>> that other users will run into similar issues later on.
>=20
> Yup, actively working on it.
>=20

Is initramfs-tee-ftpm-hook included in the build? That is supposed to
wait for the ftpm to appear.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

