Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B3C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:42:52 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.44])
 by mx.groups.io with SMTP id smtpd.web11.9895.1674024168387360914
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NIIN2cyO;
 spf=pass (domain: siemens.com, ip: 40.107.7.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeGozdX6yC7awIpX0Fea+q6ZhivlgJLZfYHp+EpNImdTuKhd+7grzeB1CB9r3RL0iMcbOSB+yKmon3PuU99xkTEkRtkg4ZcZnySUfv6wk0tOIIJwj2+FpVpuhC7C3A0x/hffvzkf2CUK/A9Y9xEXGrheXvGAuun3PdyvMFIE5cdUsrDpkoIuIqa5WCZfPtYnzI316Zvwkz0acmJxPUS683qAXw2wNh2wHoMHeJ59NX4hkeykZeqzgkW4lYoekmkZF4ZepJgSJb/ZyvS1eWd/8zcSxDYpv2vTeS0J2YYn/mo350qfYvip8K9dtzASlb/nN/qHlj1CPaRdzX153/7Yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgY+IB8UcUWCL2m8a1F3/de1KiG5cNCdTKDJ3GV/cDk=;
 b=VJ5q1T/06bUaSbEtCF8dQJ5iB4y+LHNj9Ou+yUNdQXbMRefuFFeIxf4S8b/uXtcu/mfovDqpwwnbWGsSFtyCjK01yx5v5Zk+Z7loYLN4eOamcEARifUddRXe/fuu8S3WcZim0tOj58zgeDDwtwFGsXhZAiLEfGYWRdDQrp2cfX01G8zCK2/2st3nEvMJS9gCsC7tD1F9UKko0FE2CLjzZrKoee3PrNNl0jAca4S2WcNjqJNn3O0zT5+sNeOmCZJhkSzoE4ZlMIU+SuKXipsTURebiMpOXLcgj3sO3mEYKP28etH/epHy/R1ZAnADKbeF2rTxeJnT26TG+d40TbIixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgY+IB8UcUWCL2m8a1F3/de1KiG5cNCdTKDJ3GV/cDk=;
 b=NIIN2cyOUYPj0O/WKCLngGC2y2MfHNy8exG87Q3WraUDBAwmRc/8kUKfZP/jClH9q1KgHPyx4Lkf99/KRkx8G7csVdWkbyknkT9iFQ+BQDbdnAuTpm0oOXxGWOjq+ramgqAjy++tNdlAhTTzxhMuRcTwf5bq+caIkWkPiNqf8gCBdJOMWwo5M+6REle/sliuLPhJ6k7sQD5g911qxoKwDPkIjKCoRAwF+VUcZy4nuyRWG1nF3ZB6dE9/C80x82toJvJLyWSYncVOIHJXDZIGv+0W3N6rMr636WQfsOim0+2yw7MC4404hEHwttRiMe7tYelJDzo0fRrC3De5Ax+Zcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 06:42:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 06:42:44 +0000
Message-ID: <0e9bcab9-cd16-4292-ea39-b4b1e7baafee@siemens.com>
Date: Wed, 18 Jan 2023 07:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] Create a generic initramfs
 overlay
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230117131550.249530-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230117131550.249530-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 15caf19e-ad2f-4dba-701c-08daf91f344f
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nr1Dyqh/4raeYZV/5gdXIUQPa1aLTAcaWL1jhMd1ICXgKNs0TvBT0zkAxR8E7PA5T2ZMKRNuUbQizK4IBxCXaMNOwWtcE1NDs+3IkXLtHNP9SSGD16y4Qrg+YUF9k6u+V++EQQsVj5Nv3QMc2FPgcpGra/k887J7k8tKeaD+IfLqVm5mGZDGHILtP4gC99ixDBX2MYPhA1obACxFWGh0U2YlhLqQVtcD54pjtsIIE+XsGxa94dS1pPbXvfFOcYH5hwmI7xiNqxopMDt4agVnKdvrcVuz1LfIyGRX7fMX8Brb0RjVsuEBlbfgzaM/181jc+7iXYKM4cVTe5pxABqdn1P3Nyimz/zv4NggzTiBGEhT+qodWv17D3m6YjGBmet4u4zZSqKLOrIPwTcwhIXJAmVfKlhx8WmlZGLx+LBRzpN7zqcwzrA7X1ccslupWJCFL47dlNVzIBsEl4tCc5uDiupv0LcvwhUqdC0LGhTv5yjvuxEtr1DkXeEIEYIIH8635309ZcO23vmmjprOWcMLRFvk5G2uzTTz4WdQbDgF1L5mywd3GhQd/H1c6yaVgE/gcyhsLqnZaYgmc9ZPwxjWoY1/NsSHsfDWGtlZYQfwUbjnlLsKUXR64Fdl3LH7LeRa+Fd3GDA/lvPGTgJY5L72LseivaIztKXc0myrBKVjUG2R3elwWNzCF9HSbxJ+MAMPE76brwJe2FX/LqozVQJoZV4fe5QZ8DseNkTDek7LoMyQhVKo+KgQmYt/WD+G7LXK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(38100700002)(82960400001)(36756003)(31696002)(6486002)(86362001)(6512007)(186003)(66476007)(26005)(66556008)(478600001)(66946007)(31686004)(6636002)(2616005)(53546011)(316002)(8936002)(83380400001)(8676002)(6506007)(41300700001)(44832011)(6666004)(2906002)(5660300002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2tVWEJ3Z0xVZHcxN2dRbnZXZEhkN3FqV1lvM0VoMDBLOFdDZ0VkaWhkUHJW?=
 =?utf-8?B?Sk51M0FHRkhUaGd4QTluajdOVE1qSTh1MVI4R09YejJ5K1A3N29UaWtBdUtO?=
 =?utf-8?B?c0d0ejFWZGpraThnZkh1dGdJOHdpTG9tbUZDcXluWlpBOGhFdDhmcmYwQ01s?=
 =?utf-8?B?eUtqVFhzaHRDWkJzOVlBT2tVU0VwTnM2aUVBam1jZ21iWlNlb0FZTzgwVTY5?=
 =?utf-8?B?bmFWb01yVGNpQW5LWk54Z2JuZTVvN0xZQkpQd0tvTXFVMUxVY0dVZ3ZISXVD?=
 =?utf-8?B?OE05aWxoZnpWaThtUWpMcVl2K0JJNlZWY2lXRlUwL2EzWjlyQ3JUeTlLNGNM?=
 =?utf-8?B?MjJnRGhyUTIvTHNaWUVBaktZQVVPYXVHYVI1UVhaN3VjYjcyd2h1cmdYZWxR?=
 =?utf-8?B?WE5EUnphRlkxeElHVGJyV3E2QW9YeGRnRU9RRjdBLzgzaFdSN2xhaytsYTBR?=
 =?utf-8?B?aVNqOFNZWk5CazgxUUdqUUp0OVdWVndrT3lwUkJCTUl4WGJGdkFSRHdSNUs5?=
 =?utf-8?B?L1BiRmJCcnBDL00xa2RaZEs0VE5MYUVKaWw5bXVZeUNFa3ROVVFqWmNwSlZJ?=
 =?utf-8?B?YWNsMUhpK1ljRzU2VVlzanZka0lKbFVGUEEvSHRnYmlJcXRiSDBkMXZTZzVP?=
 =?utf-8?B?K05oSUV2WWQvcWFDbEo0eGNaUGRQRDNuYzhTaHl3a0NobXQ5TWtVcVNUL3ZK?=
 =?utf-8?B?QnhJU0VUTU5UYTI3eXh1RmNGbmFMRGl4Umt6STJkblNjNHdSTlV6VG9pdUNP?=
 =?utf-8?B?TzhpV3NUaFo5SXVYZkhjbHV5R09CTlM1SGhyRE4wNS9MUklaSjZ4TjZhMGxo?=
 =?utf-8?B?dWdyQWhBaUlFL1NGQlROaC9jdjYrSnh6aGx5N3BJdEg3Q0MzV3Z2a3RHRFJN?=
 =?utf-8?B?ZDNQbmFSUks0ZzRPeTg1QzdPZGRERkQrblpMdXZCTnNNWXFiYzVlZVR2dXBz?=
 =?utf-8?B?NUR1c0NiaGszVTk4ZlRvTEhIOHJqVFJiTlJ3ZWRXczc3cWlja3NDZnkweVU0?=
 =?utf-8?B?Y2o2eWlzSHoyZGFML1pvem12RTBuOFh2U0cwZHhDcGE4VTNkWi9meklUUGtn?=
 =?utf-8?B?K1RiS2N3YlBwR3BzV1Fjd2xGcE9YcXZYeFhhK1V6emlvY2FicFRpMGFSZ3lv?=
 =?utf-8?B?UEkva2taQU4wR1ZiNytzb0hwSFA5R3JQV0ZIcmhNbW5rTUdkSnZVUGNMendv?=
 =?utf-8?B?T2FkNWZKOXZlVjRlR1hJU1RsMCtHNVovdjZteDk1WGhVTTk4b1hlaHA3eU8w?=
 =?utf-8?B?b3B3bU1tWjFhTm50cjJWTGZOWlIweTlwalZSd3lpWXcyYUpLN3grUFBBR0dm?=
 =?utf-8?B?K1pralRMZ2xIQlR1VC9kMGdmN1pqU1c2UGNVK1ZQbnd2VThsbENsN2VISDZG?=
 =?utf-8?B?SXRkdEl4ZE9mUk9tcDB3SWFSQjR6S0NRVjhzZU42eW9jZmxmTnNTTmF1d3Rn?=
 =?utf-8?B?YnZwcGxPYXNSQkVlK1E3V0l3Um0rWXlPaWc1VmxNWGFadWJ5c25YSGU4TURF?=
 =?utf-8?B?bC9DSEg1c3N4Ni83dTVrV0Zrc1dNUU5NRTdqUUtBK0pEMFM5UmxMRjJqN3Qy?=
 =?utf-8?B?bU5pdnZKSE95akZENE5SUEVjeHZSbVNaOUVLdWdKcExKRmN0U1puVVArYytr?=
 =?utf-8?B?ZGpFMGN2VnEvRUFDWWlPSlMvSzkwRWZFUmpFWEJCaFo1ZjhCUEFwbkd5czNK?=
 =?utf-8?B?SkFZYXdhZERJSXZHOTJ5dzhlQ2xaUjF6bll3MG9UTXkvZmlGS1QxUENkUU1U?=
 =?utf-8?B?UGRUWHBSa0RvbzdtbVg2V0hWejQxMkxnZHpGbE0wL2ROazFXOTM0bjB4UzVQ?=
 =?utf-8?B?VEd5TDZ4SVRFUDJhOVRCS1lVWEZCNytlcGQwb1VtcHNqa0VvK21Xd1ZUNkJa?=
 =?utf-8?B?VzFTV0FMMEtEQlB4dVhNbFFRRDRONk42RmszZnovckE1M0toandjNjA4bk5D?=
 =?utf-8?B?dkZ0bU5QMmQvb3Y2bEg3M0dNMkFOZHRrU21iQjI4QUErVG1TS3IyTm9MQlBU?=
 =?utf-8?B?VE94aU1NY05EcHdObm90WEtIUURWWHNsZitXWU1sc2JZNVYrVmwrRWxEL1kw?=
 =?utf-8?B?b2gwUWYrQWY5aXJ0NWhMaUxYZlUrOWYvbVdrWmwvVThpUjVhcE5LWlRST3JF?=
 =?utf-8?B?cUxJNGpUSGJ1eUZBQk9XMWx6U2o5VmxEd1UyVURCeFlUdWNndXRjRnZXK204?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15caf19e-ad2f-4dba-701c-08daf91f344f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:42:44.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApVSEWzCZBbP15QUxbgNZdsMRw01u0YJDcM9oGbc24UegQE6ypgtOsKsMcKgrOLpADFnM0b+iL45G2Tt6qhQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6323
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:42:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10386

On 17.01.23 14:15, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to generate multible overlays in a given
> location.
> 
> The configuration used the following variables:
>  - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
>  - INITRAMFS_OVERLAY_PATHS: space separated list of overlay directories (lower overlay directories)
>  - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored
> 
> The script tries to mount the top directory of INITRAMFS_OVERLAY_STORAGE_PATH. If the mount fails
> the boot is aborted.
> 
> e.g.:
> ```
> INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
> INITRAMFS_OVERLAY_PATHS ??= "/etc /usr/share/foo /usr/share/bar/foo"
> INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
> ```
> 1. This will mount the partition labeled var to /var
> 2. This will create  the following overlays:
> 
> ```
> overlay on /etc type overlay (rw,relatime,lowerdir=/root/etc,upperdir=/root/var/local/etc,workdir=/root/var/local/.etc-atomic)
> overlay on /usr/share/foo type overlay (rw,relatime,lowerdir=/root/usr/share/foo,upperdir=/root/var/local/usr/share/foo,workdir=/root/var/local/.usr_share_foo-atomic)
> overlay on /usr/share/bar/foo type overlay (rw,relatime,lowerdir=/root/usr/share/bar/foo,upperdir=/root/var/local/usr/share/bar/foo,workdir=/root/var/local/.usr_share_bar_foo-atomic)
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
>  - updated copyright
>  - formatting
>  - fix typos in commit message
> 
> Changes v3:
>  - add awk to generate a unique wordir name from the full overlay path
>  - allow absolute paths in INITRAMFS_OVERLAY_PATHS
>  - ensure that subpath, e.g. `/usr/share/bar/foo` are possible in INITRAMFS_OVERLAY_PATHS
>  - adapt commit message
> 
> Should we split mounting /var in a seperate hook with a build time dependency and only check if 
> INITRAMFS_OVERLAY_STORAGE_PATH is writable instead of adding the mount logic directly?
> 
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  4 +-
>  .../files/etc-overlay.script                  | 36 -----------
>  .../initramfs-etc-overlay-hook_0.1.bb         | 30 ----------
>  .../files/overlay.hook}                       |  1 +
>  .../files/overlay.script.tmpl                 | 60 +++++++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb             | 40 +++++++++++++
>  6 files changed, 103 insertions(+), 68 deletions(-)
>  delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>  delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
>  rename recipes-initramfs/{initramfs-etc-overlay-hook/files/etc-overlay.hook => initramfs-overlay-hook/files/overlay.hook} (92%)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index 9e0ee26..2935ed8 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2021 - 2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -12,5 +12,5 @@
>  inherit initramfs
>  
>  INITRAMFS_INSTALL += " \
> -    initramfs-etc-overlay-hook \
> +    initramfs-overlay-hook \
>      "
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> deleted file mode 100644
> index 6e5aacd..0000000
> --- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -
> -PREREQ=""
> -
> -prereqs()
> -{
> -	echo "$PREREQ"
> -}
> -
> -case $1 in
> -# get pre-requisites
> -prereqs)
> -	prereqs
> -	exit 0
> -	;;
> -esac
> -
> -. /scripts/functions
> -
> -if ! mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/var ${rootmnt}/var; then
> -	panic "Can't mount /var partition - overlay will not work!"
> -fi
> -
> -mkdir -p ${rootmnt}/var/local/etc
> -mkdir -p ${rootmnt}/var/local/.atomic
> -if ! mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc; then
> -	panic "Can't mount overlay!"
> -fi
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> deleted file mode 100644
> index 37a04ec..0000000
> --- a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> +++ /dev/null
> @@ -1,30 +0,0 @@
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
> -inherit dpkg-raw
> -
> -SRC_URI += " \
> -    file://etc-overlay.hook \
> -    file://etc-overlay.script \
> -    "
> -
> -DEBIAN_DEPENDS = "initramfs-tools"
> -
> -do_install[cleandirs] += " \
> -    ${D}/usr/share/initramfs-tools/hooks \
> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> -
> -do_install() {
> -    install -m 0755 "${WORKDIR}/etc-overlay.hook" \
> -        "${D}/usr/share/initramfs-tools/hooks/etc-overlay"
> -    install -m 0755 "${WORKDIR}/etc-overlay.script" \
> -        "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
> -}
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> similarity index 92%
> rename from recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
> rename to recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index bfaa7b6..5bec258 100644
> --- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -23,3 +23,4 @@ esac
>  . /usr/share/initramfs-tools/hook-functions
>  
>  manual_add_modules overlay
> +copy_exec /usr/bin/awk
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> new file mode 100644
> index 0000000..9cbe537
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022-2023
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +	echo "$PREREQ"
> +}
> +
> +case $1 in
> +# get pre-requisites
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +
> +ovl_partition_label="${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}"
> +ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
> +ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
> +
> +root_mount_storage=${rootmnt}${ovl_storage_path}
> +
> +if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
> +	/dev/disk/by-label/${ovl_partition_label} \
> +	${rootmnt}/${ovl_partition_label}; then

I indented these lines a bit more to improve readability.

> +	panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
> +fi
> +
> +for ovl_lower_dir in ${ovl_lower_dirs}; do
> +	# remove the first '/' and replace all '/' with '_'
> +	# on variable $ovl_lower_dir
> +	work_dir_name=$(awk -v var=$ovl_lower_dir \
> +		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
> +
> +	lower_dir=${rootmnt}${ovl_lower_dir}
> +	upper_dir=${root_mount_storage}${ovl_lower_dir}
> +	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
> +
> +	mkdir -p ${upper_dir}
> +	mkdir -p ${work_dir}
> +
> +	if ! mount -t overlay \
> +		-o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
> +		overlay ${lower_dir}; then

Same here.

> +		panic "Can't mount overlay for '$ovl_lower_dir' !"
> +	fi
> +done
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> new file mode 100644
> index 0000000..78831ba
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -0,0 +1,40 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022 - 2023
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +SRC_URI += " \
> +    file://overlay.hook \
> +    file://overlay.script.tmpl \
> +    "
> +
> +INITRAMFS_OVERLAY_PATHS ??= "/etc"
> +INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
> +INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
> +
> +TEMPLATE_FILES = "overlay.script.tmpl"
> +TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
> +    INITRAMFS_OVERLAY_PATHS \
> +    INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL"
> +
> +DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +
> +do_install() {
> +    install -m 0755 "${WORKDIR}/overlay.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/overlay"
> +    install -m 0755 "${WORKDIR}/overlay.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +}

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


