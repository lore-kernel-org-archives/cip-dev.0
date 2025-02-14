Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8DC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 08:17:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.74])
 by mx.groups.io with SMTP id smtpd.web11.16572.1739521047571601152
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 00:17:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gM4z9jN9;
 spf=pass (domain: siemens.com, ip: 40.107.21.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrIEAKWkEVuKjSXAawkVEKWKSH3mEHc0Y03hAHUmOEhxc18tUvnXISrLNRUn3SzSOh8GOyjZdYtD9SmVBJDZsSntdgr/ZxJpXJm0OAEP4wED89kfvAlErJZVamAbSHp0PPE3phgMTdtXdn4uGQFcm2PMVT+AMfRe8BeQ3ukpbDPfhclotugs6keLUoKrF2Xjp9fHJsVRcsAlIeTmDokbMjkl4HKujQktbSYWPl7upRB6bWKIIA8ldhfOd8HA95HhkEAqRHGTB/i6gJ3DGuRtYNnyMaB8ky24pt4kbvzazmLtPDgEtYTh9lo0X0MvXhgBEMhB6OK9DY++ndKhIjWRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj9bPwpV0bZ3PLSar9YhQGc05FttIULx3or6yTNDsRU=;
 b=p+iBsuKt4/O1KP2+M4l++8leWj3msSOFbh/nKMvOYgO7UKs32hO+M9wUspww+yDGxdYZxfDn5wbKKqaeUJjYwwFCC389EqUfAF7wGW3u9bW7U1I6TUilblJV1cASMQMor9rtOLXjwo6xRaFJijUaJtQFXaUYyUNBXz/sF5Gr+rBMzFftPPyR0WkUId23tusCBGxk6aoKCjvOk/hlS88QZmg80uIS4jZoKB3Umpz4i4LqSJ/1TyEq8bdJVNntMohEzJ5P8Vz+84/Bd3AuJW/ZuV31mB5UMe2zEYu0efoh/xeUNkdlYminyZxcQtNsBstji9ssNsjkc38xTjMzYA7TMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj9bPwpV0bZ3PLSar9YhQGc05FttIULx3or6yTNDsRU=;
 b=gM4z9jN9gpXeSuJQIE9lH4CgDNyKYOxpBDMI05E110VVVwItl28zZRjnqVoOb/oIxkiXeseqS/FPfEtjn2St5mmkz3WhWRYrF3wFRnGVF3y3VAa+txShFSKKdqKh7na4pFkz8QsVasACSH/VZjHi7WiFXlfZsWdaxMKGsG4cg20gbRAFWHjq5YF/QdXFwKCzuRgJgcu93ROoRWzq098JqE7XbYCaAyLBwhZap+15Kjg1umKpSjtj7eYfUBxLvdr0reS4r1BakqG8LNq+TXrjZr/ubziLszxPcujGkkFVCgCqIm5LFoK7VAvPJESDijEr5phu4Uh+TBRE2Uum1qekIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.10; Fri, 14 Feb
 2025 08:17:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 08:17:22 +0000
Message-ID: <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
Date: Fri, 14 Feb 2025 09:17:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eaff44-d057-412f-724a-08dd4cd001b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWtlRG4wblpoK0JXdldHbkxCZGxsaGxxa0Q4ZXZRZlBBY0ozbmhsUkl6WnNW?=
 =?utf-8?B?VFVRS09oNllJRWJDOXQyaGxOSjBNSU5CTTJlcFNUQVFQOURXaTI3UHRQT3lB?=
 =?utf-8?B?aFZXN1ZQWGJNcTR0UjNOSzE2eTh0MGVLblZBVFROZi91UC9wODNVN21Feitk?=
 =?utf-8?B?NnZLZm5vOWZaTTRFUWIyWWY3Tmg4bWI4UmgvOHBvbi8rMnM4UVp5L0MxQVV6?=
 =?utf-8?B?MDlJZ0RZT3BqTURwd2txTUdSOS9rdjN3K210ZysxN2lFaEoxZlVXbnNGMWw4?=
 =?utf-8?B?N2lsWHJNcDlKT2k0WFhBc05mbUplblBxaFp3UnJsRitrN2prcnZrVElMczha?=
 =?utf-8?B?UXhEUTdiT3NjZ1lSMGFkTlNaOHBTMzg4cEVGa29OOWR1UDlJaC9GWDU5TzM5?=
 =?utf-8?B?SUVNRzhQRWMxUE9ndUkrWUdndXh6TUwxSDE5bjhRZ0RXQjF1UW95K081NDB5?=
 =?utf-8?B?OVNFY0o4bjYrSklaNU1QZXl2eE5FNWI3c3NqWUJuZU54cXRpMUtDRG5PZ0hU?=
 =?utf-8?B?Tk9leVhiOVB4dDZTTmcwSFJ4VXRDZ0NIcmFaSnZTY2RtbkNna2paMUg0aDdU?=
 =?utf-8?B?eW9SU2RDNDhUZ1pVZUdVRGNCcDVIMmJobGYzM1k3bkw3NUpEcnl2QlAwekpX?=
 =?utf-8?B?MCtQR0Zvc24zS3E0S013SVhoZWpwaEJMQ2N4a3dBNkVyd0ZGQUxVbW5qWGl5?=
 =?utf-8?B?cTJmYjBZODJiRnhVUTc1TVhnbWN3Z3NpeXFWbFlySGFKMDZva0xITDdhSGov?=
 =?utf-8?B?aS9xeG93WG9zUVpQQTJ2NW9HMi9iWUdlekJyUjYzZ09EeEZ1enRlcFBMM3R3?=
 =?utf-8?B?cG43NnU3UDVGQkRZRnpIVVgrWllnOTAwTkh2alJOaU1KOGVtbFordzFYazZ4?=
 =?utf-8?B?c1FCME5uZWUvbGN1RjVhUFlxSm82dVhVQkxEc3JqVnlKMkxjV1Mxc3NwaEth?=
 =?utf-8?B?YjBZblA5WURENEN2QUNmLzcwOXNjSHUrQlVnbFBXUHhQT2ZjUlMwTzkzYWgz?=
 =?utf-8?B?bXQvYnEvaUE5Q1dtWlYzMmI2NkZRZnR3aUVUcFA5MTVSL0wyL3pZYzFOOVQ2?=
 =?utf-8?B?UWdYOHVnNGN0RU51NGEzc0c4NTZqdWxvbC9TM3pGY2dFTmRLalVOZDkzc1Ns?=
 =?utf-8?B?VWxTZHBNRzJhUmFUS0hkcFd6OU41VGltMklnd2psS1Fpcy9oUU9CUTIwSzAx?=
 =?utf-8?B?bFhsUDNtSVFIdEl1OStyeXllR3liT0VMWmJLblo0dTNjUUtWU2srVXlJd0kr?=
 =?utf-8?B?K1o1akZXTmY4Uk9ia09IeS9ES1VFeUZ1SnM0MUo2bVJaS3M1RXF5YWxiQlF3?=
 =?utf-8?B?aUxIZ0dMc3hiUnlCQ29yR2U3OGtnTGdEZ1E4ZVlKYmI2YW81R2tHa3hHMEhH?=
 =?utf-8?B?VWdmWTFiWjJ6YnQrZ080UTZTVm15dGMvUmVmZ1plOEVhaDhRTmZINEtMWXZ5?=
 =?utf-8?B?UFRITE9NQ0xKMm1oRTFvTHNCUE9OeUJTaUVHTHlJNU9TY1RiTnNFaThKM1pM?=
 =?utf-8?B?SGNkTFJqNExodGd2ZDhUSnUwc2IxTTIrbWpvY0NDb1plYTNRdDVOcm01ajl6?=
 =?utf-8?B?QXBpQTg4NGNJY09KVkxJekNtajExcUJJRms2TXo3S3VZeVZEWUFTeTdzL3lr?=
 =?utf-8?B?L0prU2R6VjFFQXI5KzZ3M3hFcVJVUkFnYUhRTmRFRXVMSnhiSXhqbkZWOW9h?=
 =?utf-8?B?cHdOeG16U0tMYmtXemVYbkZ0MmtNQUJJZHNTSDAvd0UzYXJDR0U3K3h4N0xM?=
 =?utf-8?B?RHFOYzFKTXBZZkZlMExqNFBkY1Z3MC9hZzFvb1p0RTdGN0EvcHIzenVPVVht?=
 =?utf-8?B?SStOby9lRHkwYm82MXFrM1ZtUEVSVURpUkRVNEg2VWRwZTN1cCtNYXl2KzhS?=
 =?utf-8?Q?tDShyHcyGPafm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnFhMjc1VlJCaC91NHhpVkRKNktVakxadEdLWE5BN0JYNEhtbmVJTVYzeGhO?=
 =?utf-8?B?NTBFT2czRHFCb2xtRm9XeDhoTUI3UDh4bjRjU3pYTDFFd2c4UnBYZDRlelp6?=
 =?utf-8?B?UVpHY1dwQ05XNXNSOW1lZ050aC9DQUtYa1NSbFhIajRXeTY1S0NDRG1jZlRU?=
 =?utf-8?B?OVNXcWprSTB1NjkwdWZHbjJ0YUhLeTV6SHhZaWNYOGFWbDVzeDFrK1BReDZI?=
 =?utf-8?B?aWJVOGRJZndtWnpkRWhqYkFvNis4REM4V1BoQTk1RUFSbVV3dDNkMHhndi90?=
 =?utf-8?B?ZG9OaGVSL1RuVC9YampIZ3Z2K2FvK0x5aklqL1NMRkxReDNWQS8xdmZGbU1I?=
 =?utf-8?B?dXdpNk9aRm5SZ1RJU09NaHpSdzZpOG1PZkNPMy8xWEhrck0xZERMVFBWUFBw?=
 =?utf-8?B?KzB1SllwUWFXdmRTTFdLeDZGNnlKeWhuUXRlSmNMcUx6YzhHZG1OejdOcDgr?=
 =?utf-8?B?bW1ocDBrdDhmeTdQS0JMNEVvUlNybXFtSGJocjRoTDdUb0t3NlJ3YStlTklW?=
 =?utf-8?B?NjkvczZpci9kSmFBUWN2dDVReHV2UnU2Ymg2SXptaDBJeGpOS3c3TkZqeStK?=
 =?utf-8?B?S1BHSnVpWUtESE1LSGtkUzJjMEk3dlIzcTlnTjkvcTRQRmV6bnpiZEdqSyt4?=
 =?utf-8?B?dkFRSDRrbGdiY2ZvKzNBZUlEbFFWb0NtV1BhSENkT09hY1QzVU1FU25QRVZU?=
 =?utf-8?B?eTNmTlQvTmRIZDhzYkVrQk5COHIyTmV2TENyQWNnZFRIcVRhMkVJM05YMWZZ?=
 =?utf-8?B?c3p5ZXdBRDhzRkc5OUErL0dROXRjZXR5YldPQlpoV0NNTCs5NUZReHdMd2dr?=
 =?utf-8?B?ZDlWSFFZVzZobldHaHJJSHAxSUY0d1V6NjNnMUtSL1FsQk52aVpSakZqZ0ZI?=
 =?utf-8?B?QjF6T0xIbCtuTm9rUjNLd3g4cXdTRnVKVUo5Uk1MNVo1anpNY1ovZjlmdmp4?=
 =?utf-8?B?WG9xRGprdDFPNUE0bVNoWithUnYyTW5wMWkxeHhqNkVldktvMWVuZklpVTF2?=
 =?utf-8?B?Q3BaOUtDY0V2cGV4T2NNTDFlQWJrN20xWDJqTWwyV2h3YjJtZTc5QStQcDV6?=
 =?utf-8?B?NHFBZzNzeGUwdmpEaVlyQlpOM0NhVDZMTU0wcWFSWXNJZ3k2azlZTk9NUlpP?=
 =?utf-8?B?V2dFSmJLSENiN1ltKy9RdWw3bkJDa2g5OUNpWmx6MmdQbkw5T1RGQlpvVkpR?=
 =?utf-8?B?ZnNLK0U0TnRxMS9tRkRoVkJoTjM1RE0zeTY5K1h1dFEvQldOV1RGcStJV0tU?=
 =?utf-8?B?VGpDWENZa2hqTms1eXdFSDVzNEV4NDlBY2MyR2RTR0dtWFh6ejgvOFFGWXRI?=
 =?utf-8?B?bzN4cGlWZVhsbXVMZDBCNHZuK1NPR2R1eDk0ejVzL3R1TVBnNFdnTjlPS1I3?=
 =?utf-8?B?ODJqTVFlRHNCQUl6UFg5TXY4anRSNmY0SWhxMmowZ2JCTThKUyt3aGdQRkVO?=
 =?utf-8?B?NktLaWpzempwS0RzQUJQRVRhZ0FINWgvRjlLUWFpcjlBQVZ1UmE5OG9lbzJ2?=
 =?utf-8?B?ZkZHMlRXVmROajlOYzR3cW9zdVMzUlVvdnA0ek9YTmQycnk4S0R6NURuMlRD?=
 =?utf-8?B?N3pKMnBWemE4ZlpjQy9Nank3clVMajZuUFlzUjZkQmU0MTBxMllDVGlkMGV0?=
 =?utf-8?B?Y28wODhQamNScElFcmx6d09zMmx1YlB3RzJXUnlEa2RaVzk3NUg5VVZHNDZ5?=
 =?utf-8?B?cUk4d3JTSmNnenR4T2EwSVV2Y3VmMXpYSUJJK2JhTXFPNEExSkVtTWljeGM5?=
 =?utf-8?B?N0ZTVGhhaFI3emh3dHk0WjhpMkFDbGxUS0hKTFRSZTNYLzVBY0FMR21YVFVR?=
 =?utf-8?B?VTlVSGtudFNkcUt1Q2RHVms5UkVNYytYN1NrNkF6OUE5NndYNzBmZzV3eXN5?=
 =?utf-8?B?SVh2bW5sWjl1NU5GVWFBZmE3TE0vbS9VY2NZbjJsTnVESzFxVHE1cmFWWHhL?=
 =?utf-8?B?Ly9meHBiVm05QTYzZkIyWlhldkg1MFVLRTluQ0xVeFVHQVZzVDlKS1M2ZVcz?=
 =?utf-8?B?aVgxT0h0WVY1YXZNVzBDd2hjWUlyWGZvelB5UHdzM1Zaa3NyUFRDNGpZNkFv?=
 =?utf-8?B?Tng2bGJWdzRBeGV6UXBlMFhLUGx3dTY1Z3krTFgrRjlmMFpzVUVBcmpGN2dR?=
 =?utf-8?Q?zLEQP5ISbcjpeX41OwWe5FPff?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eaff44-d057-412f-724a-08dd4cd001b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:17:22.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFb5/z8+LZK6sxVR1SQ/pntabine6ek+Coc9RpaWYaDeYZHIDB+nigMt/muUN4wW2DsVNPOSQBGRm7rpA8Apog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3135
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 08:17:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17836

On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> This revision brings the CONFIG_EFIVAR_FS to read
> the EFI (Extensible Firmware Interface) variable information via sysfs.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 53bee8f..e761957 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2022-2024
> +# Copyright (c) Siemens AG, 2022-2025
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "e486c93a916cb6f78b4917b7345e8818f96069f9"
> +SRCREV_cip-kernel-config ?= "6b5db480b7a43e0217b1fa58f487f0bb997743c7"
>  
>  do_fetch[vardeps] += "SRCREV_cip-kernel-config"
>  

Argh, the commit to cip-kernel-config is broken: We must not patch the
merged configs only anymore, they are generated.

Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that
switch causes the merged config to turn it off again. I though that was
fixed?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

