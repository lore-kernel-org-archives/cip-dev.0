Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59435CD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 08:44:07 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.107])
 by mx.groups.io with SMTP id smtpd.web10.160972.1712738635487583170
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 01:43:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=q5f0ELOf;
 spf=pass (domain: siemens.com, ip: 40.107.8.107, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUZPYDM66eJDIOJawB1SlrOI2Db6eoQfMxTViUYFvKiyWL83EpF7IzmxXts/r1jDEQsdf2JorEoPzzidExXZtBsRxzbYqsA2GWkwqnfOekhTMsjB6h4Z1hPE/+yPOyVGwV4kJL68gscT4jxzSdikFr8ontvsLfhDPDAZMLC8xPNsayNFeFAgc+BaYzp6gQhF3QHGBAuOnjsYhjGBrf8IqsPH+OkYuzptutXuHm1o3anDpP7tW4zVRKwspHBx/20Tyr5OAr8pRajJINEAXpiibeF8AidlS8rTb9CV1cUvJ0hjyYDgla3SuU7sCqeAUF3PjAFgTT6vzlC7itPtKGCOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GQbNA1A8R6Mwcx3vwGRezQpT4PnefagkYiAh0AT4is=;
 b=ZCF0Rss6fxuX51hICaA053veDC43mNQ6REcbhU1bXTTVivheMkoZH01K8n6O1Zv3jUmrO6zLmcMUT+cFCFVXW3eF31A2S8QbDB7zKaCjwBzf5oONqUUV2Vn398icj3tf74WGzASNAkbWHFjHcJkk/VHmIQBRLO08e0t9RK6UzgHAM4szP7u0QLaOY+WzwABcEwtP5ruuQFQW8WlRGjdxUbqigc92EFNj2tBod15IlXNyD8q7ECeWugOBUloQ7oLOMJwOlzGmRLSIFpCA1MoSwFsiNzsyR4bJjS5BAa9B0iQBmBAMIqozykhVPAYXeKPzLh+MRdtEWK0IJqyF0VxeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GQbNA1A8R6Mwcx3vwGRezQpT4PnefagkYiAh0AT4is=;
 b=q5f0ELOf37Eq2g/xc+gtHYqvsZ/ZQwIHCgxRhBXfLBFEhBOa+vsr56abft/GJZh0XXpOhwC7TEssxuL7JYcOtL/Pe0MCpenT6ooSS6xWSfu4cpk8JrQsfD7b0ayCXfPO/K5IekdLt1hlfZbLreyYq/JSJ+yY/Dt/+MbY84xj+MIzZvRrfmQguXYkfyzYQowT82yi1uHZogJJS9Q04ddhotGE0tHXq07O5soQzJ38tqff552eQcA3LeyX8GP/tb3aNAU1MwDCfBklbUvu62MTxZBalp6dFV/lguFUUNei3RwppgHWTye98DKM/wZsr+FpM5q0ZIaN5vJH9MbMtQBO4Q==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 08:43:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:43:51 +0000
Message-ID: <6306b141-580e-42e6-9e44-19a2de20c856@siemens.com>
Date: Wed, 10 Apr 2024 10:43:49 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <TYCPR01MB966987E730E8F8D621DF564AC4062@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ISNqCO341Udp9k5DbCXLL1uQt4/20W71V//BG2Ln49cHfyN5kcym7thoup7G7h3rvXGwbs5Y44uvpxCb6sGcevCV5PmObEzd3gh9Y+RCsNhsDtJWtroxi0VppLGJtGVtHP0JOdLuVcm2JHPrzmODyLj4B+T2x3Z+6uFLlQYIsH94FOP+MKUMLoIWudLcgGDZyhBGDTCLZ5ZRMykQs1o0dpYG5N7gSQKqzAVSErWPfn46kapPWDbdKPFzo7yh8vGdgcymFkjiOKpc9ziiLatezfmghnjzjwnCyTthEPWQGKgAdoHT1Y0/e+bK8Nb04Jgx43pOQU05p6jEk2rWwRSNikJFdU38Snhq7+0n4hmYkyRX7eIc5b7DWrobL4YOdQ9fEuvzi8NvmNwd5YXP9qjBxb5omKjgbLUfRQxgzraF64/ImPf7Yhk5CNTdbE39DTFkYgswS89uYXjGl3YsqZMcfuHujw0ePWvy08TU6IaLWe94dIsikXZ21DCUWPE+aHTGmQ6Hj4vf+AR7HEk/TcRAe4OYKvrh5wMn1wGa5J8ywBGtBdJ4MYJJT2Sjusa+f/MxMuPjS+q2TiCZbgmp9gH80SPf8vApERQCJfUy2aVRzB+eGQhWlhHhjr37AUFhcI0qvslx8lc2PPDXclqNV6DATovxFDfTTWvizrXTs9b/FbE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gOX+BuqgBEW2yHpTbPImDPEMdKDQxpTLPsktbc7o0xgI3J4kyonfg/aIh5D8?=
 =?us-ascii?Q?hPH5z/cTIJzt9zlEslSGw5XXRtR6PZPmbyDiwJEZE/O9lLk4/B8zJtw1UOIw?=
 =?us-ascii?Q?CqbUl1v6b2XfJbs67iKpM7sEHAPi+hVkdiuL5XzVPbmEIijNt3cQ/l4cbFGc?=
 =?us-ascii?Q?MUw8ZkLTNs5mfMleLkyzWl6VoeUXFhIF1FEufKdfT2a9p+yRlzAXHwPdt+YB?=
 =?us-ascii?Q?dMP975OSZWrtjXkhFVqt0yX3ZQBkJWHvnDZI0pmVDGFUapbKM8XCP7Iw3sjb?=
 =?us-ascii?Q?W9uk00hRXBMo+BvEN9+tHyd4ilId5Obf5TSlBoBeklZZsmed94h6BpP/uar5?=
 =?us-ascii?Q?oRtMkIvmQ04OkmPicYfQo1GeB8G50L9YXwSZQvigxLZYWOFABbtd2cxCpiM+?=
 =?us-ascii?Q?wTjcLXm57EAL20DMYXZmqFj8Wnqweid2GEOzgtU7gqYXUR2fkxaKFcLPvdtT?=
 =?us-ascii?Q?2A81+Bz8wVNRsx8AUCRcmrCjogSJx1RS224tFMY9UUaizMCyK71VPyUCIjc/?=
 =?us-ascii?Q?YHXq7FAZmpl/igZEuX52RgalZfvjcVISqNJUYTbFkhB83VHMBrEHOHEP3WKg?=
 =?us-ascii?Q?Hkx5KxixINNcu4cRwsLdwUJ3swkDp9ccKinDa0z8LJRgQOAiOYf8RpHO6aUv?=
 =?us-ascii?Q?rIC/qkErF8vGmqaTkuDLz3VL0beR4pmxGM+FOQ2G2YHW8f3i8p/faPWiL1TW?=
 =?us-ascii?Q?usbJUkzY7Arr4ZrBFQh8E7HgI4Fx35WBdWE0ria6RRpVBv4EYcz/w98HPxv7?=
 =?us-ascii?Q?saONjb0u5WB9h0JdVnC96lmOn9oeaw3SWwkNxDzRMUHefcw/0bQeYFA1n3yb?=
 =?us-ascii?Q?7RLMYE/nks3L15bNibGvW9X03K4ldR2Uwch1j9M3k99Gn/P3zKCqehb1jL0k?=
 =?us-ascii?Q?GEOfJc7UUChJP4X5/TqkD0VV4PMVv0I338OXNtWkeDEQbR3GTI0DKv1vnswD?=
 =?us-ascii?Q?ZVO5VsCSn+Ul2NkOAG8jQjqS5ete7u5RswOeakH2mVH9zZJV4dxo+rTtX1nx?=
 =?us-ascii?Q?ofAzm3KNOJsD6j1+vvQcEWwKnnlXOBwX22IMNaQ0fvzQPD33TX4IA9XrUVZw?=
 =?us-ascii?Q?p+z/BQ2nDZD+BgbyGbfDhKQmeP/hqeoIo0+Djg3ILyeVOKCb7D33dT0i66AP?=
 =?us-ascii?Q?PtUksOcNiezpuCqS/ASWqsw0esAVmpaGR8dkmQxo2yvgqKGg30eFlHFU3EM3?=
 =?us-ascii?Q?+BdA3H6EFww4kHgXumlVvH2spWJbZxPY+h4z6p8gMe+zH4UkfLyFknjW9g3W?=
 =?us-ascii?Q?U2pbSs34Zno8EenNTuZA2/c15OUcH/k4S8cbG1au99ViNJzCSDaFGEw1YXfJ?=
 =?us-ascii?Q?y0YeY16adxWBe2iGZAhrrd+3dh63O8wYGxBt3O7a6ZDZRlFEaFkaiHm3lkDM?=
 =?us-ascii?Q?GgpadJjOY79lkQ1I11TlgHXNV54Tpgz0LO6wQy4G2iz0Dla+d3221GCtHimC?=
 =?us-ascii?Q?AQ6nEJdwC5Z4K0Qih/Nxmt12n3PZO1rsFODIoML3OyLEKAPhpUC+Z1wPAInk?=
 =?us-ascii?Q?VrVLG5RdDAixVyulnjEQekYVDHgdIqOWDcMXqUVH+wVvu+qDGUGusgJwGn9P?=
 =?us-ascii?Q?w1PWYeFOQMsZ0ZJ85yK5dB2icizhdwILIrKeWIf8odmdymeerPtcBoK/w5cr?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa57fc-0443-4f7b-f691-08dc593a58f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:43:51.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Po12KFyZnEI+x9Eqn9XcD96n+31ld2Vee3qMtvfCQtr6cfO54lyGITWp/0wPvnHn4Z+8Mmcj4fBlJo9qr/7fcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7534
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 08:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15531

On 10.04.24 10:27, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Quirin Gylstorff via lists.cip-project.org
> Sent: Monday, April 8, 2024 6:25 PM
> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Ad=
ithya.Balakumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=
=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=
=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kaz=
uhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core][RFC v2 2/4] Add Delta update suppo=
rt with rdiff_image and delta handler
>=20
>=20
>=20
> On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
>> swupdate supports delta updates with rdiff_image and delta(zchunk)=20
>> handler. This change adds support to use either of the handler for=20
>> creating delta update artifacts. zchunk based updates are supported=20
>> only for sid.
>>
>> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables=20
>> can be modified based on the update type in the swupdate.yml file.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>   classes/delta-update.bbclass | 107 +++++++++++++++++++++++++++++++++++
>>   conf/layer.conf              |   2 +-
>>   kas/opt/swupdate.yml         |   5 ++
>>   3 files changed, 113 insertions(+), 1 deletion(-)
>>   create mode 100644 classes/delta-update.bbclass
>>
>> diff --git a/classes/delta-update.bbclass=20
>> b/classes/delta-update.bbclass new file mode 100644 index=20
>> 0000000..8443f35
>> --- /dev/null
>> +++ b/classes/delta-update.bbclass
>> @@ -0,0 +1,107 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +IMAGER_INSTALL:delta_update .=3D "fdisk zchunk rdiff"
>> +
>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>> +do_image_delta_update[cleandirs] +=3D "${WORKDIR}/delta_interim_artifac=
ts"
>> +
>> +DELTA_UPDATE_TYPE ??=3D "rdiff"
>> +DELTA_RDIFF_REF_IMAGE ??=3D "image-v1/${IMAGE_FULLNAME}.${SWU_ROOTFS_TY=
PE}"
>> +DELTA_ZCK_URL ??=3D ""
>> +
>> +def disable_delta_update_tasks(d):
>> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
>> +    d.appendVarFlag("do_delta_rdiff_ref_image_fetch", "noexec", "1")
>> +    d.setVar("DELTA_UPDATE_TYPE", "")
>> +
>> +python () {
>> +    import os
>> +    path =3D d.getVar("LAYERDIR_cip-core") + "/" +=20
>> +d.getVar("DELTA_RDIFF_REF_IMAGE")
> I would suggest to remove LAYERDIR_cip-core or replace it with a variable=
 as it makes it unusable in downstream layers. This class should not contai=
n any cip-core specific elements.
>=20
> [Adithya Balakumar]=20
> Hi Quirin,
>=20
> I understand the issue you are pointing at. Could we reference  "LAYERDIR=
_cip-core" through a variable defined in this recipe. As in maybe have a va=
riable (lets say DELTA_REF_ARTIFACT_PATH) with a weak default assignment wi=
th the value of "LAYERDIR_cip-core" so that any downstream layer could over=
ride the variable with a different value.
>=20

Why do we need to reference a layer at all? Can't we just define a
generic location, maybe somewhere under DEPLOY_DIR_IMAGE?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


