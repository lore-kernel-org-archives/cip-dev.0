Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B9C624A4
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 11:54:16 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5937.1788436455342855059
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 04:54:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pP4ULv48;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+sXMKJHtoYWduRiz78SPXxNAZjpEFHcIPLrJmY/b8a0V6zdGuBVexm9r4v8a1uc5vnpbs8aOyj89iGT9sgQVKkTuAEAEfBvTOxjAZ9vlY+ZW3zbyPPyyFFTA3GoMpmzDdjG/pgGoS90ewxpSQZvZCFgEN4agSRQmWHQ4D69vP/9CMSF09lw7gTPIl8yDHSso32SAya8wCxeblH/b82woiNVZ9bqmTvuFu/f5AgikQhkErB7xn1+0PNiLVH/LgO4iUdFmDfzLulwhZKRLOUzKhBfssNu5OVea28eh+oiX0Hm9YAF+FCEbOa4nVcDcDNruZ5pUsljlgxTfuoVE/9+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzAtQxH/ePjQCjcoDvWmDanVBmiDlOOVvZ/9XFYhejQ=;
 b=kOaPQ59ztcaL8mlbf2i9gjBE7xj4NEAqWDQaLwCmTyhfpIVFdkqpHnMSofbTVT16i0AJHWHOLgdD2gH1Wl7n2+J87ZQ7fk/Ua/ba07Ga0BkMp8W/o8zx4G4m06lBTYn0TvHC7hV6jhZuYvJqG//RKWCVXwYpCUcndgK/ESIfUunDCOVCWj6lC+H0Tf+Buku9VQ5qlTd6vg50w1Kq4IVooXoOdLemNqDYsM21+N0Up9pR9XblwRzd8OD3Vs0tnABj23K4cd51h0BB0S2MCEqB5Tz40Np9//BuI3rwi+EldNtmUhi1URIy86eeTWe607AxvuuUd4H3OB3PA5IKJ25Bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzAtQxH/ePjQCjcoDvWmDanVBmiDlOOVvZ/9XFYhejQ=;
 b=pP4ULv48q+oYQ5h3DYy7ecbfgZSVQPfrSCT2AAnABn4hoxo4smdIQXEXNMJQZAovUx1+keE54eHc8L2rOKCZotwhD4KKqsDHWqVBEsaTPPzo9lcfu+3HJwnb/lpXh2QFgjohwiMjX07Qf6/104tYfa/rX20lFesJI7cSbUYUiMKVE7IfiLxJ4CLBC1G6Rg4wnslhcdwDxwH9VAS8UDDPNtc0qt3ebrFkKJ0qntt/UXG4HLwxIccR18r+9/IlAUvUEt8O0Ii7j7SvrtKUfUGN5XN9QwqKhBbuO4iJ3gJ3jAQwMSOmBsjvxnmVrh4v08hsQwvYYORhlBGtDNMnrdjwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:54:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:54:11 +0000
Message-ID: <0b2c9dfe-453c-4d3e-9517-668458b78129@siemens.com>
Date: Thu, 3 Sep 2026 13:54:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Upgrading QEMU in our lava containers
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <7301aaf8-9369-4850-bbbf-c83aeacc23e6@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7301aaf8-9369-4850-bbbf-c83aeacc23e6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcfd2a0-2c85-4595-f314-08df09b2113d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|55112099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	2721jJz8alOVLsZs5ekhS24D8xdk8qKtQcZf6tvRz4Vcy86UyZdJg6c+w4a0qI83VR2KlAIcjKxkunz5AlzSVzMd90evBYLI8MIRyk5iyz6+DDXZA/ZfQMelTvuIdL1TTujp/BCtduF5jwQ6NAmjsIpyLsx1TH0QUHRqYMxXeDlPHrdgWxip+4Dz0AgvP0j7pC0qUlnf85BKNj+tnEJilHprfwMDXajwK2WY6LnggqP9SB9/vfA5SrWmth8lZzN8U4eQqE4Ndp261DnEloaq6y+X8Qyj7CSdq7lZpiRLiL21iMsL63IB7pNscGAXSwugaqyI1uT2fnL6seVJGSRUOIG0CeyM+HMo1/hsRUkoFokDLJveHjBcxSRESWNoh535sLQ0VcXAthgY3Amju78Q+qvHutoTiFIIZ1zd2if6r0gWejEYsv3yYBih9WV0C3N4lMHmHjblStwmp5JQyCC6pMOeoAOQ0bk4h2JRbbFTwknsT07WAS8CMivDEGaaGxR00gSaeIvf3+YRo56jhOuKn8MtK2K4104swSX7PkgZ8/BdqzOBsbHM3NPE9eREC+sJwdouEPOrPA3taVbphWwVWq3T6dmONdZuOqYmGiTXy3LrayXn7JZqaxJvfRyLa5Len6a7P1CkHOo/rmYna7VAvMuOJ0NjlQvelQr3/HkXqIA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(55112099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUR5SEtUK25xbXdjTGdsM1hXc0FmY1hyUnFaZC9tZ1FjRWIxRVdKeVRwVEps?=
 =?utf-8?B?cjE4WERaSzAyWmt1amRLbkFSTTZmY1krdVhEV3FlNkRicXNyMHJHR3lhc1ZE?=
 =?utf-8?B?TEl0dW1HdkNyMFF5NEtpU0FnZzVYNnBDeDAxbDI1K1A0T2JmbG1ZKy8yWjhn?=
 =?utf-8?B?YURyTWZ5WW1xcWxsSkplQnhMbVdYNFYxS3h4SlZsUkR0eklLOEdVZjRod05t?=
 =?utf-8?B?emp6dVdvQ3RoS3AzTlZ4WXNuTnIzNlpJUHliaE05cmFLNUh1LzgzaXVxUDda?=
 =?utf-8?B?MGw1Rk5EYlMrMUdEaUlMbWwvWjhtVnhyMVM1MjJRL0VSM3dUTlIzSXA1Rkc1?=
 =?utf-8?B?c2xLSFk5cUdjeEdScExmandWRGxLZDllKzN4cTE2Y21TdFQwRlRaeWVNVGkx?=
 =?utf-8?B?aDZ5b3haQmpjM2t1d1E4Qi9ZeXo4QXJlOEM0NFI2a0NZMG1YOUFtb3ltZmpR?=
 =?utf-8?B?ZjlGaXBzR3M4YzhwQmdVMkJBUjNBSTlGU3ozZU5ZUFlnbkU1VE95T3dyOUs5?=
 =?utf-8?B?SWJ3dUp3YlBZbjcxVVRaS3BZanVVUkJzRjNQcmtGU0FyQy9IZUx6eFVuSUpU?=
 =?utf-8?B?MXJHdWs1cVppVzZaSmg2bjlPY3ZPQWp0VUNoTEZCZmxpeFZrSGlFODBZejJM?=
 =?utf-8?B?V29VRWVsZldTamtuWDVmS1d0TFFqbzkzakRVUXhtYUtJOUdMUk1xWkQ2SmFs?=
 =?utf-8?B?bUdTd2Q2YVBPaDd2ZndqMjVKY3BGZVdFZE5PT1RiQmVuVlhXOHdsSnBCVFE3?=
 =?utf-8?B?Tk0zekI0NmNOSzRDNVRGYVFXd080UThYaXhSbW8xdFRCNEtuM1dKSHZURzd5?=
 =?utf-8?B?RTd2U3RNOVYvOE9PRzhsdC93OXJTaUtaT1ZjY2VKNUsrT2RHSGw5UlUzaXE2?=
 =?utf-8?B?TEoyQUpRMllSZ2VGS09Ha0xiVUFRZFFmTHNLU002SyttRU1Kd05xME5WbXNq?=
 =?utf-8?B?MW5KZnpuOXZ2Sm5OWGl1bzgrQkZ0T0toMmdlZ3Y1YnMwd0lzT0M2LzMyM0Zo?=
 =?utf-8?B?ZXcvbG10c0QzR0d6OGF5RDJCaUNiTUpyamRuWHFldWhEQWxGcFBEelZETHZD?=
 =?utf-8?B?aUNjRStvSElsc0EzWmpNVjNVWFRibG5EWlZZUS9BOWF2b1o4VmtuNDFGTy8y?=
 =?utf-8?B?SkRrUjZMRFkreHZkd2Y1RnZsYTk4VXUwTWY2cnJuWHNwRFE0eXVmRGZnd0Uz?=
 =?utf-8?B?ZWd2aTJ6Z3hPZmpkQzIrSGxUc2ZUVEF2emdvMEl5NUJhUGhFaUhhRTlMRzlH?=
 =?utf-8?B?b25ORHpmN0U0WndZZlFMSWQxNnQ2VTZBaEV1bkdPYkdDbHZjbjJVZGZiZjFR?=
 =?utf-8?B?bzI1MDcvNjNUdUVocElyRFV0dXJja0R0SmUrYkVvT1BrVVNoZEdHelVhNzFR?=
 =?utf-8?B?bmZKTFNMb1hWSXRUVTBCOURPbWlMeUpTZ0lJS09YVWxLMjJGSndzSXNYd0dX?=
 =?utf-8?B?OG5XVXdlaGVCNVp3TUdHRmdsOEFQRityZWdWTmNmVEl6U3cxWG16clF2K0l6?=
 =?utf-8?B?dGZhY0srQkE2WWZBZUFia0V1SW9yUkxTK0FyMWcwY2REOHdtaHIzM2ZlZnEz?=
 =?utf-8?B?OEpmbm10aFMvZGVCK05uWlFrZHFYYjdxbFQxWlI4QlE5ZTZ4bHMzdkhXMDRk?=
 =?utf-8?B?bmpRSnQ3YTRCZnpuSzBONjRPY2oxTEVpQ3ZEaXRreWtQYVBTY2pkMklzZzJZ?=
 =?utf-8?B?T1Z4aEJCUVFKYjI1YW5pU09FYW5ZZkZmUnJzbTNkT2svUTFhM2ZVTEtlYitu?=
 =?utf-8?B?Slkyb2pqa3duV01IS2VKcjZPeWtnTFE2dHNLUGNrVHpDL0xDV3QwdmVWaXU3?=
 =?utf-8?B?RzVhcE4rbW9KVTRPOTZwRmV6dml2V0gvOVVCY0VES1diM1RLbktqUDZtTks3?=
 =?utf-8?B?TFlycHhLSEpmdjVxY2FvMEtaWkg5QkU2V3BWYnFueEtxaC9Wa2lpZFZ1eXM0?=
 =?utf-8?B?aVVKYmZQZlI5cmlpWkZBUHk3ckhIU3ExbGl5STlTM1RUM1E0dmVaOWdESkdN?=
 =?utf-8?B?bTRLYWZINHpHMlRQV0tmY294RGM5RVVBTHh6RCtPUVo2KzJZLzRjNWh5YUhi?=
 =?utf-8?B?T0VDS1o5bTh2UU9MTmFMTHdRV29LRzZPMzg5NFRGeFJ1Qy9jclRqM0hHczN5?=
 =?utf-8?B?RVBSM2ZNbCtNeWlWaW9aczdJaGZvc0NPN3g0U3JFU2N0bXA0NFE2SEs0VDVa?=
 =?utf-8?B?M2NlTnlsV203NkZYTjJ3ZXN6TzVMN2F3cmltWVBvTjZXY2lDV215bHhYVlJ0?=
 =?utf-8?B?R0gzdklVWEZBejBLTUVNdHNNb25WYUVDMDRoMlF2bFRGcWtSRXJ1U0RvWHVU?=
 =?utf-8?B?V2Jtb082ZnZJRHJqbi9zQ1lqZWVXRE0vWFJXNTdmMytldjhhUUk1V3poR21v?=
 =?utf-8?Q?yMac9GB4fhp9qSac=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcfd2a0-2c85-4595-f314-08df09b2113d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:54:11.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm0oWaH6P0IYWenfMaCwLR4zqP1r9s1xbCGc2y55SDgYjPEieudTRNxEcS+aSsjha1tYgJXvl91BRCyRd9AyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 11:54:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24089

On 26.08.26 16:06, Jan Kiszka wrote:
> Hi Chris and all,
> 
> how complex would it be to get our lava workers equipped with a newer
> QEMU? My usual suspect to ask just left for vacation :).
> 
> Namely, we would need >=10.2.0, and if I look at trixie-backports, we
> could even get 11.0.x [1] which works nicely locally. Background is that
> I would like to enable full secure boot / disk encryption testing on
> qemu-arm64 for isar-cip-core CI. But that requires a qemu update to get
> RPMB emulation.
> 
> Jan
> 
> [1] https://packages.debian.org/trixie-backports/qemu-system
> 

I've opened now [2]. IIRC, it will still take some coordinated effort to
get all workers on a new container image version as there is no
auto-build or even auto-deploy.

Jan

[2]
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/58

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

