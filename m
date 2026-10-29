Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11981.1793280607922613925
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 06:30:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=g3gFGVFz;
 spf=pass (domain: siemens.com, ip: 40.107.159.14, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPtkiYLEmNrZX1r0KFigOQHFXWOq0pkEnNVvf3bw4dEIpzwB0gxJLSQRZz16ei7UZm/GrYJHptbiERuyGxDCvcQm404Sb0Ko6PVsKDzSdSdr8mC/4sYJ1pVu6ki1Q4mx07yem54tcmniCRmEypTjDCSsaiYHciDusrH0a2dxQDqbMuxRqudEC1Ph8hF3tn4tgh7VcoBJ/RhZTNKo4t9W5mcaTV7WkkKU6AJubA8giizyg19JgMngzXZD0du+1t6c+w5I1PvyE79oJQ2IjB02jfg7RDid9uYWvV6QXBU/6AWiLJ8GhTKQzYS5i9uGOTwSDGYolXwGB+0S8jFF6xA05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I5rb7OfQiNDWc3qETcWQT3TfkLfgROtdc+ZBCKDslU=;
 b=pUbH8xOY+PrQwoO3VAyh/HhSRV22iGRG2hS1bu2HDYapAI3QhtntCNgrp7WVTJ6uf97LofGRu+OWCFDtNDLXtKNBStPkZOfPFPK/tqlde2zNqeETfnxbJ6QGmZtUqKLg6uoHztUn6ECI0p8bZle4RMyXfLv8GV6zWgLMqLEK4tyA5J8C3KWc8cMNarDfD72Gtc0nrqa/WH8Kn2gXpCiIoqViFYpYC3vpCGVX5nZs3scoI9pD4FZQQj73oVt/UzKPb1jbGWkorC295hhv0TpRX+fdlh3mTFD64EPHz5zzEDEbCqi2B61pon0kQeGBwvgoMIf8Im8Z83F0Jdpm6dwnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I5rb7OfQiNDWc3qETcWQT3TfkLfgROtdc+ZBCKDslU=;
 b=g3gFGVFzHY3N70s9VskSOdjePWj2TvUYIKyk9i8H/6Ohow1+5jqPKbVUz4dbsDaIxGt8hNS6MjjgFBjFLpPnRTiIrxqByHmbWt0umOVo4qJpvhBAEZthGYqQulzKV8YTIzSJmIXnpdNiHY6ffN0MlOAxILt9cBTi0KKnk9LxEQcwCgbbKl+Zj2C3bBd3jT6t4iJsPwtlGm+3OUE6Sg3c6yASIFeRqCsVkX8J6fvfibw+imXqWBKxdsAFONvj0wlwijp7V5JsrH21JARLGksgHPah8gKhBEF6FvacUz38BLK0xV2JAjwFn9q0UaDyr7gr2o9TlcP+lV2ZmYT2RtJowg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB5PR10MB7824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:30:01 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:30:00 +0000
Message-ID: <d1517c5d-8207-4d37-8f43-a85d79034e3f@siemens.com>
Date: Thu, 29 Oct 2026 14:29:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org
CC: Lukas Rabener <lukas.rabener@innomotics.com>
References: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
 <0ed181fc-d81d-4fd0-ab00-94d96bd80f9c@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
In-Reply-To: <0ed181fc-d81d-4fd0-ab00-94d96bd80f9c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM7PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::34) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB5PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2a77db-2e66-4e82-3956-08df35c0bb9b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|1800799024|376014|23010399003|6133799003|55112099003|18002099003|22082099003|56012099006|4143699003|11063799006|261021121427099003|261022115727099003|261022075727099003|261022113327099003|261028144727099003|10067099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +8376tF70jwgD8pXYvaHU178zkCOgkDDiVBHBY4Jq6CP1KpdacarwTsd+4pmnaTpvAgRgQEU1zaOJ4SqdyjwWUftTiIgIU+Tu9NOT65I7egYGz77z/RuY2CwpDu6yfmEIT9PMhuvxciB159F/BQLScWJIusEO12Z4gVNgqdhgE+4vDp25sBJtcuaQgZqkx4dPixRiWPRLOxCWxjQ7fUocDpqg5MWlhtx87c2l6mCFCxK1ybUHdUcdYgzSsMB/NyuP1SrQuFXwJ6dLwma1z+qOczR5AwX68Y0d0uZP9goXyUM3KPVMpRUv03CYHoCKxEHi0sj5deCrGZgQGV/4qAeYqm7VQa9D0oDUJ9eFO0CjwdfNFpb/cqiOOa9Wbuk6oEknqlVkF6FSQjf5m1XTPTgCDTvMu+8Y+Xb6b43trdtyxPp6jluzbY/JtbkgvFKrAJ86cnoi4gRnHvrx+SONRuKdPhjGHTsUhp5TQvMgat0C6Uw8oXw/1EcXmhTZ5Vq320YZ5okye+dDZgZgRH38CxoWpHBwHXZU35JWYN9LwyV7jFqskd/Us1P53o5UQk3jBHOIjFGLgYXEYLVHhDkEJLKrhwW3CqO8aXN+d0/jlIhVhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(1800799024)(376014)(23010399003)(6133799003)(55112099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261022115727099003)(261022075727099003)(261022113327099003)(261028144727099003)(10067099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA2aXc3QlFBRG5oOWZPdzY2aTZQZjc0bTU2NGR6UXg0YW44bzY0amoyL1M4?=
 =?utf-8?B?VlhMaTBxS09kd2FQUmxzTnYrMlVaa3pteVdkS3RzT0RGNGdmUXc3d3FIaDEy?=
 =?utf-8?B?YjJiN2RvVDNBdnI2Uk81eGJGcWVXQWFyZEl2WFUyZFQwenBWQnhVZVJ6cE1y?=
 =?utf-8?B?Q2FvY1hiTWI1RmhGSDJyb0ozdWNZcHN3R3I2VkJkV2IwVkt2RDM1b0lSY1dX?=
 =?utf-8?B?M0xWNUEyNDM1NHlkcjU5V2gvejFzbVNPeVhjNGpQaTlWWTdDWW1YRmxLNW1q?=
 =?utf-8?B?QTRJc3ZOdWYvVXNBd0RKb3kweGJFVk9tYUhyWHVOY3RZMjBsQldZN2N0Wlg4?=
 =?utf-8?B?VDgyWEJncStvTm9vMEd1ZW54WHJyb3poeVRVMkI2bTdRMXNLc2pPRjlzdkxE?=
 =?utf-8?B?TlIyOEtGRk1FZGt3VzVaUTl3WVRZTC9jaUNMcmhLV0owQ0VGS21HUU8xWHVr?=
 =?utf-8?B?MGorVjExWHpJWG5OS3JaZkk1bDRDdzNrUjV3RmE4UytJSnV2YU1FTFVRK2o0?=
 =?utf-8?B?WDZMMTA5L0NYT1FkVDZwejJPSG9KTUF3RzRKTytsbXNmRUhOVWhjNWpCRUJv?=
 =?utf-8?B?bTZmMjdhTDZzb0JDNTBUK0I5N3hVMWtNOUJaaWxkWkgwaUhKZ0FnRjV0b3FI?=
 =?utf-8?B?QktiTnZMTzBWOWl5M2hJaHZFNitCWm1yUVRVS0lNS0hCTnFQbWU1Y3RFVzl0?=
 =?utf-8?B?VUJ3dnp5WmpYb2t2R0kwTWhldFJKNzR1dW9YT1JoVkJWZTEzekk5QjBIU1lk?=
 =?utf-8?B?ZDlXOUhUVWVJR2pJcHNVT2NqSTNiTXNVRGZKQVR0ZW92ZnJoci9VaUg1SmNk?=
 =?utf-8?B?bjZoaExRZFR3RlFDQStFR3p2cmR6Yy9Obk1jcDRLQ0ZVeklFNmtxQzcxZzRp?=
 =?utf-8?B?VzY2UXFhSG5qUWoyQVRkdFBrQmYwWnJVMkVXMkhEMkxRQ3dGdzN0aWdaQnpT?=
 =?utf-8?B?K3Nhd1NCM08xc2tYaVZtWmFYK3JKYXpoeEpqL01jS2JjOERXZ2pYKzljSUh1?=
 =?utf-8?B?aEtFRE15L1NjY2JGTVE4NHRzbDdabEJQWWExK2NmUCtaM1RpSy95VDlQMFMr?=
 =?utf-8?B?dkNXVjczK0tQWE1ZOE9JWm50YlVWWVJEalQzc2RqTERWdk01NXpWaldWZ3NH?=
 =?utf-8?B?QU5RT21wWUpTODR3QWNkY1hCNXRxckhaMTQwcUJxL2djeWx6dkkyVEhjUkpY?=
 =?utf-8?B?MWhUMnpRK29JTU1hM2J0Nzg2WllvSjMrWmhSRTBiL2JVckhRRWtDaHNRQndm?=
 =?utf-8?B?eWZ0S292bnJKaUdjR2pXb0p6dVRhNGU1NkhoakhRVVVhQXdDRXpYZnUxTWVD?=
 =?utf-8?B?bUlDV3Y2cWlQUE1BcDduYzEwUE5rZnI3ajNsdHVxdjZxcC9HLzBCcnJBUTNP?=
 =?utf-8?B?Smwzbm45RThqVE56Q0pzclY4a2ZKVTZSWXFtM21mQ2Q5N05ET1VKR29BNndU?=
 =?utf-8?B?c0orVGEwNU83ci9EbGJXYkk0c1NjNS93OHArMk1ITWt4UVJRYzJOTFRDSFQ2?=
 =?utf-8?B?T3FBbUlRVWZsdnB5S1lkakhVbVhFVEt6U0NoUTAxbWFsR0JYaFFpUGZxNDhC?=
 =?utf-8?B?b2FWVFFTaExNM3ZjYmhiRGtjdGxhWG9DSzZLNDBScUNVS2JzbE1DZmdFeHFH?=
 =?utf-8?B?WkszTjlCUDZoTGZYM20ydHRXMWdIWjlXUTlwOU5CaFJ0cGJIRkxXZmNsTFAz?=
 =?utf-8?B?b1J2OUpMdy9vREJkSDZnMlp2T2xZOWRRNkN3eE1BWFdJTldiYzlZWDJTRkhl?=
 =?utf-8?B?N2dYMHhQeWsxUFVVQm00QjRsbmJpb3hOekhqOTUxTkFzZFZleHRDbWQwc2Yx?=
 =?utf-8?B?ZTRCb2FrRE5VcWZ5b0Z6TDlPM3FDMzZEeU1XeUZuY3JsYVlCbWk3WjRuZ2tO?=
 =?utf-8?B?Y1pKRmhWNW9BSUtqdy82aStrQUJDbUYwY1VjdW9zTm9sQnZldFVIL3REdHI2?=
 =?utf-8?B?MzRLNlQ4VTNETElNa3BFQmxCaWM5ZWI5ZnE1VnlhdmFka2REYkloYlZQVEtx?=
 =?utf-8?B?S1JxNXNKTFVydmRtTHRJRnRkejJtK29oRWliZExvcC94eDI5MlVYajlOdURn?=
 =?utf-8?B?M05XV0E2Mm9pOTlURTR0WG9PSFpHUkVlTy9qaE1YdWJPdHBkYnlsQW85cVMz?=
 =?utf-8?B?NEkxNVJJY2oxUk01K1JqNzhHbGFBRnpjUU1wZkh3YWNVbG9JM3hQaFhsY1Ro?=
 =?utf-8?B?L2dvOFlNSFF1YmlMU0tXUW1Rc3Y5cXorczg4ZmhYYlk4R1M3djJWWjQ1UmpR?=
 =?utf-8?B?dG5pYndYdGVyclhIRS9wWHlyMk9iZE5rdzVLZzdDaThKcm1kOWJBcE44QTNZ?=
 =?utf-8?B?MzQ2NGdaKzBjQUUrQktCYWZHT25uV083dlRCa3ptMVE2T0UzUEZuTzBkWWYx?=
 =?utf-8?Q?lkDhQRlVvWwEL+iU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2a77db-2e66-4e82-3956-08df35c0bb9b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:30:00.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv/E7opQ65Ewi6bWJgaJlPdOV6frdFxBBMnJJQVc7mozTA6vAW66Hnm9rNKpBpmQ/zOLRXGLeMEv7xfo9ZczyMpfxa0qwIXSEwW3tz+Ct+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 13:30:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24571



On 10/29/26 2:21 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 29.10.2026 um 12:16 schrieb Quirin Gylstorff via lists.cip-project.org=
:
>> This removes the postinst template of the cip-core customizations
>> and also allows to reuse the `recipe-core/customization/common.inc`.
>=20
> Is CUSTOMIZATIONS now the way to go? We discussed at the ISAR Meetup in=20
> Prague but the decision was not clear to me. If so, we need to discuss=20
> how to handle more "complex" customizations e.g. sysctl settings wrt.=20
> scalability (nr. packages) vs composability (granularity of those=20
> packages).

As the hostname one is already there why not use it.

As I see it the customization feature for complex use cases has no=20
benefit as these are product specific.
>>
>> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
>> code.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0 recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +=
+------
>> =C2=A0 recipes-core/customizations/customizations.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 .../customizations/files/{postinst.tmpl =3D> postinst}=C2=A0 |=C2=
=A0 4 +---
>> =C2=A0 .../customizations/hostname-customization.bbappend=C2=A0=C2=A0=C2=
=A0 | 11 +++++++++++
>> =C2=A0 4 files changed, 15 insertions(+), 9 deletions(-)
>> =C2=A0 rename recipes-core/customizations/files/{postinst.tmpl =3D> post=
inst}=20
>> (70%)
>> =C2=A0 create mode 100644 recipes-core/customizations/hostname-=20
>> customization.bbappend
>>
>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/=20
>> customizations/common.inc
>> index 0fd3d4f8..888f12f5 100644
>> --- a/recipes-core/customizations/common.inc
>> +++ b/recipes-core/customizations/common.inc
>> @@ -16,23 +16,19 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>> project.org>"
>> =C2=A0 FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
>> =C2=A0 SRC_URI =3D " \
>> -=C2=A0=C2=A0=C2=A0 file://postinst.tmpl \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://ethernet \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-silent-printk.conf \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf"
>> -CUSTOM_HOSTNAME ??=3D "demo"
>> =C2=A0 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
>> =C2=A0 INSTALL_WIRELESS_TOOLS ??=3D "0"
>> -TEMPLATE_FILES +=3D "postinst.tmpl"
>> -TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
>> -DEPENDS +=3D "sshd-regen-keys change-root-homedir"
>> +DEPENDS +=3D "sshd-regen-keys change-root-homedir hostname-customizatio=
n"
>=20
> CUSTOMIZATIONS +=3D "hostname" adds to DEPENDS and DEBIAN_DEPENDS already=
=20
> internally in image-customizations.bbclass
no it does not work that way as the image-customization.bbclass is=20
intent for image as it uses IMAGE_INSTALL.

That design is broken if you want to use via another package.

>=20
>> =C2=A0 DEBIAN_DEPENDS =3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifupdown, dhcpcd-base | dhcpcd5, net-tool=
s, iputils-ping, ssh,=20
>> sshd-regen-keys, \
>> -=C2=A0=C2=A0=C2=A0 change-root-homedir \
>> +=C2=A0=C2=A0=C2=A0 change-root-homedir, ${DISTRO}-hostname-customizatio=
n-${MACHINE} \
>=20
> Same.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${@(', iw, wireless-regdb, ' +=20
>> d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=
=3D '1' else ''}"
>> diff --git a/recipes-core/customizations/customizations.bb b/recipes-=20
>> core/customizations/customizations.bb
>> index bf6e7175..3f931b8c 100644
>> --- a/recipes-core/customizations/customizations.bb
>> +++ b/recipes-core/customizations/customizations.bb
>> @@ -13,6 +13,7 @@ require common.inc
>> =C2=A0 SRC_URI +=3D "file://ssh-permit-root.conf"
>> =C2=A0 SRC_URI:remove:security =3D "file://ssh-permit-root.conf"
>> +SRC_URI +=3D "file://postinst"
>> =C2=A0 DEBIAN_DEPENDS:append:secureboot =3D ", efitools"
>> diff --git a/recipes-core/customizations/files/postinst.tmpl b/=20
>> recipes-core/customizations/files/postinst
>> similarity index 70%
>> rename from recipes-core/customizations/files/postinst.tmpl
>> rename to recipes-core/customizations/files/postinst
>> index 62e9a1a2..c65e2d36 100644
>> --- a/recipes-core/customizations/files/postinst.tmpl
>> +++ b/recipes-core/customizations/files/postinst
>> @@ -14,6 +14,4 @@ set -e
>> =C2=A0 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issue
>> -HOSTNAME=3D"${CUSTOM_HOSTNAME}"
>> -echo "$HOSTNAME" > /etc/hostname
>> -echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>> +#DEBHELPER#
>> diff --git a/recipes-core/customizations/hostname-=20
>> customization.bbappend b/recipes-core/customizations/hostname-=20
>> customization.bbappend
>> new file mode 100644
>> index 00000000..2fb4dad5
>> --- /dev/null
>> +++ b/recipes-core/customizations/hostname-customization.bbappend
>> @@ -0,0 +1,11 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +HOSTNAME ??=3D "demo"
>=20
> The value of this bbappend is quite limited. To specify the hostname for=
=20
> a particular image build accordingly one needs to set HOSTNAME in the=20
> respective config (machine, distro or local_conf) or multiconfig=20
> anyways. Else every downstream ends up bbappending those recipes.
>=20
> I'd prefer having HOSTNAME for demo purposes included via a kas-=20
> customization.yaml (or similar)
>=20

I can fix it in v2.

Quirin>
> BR Alexander
>=20
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
> -> View/Reply Online (#24567): https://lists.cip-project.org/g/cip-dev/=20
> message/24567
>> Mute This Topic: https://lists.cip-project.org/mt/121992122/8886423
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub=20
>> [alexander.heinisch@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

