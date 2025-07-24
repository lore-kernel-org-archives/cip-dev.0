Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C1CC83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 20:38:40 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.39])
 by mx.groups.io with SMTP id smtpd.web11.4110.1753389509892370216
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jul 2025 13:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JEvwi316;
 spf=pass (domain: siemens.com, ip: 40.107.162.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoC53DoTXuuIybrM+FgVLV5CwUiof5FA82XBvV7cXUcwS1vQeoVB5zUplGIv3j/CLpeBC5yaRobSVJODZ/x/RFsCW/DvHBxRQj69vi3MOjuol5s8ZVu//Hxx/hR5MPN8kVQVjeDxEc23bcYijzaTBAufk8EQal9wzWXXbbzxBWK7SN4YY+HakJ2hoaPODzyCgQVsAtWwia8pRyIyqnuAcKq5KQ1Z2+hgL42o71MBDi7ueRkE3IvOmSs3742xsaUS8lvLM3CM2okPRAqSA2T1NM4F1FkdJ1jGTV15sardGUIjTkq1O1Q4qxPGUWW4NfiYI/oIqIWBFkC1cUCuJThs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4sr01YBLDLVjbq9qS00JhvYZsARWshAf19MrNCa1nQ=;
 b=hZZkP2LkUlWaja/t8tfDuX8A2BU2+wjwAW6+Id3SrK5Nb7HXfc1k7F2WvjRH2OrUjwahDIultfUagLn5g9PfU8RokJBeYl4eA9KXaZDWEKxj0c0Ik0eGJgqVFZMk/MUylemxJZkaXyc2elX/073UYU8s7nqba58CD7wBEoaTdg+U6UkeagfKUXZC/BMSDbGIQR7vS2NMtyy0wOBS/t9PvNZ7s2UI+9i6rbFPoy+8ughvghdA/ll/hFwnQS77PeOQu4FLkqE8BN70DFI5LmxHuTWkgQrQXErLb80CpVCQdHcjzkWIPBC1kHt+qKCLvDBSBVxRIdiaaLnTt8Grd50Rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4sr01YBLDLVjbq9qS00JhvYZsARWshAf19MrNCa1nQ=;
 b=JEvwi316+ImtBT/0I8ZtIjt1jGhVx5VqglnvzOcRVTzl0i5nMwTMCSG0junblygFF+ZmbDa9pqks/JY4KDH3pO8azGJNg/k/hseD6v1Or2TWuEmutGfw7oNHXxRMWD9lc416uzkYUCnCJV4OLsLIei/3cwaDeA24lWst4tHyQyAtGuX9RCcZg3e7ZsRqgRSPH+K7chREGmYqncsiRwKwgK0XjdAByq4LBxZ/qLjo0Ao3R9Lx0IdMR9elcy3l5CAY1YRk+zcFvMPdmrCHtGn1WCQrNR42FTW0GAfdQHeD/9Njl9QyeZhnXIzjlt+AMwxWLri0KXBHS3YZyoc1PFQbWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 20:38:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 20:38:25 +0000
Message-ID: <871fc209-a592-4fcb-bff7-d97337bdcb5d@siemens.com>
Date: Thu, 24 Jul 2025 22:38:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug Detection
 and build/runtime issues
To: Nicusor Huhulea <nicusor.huhulea@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 188eeb4b-aaa5-45fd-cd40-08ddcaf209c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MDhVcTlDSS95RmE2SW1zS0plQWZBMmRJa004TnM5OW1hOHV2bDRtWUdOSnAx?=
 =?utf-8?B?SHBzV1ZoWnRMZXNXOFN3bXZ6R3kvV2trWXFIOFhWZC9RUHpzQlMxM0N1T0c3?=
 =?utf-8?B?bnh0ZTIrOExrN1QwTFlub2VUdlhKVVZSUzR0d2dwN1dySFJJcW1NSE1JdXYy?=
 =?utf-8?B?bW5XK2Y0KzFTcXdIdnlYUTU1Q29hRkxhY0lMRmcxK3lSZ1ZjWnFWODB4aU9y?=
 =?utf-8?B?ZHBQa01OYlc2UFhZWkhWU0RvVS9md1pZWlYzUEFxblVILzRmU1pObmlYZm5S?=
 =?utf-8?B?NFUyeUV0T0wyME9LZ2FhS0N5Q3FIbEREUlYyOXNWRlZBbkFpR2s3blUrZnRz?=
 =?utf-8?B?OEhLUU83MWc4c0FYRXVNT0diT2hYcVFBUUJRQk5NaXhNeFhJZTI4ajBSNkVW?=
 =?utf-8?B?M3djc3U0S3MzaWRTSmxaaWFWWVM4VE5FNTRsd1UvaXRZWWFxRzlIa2IyY1NI?=
 =?utf-8?B?RUhJQXNMVXVRQVkrSURrL2ZxcnNzYjYxRngzQk44MTh4aWtzeTh3clNnWEhN?=
 =?utf-8?B?ZUsxdzZmckJNbi9SVXhYNGxwU0dGZjQ5L0JQdVJOR2JjaDQrdDVucFozK0Nw?=
 =?utf-8?B?b0I1aXdhQ0lmM2tCd3dsb0tRaWpoYUhvUytFWGx6b3VvUTU1cXhYQndPbFQ2?=
 =?utf-8?B?SVQ3RkJqcEdoVHdaeEMybnRBU0tvQStkbXJoSGRoZzMyc3ZOMTVNK21wa2R4?=
 =?utf-8?B?bWtsT1Eva3hzc3FsWGhVdnQvaDVMalBYRVhpQXQyeUZNbzE3YllaZ1NJQUpu?=
 =?utf-8?B?ci90NWJLZ0JWUHNZUmdubGNzR3ppZHJ3MVlNdmI3aUNHR0l3aTZNbFBncGhW?=
 =?utf-8?B?TVJMSmlqVXM4Zy9QeXdvcnFoT1RxaHFmRlRMMTc2WUg2YkdUY2xKZkRqV2Za?=
 =?utf-8?B?bWszc2hsM1RkaEM4RGprTG1GK3ovRDBuYlZnMGEzaEZNYnhKY3llcUdEMzZR?=
 =?utf-8?B?NmV2czJ0RDZzRXhnK0dDNTkxNHFjQmkveFhwU3JVUERPYUxrcnZZZi9SNTdS?=
 =?utf-8?B?d0xIOVNpL2xycklvbDZsQ2p0dlBXRDBQSGNaWEgyUWFKYXI5QTMyUm1RK0VB?=
 =?utf-8?B?Q2FLNy85a3R6OEJrUk9ERURaM3M4ZU44L0liNWw3Q1oralFkZGR3NlFtTms0?=
 =?utf-8?B?WkZhWkUxT29sMk1qcjhPVENpYjhWeGkvQlJjZ3NaZURMeFo5VHBEelpWSVE3?=
 =?utf-8?B?QS9qN1dIK0NVYzhSZXBwRk92SU5UK2Q2eU0xMEtyNG5mUk9TVUQ4dnNyVk9q?=
 =?utf-8?B?UFRaSm9NVU84RnlrZ085ZWNlTUFyaUxScEhNOE96N3BHV3ZZcGZSaHVKVkRD?=
 =?utf-8?B?Q3JDR3pNWGNaSlc0VTFvVFpPT3NZakRkWnZGMi9UZzNmMCs1dEQ3ZGlBdHRu?=
 =?utf-8?B?em1SeXdPWjhCekpuNXZhMldRQ0hSM0hkZURiQ0RHc053TDBxOCtFV3RUb1Rv?=
 =?utf-8?B?RklOdUZGc2x4QzlRYTFiVkpRbkF4ZzVkWU5qMUhyRGdmNHREUU9uS3FNZFll?=
 =?utf-8?B?SmlkYXdaeldvNWUyV2VJUVNLU05OSTlzUzY4QlQ4WUlPWktQb1R0aUIrZk1J?=
 =?utf-8?B?ZFM4S1NsUjArcUVuK09adWh2RlhrZHBQLzhtSzAyYmd2QjlVRnFSRURJYThH?=
 =?utf-8?B?UzhRck5PeC9JS21oclhsR1pBVjJhbFdwMVJMK1hHWjZwd1RaY2JLUDlGTUwz?=
 =?utf-8?B?WDhzNmM5MVF4cC8rSnpBS00vZTdpc2YyWDFNMEEzeGhxQm1hR29CajA1VWgy?=
 =?utf-8?B?ZWl1b25yeUJ5MEN4UTdXM2h4Mk1aQzNROTUrTkIyRTVnUXVhd2V3WHQ0MlJI?=
 =?utf-8?B?RGwvMEkzbmlIV2Y1N09rL1F2QXZqWFJ1UTBsVjgvZW9uV0ZIQkt2bHRUZjdO?=
 =?utf-8?B?dnFseHU4dGhRQ2ZUWFR0dS9pWVprUk8ycVdFYkFhWndqS2ljTi8rQUdoWWc3?=
 =?utf-8?Q?244aiy3m838=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGZCYjg5b1lwNFVWblZuUWpYMVlyOEZvc2ZJMk5zSmQ3Z1BMVldjRTAra3JL?=
 =?utf-8?B?WUNybGFSMXd5RmFHMzFZeG1ZRFVEU0V6MWdueTFGMUxYUjRIMVl0Mm81RFJL?=
 =?utf-8?B?a05PTWNqb29pUHQvTElCcUhXMTNvQkxha3pURDRod0NGSStDWlE1dGwxOTVt?=
 =?utf-8?B?TXlkMzJaaFNlZnZuSTRNVWxEQlpSaXozRmFGQzc2Sy8vQ2Z5cGJQYWxkMkl4?=
 =?utf-8?B?dWpXNFRYam92WnJsR3ZVdzFpeHdSQjlVZW4wOWJxL3phNXdlWXlyRFhsRjZQ?=
 =?utf-8?B?ZzFiYTcvTnBVQitTYmtjMXdhSTEwV00wVG9xRVo3cVZZWUd6cjAzWEZ0cURj?=
 =?utf-8?B?SkFsUHFYTnAzbERUZlZMY1YzamJyVGZmeCtZN3ZaY0o5T3JPZ1FodHI5eXAw?=
 =?utf-8?B?Q3p1cVhkZE82Sm55a1NRU3V5U00wN1JwYlovcVU4UGZyZ3lSMDI2STNIenQw?=
 =?utf-8?B?VW1GOHhhMHpZYnVvOVRZSFZ5Z0FtTFYrVlFlSjAvQk8xalcySDZPa3MzdGRu?=
 =?utf-8?B?eHpwY1JwVUZ2VHRuNzFidFBDWUJ0SG9zYW1yZnBkZTEwYnpVTnRlNkYwajFj?=
 =?utf-8?B?dFVNa1NaM080TEpmbEt4anFrQll2WDRvdHNBOGtiL0lsRTQzcFBLZUJmZ0ZI?=
 =?utf-8?B?Y0pwd0VWMXZBZ3ZMMmdqU0IvRDY3dW9zNE1DeUpsSUZPL2k0dnZEaitPa2h3?=
 =?utf-8?B?NWxucGE2ZWRIM2FjRy9lYVZrZFF6ay9tRms2ZjhpN1NPQkZjclBwenhZWTRO?=
 =?utf-8?B?MEhqKys2UG9Ebm83UUJFWWFST0diV2VCb3lDOFVhekh4WlJRejhPRWdROVFm?=
 =?utf-8?B?OWZKTHpYZzh4VlV2T01SNzd6cVJ4VytReVpGTE1rdTZ5RU9RNVVlYlltNUg2?=
 =?utf-8?B?VWd0elk3eGJyZ0puYW01Mzc4L0NTS2t5VmZqRW5zZkloNkNSVFhEbEpabkFi?=
 =?utf-8?B?d3grVHBLbjkzelJ0WlRHNU50NzZXZEVCOFVvdm5qZXlxOWFTR1VzZ2lReFNx?=
 =?utf-8?B?aFdiYStqMHhrdmpFTDVGYkQ0SUJadnR2TGtiaENUelczMHBsdHF6ZUFsTjE3?=
 =?utf-8?B?eXorZlNTd2lSS1I0REdPZndTTWNMK0xqei9OUENQY015Vm83d1c0NkdiMTJj?=
 =?utf-8?B?SkFNUGxZVjFpb1BtcEhLbndReWp0RU15LzNsMnZEcURqeGFCb0p6WldZQ1Bk?=
 =?utf-8?B?aW9OaU1jRFhSblZ4QXA4SUdzZUluTG9jbXJyeU5OSE5SRkc3VlBpNk5mckdj?=
 =?utf-8?B?UXBBcXpBMjdPa3N6UkZkaEJ0VlZsKzZ4NG5tNFI4ampEcmFQRnpnYXlyUTMy?=
 =?utf-8?B?eGpaS0JyTG5wREU1ZGltZjVTcWo2S1k4UnZmMWxYNTJLa1FzUTI4UGtsaHdO?=
 =?utf-8?B?eUt6YU5BWnJUQ1Q3VWYwRHpFWGZIVlVzVW5Qc2xZQ2d3a2ZRd2J3T3djQ2pZ?=
 =?utf-8?B?d1VZdkl3QkNmTElxNDFlRVR6WHNnTHM1bTlSdk5jdmpDSXBzeExxLy9xTlBS?=
 =?utf-8?B?RUNEUmVuS0l1T2FFWFp4RVhEeVExWlFCanV3QWdhOW1BSnRDQURtcmtFMzhX?=
 =?utf-8?B?VjNQdDQ2Z3JtVER3dTZ0Y3Z2SEFsa0d1dEdhdkc0a0M1M0k4UmxmQ0EwTnNI?=
 =?utf-8?B?bkQrK1FGY08xWDdsM3hwV0MwWFZObnpsYkRKOFRvUEp0WEUvSUhSM1RXKzRk?=
 =?utf-8?B?eXZGejVCMFZFdk10SEJadW93clpMcE90RUU3RlF5cTd1VkVubTlZQTJnTm9q?=
 =?utf-8?B?WEE1VE9HbVhNUkJ6Y1E3NGhRbGFkOVVuRXlXWnRqNFdpV1Exb1hyUlpkWW5F?=
 =?utf-8?B?d1dmeDZaWHJoSXIvL1BDNnM4UzQvcUExb2lRZnZHN1B6bllncnFHWmM4Z0Jv?=
 =?utf-8?B?L21DWTEranRQaW90dFpvWW5wLzlubmlzN2hLcStmdCs2dThuS1B5QVpheXFr?=
 =?utf-8?B?cFk5YlhMSVE0ai9mRUtJcHNWbkUxbDI5VnpZbFdNNnBWWUFsMitoZnJ0SFlN?=
 =?utf-8?B?V1U5K2hVVGE5aXN1am5PVHEvWjlucGRHY0NQK2U2SGVVUXp0Tkx3RW42b2tM?=
 =?utf-8?B?TVdBN3Ard2tBTDFMa05jTCsxNjFMdWdScUdEdjcwbE1uWWtFcElxZmZ4QWNF?=
 =?utf-8?B?NGhaK0tjK1NhMlNyR3BmaWluS2lUMXA5T0dKQWtFZEIwSWpEQ3FDNnpISVIx?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188eeb4b-aaa5-45fd-cd40-08ddcaf209c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:38:25.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFNVA0OUcU4qGC3o/g1XnrZdY4JHG62XQ8ZcUfHsRdhAQIw7IeGeJAe4kTx6hXrPweqor3wlJzChWIzCU4DhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 20:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19588

On 23.07.25 14:54, Nicusor Huhulea wrote:
> Hello maintainers,
> 
> This series addresses a defect observed on certain hardware platforms using Linux kernel 6.1.127 with the i915 driver. The issue concerns hot plug detection (HPD) logic, 
> leading to unreliable or missed detection events on affected hardware. This is happening on some specific devices.
> 
> ### Background
> 
> Issue:
>     On Simatic IPC227E, we observed unreliable or missing hot plug detection events, while on Simatic IPC227G (otherwise similar platform), expected hot plug behavior was maintained.
> Affected kernel:
>     Most of the tests were conducted on 6.1.127 (manual/standalone kernel build, CIP/Isar context). But it also happens on 6.1.145-cip44
> Root cause analysis:
>     Through testing and diagnostics, it appears that the HPD finite state machine or polling logic in kernel 6.1.127 is marginal for this edge case. Device IPC227E's behavior triggers
>     this kernel edge case, likely due to slight variations in signal integrity, electrical margins, or internal component timing.
>     Simatic IPC227G, functions as expected, possibly due to cleaner electrical signaling or more optimal timing characteristics, thus avoiding the triggering condition.
> Summary:
>     This points to a hardware-software interaction where kernel code assumes nicer signaling or margins than IPC227E is able to provide, exposing logic gaps not visible on more robust hardware.
> 
> ### Patches
> 
> Patches 1-4:
>     - Partial backports of upstream commits; only the relevant logic or fixes are applied, with other code omitted due to downstream divergence.
> Patch 5:
>     - Additional modifications to ensure the driver builds and resolves run-time issues
>     - Contains cherry-picked logic plus context/compatibility amendments as needed.
>     - Together these fixes greatly improve reliability of hotplug detection on both devices, with no regression detected in our setups.

What is this series targeting, regular stable 6.1 or 6.1-cip only? If
the latter, why only cip? 6.1 stable is still alive, and this introduces
itself as fix.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

