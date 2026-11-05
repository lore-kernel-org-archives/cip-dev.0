Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28952.1793861965446376238
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:59:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x4C7gMWz;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsA+C+MI6H71DBsx/RLk1jBNH0V6CJnu2Bn5LyjaZPBI0Q0YPUrJCgt4EkogenM+nQYlpABsGa4Xw8ZKeSscSsvTRzzP1oqQV5qJUKpJL/DBVtOIh9ltjgdm+OEOBQdK8br0fV1gM5+2dTJudnyaeJcQvB2LO8+LT0beqAkpvogN0iYTf0fxAZAFS9w64J5YvbfccgiNsILR9eqLUl0HidQR0IpAed6s8kYJI8ssgv1xdU7/AAXC9+pREzHlOj4FORvzuMc7TSIrNy+l7NOA7AkwCfR7whCztAZDlGJCZeibbXQ9M0x/bBQ8akLeHzwwMScOAXzVzR39ijQqcBtDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP9WRFW2gCaXWVTzCtP0uIz/tnJXniajkV+VIq48nN0=;
 b=RY4VGAO5SMgggET3CU3EEzeqRYLqNf2vhJh3CYKoRq5xPPyAhgHeHd7C0LoBO8fVmSIsQDhi3GEIzoxefd54G3At49/CXgO/eu7difHwHIQUPgG64R5lBHLkJxcd2M37iO75tb/xtyW7/7J+/J/A2Kg0C6anV2UTiSCvzKJniCgjSgVcyTUas/OSx/mR/jyhSxUMwcwz3uqzraIBRke6sSJrcIR+JxiSmQTrr5yxk1dbtUih7lRvUKKQ6teAOtS+rCZsPVvPqpwTUDzCtI3BzqjFhAcWOdUQu30h7k+Qr/5kYoPQeaPmVpBPu3KUpPbdaDCrdyEArfU0TnkrwAlOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP9WRFW2gCaXWVTzCtP0uIz/tnJXniajkV+VIq48nN0=;
 b=x4C7gMWzIAQqxQniTGFjuMSZCM39onLzK/LbO9ctt7ems4KJxfqDiVjzMqmvTHMDxe5DzOLSExH4xhoZ2PYucB/bGdLvyePOUkBwupStnDEfgrCdJyxugL8ScXCllkTu41qC6sM6ft2X6ghJntY2a8WZYkk7wkZM3ky1E463dacDPTMHZ9pJiKTo7B7tKROiBIJGGLF6e9RbZTnfMtT3Ppwj3e66hZL8BUtfc1G8MSD2cQvuNxt8TmUIg5YunZLkMWNvN3N1HsIM8GWJmaAM8J6N7+0/qLEoQMKo3r6IsEHtyaO4iODND2s4Gf5uwXo419KOhhANqm0IcRwyhNuCTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU0PR10MB5145.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:329::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 06:59:20 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 06:59:20 +0000
Message-ID: <03a9b0ce-4087-43b5-aeae-a62e6038ca2f@siemens.com>
Date: Thu, 5 Nov 2026 07:59:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 02/12] efibootguard-boot: emit
 systemd verity cmdline for dracut
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-3-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019102541.672620-3-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7b2616-99c2-4968-92a2-08df3b0a5126
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021135927099003|261022105027099003|261009223027099003|261026140227099003|261022115727099003|261102123227099003|261022075727099003|261026121527099003|261028144727099003|261021121427099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: J/mgiM2YbzXb65+ZGUmyBm3Gd9dtLOeDcVsOy51TLHD4AVJrtFt2Rmjvzxh+YL8Lzsg3LYRYOQfPXp3dkdKvkYnvLAHnFElCUF0fL7147MtN7RELXzrwO49UHZK5kgP8gQncCHqUSYoocg4aSlbKx6q65GrwAZouTr8mtEUQv6eJyxBCtW1DILC3jlGP146VXclNx45KtvhhshhEKY6VI/431yLAGRfVvQl1S2wWpApnC1jMGFbruX+kYMTr1bJ90hI25lHPtitKIcvxi52qtD9w2FPKuatqRefo3ZMKxMEtO0sPTS7PEgjVevVhI8K4wciKRdfEaR8+csy2odz+WJzNm/EFykfmNeZvr1S98gGT2NdMlEWYpmuiXvX3qMOK/of7xbc0aoqom4u5n1SL8QN5tDjbHt7n+LJMcVJD0KvrPHLxdoeEW3tqebCxCR/sEIxenHalRiUI9euXWjWr780rZtFIbRPfg5kOqBHwkShsDCUj7+DB9xjbxNHU5b4ZSzlnD6p12/SksMHr669sOFTuMBT16bsxDiUvDoZL1LUoaJMjfABRC8pgg6CQpI0nO50CURXYWQPlSNhAoX0b+S4ds/4rFx3dh3QrfZZaQEmTohDVlIkMv3KhnIipCoDc5UBsxnyTliyVAj85TOspHUJS0SSOpgnXaBAJ2eQafsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021135927099003)(261022105027099003)(261009223027099003)(261026140227099003)(261022115727099003)(261102123227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lINVhZUGRUY2dHYWNTVVRkVzFaVzMycVdCZDI5MlY0U3NFdVlqR0lCVDly?=
 =?utf-8?B?NEd1QXh3bW83VlB0YUZReDdpeE9YOTJqZUVXVHEyS3JHM1JpenAySndDSy8z?=
 =?utf-8?B?ODRxUUd4Rmd3elRZTnA0eVNMNzRvdERJWEd0NnU5YThDTGMxYVpicTBBenFj?=
 =?utf-8?B?eEMzVWswRmlvb3Eyb2tndFZuOFI3cEdydHhrVHBGNythOEtpTkFWaTJhUDJD?=
 =?utf-8?B?Z3ZKTkhueCtKWTl0NWFrcXcwUVBDdTFTOEhqOTMrcWhZVENWR3M3SnZycTdu?=
 =?utf-8?B?WFpRWGY2UDVMcTJmam85SmY2cnMvQ1pXeW9IWW9senlybGpFcEJtb2ZHQysx?=
 =?utf-8?B?TlYvWjRVcGNmMWRVdmFBMVUwb2Y0aHFRZmFqRFBhQjlsdnNzNjdQc1NlSDB4?=
 =?utf-8?B?dHpESGVENHJLRlFtblMyVDNWRzErS3Z4dEM5ZzhjVWVjY3RnZ0ZkSDZ6ZUhZ?=
 =?utf-8?B?VUhVQUo0UE5keDgwY2Z3cWdVUlcrVmZhMGJlZjJsczdGd2k5YWRoY1ZNdUlk?=
 =?utf-8?B?S3pTSjdRMFdBQUtvZ0RrdiszQUpNOFNkVFdDRUVZYUExV0Vza3Aza0phSGxq?=
 =?utf-8?B?bEVPSmxTZ2RVLzZmMWpMZUk0T1JiV0tBYmRiRExiSzZ5cnhuaGlPTVRWNW1N?=
 =?utf-8?B?SkJCRnExOXNLZU1vZEhwVzYrUWtrc2FmekQwTzU0OWs2UmdpRFlVU3hyY0Y3?=
 =?utf-8?B?MFdEWnhUTFcrL2RSbjJjVVlxTnVGME0vdlp3RFJDd2tkblBjZzlYc2dMZUhn?=
 =?utf-8?B?cW44ZlNUaTY2R0lMOGU3YTBxRk1EVnRrZ08zbmZMeTBLc2RZTXB1bXFkZ1kv?=
 =?utf-8?B?K0JOUEs1ekp1TnRqQjQ2bWVNSy9kcCtiL000UjRoNGEvZGN1dzUyTjlhL2Jp?=
 =?utf-8?B?eUxpbU82SEVyU1QwQ1RSbDNpbE1sRTBvSXlsRlYyTWJPRkN2QzVGUUJvOTF5?=
 =?utf-8?B?QXNPeW5HWXVsM0hKeEhBeFJDVVhGU3FkOFVXYmUwRnFBU25rYUxleGlHZ25U?=
 =?utf-8?B?UFpGYkI4Kzh0SW9xU3VyMVg0K1RPWFZNMGFaUjgzaEdxWGdPalJGN2QyZnpz?=
 =?utf-8?B?Q0gyd2trMFdxVmVyaFNFRHR3MUFKMG45YzZjTjEybmFQTUh5OUtPUHhoN0lS?=
 =?utf-8?B?elUrellQdUsyb1VraEh0VjBoaFltMWpkcDJRQ2hZVFE0dm42blVpTzN4UzZJ?=
 =?utf-8?B?eWMrc1NpK0JkbSt0YUY2THlZL252TWl0ZFhRWlpuYnREZ0VhZDU5OGtRZEZx?=
 =?utf-8?B?V3hiblBTY3poRnYzM1VlR1lUVnB3RjhobVZIbWdhZjlKb0JUQ0MxOU1DVXR3?=
 =?utf-8?B?TWR0QlYzK016RXl5dHcyY2czcThnNHJCTnFOZG1vVkxORm1WY05NSVpzQ1h1?=
 =?utf-8?B?U1NpS2c3S056bjg3Y3JPUWkrcTBPczhCYzhUMDEyczNiMDN4UHBNTjNtWmJE?=
 =?utf-8?B?M0VWcXdoRnZ2NnVFYlROb2RvN2RMd1cxcC9NazhEU2VWZXRIdEc0WkhVMSs0?=
 =?utf-8?B?bjZRV1dwSTRYTDIrTGdYOHFPSC81OVpIYkJ6YjFsM0tXQTBQNDF4VEtuUjJ4?=
 =?utf-8?B?U2lMdlUvZThWR0laWi9sWkR1WXFqekhlY2pmd1U0VlFrcVRVWmJ3Sm9UOHVV?=
 =?utf-8?B?Mnhkb0ZFc1FYRzBBZ2dsYlZGYTVRMEhWd2lKb04vSjFRVlF6OG04OGhhMkVo?=
 =?utf-8?B?dm4xZ1VhVGlXYVNTSmwzM3E4dklSQ2NqMVVpSTQ5cGluZWpqRnVxWWVaaG43?=
 =?utf-8?B?cEd3R1R0d3V0cnpuLzFkaFZ1UDBWWVVmTUVyNDB5bXQxZWQyWmJCdmZVektI?=
 =?utf-8?B?bFQ1YzJhZkErcm01WG9Qb1R5dldHTCs2OEV4aG9XYis1eXZxdG9QRFhQMFlU?=
 =?utf-8?B?VmdVWTZFTFM5R0lSLzdsQzBpdk1uc0s3SWtWMkx1Y0ljK1JWcFpVWmNZYnh5?=
 =?utf-8?B?YmthMnh4dHptem1HeVg0MGFmVU03RWlZVmtha3RGZ0hBbk9KUysyQldrTlFi?=
 =?utf-8?B?c2tncXZzR1NGejNVNFI2WGlQYWtoRmJqQURvaEdGWiszam01VHlYM1kyMGZS?=
 =?utf-8?B?YWw1RXJyQ05ZOG4xUHFsYkcyeWZrZnpiUFU0eHJwdnJqSVhEWC84aXdSVG51?=
 =?utf-8?B?SmE0SzFKejRYdVI0VytpUWJFMTBXQ2ZWenFTNUk1Y2oyR3pyUGlmS0NiRlA3?=
 =?utf-8?B?YmNnWm81c1RZcUhSRkN0MzU5dWpwREZpcHMxem9razQxR2JYOXNXNEQ2WTc4?=
 =?utf-8?B?REtWVXlKRjh4cVB2U3A2SXZhMk1peWQ3bVVQdWVwWW02ZVJub3l5UkZtMThq?=
 =?utf-8?B?WmtVaWovQW5BTUJQN2RQdXhpUGNqNWxRT1dTRG5HMEtTK1NvVTg5UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7b2616-99c2-4968-92a2-08df3b0a5126
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:59:20.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paksNN9iEmLl3PEcVcpo5EQzJbePlud/bBroKSpy4mgdp8Ji/xSePqLbw3bH4BU4/R9z3DOqerQcpZzXk+kUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24642

On 19.10.26 12:25, Quirin Gylstorff wrote:
> INITRD_CMDLINE_STYLE selects the kernel command line dialect for
> verity. The default "initramfs-tools" keeps cip.verity_root_options=.
> "dracut" emits systemd's native roothash= and
> systemd.verity_root_options=, with the data and hash device resolved at
> runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
> INITRD_EMERGENCY_CMDLINE (default "rd.shell=0 rd.emergency=reboot"), so
> that a failed boot reboots and EFI Boot Guard can roll back.
> 
> Also drop the LABEL=var entry from the generated fstab. /var is mounted
> by the initramfs (overlay and crypt hooks); the additional fstab entry
> makes systemd manage a second var.mount for the same filesystem.
> 
> efibootguard-boot: use verity root for dracut without secure boot
> 
> The dracut initramfs has no abrootfs support; dm-verity roothash
> matching is its only A/B root selection. Without secure boot the
> default wic layout (ebg-sysparts.inc) passes abrootfs_root=y, so the
> unified kernel image lacked roothash= and the image did not boot.
> 
> Promote abrootfs_root=y to the verity root cmdline when
> INITRD_CMDLINE_STYLE is systemd. The wic .inc files cannot be
> parametrized instead, as wic does not expand BitBake variables there.
> 
> efibootguard-boot: explain a missing verity env file
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes-recipe/read-only-rootfs.bbclass       |  6 +-
>  .../wic/plugins/source/efibootguard-boot.py   | 67 +++++++++++++++++--
>  2 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
> index 70152de2..179dcb98 100644
> --- a/classes-recipe/read-only-rootfs.bbclass
> +++ b/classes-recipe/read-only-rootfs.bbclass
> @@ -17,6 +17,11 @@ IMAGE_INITRD = "${INITRAMFS_RECIPE}"
>  
>  do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  
> +INITRD_CMDLINE_STYLE ?= "cip-initramfs"
> +
> +INITRD_EMERGENCY_CMDLINE ?= "rd.shell=0 rd.emergency=reboot"
> +WICVARS += "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE"
> +
>  WIC_HOME_PARTITION = ""
>  WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
>  
> @@ -76,7 +81,6 @@ image_configure_fstab() {
>      run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>  # Begin /etc/fstab
>  /dev/root	/		auto		defaults,ro			0	0
> -LABEL=var	/var		auto		defaults			0	0
>  proc		/proc		proc		nosuid,noexec,nodev		0	0
>  sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>  devpts		/dev/pts	devpts		gid=5,mode=620			0	0
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index ca97d7d7..5a5ec1c0 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -36,6 +36,7 @@ import logging
>  
>  msger = logging.getLogger('wic')
>  
> +from wic import WicError
>  from wic.pluginbase import SourcePlugin
>  from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
>  
> @@ -89,11 +90,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>          boot_files = source_params.get("files", "").split(' ')
>          unified_kernel = source_params.get("unified-kernel") or 'y'
>          cmdline = bootloader.append or ''
> +        cmdline_style = get_bitbake_var("INITRD_CMDLINE_STYLE")
> +        root_mode = cls._resolve_root_mode(source_params, cmdline_style)
> +        if root_mode == "verity" and source_params.get("verity_root") != 'y':
> +            msger.info("efibootguard-boot: abrootfs_root replaced by "
> +                       "verity_root, the dracut initramfs has no abrootfs "
> +                       "support")
>          # the verity cmdline format is identical to systemd.verity_root_options
> -        if source_params.get("verity_root") == 'y':
> -            cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
> -                % cls._get_verity_opts()
> -        if source_params.get("abrootfs_root") == 'y':
> +        if root_mode == "verity":
> +            if cmdline_style == "systemd":
> +                cmdline += cls._get_verity_cmdline_dracut()
> +            else:
> +                cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
> +                    % cls._get_verity_opts()
> +        elif root_mode == "abrootfs":
>              cmdline += " cip.abrootfs_root_options=%s" \
>                  % cls._get_abrootfs_opts()
>          if unified_kernel == 'y':
> @@ -152,6 +162,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>          cls._create_img(part_rootfs_dir, part, cr_workdir,
>                          native_sysroot, oe_builddir)
>  
> +    @classmethod
> +    def _resolve_root_mode(cls, source_params, cmdline_style):
> +        """
> +        Return the effective root selection: 'verity', 'abrootfs' or None.
> +        The dracut initramfs (systemd cmdline style) has no abrootfs
> +        support, so abrootfs_root=y is promoted to verity there.
> +        """
> +        if source_params.get("verity_root") == 'y':
> +            return "verity"
> +        if source_params.get("abrootfs_root") == 'y':
> +            if cmdline_style == "systemd":
> +                return "verity"

We should better handle this compat case at recipe level, when invoking wic.

Jan

> +            return "abrootfs"
> +        return None
> +
>      @classmethod
>      def _generate_kernel_opts_from_file(cls, filename, keys):
>          env_file = None
> @@ -176,8 +201,13 @@ class EfibootguardBootPlugin(SourcePlugin):
>          verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
>                            "hash-offset", "salt", "uuid", "root-hash"]
>          image_basename = get_bitbake_var("IMAGE_BASENAME")
> -        opts = cls._generate_kernel_opts_from_file(f'{image_basename}*.verity.env',
> -                                               verity_sd_keys)
> +        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
> +        pattern = f'{image_basename}*.verity.env'
> +        if not fnmatch.filter(os.listdir(deploy_dir), pattern):
> +            raise WicError("efibootguard-boot: verity root requested but "
> +                           "'%s' not found in %s. Set RO_ROOTFS_VERITY = "
> +                           "\"1\"." % (pattern, deploy_dir))
> +        opts = cls._generate_kernel_opts_from_file(pattern, verity_sd_keys)
>          cmdline=[]
>          # fixup for root-hash to avoid an error in the initramfs search for the
>          # root option in the kernel cmdline
> @@ -188,6 +218,31 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  cmdline.append(f'{k}={v}')
>          return ",".join(cmdline)
>  
> +    @classmethod
> +    def _get_verity_cmdline_dracut(cls):
> +        """Emit systemd's native verity arguments."""
> +        opts = cls._get_verity_opts().split(',')
> +        root_hash = None
> +        rest = []
> +        for opt in opts:
> +            if opt.startswith('hash='):
> +                root_hash = opt[len('hash='):]
> +            else:
> +                rest.append(opt)
> +        if not root_hash:
> +            raise WicError("efibootguard-boot: no root hash found in the "
> +                           "verity environment file")
> +        rootfstype = get_bitbake_var("RO_ROOTFS_TYPE") or "squashfs"
> +        emergency = get_bitbake_var("INITRD_EMERGENCY_CMDLINE")
> +        if emergency is None:
> +            emergency = "rd.shell=0 rd.emergency=reboot"
> +        return (" roothash=%s"
> +                " systemd.verity_root_options=panic-on-corruption,%s"
> +                " systemd.verity_root_data=/dev/cip/verity-data"
> +                " systemd.verity_root_hash=/dev/cip/verity-data"
> +                " root=/dev/mapper/root rootfstype=%s ro %s"
> +                % (root_hash, ",".join(rest), rootfstype, emergency))
> +
>      @classmethod
>      def _get_abrootfs_opts(cls):
>          abrootfs_sd_keys = ["target-image-uuid"]

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
