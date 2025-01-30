Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39591C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 07:38:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.67])
 by mx.groups.io with SMTP id smtpd.web10.10911.1738222718518887238
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 23:38:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FP7BgIzm;
 spf=pass (domain: siemens.com, ip: 40.107.21.67, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diSOrKXtipcf4IoWpjfvfjN2aivvQNsNY5ilL8QL2d3Cc9SfUbCZa9ViOE8aBeZ8RN7eknV1HxxTkZVHEiy1H7FjUFgOzEGbsUq8+Uhl05ZmoYwuctSRkeT5J3drj4NLOm5oVLCcOcZMHiX1FaBp8dMDpUiLQgCY2uK08cQnmYIy3i2Z8ge9syVqALLz1HZfhpNABxJ5W1fHtbyqn7JQlb0vBQzguJbl+IYJX3Enk8/WUBQWuj7FS/3Evft1FHbk1lsf7+M+QcInJR+drSMZQEEKRHi2yyZJX5uJG0MOW3s9Ij21A2k0a03KYxlMpHRihH/xSZgRsXAYxJOi00CGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q+J0L/2WyKW66OJ21pvsSBqbpZCKCtCmjl81101pmE=;
 b=nGpNdFe9pgyMYy+izfSaeJbwB0VCoI1ubVWb+VhwWg5pLJLOTl42XWNiQsQVK6vlsvRR1jNN1yWd70uYInoOM9OdJdUQzn080mTnEYqKfAL0piiQqges0VcgJIhTV8UgoaS1FyGVdMLw9DmhfQo5PNRFggmxkWvGkjk+g1jztNs0p6/4UDCEb4lLFCXoKkvmJJGx+Hfl9e76eK+SMqndD57TMqj9zEtamahmCYinwZ4omYnW339tAXm81k4VPITjS9ZujIVCW2t/sImsoqmzUPSFjAJ2/AUVs1lCcwpRhXf4aSvj6J05IexlE/RjwYkE0uwVaHcpRqpmABy1xpwUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q+J0L/2WyKW66OJ21pvsSBqbpZCKCtCmjl81101pmE=;
 b=FP7BgIzmtHYVZT70/Juw0KzzMLVuDF27cp4ts+IhtKM7I1ypEtD8a0GN9WHp8lbI4/ef6hZaGR1IaqTQxBEK5+lcIEtwfU5d/1kUSdQA0if9PAyQGvWVU0DLpFeK4A/g53t3UPdPPusbFsNp0amwkDUPbj6UBPPb/RNXQRvzAVBqSkAoPBw1f0yeLORAokJK1OkCOxYVrutrbN1BY0DkXVrX1bTexDMg0ZPJ3GIqIIPeuB2Ee+LOjfleqfZ8GRgAWUtEGnCXnT/rwI2tvDDdNkO95hW65BlLsXy4oaWRgTWBoIBknhVyFBI/YzMFQvjNS7L7oP4vXlKUsg7bqgeYog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:634::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 07:38:34 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 07:38:34 +0000
Message-ID: <4de84093-2ac9-4953-b1a2-f57e893ecade@siemens.com>
Date: Thu, 30 Jan 2025 08:38:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] read-only-rootfs.bbclass: Exclude
 var and home from the erofs and squashfs
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Nussel, Ludwig (SI E R&D IOT)" <ludwig.nussel@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20250127140814.762632-1-Quirin.Gylstorff@siemens.com>
 <2fa58c7fef5275ce610cfcd6d4a936793b72f3b7.camel@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <2fa58c7fef5275ce610cfcd6d4a936793b72f3b7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e0596b-b4c8-49e3-1637-08dd41011a2f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XCG9gY/Gl+ic66wqZSPwm2q4tzFADt8hLCRT73YoeWnQzAjnX9p2/rAYi4DR?=
 =?us-ascii?Q?w7PaJsO5U88xqliJkNCIQZFo9YV/P9ZWxGUEgSJ/z8UoGKN+HLt0nH3bEGqJ?=
 =?us-ascii?Q?7ujeitLSPI3YJ7nYTpnwebyg/S7J+9QJ/nJ87uqyIC69GOQrYDUQqeK1Yx0F?=
 =?us-ascii?Q?qNs2iHOOh7bg8ZvSAFpi8hVqpJ4lob8xKM9lXa4qS/fUCY1gHcYbYH/BN1Vg?=
 =?us-ascii?Q?MMGI9wRsQYSB4XLqCR5URC0gSYVybO7t4B0970TZz357db1O4WB52b7nY6CB?=
 =?us-ascii?Q?MTzkSV9Fllz4pX9otLVFT/ZJ70G7Im/r4looWcOBPp9FldU48w8uYI86h6rE?=
 =?us-ascii?Q?xM+9XZ4oXyZWe13PMiuRtWCs9gG3DYZnSLFSFbJPPkiRQsTtBEhWmVZR4SrQ?=
 =?us-ascii?Q?vP8IHKZ5RZkSC3ntZEH4Vv/VbczvOeOmM4uxmtnKOFITgidGoYgUvjBl2Esq?=
 =?us-ascii?Q?jaQa2w9rfGNV47ZHrnMgVwhQXESZbCtpwvQRBMg+KyWINCH78mHbnTz/lUI6?=
 =?us-ascii?Q?KWbsYHYGxcQk6sVAcsqCGa4CNky3WeX3UWC22/mLD17GXCsimCYKezRYSiIc?=
 =?us-ascii?Q?z0qKcPmW43oLdcst0IIIGosnFo9mV85Xpv5cS8db18MCeUe4pYjThAHpvfBG?=
 =?us-ascii?Q?ZVDpArt0zyZqe+Qba738ZXumZeK6nSkVpfBJLSgT+ZY7plIpFyokVK2RxWsi?=
 =?us-ascii?Q?VMbnb/k7vMd4rIwBCsjEuRlv5rfY16/MM6VxuQfKisDpDgsGxim44sXu7qq1?=
 =?us-ascii?Q?BLVTHOIlKMnd43g9XAQOe2bIjubMSCE7kJKDje0Dtu45hiRDicTsfpfvnNTS?=
 =?us-ascii?Q?zKiwM2AAcwfryJYAzC1WPKUyApfgeFVj1Gh7ccjivdWb1/7ccoN6aN7gFZmh?=
 =?us-ascii?Q?gUdiqdEn9eE3zEOXvfNEwWYI3tLdjqOCwR7wpMLVEeR4rujzN6+YJ9iCTDpD?=
 =?us-ascii?Q?8nG9skKRULjAM+lSYNO/xbBVQIQN87GYOWr5ow1JyAfauOuBaD23upfJeAuQ?=
 =?us-ascii?Q?h2rOYNnzP0TPYn4+k9P/oohlcRbKnm3X9tkH9KhuVPCHlrgyL+BFblvnR7KT?=
 =?us-ascii?Q?1Fbs5h2oKwN0pN2aqFF071piGlXjNa/vhunzr9EVO4dwSHAt6b5QCx0/Mxu3?=
 =?us-ascii?Q?Ji5Lt8T9UjMaTK1KJHo3yViRfQVh5nKNfYhAJi+WH6YT+2uaYbsNj3JudFo5?=
 =?us-ascii?Q?DakS7ii8ZbrsygDg3BkJitknmj1u3QRD8u8Qbn4xA+0Gh5DanRl2jwAXFYzj?=
 =?us-ascii?Q?7iBm5CCb1JAFYtg+wI/HT15LggYXlVeHV8ythIAmEtb6R7VJj/CPSuKZvu0L?=
 =?us-ascii?Q?KLG4kNfO4yaEhhevvnAzgQSafH1eDDgoDQEfvWLM6IE+u7/cEJPf2RsyJuRI?=
 =?us-ascii?Q?ayLpQZLrRB9HalfGu+SjL6cj5xbE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ChiDqofS+JeNnpTjfAqnLcbxx5VqFRwfRZP89fbYhNUrUn3l7f38KZ1/U6IU?=
 =?us-ascii?Q?RS+eaa77P2umF2AY5+oB229Ti4hsBgJZ+AC63wR5ZUP/y0Rpw8a0phINF/Kr?=
 =?us-ascii?Q?czaOwwQJwMWKhW5ExpdtI5fSD8IZQDSrQB4gzB7G75zzq3FAUfMVg6Sfdprb?=
 =?us-ascii?Q?JL1K7hztZuxDMnCDtKCsnC90TH28KgAm+uH58FVjFzLdydSfPKZNbUhvlEKp?=
 =?us-ascii?Q?kVVWZ1i5A992lcVWb+lNmiNSddAfnVcwbEsbOYj2KFuAQ2xuBboduslmkhnT?=
 =?us-ascii?Q?jvf3jNtaZLGaANK7qgyqc8+4SPgqXfFJTzKwyjFfrDkMRKyuZY2cpGX5dII4?=
 =?us-ascii?Q?vPRMkZI2LEkAuR1g6zQtSpwHVQOUfnh76xu3fYvc6IC7NQKa+wSi32Qo39K2?=
 =?us-ascii?Q?FnuxB+WdbhqWJtKXF8wMN0sPwJcS35crfQ3XGvWrqAOpJXU+gFP74bwpXhaG?=
 =?us-ascii?Q?3bpVpf5KTSo3j1B7PFKlfjYYxd86WiPOGdOCgtIGTe3taEl2lZDmdK7xLMWu?=
 =?us-ascii?Q?t5Eza7e3y5vHOJj8cybBLusKC3IcHUp8nQ9g6iKp8ELmYbFF8pbP/8vpzUg+?=
 =?us-ascii?Q?uJ2/0ETOxhvko4INdNmCXjCa5adgFiVe+t38dlhqRTSOdNB6XA0l2xGdgSrR?=
 =?us-ascii?Q?g7vxSZs1947g6jSdl/Sze2Pg+G33xMVzX5bbii1jXyuTjhOmKRN4n9/3zTK6?=
 =?us-ascii?Q?uzY4/HnE4/iC9e56Fv9xqF5My5+PI/sYTA3Ypm5owE4t347w/iQt57LmH/bH?=
 =?us-ascii?Q?nozRG72RbMZmHInULdm5EyBwzWVhjHYmSaUjDjU/jZrvVCGFUMnhumfFCcjY?=
 =?us-ascii?Q?oaO3dCT+gEBjhjxIHqK6bbZCALp0/KsNbLuOmt2/or99p3+PocY5Y9OT3hmz?=
 =?us-ascii?Q?ScnjdjcXTr49GjodD2Bcrk7o7JVC8NU3ag4H1x5gkMIEYH4o/ChHulpWNqkU?=
 =?us-ascii?Q?aTPvr8/Wr+1RAjWDj86F7VIVWGHi5t/kSV5VvrkHoSHADG/O6GXRHLVP+kbW?=
 =?us-ascii?Q?hOQlyRFZ+Sk0eUjyuOUVWC/uzo61oV9mPSEABRujZd1UBLzlTJwT4awEifDc?=
 =?us-ascii?Q?ujEk9IqnSPmke5gt/FzmjkO0QIOk6fvSNTeWpatNPO5axULkLycrTvfkMT/k?=
 =?us-ascii?Q?/zucRzqnGiVm8e1LECXQtZ8HesjnMP13qud9f+VL4LMWf4rE9sHISLsuwDo1?=
 =?us-ascii?Q?8sUyEyuejZZMq2AT+ZqS1er5Zv7S7XaQgppzLrcrKFkS9LDH0eJBGp2ksmh/?=
 =?us-ascii?Q?qwgJVVpcYJ+rc9jsM9c2IA6SWNckJnosFwzmuwHEvESxTjHR4V6RBMhN8FLG?=
 =?us-ascii?Q?xBZzOSVpScLgWQ8GQeu5xx16f31oeWdxcDYSNlP5r4eAKHHggd0bziFTeYTl?=
 =?us-ascii?Q?0qgUt+e2mUAFiSPqh37DmBfxIUU1Br5P3FS8PVMwaIPOkqhiYdfDHdfJZz9n?=
 =?us-ascii?Q?CSa/wX031/MXuuSn13T5jKOhe40imLxQq7rbEaI9dGL/CKRXlRcLp+FJMWmK?=
 =?us-ascii?Q?XZzGTJIA5C/Sr0skbcAwrbAspKNNfT6B0Kj5nsnU+/QlVmCWxts/umAeq8Cb?=
 =?us-ascii?Q?9dC/BEaMerdDlKoMX8bWAvN4AwpMfVjUe9XJPk2JANHQtpLunAxkJBPC4ic2?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e0596b-b4c8-49e3-1637-08dd41011a2f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:38:34.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1/gKtI1q+zApoKvF0TpMMfQih5WMyuCwgVwj8frmzsysrIUoGfRKCgRVDkGV4v16NOA2eBBCaVGM7bx8pu62GSCsPZFjJMJJ7NUh44cHZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 07:38:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17687



On 1/29/25 13:25, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2025-01-27 at 15:07 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This excludes the content of both var and home from the root file
>> system.
>>
>> This fixes issue #126.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0classes/read-only-rootfs.bbclass | 4 ++++
>>  =C2=A01 file changed, 4 insertions(+)
>>
>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-
>> rootfs.bbclass
>> index 9ebcadc..b3bab32 100644
>> --- a/classes/read-only-rootfs.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
>> @@ -34,6 +34,10 @@ copy_dpkg_state() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTAB=
LE_VAR_LIB/"
>>  =C2=A0}
>>  =20
>> +RO_ROOTFS_EXCLUDE_DIRS =3D "var home"
>> +EROFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>> +SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>=20
> Hi,
>=20
> we should also exclude boot, but I'm unsure why this is done in the
> read-only-rootfs class? You can *very-well* have a ro rootfs that
> includes a home that is over-mounted with an overlay.
>=20
The var/boot exclusion should be part of the read-only-rootfs class
as we already require an empty var with the immutable rootfs package.

What we could do is

``` read-only-rootfs.bbclass
RO_ROOTFS_EXCLUDE_DIRS ??=3D ""
```

``` cip-core-image.inc
RO_ROOTFS_EXCLUDE_DIRS +=3D "boot home var"
```

The squashfs/erofs classes should not define any exclusions.

Quirin
> In my opinion, this should be done in the imagers instead.
>=20
> Best regards,
> Felix
>=20
>> +
>>  =C2=A0image_configure_fstab() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>  =C2=A0# Begin /etc/fstab
>=20


