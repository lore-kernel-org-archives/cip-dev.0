Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AABC001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 13:18:03 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.88])
 by mx.groups.io with SMTP id smtpd.web10.107305.1692019077428495557
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 06:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vdrUbr+5;
 spf=pass (domain: siemens.com, ip: 40.107.105.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abv/6KJoLMZtJRPAKPYIWRKIl6wIKjdwkGsZAviH8Ob9ZrSGXvdQrc7Zrr2Usy23rlHPNxAKnXxdN0pqE/vRFRz3dYglX4RdaakvUvinRhPzNDlr7rJ4iUjaCIXgMSYtdeR6id4j7K+4os6kQLXPJBLUKnjnTQejlCaTYOrdFICi+QMCZY+z13COT4c0yB3nMmuwSQoFqSkEH0YioapCPM7gb2x9YA7ywGSTsL1ps3qJAQXjmkhsrn17hs1BwGTiekY/L2a5cm99oWePs6JEvQ/TYnp6dE1NVvoKuXyi9mtjgPowOScKbL329igvUYqB4ofhyGVwpM7RhLqqEyHE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpx2jghRNkhPiFzqSqrx+Lp77mNc1G8MRN9mbb04lMo=;
 b=MJ+PhwupepMmul11Obb2ZJFWx6aq4uMViABaB3kr6SaXfNVil9avH4MoQc939fCIBw3/8n8TdgiVBlAJyc7m8Drz/xfbLPQhQ/B9Cw2M+qO9JEHM21YNNWrSSRoJy+Z4Lon4pBIN0WL7aIreArlH3KqzIu9MvuxUQroCfNSbtaSZ8ZTygbZVvOhI8wgRf6/Nwg68zl8SC6tMOVnfemajtPRNJyo++VzNP4VDcnnaTkkaaTCT2EVG7ouQK1UexFhsSe077u2xWUof4j9e/P2lfDduwEywEq8Q6/ILYqrff2WRoHhcWuuqJXV7gYgktJcGLWeWv0mOcZTwCjsvQSoSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpx2jghRNkhPiFzqSqrx+Lp77mNc1G8MRN9mbb04lMo=;
 b=vdrUbr+5oit7jkFAGpr3d/ge2VrOToNdsJII2d8wUAIMLTkSm/uXJBqq8DD4gjjtjNM0n3dPVjBPiBN+JA74vomniaEJm8UIht7598oKOC00/Lm1lsK+uULTMCq6KnyjWxQaWgDUh2quftsUt/ApQTOE0O4jS45oPbEpTYbhsTefWophRWHuA5+DI/62beLynr497Kd4KpDT1BqI2+C8O0zx7UpOdFieMdi75nE6KbZQdfjCJfDRwaL/anmU5JspSrcv3plmRnIEgH+TszcsgD1ATBEf+tlaZQpfvDnZLu9g+gsQqHUslYtAei+JiC9EyQ7x0cPkDA/rgt/iumULXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:17:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 13:17:53 +0000
Message-ID: <233ad9a5-9b54-41d9-89b5-2b629464d461@siemens.com>
Date: Mon, 14 Aug 2023 15:17:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 1/3] recipe-devtools: Add recipe
 to sign SWUpdate update binaries
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717105417.27761-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: ddba7de2-18a7-4308-e58e-08db9cc8de1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3IlhIwlSs90CwAEJq3ktHMaDzOIJRbzsH1TZzZCGBajhlbC3HstNHZ597h5e8aAMacMKlAp1fLl37qUr51jYcvvTzZezm1BTt6GzZYSTkNemwFcs52jNO1JqoimbpDoOkHqP/aLr6AcYfHzUXS00ItM9ZdxD3QEzR3B4MOo9tBwzUtqxlBMt9IVDZRM9omWs+GBLrGPBu8q1WXtepE2fYkX1zFuIL1nLZVe4uLjB64vWOhsUEAEJZcH2dpqO2xSTszVqtM/OuRGhRlaPTPdTe4buPJyUV2pxLUEJ7dJuNFQf9X2fVKKLoNJccR/o761Jh1Gz1w6hQnJIq5xLSPkwwhpvoxstFNFeuPAKMw0oltXQYSeyoWtFhb8XW3gPg9DYhTrsfNLzRGcbrlxkjOnU6BekZX5A4lSDPW7zrjn7uF1bmFymM+eDOmZ9CrwG0P3E7BfJWThidg+FBqYXr1bYoJKErAUla92v/CIoXK0eCbNZtxJLx/lLZC9zUAL+jAin8o1pVcLzPkRhVkA/9BcWgYEUoCMV+bg1L1Lw7SlsTVP3ugAiXkTbhDhZRq+a2E0h7EUFuZd6ULa1etCmNXy8mjXqHyoi4ey3ZFrVlnWOa25oMQqKAnIBOGif62YuBVztfuZCbK3McyDcxXZDR/nqzQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(186006)(1800799006)(31686004)(966005)(6486002)(6506007)(478600001)(82960400001)(83380400001)(86362001)(36756003)(31696002)(2906002)(15650500001)(6512007)(26005)(66946007)(2616005)(53546011)(38100700002)(316002)(8676002)(66476007)(66556008)(5660300002)(44832011)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTVvenIzUlAwRUJXSkQ3OWl5TlNmK2dHZGpyMnN5MzcxTUp1V21UekF1MThZ?=
 =?utf-8?B?S1BMSXlmcjFwVnZTaVk1YU1VWWV0dkcyakxBc2VzT2V2M0ZzR29nZElKcG5W?=
 =?utf-8?B?eGVybFVzQzlSd0kreWkyNXI5SXJwTERDdkEvSGdCWXl0dXovWTFKTUJ0UE14?=
 =?utf-8?B?NURSbnZvTU9vajRmNTR1ZElPSi9EZExOOGVZcU41ekpBV1FSU3M3NGg1aFNJ?=
 =?utf-8?B?eFNEbXJoWFhvUVFCZWNic2N3R3NvRm51NHBob1U2djVMY0hDTGNlenEwaFVt?=
 =?utf-8?B?SHB3UFNqMUsvd3JNclpXdzREdDhWUFlhSU1vREdENWpSZ09JTHYva3NCNFls?=
 =?utf-8?B?ZGV6d08xbEc3T0VvMFk1dWNKbmxsSWR6ZkdIcmZQcmY1Mm9UZHVxQVM1T3Z2?=
 =?utf-8?B?QlpZTkJORnhQbVJTVDgzeCtFTHExNUFZQ0kxYlNkSmpGSGlGdG5CYUJXTWZN?=
 =?utf-8?B?aGVKeGFBTGFSNFRja1dIZlphTVhJZ25ISkpUZ242STg5MnFmeWFMMzFRN0Jt?=
 =?utf-8?B?U1J4SWlQTjY2VmkwMVdpYXhkbHZCTU9OaUVsWVV6Ym9reldGK010MHgzSVR5?=
 =?utf-8?B?TTdjazNkbW0zZUZESG1OWStldExieEFlUGxVdVVZOTlyYlBxT0pqWkZRVFk3?=
 =?utf-8?B?SmNnVFRUaGxLTlFKc1hqSjdEOU1DVkVaRFRvdUpIZ2Y0Ry83NXpKWFR1SGh4?=
 =?utf-8?B?OEkwN2xldVM2SVJndGpXZlFQRzQ2OVowbnRsS1I1YUs0cWFmKzBKam5qZVVC?=
 =?utf-8?B?bDhDeUtVaDJrcW1ZTWVYYnltZkxkVmNRRWJIT3BwKzN5L2hIWCthbjdFZXNW?=
 =?utf-8?B?ZkRDMUhpUUZkQWl6Zit0amhENlpGVC9RVGVEWDhKSFAwaHcwOVQ4dW5UcytT?=
 =?utf-8?B?Y3doQkNnT3pBSVpxTVRiOGZGMnFNNk9Jdm5VQWVRZXF4RDY4QlBKTjRSOTM1?=
 =?utf-8?B?eWRSa0NEMjcybDRIMnBhdWRlNHlHR0FvN2dHdy92QTZIcVErL0JRNEp0aDIx?=
 =?utf-8?B?b0VmVkhBWnRlRG5kaVhocXAzSWtwc2VQWUVKZFIyT1J3Mkg2eDlSYngrZzFm?=
 =?utf-8?B?d2FnWGI3ZVEyQTBxSEoxTHNYOExmMzV0NWFKWXhmeW9DenA2T21paFZCTUFK?=
 =?utf-8?B?NVpRVnV3QlZ3TisxZU9qYmVIcmFXbW5uQ3BZTVh6R3RRZWlNcHp6bnRMOFAr?=
 =?utf-8?B?V3FEM3ZROFFGZXpmajVWYnJUb1BZZSt4Z2RYd2F2dFRLUXliZThlUFRBNVhE?=
 =?utf-8?B?SE5QaUlqMm5weUhXeTNFM201QzJhWUxRZ3NsYVJmYnZ0U21XbzBDelYvTVg3?=
 =?utf-8?B?SjkzYTA1NEoxTDI1SnEzV2VqS21VYXF6TlJXWG5xdzNJVlRHNGszVFhCQVNy?=
 =?utf-8?B?M2E1a2JPQyt3QTJqS0xVei9rUXUzYXc4ZEVpWUU4c3plM3U4MUlRbFk1eHdj?=
 =?utf-8?B?UG50NzFuSENxdmZQbjNTMkJxM0xndmx5UklSZUtJbHJLUTNaTk83TUJVTkky?=
 =?utf-8?B?aVZodjVpczVlNWtwc2dkZ092UkVyaDNPZUE5ajhvVmlVN2RiNlc5OFdGaUpN?=
 =?utf-8?B?SXVtTDRkVTFIdmlRTG1PQVErQ2c1bmxrSHozdmh6YTc0SnBYam0xQnoxQ1NR?=
 =?utf-8?B?ZVFNaklVTzhEU1VRK1UwbG9JTUs4SWEyOVhTRm91RUhBMW9CM21hcXFpZ3Fi?=
 =?utf-8?B?S2R6M082REg2SGYzVW5qL3J4RGxxTHJGQk9zQTYxSXVRZ2VwMlpBT29BY2FV?=
 =?utf-8?B?SXk2OGVuVlVEL2RjekNRenYyMVN0bU1kamxYNmxtbDdTdVg4UU5zazQ2a1ZX?=
 =?utf-8?B?cjQ4ZC9GSml3VTVYTS9helhiTi85UkhMNjBwMFA2dWRrMWp4L1l6czdKdHlH?=
 =?utf-8?B?SURWOE0zUTY0djAzTjUzQTdKZ0Q2V0pEYTBHcmxxQlJoT1IwdWFkZjd3MFFa?=
 =?utf-8?B?dVd2eDRkMFVZcFhNaG1RNDZYWjRWdklmOC8xaktjNGd3Kytid2gycXpWdHJF?=
 =?utf-8?B?WUxYdnJKREZMNlpjTEs2MGZ0RjNmdG9qdmFUZzg5UEgxU3hDUVRmMkkxUklp?=
 =?utf-8?B?R2NaMmxxQkIxbEpRUmJqWFJWd055UUNON2RKYU1hR0h2Nk40RU8yRHZsNnR1?=
 =?utf-8?B?a0ROSFcyNGFhdW1XbmlSSUdjekJWQ2UzY24yTG1ma2R2a09HSm43YjFXVkxV?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddba7de2-18a7-4308-e58e-08db9cc8de1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:17:53.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/0TxBZ4ex1uC9SDBMTZtuuWhXo65y3K/Kc9DJayRwG0HTB9awRiX5hVprmZsku2tm1u/EpA3iegRvbjiCytPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5691
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 13:18:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12650

On 17.07.23 12:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This also adds recipes with the Debian snakeoil key and
> certificate to test signed updates.
> 
> For in-production new keys and certificates must be created.
> [1] descripes the creation of keys and certificates.
> 
> To use non snakeoil certificates copy the certificates and keys to
> recipes-devtools/swupdate-certificates/files/.
> 
> The following settings are necessary:
> ```
> PREFERRED_PROVIDER_swupdate-certificates-key =
> "swupdate-certificates-key"
> PREFERRED_PROVIDER_swupdate-certificates =
> "swupdate-certificates"
> SWU_SIGN_KEY = "<name of the key file>"
> SWU_SIGN_CERT = "<name of the certificate file>"
> ```
> 
> [1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/swupdate.inc              |  2 ++
>  .../secure-boot-secrets/files/buster/bookworm |  1 +
>  .../secure-boot-secrets/files/buster/bullseye |  1 +
>  .../swupdate-certificates/files/bookworm      |  1 +
>  .../swupdate-certificates/files/bullseye      |  1 +
>  .../swupdate-certificates/files/buster        |  1 +
>  .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
>  .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
>  .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
>  .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
>  .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
>  .../swupdate-certificates_0.1.bb              | 14 +++++++++
>  12 files changed, 134 insertions(+)
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/buster
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 6a01abb..5d9cd58 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,6 +12,8 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +SWU_SIGNED ?= "1"
> +
>  IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bookworm b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
> new file mode 120000
> index 0000000..b7dbeb4
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/bookworm
> \ No newline at end of file
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bullseye b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
> new file mode 120000
> index 0000000..3c7fe4f
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/bullseye
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/files/bookworm b/recipes-devtools/swupdate-certificates/files/bookworm
> new file mode 120000
> index 0000000..b7dbeb4
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/bookworm
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/bookworm
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/files/bullseye b/recipes-devtools/swupdate-certificates/files/bullseye
> new file mode 120000
> index 0000000..3c7fe4f
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/bullseye
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/bullseye
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/files/buster b/recipes-devtools/swupdate-certificates/files/buster
> new file mode 120000
> index 0000000..67d1534
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/buster
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/buster
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> new file mode 100644
> index 0000000..a0bbd50
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +DEPENDS += "swupdate-certificates-snakeoil"
> +DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
> +
> +require swupdate-certificates-key.inc
> +
> +SWU_SIGN_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"

We are missing artifacts for sid-port (riscv64) here. Can these be
mapped (linked) on bookworm?

Jan

> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-key"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> new file mode 100644
> index 0000000..1b6b6dd
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES += "swupdate-certificates-key"
> +
> +SWU_SIGN_KEY ??= ""
> +
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
> +
> +do_install() {
> +    if [ -z ${SWU_SIGN_KEY} ] ]; then
> +        bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
> +    fi
> +    TARGET=${D}/usr/share/swupdate-signing/
> +    install -d -m 0700 ${TARGET}
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
> +}
> +
> +do_prepare_build:append() {
> +    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
> +}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> new file mode 100644
> index 0000000..2e99617
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DEPENDS += "swupdate-certificates"
> +DEBIAN_DEPENDS += "swupdate-certificates"
> +
> +require swupdate-certificates-key.inc
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
> new file mode 100644
> index 0000000..22c7ce2
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require swupdate-certificates.inc
> +
> +SWU_SIGN_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> new file mode 100644
> index 0000000..0553c25
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES += "swupdate-certificates"
> +
> +SWU_SIGN_CERT ??= ""
> +
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
> +
> +do_install() {
> +    if [ -z ${SWU_SIGN_CERT} ] ]; then
> +        bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
> +    fi
> +    TARGET=${D}/usr/share/swupdate-signing/
> +    install -d -m 0700 ${TARGET}
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
> +}
> +
> +do_prepare_build:append() {
> +    echo "Provides: swupdate-certificates" >> ${S}/debian/control
> +}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> new file mode 100644
> index 0000000..2643aad
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> @@ -0,0 +1,14 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require swupdate-certificates.inc
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"

-- 
Siemens AG, Technology
Linux Expert Center


