Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB1D4335B
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 12:53:34 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.54])
 by mx.groups.io with SMTP id smtpd.web10.71330.1730984010506522746
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 04:53:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XNj3JU7b;
 spf=pass (domain: siemens.com, ip: 40.107.247.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0TsR5PEb5tMHIIxSI/GbUB7YdkIGpaqx8YlTjgaDBbuvHKhx13IyeJ4MBFfpev415aZ8vItwsZSG1deJZF5eA4fQeb3GF++qqJo4yMzOKAJYKoc96vrgVgxUWFnkxXUVnr7oESPjNWkoUX13pHI1fyAkgU8zqmpbbN8O+2LJvP64KGqaQ1yDvhIvaY8zuVWXJR6QAke6UakdE4naGt11jk1PCK3g6g/TJ5Qr6BnA6rxUQR9Av9Q8ODkqdFaUQt+8uIl+okW0MHLd/fRR6EfgTYt/BKl0fX2B276UkAJ3WbYqs5Ap3Vn+WEtRrUsjOtdFrTz5EWBBVT9JYcu1so+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DREUiJawdcrRg3f8IJWsKD5CzoU9hKw5qKJUj72G1FA=;
 b=cUgwJME/+bDtWxs1X1+VaOIHHyKc7iIvstFQlzZ38hOuYpS9uUfT9WZD4kqGu/XKp648bBEb2YEM05fPrWmXvPJVFKsewyck4mt4t6AMMCGF88nJ/4I0aqtgWWwUvds1YXzpYXP315fOH3OHuE/SsbcbygSI9EHa8rUL+4mbNdFG7zDoNFyRKGPDEBJYZv1OQe3rEfIeJZ7nWdNqWBHtwOpJeFpt4Q+W0IkJS9hIvubT1TVSIZ+nf3k6LPDHDzWd2te/rwINaH9ZMn7RFDjDvllWnj2KDd2dUTW5TnM0yccVjxcG4rYaCYa+hVcz+a5nkVb4PsifFHohRlBD7owP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DREUiJawdcrRg3f8IJWsKD5CzoU9hKw5qKJUj72G1FA=;
 b=XNj3JU7beZGtOZMqHwAkdXyh4OJ4YJ+bLEhabOkQNyEQnWeQv+zFZNKkx9IRAYQTWArydIFx/I1jFQ9TLBVh/NbFM7R/+9GL3VD49Iedx8yPwkfgomnRltmU3axPjvOCW+wZ9ThTn/suYetBBwOf7Bf0+b01Ioq/Sr4Y8KMDrGCXqn/aV6XEF8sFpY56sxiIEJ69JYl2JPhNk0k1l9h0uW4hYgnHwwqbh2m3djlpf3Trn4ySdgxB89PUyPPuQ/LXr8AIeZcRNogy6GWfYLlX5Z0H6a8NMX6u2C4St2BQbmMS+cezOw/I4Ph5Tu0aJ5+04PerDEl3pPRc5zmbapGcCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:53:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:53:26 +0000
Message-ID: <05e39c4d-bc28-4646-af88-b6a52ab5dcb0@siemens.com>
Date: Thu, 7 Nov 2024 13:53:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
 <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
 <e5081064-f132-4d95-9254-e2962ae7bcc9@siemens.com>
 <690f991a-a496-483a-8125-8245991ab25b@siemens.com>
 <244a95ad-fcdc-4ec7-b3e4-bf5e6e5bcb49@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <244a95ad-fcdc-4ec7-b3e4-bf5e6e5bcb49@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3981:EE_
X-MS-Office365-Filtering-Correlation-Id: f46c88e8-33d5-4cbd-d858-08dcff2b2b79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MjVVSWxKajFjRDFhWHJMQ20xR3RYcGYxWitrMFRVWG9xNG5zT3dXUlJ4Mk9j?=
 =?utf-8?B?RGdOOVYvV3lJLzFFdTJIdUU1eUJNOFhQWVN6SkY1YS9IaUdnK3piNlNscEV1?=
 =?utf-8?B?UncvQ0MxencreGh1QkVSQmdiYVZpK2RvcXJVSnBzTmY2UE0zQ1JQc0JjWXQw?=
 =?utf-8?B?V0xUMDZkUS9wcFNDMXhxYVRMbnZXeTc5RVp3bkdPMXcyckhFbFBvVUlwWm5s?=
 =?utf-8?B?amVyb3lPdnBxUEU2TSs1bnZQNnphOUhrNkdmSDltYjZFRHoxOUtoTnhWeElw?=
 =?utf-8?B?QXV3a3dzMVBlSmJXbWVSeG92amxDK0c4Q1ZLcG42eXU3SnprZXN3MWpmckZv?=
 =?utf-8?B?ajV4Z2R4TjNENk91ZElGU0ZTWXRpbFYxZEVJV0hXaFljRGhYbHpaVGJyUE83?=
 =?utf-8?B?S3ZZQlFQL0NueXA4VzM0aERJekpXZHZlVERPUTUvV3ROaCtDSUYvUWUwdWZR?=
 =?utf-8?B?QTkzYlBzcFgxYmlkak45YW84RlZaUWI0dFVqRUI5MzVrSFhBRzlvSW1IanlZ?=
 =?utf-8?B?YmxjamdLZFRTZTNQSHNYS0p1TG45OVcwR2ZLL25ScGNaSnZRQ21mMWdsT3BG?=
 =?utf-8?B?RXZzZTlqOGNybGdOcUFJRmJQWkVIR2RueFpxL3lMclFUYms0TmFjTVo0M2xm?=
 =?utf-8?B?NHRmSWxMVkhNVEFINktJYkJ5U1pKb1ZGbVZzb3ora0dIOHF0WkpaZXhJSDVG?=
 =?utf-8?B?REtlUytXTFFhYllnc2RpREJXS2cyZWV4ZUlTRTk0M0FyRXFNSkVubjNVYnQ3?=
 =?utf-8?B?RGZxdWxrcjNkWDE0NlR2OVBUZkhOQlB6c3c5dkh5SU9QTnhpMmdiM2UyZWRS?=
 =?utf-8?B?aHJKMGlFbmtZVml2SlgwcGhTdzVsMTA3TE1abVg1V3lNc0hDL04yVW1wMm5I?=
 =?utf-8?B?OGtRSW1KYisydHNWOFdTYW9ZcnIvLzdINVNpNThJZTFSV2JRek5BY0d3bWhO?=
 =?utf-8?B?WGNRWWVDeHZRS3V6bTREeFBDanN2dnBMOWNDUGoxNmtFV3YvSnVVcWlBR2FE?=
 =?utf-8?B?SHNzVDNvSG4zQnZnZFdxVjE0c05JSHU1NE9MRlBnSXFoQjBETUduQU5Rcml5?=
 =?utf-8?B?UHRwb3VlcXhkVWlXc21pRTJveWcwVHFHaExsdzZFQnV4MFlua2t4dmZ3amFT?=
 =?utf-8?B?ekdwZDZ4cncyalcxdW1ESE95akI5S2hlZWkwWUpyemxaRkVDb2pHSTFYTGNF?=
 =?utf-8?B?OWlPTHRtay9TUXBNc0tGTFMvT3d0RXhFT21CRFlROGcyVm14MVVpMmZvZUtZ?=
 =?utf-8?B?c05PT3NPakdRa3dQK0lQdk9tdjc3SE9rbHIxek9LTHdhNTF2Y2YwK3BYWG5M?=
 =?utf-8?B?emp4YTNZWWJGVzY0ZllrV3hOL3Fad0I1Ymo0NlMyRzBlQ0VGU25zTUh6RDl4?=
 =?utf-8?B?cnpCSGxXc3hpZDU1YStlTjdHMVRlZU9KcWdsbkNJVUVBelZqMnJpSTlLd2ZW?=
 =?utf-8?B?Q3l4L1l2a3NOeTBZbVEwSGE4TG45ZGRlRXp3V25pSFRQNkpXWThMdy83d01t?=
 =?utf-8?B?QVl1UkU0NWJYYk1nYlhleWpkcldjWDV2M0ZxVGJGYW14WHF0U21ZV0o0T0hz?=
 =?utf-8?B?V2JCaERXU0hpT211Sk5JcFNRV1p4enNnMW5BdTZUbm5qMFRxWXhlekJJemlB?=
 =?utf-8?B?TDR0RGdIV3ZhY054L1Z3cFI5ZkFSeHFibkM1S0JKbnJpOTRBNG1FbkRMUW91?=
 =?utf-8?B?bEVQVTFtYTdtVWxsMWVwbHAyMU9Mbk1wVHloaW9sT1RCNThhRW9JRmI1SUp0?=
 =?utf-8?Q?kURIdM8On9ALPTkh+U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2tvWUZlTlZBbmExd2xSWXVudnB6SXl4MTFDWnNXaUUyZEdIdGxhVm8wNGZt?=
 =?utf-8?B?WTFPTE5adXFmdExTR0xjRkoxWHUzQXowaUUrUUtVU21UNVZNRWNrR0dXamRF?=
 =?utf-8?B?WjRtOFZYTXFWajlmVks1eXdXandJaGVJY3AvZkdQWjdEZ1JQeW9rdnFiS1VU?=
 =?utf-8?B?R2FyWVIwdnRpZWYwR01tamtuWVdxWmZVTG9lOWpHMjhPN3RmY1VKN3NKTS9o?=
 =?utf-8?B?d1NPbllJUm9OblZqanJUenVOL0hvK3FnWWljQlJsU2tXWU9qYkNyMmd3K016?=
 =?utf-8?B?WUdBVUY5Y1h3OWRQVy92bzh0UEZDVlhFdkdxclJKaDRKdkNuN2h3TW9jRm9h?=
 =?utf-8?B?WFFIYWRObzJodTlIRzE5MDFTa1Z2MzZEd3pPNE1mVW5sVndGb1N6Lzc0NDFU?=
 =?utf-8?B?aDVXVUdWMEVML1d3Zkp6bE1FazczZUl4bFZNbCtnVHRPOWRTY2ZqYUlpZlBj?=
 =?utf-8?B?Z2paYkFhMkhFRERRL1NzWEd3SUUraVFxaVZRT21uWkRRakFwYmpuNkhKbHN6?=
 =?utf-8?B?R3RONTFoTHVXS1puQysxb2NxNUVKZlZQMnJIMENRek1LQU5qMUdPR2dWYkZH?=
 =?utf-8?B?bFAzTEFiYkpWYVNBem11R3ZWcXUvRFNrcjBwZGp4K01CeWszSlRmMDFpYWRE?=
 =?utf-8?B?OHBtZm5qeUFxTUQwaGQyZXAyR0hKT3BRMzlVR0RaMUM5eXg5SmxJNVk3bE5u?=
 =?utf-8?B?c0ttVjl3WWw2c2JnMU9Dc1d6cEsxVnVwQTkyM2liNXlSY2YvZHFaN0VaNEk3?=
 =?utf-8?B?SlEyYmZ2dU9vbFJUK05uclNSWTJiaGlEaXg4ZWU2VWQ5RlJLOTlhREpJS1Uw?=
 =?utf-8?B?SWREc205QnIyTTZnbGkwZTVkbG84MnBCQVoxb0JoTXFtZE52TUNtVW81Q1hQ?=
 =?utf-8?B?WTJuL2ZwS3VtL1F2dzhuSUNwamVESUZVVS9jUWd0MHJ1NC94c2Y0aG1aLzd0?=
 =?utf-8?B?cVp0TE5QVU9idm53QlVSRXB3eStlTHZHeGNzdDAwTnlMTHlWSTE0eXUvOEg3?=
 =?utf-8?B?T2hJYmJjUWZIWWhYNzB1MGlUSzE0RGxnMGFMOVdyclBvT1hRd3ZoQ1BqbUZj?=
 =?utf-8?B?REVLcDJMMUJSNkZSQ2tyTGVDWUtPaHhZTDgwQlpteUgzWWdUV2hTK0d5emZD?=
 =?utf-8?B?Z2daZ3k5WDN1VlVvNU52MUg1YnVxZkVJVHQ5RFRtSnd1ZVRFd1pvMTY4eWow?=
 =?utf-8?B?Zjg5VHIzcmJ5MFRHQTI2NGZ5VmtqVDg1aWU5bUdoUjdkcGtLMlNTdm43OGZn?=
 =?utf-8?B?Y0RTSVdrdDY2eXpvTzZmdlBzOGd6eUJZQ05yOTR6WGFCWlVTQitkQnVLWSsz?=
 =?utf-8?B?a2hBSzVwWkFUTGUwMmpBQlRGYUdqRlFuQzdyd29MellGbUJTcXFuZlhnRGhk?=
 =?utf-8?B?allJL1NZWmUrRk1Ua2RUOFE5NkNneVUxN1NKdDllaGh0YTlNKzNqb2lkbmN1?=
 =?utf-8?B?MzRrTFJTSFhIKzZLMWx1Z3QzUGI3aGl6YVhvTktXQnZMcGlBREtGenZwWXZk?=
 =?utf-8?B?a2NBNXRqNHFjRDFQQ0Q4RUVXVkNCdG5nV2FhRVBaeFBtdm9GODBGVGs5Qldh?=
 =?utf-8?B?K082YnBGUE9Na1EwVXFMWEpJYkZSeHJKcCtsNC9IVVByeDFES3pXcDFYS0VJ?=
 =?utf-8?B?czdON3hYUVpEemw5SWU2c2grc000R2ZaTXZOSm5kcEUrNUpQOTR3K28xM2ky?=
 =?utf-8?B?YXJ3KzZhMU9yMEJ6OEc0KzJPK1RHZnk1enNkTkIrYnpWbkJkSUhrVW50NHla?=
 =?utf-8?B?QkV5eFlHZ0QxaVBGSFRDUFgyVk1kY2l2N3QyRitIcVIwaDRSbTI4L2thVXBq?=
 =?utf-8?B?ZUxXSENpN0YvcmNBTkdubGx3SVJOR2Z0UHMvMnBKNnh0ZmZUYjlYY1YxbitW?=
 =?utf-8?B?dFU5WkRaczlZVHhTS0ZHajV3RmVpMHc4V3dwRVBjSHlxek41ZVNHcmhyUi82?=
 =?utf-8?B?Qml0OEtNZ2NITjRkZVdVK2lFMTI1Qy8rY2wxN051b3owQmppMEQxR2hOYTVR?=
 =?utf-8?B?ZnY5em1NWExIeHBGYjVXYzVtR0FJZGxiZyttUkFxYlkwTVBwQmd1cHFobGpY?=
 =?utf-8?B?ejMvTWc1TUY2MStVMWRheXkrem1ZQmxqRzY1cnVkQUdiU3gvNzU3ZGRSemc3?=
 =?utf-8?B?UXVXYzNzdjBTem1oNUR6R0I4V20yWkk3QWQ2L3VwZTVZZ1l6bVJNdGxKaHdL?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46c88e8-33d5-4cbd-d858-08dcff2b2b79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:53:25.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK/6ri8DNfGXYnJEFReMfmoJjcdi4sH0l8qvXiqgMB3twiglLtY34rR/N/lTQYwUEDwlGAWJbr/YE1cmnrdn2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3981
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 12:53:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17219

On 07.11.24 13:33, Quirin Gylstorff wrote:
> 
> 
> On 11/7/24 13:17, Jan Kiszka wrote:
>> On 07.11.24 13:11, Jan Kiszka wrote:
>>> On 07.11.24 12:30, Quirin Gylstorff wrote:
>>>>
>>>>
>>>> On 11/7/24 11:57, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Under the assumption that future versions of Debian will deliver us
>>>>> the
>>>>> needed versions of SWUpdate, this eases to opt-in for self-building.
>>>>>
>>>> Do we need some additional logic for SWU_SIGNED = 0? As swupdate from
>>>> trixie requires signed updates?
>>>
>>> You mean we must enforce SWU_SIGNED = 1 from trixie onward?
>>>
>>
>> ... or do you rather mean we should switch back to self-building if
>> someone selected SWU_SIGNED = 0? The latter comes with the risk that
>> self-building for >= trixie could quickly become untested and start to
>> silently break.
> I think documenting it would be enough as SWU_SIGNED = 1 is already the
> default. If you want to deactivate signing you would need to set
> SWU_SIGNED = 0 and activate self-building.

But what should be documented? These are just the technical steps. If
those are not part of any test set, things will eventually break - in
the best case already when trying to build.

I'm rather inclined to deny self-building on >bookworm until we have a
concrete need and cover that via testing as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

