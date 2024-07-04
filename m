Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3AC30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 21:45:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web11.5508.1720129518037182089
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 14:45:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QN4T4rPt;
 spf=pass (domain: siemens.com, ip: 40.107.22.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd+/YgkYfuLE/iKllphqiPFjavQTD4i0I0wK9LDsPcslpvd4+ck9U2hLqg87J9afJz5PqSTMX3P9l4JktxylVjHrXLXaF0h7xKEiAV19OS9TeedTetbQLK2YoXyPb9liWHgPUDqxwsM/zSoi3ek4JghGRxsXy94IBbAdG6GXQ/hF7c+21QNzpiqX3n+Df/geFsNf8dT4VEL4FaxqmuWeNco3CSXskqNtHdoOQ1Qb+zSGYK0ARpKWadOQzPvilW3LIcia44NHp6Z05akPgHzbcJFBvzVVyRbNd9UEWxHnsuD5lspdVsQGGASjqD0duYKzs73DBJA1yTfzR3SFzrKr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCJ3dyGVF1pMXFYOhXBvnJz3XPbSqmhBKtaDm6sf47U=;
 b=W7gjvfFL/UPAWPUkPck+pqcisA4QyDA6/lwBIRKfmSeUPSPkYRu8MQTMNPhAgn24NRIRJgZjsSuO8s75BCDccKnjSSauQfmfowBg2wUznaB5Ovw1nkoT0Bl8nPKIDmZdarxdEpsbUPQvxU8D4Jlxpc7jct9c2K00POGbX4f460NJQuS3rFeDIGx60imxrfp0WNQwjGF2ImjR3DShTfUuGlgkEw0DhAwmEnEbcGXcZweoEgWsIMOYg08MhvjQ/ZWy/Hlflh/NIcOQBS2329se3a0xIBJRgTciqzCfm8l7VlRrXfLUra9idWCc6zI79KYWb0/Rq3gcBKtwDnJ//A8JWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCJ3dyGVF1pMXFYOhXBvnJz3XPbSqmhBKtaDm6sf47U=;
 b=QN4T4rPt1plMtkJfKdEa5tFWfcpQ404V0A7Ex+gvlf354hnDECboAjLofgS+vn5gw8Wj0iksHjq8fWMRdEqyNREcmXImCBtPN8JQfovh3AiD/zZyrl4nBaCFhXRoAQ+QBBcwoF2kLrlU/YBuNiKFUmNYxe9TkWqEgYmExkoWheF2rQt2RQVfm+MUsl5Q24V1M+4dh1cSi/GmwfZCdMgHFRTY5McHyusZpjd+zZfGkpFnJwLeM1pRtrKg3V2uo0VCh8rYvoVIz4ZWpT27chAhimhBhxKQ7cgkZzAyJwEjLApPJ0FvFzq4usEo22sGWGUnik+2DGR2LyEVR2nyW9iYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 21:45:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 21:45:13 +0000
Message-ID: <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
Date: Thu, 4 Jul 2024 23:45:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: Claudius Heine <ch@denx.de>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
 <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 26455a1b-3deb-44d7-21c3-08dc9c729591
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFI5eW1memJ1MTgrcVE3M3FvY0JvVFF0UndyTzJRQnNOanlTN2N1SUc3eXB2?=
 =?utf-8?B?YVVVWmt0bWtnKzgvdXF2Tk93czlLR3JEOXh0dUVBbDlUMGJCdXAxUGFIb1lQ?=
 =?utf-8?B?SzE0S2hvWDBvMjloSlRDUnVwamFaSEtVMzdUa1F3UzJNT1hQOG41OS9pbnlj?=
 =?utf-8?B?Yzc4WmZmcVdHL2JJSmdGb1pTN3BFSEZZbUVaeFhhUW8vOXB0MEZOcGhlWWln?=
 =?utf-8?B?U2ZzRWRNNFg3WGoyRG1IcXM0c3l0Rkk5SW9qbkhVakJOVHczRXB6MHBRdHl3?=
 =?utf-8?B?S0ZYR0ZjTE43M0NqSFVKSmZpRlBMM09hSzhwZnZ3NGYyamVMU0Q0QXBzT2lh?=
 =?utf-8?B?NkRwaDBvTTRQTjRhZzdHSjc3YmRsM1Nweld3MVp6NGc4V00wVUpVRDFjbGlz?=
 =?utf-8?B?RjV3SmdrSHdMRWh5Yk14enNuemZWUjZEbnJOVU9iZ3Bjbk11UkNEd3J1YW5I?=
 =?utf-8?B?aEhrUzNsL3VCZi90QmthU1lYRGV5ZG5nQjFzS013dkIrRkV6czBobXFhQXhy?=
 =?utf-8?B?dkcyRjRLc0lBT3FxZWQ3QW5YS0tYVHRWWU5yTUJFVFhRVkR2Q3NHc0Ewdkc2?=
 =?utf-8?B?Vjd6dEtiLzZVeEZMbzFyS3dyT0h3eEh2b3JFdE5lZkNUMk5BRU1OQlYrTVRa?=
 =?utf-8?B?STJ0b1BpK0pMMExwMExHcE8xSkdVendFMkhTRE1tRWljY3FaYWJMZTJHS2ZW?=
 =?utf-8?B?Q0MyWHA5L0FYQXVnSndBSzVuRllnOG95M2JkTEs0Zm40KzZSTmR3YXpxbW5E?=
 =?utf-8?B?TXpnRlprYWxpWnFIbE1MSmIxb0VzYWNiandHMjNsL0Fpam90UzRNOUZyanZJ?=
 =?utf-8?B?T2Y2NjdFYnRrTjE1emtkbGZzTHovbkp5TW0rYWF1Q3p6UWNrbmMxS1pERXZX?=
 =?utf-8?B?aVFQZGtuUXZpRlA3dmUxdkJDNlprVEVoQ0VqaEZXYzB3SEUwMVRTNFhVOGtY?=
 =?utf-8?B?eWRITElBKzl5ZkJXK0lFdE00eWxvVmgwemsyeDY5cWNBVDJIdzBOY0RyRzk3?=
 =?utf-8?B?VGdVaUN1NDhUQ1dwdGF3Ynhxdzh1WHQwRzFGNE5ENGFFZmtmQytneGVscG9u?=
 =?utf-8?B?aHVOQW5LZ2tXdURBNXBwZXpuSzZ2Y2lvK2RrWmE3VmJpcWYxY1pwdUpaYWU5?=
 =?utf-8?B?ZnlmYUZtL1dyWkpLWTZPNU9lS1JMaDgwaHM1ZmVqSUdyWDRxM3VhZi9IaGJx?=
 =?utf-8?B?bzk5aWM3QkhuWVV0U2JJdzJsYmFwc1VscHYyeGhMQ2hXR3dHUWtmQW02aVl5?=
 =?utf-8?B?K2RnWDZSL1ZUMFVBSVR4a0pnalpoZ1FRR2RJNFRBVDdaUll0dEtLU0ZUa1dT?=
 =?utf-8?B?UHl5T05GY01TdzNheU44VmFIV3JuUGc0WnFpNDZISmEyVVRYS0xaSWFHdUM5?=
 =?utf-8?B?aXQ3ZmUyeGwvSWpvbGtRY0FCMU5VWWJhOWptWlJKUlZxTnFsYzVnREw3ME1n?=
 =?utf-8?B?Y0FRTlJhelRJbkloL1k4S0VxZEdHejRSR0pkY0VrM3N0b29UaUNKMkMxd05y?=
 =?utf-8?B?UFFZNHNTWTcrZUVPdUFnL1F4b1pMU0wvbFlwUUplRGxTQzNxdzl2YWpsT3Vi?=
 =?utf-8?B?dlozekpvaW1WSy9MSGdWQXoyMzhhd0Nmd0Z6WWwrMFAxWGhheXVKZTBRVWE5?=
 =?utf-8?B?eXd5WmV6UldVQ0todnNGMlZ0ZWpZNFlUc2JQYTZrVTYvWTBSOURPWkZBT1l6?=
 =?utf-8?B?cXNOZjZPVEZMUVFOekpwUmc3MzB5Z2kzYk9yZnNmZkdoejdaWXAvTDZ1ZXNw?=
 =?utf-8?Q?f75CLj47RIULJGPnSE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjlpYk0xSlhZa0c4M0pSbVJRNWR1SlBua2tNOENiTWlUSHlJRXArVDJ5YkZh?=
 =?utf-8?B?U1NrTjhGNVVWd0d4S2FEUjlJZ08wRUVST3dCaDZGVnlneUw4RUlzR0Z2bVRU?=
 =?utf-8?B?cUUvZzltTHBKUHkzSm9ZaTdrUmVQTlY3UzFNS0FPVjI3dVB6R1BHMWVva0V6?=
 =?utf-8?B?NHpTQVRlOE9mbS9MN3hFOG5uam1kMVptTzZ4cVF0VVNmZ0swQWprSkFkcSt6?=
 =?utf-8?B?eEp1U2d0dlNoaTdzWHpzM0tla08xek1jUUtYb0hpaThXeW9scEs0R3R2MWov?=
 =?utf-8?B?YlpBaVk1MUhmRGEyWWVBN1NtK3d6YWVXU204OC9RTG9uVVR1SVVOa1RUOXZQ?=
 =?utf-8?B?eFliR043ZmwzZWZZeG9CTExDMll5SnhrMmpsUjU0eExGV0tBMzNIenMrNVcx?=
 =?utf-8?B?UGNlS2gvcXhzSjVUMWN4a29yejNMak01bDNsbjJiRVVaS01VUjlzUW01ZzBq?=
 =?utf-8?B?M3IxZ2lHQVhxQlNWQllRRFBCNlkwaVI3cHdoeEFSR2pqU0YvWHVMQWY5Z01C?=
 =?utf-8?B?dXI3NnlLMEZXUnZUVjFYaWxhVmRwb3FKUEhHOU5zSmQwOXJrUlJ1K0hwOWJQ?=
 =?utf-8?B?ZFQ1cGRFK3Y4OEhra2ZqcWMzeG1VVUNxVnhqQktWVi9mT0RmNkFRRVQ4U21L?=
 =?utf-8?B?VExBNjFYRy9IaDc0UDF1MThncXZBa2tnSDFrSXMvTHJzalJENGpycmJWSzFG?=
 =?utf-8?B?cVo0OSsyLzU5WTBJL1lrQjhsSURyaTcxNEo3RlRjTExndnhCVFprZUgycnBu?=
 =?utf-8?B?MW9ZMFBKYUlpOGZQdTBKa3JITjY2R0NpU0pPS212U2dVZ2ZScTRxVzFtRk9i?=
 =?utf-8?B?K2FBalNodG16dkZhWGlOamlyVldCZkExT3pLQWh6MVYzTEk1czdNSWFkQ1BD?=
 =?utf-8?B?bnZOdVpGV0VQUmNGTVJqM0xHQTRFd0N0MTR4YkFSVGFJSGNkQkFNclBZLy8r?=
 =?utf-8?B?SWhZNzVOSURPRW52QURaM2ppd3k0MXJzOVhuYlYzTmdsY1AvYVA5SnppRWlN?=
 =?utf-8?B?aWRuUytLeG1ITFVXY1BRUk9Xc3B6UXNtZFpFZEh6KzhrMXE0VVpLSEJ2cndy?=
 =?utf-8?B?Z0NOZW9DTnRrQ3lSRWJQMTR3UjMyRUpmT3BuNHhWdmlKekdoWkl6YzVaSFJ6?=
 =?utf-8?B?Zi96N2poYkhBRG04bWE2dklOdzIyakJ5a1pjTjY4dFluQU44SGh5ZVc0YmlO?=
 =?utf-8?B?NC93WXV4dW9VL3JrOHJUaklMTGF0UHJGSFdNK3FwZlY4czEyZ082cGRmS1g3?=
 =?utf-8?B?TXRaQlJ6Yms5U2krT0ZkaENjZkRxYSthbTlWTnpIbS9KR25WMHFBRlhVczU2?=
 =?utf-8?B?VEJ0bmRmSlh5ZEJJenBJbnlQZFJhV3Q0aWQ3MlBXMCtWQjN2cXNFdERKc2xX?=
 =?utf-8?B?dldxeTdHZ05adkEzUDFEbWJwRWVaTk91Y2YvUXNMVjBIWm52R3dJdk1GWUZP?=
 =?utf-8?B?R0hVN2FJaXpuWi90VGVzakc0RVhlTjlsdVoyVDVISkh1VXpkQmJkMmtkOWI1?=
 =?utf-8?B?TFhCSjEveU1YakV0ZFEzaVlNZ1NUSnRiTStQTFNQY2poa3dhSnNnUzNDN2Jo?=
 =?utf-8?B?QzdhT08xWGlhNHUwcm5HWnV0OXNaTmV6Ymw2cFU5c0MzcUhDNmJ6bjQxRTlM?=
 =?utf-8?B?NTRuT0d6VHExZzVFeXRscW16ZzJQcjNaOEkxZHNnT0ZTVndqZHNBc0hEMVVQ?=
 =?utf-8?B?ZlkxaEFwNHh0amUwb0wzQ1B6ZnlNTUIvYmJkZmdlc1lIeEEvdXphdHY1Yjh5?=
 =?utf-8?B?VlU1MGl1Q2Nyekc0TFNxQ0RnaHRrZEpVQWFyK21lTjIxN0JMRXJDbXAzNGhE?=
 =?utf-8?B?d0ZxQlZuTkk1aWlNeEpzcndHM1cya01oQUgvUStna1BVekhOVXdLVk12RUJS?=
 =?utf-8?B?QWhvdnltc3prUFNSUVZuNGFnQlh2VmpDTEtyRkdvNHViUmpnUG1udEFCempY?=
 =?utf-8?B?clFDUWphend6WkdSNWVTUks2ZFJsUFJuUU4xSWM3b0tNTVJDZmQyak9GZGFm?=
 =?utf-8?B?WTBuZkRlOEZSb3JMWm85bDZTajRYS2tydkRNYTFoelBOTHgrYzkvanBUczRr?=
 =?utf-8?B?TE03cTdiaVhWeGFadGdkWVEvWlRlQlVvYXN1dnhVTTBHVWZPblpNKytjVHVK?=
 =?utf-8?B?cEZlb3g5NCtRUk1mZDIzR2pEbHFZRTVqdzR2UUZ2WGN6L0VEZCtFbW9rTUMr?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26455a1b-3deb-44d7-21c3-08dc9c729591
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 21:45:13.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnozdP8SrMpvx161mp6tXPdhiOisTvRf7nDooSQ0MZjGKBqCegLPOV2RYw8Sj+cDs3SE+cI4fLZYHTTn4ud/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 21:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16377

On 04.07.24 15:29, Claudius Heine wrote:
> Hi Felix,
> 
> On 2024-07-04 2:15 pm, MOESSBAUER, Felix wrote:
>> On Wed, 2024-07-03 at 13:42 +0200, Claudius Heine wrote:
>>> In case a sw-description contains multiple entries of the same file,
>>> swu_files will contains multiples of the same file and thus later
>>> operations fail.
>>
>> Hi, I'm wondering how that can happen, but OK.
> 
> How it happens that there are multiple mentions of the same file in a
> sw-description, or how it happens that it fails?
> 
> Multiple instances of the same file happens when the swupdate software
> collections are used to implement A/B update:
> https://sbabic.github.io/swupdate/sw-description.html#software-collections
> 
> There the same image can be flashed to different devices.
> 

That's a pattern we can avoid these days by using the roundrobin
handler, see recipes-core/images/swu/sw-description.tmpl. Doesn't make
the collection pattern wrong and this fix unneeded.

Still, you may want to check if there is a real need to have an own
sw-description.tmpl downstream - or if there is anything missing in the
upstream template to make it even more useful.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


