Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D2AD5D67D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 17:31:26 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.59])
 by mx.groups.io with SMTP id smtpd.web10.78249.1731000678689635843
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 09:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yXibANoS;
 spf=pass (domain: siemens.com, ip: 40.107.249.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/h50UMyYMYiwOz4BwZywh6NBmXQumPneiUSiHPxWrxJXZ5PWs6h6xBWxFQIiDCC17tUkH3oPQqWx1CEqso7ljv5i6ZMRYQJUA6UKWIeA12uCvLruHcFh5UtfvXKS9m8nKospqgkDwUF8lmApsskNC+k8dtTJbtIy6GZI+QbBQfgXc3v4Zt2mbARmNL4eailK0kzZTUqh3/MHj2Ju65cWGrp3V3AXiej1/8VC3uaXE9mEp9rqvPV4P/1bzTZXskuRVY9C3ALNGPkkPWqeAYPe3VGbrgu9s/xa8iK3gcGMmETfs+sRF+CnE3RTO7PIIFmDtBUaOUcvzgHBnoqoaSsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwQx9wC6ytNYjDXqcgz1WzhKil21eguQzn2IRuttunM=;
 b=f4eanfhubnjmc72qgAhTwW/nlsmxnKAxr7EY61+1HJ679U12zN/72s8KxiEJeIOVyUJgn7HjmPMz2pLuizQFm0xVPdVFs5eyWFPky0JFlFbU1WTSYfdrHO003XYF7Ak7jGmpcNxbJFcWYmSy30A42jZTSdLpc63nVf5VnfV4/MffrPpjr5F3qYwzVGfTSspI43o2P6G1PoYSgwnEqiuNrrRD7x+jAqMywHaODakC5GdHt1nFX2FOHt2IchsMZGwH6kuse80pc5LQWqnx5o01kmA7SFAJaiTFi73U4wbwPwPO5nRGBBpiDg9PeY+b9l4zPLWMq78l6QDLQd6/T8KaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwQx9wC6ytNYjDXqcgz1WzhKil21eguQzn2IRuttunM=;
 b=yXibANoSUQJVydV9wYnyBOIZqcezDZAa+/jxJ5Ur/t70iFM3+LoU/dY7oSekfBhLeWTA10k7oA1ZKQkoehRObGG+ByEJSjgWEqcUC/f2r06YpiFct/42MjrLKjpL20dpq7uXIzahPpuX2Yye0dbNp4JO/hl2S5PobXA7d6TNtTWZ3zO8+yWusymMSnLUy4QTXfwdZ9ke218X7qHGIu3SvN79o7aPL3Cn96f7iYYA0OIEg+nYH/3NT68eG5fxkl3JsHyXZeUio01geBlimtgJFiRoB8DK5/oGWGxKswBEe3hCWCci6wYDwTFQ1gxxOOBDkukeoCmUSY5l7MJ4iZuqXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 17:31:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 17:31:14 +0000
Message-ID: <a6434790-7bff-4851-947d-1c1d8461a7b5@siemens.com>
Date: Thu, 7 Nov 2024 18:31:09 +0100
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 10/9] swupdate: Perform checks for supported
 configurations
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 76edd4a3-193b-48bf-d061-08dcff51fade
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VzVQZWFWV0h4UisxVHo2TGFoODd4ekNLUjFVc0JMRTRrR1BLQUpUYkozZUlS?=
 =?utf-8?B?RE9qS28rY1VtSmUyOEFTTjFSMmhSejEwYitwNkdLTmdGallDQ2RsNnNNNXJD?=
 =?utf-8?B?bFdqVHJIOTdBeDNoQ2hFTisxSm1Xc3VwMlFuenA5MjhHSkFCSlVzdHZtbnBn?=
 =?utf-8?B?QXA3SjdwREtjTURhQ203ellvK3BadlVpUFBWRHJZTUFtVnU1UFVmSUZpU29m?=
 =?utf-8?B?bjhDUDVOb2dxYlUzMC9KUTJaRjBmK2JJRTZEMzdyY013NzNRejZhZzdjajRY?=
 =?utf-8?B?QnlzQUc2Tko3M1FPQUpIeXhJZVlsam9rd1dKVlMyZmVhdXNrOXBOT0wzSDhP?=
 =?utf-8?B?NGUzdGtZMG5lbDB4Mk0wN0FsZHkyU0RLTHB3YVlkUDVRQUdUNjVadWVEM2V0?=
 =?utf-8?B?c01lNHZiWUtpWFVVQ1dlNzZ3aFJyTjVDMlhpQVRPQ0hONWxGeWVVZ3lJM094?=
 =?utf-8?B?ZjdOUXI0TGhZTDNZY2RNT3QwVnRkd0NVOWJhQ05oT013bDVCRTQxUTE4T2JD?=
 =?utf-8?B?MjdPTVorWjlIOWR6Y3hjZjc4eHk2aEQ0UGV0TDdUb3JmSkE5bE9NVUdncVpq?=
 =?utf-8?B?VHZRMk03emZBOW81OXRoTDViZlJJZXdzaWhzYlVYVHBnS2hkRkV5S1lIZDBz?=
 =?utf-8?B?L2daMEhjN1R5QWFJRi9wQk9STjRNQ2ozeE9vc0cvTE9PM0F1WHA0Y3d0czFO?=
 =?utf-8?B?QVFuUDFtNUpMdGdvaTlhUW9aVzdnZEZ3Z2FlbytvTVluTTd2MkdVMm50NkJL?=
 =?utf-8?B?SXJ4R1dFTnV3a0d4RENkcXErVEY3cXMrUTFKODZ3UkpEdVBLa0VOdXhuYVR4?=
 =?utf-8?B?dFJDUmY5UjBISEs2K1lyRUFEVWt3OEticEMwUTlIcEduNmE0YUk0VU85YXdV?=
 =?utf-8?B?V2tIeEhjWHRMMGk0N0UzVWN1TFBnbTUrWWtsTjg2YXRWQ3FvVFN6MlIyYTlz?=
 =?utf-8?B?VmlLZ0trRmZRcll4SmFwSy9qT21SNVFLQkU4a1A3a0JUS2NEMFJSazVTOStB?=
 =?utf-8?B?bit5bFpZOTBGbldjNXYrRVRXRkVZbFVvNUtlVFREem01TlppcklqK1UreWdL?=
 =?utf-8?B?Yk82WHpYNjJlNUNCTVNrVUxxa2dnc0VKT2xjWUN3RnNUS2llZ0V0QlhuSUhN?=
 =?utf-8?B?cktjTEFPUXAwUFJra2NxMFIrcFRydlJJcVc0NUlKVERrTWRob1lydmZZSjFt?=
 =?utf-8?B?cDNnUmxBWDRSd1I4WEZic0lPQmRRMTBhWmpJcmc0YUd4bFBlQS9acWVaZ0xy?=
 =?utf-8?B?QWpXVG90L2RWUFdZSy9rbXB6bnJYZ0JNb2hmQzY0aEdKeDJaYnQ0bFJJOElD?=
 =?utf-8?B?SlpFNzJlQmU4b0F4THBvbnZGMzJKSzBEakVMSFlqdWFVc3NZTFR3RFpqemVR?=
 =?utf-8?B?MkpaTytBNkROdTc3NmFnTEVST0Y4dXI0ZjArVW82cnZjQmFrMElscGt2TW5F?=
 =?utf-8?B?M21iMDR3elQvbzFSRG1STW12Z1pISFExc1lhaEVUYTRVQnMyNWhFeUxJM2x0?=
 =?utf-8?B?cnVkZGpTekZZVVlXYUFwanFSaVliVjBkUWRLVGc4Vkh2eHg5N1k1bDFvd1lK?=
 =?utf-8?B?UU9TUGdxd2QxTDhtOHJBTElZcEs1QzdkSFNTUjJJYUZhSFpLdHNJUmtWZytN?=
 =?utf-8?B?ZVJBMmVUSzV1cTZNb3hRZ3V4TENoNjR0dVJBQ0pLNU94dUh4UnFwNC9jOHMx?=
 =?utf-8?B?Zk1GSXBiRlNzRGN6U2lzMDVVN2NEd2Z3YlpBWHduT2xJWGxUYVh5YWNLM0hH?=
 =?utf-8?Q?UgibQmTQgxGw6CJc57n6tYAkxn+PY8IvqDMd18U?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWRUcXdTUmhqUGJmVjBjMUg5ZmhaVUxSQ1M3bVRXc0lreFpOK0FVQ1RPc3NR?=
 =?utf-8?B?aEthSUxjT1ZmZUJ1MFg2YUpPZG4xcmZNaEYrYmV0MWwwT2Y2YVhubnIwTlBS?=
 =?utf-8?B?TGE3ZGs2Yks2YkQxNms2NENxcGU1Rllhbkp6T3BEZWlQejgzTW4zaWhHRk5q?=
 =?utf-8?B?VlpBOXVweWdCM2Rnd29KUVNNZ254VytmSGZmMk55TXJUejlURlhTTkVlUktL?=
 =?utf-8?B?UjNhTGRpOGQ2dEwvSjF0eTNCNS9DclNaN1lrUis0SUw0akxndTRxaFI5VkFS?=
 =?utf-8?B?SjR2NU1wYWFwTDFyRHpCRkpUTzN0L0QrNzlOMFYyMEkxbkFaUXFOMDRBOGNH?=
 =?utf-8?B?Vy9GTXhDMzIwdC9WNW1XeU5PazJPTzFQZE1GWk9zanZOMkl5QWt1TGRBZDJy?=
 =?utf-8?B?TnpXZTFXa09OV1hhaUltaS9RTzdBU0t0SytkVnI5bjBDUzF6UTdyM08rWVN3?=
 =?utf-8?B?QWNnbEFjMkVETlRKazhPTERYOGdHd05wY1RlUG1zcGwyTGhacG5sNzJJWmlz?=
 =?utf-8?B?MTBva01iUVhvVzlSV3FuUlFaaVk0K0twVkZSWi9XZmZ4V3JPbnYzU1FabU9F?=
 =?utf-8?B?Nzd4ZmNaVUszd3h2dmxCb213NU5qTXh4bThQaUsyUk1rZGxQWHp2UW9DQzB1?=
 =?utf-8?B?a3E3ek1oaUkzbnVSQ09WNUk0Z0VMRC92aVBWd1F0SVdRZEErQ1JnRGpZemlG?=
 =?utf-8?B?MlNmSTJjaWp6UkZvR2R1QjVQWWEwUndydC8zdzNrVW11K1AzdjNML293dzN1?=
 =?utf-8?B?TkRxdVFXVDNTeTZLWnhML29iSFgzQnkzY1hDdXl5TDFDcXUrUlB0SG1La1VF?=
 =?utf-8?B?cElXMGF0QVQxSForcnVNWnZtOFdSWm8zamRuOWFjY3J1R3E1QThKU29QbEFo?=
 =?utf-8?B?VUtmT2U3bVZ6RnpMWm9HblZKVm9RdkFIaW1LQlp5cXlOR3FPSDZrZm9QYWlY?=
 =?utf-8?B?VThsVFM4QytsdmhSZjh3VFV2YnRKUzFNVmxlK0tmWXlTVmwwalB1RHZjczY2?=
 =?utf-8?B?RTh1czRMZERyUGlEc1kwWDdXRHJzK21mbytJOVVtSUtGem42dmtCU3B1emJE?=
 =?utf-8?B?ZmE2T2pFaHQ2WXM4N0NkNTgxaWR2cnlWeHVBbnVQU2hoZ01QbzUyU0Zaelpz?=
 =?utf-8?B?djU3a3JBcVNHdlVJT0VaTU1aVkhaUldqdkkwUEtIY1NHUGIxOHplbndaMmJz?=
 =?utf-8?B?NHN1OWhOYWE2OWFWRERPU0ZUR2c4SHJGcXpYR1FFR1RKMVBtQnlmK0dKeGRY?=
 =?utf-8?B?S2t5aEErTjR5eUFJdDk2ZGVwZ1BJbXluQjRHVUsrb3hkc0VDU0Rmc1dURVE5?=
 =?utf-8?B?VXN3WjdsWDM3UDZlYzBOdnpTbnZPV0dqSlVaQjcwTHlRSmZ0bFA5U1l5MDFF?=
 =?utf-8?B?RExjUjFZYUJPdzFQZ3kwSk1kK3dNUTNBcGVYL3lwRUNLWDhSUzk4emIvc096?=
 =?utf-8?B?SGx1anRyRGdUdzcwOVQzeW12MHFOeFEzOUZaWjNmRmU2dFo0RHA3SEkzWHJx?=
 =?utf-8?B?QVQ1Q25NYSsyeVQ5cEdxVHNqeUhjRlRFQW14Mm5Ra3NZbHZKWjhNbHhGQVMv?=
 =?utf-8?B?aXZHclJVTEhoN2d2OHR1SXdrNjBpUldTT1M4UkFkZWNMbDREYm9BQnpUY2Zz?=
 =?utf-8?B?NHp5UGEwRkc4ZUI5R0I4eWJUNDIvaXdxVGpXcUFRYWt6cmF4TVJMRzhtTVpG?=
 =?utf-8?B?aGl1S2NZNzAzVmNNMXZiNjIvRmJxeHdEUUNQaE9sYkcveStBVUQzbDFlK01D?=
 =?utf-8?B?dEZxUWplVm1xbFhqaW53Q29rcDFOYldjMHVvdXdlUklsc1RVdDE3Ti9YMGhk?=
 =?utf-8?B?ZXFvOWQwOUFBV3VYdUo3QUhzaEhDZ2VlU0FiUVNQeW1xYk4yaUlic2c5WUs4?=
 =?utf-8?B?YTd5dU9XTGJNckRaT3MwNm40YVJ2N2NVZUczc0FmVytiM3ZWWW1Eeno5TmZ2?=
 =?utf-8?B?Zml3VURTb2FpQzdKbjVhT29JNVc3dTB0RzQ2NE5KYWxtbnFtdk1ZMlR0L0FB?=
 =?utf-8?B?ajN1RjIyYUV4TSt0L1FWcWtwdk9FZXgwU0ZkejNQZHE4UmcxbXFCT1hrZFR5?=
 =?utf-8?B?Qjc0V1RMbXRMQ1FZY1pOVm5GcWo5aXpDczVzdWFIdi82QzJ2QkVCbGFkUUx5?=
 =?utf-8?B?UThLTlZDVzJmdEtGSXNDd1lnMkg0KytGdG5WdEVjVUhPZkcxSXhOMWVmcEZV?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76edd4a3-193b-48bf-d061-08dcff51fade
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 17:31:14.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztumID8MvnDeu4NTquR8e0KGTFQq9hexaTTWW3Qs6J5YOLZJjNB0oW2Bvef6F7cApALOD86m/Erbwgi8DEHQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 17:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17222

From: Jan Kiszka <jan.kiszka@siemens.com>

The upcoming trixie release is currently containing everything we need
from SWUpdate, so we are retiring the self-building option from that
release on - until someone comes up with a valid use case to restore it.
This happens to avoid exposing a configuration that is technically
selectable but became silently broken due to being effectively unused.

The Debian package enforces SWU signing. Therefore warn if a user
configures this out while using the upstream package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/swupdate.inc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index b1cad439..81c33658 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -23,6 +23,17 @@ SWUPDATE_SELFBUILT:buster = "1"
 SWUPDATE_SELFBUILT:bullseye = "1"
 SWUPDATE_SELFBUILT:bookworm = "1"
 
+python() {
+    base_distro = d.getVar('BASE_DISTRO_CODENAME')
+    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
+       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
+        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
+
+    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
+       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
+        bb.fatal('SWUpdate from Debian requires signed SWUs')
+}
+
 IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
-- 
2.43.0


