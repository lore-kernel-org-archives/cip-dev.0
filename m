Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26858D116EA
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 09:52:19 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12684.1764323538022805927
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 01:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=p6fQPvSE;
 spf=pass (domain: siemens.com, ip: 52.101.84.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVET4gyRVA61jJUjurBeNjwgwmCpm27uGS6KeLGcNYvI/nO5xaQLclwb5kLd9sOcl7IN7CR7+6W3GTs6i226Xs6JYlGDqVGduMRqDfvFy4jayXoulM/zIoAnw+FJKJ/YYm7ilFky+JsvJ51RHBwwBqyegQRj3BccXQfOKwv9WKGl8FXFwL2hLlGcBWE3frXe3R6CWuJtdBsUob8bTqzohh8/R3gd4ZDY5JjMP6txKxZupQb7sRHSeFFcbD/qYZFUGBEkr7c+EGRNjObacuERe/TwR6tCb+FNMJ1j5SqX8QJqNylpiLirXG6yBzvQn9oTAPqzlor/wZRGM+GknEpkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLHiN0Bve6VhFYRyELY6Bm1DAwPH9Nn/AqAyB+Wae5c=;
 b=APU389QODQy532UQc+PuX0n4Fvid6Xq/nAGFN5CdweREPcrnj+FeHJttmICXfQh9TcsU7t/SfcK71isETIvnOJHsG9ps59ptHDyh1l5dNDtAcQrO4WWq4sHwoxscKCIdlUOCW+hgoX4lEvWjMdQF3/qvUefKSGtLXqHpmnpogu/ZUxH3ZtlNv9yeL+KOvzKVjA0PZbZ5cCEPaBmv+HwX3uYllf36uUfN4owsMQzWbPYYf3zBml0FMcPLKu4Hbd2XQLHtAVkwXQEm/7JcK/dE8WOjjHEzsIptwJBftw0G6Xcnt4Um6bHCS0DbFXiTaGCYJiB7bpIA6QcVvLv1mZZNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLHiN0Bve6VhFYRyELY6Bm1DAwPH9Nn/AqAyB+Wae5c=;
 b=p6fQPvSEfcIrNwW7lFqIBHhLju3jAvoO0j6xV05E4xIhyAtCoCn855D3hAmmJtPlGn1pK/JCepgCaV87n0sx/YMlj6VkhjloOJaGtnMhkbc/4gW2k018mos6FYLEpyWqmQxyNa32mS4Owgf/FBt7yp/6timTvMSKxFSQw/vq2YwStfI6h8rjQev0juLSugks4cVly25v+N1KKncuHfuKUDzgQMFTVHgIl+gMU3tBFJiity6HZ49z8JpHGEWGrgDzLVl+lhhCSSOZaRnCU+aBc6f98RvAyqOGR48XurtQ4wFyGzvFJF/EYfJpkjSWCraPxl5bff96Hn7XYxD00N1CBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 09:52:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 09:52:12 +0000
Message-ID: <64eda5df-e366-4ab9-bde5-20d1e427d043@siemens.com>
Date: Fri, 28 Nov 2025 10:52:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
To: Shivanand.Kunijadar@toshiba-tsip.com, gourav.singh.ext@siemens.com,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3228:EE_
X-MS-Office365-Filtering-Correlation-Id: 1968f78c-e2d9-47ec-b76a-08de2e63ce16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BlM/8g/NS2psS9KRmhvmj/j8ce4m+QlbimtNHwaVPq+3B5YSgAQBWSnTwaBB?=
 =?us-ascii?Q?bSsj+r4lWosRVeSKHY0e4WdseBa7TTmzNyUQxwh+M6QAid6mcxjRbvw9SwxA?=
 =?us-ascii?Q?sIQswAsiaRUgKxtQ9XMmZNns+C+z+5m6y/0neq5vleR7+jyaPWQJVE7pmFyA?=
 =?us-ascii?Q?YOUo8cpxNxHJ0IvtCl/IL8fNBQ26x8+Kt8LoGMxlfmP+AcNbNjKPsS1+Raau?=
 =?us-ascii?Q?ifQ29qCPj5A8bXvmBJcYik9s+3SaC+k0nsrniGQ/JpJiQQsfl2m8iq89Y62s?=
 =?us-ascii?Q?UmTBYc8iJM0GaefqYq9xQ8JK3NRcJl4PeaA/5o9G59ijJMJnn0uUYQiArP9d?=
 =?us-ascii?Q?B9hfhQ0Stt+17RUU4iwkNCyBMrL+N4fm68Ok0qrhRMENiPCQTGAeQ85/KLUx?=
 =?us-ascii?Q?Ac5cnluPfqpXqwPeFo6btCVLM4O78RLD5GKNwjfLoppnkxNanx5SiUuPVM1Q?=
 =?us-ascii?Q?J3Q1KgDMhCCqGaWa5RFabo68JCRO5fNn2XDSzrGcJUeIqBMUSPt9MZLJwOEn?=
 =?us-ascii?Q?OAQmZoHeYCCUGvol7IYE2uHb6ytI0D9pItptY/qNSGSUNLHOA3C+r/3S7QfV?=
 =?us-ascii?Q?xAhP2n2txFZPJkAk9IGMP2fxofEbLps6QycicMXyypuao8smnG1jQcXM3yez?=
 =?us-ascii?Q?9pFqxca2IogL+RHMtlMfInf4mWfqCQ3vgi44NN3ctvyK5bEeqszUO33a0jy6?=
 =?us-ascii?Q?gcVxaLOCYX5AKvZSPY5dZ6O/OLa1SqaCR696PMvTRz3MlGFMwLWiDxu8Xwwo?=
 =?us-ascii?Q?Y4cCaajFO7fE+j+cEo48zejKZxtza89IPcE+YzCv/448WQ58hyo64Id7w1n6?=
 =?us-ascii?Q?Wd2sagq3ipvOtQ4AY0rRtrowup38MCVwt/eYnumo5lf6I3yCVzfJCz8obiX0?=
 =?us-ascii?Q?YIvPRsyK+pY8R6txh4BRo9qzFgO9G4/u8QjefZ4NWqZTLjgnBRAtzKSO0E4c?=
 =?us-ascii?Q?6yiYHd8KQSb8lbtE/RBceli4eh6Jo+/vB/ZvZt7FptPthAzTZTviUv7VzfHs?=
 =?us-ascii?Q?TIv1wV/9HO3IbFspxsszPBMmCRYPIRndxu3js16wa8K+J7roX1Nq0W9ZCELs?=
 =?us-ascii?Q?81Q63jmVuNfk/leZNOglaIRzae8PmcH0JKWK4hFOPuiGrzG9SsIrwnj0Wzmo?=
 =?us-ascii?Q?ppBK0zWMXI/Fxi9SCq3iqSOk51B74CqRgo11aQ/gYWE0ALt0FF96rCXA5ts8?=
 =?us-ascii?Q?KbHx/JvGncKPxWSW1KNg4wLnEPHNKDQWzjp88LzBX+p5YoUccE3qPzU/tYb1?=
 =?us-ascii?Q?aq2HSY9ajRoueFnLvvJywtaxxX6JehclZCCdy/braYuNOn0hIeNClSXuLZMs?=
 =?us-ascii?Q?4sSMJqJYapa+zrDcqeVP/vmvBzxvorT9HuNw0LHXTitH1tqXAwIyptfLei+0?=
 =?us-ascii?Q?KbfSL38VDJyHacqgAYMPsa7qJluhgyzF5LvLk7OeuyvSD+gIRJnWln2b5QwY?=
 =?us-ascii?Q?31fWaZfzBDFWiEDFWObpuN8R/QWPlqUC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WQuygd90B+jJBkCP7XLuW4ia+AXJcYqyNSu0a+rSFRq8uA2Ro93gk/JqRo12?=
 =?us-ascii?Q?0Yz7UvieZcKtjsACSHijVkVAznDGkdPVXCbccW1kEJjLfeHczky1lgbKOzd8?=
 =?us-ascii?Q?zQWLnBx2NJTown8VMqz6GyDvZFDa+GgYbmlPZyNkJr120z27kKkRN51dCV45?=
 =?us-ascii?Q?YHtqkFWgWDs9Q8LG6TjbflZFi+KSiAK35jhU4UHvc9YQRIirj2IdSBndnNKp?=
 =?us-ascii?Q?cW0fq/zz13PyDkd81cPT/TdiwRbAfcQy3uprWKaHqIpyoqJMd5qFwkWHg+7d?=
 =?us-ascii?Q?V2iPPX2ro5mqamUbcfG+tKpwW9dao1kb21OGPqLki/V+1v9zUqz7bqEoJPGn?=
 =?us-ascii?Q?ebUonnienD6Zz3etAf8aBJD7ukPk0t6DrVfUeW9dSsVJsekm8smGuM/CPsuc?=
 =?us-ascii?Q?1qysHrX7kvIOEOK6uPYHgOkRkpDexTuxGK/7fkl7zT4TkrzDpx37bibKcJzF?=
 =?us-ascii?Q?ZXHnkUudsYTH47IL8EsLYmcunoqo3voR5567HrT2uLhUerxZngvBebCXDxkB?=
 =?us-ascii?Q?6zYhq0aXZuuxvzmbHBPS4ulHjEYCaTyG/amofAZCPTeJnV11j2Cga2e6a48C?=
 =?us-ascii?Q?1HmQV862Jhqsvj1Nknon5Ax0Zwy1/n8jUWMjvQIswJ+kqDZDgCXqDuvP2vW0?=
 =?us-ascii?Q?VMhAv1nlRL4NeNF/ctMzZd/6XoJMXpPhRd5jlGZRE81RcgysEIsJ+njppuzE?=
 =?us-ascii?Q?lyUqhaUSrf3byWrlNpLJJxnPHtlRd3KP/z/gMpjI0xy7T+sKb2mfATmWQ4Q0?=
 =?us-ascii?Q?r+KXkhn9Lmg2tUpwOrMdJsY58B99MjT59nTGz+0nNKSZ9IC6RWT5POgmfjmI?=
 =?us-ascii?Q?yYeKYw2kwAhVa6B3KgURVxtxddbtFMw2NTjqn91aY6k8h4p/EM9vbXHksQYl?=
 =?us-ascii?Q?3vPR3kXEVgX5kbGEa4UABNuwVh8E5ye/iYlurWn+byPZAuswcCAnKILr6tEq?=
 =?us-ascii?Q?G5GpDOuXOd/UxUwuF7rKWXNF0T76EHyxaQXxUnxDG/KWCWBDw2ikzE9vNvId?=
 =?us-ascii?Q?D/t6diNe8lGRIgPZ+Gk0mtodSv0a8ZxrEd0fS84vtCbXDem2L1iO3wvuXrAp?=
 =?us-ascii?Q?o+8rRlZ8sF7PW0ZPwIb3MTxjssnLyNYg7MfKRLlP/p3nIthHPVDhnhsFQ6YZ?=
 =?us-ascii?Q?6BfOdIlH4hANf2r5lzp4cQbpYyIIGVP+xtzpuvFAnnlmjDiVwQbQLUgCvQGJ?=
 =?us-ascii?Q?vLcl0qpLM/WnQqhRkhhxRpESKImHqrY9qK4sbtcy8GuLfSseg68IGfGxeiDY?=
 =?us-ascii?Q?LIxZzfditwb704HxZytTbr1V9hl7Bt+mEZBytQfeJISfU289oEFBZWDtLM2K?=
 =?us-ascii?Q?DDv39QbLLx70OtSZblps2G8KajyZaL+loMBIPOwQnYqXzMdXINZeQtyYj294?=
 =?us-ascii?Q?kDP5cGka3yQFnfUREA1v0eeSVkUNtp710wGvhP3AyebsCIi1c34AYYicyx6N?=
 =?us-ascii?Q?h9audPLWtz0R/S8e8Qr+l0kCpa1NK0yyIsVN72k28XrIFIHGKiyN0i4FsI4q?=
 =?us-ascii?Q?4BfAOmjmMyhozgG1yXY+QTRjlPVVQt9X6A4kBf30vD2Hv4pBY1J84k9eK+LN?=
 =?us-ascii?Q?JG8IhL0ZPKeJmV5Y0YmWyIn2sQfdeu7upRvqBG1M9vqre00GJhAFRDPhE1Qn?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1968f78c-e2d9-47ec-b76a-08de2e63ce16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:52:12.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00d75NUkZKEe0QQtJm+AugYeUOXaKMV38l1UzLfNGLUF/fBUTKsyk9hhmK3GMnxTWEnTwJPLUnZV9BeNwwauOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 09:52:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20761

On 28.11.25 10:37, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
> Just an update for IEC layer tests on trixie image.=20
>=20
> I've created trixie based security image for QEMU by applying this patch =
and executed IEC layer test cases.=20
> qemu-arm64 and qemu-arm --> No issues, all tests are pass.=20
> qemu-amd64 --> One fail test out of 44. It is passing if I execute it alo=
ne, the reason is not know yet.=20
>=20

Then you have likely already seen
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/321c401d1de7=
63ab9b7c7afb0c13d26f0a70b7c5?
Currently testing in a smaller set, then the full one, and then I will
submit it here as well.

Jan

> @Singh, Gourav Thanks for testing.=20
> Let me confirm, did you execute IEC layer tests on qemu-amd64 and shared =
the log file?
> =20
> Thanks & Regards
> Shivanand K=20
>=20
> -----Original Message-----
> From: Singh, Gourav <gourav.singh.ext@siemens.com>=20
> Sent: 25 November 2025 16:39
> To: Kiszka, Jan <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; hayashi k=
azuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=
=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayashi.f74@mail.t=
oshiba>
> Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in =
Debian trixie
>=20
> Hi Jan,
>=20
> After applying these changes, the IEC test suite now passes all test case=
s on the Trixie image. I've verified this on my end, and I'm attaching the =
results log file for the test suite run on the cip-core-image-security Trix=
ie image.
>=20
> Thanks,
> Gourav
>=20
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 24 November 2025 22:07
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.c=
om>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.ku=
mar@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in =
Debian trixie
>=20
> On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
>> Hi Jan,
>>
>> Regarding customizations or configurations for the `libpam-systemd` pack=
age, which provides `pam_systemd.so` - a new systemd mechanism that replace=
s the traditional `/run/utmp` for tracking active user sessions in Debian T=
rixie - it is necessary to ensure that `pam_systemd.so` is included in `/et=
c/pam.d/common-session`. This replaces the traditional role of `/run/utmp` =
in session management.
>> Ref:=20
>> https://list
>> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=3D05%7C02
>> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7
>> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkno
>> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
>> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzbwdGBW1zzz
>> p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=3D0,
>> https://ddp-
>> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the-
>> last-lastb-and-lastlog-commands-have-been-replaced&data=3D05%7C02%7Cgour
>> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3b
>> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CTW
>> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5ry3XapBLPScmMpiz5
>> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=3D0
>>
>=20
> This all makes sense so far, and if no one complains, I will merge it soo=
n.
>=20
> I furthermore assume that our IEC testsuite will "just work" (again) with=
 this applied, right? Switch-day for the CI to trixiw is now Wednesday, or =
more likely Thursday.
>=20
> Jan
>=20
>> Thanks,
>> Gourav
>>
>> -----Original Message-----
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: 24 November 2025 12:21
>> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)=20
>> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
>> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;
>> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi=20
>> <kazuhiro.hayashi.f74@mail.toshiba>
>> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
>> in Debian trixie
>>
>> On 24.11.25 06:06, Gourav Singh wrote:
>>> In Debian Trixie, /run/utmp has been removed, so traditional=20
>>> session-tracking mechanisms (used by w/who) no longer work.
>>> To restore secure and correct session accounting (needed for=20
>>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1), we=20
>>> can add libpam-systemd.
>>>
>>> This ensures that PAM can register user sessions with systemd-logind,=20
>>> aligning with Debian's design for Trixie.
>>> See Debian-devel discussion: "/run/utmp is no longer provided in=20
>>> trixie ... replacement mechanism provided by systemd."
>>>
>>> Ref:=20
>>> https://list
>>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02%
>>> 7
>>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C
>>> 3
>>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknow
>>> n
>>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>>> 4
>>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239zR
>>> 7
>>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>>>
>>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>>> ---
>>>  .../security-customizations/security-customizations.bb         | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git
>>> a/recipes-core/security-customizations/security-customizations.bb
>>> b/recipes-core/security-customizations/security-customizations.bb
>>> index 717e2d3..d8fa22b 100644
>>> --- a/recipes-core/security-customizations/security-customizations.bb
>>> +++ b/recipes-core/security-customizations/security-customizations.bb
>>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,=
=20
>>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer =
Debian releases (post-Bullseye).
>>>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
>>> =20
>>> +# Append systemd PAM package to limit concurrent sessions in Debian=20
>>> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
>>> +
>>
>> So, no configuration needed? And does this obsolete any other dependency=
 in trixie?
>>
>>>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>>  do_install () {
>>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>>> ${D}/etc/ssh/sshd_config.d/
>>
>> Thanks for tracking this down. I suspect that our certification efforts =
are still focused on bookworm as baseline, but this is an important step ah=
ead already. I also hope we can soon switch CI to trixie, currently waiting=
 on lava-docker updates on the workers.
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>=20
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

