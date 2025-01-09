Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24045E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 16:33:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web11.1036.1736440389309239114
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 08:33:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KqVIrHFZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtUZl+7hXKD9ByC7d4WecgYs7fcoPAxkliJix/GMzo6cfpT94Hj/iURn1QuAYWJF4hP4nQKsVuc9imFGV3Zk8NHs9zJgiduIGopo/ZUPVbr/lpF3h9VKuUJgz8REkKlrYW/bRamfPR/EfnJWPN5QpD8W0s16Heig6fSiAyVY6h2dwY9ukvn7C6U/KfXxyd9nClqh0tDBKZcwstDVX/6zSBowBSgCIht1gndhvOnFJO3LOdFC8R64ee17jxtHTjgnnlqyP3UC3TsqtxCQfk9p4s+wynd+owaENCAP8bw+fY1MGhDhAt5xRpbpXB3qSvvd2dCIJofdIjgDJnpmSGddpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByiKpL1cSTC5BO10tV7xRDK7teRtV650EwsmXFhvKDA=;
 b=OZV5XxWTqPXF9Iw539FpfNqTCoE78OLaBZRDGb3pyRRQbVkxw3/BQ6u7II+1ViQegtH8D1u/2YgoG/eRko3tKjNxzlY9du83bbiKbElQ3et86K7eyiJ+u9J3E+OtUYDSU2tvIZiJgeuaQaX2RaAyDxMXXY/+btiGQi6P8qaNFQff7lDYPgMdrOQgHdXi1e5FG6HpGSLcoH7r3djgVGIov7el4XntSk0+kPeY4WqckCQ4Q3MdhS6xO6z+LVSRNll2vbIQT5xuhln1JsntdWePydcrjb5vbZ91Jk/ZBAAVrGurUzwaIN5L8AiEzkL9gva7LldDymV6pdovFSlrMif8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByiKpL1cSTC5BO10tV7xRDK7teRtV650EwsmXFhvKDA=;
 b=KqVIrHFZEEgQM2JhBzCMLQqVNEx/D7Pjr/6eI+R7QP4mgQZbxEPkvMAQ6WOzbBQyGgj6X1YyQO1BhWQCGf7ZsDpuJxDVnnJ6ZpX83sNDxOLvpDsLDAptbRBZvKDQdd2DyW+EARlDyQZQ4ZuhdLWcm8rV6ZVMkcy93CEYHgyJMa9UUAOPSUHXEUUd02oQ3Mnot0wBECq8TMwwT7HhW256FPn0Oz+HaXIjdRkixe7SMaEbDcbbsH6vC72Hx5li0R/YS5tYCWkMz1sJpNB5c58gj+44OoKpM4JryCN1qR8Q6dgIt+Z1tumW9xunOVSrf8hSmIjOi/ufao5jkdf2egmoZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8293.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 16:33:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 16:33:05 +0000
Message-ID: <7045885a-2ceb-4df8-997e-8f2b66ecaee2@siemens.com>
Date: Thu, 9 Jan 2025 17:33:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs support in initramfs-crypt-hook
To: Stephen Ecker <stephenecker240@gmail.com>
CC: cip-dev@lists.cip-project.org
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
 <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com>
 <CAK9C7GCBMs8awjxzw5iCy0xUbu+1LJmnSBSv9YR7YA5mKHVUJg@mail.gmail.com>
 <fe44dc91-7eae-4dde-8efd-de636eadf9be@siemens.com>
 <CAK9C7GDt9qvnRzy+hmHSfwTK7tHg6Zqirs3e6JYzz_XQGvTchA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAK9C7GDt9qvnRzy+hmHSfwTK7tHg6Zqirs3e6JYzz_XQGvTchA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd9f7f6-cf9f-4247-3c67-08dd30cb4b07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vxpIaiVDWX5xtPoBaA71kpra1xEQnYhpMsEvh02lbo8yGwQl8aaSFud11kvI?=
 =?us-ascii?Q?yX96Obbea3jPE1Gfc3vO9tbSs61zFbR02tJHfMvQZp570nDO+LGX7Skrid9R?=
 =?us-ascii?Q?iW1dOi92vjCx29q3KpLz4BYzy2eEJ+4JfPSB5gxvsok5WUE2EHrcbTUOCwKe?=
 =?us-ascii?Q?1KWNfZiwnwVLUAXDJXFEs6+8CX7IVS/GGhEwubQBex7CRV/KMmzfLawV3ncB?=
 =?us-ascii?Q?E7trQwy3vQkln/ObW+/arpEPWJKGGBYYy6z+CMRQGYI+31xMVuV3HX9Y+CTP?=
 =?us-ascii?Q?LkT5KcDbe/sciY15rwi3QdvoXRXhh5rMJXMQPkE8srh0kNiwcL0/GYRqqSEo?=
 =?us-ascii?Q?UDLQcq+VKYjDqk0uzCb8gaVsHegNt9dRE0RzTumkyhDlHv3ZIx0gY9wr9kUs?=
 =?us-ascii?Q?tFEknXAkG5t0r1WoBUVC6N3e62AElHY9Ydy3Dmy9o7Xblh/iYaayuEo9qN5u?=
 =?us-ascii?Q?O3VRikm6PWaOaoD3qUncFK2W3/HoG+neE4VTh0elx8QAMjiaKJQr18LUoLhA?=
 =?us-ascii?Q?g21PwJbFfT0mJvnp8teMWW0r8+KOjUtSrPVNfI/SnA8Zj1cCYqlsOj6jqGgP?=
 =?us-ascii?Q?btz8ZBu56iLdsSQ0v0Ic1alBrsYXSaQjZ00YApv7yeSQ6bYFfezRx8bsWBkU?=
 =?us-ascii?Q?rcFY0QekZpVxnyZFGCHs9fj/ubf2v+dZUmIRcbgFH189BFknZgY0mXi7GbdN?=
 =?us-ascii?Q?fkDJ0dSvDPGvdnOT2lgPq25/OSOuf3ObVDIxK6WwslbBkrrGUT4yPIZUNSJX?=
 =?us-ascii?Q?PTsVjSfegn2TTOgCfcRtdAWJOnj4HJhst35Wr1oOw4GcakhBk7INHKNGsCCz?=
 =?us-ascii?Q?R7IwpTzW+MMon92SA8RmQ/xAuIrXwaSTfHspkfyGidhAUBjkZ71gWLp0ytq6?=
 =?us-ascii?Q?7HU2s39jYP31srSTfuXLXT903YiDeWuVdOFWiSTL+TM+XuxBz3+d+tlmaTB2?=
 =?us-ascii?Q?NR4G/YRSkA4+RA1ttIGYYwarl3TZYJmHmFOeeP/oj9ic8abpzhsIRQ8a33WU?=
 =?us-ascii?Q?VZzBGo9/hdLwdDBopzjHGglUtbR9jGDJ7nCraajNuqPg136pzaracLeORqLs?=
 =?us-ascii?Q?2xr29OMKjiFuFNRH0JhBK3Waw/uCBK60pobgSuigpQ0+soSQpII1XVlPNfWN?=
 =?us-ascii?Q?tapdYFSJy+DcHoLztDBlWXaynfOs255VUC+biENaDwbtx8jS3JGGDrFj+I1v?=
 =?us-ascii?Q?wVLcvJBhFZxTil7XzgJ5dPxUKKywsG/bakuYS3CWLeoKCXmVnZOqhs1uTx1Z?=
 =?us-ascii?Q?35LeY6IUGErzfbRydCRIXH8JMTr7uij4caI44IKR2YtocXyGtaA6HsII8FtU?=
 =?us-ascii?Q?6fxS0N+f/yGpcbfQEPjjBBb+5IanIk7gMOO2XAfjNuSZtUWbbPip1v0N7TXr?=
 =?us-ascii?Q?ol4ePLu8V5vgbc/jYj10zG0Nh92+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n5BO1CPZVwUz+Vmwg5HAtuCyDph/ilvREWu95IARfURMeNPPBHwLeaJDTAYt?=
 =?us-ascii?Q?thhYYkKiYSefIPJsuRnzHZymjvVJLpyDHQJZib/KUmTOhcUxSJUIE2z0MCrj?=
 =?us-ascii?Q?tXjMtIIB4TDHt7JpL9jq6dNHih5hN6/e/HswcDuCbbqHNrRMb6HBeX9/ZDdJ?=
 =?us-ascii?Q?tMTMozNSPlY3TMzAqiRH8EdgbpH3OsknVNEr4zF0MrHffHPk2hffXdKaq63S?=
 =?us-ascii?Q?0m8RMt6Om6QfrrZYfMU9SyXo0BIac5gGd/GTGiuzZwOWa7EgrCokzdHwfwLF?=
 =?us-ascii?Q?jNS3XpEs43SOMS9et7f/okMEpm7sJShOw2TR6XrCQeU37FbJKnvXWIUhZA5m?=
 =?us-ascii?Q?ZQQJUWtf1kVmUrZv9U3xWMM3o2PbsU6EnCWnjN6ec9DDy9QwxYCIf8KjdyGE?=
 =?us-ascii?Q?NlwDdyxAQzbKanoU5eGZFqU+sMS7B2pbGcf8OOaTuOin2XRccFIpgnCZJ9jO?=
 =?us-ascii?Q?uITA46Xyfm+Epw0bwF8hwmU/fGvwcgN6bbrS362qjxdRTAD8crAR4VqpCUYP?=
 =?us-ascii?Q?YhbuosfTwbLyYMJf3APXguL65yjxCeNG/RSVMST8Pr7hdEQOznG1W37MUfwO?=
 =?us-ascii?Q?bJ/IDjricZDyeLWp4F1O5vMqXx4S7h7BvvWpoavBtk/b4Sd7hoCPLSgiO4yf?=
 =?us-ascii?Q?zUCn5HopVASO0lectoONYK57Jl/XYWtSvYIgu3I41ghjG84LbPFdqwTWxzY5?=
 =?us-ascii?Q?x3vPjmIdBt3YWVRH7yi1zEoeW0TsZV0htQVqShlH65/5zA8L3Cxkwjg19wQV?=
 =?us-ascii?Q?I5TcWGOWU8w09Z7JCdkAyKxLBM99xeXKQQ05fk05uzag/5AgM4HWuFrTXTT8?=
 =?us-ascii?Q?zG7ekyUEhrkLAfxDla7RI3aQyhZrathSmhNHSeGTaS7N7bxs8v5BI08Pwa47?=
 =?us-ascii?Q?oEbTcPNV/7Eoym9lrLnMf2KGrxGlG7Z1QRSzgXgWyx87tlT7PJQOY4j5f+oQ?=
 =?us-ascii?Q?xgFkR8tAPLkIjISzAnELk5GtKQs5jL2B5UY0Ql6PLiS0oxA18oaqKyHLk7Yn?=
 =?us-ascii?Q?XdnSClRcM9R6WpBh1rhjkFG0iXUfz1psga8tU4QJBIgaTFVjq2jb1oBfp5Rm?=
 =?us-ascii?Q?8IZRFuJLU6PWLsMvJEN4RUHPlU286XPh0W2QpwvY0YoC9ksJLFejRefUO3rK?=
 =?us-ascii?Q?D169D4wxjHVBfiIAVCfmAtMd32xfxKChOxOmoPMDlv9eHhMUErTQSdGxrFju?=
 =?us-ascii?Q?gak2akDPthPWBYtANeV2L/MokBfvzErCuBVNL/UUZaCD6tVUVtCNoeHzQImh?=
 =?us-ascii?Q?8ovI8JmoYkYyOdcy7RrzPyx/yPK8xXhK8r3b2eMOYLxAgdnC0qR9W8908lHk?=
 =?us-ascii?Q?IIE3QRg+iEN5NP+erPgdV61wF3bq/CwOnqQtpeKr83HvGf+G1XtazpNTiwoQ?=
 =?us-ascii?Q?XWxc2gf62detZwm/u3Imr04cqUXuoJ9wzN03M7CdyXqophpoiixKRX2yfgSN?=
 =?us-ascii?Q?qPKfrD54hmCZjfqNoDOPcTBDNxh20Qv0rQNZevrpkMH7s1RkxhkT3oY3X7Lz?=
 =?us-ascii?Q?80Utg6RkkbT29UNgITK8PPs7oVAv18Iul2Bv6OI/efJavraicSh57ZQ631kj?=
 =?us-ascii?Q?32t5zrCXF+jPG1qrA2fTLPl87LDNkqm5w04TnLSQ7iTW72RojxnFOdesr8GI?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd9f7f6-cf9f-4247-3c67-08dd30cb4b07
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:33:05.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESk+BCdoE39e6sFQeyPdrBfORFbwVeRWYYjTZ8KxyCLajuO4MvXnbhX50NcKoX/sgf+5G5FIQHqjd3o+nfNBLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8293
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 16:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17519

On 09.01.25 16:41, Stephen Ecker wrote:
> I'm thinking the best way to make the crypt hook more modular would be
> to break out the support with recipes that add binaries to the initramfs
> for mkfs.${fstype} and resizefs.${fstype}
>=20

I suspect we are not yet on the same page. Anyway, please propose your
changes in form of patches, then we can continue the discussion in a
more concrete context.

Jan

> On Thu, Jan 9, 2025, 9:39 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     On 09.01.25 16:32, Stephen Ecker wrote:
>     > Because the upstream version requires a bunch of libs that would
>     have to
>     > be added to the initramfs. I compiled the binaries static... The e2=
fs
>     > binaries added were from a static package... There was no static
>     > equivalent for btrfs.
>=20
>     We do maintain a few custom recipes for packages, primarily to handle
>     backports of patches that won't hit Debian (very-old-)stable anymore.
>     This one would be more of a feature recipe, and we would have to look=
 at
>     that carefully because of extra maintenance efforts.
>=20
>     Please split up your patch queue, adding this as optimization on top
>     (unless that is already the case) while starting with regular
>     btrfs-progs. And please open a bug with btrfs-progs in Debian to trig=
ger
>     a discussion there as well. If this optimization is important, it sho=
uld
>     become an upstream feature eventually.
>=20
>     Jan
>=20
>     >
>     > On Thu, Jan 9, 2025, 9:27 AM Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>
>     > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>>
>     wrote:
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 09.01.25 13:37, Stephen Ecker wrote:
>     >=C2=A0 =C2=A0 =C2=A0> Is the reason for lack of support here due to =
not having a
>     package for
>     >=C2=A0 =C2=A0 =C2=A0> btrfs-progs-static, or was there some other re=
ason?
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> I made my own recipe for building the btrfs-pr=
ogs-static
>     package.=C2=A0
>     >=C2=A0 =C2=A0 =C2=A0Would
>     >=C2=A0 =C2=A0 =C2=A0> this be worth submitting a PR to add this supp=
ort?
>     >=C2=A0 =C2=A0 =C2=A0>
>     >
>     >=C2=A0 =C2=A0 =C2=A0Primarily lack of use case so far - there are so=
me operational
>     >=C2=A0 =C2=A0 =C2=A0challenges with btrfs for embedded and offline i=
mage building.
>     >
>     >=C2=A0 =C2=A0 =C2=A0But adding btrfs support is imaginable. It would=
 "just"
>     require at least
>     >=C2=A0 =C2=A0 =C2=A0some test coverage in-tree.
>     >
>     >=C2=A0 =C2=A0 =C2=A0BTW, why an own btrfs packages, why not picking =
from upstream
>     >=C2=A0 =C2=A0 =C2=A0btrfs-progs? That will need a strong reasoning.
>     >
>     >=C2=A0 =C2=A0 =C2=A0Jan
>     >
>     >=C2=A0 =C2=A0 =C2=A0--
>     >=C2=A0 =C2=A0 =C2=A0Siemens AG, Foundational Technologies
>     >=C2=A0 =C2=A0 =C2=A0Linux Expert Center
>     >
>=20
>=20
>     --=20
>     Siemens AG, Foundational Technologies
>     Linux Expert Center
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

