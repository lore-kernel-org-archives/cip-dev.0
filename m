Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7215EC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 07:53:57 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.42])
 by mx.groups.io with SMTP id smtpd.web11.14968.1713513230408187318
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 00:53:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hmkZB0wU;
 spf=pass (domain: siemens.com, ip: 40.107.15.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ0LFTbwAIFAAju1PUzI1JKYXnpz0aBcE/tDuG271ZNiQf0GOV0e+GaB5+znx37KbIxtqys4kCbFVse9Rwtnly6hZdEwVjC1Jfxq4VdLwKs/bmKtMBbhCn+4Y4j+8EZmdU71+2Xneu/Hry9+RQuTcJXC5imo9U47NAHNgYtuI/QADgIsV3pOpapfwC9wegXYskq2qj8e/6A7IpxgHnMJoq3vjgmUmN/uhc8dM1m/e4VRGF8ypo+iIjAjgVFeJHeY3mkuoVLV0r5agNrpuzxtAYgiEzCg6bhr5seCQwENbjELBxGfbulDg8zEelXKcMD9VnFV0U4MsQxJrBhUZqb2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/hno529PUFBs0r26ps1YCklsXRdxm8YDG83Q14F3pQ=;
 b=Yet0OgJTP16zxpuX6uGk1qr01h0tzXbHUXum4vJXxLbJUb4vRJePkWfgLJpbOmQqNIQFQPImrxmHaVvY2/3wUBW/T2kis4BWnKiO8XnWoCX8rPdyB0HLd2nY3SByx5o2Ld/bXHiztSWVk7id13JL5XTrpRlB0YHwFF/gX36ZMB5t+pARS2YhDbymfDjzoJMLIhjB3L9sp3HHYNciiHG91+c/etLT4yrK8iCuwjbC88QRm1xNl9KUeZtwf6GuYT9xOG6yH6SDS5xaB0KFXk0rx4WrNOUzLR1nYiDHND2wHwnegCyH2mn6pMez1ihjZ5oTZfQ3z4WufOzuxLG0ukSC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/hno529PUFBs0r26ps1YCklsXRdxm8YDG83Q14F3pQ=;
 b=hmkZB0wUqhKovPWCdFxsHfRQpDbyCW0usPXlf3MR0xR/8KWLAsZ2XLCQ3s1sacE96eywoFsYLnXuNuArv6Av6J7GCH4zwE5bfzQ5sfDV2m8bQDtiLmClz6qtXVt7/Og0H2FfOJecOAf1eMp6wQgVGwSoxoVOZEJcVFDwOt/7iyocVwhX7Wo6219N8FbR69pIsjuj0NVUYOxfYelBIRl1ZMI2vYiH8oqXTl2cl6rckKuq15juvl8D5WGdV1S+wM9U9Ihes/X8F8evBK4W3+cYzc2xHpow9XjwtRONGBBQHT0Nr7K/yC17ZBhugPE355rFGQa/w4zeNTYjhdP126x4YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DBAPR10MB4074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 07:53:47 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Fri, 19 Apr 2024
 07:53:47 +0000
Message-ID: <c0af497c-b598-4376-a72b-9764c6bd5da1@siemens.com>
Date: Fri, 19 Apr 2024 09:53:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 2/3] swupdate.bbclass:
 Generate swu for delta updates
Content-Language: en-US, de-DE
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, jan.kiszka@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 Sai.Sathujoda@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240415104610.3073497-3-Adithya.Balakumar@toshiba-tsip.com>
 <daf58173cf5f860c6d2bafca6febeb354679a15d.camel@siemens.com>
 <17C6A85A6EC64CBF.13290@lists.cip-project.org>
 <TYCPR01MB96690F57920D475F109579ABC40F2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB96690F57920D475F109579ABC40F2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DBAPR10MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e887280-a2f5-46cd-014a-08dc6045d811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l+FepeUr72D3dYuAXTyrsHOCfGCd4YGcPboykrMGA/yDocQS3vXtfE6xwXmjUjAweGvmsWYAIJXlugQpmw8YQu5rifQSjKBRx7AIpMg2OPVuuFGQBxxShNfhHAQvV8D/o6Jlrr0yA4kkTFktxzzBeBtSQe/KzxvnIzH29AxO01WWHpoLrqgrT0QcbG+44h8qIKiN9yGRoOXTYPTyUWpVbre2YMYb7PAfn1ITXGVJKv4/MFxwRf5avlQ7zbg4KQGTfinoLbsuyB4uA+S2wikAgc9ccaKlLbPIn7Bip5THEU3GcZZ6YnDsLzDWbhtspYRTFHQyNaU306OstQoJOMJYOXnFh3m48kqBiAVvBaXK6gO0nNiQe8DBOa4HdXSFYhOcQVDb0mtAgkJWEPJjCsnGlvcnHsIXh2suxHQyTOj/pNiSIybF1oGEnKc7mFo16juegiCtQ8kILyi4OP9pzd2MBinAjddI+fjYbFE1XLCfgxV8nYEpT0jVCB82/aqeLehLm63BXjl45/pKk04Q0BG+FxWR6k62HVzNMHkllxO5ShvHzufMU/MC9bmFd92nNmfi5aXi8OFOa/dkfqtQJaG0qzNIyII4SbiOIubcymRfvBMD+8geAdbnyV2eVn8A6tV5CuMztD5osrELffPUw3VumHd7ZomS/NljXZkEYNVc1yw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9fQsrln/R86nTPSJe4WL1IPmQtmw2gQR+b2kvl5k5a7ZbvADIm+8F4oKp31Z?=
 =?us-ascii?Q?KETTlgc0Egkq2IkOJNpIXeHvZDRRHZsHCU5JYwfuFgwZSTiz6AL1+W4vl4cg?=
 =?us-ascii?Q?ERlALujKLKCCXgVKkVSkvOe67Q1pT16eWmezxRFibMQeqVRAw8K9wq2hZIX6?=
 =?us-ascii?Q?NFQKUfjNIS6zlBMEYWBiSPbMTwDnqB1VWW5yj1vd+Xdg8BJTa5a4Ly0U/EOL?=
 =?us-ascii?Q?VkNKpVHAH8xyvdBNkML8EfOO4SKfAB9UBfEoV3C0migjYK4X79OzQBhhMBFQ?=
 =?us-ascii?Q?Oe2oLAXhyEmFMoS+/75ty7VJP05hiOYflwxxFWL2nf2LKQqBB0s5FBKBZTij?=
 =?us-ascii?Q?SBb35eZxHvIUevFo8E2/nK9xoFbN25NaztLqQuIJq3BnLFAR3P2KtWclIYQK?=
 =?us-ascii?Q?vW7ny+ccydNArFy4XmwI2BcISNrgN3BoogcVxC2r6SbXzhHHcjOvIakgCQvZ?=
 =?us-ascii?Q?5W7RLcYj/KdyoSs53ui6pTpptTCgMV6U/2ibnIM0iAnhHNd0ow1Shq03yPKb?=
 =?us-ascii?Q?upllsunWb9KBdWxS4e8qTtsNgwTx+N+7YbOtGSSc0xzjwCmnVc0PWnlGk2k1?=
 =?us-ascii?Q?4fLYNFKrWDteaXttC4/sIcTjSJz/qVxdAGo75KoFoMcJs50k5X5MUo9w3PH8?=
 =?us-ascii?Q?72CrhXTSnAv/oaUZ1CnQhg2kLfkPFVgv+viRVJJCQyyCEQYw1v92Sgs0cOh+?=
 =?us-ascii?Q?oVkDr/jvM1PRGbFrvTs/4fU80ML6QpIEd4J9GrTns4LNWvVbT4TzRf37fcbe?=
 =?us-ascii?Q?XL/nbYcj1CJOH2nn7KfuPQmJmGvXqiQbS/zHRVc1n2253zGcp2DErNqb9AYP?=
 =?us-ascii?Q?DkzWKW2WGIetrIAO6L9Mh0gJymHAiGdaSRZZpiqOmiJGbuWLUS+MtFgEvjEy?=
 =?us-ascii?Q?gQNXtE8fun8USGsUuXNU/bOrBtsVhqqFfA7hgmlNvyLClnyPo7NZa0wxiwyE?=
 =?us-ascii?Q?t73QPdZuHuYclB4NrGj5EtVP5QdA1+NEwx8iCQFkFF7B4Ng1WfQXu8DN7AjR?=
 =?us-ascii?Q?7C+eSlWyxc16CLzE6xuSTZWczbOR8e1WlGYRk7Wsu7VYLHFkvHyuiAGNzUhF?=
 =?us-ascii?Q?PzIzxvrBESsN8wxQkDE65sm3FoXy0dnT+WAu2Vl2M8YGGPLlVArG3X4R1YA3?=
 =?us-ascii?Q?GK0gBkxAdQyvJJGxzddJ/yQkGLEsF41yJl9RR+9mN+2/uD+GLZcIvtMqPe8L?=
 =?us-ascii?Q?s1xsF9sKKQT0qpi1djy7shv6Cym4aYK1HSRWogJakH653ykofjh90Zyv7/ey?=
 =?us-ascii?Q?j3e+aDv3I4MZ+NN/yC3JYXfKuk7BJYrmCUSnZZ+E4sryx7tT/KBwe9J1D4NN?=
 =?us-ascii?Q?+2FvY/Fovaj1vj39gRrRQkKD91bINgwoikIBFz1lynpnfqXpNX6LGz/2eDfU?=
 =?us-ascii?Q?vGpT1IqH5jY5zg+cp3LWCgtcX3LdF+AcWjwYDPe2g7SANdeAqBkkG63/jZeu?=
 =?us-ascii?Q?wtZ4sSLy0ZFiyrINOL/h5t14P0OhHIqoybAmw5IVEhe5GS1MGXmmW1yWdIQ5?=
 =?us-ascii?Q?QuwRmzgkMK9/TZ2A7gmI2aUTyafNn2TQfxUHQ3jvnNiriPdWBZ9AgyO+l44K?=
 =?us-ascii?Q?lX69fMVobTf/9vWtlsoI9xlaZoEpiPxeWpHafE09gGeJEzn+UICyInFuMlek?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e887280-a2f5-46cd-014a-08dc6045d811
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 07:53:47.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwYz3+uffWbtvyM4pq4JNWtzA66Oel3GURYm2/hiOVFvUdb+uAfsKmj0qtwTYEpXBzmadsPwT8+lk1iOvTgUucwBy+k0hePz6KAdEXI4jVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4074
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 07:53:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15586



On 4/17/24 1:42 PM, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Adithya Balakumar
> Sent: Tuesday, April 16, 2024 10:00 AM
> To: felix.moessbauer@siemens.com; cip-dev@lists.cip-project.org; jan.kisz=
ka@siemens.com
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; quirin.gylstorff@siemens.com=
; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <din=
esh.kumar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=
=B0) <Sai.Sathujoda@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=
=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=
=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <=
kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 2/3] swupdate.bbclass: Ge=
nerate swu for delta updates
>=20
>=20
>=20
> -----Original Message-----
> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
> Sent: Tuesday, April 16, 2024 9:46 AM
> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR) <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan =
<jan.kiszka@siemens.com>
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; quirin.gylstorff@siemens.com=
; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <din=
esh.kumar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=
=B0) <Sai.Sathujoda@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=
=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=
=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <=
kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core][PATCH v3 2/3] swupdate.bbclass: Generate swu=
 for delta updates
>=20
> On Mon, 2024-04-15 at 16:16 +0530, Adithya Balakumar wrote:
>> This allows the creation of a swu file for delta update.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  =C2=A0classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 32 ++++++++++++++-
>>  =C2=A0.../images/swu/sw-description-delta.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 39
>> +++++++++++++++++++
>>  =C2=A02 files changed, 70 insertions(+), 1 deletion(-)
>>  =C2=A0create mode 100644 recipes-core/images/swu/sw-description-delta.t=
mpl
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass index
>> 1a7cd4d..76c7aa5 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -26,6 +26,9 @@ SWU_EBG_UPDATE ?=3D ""
>>  =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>  =C2=A0SWU_BOOTLOADER ??=3D "ebg"
>>  =C2=A0SWU_DESCRIPITION_FILE_BOOTLOADER ??=3D "${SWU_DESCRIPTION_FILE}-
>> ${SWU_BOOTLOADER}"
>> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??=3D "${SWU_DESCRIPTION_FILE}-
>> delta"
>=20
> Hi, I'm still wondering if we really need a dedicated sw-description file=
 for that. Can't we just mix in the SWU_DELTA_UPDATE_PROPERTIES into the no=
rmal sw-description? Maybe Quirin can help with the integration using the n=
ew infrastructure.
>=20
> Felix
>=20
> [Adithya Balakumar]
> Hi Felix,
> In a case where I have to generate a delta swu and a complete swu, I woul=
d need a sw-description file for each. Hence the approach that I have taken=
 here. Please correct me if my understanding is wrong.
>=20
> My thought was to have delta update swu as an optional / additional artif=
act apart from the complete update swu.
> In a case where a reference artifact is not provided (atleast in the case=
 of rdiff), a delta artifact will not be created. But we could still create=
 a complete update swu anyway.
>=20

First the question no one answered:
Do we need/want to provide both the full update and the delta update and=20
why?

- My thoughts for **not** providing a seperate delta.swu:
   Downstream can select during build if the want delta update or not.
   One swu is less confusing as we need to a suffix/prefix to the full or
   delta update.


- My thoughts for providing a seperate delta.swu:
   We can easily support the usecase for version jump updates.
   e.g. 1.0 -> 2.5

If we don't need both update files:
We replace the properties section with a template variable and generate
similar to the ebg use case.

If we require both delta and full update we additionally need to copy=20
the original sw-description and do some regex magic on the delta update=20
variant before replacing the template variables - this was done in a=20
previous iteration of the patch series.

Quirin

> Would like to understand if you are thinking of a different approach ?
>=20
> Adithya
>=20
>> +SWU_DELTA_UPDATE_ARTIFACT =3D
>> "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
>> +SWU_DELTA_UPDATE_ARTIFACT_TYPE =3D
>> "delta_update${@get_swu_compression_type(d)}"
>>  =20
>>  =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>  =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>> @@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?=3D "cms"
>>  =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
>> "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>  =20
>>  =C2=A0IMAGE_TYPEDEP:swu =3D
>> "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>> +IMAGE_TYPEDEP:swu +=3D "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if
>> d.getVar('DELTA_UPDATE_TYPE') else ''}"
>>  =C2=A0IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-certificates-key' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>  =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl swupdate-certificates-k=
ey'
>> if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>  =C2=A0IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> @@ -44,8 +48,10 @@ IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>> bb.utils.to_boolean(d.getVar('SW
>>  =20
>>  =C2=A0IMAGE_SRC_URI:swu =3D "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>  =C2=A0IMAGE_SRC_URI:swu +=3D
>> "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>> +IMAGE_SRC_URI:delta_update +=3D
>> "file://${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_FILES:swu +=3D
>> "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>> +IMAGE_TEMPLATE_FILES:delta_update +=3D
>> "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>  =C2=A0IMAGE_TEMPLATE_VARS:swu =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_ROOTFS_PARTITION_NAME \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 TARGET_IMAGE_UUID \
>> @@ -58,6 +64,8 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ARTIFACT \
>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_PROPERTIES \
>>  =C2=A0=C2=A0=C2=A0=C2=A0 "
>>  =20
>>  =C2=A0# TARGET_IMAGE_UUID needs to be generated before completing the
>> template @@ -148,6 +156,22 @@ python add_scripts_node() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_no=
de)
>>  =C2=A0}
>>  =20
>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_swu_delta_update_properties"
>> +python add_swu_delta_update_properties() {
>> +=C2=A0=C2=A0=C2=A0 delta_type =3D d.getVar('DELTA_UPDATE_TYPE')
>> +=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =3D ""
>> +=C2=A0=C2=A0=C2=A0 if delta_type =3D=3D "rdiff":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =
=3D=C2=A0 'chainhandler =3D
>> "rdiff_image";'
>> +=C2=A0=C2=A0=C2=A0 elif delta_type =3D=3D "zchunk":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zck_url =3D d.getVar('DELTA_=
ZCK_URL')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =
=3D f"""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain=
handler =3D "delta";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =
=3D "{zck_url}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zcklo=
glevel =3D "error";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0 d.setVar('SWU_DELTA_UPDATE_PROPERTIES',
>> swu_delta_update_properties)
>> +}
>> +
>>  =C2=A0# convert between swupdate compressor name and imagetype extensio=
n
>>  =C2=A0def get_swu_compression_type(d):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYPE') @@=
 -166,14 +190,20 @@
>> FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-
>> core}/recipes-core/images/swu"
>>  =20
>>  =C2=A0do_image_swu[depends] +=3D "${PN}:do_transform_template"
>>  =C2=A0do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
>> -do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>> ${SWU_BOOTLOADER}"
>> +do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>> ${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
>>  =C2=A0do_image_swu[prefuncs] =3D "do_extend_sw_description"
>>  =C2=A0IMAGE_CMD:swu() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*=
.swu
>> +=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_UPDATE_TYPE}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${WORKDIR}/swu-delta
>> +=C2=A0=C2=A0=C2=A0 fi
>>  =C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
>> '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BO=
OTLOADER}' ]; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_D=
ESCRIPITION_FILE_BOOTLOADER}'
>> '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>>  =C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 if [ -n "${DELTA_UPDATE_TYPE}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIP=
ITION_FILE_DELTA_UPDATE}'
>> '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
>> +=C2=A0=C2=A0=C2=A0 fi
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0 for swu_file in "${WORKDIR}"/swu*; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(base=
name $swu_file) diff --git
>> a/recipes-core/images/swu/sw-description-delta.tmpl
>> b/recipes-core/images/swu/sw-description-delta.tmpl
>> new file mode 100644
>> index 0000000..7f7d623
>> --- /dev/null
>> +++ b/recipes-core/images/swu/sw-description-delta.tmpl
>> @@ -0,0 +1,39 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com> # #
>> +SPDX-License-Identifier: MIT # software =3D {
>> +=C2=A0=C2=A0=C2=A0 version =3D "${SWU_VERSION}";
>> +=C2=A0=C2=A0=C2=A0 name =3D "${SWU_NAME}";
>> +=C2=A0=C2=A0=C2=A0 ${SWU_HW_COMPAT_NODE}
>> +=C2=A0=C2=A0=C2=A0 images: ({
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
name =3D "${SWU_DELTA_UPDATE_ARTIFACT}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devi=
ce =3D "C:BOOT0:linux.efi-
>>> ${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=
 =3D "roundrobin";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${SW=
U_COMPRESSION_NODE}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop=
erties: {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subty=
pe =3D "image";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 confi=
gfilecheck =3D
>> "/etc/os-release@not_match@IMAGE_UUID=3D${TARGET_IMAGE_UUID}";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${SWU_=
DELTA_UPDATE_PROPERTIES}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha2=
56 =3D "${SWU_DELTA_UPDATE_ARTIFACT}-sha256";
>> +=C2=A0=C2=A0=C2=A0 });
>> +=C2=A0=C2=A0=C2=A0 files: ({
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
name =3D "linux.efi";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path=
 =3D "linux.efi";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=
 =3D "roundrobin";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devi=
ce =3D "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi-
>>> BOOT1";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
system =3D "vfat";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop=
erties: {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subty=
pe =3D "kernel";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha2=
56 =3D "linux.efi-sha256";
>> +=C2=A0=C2=A0=C2=A0 }${SWU_FILE_NODES});
>> +}
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20
>=20

