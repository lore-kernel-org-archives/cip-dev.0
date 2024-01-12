Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F4C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 18:50:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.257.1705085441043448478
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 10:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tCb2aWu3;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCbaHtRnMsj87XmG+8HzHov4CNCesh4eo1IhtZUy6wsTWg+ZkuHhsOyox1amz1d3ABfZc3JWYbjBL0+xMmoWlO0/tJyS4j95driVuqA3LA0xzTs4ZlzuZM0Ajm81XBqLh4QProAtxF++uvDwpBBTiPegflW0Z1BhHm0qlOuk9hbTrBgGwvbA8UIt+APAxIif1lcVGCaO9EeZ+MbqW0qdFbSgT42UeR06wS1hnDSH6S9XZm3Lgn7XmUS/25DlQTczWbkc/z1lyot/lEuRvYW/fzK5mUvUNN2676xtJAsKaq8qpoMaTAbrU9Ijx6nTJt0WSysM/TKqT6JHc56TUMPkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYdDROAeEeIfwSNSZRmJu/XO0FRGRe3w4rRbJX7VpJg=;
 b=IRakPH1QPyOOM1RE+pzP8ctfoTrodAt8xQCy+TdmryFSnecfNYE4LSqojG3FI7eGuKGg6uAwdmFuRdhgZlrYpA+A0vDWyZ8uoSwspBmNfhvapQPQl8kRbesNvPbt0mw5hOngwTG1CwqSgFMBOM8vL6NFljGWMfB5yo/AR2aTePis3UsOYTfXurPQuyYhTKV9fn6fDe4rVptWQjrK1IS8W9dDxn2jbjIqIK9qOmT7lqA8bcuRN8m0wWpFNmoB8XMU5tY8S1SIGJx26ieoHJ4QLjjkAKfeV0XDTqQ9nuVPoZVSy9KHvVDvG4poh6oAAhorhMhuC57neqjHcKE/K3MniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYdDROAeEeIfwSNSZRmJu/XO0FRGRe3w4rRbJX7VpJg=;
 b=tCb2aWu3ZMf98zgio54dtLjCj2qk782kKHIaaX8skbS0H31MxgINZRDdXY1Rju5hrs6xVtzDmLFUURLDw4KzX85kBJj1ue0dbedQDKGs0wBFFdNM5FL8gbOboo9h4Jmh5WFhvwlpbehF5wAKg5uZA1pmGVJqkg+yb3/2IYq0jrNlV1pAxGClyeamWYtk7rgLylAbkWJpa7HHMZkupMou6N4B0DwODScjjzmDV8P83cxIC6rELp5rRPNyKtp4ondazFOFc9RmQYeU33ociV2KeWf8FJupksR+xLzALcDQrHzj602F+LpcXtPVaxUKjf285AUEcPQz2FCGUl2t3ZCuyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 18:50:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 18:50:36 +0000
Message-ID: <291d2b96-4a8b-4652-b844-1d73d730bbce@siemens.com>
Date: Fri, 12 Jan 2024 19:50:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] recipes-core/swupdate: Cleanup
 swupdate.inc
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20231219100858.1853427-1-Quirin.Gylstorff@siemens.com>
 <2dd54a71-9293-41ad-9be0-72b4b0a7b46a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2dd54a71-9293-41ad-9be0-72b4b0a7b46a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cf15d2-e2bb-4236-ef94-08dc139f5d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1AmH8jovQ938xMbEwqa7tlvwoP96+njof3barcok1QWFin8I642pWYdFL4c5Bv7jgnr/lwsY2ZbKwj5CVEguQmf/DME5KacHMikWCAx02+2iCs4ynBLDNwzF8k93GDcGWPyMFqgeTdi/fMgGxoHikCKrD6tKwbjjmCeS4+JprS3f1MtM9xWQOcArq6vDS9EIruIfZe34pSkptbD+h1Fmh1kD7lOpHLuah3Zsoq9K9klLjkk4fzFI9xnk3xPgDPfGeHeLSsG2eR75SFIg1A3ZQjZpQrS9BVWOwtRvDw5EcpaOLgTKlNwzH7g3Bx8ZS+mcLUbwd/1Yn4KsWZxWxykJfVYwmZlzW9jTA+XLpQRs6WnYILAhtWfzB0FE1FZj3rvImYXh/SOBnBiGX3meexupIjxY8nIjC5ryJURTED3BY6rJ/A18DhA/C1EwgK/ha+H/t1LzkBor2MY0KJ9mysT26D8BE+5n73gqx4RBvA3lixNzD5668poDRF6q4PzIISEjD2I5bbI7ZL8omRFesqL0bTRPIdox4A31z3aYDLDaNsoVeAVLt1WX+CM2X2FyK2LtEu7Qgq7jlMuisyrzueuktlkTaXvE9iCSKLHRrOHXfUHPp7rEi4/og8eob3UEvxL4NiJZmFMSiTSkpje6KhK8Ng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(8676002)(44832011)(8936002)(2906002)(6636002)(316002)(31686004)(66476007)(66946007)(66556008)(6666004)(6506007)(6512007)(966005)(6486002)(66899024)(478600001)(83380400001)(53546011)(2616005)(26005)(36756003)(31696002)(41300700001)(82960400001)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/4EaFduN8yi1Hr6Is5DMmwO3jLhm80MIO/zcKQnLmBujNHyw3pcWCfAr7w9X?=
 =?us-ascii?Q?U09ZFF2TvsB839LfgrXlPoyRM/9qjMjM0selUXa8ciyBK3wmCnTc0Ut+oTRz?=
 =?us-ascii?Q?V8xJ4lbfYjAqmJeCem7OzVuJrIcAv/d0SWDbIcQ4HoCBahnh9SXk8DeqMiYU?=
 =?us-ascii?Q?xO8QTl8fBlGPMlhjUMQ92COrHyypiLYVGOjbx78Bj5iprjamtqd3r45HywF4?=
 =?us-ascii?Q?pdnlHSUoi0/XjeT3PSrczXXQCWK9meyzQiYvfg/EuexxEFFZT/ci3hA6GZmf?=
 =?us-ascii?Q?vMKry1bHziMmoCfXKVzzSpGt/w1zxvvSo0p20X6Q4T6rKwiCQHltDklYqkHH?=
 =?us-ascii?Q?Xxwkcoh3RJuHmLbkJaeQ1bv6L5DkWg55mU0ZqhrTw3LficdTWAHw6uOC6g2F?=
 =?us-ascii?Q?anlW30Fc8riZ2RXL46BoZqUTPd6XyvDDQVtJNHrdLZ28tlgJgfK1OMoyL3BN?=
 =?us-ascii?Q?BGPdCqIlwprcT99etWfVDayoCv2ZnHffQojFv1icrfbEGeeHH+BJF8NwxAWH?=
 =?us-ascii?Q?9IssHSmY799v3ekruv0rMmrylguS4+SrwtlpQPht+cvZmZ20A5dQzOnA+Y6Z?=
 =?us-ascii?Q?bnrK7aS0FDSjLjjvRQiLaucI+kShKd1kMwVjZG/qIvWrVJ7gEu3l/VIIrnuq?=
 =?us-ascii?Q?tBxgPdUB0pEMLys04z/qx/WwtYabL8C0UOUadtJW1Mg3eHhq7oYPS3fGqj5u?=
 =?us-ascii?Q?EO781RK/XMPbp9jord9cSoHrAYGX31u+oWmPkpXGe8H4/DrTuiC2DttDexGt?=
 =?us-ascii?Q?X9SZwqTD5xwLaNxrUaHVlsb/A+ntYsz6cFf5Oq1YJh1eWcJI9AhCBxgpfy2A?=
 =?us-ascii?Q?4wirxC7JU0CNR9ZNq4j24zBlK5yF/mhFtdepZnnrm8WQ6D+Mh0idvb9fHhas?=
 =?us-ascii?Q?XwUPEMn+yOJeANOI3S1JIfED9SryEYcJmnyUILhkcPoL236qV1qt2KMn/Zre?=
 =?us-ascii?Q?f1r5WQe/fBwhJ92DyT+p+AsvXjXBuTvFH3YLDNITV+bv8dKRNUw380BQ06Jv?=
 =?us-ascii?Q?UNQjWFCIhH7js7l7ondYd1N7s5YkhjfBUN+dPp1HZ623kEyF1bqEY6kBXmG+?=
 =?us-ascii?Q?a8s2qXkdEf38YSTp8gHG3lI7vYzVtmLb+BqAC6ynfrXshXtEHcjQGpwTTdw+?=
 =?us-ascii?Q?8Vkg12j5hKt8pmcRlKdxpUouoZQ02T8PzG3D7Pg8gkR11Q3+mK6KyFxlypNN?=
 =?us-ascii?Q?cVJeT3pnyhIaZ7lmgy+q90qUmYVFP9lxaE4Yw2GkIKn314QVPQTmILfe1fCr?=
 =?us-ascii?Q?NS3GJtpUVrGQPZ2tiVQPoWnZ/NzUTAqg8HZwWno0vDIs5sQLByZTIpabJjnA?=
 =?us-ascii?Q?nYJZC0mK4Q6wa5YLuVwZRO9M47Ck3IregJX5lEZ9YwAA7gCSJM3JU33Y9Jtv?=
 =?us-ascii?Q?NC7ZyTt5hcezmz7EMZmA70ts/xyhheov4gukWcnmObMvO14KIbHQdpr1+SAA?=
 =?us-ascii?Q?9OdS4D+oOz2WhiMBv9QkZXYqvIWrp5mMEMGPcrNDVvsXFcZlym8Vv0X7qdwg?=
 =?us-ascii?Q?pzyjk3/v5imozNPI1SUuTaQuhyMag3DMA/W7Oia2fwxk23OXe5Y0lUC7njm2?=
 =?us-ascii?Q?8uxY2dl8RoLCZRI2vWZptju8aMFGOJQ669XUtOBMcsIyVmuzFC1r0uys0U7N?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cf15d2-e2bb-4236-ef94-08dc139f5d27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 18:50:36.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJJZ6/ttkl46YCAhsMIRIFQnZVvg1T2ZuBvQv2g6j1cE4tN23JM3WPuag03cp5qulVO8i3DEUfhQy+XGSry77w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 18:50:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14355

On 12.01.24 11:34, Gylstorff Quirin wrote:
> @jan, ping
>=20

Sorry, misclassified as "changes requested" in patchwork. Will have a
look next week.

Jan

> On 12/19/23 11:08, Quirin Gylstorff via lists.cip-project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> As software loads the bootloader libraries dynamically it is no longer
>> necessary to set the build loader with BUILD_PROFILES.
>>
>> Also add PROVIDES for the additional packages swupdate provides.
>>
>> The profile 'pkg.swupdate.nosigning' is automatically set if signing is
>> not set to `1`.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>> =C2=A0 - cleanup 2021.12 for debian buster
>> =C2=A0 - move cross and nocheck to swupdate.inc
>> =C2=A0 - move DEB_BUILD_PROFILES pkg.swupdate.suricatta* back to
>> swupdate_2023.05
>> =C2=A0=C2=A0=C2=A0 as the apply only to this version
>>
>> =C2=A0 recipes-core/swupdate/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++--------
>> =C2=A0 .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 11 ----------
>> =C2=A0 recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=A0=
 | 10 ---------
>> =C2=A0 3 files changed, 12 insertions(+), 30 deletions(-)
>>
>> diff --git a/recipes-core/swupdate/swupdate.inc
>> b/recipes-core/swupdate/swupdate.inc
>> index e5e7282..cb1716b 100644
>> --- a/recipes-core/swupdate/swupdate.inc
>> +++ b/recipes-core/swupdate/swupdate.inc
>> @@ -1,7 +1,7 @@
>> =C2=A0 #
>> =C2=A0 # CIP Core, generic profile
>> =C2=A0 #
>> -# Copyright (c) Siemens AG, 2021-2022
>> +# Copyright (c) Siemens AG, 2021-2023
>> =C2=A0 #
>> =C2=A0 # Authors:
>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -13,15 +13,10 @@ HOMEPAGE=3D "https://github.com/sbabic/swupdate"
>> =C2=A0 LICENSE =3D "GPL-2.0"
>> =C2=A0 LIC_FILES_CHKSUM =3D
>> "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=3D751419260aa954499f=
7abaabaa882bbe"
>> =C2=A0 -def get_bootloader_build_profile(d):
>> -=C2=A0=C2=A0=C2=A0 bootloader =3D d.getVar("SWUPDATE_BOOTLOADER") or ""
>> -=C2=A0=C2=A0=C2=A0 if bootloader =3D=3D "efibootguard":
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "pkg.swupdate.efiboot=
guard"
>> -=C2=A0=C2=A0=C2=A0 if bootloader =3D=3D "u-boot":
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "pkg.swupdate.uboot"
>> -=C2=A0=C2=A0=C2=A0 return ""
>> +PROVIDES +=3D "libswupdate-dev"
>> +PROVIDES +=3D "libswupdate0.1"
>> +PROVIDES +=3D "lua-swupdate"
>> =C2=A0 -DEB_BUILD_PROFILES +=3D "${@get_bootloader_build_profile(d)}"
>> =C2=A0 =C2=A0 def get_bootloader_dependencies(d):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D d.getVar("SWUPDATE_BOOTLOA=
DER") or ""
>> @@ -37,6 +32,14 @@ def get_bootloader_dependencies(d):
>> =C2=A0 DEPENDS +=3D "${@get_bootloader_dependencies(d)}"
>> =C2=A0 DEPENDS +=3D "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd',
>> 'mtd-utils', '', d)}"
>> =C2=A0 +DEB_BUILD_PROFILES +=3D "${@'pkg.swupdate.nosigning' if not
>> d.getVar('SWU_SIGNED') =3D=3D '1' else ''}"
>> +
>> +# deactivate hardware compability for simple a/b rootfs update
>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>> +
>> +# add cross build and deactivate testing for arm based builds
>> +DEB_BUILD_PROFILES +=3D "cross nocheck"
>> +
>> =C2=A0 python do_check_bootloader () {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D d.getVar("SWUPDATE_BOOTLOA=
DER") or "None"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not bootloader in ["efibootguard", "u-=
boot"]:
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 8f7a97d..0f91d5e 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -27,17 +27,6 @@ SRC_URI +=3D
>> "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
>> file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
>> file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>> =C2=A0 -# end patching for dm-verity based images
>> -
>> -# The option: "pkg.swupdate.nosigning" disables the required signing
>> -# of update binaries
>> -# DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>> -
>> -# deactivate hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>> -
>> -# add cross build and deactivate testing for arm based builds
>> -DEB_BUILD_PROFILES +=3D "cross nocheck"
>> =C2=A0 # If the luahandler shall be embedded into the swupdate binary
>> =C2=A0 # include the following lines.
>> =C2=A0 # DEPENDS +=3D "swupdate-handlers"
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb
>> b/recipes-core/swupdate/swupdate_2023.05.bb
>> index 77b7431..d1fe1fa 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -31,13 +31,6 @@ SRC_URI +=3D
>> "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
>> file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>> =C2=A0 SRC_URI:append:bullseye =3D "
>> file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>> =C2=A0 -# The option: "pkg.swupdate.nosigning" disables the required sig=
ning
>> -# of update binaries
>> -# DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>> -
>> -# deactivate hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>> -
>> =C2=A0 # suricatta wfx requires suricatta lua and the dependency
>> =C2=A0 # is not set automatically
>> =C2=A0 DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattalua"
>> @@ -48,9 +41,6 @@ DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattawfx"
>> =C2=A0 # with cross compile we have a unsat-dependency to dh-nodejs on
>> arm/arm64
>> =C2=A0 ISAR_CROSS_COMPILE:bullseye =3D "0"
>> =C2=A0 -# add cross build and deactivate testing for arm based builds
>> -DEB_BUILD_PROFILES +=3D "cross nocheck"
>> -
>> =C2=A0 # use backport build profile for bullseye
>> =C2=A0 DEB_BUILD_PROFILES:append:bullseye =3D " pkg.swupdate.bpo"
>> =C2=A0
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14135):
>> https://lists.cip-project.org/g/cip-dev/message/14135
>> Mute This Topic: https://lists.cip-project.org/mt/103260154/1753640
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe:
>> https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326=
/xyzzy [quirin.gylstorff@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

--=20
Siemens AG, Technology
Linux Expert Center


