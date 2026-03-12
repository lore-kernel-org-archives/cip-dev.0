Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66804FED2D1
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 06:41:16 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15764.1773297673427113814
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 23:41:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Vh2m5IA2;
 spf=pass (domain: siemens.com, ip: 52.101.65.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le5jMnMSt6DHsEiEwPMEKYLAC+PkzWPR84EMQV52HphwQix/Q4tJWmbQZqpTjaIBqSq10BMv1Ka/XK2lGpCjNzvIct2m5JhRqBGTy5Md3jisuLZC3wj11GzEODtOj3KCPCVg0Dx9hP8CCU8LFMIKafcn8R9LyN4NV/rStKL6ThLKOhkHxZPK4UtSi4OsjPE+7ZoVbzlRd5n/Srezt36/4qf7/l9ffALBcKTkHn1Fvo+F4tuGCHR/ziqbkulqWXYHHtOoQLYLe7cLEZz3rajPyiBna8MVI3GJQoy5rYzfXYbP6Mb03dU/kNv8X9AK8HWZi0eYVzDwwQNLhFlRpL1xRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH1K0WUZhwecAyLBz3p9zD+xRYMNIOrMujHQb2U92lc=;
 b=VaxQfNd5NlDF2kuYndojQnpDS0Nh3bTzJh4okl6JGc1nTnqG8MvYzEmoyvCKEgWlNsx2APELjUMpaAM6CQY+All3FwlHsO+VZ2lskoJOGFVZ8m1Zp5y0H4wPw9J2Go8Pls0RBWBTpNofq4TEY4ALuixnOhfG6zeInYHbe0Drvvdz/VvYsXwX7AFMAJkOGbfLRqH77vxRcYmG0gxL1fPERdmNSilQjzFhtLCPiiDnDIsnu58nIiUMLvRwN6+04Lxm7+eGs9hjTGLCoFheiW0YujEHfX4Yjl8MXojYpj0Ub/TWdtVxo2IejdnpsMAURc8SZ6XPW49QtXgdB84nWVtNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH1K0WUZhwecAyLBz3p9zD+xRYMNIOrMujHQb2U92lc=;
 b=Vh2m5IA204L8UL/ZyziRExCC4mL3PuHBKdcnn0Sgz/T9TJx9zRGshu8W++flrOUJBykpDPkwZXppOU/EleYOLhHwAatwQsvb4b2bQ5wBfaO7zgAxAYSeibGnC8CWMjrcqF7g57/TrRy63wb6WqVjc0f+ie0W4ntO74R3Zp6jYJKvKzU6f45UNofl8fGc/poH4KhtfIHgxvIm3MzYlr2sc8BF02pU1mUQ7GJg5I4NuxRfLRn6TAiO+ngpdq6NrP1gvSu5AB36z6+uDEwy7I22wgZjcGlI05kLvu52b5f0suOXda2szCKn9NRrWxpd9W1ulqNbbAdPyYNI/g7efP6W7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 06:41:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 06:41:09 +0000
Message-ID: <3e155038-b93d-4056-ad8c-052329da1ed0@siemens.com>
Date: Thu, 12 Mar 2026 07:41:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v6.12.76-cip18
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
CC: pavel@nabladev.com, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
 chris.paterson2@renesas.com
References: <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <f54ffe73-aafc-46ec-8f0a-a2c14f41b471@siemens.com>
 <TY7PR01MB14818DD62ED8DD7D484BD232CCD47A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB14818DD62ED8DD7D484BD232CCD47A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 242d5991-69eb-4ab6-8062-08de80025856
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|14052099004|7053199007|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	82cK7YqiDzIQp6BbaEkyA7rzdjYRxjK1upC8gMCveWGZsEoiQX+JAenwqTKGtyEc2/5mgtJ7gm2GhQfXvVh7FihZ4ikZD3rDeF3hsZoaCSggGo591DUqWtc+RRL7PCBTLWBrBUDVT9v9zG9//F+9PyNBIE+OQ1KYT55jDla+jOAXEoOyoCCW+pBA/LgvxgT7Me1byCXCq0ImROl1OItG48yjHnk0ztRC4x4y3h0I1xMGji2BIKV9OrQRrx0cOvMnfGkayi5NbFYOG/0BEN7Y79bQO+iQtXGSqIjOgcrqiIp73w4PLNRbcfpm/l2VfCTw7U1tug/S3lt+3uH87s7syEjwmbp5mHIJjW3iAxKaZKo+y+FGskbJapZmeSxchGAK04y0CUqE/bZN26sNe8sNEhGcDRjvO2C3DRnPL1fYSamoD9RtwBEoU5QCyXDtYOf/eGPRsRRjkNkuqGq7ifupX+6hdK16eTKPkNMMDlzELk40QeICa1LLuBkg043ZI1hHqkVjJmTJLaQZdA6mbBUCu02unrkvMHs7OK9FMKtQpizqqut62PcsbZf2evNC5YMnrD19FGV0iLUUdceUwjdB6FwcwpPIQnF50ElY6oFJ0HVlIRSPAXNAwnMG/5HxI8wqh4CYLWAW/LVTmLHh+roCefadu9p3tUvKA6nLHA7hLUWCcR6+UESPehN12a2wPlRr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(14052099004)(7053199007)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S39zSAOn+OyoUUwHMIq1NzGCdIwgR0zgUYAYAhxU3lKVLL0nBO3+A2O3zm7C?=
 =?us-ascii?Q?ANsv9RLmr3WCtSY3IXEDeycq0Rr8n4ZR7rp2gGBoONqIi1FCJu4blQGsYNAp?=
 =?us-ascii?Q?i+KEcha4i0sN6uzckdUKVatfnLzW19yOxvYXKRAvFuuC8XIy5kM2Fe9QQnw6?=
 =?us-ascii?Q?5CeeCcCFgB0pQ408F3uTvytyaOTBCWZSNDdnrohXBlowWXVYyh83PeoCxW2N?=
 =?us-ascii?Q?cb+LBiPuyDlV6CpfFiVXFcLnNt4AXjG8ocp+yuilCqkun+EdjHjfYyXSEcgM?=
 =?us-ascii?Q?ajGSjl4d7fdSluf93Ygr247mMc+TuNBPV55PaubGMHpwnc437aEM0cFYLFo7?=
 =?us-ascii?Q?dAQ5e0F/EJIkWBYEyOwn3n6xcTxYoy93v4asKSRdJQjum/1TG+S4Gqb+uGwK?=
 =?us-ascii?Q?aKyUB5EgIol0kS70q4fWpWznniCYud2vCFilvXed2DCL6HkTMjDgi9sfzeq5?=
 =?us-ascii?Q?Ml1L1leCjuZQFv7IsMoHJiSeHSGOdA834V0QiL2SU4ok9hU9/RCMoUT/09d2?=
 =?us-ascii?Q?jTrKFixFe16e83rpCziPmZTCLLrVCs82lsQVUkLgDNXuGsrmkJs9m/yRufkM?=
 =?us-ascii?Q?RpbgNv6hp8TyL4Qb+6icGdYVXGr4uDyahZNbv2yz9Yg9TRMHCljwpEtTnEIw?=
 =?us-ascii?Q?VuQqCrOfyMCm8RY2GblgSpEHK7VDEJRKv9n5U16TbAc9gWXCDOmB7AQUF3j1?=
 =?us-ascii?Q?uNoW2fh8QVF4hv35TZQlPMb+I6wadlYqSPGKMfeGxyu5AnTyleKqGRMtq568?=
 =?us-ascii?Q?Bpm0ziEWk+JBIn8Rk3siZkKkqq9WfAb9r+ATiEaCgusUF6YKdDnGxdrUUqcP?=
 =?us-ascii?Q?bTGwP1rN6vcmhGaQHphvPaBdu6ItyQ/rBbIl0fRPc92PNc+H3TTPtzdXzdfC?=
 =?us-ascii?Q?RqNAnXRquNqRwE7zOa0kI5MiGTXTjL+Wk2Ln7HaHVWglM6u6uMwjx9FyVMd0?=
 =?us-ascii?Q?WYMdYTQlNbS9J0dntGQhk8MqyYcaAX+43ivggUZ2gyewh3XbtXCKNj786zXB?=
 =?us-ascii?Q?JTZONQKyZa+hIUIGGdrBwwq9UeGdhpeiaA6PuyatRp1rT6w8lqe8aO/JEgOt?=
 =?us-ascii?Q?w2XkQ/2NXuL8e5JeIPyemQ56+VYd+fNcZvz+54lAxKtbaacHURTpI7tPUXZF?=
 =?us-ascii?Q?c7yMCsK/YwYXO3g2fTqMb7OD0oKYUSa269B3hheC9LlyoepMhGhHVlJzTluu?=
 =?us-ascii?Q?PuLGj40Qiuo52T7g62gv0oQXvjUwxGsxPqS2xPx/pwVCxcZJsSupx4s4pjmb?=
 =?us-ascii?Q?EPZUsEnyBOXuG1+La80wmbf2H/1Gdlvtor0/i0k71RnudPb4lc2doMALAScc?=
 =?us-ascii?Q?/Lx9WE9ISsRyZKy88yNv7MNQ5y5lFm7KzJHzYXCpMwY+q412GG0i7+a4WnW3?=
 =?us-ascii?Q?sShq+4Ju0b/g+4CR3MJQDRnozOU6kQMoaPNcDg9xgALuRf+ibJU1J+whETpY?=
 =?us-ascii?Q?rs83ndEsieqJctYoRVOZqz+Ry9ffmNnMMAMp5Vp831g5SHbv3ZBfd3fF0kzi?=
 =?us-ascii?Q?MSFzJHiSksIuLR8amfhNv+HFkY7piMciQmD5VpiJbMg4/3Lw/rh++6p37FSZ?=
 =?us-ascii?Q?Sgop9lUD+OeebSZco0EenR9CltpjweEf7sy4cZxAqDcCaiYCToWalYx5AKxL?=
 =?us-ascii?Q?0pqLZRFSQU4mEoYl3qL0L4e9fSaHqL4lSFU4OEQlQgS9i66J52w1MNdLXEHi?=
 =?us-ascii?Q?F6MmtkYM3bzEMny9zGNr6E0KgaVfp1H+EsKtL6Kr6Dn44/BqZS27pyNkbcUQ?=
 =?us-ascii?Q?p0zc9qqbRw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242d5991-69eb-4ab6-8062-08de80025856
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:41:09.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3ikzM3MyMpW55XzozoK2FwPN49/iAA7nEhVOe/n7C5uberGco0V6Ef19dQqzF+I3GwZ6v/gUsWZBlQDq9R1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9768
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 06:41:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22354

On 11.03.26 06:01, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi Jan,
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, March 10, 2026 10:26 PM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <nob=
uhiro.iwamatsu.x90@mail.toshiba>;
>> cip-dev@lists.cip-project.org
>> Cc: pavel@nabladev.com; uli@fpond.eu; masami.ichikawa@cybertrust.co.jp; =
chris.paterson2@renesas.com
>> Subject: Re: [ANNOUNCE] Release v6.12.76-cip18
>>
>> On 09.03.26 10:05, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
>>> Hi all,
>>>
>>> CIP kernel team has released Linux kernel v6.12.76-cip18.
>>> The linux-6.12.y-cip tree has been updated base version from v6.12.69 t=
o v6.12.76.
>>> This release includes updates for the Renesas ARM64 SoC RZ V2H.
>>>
>>> Information about this release is as follows:
>>>
>>>   v6.12.76-cip18:
>>>     repository:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>>
>> We seem to face another delay in cdn updates:
>>
>> https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.12/ - no cip18 ye=
t. This is unfortunate for our cip-core recipes
>> that prefer to consume faster-to-download tarballs over git.
>>
>> Can we clarify where these delays come from?
>=20
> Sorry, this was a problem with my environment.
> GPG signing had not been completed.
> I ran the release process again, so the release archive has been created.
>   https://www.kernel.org/pub/linux/kernel/projects/cip/6.12/linux-cip-6.1=
2.76-cip18.tar.gz
>=20

Thanks for clarifying/fixing!

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

