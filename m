Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4347CA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 06:30:19 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.web10.94939.1755066610618732759
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Aug 2025 23:30:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YhjR5jY5;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNJ4b75SW/MkJs7DJhj10Rp8vDwuG2+61/xX8VpOkNvMWVELe4ZKNz2PmBQacW2iRrkI0DCL8EW7thG5hns0Bj8pBi6Xb9NQCth694RqdQUl7GzZ0iiSAmEc7m+rJ3ytoGnJ6fxoACmpyR5mF+WC/6yP3imWhG+TWb6wXWPyGE13HOpcQErL7ZgnCQnDo6w5jXKLXBmSd6WTU+PIOlCXz56UJSnzVJ8c6RAhkWoj6mDerK+szrwkPAMJoXzEujuFQ60QKUmxxyxxXkp/aoO39+kSH/PPNfixcgC+N91s22jymSJbV/w6S16LNh+KLCWlMuAJWZ3jqBLRFBPogUgkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v2sDCm+ZDOk7xNBZX0QVxT0eCjoviM0yFII4Axd7uA=;
 b=R00E6BRwYIwZFU7jOj8KV8PxZfcwWl9iFEJa5MeYofugqzk8MYpqn/iwARGTFPpCXIjgEfYfntV0Ll6bcbuskgihb8UKCqNj8ySlmgGaRqesuaSNPJxcfFvrzYsGDPlitCG3kwBuETEQVG/flLqpHAGeFk1G1Zcv8u9VLF5mLRvJXv6zxn3NaVb9I6K6qMyn9WpyZGCjsofbA6JyFUCDZBLcjItJ1vfoMT0BeVIyHB7hWUjFke0MMrI00DVjkjyodFgcG9k4+ewlSIVt+KH+GVoZ4lzF1+Ct2nG5MCa2p6stIWP5bfKD55+7r0HUejl4C1yobsFYgytBMEDIdyHJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v2sDCm+ZDOk7xNBZX0QVxT0eCjoviM0yFII4Axd7uA=;
 b=YhjR5jY5ua9IDcnVCwwawtEfli/5kJ03muGIsjkWkxjtI5cFcT0AxL/h1JiaCprDekmdxhMF5gk99AcK54YADqlo7wZUeYJ3BKnupPK6rPoEybIQkMHpnU0F7jwOVQeNVb8ppbc+kxwJQTxvIP9oCDCIP3/19lXJyLyP2+KzipVe8g4hI4PSZtv8hwbd5FCXiz8ga/a7gwjmJnLFWQKt+SRGV/z/qXfitzQhMdcKTQQ7PtI9y7lyysAo+TsQZlmgHu0xWCJxOtxTqkuDzYLFpZp9EQUb7O97csEF1MUKE9i5mnzRY/J0qUsbGZdbSXv7EEqMFvn0OVI/m0fVTAMQRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 06:30:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:30:07 +0000
Message-ID: <5d939d03-d437-4c20-a774-a2b9835434cd@siemens.com>
Date: Wed, 13 Aug 2025 08:30:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update
 revision for rdiff_file handler support
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250812092815.1282546-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <ec5c9daa-5dbc-4073-a0ff-228ab91444d5@siemens.com>
 <TY3PR01MB110752C228BA5A80A92B09B55C72AA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110752C228BA5A80A92B09B55C72AA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3186:EE_
X-MS-Office365-Filtering-Correlation-Id: d82f6af7-61bd-4c57-a666-08ddda32d85a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/EWWLdBvXpgUWt3CumI5yIRnD7xAtTU7uCwhgcQ1IIFwDFREM1p11BV1LUJb?=
 =?us-ascii?Q?z1PwZyKdut2LTIgU2ECl7Iqb1t8Gt4lpHxTyTys5Ygc02wHTb/JHDbvApDP9?=
 =?us-ascii?Q?ZLAPwahhZPBPnGtxsZIKBBhtyJGZlAWI0pqQLTdAPGxkgPI3Ktmt7pEGNnmE?=
 =?us-ascii?Q?khoU215LGUA7KjbkX6tKENrA+kbQpU1mSZ61lQkE1AusyKvQWFxxpZwXUPJR?=
 =?us-ascii?Q?lrvOPX2CbG01TH79c+CZsz4UXp7KzchPc+/TU5zqL8NQc7MJhMvTndFkYjlj?=
 =?us-ascii?Q?S45BYqP400qUcfWq5WKfEj+dnT2fqFT6Nf7TBNRbBrGm/61QHLWCWKYxz1Wx?=
 =?us-ascii?Q?qkn2E3YUJVisVN7W4Pwumo7SYh1FEdlm29LQ1WqJQQEeyQQnBW7VT/ejG21C?=
 =?us-ascii?Q?oT5jUV5uzCZlbHhodWWgzh/4fEquJO2qT7FF3V055ZPUqRHnZN6jsVLJUGnI?=
 =?us-ascii?Q?lDdKSq6jcLHr9fC4ER2gnu2KOZ5X5pXBEEb8/uuquvYidFL96ZSXjjOO+rtM?=
 =?us-ascii?Q?leupm08/UMDKKwP5GXLL2lvxju76q8CRe/VKBxHiX2RfM+06Qf3aFEek8VKt?=
 =?us-ascii?Q?EyPiiPKB0T+owx/YPjjNJZwEsEXYcaOOUF+nkc+JhjNPxI5TVNKkROvvaB9i?=
 =?us-ascii?Q?XfOCP5WHOU4fi3KmsdF5doLOejWUO3cnrGvtrJszvTTjhG6/qy6Vi2pwaoYk?=
 =?us-ascii?Q?8XrbWEkABLhiyO7AWXWEZkuofH1FcXTgIw4lDI328Ckm2tkdGEM2+HNkMxPP?=
 =?us-ascii?Q?sajxSyt+qb8SWIIvYNZvDPoNBWnUz6BZeMNLznfddf7vCPgSLuTD4AOW11LH?=
 =?us-ascii?Q?syCf5iyt4dIS/Q3GSZzb97ROTxWh+VdvmCVt55PufXJd4wb1+8ZKsSZ+hnJf?=
 =?us-ascii?Q?RU19rsBpT2S3DVoPOPq/Q+0rjwLpy9Sgd7tK6sDck4VyPIMV3gyOe5E6Qaz0?=
 =?us-ascii?Q?9XFv6Ype5ax/kRJJPxeUe9KyVkObZW2cyS8lGwuqUARpumnIaALheGT6WvBE?=
 =?us-ascii?Q?lTwChkG+/+1oRVrO0s4CprvXQTpOi5MtdzAFiriLNL0/I02VEsDKR4lovhKb?=
 =?us-ascii?Q?8ctL6OZ6W3mZUeHQvdmF+B6WElYAJdS0tzZZbegF+Qyz1kboTz7l4dUlIW+W?=
 =?us-ascii?Q?TT6FardnzO9Lb0i3jaIP5iooXWSg0dwoG0x5FHqqkLNk4vAdWJHF9j2flUA7?=
 =?us-ascii?Q?1kX1tOyPGVspCN90CNlFYnnLCULpEnrMXR5nl3QWkpiNnymZKm3NNkaAVaTU?=
 =?us-ascii?Q?t9V7wKmXtz/CIviNP0izKihcYh7GAe8bAM7LWIiq8Um9NvSugVKWLDRwwUpu?=
 =?us-ascii?Q?/QHKfUicWpJaX0+tjdpozQIxRWmrt0W/WiyfdHil0cMbpaTbzsaDMxUugltk?=
 =?us-ascii?Q?7/Vz+jTYFASyNeIiu0Zelp2sz84dn3Ehp9tpjyLZ46mcw8j0Cs3vT/shHZPe?=
 =?us-ascii?Q?l0Wa2BoLqho=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bn/QHX7Nt4vnxmjIUg43Ufc4GlLOGmakVUOIAPLvFZxMmUfuCI+JskEujdeX?=
 =?us-ascii?Q?7zf5+psghQqN6Yrgmr4GjNlmNmaGjapL3ch9mFYKgQZdZhHFB8i/Q+lMkCFq?=
 =?us-ascii?Q?XB8S+1Gzle9FUiTCcQ5QHvJkrCb9u1pH9gXhAgXzq7uKWesLyvNUyIp532Wb?=
 =?us-ascii?Q?qN3+fOEnNk9wL/lG5HtAFFje5M2ZV3OJyJ/xvvxMvUs7xMYeBdqQoc9rdx8L?=
 =?us-ascii?Q?dyI8/25i/mH08ofradbyn+g6AgcYRCXr+UL51fQKXjL5TT30hVoiETHTMbbh?=
 =?us-ascii?Q?6opnZcGlG+05k7uzJK1E8hKHBurbMZWRf87BLSxqJhjwT1Tb6jVnACstgjSF?=
 =?us-ascii?Q?YNloZUaBaVl/WgdpzyC3rpZvic2i5fdLArcy+C1XZfBTgNAzTahU4UZVcMHW?=
 =?us-ascii?Q?6fC1aJjqs9EoFrL3A0Z71rKrdlYZCDtyugAzIWk5CrsCYOnnpK7VmG63LAZy?=
 =?us-ascii?Q?iLLR2ylbPrJCHEPj2jkOPw5FTp3BJTmOYuw2thYaMZuaV+hFMu67hIQ1AsOw?=
 =?us-ascii?Q?562h1x0zGqF6XuFSOM3MZNP+9IDLIQ5kFxwpwzp+wnBFf1tHt2B34Skye8q+?=
 =?us-ascii?Q?jO907M6qnO/S5+GR7SMSOMd+uUHeFd/xwDcojkP4brgi/hobUugGOB114vJw?=
 =?us-ascii?Q?9yP/4fFq1SjGdSu2UHfM2D4zbljNK8acRQOJfj9kh1toex4Vl/vJLoq9Dzvg?=
 =?us-ascii?Q?t4RB3ZLIQg3LsMErz6Shfjt0V3dHfwom2E6bIjaMIaETozm0FVvQ4Z76hJWz?=
 =?us-ascii?Q?lOUojo6DUI7r0rD07aGGY2MMO7fbBItNWHqvrOyPTdKt8x3FTD8p3Cz0Kivn?=
 =?us-ascii?Q?uoZnQqDgONZvsAOHu3/mbO8mA7W1P8xoc17dvD5ZNMwoehhO8gQctpD8eR/P?=
 =?us-ascii?Q?stObCnuCufnqy+RoB9vHZ5sxrJ6wIJHclaiO8ogGtsrOIwONTTMssBSjH/Wy?=
 =?us-ascii?Q?0HDJgQgDFASyolv2AsEJjaehe1PE2ZTDjbSPKhC41UlglI4HjRk3NQzBQmmg?=
 =?us-ascii?Q?3KG53Fgdp47SeMPhFzHiooBg69OiW1c09rk9Gtn0k5Ngk12B9uxS5wanbJ0g?=
 =?us-ascii?Q?PA1t056+/PdU/duoxlwqxB3zjQeutZC8Pky/T1TIJ5+VZYATbhQKcu3puiyp?=
 =?us-ascii?Q?1TiRl+RXGBy1zDIAHbgd4w/12dIQ+CiQOfH8XnoHa2I33EH5znGQee/qRf4H?=
 =?us-ascii?Q?unB7XCZ8rQ4r2bSpVxoVk+Q8pGVzmL0EcBzumGzRXN6sGfNd62b/Vyr111Jc?=
 =?us-ascii?Q?ZmJjiluMHc6QZMQ2RxKKVeuCUEyuidLS+sAFCn+8aCGZkEo/SvVJ9A6m+zIS?=
 =?us-ascii?Q?UlRsjdXKqUiU7tr+bIXRMDWMaY59Va8VKbv/YnVDgp14C2PnfocDM3jDHgy0?=
 =?us-ascii?Q?wot8+g6nm147t2jZ2CKweTR4jlnOqkB2SMxuK4ARnD8fMGGV4FPCq2PzgLri?=
 =?us-ascii?Q?Q1A/ff7LE5cwirs483fl6t8UlEjJCSYYVGJ7yo+6cCQwUQe1B5eYeUgcOgX9?=
 =?us-ascii?Q?l8L/D1UFvo7kr0RaexsGnd6OD9LjpC3deHYumB1L5ngBqdPeqMi1Faf9ja3G?=
 =?us-ascii?Q?8zraVX4vE/xpxo7DC9fge9QiW4jOkf8KPU9ieGbL?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82f6af7-61bd-4c57-a666-08ddda32d85a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:30:07.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHLfs31JWXj1FUK/HqDi9T8q6PcwNBd4MNpQ2IPTHGUn5AcmuVVKJXdhcK5Zk5ewc2UkrYz1HWtRf6BtiCG9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3186
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 06:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19721

On 13.08.25 06:29, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> I would have expected this together with changes needed to do delta upda=
tes with UKI images. Or that already all what we need for that??
>=20
> Ah, I see. I have made few changes in isar-cip-core to support delta upda=
tes for UKI images and thought to send them separately.
> Let me know if you want I will send this patch also along with those chan=
ges. Shall I send a separate patch series including all the changes?=20
>=20

Does this update of the handler bring other benefits or needs more test
exposure beyond the new feature? Then I'm happy to merge already.

Jan

> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: 13 August 2025 01:50
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =
=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=
=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update r=
evision for rdiff_file handler support
>=20
> On 12.08.25 11:28, Shivanand Kunijadar wrote:
>> This revision includes the support of rdiff_file handler which is=20
>> helpful to update the single files using rdiff.
>>
>> Signed-off-by: Shivanand Kunijadar=20
>> <Shivanand.Kunijadar@toshiba-tsip.com>
>> ---
>>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git=20
>> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
>> _0.1.bb=20
>> b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
>> _0.1.bb
>> index a185f25..d2edbbd 100644
>> ---=20
>> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin
>> _0.1.bb
>> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundr
>> +++ obin_0.1.bb
>> @@ -13,7 +13,7 @@ inherit dpkg-raw
>>  PROVIDES =3D "swupdate-handlers"
>> =20
>>  SRC_URI +=3D "git://gitlab.com/cip-project/cip-sw-updates/swupdate-hand=
ler-roundrobin.git;protocol=3Dhttps;destsuffix=3Dswupdate-handler-roundrobi=
n;name=3Dswupdate-handler-roundrobin;nobranch=3D1"
>> -SRCREV_swupdate-handler-roundrobin ?=3D "e6936b8c29a20cb6a6893faae57e12=
499ebbc342"
>> +SRCREV_swupdate-handler-roundrobin ?=3D "5deb75df5469c5a66cdd727eb72af8=
3ce0784054"
>> =20
>>  SWUPDATE_LUASCRIPT =3D "swupdate-handler-roundrobin/swupdate_handlers_r=
oundrobin.lua"
>> =20
>=20
> I would have expected this together with changes needed to do delta updat=
es with UKI images. Or that already all what we need for that??
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

