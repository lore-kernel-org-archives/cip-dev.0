Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBECAC5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:20:27 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12822.1786713621001131703
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RIRPAD6y;
 spf=pass (domain: siemens.com, ip: 40.107.130.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhnPPc+9kKnijfkebmItTxjm5SHxZ/3rjQ4FU80+3FmKz889f+BxuGCzfGShZLqrS7vrZMNyUEvtSuYO6yHcO9WnAeLf4eXJGzSoOFWF0X1/yWWSMo1iwl4yYRC4rmeE2il6u/RBPF2qKCSk8N4/jmkawEoMkuDuByyh/2pxN+u6LUgjjRiA4Co4u4GqY+bkM3iY1EHXynS8wQQ5pzsIPhLVBIgejEOub38eO4dV7uiVbq6yXTdK7zqOoIE9I1e2W5h4vzUzuSSR6B4KDHGmGRyYXP6cLJIlQVNfSKMVMHdjZ4I0ASgYrrqO1Ry1Z8jhEtKUDcn2DrxKzd1mxIG4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjL9CxFOhSp1z4dSczv0hRZ7gi4pkLt+zbOqaB5TjO8=;
 b=o/iuMM2yuykHgBT2Z6SEuaOK9EG5RgHUGxwQFSL7e63qkcWFlZL89q43Lw3f4TGl+uynLwGLfXkoWuQDQxdSLcVnOTwWEPgoWov3542WWvpQzE9o/TMrTQ2X0KPC3m9Zc7IjxkIMfypb8sur4m5taKCRAUvLuRY32tdg5icbLxQ1tMCeNd/x5WQasmJ7O60U9HjZRLEDHevcf3DVokq0D9VkJalCQuGjhKmP+xOasNcDZ4vr5Uubb0KRzDFh0koeFRSCyfnyIHCmZNgelvoQCm4T7najyAywXTiBtYA6pMq+sctb7KDq95egGcxRO86PpwF9IMAIAB1XN/GCOvOi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjL9CxFOhSp1z4dSczv0hRZ7gi4pkLt+zbOqaB5TjO8=;
 b=RIRPAD6yUBfBPmmzQgyHQZa2AmC8p5EX3TA8Z3bC+kQmtJiRGPAqhufkcjr/bP8gHnHzjL3vKk/jWA/SjLZrsa5hKpBYyNRZXxETTaw/pXAvgHjfuKz9Q7rZevVEEf2G5h8/PiePIJkpeAScfistny9CXt/rfyyHO+GMl/ELL6EWcJo4v7p6kZsj71EJ2tRgOruHwMf4vwqZE8ROMCfMUIygzzvuHK2AbVtjsQu+Zn+WIrmdWYbZu+LpeRPUq+2I6B1vFtpfp3GbMc36YCAI7xBeIpugjVwC3lp+vs569ajLXOCC/ZQWbMD3w/j4/uro7Mt2ut22Dtgjuvi4hr7oXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV4PR10MB9594.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 13:20:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 13:20:16 +0000
Message-ID: <a6bfc8d0-3f12-4a14-986f-3d09aacc6b02@siemens.com>
Date: Fri, 14 Aug 2026 15:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/5] switch to rootless build
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 Michael Adler <michael.adler@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <592f75fa-e569-4d21-abd6-0bdca1cfb5fc@siemens.com>
 <ff66fca2-4e47-42c1-b88c-7e736fd68114@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ff66fca2-4e47-42c1-b88c-7e736fd68114@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV4PR10MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: e24c715f-23f9-4c54-192d-08defa06c79a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|4143699003|5023799004|22082099003|55112099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	kZ7c09aA3AsEDcx4lYr4hOL79bJx8hcCgmAMj4K2auVaU9iX/kb0slyEI50o85v2ztZSP77yQAYfACozgvvlSBTE3Q9Y7oFkMJAlY7I7DcPcea4mwaQs2JqM3oX581fRo8fNeFNRhzEeCjh/lL1Wf6JQmluvkE+GNN13iMZGIDnHJvN5Ja2Zb3DQpdPE/rhnFMjSYNFl1KIMKkIa3LGFQej1F/V0hJd6J456qY8S9qYnXoggzieL1NAU5P53e94wcWDk6s/Gy2HQDnlsy7ygZxBZ0mB9sbzocl1bXPwE1/aciYmdVCQC1bxYO6OZyfmskzUuos/NN5n9KbVjmIDZXwjDd0NAhEbuf4rs1uG/u9HJx7oUVn7Lq2ZKG5v2KvGe7Qdpis7bx5/86ZoAdcTvORSpBf/l4PoGXk/bkw2amXdj2MD4oBLmF6pO1ywjrnHU7XSNYMHio7pNB1S5j2SPV5pQZYBHnLn0hMq25h2m/Qw7xe9vKpNWZm2Dt/7ocY8USCop6OdyKNff3yXG4/XbJGUX0mvSYjP4UdF04xIgIVNBDkYg9h8ehKnLj2qL57j3HfvS+1x3GIiklPMPt7FpwXg9tSHGwUbwWd/Zqhb9vBBcc2QHd3hqUYbF8aOwkRYUxOsa/Th6l3hH8mfNBsLAQCzzK0k7q4OdzACPe/1T2O8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(5023799004)(22082099003)(55112099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U21ndnlwWWFlYVo5WVZSN05kQjFjakFCY2ptRWF6UXVxc0RpMnExK3ZtR3FL?=
 =?utf-8?B?MDNpc0xQNUpuODkxM1hjc25XeHBiUE02YTY5U1pGMElqcjNNalMzY2V3M295?=
 =?utf-8?B?Vzh6OU5zaTNlSUl2QkZGTzBDelFXZU5uVEZ3WXMrMGVnSEJiYXVvM3VpSno4?=
 =?utf-8?B?MDBScmNkV0lDdUt6R0VWTDJrdkxxenhXdElIWFJSQjZMOE5lanJiWldaNDc2?=
 =?utf-8?B?OE5GaHdHbVFCWlBML3hUZWdmVUZ2U2pXZng4NVF5Q3VNemhLTWprTDVSSTM3?=
 =?utf-8?B?Y2xZaXhlVlUyb1B5NDVnQjVEWkdKRDExK1FqT0VVVHpJZnVWZ1UwMG9Tdisy?=
 =?utf-8?B?aVVwbkY5SUloNWFhakpCRXAxdjhMM0F2aVlraDl4TTNlSWFjZ2hHUG1mN3Bu?=
 =?utf-8?B?WGJQaXIzc2V1TFlnYVU0NnAxSU94ZG8wMmQ4WmJKSkZIQm5GWjhHaGVuWFFm?=
 =?utf-8?B?WWhQYTk1NDlIUWc5UWJwWUFBOTllbTBMcXdYSWozOUdFc3pkeUdValNmMHZl?=
 =?utf-8?B?S1M4Z0hRMjZ0YVJGeHZVTy9vbGt3NzI5SWdzVVgvb3l3TTNmcWVuUlBpSnFG?=
 =?utf-8?B?RWJ5dFZHUmRrTDlycFU0T2FheG13RHVvZGVINWU0MmdOWmxZS0tSQmtjQWhL?=
 =?utf-8?B?cE5pWk1ZRVRUS09QY1ZJTFdZaXQxZnRlWEJRd1lQVml2UnVnSjFHNEwxUFFN?=
 =?utf-8?B?eEZMN3ZFeWlWTkR1WkJockd5QXZ6Uit5SWlnczJsTldTVElGSEM0UTg0SlpF?=
 =?utf-8?B?TVI3Z3ZvaEtZOVl6cTBLbDVpWlVHZ3ZkV1NPTU11VDBISFE4ZFd0c3JkTVVP?=
 =?utf-8?B?cXZpQ216MGhRb3FOOW5WSlpRRmgrQUJkdFZaMlFVYXpyWXFrM0plWjhTN25i?=
 =?utf-8?B?dWxMWitDYU5IcTNhWXNxNnowUzBML0VDaEwwUnljV0JvUmVmeU8wWGM3M1JT?=
 =?utf-8?B?YXZqRllxNnVlRlRzSEV2cmhDeWNIRUhvWjk2dkpONVBoR2tjNllaS0RtTk9v?=
 =?utf-8?B?d1N5aW8wbFlQN1d1Nm1JV2lIK2hadE1ONFE5Z08vakdabGRDTDhJLzR6R0N2?=
 =?utf-8?B?VkEwTWpnQWFWdEJiUnNlRVZRejlPQzBPQSt4WnhQc2Fpa1ppNDdYSUtEdkdB?=
 =?utf-8?B?dVY4MHo3dDNvM3JHbmc3VWVsVUdFYlovaTZYL2wxamdoYnV4T1ZxZytrSnNY?=
 =?utf-8?B?cEZSUFEzd0s3VlZFemE2ZkJ4MzdUUVBneTRQNVNVdDc5cUlqMzZZeGo4amly?=
 =?utf-8?B?bGZLeE5PRXgvcVV3Y1FlWDhBeHFndDh0bFNIT1M2QTczVURFMnB3L1B0eGR3?=
 =?utf-8?B?UFlXbldyNWVzK1Fkb0h0UUNnZFNQRU9EUGtSWGh2UWplanhqNng1bFk1VEQ5?=
 =?utf-8?B?TnZjdEh1bUtlWVptNjh6U0dub1Y0eGk2RXNQU0RmUlB4eWtCZ3pNUFNmSXFW?=
 =?utf-8?B?RDA4ZjIzTHR5RlBWSzloMUU5a215MDNPNmFQQXNvNXd0d0FYOCtmeFFhSnA1?=
 =?utf-8?B?eTdncVBzcjdCaFF6cTNMUUU5emRGWmxXYkpmNlVsVk5MOG9pWUg2NnNWODAr?=
 =?utf-8?B?Nzl5WUNZUGZqU0I3SjdmOEkxRkZjZGZESDkrZ0RmUUxHMCswVnJxM3NQdU1v?=
 =?utf-8?B?OWJWK3luZW1qdjdqUE1jNHJIamhhYjFBUU9CTDZ4anVrd2xMVDNNN2NlQTNq?=
 =?utf-8?B?UHlBY0dqKzZUdUhrNmZjUFBLQVV6NGFyUnRETkJxbGlZT1B4TXNpQThFZlRq?=
 =?utf-8?B?NzhGanBwdW5JTmhQVVczMllsS01Zc0tnbFVyQ0RBOS9Rb2VsV0VTSWUzMGU4?=
 =?utf-8?B?aXBya1liNDRqNDAxSnkwcUYxVHZpd0ppZ0hsU2haTnVDVTY4eUw3ZTRJWEdD?=
 =?utf-8?B?a2JiSGoxeGhRSEpCQ1piTXNkS2VBOHRpRk1IdXgvdlgvOGVTdE9Xc3RtRlJv?=
 =?utf-8?B?MXVZUVVJaTNUeWtsVXVpOCsrb21SOGplWEY1WnZTK2pxeG5hQjhjdGlmeE0w?=
 =?utf-8?B?L1FVdWRIRmlnVmw4N3JrVnJvNDJGZDlIdlFnQkhmaUEyb2w1aFVzblRjYVN3?=
 =?utf-8?B?T0xoV29vWkxBNHBoSks0K081aG1vL0RIT2NDUC9heTFFMlVHcSs3Mm40azB3?=
 =?utf-8?B?RW12Tzh2UE9JR0xqOWpLMFpaWWxPQ3JmbE1vcUJrVk9WTTFlOUNrTS9DVzJL?=
 =?utf-8?B?K1FSMVBhRW9sZDVwODBETzkzRHdJN3JqZWdCS2c1aTNLTVFyek1TT2h5L3BB?=
 =?utf-8?B?elc3ZHNKejBzQlA4d24xZ0ZGY1pZRXdQZVUyczliTHJrWm5scVFDVEV3TWxt?=
 =?utf-8?B?elo4RnRKVU45d3RXNEpTRFdkdnRRSFZVWmtjRStQNk4xSzc1ak9la08rZmcr?=
 =?utf-8?Q?qtpcSv1NyvQ79bdg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c715f-23f9-4c54-192d-08defa06c79a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:20:16.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk9q/K4r/c6TRfMK0wCVmVA8Ab7TwIDB2vQ7Cg0jDBRoWmHvKHEjODcWdS1+vHUvlNANYmsc53cCg54C3D7QpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB9594
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 13:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23943

On 13.08.26 16:10, Jan Kiszka wrote:
> On 28.07.26 18:55, Jan Kiszka wrote:
>> On 28.07.26 15:12, Quirin Gylstorff wrote:
>>> This patchset contains the necessary changes to switch
>>> isar-cip-core to the new rootless build.
>>>
>>> Changes v2:
>>>  - add Debian release requirement for rootless builds
>>>  - use kas purge in .reproducible-check-ci.yml
>>>  - use correct kas-container
>>>
>>> Quirin Gylstorff (5):
>>>   update to kas 5.4
>>>   update Isar to contain rootless changes
>>>   use run_priviledged instead of sudo
>>>   switch to isar-rootless
>>>   update README.md for rootless build
>>>
>>>  .gitlab-ci.yml                          |   2 +-
>>>  .reproducible-check-ci.yml              |   3 +-
>>>  Kconfig                                 |   2 +-
>>>  README.md                               |   8 +-
>>>  classes-recipe/image_uuid.bbclass       |   4 +-
>>>  classes-recipe/read-only-rootfs.bbclass |   8 +-
>>>  kas-cip.yml                             |   4 +-
>>>  kas-container                           | 300 +++++++++++++-----------
>>>  8 files changed, 176 insertions(+), 155 deletions(-)
>>>
>>
>> Thanks, merged with the mentioned changes.
>>
> 
> Michael AI identified remaining issues in kas that currently prevent us

Haha, I wanted to write "Michael and AI" here, not suggesting that
Michael is an AI.

Jan

> from moving forward with rootless in CI - local single builds are fine.
> I will move certain patches from next to a wip/rootless branch for now
> until we have a new kas release with those issues fixed. Some backward
> compatible patches may stay in next, though, still need to check.
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

