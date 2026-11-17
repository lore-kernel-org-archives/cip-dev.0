Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12140.1794896554515832474
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2026 22:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bEWYQq1u;
 spf=pass (domain: siemens.com, ip: 52.101.66.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+MIze9uNSQ+GCnYCgnzuWVsnuc5WmLZggR1Uw0sAS3D1b2+XFKs1CkyNL54V8yVmuCKk9Pc5P9F3aHnjaEvAYXTBWBgrkdnOM6YeEm0CjSdvIyX2uRGktt1mxN5LaaLL+ZREcXo5FqrdcJBwcVPS3Ke563Ilw8TnwHR2gmFYB4X95S7PorAzM7B35cpIhekPrG0mAXgap+S/ogYrGfAxG+a0dE2nTgCheklceqeSA4aJcvpus/QTA3SyJefDYuHKT8T2R1xOMFpSb0V597ZGnmJGAH3xTydlpFWQkzqw6S5JNUrKL3GJaOGZ1BOFsGkQ2F6Yfwl2TAEl/WcjaisQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuoPzcy9Wi1Ph5r29WqTpd5aPyL2Xl0Uvi4JDf1nI5Q=;
 b=D4Zc/nW9v8vX5C06182Qtf+OdQl434ocynwZqMXOFu4aWA+zebhGkesbQWdGg23eQGMia6B5zTqxTc4jNR8yg78rdLs/DSvI3gm2hrlVZ6GNSiUATm9YzPSDWJkl1PPHpcyv/V3SCUZ2nCmvqUYzJ21sMWdWN6XbbMA0uqtthGEhleSeSGw4fGOcxPYfyXIXXqsoyimpm/L3RlNVxHh0/jXspx9a0F/0FYcxit76slR8oPxLjtARZESzmvLQDFRLsJRZAPqhbDv9x3wHtCmqXvEVDA5mq9RUXcI/e+fqcx4484JEw28SxLlbcvFFHAPH01OrNU+3p3VCY+YQgF2o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuoPzcy9Wi1Ph5r29WqTpd5aPyL2Xl0Uvi4JDf1nI5Q=;
 b=bEWYQq1uuR6AXbuLgrAkbzEAV4boCgScLRESlX5HhXJ0atQUz1gX/KuAHnGq8DHCrsK1/Yk0uFZJLqmx8JtJSvfFS9WjcpsLqpKBmNPx4LwuYD2zaLgklqjlJ/kCobzeDbIQRh7V0ZvNR0HEsniJoNsft7bWdBr1DJhPrIgPg+KopQiDLL3vaQDsNeyc3AyrQokjsMgOKa/iKEMO+H7/2OxmMDU3h+ytrzU4GC7Hf1ma3jsGfKerngib9Y1KuFqGYWlG7Mz+SDrEvxkvEiWb7IRnGSKMFeTVmFYAl1L8Kotng+Hh4bImUYiAt6/B9EjMF5NRUq7po5QzKtASVYdcGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU0PR10MB6953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:414::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 06:22:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 06:22:30 +0000
Message-ID: <01bcebb4-9c8e-417d-9b0a-ce2c7cecde59@siemens.com>
Date: Tue, 17 Nov 2026 07:22:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Backport PREEMPT-RT support for ARM
 32-bit
To: Pavel Machek <pavel@nabladev.com>, Chris.Paterson2@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba,
 Daniel Wagner <wagi@monom.org>, Bryan Brattlof <bb@ti.com>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Pasquale Nieddu <pasquale.nieddu@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
 <avbS_UO1IHpgbZgA@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <avbS_UO1IHpgbZgA@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU0PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba6a42e-3803-4fc4-0820-08df4473289b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261102123227099003|10067099003|4143699003|11063799006|56012099006|261021121427099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GbmaxLwti0GbirxLMKfKt/msExFo5mE/Z4f1CJNySWXpG/JXhnuBtlgdJCYCLOGrQRpbBaCMfhdrgRUZNUu+VECNw01rYcLXGe3T3NPgsBGqFXiTaGJTgSjiBNDj7a8twG8Mwjd3jZ8dqmqIXddj5E/ocZ0aRyVWokZODDWkk/24vQ9xdG64JZjKkvpJGj7EP41KuTNDL7zEeKO/SzwzhVXDAnWmROi08XwZ3iJvcfxAJF+y2dCyHeFffvhWfQ+GWtooQYpqfz9dsIPzwxW2J8iwVsf/oI7zj4J0xgnGKu1SDuv7gkYC+2Xpv+0ssIVjiNQb8xPWY6DEefKeTj7VxthXm47R4Ein8LYFIMgQxm7KRqSQzTF7Q5zsltrxT2qlngPRR1xYtDiXHkhOefxhremS6G94hlC8RJZU029W666zZIHIg9Bgg4ybosYToDZ5YY2jVGHLFwXxzFvo1+9nqjQsmcf511GWhJNZ2NI/7IQ76DiYgKPOFMeosd6NKS2K+W7iZBsfkWGklGo7/QqHhuaB7lXz9E0+fdQSTFeqJvkkAYTnH//k540AvsQJUwri3EcUpF6Q4+Ar2Zo+59FwZl9tSj8H6g86W0A8PofQugO46PIJuBLZ+xi+O2JYu/Qs0ldWDD5qEMbEYADeGWG7ZQXrU4fI5GRWhI7o3ChtGf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261102123227099003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhFMVpuVHRuWlJmLzlSczV1OUJsNTVObkZVaEFJRHVRdHUyU1phUDNtb1dv?=
 =?utf-8?B?NXRRRDJ1U2x2b1ZpVlNtZjhTNXFSbkdUSVpkQW9rME5tVGNGd0pHclU2UXhM?=
 =?utf-8?B?WkhsTXNOVGErMU0vdGRMVXV3UUFmR2VTWW15b2FPQUsvdXpnb1lWUzF2bkxM?=
 =?utf-8?B?bXo0YXp3eUxLRm1NVHFJb2FwcDVMbEgyQ3FtK2FzRkM0cVhDd3RvcFVCbnpE?=
 =?utf-8?B?eTRBZFpSOTRZSGN1cEhBWmpDd2VpTDhnQ0JMMktQempxQmxIbEdBVW52UzFo?=
 =?utf-8?B?VkIzS2RmUmpYMndWYzdmSjgyZEorMTB4YXVES3JLVTJ4TVAwZFZzblFYS1NF?=
 =?utf-8?B?RnVibnpFa253VmZmcDVZcnVUenY0Q3p6ZUdmM0N6aFVxZ2RZMmc3L3hRdHFW?=
 =?utf-8?B?U0ZKM3A2K1dzY0lsam55dzBPWVlOMmoxTjdqZmRLY2tIbWJtQTlRamxGbHJI?=
 =?utf-8?B?T2tGYkcyY1lkblZvQzdKL3djUzUrV1h6WFlONVdyZnFRSVlIK2JiaE1wb2ti?=
 =?utf-8?B?MTlPTEpzOTR4TGh2WHdKN3dTV3ZZeUJ0MjJYeDI2SkJCQlJLbnA1L2R2WGRB?=
 =?utf-8?B?THBITkVrYTdYbTFOSXJrVWQ5SjBSck9uUWdBQ3A3UjMwcTc2dXdXUW8vRmNQ?=
 =?utf-8?B?Z01pdjJVbU1KM2ppbVRTdTlWS3FCeURZVnZ2VGxoRVRocnJlUUMvb0p3QkRD?=
 =?utf-8?B?dExyODdXUndNZGlSUld6ZG1VZ2Q2QVdmNHBSNEVhbE9zNlBxbjRkdFV3aENM?=
 =?utf-8?B?bG81cWd6NGJGcFBJaS9LZTlwOHJDZGJkbmZkTWFhbk9yNmNZTnhod3lOKzRE?=
 =?utf-8?B?RnBhMUhLencreHdPbmVOQWpFZ25neTlKQU5wOXNHbXZhcCtpY242aWd6d0lN?=
 =?utf-8?B?YUVXcEhxV1kvc3JJdERlSXE0Z1NXd2xEcnRBLzYvL1JpaTIzc21ENjRneTFv?=
 =?utf-8?B?N0hCZnZTbWxMSm9NVUpIemM3amdJZWFMbFpyWDA5dkM5K2FNNXlBVG1JaDhx?=
 =?utf-8?B?R2oyUFplMnRRQXRCNDJ5S2g4bVFYaG8wd3VNVE91N2dPRTNmSlpUSWFMVVpG?=
 =?utf-8?B?dnhYVEV1dGthSU92eW9ZU3oyS1IwbXY0M3pqSXlmUW95ZEI3ZjhEZW9mUVJG?=
 =?utf-8?B?R3lJUXNNSUIxZWgvU0grMHliM2syNFlZZFZjVklZajZCU290WkpQWmtaK2xa?=
 =?utf-8?B?ZDhVR1duWE5CZCtZbjhSWEQ5dGJ3alZyRFh4MHE0M24zUlBJM09lQUNhTHZD?=
 =?utf-8?B?VG5CMjJya0NYSnU1MTZhV3Mrb3RWZUl6ekpnSnhML2UwY1Z0cmpESEJ4K3RS?=
 =?utf-8?B?dmlsRXdUUW1OcmhjakpqY1ZXSFRWa1B3MFo4RTBCOXl5aGpqR0tSRmRIT2lX?=
 =?utf-8?B?djh5QU52UXc3ZVhuMUxJcFNUc2tpbldBdlhLTUYrdHAzZ0N2aWpRaEtqbmNa?=
 =?utf-8?B?NGd0Y29lcVEycGMycHdOb3E2R0NvNG1JWFV2U0JDYXFiMXM5M3BoY1M3UmRY?=
 =?utf-8?B?Ly9qSGkwTlpjUVNaMUgxaXpQSG9PL0R0dXpkZW5HUnNVb051TjFRSmYwSUh1?=
 =?utf-8?B?Nzg4NC8zV3JVSGtvZHNlNXZwSTNHQkl6c3lITjlUNTdJbnhoZklsdHp3YkdG?=
 =?utf-8?B?WTl1VkJPMzhmdXQvcUpjdUhYYVBUTGtRLy9TRFZ2QnBIUk9hUnZBMTcyOVJn?=
 =?utf-8?B?Wm9JSGZBN3JNTlJjeEw0bXFUS2NRTGU0VUU5YVFmWklQUlNQSE16ZmJiSGx6?=
 =?utf-8?B?OHFaREdEZ2RPdG1MSkFodVZJV2U3aG1Wd0tkL2lML1hkOXh5OUpVZmlXUHhB?=
 =?utf-8?B?dTRseU5oMWdWcmptZnBJbUVxaWFTNTRFeXBhZXNybUhFUCtheXY1b3hTZTMy?=
 =?utf-8?B?RXh5SGkrY3RmN2VnVlV4MklGNEh1RWVhcjdzRjN4OWRram96R3N0UXdtTVdV?=
 =?utf-8?B?N3ZTVnBaVlRDTVBBL3RNZW83aTVhLzRJVU9xSHFWbGFnKzY0cDNuQkhsKzlT?=
 =?utf-8?B?RFNqaTRyTFFSTGQwV2Z1bXRCb2pOVVZJemNGYkJpVWxIQXJjd0FNZGJxejRy?=
 =?utf-8?B?bWpPKzErdlZvN1c3REtLc0lhaVlzZHpmM0gzZFBPTTRoTTZROWs1TUExckdw?=
 =?utf-8?B?V28zOE9ucGtnUytWelJsR0ZSZ2Fra0hUMnFMTHVkRm9xYkdmaTU4dDdBVURK?=
 =?utf-8?B?MlpwOHl6bE9Wc0ViSzlMYzkwY1NWUTA0ZnBDbTIzY2x4a20vazFTZjNyNjh1?=
 =?utf-8?B?MFVQSGZrZndmaE1ZWlE5YUdmTFZxZ0xBd2NNWHFDQXlMTGhLYTY4QlQwZ0Zk?=
 =?utf-8?B?UjJNaXlvS1RhS1JoMCtER28wRDdJZTZkT1IySUdqTEdha3ZObWF4Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba6a42e-3803-4fc4-0820-08df4473289b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:22:30.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+ujJrw2gwDHiVNeanxY2AiYwn2fxlD1utk33DwivCHR5OD3ugpPdU4Yt6klpDe8jDIGBAYM30oL7j8xpkB0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 06:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24811

On 13.11.26 10:06, Pavel Machek wrote:
> Hi!
> 
>> As a full backport via stable was rejected, this is targeting CIP 6.12
>> with the required changes from upstream to enable PREEMPT-RT on ARM
>> 32-bit.
>>
>> The series was derived from the ARM-specific backlog in v6.12-rt-rebase,
>> only reconstructing it from the corresponding upstream commits - maybe
>> worth to consider for stable-rt as well.
> 
> Thank you, applied. It might be good to merge relevant configs so that
> we start testing rt on arm32.

The config snippet for RT is arch-agnostic. But it may need some
tweaking to request builds with it for arm32 as well - Chris?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
