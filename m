Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C296AC7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 18:09:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.62])
 by mx.groups.io with SMTP id smtpd.web10.19922.1682100549156493737
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 11:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wfCJ67Os;
 spf=pass (domain: siemens.com, ip: 40.107.241.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6fGhUpNo9q8PZiDgVBOyrKheY2BoOMSZRmpwh/g6K54bEKtmbyncxv8vYutJVJPVHcN3vs3U4/1BfrTHj5iq1B/gSq3bGvtYmwld6FsV5L1QWHtK2D4W4a8NchveywCptmADrQRQwh9SCjs0CvqZZ4tsKdmDm5sPpxI0fGkG8UjzGMsvu9icaCVlW8/r8520UHosFKNsCvOBF3TWoPVcZemls2sqGl1UlCNgeenpr4PLcqww5Tt7lRPVGte14nz4zre/V8sTEggympdmYpmO5c2xQz0gT+96tXVUPQLInRzSLn7kQzCa95FoLaGPIylnalUadpyhXDc/7/FltYEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3iyWkOZzvhv7rBDylzCeUxUQ6SB2TK07zXzEFJamtA=;
 b=V0JYf1sBK6oGqOwgkdaI3YW1EOfC5duB536flaxF87TWY777xSoPaCOuZB8UjxfRUi/ZU7N4FV6GEYe0egq808MmQ0k3/PUaq6o/a0aDltoPinoivfARzofLaTlogIbxnX6RgBLm/AyhN4/+hKMaQzzYSVIXGeRlYlR3ovXkTGrrph9h8JwvX0+Lm3rSjG9WCb+AYxdobhrLQWERPxfqBj6ijbGWiJjxf3lZQiDbhA0VqvLzeu+uMtd9waTcfVVPGerUxbYX/n3DI5tq9J26TpkVNzEmism9jz071ogdMZV3dJuKdcbuy7YCCcDviNAd1/eHuvc10K/hFRCyDg5onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3iyWkOZzvhv7rBDylzCeUxUQ6SB2TK07zXzEFJamtA=;
 b=wfCJ67OsqxaxwZuq6lGVMtePNoRxzSw2ByqCQKn2VUSN4IXKsE9y8iAk22sq5RkqTONKnG9aAhXZFaFX8HsBorznaEgkAV+SJo4QQooewCjNp0QI3uE3QWZxjloQx3cHqD1tReFi4pI3BAoM5QqgaDbcujJLfvezhiXhSYRvtH7R3qFDHpDxAIeyFQjA6Q7FkGSCX1g88WIBTVsEZUkYLFF1z9VaJdMctqRVg/yuql7O5Vz5dpfjvDNu6ABR4qyc9C5zjuNWVmwM67HaUfR+QBjzghfyFvTlGgKlmPccErEmwkXoR8vmzQeMfQisP4W6HfQWQt9UvJc7OmukVdRz6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Fri, 21 Apr
 2023 18:09:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Fri, 21 Apr 2023
 18:09:06 +0000
Message-ID: <45232eef-46ca-c957-aa8c-47d25770ffd9@siemens.com>
Date: Fri, 21 Apr 2023 20:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/4] initramfs-crypt-hook: Add
 support for buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
 <20230421150545.4073324-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230421150545.4073324-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 968d4342-ace8-4019-edb6-08db42937ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ssTCEZxtA6ocTODM4g9CLvO5e8mf+Hh0GDJGk182GBuVU0PWduoKWYCm8LC3xte3KeGiyhE9/RwaHNeh5qVHYQGij8ViY/TMcCef1/SJ4XeuFf9EaQ1CDnfjO+WtDnI9h+vPg/PEbBnutKRK/Crj0dF7O29PUYwlMCOysLgrEpeofogt/F8rPNsUIVIl2LT6EEtHt+URi1ZptggF7NcfGRah3I9DSjtVg5jSjKwix0or/D5/0C2WYUcgAq5FFXP2rwt4AJum3x8zptSLAvLXe216aIdJ69UkfPqXTj+lnOt6voovEdA5njEaxhtH0hhZ9ELjLtq7l38Aeq2PTIu8hG69u35KY2Ic2noN15JZ8mLgp8uZugzFZoSeDqKolB+lHfWeUMVwUFBx7JVX+WEyyz+MxKXTnkxcMuyx7aXGDztnf5tOJoANjcKXMosTxtWJRXMqeG3az5qelmn0aJNO9c0f4Fxl1SHS06vqQ9kDuupyDvCTp69V7SU6WUE9QQ8fP5JYv9Lu8P/368+RO70PAMM8BuyOl/QCbbT5uYMeAgWTsEq0rHfwyWtPdK7DjWm1xm5qJfkYgBq0vchvonqPSbqs0yuyqG4F3fLF+NRAkETTxFmKMez3YpN33G1iSSH2wvmS2AJTIbbUNDm0EnfpgA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(36756003)(478600001)(38100700002)(44832011)(5660300002)(8676002)(8936002)(66556008)(66946007)(66476007)(2906002)(41300700001)(82960400001)(316002)(2616005)(6506007)(6512007)(26005)(31696002)(53546011)(86362001)(31686004)(186003)(6486002)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NW5HaTRQS1RJQWx2SjFDTFVxY3NpU0FwTWNGQVVKZURrQWMwVzgvdmxzUTVT?=
 =?utf-8?B?UHdBaDhuVVhFQnZFVDRFaTg0dFRxL2M4ZWhQTE15cHRNR0VxYkVzQ3FnMWNa?=
 =?utf-8?B?Y0FReE0xeC94UkxHZ3QxR0pSK0pVZnQ1M0E4RmhiQlV2SUtiMm11cGNLRlQv?=
 =?utf-8?B?ZE9hSFJsdmM2YytYNmVVUldON2lORHFsYTFMTWpZb2ZMcXFzdDUxb0h2Mjly?=
 =?utf-8?B?Z0Z4VVBSUjhha202aXpIYmdnR3JDOG1Pd2YwcHpFekhTbzlscEp3b1RYVm5w?=
 =?utf-8?B?VDVRaFJZT1h2M05RRFUveUo0ZUtyUnVhRTg1QnVUNnVuRHdBZ3d2WUluUEoz?=
 =?utf-8?B?L1gzejZWWU0rNW1iSy9wKzdQS3lVb3NRTjl3Si91eGE4YVFBMXRMU1hJa1Fk?=
 =?utf-8?B?d3dzeHZWRkJHa0ZmWnZCYlJHSGlLN0RkblE5TGVGSlhOOU8zWVFtU3ZBNWdM?=
 =?utf-8?B?d0hDazlZRHhKWUFkNWVrY0NnOVMrMVZkMVJETDRBN0FGSHlPVXdyVVpHeVB3?=
 =?utf-8?B?UDNlK1FKR1VUcnVOSUgwd2szVXo5ZS9ZVFEyY2FJbUpuVlY0bWhYSTF3ejFR?=
 =?utf-8?B?WHN2WE1qcXpvaVUzQkt3YUNYdXlpQXFJelVyYkxCMlhCeE5NUHcxYks5MzAr?=
 =?utf-8?B?ZmMrRGg1UzBPNm1hclNMZEpKK1NGWFIxOWdvemNXQUZMcnVSZldRQmo1U1h5?=
 =?utf-8?B?Y0tBUlY4bjV5NFRtQzB5ZzVtV2ZwbDlNTmNtUldVL0tlM0xGRy9SdkJRQkJx?=
 =?utf-8?B?QTRGMW5MUStsa3pMU1RZQ0lueGFIK0xaU0dvTWs5K0JtaTRRWHNldTFXV21t?=
 =?utf-8?B?czdzeGRIOE1aRTQrL3FURFFYR05BMTFyOG1oRUhRTEdnSEF3ek54aC9adC90?=
 =?utf-8?B?Z3R1NmlKSTdtNk80MWhQRUxod3dxNDJwTXNPd2U4UkJsb2d1ZE1jM1NUekdy?=
 =?utf-8?B?MGFXUHpNeWlJTm8yd3dmS2FJREE2d1kxMnM1bkNxOWlBdDN2RUZ0V2gxbGt6?=
 =?utf-8?B?WWxGelRlR1JSYWVObnk3VXQxN1IvbHNiYTFORUlqRnhLNFpvRXorT0FBM3Vn?=
 =?utf-8?B?cXpPb2NDQy9HZUR4ZlBSVzBkOU9ReVprTnd1dUxtclQwd0hkL3NHbjFrTzMr?=
 =?utf-8?B?NTJHZ0ozY2JtRUFwSW0zS3Ezb0VGNGYzcmdhSmN1TkM0Nm5kL2puZmxBMVJ4?=
 =?utf-8?B?Rml6NG9uNE1SckliZUQ5RjJFMmY0bnhnRERJVVNmcWhtZkxkUjk5UFFrVkpy?=
 =?utf-8?B?Z0EzOXVhcVNxU01ML2tRTzJuVXJZK21URlVZOHUwMjhvU2hxcmsvNFdYaG9y?=
 =?utf-8?B?cU9YV1pnaVk2SHRiNDFoWUNnVWRvVVdBYUR4azZ0SkVIaFplZEw5cXdGM0dw?=
 =?utf-8?B?R2RBa3pGR3JHMThpM3g4TFI1eUM2UFVNbGNrSDI5K0hGZHk4SWR4QVVYSnc5?=
 =?utf-8?B?bFZqNzZmZXdqTGd3alZ2OEFlSGMwL3ZMUjNBeTY3dlpNTk5odGo1V1BRd29v?=
 =?utf-8?B?cjlJUk9iTzdmSGVoSzMrdzVscHpUbi9ScDRiRDNlb0liYTlLL3FqcEhJNmNh?=
 =?utf-8?B?YVNiTmp3eDUvUFFXKzJwcVgxK1FTMS9FNFpKQUducGFSTzBSZXJCbU03am0w?=
 =?utf-8?B?ODN1enV0am5La2VOSEY1QnM1T2tSa25OREVxUVVPMlJmY0htcWhFYkg2b2RB?=
 =?utf-8?B?NWl0YTJpOE1hdVlRSURKeHU0YmNPVTRaMlZWamJrcm43ZXc4MjRJdFA3M3ZC?=
 =?utf-8?B?OHl2U0g2blVOUDEybDd1OWcvTlV0NGVSUkEzUDg5ODNOcStFOWtvK3hBMmh0?=
 =?utf-8?B?WDZpbHJxYUsvL3dxYW1NS212bXJ5QURHSThMcVF4V1hsNW5XSnFia3B2Qldo?=
 =?utf-8?B?Rnc1N0NUaDBScSt3ejZRUkQxV1pQeUhDV1p2TXZTZWJzd2x5Q0xmendjNmNm?=
 =?utf-8?B?N1FqMXNCSFZUdkhycEozd3JiT0NXbUVxd0dpeG0vRUROeWM1dXJNR1RLa0Rs?=
 =?utf-8?B?d3Rid3RYL04rdEdHNm01cmdXbTRhQ1dBZTkrbmJzeDJ1ZlZXblhZNGRxdmph?=
 =?utf-8?B?RmZYMndadFJ3QzJ0K1JvZURWVjczaXpDQkc0MjBJZ1lLcE42YXhnTmtub3pp?=
 =?utf-8?Q?msDf1zCsR7WqVH1OFxiCm+Xll?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968d4342-ace8-4019-edb6-08db42937ece
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 18:09:05.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0LaU8TRUkU5WYKtZuLoqn0NP9Q5wNdpe6/FVbFwffSA7FtCiRtS+TLX9P/mFB9gwPGX+1ClZ4xlY/7o7TW4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 18:09:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11328

On 21.04.23 17:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This introduces the necessary changes for Debian buster(10) with
> inplace encryption.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.hook       | 20 +++++++++++++++----
>  .../files/encrypt_partition.clevis.script     |  3 ++-
>  .../initramfs-crypt-hook_0.1.bb               |  5 +++--
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 5dbc5be..924ee7f 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -9,7 +9,7 @@ prereqs()
>  {
>       echo "$PREREQ"
>  }
> -

That newline should stay.

> +set -x
>  case $1 in
>  prereqs)
>       prereqs
> @@ -45,15 +45,26 @@ copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tp
>  copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
>  copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
>  copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
> +if [ -x /usr/bin/clevis-luks-list ]; then  

Trailing whitespaces - could you enable related visualization in your
editor?

>  copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"

Pleas indent the body.

> -copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
> +fi
> +if [ -x /usr/bin/clevis-luks-common-functions  ]; then  
> +    copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
> +fi
>  copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary"
>  copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
>  copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
>  copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
> -copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> +if [ -x /usr/bin/tpm2_pcrread ]; then
> +    copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> +fi
> +if [ -x /usr/bin/tpm2_pcrlist ]; then
> +    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> +fi
>  copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
> +if [ -x /usr/bin/tpm2_flushcontext ]; then 
>  copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"

Indention.

> +fi
>  copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
>  copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
>  copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
> @@ -66,8 +77,9 @@ copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
>  copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
>  copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
>  copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
> +copy_exec /usr/lib/gcc/*/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/gcc/*/*/libgcc_s.so.1 "
>  
> -if [ -x cryptsetup-reencrypt ]; then
> +if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>      copy_exec /usr/sbin/cryptsetup-reencrypt
>  fi
>  
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 37bb024..bcb5a04 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -8,6 +8,7 @@
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
> +
>  prereqs()
>  {
>  	# Make sure that this script is run last in local-top
> @@ -67,7 +68,7 @@ reencrypt_existing_partition() {
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
>  	resize2fs "$1" "${reduced_size_in_kb}"
> -	if [ -x cryptsetup-reencrypt ]; then
> +	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>  		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>  	else
>  		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 1436b94..997f469 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -10,11 +10,12 @@
>  
>  inherit dpkg-raw
>  DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> -    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
> +    awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
> +    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs"
>  
>  CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
>  
> -DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}"
> +DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
>  DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
>  DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
>  

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


