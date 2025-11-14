Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B018CE7A94
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:28 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13974.1763111123245453982
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AUDY/hmo;
 spf=pass (domain: siemens.com, ip: 52.101.72.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSTVd+IHrw/1ZqAZHBkWeJvhYv5J9deud7sBQY5EYpctAWGH9zfHsqIygyvPgUyJIAedobq7r9ZIWaa0TwWMEnIZqz3PmVSPPMTsLjy41WygEqOa1sZqj9cSXEQO8Rz39z0r4BqYDvidUfjrzpsIWiprXNDurdj+eirbImVrExZxqWl6RmLLtdpvSStduSiJV+7SHiRhzHJBhrZzeULkETP50m2x9dYQJ2EFRrdViqWKjkv0wvl2plRtlbJD5FI5+ZMs89rrnWxR9sEu9165sAeM80AGNhFsk4xNpgm1sEkpJRuaj8uMf0Fz/PXwRQx/uErDu+Mbv7zvQaCKk2ZwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbuNntPEDBY0aQq+pr2gB7sP+Nyvqss02HVRetCglw8=;
 b=sNrzcHZggn/4ptIvRV9pCRZFPrZex0FYzDsxq6fvYHo7QMBJp/VDTZZ1X5zBRH0me4phwCSfJXPdSFHPhavb85adfWPG76JHZGXO1lXfFGH97r7k/FzrLyniiZkVgTjfsSdlkyyJ7FvUltpuBTawBE37jvaHsjylDZMTQ+iUaLT7MdIH9HLBRfPSyXXB9a6GTV6/Gmp7SYN68TF8b5Sqx8NTYd/EfDpNIjGVU+BS2dc/DUzqRUlDEPaxEmD6fV4HI+o4Xh+GNoZZzm1uJ2Rvq1UDWuZMnPIOhh8BZHo18/qb34V9L1LfVN3sWCdjKuH2f6QGZCNrLCjcFXjnZigV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbuNntPEDBY0aQq+pr2gB7sP+Nyvqss02HVRetCglw8=;
 b=AUDY/hmosPxlSMUg41rptLr69o2Fiak+15dZUbUhJHSH84BJPuFg1krQdWEtKjjyqT351smxoKdUhmgGjRZKFM4WwrG2urDAStbm/hM1dVMf4zT88tachYC4fij1QWKRS15CaOwpW4s52WPWnDE1n0CNEK2oqUeo4Joj9T1RiBLAs+uP91cWhNutWhle+lAZIz6b5HO2GTfnq04G9qaHw9yxoH70wn6wl2Vm65+VkqpSVPnQjQuht5AXc8egHxQm/wSlO+EXlpqYOcyR5Sd+3Zw18JJWEdkJEB4i8w2WVCqig5uZ8UvbF/oEgMLUQisVLfZ84EXmZ3zCYp2kBuk9KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:05:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:05:19 +0000
Message-ID: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
Date: Fri, 14 Nov 2025 10:05:18 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: Testing isar-cip-core on the iwg20d
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa3b134-d0f0-455b-4fe0-08de235cef72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGw0MU9lMkJrMThZaHBieFRQQzhYS01IbHpTSFlOcGd0UFZycWpKYWs0dzBP?=
 =?utf-8?B?eE4xSGxYWG9oZm9JU3pRM25IMlVMMlRzbkJPTzNSVnBsZnVBUlhyS2FzOW5S?=
 =?utf-8?B?RmNMRC9jZ1dyWkNjdDllT3VPazc5Njd5aXNoQUQxZkI5aGZpTUE0K2kyd01T?=
 =?utf-8?B?MGU4bkE4b3ZFM0JNNS9heFphay9rM1ZleStqUUZXQTQvUFlYbTMrYTM3MDVE?=
 =?utf-8?B?NzBNNUdzcHdLYlkyTC9rZ293dDNIenI1QUZ4YjhwZVVyd3lYcWFGTTIvWGw5?=
 =?utf-8?B?ZjV3Y0l2NUdwMCtzMWNIamhnejZNZ0pkYTg1bm95b2Uwc1ZRclRndnhZMTRt?=
 =?utf-8?B?ZWdRTUtxdUxzMEZZLzRMdFFScHpURUtHV29XK250Qk1KcUFXUzlIZGNneGVo?=
 =?utf-8?B?WXpkUUxQZFpxQkFyT3BuOENDUloyM3E4cEhxNGNmVFRGTUpTRXhubFZnZWhz?=
 =?utf-8?B?WXVGM3BDZXBQSEhsbGtEUGNiaE82dXo0OHc5dzJKWHVhQm0wUEpXU0JwOFFC?=
 =?utf-8?B?T1lTai9oS3RhMUdhV2l0WUJKVGtoTWVxdHM1NlYxKzhnZFVIYlJ3ZXRIUi9I?=
 =?utf-8?B?ZDEwaThzVUNVZDRFcUhOVy9Ybmw2UGQ4MExoMnRpVitCcFdLUWt6a2ZmZG1W?=
 =?utf-8?B?eFBhcTd1cW56ai9RS25kYWVRQjhYamdVYy92UWhtdmhVVXp2QlBldUlkeTdJ?=
 =?utf-8?B?N01CZzV1VFM3VldaQTBmaHo2SUg3SC9NdFU2R0tWN3NtQWpTREpIR2tjeVds?=
 =?utf-8?B?UHRtVXdUNTlHV2FjRjc5Rkhab2pvQitFbS91ejV3S2dka0lrd0FDbTJGS2ti?=
 =?utf-8?B?TFRjRzhnb2NZcFFlb0M0UHhxOGVsa1VzSy9JVTQ0Nmsrdjd0eHcrNEVmZFVH?=
 =?utf-8?B?NGZuU0UyQ2xQMUY2YnBCWmF5MDE0MFlkL3Z1aEdMWENVbXJOL1RHNnpsdmVC?=
 =?utf-8?B?RkhWaGVEVFhFMkJmOWUvU3p2UkxZRVBod21tbThuSXl5NnhFYVJsSDgrRDhw?=
 =?utf-8?B?eHpQOUtBQk4wdnpaQlIxRFIyMGlYUUdYRE0rVFJCU2ZibzA2UG52aTVhdzVF?=
 =?utf-8?B?S3NKQWxPTjg1ak9JL0habUs3ZkYxcm9FWm0zb3VxSDdMbDVWN05qczBETWt1?=
 =?utf-8?B?aDBZTTROUGlyaE45MFdrZkZNWm1qZkFwN2U5Q3RKZTJjNDRseGlpYXViZ25L?=
 =?utf-8?B?aXFLT0tYcWlsS096VHlOZWNsY0thM0EyVEorWUtOWFRyaExnQks1S2lYdWR3?=
 =?utf-8?B?MHYxMWpveVcvV2gwQ1VBR2V2OFA1VzNHQmxUc1k0VUkwT1JLZWwzNXhXTklM?=
 =?utf-8?B?K293cTVqU2ZUd3lsUytBZXpvOFZVUWdxbm5HcHFQSlBUUVAvSlVtSlQwZzdv?=
 =?utf-8?B?cFZnZzdMUXRUanhWalUvZG04OFljcTJqc2RsTEQ0aVZmSUJKMytNcUZvbUdx?=
 =?utf-8?B?TkIrNVFaQ0QvWlNYQ0k0bUQ5Qkx6WjNZVGVOSWc1ZFRHT0kvWXo0U1VrT2xt?=
 =?utf-8?B?OHYvcENLanpveWdUWjVQTENFS3dHUWhJQzJCanZLaktjL0VOanNQUUdST0d3?=
 =?utf-8?B?cm42dVdiK2hZbzNUWVo5WG5EL01VcExoL1UwckFHbjY4ejdEMThmTGVFa0ZE?=
 =?utf-8?B?V3ZqVWJaL1ZGc2g2bXR3bGVBTVZnNFRLTklQQno2TFVyZEt1S1JJMmZHTkVl?=
 =?utf-8?B?SklKaURibksxcDJNazZJcmlhTDVxTklNNTF0SERTUjRSRGNKSmJvbGlXTk9v?=
 =?utf-8?B?SDdDcVlTSnI1a2F6MkJDb1F1ZnYrMHdJcFZoQldhVHFmZGJmWVU1aTFIb2hz?=
 =?utf-8?B?Z2ZaMnNZUmdjZC9qRUVoekJWOFhTRTM2MkpzQnVoZUxRQUZraTBROHhvUGhZ?=
 =?utf-8?B?NHpycExhZnYvS2JjdXNXUmRDaUN6Y3AzVE1id1RqWXFBdkVlS1hLblNWaXov?=
 =?utf-8?Q?iQzzrKGDQbcdn7h1HVYTcDkqj+B5dZp8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkMwek56NXVKQ1RPZnVTd20xenA2UTZhZTd0TVkvL2ZCTG9sR0dWSnhxTGt2?=
 =?utf-8?B?a0oyS2U4Tk9TS2ZiQmk1WTFTM21zUUVJQUxuMkpXbFFEdGNxR0tCdnFHbTlM?=
 =?utf-8?B?Qnl4L3d6OWZma001UE9MQlAzVU5NUWxOY0lLelJkQzJjN0gxYlBsd2EvTVhy?=
 =?utf-8?B?RlZzTVc4YTd6Q0pDdmhlbUdIRlU5U1duWHU3L2diZExlTVhpS0tMZm15QmVj?=
 =?utf-8?B?MnpOMlAvOU80bUdMT2dDU2NNVmJHODBJckI5dDJFNEFzS0VUQVI1QjNvREFB?=
 =?utf-8?B?MCtkOXd4U1NybHZtSTNnRmFGS3hMaFc3Mkt5SVh1bkVzNnhEbzRVeTRMTllF?=
 =?utf-8?B?YjQ4R3R4NjEzaFFGU2VMUTFaZXc3d0lNSUo1QUs2UE1nSEVHZ3FtUEdPOGo4?=
 =?utf-8?B?ZHE4TlRWeDdKampNWVcwYVdNYzUrL1VoKzVFSVFpcHVwTENkcDltR2p1ckFC?=
 =?utf-8?B?YzJkK3QzQnJ5ME5UZ1FMUngwY1FPUkJ5NGZTbEwyRERxMEVaTHh2NjdyaDJV?=
 =?utf-8?B?VnZjWkVBUVg4SWFldUxLWEJBdDk2UlRDcTVJajhCQmhLY01vMWlPZHFvR0wx?=
 =?utf-8?B?QWFRL2dVeFBkd2FmRVF4UG1KZjVWcWZYTUZWSllwQ3h5a1JiNmlaZUh6aXNh?=
 =?utf-8?B?cUlnZTFqR1V4bGphUGs0eHNPbFd3MzE5bS9VenVaSDlMU0o1NXU2YmJCQm5j?=
 =?utf-8?B?NS9TZm5yT0pWQlpUa2FzOThVMEdKVWpjZ256Ti9NT3RGREtSUXh5VThIcG8v?=
 =?utf-8?B?Q24vUTloNVQyTjJMVlJwWmtkWSs2Y0lhYWNkYzJnTGZKamJydG9lZXRLUEQr?=
 =?utf-8?B?aWVqSWdoTHIzNXF4UVBycW9PajFTWHE1TGhnd1JRK2l0Um1ITHVrU01MNVJ0?=
 =?utf-8?B?RjF3SCtuODNlVU1scUNuOHJmVlc0dGppb1RZakordlN5ZmIzL1V6MEVjQVRY?=
 =?utf-8?B?bE8yR3YvSG1CTlVlQ0RwS1hMZ25mbEVGbGtmUDRrVTZnVzJPQTI1dVIyNE5a?=
 =?utf-8?B?MDVLUjJYZ3kweVhwUjA0dld4RSs3dG80amRTMVR1RjIwMnZ5MTZPbm12YkVJ?=
 =?utf-8?B?UVJ6UGhwRG1KWGxSeVFueUU4RlZsdm9aZjFvdHZEWkNxcUdTWGJrc3B5aWJF?=
 =?utf-8?B?VkcrSS81RkV0eDBqZS9OcCtkaWpTOTMxYjRVRjM5OFpTbjdBMlVmVWRKc1RD?=
 =?utf-8?B?YzFTU2hGaDZpSWQ5d25iM1NuQjk2bGladURhTHo1TjJZckFNbDlwUFVyUk5R?=
 =?utf-8?B?Y08yN0VVNXg3Zld1REh6ejkyQzBJSm5BVmsrSytWdUVudDRxdjk3VWw2RXUx?=
 =?utf-8?B?enkvdjRFRGZURXNVa2NWQUFSUUllaDFJVXVxNUJnQ2lPU3BrUWc4OUt0U3Jm?=
 =?utf-8?B?YUgwUU4rQzhEeU13WlFkNkdRRGFGeWU5SVFMYzY3RDF0cXJRTGZ0cTAxRUdI?=
 =?utf-8?B?MlQzd0JnQVRyL1hIME5nTFlrV21kcUtLMDNpTFNMczZSM0dtaS9jRjFXWFJ4?=
 =?utf-8?B?cnVLdUREMHN5VDNEYTZRU0Zwems5UzdEVVlWZWpMWkluejVEL3k3TWRTVmZC?=
 =?utf-8?B?OXpCVy9yMkQ3RG1vVFdVc21BdFFGVEF4VVo4c2NKRTdvMzVGVjZaMGRNTzhJ?=
 =?utf-8?B?Y1pWR1E1RVdaWmo0bHFWTHlIRlpiUEd1L0dRczNNb2EwU0oxSVhWQ0ZnYzNj?=
 =?utf-8?B?ejRPeWt2bEhLWnN4SCtQZGNYN0lIYWRNL3BFQWZHUW5vZTNXZGd0T0lnMGVV?=
 =?utf-8?B?QXhHRE1jSUdjcXhvQVBienhSM3FBUnpvZ3pkTG5WaGhKcTBHa21yQVdxUkM0?=
 =?utf-8?B?MEQ2aVkzeEc3d3htZUZFaE5GcXAvbFl0emIzWVJ6UlI4WkNwc1h5L0Zlak05?=
 =?utf-8?B?cURNYXY1bHBoVlB2cXh0aGwvNVMzUStiU1BKMnoyVXc4cHhrZmFPaWNkM0lX?=
 =?utf-8?B?SW5IR3VTV2d4emRCeVQzRVh1SDZCN2RncXQ5QWtxTW9zTWo0bEhhOFgzNkI5?=
 =?utf-8?B?OElwdUk0MkI3ZHNNVzRGcGlxRlFYbVFUS2YwTWZGanhKY00xQXRvTFM1WGdq?=
 =?utf-8?B?WUhqVzdDNENwR1BtaHFpeE5EWEFJaU9HZXNBUzRITEVybEw2YW5JZGxvcEVH?=
 =?utf-8?Q?SDiDF1kpA7cTeldIy/16WZweS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3b134-d0f0-455b-4fe0-08de235cef72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:19.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDuwLTXhqJu3BmVI35NFLDXCmuFhNkfFtkRtAM5RrqXGIMOSMnYaaxOdmhzQUW3QcZb/NnD3nJdItP3TIa6zdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3497
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20538

Hi all,

as I still have the boards with me, I "quickly" wanted to renovate and
test isar-cip-core on iwg20d. But the board I picked from the stack has
an ancient u-boot pre-installed (2013.01.01) and has no clue about GPT
or the right name of dtb file to load etc. etc.

Can this board only boot U-Boot from SPI? How do I refresh that safely?
Or can I also make it load U-Boot from SD card?

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


