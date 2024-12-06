Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1816AE77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:47:40 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web10.33528.1733478458839613781
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:47:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=efKpcFAv;
 spf=pass (domain: siemens.com, ip: 40.107.104.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trzxvmx5V9E6mAWaCcMZ3X34Ez2XURPaDOS8iM0w9opSPCPVYaGnlPqYQV89rzxIXUJCWu+buKqLvxo4w0gUaBfaYRxNe/NHxZcLDEEI0PfSvIFDr+mXnooAP3y9Tl516LJSceZXojrnpohWKopzwo4lVJpybVQRznzl/KqEWVN9g5f89vbAGKVZn5EOHkY6s+sCxXp3N0FzbdMnLzKSN+QZ8au++6z5fBg9MieOvyflCPKCfUaDtefOhSghF4sadGddSHxYoplvCYtgCQ565QydULnwCGS7Sgiku+UhYA2GN4kso5zAgtcF5tcGvJqq1mV47ftgiJXIVOJ2oXOAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNqENCVZqWO9+gU0Ls0BsylWO9HhcZQfhhymupLNK/0=;
 b=yiXIywApRVF4CON7lpbprMNin/ajeLj++hU4EYaNRtmX0mcbq1J6/8X2U9HPk0WbM3q3guZfriTe7NTbG2YkJlfmW3pp3u7KGuT6UlNo/Z1P3DII4EPvcyH7wPncLnWPeBdiqo4a6dgyUJD+I/mxbHuirHmxMasnLfb06sLLhKNFpfNFyMJFIORlI0JUf2AKYbl7J3fVPFhISKbAzQ7qHaDBWy3eWC95gMlt4V2WA3kDRs+JqkR36w9wY7njoOOyu73OTfbY1b43dZcH3XNt3H/1z3JHDL724rBbPCrE/ea8gI3oKo3YVOHhdufhl7yfd+Ke6HxZGBIjLZZaOhnDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNqENCVZqWO9+gU0Ls0BsylWO9HhcZQfhhymupLNK/0=;
 b=efKpcFAvHxN1HNGW1WEAKNn9zUODI1q6eY5gjC4uENeL/dAgvoaI6VI3OpwBXAQCiJz+jq2gTLJQchuJp8rXFyb4JF++eCd+Q6PBMoRrkbfeGuBlPA13xzSQEjkezHjh3IU/ZgahZrrDcyOX1OUNYTtNn5eRYvkhyUIYgAZFBvmqrKuuOChZjj9cYRCmLW1fYxreRuie7CdPV2ubBtjiSU/ob2dvUfJW6oXuMDF56GEpHWQub34C0t/6cjNn/qpx3VVeESWtYCV1w0qbll1eHUKpY3Iv6c6qGQnc5WSKrsT+2A/GYg6J1fwga4gMVzET0rFuFFOC7TccqSM9IiqISw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.10; Fri, 6 Dec
 2024 09:47:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:47:36 +0000
Message-ID: <6182f4b9-d815-49a9-b9f2-8f000fd52fbc@siemens.com>
Date: Fri, 6 Dec 2024 10:47:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip94
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dae3e24-872b-45e5-6f81-08dd15db0390
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akxhN2p1NEFsamVGV2hUUFZpNzRtdnJYRmVHMGU1dEFlN3U1bVJ0NlQ5QU5l?=
 =?utf-8?B?T2JocE80LzBGOHpGcEpVaDlKc29zOThvWXNmMmN5MXBjUmd3TExlRk1oL21p?=
 =?utf-8?B?c2hEbFdpdFl4ZDBwRm5hSTF6eW9PeUN5ZnBVM09SZS9aOUh6QzI0MmpoV2RS?=
 =?utf-8?B?NGh3REVMVGl0Qyt5VXdIM3pSUjBiSXY1bW1pZVg1MFc4dGg1T09FWlhBTkZv?=
 =?utf-8?B?MG1ZQk53dmg5dTNPamtJejk1cTN6SVVKa3hwZFVyQ01Uc05WZEp5MjNOWjl3?=
 =?utf-8?B?eUZEaytCRDc2MDY3c0NRVzl0OEYxYW5LSHhZYlNDSjV4cnllQjJWZ2NkMEs0?=
 =?utf-8?B?VzB0Nk9LUGVPMzRha0pGY1ZSZERjSytVeFo5aHdPRVdBc08rTllFRlA4Q1hh?=
 =?utf-8?B?UmFwVWZZMlF3eUdGV3ozNnlkN3JoRHdDRExwSTNmQmMzTVNQRFZhUGIxZWVZ?=
 =?utf-8?B?WXF4QjlFYXFLQllvekhudzcvcmFXcjFzSUhPVWJnMU5XaUpTaXNBVG9RaitX?=
 =?utf-8?B?cjdIK2VLUFV2SkIxamFTN1pJQzhiOGIxa2ZSdHdlRThXcEZwbVFGMm44dGs0?=
 =?utf-8?B?UU96ajEvNkdocGcyYWNaUEdDSXhzZGFIc2lNR2FWbnFEYjhUZDZpL3NlcW5q?=
 =?utf-8?B?VVBleFpGOWVnVjlhUXg5bzJSa3FKVW5EZThaYWIybHUzcldqTG8xcDg1R09Z?=
 =?utf-8?B?TDJSdlFreG1NRGNxekFSYk93ckJPbjBzd0ZlTmprUnRTWE16eTU2UjZTZ3ho?=
 =?utf-8?B?Qzl1SHY3NkVkZm9uY0N6T3VRMEhvQnVTWDZoWVovY3VPWWRHYStCZ0tmcExM?=
 =?utf-8?B?L2JwemVVYjN2NDNXZ0MramJTMk03SEdJazMybDBvNnNyRktMZ3NUS1JaNVo4?=
 =?utf-8?B?dSsrVXFrL3JSczRKM2YxUlNqL1JkNkdmUFlYaXZHTXprTmlXZ2NRMlh3aWpI?=
 =?utf-8?B?R2wzS0x0cnlHUlU5SndtSEZyalJHd2VXKzB4R0IvNElOWFladzZuNUQrVFdj?=
 =?utf-8?B?cXhjVklSVitTcGY5YW1OSzErdjJITGs5RmNpalZoMzRXNWVhU1F5b1I2Zjdk?=
 =?utf-8?B?MkNIRmJLaGRsU1JaOFFJeGxEbzBUaHBXT1dNUmJ6SlZIQzNVMDN2ZlVsMFd0?=
 =?utf-8?B?anZWQ0dNbko3MGRzYk8xQXpLVXQ1RHhOSlNmZE5BTlV4YlJpdkJlS2FObzRM?=
 =?utf-8?B?SHE2amMzdWFISXMzditxQm45ZkhFS1NsZWt3S2NrdDc3ZGQ3Z0Z4SFdFQ3M5?=
 =?utf-8?B?MWFyeGk2Ykt0SWYwN0JBSDlmWXVUNzVtSG84WEVQTUdGc1QvNzJ4VUNzUWlu?=
 =?utf-8?B?MzlOVUY4Mld6WWtQdkVPN2VUcHNpZ2R4b05LcXB3VS8zcnREVWRlYmI0SWt5?=
 =?utf-8?B?bFFpY2Rqb01GUTFOd0IrNGNpbllTV1VZSzg1aUZkWU8xTWU3Z0RQVHhKU09i?=
 =?utf-8?B?bUdqdjFkNUlNNjlWMjhYL1VSdlhsaTc4anJjMWM4dW9NMFZxakJnV2ZVUG11?=
 =?utf-8?B?c3FxTGozWWF0bmoyeXVtSXdjZ3hYRUlLNXZDNVVTTTMyQjRvNEJSdFh6ME5o?=
 =?utf-8?B?dndCTHM1K2FMb21wTTIwMWhHcFdDUlUvUm92Q0RDb3BocHlscDVSNnk4RHlM?=
 =?utf-8?B?ZWYwV092c2Y3d1ZzaVptTmhwUGxzaDFRTXBlZFptT3gyM3ppeGhTOS9WUXlu?=
 =?utf-8?B?UC9LUkNoS0tQTEJhZHlmRHFTNjB6bTZiV0NDL2UxY3dzYzZ6RW5nckpJRFlI?=
 =?utf-8?B?OWpVdk5OYnhwbzhlYTA0TStyb0swekRXK3VHRnZtZVRtRzd6ZDYxZWZzVFVG?=
 =?utf-8?B?Y3YzbmtWRWplR0V6bnZPZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmJjbEdCVGlKUXp4YXZoZDVkeXc0dktFWHR0dGVGc0lOT3M4eWgwV2dyK0pM?=
 =?utf-8?B?emJyc2haaDJBaWs3MTNTVjMxenFNeG9sb3R1dGl4WDU1Q0pVNG5ocVAwWGJH?=
 =?utf-8?B?TVNrMThFWWdRdk83N3VDaXRjOHdLckJDR2N6UGZyT0V1VVd5SDlTcWFuVVZP?=
 =?utf-8?B?dXN3NXg4VGZ6bEp0cjI1dmp0VjlVYjIyaExMOEhSNHByL1NNK2Q0K2ErQ1NQ?=
 =?utf-8?B?VlZQRWQ0c1B1OWd3SzJPR1locGlXcFBwVW1mcEFxZjNlUFAvdlB2WmNFdkhX?=
 =?utf-8?B?WnVsV1U0L1lLbjNxTFJJNkxOVHVtN2EzK2xIa2NTd21rN1dVMm9YSEN2ckIw?=
 =?utf-8?B?WDl5N0tKMFdTdDdldXdJelU3b2t4OW9CMG01T2MyL3hRUFZWeHZ5VmxOU2cx?=
 =?utf-8?B?d3lDTzVNT1pTa09uVVZ1L0xnalJaRDdGVHZHR0h2Qm1QS2J2NHRsMDYvSFZD?=
 =?utf-8?B?c1pyS0tsSVVWQWwzVmFQNzk1NlZxRmJZTGYybEFxOFIvb3RWcjhMY0lSRVcr?=
 =?utf-8?B?cm54WmpRUCtqUWZXZDQzQmVzeWYwalBMS0U1ejJiWHk1RUo3OWF4bVpPU01j?=
 =?utf-8?B?L1YzYXZzeGRNK3pGOFpTdkExeHdEMGxUdmhNRUdDUjBKZUxZbDFScTJQekdM?=
 =?utf-8?B?Rk5sRyt1dmF2U3RaT1RSNExkZlZtQWxYMUxMQjFmU21tdDEwb2g3NFNuV003?=
 =?utf-8?B?RVgwTCtCdDVrNmpjZzVhTlRMbXJTSjdSbUhuc1ZGMlNQSTdVeW9BSGt3Q04v?=
 =?utf-8?B?dG82dnF6Ny91NUFIYjI0VjNIL016UWFaMUl0eXJsc0lyWmdBMmdiZ2FoaTkw?=
 =?utf-8?B?VVVacHVSelF2bEx3OHY4L0dVSG8ycUdGUTdmcytOT2lYL2JBcHJ2L2RCeTAz?=
 =?utf-8?B?a1N6Y0JMT2dvNTREZGRrQi9Lb1R5aGJadVpRZGF5WGUxZ1VGUWZkbmxsUm1t?=
 =?utf-8?B?WDRCdkI3QzE2MmFvVUZwNzkwYU9VWG1XaDBmQVVjU3FReVcvNzJYaDVvYjBz?=
 =?utf-8?B?SGEvSlZuWCtqTkozeXM4WjFrR3hvSC9XK0ZoWnN5MXZydDMvb1QxRHBWL0lG?=
 =?utf-8?B?LzRwaTBqemk3NVRvQ20reVBCbGZMemxJUGpsT25WTFp0WG5zeHBkOHpDL20r?=
 =?utf-8?B?Myt3WnhVc29yNGwxOEhyc2xZOWVtR0t1TW5LWWN3UFZqSmRGTjF0MXRBTXRq?=
 =?utf-8?B?YjdaY2dYclMrR253K3pBZitBb0Z4dUYxSG5NT1VySkFSRDNRbThXOTlldCtE?=
 =?utf-8?B?N0RldCsrZVRHZnV2a2k0Zkg5R0J3V3lsUmhpYjQyU0pubWd3S1NjWEFNbm1t?=
 =?utf-8?B?TUM5b2Z4MlBoSkZsakppb09zWXZIMGxxMzZnV0MvbjhhZ3N0WmhtNkhtaU9o?=
 =?utf-8?B?QitRUmFjR3FOb3g3NDZZdHdWMXUwVTQwOEpuSWlsZ3FpcGgwQlJ0WDlXckJT?=
 =?utf-8?B?MDNhVi9KSDEzdGV3ZWJEbjNSUjkvY2ZHVHFuU3RyN3ZWM3FIcjJ4b002VlJ0?=
 =?utf-8?B?M3J6cmVGQ2R0dHhPbFBTaFYzNDBYVmpsZXVIWlBENTRKU1NoSEFWb211R1Qz?=
 =?utf-8?B?Wm00RzVreEZvbFlxODhJQWZ3Z0JVY2pMOWVUc0FnRjFtYk16aTIzdU13WmJt?=
 =?utf-8?B?WGk1Wll2aFo0Vm12NmdvZGdtaEswQjFrQ01FVU5uSDJsWTZNaWlucmZnRFpj?=
 =?utf-8?B?K1o3WFgwVVVCaWx1L2cxTEozbUdlVDVQNXFBTjR1R1BOSGZpWENxVU5jdith?=
 =?utf-8?B?bStZUUU5OXFSUGZFR29vYUNPYVdhU3luRCswN1IrcVZMVXVVSklMMVdaQlZ0?=
 =?utf-8?B?aDZHd0pwcFpNTDM2anRaSFBVUytobTVrK0lhRGhub3k3ZWFYajNNUXhacm5l?=
 =?utf-8?B?ajB2U2VkQnpWRXNTTnNyK1NWcEF4QTdMRVhMbW5yZXYrS0FBWTZ4MVpsQVlJ?=
 =?utf-8?B?em9KY3RVcWM2N3laZG1kVjJBR2dGbmtkMjRwV3FBaHg3UlVKa3hXNHBTRy94?=
 =?utf-8?B?WmIwL1ZaQ3R3dVFJTWxUcmdJaitqSDF4K2JNcnZ4eDhOdk5mUE8yakFxcVVF?=
 =?utf-8?B?Vk5IOThna2xEKzRQN01mUVBoMHM0WTB6Q3kybFBNSlZpaXNBbkd5Qjlkc25S?=
 =?utf-8?Q?50RdA0J4oqK7j4WdUxr5/8MF1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae3e24-872b-45e5-6f81-08dd15db0390
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:47:35.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/C1p9fpXMXZcPybil5PD0j5QA+3Blk3T2NjJ/k6uOCKGXrYcwQR1TmKRl5SaO0BF9NJyky24unYoIDNKhWnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6724
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17361

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip93.bb => linux-cip_4.4.302-cip94.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip93.bb => linux-cip_4.4.302-cip94.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip93.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip94.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip93.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip94.bb
index 7c080ae3..3951814e 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip93.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip94.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "4fc7c7364c410ed5dac752d2accba0f78b09c01322f321ec97b7a2880c5a40e4"
+SRC_URI[sha256sum] = "c8fc9015d6eb49164e45a504d86d00627dd5fabe0270e35a7d2b70be9f7aef98"
-- 
2.43.0

