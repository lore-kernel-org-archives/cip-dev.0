Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64BBCCFA05
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 11:50:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7769.1762343410176779137
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 03:50:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uMO/p/bu;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srAvQFasNCghii+KDp90Jj5qC4OGk0eM2aWclzA3dHpoJRPZxkdpmGG68Srfm/ow7IC2g2WcR9RaRTOYLIEDBBy/5Oh6d6Isis2bHxwRXgYxOxE8rcgJQhW/4iQ/XAXFNFEr02qnDFJo/18qoCwK+Zo7qZEiwTzUk79jEE0PIYkJd0KHlR76NhG9y9+o6Zh3BwLAZWFLUmvPmfq95fI6k+T9ME4mXnj5UR5ci1q/lMJHocbaY3hrhlKzx2yy9jiqcQ+NOMol0mUG39MCPPueO/3ktr0e7MGhIOV9Z5P64R1oFk0tB5RSyLtHMACHzM9nsatirHgatFMpQvposQ4GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2oQHeHDsRH8gxbirmA8zgRUZyuM9aK3c0eMS0GbMt8=;
 b=Aco8WAWlWD1LxZBnf9NRSqHLtx8/jMYq8bSvBQeQ0Emc9PzLM4bAkL7/bHcd/e3ukIijwP3kr2tX3qFXZAfiWi3nBHW7i/K+Ebm0C65hb8ewpz2EBX3Ht4Py8Bgd16IS9hpmOt8BinLMWuytPM8+LBDdlkLH3aLJUl+Yjk0iw6nPzH4BnQLUMl7JJagkZVI0AFkm4IXaOxfZ+eAoMvYQrEtmM2A3fs4aFfqYZWU+p5CUuqPdQQDdd2deTYeyxa18BAEGopBA2zYWph+6h6x3b2i6Fniq3m0bUD0RBWWWSG6IqDeCU3bgkUIuqEpo4I57TukNRikJLelQS9lJJ1QDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2oQHeHDsRH8gxbirmA8zgRUZyuM9aK3c0eMS0GbMt8=;
 b=uMO/p/buTOKgoBa7+shLqev24WBCXdeR/rje0fKpMxGyJ4Az09K9bsmncdZlB5Oqc9mkE+QmzQb9MZmbVAomE2oS1ilaBfsFthPkRcK9P/Cv9KXxRN9CxRg4SxURcDEtGVkbOCsXk3fIgMQB7eykce/fwjOp2XrW/laXCxH0MbpAcVPjZoiMz1D7W+JbYrGyxjbzff8YCTkk2t7T2m8R+s0yJJrRvnG34xuu5DPIuDgQbc0MtBCE9OsuQYXwsOqEusQwNKnD8697Ua0qcEah1sfJNZxmmfG641jvceHtLdGqKAcblp6EneXWYb4OysCvwl9pR+7it7skFgPd6YoXUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:50:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 11:50:08 +0000
Message-ID: <f12d51db-5c35-4df8-82f3-9dc3ee6ca9c7@siemens.com>
Date: Wed, 5 Nov 2025 12:50:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ltp: Update to 20250930 release
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f239b2-b107-4aa8-172d-08de1c61779d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WkY3VURML2JvSTVlUDhZbmVsMjhGMHNnU1YxRkU3TW53b3BxVVZQSjljNGFp?=
 =?utf-8?B?Vi9BZlpzazhSVUE2NksrZ3IyOTFHVlZCRHBMOU1tK0gvbTQxekRZbDdSS3pz?=
 =?utf-8?B?ZjVpeE1wbTVSakd5WmJQelBZL0YzUGs2d1UwK1V1cmN6cmZOZ3BiRld4YVJN?=
 =?utf-8?B?ZEdSb2w1N2J1SE1YZVNlazB4TG4vb3k3VmZ3NlpaK3lYeExzcHo2VnJkY09m?=
 =?utf-8?B?K1pPeUVpYWw3ZGp0SlJjTzZxWUx6OU1VbnlLSHhkT25VTjNxaGk5QWdLNmN5?=
 =?utf-8?B?amtud1VLTHNrSWVYUEtDbHpTY0xrVkc5ZWgyWWFMUCtBZEFpRDkwbGwrQnMx?=
 =?utf-8?B?ZXhoVUxGSUs5NlBnYXo1Q3RGeGZsS1EzRkpGRC8rQkEwMjd6VFRQSWFrWG1y?=
 =?utf-8?B?Nk5vdU9GengzSWl4UlZFUmwvcTJta2I3ampFcWE0K3BzQy94K2lWVzZoaUg1?=
 =?utf-8?B?a3FUZ2lKT05OS2h3ZkdCOWJDNmlLRmFKcXpNWW9zSU4yVGxrQ0Q5U1ovOTZL?=
 =?utf-8?B?bGljRldGMTI0ZGtnd0R5T2RPQisreFdsWC9VU2Y3TlJWR1lJL1I3WkhOa20w?=
 =?utf-8?B?bGVlVldzaHhCdUQ2U25pSXkrb3FMWGtvU1NzZVBiVGJWWkkwaGRua1J0dGY2?=
 =?utf-8?B?dmJNUXhFMGcvS2dRWGVwMkkwUFRzQzdDT0oycEdKZkhna3Fxd0hWdUx5QytI?=
 =?utf-8?B?VVJPdzNza3VRbWpyaUF0bHZPZm96SEJ5NHJnamFYU3k0NHdlbTVzeUF0SzZ3?=
 =?utf-8?B?U1RyM0IxNUJjVDNIczFhRlZudkdZMVlUd1ltUHBiQXg3bldsMTc5TVdQeHdX?=
 =?utf-8?B?UlZ4aEhYMWVaM3llYlE1S0d2MXpKTXkvTnhpMnRzRDVBT1lzS3dzWVcxSXJK?=
 =?utf-8?B?dXlxOHpzU0s4Nzl1RGdMbXFDeGxoMFZ2bzh2bkpqTzA3MUdMWUtHZ3VIcHlY?=
 =?utf-8?B?S3JvNlFlRTVrQlZJZlp6cFJEVTk1cUF0VEhVREVhdG5YM2t4THNGaGovc24y?=
 =?utf-8?B?SlM4cVg2WTF6ak56UUcxazlNZjlWNFdOeXBDNUlOaVBQSUhrampwRXYzcGVy?=
 =?utf-8?B?Y29Rb09GR0k4YnJBQU5KNG8ybzh5N25wc3I2VXA1Vk55YXN2aHZPTStrVEdF?=
 =?utf-8?B?bG1CWXlpY1dsYXEwV0tmY1o0dXRBL21DOFlsWW1QUzlxZWtLOVFPaXBWbVB3?=
 =?utf-8?B?a2hkUXhETnlMUUxqbmRiWnd6eHpRdkxiQ3RvbnRJRnJqVEYxaTF3eFNjd1U1?=
 =?utf-8?B?cUtoU3ZyYkN1M1hmRUVOYi9ZaXV3TmdYYmM0eXk4WlE1aDhHdUhrb2k5R3dx?=
 =?utf-8?B?aGIxdEpZYWtmT3YzbE1iQ00vYjNyRkhkWWFDdktzVlBqMHVqQUxMZTlZd2d4?=
 =?utf-8?B?REIybDg1Z1NneERzN3g4TzJkT1JxUzVTWEU4QnpyMjNxWTY1dVkweE9vSy96?=
 =?utf-8?B?QzdrZXVROERuaXFodzZSTGo0eU04QnVuZ3VET1Q1emFob0tPM0g5b2xCRGJC?=
 =?utf-8?B?b0gwU3NKbFpabnMrK1N3TmMrTFZYTDRjNmZLTDRQZ0gxVFhiaHVIeEloUXQy?=
 =?utf-8?B?QWNBbVR2cy9kOW5NU1ZwQW92R1Z4TWxiMXhuNzNrRnIvS25lZmJwZHpmUmJ2?=
 =?utf-8?B?a3habmFzNVhRbTdCK0ZXVnJhYjVlUVlQTmVJUzZOaTZHOG1TMFhtVkpxaTls?=
 =?utf-8?B?cmxJYU1xYkhqQyt0WTFZTXBhcVJXcEVRQWFvenBMT21wYktyMXp0akdOZjgr?=
 =?utf-8?B?SUsrcWtUMzFmYnIwODEzYjNNLzIvM1N0T2tsYytSMVZxdjN5Rm1aVnJZdFNG?=
 =?utf-8?B?ODM2YmFsN0hoTFVoaDRWUDg5L1lJTGxrZDVUdzJDMTE1S3o0K1pMWDdBUWNR?=
 =?utf-8?B?WUpVYldRbG52S3dUa3NMeCtJV2JDZ0I2cnRtdkt2d3ZSamQ4OWhtR0JTOHJy?=
 =?utf-8?Q?NI94wZcK0XIKzmqFoyPI6d8GfOhtuFuA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1QzV0YxUlozbURmdWJXa0d4bzBIdjRIYWQ2RFh5cEJuZjVFZVlvdWtiV0Y5?=
 =?utf-8?B?dWdRcnNPTG1Pd1Z3UkFCaWJKbElwKytkRGZtcVZkUG0ya05SYS9OZjZBdzJy?=
 =?utf-8?B?czBpTTFqQUR6ck96Y016VWJtaWQxZWpmSGZNK1BHMEZJZHdPejhFNlAvYnZP?=
 =?utf-8?B?aGRmL2NmbGJwSW4vUS9yUlp3ZXNNL25JWUk1ZWhGRGtWejI0cjFKTTlOdkps?=
 =?utf-8?B?V0wyb1NNNFd5L1U0SkcwSysvR2RaNW9YTEhiZTFsK21sZmlESUNRRzltbndE?=
 =?utf-8?B?U1VSVVI3aEtjWVZ3bUNlR21VOTlZMGp5eDZlSERXaGZrbzVRU0VESXJDMlJH?=
 =?utf-8?B?VHJsQUFqdkhSUWw2MU1LRElCNDFhM1FoS1I0T0JZY0ptdUltWVhBdTUxYUZy?=
 =?utf-8?B?c0c1dm15RmpKWUVSNnNlKzRicE1NRFlPNnkrc2hkdlhPQTBXQkoyLzJ6MDdO?=
 =?utf-8?B?SWtJUC82aDJjdlpDZWxwUld6NDdjYTdwOE0vN0lNclVqT0tmREFPR0xvZkJJ?=
 =?utf-8?B?REtjZTd5S0crNXdydkNRRDJ6L3VQNWMwWnNvV281cTM1Z3UzbWlYb25xakI3?=
 =?utf-8?B?UTRXcVZwbENOMjNTM2o1WFVsYWRZMXJRQ25wZDFtRFU1MHVRcmdSUlNoQTIv?=
 =?utf-8?B?TFRQcGxhRnltcFIxSS9RejdQOHcrTHlDTEdnV0hETVFEMkhraTQ1dHJjR2FN?=
 =?utf-8?B?TlpESW1ROHZLSGZJV2RULzBSVUR4TWFramR1bStQYk9nVThFZXZzRDVmMG1h?=
 =?utf-8?B?a1FlTnZkb3RDLzQ3NnhRTGloTnZwK2JTRzZmek83UjdrTld4MWJrNUU1YzIv?=
 =?utf-8?B?V2lqbjBCUXpKSUR0WXJIcW94bnZBSldBSitXYms0U09TNE1YWWRPdk5pZi9G?=
 =?utf-8?B?bHBaRFA0WENIcTRORUtlZTlra01OSk5hUTFwMWp1Y0N6MjRBMHZ6MVY2WEdo?=
 =?utf-8?B?aVhwQ1BldFhiemNIOUhmZ1FnY2pRR1BjdVJWenZmcWNTMG5wQTBDN0MwS1cv?=
 =?utf-8?B?TitJZ3hGeWpDQXI1ZFVBVVVmcVhlSVlYT2dtMEl5VDk4UGNhTXNLWHQ1Z3Jj?=
 =?utf-8?B?bmZNWUUxaGFOdi9VUGM1a01QZFF1eDVIQXROdmxNTXRxeEE4VEJRK09iMEFh?=
 =?utf-8?B?Y0NUdjgzQk1VWTBrdHZEUWRpYVhjVWxTNHZoRCtSa2U2UGxpdlptb3MxTUZa?=
 =?utf-8?B?NVk4YjB6RUJhUG5XZGdNWE9kSlBMcktXNFV5N1lJWTRxc1NiNEc4SjVISExN?=
 =?utf-8?B?ZzUwakJ6TTFZL0NzTjZRL1QwVVYyYm5EamNHMkN1Q0ZOSjh3VXlwY01SVCsv?=
 =?utf-8?B?dHVsUC8vcjBvMzl4alNyQWNuNDZBUTFGVmZlL0F5VnpuMExBWTljRElqR29k?=
 =?utf-8?B?eXk4ZmlpRHpscStpYjkrenllZkNaMUFHMVByRmRRQkxVczJ4RjR1dGJ5c3lj?=
 =?utf-8?B?OFNtMjFTRjlRTW5TWEx4SVFpYTVZOG05VjNkZzVxWTEwVmVQWWpoMGVwclVZ?=
 =?utf-8?B?R1ZSVmI3b2tIL1liRlhWeDNDUm9KNlo1NlkxRlRDUGMrNjhlSFVaUnh0bXNq?=
 =?utf-8?B?YXhYd1dMSmVrWWdWVUFYTHA5SEQ4aUdoMlhxbzRaODAvNzh5STkzeVF2SHU4?=
 =?utf-8?B?YTRaNXJSM0pabHhHM2taSlY0WVUrRnN2MXNkUG5kQW8rQzZrZTlicGoxcG5l?=
 =?utf-8?B?UHlSbWNSMHBZWCtkUVRPNDcvYXZRSjcrRUl0aEU1U083Y2VUTXdDM0JmWHFD?=
 =?utf-8?B?Z2hZeEZNUE56Q1lmTXVWTW5lbmRhT2xiVDVwMVlYUmdqMjl3d1JEQ3krTm9S?=
 =?utf-8?B?bldlN1JoOWduRGpZdGZPY0wwRGxFUnEvK2pkRkk1bFFPNngvRUQwSDJPRi9B?=
 =?utf-8?B?aEw3cllIWTY3ZkZ3clNKc2ZlZ2orNDI1L1ZmS2hsNmlicExzOHoyN2grVmxq?=
 =?utf-8?B?SGFsOWVrVFNyc1RpK0dmUHdrVk0yYktLN3d1Nlp3Ly9SMFoxMGFiZ05hL2N2?=
 =?utf-8?B?UVdwdWZRcVNIU0VjU2N4N05kQnROQlNhamEzSm0wa1Z0d2p1U3dGMmZsUlE3?=
 =?utf-8?B?ZXFob2p5YzNRTVljY011OFkrVXVxNE04TENIaWxJaDZySFBTemNxM1RwZnJh?=
 =?utf-8?B?a2I1M2xWMUdKQXhoQVpxak50eDgvUk9JUVZGd3AyRFNWVlJJakdrR2tyK2Jm?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f239b2-b107-4aa8-172d-08de1c61779d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:50:07.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8D8MFKHQZQuxZcjEx6/StutpgP0Ddgquc0RoJAqyRkKE9bEfhzfhM+p8RVGEs7io5Fs4t2XowOCeEq6SPao9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 11:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20363

From: Jan Kiszka <jan.kiszka@siemens.com>

Just housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb}        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} (56%)

diff --git a/recipes-core/ltp/ltp-full_20250530.bb b/recipes-core/ltp/ltp-full_20250930.bb
similarity index 56%
rename from recipes-core/ltp/ltp-full_20250530.bb
rename to recipes-core/ltp/ltp-full_20250930.bb
index 553b58db..d57e875e 100644
--- a/recipes-core/ltp/ltp-full_20250530.bb
+++ b/recipes-core/ltp/ltp-full_20250930.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"
+SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
-- 
2.51.0

