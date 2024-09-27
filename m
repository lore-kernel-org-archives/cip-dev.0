Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A85CCEBF9C
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 11:54:44 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.68])
 by mx.groups.io with SMTP id smtpd.web10.67216.1727438073218836795
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Sep 2024 04:54:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZoGAJX0d;
 spf=pass (domain: siemens.com, ip: 40.107.241.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPPtgyPJCeweNs40AwaZH0DP9QhKR8MJBG/2+MdgQPHwEQea0FMC40vqiy1ujeve6RV9lZkH+vMrQzcJIR70Pn1VC7gKDtOfA8UJRE4nNlvGV9RJpqz1ZYLiEHOhxPh9MjxNjIvIJDLduFe4poxC0cBg5V6lmR7jny9GqQPrMhyiMpcBhJ2De4KfbP3is8MVMRnJ/6I1NcCLAENN/2/WZfROnGQlO4fAwXKTaMRyc6OpHwoEnOsQr9V5wyB7IFyJvgDvjvj4xudli1TEmYFrRYJiiu7MknFtRHw4aQxsYmWsrtYPdlbkyveU/RCoWUh2lLPoK7xNAfZnshM8+76LIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv5L2YURuvYtmyhAwoWDHtTjTeaK3JFS5GxyBMNXmRg=;
 b=ECyneoro3m8HylxIWJ6z2xfYegjhayOjKanGfIP/jShzWFcGnK3tYq2ZBhtmCF7xFp1e8WuMjFzdaCnU8Aa/fubqonMdDaEqwK7+HluTucgWFuetPQs94reQNOvwo+7GLUmb8totHH1kNHCJJ4lJBhomWMvpbY4uB+uL5P0O/6sQVViinnFBwzWHUrXoCicS9YRaZ8K/AsKBuUpUS+T0zTpLxNmq4vrInsAzUycKgcmVV7ShqPujTHY5wMCWEu22Ae9D6DQa8g5SBbvyOFN5+gmAUDo0qvUO1Nmv5moDO3L8mpdUt0iqV3OZEw3nTHqUh6G4aHJbDpPwi8OO3l55/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv5L2YURuvYtmyhAwoWDHtTjTeaK3JFS5GxyBMNXmRg=;
 b=ZoGAJX0dSsuwJjV+OyP2tY7L0KT19QOMwd5Qv3WHfi3oXw4+CNlX3F6KxsTTWY3zYA4r/5kRfPMxDgGCh16dBCUmXw0/IUSAACh+w7XgHqi8AaOUaWeAUVeJeg/upFiiy7UaHgUHnmeb7X7aJe90EFCRo9e41RYVp67fKLM2CtmY6OwXvkGrNbrXr0tx1yUHfFPpxNcObZmFSpNhfChOZpBdY5xEDTJZijjcEzSylKNPCC5mzNRFqNCJY20ebMamu2kGzFksoTRckW6T2nmsR4Yokr3RVL51qq5/ZDWeXEWjF6Yr41NwaIjR6PXiGcCJ111PtnCCxQHqqSYJ88OQ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 11:54:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 11:54:27 +0000
Message-ID: <37027874-bd96-447b-b969-00e5e1cb7340@siemens.com>
Date: Fri, 27 Sep 2024 13:54:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/3] Separate swu signing
 script from key
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 23aca692-02b0-4bac-f096-08dcdeeb23aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VklkaWdkaC92WjF4SWltMEdVdXo1T2hoTXhuQjg4NzZWR2hDK1lGNnk0VUlJ?=
 =?utf-8?B?bXI5SDZhaDFKMFlnYm1mc0h4Z3lKSWh1TVpjNkdISWY0eVcvMnVZbzN1cFd4?=
 =?utf-8?B?c3V3OFlEbFBlM0dhN0o1K2pRZWUyYU9tNlE1Nnh2WHA3bGdhdTZ0QzRpcWtm?=
 =?utf-8?B?aVh5YUNmT3krQW9SVFNWTlN1cmZHUHREdnJHM2VJeUxmL1lvQWlRQ3hkUW9Z?=
 =?utf-8?B?VUZQNEhrT2xCT1lsU3V4dnlOb1pZL0pSYlRqTlMwbzFwUnFrSytjclZkZmJm?=
 =?utf-8?B?a1dqeXVPRFVtalBpTTJvSUk4ZkFLYWtrUkZpaElXVHFJcklMcTdPTWlGWWt6?=
 =?utf-8?B?bUlrQTQzQkdYSzFzRWlKL2ptVTZkRW15cWRiQitMU1lwVVpjTnFzOFpZTmR2?=
 =?utf-8?B?NGVCRTcwd2grM1dreG9hTkxDWmlaL21QbDY5NURHaXZsMFBZeHpqVnNwa0oz?=
 =?utf-8?B?ZWhzUlF2ZnpIOThzNDVPL1hmeDFGRnRmREFmbjBUbHFUWEFoZ2pIM3hnRWNB?=
 =?utf-8?B?NmxHL01FbnRrNkZGRTkxWWlZUmFDU081NVlobWMrUHNoelozWnFGU0ZyN0pk?=
 =?utf-8?B?ZnV1MVk2VXN6eE92RDEwWmpZUGZSVm92Mkd5ZnNMMlFhaFpPY1J1dEJmL2pk?=
 =?utf-8?B?dEdFMmQxWHhGOG4rLzNGWU12akhYWlp3SE1HRTBwZTZCMmFPYVo1bEF6aFhX?=
 =?utf-8?B?ZFg2OThHeS92bEZpMHAxK0s5K3YzS3poQ092WGZzOEVIWk9ickx6TnZJRm1j?=
 =?utf-8?B?MkJjZDgvZXNSalJsbkViRGhZdzZoc1pWT3BPaXhERjBFQ0FFdHFsM1RzN2pU?=
 =?utf-8?B?WVJWeXo4WnBJdjRGRElYL3R1V2JBNU1Uc0h1TTVRdm8zSXdISDBaU2dZS25l?=
 =?utf-8?B?U2Q2L09oV1k2S3NxaGh2MWdlTmh4YnRhV0haZ3lTU042akRia3dQSy84d0tn?=
 =?utf-8?B?NzhpUTdNOHVBTDFzb0Y4b096cUhCQjhlcTZzWHJndFZPV0xxZmszMnNOd1pG?=
 =?utf-8?B?ZTV5aVliQVJsbVl4elRWTmplbnNndVV1OUdPamdhekRtLzFYTWZRSC9GWjhN?=
 =?utf-8?B?cHU1ZHhZc25ydDFpZkZVVDZybEgwWjU1elJkZjVCUVRDTklvLzA4SWxNeUcv?=
 =?utf-8?B?N0FyOHQ2MlJ5MjBHNDZQU09Sdy9oSGlpeENGMkVlZmhBNWRYcUJSMXpKTjhk?=
 =?utf-8?B?YmVkQ1RnMXZWMFFNNEtkMUltdDV3a1VmU2JmTCtjR0llbUpIalRxd1NCUCsw?=
 =?utf-8?B?Y3hzOVN3SVRjVDJMM25ncXUraVQ4UFV6ZDdaQk5RQ2ZtYlA3aVU2S3pBbE9R?=
 =?utf-8?B?SmY2M1gzaHBLYkRzQWVmdENrQ2pHREUweldRL1ZzbStmd2hrNmdHSXVSb1hG?=
 =?utf-8?B?VkswS2FRcXB2OFFHRFlkR01tUi9EQ0tKSWNMR3ZZOUVHRHBhT1oyUG5TZlBz?=
 =?utf-8?B?dVUvVzI4TTdjT09EaFFrV04zdHlaK1dSMDFqQmoyZEtTallnZGVFaVkrWDFB?=
 =?utf-8?B?RWcwQWkxdFZZcERlcFhFSHZZT0k4emw1aXZVeGZnUlZUdnpsdXNvZDNGeGRX?=
 =?utf-8?B?ajN4YVNQemJTRFBsZEd2NFBHY0RuK1VQSGd0djF6UFJYRDZtYk1XVUE2WWYz?=
 =?utf-8?B?b3R6dHJsL1Q2OUtKdkczWnFMdWxsZlQ2cmh1Q0RUQ3pEaVdhOUFwVG1XN0JC?=
 =?utf-8?B?QW5UMnN6MDdaSFVvUW4vM2QzWXNmVzZOWHhiUmFKU25pUk05bVNWdThnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXRZcnRmajFXNTlOY0ZncVIyaUlHM2FkTmpDQnpDTDVZN3IvMzhkNHZtRFZw?=
 =?utf-8?B?UnBJQW1RZ0Jubk1Nb2J6dm9YbFdVSktHVTEzMWIwNmNvRnBoVUh2RU9YSFg2?=
 =?utf-8?B?QVdkUmtXQlNBK2RKZVFKRGN2azRheGh3eEJVR1h2UUpxcDluRXNuQXVPbnpF?=
 =?utf-8?B?Q1pzeVdoSW11WGkrY0xadFZUMnpFdzZDV25vMTVSYVJlakhVNlIrMFVLVnI5?=
 =?utf-8?B?UUZCVkZKM092ZktIZEcxb1VjbGJsMCtDUWZZVE1tY1cycjBCcktKUXI4UzZz?=
 =?utf-8?B?QXVVVXdYek9ZcDBrSXBnY0FlRzR6YmN6T3BSdFVydmUzdUtBRWg3cmhTY09P?=
 =?utf-8?B?aG02TFltWGEwNTdqM3pmeEVSaVUwdzBVNDhBVG9Dcmo4WlNjSVgwcUFHNUFo?=
 =?utf-8?B?WnlJQUtxSU9BUENITGQwejZjMXRWWjhtQnE1cFNUbkRLT3hZa09hMFN6OVBP?=
 =?utf-8?B?aDFsN0pubVdWT21vbGUwakdSZURXbTRqTjd0aTFZT1dEbVVFWmVTd1Vub1o2?=
 =?utf-8?B?WmtsVk5vc1dTbHR6VlBRWkF6SURRb2NmL0w2OXppQmx6c0RqZEZjWWlLNHZF?=
 =?utf-8?B?bHcwNUlIT1BxZXN2bE5UeU10emc5WGdldjJsQmpBNDBjU1dRVGdxTDR1cHR6?=
 =?utf-8?B?Y21US2crdXpORWNrTmpGb292L083b2tkSGhPeWFmZ1Jkekh5NE5keVJZYkcw?=
 =?utf-8?B?T0JpRHFXUFdmdkI3NmtmWFpxUVd0akQ3WVBKYVRZQmlOV0xUY1c5TDhleWtm?=
 =?utf-8?B?VUgwRnRUeURTeFozY0IxelFJQ2NBMjF1dDF4Z1lJZnNVeHJwUWtRMDRQK3ZV?=
 =?utf-8?B?SUM0K2RyRDgySFhoUUNaem1hWjA0TlZ6d2dDTmhXN0thRDJwamZHamdwZVpR?=
 =?utf-8?B?VWR1aytQSmZERnZ0d0g0YjNUVDFrWUF5M2V3U2t0RWNrSHpjbVVHNkdzU3Rp?=
 =?utf-8?B?RUp6c21nQ3gvc0RXemNSWElXOERRUkh1MktxMlNWZGppcTZ4WWxRMG9IZzM4?=
 =?utf-8?B?a1AyUEIrM3g0OS9XUDBqNnRTUDV2b01Lc0pIUVF0eWo0SE1xUklVWlp1U01K?=
 =?utf-8?B?SFN5U0ZIWUo3ZDBaY3ZHc3A4ak9yc3Q4RVZGTlpRVUV5YkxTSmtvNzJBTWFX?=
 =?utf-8?B?ZmdSNTdXS1ZadkNKeUJnY2hMT1UxTHpXcDAwR1ZteXNCU1V4MW9ydTN0ODlw?=
 =?utf-8?B?VkdhNC8xTXNiLzhDMDcwdGFUaldzMTFqTFlEd0VMSjREcmVBdm1Ba0dqT2tD?=
 =?utf-8?B?Q0R5NWYzYU1melAxZFRQdlFmR25vaXZyZEw4QWFFQWN3aitoQlZIT0x6bWZE?=
 =?utf-8?B?MFZHbVhJZFlLQWVoNXRDT2lEZlU2Y21Nb0tBWWZUV1krenFEeXc5ZjhBbmZ1?=
 =?utf-8?B?TjV3Ty9YeWN3Q0FkMndTTUFJdEFCWVdTTll6VUg1bTVxUVljZnJpTG9DcGps?=
 =?utf-8?B?SzBmOStOQkRRaWQvRHdoTHpkZC9NaVMrR2dMZm5lR3NaUmExSnR2TWZRK05l?=
 =?utf-8?B?NHZ6RGg5dWlzdDZnQVZGU3c4eVJqL1pkNmpiMWJxbUhaZTBkbXovMnU0SjJq?=
 =?utf-8?B?NjJzYUFtZTJyRWlsOFh0RkRNSDl4NWpsc0dydDQ1VkJydDJHenFsS1NLcVQ2?=
 =?utf-8?B?YTNwazdSSEF3KzVXRm81UmdHUDc4ekFlMXdHTVU0ditvSE1kSHlRSzRLbGxR?=
 =?utf-8?B?VFJPSmhRWG5HL2lPL1Ird2ljS2FzMWxvYjJwUEFTUUVjS0oxRjU1M0xzVzhl?=
 =?utf-8?B?TXNIOFRDSEd1dENHblh0WkY3dk9Fei93QURuTll0cFRXT3BKOFBuVjNZRnVY?=
 =?utf-8?B?TnVRdDJNaFVDaXdkN0JEQ1RiZEZLaDNacWtrWEV0Tk4wWkpDMFhiR1lTUVND?=
 =?utf-8?B?cnR0UHY2NVltS3l0eWlWdEpUcVJzS0NFdHlPaU1rMWdkWFIwUERWYTA0WVVG?=
 =?utf-8?B?THZXSW5XTmlWWXc5eGRBb2t4ZWlkZzcrNCtNYitQOGpUTHJKWTNKNVpKbkNH?=
 =?utf-8?B?am5laDRxTEllY0hlQlNoL0JrVm1xeUdScVN5QjFCaGxqYzlJSURSZHpVaEJ3?=
 =?utf-8?B?N0R2Slhka3Z3VGVmZ2xad0MyVWpmQ284Q1VrcGViU1RPL2RuUmpaMWJrREty?=
 =?utf-8?B?a0UvWnFZWUhLM0g0Tllyb0xrRGZGVm1tM09kRVgwNEJXM3V3b0lVSXM4VkVP?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aca692-02b0-4bac-f096-08dcdeeb23aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:54:27.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9UTIPfv2cNYqApehdoDZNkN56qxynaJBhvoOZ/RceacNmG/cMerq+KGu2Nw8PKlMvWrjlNPLQl/YE7FwFdf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8430
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Sep 2024 11:54:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16925

On 16.09.24 14:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Some downstream projects use Hardware security module(HSM) to sign their
> updates. To avoid a error message in case a HSM is used the user needs
> override the major parts of the swupdate-certificates-key recipe. To
> reduce the integration work in a downstream layer:
> - seperate the signing script from the keys
> - move the package installation of th scripts out of the swupdate.bbclass.
> - update the readme to show this new behaviour
> 
> Changes in v2:
>  - remove SWU_SIGN_SCRIPT variable
>  - remove rsa-swu-sign script
>  - fix typos in commit messages
>  - rename swu-signer to swu-signer-snakeoil
> 
> Changes in v3:
>   - Add example of an empty swupdate-signer
>   - Clarify signing script section
>   - rename swu-signer to swu-signer-cms
> 
> Quirin Gylstorff (3):
>   Move signing script to seperate package to better support HSM signing
>   Add check for sign-swu executable
>   Update README for swupdate signing
> 
>  classes/swupdate.bbclass                      |  7 +++--
>  doc/README.swupdate.md                        | 25 +++++++++++++++---
>  kas/opt/swupdate.yml                          |  1 +
>  recipes-core/images/swupdate.inc              |  5 +++-
>  .../swupdate-certificates/files/sign-swu-rsa  |  6 -----
>  .../swupdate-certificates-key.inc             |  9 +------
>  .../files/sign-swu-cms                        |  0
>  .../swupdate-signer-cms_0.1.bb                | 26 +++++++++++++++++++
>  .../swupdate-signer/swupdate-signer-empty.bb  | 22 ++++++++++++++++
>  9 files changed, 81 insertions(+), 20 deletions(-)
>  delete mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
>  rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
>  create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> 

thanks, applied

Jan

-- 
Siemens AG, Technology
Linux Expert Center


