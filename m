Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B27D59D90
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 20:05:13 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2499.1765569904863352288
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 12:05:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i7m/DNZy;
 spf=pass (domain: siemens.com, ip: 52.101.83.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueSHAJ5fSWyS92IdleBeTnfNOMQM+/7m3NoUx+fhmEACwQisJ5//4BWCbGMCgijdP2874LKguFo+jk7Z7j6QlZLf/CsKUAhYOHMFylsGblahNr5+GdnqIroAQe1mRR/a3Eaw7YHtY6aVzx0NHQsw7s7XewVRLL1C4aZq03ll9lITEi10EAulgB2gLtSc8fDdvoGa+9JhfFZcRqUUfvoC8lWak8vIooYP6IQTUBWI65Fi/fhLgk+WKSHHy2FLbjKCCujKIjWW+E55NvVWebyMybGeN7P6HPD0e10Ow807AcBiOyHeXvuf03FWHDZhhN5x+0cxiBJ55Ewlc/BbR8K6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27uKeP8t+gJhmahOwsGes7HBrJmXo8+5ypBwNuDM8qI=;
 b=stDPoUU7+IodOR6rLABOEOALYiX1WgAoLzVl2A6GGYpqFO0qAD2xWlqEmbkzIrY6S/zlMwZEMOcTxcVeVHtLHafiU0wrLXVswI3Oejkzymtcs6EKPsb8qbbE4qUEHkDFReeoobi4Ule1j43plBe7ayfwCcIbLnXuOlizG6cDIzVzZieOXbC7dPp69dF6mwSkWGSveLpvAETAszjqX4vxC58vN/oqppvqqH5WBBIWbhCuUbhlfrsWulUoZXl0V6QlC7QeUsuIC7FA+u/H5Wa+pNQ7cboV3byBTXYiCfbsnyW7BTuorK+W5nH0L1Dd0vERIQYQcRR2YvJNjjNqofOU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27uKeP8t+gJhmahOwsGes7HBrJmXo8+5ypBwNuDM8qI=;
 b=i7m/DNZy52I3PIkPsFl+cdS49RBODjwEQPHDV7dVNvcTOpxH7tthIH17hcAmsSHD3V6fmlbpWA64SS9qi10yimIDnW+/JsaWp6diEFfrXBngAxHiFRXiodDSAHHkbeTiYjlp3LaEvKrW/69QrI32n57Sc5Fuq1mt2PYUUGejZpMZvbZh6hlgwZKj8/HZT7YwadnJRC5/1cF4uq5dhNk455ErYX6SwxZAKLkAaXZiSH8FTeka3MUSObWio/KR+yI5JeAztlCXF3yyWDi/4hNVyWoBwrtZEvJ17TvAr6dONDixfqXTjLrWssZ2ohLv0BaRbe6zyPKwS8Z1XTjBZiwAXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 20:05:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 20:05:00 +0000
Message-ID: <c0f8e7d8-4b60-40f0-b71e-2649a744455b@siemens.com>
Date: Fri, 12 Dec 2025 21:04:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Use exact matches for COMPATIBLE_MACHINE
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6870c49c-ee44-48af-3a80-08de39b9bad8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1pTWHZ0VkRHMEtaQXFBV3BSSjM5S1dIWjdXb0d5M0JIMHNqNG8zSDVTcU44?=
 =?utf-8?B?SVBvaDV6bHV2a3FPM0NQM3RTVE00TE9XR2tqYUVCVTM1TG9lM3hSOEFmUDYz?=
 =?utf-8?B?VzNORHRXTU8xSk04OG9JaTBycnpTV3ZMcUtCcWVRSkZPRnF1dXJNcTJmL25p?=
 =?utf-8?B?bkZKcWo4UUJFYjhLc2hPcGF0RXExV0Q0dTMrY2N0aVhXSi9FYzBXUzhKZDhr?=
 =?utf-8?B?dk53MjZDVDVyT2xvQ3pueElsaWpQcFpTdGFOOE9ZT0d5cFZTaGRiV3dtVU5X?=
 =?utf-8?B?U1VSRmtvbFliWHBVOVJTVUsxcXdQaUJFLzFYckpUN0hoRWV6eHRUck5ZM2Iv?=
 =?utf-8?B?QjhtZjFiSms5L3dsSEdRYzV1T1YvWVpYYy9RbTZtTTEyOHY1NGFTcVhFcllY?=
 =?utf-8?B?SUJUNVMydm5PaFZHamthN2FjcVZvKzF3aEUyQUdzSFZMRzRhRXRQZUVRdmp6?=
 =?utf-8?B?b2J3S0JmTmtCeWhHOUl3dlpUeTR2d210eDBWOHhQN1pZSzZmYVBUcDVnMFlF?=
 =?utf-8?B?c2k4eGVnaUFzK3RFNHdtb212R0l0MXNtd3RrdkhYUGtrUXVzaUI3WlNJanBo?=
 =?utf-8?B?RVRVQ3VyZnIyakNiNEVNTDRpVkF0Wi95d1ZCSTBna211UGo5NW5HbHo2Qnhz?=
 =?utf-8?B?d3Rkb0RvTXRJcCtGbWhoWFFiWjFMQ1ZWTUtXVGRUMHhvME9FNVFselFDZ2NQ?=
 =?utf-8?B?ZkpRS04yTVFIQ0NTYjRWQ2NHWlRyU3JhMS84SmdOTTR1NmNPMlNWd2NnSjBV?=
 =?utf-8?B?NE5mSFNDcjh3TlNTOXgxenBqZ2tHcHRTQzFEUWFsd1hmb1dDRU1pcjNBSTVh?=
 =?utf-8?B?bGRHQ1JzU2VtQVhQeGFxWGxKZm13UEhRNzFEa1lKZG9JaWE2WmU5MXB4REhn?=
 =?utf-8?B?d3Z2dU9JeVl0MjBLMm4xSWsyRzl0Sjdxc08rcUNqQjVZWnhPSmRkUU44SFlZ?=
 =?utf-8?B?eVc5WThjOFY5bWxGTWZzbDQ3cVdmLy9HTncyd0w0S29BQVYyUXh4b3lsZ0Jp?=
 =?utf-8?B?MTV4ZFVtZFRvdkRLR0xXVWtkamxDR0NObUVxaThJZEVKNWpLUWIvd0lnZ3hJ?=
 =?utf-8?B?cE83d01HNytFeDJxMzRTSG52M1dKNkVrV2xWdGlSb2cxS0k0Mkx6eW0rNzFI?=
 =?utf-8?B?YldyTDVEeEZpZXJvQzJvSFhkSzNKakxVcmtRWFhjckN4a3I0ZFJheXdtY2lR?=
 =?utf-8?B?SThrT0JrWUJocXRna0dRNHJySnUyVHNpaDV0M1htajNOT2N2Z2p0ZGN0ZWhs?=
 =?utf-8?B?b25sQ3oxVGM5ZE55YUQ2M0F6RVo0OEgxL3pGV3FZTTI3WUxKcW4rMUJ1RmhV?=
 =?utf-8?B?dXF5TDZvOW56bExhWUozOFJLN3gySi81UlJvSHA1cXF2SC9OdGlwek9CUzls?=
 =?utf-8?B?dkV5SC9RbVZ3Q05IVmpaVjV2UTBIUzBmRm9lMzR2WGEycnExOHV5VzNVMmw4?=
 =?utf-8?B?V21BN1ExNFNBYlRvOUtJQ3FsK29nTmhIRzAwS2hPTmdBWThNdXJxNW1xaTR0?=
 =?utf-8?B?blB4YWtncTZTUzFiVktremdYdm9neFR5TGNsdzBOVW9jY2NoMHRSRHZPV0RU?=
 =?utf-8?B?RkxxR05ZbklpTzFKVXE0ajNtdll5Qm5GUjVlVXVSUElEU3BMQUE4cXQ4TG4y?=
 =?utf-8?B?Nmg2NE5pY0JMSWRyaVFIeHNGZ1Q3VGhkQ2J4VHJwVGFoM1dZT2V2Qk9ENzJZ?=
 =?utf-8?B?VGFKVmJuK2NzYXZsNEU3Qk9kRFo1c2Y1TWJNVTcwcUhkcGEzZk9rTkgwMnVj?=
 =?utf-8?B?bnlwK1Zaa2IwZkl2LzhEMElmdVkyVUY3ZmswSU5OU2lLNDZNQktmWXJraE1P?=
 =?utf-8?B?L2FnZjRwbElUZXVHb3hqajY2cFBNemcrQ2lXWDVhSm4zOHJ0c3BFK0hsais5?=
 =?utf-8?B?QWptVHRMSnhMODV4aFFvczU2d3FZNDZWcHdITkVPYzdYT3AyWWxyNStCdWxk?=
 =?utf-8?Q?6L7D1JCrFoFNxNq/GiUjg5/+c7sLSLP+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0pEQWhqVVVtcjhiL1MwbXRyaHlPRTd0YVByUng5b3NHdzJQSXJ5czV4M3A0?=
 =?utf-8?B?cjdMdXhxMmo5bkRteUlOZG9sdkFqanJXTEcwN015KzIzRTNwWmNyOEhWNm9o?=
 =?utf-8?B?QjE0NDl3Q2w4WmNZR0RsbFR0SWxpME0wOWdQN3IrYVFlMVE3dE5KeUV2dVJ5?=
 =?utf-8?B?NUdWZURuNVppWlpod1B5d1J2Tkl1R1BMTmw0Zlo1WVlBcEdWYUpUTVM4dlE1?=
 =?utf-8?B?RU1OcnhNVUVjRko0U0tZUU1hMmtleExFZklTdHQ1ckorLy9kNTJQNHlvVCtT?=
 =?utf-8?B?QTZXVlFDODc4c3RuNkdkL1ozZXV2blNGRk9sYTArY0czc0RTdnNHU2RCNndW?=
 =?utf-8?B?VTFBRHkwNzZSUWFRdzVuNFhVY202VWhiTUlsMUlHUkkxbHV1THgrN2FwU1lO?=
 =?utf-8?B?Y0QvdCtwVHJZWmdpWmxWYjgyWXprelJyRnRmL0xaZzdXVzZteGc0YzZHd3Jh?=
 =?utf-8?B?TWZpbTBWenpCMThSVFkyMEJkQndvUzlSaWJuRkRQVTNkYzR4a0VWQlN3TDNM?=
 =?utf-8?B?UDF1ZEJkZGlzaFN5QkkwVUsvNnNYRjVXTEI0MlowS0c0SmVoemRZNEgxWVpQ?=
 =?utf-8?B?cDFsYVNiRFdWeGhaT0cxcU9NZFlQek1zbkQrS01SSkhUQkRZQ0RZcFFaTkZG?=
 =?utf-8?B?Ri8walFrR0VyYjgzdnZDUTlrdWV5dlFRblNqUkNVMHRCRDRYK0lRazN0N3pQ?=
 =?utf-8?B?VXRhemduS3Zadzgzb0RYbXplRWl3LzdZUm5VcXdSVGVqMUpTcEtlckZuQlYr?=
 =?utf-8?B?SXF5cGZSTmxXclN6MlZ5a1g0OEsrNjRXUkJ0clFTOHFHYS91cHJHL0h1Q3pK?=
 =?utf-8?B?VDM1endEM2dhNGdGLy8vd2tIUmEwUi9KeTIyUUQ4UU5PdFE5R1BxbytkN1NP?=
 =?utf-8?B?WFUzMDVMMm55SnZzUU5UN1hKUzNHSjc5cTRTbWVaakEzM3pER2NicGY3andi?=
 =?utf-8?B?SGdLVFM1eWxFUUlLRlRtMHdqWjJBNnk5RVY5T0phUUV6Y0J1Y1poQ2dDaUgx?=
 =?utf-8?B?Q0Q5UkFsZlp5OC91aVNQQ2ppclhmZFhPanhCYkJPRE1PQkxFVVBUazNydkxD?=
 =?utf-8?B?b0tBSVdFcWtLNEd1VWE1cXllR0tudDdFV21VdHc2V3RpMlpNT200ZUtSdTJi?=
 =?utf-8?B?STYzN0ZNeVVHd2ltb1orRTVIWnVzOUh1U3RYRmxVTEdFWG1vK25peS9yYUFW?=
 =?utf-8?B?dm1aL0FyZ09BOTBpZWFRSHIyeS9BaUNiWHhCd0hqM0tyWld1NU5VSWpuSVhR?=
 =?utf-8?B?TG9Xbm9lRVZlZmdhaWRlcklpL0FpU2t1ckdDRDVqaEtWblJEZVNXZXB2clRn?=
 =?utf-8?B?VnBxUEpDYTJ6Ymg0M0NENEl1Z2RwZjZFZkhHRFUrM3UveVhwMUFkNjNoSHJD?=
 =?utf-8?B?eUs3czdlMnA4NjBCdkdsbDRQMWNzODdkd0hkSHpzYlgxWXdwbGpTSEJabTk5?=
 =?utf-8?B?bUxyUHVxdE1zWE9qcEFsWDIzNVpYZVI3REdyYnBlUHo3c2MzSXZXVmNVZHNh?=
 =?utf-8?B?Y1RLSEhQRllvdlF3ZklrWFJCWkZlbTl1NzNzbFZaY29BOFdxajJHY0kwYlRF?=
 =?utf-8?B?SGYwbmthUTBGQzNxeGlSSFp4OGg1ZVBUVTVDYTJFOTkxK2ZoanBFaTUzWmpJ?=
 =?utf-8?B?cG1TZW9sdUljeHFyQ2M2SE9TMTIwM1RTMkFRUG5zdUdWNldRSjgxVFkxREhU?=
 =?utf-8?B?L1hDN0phekduVWZDUXo1cXd1bVhCVWk2QVdDTkFEYVVMYjFFTDJYellBWjFU?=
 =?utf-8?B?NEZLYkZaWndKM0Q4V0s4ZzhmdFJmRDVlcUJtVkhlMko3K1BxV0RjMzFzQlNx?=
 =?utf-8?B?K3B3R2FESXo2OEhtQXJQZ1gwNDdlZENBT3dZMGFBb1g4eWVuSlJTam0xMEE4?=
 =?utf-8?B?Tnc5K1VoaVJ3TWpMK1orSUtVTVgrVjhScWg1Y1BlRFB0YzY3aE9wazZrNURK?=
 =?utf-8?B?Snc1OFhqUEtFV1pBZ3hpVjdsRndrbllxMDdKN3BuM1FDc2xZakt4THVkMmN5?=
 =?utf-8?B?UTFWYTVQZ2pzRDBLMHFGM1pOSGlldlJodmQzU0JxUVJRcDNXWTlnaWdoNlBa?=
 =?utf-8?B?TTF6SXlFczhrVVVMM2JYZWoxNWg5TEN6MjFDQStLN1V6RE05RHg5V3hRbjlq?=
 =?utf-8?B?dEh2NVZiNmtxL0ZxYTNGYUQrdUx4QThhNmNKbmYzazE3a3JyRy9jLzU3OWlV?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6870c49c-ee44-48af-3a80-08de39b9bad8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 20:05:00.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV3RgP/y1RupGSA8Jzm9gc1VPb/bjfAcMPO1pEc0c66tk2eHj22+WVj1i2vt0h1wyf2od+MSIojdQUiVIo69zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5865
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 20:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20993

From: Jan Kiszka <jan.kiszka@siemens.com>

COMPATIBLE_MACHINE is evaluated as regular expression. To avoid wrong
matches, e.g. qemu-arm on qemu-arm64, make sure that we only match if
the current machine is identical to the expected one.

Brackets are not strictly needed for the match but improve readability.

Fixes: 4ba393e85e5a ("u-boot: Set COMPATIBLE_MACHINE to drop PREFERRED_PROVIDER_u-boot-*")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb | 2 +-
 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb                        | 2 +-
 recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb               | 2 +-
 recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb                 | 2 +-
 recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb                   | 2 +-
 recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb               | 2 +-
 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb               | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
index 5b572bf2..070b9a5f 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
@@ -19,4 +19,4 @@ TF_A_PLATFORM = "k3"
 TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
 TF_A_BINARIES = "lite/release/bl31.bin"
 
-COMPATIBLE_MACHINE = "ti-am62px-sk"
+COMPATIBLE_MACHINE = "^(ti-am62px-sk)$"
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
index d62058f6..956aa446 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
@@ -11,7 +11,7 @@
 
 require u-boot-common-${PV}.inc
 
-COMPATIBLE_MACHINE = "bbb"
+COMPATIBLE_MACHINE = "^(bbb)$"
 
 U_BOOT_CONFIG = "am335x_evm_defconfig"
 U_BOOT_BIN = "all"
diff --git a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
index 0dd67db1..b8cba972 100644
--- a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
@@ -11,7 +11,7 @@
 
 require u-boot-common-${PV}.inc
 
-COMPATIBLE_MACHINE = "de0-nano-soc"
+COMPATIBLE_MACHINE = "^(de0-nano-soc)$"
 
 U_BOOT_CONFIG = "socfpga_de0_nano_soc_defconfig"
 U_BOOT_BIN = "u-boot-with-spl.sfp"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
index 40a39858..a3742ed9 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
@@ -12,6 +12,6 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
-COMPATIBLE_MACHINE = "qemu-arm64"
+COMPATIBLE_MACHINE = "^(qemu-arm64)$"
 
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
index 416462dd..11f32dc5 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
@@ -12,6 +12,6 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
-COMPATIBLE_MACHINE = "qemu-arm"
+COMPATIBLE_MACHINE = "^(qemu-arm)$"
 
 U_BOOT_CONFIG = "qemu_arm_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
index 8db94910..ac0a28fe 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
@@ -12,7 +12,7 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
-COMPATIBLE_MACHINE = "qemu-riscv64"
+COMPATIBLE_MACHINE = "^(qemu-riscv64)$"
 
 # we run as OpenSBI payload, hence use smode
 U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
index b26c089d..622f429a 100644
--- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -35,7 +35,7 @@ SRC_URI[am62p-sysfw-enc-hs.sha256sum] = "4d0ed21a36dd57ada78307506403204e179d81d
 S = "${WORKDIR}/u-boot-${PV}"
 TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
 
-COMPATIBLE_MACHINE = "ti-am62px-sk"
+COMPATIBLE_MACHINE = "^(ti-am62px-sk)$"
 
 U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
 U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
-- 
2.51.0

