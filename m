Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38161.1795595399707497321
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 00:30:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lJGfGXsc;
 spf=pass (domain: siemens.com, ip: 52.101.66.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jInau8Kjug0Qf6Cym5y2cK1T8HkFAFMsS0DzJ/DDe5LUGRenzd4pnnUZcBH7wRamhpy9iT4YI9jjga6i4UgBiQH5+dAwt1an7ShUXkSSQe4Be+WxOVwFaduL92S1T4c3W3+oGLDBQ4GmhVSDXAF2rsMCcjJyE5WMyqydGmVUlG+i1hdYR2IPLZFXmpHNCsd+aKF/gv83d0Y5XlWQMFMrqEHM/xol+e4k1Z4xrz+QNR+GPMoDmqg5CG+IUKzqnLXe5zEQyITwP/or3KilSDg37UYPM5CSUj9RKvFoFLhLkXGYAOloiO74WW2oq/x/b9tksfYxHge0KyOXjZFTGdzUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8J99j6N9Up/tcRjXogq8AYrZ9QS/AP7Hzx4fcT7/dI=;
 b=oYF1mkGmoSgyM6GTZbyMuZhDSbUm8nI6RgxvmlpXFF06FQyzgijz93BUVFUH9YfGz1kbx90HaldNdkS+SVsZ+yETCR77+N+v6JK1NsvZzeCBmGUQ+YDBDT6OdTh6mtWysiECmJQ8OJd1mIcKrDW26FPf2DSJCoRftY+MsdqrnxP6vaVwLdakAat3lj9b6iFOQn8zVuwdHxfzgc2L96dVJYRdaxgGalCDvOWC9Lxc7fRa4KZ23oXk7mNABMiQvMU3F8o+StowAP1J42dzdDrdGZw26+pOLUArJjalz3Mncxg9uaZkNKvjYWoWlwmj5hkC5ARH9cTGHLQYpWy4gpt44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8J99j6N9Up/tcRjXogq8AYrZ9QS/AP7Hzx4fcT7/dI=;
 b=lJGfGXscQo7Rd+HnendLx4nqdAdSrVK0wrBfpHJ7MSV17j4if2W1+BC1W/RvC5GXJHoA3Hr4caQze9eVL7JE07mYKQqjF5YG8KM0FAlUWcS1R0LofKACDhHe8HST7rkZBEDOLWkwQJl/7i5DjoHKzPxSK5dnpxLr4kTsu6YcF/S4+AQP/jYWN/3I8pkuh/fZBZWtmE5y7yMEyjp6XT+mM9JY6x/2PnxF0Hsg+VOo9JFQJA5raSuOP+RPTkS9DjAP0m05tZBCnEZJJuaVDko1kBENuVBlEBC/y8fGBjK7SpYhw6LAvCVnPHi/CQv+F6IJa6VCP78YFWWaHbMesuP3IQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8875.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:426::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 08:29:50 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 08:29:50 +0000
Message-ID: <f33d6b61-a30a-4685-a2a7-8e333cbcf6df@siemens.com>
Date: Wed, 25 Nov 2026 09:29:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wic: check EFI Boot Guard signers through the tool runner
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20261123142242.1753173-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261123142242.1753173-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cc0461-33ca-430f-2b8a-08df4ace45c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|55112099003|56012099006|11063799006|261021121427099003|261102123227099003|261022105027099003|261021123027099003|261022115727099003|261026121527099003|261026140227099003|5023799004|261028144727099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: LdHDsZK+WViRjfSXQqNzDVoFYxh7sXNeKTb6T19tC2bOaunD6kP+WFpBPO3ZlFIThW0n0/ZhkWbVtFpJisuJBZbtAN587sRCvihXDcxjtS9shd+kdVG0peI2KH5gVxT5ziMVEMhbAewF2p3itPkfLMyqAwwmjPYnBJz+SPUPjf5Qw7nkcbvEhMTjTaB5xVBDArSbL7xlerhdHaV8UzKOSWPPHvukECFK6RA0OIZnfFVUGioX7MoPGeU8AhsWyByHlE09jQkiD+4AKlEvrDGiZ70eG6ipqSf4SEYJjbXLVHm1MlhIo/3wnHh/cHfkrkd01QG8VqJjIo+A9nuB5izzcir9+kDC2Xp65uYS2+Ji/oIh4LuBjSNKvF6qIG09zgvq9ypP0dqKg0ucZexGHifYNPpUvV5k8BTO0wpORxUk4d/vJgirydgZukPyDnslhKkSgW8p+wmnZQvOx0tmfMeuoSm2/KP49BwXSTOHxrOJH6xHdRic0XHa9rdZFTJicF5UCkZWZVJJLXALmnPPMGK+kL8+5IHpeHczNlIwOiNhUdO86FkdgdThmxOSJA/LtkVOztGI6hBw572JTZ7p80VhFlI2DJqRIr+6+RtbPlLM74B1Jt5Y0A7+Sm/lVga079T99vUCnF6UxFbCxNr0PGIrBJRUChV0TnSiychKAeul+a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(55112099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261022105027099003)(261021123027099003)(261022115727099003)(261026121527099003)(261026140227099003)(5023799004)(261028144727099003)(261022075727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BtdWhKb0lqQXp1TmxBamxTUDdid1NDQ1RRZjFzd2VRb0c0aDIzUGxlU29a?=
 =?utf-8?B?Qkd6NmZhWWE3cUk1c1VIclVGQy8reGhRSEZmdU9PVWZSOWc3V1ZGQTAwdzBL?=
 =?utf-8?B?dVloMnJiSWNSb1FVQndPV3B5L2FEeWJDdEFsYVVHUmZmaEwrZVNSaUQrRmtI?=
 =?utf-8?B?VjVBa0lFZkpMZE5TYmFTTTlYZkxyalpoLzVmNHdyOGw3Qkt4WmI4SG1zb3Bn?=
 =?utf-8?B?TlM1cUpqS2U0Z2R5MmdWcnM1YWZWWkQxZklrV3hpNE9RZmF6UlpHQnd4bXp6?=
 =?utf-8?B?amVrL2Z1dVJrdmFMa0E5YUpCWlc0ZGZkbEpOMS96NzNHMGdCSEFLTXV0QUp3?=
 =?utf-8?B?UWpNVUtHaGZNaWlWSTUwOHVHWXNKeGNjbUpnenc4VW12aTJoYmEwRHlyYzlH?=
 =?utf-8?B?Q3lta28xbGRoVjBhT2lVT2lZUUxpTmQ1WlBsRHBVOWFaMzJ3UzlLWGJuam85?=
 =?utf-8?B?SkZxUldRL0FnbFl6TGxjNjlxdStnMzhzWHhUSlN5UEd6R3hWU3U1WVNzQVNG?=
 =?utf-8?B?MGtrYit3U2VPODZINDBCTUxtRTl0ZFpTdFNaMFl4WUIxanpMUkpMcFZQQ205?=
 =?utf-8?B?QTJkS2lmM25zbW5FQnAzcG4xenNoVVpaMGNzaWtNdW91YTdMc3lmQXV1R2JT?=
 =?utf-8?B?MW0zdnl6M0E2MlhOTi9UaGJPMXlXZUxyc2FNWVBtck5TeFNtT29zaDJRU01h?=
 =?utf-8?B?MWg5QjJXZXh1VFAwYUJDVElLV2EyQlBOTjhhdm8xaHc3YUowblRiN1o1U0lW?=
 =?utf-8?B?SnR5a1d6eHNqdlJCZlNlbkhXWU5rK1l3K3VsQ2xER2xLd2dhMEpiSURHcFk4?=
 =?utf-8?B?aG9KNXhQdEtua1pwdllrQ0JNZ0U4Tkw5MkE2bHlTUjluOU5aQ1FkeG1jN2I1?=
 =?utf-8?B?T1lLK1A3TWZhLzlXemhGZ3hmcWF6UTFwZWo0SGRFTHBqRDJiTDhhcUpIWG1K?=
 =?utf-8?B?d2J1S0JTaEJRdDBxVy81VXhUWUNEVXFjNDAwcHVFVmxUWm0xNkZkWHRpaW9n?=
 =?utf-8?B?ZUpqY1huVWFaZnhCVm9tOTJqUXN0cUxMRy9WV2N3c0NKbVkrZlI2M253QTFM?=
 =?utf-8?B?S09GL3FOVXoyaDZSSjlDSWcwcWhweWdqQ0ZvTGk2QUxGb3YwMDE5TjRzTW9D?=
 =?utf-8?B?MHNnYmVweHdVTGlVSTJlVFRUTklrRDJESThrTjNHN1AzVU9ETnVlU2l3Tllo?=
 =?utf-8?B?TXNGbE04Z1J2d005endPSkhPaCtXV0tkT01aYVdCNmttVHU4OFVsOFRPZTVy?=
 =?utf-8?B?cHJSRmZsSHVHbVhXUU5jelVpbDJDMDBxNjMyaUNLYW55SERKSzlLQ3lOdm9q?=
 =?utf-8?B?d2lYaFNFOGVlS3dRWHdsNTBsTSt2WVRrdVVNQzBuMklLeGRuYjR5NnpLdXh3?=
 =?utf-8?B?TEVlYW0vOENXNEsvVUQ0b2dSMFY1bUZJSUlWdmlSeFFyK0loaTdMY0lxSkRv?=
 =?utf-8?B?aWM4WXQyYTk2YUZIV1duWWNsR0hqZmlkdy9lb3FDKzV1UlNWNWk4MTFaMEhC?=
 =?utf-8?B?R2xpMWhMY1c3ZTVKNWdFNnBmeHlobEJabzdWTzA3ZXBCMWsyTk4ybHNtM21R?=
 =?utf-8?B?cGpTem1VNEJyUVJvMjUybWpXRnJGZ05wTHFoZXVBWTJXdVdidVFLNjZzdTNU?=
 =?utf-8?B?S2VUK0xxR0xoc1FSK0dMSnI4TFh3NUdwZG0rOVF6ZUV2MGRPOTFRZ0I5QlpP?=
 =?utf-8?B?S1VISEp4NVhObHRIRWJ5TGRWV0F6eUUrVG9Id01hR1ZVeWxMdVBHZ3VtZXBl?=
 =?utf-8?B?Um1rNG5FZU1XNTM1ajUxR3djYU9MbkhLYnRGNXRsTGxEbjlKTWFVRmpZWk1X?=
 =?utf-8?B?QXQ0NmFKNDZEbkdBWis4NkttLy81dnlzcjhxWm1DYlJSUnBzWjhjQWJPMi9j?=
 =?utf-8?B?a0xmS21NV2w1VllYUGVUaHQybE00bDdqWm5mV2FlV2ZDUEhuRmdBRCtxbEdp?=
 =?utf-8?B?Vjk0SXp5aEtQNFB2QkE2OEFsOHVPR082NUEydlFCUGljaE12Y2dzTFJmaFhY?=
 =?utf-8?B?ZE1qTktpTE05bmtLTXhHZmZjbGFsSUxjd3BPYmF0b3V2RmZYZGxrU0VFeTBD?=
 =?utf-8?B?bEdRNHZ4ZERsZS9sRGFTdG5keTh0eHV4VkFDMlZkMkRtN3F4Y0xPSFBhNmdR?=
 =?utf-8?B?cnpESTFCYWNSYmlBMXpraHJxKzg1ZmxEbjVjaDcxb1VsbWR4YXloajViSm1q?=
 =?utf-8?B?VHNISmUyOTFPWkV3YWNsbmNrUkUzSzNEK3h0UmptMS8rQ1B0eFFoODEvUFlj?=
 =?utf-8?B?YWZRYk5oaDEyUjVlemV3cmdTaCtUa08rN3hNMnZUQnF1Z1JCN1k3MkJ5a245?=
 =?utf-8?B?cWhDa2tSckp1eFlsdU8yVUxaYTFScTllbkhEdi83bnBKOHhnUnFMZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cc0461-33ca-430f-2b8a-08df4ace45c7
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:29:50.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egjy4PGSuVtzv1n4mX8QwWETB9bi2P73UhztXO6/5Penqa7jvMftRl/VpYLUsVScv999a/rfI4NUzqHofV3XbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 08:30:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25072

On 23.11.26 15:22, Clara Kowalsky wrote:
> This change has to happen in lockstep with the BitBake update in isar,
> where WIC's Python driver is moved to the build host.
> 

Then this patch is pure informational: I won't merge it as such, only
along with a future Isar revision dump.

Please refrain from such confusing postings.

Jan

> The EFI Boot Guard plugins execute signing scripts inside the imaging
> chroot. A host-side os.path.exists() check can therefore report a
> chroot-only signer as missing. Fix this by using tool_path_exists()
> before renaming the unsigned file, preserving the existing fail-fast
> behavior when the signer is absent.
> 
> This was tested with:
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/trixie.yml:kas/opt/ebg-secure-boot-snakeoil.yml
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
> This patch has to be used on top of isar with
> "[PATCH v3 0/7] Update BitBake in Isar" [1].
> 
> [1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/la9-tg36AgAJ
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 10 +++++-----
>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index ca97d7d..d8b9212 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -37,7 +37,7 @@ import logging
>  msger = logging.getLogger('wic')
>  
>  from wic.pluginbase import SourcePlugin
> -from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
> +from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_EXTRA_SPACE
>  
>  class EfibootguardBootPlugin(SourcePlugin):
>      """
> @@ -258,7 +258,10 @@ class EfibootguardBootPlugin(SourcePlugin):
>      @classmethod
>      def _sign_file(cls, signee, source_params):
>          sign_script = source_params.get("signwith")
> -        if sign_script and os.path.exists(sign_script):
> +        if sign_script and not tool_path_exists(sign_script):
> +            msger.error("Could not find script %s", sign_script)
> +            exit(1)
> +        if sign_script:
>              msger.info("sign with script %s", sign_script)
>              orig_signee = signee + ".unsigned"
>              os.rename(signee, orig_signee)
> @@ -266,6 +269,3 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  .format(sign_script=sign_script, orig_signee=orig_signee,
>                          signee=signee)
>              exec_cmd(sign_cmd)
> -        elif sign_script and not os.path.exists(sign_script):
> -            msger.error("Could not find script %s", sign_script)
> -            exit(1)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index f84c61a..504164e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -38,7 +38,7 @@ msger = logging.getLogger('wic')
>  
>  from wic import WicError
>  from wic.pluginbase import SourcePlugin
> -from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
> +from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_EXTRA_SPACE
>  
>  class EfibootguardEFIPlugin(SourcePlugin):
>      """
> @@ -168,7 +168,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>      @classmethod
>      def _sign_file(cls, name, signee, cr_workdir, source_params):
>          sign_script = source_params.get("signwith")
> -        if sign_script and os.path.exists(sign_script):
> +        if sign_script and not tool_path_exists(sign_script):
> +            msger.error("Could not find script %s", sign_script)
> +            exit(1)
> +        if sign_script:
>              work_name = name.replace(".efi", ".signed.efi")
>              sign_cmd = "{sign_script} {signee} \
>              {cr_workdir}/{work_name}".format(sign_script=sign_script,
> @@ -176,9 +179,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                               cr_workdir=cr_workdir,
>                                               work_name=work_name)
>              exec_cmd(sign_cmd)
> -        elif sign_script and not os.path.exists(sign_script):
> -            msger.error("Could not find script %s", sign_script)
> -            exit(1)
>          else:
>              # if we do nothing copy the signee to the work directory
>              work_name = name

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
