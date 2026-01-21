Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53875C44508
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:08:53 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16665.1769015323590636865
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 09:08:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WvRchjHn;
 spf=pass (domain: siemens.com, ip: 40.107.130.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy8NTfhLoFmmqNpVL3q2kpEAT+4W6Z13txNpZuLXvAS7b07YXJxZ7tL/o7nw52D707SJO/Fu6cTGCo+p890CvJu3+eOjm83GzFGWxddukm0OPUu0wfP19buYvfScm0xsNRjq2mxns/cRcglWQXQDbfwQ7dNgRXATzCEATt27T89NnrC91G2Kmb9Pwg0YLZhUFs4RXQwKVK665i0UmDg3J2kfnqzpLQOBE/j/34E2iR0ItuSJhGcrOliuNYi4ehDb69MaS/9LZfCBWLXLXjHgXMUBhfll54DHbSCymCyYxWmkZCMg8/zG6dlkuAn0yjosFT4AdrEBnSjNJ+LLCZ7D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7+jWk8kWpjq409NE24jQeTH8+xNRa2fjXLEsrsm7cE=;
 b=McOUFWWRoOJmko2grECOq1gCDiUJBNkHBAB6z6qn+AxLuGk/1+wXhrcyfiW/tetzdyiGesNIFjGa5xX8pB9mrFGnHj292+fPzi5ypbI7N75+dk4RBDoB7M2dAJd55yhZxPLG+xdAv8xKGIxihs3xr3UPgy3JPlLsK80OHv23p77sv3w8JEo/G6TJzgFtPkIQpa75o1PNap6kHj4ByIK99Gy0b49TIwbzCoeWAMpYG3O7fbLBsTdE8N5OtpMJlZZUni8h2FGcoAJbL3Sn+34MxHdYoCcuc9UmCz1FT+iCy2LR70/68iJYAKyyKlwGVmG0SLUH8TqyFjlmoPAeeRO0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7+jWk8kWpjq409NE24jQeTH8+xNRa2fjXLEsrsm7cE=;
 b=WvRchjHnXoRWrU3Gy0KFFMTk5W8fwxkGO8QArOFVfb4LNoZj6J6q3hHR6VVmikYZ8WQqdTKBkVnEPeTlT4NUuQsIcp7t8aDvF1zvzGyudy8bZyFdp6OgET7P10DfbCf7yY7awVEo23BPDxZcrRnC/aq/xXiGIol0+bDWGCpx7+u9J1bhmTfGWNpNkXvDNaiqta2Iwm7pKXpkJl3K7ZFhdrHbZjWuWeDo9/8cAhTiPOCMCTMWsOyjAxJItJN49/fD0iDQYlcBKqthwnVTA9ZKTQu9FoZrv5/hWIIwqB0fMEOvz4P3kKRYrOW7pfgqHznNsuaxpH4jnh0N4YZ7z/kw6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:541::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:08:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:08:39 +0000
Message-ID: <860e90bd-aaf5-4ce5-9fec-d241371931b0@siemens.com>
Date: Wed, 21 Jan 2026 18:08:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(linux-cip-head): catch
 network access error during commit retrieval
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20260121161634.2385379-1-clara.kowalsky@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260121161634.2385379-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:76::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: fd38039c-f835-4107-4bb8-08de590fb8c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZzZwNmVRUmpjbnkvc3hPWXNka3BKYS9QY2lZbUZlZFNYNGlvUFBMWVlkNXdM?=
 =?utf-8?B?T29lVzV5ZlpWTE56aUVIZGRkT3MxbGRaTnZadHJ5K2pYV2RKUVQzYldYTGp0?=
 =?utf-8?B?cGZQWjhsUER6NE9kbjVHNjRLbW1TZHkralVLZGxkaEYyK0MrbVlPZFpzUk1N?=
 =?utf-8?B?cit5ak5qYWtHNUNyR1VJTVYrRnJON01Xd2lOQXpKR0tzWVJTQTBkMlMrVmp0?=
 =?utf-8?B?cDhhSmNzZll3dWlIa2F1alQybUJ3NjdIMk5icjJvcXdkVmhNak41d3NadVlD?=
 =?utf-8?B?VXN5dTFnZnJ1Wis5RTdoU25lcFpremlscWtwZGxKMHJhUVZUR2NxRnlTS01O?=
 =?utf-8?B?Qkk4VnE3V2NDTVU0ejhyaDFZUjIwRm9QRkdoL3l6aDF6QVU2bnNiUUpmdUZw?=
 =?utf-8?B?M09vTUFPZFpkVzNIdTlTaGowRnlYTlh2M3NvdG1ZVVhaRSs5MDNvblNBMTlp?=
 =?utf-8?B?TW5IN1lDT0RMUkFYUVFOaTFYdVBtdE5yRThOUlhPdHl6ci9ROWJ6QmlnYllG?=
 =?utf-8?B?RUJXQVh3ZkV6WXJxbDYraXJmOWszVzNCb2VLZDErL3VMaGdvMTJUSmVnUmMr?=
 =?utf-8?B?U3FGWkxFVERvQkh2QllqcDJ1WkNybVBhcG9XWFh6V3FYcXZXcG1HanduVm5H?=
 =?utf-8?B?c0ZkQmc3OCt1cFQxS3l4YnhJOWFIUTk1bFpoL3ordENsUGVPU3hyVlZSWUhr?=
 =?utf-8?B?LzRtKzFXZGdHTWJYbTFnaW1Jc0FSclVwWGRCZGE4NU9KK1ZJS2wrekQ2SUNv?=
 =?utf-8?B?aEZGOExQZjlQT2dsMUl5NUh2eWpyMXYvei9sNi8vQVR5ejJkZ2Z4WHhJeXRP?=
 =?utf-8?B?TUpjM0VKdW0zT1BoQVFvRit1am9NU3hyQ3dPU0k2SXpLWks4NXg2NHJaUU1o?=
 =?utf-8?B?MXFRT3hUUU9XRFJMZHJkQXR1cGptMWRvUGx4UUs2YlZVdFBLdGNyanpUZGts?=
 =?utf-8?B?VHR3b0l6TzF0RU1DZWVVY04vNEtOVzBtY1V3RG9aa3oxYjFsRjR1N1R5Z2xr?=
 =?utf-8?B?Qk0zb3orK0NSSE5qZmtuNVFVbjRJUDQ0U21RSDZCZEQ4eWhEZ0JoTUZyOXJo?=
 =?utf-8?B?aFR1ZUIyK1R2R09PQWNrdUxZcDU1STFmN3Z0S1NqNXJHamVKVzhzT3o3UVhy?=
 =?utf-8?B?WCt3ZU0zTW9ubzh4VEVTRGttZ0JYc0ZzSHpWZ0FVb2p2VVZkbmViaHFsTnJN?=
 =?utf-8?B?MXIrSk0rOFBWd2JXZlF6K0ZJUXh2YVZPR0NYNkE2OTFMYVUvSG5CK2QxLzg2?=
 =?utf-8?B?aWw5N2d1TXRPc25MM2hnUm9Ya2hMcmpza3J4b1pZUnRBZTRNOXd0emxkWVpa?=
 =?utf-8?B?RE10R1NOQmV4dmpjS0VveW0yL2ZrSGFTVjRTQmdIYjc1VjlLMTZyOG5mR2Rx?=
 =?utf-8?B?Z1FZZ3RnWStYR0JPYmN3Q2MwYk1mR3hwV3dINHJOaU9ONyttUFcyUFBOVW5x?=
 =?utf-8?B?VFRIZHF4NDNuK2Q2ZW5sS3ZDTTJtSmswNnJPK0lJbXk4RXlreVlMK3NnQlJa?=
 =?utf-8?B?WHAvMmlZRnVwVUpZRFJsRTYvVTl0YnRROHpwblFja0o3amlHRk9aRHRkK3pD?=
 =?utf-8?B?OUNtc0VlTk1oZWRpY2dVK082V0xZWTZTN2wxaWViaFZpODhWUzBqNVJ6NmxH?=
 =?utf-8?B?S3h5aVdWTk9SakVSRVc3blcvdWpJTkt2eDljc1hjRU13S1Q4VTEwVDhQbUR3?=
 =?utf-8?B?bVkvbnZvUG1TS0VJQUxQV2NzNmx5YUh6ZlU4bDBpcHZKRVlvcUpRZlZGd0l5?=
 =?utf-8?B?a2pjTmtFd0Z5aUo4MXowWkdwK3VCai9NUWdYSVZwUzZZbE1kWDdJTWhtSThY?=
 =?utf-8?B?SW5LYVJYcytESTQ3VUdlQzBVNDhFZVVvMFpnMUZSMjNGbTdmTnZFR3BraWRT?=
 =?utf-8?B?ZEo0RHBwaVNlbHJyTnZTem5odWZQajJkNXhDMHlObUxGVEl1VW0yOUlnWlp2?=
 =?utf-8?B?WVoxM05IdExoekF6OElTL2ZDd1E1Zk04TUhZTXM5elBYbXRlWUc1YkZVeGRX?=
 =?utf-8?B?VG5EMjYrd0Z2QkRuQmxROHk3dmZzTW1RZ0dPZkg4dFE5THVxV1VJM1hQYXF2?=
 =?utf-8?B?anhGKzFoWWwrUk9SN1dRdlduK1lOUXE2Ykh4ZnVOWnMvY3oxdEI3NjcyNzMz?=
 =?utf-8?Q?iWB4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkEySVNya1BpeUhORVVTeFZEZDd5ODFaQTIzaDl2SEVGb1JoM0xSc1ErU1R0?=
 =?utf-8?B?WmRxbEQ5U3BYRndsZlNUZllTTVJ2d21YZzE3eVhhdkNDM0FXMGRvbFhpQWxV?=
 =?utf-8?B?eGpqOUZ5cmdqWHhFRU4raE5wN0NORWFCZ1FYd2c3cnZWS3hld3p2NHhPNW1G?=
 =?utf-8?B?Rm5JdXNXcDlrRGEwZFpoQzVJUlNsblpRa1dReHk2eTRsKytsUHc5cTBDTHUr?=
 =?utf-8?B?STRPSTB4Q1MxenNNTC9GbEV5dXdpelRjZkRMMlVUV0tSTU4rckVLNjRGbjdi?=
 =?utf-8?B?ZklLWjlaVkl2VXBoeFdHaGpOZEZqVmVHY2NiNWQ0TzNKNTFjbnJRTllaOFdQ?=
 =?utf-8?B?STIxSll2YW1DeVcweFhua0kwa295ekVXZXFDZDdETlJOZTlCU0pWMEsxWGpK?=
 =?utf-8?B?VCtxa3FkQVJYZXFkdFFZYVQ5dXVBbkNBc2xRZjVVSXVURlZSWFVSREtVR0RY?=
 =?utf-8?B?bTh3MDFmc1JyNGV6aTBvbVpZb2hRZVFVRVkzOWhmU0RVZENUL0Vha0x1MS82?=
 =?utf-8?B?SUJHNDBBN2lWek1xcnJXajBRMHgrR2xmdDB0eXFRWXEzWEhJRHhJUHp1eHB4?=
 =?utf-8?B?UUhqdXJ4N3ZiSmtqaDJpM0wyYzY3ZS80c1RPOEF4Z1hMM21WeXlKS095OEtW?=
 =?utf-8?B?ditOaldNV3JIWHUydm5KVDVsSVZaaXVCeU9NUkVpVnA1M08zbDlOTm43MVF0?=
 =?utf-8?B?L0FxR0lMV3hFc0JFR2NLYXBabUR4aDRFN2xxc2xTWVM5aURrclphZkVPbGIv?=
 =?utf-8?B?azg5S1VobFRoeGRsd2pGOGxnZXovV2FXZTVkckN1UytHV2NId3BxNXVPQ1Rt?=
 =?utf-8?B?cWxxUlZHai8yd1h5RUQ5K2oxY0trQ2xMWGtaUE1rK1BlbnlOZzg3WkIwVnlO?=
 =?utf-8?B?Z3MvRlVGK0tNQ1hYemJDRGR4bko4VzZSSUNCT0YyQytmR2NkdktqUTlMYjFu?=
 =?utf-8?B?bVFseVF6TXIwTFFDQ1E0UGM3VWZtZzZUSUw2ZXpGZGV5Q2lvWnNUcFNjeHA3?=
 =?utf-8?B?QWg0SVdTQ1huTzErRTVLeUNRUnNSN2xpTmgyeWllRkJjcGFCQVBnbEhCS1lR?=
 =?utf-8?B?QldyRWZkbXZIT0JtN2xlUVZUMHlnZ3lTWWhpV2RnV0JkMHNrbGgzL3VPR3dr?=
 =?utf-8?B?S2tyb1pJQlhHano5WmhrNThaMDBSZFh3aVlKMXlJd3NwVHlMSzlBY1NaWTJ3?=
 =?utf-8?B?SUNSN1dXTTNwM0pQL3ZZdGJoN2lGRU41QldheWdZTG83ZUJ4dVY5VUZuN3Y1?=
 =?utf-8?B?Qk9EUFZmYUZHaXkvMGVra2k1RTdnRVRWdFFSTEJiVFExRjJ1dTg0TkE0Tlk2?=
 =?utf-8?B?VisxQjZjM2YwVXp3SXFYWjRwUEFQMDRXU1pGMThZTThpaGZzWE5jMEw5MDlN?=
 =?utf-8?B?azFOTTdqRTlhVUNYNmJyb0pqK1FESVFyMlYrNzloQnNiUUVVMFFpSGZyRzJF?=
 =?utf-8?B?QktQeFFLREhUYkJud28wVy9CbnhRUWcraC9TVExPeEVTYTl2S2JGNkxLOFJU?=
 =?utf-8?B?NStXcGVNZ2wxbU5peWZEbzZldDBNcTdsYzVHaXF0cy9Cc3BjK3JldGxMY0Zt?=
 =?utf-8?B?azFBR0x5MVlPT2dFeGtVbXJxQjFmOW13MTJKKzdhN0p5SnlCK1NKYjh5Mllk?=
 =?utf-8?B?MGZETU9CZHVlaWdYaTQ1VWowdk1Zd0JqbUlxSnhBbkE3bTFqZWpFMHp2dFlC?=
 =?utf-8?B?dEtway9LbWsyWUU3MkxaaVpqNzJhV2swVnNrZE9LVVdnaEhSTkIyaklQZnNq?=
 =?utf-8?B?MEkreTk0cmNhYy9IRXFuSHpVZFdvOXdsakhTLzBUMEt0UzZzeWlzODdDUFMx?=
 =?utf-8?B?cjFtenAwSFJpMjFQNVNpck1HRGRlMG9sVGJmZVZvTnpCNmxPdkFEZ1Y5c2RQ?=
 =?utf-8?B?bHA1MVExVXNheVBMUzQyS3ZYN2pZMyt0OWhockcxblBCekJmZVZYNEo1OThw?=
 =?utf-8?B?WXQreDRkQzF3R2hNeEZoSGZmRjV5cm5TZGpoNWViWXE5T3BZWGhjc1NNdlkr?=
 =?utf-8?B?dENoampjckxobHNVcUExREp4WTdURG0rZnNZRkZIdkROWXc5dFI5QTVnWitx?=
 =?utf-8?B?REFYbXI1WHBhRU5MM1JRNWdoanQ1WVdTSE11VGVVWW1VdlBETllsU3RMNCtq?=
 =?utf-8?B?SmFNN2VnUHEwbzl0STdnQVBtajl3c2hqS2IyL1kxc1U5OTc0TlgrNm5OSHIx?=
 =?utf-8?B?U2JjcytPQXc1eFBnTWtGTXRKdFJpV3pyMmIxU0ZtNTlFbkd3TnlZVldmVzVp?=
 =?utf-8?B?dGRGVjZlcGlob0g2dUpyYVU0UVBKaFBac3ZYdnJJU1RsTGNocmV6dlAxRWRI?=
 =?utf-8?B?ZUJPVGtndmNYdHFWemt5OXRKY0FDN0w5U1FuSHhuRG04SndZYzJiSkVqbUxM?=
 =?utf-8?Q?ANlEaJU3Amgixks8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd38039c-f835-4107-4bb8-08de590fb8c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:08:39.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRo8z+xk22Jf3Ta1IutiTeL2Ib672gTZUxVeSH9CE+XIAZL9Iar+B/bwpz8avdr8qVp53ZwbpPq1URzJ1FNRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 17:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21691

On 21.01.26 17:16, Clara Kowalsky wrote:
> For offline builds (BB_NO_NETWORK="1"), the linux-cip*-head recipes
> cannot fetch their commit hash. This catches the error and falls back to
> an empty string for the commit hash.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-head.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-head.inc b/recipes-kernel/linux/linux-cip-head.inc
> index df604db..94163f2 100644
> --- a/recipes-kernel/linux/linux-cip-head.inc
> +++ b/recipes-kernel/linux/linux-cip-head.inc
> @@ -14,7 +14,7 @@ require linux-cip-common.inc
>  def get_commit(d):
>      try:
>          return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
> -    except bb.fetch2.FetchError:
> +    except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess):
>          return ""
>  
>  KERNEL_MAJOR_MINOR := "${@d.getVar('PV').split('-')[0]}"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

