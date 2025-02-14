Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BCC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 13:00:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web11.20419.1739538045994324221
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 05:00:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Hsou7g5k;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7d/k45sNyoAYrfQbJI8Za7mNKuW8p6TT8Ln5i97ZqgSbf+1eLk+aKfQozS/bUy/Dh1VrJZiOohpSPCv2NlST4VZrqeI1AGuk3hl3pvMdGxWOEKaadrmunD7jMTk2O5t+lifi5OGZ1Oq08AR3uqirxfSfZzu/WpHiPw90k5jSGGkCVuwB9C1Njh0EJ7Ql3uND+xp8tQufNceUNFRM7wpyGO0mzpN3/LuvBq/jYUclSqEq2Tx95rS5Kc+T2+z0BLC6Vdlv+oPMUU37FeaxtV9Qpik2dTbRkj4hx1nchk3/IH+Ao1czTcSqeOEPQeUO/VR0Z9/+rIBdPV4gmoOWFxpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2pijR/rJFodnR8+fteCXmP6r3LlyvM/OLaltcb6dx0=;
 b=T32ve4IffmrinnhOoSZxiYD6xx85FmWH5gF3Et+qfCzg/Q2t4B8eBYFUVzI7NCWnQvQx8q4NxqJ7iULXsMJd0VzVG71yqjUqIDszw4v+fbHB04pvt2FZL9n6ODDvN1clZcRAfMppoSZVhcbSLs2fj5Y3U9l1xhM0QRbBKEgKG+MPdWZqgsyr7T2RrJ3YNw1suYU99UNbfDWxfWj2HUBMuxOkYl5yAtoThkoAjUjNUttMTylnIxbGmAs0H7g+SrRhVxQZr5wI6ucOHh8C/2kEnrTfHTtqhTLbB+khdZGVFSVz+TIWunMQ3wCdkXSx3peOEbctWP/s5x8zome77fsrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2pijR/rJFodnR8+fteCXmP6r3LlyvM/OLaltcb6dx0=;
 b=Hsou7g5k+aAqkPZ5cuPnAEWak8eqG8otXvAyibQMNPN1YoYmSgeJjhSw/1yT5LwxWSk6HEOa84o7c0toZ2c0lbFPhVQqDrD7RGzHgtM0q3UhiGo+li0JxTmncFtz5bY6g8JhpVTjhc+luN7TNQCm85h+UXXGwakPo9l4df7IrhUaa9e9E//Cez0lN/RjqD6sKuNcHt35XQabMJ/53I8EIB7T9MgHndJOBwnPubCkuvCPFMtctpwhZE8b3eDHpcg8K5TK5Fj5+QJ1NqtgBlOl000b37distoMQJFSLUPe8/V8Vq8kIrQSu20jTWfLPt5XwQY3hFH4Ujz9SDJI7T8XNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Fri, 14 Feb
 2025 13:00:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 13:00:42 +0000
Message-ID: <5cb6dbb3-5061-44ce-b5a3-0f8f0f0504b7@siemens.com>
Date: Fri, 14 Feb 2025 14:00:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/2] wic(ebg): add support to add verity env
 to cmdline
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
 <e01b7d05-1be3-4189-a8d2-2efbc2733bf9@siemens.com>
 <5cfefb4ab19187342c1252d4261d2366e0f437bc.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5cfefb4ab19187342c1252d4261d2366e0f437bc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3346:EE_
X-MS-Office365-Filtering-Correlation-Id: e008ed56-4d4c-40ee-ea8a-08dd4cf796b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TTZNbHZKUEYyL2x2ck5IY0UvRGRaNm0yYms3ZjgwNmUyOG5wOE5KZVowZzFJ?=
 =?utf-8?B?NnA0T25qcHZwaUY3dWtVd1VDOTFYUUp2VWh2cmZuUWNQeWNWOVhCVEZ5SVZL?=
 =?utf-8?B?ZjRiZjg4WDNpS2ZCL2ZuamwwZ21pNFh2TjVFRlppVTFDWXJvR0lFZVdIVWxQ?=
 =?utf-8?B?SytYdVRoSTdWRUN0eXRNT1lseVNiQVdTUVd6RUowRU8rY3ByUThNWlFseDA4?=
 =?utf-8?B?c3ZvK2dCWEUzcHBJeEJMRjgySXhMVGFWZ2dKSmtPdFlhejk4Q1V5MVdrTTlu?=
 =?utf-8?B?Z09XajZVd1lvazhzenErVHFib3hLU1dRb2xGbTdQY0kvd3JZeXRuUmlWaS9a?=
 =?utf-8?B?WituV1ZGa1ZIRlVDRnViMUY4Vk93QUxuR1JwbHYxZGpZZjVtWUpxelBxR0li?=
 =?utf-8?B?SEJOSHhRbUhhVERLb0RJcExhd1h1NFh1d1BFUGszV3hyenVjZDZISlZFTUpC?=
 =?utf-8?B?QUx3alV0OTlIQWpJRm1Rd1p1aHNVQzRSTGZ2aDU1Mjc2Y1dBNXFoS2NyVkMy?=
 =?utf-8?B?cTB4cGFaTGl1SkhhYk15SmtwQUY2a01GSUdLVThZdFZTSWowMmFLM2tGYjhZ?=
 =?utf-8?B?YUVIZmFNc3Q1Uyt5S1NzVDZYUVJKMld6QmlLUkZJRjNUNUplQnNmNjdrbnNC?=
 =?utf-8?B?QmJPZXlQZmlPNFdLVmpxMURQRFJiRWxkRWpjVTlMbEVrUVlkUlk3RVZTVXdv?=
 =?utf-8?B?cE9vM2JvTTBlc2Y1dVE2TWFnemlkR3pWcGZGOVJPRDJwU1Uwdk1abW03NEtt?=
 =?utf-8?B?UlJxNjJLVkxtT00wcHBndTVIQ0VUbER5VW12eHY0bmRJQ0dmdXJvVVQ1cFIx?=
 =?utf-8?B?djlMcWRXMlRPZTA2TDZPV2txelB6YTVOcVVabmVKYU5CL09EV2dtaFROQmk2?=
 =?utf-8?B?aWwrbWhRSExQYmNiVXdpdzdIYURTVitKSFJiOWRNdmZJeVpiRFQyZW15ZXVa?=
 =?utf-8?B?WGlqa1ljcVp1SzY3THRZaHpoT1lCTVRHZVJXbStwbHpMcW9aMTF1VWRSYW5M?=
 =?utf-8?B?LzM1aFg1dU5Pd0FHQnlFQ2drcGsvaldSWWh6a1pNeUQ4TTlyWGp5WWcyL1Rl?=
 =?utf-8?B?NHQ1ZnVmU3B4cWxUcUpEUWkvNUFSWDNuZlpJWXFxd05IL2QrTGdVY3Roem51?=
 =?utf-8?B?cGtHUjAzblFGbkRUY3h2aUpPU0tGWFkrWVZYQTBZYnFXZlUwWkkzOXh4TmlM?=
 =?utf-8?B?OSt3UmxNQUJKOHE4K0pyVG8zOS9UdUdNWFpXenhFVHNSZEI3cnhJYWtWL3NS?=
 =?utf-8?B?OVRINXNPWWcyUTczWFRnWjJmWjhQM0Mvcm1wbmNsOUpia1o3RUpFbittWGtr?=
 =?utf-8?B?dTJodlY4TkthSG1MSy93cGhEbGZkQ2VSaXVXck9EY3NXVitRb1JXMGpqYmZs?=
 =?utf-8?B?b2NaZHlqWTBOVnlpSEJIaXp5b1N4Q3dRcTZhckk0ZHVCOWZ4cUMrV1ZuV1Vl?=
 =?utf-8?B?VGNFSXJiSXMzU0k3dXluTnlpVytJNHdNT2NtdmM5VVZIajU5empVUHJCR01t?=
 =?utf-8?B?VHMwdGNQS2NnVDNtS3RKSmVoejNqaC9tZ1pvRlkrTjl5VlJNeWxramh3a1pu?=
 =?utf-8?B?cUVLVEdsSTdCeGYrOUp1WC9oTXpXQTlNRWtPbjZ0eUNuVU9LOStnWTNndVhT?=
 =?utf-8?B?bHpiOXlSWXpTbVFBc0VlUnVSc3NrenJTSkZCa01LYzU1ak5WNUlpakRaR3hB?=
 =?utf-8?B?K0t6eU4raW5VNzBPVStQYll3MmZYVnFXeHZxajVIaUl3cHFxT1l3bnNsTjl6?=
 =?utf-8?B?Q1VzeG9QQi9oa2VhMk1rOFh6S3NxWDVKMEFlb3phaWs5Qmhoak1kcnQ0VUFG?=
 =?utf-8?B?K0NxR2ZHdjl0TXhlNDdVQjM0d0EzUEVGSUNKN3gzcG1KcmtWR3hmWFFZYnNP?=
 =?utf-8?Q?dDcqThwixPQvq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGJLRnpRc2FLSkRPOU51WTNmY1JvSDBUYXZoWkZNbW1hakg5cks4U1NsN002?=
 =?utf-8?B?Sm4wcmd1THZIOXVXS0hQS3UvUGxOcDhYL3g4dCtNN2toZHVLaTliZUNhbENV?=
 =?utf-8?B?Nk0vSjhrZkl6L3hvUFFaYjk2VWU5ZUc1Q1BhaUdqSURuRFBxNDlTNXFZL2F3?=
 =?utf-8?B?SmhOUzcxWmE2QmhwWmZpa3dFL3h2VHEyeUZtY3hmam0yTlJOWk02RXhmYWJj?=
 =?utf-8?B?NkRCNHNDcklFMnFSUk9sL1pFTElOaW5rOUJkSFh0aEI5dzhUU24wZ0J6ckQw?=
 =?utf-8?B?c0pDKytJaGtTV09Hc0JoOGFRbitQL05TKzMyWnFTdFNBY2dxYzRScS9jdjR6?=
 =?utf-8?B?dmZIRWxtN2RLSzZLNXZ6VWErOVo0ZW1KM2VyZmVCR3NFa3hmQWRSL215VVBw?=
 =?utf-8?B?MzZ3K3JoZURFU2hvaDF3K2NPd0Z0b0VsWXVoMi9OK2tYMk5sVzF6WVhsaWdt?=
 =?utf-8?B?U0tKSlZTWE9SMUJCTFZoaklrY1o3ekNlazFYd01QanlqdjhjcDFKb2VKczdS?=
 =?utf-8?B?YTNPbEtNOFlLdVZnc0N2MkR1VEFhM3RXcm5IQVh1dlY0T0xpb0o1MGNmRmhF?=
 =?utf-8?B?b29GTnc1Vmh1OE5ZSmRjbEttNkY2TU1sN3dQLzNDL24vM3FFRGo2akViYUlH?=
 =?utf-8?B?OUFPZVJWT3BPUHpWc2N5R01lOG56cmZqUStBTHM4TnVUVG5SZzlFWERzekhJ?=
 =?utf-8?B?VHlTeHpHejBkN0NiRTFVZWxrcnlob2Jod1RZRWJKcDVEU3QwdFQrYTl3S3NX?=
 =?utf-8?B?cEJmUlROQ1E1aFl6dHJpWFg1UjlqQ01sMTE4Q1lPZXBzcnhIS1h0bVY0U2FT?=
 =?utf-8?B?SFczQTVMdEdxU0V3THBSTmJqNVBWTWpXTHlkMmRZYUJwL0hMQzI0QnpqVDJk?=
 =?utf-8?B?RkQ2NGVBbjdMN2tsQ2RNVkl6cjVXOHhWcVRMb25WVkk0SHBqSHdub1hZVTZC?=
 =?utf-8?B?Z3lkSkE5UzdWWEZiVEpEamFKWGx5akN0NTYydmY1WHllblF2RUExUHVkR1Fj?=
 =?utf-8?B?VGd2T00yYnFmOTRMRzZzTVBTdXgzQmhCdndKdjE3K1B5bWMzSlAxYkJGRTE4?=
 =?utf-8?B?VUw1KzZua0NPVWxueVhuWGQzaEJrc1RZTGU0UDdoN1pjU2crUnBoRWVvdEdF?=
 =?utf-8?B?RDZuTFQrbk5Xenh1Si91RlJOQitLV252OHJ3aEhjZlI2Q3pDa0RrYWZMcm9r?=
 =?utf-8?B?U3k4YmJUVWhwOGVQWDRsVWJaZUdxQWxxRzUzcVJHckNQQ2NmUy9VMmJYcXZo?=
 =?utf-8?B?U0FvTEd3dCtMem5CUEU3dXN1aTNjc1p5amdUVWdWcVo1aStsSkRLVWNDR2pl?=
 =?utf-8?B?MjRQY215OGJUTWdYay84aGxtZG0vNUZZaU5pU0w1YVgrRHlLRml6Nlc4Uk5X?=
 =?utf-8?B?Tm9haG5hOERuNEVCdnFBWUE2T0ZpdkJYZ21OS1hLeXN6WG1zMUhod3RSK2Qz?=
 =?utf-8?B?Qm8rMVJoMTJtRENhTU5FdFRGUXNROEdZM2traitOdjlmRjAySlk1QjRucjdk?=
 =?utf-8?B?Q0VpT1Y2WmFrWmJYZnhqTGJ5Sjc5bzJQRlJhSFdCVHdwSFlRZjAxT0NTY0hu?=
 =?utf-8?B?UkdZTDlNdTBPUk14eS85N0tTSzZBRndJYTR2R2dKTEFPSkdrbUNSb3hBb1lt?=
 =?utf-8?B?S1VRUlhhajIvYlpKSDBLSWpDWklwc2NxeUsvc0wwTTZ1Z1N6dnJKRHZja2Z3?=
 =?utf-8?B?TEZQQUJPcWt4eFZ6OURnNEtCSC9KTDY2Z1dsNXZCUWd3RytUNks1TFlhMW14?=
 =?utf-8?B?SmQ1R3RMWldFSTE0QkFqT3NjQ2NZbTlnTzd0SE5pRUNxNzl3ekFra1BOK0pW?=
 =?utf-8?B?cGpVNHd0OVVUNEFicis0YW1sS1FhcTBqT0M5WDR2eDc5UEltQ042aEhOWTU4?=
 =?utf-8?B?T1lGSTdHdzVrMEw1c1dRRk0zbHBaakNvY2w1T25YY08vamZtQms4Vm9SK2RW?=
 =?utf-8?B?YXBiZGswb2ZTRGE2WDhjZXgraHo3OUd1YVZwM1pod1V1V0VGTTZJcVA2YlM1?=
 =?utf-8?B?QXNOUUtwK2thcHIwNGMwRFkrbFVYbEpjRU55MkR2SGpHTmNRaFJnV3VEdzlK?=
 =?utf-8?B?S0cyWHMvSitpeHpwMUtBb2xzYlJZS0lxVU9YRmJQRmJET3RZZDE5N0NXOEtr?=
 =?utf-8?B?cEIvZDJ4bDByYkZObytxZDFLaDloTWRwV2NNTVBJbFJQTld2OE8zSEZDZEJC?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e008ed56-4d4c-40ee-ea8a-08dd4cf796b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:00:42.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl046qTuvyiACOMF7MOjSO7aDricY0g0Y2CybDR1zL93WYbohaUZAH8ZOxWB2+xGpTzLNyCgNzSB3JYpim52/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 13:00:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17845

On 14.02.25 13:46, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Fri, 2025-02-14 at 13:30 +0100, Jan Kiszka wrote:
>> On 14.02.25 13:23, Felix Moessbauer wrote:
>>> Passing the verity data via the initrd has proven problematic, as
>>> this
>>> requires to rebuild the initrd on each (bitwise) change of the
>>> verity
>>> container. For use cases with not bit-by-bit reproducible rootfs
>>> this
>>> can lead to verity hash inconsistencies as the bitbake state
>>> diverges
>>> from the file state in case some task artifacts are taken from the
>>> SState cache. Further, the build time is prolonged as on every
>>> rootfs
>>> change also the initfs needs to be rebuild (also polluting the
>>> SState
>>> cache with not-reusable entries).
>>
>> Then let's fix the reproducibility issues. This change here destroys
>> a
>> pattern we are also using for abrootfs. I'm not a fan of doing things
>> differently only for verify.
> 
> I prefer to fix it for A/B rootfs as well (actually I was not aware of
> this). Also systemd envisions to not have any hard-coded rootfs data in
> the initrd.

I'm open for any consistent optimizations - but there is nothing to
"fix" here as he current mechanism is working correctly.

> 
> As of today, we cannot assume that all downstream layers have a bit-by-
> bit reproducible rootfs.

That is not our task here. Generating non-reproducible artifacts while
relying on caching is playing with fire, and the earlier people see
that, the better in fact. So, don't use that as motivation for this
*optimization*, and we may rather think about how to install a proper
warning in isar upstream.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

