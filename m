Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B8CD128A
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 14:35:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.99])
 by mx.groups.io with SMTP id smtpd.web10.1354.1712759718769093529
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 07:35:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wa6+AwIs;
 spf=pass (domain: siemens.com, ip: 40.107.22.99, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzP+Yrj6f1SC7lFQiTQ+dLf9RUhW33ZLRst6qHZjPDP2DZOpEOqGP9jCprMYKrC8bzrUwhLRw6uaDuPVnVjXUzlHaXgiTjZuHxFufTXgQxRHncLGBl+OX8KDArg4AwHkU5qgX1YuQvLcFiYq0IKGUdAEvQFK8yGKxaE/faH0SATIGYRIHFqo0xsTKXLSSE6ecmvmYTuagTXmSxZANaMt4AihphThpOVY8LECjSaKIFYWO+LWf88rc/wov8Ulb2flAk9fTtMPFNhk2Ccqp3dFxoSQWi8s3yuoFaftRwPaHFK7WbaonsnT1AaUVjkD7DUbNu33WyMvcVq9zUuV3VO9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKpXcAdqZHCIY9iismQHPaDlq2EzDH53/LHFNHu8eao=;
 b=a1DGjq6NX5x0Zp8GOgaTrCNBw0mHBjDIXJHYcABLVuQSDIDN+GfLVVkV4W9PRxCyNtkLZZi/TPLD/35Fyqc+48yFr6XuK+nlbzaAoq2tu1r3ApleGp9gqrAfnfehExdIwQ+VGxVSjkqCd/Pa10g4V7Ke7ljBGNbbTlXs4+uRN1+adbym5yA5tR3wIMY2xbFIuYvyKwXx4CltNk+xFPWkWt/1dHdkDv3VheTiVl0LtUhLha36DdQxPpqnv2YIa1sx9hbcPkEzvFhNYTDZGeTv5z8OYtBYXHIlj/pQsz2PzWw0avW7ThJaptYqGGJ+asGXKzRkSjaxSrgvPjt/m7LXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKpXcAdqZHCIY9iismQHPaDlq2EzDH53/LHFNHu8eao=;
 b=wa6+AwIsTeWf10cCTPS/bRkmMLHqWJhTOr01qNOrsoRipty6xyVa+ybFaNyjXwMySSNR5hBZ+9coU2DhAF5vYlm1ebsqVOgdgeEiUiDez369THKa2dfIwH4iNHTWnouGLLEKGir6RejsHtck+GOTXYBmEKpUa+U6uhNO6KHoCCptHLigZi6u8lcMD8ts7CDjqjPiATryDWWxFuXgdttlHayTl5FNIbMLTCHTfXQflzdDl2I7HY6bg9UTknvchmQTHMd8oNjXkQ1DliV3z6P1zK9TB5Xqpxz7ofqDiW2RPj6eXrWz87FY3Oz0nTovGr2poL+wg4H90mUa2GviHJwGIQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 14:35:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 14:35:16 +0000
Message-ID: <da52e44e-b9c2-42a7-8539-fa946d65f36a@siemens.com>
Date: Wed, 10 Apr 2024 16:35:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
 <ed0c8463-e04a-4a70-9954-54640fdac205@siemens.com>
 <TYCPR01MB966987E730E8F8D621DF564AC4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
 <TYCPR01MB9669E5691C80A28F3BD65BC5C4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <417f3a0f-8d13-4156-b2ee-89b258bf585d@siemens.com>
 <d9c1d3ff-06d3-435a-a998-27fba042d35a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <d9c1d3ff-06d3-435a-a998-27fba042d35a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6971:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	72kIpsecwkmJ/5aNAkxPRKFHnzgV6cOQ/2Z46iyalIyTY325tTlKg2SmUX/WmJ9rFeJ5gh46VDvdKtbx0L1I3R2IhNN/6LOjTTvFIuUmfG76NC01g8lrfJEJGfaqqAOSQcUjKcntX3VQvJTXFxE5Kf8UXu3mzFmiDxDUoiGo1PYh3z2UOqhsDYg2cv0ec/1CTaQEqHjuS0JK3H92HMf9CJvaxYhzwNKwh9qXTXlj7Tdpo7UF1u9VO119ApTlycaxSVCtMnYqC9nYY6Unf2wMC4x+HNIlHUn9IihYwfLYRYSMx5OVL+Km9pQ/lpXyAOUFwkLQUnRDNbsn4ZphPPtgCNqV3u6sVSkZpxH4cDIghRckXWxYq0MmB0L3GGoyjAk3aRhqw7qWjcdX7ulzoaymo6rS1VWOjmEJNmYi4PF+U2Munl1BuM5E1ZWmwPmzGMArBHK6IQAsn3wj1wjmNJFzejJiMkfFAz/9lAmrMMQysvXhSfM8xwYw50K3VgjzXNBLDuNAoQG1GEqZepmpwy+bD8ROYdqtGFL+FMByPPnE5X7wkULTeaVkx4YCupi4vlKOBFIwd5e2vN0ULJtI7QLCdC6L1f4w1HaqxSuLdV2XqaodKb+xVlj16X6B0Lez70AmGpZ14u27hmuwXCZSvTIRe0dHfN5K4p1HecE23hmdUQI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FfvBk3Ue+ekU4XO0sE37s3XIzaAxaMwMhcPBz3EpwOwOu0PQDVugUACBCxqo?=
 =?us-ascii?Q?gUaLSXxtAOZZbmO673uf6uVNMEao+SFOyxZibXbKCLdkF9XEhFnf08zTmZIN?=
 =?us-ascii?Q?feidz965R7SngrbcD97DrAjnTDZYs2kRJ/wrcG1p1cCd6GfBwQjPAOfx7W04?=
 =?us-ascii?Q?nW/1DqGK7prFZAmmCmzBloOfRhvwvi8zb06Vb0UGDeBzDT+t4/a+Xmd8T5gP?=
 =?us-ascii?Q?vgl1hN9eXRD9sr6yls3jhPa2VWncnGjHH2xsfBFmAUTTRonPzRk3EOkjpNAX?=
 =?us-ascii?Q?iRz5FwRFFmZwpFeovh3bfuJEIxhD/k2IZ2G7mIhV8O3STQrSxvF0P8ZGz0o5?=
 =?us-ascii?Q?a1W3BuaBN575s5vfbUGarbJeoODpKcebvYTTsDbksBdilIFrXn1zxdgIo9GX?=
 =?us-ascii?Q?OZ5sVypxSb53cAvo5+ns914lLIWFtnEAkDmivaXSHvfWlwKFbBJ/KCEw364N?=
 =?us-ascii?Q?lQ4drZCOPJ14819VpEpBA3KFILtkIBDkfikErXPCO5tqiZmIY0mQsLfoePrB?=
 =?us-ascii?Q?Gn9hn5LCybxZT9khEcyVxCy8swKHYKXCW3KcuJ0hvF3Ev1qpC7AyBJRX4Wdd?=
 =?us-ascii?Q?Tk6hc4DtyLoK71BOWqMolgnqwXJHX57Sa8huX6gWOuz6NzHOhs9DYcFVYFGR?=
 =?us-ascii?Q?PdEOmXJloNsrXJ7V4D9iVOTnlvtH2hLZlq1WT02psDcXbN0rue2sfdMm2GMp?=
 =?us-ascii?Q?Qb/OhNXHGfcMq6k75YSd93zUU4WE58Et3xULafEER9Vn96hX50Vg/kyYtAmk?=
 =?us-ascii?Q?E11mGy34sJCdNEgVjORES5b8SZXRt0xoMavbQSfdtOpvUifIl+sZsPlRStu9?=
 =?us-ascii?Q?zOM5LWdqYmmtLTa3p3DBPXOxPmH0O4cEdradELZ8OQgVBVw4aGEQZ3T/nkfa?=
 =?us-ascii?Q?72DOdVnMx8VFYXp3wW24mQtC8K1XbZEAvUFN2Iy7matAFSyhCooj/5zj8Ykk?=
 =?us-ascii?Q?GZKSrS2QFB4/ggEk6UlH6sBnhxquKswBxrn4onZnQEWXWV3MumNRdxxCl7Gj?=
 =?us-ascii?Q?r7O6EsELMvnZFgAdS4EAIH/cRfdRNSYL7ctM+aFUfppK7QGBYMDcb9pNzrmL?=
 =?us-ascii?Q?nBt6O6tsvS9D7GZswEMq6h1EeT/U7xqP6JSSAIQrE2wdu898OFBKz5dJGQ9k?=
 =?us-ascii?Q?tlgtBvE6TmpenFu6xXJe1J5oP1EqCxDn/UNIZWZryllT6P06iaTcIzD9XrwG?=
 =?us-ascii?Q?dO5zZPyMSr6srgfcxtCiPhutcNaybzngRZCJeQjhoNchnjxThNLuhndfei04?=
 =?us-ascii?Q?8HSoKG0z2FNz0R108akFbv+DzjSO4B9nSO+3yAr+KV4WIJt+94gU/WMWijBS?=
 =?us-ascii?Q?ksWpfLaeta4INgh5KdcEvfszQoltC29ATiygRFIEhviR3jctBDfZWxOUhBim?=
 =?us-ascii?Q?MOL7l1oxfd2UREgb0bFluJeyHJ2eHY0MrCD/LsLQbcpt495fEHoqOPDxFOIp?=
 =?us-ascii?Q?6QgjIiKCP0FW+v9XbcFTbIR6x6ZQfkpzkQUXaeuw36fhYoJwW6OSf6vMmTb6?=
 =?us-ascii?Q?w4EKK6Wy9kSR8M2PD12cLG2J247yOlwBhOnQajpTg6/5zkiPPWo6HvDoPY6a?=
 =?us-ascii?Q?urUZL72LfwZ7ivYGXwKwB3PlQtquxJrq2P/B2XP2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db87bb0e-3841-42ad-eaf0-08dc596b7039
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 14:35:16.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQPF42Wi+kUxRe7f/eCGDL29D4ToW2nFsCSISG36IQv0efzaXhgSxHuIY/W7BhHH5e9CpkRoifjFtns2pgwGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6971
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 14:35:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15535

On 10.04.24 15:24, Gylstorff Quirin wrote:
>=20
>=20
> On 4/10/24 12:40 PM, Jan Kiszka wrote:
>> On 10.04.24 11:23, Adithya.Balakumar@toshiba-tsip.com wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Wednesday, April 10, 2024 2:14 PM
>>> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR)
>>> <Adithya.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org;
>>> quirin.gylstorff@siemens.com
>>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG =
Porting)
>>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG
>>> Porting) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =
=E5=92=8C=E5=AE=8F =EF=BC=A4
>>> =EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=
=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayas=
hi@toshiba.co.jp>
>>> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update
>>> support with rdiff_image and delta handler
>>>
>>> On 10.04.24 10:27, Adithya.Balakumar@toshiba-tsip.com wrote:
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>>>> Behalf Of Quirin Gylstorff via lists.cip-project.org
>>>> Sent: Monday, April 8, 2024 6:25 PM
>>>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>>>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG=
 Porting)
>>>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>>>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=
=BC=A9=EF=BC=B0 TMIEC ODG
>>>> Porting)
>>>> <dinesh.kumar@toshiba-tsip.com>; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR)
>>>> <Adithya.Balakumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=
=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>>>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=
=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update
>>>> support with rdiff_image and delta handler
>>>>
>>>>
>>>>
>>>> On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote=
:
>>>>> swupdate supports delta updates with rdiff_image and delta(zchunk)
>>>>> handler. This change adds support to use either of the handler for
>>>>> creating delta update artifacts. zchunk based updates are supported
>>>>> only for sid.
>>>>>
>>>>> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables
>>>>> can be modified based on the update type in the swupdate.yml file.
>>>>>
>>>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 classes/delta-update.bbclass | 107
>>>>> +++++++++++++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 kas/opt/swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 5 ++
>>>>> =C2=A0=C2=A0 3 files changed, 113 insertions(+), 1 deletion(-)
>>>>> =C2=A0=C2=A0 create mode 100644 classes/delta-update.bbclass
>>>>>
>>>>> diff --git a/classes/delta-update.bbclass
>>>>> b/classes/delta-update.bbclass new file mode 100644 index
>>>>> 0000000..8443f35
>>>>> --- /dev/null
>>>>> +++ b/classes/delta-update.bbclass
>>>>> @@ -0,0 +1,107 @@
>>>>> +#
>>>>> +# CIP Core, generic profile
>>>>> +#
>>>>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>>>>> +#=C2=A0 Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>>>>> +#
>>>>> +# SPDX-License-Identifier: MIT
>>>>> +#
>>>>> +
>>>>> +IMAGER_INSTALL:delta_update .=3D "fdisk zchunk rdiff"
>>>>> +
>>>>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>>>>> +do_image_delta_update[cleandirs] +=3D
>>>>> "${WORKDIR}/delta_interim_artifacts"
>>>>> +
>>>>> +DELTA_UPDATE_TYPE ??=3D "rdiff"
>>>>> +DELTA_RDIFF_REF_IMAGE ??=3D
>>>>> "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
>>>>> +DELTA_ZCK_URL ??=3D ""
>>>>> +
>>>>> +def disable_delta_update_tasks(d):
>>>>> +=C2=A0=C2=A0=C2=A0 d.appendVarFlag("do_image_delta_update", "noexec"=
, "1")
>>>>> +=C2=A0=C2=A0=C2=A0 d.appendVarFlag("do_delta_rdiff_ref_image_fetch",=
 "noexec", "1")
>>>>> +=C2=A0=C2=A0=C2=A0 d.setVar("DELTA_UPDATE_TYPE", "")
>>>>> +
>>>>> +python () {
>>>>> +=C2=A0=C2=A0=C2=A0 import os
>>>>> +=C2=A0=C2=A0=C2=A0 path =3D d.getVar("LAYERDIR_cip-core") + "/" +
>>>>> +d.getVar("DELTA_RDIFF_REF_IMAGE")
>>>> I would suggest to remove LAYERDIR_cip-core or replace it with a
>>>> variable as it makes it unusable in downstream layers. This class
>>>> should not contain any cip-core specific elements.
>>>>
>>>> [Adithya Balakumar]
>>>> Hi Quirin,
>>>>
>>>> I understand the issue you are pointing at. Could we reference=C2=A0
>>>> "LAYERDIR_cip-core" through a variable defined in this recipe. As in
>>>> maybe have a variable (lets say DELTA_REF_ARTIFACT_PATH) with a weak
>>>> default assignment with the value of "LAYERDIR_cip-core" so that any
>>>> downstream layer could override the variable with a different value.
>>>>
>>>
>>> Why do we need to reference a layer at all? Can't we just define a
>>> generic location, maybe somewhere under DEPLOY_DIR_IMAGE?
>>>
>>> [Adithya Balakumar]
>>> Hi Jan,
>>>
>>> Do you mean to store the previous image build artifact (.squash /
>>> .verity) in different folder in DEPLOY_DIR_IMAGE itself and pick up
>>> previous image artifact (if available) for the next build to generate
>>> the delta update?
>>>
>>
>> I didn't think this through in details yet, but the basic idea would be
>> to look in some build folder (rather than in layer sources) for the last
>> version. I would not simply use DEPLOY_DIR_IMAGE itself, rather request
>> the user to move the old image explicitly under a path that signals
>> "build delta update as well".
>=20
> You can use ${TOPDIR}/<some directory>, e.g. `${TOPDIR}/delta-image/`,
> to search for updates.
>=20
> TOPDIR is the current work directory, normally `./build`
>=20

Maybe better ${TOPDIR}/previous-image/. Which artifact(s) need to be
copied there again then?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


