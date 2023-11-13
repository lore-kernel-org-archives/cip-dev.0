Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E0C4332F
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 17:09:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.87])
 by mx.groups.io with SMTP id smtpd.web10.825.1699895384713474466
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 09:09:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vBSAsqF7;
 spf=pass (domain: siemens.com, ip: 40.107.105.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrsiWxRjZAKp3oKF6Qr9Oiy/Q1PBi2ZTt0K9ku1rV/vitzklyPT2aLZyitg8PpFIOTh5J/3GurfVSbSMXUpMEoxs4IJR4HoN8sH51MD5X75k5F8nDiKN7vKuLYu9wYpHImY7AjGHbvcg5qjtEh31TbVnywEAumw1ILRlksp6KqEYYLocGKyFCvAkoh5gBhHswnt+JAhmZnhj/2MeOC5E+qVuRb4bZEu82CalLz7bjXFW+vmyBDYPm3bgD5o5Ax0eA4z+6+bk9k3GQT61yN4KH25ATR4aXnbSOgItiCF0zfVcdPO2/v2gLR7SeZgeP+yNqX8Cnh5mv/+tygcVjZ1ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI/AwkXW/tNkOkbKtwZXbKZAJScFeeYy8DE+8RGaCBc=;
 b=IqkTyT3w3MpOCaYWQytlbeL0Mpzpdsou+tuOggJvTesPz3v1O71bYlR4JYKoSjCiUi04ltopoo7+s2nXgn2M27MUFinDy+cNrAQB/Tn7uUf86GJ32JpQbTaJOjrUVdeL6W+iYB7tkSrWvPfvUO0oGPYhRCopsq0M/jdk9jWSYSmwu72ImRpefyqqbOrm8uX+nYk2O/uPqO7MxGBBjH6R57HDW4PaIL/d6BA0rqsQp7F3jYsf6XgHr4pmsI63OQ/hzVBRdN/WhLZbpbbVe36hdXMFh82INyFd8ktStyEuweLeWO/gwCXL1/o6Y+WYejMmDIfdPo4BsRxT5qbpXF3iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI/AwkXW/tNkOkbKtwZXbKZAJScFeeYy8DE+8RGaCBc=;
 b=vBSAsqF7t8/gzOj8+NzTyvtfujbKkfD/jOA1vnElmV4Xsw/QXm1pTGb5XWpDNaZZvcVEkyXCPgEarM7msIQ6qoajvcU5TaiOTbyin4K17Qn205FpS/4iMBribjlUOiMefbVP7zAqFvuVN8lqwTg3fmVPrbMyuCm0lBCCpWOs16O03NMH6bPajYj1si4gdWAEXDBO9/FNJyPvL7yLlwTnlI8jDp/Y4WLS0oZ/KD+QbcCl++ZCS6zcUM3+HiDmFQFXIhcAptPcGHw+f7A+Q8nfS5/09NeLNYnSqnExXw4BLudANsy0EmGxlq8LTw3q/SUCPsADCCesj/wjexPsPGPwSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:09:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 17:09:40 +0000
Message-ID: <38366a17-75fe-402b-8ea2-fcae03f85832@siemens.com>
Date: Mon, 13 Nov 2023 18:09:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US
To: "Sari, Sercan" <sari.sercan@siemens.com>,
 "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
 <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
 <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
 <DU0PR10MB6898448570555A3F8D0023DAF0ADA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU0PR10MB6898448570555A3F8D0023DAF0ADA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2b4b62-fc2e-49f6-99c2-08dbe46b52cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LDD1aQoaf2y1H5ZGSKVWI+k9JoSrsq8Pn8eTj45LVFrX8kYO8+15ikW/0RvjDWLSxza8NVEb+UHXL8tNDW6aEqb0LLovoXM1Mg7ws5FFj/8bL8V/PZmsNqCcbkKNuyxOQtA7J2dqRfdDrwfQEuosVZVg2xE9qWpHK4uGiNGg6FTQBQLcP25uA6SBpmBBjzmK4avLVHqF2hJpEL/8f64ZOwjGVTxqQwkLEe2GJvdfH/FwwrKO7Z6zQtXURGhX3CZZFJZnbF5PiFsf/Bax2zCOtqz661Xgp4yjc75dvJR5t3bTXjiQuRAFI1uuBuRFwu9LXwFV0s+0QvswtWXDNQMoggOELumplI9EFxhtZu1PERXniwEo6S5mDfqEDMjBOUo7FpZIVCJmxQmD1LbYcK1omXB7YyvUvStjB5qZt86ILpuG8B3jAPbg1tszTzPeribsxqq0fe8tg/wsW4QxmQ4/XBFEmkd6pCG8vtdgA+BhLRLRDYWzU1663DGkB/AgPg7YjCZF4UjhQJb4A4XQVYriW+U3aJOnl9btxwb84jF2ZhNxjJMAbQPK6YfMQq8lHXWVFjYO/gdv3UZUVyie6S0ZGMZD4SSiphn7myUkmm/iQ0u1wrhdpOed5JLDRvBCbHDTZJkvYaTko4T/Xiy2ngE56Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82960400001)(26005)(31686004)(38100700002)(2616005)(44832011)(53546011)(6506007)(6512007)(83380400001)(6486002)(316002)(478600001)(6666004)(66899024)(110136005)(66946007)(6636002)(66476007)(66556008)(36756003)(41300700001)(4326008)(8676002)(8936002)(2906002)(86362001)(31696002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SE9oQUpESUIrYnljcmc2UnlRTUNCVG1pTGZJaHpJZUp0WE1rYmdWTXJzVTZD?=
 =?utf-8?B?ZFU3bVlTMTliZFkvK3VYN1ZYTWY5em82MUdTYU5yZ0NTM2FhMElJclg2V1do?=
 =?utf-8?B?KzBITWQ2VFdOeFZUMTZsSnJQUXBpdWdwWTJobGdoS3JDQjFodUg0cUdJZWd5?=
 =?utf-8?B?M2I5Y2Y5NUUyTkllNEFLOGV1N2ZTc2RrVUZ5RGlhdlVpQWZuaG1tbzVKSStN?=
 =?utf-8?B?UWZEcVlvNEY4UC9kZHF4OXZseUVCcWc1YXUrK2RPMWlWenBsVmxmb09rcDZr?=
 =?utf-8?B?VzRIR2pLNjBsdHVZMVVoaFJ3SmRPTENZY0JGazNNRWNSUHQyNXdlamRuTUNq?=
 =?utf-8?B?TjZzZzdoQ1h3eXcvS01mT2QvMGk1Q25GaXN5Z2JqckNsYzFwelZlQ1JSL0R4?=
 =?utf-8?B?ODlrUEhVQzhZREtLNnNxRUg4ZXNkVWpNSEVkQ1g1WmZTSk5Db1BmeUhRS1Yv?=
 =?utf-8?B?bzVGZ1NCaU5BZUJwRVJMR2VUblhMOVptSjR5N2k0NVNmYWxFTWtBYWNGRVJy?=
 =?utf-8?B?em1tSkdBancxNEE4TS9ab2o1c0dSTHIzbGJoTEVaa1BCUmVxVVhxeG9ndS9l?=
 =?utf-8?B?bFhreUtxRHRGSGhLMGJQWTlBQ3BNVkE3ZkJWS2gzeTU5eVlPQ2k1dDdaRkRi?=
 =?utf-8?B?cDc5M0JBWkNqRHV6Z0NNKzV1VnV4THh5WXJsaTJhTkpUNk94MCtrUCsrUWZH?=
 =?utf-8?B?ZncxV1ZQSnQxdlNiaWtJR3IvZ3hZSXdzdXlSbkU4K2h6dU1PVnh2cjVHWFRP?=
 =?utf-8?B?R24yY1B4eld6bmlicjVjMkJCYkJDU0pLZXZNRURVeXJ0dzM1R2VuN3RFbjdI?=
 =?utf-8?B?RXlnVWJMTDUwK01IbTlUS0o4cHIxVDdoVkVpWEI2RDVFSzhXTlRSUXVvWWpj?=
 =?utf-8?B?Y3VOM0hKZEpuUFhqSThvTTBJcGJiT1gzQmN3QUVJNnRFNlUycG9OMXk2aE1P?=
 =?utf-8?B?SVl4dFZhZHNVaG1PSG1kMmhSK2tZQXBRU3hGdVFmUW9ZQjRxUENLZGcxLzZi?=
 =?utf-8?B?OThQL2NMcnVNbCtadUhTalQ1M0pRUWcvS2ppRUpSeGliNU9FNG8rWko1dm9s?=
 =?utf-8?B?eVY0VFFiaE1ua1RUeXV5K01TN0M0WU5SUUQyd0lNV3grN1hPeEsrNHdqNm84?=
 =?utf-8?B?WGJNWjFrUG55cEhBYVAyK1dySWdiYWlRSjVUMVRuazZCeXVZTzh4N2Y4L2NE?=
 =?utf-8?B?RWU3SWQycHZFNFRVL0NEQmJhUmx4VURuOG5EZVAraXU5UHIzN2JiTGt1a3Na?=
 =?utf-8?B?dVd2R05EbkdlUVpIdFZsem9ObzJ1KzBCOS95OU56WGpxU29TY2VIWTFFMm0w?=
 =?utf-8?B?Q3Q1NGlLSlZ5WkNiczVQd0I5MWo3alFTSzV2S1lUMlYwSXN3a0VlREl1YjI0?=
 =?utf-8?B?ZGtSWmVZWHFveVZENVdsWE5MWEZGcWF3NHB2VklpbmpydjB3dGIyWnJ0S2hH?=
 =?utf-8?B?MWxsazU1aHdzTEhZcGVXOFZxTmx3dWZyQ1ExM0s2NURFcSt0RVdWUG5lcUNi?=
 =?utf-8?B?eVErM01ac3VDNzFjNVpUdW9tRWYyL3B2ZXpwaXYzNGVlMUorZDJIN2lBYnd2?=
 =?utf-8?B?STA0djV0R2krWFFkeWhWZ3V3Z0xRdGdGeTdZd2lMcGtuSzdFWU5lVnY4RFZ5?=
 =?utf-8?B?MFFkcWdmb2N3aWQvQS9lRlA4RzF4TVZRTzRPWnJuYWlwdFZsK1BqZm0xeGpy?=
 =?utf-8?B?M3d4WkprSnlrTlJMRnV5UmkyaXJZaU1TcmNnWEVMT0dEYkphMmpvSmdGV0ky?=
 =?utf-8?B?Y3ErVGRMRmtVVFlCVkY3MkZpQzBmNUsybjgxejhJSlhWL1VLOWVpdnFCZU9x?=
 =?utf-8?B?ZytQQmZud2xiK0VwRk5xTEdIUnRQWkZ1TEtUdUF3SXA3NWVSU2Rtam9BM2hq?=
 =?utf-8?B?ZnBWWVM0TGxCUFZoNkFCTjFadjVNUit2VFUySi9oVXNCWVdhSk1ab05tUHFU?=
 =?utf-8?B?RThjeGRTRGkrL2JQRXp2YThUT1U3LytLUXBFQjdJb3prL09uVi9iQWZMRzJz?=
 =?utf-8?B?b1JhdUdKWnkwYXBmMVRlUnpRVnJDTVoyekVqTGhrcldjWm52K2ZUeDYzZzl1?=
 =?utf-8?B?NTRlbGxrVTNwTU5WRGRzeDVydzhSWWhBc3FtUURteEZ2UVpIaGxINkk3WUpX?=
 =?utf-8?B?aXVrMXo5QUpGekV6SkVRd1FYZ0RHMjl6V2JkNFpTdUZlY2xRMTlneEI0dXh3?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2b4b62-fc2e-49f6-99c2-08dbe46b52cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:09:40.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63a/sumLzza9O8bWDNflus7m91gAmclMrf3MZ65oMCl4zGMFC1Ab32CCRuzsdLzrunq6XVKhL5e3gev1nQ1AZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Nov 2023 17:09:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13575

Please do not send new versions of patches as reply to the old one. I
can't apply this one without editing. When sending the next version,
mark it as such ("[PATCH v2]" e.g.), ...

On 11.11.23 15:11, Sari, Sercan wrote:
> Configurable hash type for pcr_bank information. clevis will fail to encrypt data when the TPM has multiple banks, such as SHA1 and SHA256, adding the pcr_bank information resolves this issue.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---

...ideally also including a short changelog here.

>  .../files/encrypt_partition.clevis.script                     | 3 ++-
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl     | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 +++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 899f20e..6d8f209 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -40,6 +40,7 @@ modprobe tpm_crb
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> +hash_type="$HASH_TYPE"
> 
>  if [ -z "${create_file_system_cmd}" ]; then
>         create_file_system_cmd="mke2fs -t ext4"
> @@ -61,7 +62,7 @@ open_tpm2_partition() {
> 
>  enroll_tpm2_token() {
>         if [ -x /usr/bin/clevis ]; then
> -                clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
> +               clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'","pcr_ids":"7"}' < "$2"
>         else
>                 panic "clevis not available cannot enroll tpm2 key!"
>         fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 52dbd00..bf2cc78 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -2,3 +2,4 @@ PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
> +HASH_TYPE="${CRYPT_HASH_TYPE}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 3c3f6bb..0dbac2a 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -37,9 +37,11 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions
>  INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
> +# clevis needs tpm hash algorithm type
> +CRYPT_HASH_TYPE = "sha256"

Better make this override-friendly (" =?? ").

> 
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> -    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE"
> +    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
> 
>  do_install[cleandirs] += " \
> --
> 2.25.1
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center


