Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD5C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 15:35:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web11.17809.1717688119940113698
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 08:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pHS09KA5;
 spf=pass (domain: siemens.com, ip: 40.107.6.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6ECF7HZGe3vD7Z028HyFVI6yiBX8oTu5gRtInlrjJZYFRvcR33nCGffe33khytWteURMLRyqtP2+xKQCf76+EXi7R7qzqgOsGtIIlW7Mq9FUS0DsKIRig8jLYQKvJUvDKxTqYNbszJ07UtXsXHSWpztIYt2EEmiI782oHUhQt64+EiPeiBUlf4Kf75IWakEL/EbuAKFBxfDbC6tSJuXlDQDg5TNqx9qFAr7UhU4ZSch1L3Yjby7xrK+1yLbihhLx5s94oMEoSafDDGtuiMDPoriOWL0Oyv54CtsgqOdH02Q6TKgFNJaSgtOAUxcNjHU9kjl1RmaBsgSP6cLiF4p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxXdTaDwJWS5PPHrQ7cqRcatVaqMrVnRzE4zsVFw9fM=;
 b=IuJBw8JBiUot57e4qrG2su+07z2U+lyPMq0+KTXVu+G0jjV9WiOINLWD8akZTzngxQBWEAl2L40z9wgga0+IclzD4so8IZDAiyNOkt8VVsd8V0+ukbx0laMsTqKqQQ7t+P8qJ3ynAyFDGhBtv0tNmM/L3xDsDHXPDOwg0tMCnUqSw2hovkqByVKAKWnVYTsjdFvhHONGucGauzcPz0tSaRmQUZyUw6d934tDjmt0420rjzV3s1W99cK3S8OZVJj4LaJYgJnzu4ZPwu9vGHflhOrPwtlif8NQbdDwQTkZ+0nnTKcFzl93z4GWdtSNzjYgFGxXL7do8hGPUUta0nAp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxXdTaDwJWS5PPHrQ7cqRcatVaqMrVnRzE4zsVFw9fM=;
 b=pHS09KA5poWLlW6h9BAQwXOASga2rnfbWYVbiryEXckQMv07gWQVGUDdHBz9D75SHwtt6RHuC6XuZ1bq+rxsf5MbopHRSrNPSOW3JG1j4EwOPko8v+SfD0gQO9pryi90FPedyQ4Z7kkk4c/DMA2S7p1zWMpjI5VV5Z0aPDbcJQw9blQLsoTCANVffd7NxTXrPnWfGXJEvtriN3+sL0AiIWHI7RAK/qYL4C07Zz9n7tYZVUnZnsUrAQzVjF1ryRlf2vXQFOQNMwMGkwhhj+/SwawJTcjRq5zR6hgGBzHNVbOCfR8TJo0pC1I67mxrlw/bByp1Nlnf3Zv62m3HoeDzgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 15:35:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 15:35:17 +0000
Message-ID: <c2c1f925-fbe4-46dd-aa77-52a75abf84d5@siemens.com>
Date: Thu, 6 Jun 2024 17:35:17 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Fix and update security extension
 option
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e8a5f9-5d9b-4a9e-c8ae-08dc863e44a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWpJQVh4cE9HL3pmRkxFdTNUWVlpRUJyN3dIbUhRZ3VuYm9RUUpvTGRYWktn?=
 =?utf-8?B?NVl1TjJVbnZudVRCbkRUWUtrT2Z4R1dPMmRabXNBZ215MEx3WEh5QlZzdXd4?=
 =?utf-8?B?L1Q4bGxkdGVzajN1b3d3VGdZZUs2dkNpQ0N2cTNuWG5NbVJOdkR2NzU2K0My?=
 =?utf-8?B?NCtDVDFPeS9HYldiSWxGeEo1VTdDVi9INFFONTIzUEt1dTBEOUZDS1JySmsx?=
 =?utf-8?B?ckFldWQ0eUQvSDVVUUxZR2RQUktmMlpjcWpJNFVwMWk1Zk5FbzNyVmltNzdG?=
 =?utf-8?B?R1R3Ymx0cjhaZXhER0dSejdRamtCbWRVbXNkdkhkVGlzMkhCeFloVmVBK1gv?=
 =?utf-8?B?VGhzeENuSVpsTTAyWTkwR0NyS0VtdU16NU9ZdnNKMlErV2dQdHBjT3B2a1h2?=
 =?utf-8?B?d3htMEdzWStKN0xobTlacGNNdS9aa01oeDZmL2o2RjhUYWczTDlZQ1FuM2hi?=
 =?utf-8?B?eXRGdElQdmNlYmJvWXlDQ3dIbGtDMWJ6NXdFbi9rdVo1eXdjNE5GdkJsUHFN?=
 =?utf-8?B?SXV1M1VVMFljRks1WnJCWmtyR1F1c28vUHJYUnFkR3YxT082dnd3VUZmZGNB?=
 =?utf-8?B?UTNWVjUveFdWUlhnSnJvVmdaVGZoZFpUeHRKcFFNZE42bU9WUHpKTys5Z1o2?=
 =?utf-8?B?d0FzYTBHVFZLK0tGMUdZeVRmQk1xdVZ4OVFjenoyN0k0YlFIRVpUYVM2SnJv?=
 =?utf-8?B?aUNid2U3RjY1cCs5RVpyaS9MMDNvNS9EK0VOcFBmYktMZ01yNmpyYzZtSndq?=
 =?utf-8?B?cSswUUlZUk5lbS9CR1VJRnp0WEtwTFAvSlhRU3hoVGpiQ2FRVDVZRkh0TFhT?=
 =?utf-8?B?aHc2U1ZkUDVWOTlLaUhxckFJRjY2dkh1NEIrdENVTzdiUkhWRzV0TzdCcEhE?=
 =?utf-8?B?a2cxcDRQR0JOKzhPUWlHQmZYcFEvRU85aEswdGM3MXdRL3paclFYRi8zT3FN?=
 =?utf-8?B?enE5NU81dzZOMHZLYnRGbUlXcnNybDhnVFA3dC8rci9GMkpmNysrYSt6RDZw?=
 =?utf-8?B?VUVkMHRZaXJwN1hRU0hzZFA5bVdWQklsWk5wZFVTWFhHQTJJaVFHUlhjdHFU?=
 =?utf-8?B?M2Ewcm1xZytBOGhnRGdaU08wcGRFVWE1SlNiODJlb0xuL29ZTVRFMFdNNUxJ?=
 =?utf-8?B?YWJTQnVRYmlHS1E5T08vNmt3RUw1ck9DSjBwYzdQYTE3SEY0dW5SVDZPTE55?=
 =?utf-8?B?NGt3dmJETU5Jd0FzSzVSeEl3RnAxWDB2SmZERCtPNHBGbVJyTlJBWmtCN1V1?=
 =?utf-8?B?aFBUZkdxeFZ3MEt3MnFoOUpyYm1YVWlscGZXVjBPZ3FVMkpSVnNtRE0yMncv?=
 =?utf-8?B?Z09BYmlZMm1zV3dDMVZzOGxIc21yUy9QT3phWm5hTXc0TzBTSlZzT09KSkEy?=
 =?utf-8?B?T1pLeVdaQnZhZjRWdHpHbEd1ZU5aa1BwL0tMU0pTaFdUMVpCU0Njc2l4QUdY?=
 =?utf-8?B?Unp0N2NBY3VlVHB3SUIrb2ptK09ma3pXMENaQmNnYzhDVEVrTGcvTGJDdkJq?=
 =?utf-8?B?clFscTdrbVBhWFhjeCtOT3BhTWRabDlUYThxTlRaT0dCMjFHV0NzaXhML2FX?=
 =?utf-8?B?VkVPcEZ5c3BSVnhzNDdvN0hyVFJJRE8xaHBPMWc0YlR4d2djZ2dxVkdVSi9i?=
 =?utf-8?B?NmtSWDdPT1NkaHFKaUtZakZQUGxsc09sWVo2SlJ4elFYU2dvd09CeTdJMnll?=
 =?utf-8?B?QUNGZ3NLdnhFOVYwMjlDeTBGWFVHSG5PVng5dFNCN2doQmZKQUtiRXg3ZzB3?=
 =?utf-8?Q?Rwl/GX3+12pd40ozw4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q215SHlSYTlnQVh1VTUxM3k4QVVoSTk0Z3FVSmhmVVBBeXcwR2V2ekllTy9r?=
 =?utf-8?B?ZUQ4UHp3UWZ0RktxTGp0R1NrbnFDNVFpOHVmMWgvZXlZZkVnam1JZ2RNNTVI?=
 =?utf-8?B?aDhLN2U0THQ4RFV0NmRFRzhsbUdIcWhpeHdjUWdvcDJBRmlzUm84bVpUcC9X?=
 =?utf-8?B?QVF6aVhBb0pteE50NEdCRjRFd0VWMHRINkJKbjFaWkFERmVmYmpHODhYWkNm?=
 =?utf-8?B?bGkyenZnYVpKNWZsMU9MU1NlVC9SM1lwd1o2eFNQTDZTL1BERHVVNkpjU1FN?=
 =?utf-8?B?V3AwalBJeitXQzV0ZVB6RjRVemNETDJJeUpod3JndTNUbUNMakZQenFEVFY1?=
 =?utf-8?B?R0Z0Nm90THA2R1RtRk4yMVE0NS94NElHK2Z6R2JiZVZFalp6M2VQdU5URUN1?=
 =?utf-8?B?TnJ6RHVDOERURkl5cEtUalhoQUgrOVZBNlRLSVhqVTBxaE1DWTU1RkduNnAv?=
 =?utf-8?B?NnJNWW5IM0JnTkM0M1pOT1hxdHRJVWpwejh0dCtTbS9qT3Rxd2N1azU1UFFU?=
 =?utf-8?B?WnRCU1dsK3p0K0RSNDJnQktCblo5NG0wQW1wSnJidWN1T3ZwekMvcmlhd3Z3?=
 =?utf-8?B?dlArTmZvZitqaVRjajFWc2EzZFFnYkx4VmdFNXJWVVlZYjFYQUh2ckdGRnRG?=
 =?utf-8?B?NFlnUE55d3F0WFJGZ3pXZ0NPMzZOaGNhdzlDS2QvNGVWbk5xbWd4Qy9CMTRH?=
 =?utf-8?B?b25MaDhjVmV4L0oxT0VkQm11ZU1IY203S3hrN0w5cG1ocldaNjFtVStzUGxs?=
 =?utf-8?B?TUhrWHhrZEhQc0ZEdXdEL3VGWFA3SVB2eWJCT3RXaWlidzI0VFBkOXE3Y2Qv?=
 =?utf-8?B?OFpmdzNJeDk5VEJ3WGxqVXp5MlBwb29PcWpCdUNQbUIrSTNLOHdZenB4NlBR?=
 =?utf-8?B?bEcvaHJWdW04U1Y2cElKVGd6WmFTYzB2TUoySEVHLzhMMk9BQ0tGdFRkTitz?=
 =?utf-8?B?c1FBTmVoa2dLaWYwSnJaYnNFSjJ1UEdLeDNGYXVWVEc5RXVWOVhJeGUrYlRN?=
 =?utf-8?B?M291clFWb1oxd0dpdTgxOC9Nb3Y4M25Od3o4dkUwRDJuS0w3RWZEa2VIcER3?=
 =?utf-8?B?ckIwTFpnc2hqeEVyZDdNKzBLcEJ1RW10MkNBTFkvTXBCd3liR3Z1YXZHNmpL?=
 =?utf-8?B?aFdlZjJoU0UwMlN6RzFjNjFBVHpMbFhKRnVMKzMrNnBHS2ozZEJNd3VNMVk1?=
 =?utf-8?B?MXoxZGZLK3lOQmVlYkZlNTZPdXBUMmtxUllKbUZwMHZtZHIvQkNqOGxud0Y3?=
 =?utf-8?B?bXBncHVpRWJEb3h2WW51OWF2M1kvbHBENUR1WlNoT1hMaGM3b1VFSnBXYlhE?=
 =?utf-8?B?dTVQb0xTY2NZcEpsSEtrTkFnTUFNK0VNS2F0b0VXKy8wQnljbWlsOFJlNG1w?=
 =?utf-8?B?a0dSUDhvZDdDc0FKZUxHL2tiYnUzbHNWSXVjYzlObkxOd2NJVitEbnl4Wkhx?=
 =?utf-8?B?M20wNGhIdjFuaUN5ZVdnME11ZmVZaUNUNkcrZE9Tb2RteTJwcHQwZ24xSzMv?=
 =?utf-8?B?Y2YxZ3QxQlZ5TTVFZG5kZ241WTc0akNEU1NCN0RWcnZZL3NxajBZRWg1ZzZ4?=
 =?utf-8?B?ZThnMkdoL0kwUys5cTJGSEIrcUVwVzZhdWY5bW1Sd0pCKzBXNlpZcTlVZlFN?=
 =?utf-8?B?OGtsMGFkZHlxckFlUHZ4SzN4MmdtenR1L0VheXdjTlExOG0rQUJMYVJIQUNw?=
 =?utf-8?B?MUZ3b1ZObDdGdXFLUFIzZmduQURXSE1lR1AzTDE0VENnVDdETjNidTdRZlI5?=
 =?utf-8?B?NklBWkQvM1Y0bHZNc09GTnRVMGNJY083YmZiVG5wN3gyblV1cXBwL1NPZTJY?=
 =?utf-8?B?UDhodmE0V1BqN2s2bzdVSUpGcmF4ZGlkZDN6QU1ZbWRLNnUvai9sYlgvMEFn?=
 =?utf-8?B?Z05YY2VzLzNTUVkxMGJUd1Roczd6OElMVWRqL3ZFNnlNc0ZTV2ZNczJXc2hC?=
 =?utf-8?B?UVRidVZyQU82ZEFUZ2xHcllNOUl6ckVyZHhRT1RHZ21NQVdQeU1RTFFFbkl6?=
 =?utf-8?B?L1ZCdC9lYS9XWHgzSUY3Qm9RZ3g3eUZRSWtPVnVLY0lFckhOQ21CTG1jMDhs?=
 =?utf-8?B?Q1lXOWpXRTJlYWwyZEpHZTVzRGVZZTZXdXc4SnNUdDJKUytjMHlpYnNKTEpJ?=
 =?utf-8?B?OTlCOGEwQTJlanZDamdqOGZMdkxWNDhST3A0bjdJUUh5OExwU2FDUkF0Y3pi?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e8a5f9-5d9b-4a9e-c8ae-08dc863e44a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:35:17.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21pdhUBtsVNUiaBTQBr7rvwfpngQr0ZlCTq354Hsy2Jn6Mv8SbKMeIin7TRDtlv7p0IVwEj5N1Jh92QA2wPKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3749
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 15:35:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16130

From: Jan Kiszka <jan.kiszka@siemens.com>

This selects IMAGE_DATA_ENCRYPTION but that one depends on
IMAGE_SWUPDATE, thus we need to select the latter as well. And none of
this is supported with kernels <5.10, so move the security extension
under the related guard.

Finally, TARGET_X86_UEFI is now supported as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Kconfig b/Kconfig
index 364a84e9..9aa05d2f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,10 +151,20 @@ config KAS_INCLUDE_DEBIAN
 
 comment "Image features"
 
+config IMAGE_TESTING
+	bool "Test extensions"
+
+config KAS_INCLUDE_TESTING
+	string
+	default "kas/opt/test.yml" if IMAGE_TESTING
+
+if !KERNEL_4_4 && !KERNEL_4_19
+
 config IMAGE_SECURITY
 	bool "Security extensions"
+	select IMAGE_SWUPDATE
 	select IMAGE_DATA_ENCRYPTION
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 	help
 	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
 
@@ -162,15 +172,6 @@ config KAS_INCLUDE_SECURITY
 	string
 	default "kas/opt/security.yml" if IMAGE_SECURITY
 
-config IMAGE_TESTING
-	bool "Test extensions"
-
-config KAS_INCLUDE_TESTING
-	string
-	default "kas/opt/test.yml" if IMAGE_TESTING
-
-if !KERNEL_4_4 && !KERNEL_4_19
-
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
 	depends on TARGET_QEMU_AMD64 || TARGET_X86_UEFI || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
-- 
2.43.0

