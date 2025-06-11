Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DABCC71131
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.17])
 by mx.groups.io with SMTP id smtpd.web10.310.1749654032851702050
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 08:00:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P0s5smkH;
 spf=pass (domain: siemens.com, ip: 52.101.84.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHHFiw72Slq0sazHG/IDuv5CZLrcRgL0gZv98M4iSrWEBNzrBcR2BhiiXW8KKRC1vuurUS5muScWGgFvdDyobc8CwA/9eY/2IBIQPriu29rqz5O+p3ckCIRAxFQSoZ2uXogISwic5f9VWEc8/VqEnN6gu8+xxhodNojLWrv8FXxnGF7R6V/optqRUdDC6IKlrkkLNv8/mBdJWZJjSOc6VoHJKpIZQ8cUGfx9XQ7esOcKeIeoNFiEpMIeyIrxATujejYPJI4/U3j9K3GCOr8iQbACtMKjK4ou10zZBNNCDkm7oCtxmlww1UFnoueGPXd3VP1SCbt6aavRhqUHzfUllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO0z8YH+DuqGWXwZ25fo5gHS42ym25sxO+wHwtX9BiQ=;
 b=K193Fu6qXAwXW6m7cK2a9p5VAX79eUgbap1937yWB9kSrGLc3yCxyye9ih1sqqn5vf4LeAJq3NcEEYtGbC3BnFqcHq2WfZFIdN6/CGTzqwY2qePPXZso+KX9CENrfEIBCP69oJcxClQ2ChdwdbqnzgzOVudEqh475LdSLbjnkuOqf31rWvs9/f9qiQSU2zqxD9dHBMW6jZqNYQHCRkkvG782o26tXv7JEQcLgtQo/tHYTVlqVgs/mA+xS7sVBuDy6jTXi1RdCFtdvXr9nT2bGuSZbxTkS9H1PjgrtRunhci0aj9N498r5reXO6XQ3WhYzQVnaIqBJN5ZzxeI5ag78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO0z8YH+DuqGWXwZ25fo5gHS42ym25sxO+wHwtX9BiQ=;
 b=P0s5smkHYmncQ0gbAN/CVc04RJzONDiqH9usiIQZBKT7Yy8bRgZKQAgeD2OtjD6qXbHCdjuhssYVx+7zDQ6ufH0lEkn3EscWfbegqzo39r0EdOOF56CaQGPYqq/WBejvo1INsNUpVwbpGtao5yNZzu6r3oBmcghAYRsaiStbfrOw9G9PCBk+yYsWZs2H5qbbCfyRIcLstxsTTdHy+dQ+KDYqJbhH2s6bLB/Q13LCKhyjuaAwZapBDRHe18zC4hnc4s/13xFeNF3xwRuKblLDdswMhKGHN110Z4/I5hs1nEY3TBSI5Y/S7mGnvDe+/fUqzIhK90q1EuDeD8jwQdWKOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 15:00:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:00:28 +0000
Message-ID: <f9dfb02b-679c-4bd9-9b06-7eb3d65b97f6@siemens.com>
Date: Wed, 11 Jun 2025 17:00:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Improve modeling of SWUpdate
 availability
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3577:EE_
X-MS-Office365-Filtering-Correlation-Id: 17635b82-4eaf-4925-ce62-08dda8f8b445
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UllVWGkvWkR3NkU2ODk4NGdLaTZQTWRUblpVTzVqYlNkWmd5QVZCcWdXRGxz?=
 =?utf-8?B?SFZITkZlZGNGWE5YeENpazdHT2FMVWlkT1JOMjJaeDNtdTJSTFBPellQaWxo?=
 =?utf-8?B?dUw5OGFwNGNoUGsvekpwSFIyRGd6VUdycmFqY1JhWGx3VlBDd0tQRllqTUIz?=
 =?utf-8?B?ZWxSdFYxb3lEZHg2cnJZKysxa3FRMXQwTzBaTTRNTEQrdnVINnFqQURKTW1J?=
 =?utf-8?B?QU5UQVl2NFRpUk91dGVzajZ1N0lrZllTbGdKbnVFdlhrUmNBSzk5bnlZZmN0?=
 =?utf-8?B?dmRoSVBJLzJFVFJXZkpwU0I3UkI1dFk2TEZOYzI2aWVJUUZvZ3ZUL0l4Nlhl?=
 =?utf-8?B?b2Z0RFhNQ25UdlpkWGZudUZ2VDdHbjNCenZDYnF4V3hrbm1PeE9rdGlMWWFB?=
 =?utf-8?B?NFJqUkFablJHZXRvRUhxdHRwcjR6NERhcTB2SEhzc1NPRW9meUx3T3FRVGpw?=
 =?utf-8?B?U2RZajg2Q0R4ZzFWYW5zUmNmYWJZRVVNeGtUWTZ1N09tbjFFQWNQOWtpZnNU?=
 =?utf-8?B?T2RTR2tIbEM2elZMSUZlT053TVVXM0tybE1zZE1QVUZWakc1QTRPNTd0bmNR?=
 =?utf-8?B?b3VvQ0pBbkJBTUtEZ014em9UR21nTkEvWGhxSHRJOFljSWk2em5oVjYySUFN?=
 =?utf-8?B?OVdMdGFSVzBKdkxPa2tLMDd1RXhLbFNLVEFNR0U4SDBXdUpZWlA3emhWcmRy?=
 =?utf-8?B?MHZZMWNpaVU4dVpYMHhWY2QzWk9TWjZUZU13bnB0OFZDUzB5Tkt2dEVvUGxM?=
 =?utf-8?B?c1RBTXllOE9MWnllVXVvR096MXY5ZCtyYTgzY1lXc0tjcGx3RHpnT1N3OTMx?=
 =?utf-8?B?UkxWbzBUNDAvcTVSTmJ5RnluT1FQTE1wQ2Y1VXdyQzFGNlZHdXZTNmVNQzgw?=
 =?utf-8?B?ME9WN2VCb0hNOHNuZ2l1K2pJYUs0U3ZZeVlXeFNKUks5bmlsZEhMMGhldmNY?=
 =?utf-8?B?U3dqeHN0VzdqUEhSaWJpQUZ1K1R2dDdLOE0rcHBDSncwdnM5OXQ4V2MrakVh?=
 =?utf-8?B?akZFbU9OUEwyT1JVbGxmMVpjdGM1Mng3ZThZc1VOZ2JwdndEUGNwZGh6RVNw?=
 =?utf-8?B?Y09zWHJRdU9DYUFyZzBrQXpHZkxFblp2eXpQb0VYKytRMUJjbUN1eGNSMjVV?=
 =?utf-8?B?UHVrbFZ1L29tMGs2OE1tb2tJN3gyVTFieEwvdFNzU1hzZ3ZlWTNtYmhxZGQw?=
 =?utf-8?B?S0pWK0dXaEgvbXo3anlYU1N4ZTJSOGNsWmh1bGc4cDg2d20yUEZsVlBodVhy?=
 =?utf-8?B?VkJuRlhJMHJGNFllOG0rbzQ5aWJXdWhnSFplMFptZUVLMEJXNDZaekYrQ1ZK?=
 =?utf-8?B?NHRvK09zMWgzNkczOHhHZ04vRERqeTlPMVlNYnJQdVllUGhHMGM5aXlVc2tt?=
 =?utf-8?B?RGRBazAwckp3d1BGNkJKS01qdEY0MFNmQTZNTzhyZHg0RzRuTk4vb2dYQUdv?=
 =?utf-8?B?b0RiU05OZnUrbWpnbG1tcGtzVUNtT2hEOVNNbjRMMC9vWlFiRno1dlVqQ2FX?=
 =?utf-8?B?V0ZGdXMzRkkvUlVLSzVCdWJpN1BlZ205Wk1rYjZTMndTWG5GNUpJdjZLQzZZ?=
 =?utf-8?B?SG4rVXZNOEhDbzMyOEhaeWlqM2VBVHdIeFh5Y0s1bFNSaU82L3BMZlVrek1u?=
 =?utf-8?B?YkhXcGpubWFWZGgyTU55eTk5Rmt2MStSSFNPejNOeUFvOUdBblAxQzlrWHNT?=
 =?utf-8?B?MHdySEpsSFlTWDBpRGtjdzFZdDdRMDNhdks1TmZoV05uQ0FpSy8wUGJSS1NE?=
 =?utf-8?B?MVV5TVJvWnZndHRXSkxSUEpVemptRVFjYkl2cjg4aisvaEVRUkZweGRhWDlD?=
 =?utf-8?B?NWRxYmR0TjlsOWZjbmhrczlDWDFzNWtpOHFMOWx2TE1Qbi9yOE55dkZ3c1U0?=
 =?utf-8?B?S2t5WFlsdTRsUkpOTUt2UVVBQ2F0KzZXUG9VR2E5UUVUMExYVytHY3JZMDhJ?=
 =?utf-8?Q?k8AIVUTkxvY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1FxRkkrTTNiK3NoQlVyR3FuaDUrQXVpZmRjYlJ0SWVMTk1rYzdyZ29hTUg2?=
 =?utf-8?B?ZUc0M0NOOEtNbG5yeGhpVHhydWRNNjVNTkQ5dUU5S1NMRnNxQ2ZocU9FRXVL?=
 =?utf-8?B?cjBnaHV4SWlZUjAzK0F4dm5mQ0NvalFRQXVUb2JsMWhpbHExa2daaEtGMzVP?=
 =?utf-8?B?S3VhdXdGRklWNUpUQUIrY0MvbFpGeEQwZXFxeTB5TGd3WE1xZG1EZ3RZRlRp?=
 =?utf-8?B?Y0tVbjUyMmdWTmZtWThSd0t2SDZLcmpCZHdQK0J3bFA3UDB2SVJpcExBcjZH?=
 =?utf-8?B?V2xDcG1EMjcvUkhWdzJMdHRlZkczaEtjUkVHNGpTMnNZeU4xMjZJQnJqMUh6?=
 =?utf-8?B?RkVRL3YvUkh2UUJNVzJZYUdJVW5DR1B5TmxnTE9ZVDhCdW1QR1Zna25rV1lz?=
 =?utf-8?B?RkkzaTM2cHR2QnZxeTZoOEJKekNzS3lDeUZib2Z3aTMwaTJlbW5KZjk3WG9v?=
 =?utf-8?B?bHZXWDhhRVFaL3NmUlNFN1dYTkxlQnZIczVsZVhuNHNmODRPa1VhVzNVN0J0?=
 =?utf-8?B?Z290eitWOEM5dVpsbFBQTHAvU0RUdmZCWE5uRFEwNldQbGV6YW15cWJ2TWdL?=
 =?utf-8?B?Y3cxZzJCL1dGRm9JU016UlJsYVJEODB1OFRNVk95Q0phejNJUVlQMFYrTVky?=
 =?utf-8?B?S1FmZlVwbTlVNlhJOU5uQ1BTSVhXYnZYbEw1Q0FxWXRpcmhxaGJraEJiV3lQ?=
 =?utf-8?B?Y2UyVG5BOER1Ui9TMTM1UkVFVWpmaGx4OWVjZkdTdmExSnc0emJBNkJFWThO?=
 =?utf-8?B?ejgxVnpzd0ZkN3ZPQ21yS3haV0V6TnVlM3d6WEVtZU0rcld4VUFoUFZZMExw?=
 =?utf-8?B?RytJTjg0OXYzWi85MWJ0L2g3akxYRnhRSUgvMlg4dTdhMWlJNmxEN2xURVJL?=
 =?utf-8?B?b1ZPNkNxb2hrSnUyNTFOMGpvNlZxSW1EUWxSblM0ZTdiV0ptWXNLNCs0dWJW?=
 =?utf-8?B?VUxDOFc3dXFGbnBGdXNFSkhPdHdBblFPelR3MjN3N2RGTzlWTkZQTnBDemtu?=
 =?utf-8?B?RVdYckd4a2ZmN1paSmkySzIwaFdrdDRKQ21JRE04Y3o1blFVQWVzV2MrOTFu?=
 =?utf-8?B?dlpaRmJJTjRHUUdPblVEMU1rNTYxcnZucFd1SDRyNXNaSmVxZUxoUlhpT0Q5?=
 =?utf-8?B?ZWtmZlp4NjgwUnJtZk1hb0UzUlo5bWJadi9VOXRGRjdyR1A1TVk1c0ROaVlI?=
 =?utf-8?B?UjhXWHUwRnNWeXZaS0w0Q2R1bVQ5elVhemZocDdRYUgybE5ISEVPeEEzQWVL?=
 =?utf-8?B?aWdaS0t4SklKVkVNZU1LZlMwcXJ2VE8xSWQwTWhPTUVNOUU2OXdPR2dYMDVl?=
 =?utf-8?B?UTRhOEY3bFIwcVg2STZmZEhHUEQwYStuRkUwWms4ZkZkWTZuVUduN2NlcitV?=
 =?utf-8?B?L3pDMVQ3M1lkTllFMy9aeUZMQStTQlZ5ZGhqcnptWi9CRm9rYnBzMTI4elhy?=
 =?utf-8?B?bm03SEdMYVlPNXJwSnEyRXRmUnRiVXg1b0ZMRmQrNFhyb1VZRHBhK0VUWis0?=
 =?utf-8?B?eHViemN0K3ZoWXUxY1FiWmtQUlU0Rll4MXZRcWVqOVZXeEtncVZxMk5vMTdQ?=
 =?utf-8?B?R28wWVVRaFhnV0p0bWxCRXo4ZXdienVCRmU2VVU4RDBuTkJlN0k0OFR6Nk1r?=
 =?utf-8?B?ZlVxWjZ6QU5TNEVXQ1dZOGkyeVd1VjlmU0M5TWNPbEpaaElFb1hBSk4zdXZn?=
 =?utf-8?B?V1VjV2crMnhmVUtqTzlBVVViQXdPMGhIcVBFd3NkZUwzeVNGSVU0a1g2SXpC?=
 =?utf-8?B?UWhUSlh0b2I0anZkd250bnlIQUtpcGJIcmJCUWp5aGk5dWU5ZjBMb3dBa25S?=
 =?utf-8?B?NjM5b01wRGU2clhVb1AvT3M2VWtYM2ZrZjlNakg2eW8yWE4wVEIzeklkZnE2?=
 =?utf-8?B?NU5zS0dBdzFBd2JCQVo0S0h4S2VyY1h3OW1CcUdSYUNWSDFONkdtQ0Zud1dL?=
 =?utf-8?B?SlZVcC9yL1NNTWZBUUtHNHExWDRZUzdUMVl1ZGlSbU0rQXdYM0hYUUFjVFVK?=
 =?utf-8?B?K01QNUJqNWxoOXM1eHY2cGsyS3FCYnhIdWI2TGNLSU1Gb2wrOFcrZVk0MHJE?=
 =?utf-8?B?b0ZZcGlWNjFkWE93U0F4eDNWUnZBRU1rdjg4dnF0bncvNkhoUTF6SnhuaTVv?=
 =?utf-8?B?dm8ySnpNejl0Uk45dXRDbWRTWG0rdXF6TWJxYWpqNzlSeFlzd253TStmcVJv?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17635b82-4eaf-4925-ce62-08dda8f8b445
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:00:28.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjjUdWU8AH/8wK2J1ckj0h6CWI39ZuUEQXotIGU0O0I76tIbSHj5DcUjupMREPjuL8wRY/oSaZJsZEzD6eAiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 15:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19030

From: Jan Kiszka <jan.kiszka@siemens.com>

Model it via a bool that the targets can select. Along that, extend the
support on riscv64 to the new 6.12 kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 18560292..a9f28fd2 100644
--- a/Kconfig
+++ b/Kconfig
@@ -31,6 +31,9 @@ config ARCH_ARM
 config ARCH_RISCV64
 	bool
 
+config HAS_SWUPDATE
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -38,26 +41,32 @@ choice
 config TARGET_QEMU_AMD64
 	bool "QEMU AMD64 (x86-64)"
 	select ARCH_AMD64
+	select HAS_SWUPDATE
 
 config TARGET_X86_UEFI
 	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
+	select HAS_SWUPDATE
 
 config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
 	select ARCH_ARM64
+	select HAS_SWUPDATE
 
 config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
 	select ARCH_ARM64
+	select HAS_SWUPDATE
 
 config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
 	select ARCH_ARM
+	select HAS_SWUPDATE
 
 config TARGET_BBB
 	bool "BeagleBone Black"
 	select ARCH_ARM
+	select HAS_SWUPDATE
 
 config TARGET_IWG20D
 	bool "iWave Systems RainboW-G20D-Qseven"
@@ -66,6 +75,7 @@ config TARGET_IWG20D
 config TARGET_QEMU_RISCV64
 	bool "QEMU RISC-V 64-bit (riscv64)"
 	select ARCH_RISCV64
+	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
 
 endchoice
 
@@ -197,7 +207,7 @@ config KAS_INCLUDE_SECURITY
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_X86_UEFI || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
+	depends on HAS_SWUPDATE
 
 if IMAGE_SWUPDATE
 
-- 
2.43.0

