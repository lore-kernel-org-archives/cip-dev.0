Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88.1794200547697890118
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 21:02:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gYfqR3Oz;
 spf=pass (domain: siemens.com, ip: 52.101.66.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuxwEpxPcZUCYEZqdXEG0NBNfKEfpdxbklaTgxhf4wrJA4DbrzETaAM9WOqqWrHXl8iLR9KLUK71q9JYeb7LdPIdHnTPbBry9V/TRyiso1CUw/4rt9LOkyLmuashfAjetM3h1jqlBBoeb+jJTFH1NK4ybUOOawqZ3HZQ996MOlFGAH8hKoseM9ho6JWyxkY/C0S6Z1KoVrzIBxE7+Jhv/AeaJNsMtf/wp0whNai/EojfEMBAXeUelVTKrAZ99k8HgIhu9SN1cCrTPQ5EQZ7c8pos3A990UeYThrfrRfS/PG1+ti5cGDgDGP7rOBJIPGJ6iJt89EXtGWZZdegxP3qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/o8XNjWHTf2sy8WxwKl67NTsK/msFiuCgPfbOPmcAY=;
 b=mUniF7haQL79JN4d1l28isvnFHddB3tOX4Xn0Fm6gPZcG7xWscsCOJOgs8sKLokWkcuBqVhNAdYoWXzWPbPKkTLFBcpdO0crq+kvIVrepK65LsxRmsrW4Pp0mwwpCgNwpTYsSbntyff+MagQLXRkq8EwE7FufR34oFWzrbCMzMapKgY5B3V1EtVxIyD0UInNuqJzVJDdRYvGytfb8YB5UndriQkxU9Im8UaM8SiVm65BgJAOq5SQQ/7S8Xi8kD8pG5qZjTsNBINvlQtUTYpn3XRaSUe8V0zRmg7rYXASJEKhkD9h/+ozvNTxKuARFYFiPKZQTZV9CSEq61Nxj6araQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/o8XNjWHTf2sy8WxwKl67NTsK/msFiuCgPfbOPmcAY=;
 b=gYfqR3Oz7vuE0FXrN6eKlj/AMVl3TlgzVbGRqrKNwRlZW5/+lIpxWeq9gQ73ZIhdUzrlOXZfOpiuk6glCIpKVf0CDX6zg9mLzEJdjutZIIxBlLb9dRO0I2/2jEKi0bHYuWKOFI+LDDRWt7e3HTdqafRk7feN7qILJbQHS5s0gWwngSyejB7tKHvTLweS7+UX52itLro3C4x36aVmPFGJS6NUdHYkE4ZIOiqyNI5qiSEWeST4wbHhjaGfTNtk0jlG71HJlUmUurVx8EJyrziCnsO9VAUnnNJfGl88z5cQkcj02tFToscAn5ZvzJRX9dkiHUdSvhEYuf13UnR1T0lJ2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8459.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:442::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 05:02:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.005; Mon, 9 Nov 2026
 05:02:24 +0000
Message-ID: <09e7db5b-4c5e-4c80-8575-941bf4ac5898@siemens.com>
Date: Mon, 9 Nov 2026 06:02:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Kconfig: Sort supported boards by
 architecture
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1794196842-2008-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794196842-2008-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5d1ed8-12eb-47d0-feba-08df3e1ea472
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|11063799006|56012099006|6133799003|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mz1s3LE/7juCiscAEtOM625jPWjKveV4uzdLJoChBhzdqTEvcIeVgzOvLgZel5b4+hG/22OsNwMOEJG4jj/lAvCWdAbqLw84hDRYlS/od8FIoIymAalXBqQOyV65Pf6zev00InBtwhjOYreXQ3XE3raZwX0+9lnLRTN5sEw6RPegWWlY7Hc1nhUSJLfZNobR71dtf3a5kBmFF8JHL/I36B5ipZlTFAb0OrbPBCMlPED2hGbHNN3L5fZuvDwtKqJnyYrvqLzxYpZKQpWnyau32ReS+6lFxwSJHNDQHySzOmm85TQWaLMgbrlgmc8e+zb+jCEORUXGQOY/O2cxXkmoZGT5mDgvE/MIa/2Uvh+20NQdEns+HEUEv3F17NGlLTqfHIf1IBmuD6252GsO26Od5T3x+qm9o/sCuNcU75efVoi+RNq4aoMiDQflY4FWSzJm3xs4HxIVufvVDFEYzWjVWZ2+aXfFr/ftCIP8dvS9JKLrRi5lKaJucSMy5QiuDkaE8KbecXUPt1UXWDX92GJhiYrq6pXC2YdiwTSSu871Xgqn8wIZQLZBXhBa/UWpYWCwN7YM/lEwI5rbFu+W8xogSGJP2W1CJjeanUGYxTE6SF1aYCx7MTY2wGTlCl4XsTepJ6+nx3vA1jNmAj+ln32rLz+g0DylBuT/SjbR61TXAuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(6133799003)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdFUk5KQWVncjJDM3lWVXJodlJwN0E2UERvcDgzVHUzNFRGcDF0VzltblVw?=
 =?utf-8?B?Vk02dVNSbTNMN1ZQRS9jQlRUYXA5ZUFBV2JIZEVRZWN3dDRBOEJnMHE1bk4w?=
 =?utf-8?B?bElrc2p2bEMweW9DMGg2endlK1VESWhua1gxQzhnRU02aHFrSjVLTGRBa0ti?=
 =?utf-8?B?TDgxM0h4RzBVVXJTdGdVN09UZHhPSERDUGlkQnNnODJSQXpwMFdHZXNDeXgx?=
 =?utf-8?B?cVU5c3B5QVMvUmRmcXM2b1RFS2RmUzRZNEV0aitCT29QcUFTNVRQRGlrRWFR?=
 =?utf-8?B?ZmNrcGFIMUdlOW82MW1EN1hBOWhvcUl5a0U3STBXbXF2dDhwSGRzOTNxTVQx?=
 =?utf-8?B?NkpZK1U1M1ZybXo2MHFxNjBwaGU5TVJDTzJyakhZRlNPY05PdWVRQkkwSFVp?=
 =?utf-8?B?WVdXbGVZSG1kVFc0MVNiaC8yVjFJNXNPTkswYmdTRFNYYUxDcDdaUzBPc2dp?=
 =?utf-8?B?SDYxeFd4emg1cjV1TE1Fb3lKSXNnRzdjSVh5bEc4ODZ4cHkwWkVxQmtRcTYr?=
 =?utf-8?B?NG9wTWVaOFJ0aENvaFBQdmFMK29YQ01maVdpbjRDMGtQblFabUZ2V1B5R1FO?=
 =?utf-8?B?WHBRd3h2bitjRG5EVHo5SG1LSmJWbVZ1dVYrQzZMdDNXSjl4aUgrOExjWGpr?=
 =?utf-8?B?Q1JKc1lmRHE2cWxnN04zaHYvbkRkSFdSRjBZeEhEbjgvcDRPcVBhVFphNllV?=
 =?utf-8?B?cTgwWVZTdldzcjBYd3Zya0RxcDc5UHR5VVZXM2NYZGRCZjR0MmJEdjBraFJT?=
 =?utf-8?B?b2pBKzZGck5la0t1cnZicy94UmIvTklRUFg0ZWM5bnBsRFZ2aUJFM1NteFhP?=
 =?utf-8?B?a3F6Z0RZYitCdk5hN1ZudWhNK2xBa0NvdFJuVUR4R3hXcmNIZkF0Ui9VSDNR?=
 =?utf-8?B?bDBWNkpkd2wvSE9yRndOdjZraTBleFJ5SWh4MVZtL1dpNWJsVitHTTJJV0hL?=
 =?utf-8?B?cTM3a2xOTXpHR2FIZWlBMWwxTGd5eXQxVUhIVVhBSEZON2dFUCswTWNuMXZ6?=
 =?utf-8?B?YTNxb2o5clFEbjU2NWVmNWlCVWtsenF6ZVZTNy8zbnlMc3VsZVRBZ2g0cjRs?=
 =?utf-8?B?YzVPWXhBcjU0NWJucmtVVENCR1NJNWdLak5SMmxQRHBuYW1yZTZEeUI4TE1n?=
 =?utf-8?B?NUk5YU1mckRBcVRqTXpqNjFZdnN3Q3E1Vm9EaSt6UVZ5WDZhYzNrRXM0VVh1?=
 =?utf-8?B?dG5GQ25tWmFEbU5EV0huYlE2Tk5uWjVKQXVUclZReWZFSHVHclpSdHpOZjRR?=
 =?utf-8?B?YVlXS2VTZ29ZY1ZQdWNNUDV5ZzhDYXVqQWVyQXViamV0ZjlNbk53TDdXQ0ZG?=
 =?utf-8?B?UjZEWVFrTUV6bTdNTjlBcXhUaktRb0dTM1FubFIyci8zYTZhNW1GSUNUVTB6?=
 =?utf-8?B?bUtKRDlqSzFBL05BTFZhMnd4alNHZFNKbGtnZFpiV3hxRDZjZW9SVkRMdVAv?=
 =?utf-8?B?U2F1b0JtdTBUUm5nOXlabUNjN25wRnNSK1p2Wk5kQzNtMWhLT0dabUZZZ1ds?=
 =?utf-8?B?Qmx3MjJHUERDVFp0TXhZcFpuUzRVR3FIWk12Q2ZsckpTdGNONFVaVzhIOFI5?=
 =?utf-8?B?N1I2ak4zaFFPTjRsTFBkb1ZtZTEvMVVmZTVDMXkycEU5SVJIcEZXS1g5eVY3?=
 =?utf-8?B?aG1STHNDK3k4NGRZQUduMmtZVytmUnpTUzFuQW5BNFFHSnYzY0UyVk9BMEtu?=
 =?utf-8?B?SVM1a0pVa0pOQzZGaEUzdVpEK3ZJY2VubjU5VlZBbWZLV1FNUlRPaktFMUxh?=
 =?utf-8?B?Wkp2Smk1NE9yZjFrOGo5am9IS0t2bkU0Wm9qUmxxRC9YbGhjQkdnNlhKNHNZ?=
 =?utf-8?B?UE1RNCtLSSttN1g5VGRyNmpqc1JNSC9Uano1b2JaQjFVNnFQK01aazFJWXhG?=
 =?utf-8?B?WDNGeHZWSHFiTTVpamIzWUpITTFqblFhdW9hVjgwanZ6ZHF3d2Z2WUJWemhq?=
 =?utf-8?B?dHNjL3lhVm00UGhqOFIyWHRYMnNSdzZsZHFVbXM3Qi9NYm9VSURWRnFDblZs?=
 =?utf-8?B?MHpSdlBLVFg1dFlGMVZSYjhOQ3dYaGNUQjJLa2xZcm1DNXJqSWZEYkdtV0cw?=
 =?utf-8?B?WS9vK1lqL3JFT2VpZDloYkE3NCtROWQ3ZmV6QTJCUXhTRThaMVdSUlNhNHpk?=
 =?utf-8?B?QnV0d3lqUVRPSS9vYVlZMnFpOEpCTnhJOEtiK2dMU3ZWY2MwaFhLZGFjYXZS?=
 =?utf-8?B?M0trV2VFOGZYd01LU3VkMEtGa2E1VjdJTHFUdDV0d055cUNiaVBrb2lCcFRK?=
 =?utf-8?B?eDByZEZPNldBYUhDWXZ3d0RPUkhPOGRPK3hkN3hvbjhWSkw3OWhZNUErbDUv?=
 =?utf-8?B?UVpUTmhCQ1ZYMU1zUGlodGMzUFNGc3JYSitkQVVBcFhObFJCM0ozdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d1ed8-12eb-47d0-feba-08df3e1ea472
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:02:23.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxpmpJHdDvuMxPXXNiVyU/6Fb4p6DHw5PT2ZNdAFZ0HzxQhNIzQkWvU0QzKb79DjNSRCwhS8t2FTKHk2RA5gAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 05:02:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24678

On 09.11.26 05:00, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Kconfig b/Kconfig
> index c5dc301..163813b 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -133,13 +133,13 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
>  	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
>  	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
> +	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>  	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/de0-nano-soc.yml" if TARGET_DE0_NANO_SOC
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>  	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
> -	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>  
>  comment "Kernel options"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
