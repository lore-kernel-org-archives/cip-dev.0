Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CEBC47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 14:47:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.72])
 by mx.groups.io with SMTP id smtpd.web11.12992.1704984453975646038
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 06:47:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CmKNULmB;
 spf=pass (domain: siemens.com, ip: 40.107.105.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvlDlC5xLNwdVN0VdwkgDzxbR4eczMGvneq1LjYAtp8f8E+n4igQkeZoWho1w99H6PNqNfX4YGHGUAhYxFp2Eukv9KNT94YzobY0BP8MYX8tY5eE6JbUdQm6S7Mj431vuAzFWF840E5e0P6d/z4VJW2tMN+DQ6xdKuxK0RyA0CbzHirbMVQkppTDIdK3BMO5WX2MaISPBS5hxyQg2tZkx2QNYyX32YMNuvefCQKQ+XwGOB9IrWDzbggS3jLZnnu8VA9kHcg206xIxilJI8UFDiYLi9OKnZazU62/Y8wZDUXc/rUqMkLvNux9GLyZYtjM/YSpMBVSzuyFdwVSGULI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AzxFZ3zgNGimBjCLluAJGjbb4vrha8P9+BxF7yhIe0=;
 b=S5yd+sCOUeYFmocFh1NpeteIKM7iiJSFfa7mYOyVEJACOFB3zWUL334KmRpcwLkfEdhgPyKXSdXVRBGLveRtwlRDjVm8uZBDA8/EAedi40tVV68suZ1RQ/sIKFGrQ+g8LMNJvHmos6+cV50ComQgC0GkrrXyyuQbs7fFDI512LaK6c/FBYcvwRC9hSGWiyMOcyT6iA6k045FZGk+qJbBLjkFYpq5jPmj2MKRdlqA+W6jif5JdmZGa7aZMNbEhYHq3LIMxZlu5Jo+r42V5JmpjXmGlLPPAtHMiEOWsRPd/c45/eVeGv/ZRf98/kCWqUtJp1BJsefCwRF1oUZv1ildwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AzxFZ3zgNGimBjCLluAJGjbb4vrha8P9+BxF7yhIe0=;
 b=CmKNULmBqRihTxp6ZklO5AVYlzXxugACH+Qnm5rvqR+tHCFvszMIHicgz2s8DXthNJGBVlG4eWXie3YUhIcUJVskGLr4KFKxAi9ogYS3XxiaAtkWHJ90MJjWFF89HdqIyvh4PF7t5/OWm72u2g6ckB/TCTXDjqxGISZkj3OpnAvmo66yFnQOzaM/uvDm+2bh4yXhiecCTwrWrVIkXfbNmGAxZZir51icQsGZQlu8v8tGK8StNrKW+T/K5ErcEc2jEfPaBMBNa2GFPngsa5WhzflBKGullf9uDtTMtcBiBlrdb6TXRUZGUWFutsQidKHfljbY0b3GNV/JyIyC64L9Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 14:47:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 14:47:30 +0000
Message-ID: <6cee5609-9b96-416a-b477-e54f29d13287@siemens.com>
Date: Thu, 11 Jan 2024 15:47:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Migrate RISC-V support to Debian sid
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <1cd81bc4-a52e-4dcb-9ff6-48b163bd6edd@siemens.com>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
In-Reply-To: <1cd81bc4-a52e-4dcb-9ff6-48b163bd6edd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 78028bb6-ba44-41df-46ba-08dc12b43c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i3rXOLvqlDI5T2455wfDswzFZ9JNrpA2HOqIx42QBXvmFJgA35cd4VhJWj4mDmZp6HZq23ZV1F/o1m3NMbfNqqS0gDg8mhY6qK6qrT/HPaAu5KL/c4NYKvUTOfizrg1eIYLO9y0fD/b6J/tvxbQFCNgq9DuqLMESnX3lEcC9+Go5Y413/TS3d7Xe/R3YJou737PgtJ3WFbPBioyCHKjWNZUgHSuC8OjYTCd6Aw0g2Bi052wozGqN2YhdP8KnS5+E+2WACLI3YTjWAEOXZc/4OCRRMBZ0AfyHhzrDNLRJu8sLqO1K32hs5M5tELtILk15+PBGa/7IVsMAsxzxWBgyEC87rZPUJa6xrX1XQH7zWAzXjJ1FuRQZyfPmkkYbALaH5fJqoCnlVw0gyAw9OGzMIGlIK61YMB+/sw+weplfj65Zl7rXS9VWqSY3CYuA7P50QsW7uynz9uHCYxhksLCoFbEKi47nVICs9zn96SGlTeVAB3QKeOhD5M0Nol5/Ggo5lkQEHzTFRxi+AaD2SURKhjW+xYTHWbeLgJw2TY45ddXbv5OV7T7AqRV1HNhnuDrP/82VgvbPwANuAP+BouQiUU87H7YyBmlyXl9RD6rj4pydbmtT772VgabyVfkjqa5ASurDXZIfMvVI8gzdAQiihg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(2906002)(966005)(6666004)(5660300002)(478600001)(6512007)(4326008)(44832011)(41300700001)(8936002)(66556008)(66476007)(316002)(66946007)(6636002)(36756003)(110136005)(107886003)(82960400001)(6486002)(31696002)(8676002)(6506007)(53546011)(2616005)(86362001)(26005)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFhicHI4bUF2NS9EUWY5NG9PTHkyR0REbEUxVnRjN3pRS2ZBdlBUTzFUU2ZF?=
 =?utf-8?B?R280cmk1YTdoeWZvdHpIV25HM0FMMU5SWUlSSzFKbHdHMXRSRE1YNzRLMWtT?=
 =?utf-8?B?bWxxbURNeVFjTXk2ZkFyM3ZVUE9uQmo1ZkQzQytNMEJWTitmOTBmQVBuQ0lP?=
 =?utf-8?B?WGV5YU9sQUY3NGpJZ0c2aGg0T0NVZUtFRzRJZHhSc1d5S0dudFVPSTJhVnJm?=
 =?utf-8?B?UFhJTDlTd2Y1QmR6T3RjMktvZHBua2gwUWNNR253akw3blM3dGpRcGlmZ0t6?=
 =?utf-8?B?UFBTOTJDZGJWRHVzSncwaHo3Slgxejg4VXBablBQRWRuTTBMR1BhQ2s1b3lY?=
 =?utf-8?B?NE5zTlp3UHBqb3NQUU9MNy8rTU1YTEVRc0NIS0RFLzdFZkVHLzlrdVFwUFc2?=
 =?utf-8?B?WmEyOTk0ckpDY0pKckJEYm5FaHZrNnBlZkh0Ujh6T3JIdFR5RHZ3Q095TS9s?=
 =?utf-8?B?VVVXcW9oQlVxNGFEYUJ3SXQyZS83V2N6bDcyQm9jUEZvUC94T3ptNzNkQ2NE?=
 =?utf-8?B?alBFOUFiOUpuN0RJV2tXaGJ1d29nWUUrdkNFKzBFN0p6OG9Zb1Y1QXBndmNE?=
 =?utf-8?B?b0tNZUZZNFNVRFpVTVR6NHMvS1JlNUFRcUI5L280YWFiaHVIbDRVaHNBN2Fq?=
 =?utf-8?B?K0FTdVJPK1FZVWlDcmlGVmJwQjdta0x2QnFkY2Z0alN3UjVWRmVySEZORkZM?=
 =?utf-8?B?RVpQd2JFS05mMWRVTEpQRzJMZXNUYUVOMzBKVW1ZN0NYUXB1ZjV1bEhIOWU2?=
 =?utf-8?B?RU5vS3YrcXlYek5NZG5McEpEb0RrbTBEVHBFdkZwc3RYUFBINGRLNGs0RVVZ?=
 =?utf-8?B?SGhKQVJWakNEMXBGQ2pvU3V0ekhJSktxVmRzRlh5eTR4ODNTWUtXUkVqN1R4?=
 =?utf-8?B?TFVIL2RsckNYUDJ1QkhRbm5wcFJySlRrUHFPeVZ2NXRJYjJ2RU5NSlppZUFZ?=
 =?utf-8?B?cm11WVNFRnRCdk5FSkc5STdwVEtUY2FTUnU0N1dHeVhIcEc1SXJpWEFFMEN6?=
 =?utf-8?B?UmNwRWpWNGNXQ09iQmdKaXNKbDJxMWFVTXJQb3RTZi9iV2xTY3FreUdBUGlw?=
 =?utf-8?B?cnRvWFZBMkQ5MWxjVzQ3ejZvZTkvZ1lhTWJQcE5NNkRIbzNBR255OTNqa0NS?=
 =?utf-8?B?V2JSWnBkK2ZDTUZncTF4UlVKMm10Y2lLNGdUWDJVU1V2SHZDVTVHc2paV1dU?=
 =?utf-8?B?UjRFeUJTY1plYVcyZUcxTFEvRU5IK21iVE56dVZ1aTl0NTlQbEt0dTZ6U2M5?=
 =?utf-8?B?aExpa3UvdUFDKzhyWWU5UU54Q2ZPZGozWFdJNkxqRkFpZDlpc3huV3R0WWdU?=
 =?utf-8?B?MHl1SEFlZEJzU09YU0tnZlR0VkZEMlVRcjZwTXFzQUF2Wm9UVzM3OVN5aldC?=
 =?utf-8?B?VmQvU2FvMGk3SVI3TlJXM1c4VzRKN1JtZE5mTi85UVh2TTJmTVByd0szU0dX?=
 =?utf-8?B?eURIYTErcFJJZldXdlNhKzlxdzdNVUlyd3hWQWNSV0cyVW1YY3Y5UmEzRElr?=
 =?utf-8?B?T09SUm9aQmtOdnkvZGVDenp4MmJnQ3puTDFIVkMxTzVPTkJBbXRiRUFLTmQ4?=
 =?utf-8?B?RUNVcXBOL1BDUHZwdmk2UzYzdEVaWTN1YTRNbUwvMTBCTlp1elVUTGo1NjVv?=
 =?utf-8?B?YjJ1bVJKNWNaNVRHUnhGSGtzeGpnaHVsdkR0UFFvWWpJQ1R0YU9adWlYYXlM?=
 =?utf-8?B?QTRoSXFiYVVZQXNXK1Q3UjJnVUZUZDdaTjFWVk1OWVJoMTNuOGplbFhaaGE4?=
 =?utf-8?B?MFU5TTM4SmgrMEpCeHEvZDNPWDVVa1NSbHNsb05FM3V1OVJ5M0NjYlAvMXlo?=
 =?utf-8?B?dHRhaUxlMGNremlOSGpvd0MxNGI2cnR5Mkw3ZGRUNmF4eUM0SG1Vd1lrU3BX?=
 =?utf-8?B?ZWV2Umd4VEoxVGR0SjdMaGgrWUFySmczNXlhZDVuMmZFbXJTSEpoWEg2K0gy?=
 =?utf-8?B?L3JITHdrcTJJaTRuQm45UE55OWU4dTM2enpKRlkvT2hyVVAxN2tLbURNSnA2?=
 =?utf-8?B?UDlhQjh1S3hqYnZiK1BJUUtwMURkaTlEMjkzQkROaXdGTXJ2aXNjV3BFTTha?=
 =?utf-8?B?YlpnV09pVGI5eFEwMWpXVm10NWVuZERjdlliQ3pDVDRUNjk0ZlJZUVJ1d3Rs?=
 =?utf-8?B?T3FCaU1IdUVqZExsUURsRTJMaXVDM1Q1aGlJYnRjUlMrN3pqby9WMUd6ZXhD?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78028bb6-ba44-41df-46ba-08dc12b43c9f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:47:30.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfpxv1fExVU/rIuk1VqvZbNfosdSaQoTrw6FqQbF+2I7qIm/ej7tOciOaLiY9zvziC6z9RgtzHo4UQi+qRVYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7545
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 14:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14331

On 11.01.24 14:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> With the promotion of riscv64 to an official port, building from
> sid+sid-ports became broken long ago. Then cross-building from sid was
> broken, but this has been fixed recently, and the release team is also
> trying to keep it working. So it's time for us to migrate our
> qemu-riscv64 to this new configuration.
> 
> We keep the "allow_failure" in CI as we are still building against
> unstable, though. That may change once things move on into trixie.
> 

To set expectations: SWUpdate does not build for sid right now, thus the
related image variante does not work again. That likely also means that
even the Debian version of SWUpdate in sid will likely not install due
to version mismatches. Would that version otherwise work, Quirin?

Jan

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml                                |  8 ++++----
>  Kconfig                                       |  8 ++++----
>  conf/distro/cip-core-sid-ports.conf           | 20 -------------------
>  conf/distro/cip-core-sid.conf                 | 17 ++++++++++++++++
>  .../distro/cip-debian-sid-ports-snapshot.list |  2 --
>  conf/distro/cip-debian-sid-snapshot.list      |  2 --
>  kas/opt/{sid-ports.yml => sid.yml}            |  4 ++--
>  .../secure-boot-secrets/files/sid-ports       |  1 -
>  .../swupdate-certificates/files/sid-ports     |  1 -
>  start-qemu.sh                                 |  6 +++---
>  10 files changed, 30 insertions(+), 39 deletions(-)
>  delete mode 100644 conf/distro/cip-core-sid-ports.conf
>  create mode 100644 conf/distro/cip-core-sid.conf
>  delete mode 100644 conf/distro/cip-debian-sid-ports-snapshot.list
>  delete mode 100644 conf/distro/cip-debian-sid-snapshot.list
>  rename kas/opt/{sid-ports.yml => sid.yml} (70%)
>  delete mode 120000 recipes-devtools/secure-boot-secrets/files/sid-ports
>  delete mode 120000 recipes-devtools/swupdate-certificates/files/sid-ports
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 1de6570b..81a31c5e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019-2023
> +# Copyright (c) Siemens AG, 2019-2024
>  # Copyright (c) Toshiba Corporation, 2020
>  #
>  # Authors:
> @@ -56,7 +56,7 @@ default:
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
> -    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
> +    - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> @@ -329,13 +329,13 @@ build:qemu-amd64-secure-boot-buster:
>      deploy: disable
>      encrypt: enable
>  
> -# riscv64 (sid-ports)
> +# riscv64 (sid)
>  build:qemu-riscv64:
>    extends:
>      - .build_base
>    variables:
>      target: qemu-riscv64
> -    release: sid-ports
> +    release: sid
>      use_rt: disable
>      wic_targz: disable
>      deploy: disable
> diff --git a/Kconfig b/Kconfig
> index f5ea5aff..d0dc13b1 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2021-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -136,8 +136,8 @@ config DEBIAN_BOOKWORM
>  	bool "bookworm (12)"
>  	depends on !ARCH_RISCV64
>  
> -config DEBIAN_SID_PORTS
> -	bool "sid (unstable) with unofficial ports"
> +config DEBIAN_SID
> +	bool "sid (unstable)"
>  	depends on ARCH_RISCV64
>  
>  endchoice
> @@ -147,7 +147,7 @@ config KAS_INCLUDE_DEBIAN
>  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
> -	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
> +	default "kas/opt/sid.yml" if DEBIAN_SID
>  
>  comment "Image features"
>  
> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
> deleted file mode 100644
> index 2e74af73..00000000
> --- a/conf/distro/cip-core-sid-ports.conf
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022-2023
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -require conf/distro/debian-sid-ports.conf
> -require cip-core-common.inc
> -
> -PREFERRED_VERSION_linux-cip ?= "5.10.%"
> -PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> -
> -DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
> -HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
> new file mode 100644
> index 00000000..028b6c00
> --- /dev/null
> +++ b/conf/distro/cip-core-sid.conf
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022-2024
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-sid.conf
> +require cip-core-common.inc
> +
> +PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_linux-cip ?= "6.1.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> diff --git a/conf/distro/cip-debian-sid-ports-snapshot.list b/conf/distro/cip-debian-sid-ports-snapshot.list
> deleted file mode 100644
> index bd08a742..00000000
> --- a/conf/distro/cip-debian-sid-ports-snapshot.list
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20230430T091331Z sid main
> -deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
> diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
> deleted file mode 100644
> index 87e0b95b..00000000
> --- a/conf/distro/cip-debian-sid-snapshot.list
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
> -deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
> diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid.yml
> similarity index 70%
> rename from kas/opt/sid-ports.yml
> rename to kas/opt/sid.yml
> index b11a1c2b..be2eeb47 100644
> --- a/kas/opt/sid-ports.yml
> +++ b/kas/opt/sid.yml
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -12,4 +12,4 @@
>  header:
>    version: 14
>  
> -distro: cip-core-sid-ports
> +distro: cip-core-sid
> diff --git a/recipes-devtools/secure-boot-secrets/files/sid-ports b/recipes-devtools/secure-boot-secrets/files/sid-ports
> deleted file mode 120000
> index 91bf492f..00000000
> --- a/recipes-devtools/secure-boot-secrets/files/sid-ports
> +++ /dev/null
> @@ -1 +0,0 @@
> -bullseye
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/files/sid-ports b/recipes-devtools/swupdate-certificates/files/sid-ports
> deleted file mode 120000
> index 7d00e075..00000000
> --- a/recipes-devtools/swupdate-certificates/files/sid-ports
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../secure-boot-secrets/files/sid-ports
> \ No newline at end of file
> diff --git a/start-qemu.sh b/start-qemu.sh
> index b6f9d012..080f939c 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -40,8 +40,8 @@ if [ -n "${QEMU_PATH}" ]; then
>  fi
>  
>  if [ -z "${DISTRO_RELEASE}" ]; then
> -	if grep -s -q "DEBIAN_SID_PORTS: true" .config.yaml; then
> -		DISTRO_RELEASE="sid-ports"
> +	if grep -s -q "DEBIAN_SID: true" .config.yaml; then
> +		DISTRO_RELEASE="sid"
>  	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
>  		DISTRO_RELEASE="buster"
>  	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then

-- 
Siemens AG, Technology
Linux Expert Center


