Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C30FD2D7F
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 13:26:28 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40005.1773149177793622848
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 06:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ay/34l+Y;
 spf=pass (domain: siemens.com, ip: 40.107.130.27, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2Qnsr3nwQVJYoDy5spUDLEbENcohBCMJ5Vdl5Sk7tpvjGxyFDzYR/LmfcIqP0XUk9cFRInCxdsv0WehFVFHqgdU+AlbazcLzo1fUgl1pedGnH6LQQoNeF2yaAYCXQTelX6AfFFAmlu4a1n6ug4QI0TS6JFldYcz67A11CGIUvdSQAgRkhF55Vs4FHxYZCMn3YkT/UCx160O8O9/LLB2liih+x2o52HnejQfnhlpMVToZFjpfDZiZGYtbI6twkhfv/cvNnFsYLEVZwAlrFiBHsc73BXo5KO/0rafXB+thIp6OnEZ7jFQg8Gtxdk890ho8o0UFzvgX4JYg1yNEd5/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjYqDT/kHmX0kHIBHwKMJSKSusSQnsEoOMDiD/X4tvw=;
 b=rwYaAm07WzrdStCtQGSiyzVSoYFgGbXa7cZLLD2+yUPsVceIrhfC7rUTEEkBX5Kw4yep1oI+BnEDY8NWSRmzkGT6c0f1CxnpDxd4DJZ9cTY9a181TRTQlmlBG81ncEZZzQYkl79FwZL2cBh4jq6k6kEPg/EdPBbXCtNPRUWI56ueIB08/Q95SGRk3CZCz37MMhZXgz8rce/q6WJklNYuN6LUM9XJlcnQjbvTia9SpCvsZfMU5up/VM4ZxMwta9nppoOS3hC9imYqYyqp+o/IUlT3dPZT41XomhwvQy8oyRlYKwjoCit4UrkS0ko+EryIoSvl22nmMxjbKCEhCunz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjYqDT/kHmX0kHIBHwKMJSKSusSQnsEoOMDiD/X4tvw=;
 b=ay/34l+YkDMzyKkHgkcsQV7TRPQxT0wMz+kOZZWUlCewjdQqli9GtLu002+d6Yhy2tlhV14eSDQghB4O617FAhM/iuZY7C9zbryqDvPRaGeldn7N9qdVh9X5S7QxRfIHOF6Kl0OIzSDsyufVEA6PRS8J14vXVaTu106Jya9+RzkOdqbeZVWBMlSNvJwfhBhJrQ+MFg60iHdrqsSOdRA80zN8FONAGIY5A9Cg0SiAGSQoo0iVEl1pszHhHPYbZ61OUfGaJVLbIdd1nmVpMmmtk1tBmkVIjGfpHG8oMyN6DQUicZ8QuSIw4gGbVeUN10/nWzBLaYuIUeNRbV/0EVsDVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9787.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:657::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 13:26:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 13:26:13 +0000
Message-ID: <f54ffe73-aafc-46ec-8f0a-a2c14f41b471@siemens.com>
Date: Tue, 10 Mar 2026 14:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v6.12.76-cip18
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
 chris.paterson2@renesas.com
References: <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e0223c-014b-4b4c-12ab-08de7ea8998a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info: 
	i55lJXaotLHGD7UVpiPyD6zc2o5wOLxoC5qMq3aFAMiCybCqUK6fp/q5JOWTHEGAcSM7yGzT0cOfG193EkaRtQ7PCtiE+za71sFKSgiqgbqmxkOSevh3ggbWCP5hCI12K8UHPOD3ASbXd+qaFshTg9j63YOUy7wX+gU/AguNaaGnw7WCBbik113jego9n8LtqMJ5o5YVNg/zxFqG8XQ4ej+mktLU/TyxMFkgGsPK14NGxpZuxwxxYBwfcPeAQ9VywHu1vkqbXJ5oRqTLFg1KfZADZde1lj4xbxPEie5rbfoGtS/il16mzVGLuFo4eqQ15UxvaT4FYt4MdMU4VxOO5OtpTpJdrCu6uW2/P3blEBYFK0KUm73Bn4fnP+7I9jed9iaYdwC9GXUJabkQgMisIqVREIYcDEGQ5oLUepySqgXeB58l4POMyoXjBdh7MWCHtLj2D/5tCAbSACEtsnMH9eRoF3nX1IXga3vwX5ZzPj01O+d/FZUqjU9yurIvD5auVXs83fcGEmljkOTaSrviVm8fdDKdHhnfiMpf7e2nZmHjjCvoL49guOvGIA4Y3VuSvoWT0Ppvm5F/O4/xADanIZgfhblHvH70tiCH92Zq5go7Ofq5HLtkA89Wgc4bRQeu1ze2tA0OgGSKuVFyu3jemSX37XWVTgZvRjwtFME7if4ysGPZDXlxh5vdjvBZ2qYM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amNicGM3anJydVoxZzZVSk5YVmFRNWNOdFJVZDE3M1NIdGoxMSt3bnM3TmJQ?=
 =?utf-8?B?UVNkK1MxYjBKNS9OekVmd0pGU0o0TWp2eldURm82SHM4UzhMclVuVVRBK3Jh?=
 =?utf-8?B?QzFoeTUyd3g5U0VxL09qUDVXazVOYVhWRERCWWVGN2RZZUFQSWhEQ21wUnNa?=
 =?utf-8?B?YWdadVZlUTN6a3ZoMmJpQ04zZWFybmhWRXRWSVFsaXRDSUJUQ2hzRmMrSHlQ?=
 =?utf-8?B?MWV5c09ad3g5UzlEZm1JSDFSRDYwMkdMeVNFNkNUNzZTd0dNaXBsZWMxbWlw?=
 =?utf-8?B?TVlKdkFFY0VkajZrQU5LMFQrL2JIdERZaC84VTRHeG9oR3N2MythemVmZ2VF?=
 =?utf-8?B?ZytRTDlGa2xIMk56NUJjNTlTcnU4YmF3aysrSWUwVWJBSDRvdTR2ZFdvT0VH?=
 =?utf-8?B?SzdYaDZYc1JWb0svZE0rVlphTXRKMU9GTHMwTUpOOGxzMS9yYjhzcm5lc1NC?=
 =?utf-8?B?cWRnOEFVNmRNeHRLcVJTclNnc2VPM1hpV0ZmK1ZIdUtoRlI1ejFZRVpydmJK?=
 =?utf-8?B?QUxkVjJFZzhJQVRDZEgweS9GSlpiRVlZOEE5QjJMRUFuV09ETXpPSFdORndk?=
 =?utf-8?B?VjBaMkNNK1hZZm5KNzZUcGZJMUFaanFwVk95TzdBekZlSU4vTk1rbkRoWXdz?=
 =?utf-8?B?ZTVmUmc1NTdCV2ErV0lPV2kxdU1sNy94Y2RzZDliV0xrWjRudXE3TXZUSitJ?=
 =?utf-8?B?UHpYQnlJR2o0Z1FuUndGNVdUbk1YdlpaK0ZmUVR0RjBieEJyQlFzK2VwSC9r?=
 =?utf-8?B?OE9YUzhMOG1VWjV0NDBDUVVMOE5kYndGOGIranZjMEJSUk5YZ0dFUnBVMjJO?=
 =?utf-8?B?UkVZaWtEQmt0Qk81d0xUN2crc0F6UXRRY0E5UG5XTVhQTlNWci9WTS9ocjVj?=
 =?utf-8?B?SUJiUGNVN3hnV1dnUmtMT3M3NHk2dWZVVXFLZzNHdU13ektLdlA3RDJIK3RY?=
 =?utf-8?B?TnlJMlN5cTNxcENLaW9hbTFWQVR2NnYzRm5pV1hwK0UyWTZhTmZNVDdFZ05u?=
 =?utf-8?B?RU1ZaEZ2TmxMeTg1MUhUUW0rNnpMSDU3bGR0ZVRQZElGbkVJK2dLTzlGaGNM?=
 =?utf-8?B?NzlTMGppbFpKaDN1Ukl4VHgyVkg2Q1FZT0Vhc3B0ZXpuQm03K1BpL3RpSkRl?=
 =?utf-8?B?bjljR2NiLy9nVDIzOVAwMll6VTMzcFJWNzFWbXkwdFlQRTUyVXAzT0V5ekxB?=
 =?utf-8?B?eHRwRVNFTVA2dFVCSm1VSHRlNFpsWDl5S3I4SVZzOFVQRlRRaGJvUk1lVjNp?=
 =?utf-8?B?QW5Vb0piRHlSZms3ZkVvOUllUnhneTR2MG13cFhwRjBaVUVHdU5nbzJia3pU?=
 =?utf-8?B?NzRka1ZDSnBXU01xUUhISkNMbm0zUGRJaFBSZ1VuSElYT01IY1VDQXBYck9Y?=
 =?utf-8?B?MzI3anhWN1JrRS9hQjVzRlBlbGJlZ1ZkdWIzVStoeEorclk0MHBnYXFKQmJm?=
 =?utf-8?B?NW5aSkYvODRvTGRjTmFhYzZYN2pvL1BOT0QwTWt4MW1kTndyNmpBNTU4SVNz?=
 =?utf-8?B?Z0NaTEYwSHkzTVJXOEM4K2hIYlp6TDFCR01ZbnVDUnpPYm5DaG1xMHYxQ0xS?=
 =?utf-8?B?NGIxeDdyRnhBdC81ZndjcE5VK2liTitZb052ZG5DeG9CUTZVUW9oeGphdUl3?=
 =?utf-8?B?NE5xVVJnc095UEd2WlI0ZW1WVmEzSDhXaStpTWszaGlZWHVxelVrY0l5R2xJ?=
 =?utf-8?B?M2poQktqNzVzUFEwQ2xmTUFvbi91YzlXd0RhMTkyaUpWNURmSHlPY1JqU2hJ?=
 =?utf-8?B?d3pZaU1tdzdnUEI4SkJJZk9nUVJyclBRSXFOSTd1c29MTkZ1WHpLZ1RUd3A1?=
 =?utf-8?B?MitvTGpjUXJqVTZCeTJONkJld09qQTh3Mjk5ZUt1a09DRnU5NmU1MUZkL2tB?=
 =?utf-8?B?MFJNN2xvYkRQWUhFQXNFTnI2RXl4YlBwRTMvbWVmS1BvSHFIcjlRdUI1RUl4?=
 =?utf-8?B?dXZmb3lDRzJQbG9HUXVGQ3V1YUdoemNhb1cvZHdTazdOZjF0WUFwMTUrSFlK?=
 =?utf-8?B?YUErMy96N3c4YmxSNlRHbzlQTGNoaXd3UWpybWdWaHZCaVJueTFJRXp0akJk?=
 =?utf-8?B?M1A5dFJ0Rjk4SWVPUStIK3d6anFJNnNMWkVCVmNVSlV1RG51TkwyMHlCVHA1?=
 =?utf-8?B?YnNqMDZDZExWdmdqQjFzYTR3V3BOcm9RcXRUY0xjTnl6TENvNFNjWCtCVVl5?=
 =?utf-8?B?SmtvTmhmTkk2QWVHWDROYmZCNkpJc2RSSUI2WFphVlVKUlduOGs5dU5sWWdv?=
 =?utf-8?B?ZGtkVXFvYlNvanRQeEtBdVNjOG00dmRUMjRtbnBQWElyMmdHbGRPdWgxTEVa?=
 =?utf-8?B?enlyeUdOMm5hOWw2TTJOSkoreGRSelFnWXpxNVBRWkpDT3ZUOHpBQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e0223c-014b-4b4c-12ab-08de7ea8998a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:26:13.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm1OxTIPYtGHMyzxFtqBNk2sPDUsy3jG/C3X9gRjifnM6H85YEgAHZaNVyqHYWQO5O+DETTPBg6pnlU/3uESjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9787
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 13:26:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22227

On 09.03.26 10:05, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi all,
> 
> CIP kernel team has released Linux kernel v6.12.76-cip18.
> The linux-6.12.y-cip tree has been updated base version from v6.12.69 to v6.12.76.
> This release includes updates for the Renesas ARM64 SoC RZ V2H.
> 
> Information about this release is as follows:
> 
>   v6.12.76-cip18:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git

We seem to face another delay in cdn updates:

https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.12/ - no cip18
yet. This is unfortunate for our cip-core recipes that prefer to consume
faster-to-download tarballs over git.

Can we clarify where these delays come from?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

