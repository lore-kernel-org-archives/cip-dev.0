Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F63C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 15:53:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.941.1789401208350079308
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 08:53:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=v0+CTcUt;
 spf=pass (domain: siemens.com, ip: 40.107.159.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brz9JowCfBNONodFQD9CUW64lkUsBciyj56vTrlcgfQz7yiHEDaiaG+q5aPHWqm7eZIuucMLOZjxIEmkCQZMOZNzg9qCE+3g8PW2iXwc7BBndVEtAAW/FqO3LT1sFn2ZjyNlwRz1wBwIiBRTfltqLsxgvXnTx3m7PJgfXfqwHxJM5QbUgpT55WmxU3zAZJW0W+ILGvDOhFzS4Lkc3RLgjtRnOBfPW50RzxSwF6TYDtO/F2kFiji/jfjfp6/hhCGNwmog6DaOlMYZFX7hh6tmPvqvX/KxL3TkC1IEvOWl0HfqP+G4tibBVW/ovi2Lm1U5f598cqESLdxYgH7s2c3X3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgHpa0NbklLoyScD1DI9sx9kUb2pVMBE3Hsb8C4Jm7g=;
 b=AtUpZBgLhZcs0OlPKvJkeZtwt4Rzq8iwW7l4wd4A/2uRu+X5/YXcOttPdYqY1jnOF5aTZyTPUxpMPVQk9yHDhLB2jqdZn8KfYfTwTUc06vzvkq8/E48yMHLxFV1GW6qDWBQ+19/08m6axqu7wc+JIjwm1B3DlwBL2iEex/hnqQNNRH2zDNfI7blV+ADtHsUhX6lojfSlHVmZQ/q3ilqSktm4icdsjJcLLWC0YnJRSX63NbFSfdZb7Goc3BiF2yYcNOMU+UaWJoHlXpzNIORdQguLW0Fy9h9gR3wWGhDcMBS+jy8p4P+RqOwBOnnSlwGw5XsG0J/S/ONiFxLJt2aMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgHpa0NbklLoyScD1DI9sx9kUb2pVMBE3Hsb8C4Jm7g=;
 b=v0+CTcUtkm4dctdET2i2HsRhMObbANGGL95n/INssh/MpY71/uWUPbq85Nc65cBI6ZpnpeMFAud2LMcl/H2uikSumRVphEiaOVOs2mZvBU9VGlcyDi0+7K74ticvJf3fz0/pvfI3QG3fQocpxRf91HBDVYALvyxUkeTcZmrk56txQTd2RR/+HwJK0sMaYZkvOZdlG4qOvQg/PGp4E3+lxGdMAV4iVbzYASDEGOHrNfR/PsMKO1hIe/OFEaq0lX6PocAED/NXqy9J6b6nPZ+TVOIlH738V+p1cWOdy3zKgam5IEUlKJs6q9TU6hnsQB7q/2WITB4MyWZFDIPQwLvs2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:53:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:53:24 +0000
Message-ID: <ae35acaf-61c6-47a7-9c7c-1eef062d5880@siemens.com>
Date: Mon, 14 Sep 2026 17:53:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 07/12] Add class for validating
 the CIS options in the kernel config
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
 <5cbd3567-d84b-4a87-a029-b6bfc0ac2b43@siemens.com>
 <e6e65f01-2a78-4a7f-b329-4a35e53af1fa@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e6e65f01-2a78-4a7f-b329-4a35e53af1fa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e0ff5c-7e79-45fb-648c-08df12784edf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	RHJj6WhoT/gThpw8XLrs/lEp4+MiqCTaDCW11/tDsm9e9aOZqxJo1B9j3NZg3yjxbonbmgTggOBHkZYsAIjUYGP1w87GsMaH8I9IEtF7UHg1oJ8ROGfPu9ldJlqlysTNyaLeIlyAb1iS1w39rzAvdkAKUZdHkesIs6iXQWKmUB6pMHaoI48FLxQPM3t8rxVFhEOvNyqC+WrFCEBWGtVpQzrD06teOK7eUNG8EniUqZQF8+Fm2Xji2/kFiuqMslMY0Shs8Kei1sGdecQ/sZI097xObWB16ryHYrkJNXJ7C3pAyJGP0OY8cmNKykvpanFLhVCdKrD/lPf1XR+8AcgmuS/3/lr6KbHKd6uGPdxm770JAjQ+88vEgU6gbx04+leG0GsZKMJv21gm/FCscZ3Qeh33L4Q5lY6sTdGY32YzbUQxb2C1XQQyYrR14JCUmNbJVEOqnBnyeAPn0c9nnSQdOsiyKjoSSSFb8tAQMb2J74wkGj92Z2E6rbPBVX1eQjgMdIbgA2cbh/wO19u1mEERf2GGlj6Yl9nv6Qt7pfKiKVrRUgU/feltbdeBR2fUdo9145DdJrZWNpR0ewZrbkApPhDTooV2fxwRO0wabJwfBOVsxYsBMy2ntdqR7hSfFfmE//aXG/96eDs9L6OY0CzAxKjUKrIuCYG86E8LUZM5CI0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlJjZGxUdFhBT2ZZTk5Jd2Y5OG9WQmo1TVorSm5TRFp1b09XM3lnL1lKYTho?=
 =?utf-8?B?NE1ZNHRJVWtORnNRY1d4Qy91RkJCZFRwbTJQbXFmTExlY2ExdG1QTlJ1YzQv?=
 =?utf-8?B?YmNWWEg5QjFqTjBvMG4wRE1GbTBDcG0vSm9xNWt3VGN5Mm45dnhYSDhKeFpD?=
 =?utf-8?B?R2FBZXhsQ3dlVUdIb0dnUnZPZ1ZvaTdMTmxpbFZMeXk3QndhNjBKUWpScTAy?=
 =?utf-8?B?ZmNFWlBNUVdDNzlhTTUyVFR2K3JXaGVDSVdSVDBaWmE2UjdmSU9NN284TEtU?=
 =?utf-8?B?WnZIQ21TM3FlV3JNajFwaEJsODAwRk9RYlZ4R3k0Z0NaaXhqL1FObVhKbFBW?=
 =?utf-8?B?cU9laGx2THhkZ3hZVEF5aEFlSTBTSFdBNXNsVnVHNitHakNOemRsR3U0eEx4?=
 =?utf-8?B?UDJjZzBiMnR0K0lld1pPUFUrSHpiRk5ySjhZRUpWYVF4cEl4anMyUW8zRGdY?=
 =?utf-8?B?WEJNUlU1dXIwRi9YMmdaUlVJZC9HQU80cHJHVnMyQjRFd2hrbG9jaE54NEZm?=
 =?utf-8?B?SENBbDhTYUFlVFFYVTBWZlV6MmdYUXg1c3J1QzZ3Wk5ldHVPWk11UFVzajRr?=
 =?utf-8?B?bHlRR0FSdFA0RmtZUUhEa2dhVXpVUjRuaGpFam9nNmdvOWdLNlpnd2JjVitC?=
 =?utf-8?B?NmpBVWJER212ZUhBNEp0M0d0NnZ1YXdMQXkxVThDUGQzcjZ6WXpoR05lVW5N?=
 =?utf-8?B?SEJia0Z6VWlqVm9iYmN6SWQ2cXBJVlJ2ZzUrNDgvTGpZaE41OHFDTDNxL1c4?=
 =?utf-8?B?OFhXNGU2dTJDNlloUDBMNjMxQzFlNEtmQjZpM01GMkMzODFVODYrSUtkYm14?=
 =?utf-8?B?dlVMN3hVaE9uT21ISGpNbDhlNDhkd1lsNU9HUjQ3Mm5zakd2VGd5bkdTZ1Bp?=
 =?utf-8?B?SXA5eERhK1g0dUcwSUQ3cTJUYXJYSG1qT1pkanBVcDd2end6WHpUUllNaWtK?=
 =?utf-8?B?b0xjNlBJUDZWTzRKdEFNUzlIb0VsRlVyYVplL2pCeTQwYW9lQ3JTcnZDeXJn?=
 =?utf-8?B?RUMydjBIUHY1MnJObFAwd2NrNVlvQVBJdmEyL2c3Yk1hakw1REt3dGtVaHZQ?=
 =?utf-8?B?TGhXRVBoUlN6TEFFR1dRVVFyQXVSME1Bd0pYT0wwa0VwTDhhSFZVOTErM0s1?=
 =?utf-8?B?MWs5SG96TUxqdTM4cUh2V0hWWTk4TFNPUnFPdU8rOWlrMlJnWVB4Q25DWHgr?=
 =?utf-8?B?Z1IyYWZjbVNnenBGaVdISXRnQUd5TS9lZllMUm5PQ2o3TU92YVJyb0xUb1VW?=
 =?utf-8?B?dDVtczBuVVVoNEdhaEVvZkdJTStSaHJwSm9TZzVzUHhwYUVORE1rOFZWZ2Zu?=
 =?utf-8?B?U2xXTUhOVlEwdUU5MGY0K2oxZU1rS1F0TnNKajZVaE9PSXFHWGhORkVDWVl6?=
 =?utf-8?B?cXVXNTRxU3RLNWZleUpCeHBLUEdUQ0VJNXUzTTVaL2VncW5NNDNJWGVEU3BK?=
 =?utf-8?B?dzMvem9ZZGtHay8rcThrc2RSRU9sRnp5NFpKOUdCcTNQdzFuc2dETEIrSU15?=
 =?utf-8?B?QThINFlpL1dISnVhK0w1TExDQWhUTEVoUFJDTCtWak9WWFJBaDl6eHE5NGV0?=
 =?utf-8?B?UTV4c0YzblBxZWo4SWRwVjhjRGdCWGgxZStHMkpXaTNFYjdYbWcxREZEUlFT?=
 =?utf-8?B?SW1oZ1I1Ni9NendDS0FYQ3QrV3FUdmUweVpVSnBJTDRBb3pYTGpWcUlDTCtM?=
 =?utf-8?B?dUJXY3h0OC9qQ0FweHVYZ1l3WU9PYjFnaTN1SnJKN3cwNzl3TVJRUlFYWXd0?=
 =?utf-8?B?TlJPUU1hL3BDL2hKMDFRbUgxYk81NlBUMm15aEF2dFR2aDdxQmVmSHBudTJ1?=
 =?utf-8?B?clpzLzJ6Z1pFNitqWXVxZU1adVVjNGFGSE9HQ3pPWkJpU204ZmZkZWpTdFJ1?=
 =?utf-8?B?M3BFR0I4RVppMTZyd2JaeHoyNkVETDVHcGFtYzFWWGpoZUg1NUx2bCtBZEFH?=
 =?utf-8?B?Rk11bVprNWo3VE9VcDNXM1VIV1pmWU9VQ1FKL0tIY25DUWlRK3h5K3kyUk11?=
 =?utf-8?B?YUduNUwzTXNIV3loNkRZUTNZTGZmNHNLRzUzaEgxTlFXSDZYSktqdU1nZjZt?=
 =?utf-8?B?Vm52UlBFSUs2YmZQbVV1RHB6TFNUMVVBTG9yM2x0aURtaFpoV0c5Skt0cnFG?=
 =?utf-8?B?WlBETWNROHMyQmwyQWJtbTNJdWFzUzc2ZGdlS2xhZWRHeW5jdCtWZzlCbUM3?=
 =?utf-8?B?UC9mc2JJcFNuY09keXNOMUpIUmtlY0VxTEE1VmJHZytzeXRDTGVHeXdHMGxu?=
 =?utf-8?B?SEhoS3d6RUJLMEZpais5S0xZUmpCdnFKblNsUUNmS3dnS1VBa1IrYTllTzhw?=
 =?utf-8?B?dTJyNXdNZTF2YVBBcytOVG5NOWErY1lQU0prSWY3eE1GeEZWaVdLQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e0ff5c-7e79-45fb-648c-08df12784edf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:53:23.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzbyJT0ZSiS9Wu62aX3pSp36+Ngyj3njd731e0/L6/YmfVAaQUp2IEUlVffSsgZH/IRlnO1nCxiVTIO/K1H+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9009
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 15:53:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24179

On 14.09.26 17:46, Quirin Gylstorff wrote:
> 
> 
> On 8/25/26 7:00 PM, Jan Kiszka wrote:
>> On 24.08.26 11:46, Quirin Gylstorff wrote:
>>> If CIS hardening options have been configured that change the
>>> kernel configuration, this class checks whether the correct options
>>> are selected in the resulting kernel configuration in ROOTFSDIR.
>>
>> I think I already pointed out that checking for some random file in the
>> rootfs is NOT reliable, specifically when there is no config deployed.
>> Please check the config that was used to build the kernel, possibly
>> leaving "signature" if the check passed which can then also be
>> runtime-validated (if that is really needed).
> Currently the isar kernel build and Debian build all deploy the kernel
> configuration into /boot.
> 
> We can add for example the shasum of the kernel configuration to image.

No, it's not about that. It is about doing the check in the kernel
build, offline, and then passing a confirmation of a passed check down
the pipe.

Jan

> The question would be where to store them as the should not be in the
> rootfs if for example a kernel only update should be possible.
> 
> Quirin
> 
>>
>> Jan
>>
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

