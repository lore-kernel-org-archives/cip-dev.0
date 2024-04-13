Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C41C04FF8
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 09:51:17 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.89])
 by mx.groups.io with SMTP id smtpd.web11.7667.1713001875243003535
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Apr 2024 02:51:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qcOiQO/8;
 spf=pass (domain: siemens.com, ip: 40.107.13.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3xQUBohDi+LRzAZgnbFKFsaJLVs5ANZsuMo5D60L6hYYSVXi/YLPdU5s+wi7iJwAcY53NvKMo5WrE/MPjv2cuYy5cR2fCnODFoFBLvTqC06LTZUumDTxo9JNJPtAHx4KvBISskDlBHhbJfjRchyHpKHQhWC/CNy3gbFUi4S37miycyUrZQXE+UAG+zZ065S6M1PoePvp/pQ2leqeTj6jQB1Ws0PDge3g00QdSaMqOKjBMRa3LGedtAajVsoukWN246Xkf2L/TR1W21Pgwz7WS6PZTP67wCWbzm+66IIg5AuJbnLBO1xOegTG3+OdJ72f/miWXCt4UpdHxLqkPSzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kn78RukFp15Qh4oJbUGhqYvcUY4n7TAs4pb2RzMJPo=;
 b=AuEWlaW0+/hJiP8efKAQq3FgjBZi5IphSRUf3JdjkN8sqoxgVofrg3lGVNmhM6Ggu6fpEcgBUBHlthuajnUBu2NOIXRYeiL19tAkLYBT2207e4DK2K1ETL3k1VvFb4BZn9socYqVvOQIINBG8cTnyPq1Ny7MScM9SmTWahPlCjBeit9MN0SyJmgsW0RktRxvOqgz4BP//x0YY68Ue2V5vzBvyjabOuHletf1OmdZlnL9Ed5T5tcQfr0sf+1SSmJTRYwmCTy9PHrMmEOUcbwm5xIv/VT6+izS1pZ0Mvx2Ek6gLMFyMstOHt2JVjFWRInTRaWaSdW+ZqTg1swdJxcAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kn78RukFp15Qh4oJbUGhqYvcUY4n7TAs4pb2RzMJPo=;
 b=qcOiQO/8+49KAys53MH4pQdK1UZTnrFkVrrUMgL8pm6FtxrsezODeNLZMQmikimR4cuptGvAoPmJgxyp/KdUENkPIVbFWBNCFRRjgxnvYV/0R/rrxeNPLJ7RX0Mm0yQSGebTZCzoEbB0EPMl8XsmESI2OE5H0t1TME7MDJsX0umWp47pl2X0ts55kjiWI5zLj4LekyN7YZwCxEUq/NF2/CrYhDNF0yl7fJTSj+y0TWsxk66aDiBOddtXfodA0GmzQLll33Ll1/8eIXrVRr7Oi3SUQOvBmrODZOylFmc/XDRonn45dMHnfvaeN0cJJiSWqTtzRXijLP02LMm26WnX6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 09:51:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Sat, 13 Apr 2024
 09:51:11 +0000
Message-ID: <ebe541bc-8325-4899-97bb-3993c1917a47@siemens.com>
Date: Sat, 13 Apr 2024 11:51:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their
 deploydir subdir paths
To: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB69084FE3C4AD6F2A100E9E28E6042@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <DB3PR10MB69084FE3C4AD6F2A100E9E28E6042@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3971:EE_
X-MS-Office365-Filtering-Correlation-Id: 17331093-6845-4c09-2cba-08dc5b9f4030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lktQwX827NlD9iZAiXvBvy91n0YENKtl/ZfTv2NE4a90rIgFFjtcCtESdKzH2piz577X+FA6OQgweLrm3P/+fw5wH9tkqZIr/WX+N/kcNIu+wDc3xJih0sZKD+GRCWy2rGFE9BiDwja/ZFi1pcXfoafJY++LWoV0OVh0vB5ACI7oaLmt/9jmHWn1OcoCxGr0KLCUQNCucv+MUc0akoRAgpBMvGi7s36VAf+q9DJeS2l/PLrs5qKyL585ZPtpX8cbiZ/Dm8yMfdAvhcXrnuaoQDz089iOgHo/DP6etu/vz+E6gFNP41judCUeBu/COBqTJCIqr0XtQfui+HnnF8jq5BL2zCRiEJ/Y7vfAfKVDJ0cBq0go6yraHj1bwza/uDQHPqA5a0OjVc0zG1T1SNo86/R4Djr3UV/PmxmuGDWaPIO6owDffG16JZX8H+13U/+Yz0ZCWClEty9y47fBKm60pMof3339jW1EQODmT0TvBoyAvgoHwTabKhyw1dVrevEnWQ7UOoQiK02h5T3H+tfyeAe8IzytZmCrd8F9yNEX1ht/1ecc32+tLkHHgHJoGlQJf1weKNOcNNk3Lg3KXighb6QQmq0Qnu4AFSYMUQWQ3iadb25jS7g/nHhFK7/2auGV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXFCNkZKTTQzZnlpV3NDYmROWElIc1RDMVFtUGU4RllYdlZ6QWNBSk5QZ1BU?=
 =?utf-8?B?bmhWUnNiUWJlelVOdGsxUDNpVXFtRTltTS91NmtydGExS042dkg2ZTVibDRG?=
 =?utf-8?B?MGJlRjhiZGRLbk5ka3gydS9vR1VGTEZ2NE9ZVVR5NWdLTkg0RWhGenRWdlIr?=
 =?utf-8?B?VWJWTDZMS2RPS0ZhQ3FPU20vV3JTbGFjbFkwVE5hTC9OejZuSFVoUDlMT0NO?=
 =?utf-8?B?VEpGQ0swcUhISzA5VXFWVlM3aW5RQW0zVkxrR2plUWxjS1k5a2pGY0xRTU9P?=
 =?utf-8?B?c1hEQzF1QWpVT240Q0tKSDNKcHRIWHordElycDdZTWk2RFFDNW5MN2VPNkF1?=
 =?utf-8?B?UTl0STVWdDNDRHZvMmxpZE5VbXFDaVAyV0dEWkRuU1VRb05XU2ZBZEwrMkNn?=
 =?utf-8?B?OHpvbGZML1g1VDFNajlxYnJDZ1FwV2p5WFNKV2RYc1RpQ0hmcFl1bzNJMGFX?=
 =?utf-8?B?cVJWZ2tWblBqdFBNcGF5M1RCaDNhU3k4aktMOWllRGdZTTUrQ1R2NzlITFMy?=
 =?utf-8?B?bStkcmo2L3FaTVV3ZW4rd0pkWU1JQjdQdEd0TWNWVzJxNWlwc1RpRVJsT2pF?=
 =?utf-8?B?c1hGb2pEMTZWZ2YyUnpBbkg1OCs5QlpFcldVNThBcEgraHUxVFpaU2RMRmEr?=
 =?utf-8?B?Y3ZLcGRybldaalVlSEYzUVZMOStpRng5T1c1ek8vMFFMVUszSHU4TjB2SVMz?=
 =?utf-8?B?bVNYK1k0WHE4VG9hWWxVdnRjZTVsbE9MbzZzRE1KVEJ4Q1lMU3VnTUhaaWhz?=
 =?utf-8?B?QXFWUG9NMVRNQWRudXQ0ak02eTMyMm1GYVZYYnhIc1R4Z3BFRTlVb1htWDBT?=
 =?utf-8?B?enhPdjFrZHpOM2k3SkFYSEMzeGYzaUJlZzlHNFlHbWgzZEZycWhGSHBsazZj?=
 =?utf-8?B?SElsWGxUYmZkTVA4b24rZ2tMNXJOVmVibUdseTM5UXc1N29iRlVwUis2S3RT?=
 =?utf-8?B?cXAyZmVPQUVINWIzVkRmWDVQRVU3aFQwOHltQ1g0RFJjWWxuRVorY1p4SHJi?=
 =?utf-8?B?NCsrZkVLRkMwTHZhQUo4eVBoa2RMQlFZcFZHMktodStQQlVWOGMyZHNJdlFW?=
 =?utf-8?B?N0J4ZmdHa25pVlBjaDJiVEJCZE5zOTloODlCOWFkV00xRjRka2hud2MwUDdX?=
 =?utf-8?B?VGlnenhmd0NDQnJrZmFpbUNoc3l2SGNMRnVaeTIvdXZKdWpzSk5zZVBWbW9a?=
 =?utf-8?B?RXZmeU43U2RxT2dWS1lLUnVtb28xODJwRk1PM3I2VmRpNWFMNlZFZEVOc2VV?=
 =?utf-8?B?TGlyY2NrZVR3OVBCSHp2TFpoaXEzRjBxeDVmQ0xHUkpKS0FSU1RUSVlWNzY2?=
 =?utf-8?B?UWNDUllrOGMxcUV5SEUxRWhVQ0FPSmFpSUN1M0lFZTJnVnQwYXpJVXVLbVBL?=
 =?utf-8?B?MHVoTEtXeExhSExNMTdqaVB0QzdLczJkeVNxaVFzYzdERkNJSFVSdVNCZ1BP?=
 =?utf-8?B?WHAxSTJwa09CaTlDbjlKT3JaZDdKVi9PNEU2TzNrNG8weVh2MUdqK2ZRZmt0?=
 =?utf-8?B?SzZPT0M0bTA5WkIrZWxiR0lZU2Q3WTR5MEFDUkpQbFpiYzBaMmtQUVlpbVNO?=
 =?utf-8?B?L1JWMU9oYWZNR0QxRnFzc3FVYit4SEdPYThqZnZ0K0R5OWoxVjA2WHpWYXY0?=
 =?utf-8?B?QU9QUmVqelBqSEtiN0tpOFV5NkJEV3BkVkFNa3NnOEVXZkNsT3QxcFJZSkFE?=
 =?utf-8?B?Sk1Pck9STy92SllmaXRHK1phbGF3d2UvMjhJQWdqVGtMYmFnb2Q4TWc0SGZ3?=
 =?utf-8?B?N09xOVFFbDdpOG1lY284bzhRSUlpeU1zS0FhWG04bFU0YkpZb3RSd0lqMWtW?=
 =?utf-8?B?ZEhhd2pIVHl2cnBBUVpOYjgreUhzSjVlc3A0cW41TGo0MlhDSHZDSGE4L0pU?=
 =?utf-8?B?bDY4Mm9uOGdLdVpzOEhUczJ2WnhZc2dVM1NpdHpyR0ViU1dLZHNFY2tFcGxT?=
 =?utf-8?B?ZlpVdjFTRS8wTytaQWwzMWc2V3FFRENBelRqR0svSi84Szg3UWdKQjQ1bTdK?=
 =?utf-8?B?WEFzeWNiYytwY08waElmWGJFVFR0c1ZQTkhVUFViY0dTQXptb1dpNVV2eU1k?=
 =?utf-8?B?SVJkekdteGJLZkxSVGN4WTNqMHJhejRsZGlhVmFnVjRVdXZlclExcHN4c0V2?=
 =?utf-8?Q?CsbIPnndo1pvqKRl9TehUM1sl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17331093-6845-4c09-2cba-08dc5b9f4030
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 09:51:11.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llzUAuGzhzaxnRyBKJs0z5RV4XpBWgrWAJPyD6gvj5b3Zq8oEa4CBTfYhKtPR2rN/YK/nDrzzVwuE+hMImNrEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3971
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Apr 2024 09:51:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15551

On 12.04.24 16:05, nicusor.huhulea@siemens.com wrote:
> pass image_fullname instead of machine as there are cases where this is appended
> e.g. kas/opt/test.yml
> 
> 
>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..9451f55 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -181,6 +181,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>                                       deploy_dir, kernel_image, initrd_image,
>                                       dtb_files, source_params):
>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
> +        image_fullname = get_bitbake_var("IMAGE_FULLNAME")
>          efiarch = get_bitbake_var("EFI_ARCH")
>          if not efiarch:
>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
> @@ -210,8 +211,9 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  uefi_kernel_file=uefi_kernel_file)
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> +                cmd += ' -d {deploy_dir}/{image_fullname}.dtbs/{dtb_file}'.format(
>                      deploy_dir=deploy_dir,
> +                    image_fullname=image_fullname,
>                      dtb_file=os.path.basename(dtb))
>          exec_cmd(cmd, as_shell=True)
> 
> ________________________________________
> From: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS)
> Sent: Thursday, March 28, 2024 9:09 PM
> To: cip-dev@lists.cip-project.org
> Subject: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
> 
> This fixes the build failures detailed in the https://groups.google.com/g/isar-users/c/Va0Ue-ISYeA and
> https://groups.google.com/g/isar-users/c/PSGU_AcdPZ8
> This is a continuation of the https://groups.google.com/g/isar-users/c/ZMD4XY4dKWQ
> 
>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..86e342c 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -181,6 +181,8 @@ class EfibootguardBootPlugin(SourcePlugin):
>                                       deploy_dir, kernel_image, initrd_image,
>                                       dtb_files, source_params):
>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
> +        image_basename = get_bitbake_var("IMAGE_BASENAME")
> +        machine = get_bitbake_var("MACHINE")
>          efiarch = get_bitbake_var("EFI_ARCH")
>          if not efiarch:
>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
> @@ -210,8 +212,10 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  uefi_kernel_file=uefi_kernel_file)
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> +                cmd += ' -d {deploy_dir}/{image_basename}-{machine}.dtbs/{dtb_file}'.format(
>                      deploy_dir=deploy_dir,
> +                    image_basename=image_basename,
> +                    machine=machine,
>                      dtb_file=os.path.basename(dtb))
>          exec_cmd(cmd, as_shell=True)
> 

This is not a properly formatted patch, plus it seems to change to a
path that is not in sync with currently selected isar.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


