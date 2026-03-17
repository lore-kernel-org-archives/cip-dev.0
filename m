Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7CCF46425
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 05:32:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69843.1773725519813981303
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 22:32:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IkvFW6W2;
 spf=pass (domain: siemens.com, ip: 52.101.70.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohRfO9yM6Uw24R2+FvGwcq2sfY+nw9H//A1ey14IWwT/Pk38gJ/ZzKIuMBD4ByZWc1qWSWahJEoP+snQm9rZ/NHpc1eTyW3yIAAfOFar82EF/8PSVA2ZTfjbYBl6Igg3J9M+b6oTJ8NDfpy9aemomyHX3Y/02cRUFJlBTWoFn5CNSn4GYLsM9QO6Xy8a/MQRklf5G0I68/3E8p91eef3x/69LvT7nUFrf2x9zxhBDrpDJ7bb17UYII9H7JGtuQ1SeHtGqTwrieMaW8Dtgk4yOPUs3taH+cVhmLG7euIP9NJjcoIsZAukUAqQOH3VhqwXNbN/7t92+BQlXXTGgJFRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucES33cxjchqsK+85JBKBYm+DUcBkVYyHHOSNx/z9uE=;
 b=Gt+4B0PXE0SM01UiM9v22s8GoZgyXPc6qJ4+dLzUXDLdASOD10fkBIfzr8aQWC0q0juHwjTCZ6AoRxnlDJVr4jER8yzCFIl4XCfd6yocxmgX9biIsxZfI8X/jwplkqVraiI/sQ6od638yl5NebeorAg/uzgtHwgWB+uy87mUEnhYtDY/ogl7O64it1wkrwBzUvcbQIAqhHGfyg+0WZb78EUJo25G0VE8fdNb/VJE+Xib/rk2v0EoG2pjfU6Gf+RpyAerMHGutatsKKO+J0YHHvqFsyzkkq3S1whA9cah7mwg4R+6Er3tu0TMdhG76ApqzxgXsjVHHdwE0Efp5iAwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucES33cxjchqsK+85JBKBYm+DUcBkVYyHHOSNx/z9uE=;
 b=IkvFW6W2crpbjtUMPuQoJ+OXjMuZS0tovq4R753I5XQZIUFVPr5W/C5CcYUNikM4sUBmhl2Gn0Ur+7Fp+5bZOgK8X9qNBj8YNa3NjZ2c89reuHeVhU85Ud+RbSd5Y4OnMOBOfvv89imzhcWCEiUBeHOibkz3VZvYgtDkaVVSOpkV25EBopJVrAInerKpnKSEUg4BpMCWtKkZhKf7XMX/4CLWHIAk0F2k6hEGUSYGAVh86MGernrzCxuKlT+fpI1/npg8KyWmJvvHnCOdMGOvmfFIFHf2cRKq9VtykErEYRk5zKJjjtN1Mlst5zD7GfUth9IcJm1RugcbD6USQA5RGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 05:31:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 05:31:54 +0000
Message-ID: <7585f240-a30a-48bc-b461-b2058f937b4b@siemens.com>
Date: Tue, 17 Mar 2026 06:31:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Next isar-cip-core feature freeze ahead
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d369b5a-59c4-4790-e064-08de83e67ffc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	1d35nIwrE6C6q1LoLSi5yO3csyVdVVL7Js2cnt0HXUcFgWN04DGIyvdE905Uyvlh+bd3wf4cWk0FeurHI/im5ba0s2l/kxSxOJm0ThGlQ6J7cluoCZuQh460Nak1FExGdLt4uiYzM5Zr3rLEV99b3uFTb4DOV+/fsXpXwlBsuOM76Gj2TwI3/NhpkluohhV3VRvHdgY0RH/y/fAEgMCqFOHCbUBjaaPxzmq/jSY29veYR/rKSerC0I7jUeRREmvq62URg5EPH4TTWVqxH21EzxvFzsHRMgCokHhE6GZRQUFPgTDDOx7rEBSMAtotXgn4uJ2kOM3R2GhQBO3LQ2PixIj9gW4/n9jkikii1I/eaRO/F7vrqga/NnXf8kmywK2pNiwmOhvWag2VOuxOum+BBjXdZ3NJRaAiv9mUWwF1GlmnJHg8jJeIcUnIWkKaLxZu0ooKJq1aYJp7lhJ85cKDqyPZb3XH2qt9xG+v9/Yb8HyIwe1VTAAJEfVIBPRD4xKJD8/i46lqNAaDQ5AC9xkrC7d6HVjAT3aasu0c9s05KPTAJy+H5DFsX+8/ePr2QACKQGwa2nEcD2+rzfDXPeYktqgJJXzbKMRLr+W0v7ZmtfjImClF61VAuzIZEe8L0w1BDzdrjCYOI3naz5oYfQdEHyeos9ULHvOg5JbAHfH9EP7ANShVCv9cTjKpnL7iob32PCoyBJ4Wa4YZB5CU7fYHMwA90R03YUWK1b/ktlXZrnQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU5tVTY3VCs1WUZoWlNlQnlpUE5zKzI1NGtVQU5KTnBScVdEK0JZMXZqUzhZ?=
 =?utf-8?B?ZkxYU1lsRDhnc1BJV1VGeEhnVGkxU3kyZFhEQkNaNlhkd0NyV2U5ZzQ4dkt1?=
 =?utf-8?B?VFdiZGF0SjBteDZ5QzI5bGtwaWdLRlcwSVlKWk1XU1lzbTZrQjl6bXh5c1pB?=
 =?utf-8?B?MnQrQ1FEVmowT0RuOGRaZ3dIVFF4Uk1wL05wcnpzNVlsVkdwTXNBbFlMRFF2?=
 =?utf-8?B?WG5xZVJRZkkzajNiQ3JDaEVMaU9ZVFFCc1JjZmZWa01HbU1hZU5mMFJUN3JL?=
 =?utf-8?B?T2FJcGpxOG5wTmNuZnBKQktGaXljS2xBbkVXQVdtZ2NBT1ZmVVhzWVMvVU9q?=
 =?utf-8?B?TzQrSFMyUEczUFRLTEVsWE9iZlpJSU4zMnRVMUdobjVvUFFxSWxqblY1YXNI?=
 =?utf-8?B?S21aMlpHc3BDbDZWNjJoV2JlQ0NjaVU3eCtKWGQxdXdYTlE2aElET1E1QTZn?=
 =?utf-8?B?eklhSWVGa1lEOE9lMFNMR2ZIU2ZGN3ZHa1RmT3VSZUhYUVlWSVVNY244N0RR?=
 =?utf-8?B?S2JERS9SZkpWa3V1VnQ1ZWcwTGtjL1NVak5XRXY1bG1CYzduUjlwOVVTcytP?=
 =?utf-8?B?NjErM2g0NTVrZUxpUTlQdThUcmI4R3FGQVFzRWJWVEZpS0dkMDBZWkVueCts?=
 =?utf-8?B?WHAxdlZWeHE0d3JvUy9hSFQxK2ZEQ25xdksxSC9yS2JaaG5WNGJ2MERMNm5p?=
 =?utf-8?B?ZUlkdXpGbTM4TCtEUEdOZElvVVhaUysxMnJSaGJqdFRhR1pkN0lhOENTazZn?=
 =?utf-8?B?NkgzT2E0MG1rWjNpOHBjSHBlT1BZR2h1aXU5ZWVyRXV0VXNGZFpiV2JmTmRD?=
 =?utf-8?B?WUJqSndldTZCK0ZnVGhzVXRVQ0NqbWR5bmppMmlBVTBVdHBLN2VuWmF1aHlF?=
 =?utf-8?B?cDA5QW1UVUphRzZEM3J5UzZlZ3Q1aG1TUjZ5TWZuUEpRTUQ5dzVLZC9GYnVE?=
 =?utf-8?B?dktVOVRua3k3eHJlWE9BbFhPc3AveGNFaVVSQmROdWJ6Zk4zYnNseXA0dGpQ?=
 =?utf-8?B?R3VvUEVhbWp2VE84WGoydHRvKzVncHkvNEhuVGl4a1VCek9aMzFtSWc5Z3NY?=
 =?utf-8?B?R0kxbkdmRGZjalNCMVp5elJVUHlkRUFxMlZFSEo2M1FwUUdrQkt2ZTJkL0VC?=
 =?utf-8?B?clQ1TTA1c3BXR2YzdjJiVFhxRCtFTlZMRzBiZkxuKzVnUkwxVndjblVHQmRi?=
 =?utf-8?B?WG5lUllXQ0NFUUVjUHFKcmhSUlJDUUg0dW1lNit2UGdhZzdaQ21SMnk0UlMv?=
 =?utf-8?B?S0hXUjJJajFhQjh6OUtaMkpwZUk4WjJLL3A1LzVCb2Q3VElSTENjNFROOXJE?=
 =?utf-8?B?bFIxVzk0TVdsSFhoMjhlbDlEbUlETHQyeDczZnNEdndIb05SRVhOZll2QTRV?=
 =?utf-8?B?a0d5NUVnRy9kK2hCUmsxa2RPdUVXQlRhNlR2TVBRbUgvTGVCckNzd29HNnVk?=
 =?utf-8?B?U3ZvTXc4bjZnM2xDa3BqRHplNk1wdk9TK3VJcU12S1RYWTRLWFFPMEYrQnJZ?=
 =?utf-8?B?VWhFa3hneThXL1M1aDlSeEozSnZWTlB1UHVrbWJFWTJjbTd6TmdQRzRkRDNj?=
 =?utf-8?B?M05ZbEFDQVUwbHZQNjQrQVdJVkhYVVYyVXJ4VENJeHRwUGdSKzBxMS9FcnJv?=
 =?utf-8?B?QmcvSkhoREVrcWdkbTRSQy81NHFNMGZlTzVyc3c5M0xkdlJueStUcC9PQnZh?=
 =?utf-8?B?Y25oVDNGK3dVTHFsdUV1Qy9JVWJqSEt5QXBtUUtPT2ROb25IbmxuNW1PSC9Z?=
 =?utf-8?B?MURRbWtwL0RvczdnQ3VoRzZEcnVJblJ5MWlia3VzVU9mWjVqWk8yMEJUM1Zz?=
 =?utf-8?B?SDl6Z3FWaEk2blp0OUNaVC9tMnFjTE8yREljcUMxaktSUzBjT0FQWklRWXl3?=
 =?utf-8?B?enFWY1RpZk82NUZXVmdheTA4a3loSVNFd3hMa0J4WGRHQk11VVdvWkpYcGo0?=
 =?utf-8?B?cnJvNFdGUm5lQzlxTWZ3ODBNR2ZEbkV0UWhXdjFJZzN3UEV6QVMxZ0s1N0Q1?=
 =?utf-8?B?bjBhaEtaN0JwR2RJKzhWRXA5WHpVMnFHYWt2dElRSFc4MEM5dTFUYzZTaUV1?=
 =?utf-8?B?TndzcmlaWm9Gc1NlaU1UZGFUblJ6SkdlV050Y1RnU2JCZVVZandjZlZqSzZx?=
 =?utf-8?B?TWREK2QvWkRPd3ZhVVBSbVhBWmFoUW9XOTkrOHVkV0k2N1Bpa3JVWFA4S0lL?=
 =?utf-8?B?T1UwR28reDlWejNoOFhFbUFSTFc0WXZHK096N2k5TEdscjZpa1VVbkRVeThJ?=
 =?utf-8?B?LzFKRW4ycmNGRUxhODlGZUR1bVB3UHhnSUdrdno4dW9zSDY5SkdnTDRUT2x2?=
 =?utf-8?B?V2cxV0pIZnlIV2pUdlg4STVIOE43WU9OMnN3UitCN3dKd1VaVDczZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d369b5a-59c4-4790-e064-08de83e67ffc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:31:54.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvaBc8j7E+lVTzfACTRjJBlhneZrfkpHCN9jr5JjXmK8nWY2ojioD9rzmu/carFGo+fd0yfKC3jr/oTA7wV8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 05:32:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22429

Hi all,

at the end of this month, I'd like to roll out v1.11. For that, rc1 is
scheduled for the end of this week. If you have anything pending that
should still make it into the next release, please step forward now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


