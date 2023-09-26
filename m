Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DB0E7D26E
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 09:19:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.40])
 by mx.groups.io with SMTP id smtpd.web10.14989.1695719980080619258
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 02:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AUuIy/E1;
 spf=pass (domain: siemens.com, ip: 40.107.20.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeVVOruZ9YUiGmmMWsBAhrrkvZbN4/QAGRoDToW2vNcSDPLdyQpU7II0o/tCm81a4YURKAYbUEqVqrr+WBDY/KWMAK4mHXUTSWEz7/ie15Ze9h2537DwQMxwPy5LCxFxuTnUFejy/yRbTnQstONdz+yEE4FbSGIm8kCq72RpEI143U0Pn8+X15fjIm2Ii3tcUmP1JCOWlJYdOASB1B9Tpdzv8mjhwhNqbhH75SSdy1VF52HRtCoHZ/VHRgfI+gHhyw5HVhsYEflAkthl47WQfVtIKjCN7YcDPvtg/+lulX1QhJMhHwjqafhmBdbhuaC2fk/7Uhs44miJ/DBLL1kI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Topyw0SVydEm9VtnFTqLMQU96B50kNap+IG24zsfch4=;
 b=HxXlLm+EqQTSj3EApcarBf5PRqmPIxxb0WLt/P3IWM6nqad856e/aZ9NkwqQ+rsDzA/AQJUa03VSVtcfzQ0Ka7UFwZGlyMjVVnq4L9XlRs5a5IZILRlosKhosHN6xXl7RuhKZWvM4TJuxktxRuhO0NBcMKccfcdLXnyuByC6cyowAgpLggEf06RlSdvbxGhNquUGYrRSM3Zr2/gbh0go192pXztnUPRL8u+Q2terhf8BTAEdbVaBOy4/vacXZsEAGkrHtigL18MpZD8Tx2DiCD9KQT5jf56LEmD3G+jBTvWwopQToeJIONLyN+CK0XrnwTeEY7VWHC4Z99uxMjigZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Topyw0SVydEm9VtnFTqLMQU96B50kNap+IG24zsfch4=;
 b=AUuIy/E1cn9UnB4Z45Dr+ExSRj8TOwT5kXpMaBtlhVQvGnO2SCxc3BLrJWwq5QCWZR2JycJaRn6RFMH3PBWB9g8geYOhf9S24QHOSN4dDc9dWW3y+vO1YV5lLGz/AJWCU/9MWQEi0MgDQ4taNL/gfV/8DPZILYfCjDReKlffITykXfSMJ3NjSB8A9CEWWTV0s3KRUnWvta1udwlJafg2onUBmnEIc13yEJ6GAaF30B6nc6XNcEOIokGnk61ujtb8XKWD5Go05GHRMpZBCEQwKRkWMFFWc3xOuAc6ReE1oguLcuzZEleUbN5IDGwvl9S0s1Uly3gV5KB/k4BAcWOOfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 09:19:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 09:19:35 +0000
Message-ID: <e59db07f-58e9-40d9-bc8c-1d9d5c530749@siemens.com>
Date: Tue, 26 Sep 2023 11:19:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
 <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
 <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
 <OSYPR01MB5542F6668A8E93B4E2A1E290A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542F6668A8E93B4E2A1E290A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d92159-d49a-435d-1d31-08dbbe71b3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qPE3iYyOD3KGBy5zhM+V+tuMci0/sZwZAez76cWUl+yFJLIss7I5PTUICQBwBADtL9DLSQDzxvod8Wl0YC5TvEJQGIZssNs6+9r8HludWHJCVWnHefeRdm9iQH50iaBTeH22Ob2V+oPnyLM3SB80nnPvBLVEJUWARIGsSmMTXc7IoRSTGMAM7SFCX1VlbKO98EoFBzcfw4vkSaoj6aWSJ7JYe2aKZBtkFbTUvhqtxVgGNlV1BRUL5GLuM6zlAh5uTQd6+L7FPseQurGoXWxkyl9TYcL99fpAIvtnZci60SH3SSjdCN4t7Q0z8uJE5oW/ErYlpet4BuRpnT6pE6472vMZLlCgirItloeE+aEmdffO2CxCa7mfcNxo4WTD3mh1Svy/LAPfzmhWcqinWBOxUMq/nUlLb96cVrC6ZQ71Xm9+8su5Pvj03xKLBujAcOTlzB7UhZanxxSb66d3CvJvWu/oUW69mRI1Fe9iFY8osZk2OYgu0Vezs9dF6m9yOamt/RGLXntHwQOC/B2SFnJJiywyAVt/xCWH7hEkvMHRbhxKMo2OH1Ti+Kp55Cbl2G+Ra8ir+O9iksOYu2t63FOQNbG/YU1VTHkem/eyZCSDoR1bAP2FsoHKoDauR+lfyW9uJMY4W9zRnqFPzFj72+PKmw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(82960400001)(6512007)(6486002)(53546011)(6506007)(6666004)(26005)(2616005)(41300700001)(36756003)(316002)(66556008)(66476007)(66946007)(2906002)(8936002)(8676002)(86362001)(31696002)(31686004)(4326008)(5660300002)(44832011)(38100700002)(478600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vdcgEf/UO8rVnXIKW0sINzKTUGlbPCdBHXI1EXrRrcKjStpryMNkpqn1H3QT?=
 =?us-ascii?Q?N0mV6uvODV6ppeHyT/+gA+R9l95DecPdfVcbQXevdeeVYhJIu9IHlKEiywIM?=
 =?us-ascii?Q?ji5q6cxxQRGn6T8bKY9GI+HpwcdgEY5UeyCQWnxfnfjUKDJWNzrjHnmtn7uT?=
 =?us-ascii?Q?o70zRoH+b7bMpX8lDMleTE+Nba23Q7x9cFC4HmtmofHqW6ENR/z8y8RXg9yo?=
 =?us-ascii?Q?2KA0iKgbJettS2X1cLDmrsMNMLn+MT/1MhXNJhyWmOy4O5XuFgvygCsNB+2q?=
 =?us-ascii?Q?KXNhAkg1D+p4FKPj/JbFdaYxmOfFMVuP18Lzk/u+v5DKqoMLkw0pmHsTEHPE?=
 =?us-ascii?Q?TqhpRwGRAFIw0hIvgT2GcBlAQGcFDEuBozrtBi4Dyo9tS8yME0qT/+4GkB9P?=
 =?us-ascii?Q?vpbQCQ3qfr5JrgmncHsLvxjwUiiPfV4aiKgq2yWgo0xH+sUf3UBAU/eOc3Ts?=
 =?us-ascii?Q?2CzNYKzFCTmrlB4rhvkeiKJ3rVqCHYw+bLbc91OuaPjJ4IvWpnTPLGsOal88?=
 =?us-ascii?Q?MRDsN2RIH7slTyHIZc2Vc7QYHSd9NPOflZ7vYKArlRF0nowg0/EEurksEJUh?=
 =?us-ascii?Q?o8AcRiisav48lqycJcs30AVh6fBG/BqdLZhDAxatqOgF2HKOHDInVp2McinZ?=
 =?us-ascii?Q?9VWnpMYVgzltIjx05aNUge5uIhfMryw/m/1ISGuJld/ETodqV2VOeVvPCrbT?=
 =?us-ascii?Q?dlLwri4/vazmpEy80VVn0LzylGkfc2F30JsKbRSDXU1RWTcgCJ9ewSBYadi+?=
 =?us-ascii?Q?9O+GTXaVGfD1cxxfdXzvnUAua75X5skishgfntk9Y4vUQWqbASbke+Z4qOC3?=
 =?us-ascii?Q?33zNOk27ZMVEMjxu2gozWOfIHv053pLc6ueiBNShft1RXNg3Y6MHwJxoqE3O?=
 =?us-ascii?Q?gTqSEPNoWBwwvRKzoW6+aXh7jezME2TpldJa3Mh9dQQmi2NXE+LOW2TD8Lz4?=
 =?us-ascii?Q?QvywXSXGQInu+rbRxRc/0B8Z/pXfeW5NsDWNKoJBWd+8EBQxR0yGufmEgTXu?=
 =?us-ascii?Q?Mn4pq3vMmhI2OJlu1ZIe1D7IFcrmX+5KZh0tIL5hYTWNxWGC2qmCrtu1L/Ya?=
 =?us-ascii?Q?ZOFl2S4fOTBHh+xjOApMVJKsOgYvc2NRUbdF6izK3DaFRP4Eexi7vyAWyYQp?=
 =?us-ascii?Q?1SVJmnHdQi4CVTPKscyAdsMknHy1P9bp1bFI3I/r2VA70tmlRm9SbPdFuclZ?=
 =?us-ascii?Q?CS6EbZbZiabovgqp0V+eeOwHvFPTdpk1VgV/SGDgVLhonHbxKDoW189pFa3Z?=
 =?us-ascii?Q?hc7LOnFBSnm49qmawlIaF4yphcrtpdp4EpZDIxq7VJEItmFIQxa1uVtK6qhq?=
 =?us-ascii?Q?gFiJQNgQsE5xtM42B+HrNJehnjUpcuGHaker8tDOR6r/8utItdgNG9EfqipF?=
 =?us-ascii?Q?3GiAU6vkTgzn+mrfjabpDEySZSN9Dopha2BIY8jslY12CjrE4fgwBqmBL5SR?=
 =?us-ascii?Q?wLKLPUrzWIxGH/wF3eeCDs/g93JEAvd6h7Ep+C9iWE0ZXg+m3VOTuQ3KFuxr?=
 =?us-ascii?Q?hXX8Ds7yOnvWeEIqUHaCVvRSDV3WQ1D5Wa1QikqRqv1lZ8FzuLcxKJugafvE?=
 =?us-ascii?Q?BBdLgodzW5OEpva0wV6CmEnxSc3yd6xbB9dy3tkNESh6+LOxcUqMYP7ab51a?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d92159-d49a-435d-1d31-08dbbe71b3af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 09:19:35.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JI7SaPdRrGhVTIP8jd/NJsFm6kGuT3ffqpB+LqD/Rvn3DG1w24uKymi/DPR3SQwZPDLpuHmkqJmFFgekn/L3bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 09:19:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13226

On 26.09.23 09:41, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, September 26, 2023 12:41 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
>> DEPENDENCY to all images
>>
>> On 26.09.23 03:39, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Jan Kiszka via lists.cip-project.org
>>>> Sent: Monday, September 25, 2023 10:43 PM
>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <Venkata.Pyla@toshiba-
>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools
>>>> as DEPENDENCY to all images
>>>>
>>>> On 25.09.23 18:58, venkata.pyla@toshiba-tsip.com wrote:
>>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>
>>>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>> ---
>>>>>  recipes-core/images/cip-core-image-kernelci.bb |  1 +
>>>>> recipes-core/images/cip-core-image-security.bb |  1 +
>>>>>  recipes-core/images/cip-core-image.bb          |  1 +
>>>>>  recipes-core/images/common-image.inc           | 13 +++++++++++++
>>>>>  4 files changed, 16 insertions(+)
>>>>>  create mode 100644 recipes-core/images/common-image.inc
>>>>>
>>>>> diff --git a/recipes-core/images/cip-core-image-kernelci.bb
>>>>> b/recipes-core/images/cip-core-image-kernelci.bb
>>>>> index 479c14c..8a58e7b 100644
>>>>> --- a/recipes-core/images/cip-core-image-kernelci.bb
>>>>> +++ b/recipes-core/images/cip-core-image-kernelci.bb
>>>>> @@ -10,6 +10,7 @@
>>>>>  #
>>>>>
>>>>>  inherit image
>>>>> +require common-image.inc
>>>>>
>>>>>  DESCRIPTION =3D "CIP Core image for KernelCI"
>>>>>
>>>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>>>>> b/recipes-core/images/cip-core-image-security.bb
>>>>> index 3421ce5..f114974 100644
>>>>> --- a/recipes-core/images/cip-core-image-security.bb
>>>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>>>> @@ -10,6 +10,7 @@
>>>>>  #
>>>>>
>>>>>  inherit image
>>>>> +require common-image.inc
>>>>>
>>>>>  DESCRIPTION =3D "CIP Core image including security packages"
>>>>>
>>>>> diff --git a/recipes-core/images/cip-core-image.bb
>>>>> b/recipes-core/images/cip-core-image.bb
>>>>> index 0ec7220..711d3d3 100644
>>>>> --- a/recipes-core/images/cip-core-image.bb
>>>>> +++ b/recipes-core/images/cip-core-image.bb
>>>>> @@ -10,6 +10,7 @@
>>>>>  #
>>>>>
>>>>>  inherit image
>>>>> +require common-image.inc
>>>>>
>>>>>  ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags
>>>>> --dirty --
>>>> always --match 'v[0-9].[0-9]*'"
>>>>>  DESCRIPTION =3D "CIP Core image"
>>>>> diff --git a/recipes-core/images/common-image.inc
>>>>> b/recipes-core/images/common-image.inc
>>>>> new file mode 100644
>>>>> index 0000000..863f817
>>>>> --- /dev/null
>>>>> +++ b/recipes-core/images/common-image.inc
>>>>> @@ -0,0 +1,13 @@
>>>>> +#
>>>>> +# CIP Core, generic profile
>>>>> +#
>>>>> +# Copyright (c) Toshiba Corporation 2023 # # Authors:
>>>>> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com> # #
>>>>> +SPDX-License-Identifier: MIT #
>>>>> +
>>>>> +# Install in build system for creating reproducible DOS filesystems
>>>>> +DEPENDS +=3D "dosfstools"
>>>>
>>>> Why this now? Patch 1 is adding it as IMAGES_BUILD_DEPS, and that
>>>> should be enough as you correctly analyzed. Do we want that change
>>>> rather in conf/distro/cip-core-common.inc?
>>>
>>> It is not required; I was confused then with your comment I thought you=
 are
>> expecting this change for some reason.
>>>
>>> If you agree you can discard the Patch 2.
>>
>> OK, but the question remains on patch 1 if we only want to include the t=
ool in
>> the reproducible mode or unconditionally. In the latter case, my suggest=
ion
>> above would come into play.
>=20
> I didn=E2=80=99t understand your question properly then, I am pasting you=
r comment again as below.

Your patch one currently only adds the self-built dosfstools when the
user explicitly selects reproducible building. In other cases - simpler
ones, granted - we apply reproducibility fixes unconditionally. Should
we do that for dosfstools as well? That is my only question.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


