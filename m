Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB1CD5C0EF
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:35 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.41])
 by mx.groups.io with SMTP id smtpd.web10.15055.1731079474505838803
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 07:24:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RR+pZPAf;
 spf=pass (domain: siemens.com, ip: 40.107.21.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D62818Thry8Z9vgsnHjdDn9nYNWVsRKJ2IqzdafLTXXUVo7SLICzZzSnkg1TUgv7tFNmpmzTMv2bLgrOlOhh/r3F3nmfTI6CZqM03ZKUPDK8A/wBwtsGL7ND/CZqe78tPtDkD77FTJoKbY642W2a1qxcT/lrvpPEy/eCNgknH9XrF9bNPKxwTk+zYQeRWEaqGMoVjEc/1IcsNPJdnI2DqyV3lN/oer1szdzlR6zjrr9MbM/hulbDL7MjkRvQxpTTH6cXljRnVw6kiSOBMoELa69h1uqgVrpe0WSgHkOizPDW7h3WC8+YuU/N6IM+Wd2z4krt/EhQC58Om2mRupn7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TogS1Uw9pnQ7j4qxXFtw/BRuCP14zJEpGc1GkzmI3Sg=;
 b=NoA/jIvGGOsnpSoEprkd48HC1Cx0maE+wypAusyRCpD2rOGhyl21xGfeZ4p1313gfTesgK1+p0mSQrB8cKc4VKy7PXxAyHKW+1t1bI8Ty8PH9dmSoI8t1H4lLTyIrtGFD1hCfVBlK58pH8VtQJXz7oKUOOfQmGccNP3EFLi9qb0zehshr06dIr1O+4Afan3+Vy1Z8LX5HY/klTcCXzkFiKdiO7A3vOrOEjh0gLSgmZCyR4xUOIhRfjEMZI1aOMEYwaHxDyv0IE+FTajSOeo9iZz7u40Gcb2Jg5vfRH3oE2BJK6d47bc/XKqZE4FR4rnLfWlYwy2w2zAOf+ZwWUYE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TogS1Uw9pnQ7j4qxXFtw/BRuCP14zJEpGc1GkzmI3Sg=;
 b=RR+pZPAfdAGCg34eM/EYlnjk7liuH+h9H9GjyHO1t7pEOWpfKesMxXGNt2DutkPo+vQVDT/MePeZqHTUvpktrRznNjQT2JyRo3iu0fXP6yGx/Uk8uQbVb3zkfOHd1iEaLMAyYvaae19v9MN0Kl+EV+7ys17z/yfN40dddvTl5m5wtVp0/fhEZuw7vAbcM2gM9bXndzrHeIxOCmXYDVecDefTWbMbDOlLFOiBPS8+EDwfLHsK7xjbUvvqHn6OcAu3/I0wI5AOKfwCx7s1tV4mZ0kWX5rFbW5Y22Fi+8legGSy3C5RRJf9UbaI3RFfNx7+7Ucaw3q8zFC+3GkLLDBbwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 15:24:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 15:24:29 +0000
Message-ID: <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
Date: Fri, 8 Nov 2024 16:24:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
 <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: be499d98-abbf-441a-cd23-08dd0009706d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enZUczB5VVl1dXRjWUpNSFlwSkx1dDNhUXBFV0xTREFPZXplR3FXRE9BMjhi?=
 =?utf-8?B?WW16ZHZHV0ZQQk1iRCtZWCt4M3pCcE8xcTFxbEh5RGVyekYyeStQVVlERnZj?=
 =?utf-8?B?emhBUjVxUGFPUFB4OXBCQjNSdzc2M2lXZHArbHQway9sbWFxSW84dHhnczcr?=
 =?utf-8?B?cWdmczI0Vm5CcDhRMm81ak1vbHFtelFLOFJpZzhCOFBUZ0J2WExDeG9IUWdR?=
 =?utf-8?B?Ry9yTlBSTzcwUmhxY2lNQ21LdjdkaE1nQzAxQTdKdHFFWEpjdjVDQ3ZHNEd6?=
 =?utf-8?B?blYwenhXZks4Nyt0bWVQODJERDkzYVlEUUtJWnMrR2hqTThKQVNaQ25NZDJp?=
 =?utf-8?B?SjFmM2lnNW1ZNkJOeXBEWGF3dFVGY0tUSTdyVjBQTEFkTi8rYXk0L3l1UFlh?=
 =?utf-8?B?UjV2V2o5T1dBdzIzVVAreUxkQllGMEQvVUZqVmJ6UmVSWjYvbFNzcms0bkxQ?=
 =?utf-8?B?OUluNDV4Z1dIMXAwVEhhL1VCazRwdjhSdDUzVVprdENUYkVSVkM5RDF4QnZO?=
 =?utf-8?B?RlV6Y3l1TEJiQ1RHZTZaUjBsUjMzNzBrWDVWbjhQdkN3ZHRRanRxL0FhNHlX?=
 =?utf-8?B?NkZMYlhONVpiUUp5L2Z3K1NqUWNIZWU1cGtxWFZjcFhUQmR2dWVySlpIR1N2?=
 =?utf-8?B?TFduUnp3bkVGTGs5d0hIN0dGdDk2M3ZsU0xVdmo0c2V5T05YREpOZ1FKdmtj?=
 =?utf-8?B?RkU5bEJtbWtzV1BTRnlST1ZyT3phL01hRTE0OUZ1N3AvdWFPMzdPbm93aUJ0?=
 =?utf-8?B?UXJ4bEtFOEpNdnlxcEsxeHhNb2Q2TVNRMlFxbFliMjNRTWp4NXFwRFNGaDFP?=
 =?utf-8?B?QnZqUkl1dU5mK093QVczTWRza0FlMkZGcXJhNmVmbkFOb2VvNzcwZ0ZBL1V3?=
 =?utf-8?B?R3gzYUxibG9xKy9VYnBQTGZFNi9Ea0VjeVNIVlNDVldabnQySGxtNC9QbFVQ?=
 =?utf-8?B?RGowQ1FvaktHQjBkbHJENkQzSkFUU0ZKbXdUQWgxdi9uaVB6YVF0M0NBUkV2?=
 =?utf-8?B?MHN6a1lkMnI4dU1GME0rbEVDeDgvdndocFkwbU82bUF6eG0vb3FUODJ5QVRp?=
 =?utf-8?B?ZENiZTBibDMwTEc1M1BKWDhlaUhleFU2MGlQOWQ3NFVRY3dBWFQyUVlEWGp5?=
 =?utf-8?B?MjRTb0lZRkp5YWxwZWNOeUczamw3UkNnUks3eGpURzRBSmhFaEo1bldySlJM?=
 =?utf-8?B?UWlHbktOcjluWXl1Qmk5MlNRZ1R5K0pZbERsQXBXd08zUjlXRHUzVE8rcWYr?=
 =?utf-8?B?dFRXWWJEaUtDbXJ1MnpONG5waWl6aDI2Mk5HTnRRK1lwaWk1aDRwb0NrNjF3?=
 =?utf-8?B?TTlXTEdqakppWFBETCtVSzE4dmVEYkdMazdicURmTTZZcXlKdUc5c2RvUmVI?=
 =?utf-8?B?amdZK1I0NEhKZ3hFMmNKNWtQNkhOdVBLN1RLT1hCNTNMeCt2VW1SRE0vUEQ2?=
 =?utf-8?B?UG84ZjdocGNyek1rQzVacDlLeXl2OXorS1lsU3o0REl0SVE0NjRiQ3BsWnBG?=
 =?utf-8?B?eDBzOWVTMmZyc0NxSG9VRXZ2N0xQMHF1WkFRUm93blpEL0s2U1BaNi9HeG9K?=
 =?utf-8?B?UzhYaEw1Ynd1Y0dRUUtpUXhLRVhRMTRwYjZVZTRwM0xaQjJobUhWT2ptbDJD?=
 =?utf-8?B?ZzNTb2Q0M0p0NmpxQmdTVlhxQkkyNkJkdy9KNHdNcXVWaEtMVzYvK3c5aWpM?=
 =?utf-8?B?U1FPUEprSzBWZ3puL0pVZERqUFJ5VmtMOXFOTDc2RytQSUJjTW5iVjNBaHN4?=
 =?utf-8?Q?kDeZ6LdKwBin3Lju4u/WRnsGyOkKKvurIGMVOl7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnhZTnVkak5lc09CR0F2WmFldFFjQlRIU3ZIRDZTWVhGWjB5OGptVWdqOXNR?=
 =?utf-8?B?bmZ1bWludFRZaEM4RnlXcnMrc0dNKzZJdFgwSGdCMUE5RlJSbXFkWXRheSs4?=
 =?utf-8?B?K1VzTkRUVEdTWW9TK3o0MVNwYTA1aUFKL2QyV1hKZ21rSklSRFFSeXBISDRP?=
 =?utf-8?B?OXRBczI0bkpicm1wMy9Ca2oyUXFDNjVTMFVmd0M5QXdtQXJhQXBiQ01HNkdM?=
 =?utf-8?B?Vk40RGI0bmpnMTVaUVQyZWJOWXZEcFYxOFQvS3hHdHJhT0NoZzIwUTJGMWFL?=
 =?utf-8?B?a1JnN1cydDVEQ2ZVTnJXb1dEaWx1NU9RWVdLdTFnbG1mYzRLalJadGMrQlpw?=
 =?utf-8?B?aFB2UW9hc1E2cXRNc0RQTXJiRXlOSWs1UmUyS2hKVE9WM090Z2diTG80KzY3?=
 =?utf-8?B?T1UxeTRlVXZDSUZNNFAwZml5MHRXRDRGdHRrYUtKNTNiNEs0NHlPWkZDZGJI?=
 =?utf-8?B?cXRBR3RZN2cxWnVHNlNGRTJ4ZlkwZDVadWtnSjFNb05YRklTTWdzQXduUHBS?=
 =?utf-8?B?Ujl3bGt1WVJ2emwxem1LRmVUZzd4dUpSdXBxNkRqMkI4KytHRUlpRnZmaldR?=
 =?utf-8?B?ZFptV3FyM2UzWUJlZVluTVM2ME1OZzVmYzFIWUpYUUZ0T2x1ZGJYTWtmckpD?=
 =?utf-8?B?MmJIZEIxVldzbFpNQVhHUWd6eW1aVWxBS0ZOOEJGY3EyYmlzUUhXUU9DeFNF?=
 =?utf-8?B?ZVMwTVFxRkFXdW03NVltcUVrdTdQWk03azJzVUdySTRyWjdUckJXZWZvTGdy?=
 =?utf-8?B?enNRbkVhRlRRanBlMHVHTEJqVWwxeGJ2YUlzSkZmNGdTUmt2ZUZiOXFRUHk4?=
 =?utf-8?B?WjFYTjJsUlQ4SFhhV2ZmUWR4ZXhoVjdIZFhvWnYyYXJVV0MyS3ROVHFpSG82?=
 =?utf-8?B?OWFId09DK0xnYjFGM1JMTDE0anFMQ1BHVWlEUjh1U1dONjNuSjlEeUNlekpp?=
 =?utf-8?B?d3pUdUJEczh1RzgrbXc3QzhLTUZibDhQK25Ja2pucjNWWjBGSXFjeFEvOUtI?=
 =?utf-8?B?djhHUHlXcFUxL1NhWXlncXBOanJWZldpT215OE51Rkwram5VSlJoTElrUFJk?=
 =?utf-8?B?TUtUU0pxZ200Q2hEN3JybG5LRGdYY1VuN1pKLzVpYkNUbkx4b2EyMnovWlhY?=
 =?utf-8?B?Yld2eEFuaGZHd1QzTzN3MWc0ODR1R0lVQzlrNXBvWVMxQXJ6MHRzcUxmTFh4?=
 =?utf-8?B?cG5ySkl6UGJ1R1NsVHhUTmZwUjlZNGVHYWlKWnhmMEk2dUhzNmoyZW5zejRs?=
 =?utf-8?B?S29zbnpEL0hVRWlNL1J0WkEzZFpRQUlrRzk0R0ZWK3JQaU11dkMzdE56TWJY?=
 =?utf-8?B?a2VHUmNIU201UGVMWTZ0WGxnVW9PVWpnZHBqVjRjZHFUUkFZMWpUUE95Vzh4?=
 =?utf-8?B?UFhTR3NZY3VOQklyNFZCbGxXTEdmazMxZHdnT0Jkc1VFZkFpd2FNMURmTEI2?=
 =?utf-8?B?SitDRWl6V3hHY1BEMTlYNGg1Z21hQkRqVEFCTmVueHl2MzBNTkQ0RnhkTGZn?=
 =?utf-8?B?VUxhemZyNjhnUG5EdHJSWTREOUgrZkxnM2pPSzZTZ0oxMEZjV3F6UnpnNjk4?=
 =?utf-8?B?Q1pGUWlhVVpialdQbHBiMWhBTXZGbkoyVms5Yk0xVVRMcy96SGw1SVlua0hq?=
 =?utf-8?B?VkhrQWNUUkhFdUxROFJXZWpPeEx2S2hyekxiOUdPdEk5Z21VNnVFcTlHUy9s?=
 =?utf-8?B?L1JMbnF3TS9yUGt5RWFoWE1taWc0N2ZXN3BWdW9KMEk1aGt6b2lhUGt2NFpX?=
 =?utf-8?B?WjE3TmFQOGNFaEw3RzgzYXJxQkdFRm42Wm9OQkV0MmZweUxIeXRSL2R4UUQ3?=
 =?utf-8?B?QkE3WVhKSjF0REEwMTBXcTJRdSt2OXJwTGlXWW9WWklDdEY3bmpHb0k5dzhQ?=
 =?utf-8?B?dE13N3A3K2piNXRvNGNjYXJ3eGNQbGxKV241TEtiZkJicjBMM1paSncyUUFu?=
 =?utf-8?B?dHNyMVpUN0ozaitVVkJMem5ONlZCVDRsYVZjZGJsR3RoRjdGMW51dEJJQTVo?=
 =?utf-8?B?VE9uMTVpdlRQcFdmMXZMc2NaUlhUMkttWHBhdVFxYWl5cXhhS3Q3ZmZjTUlU?=
 =?utf-8?B?bU83NEVyRlF4azdhS0gwR1U4U0hBaG5mNFk2M0ZvUGlJUC94QzNadytnSVdr?=
 =?utf-8?B?QlFFdUN2aXQya0phZWhWMkpkTkYvZldwMlRHRXhlUStvSExINVE0N3BlaXg0?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be499d98-abbf-441a-cd23-08dd0009706d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:24:29.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFGJgIxyb4Mc8nZkOV29MOjz2gTm1KRnaBJ1D3EVC210sRlWnmyrySDwDt5sq0cMg72M3NM8kgOr0TYTdhGKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 15:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17230

On 08.11.24 16:10, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 08.11.24 16:02, Quirin Gylstorff wrote:
>>>
>>>
>>> On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>>>
>>>>>>> Quirin and I discussed this a bit longer today: We actually should 
>>>>>>> remove the need of expand-on-first-boot to access the key again.
>>>>>>> And that is also due to an idea I picked up yesterday to lock the 
>>>>>>> tpm secret after initramfs so that we reduce the risk of leaking 
>>>>>>> it via the main OS.
>>>>>>>
>>>>>>> Our plan is now to convert expand-on-first-boot into an initramfs 
>>>>>>> hook that would then come before the crypt-hook, thus would only 
>>>>>>> work against the unencrypted blank filesystem - problem solved, 
>>>>>>> just differently.
>>>>>>>
>>>>>>
>>>>>> Actually that's a good idea!
>>>>>>  
>>>>>>> For now, also for trixie, we will just make the dependencies of 
>>>>>>> initramfs-crypt-hook release-dependent in isar-cip-core.
>>>>>>
>>>>>> I guess this is the patch [1] you are referring to?
>>>>>>
>>>>>
>>>>> Correct.
>>>>>
>>>>>> Just to be sure, still, the implementation of the initramfs hook 
>>>>>> for expansion will be in isar?
>>>>>>
>>>>>
>>>>> Nope, this ideas fell apart after trying to convert the current 
>>>>> systemd unit into an early initramfs hook. We will need to split things:
>>>>>
>>>>>   - expansion for already or to-be encrypted partitions needs to go 
>>>>> into
>>>>>     the crypt-hook of cip-core
>>>>
>>>> ad "expansion for already encrypted": I guess that covers cases like 
>>>> in VM/Cloud infra, where disks can be expanded after first-boot / 
>>>> installation?
>>>> ---
>>>>
>>>> In many use cases resizing the partition should be required during 
>>>> installation / or first boot only.
>>>> That's why, I'd prefer having those steps separated and opting in for 
>>>> either!
>>>> Although package dependencies might be tempting to combine those and 
>>>> reduce recipes + initramfs hooks, the use cases and options on 
>>>> combining those justify a split.
>>>>
>>>> As an example to point out the combinatorial complexity of just those 
>>>> two recipes and probably there are even more combinations to come 
>>>> when keeping the systemd expand from isar.
>>>> (which probably also makes sense for non (customized) initramfs use
>>>> cases):
>>>> My current approach to streamline that (downstream) is by utilizing a 
>>>> target-bootstrapper (kind of next-gen isar-installer).
>>>> That means, expansion is not a use case after installation for me 
>>>> when running on target hardware, still, when deploying on vm! Similar 
>>>> combinations apply for encryption, not necessarily mapping the ones 
>>>> for expansion.
>>>> I am aware of the target-bootstrapping/installer approach is not 
>>>> desired for many other scenarios (e.g. vm, sd-card based installs, 
>>>> ...) but it already shows a good amount of combinations.
>>>>
>>>> Apart from that, not related to the initial problem, but maybe 
>>>> something to keep in mind when refactoring/reviewing the existing 
>>>> implementation: The current implementation will potentially break the 
>>>> rollback capability on upgrades from systems without encryption yet 
>>>> in case of full disk encryption.
>>>> To mitigate such for upgrades of unencrypted systems to use 
>>>> encryption, we must encrypt the partition relating to the current 
>>>> initramfs only!
>>>
>>> IHMO Rollback should not be supported - this open opens a can of ... .
> 
> I see. Fine for me.
> Then just ignore the part below: "Apart from that, not related to the initial problem,..."
> 
>>
>> Right, I don't see that use case either. We are covering the initial provisioning use case here. Wiping everything is a different thing, and I would not address that as "rollback".
> 
> Rollback in terms of A/B not in terms of wiping out.
> 

Then I do not get what you mean. A/B only comes into play after the
first boot, thus after encryption has been established.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

