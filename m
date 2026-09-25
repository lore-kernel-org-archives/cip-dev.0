Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E191C98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 14:59:54 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.289.1790348384573909527
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 07:59:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BLWNhXOA;
 spf=pass (domain: siemens.com, ip: 40.107.159.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhiSSHck7L8bm90PrdMoIHuC7IZ8xFYHERFu+YFNYN1iGOfShYbxdoMHhycrZ0dgVq1BH/5fQzy1jXwqVzfj4FcSf9GyJ5ps5ynhPgGsIwRkJEkJv6k8j+lhIq7e29Td6PuuRyk9gj8DGff/OZGkjDBFZBI3NJ33ORBWumHmGlCkoK0NkfQswzVJZpcd4GFHAbpa0ln6H1BcUCnqvyhXGv1o6S918c7d9Nmo/Uc6HhCbo9MMGETFIEDVE3XjaE6yxc8o/IqFj7ZyYJw3PBMhrkXDEFWzQ7PExzyxbht25YY3qb2mT0MLZx4EmEIiHb2TIyxr+qxeLmLuMBu6TxmdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLQBMvYBhe227i9v1EeiwFg/yEk5yO4Tba/UePJjloA=;
 b=hjRStkJkoT0VCJjZatVfdITKIoix/d13xaQpaTwDaAypvaXfzWRkM1eprtV7VEfY7R2yilRffD3so7eG3/rBKL6ymLbGz2W8Bq2BfUjg5E6NTcyNMM9A+tXfxAHqyT6Rzm1vFJkjxSrsWlLWuWN9d2zL7OPentoQYLd3F1i24cmppL5Ub1orfLSDv3LB+Ppz+/CPBP1ZberzJMR4HJYxVwzPrZdIuUeuwh76acrKltfG28l/4UGC39k+L+ymLr4hGF8ANEAGnDjyrFTzI5J3sOSkUaihIqPvx1ZyqDLvb5ltQXVtKVKQLBalyviqnE95jaDLeBtuxvvH1VhZF6yM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQBMvYBhe227i9v1EeiwFg/yEk5yO4Tba/UePJjloA=;
 b=BLWNhXOAhPtfb3vLIfZaGIf7XcfBs0lPLGgxPi2qK03LP/3poc4FnCWoj3uWsFy7msZFmLZIlEColdY5uG5nOYPFtWwlX05Pi409KE1CRfcskBZOQYQ3BcGQsd16Fmsq3GyYSkeCcvcBkNzdCfJigcNN3UhzIxkC7UhgdQFVWSxffQAXBiBVZOTq2kgvKxdlN1wd0U/QgAlf9inNySPsASGNYg0hjowzKH5QUXxMS6DHvW/lzbtfIAv0RCjjttwzT2d+iWooEAZXX/DN2e25PM6LUMOLDsiEb5gVVKW59vvcIQ7BPguKvW2D9OEL+st/RUAHSGSc+0x7zsjVJBpUaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:59:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:59:40 +0000
Message-ID: <57373b6c-874a-4b18-a0f3-b10697cb7a43@siemens.com>
Date: Fri, 25 Sep 2026 16:59:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.13-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9485ca93-8d8d-4ebb-7b74-08df1b15a028
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	wzfSSD7gH05rz1T8Oh75/6LgFiSNn+yqc0ZpBoTdp4seO1TjFIpHmr8swq1W1cL9lPgNSugLiZGIxNACyUMX4VaZd9yDLicPqUT+lHjYmHmKfVRjKxT/FaEjsLzpyAwsXlnJLJxOBKIhEUmvOWgurfyF5wx4Mj1QE9IpiYl/oShfgt+2QAzC/GpkXm9stT3ieF5FFqVSaTsSv969O0/bkuLSqOSi74Llh2yvaLlnB1slDZUSEYRuCDTacy8ywOUZslzhDorbh+lxbocBjDud/AjP0KrKKzFsRWw9e8vdem8VzNf8OxOUNTOA7x/sgzX5pLy9icDb/yeZkg7NYA00F+Fm22Z0p/FLVpp8d0A1Em4rIgIvVyrNTZ1e/Iud+232VMlLJyeyJtOqBZHpQa8JIwtuk0QhxtJefWq8s0mQu6k/m/35KL2Q/2s+u3Gxc5KsbDJMZnuZz1v/v/xbx1UDYM6/u0lwR6fUJU/3d9NsMiGjloNGI+YmNbzVh7yX8eiaXuwzOb30shSEHvegHFN/efvPctCEAsNGdqFxOan+Utmo9MpqFhoAwMgA8/L+/SQjlelGDJM/jZ3sukCvdxnVwNv8lWAYN8IivV1k5ihjBY/p/kCy9gqhi0h9Rd28tgt2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1J2N0pzcWkzaTB5dlFpenF2VUgzNndhT04yWlNSQ1ZEUkRrNEl5YmExdFJy?=
 =?utf-8?B?RHZvcms0UVl5WmFUbVZrMnd6Y1U2VmNhRktEVnFJckVDTER6dXVrRVJReVZN?=
 =?utf-8?B?UGJTN0M4L00xTTZaRm9CK28xTjJzOVR4b3JMdHdDaHBOa1cvNjVWSEdEY29E?=
 =?utf-8?B?VFZkdWpJWjdLcW5CakdRS2VjbERueklCL29CVk9kdGNHdjc3SHR0Vkh5Q2FI?=
 =?utf-8?B?R05Udmh5UjV4SGFESi9PVmE5SEt5RUYyUnZSdmRXRHBJREJpaXlsSUpvV2Mw?=
 =?utf-8?B?cjhlRk0wdUtCQ1BhOHVNRXRUNmZ4dW4vNm1lc3B6aEZMTzZuQWROcFlwQ29i?=
 =?utf-8?B?OTZ5RjZpbUw0THdqNVljRFpjekdmWUh4VkZBQlB4dXJZVDJ5MThDSHlHR1dE?=
 =?utf-8?B?RFhSZjlWeHhVRXFsSEh2Z0N0VzNoRktncVcrZDZFYnh2NlVjV21GMDMwWG5o?=
 =?utf-8?B?UStWRmRvYUJYdWJueUxLRC94R3o2MitNOVBkRVFuc1N0MkhrOXpTM2FLR2ti?=
 =?utf-8?B?Y3hLbTJ5aVFSNWtSMXEvWlBoQmlKY3l4YjUzQ0UySllSYm5NRlh6TG5RbzV6?=
 =?utf-8?B?QnQ2a3VldXdqNTVQU0pBRmJ2V1dML3F5VWdqZWo5WCt5M3RkbWd6SStEV293?=
 =?utf-8?B?WVhXVXhvQmhWOXVxeHVRd3hIOHVZMU1hbUlBM1lJREpjWEZYNUQ5aEQxdGZH?=
 =?utf-8?B?M1VlRjBGeTk5UlNvOXFiV0RSelZEajN6MzA4YVRMa2R2ai83QTAvUkp4akNP?=
 =?utf-8?B?K2JzcmRZcnFEN3J0U1lucVF4OS82RFVpZnhidjJUM1A1Rm9CNWEzV1ZOODJy?=
 =?utf-8?B?SVhQUDZDUzlWeXJyUHN0YzlPNUFKaTZFdVRyM2dNWnBnakNBT25CS0EyUTNs?=
 =?utf-8?B?dzNrVTk2Q0dkM1Z4emtYaVhMUlYxRGUrYlFzWTk1d291dWY2T1MyVHFZdTJi?=
 =?utf-8?B?ZEFCWlZrU3ZidXB5eGFmK2hLSmV6WGVtdk5ZYlZMRkFBNThxMGp1R2MxOC9U?=
 =?utf-8?B?RFVhR1FNc3pGYVJLRUdodkZIWit3cHNDSEE4MmJXbUZIcmZMTEUyeTdZbzJZ?=
 =?utf-8?B?cFJRbXRlNVQ4RVZHdlhiaWJsNWJTNFNYeTBZWk95b1k1SHJ5M0ZWOXNUTXVa?=
 =?utf-8?B?eEhQMDFSYkFCSTFZUXZpS0RuTHRXR1FCcUNtaEhtN2RZR1h0cE1razhOeXJl?=
 =?utf-8?B?K2pyZWtCNHo5aEpzYVJCL0VNVHZ1b05LZzZxUW1ZNUQ4NVpDUzBENUdUQmZi?=
 =?utf-8?B?SjF5T2UzTnBZNm9VZThORlZkQ3cyTHZkcGhIL2tpRDkzRVNPT25BbkIvakhy?=
 =?utf-8?B?WDNUZnFkWDA0VDh3d3lpOElKVzBJTUZ6MHZEUnMzRW5TdXdIT011WTFXRnJ5?=
 =?utf-8?B?OVcyaEplQ041UDc5dk1hZ05wem13MDc2cGpUYkpDbHlzY0RnRTRpa1hMNHRQ?=
 =?utf-8?B?c2lBRy8rV0tpbFZNK1h5d0EwaDZ6ZVQzSDRMYnIreGZNTURwWmZrcDcxTVRC?=
 =?utf-8?B?NVY2T3RtdXdCTVU3RnpGMjZMdXozankwQzV5K0RuK2VXRHJ2dmQ4QjdIR1pY?=
 =?utf-8?B?cnlCMGFjYmw3L1AvS2FnbU4zZm4wNHZXNW14cHZZVHdrN3IyRWRSSjN3OWIw?=
 =?utf-8?B?SFRlNUhvUW9LUitJQ3p2WTR6VlZNOWRRZmxKZE5oMTNuSEphWXlQWitPYWZR?=
 =?utf-8?B?eE9LTGtOZ1NPZ0FhU1RtTVFLYUQyc3daSHUrV0FJei8wL2R6TER0djlMcGJI?=
 =?utf-8?B?TlJKUUVuNUp2dmROb1FaU0JSbkw0RmZRZ1BkYW92K2RuVlZpdmxhZEVRUW8v?=
 =?utf-8?B?MVpHWVNCV3lmcjdKc0d3enRIVkZud0dMLy9GWDNTVkswQ0p5VGpoUGNaMllt?=
 =?utf-8?B?NDU0T2dpNTVVTU5sS0pnQXloRmFPbmZpK01DaXNvMGdjQ0xjL3FMVGFpb1l3?=
 =?utf-8?B?c0pQT0JTbENQVzhjd2pabGdRblJhcXJ4SUcvOXJUeWg1MDRxUExtZkV6OVhq?=
 =?utf-8?B?bUQwRFVCTlJ5Y25Mc3AyUmZhZDcxUXExV05ISDJlVzJUa3BTdlRRTWV5SmpD?=
 =?utf-8?B?NGpuUjRsSlJyalBzTjBrVk52Qkg0L2s4M3V3ang4N3E1UnRNS1RWVXBncFdU?=
 =?utf-8?B?aVB1WlJ3V1ZFeDlFWEV5bDBWcHpkT2VMd2tLZXlSalFrZWlvaDJtSTUvQVJQ?=
 =?utf-8?B?aVRKM1hyK2lGcjFhVVBUeEhqM2xUamtKTEdjUVFTUXJoUDlVMGMya2NBWFov?=
 =?utf-8?B?L0xsQUw5ajQ3cjZWditya0V1d1F0OS9jb2FxVkh5bkZYZG02aTlBSFhoQ0JB?=
 =?utf-8?B?L0k0ZDFzMXZ6NFZCa2ZjSXBpeVJjbkhoMmNLYmlXRDdpUUVRY2xIcVI1Yll3?=
 =?utf-8?Q?m4Xy2ijPqhXd96X0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9485ca93-8d8d-4ebb-7b74-08df1b15a028
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:59:40.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QqtFGz3QTgMIbvndu8b4GkKuPJitJXkV3K3BMrgGJU3+7Hwi7TT6afde1KbTngYr6o2JNcba+DDhjdPlK6zzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 14:59:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24351

Hi all,

v1.13-rc1 is out for testing.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.13-rc1/isar-cip-core-v1.13-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.13-rc1?ref_type=tags

This release will come with some changes that can have subtle side-
effects. Primarily, the enabling of rootless builds can be one of them -
while we /should/ still support classic privileged builds.

One known limitation: the fTPM integration update should really be
considered for demonstration only at this point. E.g, the currently
provided patches would wipe the state of an already deployed fTPM when
using it as upgrade. Keep an eye on upstream OP-TEE for official changes
instead.

The plan for releasing v1.13 - in the absence of blocking issues - would
be somewhere next-but-one week.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

