Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EDC83F21
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 13:38:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.61])
 by mx.groups.io with SMTP id smtpd.web11.8699.1752586677663513681
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 06:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sVXf0ipG;
 spf=pass (domain: siemens.com, ip: 52.101.70.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH6HcWByVtrYJTjZ2DczotChQvgjpF3AeEbvFyIzxM31Hp0Smx1cq/bKY+gJjmcs6mfarJFpuSGdqpl5OG3UPBUGZQXgnbLEcDWqF0NGdx9VhggBuWrDEGhPA7n/mssRtjzkTaqzD5cieVSJuPuGuyqeEZuG2Ze2IJPMNuOqcCAvImoOUH67Bu3ax6tvHMikoBJW1zfiIaS2JIxYGZSYFguF3uXt00DdM220mmNiFOD7CAwtg6z7B9VwDS2NSYLwMYhBSkr1cDC39P1anjDmcpgQpiolV30FG68RMooKWnRuUcu/owUCVN03/6rsiDDEdu5DhOjCphPq7F6wUThIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDe/RPMnXKM7lp6ZMF1hm72UOp4l0CXPnCCZke8rYRE=;
 b=zC2rlgCGN71TuzhynshHjfXO4eyH22aA+bCAyCU7ziUJGYOQZ0x3+3mOAVAVzFZIaST2X+MAwK2zzy06+YsbrpG0hTBEI5hR1ZbRzYu4JZJ8ls6jboFXqfkfBcE82mFg/XdoBsUE85SBCGbQAZz5A1ZP6isO31jByRCBkDOASEGCSLapR1Nmz2IrJ8wEh1R01HrUi7lWw1fmqVQTDJlerTec/60WMPJ34wZpfuLKwDqvNWKrIEYFCI/FOdB4DsRbU4A+dzZnum4LGPMgBr4gYA2P5Q9TB8vWYCO7LidJqrfWVfvDiK1v2ijDxg3lrejkXxIXOLJSol16RGGqldn4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDe/RPMnXKM7lp6ZMF1hm72UOp4l0CXPnCCZke8rYRE=;
 b=sVXf0ipGJst+2xVKcFucYuIZV/h5Gajsln/JKa23fNwEX8VC0E+XN79+12HWixzMkqllsL1rSNmBknhI0oNUpbPYwlh6syn8jlGF1aQpkOgvIA/5L2zRtCyuud+6HAfDQGEG2xdVBky6e4R88AKqKHqLgidrN/+FpDzoppdv/e7x3wnUuR5m391+CZCB1IzkmOTTmvZIikqcvX/cN64xaOIst1Mz7jtKZbRMgtPCzNxdOsyMgy2TmXjlYWEe6CVOijZ/azTG0BX+WiwBNpgevYfGbn525KWa1fXPi4kKYWOvLlP0K7zCccrMH91jpuxoiEytljRlPfSIv9SCcR8YyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:37:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:37:54 +0000
Message-ID: <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
Date: Tue, 15 Jul 2025 15:37:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v6.1.145-cip44
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: pavel@denx.de, masami.ichikawa@cybertrust.co.jp,
 chris.paterson2@renesas.com, uli@fpond.eu
References: <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0294.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 890eb7dc-cc02-4e8b-173f-08ddc3a4cd38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a2M4VmJOamViYUp6eld3QlNMNTc2UFNWMzR3T1BvcUJSMWZHTVA0Z0dmYkM1?=
 =?utf-8?B?ZUlrWUpUQldFazZteFVxZ2NJSngrYW5VdUovQ3p5OC9oMlp4QTFneExmb0xR?=
 =?utf-8?B?YkZXQU92aUkyRXUrNGZUbzc3VmQ3aGRtaXFPS29DUndycFc0QTNvVndzYktq?=
 =?utf-8?B?aDg0U3pRR2NkQ1JiWXZOV3NDRmZ5ZnZxVE1vR3ZGbDVibm05YzE2Wmk4RTFI?=
 =?utf-8?B?WFpMcXVWMXVzQTlVR1V2cjZhRFNxZWZrWk9aRDhPd2t1bklMVWJ4em5NME1p?=
 =?utf-8?B?NGgvMFBHaitueDhNMFY4a1V3TFRnZHN0SGNuUGY5MnNiVCtOMFZ1SE9TV1NU?=
 =?utf-8?B?dmg1L0YwVGtSYzBKSDhRNGFyRWR2dXN5SEVCMG5MaXFtUW9CVzF5R1U0VGw0?=
 =?utf-8?B?UHVpTnRBQXdTWmZTelRjZVRZZGpEd1ZUOWo0NHNNa2hRV1lJVmZESkxWNW1Q?=
 =?utf-8?B?ZC9sUHU1WlJXWjBRYzczaWRnTXZ2M0UxZDhhdW13V1dnT3d3RFljTUkzWHVV?=
 =?utf-8?B?aVhKTlI1ZUttazVEQ0pFRjgvcGhZYXBrRDNTa1hYdkliai9GbVlZVHFEOElp?=
 =?utf-8?B?Q0dxd0hwZDdjaExYRHYyS1JJb2lJRHdibVA5bjR5a1NKV2FVMnhGOXc4Y1VS?=
 =?utf-8?B?b3F3OHViY0dYNnlkbExQaFo0MGFwcVkwWndaNGFRc3hiT0hHeTZoRXNqcDBr?=
 =?utf-8?B?K245RmJucWcyOS9yV2VZbzUwSGxBdVhxYUJUQ2htK0MyUlNtek1DZkxFeklk?=
 =?utf-8?B?WFhGbzZYZ0NabDJnOHMzUDYweTh3bXpsbWhsNjNmYkoxVDNPdk1IV3htR1Fa?=
 =?utf-8?B?OG1ORVY1dXJreHIxOWNsa1dHNGU3QWp1R1RsYk1FNGhNdXhKZ051dEprdnoz?=
 =?utf-8?B?Z2NNSitubEp6SXpkdkdORlJkeGZyM1UzTzNMY1QrUTNVZ3ZSRjVVM2ZNenFt?=
 =?utf-8?B?K3k0VXhMMm9uRnZPZm43QUhJVDdhcjZDV1RFajlHOWxsemNERE9VUWkwMzBD?=
 =?utf-8?B?Z3liOW9lR2ExaDJ1NE9YOGdLV3RmYmd1UERoNEg1eEJ6VE5UNnM1Vkc1OWRn?=
 =?utf-8?B?eWxoMDk0MzZyaXZUOGk3aHNIVUhiemliL1VEM1hlR3JvTHpVZWxGclVJNnRK?=
 =?utf-8?B?RkNxVWNwanBZcVpPcWpKT29HU1pBMEhQd2VLdzBKYWNYWGtWUURGNWZVTU9w?=
 =?utf-8?B?WjVGNXJVaEZkQytzT2lvSllrRHNhL0ZFQVRDU012bC9GcVRVT0RUNlArMXp6?=
 =?utf-8?B?OHMyWjgzRk1xaXN6dUpTZTBqeXpPMk9DRGVyNzgxdWtUZlJja2NPUlA3ZmRM?=
 =?utf-8?B?ZnRuazMzUTlPNU56VU1FNnoxdDA1ZXBjRUttOWJldkE4U2dtSzlLUm5nNjdx?=
 =?utf-8?B?aVhwWlVESlhldC9YeHJxTlZuTEZPTUVyeXNySWRQVG9SeHdwS3A4V1plbnEw?=
 =?utf-8?B?U0w5SERnNi9KakFnS1BONXNXY0ltb0VkL0Vsdnd5ZkZrSCsyNHpRU2NBLzMr?=
 =?utf-8?B?SDB2S0kwZ3ovR1dNY3Y2NlZ0cVdNYlhHNDVjNHYvUXNOODhmMER5ZDdOcjZJ?=
 =?utf-8?B?NXlYUS93R1BDaE02d1piNGpnNndSQjVBNXJkQm0rK2FiNXVDaTQ0UXlDeEkr?=
 =?utf-8?B?SkkwRWVLY2E5ODFaSDFLSTZjWU5vbnZzeFVaZGF5Zm5uVnRZc1FZTnh5bml5?=
 =?utf-8?B?dGk0YVQ4bzU2UFUxSW82Q1c2SUh4RUptYTQ3UXFPQlp2S1BQQk1uZThiR0xk?=
 =?utf-8?B?VnVXdVdCdlVuU0t4dnMyVmRkKzYyTkJSZkFSTlpTcjJXcG03T0ZiTExmV204?=
 =?utf-8?B?Q2txYUZGb1ZFTU1tVUtVZm1iQUJoMllEZ1AramswSUE1SUtqeFNSS1FyT2RB?=
 =?utf-8?B?TUd2TFY4NDMxTTFoeFl1MlViaGJaNW1hc0pXTXcraHhEbDZCVGtGZ3hVS3Nh?=
 =?utf-8?Q?hPHDO3QXX0s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFBkM1Myc2FMM2ZHdlpueU5MUUNzNDVFdnU5bVpOdUxlczhzb2RLb1NEak1I?=
 =?utf-8?B?VHE4ejlPVUxjeXhucjJUd2N6TE1sbEZxeUVJekk3NHYzRVhUMGl0N1lKa1dq?=
 =?utf-8?B?bzhNcGFiRjFVTFNtUGZKVndtTHBSbE4vWnZwS29BVCtpL1VwaE9JcjM1b1Fm?=
 =?utf-8?B?L3d3bnU1bkpCQXJhMUF3alZkN3hsQjlkL1FxMG43REJnR2k3M1F4N2RYUGlq?=
 =?utf-8?B?MzJmdnBabjVzNXNudXhzWnZXM0tGSXB3NVZEU2Q3TkRuSHdiUWFXUDJZYkM4?=
 =?utf-8?B?WnRsM292UVRsbUJaOUgwaWRwcEs1MjdlcnRuamxIaEw5cW1NLzh1TWhlTkV2?=
 =?utf-8?B?ZG9Sa3NoSlUzb2hJaHQ5SFJwVWExSnJYZ0R6SFNwOTN4azlybHlXS2lNM2E0?=
 =?utf-8?B?NTYvR0RYK01rNEpnWFUwVGZqTVMvZ291ZTZTRDhmYm1zZWtMSU1VWHlrSHNH?=
 =?utf-8?B?SHljbXY4dlN3SzVTMlV5TW1ENHVkZnA1S255VHNVcnFXbk52MVRLSHl3eVJ5?=
 =?utf-8?B?VEJvYjFSWE4xaVd6dXBzRzZQWURuZzRNemEvREtQZWFpcXJYQjhQR281R1N1?=
 =?utf-8?B?czN6OUdhOWRlUGxxcnB1K1VSNE9pQXdGN0U2WGdmQjlZekJYZjJDWUNwWWI0?=
 =?utf-8?B?U1lLVEdoVUtUV0lQaXFiZFQ2SGVlSFNRMXkreVdINW4rdnRyOTFla1dZbWE5?=
 =?utf-8?B?MTZ6V1lCVEsreTVscDV1YjBsbTJoUm5COG1CdTdnNy8xcHNQYURLWENzTEJr?=
 =?utf-8?B?b3o4Mk5aUDZhOTQ0Y2dHZkhoelJSMTFtQ1RSUU91VmhrT29YZ2xDS3RLUnZV?=
 =?utf-8?B?R1daM3pZR2QzMSsxOXpHeEhMOE5QakQ2L0ZRTmNSMUZVbWtjc1RoNUdTRTdt?=
 =?utf-8?B?VFRaK1Z2L1RzMTV1L1ZWaE1CK2ZsSGtobENib0xieThQZE1CdkhsK0xmcWN6?=
 =?utf-8?B?dmpTQ25nSlhIL1VpNUlTelg4eDdqcU1ab0xMeUlxVE1wL1Vac2R4bGV1bzh0?=
 =?utf-8?B?UVZpcndGYjZudDJLQlFQaHFLN0dKWk5ZMExXMjc3VndMNXIxZW5GdExOYyta?=
 =?utf-8?B?MnptVm8reXhRSmVKWTJwOTllS2hJTm85ZytvRGd6Y1MzWkVlb3JYTzAxS1Ay?=
 =?utf-8?B?Zm11S09sQ1VXVHdEdjU3ZmVnczlyc0xzczFOa2V2T0dJMW1lcnV2OGZqWEhL?=
 =?utf-8?B?QUEyajNVUVZYN3pQd3lMSThJN0RxbnFYWWpjaTBUU3dya20rTHE2Y1pXMW9x?=
 =?utf-8?B?bEtpUDgvWk1tT1pVbDNnL2oxT1hnU1RtbTFJMUw0NUZhSzZudUp2VlJqNWl1?=
 =?utf-8?B?OHpTUVh4dTVBQ2MxQm5PYUtQR3o2SXZtdUcxUVJIelhhL0ZmckcrTEJDSG9K?=
 =?utf-8?B?UExhZG9FNDNnMWVEYmx1czFCek91NkV4aWV1ODJ6NjZOamFqendsM0tKY3hL?=
 =?utf-8?B?clBzcjZ5NnZOSnNpRGVleFJXVHArTUYvMUxPVXEzWTlwdkkvaEF0UGxOWm9y?=
 =?utf-8?B?aVA0eWNMazZVWG5JMFBoTkovOG9hWlR0dXJZd05ZV3NyNHViTG5Ob1ZicmlB?=
 =?utf-8?B?KzhjS1JnaW14MW40bkJUcU9WaXE2OWlJcFlsTUVXZnNEUUFscCtPNmpCRWtG?=
 =?utf-8?B?N1RUL1pIcDlIbHdYTGNWNTJQcmIrc3cvckU5SlN4UDhWM3VTRE5PbWkwUTlh?=
 =?utf-8?B?ZG82dUdramVqbGdQUG8zMGl5RUZuSFdPT0U2QWYra1NZdVNxN0VQaTRFQ1Fp?=
 =?utf-8?B?Vm9kdTl0QWZyWHVwL0d3dGRJb1BuVDdoQXc1NmluckFpbWNGd3dRYng2ZXFs?=
 =?utf-8?B?WDJndzdiZUR4WmJSTC9wZ1IvQUxPSEJPM0lQa1k2YTBTOERIY3RuUlNHVW8w?=
 =?utf-8?B?b0RkbUVyOHhPZzlOVlpDRlBEVEtIK1ZIYjhoOGJ5aTQrdkhxcEVjNnpPQ09S?=
 =?utf-8?B?bEN4aDN1RGRUcHdwMSttcjFjWGN3eEphbnlTZHc5ZmJla3d2dWZabE8yM3RH?=
 =?utf-8?B?M21jM1UyWEJGcUVpMEU2M2N0Y1krRmxnMEVhaHJRcnVqUDFUMzJlNnNzemwv?=
 =?utf-8?B?aWJtQTRNNlByZWxjV0VpT0dpWnBIOUx1N0U2cXlNbk1LVDV3K3RHSlNZcUFT?=
 =?utf-8?B?RmpHVHFCcVU5WUMrbTdmRDNRZGpuQXNvVWVWTzFYN0t3a1lvbUt6Zy9LMEh1?=
 =?utf-8?B?L1RyclBTR0h6MXNpVjhLb0haQVV3UWdOWDNJZ3prVStiWlRxanZlYlZvSklS?=
 =?utf-8?B?SG83MmU1VkJtVVp5VklSeEdCTUhBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890eb7dc-cc02-4e8b-173f-08ddc3a4cd38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:54.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/emMVjAbNMucIgstVBPUlISzPM7/eQicCqR1G/m8LKUYp3jaUw6Bqkiq4yMLhNQ38yJA6fRdt/1GauTwI8RoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 13:38:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19540

On 15.07.25 10:06, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
> 
> CIP kernel team has released Linux kernel v6.1.145-cip44.
> The linux-6.1.y-cip tree has been updated base version from v6.1.141 to v6.1.145.
> This release added updates for iio, clock, mmc, irqchip, and drm on Renesas ARM64 SoCs.
> 
> Information about this release is as follows:
> 
>   v6.1.145-cip44:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git

Is there an infrastructure hickup? I'm not yet finding the tarball on
https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

