Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92BFC38150
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 15:37:38 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.83])
 by mx.groups.io with SMTP id smtpd.web11.19961.1720193849623381570
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 08:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PiuuS2TR;
 spf=pass (domain: siemens.com, ip: 40.107.249.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4In3+GCmfKYjhFZ9Dh29h5KiKHdeic5mdMYbHDQX6MilSC49qA4eyLGVhKeH9ksyHnCAnGS/n90SY41L5lYQKkdNfX628cx0W5ON1pgsSVxqx8BQQ7W01ZaUBruULYxPI+KSyAc/6DRkQAH5eDawXpWO/4DSHwEl+twd5/5lb/jLSngRvGWpN7Px0UQKiumSodBUU8s6Gp8UI70QwHjUC9IEzzL6zr+7Hz9lrcnoRpSd7EyexWLtpNNKOwNTMdZAY6BBYJ6sh+tGY6nSEK9jr+GtIFNyJzqLFHWncuNYw/W7JMRfb499CAnCdOqnK/61ZEpUBsLxf5thWDV6MY2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQelXedsw6ajeoND/LtxNx+yUY/mqPdVcNhe5uhwfrQ=;
 b=oOEh0xgTRoYotOUnZ5PrYdg8l2F4+CA6sNitgJTqEaEleybTOXOdh2DBQUqdirPkhQnwfDSlfnMCo5inJznzO+4hX7AwkQIrVUgKK9WZLCpRfpHOfN1DQRKO6ZGzLcC/17ihle9XxOvftZ4I+xKNvWSufjBwUmDSBZ2WjTPEpjHFP934dFdOeaq+RhYV4TDNchJhmUPj0loBbkfBPyjf0jqX6l2J1Uht4lyHHf/httMcHRzRZl7u3y9216uME1NcA5mvrujBTxIr4cKh6ktDnbiKfGU2leuSFFWBuENqKxYYMyJBAQAS+Iht7e+j7zLgbk5wP5W9RRgiwhPzGJYkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQelXedsw6ajeoND/LtxNx+yUY/mqPdVcNhe5uhwfrQ=;
 b=PiuuS2TRBqhwujFp4JctpGf+MWXjpkK5JAkrXz2Ke/bWmwPgctfxbYgoZaB7k2CWT5LGemf09IywiRe0noYI32QG3erqUnVeDi85Qspfu/ca8mKLDzXmocISwsZP9NL9OyVEs9WISBHK9xhX45ejIFYGRs+u4Qsp0vc8JSTp9DRwgNHLXlTOGMtG/HvVHfRHMffvatPTGw8sjRQbTA3Vd/CNm/fTdZzq8X9NQLKDn3kI35HkeyOAb0C2OSnfUFYzLc3pfa1A/3kNUJORQWVXMr5cUBMD2AhxAAlCIzIdnvGZs5QusiDlJQ+raQwbJLTX0cT1fDCFs/q1Xh/IqlFcMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 15:37:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:37:27 +0000
Message-ID: <9b3b45f5-41f0-4009-87ab-d306f607283d@siemens.com>
Date: Fri, 5 Jul 2024 17:37:25 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 3/3] ci: Require IEC tests to succeed as well
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <0f90dc2b-227a-42fd-964e-4086d00e9694@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0f90dc2b-227a-42fd-964e-4086d00e9694@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: d007103b-38c9-41db-4236-08dc9d085f9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3dSRU5OaHhOV1o2L25uS040L3pudERqbGkwU3ZjdnFheDhYYlk4S1ZQeUhr?=
 =?utf-8?B?UTR4S2ZRYzRWRWZwaGN6cEYxK1NsbWdRVHRGY0Nzdk9zWUEvQ0hweXdhQ3pG?=
 =?utf-8?B?MU1veFdwTi90YVQxNjZJVWZBMkgrUEh1MTZzMGxNQUk5QTVrOU5UY0RNT3JH?=
 =?utf-8?B?Uk03Ykx0QWVkRmU2L3Y2TnV6UVJXbGZlUEFMaXUwazFxR1A1NVVEdmJKK2xx?=
 =?utf-8?B?aWRkcFlub2gybmlKQ2lqZHRxYVk3RkxkN1BJT1dDZW1nMXpFL2U4Tk1haThQ?=
 =?utf-8?B?Z1lkN2lab2dUaVhBM0JNQ0EvS3ZNblE5SXlQMXlLZCtsaEpjZVkvVTJ5cDFX?=
 =?utf-8?B?NXhZYVJhSHRMbW9zTGpBdnVrWWJ0ZFdUUVpBd0xCU3N1QmJPb2lpOWNzbkR0?=
 =?utf-8?B?ZXJJaktLYlNNNitTejEyQUZpWnRQampOSSttdys4SHE5dFNJRklvUThaYlQ4?=
 =?utf-8?B?MnF4OTc5UlQvZFVBdEdQUk1WYVo4RzNyM0loZHFEM0haQWtxTi9tZTQvZmFu?=
 =?utf-8?B?TE91dFVNVW94UUNXbUtuU2g3ZUVObmNZcy9ucElrQjNVSHlqcHhmb1RLQ1I2?=
 =?utf-8?B?UWxoWUFUQ1c5aHMwUFhjeEZqTlo5ZWx6UU5RMkxKQnRZOGhJVUM2OGo3ajM4?=
 =?utf-8?B?cTlPbHFKZGM0ZlBkdVBtQThLbGtHNTNRMlFsZFBzNHY5TnMycFpFeWVJTFFq?=
 =?utf-8?B?bXJYRmh2U29TVUZ1UWEvT3MzZWthdHpzbktVdTZHWFBqSW9kY2NwM2tGYnNp?=
 =?utf-8?B?aXRNeDN6SW5KY3plKzJ0STZ3OXBEUkFtelp0UE1ZZE5renNPbVY5R0dzenZs?=
 =?utf-8?B?WDFlbFlKdFZlYkJKL2dBOGxkVXhRN1BSY3Mzby8yVWRDbXdSWGdvL3NrMm1l?=
 =?utf-8?B?SElUR0NncEordDdGdzQyRmVJZ1VnSEROUzVydjJnNkRPMlhWbWxMQ2RNRXZi?=
 =?utf-8?B?RXBxd1hNY29TVlVjdFIwY3djdEh1RG5LVHNld3Bqb1U4YVJTZXIzWmZJcHRV?=
 =?utf-8?B?Mnk4ZWxhQURmbFJjeVRGdlZQam9QU2N5SjdKeGRmRHdmOWliWUtIQnNuRDIr?=
 =?utf-8?B?Z21SYk9VV05MRUJGaUZjVFNMVXNMOGdEYW8weUJyYzJ2U3cwSlFkZTI2YnRJ?=
 =?utf-8?B?Vytua082Sk9WbGVCbjl3a0pXT2hPLzdDV2p3WG5vMzdsTFgvQkhWdGZTMThH?=
 =?utf-8?B?T3Q4ZndiSmZJS1dNVWVibi9VbG81aWpLcTRPRHVNMmI4L3YwSDRkSkxaUHc1?=
 =?utf-8?B?MDlWeiszT1VDZExmQ3IwOWROcDZMOURYQkRJaGFCbE9IM2FSeUpseklsQ1gr?=
 =?utf-8?B?Y0dmQjBhRDZFZDk1bFF0L3lKQnpnb3U2VTZ2d1haRHFLc0xKT3psOUFLS2pD?=
 =?utf-8?B?dCtHVFRTaHlDUDZzZkJJai9ONVFmbjl3bXZveDVVSTlDb3Fka2ZUdkZwOWgy?=
 =?utf-8?B?YTA3ZkNENmhEc3psZjNadnROd3Jia1g5Z0dNTHhtVVc3bEpIWXlqdUZMMVpv?=
 =?utf-8?B?ZXJ2R3dCWkx1SHRseU0yZzM1RHc0ZTYzS0xGNjhTdWVxVkQ2M3J2NHFQRndP?=
 =?utf-8?B?bDc0YUU3dGdrUDBHTWQ4aWd0Tit5UlE1TFlPV2gxRGRuMVk2TWpieWdoOEZp?=
 =?utf-8?B?QXNKMjhRdlpYWWdiY1NyVE5MRUVPWmdaSnBKUjNNVmxKNjNFc0FhcFRZdEFU?=
 =?utf-8?B?Sy9tZGk4eUtrS25BaTNrVTlTWG5PeUVNM0RyOEtEaFZoWTY0Ry9FY09BUU54?=
 =?utf-8?B?RGNXY29IeUd0bWhLZUtBWXhSallMRnVNb3FORkZnMjZ6YmY2WGlLN0FlRlcw?=
 =?utf-8?B?TTVqcmZTdXF1MGsrd3R2Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEFFdXJZSnBaZC8xYXZFQVR6eCticXFsTzR0MGNCWjNaZ2NxQkloazFCWmdi?=
 =?utf-8?B?d2x6RmlubEJnUWcwRE05cGhPNFovQStPV0xiRmFZNGE5UitBS09FOGs1SHFs?=
 =?utf-8?B?eHROOEg3bGFFbks4VFVKczZCT3lGUUZmNCtGZzdYRVdVRzdOODRPSWxCM216?=
 =?utf-8?B?VURzaE5RS2lMbXlONVl5bW9iVUpEYTN5dE16MFI4eVZEUXU5MHFjNE5MdVBz?=
 =?utf-8?B?OUZ1RG9TaGJUV0o2UFViZU1PR0Vqckp4QTl0TkgwRDNWM0VoV3U0cHl6N1My?=
 =?utf-8?B?a2FHdDJXQlJPclpBZHF5ckc5K092NzJabTk3Y1gyZ0ViZEovSEZQMUFINmdk?=
 =?utf-8?B?dGUzeVN5cG52UmcwSEVtUWRjZFhKVzduRm1halB5cWxIWThhZDhlUUQ2TURS?=
 =?utf-8?B?MThiNStlRWxsNDdFallrcnJwRTJBb3cwSzREamU3RndUcGhWTVEzL3dKcHhN?=
 =?utf-8?B?VGlNUlE2TWcvaXJkV1BRWlhVanZvcjJQbTZmZTlsOGZqZ2M2akRNT1pZMFkv?=
 =?utf-8?B?bU1rbHVxc2tYbm5EYTJ3b3pxajJrZVI3MTBwSmhFYzhzbUtTVTZHbzZCdGg5?=
 =?utf-8?B?d2RuaTdEdThVY1ZJU0RpdVoxckRWYk5pc1RCNFNIb2Zva2J3SVZrRDgreVFl?=
 =?utf-8?B?aWc5RVo3dUZZNkFSUUsyZHdzdURHOEwrL2U3M2pDbnc1M0tkSy9YL2piNHRr?=
 =?utf-8?B?S0U0dldkd0dTYU9MaDBJWDR4anh2d1N3aUg0OXgyV1REQVoxTVV3VXNud2hN?=
 =?utf-8?B?cHFPazhlTkdyeFJjY3VydWlaVzBEQlRyUWo2eFZaVmxHTlpzd2ZNVXg5ZWRj?=
 =?utf-8?B?MEpEMFRYT1JPakpXajVXTStoVWhpREVzREk3anEwOHUvaEJHcjlLU1NGSzV1?=
 =?utf-8?B?QkZYT1ZISk5TUXhnWEc4dG1QeFVqUVVQb3JBcFdDRTBlblZUbzk1WklwVERt?=
 =?utf-8?B?R3ZxL3RBR1VtYkEwYVJzN1I3RkJPMnEzSE01czRpS1M4TTFQRU1KTDl0ZmxI?=
 =?utf-8?B?UkREaUwwSHZORFZYaUJRby96UnNIL0NKY25Mdmd1UGZVYm90bDZKOEsvQzZ4?=
 =?utf-8?B?TDNsdFBJYjdHUXc5SWxnNFY5aVc0d0pvRzZMMmNlNWNJTHlaM1FsSlYrWExI?=
 =?utf-8?B?NTFpZ1M3NTgxcVJrQUQxZm1Hb2ZVMW9hY1lCSW5jRGNFOFkrWmhqeEU5RnJQ?=
 =?utf-8?B?SDQySUtIYjNXTjJ1SmdEWW5sTnNYRForclJwV1J3OGVUaWkvYVJ4MW5sZ3Fu?=
 =?utf-8?B?YSsyTTFJOU1GUTZJUnExWW9EYW02U0l1ZVgyblEva21vZXQxWk1HSzFuVVRw?=
 =?utf-8?B?alVQTXRYWmxpUG1sbXBtZCs4Mk5CanNtcTJteEtuU1dpV050NnZSc3ZpN0tr?=
 =?utf-8?B?alBlUzRDKzJTd0hZOVJXSHNteVF5VE55Mmd6RlBLTG5aYU1va0xaV1l6MVh1?=
 =?utf-8?B?eVRxYlpzMzNPK0tYOGF5OXdDQVk5ZGQyM1dZbE5BUHY2QTFQZGR2UFczanVS?=
 =?utf-8?B?eFpYOXR6ZktqUy8xT0w2QU9kVUQrQkRSZWJ5RW5KTjFNdHhKNnpnT3ZrWjV0?=
 =?utf-8?B?TjNiK2JHUGVnVC9jZVl1anoycmRFS3BhOXQzRG9vOHN5d0p6NCtTMGpGY0hL?=
 =?utf-8?B?blRrNU1nZ2xFZG1sSk00dUlFZjZwOGJJQ0FjNW1YWU1vWjVZZzc2WE1uV28y?=
 =?utf-8?B?YW1abnhnYUdtL28rcGxNejY1aDh5dVY2Ry9RUTdZZUN2V0xYcTFoVHkvaWNR?=
 =?utf-8?B?YXg5STZIODFJeGpHZVBIYmF6OVUrazg3OGJkaEpIWTIxVkhveWxCb0F6Qi8w?=
 =?utf-8?B?Q3hBYS9ENWdoU1FZQlY3U0FkTkRkV0pNTk1hM29XUG5jMEJoaG1HMFJVdjdr?=
 =?utf-8?B?UEJrTEtYZUVVVmYwcTVBYkI1aVlkWHUrTm1KMmtoZnFTdE4xaTE3TmQ4cnRF?=
 =?utf-8?B?Y1RiWVRqZ0ZuNDRxQmJaVEdJdk5tbkV3RnN0SEhNWjgwc0JmaGtSYnZqM01o?=
 =?utf-8?B?WVpsOUwzbmdWTmwxazh0Qmx2Q3dleW5LazI4L29na2JIOGViSEJBeVd5T1N1?=
 =?utf-8?B?ekpORWsrYXBCTld3M0JITFBaOEJFNFFZSGgzdUZ3WFFRakFHSnlRWVVDNGR5?=
 =?utf-8?B?Q2hSeXNiUGNwWFg2bUQvM2lXY0pnZzl6QlRZUWhoa3VDVXFRTGhNY2Z0UE8v?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d007103b-38c9-41db-4236-08dc9d085f9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:37:26.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ob1l8058mBSE7lb3DIVTeShUpxPP5i5VoMjHHr9n7UpZ13FMWKnL09PrtsIcjcmIOVeH7TiGMadnccPcdfYgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 15:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16421

From: Jan Kiszka <jan.kiszka@siemens.com>

With the modifed failure detection scheme, those tests are no longer
reported as failure as they do (yet) let the job fail when a testcase
fails. Now that we pinned the test descriptions, we can also rely on
this property and enforce that the lava job and, thus, also the
respective gitlab-ci job succeed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 683790f4..ab1835a8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -436,7 +436,6 @@ test:qemu-amd64-IEC:
   variables:
     target: qemu-amd64
     test_function: IEC
-  allow_failure: true
 
 test:qemu-arm64-IEC:
   extends:
@@ -445,7 +444,6 @@ test:qemu-arm64-IEC:
   variables:
     target: qemu-arm64
     test_function: IEC
-  allow_failure: true
 
 test:qemu-arm-IEC:
   extends:
@@ -454,7 +452,6 @@ test:qemu-arm-IEC:
   variables:
     target: qemu-arm
     test_function: IEC
-  allow_failure: true
 
 cve-checks:
   stage: cve-check
-- 
2.43.0


