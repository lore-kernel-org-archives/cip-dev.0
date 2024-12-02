Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052AD7831E
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 13:24:59 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.86])
 by mx.groups.io with SMTP id smtpd.web11.173662.1733145897184193588
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 05:24:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gFi5RLlo;
 spf=pass (domain: siemens.com, ip: 40.107.103.86, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jblvfPy1SthqGq/u6YqEssErd3duWxpPriJl6jU2cyblb0tveujGMptQAD1Gpg7If5DnVegkLqTHNittnVwWEbwCnkmvrKTYmrjZTaWRYdhH6nQmmOH53wkZYMndgZ98UVbQlONsaG+GT1XPCk11rzVfNxfmfw+YPZf7k0n7WyybFjWT06JOV6w9XqWic0C9LDoR1HCIgCrVRFX0q/zRzYaxMAGdsrbeDqTSDA1Xzshlh6XAyw2PMJYSqdsf4TMBlwsaBL/4B9Iwo8WxTlfhwrDz9SslnRH9xn3jezfHySNXHDxd/19y1gpuvj9qL85fnseRY6BJaPplla+ujGzDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVpV2XUcivyc9P3tDJazB9Z9QiF04KC8nmiHue/ZmaA=;
 b=kYS2SyL6tqUE+YU8oKN3BVfKp3P2cnFIBjzF5hGwc+SjMhjToOmTMaZ/zgnmYwcLPBw45gDNumnhAEGL8xyycIo8tKnOzbO/WdUGAmvgbrxbh1euohzTQfoL9tZWf1OtBhqhna/cuJ56JyWDLfBiXPLQ7S/A7jchGAdVe8TQHW1mMhk8dxEMkqBKCbb+PLmzmhrrsXZzJpquP1uLnfhjOsxHnFeMzGf3495PQ8PfnrZFK1kKoBYFcCpO37CAm45BO6vkIRYzYuHbqJ+LpIkIBkXeNTB0BgYA/hicvdkyy3VIqMYRZy6WtKPUY30QRSdpXjV4rl/GTu+9Tn3oo4gTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVpV2XUcivyc9P3tDJazB9Z9QiF04KC8nmiHue/ZmaA=;
 b=gFi5RLloqlOCE6OWE60fmXf4b4oQM6bYU6b/YYn3AglmoSC6VUB3oUP2CzekrVGvajwpqRRt8r2WhzLwtCOwBnvWvSSw0T2E318mYg+egHalKOlBSFk/WHOLzLZEmIqJ1kDD3Fqg6y7EFDDnaj8zCrdgXoMJzUx+BQfQThRo2z9elEe167hMQtAh4XadYS1z7OweVp6VAEezYgHmPyA6GjYSs+iJoS9VPfdV+8HnrusV5cNiY8b6CGjGuv3b120yT4itIyTmHuZ91udBve9SjCz3i27NPNkG9McfTkrLOPIXpd4X+Ds+26Hn4PDfgO8MuRwwWtYnSwvT4rGSLlN22A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 13:24:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 13:24:51 +0000
Message-ID: <15dbcfce-757a-46d5-9d08-d4a8298348fb@siemens.com>
Date: Mon, 2 Dec 2024 14:24:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
 <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2fb47c-366f-44cf-9265-08dd12d4b36c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FWAAqbmyC0fvBmRE/lKvOqj9C+4L9V4AWiZqBpIyftUtl6UBdUh2BKzYVLMa?=
 =?us-ascii?Q?V1MVXHqcvSygz5yVDQeMRMridKzg9S+KWF9fmnjB2xYtJ3fOIXjqTiz3O6p6?=
 =?us-ascii?Q?11wKhfmJATL9C/aqJSl9bnYaqOEFNrH4r1pTYrHQTl+40hwx/bj+t28WsZV7?=
 =?us-ascii?Q?u30mNhvUI4b5mQrqr2Mv395GU9CsyPxeXImZ/N0DSgSwGkcxtGEHi1Ne11fk?=
 =?us-ascii?Q?hHAx/U29h5XA2clGzaC3XaJ66LHVKlMbkiFUFrAj2B73hNUhlYsTJP5WrObG?=
 =?us-ascii?Q?g4N1MV0XYqCnAKQJNih2xX9l1uqxVyDSWtpNBCBr8NyvCXnmbGwgBYbaVTvB?=
 =?us-ascii?Q?CBSTpEVUEylDj1vIXzc5f9y0elp+Eah1RiXLm04I3L5vhpQyFg3hjUPZTSB6?=
 =?us-ascii?Q?KChPCa1oTFbCvqwSelZ7gc/omJSyAFP4UCCIxlilmTZlnC2/ZOHfZ9aLbzPV?=
 =?us-ascii?Q?BIOIWUzJIRwPgUDIKSY5O9Hust+MOv25NDBMMpWOVz3pHh43NwXQDO9NhLH2?=
 =?us-ascii?Q?gU5XqFbuTt5sJ463UF3oXH0jUuMKkx+pnZOhn7pTdfRilDdQk/IQoOVj6aqs?=
 =?us-ascii?Q?sZIEfspyjYA1yN3zU8XWmjVdZbfngeMWD4vrtQdROk1cu3PRpGtGBxixm/Be?=
 =?us-ascii?Q?Q4nHWDcIacEafaRPlItAbArNGZgBWCARPfW9lFE2DBmR1Rdf2RBCIDPOGSlj?=
 =?us-ascii?Q?/ySwFMLkcXTGmrwODeUPbuJHVAdkC1aBBPAsLPt9ftQB8GJ+9LDrcOPuYBbp?=
 =?us-ascii?Q?DUPJ7PfaFh5Emi1cWxKakpmKtZGJVyJVJEzcyuNrqtJGRFvWWFJuouQfzlH0?=
 =?us-ascii?Q?BKyFNUv2C8j/H/yLn7qXy9AEKKcDTSORM6o959Jcg9lWc5SjgMAfOuelkqyq?=
 =?us-ascii?Q?G03jUOoIqVj64P1ArSzaSYxE90qfdql8PKuBHrA+3c9p2DoKvpRERBclxfz1?=
 =?us-ascii?Q?SsjR2gNLZmo/GoaI7rwmrd189WKTuU8Eqinw2c+UahiB/IS4x+lBi8nIPpCB?=
 =?us-ascii?Q?b85b4eMj5z5eVH9RWZJGYFOR60Ya2Jf5cxWv9ODg+X46wNs7EZ2AOLdB++gM?=
 =?us-ascii?Q?0BtBKiVGALy2UsWHiUrDwxy22dujaIDFq7sX8fCF5mflcUHPDke36dw14fem?=
 =?us-ascii?Q?9rs204vcRTRbYXJOCcsdmIDGreeBfxjRijcD9c8KsIntJBVJMQfXa8clH/jn?=
 =?us-ascii?Q?v+zNuU+BiiQRbqRUmbjAEuOZla4bchMMby7bX/SDlkE2/zGaFit6F1DV9Vw9?=
 =?us-ascii?Q?ogXlSgzmIN7v7vz4XyNoW85CiosqN2uAY9fF9cFAPG5p9cHen8zy+/rsRrRj?=
 =?us-ascii?Q?5jw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ozBsPWua5aKQ1X6K7cg46kJIHQkpCKJlVzasMdjZ/vgoG2d+031YxnWqYsR5?=
 =?us-ascii?Q?G3KopCWc4O/LsjlGMPUFJ1OTv+SOkwAmbIdNiMhi3kTbm48cefT+YtN0fcHX?=
 =?us-ascii?Q?YMwXiYdpCC8FruQVz973SrSK5spE/UfYlTGWjHPJQa/aDBWooGe/kC8llx1E?=
 =?us-ascii?Q?DeUdaqdyrcwJWzuFda+L8P7gIqUNQeYHz497zedTeJXgLk/TBDfPzDB0SD8F?=
 =?us-ascii?Q?p37bAqUqAlURnMJHwd4OHG+mJdubmksKKq80OyLhYNezlHL/Z1OVqJDpRos/?=
 =?us-ascii?Q?h7wPC5ujIzzJxF3tQwO7QqCzohIwML+1bmNwp4t/KrW3m2aO6Hl37X/v6pwI?=
 =?us-ascii?Q?V7xdle6LrwE4NCWrAUMLQ//KjaYXamsiOt4SrHrHqTknV2PuQq5JCVYSu7fy?=
 =?us-ascii?Q?Sh30nNb27N3+DxsetbFyaFMPm5KjI73Nf4Nr171x56JebHL2LGlXsYCwaJmN?=
 =?us-ascii?Q?h7b37O4aK8kBe8Ih74DR06IwMkYZJb6HJccBuoPZ+O7J9iRBx+cWsh/LH5bg?=
 =?us-ascii?Q?RqR2TxKM1LZQuic//OH+IU9APKoCEtSAio2zBP67PIPsVtrHsYHBA/t9WQbi?=
 =?us-ascii?Q?lH+MhPsk58vXSCy9d+3fRVfT3NSFFBq0QhereC3AJ1XR5xJn8Oo4pcTCNLNX?=
 =?us-ascii?Q?7akprQNjpXZi9/dj5NBf/8/zX1PkqQRNcbHrsyfpjae6ErrIWk84KbQ0/7Mk?=
 =?us-ascii?Q?+cvsBgsZwF81BxNZUhUK1LOdL1cONDesnFlrRMkRq7iRrirqpLSr/LVna8I5?=
 =?us-ascii?Q?RHEmNPeUtqUBZ/Iv6D0ARrYZP8R3dSClV4n2ZTCLHzBCshu2ZZKU0aUumfug?=
 =?us-ascii?Q?xCk6ssAjyD9yHBYvZ414xL6c/L2ZNgbchOBfwBPgGOSpTITIFx35oyIKH0ea?=
 =?us-ascii?Q?tUuGXb+OwhvRCTADBGJGfkJmZMUu09fk6SOMG41BCx3pmV2fNAlSWbZ4WibC?=
 =?us-ascii?Q?GIyzuQeNsPZkzRSysj8+irJSvKHq5CvBC9EHjP64tMS+K3itU17VhBy6RFcy?=
 =?us-ascii?Q?3VMHDy9xO2hhxpVuQvihyghFMBZzceIljqcsq6LVagQO9dE2uCZghbP5/dZJ?=
 =?us-ascii?Q?TlhQq7F+DSjv1f5so2LthKDfiT2zvu7kk5j9v9xsDy9mxQsNQ4ebY0HOZ9v/?=
 =?us-ascii?Q?Xu8tA0QD8muofNuOaokcI8Xh+rwb2W5Nv0eXZrh2bDdZixPjHhQSF2q3PXPG?=
 =?us-ascii?Q?Tjxe3TFW+c/3DcaSEjfzTFgNr/jErALcm6jN9+rJomBX1kQ+t0/DNyvH5jSY?=
 =?us-ascii?Q?XXwsYmJ30sfrvjciUbA1RA6+IgfNWkLxh0q2cBrsG5F7BvdLIngKkPZxoKjG?=
 =?us-ascii?Q?uyMM9Rs3FDe0d6LyM5V8e3g9WDtOgIMihkbn2R/Ba3c4c9AtM1JDf01b1eRs?=
 =?us-ascii?Q?uyJuNCq+RuFll4qs58PKJtBIJNqTiHQ7OUv0Gu1Npt56RP0HNWhBMdD9AYsS?=
 =?us-ascii?Q?Q6Bez8b/rn6KnxcV6FLGopL7X75NVJrM4Z2IcXEoQIYEYvpUiafCJY4SI7sv?=
 =?us-ascii?Q?Pa6HtFm/SRLHWpJw/iXyqnZDJAWD6+kZSm16TNlzKsgwTakEe6BkSUlSK/3T?=
 =?us-ascii?Q?gmLBKEqqwcZhNCNjLGHPfiZfiNKNuKdzn7mBTzUYeO9o1rLeRUMVdnGk+qW7?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2fb47c-366f-44cf-9265-08dd12d4b36c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 13:24:51.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvCZRAId1xfd84QVacy/YuKYg7ZoSHWA5e+eYX5iOeDqHFa98kKmadtrV/p2c7lHJ7uTlx/CHdO6kESiBYzTih9+thNFlcAI+Kkd3h5W+xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 13:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17305



On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:
> Hello Quirin,
>=20
> Thanks for your help. We will go through https://github.com/siemens/mtda=
=20
> <https://github.com/siemens/mtda>=C2=A0to understand how this can be used=
=20
> with LAVA to flash and boot the WIC image.
>=20
> As you said, the secure boot image can be booted on a device with=20
> "Secure boot disabled" in the BIOS but we have a requirement to automate=
=20
> secure boot testing as well, so we need to figure out if there is a way=20
> to configure BIOS through LAVA before booting the image.
>=20
>  =C2=A0If there were multiple devices, then this could have been handled=
=20
> using tags where security image related testing can be directed to a=20
> certain device with all secure boot related pre-configurations done in=20
> BIOS where as the non-secure images testing can be done on the other devi=
ce.
>=20
How many test case really require secure-boot enabled? Most test case=20
should be written in a way that the don't require secure-boot enabled.

Quirin

> We can start a discussion thread in lava-users mailing list to check the=
=20
> possibility to implement this.
>=20
> Thanks and regards,
> Sai Ashrith
>=20
>=20
>=20
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on=
=20
> behalf of Quirin Gylstorff via lists.cip-project.org=20
> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Wednesday, November 27, 2024 7:39 PM
> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;=20
> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> *Cc:* hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=
=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=
=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)=20
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LA=
VA
>=20
>=20
> On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
>> Hello Chris,
>>=20
>> We are planning to run software update, secure boot verification and IEC=
=20
>> layer tests on M-COM x86 device in CIP LAVA.=C2=A0 To achieve this we be=
lieve=20
>> there are two main challenges.
>>=20
>> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>>=20
>> We went through the existing job definitions running on CIP reference=20
>> hardware on LAVA to re-use if any disk image is being booted on them but=
=20
>> did not find any. In every job definition, the root file system tarball=
=20
>> and kernel image are deployed separately to tftp. We are going through=20
>> LAVA documentation to figure out proper method to boot=C2=A0 =C2=A0entir=
e disk=20
>> images on LAVA.
>>=20
>> Can you please provide your suggestions on how to do this, if you have a=
ny ?
>> Once we are able to boot a disk image, then next task is to boot a=20
>> security image.
>>
>=20
>=20
> I would suggest that you check out https://github.com/siemens/mtda=20
> <https://github.com/siemens/mtda>. This
> provides
>  =C2=A0 the necessary tools to flash a device over USB/SD.
>=20
> We would need to adjust the lab setup for this.
>=20
>> *Configuration of BIOS settings on the device's firmware to boot a=20
>> security image*
>> *
>> *
>> Basically, CIP security image has secure boot feature enabled, so before=
=20
>> booting such image there are some settings that need to be done in BIOS=
=20
>> such as:
>>=20
>>=C2=A0 1.
>>=C2=A0=C2=A0=C2=A0=C2=A0 Enabling secure boot option
>>=C2=A0 2.
>>=C2=A0=C2=A0=C2=A0=C2=A0 Adding secure boot keys in EFI storage.
>>=20
>> Only after these steps, a security image can be booted on M-COM x86=20
>> hardware. I am mentioning these steps based on our current experience=20
>> with local setup. But I am not sure how to achieve this on LAVA.
>=20
> You don't need to enable secure boot for testing - an image with secure
> boot will also boot on a device which has secure boot disabled as the
> image does not check the state of secure boot.
>=20
> Best regards
>=20
> Quirin
>=20
>> One idea is to pre-configure the above-mentioned settings in the device=
=20
>> present in *lab-cip-siemens-prag *but in that case I believe health-=20
>> checks and all other tests running on M-COM x86 can boot only secure=20
>> images.
>>=20
>> Is there a way to change the bios settings through some arguments in the=
=20
>> LAVA job definition ? If not, then can you please provide your opinion=20
>> on the above-mentioned approach.
>>=20
>> Thanks and regards,
>> Sai Ashrith (T S I P)
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17304): https://lists.cip-project.org/g/cip-dev/messa=
ge/17304
> Mute This Topic: https://lists.cip-project.org/mt/109804627/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


