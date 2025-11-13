Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49612CD5BBB
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:22:07 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20570.1763029326629330459
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:22:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C8VaPan0;
 spf=pass (domain: siemens.com, ip: 52.101.84.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbZbUTxMX0vxC9gPc+eKmEIsS0NllgKlTk5jggJjTh3rRzpvfZzekZrXiRiWXgGVOqG2Mj00ES4JZiPAzaw9hFqfZfAsQ0wWREG04mOJxE4cDaPFp415czuWB9cMP8S/nGm9f5BQXfKUC0dC9WXaZ+SqOtAKEP16gZmNbcCROD9yYbPcjxxwNDB21YGcU0VzImzsuQb6VACwhFGmAw8Sa/NT1UrBv05pUXc2ej0FhQBtLD7gbcLo6lWU3s8GLyPpf4Gs6URuh8CPVFcfR+ztNMXdy+si+nOzubfBsAo99n0FZgAOxxonU9Pfe4PcxsitoZSCwJNVJK2cqnLOsF6NiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKw0pyXlCJQ2wUrqoFUal9n7CFsSiIhsDCRJjrFyLkc=;
 b=djd4xYDXwR1+La0kfjvguW+94xVazsElOZ8DxtuKHCh0tQ7xTXubxA+dCsSF2bgNLm45z9cWdzwDYK8bBDfGrazWxcTpCNmuXBtkxQUB/veqiZm8jkTImxPrT48A1dBArNXsDHT49T+5z3NwLoEqbeVMFFGe5LJ3kSTM+VWxpv4hhA1G/cBfwXIPKkDPUEcxW5EwFNWr4cwaG7idTBzXjlz0oQ72Tub774aLSVe8CvDqZlAVHa4RkmAdBLgkoUeX6N4w0RARuRok49e20jNAb6sq2NC88LU2CqEpkXox2w7RDXlj+qaNtvDZRXjzd/CRxQD4USJMMMowktE8kov5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKw0pyXlCJQ2wUrqoFUal9n7CFsSiIhsDCRJjrFyLkc=;
 b=C8VaPan0Wsi/QsWnmIJyiyJkjqlK+t4G1GWyX6yEUUmGezaqSGJjnp6Kv7pv02Va6zi1gJ3iwPX61vo8xErzj1D1nRHo+gqBpYHvvQZlaP9UAWm07k7TZTXVmNQMAyBqdekS6XKehCUw4iPoqLZcATerpYiFV9vSzhhwL5mXcO6uzyEiGxqo+9gKKOkAIm/eHCkOnSI9I82cjDRnzR6phIb4mXOoIpkmb9Ckwn2rcDYMmDD1eywNpPGpSpzGGtwn+zD0Dis1GWuM7slzMkkE1iI3Xtr1QGO0o/I0OqsCfE0d2LssJCrvUaf3v4mE4FhnCsRSSvd542oTNAemceSf1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:22:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:22:00 +0000
Message-ID: <583f61d7-fa94-45eb-a3da-5c1958b87032@siemens.com>
Date: Thu, 13 Nov 2025 11:21:56 +0100
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 2/2] initramfs-overlay-hook: Address shellcheck
 findings
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <a7504bc2-d148-4275-997f-e94d2cf88cf6@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a7504bc2-d148-4275-997f-e94d2cf88cf6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: fef6485e-8b2f-4905-db95-08de229e7b81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHZERk9sYU5QRm9INE1qY1dHL09Yb0czWTVjdG0wRGF4MkhlbVJNRDA4TUpQ?=
 =?utf-8?B?and1UGVEVVUrNDI2WWxCeGIwLyszN3lxQXZhZDkyQVZKRjByeU1NdWpDeUpj?=
 =?utf-8?B?OE50dTVtckZDNEVBcGdkNlYvSkRTaUtkSkNIOUtmRWJ4ajRSbDY0eHFJUEJk?=
 =?utf-8?B?NmhsZ0ZSeWllK0FNbUU0Q00zb1pLM2N4M2pFU3NzU0haM3BUZmNlWWFESWJT?=
 =?utf-8?B?Z0FicWc5RTJqUG10QlpIbGljRmdpUVB5SHV0di9ORG1OVUNaMmdJZFBjR2R6?=
 =?utf-8?B?djBUUTNTVXVxOWdKeEVwcGlhSVhlbmNzTGRWalpmejkzd21vdnJscHBzRnZv?=
 =?utf-8?B?MDVRTzhrbUdpa3R0Y3MyejdFaUkzNUdkb1JxNHpRMWVmRE45cWxTTGNBek5N?=
 =?utf-8?B?Zys1bXpYeGUxRTFJbE9jOUNIdXBVbGdTWXczbXJSVXUvemxsSGRma0o5aE9Q?=
 =?utf-8?B?Tzdoem9aZno4dis3aWthaGtWVFpkUGk2N0ovU2puTGdCNGtlQ0FRbnU5SGd6?=
 =?utf-8?B?QVluME1qUExCUzVTNHpld3ZPTHlHR1dYKzkxWE10V0RHRVB2TVVnTkRIUXY3?=
 =?utf-8?B?cVEydS94OEh2UVU3akVweFZHUElTTEQ5WVBCNG1RVllLbFVQUlJDV1NHRlox?=
 =?utf-8?B?YzVnT0xCSngrdjBWQTViT0tXWWQ5eHhOek1weGhCSWh5d0hYd2xETzg1ekkr?=
 =?utf-8?B?ekVzaGlXdlRhWkNWMGNWNE9zUk1QeHltVnVSS0NuOE0reEx2dm9FUjZsMGl4?=
 =?utf-8?B?Mnp1UkI5ZG9KTlVrN0M1cEhudmtMeW52T0pJUk5FY3NnWlZpeWFzZW9NZnRl?=
 =?utf-8?B?WnFTMTM1OTYvbXd1aG1YOGFFSmNRRXpuTFBZUmlrckMrM1B6K3RBYTVLOExE?=
 =?utf-8?B?Uk1pamk5cnF1dWo2L0ZKc2s1b1BjWWk2VS80Tk42TVJjN0Q2US8zbll1YmM1?=
 =?utf-8?B?V3hQUFRKVzhGVktNTUxjNDNMZk5CblhtUUFFRkdwM1dKd1g4VEp6NXpFbVY2?=
 =?utf-8?B?aG1hMW91Z3dQY1AxcU9Qd0c3VE5HMmordnIva1YwcCs2OEdlK0FYaVZIRFFp?=
 =?utf-8?B?VTU5dU9jVGpteVkvbTRhOWUrQmczTlJrQjFqMkxkY2pleDd6R3VjVHkxTzI3?=
 =?utf-8?B?NVhYalNOVzhUSXhUUk9xQ1dnWFRxaW1mNG5ialQvN25YVFVnVWRrck1QWmNW?=
 =?utf-8?B?eGh2STlqNnVocFF4ankxMEhLMjJxWWx4cVA3UGVVcG9XNFRWNHkvVytUMGlT?=
 =?utf-8?B?NjM1b2xJaEhlSzZXMVlOM0lpVnZvNGtrSCs1L00zV05qNlFKY0dXemtmNXhW?=
 =?utf-8?B?THg5SzdabnVKVmRJRHh4MjNucWVUY2dCb1FPOGd3c1BTa080R0tnV2hJdklC?=
 =?utf-8?B?UGtPZDZ4R2lZekdpTi9jZGdLUVQzYWtva3JNK1ExUHVFQVUzaG0vdGppUFQ3?=
 =?utf-8?B?NFpiVjRweUc4THUzTFpMQURORTFQNDNHYmJRY0NwZXJHTjRTcm15UkkwODNQ?=
 =?utf-8?B?c2FPcU9HMXdpeTVTbjBWdElZdFl2Ly9VOXF0VW1IQS9meGdjeTJ0UHEzcXNy?=
 =?utf-8?B?SEEvR2U1RkFrUldzbEhwZWJFSkpOUU53MHJwSFNjM1VYWTN5cUFqL0ROUGow?=
 =?utf-8?B?RHI2UDJrZFphbDZPY1V5Z0hOTnRQTVhtTWFuTDQ5dDRqY3ZXTHhNYlVlQmVQ?=
 =?utf-8?B?YWhmeHoramoxQlNRQjhWN2JtRTd1UmN5THNCK0E2MDdLeGJhVS9KZ1V0TitC?=
 =?utf-8?B?QWZUenZSS1ErNWgvYjRNdUs1UVgxV09ZWnFselJSMkZISjh2ZVVxNkplZWp1?=
 =?utf-8?B?Slo4TW5GZW9kcnRRKytnRUwrNG9QMlVFYVBrWFo0WE1GV3JtOFlGNE9BU3Rm?=
 =?utf-8?B?L25uVlc3THVQNGc3b0p2eGtjNmM4RnBRNk1SOUdzVFdTcCtVSktJMzNaWS9H?=
 =?utf-8?Q?mJMXKZajDN1KyJc51kVmXmMjRuRsCm7K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlo5RnZ4ekNXRklFNko0bDRZNFJaRWJ3cEVMc0pqQmtzTTJFcEd6elIrQW5F?=
 =?utf-8?B?YSsyZzJJWGlGV1hKL0RqSnQ1L2xhemMyaGRXa3hIUEx1TmQwZDZsNVdEcXp1?=
 =?utf-8?B?WGtnSS9TMUJoQkQ5MVc2RlZDOHY0VkdsL2VjZXgzUHBuQlU3Q0s0Z28zcVVP?=
 =?utf-8?B?cTZ1SUM0YndHTWZqc0NPb3JPekZaYjQrbDM1dWxiajBRZGhQb3ExQWVKVXpo?=
 =?utf-8?B?T1JOekZNTGZSSWNjMUluWWZsL2hpbE1nKzdIall5ZWxET3pyaWw0a3RiSW1i?=
 =?utf-8?B?bTA1LzRyRC96bkVIbzhjbVZKeHhwRWEyM2N2bXRlSkdZTHJOZVMwQTI4dnFU?=
 =?utf-8?B?L2sxb2JZZVJSVzVEdm1ic0lISUY3QmpIa2p1cVpuSUlPdHdyZ0JqTDB6dngz?=
 =?utf-8?B?a2pGOFMxR21FZ2JWYXBXcjJTMFhvRG1NQjgydWNKY2xRc0Z1Q3R2dFdJTXlG?=
 =?utf-8?B?VUc1cDB0Q2g0RTJvZWdaVDB1ZXQzcDcxY2VPYzc1R0lac3VYaktZbDRFdW5E?=
 =?utf-8?B?alluQzZNM3hHWWxlaE1HNVZJTS9iQjZKRzJ2WXhON2d4bE04UXk2ci9UUU5q?=
 =?utf-8?B?SXUvOEVjV1ZDcE4vNnZ0TVFMaUo0QnR4M2FYd0xBMGtGc1VPOEhXbDl4Witz?=
 =?utf-8?B?WU50dGdWSklTNWRXMi9TTktIdXhXZi9IcUw3YlBUa1RtdFlBNHl0cHpqRzdH?=
 =?utf-8?B?MGJDaTl2cnpRQi9CMmpkd3ZmeS9iby8rajVma0c3a21NYnE5RzNVenR4amxi?=
 =?utf-8?B?ekpvcnFkalYvQ0U1Z01md3RTZVN2RDRxRWVQYThoR0gwQVV4bHhSNzVMQXd5?=
 =?utf-8?B?WjZxVjFtUVI0endVbmVMYzZ0RHRPTUdZeU5QOG45NVM4U2pUVnFGMzBUNWxp?=
 =?utf-8?B?eUpaQWFYSDA1aHVha1lXYWM1N0FOM1MzdzVyYmdiWEk5alhmQUlKSm5hbjdw?=
 =?utf-8?B?emhEM3lqcGlNMlFObC9DaWRzSlVnaUY2cVp5dGY2TCtCWUtSN09SWjkvbkk5?=
 =?utf-8?B?Z2l0V3ZmbkJwanF6MVY0dW5FVksvSWFiT1lwWUpUd1I0RlpzeHExY2NCYkRi?=
 =?utf-8?B?RWdJVld6L3dxSGtselJJaUwwY0tBTjE2cjNvbVFyYkVjSUNWa01jMDFjNm5Q?=
 =?utf-8?B?ZmxTcUVFZVcxZHl5ZUtRWEU5NE1BQWtveGhLSlU3ZnFNTmZ2QlFpeXFmV0lV?=
 =?utf-8?B?Z1hldFFFSkt5VzVJVlRZZ3RaRXQ4Q3NlaHJiVXRhOGdLMG9VV2hlSTQ1d1Jj?=
 =?utf-8?B?TGdEeVRIY0s5RlpHcCtPdWpqZ0UyY0EvMFdNMjlkZ1pjQWo1NThtRHdOeUda?=
 =?utf-8?B?dEVPZlZzMEZLQXZtUDd2NXNTeDlob1FRajNydUR3cDVCaGM0dG80Ymx3dVNn?=
 =?utf-8?B?NVluZnByZHJqSGhCTnZlMUdMQVNBSGhoMnhtU2ZxZFh3K0t2cWxJZUIzOCtZ?=
 =?utf-8?B?VmZLR25hTDJFNmJDbTJBaGJqRkJTbUMzVnc4ZEwwbzJsM1BQVVNldU5kQjZP?=
 =?utf-8?B?NXFMdmpNN2NOemVKdVRmSml4YW55ZUg4bmlSNnNmZXpRRG5lZ3BZQnBybEFC?=
 =?utf-8?B?TDFEaVdCaTFFbkprVmRYKzNOTzdua0NSeTBhUmZsczlNZ1lPL1pJQjZTT3lE?=
 =?utf-8?B?KzhhYS8xaVlpV2JZQks3cm1aY1V6YytUTkRydiszaUV6ckkvY1ozaEdJTVFP?=
 =?utf-8?B?TDFDdHpGSWNBNStpK0FxUy9keWNEbmZlTDlvQnNwZmloeVkyTmQ0TzRuMldt?=
 =?utf-8?B?ZlJadGFncVpBSlBxRHZTaUNSZGphc3JsVkZWaTB4c0svOC9sTzJnUnIralBz?=
 =?utf-8?B?VlZGRFhMTWkrdnFzVnp4QncveVM2d1dTRmtlM0JLeUhxZGVZZ3dNTkFobDN2?=
 =?utf-8?B?bEZuNTRyalJwU2xrQkg1ZU5MWUFUYVA4Z1YzKzVuSTJxQ3J6TG4vNVhhWnF1?=
 =?utf-8?B?K3dzOTdrcWcvZ1krbWNxYVI3SmNTZmtNdXJwZ290djVRZ1RXZkFNRkVWczYw?=
 =?utf-8?B?SFFLcTZXNVZ0dnRGejBRNngvOU1qekI4L3o5V1krMS9BT2paUmFGb2ZySmRy?=
 =?utf-8?B?aWpMQUpZS2NXWlRqVVBMcW53a1V5S1hIR2xQQWVkWUZBMUU1eldHRFJYaEw1?=
 =?utf-8?B?RUFpaFFRRFdJaFJ5T056OWJKM0Z5NnF3aDRkZW91bkVoK1ZEdWQzMEtIQ0Qy?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef6485e-8b2f-4905-db95-08de229e7b81
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:22:00.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S88k+fJAaOsKS2f4U4BH55+zTngC1D242XFLYGnMWzx/2P0bazEiwHSkYH4RCdgfQvKFWpgC5bAV93M5DAuPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7309
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20530

From: Jan Kiszka <jan.kiszka@siemens.com>

Just quoting warnings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/local-bottom.tmpl                    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index e296b142..bce588c2 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -33,10 +33,10 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 		fi
 		;;
 	esac
-	if ! mount -t ${partition_fstype} \
-		 -o ${ovl_mount_option} \
-		 ${ovl_partition_device} \
-		 ${rootmnt}${storage_mount_point}; then
+	if ! mount -t "${partition_fstype}" \
+		 -o "${ovl_mount_option}" \
+		 "${ovl_partition_device}" \
+		 "${rootmnt}${storage_mount_point}"; then
 		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
 	fi
 fi
@@ -44,19 +44,19 @@ fi
 for ovl_lower_dir in ${ovl_lower_dirs}; do
 	# remove the first '/' and replace all '/' with '_'
 	# on variable $ovl_lower_dir
-	work_dir_name=$(awk -v var=$ovl_lower_dir \
+	work_dir_name=$(awk -v var="$ovl_lower_dir" \
 		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
 
 	lower_dir=${rootmnt}${ovl_lower_dir}
 	upper_dir=${root_mount_storage}${ovl_lower_dir}
 	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
 
-	mkdir -p ${upper_dir}
-	mkdir -p ${work_dir}
+	mkdir -p "${upper_dir}"
+	mkdir -p "${work_dir}"
 
 	if ! mount -t overlay \
-		   -o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
-		   overlay ${lower_dir}; then
+		   -o lowerdir="${lower_dir}",upperdir="${upper_dir}",workdir="${work_dir}" \
+		   overlay "${lower_dir}"; then
 		panic "Can't mount overlay for '$ovl_lower_dir' !"
 	fi
 done
-- 
2.51.0

