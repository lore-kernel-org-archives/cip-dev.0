Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA80C3ABD6
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 05:01:56 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.47])
 by mx.groups.io with SMTP id smtpd.web11.14302.1726549311553205129
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 22:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O5XMGi6Q;
 spf=pass (domain: siemens.com, ip: 40.107.104.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDF5N2tS2Ru9K1OMYiuIIXqPW5JxRA2qT9dp6iRYPf/QY4i9f09jARmKYhSTKPbFP6elwRcFebOVfy3TIEuPv0fKfA350GKyP5HM+0fnLBrIP7nMSkilVSL0tmGXpMlRwupDqHjtCOyqLTUGQHbLp1/gzmsSvzTJ0tdb7atVdcma16GL53VIoneQx2jbU9h6eFRFILjEgYzvcQb4p9Ugj38AtrNc+y2NqPWYTrKuEcWvsLlWm7zVn4b0fBfdGIa7uy6AhcYZM33D6z+yb/6HXplRnaQClNKIDVIIgI608OS6UR00iYT29znQnoMalf2l0fmj2TgDpCkGYJK9oa0KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2llFT/xeWdB0q2yoQsHcQl6zsurid/h+Vd1BA4wxrs=;
 b=I0kImj71yFWXocWYsJ1RvMm14Ei1g1o/trDzqDw+QgYORxee01UCtkYky6U5gufqcT5xLFsuOkdtFu46d04NuKIWUkp2m3T/AvNWEjF5KeUMLmG2CgH5Bkd2mDyJehgozaF2ZYtRTuL07Qw8AoszMJ7z5n+9D7PgnSY9LZyQ0HcpHQL8tkJDXeAqKBS6gz2rJrjtoHubWaWavW5x3YUK9kT4mB9odSkbqflMNcnkLureacFAHcckUkhEq85ws1ZOCpXNmuTxFD6iNgID+qEPD4IOhZyJauTjQq6Is/cmykdftABCxuUUpXOwC+dflDAbLZEq6ZnXRumEK1fQl7AkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2llFT/xeWdB0q2yoQsHcQl6zsurid/h+Vd1BA4wxrs=;
 b=O5XMGi6QdarlKPyFrf7zdrB4fyV+5bHthVHI1ZlFpg+lFK1mPqm8gkaYaaqlJFV5LRCNaOVR4gsqYSCIdwa5nPxdmzGFB5DShuFdQWoorHVrpwMxEL5FelNzrArBNdx3Y9EZFQ0OjI+ADOo/ipTjPyyngw2PN5p8UyqpWK3xXDNM1FIO0b+3MDRX3uFhXfaZxaeT76cKKcFD9iOxfZzmsV1kjLXOWkK/zgHaSe9BFLnI5Tf6DjbVeMdZQE0W62zSzPuvKHQnoEJwvo1qL00VClaUwi99ISLWaig9r+7YCNjhMhFu/ufrLTnNH0MQLlS9u6KVYxQF9idJ4fiOnNubPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 05:01:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 05:01:48 +0000
Message-ID: <32493c3f-330f-4471-8092-7aac9723d907@siemens.com>
Date: Tue, 17 Sep 2024 07:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel WG meet-up at OSS
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <fcbf9a38-c3e8-4ba2-add4-16c860c49dde@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fcbf9a38-c3e8-4ba2-add4-16c860c49dde@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0143.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 921e83a4-5058-4e68-8743-08dcd6d5d5c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dGFROG1COUxtcmxtRGtYMHVkQng0MlRqU0hjNDgvZUpWbVVrRG5XOW8xb0pq?=
 =?utf-8?B?b0V3WXc3VUhwL3NIWnZRVDIvdDdINlB1cGVwT3VhTm5LdEhkclZUWnp2ZUha?=
 =?utf-8?B?Zis3UXJDaHRyK21qaDlSVFllcDAzK3JRcDc0dU9vbzdtVDNISHFQVVNmQ0Rz?=
 =?utf-8?B?VGREMFFOVXdMbmdjTC80dEFZZVMxV3BENDVKVmRiS09yVjN1UlpDRm5POWFW?=
 =?utf-8?B?V3ZsckYxb3ZKdkl6K1JwZGRlbGRjbzVuS1oxUnduclczWVhVSjNVcG9nUkY1?=
 =?utf-8?B?SDFMZUhlS0ZwaDB0dCtsQXhHbk5qc2FVdENRZ3FjaWRCaXROaUxDT016aHEr?=
 =?utf-8?B?dlNudk5HN0ZDYXRxNURCd3FXcDZDS1VJQ2tLZGhqWm8wRnlQSy85aWlzK3ha?=
 =?utf-8?B?b1lvUzBHTEJOVGhNdmpMQVJDeE5lRVNZUEhUQldaQWhaakdwbUxQeDBYcUlm?=
 =?utf-8?B?cE9YUDN1M000VkhLNUJFbFprYUkvZUdEaUdMU1h4Si90SFdYTzVMdHVSaVZj?=
 =?utf-8?B?S0N5bzVFZCs4cU4xaW53TUJxR3hZalpxc2dNQTlGeUVnZkxaMW5veG5xWWRG?=
 =?utf-8?B?bldCdXhoWmU3OVhwRm1NeEM3eFZxRGpoNy8reTg5dU1xTjIrSDV5elNabW1q?=
 =?utf-8?B?d1c2SUtibTEvODZzZXNEbnZ3b1hUWFBwQlBRa1ZtYjZWOWZvSFl2elpmWW1w?=
 =?utf-8?B?dkozbVZBZHF4WWJpaVcrWFcyOUxBaEk5cytjWXRMeEUxZUhsTUhidGJHOEFk?=
 =?utf-8?B?UEhrM1ZYTG83Zmg1SllCQUtQQXBqN0R0MmVkamppK0d5dlEzczlPRTQ4TGRI?=
 =?utf-8?B?T0hNU20xZjVGWlZmTDdqYm9uS3Fwam9tak5QSDIwZ01uYWdQMlJZakNjOEpn?=
 =?utf-8?B?c2h6bHd2c1ZvQlM2eGlVWTFZNkZZSVJramdaSnlPRFV4R3Fnb0NWMU42VXpx?=
 =?utf-8?B?UXN3V0w0UE83anNEcEgwdysrbkZiZzNxRmpaV1BseFhzbWI1cmkyZUl5U0tz?=
 =?utf-8?B?ZVlNWFZSN2dlSnVTNnhrL2V0K3ZLQ3VpaTNRRnowaXFwaUJISXNpSmRScGFo?=
 =?utf-8?B?QTNGVi93SEc0d25uMDVXelBPZjhKcUhkTUlkRUo4QmVpLzMvaE9JQ2sxR0FI?=
 =?utf-8?B?NmxDUzJvYVd6UFYycEszT0lNTEpxTWF3eXlINzYreWc5bDVvY0JuS24vMzRr?=
 =?utf-8?B?UVh3d1FQazNNOUxuTGpRUU0zbEdNenZJTDNobWtxY1RJWHQwS3dpTVJxL3c1?=
 =?utf-8?B?MVBwa1BrNFREVmQ4ekJteE5xditjbEZEbERlbk94VW9FZ1hYV01KQ3hDZTU1?=
 =?utf-8?B?bVpYT0YyK1kxTGVvUzlYL215K2J0bFhvUlE0U1IyZFB5WHRjM0Rvd3NYemlp?=
 =?utf-8?B?dzVjbVFBUDArR1Rqa2FiUnVRZ2VHQ2lZc3UrTUZZTXdjYmw5R1ZudG5nZnFk?=
 =?utf-8?B?OFRQQlhZVi9ObkdXV1d6SlFHY3lTbUVkZU5JeVplM3ZPeVB4UXh2aVBwTU80?=
 =?utf-8?B?ZzRxR2dKL2RUU3VqeGUvV215NXgzREM1ZzlhUk4vNExZRXE5L2JkaUp4aEdL?=
 =?utf-8?B?ZElkVVR0QURnZnRzbllSSG1DV2FNM1hVZEx3OGhHSUQzNnVoOGQ1emxuT21F?=
 =?utf-8?B?M1BJUmUzaTFUWHdNS1JmeGlLVWJUazVoRmd1dnZKczhnVjk5VGIycThUNUht?=
 =?utf-8?B?TXNsWkpscXdJUGZ1OG03SDlwem9ncjlFVFYwaTJEdm8zK211Ym5oRHY0MGhK?=
 =?utf-8?B?Z3M1RHJCWW82M2VpYkt2VjF0dmczdmx3amVvQmplWmdFWnRLc3B1RkhEWS9i?=
 =?utf-8?B?Mm1oRmFtVTNjZkhBUFF4QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkUrUDBYV0R0U21KNksxOEdFUVlTeTdOQ0U3WXJQWEcwZlE5QUhNdHdqZkUy?=
 =?utf-8?B?b3ROd1JMTFl5VGM3M05hb1p2bmZhKzFJdlVyZFRZZnZsT0M1WTFHdGZwbjhz?=
 =?utf-8?B?MzZ0TlNnTHczdm9FekJ2RVlmM1Z3bCtmb3V5OUppWWhHcnpjOUpoVTBkbDBJ?=
 =?utf-8?B?TUE3cWZKN3picmZmVncrSjg4dmI3NnYrcUJrQmg2ZmpsQ0xKM3dXb0JhamFa?=
 =?utf-8?B?c0xGK3pacjVQc1R2UWhxVThLYVZsdTlDTkZOWlh6a3BDZUJOSHJ4RVdtb0lw?=
 =?utf-8?B?UTd6M3lUZDBXSXVXODI5Ym9vb3hPVzdjOFhSUUhvTU5tbmRpb1Fnajgyejdw?=
 =?utf-8?B?emhLekh1ZFR3QXZsbitLTS9QSm9LckJYWnA0a25vcm56dGd2SnNucVlDTnU5?=
 =?utf-8?B?ZFRra0FmZkRLQUdMUWp2TlRrQkl6TmRBalYwUE1aOE83am5rWTJ3cmhQT1c4?=
 =?utf-8?B?d0ZFMTMzYWd4ZlJOSnhST0pUdjB2NFJuUDVhQW1aR0FhVmIzN3RMNEZGeEpZ?=
 =?utf-8?B?dzFrajVLWUJrR0l5QmlXZitaTFZSVkg1V1IwNStObzlEVG8yRkF6ZU1ka1Bs?=
 =?utf-8?B?NGxSUktrRTgybGx5RnVrN0VseHVRQXNvUmZ3VTJGaU9tWTd2K2tmK0U0OWhS?=
 =?utf-8?B?TVZub3J2Yk15ZjVmaWZvM2JNcmhESnVRQ1BCWnBFb3NncVNhdGZzdmxEM2ZK?=
 =?utf-8?B?RmpMcUh4NjVRL1JhTGduVUlJUHkyTnFPSS9pampFWk1UMVJhRlhLbVhQZmZq?=
 =?utf-8?B?eDJZQkNiVzlPMFFiZkRZL200L2NjTDlBNTlocmZxajlmWldYZkJ2eWNyaEpx?=
 =?utf-8?B?Q3RSY0ZGNzJJbitXWFl0Vzl4RkFnUEZ5UEdTbW1EWWoyVzFpZHpyZFFrSG9s?=
 =?utf-8?B?eUkzZ1JqR2RMbUhpRUtJTThKYjJkbk4vK01HWFAwdWZXUDExRXVWNm5hS0dE?=
 =?utf-8?B?T3ovZEFCTDNTN2NZOFNSRUlHWW5mRERveGNEV0t2UmJyMGliWi9HNkZIa240?=
 =?utf-8?B?Y2t0VXlwV21YZU9nSGVjcHpKUVBIZXhQNG5QeEI1dkpBb2x2bzdPMEVDWmZ0?=
 =?utf-8?B?N0lzRnNYRFhQYmJYWUNmcVd1aCtUOFp2azhheTJ0ekQxSk5yMHRBRGYrZGhm?=
 =?utf-8?B?M1JTcmppTFlXOUlMWGNkNTZJVHRldFVTZHcvYVdXZ0NkZklqRnhLMkV4MkMr?=
 =?utf-8?B?YnQybEgwaFM4YlZJejlPdlpTT3NyeVJGa2tJaS9LQW5oWTlKS0Y2bHo3THpq?=
 =?utf-8?B?ak45a3REM2lhb3ZuN1BFd25vOEErK2txRmJpUTNtQzIyVXpPejkwbGx2eUNU?=
 =?utf-8?B?emhWeDRYaFhVaHBYN2hIVExVS1FWejN4UmNoQU1HRGpXV1ptZ3dIVGhYZGZ2?=
 =?utf-8?B?OG9YeEdnQzNYUzVCQ0NnWWR1NzdUT2pQeWN4YndOOGY0OTNrb25HNVg3cUJB?=
 =?utf-8?B?OVlhbC9GT3E1REVPNHhac1RwcUF6Rkp4SnE0OHNFb0k5T2I0N2d5QTF4K3ox?=
 =?utf-8?B?aXpkZXlPNU4yMkhLQlh1MlVWWklPZVZQT09ISWl5NU0vWkhNcWtRbldVc0w0?=
 =?utf-8?B?T25YUVRWcG5VUUVBbkJjMVJORGs0ZFN2dDIzSzl3bGZBMXlVcjlTWnFNRTVs?=
 =?utf-8?B?cDFRRmZ2anBJblpsN2ZHOHRQUXA5d21RWThZZzQ3Wk9lS2pKWnY5cVJUcnZa?=
 =?utf-8?B?NVNRblBzbWV6aE5LQ3hsT3dyMktxZUlWcTNsTWJONEU4RS83dllRZVhjd3VW?=
 =?utf-8?B?SGs4eEo3MWZWODNKN2c4N1AxcmsybVlSWjRZSWRXWmp5SGRuSDNCZHJkY3kz?=
 =?utf-8?B?Mm1hTk1DSVlwU285SFVINjNLR040cTNCZ3hlQUFXR3BDNEJXRE4zTWZ1dnRB?=
 =?utf-8?B?aUFmckw0TkdjUEpsNG5rTW5WT3d6YWMzZXJIVCtQQ3c0UVBuM2R1aktaK0JV?=
 =?utf-8?B?eFNiU1RUNUcxUjh2ZUc3dyt2Z0VtK0RuSDZxYUQrdlhJZUUyeHJaN2Y4T0hm?=
 =?utf-8?B?dFozeEVkNDhPNFVXQndTWHl0enBGRUdUZG4zNjNXT3JtL3A2aGxaNitKSGVM?=
 =?utf-8?B?WEp0c244QjBPMEVvbUNYWm11bVZNWUdreU5LQkRDMVljRktjaVhLOVJCVlE4?=
 =?utf-8?B?MVVsMnFnMVh2QVpUQ2NyU1hXT2JlaEZ5T1RWdUVVZVBscFVvaHM4cklVRlJT?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921e83a4-5058-4e68-8743-08dcd6d5d5c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 05:01:48.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbbadXVa0bugeM8e21JrtQn7WqdPlSlywyrlA3r30lFRBgd7t55XyX2MTkG0WZ+zBCzQOv7kyPTp5Pfl8nqbhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Sep 2024 05:01:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16906

On 12.09.24 15:17, Jan Kiszka wrote:
> Hi all,
> 
> the kernel WG plans to have a face-to-face meeting during Open Source
> Summit next week in Vienna. We will gather for lunch on Tuesday, Sep 17,
> around 12:30. Meeting point is TBD and will be shared next week. Drop by
> if you want to listen or have questions.
> 

So, let's meet at the CIP booth for lunch today. That is in the right
wing on the ground floor.

See you later,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


