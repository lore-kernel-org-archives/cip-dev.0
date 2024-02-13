Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDDC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 06:41:12 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.53])
 by mx.groups.io with SMTP id smtpd.web10.6016.1707806464640249407
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 22:41:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K1CHPZ5U;
 spf=pass (domain: siemens.com, ip: 40.107.21.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/mI86L7ofrlCmz8zWer6YAmAhEbsynudYHEScMfq26U6h4IbdgL7yBNjf5PROoGromZGqU/hW124RFdyQyRckrnpi1/ATxnwFNzBHAdhyMpHz3nm+Jg1NhJrslDUGNvt9eSVcibA3fYps2iVOQ4I6vhsF/XxD98h+VlYRvvmIrzScv0yNJ9uUx0znNNwiJhLTuxvRSjVdMWzqjrq/9jznRiZUMdYX95Z1q5qWDwMYVsnXRLhMTc5iz1I9+iY9/s3UUl7rVaaWg1mqx1Q46Ilk0MvrTPY2bSnVIEZqdVtLaSY/qlTgPTMqz7bCbx07a0/6i6ea0hy4rXjANfB13y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Y4ykAZktu9E7LizvtAAdhXvPDjMTGokgdAuuyy82M=;
 b=AbXdFGBOj8ytQeP1n1XNLIDg89cPMoNCjTEaCCz07JgD38cA+kpQkqi8fd+8eIfqIV8J5N4uQwwC6FbhlypEH+jB0efgBUF3arvgGW+klMM6rJedwV6G7xE+kSGdSNSDS+0ljEKaqb1nA4rjfykCXQHtEKrHvF/PQ+DhjMLPX+FTKtveOe0oTZH2Gjya7Ey+1aPb1MSa2Y4nHA/jmxerj/zAw1tmEpEUj6tJvqo93ygp9rSo8b2psx7Awc6rva1WAQ9uUv8LhmEHKLAS7k2kthsnMm5jMJovBNuGIOrpqImVxzkjP6f+if/O0b7MaOeoKuoPW+wOG0vyr/tVBxH+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Y4ykAZktu9E7LizvtAAdhXvPDjMTGokgdAuuyy82M=;
 b=K1CHPZ5UDN11mcdTtCkQWiO7S5m6i4/M+fyxuFIn8iQeowyPPVGpbtZ/EBVNY1LZJogZlc4nFjQep783qh+sJez7HK8O+xKWkcEnBlKB2SzE5iSvZiZOHRfDpodJKd8644S4d0uM/BIc1sZamL1zfOy8SKf1uPPfGYdya13fu7xxNMAgjTGNFjqPmZWt9qX3cnH9hQe6F0Eu7N6NQwEqN5h7GXarxDjtVqI54lFOpdmQSTOyvo1+soqLM787r7NmGaepbvuKEq42GV0ZZU3agx3FXUrj+h1seCxAbhH/VmRjSKMGFF7v2ztv6mHcIMzpjreQumWJo2Fpgn4VAH9G/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 06:41:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 06:41:01 +0000
Message-ID: <a2a4be58-7299-4d2d-a04c-c60425256763@siemens.com>
Date: Tue, 13 Feb 2024 07:40:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update certificates for sid
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240208102314.169456-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240208102314.169456-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: aff00c5d-c96b-48ce-b990-08dc2c5ebe28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wBAwVrNc8gkF214uYIhQvttOgAuiWtUN0etD8n/jKD+X4oKzOiktbEpXS2QNMEEY/patgM7AUp4Xy1LjwtQmW5/GxDQJZonil2ISjnorC012MbbYX9gxap2KyLCAnCIT62lZL89bHQg7WSW4qr0djJ1kegYb9NYG+QECUCrRcES0OR8vBcahFI/9qyTE85YeHVq7rDiJtb3HK5CcJL6RYrfh9vb6Rdxpsx0f18/gOPzef8uOOURoFZG5iJ5RucQFL522iRAYUA0YrKd/q/hQKgbFnpY0ghxOI26oEKhYM7H9kXcSroE9TGI7SKUUvXgc9FSKht3Z+2uAZUbaUHuav+QvEOnYyp/CuCirPAwobESLhsD3k1V7dj2+MCLPflkEHeyZ5BxTMdaOizk2QSpTn154H6fzMR7ASM/p8K7lk9wO2NjxQ2ZXMjBQwQGgOGnGVeVQODj3uL2Dz+rzNGWM0rS28hPxCRAJ93D0l1VreWx3UpJRvK35cLSk+SSsNQcwFWQoZC5OF6YLCegbHqE1GX3oRpWpuVOoFrBRFyF3QOM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(66556008)(66476007)(44832011)(8676002)(66946007)(15650500001)(2906002)(36756003)(82960400001)(31696002)(86362001)(38100700002)(83380400001)(316002)(19627235002)(478600001)(6512007)(6486002)(966005)(6506007)(53546011)(8936002)(2616005)(41300700001)(26005)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWE3ajhPcnVTY0dxT0J4MVdyQmM0NkJaWG1odmFFdjNGMHAzN0huYWtQNXFL?=
 =?utf-8?B?MHRUczNQVFgzTS9JMUQ3T3ZyYU5WZmJGeG5obE92cWhFbXZyaWV6U21lSUpm?=
 =?utf-8?B?OGlwc29USnExRUdxcWJvOTA4eWt6VjZxMGx3T1ZwQ0Y4bDhXV3c1cUlCT1FT?=
 =?utf-8?B?Z3JWNUpqUVpmeWdmNkMrUkd3VUpVdnZ6ZFc0ckpqZVJCbTRYVzcrVW5KMlJK?=
 =?utf-8?B?alBlUlBYc21PREdpSk1kOFNETjY3MUJBcEJjR1d2T0hST00xN3VmcFhDejhD?=
 =?utf-8?B?Nm4yeXVmMUJWS3ZiTnRCRVVibUMwTSsxQUFJWlp4RER0bDlybUlLV01sSVhL?=
 =?utf-8?B?MEdhTFpRb3ZFUjBlYWc3cnhycXdsTzNaWmZxNlZpRDVJSm8wc0s5VW94SW5I?=
 =?utf-8?B?Qjl4WHVPN043TTBWRUFLenFuSU1iYUxORWw3UGRTdWo1ZXdpMzFJZGNvbHhW?=
 =?utf-8?B?K3A3VUN0RDlna2thVE5pWHJ1eGdNeXAyTUxaMWUvQTRvb0x2ZVpZUmFGNm5Z?=
 =?utf-8?B?RzlOR0ZjbFpIY2dLbjY4UGkzVkVPempVYmJaRXdHc0p4OWEvV3I1ZFRVSFRL?=
 =?utf-8?B?V085bERNQ1hITzVVRmRURUFkV1FBeWFMOHl1U1VXcERTQThnMjgzS3ZKZUtu?=
 =?utf-8?B?YzhubTB5b1RYZyszN3FwNkV6dzVxVUt0UlZHMmJTZzBSKzNqclJJcTJYOUJX?=
 =?utf-8?B?OVpNc2tCcXhSOXc1OWtMWGYzaCsxeDh3L1dkMjhVTmdhbFJMcVduK2tDNkNm?=
 =?utf-8?B?Ym8rc3QrakkxeFp4VTdsSmFWNStGOStTSk9NZUZoRDJ5cjhyQ2M4TzZidUMz?=
 =?utf-8?B?d1drcUdxbThQMmdZTVJHamZ1ajNZR0pkT1k2cVdhMUhWWjk1dFhPVHBTbUFl?=
 =?utf-8?B?Z3RKWU14a0hiRkczaWpvR2ZDUW42dDA3dWJCdnFVK0RGTmpIYXp0THM4SmRy?=
 =?utf-8?B?MXRHQlc4bTl4Y3o1amR3RnRPVE4yc1FTYmVVL25uaDZicWdvRkw0ZFp2Q1Nh?=
 =?utf-8?B?VFFoZE9HNDFodkJaZU93NDhBYzRJOFo1Zlp4azVWN24zQUdlU1VhQlBmMVNq?=
 =?utf-8?B?QWZUUzFTSURxSzNBQy84Nzl3QURMei92MUlyTy9pUFFhL0RJRk9pSnhkNVlo?=
 =?utf-8?B?aElHSGhIcHBRUThEKzlpekk4eVhYb2N1a0U4TTZkZ2U5ZkR5MUtHN2oxZkRS?=
 =?utf-8?B?SzRQZ1lBbEtjY01lTUZoV2NKNExQM0Mrd0tmME5CdDhWTHhYL2pqMjZtSUpB?=
 =?utf-8?B?LzdmVkRHaXFFYnI1RjZGYXUrYTB2V0k4bXN1UGFqS0RNUXBRazdxdnY5SjZk?=
 =?utf-8?B?cmN2NWticHIzMFVUeURvTHgyd1BCSWVxdE1vOHc1YVBySnBlSU9LdnhHOFBr?=
 =?utf-8?B?ZkZqNy9kV3oxOEJ2N2ZIT2N1OW56aVlzZWNXQXFCVkprbDF0dGZBdC82WkNU?=
 =?utf-8?B?cVgyUWtJK0FYNlJQNVhRTnVISTIrcGRzRGYxdlBLdFdyZ1ZaUmRvbjNraFQ1?=
 =?utf-8?B?WFExeGd6TDlMVjVzdDZvci9NYWZRRURzaEFQRWlSdXI5ay9acnlsTE40RVNm?=
 =?utf-8?B?c3B3TnZSYlFhVlBsU2xNRUllU1FXaUlYVzZ1b2krcy92TStpcjF0dC9jRnN3?=
 =?utf-8?B?NlZHV2pYYUNERjNOdUlyUWJYVTA4Z3RBSE1GUVdCdkE3SjdMeC83TmFrczA2?=
 =?utf-8?B?YXNXOGRtb3E5bU9kZUZ6akxUYUE1QytyZ01vTEN6NjJURngvcG55c2sybjNZ?=
 =?utf-8?B?ZEJHZ3d6Uy9HYmhFbkttR01qM251UWVWWFgzRVQvKzZ4dmxSaGg1R3dhcFpC?=
 =?utf-8?B?eDJYUDFLV3Z3NU1zUUQ3VzN1RU1ET25lMGUyYXlGd2wzTDlEbE1KNWhMcXVY?=
 =?utf-8?B?N0RScG5Mak9xd2NnY004QmlOUGtiVER0UWkzbnh0QXZNQ09zS1BOT3BMbGxE?=
 =?utf-8?B?UVVDWEZTek5nK2NJN0xmTWFPeTJwL2JQVFNMR2EzeUhQMkp1V0JiSENvWU9s?=
 =?utf-8?B?bGpETFMzbjJEbWV2ckVGbHdoVjVMc29iNTVRb09BdW0vZUxmL0dkYUZEV1BM?=
 =?utf-8?B?NzVLU2FFbndlY3NUR2laMGNId0xGNXVTbWsxNkQ2WmVPQ1IzM1V6UUlzaXZ5?=
 =?utf-8?B?SlJOUXFDREtocXhkYzFRWFl4bFhMdmorbjJyYmhHd0xscE1IRkJraVRxOWVp?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff00c5d-c96b-48ce-b990-08dc2c5ebe28
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 06:41:00.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huG/mOOGa9SpjATD0tei2L2VmY75GJhvL7RS9GS3rEziioRmGu4mVDtAdu9v5pKqRr8MCCOJxDGpZEQl+JdxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7420
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 06:41:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14932

On 08.02.24 11:22, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Debian updated the snakeoil certificate[1].
> 
> [1]: https://salsa.debian.org/qemu-team/edk2/-/commit/892a23a65fc397c784bc905b4235f7efede102a3
> 
> This fixes issue #97
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/97
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../secure-boot-secrets/files/sid             |  1 -
>  .../files/sid/PkKek-1-snakeoil.key            | 27 +++++++++++++++++++
>  .../files/sid/PkKek-1-snakeoil.pem            | 23 ++++++++++++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
>  delete mode 120000 recipes-devtools/secure-boot-secrets/files/sid
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
> 
> diff --git a/recipes-devtools/secure-boot-secrets/files/sid b/recipes-devtools/secure-boot-secrets/files/sid
> deleted file mode 120000
> index 91bf492..0000000
> --- a/recipes-devtools/secure-boot-secrets/files/sid
> +++ /dev/null
> @@ -1 +0,0 @@
> -bullseye
> \ No newline at end of file
> diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
> new file mode 100644
> index 0000000..193de62
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.key
> @@ -0,0 +1,27 @@
> +-----BEGIN RSA PRIVATE KEY-----
> +MIIEowIBAAKCAQEAyIuuXei5qIw+UvavLxPyyNhx0G6Ijuf9SqxVXOpKcQ+l3ZCc
> +KQaCLWCH0pbPQj587zVjgMUd4SHgXdVP6awDz8b0NcLgyzF31pHBmmB3z55nv2Jb
> +gI56bix9TEHLpoDs4+cWAb2WZPkW8rV/6YR+xVuE8fi9aAWJ7H4dwUhPzU7RBB1d
> +Z1wF6Wv3b8nn1jJa5W8I3zOd+tpWczOsqyRnDnFhMiOulGAiFTtmIXv2VReQf7Tx
> +rXdqAAs9dcS3qizzNVgY5XpABtmYu1AjyLwwqXZ+blZ2tmUUJicgw3YdCWtlTAtf
> +XZDHf+ZzgCNtTvhb2DzpAVmF/H+A8w8lUJZiBQIDAQABAoIBABET/BRZNj5JOyF7
> +im2a6Ej8TazvTMfGr8ZFKLvR4+b+6yQUJYhE2p8colRnrVy5z4/bXw7fOm0qol27
> +RaPjlyuBiNhvMQ98tfTa0r7fyjQvDCy7JomrGHf7Z+wvijUys3mw+ynIyF7u62pd
> +1HfBZb5OzeKBSTfriNRP5R7JlqooDl+O9JVlnvlJIaFe1rX2sQxZ7F8gVINKIJDv
> +n7ZZ0o351uIMjKLqwmliULPTjZ2ZeeJqnkB0pFcWZzEf2wAnrrglYRdnn10oNzhB
> +6cXMHJeuEOedXECLZtmynRw1dWZK9+Xku1jEAqTWAoI0OIjrfYYzntwe/kab8w/R
> +T7ojFGECgYEA9rGhtmSQiim2h+3iGyXNTEQiEOFFL7E8/1ibfWi3vzDhoLARrnH1
> +p45DPgnL664xLHXIUl6/wto79Ij/2qA9mp054nVJ4X4AQgq3xCT/57nL0QHfQLaa
> +VdzNIoz4jJT3cO0gYcBAK4Bg+dGGQ6ZUrRRt6VkHG/W6fW0D1e7PnEkCgYEA0Bxj
> +Jr4ShNXb7J4YDQ24uSwmc2E1IgX5FjHu/JMKCiyIDWQkrxtVdIL9v6+kmYecyxFJ
> +S3Qyr3ZqOHqwN1svYuB/CHyKg6dHrzJyZFTj8cr8h0ZKLDu2xZNFxfBIjn5vitSX
> +W9q3477oFG/30Ew12Yee4NhDQkaEuB/Ic9+yv90CgYB2y00rLrwnvDSIunXiSs7U
> +xg59gG03rSrJb5rYxj+NkvVj0sWA8qGwASLCUidfo69MUJ+ZgsTnCP5MIFjMp9Ni
> +jAne0ko0it+G7fBWRNbyeJb8W+FtIUGqzTv/QlFCKU4KlDW+vLxp9lU8l7gHBabK
> +/gZ7kwKIZUlbss5hC7Hv+QKBgQCsQBLBKmlhkTEqs9/sTgMrISPiM/8qXg9BE6tf
> +WsTgjuM9UjoaxWEBwroMQnDWsqxQV8p2rYKWQEjC3qmj59Fc4bvDZnGvbnGizPpp
> +mOniY8SIouEZo4MwHSmPH8auSnBAVJ3C5VF3K7gj0lknCy03E02phNaGsJ+BVq0v
> +W2Qz8QKBgEB5RKiwJhgGQA2o+NJKKUUCDM9iBsO1Yy3QwtDWioKKcdAkxdTg3xR+
> +XtJdXq6MkCMWM5em3v6GHPceexn81FZTxGBbIMBYNp0Sp4qs/3lK64ln8m5Qttxe
> +70HVtrp9HhG5oFJ3fUuLPcYpE2GMgPM9fIbAWh9GZ4GpTLuPRtWg
> +-----END RSA PRIVATE KEY-----
> diff --git a/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
> new file mode 100644
> index 0000000..7cd2487
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/sid/PkKek-1-snakeoil.pem
> @@ -0,0 +1,23 @@
> +-----BEGIN CERTIFICATE-----
> +MIID1zCCAr+gAwIBAgIUDMG7xGGEPj+ABvbflim0PNb/loowDQYJKoZIhvcNAQEL
> +BQAwejELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
> +b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMS4wLAYDVQQDDCVTbmFrZU9p
> +bCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290MCAXDTIzMDUxOTIzMTE0NVoY
> +DzIwNTMwNTE3MjMxMTQ1WjB6MQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
> +ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwxLjAs
> +BgNVBAMMJVNuYWtlT2lsIFRlc3QgS2V5IGZvciBFRkkgU2VjdXJlIEJvb3QwggEi
> +MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
> +boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
> +wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
> ++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
> +I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
> +Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
> +AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
> +gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
> +DQEBCwUAA4IBAQBBxlfo6MxBN44mXBIhE/QUbJZ+bo/Vrqv2DIZqOlV5+Sk6KnK8
> +X9Rz2IJwoqLjB6cW9yInk5P/QS45880K1fDT/lu5/2U64i3l1ZFK75qLDCn4/khF
> +birV2U6LBZpxLe3UvXk3xZMoUPzvT2rhrsf78G0pSmAnP8li8Co8F6hTjQzB8IgC
> +DpYVATCoWBH6GhudtjUp+CJSyGApdL+HKX6i6oD7vutvWYBf0Hx5r1NrqIv31Y4V
> +bhwvK5zajFamj/VYeVy7/roqD06hNF1ImhsuBOqoJlKu+cHMGN9DOJqjGup1T9aI
> +2dpEOK5vbKXFrox/yCLgXmUkdwZ3BK4lcxCq
> +-----END CERTIFICATE-----

Thanks, applied.

Note again that a missing "isar-cip-core" can lead to the maintainer
missing a patch.

Jan


-- 
Siemens AG, Technology
Linux Expert Center


