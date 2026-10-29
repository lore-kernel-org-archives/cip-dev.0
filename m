Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12261.1793281432828883994
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 06:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=feLJRRuf;
 spf=pass (domain: siemens.com, ip: 52.101.66.9, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWYL+jWSA4vYXtgB6Q2WdrWWcirYPgR72dwvYK1Q8fEWkACeqNq1joLQEQLZlEYPSH2MEKoeJkQduHAZ1NtkQ/hMAyhFB4xUFLkR3YoIjlxWTWJI9uz+P2VjuYzY6jyr1TFWpPP1HprJxVMm0hXak/dNcU2zNXbgn89BUo6TQqDkX/lUzbK5h3nIheJSoOHtEzND7GMwplxZwU4QZ55Elaqzrshx79MIPiDxjkrrhkrwTc6GLM8pWSsR6DMTYfOz37HUIEHInajE1bQZzQ0t1i+KSl598yUbwjFz0RblJm+P6CkJRFiQzaylBIwsx/C4e7m15Yaei/O4gVDzw+7Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ343GAqOTlZ+//0HhxBxKk1GsvMblcIjQHsIfWS7wM=;
 b=NWK8I+ZtOC4N9240pTm+E3tF+VUsKyCsTyKXieOpCBC0f7Z4wY8Nw225LOeuppatBlq5IixmHp0k6VhZwU3taS76V+WlzQK7uu2D3MX9i22RHiBlC7NzQUBlBICxyH9zimUSbvT+9f2e7QZKFwpC7X8dYmT5NZhIMxnHojgaHhFzVjce8Hu8mqS0JbTseiGAx+xuavutE58zCdhqDw0QB4aKcvQWvc8ELlrTMGACgMp3ygBggdNZyH2U1CncJ0gtIK4S/A9Qg2Ul8PM/HrLOXwmUpTEI+Fuo5KEwa/zEcbb7zodlgmi+6Pj4oxLCOAWbLpo5H71E+SoayUkdIRU4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ343GAqOTlZ+//0HhxBxKk1GsvMblcIjQHsIfWS7wM=;
 b=feLJRRuff4RI7DITJeVa7qQD0IEf2BO3aLeAlcxOsPep82WVAOcohxwghT2v0hg9hxiUU8H5/BzasCFkrQYZ5WnRFJUb6Twrg5z0/aaP41XcrKKyS5nsVH6tXL/lSlZuSwQqo2S+hrIjZFg707WmzYC33AibIZHM7p65viOinYXim30nI3U6CH4DLIfUdVqAExV0v07PBESNHBnjEgGRssH9TSJUJYaIf71YvKoGoRylQVimGdUNESCXZjPkufURnoAQ4neMuqnrRwXL4O2vFBKqpWBboi/RE5zZ/cNa7QBrK9cSYqUQUB9FlF62+DXUAME7CvUVHvxlhysY7F6Q7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DU0PR10MB6341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:413::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:43:47 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 13:43:47 +0000
Message-ID: <64d6b369-e67e-4025-a420-3c69cca3735b@siemens.com>
Date: Thu, 29 Oct 2026 14:43:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] customiziations: use Isar
 hostname-costomization for HOSTNAME
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: Lukas Rabener <lukas.rabener@innomotics.com>
References: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
 <0ed181fc-d81d-4fd0-ab00-94d96bd80f9c@siemens.com>
 <d1517c5d-8207-4d37-8f43-a85d79034e3f@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <d1517c5d-8207-4d37-8f43-a85d79034e3f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|DU0PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: afb9e905-3cec-4e5e-be80-08df35c2a842
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4022899009|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261026135527099003|261026130827099003|261028144727099003|10067099003|261021135927099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021130227099003|261021121427099003|261022115727099003|261021133027099003|55112099003|22082099003|18002099003|6133799003|13003099007|4133799003;
X-Microsoft-Antispam-Message-Info: qW7fhcmvujzvP3Qasj+l8zfgWQFGD/qY/mXjK+0tKkiAMr5d90VECtFS5f1UJMVxAq0ZPUiraQSQSYM5KXfWt455niFQt26o9/3YbHP8lgeWiQlhdQUnowPFzlVfYH7u9hf+Ctau76HIE3bcboI4mvp3yYxLP9/JK2T5wrtVtDv0pRQ+f2Pe+qCQgrimIBRpgGXCXUJYTrilGM6kYNI2Sxxh40jza1IKaI88G9C5pA4kyEMJI0YFLcwF52C0A88At/WqJ2DjVHTtLhB9mofQrGX9bXtRYX27FpI14jPx4p5JPrCR82cQRhK9qgTgLfkkWDoWelDiYHV12mW/1p18HcvGGuf+LUGflnEAy2x7brSDGqtzMUBarvTJ6qF1c/Q9uVi+V2YpZEO+WlnmbrvangB41vUWWyZge80bQ+OWH8+K5xfsoAQUPuEPIZMv7g1C/O0zBrwPblxWNAUzDCzpWX28dqw8XQX2GDkVdaIevFdDCsnEkcV5ODvygMyUhGvzrtZZYXja1rQjZKR7DZc0dkT1994ZJAhSgbR2oWgthP80TFh3jOiFWTeMsruBEt4MgHUprDdKlDZT1qkEjFNYfPJ2OrZxN6EfsrCY4MZ1OrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4022899009)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261026135527099003)(261026130827099003)(261028144727099003)(10067099003)(261021135927099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021130227099003)(261021121427099003)(261022115727099003)(261021133027099003)(55112099003)(22082099003)(18002099003)(6133799003)(13003099007)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldRQmd2SHlXaWJUdEE1SDdyOWk3TStkSmY2dFRnd01HOURLbWh1MFNsWDRq?=
 =?utf-8?B?ZDA0MXJ0ZEJUbzlyb3dyamF5WFV6QmhKTnUya1VBbmFXdUdQSXhHM3Voa2Jt?=
 =?utf-8?B?c083SmVxTzY4a2h6VkZJcmlaTVBQMWUxbDQxeXYvUHFHMG5pSmQvL1FWblBs?=
 =?utf-8?B?bW9zNTJBV3IzMURETXZiaVpIWTczVmtMVjh5ekFDd3o5R1RpVmVkWDE0cWRC?=
 =?utf-8?B?SWNRNWZVN2tac0RuSEU0RlVyZ2hZMnJ6bmh2cFpERUZ5MkZ4QzB2Z05CQnQ2?=
 =?utf-8?B?TDNLQ2J6dHBTZmxVUE9yaEpLRlpuT2xFM2VFTzlWTXlERjdkNkN3Sm8yM1gr?=
 =?utf-8?B?RFdSM3QwdlE4RGZYWU82dFAyMzE0Z1ZMUWZoQi9LS3NmTkNKbTRsM3FzbVhB?=
 =?utf-8?B?ZlhLQjNrV29OVU1KU2JQM21UR3VhODNhVWdFQ2RMckNVWnBXc282MWdqbDJF?=
 =?utf-8?B?Vjd6VjV3cng0YWNnY0dCQnJJVDdKbVNGangwd2Q0Y3dSZHZOVGF4eGpEdUF3?=
 =?utf-8?B?R096bGpQWXBUb1cxUzdTOGxmMklNYzFsSWZKL2F5UW5QMnNjQWNmNy9SM3lh?=
 =?utf-8?B?d3J6R0k5NWd5bUlpNCt0SUxBd3dCaTc0UGlQUi9OdUZNYjkxcnorWG1saFVH?=
 =?utf-8?B?cHFJRHJOeUZXOHdoZGl2Wkt3MW16aWtKWFlCd3FMT3d6RDdYWFR0dkRuUGl5?=
 =?utf-8?B?bUdnY2RIMkh2UEdjSU0zc0JlSnowTDAvRitXTzRBb2JybVBVVnEwdDJCN2J2?=
 =?utf-8?B?cnkvVDFhalM1eUZGaWZNWkxTNkpBand2MkRhY20vVjJlSTJVSzBkd1Q3WUxs?=
 =?utf-8?B?SDNJWGxuOS8ycXN1VmpaeHlJRHNUeWZzMlVBcmRPU01LRVNtcmRmbjZuamI4?=
 =?utf-8?B?U1RyL2tOeWxzcENrWVJodE9JVS9YYWVoUllWQ3ZFbTl3ZXliQ1FleEkrRzNL?=
 =?utf-8?B?akVuWHdOYnhQM2ZEeHlWRjhGbm9tRi9qTWMyYW42b1RTd2NHcWkwN1dSVWRJ?=
 =?utf-8?B?bWVIRVl6dmRtM0hQWENFc21VWk82YkxiVGN4c0hqcTExUEJjTTFZNkJXUmpR?=
 =?utf-8?B?bkhRSyszZ3lGUXZCeVlqNFZHSFg5QzRETlBLdlFaUWxCa0ZCTUdIUUZJOWZJ?=
 =?utf-8?B?OXhKN0JrWXhnVFREd3lRaUFsTGU5NmVFNFhjYy9DS214QkFLZ0piYXlITWlL?=
 =?utf-8?B?d1AyMURSZXNxeDE0U3pYOVgvbnk5VE1SOFYyN0pyWjEzSVFQejN6NTRtendm?=
 =?utf-8?B?L3FmN3R6R21WSG9uZFpDZEJsZU5wZzg4S284aFNYZEYwR3NnVVV3Q1pYSi9u?=
 =?utf-8?B?d0xxZnFEUzltRnI3VFBBSVN5TTREN0wwOGdEWTVLVWphVVQ0elBWcjAwZ09x?=
 =?utf-8?B?QzJySlBubTVaUGhaMjliVkt3Q0M4dlhReEg3YU9xb2hyeG1LYmJGZ3FsRkJw?=
 =?utf-8?B?d2hDZmxoaTkxd3pwazNmS2JzUzBtZWdiL29tM1pzaHlPL3ZBWUNmS1VINVM1?=
 =?utf-8?B?ZGhmcVAza2RLbW55eW5WeFVaTFFvVUxvdnF4V01GWENyRW9Vd2NBckhrNThQ?=
 =?utf-8?B?YTB5bE5MdkFva0x0ek5aTkcyMUFxWVF1SUxMQlp3bkc4dTk5TnZRVmgxZEl6?=
 =?utf-8?B?V0dkdlcxNVhpWjhqb1pyYUlnUjNvNDhKRmJTdS9DYTllbGJkcDhxa3NxR1E4?=
 =?utf-8?B?MmhwQkRCdmpTbk8vVy9DaDcvR3Z4eUNSeXBmeEVoUWI4cm9BSkx5cVhzMWFn?=
 =?utf-8?B?Ymg0VlJnY3lFSURwZ2R4UHg5dzZJMVlZcVhVRDRkU0lTL1JTRVltUXpybUdI?=
 =?utf-8?B?ejF2MGRoeHVuZnJRNlJmSTdhVWgwMkhDSkxzVDZZVVRCYkN0WWtLV3BsTHJS?=
 =?utf-8?B?bTJoSGxmYUNqbXlJdUx6bmVUUjBnQW5CZXp3a3JjREYwZkJTVFRZaGdBcm9S?=
 =?utf-8?B?TktaNTZTQzhRelBJMFVmTDM2bll2ZVVJdmxwVW92WnFyWWRzdDF4TURJZ2pm?=
 =?utf-8?B?YXhmQzc3QVdUNjlBK1Zhc2pCUWoycTZBNE9ncVpZVGNFcm5XVTI3Q1F0b2JK?=
 =?utf-8?B?SHM0dFZnc3NVRUErc0cza2pUdW5VR1NXdG5lc1Ftd1NqUFpiSzd3UER2aThm?=
 =?utf-8?B?OFA1Mld4SmZQbWRqQTFZYUNIRzdjdkM3bDRRaFdCaUNSeXppcStXMXNrSVlM?=
 =?utf-8?B?YjlXNWdoTmxBLzE1aUZnUXNLb0lJSUE5cDNieThKbkxrL3d1dzgwYzk1WDll?=
 =?utf-8?B?bTNPcnMzanlPTUwzS0lkMHFabzBPSS9NMXdydU5RT3loLzlvUXFROTVCeUx3?=
 =?utf-8?B?V1Ztd25seTBLcGxSU3h4REF5d0lLNmdkZHhveFhPZ3kwRWdQeENTa0xFbjNH?=
 =?utf-8?Q?x5Fc4rG/56SlK+WI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb9e905-3cec-4e5e-be80-08df35c2a842
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:43:47.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpe2Vvjb4snPDsnJWNbD44IxG0LuG5mXt2OHJvRTXvhv8/W/uBFdHcNeCGTOUbxfhGgIXo109ct+XJt2XhFjYDL/lLX07/+q7kclrJZNKXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 13:43:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24572



Am 29.10.2026 um 14:29 schrieb Quirin Gylstorff:
>=20
>=20
> On 10/29/26 2:21 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>
>>
>> Am 29.10.2026 um 12:16 schrieb Quirin Gylstorff via lists.cip-=20
>> project.org:
>>> This removes the postinst template of the cip-core customizations
>>> and also allows to reuse the `recipe-core/customization/common.inc`.
>>
>> Is CUSTOMIZATIONS now the way to go? We discussed at the ISAR Meetup=20
>> in Prague but the decision was not clear to me. If so, we need to=20
>> discuss how to handle more "complex" customizations e.g. sysctl=20
>> settings wrt. scalability (nr. packages) vs composability (granularity=20
>> of those packages).
>=20
> As the hostname one is already there why not use it.
>=20
> As I see it the customization feature for complex use cases has no=20
> benefit as these are product specific.

Then we should question if it's really worth to keep those mechanics=20
alive artificially? If it's used for to customize the hostname only, the=20
overhead is pretty huge.

>>>
>>> Also add `#DEBHELPER#` to postinst to add the by debhelper generated
>>> code.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 recipes-core/customizations/common.inc=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
8 ++------
>>> =C2=A0 recipes-core/customizations/customizations.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 .../customizations/files/{postinst.tmpl =3D> postinst}=C2=A0 |=
=C2=A0 4 +---
>>> =C2=A0 .../customizations/hostname-customization.bbappend=C2=A0=C2=A0=
=C2=A0 | 11 +++++++++++
>>> =C2=A0 4 files changed, 15 insertions(+), 9 deletions(-)
>>> =C2=A0 rename recipes-core/customizations/files/{postinst.tmpl =3D>=20
>>> postinst} (70%)
>>> =C2=A0 create mode 100644 recipes-core/customizations/hostname-=20
>>> customization.bbappend
>>>
>>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/=20
>>> customizations/common.inc
>>> index 0fd3d4f8..888f12f5 100644
>>> --- a/recipes-core/customizations/common.inc
>>> +++ b/recipes-core/customizations/common.inc
>>> @@ -16,23 +16,19 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-=20
>>> project.org>"
>>> =C2=A0 FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
>>> =C2=A0 SRC_URI =3D " \
>>> -=C2=A0=C2=A0=C2=A0 file://postinst.tmpl \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://ethernet \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-silent-printk.conf \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://99-watchdog.conf"
>>> -CUSTOM_HOSTNAME ??=3D "demo"
>>> =C2=A0 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
>>> =C2=A0 INSTALL_WIRELESS_TOOLS ??=3D "0"
>>> -TEMPLATE_FILES +=3D "postinst.tmpl"
>>> -TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
>>> -DEPENDS +=3D "sshd-regen-keys change-root-homedir"
>>> +DEPENDS +=3D "sshd-regen-keys change-root-homedir hostname-customizati=
on"
>>
>> CUSTOMIZATIONS +=3D "hostname" adds to DEPENDS and DEBIAN_DEPENDS=20
>> already internally in image-customizations.bbclass
> no it does not work that way as the image-customization.bbclass is=20
> intent for image as it uses IMAGE_INSTALL.

Yes it is IMAGE_INSTALL as it applies to the image. I just copied the=20
variables you were using in customization.bb. But that's the point,=20
don't depend on it but use CUSTOMIZATIONS +=3D on image level instead and=20
you are good.

>=20
> That design is broken if you want to use via another package.

Why use an image customization outside of an image? That's the sole=20
purpose of it afai understood.

BR Alexander

>=20
>>
>>> =C2=A0 DEBIAN_DEPENDS =3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifupdown, dhcpcd-base | dhcpcd5, net-too=
ls, iputils-ping, ssh,=20
>>> sshd-regen-keys, \
>>> -=C2=A0=C2=A0=C2=A0 change-root-homedir \
>>> +=C2=A0=C2=A0=C2=A0 change-root-homedir, ${DISTRO}-hostname-customizati=
on-${MACHINE} \
>>
>> Same.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${@(', iw, wireless-regdb, ' +=20
>>> d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('INSTALL_WIRELESS_TOOLS') =
=3D=3D '1' else ''}"
>>> diff --git a/recipes-core/customizations/customizations.bb b/recipes-=20
>>> core/customizations/customizations.bb
>>> index bf6e7175..3f931b8c 100644
>>> --- a/recipes-core/customizations/customizations.bb
>>> +++ b/recipes-core/customizations/customizations.bb
>>> @@ -13,6 +13,7 @@ require common.inc
>>> =C2=A0 SRC_URI +=3D "file://ssh-permit-root.conf"
>>> =C2=A0 SRC_URI:remove:security =3D "file://ssh-permit-root.conf"
>>> +SRC_URI +=3D "file://postinst"
>>> =C2=A0 DEBIAN_DEPENDS:append:secureboot =3D ", efitools"
>>> diff --git a/recipes-core/customizations/files/postinst.tmpl b/=20
>>> recipes-core/customizations/files/postinst
>>> similarity index 70%
>>> rename from recipes-core/customizations/files/postinst.tmpl
>>> rename to recipes-core/customizations/files/postinst
>>> index 62e9a1a2..c65e2d36 100644
>>> --- a/recipes-core/customizations/files/postinst.tmpl
>>> +++ b/recipes-core/customizations/files/postinst
>>> @@ -14,6 +14,4 @@ set -e
>>> =C2=A0 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issu=
e
>>> -HOSTNAME=3D"${CUSTOM_HOSTNAME}"
>>> -echo "$HOSTNAME" > /etc/hostname
>>> -echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>>> +#DEBHELPER#
>>> diff --git a/recipes-core/customizations/hostname-=20
>>> customization.bbappend b/recipes-core/customizations/hostname-=20
>>> customization.bbappend
>>> new file mode 100644
>>> index 00000000..2fb4dad5
>>> --- /dev/null
>>> +++ b/recipes-core/customizations/hostname-customization.bbappend
>>> @@ -0,0 +1,11 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2026
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +HOSTNAME ??=3D "demo"
>>
>> The value of this bbappend is quite limited. To specify the hostname=20
>> for a particular image build accordingly one needs to set HOSTNAME in=20
>> the respective config (machine, distro or local_conf) or multiconfig=20
>> anyways. Else every downstream ends up bbappending those recipes.
>>
>> I'd prefer having HOSTNAME for demo purposes included via a kas-=20
>> customization.yaml (or similar)
>>
>=20
> I can fix it in v2.
>=20
> Quirin>
>> BR Alexander
>>
>>>
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>> -> View/Reply Online (#24567): https://=20
>> eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.cip-=20
>> project.org%2Fg%2Fcip-=20
>> dev%2F&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C2a2a77db2e664=
e82395608df35c0bb9b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6392887740=
47991760%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC=
IsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhL1=
dRYTVDUF9hgvOZmZXkAh0CaLSGaAdSmztMob0cf0%3D&reserved=3D0 message/24567
>>> Mute This Topic: https://eur01.safelinks.protection.outlook.com/?=20
>>> url=3Dhttps%3A%2F%2Flists.cip-=20
>>> project.org%2Fmt%2F121992122%2F8886423&data=3D05%7C02%7Calexander.heini=
sch%40siemens.com%7C2a2a77db2e664e82395608df35c0bb9b%7C38ae3bcd95794fd4adda=
b42e1495d55a%7C1%7C0%7C639288774048044071%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e=
U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy=
fQ%3D%3D%7C0%7C%7C%7C&sdata=3Dt5ju1wl00C6Od%2BLCWEqE9xCVy1ymcXPFxqOG2fICQUA=
%3D&reserved=3D0
>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>> Unsubscribe: https://eur01.safelinks.protection.outlook.com/?=20
>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>> dev%2Funsub&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C2a2a77d=
b2e664e82395608df35c0bb9b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6392=
88774048086780%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAu=
MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=
=3D0b05HH58ADoebxwxqeQW4VfuTcQY%2FwxfwqrESs9A%2FQ4%3D&reserved=3D0 [alexand=
er.heinisch@siemens.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>=20

