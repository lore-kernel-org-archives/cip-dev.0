Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696FFF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 20:04:47 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23939.1777925078400993907
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 13:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZPGuxo82;
 spf=pass (domain: siemens.com, ip: 40.107.159.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVUPD0I56+QprcgUhfYvRGbA0qy370rYW+0BP7kyPk+NJKnK/JtVDGcfh0bgm3KqWLSg8XTQDdGK5kAaiCrH68vKoYDSpBtkbfDkZdgl2r4CVlIhqc5irsFWItJh2mBTgVDJnl9dnkgTbsCz8zB26/v1+Q+DvWcT28eJy8p775PBfmY1iivPQ1EH2fwAic0VH3T87FgCeJmoJDp5vq4wcUn7DfJVbWX9qM4EMmcH+yHHBoiXUTyURL54q1nA8no/SlVUYxj+W5gIjC+5CCtviMHFOKfreBOHUbWLZlQ1X2foO9HYrqiNsAFBjlA1/TsawSbl6QMGInqfSAstmlnbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WXduZ1SEM8Fz1N5P36pE0zVBm26AbfXGFnFfzC5y+U=;
 b=m1YxJg5d2qwtT3XCD+hU5XTnPKj/xU1vubo1N2mX0pL+EEXeEmQqc0nxIikLJhGXhWPyoUVvNA4cn22AEZRAnVzKyaTxjTUCw9NB9aemfcRD+a4N88KqLC7wWi0sB51am+FWcP5DOT/vKPV33WMYcfU8/mJ7YDR4jL4qHoX/UeVP//J1NDbQnYP5gO7gWFwIujKOvQOuApf2E+2nawqzkcyBSTKdrIkc8OtrIfvcVf9GfQxxKyWqriBujrg1160sJWbN0KLA6LXHVMPy5o8zUbQnCE7YcxIuHOCqTyW0MqYig2rGWEt1n71WhvoFUssGc7/fWKxhTdK+dytEzTpG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WXduZ1SEM8Fz1N5P36pE0zVBm26AbfXGFnFfzC5y+U=;
 b=ZPGuxo82SKsgBiBuOkfyRuRLfirrd89Gs87g9bEbLaJK6MK1QeTQ8e5hSwUyFafwHSlSYqZfL9Jj77Brf3GHiCyc3jXHguHP3hwJC1BF4M7Smwe+Skow/XVDLj5Y2HFHiyKvC+7h0dMpildn+UelI+V2INciyKH/raGJdajRg0NJHywLxKlvnWc6Fn2KA2NRNxRJtsJCJNRBkfhmBHP0ZM6DmavPgSecfQyB2vsGtqNNN5yzJl7pXDl+JWEJNMP85utJXaKZg8iuT2zCx2BpcgU0U8ZLCZo55je7U9sjO8lxlJBYiWdaih3MiyMQqRMKamav2GfKBvLLq8oSib9/0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:04:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 20:04:33 +0000
Message-ID: <5a656542-fe6f-46ac-956b-073c32b9cf6c@siemens.com>
Date: Mon, 4 May 2026 22:04:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: cip-core jobs passing in lava but not in gitlab
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <50ac15d1-1a05-4111-a2ab-789264357320@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <50ac15d1-1a05-4111-a2ab-789264357320@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: a861e246-58c2-49c6-014d-08deaa185bc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	a5wLvvnXwsSKozawm+UYUkLRyWI8jXkziDb5errPHBbIRZ9QOmAnTrYA4/XFbljRNTNv/81CgRCAlCvG2RMIOJXvjWT4CEVXfdFChv/c5g38mjgeRdB0yds6rjKURUdNsO/A+gJsQzUKRE1muDretvOqkkVFcHx//37rwHDUftdflRzckKf8LPG3noMdSSw+u9kcuJPAYDTc2pkufwZbsbsmn8QlYJtPdjNKRT5tl2JL4J3ZwXVvpsgAFg3L1yXdis1dBA/d6f1Fy6cD1soj/dHtkd98Hi4eVEmX/drTNn1Y6DmwLws/ZFdnOJGIhaJgvxSUDOGWR4EFg18T/jXVFpSU229zkpupuoJkpgH0s6qe1xWkAbglq6XHoVLrrE6V954Vkz7yAoUygTYvN/H8NVgcVb8vU50gorCCBxsu2iDIylU3dqxVD1rfF1bJg0kkYotEXb3UhLOPVGdRZEJHk1tlHk6Uwcfp1KyfuMqjdSYvk8ESUKJGYpRz1UpxmJQmAh/oRQhZ5Xl/CZAYJcGDlSznpRHuSez/7MKpHekit0ev8TA6mvHNDoNzYK9q2YGvsS2am7eCWEqXMCUn/ZCdAZEHZGnqSdUhU6U62mVlZ+Vftqn1JqZSrcntogIgj3g1bBFxvDgmcgcrSqe7QpPtPA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnNqVFlnUDN1a29zRWJsWWJEdkxWZHJ4SEZqOGVURmxEVVE3WjNRazVTUGR6?=
 =?utf-8?B?a1ErWlhaUXBNUnpYUVlwUFZ0WjZjWU9KZHpkdmsxYW9BOWc4VEM1eEJ0YUIv?=
 =?utf-8?B?bWlSZlRzVlVNSksxRVpnTUgzclZ5M2dtR1plVW1CYzVLSzNwR3M4cVJZOWZE?=
 =?utf-8?B?UmQ4VGxVUUplb29yekg2QUhFckJuRGttWnJncU43dTMvdXRHWnFwdjNrV1l6?=
 =?utf-8?B?bWpyaUxQS3QrQVVBYldTekhUOHVIVTQ4WHBzZEtoT0MzcjYva3JZRXVGcWdF?=
 =?utf-8?B?bjNUTzAxaVVRVlY3SUNFUGV0a0l3eStIbiswbDdDS09oTEtvRkpnVnZBVlNT?=
 =?utf-8?B?MmI1Nk1KL1d2SFlHcTV3SGIyZGxsbUdJS0ZLSmNkK2VOTkVPMWxGTzRsdDFC?=
 =?utf-8?B?UXhMeFhydmRiaDVNSWRBNENmVlpmdlF3cnAxb2RwcHVNdlRITEYzdXMxV09y?=
 =?utf-8?B?cE9yVVU3dXlIMnBlUTFtWVZuUUcyWS9oeDBRZkJ6K0k4R2hLRWZoSXYzc1dI?=
 =?utf-8?B?MmFZd2lIUGk4SE5ydUFXcGh5TmJQcFE4WVpHUHFheUU3RzZJMVlVam5WRFMy?=
 =?utf-8?B?ZVBJN3lVYjR5S2JESURza05VQ2Vma29JRjdkS2NCYUtVdk5rZG9CSE1VVkpT?=
 =?utf-8?B?clZFRFBJSlNoejlWa29qUEo3OUZNN2ZwVjZoMlFiN1BzRzQybTdJTExLQURY?=
 =?utf-8?B?RlYxS3JmVmpORUZGQnlsSWthQWRtdFJzTzZHRzRKM1RqYmUycks1dEhiK3dQ?=
 =?utf-8?B?amg2SVBSTklCQTJFY0E2QmQxb2hUUHpIV1RKYUk3RTVNT2MvMWZQb2pHRjNl?=
 =?utf-8?B?Zmt6aC8vejNCVEFkNWVoNTQvSlgrMjJteXhWajlwc2RBY05venFITlRrNFgr?=
 =?utf-8?B?Ri9ZVDRaSjI3WDhrZlBobU95KzlPYlNlaTJWa3BSdW1zazhqNllrREVhNjR0?=
 =?utf-8?B?dFRIZmw4dFJCOU5DZWdVdzFqcWZDeUh1bjkvT1I1ajdmV2pHTWVPbmNjWmlH?=
 =?utf-8?B?Z0NhaDFmaG9uV0dmendMcnZkczZYQzl0UUlTRFNEWVFudVpjYjErUjZiMEpI?=
 =?utf-8?B?cnBtS0R6U2RjdnZVeGNtNnBqQjJVajd1MjZVdytBcmpqL25CclhFZGQvNUk2?=
 =?utf-8?B?YVhvVlcybVNsSGlWcXIyZ1ZzQ1R3NS9BYktIaTNTMWF1YnVoK2NFNTRvWkRG?=
 =?utf-8?B?aWJOYXY1T1Q1V2J3V0xjVDJNeEJUbXhMaDE3OHRXVzhuUW9iaEJlZ1pQYStP?=
 =?utf-8?B?UW8xQU55TGlyMmpuWlM5STVqY3h3b09nK3ErWlJnckoreUFtSHVoVmZNc1hq?=
 =?utf-8?B?Q2VNTWw4NnpYWFZ0Z0ZPUHpuNGhYcUFub3dxOER3YWQ3QXNQb3dBU1VIRS9a?=
 =?utf-8?B?Y2hwUkZTZVI0T0kreGlpQUxQMUlYK0pXZFM1TFYzd3o2Q2ppdEdMZEk1QTFD?=
 =?utf-8?B?aFl4dDFYRmhqSWI4K1h4dVVESVgwTzdEcjB1V0IwaFQ1d1NoMGVMN2kxdXd3?=
 =?utf-8?B?bFJtd1lqUVlYVzlEanpwZEZDbzVvWEFibkk2Ny91dmFuSVRFK1hUZXg4UWVQ?=
 =?utf-8?B?TFhqTnlraDRoMGJwUkFTTTFvUGY1ZHBXQ0ttM1BOMjRkbGZiVXFyTFZjVWdq?=
 =?utf-8?B?T3RqcUV6Z1d4VDd4UkNMcENERkdsaVRXNmJnWkxlelhEOS9mOTRydGdtVHc5?=
 =?utf-8?B?RVhqTFQ4N1ZsU1ZzZlkwUUJhMGROKzd2VFlFZy9Qa0JjZlRtNXhPVjVERlhN?=
 =?utf-8?B?T0FKZXFrUDgwOVcycXZoM2FxMm1IWVBYdTRPUk82U2kvUEl1Z3djeVI3WnVm?=
 =?utf-8?B?TXEzYmd3YW55VTFDVmhKcWpGMnBBNDhTZFpDbXFlOENERkhTd3owbGZ0WExy?=
 =?utf-8?B?d0JvRENPd2ZydnFXMjhTZ0N0cmtHa0tlY1NnTXNQMEZTYXQ3bURkNE5wZ2xP?=
 =?utf-8?B?N1gzRjJ6a01zSzg4Nm12V2lvU2JGM2xhZlJiZGhnbDJxaTJNUFl3L2pzamlB?=
 =?utf-8?B?K09zbW9GMW9oRWdCVEdWTUVybmtiMEYybUxzdFNsRis5dzZLUGR6eHd0TVVB?=
 =?utf-8?B?MW0yYVdCRTNQZlIyTitQYm1nMVFuQi9SMGt1ZlB1Ly9NMlNiN0JkTXJyQm1E?=
 =?utf-8?B?Z3ZSYVUzc2hEZDdyTDgyR0pMWkRLVmN5em5yeDR0UnhyRkhLbXJ3NGZtd1JV?=
 =?utf-8?B?ZEMxTHBpTWllWkVuTEw2MDdKM295OHpNRFp6aS9RWm5lUEFwK2RsVDd2YTR6?=
 =?utf-8?B?cVU3dEtQMlZjdVpKa2hNMWVLVmxUbGhVSVNzWXFJM2RtakRpZkNwNEFybkV1?=
 =?utf-8?B?MEdNdTQ1cGJ4SjBXSGVyb1lsUElCSmFacG81K1c1MlAxcDVROERnUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a861e246-58c2-49c6-014d-08deaa185bc1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:04:33.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhQIxdUTxax7rC8wPZKMl+7lQiD48AsyZSAdeJEewApLK7ePS1RzheX1rRHsSIOT9zZj2fPqGqjsPAwrzkQYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 20:04:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22866

On 04.05.26 20:03, Jan Kiszka wrote:
> Hi all,
> 
> currently several isar-cip-core jobs on QEMU targets do not pass
> although they ran successfully in LAVA, e.g.:
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14205628583
> https://lava.ciplatform.org/scheduler/job/1437475
> 
> Seems as if lava-cli gets struck right after kicking off those jobs. I
> already retried some multiple times, but this didn't help.
> Interestingly, others are passing, also on retry. I'm still looking for
> the pattern.
> 
> Any ideas?
> 

Now they completed successfully. But retrying the one above gives the 
same behavior.

Looking at the log above gives a hint, though:

...
URL: https://lava.ciplatform.org/scheduler/job/1437475
Something went wrong with SQUAD watch job submission. SQUAD returned:
SQUAD URL: https://squad.ciplatform.org//api/watchjob/cip-core/secure-boot-testing/35b3ea92/secure-boot-testing_qemu-arm
SQUAD Backend: cip
LAVA Job Id: 1437475
2026-05-04T17:54:41 lava-dispatcher, installed at version: 2025.04
...

Is SQUAD down?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

