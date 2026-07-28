Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA97C54F54
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 16:55:27 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1038.1785257723193735855
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 09:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M2wHO2dG;
 spf=pass (domain: siemens.com, ip: 52.101.69.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoG1hTh1MlWGjQU6wRR/DwJY4ULr3iwlNAVM6XWE3a1LuYozNe+l7gG8qWMF1HAVWI+a0dT2vAktOL2KZ4aeIy7Ljxr9KrFAbfWOqvUfPqhfpUb9DvYpNWG6aNjeMoaLu1ySyckQEFX2MxHHCHmtGp6SNGMU349SU5pQzIoRgpvGZBcjL7rCWs9T7sUgS4ba177PoPNgAKxc4eThau6a1rABPQsabNceBvLJUujtf1tUuhxAdUDzi3dEeoAC8doo/hymdwfZ+dlMrPmUN+qidgnAaSDf0jMfoivBCdHdvVaj5mVbL4TWgVtgjpSxHGgOaIpaDCTfvgtLVjDQFUlA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+3vF+VKBhh11UkZA84qFCTWVkHC4KfIBGasVxCCvu0=;
 b=NYjOrITt0/XKlR+qfgLJzrWsyTN+JqW1lXIlAzyu256FNQQzUsIlv5Un+dWdVHq1aBgK51TPlim4lQ2k4aCv1+0pn32Sx4VxTWReEtU3XDG0GUoaiSWEFC+MmMNSyf9quWiRelzJaE1a+azxgkx9wI4AwxZskGfgSqFKprLRdvPppHdZib5XcVsBMEfFZIXBZrzI92CAt+pMzoqFqW59+nV0EvAl6Ku5a8mVFZOHoqUXz9L60N/qCmfUSD/T7k4WBQZYgYewm9PMD87R6drMn0HyrQfqE+9AKuogeuZltgMbgeMTrg1V5HYM9Icnf09aTbmiO+EFOAqV3dM3LHrhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+3vF+VKBhh11UkZA84qFCTWVkHC4KfIBGasVxCCvu0=;
 b=M2wHO2dG7yqH9G6yapQH5HpH1ZAHxQHd6ZevuK2Ziu3iiLRCHcKTgMISoobNEkoPwUS2fiP/w1ohMJ6LaaVaMvrbeRMyhDk6fIYPYLreCROJLpHEux3O0IU8GbQnVwnaCR41IgCm+nYgWutwB95JAk15x3n1hDUqMIU4iLMbWD3Fks3V6ATaW0QmLYOmdaX0WFqs72EHROQffrW48LWCRQHCmdLbsgMpIozGwdBKduKxolPJ4Vx2Uh58kQV+2kaAdQugOczB+Gy5WHbFHjRAbJ3V4my++I2ESCRKifkay+oFXbwPnSwf9qRXrJOdOPkq2+vbx5lW+ubCNA7Clf12dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:55:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 16:55:18 +0000
Message-ID: <7a82d63d-ce93-4554-a1c1-ce1e01065ce1@siemens.com>
Date: Tue, 28 Jul 2026 18:55:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/5] update Isar to contain
 rootless changes
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-3-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728131231.117214-3-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0312.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a4f4bf-adf6-46ea-adab-08deecc9012b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|4143699003|56012099006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	gcdQYsQPiOResrV5A4PqnWFSk7A/5x4ZPAOTvLQtKbRW8++oLCTZcywzPmB+1pAwhYoNo9uxjOCNPe6TBS+tX7Li9bT7VF09UiD4pGLZp1rN/ASxE6S3UT7nzggmu+HHYYiNRqAytWBKz79z6uHKv0tF3B1MesI9H8+XSYlQC9KFlWAly5q5m4MWVGq3S/mS2IfXvrh47lDtPfSotL41p3ftwO/qPM6zop7/sROfrK7r1irQliniDQpJaMHtdKWWKHMXdvAIlEQfXzlbLz13Wy6cNfjD2NLihJhvsMnXexmP9ZqsvUXpNo4I77eM7Ck4EjYyRDatU78svTYLkLXieoaazDEfPsJC8u+vBeVuw1eh3STzuq8/uQoUBfs5Ru7BeIPKepbODU+FhO1uut9iyUyJ4immxACTnYgYhVwPuOObe3nNO/7bbFmjvHe0K9fyAHmtKHbRd0ku8iKhcAs3pK+PFTzdmIZmxl6DCs8FiDrHj7lrM+4vhiiOTlpr85sc5IcvnfeTiaq+twdEoc4cY71Z1TNTDlJwlkeesSmRShIy+N94OS6lK0SBngqXxk7JCcjAIFwePCfDQo0VahngVMIdiEkzTC468dlrclwnC/MNyPaCS8wB7sxj9/AC10c0iLCjMlKQK+0Vis74eWe5ZRsbh85PYxKcvt6F6NNTZcE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1Y0MWRUUit0SEgwZFlJUXRtRjhaRHZJYWhsN0E5YmdTV2V6a3I4V2p2bVBx?=
 =?utf-8?B?UjJRV0dCSHhCMDFWbmtON0FmVEtZQkMvbFpZYmVQWjB1Qmk0a2NZLzR0WlJ6?=
 =?utf-8?B?a0hscksrMFN0djVsbkpVQlpGRnlSTTFPZDJPNVVsTkRoQVBZbFlpdW5wSFhw?=
 =?utf-8?B?M2JTaVlFcTR2bmtQeFhvSVU5YWUxNXo0Zy82M0NsNUE4K3pEK2ZGc2FLQzR6?=
 =?utf-8?B?R2o3Rll0L2FNOC8vZU05MlEyU2dwSUtDYUZqSlBNRnk4eVRGYjVDMHZPdm9y?=
 =?utf-8?B?QmU1TklOZWI5YXBRaEIxVGFxT2szRnNhdnJOTmwxMm9ITmd0YWZxZjNyNSs3?=
 =?utf-8?B?K2VRRXJreS9UYVhtakxHbnh6U1FUc2JFU0RCalZYRUw5VHJJK3hnWU1rb0dy?=
 =?utf-8?B?eWYrYU53TW5oWEhkMkltaTRPMDRjUlhGYjRmL3VVdFVjMWFOcnF2cVo4SUpE?=
 =?utf-8?B?c0RtTzhQeHhIa2o4QzFxamtKZE5Ma2xicHBYY1pqT1QrOFcwTXdnMGZZVnBh?=
 =?utf-8?B?ZnhkM1F5RlNpT0syUm5nbFc3clNYcVBFT3RLSzlka0svWEFGVEJiYUNMa1d3?=
 =?utf-8?B?SVRUekZ4S1hER0hobkkzRVZvSlFhaWxpQWVRU0F2bWkyblRMditDbmlFWjA4?=
 =?utf-8?B?d0ZUckIrbUw0RU5ZVThWWGRIMEZmUC9wZHBZdW1DWGZxSmhRbHFlQXlmZTBk?=
 =?utf-8?B?c3RSczZjcEdnR0lUQndDakloZ0dsckVkUXh4Rzh0QVZEUUFkTEpVdzd1czQx?=
 =?utf-8?B?L2ZEU1lpNlBDSzlxT2FZYWVuTDRxN0szMGJWREFyOUdiY1B0dkV3aTZSMWVM?=
 =?utf-8?B?eEtSaFplTllFYW9RcENSVGkvSyswVFJtd2gvcUZYVGJkQmVQR29ucUoyN3Rm?=
 =?utf-8?B?RmNMejdWbkZ4bnNUMzFYRTNPRWxhTzhGWlBkQ2kvWkNPQldGeEcrNlY2V0dV?=
 =?utf-8?B?OEdLeXE5WnU4TExMV0JieExjbVF3Q1J1eHUybVFqTDZQclNlRVVJUHVyNmNK?=
 =?utf-8?B?eDdEU2UxMDhxY3MyRE11a0lCUjdKZGtNYzNsbnRDOFhOSGNVOHZ0NUdQdGVW?=
 =?utf-8?B?YzQwYk9EdndXV1FhSVhYTWJtaWxBTnRvTHRVY0c5QWFRaDkvcGM4ZVQ1c052?=
 =?utf-8?B?ck8va3BjSCswb0MyQnBkcWhaaHFzL0RZMXhGbVkwa1pTZ05ycy80ME1mRk9a?=
 =?utf-8?B?MllWa0NWNzVIdjVJWjBxa29SdUl4VGpiT1RtVkwxOFBXZVVTTkRBaXNsaDNw?=
 =?utf-8?B?aUhsOGo2dXVWZDl6cmYyVXlQUm5UenFJNWpsa0NleERTeTVzakNDUGpZNDlL?=
 =?utf-8?B?aTZLTi8zZ2d4S1pNVXBhZm9QaFdLQ2RmSjN1N1REZFgrajFYK3BVa3Y3dUhW?=
 =?utf-8?B?TW0vbEhXSllHdnpiZjdJZXVNWERyYnJYdkEzNlIzcWtlVitTU0JvOCtEZDJo?=
 =?utf-8?B?d2pvci80VGZ5Y0ZQUjdkLzRxLzNzNTIwVHRXT1ZhMjUzQmdsdmFuNTg5aWdQ?=
 =?utf-8?B?L2ZyYW1DRjhwMmtRaTRWRHVSMEdyY2d1TFdZRmMvYTM5SXpKdWcwZGVLWkJl?=
 =?utf-8?B?eHhQTStRZEYxRGtSRkNucGJySE16Z3RXK2FDNENweGYvTFkzZStHbUFXVk5R?=
 =?utf-8?B?YUpvSEs5MEtPUXBWSFowU2w5Nm9jYmc1TjJTOVRFd0NXMnlvdW9pYTByR2RQ?=
 =?utf-8?B?LzJxNEd3YVdJeEZqMGhGaUVwWnJYeDBiWUFGNXBEbmxjWWN4TmdueTh0WjFk?=
 =?utf-8?B?b3JjQ0xhV0FmZmNxY2lHRmNXNUYwSHRnUTA0N2FKcVZVTmJ5aUVJVFREVWNK?=
 =?utf-8?B?Z200OERGMzlwb3krejhCdE9nbElrZFJXWDlZZm1aSzhIQUxBM3laOVF3Nnl5?=
 =?utf-8?B?NWhkTU56MnhEQktNeUQxVlcrU3hiQTV0MEZHOFhmS2tGb0c5RXk2cm5ucGk3?=
 =?utf-8?B?M0ttc3NRQnpCbXpvaTJKMHhsYVkxSTRlcHVhYzJLT2YzYmdMbDZQeXJrZzNm?=
 =?utf-8?B?c3FtRjNUaVdiYzVyWmwwbDJqbEdZWVl3TCtKanExMWNDL1ovZTVLTXh6RTc5?=
 =?utf-8?B?ZkdjbkxuVFBGU2V2b2p4emp0WEcxcGlhd1NzVk83U2hwcERsTFZYY3JqVTdC?=
 =?utf-8?B?aEVKd0YxT1g0RSsrV0JXUnFtMVdOZTFUMytMOXNMSWI4eHF6YUdEVGNQVUhj?=
 =?utf-8?B?TXdPUWV3ZnFwaGcySi9MUDZkVXI4eFA0UEFOUDVLR0NDK1UxNU1lNUV1b1Rj?=
 =?utf-8?B?ekx1WWJaZUlsejNWU3ZKUDQ4QUJuZXVHbkdEVGQ0NnhRakF6WVBVQ3owM0FQ?=
 =?utf-8?B?d2p3MFk0Ym8vTVg2Y25pdGZtQUJTbFRMb2praS9hZjR5NmpvZE9Tdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a4f4bf-adf6-46ea-adab-08deecc9012b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:55:18.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZblhuthgWLYWkB9F06iqIhZZsIYVdzNZpyDOpcKaUCvJD29B3TtDVESLn7D6feKtAiy/Vd/r9xeK9Wdw27QbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 16:55:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23806

On 28.07.26 15:12, Quirin Gylstorff wrote:
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 6badc7d..cbccf63 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 3c645ee8dcd3d2161b93a3b2f9808fe1829850e7
> +    commit: ea319eb835aea545f23266ba15358bad029a56a0
>      layers:
>        meta:
>  

I'm bumping this to 8ae7612dbc72607825e3efce6c3f8eef66200f2d because
several related fixes were merged meanwhile.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

