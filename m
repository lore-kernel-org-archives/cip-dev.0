Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3788C77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 14:53:29 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.49])
 by mx.groups.io with SMTP id smtpd.web10.19669.1683730401918274877
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 07:53:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VnQpiK7/;
 spf=pass (domain: siemens.com, ip: 40.107.249.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeGfR4Odd5bk8ciUJ432DvQvhEENbsLHn0D0b8E9qxPSxOfswin8QM7pUli8eJnYKIRVd7tHlxU7YfeGv0aR1h2RV53itOJkBvAjKzgKR3KfAk4+YeLR9DKzT0jR3Tia/ctdfXo8eoHUtNVe888Kf0aKoSDJTp7Lu4ahVS2/d1/Gg16cY/HABgXfR5ZOcNJvPwbmiRpUUH5vCOkTW9P51lypfQdVtH+D4kieLtFiFzXb5MkmxqqRQW2NNeYStH6hqwU6ipz09HRYUHdiymb+jotbLkMRVXRu/KAvZB7hb1ZuWnpBy9074yEBfq6I1I6QM8b3PaN6T0EqpFo0FMfsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EWv41XZNY9lWaFfQtkDAGgl+7+cYG9c+HpPOFA9EHo=;
 b=m0UTDLF/3z6fR/3N6tjWVbmy0zxTbFBVRhphs1aT7UNRIJw0U+x8OdXlqcs+9Nq2AKAuHx1ODl109XBAaqGnEku5/hRkDSdNSVcRCf5fO5Enatyybko1vb7M0ObRUdxT07V+esrSPC/wEAZbLLIv7YPPVhrIrhaEEJxg9yJhkVRyTNm7m5CduMx8tGajHd3mAzo9yJTOuHHhO/lCmM5PAz321OhGud387I8LNnqZeV55aXFnoZD5jYoIQbHxBkWfa7G2r0CXtLs/m4Ixm/2DcSICXpBBoBBwAFibw7OStYmPoNSiNYsAnZeC2EtS6osG7WiKonAakxmeQZjJHnve1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EWv41XZNY9lWaFfQtkDAGgl+7+cYG9c+HpPOFA9EHo=;
 b=VnQpiK7/POUlRwMRU4EjfugQkC5z27f511FYaIuOU1sIuCUTLv4ZIoRd5BW8jC6BKN+IcRPsp0Zz0F5UFdVhPy4MaF9t3FcXZ9FfhuItb09WCyOPsPwR5tfiFxedaFHv1WKNZla/QaRc6Pk9Y5GmPhkUB1jeuo6NwmpukByGOAbYa2HevCX35eG7pTvP0ks+yHAENqZN+A/SO6Px3R3NbtHnrZ1TwVEKdbXZ1K3N7jcHQh7oMJXyslfFRNtUAGmsLSDUQZKqtFBhGraHJjKeVmSRS6bYd/9SjuD+XndtJ07FoGt3tJWLDDhUbbloQy4tFlEj0Br1dIdfmqQo0R28rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:53:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 14:53:19 +0000
Message-ID: <1c40ffb7-664d-7d96-e4aa-4afa52520aa3@siemens.com>
Date: Wed, 10 May 2023 16:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH v3]
 README_cip-core-version-release-policy.md : To define the versioning and
 release policy
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230509122505.3405-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230509122505.3405-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b9c057-6c9e-4ee7-5589-08db51664b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ao/2gVmR3HB9b/0byXiXWxW1KYXKVK9QYj7lQWG2NizRbVe5iiklh55vkNsalHCKXXNsRluMzzfVInabf6E23lPKfD/1Crornxd2sJwYZQoV6EmsEeEHxeROT5AhjUyvT8K/cj+taUGfvit+tF9jXdScvrbMoW+el/qUoXMAq4kkpD3O1CsVsdCZDL8NakCJwK9klTxCbYs4obTWw5XSDNo7Zfv59d3/gbMNN/3ytkhPx9+J0H2Dbx66ME2I5StPirr7e5kcCBUHZ2yt5YCTFghla6bo2GhFXRUj+B54Jnkj58qlDlJurxeJJIJSJpUvvVRhojXpzQVfL8DvAmKibDH1X/up/qAtNQqo+PcRi+k3ngMAL7SU1uGC0huaEOvckMs5JsdR7tcjkgQJ31PXHO+jjUYhVGI97QSXaS/XpvA9Z1nZxudXnnlDqvGe2wEZNhCi99dH+zQ438fIdDVJAXVfj3NHmKqEyWzCOMv/2FxpqLiLWNtO4FtbcjtHVbWAe9gjBTdUHFTiVwhuJswhmuUzMRm6lPljGXFNrqY60ZRPxwwY+4BR4MmLMRmLKNnLOKrsQOGZUcNF4YXIrbBatzSvpQkzQp7NAd0Ty/mLIIiaLpV3+1vrkM4qqiTEU8ANLtz2VOT9aH9yFjWPZzKEsg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(31686004)(2906002)(41300700001)(478600001)(66476007)(8936002)(316002)(5660300002)(8676002)(4326008)(66556008)(66946007)(44832011)(53546011)(6486002)(6512007)(6506007)(26005)(186003)(82960400001)(2616005)(36756003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zvqElJHznbcIHtVCpFlr0BM1RN7XiYxepeRjiZrhssGtCOIyd2i4bFtgNq43?=
 =?us-ascii?Q?QZR/UKvYD6wpSxRtoPCXjHUwNR/D/3O4Vhl5Gu33nk3hGALNkcTGFi/BkfFA?=
 =?us-ascii?Q?8VZwdGg3aa8MMmE/wdMasaVu5Ixbia8pAiYeCjXjgmdzAjAcuj6SYDcS0+V9?=
 =?us-ascii?Q?k2kdmMzW4Lkv5LpJeLztEVogo8yHHi/yMRhtyDqWa8vLxv9hpVD3zzJVrtIa?=
 =?us-ascii?Q?W9uXaZy+tWdiEO00hlBaW5VF6deWJmgGwtx7W8H/ZrgbhEqNGymlMUcQ8DYP?=
 =?us-ascii?Q?B4ves9/laqQxbXKHqZ58i19drtp/VbZtOuK6HOLBQD2bWpJds2do9EmuL4Dt?=
 =?us-ascii?Q?4AfaaSCx6FnsUkh/1T/WIGzs2bGggbnd5edUjJwQPOekngv2YzcEqkOnzdgw?=
 =?us-ascii?Q?j/Sqiewyphay9zY3mwBhrJhU30rdynHaGPyFLW0Zy12MO7/y0SuUI+fXG91U?=
 =?us-ascii?Q?OLvSQEveBERVyWBzjfiz/9VxpzYriKhacRAYVvFqJZehfDI2Kq4qQW82lauS?=
 =?us-ascii?Q?Yhi8CRm5BhGgMhBVGDgOxFi5RMnQiL/bBS31P5DJ4xA40N2t138X0lKu7a/v?=
 =?us-ascii?Q?lSGH5l/h3djPneOASwfb8NScDLIX655usiLEt7y0w7704c+yCSMATG/Z/GoL?=
 =?us-ascii?Q?s+c8yGAIa8vfVlDeFJntomyR8Hhlwjf1ddA+GVAmxpXGWENJA9uZSLWtfLxC?=
 =?us-ascii?Q?2M+UsUEOqW/FvlPMeLtqtFtZfjc5kc7ljPaPNJ2idBwCEA59eN84xS5C28zH?=
 =?us-ascii?Q?qPL/yaH7POZD2fVEnYcsuFwkSzVppH+dHJd+BjJ2lCaKvBu36WCrMREGp0BC?=
 =?us-ascii?Q?dM9UzYpxoHrYDsinbymmhmLZUcdwQyzRaxbpu+Qb7GKsHB+CTTtKo1cwpYKZ?=
 =?us-ascii?Q?6GOf5vjZfU2rOhGKYWE0s7xI4Y8nVLnaL7RHDdXwDQuFLHd3+wNxxza5fl1a?=
 =?us-ascii?Q?r992i1q0TEeW2h4o8YWxsoOkBt3/w1kbB2lCJwdwByfGpXKDvqi8RR/1nNDh?=
 =?us-ascii?Q?M34P2msLc5aELTpNgZtRWrKORubVn0TnKcblR/VW8JJwr0iyTMe7LVh4H5IV?=
 =?us-ascii?Q?xSZE8fGSxGq0GiQKLRUNbsLK8B+tFoF113pZr3+jalpcPO4j5SAMxI3Caa3u?=
 =?us-ascii?Q?vlXpphD4mlMMFxG+dt80ZgTDqYSAIOY+uBIIyufeDahl/1jGUEdH//iC0roQ?=
 =?us-ascii?Q?i1vCtK7P2NZO3YnDbE/pB61C+q0ZubPuBw57erM2GZW9khRyuFRlfiM6tCL8?=
 =?us-ascii?Q?TGQU6xwDQi++UUllEvQFjVyeYTM1szhC1+yoDwhTWjP2mscOoD4ZnX3C3nAS?=
 =?us-ascii?Q?btvUczseINqh0tu9/ktMWN8oKs/6ZNiJO/2pl+pm6mFupKXoG7K/z+78V+Xi?=
 =?us-ascii?Q?gjhhOMtLCX75D29yyqb0D8UKJVZdsr+jGfEbjSHiqrS+KBuw5RryxwjEDX0d?=
 =?us-ascii?Q?41MYjzHw308j6+nbyCTPeu2iAY7MmaUj2PiibFaj56/IzHMcL5YGeE08l55I?=
 =?us-ascii?Q?02Ur50Fz/hjQEtGNSCMos1BH0LR784o/26b15OOtQZ/PoVYEXlCV4vEWcS3L?=
 =?us-ascii?Q?JWMMYQpNW33DCNobDrTn4+uUQUvKaiJAUJkcvdWMpU403EQkUQgQYgU9gw68?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b9c057-6c9e-4ee7-5589-08db51664b00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:53:19.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zE4UslHpFYZIsc0qrpqvRw8JlLwRXMs2rLheIMNpxDWnMqalw7YuuLAinlkQ0zxJsePrdEl/ZvO7DTLqmRsIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7069
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 14:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11434

On 09.05.23 14:25, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> This document explains the versioning style used for isar-cip-core
> metadata releases, frequency of the releases and their policies.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
> Added original commit message and version to the patch.
>=20
>  doc/README_cip-core-version-release-policy.md | 31 +++++++++++++++++++

As this file is located in isar-cip-core, I've shortened the name to
doc/README_version-release-policy.md.

>  1 file changed, 31 insertions(+)
>  create mode 100644 doc/README_cip-core-version-release-policy.md
>=20
> diff --git a/doc/README_cip-core-version-release-policy.md b/doc/README_c=
ip-core-version-release-policy.md
> new file mode 100644
> index 0000000..6577df4
> --- /dev/null
> +++ b/doc/README_cip-core-version-release-policy.md
> @@ -0,0 +1,31 @@
> +# CIP metadata versioning and Release policy
> +
> +## Table of contents
> +1. [Objective](#objective)
> +2. [Versioning system](#versioningsystem)
> +3. [Release policy](#releasepolicy)
> +
> +## Objective <a name=3D"objective"></a>
> +
> +The primary objective is to document the release process, it=E2=80=99s f=
requency and version changing for isar-cip-core metadata. This metadata can=
 be used by CIP users to create various flavors of images like **security-h=
ardened image, testing image, partition-encrypted image** etc. in architect=
ures like **x86_64, arm64, armhf, riscv64**.
> +
> +## Versioning system <a name=3D"versioningsystem"></a>
> +
> +The isar-cip-core metadata follows semantic versioning system i.e **x.y.=
z** format which is explained below:
> +
> +1. **z** is incremented only when critical bugs are fixed.

"If **z** is zero, it will be left out." - I've added this sentence on
merge...

> +    * For example, if the latest release version is **2.2.5**, then the =
upcoming release version after fixing some critical bugs will be **2.2.6**.
> +
> +2. **y** is incremented for each Debian point release or in case of isar=
-cip-core regular release. When **y** is incremented, **z** is reset to 0.
> +    * Let us assume that the latest release version is **2.1.1**, then t=
he upcoming regular release version will be **2.2.0**.

...and adjusted this example accordingly.

> +
> +3. **x** is incremented when significant changes are done other than **y=
** and **z**.
> +    * In cases where recipes are broken fundamentally, or support for an=
 older Debian version is dropped then the value of x is incremented by 1.
> +    * Let us assume that the latest release version is **1.0.1**. If cha=
nges similar to the one mentioned above are done, then the next release wil=
l be **2.0**. When **x** is incremented, **y** & **z** are reset to 0.
> +
> +## Release policy <a name=3D"releasepolicy"></a>
> +
> +An approximate time gap of 3 months is taken between consecutive regular=
 releases. During every release, CIP-Core plans to give out recipes (isar-c=
ip-core metadata) using which the user can build the flavor of their choice=
.
> +
> +All the releases can be found [here](https://gitlab.com/cip-project/cip-=
core/isar-cip-core/-/tags).
> +

Merged with those changes, thanks.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


