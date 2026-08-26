Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBEFC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 07:54:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7509.1787730863872038013
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 00:54:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lF4Viqf4;
 spf=pass (domain: siemens.com, ip: 40.107.130.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ24vC+A69NtMjdwNybM7bFPp7+gRBLZaS+eaQFKVaLnfoAYNaV2RAU7k5QRpuZG/wfJ0MObJuhK1dDX0CUdFqTDis0wk6krDDBTw4zy9HRUoCY4HZT7EK1yG2WuyJrrCm2VPotKPjuOGeIr8XweMYaxQa11ATt8hivYQBG0ZuYX1s2XvkoBfyTva6qFJ3IBt+3FhUd7FRf0AyaJiLuwoTkDbDk3TZoHdUkABGYRIibRRRP7rLxptEbKv1Lwr0MYEdbD/MpSkJXjVBygx5Rhm2kFf20vkj2u/BwWoZCXlH4Hd8z0M4L6LYJJ5UuiunPGo7dQHu+pQwcW84IGTFjZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBt/s4X3xNKAKZ1YrfnDahK+EkJXmzz2LwPmCo2q1OY=;
 b=B1HfmGZi33QizZhDvC2ZEdjVuJXi0DpsSXPO9WR8i61izogbK/p7Uqxw5eTfMc2ao4x6932tyFkTZxgY4YctozadHLip4CQViIcgoVHxOWaVSD+ZWXl3V3owQrH83k3zpgVBUn6FXjhcf+szcK3Gj4EpPwaerxjbFqjoya2FYuhDvaw6GWn22/VQfhk87y/v4EaRG4OP1X+XG5Sv5OfbAyvWdgApi0F307OkFspXkkSYxhQCMH97KfzGAKTNRnGadQgBEtcGdpuFJnvB5a/Q3lzs7RbtmvdDEMDNOUpKqTlG+QjCOMUq1ppVI/bcvdpTV20AscR1LJwCAcM82+uOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBt/s4X3xNKAKZ1YrfnDahK+EkJXmzz2LwPmCo2q1OY=;
 b=lF4Viqf4l3fr+VxZv9U8jO1f59gj5XMZQluVb42JBHOefnmLT1ZVOdAMkz12Z3YmG2JkIibmhH/1hZOkVe94QabnkLgTmNhbeW/L1NrRcVSr8MUv0Yj0ltyWC2UsYgQ4nJZp6UXLm5hY26vmiFmzHr1vAyhGtw2axmJKEChy71AnY4d9NFmCXo1L2CmPxh581ANewriPH3roIkvPgMuL9ggT9Xh5h7vzDVADWpbv8LngtJzF979rIbdaI8eeBpXMW5/tBnf5XF/REPO6nDLx+rdw/RCFvEuBS+URSuGw0N3B+/W0PS8/xx0JpZaV0GmO5DVeTkegSRsyFVe4Bu21LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 07:54:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 07:54:19 +0000
Message-ID: <e9769fed-d36f-484e-b659-72c3c3abdff0@siemens.com>
Date: Wed, 26 Aug 2026 09:54:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/7] cip-initramfs-functions: Add
 secure_boot_enabled helper
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <d55b05021ce583596d62e15daa1beddd6a32a242.1787722904.git.jan.kiszka@siemens.com>
 <12c4eff1-4a75-47ad-b5e5-6ac08dee982b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <12c4eff1-4a75-47ad-b5e5-6ac08dee982b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 814477bf-7ce9-47c8-522b-08df03473bc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|55112099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	TTzL4hK+iTEIktWJV+NlCk5GF3d+2pBbZydHyOqArInYqcqWD4BE3eDUUc0vk0obPWJUZcjTH+6fnrRzdXMuPcRq2jOWWJEyVSGkVWsZDiUkvjdfDW9a8nj+XlY8Azwa/DP0UEyJgNcxdY3MupjJ/3OFEivRTAJ1i3CuDxrgFgA1H//7NOtdyesPHkRdfzYjq/ZqP0B5M/Rp6L65KYuykNXIDYYkn0ZdcSzWwo+r3paXawleftLEa7EO1jqb9/VJ5wVHX2d668YVlxWe9SfKoJUWKshauP08rNQ5wETDX8P6Ey1J9XWcIF9Umltco4b4Tbs+6bbt0kq+0Ib9FcMwrXp8ZUD4hb16K+rERSJ2XvIv9+rwU/mU6afhpStI0+5aUF6Kstphj7LDbjZNslcKLEjqTrXn6vjBE7JE147OneLQFLBhiFD75xwg1CUpFj5ebXGk9ZWwOI9Unjo21w9dY5ZnwDXX8Bl9XBSEEgxR4DjUf/eiT8goB2iXsTbIbDYt3mMk1FV+luAkX2V5ukskYJJ42XlLvVl81kAp6U6wi3dX7ZJ6EpChBIRp7aGi5gFPsUIUGUEIisnUSITGmAup6ElTCb29Hv4MiJvfIr/MAGDbZAPhNclKhC/hwjhDhN7vgUvRRhcXKCmQh7iLW2AaTuv3oERyG59ohaKTWZnutQ8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AXdbwuPNOml3JM2h+kYKpi62XVXhE2B8+e5CtLv92tfptNFu015UqmqiAwAq?=
 =?us-ascii?Q?Fv6OCZINRRbA2ou98Apolpi3wb2KGpaiET1fjul7562sqoOpN5imPBgn5IKe?=
 =?us-ascii?Q?jcc/S1QpTxjJLoK98SZd21HitaXZQl3NWUSglu1KNVbM4kahnuoiTopHfKLR?=
 =?us-ascii?Q?lJbKkKnSdNNV5ZXl/kfiJECywumLSYwyNSY1QRNjT8/+LtpOPjrDfslhaOoL?=
 =?us-ascii?Q?Uh1vPS5ph+zhtZK7FYJCGYI8VZVDnza3QPCYTj0U20JAwS4KlgM1QgE6GbGD?=
 =?us-ascii?Q?ligrB52UD1ZaDhq0BzNGodMyWuzDDn7tQDodYBYy3yk8PdnjFn8c1Tsc6Q0g?=
 =?us-ascii?Q?ZlGR5DOkZXNZUmIL4JCad609cq8gByo2befVzdXiPMjqVMMROhlzf+6i3R1S?=
 =?us-ascii?Q?U2Yz2VRM9V0hGNXeFE028OU1opEoj+V/kHPLJYd1Oaebr2mPvJSvIBV67/Vg?=
 =?us-ascii?Q?eHC8+wQQl7tF8YIRJ3Hwf6KT0DIStaNOL6vDBknvltU/WeU1EMmrya9IMrUK?=
 =?us-ascii?Q?sCl5DR8nPgeoHBBBBtuHO5EpjcAnGjLl4DMUtY1Pripqyo2C/2Ga15wIEtXZ?=
 =?us-ascii?Q?HugZcUcEqcACxnv8Ak9cPfgBrJKsOAsB8noKLbWuK9cuUN1yuRHohPxOFiEa?=
 =?us-ascii?Q?mX5m81aH2VxZXcnYFpSFlhMQc7FwRjB4FAa06K+YhLFG1cL+3Rj6r2cGFRcn?=
 =?us-ascii?Q?SjOTb40huJRKXhEQWMqtZDcqxDhBb3z17mKyi8XvkwwEYNwJyvwvxON4waHI?=
 =?us-ascii?Q?fVdHLZpeSFR6DGL/0L7oGqOtGMOGJKNrItwDv3KXXVgvkUS2Uea2VzSVf+2P?=
 =?us-ascii?Q?1YWXpKCgNB1+joP6ko6bMqHBQPyy5mw/bEYN48jzwrFUUoi+VNLolK4dg9z4?=
 =?us-ascii?Q?pcu8ZeqLk3ai0XwOsSqe9wcWXZ4b7lwSpTxieMSqasiAUIoCwts6PGNFn6UE?=
 =?us-ascii?Q?8oPRT+wn9mwSshicz4IRgedfuOZ9odbjuHKIaj/EpvP114ALAXUOr9EiD87e?=
 =?us-ascii?Q?HqwnZWkmOMk3VEE6HzGgE55eNTQOSt23bWQAfTlmfuyksyYHGR4/oPNq81DZ?=
 =?us-ascii?Q?DU1Js74CrE+JLj/BEubEs9NvGjsE5UHHE5BUtL3XWHO7yWosr8L/uCQubZXh?=
 =?us-ascii?Q?UA1LveDMnvjk8KfWGxvj7oG5IuAjhUtOQ6KBGM+2m/S5mHyuerboUM8ifON1?=
 =?us-ascii?Q?IGpuPssJTJKwrSPth9R7OvRF1frK3SiGs4bxoQsRCuH6rXdRVvUuuUVVNhCg?=
 =?us-ascii?Q?w/HcGQTGccTwbf06mr51RLw667ucNK0WVtLN6RZvlPYpyommBc7ltCpWi9bx?=
 =?us-ascii?Q?qNj3tZy09QKFjToE0bjoMo0rYG8hBViKtfRJm8cC1QpK8+twYnKBiXkgOg39?=
 =?us-ascii?Q?8tabmOUo8eqZlotHzq6pt2M3HAN2b/yNbg1w99Brtd1pIo3weufDX/NfCBL/?=
 =?us-ascii?Q?wfcMJ8g67QjFYyXClnzEBLazK6cj/at3WBAZxWfvtQesUmWG+tuIOez5Dhtv?=
 =?us-ascii?Q?/RYONebyWaq2SajRndmAApkBvBRo58KSH/jhf5Jfj7qeXFa7KfdiFbC2EJbe?=
 =?us-ascii?Q?6Z56rO39y0sV1IxmsARFQr9YgixlatXL2ylAoSyduVEoWqAoXFanjY/4+GL0?=
 =?us-ascii?Q?WjmVsyjiC2MbryFvh4gw6W8hRa0mYbpjLWnpiGOZYIM01cWbY/THB6jAgAVU?=
 =?us-ascii?Q?UT/xFDJ19sRUcrOJ0/xh7kqLwdkUCSjNaxDznRSnL1+sJwYi+yZMGuw8bJ8J?=
 =?us-ascii?Q?25Nwy8JqGg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814477bf-7ce9-47c8-522b-08df03473bc1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:54:19.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zPFQJF16ygIdTIzhP/wigwet9hkN4pkvRm/WgiH3ZCxi1NP4DJVguy170Ow0FPIMFvE8Fpdr1kvVEnsUg5onw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 07:54:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24015

On 26.08.26 09:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Will allow initramfs hooks to determine whether UEFI secure boot is
>> enabled. The user is responsible for deploying cmp and mountpoint
>> binaries into the initramfs.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 .../files/cip-initramfs-functions=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++=
+++++++
>> =C2=A0 1 file changed, 16 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-
>> initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/
>> cip-initramfs-functions
>> index a4c1fed6..f14956d5 100644
>> --- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-
>> functions
>> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-
>> functions
>> @@ -68,3 +68,19 @@ scan_for_partitions() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> =C2=A0 }
>> +
>> +# check if system was securely booted via UEFI
>> +secure_boot_enabled() {
>> +=C2=A0=C2=A0=C2=A0 efivars=3D/sys/firmware/efi/efivars
>> +=C2=A0=C2=A0=C2=A0 if ! mountpoint -q $efivars; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount -t efivarfs none $efiv=
ars
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0 secure_boot=3D"$efivars/SecureBoot-8be4df61-93ca-11d=
2-
>> aa0d-00e098032b8c"
>> +=C2=A0=C2=A0=C2=A0 setup_mode=3D"$efivars/SetupMode-8be4df61-93ca-11d2-=
aa0d-00e098032b8c"
>> +=C2=A0=C2=A0=C2=A0 if printf '\001' | cmp -s -i 4:0 $secure_boot &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\000' | cmp -s -i 4:0 $set=
up_mode; then
> What about audit mode?

You mean, I should check for !=3D 1 instead? Seems that this is what the
kernel does as well...

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

