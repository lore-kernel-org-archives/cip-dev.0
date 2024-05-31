Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FADC25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 06:24:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web10.5412.1717136667147461114
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 23:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m2K2jF92;
 spf=pass (domain: siemens.com, ip: 40.107.22.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hErIotqf5GG+Hpa4t0mlvHpavZP0dleGhx/gQEXj1Vue6opRFEzg5cmyQmohdvl7ICFTYCx62HV9I4XYfqKdO4LptqsnZkGN2WbgIzrlWMrSHMvuK7zattrLgDDfzCO4w4nzsm6EUwfQHABXRKKjXyJLGdSp0l1RKNs9MV62jhvi4TDgTYUz6f98rbOn0tmgbv6DDbGtDb7D19QidnJGPSZjXQ3BeMWME052q1KIxRWkK7hhKdK+/qnupixeFgLYkzy8KZIG3ltpblBYlcOEbfKa9sudSLH9Q3H8th/qdttdrAkQ/PcUYb4Mv5GwrOH6ASyCryvhQHTmrHiQlWqRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGoC2F3rRUvUHH7DRsUMCC+eFey9y2OtcbfgQEP58dk=;
 b=BwqrQQvSKMRHuWoLhJMjVac7K9L3w4VDMl6iCDTZRcGhPHrvWFLWy1K5ilIHcbrMsF+avnFVq5I8jfI7XBt91QEfV/RjmvDSr2IhvhbIqLdcqpiq/5Ei1+/C3E7oGWr+LjeaBN0+VtwMCZ3AxZg0cIZMLx/5vk2wilIb03KvkpM2Q+cI+P4C/AkhY0TPAnkM+N0kMrp5W8164E8VSig6OPvPx5TKvlimk/nFWt2UW4H+pVPjp2FgLVlIB3Zq9j0yd3tb1RSMZpg/1nRk32Ik+sEQjVoDjqH9HrAnxlXEPyiJfDuw4VF1kDlgm+XD33qu/zAK/NK22krqx8YnCMl6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGoC2F3rRUvUHH7DRsUMCC+eFey9y2OtcbfgQEP58dk=;
 b=m2K2jF92VzArcMEZ3H6k4jKGN/4SsDLxAw/8Ba0+hCSXFM35s46u2M3CRUZgaIxtXIii8wsFw/zLN0zsfvY/pzlGXP9wYkexegkCauWkaB97lD+Afp1hH/nETRujgBsDpoB7trYzEojzSAQKc3Eza4oxUN21QgmKJCPN1hdkNsYsZguaWrvrDF3D/rtHNxGZ5KRp0UJy8wslbfTfIKLGnhXtjB+4ApaKMq4z0OHJ1D+VaMCsmrqkSSh1hAe4p3bcmqDflkWoLZn5HXvSg1/hYz3yhIV8D59oOOgenoHG5QdQdb7OmpJx1p0VMVx2t7pQ3PZg8IsR3r7aflPTfGfqyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:24:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:24:24 +0000
Message-ID: <33909cad-c08e-4318-aa25-a0e1cb8dac70@siemens.com>
Date: Fri, 31 May 2024 08:24:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] linux-cip: Bump cip-kernel-config revision
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd751a1-70c2-487b-f8af-08dc813a509a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UGF1NVEvSlFUTWhuSFZjVTc1M2NaK1I5R2E0RUNJcS9uRGR4dHZNUVl4NU5h?=
 =?utf-8?B?d0dMR3A0YzZBOUU5eXoyd0dUZFVnWjFKZkQ0TG43UWhoTU9vSVl6RERSSHNq?=
 =?utf-8?B?NGlxaVdPNEpqbXAwcHNpUjdBK2FlRHNEYmY1b2U0UHY4UmNIUGY4NzhNOWFr?=
 =?utf-8?B?aUQxR2R0VE1UNG5xL3VFNkxXa3NHRHFPSFlLZURZU2lCb1VXVlFEc0hSY3JE?=
 =?utf-8?B?dks2ZFZLUjF6bGhPemhKVkNTeGhTQjVVY3lyZTJBV3N6RXNDeU9PNTVHOVB2?=
 =?utf-8?B?VDU2dDF1UWk3NlNpN3NibW1na21IRVR0dkx2Y1IxNjcyNXFPanZyV1JiNEFE?=
 =?utf-8?B?L1VOOUdJRlB4bm5vcktTTkEwZzRmRWpETzZ0S21jYjloSjdnN0J1ZER4Umtp?=
 =?utf-8?B?bnVjV0l0WFBMdk4yT2JBVEN0bGFZZ3EvbzRFbmluOU1qRjhJVDh6czFlbEtr?=
 =?utf-8?B?dDJQTkkxdDVRUEpZMmlnaFFMSjFtcWVvK01vcGxaM3JuaE53cVdnWHNGeUZz?=
 =?utf-8?B?VWJRaE96bjY4OSs0SkhZS0hJNWNDUUF5L0ZkVjBUZ09pY0REa2tQM3NsWnUy?=
 =?utf-8?B?ZGF5RDFRbUxOMUxmRTNTM3dSWW9vdHFwT0plNjVOVnl0UU5tUzJkS0JCOTd4?=
 =?utf-8?B?VUVyZUtIMVFWY2VxTnd3UHBPbnB4a3lvaVFpYWVENEozZFhLVW9XVGxST1po?=
 =?utf-8?B?dDlxM3JQdGJ1VXVQV1ZobWpzQWFQc083M2tzSXVza1d3Y2FaR0tsTmRJanhP?=
 =?utf-8?B?U3R0eUpIVnBkcmF0WTNPSVFlZGdTQzJianI0K2FlSi9hTGU5UVhZUHFZN1lB?=
 =?utf-8?B?VHpmYk4vb3Nld20ydjg5ZTlkVytoQ0ExUUtiRnFLOWhpb2dWQ0xsdnRLREFp?=
 =?utf-8?B?V2JRY0FLUkJlMHErd2ZraWFpWnM0dWdxcklZdENha3V5b2FSblhhMExSRG5C?=
 =?utf-8?B?S2dYNG9mNHdxOThYOGN2eXo0SmU5bFZPU3d4NFBZc2UxNG84SWFqZXptNUZy?=
 =?utf-8?B?RVlvbHBpN24vbTVnNUJNSkZvSjNocE15Z0JaemIxbDJScG9CamFFeTNFeVFh?=
 =?utf-8?B?VnAwTzhKQnowSTk4a2Vub2xYRnd6RkZLOTJ6TXNOTUZDZ3pacDhUUUdIdjR4?=
 =?utf-8?B?cXM1a3RzNkZDVStRTTFvOGw0ejFwY1puYzZUUXZ1Qzg5aDh6WEFUWjlwQ0lj?=
 =?utf-8?B?cXBHN0Y4cktMOUhhQUpWMUZuS2FBVExuelM3QzFra3p6ditmdllkYVM3K0gv?=
 =?utf-8?B?emt5bmRnL1Q5K1g4YW5tT1lEQUd1T0IzTUFDUkY0UXpDR1NpOE50SlZIVC9E?=
 =?utf-8?B?cUlWSlR0VVliSVBqb0JGdmR1aHlvOHZGb0ovQ1h0WUEvdG1WcUpZcHFvdEw4?=
 =?utf-8?B?aHRLclh1eEcwam83NVdBeC94Sys0U2xQdkJxa3NrUFkxdGJuMXlOc016R0tk?=
 =?utf-8?B?ZVQ4eUxSUTlKVVFkaDJoejFQcWlmd2FFc2YrQXEzV2VKMEMzVEsxRUphaERN?=
 =?utf-8?B?bU1FdWZxSWtNcG1CdXNvTGlFUDd0a2liMUhCSi9GOTRGb3VHTTVlMHBicFh3?=
 =?utf-8?B?ckVBdGw5R0o4VG51VHdONzhOWTNPRHZlT2RlTklSa0pPdmdpRENqNEkwQ2xT?=
 =?utf-8?B?dFBycEZpbVdiK01FOG1uSG1vNWFDOHhtQU4zNXdXMkg1aGxZVDJSL05Sb0VR?=
 =?utf-8?B?YXJDcGZkNGVNTDhYbU1wbGVreC9BUlRXM2RiaVpYV1dKandSRURidHhBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEJDVnRpYzg4SlJDd1k0dGhwcHh1dzJyNXZoNkxyR010LzVLR3p5U29zYVE0?=
 =?utf-8?B?VGhmQkovQ1FtK083aENIdlgvdmU4bkRyRHpDTGV4ci83aDlnVnhkdU1qTDVn?=
 =?utf-8?B?NnRsWDVXaFMyeEJOdktWUGFJd05naTFBVFpnOU9iRm9rcWcwelNsNW1ZMTVk?=
 =?utf-8?B?TlR0VUdscUh2Vjc3TmtOb1dubmxGVkNjSHE5TzVEYzFkV2J4YnFFY1J0WGNU?=
 =?utf-8?B?L2JydDN1ekRESkJ1ZExKMTVjS3BXM1FUQitqbE9reHJUL3hxY05kS29vUWlB?=
 =?utf-8?B?a2FJS1ljVVJCRzA4U1hVbUJtYTl0di9kZ0pYTm5sczFaV3dCWmdtSkx5aVNY?=
 =?utf-8?B?ekIremxYN2RiUFZZSmlVWkR4d0xZWWUzU1NFSXlrdjdCbDJEckJDWkQ0ZUdh?=
 =?utf-8?B?V3IxL0JPYVJtRHJzZ3Z2dERsY0JlQU0xVVlieDdXSW01cy9neUtJWithKzBn?=
 =?utf-8?B?a3p0aHAvbXBjOUJzODJtdFhsazhGTnBaTkVZVHJyYUJxcEhMZXg5OVVjTTlV?=
 =?utf-8?B?N1hkcncwWW1NZm9QVFVTZEZaVGFLa1FqdENQZ2RUNW5ZU0FpeEV5UmtUV2w3?=
 =?utf-8?B?clh3eEp5MGMrWENQL1ZRbTM1d1RReHd0c1FQOXJuOTBzVU14TittV3FXclUx?=
 =?utf-8?B?amZWbHNwZWh6Ti8vNFFQQ0JTTTdVSmZQTGZBcm5zZm1HTzlVWUpjblVhYUN4?=
 =?utf-8?B?czhYVXdqd3RQUDU1WVVOaGdpSzJmSnFtcllwNWhrMDZlcU0rMElaUUNNWDJT?=
 =?utf-8?B?eUtlTDBCQUk3UlBycjBZV2RSQ2UvR0h6eGxGRXZlNHQyWDV0d1FZYVAxK3lJ?=
 =?utf-8?B?ci9ObW9hZHpSeGp4cWY5b0JRRVRmVDI3L1MvdUpXd0xBcnRlWVRNLytRQWEx?=
 =?utf-8?B?YmZTR29rK0p4bW9vQ0tRUW15Qk01ellJbkh6M3hPM2dwSlQzenAxTExVN1N0?=
 =?utf-8?B?bXlOZmVNaVVMbWhOQTdtYmkvbTlsQW1RZWtxa3JNNWxyZmRBekxQcUwweUp3?=
 =?utf-8?B?Z0NobUNZQk1QS3pEMytlM2ZmREJLaytYVVh4QnNUNVQwb2k2MUhkQm9zYm1n?=
 =?utf-8?B?Qm55VWVqOXNvWlNSTEtSYlg0bU03M2lKNGJyUzFhV3VkWk9BYmJYMXJEMlh4?=
 =?utf-8?B?V2MrS2p5ODlYb2pxa1MvOGFLZXUrMVBKR3VhKzVDRkZUdnlsQXZYZVZJYklL?=
 =?utf-8?B?MTN5Y1VXTWYwSTRsMktqTEp0aGEyOTBqdEJxTjFqaVVXS0pvTzhjKzFQSktN?=
 =?utf-8?B?dXVhREVQUWIzSmFJT0swT3JrKzFWYlBpV3I3OUZBbHdhbitrK01BeVN0dGRi?=
 =?utf-8?B?UW4vNlR6YmFHY0FDUzcyNm1ET2dReVVCZDVSQTBjcHdPUmptYWVqcVB0VTh1?=
 =?utf-8?B?WDN2TWpTQXhNQ096Y1NDWlNYTzNOc1JHM3hvRlFDVi9aWmwwSWlidWtOREJJ?=
 =?utf-8?B?dG1QTFV4bWJYa04vb05qNUtpRWIvQnpsQ1hmR0lBWmwzZjdUcjFXR0JZaEpN?=
 =?utf-8?B?Nllja0tXTWVlL3JkTUlVei9Xc1dWRXVLSVViOGNUeCtMeTZGbVIvbEVIQnhu?=
 =?utf-8?B?MlJ5NTZuUkpZeXBIZmJuRzZGTGRYU04xR3lyTUs2c0pnUllpenBUZUZRZjlR?=
 =?utf-8?B?N2xJMDEvZ0tSNExGbHNYdlV2Mk9Xbmp0ckZzLzN2bUQ3djVkV0dOQ3RzUzBv?=
 =?utf-8?B?R09yOXJYUWIwVHBVamRQb1BsdHF1cTlJODhsVGJBSHU3MXlkajA2d0N1VWJB?=
 =?utf-8?B?d0NSZUJGWU0zNmw3cVVnalAvSkpheis4b1J6TUlFOXZVVkU0cjZWVnlaQW9W?=
 =?utf-8?B?Rlc4cCsyTDBuVWxwU2t6VmVoTFFRdGVXQ2VaWkk2bVp1NER0aWpFRmFFRzRS?=
 =?utf-8?B?QXlJOUlmV0s4azUyOVZkTWR3VHZmZk4zUnQ4eTJra3Z4ZGgybUVFbFc5NHR3?=
 =?utf-8?B?Ym5EMFJKQjVaREVrQVdXQlZSTjQvUXZYWTV3MW1kbzJqZkt1UExmTjh2TzQw?=
 =?utf-8?B?WVhFVzBnUUhRQ0JmTnlBNFY0YXMwRVllcHJsTmpmeGgxcks4VzBCL21ZcHQ4?=
 =?utf-8?B?NURHeitMUzNOZythOWZSeGdxM0hsaEduMkxEZmZTS3pSdklCMGgyTXVqdjhB?=
 =?utf-8?Q?elDCjj5AOx7P2gVvI+hKpn+Gd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd751a1-70c2-487b-f8af-08dc813a509a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:24:24.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4mHxNFrpl1LtzPGsFaeWQUGq3QMponHvjY39YMXunHsN+TxiCHywfB8y94oKs1/3QalO55OGuSNDxnumpexdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3573
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 May 2024 06:24:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16074

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes real and virtual keyboard availability on x86 with the merged
config.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 6839e1a9..dcb1b90f 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "5a81b70b8a158d44991da73cf01f310bcd2bff72"
+SRCREV_cip-kernel-config ?= "93b9ba271c14556a24b3f8392d10a8647b496f1f"
-- 
2.43.0

