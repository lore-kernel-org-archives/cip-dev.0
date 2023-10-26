Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86DDC25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 10:17:25 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.82])
 by mx.groups.io with SMTP id smtpd.web11.67279.1698315442908130415
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 03:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=aL9BCMdL;
 spf=pass (domain: siemens.com, ip: 40.107.15.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgLye06IBq4rzvTF9g8+YiA+tXkb0Q8VZ4phqg9/FwxLWhiHDZaYmTdlw/IkNvmDJcTNePnMtRUI528+B0KrwUSB6TlIflQpcyZFQXv/FwmUaG+TU/FweF9ZfvrO1xkTpxKXmwsPK0NIXCmil9LA+CdOVejj5H+uDM8sOPjRlqrEwvMrRuZU+WW7Oewg5RzsEWsSErzEyUEO2zPYQd10yKZGcgNXldJFGOYrQROqw2xsK8IsCWQ3klC03JpGuGbCqgiMQmfFIOza7gfb+0LEW94RrQvK0L/7kjc3EmOgghAcXZhaZWJ150ZpswCl/+3QOyta3Rr8kyk9YT+wiH/TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4YBSDcqcffR6XhhhmFvXTgKPCVBBefIlqPEiII0z3c=;
 b=ItvhBJpVX4rgXU2ZcLlOyKs7rjnqt81AV5xDT1l6g547CWob0eZorQu3LRnYM5PrAmKuQGTm/1b3kMm1WJPtXZv1/qQf+b45XlNZX+m71zuu51c4Ho7TMtA//+fcBJvUyREQ7JCvn7zKEPojAWod79ub3nT9mDaGM0v3UJa7hBhSGtjWUu5/xLdOfMA27Y9TYFek4Cge2EJxiOtt+4w1SokfFt/pIHXhePm64C+66WmoamAhgHmzdIT4Ghnhk+zI3fJtbzByKhL+uMdDzQLOT4TaFe/6I3LVOeIf6QVb4crnj5G1mI38IdK7hdtA+AK9SFZD0upTR2djGfc/6C+j9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4YBSDcqcffR6XhhhmFvXTgKPCVBBefIlqPEiII0z3c=;
 b=aL9BCMdLCiWbXX1N6tGYp6oWjSPFJ4GRsjpirzYqUghTrIQAqt76lgMcyeT906PCC7NgKOyCXvtbjYEKa0xHbg4ij9bjJcbrPjAkxdo2ocP2prHVcJT1ClfvtS6p3KPVbICdH/0YcNMRwS9wVmA42kKTgpPvnQPua3QN6EHhGLmN3YZGME4Kmsj6GnaVfV2NLs8x9GIwk6VEHe1uhPSQZTsg7N93SxUVlU45hwhZBDIO0Tai9x93sWulZD0Vj9rwxn2zUfcNw99aa2O50vSt6fUkHDUksYU6kLFUw/28rEZ1FgJfGW8FLO8RX2gctuMNtGyXXsK6fGQa2I7hn3gSWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.32; Thu, 26 Oct
 2023 10:17:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:17:18 +0000
Message-ID: <b75e66fc-ed3b-4890-8f8b-bca92c1be296@siemens.com>
Date: Thu, 26 Oct 2023 12:17:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/2] README_version-release-policy.md: Add product
 description details
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
 <03e48c84-2497-49fe-a61e-2e1fe6b95251@siemens.com>
 <OSAPR01MB49456019A81DE8EA4D79E820C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB49456019A81DE8EA4D79E820C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:610:51::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b41ec24-7f4c-46d0-e153-08dbd60cbc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PDL6PTTyBLj3fk0yMq81GkV91jOTZFVsG/eqgIp3g5mhBqvxSF4Cqh4PVVHm2Svo7CSx7MFzuEyA0CVMLq/RLI8inaQpr0tVWesWSZ5Ki94fHppkG4pKvQY3AbdV22Sp4c7hARrXvYdV0v3hYsGApev2UKXmSpYP/gL2Q7iMw3vJs7zcg5ccixQgcGNeoqjq5rIwKCluyeUFvYxKHQX0/rhHkToUPszQnH988aLSnH7iI1OBexXp+S4qoSqMTAov09FJqwczaZil1W4awcUoc9WhT7xcPDccJslqOcrs3S7tfsrszAJlypNJ03Ahf7v61rP8ULE7xch2JgsLsy5Hhl3Taf4tfumz6MQWTxVQaW3n4n2tJJt0PAdef8p04BMEro9f1NXdynWHiwORSnlJqSITv4YglSHfrQbp6hEk9ql5O5vdDfmrtK0D/8L1T9g/rRNbihsfnUmMMgS014NHcOVUflERu8BFJwbKUQ5LAHgpxF8fbig/UGpHg9/mxDbaTuh34KPS1PojK1c8t0RnftJumGy6RfG8PMZhMhePEiRtmxxoQGqtgW1ZFjE8lHJ+M99t/Z8BRECEs3zlO0ds3tTY7Z4W+AFE5v6bBGSlMfPXY5mvBmTfFfsfihza04f28Nwl2L17sEoL15VMspEHOuveiwc7sKH1HQqykGkCKxY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(36756003)(2906002)(38100700002)(6506007)(478600001)(316002)(82960400001)(2616005)(66556008)(6666004)(966005)(6486002)(53546011)(6512007)(83380400001)(44832011)(86362001)(31696002)(5660300002)(4326008)(8676002)(41300700001)(8936002)(66476007)(26005)(31686004)(319154004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DTmrZ0O6W24lPtdOAmLmif5Q12fTcSNEc6CROaudYA7K+1uaXbjEXSDpRIwp?=
 =?us-ascii?Q?K19KK6h3k9kvBvx44+G9hj8OqrQ2SiCAcVx/m//08dzl0ni1n7b+XNMrhA9K?=
 =?us-ascii?Q?RK7X5qya3+TKww6ZYG8q8+T3Reg5nDRCBPQWabpQqrL4jwtFQE7MIUMjtP3R?=
 =?us-ascii?Q?c8f/NKZ27oBDWWV7uFZ4l/L/E05e/PXrPPZvrR0jc1c4VYjiBctG5485K0l3?=
 =?us-ascii?Q?HrZ3wcN4XeJj335Nk8PtotiJl2sjc7Qso9eRVx9CMAox3O8QBTw6MOyidKU5?=
 =?us-ascii?Q?QFoT8w1GUGnVfqZ4FXaYULMX+4/nQ6Ic4JBMmHIQ2V54/MPmeR+/PNttStqX?=
 =?us-ascii?Q?+GSlX9AlWGXj73m2BjCaaoSaBvH2xapbIu6rNdFIKFgKvhWD26unWPftIt12?=
 =?us-ascii?Q?MPO18FFfRnCDsXSjUFd28C+Gn8kVUBk7u4gOqZrBOe1hN/AF9Ofk0lokCXa8?=
 =?us-ascii?Q?O8ns7ztTAKeb+4/q6YhihGsiD9IXwdUH3bGUbl2uezveITqNpAPit3BtYGxk?=
 =?us-ascii?Q?KUAeEG3zyX7eV5yjhxMmD5H8agqRrrCDlgQOJXWqqHcy+O3cemIA61A/Q75f?=
 =?us-ascii?Q?ne+uJH+8YzGHz/XW/B5zkRKnVQRF5ukFDr9jbg3WO/Dt6DbVTJRojEVcOFVm?=
 =?us-ascii?Q?Jgl+5cnoWV47zLYcrysGoLr4WZFuH6IdgziS4Brr5JDiPpXc6OVuHZe+tzWI?=
 =?us-ascii?Q?YABFCRNdyTtGPsBfjNN3uCHcyIib5JtQKwdDnVvstH18Ga+fo3s8HORU7/KT?=
 =?us-ascii?Q?DIxno1NCzMVVWyGyviP1aqzcf3qGWzGDXprGR2pIjN1Fxh+cdIsym724Dzi/?=
 =?us-ascii?Q?jXH2Z4e5HY6hyOzj12YGkIMN0XkahCeDGGxuv7mj5tyXI9ibWY0UaazAJ9Wn?=
 =?us-ascii?Q?q+U2oG/7NISeS4RZKGZT3NOgfuUMjdMXZA4AZ38EgO9LbgqqumYajyqeQi7m?=
 =?us-ascii?Q?svXZfD9ozPfySedYXRzLs5oksQD9adH2itJfrimp4Qsrj6aqJJ5ZZtocxfu2?=
 =?us-ascii?Q?kk+/KbpkEtyJDNSJk1ljwLOerulp1EO6cYf+6Ow9s1riiO+0QgCZvyyTNRxF?=
 =?us-ascii?Q?w9vSoLahV2zab10mNs+V/bgWVXFGOORkGnci6cvDMUCij1rsIkf4QGpReE9u?=
 =?us-ascii?Q?kfRMp82VYeq99FK+zxdN7Z3AJkmE0JuxqbBxgjXQg0WTyc/2RhNdMGPd6cWK?=
 =?us-ascii?Q?hmSwPpR1672dos+Q0VfNeICHQ4yUshOoCDPTE0D+UhAZlsb/DhdwS0gctm92?=
 =?us-ascii?Q?gKEaPTBjkdc5DX/GnDMTzBU4EDjO8e+8xz8FNjrYSt5cE6pOQxFb6HAXlUT5?=
 =?us-ascii?Q?VHEyUqBPJkAfN74Cz2xMTp6r/9Yfyyl1+AjtLaX1SOI7PMuMb8WFLhcZMGF5?=
 =?us-ascii?Q?yfLYAWi5pJqrKM8ItAZKjr+BqSxM1nEfPimpHjzDf7DLeLU9KKRqo5J4cm6q?=
 =?us-ascii?Q?otTBq+ukCUDYMgXVOdKKNK+zzUQjD7uFCD+jMfPXSdSukDE8sDsFjqOoHeed?=
 =?us-ascii?Q?2bso76wT6XTlid3AjN3Fah9j8ZYFdr/apymQQa5kkV3MaQdwfeKu+40OFJrR?=
 =?us-ascii?Q?4cAVyutTDibc9WQmBJuZ+6fpYcBJw0bvOI4Q+z9v?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b41ec24-7f4c-46d0-e153-08dbd60cbc20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:17:18.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9T0ozqbGuEuhfoBgu9LlIfSdAmmzb7jmK6pQ3vfRG+axwY4F7ZXyq1G3OI4wTIkgEOr9RgW5MtjhoYg/aftwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 10:17:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13463

On 26.10.23 10:56, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> We are thinking that this description table will help in Configuration ma=
nagement as well as in future where one can refer this to know the features=
 for specific release. This will help to create images of their choice.
>=20
> E.g. version v1.1 meta-data is used to create evaluation images with some=
 specific features which might have been deprecated in future point of time=
. Later when someone in future wants to generate an image with those specif=
ic features, then the information in this table will help.
>=20
> Please provide your opinion, Jan.

All fine, but please don't duplicate existing efforts (git history +
announcement emails, existing descriptions), augment them.

If we want something similar to [1], let's propose / discuss that. But
recording the obvious information that buster-bookworm and 4.4-6.1 are
supported (kas-container menu...) in another document is not improving
the situation a lot, rather creates the risk to leave that document
out-of-sync behind after a while. In fact, it even fells short on
describing the actually supported combinations (KERNEL_4_4 depends on
!ARCH_ARM64 && !ARCH_RISCV64).

Jan

[1] https://github.com/ilbers/isar/blob/master/RECIPE-API-CHANGELOG.md

>=20
> Thanks and Regards,
> Sai Ashrith.
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, September 1, 2023 4:10 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core 2/2] README_version-release-policy.md: Add pr=
oduct description details
>=20
> On 01.09.23 10:19, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>
>> The Debian releases, Kernel versions and image features supported for=20
>> repsective isar-cip-core release information is added.
>=20
> respective
>=20
>>
>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>> ---
>>  doc/README_version-release-policy.md | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/doc/README_version-release-policy.md=20
>> b/doc/README_version-release-policy.md
>> index 918e77a..f8dde38 100644
>> --- a/doc/README_version-release-policy.md
>> +++ b/doc/README_version-release-policy.md
>> @@ -4,6 +4,7 @@
>>  1. [Objective](#objective)
>>  2. [Versioning system](#versioningsystem)  3. [Release=20
>> policy](#releasepolicy)
>> +4. [Product Description for metadata release](#productdescription)
>=20
> We are not building products in the CIP project.
>=20
>> =20
>>  ## Objective <a name=3D"objective"></a>
>> =20
>> @@ -28,3 +29,10 @@ The isar-cip-core metadata follows semantic=20
>> versioning system i.e **x.y.z** form  An approximate time gap of 3 month=
s is taken between consecutive regular releases. During every release, CIP-=
Core plans to give out recipes (isar-cip-core metadata) using which the use=
r can build the flavor of their choice.
>> =20
>>  All the releases can be found [here](https://gitlab.com/cip-project/cip=
-core/isar-cip-core/-/tags).
>> +
>> +## Product Description for metadata release <a name=3D"productdescripti=
on></a>"
>> +
>> +| **Metadata version** | **Supported Debian versions**   | **Supported =
Kernel versions**                | **Features**                      |
>> +| -------------------- | --------------------------------| ------------=
---------------------------------| --------------------------------- |
>> +| v1.0                 |  Buster <br> Bullseye               |   4.4.x-=
cip <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-mainline  | Flashable image =
<br> Security extensions <br> Testing extensions <br> SWupdate support for =
root partition <br> Secure boot <br> Encryption of data partitions  |
>> +| v1.1                 |  Buster <br> Bullseye <br> Bookworm | 4.4.x-ci=
p <br> 4.19.x-cip <br> 5.10.x-cip <br> 6.1.x-cip | Flashable image <br> Sec=
urity extensions <br> Testing extensions <br> SWupdate support for root par=
tition <br> Secure boot <br> Encryption of data partitions  |
>=20
> This is like a mini changelog, in addition to the full changelog (git
> history) and the release summaries. What is the purpose if this table, wh=
o is expected to read that?
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


