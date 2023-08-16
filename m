Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732FDC04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 13:59:49 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.40])
 by mx.groups.io with SMTP id smtpd.web11.161240.1692194383335910891
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 06:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TLEEi+vc;
 spf=pass (domain: siemens.com, ip: 40.107.6.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXJMnXkzV4/tMHPibukVIR+IvElJ8ZsbrpGptiehfxuaX52YJt30Gn6gKql/S0XavW3PNlGElIJolhYmQq1+o54W3MmukEZBA62efPniDMPhgP87JQ58fbddtGNRFU4fXOPE1Pz5qyYAAvHAQ1utqsa8UhgHUtkHF718/drVVE7cacO8O3jPIeuEByIob7yxAct2xzEBQVvrYgdvcSrhjrx0jiFLGjjYegWlealqWqMAD8hSgEKEZRLHFy6xulVSncryzfjbQs6kxI6ei0Lqcuj+p0cmYztm8nmsqVjycG8T7H/kHA8sbODuuDC3Z+932HpR2hQLbwhpYoQQ1V8zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk7wzcgk74V5H20ehBdH2AvDzS8ZC/ovK7g0q2eJNtk=;
 b=VuTRE4tMFU04tLV/PsR8D8WKw+V+u09TtwjaZUZHGI8ZYnykJhOj36vTRtMrt4OtLslzsmdt+t3s9SkOxWSMIzegHEFp9OI05rhrSjTSl31Thd2yvUJ+jYP1Gp9OJPezO/ZeFnOztgHTBG3GXJTSA0jpRP3+zeQwFuH4ogBRpOWIyDYdMWePG1f25n++/rW1VrjMiwDYTZLtKOZ5MrbgnF5gJEUUkEtwZD/UTQg2e79YObesgzbSnuAihebg0JrDR2vsWuLk/iWK9BF6FE3TlCFS1ikc2OYBLV0s7/QH7pt0d5OSY6/AnWpiw3e20V3tyGsT6pzYsyZEzmtaKcd35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk7wzcgk74V5H20ehBdH2AvDzS8ZC/ovK7g0q2eJNtk=;
 b=TLEEi+vc6vqip64ISql/ccJLTrg35kV43sI+vPiZlf1sb7awxmUkGpT7VFau+EGS1DlV24VeYgbPbFyjxeaj0jW0UhsvPef2LskXUW3+1H7zabLfo9NzMb3qNzy3FnTzscC2URi0EUC/LCzKnvrIvKbvBCebn9msAz8eRB7dx1+mqQzu+c+fItiiFMtaOhLn1QSRZbXojm0IsOwT/VNtT0p/fVQdAXPfeyPWm8UeWpnPPVjg6LfxGpgp95T5zIW/of38SGMWAk3ohE7kkCWOUFA85/XXuSbSVLBy1HwYAJp2fS8DMqSPLZOCsmuXvFHZV7jKQsblmB8O8tEUMIrY1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:516::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:59:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 13:59:38 +0000
Message-ID: <d9aa0410-78e0-4f60-b16a-ccaa3a8302e2@siemens.com>
Date: Wed, 16 Aug 2023 15:59:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
 <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
In-Reply-To: <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d00d24-a411-4bac-8278-08db9e61080a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZRAL0IdpTBYZgyZ7gn4BmyAe2cqRtKmKqhOe8emwZAaAvYOHK5YerZ7E3ze9YGgnq3gPjVBgFXGVeZ0sAhm2fM+UBOEtA+zRvdNlhvw1cLDM6sqFR3zL9CevZzmpzEheOzqaWONqH0qhIJhJ+3+bknxYp/ay7nGcN31EdXAekQWyM6kLrb1EYRVXggO9dUFeRCmmRr4JHiaXUD8UyJpW27Hy/WTyW4SJrc71Ir175oG0gnr032CAr6g8ScECqhXPy72NMDuTRNeHcYxI23Fu/3Q4HhYmVEIb8AqbW9UOJrd3AQwcA5QY/ldZ96eFU5/Gckute1iv73zK+BdXFa8oZb/HrsSCbUbKyyHQM/JtcudhiwJJbi+vKejhXqS2QYp18n8MOItNGS2QHsic+cFpsFJf70XnHhL10rLC/ktbWtMHNDfhDORhZvs9K6NK6HJdpIhV7L9jPTtMwuVz/02nJeJFQh1yrlyWeRJhiphyz10n8L9y8EZ+ByfsDSHljHhqbaX1jMmkxNaBbBtS3lLrj2NiWZqvGVJKurxs/xt7yoCwEDS5i5TpxgDe35n0pdxk47z8cLwsim+bQG4KeSi0aD34No33T2c9k+xIaAAHnReOM4UI5ISR6ULD5qDqQEuHHaMNcxlPpYWEDkl6T1Vqfg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vk8xWnhZNkJZeVhlYXZkeGtXME1mWTVPTXl6WHJpNUJNMm1YUkJYb3Jic2Rh?=
 =?utf-8?B?QW5WQmRCak9TMkpYSnhNUG1TZWg4Ui92S1IxTUx6Y0FxQTliMWhkRDVNVUYz?=
 =?utf-8?B?ZjJnVmxsZ1M5VVZoaW9UeitvVEFPT0FIS09mNnFmMmYyeTh0OG5rdTJST3NS?=
 =?utf-8?B?dzlvaktWam13RlhXTEh0OHVwaldkN0pTS0V2VTkwTjF1SjFpajNRNDJJSUh1?=
 =?utf-8?B?VUVaVnQ5VlR2ejd0NGVXSXBkSzBXY1NQRERIeEpxT1Zla0g1dUg5SjRWVHIv?=
 =?utf-8?B?MjNMUDVva08rd0hHV3FNNis4WUZQeDZZT1R0ZTI5RUc5eFBacFZTWHhzQ0xR?=
 =?utf-8?B?dkFZYjBidUlMYytBdUlwc0MyQ0NGUHV6MFVXeHV1YmR0cmNYaVBVRUtQVldH?=
 =?utf-8?B?cGRuUDI4ZzJmR0EyZ2MrMnIyR3hWMjBkWDhDUmlXL0ZqM0RCbDlHWEp3aGVU?=
 =?utf-8?B?UFVXOG94NnNSM2tBT01oaUt6dDl0d29za0NiM0pwQU4xRnhIMUM1cXlFNGFN?=
 =?utf-8?B?aXRyWVp0ZU5aR2tHYllPQk9hMC9zMGE1ZWlYVjBrNE9ldEQ1dDhmUm1qenlH?=
 =?utf-8?B?a29vWk1zcmoveDhwbGhyV1gySDd4NnhtbEljTUhGZ01GRnMxbWdZQUNRbk83?=
 =?utf-8?B?cUExYzdjbHoySnY4enI1RzFxQ2NFdmVTSURXaVVlWE1nb1Q1WS9nMmxXYzN5?=
 =?utf-8?B?NnlvN1lZbzkxSjdHMldGdEVNdEpWZUpDNWxNUVNqa3h6Z3dsY0JCSk5zZzFD?=
 =?utf-8?B?ZEQ1aDBjZTNlRTVNUE82emIvTnJBVnZVUkVadnZhUkZKZFpzRVpxbFdiVWNN?=
 =?utf-8?B?V1BGSkFiTnpQTVQyQzNVMEdqUWxsajErbU04STlMM3JMWUd4RFh3dTFneVhE?=
 =?utf-8?B?UHVIcGNBSllLYi9tSzhLbFE1WXNuZGthdmtzbzFNOVhzeG5XZTZXTXhnWFRV?=
 =?utf-8?B?VWJsZzBTYS9TU0tCcU1PQTdZbGx6NXY0WTlHVzdNVityZTBuTzE2UjVkMitD?=
 =?utf-8?B?cnZZNjBsZ3pZZnkzUUNNV3EzcWVtR3pleVYwUEY0dHBsK2NDS1g5NmUxZUR3?=
 =?utf-8?B?YTgrRS9NRTloNzVmR0Z1WmUzdDhlaEZ6b0gzT3RWak52THd1QVEvSVh1M3U0?=
 =?utf-8?B?ZFFlblRySnF6UUZ2d3pTa1p5V0JWNWlLYVZMa0JkdXRyNWpqejREQ3Y5QW5X?=
 =?utf-8?B?cW1WWEFJNXJGcHdzVlJrWHhkWjQ3OHZuNDJuMXA5ZzlHT2FNNzRGWWlXV096?=
 =?utf-8?B?OEttNytVL1psUkgxLzBrV3BTVy8vZEd0ZENSZytsNklOTmpvZlJPMjZpMGt2?=
 =?utf-8?B?N3J1Q2J2ZUpYTWRkekthakdMelFvV0F0MGJBM283dWlhYkwrZ3pZbmlXelZJ?=
 =?utf-8?B?WkdTQVdtY3daang3OWMvRjVUR2x5QThZSDdibVZIQVhPTTFrQlhUY3pkSjBF?=
 =?utf-8?B?YTZwT1VTUzljZHBqczdWME1TL3VodmJZYlhlR0VIQlNQaHRYeEU1a3pLbmxG?=
 =?utf-8?B?a20ydEw1VnF5Y2xNWFp0aFdEV2NDbDhZb3JBN0xML1dsYVphdEJCZDNQY0hj?=
 =?utf-8?B?V1NSeVdmOXo3Zk54QkhjcTJwbTRMdjVqYkQvR0ZkVUlnOE5hM2hjMnlHYmFQ?=
 =?utf-8?B?NmIwSlFrMXhkU1MzQngxVG9MNWEyU1hPSk1CZWtEeGZ0Z0svcURXbmRwOGl2?=
 =?utf-8?B?RGhmMmRCS3BaUTBPdjA1cWhRaVppWE1pUHl0bDlod3RveTZxQU5PWjdicCs2?=
 =?utf-8?B?aUdBRERxUzlQNDh1WUdQRjY0c2FkcUtUVzdBTWJpcERydWFCcTArNXFZRVc5?=
 =?utf-8?B?Yi9lU2IrWms0WUN2eWczUG5ZMHVmRElCY1lnNEtjOVhudjFZRXZsYnRmdDl0?=
 =?utf-8?B?SlVrRE11RU5aZ1dkaFJPRE1mdzczTTFaTjJYbW14a2tyWlU2OTBxNTgzUlNX?=
 =?utf-8?B?RjQ5TzAxUXZocmJ3Q25DU1cvMUg2eDZiVm4rYklLOGVXUmtudVJoWnVtRVJY?=
 =?utf-8?B?emxnaFpCdzJ6R2hoY1h6cUgzYWdsOGUzUlRVU3RTVXNJbFptM05wdS9EODJD?=
 =?utf-8?B?SUliSWxKdmNYWHUxakJoN3lELzJRZlNzc0FlUTVWblZUQm1DOGV2N3hXL2g0?=
 =?utf-8?B?Vkc2eWtZeFV3dkE3OUR6cHFEL0tlRm04V0U0eitUMTlwLzB1QVpqZnVneVoy?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d00d24-a411-4bac-8278-08db9e61080a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:59:38.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obnVp7wN66QajwpcKdQbfzjiDe6+0dUI9Xg5LTy0jTOrwRS66Ar1yVhOhzPmv2CvyUh5tDee7MI8jLPw8s7tJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 13:59:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12681

On 16.08.23 14:47, Jan Kiszka wrote:
> On 16.08.23 10:03, Arisu Tachibana wrote:
>> Force the creation of buster, bullseye and bookworm images
>> for KernelCI storage with GitLabCI
>> This images will be tested with the relative linux-cip 
>> kernel version
>> ```
>> buster with linux-4.19.y-cip
>> bullseye with kernel linux-5.10.y-cip
>> bookworm with kernel linux-6.1.y-cip
>> ```
>>
>> Signed-off-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
>> ---
>>  .gitlab-ci.yml | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 892ba92..183efcd 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -101,12 +101,39 @@ build:qemu-amd64-base:
>>      wic_targz: disable
>>      targz: enable
>>  
>> -build:qemu-amd64-base-kernelci:
>> +build:qemu-amd64-base-kernelci-buster:
>>    extends:
>>      - .build_base
>>    variables:
>>      target: qemu-amd64
>>      extension: kernelci
>> +    release: buster
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    targz: enable
>> +    deploy: disable
>> +    deploy_kernelci: enable
>> +
>> +build:qemu-amd64-base-kernelci-bullseye:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: qemu-amd64
>> +    extension: kernelci
>> +    release: bullseye
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    targz: enable
>> +    deploy: disable
>> +    deploy_kernelci: enable
>> +
>> +build:qemu-amd64-base-kernelci-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: qemu-amd64
>> +    release: bookworm
>> +    extension: kernelci
>>      use_rt: disable
>>      wic_targz: disable
>>      targz: enable
> 
> Happy to add that - just wondering if adding those two targets may allow
> dropping one or two others which are implicitly covered by this now. Did
> you check that as well?
> 

Oh, and why only amd64? There is no need for other archs in that
combination? Not that I'm keen on exploding our matrix further...

BTW, do we need the kernelci builds on every push, or should they be
updated at a different pace? When are they consumed?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


