Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30837EDE983
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 06:19:19 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.42])
 by mx.groups.io with SMTP id smtpd.web10.5866.1694672355699911491
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 23:19:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hK4O/YOZ;
 spf=pass (domain: siemens.com, ip: 40.107.7.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5pKLxlP1NfXSwkT69prnw36eiflOJaE+Hczapr6pvobc7kasM7kgit0TsMUt3lb4mZI2EuDX/GzpinFz8RSBVDbP3Ke2BCm1GqkZ5HXeo4Cl5vsMzFQvIOj8chuag2sqXmxmvGeX6YDwLUdCfpHeiyPAAONkNXUaHxkKiJkQiH3vC9cDiJEAs3/hFqpMFrtIrifKXC4wkUAWzC1Fa4GQ/3M4UBQtfRPsNk2pUWBLHEdVgpj0x0Gsc+gZxjnhk8i9ecgpy7fCBjA4Vy7iFviSx+GeIt9c5i2BnZ+vowuxcHo//Rz8bneCS/0PiE3e/GLgNC8/07xzpRDYhhrsQIMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQgPVShHfR//m/iZ9GaR83zRrrcrGV3xPfFHB2lp1Hs=;
 b=BAxgBzng5ProtuNptwk+qjIKe+BIJaQXnyAC0CiBIAUpiU7IFPM6GQHLcJ2g348A1162XEOsZza4gthpwUf4tVIJjr7zYl4QopNoC3NBAQGHFEfGYWQODJctes8u1Vbj4LBkrlfjQWSDLq0WQv4staprp84Nb3o79k5qjtRW3CBM5E/xcDyrOSrjpdur3wGcEb3eqZVhWbQkRAKmrqyqkyVolye3wHVOrlIPPuJl+Iiixb+y8PZ2AkzXJjsEDPCXF0f0JdlHcDulVk0BSC0R0nCYoptEBMEwcZQ1s/I9NAhRRVUX9ytZRc1e/3zfV+rf4WClt/ufRLk5h8B4H5abeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQgPVShHfR//m/iZ9GaR83zRrrcrGV3xPfFHB2lp1Hs=;
 b=hK4O/YOZIwMo/REmYzCux4dbL2NADs1l8iRwF5PqatUvefd3rt+lno5fki2DK1mQI4u012lg4Gjs07zZuGNd247adLZqvgHchkGyWwdjmdJYAFW2Q3alIvyk7uOb6/p/qBjzsVZ+VmVIbJD4G3q8zBX7dInQwA+Zee/2YToaoGxEZOoez1mgfUPHAxh4uxQ95WeIQLxIqHOfEKHrl9q56RLqJfEwkgC7Ol4vQ49E848ptqX3uMr+ee93vLPS4CjK8MnYujN1+r7mIIvZwPsx/O0j194n5QdgV8bX5byRNi3Ud0pEGXqiLGQrHpT9ISddBgvHPWk72JCa3wgrznXUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 06:19:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 06:19:10 +0000
Message-ID: <8edec13d-b14c-437e-8a9f-f7feaba2a6ce@siemens.com>
Date: Thu, 14 Sep 2023 11:48:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
 <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
 <0d30d88f-ee82-4b56-9453-85a7e1832242@siemens.com>
 <OSYPR01MB55422F888CB0CFC373E89496A4F1A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <1729ac64-b891-4dae-b723-1e009c92d66f@siemens.com>
 <OSYPR01MB5542F9FA4966AA0F34736826A4F0A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <4062dd3b-77c3-4ff5-a7ff-a195f35b9e12@siemens.com>
 <OSYPR01MB5542D6B290CDC9DFB4C06E11A4F7A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542D6B290CDC9DFB4C06E11A4F7A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 43309a56-16c1-486b-ab14-08dbb4ea81e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tneeB1x/tFkEGGjsAO1bwOArfoe9L+DAFm3af6QzwuxbjL9dnoYS9/oxPEQoxCIbjaIX9RaV1pnuxBFLS8r83XZ//RO8fbnASAsrcVvohI9Pyqyxnhd4sIfzuMMn4J4nOpR038AEYL5S1Gm8tuo24QcYTnzjhLlEsTzIJGzSJyXIpmxnwN4TeDeqbXNnqjrsszFFmcDPpWEHkWlTb/thIBFBYptnvbSRz25j/JnyZ+0H4bahJ29JcbIEI1hlecgccEJcXcXNFLx/DfYkSmH439xDCrctcKl8OVIOsvaT+K099K6mldERovVkShZK/XhaSAVriXc/m+U+JTVFISP80fzsrauLUg1aCL2A/qHHrz+fQkMoZEk23blzjhuTBZ6WNxV7rTWqT6oaolF84Oa6rTJC6K9Ujso08nF2UBVR3E/z4W+cbI2mxWPRxVCVb02YHUay2TnTaH+4iMrW9HP7oVj+ekObqi3I2+1R/v3ksvo3NMuTUAel0iv1lNEMpIRN9Rw15+gYLGVM9OvJid1GVAPJlITP28h+0c+UTC3Ee12Liw1aNwX4rJ5gHJfHQTKTc0VjvDT0dhAf9U0tBiacSBDBvn+Tq9x7pZzvTWiNxWVO5YK8buZ3kcJy+Jzc4fA7dvv/nF0FJZMkWqya5bfcWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(1800799009)(451199024)(186009)(5660300002)(31686004)(6506007)(6512007)(6666004)(53546011)(83380400001)(2906002)(6486002)(31696002)(86362001)(36756003)(2616005)(66556008)(38100700002)(4326008)(26005)(82960400001)(478600001)(66476007)(44832011)(66946007)(8936002)(41300700001)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ix7toWZBvXUthT6eoQetR8+zpA9BKJchmZjsoEGQbBDnFiMd+hsky9MYmeVD?=
 =?us-ascii?Q?5BO7cZbxvckatEiarUrEBRsAt4UEtsdwFLvKfzsP2xhK0O9W5Y1bkcKgdbCk?=
 =?us-ascii?Q?3KQjRJO3qiOSZs9+h6HZdUkoOQWuV8DjwpKVFc2wp7iJBG15D/V5ng8lzOjn?=
 =?us-ascii?Q?Kj3g2MRe3strsUiWz/zZTU5eRc60f42cNqhEEnqgd2+mm15RCLnSEhnuZl2J?=
 =?us-ascii?Q?oib9TYifNtrIqIkpehPTMvo7U3yK2ngvvS/Z2ze46fpi9fISUdCPfzi2YqeA?=
 =?us-ascii?Q?sP6R+xj30eqqEML6yKhsw7ecg+WsSch+tRtQe8ZRCHZ87jIdIzK79cGo6Vr3?=
 =?us-ascii?Q?hX9ATHzujAkRi59elF/Oa2nUqHJWyhK+vO5zfISSrPUw1z4iHW6bYXh7rURD?=
 =?us-ascii?Q?aipTI2fBUGTvFSk4rouQ9/zQ7mhBQNqBqlBG6rn58GJNIVmmR0dB4+hjN2HY?=
 =?us-ascii?Q?x86TxbRUhV7GriwXWxKUIcVovM11e+YHN7hsDujX29VsDMxF2xkHgdS1DroB?=
 =?us-ascii?Q?UGmRrpyxdO3cY6uQtP2fX/2RQM0t4Spljr84ZmjM/xM2heajcxBbnvpBmwLd?=
 =?us-ascii?Q?Qjg5F1R4GGgWbe+gE0eZZLc9oHyW+nKFwCihrJw26aH//9+VV6DcRAm5YC51?=
 =?us-ascii?Q?94dA/wxsYLe8Vl2Um3eUSpUpzJot9wLZsr7I4iZ6Yih+Iryz52ApD/Q6T3al?=
 =?us-ascii?Q?O3mSF3dJmO1QzLde++Pi9Lron34JjeEJiJs4BCZ/CWY3Llp/YDmaybV1rgP1?=
 =?us-ascii?Q?n6RpQwq1rwu25L/3/mi3W9GBrZ7VxbxbFYd5o9k3d9NadtHjz+ROMJqkEaoX?=
 =?us-ascii?Q?WfNuYswOBY0p3OM+JtpR/z3VAcBfZGhj1MvJ7/Ld2sM19/fY9qW5DwTwokE3?=
 =?us-ascii?Q?17laqxzF8ABAKLrslN8cNROpH2jZhLficRNOvIHUoylehb57ZprfisfrNPjw?=
 =?us-ascii?Q?lhT+/Kft1atGdx25HETx9OM84xONCflmiBeic2T9eeOwIoqUjV1c5WHpLngx?=
 =?us-ascii?Q?8gs5mIRFwMXlDflQCIScBl5yENfuHseeNMsLnJQ75KrcLOnhdGvhgqYfo5zn?=
 =?us-ascii?Q?maEDHGhs9Vlxpsq2BydSbVszJ5KIsNGnJVyP/Juomn/oqFyw7cbrv4J+DHQ+?=
 =?us-ascii?Q?Uv0vv+yAE+Z2EOFMmo8/4hH/UE3KVvt2Sja9S4MySgaY0jDDcQ3dx5+2IQbD?=
 =?us-ascii?Q?LNLLOud6C3C6yn3z9AGT7+Vze9/aOc2dpz8DAsvF4H6lgXU5LLDpxx8eNM07?=
 =?us-ascii?Q?rcnuxANKpuLRiLG17qENB0xEI68WHyDMm12IkKwkJFP1bTothQL3hg31A7Tu?=
 =?us-ascii?Q?OYgngPaXiDqKP0ZzhlIWj6oKvmM4rV6oW9lfFUkvnCKNvsIkL/clLL5sLbZi?=
 =?us-ascii?Q?+So94UXRNUIE7fRN6PIktJERaKBx+UK+YCgd0QXABqres5Ym1/BEQqcIZ7Xl?=
 =?us-ascii?Q?efOB0G0ONsdubhVQQ/RfYeQ8Wy0JXDaa0G57sRJGFKqvXUL4tQfq1RD8zuem?=
 =?us-ascii?Q?T8CsxntzipWCT4Mf22nkfvTGNOawD2kLQZ7h4doPYrEmLQo20Bg6gqv7tVrF?=
 =?us-ascii?Q?9VjTXRDH796c0Xl9iWT3N2CE15qkW18QWGwAvHlXATfFu5qY5kTswqrOn8R+?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43309a56-16c1-486b-ab14-08dbb4ea81e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:19:09.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7xDKrDCOIXU4l7SoSCGFF/244tJsQ/zHeHEYfkV9oLMc23Yxq+AsBLOuIMThW/DVOhjgRcBmbClpGO6kCxh0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5653
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 06:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13130

On 14.09.23 11:44, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Thursday, September 14, 2023 11:23 AM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB tar=
get
>>
>> On 13.09.23 09:37, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Tuesday, September 12, 2023 1:20 PM
>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Venkata.Pyla@toshiba-
>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB
>>>> target
>>>>
>>>> On 12.09.23 12:22, Venkata.Pyla@toshiba-tsip.com wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Sent: Tuesday, September 12, 2023 8:39 AM
>>>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Port=
ing) <Venkata.Pyla@toshiba-
>>>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Port=
ing)
>> <dinesh.kumar@toshiba-
>>>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=
=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=
=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>>>> Subject: Re: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add
>>>>>> BBB target
>>>>>>
>>>>>> On 11.09.23 19:01, venkata.pyla@toshiba-tsip.com wrote:
>>>>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>>>
>>>>>>
>>>>>> Which additional aspects of reproducibility does this target test?
>>>>>
>>>>> It will try to verify additionally beagle bone specific files like
>>>>> MLO, u-boot and
>>>> dtb files.
>>>>>
>>>>
>>>> OK, so this includes firmware generation, understood. Does it also
>>>> include something that is now checked twice by other targets? I.e.
>>>> can this supersede some other target?
>>>
>>> No, the kernel is different because it uses different configs, rootfs c=
ontents
>> also different as it installs additional packages like u-boot-script and=
 u-boot-
>> tools.
>>> So the bbb target image contents are not verified in previous targets.
>>
>> So far, we are not looking for testing each artifact we could produce fo=
r
>> reproducibility, just like we do not check each configuration combinatio=
n a
>> user can select. Instead, we are testing representative combinations. So=
 my
>> question would be if the BBB can be sufficiently representative for qemu=
-arm
>> specifically.
>=20
> Ha understood now, you mean if BBB can verify all the contents that qemu-=
arm can produce then we can drop the qemu-arm target and use only BBB in re=
producible check CI?
>=20
> If this is the question, then the answer is "No" BBB can not represent co=
mpletely as qemu-arm because it has additional features like secure boot an=
d encryptions are not yet supported in BBB.
>=20

Good point. Merging this as is.

Once we are fully reproducible, I suppose we can drop these side-checks
and just add them to ever CI run. But that is not yet in reach,
unfortunately.

Thanks,
Jan

--=20
Siemens AG, Technology
Linux Expert Center


