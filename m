Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D357C54E58
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 13:14:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.69])
 by mx.groups.io with SMTP id smtpd.web10.44029.1710940474467208712
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 06:14:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G3Jxd5zj;
 spf=pass (domain: siemens.com, ip: 40.107.6.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJF+KnWvTeA2zCO6ZxzVdjpyhZ5Aor9N2k7ZunYryufZWr3sXhkbOg9DaIM/3pqb62cXzqAXp+oJVSyRP9jHjKkzY2pyLXX6dp5jfp81rmK5hB1TmizNDN+x+lxAhv6HfzhNziTpFhyu5pP+CSNMSwTuGFIu1gghj4j/loeCo1vRQX11rwNOHauWiPjTmp8glDzgqdjVy503OjVLIb0UehVRZfak0zsCWKgkqkgarNLiaSj7N0HNq8zrL00e5FyhQ/xsHmMz8ULrCvsPSsWJRIU+3vKOwBRO4pUYOtGNYREYYewkLR6W8mJwjGwxNaw6H0DJ7L8t/htgzuM8qbrdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVET74qtDEGMfQN+0sJM5SXr794KAqWgr6dFPsmVlJE=;
 b=Ny0/uiXSy4vqZhr+VYbNmZ6SxFD44W/6eyPhU/GEhfT2MMTQmw+av3gb8galJyMICut/swcrsNLEtGHhumfanFAWj2rZBVw4NhE/QqpNtq/XXzRZToQpoKZ0Ku13Eu8XHUDB408dW3Eo9jC1iHm3KzAfKDaS2LslE0EzCRvDKKGYNeHlUVm1yiz9VbvEh/0cC72Qej4MsJYErZFSE0GVyFk9ar1k4SOmRX1cSOcyx2VYowcUNq/K3kKJaB47qjJBZiEnXVTNgbx9pYfs5NE6AYlSRRqTMQjqPeekHe8bksCsBIRxknJ6G8QX49x7TCfjwtp/nkQ0c64n9Zh5mLzIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVET74qtDEGMfQN+0sJM5SXr794KAqWgr6dFPsmVlJE=;
 b=G3Jxd5zjO+oZIJSIXEJlIy2xEmsltNwwVmzk1z85fUUkCY0R0uXe5HyerfE5VWfrbb9lqLyYFrDaGsu8H4CKVd1oZUj+nW9cMbLQAQ44A6XaMUnZh8V9rYgEob2sKwoes5ISX5+3LWkoAQz50HQ9FWLRmFJ3c/6mFHwG3lZ+W4RKreN7RzT2RS2rJpdqafZfEJQb+MAMCcLnafmOSluc9d6tCcb3gD24ymn+UXurss+5V0AKjLAJg1YiOiIvdpcnWjIdfNNhs6Wd9kagTUnxB7eyrNhSA5stAT0xrSrs22nfz+gtiMLNS4efPyyvRZZDPvrw98pN/uqo9yYSeegcFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB6880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 13:14:31 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 13:14:31 +0000
Message-ID: <6232a276-c260-440e-a870-55800807822e@siemens.com>
Date: Wed, 20 Mar 2024 14:14:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-handler-roundrobin: Add
 link for handler search path
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Adithya.Balakumar@toshiba-tsip.com
References: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
 <3f30557c-6fdd-4715-a959-1cb27334a319@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <3f30557c-6fdd-4715-a959-1cb27334a319@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dc01ef-952a-4b2a-59dc-08dc48dfadd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jmKxLAodQ8e4Y6PPNXxys++M8kaei3qFkLrcGInyWEs0xWvXwydQ8//iDolpnJSodj9OhNrChZ3ja7arqsgF1nOH9/erlhPGKdHiOCsoS51Ch2yTuLUaCEuEGYn6jV7QG/SBvn6ZRSfRuIHmf3Je6uwiOa3GUuGGrZw2iEYKXfa6VshX9gys6WTe4gB9utWVq3weEgG/JrIrQFa61PbsF3LxCspHrV5db51SQki6LOxZ3OMyShPLbpt2yWTKVOoTkLAhUQpHB+Vy0Ai/WKIyGJK8GVpbAD1p7aDo9O2O0Qa4b5oA0OOaW9KXdqQTjeGVCfsSmmznr3oNOz464CrdphJa7gpuMdhbG94nFBga6t5ho5qYGKOE1JRyzzJhfSKsIBulqtpGZjTXkgk5ws0M+y+jtolZWozy7bu56OlAWkbpEGvPoC0y6GmtPgPx+Yd4+YRVTIuKhxvPmfA7nUIER5XfZwNfjpaFROA5fVJlaAvp+faj8+KD+BTLIXhEhnzmAxamM6C4GcO/RgdjLVeLRhJhuIOkYuK48ilKeqSU6icjrmD9/sT7mLscgbILBYXoffv3uZDXz7DNQJLTons0gBwIfJnnJClu89s7Omx7re8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXZCQ0IzYVZOWW9CbFhPUmtBcmhOZC9WTmRFRm5SeXFMRFYxb3ZLSEZjbnFV?=
 =?utf-8?B?UlBLU2tVc1VsZjZGYzkybmVjNGRpK0UzempEOWt0Tk5JY1hwQ0FlTTlHNmZr?=
 =?utf-8?B?N3JBRUNGY0NzOW8rTzZWOWVUVURDSU1Kd0M3ZVFRQlpHbXQxQTVkTkhObTk3?=
 =?utf-8?B?bGZPZDk4clBHRDJ5SW4xdzZwakFVOE1ZeTB3T29lSmhZTnBmV1A2ay9vZlRD?=
 =?utf-8?B?ZHdVY3dVWDY4bFcybUx0S3pNMGpCdWNOdWZRQkU2dy9ZcTBoVDhQMEVoYTFk?=
 =?utf-8?B?QmJ6dGpqR2c3N1djN0tjT0ZVQnJQS29zS3g3NW82TGdSWElhVnFKRVZtcEVF?=
 =?utf-8?B?YlY5Znc3R2ZJZG1TajVLSkh2L1hYNnErWm5vWktscVE3aG1FeFRTM1dSU1Rh?=
 =?utf-8?B?NFluNzh5TjAzYzFzb1ZSMXM4UHg2ZjRXYmRtZkhwY3hzaDZSaVhhQlZ5clRJ?=
 =?utf-8?B?SS9VSG9ZSTlIb3VoUER6V1gzdWwwSG02ZDRCdjErZ2JPb3lFcW5pQjNQWnhz?=
 =?utf-8?B?Y3hIKzNML1htOStUdi9vOE82bDA3VVljUG01M210aFMweGVDZ21MTVJjNzRr?=
 =?utf-8?B?Q2tDWThnRFp0L01NcWh2NEZjTFpiZXNPWk9jNkpibjRBa21xU1lSd2NFZzRH?=
 =?utf-8?B?c1lGdktjdlZudDNsL0oxM3lPdmxaYVJsWnlOR3pJVGxTTHBDNEZQNytQckIv?=
 =?utf-8?B?Zm1Uc1RaQXRJelFkNlFlbUFZbllibDZKeG45bW9sM0hWYlgzYThwY1NCMFRt?=
 =?utf-8?B?dGdmSzBheWJHNzIrMmFKOXYrN3phZkt1d2xxWlRoYk9SSWwzSms0bXM2K2Zh?=
 =?utf-8?B?VmViTEtIbnluOVFacnFNTU9Zdi9JVEorbEhvOUxhV2kvdGI5bHpRSWRPbHJp?=
 =?utf-8?B?TzlCOEpKMS85Ny9mU1RUeE52QytYaTFSUUQ4QjZDVnVsT09SeTQ5MnNXeFFq?=
 =?utf-8?B?Tnlqd1VFazJQakU5dXZEMEhhWE5pS1dzbXlxSVV5YjR5NTdTR2pGUlFNanhH?=
 =?utf-8?B?VWttLzNPZWN0ZS9jMUZnQ3YxNlhCMldNanA0bVVoNXNQOVlTRUgvTWlLelBn?=
 =?utf-8?B?dTdKR3dlLytaS1pqTkZPb2tidytscUZUQlBRU0tOaVBLdE80UUVoVzN3SEU0?=
 =?utf-8?B?WGZiNzYzSWo1U0IyVjljYkRFMGkyOTNMMDBoZDZsVEloMnpkMFBDMTRnYjRJ?=
 =?utf-8?B?OXZuKzd2UVhjOE1OL1FMKzZZWXg0RmlXZmFlYzVic0JBRUVTbVBDaDlkeU9J?=
 =?utf-8?B?Q0hvWFgxaWg4a1B0TTZIM0lOYnhHUk1VVHZ2NnZySFYvQXRGWFdrVFFaOWU4?=
 =?utf-8?B?K3B0MzhRa2RaUEZVaXl0UW41NFdkTm9CMng1MWpiUHVKZTlpOFAzZzlKbzBp?=
 =?utf-8?B?MCtnZzJMTk56OVlBZHJOTFZsREF3SmRZV213bk9kWnRQWktPMk95OGp3cHR3?=
 =?utf-8?B?OTgxUWpXYlpZTHF1ZERxR013ZkdPZm93Q2pyUSs3NHFkMllVVDd4MFQ5cEFI?=
 =?utf-8?B?YjVZUDhHSHIyRDN1U2FTeHBHY2lnamtRRlBIQkhzZElpc3ZIVFlCbVc3Mldw?=
 =?utf-8?B?Wk54S1AwUjFnYzZOazlUcFNRcmtRQmFyN2hnRFRnNWQ2NzdyRUxWaS9JVXFE?=
 =?utf-8?B?cXJJdkdOWnJpMkNNVzR6aE1ONGRHUFl5WVlQNEwzMlRzR1Y2cEVHcWl3TkVY?=
 =?utf-8?B?UXQ1aGVsdUlENWdJcExkcG1LQ3Z6Z2RRcUhpSWk4R0ZPaWZKYzU5TnNrYUtZ?=
 =?utf-8?B?WktHYTFWQks4TVRFMmtpZEJIWHBjUnN1WmJtWVp6ZGRlUnZkdWtHQjM0eFNs?=
 =?utf-8?B?UExNL3NHVmhzdWExWjhHeXhzYS9iWGRvbGxib2dsVzNpR1ErSGxOOU5vdm9K?=
 =?utf-8?B?ZGpvVDdKRWNCNmJWQm9oZmVodlJYQnYyaHJja1A1Zmdxbitmc2ZSOTJ3Q29P?=
 =?utf-8?B?ZmRYQVdiK0IyODROUEZBbzRHYlpoZ1NzbDZUL1pmRnowTFVlQ0pYVi9qaFRD?=
 =?utf-8?B?SzZhUFc5T2wrUGdhVGtheEdreElyNFgyUWtkRVF1aEoya3NYeDVrQWhqOGo4?=
 =?utf-8?B?eFZTMUIxQ0UyNmwxa0h5ZzFUQWx1aVBPWFdCNmFxc1dKTUsvWVhCaG10QjJK?=
 =?utf-8?B?WGp1Qmg1R3BwZmZiTFlxNi91SE9tU3ZKZncxQlU4REdKMXZWSDBvOWI1aUFX?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc01ef-952a-4b2a-59dc-08dc48dfadd1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:14:31.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Unl/v+dNLw9b+hwo4pGUVn+fn0iSDmegR9D+kZ4AevKillnf2DRr9XnnUXm/H1DVmg3BC/IDGL9OwqAqFN7gtVqV2npVVfd/ANBi+LBjwWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 13:14:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15390



On 3/20/24 2:09 PM, Jan Kiszka wrote:
> On 20.03.24 13:59, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The lua version which is used to search for additional handler is
>> hard coded in SWUpdate and debian salsa[1].
>>
>> To support multiple distribution with different lua versions add
>> the variables SWUPDATE_LUA_VERSION and SWUPDATE_ADDITIONAL_LUA_VERSIONS.
>>
>> SWUPDATE_LUA_VERSION defines the main version and for all space
>> seperated entries in SWUPDATE_ADDITIONAL_LUA_VERSIONS a symbolic link
>> is generated.
>>
>> [1]: https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
>>
>> This fixes issue #102 SWUpdate failed to install update on bookworm
>> amd64 image.
>>
> 
> Should this move in front of your recent changes in 'next'? Or is this
> issue older?
The patch can be moved in front of adding SWUpdate 2023.12.1. The 
problem was previously undetected as all supported swupdate version
used the search path /usr/share/lua/5.3. But the delete comment 
indicates this path was updated once.
> 
> Jan
> 
>> Reported-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../swupdate-handler-roundrobin_0.1.bb           | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> index b39278e..95ceedd 100644
>> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
>> @@ -20,12 +20,22 @@ SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
>>   SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
>>   SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
>>   
>> -# lua version 5.2 is currently hard coded in swupdate @ debian salsa
>> +# The lua version used by swupdate to search for additional handler is hard coded in debian/rules
>> +# see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
>> +SWUPDATE_LUA_VERSION ??= "5.4"
>> +SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
>> +
>> +do_prepare_build:append() {
>> +    for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIONS}; do
>> +        echo "usr/share/lua/${SWUPDATE_LUA_VERSION} usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.links
>> +    done
>> +}
>> +
>>   do_install[cleandirs] = "${D}/etc \
>> -                         ${D}/usr/share/lua/5.3"
>> +                         ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
>>   do_install() {
>>       if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
>> -        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
>> +        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
>>       fi
>>       if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
>>          install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
> 

