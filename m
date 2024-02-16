Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6AC48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 08:09:28 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.80])
 by mx.groups.io with SMTP id smtpd.web11.14406.1708070956563913586
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 00:09:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h4xt33ia;
 spf=pass (domain: siemens.com, ip: 40.107.7.80, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTVlS1i051TcMfCCGwe6OFuZMJr21t51KWYlXDOSUjrAdY6qipKQ2RLYRIRNMVvApJPo9mTNgckSW4pk9RcKFn7jTyPdCps9J3meinOpIxHsCr1Rn3t1BG1DHSZw/HtChzLvqy7pviw0xwM5reWYCFBvZqRVuvXbyuTk3ZzDPH9SsyqSvdFCNRGepc3sn+JM/IFwZTCS77yI9HZp+X3jyG8Xd3g9hp9TSsGI7rksOWZlNUXpoWUsgOzeLhf7LsSchn/6fW4RJUnBQAh/TFmhERbCs8ACTwvkJ8NAeYx0pJaZ/CGMmwcl1s3QonKL/0lzQSQ3mlX1Ai1zafSPa/WWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or30HyUEppuqIoJFkqfuXfQE5kyp5iI5xl/cjHlwKO0=;
 b=gS0lPgjl80FfQp+n1C1hTBwmPDkuO+n7xh0TsTC44oxYOE6xZjLuuU0Rtg5GsJ8MCphMvq2Pp1fC6Q2Kc3bh1umcu/Nc1Bt8boAVx22pgfnnr3ylnGzB7JpQ+VriU8/1HpHAHd3GN1dSKkeppzQdCLfxZlGEFKtB6ADELtpFagcI0QYwbWtXRgTsRzzAPTo/oluBWgIXcYUl8XBZRdVsXWArXYrRKQ6qpNYiDtLLa2Tbbews3iNA5DpGdD4QR7KnLfxy6bJpsmdEkRYExD7an4aw5z6tuaXlUX6Np+3z4hW/1RQnA4jY1M+ZysOB3dbENam7XeGP8xqfCFWRXQN/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or30HyUEppuqIoJFkqfuXfQE5kyp5iI5xl/cjHlwKO0=;
 b=h4xt33iaskQXwIlE49cmfCU/jwn78kPdnoj6+oBdHnv/8sFK4xzZNpO6Djf2YbXvZ5QKGZuK2x/OAPcriWD9Gr3MUY9wKUAbtX4y9lmFj0BqC+yzdjjWHAy+u8mVYSM4MR30/OVmZiItOh/EsNEqgRZnA52Bj7n9suEH3w9IimXW4gtPXPZNzbNy8+tMD3awky7rlbdezgWeLyCvVC4sAYrooBN1/4xEgiCFX7wGyeW3cPGv7ja1YUB91nMseS6cYYut+2T+dYmtX3ZTtQA0LyYdF+FeNBT10WlaQb+rr6TGU4SNEEdJPgCkqeGgTfB2r8fhS3jmGz8K7sWG6ApD2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB7992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 08:09:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 08:09:12 +0000
Message-ID: <1dd552d8-c8fe-4cb4-b45c-9f2cc8b16aac@siemens.com>
Date: Fri, 16 Feb 2024 09:08:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/3] add SWUpdate 2022.12
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
 <20240215155350.434472-3-Quirin.Gylstorff@siemens.com>
 <6148d08a-69ac-4b1d-aa87-0301786aab1a@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <6148d08a-69ac-4b1d-aa87-0301786aab1a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c633ba-c7bc-462d-2b7c-08dc2ec68f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lh0kLJ72JY26wEj1heDsGMOT9tn+4DS/dHcqnvaxeQuvnssMWAUZd3jGyGP6CgC7qbXKq7mHCzPBllRk1W/YHt/eDVid813/rbcpq+anoYR+uZx/qQvkryYMztDWMWSwfFe1K5a06kUsJ2ZQ8mVdDCOaSVW6mQqwwts+KzERp2kxxAP/dMOsNPO9wUOTxn4hNhuUbkzCxjfgNDWBZhlJs9H1+6lVxiy4f2B+F1cYwksfAJwX8XQ7Fx+avod/8Jt3G2BD1P8OlLA4D5NB9z5hBMobHB8mJ9vPLjj57wBL1MEroaLm3ebZ3JgdDXfhi5XURZVKaGnwpVCK1nxsUuG9EbpSeB91OvUM+OpWqtZ1iu5jWRJm+wgki+LSRys4WtMw/XS/7JzNkJxlrFPKPkHvpft7AykaSkw/UAfM/gKQlr5WcfMiYh6pULiVJMz5AAJ2W7iysB11k63wyCe2ZIH1jubOdtE7li5YcQFjk1+592u+hX/JyzHpjbudEHpDGYPyc9y5XGcF6Qr+kPX3PR833kd91n8eKjKiEYnRDAIzmsc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(53546011)(41300700001)(2616005)(31686004)(2906002)(966005)(5660300002)(66476007)(8676002)(8936002)(66946007)(66556008)(6486002)(6506007)(6666004)(316002)(6512007)(36756003)(83380400001)(38100700002)(31696002)(26005)(86362001)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGtFRXRxVUtYbm9hclV3dHVoMG16NHR1WjhQZHpJeXNxNTA4UkFNREVKYlUr?=
 =?utf-8?B?Unh2OGZ2c0w4UVQxRFQ5K0hoR2NzTFF6LzNodHpyRmRDU25BeFo2Q3ZScGJU?=
 =?utf-8?B?UHl2NDdEWXNwcTRuZS93M1hqd3dKVEpCMVVnS2tWMWRRbjJzNDB5eEpVbjZV?=
 =?utf-8?B?MzA3dWVoaENtSm1hQXkzV0YydHhjQ2JleTlmWkd1ZGppOFUrcDRtenRZS0xx?=
 =?utf-8?B?UTlsdEo1QmpKVG54L2R5UmZ2cnBSZE1ObjlhUmlhV1krd09MQ1ZMWXFzODR1?=
 =?utf-8?B?MzhaeXVObW16MEdoQTlIZlo1RnlCRVBVWmxlZmxRQnBwaTVMS0VRVWhnNnF6?=
 =?utf-8?B?NCtGSXBFMTV3MjFnRWhucndZcTR4QjFVaVpCcC8xdTFJQTdjalhzQWZQZE9T?=
 =?utf-8?B?RzZ5ejVLa3kySjZuSy91WU9JUXFRZUd4QW84emxpem1ZSHpGcktjVHNpRmlN?=
 =?utf-8?B?dUxqZFZHNHpYNytlQUI1clFoZ2FSU2VUeFJERm9Ud2VCbUJ2UG82RW1WbVJk?=
 =?utf-8?B?dXZNL0wwK0JQb05URDRIVWxHQVQ4eVRpTW5uMWlWYWUwcnhpUmNDMXNlZDlP?=
 =?utf-8?B?VXBjZ3h1NGc5VkZYTXEwUTlhQ3lYbWxsOEZyVmdQMXRLdzVLRmZVcGZkdWxu?=
 =?utf-8?B?TFpFN2U2ay9uenovREpOUXpJQjcvRUprQWE2cFh5UFZydVRJRUEvVXJ3M280?=
 =?utf-8?B?dnUxNVE4NUtEd1NWUDBoOUh4UlJWWEVIbk9GVTl1SnMvbVJidUwybW5Od0cy?=
 =?utf-8?B?VytPeHJsRTNFODBKNStjUllyZUVtZmtkeWp0UTJkc25FdmxSekRHQ3hqZVlL?=
 =?utf-8?B?MG5XY3FQR3BaTVRFLzVIVXFhYkRyeTlWNzkrMlluZXEvaHd6UllBNFhZWksx?=
 =?utf-8?B?WkR1QnhIQVJ6ZXlKckZhekNSTmpCN2tXT2N0QUlLVG1PZXloRCtDWmE4WTk3?=
 =?utf-8?B?S1hNSnZ3VFNpdlZ1amx6bjhxaHd2MW5WK2pRcFFZbFJ6WUJ6anRib2t1N1pX?=
 =?utf-8?B?QXlzSjFmc1ZKSVZ6cHo2ZThxWEYwRUdyM0dTQm1JeVlmVVROZEJubkpvMzY4?=
 =?utf-8?B?ZkhzVnFIYUJzVVd2WG5ISks4eUIwWjJHdVpjYzZiTXhiNDE2WWgxcTlQV29p?=
 =?utf-8?B?cnFxWmY2NnFlanhFWjdUMEdMd2taWEZZbEllQVNZVWZYaFRSZ1lISExKNjJn?=
 =?utf-8?B?QndyaHllVGQ0azBOUmVBMnFtMVBZa0c3WXFUdXMrQllMYSthN1RUWC9iTzR6?=
 =?utf-8?B?YWJZK2x4bmtDRko3WE5CMDFrMXI1WjVIT01ZUEJ3c2RncWRYQWZtUUl1Qksv?=
 =?utf-8?B?S1pZYWlSUHZ4TGxnS3V6bjJCT1Z5U05NcklJckhlWEVneGEycHB0MEVNdWRV?=
 =?utf-8?B?Wm1qOW91ekozWm1IclA1R0g5NFl0SVVFb0NkdDJOZzU5WGRHU0w3ckdWQ3RC?=
 =?utf-8?B?OTI1SXJLWmJyZDJXSXBXTTFNNjY0aXljNllXTTdPazErVE1MQitoT1pGV1dv?=
 =?utf-8?B?ZVVzUERpMk1WK2ZrS29sUFh1Q2Iwajdud2tRTDI1SmxSbEl1WGJSa1lCYlkz?=
 =?utf-8?B?TGVBWHNoUkswS1VOKzErUzBUcTkzQUZvUVFlWlIwdCtCWXE5dVI2QitEZVZm?=
 =?utf-8?B?dHhyZVVjcXI1cnphbE9LNHFCN0V2WGZEcjRad2w2Qnl5cDBuWE8yVFJnaVEw?=
 =?utf-8?B?RHRvcVUvbkJYNXlCazVXMG5salU2UmZHczBmT1VabnlBRmZxV3dMaXpYQkhZ?=
 =?utf-8?B?d1ErMHQ2OHd5QUxsN3licThyWmV2NGxueGxTaTBZWG5wU2M4SmkwdmxIdXN0?=
 =?utf-8?B?N0U0WFo1b1RZRlh4VDN1dkxNTUJ2OXNFVS9iSTNobkZaUzZPcnQxYnhOTWhr?=
 =?utf-8?B?blBvdm1wVUcwTmMxUlVEMXZCOWdRcHhyano4KzQxRjB1ZjA2UmlTR0VhY1d5?=
 =?utf-8?B?Q0xHZWlIY1JUaWRBSmhZVHRtdGxqN2FFZUJ2TFNycDdSdFpHRmduRWJZelZZ?=
 =?utf-8?B?NTBUaDR5eDVOS29iMmZaV1ZHKzZSWXRUS216a0QxRlhKaHpQYStYVUlaUzgy?=
 =?utf-8?B?b0RXMjR5Mk4rdStZSjFmb0ZIVjRPMlF6RFgzbDIrb2hwdmN2UWdHaWNlR2Fk?=
 =?utf-8?B?VmU5US9MZDE3R2ZtYm5RendCRlVZTWNRdzVHcTZPdVZiSTlveTRTYTJ1L0xL?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c633ba-c7bc-462d-2b7c-08dc2ec68f72
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:09:12.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJrWMgeVma20aPbEsA40sLSWiyptnAQSslili4x6U9CV0P8pu9RH5GW+qUYV7EFaF4uj64TVLvvkQF/x2f+kS7a6DkwOEidnwhvlPqyy2YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7992
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 08:09:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15011



On 2/15/24 21:14, Jan Kiszka wrote:
> On 15.02.24 16:53, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> SWUpdate changed the Suricatta lua API in release 2023.05.
>> To support released legacy applications add SWUpdate 2022.12
>> which supports the old api.
>>
>> We use the latest release from salsa[1].
>>
>> [1]: https://salsa.debian.org/debian/swupdate/-/tree/debian/2022.12+dfsg-4?ref_type=tags
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/swupdate-2022.12.yaml                 | 22 +++++
>>   ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
>>   ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
>>   .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
>>   4 files changed, 184 insertions(+)
>>   create mode 100644 kas/opt/swupdate-2022.12.yaml
>>   create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>>   create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>
>> diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
>> new file mode 100644
>> index 0000000..5dfe97a
>> --- /dev/null
>> +++ b/kas/opt/swupdate-2022.12.yaml
>> @@ -0,0 +1,22 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
>> +# from the first wic partition
>> +
>> +header:
>> +  version: 14
>> +  includes:
>> +   - kas/opt/swupdate.yml
>> +
>> +local_conf_header:
>> +  swupdate-2022.12: |
>> +    PREFERRED_VERSION_swupdate = "2022.12%"
>> +    IMAGE_PREINSTALL += "cowsay"
> 
> Still there - may I send this cow back to the barn while merging?

Sorry this cow was used to generate a new update :-D
v3 on the way.
Quirin
> 
> Jan
> 

