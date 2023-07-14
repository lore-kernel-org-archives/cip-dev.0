Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC35AC001B0
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 07:14:31 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.65])
 by mx.groups.io with SMTP id smtpd.web11.13438.1689318865026857732
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 00:14:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RSO7g+KS;
 spf=pass (domain: siemens.com, ip: 40.107.22.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/rX9g1b9A1AwbG1uYjX6ge91qNVf16NXuX1vrZ/Vk1ZYY+HwQTCK254Q5fOy1jmlCz1ztI25vN7/lFkmP4dPH66NYrI6YJcx9zAWXuS5vZi+qHcOGxX4CzJVajtQmKjd0MHSb39RevFnCKmMevAt0oydcnxGa5UI2a8AZXiJNGiWJ5ayNn0HB6lRjDVCzoFH1KRPD0Z6f4SKiFXmnXy+epSblJk6L6SlAJyWKq68TNqiCiYCxdMr5dcgdUKJXdZjudpEcc+MXHSnIb2evVBFH9+3ATU5fzJLtAckTtA0v/zQEYcACqunlT17iomTYGEtSyZj25nSE0XKz4pzUaPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6kGEYhOYvWqtQVqWPajl7p84lqRPaY16C/9UX1qabo=;
 b=FTQ9TqoNweozQ/mhoez8IfmV22MrfXkqBUtk4rcn0eQCR2CWWKhDJByZSm0/Hh3D74PofQB1eHYvpY+dYMzZJHS9qOEBrWOa0EGM9Xr98xGZ4isKZg8OEG6Maf4ZyUofvTDCt7Ox6OlN3duBG6z4hCoFJSpPxNzvOBUdaiebLfdza9Y+KeHgDEfKGbxp5b5dDAPcWhSt5TWQNEnQkOIuJIQJ06A0GOB39XTcew1fyhENML5LxCQ2ZGLQwHwhOVUDi8l0s9/q6FQEf83OQE/hTFRa55O4Jw3b7k09+2glQxur5GBrPzl6zaQ22bUdNDCtwLYCJ/MCItk76kY3fgVmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6kGEYhOYvWqtQVqWPajl7p84lqRPaY16C/9UX1qabo=;
 b=RSO7g+KSpujfTuYnv79eHQgWkGSFpCa858l4AkKO9eDGSISqZWv2Nb3HSOKLZ+SuRUom/v1AamdP2ZGUECbdo7OvFA3i6RtdZ0VyMJqStw1N+417XoBsEBQM9AAVzLPgto7sNadZ7B+WVAk+c0nr6+4FKbdi1g2YbTDHZmOVgIxZBXQUY6UVaoSOb5FsD1kmaocBAYFSIYHV7vk/0N7ppOeVSXqZStEZ4CbJSH+pVJ6Eev3cCAK5PWsZcd1zRon4IW939f+DZ570l05qWGvniPuC/yrzG3L/2+pnJrJoX0OyqPfORdHIEzLlL53wyVzH/ySppgy+zBRsy0Y/dfkbYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB5803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 07:14:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 07:14:21 +0000
Message-ID: <52c24fed-92e0-a24c-515f-028b57202948@siemens.com>
Date: Fri, 14 Jul 2023 09:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 1/3] recipe-devtools: Add recipe to
 sign SWUpdate update binaries
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-2-Quirin.Gylstorff@siemens.com>
 <02bb2692-307c-b19f-8d47-69fbd59acbb8@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <02bb2692-307c-b19f-8d47-69fbd59acbb8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: efd2b485-3b46-429d-fa8b-08db8439f1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yAjbALBrZwzQkeP6+v6RYdWzITCmT2tlbdYVo6x1FsacLdmUzDA/VEXcXBvIuo3eZyTAPsAsnMnvIkILzlR6cZxFf0V+AW76rgvHRQHBJxtFD1cx4bRV1QIJJQhVrJBtUOi0oDBam8h7RsI2NG5jQnHPzWGBsbJOHF4C1dGRybKBfiqADXYTr4z6sg5WlkQbMVJy1ru98cGtzCDG3lflzZFKRgZaZ1XjFi14wyWu/x6cUgQt7cIb+JE7JksHPbubVXWoZhj5BpVHuB/tuwa2aGdGUhpk8Su/th8NixGS8t5cT01SJ5B3Oj96cr5jTBIqCXn20/VoGleh2kySp8vmdNOmk5OECsZFdiKFR/OEH5MvH3roWO2aXbXIjc12aBQBC5d43fgBl0zoHfdiQGzleCFfw2apXdVqJIPD2wAHwjheqO3n9ijimBhxDHtZ+uE+1KLIY3f3vjXZasjCgAm027cbE/9WCvHgEgrsWdIH/9RZrveidIkGiZgw194aPLhadZ2BdfUBgm7iiRImpNR7Bq0IDikiEABEZ8uD5DZou0apRmW1ZB6jSs9RBIGetxg4oMY9MMbRzw4tFlKAo9MU19zmnMSp2rl/cLed1fAHUw8CPfs9dPpNxICQuEkJS5Ee42BJlyH6cqR0n95kuxiPRg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(966005)(6512007)(6486002)(6666004)(83380400001)(186003)(2616005)(38100700002)(36756003)(86362001)(82960400001)(31696002)(26005)(6506007)(53546011)(66476007)(66946007)(66556008)(41300700001)(15650500001)(5660300002)(31686004)(316002)(8936002)(8676002)(2906002)(478600001)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUtEY3o0THZxN215dzZCTTlXN1hNZGFCN0hvRG1xV1dIR0l4UExPeGNzcHpD?=
 =?utf-8?B?V3Q3akF4cUFjVnY4aG4vc0JNYVR3QlFtNVZabHBxbjk3SmZrVzYvWFpiZFRq?=
 =?utf-8?B?eVNrL29jQ2lHWCs4MUxhbHpyUWxQLzdpU3FkOHJVdE5JVzJ1SFpsbjBJSjNp?=
 =?utf-8?B?UEdCZ1Noa1hFUWlmUWlGb3dybnhTNXBrTXFGTDVFUC9tdnVUaGVzTTR1ZmRD?=
 =?utf-8?B?dzFqaEk3UXBIU0F6TU1uRXpJanJ2cWxuQy9SUWZDNkYyZEZsTXFFZ0E3RUlB?=
 =?utf-8?B?c2YyQVlhQ2ZVYWJzcFBmRmJaUzdJdHdNYU5udXk3ZHl4cjNEeWJMLzRNUkht?=
 =?utf-8?B?OGY2dEk4WWNXTkp5NlIrK2c0Y1RERU5aWjlpSDB1VWtIOU1VVGwzQjFXRENB?=
 =?utf-8?B?QjFpYmZwZU5hNXhGa0hJUW9yWG1nMW1sQ1ZOT2VFUkZEL0hpOVdyTnpZaGdt?=
 =?utf-8?B?OWlsWERMbFpwcE5COXg2dlJrZ0E1RDE1OTltUnh6MG1NYzU3TWhPZzZFY0gx?=
 =?utf-8?B?L2tzMEJpWUEzTWp6M3RwODV2YklEdldIQXBNS0hDMXE2S0RvN0ZNZ2ZaWk8w?=
 =?utf-8?B?TDVRSW42YzRHOStuUEhxVHRmNmlYcVNUVkZXaXlKK1dvVFBaNVpQK2ovdTda?=
 =?utf-8?B?ZjBOU09pellhK1plb1dHMEFrS1AzQ1ZieHpzQnhtYjlFcFQyOFo5bm03dFhW?=
 =?utf-8?B?SmtOTDdtVHl3UlkwS08wWmRFWEozS2k2aVlBZ200dzVtSFAzeDAxcnJwdFh2?=
 =?utf-8?B?cU9BTG43Z3A1TkVjeThNeHAramc4TkhLcTU2VjM5OVJtRjFZY1JUV1RMSG5p?=
 =?utf-8?B?Q21LYmxORW5NWHNScDlKN2pObTl3Vi9SbmFGL09jTHlvUklnNnI4aTdzUEkx?=
 =?utf-8?B?Q0kyZVNsRmZjR3dPQnM2RVBqWDhuYzRyWmh4UXhBV3ltRHJxOE5iRnBQaDZL?=
 =?utf-8?B?aEduYmdDYjhhSys0MEZZd1dVbHBEK0FoY2MyT3N6YmdwdXV1ZmFsVTBsQWJI?=
 =?utf-8?B?bi9teWJRZitEaDRqZVQ4NzNZMEx2U1pFTnJrb0ZTMTV5cjluMUc3cS83L0xy?=
 =?utf-8?B?aE0raE5sNWdqTDhJTTF4MnBzZGJmK1ZlSFF2UjkyenZOcGhZT2RYeHdSeldG?=
 =?utf-8?B?SFJPV3pGNmZXcGUzSldzdTJ6eDNOZnhiRU5GQ0dSM1B4SkZ1aXRGY3dzNzFW?=
 =?utf-8?B?RVJudzFPZmxLQlBWd1NMc2NmMnUvTi9Pa3JreFF5aEFZdEY0VTRTTnhQVWRa?=
 =?utf-8?B?RjZhR1lzT2NOTVI0T1V5S1JhS3BIZytPTTlnRkp5REVQZnZVSWI4VVRXNXJQ?=
 =?utf-8?B?Q3FjWHY5S0hFSUFhVXYwd3FzdjhLd2tUa1g2STFkQW53SWFUTXBDUWJKZEJN?=
 =?utf-8?B?SlF5NjAxejkwT3pRV0Q1cU1mSk5Fb2ttZXFtWitlSHIxRE5vNC81S3BqL0Ro?=
 =?utf-8?B?SXhQZm1tb0cxVC94c2Z2SEpSMEN0Lyt4MzdMQTdmcWQzOSs3R3h6YXNtdmRG?=
 =?utf-8?B?aDBvZjFqbWJ0b3JpR280YnhFaDl1RmJ1enhLbU96aFdkNTNBYS9DNDdQd0J1?=
 =?utf-8?B?U1hSeUdiK3JSbjNubWF5K0VjUTNGdzF4Z0JVQmY2SVZsNm12OG9TMXFMYkJ5?=
 =?utf-8?B?ZmN2NTdRNXdxUERYVmQ4eVVsWTdPbUUyT2d0Y3pBanJBY1VHZDZGdWw5NHc2?=
 =?utf-8?B?V25kbmFva3BmOTVNV2Q0KytWZlZMdFoyU21lVitxUjNsOWlLM1pmLzNSS2Jx?=
 =?utf-8?B?NURtam9kcEQ4WjN6bHNuaDhXaitDKzNHWi9YVWJGS1oxSmN1STdMd3pvMWFl?=
 =?utf-8?B?UWpJUE1tTHlWU1ZzaW5nKzQ5NWM5d2IxR0NERkk0YUdvRG1xZUU4NXlrankx?=
 =?utf-8?B?cGJNSzRoeHFQZWlzVi9wZXM4YVVhdy9VTlJmSDRzMnY3VWM5Tkg0YnBWWDBK?=
 =?utf-8?B?ZWloaVh6ZVJuazlQMXZFN0h4NU8zSWl3YThobTMxVUZDQ3dYTloyOXhndWdm?=
 =?utf-8?B?VktpVHBOZHZjMmkyVWMxZUp5Zk9xS3JUSDg2cW5TYkIzY2JuVnNWakMrZVBF?=
 =?utf-8?B?dHZYTVI3V2NxNGJjK2s3cjkyeXlFT0NPZ0JFQXdBRGE1VUNoS1huRU5IRXFy?=
 =?utf-8?B?UjRHNzJ2Mmc3bWlralFGYlFjSXdxNkxhRy84Y2NhQXpCSHNJbjVINGhKcitY?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd2b485-3b46-429d-fa8b-08db8439f1fc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:14:21.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcDZIMHSDLK28b3P0QvFe2QSkl+Pfqt9zHTjA8nKdeipZH696UAioyy98iymB5NYO2l42Ev26ip5qwIlKUcGldVqvEe4xi7Rda4HjCGLA0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5803
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 07:14:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12342



On 7/13/23 19:03, Jan Kiszka wrote:
> On 13.07.23 18:40, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This adds the necessary recipes to provide a snakeoil for testing
>> sign updates and a recipe to for offical certificates.
> 
> Several typos / wrong words here.
>
Will fix.

>>
>> The certificates creation can be found at [1].
>>
>> [1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../files/cip-swupdate-snakeoil.cert.pem      | 30 +++++++++++
>>   .../files/cip-swupdate-snakeoil.key.pem       | 52 +++++++++++++++++++
> 
> Are these different from the Debian snakeoil keys? I suspose they are
> for the reasons you mentioned offlist. Please document them in the
> commit message.

I tested it with the Debian snakeoil keys modified by isar-cip-core and 
it works. The question was more should we copy the keys into this recipe 
or do we make a dependency chain to secure-boot secrets.


> 
>>   .../swupdate-certificates-key-snakeoil_0.1.bb | 17 ++++++
>>   .../swupdate-certificates-key.inc             | 31 +++++++++++
>>   .../swupdate-certificates-key_0.1.bb          | 15 ++++++
>>   .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++
>>   .../swupdate-certificates.inc                 | 31 +++++++++++
>>   .../swupdate-certificates_0.1.bb              | 14 +++++
>>   8 files changed, 206 insertions(+)
>>   create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
>>   create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>>   create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>>
>> diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
>> new file mode 100644
>> index 0000000..a44cb7d
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
>> @@ -0,0 +1,30 @@
>> +-----BEGIN CERTIFICATE-----
>> +MIIFKzCCAxOgAwIBAgIUEA0euuQB7ulZBzoFaG+/Fps82oEwDQYJKoZIhvcNAQEL
>> +BQAwJTESMBAGA1UECgwJU1dVcGRhdGUgMQ8wDQYDVQQDDAZ0YXJnZXQwHhcNMjMw
>> +NjIzMDk1NDA4WhcNMjMwNzIzMDk1NDA4WjAlMRIwEAYDVQQKDAlTV1VwZGF0ZSAx
>> +DzANBgNVBAMMBnRhcmdldDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
>> +ALO14EDb7Q/hXCJZbrl/UD2RytUb8Phh49iPpIOryJKqDEyGNhc03XzpkB5qMYEt
>> +vMN+UXRTLFvBIfrtukLzrpEm5jTPaSAciKD+nIGqNFbPXWl+KIy2lMTEqD9Se7lQ
>> +4u4fupZQp4adlsdjya0i9u9fnNbK25jCrPjQHf698eS1VR0YpXOqAqB9VFLeLdlj
>> +BCCmVBkhMTF/z7CvF7XsL7rqBG8F1yTg9qKTf/2C9Odc9sCtjy0wGt8NBSV2Cua3
>> +ifPNQtYdxPLR9ohyariMEsS3s0WVclUvctD6SwCmP0RNvwmKDyzlWerRTSvODw+8
>> ++laD0vI2KIkgegzDiJGBF0DrfBrePqCHLeZztQHpHfTkcSAEP4hgg4ev2p5XV7lC
>> +1ed9UTHjhW+mmKJuJODgfsS7sQs8CqRGHYj95RrK14CG5PHebRWpSH3KcmROpsSl
>> +fUXQTSqth01welrL9/OEpO0vRlnL0FNrhjQFtgIR3djgxosoRuOL43g/ep1CtIwc
>> +ypFDemhgMKoUzc7KnQvGpG5FeqUSqqAlqclAKEfFNs4pvpc5mz3LUwdNkyIGkgqL
>> +Xuhnf1OkMDtMlZ5wvi+CTqYMX2KqXU8yz2Csf9uN54ojIGbWN73wCZA5JH7R8FqN
>> +PoKJ8csQTayQK5XBYP7XQV1CgnAJDxa/pEnMf4zLotG/AgMBAAGjUzBRMB0GA1Ud
>> +DgQWBBR2lBlS17x7xqB2kaLwEg1lJXpoLDAfBgNVHSMEGDAWgBR2lBlS17x7xqB2
>> +kaLwEg1lJXpoLDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4ICAQCe
>> +WK2TcfszS5EPeO4K6o7Zsr6tNkyAfP0oHm4gqAOfverfITctws/SIOdwLI79ljMq
>> +vUuSEzWRnx16TfzqBlnFNFEUPBknnk/KeHCXgz4XdyyLdS8cga1lCHc+yRVIcq53
>> +Z9KaLjbg/OmyJwVTehlJGnDF4QCOIzMO4Ha+O6Eyxu3ARp/x2QrzsfQ1U3KtMhAy
>> +NcBG/mupj8mwg3cfo10MmzzN4ioQUCIf5M6eg/8iDITgA51XqFpjf2fX1xusSBBe
>> +zuoy4Rz+Df1rGsUabAd7jKVXghS1+AE22ZPy6bnmV810ONb1H8MExFbGgdulYhmo
>> +zoH6H7h6LtKP0xVOZ6H87X4Hoi7YitQqCl+oaHUE2GzA97fm+rNXe84ekJvjUiEz
>> +Js3q1wXaegMr4LFmu9MPBSycJw54KtLfg2U0tIW6SD7dFlvD2f/qo7RtyEiE/Wfu
>> +Cm8ZvMUr+OuNAvQL/Ig08JgUKisTK3ARHFxMu9sEMsWoB7bTGvyiZ9mS/G2VIet4
>> +1pucvi89d9qXeZZ8PByHOEo0c7cu8lCmtIZoh0rdV3t8mxOZA1kFwYK2xahA6DT3
>> +J2me41iKb9l2aCbGBbUKiesu3CRLpPG8Ic8X5PPkbRlX5/Zza21AbM8jxX14ZAL8
>> +mkgMhzaLWIGo8ixvA8i7Fm/JunrIimDZaRjJrKuoMg==
>> +-----END CERTIFICATE-----
>> diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
>> new file mode 100644
>> index 0000000..5dd3d3b
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
>> @@ -0,0 +1,52 @@
>> +-----BEGIN PRIVATE KEY-----
>> +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
>> +nFtyUBqMFy+r+QlyRfQbhfXxs7cW1/M=
>> +-----END PRIVATE KEY-----
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>> new file mode 100644
>> index 0000000..fa2ce23
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> 
> Did you change your name? Or should I now use your email address? ;)
Oops will fix in v2.

> 
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
>> +
>> +require swupdate-certificates-key.inc
>> +
>> +SWU_SIGN_KEY = "cip-swupdate-snakeoil.key.pem"
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-key"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> new file mode 100644
>> index 0000000..3fafce0
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> @@ -0,0 +1,31 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +PROVIDES += "swupdate-certificates-key"
>> +
>> +SWU_SIGN_KEY ??= ""
>> +
>> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
>> +
>> +do_install() {
>> +    if [ -z ${SWU_SIGN_KEY} ] ]; then
>> +        bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>> +    fi
>> +    TARGET=${D}/usr/share/swupdate-signing/
>> +    install -d -m 0700 ${TARGET}
>> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>> +}
>> +
>> +do_prepare_build:append() {
>> +    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
>> +}
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>> new file mode 100644
>> index 0000000..45864fa
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>> @@ -0,0 +1,15 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +DEBIAN_DEPENDS += "swupdate-certificates"
>> +
>> +require swupdate-certificates-key.inc
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>> new file mode 100644
>> index 0000000..4e45b6b
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>> @@ -0,0 +1,16 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require swupdate-certificates.inc
>> +
>> +SWU_SIGN_CERT = "cip-swupdate-snakeoil.cert.pem"
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates"
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> new file mode 100644
>> index 0000000..92f9715
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> @@ -0,0 +1,31 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +PROVIDES += "swupdate-certificates"
>> +
>> +SWU_SIGN_CERT ??= ""
>> +
>> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
>> +
>> +do_install() {
>> +    if [ -z ${SWU_SIGN_CERT} ] ]; then
>> +        bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
>> +    fi
>> +    TARGET=${D}/usr/share/swupdate-signing/
>> +    install -d -m 0700 ${TARGET}
>> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
>> +}
>> +
>> +do_prepare_build:append() {
>> +    echo "Provides: swupdate-certificates" >> ${S}/debian/control
>> +}
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>> new file mode 100644
>> index 0000000..41d07a5
>> --- /dev/null
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
>> @@ -0,0 +1,14 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require swupdate-certificates.inc
>> +
>> +DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"
> 
> Jan
> 

