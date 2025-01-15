Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A44C02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 18:21:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.13])
 by mx.groups.io with SMTP id smtpd.web10.28967.1736965310799039826
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jan 2025 10:21:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ch5MCyPP;
 spf=pass (domain: siemens.com, ip: 52.101.67.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp1DSztMYrlhs7ZC13fRF/KdekOHbPrQzqorj5LI6H26pG0dJKJUuKaUEx6qNn9ro4cEWSQ/bxD4b6ZFTPSaQT5k1/fszF6RWj6a4dzThjgZ1+ZhsguOjLLbWP+zXA2rFilsGUlbcmg8UqSoF4FcaEnji6nlLed3BkXfxM8Dx2Ats+cdFkb9HfOTNsH780zqlxWmwhHc/aN89pNt42nfkTLxVL+wlw9ROjJ6FIVa4dSNACaWvlSrXNC9T8AjOk58AbK6LBTzvT+xY9gxUqa5tjM0emoAhIY3QDG+E04u2mcT5xnE6obZMM6y6rU7GFj/M0Ej1q5sj7d8RAR8oRu/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSFGe6HOOSmPAKX6VR/B3H82m4KSRoSAaG1ytXjYljM=;
 b=CoBNIqZAdcGSUQ3icxNfC2yhQUTao9fgrdKl3B4LUv8QMAZOHyY1cJNgRjBR3UqAIOmWWllrH+WjdYS8ZgypkEjtiBEPJR1AyuTmTUV8Y3qzniCS9e2FJH6EW3QKkTV7GtG7pJdiT2GdSS/D+ccJlARoe2D51w/089kTI2qD8rhBD0OyhY08pn2DeYLrP98Dwovjcz/5Rbwlrh8AtOcBSdSZiEXUVtwA4griQPU+8BAOtKT89M9cVIWgcnobdYUuabF8ikQ5uG6g1u91aRFaDPBSqxwNN+raXN0wHu2eIdGbjltHpJUKfhneV+g+rhGMVztmBILxiMOxgia/cejFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSFGe6HOOSmPAKX6VR/B3H82m4KSRoSAaG1ytXjYljM=;
 b=Ch5MCyPPr9YVfLa+FezzQl8Y2E33GIIKgzU8Qqygo+CbJol60d+89ktvVjT81qaqrXxti+lzzkriKGj4WmWDDG3ZWI4mhW/0eWvsXKdN23N/IHxZCFyQAs/22Z7ebALwETRk1HrjIHhp5qvCtyOvwmZFjsC1YDF2xS099po/GK/oGXpHreY2U0Vgfu2jAW4gDhumDmrVAwgG90aVMUgCpugJ8uW6Vcb36n9aY5iSWi6txAlUiXltAyBBhQggK2lPNVgerRtXr+VVA2ZTuUoNPAn4A1IqXQHJwc4CC9ydIpzWCgUUWpxYnV9CAMhXyENVLTwjY2MCju9b970pzOzW3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Wed, 15 Jan
 2025 18:21:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 18:21:47 +0000
Message-ID: <1086822b-1cd7-4424-a1d3-5ae0ce8371ad@siemens.com>
Date: Wed, 15 Jan 2025 19:21:46 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][RFC][PATCH] Add security policy
Content-Language: en-US
Cc: Christian Storm <christian.storm@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f31549d-bef5-4aed-436e-08dd3591791e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWZMRTM5M3N5ajlSTXFQZEprWkthUUdPU2hLeUhZZDNuKzl6b2RYN2VEb0hW?=
 =?utf-8?B?Z21tUXNpODhydm9ua1FsbGtBVk0ydW84bmt6ZTBYb2xpL3MzUjRwdm5PTmtq?=
 =?utf-8?B?dWR2Q3h3KzBFMEwzQ1FXeGN5b0J3Z1ZuVk9VckN4KzdubkN6YWVVelJpVVVt?=
 =?utf-8?B?cUQvV1A0TDVUeGFhU2ZsVFZXb1o4MXhaWHFpYTYvWS9TMkROY3NZUENGZm5i?=
 =?utf-8?B?WXJTSVBUbkRGcDBiaWRTTXhBcFVyM0hVYkx0R0k3Z1UzZUpXaWFVVjE2U0Jn?=
 =?utf-8?B?bHFwUGwyeHMrSUVHcDRQSzkzbEVEbklXZUxCTGpGZHhaR0FUZUF2UXE4b21k?=
 =?utf-8?B?YWozMkNKdXVKSnBMbUQrdGtQRVlkeHNvbHYza3oxU3ZDSS9BY0hIQTRNWkJC?=
 =?utf-8?B?bks3RlBoaEViVlp6SVpKUXRoTkdWV0NFWTJCSC9mb1NGbURhSVZKMEFwcFpK?=
 =?utf-8?B?RWc3cGgxdFRoSEtlc2xvdFRoQy9XbC93SFZpd3hBMTNGNk1aMTlQZ3Ivd0hq?=
 =?utf-8?B?QVR2WENoRVVWSkNXNmZyU2Z6WURIR3JaZzRlNFh0VmlHU2FMaExJS0U1VHNa?=
 =?utf-8?B?ZTA4WWp3ZlVMSGdUWEZNQzEyQlVxZ2RPMkVUM2F6RG9IVVlsMGtJZ3dwMzBl?=
 =?utf-8?B?eXkxK1VQdlcyVXJERXFRM1lKM1dOc1pVQitTdjJaMC9JaUMwTXF1dC9YSmtD?=
 =?utf-8?B?N1ZvV3RlckJNNUVvVno2c2lqQmJxQjM0c0VSQm9WcG9DL0ZOZXAwRExENHFW?=
 =?utf-8?B?NlpGb20xVm1nWENvK1RPOWNmN3JxYkV5TlRUTnphelVsZE5xT2xsZWQvUFB1?=
 =?utf-8?B?SVBqZVBMTmZXRS9NTWZ3T25vajVKZG9WemJ2cWlQWEFPSXRxSHVYWGVuR1Bv?=
 =?utf-8?B?eDdCelJoZ0lzR251dUppNytyZ2M4bmFlWE9EN2hWeEF3V25FOFdTcUVJQlA4?=
 =?utf-8?B?c3VvaVNkTktnc0hyUEF0RG9xVDlPTHE1RGp4NGVwcUN4TjFpaFhXK1B0OW90?=
 =?utf-8?B?cGpZRC83RERZQ3pPZkZMZjZWd0ZpQkFhd3VUekhEdnBVdWwzWm1qTnM0K2lq?=
 =?utf-8?B?Y3FLc0RzZm5UR2svbm01NVVyRWQyNnZNUHJyVDlYRFEyNUNocGtnT3QwZXhN?=
 =?utf-8?B?T0FlSTNyalpUV0VpM0dTd1laUUdDYlFTa0syM3k5aGZWaUs3M0FCWnhxUUV4?=
 =?utf-8?B?ZDhteDJHa3FTMVR1dnFmN1FYMTJzdGFHcXV2cVNYek13OG9nK3VSNmpudXBZ?=
 =?utf-8?B?RTVOZ3FRNDVNOFdlY3h5YmRGUW9kdnFMSVJyNDQ5MmlwRTRtS0cxUHh2azZQ?=
 =?utf-8?B?QmNVQVI4OUZUZEE2U2JxVCtqV0hnREhCaTBKM2JKR1dvQnExMzRqTmh4UHRr?=
 =?utf-8?B?L1o3cjRHZjlMTmxVaFNmR0xpR1E2bnJ1b1hSQnhpZlE5MjdmQ290Q1dRMEht?=
 =?utf-8?B?WVVLM0xmc0p4ZitXVDFwRmI5dkxoWlZrak5kYXRjdEtteEdlRC9SYTNRejhK?=
 =?utf-8?B?S1RzQTVOVE5QcXB0Yjg5MmY2VzhmTU9kVVA2MmpNTHZudFBXNEVPbmE5bHJR?=
 =?utf-8?B?K29qQitGYUdvZW5iczUyZkhDOGlkbEt0SWlvajMwQnlCMmsreFJDbWZHYXk3?=
 =?utf-8?B?dmV3bXZ3VnQ2ZG0waWx0WlZacE1oRkNGK3VOd0pZNmJLanhDVFlubTE4VGJ1?=
 =?utf-8?B?S3hob3RrdWlobG1ZbmZKd1U2aGU4WDdZSC9TU1JiQjZjWXZLelRQWk1kWVRI?=
 =?utf-8?B?TzRQbTkwcm92SE95Z3diaUVqRUtBS0xoUVU3RVJsMnpmWlBLZzJ1eENFNjR5?=
 =?utf-8?B?dXNmVFIxOThMVzVVSnhLQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q09LRVd1dnhLaW1kdUR3UjVSK3RnZlpNenNWWDF3OVA0a3JjSTJFbGFZYVky?=
 =?utf-8?B?RGpycERQUVNZRFZQRkF6QzdXNCs0MUZxZE5namdja1NNckRsWTVvK29ySjI1?=
 =?utf-8?B?dC92TDU1OUVtREVhMm5oK0wyZkdUVEp6MkVtMktRS3VKaG9wZWY5SmR1SXZh?=
 =?utf-8?B?WHROUFB1cmg4RjdBT3U3K1JvSmFRdTZ2TzBFdnBtOUFDWGYySTV5dkIxazFn?=
 =?utf-8?B?QUtkOWpHUlNrRFd2VmV5QndyK0VYcHdENXRlZWs2ZFpYNTBiQklRNDhCc0Va?=
 =?utf-8?B?R0tMOXdWc3g1NGlvdnM5WllyR1dUZmxEYVpSTFdza3FVd3duMEZIbGtwNFZW?=
 =?utf-8?B?Ni96bk5sRFkrSHhqRzJnc0RWZzVSM29TZkN3emh6VEZYR1JpeCtTZ09kL3U5?=
 =?utf-8?B?VGluVWkwSCt6Z200VUlHN3FxU0tNd3FrUmMvWHhpTFRxZE5SWTFiNUZGOGJ6?=
 =?utf-8?B?cDVlWjZReEJTdnVyRnBqOHRCMzVBbDJiZ3J5d1p1VUY3RVpGTVRLMldWUTY0?=
 =?utf-8?B?Sk81S0hKc3JSbmdoODQwNEpNaE5COTVhbVRpN1FLaEp5MmtEUytDdFZyeWhY?=
 =?utf-8?B?clduTTRjT0piV2F4Z2NJdW5zb3JJR1ZhdVUvZktLVlh0VVVBQ0VYemJTWlRC?=
 =?utf-8?B?VURhcWdGcnVOMmtnL1NmYnAyU216LzVEUDMvaXZSWjlxOFRGNjFpb3ZRaENP?=
 =?utf-8?B?MzV2VXpnbitvb3plV3Zrc3BOS2pnTE5Pako5ZGdGamNmb290bHFFZ0ZiWXpM?=
 =?utf-8?B?UEZtMHJ5VzdzRDl4Q1VBZzFwcnc0NnRuMDBiRHBCcnlGN3dXMTJRRVFlUlR5?=
 =?utf-8?B?RisyeFpXMDVYUiswRWduOGFkRUdrUkVxaTltZ2dUZ0tFRTl5SDR5cXpCMlNp?=
 =?utf-8?B?QzBCZUZlbkx2MldoajI2cmwxTkhUUTJMV3M5NVE1dzJTd3RRVUkvK3pGQ2d5?=
 =?utf-8?B?RWNYL3hLbVhmSm9xOXFDaGNTaStnc2NSRGZBWUFTaHJsQjAySGdrSngzWDFz?=
 =?utf-8?B?RkVPOFppdGQyWjZVU0l2ay9UczVJRnh4WURVaVl6eEcwd0FoMTUwZzJLNkRI?=
 =?utf-8?B?aktveGQyWTJveDZ2MExhZjRKYlZRWjVTOGZMTGhhK283Tm5xRkxEMGVsUE5s?=
 =?utf-8?B?QUtIN0RoR2JyYlZKUGdEOHk2TlRFNktjY0g2Rmg3K0tPQ2djYXJoUlNpUmRG?=
 =?utf-8?B?cUsyODNRRlgwcW1HU1hrUmR6Qm1yT1JNUWQyOFJCZkVTd3ZxbS91a25GMXpj?=
 =?utf-8?B?UmVWcHZGVWtwcFRrTjJJcG9vS3pRU0pDWkhqakUwcElNZVlONTdvNGJlZW0y?=
 =?utf-8?B?WkNFamNEMGcxVTYvTjA0OVJuK28xZldOL1BDSEUzN0VZNkN5LzdKVkFRK2Er?=
 =?utf-8?B?amlSQm5xMVBXK0pMNkxBbGR6blEzb3lwTEJNeG1SOEFUSGFLc29ONi9uZ0FH?=
 =?utf-8?B?SlVFSkdGNk1ibEthUXdiUjJuZFFJTHpBQ04zQ05oaGVnbzQyM1VYWWZ5OGNq?=
 =?utf-8?B?SXFxZW5ZTFNoaXAvQS9EalBzaEFHelRNb2RmRWdWZFFCdEVKRzQ5aTd5a3lF?=
 =?utf-8?B?dlByQUtva1c0OTBFdE5zMDRkY1orM0RDMERCT0p1V2NQVnlGUG5GUTJhaTRH?=
 =?utf-8?B?RnNTM3JxVFQ4THFOMnN6cnhYN1NrMXZFcko0cnJKeXJVRVdhRFRXOUlIanJs?=
 =?utf-8?B?cWdxWStCcGNaVmx3MEFTeXdISWJTZ251TFBLMHp6MmplVUhCWm9qenhyN3hX?=
 =?utf-8?B?aEJkOXQwWGdPVUNwcjBsZG15c2t1OFpOYm55WFFaQTRjb2VRTWNPa1A4dk5F?=
 =?utf-8?B?Y3J0Nm9wMyt6anVxSDRnQWpFQVIxUld6ekp5ajhZR3RrY2Vqd0lyRDhpZE8y?=
 =?utf-8?B?bDFvQ1pqMjdseXBUTE9DSHhsbkJZcnVycFFpUTFXNkFsdzREdEJzaTRocFlu?=
 =?utf-8?B?dDFNTUlZa3Uzek9CQThZUDUrQTJqWXZsTUFnU0NsYldJdEZraUdpZWlKQ3Ux?=
 =?utf-8?B?VlBtUXErR0grMjIvTFRXOXpIZkNEaGthSmI0SFJ1bHErQWE5elBMSlhRbDB5?=
 =?utf-8?B?cEdFSUFGSHd0ZUZScTlubFh5UEk3T0tSSWRRZlpaTHNUOEo1REVKWk41Nkg1?=
 =?utf-8?B?b25XTEhySGhPN3E1NjV1K08vazR4eDlpWlJSMmhXQkVQNW43WjY5enpZbEVQ?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31549d-bef5-4aed-436e-08dd3591791e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 18:21:47.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSvZCShZm7W1rkiRq9fXbnodZx0P8XR1u/kGPLxqyw6Hu/E+Wr4f9EHJtElp/3cCbtrsiphZk39uoyuuCSKltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 18:21:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17540

From: Jan Kiszka <jan.kiszka@siemens.com>

Try to define isar-cip-core's security context and what is considered in
scope. Furthermore define the reporting process options and our handling
of reports.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Kazu, are you fine with being a second direct contact? At least as long 
as we do not know your successor as WG chair.

There is one TODO left: reference to a reporting procedure for our CIP 
kernel. The kernel WG will discuss this soon.

@all: Please provide feedback if this is accurate and sufficient. I 
won't merge this soon, at least not before the next CIP Core WG and TSC 
meetings.

 SECURITY.md | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 00000000..60619a7d
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,47 @@
+# Security Policy
+
+The Civil Infrastructure Project takes the security of its code seriously. If
+you think you have found a security vulnerability, please read the next
+sections and follow the instructions to report your finding.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyond
+what it was originally designed and also secured for. Therefore, we describe
+here how the CIP Core integration layer is currently expected to be used in
+security-sensitive scenarios and what aspects are covered elsewhere.
+
+The isar-cip-core layer provides several recipes and configurations to build
+Debian packages, and to install and configure them to create bootable images.
+Not all configurations have security in scope, and downstream integrations may
+further modify the security properties of isar-cip-core deliverables. The CIP
+project considers security bugs in scope for addressing via isar-cip-core:
+
+ - issues in on-device logic generated by recipes or scripts
+   (e.g. initramfs hooks)
+ - issues imported via hard-coded versions of external dependencies
+   (e.g. SWUpdate)
+ - incomplete, incorrect or misleading integration guidelines for
+   security-sensitive recipes and configurations
+
+Not in scope are:
+
+ - issues of upstream Debian packages (please report to Debian directly)
+ - issues of CIP kernels (handled via the CIP kernel process, TODO:reference!)
+
+However as there remain grey areas, do not hesitate to open a report for
+isar-cip-core if you are unsure whether a finding is or is not in scope for
+this project. CIP maintainers will help clarifying the situation then.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public channel
+(mailing list, gitlab issue etc.). Instead, create a **confidential** issue via
+https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/new?issue[confidential]=true
+or contact jan.kiszka@siemens.com and kazuhiro3.hayashi@toshiba.co.jp via email
+directly. Please provide a detailed description of the issue, the steps to
+reproduce it, the affected versions and, if already available, a proposal for a
+fix. You should receive a response within 5 working days. If the issue is
+confirmed as a vulnerability by us, we will request a CVE for it, publish a
+security advisory via the project's channels and give credits for your report
+if desired. This project follows a 90 day disclosure timeline.
-- 
2.43.0

