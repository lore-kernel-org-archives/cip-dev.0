Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3421C5B549
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 08:25:04 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.37])
 by mx.groups.io with SMTP id smtpd.web11.44562.1748852698925616709
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jun 2025 01:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jZMwqdUw;
 spf=pass (domain: siemens.com, ip: 40.107.162.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF68wmiXIxuc3s2Wc5uAwaweWISR63RNv1RYabOWg0m+FT3zMzHMhiWugVTy572OHGUaR93EKKPlzLp2S/dMtMA6OWe1gpopAUyl9p1BfVkfoHY3oLccgnN/3hnjTt2tGOy2d15NLp9pNhgin8vk5zjG0Ip7W3EIzCKOm2vLbkFy2tj1kcw04KzEtJWX0LUGBpLQyycw/D5AuHjJXPJUfCWlp6arzQLksU17SuzooJ0aXZ4sKvw6N5qcHVlkpHn6F0W1ZLBP9xpEyiaBY9kD9/MjDZ85H1jRuFCjUcC/BE4OYSCr2QAE9NRl1lE2dEzTiUIQevQqwvtWl4KRgHIknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE9xpCavr5WRE0/VcXBQf7kTiIs22uRoMBBkaaU7MXY=;
 b=H7Yb3qIN5720lA4FeDLNe6NUvnZIO1640oeSFK0v2pCriCIomFhyD4d/sk8z5K0RxZVM1Bdbnn3JgV2ztrMCmtyldbbB2eAn3MR6oL4xJ4Iq6AMCPidunFFBmj562tHSaVTNeTxmAO/va4UsVjqzjBsK5nHXT6Kx85aL2wqzYyqFE25epfS31BStji/5G79TVFH2UYUQ7W653Ujlens8OBecMua4V1put6VnWTf3EokJCcIMf5ULZMaI1Eb5KXVsvQ02ZJQO+xG2ewDFJ2OYInqU0rQHofi3XwRYCM5Uf/6O0NkfmslZhFbNOje/vO0GiEHdBX5Cr0GhZpEBfWeXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE9xpCavr5WRE0/VcXBQf7kTiIs22uRoMBBkaaU7MXY=;
 b=jZMwqdUw3AFffx6/8Z0voGehZ9StpBwcRYd1DT2jFOPvBk+WJKldhs9H9Fv+9UZIsDPh0cD5N7JglHqvnia5C8FrZN+cQLno+MvJxZOvwpdv9OKTdqh9zB1qebRQZ+ItO2prSxdPKJHchc10LwB+V/HCF+CukuQass9Q2kEqyF4maQKEpqoPQ5uQV4ypbvM2ClgZF7M2czsXH15ESscyeCowrZCnJbhBnAUBSGGilTWeXMmLKBfkYGaaORP0GVTcmy1stWJUZBIW+MzqiRg2V7GTfDa3zecoxV055VM7rOK3nHXddqBbFpKaIyN7gYpi0x20yBZkicZzcrroSAVKhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 08:24:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 08:24:55 +0000
Message-ID: <a22f282c-efea-4cfd-9870-118e1950b828@siemens.com>
Date: Mon, 2 Jun 2025 10:24:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>,
 "Cetin, Gokhan" <gokhan.cetin@siemens.com>
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
 <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com>
 <DABWFSN87AVE.H2RGOY175Z6S@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DABWFSN87AVE.H2RGOY175Z6S@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 882d6af0-02f3-473f-419f-08dda1aef481
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oUUJUaS1lPW2cpoY4w1b/DaPQLw3uG8ojY2nWiz0vewr5/nHBJH0zzS9Ee83?=
 =?us-ascii?Q?FEzpBimUxkdbGgO+Y2yg4dCQYlmsENw9M40XjqHYBBxF605N7cpxznw3wqbW?=
 =?us-ascii?Q?zd0upVFKh/5qn3cKn+xRJHnZ+jqPYsu1ehu90GLmBnIyu4r2MArCazzvntjn?=
 =?us-ascii?Q?CmtPi0UPCzS/ePIeG7jmIKZLKXUxoz9hXk5Faam/Id5sdg6U6OgcPzuj5vSW?=
 =?us-ascii?Q?qgSzWkNV8NmpQ0o7jLZj94e+uR0LWz+PNVfb3NVKiwXt0ug/Pgegy+bQycfA?=
 =?us-ascii?Q?GTsUQXwiQYEgHiabVXlyxY9VeOPoNrq6RaGU2Bze94PTCzM7raQQlGk5A9T8?=
 =?us-ascii?Q?lF0IK3HbjfUm8Dev+CqN6UjDQLYfqehTYYzJ0ysg1VF9dwX31BxOXx6qiNO8?=
 =?us-ascii?Q?4bknMrELZgGu/Htew+9jaBJ5CUEaCbA8HwYzyp9yYPq5FgmCEAqzeELZcNlw?=
 =?us-ascii?Q?2zCNbau9BK/s5K2VbMozw8EJNgHBLndgnNibspLczn90NT4GQFpmx9s/negm?=
 =?us-ascii?Q?W/ipTYi3Li9wUbWH+FheimikCvsZOikjTSVhhrUCt8iypfdXDYck6Nip528Z?=
 =?us-ascii?Q?eZDA69PyBGwOj6VC4wSV0J7AWosFVd7P4tadB5H6sMM0Pz4aiPS9Otztd/56?=
 =?us-ascii?Q?2OWIh9zuKK5HM2TJQjioAGwS/U6OzSLZcp1lSiYWmdZUhDQpujv99R0JSUgh?=
 =?us-ascii?Q?E7ofhI+7LCqkoRy6CPn5eaXMifmeX78bi70QKnW7anMBcU8NdbyRd8LlOZic?=
 =?us-ascii?Q?pVkAjVzTjsyCQjjdMhrzzzuAdDG7Z/vD15PA/Ga+BxvVx0vS+obLsqZqgXK1?=
 =?us-ascii?Q?LY1uNRHjn93vbBWmFXRiIyfxD9rhBhF/a4Pe0oJ9KUK2lK5tEBi2jyC7CLNi?=
 =?us-ascii?Q?l8HRUOCpO/d8u3CPrV9M75BQQprV/ZIOzbyHmeoSjMsGHnG61Ca2QZzCcbOJ?=
 =?us-ascii?Q?t+jB/sUbSDyZRYVcLDdcuA5b/7uwTRZ+FYUSEytAWIjMAnUAqUDhjoB1WjBO?=
 =?us-ascii?Q?1EN99MTW0afD9flSu5/tDSLNRgnd+38KbxQgiZkB5fJHjR8ouyQqjJzrBCEt?=
 =?us-ascii?Q?eE40oWBXnbKoC5/hVUZ7+cK3rBIXpaNAa7C3WP0OWORrgH4wKSXP/8gPTNz0?=
 =?us-ascii?Q?4jT5VKUa7wGPAOitbu+DqdIi73MeBwLeNDl+Ljgkx0f39lbiaJkONGKxHOtb?=
 =?us-ascii?Q?zHxC22uJjXMGNwYZj8YB89RqmfzvQRd8XrhMv+YR3ABSNZaHJMh7CivBSQbq?=
 =?us-ascii?Q?F4DjswasZbg+PmrXiaxHrAI5uxmjOXNiMZCYkwVaMO/uhEHc1eG7eIJm8+iB?=
 =?us-ascii?Q?z3LslafjB+zkgrkIumt4OHqzWpIC9RrkWHfDyiTg4xCH1aDRk2J0m27sBRXs?=
 =?us-ascii?Q?cGxtv0kT3wZfE2cZA1Vj8L+tNNXIUJqNTna5Suh39yqt3FaMhd+C52612kp3?=
 =?us-ascii?Q?NhBfsy9l95U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K3Z0ulBYOCvQyHy2Q1KOn8ZqGlVTAMH4ui72jw/t4nAOfkQMbTUXqieGELtM?=
 =?us-ascii?Q?ZR1pvp8YfUxKIIz3GHhVapasVFz+dI56EJEVmPjZOAEawvHvVo0ZmKY+xzgs?=
 =?us-ascii?Q?B0SQsbkCjy4U3ARk6j8es+IrfLMp+JW/5W225NfgSLcwsXOUc1k4BDQyYH0n?=
 =?us-ascii?Q?JY9UPKDRb5ohyKnMkNQYi9sAXs9UPs7rWBrRpEwdHVJYLHgh7kVY/gcMOWLg?=
 =?us-ascii?Q?mBo+G6aAmhZl7NfzR+I89uocGT5S13xoZcga3LgUtIowQxFfzw1oPPsZqd+x?=
 =?us-ascii?Q?LFUlR/6uKEoNmpqz+OKQZjxfAn4fCUEtyrkcDTXTjQgVGMoVJL7DtpCfB2ZQ?=
 =?us-ascii?Q?hOMS9wZ3aoTblwjUkypqtBsDogTMlVsILYJRJ5NzDJoX1WBHTEdJHVtO835H?=
 =?us-ascii?Q?McjDydczgKhAWMJjnBcgqZqeuIUt+5Qh3+nwUT6OuvGYS4u1pCG1fE2FvzNH?=
 =?us-ascii?Q?fdamUyheJFVsIigBk99lLCFp9bWCbrg/qtSTNpeHjdH8lcHMkscKSLRLXRBl?=
 =?us-ascii?Q?WP44raC/LnHknWuhy6CKkBDJ4zbMBMGpQxtb5H9yXDiyy2ry+N89XcWd/YCr?=
 =?us-ascii?Q?919bzsAz1Ypf3UHCK9j2LMrwbNAFUcK54Ct8xGsr/4scmFiGhXXvUQmeSBUA?=
 =?us-ascii?Q?C30n7XfOrdx9a9vNxqP/rHjE2uKA1XBHiqxxvUL0yXW+TmxDdaYW4AhDn54d?=
 =?us-ascii?Q?L1xtoVx49noLBKzRJn6kl6+QBCmFUjmo1rZWBHqXv1OGeIdIl6L2/rgQtLH2?=
 =?us-ascii?Q?oo10UQbfHu7KSaZk1LtROMVG21L1EWUig9cVBfE9uIoCmahek3Bj1WfHSosb?=
 =?us-ascii?Q?+POsH76DWJhh3b4r0+HSJweABEbzgAU/J4gkJDhac5NutHpYQHpYR27nz/f8?=
 =?us-ascii?Q?Wn7Y1J63hQhuR78Mv/Xx119CUJoePRjtAn4NUWW/t3sm01sVCS5o/x08uVo8?=
 =?us-ascii?Q?d6uKNfh2XDbCXYO+LvYrZMximCXiLeDLuFJnvS9imZDBtz/F3mdOju6+NVHJ?=
 =?us-ascii?Q?sIbRPzrtHqw0/HB1zwrjAWOcmotN6KoNrY5k1HrTmhoMpSwRsffgahzAnzKG?=
 =?us-ascii?Q?DVnCtWLCBgQc4kDvJWaSLy9HvLDwNW7SQpCtbKT/WPq9WHsL8c0uANKFj0A6?=
 =?us-ascii?Q?t7lMCtxM4S8rd4wTxUmQHSABKV1bualMObXbmk6+i2wGry+Zw1Qp+idf8P5v?=
 =?us-ascii?Q?Xo9hsg//wcYAufqOZE+jxt7hx+XvzB4KfESzBVIf+TI0+pWe4UxvpXXWijCu?=
 =?us-ascii?Q?bvPfWPXY26+7DZyWKwniXRnn4GjNBix4OAqyHJcfgOuSEMLcNHMg+lrsxyNP?=
 =?us-ascii?Q?sCodkYkqjifDhA8wEGMednAZ2jIzFV3n5vscUkdR058hbuXeauF+ZyipVCZF?=
 =?us-ascii?Q?V63/ij6164Q+6RJxELzxRiomkwthtSbTK8vRaKQb1l15yHPPMX/6BUkf2F7O?=
 =?us-ascii?Q?W59IBCHYiF0bbRfUBgoTEcM7/wKhN4yNAQaA/Or98E1bO9ybeLKDj9GxlJ9H?=
 =?us-ascii?Q?gG6uECz8U8JIgnLBDh2LZmIN0hciuEx1EW0l4LOuKF2TLBIJ8vGL3F0TBWy6?=
 =?us-ascii?Q?x+0XCP1cSpIxsxMbweOabZVEJ5nbpGnzjRdhDYFO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d6af0-02f3-473f-419f-08dda1aef481
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:24:55.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBMJ83SL+Qz30VIC5TP1lFvluW6gM4Ymr49yRkuzm/QGcytHojOxmWClr94RekqgCQr9k1vC4Zrn1NIXAJb5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7069
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jun 2025 08:25:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18960

On 02.06.25 10:20, Claudius Heine wrote:
> On Fri May 30, 2025 at 4:19 PM CEST, Jan Kiszka wrote:
>> On 20.03.25 08:43, Claudius Heine wrote:
>>> Hi,
>>>
>>> here is v6 of my patchset.
>>>
>>> I fixed the issue I found in the last patchset, now the `format-if-empt=
y` process is a bit more power-fail save.
>>>
>>> But I suppose that if the luks header could not be written fully, and t=
he `luks` fs type is not detected, it might still cause issues, but I am no=
t sure I can prevent that effectively.
>>>
>>> Kind regards,
>>> Claudius
>>>
>>> ---
>>> Changes in v6:
>>> - luks formatting of format-if-empty will now be redone when if it is a
>>>   luks partition without a TPM2 token, this makes it a bit more
>>>   power-fail save
>>> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-p=
atches-2-v5-0-fc62d4a2ad29@denx.de
>>>
>>> Changes in v5:
>>> - Switch to use TPM2 protected password instead of static initial
>>>   password for encryption
>>> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-p=
atches-2-v4-0-4170912e5261@denx.de
>>>
>>> Changes in v4:
>>>  - improve documentation and commit messages
>>>  - reorder commits, to put re-encryption recovery up front
>>>  - extract static temporary encryption key patch into its own
>>>  - switch from lsblk to blkid
>>>
>>> Changes in v3:
>>>  - Rebase on current next
>>>  - Extended `noencrypt` documentation
>>>  - support clevis tokens for re-encryption recovery
>>>
>>> Changes in v2:
>>>  - Added more descriptive commit message
>>>  - Added more descriptive documentation about noencrypt option
>>>  - Fixed typos in documentation
>>>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-h=
ook
>>>  - added re-encryption recovery patch
>>>
>>> ---
>>> Claudius Heine (4):
>>>       initramfs-crypt-hook: store initial encryption key in TPM2
>>>       initramfs-crypt-hook: add re-encryption recovery
>>>       initramfs-crypt-hook: implement 'noencrypt' option
>>>       initramfs-crypt-hook: add 'format-if-empty' feature
>>>
>>>  doc/README.tpm2.encryption.md                      |  25 +++-
>>>  .../initramfs-crypt-hook/files/local-top-complete  | 127 +++++++++++++=
++++++--
>>>  .../initramfs-crypt-hook_0.7.bb                    |  12 +-
>>>  3 files changed, 146 insertions(+), 18 deletions(-)
>>> ---
>>> base-commit: f5661b18b9721eee984ffc3b75169b40508469cb
>>> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
>>>
>>> Best regards,
>>
>> Seems this got lost after 1.7, G=C3=B6khan just reminded me. Any updates=
 for
>> this in the meantime?
>=20
> From my side v6 is still awaiting review. You mentioned that you will
> not merge it now, but in the future, and I have not received any further
> comments about this code so far.

OK, then everyone in CC should please have a look now and provide
feedback. The good news is that it still applies cleanly.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

