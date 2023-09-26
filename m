Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E3DE7D242
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 07:11:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.13342.1695712271163025703
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 00:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YxtHBCZr;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGa9dBuef3D/ia7KPG/1YxJsiocQx8ogSe/E95xoaEE1MU3w+fngc6ACSjyNyiVv7tYGnKislGhFxfPH1KQX7XR0/Y7hO86U+Xx57cNUldB+VinUh9+Ey+3ujKFWp76Ht2VTlfXt/eMYI9BuiR4Y0mFnQOR4SrO4ryz/Z587fA8F6JWLgE3H0k46xryaDASHq5XU3zePjaa0IhD0snFy97Nw6EVbAWBDv8PFCUdEOEQz6uN7998CFhL1DsyDgvOuv4knsJHx1sexwu2+X6Fiajb0HG/hWpLiOIZU27g5rvZdu5Ffte37vKsGKdlLL6vFTGlBNPn+QwYlvg8YK5zScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixhh9zKtn/W6bOQNDbsMsgdsJPzMR7XiaLOIbWGw+tM=;
 b=XBZ4Pax6X4gJf33szopzFf5MVm/Cvl5CzcUX2hkjboJWgxiITjy5HXMfr1YmfVfjokBPXfdcfqCBdDleiZEZ5J5YpJQRZbSUNBUtDBriJgZor9bzErUxZjFTXc2rY1hmRjqzGjwKHbS7P3Lq/Zxdrv2rN1dPDj9aZK9Ha7LN2AVQh6TDSrBH0tyQ+UwaRLAKIFNnwUkJLvJWI3DW+YO7gTL5MRc+Lskz/I1SaeKTT2Hw2PTHhT9hCPYv969v63QMURnDysw08W1bsBZnwZ3rVBVdgb3idCNjfxB/1zU+aLxWsr0mt93X6KDvQGS+AeIxfyqo3iAZ+WxlP6qHzr9rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixhh9zKtn/W6bOQNDbsMsgdsJPzMR7XiaLOIbWGw+tM=;
 b=YxtHBCZrTlGRWSzcjPjjO39rFB9MST7o+fqDy8cWaS5iuKERcupJ5N032XbQWCllcwL1EzBrECw+WJ+m8+wLSOsc2j455XR210yH5ocQaoDbLeO5g0Rv18LX241X0CNuxOpqh3Lo2+py3W9dFCgZEYqFHzebM/i/5kLpc5Y1tks7FojxqrD13bMV8ZURV3K0GtaIWEvA2gsAw5NVYbpvWKYEawixy6sGZunQ32ZvVxi1Z3lFk5N4QQLXr+qFpu8FqzeN1gVN/GE0be8BACM8Wk+hFJj5ZNCLGvAzv6Wm4O6eOWYHlzsovocTRu0SO7OsbGFCtvvJAIrVK4g//UwTzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 07:11:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 07:11:05 +0000
Message-ID: <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
Date: Tue, 26 Sep 2023 09:10:58 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c54861-1368-44fe-8771-08dbbe5fc000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rLqT/8cQGjiSvj231RPpTRSuIHMRUhRyUFAYan6/vEZ5Knz5CCE0bIzBP1SKKN2GFXPXVeRaM1sAOO/L9x980emR7djb73ZLRnvA7XJOTxg4fKYBj1lVwxTg9hJILiNy7E17qKT36KxtcRRMHAC3xBljP+aD+0cYtAAYSIS6PvIhhMo0QW28pEV9lfDYKyaww7IrBp9ahiorBsrSwACInCclsUhIAnZL+x082ESzFncrxNJATcTI9A51ryeVDir9PymC7efLd2nWaLY+NMY9PUBXCAXOTackyPjNDTyWndz9dSmkQgjxAYqPONeOEg6saPF3rtzK7xVxeH45BzeedKsSkbPdUv5UM1n9t5zoh4HdKhkXjLg+enBVchGtI3irYwFM8j4+LzaZlLAyhmHruNaRTS5CyWF75dMRS2H8xIkOqE/fCk6Yz8Bx5AGLHV307jIpRvavYy/wMhjnU8FzEiBhH/4Z4SmzkbsmhtboF+my4Y5Veg27scUnVgiSfdQTrogReaLZNL6N7Xh5dwHV+DkL+A4HQ6usAeYZgIkGkyMJQhceNcrjDmIXe1E1ByxabKsYNKAhWf/axxAfFk+IIpMPIvrFIaNbfgPmR4IpItR4IKaVXtPZ76430V1YuCZD84EQS7XKV9eSKJLwoji2Rg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(36756003)(31696002)(86362001)(82960400001)(6486002)(53546011)(83380400001)(5660300002)(6506007)(38100700002)(6512007)(2906002)(4326008)(8936002)(31686004)(316002)(41300700001)(8676002)(66946007)(66476007)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HSsVbggmtDEVTxpFQG9SzemKUH1s8wfiVpk6E/U8STBWpvZEc0Gm0iyEpjfa?=
 =?us-ascii?Q?JHvmUnDewt0q2Zk7cosME1P4uSPEdtO+s+Rqw1XFeb+F5lk/peo3UfgW+5bP?=
 =?us-ascii?Q?gIuftGjpbG/m1nOBjVHfvVty5Hc5ZqsZXuDjpuiw80R9g64wFq3MCJ/FGckj?=
 =?us-ascii?Q?kTaNUDqsSruKv8B5J20jxFXCsc4xcw6ygwQRcyvR81lAeoDQETNpPObUg/gb?=
 =?us-ascii?Q?zjSdwbEXe4bEAkXTo1fpWwWW0T264y9oUQnVL49ZS4O0B2GCh6vgKYH/IZa1?=
 =?us-ascii?Q?j8ONCGwZprbqmG3WehM/xNs/bY746b+pMcDesBQljDSohg6YtQW8NwydXmjZ?=
 =?us-ascii?Q?ta0x0bdFAt1g9Yi0bmhcFx73Rjn67XG2vcrfSUb9RIDKuKO8IlvBvkABA6e/?=
 =?us-ascii?Q?X7o/yMSy7pIL892/UZbW0psPcQJQLEbLNzzJ1FemaLu7PDfPwRVw1SmufbkM?=
 =?us-ascii?Q?ffntIg/iItxZByNyotQtojiLYkbTTThIK+5vKogkVeYg9DBeD57a+ZCrfqHZ?=
 =?us-ascii?Q?HZr+o4O3tTlHkMdAovYsla+MPy8WVDCK0/Xv+lFgD1x5mgONWoH1bxuQrjdi?=
 =?us-ascii?Q?Hi2B6phiZYbnUHrUf7bttTIDNk+7GmB72PeTz0CVBb+DSkks8XSbqUOxzl7s?=
 =?us-ascii?Q?/KBqe9aH8swuGjx+FbVmQSr0fTKvpH7xYsu67s+g02kBOXNjFMJGbkJOyzQ+?=
 =?us-ascii?Q?ZVNwwTNW3m7W5j3fBBCOhjTlq0Vdvzf4/+ZICcuG+PqYrY7QOdyhBP7T65bV?=
 =?us-ascii?Q?9M/3Zkmygdh8N0qin6IeItdeC3y1YIqpX4RDr6aNICD13QJunxUlplHwToKx?=
 =?us-ascii?Q?M+7SfFfgPQO+xL+qndHAneXzK0XKdXFkF7/9HSsqQzCbjbJQ3+Jo1bd+fNhY?=
 =?us-ascii?Q?+cEYEpyi2BOwgQ/lBsMn+BKRiLE9WBpMBhor3WpatFj9v4S2Jx4phbAh+eP/?=
 =?us-ascii?Q?sxD8mQZ1oMFamQ6C83S9zfYGV/koAkv0Ph9kRqs4msSQcrfndfMWNVvLjtXq?=
 =?us-ascii?Q?S4KTGQzRQvTakmK3j4ULRtQjjmYeVTxs/c17GXVYu1U2+LXxU/2ghKzBcpAs?=
 =?us-ascii?Q?2rmxC0nhDLKsc4OaBWH/Wp9M3i/Xf3ZF2zCq51iGBF7FzYAxUkm3SdCxe5s+?=
 =?us-ascii?Q?1SvUjZ03Sqg/Zovb9byE44yHsuJZUuSbY0wCRGVN6UeBMRuWz80IoOaUN1+O?=
 =?us-ascii?Q?gVGjz+5TFT/E2rSPvLQAdaKSIKPjl9EAOeySlBOw8AzxZv77LpU2gj4lW0+M?=
 =?us-ascii?Q?7g0O7ZqIDioxBXxGvZkUetXo65VrtVOX/ZJXZ0drqb3w7t2wyI5NTCEp+wlg?=
 =?us-ascii?Q?MGPn0DKwuspniFOkQWVnQkDPf97YuDZKwAYZApLi4TF9g6T658JXHAdTtlHg?=
 =?us-ascii?Q?1/Sfa1gJ5dM/Z1lN6Z5Jaj0XrAw+f4qE7w7XyQyx8fVZd9pbVwEEvDsDbZaZ?=
 =?us-ascii?Q?cnu8UhXtTYafkstRrRFRJ2tH+vMDehgTNi+fmnoB1Q+mPD4z6AssdrLx2Xl7?=
 =?us-ascii?Q?GkfYRGIGMQUeEBxJ4Qfc9ZjZRZ8GDQtEXkfa0/QY4MwdVF8cUxTv2VErJEOD?=
 =?us-ascii?Q?PxvfIQZmM1MhoMxf0wL/ZoL2hNSOt4EZMAAP74IxlkR4h+g4DZ2Cm6Lk6ibz?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c54861-1368-44fe-8771-08dbbe5fc000
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:11:05.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exnfkvFUrAXHp2NlMG2yZAsvDBwdZhTpsK3iDWIyh4IvDLbk21T2BaFNBkuMlUZp6P5iA5CPeI12i0+qtCyPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 07:11:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13224

On 26.09.23 03:39, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf
>> Of Jan Kiszka via lists.cip-project.org
>> Sent: Monday, September 25, 2023 10:43 PM
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
>> On 25.09.23 18:58, venkata.pyla@toshiba-tsip.com wrote:
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  recipes-core/images/cip-core-image-kernelci.bb |  1 +
>>> recipes-core/images/cip-core-image-security.bb |  1 +
>>>  recipes-core/images/cip-core-image.bb          |  1 +
>>>  recipes-core/images/common-image.inc           | 13 +++++++++++++
>>>  4 files changed, 16 insertions(+)
>>>  create mode 100644 recipes-core/images/common-image.inc
>>>
>>> diff --git a/recipes-core/images/cip-core-image-kernelci.bb
>>> b/recipes-core/images/cip-core-image-kernelci.bb
>>> index 479c14c..8a58e7b 100644
>>> --- a/recipes-core/images/cip-core-image-kernelci.bb
>>> +++ b/recipes-core/images/cip-core-image-kernelci.bb
>>> @@ -10,6 +10,7 @@
>>>  #
>>>
>>>  inherit image
>>> +require common-image.inc
>>>
>>>  DESCRIPTION =3D "CIP Core image for KernelCI"
>>>
>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>>> b/recipes-core/images/cip-core-image-security.bb
>>> index 3421ce5..f114974 100644
>>> --- a/recipes-core/images/cip-core-image-security.bb
>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>> @@ -10,6 +10,7 @@
>>>  #
>>>
>>>  inherit image
>>> +require common-image.inc
>>>
>>>  DESCRIPTION =3D "CIP Core image including security packages"
>>>
>>> diff --git a/recipes-core/images/cip-core-image.bb
>>> b/recipes-core/images/cip-core-image.bb
>>> index 0ec7220..711d3d3 100644
>>> --- a/recipes-core/images/cip-core-image.bb
>>> +++ b/recipes-core/images/cip-core-image.bb
>>> @@ -10,6 +10,7 @@
>>>  #
>>>
>>>  inherit image
>>> +require common-image.inc
>>>
>>>  ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --di=
rty --
>> always --match 'v[0-9].[0-9]*'"
>>>  DESCRIPTION =3D "CIP Core image"
>>> diff --git a/recipes-core/images/common-image.inc
>>> b/recipes-core/images/common-image.inc
>>> new file mode 100644
>>> index 0000000..863f817
>>> --- /dev/null
>>> +++ b/recipes-core/images/common-image.inc
>>> @@ -0,0 +1,13 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Toshiba Corporation 2023 # # Authors:
>>> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com> # #
>>> +SPDX-License-Identifier: MIT #
>>> +
>>> +# Install in build system for creating reproducible DOS filesystems
>>> +DEPENDS +=3D "dosfstools"
>>
>> Why this now? Patch 1 is adding it as IMAGES_BUILD_DEPS, and that should
>> be enough as you correctly analyzed. Do we want that change rather in
>> conf/distro/cip-core-common.inc?
>=20
> It is not required; I was confused then with your comment I thought you a=
re expecting this change for some reason.
>=20
> If you agree you can discard the Patch 2.

OK, but the question remains on patch 1 if we only want to include the
tool in the reproducible mode or unconditionally. In the latter case, my
suggestion above would come into play.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


