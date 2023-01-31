Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB70C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 10:58:43 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web10.9234.1675162716659633968
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 02:58:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=woon6rr+;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5NRgWUvOPIJURPi8wKxIwrasolBbc8++OeQ/4S9dfH3mHsE5oduKnx9c0Dd/gfNvYXUrz/0bb++R62LBGh8Iien2e1hlKlqPq26a8razJ/F6wAzA0Z9ueW/HQDSYSR3w1Rgm+SwIH+Jhqz82WrcEVGZmoYyr9y5ercP2v5E2E2cDVNWm1RD0vBLKopRFLu5Cjbn6G02MEm168dugTXJ5B1WMFJveaxLZ3WwsGNP777RyNX5ZMplWUEkauQUg8VmmzMkVON4a7V+jMBGuMcy/67he0Y4q0yeZQ9uFodffAq0y+pr8H71DZx61l+ioonmG1q9HdXgcTfVG8EZ7C7jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvQTLh21wJv3H/MYXK/Tr4BB4hOEhIOzKnXK4fQ4MRo=;
 b=CAt4OwBBlMaWScsthklYUdq/HmgN1/YitTk60x6vXH18DhkcoulYDOXIVctErgHuKwiBzt/45Yd4rIvlhr6JLWfFbSmMLAHUXADXW1UAJVTru2R3CVmESGkzREGXvYWFTdifJikkBmMRuvdTT8mno0zzUJCE7yGugov00I2m32GlhJaGtEefXfe01saleIDBVxUIQqlQenRovdmzlajCQd4jcLeYyuME1miztLIX49YPG6CQQeRITY6hSdlq11U1W5jrHhXtb720ZCqsHUWn/Fe9mYMmOIE3B+g/WTe4Uj1SznihSX098t3kPDc+REQV/MgBxA9uMOJkzSCLJjyXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvQTLh21wJv3H/MYXK/Tr4BB4hOEhIOzKnXK4fQ4MRo=;
 b=woon6rr+8faNVGgJkT/q3iAw7eI/Wdx/RsxOXMpOx2aTwhsbDYkCgrj6bj5mnCHEToS1nhOGBSYkgp7UrayRW10RQ4gATNg3rTXI9KjEdCxUUXUmSWn07pmBldziBQegX974q6rghC8K+ujTcDluxPbmYtzLBvgso2xdaSzOBa9t2OsVTL1Gr1afKRvfx/j941M7XEiTN23FnqW1d4v3eoc/5Ywbu+crIipTeNtHRfFrnNGVB886eqBFTsUUUYxiAat3Rf75P3rotL6403ZjjwUtniBXwG9B4Tzk2oXgfP3IpZ6TaDJb+xKxk6CnFcJrJlVymnH/AeRMYP4WNFPOMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 10:58:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 10:58:33 +0000
Message-ID: <d6be9d91-a5ca-ba39-1a43-9ef28ea4985e@siemens.com>
Date: Tue, 31 Jan 2023 11:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][RFC 2/5] use bullseye backports for
 systemd-cryptenroll
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
 <20230130150204.697758-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230130150204.697758-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3261:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5fee96-c3cd-42af-a08a-08db037a1856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jKMSbaHbactkPp1jRgiH/vNxSVEaCV1fljmt2J24yE3RLew8BGrCoHTl9N31/ZC+27FkpD0CHuzdyyojUqPDI2wDCuWZmk/PJAVQPpR7CJAnWw8WmMG3FcjI6dEs2TzyIdMbdaO29lDDb+wY17SwCGbsgafX4NXOXchk1bp15o8m3X7ky3WluoX+aXugfYS6DitBdvj8qr3oyTlUkc355Tnqa4U9wuOc16Z8D0ZlZ2QOv6kLT6lEJeNOOl6dFCTZ/Crn9uQCfNtb9zlMe8dGtcfEeAeBHSOZsdSY9O8qVgKTfVl+uDN7veEHfml/tC/qjZJEBH3IoMRo9rIa/BBZGe80h5l2R/Bgc2WbA/a4POQQ1RdBOD1lLW1apkY3YPv79fnYerFPF5a7nN0dfJJpCz6eRViVUxTq7FJA/z66pwALQ5HwJcATUEoYT1c5R1jvzg+G5o8mlEoQWMGuZSGUuLZ5Sm7Xtd5n2vTD5rLXzY+psl8hgHcowW5H8awznAAKgcc3F6r9qxnrLvNLKs0Itd83PS3PzX3ObB94s90V32X1JdJISL3dustE3JGgn0xv7P/cvHwJ1oP/9GNmJVSmVMMs1vTG9nqk8CrDz5682CdDVbcpPFshD3g9nXSMlECl6hEHocms5k05gqElNxi9fgM9qDoJGq5tnpGOqTxgtE5abz1qxi+sZ0Mw2uzCAhcZV+hupKDYvBtO1b8HBdPGLSPMYp7roz6i0Pw3kpcsZ03lQtfpEDDDLxKTOLwN9CLQs39VC8LJuezPjWarOG1hnw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(6506007)(5660300002)(6636002)(6486002)(966005)(316002)(38100700002)(82960400001)(2616005)(6512007)(36756003)(186003)(26005)(41300700001)(8936002)(31696002)(8676002)(53546011)(66946007)(66476007)(478600001)(66556008)(86362001)(2906002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGRENHpXR3hoaE9qa25nM2pndnJRa3g4SmttYlRBYnJYQXM2WXRUYUNjL0NP?=
 =?utf-8?B?d0Jmb2YvM3huN0NkNmcyOU5QcWZVRVRDWS9OZTZFSFphYzltTGw4MUcrb2t2?=
 =?utf-8?B?VWNNOU90Y05YQkRWcUxHd01RWEU4NVNYa3JZc1lxNkJIQXN3QXRNd2RvWnFs?=
 =?utf-8?B?em1uQ3MxVmV5ejVQQ2FXalY2bGlvNTR1dW5xekhtRS9ZUWtkLzVFekVnYzFT?=
 =?utf-8?B?YXBBR1pMYUlRL0NhRzgwTXA0RkR6bjlpUVhUT0J0aTMyaTVvYUZCaGNCRlAw?=
 =?utf-8?B?bkRiRnpjclQxMXJtdXh0OWo3SEQ5N3ZwS1ZkTGVKRnpMMURIT2sxb2JuWU9Z?=
 =?utf-8?B?ZlBWbjloWkdyOVl2ZkkvZXV0TDNoNVV3bWtVblhSaG9BcDdJc2IyNnc0ZmJU?=
 =?utf-8?B?SGh4MWZaRWV6YlQ3aktmUk5XaSs5bEprOXU0bnlQcVFPeFBURk05REFrUTd1?=
 =?utf-8?B?bEVrd2xNM21icHBSS0ZwK2tyTS82TVU3czlUQTVGLzRINlFRbTJZYmNubWpn?=
 =?utf-8?B?MXRDREs3TWlKVEorckVOZWw4M0JjTnZhZXNoSVJhOUVVU0tTOWhsMkhpUndw?=
 =?utf-8?B?cUh4QU05Rk1oV0lKTFdSRFRFRUFrR1dKNGtVU0RmMjErdWp1dzJTVGd1MUtq?=
 =?utf-8?B?cUhOZ1JBVFpTY2hvYWtINnorWCtLTmV4YkJKVnB4eUV3VmoxOUJVUWswU1RX?=
 =?utf-8?B?SDhMUjRRRnhmSko0WEhiLzQ4VHJub3R6TXZ6U0QrUG96Y1EwS0dDQUx2bXZk?=
 =?utf-8?B?U0ZVd0VhdHV3bkQ3TFdRSTdHSW1oVUxpSzlzdW8vT0E1UVpwOENOK2VyNURF?=
 =?utf-8?B?bG9IaDBVNkUzTXBYMy9sVUhQRzNZY1BWV0NuNFdJa2tqOGJlYmZUSW1BNVZ5?=
 =?utf-8?B?VEVpQVRlQ2ZpbDhsN0lqMlFzL1N4Zml0ZUhpQkg4T040WWMxSFZNNkNSbFN3?=
 =?utf-8?B?YVR4WExqaXhjT1lsOVRYWXdPN3hKYUZiUy8vOEhoTTRCM3NOVFI1TjBKNy9p?=
 =?utf-8?B?RmlJK0IxMFBJSjRlNjJIT1RJbVpyOUxtMmx6NHBVRS9Pck43VENiOGNxZEFo?=
 =?utf-8?B?T1JaSHhNajNGOHhMSC9VMzFkZ2kvbFdHS012NUM4SGN5dC9PWkdhVU9FVGp3?=
 =?utf-8?B?ek56bWgxK0VwOFFxaFVVU1pWcHFGV1IwQW5ORlA4djhNbDhOVGJEMGxGQzlJ?=
 =?utf-8?B?MmdKYjFkeTNXRnlnSGZnTDhiMk1YZjVBdXNkV25WT2pSVWV3OTVzMHJTYTNj?=
 =?utf-8?B?cFRhaUpKZXJJeENwalNQTUxGSWl6Q21zVEJ2cW5OdmxzbmxZMUFnMjQxRng2?=
 =?utf-8?B?MlZNT253amZDNzhLcVJwVHRBdmMzdlhRcFRicFdaZFU3SXBhRE5UUlRUOGpo?=
 =?utf-8?B?WFZRREtlc09EcEJnRDJ0T1B1WUdsQ1pvbk5VcFdPRjNVcnpncG5wWm5xL0RW?=
 =?utf-8?B?a3BPV01WZzlDT1prU3FmYWtkS09HdW5zUDdPTjZJdDB3cllRSUFrOGZQNXBQ?=
 =?utf-8?B?NTBZekUxM0trb0lyMExVRWs0S0FtWVNKRmZseEYzQjFRbG9MQTlSdzBldmZM?=
 =?utf-8?B?eitpZXZDdFRqK2RieDNNTlZ0MjZ3cWZwU1NBU3Y5Szg1VlRqK3o2NzF5cUFY?=
 =?utf-8?B?N09jZlpLVGl4MUwvZlJEMXFjSWFuTFJObmpqMXVLOFUvdWw2YmxBMTZ3djZq?=
 =?utf-8?B?dmNqekcwQmFRb1pERUV6dm81NFpMNG9TRE9KSnRwZUIxMllEZ3FxRUk1Q1R3?=
 =?utf-8?B?cmd3azZHbU51bWJnSkpFTTg3dlQrcGwwSDJDcCtLcVNxV3E1UGJvVkoxaGNk?=
 =?utf-8?B?V3VPaFNYT3ljeHlYTmY3MGJhMVhXY0g4dlZUMU9DVmVZOTRCL2gzeTNkZ0xn?=
 =?utf-8?B?ODhFbmJmck8vVThLUjB5bEppYnB2dk16c3dFc1lEZFR1ekY0R1lnMWVtM25J?=
 =?utf-8?B?VnNaTXdFR2o3SEU2T2xUZGdqMXVqd0pvZnVDbTBuVmhjRi9jZFhvUmFYa2xJ?=
 =?utf-8?B?STAzUWhlZVF3M1pidzRPRkw5c25oLzFFK0t0V2tFSmJsd3dlZFBHRUZoa1Jm?=
 =?utf-8?B?UVIxWU9IR3dxWXZDUFovZXgxYmNKNFY3aEtmbW1XOFY3cGhCRXd5WXNEUWha?=
 =?utf-8?B?dEllK2JuYWVDanE0VW1TVGVETHZtTUFDV200WDFuVk5lWm9rVDd3RHhtYXIv?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5fee96-c3cd-42af-a08a-08db037a1856
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 10:58:33.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWdtpd1JERnvKsGhKcCh8lGRnL1R3c9ZDE2Ts0QIcqj0AaMf1g7EVkn4HVxPc+owubgFzv1WW+numzTnCPsSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 10:58:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10522

On 30.01.23 16:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Systemd >= 251 is required for systemd-cryptenroll. This version
> is part of backports.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/debian-bullseye-backports.list     |  1 +
>  .../preferences.bullseye-backports.tpm.conf    |  3 +++
>  kas/opt/tpm.yml                                | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
>  create mode 100644 conf/distro/debian-bullseye-backports.list
>  create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
>  create mode 100644 kas/opt/tpm.yml
> 
> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
> new file mode 100644
> index 0000000..3a55e4c
> --- /dev/null
> +++ b/conf/distro/debian-bullseye-backports.list
> @@ -0,0 +1 @@
> +deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
> diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
> new file mode 100644
> index 0000000..0905fbf
> --- /dev/null
> +++ b/conf/distro/preferences.bullseye-backports.tpm.conf
> @@ -0,0 +1,3 @@
> +Package: *

Please list the package here that you need to pull. Otherwise, we may
pull more than desired.

> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
> new file mode 100644
> index 0000000..03e8e47
> --- /dev/null
> +++ b/kas/opt/tpm.yml
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +local_conf_header:
> +  systemd-cryptenroll: |
> +    DISTRO_APT_SOURCES_append_bullseye = " conf/distro/debian-bullseye-backports.list"
> +    DISTRO_APT_PREFERENCES_append_bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"

We still allow buster builds, no? Or will you prevent that later in the
series for this feature?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


