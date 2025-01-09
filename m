Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72843E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 07:58:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.58])
 by mx.groups.io with SMTP id smtpd.web10.42678.1736409527813822270
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jan 2025 23:58:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sG1Yi08B;
 spf=pass (domain: siemens.com, ip: 40.107.21.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGKLi2VpvBpXPrMEjzWSsH/PXkLk/T92HlJQ7cWkwMlIWNF+ka8MGT27UM+wTgCbzqpDR3fmip4k5UdXUQKNnfOezDG2S+GRb61UEQ1Ojhw1kw889uaTJ1s2hOrW2QfjEZSNH2AprUZP9bc+neVYuamzNZJn43lZLzCUW2xe0yQFSAqt8mtLotNTSLrzjoU/aTDHLw5U/x5zu0fqM9gCuKrkP03KtIPx1lxtFze+ncU+hbvNK9FP44pXENw554yeqDMyaoKFf7qm1O1ovRj1+WFFmhPKwDiBQLYI1sALezPQkLIIXuao2PLOzpYCenkoHB3894gmsLGic/9p0oN34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx85XbrEutMwN9yubTTWAJ2Yg0HBdlgA9rSRWT5GBHg=;
 b=lkO5CGi62n+zOmOt/3v1K7tmHym9Rid/9TCQPMCM8tTF5d/EAQ9r9u3IxpQzLvqPQNVw93T1kE3DOWiNEu22w3Vz/mcsP8J8BDntu9BwuuWi0k1MW/+DWSSEav0h7wyz5lPYClZx2bi2+ZgVrGMm/Va8aPbxvXZplnR/5y2YtLXIVRO2dWmhoQjyyYpX8NqX9RKAM+jnmj2rt8nU6OuBSnP7MtQ6qq9EF4a24zAlNxULI7euLI1fk4tiB3672dgKE0YBJioo7N97YSs9gj4TYMOCw+nnxOYMOA2c2Vmxw6jmMDqz/uvc4khlGip4BmJSevy6wZU9ic5c3YKtSIe2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx85XbrEutMwN9yubTTWAJ2Yg0HBdlgA9rSRWT5GBHg=;
 b=sG1Yi08BMtjdHtnvVe++3oL2Y+nI8XcbFRumzAw3IEY6iO3mP1S4vIP608Ox3dTSjj5qZuXOxW/63nswXwTQTf4/6z3HQh51mrkKrHN/pgEPWdgUHz5THR3bzdM6pt37BHGnpj6Qd5HQ0skogdFO2E5qt1JFdfQzTAbwl18kZgBRkbFu+MyOSPW7aWbTweYZumlAWFAWu2ig0sbIBvVotLYQXYmd9D6wEFRHeSaCi0rzKA+Xx9NBeCzjFf+MaX2qzZtlb4oQua6LjpsdK9KvpPeGpvMTnT6vqBGfnGyBPWaT+NfwZGxPHOYyxbsDvlyo6HP8WmtBLQYai4jZyTvvrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5440.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 07:58:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 07:58:44 +0000
Message-ID: <dc5c9ece-2f28-4506-8381-795367273da7@siemens.com>
Date: Thu, 9 Jan 2025 08:58:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Adler, Michael" <michael.adler@siemens.com>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250108100755.55673-1-michael.adler@siemens.com>
 <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:208:69::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e11b5c-ebb3-41cf-7689-08dd3083706b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CLpuCEeIZKfSsKMoDvl9nPn4EN2yyNhffB5poi0YjeNwvSLiGuyc0L02TNMR?=
 =?us-ascii?Q?LU44YxjpSFjmhizlY7SKfbvEtZbrdjLapdbewMSnhJ1ll/S+JsfiMbhxZdCR?=
 =?us-ascii?Q?TEmVFd5ZKwN+EYaU2zRku4TgyvuZ82bL5zFKZQ6NskNbkvvaPNaQt3ptUMiB?=
 =?us-ascii?Q?Y1ucB/LgOdnBHGAiB1CDXCwY1BquwptU2HrrlhioxmvHygxNec1RFTNuVGUW?=
 =?us-ascii?Q?iHt1lwcFmNIab9j2l44yTh8x7BPh162d3MEG8XVWisXoLj6R827nh3uhTWN5?=
 =?us-ascii?Q?PsHfECJwie12COw6p8y4KSWBnG+xF+fizRB2Nr8BNjuhd+5xLnvOXv0K8MR1?=
 =?us-ascii?Q?TvmPzUA0ZFfb4BEEX3wquRnJCGmhpW/3PsLHoHas8a3nw2BUwGt87eGz7shD?=
 =?us-ascii?Q?8cWRuC9dVtl1FgUNwmWUhQM9/6PGts7nPc4kJRmcE/ksI9lykRlpf2GUguUt?=
 =?us-ascii?Q?JphDSQk0ExMt+zq/WyC+FNvbJiXvsaQSqv9SJMiJmI0uW8N4lMLVjS31PA5v?=
 =?us-ascii?Q?JVp6Mk5TG2YJCmoFTsUPYCjnovyTjpwjcKCkGUev4cLEa4t3Vo7FC/0jwd/J?=
 =?us-ascii?Q?j0yvBNEc4Ec7JAyCPFfj4bGYWTps7drgf8MHpcYUk7Q2HEux6NV2TA9ftV7G?=
 =?us-ascii?Q?pZ/GZhvZfsW4aGx+I7v95mxjOJo4wYSDr2QcWhsPF3LRyOqLX2vVOqyEe2OT?=
 =?us-ascii?Q?mJKFX4yTM3vIRRv3uhOEab1kqo0FCwB9GCkfPoWXuhkS+jswR4rZ2j2QKe53?=
 =?us-ascii?Q?Z3b/CCXL+gdtiRD2qvYTsYUjlBNjfR7fSmA7htC9rxHf4TFyIf38AO2QIgxN?=
 =?us-ascii?Q?oj9VBvpv8ChR7PTZUvOETk/A7Co4HSrDHrzS6Qkvd2+41xDlXdxcdQ0HPWdv?=
 =?us-ascii?Q?519CXJqAmCMLQtwz16hjH4eF2gdw/kmIGtGzMrqygq1xRQVFCUkLdMB9ndK6?=
 =?us-ascii?Q?OM0ddJFmzXpP9FK/BoSkJjH9yw0TaqjsfYCFPzqCCAJemM4lNgARXv50x1X9?=
 =?us-ascii?Q?uYjHSguBSVoQKJp4YoJQj4q3fFMP48M7BajhzRtX5a6LfV8NBGuvbuG3bL+z?=
 =?us-ascii?Q?fiWlntMk/gfyWPTWz05tQWIosyiLRO8FgbURl1t2qWQxWLQsrBqZScwTauxa?=
 =?us-ascii?Q?ONu2QHLWGARKfT7+ogiXbeSJK89MeZmZgQpRFRj67GImebluo6gre1COgpJb?=
 =?us-ascii?Q?Mry6iDsd/z0t9PayzN/KeD1IdZP6YJwmdROx877nAD5ZVYr4MTo5QALAStn2?=
 =?us-ascii?Q?q8t+AbS2c7A0dKA4JKj4DiHyn1nyqOB2tUlrjLKoYc5LpXvTQ94lKYrUp+uP?=
 =?us-ascii?Q?ww/KaO7pmeCkD3Rbc0MWXm9FH4PIkBbT+7ScIP0HLgMb6T6FHlXYGxFn15Q+?=
 =?us-ascii?Q?NiHhQ8dCwVn9igLD3wnFFhuLfEKQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3Lde2OvXZti1z1yhi67uOjbc/voxnyJYi+Uf+p3PfzgdMwXaFkv1hmzhTS5b?=
 =?us-ascii?Q?JyP7mqctNyCy3OiJfB/A21nSrvmqkrAqKWEaIzl/Luwu0KCdE6izz6DJa67s?=
 =?us-ascii?Q?FV7CiBGCsDdbWrs45ZtwaY3PC0zOvoGhabzMeny2Eyo2MEc33kyZH1OKyWE+?=
 =?us-ascii?Q?2PlDoO3bClP3CnFNCt/QngRN4jqWctZWd7xR4VmaVrLi9j/+t4LQRxVH3XId?=
 =?us-ascii?Q?a1zdNkyxl3R5iKzFjyCBTrf75lh1HZFYXao1NpoYjFCnNN3/h1pRI34gw2cL?=
 =?us-ascii?Q?yXvd7ksXHn+IwMbqhh7wByxYQlwgWWjHU+i31XO/fVXT8fOIWhmE/YpBr2L0?=
 =?us-ascii?Q?1kJIV64e9vtBRdIGAKPfYgiKJ9s9DUyo9D4Oa4slX3INlaB6XL2kSukm5FIJ?=
 =?us-ascii?Q?5VRWYei0xynzVprMInkEQXltq6L8zxb1YwbUTaeSzmAvq+Bytn/i5jJF602y?=
 =?us-ascii?Q?TBye2Bej2Y7uN4jDQ1Co9Zb0V6U8RUwb7ypASOYLEp4Vdnlz9pBPfkrlGdOm?=
 =?us-ascii?Q?DA/FXFMK+jIDJb9SdsHJ+svODRNrSuhZ5qtgaTltgeeeEzv94yn2M2nhuT0l?=
 =?us-ascii?Q?ISuIYFIT+C/RFjYwOAoatYRh76vmrC7In4MaguDB7pDzgQLbr+gyHfV3t0aO?=
 =?us-ascii?Q?WR+515U8lnpyUSNUul8f3GUdm1eV8R13Vhe8iq6/DBJCDq3iTf+tAJ8THYE/?=
 =?us-ascii?Q?z4SSIbQ9utb9/qSQ5uxDcBl0/25Eq6nUC7ErU7+fPBsHXywJpnNbkgmC5IeB?=
 =?us-ascii?Q?GqEkZSOu4wA4AJXcPQjzNS92FtAYC0857fCQIDOG1mVWwdl73eLpGVfjTPVd?=
 =?us-ascii?Q?lrss2eMPLhTUAg4ZZBSamsyJWp7LeoPNNBCjfkgcJk/YI0vPZCN5q4x57dim?=
 =?us-ascii?Q?anRCAniJIM5x/YFRNmU66wkIdCa8eXxePBctyitwnaP9Noy3MTywBEORO3PF?=
 =?us-ascii?Q?aidz/zXXK5xpjGQsYAO/J43QF/J9ulf8JLEzQ32b3/vU/mjxM3wOZq2v+vGy?=
 =?us-ascii?Q?6Ngg1OP2CMqw/Dfp8grJQWIFWVWYHGkUJKqPiYldBqQt+5zmiXqQNtuMb114?=
 =?us-ascii?Q?WK3p73xYlDgAhrYYum/M/fEUurnBu949VpekbsFNuZqkbqpw7gP2I9wuGdVc?=
 =?us-ascii?Q?nc9NkgkpuEVBgGRlSxS5EBbsVY7dcO2rvpbyqWGTyz3UK/ziUY+J0WrzUyKG?=
 =?us-ascii?Q?FLtV9GA21eVhdRkpKOhQCLSpBxQEY9TGB1FFMbeFUtopsn/iVnb/SyNX48mG?=
 =?us-ascii?Q?b5Ks2Z7FlShPGX8ekrL60tJRxsVfjhYoTPb2ljG7hxAwqo5HKA0BdskRCjqM?=
 =?us-ascii?Q?/fQfIVEQiQa0YBfJSLaA/QCPxZ8IAkBdgyyOy6s330itin+NbHN1aN2oJlGr?=
 =?us-ascii?Q?WMwn+W6dSbDBtmw1JndFiwWeI/WyWIsd2OtWBEMRH8vosU4+YYRj84GyaDK2?=
 =?us-ascii?Q?esPfA4xn+LTzSALbyUPRPvR5gh7RxkRElYRWFC4TgJsoneuFP4R+6pgmDWKX?=
 =?us-ascii?Q?DzyNPDCe+494I8/7BPmGxT20fjJmgfhhLiLr7AC5gecH63/sFEtaLGBS1ERN?=
 =?us-ascii?Q?p3U+PhfaKbzTOJWv1kNTGoIgDNBMA5yAJF1vuWfVNfmUd4a+mdywjh74Wv1M?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e11b5c-ebb3-41cf-7689-08dd3083706b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 07:58:44.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoscnwqi3Bo5up1H+II1gYrSmHPSE0ckBmK2i9yhbnVU8E6+3YXqUrPiPD3iEVrlm2pbKlH/QEWts4PMyuFQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5440
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 07:58:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17509

On 08.01.25 11:17, MOESSBAUER, Felix wrote:
> On Wed, 2025-01-08 at 11:07 +0100, Michael Adler wrote:
>> While the cip-core x86-64 kernel configuration includes the necessary
>> options
>> for container engines like Docker, the arm64 configuration does not.
>> I have identified the required kernel configuration options to ensure
>> compatibility with Docker and Podman.
>> Instead of integrating these options directly into the arm64
>> configuration, I
>> am providing them as a drop-in snippet to support custom kernel
>> configurations.
>>
>> Note: I am open to feedback on whether this should remain a drop-in
>> snippet or
>> be merged into the default configuration.
>=20
> Hi, IMHO this should be merged into the cip defconf. At least the non-
> arch specific features should be consistent across architectures.

It must be merged there to have practical effect: support scope
extension, test coverage for the kernel.

Once merged, please propose a patch for isar-cip-core to bump the
cip-kernel-config revision here (and tag it with [isar-cip-core], please).

Thanks,
Jan

>=20
> Putting Nobuhiro in CC, as he maintains the cip kernel config.
>=20
> We further should validate the both platforms with the runc checker
> script:
> https://github.com/opencontainers/runc/blob/main/script/check-config.sh
>=20
> Best regards,
> Felix
>=20
>>
>>
>> Michael Adler (1):
>> =C2=A0 linux-cip: add kernel config snippet for container compatibility
>>
>> =C2=A0conf/machine/qemu-amd64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0conf/machine/qemu-arm64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0recipes-kernel/linux/files/container.cfg=C2=A0 | 114
>> ++++++++++++++++++++++
>> =C2=A0recipes-kernel/linux/linux-cip-common.inc |=C2=A0=C2=A0 5 +
>> =C2=A04 files changed, 121 insertions(+)
>> =C2=A0create mode 100644 recipes-kernel/linux/files/container.cfg
>>
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

