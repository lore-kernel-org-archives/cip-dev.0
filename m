Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E2D74968
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 08:44:47 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13080.1766133883417226985
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 00:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DvxAaItQ;
 spf=pass (domain: siemens.com, ip: 40.107.162.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTCmYJA4kRB2xR6+vIXTG4QocQ/XETerxbryv+i1sFuMz401qUByuh0rs4+DyZNdTBZ6YmpkUVZbq3sXl7XsiSrWam+bFvHqJqNXisIU0b7mJ5Xup/AOrfAtL2/przmOyeG++AmUuq52kKFRRdYrjEAVVlQZ3a+tLolJq3ZY4TGkaVP3WNoGvsL4v30UwR34kixytZKIzG12/sjb+KaqhpMtKDtcElcXBWH8teOQPe8l2T6dJDSKsDJdqqj9plwKq/dgco3aSvlN+l6MZF04meA5p8xqyQZsRNS8obhMJ84XXlRQr3upMTd9sKJJQZ54q6sgl7vjG8r8YWcZyxFOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnj7PKoA9DHE7JLHb0vja5xXAAdMJebCq42e1qF8xGA=;
 b=X5QHngjMETPqFxryzY1dP+MKL2/yHK2F1eFrEhn/f3mVHVp5DsBMahth2QEG1VTKFXjpM6iuQGct+KVv0XbnozUqXP0H7ryqWKRtddXu04RMpNPrILS2S/7cKufK1X/i04GinOtUQw9TZBiOWBGgnT5SQ//b3FjUHNtLhsOBSzhWEQrEcHhoLfcPerPajbiMiVOnBxFX+WaqCHmX8lu9q0pVYMnAkzE5Fy+IPJEIWVjqyZiP0OITPyZ6xVVHALxpC6T+MC32nFmb2nMuQUGN92PdDM7kG1ySiXQwnHbGe18q4HUx1YBX2Ux4ynorqFTdG1tLM3yuZ6m2nXqsZhPCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnj7PKoA9DHE7JLHb0vja5xXAAdMJebCq42e1qF8xGA=;
 b=DvxAaItQlH8+szXP9USWTrngD+Fkf26CIr71OJpqka9Z7QU1gXUbdE5DZJPyaUrT2MVNkaHfBLtG/scZyCvuTMbdmdZwSV/bz7h7Y77zp34CCLHU3ZKuLs6Vy0OrJg87CQR8cWjmOkrrZAnjO98CtewTdW5adT0KJ9Oqi22Gi+8cOVl5zUprWyB62T923cYSgCq3QD8UcmdqpVmk6y8kb2mybZD3klX4SWwJhlsN5JHpTjvOxWSDMYVT9WLVar7s7EWNWCHdSOC50dUwdtJaCJO1FERELRrLgcL2epHqV+MkzyKYdubTuf05eoMbXmSn2qFcM/Ut+cKOFvi1O1T9Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 08:44:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 08:44:39 +0000
Message-ID: <95a0531b-d41e-4038-ba9a-d7119f420b41@siemens.com>
Date: Fri, 19 Dec 2025 09:44:37 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip126-rt45
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bc32ad-0096-40a5-88d5-08de3edad8c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TjdRS3lvVEVHMlYvK3JJdVhtZ1V0bnhOWVhaTERVenVjcElMQmdGaTlqcDk5?=
 =?utf-8?B?VFRzRDJMOE45T3JxQUdFZkYrYVgrRkZOQ0RZT0RCZ3g5cmladkFjUldxVzhp?=
 =?utf-8?B?dDVLN2lsMFVNbGY3akxFSHJxYWZDQjVpdVhYR09MRjBpMUpMYzhaVTFtbVhU?=
 =?utf-8?B?VzlDOEVzWWp3T2gzSGgzSUlUeDZ0MkRINVRDTGFhYWNBRWo3NTlZc0l4RlYx?=
 =?utf-8?B?ZFpRaitXNWEzc2ZBRGtBMVBVS2IrclBNRVp3Vng4YmdIdmZwbmdEZHN2UjVl?=
 =?utf-8?B?S0U2SmVYZmhPMnplRmduZW1NSUZjVWNQM3JsWjBlcUtLTkgzQ1pFdzAvNHNC?=
 =?utf-8?B?Q2I0NU9hQ05xWlFHTUNmdk13dWRaRm54dHV1dGlkUkkvRWpYV3FVOHZXY2p1?=
 =?utf-8?B?Q1RLRnR0SkNsWmFiY0w3M2RrbmdhMmNlTm5CYVdUVDlLWSs4OXNxakhhZ0lr?=
 =?utf-8?B?Nll5aGl6eFAvMWo3QllSVGFkb0dJQmtsV2V1TktOSlRMTjJZMVdVTCs2WnB5?=
 =?utf-8?B?VXF1WTErVnorK3E1SmF4YlZOZzVSQVBVZkM3L0pHU3B6NHA5U2NrM3NmaG94?=
 =?utf-8?B?bnZidXlpdmlZdmM0Nzg0SmtDSjlENS9XM0Z4T3R4b0J1M1RvMFBBTlc3VGI2?=
 =?utf-8?B?L0N2ZkV1SkxWK3RGMFJWbWRlam01YjMvY09hcVN5dWEreC9WMHpzelZwclB4?=
 =?utf-8?B?RU4yUHhRQXdUUUV3a1VVblpZZzRWZUpEM1UrK1BFMVFwcWl1bnZOZE14c3Ez?=
 =?utf-8?B?bENpYWNWT2s0bG5WSnR0eGw5RVJTeW5TanNhOWViSHhMVnhtSnpUM3UrS3lO?=
 =?utf-8?B?RjhXTU1wUWJGdnVlSjQranJXVTZpWVNsRUVFdFFNaS9FdnF5d2NSMGkrZE5Q?=
 =?utf-8?B?cTFGeUVSbHZxNHViSGtQVlNEMThjcEtpcHBpeEJSVUsyc3VWdzR5VHE5c05a?=
 =?utf-8?B?NnJsS1NzamF6ZVVKcW1nekFsMjNZYm9lQmN6VVNoWE9hcHJPY0tGWDJQRDZ4?=
 =?utf-8?B?NS9Hc2JTQTN1R243RC9tMUdSY2JyK1BENDlPbFR0Ny9UMUdKWGZZK1VIUk12?=
 =?utf-8?B?VFVLZGtRd3BHVFUwcithaTk1bEs4aGk1OW5SU2NmUVBlRExOU3k0SUE0cFN2?=
 =?utf-8?B?TXkySzNjWUwvMXQ2RWVEaDloUEo3UlUxZ0NJM2hwdTZ5c2wvWnFuNU9KeGxo?=
 =?utf-8?B?NzhzY3VodG1ENmp0c01mR2UyMEQrMitwZHJaQ0lhNUQzTlBMYlRpNDNMN0lw?=
 =?utf-8?B?b3JIUHIraUN3M1djK3dibjlyVzBjUG40Rjg2MU9qcENqNWU2Y0p3U0tpSWx1?=
 =?utf-8?B?dW9ueGcvRkFzeW5HQ3VQYlpKL2JSWnhZOVJ1MWtxeEJoTU5tNWMzWFZxRzJI?=
 =?utf-8?B?bWZwOUp3bVV1Z1lKdDFqREx1V28vTVpUdWtpL3prSHR5VlptVWcvUWMzcGpN?=
 =?utf-8?B?QmtrRyt4T0JESFpPaGRtVUI4eFNLakdITDFVK21UZW54c094QlpmZGd0QnNz?=
 =?utf-8?B?UTQyZlZJaDZVbUQzMjdqMFl4UUVnV0VSK3dNY2t1ZWxDcTMwZkk5VndEWEJo?=
 =?utf-8?B?c2cwd3NVOWtGQ0FwRFBwR1hwY0I2Nlh4YmE1VW1wK1gvWjltUVk2N3ZaYWtN?=
 =?utf-8?B?eEFxQkVaNktsbnpoZlVDbmtrcmFVempVaVNiQ0o2YnpzZW95TldsNFAzYnYw?=
 =?utf-8?B?a0QrSTRnRHUrOERmbXFmcDdnQjRsR2dBL3ViMHo1TkhjWFp2NHFQQ3A5Yllm?=
 =?utf-8?B?WW56M2JDSXdqdHBkeXJCTXM1R2NkVzZURkxxUHE0L2R4c2dCZWk0eXgxWEdG?=
 =?utf-8?B?SW5ESzhqWEhEbnZDN2p2Tyt2RWxTTG9lTWRJQlNQMUdVQjBEenAwaHN1Z1VP?=
 =?utf-8?B?MVp4bGNYdnd1RE5hOTZOdm9WQnZYMFNBQUlUdEVkMHhFeGJJZDIybkU4WTVi?=
 =?utf-8?Q?P4mzTXV3N1xGfTMvYzy9buZzoDAB0W9b?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkUyOGZ2OHNWT0ZJeTNTMkdYMXZjUFk2c3h6a2pqMG0rU0llZU15RHdmNUlv?=
 =?utf-8?B?YUFWdVNWa2x2dE5GdFloaG9sTFRDNkM4dGJjZ2hxL1prY0orUGZwUEZJa3Zo?=
 =?utf-8?B?dktvYlp6aHNoL0h5WXZ6QVhTVThTZ1VqUzJ0aDdCVDJFdVd2YlU0cEJpc2RX?=
 =?utf-8?B?MEVTdXFLWGlCNW56ZFM2VGRGNkdoRCthRkVzTnhmdXZKczNwajMyaDFNMlls?=
 =?utf-8?B?WEpVOUhFU2d5ek9odlIvUjV4VTM3WDdObWdML2lWZGtDU3hPVnptTHRpVGk5?=
 =?utf-8?B?R25ZZ3ovSGRuVFRCNUl1RzRiN1haNWkwK3p0V0NUNHBvZWJVSnlGeHBJaG1T?=
 =?utf-8?B?cEw2YmxROGUrRUJWWHg1OFJUKy9qWVk3MzdlWkRaVjdJQml5ZHp1MklMUXQ1?=
 =?utf-8?B?ck02YklaQnBuSGJvbzBhL3RTTUs3YThWQWdyWlR5T3B5YStIdmtpMFA2ZCtZ?=
 =?utf-8?B?dTh1MkovYlZMOUNCRmtQVUpIRGJYVDdKS3B2UHNWVVNrYWJKRUJhMFJFcWV5?=
 =?utf-8?B?a1hZNjRJV2tyMTBOVGl3d1hPY2FyaTJkT29MWHZ5R1BrbWEzQmhaeEh1QTR2?=
 =?utf-8?B?OHNRQU1IYnFUN2hMYXJBQ1JYSklBWHBpcWFTSHJYRkxHNEgyeHBvK2lkaE4w?=
 =?utf-8?B?eWxWQlNOTUE5Y1MyYmh1M1NrZ2QwaHg4aVVzTXcrTlREaG1nTHdnWjBRdHJz?=
 =?utf-8?B?Y0IweEQ1YnJKczlmbkxpSE1CekVFcHpDYnJXdDNlRVlOdGdlc0NaMGpaYUxG?=
 =?utf-8?B?RnlCQ1MrMGtHWFpYMkFiK3BMTjdBQ281a3prWEFuV3oxZkJhaHozWFJDT0VZ?=
 =?utf-8?B?bnJRS2paSmxrU1d1T2xNQVdBTk5PZEdRcnVWUGM5WGVSL3lhVm5hMzNOOTVB?=
 =?utf-8?B?bVoveWg1OHBjaVJjNFEycUhlR3ZpMWNkUEVNcnUrUnZSZi9hWDk0V3dEM1Fx?=
 =?utf-8?B?czBOa01iTUROZWV3T09VSWJFTmJwNFR0eWhXSVRZZDJBRlJzYXMxTXl3N3JV?=
 =?utf-8?B?dmVOaXVPYVJXT01RaHdyb3RPd2xqdll5bGlmYUZwanh4ZWk5K1dKSzBGRkto?=
 =?utf-8?B?ZmZDRFNKUTArcHh3ck9DUjJLazdxMlpsVVNmN2FJV0tVZ2djQXdEd0t6bzRw?=
 =?utf-8?B?aEpKMkx5YzhwZEsrV1lwdTdrWFZtQmo3L2JQZTZsUE9CQnlwRU5hVVlaTklX?=
 =?utf-8?B?NzZscitrTnFFTVpRUlFCc0lYclc0Ymh3SU02ZEFCSUJ2Rm9iNGlTZzJaaith?=
 =?utf-8?B?c1g1dXdxOHdoNUxRSUtKZE5TdFZ1UkJSUWlyZG5heVVlUXExdGFvN1NncnlG?=
 =?utf-8?B?T0RGRkRPLzl4WXpha0w4UmIxcGQ1YjNZdm50UE9yWnRZVm15MS9EbWlFRGdD?=
 =?utf-8?B?RlU5ZXVKekFYV1lhZW5HMy90THVwa3FkUnYrQnRBZ1h4ZGlIOElUdlFDaDND?=
 =?utf-8?B?MFYyZFBwMWZPa1lXSkd1OFEwazlsOTBjKzlYTE96K3dJQTQ5T1BqWGd5Nngw?=
 =?utf-8?B?UW83bFROZEs1MDIvcFhvd1JKbm5xWlE3OERmK3hGUXFrc0UzY1Q4Q2lXSngw?=
 =?utf-8?B?VjVCK1ZoeFFrampGNzlyVnlHcytxL2hCN09TQ2o2c1VBVlgvVytQMnI1VVBm?=
 =?utf-8?B?bTJpSzVVZTBDVzMwaXJiTmZDK1Z4VUlhSytkVFZrSnB5QjZWdGFxbEtTSVNC?=
 =?utf-8?B?V2YzTXV1ZU1CR3hJL1cwTmdXSlgyMEZnOXNyakM2T2ZEV2R1TFV3ektoUG5F?=
 =?utf-8?B?VndqWDRiVnNoMnRpRzl5UG9Ybm42ajk5emNXa2ZYbHc2TldUSE82SjAzVWZU?=
 =?utf-8?B?akdkMnBOekRzdURobXlweENGei8vM0lUNDh0TStuSVlsdlIzTkVVenplZEdi?=
 =?utf-8?B?ZXR6SndFRUk2Y0NEQS9RRG9Wc2ZQWm45WmJkQkxQSFNQWnp5TE1oeGhGU3Ey?=
 =?utf-8?B?RG9GV1FtUWxMa3pPcTlTSzcvWmEzY1RBQXFCSk1WbzhWekQzTGczSTllNi8x?=
 =?utf-8?B?eWVnN1pJamRQZkJPUURYRXVxUEFYT0U2VWpjbEhGR3RNRkhwNzJGRXZkY0da?=
 =?utf-8?B?RUxodlJBa3NQbllIc3p5YW5ucVdoeTFPa2dCZTFCcEpkTXlVd09STWsyNUtk?=
 =?utf-8?B?WmpPMUkvUVE5MG9ZenNoOHErZnBMdVFobVRkV0VGa3I5RGxjTWpWNzMyRWRq?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bc32ad-0096-40a5-88d5-08de3edad8c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:44:39.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv5U1oZ4e+rTDNleoQpcTOGs8NPcYqR0nkRZkFYJetEgHnw2ptZxvepqk1qnydy5cV6Lnw9ISyLR7g1fz/KT1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6981
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 08:44:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21164

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip124-rt44.bb => linux-cip-rt_4.19.325-cip126-rt45.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip124-rt44.bb => linux-cip-rt_4.19.325-cip126-rt45.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb
index 026dcd7a..34a83b3a 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b04d0d24e9a3cf192784f9f5e6dafd2332b40f55b2066e55f5cd18962b99cf1e"
+SRC_URI[sha256sum] = "b4be712efee191bc40c20927455d33d4b97e3f8ec5c504deb26bdd29f94801c1"
-- 
2.51.0

