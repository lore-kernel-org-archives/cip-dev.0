Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BFAD3ABFB
	for <webhook@archiver.kernel.org>; Sat,  6 Dec 2025 08:29:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2372.1765009745039411761
 for <cip-dev@lists.cip-project.org>;
 Sat, 06 Dec 2025 00:29:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bUX3SnQE;
 spf=pass (domain: siemens.com, ip: 52.101.70.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCqDi4Qb0LAa09q547OVJkOFQykxS45bX8lrxAmc8U1nEgXfDsiZpUZGXIYsyYJUVYu5QetEPkCrM/+JrQ0wVGuEb+fCXTajkbQzLCpNa8D4u20oEjCGhOJFgVw0T0j37gwJNVBgQihr3dDAc3YB97Mh5niuplw1cV8h1lXCK4v6l4DjDz9pTs59C46NWNM8r2FIZZXmewHO+qvO4Wkcow9T1uxdykc3tfHCRZyM7Tczyp4Ev1vuNwUIp4j0vnMh9eYCNLyEQfl3MVuvXB6qdSfYGCEvv7mnqqFfrfZ7QYen9Vqdktn0fCUWDFd85tSbjjEvLLlMIJV3GYd2DKN22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcQzgNsNw9lDs8LxU9R+0jEj6ibFm0/vC538WSqYhD0=;
 b=P63NnE2PyFt86AHU69FPiv2FTw6SlBbLI0dQIqx2Mw4ShuyraIerAE9F6JpDdv+3kqhS8jNfluwL6R9zs2/0NldJf3CjPG2zy9vfTLZcKIdbUUFyyNdNEAH6p5aafKuSLUp47ksY2G4XEOHF+o+BX3FRRwL9+TAGmGSVIWnpOJWYBW3Z7YXN7djeMUyTJP9kAy9hRrmAmw7f66JtFU8DE3dhF4sv75A2uewX5IF2Y/6XE8wrDv6ks6ox+wzzluTpfoYZqAxee4O6+aSQ/vvqRU4ugqRyPPvSnjXx/asaiPx9dO24fNybxEAXN22TV+GSsfdyTW+ZLU72PcV3OYLuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcQzgNsNw9lDs8LxU9R+0jEj6ibFm0/vC538WSqYhD0=;
 b=bUX3SnQEmWScT2/HqFKNPBbTEb9YRExiVJ+g7QmNNhS5LFXeC0f8gOR2AZg/OUTwg9455tGrZX3rBvtQUqPrg0Q8dmdSgJRTtx1yaYBFZw/B+rJ+tv0o5lM9lG0bw5cIZj/R4KIXlYH0aZIyuJtx59q+lrk/GtwrvlS+1vUlKNt6hy5+UsvZPHxBjt9cbLhKP+jZ6mYLOf+fKni+r9vu1J/hxuxn1ywEyk1hF5zP5KryIAQ451K+3SQwO/5JbGx5OcvkrahGLyf13Xej8MALBeWtjQbfIHmzpmLnvSishWgLdShXP8cwzZC9fg9M5LJ0/RBaa71HsC5d6xKj/5aiPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Sat, 6 Dec
 2025 08:29:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9388.003; Sat, 6 Dec 2025
 08:29:01 +0000
Message-ID: <5f20b8a0-f3dd-4aca-8874-0dbf38a6b387@siemens.com>
Date: Sat, 6 Dec 2025 09:29:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Deployment of isar-cip-core images, lava images
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
 <TYYPR01MB1513215D1DF4F9187043D495FB7D8A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB1513215D1DF4F9187043D495FB7D8A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 57575a03-c6de-4774-ab2e-08de34a18243
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|3122999012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b1ZiZmhSQkNaTDZiVnZRNFk0ZndIRXlHbkxBOXJXeThFem5oSkdSMlZxeVUw?=
 =?utf-8?B?NnpML2d1YklNZCtma0tYM3l5RDRHVGEyZ0xiaThGekwyNmZsU0hwU3Zlellz?=
 =?utf-8?B?WEdmR05MbUV4OGd4S2NsaEk1bTUwNFpzYkYvY1RFbWJDM0dhTmNPa2lZRmQw?=
 =?utf-8?B?eWlLdFhFbHpUbnNtUWZMU29uUlozTlhwK3UwbU5iOUVSWkhmR1J6RWxSOVlo?=
 =?utf-8?B?anNSaUpYa1Q4MXllZUtHVTQ0VEFzVlNIYTlyVUJ4eUYyZmZjWisrckpDb0dJ?=
 =?utf-8?B?SnExM2hmMERoZzZjeHlWdjNyTXJRckoyUEhBZ3gzMG1xcDN0UzlYUUt3amFU?=
 =?utf-8?B?MUZGV2lpWlBqZmR2b3RHU0U4M0c5eEFrZUtQQys0UG9Iak5Id3NCQmhQdjBV?=
 =?utf-8?B?QWsvdlpVK3FGU2NOdktTWWxpa1NUR2JaUHJZL0tVeTJuamVkSmx2MmdUSTQr?=
 =?utf-8?B?UDVRaHJhZFRxVHhEeTBxNHZnT1Z5a0xacEphc3J3KzRFRVlmQVkxUkY0YW5U?=
 =?utf-8?B?cmFWTHpuL3ZsbG1mNG9TZ3RZUVFtbkpkZCs5M2RMMkUxRitUUEk4R213L0gv?=
 =?utf-8?B?eFNJZEUwNXJsU1J6ZU5RY2FIbHBZV3dZQ1RBbnFCLzVQZlBJMmE5SmZOREhN?=
 =?utf-8?B?bWp0bHZjRWl5Wk0wK2FFa01KSmNYUFpkcUVKbjc1ZmZVWUdLU2x2MGNPeSts?=
 =?utf-8?B?MXVmZW5PTHEvaXB6SS80UnVkSFpaVkl1aWJac21ibll4K3FtNDNKK09WYmZr?=
 =?utf-8?B?ZWZNOVJGdzY2cS9XUWRValJ6QWR1dkliWFBsN0oxdldlR3lTSGRNV1ZDbGov?=
 =?utf-8?B?dU1nLytKZk5WTlVHUE53RGdwazFONlJHbmZwQVQzSHFrYUxKVll4Zjk2aUZO?=
 =?utf-8?B?ajVQemwrZWNrSDh6akkySUhYbmRoZGVjRjN5Y0g0M3h6SU1rR3ZhdHRmWWtP?=
 =?utf-8?B?Yy8yek5uZDFJOGVKVzRMOUJKUWpweGJyZ1JLbmNTVzkvbVY0RU5yZkZqY0lP?=
 =?utf-8?B?WWozYjdNcWpQN1dSMm5KbmZWWituTDlFU3F4QStYV3VUUXNCem9MZHZvMzJ0?=
 =?utf-8?B?dmtRRFRybTk2cVdPNnFVcXpsU1RJU0grRHpHaEhSdXBYb1pzQ3Eybkx3SVRT?=
 =?utf-8?B?dklCbW5aMkNlbVJrQVJ0djhQRG93ZXdsY1JEWW50dU5iLzlxZnNVYmlpR0pv?=
 =?utf-8?B?TWtvQUlPdTQ1S1RLMTNlZ0xnNFh0eDVINk9TQWFZTXVmUHJxSU15VUdxaEVK?=
 =?utf-8?B?MWxzdkZxZUw4d3FXenpNRnhVUUpJMVVTQ0ROeHZQMEJRVUczNUNxMnB2aTh5?=
 =?utf-8?B?aEcyRWtsclBEMERKNEUvSGFMV2FWR2hZWkpQWkxwd1VQbktnRDVLMTdWNHYw?=
 =?utf-8?B?MlFaQk9EQ1h2WjlrTHlNMDFPM09GWXhhTkRuSjltaEt3MnJWTnljSUlBWkYv?=
 =?utf-8?B?MUVrM0kwYTQwQmY5OFBTbWh2N0pCUi9pdVhDdDlpUDVtYVdFZm15VDJKU2Jp?=
 =?utf-8?B?R2Q3QlZtU2NReXhXaHo0OXllaW5LOE5HM3FsNlAvQm9QMzlBTGFZdEduVG14?=
 =?utf-8?B?U1E3cy9sRVRvYXEzTEZ1ajJBaVJyV3ZkR0U1amtWWlRCalZmalgzRHQxd1Rk?=
 =?utf-8?B?dUlkSVgvTkhzcjZBa3JscjJwSTFJS0twODlpYVV3WWFwRWxwM1FobkFIYkRa?=
 =?utf-8?B?U1lPVGRLOHdwQmNFSzlqUFFrSysrYld5Umx2OWl0Q1VOQzYvOWwzY0RBVy9J?=
 =?utf-8?B?VWRuVXFEdjFxLzhRYzViVWkrWnh4cjNJWExpcVhmbWl5MDBKVFBLU3R5UE1S?=
 =?utf-8?B?dFJIejVYanUvT3liRG9VY3IxdTlRRlFvbTRRWFVSTXo1SjVHS1NISDZEeVhO?=
 =?utf-8?B?c3Q1KzdaMktWQSs2Y3F0WkltZTUrdnV1SmgyUXFrRWNDZFlUTHFrVlU1SmIz?=
 =?utf-8?Q?XQ8d8tv2bcR6IhBwf05Lidg4m3f/v0ro?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3122999012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2NSREFGOFQ4eFk3eStSbE94WlMyZXp4R3dZNW9nT2xURXhiUHJXOHRJdmdy?=
 =?utf-8?B?UjBDdUxsTGxZR0tmd0txNnRpQnZFd1BxUG9BOEhFajBmbE5mU0JGYTlwWVNO?=
 =?utf-8?B?aVRHT2VUVG5LZGNiWDV4cFhMSGhHVXJvUFZFRjhTMjZ3ajV1TFJFcysvZFVX?=
 =?utf-8?B?eHdNUHVwZkJ2S2lKWWc1d0lnOEpMRE16T04vZ2VTbnBNbWhoOUdpRjFSTUpH?=
 =?utf-8?B?OVFVc3ZTTEYrL29XM3MwMXJiWG1aNHlSQ1RZaDBJRjkrUk5aR1dyWTdLdkJy?=
 =?utf-8?B?cUYrOU1kbmZXMUFkSk5UNVFiS2Q0azQzME0vMUdNUnVweUptZzhFMjVnQVdi?=
 =?utf-8?B?N1ByUXVPK2FSekZVbUxxOVg5UmhabUJXTFExTS9XalhmcmxDazA5MWczZ1dD?=
 =?utf-8?B?ZjJWTmxkaHRHbFpnaTBPVUhsUkhvT3JJam1TQXBLMzk0SUVpVG5GSVY3Sm5I?=
 =?utf-8?B?NkQxWEhvS1BiQnRwdVVUdXM2OUs3NkV5UHd1NTJ1OXZJYmp2M3AxWUNqMmlt?=
 =?utf-8?B?eG9yR2xLR2ZwdHd1NGtlWlphMnVNNGVIUjdQT1p4WE4vaU10WlgrOEUwVkFT?=
 =?utf-8?B?eXhMZW5ibWRPOUdWNzEvNFpmM1FCc3h0bGFOUTZobmFlc3YrcVN5NllBSHkx?=
 =?utf-8?B?eG45bHNxU3RaeXdzdzcwR0Jyb2VtVVYzQW12QSt5bWNSVDNncWlDUVdYK09j?=
 =?utf-8?B?MWtkeWo0blZEZVZXTmJHUm02SWcwSkx2TWdta21rRmZSTXd3KzdRUGxGZlFi?=
 =?utf-8?B?V05lck9NZU94dTJ3RlEwNEpzMWM1TG1aeGQ1Ymk1bG9EUVdBT2xCVG1rR2da?=
 =?utf-8?B?OXpoZTVPa2tBSkJVYnh3eFdYbWtURDRSSnBtZnRyZVB0RmljMlVhaUlXMTFu?=
 =?utf-8?B?T21qNDJaUjZ6UUt0S0FuRHRGMXkydlUzNmsxWHIrMjkxNnhpRDU5RlFCNzRp?=
 =?utf-8?B?cnZab25qQXdQRmdLME94ak5XU0lDSjhyTVNJWDk1TGtaYzJZb1ZteG9JU1Bk?=
 =?utf-8?B?UiswWGdaeHdhVDc2ZmdLdlA4bWU0RDZPRkpkQUREV01GU01ZbFlQWmlGUm1n?=
 =?utf-8?B?Y1NVUi9heG5qMmFkNzVLajQzY1RBTStvb0xzaW9VbnRwMzdXSlFyTjJ3OStH?=
 =?utf-8?B?NmlYS1pMS0hEb2piMTlFV0VpbWhncWcraGV6WERacTNkYlpXNXZTeThHcDBT?=
 =?utf-8?B?ZkduK3lRYVNWdjZTTWZYYWVWZ3AvWTBTQk8xZURFSmtxZXpONFdQSmlVbUxY?=
 =?utf-8?B?K2JwV0NUdTl4S2s0QXBETUtIcU1uVlhPQkRQM2Z1MVdOM0k5K3Rja2hsWVh4?=
 =?utf-8?B?R293UjgyK3BPdEJ0KzFRRGZPMDlXQkpueFVkcDhJb2ZNbk9QZnRDMDNnR2FT?=
 =?utf-8?B?eG12aFJ1UEdZVDZvRFdkeENRVG5GT05vc3dCT0p1ZGZFTEYwNjNCWnlGcnVm?=
 =?utf-8?B?REh5czlBK05ac2M0SFFvYjhjV1hnN3lZK1FsTUhIbEk4K1U3YXBuNzFsMzhl?=
 =?utf-8?B?ZHFVVi93ZG1Bclpqc3MvVEZDNFRsUmVEb1lodlY1bktVSW9DaTNNbng2WUE0?=
 =?utf-8?B?NGFnUmtJRG9JRWhmcSszaHNacWVmcGh5WXNKTW82OURBd2xwY3czMGRZNG1a?=
 =?utf-8?B?TDJENXUxRjJCL20wT0N5WjBTSXk1RytyaTJNRXVMdndOOHlER3liL3Y3V1Vq?=
 =?utf-8?B?K1crR256dmliaUFLblpCRnhpNDF2MWxxRWs4aG85UW9ETXJta2RJSFphT29u?=
 =?utf-8?B?QU1zbEVhb3EwQlY1QlRkRTF1ZWl6RjdDUVVaLzZkZER5N1ZyK3luWjlGbDlT?=
 =?utf-8?B?R29Vd0JoUE1La0FMaGYyMnBGa1VJeU9DcEJXU1ZTcWRxZzZFOHdVeFJyRjB5?=
 =?utf-8?B?N1FiUGZPYnpkVjJGSjRFcXVtVzlreE1reTNKZ09ZblM5d1FheDBhZkMyMSt1?=
 =?utf-8?B?UXFRbmVDSFVaY0xtU3BUeGR6d1RCby9CL1ZRR2plbmczblEyNFRTQVBJQ0Jv?=
 =?utf-8?B?d0dEWTJmLyswMGd0cEc4UmcxaDZycWd5K251OVp3NnRQd1M0aXMzQ3JKM1pM?=
 =?utf-8?B?TGdwVjFrQzllMitScm81OUFBaDRKQ2hGNlZaNjhJNGgvSllHeHFMMG5xSGs0?=
 =?utf-8?Q?yXCYCilKQnfZAyMHBtLAYd91k?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57575a03-c6de-4774-ab2e-08de34a18243
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 08:29:01.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl+ZFsz6jfUD1aRNP7k4NiSy+PqoQiodW8LxE9KOmpuTpWJ3LuTZEkmK3BDArlgJofMyeJ02XncDFAU5iUHI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7264
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 06 Dec 2025 08:29:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20954

On 02.12.25 15:21, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 01 December 2025 08:32
>>
>> Hi all,
>>
>> while fixing our pipelines for trixie testing, I was also studying once
>> more what all we are building right now and what we are deploying. Some
>> questions arose from that:
>>
>> First, I would propose to reducing what we deploy to S3 to only what we
>> also test in the CI pipeline of isar-cip-core - or are there more use
>> cases outside of that? Then let me know, and will keep them while
>> switching from opt-out to opt-in deployment [1].
>>
>> We once had deployment to kernelci as well. We disabled it after some
>> API changes there [2] and didn't re-enabled it so far. Did the situation
>> change by now, and would it make sense to look into that again?
> 
> Currently we're testing the kernel with the KernelCI generated rootfs.
> This makes things a little easier as they will sort out any test dependencies.
> 
> We can switch to using cip-core if it brings benefit, but if cip-core is being tested independently already, maybe we don't need it for kernel testing?
> 
>>
>> Finally, we are building those kernelci images and also test images for
>> hardware and no-kernel qemu images for our own lava lab, right? Do we
> 
> TBH I'm not sure what the no-kernel images are being used for.
> 

Nobuhiro, you introduced that mode and you likely have a use case for it.

>> need them all in the pipeline [3]? If we can't consolidate extension
>> variants, do we need to build them for all archs? I'm just looking for
>> ways to reduce our test matrix where possible. It's growing
>> automatically, shrinking it again is the tricky thing :).
> 
> Please feel free to remove the kernelci images. 
> 

Does everyone agree?

There is quite some infrastructure behind the kernelci in isar-cip-core,
from customizations over image build to (disabled) deployment. If we no
longer have a use case for that and won't have it again, I would remove
all of that.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

