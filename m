Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA291C77B7D
	for <webhook@archiver.kernel.org>; Fri,  5 May 2023 19:32:30 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web11.4981.1683315149360132255
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 May 2023 12:32:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=a4Btne0v;
 spf=pass (domain: siemens.com, ip: 40.107.20.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m65ySUPRFq43WWj0j6IHXNRPCO1W/0ypzMY+H8+JWkeaPRJldqh7qUyGMMg1SeDPy6wPH0hm8JXD9Hgfn2pF+nJO6en6+Mud5RvlF2QjN7H6hWN3Og2qCGW3iugycuLnIxdOfxwql77bmQ1BY9YZcvB+44KG/lfTJaUW8SRcIaY1l2XyBx1PMuSbkb2dvyLR2Jcrd/oBokc0dn0oFbTd8mHJvolUiEMpl3v0htXajxOZns/9Ei3y4sMFZiUy0BKXE4VAHUDKrfNEnZgZJ/xDNBYXbBUrzB/ZpUZfmME0e7Br4/KP1bFlsvjDPN5F4l632dez9A9/wBPMpPpuEp7M1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU30NepogpfcW/o6EzC8+tcILBYIv1rlu0Q/NGYBMP0=;
 b=Utm5fcgqeoxu4OpEMBULTnaebmmpuofOrCnLl9+H18DvQRdDQl4xIbsvOGoMyaPXBCH0Was9OY5hWBu6K3brK9Lo4gM5OMcQisEDtYwvAr+JyNsXd0jLZEUYQPzEs7Qkib0Heb4i/vhlia+hnf1pij7zI0HMvRaEpOC9L07zUh4514eS5hiTYuAvxbALEJwKGzwLhj3nCAVgLPQsJGcB+1es7+cmlUhCWGsDW4Q7noE8fqJFqoDOK7c+YZhOgrHnWnpa/NCbaxyrEILNuht56ZwuLEDvsvIRpzHVmvHzxqBtINHs4fO0mu2UNnLLNfWZo/+k+7d9tjfE9EC5o18KHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU30NepogpfcW/o6EzC8+tcILBYIv1rlu0Q/NGYBMP0=;
 b=a4Btne0vzyywTO9miD7HCfx86sDt3e5hPVF/4sdes+sSwXElaPI0Ogn8Yl/xKB6GeUP3Og7PyFHB5Y7MVA2/N2R2UaP+88p7Hk10zMAy3DHcIJSimjhnu2wHSJbIWz/HG5m4/8AsWDSeFd6mKEtkqv0nI/SqCyfKiLD8MX5NdwB3c78cS6h0tng4vUQ03wFr5I1mqoaPWkDfzOwpjUUpL7FSKT5nm05+L95MlEiIh1pzR0NnCW4v2IP43ywhlvfCZg44/tUeASy4S2ZYnXSXy4JPctxU2BheSCd53Zx+fBjTQbcHmhIfGecmxhPISIwxqjCm4b41JF+PVrXpAu5GrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 19:32:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 19:32:26 +0000
Message-ID: <8d0bfad4-c44e-966d-17b3-18cc5695f206@siemens.com>
Date: Fri, 5 May 2023 21:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core] README_cip-core-version-release-policy.md : To
 define the versioning and release policy
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230505175629.4635-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230505175629.4635-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e63375-4675-46f1-e307-08db4d9f7545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x4pZykzg/aFznqMyQDM7esWGPPCM4xQGm2RJikxKVrI21CslhuN5gakBf3xVeILBZ4ICffTgh89hxoBathf2xR3YlyhVblPrkqbBpncaurRnJ0V/7Fg6kXYNkB/SyLKgPIbO9Y+yKhlt7K2VT9qhfMetmbmsMmdcKSuGacMEAqZNYAFXncoebey1egAOWcwbTUYPlSRsiE6ey4bwunQBMkeS3KYby7kWG6IrAoWN4QrnE3LgwpM7BD3rx0jeGvG9jsUOkGefbr2z1k91t+ZYMm0utSw8SzYySWWVnn7OD1t8Vvq6tst9vmZH8HZJhNBmPE9tC7kKr5PCQB0y0fVJhhwe34LD7m0cKobsyblc0+humKJ+4NtgvQKegtfKgd2CkiOar+C+3Dbqt+GrGLVPxCZo9GfAwk00Yty/sRZV1UPE+GrePDORPEpw0BvgF63G9Ihd/A8oMGd/jCtTyosbFNY1ciOVcBkpyeBPQ4emAbUPWWSegde1W8cZtaiwPpjJeJ5zRAHYEWrSwGVAN31LQCkVBiHrfolq0oaoJkXJL4shKBR7UxPjgxHty7oV6vjrgTiVhWWyIYBqiLcyShIv2HxMljBwi/RxoR4LxczpYiWKA+nEIirAmOioTECAFH8MHGYsJQ2q3RIHR4mKtCCTOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(83380400001)(2616005)(186003)(2906002)(31696002)(38100700002)(82960400001)(36756003)(86362001)(8936002)(8676002)(5660300002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(6506007)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nFQIA8a2GneikTcCbA6N/Jyom3lxwrDngUmgpSiN7VBC/rkvFPVVT2lSe1R/?=
 =?us-ascii?Q?LLbV+gBj/VwIQAoGl6wEzzSWjU5W1/QS8iZuSCwqdOUjxOF531X2wH2rKNc6?=
 =?us-ascii?Q?NTkBwEbjZAV3W91A/Yn+VfUb1XS11+0J24yWmFAcFWEOwc1DZarORohSrLvW?=
 =?us-ascii?Q?49T8frd+UF8a1iIPZULoifcTlUh3E0H4hN1Llj5RzxuegdqjrViSMljPSj+k?=
 =?us-ascii?Q?6f4KEBVYfgEBShagvrAzKNsBQssYN7Ny8+5r91Hh1QPPY8cNX+etF9tryYtI?=
 =?us-ascii?Q?Crxs1GNA40CBwVtl0lMMXb+jiOdT9WFJASHvtnyk6qYLIEDLl7+CL947YQrx?=
 =?us-ascii?Q?SnYS8SFn4YIQ2w84wk9QAo2KDjD3MTpSOx7am2cgy1qQvwjSfi72ZaIj10RB?=
 =?us-ascii?Q?rtXumCf4uT/fCQN275OZTMzEsUkAGkzAk9DdJcoEv77Hh6wVf19gQuYbE1gX?=
 =?us-ascii?Q?/gj1mMbkZbJWNemb7qIgUpZU56l2iHwgwicStrIM9gMJhwU0AY8LM1KoFLSX?=
 =?us-ascii?Q?CtTPib4dbPeD+UlCzaQDizzTFdcXGyA9nnUYYh29bf9Q9tVCgQygAP2EgMEp?=
 =?us-ascii?Q?m84tNQVNjqoKvlAy6nGZzDwN4MdJtKrMeNZRSjWb3NuAWJCjrMvHDpx4vx1a?=
 =?us-ascii?Q?d9boOGmhJhxUgQbMyIZCJp9fGud1yQezqrCmrPpZOPWz1CLA240GFrxxJZnW?=
 =?us-ascii?Q?pJZZSlPL32fjKrKza6fXkAvRlLLna3aZ7cqLLKfT45ridgMZPBWVIyO3LzUn?=
 =?us-ascii?Q?rSPQN9mhEFFY2Ghv/eO50SmCC+oxxqRiaZrjqDvE1TdhQkPmcTLobACaBiRZ?=
 =?us-ascii?Q?GtJ2BCKAvnaLSUkzS/0yKnZ2o0cacPkq/uGunKe4U7kR82ZfTgj1sArVf1ly?=
 =?us-ascii?Q?TXWAwAuvDF7Dmed2/opPwVODb4A8hWci7JrnJdbVR/4BbxpZj1aGZYyEmLcl?=
 =?us-ascii?Q?8RRpFowwQWBWS7sxW2h0p2vlbjAwqLOmf5I2OCjQhf0BaKdot6vWXi3hbYO3?=
 =?us-ascii?Q?7+lnfbUjTCe/Ekbp8dt29YkmZZB4VyTkRQmhHgbDwSLQiMMU/MufdyPdWdNL?=
 =?us-ascii?Q?PInBYGcudzyckX9OU6BLG3ZRb8OHRJtxKY79PNiyH9kEdP4RZY2agBkAyG/I?=
 =?us-ascii?Q?NL1Cj7X+aph5Updhi434xhd+gi2bOhPiNZdiErI8wamAVkypMVOWCKIh9rbV?=
 =?us-ascii?Q?PYNaDtwDyH/z1HB7EyCupqjprPk4Wlh21+qnZyEzxAfpZxYr5rmt7q7JLWrk?=
 =?us-ascii?Q?IcpXP6GiN4KdiJYhVX0XwOJNSjnnSdSRlFv9pbNwD566J7UP6mUby8Dl2guq?=
 =?us-ascii?Q?MEphYaFmaOyBBVGRq6tmYutZ5y9WOVA/w5e96QC2XaMm2otNA3gi7QVPkOaG?=
 =?us-ascii?Q?8bMR/Ul8/9hYJuBHydAtOPKHQMqz+rLKYn/mZDMoPT6CdiMnR+HDq5GX4OXx?=
 =?us-ascii?Q?rJ/r2OVqdthizsdoFurR4fkAKokPqIg78hKaRnVcM6TENsAFf97K3ET0Mxqk?=
 =?us-ascii?Q?kWjkwP/INtIOpu3iSr2wIGAX6Fz/iy+6FsMJTRYByTIRKwcg6k8uxOoOq5EG?=
 =?us-ascii?Q?bCf46fTQ+JWuwgzdJ5foAJTXJfJ+Ai7gI/YJ4OxD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e63375-4675-46f1-e307-08db4d9f7545
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 19:32:26.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK3z7BMnpQyYF7R369i30x7Gk7j/aJ+o1wKw5faR1VyPAUS6e1DX3uIl9snYf1AExDABAlZAc6m3xtWcNh+TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5632
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 May 2023 19:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11413

On 05.05.23 19:56, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> This document explains the versioning style used for isar-cip-core
> metadata releases, frequency of the releases and their policies.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README_cip-core-version-release-policy.md | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 doc/README_cip-core-version-release-policy.md
>=20
> diff --git a/doc/README_cip-core-version-release-policy.md b/doc/README_c=
ip-core-version-release-policy.md
> new file mode 100644
> index 0000000..14cd839
> --- /dev/null
> +++ b/doc/README_cip-core-version-release-policy.md
> @@ -0,0 +1,42 @@
> +# CIP metadata versioning and Release policy
> +
> +## Table of contents
> +1. [Objective](#objective)
> +2. [Versioning system](#versioningsystem)
> +3. [Release policy](#releasepolicy)
> +
> + *****=20
> +<div style=3D'page-break-after: always'></div>
> +
> +## Revision History
> +| Revision No | Date       | Change description                         =
                   | Author       | Reviewed by                            =
   |
> +|-------------|------------|--------------------------------------------=
-------------------|--------------|----------------------------------------=
---|
> +| 001         | 2023-05-04 | Draft document for CIP versioning and relea=
se policy          | Sai Ashrith | |
> +

Err, this is not a legacy Word document. We have git as versioning
control system where we can easily leave all this information (and more)
in the commit message. So, please drop.

> +****
> +<div style=3D'page-break-after: always'></div>
> +
> +## Objective <a name=3D"objective"></a>
> +
> +The primary objective is to document the release process, it=E2=80=99s f=
requency and version changing for isar-cip-core metadata. This metadata can=
 be used by CIP users to create various flavors of images like **security i=
mage,=20

Maybe "security-hardened" image?

testing image, partition-encrypted image** etc. in architectures like
**x86_64, arm64, armhf**.

+ riscv64.

> +
> +## Versioning system <a name=3D"versioningsystem"></a>
> +
> +The isar-cip-core metadata follows semantic versioning system i.e **x.y.=
z** format which is explained below:
> +
> +1. **z** is incremented only when critical bugs are fixed.
> +    * For example, if the latest release version is **2.2.5**, then the =
upcoming release version after fixing some critical bugs will be **2.2.6**.
> +
> +2. **y** is incremented for each Debian point release or in case of isar=
-cip-core regular release.
> +    * Let us assume that the latest release version is **2.1.1**, then t=
he upcoming regular release version will be **2.2.1**.

Nope, we will also reset z to 0 when incrementing y. That's standard.

> +
> +3. **x** is incremented when significant changes are done other than **y=
** and **z**.
> +    * In cases where recipes are broken fundamentally, or support for an=
 older Debian version is dropped then the value of x is incremented by 1.
> +    * Let us assume that the latest release version is **1.0.1**. If cha=
nges similar to the one mentioned above are done, then the next release wil=
l be **2.0**. When **x** is incremented, **y** & **z** are reset to 0.
> +
> +## Release policy
> +
> +An approximate time gap of 3 months is taken between consecutive regular=
 releases. During every release, CIP-Core plans to give out recipes (isar-c=
ip-core metadata) using which the user can build the flavor of their choice=
. The images built after locking the package feeds to a specific snapshot d=
ate will be bit-identically reproducible.

We are not yet bit-identically reproducible, but this is clearly a goal.
So, we better not over-promise here.

> +
> +All the releases can be found [here](https://gitlab.com/cip-project/cip-=
core/isar-cip-core/-/tags).
> +

Thanks a lot for picking up this task and writing the doc!

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


