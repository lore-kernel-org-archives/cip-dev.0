Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B1C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 06:07:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web11.41662.1745820325284046782
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 23:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cRp2ZXfN;
 spf=pass (domain: siemens.com, ip: 40.107.21.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9VNpu3FVowaRGI6iwP4wfS6J5LKU5+G8VU/iKLetpeAkrIstRhrmF83Rb0+TUwMFEtNxqCc2BNSgeDrj8/XLwilxcZVx17LM+GjPs/b8Y1TunBi2zquZy0XRv2lYtx31f0Xqwn7LU6WgSwhXUU2sKiYbfamrkMPFGtoMMl/OAWeRE1ZVQ6R7byFs/X4M4QmuCD3nCV0/M+MoeHBk3ywlDdsj3NyaWmV4fSVEXX3Ucan2wx8ylJE8MrK3FttuVsNb0TbkGtKCm6eA9rTXk5zkz5/MfOiIO3B0OX7QCk7mF1r/5qwIpmNLIqqodm5jnqeRqnj198JuMXS/HP3jmlrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm1wUB/5xNIW/7kduXrQFfsa3i0TNjl+4JjkerVfsnk=;
 b=Y/lNCVDgOtYlQb/wIkcTfnF+ZnZ5R6hFhokN6bt4pGEh4zCSAwTvTdIY48+x35GV964OzefiSYfSFFx1iALgvMUXjHTBcbfuDTO5bNGT/2uU5SzfWUveSJg2kAFY1nBN61SjKzyoHMZfMcGg32y/1EZWvtW0jQbnTvJTEUOOz8b7rk/8TX+xKb+g0ZI8y3pNRdfuhCSReqN0dBDQqc+sJd7kbHqU3Lh/0IC1+OIOPQNKTwZZPAT/MlVaAXozXxxmGtRaHLT8o9KO9uB5qqTYb2h29V1GehDdZ7DEtcVe2ibzA2GNXQArY30awRSThEI7yEaoZzHEmD004LG/nwnnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm1wUB/5xNIW/7kduXrQFfsa3i0TNjl+4JjkerVfsnk=;
 b=cRp2ZXfN4MLVKLLob9tlcmNLDHT9vxA4h2MHWoWSBDSMUO3U8FiJDGyB6CroBNO0mlWd19BP+pLVlx+r4EiOxK46MwhMsEoNXAe1xhE7xkgOcy0OoFaoSPKf2BTFCa6Tsh1U/p2eXu8H1e1NYbq7SApvUTKeJhO69a3SRIfMX3qJ031mblaWJS1v8t/ESjKr6NevA2yw/QUvkx4Vxn5pKxtVgGcJzMfPjQDvBLe5I2tEWKT2OU/Lvoo0Cwl2bXKZpSz5RyzeVnuK9BTBtm0L8zsK2NLrgsqxNC1X5lDPVMJKOvdAl3l6womA/I6EthAp8QTLwOfHlLB3sXfE/07YbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Mon, 28 Apr
 2025 06:05:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 06:05:21 +0000
Message-ID: <e8b8c58f-e56e-40fc-a313-69ef7087ee1c@siemens.com>
Date: Mon, 28 Apr 2025 08:05:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v5 0/2] Update IEC job timeouts based on
 targets
To: Sai.Sathujoda@toshiba-tsip.com,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 cip-dev@lists.cip-project.org
References: <20250422112751.3620163-1-Sai.Sathujoda@toshiba-tsip.com>
 <79d61200-975a-41a4-8f46-5fe5bf3ead1b@siemens.com>
 <OS7PR01MB148412D8F02FA189FB973B267C2BB2@OS7PR01MB14841.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS7PR01MB148412D8F02FA189FB973B267C2BB2@OS7PR01MB14841.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: d1989e42-2f7c-429d-bb3c-08dd861aa874
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGUxSTNwVmV1eE9hVnZReUlrdU5vT1BCZjdmSHNNQkxJcTZBQzY2WnI5ZVE5?=
 =?utf-8?B?Mm1hTk5HY1VmczNXZ0F6QXppRlJHWWxWdUhYakNIbEZCWlM4Nm9zMnpVUGNl?=
 =?utf-8?B?ZFpyeFNtTmJKRVpSMEJHdUM1VFhIemFzLzRqaXQwQUgyUGlCazl6SXZUbHBx?=
 =?utf-8?B?UVJIZlZKcXRtaURrSEttU0ZUMUJRSkVVZFFGNS9MREJRTW4yK2RWSC9Jdmo3?=
 =?utf-8?B?YVBSZ0pGdzAzSE15SEx0OWFpZ3ZFamlBcHRncjIvQWRWYkZvYzQ5QW9OOE1r?=
 =?utf-8?B?T3NGUzhVSUVvYnJycCtQT1lwMWJUbDlYS2tzVGhaQkYyTDByK3k0YlFITTJJ?=
 =?utf-8?B?Z2Zmc2lqd3pnR2VTWTJJcmFVZTRPY2RiR0pEY1dGYzR0T1lNSCtWSTJqV3Ey?=
 =?utf-8?B?cTZTN2dYZWg2cWRBM0RCQXNONUwrZ0VVU0ZaSXhlc3Zpc29HN2YvODBNa1hQ?=
 =?utf-8?B?a0xhMUo0eVdyaUZIV0pmSEVDTkFNeHZ1RTkyblRGWG5MZGRFWElKVExrOFh1?=
 =?utf-8?B?MEdFbzNOWkRFbjBvS1IyWnZMVTVsQlRRN2tMOXdMb3lDT3hSeVpZemFiOC9X?=
 =?utf-8?B?WTRic2lPeWNOWk5yZU4wbU9VWXExRlpHcUt1azBrSHBZU0dLblllRzZvS1Uw?=
 =?utf-8?B?YzdmU000VG1WeUo1dW5FeEo4azBJekhCb3F1WkhwbElVRjdoT0Jvd0NOM1BK?=
 =?utf-8?B?QXR3dkxqaEJ2SDEwRVRsTDhXSDZmZGRrS3RkdmpicjBzZ29VTTQzUVY2eFlH?=
 =?utf-8?B?TmRhMFJKK1JleDkxNGYwVEdVYW16MmFEVHRDMmdTVVhGeTZaaVdkeXNHNnhI?=
 =?utf-8?B?Rmlqd0RwcHNneVFJQ0ErUjIra1R6VWNadmdZcnB1OEIyamxNc1YwZGRFdFNG?=
 =?utf-8?B?Q1Z5ZkRYSkc5V0YrRkZ3YmE0eVg1TUhuUnlUZUdkbFZqcEZuY3NFYnA5Q24y?=
 =?utf-8?B?L2Z3VWVwMmQvWmFLWHEzcko2Sm5ncnM5SnJseERvWkJhcUFkTFNoQ1lvSy8z?=
 =?utf-8?B?RWxidWlYTFFiUkZjUFd5aXFuVDJFT01NZ0ltUHQ1dFdTM3dwWkYwQkt5dXhn?=
 =?utf-8?B?OU9OZldSWjBtQkorL2hDdFkwTkJpWHd2QW1yYks0dDhmejlxVmxMQ3V0bndt?=
 =?utf-8?B?RU84ODFxTjBOLzROSXlvb2V6TUJhVFdnNE1HWnNIbG9FOFFmSVptWURPZERq?=
 =?utf-8?B?SXFEQk9lV1JjRDNXUGg1TVNLaDZKQmxLc21WOVY3U2xrUXFlYkNkK3dxbDBP?=
 =?utf-8?B?N0ZHT2pnb1ZFZm1vT0ZVK1pGSUp2L2FveGJ0dHk3TklncTFsRUUrQWQrZEtl?=
 =?utf-8?B?YzN3R0V3WGR6ZEhXWk5PMmdFcDk1NDk5Wmp4empDTStLNEN6ajFkaytNaWJo?=
 =?utf-8?B?M25TbVhRL0V5L0RPdnlRM3h5cDNPUEdaN09DaXZzbnF2NEtLMkZLTmFqYkh1?=
 =?utf-8?B?NU5VNUxPOUdwd1k2a25lSC8yZm0veStscklQTjFUdnY4K0VzRU5MWGdsM2ty?=
 =?utf-8?B?SFgrb1VwWFFSc0VmeStGUC9GNVJ3UU44YUdtQTZpTWFkbC9tdWpFYk56dVEv?=
 =?utf-8?B?bkZEVnArTHk4VDVmMHdkTTVWcm5GdWdlMUFlZ0JvRTQ4a0FiMEhvTlFQODRs?=
 =?utf-8?B?U0didGJPMzBLMmVSbUwvYVFaQ2syUTZTeVNNd3RKSEh4WXo3MjJhaTJvY2dK?=
 =?utf-8?B?M2Vsb1pEWDMvYm1FVWd6dlNNNEJWK1JCTjBMMVFGL1VLUC9VTVE3U2svNHFs?=
 =?utf-8?B?R2t0MEZWdmdnMFlxY3hHNWh0M3BsUTJwQnloendDWmdadi8vd25yWXZTR0dY?=
 =?utf-8?Q?ahqeR5vFzWL9+kJdLw6PtK9FOYxFfNGd8Ncmo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHVsdFVMbzdadUtMdHc0ZGxwM3JBU0FYLzVVcVY0Rnd3WWdQODh3Q2V4TUpo?=
 =?utf-8?B?L3ZFOUFYRFBUZzNlWWR1TkFDZHVkNTVmaXY0MkMzem9uazUxeTVGTVhwcUt6?=
 =?utf-8?B?SG4vYjgxSVVBV2NWZEx1aW9OdHc2NVlSaWlTVFFvRWpvYmpOalJGeUM5YU9z?=
 =?utf-8?B?eGc2UDFHRnh0V3RrNWxKSjFXVjBDc08yWUl6QmJ5NGV4QjVKOVlWL3JMaVgr?=
 =?utf-8?B?U2RMNzBuUjl5a051eHRUdmVzVTh3RUlObTJwb2E3MEtsUDY4bVI3Z2xuZFhZ?=
 =?utf-8?B?QlYzcG1KSUkrREZDRHhqWUQzelNuWlhBc215TnpIYzhtQjIyK2p0MWY5dERD?=
 =?utf-8?B?Y0Y2WlY0dVFVZGtHenY4TEttQlYxWkxYN1VFdytjQXFNU01NZXFMSnlobVFV?=
 =?utf-8?B?TjNrMDlENXgvR0ZFc2V1aFZ5M0s4OU9RR0hVMmN1RGluV1E0MVhSSm1qSUdV?=
 =?utf-8?B?bktZSlJyTUdNWE1KUG1PcmhDUWVCUWJMT1k5RnkzZlRERXVNTWRBMFpMUUNP?=
 =?utf-8?B?YllLUHJCVkkyRUpLOFBSdXkrLzZFaGFCUEZ6aDh4QldKOEFJeG1XNFJLc0tk?=
 =?utf-8?B?SmFHSFZEckhxWFlmOXEza1l1eGZ6L3FSS29RbmlzNENhbHRoaHFqREgvR0Nx?=
 =?utf-8?B?aGc5MkpLK0g3cFJwZzBrSDBiM0JGRXRzYjVkU1V4a3dxeDllM3RENk9LZ0s0?=
 =?utf-8?B?TXpqb1hneDRhT3JoOTRWQVpOTlM1WmR6QWpaaVdPTHJkVnFYRVdsVUg5SW9x?=
 =?utf-8?B?UEkxdkxjMXlOY0d4a3J1cUVTVm9OaDBOa3ZKYS9lOGFVN2diSHhTSnVnZDA2?=
 =?utf-8?B?dFFtMEN0MnpMMnV1M0RYOGJmUWVaOGhTRUwwRVdYak1uVEs5WmdkcWhVbHRZ?=
 =?utf-8?B?WXNvWXdibVJWVXlGc1FNd1czOHBOOHZhVzRZNGpwRTBzbmtXU2tIYWxzdEJm?=
 =?utf-8?B?VFhWYkRMNmZYRzUyZFY2NDJCWGVpTUltVUhrb0daeDZoam9ib0dJb2F3a1BY?=
 =?utf-8?B?MHJpeU5lUXFuNTR1Qkk1YWxBVkRxL01rMlhjVEFsYnZ5cUM5Z1FzbXpYSTdR?=
 =?utf-8?B?STVlMWR3bmdEbXUvNkRFeElZOC9EMlBMaTJSWXZXVGpNUm8yVUVOMlQrRHVY?=
 =?utf-8?B?NEpsVEJaQVg0NXlIK3VSUkFZK0d4Rk9kUVdFN3hyeTdPQTFaQWxueVQ2Mks5?=
 =?utf-8?B?TGJYNCtDNXIxL3BhNEh2REk2ZkhwQXo0WnBodHRzcjF1TC9rRUpTbW5ON1RW?=
 =?utf-8?B?YVVtSVU3cDhvMVR5V2l3WE1UUzBEeGxvd3JFS0ppRGg2L3g4aklLdjBLT0FE?=
 =?utf-8?B?UVQxS3VST2VQUmYxZklXZWN6RVExWVhPTWE2UnZYMm82UDZ3SWtXMzNOQzBk?=
 =?utf-8?B?K3Q2VFp5eTBTb2RBdUFEWXcrQmxyMDE3YUlUeWlmMVJPMkgyRFZCVWZTVDZn?=
 =?utf-8?B?UzlKMHpEbGRvZjduZHMraS9xVUpzWkV5cWZhTDdVM2hiMTBtZXNWTU1oTUMr?=
 =?utf-8?B?WnRvQXF2UHFienh4MW1YeTI3NXpTMmRESnVsRUM4dnJwbE4rU2k0UXcxQ0pL?=
 =?utf-8?B?U1N3TUlGR1pVYitCSEtURDdyTmE5RDU4ayt6TEdXS0JMZXBKUmp2S1NuY0NT?=
 =?utf-8?B?VlQwemtHZzVVZG9aRnVBdFZIWXNGck5xT1hKekxrSjNwaDRTZGM3ZjVraWdn?=
 =?utf-8?B?UUJmcVBrVEtYR0MwL25MRFVqTG12TlF6VmFOK1MrdXAzN2M1b0wwWlpkby9I?=
 =?utf-8?B?S00vYXdOT1dhNU9LcFVRUncrWWVHTHpTYzVCa2pHWGtKWWIxUGQwN0NaSXdS?=
 =?utf-8?B?Qk84ZUloNVF3OGlGUzdKYzREelBrVmluM0VLdW8reUJmbHdOaEpwN2kwR3pz?=
 =?utf-8?B?N1B0Ni9XTDgxT3R3SU1lbzBZOXp5YWl5K0NpOGVHU1daOUFIeDJGQlVRc1c3?=
 =?utf-8?B?UHZDWWx4cmlrRHNtL2tUbDRmSXNZNHlWcFFFcEt6M2Z1QkJKRFdMQmQrQTlD?=
 =?utf-8?B?bGRQTjB1dGVzV2FjKzRtbnNSQ2xPV2xnUlJqbWdPTVdiaVFOT2E5QTFTd1pQ?=
 =?utf-8?B?VG11MlpYQWdWOTJNQjBFRUVMTnVIbFZZNkhIWkpNU3ZtVDZzbTNkYkdzdEQ1?=
 =?utf-8?Q?5nycvO0TxR1WFtotQ1DtsCCAA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1989e42-2f7c-429d-bb3c-08dd861aa874
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:05:21.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcM7oRzQ3rjYM3AWHTBeC97HP2SAg/1K94/TFjQAhRaPn3QnUbLf4iQx2eFP+oK06+TXNszCQYHvV6fRsR7dKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6073
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 06:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18677

Hi Sai,

sorry, missed to reply.

On 22.04.25 19:51, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
> 
> After recent observations from last 3 to 4 weeks, I found that some
> times 40 minutes of time for the IEC test execution (44 tests) on M-COM
> x86 is not sufficient in some rare cases. That is why i sent the patches
> to increase the timeout from 40 minutes to 60 minutes in case of M-COM x86.
> 
> That is why I have increased the timeout for running those 44 tests from
> 40 minutes to 60 minutes with the confidence that this test shell
> timeout rare case can be ruled out. But now on the pipeline triggered by
> you on *next*, I observed even 60 minutes is also not enough in some
> cases to run those 44 cases. LAVA | Scheduler | Jobs | 1266235 <https://
> lava.ciplatform.org/scheduler/job/1266235>. I verified before sending
> patches and I did not face this timeout issue with 60 minutes timeout.
> 

Well, looking at that timestamps
(https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9788883037
and
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9795922010),
the whole test can take way more than one hour between kernel boot-up
and lest test run. So it seems you are at the edge here, and if
encryption on first boot or something else takes just a little be longer...

> Currently I have no idea how to handle this timeout problem. Do you
> think increasing the test shell timeout to run IEC tests on M-COM x86
> further to a value like 120 minutes can be the only solution to fix
> this ? Can you please provide your opinion on this issue ?

Quirin, looks to me like the emulate storage is one possible bottleneck.
Could this be the case? How is it backed on the MTDA device? With some
SSD or rather some slow SD card?

In QEMU
(https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9788883027),
we have more than 10 MB/s write speed (which is still slow) while the
MCOM only gets up to 3 MB/s. In general, QEMU complete these tests in 20
min, total!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

