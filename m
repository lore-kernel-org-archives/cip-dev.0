Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A6CD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 13:58:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39895.1777989477496845622
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 06:57:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MxtRJWep;
 spf=pass (domain: siemens.com, ip: 52.101.70.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4oWlUJFLwLaesMHzFUwnG89we+9VHsEKigNPI3SbJqIweNav/iwYSSA0V/tX0R6YPWqjdnGmvtzRKfOAYIzoNa4tQpDG9mlUFtqvnUcnhkiYDrcc/wN4ehXJdlMgeBUHlrMd7kJSxVMsVvO5tZybQlobeI+l9AIxMIzMtigq2v4w4BhJz5xkj5S4fEax3QCEi6VZWGvtKTq9Tr9GXFwCLY3aNut4n2u2zjGs56UPd1LHupByME/hbSEeU/SjtknbK0769AeFUjyHNrQij4cOJLFie9Fj4N2zaeNc2stMHnibIoD+ClD2ibAIgFMT8tUUlwV0GlZfL66TctZPKIe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw1RyCcJE4D/FAWXCAM3afRDnA/aQ7zCgidGUNWorRk=;
 b=EwjWPzXTWtluo0ye+fbIRguHddEfzOmPVQmPQ9CnRShFiT9fCQZpNEBTxq+v+CRJPGDT5XHS9RzrXVwMFjVr1868T/8Y4yi52Kj8T/lKoqRxkwtxVuM2EI8ffjgkU8Lw26YXZLBv3s6HVs+vO7mlVB7u4p/lFy+W9ElYuPtomxYck6KamxfB+IcOeP5z4VcfHcEjB7hbcQ0gWfIB70gJNisWY0kPGMeCD5UL1sdL59AldwWNbPmDWmYzIda7f7nmfRomtNV2qJw8LSJvoRefpfJWid8R/5q3gXh1uuBH1J3xZd6+au1BlCdmcXCpbOV+mtDCp/0h+GXYcQTwdOo/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw1RyCcJE4D/FAWXCAM3afRDnA/aQ7zCgidGUNWorRk=;
 b=MxtRJWepGxUnTCxqkkJq50Pg8BCUFZVcJWZJwE/oMpcvAZ1HHe0avn8YjQ43TF6GR01gyh64+C+buzkEvQ0JtaXmCQw2XOlUofAEcakMv0DvWnmskwpl0AzuRcb2XsQ3oR3M4Mqppy/VyB+gqBtUKtbfSudNMVWhi5gzOVdsuvUK7W+96tVUukHbnZw38Rle6QE2nbyN9Z3spoChRHnk+LKmYSDWR2mHq89JNOC3bG2x5dTkiM+SZ0+spfILuszHHb/RfiNKHHY4lJe9vbYnZiMxMZnNYh3DxMZZnFkfG3M3jTXXcEK1Ku2QfdyD5qAGh8F9abQusGd1+KpjC6Zg5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 13:57:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 13:57:51 +0000
Message-ID: <d78b79ae-3098-4048-b15b-b402c3564a8b@siemens.com>
Date: Tue, 5 May 2026 15:57:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: cip-core jobs passing in lava but not in gitlab
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <50ac15d1-1a05-4111-a2ab-789264357320@siemens.com>
 <5a656542-fe6f-46ac-956b-073c32b9cf6c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5a656542-fe6f-46ac-956b-073c32b9cf6c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4474dc93-8eb1-4826-5aa2-08deaaae4c4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	0wWlazSj9wET38AdHDPuMjDNzvgbSf/IAnVxaYCEeWXUVhRTtCoQWIpSCWNnE10isdbzDQcEJnNVf6DndR86roRAj4ZpRVvk6nWFZnfA3rU1hE/4BPspPAQKrTsEYUH7le05hCtmEuaOrAW1VbMcoVfmQQ/Pp2+1dpM7v5qwYMY/SZgyWterItWhvNifbVvnNvQH87wefvfZs9TbJNafS3TZxgzmxspw6sviKFC3942ks6Q7srHZVD1tb+whdP7hd6eSyzQ5KGAiu6mFTBw9c+MH1+CArnlNzbAr5wxZJOa8f+PvCW02QIrwz5kh8IGWjPezEfqHMKsoLaqqs/qllz02mkEMiDWPov9VwAmh8wa84c321dKlu+XimLNT+XjYDvHwaOwUthCAq/UrBnNanPyT4Psa518eW4oOUM2EydGZA3qyZatZgxmHwsy0meiHZTxeROEPuxAeIxW8hxch+SnUCRLEfA9MM1PW9/npEAZTkuwl53THitC3tB2UuWTJyo8IHoAo0KAv+elifa8UWufoHEytS9B988DmnimLYDoCXRK2dn3BgwQFt2NTLq7UbZQtH/xSVrly8Z73HHGjLoN3UNTrGuegOmidw2FDVah3i5hstfxj0N8F4x+mu8boxiieMAehsD5LBCkROVJegQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjVJYlJXNU1YaUk5c3NwN2JsTCtTN09OcmgwcHViNm56dlhJdTVZYXVhbVJl?=
 =?utf-8?B?dUxzTTlNaFRsV3l5OTh0NlJMNVlPQ3ZZT21vLzg3TVlZdnNmT21wNS9DeE1z?=
 =?utf-8?B?a1l1RHNVRkpqTXdwaFNtUDQ2dzIrd2FPcmVJOWhTZFVvYnRaWkxra09aT3Jm?=
 =?utf-8?B?ZkhtMzRzcy9iSUhpSk1TVUVKUHBQVHVocjhMYTVVTnJDcmE0cEhnWnJKb0Vp?=
 =?utf-8?B?RFNreTZrUk4vUis5VmxITXQ3R1RRR0czOWtYR3d2aWJaVFd0bEJwbzdybHZU?=
 =?utf-8?B?Q0N1cGdHcHI5dFhtVENqbXBuOWZDTVFWdjBLV1A3TkFSU0RJSlQxc0dRaVlZ?=
 =?utf-8?B?bS9qZEdBdlg0Y2pDRU9XYzZzREQzTWcwTjFGbTkvYTFRYVJqYXFhZE5pb1dH?=
 =?utf-8?B?OGJ6MUo2OTkvMHJRZHZkMWlkTTJ4WlBXMTVpRXJIZHhwY1pobzZrVUZsMk8v?=
 =?utf-8?B?dXB3ZlpHTWlvSDg4bHV6T1ByUldPYmNsc296ZnpKNm1PYjhBWGkwRFZtejNp?=
 =?utf-8?B?NnQ2R3dGMXdIRTluUFpZS3RTMGJEZlU3TkkxcEpIMUdVdGlBc2hxeVJXNDdo?=
 =?utf-8?B?NXRVajVsMXNUMUN0WkVobG4wSENmcUpMOEFweDZBT3ZjaGlteVNTRnp0TGg5?=
 =?utf-8?B?MS81L24zZWc3RFhOOWNIV09lZTE2aytyc3lvcEUwUEdTUVo4YWorZTdOREw3?=
 =?utf-8?B?eVhtUm5YZWxjYWJxN056WFlPY0hRZFVKdFZJa0orVVhVcFJtYy85UjBQVzFI?=
 =?utf-8?B?TUx1aXEvZ2Izd1p0djFEQnppRVBZMFdabGhuMVl3TCtXcUhVZDIxenJNVUlH?=
 =?utf-8?B?ZXBvQ2FrNkZ0RXZ1U1VCOUx5ZTVrOTdGb25ibTIyVGRFYTNIL2NRUE1ma1kz?=
 =?utf-8?B?SjVUL1lZUzJ3clE4NjdYMVNFMFhKOC9QSnBkazFVL2Y2VDYwbzJSaGdVajNF?=
 =?utf-8?B?L2NRelk0MmZPelFvZ3lDVjFQenRSKyt0MitpcFhXWUpUakJtV3EzTUdqMFo1?=
 =?utf-8?B?VjhtK0dpamx4U2J2ZjJYanpEQWE1NGFERjV6R1lEV3VGSVJuNmlqUWFUeFYv?=
 =?utf-8?B?cjBWM1YxMndOL3FEMHVEM2ZPRkxNSUlxOFpBWU9HWENjV20wNnpzYmZkZ290?=
 =?utf-8?B?Q05jZEdNdTBSLzBmc0M1Ti9YNUFHdGhBaTRROWZnTWpyc3U3TEk3cG1hbUtM?=
 =?utf-8?B?NGNhOXRHZms0VEFNbWUybmV4Z0dTNXMwOHdXcHFDODhtNURSZVRlVlo0NURL?=
 =?utf-8?B?cm52VTZoK25PV1NFbkhrcHFiaGRjMVNwaXBndU9Mc3JaRkR5MnlLR3kzaHFL?=
 =?utf-8?B?aFZPUDQwdWdmZGd5NDJmc0txdE1kcEp0RHVjZUIwbkt6YnZsa3o0TU5hZFFW?=
 =?utf-8?B?UERVMm9wNnQrTlBkSThwRDZPSHJkOTN3NjNIZXd2S3U2QWo5MnQybDNGVEhp?=
 =?utf-8?B?YVh4NXp2aTdGcWR1THhIdUdXaXBvaWJJL29nRzJrbXJURWliUjdYZ0xibnlG?=
 =?utf-8?B?Kzk0SVFHM0tSMHk1K2hoclI5aVE5Um5QYytLWW53VjcvYUE3RWdtU2VnYXdm?=
 =?utf-8?B?Y0lzQmNjYnA3NlgxU29YU1dXclpDb29hZC9FT3dpT3l0cEJ6Q3k5OFJhN3dh?=
 =?utf-8?B?WkpIcmVDN2JXR1lFamY0aXVESk5iYjRvcWtoMEJsVDFDUkgyUzJGZmZoWktJ?=
 =?utf-8?B?OS9NZENLZVkrMVNqRVR4RUNWVkp6Vk5nTTk5QU8yT2tFUW9PNG9NcURPWjZX?=
 =?utf-8?B?RSs4cVRVR21JR2FhRnRacXRwQWdGbmpDZFJOTVdWYXNtUFdZNlVvdDdvQm8z?=
 =?utf-8?B?ZXI3WldNcnVrYUZacU1xVGliazk2Y1NFbnVmMzRqV3Bja1IwNG1NTUJWZmFh?=
 =?utf-8?B?MzVyREx6cWdneHQvS0t5MkZDSWRoR1lzaGJhUzhoRElLVmY4WWYrMlIwL2hR?=
 =?utf-8?B?eElCeU1BTStzMFRQV1NGMzUvLzBBR2gwbXhkeituSC9PcStiY1dweUVudEVY?=
 =?utf-8?B?ZnBKamd3UDdCUThoTzJpZ05KdVljbHVjRVBoWWdDNDZGZ3ZoU0dvYm1mMmdw?=
 =?utf-8?B?ZnBWOXozdjg0bjlUZEs3N0M4SlM0ZzBqMkUxM1JwODYwd3VxRVIzOGJvVlpl?=
 =?utf-8?B?UncxL3plYlh3NHgvNnJLeTJIc3VzWksrZkRha212SitRYWRsUkJrQUhXSEc3?=
 =?utf-8?B?L0N2VUpVUVBicXVvbXFMS1VWcTg4Zjg4VnBxc0FrUWVmV1VrelV5ZjV4WVVy?=
 =?utf-8?B?TmxpZXVGaGdNc0VaYWFqU1dtQWY3Vk1zZEp3YUwzeVluRFN0RkVjS01Dd29Y?=
 =?utf-8?B?V2dya1QxYlBSUkJ4YVNqcjVnNXVlY0JSZHpWeE8ybmN4bWc1ZWxOdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4474dc93-8eb1-4826-5aa2-08deaaae4c4f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 13:57:51.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bC4xgQjk0S2ygUr/cjvSBQprRMQRU/GdM3tWFti7WQ7VD8AQlcBx+X04ZF9rlTZL+OovTcYr90qs1159gWKvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 13:58:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22883

On 04.05.26 22:04, Jan Kiszka wrote:
> On 04.05.26 20:03, Jan Kiszka wrote:
>> Hi all,
>>
>> currently several isar-cip-core jobs on QEMU targets do not pass
>> although they ran successfully in LAVA, e.g.:
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/14205628583
>> https://lava.ciplatform.org/scheduler/job/1437475
>>
>> Seems as if lava-cli gets struck right after kicking off those jobs. I
>> already retried some multiple times, but this didn't help.
>> Interestingly, others are passing, also on retry. I'm still looking for
>> the pattern.
>>
>> Any ideas?
>>
> 
> Now they completed successfully. But retrying the one above gives the 
> same behavior.
> 
> Looking at the log above gives a hint, though:
> 
> ...
> URL: https://lava.ciplatform.org/scheduler/job/1437475
> Something went wrong with SQUAD watch job submission. SQUAD returned:
> SQUAD URL: https://squad.ciplatform.org//api/watchjob/cip-core/secure-boot-testing/35b3ea92/secure-boot-testing_qemu-arm
> SQUAD Backend: cip
> LAVA Job Id: 1437475
> 2026-05-04T17:54:41 lava-dispatcher, installed at version: 2025.04
> ...
> 
> Is SQUAD down?
> 

Apparently: https://squad.ciplatform.org/ - 503

Looking at
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts/submit_lava.sh?ref_type=heads#L240,
it seems we (isar-cip-core) need to talk to SQUAD here to link the LAVA
job, and that interaction is sometimes failing directly, sometimes
hanging first for an hour or so. Quirin will look into adding some
timeout, but the general question is rather if/how we actually benefit
from SQUAD, at least in cip-core context. I never looked into it, or at
least I forgot about that.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

