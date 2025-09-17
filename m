Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FACAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:43:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.45])
 by mx.groups.io with SMTP id smtpd.web11.18867.1758102186717276571
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 02:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yriH5nK3;
 spf=pass (domain: siemens.com, ip: 52.101.70.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJXNPW97uCGzTVD6OMZVzsPqsCCv9yswebKbU0ZIysIaAubMk11ah5LfYXWauu5b1Zfny1mbr6yZ2YHUVAP4M7C56tpxGwVTR1KnF7c+fLujqc669IVr7boGz371VC8cVQmacAK2gqx3u//V3LTsyIrjZJsptc713SyJp/W5AqpY+8YQCpv1BZOMWNkHCvWYYDPFe+2NgR5wDWvJxHUnTQyiZ+1PclYiDVhNFMtFrLDfeOUJaV6XFvwGZJ9ybs1U2hHFNry39HtPzb9YfeZImGrUCbfzLchTrXx+PrAsYuHwqOw8RTV8qkJqqna2LJo/0hbTXZunEnYBIVVQ3nJNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr7bBESbBYqn4+l1ds4s9ImsqVphIFD6kcg8Cwdj9I4=;
 b=dMlurJvHUJ5e5SCuTy2GBwknCX8V3p83Xl6fdnQmrBhIT3bvvQDPPVtkH4DE8Yco+uACIYWQedQBJI+0ME40TxdIQ5YoC0Q9Rl+DanF8zfFHKHvaKNebt3NMMhl/Yph7EXq87eMktj8JV5aWOr0EbUsBXJK6ILt2OeExfoqSBkmBnrCIK25frnzV3nQ+8tZRgxP9mRvkxWn3eDO7U1/1306oQ3wvDRZofyh3SAugzzICsb3U9KrNSeqRPxHjJtGtFyhMp1zSeWLFx0N7QMU4isK+gIH97ZuFTzN+cYRYwj04z8pefnLCn7Kk+j9+c2PlIUEnmSCIy0I4KbxOIoUBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr7bBESbBYqn4+l1ds4s9ImsqVphIFD6kcg8Cwdj9I4=;
 b=yriH5nK30FdZ2ZBnBG40SZ03g3K0j9beve/ki9+NiRBvi2rbJs4Kgg27Nl7Qs64U40n+NZ/O0Oz0ACSrETmekogD4cDdNSJg6o7FnkRReraKIxYR7eCOWtUA9RGlLMZhBhxEbvOzKlaA+Bugey06njlKaLZedN+Gs5NKQxM+gktveJsqpryUm9MYUnEWFr8Kbl//15jm0rEhIY0hM4lQo8YxXRgz5w/ZXSV1Pu43nliCawOFjevmONDzO6UZaPTHI/qsZbAYxecf8agIXSK29YsR1aLBtZ3DjN2Gvk8p9ydk4Z8wEJk9LgekkelDZHyM0IpPEd6Zik2HeUT0Y4ZA7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by AS1PR10MB5721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 09:43:01 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:43:01 +0000
Message-ID: <ccb1b278-044a-4a95-bb78-67ebca612ea3@siemens.com>
Date: Wed, 17 Sep 2025 11:42:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/3] ci: Add job to build own
 lavacli container for tests
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <cover.1758096066.git.jan.kiszka@siemens.com>
 <f8694e5ba24ace2dafd4df9fa859e0395d932917.1758096066.git.jan.kiszka@siemens.com>
 <TY4PR01MB151279869A438BB0BFE882D17B717A@TY4PR01MB15127.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY4PR01MB151279869A438BB0BFE882D17B717A@TY4PR01MB15127.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|AS1PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a814cc1-9a97-49aa-937f-08ddf5ce9769
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmNHaU9wam8yS2JoZmVmL2VDdUJnblhUdEExUjdmU0o0NU5tanB6Z2Q2eFk2?=
 =?utf-8?B?dDU0ck55VUVIS29VSXF1NUIwNk9rei8vTjNDZ1pyYVFxOEtVNEZNaEZ2aWZC?=
 =?utf-8?B?REFkR1NPeU8wbk5LNFpQNGErby95ZWNwaEJCMWtDK2tIeVlIdTEwYTFSOEVL?=
 =?utf-8?B?djVhU2dMMnFOUGJ3Qm9kRmNaODl0K2xkVThoTjJGUEZyaEZ0UWtTOUhjSHpr?=
 =?utf-8?B?eTQ5T2VreFAyNU9wZk5qbkNsbUFUYWFNQlpvMW1peUVyeG5zeGQreFdySUhm?=
 =?utf-8?B?a1d3cFRGQ2NOdVFEYWttWFdoOS8wWWxDUDZoL1BpeVl5d2dsMHhVNUoyUUt5?=
 =?utf-8?B?Z0E4Z3Z0dnVDTEFlN2ZESTJnRXd4aDJBMGlrYklycHBEU2gxR0ZnUDNLaldX?=
 =?utf-8?B?UFVJN0lzM1hjU0JxeXF5T1oxNUtmUHBrVGVQWXZYNlFaVFo0YkhaQWNpcDZa?=
 =?utf-8?B?MmxUVEJXTkgyWUltV010Znl4Q1FCeVJHdHZVZGVnTm1mTFE2Q1Y4QnQrRHhw?=
 =?utf-8?B?UkpoYU0vTlROTHRRVDB2U0xRRkM2dldOQ1ZTVzdLTitMRUhOYnVTUmtpV0dL?=
 =?utf-8?B?UUdtWEVsZVhIQ256dWxtM0Fkc0RVY2tpVTNEM3JsMW9oNWRBQzhjRzZEK0h2?=
 =?utf-8?B?ZHE2bmtxMFdQak9UTmtzMXBYM3ZoK0U0WlBBMDErTmJ2VnpJME13UkxLQzJP?=
 =?utf-8?B?UVhlUGx6ZVBuV01lWFMvalZDUHdVSm45eFI5VjZpbHIxSzRxRVFIN2dLTXhr?=
 =?utf-8?B?V05ka0FzM0tLOEtYd2I2SFBhb3BoblAyR21Za1V3Y2xWUkZ6UUZPalNocjM1?=
 =?utf-8?B?QzBLQnc3dy84U0xQbHVza1JRSVhLTC82UW51MzlUZzcrOHN2bVFxUDA4RkQr?=
 =?utf-8?B?Y0k2RVNlSnVnR1g2cjYxeGQ0QUoyejRSOUZlci9lamN6SlZDU1dOT1ZyNlg1?=
 =?utf-8?B?SXNuVTVkSHZjUTlHSnowS1UvaU5RdXhpbnZhWWtieHpVWm5vRHY5Z1drZlR0?=
 =?utf-8?B?SlhGVTJZbit0NjNjSHFqTW5HcU1jVGduUGhiK1ppWGd3REFXWWZhZEpnRXVy?=
 =?utf-8?B?YXZpQlJtSk1oVnpZdzhlMmJrZU9xdTkvbGcwOU5BbWJyUGIwL1U5UnExb2pB?=
 =?utf-8?B?RWY4R3hLN0hkYjFLUDNXOS9BM2k4clhnZ09NLzF0ZGwyZ3ArZnpBNkpVNUZB?=
 =?utf-8?B?SE1lR1UveDcxQldGdFRrQjNPeE40R2NncnF1RCtHQXRUVUlwdXlaVEhtSkxN?=
 =?utf-8?B?MGt0c3Q4a3YvdlNZQjZiSzc0Z3hTVTZ3NUx3WXRPMVNGelBaYkVhTFNxLzdB?=
 =?utf-8?B?SnJrUHVvN2E3a2hCb1ljVEo4MUErNjArSW9WY0tRQTFta0FXU29NYVIzdGs4?=
 =?utf-8?B?c0pEZUl4Z2k1Y1NFZmVpK1lPL1BwZWtPMEovano1K0UyWFZTODJCVytTd2pX?=
 =?utf-8?B?MUEyTDJGcVhWcFJrVG0yak0vQ2crUEdiUVZpMkE0RXNSaEduMUZ4ZE1oVDhZ?=
 =?utf-8?B?YWtsaXRQNkxtZVZ1VzlHa2tSdGFiQ1Z6UFk3MWtoV1VVRHdpZittMEVEczJS?=
 =?utf-8?B?Q0FoWmtqazcwQUUxY2NnVjhZc3k5VDVBVEk2QmVidFB4V1ZrNnB6T3RTNXFD?=
 =?utf-8?B?cndMVFpIKzB6ZWJRUUI3ajNPcWcyWkZDNUxBTkcvK3NQV0dDUjFlUWtSdjBU?=
 =?utf-8?B?U0dXLzM5ZHQwWU5ScEFMNlVMNFhiYXlvYjNxTU1sR1lLYU9UKy9QcEdBU1NT?=
 =?utf-8?B?bEY5M3NWOHlBZngvcnZFdE80eURBbTFqUjNsamU4cGkwYWJiR3hIZXB1UDJV?=
 =?utf-8?Q?doLXRyj/3xKi4EV8FTqFnFnGPy3nmlJfNMdtQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnN3RFdtTzRHYnlTY0wrVHcvNitRa01qNCtLUUFTdEdQaU5mTTgxTEcyaENL?=
 =?utf-8?B?QlBoa1pMRkhFalMwTjVZcXhXZGJvT2t1ZTVXNmV4S1Uva3FIc1krWVFTbjhP?=
 =?utf-8?B?dWM5Q3VkU3BJV2dtMTNpemNtLzQwaEN6R2YyazJxKzF0UitocytNVFdYV25n?=
 =?utf-8?B?Z0tLUExXTjhZdTFMYVkwaUo4V3FVVDVsQmpQSDJMKzRrMUg4bFVmYzBkSy9r?=
 =?utf-8?B?bjBpbHZDTnBwVFN4TjluZlRId0o4Zk1BZlAyRDRpRUNFSlNxT29lckl1elhG?=
 =?utf-8?B?eGFzcVFqWkpXZmtscEpTNjk2RTl1OHVRTVdxSDdLT1dBUEpvRFFscWVCU2s2?=
 =?utf-8?B?SDF5NndSY29DSFd2SktYdmdSSlBvSkxXaDhqeTE1cnJ4d0diczJvMUxSRlV0?=
 =?utf-8?B?ZDl5NG51ZWduUVNZYmN3ZVBxZm9NUlhucWNzMFBpYUoxY1lWdHhDVngvajJr?=
 =?utf-8?B?bW1GUVZ5VERYRGtDdlJMUURPalhKazhQUndwVkxSdnljcjVuazFiaXZIbVdC?=
 =?utf-8?B?dmZnbDV4SXBLY2Z0UERUaUF2UmxZWXJsT1VuRmFsdXpkYzVEZ1U5SFg3WFA2?=
 =?utf-8?B?Y2EvWFFPRnpmaE5NbUkzRHNlMHdKaDhaWCs3SVJlTFdNV05Lb3ZZZUkxeDFQ?=
 =?utf-8?B?VkFvelJUQWtiZUlwbEhtSFo5dDh6MVdoeUxFQWxSYXRnSjZNVHRtYlB1M1Jp?=
 =?utf-8?B?V0ozVS9yTXVtL0p1V3Q5QmNHQzJ6TElkdm5Ud0JwVlJyV3MwSzVYaFdVUjFF?=
 =?utf-8?B?aHVML21NblUxZ21iU2pkQ2JoMWxoZGdtTmJlbDZQOHludFltUUxrMnNQaU5N?=
 =?utf-8?B?Y283K2c3NS9sR240aHJaTWZqNWd2Z2phOU5JUFdNcnFxVHludE5xZFV5V3Vo?=
 =?utf-8?B?Nyt0MHpRSnM4UnBCcXhReS94d0VBdGpkTkVud3JhUnZrUHVra29sU3g3KzlX?=
 =?utf-8?B?ZlNCNFFpdnZQVUlHejRHSTVZeit0YmxXRkJBemFYUFBwUUh4aWhrYmt5Um1N?=
 =?utf-8?B?cTA1VU9ienhHQmd0R1NCUDVrbEFER0oyb094a1pIR0NQNTMyT0p6RGlQYkkx?=
 =?utf-8?B?aHV1TTU2TUQ0cGduY3VvbHNoN2hIVmRCM3pTNGxwWXppRU1RQXh3bnEzZ0VN?=
 =?utf-8?B?cldlelFhYWxMMVRYTVpHZFJuN250UWV1U0dXYXhLemVBYm03RXYxaGUrYldG?=
 =?utf-8?B?Z1MvMVdIdDBJd21jeGkzaWIweEVmSFVzWjB1RnVadkxCZUZFL0hNeTlXRnV0?=
 =?utf-8?B?czNYQllDdmU3V1VVR2FCeWVjaGJLbytoUlBuVitUWFh5QURCb3EwS1hFRTNq?=
 =?utf-8?B?dEVVbXZ6Z3ZjbUc0bklYcS8zd3IrbzBhcmUzQlpSMkFtV0VRN1MvK1UzY2sx?=
 =?utf-8?B?Mzl5WDZ1UkZZUU5XcW5XNkYxVFhaNGZkQXJ5WHczbFlYdnBHODNwKzBNcSs4?=
 =?utf-8?B?NEZqMWJsNWV3dG1nVFl3TWgwendiblp1TEhGTFF1Z2hHZnJKdERITWw3NjZl?=
 =?utf-8?B?dnRCRjFBNUgvNkZTUnQ5VzhXbFk2M09UbTVvWnZGTTFxR2MrUWtPYmx2VEE5?=
 =?utf-8?B?dXM2enhFWHY5TGFYNDRnZTcxT1dyNDhiaVE0UDVmN1lIN2VPaktKaGlIUlM2?=
 =?utf-8?B?ZGRHTTJMbE1EMmxiQ010RWlvS0p4bklvTTBhWTl5dkRjVUxXQnI3cmFaTnhB?=
 =?utf-8?B?VXJpNG5WNUZCUVFpcG1pWHd0cXEwb1pWc3JYa1Uvbklpc1dhNjdReVVsNHQr?=
 =?utf-8?B?YUNuM08za095Ulkrckc1dnd4bzQvWXFGM0ZEblp0d1BuOU50TmpNSDhFYVNC?=
 =?utf-8?B?OGtDaU5sbEhuQjBGZHRXVEUxaW42a05JcG9yZlZMT3VkanNPWEw5WThQNU1N?=
 =?utf-8?B?dWRqTWZTd016WlBhM1lXNVVnLy9QT0NPL1M2ZUhzMW55M09zWEhlYWRTYlky?=
 =?utf-8?B?MHdFVVNLWjFaYWpyT0NaQnphTDRkRU41Y1N6by85SG5uSWljWkY2U2FrYVhR?=
 =?utf-8?B?UjRrKy9nUjBUdHpKZVNaMVoxNEw2dGhTU1ZGZEIzM0Z2b3F5WDBTamJ6bDZW?=
 =?utf-8?B?dllrWHBzekIzcWJNS21OWE1YTmFNRXpEVTdwNldab09TV2Jwc3hJcDlSd2NZ?=
 =?utf-8?B?MlNnQVhCakVmZjV1YWgxWlhzNUxWV1FyQTJiOFM2TklRVkZ6NGJ1c0NMaVBW?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a814cc1-9a97-49aa-937f-08ddf5ce9769
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:43:01.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPbwmt7/Z5gWnYRroZFc9U0VIm1wkx1GWcB4hgyAFLdo3T9GEqqvGJ0dLz5Q9Kpozg4LSfPcpkWwFpBFpmMqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5721
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 09:43:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20073

On 17.09.25 11:36, Chris Paterson wrote:
> Hello Jan,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: 17 September 2025 09:01
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This shall accelerate the startup of our lava tests by using a base
>> image which already contains all the required dependencies. That image
>> will be re-generated every months by a scheduled pipeline and stored in
>> the gitlab registry of the isar-cip-core repository by default.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .gitlab-ci.yml             | 13 +++++++++++++
>>  scripts/Dockerfile.lavacli | 17 +++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>  create mode 100644 scripts/Dockerfile.lavacli
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index d951e160..de082272 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -674,3 +674,16 @@ cve-checks:
>>        - cve-reports
>>
>>  include: '.reproducible-check-ci.yml'
>> +
>> +lavacli-container:
>> +  stage: build
>> +  image: quay.io/buildah/stable:v1.41.4
>> +  tags:
>> +    - large
>> +  before_script:
>> +    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD
>> $CI_REGISTRY
>> +  script:
>> +    - buildah build -f scripts/Dockerfile.lavacli -t
>> $CI_REGISTRY_IMAGE/lavacli .
> 
> Nice. I haven't seen buildah before.
> 
>> +    - buildah push $CI_REGISTRY_IMAGE/lavacli
> 
> Normally I'd worry about the "official" container being overwritten by development branches pushed to the same repo.
> However, I guess you're protected against that due to this job only running via a schedule.
> 

Yes, it should not collide with running jobs, but even if it would, you
should either get the old image are already the new one once the latest
tag is moved. We are using that pattern for a while in
https://gitlab.com/Xenomai/xenomai-images.

> 
>> +  rules:
>> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $LAVACLI_CONTAINER'
> 
> Maybe further protection could be added to only run it on the default branch, but probably overkill as you will already only run if $LAVACLI_CONTAINER is set.
> 

Right, you need to pass LAVACLI_CONTAINER along the pipeline to get
activated. Same pattern as we already use for the weekly reproducibility
check.

> 
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> Kind regards, Chris
> 

Thanks!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

