Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B693D116E2
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 08:14:18 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16669.1764576854644042246
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 00:14:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ELebCNRM;
 spf=pass (domain: siemens.com, ip: 52.101.69.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyVzNhYyF4za7Ahlp4Mi+gCtlCq6PjbEe/Nu8VEoq9snFew/R46fL0gwOUUgsmhuWTCwbRzZkPUzv/T2gRu88ALA3q4C9msiDYQrFwv3zYSd6PcvPI+OXmfxEvPPf0MvwUPNF26LSVZHyh/M2+/DHDzzanWRJpJwD6XUCIw5YyBQeptBRKZ6iJHkK+Fa3EVeeEyIIwPK7MYnAPT4wvoNOK+7fXAOLv1GJ+WWoLdOM+XSjTBicK4jC5aS6Chq870lzrAHlHvR/6DCzKWgq3WsfTicsw1l/2w6y62E8ZfS+ysJ6yHEBaItCRYuv/hGZlYfji3zlRnCeo7q3vMBoq3ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjnV4gZaXeVy2FBOg2zrD+bAMeLtZQEBMLliSFHVGsQ=;
 b=DMwCnSEjCtx5LIw3lwQvEM1t64BGVm5N+Zl0sjBiHj95CT+UFyI5Mku8AGWNLK1gRpMAhWK8DTh+JOmJ5cXKycfT9HxCWHWSExNvuI9p3D6ejw7qWyIhOT8lgOZwRJ7dN32iAxL78GrEoVflA3x7EmM7vCGP2nlrsLG5/TlenIvIX0oGZ9KwhIWAQQsDO9olsAPAvumu32GUD/EnTJA+JLdmEtivHHsL8Gniwwdgz70byL8s3Lm3tEy+jzaPpfEqFJ9LNLZfRu9F+kqapUyWxCcXfHuvnMiyAecZETCmZb0wSygBkT8NiUYZTApyWqxo44ln5Ej5soXxjls/OTIiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjnV4gZaXeVy2FBOg2zrD+bAMeLtZQEBMLliSFHVGsQ=;
 b=ELebCNRMj/8zwa3wDd2ha9DK44SbaqVL/gAK8osUCjXRqn1JKILm/LtQhlQeXW4Z0njcbJEPrHJKbRbj2jbbAdydrgQTwk4liZN6W/PQki0N7vFti6oOne1Xg6drqlfnkoxD8m/gXS5+lBUMUyo5GDmUvcHqStsCgbqN3kMFMk5zfYgUtjyvyWz3sYO8s7NNSFg8ssm86PDEtH3xjYWD22Sp5LkbqVrgKRjNXYttS4a6FUffDbc+ImKtaq35ZA3l1d6gn8syA63DhmS6n7u9bUcAlPZcxb7ogbDqRDf8LyquF9Xf3fN8QEODT1v7Fm4/zxkVX67DsDXZdQwriNeDPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7245.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:14:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:14:10 +0000
Message-ID: <0aa25a1c-cf00-46cf-8570-93a2c42ecb88@siemens.com>
Date: Mon, 1 Dec 2025 09:14:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Enable KVM for x86 qemu lava devices
To: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
 Chris Paterson <Chris.Paterson2@renesas.com>, iwamatsu@gmail.com
CC: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
 <TYYPR01MB151324B0FFB58A3F654CA8041B7DAA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
 <CADPJy8XYCDEgxuSvWwOL3Kf3-P48nZbS672+sc=yq=w+sMcAOA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CADPJy8XYCDEgxuSvWwOL3Kf3-P48nZbS672+sc=yq=w+sMcAOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: f37a6eec-a147-41bb-4a2e-08de30b19b50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iwt84fxJMPoPhCCX9Yp9pxZA1t506WjKsicSRwtmab/aF3DC8fsmbPoxtNtC?=
 =?us-ascii?Q?l8T+Q4hbE8GwHEn++NwluchS2XzstfEQoDt4n7bpMYgNXLeczGkpiko/x9Lj?=
 =?us-ascii?Q?LD1x+255QlcnKFCjSSsZ8mpqriC4UHIhY6iEo4voapl2lqOBrilQ4WPcAetM?=
 =?us-ascii?Q?hYSHStLSA8Roe6x1hWn5zEEUhuj9hYgwt2ZKwNsPOY1IL7oU7ogRL9D3IEv1?=
 =?us-ascii?Q?ewI7kOtmvBbriYMGOjjKeE5WoB56UH4uVdQVOP3YrV5j3XsFksp0JrgXOiZ8?=
 =?us-ascii?Q?1umFCIWTUdLvo1Oway5OG/bH40bNHxMFRu9vpTXlx35tN8PwdyVJ7wMtHnYA?=
 =?us-ascii?Q?kebicHsr6WJre/oijH6y3PJ1DNNF7wbwysua3LR0aIgI+yjY5B1wsvFQp/SG?=
 =?us-ascii?Q?TdTm3vuIysWMwWrwPb4oMqyZm4k5ySdTSFaitZkgt3CaOAIcfNxtz5SREgVG?=
 =?us-ascii?Q?EBEKWYuf++gixKZ3zMGEw4o36UZ0fvDYENcchg8STrDlLBvejwo+VLNiGQrb?=
 =?us-ascii?Q?mFDD03Sf+Hgo8R+v9+g7J2nqP0RbMao2T1lQCSNdbJ07Uo3H9eGxv3xFBXEh?=
 =?us-ascii?Q?PEUAB0KEJDA3m4OL7qXIL9b/x8obNHwj/lGHw5LmDWhAlg7MoLqPP6m4ktIu?=
 =?us-ascii?Q?iNsf9oVDXh+eItZdJJ/vYn4oDAYPxWGnm1jjwRTKFxYFFj9/ivTXvcYPUF6m?=
 =?us-ascii?Q?vz0yxbUQS74b8JgoCpsnKtHUcw5Ien0nytX/C+TI+OoBweRfPI4i1PihoKMv?=
 =?us-ascii?Q?7F+YfUAd5A+8YmlkSSp+/mKNOX/L2CaO52SDNkUkDN9HGKrnmFQbFwdrymso?=
 =?us-ascii?Q?934dMAP9D2rDdRMl/hcIuWoJauqK6u+N6KNhx6r+g6BBWAn5wkxzyCUG227I?=
 =?us-ascii?Q?F5wZGuYBiox6pOK0Fxb8++CTSQzzRooeHHJIWGHtMEGFVoiQlr8FAe2STtkU?=
 =?us-ascii?Q?6jHQbYNtArgpROMgS9Jfx+2eZ2YItrP/sfJUrrKmQuGVIa2r7FmjqFgwn4tH?=
 =?us-ascii?Q?8vuRki40b0seQRg/TX5aO8iIwuZCdsVL2bxXFl6DM8wDOxW2ebezQHfSE131?=
 =?us-ascii?Q?O7ljvr9a1B3++ojrnhH/TuC5t69QIAu6t4q7H9qfAMup+gG2FehH6EJkCU16?=
 =?us-ascii?Q?o1uehSTKOLDimLUaA8CjWvnbb+v+YyvV87mvGumgpAFVSInM+kZz9kYugDP9?=
 =?us-ascii?Q?6BRb05++4YTLA1qidUE9ga8ohipJh/kKBOCzLmm2trFv2GdMV4uZX3q/zta7?=
 =?us-ascii?Q?BYl7q0UztRe5xembFRKI3FytD40HnA4hKQcckV9GBGcvH4b0oX2AlB8OUYvp?=
 =?us-ascii?Q?QBWm6YSKHgIyCxqXkux6OZfMLrY3CE3iaH7tY14PtkmEUXYcTzL+CRZr+sNM?=
 =?us-ascii?Q?Ik0+fa4RX6bRpak/l42i3pcyy2IZEIbbcEpuZy4DPnfTZzWfz4rTs9HBJVnd?=
 =?us-ascii?Q?7P9AeW5uqfOiDFyQuc6/jOsLvS2Jab/V?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rkfyG+T1Ard5+aE9jIfTmpthY37xuSVYmwrOW8sGupXfORIUJbUCnKaRktzU?=
 =?us-ascii?Q?25IP0ZsEEd39uSb6HF2OLnX4o2etRhMyAi5hwi9FHFVZ7uFCy7WneRfXJPkJ?=
 =?us-ascii?Q?666xx4Q2S5JWq+Lo3pxYUaD/0xDurZ2Ecbtq1E/NCiInF5tjkk74vCK3hYvs?=
 =?us-ascii?Q?Csa+Ir1NABnnHVWMOz6IR28MvGEUeI4kGBBqmIslECOOeO0Cgg08bQlzt/ZS?=
 =?us-ascii?Q?QCdhqmc5yMwPIefGErvkHs+XgXyNNNhMV91gBoDHn/j0FETGqwags2/f0i6o?=
 =?us-ascii?Q?+GjHwJOlXd1HAKRZy9OaggUj5jS8uTHXOwA3DBkdzYe2S4h7QaavQqlWFPVa?=
 =?us-ascii?Q?RiDgIVdJtwc5ATiu0M+ZfhQODKfBTk1TimZY9sOH9S3e9tx97q256/ukP3Iq?=
 =?us-ascii?Q?w61qzMVPOY24Ghgv9z3tTBzce4PejO3OkJp0LBtM1ma28zj4M3bx/OxLfO3V?=
 =?us-ascii?Q?UdVcZZZnHPtexmtko4PqqM9t2DSzYd0oWqXefwONZSzqEosM9Lm8zF7i5dKs?=
 =?us-ascii?Q?06msECAq+zaE31aDbstSMr8ZgvnX/79PA4wqTGsZ9xWYXkOMwc3EGUIW0YvB?=
 =?us-ascii?Q?3y5hP6aGIoEi+dAEjv66FEws6ld7jViTO//Z7cSMHIatpU2Ae3/YvKsN7Mg0?=
 =?us-ascii?Q?lR/EYxd7Cd/wUbCncWsQeM5u6p35mYOHWkKky8IvSK9Dqi65a5llibrNUzUr?=
 =?us-ascii?Q?8jU/WXtErh1rRVOJ+7ff2FX0XKvvyXU4CdxFR3OjgzTYLbrocMsoRAAqchGN?=
 =?us-ascii?Q?lV+gw5s8F3Nf++eP40bbB1L6v4X7arr8MvYKnZPgIIQFg9FJhEs1eiR8rdW9?=
 =?us-ascii?Q?4px6l8Ma9BzqDJlKju+Vx9tycGNLflOT86Pl3feGkVlq9+BWp7Ohu33re0Kb?=
 =?us-ascii?Q?TgMxmk6nrmMim0mTYvRXD+d4c980+9UrHU9MDbJlaMRQChROjAaXUAnS2ghV?=
 =?us-ascii?Q?+Yw0a0lKOUBm7xRE0wEnw8k7q4HBn12Z5e2zgrTO9wWry1b7O1rmLQM2KtC+?=
 =?us-ascii?Q?iYRZ/cY+JzqLgYS0BxVcHaLaCBAxYaMyS3XkHJRF88jYNYQI999toY9/JJcb?=
 =?us-ascii?Q?Uwz/kg/n9aCCs2MHwlCJv1ejjq++WXw79OBPIW8pkbHM9c+foS1VfTlBX27F?=
 =?us-ascii?Q?n8f8dpabGQS1VAtitoExKHloUJf0eJE/9ShUr/JxxRNkr4q71Mf/dSzbUL7X?=
 =?us-ascii?Q?fu4CiBJZTbb3RNdd+C5v7tf7K87FXCHr8duuxbZrpGJJ9PpcBf2tifzeX02g?=
 =?us-ascii?Q?TH5rb6bUEjAHUInfSew1Cj04cne8RCgriwDdNPw9UClw7uF5nqM3+I1jRuob?=
 =?us-ascii?Q?xLGs5Z6EqloNbJvZIVbIQYfkfTVvmqNTUxM7YqY3kmQsSyd4SkqRoLmQeyu8?=
 =?us-ascii?Q?aHMI234u0P/H4au0zUUX2yBu/I8kJagFSmSYM2DhsrQwOC1jozddGlldSu7p?=
 =?us-ascii?Q?j+kKgD7kAyCt+rOecU1r61gqsGolUVFCb5vTf5BUWSzHUCotpYVYtz/rwsIp?=
 =?us-ascii?Q?VGjx4A0+6yA0vUgI/6QXFO1AeH90J2A+isPUQDgu/eIFXUlUErFIF85cLOjo?=
 =?us-ascii?Q?Im+MczupC5M/pUftynmtJjHMKAlFfzVv56Bani5d?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37a6eec-a147-41bb-4a2e-08de30b19b50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:14:10.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9Ssj7WzBkUQMcOekFyBCN2rllCqL7hD+4ctCCaJlxOikNXhCQxt/5Osioe1vewL3XTghIvs1lOLPSKNNcbDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 08:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20778

Thanks all! I'm currently running another tcg-based pipeline, but then I
will switch to kvm.

Jan

On 01.12.25 08:47, Hiraku Toyooka wrote:
> Hello all,
>=20
> I have enabled KVM for lab-cip-cybertrust.
>=20
> Best regards,
> Hiraku Toyooka
>=20
> On Sun, Nov 30, 2025 at 9:21=E2=80=AFPM Chris Paterson
> <Chris.Paterson2@renesas.com> wrote:
>>
>> Hello Jan, all,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 28 November 2025 10:19
>>>
>>> Hi all,
>>>
>>> it's almost embarrassing, but we are still struggling to get our CI
>>> running with trixie images. Another blocker was identified today, and
>>> that is insufficient CPU features when running with TCG(!) qemu machine=
s
>>> for x86 in LAVA. I played with lifting TCG features levels up, but
>>> didn't find a matching CPU model yet, and that might also be because of
>>> missing qemu support in general.
>>>
>>> Both from the feature perspective (forky will raise the arch level e.g.=
)
>>> and the parity with local execution (start-qemu.sh), we should really
>>> switch to KVM devices only (for x86).
>>>
>>> Quirin identified that the following labs still have KVM off:
>>>
>>> - https://lava.ciplatform.org/scheduler/worker/lab-cip-cybertrust
>>> - https://lava.ciplatform.org/scheduler/worker/lab-patersonc
>>> - https://lava.ciplatform.org/scheduler/worker/lab-cip-renesas
>>
>> I've now enabled KVM for lab-patersonc and lab-cip-renesas.
>>
>> @Hiraku Toyooka, please could you do the same for lab-cip-cybertrust?
>>
>> Kind regards, Chris
>>
>>
>>>
>>> Can we change this?
>>>
>>> Thanks,
>>> Jan
>>>
>>> PS: This one is currently under test and consequently fails depending o=
n
>>> the device:
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>>> /commit/321c401d1de763ab9b7c7afb0c13d26f0a70b7c5
>>>
>>> --
>>> Siemens AG, Foundational Technologies
>>> Linux Expert Center
>>
>=20
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

