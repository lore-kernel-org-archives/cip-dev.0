Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F26C5475B
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 08:16:07 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.88])
 by mx.groups.io with SMTP id smtpd.web11.7418.1709712961331446408
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 00:16:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cTnnuAmI;
 spf=pass (domain: siemens.com, ip: 40.107.6.88, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck3LikooCikqsHxzJSUCYN0Nx3ejNQU3ptGleZWC/Hq8t28nyzIKiG7rl0RN3BoGhO0tueD+cCmPwbzjK7saCISSTj3UeJ4ij2DOuktxUUeq9JtuHkpRoh0mqrDdunM2fmbLLiofAc9UpWZehV7WN5vFSeAhnSS5X6W5WdqO+sgrfYIvBh8poIbaqo0AMbwU/K25iimuawK222cu3xpzq3zagQO+usPpUo/tsBhnrImxaeDOyYJ0F2UokC8JF9zmN5Bm1OC/dhi0HlyLImZkfCdcuo1rOogm+DdOXwAHSNXXRIW6QKrZkNokiHGdR3Ji3L0Tvr8Iib/3Y7Pt4f/nZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Maiu3EkbHIzaG4wfOJnvRWC3jzTMMS3BL87rl9ABKYs=;
 b=QgwLaWFuE3gMjHkbqJzSolDPxHrg/ToGKhUazPLSWZdZ76XhbjI3e12AqDdViS+DcBl2iPYHeT2ToWChAeFR3s9FroUX2iECkwHFsP7um4Sad6Dz/Fa6lCG7i7vPl4fI12AFa0vEYpeorOOu8owkU+zjGrjb2/hsOJ1RhlTLOGyVVmxVwNiS6Teky61UZLVckNXq3KsE4uDspw8HIXzYnoBLUnxYlsxpRLvyyRtizbqoCu42etJlh0Vh/Omz3NDyOv/1SkL8A96zJi8VJr+hHhpH8I5y8AecW5gsY4ovXWJk0XWOgxzuSMcAv05uu1UAf8CXdWcxTWdwpF+2UI3OHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Maiu3EkbHIzaG4wfOJnvRWC3jzTMMS3BL87rl9ABKYs=;
 b=cTnnuAmIk+5lNRFWZeBF1hIkSrbG8LrZetpz48oWU29FyMX9cbbhwk8H3JlFWb33rdHO1yLc/op24PGyS6Uf5DpQGmwLVRepfq72MHFUKUGU2HQ3allq/59cG7YEhVB9mk4lcJ2vkYGfUnEApC2yV33f9OBnOWNlWqtPasESWnvdqCQt37eDh3oXYP8iEsPcjusjz+Bch3F+wSVmWiT6jzq8xn2APYep5VjE2xlSCr8nQRbnKkanIIpERlFoA4DXRCs/yNwtTCG1v4RQ2Z0//2RSYtAifXsbFeo4VvVeSl2qi90aXa193ZndVmIDAy2iQeK/sQZI68LQ0ruIE+tRiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM9PR10MB4103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 08:15:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 08:15:58 +0000
Message-ID: <217c7547-1da1-4915-bf7a-526211bb4a6a@siemens.com>
Date: Wed, 6 Mar 2024 09:15:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/4] swupdate-config: move
 swupdate.cfg from customizations to own recipe
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
 <20240304105453.984881-2-Quirin.Gylstorff@siemens.com>
 <30922b1e-8406-49f6-896a-3c4d1874625a@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <30922b1e-8406-49f6-896a-3c4d1874625a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:610:b1::30) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM9PR10MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: a1af4990-8bc2-4437-f8cb-08dc3db5a6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X5cqYrrMvdg06W5LHphpjYRL/RilyQY0jY87LhYg7omvMzuBgdx4jWkLHOe9e7mvdwMuofS+K7rN0I9L4lZeCszAg4xVMpA503r9rvLZlIYu+EkuyBvokOeCUVWmSlBviKs6q8bt5FS6XGR10heuajFik+Z9KmEIDq4HOsO1iyGCDtlmGl2LSEc0mqnSS3059G89ifeMdSK1nvJfnyKdv6A87oHeloFYXi/iNOW0Kurj6f8lyTNHc509Gk7erhOJFu4VUznKclLhhjckHH//ynuVrrEr70UUmzRmZfnm5szT75K0SaV59wPCIwdNhx8dHlfug0WLOI5v71yqSeeZkppZVExqu0MmaQ2wTjAr8Szzpk0dm744OJ51KligierCqDcCgF/WTNt5IlVVDTcqZLniOBleMyKTmAbD2jVP5+N+vAZFNFGFHWGZleKoNJwoNKX9YcO9puzcEk7XVABu6hQYVVveeeL8dS6jNdbCN4KYrS0WzGJq23HeQWEANzFgyMq2qCF9k0GHWBGq3flyG0OLdtev704Z1ZjKsZY+TedD+MFwTldOceOqHu8BOxbJihLxd74HuR9BcLOwIXx3zCdi/BGGk/0D7CAQggNYXm0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUxZVVZDQ21STXc0ODZoT3o0VGkrTmN2QXJhT01IZzNRbXozYURXdEV3ZWor?=
 =?utf-8?B?VEI4WkcxM2R1ODQ4SDZhdTVNOXZwdWdRV3MxcG00R0NJK0RtcEkrMVd5ODVr?=
 =?utf-8?B?N0ZFdS9mRS9lNi83RGJyS3QzYXJRQ1NKN1ZuZTB5N3EzYmtyaEMvVEdiM1ZV?=
 =?utf-8?B?ck9lSENaNk9sNENUdkUrYTJZbld6M3ROcUZ6SzJpdjJ3VkpEbkpNT1pIMkJK?=
 =?utf-8?B?Q3d0R2dodmw4VGlRUXJ3Rmt0OEpaYkRFazk3MXc5Z3hncm9WYm10V0RBbXNs?=
 =?utf-8?B?eTRPWTJ2Q1Q3MHE4enMzTGtpWTVPTlRzTTUxMERkYW03M1kyVkhrWWFHYUZu?=
 =?utf-8?B?MkxhYzF6YmdxWFlzY0U5T0JpZ2E4VTlJZUFVNDRBTU9CNm1sc05OaTlRTXVY?=
 =?utf-8?B?OXhmZEcwN2hrY0xYMFQ4S0dvQ1luUjcvOE1GWnBKaUJpb3kyNktocTcraUpN?=
 =?utf-8?B?Z252SHFvVE1MSlcvWEJXTGU1aUZsaXBway8xSjBaL3c2RHREZmZod2c1UGtT?=
 =?utf-8?B?anpPS1lzdWoyUUg2WHlESnJXaUNyZFQwMVNFZXZiWUVJUWJDcjNiY3JtUTBQ?=
 =?utf-8?B?WExQczUyeUVqSzh2ZTlHNU90K0I1bDU1S002cXZ3ZVlpUWhSK0VXYTdvMVFw?=
 =?utf-8?B?NXc3YjJGWGpHSnZ1YVEzL1dTd1B3S2pEQ2FrMjRzN0J3ckRIU3J4MkVaQldj?=
 =?utf-8?B?Mnc5R1lmVjl5dHh0Q3hKanBSRmF1eG5HeHVGUE90a1V2Y3U5Q1FjWHBzT2pV?=
 =?utf-8?B?aVllRk5IOURDODZYd1M2NkNad3VUMnhCZ1lzclQvbXdQUUFtOHpTVDJyd3hK?=
 =?utf-8?B?aUxJZjJHMmc2dmVTejMwaVlNK29hcmR2TGRXYWVOT285Zit4LzhHWlVvbk12?=
 =?utf-8?B?STV1YjRCMndFbWs5dDF4aHJkUU0rRFdHV1k1eStlMnN5WXJCYkdteVVCMnBK?=
 =?utf-8?B?U2J6OFF0QW5KMG90OUQxS0VacWl0cFROWE51TnJ0REo5WkJyYXZ1endnMW44?=
 =?utf-8?B?aUlsNVJNQXNEYjNOMTRacDM3U0xFdC9reWVSVkxHUjhpR1U2eGl2a1FLNW9k?=
 =?utf-8?B?am1TWjV0RWRNWTZ1QmZRdDBxcnVzaWF1dWtub2lkM3ZPKzJCZmp1dS9QOUlF?=
 =?utf-8?B?YmJsRFkwMFcxZlA5a25oWVJZcDZGSVJVVldXY0ZhaTZGaFRWME1nM05HaTJM?=
 =?utf-8?B?aXBPOXpSNTJ4bDUwZlVsSTdJYTRFYnRPV24wbm5PZVliTWFTRnNyRkVvblY1?=
 =?utf-8?B?Z08vZDdsUVpOemUzd2dyb1hqUXJVTVNTS3orWDZHTUE1R0MxMi9ldEQ4dkdD?=
 =?utf-8?B?LzBDekRtTWV4VlhGbWJNellZLzNRczJ4NEMzUm9VVXJVVWw3VHNjQUZwSytN?=
 =?utf-8?B?WE81VUwzaFkvTTJYanZXek5yT2wrYWIwNFRoSkhPeTFVbll6V2FNSHBOakll?=
 =?utf-8?B?SGl2SW9KbG9lc1BZYUV5NFBSemt3RHJNSWorVlNicFZjUE1XZCtFcGRtRU9n?=
 =?utf-8?B?MnE5cTdiZGVLa3d6aWdaM2J0bmt3KzZtZjhJRXI4U3JCOVMxQnpiNERpKzVp?=
 =?utf-8?B?eFM5NmRkTnJsaGdYam8rUEF4YXQrejBKajdtYzg5ZXdxSWlybVFkYkkwNXdx?=
 =?utf-8?B?SWszR29KUXRwcFlZOUVuQkJMaktmYmtBWUt5Zkh2MmVZV20ydThlRnQ2TVY5?=
 =?utf-8?B?bWllQXdwTGY0S2dyaFdrOGtvQUF6Lzg2ZFhjS0k1Y1o4RWo3SnlORitqRjA5?=
 =?utf-8?B?dEdkTyszT3FteTZ5TnQ4dG9rRlE3eVlzVXFSbVlVNEV4K0FZQ0Fvdi84di8w?=
 =?utf-8?B?Qk5jb2pJQm1idlA1dHJtbHBHL2UwTjJXWGtHamFCR1EySjM1WFMwZWZtZTEv?=
 =?utf-8?B?bTl2NTdIMFRUdGN0OXU2eXFvcXV2RFltUndxS09BNjlzL2VlZ0lkaWZrSHhJ?=
 =?utf-8?B?cjdCVFlQVGM3aEFOQXhFRXhJcnI3M0hYNUE0d2VoYmJkdzJEaGtkOHR2Y3pJ?=
 =?utf-8?B?MVBsSGRxejllNzRJRFdiRElXdTAxVDhaeEFnNFhoakVuUGJoN01rWWpsNjlF?=
 =?utf-8?B?SEFoUUZLeE4wVTRreXhPLzZRenVTUzZKbk1JTk82YTNKRTJtR2xXdjdjOVUx?=
 =?utf-8?B?bjk0Smoza1Q2ZjM2MnQrSUpsU1A2V0xBSjJSUzJaanJSazRLOUFpbmVxZEYz?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1af4990-8bc2-4437-f8cb-08dc3db5a6f7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 08:15:58.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB8x8NZqxdKzG61pOiifYF7A1vsmwLgYUIUAfVhPp2uA8ZOah/rgX/KZit0Qu9T9Vl6zwCsv5kMq2S3/rchamubEYHqprR0Ria+FuAiH5dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 08:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15238



On 3/6/24 7:58 AM, Jan Kiszka via lists.cip-project.org wrote:
> On 04.03.24 11:54, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows downstream customizations without including unwanted
>> packages.
>>
>> It also adds the new variable `MACHINE_HW_VERSION` to check the
>> compatibility between machine/image and the swupdate file.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/customizations/common.inc        |  8 ++----
>>   .../swupdate-config/files/hwrevision.tmpl     |  1 +
>>   .../files/swupdate.cfg                        |  0
>>   .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
>>   4 files changed, 30 insertions(+), 6 deletions(-)
>>   create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
>>   rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
>>   create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
>>
>> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
>> index 79bf80d..37872c1 100644
>> --- a/recipes-core/customizations/common.inc
>> +++ b/recipes-core/customizations/common.inc
>> @@ -19,8 +19,6 @@ SRC_URI = " \
>>       file://99-silent-printk.conf \
>>       file://99-watchdog.conf"
>>   
>> -SRC_URI:append:swupdate = " file://swupdate.cfg"
>> -
>>   CUSTOM_HOSTNAME ??= "demo"
>>   WIRELESS_FIRMWARE_PACKAGE ?= ""
>>   INSTALL_WIRELESS_TOOLS ??= "0"
>> @@ -29,12 +27,14 @@ TEMPLATE_FILES += "postinst.tmpl"
>>   TEMPLATE_VARS += "CUSTOM_HOSTNAME"
>>   
>>   DEPENDS += "sshd-regen-keys change-root-homedir"
>> +RDEPENDS:append:swupdate = " swupdate-config"
>>   
>>   DEBIAN_DEPENDS = " \
>>       ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
>>       change-root-homedir \
>>       ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>>   	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
>> +DEBIAN_DEPENDS:append:swupdate = ", swupdate-config"
>>   
>>   do_install() {
>>   	install -v -d ${D}/etc/network/interfaces.d
>> @@ -46,7 +46,3 @@ do_install() {
>>   	install -v -d ${D}/etc/systemd/system.conf.d
>>   	install -v -m 644 ${WORKDIR}/99-watchdog.conf ${D}/etc/systemd/system.conf.d/
>>   }
>> -
>> -do_install:append:swupdate() {
>> -	install -v -m 644 ${WORKDIR}/swupdate.cfg ${D}/etc/
>> -}
>> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> new file mode 100644
>> index 0000000..1eb0996
>> --- /dev/null
>> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> @@ -0,0 +1 @@
>> +cip-${MACHINE} ${MACHINE_HW_VERSION}
>> diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
>> similarity index 100%
>> rename from recipes-core/customizations/files/swupdate.cfg
>> rename to recipes-core/swupdate-config/files/swupdate.cfg
>> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> new file mode 100644
>> index 0000000..6991321
>> --- /dev/null
>> +++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> @@ -0,0 +1,27 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +SRC_URI = "file://swupdate.cfg \
>> +           file://hwrevision.tmpl"
>> +
>> +MACHINE_HW_VERSION ??= ""
>> +TEMPLATE_FILES += "hwrevision.tmpl"
>> +TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
>> +
>> +do_install[cleandirs] = "${D}/etc/"
>> +do_install() {
>> +	install -v -m 644 "${WORKDIR}"/swupdate.cfg "${D}"/etc/
>> +        if [ -n "${MACHINE_HW_VERSION}" ]; then
>> +            install -v -m 644 "${WORKDIR}"/hwrevision "${D}"/etc/
>> +        fi
>> +}
> 
> If I'm understanding the docs correctly, the purpose of this recipe is
> just to act as a placeholder when we want to use a static
> /etc/hwrevision, nothing hardware derived, right? That leads to two
> questions/suggestions:
> 
>   - How about a better name for this recipe? swupdate-static-hwrevision?
>   - How about providing some references/examples for creating hwrevision
>     dynamically?
> 
> BTW, error reporting of swupdate is by default useless when you have a
> hwrevision mismatch:
> 
> [INFO ] : SWUPDATE started :  Software Update started !
> [ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not installing ...

We can look into upstream to get that message.
Quirin

> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15237): https://lists.cip-project.org/g/cip-dev/message/15237
> Mute This Topic: https://lists.cip-project.org/mt/104719596/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

