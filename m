Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766FCC47DB7
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 09:47:06 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.45])
 by mx.groups.io with SMTP id smtpd.web11.18496.1705657622912307076
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 01:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VLKcrclL;
 spf=pass (domain: siemens.com, ip: 40.107.241.45, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK6V7hcqtYHaTmhExzN0W/j17h8rZOGF7Zavk5ls/w2y42hQ7Pt9AE/OoKh06ozFrcYmBI9W2vb17zFsH007NjF3mC1sGXGfN4PpTkr4BvFGjC1ZcNsgDqWPIrv9mUCx9PTwVHhwm/W01Wj0NfiRLx4mgzROtVwzfm1J7BMQaGVoVtXfU+72eWs6GdC0Smrt7d1I1tFoINB4eScCdxT9XGayzvDsOgTtNIAEYtuvatjuSK7vCNYF81JuT89I+x2BlTlzlr5opxfwRaLpn9Q5H4jOiuRi4jGYSybyDd2wm4F6DkGRkIf5Bz7rRH04sYa5HdIteYWmIXa+jVJ8MOd/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKJ1jwb1/oTZ4Nj5BAxh0NeLlAeU7/vssxWHHnHoAvE=;
 b=BWGv43yVNi4AwJmDhBdujCUUgm+gUr3XiBwiNXIBTVDzw/YunlEsBpEcId3zc6MtoIA1VJIgD35yUMcmwG2cUAFTNUXLpGbnPQHEklGGcaStj4mebZjThTfOuxsHJSd666CqCnmZZi2063q/m/X37UKA5hu4QDMINfkTvGcrTtQMXkcRpnT6Mm0UKWX33y4dE55elq3+12+klrfWwUt8RP1Nm97fxZPlHewQJ5FIcRHqjEUffdQVN6N7clTN0m48cMTcqvrPmziT89wGPJeBmozU6Nfba+HL8hhf/WoGEMXm4z4hYtTrX+Iiz24tOVKi5NQAGIBaYT38gI0E3gAPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKJ1jwb1/oTZ4Nj5BAxh0NeLlAeU7/vssxWHHnHoAvE=;
 b=VLKcrclLC29YI+WF7zTBVKRo6Asksi5+gLBn/XHgZzLSBzjb3pH44iupxem9WAsQf9aAmIHXQ0QPc/DC/6VfukZg6viSRdYnxSkMVKF9e2mVY7TiY1O2LP9ePPJNFcyDmHHq+ydgfbZrXFRrRKz7Z/Oa/jaSV2hMzHt+FUS44qOJnq4RsnVRFYHX6anym2E6OoPL/9y8OYc0FOj9TG5o/ONPXx9toUqSZyJHCQdbOsu5tLHkd9KmZt0alyz9pm2D+Or2d9nFFW3AMeLMzQHk0nhJJDY23MQ2PRlSxbK/9Fv8EaGjV7F859A7ewIkW4HyKQQINEGQbzU8eiO7JQ9F0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB6886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:46:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:46:58 +0000
Message-ID: <6304ebcf-2dd2-4e1c-b2b2-4ea77d3a78ff@siemens.com>
Date: Fri, 19 Jan 2024 10:46:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] efibootguard: Update to latest
 debianization
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
 <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c80e8d-4039-406b-4629-08dc18d393da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x3nz7AmfAxWQWWeDfvJxhNS4dQNWtxEt+b3rHKRO+GibzlNL4uMKnyxpD4H/7miFkT4kFaK9hTwaQ9kobKOnPhh2w/Lx0qyHlEZKzGGn9Ppem2Mzx+yNsdRlvJC91xbNqn4eIxeZpK1LvsW/d/M0WxbHnPUNxN1hSxE0bNTgpy+NCruiglFBvu2eexoxzIYi5z3Di2oa3Ux83Ux53kmz2QMJN3P4rFrjof9ER+zzUKB+1YY+0lY4qmNt/F2xfHxDK6IW86jpdw/PUEgWbeMsH0A+NXry5LYIDjjPZ0nM4bmFwAg2q4qdRIiwhhrerNKB+u3mRvgx4tO6U3YzykCnHfr7hzBH9IIwvBntw96sNiggovcKeK4poQOnFzQqiwzEIBg2Yp3TziWeImtvOpw49aNFmRJh3n45nmMkhm3hcIaDaYWZAp/tSGtwrWm3lDjJ108ziumy7NQi61a9swCkveLddoXZG1KYvCNRBk6GA66tm9osTC3kp7uBXV7GjBlbtsgbhH+IUAvXfEmza6XzA969AMH0LyMIwADpvrMjim/eEi0ifvMt8pbNb/jBSqt1la1FsFfO3xBgrUGlsbpq9VEvGLNZlAJ1Woub/K9t0gF03/rBhbceMj205vNR+LIh8YyUOcexDAJGaXtORAMYoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(4326008)(966005)(6486002)(6512007)(8676002)(83380400001)(5660300002)(8936002)(6666004)(53546011)(6506007)(316002)(478600001)(66476007)(66556008)(66946007)(26005)(2616005)(107886003)(110136005)(82960400001)(38100700002)(2906002)(36756003)(41300700001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MW5yNCtYOXBsSlRoeE9hZEVwV3ZNV1J6eTR0TjhXU1UrSlRlSDVGVGtyMzlZ?=
 =?utf-8?B?eHNIVGxraVpveFEwYksvc0RFaTE4MXFKMldwdHp1YkRSMXh3Q1lzRnZHWGZj?=
 =?utf-8?B?SzNld1hMUWpUSXBoQytRbnoxRUtYK1NRSCtRNW4zNC81T1M2Z0tPVVM2bC9G?=
 =?utf-8?B?T0UzSlRIZnVySnJWN0FxYXQreGtSQXpYem0vb2lwRC9aZzQzSzBJNW5wYTR2?=
 =?utf-8?B?UDFCZUVucmpKSDhGWURvc09SUmZQRzc5VHM2MU1nU0tJQ1B1L3NrOFMxYVNo?=
 =?utf-8?B?ZEJiNm8wR3JaaUkxSStJOUtIT1o2bDlibmpBdDMweGM5RWtrY2o3YU9GYlNy?=
 =?utf-8?B?bFZTSzFqeDZqYm1XMXZwNDkrakdQbC9HWEdzU25LZDB1QnBxNElOR1MwOHJ5?=
 =?utf-8?B?V0VJdTY5UTFaZkxvQ21hTHdnWHJDcjc1TzFpY1YyTWZyd0VEeUpGMUhVTTd1?=
 =?utf-8?B?MW52TXFTWDdYUnRSNlY2KzlEaGxibFoyRXVmZ2JKNlVvQ0RuTlpmVmY3V0Rr?=
 =?utf-8?B?UW1GSFhDOHZKNXpvM2Roa0FkZ1UvY1MxSDVlWVFPM3ZFVVVQSHJCVDZ4eFg1?=
 =?utf-8?B?RU1FSUFydmFISXFHMGF6eHFkaTZlY3J5NVN6QkovbnYxU2xuVFZuU1ZSdVk1?=
 =?utf-8?B?SjJyd1NMdEtpSFkvT2VtSjBaVzBIVDlWMnpmQUp5SnBIOGlOY2RydEozSmVq?=
 =?utf-8?B?TVNBR0FEUmlsUHJrY1dxcFpUc1BzZU4raUk2V0dlNHl2NWw4RE5TVzBtWmxE?=
 =?utf-8?B?Z01FVXNKVWI5T1RxK2N6aWxSTWplYnpQRXVDSXN1Wk4vK1Jxd3dhcndTbytS?=
 =?utf-8?B?c29la3I3ZmFkT0VrL3YrOU9WUkZ5bmVDdzdjRnFOeU1XcSt5MnR1VTdKcEZs?=
 =?utf-8?B?MStFVjNVMm9KNmxtVkJVWHhDeTEzWGRCZXdoY2tuY1l4RGhHMFRHcEFHbFFa?=
 =?utf-8?B?Qm9GV1NHVVBMRGMwbDk0UzVweE43ZzVQbGJReVA1TjRZZHUrTHpCcnJaQk1E?=
 =?utf-8?B?Wmp0clFrM0xneUQvZ0Zjc3hCQ0VkUzUyQStPM3lQQVJIdEJUSmV3L2lUZzBa?=
 =?utf-8?B?NnlXbDNRblN3WWVqS1dLdTlYM0FSL1gyM3NpZ3U3V283enBSZTZuSUtmYXA5?=
 =?utf-8?B?NHA3ZTgrWHNaVnphOGc3V2Erc21TYUpFSmtMS2FCbFB0WGtucVFwSzZRUE5U?=
 =?utf-8?B?bzhSekpmS1lsS3pjSFZET0s0RDBSVHRGbWZjUHRJbmNJeXBBSGdiVFZUZHI2?=
 =?utf-8?B?dmw4Y1VERDlrZWVQcmJBRlBNeHRVbUxJSUF6bG16YTBlU3RPR3NuZmVzaUJO?=
 =?utf-8?B?VUVXc0R2THloNjBWa0hLUGRVM25oRytIRHV1aGVQSzYzb2I3NGRSUXBDOUdK?=
 =?utf-8?B?TEVvVzI4empsK05SUmcxdlRZV2gycyswTTNSOWtxdmEvdzI4VHJhNTBKaEQy?=
 =?utf-8?B?Y2daUXl5ampHdVQ1N0lKK0VuamhhTmQ2bzJSMi83ZXEwQmpubllyWVE2d09u?=
 =?utf-8?B?cTFSUGRhZzF5c0tjc2ZPRFV1WHBkWnZibC9TZDBmdmFacXg1OVAxSGt3UzdO?=
 =?utf-8?B?Zms1OGU4aFg2eEp1bmhidXN1YzdaVmpsRHVVcEVsMGJMRmE0YmJUZjdpdzhF?=
 =?utf-8?B?b1RTZHJmU0lKNUI1T1ZGVHMvREF3OE9lNGR6TndEcjhqczhtT0VSOE1UMGhO?=
 =?utf-8?B?emhlR3JXbUpCb09IMzhocXV1eFVEclI0aWpOWmx3dGRzK0E1VmtYNGhDUEc0?=
 =?utf-8?B?SzVHVHZTanNmZGlzbEltZG16MWNlempONjJtM3BHVzd0TW9FZEJLeXE2Sk8v?=
 =?utf-8?B?WG5kSzFVSzRLMytHejNxYitNWnMzOEhsMHBlc2ZsYmxYNkNtMGkxQ1NmQkhs?=
 =?utf-8?B?dEdzYUlEc2JNN014R1JSVzlHOFZUMnFickJQaXUyMGJCeXkwSGFGcW5zWFdI?=
 =?utf-8?B?WFhrMDkvUlU2Q3REZjQ4QnR6ZWQ5Q1R5SzgwdG9aQ1JWWkluejZoNTE3WG9P?=
 =?utf-8?B?dkZITEtDL28yY1BCdGh5MkRuYVQ0L1VuMHJLRThhcVgrM0wvamgxbDJVMURS?=
 =?utf-8?B?TEhJNDRnZVBnc0tsZ3VFbDJ3OU9oWVlkYTN3c2poak92TzlrSkZEc3NCd3ow?=
 =?utf-8?B?UE1hVCtvM3dZWDZHVGJPdXh2WjZoNmFwTitINCt3a0dWQ1lHVkp3VUdIYnJw?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c80e8d-4039-406b-4629-08dc18d393da
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:46:58.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKjBlAzz/dou3RkisdHI2twwsuqWi8aeI0w9anMKvWciwWw4JoPOctR7SV6i7ISBKkXRh5Rm0U7YOM2JBC+Sv8Omb5hrgspB7gF6RLu18y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6886
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 09:47:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14424



On 1/18/24 21:18, Jan Kiszka wrote:
> On 18.01.24 20:50, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This fixes cross-building and allows to use python3-shtab in bookworm
>> and newer from Debian directly - at least as long as that version does
>> not include the Multi-Arch hint that was recently added and that also
>> our own shtab recipe uses. That one, in turn, is incompatible with the
>> :native suffix that was now added to efibootguard's dependency. We
>> therefore also need to switch our shtab debianization to a version
>> without Multi-Arch yet. What a mess.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> I was considering to hold this back until python3-shtab 1.5.5-4 has been
>> uploaded by Debian but that would delay our CI testing of riscv64
>> because cross-building python3-shtab for that arch is currently broken.
>>
>> Note, though, that the generated swupdate image will not boot in qemu
>> because  the 6.1 kernel (just like other upstream kernels) is missing
>> https://lore.kernel.org/lkml/42c63cb9-87d0-49db-9af8-95771b186684@siemens.com/
>>
>>   ...bootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} | 8 +++++---
>>   ...{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} | 2 +-
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>   rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} (89%)
>>   rename recipes-python/shtab/{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} (91%)
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> similarity index 89%
>> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>> rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> index a7ffb00b..83be2a4d 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020-2023
>> +# Copyright (c) Siemens AG, 2020-2024
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -24,7 +24,7 @@ SRC_URI = " \
>>       file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>>       "
>>   SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
>> -SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
>> +SRCREV_debian = "22b173a3293c976c9dff2ae92085d7ed995f6768"
> 
> Someone reset history on salsa, for the master branch - tss, tss. So
> this won't work anymore.
> 

Sorry this was due to uploading efibootguard-0.16-1.

Quirin

> Jan
> 
>>   
>>   PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>>   
>> @@ -34,7 +34,9 @@ PATCHTOOL = "git"
>>   
>>   inherit dpkg
>>   
>> -DEPENDS = "python3-shtab"
>> +DEPENDS:buster = "python3-shtab"
>> +DEPENDS:bullseye = "python3-shtab"
>> +
>>   # needed for buster, bullseye could use compat >= 13
>>   python() {
>>       arch = d.getVar('DISTRO_ARCH')
>> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> similarity index 91%
>> rename from recipes-python/shtab/python3-shtab_1.5.5-4.bb
>> rename to recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> index 7a5cfd2d..f20cdcf7 100644
>> --- a/recipes-python/shtab/python3-shtab_1.5.5-4.bb
>> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>> @@ -19,7 +19,7 @@ SRC_URI += " \
>>   SRC_URI:append:buster = " \
>>       file://0001-Lower-requirements-on-setuptools.patch"
>>   
>> -SRCREV ="8db4615b2c3ee0a9332b6030687e1179fcfc8670"
>> +SRCREV ="3cdca7c8f4ead23c194c4e8a84e2631989e26b3c"
>>   
>>   # We don't have pristine-tar in this tree hence use this option
>>   GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
> 

