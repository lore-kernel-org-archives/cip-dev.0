Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30358.1793869514011646448
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 01:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yH3lCLzl;
 spf=pass (domain: siemens.com, ip: 40.107.162.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYeqGMesMRXsfgo+Z31au0PmhahLwdSgJFUx0hGmfkRTI2FMCmByISeM11oC+7H/0PSiv5XVE3Vt5eH6pqCr9iNmrEpI5j/JyugEwQjgT2u3FnwUPo4rXgpb1Fm//BfefdW8RS6P8BBqEdKq+BAW0T1Yk3pMge9ygtXgIFnqSW49fQOtNzPt6TUMYcYKOfOh8dspjohvLwuLmAU9IM1Oa+GgJt65WIlRhkBHsgWQ0tYekbHFxyFpTfmIVssp+OCrN1RiJYMi5DQU2ZcRfzRmttW7GAkfG0ZLEBaFgBGcRpRvASWpEWFIEn64n5jKjtifHhF7ktMTxy4WIfyoyrjgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX1H3vY0u2DtJ++zLV1OTicXkHa+oP4Y7PFY1mXUUuo=;
 b=kvpVB+s3KYtHcnbiZnMseFkHFk0mhCW7ecfqll9sXcLQ73orgRUtOMB74bFiggVnKyMPtJ+9tElGKMNTfIMbJ2fcCtwIV4jsuGyvWZ+EYpndDAOOWiNcKCYsEzdI2qQotyyJovr0zVH0RfZ12cwxXf17+XudVsRC+rOKAyov+G/whJebztSrUQYq480f+nk06ztkPYH2QSeKkTzrMUJMal9TxHABMuMWbfb+1RhP9OZilWecX6CDmV6FJSgh3Ikj/5oFlzGEHy8Q5eg5wbK+sXFEKBy57BPtvEL303xNZYXoLnCUYZSOOndUWPJE22YeGskUX7sBlD0rwj3k0fxqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX1H3vY0u2DtJ++zLV1OTicXkHa+oP4Y7PFY1mXUUuo=;
 b=yH3lCLzlKxH4Yjq4zeg4rGMzr2apG0HuSW8Ht2XgHDGnZyGbubLUHXVgbWOF8trx7ppQYHTi3u+L8kBF6qmbXTuWs2V9jLLRfeI3VzJoqKF48c8qQyqhFQ1qY2ksneUdEMjIwo2nVciFoQi33OSlbytXorLd5guVRQcLmfdjR40KT+z/kUXE5aV63v6uU2JsU+eVUxrSVzFpYXCZjOMrk/BvTGUU/LpA9HlViAELyGRvNwteCLPVYkQwqwoci8c3lPdaL+woJKgeWnwuTHaXveEyU76teHzCnPXfLRrIfcOucrgEehw786ZryiN1V11iJHzpe4N2IU7k5D222Igt9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3979.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:140::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 09:05:09 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 09:05:09 +0000
Message-ID: <d8f8bec3-8512-4494-8a9f-b3d8d92e6fb0@siemens.com>
Date: Thu, 5 Nov 2026 10:05:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 12/12]
 cip-core-initramfs-dracut: load watchdog drivers early via force drivers
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-13-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019102541.672620-13-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3979:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5b07d-b597-49dc-d047-08df3b1be47e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|261021121427099003|261009221227099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: lcWAMmESlkvLUZrC1KHCxdytY4UImX8QdlTV+8PSOiDwqo1C4xlaD+KQOMYoN+7UXOmH5+02rAWXLWn5c0h+A5U6vMduRWyJscc8gWmdDEBy8BvEc3qEoQRRbigGD7yUPZ3oYqutgjo1n2d3IcWhKvjHzvEmk/uheKU/IoL4KzTUSHJIlkVVP9MBns7hhh2BNwKZ81s1hVW8lAl9iU/1n+egxQ4MKd1Ks7frbBRKK8n4+SQga7LR7jBga7FaFAYrc5qDNCL6VqCKPmV2uOzgItKqMQ56wANEpo20Q+IgMrqW91hSG7nqCj4xqqKW4gKRGAwKKJL+EhrpmM5CO5NDw7tB6JD5BWLIHLmVfkM+NCGFc2sznz9Zv591KIBPzU008AwhH1HNZX3IfQrOQsW1K8WyyH/BbWZBiZ8EFygRzc6aLO+eT7Xrb1r2BB9v2lKcVYa5ULbdoFhp3O/9CFdlFxPXFvZeBY5CW6RX2nLf18qOzyyMhpXqYS5ZFAAoBCiypqkk2cG1JPF0GR6jaPEc1tZj72Mn0+kiVtevSUTxYQYzB5o4UZkF92wufpEtzErqOPCxBom4KSFgusnZh492PCECuaHsn8XeiYVOwglt0RXw7QhuLk7YIb+SZBCepAoZy+haR0aR3jzKumVbmjkAnwR1aZXfpmBx/fwNRxM446Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9LeXRJc3grMi9xSHJDaVJSd2tEVkFTTXZGZXBlYjlKa3RINVlIRWJqT3d3?=
 =?utf-8?B?elIwUlA1MlNWdWtYRmgzdzBqWmd3akdPbklPbXJ5YlNNdU5lZGdRNnRQbHJq?=
 =?utf-8?B?VHcxMk01bHYxakk1cDltVEVsNkpJeGwyTEdmTHZRS1MweCtoYnlObmtVdVdV?=
 =?utf-8?B?bE9VRCtiSC9VYzhNUmJOYWJIZ3A2K2FPR25Tak1ycWQ2L01TR0IwQzNFVXdu?=
 =?utf-8?B?SmJPSW1IMXRIcHdTTElUZGs1RTc3ditiUU5tQ29EWVFXbVdDSGw4THFNTTRY?=
 =?utf-8?B?dENuSG5MMWdiR2RyYzlZcUpobWNOK1NWa3RJdTYwazlhZlJWM1RKeGdhNnZn?=
 =?utf-8?B?cXdvQmhWWW0yeXNpRHdiYzZuY2tDdkpHM3hQY1pzUXRZR0hrbVF1Y2MxODVn?=
 =?utf-8?B?YXN4TVlUc2xKQTBreVFGb1ZlYU92WW9uNFNyU3JkcEs2QTl2ZWFqcVZNSUlt?=
 =?utf-8?B?eks1aUxLQ0YxWlJ6d0hkRzBiN3VDZWVhdklrOXFpV0NPTTRhNVFmZXA2ZGUr?=
 =?utf-8?B?ME1TVTIvS1M0OXNKbHd6SW5URWRpUXRaSEdhNG81R004Ym5JZ3Eyd3JicnBI?=
 =?utf-8?B?MXFZRC9mTHlFQXo0NGlPWXJESUp0dWxaUlJqcGdJM3ZBSGdPMFhGMnJCNStD?=
 =?utf-8?B?L2Y3WlB3ZFhEWEFCTTZsYzRkZlF1dTNCVk9WYU9jdnEyZzVRU3BxWVo0TkpQ?=
 =?utf-8?B?STlab1ZtYTgzQndVQy9DTHRuN0UzSGdmZnRlQ1V3dnkxUzNnb3VCc2JOb0dn?=
 =?utf-8?B?YzFqblFtaU1GY0pKQ09JSnJtMENGWHEzSDNjVnFZTHdPakp4b0NJVUdmUS8x?=
 =?utf-8?B?SzROdWF2ZTE5ZE1obW55d1VmWTFSdVhmU3N4WTJyWFFIZmZnZjRtZlRLaDN1?=
 =?utf-8?B?ekxidlhqL3NHM3UzeTVyeE83aTI5MytMU1ErR01rQncwem9rL1VZL0xtb1VP?=
 =?utf-8?B?UUVUWklreTV0dzVtZDFZOE1xTVNGMnVKU0NDT3U2UFRybFlsS1ZRdlJJcWlR?=
 =?utf-8?B?ZGNOTVkvUHBnWFJWWVFEcXEvWmZnSTlQNmRMNSsxOElGK05JUnNKWGdZdzN1?=
 =?utf-8?B?M3I3YUVhc09sbThkdXVrUWtHdDltR01hWDlTN2tzc09zYXBNRS9JU1l6Q0F3?=
 =?utf-8?B?NFhaNWFtRjlZK3RmMS9SUW5ZSTZWc0N4UGdCMDdVVmQ3MlZ1Nzk2RDh6aW41?=
 =?utf-8?B?cWkyMmovaVhUQTFwMXJCTUpncjhTSjBlK0ZFd004Sno3NnVKQlg2VHY0OWdo?=
 =?utf-8?B?OUVnYzdrdnlWVVA0Ulp6WC9KUW1GWWRkMFkyb0xTRGlUb2NIRHl5QmgwcGk4?=
 =?utf-8?B?MDJPK0Jxc2JJaXNlb2crdytsYmwySXlIVkFoa0dxZ3hXb2FMcVJwMXJzWGRV?=
 =?utf-8?B?RURjM0o2SFZWR0FIYjRWdVdTRFBnUG9leUhHRjVrckF5ZDdoNkU2Wm03d3kx?=
 =?utf-8?B?U1Y4WHlmWTN5Rmg3cDVEU3cyQ3Fla1lDYitPQWFVcVRKVkJvT1o1azNNSDlB?=
 =?utf-8?B?cFRqU21aS3dhVzZFSm1CQ05iREd5cDFsZ05rVUxaZ04yWkxkeENLSm1Sa01q?=
 =?utf-8?B?dG4xbU5sTmJRWGlpNXdwL0liN3BBWDFUb0lRMVVUZ2lidVNGTVF2QTJxMGJJ?=
 =?utf-8?B?L2JiSWFWTTVZUzZ2dFBocDd1WXVRWEdidHljcXpsdlZZYzdJS29SNEtFdWxk?=
 =?utf-8?B?SmJ6RFBrb2JXc1ZuVURDV1k0aTZ1ZG5QNW9VcjZMU2VJeDMzTGp6cGowU2xN?=
 =?utf-8?B?VzBveGpYVC82UVZ0aUFUcFRsZXhCL1hzRjAzeWdpWFJTbCtqeVJkdXhGUUw1?=
 =?utf-8?B?NFI4VGFJQXlRS1p4N2U5Sm5DTjdZN1haRWdSTEhtNzZUVm1ydXFwMnBzd1Vt?=
 =?utf-8?B?VjQyd2g1RWVvRmtsVnZESGxzTXhnbTF3RHhPRVFJS1gxaC94Y0RYdnhQU29p?=
 =?utf-8?B?Sk1kKzhFSHVBUVpSTURGK0RWblNkaUc2SGZGR1M2VWNsZmJ5OW5tRDZWMWhH?=
 =?utf-8?B?UWN1Z1ZCVWJ3Z2l2cnE5STBveGh2SDh5djRNY1hlQWVBc3hYZGNTV2t2RjM4?=
 =?utf-8?B?T0R5SjRLakdIdWJzS29LaGFraVdjd09YSTFTTTdLMzN4aW1obU4rdmtlKzVC?=
 =?utf-8?B?MnNpVzdIYjhicEhMZTArY0VUdWU1dmM5alNHQ09idWwzc0NFNFFDUE9YRW5k?=
 =?utf-8?B?YkRZbFZWQmluaDVtaTFSZ3VGSlF4RHl1bTg4VHpmR0JnTUI2YisyZUlzN1BC?=
 =?utf-8?B?OVYzTThBS08zbW9vMDZQd0l0cHRrOThqbEQ0OFRBVEdSOGdoOGNxM2dPVVM4?=
 =?utf-8?B?c3UvRjNQU2tCeGZwMzlLSC9qc25KNXhOaEFlMmZ2VGZyd2Y1OUVxdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5b07d-b597-49dc-d047-08df3b1be47e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:05:09.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttm3ZvrzxW7v6eCwQBNw1+5m9YRS3WmeTdZib/zenmUccpTLMAFgcyUQgwDs29JuDjrQ8cq8ptJxXQNDA/etsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 09:05:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24644

On 19.10.26 12:25, Quirin Gylstorff wrote:
> On qemu-amd64 the iTCO watchdog is not available in the dracut initrd:
> iTCO_wdt binds to a platform device created by lpc_ich, and udev does not
> load these drivers early enough for systemd to service the watchdog.
> 
> Add INITRAMFS_FORCE_DRIVERS. If set, the new dracut-cip-force-drivers
> module installs the listed drivers and loads them early via
> rd.driver.pre. It uses DRACUT_FORCE_DRIVERS of Isar's dracut-module class,
> which is carried as a patch until it is merged upstream.
> 
> qemu-amd64 sets it to lpc_ich and iTCO_wdt.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/qemu-amd64.conf                  |   3 +
>  doc/README.dracut.md                          |  12 ++
>  ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 ++++++++++++++++++
>  kas-cip.yml                                   |   4 +
>  .../cip-core-initramfs-dracut.bb              |   5 +
>  .../dracut-cip-force-drivers_0.1.bb           |  17 +++
>  6 files changed, 148 insertions(+)
>  create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>  create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
> 
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index 748aaa33..b85666ee 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -15,3 +15,6 @@ PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
>  
>  # when running without kvm (as in CI so far), 60 seconds might be to short
>  WDOG_TIMEOUT = "120"
> +
> +# q35 iTCO watchdog: lpc_ich creates the platform device iTCO_wdt binds to
> +INITRAMFS_FORCE_DRIVERS ?= "lpc_ich iTCO_wdt"

Doesn't lpc_ich pull iTCO_wdt?

Jan

> diff --git a/doc/README.dracut.md b/doc/README.dracut.md
> index 2a59cd08..3f26d772 100644
> --- a/doc/README.dracut.md
> +++ b/doc/README.dracut.md
> @@ -58,6 +58,18 @@ default recovery script is used.
>  
>  The initramfs is built with `--no-hostonly`, which `cip-crypt` requires.
>  
> +`INITRAMFS_FORCE_DRIVERS` lists kernel drivers that are loaded early in the
> +initrd via `rd.driver.pre`, like dracut's `force_drivers`. Use it for drivers
> +udev does not load on its own, e.g. the watchdog driver serviced by
> +`cip-watchdog`. If set, `cip-core-initramfs-dracut` adds the
> +`dracut-cip-force-drivers` module, which uses `DRACUT_FORCE_DRIVERS` of Isar's
> +`dracut-module` class. qemu-amd64 sets it to `lpc_ich iTCO_wdt`.
> +
> +systemd tries to open the watchdog device when it starts, before the drivers
> +are loaded. After that failure it retries at most every 5 seconds, so it only
> +takes over the watchdog if the initrd runs longer than that. Until then the
> +hardware watchdog keeps running on its own.
> +
>  `cip-verity` does not open the verity device itself. It ships a udev rule that
>  runs `cip-verity-match` against every filesystem partition and publishes the one
>  whose dm-verity header UUID matches the identity on the kernel command line as
> diff --git a/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
> new file mode 100644
> index 00000000..df652e23
> --- /dev/null
> +++ b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
> @@ -0,0 +1,107 @@
> +From 061e42be73d410405bca189e876efa3034cd55df Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Tue, 13 Oct 2026 14:31:28 +0200
> +Subject: [PATCH] dracut-module: add DRACUT_FORCE_DRIVERS
> +
> +Some drivers are not loaded by udev in the initrd, e.g. watchdog drivers
> +which have to be serviced by systemd before the root file system is
> +mounted. dracut provides force_drivers for this, but it is a global
> +option.
> +
> +Add DRACUT_FORCE_DRIVERS to the dracut-module class. The listed drivers
> +are installed regardless of hostonly mode and loaded early via
> +rd.driver.pre, same as dracut's force_drivers, but only if the module
> +is part of the initrd. The module depends on kernel-modules, which
> +evaluates rd.driver.pre.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + doc/user_manual.md                                 |  5 +++++
> + meta/classes-recipe/dracut-module.bbclass          | 14 ++++++++++++++
> + .../dracut-module/files/module-setup.sh.tmpl       | 10 ++++++++++
> + 3 files changed, 29 insertions(+)
> +
> +diff --git a/doc/user_manual.md b/doc/user_manual.md
> +index a134903d..09ac080b 100644
> +--- a/doc/user_manual.md
> ++++ b/doc/user_manual.md
> +@@ -1877,6 +1877,11 @@ It is controlled by following variables:
> + 
> + - `DRACUT_REQUIRED_BINARIES` defines the binaries required by the module.
> + - `DRACUT_MODULE_DEPENDENCIES` defines dependencies to other dracut modules.
> ++- `DRACUT_FORCE_DRIVERS` defines kernel drivers which are installed into the
> ++initrd regardless of hostonly mode and loaded early via `rd.driver.pre`,
> ++like dracut's `force_drivers` option. It adds a dependency to the dracut
> ++module `kernel-modules`. A machine can set it with
> ++`DRACUT_FORCE_DRIVERS:pn-<recipe> = "lpc_ich iTCO_wdt"`.
> + - `DRACUT_MODULE_NO` defines the module number which prefixes the module name
> + to determine the execution order. The default is `50`.
> + - `DRACUT_MODULE_NAME` defines the name of the module which is used to install the
> +diff --git a/meta/classes-recipe/dracut-module.bbclass b/meta/classes-recipe/dracut-module.bbclass
> +index 6fce979a..6d32a4ac 100644
> +--- a/meta/classes-recipe/dracut-module.bbclass
> ++++ b/meta/classes-recipe/dracut-module.bbclass
> +@@ -22,6 +22,9 @@ DRACUT_MODULE_PATH = "${D}/usr/lib/dracut/modules.d/${DRACUT_MODULE_NO}${DRACUT_
> + 
> + DRACUT_REQUIRED_BINARIES ??= ""
> + DRACUT_MODULE_DEPENDENCIES ??= ""
> ++# Kernel drivers installed regardless of hostonly and loaded early via
> ++# rd.driver.pre (same semantics as dracut's force_drivers)
> ++DRACUT_FORCE_DRIVERS ??= ""
> + DRACUT_CHECK_CONTENT_FILE_NAME ??= ""
> + DRACUT_DEPENDS_CONTENT_FILE_NAME ??= ""
> + DRACUT_CMDLINE_CONTENT_FILE_NAME ??= ""
> +@@ -71,7 +74,18 @@ TEMPLATE_FILES:append = " \
> + TEMPLATE_VARS:append = " \
> +     DRACUT_REQUIRED_BINARIES \
> +     DRACUT_MODULE_DEPENDENCIES \
> ++    DRACUT_FORCE_DRIVERS \
> ++    DRACUT_MODULE_NAME \
> +     "
> ++
> ++python do_validate_dracut_force_drivers() {
> ++    import re
> ++    for drv in (d.getVar('DRACUT_FORCE_DRIVERS') or '').split():
> ++        if not re.fullmatch(r'[A-Za-z0-9_-]+', drv):
> ++            bb.fatal(f"Invalid driver name '{drv}' in DRACUT_FORCE_DRIVERS")
> ++}
> ++addtask validate_dracut_force_drivers before do_transform_template after do_patch
> ++
> + python do_add_additional_dracut_configuration() {
> +     workdir = os.path.normpath(d.getVar('WORKDIR'))
> +     module_setup = d.getVar('DRACUT_MODULE_SETUP')
> +diff --git a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
> +index b38ae50c..9fc5af93 100644
> +--- a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
> ++++ b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
> +@@ -15,11 +15,16 @@ check() {
> + # Module dependency requirements.
> + depends() {
> +     echo "${DRACUT_MODULE_DEPENDENCIES}"
> ++    # rd.driver.pre is evaluated by the kernel-modules module
> ++    [ -z "${DRACUT_FORCE_DRIVERS}" ] || echo "kernel-modules"
> +     # ISAR_DRACUT_DEPENDS
> +     return 0
> + 
> + }
> + installkernel() {
> ++    if [ -n "${DRACUT_FORCE_DRIVERS}" ]; then
> ++        hostonly='' instmods -c ${DRACUT_FORCE_DRIVERS} || return 1
> ++    fi
> +     # ISAR_DRACUT_KERNELINSTALL
> +     return 0
> + }
> +@@ -38,5 +43,10 @@ install() {
> +             exit 1
> +         fi
> +     done
> ++    for driver in ${DRACUT_FORCE_DRIVERS}; do
> ++        mkdir -p "$initdir/etc/cmdline.d"
> ++        echo "rd.driver.pre=$driver" >> \
> ++            "$initdir/etc/cmdline.d/20-force-drivers-${DRACUT_MODULE_NAME}.conf"
> ++    done
> +     # ISAR_DRACUT_INSTALL
> + }
> +-- 
> +2.47.3
> +
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 13251a75..04345552 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -25,6 +25,10 @@ repos:
>      commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
>      layers:
>        meta:
> +    patches:
> +      p1:
> +        repo: cip-core
> +        path: isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>  
>  bblayers_conf_header:
>    standard: |
> diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
> index 8541574e..ccd6b7c1 100644
> --- a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
> +++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
> @@ -20,6 +20,11 @@ INITRAMFS_INSTALL += "dracut-config-cip-overlay \
>                        dracut-config-cip-watchdog"
>  DRACUT_EXTRA_MODULES += "cip-overlay cip-verity cip-watchdog"
>  
> +# Drivers loaded early in the initrd, e.g. for the watchdog
> +INITRAMFS_FORCE_DRIVERS ??= ""
> +INITRAMFS_INSTALL += "${@'dracut-cip-force-drivers' if d.getVar('INITRAMFS_FORCE_DRIVERS') else ''}"
> +DRACUT_EXTRA_MODULES += "${@'cip-force-drivers' if d.getVar('INITRAMFS_FORCE_DRIVERS') else ''}"
> +
>  INITRAMFS_INSTALL:append:encrypt-partitions = " dracut-config-cip-crypt"
>  DRACUT_EXTRA_MODULES:append:encrypt-partitions = " cip-crypt"
>  
> diff --git a/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
> new file mode 100644
> index 00000000..db3815c2
> --- /dev/null
> +++ b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dracut-module
> +
> +DESCRIPTION = "dracut module loading INITRAMFS_FORCE_DRIVERS early in the initrd"
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
> +INITRAMFS_FORCE_DRIVERS ??= ""
> +DRACUT_FORCE_DRIVERS = "${INITRAMFS_FORCE_DRIVERS}"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
