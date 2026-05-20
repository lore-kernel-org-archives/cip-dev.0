Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D1CD4F54
	for <webhook@archiver.kernel.org>; Wed, 20 May 2026 05:07:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5383.1779253635551192481
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 May 2026 22:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=orb6W4+W;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoDkh00F8/3xbuVvxajHmg8KMGoa9cjAoEskNl6AjIu86EmvB0oisW1CZ45wSLDkTR5+ukzWblAJNM4UyLexpksl3SQPJZ0E4FSQLns8DmOubaLmgyBqBNdWEVBkYbuzgT5HGoU6JIjzemhdx353Gg2jJQqxZwNJQn+y5l1/zyCBU0xd7rowo1a3Grb3prhMzFJUY4BHGfFtXHV638oSc6Xv12KjCzcwLIt3Pv8iT2v331GKZuvRUUmRbIApyR0FPLVVlmGZ37no7xRfdiFNk431yvJnNSzM9Brgp/QaL2WC5Js1MAVVvsU/Ub/OUgtwdxYzHYPjoUjA89yp/DSEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsPFkw2NNm13o5PH+QoT4Sgh5Gzx3pJOVtAOTK9kBLQ=;
 b=wclHPMoitsCssu0fnvXllUnaEbVvGaXsjw6PvGC0Sc6r/HkXlX6oDIXfTkACgW3CXVhJzigaXEPZj2QYKLZwazBffplmwEYQEy9NYM+Ywkr/zw4GDr/efM6/i28hJq66p/GjhO91RFNCcBNO36WVLzRIu1B0kdeDus+UDl97LYRX1Qz666IXOTPC8q4V8+pzbGuS1ituRpzzPB59ZDES2GMtBixdctgnIqero3OtR/QkM4tY/1qu8sa3KmQuvym/ZaHlFw5Ymx0VsuV4z5UEkBN/yLpxWL7a6qdJ0tN3MgWQRet6rf9Ho4wUnReE7BOcDqYEDy0pec18C4+ac9Ai2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsPFkw2NNm13o5PH+QoT4Sgh5Gzx3pJOVtAOTK9kBLQ=;
 b=orb6W4+Wqv+YguwtkEpbcvEyFspk/C91DEo/I9BrGdlXV+cM8JvKjytwJMQkg/WqEmn0epZmKC39P56YboWSfOjYddsKU6xJTFfcVbFZFNKlergMqY3HqdmapMf/RStoHIJjIeOW4gyqOQaf2+1kwawzSbV5XfYPwYGR+KhfmY398bjzAO0knZ3Lzr23X59XmNAQL2L2x32y8tjzoY3R3qqOfnZ0xcL4PoNXdAQ/A3YptsZOAoD4N6siDaW0SVKRp+TW3C4rHyF0Gg+7b5P1kMKvQdvQL5It8Z+QVRRPjBLy7Dkv28pmhbnmPJ63lmxKzDr6r7o+RHPvxE2LhFewhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 05:07:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.023; Wed, 20 May 2026
 05:07:08 +0000
Message-ID: <d48fb5b4-6f37-423d-af3e-2e363589574e@siemens.com>
Date: Wed, 20 May 2026 07:07:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] lava: qemu-renesas-01: "client version 1.41 is too old"
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
References: <e4be98a1-10f6-4b0f-9e5f-b990be2204e2@siemens.com>
 <18AD50B115979D9C.2359280@lists.cip-project.org>
 <OSZPR01MB8123A5AB3F64208BD0E653E2B73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
 <891d080a-c5b0-4cc4-8141-f40560d964b1@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <891d080a-c5b0-4cc4-8141-f40560d964b1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0213.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5683d9-b22e-407f-cfe3-08deb62da42d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	P9FAIdixR+wqQRkeCPmkamNvBkHb/M75wOLsxN3kxYZyM0+/lZP1YtCIhW0Eukv/qp6qnY0Gi3216uEOihnd+f9Y6CJj0O5KzdIvNPrv3l0KLUdBGyiuzl7h3snhl6vGXNihvqrdiAXFEXdwJ0uwT6czI/Ws/DeApeh+V4WyaegqHWlr+Vt7daxNvxPMFWeDxShAOAirp8IwIMseVW68+m7Bm6FuTfOUgJlkRFRXxVeHHkhw33MQbnQAk6enYAjG742oICeBT/zN/jUwVGpH72LO28aYx6ajTgAG9UwQgiuEl5MDuw25xiqyElseKdVdHL+x35jltoU1j2DpJvwncTDKAN4IHzeNh9SwNU5E7UWRWoQZV78GtlYDRK7eeNsJx3krHh8N44uN96LxUKjUN1SRl9VB926vZ2Cq8ylMvf5LGTIpsLNJEGiWOEDbzKPbpULh/Rvvg4U+vQPb/XddjMuy7pv6hko7lnSYCrV5xrEuexJH8usv9S7GUKQjrCP5xninJrJ1BLgrlNpc3ZzgiosVD9jG/x2lCmmhbC8Rx2b7xUTjLjjx+f1eWattmSV9N3STQi9gPHsigTV0cmDczxQf/tiHQRyo9d0JbjDSv/vhlAqHwwZbZ4ZaRfKc996+hNbbCSnDdMqPUq92BY5+2g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGh5RGI5aDB3QjRKUWxLZ3VRQVgrT0pheHA4cWdPRHBWQVRrUGlGWFBYcnFH?=
 =?utf-8?B?RmlRSXpVRmtCc2NCWGFPa0FZYm93SzgxRXFWWU00cHNWZm9IV2ljeS84Y3l4?=
 =?utf-8?B?cUtieTgvcWFDeDYwcGdydWFjdWZCV2tyUnpuZzQyeEljdXpETWltdmhKcGJa?=
 =?utf-8?B?c2pQYnRNbVlORDJsajJCNHBHalIrSmltUUhFd3JpaW9GUldVeXZORnVseUcv?=
 =?utf-8?B?bVBSNWl6eE9jWEZqaTNQdDk3UHNXb2dBWEtxYmp6Ym92bHpUNmY3QmxJcFdi?=
 =?utf-8?B?aTA3SklhOXRHWVYwWGJkL0RrT3UyczVHb2FuQ3ZJYzZGYUZ3dnh4Z1JMeUhF?=
 =?utf-8?B?ejNmOUFOZ3MwckgrZWhXQWlBWlRMSHd4bWJJUXIxRFppQkhsbXpNdE5SVmEy?=
 =?utf-8?B?NmZrdFVjYzF0OGxTS0dHYVZXcyttU1NJY0YwVGZ2YTEyNVRJSlFmOGYwMnpH?=
 =?utf-8?B?TjcrUXEyZXJOYkdjZ09EbE5DOEtxS3kzbzZQUnRpZzNBK1d0Tkh6YUFiSjRp?=
 =?utf-8?B?SVBiNk9URzI3aUwwcTRVcy9EVHdMUGZYclpKdm5TQ29md2VPd1Y2emRpZnRr?=
 =?utf-8?B?Z1RCbEFRc1BqUkw1YnFXd0xxeEp4STIwN1QwYTVtRlhxKytIdW5lalBXeGpz?=
 =?utf-8?B?VVdBYWdMRG1NM1N4RmtLb2FQYW9mZ2hrTmRmVm5rTTloamZlVVcva29LUlJz?=
 =?utf-8?B?UUVGUkk3V1EwNzZMNmxxWFVHbitDanN0b2xsTzVzcVN3WGxKOVBIYnArazd6?=
 =?utf-8?B?Y1AxOFJ2ZDNUYlhzL3pvTG0rczRLM2k3UVFnTTJ6NlN2UDl0SkprOHpTS1gx?=
 =?utf-8?B?eVNvTVFYL2hUQVR0Q29xdEVCZ2RnK2RpRTJJcTFYYlFCZ0QyTVVaWjFZcytl?=
 =?utf-8?B?Q1Y2MERpcmJsTmtwczlIc0JtUmttclovUzNObi9vZi91Nm52emdRR0hmZ2s5?=
 =?utf-8?B?ZEhMQUVtdHN5MGNOOHIvemRMcUNKWUtyK0J4Z1oyUU9YOC84QU9hSElpenc1?=
 =?utf-8?B?SGtuNUhiVjYwWndLenRFQTlUcVdwVUdZLzBOMHBQd3ZzVGkwMlRmTUJVUHBR?=
 =?utf-8?B?VzhtUStiMTdIV3NKY2xOVHB2YWFaTjRlTEMyUFZEWGtlYnk1b2grMFB3Y3JE?=
 =?utf-8?B?ZHl0VTRBMjZyK3pMNGQzMk14RDlBcmlFUkRUVjVPRjRZUlNodll6R3NROG1B?=
 =?utf-8?B?akY4WXBOVEpPWE9Cb3VhQmg3Z3RZTnpXNDI3TmRLaW9jMnI0NXdwQ2ViZlUz?=
 =?utf-8?B?NmpHZENkdlVlaHVyOEZKMDNoT2JtK0RSUDJyUW5OK0E1Tm5kNGh1WEovd2xs?=
 =?utf-8?B?eFFPYXFBaVZCUWhWZVpmbG5seXRjN1EycE9XajVENmdaTFVBb1JOVHgvUG9Z?=
 =?utf-8?B?V3ZWUC9LOEdZeUtuaGlQbW9CVlZWL1VzSVVudlJQSkpDeENsbmUyK2duN1ZN?=
 =?utf-8?B?K1JBdTJjZ2tKQkxXNjNUNjg3Z3pGSHQxNTRDZFhzcTF5WWxaVzg2Ukw2UmY5?=
 =?utf-8?B?VGdFUHh3aEEzMXhXcnNJVE9FYWlOaHBobEdUMEw3aUcxR3JQVmZ2SEcrU2kw?=
 =?utf-8?B?Y0lOeHlUeFhTNzF5dlI4enlvaEYyZFBYd0lQeXFDbStyMUFOTVRoWU1Qd1VR?=
 =?utf-8?B?WURxM0R2M1lkMS9VVmg5YThtN0tQNTZwZExibERvZDd1YmZIQUpFYTlUcng2?=
 =?utf-8?B?ZWFDd1FWOStDdGhORFNSSEVJdnFGR1VQZEczVTJKcWNDdFJqYkVGNWRBbUVE?=
 =?utf-8?B?MllqUWR4WnU1Q2J6Nm00bEVDNjBUaDMyVThOQ3QzTVZwVTZFVXUzcnRsZGk2?=
 =?utf-8?B?Y3V6VWJyUnlKSXZRNXBlOFdGbC95akloM1hzUUV0aDl3RmRQT0hSOEZxTzRN?=
 =?utf-8?B?OGFYRTR4SFNhNWZCSmd0cURLRzlzNUtDaEVkZmlvSHREeGdZZzRDaU0ydUQr?=
 =?utf-8?B?VUZIdlZnMmFlZE9hcDZoTUk5cElNMUlIVTNSUW02Q2dpY01uQlQrbXRHNXRT?=
 =?utf-8?B?SnMzczJZU0p6KzNjbEN5OGphWnNyWmJFai9WRVdFdDBJQXJFT3BkcTFmMXhy?=
 =?utf-8?B?aXB1NlhlcnZJTkVETVlKazB1b0RqTXdtYXpmNktCbnVHRVpCTVVhOW5iNTFk?=
 =?utf-8?B?dmlxRUZ2UW15TjdYVFpIQUxJZXlJOHVtV1dXRGJNUEdCOWNCZGN0alAxdmp4?=
 =?utf-8?B?Y2lDcE9UM0xMbjNjcFdpYTZ0THFpbVl0THZSSVdhb0hQWHZJZzh0QmFuZWZ4?=
 =?utf-8?B?T0toam56R2V0Nk5MdUNBTVBEN2FFRUQvYlhFT3JibXl4VlhJOWlsTGpoMnp0?=
 =?utf-8?B?OW5WSUtlWG9BWXZ2dzdqT2s1Rys5RzdPbjBTTjY3bCtSaDkrMkllQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5683d9-b22e-407f-cfe3-08deb62da42d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:07:08.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUHTDxNaU2ACCcfMN1hfzVQt9YY0zk8BvtTG5UmkLw55OiNagTRH29WB516nKHhJ9nbWP2+OnN3IUfdLPZvVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8608
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 May 2026 05:07:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22982

On 08.05.26 07:44, Jan Kiszka wrote:
> On 07.05.26 17:49, Chris Paterson wrote:
>> Hello,
>>
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>>> Behalf Of Chris Paterson via lists.cip-project.org
>>> Sent: 07 May 2026 16:02
>>>
>>> Hi Jan,
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: 07 May 2026 15:58
>>>>
>>>> Hi Chris,
>>>>
>>>> is there something out of sync with this particular runner?
>>>
>>> Thank you for pointing this out.
>>> It looks like we need to upgrade the host.
>>> I'll put the offending qemu machines in maintenance until we've sorted it.
>>
>> Fixed now.
>> e.g. https://lava.ciplatform.org/scheduler/job/1439373
>>
> 
> Great, thanks for the quick reaction!
> 
>> Quick fix was to upgrade the docker version in the lava slave container:
>>
>> diff --git a/lava-slave/Dockerfile b/lava-slave/Dockerfile
>> index acf7bc2..eecd446 100644
>> --- a/lava-slave/Dockerfile
>> +++ b/lava-slave/Dockerfile
>> @@ -7,6 +7,18 @@ RUN apt-get update
>>  RUN DEBIAN_FRONTEND=noninteractive apt-get -y install telnet git ser2net patch lavacli libvirt-daemon-system-sysv
>>  RUN if [ $(uname -m) = amd64 -o $(uname -m) = x86_64 ];then apt-get -y install linux-image-amd64 ; fi
>>  
>> +# Install up-to-date Docker CLI
>> +RUN apt-get update && apt-get install -y ca-certificates curl gnupg && \
>> +    install -m 0755 -d /etc/apt/keyrings && \
>> +    curl -fsSL https://download.docker.com/linux/debian/gpg | \
>> +        gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
>> +    chmod a+r /etc/apt/keyrings/docker.gpg && \
>> +    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
>> +        https://download.docker.com/linux/debian \
>> +        $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
>> +        > /etc/apt/sources.list.d/docker.list && \
>> +    apt-get update && apt-get install -y docker-ce-cli
>> +
>>  # Packages for SW Update WG
>>  RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ovmf swtpm
>>
>>
>> Other labs may need to do the same.
>>
>> Proper fix is to upgrade the LAVA version (latest now uses Trixie), which we will do soon.
>>
> 
> Yeah, that would be good, indeed.
> 
> Jan
> 

The issue is back, currently breaking most test runs for cip-core, e.g.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14456368202

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

