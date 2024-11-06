Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F24D59F57
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 17:33:18 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.67])
 by mx.groups.io with SMTP id smtpd.web10.51743.1730914395798572974
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 09:33:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T5hbjEOx;
 spf=pass (domain: siemens.com, ip: 40.107.103.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzZRp6ZN+6zZlReioliHaX8e+3gO5pIjtYcIzXRM3D9hgDx0TKJ7IaYuwYU7RJ+wjX7pGAVttXsC8mTsRxePfZLGPHyrWVt+24OKbqQITAhoK4ng3C5gmuJVHUedjZ2MqSX7cOBCDQ4EQSmEZCInac0FM/JvfUGHlGv3P72NGds5QfYW2YVn08kizXkBh/m7fQeauAuL9vXMvKZPcd4lh0FqI4PS1Iawl1Vyu241Gxrl8srpryrpp9doSvh+7ULqBbV/vBXFixHyr9WEeHKfUjXHNh0ZfKbNRVUolrjXVh1jDfohWIJpPnA3zBaPgeOQwWwas40iDoykyUmbLx1+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqlJV2SgGyKY3qEquWvHnwLTJAVZFhp7FD9cCqtT8Lc=;
 b=bGjLTgTYPvVCnYbSsxcCtp2YmEYNvPMy0XZ736sut4YovzM1i0dkcv+Hu2NY3nVbBxSc9EPXxqkP/ph2XsFI7oZq6GIL07k3zztpdwMPD2cT3p7ExKGvq4tQwmlA8UA1kZzELsY2pC+oc+SgX/n3pFJMpUw52e2ntneMoK2bfEP+YL/ENOjkjYjPcCqF5JllvO5x/uJZMy9ZYH3Rs1VnvD/in3QFz9Q8BePrkcTXeYvhuxhMwkDS1DyOaPVxSMWKdLU3fSdnxqSbCI5wrE/bytx3smNvTR4nUkXpVEoYlr7JviKaizm8NF5knz61/uzVl3oYpay8cZVisSQr9PWhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqlJV2SgGyKY3qEquWvHnwLTJAVZFhp7FD9cCqtT8Lc=;
 b=T5hbjEOxHbuP6CisONxBnDxM/0Twkcwg76W155i+Esk1SWd8Xn2xoXHUlqzHbIEM3HgOkg7y4EHtmOyEPbp3EwrpFOh6BTzRorzcImAvUIBzJWVkg/cCM2mXP+TVJA/ouyUMpceMLKJYlSzf40QXC+LNO4rKNJkq36M79dV1dIccp2lv7OrIlHcMHVVxCTEgOBap7QKemM5Ub/wJkiQcnC/dzfkoosZS9ExTPHc6KD5ykCngF7Lm9y9o/bPWUk+hXixYWGfZUZaQByvtHJWkTa4igiQnI8zeldCyZFARepkPxBcdOlARD4433wveBBJ/ODlnQlLhC4ch5Yj3tu8taA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6337.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 17:33:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 17:33:12 +0000
Message-ID: <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
Date: Wed, 6 Nov 2024 18:33:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0229.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: a8397863-8b10-4123-b3a1-08dcfe891659
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bG16ZFhReVcxZjJkUzhESEUrOHVwbkt5cVNGeXdaSGFQcWF0S2NFeFVPTmlo?=
 =?utf-8?B?TXhyT2hlY0xUV3kyUjE3THhMTUFGdERweGtkYUZLNWxkQk8rWTFuZFd6VElW?=
 =?utf-8?B?V0dYVGtncTdLa3Z1T1RQaHZadUw3QldQOVhCWHUyUnNROXhIajJRY21EbDEw?=
 =?utf-8?B?TkRiMFkzUVpGQSthWHFRd3BxdHM2RlVPYll2QXZyQ3M5WmZFK25rckNyUUNJ?=
 =?utf-8?B?ZlFHWWZSc0FlbUZwOU5jOWUveWlFSHpDSnA4Z0FjM1dBNnA2RFJxeUdiOUxx?=
 =?utf-8?B?QlBqNTJJeHZSeXFnOGFhWlFKTFptdG1xWWJXYWkxUS9iUXQyRlhidGM2aWM4?=
 =?utf-8?B?R2JNNWhjRmlJeHlZdDJVN1c0VytxOUxFYnZNL0ZUeVJhQ2s5aE02R2ZWZVM2?=
 =?utf-8?B?MVcvcGtvWk9IWXNwTnAvM203WXZSUTVkWVQ5R05BZGpudnVCdSsrK2NjR1h3?=
 =?utf-8?B?NDZycU5ETWRyZ0dtdUlPT3FKYnpDSSsySHo1OTBNaHFDZVNGSExrbk5uZHVQ?=
 =?utf-8?B?SnJ0Q0podVhhckxLdktudnU2b296ZGpPZ1ptNGdwWm9IM2ppRmQvcjhlWjRv?=
 =?utf-8?B?WGRsUEVEQ0l5d3BLMkMrOUI5RGFldWRkQ2dxU3BheGdhWTlZUVZvVmNidEdY?=
 =?utf-8?B?M0lvOS9Rb2c5VngxbWdMbXA2RFNwZ2tTTytOaFV3V2dBMmZGclJlZUVIWC94?=
 =?utf-8?B?UmpLRGtta3kvVXpObkxyUzU3eHRrWHUzTmxQTElyZzhqY002VzFHa3dqbzFj?=
 =?utf-8?B?K2ZFaFJzZlg4STVQOFZjUHl5ZnF3Zkd1aC9yNjV3dHRxcTM5OStUQ0tzMW1M?=
 =?utf-8?B?Qnh2RHZKTURMVm1vWXcyZmpBWDJQeXR4REhtV2xwY2RCN1JRRnpwUWhIbGVQ?=
 =?utf-8?B?Y2RUOUEzaTk0c2dSSlRpYTlZdStIYjJXcTVLdm4zRHBrS2xJV2JjN2g4SE9E?=
 =?utf-8?B?YXFEOU9rMzQ4YWpVZWlKd0xPTW1WNUlGTG5YSGlTVm02bDIxblBFZW5JV2t2?=
 =?utf-8?B?bVdkV3gwa2FZYWZ0WFNkTll1UzNhSU1pUGFKMU5LQk5EWlltcXA4aVFPOC9G?=
 =?utf-8?B?dUpaZXVMT29GNjR3Q0Z5ZHhza3pmZ3A5R0hOYkxDK0FkV210ZE9jY0crTzhE?=
 =?utf-8?B?QzllYTU4TXpRL0RrMTVod2prQ1ROQUZ6d3pkcGRTTXplTHBMVnlya0xsS0o2?=
 =?utf-8?B?T2VsVnVBeHh4V2gwLzB6RWdPd0pmS3dpdy8yWlRqd1RjZTJEdzFDaWFLZWE4?=
 =?utf-8?B?VVgxQ3FvaXlsVzVTK3puUVBFaWNUTGcxSExHOTVxa3hPaW5CNU9kWTQ1SDVO?=
 =?utf-8?B?dmo0ZlZrN1d0NG1reE9XWlMwemlRYzM4eXEwdG9iRll6K1ZOaEV0NFBrVTBz?=
 =?utf-8?B?dWMvb0N2UStFdFdpT080a3ZNRnhXVWMvZG9iazRJUm1hWDcrSThIa2NCVG02?=
 =?utf-8?B?UUVobWpreHVHM25RUC9CM3FNQnlodTJUdGxaMlhQNlI2Yk9KcEJjNEpwbmRS?=
 =?utf-8?B?dERuWXJuRVJEZGRWRjZ6Rk5zd3Z1NnJsaStNRythUitRdXF1R2pJNGx2TkxZ?=
 =?utf-8?B?bEorOTUvcHBScGlZVXpDQXY0Mm1MMVdvMG9GcmJVWTBPaUV6eXNNY0t4QUds?=
 =?utf-8?B?VER3SVF1V29aaElhcXFSYWYwY1RYQkI4VTFBSUp0TXdialNTaUgwV2tzRG9O?=
 =?utf-8?Q?asLA6mL1pcPdY9JMk0Vo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3Baa2hjYzRCOGI1dStTSXFTLzVZVVFNZC9uUndZbkxWMWE3YURseW9XOUJ4?=
 =?utf-8?B?TUhVMUtkSmN0cVl6dTRRZnUraGpWVFVrWjBmZ0REeGNqYjZRalNvRCttNkhw?=
 =?utf-8?B?R05CNElQUGkwNFZYbW8zNUhES1FxVWZwY0VMS095KzdzeTBnTStGOWd3U2la?=
 =?utf-8?B?SjJ2OUZ0RlFkblkzeWJXRnJnZjFCZHV2ejV6bklIcTYyUnJyYUNwU09YeFRJ?=
 =?utf-8?B?eVAyMmprcEFyem11aHkrYUxaMzc2UFQwZmpUamdjZkxKeTZwMFBValRlN2lr?=
 =?utf-8?B?MjhhQ2JScHhPNWlZZUZrc294eC9GYW9DMGFEL0RMMGN6UDR4NTViNXZwc0kw?=
 =?utf-8?B?NndBVXJpaGViN3B4TkRIb3gzNy9LdXdnUmZ3N2tXSnd0Ny9hZzVoU09rSjhs?=
 =?utf-8?B?amFNNmdWdVROa2tPcURXbW1mcUlHU0djUTc5Si84N056bGV2QVVKNjd1NE9H?=
 =?utf-8?B?cXBXNngzbWFNUThtWjlCNlFQS2ZPbFNveC8yeURvM2szejNaMGtweEJ5cm0w?=
 =?utf-8?B?RlU4QnBhU3lWZThMMTBXVHhWK0JrZHZGL0REQTFkR0JFaVhMOThDUGZYZkYr?=
 =?utf-8?B?S1E1dWpjMDJSS1kzNmFKb2Q5UFk1cGl0RVI1TmN1SGdrVGlVN3Y1NjM5c0t3?=
 =?utf-8?B?QkI4b2VoU2hOdDhTbWhYQWo5TEF4Zi9GMkNjRDE1WlFpaGtYRVhrN3cyZHY5?=
 =?utf-8?B?QSt5OE1GTWk4ZDdXZzM4cnZmRXcxK1E3RmREVlBvSXhVcjFBODQ0Q3ZyNE1U?=
 =?utf-8?B?c1RHelVWeGpBVU84VnlraTRNbjJmZGl4b29ydS83UUtidnUzdXhEL3ova1p5?=
 =?utf-8?B?M0o2OENXdzBaY2svbkdwWkZRY003Z1NQdEJBZUI0K0wveTlTOUU2eUZwbFJK?=
 =?utf-8?B?bXF0SmtteWltbVluRERHc0o3ZkVtcE9TWDIrYURROU12NncxdTlrdmpwU3dn?=
 =?utf-8?B?RTdwNjZOTEpaelB6WFhMZC9waVFlUk1MSXpPdUkxYUUxRmpGaEUwMmluaHJ5?=
 =?utf-8?B?K0tCQUEzQ21JNXhiRWpJOGZVRCtURWpwZFh4UDFJbGV0VVhPTDBjamhHa1Na?=
 =?utf-8?B?dDBkVzdub3BVSmVjTDNuWlFLV0JuV1dkT2F3SjY4L1RKZVNvRGdiQkJTMTJp?=
 =?utf-8?B?Y0JpTlNnQlNxcC8wY0NEZFVBRUd2NWlSYXFvL29HTlBERXVLcmtKV0h3Tndi?=
 =?utf-8?B?QXdOVjBCM1ZJZ2tKZWhFbFdFK1p2aFpiS0daUldqd1FuMHp0TFk5L0JMemR2?=
 =?utf-8?B?MC9ieEpDaGRQNmF3citmaGJJUWZzeG1uOVFwUm04em1iZTArUTlrd1dxNlJv?=
 =?utf-8?B?c096bmh5MXFxV1VMd3NHeUJFWnJWeFpCTU1LcGF6NWhkM3JtVCtIenhMK0Fa?=
 =?utf-8?B?eGtJZkJLL2w4L2xqVDhYeUhLOThmWGN5OVZYaUhwU0U3dVFIV2l6UE5DUFE0?=
 =?utf-8?B?QXlYbk9OaVdkSzAxTTZjdFlFbVZYTDlxL0ZMRXZJaDRoTlNtemk5SU9odnFr?=
 =?utf-8?B?cjkzYnZURXA0VUxianB2b0dYNEg4aWVLNWFBekZ3RTF2eG5sbWJPcTBHbzNI?=
 =?utf-8?B?UjRDNU82N1RXZEVzdzRaQVJHVW5MMHU5bEhONm1qRzZ4d00vNTUwdEVpOTcv?=
 =?utf-8?B?M0dRSHl5L2s4azdKb1A5ckkrZllxMEVUWjU3SWFYdTlGY0tZNkVqOHpFQkR6?=
 =?utf-8?B?ektqbmljSGMwV04vTUdrWjZGMVBDdW9wc2MwcXZpS003REwrTTJHK0xkZ1lz?=
 =?utf-8?B?U3Mya2gxMlNNTzRubWliYVFLMTBKUGx0YjRZeVZHTzdJUVZ2eUtJKzdtVllP?=
 =?utf-8?B?TEZrRFczS0hRQ0srSTdnUTViTWVoME11Y3h4TWowRUR0akEwT2tuL1kwekZN?=
 =?utf-8?B?Q2RXL3lCdzRrUHY5WkloRUlxYXljR0t3YUF4bGZOS1lvQVdKcjljU3QvT3Ry?=
 =?utf-8?B?Y2NZTFJrTE1VbEpTSm5rMkd1Sk55enR5bm1ybkJ1dVZkSEMzUkxTNFFpMDUr?=
 =?utf-8?B?aGsrN1F5SGhmN1QvLzdPb25nVFRXSDVXUjJialVZTFdDSzBFbTUybEVGc0hn?=
 =?utf-8?B?Zll0bFZTeS8xK2xwdzQxa1hiQzdhOGpETUErWEVHMXlRS2RmbTB5MTd3V3hj?=
 =?utf-8?B?bXdobVJKbVNXSW9OWWQvWk9RR3NtcWVjcHNqRWdmeDcycFpoUjdpZnEwTzlt?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8397863-8b10-4123-b3a1-08dcfe891659
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 17:33:12.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYlbZeH0d1P8V3HVE5N5iMN1/ymY3YZqF1Q8JEGcN7UZc0JhZLGqDM6H1Xj/JsdXiiCr84eG7KWBvuj7em8FcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6337
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 17:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17191

On 24.10.24 18:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>    Unfortunately, I could not find such library anywhere! - Therefore, expand on first boot and similar,
>>>    still won't work for current disk encryption implementations for buster and bullseye.
>>
>> There is no clevis library as clevis is more or less a bunch of shell scripts. If you want use expand-on-first boot with clevis a solution would be to extract the passphrase, see [1],  from the tpm2 partition enter it via a environment variable.
>>
>> [1]:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.tpm2.encryption.md?ref_type=heads#steps-to-convert-clevis-to-systemd
>>
> 
> That means a bigger effort on `expand-on-first-boot` script than just setting
> the correct package dependencies!
> 
> Currently, we are using systemd based cryptenroll in our project.
> So there is not too much motivation digging into clevis for that use case.
> 
> Still, I think fixing the issue for bookworm (systemd-tmp2) is better than not fixing it at all.
> 

Quirin and I discussed this a bit longer today: We actually should
remove the need of expand-on-first-boot to access the key again. And
that is also due to an idea I picked up yesterday to lock the tpm secret
after initramfs so that we reduce the risk of leaking it via the main OS.

Our plan is now to convert expand-on-first-boot into an initramfs hook
that would then come before the crypt-hook, thus would only work against
the unencrypted blank filesystem - problem solved, just differently.

For now, also for trixie, we will just make the dependencies of
initramfs-crypt-hook release-dependent in isar-cip-core.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

