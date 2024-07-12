Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DEAC3DA4A
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:46:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web10.4197.1720777591783369315
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oIEiBLvt;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikgfw760VDZSPEUb3MJZdBLSmzNolbA+sbRwFQclJyPl//kCyUjWVaXl+XFpZiXL5nwrfPrM1CHzbNMO7KCNm0imuzLbkJRE63uxsHjlTojJOV3tB+ERS93p5JVWk8l05HMKO62UUY74w+Wg9zlKdKdNO07er52EgBjixSDRv9XZO0J3FeX2ftcwxhEx1D9EQgeCwhglac5OMtQxha5NzO36aAebWAIBeeK9j9S1XGD/603f915vRjVpv8zBj7MrUpC80WEcvT5GoN/JAvzgdNcUv9eiDeCy+zQVFXYDMkKR0L25cgacVHZi31N+QzutZQsqbk2DhaIg0r+B94w8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry6hF+JSVvbLTZ3uT8VNGfHxJoxq0Y2/AXS+fvBk7Rw=;
 b=ou5u+AQZpQiKq4OwsgpxHNiA9GrE1Tb21/tadDAk1ATDOrhPN/Iw3Kv+eWp55k3OnYrlpw4K49srnhaErZjx/30WzlquhnIdAPuXx3wKhsyzXpBiDUYRnwpDKYKrPYcAg6ymQumfBpCEETrppIx2zeUiXO7S/vM/lB016vMG+zUvTholxomDl4pMhVwXBtXEAEU4m2DOX6SNC7NxzWYmI0tU+WfDCRV94qAgNKx0qgnW49h7w4kuch0r32dX4IbTrgnNwUgWlRaZAlfXKVWQejZTMQ7P7jcQ4hFnHM+GgfETS1FwYcJriAvvKOFxubT+4OjK6mAsCabSTZ1JhSjhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry6hF+JSVvbLTZ3uT8VNGfHxJoxq0Y2/AXS+fvBk7Rw=;
 b=oIEiBLvtGzLaJaz2XGlDx4UxWpbHTqF6PEN+bfaUu8eH5kfagZnrZen5DDjxgfzMmdr/7BreUyC3pO9dinIH/Or57BXVWfErG2tsR8huevkP48NGxx76l8KDgoWQDUT2YDtIZLjPulWmRxw5bzDKsYg3f1R/evFAuDJEymXtwYQkHce+g9yxfwgfIHkFHOoSD7LyBim0YHqa6wmaO5C4bhxYHn+Q/ownqS4WWtYU8gvQeSEaxn4KlL4uqP+Vsr3tC1DAwb3Cjypl8yTmL7uCqfOlpE9yRKrJISfs/UagMVwO6wnFDfb1UaVg2kyjpfMlsfYZ3sfavUTkxRFLmVYGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:46:27 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:46:27 +0000
Message-ID: <1f54776f-d35f-4b5e-9468-06f4814ea5a3@siemens.com>
Date: Fri, 12 Jul 2024 11:46:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] initramfs-crypt-hook: Speedup disk-encryption
 reencrypt
To: Jan Kiszka <jan.kiszka@siemens.com>, Stefan Koch
 <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: christian.storm@siemens.com, michael.adler@siemens.com,
 simon.sudler@siemens.com
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-4-stefan-koch@siemens.com>
 <998b7abf-4a8f-4f22-abd1-e077eaf68bba@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <998b7abf-4a8f-4f22-abd1-e077eaf68bba@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 731eccb3-2cce-4979-1204-08dca257800e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eloxQjdpbDBnbjQ1MVhlYWwxZ2dTb25HV2xQczAxRkRSNGY2YjFMOTh1T1Za?=
 =?utf-8?B?cjh4RTg3MFhvVGtRdTBrMCs1YUtzWkVYeGFtd3F4bXJHSTE1MG55akdEcXVJ?=
 =?utf-8?B?VkdpZDV2UDBXSFQ4M1hvVlBpZS9PMzdjcnJGb0oyL3ozWUZzb3pob3lud25p?=
 =?utf-8?B?eWoyNDRCZ1RZdEp0dUdod3AvVTdFcUlzYmhrcVVUUFQzMXJMMTRXVUlLYnA2?=
 =?utf-8?B?TnhkRlBKUFZOYzVrVkhmN2hxR2JxRWhmekQyK05KUlU5MmttdkRpY0RFeVBq?=
 =?utf-8?B?OXZOS0ZUSEl0NWxpNWplOFBIaS9NcDBXVCtuV1FveS92Vjl3N0h1a0luY1Aw?=
 =?utf-8?B?ekpadUc4bzVVb29HTENjWWNMMkhrSzN4VFlEQy85eFNOTTNYQk9Qa1VSRFVn?=
 =?utf-8?B?N0l4WS8wUVMvTFdGUkswQ2pQWDdkSnRrTVNOYXFXVnRXU25GTXFpbU1IL3B4?=
 =?utf-8?B?VmtwWGZadTQvWUduM2t4SUFaRmRxYzJ2dlBiQTlRQVpVQUM4QWxnbGMzUkw4?=
 =?utf-8?B?QjhURnI0VURxVFpkNGkwL1ZVOGx5cVlUMEFZN3JKOHArd2Y3Q2s4R29PaXhS?=
 =?utf-8?B?MXV2T0VEVG05QzNsRUFqNmE3L0d0NmZockd3YTBUWkpldFZLdW5qWGZ3TEJ2?=
 =?utf-8?B?WjI1NkUzd0M4aXpGelEzaFJXLzlhQTA0N1lRRDU0Y2RzaVljTEZldVo5ZjBV?=
 =?utf-8?B?djNEWit3MWVLQVJOMGl3SlZlaXo0RE4xZ3ZtVmpPbTFFS1BhbG5HWnE1emRD?=
 =?utf-8?B?WTg5dnRwL2hvZ2w1T3JTb2dXMkJvN0JYUjMweFMyK0Y5M1hiOEVMcXlqcG55?=
 =?utf-8?B?NUxIR3ptYkJZdkZVRmp4MGtTN0RqVUVUZVV5Vi9uNDRKaFgwRHczUk10eThK?=
 =?utf-8?B?UVFseGVKd3BnTG53R0pVY0tYZ3V4M09kd3BGYTM4RncwTndRWVQ2NWtPSTdu?=
 =?utf-8?B?Q2JmVTc1S21YZ1JmL1owU3JWeFdRSVZjYjRhVFdJYm9ER0M2RnBHdnFHd3dO?=
 =?utf-8?B?WEVDVHA3VUFMdXk4QUpONng0cHMwWjU1aXJDUUlya1o4aWZicGFJUUh2cnM3?=
 =?utf-8?B?NXY1cHpQWUo0Ukp2RWRJRHdhTkthZ3hxa3g0Y2pBMjlHSC81Z0pGcDZTelM3?=
 =?utf-8?B?TnJ0UUpFdGRualp2RGhnOWhkeXJlU2tFbUtBVklOZzF3TWJZODd6cHU3ZkJl?=
 =?utf-8?B?OEpIRUh3U21RODJGdU00eEh3cmdYV1pYeGl6UWluNDZ0bTNWVXkzNEZNcXJT?=
 =?utf-8?B?TWxhdS93ODJ4aDIxZTlBYnlvNVhyY2hseUY4Q203SkoyUzFqOU9hWU13ZTJh?=
 =?utf-8?B?M2dGbWs3bDdKdFhFcEUvY04wS25uT282WnZBVmRJeFBZM2xjeDFwRjk0dEpU?=
 =?utf-8?B?WHJ3dW1jVjFQazQ5RWMyVVN2VHlHWm1hNnpWUzU2WGoreFFqUnQ1YnpZSElF?=
 =?utf-8?B?K1ROVUVldnBRWkFTSk9Kd3AzclZKdFZYUm9qTWZMQU01T2ZsZFRqWEJjK2ZM?=
 =?utf-8?B?OXJmTnFsWDR5ZjR6cTZhSHdrM1dSRC9hc0hVallhYXhlSnZ2TkRIS1ErWnls?=
 =?utf-8?B?UzVQY2cyMUd3a3lCT0xxWFQxbVJIZHMzQmZGMW4zTDQyRlFxdndkRUhvOW5N?=
 =?utf-8?B?NDRxVG02ZE5wM2plSFlTRkllZmNYQ1ZGbWhtdXZjOWZ5NkZtdHhuQnF0Y3N5?=
 =?utf-8?B?ZnlFak1ESk5oNHFaK1RSclFITEMrTGJrZ0dQQTZuclRTL0o5c3dta1VmTmNO?=
 =?utf-8?B?elhQZWVzZGUzNzRlODRYREY4TWhpRTVCQ1JEOGFkcHZxOU93VDU1d1RIRVJL?=
 =?utf-8?B?ZCt1cExFY3ZybGFWeGxvUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2FIcjdVUENRY0JSVG9YblZwOHZISmJWUmQxVWwrS3FoRkNuSFIxb0Q2RjVV?=
 =?utf-8?B?bEVFdVowR0t3SVBkZDVUa2xrL3J4UG50Ny83Y2hva3UzeTQrMFNucFhSSE5F?=
 =?utf-8?B?d0FnOGkvR2UvTUhzaHg0eGYrNHR6dmtiL0RsZ2F6eTlRclVGUVpPd2tQbkc4?=
 =?utf-8?B?VTlzdlpnZytFR3diMENKRlB5R3l2L1JVeDVybXI3b05HMVFsamZHYWsvWG1D?=
 =?utf-8?B?UVVKbW8ySGgxQXNuQVJzNGVTTUNGdks4Q1h3MGkvSmZrZndMQlE2dGtiT3Aw?=
 =?utf-8?B?ODk5SXVueG5ZTDFGWldRU0FxZDdpNTJLVmpKbkdpeFJSZFc5T3dEb3l2NHNy?=
 =?utf-8?B?WlZ3QlV1dW9udkQyVUZvUmtzR09Nd1VMTnNCaEdTTmpLNWV1TTBBaTA0cjFh?=
 =?utf-8?B?MHQvbjkyN2J4UW5XbnA2NU1iWHp4ZDRmRGg4WUY2WEZxKzhyQXFLOFpIbS8r?=
 =?utf-8?B?dmdHS1ZEUW1OYXB1NmRJdDkwVFBrQjVBVEx0cHhFU3J3cVFDSFlEZ1dLOUFm?=
 =?utf-8?B?dVdROVhvM0hiSkZaMVFFZXFycXd1Z3ViampId25yYlFFSW5XcWk2YSthL0s4?=
 =?utf-8?B?NDcrSkNzekU2RWg5VWdheEZUR05tR3FpZW14Y0pURnJSaDVuVmNlcG9FUi8x?=
 =?utf-8?B?Nk4zVWsrZ2w2UWV4NVJOSUpRdkhYcGZwaFF3R1B6cWtnbTJaam1wekI0NjhY?=
 =?utf-8?B?MXM1ZXIraW50MlFlQ2xCYkhhb3hvTUxMczNXTkV6VEFsMEFQa2dENzZoOStx?=
 =?utf-8?B?S0lrMitmd1AvUWUwNUllWkJ0aUxlc1NrelI1eDRMSnFpOWNxeTRSL2hxalVn?=
 =?utf-8?B?aXBhNElGWUUvMzlqRjRkckxDbTcyWnpvc0hkRUlpa1h3RlZuSUMvN0p6dzU0?=
 =?utf-8?B?UlVTQVluRlh4VWg0dVNPRXRULzl4VDFCTmZSMmVrRVpiL2M2RUlSQ2lzRGtS?=
 =?utf-8?B?dTVWT2N2WG9IWlh0aFVpdldVQlFHeUhYN3Y1UGJwT21FTkVWemcrakxMREpu?=
 =?utf-8?B?dFhGSGtWaml5T3pCbTk2RFF4T1BuUURhMUQ3T3ZsNnRaKzNXV2dVdXBzemFh?=
 =?utf-8?B?cWZEaStselRBaVY0MmJRTTl4cXA1QzIzclhBbjROUzI4cWlnU1UzZnRuenRn?=
 =?utf-8?B?TWRkYXVNVDc5UG1HUWx0OTNjUGM5b1ozbStaM25hcHQza0M5MC9FOG9nS3J5?=
 =?utf-8?B?RTFTMEtjeDgrSzluU1RnMXhqMlFCZ2h3V1ExcXh2OW5GcE5mRUNaMWFadlZu?=
 =?utf-8?B?V2FMWmVseld5Nnl0QWFiRW53QkdQdFdwZjRZMWd5YjFZSDRLRjFWcmc0MHA0?=
 =?utf-8?B?R3NEK1FQRklrS21ZNkpyY3diY3I2V3huaEhodXVybzhVOFo1cEQyTXNnVEcw?=
 =?utf-8?B?ODFFdjZXMy9WZjZWTFZkc2NHMWJIbUR5cDZoakNRMS9SM3pFZ2lGQ1lWMmhv?=
 =?utf-8?B?UlZzZ1o0dzB4bFN1WUxJU2VwK2VPNGh2RVJJZENQZ0o4VE41b0hyVjAyTWVt?=
 =?utf-8?B?YUpSNllNZSt5Wnk4ZE91Y25SYmNVSnpOVTIzNTZiUWRpRkJQaWlSbHBpZ052?=
 =?utf-8?B?WXlReUhEdWJobkhHdGNWOWNCN1hkazdqM2s4ZGUrZUo4ekYzeTQxTlo4TGh1?=
 =?utf-8?B?NHpZRXhza3hCclhMYTZJQ3AvQ0hLMm5WamwwZzJkMmppZ3hwUitwelRVckx2?=
 =?utf-8?B?b29uYnhCZlJxcTMyMmtVTEprd2NWdUFRd3krc3kzV2dXTVdxOUt2cDI3VlRR?=
 =?utf-8?B?RFNiRFU0cDBpeElMRldRckFvT091Q3d4TDhpc2dQcXpIeG1XQWtYMlZkd0RM?=
 =?utf-8?B?cmUvU0xFQ2JNMkVXMFQ1TGJrdzZHMlNoSEtBeUdPdzh5elkyb1o5VnR2SndB?=
 =?utf-8?B?aVNhQ3hWOVRxY21yTVpsYmVMRXJNUWpCZjRObnZPSDFRRFp0djJBNEVFSWhy?=
 =?utf-8?B?RmgzbmRLOGFVeFlTcS9KcjF5UmtQb3l5UGI0ZHNLRmdvK3ZpTko3Rnp3UnNP?=
 =?utf-8?B?U2FJZFowYjFETXNSNmZ2NEdlUjd6L3MvdmFUYnhNK3Z6WGQrUGRob201Y2M4?=
 =?utf-8?B?UXZYdFh3OUpWSm5qK1gzNlFXZjA2RWovdnA5NVA5aXhJM1NuZTdnOExnQlVV?=
 =?utf-8?B?TmNEM0p1Y2p2dkl4TXUydWk4ODg2OTRhOGNPQVBtQktBSW53MkdZN1pVMWRq?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731eccb3-2cce-4979-1204-08dca257800e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:46:27.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H26kQgJRnEekCtHXK67EeD6oxAjlsSGuzgmBzt5v/ZWCqNtVY5Y9VIs9308MTnBE6DrMBDzmj9EYH5rF8sis7EXW3bemNmAWu8nORLtj9Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16471



On 7/12/24 11:30 AM, Jan Kiszka wrote:
> On 12.07.24 10:11, Stefan Koch wrote:
>> - When "CRYPT_FAST_REENCRYPTION" is set to "1" (consider security and
>>    data reliablity aspects when enabling):
> 
> Where are they documented?
> 
>>    - shrink partition temporarily to minimum
>>    - encrypt shrinked partition
>>    - expand encrypted partition to maximum
> 
> Can't we rather generate a layout that starts small and expands after
> encryption?
> 
> Jan
> 
>>
>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>> ---
>>   .../files/encrypt_partition.env.tmpl          |  1 +
>>   .../files/encrypt_partition.script            | 50 ++++++++++++++++---
>>   .../initramfs-crypt-hook_0.2.bb               |  6 ++-
>>   3 files changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> index 72033d1..9f3df4f 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> @@ -6,3 +6,4 @@ HASH_TYPE="${CRYPT_HASH_TYPE}"
>>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
>>   LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
>> +FAST_REENCRYPTION="${CRYPT_FAST_REENCRYPTION}"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>> index f943aea..e768b54 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>> @@ -62,13 +62,16 @@ service_watchdog() {
>>   }
>>   
>>   reencrypt_existing_partition() {
>> +	reencrypt_device="$1"
>>   	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
>> -	# reduce the filesystem and partition by 32M to fit the LUKS header
>> +	part_size_in_kb="$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
>> +
>>   	partition_fstype=$(get_fstype "${1}")
>> +	# reduce the filesystem and partition by 32M to fit the LUKS header
>>   	reduce_device_size=32768
>> -	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>> -	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>> -	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
>> +	reduce_device_size_blocks="$(expr "$reduce_device_size" \* 2)" # 512 byte blocks
>> +	reduced_size="$(expr "$part_size_blocks" - "$reduce_device_size_blocks" )"
>> +	reduced_size_in_kb="$(expr "$reduced_size" / 2)" # blocksize 512 byte
>>   	case $partition_fstype in
>>   	ext*)
>>   		# reduce the filesystem and partition by 32M to fit the LUKS header
>> @@ -84,9 +87,31 @@ EOF
>>   		if ! cryptsetup luksUUID "$1" &> /dev/null; then
>>   			e2fsck -p -f "$1"
>>   		fi
>> -		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>> +		# shrink partition temporarily to minimum
>> +		min_size_fsblocks="$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
>> +		if [ "$FAST_REENCRYPTION" = "1" ] && loop_device="$("$LOSETUP_PATH" -f)" && [ -n "$min_size_fsblocks" ]; then
>> +			# set encrypted size for expanding step
>> +			encrypted_size_in_kb="$reduced_size_in_kb"
>> +			# minimum partition size
>> +			min_size_in_kb="$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 byte
>> +			# shrinked partition size (reduce_size + minimum partition size)
>> +			reduced_size_in_kb="$(expr "$reduce_device_size" + "$min_size_in_kb")"
>> +			# set loop device as reencrypt device
>> +			reencrypt_device="$loop_device"
>> +		else
>> +			# continue with default reencryption in failure case
>> +			FAST_REENCRYPTION="0"
>> +		fi
>> +
>> +		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
>>   			panic "reencryption of filesystem $1 cannot continue!"
>>   		fi
>> +
>> +		if [ "$FAST_REENCRYPTION" = "1" ]; then
>> +			# use temporarily loop device to simulate shrinked device
>> +			# because cryptsetup uses device size at reducing
>> +			"$LOSETUP_PATH" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1"
>> +		fi
Why is this setup in a seperate if clause?
>>   		;;
>>   	squashfs|swap|"")
>>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>> @@ -96,9 +121,14 @@ EOF
>>   		;;
>>   	esac
>>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>>   	else
>> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>> +	fi
>> +
>> +	if [ "$FAST_REENCRYPTION" = "1" ]; then
>> +		# remove temporarily loop device
>> +		"$LOSETUP_PATH" -d "$loop_device"
>>   	fi
>>   }
>>   for candidate in /dev/tpm*; do
>> @@ -182,6 +212,12 @@ for partition_set in $partition_sets; do
>>   			reencrypt_existing_partition "$part_device" "$tmp_key"
>>   			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>>   			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>> +			if [ "$FAST_REENCRYPTION" = "1" ]; then
>> +				# expand encrypted partition to maximum
>> +				/usr/sbin/cryptsetup resize "$decrypted_part"
>> +				# expand filesystem within encrypted layer to maximum
>> +				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
>> +			fi
>>   			log_end_msg
>>   		;;
>>   		"format")
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
>> index 1679133..76ce72c 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
>> @@ -59,6 +59,10 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>>   # Path to full (non-busybox) losetup binary
>>   CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
Is this variable necessary? I would expect that if the real tool is 
available the busybox variant is not used.

Quirin
>> +# Fast reencryption state
>> +# It uses temporary partition resize,
>> +# consider security and data reliablity aspects when enabling
>> +CRYPT_FAST_REENCRYPTION ??= "0"
>>   # Timeout for creating / re-encrypting partitions on first boot
>>   CRYPT_SETUP_TIMEOUT ??= "600"
>>   # Watchdog to service during the initial setup of the crypto partitions
>> @@ -70,7 +74,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>>   
>>   TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>> -    CRYPT_LOSETUP_PATH \
>> +    CRYPT_LOSETUP_PATH CRYPT_FAST_REENCRYPTION \
>>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>>   
> 

