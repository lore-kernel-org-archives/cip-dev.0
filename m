Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A3C04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:44:05 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.48])
 by mx.groups.io with SMTP id smtpd.web11.822.1715964242065166839
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 09:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y1+IWTMn;
 spf=pass (domain: siemens.com, ip: 40.107.7.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksAVh4tyTGh9OckHCD3zIPcOeqOoa6SUVWn35pk7z6GGdE94pyFIkFvZbG3MymZyBKl8Ki8YICnf6UGWGzXq5FGaPmz03nplQyEyE9NlvNNgs5L5ctecGbSIooOhJcYr8S5hXbRGm2CGlEJcM3xv3o9+YT4XLe8hypl3EAQisH9M6+QsdDZGzFbxvO/uaNUCmy+8Eq328bXSQxFCwNiaL9893JT38BaMKxRPsIe5bSFE2tN/QcrsFF0XUvNqF70t6CzhdbFAC4GNG8+alYzUZl4+7z6PHBHAKkMDKHos44OuNKZzbI5VQY5UlHrEFeIPBKfHpEzRunutE1ALjIgNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH/DjiKqEo+ZAZ+9Got1cYLeEt3xPQtsJKXJN75fXKo=;
 b=Hll+hJhySzAi6hhw2sUIX2hz/aLcTVAQMFQlVDGu4p3NewTtMygmtcIUuSBHQnhiWV6AC/jbX7eknHVsr5/S/NZPUAyLzt6UU6h+CI99KnO+f7myQ7a4+NS2ff0v4VwbZwrs5qQcds3+MLt4BHhtML9XKbinuTtjAKWT7WshekG92qPFBNEN0tzsXZ/8KyDtyBTZ8M1dDKqjKCuepXxLH/vXOndP4gm1Bg/z8xliQEXKfQ+YKcsZDUTWv6FAgqi9v63ZzXxLLpd0igj9ghgjcaRJoMOX/c4N0QfxMqJY+lqdUmG52/97bf5UJTLgDXQQbQamqcZOBDKf1X2yx2N8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH/DjiKqEo+ZAZ+9Got1cYLeEt3xPQtsJKXJN75fXKo=;
 b=Y1+IWTMn56aGfIVjXK83IOerP90ZNOMmZkCSPLElVwLgyrTAFEcwft8QQoZutrT2cRCV50EZdjltKtu4XWG5bK6gyJpnHEcnT8tJIesgsFxpnv686bujrZJTQKJakt0Kebc/RQ0/XqtFxEVx/tUxCCiqMXwtNCLIguxPbkF+Qi4b6pTFOzhUO8sQEWZ+a6V3PvXt0Sqqas9yGrVGlWKash/5IUvYtKoZ6bZVyETfEc1rfksygrzbR1kQHA3UlMPZf2dSUOjTlL1OXb2Ixs1RUKYnJHgvq5d1fwt42yqru+uLNkN4kvg4/PvyZpIAF2u09Op66ktcnxaf3VFQiYUeeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 16:43:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:43:58 +0000
Message-ID: <476c1778-1c3e-43db-bbc4-69b0e48442e4@siemens.com>
Date: Fri, 17 May 2024 18:43:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] shtab: Align recipe name with source name
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c12a3c-f2ab-49bb-80f6-08dc76908c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YWlDMDNFTlliY0JxeTBocWFROG5seFdDcUdEUFl2Ti9IR3Vva1VvTDdhcWF1?=
 =?utf-8?B?dVFCS0dHdktFMW5uczZmSDdObisvNVdBczR2eTZ6dWZpZW1pdm5yMjBCUVMr?=
 =?utf-8?B?cFczeFZYNzlBaS9BeFVZVEljcjRDTkc4ZWQyeWcxZ1RoSVRWZlVxSDhqSkxa?=
 =?utf-8?B?WkxpcCtxZWVoVlFpWXFDWUZUSGp1dENxSTBDUVRJemNUenNoaE9IVjRiZk45?=
 =?utf-8?B?Z1FGdWdITThLcmEwRlcrUnFkUVF5WTl2WXJteE9xbGNzbUVJQmkwRUtaQ2Rt?=
 =?utf-8?B?dlZTUGtJN2dZd2NCdmJoK3RUalJoc0tZajRxcHFkcXBDdkRyNUEwR05wSDhR?=
 =?utf-8?B?V2Z5dzYvMVRsVkM2WFZEUVJwYzZKRUdidUVaTWc3SmZ6VXRJQ0kxenJXUG54?=
 =?utf-8?B?aDhrTG5QVnQzaGx6MFlPN00ySTYzVW92bWdmOGJISmJ1enMxMEN6ZzFxK1d6?=
 =?utf-8?B?VHFKamEwa3YvOStRTlNuWU5NbTBWZUlWSVI4M0VDUUFkQjdpeWZWM3BGMGVZ?=
 =?utf-8?B?dVVXMi9nQyt3bXZuMmRNUDRkNXdZa2hBeDZmVnEveVBtV0JIaWVlSXgraTNi?=
 =?utf-8?B?M05FUmdOTkoxcmQycVFRT1R3NWhyMjFRdXFocmRDZkkwc05pSHBIa3FVczRi?=
 =?utf-8?B?YWJYRjR6TlVaZkhoL0pNY0lBZ2MydGhaREJyTnZGeTB6cHhlNVMwZXViU1lw?=
 =?utf-8?B?YmxHYVhzTG8yUi80ejV3Ui83OWFnYXp6N3ZDSTFBRDNDR1BGS0luQUluWjQz?=
 =?utf-8?B?R3pnRjdTRmJOem40TytrY05pZS9ZenlqTmczdzc2U29NZlpMZDYzSThsWlE3?=
 =?utf-8?B?cmgwMStTUkpObUQyUWE3TFVnOVpybEF0K05kaUVZdFc3NHhsYjIvYXJzc3F3?=
 =?utf-8?B?MnlveUE2ZE82TTlNeEhQcnlzakpWRVZCZGZrMVoxdjJ5dVJUb0dneVNVQ1gw?=
 =?utf-8?B?TXJVUm13QU5TOHk4SkhSZFE5RGljWVZtWUtUUkV5RjZNdjlpbkd5ZXlVZUJF?=
 =?utf-8?B?ajJtVHdXOSt1UVdlQnVZYVBBYWdtUnNRTkFHS1ZhRmNaTmxSSk9IRHhMNDAx?=
 =?utf-8?B?RW12aTB6MXlSODdOeVJGMmp2L01jdkRMbTVXZUxaS2FITkVlbnZwdjB3bjNi?=
 =?utf-8?B?K0Fta2hVVHI3NklIa29OTWN1d3FpRTRINFcrSlM3bnpuTUxhQ1VuMkkwcEIy?=
 =?utf-8?B?RlNTdmdXK0YrTDdyVnV2MERqamJ3dXo4NjA2WjA4eUJVMnBrdmJFNXJtQlhP?=
 =?utf-8?B?emFXMmdPVGNtbFZKZkE1d0tQNVA5NE80TmpBcDZtSkJDY01NQ0xwdytqWEo2?=
 =?utf-8?B?WENlVW1oZ2VEdVV1Y1pEMkl6MXVKcXVnc241NlRnQlBLamQ1Q0k2UHQxOFlv?=
 =?utf-8?B?N2ljVkEvdGJXbldQUnRoVzdrWVJMNDBka25lVXkrLzVXL2pzWVY5MEhYVmlN?=
 =?utf-8?B?eU1IMVQwRmtuTjYrSDdYNkJMVE5ZbUhDUjg4UXNPanhxZDR6U2szRjdZWFdC?=
 =?utf-8?B?VEU5emYvWTlGN3B4NExUeGROb1hSS1ZiWXM2WUdCMDJST011TngvY3Y1NmhN?=
 =?utf-8?B?S25UREJnKzFkV0s1OTZaZHRmWjVVWkdlcXFIZW5SWTI5STMwSGtyd09HbzlS?=
 =?utf-8?B?QzY3Tmg1d3Z3R1pQTnlaaUdQQk43OFlCY29TeVVIYURSM3VBVWdZZ3MxNXJJ?=
 =?utf-8?B?Q21QSDRrZTZqa3A4REZtUEFrY2kxc2x4Zjdxd0d6Y3YyOUlvZWxvM3B3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzhCZytteHRYRlVaaENOU3paUnZOWDNURXNzQVN6ZmF0clJRbFJ5NkpZMWJJ?=
 =?utf-8?B?Q0dPbDI1SlZpVDhYV1NPdnNkeFNSMkQwR3Y4M2RXaFFxUzFONlNkcVdGeDZ3?=
 =?utf-8?B?ZzBUemVYbkNGWWFlWkp6S0JpUFFZMVZzMXhiY2NDaXJDOGJiK0FzVjdSMkF5?=
 =?utf-8?B?d3BmTFVoRnA4aE9kMUZ4ck50cXQ5YUJlNTVTbTF0Y1FaQ3hWN1RVd25qUUdJ?=
 =?utf-8?B?M2dKY0h1R1ppQnhoN2hpcFhHZWhPMzV4R1NLOXNhaUFTSUNxZTMyd0w3Tldq?=
 =?utf-8?B?VWR3bm9vWDhqb0ttTEtyOWtsajNoTkZaQ1J2YzJHTThMTmYxWFZpZUJwbE85?=
 =?utf-8?B?bGhHckFPb3NSMlZuNExETU5oRGo5bVpXNmNEbzJiazAzcXdkK2tsa2dYd28z?=
 =?utf-8?B?Lzlvd0ZBSXhGQmx6UFJyVVVxbVo5Sk9rT3lOUXRkMmFKZmxrTUY0Vmk5eEY4?=
 =?utf-8?B?WmU2REYwOXF1TWpsN29ZRjROSStkMFVMQVJhY3pvS1U2K0FHMExnTVpRWUNj?=
 =?utf-8?B?YnI4SXFHZ1p4dXUwdzRZK2xKa1B5cC90ZGZuODFLdG5lTFdHOXBlK1RINE5k?=
 =?utf-8?B?SEY0Qmh3bktpeFV1OFVxTHp4MGhKQnhkTlZXRlpyMkdoT3FTd290OWlKN3k1?=
 =?utf-8?B?dlV1WS95WGhMemRLNTFOYlNkUDExMU9rSlVFaTZLMFg2YXB2TWkwM2JyUEE1?=
 =?utf-8?B?am0yeDZQc0pQUmN4Uk1YRjIxbUNibmhuQi9lbzJyRTRtdnBiQ0FKQjA1bDJC?=
 =?utf-8?B?aVE4ajk3aEk4MTZCYXRjRVZNa05IZE91dExWS2xQSlFhU2lLVVhTWmcrWldG?=
 =?utf-8?B?L2t3Z0VwT3dsVFV0dXMzYjRoc1FXM1o2MHhINE4vMC9mYXlSdXltWnhXYVl6?=
 =?utf-8?B?RHZFdGVvK3lxTjNpVk9MajhwM1RodDdGQWdZdldGcVpvOXhSL284QTUxbWRi?=
 =?utf-8?B?emNRMndGRTgxV0FRMFVvaStsMi85MVZLek1ySGJiQWNBU1NVNXpHZk1FbXUr?=
 =?utf-8?B?KzdibW1sMy9xWFFtb3UxVWRVNXdQU1E1OG5wNFFCdk5xT28xVldNUXBHRkdU?=
 =?utf-8?B?eGRMTXZYZDdsSjRKWWd3VXdROVpGTmlxdkxGRnJmWjJ2OUJxVklybmVEMmJr?=
 =?utf-8?B?MEZGM3RYdDNDSDMyM016ZXJwN2xxZnkrVEg2VTAwK0FtRENjVm5PUFRVeUI1?=
 =?utf-8?B?RitMdytsVHQ2dkY1ditGUjlPaGtqdVdEMmZmOHlNSm9UWlpTSDF6dFVxdFh0?=
 =?utf-8?B?bVl3eEp0b0owK3NrQ3lYVkNoRHVFdjl4VWlCUmx4aVJMUGQrbEJNRFE5cStY?=
 =?utf-8?B?KzQ5bTFSdmo5L1IrT21PZEtOck82WkNDaVEySldFcWIwU0Qxb0FicXBuQUJC?=
 =?utf-8?B?YzkwOGVxbzQ4dWRDaUFSNkpHSC92QkxFZDlPWW4vMmRPbHB6dVU2d0RFcGxj?=
 =?utf-8?B?UkJJd094UGJETnFZTXN1NDc2WGhDem85Z21QN09VVnUxdHhSdkluQVQ4ajVO?=
 =?utf-8?B?OEtNTzhJUnRUL212Z1RRZWdFVW15WS81WStzUDRVNWxmTWtYdnY2b0EvcVQw?=
 =?utf-8?B?bklJVkR1RmV4UW9vdnJrcEpwVUVGeGxBa29DUWFrYjl6L0Jycnk2L1V2d3Fw?=
 =?utf-8?B?NkxRdGZmREFMNWhmZW5iVDZpNXZiTFlGT1llYktkVlc5cTdLdzF1by9Yemhy?=
 =?utf-8?B?RFlZV1VjY1Z0VTBZYTNyNHVUcUEwN1lsVmNQbm54ZjVibUdYMUpZNkthU091?=
 =?utf-8?B?NXRzdTJLN1lyejBHU3hpbXBzUENnaDRPbUNrV3Y3YzlvZkFWY0wzZHYyWlIr?=
 =?utf-8?B?bWpWZFBBeUdxL25Fc01UcFllemZDdS9MM2pYdjd5NnE1QVlSWnVBVWhtdk1r?=
 =?utf-8?B?Zi9rK3duMkg5U2tIUnFMT0pEemJZVTdRU0JwbVZDYlJ0UHdhR29nSGJvRjFj?=
 =?utf-8?B?RklQOGc3cVAyc3d5NXdPOWtPWGpZM2lRT0tNeC82eHEwNFdZV0hRNGpiZU1J?=
 =?utf-8?B?Y2Zrb0dDVmhRaDlzZFRZKzZSOVp5aFRmbjhUOGRIQ25RdFZ6SmtYZ1NnSUN6?=
 =?utf-8?B?bDl0Vm83a3IydlpvUzEybGJJNWk0MUNDYUFJdi9MR2RHRDFrelpwZ1YvYTVz?=
 =?utf-8?B?c2s5R3g0YzJTOGo2ekc1bXpXMTN3ZC9Ua2lLMDJ0WDlpZE1QY0haZkZFNEJS?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c12a3c-f2ab-49bb-80f6-08dc76908c6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:43:58.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjJXtWprWq1MZKKahBOXQaVf5WnVVCU+C+RY7hSYt3dbUREkP4SlPU+MI11nQduoHKeK52grk9njJ3MJZ8SZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 16:44:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15915

From: Jan Kiszka <jan.kiszka@siemens.com>

Upstream-pending isar patches will demand this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb             | 2 +-
 .../shtab/{python3-shtab_1.5.5-4.bb => python-shtab_1.5.5-4.bb} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-python/shtab/{python3-shtab_1.5.5-4.bb => python-shtab_1.5.5-4.bb} (100%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
index b6bb2bdb..20cc907b 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
@@ -34,7 +34,7 @@ PATCHTOOL = "git"
 
 inherit dpkg
 
-DEPENDS = "python3-shtab"
+DEPENDS = "python-shtab"
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
similarity index 100%
rename from recipes-python/shtab/python3-shtab_1.5.5-4.bb
rename to recipes-python/shtab/python-shtab_1.5.5-4.bb
-- 
2.35.3

