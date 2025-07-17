Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F415FC83F22
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 09:28:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.38])
 by mx.groups.io with SMTP id smtpd.web11.44763.1752744508728402018
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jul 2025 02:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HESEcLRO;
 spf=pass (domain: siemens.com, ip: 40.107.162.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGQp0TAFO4X+uf7z3J6hZLZjMCFhHD39UQPoEbdOLf7jgcyZdCoBxmwn8OeHP8JeQ4BZuxtvCML5x/K6DEa6vyXoWv7ccvGHfEyJh9VJDjy0VAouhxNLemAlMVIjRNyTh0Etr9ZEGg6ZSJN90FglTeM4Ctrmi36Ov11Trq37iZbHvZSKJ0P1Zpu35SJpINzTi1KGTN3lZU9vRg+Y3w9PiXY08Y4vQ/e09+927MSvwNw6NFiSD+48RSIEAYbnLttUDyzVqhhLaW0eZjTYQPo/5cV7QRnnt1BmWeSKh1cBsW4Xs4RNISsq2Z/usjinde7NSrTLaEaRl/AzZjYYhpkMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDYKvtw/5PbvbkYm3VD9cO5edL9tjLitMhvFW5xRiCY=;
 b=H5mi028kuG+AeJ+uHKdsDBdeB2Jek+/wfRs/pcCPGDc/soBRyyQcd2nCs5+mVKUisZvebdmB1Ygu+bkrXasse8XnRGZ3kthgbRvvR9joEbxiWvTXmN1piLrANEAO3hOxrXbp8XpOFvN0/hZ3aZWAAy6VGsBKEUn9DXBkTdaDqDH+ah3W4X1sVQBi8ZmDqgSjN0oNDnBFYYTGQfwZpWgk0VFPauN+7cRdwfB2K63RAi1IcUNbp3J5nopj0XjIXOCODXoagYAazBqWWmFcehaDOdakcvf9cxvMXY1gFr6YaWl6NFKvm4PPQbI4LcU20O5KRa3RGNetfv/CzXyYo8fm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDYKvtw/5PbvbkYm3VD9cO5edL9tjLitMhvFW5xRiCY=;
 b=HESEcLROya8IFe76bNTlEihEDZqXqbjUB9DnzAH9qiLK13jVEHAV0/ewLrF2y4BRfdYuPJG/w24Khfg9v68K6/Nn5U48cqa8yy5dIJGmW1TOFMWnz+BvMf+i44WOz5AFkqQ/WFQ2UID/qo5JE6E2AmOFSeJuAttAyZNm51BDqkV5+/42LS3mC0rGu7HRmFzEMNIAXbjqNBbKgJ1yzpH1MvqI4XThwQlTyAK8d1rk/Q5xsowA3fXNCoFTY1w8W2L66GbwfIrNGU0Oz4EDdcvTo0KjOaE83FVd5lVwgno2DcXJ9Fx+MgTWMHC0pAfOQmBrkSvYeiqSbbdcf2z1pc4DYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:28:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:28:25 +0000
Message-ID: <491f05d8-9ff1-445e-978e-fe713effebdc@siemens.com>
Date: Thu, 17 Jul 2025 11:28:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 948acc3e-6cbd-4c84-92ed-08ddc51447f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWZBM09uQ3V2VzUreXNJZTJDdU82ZnZpeTd5ZXFVdXEyZTdrQTV0RUMzbFpV?=
 =?utf-8?B?RG1TZWFma0laN2hua2huWjVhTTlYODBWUjBCMVQ2aUxYcmJKUHhlcC9iY3Vx?=
 =?utf-8?B?azVRUnI3YURwYW11SHI0QmxNL2U5MlQ4QVpDR0tTNUpzeGdZb2dmZ1l1L2gy?=
 =?utf-8?B?UERnTTlHWk5SYTBYaEF2OW5BY3JPTFZMSFVPNXEzZVRTME9STHNncVd3dVEz?=
 =?utf-8?B?ckMrQXNaTmpTbTdLcVlJTTBzYlFzdkhHL25kYUFmbVpFeURqUkgyQmg4WGdy?=
 =?utf-8?B?N1VpU0FocUU3L3grUlBCYmM3eDV0SFQwdVBNMTZGUEhHQTJIK1UreHdEQmhR?=
 =?utf-8?B?U1dPSEg3djFLQzBRRVd4dWM4OTdsdThmRmM0Zk93YVFSbnQzcFZDN0hpd3VF?=
 =?utf-8?B?cERJNnNrMk5ZNzNWbUdzRHh1dUNyREd3cDZaRGY4N09jZHJ2RDZFcHBmOHhn?=
 =?utf-8?B?WDljalp1dlhZa1dBZThVQmFDQ3krUXVyKzBzdzJRMXJHdWdUNk5ML2VIY2t2?=
 =?utf-8?B?bGZxR2NxTzFpa05aMlMwNFp5cGZzaEVhZmdrNDg0OUdTQjRyL3dSZ0Q0VHZl?=
 =?utf-8?B?bG14dGprOEV2TmpMUlkxNkt0RjNCUTdSbW9CRW5wODA5MWE5a0Y0amYzWDYv?=
 =?utf-8?B?NGtjcXV0ZDU4enREUmVZMmFoVGFwWEpTZVR5OVFqb2x1c3ZkWGtBN3RqdWlH?=
 =?utf-8?B?eGh6NnZLa0JvVEpNQlErYnFhTmhVcmtaTzhXUkhOeUNKVDVhNzhtWFdhckhN?=
 =?utf-8?B?SGgvd250VGkrM05pMnpUbGtiOUxOTUpqTDVsKzZCMkYrRWJEVmZxQitxU2M3?=
 =?utf-8?B?R3pKeFdlQm9sOU1iOTZVa1ViRGFkbUo4ZzQrd1hUcGl5cVNrekgwa2xWbTkz?=
 =?utf-8?B?R2hGUXd5b2lpUU1iNUt6ekdwY3NoMXU0UmRYVytYRlhReC9HV09aU0d6RVc3?=
 =?utf-8?B?Q0wyejl1WE13NDFUR3VWVy9QeFBvY1VFNnVOUU9pbGY2QndpYmFkdHhvYkxh?=
 =?utf-8?B?bnM3MkdKVHl6dDJBckFIMnhhdkJiRjJFNjJNaUZDV0tLaG1zY0ZCVFlRMmVO?=
 =?utf-8?B?dHpqWmhFazVkWElPSXIzS2JNWVVNNUs1Tk00VzRlSlptajAxaDRTTEZleitK?=
 =?utf-8?B?TURtMm03cFZCdDFieE5YVFZHSzNEZklsemVJQVoyOUhTdlp4blpSTW15VGdP?=
 =?utf-8?B?SVF4M0d1dnlnR1VjMUlrU3JQQUtaMG1ZR0VVR2ZXUmlVN0pkSk1wVW9xb1g0?=
 =?utf-8?B?b1pGeFVaQ0UvdUhyYnRMaW9VQnFKNy8zbUp4V0tTK0NBcUtjOVF5V2tVV1pZ?=
 =?utf-8?B?QnZ3bU1pbTVVYWdieVkvcFdTSzFWZURVSXFjOE9VMDZjd2g0aWpBK3pHL1Ru?=
 =?utf-8?B?UWRDSGg5dzBMeVFOc3dPS2R1U3Z0MnJtMzBKdFl2VUxnT2JMR2UwZlc1STlX?=
 =?utf-8?B?WHpsakRza2dLMlEvSmtKZGVXbFgwekVXMzhCVi9RdG10TXFOZzdENkdYdWJy?=
 =?utf-8?B?aDNTakQ3bVdjV3VNOExsNHhTQkh3WjlVdEhoaXU0ZzRUUkRaVGMxK20zcGV6?=
 =?utf-8?B?R0ZTakdJeXR5MmNJSDNFSDY3UW55WHNRSG80UWJUNGJXZzc0VXA3dDRHdUNS?=
 =?utf-8?B?R283Z0VENXBjQlFQRU9YaEhxM2g5dkdHZXpsUDJSbDdvV2V5UUR1NXpzeFky?=
 =?utf-8?B?Q1dIQUIyMFJwMEVnOHJ0dnluSllZeUU2TWVVV2JLRlNYbDJVdjEyanJ6enF1?=
 =?utf-8?B?amozZFpveC9CK0NoMmJxajRkUlR4U2RMTmhVZEtrVTdRV2lJYjA1ZUdmbDRD?=
 =?utf-8?B?R05FejBjKzgxeVhIUGpVZ0dIdk1NcEdNWWFNTXF6aTBDYW5ZUjlWTCtTOEQv?=
 =?utf-8?B?SXM1dWl5cFRMNzZlbjZ3ODFtUzAwZGN3b3J5R1doVXBtTmNNeFNtdFJBcG1G?=
 =?utf-8?Q?dSnG6/vLyZQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjlaaXpjQ0pWQitoaEw0WlJIT2tnYTFmQnFOVXZpdFFiOVR1dUw0dkRHMk4x?=
 =?utf-8?B?QmNOQm1rdzdiL2FEN2tKV0REdWtxR1N6VjJqMEJjMUhNM0cwSEFxWVQ0cGtO?=
 =?utf-8?B?SWxmYUVURUozWkFxUk51cXBxK1NjYmFJZEpkSWhJZjNqcjQrd1VucFQ0V0RO?=
 =?utf-8?B?NkJxeVNVVkpxLzBsTVgzUGpSOVEzWHUvRngyYTFnQnBjVGs4M0NjcDFURHAx?=
 =?utf-8?B?aGcxLzNUYlVnbXdFMWg4RWIxNGtaMTFnMTQxM2o0QTc2YnFwano3cVdaTTJh?=
 =?utf-8?B?U2krZWVQMHVheko1RkNYQXBNRUhjN1FqQkhhYkJyREYzV1ZXUnN1SUxWZTVk?=
 =?utf-8?B?V3NrR1FZSWRudHZJazNYM1craFI1UGVQOFh5QWxIaldvemhlU09aRzcxRWQ0?=
 =?utf-8?B?K0M0UlBEeXErMnQ1YmFyTUVzSTlqeDF2alN3b3BwV2xESW4rYWs1UVNpMzNN?=
 =?utf-8?B?bG8rMWFNRHZTQXYzaFBlcGJQSzFXQjZLbTFQQVhWYnpNcnQ2VWJ0dFY1dXV0?=
 =?utf-8?B?L013RFpwbEdGOWk5UGNoU2dvUk5URTluNXIzNmhGOUV6SUxOVExXWE9YSG1H?=
 =?utf-8?B?ZkhrMFIzWGdRdVZhS1FQelgrVXNhdVlKb0hxNXExTE42QXgvZ2ZFeEJZM0tK?=
 =?utf-8?B?TzRaNUJoV3dIZGJNV3IvOThsNHpUTFlFbG1MOXRiMThBM0F2NTZzODZCT2FE?=
 =?utf-8?B?QXVoYmRxMWtLMEo4aTQwTTN5aWFqZ3QrVjJKZ1BxSkxlVm9OVm1uc215eUx2?=
 =?utf-8?B?M2owbWszVzVLaVRnNWd5dG1vZmRnb0tGYnlOR1lKZ29HOVZ1Vk14NE92R3ov?=
 =?utf-8?B?emoyTmNuTTd1bFhNYmNYUXFUQ3dVekUybXltRk00NjRrTitCM3g2YmpXc2hH?=
 =?utf-8?B?UnJUc1dtcnV2Smx4b3ZXWHBTMXFyTDJ0Y3VaOVRXNlNYU0dnZ1pLZDZRT0dW?=
 =?utf-8?B?WFNXUnhHNlB5VEV2N2NUYllONklGVG9COVR1Tm80SGN3RkZLSFZoRDlxMkFw?=
 =?utf-8?B?Q1oxUDNOMkdaVkxnbUJGQzczZE0xZVlYMGdnYmZlTzVtekRYZU5kRHlaaWFy?=
 =?utf-8?B?OU1IeXF4SE5EOFFUY2l2VnB2WFgzSTFqK2t3em9QZnNZZGtaVXJ4VS9jTTZj?=
 =?utf-8?B?cGY1ZWZkMUNXV1hUZ0tXRElnOURpK3ZKRzBPcjJDdEc5K0E2bWVyQ0lyYm0x?=
 =?utf-8?B?ODhoc2o2L3gyVVRVQnJXcnlmSFhtdU5ybGhlMUg5dTJSUW9kQnEvM1lOaU9M?=
 =?utf-8?B?MG9aN0h5dFRCVTVNN3BjaVZOeVl0Z3ZXVjR4d3pacWRMdDdSMGFFUXJ1U2Fr?=
 =?utf-8?B?Qms4NWMzamQwUnBRUG5aM0FWSDNFQmNrSHZjQkt0cU1naGFlRHF6ZFU0aDg1?=
 =?utf-8?B?QzhqKzA2R3FmM00zeEZickx1ZDQ2N1FCZjZwSG8xRXJwelJtYXUzSkt1Y1FZ?=
 =?utf-8?B?N3NDd3dzZFVURzE4Y0hxOE14Q24vMnU2cnU5di9VRGZMNm8yV1lzbVBaRVdk?=
 =?utf-8?B?ZjJzWGhMOXYvVU11OVRxRURxOGR4R0RDeThlRCs1Y0JFM1Q1U2xVWkE4alRn?=
 =?utf-8?B?ekorbnVJSkdWVFFTeE5UNzBhR0F4anFuai9jZFQwZ2toMENuaCszOFM1dHZX?=
 =?utf-8?B?cDdXTTk2dDdqMWgwZ05VNjNnNmpsZjBxRVcvU2lNRU0vdU1sMXhralQzRG1a?=
 =?utf-8?B?bC9SbmtxWmkzenZlcjM3ZXZqSG9wanJiYjdaNjNWYStDOXJLVGhnUTBiWi9V?=
 =?utf-8?B?VUJVSEZtY1hZK0JDdkNSbkI4THI2UTdZYWFWUkl1N3Bmc21zSjJ3cDhRTTla?=
 =?utf-8?B?N0dkeTBVNHd1dm5FSEVaUDd1b3lMd0pQR2dVR2hzbVJQVERxR05qVElOL3Nh?=
 =?utf-8?B?MUVzZE1YQkNYYmFWeEU5R3JkamdOVHRsL2U5YnpLVWs2SEl0UGg4ZmM3TW9G?=
 =?utf-8?B?WXpRaWlxeFlyaVB4TFFsZ2lvSGhzSGtpVkxTOEZiRnJOT1VvUzJKT09JSGNi?=
 =?utf-8?B?ZlNZTmp0eTlrRGpNZXBBQUUrU2xSLzhQZW9TRXkrYm5LN3ZBenhiVms3dTBn?=
 =?utf-8?B?cktINzR0OW5pUDY3azRkcE1FdjNleXB4VlVuYVpLNk12RTAzVmVmVDQvSEgy?=
 =?utf-8?B?amdwdXJNaFg5ODN5YTlQZGdQUEtDbmE1MkJsVGdNQ1h2aUpabEkvUlgyeFBM?=
 =?utf-8?B?SHk5VjB2M1ZpTG50SkIydm1NaStkcjRubWxlb3p1amg2TkVrRnVwellvem5L?=
 =?utf-8?B?OHN0L2ZmY0c5VjV0TmlqNm1jRVlBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948acc3e-6cbd-4c84-92ed-08ddc51447f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:28:25.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFjakQDChnFcIU+EesyQU1Gj1kujWcNvMkpUGsfReMOb94NkF8FoT341aUeTBqhTmcblzYxsM+1RTeOYX4SROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Jul 2025 09:28:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19552

From: Jan Kiszka <jan.kiszka@siemens.com>

This enables squashfs and erofs for 6.12.y-cip and qemu-riscv64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 2e7c38e6..842eb9cf 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "c999bb8f530e3fc0894e2462cad10f610507c16e"
+SRCREV_cip-kernel-config ?= "2349955d6d536980b78099d4d2bed5e86fb32cee"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0

