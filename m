Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC2106F312
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 09:31:50 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43492.1774517505431758109
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 02:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AsIMb8l2;
 spf=pass (domain: siemens.com, ip: 52.101.69.4, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS92C3+OAhhDrjgOzDdgtgOM6d9t0pbrZOVDT+CVyKgpFRQgSOw3qETpIy0NMJTDjcIrcwgal/Rcyl3XNUVF0bfsp9MVxdMKngmJweRAQn1VaJ7X486IYiVCg6HCwNw7HRvn7iT64WhD0kFQ0Rq0C6n/vWis0StfMu+iMHrz0VOnLBqRzyaul5APgxBHBSMIYbffPi4JUgM4IDECI2KtjOoL2ywyJX7flKN5bXhptYGkkFvYxu+XTwtTOZYBTgTgEhLNK7e+mfa0GahfqnEbnTtx2c6Feo59aXEdAD90LV6gE1Ectzd+Woes3dLoy9/wNHUrHUW7mTeiAzpBLtUhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42qbKHyCsyzjxpJj4lLfaXIxnYwhLrGYUGHHiuDckQY=;
 b=lC5PowPmPWeJxJUiZN6BV43c1R+4oNNUw8495f0ETAcFRkbuX+9K5sxrrP+8CHOXfaofpFdPShvYti185B5eDtj/JU5aAo1gGJ7LVe6hK31p9uBLggbKtc5YPExNIy7BFWAnQtdTMO4Tx+dxR4OeWBvI3fhRUloP3yF2yQrsSJekDVr0B7FmV6BGzactXpjrUWAF4cw8EXPDYVU0Ac5QKn0lF9dDSytMvkplBkn5iJPPYCm8oPVHdT/BZCn+VH4tqeJjUuv50sP9/TNagHpreiw41IoF3RCtq5Mn0zWabM/qyMmtmxWwdvN1EjOhPOsc5E5fLb7/s75L0SYII+zirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42qbKHyCsyzjxpJj4lLfaXIxnYwhLrGYUGHHiuDckQY=;
 b=AsIMb8l2luqShrvlR+t+eJ74W0Mr5BXS/SZMf6AwVHOIYw7Q9yYY1YxNowQGmliHDL8zLgLhaQObJ21I3QKMimlWpRJC04aUdmTcEQ+3GzBxDrZN0wYMOMJnGuBH5fhzQU4kbsmwCklMq5hYqzb8DE8is/BagKZfTomvU+yyJ2NMURey46TRU/7juiP2xIWIOUS11bDtiv0MbcLbNzwvyVaO8xPs4RnfBE/3Cc7HKzZ2ol/7Vl27yWb8H/FnmdEKlG3ScJTCWHZSeh+C05qzCcqRDW99s7AW5kkbKyE+6h6VrfXPh3DG3DP+yuUeD+7dJj3gQN4lFLkyh5IiSxpBLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB7555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 09:31:38 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 09:31:38 +0000
Message-ID: <ace242be-8c6f-4b99-a1a7-20fabb20edae@siemens.com>
Date: Thu, 26 Mar 2026 10:31:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH] Use pipeline id instead of
 CI_COMMIT_REF_SLUG
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 chris.paterson2@renesas.com
References: <20260325122615.424136-1-Quirin.Gylstorff@siemens.com>
 <100318a9-325d-4d1d-a2b4-36ba664ae048@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <100318a9-325d-4d1d-a2b4-36ba664ae048@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0037.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::28) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d2564a-514d-43c2-61ce-08de8b1a7b27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	QH73Wkw3JE4afyZCJ8QimSBs+0SfB4N+Szv5w2uaWOMUCAJKRUSBHdWlGTdQSVvCz/1jHV3Pr6xD+Vurmq9HFhZvoJIxPBVjxHRxaAG3NiKqiDJL59pwUVFOrbiBDyJ4Ha2xlK1YraFl+2nT9kC31zm0184rnLAEzovq2NCzoDWsL7SM4G7i2ih8peQcThWrg43/7RL1x3ORAtgrIvwRi+A+DIXYDuU3pNU0CSN6ub2axhf4U+ZdJdIQ2yJbnGiOGkVXBem+bAyXz9p6y0y+9jFDtHxFaR1NiiQoZF2zpIMJMkujzhaKgoxafN9+6zRG+dGkuZ76uwm8kQDd3dE8U8Sxqq8Sl1U4DVytyw3rA+qZMNQvOAz1jWgRIh5Zem2a/SV9/4jtv95zIRFe6fI2aBXK38BcMB8nil4KsbqP0i+DqRtkFKeP0WolQ0X2uz0vzHbTWNuj9e83pgYobUttY45QFjNrxCbChJenrB2AIVphXlGr/z31uxgE+p8Ti8CxSMGwOMU/O9PKJ+vEd/Q2CVTMnzV+zhnb2BN0wiWgJocY4tRklybhqUeUcC4+iEbqmQhT7QdoPFHOpO32bQ41a1GCdSXV64bvxi2hDhXXuAXbq1b17zb9J0/bLftI6bjgpu8tscppay8jO8z8id91BcTtl73C3P2T3YM7vfLASpixkxu5OLHEw05lQVvzbTmYry3Xhhw9uCEETlYSbXhFb4kS2kPMsRYoXecC+RxwTTM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3QybjNpTlJwZ0ZLcmF2by9DUzBzNjE0TmFEMnQrRVkydjNRVUlBNGRKWHFp?=
 =?utf-8?B?ZVZKeFFZblMzTkxKVVdwenNzRU9nK01OdEpDWGtZcnZHcWdYeUFGNndpNk9w?=
 =?utf-8?B?WXVTNTh2Z2p5cFlpT0NBNlkrUDEyMmVLTnpIeDVQMjRIVEhHTXNxTis3NVFl?=
 =?utf-8?B?N2NFN3hYZGp4Z1JPZG9pYjZadzR5Z3VtRXJCYi9HYmp3MkIvVzRGbTRkUWI2?=
 =?utf-8?B?a3FNdjdTRk5zN010NFFZUzJGayt4dGZseDlVbjFIOHVRdWtNZ09mZlJUZXRv?=
 =?utf-8?B?RTJPaGs4eTMwV2dXSTFKZXpDOWdST3htOTh0b1B2eWthOVlXcWJ5U2hzQ1N3?=
 =?utf-8?B?QnBqWEw1anJ5UTlEVGpISjkrcERjamtxRWFSNmxrcEovMHk0T25SSVh5cHVH?=
 =?utf-8?B?L3lyS3lnV21Zd3VJbCthTG1VcDBmVGpBNVVKcnA3aUs3WUVacXdaQUJuTTlS?=
 =?utf-8?B?alhWenR0dDBnYkhQclRYRWFLSjNJdmFCYmpDV0FQS2gvTXR1VGkwaEhvbEdN?=
 =?utf-8?B?eEhFRFZEUnYyMlI1MWxqcHc0cDNkNFg1eElZRG9oWW5JNStpbC9Xc2pNNHpm?=
 =?utf-8?B?UG5kc2lZS2twU20zLzBPQ0VMQ1NHMHdqdnVVMDlMM2tBMEIxaGJmbFFEaVVt?=
 =?utf-8?B?Vm0wM3BRaTUxSlNYclIrajlacnArcVh4ZjBqVXZrQmdRMGpDSmpXUVhieFNs?=
 =?utf-8?B?dzF3c0tlcVlMc0szUlZHbk9xTTk3ekxGRXNmZEZGZzVUWTNVWGJmM3BPYnAx?=
 =?utf-8?B?a05zQndEdXQvV3djQ3M4L1RORzhqa3ZUOFhaZzZhaFYzNG9PNzBQRXFFdWZL?=
 =?utf-8?B?QityK0tVZnRRZk5Sd0pSN3M1VTUyME5UdzBGSDB1YnIza1JxcXpHNGhaVHd2?=
 =?utf-8?B?MmRBZjZpZFJKRmpMeWpTaWFPd281V05qck1jZ1AybW9Sa3plVmdCTG16eTdo?=
 =?utf-8?B?MWxPRjQ0eXJTWFNSNGh5UGp5S3RYZzhkUjNadjQycnh2V3lhRFpjcFNFK21u?=
 =?utf-8?B?VnlTZnlyNjlLRnlSamJ3bXh5ZHhTdFpnc08xR2M0VWx6SnVMNVJ0ai9TMlNI?=
 =?utf-8?B?Z1ZPRHRhT2lOVXV1N0VQQTNTUm5FTGpvSXlPQ2UzNmp0SGdlL3hZNVVXK2cz?=
 =?utf-8?B?N2UwenNBcVYrSUM1MWhHdEh4T2d4dXRKWERLT0xjRDluSnI2Mk43OURPWW1a?=
 =?utf-8?B?M1h3alBpZkNZaEprY2lkWllaaFZ2V3c5ZGE4SEFOL3dmME9xRk41VTlQWE9t?=
 =?utf-8?B?OGZoOFZJbEpqQWxoRmdERzM5RkNLSEN3TzhhUmZpWXNEM2NIUG13N2tDN0RQ?=
 =?utf-8?B?Q0ZNS1NabFdPeWkxay9jQjFyS2ZHYnRvcTJXWW5XSlQ2ZUtzZnNWeWx6TVlC?=
 =?utf-8?B?Tk1BVTBJYmV2Ukg0R0RRVWdkNUJLL3JjbW1QaGhMTjlnVVBXZmhrdFhWVFZE?=
 =?utf-8?B?SzB4Q0xvZzNLMEJSTjdCK0JmUHI3ZGxFdzVzZTVhVWlWN0ovMzNWeTVVMDRu?=
 =?utf-8?B?cGJEaXpEc0xnOXNhTFVzUlJ0eU45TGthQ0NjM290R29QUlJESGEyVVNNMFdU?=
 =?utf-8?B?c28yK3pQUktoeDlNZ1VGUFQxdGgrQUFVWkxPRFJKUWxNT3IwTnZBYWI2M1Zv?=
 =?utf-8?B?eDh4OWkwdkxrb1Fra3pkOTJmWTd2dFNFQXFhVkhRQ1VmODFsUUJFdjI0b3Ew?=
 =?utf-8?B?cTJsUjRWWjU0bmtPMTJ2M1plTU1HVWY2aU9ldWYwZ3NFNmlKWXFjM1lUbzlD?=
 =?utf-8?B?cFlGeGlCb1FHa1dRUWZFL0VxSDBVSHJndmN3VVNoMlZWUVJjdmNnNGtPT3Z3?=
 =?utf-8?B?b3p5cFczdGRmd0NXVGxJVHhaQXVJeDhnV0FyS2tWMXc1VGovOEZsekRIK3V2?=
 =?utf-8?B?SGVNYlJvbHJqUnJTVE9jSEhGcTFnVkl6TldINTJLc2FyYnFXQlJuZ2l0Sk1E?=
 =?utf-8?B?UzBxRXNWY1JSemc1YVYyTTZMZi85dXBlVSsveWlZSTlFaG9YN2k0TitmZ21j?=
 =?utf-8?B?TkFSRWxlcXhVdXR2aXpGcFpEbXNGcGpKSWNUY2Iyck1WeFVtS1JHRHFTeTRI?=
 =?utf-8?B?NlNxYll0OUpyY3B1eGE3czVaTDZGTXJJanY0L0YyY283cnlpM2V3K0M1dzVB?=
 =?utf-8?B?N2ovQjYyZ2FXaWJUZ0dIZ1FyaERDa3NMVnoxWU9iUDk0WlFmUmRMbXhlbnR6?=
 =?utf-8?B?bHdKK1ZJZSsrTzFBbFJSQ3NzYW1GekMwbXpFYVM2Z1RTWkFYdE5ReDgrNHk2?=
 =?utf-8?B?VTBwL2RXS0FNcUV1MkZ5YjYxemxYL1ZZcHhDamgzZE9MdWg3aTVYTkU1M01I?=
 =?utf-8?B?RFlUSkxqRDdPZXRIVW4zUnNraGtvNWlqQ2NjcnBOLzBBWEhEK1BscjdpWVlE?=
 =?utf-8?Q?MEIgiQcpeiJpVpS0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d2564a-514d-43c2-61ce-08de8b1a7b27
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:31:38.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyM4wLQ1dByAVOysrk7qcrfW2irN2gIzNc9Y8zAquymA/WA91kFkK2zTNBvZcmqlUR0/bspxQhsK1MFAs2acTgMXakRS2N2fYBjdFGKEwPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7555
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 09:31:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22578



On 3/25/26 3:40 PM, Jan Kiszka wrote:
> On 25.03.26 13:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This avoids errors due to overwrites from followup jobs.
>>
>> This change requires a clean up in the storage backend(e.g. S3) to avoid
>> storing outdated build artifacts.
>>
> 
> Who could do that, and how to coordinate that best with applying this patch?

This would be the admin of the AWS account, as far as I know this would 
be Chris.


https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-set-lifecycle-configuration-intro.html

Quirin
> 
> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 602c503..75f0502 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -71,7 +71,7 @@ default:
>>       - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; fi
>>       - if [ "${build_updates}" = "enable" ]; then
>>             mkdir build/previous-image;
>>             if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
>> @@ -90,7 +90,7 @@ default:
>>             for swu in build/previous-image/*-broken.swu; do
>>                 mv "$swu" build/tmp/deploy/images/${target};
>>             done;
>> -          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
>> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} swus;
>>         fi
>>   
>>   # base image
>> @@ -359,7 +359,7 @@ build:qemu-amd64-secure-boot-buster:
>>     tags:
>>       - small
>>     script:
>> -    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
>> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_PIPELINE_ID} ${iec_test_timeout}
>>     artifacts:
>>       name: "$CI_JOB_NAME"
>>       when: always
> 


