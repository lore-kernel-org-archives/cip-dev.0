Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8269D767E1
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 15:56:58 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.85])
 by mx.groups.io with SMTP id smtpd.web10.16003.1730390211649062295
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 08:56:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cgph0Mbu;
 spf=pass (domain: siemens.com, ip: 40.107.103.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNMPafHuiJUJXQoodB2rdrpzrOA7Mtg9voEugAnR4KbPXEvB6PfEuc7gi49BHI9tj43XJO8xCJj86NoPS2ZtAxzYMTC6UmIDsnH2sp9+ahc0uOvlHANDFRQWbdhw9jTt/hB90lI2f3vsAsuk37CndOGu2r2empLgNNy319VZZHwIlMPqMjgUPG+1auAKT1vS8RE7JfKMMjYQL/qyXdVvKJ1Y3tdvZoidagKhIh1JVf3R6j2KATetSg+0lj1W7y5Ms5pnWF1BGDb3/HIZOefWznVLiMtTNVnJ8kGWIX/OZjihdHsWffABMHCNJIv+TImC1ELhOI85dInDwqFhf0AVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9LONwoc5qyA1wkoacwAQVkqlvsDDNGeW2fxVs65o+I=;
 b=v9KyAO7Yjs5nAcLpJ+Uda50mM81DVCs/avFxJG0sKSeAN6j9wz3hUsYeT2Mj48BdQq7jyeb4qDagVK/KrxZMr7KQCtGiCzGZdFd6yMW3WllElze541v5+abVT3Hd3IoOYXS2kkkJI/tDVkBANe68TiYYzAGJ8gGJolmIYx1aQ5Nxte635xgHfLnAsFbYqQw+6o97rEs70BquVig7hglh2NtdPIjGmZSvQ8rUFphOre0yQ5qATVNUQLrfw/dAh307Edg+ZvlN012KXNWyEp0o84xhSOPvuwv6tiFJdEhAdYYNskt1nfkPhWvhSYU5i6bXc2YR3UmSsGy98jbJOcGOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9LONwoc5qyA1wkoacwAQVkqlvsDDNGeW2fxVs65o+I=;
 b=cgph0Mbuscme+T7443OYSUD/RdSIpru0NVxwTt76sw1cEBY9PMZ7FGULxkwSznrEqN8BXz9NptJANMut66g9wihbQA1S+mpH7Bf8MajTpCraftIrqEwGIPk77Z7N6GzLk779vTCfoJn3Vvui1o3ZDYvP+aPK3i1EKCFo3EPrJCah6NxSbg190aGnKLgIc++hPynr2pZYV73NNOe1PiiBvN+82cu4PrRnvWMqD6Y9fBm1DBq1hIcZCdL4XsGXg+dzHvKThTD8r/uT1Wf01lv7nwU2P76LS+FEi7tZuDsxJ8NIFQxKGt99PvkqUdGOhcUC6N2CeoatV4shCVyGSOWFRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11; Thu, 31 Oct
 2024 15:56:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:56:47 +0000
Message-ID: <d862813d-b47a-440f-850b-8aaeb3340f3e@siemens.com>
Date: Thu, 31 Oct 2024 16:56:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs support for disk encryption
To: JohnW <johnxw@amazon.com>, cip-dev@lists.cip-project.org
References: <QjQa.1730387218425037755.QYDK@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <QjQa.1730387218425037755.QYDK@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: e208bf76-933c-43f1-5f9c-08dcf9c49fdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3mghU/q040H7PYEM0gqWtHWYNw2RmhbVAA3W39X/Htpwf8He5oKdYtbnYaG+?=
 =?us-ascii?Q?EkRhW6SAicHPZ8oh/q/2KRbzDfOS9RpaT/+T827bVsXyOJZklGp09GQ7WIjY?=
 =?us-ascii?Q?EUvDD5yyfR0M/uYEw2wgJJSnVEqNyvb3ThCCLrDuUcD6pYVb2UHUdmRYXGK1?=
 =?us-ascii?Q?78bSxrcxu19PjLN0ufjVahms6+OpRzei1pTvuojK9CkULqJ+IR0ZCtXtzgNG?=
 =?us-ascii?Q?nSWjJZfmASwoBB8A1UJpsKpX1EPJp9UYuQohpX5kGglWB42YrNuLqCFPCMWz?=
 =?us-ascii?Q?mPvb/bkEk/URCI6GQr8GGlhRahld0VxXZz3vqEtKFgJ9Aq52fSEnnuhm9aoW?=
 =?us-ascii?Q?bgrltEw6Vl1zhUCblRZ6cQ5Nq8zPDYH30NOcgV2CKkQTcP45p/o3rAQxgSZi?=
 =?us-ascii?Q?2TEb6KOKuoHNz5FdfAaZcFlR3MBkOExIXBqsQskcEcmnVTFhcZwZfdFc3ZvC?=
 =?us-ascii?Q?lMAlFcj8oENdwJa4mQpnWH6JNsV+71DDCQ9DAkXI4l4RV7BKH01BIJ5wN8r4?=
 =?us-ascii?Q?cjzu3hJES2us7qOmLR5EqqWUIXHR4k346WOcpjAX1RGfBtMJ7qjvp0o/uKVc?=
 =?us-ascii?Q?8ZafZdaTOEw/N9zP5IDG9fl7LbjJJ+xpZFPtN8KBxQGNAS6Wp3X/co1kZuvR?=
 =?us-ascii?Q?LP37R/3hnspOScSmiex3+gxkLBMqIS1+fLKg6f5Fsc6PvahRhGq5dzZqJ0Tl?=
 =?us-ascii?Q?aTKnA92pEgrz5P968zQSpB7hSCC2o/DBrEnvWid3D2Z9lOGajgPP+g0xfQ5J?=
 =?us-ascii?Q?pFe/htYo0Tc20YEkEyz347395wDEuumQbirjVlIie0J/+TifWTn9ZtdMUV4Y?=
 =?us-ascii?Q?9dwyInrTxt9KMF16BoDL3xFAi3hE6JCYs17gC0ddFYI8fL+ss1ZErqy27bvK?=
 =?us-ascii?Q?5skX9w1V0D4YPOqOKeHQX4Pi2aaLESvWrYODwvPOwgvZty7G+A/Dfu6OLPtI?=
 =?us-ascii?Q?pWmD3OFo4wHw5AKRFSZCFz0U/1hJTHKaW4qmI/L8GQDip7b2LWU28yeUjOD0?=
 =?us-ascii?Q?b+RSd2qJ5G27dV29vc5Adh3Wqo6XKeQ/oy3ToDg763pVs6gWwXZFVIYUdgj7?=
 =?us-ascii?Q?cqPw2+DzcRKfe+yo0c5NRZgj2lCpdS3qeHQforZU6ck1NNvWW/tHRwT1gkM4?=
 =?us-ascii?Q?hLPZOPzPsb9mTcb8BWSreMbue0DiWZDtU1mSE/6/h1qbEqI3VPf/Wx/tXAfs?=
 =?us-ascii?Q?vmY4BoyPXagmpw7i/s8VM0U8pB6CqojJIcFmYDos02Vqa/afNAM+Fy7ZzmO9?=
 =?us-ascii?Q?oPNm/h6UzDlvlziSsQlK0f2KX3/FbOy3jILw1eCuDVLQA/3uYtk1RDwiLM/E?=
 =?us-ascii?Q?/LnCGIV7rc7d1JjKDmhTgSiH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gTyJpo98ov0rEO2b5UvJva2AK448AFcAMovmSEsiBHBX1SvyOFkWn2MUi3jG?=
 =?us-ascii?Q?7O/kSlSr8rg/VUom5C756CpHo24ZMQiwQ2jo3oxNiBzUEAJrnyIFHZ1PFyaJ?=
 =?us-ascii?Q?gXBVQdsgR9vi2oWeH/3kiBPXpPJm/Txi4P2bpa3d61y085SDI1VXUmOTs8bv?=
 =?us-ascii?Q?zyub+dJN98zXXAnw5xYuTiYsMF8c3sZHlVVb5bSakXyd5zN0ytWwiPlk+8Im?=
 =?us-ascii?Q?FPgdgH9LaUYJcIx4WtXGsiePZCackiDgJli7XoT/X9frSUm0DZ66TNbQyH0I?=
 =?us-ascii?Q?gAeVfEv2Op7VFO39cGqoZWBp38/qiMoFqlcfyFmvURfG4iT0mQvmPPNkL2Vh?=
 =?us-ascii?Q?U0n2FpFlQUirD7/laMKvP/ZZePQ8hhuM9k/iIhimEXI8FGz2orPQDHlVc5D3?=
 =?us-ascii?Q?kKQXlELFMaPyZxtLDXWoM6sca5J2jSDcEhqCMSxP6gWfqqg7y39bGWxYdSjp?=
 =?us-ascii?Q?dO+TmaW32giDXu9VlPtufAs0eENAWdijclPvD+Fqi80Oml9qUGWaZYtfp2bs?=
 =?us-ascii?Q?zSwv9Juyeo13B/ezHa8HJBI/hu+DMDtoSbU2dGxf9YhiTDyl+jcDbPFbVzMP?=
 =?us-ascii?Q?ULbCpM8ubU+37plzRoMMMqo5dnq73cJ3h+rD2ZGCueGw/ftmLhXpqAam9x0Y?=
 =?us-ascii?Q?imAEqepLcSqcafG6mD2jeFv4jzULnIHBWVCileHPgH/X+OkEwlEEhBG9625g?=
 =?us-ascii?Q?4djt2vhQ12QJGYiUxR2lJKbEhf21ingVUugu7TlpVI66IUxY6X6LUPj1YYfZ?=
 =?us-ascii?Q?OPOt2RgzlaoX15A7cugwtqNFMQkn2g7s7WukEDWi8Gos5tzG94FSwiyoEIxJ?=
 =?us-ascii?Q?SalY/PScqAhuBKhlK7k8TWz4ShubCKOLAOMh4t1wNSAFN+P5V+P/EPss7w5S?=
 =?us-ascii?Q?RY8ihzXUjO6GGKbUGKlTUyfwQi2WySQNcOIMaRmPXXN3dYTEpIJWkE/hQW75?=
 =?us-ascii?Q?rljgeMGQKyd+9mppO8GVEkcRSTqLo/iLsVyxgMxAivL0WwXybZODuCoNNUsI?=
 =?us-ascii?Q?j9e6SbsSKk566xlUqFzDwOQfryJ6DNklX1Z5MJ2599zgV9Ai+6PK2drar7cA?=
 =?us-ascii?Q?Vlt5tRIMyxvuX/a9g+pBZ0cKntNdEKNaOu9yaLcl4t5cl5YWRBnSWWlGk00e?=
 =?us-ascii?Q?kBnyYD4aQABDdm2AXRAaxNvxTs0PEwFIz6DQPJMDltVSYkTB/e9E/Mi0AMMn?=
 =?us-ascii?Q?qo/UjYJYixyEIvtrLBmMcnWnj45gbV74vuo8ESB4bwXdKWf5FQZRxDLP8pSa?=
 =?us-ascii?Q?a4aIJ+ULeLzlznWPqt532uLph07NltlIOjaQTBW9bqVUWcGr3cKQc6KX3CXN?=
 =?us-ascii?Q?BRwUYxJJWJLhTyY07p0xztFUjcguUZyZFnGMh0Cyv/W3fcvtZI1vmrhR6diP?=
 =?us-ascii?Q?gl9/f4jcJAewU9sIAh0F7rbL39sr004H+V6HxakoA6ZbZupQV/B54+RzNoCb?=
 =?us-ascii?Q?zmuH7BOsBxehUhjJbCjnGWNrRhoOT6KoHeVt34FqYlqiPYj7FNOrn9F3hmIM?=
 =?us-ascii?Q?Ajzu6iAcyB2zQ0LKnug34Z3B0lEr92zx+iq2wgV0ES5lobzKD8fInGaegqKw?=
 =?us-ascii?Q?ftoruQOTNUsrBNHVdUXnoKugIYcLmFxyNvli4ewrAgH5lNQPKtpdIBLU72IK?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e208bf76-933c-43f1-5f9c-08dcf9c49fdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:56:47.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp+A60hdzNEhb0lVgRYOsegYwCg0DxiLwvBqooAaFGVjRrK84aaP4L1sWNtRKhrReMR+jWmTmKtWVeaFwUtimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 15:56:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17132

Hi John,

On 31.10.24 16:06, JohnW wrote:
> Hi cip community,
> =C2=A0
> is there any example to add support for btrfs for disk encryption? I
> noticed that at the moment the initramfs-crypt-hook recipe only supports
> ext* filesystem type. Wondering if there's any way I can use this on a
> btrfs rootfs.

We had this under considerations internally for a while, but btrfs is
not so straightforward like other file systems. Part of the problem is
that you cannot create filesystems "offline" (without the help of the
Linux kernel), and that complicates the image generation further. There
are more "details" so that we pushed that topic back again.

That said, if you want to contribute the few bits that are probably only
needed for initramfs-crypto-hook itself, that shall not be blocked. It's
just that we will likely not have it in our test matrix with CIP soon.

Jan

--=20
Siemens AG, Technology
Linux Expert Center

