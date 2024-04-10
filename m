Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16319CD1296
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 10:41:08 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.139])
 by mx.groups.io with SMTP id smtpd.web11.163775.1712745661275822581
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 03:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S+mt01uz;
 spf=pass (domain: siemens.com, ip: 40.107.14.139, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S51Q4TjfBS80U1AZMAcK8ReoUo4AkdmALe6dYu9Uc7h8v00FncYp+4XWPVEVJeUrdVmAp+Lh5q/4c+Vse1b9EgJv9BZqKCycy7EAb4bX9ASIhT3Z0WtdQD0zcyHZefHnBa0kr8/VFKjFmHXTW0ZkQPSiSuS2siFspDfyNwlDQIksMpj1u0j9j1JnQebxl2is14zNkCckKF5SrOIM4xVWClWCXb8y29dDy+qRbRccfK0hTlBaXTqM8BJjNXZyzGZbWo42CUxcN4TfmGpbEiBUmk7Q3aZIJaKoz97BnJ8UYZ/ZhXqzB8GbhrdRcVtqMQyjKFNZM9uf8Ek04EapBAuLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHIB6RqnuIZikfCBnLMh8SGXHUlNRqKFQf59BfvrnZQ=;
 b=LnQYwR1oX5X/8hiD1bvQxqo/fq7xKNcAugFXwqaBgi0O/6lphxh5BzhH5RSs+hKHNCHyP+vFMsoDt88TDRcdv/6tE4xvcdDM5bIHkcGSSpB6ysiJx3PBXDR5sZKEZXL4Q1wSf2P66ohX3a/GycZSPAPQAThDQTU6wXqodvv/85u6JOtbaERIkdm56tshtgnDjVd30+SLfXgu6mJV7i2WLlTpDF04Fviv8Gr2otOsjnQtZHlktmFB1exaDUUQNEW8YYkVSb4I+aPoDXRIL3A9Dkt5noaENz4jJ7/uXUyozBt3F4CN6/RJ3NwU6HN0+lHsbwrhXoJ9OlFwInU4TxhBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHIB6RqnuIZikfCBnLMh8SGXHUlNRqKFQf59BfvrnZQ=;
 b=S+mt01uzsCz9XQXRcIkFmjJEZ1KshGoN9Z6W/H4fPf93DkByuVnPMmZM/VfCCSatARfEO1oClBIKaTW/cjsF3+ArurNPEjj9EPuRiXB7bOI1nW75yd/fM2VLtJd95xhJQxWs0XizZluWbYtc19QVZT1s9ahktGPuY4gm84Vumo7+QsGdV3HtBjsENzFCO5zKMBX18fQhnUlPZe8vR+vogtwqc/RDREZ5ZD+wuqCEdcDNDu7IgLqOFQ6Cecyp3wEkAiGbSvdtF65epvAmY+NRksFqldkNsuvZax19CwqVnYRhdgyJlSRopVGudk+7IkYYayqAtHLHxHg+kVFFPfzDHw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 10:40:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 10:40:57 +0000
Message-ID: <417f3a0f-8d13-4156-b2ee-89b258bf585d@siemens.com>
Date: Wed, 10 Apr 2024 12:40:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update support
 with rdiff_image and delta handler
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-3-Adithya.Balakumar@toshiba-tsip.com>
 <ed0c8463-e04a-4a70-9954-54640fdac205@siemens.com>
 <TYCPR01MB966987E730E8F8D621DF564AC4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
 <TYCPR01MB9669E5691C80A28F3BD65BC5C4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <TYCPR01MB9669E5691C80A28F3BD65BC5C4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RpHT3aa5Pu5MVgWy4nHIySTy38UPRhyYCEdZ9FsfnzcfVHwN7vg/ooPi5d7yLWkkNv/65yXJI+mILAn9QNgAGkuEhlF8UogJjmvIFK//CsEX0keQv4WroZSmOVbnjHkZ80tzR+i6kRmcy1+VNngqPQOaOL0GV6uZk+ZKwCqwLO2HkEZSkqupVYIdJyWQdKMojwEJ1RYRUxHaCbntHqqJ3PqXirQvsXQD3OBGRfeoN5QBeC2afq6SZXxg89R7hp+O+OJ60mnFH2ExLIrlvlHhBahsjhxtzY03gFWsE6qN5pNCl3SjS2zN+Urs4yM9MaQpWRDTvo6tIIflQzX/sJLQ0F9vkLuxIPnUCo2nIcgiDODPXMFFXDUrwlFI4g1GxVRw0mujSQEoKR0h2T1ddh7lBtTX5rrDZ9+D6O2718KeLt6cs/suy1ACpBYOf1czNYKF29guhLkk/zDhwM0ZCqtLQpPELf9ugqdeIQEnA2e5QQvdp5PCYQEdr7ajoIfeuWqaXyO8xcO+gFxWZHjbxHNC2ItFDhxhUMvdOEMTbuzQYf+v3gr3p28VpoqWpOX6tmX9rNGxASAaBZcbCwbC9CmMpS3v/609ypy62eCUudrJyx02f/DjDKm/l5aH49epqjJhPL5FhyIjsywDbvdvpqldXG8wLPH02wswyvoK8MsSBtI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QJ6MUrlLkiC9jQY6CC4JyRCzbNUQeK08zRlp4TPiNGpKN2L7LfBJbVVo3IIC?=
 =?us-ascii?Q?Eth9WJcYp/eK+qz9rXmi3MvRq/7ujsu3g5U1ocNeTuDpID57CpldgaM+Jb2J?=
 =?us-ascii?Q?TdLsWEaZkY96HGdCGXk97PgJnpvAuBozYzlQo8lfZ5mcbbPun25aNBk/AbrI?=
 =?us-ascii?Q?FDR5lQETXUtoSqXr93mASiIzJd5u34NwAIkQiczBLHdt3TAPPWIyAz4MoeSv?=
 =?us-ascii?Q?fd6CwOyt2xJrkVLL/dob/52/LEyl3zkX9W4VQDotJRWkgHwyvhcUE6o8QbnH?=
 =?us-ascii?Q?zeXYHzZWZKtiLsfqN7hrzYk4zNOglbh1uLq+U8ZAnuJbpKPsltE1sI9JTRZh?=
 =?us-ascii?Q?69wTkAbjxhjeoLmxNGMHz0uCSyxvQrCvpqV3k1lWAoLkOUUq+AIIY06MqyE5?=
 =?us-ascii?Q?2yiDIrulsySRhf3BEazwvrD6RSTxlmcuIPL8lqW0H4LLhF5C4kit6H6UkZTm?=
 =?us-ascii?Q?pSHqMKJIW+ocyjfW2azpWHaADm4TyKLX/WOSBAk8Q9Bg23DWbXSLswC6lZJE?=
 =?us-ascii?Q?bjfbKObm7F+gSd+YbNws7tIl7ieNVPjuzjb+FcpDh2g2m/uwBvez6g2u/orf?=
 =?us-ascii?Q?ni0HHfuX9b3GrjuTjGg6BYgPRBSWpw81XIJqVbvwsOeNLhb31gJbo+vdV1ye?=
 =?us-ascii?Q?xhiLG0Kt2NuPWqihBs9xNgn+Gh4CEqWqEO1GwJlpiinIZ4FLR5zphjFUR4/c?=
 =?us-ascii?Q?13q3KKc+J5sBgYVRMZhoD7I+l5WE+BxkRrP9Y9DwOTcozw3bSV24ToyDxem8?=
 =?us-ascii?Q?JtnBDnXiUTTfLe7jERrFzoGRgdWl6qXRnQM9y6tx43EirEjKVNg+agWmUBxK?=
 =?us-ascii?Q?YYjP6D0O358mOPtUHR92Lc/Jc7FDfKB4PiXZ2T63Jrc9hqYQN8UScpXjkNcm?=
 =?us-ascii?Q?X/R5bRf5m0AGxJYzZ/FrSQ5T+mtjogUE+dYc+f2ImUwJmm70r/fGNpNvLb2f?=
 =?us-ascii?Q?c34DffMjKEEBEW95lAFXVLPtxWFArWExKyYsjG29v7HMwKFAsG1xlT4QEAmY?=
 =?us-ascii?Q?+7D9LvpHQbzD6vgmwrli+9RMw5HMZDK9SvfbNg/3Bv7JvutFWXzO9ETuDfHn?=
 =?us-ascii?Q?ficnUOSJVIJ1LCD+2v+7Torq4qk6b6MU2IM43FSQ3laZ9B8Jaczc8zccTHU/?=
 =?us-ascii?Q?P8HwI5OQsvC4vpuG246bkRqDudJ/gfkEdaT8geSuUTnl7pXusiEc8zX1bYLV?=
 =?us-ascii?Q?aPs1iJuCvbejVthD0/DVkqcI9hjjp1Em8N+YIFlKWipvXd3KTo1gSSJWqMvK?=
 =?us-ascii?Q?y2mhteSu6vPmbx/ZI/4WhtgL8vYes95gn/9F/VrFzwD294gx1v1yDMa6o7MO?=
 =?us-ascii?Q?BK01dMxkJPGrqqfmOkob6PuhUwIc1aXUTaTOVevZd45vyVk+0ztuX4JGGZZd?=
 =?us-ascii?Q?xe+zJyW6BeL90P6pJBEj3Dp3ukJ5mkU4uoitg2A94Pks8Z3FdtHPo2gfBEGW?=
 =?us-ascii?Q?Bbo8fuSmofhrN13Rx8UbbKRJyIgiqXzeG3ayMTo+g5EuvGQpj2B0+S6hLx2u?=
 =?us-ascii?Q?KDvQ/KKovB22oj1dmzDObj/nv9P1ZiDg43o0GRCymADi3GTA+uMmdgylaCRY?=
 =?us-ascii?Q?FEfzp+r8sgO1D1hA7JBNXuTP6Hk0B1YImQuI+LR0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c15f7cf-1760-4887-7bfe-08dc594ab4d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:40:57.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnN0fTr7BrbbbbG2qAnN3OwK7vo6dom61Pw3jO3i1dbSYHFpi06J+Nhz4ZedBEa/1IfX9fpbXCwr5akIDx3tfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6285
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 10:41:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15533

On 10.04.24 11:23, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Wednesday, April 10, 2024 2:14 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithya=
.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; quirin.gylstor=
ff@siemens.com
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update suppo=
rt with rdiff_image and delta handler
>=20
> On 10.04.24 10:27, Adithya.Balakumar@toshiba-tsip.com wrote:
>>
>>
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=20
>> Behalf Of Quirin Gylstorff via lists.cip-project.org
>> Sent: Monday, April 8, 2024 6:25 PM
>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG P=
orting)=20
>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)=20
>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG Porting)=20
>> <dinesh.kumar@toshiba-tsip.com>; balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=
=BC=A9=EF=BC=B0 TEUR)=20
>> <Adithya.Balakumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=
=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5=20
>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=
=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update=20
>> support with rdiff_image and delta handler
>>
>>
>>
>> On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
>>> swupdate supports delta updates with rdiff_image and delta(zchunk)=20
>>> handler. This change adds support to use either of the handler for=20
>>> creating delta update artifacts. zchunk based updates are supported=20
>>> only for sid.
>>>
>>> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables=20
>>> can be modified based on the update type in the swupdate.yml file.
>>>
>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> ---
>>>   classes/delta-update.bbclass | 107 ++++++++++++++++++++++++++++++++++=
+
>>>   conf/layer.conf              |   2 +-
>>>   kas/opt/swupdate.yml         |   5 ++
>>>   3 files changed, 113 insertions(+), 1 deletion(-)
>>>   create mode 100644 classes/delta-update.bbclass
>>>
>>> diff --git a/classes/delta-update.bbclass=20
>>> b/classes/delta-update.bbclass new file mode 100644 index
>>> 0000000..8443f35
>>> --- /dev/null
>>> +++ b/classes/delta-update.bbclass
>>> @@ -0,0 +1,107 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>>> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +IMAGER_INSTALL:delta_update .=3D "fdisk zchunk rdiff"
>>> +
>>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>>> +do_image_delta_update[cleandirs] +=3D "${WORKDIR}/delta_interim_artifa=
cts"
>>> +
>>> +DELTA_UPDATE_TYPE ??=3D "rdiff"
>>> +DELTA_RDIFF_REF_IMAGE ??=3D "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_T=
YPE}"
>>> +DELTA_ZCK_URL ??=3D ""
>>> +
>>> +def disable_delta_update_tasks(d):
>>> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
>>> +    d.appendVarFlag("do_delta_rdiff_ref_image_fetch", "noexec", "1")
>>> +    d.setVar("DELTA_UPDATE_TYPE", "")
>>> +
>>> +python () {
>>> +    import os
>>> +    path =3D d.getVar("LAYERDIR_cip-core") + "/" +
>>> +d.getVar("DELTA_RDIFF_REF_IMAGE")
>> I would suggest to remove LAYERDIR_cip-core or replace it with a variabl=
e as it makes it unusable in downstream layers. This class should not conta=
in any cip-core specific elements.
>>
>> [Adithya Balakumar]
>> Hi Quirin,
>>
>> I understand the issue you are pointing at. Could we reference  "LAYERDI=
R_cip-core" through a variable defined in this recipe. As in maybe have a v=
ariable (lets say DELTA_REF_ARTIFACT_PATH) with a weak default assignment w=
ith the value of "LAYERDIR_cip-core" so that any downstream layer could ove=
rride the variable with a different value.
>>
>=20
> Why do we need to reference a layer at all? Can't we just define a generi=
c location, maybe somewhere under DEPLOY_DIR_IMAGE?=20
>=20
> [Adithya Balakumar]=20
> Hi Jan,
>=20
> Do you mean to store the previous image build artifact (.squash / .verity=
) in different folder in DEPLOY_DIR_IMAGE itself and pick up previous image=
 artifact (if available) for the next build to generate the delta update?
>=20

I didn't think this through in details yet, but the basic idea would be
to look in some build folder (rather than in layer sources) for the last
version. I would not simply use DEPLOY_DIR_IMAGE itself, rather request
the user to move the old image explicitly under a path that signals
"build delta update as well".

Jan

--=20
Siemens AG, Technology
Linux Expert Center


