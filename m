Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD2C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 04:04:09 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.42])
 by mx.groups.io with SMTP id smtpd.web11.17493.1754453031627813279
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 21:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kMYb9Ln4;
 spf=pass (domain: siemens.com, ip: 40.107.130.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGoK+uS/AhJqLsnz9eN5BUHMtMMsgHC48EryYcENl9jBdICUhAdKi3DR7XW60L370jVB7Hj8YvwlfqA5mR+6EOCoXF4ivDbAolIgDAgxx8lCG5xwqbcjocnNXyhrBQa91bGiJ0oRy8RN6rFKVN0sdMU7ExiEsz86ISJVM26XxgJ5i0NGsfOGmcNWdaOoATte+L6zhCg7FYnWoCpOMC0yk82VBooSBOv0ts+4bZhr6c9Gu1XtPRbGCuSxoi+gIkFK4NwExnKkijX97j59bZud/em7wzqJ7h+GVwmSy9KzUU26y9b8sNs2xW2r/KO9sqnoyoq0fh0v9w18WEck5u9WHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQvqkcejqKOJmAYWuJSIr9WuiBiljO2drhcbBd7OoHw=;
 b=CaFTBP3OcbKqamoyMCCpJxcE4lcuxpKepdoWA+itEakiBPVkDRj7sZ4ZGOoPsp35EIN4THUJUzeDj+7MByz3CXzZ+BplfEwmgMHaiR/OOwTVh0aw/ZDfIOmHqnTVU+YinwL/ZWVU051HVwF5F4ftrV0igKvBm5lvvK4/6lf96QZ+GzHK/aGH27RM8aFQ5v4HbIJ7aa0poDgJ9ZFDdvoCGucOCzwHSkNt6zJs5w7w/PLiFpyjFwFyHMeAMGdCjG9154AnHe9B39G969CNYSdP7uCbu2l+vDW/6TfP/q4EJe4/rBbJA28dawFbHaoIVIQX69tzoe9lRBID7wyfnOaVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQvqkcejqKOJmAYWuJSIr9WuiBiljO2drhcbBd7OoHw=;
 b=kMYb9Ln4hvE52V2hky6PRsZwxqWJR2x3m80sJgqglr8tEwlByHAgeqU3DC55+AD5YUDPsn6k0f3anX9O8Strge9/QeZYVxJkPj+JnDzu1uSriLCYRXi/EUQNoZk86XUmQkpl5htJr8f7yQoR0N83J8S0xXkP4/zVQiA4eWUeSyL1IyR0a9Fl90kOpuFnPAp67VZMi+Gh9HekigMJwmBoFaVQimjnKS9sXkf/nCGhLdokN2Z7KOxDzLk1OZAhqUHeM8OOcfGqUZkyoqHZdUtmTC+fgPV7WsPnn9YSDVoxM+Ko+RXqMjRtAr1VNmOax0AwjT7wGOAQQdwBrrNiKHMLbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:03:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:03:47 +0000
Message-ID: <45d4c4e8-322c-4b01-9385-219333638981@siemens.com>
Date: Wed, 6 Aug 2025 06:03:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remove
 the credentials from console & document them
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Adithya.Balakumar@toshiba-tsip.com
References: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
 <29c1beeb-3f3e-4bb2-89b5-a84d2b0b5043@siemens.com>
 <TYCPR01MB9669DF71C777AFA3B394F007C423A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075B09AA1BFCDF5DACB3519C723A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075B09AA1BFCDF5DACB3519C723A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: b6548e5f-1b83-42c8-3c09-08ddd49e3e66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fTdrjVcc4MbEMfrcAcLz7QQz4xNtJ0iV0r2MHvOR63co8VmRiqylrNpmmPHm?=
 =?us-ascii?Q?Lp1pzRTTFdES0Il6b8Z7hQ8CsNGwsZMl6moDpHNcRKLoGOA9GzE+nel2YGt7?=
 =?us-ascii?Q?baWOs7o4AGXdjkTvxpsdhxpF1SCFNq1Jn1wEN5zngaxnhPD7tkfM+3uqWleR?=
 =?us-ascii?Q?jSQPGm7CyVHZUPrPCRsJFl4rX8xv7iBDrKRMAG+2Qu0bAtkkPJzs1SCAogwx?=
 =?us-ascii?Q?WXoGUgWqckpqd+QcgoknCARoA8uPhWHz49GLpaifenaLpkBagmM9kstFaDPL?=
 =?us-ascii?Q?YjUFVKL6ibL7eA6fiyNk4ii0KhSHTaIRq5d6SO7220iKQdqaRcsej2qozALS?=
 =?us-ascii?Q?O90MAO82+dVYOH6mbukWLFxF5TN6uH5hBTRmBEoDpuy28tJkM+yIHb0IRezx?=
 =?us-ascii?Q?xa0TbekrnaCS4RCJXiNsTpGo3+OubMEnJ/gymCoHEmTggq2sSob0zIjYGy12?=
 =?us-ascii?Q?lGRMCYLla0cPkuZh3mKrTx76P59/1TvZKG3brdasIHMMix265uyKO4M0AV1H?=
 =?us-ascii?Q?9YA/nxQROLXV4lVnH6k647Z2Z4QOrbgTyr6BCCPulVSBdD1W9/8bYOu0FSgH?=
 =?us-ascii?Q?m6h7htPrSfMgMVQfvSd4h69h7enOizI7z0JGZX2T4dYaR2ccxbWYzbtsz993?=
 =?us-ascii?Q?s7xVNJC3aecd9pEh/zcS6ehLBybGoctivWMMvU6Uxgyf7JUsvLogLCfzVkzc?=
 =?us-ascii?Q?6r6vXBK91YkNHQmogANVt6PT2G3jmSeMYErjtB8iU8paTem5ZyAxUgjQKEVM?=
 =?us-ascii?Q?wNx0Zt7MsiFQ9lpcDzB4NXPXVbX7H8KEMfLPgBYIit6XhyGmgOGJbJUWgUFL?=
 =?us-ascii?Q?66FcXX2nRTR1lqO0Q/mKa0pCz4H3Dp6849r7ImY1V1ghwku8KAOS8OH8ZlLo?=
 =?us-ascii?Q?jp9PyXcU4mnYoLvm5ErPUd/gUgqqvlfsyavdGyVpWXfqDOGYIr2gPTTUpVno?=
 =?us-ascii?Q?oh8oZjNdRwCWntFCMm6JWV946pGR8BQeh5NvNNfzNZLwK2yPcyvUCSsiCCmP?=
 =?us-ascii?Q?16ypoRTv544TAZQ1o8+5KrKA0M2mCtRf5Ld4wmIcMiP8ghhZ4cayP1Vx0vIM?=
 =?us-ascii?Q?drgjK12c1UlChVSXmXK3g1mWzoCdF+OsQ4kWSmmduC5AJRFSacv8+IBiIrrR?=
 =?us-ascii?Q?fJaJBLY7pdJvXnHVFzLq4pvACpUwwy3xO2Wn2hGkRJFjHxGDJfFbyK+LkYLa?=
 =?us-ascii?Q?fIuRXDpJ7/oyOijt68pfwZ1cH8WjgNV0YKwgCLCdX1cGwBqIJB3g3dN5O1W4?=
 =?us-ascii?Q?YVLUXAYYdjb8Yr3Iw661vv51cPc6cBZ+qi6z1bAcrpyaYb1J0YeMQ/38bZbG?=
 =?us-ascii?Q?MONnCLs02k/qG2/GHlUwr2a4/zCqZWKfyxSFroRXmV63g1HR8YnTHwS8cIRs?=
 =?us-ascii?Q?SUfq739Sjkl2FBIXZhrYOOO6upbJvEqcUx3bpW0VnEKL3gyuQJqPIIXiXsuL?=
 =?us-ascii?Q?c/vxR5H5Pho=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jtf64a80/AUxJ3fC9dwE1yuFmdPQkX387RPWnuF/G3zi2xP82sh0FlDzBtyF?=
 =?us-ascii?Q?fIvFEqqiyAzFVGTa2MUDoEK6GOg+bffbie4q9v7T3SPPbF1wxmvSM2Dk2zX6?=
 =?us-ascii?Q?Rgf39/T3FORyK155CclAEksNcyN5oKdDpbl+ZPTUgsqkg5QDaK5f+icthQv2?=
 =?us-ascii?Q?780p7BYx3Nu5PYoNDNTM83XCWqD7HE9GFC6mtr+vMPQjdD5lTJDXHydBIU4N?=
 =?us-ascii?Q?jTE0lRK9RTqgQsxwo7lRvxJFhcEtro30NPnom/JTG7IWZoPjp7iPjI8tQ5ci?=
 =?us-ascii?Q?mXQ5Ei5zEnoe5Md45wVxPJSAG8zzy9umTZVgvtWyS1VQq9Dj1bGGMvI05ifY?=
 =?us-ascii?Q?U3wK36xmTs09nf6e3fPeLgqF1WHMkwwSMwXFRvD1/S5gFOLQgDm+gRe1kZ26?=
 =?us-ascii?Q?Jw8NzzHJvPd4raM+5CyprRZKJq2gfunNtzEcDQtq4yjjYowPEnWPySAGyZy2?=
 =?us-ascii?Q?FDMJJqbzT8lEX/nf14yky5gkDvrDDozcyWSZ1SY+zbV8QZosYXRORFWESXy8?=
 =?us-ascii?Q?xd7ORtcdmzM9qOCRv1OuzSZbdWC5Emkl+d7N8+eCHqX4SURD4aWz3tgoxaLg?=
 =?us-ascii?Q?sw3Vo7aAI+cm6NyqdL9lk6qO0V3GNh8VzPkjgdLPuAPBQbv/EmG8q8YTK88s?=
 =?us-ascii?Q?e72hJSgERyDEnpubJTFHtN0MgidJIPODsU2jgPlv5Qt9IELTo+f0N/JLmu4b?=
 =?us-ascii?Q?z/FOCMr4d83qEiPk9hflX8H0lNzlmzlk0IOJRzDuJrr98ZJp2V4y1YWnz4ZD?=
 =?us-ascii?Q?CukZs42ZKXhIWzlQ3iOSFW90jX5R1G8zyVGNE6TsLcvSc/xz0nCMUz26J1JX?=
 =?us-ascii?Q?hX0nMLJcdBRyFxgjIjmR48iV6yFS7CKp/aRT1kmagQe0ADz+yrk5yHzzmV/b?=
 =?us-ascii?Q?GCvQCueJULSs+EuFdiixT0KDFNLJsJuU8k8NPOEWoc7050QNgOzOSWkHCqUP?=
 =?us-ascii?Q?RNLguXKKe+2+qicrtsi9qQJ9QCVebf8mjYYrv9BXJcbwMWnpkc5Jw9W/Pa99?=
 =?us-ascii?Q?WcIgpttXYP8ssi3Zdbl0eiGY3u7sH0eOQYAOPuDOWYJITEK4p2PPlRTnNwsf?=
 =?us-ascii?Q?S4X+0YOwJ0rt9YfmFoj/BLvPMC0Jg+zprkWCyHXxNoGIxSdq5t1IeFzyNROW?=
 =?us-ascii?Q?kNBNMUKo+Zu/AsaSVNBfUUOcC/SGKYI1knPwJf2nB/Xfc1h23FKQdQD6B5w8?=
 =?us-ascii?Q?hwTX3SE91T5wK0LVkjb83dQgkRqWQEB21Fvnm3j06oPWYPRbGCmcphFrs6yo?=
 =?us-ascii?Q?e+Gzent+DVinzFjTKQUPJGBtxkN2LWWhPZG+XOiC2UPrEUoxx1ETMzX88TXv?=
 =?us-ascii?Q?JTJn/jcOWe7+n486UDi1zRHURXKzXt16P65D+NmS8I1i1A7jS4IqdZXBTqkx?=
 =?us-ascii?Q?2IKCg7oxpVL2zkf4IVOR4jM8aDNBnGgznNUdaCbDBragCV0IcomG1lJwvRdJ?=
 =?us-ascii?Q?pliFNqiXPLi/6uPzlwWivP324BoHaKSeUE6hodA9ehPCw0/vGF7o+QYDuJ5P?=
 =?us-ascii?Q?TnYFxGY0LWu4f96gN/WEfOP/ebHHhLTazz8tRkbLN4eQU3kLXLJ5ShnSdhLa?=
 =?us-ascii?Q?Ri404c8m4O0wWK3McfMOnUL824FliKIDVOAFs/i+EvTAnztu5dJHiFL3gwL2?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6548e5f-1b83-42c8-3c09-08ddd49e3e66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:03:47.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8J1wtP7dQiVG0LV5K/1NIyPMaLd7VYFhorSm4nW9HnSZmGPGuGSWQN+S+xWZ6ua5RvV95RLvWZcUEbYTwnUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7492
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 04:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19676

On 04.08.25 15:08, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> This is an old patch and would like to get some conclusion on this.
> Based on the conclusion, I will plan to send v2 patch if required.
>=20
>>> +IEC 62443-4-2 certification body expects to remove the credentials fro=
m being displayed on the console prior login stage.
>>This sentence does not belong here.
>=20
> Okay, we can remove it.
>=20
>>> +(Warning) CIP users are strongly recommended not to use CIP default cr=
edentials for production images.
>=20
>>No, this MUST never be shipped in production, irrespective of any formal
>>certificates. This here is a TEST image, not a PRODUCTION image.
>=20
> We can remove this statement as well.
>=20

Having the statement that default credentials must not be used for
production remains valid. That statement should also be added to
kas/opt/security.yml where we inject them. That file, as it is, MUST NOT
be used for production.

>=20
>>Anything that must be kept for a production image
>>must not be contaminated by setting that are just for testing purposes.
>>In that light, having our test password inside a customization package
>>that could be reuse for a real image is a bad thing.
>=20
> As per my understanding, we don=E2=80=99t have separate recipes for TEST =
/
> PRODUCTION images.

By definition, isar-cip-core does not (and cannot) provide production
images. It is just the toolbox to build such images from.

>=20
> Correct me if my understanding is wrong here and also I believe minimal
> changes required for PRODUCTION images based on the current isar-cip-
> core recipes.
>=20

How minimal changes are depends on the actual product. But it does not
matter if those changes are just flipping a variable value or replacing
multiple recipes, adding others. The point is that we are not producing
images that are 1:1 usable for actual products.

>=20
> In that case, the current patch which removes credentials from console
> (/etc/issue) works for both TEST /PRODUCTION (if production image uses
> the current recipes as base/reference) images.
> The CIP users should refer README for the login credential details for
> TEST images.
>=20
> As of now, there is no blocker from this patch. =C2=A0
>=20

Please adjust the readme changes as discussed above and, while at it,
document where the credential are injected and what should be changed or
what should be avoided for production use /wrt credentials. Then we both
fulfill the formal certification needs and even add real security at the
same time.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

