Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5264ECDB474
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 17:02:30 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web11.59827.1697821339407615406
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Oct 2023 10:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uqC0e6NK;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2Vc6OLhLj31IHJLY1GJr96AhMbN3ypRWvJhyQkEQFc7bhXodlW2xOKXTccOjy6/5J+Z7tD3Y2qH/tqZZEw+tl6zkbySJQjuySYQuxJ2Tyr6eEezolgvIbobdkWGncylz+HP33hVUcPZmCSodhfaf/bSrVKRcFc8zhxjltsYDfckQIGpoMHjSs593fT3SLzxFIWsoAn91TlmQxdOl3WOGan2xHy6yhdU04RrOfXx3RN+U4rFXHpByGbFK/jFrwHl3GhNFk2WElY29FxoliaLq+vmjDkkkTbnHGrwPE+G2ekNOokbYf74FuGq/TEIeQMNTzpE7JoqNTCtmkzsRw0pxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1PJmg4vIcheNsruyiPOhM7eyscyOqiJZnTJM0iM25k=;
 b=NmHyEWUhIJ3Pdy17ObYFIpU7C0XaMXs/9KmhtNnK90DguLWn+yYhoEaoFQgO6wFsjlfcGaJIglz/uWfELR4+r9OePPaWbNHQA1jM5Rk2s6NeHqOxe0pgFx9fscSuK0jub78qKA1FQqo6fPHSc0ITJQtM0FYJfPyF0RqJiQ6lW4s+J63rlfqHbMbG1YFmxwQMpr5iM+QUCPfZ+sw9OyutrPrXwdX5tk9iXByhieV8VEZbSc5/3Bo4NjZZWs/x74Eh/mSidGtg9hKfSM6JQYDWyILw51HCaKuboyitwoICvZkPC0mhRtD+cEGswecfZz//ntfnjg4UscBjlIbwoj/39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1PJmg4vIcheNsruyiPOhM7eyscyOqiJZnTJM0iM25k=;
 b=uqC0e6NKJV+doMoC9oMVZiw2RLO1vA82z78XNwcRNLMuul5nKbPBOkMlrUvQH2TwRCMDV4o3IgYCPsjWmI8P6NVS/AudDrKDQHJzUha6sTpR6mIfVMs2HSDlxwF4Kd0vPxPuJ61Yz/AoeiaGyUg+TePBxMZe5HjIvrjsXbOtD4Czg94qAGMkvA3QhEh+Rn/wCWSsr56NXlibJe18z2xCgI943DaY/YxCozmdVghzlsGOBXcCxbHj7ZZ46NypxJsJvaiPgTsSJmEmItvN4oJx10D14X3disxp2VxEfBYiHw7cftM6YosNjDxw+2ZwV35Wks6z+ffBcjPKrA/tAFqW6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 17:02:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 17:02:16 +0000
Message-ID: <fa32414b-4690-4fee-856f-278f4aff1013@siemens.com>
Date: Fri, 20 Oct 2023 19:02:12 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.2
To: cip-dev <cip-dev@lists.cip-project.org>
X-Mozilla-News-Host: news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d8db31-6b34-40a8-5fa1-08dbd18e500e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mZmoMvYAHuk+3PdOuz+Ppk51C/N34+7EE+Tb5stjmGNTtLED8RGDTAqqnNEGpwZWRxN777GSpWB1Q2YY879UHc0TuXceho60FspSOnxw2QGpdYVZYKZFtIaznhIZ8wS5LNSZHTh+ssNzI13p1fnZjgwY6FFYjWjItdoPNKsQWPMEeNPxAou5cJjz8KuA8NhPfm2r+vqB23zYdTZ36xxyFF3aqpmhmcJJBEtYcmwWgjvU45jXHduA6Bp0w7MV5KvZlKugHFd6jtIsLPPtM+iC+W1hPUhZ5FE5c79G6syHG+iOCYqP/1sYzuOlQd8fxXMNqw7sQt5vw7Y4VWCGHt+M0+MxLz96nNzQ4SSMVVrMTP7zwp6/GCr+KjOtzRJ7Ueb8xnoZePTv3fH69oDcDuE8d9UOhyUbzmrgRvMikus03rSl3LXwqe/12K7LfSh1Wm+OpR/jktq+WEI81w/nM+oTBLLIiRjdyHJ31oxli0fnBqOfpy6uxs5ueSSqg+cjzQqWa0niursXQqjuxB2KiXQE88JF7WKULN1Z9895vy/f2YZg32vlgljrKwvywuIGyCjsAPBx1yYf6C1w4xkm26Y74aoCx4Phd9tdtLy+TTknt/KZXilN5xwxGOAlXjQa+SQJ6/vicQXMdk+59asRyYXhbA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31696002)(86362001)(82960400001)(36756003)(44832011)(66556008)(66946007)(6486002)(316002)(41300700001)(5660300002)(6916009)(66476007)(38100700002)(31686004)(6512007)(6506007)(2616005)(26005)(6666004)(8936002)(83380400001)(478600001)(2906002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkNPUTdxb0NlaU9sek5sMHZnMllGZVFzd01iZWRKdi9jaHVZNVR0YjJkVDQy?=
 =?utf-8?B?UXg2dG1MR1FmdUNMSnFQY0NuOVJXVkYrc1R4M3NlWGUvTExkWDNTeFN6Qlhl?=
 =?utf-8?B?OWRBSzRHSFZqYUVTQUtmemRKS0hjMU1yd3RCQlR3dW5JWS9IckhyVDlHejYx?=
 =?utf-8?B?WWJYdnJUdUJFZkp6Y1BmKytEbHhTdzZncTRIMWJyK3E1MTVxNHJLRERpdTY3?=
 =?utf-8?B?ejRuWTZMSmhlcVVyM0JxZVF3MldXN1VqcjNqYmZIQlY4YWdxUmFkbG1IQkMr?=
 =?utf-8?B?NVFNRHNEQlNPeGxmaS96YTRJbk5MTlJHSXlLcW04YVhvRUVyNXdRQmh2NG1k?=
 =?utf-8?B?dFloUDJWSmRySXMwMFZybGV3TDA1QWNTVFdqcERnek5zK1ZwQXZXS3B6R2l0?=
 =?utf-8?B?VTVEZ2NlN0RUTjYrL0FxbEhnTDBDSEYraWZnVlFScjBhYmtrandhL29LcElq?=
 =?utf-8?B?VTVQTWkybDl2Nkk4NVpHa21udDZsbmdPUXZ1TXVUL05uei9ZY3NHL0JlV0Zn?=
 =?utf-8?B?enhpL2JyYW5aTFRHQlRpSllQbFl5dG9iSXZvMFIyS2pXdzBJS0cvZFN2Rnla?=
 =?utf-8?B?Qmo5YVh6UnJsSTFhelM1K3lBRGhGb1BRUnRPaXIrc1NqU0swZGJOUUg4aHpL?=
 =?utf-8?B?cVRqYmhEMXNUaHJxdWlaZ0dnUzNXZVFXWVM0K0RQR2FyUmJjWExqb0srZ2lK?=
 =?utf-8?B?QzlwRmtoR2dBR2tkaW0zamZ1OENLYnVRZStHRHlZTUEwWHYwcHY3Ti84Z21z?=
 =?utf-8?B?MlRMYlRTZnEzSy9IYVZDWEpYRVB0OHVTOHFZbnF5NzZLRFNFMS8zZGtmRmZX?=
 =?utf-8?B?Mm1HZm45TGk0R1IwSCs4NXI5UG43T0lqTllkS1UrVU9oTWJuRnkzVFhHYWpw?=
 =?utf-8?B?YndFOTNJaDNmZEN5QUczeFNlSmp0UXZ1N21YU0tpQTlXbndaVUNXQ2NQMXJM?=
 =?utf-8?B?WE56SS9DY3dLbnhhQW1vaFgwcllOa1VCQXJ2bzYybTVKSExVaDh3OHBwbFhX?=
 =?utf-8?B?WEpMVVVKMkJqTXdyMTNhRGR6cnljSUEzd2tVTGV0d3VVSmlGb3dvMzV0ZjFt?=
 =?utf-8?B?NmNvMDJhSnBtRDF2SCtnemFQNU1jL0JvbUorL3BVUWdXaUs2ZjJzV2E5MWx2?=
 =?utf-8?B?V29ZMjFkeWltR2dKUjVrVnlqWGQvUUFOSXMwa0hEc0xmNGdpai80dXlMOE5Z?=
 =?utf-8?B?RFlPNCsyOXdVY0Y3dHVFV2RDQW1VUHkzaXFjemdIUHgwNDU2dXRJS2t1dU9J?=
 =?utf-8?B?OHVocDVRd00vbDExUDgyK0tiV0VMR0EzaWFIYU1VOUcxN1VsMXdweG4zQnlL?=
 =?utf-8?B?SEY4WlpVamFPTEMyM09KODhwSmtLSmF3NVA4MTBmejdzZ2g0cVg4eVZ2eU52?=
 =?utf-8?B?NDFwbXdyOGpQMUZscVVwL3NvdHd5VEtOTnJ3ZFQxWGMxUGNoQTBVekFQR0lY?=
 =?utf-8?B?ZG1pUDlWcjdLeHdHbk9MaGdBV3JMMENIK1hqV0RBRXBtMWVxQ3FKc2Y4eWtE?=
 =?utf-8?B?dE0zZ01PVHVGczVWMEc3cHorRnkxcTU1MUNjMG5jLysranBjeHVielFzTzZD?=
 =?utf-8?B?M3ZKMTlwbjVLaGRQNE5WT2gxUHk0Um5sUzJFSmJmYThSSGNjeTcwOVBjVXZ1?=
 =?utf-8?B?eElJWnlPUWQ3U0lDbnhVZHVnUjRqWWp5clhRRWsvSkQraWhsQVUxSXdaRVlG?=
 =?utf-8?B?cVpML1plNWd6K2pwR0RrNXorTzdwVzBGVkhSZXN0Qk41OEVqOXlCK3BtMTVo?=
 =?utf-8?B?Y25RME16SXhNRWYzZHV0OFVKbTVQNmkyT2NtaFFEZTN2ZnA4bGFOSjcvbGE2?=
 =?utf-8?B?ZHNhZDcrUldvYUpsUzNOYTdWbU9wajQ0NGZYRDlIME4rTG9mN3plam1CSEtm?=
 =?utf-8?B?WVlkS1JuVTREVjRQNjI5cElPQU5qY3FrbUkxUjh2OUhLZ2lpMStyMHVBL2Jq?=
 =?utf-8?B?UFZjaHl0aytRdlJTTmVyOHZsS1JhWDZEQjh6azIweGhXK1RHTVVncDFwZldz?=
 =?utf-8?B?bW0zV1NIRFc3UDdya21VaWwrZkRkc2cvK1hUVytkUmdKemdXbmVhSjNydjVt?=
 =?utf-8?B?Vm1lbVNFQU5CWCtaNDdydGRxU3RqM3BuZkVob3VrYmo1Y1p1amdYTUxkMWFV?=
 =?utf-8?B?WlNJeGZPbVY5VTB6dVNtV3dHRlhZaUR0aEMzYktIUG5leHY4ZGllUVd2R2pD?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d8db31-6b34-40a8-5fa1-08dbd18e500e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:02:16.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBC3SFq31ZqJe5AWH+498WPrX9GouunEAe1WRzDk4ttedWPdZERWTDQ9jVeiPWIS0OSo1taBgKoNsA+buTEBzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 17:02:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13421

A new release of isar-cip-core is available.

58 changeset, 9 contributors, 98 files changed, 627 insertions(+), 266
deletions(-), these are the stats of release 1.2. Beside a lot of
updates, this release brings support for signed SWUpdate containers
(.swu) and once again many reproducibility improvements. I think we are
pretty close to even complex image being fully reproducible. Full list
of changes can be find below.

Thanks to all the contributors!

Jan


Felix Moessbauer (3):
      drop dependency to no longer existing buildchroot
      make method to find /var mount configurable
      update ISAR to latest version on master branch

Jan Kiszka (19):
      efibootguard: Update to release 0.15
      secure-boot-secrets: Add missing artifacts links for sid and sid-ports
      Update to kas 4.0
      Fix required version in kas header
      linux-cip: Update to latest releases
      linux-cip: Update to v6.1.46-cip4-rt2
      linux-cip: Update to 4.4.302-cip79 and 6.1.52-cip5
      linux-cip: Switch to new download space
      linux-cip: Move KERNEL_DEFCONFIG_VERSION into linux-cip-common.inc
      linux-cip: Update to 5.10.194-cip39[-rt16] and 6.1.54-cip6
      Make bookworm the default Debian version
      ci: Reduce number of build tests, focus on bookworm
      linux-cip: Update to 4.19.295-cip103 and 6.1.54-cip6-rt3
      verity: Prepare generation of metadata file for Isar update
      edk2-standalonemm-rpmb: Fix unbalanced brackets
      edk2-standalonemm-rpmb: Accelerate the build
      Update Isar revision
      dosfstools: Use -native suffix to select the right architecture
      linux-cip: Update to 4.4.302-cip80, 4.19.295-cip103-rt33 and 6.1.58-cip7

Koch, Stefan (DI PA DCP R&D 3) (2):
      initramfs-crypt-hook: Avoid data loss in case of resize2fs failure
      initramfs-crypt-hook: Avoid calling of tiny mke2fs from busybox

Nguyen Dat Tho (2):
      linux/cip-kernel-config: Use latest commit
      u-boot: Add EFI secure boot dependency

Nobuhiro Iwamatsu (4):
      linux-cip: Update to 6.1.42-cip2
      recipes-core: ltp: Update LTP to 20230516
      linux-cip: Update to latest releases
      wic: Rename wic/simatic-ipc227e.wks to wic/x86_64-generic.wks

Quirin Gylstorff (5):
      recipe-devtools: Add recipe to sign SWUpdate update binaries
      swupdate.bbclass: Use new swupdate-certificate
      swupdate: Enable signed updates
      classes/verity: Set salt and uuid for reproducible builds
      initramfs-crypt-hook: Load necessary crypto modules for intel platforms

Sai (1):
      README_version-release-policy.md: Rectify "y" incremental details in metadata version

Sai Sathujoda (3):
      Kconfig: Opt additional IEC 62443-4-2 features when security option is selected
      deploy-cip-core.sh: Make .wic image and separate artifact deployment exclusive-or
      security.yml: Add additional features to security image

Srinuvasan A (3):
      secure-boot-secrets/files: remove unwanted link files
      Update kas config file version
      cip-kernel-config.inc: Bump the cip-kernel-config revision

venkata pyla (16):
      kas/opt/reproducible.yml: Enable extracting individual partition files
      .reproducible-check-ci: Include individual file system images
      scripts/repro-tests.sh: Fix condition check for artifact folder
      scripts/repro-tests.sh: Print partition label and fstype in the output
      ebg-sysparts: Add filesystem UUID to fat images
      qemu*.wks.in: Add filessystem UUID to home and var partitions
      .reproducible-check-ci.yml: Set default values in base job
      .reproducible-check-ci.yml: Enable security target
      reproducible-check: Add option to pass extensions of the image
      .reproducible-check-ci.yml: Add BBB target
      scripts/repro-tests.sh: Add *wic.p0 image into reproducible tests
      bbb.wks: Add fsuuid value to the rootfs device
      wic: Use fixed UUID values for the partitions
      kas-cip.yml: Update Isar revision
      dosfstools: Add recipe to build it locally
      distro: Set dosfstools as build dependency

-- 
Siemens AG, Technology
Linux Expert Center


