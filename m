Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974CC369A2
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 13:25:31 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.44])
 by mx.groups.io with SMTP id smtpd.web11.46872.1744032321179288459
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 06:25:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ahBtrK55;
 spf=pass (domain: siemens.com, ip: 40.107.130.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwWbnk9jbRG9wv7w7wMm50e5ePo5DkIw0QBujv3w1zgwp/UcvZA8c+KTdJgtoGhUcpRPyUnNQFvJwlelGmFyZNlIiIuEp88ayfXlWRodZp+BWJMvCjiijy+uiH6qyTgCWn/FKpRIPDf8HYBrs/8iRgjjU+hZ2/yXjoHwCvYOs8VDhJxYImExLWZMWarpGPXsCJWwAc/09MCWFHwymcgIgGhYTRsjFPlFwdTc2iO+ZfQY3twOCUa4V+kjgllMRWdF+CLlsJtTCFx2L/hfvugy+4tUUGFUz5bxQa1bdGAMtakyKLaTGAc2+cGRa+b/cGkWGI/SSglrjEhfcL3NAT2hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDxTwLdWM5JkZnbbHziR4kxzLrvQYUdEZYy5kx9rWbM=;
 b=JDRcAAijV+p+lpGZWCw9WQSds8R2QBkOPKY+f8AI605MuIuxQ/K71NsPUHGqq97RPJmiHxEE1Ifb3YxvRkBw4DI//mTKGHIyVvKehKtEZTOFOY2rfjcolRT5Fmg0vOUqTvlCbKSeZHQzq54JnXevoJtl8bj90Rz3kdhkEh26AhklH/NLu39xbTr5XJ2ww5EY4jYZPycGkPpgBKpPEPYTk7pt8N6szM+dJlewg0GHFBBIclNIesrJBajzE8nQH3Cr4pHB8jjYVpMegPVL56dYiwvGw7E67eUNlZsfAUxmVYcPJeIf36F+nQjm4LPhix38ldjz5xsvI/UrvgZe73K19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDxTwLdWM5JkZnbbHziR4kxzLrvQYUdEZYy5kx9rWbM=;
 b=ahBtrK55dJuJ9NpLU21PkdsaevcTPNk4y46/0Ys8bQfR84inHGBYwCEc8fllPBk0N6HFLq9PoFSa5MQtOesW8mLDsr4dQSLpVzzqGOc46Iuwo6ineRwuguzqmo8JR4bVm+gTdCx4Ysm3bsIlrDnzH9Ld0vrBAOoN9/Aqf5pku0GZAqlAB4GMPrmaJQo4PHNTzJYpAMfIedmYb1OGn4jvB7q/LueYrc8Xh3pOc0d94NmtyzYwRO/DZkmwuzUwI/SIDz1ZYu9Rh0KdPB5THxEpQTO3xH1QSx2Rsybyq/hsv8t7odRDm6Io7PbyVRYbvsiiW93G1hgMTQ6ePgNX6dLSaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 13:25:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:25:16 +0000
Message-ID: <b1ab4d90-48aa-4464-8e76-ec7c0daf5f8a@siemens.com>
Date: Mon, 7 Apr 2025 15:25:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.132-cip40[-rt21]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 863d8c6d-a5d9-4a6c-9fdd-08dd75d7a262
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVduVG0xTENweWNvb0F3K20zRHpUaE1zWUZLQ1dBNnB4cHhLa1IrVGs2MUp3?=
 =?utf-8?B?dkRIMkNBQU1nbjFOTFp1dm5BTnUrZmQ0eVR6NDFxTFVFazFET1FlU1F5UE51?=
 =?utf-8?B?aGdFcFBXUUYwa2kwa3dDZmg3Ukl6TE5CL2JDbTFQbGNlK0xzejk3NUpyckFu?=
 =?utf-8?B?elc2L01MNXRrYjBFOVI2d0FvVDBGbFRhVk9rRHVob3JYS0U4a3lxWlhRZGFK?=
 =?utf-8?B?aGlONDh6aXFoa0FzUDJhaml6bTRhODNSeWp5ejdOZlhsdGg4d1ZrZTdJVnJp?=
 =?utf-8?B?amlYNXhEbnIreGU5Y1FjOVYwc0RTTm1peEQxQ0d0VjhSRUxseWd5bU4xWFdh?=
 =?utf-8?B?MFBiRUtIejFjcEU3bmtHemlGOWZENHRKbjZDb1pUVUdtUm1kQ2RFYjNyVDhr?=
 =?utf-8?B?ZUlxRVYvV2pmY1lmRGxhOFQ0WDZtZkpRdWFCTXRFeVpjUklnRGUrckt5RUlT?=
 =?utf-8?B?amhub0dXWUxMV2wrRTRFUXc1SjRFOU5yNmtvc0hsR1pMVUVmTUlxV1ZER0pF?=
 =?utf-8?B?VGk0dy9zc1ZCcm5Bc09rYUcxTUQ4K29DVmI2U2FSdXVtMWZycVpPTVc2VFJj?=
 =?utf-8?B?MkRTdmdZN0dsWE1DVWJxSVBndjNwbERsMFFHUFVMWFhTNFVJb1BZaGJET0Ir?=
 =?utf-8?B?TlRndWNYZ1ZZZkdmU2RwcHFxdHpoYURRaDlOK1JqMllyaHJkb2cyRVBLMGVQ?=
 =?utf-8?B?UXduYWw0QUVZQXRWVFo1b3M0N1I0ZkxXY2VrNDJ4QXdzQ2lCdkVGcGUwelZy?=
 =?utf-8?B?c0owSkFKMjE3eUlQdzU2VWR5SmVMT3NGRloxRHJPZkZjUktsc0VhUms2UE16?=
 =?utf-8?B?RnpDbHh4STR3OXo3aDArSUVSNmhINWJJdEYvbC9LOWZrS3ZDM0ZlNmpya3Ro?=
 =?utf-8?B?MUtMN0lzejNMWk5UZ1U2OWFGTllVcVNTRDNtaGRWMjNwWk96bUNSejZPNjBU?=
 =?utf-8?B?eUNlVCtDMy9GenBnK0V1c0o4bUVDSkYzNlVJYUhnQlBLREVYWEU2cjFDU2Jr?=
 =?utf-8?B?QlRHUThPZlZ6dERRdDRUL1EyT3Q3OWlpQjV3VXBhT3A5UU45TGxGcFdOYWUz?=
 =?utf-8?B?OXhtR0RjVUdkNllleStLN2VrWko4U0NVQXc2enZkRmdHcm9QMFNITWl4dG5R?=
 =?utf-8?B?TUFSYUpvZXpoOVRMdXhOMkpNN2RrdnhkMDhzRm5ISzVWOHp4ZVpPdUY5aXZX?=
 =?utf-8?B?TnBjRUVjdEI4YjNkT2tobHpsSjdKL0JIMFAzU0RXWGdRZTdrTnIrVmJSNkYw?=
 =?utf-8?B?ckxjRHZiUW1PVE5GVWl6bjViTHpyZXgvVXhxdU1ZTlR4bEZYTFZ5M2hTOEFh?=
 =?utf-8?B?MENMK0tSTDVzWkZPR2x1Vmw3WmtqbmI3b0Y1d3VRSGRJWEVNcWVUWjdKSTF4?=
 =?utf-8?B?RUFJZEJNOStpQThrMHhmSEluL3RycThoVUxWeTJwSFc5UEE4dUhvbGt1a1kw?=
 =?utf-8?B?VVlPcHUvWDdpcCtFa1JXa0hZSmNqdnpweG5xWGtBd0RacG1LQSs5YW1Kd1dO?=
 =?utf-8?B?aXZFdU1SWEhQSVVGaDUveXk4VnU1U0x1UVJnTHNyNWU4TlRkc25URWlMZkQz?=
 =?utf-8?B?R3d1MyttNVNWa2hmWjFOUFJqS0d5SG1XNXdTalVJWTdQWmdkY3UwcHpLWjU0?=
 =?utf-8?B?RnVwMUYvVjFGTStJQndKOFM0NWxDTDNWeld5dmlJdVZGR3NLVmg3QTVWY2Z0?=
 =?utf-8?B?c1pBalhDdUpMdW40cUJUMWQrZnZCaktlNHluZnVDZDZVWmFQWTk0RVZoUjYx?=
 =?utf-8?B?MXArY1VQazNyMDZtc0xOei9vby9pSlZlZlNXS2NMR0ZVMGhZTVlDcFJpeVRj?=
 =?utf-8?B?NXhMdFI3VzY3a3o4eXBsVG9YVitWZW9zTkxEU2VmSjFrTi92R29vemUvaGN0?=
 =?utf-8?Q?eD3x4pLNYogM4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wm9TZmxreGo1TDRMNzRIajJkanRDWi9ZVit5c3dEeVdyclBDdUdNU1dFYzdL?=
 =?utf-8?B?Ym92TEh2Y0l2ZDR5YVYvQnV2Uit2WjdCd1gzM1crWVcwbGZXS0pqaS9qQzBD?=
 =?utf-8?B?Q01XdUFTc3dJT0Z2dHhRc0c3L1VsSXMyeDROZVduMjkvR0pwR05rZHJDVVZJ?=
 =?utf-8?B?cStjRVdiRDR2b2wraFdPVWkrNHZGL2Z5UnBoS3ZuVEdKNCtLcGJIKzlkbk9P?=
 =?utf-8?B?QUpEcmZSYmVuamphSHlqR1FuZ2RHUW5oM1FrQVpoUE8vcTNBY2Z6R1Q3aWM5?=
 =?utf-8?B?MS8ydlBJZDdNV0NTbnVEajdqb2p6N0JoZjhZdWNJZ1oxQ2lwNmRweUJrZUw2?=
 =?utf-8?B?UW9JZGZ6S3FhZXhjSlkzbVB4WXkxaHNDUkN0ZDVmOWVZeHlOQUZOYWpDZVhz?=
 =?utf-8?B?LzZRNFhENzV5NnlYN1JzQWhydVhWSXZvSHoyTlZLRHo1YUtBem41Q2pHVTlo?=
 =?utf-8?B?cXNkbE8vRDdscStsdE9aWkczTlhhdU4yM05KNFByTU4zZCt1L3l0YkJSNmNj?=
 =?utf-8?B?akpCaVlFRUhraTJKU3I4cjVZMU9NUWZGK24rZjlLZ3Vaa0ZpL3FZQXhwTFcx?=
 =?utf-8?B?K0xUd2pLRFJwRnQwRVRzSnVpLy8zN3d6S1IwZVhhOWRvLzd4M1ArS2phdFlK?=
 =?utf-8?B?NzFDbCtPUUpKVzBwSGFJellheUhtdytqdVRmVC9EK29oRjZHWWNMdFdjSVJy?=
 =?utf-8?B?NkpJbVN2WjhFdFUzMzJoWGZEbkd2cWpCT1YyRzFGTU5HRkp4bi9DR096R3JY?=
 =?utf-8?B?WExRRmpBY0E0Smo2T010aHZhWkxOcGRtNlZjVUt2dDYzSGZXOGk3SFVJTnBN?=
 =?utf-8?B?QmFrNkZuanJHdFlTYjd0YjM4WCtoSDlrVk9IcGVRTWlrVDZrY3hKT3dhZ3M0?=
 =?utf-8?B?NHlaVW1WZ2trRVhjQVcyWmxrZVRPaHpMazl0REg4a1dKM2dGVUNhMUpjWmJV?=
 =?utf-8?B?czZQWkliUTBXK2RBY2FEWXlnT3UwSWgrcWpsUmZhZUpQam1icjczRkpnU29s?=
 =?utf-8?B?S2RPdXZhaEE3cFRNNUVwSDRGS1I0R3RuYzNnQVpWdGxWVlBQSUVDMmRHSmZ0?=
 =?utf-8?B?VUFBZEUzUlVwYWFBVVh5K09uMU9seElWaHhhT3JvQ0tGU3p1YU9YMlBTOHZn?=
 =?utf-8?B?b3RudkM5RTF1MW5tdXJzYUVOTWU3eWZ3Tmhpb1VQMkc1L3hqQy8yTzhydW5v?=
 =?utf-8?B?aXFzZ0xKR1o3bUVESTlCMFduMVU5K29ha0dGa1Y1YkVoQWY3OXBHRVNHWFZs?=
 =?utf-8?B?TCtXeHFkaWozdUFyY3d0SU55NHhMUWJIVWxwK0dLMFIwbE1NSno4bi85QTEr?=
 =?utf-8?B?MC84RzBYcG02M050bVYwTDN3bVhIbTBjUUdqancraFdKR3Q0M1Z3TFFyUyts?=
 =?utf-8?B?bEEwcFVqVTFWa3lESG5PcUgrN3N6Slo3S0hCUWFHY0NXWEpnckVGNHVVdFp5?=
 =?utf-8?B?ZG9VektvU2RObExwcXI0NE9sODFLSVZIc051Y3dsYWRjRjdSVGpQN0ZlaE9w?=
 =?utf-8?B?S3hsRmxiVnNERnBCbnhMQ0tWaU9LQ05nenhTSzIzRWwvMW1XOTBoRVd2Ti9t?=
 =?utf-8?B?aWI5UkpFM2MyTXpSMms0MGZkK21kQlJFbTl3bVlzeXA1b0VGWXhQNG9lZ2N6?=
 =?utf-8?B?YnhIUlpZU01xU3dQaUVwVkVJdEdrODlKY2pBRjVDekp6RU9RektBM3FxSGpl?=
 =?utf-8?B?Z0ZnU0ViOHkzMG4yNHdvc3BKdjBzSllHMnFHOFNmZ3VheUtSREpXcWROTndp?=
 =?utf-8?B?WGxDRTBqTDR3REZ5WU1IRWpUcE8vSE4xdDRxUU5NeVB5ZUFGZDFOLzZYaE9u?=
 =?utf-8?B?NWZ1NHBjeU5XNkJRWnROazh1WU1Ra0RLUU40NERzS2pYUjN4TmRUUXRXWmhs?=
 =?utf-8?B?TUhGNTlVYktTS2dlQWNkQnVOOTJaQmtXbk5ONlNzd25oOWdUdkIwLzErSm9V?=
 =?utf-8?B?MGl2aGpEVkd4MUwxazZpSFc2QlNsV2Y4NGJ1RnZ4UkN3ZVFYd2xNMlhzcHZ3?=
 =?utf-8?B?K0FxZWZkR29Vbldyb2ZZMy84SjFhYkRod2xUSzlTc0ZBb1IrRGZmMXFnakxv?=
 =?utf-8?B?bHNOOCttbkJXczlTWTBSMTFVZkpYV3d2bmxmNzc5S2ZwYWVaREQ2NWN4MWZx?=
 =?utf-8?B?UDg1UjUvUFkwdlhoUkZUejBxemZvb0hvTTNVMEplTzhSSTQwbzl4Ni9SeEJX?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863d8c6d-a5d9-4a6c-9fdd-08dd75d7a262
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:25:16.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tVXQ7xMaaNt9UvjPy3GQTCQzU1Q6bUwokzmDtKEF7z9r8u88MmFN1Iwpa15RCozqGUZHeLGpNJftqSTNfsv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 13:25:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18491

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.128-cip37-rt20.bb => linux-cip-rt_6.1.132-cip40-rt21.bb} | 2 +-
 .../{linux-cip_6.1.131-cip39.bb => linux-cip_6.1.132-cip40.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.128-cip37-rt20.bb => linux-cip-rt_6.1.132-cip40-rt21.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.131-cip39.bb => linux-cip_6.1.132-cip40.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb b/recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb
index 6c780826..e151c1c8 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "45a2eb7cf72faf1ac8ea4a6dfa8891671c74f89e0265cba2737f116fbe7c22a5"
+SRC_URI[sha256sum] = "788e9169d1b41132ff980a6b6120cca5ae5d951ea9d01c26c6d40a82e0835e83"
diff --git a/recipes-kernel/linux/linux-cip_6.1.131-cip39.bb b/recipes-kernel/linux/linux-cip_6.1.132-cip40.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.131-cip39.bb
rename to recipes-kernel/linux/linux-cip_6.1.132-cip40.bb
index 5bb45114..16364537 100644
--- a/recipes-kernel/linux/linux-cip_6.1.131-cip39.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.132-cip40.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a83a4381dc9d0934bca7a31c6f30fb587e5d89c03ca5d361cd7425a3b92e850e"
+SRC_URI[sha256sum] = "49a702507398f3ab10d4ad744b4561983fbfa6d92dde9e10a9582d7bddc7f32d"
-- 
2.43.0

