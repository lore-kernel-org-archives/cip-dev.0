Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D18C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:17:26 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web11.12329.1720163837321410581
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QnCQ6zy4;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9TUb65Nn9a9dSBOPy9iHQxLAFGQSK7DwgKPo9Z9y2ruc+E0AR6dm/LYUHH+XOO7Mulnd+x3wnKVPhhAVmCtvmH1nLliRKecLnJgf8oIg/42mEeQc8Ixlj815e11k197V1vSRPTbDl5I27LTYs2siROiF1bzb6OkzuflGB3Ss9CkTdq2XjSg0vkUZTorpEEEr9kqGiqr3FpM1UFyC4GbujxRsuKI5U+JomdSujZy/qMiKNG/iDt1wdlBBrWz3rwVQ3uFgoZ6GNPUv+vlFS0Nxmzzro2iGh+b+AvXgmv+1Ny0b6J1S8gNkYhJx5DViACFdikZQ0cdR9kXdm3ItuRfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRg9Sux0ye8iQbTvoDhdZ4u0CVQKyt/45C5+d/Df4iI=;
 b=oDnIYALSz31wlPtamG+Zgn0YxJGmInskWM7Sp6tSiWf76FlOMm9Qr4FAmlrA7es91XsJAR6Z3l4ZGnyaD4ayy4rM67Xb/qp1TIjJBQu7shihzZtDpBPjhJlPZqBVvi9hYnAALMH7twnXK5rOnsllSlYPz/HFY0iJZPQO4kU6EAnFDt2GqJaF5pBEdOyL2+EMYFCMFwfxud0u9VvhcH5DqwgYo/MaxDlmtxjEP7O2pD6Q+E9J8pY0J8Fs4ie+RDv2Ua+MJT5ZyyjymJ9GZoVJcpLkXiPSXK8OcGWuOOeDK+iu5F4CEX75X56KPMaWXTqWk13Wzb9y9mMWQG7QToHS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRg9Sux0ye8iQbTvoDhdZ4u0CVQKyt/45C5+d/Df4iI=;
 b=QnCQ6zy4SZ3EjR9eU7K8wLg4EHgZheG6SIXtG7YMDxKAOBdK3z1d1yGoGDLLJXF9Yowm87xPkBAEcI/yh/5euUihNp9GfOTVNCVUDY46Y2Ty5HT4k8JPjmpkW3cbqYdqnsZnaPIF9zwVMUkh6h03xAcFwa65tV4SWZ6qV/tavqL+ZbRFi/orUaLAuWXQGLP0n8BrFFiBqeKXQzt6/p57tebCQ0kNw0GMJusax3TEOAp1lltzvXQ1rKFci0O8Jsfe5eZenAp9RVy+gob6KI7XP0URnoWfAuB8h/RH1DEXjwM+4GHukULtODIjNx34wVisnZ8FuFJ+FZNmQxLHG4/ubg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 07:17:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 07:17:13 +0000
Message-ID: <6845d328-860d-46eb-90ce-b994da7c3508@siemens.com>
Date: Fri, 5 Jul 2024 09:17:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
 <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
 <TY3PR01MB1107551C9D25C7CC82540F20EC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB1107551C9D25C7CC82540F20EC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: cadb2005-acce-4f59-90be-08dc9cc27e65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WXdjdkhSUjBPckdTNnpMOVBueWY1Uy9CbjdlOUFCT3Nwam1UaXdmRENsUUVO?=
 =?utf-8?B?a3dlZWgzSmNuQWl6N2RYV2pnSWZyUUZ6SzlnRlpQdXpBWU9FSDJnejlFYjZB?=
 =?utf-8?B?Smp0elV1MmNHRDZVTys5ejdPdVJmYlNXdnMxSG5JcDIyR2R3cHkzekZKTGds?=
 =?utf-8?B?NkJJaE5rK3VvNittSHJubFlyZWs3Z0p5ZHY2ZytKaXpRZXI1ajZqT1BGUk1L?=
 =?utf-8?B?NVhOMnNaWk9CTk9YZkNkckFjRFcwUFEwdDFJNkN1ditGanlTc1NvaUlyMUdR?=
 =?utf-8?B?T3JMajBzc1dZZzMzQVZRNkErcWVXcFhuQUw1SWFEVjFiN1d1UExhUzMwREJ3?=
 =?utf-8?B?WHM0bXAzSGNUYU1vc0t4Q2JvR0VzaXJ2UmRxS05JdXJDSmxOYTAreCsxb1RD?=
 =?utf-8?B?eTMxc2E5THhISFVJeUY0cDdDdnZuZnFQS1RFeXprekVVMWVzZHJHWmVJRE01?=
 =?utf-8?B?RlQyM3ZBVUZvUVJzemM0VnNSc1A4K3paeHlFNFU1dFF6NzNTTVhWV1BjRG85?=
 =?utf-8?B?MmZlTFZ3K0xDelZsME42bnNBeVFTQWRRS3ZnUUEzOUF0MHZ0SWJHU1llYkxK?=
 =?utf-8?B?cVovUWZiZjVRTnhuT3g0MW9KOGxVeURRQXBlS0kyWFJtKysrcjZOM0lVa1hD?=
 =?utf-8?B?dUNCaWh1RStnWDVKMnNrQ1pWbVo5RGZPSldHSzMxbG1tRlVMV3Q5a2NtSEVw?=
 =?utf-8?B?OFlNSjRzZ2tHa0ZJRzE1K1hqWnJqb2FabHRlOURKakhJalpYRUJOMUxGRXBD?=
 =?utf-8?B?UVpXTFNBNjZxdEkzVjZhRWpPdmZPWjJmamUxWlpGTklsUkNmOFdMV05XQVNu?=
 =?utf-8?B?c2dFYXNKOVVjaDVNMER3dDRBWlhpa0UvUTlrQlhEeXo5LzZ6TnI2OUlrNi95?=
 =?utf-8?B?TlQ3TDlyYmZBNHlxWGNZTjg2Mm9ySlhFS2NDZ3VPVlh6WUdLK0pGQ3owM3JK?=
 =?utf-8?B?TGhUcHljZXllbWNiTFhkK2wyTHBZN1ZWbm51WnZQZ1BCeThnOVBxSjJqNy9W?=
 =?utf-8?B?NGhiVVFuY0dOc0svMHJVNEh2VDhyYnlXTnRrWVVRWktwK0JPVWtEUzFHRTlO?=
 =?utf-8?B?dzA5RDhMejB6eGptTU91bjlOb293dmxXZWZzUzlZR1pLbllyVWU2blBQdTlq?=
 =?utf-8?B?UUtHL3NpbEV6S1VpUkxLcnlrSkhPcEszc3hvOGZpMU5GUmMxU3ZNNzlIS0ZB?=
 =?utf-8?B?ai93RGJuUy8yN1Vka0NwWEdKN1hKeW9sMTAra2lLd1pPbFByaWwwVklyRE4y?=
 =?utf-8?B?UkxScTVacEpvbGxHSisxZW8zODNvM2p2UjQ5em0rUDVsdmNCK3ZMWUdqMjB0?=
 =?utf-8?B?d3V3UFZrMmcxUGhuaDBVRW4wMzh5RkdMSzdtTUlYb3A1L1AwWHl2RWo4WG1p?=
 =?utf-8?B?aGJuNW5za3drRElEQkdjei9aN1NqUnRRcEhiREhnc2k0RFRhcHBPTUltMExj?=
 =?utf-8?B?eUU0VG1takNGZVR6d2FITE03RlZsZ0N1cXNGSnNtUEt2K2R6M0YzdWFyV3Mw?=
 =?utf-8?B?Y0dWTk1iTFlSNzkwS0pjeFpKR0tZR3VlMGdNWG9EZEN3d1dDMDY1Y211WWJm?=
 =?utf-8?B?RDJBVEhCRHJPQmMyM1JmYWlrYnVGOWJzSjJFMWpkaHVuYXVucTAxQ3FnUkRG?=
 =?utf-8?B?K3FDOFIza1NJWTZ4M1loWWJ4MHdTVzBOOU5EczBwUjlIOWhqb3Z4NlR6ZGky?=
 =?utf-8?B?Q2lrN3J3L0JkdUwxVkJmV2VwQjZNb3hJaWF5RkJDT2hoVXc2OStTdSsxcWVY?=
 =?utf-8?B?K3c0SWtSY012U3I3V3NNeUlFdHhrejEzOFQxTTVld2RCU1pBejkzenZYUEFT?=
 =?utf-8?B?eTJpNVFseW1aQVVwYk5tQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3dNYllKYmxzZnVibmhtZUhxalZiWnk4M0hhYXBlZXRvTmV1YlViYlVxNWw2?=
 =?utf-8?B?RU55VFZpNlNvL01UNklEMDZGY1d4Uk1yWUJxM3ZnQ2NSTzQya0pzTFdOdk1z?=
 =?utf-8?B?TGxSZjBLZ3g1KzU2Tk9vOERyV2U2a1VqY0NIMlVkTkZ3UGNIWmdQVE9LQWwv?=
 =?utf-8?B?TzdGeHVaK0c1SllYTTVZU2x4NjBiK3BJR202SnJOWlRkNkludWlReTNEMGZS?=
 =?utf-8?B?azdENG5iWW13cCtZYS9iRmxiS0crTnFFTTQyMS9BSDZNMWp2S0tNb2tZdkJ1?=
 =?utf-8?B?cTFqSjI5WEh6emdjT3lqWXZvVEdhbWxFYWVYcHM0bnM4VkhJT3dhMExsYWVr?=
 =?utf-8?B?WFZydE1BOVNUc3pNbGpZNzNZNjdQUTRqV2xnU094cllrUkh6NXR4dmFVY1ZO?=
 =?utf-8?B?alM1U09YMmZmUklHMzNxSzJNN1V5RDVaVWc1NExKUytwQjcyV3NvVFRuREgw?=
 =?utf-8?B?WmpoWUVWN2RGcHlOU1hIcnhGQWJGM2JHKzRxYnU1VEJ0NDA5VEJuZStvY05J?=
 =?utf-8?B?Mnl4WThFTklwNkZZcEQzUTc3cEZtYkJ6UktvYlJnNEliWE9uY2ZISGZIU0lz?=
 =?utf-8?B?RG43TlB0SjkrTGxQY1J4TGw2S1d5TDJ0a3ZkcVpkOHZlMHAwb2ZQVE9BWUgw?=
 =?utf-8?B?WkgrWTN5SWpYekliL1dFMjUvOVFac1AxMXRsRFpLZXFrQmpaTlQwOUxMS0Zu?=
 =?utf-8?B?cEh4NmNDcHRpR2NBY2xzR2tFalBZcFdiZHhYVjBkdGZ5N1J6TmV1eVFwMDFB?=
 =?utf-8?B?U0VPckhlZmxwc3JNTU4wZUEvcXdDUk5WOXJjNTBRTFZuMVd6YmtoMU5yUnZE?=
 =?utf-8?B?YTBVMFdqWU9LdTEwelBoQmlNc2VDWG1sVGxYYks4TUtxbnp4T0Q0aFNlZlpC?=
 =?utf-8?B?bHA3S2NNd1h1aHRQUjFNZ0tvdVNtVy9yRkxMWksyN25mNm5IUGNKNVNyR25v?=
 =?utf-8?B?bDhrbHF5MmQvMU1BK29MS1pPNjFsWCs0cDIwbTRaeTBTOWpIU28zOExvQlov?=
 =?utf-8?B?OUxvSGc4WU4zMk5jQlEyYkdLeUxPMkxsRHVaUTFMYU1qWVlQLzVkaGRSbE1U?=
 =?utf-8?B?RWtPL24xNnU3UjJ3ZlF6WDJzRVYwMG1kTjdSUU9DYXl3aitkZ0dwZEZ1M3Bo?=
 =?utf-8?B?d0pZcm1lWFhJTVdzU2dNNnBMUEU0MW5jenJOT00xd05uTVIvOWNjYVphTUZp?=
 =?utf-8?B?QVBuRVY5RTV4WVJhRzI3anFnWm9WeHVzSFU3YXF3am11V0J6WkdnSDJMcUph?=
 =?utf-8?B?Nk1Ld3lDVmRKM0xIRWpOdmtpTXJHN2pXbEs5ZVdER0FDcXFnaXlsZUJEWmxm?=
 =?utf-8?B?NkZpbU9KcUU1ZDRsTWEyQ3l5M3JHQXU4cUsxcnFLK3lGN3FMaXl2bkZMRnIy?=
 =?utf-8?B?bXUxWnRtb0YyV2FtWStOcnd3b1A3N2JMSU1lVnVoaW9QT1I3SWd6R1haNW9F?=
 =?utf-8?B?d2xUVHJ6TEdBYUJpVlhQZ1A4RVZ6Y1dSVzVlNWs0aURrQnRUaksyS2IzQjh5?=
 =?utf-8?B?UkpzbWdGUXo4WnMxeGpKSXoydnYwajFWNmtDZjBxcFZ1UGZ3d0hJSWh3K1I1?=
 =?utf-8?B?UGJPODhkR0hPNnJTTXQ3M1QyaGJpZnUxZkduSFpvU1RKY1lkRkpmQS83LzJ0?=
 =?utf-8?B?U2toeWdBSlF3SmxIWGFSck1HWTFzZmRLTFVaSUFSeXc2SXB6VTdnSmNOcGpG?=
 =?utf-8?B?MlByd2c5MDUrc0tFMytRN2F0blVwSmJOL0t3ZWdsOWowYVhTd2lLeCtqVnl1?=
 =?utf-8?B?L0VsYldNQ2N6QmZ5V09LK3NlM0YySzJnOEh5aitrMC9lZ0xsMnhjQlk3ckls?=
 =?utf-8?B?MWp6SkxJZXBKUElRdVFQelJUSnpBZUVjN2dKekdQcTZRN0pPRlhCdHRjZUMy?=
 =?utf-8?B?SGU1V3lJRjUxbUJ4RTBsRG5naWpsUFlINXBBek01Sy9PSjFTQ0pQVVpIK1Q4?=
 =?utf-8?B?RU05SW5SMEtpbTBoa2hsazFKanNKNTFiSEFWSEFwNkFSQURtN2gwazM0SVFw?=
 =?utf-8?B?YXcySlo5ejBFNUszcm93cTVGZUFxWUtaN2lZUm9xdzA5RTNnUWpSUFN2NnI0?=
 =?utf-8?B?cU5iZk9UWDFXdzRvamh6ZW1wdFRNSEppbytYSVdzUE9SZi9JRzZsWC83Ky81?=
 =?utf-8?B?MGZpOVZid3AxQVE5OUhpUWNYTVhxdi9vZzRDZ2E0dXFIemZpeUoxWWd1QWVI?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadb2005-acce-4f59-90be-08dc9cc27e65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:17:13.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZa21PKBslNl63aQdJxUcuSNQhQA6jCmDJYkszpN6pJll0dP7xpRKet3g42pjCgLUF6w8Wl7tWTOLQZOtOKyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:17:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16384

On 05.07.24 08:57, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> This is by design: We do not support secure boot without SWUpdate. While is technically possible, our recipes and conf files are not preparted for that. Therefore, you have to select SWUpdate first before being able to choose also Secure Boot. 
> 
> Ok, thanks. It is clear now why secure boot option is not showing in Kconfig menu by default.    
> 
>> Ok, it's getting clearer: kas/opt/security.yml includes kas/opt/ebg-secure-boot-snakeoil.yml, thus already enforces secure boot while 
>> the kconfig menu suggests that it can be disabled as well. That should be fixed visually by selecting secure boot in Kconfig.
> 
>> Now, if you enable (or select) secure boot for the security image, you include kas/opt/ebg-secure-boot-snakeoil.yml (and 
>> kas/opt/swupdate.yml as well as kas/opt/swupdate.yml) once again. This looks redundant but is actually harmless because the 
>> statements in those kas files are automatically de-duplicated by kas. Just check the effective build/conf/local.conf.
> 
> Understood, then there is no issue if it includes redundant yml files as it will be handled by kas. 
> 
> You can ignore the patch, sorry for the inconvenience.    
> 

Not really: we should still select secure boot from the security image.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


