Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54931.1795443936417638285
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 06:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zuBd6BiD;
 spf=pass (domain: siemens.com, ip: 52.101.70.14, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI1xzjeJ0G+hERO0/DZzEllFl/t987LpgpdJXtmHn0Z0piZC5eBHy29QUxZAbc9zgAhvPhKeuSEdffmG0+Xq64Id11jfuI06DJl2UCoXlXGpxadPy4lWHtQovd9TZ75aQ5UDHHyVn5TBJn3wB0dIi3V55ELwHmAK2+fli82HO2FhQK9xUq3XiY6eZnKVXmWGSFrA81ggnk1kyHFYaotE6pyBh+FsN3UXGiFJUaAuWyC/+CyEafjn8BYDrlZJI4JD+ggdum75DqTiCNNMJoPskwFmMRjUPmouaXU1vsA1HbZ0WDPvQ9DGlklkXHHBxp+0qz3nZZyexrsCcjtBU6o0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpNq3KDjSmsPYUnWq3Br/YXH0W1LK48XBoPZNxJS7w8=;
 b=lhwRWRO+K0tqSVA+hFj3iC3MG+hElqi06+zEBeLJmYsHXXsZZU/TJLY/4LpiLyMozSCwQZ5NPma/OPeUkpIF3Xl2ADaO46wrBSePWv3nBP7/IxKlCwCKzkSsEJ6ZsFiWDsz6N0M5RjxJ1YkKpdW4wXdhDm8puq8X5HqZqDSyVnWLv0m58Vs1NAkMAuv+s4E7jsJ30dAqs1RgYBt5SlPUb2PHvuZhuX4YQZrpYQc3fciO/1BRDsJs+uPfZtP8fAwK1oh9WEzwY5hTLLxIxcRJ62O87ypCnJjby4etfQbp161Vn8q6Wit+d0SUzX4eAYtHo3Bf2EAkES3+DpZAs+69cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpNq3KDjSmsPYUnWq3Br/YXH0W1LK48XBoPZNxJS7w8=;
 b=zuBd6BiD/dctnYDM2TCI4BhGzSmzdIsGUcWnwGtzk31DJwqczXVLjS7Tkhl0hlBbz0hvZiCYUpBSquo3QcVVgnqFq3zTxhIR9GN8E4lkox1OFCddqLceKlrFpBjmtSRgW7sOQZcyzFuD5EGcWglowj+pZrxCka6V9JqBAyZhtW2RN8duM65QX9Y+byanJ/yNWLQk3vj7Sy1J16ICn63Ifndk0wMLreM2dGfmCODBvnvIc/pUJqvrOvI6yQvBFEXM/u4SBDhlySL8mdIHGRE1oRrnQpXKoc+7AEGV94rwYY1s5coOPB0qoIuWGl5eTuyZuSdEwO/Oh6E106dYQx9tVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AS8PR10MB6335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:50a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Mon, 23 Nov
 2026 14:25:32 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 14:25:30 +0000
Message-ID: <5eef2c39-1c1c-40a3-a9e5-f29d7c8af367@siemens.com>
Date: Mon, 23 Nov 2026 15:25:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH] wic: check EFI Boot Guard signers through the
 tool runner
To: cip-dev@lists.cip-project.org
References: <18EAB29CFA43C4BF.1570031@lists.cip-project.org>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <18EAB29CFA43C4BF.1570031@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Return-Path: clara.kowalsky@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AS8PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2490a077-5f69-4387-57e3-08df496da0c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|4022899009|1800799024|366016|376014|18002099003|22082099003|6133799003|261009223027099003|55112099003|56012099006|5023799004|11063799006|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022115727099003|261102123227099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: FsoQ1GZu/X2xILV20G4nyfq/lVaqnvWErdPsEGZGiPaa8C0vV9CJvFy0J2nqQuQdwgK8g1vgvbXLSZkoZfXPaDV65N6xErO+TYTDJpSwVg+RsmCKlhQXaALuz/0e5fY+Uthgz860XdNDRa/ffdHGshvgHIa8TRaP9i414elz2l8bFLFccjRtWeawLfKVwhWnOcuxqztKcUyft6yon2002/HOOvXUm/a1LaB+HGnbosEN/f3pm/+u2iFVEm4HKvBpLcEB2ipcVgWqCPoCSt8sY3WygEN8CRK6ILWSHIH8kCS5Z5lIMjpV+R/l7NBGoA0+VZyAZzI5FSv+QCnxGS6A8I8vapfBHrD6Kn8HVFzYSR31oEgbQkKUWDYrQioI15W8ZKzH7cR2J9aQnBzbT8piivTeoCYxrqegtH0skShWygeu4HDxwcwCMGL58JATTlK21kJNYQ9REJneBpHanT199XCtn9SshkmXUB5oLiF0K+r18uqPw1EUleC9CRt2W9imnyWrEoGKKWr+T9/yb/G/+NKTtLCWPoZLJL4gJ3JgClO2TlDaAFUFtBE9wkOJguAOTrlJVbtX5dpr+QvCizt1Ia5xY+uGi7jPWT2g1JizDWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(4022899009)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(55112099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022115727099003)(261102123227099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empUWTZFc3p3S3BEOWpwNjZpVFRKUzNheTFOWm81RFNlTDNLZ05PQWZRU0Qw?=
 =?utf-8?B?MEpKQjYyTWhnbk9BSjFEUGxGTHRqTHl5TVFwZG83SVROOEJUenpGRmpqUm1z?=
 =?utf-8?B?V2hMRlVJSThOY1lnWmdFZjVEc1NKWUFvTCtacDRubzBEaGRLZ3UxcDJHZnpD?=
 =?utf-8?B?Tkptc0dNeE92TGFhOGVTaUhyaTVzRzN5dVRDVnd1R204TjhPWEhzV2dmd1Jw?=
 =?utf-8?B?Y05OZ1pveTZrajBoa1FVNVNhYkVtMmJybzBCYUtaWHM0anZqRVBEN3ZtZm5p?=
 =?utf-8?B?SUhCQ0w4c2o3VXBiVjUyaVpBOXFJM3hkV2dlMUFDTUpjbjV4UGcxU3dPcER2?=
 =?utf-8?B?RHpNQm10RGhBMzRPc3gzSGc2Nzl0Z2NhVEg2Rm5uSFZVSThLdmdoUlAwSmtJ?=
 =?utf-8?B?a2p2MFFFNTBWbVFpM0QwOUd2cEdJMWY2aXBhcmN2d3owMjV3clBNWEFQWDN1?=
 =?utf-8?B?b2xwYmFzRWJna0F2TFVrVjFpd1VZVVd2UGlqVGhOZUVqY2pIbDhSd0xJUmZC?=
 =?utf-8?B?YThOeVVxNVdPdFpTWnZOT080cE1qS1l3aWpRcDlvS3gzZytmZElERUhvclF2?=
 =?utf-8?B?NWozNldDeHZTV3RtSzBocThLcmxWQ09aUGNrdDhnVUdSRlFVMnNLbnhlV3N1?=
 =?utf-8?B?TDdnQWdFaGdocjhUYmV6U29WOVB0VWE0NHZDSE9EYzBmcStWZy9ldm03NGxx?=
 =?utf-8?B?bGsxWGdVM0hmK3RaeXlTUG9vRU8yc0xzSzNkcHJBeEdzT1dEeFBSd05iRS9S?=
 =?utf-8?B?V0pwT2QrOVBzS0lXbUd3WE1NaXhaVnlqcHlUNS9rNHNNWVdoUDRjcmZyMVFx?=
 =?utf-8?B?RVpYYUNPMkdpZGFKY3hkYlpic0lxcDRyWnZrZWsyVi9kclN6NTlEamh6K2sy?=
 =?utf-8?B?clpCK1dUK1FRTm1KOG5hRlNYQ2xjRktQOUlOalVQd2E4enZRN1JLZ0FVRjE0?=
 =?utf-8?B?UUd1OThuQytSdTNVUHFIdTZmRG5kbUc1aDNNcHFvOG5VTG9PUTNMd1hHNDJI?=
 =?utf-8?B?cjgvS1pHVkR5aU02YVphZkp3VmREaENDQk5FaitDVTFBVmhWc2xWNE1RSlEz?=
 =?utf-8?B?Vk1hTnlEMnN2ZEZHWktpa2RPam5ZUWNTZy9COC9yYmFRTWl0eU5GUTRTZGxv?=
 =?utf-8?B?bVJ2VVFYNC9XTXcwd1dyT2J5cm1ERFZMSStUMXdNZ0dkcG9WLzJYTGU1eERZ?=
 =?utf-8?B?b1l0N3ZUK2E5S3krRWhPRTYxN0IycmlTU3FqZGkrREs1eXVhVnI3RlArOWha?=
 =?utf-8?B?dFEzTllqSW9DZ0tEZ09Cakx1RFJXL0pxYTVFZFBIM3lFTkVWRTB6M1FLS3Zr?=
 =?utf-8?B?THFWSjk3VmlPckhGNHQzMUE4OWp1VmlHTUtHL1g1Y0EvWFE3WlAvQkFvZzBY?=
 =?utf-8?B?WW5EU1VzVkVNVkxacUdNckV3V0xqV1BpdTVjSkM0VXMzL0tnU3Zla0lCYnRm?=
 =?utf-8?B?ak90WW9DdFZmc3dnbzlkNkMrbUtxTm5oREtBQVNQRzhNeTlZV1RpNVNLVHhI?=
 =?utf-8?B?Q1YrY3psU3dZRUJMNElRRTdzc1ZZQ1NvbzBwbWZ3dlozckN1RE1xSzhxUlVa?=
 =?utf-8?B?WVBEeExiZXB0T3YwRWZodkNMQS9vcEZRUjlGSXVEa3BMOTNDSlpyNlczdGdi?=
 =?utf-8?B?L1dtT3kvR0R1bkE4eUFQaTYrUE13SFV1NlJwTFFQQXRKTUVmQ09TSjNzTE45?=
 =?utf-8?B?M0wvSkFEdXRMRmtldDJOV0EzMTNiZUlEYmlqdkpMU0gzQWplVVczdXdWZlFw?=
 =?utf-8?B?ZzN6R21NejZXOXhnMTFxUE1Ed21jQWgvOUNjRE9Ydk1IeUJVTHhjbHFTdTBo?=
 =?utf-8?B?R1NEWDgwZGpqSzMyR2ROQ0V3aW5IUnltVXd2RDIxVjEyQ096dU9vcVFtL1Bq?=
 =?utf-8?B?R0NIakp1RE9FVEJaQjVVRUVQNW9vY1JzdXlIODlXWXVOZU5UM01tQy82Y0hT?=
 =?utf-8?B?S0JFV3U0VmxxRGp3R1ROUDlCbXRuNXRCeE1rRWZVVVJBbEdsWktiVnAzWkVm?=
 =?utf-8?B?N2Uzai82cDBtdERWK2xSbmdjZVN6REN2VnVoZkkrNDlmT1NVN3JQUkgzcVE5?=
 =?utf-8?B?UG9NQnA5cVNQMEdIdGJnbDhOTW1VRUtub29uUk5WOVdCOUVDQzV1STNtV3Uw?=
 =?utf-8?B?ZVcwV2Z2MlFCV2h1VzdCZHNPUEpMUmVjQ2RDemhsckpSV2FQVnZGVW54d2Jr?=
 =?utf-8?B?UzJ0NHBQNUJWUUJQbU51eVZOWU1qSnprVis1ZWdjK1FGdzJWRW14UzZ2bHVQ?=
 =?utf-8?B?OTM1VGd6djN2T2pyd0RVRXZpbkp3OW5jUFVaS0lXWU5LbGwrNGk3NEpaRURN?=
 =?utf-8?B?MUFLanZxUXdGdzhPenFuVW5kVDA5WDdTT3RMcW1KNHNEc28vWW9NbUFzbmV0?=
 =?utf-8?Q?30Dz2dhG/2/pq/3c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490a077-5f69-4387-57e3-08df496da0c9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:25:30.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwZZ5P5zzhqxRO+f9+hKYl2hwqM2EghFve4EhkDXPIB/P7AalxP//rjd1koC4IZquuAFPD+ESH8TKmtAAO4GMu8VMHPbtdt6qA6M/tzTXfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6335
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 14:25:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25048

I forgot the prefix. This is for [isar-cip-core].

On 11/23/26 15:22, Clara Kowalsky via cip-dev wrote:
> This change has to happen in lockstep with the BitBake update in isar,
> where WIC's Python driver is moved to the build host.
> 
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
>   scripts/lib/wic/plugins/source/efibootguard-boot.py | 10 +++++-----
>   scripts/lib/wic/plugins/source/efibootguard-efi.py  | 10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index ca97d7d..d8b9212 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -37,7 +37,7 @@ import logging
>   msger = logging.getLogger('wic')
>   
>   from wic.pluginbase import SourcePlugin
> -from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
> +from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_EXTRA_SPACE
>   
>   class EfibootguardBootPlugin(SourcePlugin):
>       """
> @@ -258,7 +258,10 @@ class EfibootguardBootPlugin(SourcePlugin):
>       @classmethod
>       def _sign_file(cls, signee, source_params):
>           sign_script = source_params.get("signwith")
> -        if sign_script and os.path.exists(sign_script):
> +        if sign_script and not tool_path_exists(sign_script):
> +            msger.error("Could not find script %s", sign_script)
> +            exit(1)
> +        if sign_script:
>               msger.info("sign with script %s", sign_script)
>               orig_signee = signee + ".unsigned"
>               os.rename(signee, orig_signee)
> @@ -266,6 +269,3 @@ class EfibootguardBootPlugin(SourcePlugin):
>                   .format(sign_script=sign_script, orig_signee=orig_signee,
>                           signee=signee)
>               exec_cmd(sign_cmd)
> -        elif sign_script and not os.path.exists(sign_script):
> -            msger.error("Could not find script %s", sign_script)
> -            exit(1)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index f84c61a..504164e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -38,7 +38,7 @@ msger = logging.getLogger('wic')
>   
>   from wic import WicError
>   from wic.pluginbase import SourcePlugin
> -from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
> +from wic.misc import exec_cmd, get_bitbake_var, tool_path_exists, BOOTDD_EXTRA_SPACE
>   
>   class EfibootguardEFIPlugin(SourcePlugin):
>       """
> @@ -168,7 +168,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>       @classmethod
>       def _sign_file(cls, name, signee, cr_workdir, source_params):
>           sign_script = source_params.get("signwith")
> -        if sign_script and os.path.exists(sign_script):
> +        if sign_script and not tool_path_exists(sign_script):
> +            msger.error("Could not find script %s", sign_script)
> +            exit(1)
> +        if sign_script:
>               work_name = name.replace(".efi", ".signed.efi")
>               sign_cmd = "{sign_script} {signee} \
>               {cr_workdir}/{work_name}".format(sign_script=sign_script,
> @@ -176,9 +179,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                cr_workdir=cr_workdir,
>                                                work_name=work_name)
>               exec_cmd(sign_cmd)
> -        elif sign_script and not os.path.exists(sign_script):
> -            msger.error("Could not find script %s", sign_script)
> -            exit(1)
>           else:
>               # if we do nothing copy the signee to the work directory
>               work_name = name
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#25047): https://lists.cip-project.org/g/cip-dev/message/25047
> Mute This Topic: https://lists.cip-project.org/mt/122412147/8340681
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [clara.kowalsky@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

