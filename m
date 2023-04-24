Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B258C7618E
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 12:06:31 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web11.48882.1682337990378688293
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 05:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YxXNncBY;
 spf=pass (domain: siemens.com, ip: 40.107.8.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flg6uxGytx730DSfqDHkJ3WRkmowVZrloqcIWMYDqLO1pZ3K+7UfVhR0wEcVt1dxkrA6D5ea21wZX0y51/bgiu8oXn+5noFsDMdHDB6PdLSzVTDQ5TUr/8YUPB8iQ5oRauGETldY+mNuYJYf1qQwCMNq+IgxpUACghvqBvfHac3/rAGx98+vw5OyAt6mYlguDh5LuCUAPhUYJpDxG9VXMprhXRYdVjD/J8pNc5Qx+iHsnZzqRYNLLdQw10EN9+MBr1ef3ERDqRkeB8+ajo36Nbhk26TuCp59SkDF6boEV89gXxX2qPh/5GuNFfiKdk73KvFxJvEMpG9k8zgmtEpZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSx7WKQiMaeYfGLKZXqhVCxRytMqTvC+3pUkBA6WNzE=;
 b=U7l5T390fS7rKanStEeX9a3j/iNSVmle+1EbxfRkUrl7UqerEpIcKGbhGdnZ/D5QEiKiZceHkStr1zjrofa8gxQRhJ8BbMWlqDmJFf1GEm5QW+QiE2acnmSwT0oITvHMle2ekskCN7TXi0jojdTo+3lBP8vT+/hvsfR7exVJUooix5sLqfj9AofjDj4x95RS6lCMNK0ckaiHFjunC8aY9922kfPRKq/r0MuaNI2eVbtQB8s3J3Z3FT+vQ8+SGpcn8JGQx/IdhgEgTKGOs8MJ8e9GA31Ugl95EubNooVGzjLlSIjC/WDJvOGXcjaDU4a2AE+DMILwfAiGs8fv8v3M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSx7WKQiMaeYfGLKZXqhVCxRytMqTvC+3pUkBA6WNzE=;
 b=YxXNncBYmvrF9g0UMbwJsv3m0H585utjBXnYRgFcCuHqb1qJwKmxSTs7fPLw4awNdJykFS93LGkR1QYSwAur2ZFrKLUHvOUaKNDdxHb+DcS8SN3h3FDoRzPHAqc1PJ0/ve70VGxVMAqaNHDQWUzqJCBaE89vS99DbPOW+7OwYMNO33DJDo58O9IslIGM01ZZVEkX9OAi5ojHkNvbya75OUvbcf4U1VTeHFEYVe4KMh7Gefw/s3/8IwyYCi5qW6HPDy18eCfIRqpw3Hg2zQuiVQu4xrDj1+2bNdvhIZfbeIqSc4BqJ6KCZ/IQEMyiBRjR7pGEZJQbAzM4goOHuNbnfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Mon, 24 Apr
 2023 12:06:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Mon, 24 Apr 2023
 12:06:26 +0000
Message-ID: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
Date: Mon, 24 Apr 2023 14:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] recipes-python/shtab: Update shelltab to latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230424115551.2896898-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230424115551.2896898-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4ed289-6eed-4c66-8fc0-08db44bc5477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vIykqNPLj5SJLqJXQ4q2LMnp6fIt3Iu7hBQECCdvTq/R1XovOOipHNUnyxQwmshLYsCTEmWNXk2EYuYdDgQQPYrgqdKBeJIGs7s/cJDgCTnt61LyhLnvduVpWUVqvXMxZeJpd22oBY3/ccHEA71yokcaHYc2UrXvRokn1q1tK97KGUEwFzst8bsN/r8n1KC4yMRKLsifnL6l3mzl2qKN6FWHXJ+GqGga4ZPpUK20iFAV3oDeoJpae8EI0FtL56Oz/mlt21oe0Whnya+fTlzJ2pqmeeIMzJafFHXLobNtUXaG0MS1IGE8Fn1zUQgAte2Q56z0wTltFNHo/jKGoH2SnNIyp3n20a/RhNVoaneOtdU5o2OITsHfeqn0dxSzDoHV4Azvgjv4UGuY73k9HpdetN5X7B2p0DNqSOVKPkZBXh+MmfPWRCUzLUp6ciKcYh84Jx2RL7qTUJP15yGXCTFRqsr2c+GPPm/DE1lznwPkq5xqgg5sG90nKS9/0FUc5gPXM8/y7oauuipTmApHt1wUkCH0vyYaIZX0rOPaC/5oCjWcg+sauuWiUdGqnfghVfORbRaH1i2cuepOx8cOP7P2HY+mBiFX8bWwkta5xmyCe5aul07QZFBhnfhO38RRYLZ6yz3V9wsRo+Oa+nq/t4EMTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(966005)(107886003)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(186003)(82960400001)(38100700002)(66946007)(31696002)(478600001)(86362001)(15650500001)(66556008)(66476007)(31686004)(8936002)(8676002)(44832011)(5660300002)(6486002)(41300700001)(30864003)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QU1tMXB1elc4UjNmR09kc1Z1M3JuMThLMGlRYllta2p0ZC9qRGdIZU5JZVgw?=
 =?utf-8?B?b01YWCsxUzF2WE9TTm9SZDRBK2VGd2NqOTNPOEVaeWpXcHdSRTFHN0oxMWw3?=
 =?utf-8?B?NldjQ1ZxQkphcTh6WVdjVVRqWTZsd0h2bVZLWnFkY012Ry83OTZoWUwyZG8v?=
 =?utf-8?B?c0ZWLzE4RzArUEFPSkhiUW82M2VhdTFSUXIranAyQzN4bkh1K28rU2xPdDNH?=
 =?utf-8?B?cCtDUlZIei9xZXVNME4xQVpwZzdaYTRmWFpPcCtDekh1V290VDExR1dnNjlv?=
 =?utf-8?B?VHJFcDlCeTdZcFdxekRUQktadml4VEFMNU5PUzByRlZBQ2NEL3gyaFNkU0lJ?=
 =?utf-8?B?NTZLSEhmajVpY1RjeXFuRmNTakZ3S3BudlpQR2ZmSTdvblZNK3BrQVZPOXBr?=
 =?utf-8?B?dkE4RXgwN2JJWWgyY2NjdE55amRGWUthYzc5eE05bll2dWI0VUxVNy8xUk0y?=
 =?utf-8?B?YkdqUHdZYWxCQVhaR2N3eW4yZlVZMDZwdGdDV0h6WUNnWFUwOU9jYlc3R3ZT?=
 =?utf-8?B?UktLYUQ2ZkMxQWF0MXgrbG5BTENGTGZRNmx6WGR6b09oSXM3SnlnS2ZkMGgr?=
 =?utf-8?B?c05TRDVlNFJpby9hZE14YUJRQm83SEViai83OERQZHd5Zlo3QkFNRFRkbkdl?=
 =?utf-8?B?M1lveFdlYy9QWndBblhDVi94M2dCS00xeUhhVDcwYjRrclVSWDNLRnJSRUFB?=
 =?utf-8?B?bXk1dm44NW9ISXBGVUZYYTY3eTlLM3p5REQwZmVyV1BVbFYxZ3pOckh4QVp0?=
 =?utf-8?B?QkJ4Y28zd1d1Qnc1ajRjTFYwYnRPWkJOeit6WW1vTXVlQ29ha0o4anEzeDdH?=
 =?utf-8?B?M2xxeFFLYkpURE13T0JKUENQYXJNaXF4U2VsWVZib1AyRDRzRXFYd3ArYlZi?=
 =?utf-8?B?ejBxd3JhZVVUdWdGOFozYkRXczMvcjYrTVNYN2g3T1Z4Zll3cDluL3p3Ulhq?=
 =?utf-8?B?bkJ5NkxPbEFlSXN2WjhwbGJTNVpkNEtzUEJNNmRISENzbU9FSmp6STIwNlRG?=
 =?utf-8?B?K1Z3c09RVkROMU84NVNvMG5SNTZPZFB4eEVwQmVRd04raTBjZXpMMFR2a0Mv?=
 =?utf-8?B?YWUyR2QxZXVaZTROVWIybUZTZGh4RzNYMkw4QlRNR0xDdndCeGE4OFFnUlF4?=
 =?utf-8?B?N0Q5dXVqUFNDNWsyZC9FQ1RHc1BHMmViS05leFNUQzlTWkJmbUh2aVlSalR0?=
 =?utf-8?B?TFliMmNqWU5TWGVHMjV5UHRVV0o1SnJKQ2tLNXlBZnVCR0ZwNEhIcW5CVktD?=
 =?utf-8?B?Z05sYjV3QjkvMkt3cTB2d2gwTFgrZ05hZVRpNVJGRkhuc1FlS1ljMjlyby91?=
 =?utf-8?B?SHFOWGVyNDE3dkcrck1QRHpDL2NBT2VsU3RyTmhZSW5MY093YkpVWkJUMUY0?=
 =?utf-8?B?SWhMbTg3NW5lZVowYUNZUUxXSHFyK3NFNzJJV20xMzJHMlljaGNGNjdOeW1y?=
 =?utf-8?B?MWFYNzIvQVU5N2RMbTBGV0JzTjdwc3NYYlpOV0dlbGNOOGYwYmR6Mm0wM2tI?=
 =?utf-8?B?ZGIvRXdycXJ3SGllSjBsK09iWS9vY0hYdTlPNzNmNGNEMG41WTJlZnNtcE5s?=
 =?utf-8?B?anhVdmhFaklFU0RSQWhKVTh2andnTVhjcCtFYmRhbGNGemdGNDVQWUxwT1BI?=
 =?utf-8?B?YXFpT1dwbmlXMWRncWxRQ1RFSjdINlg2QVJyeGtLSE9wK21INWcrM2NCUmVH?=
 =?utf-8?B?WmVmdmp3YllBSXJnNjlUSGN0clc4SzMvMXZKOUtjM3JSNFRwU0Q3VzNwSGoz?=
 =?utf-8?B?cmd3bFM2cTJ0cDZySldjSmx0TXpDQlprT1ZnWFE3bnMzZDJJS0RrRHp3RnJR?=
 =?utf-8?B?TzFONzh5aG5ka1E2Q3UzQ3k4MlZHelNaY2taNUlERTNtRzBzQ0dTY0swd0Yz?=
 =?utf-8?B?VXhpby9iNHZFZS9SYjNteVJidjBrbzJ5bVN3T1FXWDQvYWFqaG9mdVBmNXlW?=
 =?utf-8?B?bFVjMktTR2JDbDhTS1ZPRVFmWnBmVWE4UTFaMUZQL1Zod2FWN3FGUWtZVlJi?=
 =?utf-8?B?NWFRbkV5dFc5MCtJNjRTRk9tNUdGKzhmeXBaN3lmbjFTdVNjM0kxWGNKSzUw?=
 =?utf-8?B?S1crZDhPT0gwcE1vUGlaZGtJNngxNzZzdXhtdUN1VWZFcTdKUG5ESjB3ZWo2?=
 =?utf-8?Q?FRNf5pddlg9jdGgmRRxiyNQP+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4ed289-6eed-4c66-8fc0-08db44bc5477
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 12:06:26.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVwITyijYnNSBrPYmCImUTJffcKrsSGopfa8BLlVrVLY94ndbtOE68oJdUGPzilMjkoLbaSA+SnuSeTJG8IQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 12:06:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11335

On 24.04.23 13:55, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update shelltab to latest one.

...latest one of Debian bookworm, right?

> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-bsp/efibootguard/efibootguard_0.13.bb |  2 +-
>  ...001-Lower-requirements-on-setuptools.patch | 28 ------------
>  ...ix-cross-build-issue-for-bullseye-im.patch | 33 ++++++++++++++
>  ...002-Lower-requirements-on-setuptools.patch | 36 ++++++++++++++++
>  ...003-Lower-requirements-on-setuptools.patch | 43 +++++++++++++++++++
>  recipes-python/shtab/files/rules              | 21 ---------
>  recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ----------------
>  recipes-python/shtab/python3-shtab_1.5.5-3.bb | 31 +++++++++++++
>  8 files changed, 144 insertions(+), 86 deletions(-)
>  delete mode 100644 recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
>  create mode 100644 recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
>  create mode 100644 recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>  create mode 100644 recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
>  delete mode 100755 recipes-python/shtab/files/rules
>  delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
>  create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
> index dd76198..313716a 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
> @@ -29,7 +29,7 @@ PROVIDES = "${PN}"
>  PROVIDES += "${PN}-dev"
>  
>  DEPENDS = "python3-shtab"
> -BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
> +BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab:native,zlib1g-dev"
>  BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
>  BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
>  
> diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> deleted file mode 100644
> index dccc2dd..0000000
> --- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
> -From: Jan Kiszka <jan.kiszka@siemens.com>
> -Date: Mon, 14 Mar 2022 08:17:00 +0100
> -Subject: [PATCH] Lower requirements on setuptools
> -
> -Allows to build against Debian buster.
> -
> -Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ----
> - setup.cfg | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> -
> -diff --git a/setup.cfg b/setup.cfg
> -index 55eecd4..186aad6 100644
> ---- a/setup.cfg
> -+++ b/setup.cfg
> -@@ -66,7 +66,7 @@ classifiers=
> -     Topic :: Terminals
> -     Topic :: Utilities
> - [options]
> --setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
> -+setup_requires=setuptools>=40; setuptools_scm>=3.2
> - install_requires=
> -     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
> - python_requires= >=2.7, !=3.0.*, !=3.1.*
> --- 
> -2.34.1
> -
> diff --git a/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
> new file mode 100644
> index 0000000..9fb17de
> --- /dev/null
> +++ b/recipes-python/shtab/files/0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch
> @@ -0,0 +1,33 @@
> +From 661472b5fb651a140cd9852fef4b797b8535fedf Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan.a@siemens.com>
> +Date: Mon, 16 Jan 2023 13:55:23 +0530
> +Subject: [PATCH] debian/control: Fix cross build issue for bullseye images
> +
> +Fix cross build issues for bullseye images.
> +

And this one was also submitted to Debian upstream?

> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> +---
> + debian/control | 8 +++++---
> + 1 file changed, 5 insertions(+), 3 deletions(-)
> +
> +diff --git a/debian/control b/debian/control
> +index b30beb1..a63e366 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -6,9 +6,11 @@ Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
> + Build-Depends: debhelper-compat (= 13),
> +  dh-python,
> +  python3-setuptools (>=42),
> +- python3-setuptools-scm (>=3.4),
> +- python3-all (>=3.2),
> +- python3-wheel,
> ++ python3-setuptools-scm:native (>=3.4),
> ++ libpython3-all-dev (>=3.2),
> ++ python3-all-dev:any (>=3.2),
> ++ python3-wheel:native,
> ++ python3-toml:native,
> +  python3-pytest <!nocheck>,
> +  python3-pytest-cov <!nocheck>,
> +  python3-pytest-timeout <!nocheck>,
> +-- 
> +2.34.1
> diff --git a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
> new file mode 100644
> index 0000000..1db4fa8
> --- /dev/null
> +++ b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
> @@ -0,0 +1,36 @@
> +From 1d2e28a3da03815d16e0fb6dc11428509f4ed366 Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan.a@siemens.com>
> +Date: Tue, 17 Jan 2023 18:54:33 +0530
> +Subject: [PATCH] Lower requirements on setuptools
> +
> +Allows to build against Debian buster and fix cross build issues.
> +
> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> +---
> + debian/control | 10 +++++-----
> + 1 file changed, 5 insertions(+), 5 deletions(-)
> +
> +diff --git a/debian/control b/debian/control
> +index b30beb1..380b934 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -3,12 +3,12 @@ Section: python
> + Priority: optional
> + Maintainer: Debian Python Team <team+python@tracker.debian.org>
> + Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
> +-Build-Depends: debhelper-compat (= 13),
> ++Build-Depends: debhelper-compat (= 12),
> +  dh-python,
> +- python3-setuptools (>=42),
> +- python3-setuptools-scm (>=3.4),
> +- python3-all (>=3.2),
> +- python3-wheel,
> ++ python3-setuptools (>=40),
> ++ python3-setuptools-scm:native (>=3.2),
> ++ libpython3-all-dev (>=3.2),
> ++ python3-all-dev:any (>=3.2),
> +  python3-pytest <!nocheck>,
> +  python3-pytest-cov <!nocheck>,
> +  python3-pytest-timeout <!nocheck>,
> +-- 
> +2.34.1
> diff --git a/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
> new file mode 100644
> index 0000000..9687222
> --- /dev/null
> +++ b/recipes-python/shtab/files/0003-Lower-requirements-on-setuptools.patch
> @@ -0,0 +1,43 @@
> +From a4d6204b7fe5af89f7edfb9a6d8e58455ee73e46 Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan.a@siemens.com>
> +Date: Tue, 17 Jan 2023 19:06:50 +0530
> +Subject: [PATCH] Lower requirements on setuptools
> +
> +Allows to build against Debian buster.

Why do you drop the original patch, just to reintroduce it here again?

> +
> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> +---
> + .../0001-Lower-requirements-on-setuptools.diff      | 13 +++++++++++++
> + debian/patches/series                               |  1 +
> + 2 files changed, 14 insertions(+)
> + create mode 100644 debian/patches/0001-Lower-requirements-on-setuptools.diff
> + create mode 100644 debian/patches/series
> +
> +diff --git a/debian/patches/0001-Lower-requirements-on-setuptools.diff b/debian/patches/0001-Lower-requirements-on-setuptools.diff
> +new file mode 100644
> +index 0000000..257c054
> +--- /dev/null
> ++++ b/debian/patches/0001-Lower-requirements-on-setuptools.diff
> +@@ -0,0 +1,13 @@
> ++diff --git a/setup.cfg b/setup.cfg
> ++index 77976c4..8857d32 100644
> ++--- a/setup.cfg
> +++++ b/setup.cfg
> ++@@ -65,7 +65,7 @@ classifiers =
> ++ 	Topic :: Utilities
> ++ 
> ++ [options]
> ++-setup_requires = setuptools>=42; wheel; setuptools_scm[toml]>=3.4
> +++setup_requires = setuptools>=40; setuptools_scm>=3.2
> ++ install_requires = 
> ++ 	argparse; "3.0" <= python_version and python_version < "3.2"
> ++ python_requires = >=3.2
> +diff --git a/debian/patches/series b/debian/patches/series
> +new file mode 100644
> +index 0000000..804951a
> +--- /dev/null
> ++++ b/debian/patches/series
> +@@ -0,0 +1 @@
> ++0001-Lower-requirements-on-setuptools.diff
> +-- 
> +2.34.1
> diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/rules
> deleted file mode 100755
> index 2dd07b2..0000000
> --- a/recipes-python/shtab/files/rules
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -#!/usr/bin/make -f
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Felix Moessbauer <felix.moessbauer@siemens.com>
> -#
> -# This file is subject to the terms and conditions of the MIT License.
> -# See COPYING.MIT file in the top-level directory.
> -#
> -
> -export DH_VERBOSE=1
> -export PYBUILD_VERBOSE=1
> -export PYBUILD_NAME=shtab
> -
> -ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
> -export PYBUILD_DISABLE=test
> -endif
> -
> -%:
> -	dh $@ --with python3 --buildsystem=pybuild
> diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
> deleted file mode 100644
> index d03e694..0000000
> --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit dpkg
> -
> -SRC_URI = " \
> -    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
> -    file://0001-Lower-requirements-on-setuptools.patch \
> -    file://rules \
> -    "
> -SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
> -
> -S = "${WORKDIR}/shtab-${PV}"
> -
> -DEBIAN_BUILD_DEPENDS = " \
> -    dh-python, \
> -    libpython3-all-dev, \
> -    python3-all-dev:any, \
> -    python3-setuptools, \
> -    python3-setuptools-scm:native, \
> -    "
> -
> -DEB_BUILD_PROFILES = "nocheck"
> -
> -do_prepare_build[cleandirs] += "${S}/debian"
> -do_prepare_build() {
> -    deb_debianize
> -}
> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-3.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> new file mode 100644
> index 0000000..9d2b1f2
> --- /dev/null
> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022-2023
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-gbp
> +
> +SRC_URI += " \
> +    git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
> +    "
> +# modify for debian bullseye build
> +SRC_URI:append:bullseye = " file://0001-debian-control-Fix-cross-build-issue-for-bullseye-im.patch"
> +
> +# modify for debian buster build
> +SRC_URI:append:buster = " \
> +                        file://0002-Lower-requirements-on-setuptools.patch \
> +                        file://0003-Lower-requirements-on-setuptools.patch"
> +
> +SRCREV ="5650535ae4a1d34a21b55dc61e3e891d87a9712f"
> +
> +# We don't have pristine-tar in this tree hence use this option
> +GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
> +
> +DEB_BUILD_PROFILES = "nocheck"
> +DEB_BUILD_OPTIONS = "nocheck"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


