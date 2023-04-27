Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2AC77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 15:59:33 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web11.24784.1682611172686341096
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Apr 2023 08:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pZoeK1b+;
 spf=pass (domain: siemens.com, ip: 40.107.6.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS37hmgc2vPLCM4OYALXI6gMOo8Z3uJOIYlJVnEO2PzjTKJwriQEYMbnSB/DyJCkhypO/uZdQGKVj7RWsAmflEuLalsOBkVoRi37JRg0a4Werheq4K442feSTjYcZlJehaEapzKC+3O84rCr5qjd3fL9A++lY28bRJsDjHWG012k3ZvrFbBj46uuf3USndKFJ6V5A8KiVSEG8XezmsPVwVZ07DcZWHvbPTdY4vo5RzUrN/DTWSPiFcqbN35XyLSSDyH85odrs0l28wYEjGlSy8OeaRjn+hzmUhXGcBj2B6TVlE7NmbQDK9OBp0PEUTNMD3XuUHg3dYCo3eEjVBFibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po6RXIt8AorRNBVnxL2IMSt0DsOPZDNRXn0AOh0iDRs=;
 b=EaJAtNsUsRG00QmEp2d0CBu49hforU+qWa/UGPFTds9CeWM6+I7yMwdlNf+PXsTs/fJFAGxFkAsyDfKAfSV0oBqMBp1h+squg+rwt3HgjzRu6YxSMA4uXhe1DqPMvuE0QqNPDxmmkuHvMFK+mqmbe2vuk0lB88RoQkka2kYujB4KdAzudMZudrgRbAYWTV+7G4RmOLwDzlgZ9jcO6oYZ/T9aqrjKC6KkW8SqDHmpxJU61mWOQkI6EFMuop8UXNkY2B8MQaYEiHWP+ZgL1h6Inj9sIJSLeG1ljTO1YNDJHfRN6NCfmKJoQYZ6Zool/RW0BDC6WPnz8peERbrEpH3Wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po6RXIt8AorRNBVnxL2IMSt0DsOPZDNRXn0AOh0iDRs=;
 b=pZoeK1b+gj9+orXpgXVKcvLOq7QymY4Qy3bhBihBOE0K6ekDiYwH0931E7p0genXy+hGiBSQ/qxFJCV31aCnHLl/A0HT2BFNztymmkM27ndCaY37vPvJzeHvV+jpLgZ+230bpFPuAa8sHQV/O1XtPkbLlOV5PccNrwtPIM8BfWgwepsomDAxl/ohUu3aA5tj1PmRw3SGsMx+f9whp9KOqXE7/S/9atI/IjF/Xes2/nAhBzETNwrnsL2/atwzbQ/SWUvT925Bv9sufiC56KGATZDwHAdIWPfeq9SKC+G51rQmkgVicwIi4erLNpWX6FRxs3ggoYdg3QNjFL+rPsVAxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7826.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:59:30 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 15:59:30 +0000
Message-ID: <7eee5125-23bb-f387-9c5e-42587ada7237@siemens.com>
Date: Thu, 27 Apr 2023 17:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 3/6] linux: Add missing kernel
 option for LUKS2 encrpyted partitions on buster
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
 <20230425104835.655946-4-Quirin.Gylstorff@siemens.com>
 <dbb31b57-7d5c-a64e-2f54-965c048a7acc@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <dbb31b57-7d5c-a64e-2f54-965c048a7acc@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: bd126d27-d8e8-4f6f-fa6a-08db47386263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DOmNnRTdiPZ71v8hVE8PH5iVGpFd8+251CtiTqYAvFvITtJDhbuxoCCXa95NwURcFlSMqXCll+Myr5+6C9Cq2fd9VHvfwewG9X11Tvs+w1VV79ct4gIE+Jo33TDrE7SsywrXjJ64EgySeCWKPzAn8dpwe5U7PpZ62QqwX4kok+b+QIE9C4EOCU8+Dj9JbnlK8FBjDU1WLi9Bq7GqeqZT2XxIAAdk0r43Ii7l5o20NuroDRoKpndeLaDwoPojeafiMnhNz3rxpgmlYkDzjTEDsKjQ22fhNgPui50zgnd1AaagWd/RIGbQOmyw40Qbi5FpQtfSS8V/N6aSYYdmTF+ao5QceJf6AU+3o063Bge4KquoO8Quv41Q7crrhLYmxzxHWBIGNNSyiCE9tAZC1BkdkBl5FcWzP3fyknQjhG19HyWcZpAeXKKojbZAw6vBf08CCvuchFew80eb2UGpSsmUFFPQ1WztOFH9etpatf6ZIEdZaZJKxJx3xX4InjaPBl14Rb+cfm1NI+3wTIQJYiVoDxtDKusi+h1SCQWHr0foQdwNHfHfYj+6l5m4A4oIOtJfCrm7FMSSxAhsoCEXVv6D91itZYjhhro9KhGcWOEfR4OQd8OEVyVgJlc+yYuFXSp5TffmhL9dWK9/8P/9KgwHKw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6506007)(478600001)(53546011)(6512007)(31686004)(26005)(6486002)(186003)(2616005)(6666004)(36756003)(316002)(66946007)(66476007)(66556008)(8936002)(86362001)(41300700001)(8676002)(5660300002)(82960400001)(38100700002)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yi95UDRxbjkrQ1dVUXg0cmI2WUxYeTdqU0QwakovN1B0ZXpYbllCdG5tV01D?=
 =?utf-8?B?Y09zV2NuZHBieTlWN0xYR0dObGR2TURDZzVqUUd3cVM1ODY3OXhpM2RrOHdM?=
 =?utf-8?B?QU52SzhwaFhvWkJxMkY2K0tiWG5mS3gyNWJsUVh5Zkh3SGFRNUltSHdsamRV?=
 =?utf-8?B?TEpwd1ZDVU9UREZ4WnJBRjlPMXU4aGdHQWpqQkZ2SFVPdUxpUnZIQk5rczVZ?=
 =?utf-8?B?R0FTaFc3TGFHZjBSRjZ5ZnFvR0I5MXZvZUZaVlViVWdjQURKMkZRN1NyWER4?=
 =?utf-8?B?aWxJYitmdDNLWjBjVUR5RWp1a3JTQVJXb2JzQjE1ZzRXNjhTNnpvdDUvSFF3?=
 =?utf-8?B?MnJzWktpNmVRa05GbkVaamlvTjQvYVVWZndacExMNGZhYTJDU1VOU05yYVZj?=
 =?utf-8?B?dm51THJWcmthRnFLbCtjdkFrLzQxV3M1MmxZWG9odHVlSVlmdDdndXZ4OCtX?=
 =?utf-8?B?WkdoRGl3OGhoZHVCYVV1SjhTYm84Nkg2YTJyUWVOUEdOQ2Fkb21GN2w0S010?=
 =?utf-8?B?V2ZGTk9FTU5XMDRBWUwyUlp6emxSQlI2enJja1NlYjZoL2lsbnBVVzFCdHRU?=
 =?utf-8?B?MHhUMDN6Mm1PMkE3M29nc0xKdU5yVDZrQmM2dmNZaHB1RHl2ellKWFhrZ2lV?=
 =?utf-8?B?RGNkSnRuMzRpWW11b0FuRUxoRGNzUlp5d2U0RlNGcWJGeFNNUDlIalFJYUly?=
 =?utf-8?B?dk9RdG1XS016RHljd3dkVXZ2eGFpTHFaTEZFc2ZaTmRpZ01yUjJNU29TM3Mr?=
 =?utf-8?B?c09kQThqa0VjbUtmQlArSzE1WnV1R1dnUzBlS01EaCtaQXF4ckxRemtrcTlF?=
 =?utf-8?B?SkVaRVoxSVNUakJNYlNZKzIvUUlPZWZISU55NVRYOXd6cHZ4U1JlR2FRWk50?=
 =?utf-8?B?VTZaeEpZL0VoOE80TEVyUDJMS2NXNzlYbnN5VWRVNmd4Z1NvWk0xck5KZm01?=
 =?utf-8?B?ZVM5NVRxVXEwZ0NlNldqUmtQdk15Y2ltb1R1ZDRtbXg4UlcxQW5QZEJWcUUy?=
 =?utf-8?B?R1hJVUpNYThGd2M1ZHpzWUFsS1R6RmJzTHgzUDZiTkFsQnd0VDNQVk15cXZB?=
 =?utf-8?B?T3U4K0Y0bmVMQWwvUG05MnJmZG0xU1FDam1zb1pSemY4VlViZjNzbEtERTRP?=
 =?utf-8?B?Q0txSXhpcFhCd1FZRmZzYmV0bk5PemtrbEhvRkFhbTBVT0hqM2d2SUpKYUZS?=
 =?utf-8?B?Y1YvcDNBZ1NhZlFqeTVxV2hQMlJzL1U0UFhaUyt4SmJQTjR4T2owSVFDRm0w?=
 =?utf-8?B?cUJzaUxBUTVLMmFpSzA3NGcyK0NwZGQ5L1BUNnBvcEZZNlhCTEI1bkVGeDJk?=
 =?utf-8?B?SmFJU1A5SnpSa2IvNjJkdVZNcm9rVUo5R1JRdUJ4czZVNkk0M2hxZ0FnU1pO?=
 =?utf-8?B?emNHb2pvMnVzSmVtNkdlVDFhWmFVYUI4ZnlpQUhIRGZZUVdEVFNCMzZpYncw?=
 =?utf-8?B?WWsxNVoydk1MbU5yZnhpVjZ5SU1aa3JsQS8zRTVrSENlQ3ZJRkFlM292NnYv?=
 =?utf-8?B?Ym1WNFYzYmswUGRsVHhHYkJreHBidGxRZWJTU2VNTmV5SjZRQU9vT2pLVWU2?=
 =?utf-8?B?N3MrNXFwdlY5b3BjRzVhVGU4MHRHSFo5NWsybDVkdCtSVEZEQVZSK1dkOXdR?=
 =?utf-8?B?b2lGcVlzc0ZONEd5YlZDdXF2dnAwWTc1ZDdabEJBQWNLOHFVOGljQmppdWhs?=
 =?utf-8?B?ZjkrUG5oU3k0NjJ4cWp1VmtKNVFNWW00M0tYVVk5OWg1cFpSb2J4UlY2Wi8y?=
 =?utf-8?B?Z2ZOckFwSjZJV1VmWmk2Q0NFcU9mc3ZhOE4ybE8vellvUklIWDY0UVc4Y1lE?=
 =?utf-8?B?dkVlWDdwMTRyQ08yb1JReXRhU3FSZTJVMnIvNnNkdVZYRk1BdXIxT0owQlhL?=
 =?utf-8?B?NzJUREpqTUVxWStPZVhwOHFJR003UU5qejQ1SlZlR3lFNytETmNzNm81c2N6?=
 =?utf-8?B?RXN4T2RxYVNncm5XWHlzeHZ0MXFhZU55dWpIOG5RSHRob2dtSnBRL2R5ZHAx?=
 =?utf-8?B?aGl1YXZvNS9PcE5PZC85a3h1Q0JoWTIvLzRpdytHOFNmUWxmL0MybmZyaExJ?=
 =?utf-8?B?WVk0Uk42SWRrMHRzcFFCZURJTXdoczBFdWNxYkhpUWpPZTlJYVk5cEhNUHl4?=
 =?utf-8?B?RFE1ckxENFQzVzJHNEI2Sm1WYTVGRkxNVWZ1RUVGa25QcEI2Q1VYZ3dmcFV0?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd126d27-d8e8-4f6f-fa6a-08db47386263
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:59:29.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvuQvaCFho1c2Xt5Ownrvws8s/8s0KCwZFhbzaH52K/Jv3flTPc5BSB93cojvXxMOmXidLhKKx+3o58qxyQ6eadTrFKy7WQuHA+jlzLHUgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7826
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 15:59:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11369



On 4/26/23 14:00, Jan Kiszka wrote:
> On 25.04.23 12:48, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> cryptsetup uses the user api of `CONFIG_CRYPTO_USER_API_SKCIPHER`
>> to generate the keys.
>>
> 
> But why does this only affect buster?
> 
> Jan

cryptsetup 2.1(used by Debian Buster) requires `algif_skcipher` to 
generate a cipher. cryptsetup 2.3(used by Debian bullseye) and later 
does not require the kernel interface as can use openssl as the backend 
for the cipher.

I can  add the option `CONFIG_CRYPTO_USER_API_SKCIPHER` to the 
cip-kernel-config as it is necessary to run the cryptsetup benchmarks.

Quirin

> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-kernel/linux/files/buster-crypt.cfg | 2 ++
>>   recipes-kernel/linux/linux-cip-common.inc   | 1 +
>>   2 files changed, 3 insertions(+)
>>   create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg
>>
>> diff --git a/recipes-kernel/linux/files/buster-crypt.cfg b/recipes-kernel/linux/files/buster-crypt.cfg
>> new file mode 100644
>> index 0000000..e3ca518
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/buster-crypt.cfg
>> @@ -0,0 +1,2 @@
>> +CONFIG_CRYPTO_USER_API_SKCIPHER=y
>> +
>> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
>> index 2d878a1..762a86b 100644
>> --- a/recipes-kernel/linux/linux-cip-common.inc
>> +++ b/recipes-kernel/linux/linux-cip-common.inc
>> @@ -24,5 +24,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>>       }"
>>   
>>   SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
>> +SRC_URI:append:encrypt-partitions:buster = " file://buster-crypt.cfg"
>>   
>>   S = "${WORKDIR}/linux-cip-${PV}"
> 

