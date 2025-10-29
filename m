Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA0CCF9EB
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 09:44:26 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.8])
 by mx.groups.io with SMTP id smtpd.web01.3079.1761731057314235158
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 02:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Mer4rQem;
 spf=pass (domain: siemens.com, ip: 52.101.69.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT+5Cw7BCrCaIuc8c8C17LejCRK55lk8efDLt7BycQ9XOX1onQhUzevSV9Fz0Fk18zR8HXtJ65y7wE9hHSp222+GmbfJfwtvVQW6PIoqx+p121Giib5FwEPkL2XuVT6ThKIj19Pgc+1EiXtGeRTPU+gFd0dy93pWQ3+eRRJ4TBVspoYC+i1DHdnrmtRSjxeul8mgflC0ByHhzT3HDkTSXsIYbk8FnGTNw8oGjfyTRl+JYZqEhWly9Rlj1esQodtJa4o9NK2CsACueOcmpfMO/x+nuVsS1CF7BGX9CjGRPMdTz0v6YT1WIZ4hioyzrKKzjpckSLFdG5mLqXVVgzSPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e20UdCxuoGTYAiGWgS3tksnraDJ8fjVgSvW8GOUVoi8=;
 b=OmUMIBmN0JAjzi66x93pYGIYgsQRN+3Gz4Z/o0S8TbEGrTJOgKu8XKOtKZ8efJGrRoM1u+s8e2eL7Mywv5+WcSVjiTybftPOIbffdwJsYU0hICdjY6IcgXIRvtOcfn33tAJMjlg9nHF4emQxCaT/e+hXvpvr+K2jU2eOLlgreCgHqodcawZsdXNzwRnHaDSGYVsdagxhHSlsNqqnca6tLYcaVe7FqUVutO8G0uvez0KPW1M0bFRI8/1Kv74iZoeC4sjdqZ3YcC5xEVVYmBxm+sB4hRKRMLIXmf9R+tIoiWIvfsAnK+OhPTSccD38IJgh1qYXm1Dj246j/ksEYm8vWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e20UdCxuoGTYAiGWgS3tksnraDJ8fjVgSvW8GOUVoi8=;
 b=Mer4rQem+oBJ/YquNGBhafH4ZDkIxSxswwfyvDXtb2cpqEahDuNiFmHDNUAt7Wf5PxciZ+X4ujONl6sPSJnsH36Lu0wj67dNEE01aRrpN7GC9DxlTPsVubhysQrDeXjZKYJ9xtJtAqGOk2WVl3wTRwKKFfYFh4Nhoa3G4Bub+oMZgWxtC4mlhiRC5zd/pOEj1VHBdA4Qts3pf5ZIdqZelqGe2xTdlrS8TtBYqe69C0fgVl0UvOhCT0K4hYn2uHD6qzuFvL3OBAVitotboB8ftjM0FgiR4d1/IVDo14FNn+i5FybFro9aSciDiP1X/Thtpo3zT+9UDoVgDUxcj2zwgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:44:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:44:13 +0000
Message-ID: <4cb2fe94-589c-47c2-92af-ed694cdecf7e@siemens.com>
Date: Wed, 29 Oct 2025 10:44:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: Shifting defaults to trixie?
To: dinesh.kumar@toshiba-tsip.com
CC: cip-dev@lists.cip-project.org, hirotaka.motai@miraclelinux.com,
 kazuhiro.hayashi.f74@mail.toshiba, pasquale.nieddu@siemens.com
References: <87286d13-6e1e-4cbb-ab14-a8af38037b8a@siemens.com>
 <OSZPR01MB8515ECCFEF6C63E9F77F7998BFFAA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB8515ECCFEF6C63E9F77F7998BFFAA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4024:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1ac9d5-301f-4af4-2ee1-08de16cfb80b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PlELvmSlMHg6WJqPAnw6Bg37w//pTCskByABSYualfkuX+eNTTfu640B4fpm?=
 =?us-ascii?Q?uodvRjY+dZ7hFq5xB3/8h5/SUA/QcThrsrvZNe7rGKksfEIVp/IpzuFxdQ7L?=
 =?us-ascii?Q?hZQ3B3cMy8s685ipVL2jIUBfhM+fgzGgpmzFckv/7ti0Ia1IqnXlqt9g+Pe8?=
 =?us-ascii?Q?xnvzc0d2kWuCAInDW2W8TKof8pb0r+8V+lOoN47eiZVGz7qIYOWUow2/LDKk?=
 =?us-ascii?Q?y2/I0+y9Sm5Lyi6y52T38v6Y/3lOhhqWFADmrNTPowA7f4o0INAOG6QCxMcd?=
 =?us-ascii?Q?7LWkxUIZNQP7HcvoJmPAXDh7lDj1/6LqG6s6A41KBsWgzW+1wyZp282FTBKY?=
 =?us-ascii?Q?LUHu0WrxZ8yiQjrbw2u5B7KKRBoOfBfVVZrj3V4m4mUnrwnIK3GpqfD6biSx?=
 =?us-ascii?Q?Qx2JZj83TVrUSJTScf1Re+ZSPAbfx9IyyrtPAOxPx2Gd8BXzh3ovIdX8i9Rc?=
 =?us-ascii?Q?0CnIY9+OqrJeCkY8e0UDo8QgR0QWqJr2WnfFYfhydt7xKn3KzBLotIt4knxZ?=
 =?us-ascii?Q?ICPJQYU53u811BiLv2VgNsxL2H6n1E5uQhcizC4ikKX1mXgsAUxWDLdIVv/D?=
 =?us-ascii?Q?XjZxbZMx4KiPTPA/D/HFksvUysyU5rxN+w94TyPFWmsu0Cr3apCchEy8ReKr?=
 =?us-ascii?Q?wJ7MQr0ITmvzhrECqsjSxk424nHnYMAFyiRFkKGKsotwHyLWyT15boICeUXP?=
 =?us-ascii?Q?JqWoox9GHLBq8LOSsdQpY3diuiegaBaKOMpbTXYT/A5A+BibF4IEQLmug9r5?=
 =?us-ascii?Q?wNILDYzoZsuj7yTr6nxEU7WJXzwZugVNlxOMzM4b0SeUF7O2qjWat/y0hrEs?=
 =?us-ascii?Q?3+yFeQXgZDwPhc/VTDXFRm1UDE6zUyoFcEbj9s19/HQ88eRff5wdcWMvx978?=
 =?us-ascii?Q?i5z4Wmy9r0NDyRjWXZxkLyHDVHyQ1ro3ZvgMLEXenDxaec5IH6zUbEMdDpzw?=
 =?us-ascii?Q?xvbikhj56eBH67CTMw6QM0rSaIRBCjkZkJXe3eEEOXC1HvqiXHF+jJonT/LH?=
 =?us-ascii?Q?Sx5PedKv3t+r0eBi6kpZVIvz0K3YP1fLLPFN8r5DhpdTpSoj0WeABvaQ0kYr?=
 =?us-ascii?Q?KvLfsCW8/Oohyw6vfhCsrjwknlCjMQyyO7gX/8u6TqSjCw10SNouyGGa9Hhv?=
 =?us-ascii?Q?rSO5A2SG0o8Tq3bTBMbPS5LqphawADOebNwmJiSPY7ccWAhJyXERHPmsEsuD?=
 =?us-ascii?Q?lISkXIjZuE5ShPYKx/WqmAvYmvXbshcBIiWzIi8vBtFqT0bvrywcJs/9gt1e?=
 =?us-ascii?Q?fPxn+HDdVk43GE7bw7+Kjcr0iyzMH8+xhJXDVOHnUNjkOeY++kWVnwIi2Ydn?=
 =?us-ascii?Q?ccpVk+Kq5mpIpIwSybMCcmpKrmx2zDUks2YbiR0aULL1gdAPuA7/yra3ooHW?=
 =?us-ascii?Q?PpoGXRL590i8Q1FPQS7mabgwP695c9BMoxKByk7sfyEbCAXNOcXKFgvbAU70?=
 =?us-ascii?Q?31VlPjNISNm0kaV9PWOO8oSj3Qhy3WMe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cz4xQUZp7LRhnl9EUqPbLH8W9Fk1zYWWKQAchXH5UWoKtdMVbPXlYhKLk99f?=
 =?us-ascii?Q?/+8Kjod854+m1EUNj5hoBewCgwPR5subfteMDAM6y4HaPM6BUk/inAWkqSUD?=
 =?us-ascii?Q?pQkvF0hloKKXJ2sOgxv3v9rW6+yhq9uER5nknTY9lWWUXl65MUBb1UnJLnwX?=
 =?us-ascii?Q?fNvpTJ4VW7QFXTy0yo1Q0XVWQOiQucZ8ctTke6z/vXe56Cl9fLHuCZnE/9IS?=
 =?us-ascii?Q?RE+zKwKZiE42YqQgSe8sOG4GBKmwTKNkzw0EeLxvVm7k6awtOPin5DdJGwNI?=
 =?us-ascii?Q?6aSA8drxxCuMb0GLRod0oqBzJ9EBhw28ELe59tXFtfqWR/JsBK3VDSyEe5W6?=
 =?us-ascii?Q?h5LCsf34f0TYCOdZa/KRb/qnfwxU83e27DCIUi+uFWeEm1qn0MkkKo0IeYp6?=
 =?us-ascii?Q?SeHzXyqgN7DIIo8/PbaiWnY9a1ufKhX+NhRo5X+19q127NzDT/L4SUSE9I9q?=
 =?us-ascii?Q?xcoA1msVR8/itCBGHLIog0keL/jYvlrucMPV7lFfVVwaySvVAYGBD9qxc/Dy?=
 =?us-ascii?Q?vjnYF6N4JnKy1rTQDy9mZC3Y8upNmAPpXhr3GiLcPVBp3EYRccsSH1E4xc7F?=
 =?us-ascii?Q?bm4dS1Qi2/M1xqvRj387HlJxGm0awGgn0DgSMMoYwvsrhqtK/lacCH7tfF9C?=
 =?us-ascii?Q?vU8qGemKc5+bpbhc3FR48+ZlFdtsairX+WH+pXjlX644WiuLyDuQaRFPyjJJ?=
 =?us-ascii?Q?OGM44/VfN14ymfXAdsOrdtHH80LjYkQvNsGvlP7JBO2HYA824tQhoTLkmmoF?=
 =?us-ascii?Q?IcPfGrmefHtZVBdHQT8nX5jiaFYNtRYAbokS+10eoOaMzmeuy85A+iSXClvi?=
 =?us-ascii?Q?iW8y8p18e/r3M08oJdiBFeLnHqYELlBkM07Ts87RhN8PLhEqzbNkap1Rf3vz?=
 =?us-ascii?Q?FF1qlDsOC0aGZadTKfiKSgSoh+dTNNK0UtaSj1HDExYVMHvtHxZ+fAsk7Wzc?=
 =?us-ascii?Q?p4tDnU9cmUoMgruhqyemW5bWgSyLV+NTAH13GqeanvZwBeVP9na1ihzUw8uG?=
 =?us-ascii?Q?vZlid25MxPqWtHH7spBB6SpBIUhR4sDIMT6kj0I6O2gGUf9Y329q+hiddUt6?=
 =?us-ascii?Q?cdYqk0uguSNNxCzgfX8xSYhqWAO+eJxCjTEcOpYEIdCzTjPA7aaThs9ZaLRL?=
 =?us-ascii?Q?Si9J+E+kx6RAx3MboC89Lrv26QB3+FWBGw3e/G8nz1k3PyGEXv+IJjzPG3+N?=
 =?us-ascii?Q?Q2Jj6/U1654j9wPBnKtbWMfUMjNB29DjQN4QSU3DQ9AaHQMdbYNKC61hto66?=
 =?us-ascii?Q?vUlml1aTo8ViueZsd5NOF3dFunuBX+iBJ789+T/Nvw7KpS/vd+zL4VhBSq2+?=
 =?us-ascii?Q?70C9yGlYevr6bvJ+Ns9G4FuBg7KaCtipOlmTPyFAYW60J/ilJVbPTZJRHBSd?=
 =?us-ascii?Q?K9Du2yJPXsh8l9DCFSMYhAhBBl+NEO7A40+lexpegDHarAxQ4MxIYhHuh/PZ?=
 =?us-ascii?Q?lMkjOwCaGYkba8kVwFGFCvmcpNkKPg3YVQgBid0rl7mkXOGnqsq26ZkJiLm+?=
 =?us-ascii?Q?13cuEC1FZ030HYg5QiZGcWYFstyda/pI/lmKTfL7+5ZEvUKGzW4nVWPggRUO?=
 =?us-ascii?Q?bzHq1rhhJBD1i5c4UmZOlGoxPmdjQRJiZ6ml9FUUgYJiOyAt/a5ay5U1Tyfc?=
 =?us-ascii?Q?JRzpVFk8acGEJ81Xoq9M9N1OFejCiOPX2NKBm4zERDS1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1ac9d5-301f-4af4-2ee1-08de16cfb80b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:44:13.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF1FC+qQtgftm07RrjiuS65FGvScam8uyzBNsiB+candCokXefAdB1qKBpfrJk7GsZaFAZeLAd7EOy/j/L0fRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 09:44:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20273

On 29.10.25 10:11, dinesh.kumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> That's right CIP IEC certification used bookworm based images.
> However, if isar-cip-core moves to Trixie it does not affect anything for=
 IEC certification as BV does not use CIP CI test results as evidence.
>=20

That gives us some freedom.

Given the current limited availability of the mcom device in CI, it
would likely mean moving on-device testing to trixie-only. A slight risk
of missing a regression on bookworm could arise from that. If there any
concern about such a test consolidation, please raise your voice. We
could keep a qemu target for swupdate/secure boot testing on bookworm.

Jan

> If BV requires any other artifacts for SVV-2, SVV-3 and SVV-4 testing, SW=
G will share from bookworm based releases.
>=20
> Thanks & Regards,
> Dinesh Kumar
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Tuesday, October 28, 2025 9:35 PM
> To: cip-dev <cip-dev@lists.cip-project.org>; dinesh kumar(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; Hirota=
ka Motai <hirotaka.motai@miraclelinux.com>; hayashi kazuhiro(=E6=9E=97 =E5=
=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=
=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: [cip-dev] isar-cip-core: Shifting defaults to trixie?
>=20
> Hi all,
>=20
> we are currently still preferring bookworm over trixie in a number of pla=
ces in isar-cip-core. Likely most notably is that most of our CI build and =
runtime tests are bookworm based. I suspect that at least parts of that is =
due to the ongoing certification work which was started on bookworm, right?
>=20
> What can we change or add to move trixie more into focus?
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

