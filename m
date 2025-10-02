Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D5FCAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 07:53:05 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.web11.3664.1759391577574505204
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Oct 2025 00:52:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SE23s8qe;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAAPKMsM9m4DP9tiPghr1buOeqUy2gLQk3itymAeN0f/n615Cjy104FeKGDTutbLBc4/9DMTCS5SJeBjeR1M1xwJezgy+Gyihw1RFb/m3XjiFUcQJLjrFv/1doSebOTmiPiWBdGczKP5oTS32gqnqg8Rrd6rca8NU5hwd474Ux186pm5+FpQHxPEFnFI4PO6P1ZkskpVJTyUy3Jt7UyMa8OiuPtwlA+mLYSCVAAGPmrpYDPG86X9jLEK3MZdOpkIFD0s3CIyNKP7qaXAeNJXwKixn/hBmIEYT5aCtjGHBo3Zeb4agHX8EpQah2w2232Fp6BiDEblBMwU4w+1qmpwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWbsIKml9sm45GGydhspNZt4sa2vjKWWNsfN3tgl6/Q=;
 b=E9zY6PVhheB3EMcPnTc8leqm+faBxXBXjb96YsmgKI6jhs+NyopneFX/dMwfeZTWYAdqkAw6hCmYZ2Ei71ybRGDMvNhhEly1qQMFDVAAkm1KmxtRbbs8BGSuS5OvVq7YQk1uAhukgLPKVkS0ljeIIWYFidl2kvN1kcq2fmditgSByxszGLoIjjCKG4H5nVLLukr1RNoausZusB8fpoow1xcWXfIFyNaBeVJBCroIbmof2yScNs7prEV1U7+FonDqfoqeEfI1kqHEBKo0733OldFXnyg1jPGwNBc4qCRQEond39ZlTnIWYFcDPGY8yO1WFylOddu8EGHolOoCg8x3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWbsIKml9sm45GGydhspNZt4sa2vjKWWNsfN3tgl6/Q=;
 b=SE23s8qeJem56yz0Rm9q+VXt6oT4ckPxxiLhCiZ40RZ9hH/C66jDEkG/IzTgjWh48l9aN8mXHLR9ON3sKyLfyMwE+WAMsdkbEuz5eQjm9Ub08uTQdX2EKzv2W7iGm7pacIOlqmpTxu6SyYxtMWFRaOhtioFnh5Q4OhELGheHyhVAPvPx+Z3PgBTc5I59P2lP6K4mUzzHv0jfsxmbN+2runwuRBUF0mOEh2TeJzmlpITpmyn5MuPwZsDZIBEWKuxgb4Govy0tvPwvntUcmIJeSSp1Ry0A1tI8QqvRyr1ZcUQfMKSFZkUAstfzPpei+3MOfJM5cmi/gTXaYYS2vgWfPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:52:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:52:54 +0000
Message-ID: <24f7f86c-7f2f-47d2-aa99-a1b255e576f7@siemens.com>
Date: Thu, 2 Oct 2025 09:52:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip103
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 16469ce3-8c41-46c0-f40c-08de0188b18c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWZpZlRYV1Y2RWovRnhVcktEeHZ6RkpxYjZFVDl1WTY5aG1PUk1aYkhmZEdP?=
 =?utf-8?B?blNKZHZVMm9EWFF0d0c5Q1hDN0IrOE1uMDk5cFU2Uldaa2wxZk9IVzUzL2hU?=
 =?utf-8?B?TndZUW1MRW5QRjZweFM4Nm1PbG9JOHVvY0VGRkZobkJ6MUFJd0ZVZmJtY2xz?=
 =?utf-8?B?SnhIWlhZeS9kdlRGRTdITFBWZVR5eUtMZjdCd1JzS2R0bDFiNWFNRCthQzk1?=
 =?utf-8?B?QUNNKzlGN0oweXVRSkRVemhOZ3R6L2RMaXUxMEk2NXdTU08zRGhmcHZ2bUNE?=
 =?utf-8?B?MklOOStqQjVobVk1U0tJQlN6cS9UNTd0d0ZvRUV4SUZPVzVuaFF2VnFNdCtw?=
 =?utf-8?B?clhBRDNPZ3hCZWJNRUtaWmxOZ3UzMDZKamUvaTF1UGFTd1F2bXhubFh0QmdM?=
 =?utf-8?B?ckozLzlXMjh1Um1CZVYxaW14Y2VFaFRwcnprd2dwM1liS2NVSFJiS0FRaUoz?=
 =?utf-8?B?bU9CSTFlNGtacW9YbllVdTJUcmtRcDVKdjRpVjVsRU1wcEt6YnlSTUJDbDF3?=
 =?utf-8?B?Sy8rbGw3QnVtRnk1Mjc2RWx4RllQMm9KeWRCUGJGeDUvSnVvMzFhY0lQWE1p?=
 =?utf-8?B?TFpRcEFnSW5qVXl3dDRZQUpaM3N3RjcyaVI0Qmx4S00vM21LcHlzWXRkNks5?=
 =?utf-8?B?QmdIOHY5WVZabW9oYmtmd1ZTUjkybEo1cm9nbHdQOGV2dUR5NUZWeng4bGkx?=
 =?utf-8?B?eFlWU01sS0tmb3lXMTk3cG9FZUc1azk1T2pVVmZYcWQ1Q0NJMEFGT29ndDEr?=
 =?utf-8?B?aW1rcUNObi95RHErcXl2M3VTcXcxdU5JK0FRWXV1b2Z6SFJZY2hweElkMXFE?=
 =?utf-8?B?YVFDSEhhU3RxYkFNa2VCSWxIN2NxQithVUxhNFZCTUdOL0hxdnZRNVpVNng2?=
 =?utf-8?B?Y3NXQ3FDc1RXNmJEMUxDcE5EdU9vUzZJNW1XWUtUZ3lvYzNBRFBScE1xVnJJ?=
 =?utf-8?B?TnRzcXM5M093bmxVbThkNVZ3NkZzZC9lWmdRNUZhWkpzc1ZhQ3NCUUZLdGRs?=
 =?utf-8?B?Ym54YU9zNHpVaXFCQnhlWlRUK3AraGhoMlRUYlRML3VsSDQyTkc1ekRsWXhN?=
 =?utf-8?B?UVNhRmVlTlFDQ2lPbjNWaTJBbEVzUHR1WFUzTlZ4NytheWowWTZqSE1sN2Mv?=
 =?utf-8?B?L3RhditkWVREdEtOQzlqNE1XNHlxT2xNb2hRR0VpejZ4L1l2ODhSWklFSHg4?=
 =?utf-8?B?VlE3Mm51Mm1sRm1hdUN3OVlYNzcwRSt2WDdoWUpRT0tNbmFYTFZJeDdwa1Ba?=
 =?utf-8?B?WE85RE9hcGUwdndhQjZ0ME1TZWNXaW1nQ2ZPc2hESHMyZ2pwVmdRcFZwWTRP?=
 =?utf-8?B?UUR4Yld0Sk1qVFA5TVIzcFZ5b09uNzE4UTdDMUVpMWFta3Jzb2dXWnkxVVVD?=
 =?utf-8?B?SWFXQXVhZHppb1ZzSjdZREZ0YUFWQTJ5b2JsS0RGQVpBQkgzRmh2S2dZa2gv?=
 =?utf-8?B?dGZ1L0F3YzdLc1gxRDRQWkg4ckpwKzRPQUNhM0dXd0hYclVMaXV2VU54Wmsr?=
 =?utf-8?B?RVRDR2NpR2dwQ2FwQWY5dnJaRTgvUkY1U3R5SUxGWmhyOGRJODduc0Y4UTdn?=
 =?utf-8?B?L3BoYkJGMllxNGlBdjF4bkw4RXY0VmtibEwrQkZYdHJPSFB0MlZzbWo1MWd4?=
 =?utf-8?B?algrRXY1SkxIRGtDVUg2UWJFTUl1bGFiMzFvellyQkNnc3hJQjBWU2lGMUVy?=
 =?utf-8?B?S2dtd0xJZFBwanR0VHFNQzRSanorQ1RvcU5DNXkwaTBOaExxYjE3b2lOL1pk?=
 =?utf-8?B?cUMrbkR6UHg3VmUxZTk5eWVaTld2YlFTOWs2d1FjWXppMmZ4Rzh0c3ZHSDli?=
 =?utf-8?B?TFEvVEtndllJMmVWRXFxbnBlUll3WDF2UlE1OFNrRVZoVXF6aG96SFlMUm5P?=
 =?utf-8?B?eDB2L3V2TVlBcngvdEFWRS9pNkViRE5XVVdkKzBUTnpGcW1qdWxhc00zK21M?=
 =?utf-8?Q?vAMcaoQfN/ic1KebiH7yzECkKazfgM5V?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0NPd2VCUUdqUWw4YWFwR3dOa1RnMmJUMTNXYmJSMDFKN0FaNXAyUmJlRW5M?=
 =?utf-8?B?citUdDBvdHJHekh0VWdoWE9GbUZPVzRYcDBWOExyVTE0Yys1aHZRYkkvYWFW?=
 =?utf-8?B?aytCaDJML0RNMzlzdHlqb3FaTEZ2WGN5bnp2V2gwSEtNOGU4V0RYMDVMVVFh?=
 =?utf-8?B?UXpZWFVZS1N3aWVSTzNweHVoRm14TW5tZElJWU9WYUJ3SDdaODFDcG5wWjhS?=
 =?utf-8?B?akFqdjVGZ1pubTBMNlBBaU9RdVBUTFBHR2FoSmJRbDhyQUhUUjF0RmpraWtP?=
 =?utf-8?B?cm5rREdSeGZyS2lEc2w1OTJtS3JmMnhQbSttaStPTzdaNlVSYXU0aXhiaUlR?=
 =?utf-8?B?UCtTTk1iRlFjdjhpaUNSdUs1VThsWUp4NVJaa0hIN2tleGxGZm1MN09rL0Ix?=
 =?utf-8?B?aTI2MmlSZEJMcFdVeUxkTURCdExhalFSeC9kbmJLZkxlUG5naDc5UEIzQ1Y0?=
 =?utf-8?B?dms5OUgzTjFkdG84QUg1MlV6VUxQU2xJM0pJMG5IdWFtSS95MFczS2xYZVJD?=
 =?utf-8?B?bm9CQ2tuaHA3N1h0amdVbk9yM2laNGdpSjRRRDhDMzBYazJCajh2UVgzMkZs?=
 =?utf-8?B?V0YvNy91QVNXVVQyYTlNMTFpb3BDa2lCY00xUTl1bFdKWVd1U2lYendkZkI4?=
 =?utf-8?B?bHdoaHMrbkZ5WVArcFVXbzd4L1g3NG1POERHejZwUUF6KzY5cXNPaTROZmNG?=
 =?utf-8?B?SGVMZ21uWkdNWmpQSjJ1cXVuWmFtN3M0a0ZOTFlITkg3VTZSaXBCamFCRmZU?=
 =?utf-8?B?c201TzFHMFVLby96aUlqVW5uSnV6endKWHpIWUV2eld3TEowbDByYmpSVFRL?=
 =?utf-8?B?OHYrM3hUeDduQ1lWMG8xeGpoVENjV0xHSlhpTTl2b2tEelV2NmVQeDRDdjZi?=
 =?utf-8?B?bVp1eDdPaXQ4ek1iNWdLeTl2dllCL1crN25SUXN5MUpuM1NsRmFZMUR4WjNZ?=
 =?utf-8?B?KzRmSmpFY3ZBWEV4YUJBUjBTMHlMamQ5SEp6R2lPTXptQ05BeVRadVQ5SEd6?=
 =?utf-8?B?UDRuR2s2SnFwdU42MnB4U2xSblVOZnlsWXhERkVkYmltRkhEYTM1amQwajQx?=
 =?utf-8?B?ck5hOFZtcTA1MEdSQzA2Z0lHb245aGNvbDJQV2J5a2UreW9aSnpDUUU1RW5N?=
 =?utf-8?B?a2hoVDFnYWcrKzN6N3lkS1BSTm9MSFFRVTl6ZlRXTDdTQkJhR3lEK1kvWGpR?=
 =?utf-8?B?bS85ZE5rSVFuVVJWT3E2RmRvYmNlc3E4MlVZelh2ZFkxaDhzcGpBY2NPUkg1?=
 =?utf-8?B?S3AwWlRsd292Z2UxeHZzVGZ2V2RCZ00wWXQ3dndkenBRdjdpRDNnck9hamlr?=
 =?utf-8?B?Z3N2dDFYRnVwQmYvMVlqSHRMUk9UeEw0cXBWQ0V3Y2JrOXhhNEFNNjBMQld6?=
 =?utf-8?B?eWxyTlZTY3pCcUMrcnNOQ09JNHBNeHNuSEExcnhSL3o5ekdOSVNYMXRJVDFj?=
 =?utf-8?B?QkIxbUZCNlEyRUpOTk5xcWFBZzNBMXhYK0dLNTdzWUVLcVNhYkYybUp4anRn?=
 =?utf-8?B?Z21SalQ2OWdMUURoNlJmYzRzUFVZOG5DWGhsYkxGTkU4TjhTQlVQek9KV1E3?=
 =?utf-8?B?V3RLL1Q4RmtZVUNtQVQ0VCt1UGEycllic1A5aXh1QldoeHppbzFpSWplejFj?=
 =?utf-8?B?VnFKbWZ5bldKMnhHaE0zdDZOcWJwc1lHWnBjeS9HVGxHWHRGMCs2L2tOLzBR?=
 =?utf-8?B?cnNLbW5LdGRnMnp2OTFWRUswRWhiaTYxR2JSRFdOcElMQlF5TGNvd3VuTk1q?=
 =?utf-8?B?TWY3MXl0N0RYakZzcmFHWGZ4M3pYalUwQ3F3cGtrQWJkL0FxT1R5THhaQW03?=
 =?utf-8?B?VnpUdUJLMXNEdXIweUYySDZUUlR0Uk1rZmdaRW9lVDVqVVgvTmxHVnpCVUVO?=
 =?utf-8?B?UmJCOFdBdk1DdmU3MXdrSXphUUlQdGN0bm9HeVB1bE9GSW14ZUF0OXpQSk1Z?=
 =?utf-8?B?cVp1d3JReEd6SlFrUlRzRGNFRHRES0d0elg0R0FuVFgvN1M5QTFuU3pQdmtB?=
 =?utf-8?B?RWFxY2o3TTNyN3hOalNXMU9YZDUrNkRrKytmd3pXWDJrS21SYk53SUNRKzZR?=
 =?utf-8?B?RUIzNmluemFIaW5ZaDZiZ205aGg1OSs0U2UwYjJVMXJMdmpuMUkwMzViVXRZ?=
 =?utf-8?Q?g+xSS2WDqgPF87G2/09kYJGWV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16469ce3-8c41-46c0-f40c-08de0188b18c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:52:54.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dUbxzXgm0uklEfPOW4gYtYdcHB6rv/3c1jt3nph+vGDoRSC38Rcpfxpzn7+OJLmJWuvh8MM5B5GE72roM+SGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 07:53:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20156

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.4.302-cip102.bb => linux-cip_4.4.302-cip103.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip102.bb => linux-cip_4.4.302-cip103.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip102.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip103.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip102.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip103.bb
index 6a58804f..5f4d1e34 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip102.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip103.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1dfeb1f5efd4636a652acf1d42fde90f39c1381269b23d91697b5b3dfac20666"
+SRC_URI[sha256sum] = "a7ec74eb70cd953f1c10e031ffd34cc1e0e30942b684a331225fb7991d95b829"
-- 
2.51.0

