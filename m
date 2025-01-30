Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D3C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 05:46:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.63])
 by mx.groups.io with SMTP id smtpd.web10.9775.1738215995723160794
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 21:46:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TYbz0kas;
 spf=pass (domain: siemens.com, ip: 40.107.241.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USD1vPl0cwY8rlD3r3tyhAz2rJP+ozfPpw1LPfvKl967eMt5BzW+cDuHPLGX56GZkr2f22xzCaGHoZWIroMuRIjr5CtWt88gcIOnVFxNfLdVUvG8QyRPWxg8fa9jAgl9ytYvDSn0NgrcqVcAYnGu9QWSFD1ZQEwxjishpwkByZjUrUj70myLHS3Jq18Lr95IR+WwylIyAEwzrc65pdrXOGGrH1UNUaGlCvXmqbYVrTTS5ZXUpUXRS1bmxeqTotJtRCpUMBQGDxCJ3dyBXkIQf+/eHGWcDnPuVPb+j7L2dTdbm4as0aKgTRt5wiZs8983EGoxKe/4zLf7AltN17DNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWHEbAnK6k5Fw5QKyeIN0+QFeSrej80KMRA268U9A3s=;
 b=c75Ft3D+Meni1g3DgPhL4TSGjpNuxRgCgXkBkB3puqjLi9ZyEskZMVBt8ML+n+ldQL16ZMwb/aErb5JQJ2KJhhR8cBtZvQPnrhgCP/xNa5ye+DIapfPFwzKh5ROQiUB/2kXf/9yumyNi4QSporo65dR1wsmij3BzEJURN9OIN8+5Z47kz7wcW3Wt4B8QUB2MeHpgngh8/1ridBVh+ls/DomY1vqvV8xHrwG47KRQ0kMJlT2oydXYMUAm3yxF2N2554BycRKIfX91nh6RpgpPPt9afD12R9+9FZxqIAWuSUgcoRcc9w9E5vThRGZ/nWSGZCXQkkp/0AT3z7tilAjRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWHEbAnK6k5Fw5QKyeIN0+QFeSrej80KMRA268U9A3s=;
 b=TYbz0kasdM2jln8ri5SU1e/lBOGqwh2ptvEbKu1C46LpeWe7gwtEcWP3iWaEYVSqQqXGl7/rmsRaqZfhq+vbZYlOrFFdQg3/wPLk9/ilGkLHgaPpV3NPOb0YagAhPPjmmrmlpITkpveP344mgCarIRuKVGs0ju3zEkIphsZpr8JCN/1lEJFSM0zf/dsPz35f0jCIN5vv5fnDP9QhhRWTnBBuD4rspN5DWryVzxqYnqWpZdD4xsZnTpg288ITGgOkRuvPqV5DpHGhSFJrU/XvHdcLm+5Rm6u1y8GBPaj5VXnzxPwEV8aIztj1Zh11LjM2N8d3je0uEw0R8AODxL7p1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 05:46:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 05:46:31 +0000
Message-ID: <3ab489bc-3d54-463c-8de8-43c3872ccf77@siemens.com>
Date: Thu, 30 Jan 2025 06:46:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot-common.inc: fix FILESPATH
To: "Nussel, Ludwig" <ludwig.nussel@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <b6e7799b1329fe8b403c37fa46d3d2258517ded1.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b6e7799b1329fe8b403c37fa46d3d2258517ded1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d472e4-5747-45b8-2731-08dd40f172ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m6Ti03iZx9aHor97qQgJGWqk/riHYjWgQURDgJ4T1S+gxfA0hYChRvF1cRRy?=
 =?us-ascii?Q?fX8MefwDeCh8qCG8qwZvcfOu0LbrS6GDEOYTgz1qv/bR4nRV57I1q1aB7xXl?=
 =?us-ascii?Q?GhLUcbAqJGyBXuQkMAefzJHyHlLhjvPPV0cyZlCwHmTGhKC2lmJBHzH9ICUZ?=
 =?us-ascii?Q?RFf9i7QQtLhWHxFmepeQ3/5apAQ0TO91d/J8f5oah0vEEs8JJJ3oMr5S+Wa6?=
 =?us-ascii?Q?jI16inlwPU8PQkVhZhIL9oQN61EYEfZje7JTuJq+J6iZVr6Z2C/08Xo+LdEB?=
 =?us-ascii?Q?/Go8N05zgLr/5yi7flMFxaU6L3Rg0zkK8cZ/cKkLDPBZDadOE6E03cmebhCB?=
 =?us-ascii?Q?57CMOvt7AhlGYd5uu1x4bSVB6SOqEpWgZJAa/VVOHGzuCUs9kYUN3qAdMqJr?=
 =?us-ascii?Q?eUiPAvuRUaZatEZsiYa379D5lfoHXTsfwD340k8KYPcp4DOZIUpNG0c2s8eE?=
 =?us-ascii?Q?95vQnuJ3AAHuCCXgLEUTWXVwBzb5WeMPLi4xZ8pxi8/mntyWKOxWK44eYoF3?=
 =?us-ascii?Q?OHmWdimV32d5EfYvcMUVcybbKHLrvJRWGOvdf+EvmpQHgBzlt38+T9uh3INZ?=
 =?us-ascii?Q?Pg3iTsIal/Dv6c9tRkfevycFQjcAKsbdTLl39pFpIEwUjAHlga7TTUlUylFi?=
 =?us-ascii?Q?lHhBliZ4f7c0u7KB0l4X1EN7pcBtUIZUSpZmkznavPWDbX1Cpye3bTnzBYCP?=
 =?us-ascii?Q?xwgeuU43SlTxw5OzNCP+s8XK4buqJOaYv38nigY0OC9+UXr4+fYiAQbhxcLN?=
 =?us-ascii?Q?Y9OhUUewf1GNJPHhseqlyIry03YI0YoNarBdrny951PUXgQ0VY2A5nxl3C8J?=
 =?us-ascii?Q?PbZFqQ5m1xDPiYAxiHF7kdMgg1aTsazjf9/r6ALCuaIvCwwTnRX9ITQPrvnw?=
 =?us-ascii?Q?48DU6umrFbi2Rb+rccMbsGTOEHpCzDY3rO9Of2xU++ProumTCWkj8HxZ4dRJ?=
 =?us-ascii?Q?k0quZTfcTM94CVL+lu8pQBpglvCeTJi8/vlHZ3iuJ9KkrYEqJqheaDpY58Pi?=
 =?us-ascii?Q?kKna8t7X0dIHIb1HuvAZ/A4L/uuwCzDGfmcIdP9bA4eqtrHAqNIiGKmrvrDo?=
 =?us-ascii?Q?A9Ssw7N0B0c7QikC46Ah3KS4On+Xlh0um5k0i9eC9q0YqtLH4CGddYuu13qH?=
 =?us-ascii?Q?kuTk1NJLdgGpT0xtkkqnQv1K8X+U576PyCrzfiSk965RTbPNcYSiXjIanBVP?=
 =?us-ascii?Q?eduaGn4wRK2L4ZgYk8RvugzCVOq5ypeklvq3DBgupuTaMReHKqoEqgvYWOa9?=
 =?us-ascii?Q?YmW5DN6siKtLExezbaAU2QIGv16+uMwu4U2zSYZ0nJdnxA5mE/6ow4FWjs9X?=
 =?us-ascii?Q?4Z7hdhASvKBex7mTRc27sOkbvSRhR2z9pxKYU2QZ4Rd2xQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?inl/coudy3PlnxDv7leeyUL+fXr08PZZXuYgz9D4eA2zyZMxBlITdkJ6seA6?=
 =?us-ascii?Q?5c4CwddhQGR1+o8NeOk30a4EP6t1DUy+cJUF8NuDhpdzrDrTfmaagLMcwMOH?=
 =?us-ascii?Q?N1eR8t+j1gAocgVwKtLrzBYPf4825S7PjjDNCibN89U1Vdbv5hCjN/d3W1yC?=
 =?us-ascii?Q?SYPFW3IstdavBKBHiK8gAGrR1tXOqDFnVI7L1F9l2r6dXXqJcDgE7KfxiFRs?=
 =?us-ascii?Q?+gTgWys+tHhasOK4wVgVqNRjOLqLPyBu0YW1wK7hMc4bFjwiaOyrVbz3I+AP?=
 =?us-ascii?Q?w2+W8wmAE+lQq2/QpXM0E6D1zlnn8l/TsIvqT1Pymo4ctr8SBIws3aeyfPly?=
 =?us-ascii?Q?jV1osiL83W2OCdk1rx17sXKQOkYyt4gvvmcaNBIMnlAgbjL/KTe06YXtHCPG?=
 =?us-ascii?Q?e/65CsFLDrXaW7AvtZorKUijJpG+U5QGUE7ONwkUBn8iym20Sri2RnPvUL4v?=
 =?us-ascii?Q?+PVSbE9RIK1jeY4Vx+cP5TtM1yDxlnS7KEioEVft/9xhGwZMZ98U0Pq0a8hf?=
 =?us-ascii?Q?V0NmbfMowEeMxKWSK0JWQAWt2FW9TQJl3BnrRBjMB7y0NHouY3ToCY5DRFpV?=
 =?us-ascii?Q?Wf8JIXcogjpc8pkouJV1jqkg6CdC0k55oR/d4iJchqe+6a5EUqF3OfKn6/FH?=
 =?us-ascii?Q?QBJDMBOZsijVFSBQy1ZTDfxI72B8Oix0PL+aTr/PH8jYufUEsfddapuiaJxl?=
 =?us-ascii?Q?ISlCN+BmgyBHweoBhxOhGBCfzIuS1/WbgB+2wzgFBmMaMY45UajLVA4Zx/R5?=
 =?us-ascii?Q?Gwkt3/kY2ADmUcbYVho9O0kcMxmLQAIl5IL/qDgy6Pcke/safDzRXaCR6d7J?=
 =?us-ascii?Q?CZIptX0+3jbnoa4gJTKa6fnI0+M7cSZ0hs64FIc8138QkATOJt4MuxOizzNS?=
 =?us-ascii?Q?Ph9PplIIbbSDJyHzrlwd80uTngZ8Iq6AMe5f3tGVEbm/Y2lDLiI4vYpdTRw8?=
 =?us-ascii?Q?TrkuMQFs8LoPT6aKtofbEoc0nfaUbkI+ULrDx75gro1FohT7IL4mqCyylkG4?=
 =?us-ascii?Q?I7oFuqMPc4G+j1RwLJgt3wjkpqnQAejpoZh/4vx56hEw62bsW4avMKsmYe98?=
 =?us-ascii?Q?2eLsowqt0b4X+FRSS2VYV18srxuGkw6Ff/Hpr5QyI27cMuLsU+/o0q8Tp8bz?=
 =?us-ascii?Q?hyagigfKnLdJgjsj0BfoMTIsR7bqJWPZzGccH1te8wTUVki4vn+wgvq3Is0z?=
 =?us-ascii?Q?odCiqE/9cuUmP/Fsyl9GicIyeiHdg44VyWWXDvBuRF0MI89oXJARuLDN6Jjx?=
 =?us-ascii?Q?A0Fz2Tj+qIbhOvmHcN6UoDuVHB4TNTUKx9BOMEJyU4F5RYTO3gq39Cg1qJc5?=
 =?us-ascii?Q?Jhb71Fx60xgZgWH2hBMKxfxwPVEeih8NJQnjkNCXLGwXebTAYKgkNqnTLtJg?=
 =?us-ascii?Q?l0A8LkOhhdDGB4RCTTEcg4bfZDZXX8fTMkk2diPUdAKi03oMa/1RQvLNyQBE?=
 =?us-ascii?Q?+KyR3DYR6Uen1rdN/Mlzf8bkPPqH1UpwPeNJUzVX/F34BRVSjRn676CdfERP?=
 =?us-ascii?Q?9sgF4bQ1890RdheOYZ9RPBX4Qi4MQiXUf0Wa0JWpANQKYUGB7YCPzGnb3fUk?=
 =?us-ascii?Q?OuLSIjiljy/BSATB6MRsaKDwenRrSh7apfHyAEXz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d472e4-5747-45b8-2731-08dd40f172ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 05:46:31.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sonFuWI0DS7pi13ZN96JiCmYcbCUSVPo5dGR9DY2MkLECuKEoqN5zXiP1Eu4kOPyhEmQMvbYpPw9iz0LVzp+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 05:46:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17683

On 23.01.25 08:17, Nussel, Ludwig wrote:
> Extend FILESPATH to make include file usable in other layers
>=20
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> ---
> =C2=A0recipes-bsp/u-boot/u-boot-common-2024.01.inc | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/recipes-bsp/u-boot/u-boot-common-2024.01.inc b/recipes-
> bsp/u-boot/u-boot-common-2024.01.inc
> index 5a020da..7f2d611 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2024.01.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
> @@ -11,6 +11,8 @@
> =C2=A0
> =C2=A0require recipes-bsp/u-boot/u-boot-custom.inc
> =C2=A0
> +FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
> +
> =C2=A0SRC_URI +=3D " \
> =C2=A0=C2=A0=C2=A0=C2=A0 https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.=
bz2=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0 file://rules.tmpl;subdir=3Ddebian"

Thanks, manually applied - your submission was malformed. Please use git
send-email in the future. Also, my tooling complained that author and
signer lines were not aligned. It uses the signer line then.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

