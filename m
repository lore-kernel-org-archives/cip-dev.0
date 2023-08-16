Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E74C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 13:37:29 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.87])
 by mx.groups.io with SMTP id smtpd.web10.160929.1692193040730163030
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 06:37:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H7pgnsGU;
 spf=pass (domain: siemens.com, ip: 40.107.21.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDNcxgeLsgNUd8oAXD4n3rS8s43n3a50jjwQ//OuS0PoYObiRrWRNz4XTlrWBRWhRigHZ99eH1Etd1i8XlDn6CyMyPSeFt/YSOTdA8QR8rGj0cw06lb+N1uWUFGdtnE6r18Kbf55XjoePNiy7//gpXT65hwNOqPqcRFOrKJo0fv9fLXhTZntdkqGbtxoc7s8VjdAQ5QKkb/OAKW+BqxYFsH/+wTQtSv3mvm56qJE37DnowUhroeWgye+xGUE+oEb07vhoCwMH5LyCRzX7o8PnW96s5UEBT0g3Fyk28jFSP5awpW7vyDobxfsL89kPecZOpDE54DyIuI11wYXaA2bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFNNVkuXEYg58n8JuHvV15QEIds0zu8a2RexAsI6Et4=;
 b=irFFabtGjj6skDj1I+OQz4uGeB0kx3B6He7unqPIvjb1KhcwGmMr9LnUJCrB29RKV50BgzraUXyFAkV2WUp+Ge+kuu3+X5F2MqeZtcvhbDoFqRH5fjwccBaz5iVpCuxisp8oORjZWxR0DIZQkHjl3n1gq+hniv7TI13oK/CCt0EMjx5ThP0FiDxbN1U0zmqvjGOVFgS419KSyJkXjj3CN5S92TkNYfWwU1z4ZY/YxurHlbQ4YfMqRtpC+YQf07GSukxsusKjFrHY4O2xqVpvCXl1gabwIfsokC18F7s5T64OCHaotqd0wucoavzNl2qw8mwdDNJ60FTi5DFHOBRa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNNVkuXEYg58n8JuHvV15QEIds0zu8a2RexAsI6Et4=;
 b=H7pgnsGUgIEGz37nlVVqnrQG9GRVED+VihIhVjUvdcOhVgr/jh2YHeF89UBdTuHjKRvNTBQGzgyxZTEaxwUUgEwyjt66O2ghyS7YobqwpAogOigA/k3vXL9uiWb/JaBy0a1VlxQWagstx26RnFmjMnQSEeotAiZAf/oLsW5Dp0Ju8rwCW5KpWEGL2pU1fR7P84EWl9JP5V6NoX0kcywFqBwZFaL8ruBK0PPKygILRYh7UoNn16YTNWCK6MR5u0PD4+4jxzixOnDxNSQBMa5ppyMmiH2EIghyvKVQdDdRcSHpYSV9qeQn3ubhfP8h0xhTBd29t1VXPjGDU/7SVAS4cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:37:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 13:37:17 +0000
Message-ID: <cf676cec-9eae-4aae-b855-06c1275f6325@siemens.com>
Date: Wed, 16 Aug 2023 15:37:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Avoid calling of
 tiny mke2fs from busybox
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230814121125.2949305-1-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230814121125.2949305-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 254906bb-b720-4a7d-8e9d-08db9e5de841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	75KeaZgi8peccNPHBd4f0+QEB5xZlCQdt00sdMnsJluWnc1WlAGYJv9wzovOQwaHkNMMQ/NjJA0ze5oRCh3AIdgtgboIGsKGBbgAcjFlFNXCGyIVJp+3hoNN8/WjHuD4x8jT6uHNDC9vG3NW8trXSGZRYcjWJKtPk/ElZ7rjTP3gbR/zo+WjnawTweU7yL2JxkqNPQv49up2oU1sc1FAWTXpXrsx0+XOHxNxbyvQ9T+Ri2IgKtLcj1VJoyfHNeeG8aPt92q5tiwZqB8kghIuUUX6xy5wmELAE/0AQwBcfI0EeJEfgETP252kizHGjZPO98+QVlBWu2BzhO5qyp4xW8B2X9MRhYF012MxPrSkxTy1Bn7Aqxc4ED0RUsjX9fMurDjy+8l9qnl6kJi3rnhn3jKGYwDabD7/faPvawK3kQkJjnDXVDeZbSnS6pv3P1MIZpxmRm33iMFJLUUsgRRYKEvJIurhXyvgRYo6rqvB5OanXoFXLPxx0FNioHgQFa+peJaWgAONqAAIyIKDDulliuo+Iwx/lnPwwcDB5N0hGkzHZptjw4PDb8f1HLpt69OvMVZFBM2pyVgzhr7PH4YRif/n9IJVT9WZaXzWGHuV7kqi/I7hbJhjCjJAzn2JqeCYY0CcALxdETQRZIuPtEq6kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(107886003)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3JOOUdhOVp6am9mMXJWVmkvRE5sbjNnb2pEZUlxaTZNbXAzTXQ4OW5qaTdS?=
 =?utf-8?B?bVJPblBGNmFNQTNveHlNeWZ1bmdyVEt3ZERKT2tFUi8zZXZQbkdHNVFHMlZF?=
 =?utf-8?B?d0lCeWZ5djN5ZlB2RGdnczl5WDIvYUFpcTNHZ1Vjbms2c3FXaVA1M0RFaHoy?=
 =?utf-8?B?RzFNT210UlRsKzZlZFVFakttSCtRQnpVZUV6cm00b0RuUWIza0grb3NTcnZl?=
 =?utf-8?B?SVBROUxLWmVlV0VSWG1hRkJQazBLMnhVNTdoZkowRnFoU1pNQ01wUUdwcmNB?=
 =?utf-8?B?Ri84b1ZyY0dLaTluT085ZWtKc2pLUElLdzZyQ3lrWFY0QUIrR1pad2M5ejQ0?=
 =?utf-8?B?bjBqZEhqR01vcFRxNDhsRzZTcHNVMFFTY1l1aWlKOW5USjFxTXVDa0pKSitn?=
 =?utf-8?B?VmV6dm5STS9sWURaRFdON2krdFJJZXZzOFNheGN1T20wb2Ewc0ZvOU1HSHda?=
 =?utf-8?B?L1NjZmpMdDhyeUJIZ0cyc1JhL2RXMFZ3UndaWjMzbmxXVmtHME1rVlc2RVAz?=
 =?utf-8?B?SHJPcThKYURadDFMZ3BIMG9VdUJ2SkVwVGt2aXppRjRzUmVvVmdpblF2TGpO?=
 =?utf-8?B?MkxqaGxoanQ4Ni9UMXV2K2RnNitHVTZ4LzBWZjBTNW1ONG53eHhjc2kwVFZ2?=
 =?utf-8?B?eHZhanB4aGc5aUFhM0RkMjZkWExLYWZPRUgydFVPRVdqU1RWaEZucWJ2MDVh?=
 =?utf-8?B?QkU4WGZ0SGtPV3Bla0dzMTJMMVJZME1sYW9qVysvWFFjSWtTN1BTSG5mem1W?=
 =?utf-8?B?RnhvcFBiT3lqdlRtSlYxSk00Q0liWm54VVhWTkJpUnNMYjRXTllZcEhUZjJl?=
 =?utf-8?B?YnVTTElKMlNqcTl5RFpGbVNJOTZzZ3BCZmRGM2tDdGJlbVhKV3ZuMGFhMml2?=
 =?utf-8?B?dXZWWEpXUGJuSVRqcmQ2dzZaZFFMTmVRK3hHL3MwUjVNc09RTWlWUnIwMnlG?=
 =?utf-8?B?SUxlL08wUEd1ZzB2SlZqZVlJRnFzczNuRGFRblV4S1ZSS044SkhLRTRJdXNx?=
 =?utf-8?B?dy9GMHd6QTgwY05FM2JZWVZnOEd2OW1OZ3FEU0VabUVxQnBNTytwb1ZGWHVo?=
 =?utf-8?B?dmxGcTNmV3NIUm9BbEJJRGpHRjNyY3RCNUE5S1ZnSUJGYVBCSWo5YkVMVDhU?=
 =?utf-8?B?VDlsUVlEcDUxOU1hUlVVMW42M1pDZ29naUJ2VUc3OWpZNThwdnZOVWFZUklS?=
 =?utf-8?B?QkpqMTg2dG1WaGNHTEhnMHprQVR4dnlsdGpudkdvS1RrS0hxMGdBYXZYYklD?=
 =?utf-8?B?aUhpdkdqYUxBRnlFTG5ReGEwazRxUGxpQ1ZXNlNTWE9yVjQxU3ZPSXBaKzhS?=
 =?utf-8?B?YU5yUjRvMVBUV2RZZnkxaVBCVEkxejJmd2YxTkFVZzQ5RHBqa1IwNHFIQUMr?=
 =?utf-8?B?ampLdnpFdVU4SUw1dnFNOUNJbVdwa2NjcEpSVkxVTG9lYXJST2tpbnRhdHg0?=
 =?utf-8?B?Ym1WZEFJSHpYNExaMkE4UjEydURjV1B6d3E3ZklCL1loN2ZNZ1FqRDJQc0E3?=
 =?utf-8?B?MGcxNGVCSTNYeUVoYzNrUUtjSXk1cVlKYzlVb3hMUXVnN05PbHpjN1dqUEo1?=
 =?utf-8?B?N1gzamJQa0dkRGRscThwRVkvTUIzNEY4WTFtK0E3RkRMcjNpam55aW1Ycm1K?=
 =?utf-8?B?ajVoQVVzeHBIa3pOTENoT2phWUNiTTB4VFJ6bDdhbzQ3RWtrNEdCVmxKOTRB?=
 =?utf-8?B?UFFZZCt2R3RZZk5zMVhPdFNJNlp0WXpYcEZFZ3RwTTRaU04vL1BtRUd1SWt6?=
 =?utf-8?B?b09ENGlFUG9wV2tmWFlKOXdORWF4SGx4c1dZRFozeHJDZkVFd0xIay95YUhu?=
 =?utf-8?B?RXN6bVdiT0ZESkxyS3hHRkJUVkh0R2t3YnVRMkxZaFRUV3VPdWp2U1dLOXE3?=
 =?utf-8?B?KzBHc1A4d05scVNwK3RMakdicTdJdG9OWHlpQjFLWGx0RmpXQ0Z4Y2lRbnRU?=
 =?utf-8?B?WkwxUmZ2ZWxDa1QrOUtTOGUyL2w0UFJjM3hTZHFNUUxuNmcwRk5BUC9TODJQ?=
 =?utf-8?B?SXQ1R25kTC9CaHdGR0diNE14ZWRQNHpRTHdveFJ5cnl0bTZsY1hTYitCLzlK?=
 =?utf-8?B?dkRGT0k0dThCSk5hMVNLUzdUd0t4cG1ZTGFtR0xJcGh3QmdvT1VocTRER2Rs?=
 =?utf-8?B?dWZ3SXJqNUFwSFFTWkJnK2JoQm9Fcmpsd1RwSjE3Uk5aaFdUWkl0ODVEUjB5?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254906bb-b720-4a7d-8e9d-08db9e5de841
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:37:17.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjVEkBae0ewwAyrdFvaBkE9DOtWkepjTyeydZXiEvXvsqa+ecAesuOUMG1DVBDHnTQJS7gSfkHpQ6AQxyNLcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8209
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 13:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12677

On 14.08.23 14:11, Koch, Stefan (DI PA DCP R&D 3) wrote:
> - The tiny mke2fs does not support the used -t option.
> - Remove unused script test since variable has default value
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../files/encrypt_partition.systemd.script                    | 4 ----
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index b32b2f2..5fe2e91 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -41,10 +41,6 @@ tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
>  
> -if [ -z "${create_file_system_cmd}" ]; then
> -	create_file_system_cmd="mke2fs -t ext4"
> -fi
> -
>  service_watchdog() {
>  	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>  		printf '\0'
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 1c1bf3d..3c3f6bb 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -32,7 +32,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
>  CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>  # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>  # in a newly formatted LUKS Partition
> -CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
> +CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  # Timeout for creating / re-encrypting partitions on first boot
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions

Strictly spoken, this should have been two patches, but now I merged it
already ;).

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


