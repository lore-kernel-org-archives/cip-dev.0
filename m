Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FFAC25B79
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:22:45 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web11.224.1715962964508344587
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 09:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sZON46cX;
 spf=pass (domain: siemens.com, ip: 40.107.104.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7hkoaRrq7GUf5ZSepUxur6gqBfQxq6BnqBiEfLS+MvO1W6kSNqWlAUQCkRTFS7kycWVWvFlabnUxUNhPltSzl3/NIrHdvSYmIx5CeU+svcOpn0ImhWbUPVrRfXrznzvJpXFd+pVjxMVDjMQJA6sTSHav/sCp653V3c+VTHpfuSx07qR+dJRgvJTe4HyA8vivpArKaAtH7bB6J+pp8eECqegmybcTZEaA2BPl+taoU35sPd6y9t8ZGji9839HJqH7aDJczXP43Ldz4H8vU7m5YewiYojS2L85zOuUKF458w38JJuV4IzJxB1Pm+SqGxjTqTd9VF4mySIiJDmS5/7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XAMreM3JT9xFKu5rLB0I79msFi5+or6zWOju+HqnUI=;
 b=H77wmsQUAuZEe8ymrgOU7/zQ7+w8YbN4WdsqCEeahyOnatg0QkjT2jFecYWapV1kRiqBY3Lh5NYZuNH3FwtgKiySvjqPRjjC/sdgTx+r9nZugB1OkwhoLuQ2tsK/Ff9mXso5zthoweNMswFG21bml9wqt7PSS0ABLXWEYMEeRCU1Ri2/w9OVIVXcZl2lfczxK1n9soDVzr0GVzdolK8GQRWJa6vNC8buj3v0+WlRxLbRRIIb0hyu4UV0rDMOinauBQZoY2yBhu+nVqEvVWi7Nbc/TY+P+zUA+CD0Ov2r0If5uxuiTheTpNx+y3QdEz4n0ANsdBiljGtBd6+G2Xbz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XAMreM3JT9xFKu5rLB0I79msFi5+or6zWOju+HqnUI=;
 b=sZON46cXhL+UE7/Af7SYQAoH2v+MPRSSTW9u8R171eTtvpw8N2luLwDvkPX46kNk4a5puAuLBOCrYfhaeiUPj5X/GSrsgr3c7VAVp6PVMRw38f3GsKDr96QKj4Bvxb7Ztw8s2W2wn7+9S5uEQgZgz+89/vtIjYEsMbZvuWiQjQvJc0yRX4Vasi+Lo3Fg+MlheZXjBU+Oq0OHB9GY0bo96RVpTCnAwszTdahVVzf4FaOdERN8eqsucNd/hExDS1+i5JfHfu6GaJXOylZg7XLpDG/TsLvq3QlVHK7uSXol1rmAy1e9ohT9mWCOF+ADwYdKcgEaGtXKlQYpF4VNsecY4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 16:22:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:22:41 +0000
Message-ID: <f55caaaf-7bcb-49f9-8f85-3e132861e49c@siemens.com>
Date: Fri, 17 May 2024 18:22:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip87-rt49
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:610:119::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: b0480c53-65b2-4a97-88d1-08dc768d9369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T3BNcURJT0ZLWitNK3QxSm4wQkZKMEc1ODVDc1RLcDV2NUhJVm1UYzJJd0wz?=
 =?utf-8?B?NTBrT25SREIreHBDeDNEalRrdFJETGhsSHkwVnRLSUtzYXpvb0hPVmtud3A0?=
 =?utf-8?B?L21xeEhuTU0vdTNEQmN3aHdRSTQ1TFhnTGJCUjBxS21uT2ZQM0xpOUdlMUVK?=
 =?utf-8?B?aFFTN3NDWW12SzByTUlmZlBPRjQ0SExJajlpcmhqRi9PYXZ0cXllQ2Rhampx?=
 =?utf-8?B?RkM0aExWODVHZFpWL2liL0hBNG1GSnByWmV0dXlZYnFXRFQxandNRlkvTDdG?=
 =?utf-8?B?anh5NXRQVXVHcEVWNkZOVXoxQjhaQmhJV29uWCtIVlh2UW41RllvZmM1aVlY?=
 =?utf-8?B?N0hnNUdRMXRJdUtHZ3RLNGZENGVta0Fhc3ZkcklYcCtWbGk5WVdXZ0liTVpF?=
 =?utf-8?B?MTF4SlRJZ0pkYmp2OVpPNlRuNzREYWlOSGdFZ2h1UE1EclNiVmliT2V1ai9M?=
 =?utf-8?B?bk9mM3l6TzRSMy9sQk1KaEFJNjZaRzdVeEZxWjFPYlV4SE5ZOUJOa3pjc29q?=
 =?utf-8?B?akFQc3FKclNGekVySDNBVW5UVVJ3c3FRUnlYWXFnbVRLMndWSDVmZ3J3NERK?=
 =?utf-8?B?dkxCZURJRE5scS9NRlRubGEybFhtRkRlbDZJeHVWQzFKUjNocmdHbWJ2bFhm?=
 =?utf-8?B?RWc4MUJNa3RGTHIvbnFreWJtb3V6TEszOVBxVnI2U0dtNHVYNnNHQWFYNTBI?=
 =?utf-8?B?R0o4MHFyS3F1S3IyRVVnUnczWkhNeVp2VkpxdkxCVFhUL3J6Ung5dUVJVnZw?=
 =?utf-8?B?RkVqUi9FbjFIeXFQTnFZRGNzczZOa1JvcVRZMEpIMVdBcTMySDJOM0VSZzRp?=
 =?utf-8?B?MWpJQmJzRzJlUXpnQlBHRVg0ek5hRG5BYlpoTm1QZzY0bFdjdnFyUmRzT3VL?=
 =?utf-8?B?bXMxODl3czdiY3l5ZmlML3NDVFJTckRUNWVOTERZZFQreHpkL3hCcHFsZzdO?=
 =?utf-8?B?U2lNR20waFZSZE5LRkFaYngwdTBIaXFZWGRRMkwxajRnZjZkZmluRnl2QU1w?=
 =?utf-8?B?V3ByTUhwYlFsb01ualN0TS9TUVJjcWhuL1ZjTkk5OUM2MXMxbW9pOTJkT2FS?=
 =?utf-8?B?QXZkbHFYM0hKOUFSVlRVcTZIQjRrTzcxYTdiSWdlZmg5OG1LVnVRcHRoUVdJ?=
 =?utf-8?B?TXYvUUtYOTlBaHdTWmNYZ0JQNWxPdnAydFdzTGgxS0o0ZHRtTU4xV1R3N2xq?=
 =?utf-8?B?bzhDQ2RDaW5Ga0g0OHZrY2djRERPeTZycHMzcnREL0h5SkUraGZUT2JveTRp?=
 =?utf-8?B?TXIxalFUWU0yQnNnSnlCRVMwbEdKSEx4S2xhUEI4YktCQmVkSTJpZ3lNNi9Y?=
 =?utf-8?B?a1Z1THFhNkVnTmFFcnVJVnVENC83aGJEVVlUSFYvbXY1eFo1dnZvZ2FSL3dj?=
 =?utf-8?B?K3k2R000bDRBWmQ3N2xiQ1ZlRlNVa1J4VjFyWmE0Ly81Q25iakxXMTRSWi9M?=
 =?utf-8?B?b0R6RmxpM29uUUxMbWJYWjQ4R3k2LzE0Q0NSUFFTTEhwVUxBbzNEeXFvczd5?=
 =?utf-8?B?RzByd2pNRlM3Z0o5WVl3RlNncHZEckNBQng2SlZ5enhTbHNleW1KWGpnTVB1?=
 =?utf-8?B?L2VvSDBzZ2kvazVkSzFqQW5RVFFoaE9Fdy9TbWs3OEJpMjhmMnlaaEhrbnpy?=
 =?utf-8?B?N0o1VXhpWkVRSlpuWTRWVUJYQmJyMjhDQ3JrQ2RtMmVGbGlUWXdEQVZ2dlkr?=
 =?utf-8?B?UG5IRHFDaGZkL1dKeVZsbjd1L0YxeUtSYjdmRk5FYWViVGpLZHJoaTB3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmQ5aTk4WVNZNnh6clAwMk5sRWkvRmR3YkpUOStDM1RKQkU0ejNzamdQYWh5?=
 =?utf-8?B?K1hIWmxTY3lqUWJ6UVNSM1p1UEtjb0luZmowNTRYSTAwdU1vcC9Cd0p0Sjgx?=
 =?utf-8?B?T082UHJja3JUSzlsaHpDL0FqWEpOVHBuMjBxcjdJVElrSmxzWXltVjJENG1w?=
 =?utf-8?B?NkVzUExuemIvbGNRMjBPZVRSMks1VC9oYnJXZzNuWS8zY0N5TFFmWm9Wc3h3?=
 =?utf-8?B?WjFGeE1NeWo0Sjc2ZUhxQ1hjYlhQaHphWVJCUGFwdVBqN2w2eDY4LzRmL1ZC?=
 =?utf-8?B?anJDL2NqNkMyMFVaS05pazlKLzV2M0FrK3Voak1OSTJFYTd3ZHVHZXBFa3RZ?=
 =?utf-8?B?VGpQZTNvY1czZUVhczVCVFdWTFlSeUZzVTlDNkFoUTZ3bDNRL3grVlhUNUxO?=
 =?utf-8?B?eGowbXZPUlozYjFXbW82d1JRNHVPaEJMblFacVNFVHZOTzFEa2hjMDRUcEFQ?=
 =?utf-8?B?V0gvSlNMdnBuN1dvdTMrazhrN0ozbXFIQUc5QS80OHR3VCtLQkVudmkvOVph?=
 =?utf-8?B?c05jdFdKYW1vU2dMRkJYdGhNSWNXN2hxMTJwbWdKQXFXVlF4STU0ZGt2RExm?=
 =?utf-8?B?VFJHT1ZpcC93emUwRCt5ZHJ4UFYyM1FaK3kxNWRDK1I4LzdXckIxYUl4UklR?=
 =?utf-8?B?RGpSWklNUXk3RmJ2em1GeFdNMHBjOUZNV1hDTlRWWE9FaDh2VmFzS3hxcHpy?=
 =?utf-8?B?Smw3YVZZU2FBVGZpaVJwQUVHSEQ0cFN2SmRYVnEvc1R4TzhOM1Q5WDJuZGxH?=
 =?utf-8?B?V2xFMU05WW9ZcW9URFZMZkdwUjFqVWN3ZGJuS3lrRExUR05xOHBkUXRCaFpS?=
 =?utf-8?B?cUVEV1VucTFqUThnRTVSSzlJbmhpNmdqMk5YT20wMFFMUmt2eXUwUFQxbmFk?=
 =?utf-8?B?NHZrSkdVdytnOVhHRkVIUjUxKzhyRVZIRys2SDArN2lvYXZ0b1pabE9tRUF2?=
 =?utf-8?B?VllXNmtxTElvSDBCMzM5eTZjZklDREozQXpPUkh6emo3eHR0a1k1ZStKN0l0?=
 =?utf-8?B?YklPdXJ1R0tOMXREN21UL2t5STBicjlxQUxaQ1VPNFRyNHgrRG9PazB6d0ZV?=
 =?utf-8?B?UDRra0VVbEtLdmNMT3hPbWU0S1dGb1dmeE40elQwd1VBQ0I0YTZpK3BJUHJB?=
 =?utf-8?B?UlkwWHhUSlh5WUdWREc2SU9WdjVNMHB4ck05M3FBc0RPZmdNWGlUcVFydFh4?=
 =?utf-8?B?WkRlQzRXZW1oVzhlZ01YazdrVkpPbEN6d0dwd2RQVklDTGk2bXN0OHNKSXR0?=
 =?utf-8?B?REtmNEtsMm5vdjBETHB1Q08rb0ljOVI2M1hpWkhIME1GVWNCbU5ML2YvakZF?=
 =?utf-8?B?SVNCWnk4cWdIdEU1cGFJQk1oWG8rZVpQVUMrOGJ0K2cwODlRcWdSSmJKUUZ6?=
 =?utf-8?B?NXc0bWwvczFpZExvWUNac2hNSTZGakovMENmRFpjQ2ppSlRnbjNsWDJRSXhN?=
 =?utf-8?B?UFhseG1raTFpc2dML1RYOTRLZ2JWOEQvN0l0TGNnczdNa0ZBbW9oSTZQYlNI?=
 =?utf-8?B?dVphTldKUzFibWNBZm1NZnhPaVUvbE51SGxXNkZTSkNxcGk4SjdNc3doOXlJ?=
 =?utf-8?B?SmYzZzFLOXg1N2dkMzRMdjFoUEtpYis4ZWZUMlJ6Z1hBTXpmeGhxUVo1MFlK?=
 =?utf-8?B?MGRLUEx0cWFwaVNVM1FHMzc0ZjA5ZE9UMWxBeHRsTER4UEJ1TWg1TE83TUN5?=
 =?utf-8?B?S3JZSzhpWERkQmNySVQ4dU1HTkk3SFd3cjhwcHlXU0wwWU90bGNjTEtoZC91?=
 =?utf-8?B?TUVhdUY3a2ExUzFkWWlJTzN5bDB3RUNUVnBLS3BpWk56NE1ibUk3M1BaNDJr?=
 =?utf-8?B?aTl4TmIrVjJyckxyeWlPL20zWk5XV3dYdW1FV3laZm4xNEo4OW1ZVW1Namx4?=
 =?utf-8?B?TnNUSnZDeS8rL3RYVjkxS0FRa0hZclNaaW1TTm0yeGZyRnVmazZ2Sm5Qei9o?=
 =?utf-8?B?d0orOFNFWXl1dWxwSDNqcFBaZWYrRGNMK3BHQitRcjhFKzVzaEYyd1ZxdEhQ?=
 =?utf-8?B?cVFFckRZaE00NVRSTjVkRDRiVno0bTVRM3NLVHFHN2EzOU9oQUJHa3JSaFcv?=
 =?utf-8?B?eG9NMDFvenBGa1JBY3hZZjJNSjZKWjlGVWRiQW1aTzNzdFRObnRIOFdLVGNw?=
 =?utf-8?B?LzkwUnFBMVVraFpPZDhWL0ZwR2ZsN09zaDE1NnI0WDl1bE15WC96NjVBMGpR?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0480c53-65b2-4a97-88d1-08dc768d9369
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:22:41.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cHNyXrEhxsmYg0WtQoD2PQ+iqurhSJBxc1nHFnK2zSdY+vld7bdsjZDUfFTtdJ0EhWZaHi5FuDCPfGuREZGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7754
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 16:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15914

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip85-rt48.bb => linux-cip-rt_4.4.302-cip87-rt49.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip85-rt48.bb => linux-cip-rt_4.4.302-cip87-rt49.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb
index 9d4b57a8..d3a8708f 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip87-rt49.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "bdcbd4906a6a3869e2aede255de89c798f7eb9fb1d48426c94378f431b294e8b"
+SRC_URI[sha256sum] = "13309301a5d85f829f4b1736d9ab3137fb191da1dd7e1c80630764cb7be59c21"
-- 
2.35.3

