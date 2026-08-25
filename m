Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDDC61DBC
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 16:54:11 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26649.1787676850036340856
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 09:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uxrBdvW4;
 spf=pass (domain: siemens.com, ip: 40.107.162.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psC6veAK07qf9ZsS/Hgw7OY5T+H6knFZzDiL0H51w9JYgKMDE2odoCFjAoKCxyTSqgy+gEe+qTsERBaMyfCcpoYFFvP/JtHVaIIesApBa4k1Yp3ziuR8wqVVcb/kCEREoKc5frbAEuFt745a/22dMuRCdG7HlZPlC//gCDr6ZbYUqjVNkN0d1ZJUCnzRd2l51QCJSBibAVNR/cN1hwMNy0d5tDmvUK0Nlcrgn7t3OESDB1s8jaW6r0jYpLbCbqYob3qTyKtFZslzc5FJnGwQqEPXHrb+o5dyKxU3OJaqNYBloRLx5MBQbV42dB1mX0+SFNY5ovNuiHKRF92/BdY2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z961MHdpIO+jXP2pn0amuEWaf9SHsP/NMETpCiQg5k=;
 b=Du5XPRl8mXQ668EjXid69Qp1Txiur9yAugetcMn5nfjZTlxaNw6eZxFvh/DViXb4rHSuk/nOF5T5CMZEOdYiq2WA1LbNWMAp0B1m/QwIbUesYeUnmMFiKO2JDt7Ufdi7XblmhqAWnUfPgvU2s3Q+nujSvsGWVlhgK/QZfWvw2FkND8cxrjZgzY93u1bggW9SFJ4WZaxJH90tsB+EEH+r8xbEXSJC+UesQh1k7Y+wdHZqKDlM+MJ3JVhLIi9edcF2a4RKZD4SfshgtQnMaIpesJi0TxBP69BTWsT5+SmVxwFge9CMyYy5FCaOOcfLIOnjy5puZ6QHL/yqWI2pM6StPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z961MHdpIO+jXP2pn0amuEWaf9SHsP/NMETpCiQg5k=;
 b=uxrBdvW4hyQn/1zXfxJBmCYTh5vg6YN/ip4xNFbWB67UwtR6/PhTMxCxzP27SyDTWPZpPUzRFWNLu3/FWMA+JM/Wci5Fi8r6ynMTt6i4kgYiQsupK5zjImaFLm0gO9XgorPVji+vkLA+IGqSex+lM2UQJncGgh2W/8dzuwVAkpsJlEKQ5LDYDDAWUsZDlEwhEqg+qJ0j0hm5akzfZHspzLkqOgqzjg01Xujts3M/IB6fOkVJhBQrvHOg0ib5QoWxzEd8Z0Yz9nC84i4ehZxd3I3LArviHvAvnDl11FjAmc752RDSzjtx67izoEkwgpZVfrNIcKFf2zlYGdyCxPSCYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:54:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:54:03 +0000
Message-ID: <8f436767-7dfc-4281-8df3-9cea9bac29a8@siemens.com>
Date: Tue, 25 Aug 2026 18:54:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 04/12] Add cip-cis-rules-config
 to configure the hardening according to CIS
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9ce48e-4d50-4766-88a2-08df02c977b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|6133799003|22082099003|55112099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	OCIccoEg44bvzROXgSnLD+zuBuV6l5V5ThOO/7urp7a9NIyoHsO8rI9KjkoCdq5TtqfeW8J7OulMNC34V7tQamfCX7NsBFRm1Octo63MOaKB0syfqz92tTY+4cv6/i4BYBCY0lbUOQfRRDHHIK8cU/8kOi2iSp3uP5hLz8UwPfqFhvFmePzQwtls5PyDPshEcslXNsgz+sPmfL11s6PZvsXTHXOc/ybmj1qcEbRhM1yBNHAjsIUHPGE45FXgDuHObVfSXTBsvD1NkHdazFX4nc7/FGnG0YL9phxJHFaFbAz0NSE4Nmubd4pyRETJRj1ncuZTc1XOfGFtc04eGE2cC2cd479oW6f/EsgEqhUEPc5KT1wVC5NaTx8DP7c0KG9cFiKTQGxq34Hz/rTEp24h+gCtTwJLCcICYfmqJwnf4LB5HAguCWW9AnRQ2zlGhuiUFPxWPqJXYdqRTxW7pSxM9FhPd9OdpuiWQn2oUT34VUF3RrGyLthVkfqFIJCkUSJOW9TG2QAc1YSv6eWK+emsN+qDVx/TiYaSa5VcXhTzV74IK5E+Kj+ZYI0uznU6zdYqji7hmGdNnU1HR+5bXlX4Kb7WgiLit6/J2bJW/K9EbyzgYaP2sdxuxAxpT9drrlijdQwatYtWDO6FyuJzA5Z2PV/R2tmittWRi96DADFtINk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(55112099003)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDYra0VmYnJvNEJyK0lIdTFuTGxwNGowcU1ZK0JRT0c2NVdtMitJbEd6RmU1?=
 =?utf-8?B?NWJ6aGJrbm80SmlTRnhqOGJ2cTdhbmpWTW1EcVZNa0JhQ2piNEUvSFNVUnQ5?=
 =?utf-8?B?Vk1NTENqWkNFRFRBWHBEaHM1MnY0T0dtVEQ2T3FQU2F0NEdKZXdUdGlqLzRJ?=
 =?utf-8?B?WGZnb1dGdEFIYVVneXU0NWkydG5UejVIOEZjYWlYR1ljLzhIQjhuOHFrdTk4?=
 =?utf-8?B?QWNnd2R1a203S29adUZPUk9RMG56Rmtma2ZmM1lJWHlscVV4NEd0S1hDa3BY?=
 =?utf-8?B?SldzU2VhbkV5b3M4YmxHYnByNDNQUmhocFhoU0Ira1BCbm56WTBUaWNFZDJB?=
 =?utf-8?B?YmVDZlI2T3o4UGZJRkcxVmRRMmpDMjd5amI5bWpSZ2hnUUFKRDlkVWZZSVJk?=
 =?utf-8?B?a1MxYitPQnU5RGZqRjlCbWNKSU93UTZkaHRRMW5PNTVySjIwWnl5dUQrT2FW?=
 =?utf-8?B?SnNkUVZuems3VVNnWmRJano4TTNadVZzY003RUNyUnRlTVB3d3g5d1YzMUJu?=
 =?utf-8?B?VFBsT3ZpYU94OXpJRVJhQ1hWRTREN2FZbEZIbGRTck1PZXdjcjM1MXh1SUEr?=
 =?utf-8?B?YU9WMENvZWZIZXJuVTRQSjdTNEFpcUxRWUkvZVR4K2tJK09IUGNFa0hXVi8x?=
 =?utf-8?B?dHJlWXNoQ1RiYWNSOTR6Tm5vc01pcUxQaFVnV24yNnhOQmxPcSszSytzZlNr?=
 =?utf-8?B?U2xqWWRBQnl0WHhabFJWOW13K3Y1Mk9DT1B1eS9oRm5YZVJpUjZOa1NMcjBh?=
 =?utf-8?B?aXg3ODhyMzY5d3doREhvb2twUkEvdWE3WnJteDJ0a2lHRmhFZmFBV0F0S0JI?=
 =?utf-8?B?c0lCK3VLaHdDRE9mSTFyN1d4L3BpVCs1eGNyaEY2UWRBSXRYTEJXRVcva1NS?=
 =?utf-8?B?SWlqYUJCQ2VsQ2pxUElQR0oyNndCMytDeFlzREJJQ2I3cUNKVDFKYWQ5ejFo?=
 =?utf-8?B?aUZJbEpxTHJzS1MvT1VNNExvR0dYUDBuMS9JOUpHL1hjeURQYndMMFp2N0Fs?=
 =?utf-8?B?Q2N5VHVGU09IVzlGVFlTcFkwRWwxamxQN2xWbGY0OUpQZzJNSG1aVEpFM0NE?=
 =?utf-8?B?UURBcDJ4UGhCK2NQMUlrM3pVTEN5SFN1MG9rekNrNmkxWFFwa0xZY3VSUkpF?=
 =?utf-8?B?dWFKaVV2bUgzcS80Y1ZmSEdGUi8rRnNvNTFkV0c0U091QVhST3M4SUdnSlU1?=
 =?utf-8?B?VzJ2Yk45enkxUDd0UGZrL1pXSERwTXdkVUdaZ0FnZmJJSEpNUUNjdUROY0Jx?=
 =?utf-8?B?bHorRStDRmVwSUxUTktQMlk2NVIrWXZ5VUkzWTVENStuMjYwS1pzVklJV2lE?=
 =?utf-8?B?K0U5d0kyL0QyV3lhYmp1dmlyajNSSTVqU3lkYSthWForU2ZNQUMzdmhSczRL?=
 =?utf-8?B?ZjA2QjM4ak5ZdFI5NDgwZlVxQnlJejdubE5jN1FndVNnaDc5YlB4cVMyTWR5?=
 =?utf-8?B?NUNHZjBBaC9wVndaUzY5OGxMYXRua05ETmZrdmFKR0FBMFA5WnNEOExzZEdZ?=
 =?utf-8?B?TnplZU45M2FZSFVtYkoyZHdsZDlGQkVYUHRUT1hKSTFiU240OUN0OG4zc0FQ?=
 =?utf-8?B?dmlxQmMzOC8zaE9NUkRWNjI1WTh0QmJpcEpXeUlRdkxHV2xBWDg1TTNIbkVy?=
 =?utf-8?B?bGRnNkI0citjb2xPSU5NNU5UdTNmQ1FNN2NEbkdPYWZYQ1poQlBNc2Jidnhz?=
 =?utf-8?B?R0V2VEpGdi9XdE5laDBlN1VmbUVNTGdrcDFhMnNZemFZSzE1bWtkT2Fkcjdz?=
 =?utf-8?B?MGVhejJGUlh0bS8rNEZlUWkzWVNmajdPR2NqY2NIYXhtNURiaEJmeG1HdGg3?=
 =?utf-8?B?RnFveE1JcitYTW44WkNuZTJzYVJ0ZVZ0ZVRzOWI3anJaaHRRSG9qdWhWeEI0?=
 =?utf-8?B?NWNweEoxSnExSWdrVDBHZnIrclZEbXc0NGRSUlAwcWNxUmNLQXVQTG95eHR4?=
 =?utf-8?B?bHBWV2djdUErRXdLQi9rUURtTkZPckJhWjlzTm1yN3FQQ25iYTdMOWpnTTFI?=
 =?utf-8?B?QWxaWmR3eVA0cVFvWEZST2l0dG5vTVR5R2ZjQzBKbXlQWWJ3TlRObmpLS0lp?=
 =?utf-8?B?RFhKQWsyRTNuL2t2MGFYTFh2VnFEUDVkNWQ0MzRnQnZsSDRzZkZ2WXJOUEhQ?=
 =?utf-8?B?ajl4Lzk1STZVWjhvYVdlalZSM1dpS2NURDFabXB3cXNjLzV6YVFhQ0o1dlpG?=
 =?utf-8?B?NTdkeVZVazF0RkE3S2ZwS1NUb20xbmdidExBVFRWdFpuQ2MzbHBiSUZxdmly?=
 =?utf-8?B?WnBnY3pyQUpEUncxdmJsOVlhY1VPV211NENDNFF2R0tKWUEwN29JZCtiVVZo?=
 =?utf-8?B?UW1UUHJrU3RRMk5GUkRhOXFWc0NleDB6UHNaVEhlZE55NFRtb0RtRGhrYnp3?=
 =?utf-8?Q?8ThCblaDvxDZC9OY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9ce48e-4d50-4766-88a2-08df02c977b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:54:03.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnc7istbHM6B9RiHxiA/RF5H/sGa/wJSclb7kkDV/GqwdG5M8lMB6UZSRK+3JUotys8TEYwHJYtFe/wm5gAiwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 16:54:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24003

On 24.08.26 11:46, Quirin Gylstorff wrote:
> The `cip-cis-rules-config` recipe allows to create a use-case specific
> hardening configuration based on the CIS hardening rules.
> 
> To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
> can be used to generate the hardening config interactively.
> 
> After the package build the generated config can be found at
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.
> 
> The package also provides a kernel config snippet
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
> to apply kernel hardening during compile instead of a runtime
> configuration. If the user changes the config.json all followup jobs are
> tainted. The code for this is from
> https://github.com/yoctoproject/poky/blob/077627338ac18aeca34bfe0c52777fab38e2e0c0/meta/classes-recipe/cml1.bbclass#L37 .
> 
> This packages generates the Kconfig out of cis-debian.
> 

And it needs some extra deps on the host side, doesn't it? kconfiglib,
newt. This needs to be documented and possibly and/or reported clearly
when invoking. Make sure to also test without kas against a clean Debian
base image that only has the Isar deps installed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

