Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C10C79F99
	for <webhook@archiver.kernel.org>; Sun,  6 Sep 2026 11:33:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12654.1788694377211527578
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Sep 2026 04:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ol7ctPYx;
 spf=pass (domain: siemens.com, ip: 52.101.83.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwVcjFlyD/THl0PqpCNXbdp8830qUB3TAz9z3JX+niVlVUG5baxIjwJlfRKqmY8e8nOiUoge0h227/aPO6vsv78acQlyyHyCanrkX0B3oDmDM0ljRk1U13Re6jdV68ZtmES0XurC2e69VJu+3tItZavKzB+/26geub99mYKx/7jh4ozgWlLmUfCj2EtebVzf+Ap+cThlbPJoBSYxKBm9Wdy2rcK/Q+0186CXzD6+YR7ekBGZeEclUeWJY6xTywEZGn1BKJsZV5AF81oH92UszAZbIEmYw6okbiaXsDN0lsySoy5Oqfd56cKdJaqQIPSc9aYjNjeobZ8P1uIxMgcWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXfkv8+eUdQU2pO0A01ICsTC6aZySlZzdXDHLU8pMAg=;
 b=Dx+sVp+T1PHP1lrHSH2ATIJFkTnBwH0TjY/j4jJP3FdzuanaqzcKcbeapxQobAkTjrWOc8ORJMbUseG3V6EUBfzbZb0l8pbyHiTG9A/JTgTBQkg3VNmSS4eaBhZ1NN4qpAkfXLIzti+QV9vNxzCFfLGyDLYKeJX+X+U7u22gg5pZYjp3Wl7rsI1V2PezmO38O7C+I0cwo4D0+RgIeycXF/UloTdUVEExlSaFD24KiRxuiuoThODGQFO3/QmsG2nVjHH4t22FQ0m3UD7msBK3T/obBmq2me//bsrhwDOFD15OrhGTL0L4ZwXU7k/gXEyOAtE69oUx8Ep+EhHRP/XDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXfkv8+eUdQU2pO0A01ICsTC6aZySlZzdXDHLU8pMAg=;
 b=ol7ctPYxx3GxZpC+EBiuwyAsu/s9rEySmUlvu2pvuSP2vsasi+WBvNY7+Wf4DyLznhgfIxsjjQaFAJIm6nS06Tam5aQfTj8rwZnwYXl/jO2WGA7DGDYWL2PfMQ/oSNofGl8sSbR+htH/oDOxQahAHB77kazsFJrqBrwcfnkPGxhzMdrWAjIB+PcYbQ28DNHmOvXUCif21nbP3NMMZeDtBWTXc25cLREmOW1mlxRHZ2t+zLQ56/4ueft23MQLsDX5GqKZeWnOQYwl9gQB/4wZTV+OWJsBukBxidsTUAqBrKx9Tj6FoLHzh23bHPiJnAVI6XR999X2kCQHFW0K1Q6rcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by BESPR10MB9268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 11:32:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 11:32:52 +0000
Message-ID: <0b3a3764-5a32-401c-904b-d100c2387c0c@siemens.com>
Date: Sun, 6 Sep 2026 13:32:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Let disk encryption depend on secure
 boot
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|BESPR10MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf4d048-1a60-4a6f-551e-08df0c0a9643
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	t4r2boCw8jY/yrOCd9BYn3n0U59M9R1ADL9Cqtmstp8pLQDvtLHHGEIvZOTzBF++52amkgh+ekJAAL8ptUWI2hytAezcgEf1jfgYgB5oHMNJIQGeLKsX2f63pKI/8KFf6d+t5sp/3TpnR7ziQULsTO86cQIY/KFE7oFiylX5dGrsJ9+Trjz4NbxTlDC77Kiwr6PDJc40xcL/UhqLe0F/9++hB0K2pd0DpNMWd7bIdXJRNbk6fKDfvG9zO0seqP6DWfhlIjLTkqivfQdMv47uGSh5nZmyAnQFHew4zHc+2/YNorZM0oylzHlH8G3hL9Ne8SSaMCz7Ftp4uHS6/vgRIHreqYE8Z4VLq15ylc4ogud9ysN0PWY2h0vIlOXlJNre+uHBeogsW0FAsbygC4wjthmEed4MaOG31NEgHw7jEsHECKbOKpowEEMYBzx85QWw9wM/xy8GIVaEWNxMybOCBRfqz/HyazqQTIsoTNk0J0jwk+Xmj62001T78anJqUBcGoikomsdJwuFmLx6n10DQSGKiNl6/wqlpIPomT97/lNUp2PYXBlnctLDsR+5Fxjs0uta/PJTIkZzyaMY33BXeX55usXV0oMyt3xgv8/lZ7vrnO/zxTx9GuXYNE+JvYALO0fGNddqFe5dcy62wlz0OV71oDbewm2LlbBiME37pxg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHNHdWNXOFJhanlXbGpQbWhKaW95bGZKNEhsWlYwUkVKVENxOGtiK0pIYU15?=
 =?utf-8?B?bXpXOEtiOXFCNVM5c29mWlZZWXBObU1uellUTStXY2s5T0QzYjhzMjlYSGRk?=
 =?utf-8?B?UkRkcExjL3RNUnZUOFFSbWVRQ2RXK1JqUW83M3RUdW94ODhQbS8rOTZuOTU1?=
 =?utf-8?B?bjFtWWp6QjhjajZBZTNLS1hqNnRzLzFYMmF6bjRsOXZMOGlQT21ScHFjUkt1?=
 =?utf-8?B?THVlM3VGa01TR3ZuL0c4cVZoWWYzZEZ0OVdSWmNpeEJNTjgvVjZLMXA0TW5S?=
 =?utf-8?B?enNCaVRNb2xhVEJ2c0dHV3VEald3Z29jNjhtUU9RYUNvdXJEczlxNHg4N1ht?=
 =?utf-8?B?Smc1RjBZRU5XQTFBOXFXMjJDU3RpMnRlTWVLbHZxcEhCTVp5Vkp5anJuSUlC?=
 =?utf-8?B?S0xYVVpTL2xvN2hJRkUwTzhDVFlDQXdhREUyZmFJZXA0dE5tYWY0TmZUZWVO?=
 =?utf-8?B?d216VUkxOEVaQU5FN3I0c0NMUWV3UmFCOGluZGtQZnhQcUhITk4xNmViejhy?=
 =?utf-8?B?TGxyZ3dOM0NzQWlvQ2M0OWtxVHJzcU1LVUhHdTFRSjRYRmJiVkZHeWQ5TFhv?=
 =?utf-8?B?bzFQd20vU2xjNm5ZUldqYmlNaXZPdXZSUFE4TzhLRTdPdWRHV05KaEhzOFNa?=
 =?utf-8?B?czlMNDdaQ1lqYWFZelBZaUxLUTZ5V1lmQ0M0S3FTWnc2QjU4YlpmaDZCME9I?=
 =?utf-8?B?MytRV3hnOTRRU0xCM2JwclNGTGZMeUkxeTRyQjJXRlRRUittSyt1YUVseVRu?=
 =?utf-8?B?MjFiM2hHTkxwcytHdjlWaWdqSkZwSVdnRWRKUHNka0tkUS9sKzhXZkxqSUEr?=
 =?utf-8?B?OUJTZW9hejFNL0xFVUd0T3VtcTVBaFR4VS9mSURiM1JqNnJrZmlyd3dudVd4?=
 =?utf-8?B?K0xMckg3Z3JFZzRMOVdLTlRLMTM5b1lIRGkycjJoNUtpODlOeW9rK3lxSnhG?=
 =?utf-8?B?a2xVdVg0WUxSKzJBbVVDSlVSYUN4ZkR5RHY1bE96TVNMSGJsN1c2NkNIMU1o?=
 =?utf-8?B?TTFRT0RIcXdXTmlrZGxEcnovSnZYanVya0lxUGZEOGVwWTZBd2p3ZHhNVXJC?=
 =?utf-8?B?OVFFL3lyWjA0d2gzOVorMHh2dHNnRHBETW5HbDdZWXExZ2U4NGx0TjZPWkRo?=
 =?utf-8?B?emdvWHBKdDNsWit4blliNWxBeGRVdXdaMVRyckU4UDRsT1hlVXVXeFpNYkpG?=
 =?utf-8?B?bkViTkx3SHFnR3kwUVFoTCtEenlmbGZWeWRBUk12cnNFUUlnWkdZa1BSemo0?=
 =?utf-8?B?Lzc0eDYvbDRhdmdQREhid2NJWHRvVFFndlMzVnpOVzN1SGhldTdLN2Y0Mm1l?=
 =?utf-8?B?MnBTMTdOYmtNQTBwaW0vcVREd3NIOWpJWmRzQ1FJUHF1RHAwUUx4emY3OHZR?=
 =?utf-8?B?a01pTlFpV0pQSTZyTWZCUno0TXN3M1RQQ21mcXpYL2JTT2tOZVhHOFN3Q3Fk?=
 =?utf-8?B?ZCtIMUhLV3dHTytiKy94dTVmR0tUNTVicE05WmlvOXNpZHpxcE5kVnFaUDV2?=
 =?utf-8?B?RXUvMlNROGUrd051c2pzZWZtMHZ5TEdNN083R0w5c2RiUkRkTkcrbk5Lb2I5?=
 =?utf-8?B?NDhYZ0RRRVppZGRvekpQRjVoS1l1YW5tbVVSRjhZV0tIbENwUklPU2U0VVoz?=
 =?utf-8?B?R09pekdUVzJJc2Fhb0VvemVpc2FKeitjcmtnOHBabmtJMERaZGo4dHFrdFFr?=
 =?utf-8?B?eXdQbGF0MWx1WklBZWhtemhSQmVWeHZvNEpydVVEL1ZzaXBaMGlhZjhlSHVy?=
 =?utf-8?B?eENPVnRFZEV3UTRRanpBYUFvS3MvUzF0SW1XTHBuYmNhZE0raW1NVm1NampK?=
 =?utf-8?B?cER6aUZGa1g0UEZneWRYUE9QQXJFTnRNMnlIZzNjS2Zoak5ncGlIbkFmZDJi?=
 =?utf-8?B?Vlo4Nk1hWGs0bk5RNFFEcVVqSDF5ekdmdUpaZlozTVBnenpoaFUvWU4xT2pn?=
 =?utf-8?B?SlAvbmNGYjlEREcwandpemJZaTZnT3hFeFIwMm8rd0Z3NVc5SEhlMVBWTHc4?=
 =?utf-8?B?TkxYMS81cVR3clVUczZBc3cyNW50di9Jdlh1Ylk2cTc5Rm1MTldaRzAzbmRH?=
 =?utf-8?B?bDQvZlMzVjdkM1hxb3hVT3h2TTZQbzlkT3I1OE1WQVdDanppSGZUbWxlVlJ4?=
 =?utf-8?B?cVNJYXF5RzZTZHdCWlR0T0NyQWwxLzk3U0x0SUFkTEZQZGVKc2xrVk9WY3RX?=
 =?utf-8?B?MkxxaFQ4Q1RHQTh1eU9JSC9QeGc5dzdENFhuL2svQW1nbHdJZDVsNjBwRGlT?=
 =?utf-8?B?S3FLOUhRY2ZNT1VxRFIwYjJZbzlQWXNxbllVQnYrWkpXWTdWSHJkUW90VC8x?=
 =?utf-8?B?VG1EV05maXFrS2lEaUI1S21iaVJlWTcwQTlFU1NuN09iZTJWRm9FQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4d048-1a60-4a6f-551e-08df0c0a9643
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 11:32:52.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYDzygDrADVOiA0GLTMlWHTO5WEU8Ilxl5ex8vZSvM9XrHEt7feHmWm4pQyrVYTdF96IUqaYkOLR0k10BEZD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9268
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 06 Sep 2026 11:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24096

From: Jan Kiszka <jan.kiszka@siemens.com>

This is now enforced by the encryption hook.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 7575d89c..dae87f6e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -342,13 +342,13 @@ config KAS_INCLUDE_DELTA_UPDATE
 
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on HAS_DISK_ENCRYPTION
+	depends on HAS_DISK_ENCRYPTION && IMAGE_SECURE_BOOT
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
 
 config IMAGE_FULL_ENCRYPTION
 	bool "Encrypt rootfs and data partitions"
-	depends on HAS_DISK_ENCRYPTION
+	depends on HAS_DISK_ENCRYPTION && IMAGE_SECURE_BOOT
 	select IMAGE_DATA_ENCRYPTION
 	help
 	  This enables LUKS encryption for all non-boot partitions on first boot.
-- 
2.47.3

