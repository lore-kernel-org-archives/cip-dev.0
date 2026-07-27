Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075CC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 07:58:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26253.1785139116774206565
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 00:58:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A3BrJlCi;
 spf=pass (domain: siemens.com, ip: 52.101.70.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBRgtVJXOI32rCRa6p2XjyH0cNaT69OnX15fihEIdCT/DepqlqOuPccygfeyY1YaduBme/VOfeJUymh535+nWF9rjLPGb/fyKZuk5SnUUeOr6bHRcTihh24e+yXdA6PpCWj8RgSUVMG6OZYrBkeohdZqXpfby8CN26WkUa9cpFpANpBo2+Vnc03386wAYCj18GGI6U272hwZFVRr0HD5Ao5sJiDi1hHHNBLAt8P/Et/X3i32B7XF/CX5yR9D8n7cA+uxsdfrh0eNngM5WF8jNMDpWSma2i1l6lkBlMB1nc4+7vLHrgnfgAzr9zebCBFLhlCVzB5eG9SYTBy+U+xaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDSxXT1yKf5AIg7WkFO6lJmD84zkUG0cvKr/pqgHzW0=;
 b=Tw2Iu2l0Vaze8v7F/o+0KHbpTYbQD4tfi+nBz7k6jHNApmWNxLL2EsSIDBXlWP273EoNmTiDan7ljmzQhOlDU67vyebWV22a5yPeik3y8HEB01r2/Us3XD+D9gUjyvdcvMEyEbfpmtUmYtoRoJCPZ2ShfekykoNXgzj7TmPJfoJm0YKUwPFQvEyKrjaRXJXOGAymCiLJYYtyAHObAMwgYOOufF0kScJwzRzmiDLReRmF/FNfk+cAkHVvq1+IpV8cCO9muVBCdPxcAlOvG3gR389sH8enSnN1EKQLJQLVXoqOSjnDxd7dTyXya0LJGF5AFYMF3hN9Z/oGtKIKPIEc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDSxXT1yKf5AIg7WkFO6lJmD84zkUG0cvKr/pqgHzW0=;
 b=A3BrJlCiy8+/oRyK1evEA9Z6jnVYy/qxPR7JpRgBjKfvUVmqdL5oBBjBzKQfaN8ZdFEFnUb0rYwZ/83QaDgTaGXda1Q0RD0VnrboZ/5cjX8pGC60WSc32yXuOavjJXaXfUs8T1A9ivyxtLYl/u9clQpS3twaGkcdzL6CCW6eoyEUcydvmAnPmpMUWLJyFg4Mh8Wi0q6W237tNzfrMlPpSzokz+MWUiBkopPrg+XXJ2V8Xa/8X1qyp7EN6Rv4GD95nbNfyJvmmAryOIsfgCx/3uIy2+wqI+sMsu3mCchEWuLLTiypHbkqV+GH/q0BT871gg4tG6EeqEL+77YSXI/Z4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM0PR10MB3522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:58:32 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 07:58:31 +0000
Message-ID: <6e45b645-79f2-427e-a917-6845223137c3@siemens.com>
Date: Mon, 27 Jul 2026 09:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 4/4] switch to isar-rootless
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <20260724105116.3575045-5-Quirin.Gylstorff@siemens.com>
 <5084bce8-426a-48d7-bbfb-66535442e68e@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <5084bce8-426a-48d7-bbfb-66535442e68e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:208:32a::32) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM0PR10MB3522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae5dd55-7bca-44d7-cbe9-08deebb4d9d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	OYPIT0ZxliKC9yZuZq0JaF85qV+UYDN2yHlOiXoWm/kkUNFeNzzWkd3K0ZdsVzavilMZeUYl+pglB2JmnhMJ4F+BmHAWJ+j5yRkUjmpRZXYsDxaCDL/NVHL3UZiy6Dnd0zM1trz7TTJNccMsAMQhxSA+i4rSQ5pDiAV8Qv6SFuqY8tojgJiU0c4wKaG4G0VQwhIDtfv4agGqg1bgWqNNMhOKjOtei58G5NsDTzh3W7M5a6MMiIyC94jewvT+DKzpEhJOM5RSCsEZn8D+ItDVWmz2+K8eZk3nBCK3ADzbk+n9NiGmiNuXzNpEPptH1ccoIVjNqNordseGRZB2wgHElbS31qCpNB/VT3qHKBFogizri7a9nAX27Vn5Hf9h5ztpBHAhyTAyBg6d4tP/q0jKvx8cI5CC5vsFwzTZ0Rwn2Oacf3IsJVm5idDQvx2OiBQIKqIqgyGdPE/5SR+usFQc53VuXjSeaRHILzivyy/IDFzxStfaZZoqV5xiKaQx4gwNUIqR3BpIsnCxs7jTZR9UfnjYXYqPq1nbd4H89F4enekZj1E1Bs2i4nAGlrV9BJPcI/j7l74RVJfHWzDgGdT1dFSL195tj0++GsoBbf6w9iKL7gWcuEnyjKVpUvSXfkWwo/96NrYvHN1bVgmmGQqVly48eYkB2gui9Ek5g4Jkn6g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SG4wVVBLU2tidEdmWU5JQ1RmWTgwMVEzTHpYOERiSFRiZkcrdC9qemo4ZGRX?=
 =?utf-8?B?MUR6ei83SjR3VmxXaGxEUnV4VmJBQUp5VDd4czU4TzlTN21EV2tVZ0VoRWZy?=
 =?utf-8?B?R1VXUGNpVHFVb0c1YjJnOGVrSDhFQlA0V09zbDFJWmlMQ05YajM1aS81ck1a?=
 =?utf-8?B?Wm5qMUVaNWY5RWFOWlZHdVRabzlyM2dzZlFwbGhkd3o4MDJoNHJKelY3N1NE?=
 =?utf-8?B?bGdXRk9HbDVTUFplZDBBRm1oQnhMdnZEamdwc2hwR1dCU1BjaG0xeG8rU0l2?=
 =?utf-8?B?V3UrL0UyQy9XczBrUXdPeHVicDhkNlFWZUR4VzdBdFhoZmRxclF1ZC94Wktn?=
 =?utf-8?B?T1h6YjZiOWFmaGQwbjlQMlZpL1dtMDcwQzZibzhCM05vYVF6dFVFRGNWcFpW?=
 =?utf-8?B?aTVKbkNWUFNWZTlwSm8yNVhYbWgrWno4TFd3V0NEcTJWdUZtcWZLU1FHWm0y?=
 =?utf-8?B?UW9VV0lTQjdyc1dXYVBMT3RScXJPS0w2THBtdGdFWmJGcVVnRE8zQjN6VW9t?=
 =?utf-8?B?QlROWFRtU2xZZUhvUlk3c2hWNTlSQmNXbkFKdUJVbkUrT25zOVVLNFhSSXRM?=
 =?utf-8?B?NTkxTjBuK0ZrYmRPZXJyM2dBMVNybXpwdjdNdm4vcFJiVWl6R1pVT3ZsTURC?=
 =?utf-8?B?Wmk5bG5TRG1WQ1hCWHlYL1lQc3grNi9Ndk9sV1JyWmxTbWM1U3N2NlRuVC96?=
 =?utf-8?B?NGg3TEVtNTA0RjhNcmFsK0lrWHlqazhjb1I3cjIxQ3RyR2xvUDc2eVY0OVR2?=
 =?utf-8?B?MnU4OTloQlRheGlVR0FmOUlqYWxmL1dOb0Q5VXlDb21LRGQycmNES1Y1WkEx?=
 =?utf-8?B?Vy9QcWhjV2U1L1dMbGk2U0JnUTh5QzdteTRWaEliQ2VodzFPQlNJcW1vTThL?=
 =?utf-8?B?bUhOMG5aL2hQc0xBV24zeVZpbDB0MCtFZ0xSdFpJUG5qUkhxT29ZQWRmOGJY?=
 =?utf-8?B?Y3A3ZFZML3VDRXpFTXJjS1AySkt6NEF1allGM0VhZVd4dlJsaWpxWk1LLzFv?=
 =?utf-8?B?b0QvN09ENXY5MnFFVFdxOWlYc1ZhekJvN2VQWWdaeVV2TWpFRjV3WktWWjZD?=
 =?utf-8?B?SGhMZTM1TW1PZEJIZDFPNDQ4cHU4M3FBN09CNUJQN05MckU0c1NvSzQwQ1hG?=
 =?utf-8?B?TlZKQUNOcFVMVldHNzg4ZWtYWi9VVU01bEpLMGFzQmNQb2NoMGtiUXAyVUZm?=
 =?utf-8?B?NDNITDdXM0Mrd3NocmVISk1TQ2lBS1hFT01JVTV4Yyt5S3hySXljWExCYzRY?=
 =?utf-8?B?NGs1dFRaOXd6elFFU3VVWXVtVlFHSTNRZUhjZjRXQnRrQk5wcFdVdzZsMjR6?=
 =?utf-8?B?UUVCWTVlb1hwT0htaXdUNGhMR3l3VC95NUdPQ2d6TGVFdDRDZmVCT0NHbS9F?=
 =?utf-8?B?ZmI4aFRBQWl5TEYrWXFncHBtOE4xeXY4M1A2bjhMVjJtN2NrL0VOSUNtK28z?=
 =?utf-8?B?bXdLeTVIZStSVlBPQnN0UCtCWHFnb3oweWlJcktSU3Urb0U0aUpzbFA1YWZZ?=
 =?utf-8?B?eWtLN2hGN20zWTB2VEdicC9kaXJJcWVaMFdrUUFxRDZxdkhuUGdNNzUwTFY1?=
 =?utf-8?B?QzFBVFI1aWgydUJlSnhORXZzZjl6d25OQmRKS3R6Y0h0eVJUV042S0NBMGdw?=
 =?utf-8?B?UGpXNW9IcGNHY1RuTHF3RElDUy8zZFJOQkpFSUdrS3VkOTFqRjl5a1BmaE9G?=
 =?utf-8?B?MDMrM1RXVWRGSXFQRUQ0Vms3QlpCUVdlOEhzZnBCV29RS3Z0eko4VUxzUTE0?=
 =?utf-8?B?eWdmNlpsWXRaSnBqLy9DNGYzQUhFR1FEUkNBajJXNTNRQVRDZS9GL2kzdFdT?=
 =?utf-8?B?RzEzRzFZME5wc0N1TW9SUzl2ZlpPUmJMRVdmZjRDVHVreFlUOWdFRk44bnRv?=
 =?utf-8?B?RWNTZXQxR0JOeDYveGE1cCt4RVBVdzZVeHpxMHFSTEgrZWhZdGhWV3BpZDVM?=
 =?utf-8?B?TlJHZDdBRkxST285TGNXSnhRMW54NWVqNVQvc3VxdFNqTXNNYlgyeDdwSURr?=
 =?utf-8?B?M1NGcm5ZUCtIOWpDZUdJMzl4T2F4d1VNS3BOSEx1STlqeXowWHF1MUF5cFJH?=
 =?utf-8?B?ZUlMUENCL1A0eFAzbzhuak9EUGhwOS80K3l2T2t2bHYyN2Z2Q3F2NEVqYzBB?=
 =?utf-8?B?bmtzVlVXUkcxQ2xmbENDYzhqMFBnMmRFNTZuZVZROHBxb1JvbERGSGxGOEhU?=
 =?utf-8?B?cWJxVVVlUlFlUTFRQ0UzVHFUV2g0clZ5bjZZc0lXYVFpeVpoVnhKUGlZZ05F?=
 =?utf-8?B?UEh0L3kxL3dUMGVEemtweTJrc0FGeGlGVFlta0pRb3F0aTczZWtWbUFLMVFo?=
 =?utf-8?B?OC9tVFF5cUVHYTFJMUpYQk1tUzllSVJhQW9pa202bUpaSHNyUHg2ZFd3M0d5?=
 =?utf-8?Q?B17KE2Ro2/LsHsko=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae5dd55-7bca-44d7-cbe9-08deebb4d9d4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:58:31.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfEXlnemlNG3CUyAgnxICTFwqhKqcMY3rb+cfOLXR+Ms/P9AuO/E1oiNgOtQ+suz9i6Gotd47cZ9CB7pVstVinm8pB/I/Ieip5qB7GVFCk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3522
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 07:58:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23753



On 7/27/26 8:11 AM, Jan Kiszka wrote:
> On 24.07.26 12:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   Kconfig     | 2 +-
>>   kas-cip.yml | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 438234c..abf9aaf 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
>>   
>>   config KAS_BUILD_SYSTEM
>>   	string
>> -	default "isar"
>> +	default "isar-rootless"
>>   
>>   config ARCH_AMD64
>>   	bool
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index cbccf63..eb26716 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -15,7 +15,7 @@ header:
>>   distro: cip-core-trixie
>>   target: cip-core-image
>>   
>> -build_system: isar-privileged
>> +build_system: isar-rootless
>>   
>>   repos:
>>     cip-core:
> 
> Please update the README.md accordingly as well.

Ok will do in a v2.

> 
> And then there is .reproducible-check-ci.yml:
> 
>      # clean
>      - sudo rm -rf build/tmp
>      - sudo rm -rf build/sstate-cache

I will test it without sudo, and add it to v2.

Quirin
> 
> I suppose this also needs updating.
> 
> Jan
> 


