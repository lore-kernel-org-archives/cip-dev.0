Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA3109C025
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 14:39:38 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23835.1774449569744146440
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 07:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A1017bjg;
 spf=pass (domain: siemens.com, ip: 52.101.66.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK89mPX9Cs29ZEJNx8k792+iimm/HLO9+FVz1D36F1sHKEue3iG2CYA8AUTEVaiHvenSQcdmF9vAWRqCEnksEfRpuSgaJ9bKtNz4jcuHyX32nftTJgNHBNxACgiBGfFiBqDTx4T6zI6KtMd2AECzdEQcVqIQhi569JRQ5bMdv3pSaroo8gW5lGrD6+iBkgdTd5CMMkcEcBAjGnjKQZi3ZiSaPGVt4JZNC0IjEch9kAhHdDReSTJ90na6wPfQYz+aOgBR/9BYoM6ZSCMFQcyf82C5nIEyfdYCum7JIU1kZCU8WkJo7Saw/6UUc7R9XJAKnJDwMXWOi2/vstH9kUjizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv+ZjWYrr1YxPc9J7C4TziDwwNVxxYAtJVCVogBsQB8=;
 b=mOIy00EZvfO7s1yC7FY9hHFowg5JN2PYnmktmbqmdrrzSnINL4uB7olNGyVrt5pLTGwu56ER0ginNqd3N/EUVFid0wNqqbq+ktKhwVHFPnWQxpva0B/jjz6btbn/pnPJdHi4uuol1SZldgYfzKoDbrmULnNZCplY/SCtcTUHYUE8tO1yzC5qOPLnn1AdxbeHcLi7PtP2+IBTeOJw4ub9Hk8F36ANhTD4qBBmE9JzPtq3sB+O2q61H4BLhbmD/hyt3FReRQTLMTEM8meQW+iw2lGH7WNTzMPWEsbpgw45gJkYEH/UcadyFSUwFHPTke+wSf9P0iR1fvFpDztnFBSpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv+ZjWYrr1YxPc9J7C4TziDwwNVxxYAtJVCVogBsQB8=;
 b=A1017bjgM7vjmgQfzvw5B3+ZExY53orZtTUlI1x4/Z47ZfW857MngNNfawPKyDODAdfMrymOy2gAIF+U8iYV9RT3CqMw8B9vP43IvTzGJ5l4JOvYFU6/B79JvGcQG/K1/jHfMqeLB02tc00w2oAxIMNuu8SNN/E8wfYDCSySBAdRHIbAnJweKZY+/2kgQKv0BBHWCbWj/jdpgVyv5/moBZUC7OjXftaB7gq1SDgM1XtN0FWAyELRh6c9GHCbKp54+7SZPoIIxMzdpVdS8ojSofXeKwTy0qr4PYVkSqJEc9rPCj3ZOazcVBaI4WDgH0T5UKLKYZnnSOzBf2aSL6c6Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:39:25 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 14:39:24 +0000
Message-ID: <d6ef54fc-2e1e-491f-b6e3-d86dab45aa02@siemens.com>
Date: Wed, 25 Mar 2026 15:39:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] chore: Add maintainer to all
 package recipes
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260325132946.611659-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260325132946.611659-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4227dd-43aa-4755-f63b-08de8a7c4f6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	QlWjQt58kaJqqQN0y8nUGXouBAOwA8FlFcE4WSBvZ+8md48J4dODOz8RCh51AOm/hBH1p5s7/Ubo6vDTiluoCSwGfd6KFCuL+AXneB6hgCWS9goDpHMsmU4LVknoi5j4X5Nn91hRMtv7tDqf34JK/MF9ybBMltXM1Ar2um5RB/HKhTAVGIsdfTy5voMqIk+/n85wFo/ZoU521QbyE4Kd6qMYy19VaDvRvCuovLpTWa9AcDI8P5LyFUfzoRtm1x+LhLVyNWUgBmq9jjjmEt5MWppwkNKI0Tkb220Z4ZuTR2JdAWJ+2CT8PkqG5g8deXJNTrDNGVb1NrO6eYPZm84Sis306PIo7IlY10GHdw2SFNqDNmD/sWLYP1MPXZyVx9uzVg4nD45FzsQdtqG/oosXzowYiyt0YKMqzmgKf2Z1Nrms07mLi6lmYeZOFdD2fp3yZL5NUUOlMTp4I6T5VzAHC+jTg4V/mprstkiKKo30jIpcJ1EzB2B7WDblIfVRezyBUdnXL4B31SJNn5XVgyMWdV8xdp9/5N0y1mIUqr57coy8enXg1raJVV5YS/KhFEmX1C5TMa/EWm3xiWUL2aMdLttkF2yIEDcm3mj/PKRosTfg9TtQyUo2MTFTGRK6nqJVJLD81kTwu2x3LtMRaRq3ZAVwBcWji8JxxRNi6oW49LWy05IzRu0ySYAmx4YtYUvD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cU8veTRsRDJyT3VxQ2s0QU41aGcySWMzM3ZZcE5yQnhmSGhwN0k4Wk0relRw?=
 =?utf-8?B?SWExSlN6Umh3Y2ErMkJNMlhlTlI0UEU4NFBVYTNmUXpHRFRnMWxjMVNJSTFl?=
 =?utf-8?B?TXd1STlhUnprV0twM1JjYUE1a1dhVmwxays2R1RlUmx1aWQ2OGovWWxaaU1V?=
 =?utf-8?B?ZndKRlNldEVPZmpOQThuMGlUMlgyVDZjb3JNSGZ4YXVMd1Y1RzMycFJmOUxl?=
 =?utf-8?B?VmlFZkkzNURxRUZ3dDJBUmNoTTNybzdPL2hsV051R3dRY3ZFWUYrUFRXR2xh?=
 =?utf-8?B?NFpyZlN4Y1VHUG51ZjFBTlFJWmhReGdVdE82cGZobk94YnRlK1V0a0JIYkw4?=
 =?utf-8?B?bmJVZTJYZHBNc0xJMkF0ZXF1R25GSzZoTm81Nm5tTzZ5b1E1NTlYU3pVTEpy?=
 =?utf-8?B?RHZ2WFJqVytVMU5VN1hKSDZqZ0d1b1BhMitmc0JROS82dllSckFiUmZjRkZa?=
 =?utf-8?B?bExqanVJa3BHMGJvSkJKd1lmK2U4enpEVmZGN0czRHpsd0Qwb2JFUGJ1TlQw?=
 =?utf-8?B?L2dJLy9hYWM1VE1kV1NKaFk1NWNmUzNXbUlJLzdXT3lNYlhXVG1MdXkzWmpC?=
 =?utf-8?B?dFZTck16UEtIUmJBVitmUHNFdy85NkZpZ0d2WUphZUU1NFRyeitIZzUrR1VU?=
 =?utf-8?B?cHpxRld3c2RWMFQ2ZlVwVGpkTmU2RnNTaUMzYzFtMDFlWkp0NWIxV2JJczZK?=
 =?utf-8?B?VzNRelFLU3JIYnB4QXQ5amRRVDZrQW40Zlp3eXI3V1VnS2hmOEFOSzdnZXVW?=
 =?utf-8?B?RnhhNDZab3Z2cVRwaWV3RENTKzlma1prU3ZBbzBjSXNZOFFqcXJlWWVlRWRl?=
 =?utf-8?B?YWRPV2trblFoclA2cGdQY2tCUjk1Rkd3bFVONVVSOGNwZjA1YjFkQmZtYzlE?=
 =?utf-8?B?cndraXkwTGF5T3FRVHZ4amJzUnoxOEJGU3ZwK3MyRSt4M2FoZHVhSXFocldr?=
 =?utf-8?B?L25WOUdpbzRzc3N6dUdLZHoxajNZLzh1KzZaMDJlQmd1SThPNGY4N25lTHhG?=
 =?utf-8?B?cnBRMURHN1JIS1RqSk8xc1JlRjg2bmF2cERPb1pYUVFPWG5LTlI3ZzBlVnNs?=
 =?utf-8?B?czZqQnROcnkxRml1cmZ0MXFTVktlU2tLckNGYXovTWpQL2FSWXR2OWE3blJl?=
 =?utf-8?B?R0hsUERVd01YbDk1Z2l0ZjY2NnhMVWs4WVhjSTQzVFRIc0hWSkFZMzJnL0xY?=
 =?utf-8?B?WDQ5elZTanRUMzVYNHc3dUQ2MWhWaHhDaE1CazU3bFNqT1NWNUNJRXNXOWZj?=
 =?utf-8?B?TnpXQWJjWUtFb0hKY1ZzeFVDc3d4OGt1UDhTYzlud2xheDlqb3MweGg0bllI?=
 =?utf-8?B?TVlpbXVIZ1pUWUdqM3dmSWZMT2lpOGZNM0JBN0FTQUhTR2p1UEd5UkthT0Rj?=
 =?utf-8?B?a0hEWGRQZnVnTk5CUlU2cWVsY2NHaURLaEVwMWRwN3pxZTRNdDhOc1dWZTI0?=
 =?utf-8?B?bnRQanZXQTZTa2ZlNlpYekxMcG8wei9WdDhhb0xvek9hTUZHTGFJeFZneTZZ?=
 =?utf-8?B?SzhaNUUzMXBJdEorNnQxaWFSNVNEbnhBVU1pMjV4eTN0N25qRExNQy9CTHVG?=
 =?utf-8?B?WW1pZkhpWDhxNVZ3aGMzSFZFelhSY0szYmtaN2o0c2NWZmkzZExsSG50d0F2?=
 =?utf-8?B?SUdSZlgyUlBWaEdERVFJSGo1R1E2YkpyNFo2SDl6WFVzWmJYcFcyOGVpbVZx?=
 =?utf-8?B?eFJzalJHUEhuK09qNXNJWTcxQVROdHdseTNLS05abFlpUzVRcDNQVTgwaHpD?=
 =?utf-8?B?cUpxQnhNYnBTZFcraUh1MDd6cy8vZXFONVRSSDEwZlhuKzZzTXB0b0FRc2VB?=
 =?utf-8?B?TUJHVk1WYUQwQUNnNVFLYlFrYU0wTHFWVndGSm5RRDFVaEFkcjNveHdzbG1I?=
 =?utf-8?B?RDVjWDNUOW5icEZ3SlVpb0dPYU9COXhmNFBpOEZuN2hKaTVXRWplTmx4WXYy?=
 =?utf-8?B?RUdJbldEcG9TS0Mxc2xtZjJpazBXQjIvVjhVUWh4YmQ0a3pmSTlJazlvWlJC?=
 =?utf-8?B?VDNsN1NYbExGSXdIUktiVGNRbktwOFRldnZJRlFlTFVpYTBDaXBwNUpsT0hI?=
 =?utf-8?B?TGh6MTZYbnBVbzdieWRueTFWZjcxekpwMjREa2VMQTczdHpCTjJGNnBNVW5O?=
 =?utf-8?B?TysvdmRtaUI4MG9kK3pxYTFTcWNrclZCR2tSMHJFSUtvTWxUN1dVaGFxMG90?=
 =?utf-8?B?cURLZDdFTUcxdisvK2VSY2V6NTRuaVRJRHhnZ3pPQURyNU1rSlFjR0QxdFhQ?=
 =?utf-8?B?OGYvcE04VzVUWGtIaU1iUFdiYzk5M3RKdzBVWmJ6SHJkbEhicFBYS1BpQmJL?=
 =?utf-8?B?NmlndmFZdG5JS2xhWU84QXBESGVvTDcwcmsvRTdSVDk5cGpSTFV4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4227dd-43aa-4755-f63b-08de8a7c4f6f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:39:24.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiUwS2oLnuve4H0pQj/sde/bhnayu1dO2tz5igOxcKQQN34TvWCjYYgaRGeW7gghIion7yrjKkzTdcwdtWIedg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8964
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 14:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22567

On 25.03.26 14:29, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids the warning introduced with https://github.com/ilbers/isar/commit/712a62478d0ad34b7364f2892f485b7a014610c9
> ```
> WARNING:  do_prepare_build: MAINTAINER contains '@example.com'. Please set a valid maintainer.
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - added missing optee-ftpm, opensbi
> 
> Changes v2:
>  - added optee and kernl and swupdate inc. My script forgot them
> 
>  .../hss-payload-generator/hss-payload-generator_2025.07.bb      | 2 ++
>  recipes-bsp/opensbi/opensbi_1.7.inc                             | 2 ++
>  .../optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb | 2 ++
>  .../optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb      | 2 ++
>  recipes-bsp/optee-os/optee-os-qemu.inc                          | 2 ++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc                   | 2 ++
>  .../trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb  | 2 ++
>  recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb | 2 ++
>  recipes-bsp/u-boot/u-boot-common-2026.01.inc                    | 2 ++
>  recipes-core/change-root-homedir/change-root-homedir_0.2.bb     | 2 ++
>  recipes-core/customizations/common.inc                          | 2 ++
>  recipes-core/home-fs/home-fs_0.1.bb                             | 2 ++
>  recipes-core/journald-config/journald-config_0.1.bb             | 2 ++
>  recipes-core/kernel-panic/kernel-panic.bb                       | 2 ++
>  recipes-core/ltp/ltp.inc                                        | 2 ++
>  recipes-core/move-homedir-var/move-homedir-var_0.1.bb           | 2 ++
>  recipes-core/security-customizations/security-customizations.bb | 2 ++
>  recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb     | 2 ++
>  recipes-core/swupdate-config/swupdate-config_0.2.bb             | 2 ++
>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 ++
>  recipes-core/swupdate/swupdate.inc                              | 2 ++
>  recipes-core/tmp-fs/tmp-fs_0.2.bb                               | 2 ++
>  recipes-devtools/dosfstools/dosfstools_latest.bb                | 2 ++
>  .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb        | 2 ++
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc    | 2 ++
>  .../swupdate-certificates/swupdate-certificates-key.inc         | 2 ++
>  .../swupdate-certificates/swupdate-certificates.inc             | 2 ++
>  recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb     | 2 ++
>  recipes-devtools/swupdate-signer/swupdate-signer-empty.bb       | 2 ++
>  .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb      | 2 ++
>  .../initramfs-cip-functions/initramfs-cip-functions_0.1.bb      | 2 ++
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb           | 2 ++
>  .../initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb            | 2 ++
>  .../initramfs-factory-reset-hook_0.3.bb                         | 2 ++
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb        | 2 ++
>  .../initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb      | 2 ++
>  .../initramfs-verity-hook/initramfs-verity-hook_0.3.bb          | 2 ++
>  recipes-kernel/linux/linux-cip-common.inc                       | 2 ++
>  recipes-python/shtab/python-shtab_1.5.5-4.bb                    | 2 ++
>  recipes-security/fail2ban-config/fail2ban-config.bb             | 2 ++
>  recipes-support/factory-reset-helper/factory-reset-helper.inc   | 2 ++
>  41 files changed, 82 insertions(+)
> 
> diff --git a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> index fa86094..cfb821f 100644
> --- a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> +++ b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI = " \
>      https://github.com/polarfire-soc/hart-software-services/archive/refs/tags/v${PV}.tar.gz;downloadfilename=hart-software-services-v${PV}.tar.gz \
>      file://rules"
> diff --git a/recipes-bsp/opensbi/opensbi_1.7.inc b/recipes-bsp/opensbi/opensbi_1.7.inc
> index c83935b..885401d 100644
> --- a/recipes-bsp/opensbi/opensbi_1.7.inc
> +++ b/recipes-bsp/opensbi/opensbi_1.7.inc
> @@ -5,6 +5,8 @@
>  
>  inherit opensbi
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += "https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
>  SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
>  
> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> index 7c66cdf..0dacd50 100644
> --- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
> @@ -11,6 +11,8 @@
>  
>  inherit optee-ftpm
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
>      https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> index 38770b4..b28ea77 100644
> --- a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> @@ -9,6 +9,8 @@
>  
>  inherit optee-ftpm
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
>      https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
> diff --git a/recipes-bsp/optee-os/optee-os-qemu.inc b/recipes-bsp/optee-os/optee-os-qemu.inc
> index dec393e..3538d36 100644
> --- a/recipes-bsp/optee-os/optee-os-qemu.inc
> +++ b/recipes-bsp/optee-os/optee-os-qemu.inc
> @@ -9,6 +9,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
>      "
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> index 5ee5020..4e99949 100644
> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> @@ -7,6 +7,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
>      "
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> index a65f2ac..4786f34 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
> @@ -12,6 +12,8 @@
>  inherit deploy-firmware
>  inherit trusted-firmware-a
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += "https://github.com/TrustedFirmware-A/trusted-firmware-a/archive/refs/tags/v${PV}.tar.gz;downloadfilename=trusted-firmware-a-v${PV}.tar.gz"
>  SRC_URI[sha256sum] = "28bc15daeeed000ecd30819ecc4851bf9ffc2d33e1d4553a71985c17f47a999e"
>  
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> index 89728ec..25b8889 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -9,6 +9,8 @@
>  
>  inherit trusted-firmware-a
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
>  SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
>  
> diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> index 9d12dd9..850847f 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
> @@ -11,6 +11,8 @@
>  
>  inherit u-boot
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  FILESPATH:append := ":${FILE_DIRNAME}/files"
>  
>  SRC_URI += " \
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> index a0725c1..702e518 100644
> --- a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>  
>  SRC_URI = "file://postinst"
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index c4d201f..81a36ed 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  FILESPATH:append := ":${FILE_DIRNAME}/files"
>  
>  SRC_URI = " \
> diff --git a/recipes-core/home-fs/home-fs_0.1.bb b/recipes-core/home-fs/home-fs_0.1.bb
> index fb9e351..fd88f21 100644
> --- a/recipes-core/home-fs/home-fs_0.1.bb
> +++ b/recipes-core/home-fs/home-fs_0.1.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI = "file://postinst \
>             file://home.mount"
>  
> diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
> index 00dbfce..62fc0c7 100644
> --- a/recipes-core/journald-config/journald-config_0.1.bb
> +++ b/recipes-core/journald-config/journald-config_0.1.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI = "file://persistent-journal.conf"
>  
>  do_install[cleandirs] = "${D}/usr/lib/systemd/journald.conf.d/"
> diff --git a/recipes-core/kernel-panic/kernel-panic.bb b/recipes-core/kernel-panic/kernel-panic.bb
> index 511febb..22a4dde 100644
> --- a/recipes-core/kernel-panic/kernel-panic.bb
> +++ b/recipes-core/kernel-panic/kernel-panic.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "Systemd service file to cause kernel panic"
>  
>  SRC_URI = " \
> diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
> index 27e26a0..4d524f1 100644
> --- a/recipes-core/ltp/ltp.inc
> +++ b/recipes-core/ltp/ltp.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "Linux Test project for CIP"
>  
>  SRC_URI = " \
> diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> index 608bb69..54e807a 100644
> --- a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> +++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DEBIAN_CONFLICTS = "home-fs"
>  SRC_URI = "file://${BPN}.tmpfiles.tmpl"
>  
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index d8fa22b..382f0c8 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
>  
>  SRC_URI = "file://postinst \
> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> index 3569888..c800c84 100644
> --- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES := "${PN}"
>  DEBIAN_PROVIDES := "${PN}"
>  
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> index 63fa320..cdfd8b9 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES := "${PN}"
>  DEBIAN_PROVIDES := "${PN}"
>  
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 59ac49e..2ba192c 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 1f9eda5..497b1c2 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -9,6 +9,8 @@
>  # SPDX-License-Identifier: MIT
>  
>  DESCRIPTION = "swupdate utility for software updates"
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  HOMEPAGE= "https://github.com/sbabic/swupdate"
>  LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> index bb5fcce..f2b7976 100644
> --- a/recipes-core/tmp-fs/tmp-fs_0.2.bb
> +++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI = "file://postinst"
>  
>  do_install() {
> diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
> index 37a8f42..d0ac128 100644
> --- a/recipes-devtools/dosfstools/dosfstools_latest.bb
> +++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  CHANGELOG_V="<orig-version>+cip"
>  
>  SRC_URI = "apt://${BPN}"
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> index 57ad1be..6963d09 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> @@ -12,6 +12,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  
>  DEPENDS = "secure-boot-secrets"
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 5277d9b..38b57ee 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES += "secure-boot-secrets"
>  DEBIAN_PROVIDES = "secure-boot-secrets"
>  
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 2abb963..4124b31 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
>  PROVIDES += "swupdate-certificates-key"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 344775d..3c59887 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
>  PROVIDES += "swupdate-certificates"
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> index 44bbd0a..ee8d172 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"
>  
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> index fde9cb4..af9de76 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"
>  
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> index 3538bcf..48f6458 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  RDEPENDS += "initramfs-cip-functions"
>  DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
>  DEBIAN_CONFLICTS = "initramfs-verity-hook"
> diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> index d497aa4..73ee68d 100644
> --- a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> +++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "helper functions for cip initramfs-tools extensions"
>  
>  SRC_URI += "file://cip-initramfs-functions"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> index e132b9e..18a10a8 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  RDEPENDS += "initramfs-cip-functions"
>  
>  DEBIAN_DEPENDS .= ", \
> diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> index e423248..2015503 100644
> --- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
> @@ -11,4 +11,6 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  HOOK_ADD_MODULES = "erofs"
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> index 7dc04eb..e962a51 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> @@ -10,6 +10,8 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "Delete the content of the given Devices"
>  
>  # list of partitions by label
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> index 4ec382c..57b26ec 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
> @@ -12,6 +12,8 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>  
>  SRC_URI += " \
> diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> index 1f5decc..9ff4cbf 100644
> --- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
> @@ -11,4 +11,6 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  HOOK_ADD_MODULES = "squashfs"
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> index a0ee803..b2fb704 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs-hook
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      file://hook \
>      file://local-top-complete.tmpl \
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index b96adbe..4569b89 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -13,6 +13,8 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
>  inherit linux-kernel
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  require recipes-kernel/linux/cip-kernel-config.inc
>  
>  SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
> diff --git a/recipes-python/shtab/python-shtab_1.5.5-4.bb b/recipes-python/shtab/python-shtab_1.5.5-4.bb
> index 7a5cfd2..8ccef35 100644
> --- a/recipes-python/shtab/python-shtab_1.5.5-4.bb
> +++ b/recipes-python/shtab/python-shtab_1.5.5-4.bb
> @@ -11,6 +11,8 @@
>  
>  inherit dpkg-gbp
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += " \
>      git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
>      "
> diff --git a/recipes-security/fail2ban-config/fail2ban-config.bb b/recipes-security/fail2ban-config/fail2ban-config.bb
> index 87d1497..4900069 100644
> --- a/recipes-security/fail2ban-config/fail2ban-config.bb
> +++ b/recipes-security/fail2ban-config/fail2ban-config.bb
> @@ -12,6 +12,8 @@ DESCRIPTION = "Basic fail2ban config with systemd as backend"
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  SRC_URI += "file://systemd-defaults.conf"
>  
>  DEBIAN_DEPENDS += "fail2ban, python3-systemd, python3-pyinotify"
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
> index 56ac5b4..9e17daa 100644
> --- a/recipes-support/factory-reset-helper/factory-reset-helper.inc
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
> @@ -10,6 +10,8 @@
>  
>  inherit dpkg-raw
>  
> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
> +
>  DESCRIPTION = "helper script to execute a factory reset"
>  
>  PROVIDES = "factory-reset-helper"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

