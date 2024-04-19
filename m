Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D374C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 07:22:57 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web10.14702.1713511370123626368
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 00:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pGRbFWKH;
 spf=pass (domain: siemens.com, ip: 40.107.241.85, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxReJrZOpJGg5QIg9UJSqGoQGMgA0bV13xtaKmnVfDF1kMv5wEb1NTrJd5iBRkaHZVExiRu+ekipaOXC/+JiYdhroM4VAOtsXZq8tJf1DkxWnk7OqaWqjNLnKEAqXo7YLarzo4TT4Gnv/ytNdjUZQQpBAWWLpNx16YHpxX8TONUXrwDWbPQnJHl003EzKCju2Y5VjpjtqjuUF31FdeLCa5yfe2JSAmfkVBWjAvq9WLKaBx/1IDFKYbbu6yClICECJw5v30Qy/7C4DcAa6fPNhvQWDjkE+KGAc03LIH1TKye0eR4cRP8vbHEMkaBBudPn6HLD6HAG7p4f9r3ZO6bbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKvOh3Fthxs/INJSs9Iw33KnMBszRxqvhVOWySkSYqA=;
 b=kBqy8GgNoSCI7FAWcfLTVvg94tXr0FMSGPNNEPjN8E+U1bbors8g1QYURgQS0lwXvo+oT4XR/8xYx+zePcBCmTZXioq8aXDOcriTsAeCpB+WUNQMZ3n4fv382/EfroCXZba6YHhxlEvV80oZgu5NtOh+IMZ8Vemq7OQZomaNxsWMnYssQRbeEyZvySProqecy8xV1uiSDDwkEaJvJ1qXC54mvk3D7oHzAPI8rml4003flTxZOGa0e2nms7+T1T6GFWnAyGLwZe5Zns6W0g3pzyviTbr0CRxHdtnoQAgUv5vVXjPPp+EUlbpaUouS5skz2g35p2VwCBb67w1svt8CaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKvOh3Fthxs/INJSs9Iw33KnMBszRxqvhVOWySkSYqA=;
 b=pGRbFWKHHRmLxzz6QsqbiPu8yK0dUppOCD4AkWmXxVtwe93L6ELm54pSjsoWAwjdLe5A+GzCtlXYdONGkzA3nsIFE7nrRx37OTlDEPyf+XP+R+jx1I4fyKUa2TIbO3TUskclfK+/ONtfcnOVRsn2og3JB+w+6ZxOXP1PQn6UbpgkHmrGVxp8ZX2xPJv2MQ9RSEs3fiSvtmze+YDfayCXCiEkv4g4l61TSk1ZoosXxS3WAalSCVS5GULaqNjSHwNYHrD8FTOKHSlgCB54ldHqXAlCJqxGjxkXigFtAi3XfzZh6EOaBtPBRkHALgFzdTit+i3CaD6IhLl2YWEyFkF6Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM0PR10MB3604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 07:22:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Fri, 19 Apr 2024
 07:22:46 +0000
Message-ID: <5b0ae665-7634-4288-9986-18b1df5cb38c@siemens.com>
Date: Fri, 19 Apr 2024 09:22:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/1]
 recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
 debian/control
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, Rakesh Kumar <kumar.rakesh@siemens.com>,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
References: <20240418110353.584628-1-kumar.rakesh@siemens.com>
 <efa6a0f8-ac10-46c8-946e-8f41d6f874d8@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <efa6a0f8-ac10-46c8-946e-8f41d6f874d8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM0PR10MB3604:EE_
X-MS-Office365-Filtering-Correlation-Id: bedf8da0-3267-40c3-eadf-08dc604182c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/eJQKdcszrpasGh+9c/TtChS5jUlUGISOWc0TABIfnXNUK+jI9Qwj4eDG7LQTQsvCOFpF7tN3ZGRhu5JnT2emTGdI9eqy8tq7lnjCjP7DijkrKwTZSDrjEPJ+gMEC5JosD7PvcO1rIZR75nv9qUmIgbu8BJyHtxUo1OJ1WyopOvsp3hcpq61aeuSaakpU/3CuDN+xVIDk5VGTVVt1lLAAePSl3DSaKqdZcgQPwKL8IYPKCN8lrs8Q9OcHmcSfie7tdgDWPIT16Uk4ekI0DfkMNlLMKTl0bzhi1Xyc9eRpqD/3b0L4oJvrt9NXPw9EOI7yfEiuCEHhTHO8jmrYKSMLZ/d0JD4QO6sjPlDTZYwsfqRQKP+gdt8Es9A0Kw9B+l6oKYKQ5EKbLydZomYELqbLZDXKMDApKcdKng4tCB1RrvRfNrkQ6ssegsEt2Kty1mLn+RIIXVEN8+x1kvc1CuNQqIBEVyTUDquyLMlV0FO0ngyfDNwykg3coXvY0AOlLzOeVGGSz+geOYrnTVBLu7K7Aer8DacS3rfn+ObRcnfC46bC+KfJMNmS9OHveNQ4XFLivDP4GDTJanJMKRwLYoUeKEqDs9oBX41nISWdnwVVDc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEZKVXQ2Q0xXYWZSMXNDdHpzZHgzZEdWREVsZWZ2ZERoTy9EK3FrY1AwUXJH?=
 =?utf-8?B?bjVpL3ZEblBlck5SOTIzQ01WSzRpTWp6VkFkdENTcjFJMTRNUksxczRDZG1N?=
 =?utf-8?B?ckg5eWJnbCsydFVsSlB6aVB0bGVXbW9iOE81cFR3NmtXc3BDQmQ3a2tObWxj?=
 =?utf-8?B?aElHYWhIVUpOMzVIZThwVFZYWFptRE5lWXlnYkZOY1RuWUtWNGYweGdHeU55?=
 =?utf-8?B?UnpaMXd0ZGlObFRrSkVBMkNUdnRNVUFuUGNVb0VwVER5d1U2NnpLSXBMbWNR?=
 =?utf-8?B?MXd0by9aak5vNVRYWW1kR0pxWU9CK0puUzFoakxNaWxaZ2N6akVqRnIzeitx?=
 =?utf-8?B?aWl1S0FJbXpYT1dSb3BsSk1WUm9nbG9vNnkveVZLdFVmSFhqYWgzVGN5VVhi?=
 =?utf-8?B?aVVVS3I3RS9LTmRidnp6ODR2ejJYNDFVRllVNk9OdGszZW9rbEQ2c2REd0Fq?=
 =?utf-8?B?OUlxek9tU055V05LRjlkS0J4bUkwWElPcnFzN25RcUp0MzJGdkI5UXVjd0lw?=
 =?utf-8?B?eU8vd3pqNWZhOGxoc0RETDAyT3UyS0JDZlNVc1NwODhjbU1tTVUyb3NObng0?=
 =?utf-8?B?RGRBVEo1ZVdjU0hlUE5rdmRQWUlyT3RTYWswZUtsV21ML1F1WUJUT0krMUpJ?=
 =?utf-8?B?WEEzbGRyOUJvRElubnZjZHNlRWZPZFhjWXFUNlQ1VmZCajljZzVXaWxFZjIr?=
 =?utf-8?B?UVo0UDJDazFVMVR4eW9KY0VXMXVFbjd1UE8zeE52TTN4L3Q0NldVY0VrVDhh?=
 =?utf-8?B?NkVISnRsQ3E2MzRFekgyQU56QVdGdE9zM1pqTWJZUnpPYmVEMVVXUWVDMkEv?=
 =?utf-8?B?TVJrVFZlZWF6L2UyazZBcG5xemRPNmxFRTlVcGx3WkR0T1pSOGttZzBOSjlY?=
 =?utf-8?B?WXhmSHJEckJQQlVzQkZwS25ab0s2aEdqc2RsdkhYZGtKMWc3QUdvUTczVnJC?=
 =?utf-8?B?TVdTeld4RkRWK2w2YVFUWXhZdGpSczhoU2FVTGdBR2VibXlWRDNaNnFLL28v?=
 =?utf-8?B?ekRmRE83L3FVRm1ZRlgrejE2ejV2ZmZrWTRVVlZJc0dQeWxBVGtNZEJPeUNh?=
 =?utf-8?B?eGVQWFl5cHl5UUR5K3o5ZVNXMm1Dd1hZcFZCZ0cyVE5yNk9rL2ZWR0x6YVdt?=
 =?utf-8?B?L3hrRFBxR1R6MnpZMjNFazRaeGhTL0FrTG02MkVVUGRsRVpPNGcrT1V3NGV0?=
 =?utf-8?B?M3hySTZ1WTBuOXdkelR1R2pNVlJQcWg5aFRQRU9yd21GNjhzaW9IVmdBVEQ5?=
 =?utf-8?B?ZDNBdnkzMDZmTk9IejJBMHlqVmI2RFdqY1NzVW9MUGg1cTlodkVSSjk0UGtN?=
 =?utf-8?B?c0wwbFZqd3Q3dzEzN3NaYmxSdEtSd1Bqam5kYkNHOW5YR3RhVXoxYTdxZVhC?=
 =?utf-8?B?bnN5a2R3ZUxQUkZXTXhLU20vMnhRamEvN1hMeWsva2dlMDh5V1dYaEZ6SnR1?=
 =?utf-8?B?enlkcTVMa2liNFBucTR3WjFaMEdORDgyb0VKRHUzMVkvVjVJRXVLamlIUEJj?=
 =?utf-8?B?cFVwMExkNjNTMCtXcDhYV0g5TFIvMEZpSTlncGRiQUMyMkJwY1Mzalc1YkZ1?=
 =?utf-8?B?Qk5hL3hVRDFxQlBtQnRUZFlBUXhzeENxQ1gyaXp3MktXK1NXUitiQXp6dnBP?=
 =?utf-8?B?cU5XS0N2NnVlSUpKT2g4WGVuRHUzdUwxMXBtSVFZam80a0hySWg5TEh6dVZl?=
 =?utf-8?B?TjVNUGJRem5aczdiMFpnNml4VXh2aXE2NUJwU3lHcSt6YlEyY0xOU3puNWgz?=
 =?utf-8?B?c3pqWnI3eU9NdnlTRnZKckVYU3BBUUM3SC9TN0YxMy9rNkRvM0lpTlJCQUJJ?=
 =?utf-8?B?a3E4dk1ScFlnU0oxbjlGZkZLTFBrWTVncU9OcjEvSFBiNVc4MTdUK0xYTWo3?=
 =?utf-8?B?NndTcmMzRU0xQ1VyZC9IbFNYaUVQWnA0MkxzYVdFaDBIdVBJbjQyci9MSkw0?=
 =?utf-8?B?WmdnSUcraTg0eituZmFaSVh5ZGRKOC9HQXQ5V2lmZi9HeVkxdS9USCttVjVt?=
 =?utf-8?B?bGtPbFJ4bjJ6NWVSVnFRaTEyaCtkMDhwMkJhdlNOZXl1R0l4Q05JdW5vd29V?=
 =?utf-8?B?RHltVkk2dzFCWDBDcWhXUG9mUTlEUS9WZGtNK2hObzhzSHUzczk4Q004MVhV?=
 =?utf-8?B?eVRMTDdXRTRmR3FmaFhYa01la1VMWDZvSlRyczVMUTR5N1lncWgyOU1Xa2s3?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedf8da0-3267-40c3-eadf-08dc604182c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 07:22:46.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnyh+e0Ycr8hywEEMqZsU9JpjriL+wAj80v1MWLL8f/rCcLQdQ8sjYGHMTAfnV3/MKyQ6Rpby0qe+OBLqFWz/jj9MXT3njwtvzZm+641ark=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3604
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 07:22:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15584



On 4/18/24 10:27 PM, Jan Kiszka via lists.cip-project.org wrote:
> On 18.04.24 13:03, Rakesh Kumar wrote:
>> Previously, the debian/control file contained a duplicate Provides line,
>> which caused a build failure ad below
>> | DEBUG: Executing shell function do_dpkg_source
>> | dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/control at line 16:
>> | duplicate field Provides found
>>
>> Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
>> that the build process completes successfully.
>>
>> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
>> ---
>>   recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> index 76233b3..559d295 100644
>> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>> @@ -12,6 +12,7 @@
>>   inherit dpkg-raw
>>   
>>   PROVIDES += "secure-boot-secrets"
>> +DEBIAN_PROVIDES = "${PROVIDES}"
>>   
>>   SB_KEY ??= ""
>>   SB_CERT ??= ""
>> @@ -29,6 +30,3 @@ do_install() {
>>       install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
>>   }
>>   
>> -do_prepare_build:append() {
>> -    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
>> -}
> 
> Thanks for finding this. Can expand your patch to cover the other two
> cases we have in-tree as well?

This has no impact without updating ISAR first. NACK until then.
Quirin
> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15583): https://lists.cip-project.org/g/cip-dev/message/15583
> Mute This Topic: https://lists.cip-project.org/mt/105596040/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

