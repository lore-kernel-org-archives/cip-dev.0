Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E4C5AD49
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 14:19:36 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.52])
 by mx.groups.io with SMTP id smtpd.web11.7273.1748614769124578009
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 May 2025 07:19:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WJ1nCW0B;
 spf=pass (domain: siemens.com, ip: 52.101.69.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8MkJoP7GzKNcIuPdB51rShOpbHuiLao1ndso5BbqQhjrfl44DTUkRmXP2PqWs+iHRH78ntMziCmC/2JNJuEinn4bwYkXQjamke7DMaIqplILR+XG7RtNGGxMAxZQdIpIHBRXM0zA7QRPp5+SDTrklbJyAQU2OeuXpdUq582Ah1fc7YZ9TR7aAuAF1SFiSvx4Ie/pE1fI7PZyOoHJNMb4nJjtnnaQwloHCb8wdaPUubJiLtObMEKAfiLiSZqlF13N3YJ6lYqyDS9Vu47tzRrGHDvyNboHbOcOWX4+2T5VCSnCb58HqBcNPCPT1SPVC3oLvjcoWsQ0qQm5u+mhBfRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozx+jt+EMdodQJSvWYMuPrE3loyQPmCToTwzVGk2o80=;
 b=jJJ00vr2JgnorJFVumAyyvrIFUjyRdru3U6m7RIpfHhsVgk1HIKP0b9bKK40QkAI7c2xQ+IA2ff/ikx6nyb+7ifE1Tx34ScJBzq8OQO98xSKmo/bSuZTODznGszP2+u1YEeBIzwj6QKpUM+wtkxgmMN6D9AYl3NMD32E7xwc0P5h3x4yzueKmCaEV6Jdywm8AXYKRD5pu1kV116uU6hczngFI11cTnxd3la1nKB+slHRyyfghqmk72JuwemLHHrS0DbTmEub1wmmuAItOIqUULD9QgHaEXI8Slfum5J2IwgTpWuR8ihPn8Ff4h7Nc3RRRAfgomOFVWDlmqJ0S8VFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozx+jt+EMdodQJSvWYMuPrE3loyQPmCToTwzVGk2o80=;
 b=WJ1nCW0BUpDe2IW1VNh6v43KbrbUAdMRH/jqK5iu9wRDwhvy1oIFdxbLEaQmBiebCkzylaNTU49+GhCBcGrAXYvP3MpVRP8tGjlLxz/0JspNCIdUbGsONlRXwu9pPKffDNE2eoMzOvlNl/iEKoXsU0foIKXssIilD+EZe8z4jIUPJvyqJMNYbnw068n09t7x87NEZG6mQ/MDr68nj+cQMNTx5MuwOy7TsB2KQ9k7NOrt/7FjtNf7j1vi6ptEnuJbz6BPM0SWm65rFAjNimKpGMKNOyGtXRPewqHX0l912siCaJF9ryPF6hOZmrmt69Shy2vKGhowip2GVGACg3u7Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6377.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 14:19:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 14:19:25 +0000
Message-ID: <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com>
Date: Fri, 30 May 2025 16:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>,
 "Cetin, Gokhan" <gokhan.cetin@siemens.com>
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e9f31d-74f4-4ec0-b1aa-08dd9f84faeb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X8/NRSIqDuwxO5qV/e0Pv9Kjxtci7UQYy9MuuJ6FJEMz8T19AY6SvDpb34gT?=
 =?us-ascii?Q?HtKT53ZpU6KHbRnyin7ucKObP+Lke/J1A2pBKnk27c6LxwHFipCLiqbQeqvg?=
 =?us-ascii?Q?bVZ6VE4C9PG1RwN943nb15ijKDxTj0uTF5nA1EX2+9QW3EnG0wC+YGiyKC5Z?=
 =?us-ascii?Q?xct3QIgVl2eAKRVX8jGBO8f2F18m4+thOyIfLJe50ELP7fHfsBA5tzGDRf7M?=
 =?us-ascii?Q?g+WEPX7CTyHnng6THU495CLY1we/sk2P+AJNs1k9yI89zWBtOgv/1Qa8kAlO?=
 =?us-ascii?Q?hil26fN13m+VHRBfFS9fp/zQ7MetOplrfFj+B7jVGlqh8CjjgMSXxZSdRAdO?=
 =?us-ascii?Q?ea+AU5OmuaF8svM2CPxM1N6l92D3CIuSUuMDuaIvyIa8aBX3ZLIxMwciznRV?=
 =?us-ascii?Q?4QXSxQs5b2LNiYIZQUxDMECeOsmsV9NSkRlPcUkSqFpqDvYl2q5EkBvw1bAt?=
 =?us-ascii?Q?+YzvqvIudmAfbuSBbjUq078eY4yEdm9PNJzHuwX7l48iN3VRUAKO2HlQxW2x?=
 =?us-ascii?Q?po2F3qZL0WF7ttypzu9pKXx5Lbe1Q2BZcEA9hGXiQXZTWc+C6Dl9nhlhqfNg?=
 =?us-ascii?Q?QuuePt2wz8isM0og7nmrACQVRWW4fBXcSlCmtpln1VgYIpoqfPNKcCVdjUHm?=
 =?us-ascii?Q?tAK2C5CRxr96HIBP2UrGlMmQ1AoxTiU65fjw0Y4YcNpD7pGO7vBJdkU9Q/R/?=
 =?us-ascii?Q?Qh9hyPvokQLazBjnNnd5WbqYuph+xxZYNWOOZkPjOh5oOAOjpnHkfgd2L/4N?=
 =?us-ascii?Q?Uu8frgk//i5zU0pyi4jYMxKN8SgoG6RPUq/HHdUC/UpFzQxm0h8ql6hDFmr6?=
 =?us-ascii?Q?cthzyHwBALXSEoAT7YLzfLX5srLObAsYVZi6Z3vBrVzPpeB8N4GXGPBmyYSX?=
 =?us-ascii?Q?4XL8Q2hVZ2GGwICo8meVDWW2uJ/hDhlyqFHAbrvsjTG/iZx655szI7zF79mr?=
 =?us-ascii?Q?sKp8uDnUoKEqyJGWLy85homBHK1lhcptWQHK8svEDoWjFMdpxwzyJlawpYb4?=
 =?us-ascii?Q?YR1xS0lnuKyP8U1qddU/dXoOsI0pAy+TLP69fk1j2T9Uz/VZcwZeEmAK3mLC?=
 =?us-ascii?Q?j9vVB9w/zY6tSNHDD9byY7DpLsDiY/knMn0RCfyNMK26UaAfd3PZ53g6P1b3?=
 =?us-ascii?Q?evgfP4ON/EBYWCqIMQcXVFL2Y5WrOFhZ+BBrb2T3/+cyjwDPFumIMxZCk14w?=
 =?us-ascii?Q?xuHWPE5hifORUAgmkyahNytMqbdlvJ8pRkb/+F6e/qCEjqCVBxJWIXYaBNfd?=
 =?us-ascii?Q?7XYV9FKce+IpwQhgnIkeWUJjRIR4pKx0BQ1YVUfXAMEnuF7pMHp4j7m4r0Dk?=
 =?us-ascii?Q?PlbHCv4GsUlUh2YfGlnm+2Wss8z4L/Crho0O6XPB9pAAhDL39v5w5x2GeOZ+?=
 =?us-ascii?Q?GhZR4UetG33TewU3pQ43Y0p3VmcaRVXRwrhsRDQp3MnzQLjJTp6RU8zh6y6i?=
 =?us-ascii?Q?FNi+aQ7HWD4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wzpE2I8d8f0+Eh/MazSx8ioudkoOmRWozFPGaa7xL1tnMN3ccBmmQvrXZTUr?=
 =?us-ascii?Q?p6xy7Cwv75X8PBA5EC8mpgQlg6titwgABuuAGIjOBRtJNnNj+k7oRnPCvESk?=
 =?us-ascii?Q?hX3ppEIDspeXlYAQUXzWVJ7gjYeWgMl0kQwG4jvQFrr0bKNcrpC0xOeOxMi3?=
 =?us-ascii?Q?Uzin3G8w2JklZpdM3JwWy1HkfaynKKPz4hCwbOYTacOwkzP4O64Lnhx6dk5C?=
 =?us-ascii?Q?KNjqIbx3cYvjaRd2DKGJFNkUm+f83VNFC9r1b9ZAuerbaxfIBQcnL3KeP+ue?=
 =?us-ascii?Q?aenSrLR9PcSN80lrCpnACKsmXItd2bgZnqrn305n/CFxivRABuNrsfi3ObyG?=
 =?us-ascii?Q?sin/IDUTR/JyokQ8OufGYm2+BPV4E64zuxhMHB4NrOuwA+9j2leqbzCkRJcc?=
 =?us-ascii?Q?pw38LYgDdBfHSY6IeQ2onNgTHNiQ3u9td/MJt/Og+WgfSlPI5mpyIroItsVB?=
 =?us-ascii?Q?KCb1yJH2iAhj1jHQsXXJ0ThZj132rarEFOFpQayOC3/YtxqDZAj+VcC8ltIM?=
 =?us-ascii?Q?7t+5wKwkdHzObPR3nBX2+UlYPHkQ8viITmXvSfN1A6TeEPcIqvYkoyCVXYXs?=
 =?us-ascii?Q?GR2lNHyw3S3TW+GmklLPMn/2DtXbe2naFneXwhKiPu9hibeZmx9FP92snpDM?=
 =?us-ascii?Q?RTXkHmH3dzibjTuKVsjqCElI0kmPPcpF1conWcUfeYwEiwr++7nGaX2UDTKx?=
 =?us-ascii?Q?0/5jQUN1FyjK/Hr3lPWgSEaKQ3ni70c285SiLLiI3eLofgDOdMEE63lPtEN9?=
 =?us-ascii?Q?NPLP7k9IAC+7Z3+m0DR56SkibqOYYtasCKP6UpobUWex1Ahu10XeslZMotgF?=
 =?us-ascii?Q?kQolZhuG5v9vL+/cSZEb+bolSmnZnzhNx6s8Pj67K/bADOuCacRIc92emYef?=
 =?us-ascii?Q?tHcEQH0CGINqR6s8+DoqQBtT2Vp7I3ChM79dW1v4JL0Wm0FXyrX0rMdTBgt4?=
 =?us-ascii?Q?pGcMNPkVqsddO3jOIA2PY4HqWRFJVeEMhna59RxkaX1ZM5Li3kSPLtOGbexw?=
 =?us-ascii?Q?DvRGjmklFs2fm07EtJeJGP3iS/lTzUa6CzIVZkloaZAup0N96w3E1rfUsjSi?=
 =?us-ascii?Q?H/+LINIaAp72hew7lSrqlchJ/FGZ11ZFMwSnmxnQTZOUxIDSFxuzKOS4er0+?=
 =?us-ascii?Q?GL8jp9s/0GhOWr1wvjNwHugM9boMA0kDOiuQLrmxjNeV5oW4yMmrRC2oNeWQ?=
 =?us-ascii?Q?hjG/pA4L/G80X7I6GCzoDLdUSE/ipQ+p3tX8oZyymMSH/GZ7JEermULXYR00?=
 =?us-ascii?Q?8CNoV3DYi6xD7bRaWhKn4WhSPmiRRJd9xOE00i2fbymxqyh5uz96HXgi9z8q?=
 =?us-ascii?Q?YrSmyz4bdzDXQzvOgCw0whx6EpxlA/UPoDi8IbHLk30O+8DGmT80hsYzHHf0?=
 =?us-ascii?Q?/AmZIyHPThjDeF/gsuPGFIB73sT//Kusv5lAI4Kti/ER7WXhM7Rt+AUyeIIP?=
 =?us-ascii?Q?tr5sCSjWeBFzrXSRoCW55pSNPEoClYa2tPtV3ZSwZ8t29T467EuW1G0dH1ls?=
 =?us-ascii?Q?GbYsP7RtR4+pLugHeUioyk6hAZRQ5JdS1Q8R6aTyEtutDqIQ2QAQemfhOT4S?=
 =?us-ascii?Q?MfSJp0RFTZSgDyuz5BlHgH0h6mTnJPufdN9H6P3F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e9f31d-74f4-4ec0-b1aa-08dd9f84faeb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:19:25.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZicrpwGVZJEejaPprFtBQCq0JoR4BSOYukJaiaDHlGmPkpFPeST5lb+isgPMe7ye1nrIXtSmB5sDKY4z+KObfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6377
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 May 2025 14:19:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18958

On 20.03.25 08:43, Claudius Heine wrote:
> Hi,
>=20
> here is v6 of my patchset.
>=20
> I fixed the issue I found in the last patchset, now the `format-if-empty`=
 process is a bit more power-fail save.
>=20
> But I suppose that if the luks header could not be written fully, and the=
 `luks` fs type is not detected, it might still cause issues, but I am not =
sure I can prevent that effectively.
>=20
> Kind regards,
> Claudius
>=20
> ---
> Changes in v6:
> - luks formatting of format-if-empty will now be redone when if it is a
>   luks partition without a TPM2 token, this makes it a bit more
>   power-fail save
> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-pat=
ches-2-v5-0-fc62d4a2ad29@denx.de
>=20
> Changes in v5:
> - Switch to use TPM2 protected password instead of static initial
>   password for encryption
> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-pat=
ches-2-v4-0-4170912e5261@denx.de
>=20
> Changes in v4:
>  - improve documentation and commit messages
>  - reorder commits, to put re-encryption recovery up front
>  - extract static temporary encryption key patch into its own
>  - switch from lsblk to blkid
>=20
> Changes in v3:
>  - Rebase on current next
>  - Extended `noencrypt` documentation
>  - support clevis tokens for re-encryption recovery
>=20
> Changes in v2:
>  - Added more descriptive commit message
>  - Added more descriptive documentation about noencrypt option
>  - Fixed typos in documentation
>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-hoo=
k
>  - added re-encryption recovery patch
>=20
> ---
> Claudius Heine (4):
>       initramfs-crypt-hook: store initial encryption key in TPM2
>       initramfs-crypt-hook: add re-encryption recovery
>       initramfs-crypt-hook: implement 'noencrypt' option
>       initramfs-crypt-hook: add 'format-if-empty' feature
>=20
>  doc/README.tpm2.encryption.md                      |  25 +++-
>  .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++++=
++++--
>  .../initramfs-crypt-hook_0.7.bb                    |  12 +-
>  3 files changed, 146 insertions(+), 18 deletions(-)
> ---
> base-commit: f5661b18b9721eee984ffc3b75169b40508469cb
> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
>=20
> Best regards,

Seems this got lost after 1.7, G=C3=B6khan just reminded me. Any updates fo=
r
this in the meantime?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

