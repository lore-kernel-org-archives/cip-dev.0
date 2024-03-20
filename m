Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC6C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 13:31:22 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.52])
 by mx.groups.io with SMTP id smtpd.web11.44776.1710941477557893772
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 06:31:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LM40romE;
 spf=pass (domain: siemens.com, ip: 40.107.8.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4AYZnPGq9ozqz09tXSdcvvAw8KyY6x9dMM27zdLFCiQBtpVpPRmj8IzdsIruIF+yGCgw+jR1/izGSHhqgeDwhdSfms6QfyzkB13/CgSaVM1uqpkT/dAlOGcL7fXVJ4M/X74ffClWNIUCMBOfmEYDbmqABvewFF6YtR7p8Ua6fQjkzbGh3FH+fA3BKFhhLWh7mz4Crz2T8L8I3l8B6JIAkZqstVE/5JgHxWAQUcMOYfjipkfLSBLXw60k8Lg5eCZl64FvzfftVzZ3KIJpQdwdmueoYAznBZLdU/5c83MJ7KE5T5yAqljPz2bM5rQdmrQ6qtOuLrAFXbLOjaQoMNIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wqgstgo/eSsIf6j6PVcDzRapCfulhxsP+8f59g6eyQ=;
 b=CvdHW9E3YpBzxZaF2pgfq+Mwe14HMnI+xZp5bKkYWewBuQgnNTxquSzIKaBxiTKEOy/XgZrI4ZMB/QtImF7FWPwYs/CPAh1DHYvDkWWQ4+gVZsveG2uNHjaankMvHUbaougEMPCnCpSHtAfXAwjvT4z3P/rHmuJuxbyUTuX+pND5HSQMsMS4hBq7t0/82suKz4Cw23yZ4jZVtcKbfGj/0TeHMY/i843DEx14UhgpBOTGQMyVi0vvKivwYMxHLx9MHITMeJrHa/vGf8QOgvRtqBLr2RKpPUa1rXNDIje9hVkHhRZpSmWYpuI/F5iqFwvQzIRZx7F2m6QzJyOVRHNAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wqgstgo/eSsIf6j6PVcDzRapCfulhxsP+8f59g6eyQ=;
 b=LM40romE2V6zDPgF/kheb727xVKtz5sZ56gii9/lPWoZRUbBkUu8dWZN9LnfRgu9WXIGyT/F6beNtvhfGeTwF6bKJY8+HIQxsPav7kLnblMNur42Pn8cylgMtl/DUfwTf5o9URt8+rdZvoh7oFAD/KopYuVmW/lS9kdUyskOR/W+EygR8+FnLtpKaG5FY2ECI4g2Eo3+JMpJawz+dE8O4ZMiSx/qxvFrBSQD47xkaAALSbywM91B3/ohmcaTi7W0jbjjzG2BOlyjvOzC5vQAVR88wXssPXNBqD58gy+o348A4qlQqYPDomYhrWMcqeGJC3p/RtfpEmjhLJmEwidfZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB8164.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 13:31:14 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 13:31:14 +0000
Message-ID: <beca38bf-8cad-4d51-85bf-cfc9f1d0b9a1@siemens.com>
Date: Wed, 20 Mar 2024 14:31:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-handler-roundrobin: Add
 link for handler search path
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Adithya.Balakumar@toshiba-tsip.com
References: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
 <3f30557c-6fdd-4715-a959-1cb27334a319@siemens.com>
 <6232a276-c260-440e-a870-55800807822e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <6232a276-c260-440e-a870-55800807822e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ec8af8-57de-4ddb-e182-08dc48e20341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aV99C+YgnquMjf5Tg09uwcnaYqoptfY7Z1zYs12GSicOMR+is31IfhnCkr6OHaF3lJrdt3IjDy9H2oWXOyPXxlC0UOUJLCrVKr1eVOF6aCRRfTABz2PkL+8nBDHrF1Y5wtzot9uvHhPEzrUNkEbIA1DCABc29H67MgR41xXXQwQ2q7+5FgVj7BEtHDhml0De+LKrYOK++SPpS9+zgkq0vYITrqjLRxjd+cGUcMcfJDVzgB5kY0cDdC1kB23NvLA2C9mCthWUK6UiGckBxXvo4B2lCMHo4o/+DGbisfmwmynMkpOg/XX0PPtyHLvNwbbqqHsmOSjZEkrg6hhHMiRFH8PBtdiJA0l8S0G2Lr5b95q1RjYoZIZOo9G39K45NzV2OHfi+Q/S0Xmck0rmOPkXp/3NVdD6izf9q77Vz2mCvEhpAfwBR6H2KoOC2/V9MXBvkHCf6M9N/Rvtwm3K+6YWqphBLZW5oivXYcgt58bnaBMDRmE6yhmsV5Oh09Dx7Gl6TWnC9W3BlgGnGQOiHMAxmdZIRX48JE5eyx4TodiiqQgHmm6k6zu3a0lBJe0D/z1A4VOFIzBywl/oBEoPuJ7owYot0xoxU+Y4FVgTKE5tG5U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cyRsKvSPyDJ82dxDDLbiARgCXh5iiF8hYDSy+V/46U2ifQYAEKZV+BoOvPjQ?=
 =?us-ascii?Q?K3adNt202/6CTPNMj1xbS/dJj+9bM6BBcu3yzs0rgmMSg3worJgTZg/x/rsK?=
 =?us-ascii?Q?clFtobpaPE+zumeZFo6Ieex/noxRgrr/VHMh3bMimeDttQYdaEBVwsjHGd3U?=
 =?us-ascii?Q?DiTd6SXJEWEqQHkQlXBlr8Qu0pYXLkgohTElwieuXi0M9o7p6o2/5EVfmH3y?=
 =?us-ascii?Q?yH+8ruuCnqBrLU13NDRh4QVBQpAFOPZEoGmEbKrAiCKMUmOMNF7L5PxhAvIm?=
 =?us-ascii?Q?7EkPcDS9JpvdIoCNsFLgEsKWkYDSPsMvAz33BaIdLodN1uWniXeBRza+e/zo?=
 =?us-ascii?Q?XIhtipURZz/EPba+7IlXFRjEPlDdZVwEVknmAroRMOdzMycc4AgAFcP5EYpI?=
 =?us-ascii?Q?j3pSygPwV1GWvJGNvdxUgYFRiDa4cgpiw6d3L6zfBMWqAf7llISU51EajgdW?=
 =?us-ascii?Q?qjgl1GfjzkWcimLE2sCgFB8jYJI5RGso73GsrWklD9Gttpu4iRTTWLc4cnlr?=
 =?us-ascii?Q?aH1tPEBCVEJKFlWuC+7VcE7jblX/avsOb4z85dasaF2c2aBCv7G0P+z6zqNN?=
 =?us-ascii?Q?xJv/tNVZ5ZVums/7PxeMC7AmS/Y+PATuuYnOHc0u2Bte7MrwpS8U6nwGwfXd?=
 =?us-ascii?Q?2cInBl2awuObI+LpvHUIYrdqpu06NdU5keIAGLnxLyoHqsrhoQVB/aGgSyNN?=
 =?us-ascii?Q?2myeSI3I1OsxSh2VUi13prE1gslXCuZP4j6EVgDOPyKihEZnjUaezLhxrml0?=
 =?us-ascii?Q?BEMaREHFN8xR2nNGEe4RZR70mtrRpaLd22g0aDh7k+CcEg5LtWP+ZY4E9txh?=
 =?us-ascii?Q?lB8LXzDyCuNplapGZG52s5zyyx+6TGycGQz2xvlqz3K8Z6ijuSa4YGfVTP72?=
 =?us-ascii?Q?a+ZcybBdTJVDYMZoBtbrOv2KpWlMjP2Mhx5pEfXk26AklrhqRGvf7npvjLvT?=
 =?us-ascii?Q?6QhWDVm/J7R3Ec7oWt8DViz+daB539k2w4uvBAYLLsKr6hv6yoJ4dk/44sbD?=
 =?us-ascii?Q?UXgLGt2WG3345wFoOM1RrvM3TvP1LRRGv8QapyoJ5gEzHHcajj9Q9LTi/xUM?=
 =?us-ascii?Q?F9L/yMpwAsZnQ29PbED7co+IAe8Slt7d7geBuYxAbBEJGSsexoH8Vpu5s8Zz?=
 =?us-ascii?Q?3C+Gm8IEED/RnFxb+mfB21kW2jdpcEh9cYJ8aveFHX9uCFmWOjDxeJg4NxYi?=
 =?us-ascii?Q?299FwsdWnRkHqnRiLYM1YvDzPnk0q0uRIZkgOUqMVDH/k4h2raiV+qy2ZJei?=
 =?us-ascii?Q?x6EaB/LFJwHfLyU3mYgdguERhaNkoSG9buJde3MAFITET0GPWFst//aizO4l?=
 =?us-ascii?Q?rFnJoC/oF0EEO6Z9YVgGE7TmEO3YzlrSCUry9YX8UEOygScfVRNq+V7Cttg2?=
 =?us-ascii?Q?IN5pGgRz/NCbdJxSM+ZfoFSIpcLZ6c9b1u/609y6TTdQG/lAYwA4+OBbkDGh?=
 =?us-ascii?Q?+orFlvpe8t4wVb5NQvL2sT7w8CspxAqYyDSDfbqmsUetfFS9iHzh2oFpWv7C?=
 =?us-ascii?Q?7k8uPCyvU/pKNLYWineDlTQk2+b8rB2jqegDXQrsc2Bv4LiZphFBune2qkUn?=
 =?us-ascii?Q?cdacO46jMPwVPQLS9bxl4P54UdrXAApQZFFhu4keOFOrbmwvMUz5M76ttHZ7?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec8af8-57de-4ddb-e182-08dc48e20341
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:31:13.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFeIZME1+85uldy3EEAWPmuayJ5g6A3r6T7giH2rBbjjaZLFzLTFW9o3WjgNYl0E50ZEX3+bFQK6+6OcIB90YkzDAc6nipnABWwRh+7HEQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8164
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 13:31:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15391



On 3/20/24 2:14 PM, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
>=20
> On 3/20/24 2:09 PM, Jan Kiszka wrote:
>> On 20.03.24 13:59, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> The lua version which is used to search for additional handler is
>>> hard coded in SWUpdate and debian salsa[1].
>>>
>>> To support multiple distribution with different lua versions add
>>> the variables SWUPDATE_LUA_VERSION and SWUPDATE_ADDITIONAL_LUA_VERSIONS=
.
>>>
>>> SWUPDATE_LUA_VERSION defines the main version and for all space
>>> seperated entries in SWUPDATE_ADDITIONAL_LUA_VERSIONS a symbolic link
>>> is generated.
>>>
>>> [1]:=20
>>> https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac=
408d5db5de7e2de99/debian/rules#L13
>>>
>>> This fixes issue #102 SWUpdate failed to install update on bookworm
>>> amd64 image.
>>>
>>
>> Should this move in front of your recent changes in 'next'? Or is this
>> issue older?
> The patch can be moved in front of adding SWUpdate 2023.12.1. The=20
> problem was previously undetected as all supported swupdate version
> used the search path /usr/share/lua/5.3. But the delete comment=20
> indicates this path was updated once.
It was update with e17bf5cf83714e4783885f54a7939a51a8fba5a2.

Quirin
>>
>> Jan
>>
>>> Reported-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../swupdate-handler-roundrobin_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++---
>>> =C2=A0 1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git=20
>>> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrob=
in_0.1.bb
>>> index b39278e..95ceedd 100644
>>> ---=20
>>> a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
>>> +++=20
>>> b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_=
0.1.bb
>>> @@ -20,12 +20,22 @@ SWUPDATE_LUASCRIPT =3D=20
>>> "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
>>> =C2=A0 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?=3D=20
>>> "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
>>> =C2=A0 SRC_URI +=3D "${@('file://' +=20
>>> d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if=20
>>> d.getVar('SWUPDATE_BOOTLOADER') else ''}"
>>> -# lua version 5.2 is currently hard coded in swupdate @ debian salsa
>>> +# The lua version used by swupdate to search for additional handler=20
>>> is hard coded in debian/rules
>>> +# see=20
>>> https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac=
408d5db5de7e2de99/debian/rules#L13
>>> +SWUPDATE_LUA_VERSION ??=3D "5.4"
>>> +SWUPDATE_ADDITIONAL_LUA_VERSIONS ??=3D "5.3"
>>> +
>>> +do_prepare_build:append() {
>>> +=C2=A0=C2=A0=C2=A0 for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIO=
NS}; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "usr/share/lua/${SWUPD=
ATE_LUA_VERSION}=20
>>> usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.link=
s
>>> +=C2=A0=C2=A0=C2=A0 done
>>> +}
>>> +
>>> =C2=A0 do_install[cleandirs] =3D "${D}/etc \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ${D}/usr/share/lua/5.3"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
>>> =C2=A0 do_install() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT}=
 ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/=
${SWUPDATE_LUASCRIPT}=20
>>> ${D}/usr/share/lua/5.3/swupdate_handlers.lua
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/=
${SWUPDATE_LUASCRIPT}=20
>>> ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBI=
N_HANDLER_CONFIG} ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0644=20
>>> ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG}=20
>>> ${D}/etc/swupdate.handler.ini
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15390): https://lists.cip-project.org/g/cip-dev/messa=
ge/15390
> Mute This Topic: https://lists.cip-project.org/mt/105043814/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

