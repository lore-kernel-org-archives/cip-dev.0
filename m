Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F2CCF9F0
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 14:44:47 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.34])
 by mx.groups.io with SMTP id smtpd.web10.26347.1761835481993928074
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 07:44:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BywwboYn;
 spf=pass (domain: siemens.com, ip: 52.101.83.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2VCDOB+NqH2zfU6xhvwiP0If3M9J54qglm0ZkTdFxqg4DGsic7+1tdaIK6ZKSWsN5cKDfDrDs7KuOI3I5xwv6MwOF78pW7IybVTk4k599aXlpg/SlJ1FNtbddq40DdXjolxH62g/ebesa0F4OX73Yavc4bVlyK4HmeCIg17mBDJ8mahG+Fcm1KqcAokGJXQSyJsUwZw+qsluI6SEkFQT4PofYUcbC9IQQ4DYIu3OgEiSZvuv054PIg/YafvVARzhAhCntG8VoXVTwZmxa2U4uCNt3FptBQxqXZCtPyf+eKCmGcCTJhaL0tD/oqAjBxs0m+QJAvOCgA25Nz0AXoihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76WegX6c/vCl28BdSzBFxsrqC0vgcB0zRkpT0rTm7Ck=;
 b=rwuz7OKqi6yPnDJfWXiSyVP8t6s2oU9RR4SLNlEjsLdMSvuFhb5uGVY86f6rkWIWv5/7gbTzy1yTDp7hucFEKnJXpE481xNA9ziZFXmVappNxqAHuIUtlDYBXRuxF+AvxxzJjOBgkSUeRmvZ1nvVqtOksWVYLJbsrZUqJGLStROh0fbQF052xMWKbKzRonBEHSeTjzbz7l4+4DQHAQfSRFG90UkEq+2E9YYh7Dw+a6FGpcUxpL4zkglQtGl43t7z1VU8xk0+1Lz3B7zgerkWQFaG1sPb72sPg6zJHo3sHvSuk9w6OSussGVtjlnxmJ5UK5czfs5hlnOgFdvpXj3qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76WegX6c/vCl28BdSzBFxsrqC0vgcB0zRkpT0rTm7Ck=;
 b=BywwboYnJ831YSySXQw1ZNfZoUXtofyoK/ejPiETKEw/E7aBCyWp5yN/EEJI6chU85OUXceGXSuJYY9jcvrhPxChRMOcdEKy65/GmItMOAiIgnFg5LG+YBbLIDlDutIiaq4KirFkKGXUwm0I6Qdll1y6PIbkZWZXCI3Duf5QF+DR8J5/wUnCybJfxH589EByET1ZYk3UHDbfCqzsdOajhvKvrvC+l74pvpmdC1brH9HGzVocUvp0JhC/lADaf0gdovBWRVhYo2HVVxnq1YDzdBZn77rkpgzA4V+4izRkiEJyY5OHGNG1NRAzuU+E/ZMWv4Xcr5sw0pP8qnEhVIWv4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:368::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:44:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:44:37 +0000
Message-ID: <29504aa3-3725-4d6a-b674-ac05f88e4b24@siemens.com>
Date: Thu, 30 Oct 2025 15:44:33 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config revision
Content-Language: en-US
Cc: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:52::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 28baccd3-549c-45ef-d198-08de17c2d935
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWRJNWJPdUN6MVlsTzZ1dVUwVFhVWkg1YzhmTUpzRWpldDc4bEVmSUN1eVFK?=
 =?utf-8?B?NmFrQ21BdVE2QXNpS1R0NkJyUVIzWXZkMVJyeDZUSHM4OEk1MmhHTGRlc3dn?=
 =?utf-8?B?MnJlVW9INVd6cTUyd1JsRVkxaU5hem1hZXkxZHJyY0ZFRDlOd0FKV1hDeHd4?=
 =?utf-8?B?MmF6dWRib2FCazN2RjR5RWdLRHNMUDdWRzlVQnJvbEJXdEJYZ2dIMWFEMmtl?=
 =?utf-8?B?MkhyelZLaVZ1Z3QxRjdBbkc2QytHRlFrNHg1SUdpMzNjRmg5UGlDUzRoMVNC?=
 =?utf-8?B?eDdjZ0hLb0RMaThLSHFXV0Npc1dPd1VYaGFJMnVwUmQ3d1lzTG9JYlFxYXNx?=
 =?utf-8?B?UitoWGhGaVNBbjNTMGtzN20rdW5uU0V5TFkzTDFIeUpFRU4xamNBT25jdHFZ?=
 =?utf-8?B?TEJoOUlxT3lBZENiK0EzOCsvZnA2T0hxQk8yRGhDSDl4ZHZQcFdsV1VsRUw2?=
 =?utf-8?B?MzVmZWp6Mnc3cWtpUW5Vbzgra1NDSU8waDBWbWpPUTV1QWV3dkxROFlRMmxU?=
 =?utf-8?B?eFA4TGswMWFWUWlCSTJnV3RMS0RjdXhIMmFZVE96V2FFZk9CZGJqR0xrZ1lJ?=
 =?utf-8?B?bVllZXFjM3A2WUFxWUNmZ3l4ZkZoQ1RVSDFxazQ1T1FMQkN0ZHUyeE9NaU9P?=
 =?utf-8?B?K1RXTFNWbjdNZUpJb0lueHA4Q05ZT01kQzJKUkMwOWs1ejNkUVVUUXhQRGZm?=
 =?utf-8?B?VVRlRjlWRzhyWXkzR050RzJsM21LbTlmQko2aWFTVVREcDdYMmJMQlpnSUlZ?=
 =?utf-8?B?N1YwMWY3MTZ5Zit2R1VPNWdsZkg2YmpGRkdBcEZGQzVxeHE5SGRTSVI2NzZy?=
 =?utf-8?B?dDJWd2dNS1hXZ2l6dFhMd2lPNGxlV3FJMG83a044T3M1ZGV1Zm5UdThUZDdY?=
 =?utf-8?B?R2hpalUyZzMyeEpSMVZSTE9FK1VoTFFzNkZaekFSUllobHJtYlZMK2NoTDBx?=
 =?utf-8?B?eWNSSDcxeGJNYXJLMXQwTmoxQzZOMkJCNS9Ma2FPeit4VHU0a3NkM3hTZkpS?=
 =?utf-8?B?S1ovQm5HdWpXaEVXVlF0NTR6d2NmMzEvY1I4UzhKc3Z3REdTM1dURXB6UW1M?=
 =?utf-8?B?V1BiYmdxV2Q4VW5Calc2MWJUdzB2UjVEdFlJaXFOL29iYkhIMFRvcS91cHNP?=
 =?utf-8?B?NkF4V3dmTENndHZpMTF1OGdyaWpwL3k2NHZFVWlSd3dUK1lKWUFvcmx2YTlB?=
 =?utf-8?B?Mm1iRVhVNTZ3UjJwcW1sejFDY3h2WlBSQ1htU3BkcGw4MVVwb1FQNk9HRHdW?=
 =?utf-8?B?dzhrUnc0blhibGJOSnp1dEVoUDVmWnIrQk13SGxvSE5GemthMnUrM1BETENS?=
 =?utf-8?B?YVUzeVBzY2txRml4RUYzNlUwS1p1VlJUaTdZZE10VEthL0NuSjhqNWd2MVlq?=
 =?utf-8?B?ampldlBnVWJJYld6eFJVOTZpYXByRm44dUx0MkU0cUF3dHJTNC9xdmRLZEE5?=
 =?utf-8?B?cm4rUDlqREV1NUtXSzJpenpUV0pIcUlxZm12OWZjNjBoS1ZUZ1RxNjNCYUtZ?=
 =?utf-8?B?TFNyZWc4ODJlTDZ4YjNINXNpYVNUM29aUVN5R1FUWjQzUUpNVlV5T2dzVTVz?=
 =?utf-8?B?OEVtdFhhQWQzWTVwZGRiTk9YYWF6bEF5UXVueWpKMzFUMnhDU2pyOUVTLzVU?=
 =?utf-8?B?Ky82MFpDTzFXdjhoWUZpekxSV0xhaEIrSk1DOWpHSWNNelRNcGdHOWJQN3dn?=
 =?utf-8?B?VENTQWFiNUNVcitlL3hEVXVyYXRjcitSZC9tb0tseEVWeWxmQ01oWW9nZkQ5?=
 =?utf-8?B?VHZ4MVNEdjdGYjQ5UjJYV0lFald6ZEE0Nk1JeUx1NlY5MHNiTHFzT1NLNE9O?=
 =?utf-8?B?TEpDaitkZ0VQSHZNNXc3NUttTEdDUEpuVGFtb3h0RHJPenlORXYzNlJJQ3dx?=
 =?utf-8?B?d20vaFFyR1Q5eEtIVVR0WnZ4U3dlT29TZG9QRVhkRG1IUHJFK3pvZWFHK0F1?=
 =?utf-8?B?T0JabWY2OUNKRG5ma3d5T0oxRVhVQVVWQ0E4NDYzTEg4RU5KTXR6dGVuTUdI?=
 =?utf-8?B?aWF5bzJjeUl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFVKdXBqNGs1OE5QMlMzd0kvTFRkRHozOHRJcGdwZE5FNXdOZjVOMkhHVldh?=
 =?utf-8?B?KzRPdko5bEluZjdnenB5ei9oR2NRYlJ1ZWNJcDQvenhXMmZKRDgzUC9iTzU3?=
 =?utf-8?B?VTlxWkQxYmY1aVFpOHV2ZExXNHl3aWd5WU0wZ0pSeUNlU0Nrd3JaS2hRbm1h?=
 =?utf-8?B?T2E4QTR6d3hSVHlCcmxqdGFIYTJQSUVZTlpSYTc0d0hpcE5nVTNVTjhVa3cx?=
 =?utf-8?B?L1ljSStaTXA5L21VdWFsOGF2cFNHa2ZUSWpBdUk4d0NxU3RxdDJWbnpCTWRm?=
 =?utf-8?B?ZTdmb1JQK1ZjbEVJdmRQb2tRWGhUcXhycUE3dlVRUmZWZ1c0K21tRTgyRGpV?=
 =?utf-8?B?dDdGSFo4UWVlblV4dTFnUnlnZTlTNnc2VlEvcGxLSXo5WWVLZjVIVmF2Vktv?=
 =?utf-8?B?SGpKYk1LYTlSalhMSllBY0tPL0FuZDAwN3NoWmpBK2hBa0ZTVmYvZmZjSC9H?=
 =?utf-8?B?S0J3cSs0WHViODZVUFJCbU9pZDlmdHFRbXovSU9UWlZHYkNPMzc5QzNEMEJK?=
 =?utf-8?B?L0ZyMVBWcHBRTCtmT1N1RkFDd3k1VjlZOTk5eXY1N1M1TFo5ZEk2YzBxcUQw?=
 =?utf-8?B?alhUZHJwRi9YRU5oZkZSaUJlOUxDWGZVbEk4OTZ6OUtnQ1R3TjdvWTIxcXFX?=
 =?utf-8?B?V05DMFoyRmlLQ3VIWFJFTll1SkIwM0ZDckZ0YWg0TFpBRTh5V3RHSzI4Y3NI?=
 =?utf-8?B?UXFUV1g0MWNoRTI1Yms2RmQzVTRacFNMNUNKK09tT3ErZHYxazR0UktMei9V?=
 =?utf-8?B?ODBLcDl2cXVuWld4dGNKZ1Fkd2xGcGlIZlhEenVtZktMODN1MDdZN20vS2hE?=
 =?utf-8?B?Q0NXNHY5akNVcndEaFpnRGZNMXBENUhWb09Wdi9TYUpGQXNLcGRrc29PK0F3?=
 =?utf-8?B?TnZQWU12VHp2Mjh3bCtabGc0Unh3VmxWcTdKLzd4NUxGYndveVhreFhpN3hn?=
 =?utf-8?B?bnRwaTlNOGVtR2ZZb1ovUWpyVE5uSXlZd1Y2OVlMMk1ZakZQTEE3cFlYQkU1?=
 =?utf-8?B?bzFaUzBxN3lwT1dTTDVIY2RheUFVUlpzUXphVmJFeTJsMERnTDlUMlRjYjNH?=
 =?utf-8?B?QXJPejljZjhKMysrMnNRQVd0UmxmdmE0bTY3MlFNT1RQdTVMMnl3Zzh4ajA1?=
 =?utf-8?B?Z0dxZlNweGtjQjkxbi91eXhDK2d3SUlYTG1lVmNpcXBqM1YzOWN5N1J5Mkxp?=
 =?utf-8?B?SjFuK1hUUStjdHJlWWxVOXlOUzhTdGNJak1YejNYS0VpN0VGc1lHd0xjQVRv?=
 =?utf-8?B?cVl1WVN6WXdXSTI2SGlNN0Rya3dQNHlzUGNjaHpiMisxVVFPZHcyZDY2bWMz?=
 =?utf-8?B?STdVemh0MUtFTmNBMll4THRaaUxoM2tYNG15OHJSVzRlZ2JjOHFoKzlIWFV2?=
 =?utf-8?B?dWF5SkdzUTZBSHQyYTkvOTUwNzgwMEVoWDV6YkhXVnhjdHJDd2gwWjZFVXJY?=
 =?utf-8?B?QndLbm81VUJoMTFsVTR1SmNyRm1mbGNxVFE3U3lsODVmYmkrVERIN1RHUWlj?=
 =?utf-8?B?UDlKc3hjcmFOZ2JEUWxRbHI0dEJNZ2o5bVdSR0lSeXpLQVBuNHNVYnlGdHhq?=
 =?utf-8?B?Rmc4dDl0dlpVYWQzY0doOXpQczZnUHRya0lPeURHYlRpRlorYUgycVB5QlBD?=
 =?utf-8?B?L2tOYWRKK1JySGZadlR1Q0ZmRzA3bloxOFpYSUc5S2xKWmcwbVJWU2tKQnY0?=
 =?utf-8?B?SHpqenUrNXFJeE90Q1B2RnVHYXBJTFN1dWtzdmZuZmY4eEtVMnZjaHdrRVFl?=
 =?utf-8?B?Qm9TM01pYTZZdThHNUZUYk01WHBTTStYUzdVbU1SWDJzc253eFVWTk1jZk10?=
 =?utf-8?B?Unk0NHRxb250Y1g4aFlYZXZoREhhT3dZbDZYeTZiOUlhVnFIRG9ub0lZempN?=
 =?utf-8?B?dHZFT1hGL29CYVI4QjVYNVdST1M2R2kwcGdPQjZqZllZU0xxMHQ5TG5pTXlP?=
 =?utf-8?B?RHhUOTk4b2YwSGVvRmtrTXlKb3g5RUdMcFRrbVRrQytUWlNoTEpEajRIdDV0?=
 =?utf-8?B?SGdLMzBjNkJXSjgrRW5qc1FLOU0rM1lnbElZcVBjN2IvejNkdUlDREVKMVlk?=
 =?utf-8?B?RFlvRzZnRVVHZm92TmpJVmNTbTlWNHZqRUV0UG9qRDNGNmlSU2M4NFY5N2pX?=
 =?utf-8?B?djR6N3lsdHNxb2wrUjRNVEpwRkR0K1pKZ2JtLzJVbDNWRzV5Y0kyQXB3Rytz?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28baccd3-549c-45ef-d198-08de17c2d935
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:44:37.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VehgR4egQV3G1NfiVv9/xCZj54PuA4ZKyICKTPafAv8CAdKitzZZu+31Gk3nciAad76xtjv5AeLPu/6WGLCbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7846
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 14:44:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20286

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings the required config options for fTPM and StMM for QEMU ARM64 and
the upcoming TI AM62x. Plus, this fixes a lot of issues during config
merges, among them too small MAX_CPUS for the M-COM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Obsoletes https://lore.kernel.org/cip-dev/261b53e7287ff226006bf2a30d519beb95d71ea3.1761549708.git.jan.kiszka@siemens.com/.

 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 7ffeb195..679cfa5e 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "60f3454fe50a2faead9fe5f156ed1f89bd0cd99d"
+SRCREV_cip-kernel-config ?= "ba0204aa6c1c5a41dcb4fa1087b5ef5dd3ebf81f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0

