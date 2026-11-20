Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3339.1795171090802684143
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 02:38:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Dilluyok;
 spf=pass (domain: siemens.com, ip: 52.101.70.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGSm5ugCWzbygIbP4Kq6tFUlQADGUVTOg31xJOwZTL80IBFZDlQ+818keucHKT/FbxxxhLbiT9HOfW3cPAmHzo39zosw5LfMTtAocGdlpD/ne3zR90yZ6u+HVGkjrBC2VIIIVwLOtuFE2mI3aQikg9VNXvRXRXiws/vchbazgWWDKEU7TqFCBtLk7Xh6cfWkd1/lK1qS3v3LL1dt1Og6l99ogJcL8F/uR+G66fiaa3nquyCj+RQ1ftamZ6BTmHl4cwp370HEQoaNFhrK7XiiJtVKIGTb0qgT8WCGmRU9ADWa58ldhaTIDFtWNQLJLhneUPj+cOnpiAP7xYT61gLwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTHN2b5y0kJFPFsTpxfdJGyq8a8Z/0wFF0jm8V7OpmY=;
 b=m90e7xTfXFoAX4TjwuBe3TAuKZFkJFZlULRQQterTUOzrX/C/vBeGl58Nebx+HbPE4WBYZ5cEN7386oPebGJwWBoe3RKtmH/QeeJs0sDv4D5owf1moK4OBYw7yKE2waaCJ3J38eDmNECbqZ1+P9QNXTOnZHYLU/H3Jee3CcOnclv7lpFJuaBxLIDU718rh2yxVjHkupV1+3CJ7JSVx86FT0oK32oad1iQRFW0pPQlZJS7IWmworfinTLCj+vbNab1X2rZbZS+dZXJ+pgmHTQ+xmXHhnfsaCIaJpzIySolQKtqKLQuW/3/6LslCUIQYkYx5pc1M6dOK7+QTzuoJ5Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTHN2b5y0kJFPFsTpxfdJGyq8a8Z/0wFF0jm8V7OpmY=;
 b=Dilluyokc3FTkFIbMcROBmN9jIVU0kfQufKjDlgNon+qhrWA7bfkyYmojp5wK8mDpzv019v68dblpp9WkeieAxc7lsMaxOS3R5gWr2kihHku1ZhmphOXjqKlIuBci5cui0dK5USQ7/B5WcPQ8lUSnfaU8Dc5buE3vX1F0YEPqjh/r8FDROvrtY9yex1yamoPeNWOTaQpvH8H1KUZM/oW4ceYpGEtrz8YfUHWkL4NqVl7C5a5Ee5NHY1pnAKBmJPjpiAkqmb8G4t19hGS83D1cP8FpnPVl7PY8CzbufX+cHQZWGm6YyMp9gdZ72jNFLZVtQ/XDHQJGARU/Y9zS1+BMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB7808.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:63d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 10:38:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 10:38:05 +0000
Message-ID: <b1f9d650-89cd-4a5c-9dcf-be80a393e938@siemens.com>
Date: Fri, 20 Nov 2026 11:38:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC PATCH 3/8] ci: deploy zstd compressed wic
 images
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
 <20261120082554.375548-4-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261120082554.375548-4-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b63de52-9fea-4373-d828-08df46f25c2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|55112099003|261009223027099003|18002099003|22082099003|261026135527099003|261026121527099003|261026140227099003|261021121427099003|261026130827099003|261021123027099003|261028144727099003|261102123227099003|261021135927099003|261021133027099003|261022105027099003|261021130227099003|261022115727099003|261022113327099003|261022075727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: oJCTnFmigw5GtJsqPHuFFNNAzzVMFjq/aQLve02EjMMrKVGiTna0BpTOMSlQIUEe6DT/d/QSX1tocex6b6/pWrSvW95MhjldPBp1zcamoTMTvMMO/LorHtIAzM7E9p3r6hT2hS6SY8p5FufZt9F4b/EP+7WflmytTJaOQgEFY54cE/9syRYXfiMhNVNBBbKN14KrNz0p8P2r800sPfpr1wzqUrDVH37cqojM16WRxnU6X9qM9oDli6PBmo468ONvUKCeOrxxr+vdo0o9JCiMVVUe+zpJRc7oHM2hyW0/I5cOtu4Nv5okLBCGOxP/6OsHKRuo1SwXeorSJqZqWoppaoacRd7NPaKIa+lrrkx8fqU0Oo9rBzFDWKhn57tSCjK0JEnTKOhrIotgzh9CRruOcdyKlHsDhbdUK2ufcC9nhU6tiojrVewRXxIATH2I2uEu3lPuDstC8jAmpmE02jHIgbsywHU7jFtBdAVKlHEHJaSPiY3gYhFp9CxOhToVw3qeVnRMBEikw2vL9tH8uHs+qG4eIceeTeN+X3/eIjhwz3WMFzuvg5VXuvbw53J48nNQid60IrRHUx2JcRd71j6t5tq+Mx58djSnXXSVcxFhzjEhSLgh45HW8v0zm8b7wbNF8f7h134yapP88OzMhsbapIUqiG51SmgKJjMHHSapl7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(55112099003)(261009223027099003)(18002099003)(22082099003)(261026135527099003)(261026121527099003)(261026140227099003)(261021121427099003)(261026130827099003)(261021123027099003)(261028144727099003)(261102123227099003)(261021135927099003)(261021133027099003)(261022105027099003)(261021130227099003)(261022115727099003)(261022113327099003)(261022075727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhDUWJ1R2hWTnJhNnEvczgxODhUZytIRHZzakNKak05aHRId3AxTkI2b3BL?=
 =?utf-8?B?MGtJUEJhWUJkSWZRRlpVRml0cDA5N3BEVDJnaTNNVy85TktxR3hwa3pmYUlI?=
 =?utf-8?B?a3dpcWNGNFByR1NVeEpkUWNuSUtWcXFrOTNlS2x2ak9NeC9aVW9CQi9PQUw2?=
 =?utf-8?B?Y1d2UjkxdExEVWhqeHh2VHc4Y2ZQZ2ZNMzk5Wjl1NDZpWVJNMzlvbWxlNmZG?=
 =?utf-8?B?eTJFZjRNdktCek1oZGMvajlqOXdsT2daM2tMVER4WEpCUDcvclBmSlBOSUtk?=
 =?utf-8?B?WHJ1dnZDM1NPQkdpRFhtdytKMnV0d3JEcDFIQzl3Q2xodEpjcUxEZGZBeENL?=
 =?utf-8?B?WExuRjVGVGltU0J5aW9WUmRxWEEvRCtCZUsvd2ZUZmcxUnNsamZlT0JKeGtY?=
 =?utf-8?B?Ukp6SFV1a0hhUXV1ZmFjcG9hQVNCUFFCODlCS3o0ajc4YWI2T3YrZGNnMjRs?=
 =?utf-8?B?QVBxNFI2M09CVUxqNEFKQ21OSzE4aXNwaXM3Q1gzVVFWVEJQRlVKZWxvVmJW?=
 =?utf-8?B?MUk4ZURkRHhvZm1aSHgwR3B5T0tRVDd6WkNIaVF2YWJ4a0djbHpaZjNmQVp0?=
 =?utf-8?B?L29iaUphckgrdExiTVhKLzBNT3N3WEI3TFNwOTVVQ2FlMXhBMENJNTlLNUpW?=
 =?utf-8?B?RlU0ZHFobkdiYmJ0b3ZEMnBIQndzM0FHWmY3MnJQQzIyZjFnd3ZPQTBzUlJQ?=
 =?utf-8?B?TDBaNjg2bEpBelRQcFViRXFHd080ZU82UDhwY3RFZ2gzWlpjVTl6QWg2STRG?=
 =?utf-8?B?Z3gwdnJURitJS201V0JvRTVPbTB5eFlpeENrajArSlhkcnNOQlFmdnN0SG1T?=
 =?utf-8?B?LzM5UHZkR2pMeUxQYTJnNmpGT3l4d2ZESUxkeEw4aHJLMHN5QW5sTEpiTFJW?=
 =?utf-8?B?MXJ2Y0ViTTFMS2MyeVRXZmRmMGhvQVZxd01QVC8rTFJ0ZEhDRVUxTFRLKzJY?=
 =?utf-8?B?Y0xWMFE2aTVFSmtERElyZ1RZOFRwcFdaTlBQNCtXdk9hdVJmbnZneElLeW9r?=
 =?utf-8?B?NlgvY2hhT0lqQXE0S1M3VElhVzBwZm1ocTFYQUM4aFQ2eWtJUzE5aWdVL09m?=
 =?utf-8?B?RWd1KzJIYS9oN0lzTTBLNVdIaEpEa1RMUlBJQWp3Z3JDUzZzaGxueEpVUmwz?=
 =?utf-8?B?Ty9hdmJYZC9XeW5oY3ZXTmdHL3ZDK1g4YmNXaUtCRFcvdG9Xc3FWWFpFd01n?=
 =?utf-8?B?QjZ0dlIwa2F0THRLbXI0ZW8rZ0lhS0Y5VS9kLzRUdUYvSWlNTUFtZWtBbDMx?=
 =?utf-8?B?YlhubXVTTHBhTlBVZGJZRFVwclh2cDBrTFY1NG5ZR3piTU4ySTBZbEJSSThB?=
 =?utf-8?B?a1Q2WDVDWFd6ZDRUUG0xZGhSYmJpNFJzcHd1bVJaOTBrZ2JId2pGemJmYlNJ?=
 =?utf-8?B?WVVQUDQyTW1HK3VWZFc5ZEk4bzdSUGg4VHpEd2p3N1hMMUJwblJsMXNIQTZ0?=
 =?utf-8?B?c3FKYjdzaGNwZ1pyL2tSQjRtcW15bEg4ZWRGTHgxRVNPd09oUDhwVjBpdEdr?=
 =?utf-8?B?Uk9WaVJaK280SEZEODhHVWhPMHJHZ1dYTC9UZW9kVG9TUHpKKy9GSFYyb1Y0?=
 =?utf-8?B?dHh4RVpYZElOZk5iV1NwUG1pR2RUeG1uMHZXNFhPTUQxc2NJTDVKTVBuNW83?=
 =?utf-8?B?dTh5SStwUTBJYWQvM092dFRCRHFWZ2lYUFcvdWFUK0dpa3lCckVrSVZES1hF?=
 =?utf-8?B?TE5zajgrSzZLU0VDTFIzQjVvd2JuVW9vTXlRVjVKR2RDTHR5RkQ3SHRwOVlE?=
 =?utf-8?B?Zkt4ZlVHUUxGejV5M3JaaFd2MzhPbE82d2t4dXFRYmJBNWRYM0RENzZUUjhH?=
 =?utf-8?B?YkJyUTZ5TkRzbTU5TDFkL0xLZ01nNEJOaERmcXpkRndJblMvb1gwTmtwdjg4?=
 =?utf-8?B?YnRRRXo5WXJpaVlUM25UaDNmS2liMmRQL0tSanVLd0tBZGpCblFKbnR4VHZM?=
 =?utf-8?B?Umg1bTZyTTdGbmtqTWpKeGVUS1U2bU02aEZ0Nk9oOFJoWVdxYXJpaXB5OThn?=
 =?utf-8?B?UHFmWEhjVnI3UUt1eG9seGNpTWxwY2xCRDZZbGZHNHc0TWhzMThSeTFWaFVY?=
 =?utf-8?B?YzlaNWZPVHJXVWI0eGFHTnpaTFFvT3piaHBzS3NpdWFKUmRHbWdjVFpGK3dk?=
 =?utf-8?B?SXdBSDVNZ2hMWjh1c2xrTmc0QmRud09qMmlxdTJzSElsMXZoSkloaHQyTGxj?=
 =?utf-8?B?THA2N3V1MlhxRGhkeHdCbGhwcDhpcU5JTDE1R3pUR2ZTQXRLN3hBQ3NMTDhV?=
 =?utf-8?B?UkUyVXZDbm5TcDk1a255NFBVYnBpQmVnaVJ1bkpxbjkwQW5WT2F5N2x1aWx6?=
 =?utf-8?B?MXBXNDM3Ny85eHh3ODF1d2poRTd4Rk1sb1JCTUwweWVLemNvdGo0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b63de52-9fea-4373-d828-08df46f25c2a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:38:05.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhQcGY3VJaHel0nMFGhTlW2ev7O8Ho7YhmYrxadOQKg9I+jmdQ4r8rS8lOTIrvMnrpNtwB+izvgx/eMu4XCI7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7808
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 10:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25037

On 20.11.26 09:25, Quirin Gylstorff wrote:
> The wic images were compressed with xz -9 in deploy-cip-core.sh after
> the build, and the LAVA jobs decompress the image for every test run.
> 
> Let Isar produce wic.zst images (IMAGE_FSTYPES) and deploy those
> instead. The deploy step no longer compresses, and decompression is
> about 4.5 times faster (qemu-arm: 2.2-2.8 s with xz, 0.5 s with zstd)
> for almost the same size (qemu-amd64 +0.7 %, qemu-arm +0.5 %,
> qemu-arm64 +7 %). Switch the wic-partitions archive, the reproducible
> build check and the LAVA templates to zstd accordingly.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .reproducible-check-ci.yml                   | 10 +++++-----
>  conf/machine/bbb.conf                        |  2 +-
>  conf/machine/beaglev-fire.conf               |  3 +--
>  conf/machine/de0-nano-soc.conf               |  2 +-
>  conf/machine/hihope-rzg2m.conf               |  2 +-
>  conf/machine/iwg20m.conf                     |  2 +-
>  conf/machine/rzt2h-evk.conf                  |  2 +-
>  conf/machine/ti-am62px-sk.conf               |  2 +-
>  conf/machine/x86-uefi.conf                   |  2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml         |  2 +-
>  scripts/deploy-cip-core.sh                   | 10 ++++------
>  tests/templates/IEC_template.yml             |  4 ++--
>  tests/templates/M-COM-x86.yml                |  2 +-
>  tests/templates/secureboot_negative_test.yml |  4 ++--
>  tests/templates/secureboot_template.yml      |  4 ++--
>  tests/templates/swupdate_negative_test.yml   |  4 ++--
>  tests/templates/swupdate_template.yml        |  4 ++--
>  17 files changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index 72089685..a156efdc 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -76,12 +76,12 @@
>          local base_url="${BASE_S3_URL}/${CI_COMMIT_REF_SLUG}/${target}/rb/build${build_num}";
>  
>          mkdir -p "$dir";
> -        wget "${base_url}/${image_base}-${release}-${target}.wic.xz";
> -        xz -d ${image_base}-${release}-${target}.wic.xz && mv ${image_base}-${release}-${target}.wic "$dir";
> +        wget "${base_url}/${image_base}-${release}-${target}.wic.zst";
> +        zstd -d ${image_base}-${release}-${target}.wic.zst && mv ${image_base}-${release}-${target}.wic "$dir";
>  
> -        wget "${base_url}/${image_base}-${release}-${target}-wic-partitions.tar.xz";
> -        tar -xJf ${image_base}-${release}-${target}-wic-partitions.tar.xz -C "$dir";
> -        rm -f ${image_base}-${release}-${target}-wic-partitions.tar.xz;
> +        wget "${base_url}/${image_base}-${release}-${target}-wic-partitions.tar.zst";
> +        tar -xf ${image_base}-${release}-${target}-wic-partitions.tar.zst -C "$dir";
> +        rm -f ${image_base}-${release}-${target}-wic-partitions.tar.zst;
>  
>          if [ "${extension}" != "none" ]; then
>            wget "${base_url}/${image_base}-${release}-${target}.swu" && mv ${image_base}-${release}-${target}.swu "$dir";
> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
> index 40af2dc0..cba60a6f 100644
> --- a/conf/machine/bbb.conf
> +++ b/conf/machine/bbb.conf
> @@ -9,7 +9,7 @@
>  DISTRO_ARCH = "armhf"
>  DTB_FILES = "am335x-boneblack.dtb"
>  
> -IMAGE_FSTYPES ?= "wic"
> +IMAGE_FSTYPES ?= "wic.zst"

This should only be done when need: e.g. when building locally, we don't
need the .zst.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
