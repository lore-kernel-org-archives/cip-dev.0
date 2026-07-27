Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56143C53219
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 10:13:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27688.1785147227642440736
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 03:13:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Kb9L1ezj;
 spf=pass (domain: siemens.com, ip: 52.101.70.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0pwBcsB6V50f7pmbgP17ILxroVtFY9ZNIEuotp98MlYbSDpamndKQ25voDRVJHHm9SjYf6iNQS/pWhHV3YWfulSZAf5QuEApIE/Cpq9JLamHTwqwDAkmO90M1G5FqWjf0wbWU7Kezr4wGLEbd0EJ3uKl5NAULm1bKkMM1OQx+v55/UJh+63Uce/RD1m14jLl/o0A8jHUzX6EYhwpppYpON0+SHMpi7bxpfxgUPPSSyE/Fw4y0lqbLy7f9D05nPSyDzTCdE9m5BBgSuPnI/frWHvtv5sWbBA2qhgzryFpmHHLGiSTPTz5vbQTkvuvxg5FJo7wGMRY86v2RL9ayaPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps7Q8uhAkRax94a1hAOz03REH/waQjgCtoTl/phCoow=;
 b=GEgFtHsKeWetqyWTaWITrW1d3kiis8S+8lw08vvI5iCX2YM/RjsLFskiTLzUyHhTDkSzq9Ot2P3v2WCPnV/Q5kKhYboFNSurZeVfkaZ4HsyPy6NYP+NW2oI9MWpod1J/MkTcjjijc9dkpObkblugh6/akYXRpV1FPTqDUNGBHVvHebE3GQDR3nKd1oFVbIO3wtLGUp6LjhB/HqfWZ9RUCLpyytbE8C/eaGuoh8Y9eCDj9j89pXylWmFDtAU34KrTQEA6K/RCZSo6T6vSIH+fcwBKlKuPRsPPJ/BuzhdrgYvTlOqcejqm2JuzSESLgN1HfiaDU6fBM5YKuRT5FuB1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps7Q8uhAkRax94a1hAOz03REH/waQjgCtoTl/phCoow=;
 b=Kb9L1ezjjJW2+WYvMKfZaAuAfo77TFpc8ufpcUonqCW3U9cLHnjSkfjpZ3GZzHuOZdyW+/Kx7HBx4fgE5KZk+EiCJxOaJOwf6pyj3m9zZGg783xz6ZG0GnN5cnCx0js02X4S/EV/mv8BnrAfbCCZpmQjWWr0APiBX4wlgaoy/DsAf50HX0yp8lntl1YC7cozCKCz50CxNM+my8eR7QfVOifnAr/izXomfqNtmHZEqSxI94+OnJNK5mUxb9Maxw9UBIpai12Yu7xBjm3A6bAv2GnLJlG8MXQCXirORGu35e2oAvbpYrDm96vLehh7PqIy1MLN3ULjh0y2QopOBuz2QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:13:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:13:43 +0000
Message-ID: <8a3ac2cb-c684-4a6b-ac37-8a9ea7edc149@siemens.com>
Date: Mon, 27 Jul 2026 12:13:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 0/4] switch to rootless build
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <d307dc69-ab0b-42e1-9e48-f78cae03bdfd@siemens.com>
 <9daedbba-44e8-4cfe-9f0b-34f087b87d25@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9daedbba-44e8-4cfe-9f0b-34f087b87d25@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0088.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: e4eef8a2-0c86-4f11-afd0-08deebc7bcca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	HmrRLaUMllQyHPUz0EZgSRJ681jmCKsvvGGcD0E1xWojNGUzBC2cljqTXvZ6zIX3d0j+2RQB0fV7DnTVgb9kdhmjJ/mAO9GsUEb6Ut+mTL42E9+nTII4hMWTTCju12fXDNZYkhS6QbrjnXzPxcXCkUgXu+eYLCp+S4QsSDBeQgV8qHimWIKJqx/bqeU0BECwrUkZXIyafMT1IHSiH4v6vFl3fgxMXc4zovvwWtr/ZF+yRZQ1rXuzyoV/02Zdq21gV1ADrJRSo+Bh3A18gIZQ52qkdIfTWUp596PmX2OH4oucZNKYXJ9Y5HfQIJxix2F3eawglp+OmxZ+yym2EfmrF7BcTQqXq2S+YntRYTwL7jbMjvRJIFDnCfjh0aOZm6Vp5Hh0yPv4rK9sIMmGvXAf3HMhCPt62h9/xI8BRnU2HM+cfFKwNxxbmjNzFp5WvGH8gl2fmzcSoaYLUq/hAWYLe0bjQc4aQGmIBL98oXStsZE+Es9+XAHTYrz0bXJau20hHFCo/lFH/WIP/FdAYGXMm5BMpem2qYy3j8RyckVkdVLIu5SdmRzVVB0CpzZQ9lNHE9flpcKPILdr/YseOBEJN5VviwJfyDlIe2+91r61uznrg4aiAZR/w0jg6qSpolihdurO7/+wTHd6szEaOad5Maw1kY0N3iu4unTMJUfiagw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWJFdWx6ajkyTDc5Z2hZcXIrTkhnVndNdmhTeVZycUdEMEdRS0YrUVlkNWtO?=
 =?utf-8?B?MFZ2REdLWTdwUFQ2bXUwTWNKNGZjR3BYRG1zYzhpMEs5emtCRnRlUXhreWo0?=
 =?utf-8?B?am5lVU5jdE1TK3QxUDJwRDZneEFUWlE2eXVQVHRJaFpqMGlZaXd2aUs3aWVr?=
 =?utf-8?B?LzRvS3ZldUxFNHZJNmExOXBVL25Jd0ZGdVNKa3ZxWHhxaDJCdWhNQUdFY2d0?=
 =?utf-8?B?SVNMQjFzMlpkTktlY2FTQkRPMjRUdGNlUG1FNGpmRFpvTHNkMGQ5L3FiR2RW?=
 =?utf-8?B?QnV6WSt5L1YwUmpaQWJ5dlFveVYxOFBqYkRDWjBvQzNSdnFBaEFWRzczT1Bp?=
 =?utf-8?B?QXNvR0RDZXRyUytDUFM4WTFnMlR0YkJscCszRXc3SWtoenlVdXNDeTlHZ29M?=
 =?utf-8?B?VFR1OUpTT0pGSjlzT2FrdTJTMWFxYzBxU1llNXFJQURNOERKMXNWWHgzWC9F?=
 =?utf-8?B?N3FqRm1qVWlUMEFIUUtoK1hpUmc5RTZuR1g1Uk94TENvdEg5dEtDVWNtY1NF?=
 =?utf-8?B?azBEZHBkczFpb0xoOXNPRjVGS2dHYmlMK0VaNkxqaDNmMTZsWnUwdkxmSzI3?=
 =?utf-8?B?b3RCVDJVSmkzemRwV0dYTUFoTEx4UDBRV0MxOEZoaG9jRkkwNTl3Q01oRmQz?=
 =?utf-8?B?aDlvZk9jelhYTDhxekZxMkJCeGRZZ1NsWE5veTJIR2N5MkViVDd1N0tPWElt?=
 =?utf-8?B?SlZQQkxpZkVlODVTcHRrbU83cThpUXJENUJRNHhBc3p2T1R6RmttaDBDVkxp?=
 =?utf-8?B?KzYzdFFodEN3QytOTjgzdW05ZlpseW1wVkF0QURqSzRkbVFlYjlQY1FmNzhG?=
 =?utf-8?B?NmdkY09qWVNzTnc3MVFhMUR2QzJUU3N1TjVOUDVvV1ZQbkFWemZaRFRDMUtF?=
 =?utf-8?B?aTIvNkg5UEsybVRRbWFUR1NTeEprN0ZTUDJqR05zQzhlZ01lWWlLQVhKUnY4?=
 =?utf-8?B?REgzQmtKeGQ3dHdyc1FUZEpQTVJrSmFHYkM1U2g1dkFFdzhYQytrTHhaNXkv?=
 =?utf-8?B?V080QVVrTVVpQjcvN0lyUkU3YVlMMmNhRDVhRUNMOHlxRlBJY0ZmYm5zSnZB?=
 =?utf-8?B?N3VrV2dXREZBQUpPb29WU2RuQUcvT2FocWdENDAzQzFrakhYQU1EeTdGQmhV?=
 =?utf-8?B?VzFsSVJCQzh2L2x2dGEvVUpPcTl0UXY4aENyZ1BiT3dTWTJEQklhOXFGQm5j?=
 =?utf-8?B?TEtYTmNQblZzM2FQM0Rhd1MyRWgwYlB6amJsRkhhVEl1NVdUdDRHb1FnRXR5?=
 =?utf-8?B?cWNJQjBRRnJlNGlJVEZxejNkOXFTOUFSVFpLeHJuYlBZNFpzSGF5TFFBS2d5?=
 =?utf-8?B?ald5WVhKUVBvUUdJUzN2RDkzZW5hNTl3aDJJdEZMRldROG1ENE9oSGlBdTVz?=
 =?utf-8?B?QzhoL2JabjJyOGwvbEl4RnZVMmU4OW5jUEMrMjJadmx5dVp3WitKU1hianQ3?=
 =?utf-8?B?TFR3dzVxazIvM1J2Mnl5Sm9yZmN5MTVBK3cvTDh4OTgvNC93MWZySTV4WlVD?=
 =?utf-8?B?eDdRVG9wTUZFZkI3aUk3SFhmSWFuZStheHh5RS9rODBJWUs5Tk9VOE1aS2xi?=
 =?utf-8?B?NkowbFhySUt0K0FkcTlTNlNXQkdjaVI5OW44VlpjRkRLa0lnMXFuaUNkSGFv?=
 =?utf-8?B?d2FXMnk0dGZveS9iYUNZLzRjV3MzNG1qMzZRem96bmNQR2hNRjF1YzByeDBo?=
 =?utf-8?B?R2JDNStnby8rTWY5UTBDVE15cVZTU3JqbXM5c05DVHlCdldxa1BWWnU0S3BC?=
 =?utf-8?B?QVNBT24rRDRGM2tQUXB5bXB1OEVBbCtYcjRNSk1YZ25aUjA0WHlnclRQSDlv?=
 =?utf-8?B?Yzh0UmczZDNhRmhOQzhJL09FZlRGakxXdjdJNnNoRjFVWnYvbW1vK3FEdElx?=
 =?utf-8?B?YlZFTmtiLzFCOWErWGlvaUhNaDk5SWxGY2NYSWtEU2FUNnJlY3RNbDZ1akQy?=
 =?utf-8?B?MHI1S1FiR2hKVnNZMHRaZ09oV2ErZCtOUFNhTXFTVTgzdEpXZHgyc3FiZURT?=
 =?utf-8?B?ejRlM3dXTXROWnVRWVA4NGZmSWxmYVFsbDhXSlgxbGVUQUdHQmUrV2ZRcjdj?=
 =?utf-8?B?ZGJxOXUwSU1wTG55WHd4K284MzVmMHB5Y08vWU9DMWpUSXBCSUxzbHBITEZ6?=
 =?utf-8?B?RDVJcHZ5dko3Vm8yb0NHckkvOENCVjV1QWxmRmhRZEV0aDFOa0JyVTgxSko5?=
 =?utf-8?B?Z3cva0EyQUdTYlErOHhIWEIvR2crdGF5Ty9CWWY0SmYzSytxbHI2U29WTEM3?=
 =?utf-8?B?U1ZHVXEvRU9hVHJUUzF6R3VXOWhTWGNYSFk0LzRSSGhOejBUbm9LdUdJT2tm?=
 =?utf-8?B?VlhJdXpTM0VzVzhBemU1VWNpWmtuVkI0ekxUcEVISHB4Z2Z0aEIzdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4eef8a2-0c86-4f11-afd0-08deebc7bcca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:13:43.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPY3QtXixAZzeTI/OnAeIpnzydIvPv7AqS9ixduSjadqmX9mQmJwZ6xjZRgKVf4oHxUO1US/tOGInmObFHqXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5551
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 10:13:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23757

On 27.07.26 10:06, Quirin Gylstorff wrote:
> 
> 
> On 7/27/26 8:13 AM, Jan Kiszka wrote:
>> On 24.07.26 12:51, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This patchset contains the necessary changes to switch
>>> isar-cip-core to the new rootless build.
>>>
>>> This has an impact on downstream as the classes need the new
>>> rootless changes. So this is no longer compatible with isar before
>>> the rootless merge.
>>
>> But this remains opt-in for downstream, except for updating Isar to a
>> compatible revision. That alone is not new to isar-cip-core. However,
>> this change also demands kas to be very recent. That is a not so often
>> the case. But we need to do this step at some point, and we are still
>> early enough in the release of the next version to move forward, I would
>> say.
>>
>>>
>>> The patchset is build with the following pipeline
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>> pipelines/2702946001
>>
>> And that means our cluster is recent enough to host this. Downstream may
>> not yet, maybe worth to point out in the README.md as well (if Isar has
>> some info on that, just link there).
> 
> I have not seen anything in Isar. Has it even an impact on existing
> builds with priviledged containers?

That should remain unaffected. My point is the requirements host-side
for doing rootless builds: We need a recent kernel, and that is only
revealed during the build, indirectly.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

