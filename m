Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C8CE8D6A
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 17:51:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4285.1763142661617097277
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 09:51:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dcwfWe+o;
 spf=pass (domain: siemens.com, ip: 52.101.69.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSKd5F7fOHCSDFV+mfkxA9DrVf6rbxSkmZKbxTKQdCCQfLb9p6rUxVVjwGWqP0O4vnA6Ynm8V1yzUhy2JWAICQErfOtH2SxpQj5XtreDyfmbLOZN+pzULtGsgmzw71ms30h2g08YQUpI++mNMOFr30IJ7GJM55XSziAdiRGvUewNFqu8S4+ox2aagQU68/MR5YYwFhGWWiVuR1xcAN54cFcHU0W61WfevqSqPWM5ONUVbA3vr32V3ZKntMqMeBTS/Ztq+FKD4Kx06OnHwyFEiZD2hpqKMg0OXGXRWc9dBoGXq4cUYisk2TSCURlYIsolm6qWbIq5nsYGC8zocZBgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NcZB8FxrTp1/dBotbqI/KBIbmnaV2gSHoSkNO9eLhg=;
 b=dzCGCV5djz5FENKwhyN9yfnZD54oV+o5kuQrmD8iRjOPFjMOO3wQLVkS2UHQHT/9YHZvTldBCffLxsZ8McNr/bO8YJ9mJwVHkox8a5+ZwpHk/q0L9eLzrT65vCCVvsv/sbsi7EdE8XGsdwoqu4QQzk9ZN3hjb1fcXyzudtyK2A8fNuWl1lxUxVbL7csHONnceaxjjZaMiOhYqEEGdwHql0MvB/UunSDfGz0izJZ4VGHzMATPbW/GadOfil3ezmGCwyPBMIGvZHnhsVMg/mBrNL/oThWIJdAH9k/hNmkHKmqpUgZzMLucsTDjObeQCtQ3NkftoJ1R6uDKU0oBkyWvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NcZB8FxrTp1/dBotbqI/KBIbmnaV2gSHoSkNO9eLhg=;
 b=dcwfWe+ox1DF50uzAULbi31YIcimnNkod2Y1zKkTZpl4kDfcxzAZFxFhhfrEimBX8aFRo7+uWISxMzCxxUdz1THADor0fR65dr39jnB/AFHCA267P9Snh3jcpbRbHYk8/oZX2+/69TZMUDlSFS+x951alQn77cvnU2DDER5sKCL69ROc0yKJ4HgASaWpR3Pu3/8PAtB9xIfrGDc2duLvDsEJbcdbXB4+rg0xkOE72k7UOKU7BlJuERnL8RuhqK9cYERkJLEaQi+8SfScp+gu35diSWWySHc+Xczf5BhQvjcUUIMMinmkWZsMHh0c7qlQbe7o9DTntZKHb0XE6ZVazQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:50:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:50:58 +0000
Message-ID: <1093cbd7-2f04-4a8d-9a2b-683dce40633d@siemens.com>
Date: Fri, 14 Nov 2025 18:50:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Disable kernel 4.4 with trixie
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8512c806-abaf-4067-b953-08de23a65e00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RUovVm5yOGZzVFFybHF5d0pSSUlJTUFNZFpPR1FQUDlHWHlsdzBSMXRyM2RQ?=
 =?utf-8?B?R2RZVFRVWW1YUVlQcDZweXppaTNzMnFqOFhWR090SVcrUEYxK2V5RERsbVJT?=
 =?utf-8?B?K1BreHlTakNtLy9LN1JUdm9JT3ZERHVmSXhyRGd5V3UvSFNZZkJJQWJ6d21s?=
 =?utf-8?B?bFpmQ3Z5dEdZaUNSZzRPQWR6UDJiejQxY1FJU0E1R3M2TVdEZC9nNURSeWtu?=
 =?utf-8?B?UXJmVlVYMU1VaFZzaWF6YlBndC93ZmJ1K24zWWJnTVZWMnc3WWtqTmIvcXkv?=
 =?utf-8?B?MXRFenFrTVc3STltUHZaejY0TEE5bzJWZ0JBTS9uSjFrOHpXQ056cnJaRzZ2?=
 =?utf-8?B?ZWVJejNTMFljU1NTRDJOWFhXb2xyanRWUHZRcERDOEdwRUFRaHF6VTBPa0ZE?=
 =?utf-8?B?OVlEdVhDVmFuNlNlYnEwMzZGdUJSSk85V2dKUE5xaEk1djg0eElTNzNEbCtT?=
 =?utf-8?B?UzhQWlpqVGl1SFZ6MXdKZFhXMVljWWxNRXRHTncyODFTZFZqNGFlWnIzMmRT?=
 =?utf-8?B?NlJ1cC8zOUZWaUQ3c016RTRkVTlUQUcrb2R0dUgwcElXSi9OZnlQd2NGTFJ2?=
 =?utf-8?B?M2dLaHlBY3lkaXZPTk9pUW56VkJFNFVHVjh0UE5IcVpkVVFxbDdodkJ4WWhX?=
 =?utf-8?B?SXJSME9yZ2EzL1U1YTRFTGQ4V0NlS0RKMStzMm0yRnpYdzFNSjRyb2pRV3Zv?=
 =?utf-8?B?OGJNRmltZ1dqL3RtckkzV1FuUmhoazZQWVJMSXBGc0NxbjA0Mk9RZDNpemFm?=
 =?utf-8?B?b1ZZZTFrU3NsSHQzM0JhVEpFYjFsYWU5MnV5OWYySERhWlZGYXdyeWUzTDY1?=
 =?utf-8?B?NjBKaUo4UFRzV0xQUFFuNGhGRDlacURkaFU3cGpTR3l4OUp4L1YvMlBZRUJv?=
 =?utf-8?B?RVY5U2FJc21RZWhZeU1oeWo2TXRrb2NCaFZKYkhQVjZ3WEFBeFByNWk2NVRR?=
 =?utf-8?B?QVRLOWRpRUpCalBZeDBZMngxYXdVOUNMN1dCLzhnS2ZsSmR2REFteWNncm5I?=
 =?utf-8?B?UFNVeFdyeVZ6WXcycWtLOTdWTDNYNXBQdDlGSk1DM2krNnhFRzNPQlpRQ25q?=
 =?utf-8?B?eU45ODJNMjJhRGw0emJhYWtOTCtxU2FGL1hRTG9SanBpUTdkZEl1dUdMV3F2?=
 =?utf-8?B?WGNJSUxvdENjdXRjdkVzMzBlKzV4QXlNbE1WSHhoUm9zWk9GNXJnbjNGbzZU?=
 =?utf-8?B?WW1Jd1Z5STNDNXBaZHJMa0V2bmxPYlhza213eGkrT0RXcHFxd2JvVlFrNDNT?=
 =?utf-8?B?d0pIbTJGenI0SkZ3N3MwVFpZdUlFVis3OVNESS9LRFRuaTFhQ2Q0Vm9iZS8x?=
 =?utf-8?B?MWRydWFZRUh6OHdGQVVqV2wyemoveDVYbkwrQzQ1d1BRUTlUZHZHeCtCQWpK?=
 =?utf-8?B?MWVQVEpEY2h3Q09tN1FkQTJaemRPdnozVUhYb1crQ0JBUlBvOUFHWStKcFZW?=
 =?utf-8?B?Z1h2Q3hSc2poR3NyZm1CN1hSTWFXMmw0NDM3RHdOUTJIRXA4cUY3VHZ4TnQ0?=
 =?utf-8?B?c0QxVjFST0dmRGFXQlR3Nm51QzV1dTQ0YkVqcWFPeW5XQ3FSM3dWaGVHbmFx?=
 =?utf-8?B?U04wVWllYUhpUVprZ1pyaVllUW5Jc2dOYVdzaDJYU3ZvZFUza1hkV0lmc1lS?=
 =?utf-8?B?djhOeUloaWVtZzJURzYrZWNiUHN4U3ZZaThLd0tpU3ZIQ1dGbmFaUzRTOHB5?=
 =?utf-8?B?Zkw4OXk2dmhTYzl4aUx5Wm1xalNUeVVPZ2o1ZWxsSXl2MGlRczE1Um9Va0hk?=
 =?utf-8?B?WU43UGdqZUdCUWNmMW5hSzFZYWhVZG9KQVlRam54SVZaVW5qVUdaWEVrWldB?=
 =?utf-8?B?MUNFYm43OGg2UXF2MDBPUldwM0hVRVpUU2gyRTRBVW80ank4ZmR5NzIvRjhH?=
 =?utf-8?B?eGJWUEJBRWI4c1BZOGpnemRvQ1NDcjU3UzNJL2JaMFBKeVZoTWIyR2x4K25t?=
 =?utf-8?Q?Aze2GpHuF4yinttRODGWagglO5exdUc3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDlFL2J5QzhwWDArYlREbWxaTFFGN1VvQU9INGJhWVJZNUlKR3dsQ2N1UmdC?=
 =?utf-8?B?RHlKeFJQZk5PSW1Ia05RejJBZFN3cGtpMWRvSVd0OVhYeThXb3lmZjhONXlK?=
 =?utf-8?B?M3BZUFZIbmIwWUhUenhVckxBTjVaNTh5RHQ5UFd3TUZCZHFrTHZ4KzkwbXpk?=
 =?utf-8?B?T2txWlpXblJ0bW1wVzZqOEZuSm5yanAyai9MUWdiVUpLUkhQV3R0K2ZCMGlj?=
 =?utf-8?B?R0RMMzBEaklieHdJSVFrZ3ozbmlXL1lkODVSV0N5K0NndzI0dDZJTE5LeFFn?=
 =?utf-8?B?SVZPSFdBY0RLcnlCRVdMSEMvSExBNkVtZG1UM1NEbW9QSFNiQklpZk5kS1Js?=
 =?utf-8?B?K1pRU1VreVowWTlLTjhTVjN1R3gySUlQaVUyV2lYbjFJOVMxT3dBQUNsOXJm?=
 =?utf-8?B?V1lKVjVXM1IxVEw3NU1icS81NS9wQUgvTXM5M1NUQWk1UFdDK0pFTXFJS0VI?=
 =?utf-8?B?bU1OZ1dibG5IaU5XS2dpeDNkeXZMWnA2dTlLNGdwZm54SkNDOEVhUHVlTU52?=
 =?utf-8?B?T3ZDajBEdzc5TUdCNzFIc21WUjZ1RFQ5NWthT0FEOTdRalY2VjRiaWhBRVov?=
 =?utf-8?B?ejVoQ1MwVUFhRHFZaGZzZTByV1M2am9qMUdHZzVtbkhQZ1VNaXduVVl1YkZS?=
 =?utf-8?B?VkVDMHgyb1BPTXZCa0VLa0N4ZHB5QlB2ajNWYTFZNExTZmxhamZpK29wYW5i?=
 =?utf-8?B?YS9DZ3J5aFYrY2l1LzVBREwrZzNUWmdaK2FGbkxrQ0NlcVRKQlRlN0U1bktH?=
 =?utf-8?B?WTgxNHYrVjE4cXJrckJiZmN5dmJDRzJWbTZ4MjVTWkpEUEJDQm8zWGlCTXIr?=
 =?utf-8?B?YnBaL3lOSkF5b3pwM1J4dTRuMExGcVQvaitpZThkQzdFTHFFekgvajNSeDFF?=
 =?utf-8?B?aEh3UlJLM1pHcytHc1Q5MkZNb3JCNHNnOUk4RmtXMS9RdzlscldtSytuN0Fk?=
 =?utf-8?B?YTh0eS81dWlibTJiaWN1QXBxdit6dWJsM0tGUEttQ2xqbHFyUlpJMlB4ZXhR?=
 =?utf-8?B?dWFvR1JUUElTTjFia29qTnVySGpFMmpSczgzU1ZEWkdzUVo4OTg2THJqb2ty?=
 =?utf-8?B?UVdRQlFSNW5DVHppa0pxckhxaExVRzFQemZ0NDJ1algyaVBINnlHK2t0VDZP?=
 =?utf-8?B?c0N6eWtUTnN6QTVsMGdxWEZlcTN2SnVRbUY2RjN2UlRhTWtySnBjVmJqY3JX?=
 =?utf-8?B?K0VTbHBqdCtWZVNQVkxNU2M5VUhXSWEydm9CRjU5VEpTSk5LQjdYeUxSMHFG?=
 =?utf-8?B?bkVvWFE2MGJIZTlrZHBOcWc1bXgrT3h5WVEvY2MrYzRVVVBmTGdUQjB5emtv?=
 =?utf-8?B?NU1zTE10SVJjYWRXK3pvUVdnUVlKdHQ0Mnk0bTBNQXVoRXlac0JrWXVvdjFT?=
 =?utf-8?B?bER2Zmpkb1RFV0o5djlzYmg0VHZxdXFzbjRzUVZXR0Z1ZUxTV0gzTDdkOExS?=
 =?utf-8?B?Mmc5NlpETkVrVElkck50UFA5NFJiME4xMm5Mdkp0UktZRXBxT0FLZ1J5U1ZQ?=
 =?utf-8?B?eEJIMlNlTTR4Mk9UNmhGakQxSEZyVWgvRHVCNGxPQWFFWHViL2NKbXFWMnpF?=
 =?utf-8?B?aU1GRGVxNVZidkZxcXBQWUl2Q2N1cnRlSkVXbElTVjM3ODh4b2tDUmU3TEk4?=
 =?utf-8?B?RWNvSmpTdTVTelBiZDRzakxwVGxpYTVXN01OUWVhekNHZDM0UG1DTTRtck5T?=
 =?utf-8?B?Rm43eFRQYk1FeFJwbEJ0WTNtNzNlOXRiQVpROVgzZTdsYzRaUmxPb1NXTTYw?=
 =?utf-8?B?bVlDdTVtOXN0bjJvWFMvT0liS3JUVkh2NlBwV3RZUFpXVlNrUDFMOXEvcmtY?=
 =?utf-8?B?ZDlkWjZlSWxsWmkvaW1HNSsrMVloY3V6Y1loTUYwYmR6TnIvdE1YVHJZa3pa?=
 =?utf-8?B?UUdHTm1WMTBtbDBPYWVyTDdLRHRVQmh3Vlo0TVFOa1FRa0Q5bU1qZHgybEVj?=
 =?utf-8?B?cTNRR1FCS1JJa0tqTXE4NkY0SFBtRStqWlJKUEF6QXhoTnRFL2JDR1h6bkh6?=
 =?utf-8?B?aVEwWDFESXBDS05wdjZ0YVFmekpTaGl4TnJXNHpVN2FtZHVTcjQ2YzJNMkh3?=
 =?utf-8?B?a1A3c2x4V21rSjlOSDhPZklPUFlqSm5pejQ4NjdWakU3NitXUjRFY0R2cThq?=
 =?utf-8?B?eDU1MUJIK0RzckloZm5oU3NxV2x3a3plR2cwRkY1L3pEVXhMVncxSHV0Nmp0?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8512c806-abaf-4067-b953-08de23a65e00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:50:58.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RetpjMfUEw+kYLjcGqXB3hn5/1gTaWeg4L14oOUmXxcflboqz5pOnvJy8e48pLFChalEyWtPb+reuU92CE/qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 17:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20566

From: Jan Kiszka <jan.kiszka@siemens.com>

Debian trixie requires at least 4.19 to boot.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 536162d6..9f5f312f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -133,6 +133,7 @@ config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
 	depends on !ARCH_ARM64 && !ARCH_RISCV64
 	depends on !TARGET_TI_AM62PX_SK
+	depends on !DEBIAN_TRIXIE
 
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
-- 
2.51.0

