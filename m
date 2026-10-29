Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12357.1793281690057087672
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 06:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vwU+bgK8;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeOelssps/uyBfHMY4UpjrlP8Ri4A2YxLRbBAvIZbZsfCywVcqS8TiLJU9fpD44wNY9xXMjEpWP4n55MWIu9cEBOXI2eZA/J2M6XpbBAZkDOGtWvkiZyC0nNNTOqGxIriTuMa0bNLPPlkl2i0E1qAr8QFC9/3OnwhtUEXs2eT7ZDa2KvLAjFc6p6Y8yH2GRyzkj/+SvkOSOPJSl+5r0drjac/2yMXpTWBgxhJnzKoiH2fSvX8JSnyvvWf/X5xpyH14u4jdSSCPFUc6wP4YG0KRMFfwQ+OJFeFcu+JU1imynR254mqUGEx5twnprOG+9RDf16tamcxssk5zFbl4boEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Z+ecRgNQwuE8+qa7RTF8o0nOa/k+pnVPwJmFr+VlM=;
 b=kU/zcVMUlY1N3EdgdSm/1LELjV+E4oHPQ6xAPuKJpfzGpBXcnoXCD+aKjFUhKEi2U9AxDboevRzwIS4UY+6e06LyHxKYKpZN208G3vfbQfQzt3OTGyFOLcNBYEI40O4AiHq+HKqixH6XxiBLNsEbk904hJuCOOrrla6VB7z/MyjFRMhcay4GA0an8kBFlnI9m12z3bxL/Qx+KlovYnXklTOaAzMnq4FWe1Jj5T1sl4HuPqNYUSS2/X5a5+8cV1DVVuCIXu9jhckMZiB4vyDKF8gsnHi89t49MDbvTua70ELbUlAxlPfYXPHsvxV/VZlS1olWC8tEkscM5jl5Q4Pn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Z+ecRgNQwuE8+qa7RTF8o0nOa/k+pnVPwJmFr+VlM=;
 b=vwU+bgK8p4jotkF3ePptHwkm2go/Vdj6LrdIP8hJRUMsG5ZE21EooE3X7SPKm3Aw2gToqaOe2vqEvBTGgtwnFJoSn8jMQ85kv7wZbcNmvuXfY3CavBG50K62bY/WICMtoRjM/5WmeNAfeGkFcW+wtgEtdbk2pXh1D6tZhlCOa9XQ+cyNBQrFsluycgN5DNLAISeen2Mjc08R3Rs6116MCWeMMv0puraQR2eKRWLHcrxGbzpGToSBcOjVSMt8Pk4mXy4BlGBs/6XtKub6yolgI6LA08emMth2GfBBjf7vNHMaSMAH099dtLL6wYrPBuKP5BPNQGbgq2Z0VVyK+20K1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU2PR10MB7835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:48:03 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:48:03 +0000
Message-ID: <d49633ee-f3c5-4e3c-adb7-5134444641cb@siemens.com>
Date: Thu, 29 Oct 2026 14:48:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org
CC: Lukas Rabener <lukas.rabener@innomotics.com>
References: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
 <0ed181fc-d81d-4fd0-ab00-94d96bd80f9c@siemens.com>
 <d1517c5d-8207-4d37-8f43-a85d79034e3f@siemens.com>
 <64d6b369-e67e-4025-a420-3c69cca3735b@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
In-Reply-To: <64d6b369-e67e-4025-a420-3c69cca3735b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU2PR10MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332727b-37f9-4826-f8fb-08df35c34106
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4022899009|261022113327099003|11063799006|4143699003|56012099006|261009223027099003|10067099003|261021130227099003|261022075727099003|261026121527099003|261022115727099003|261026130827099003|261028144727099003|261026140227099003|261026135527099003|261021121427099003|261021133027099003|261022105027099003|261021135927099003|261021123027099003|55112099003|18002099003|22082099003|6133799003|13003099007|4133799003;
X-Microsoft-Antispam-Message-Info: 3BGCfZe1tSUexb8CbC8UNEmRNrBzxTtAQp+v6j9+qTQWgXZZsTMoiYX1lfwUdoojl2NeZ70en6L9vQoYEEsF0li749JDaHlX4TlvdnryRXrLDts8DwT9NTbTALwXbzi1eyyuCjcq31qnOULMy3zbB6klDFLEBzQxA/gRrBYIq0T+xMfDllGbs1CR70rsYaT2JLeNB+IPvaGEfQfJZAccRdlGVnfGkucUY13byS0GBNa5Zc5R/kovzmnFVoTrVUw6LWDDJQLj7B59942y8JOswrXsjokmoQdu0kY5In7asLyDnNrhcc+EsKQUqrpChgoL1MqhSwdpKVStnZeLavxr1EQ+1Cyfopz0L7tUGgHWQUGcFgYxgXVcsm3W5sp+TFxiG24348sa+ovVsxbY7ZtPYXO3mxs0Mn3l2rEYLwlYjVmyQ2uVCgjFbcso1Qv9hvnBA83Q1z9+a1I2rojbHMu/E9FvI++eeU33k6IIOMQgz9ejrb9x3Nylkm7mBsvt+m6SUaI9/oj6IUXDx8xy5FDnZVP8sH+b6tSpnxPCzXz5L22CEyjCgB6l30gyrVTgIcC2uV0rYcx36gS9paj4+No+TbSuAp4boAg++pRLb+CK67g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4022899009)(261022113327099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(261021130227099003)(261022075727099003)(261026121527099003)(261022115727099003)(261026130827099003)(261028144727099003)(261026140227099003)(261026135527099003)(261021121427099003)(261021133027099003)(261022105027099003)(261021135927099003)(261021123027099003)(55112099003)(18002099003)(22082099003)(6133799003)(13003099007)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkowVzFzdHBlbkZoWjU3UVY0ZVQ1S1hOQUtkWG9CY0UxRC9Cby9IM2JmcHcx?=
 =?utf-8?B?SVVuWStBd0lNSExlWnlYd09YTHN1UFU2WTA4YjFMelorSnR4WDcveDIzQ0dX?=
 =?utf-8?B?cXRrSERRRStmcVgwWkVJeVpUODM1bC9xTTZzVmNoOTdmWFVpa2xLUXJ3UXEz?=
 =?utf-8?B?VVI4TWpnK3dMOEsrWDNSUlJmNEY4Rlh4Uy9tbjBnN2pQcG5lS3p1V3lSYStM?=
 =?utf-8?B?eXhxS2djZGhuMEd1VTFGNjN0ZzVDcVhSK2xtbExHODM2ZThRek5GbEcvZlBN?=
 =?utf-8?B?dG9mZ3BTUk9nRFFpdjhTQzUyYkpXcG90MTVPUTUzeUNoL1l1dStWNHkxTk12?=
 =?utf-8?B?cm9wQ3FLQW9BNVhLdnQ5VVZJYWRqWFNJZEdMb2dsaG4vZWwvWGo3bTJiYjlr?=
 =?utf-8?B?Q1FmYkRKOE1qYVNMdGpkZmk0Q3JUeUpBaVhNb1RTVFZUSEhwVEM4blBLbWg4?=
 =?utf-8?B?TWpFT3VyWUpjVFJLTUc1UHdJZkdhUjhtTlRINXNDZkpGV1MrOUFOMFFoQXI2?=
 =?utf-8?B?REdMYXhHbWpaeVBoSkJZVFdxYmxMQm90M1NBU1ZtVTRKY1ZDalVIYlZLQlJt?=
 =?utf-8?B?bzEyN1B0OWM3aFVWcDZmOUlWNUlUUk1INzJZbVdSUnhDNGhuL2M4ckFFdjJK?=
 =?utf-8?B?VGN2eExVY1FNVjdnM1JIcHdyUGtVcEIzYVZzR1BRZFVzQzdQcXFQVnkwWHAr?=
 =?utf-8?B?dndDaTN1TGNoSWtOaGROSklOd2VtWkMzck1wMG96ZGxjblVZS0xzQ0ZQMmxp?=
 =?utf-8?B?NlUrd0J1UGF1cUFzbWsxeVU2Q0hidFB3VTNJOGFacVE5cmxoRFZ5VXJpV0JN?=
 =?utf-8?B?MVdPUWdXVFRwMTlFSmx3U2N2Z3Vocm9Pcmh5bVhCcHMxSXV2TFU5R3JwSk5P?=
 =?utf-8?B?WFFlSmJ3UEZpb2FkVUhJdUlxanNZdVRtQVkvSnY1Ym5mRUVRTXVBa1poSTIv?=
 =?utf-8?B?emQzQzBOdlNvN01uaHdIVkxURjcyeFFpdjR5aXNqRUUrcmtwZ1laaXg2eWFj?=
 =?utf-8?B?ZVdLdU9UeWM2c0h5SFU5cXNNd3hMMFdST3RPU0h0bjJPUlhsOWJQanMzVXAx?=
 =?utf-8?B?OHkwTUFIZkhUL3BoMzZuc2xYT2RPOVUvTm9BQnJVR1RBcDFDM1hCbG0wem1Y?=
 =?utf-8?B?bWxYamhnU2JJUDVYa1JIM1dHZVkrQzh3aFhqZEQwNW9hNTBDR2JGZWt0bXlG?=
 =?utf-8?B?dUxOK0FWZVJFMDJzU2hHQlF4QVVvWllsUTZmVlpzbFgvaGZOa3Izc0FzNWs3?=
 =?utf-8?B?czFQUGcvZnZNemVVbU5JRVFBRFJ2QU80UnNSODFack9tbDduR09HSC9UUXc4?=
 =?utf-8?B?UW80djF5a0U3TkZsaWxLaHZta1ZxR2dFTlByMGY5dzBSazhnMjl2aWcwYVBQ?=
 =?utf-8?B?REdFbnRkWm5LRFV4NDVKbW1ib0pnMG01bDZ5VksyNHNESWx4WVNzeWJsZXA3?=
 =?utf-8?B?WUpOTEpkcklKRUdEZmxTQVF1WUt1di9PZmJxSWxTVEdwS0hRekY1ckt3eFBx?=
 =?utf-8?B?OG5yb0xNWHhILzRDUHRZM3AvbFB2eE56WTdsSWIycy8rUFh0RjlkQWo2SzU2?=
 =?utf-8?B?dldzbUlKcjdDVjZHbkl3aG5uUEhyUUJXdW1HWGZCbXJwY2xnSWlUNHBWMWFu?=
 =?utf-8?B?QjhRWXpmTDBWTklBR3NSZ09ETFhNVHAwbDFmWjBEY296M0FJdk0zSkVPb3Nj?=
 =?utf-8?B?REJSSjhsQTgxTzFqM1hMWUN0N2crNkQ2b1RXMGRINllwZ1FtcjRYT2Q0V3Iz?=
 =?utf-8?B?eFJHZ2ZVbWFOQTlZNU9SWjFJaWo5Vnd5dEt6RFBJNGFHWDBVakt4YzNFZ0dY?=
 =?utf-8?B?aDdLQzhVbkZBSTdWdDJ5bnpiNG1LcUVVMzU3RHV0N1VZdnEwck5RcjBUQWtq?=
 =?utf-8?B?aTEzbTBjNTlkUGZVV3lSOG55Z2NMUHJKdWRMeHRDcEJTYnpDKzZMbmsxMktT?=
 =?utf-8?B?YUNaVjBPTVVPb3hMSlpQeHMwS0RRTk9Ib3hWVm9KSSt2Ykc4TzNxRUowcWZi?=
 =?utf-8?B?ek0vZWNUWDZyRUs1UlhrV1NQSkV3amRydWxMejFNL1RGSFNEdnE3RmpqSEgv?=
 =?utf-8?B?Um1nc0gzV1JTekxlTzFBb09FSHArQnkzelRwSXR3a1dzWUh2eDViSUhzc2ZQ?=
 =?utf-8?B?TEkxSXhhTzRZSVFnRHNJNWs1WnV3cjhxNC9jUXNOT1J6eGY4cjBNL0I0MDNv?=
 =?utf-8?B?WThDcU9pNThZRkVXL0RTT0dnYXdQeUxkaGZvd28yNWIxb0k3ZDNBRFhrMFZI?=
 =?utf-8?B?ZzR0WkR2YlgwTzJWcjdGOEV1Wm0vd1l0VGFJUDFJVDkxN0xLSlhBckNlQ2hi?=
 =?utf-8?B?ODIwVlg4U29lbjhiZHpub1JIMDU3T213aGZpTDJ5VFM4ZXYyWFV1MStKRlpt?=
 =?utf-8?Q?wmDieamso0fA3aqs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332727b-37f9-4826-f8fb-08df35c34106
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:48:03.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPnvE6dBUG1bKMFRyU9G7LtnZeqKv3OzTxsIE7qxf7cUlFcK9Ui9a28+9Vs+e5ZU+jt0vZfqgS9dwAlyfsiWTpFLhChpZy/nAhnPRiNaSrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 13:48:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24573



On 10/29/26 2:43 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 29.10.2026 um 14:29 schrieb Quirin Gylstorff:
>>
>>
>> On 10/29/26 2:21 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>
>>>
>>> Am 29.10.2026 um 12:16 schrieb Quirin Gylstorff via lists.cip-=20
>>> project.org:
>>>> This removes the postinst template of the cip-core customizations
>>>> and also allows to reuse the `recipe-core/customization/common.inc`.
>>>
>>> Is CUSTOMIZATIONS now the way to go? We discussed at the ISAR Meetup=20
>>> in Prague but the decision was not clear to me. If so, we need to=20
>>> discuss how to handle more "complex" customizations e.g. sysctl=20
>>> settings wrt. scalability (nr. packages) vs composability=20
>>> (granularity of those packages).
>>
>> As the hostname one is already there why not use it.
>>
>> As I see it the customization feature for complex use cases has no=20
>> benefit as these are product specific.
>=20
> Then we should question if it's really worth to keep those mechanics=20
> alive artificially? If it's used for to customize the hostname only, the=
=20
> overhead is pretty huge.
>=20

That is something we should discuss on the isar mailing list.
I see a benefit for the hostname and /etc/hosts configuration as this is=20
something every image needs to do. But I see not the difference between=20
a customization and a feature.

Quirin

>>>>
>>>> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
>>>> code.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0 recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
8 ++------
>>>> =C2=A0 recipes-core/customizations/customizations.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0 .../customizations/files/{postinst.tmpl =3D> postinst}=C2=A0 |=
=C2=A0 4 +---
>>>> =C2=A0 .../customizations/hostname-customization.bbappend=C2=A0=C2=A0=
=C2=A0 | 11 +++++++=20
>>>> ++++
>>>> =C2=A0 4 files changed, 15 insertions(+), 9 deletions(-)
>>>> =C2=A0 rename recipes-core/customizations/files/{postinst.tmpl =3D>=20
>>>> postinst} (70%)
>>>> =C2=A0 create mode 100644 recipes-core/customizations/hostname-=20
>>>> customization.bbappend
>>>>
>>>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/=20
>>>> customizations/common.inc
>>>> index 0fd3d4f8..888f12f5 100644
>>>> --- a/recipes-core/customizations/common.inc
>>>> +++ b/recipes-core/customizations/common.inc
>>>> @@ -16,23 +16,19 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>>>> project.org>"
>>>> =C2=A0 FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
>>>> =C2=A0 SRC_URI =3D " \
>>>> -=C2=A0=C2=A0=C2=A0 file://postinst.tmpl \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://ethernet \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-silent-printk.conf \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf"
>>>> -CUSTOM_HOSTNAME ??=3D "demo"
>>>> =C2=A0 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
>>>> =C2=A0 INSTALL_WIRELESS_TOOLS ??=3D "0"
>>>> -TEMPLATE_FILES +=3D "postinst.tmpl"
>>>> -TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
>>>> -DEPENDS +=3D "sshd-regen-keys change-root-homedir"
>>>> +DEPENDS +=3D "sshd-regen-keys change-root-homedir hostname-=20
>>>> customization"
>>>
>>> CUSTOMIZATIONS +=3D "hostname" adds to DEPENDS and DEBIAN_DEPENDS=20
>>> already internally in image-customizations.bbclass
>> no it does not work that way as the image-customization.bbclass is=20
>> intent for image as it uses IMAGE_INSTALL.
>=20
> Yes it is IMAGE_INSTALL as it applies to the image. I just copied the=20
> variables you were using in customization.bb. But that's the point,=20
> don't depend on it but use CUSTOMIZATIONS +=3D on image level instead and=
=20
> you are good.
>=20
>>
>> That design is broken if you want to use via another package.
>=20
> Why use an image customization outside of an image? That's the sole=20
> purpose of it afai understood.
>=20
> BR Alexander
>=20
>>
>>>
>>>> =C2=A0 DEBIAN_DEPENDS =3D " \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifupdown, dhcpcd-base | dhcpcd5, net-to=
ols, iputils-ping, ssh,=20
>>>> sshd-regen-keys, \
>>>> -=C2=A0=C2=A0=C2=A0 change-root-homedir \
>>>> +=C2=A0=C2=A0=C2=A0 change-root-homedir, ${DISTRO}-hostname-customizat=
ion-${MACHINE} \
>>>
>>> Same.
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${@(', iw, wireless-regdb, ' +=20
>>>> d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('INSTALL_WIRELESS_TOOLS') =
=3D=3D '1' else ''}"
>>>> diff --git a/recipes-core/customizations/customizations.bb b/=20
>>>> recipes- core/customizations/customizations.bb
>>>> index bf6e7175..3f931b8c 100644
>>>> --- a/recipes-core/customizations/customizations.bb
>>>> +++ b/recipes-core/customizations/customizations.bb
>>>> @@ -13,6 +13,7 @@ require common.inc
>>>> =C2=A0 SRC_URI +=3D "file://ssh-permit-root.conf"
>>>> =C2=A0 SRC_URI:remove:security =3D "file://ssh-permit-root.conf"
>>>> +SRC_URI +=3D "file://postinst"
>>>> =C2=A0 DEBIAN_DEPENDS:append:secureboot =3D ", efitools"
>>>> diff --git a/recipes-core/customizations/files/postinst.tmpl b/=20
>>>> recipes-core/customizations/files/postinst
>>>> similarity index 70%
>>>> rename from recipes-core/customizations/files/postinst.tmpl
>>>> rename to recipes-core/customizations/files/postinst
>>>> index 62e9a1a2..c65e2d36 100644
>>>> --- a/recipes-core/customizations/files/postinst.tmpl
>>>> +++ b/recipes-core/customizations/files/postinst
>>>> @@ -14,6 +14,4 @@ set -e
>>>> =C2=A0 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/iss=
ue
>>>> -HOSTNAME=3D"${CUSTOM_HOSTNAME}"
>>>> -echo "$HOSTNAME" > /etc/hostname
>>>> -echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>>>> +#DEBHELPER#
>>>> diff --git a/recipes-core/customizations/hostname-=20
>>>> customization.bbappend b/recipes-core/customizations/hostname-=20
>>>> customization.bbappend
>>>> new file mode 100644
>>>> index 00000000..2fb4dad5
>>>> --- /dev/null
>>>> +++ b/recipes-core/customizations/hostname-customization.bbappend
>>>> @@ -0,0 +1,11 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2026
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +HOSTNAME ??=3D "demo"
>>>
>>> The value of this bbappend is quite limited. To specify the hostname=20
>>> for a particular image build accordingly one needs to set HOSTNAME in=20
>>> the respective config (machine, distro or local_conf) or multiconfig=20
>>> anyways. Else every downstream ends up bbappending those recipes.
>>>
>>> I'd prefer having HOSTNAME for demo purposes included via a kas-=20
>>> customization.yaml (or similar)
>>>
>>
>> I can fix it in v2.
>>
>> Quirin>
>>> BR Alexander
>>>
>>>>
>>>>
>>>>
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>> Links: You receive all messages sent to this group.
>>> -> View/Reply Online (#24567): https://=20
>>> eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.cip-=
=20
>>> project.org%2Fg%2Fcip-=20
>>> dev%2F&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C2a2a77db2e66=
4e82395608df35c0bb9b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C639288774=
047991760%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM=
CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhL=
1dRYTVDUF9hgvOZmZXkAh0CaLSGaAdSmztMob0cf0%3D&reserved=3D0 message/24567
>>>> Mute This Topic: https://eur01.safelinks.protection.outlook.com/?=20
>>>> url=3Dhttps%3A%2F%2Flists.cip-=20
>>>> project.org%2Fmt%2F121992122%2F8886423&data=3D05%7C02%7Calexander.hein=
isch%40siemens.com%7C2a2a77db2e664e82395608df35c0bb9b%7C38ae3bcd95794fd4add=
ab42e1495d55a%7C1%7C0%7C639288774048044071%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0=
eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo=
yfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dt5ju1wl00C6Od%2BLCWEqE9xCVy1ymcXPFxqOG2fICQU=
A%3D&reserved=3D0
>>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>>> Unsubscribe: https://eur01.safelinks.protection.outlook.com/?=20
>>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>>> dev%2Funsub&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C2a2a77=
db2e664e82395608df35c0bb9b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C639=
288774048086780%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA=
uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat=
a=3D0b05HH58ADoebxwxqeQW4VfuTcQY%2FwxfwqrESs9A%2FQ4%3D&reserved=3D0 [alexan=
der.heinisch@siemens.com]
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>
>=20

