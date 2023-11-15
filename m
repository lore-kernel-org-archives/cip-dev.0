Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D793EC54FB9
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:42:06 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.44])
 by mx.groups.io with SMTP id smtpd.web10.14774.1700059318496587799
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:41:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hJOq67Xa;
 spf=pass (domain: siemens.com, ip: 40.107.14.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh+F+cKri9RTih4meYqzML/dwWTADUNsn4R6iE39mDctWIVMjLQGQA392ypgNbvm96qKXnuByVTOQ5yuseN9fq/Up24ugne+fHIWEl/nOoUhDoHeK7gPXl2EzJ44VRl05r/xJLvqsw96/EEso0v20G5EEn23VgzeNtgUBaHBDKnEOEVCVHUXTmOu5BG4SLUiFHUmBwf5BEm/KT0aP1CdvGsbEMen01bcLLiXOHrbxltm+VYue6SxzW/ohwSbo53f7uOhgh9GgHYplTay9nR8iEtqcouc1o/G5aaZYnhdJrxEDqC8kn7C5sA82lsUZ0orBRIp/5BfZfPxSUCHSZuY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ObkbVoJkEFkDpfDh7eAbjXZ5nM0CR9zMm/Ii+Hahvc=;
 b=e1Ab3LkzlvDcklM6oTuXQxUEOMJO//FcB64qeNimbxJuxCY29+UNiyhFWSRYh4CqCnWi89SzMRAqldFDnJsRbqGysSa1usske4u7Rh1R6iRmVKpId1noWK+afVdaFM/7gq09HrhenXyrxSGisniieTyPOQ5Z+Gx+NLxgN0CV/jUa2IPDKBRE9M9WnRDAVJwtov3IdW2enwpiXvsIQNKdMWWHK/z0/nfM6TFEV+dJ9FcA3X9m8UBOtuZ80LW8LTYoU5xmmkYr2Eu8th8JStQL9kzvhz26G3BspC3GPiZf/zPXEdz5pquUSYBlcUL3FU/m8kUXLeNbVRWoS2KZFnRsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ObkbVoJkEFkDpfDh7eAbjXZ5nM0CR9zMm/Ii+Hahvc=;
 b=hJOq67Xa0LIg3DjB8zzxlvgS7NRnIvapRtz1PBcZyrEJcgZTM7eptAncGwtE5TnqxrB5OCaBPwBHRPf6d72seSzXLnLs0GiIT/C90ZKLmJDtCI5AF5QNwDk1hPnjbW7UO4/eNISd7SmWFKp3+zAHAlfzt2oylWkE2UKj+4FpTORs6VKEvdqgZGAOXNoBCbtgA1MWcNfjjKGRDIhCrSCTxJzI1HPhAxEK/prtcCnW89h8nuhSVfG02t1/3Banf/9m7X2QkoYeHzgbflyNNMH6Lj1yD39Dax5O21HWluEF+y5GeQL/IVfQ/Su7EfoqD23bWP4bd7M2SSOjK6rP70G8Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 14:41:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 14:41:55 +0000
Message-ID: <d1f5e42d-2ace-4871-aac6-5e114569722c@siemens.com>
Date: Wed, 15 Nov 2023 15:41:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] ebg-secure-boot-signer: sign artifiacts
 reproducibly
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cecb10-3a89-4c98-87df-08dbe5e9035b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c4kZHjIZsdAZ1NUvmd4tDRAZ1+LFtHEYdWDCcew5O0vlL0Stmg+tfg77IP0bjDB3Yn+DUhEJ8soh65dKKs4xhB431aIyioDzZ8Jnu3e5dHS7LmK1d/uKbO7W3BLKBIqbSFJqj2W+AYa17CaISkJOiqYi95+6BKT6KNt+2EoMKK9/rFfwPAaOj8iGCmVY/gkpnMEf76ZVb6DOpSYwtKEtIeROBZMc6xEX2uOXvWtbG81bz148Woc4HkOs5vsETQJzv+DMyMFPvEMm0PR5bEpZPxuAqgEPDnjpRBClkLaLZ08GZ5DnzfEEVpSJj5I9JqV9mSgdeSYfeUxXEdE3c55rwEYERJ4xeqxCgH6AjVWm7hh5Hiq1gEzJKvcNJDgZ7Cxix/tP3QrlcfDXUULt5duralDjB68CRT7A3FhHFWXNQmqWCHdhxDDShg90a/ivN5YxQz/A0k9RzCqrtHh/YAbYiRDn+IR9HkatYE0HNvml4GJ7istQY6AKOqYepJwTzEnIjkJ9A21MC8OpGV2L9Q5XC9qpTwuJh+UR6w0SR6Pmd4TXuU0+5OEEpuKbyqWYXNVs5vuQ/ZNZYpZC7Xtk4KGXGbfpQtqG06kV/hBj+adbFYUbLwQSiLAiqgkz/zHqAW0QY2mrdA/zsJfqhwAJ5EEa7w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(53546011)(82960400001)(41300700001)(6512007)(6506007)(83380400001)(26005)(2616005)(44832011)(8676002)(8936002)(4326008)(2906002)(36756003)(86362001)(31696002)(5660300002)(316002)(66946007)(66476007)(66556008)(31686004)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjZYeVA5VEdETDFIZkhWU1lYTHJ5RktqN05xMGlZMkZVWFYveU02NTNaVXIy?=
 =?utf-8?B?TjI5MTlVNlVya2tKWVUzN2syWWZJbHNwRy9ZZmR3R1l4OUk2QUFpUW1aVUZT?=
 =?utf-8?B?WWxLdHFDUnFVOW54Sk5SQndSdmVQeHVWWHhWZUZkc3I5RVM0dklxb3dtWURk?=
 =?utf-8?B?d2VOQkhPdWNZQ09CWlQ3UEdqbzVKbnJSU2V0U3Evams0Q3kxdE0wcHB5WnRV?=
 =?utf-8?B?R2JIZVlCdE0vUEM1dXYyN0hOWVh3dHVyTm43T0luVFhvTkQvNHJEVDhXZkRU?=
 =?utf-8?B?NUZCRmdCenBXTXFmay9wbDV2MGlUM3FEV2RDRThGdWRFSUNad1RJMDI2NEJG?=
 =?utf-8?B?Zyt3a3RiaGFURW5uNG1JZGwvalBFbTZWODZhR0t6MmcvdHovSFhldiszdG5m?=
 =?utf-8?B?VUhZSFBQUWJHK2JNZ2NERWtUby8vV2d4SlUvSjJJQjdMNGlCMlNuTzdDSVFG?=
 =?utf-8?B?MUhPOVZta2xweDBRU0djdG1UdHVFU001a2dkSjZJZ0NJWkVTTUN2bUVnOE9z?=
 =?utf-8?B?a0hmeFBRM3ZpUVRlT0NhOWZHSlJlTnp0b0lUOXI3MXpFaHcraFVHSEpRSjZn?=
 =?utf-8?B?ZmltV204N3R4cXZEblVZT2pWb3UrQ0VPT0RRZ3R0d2JOWDVMNmRZenF0REx1?=
 =?utf-8?B?TC9tTXozZFZqZ21ldCsrc2txTXE3YS9pbm9BNHJoUmVuOVVxUlBhSmEySklh?=
 =?utf-8?B?NHBEM0svcFJQYXZveDFMd013amZjWEhyR0ZEc0luRWJVdm5CY1JHeHZraE8v?=
 =?utf-8?B?bThZMkhaSXErY1BkTDN1clZPM3YwRVJ6bzIycFZkUHBEbHlSMTJFdFRhKzJT?=
 =?utf-8?B?ZDNrOGZJVENBWElJaE9KVUhwbnYwL2MvQW8rblpVRnRLOVNkMHlKMnhCa244?=
 =?utf-8?B?ak5CYStEekZYcVpNQ3RDRHBTcndmTVViWmZYS0kzR1NySU5QWXJQMFlUMnV5?=
 =?utf-8?B?NEZQd3FmOE1oRUN1N0U0cjBNWVFRamt5R2g3QzRjLy9RSkxvNTBiQ1d2Z1U2?=
 =?utf-8?B?ZDJVK0NOYk5JSjh6K2haUlcrd0NMZHJQK0ZucCt0Nm5pWWJmd0NscUh0ekxa?=
 =?utf-8?B?TWIvV1oyWWd4WEZXUTNQcitIUWFPSmZSc05IU1pNN2doMU8yaVZ5bVZtZFpE?=
 =?utf-8?B?VFhIZ2NHcUNzVUNOUjVucmM2ZEhOZFdyTGRjTUNCNUxHci9FRzRTZTdBSS9r?=
 =?utf-8?B?UkJ3WDEvQVhBTXhkRXZVQkZvb2V1cEwrcCt3NjVpNUdWN2hzMURKREtQN0pO?=
 =?utf-8?B?Tmh1NTNxZVEzYmdYM0t3Z3ZzN05hSEdrd3N0Um4xOXVxMElONFYxYkJNYmhz?=
 =?utf-8?B?cVlCYU5OZHV0dU44QXh2Z0NrVjR2UnpDMWcxb1lHTzdUdFpsc3lpN1B6T1BH?=
 =?utf-8?B?SmZiVnFnYXpaYnROVWVLUHFOdkd6alUyK0U0VWF4MWwyVWlwby85VUNIb3kw?=
 =?utf-8?B?bDVjdEsrMmNZMEFtWWtCb3RFMzg5TWVRMVBKOHQ2cFNCMTh4K2RLM29ZeG93?=
 =?utf-8?B?S3hVSFZaYmJINWExQ1hRVW85Q3FpV3dOdHNOZUxWeXh5MmVOZzZtcHZnNzVn?=
 =?utf-8?B?MVNySmh0ZGJBNzFkdGxnY3JDMi9lSkpIVjBUVG4xbXdSdXBLOU5VVkFnZ0J2?=
 =?utf-8?B?TUV3TkxvK2cxV1A4ZXNUSThqZjZZK3M4dDVnUDE5ZXRrTTQyTytJTTlnUE9l?=
 =?utf-8?B?WjVsTFhkMThUQ2xrSjRPSnZhRzE2OTYxellVMVB2VElSejJ2UUV3TGc0RlJF?=
 =?utf-8?B?ODVnbnlucTk1N0tIbEtYbTFPZHJoSGFDaEJsZ3pESDQwM0psRnlQUXJlTWVD?=
 =?utf-8?B?NzBlMVFvOFhMT3Y1U2tSZ2kzUTNndTdIbTZQb2UyN3o2bDl1bzhRbkRiMjhH?=
 =?utf-8?B?QkkrcklEb012WlFIajNyS1IxaXBza0VLOEtIUXdDMWdoMjBiRmJBSzNSam1U?=
 =?utf-8?B?QU15RDJGZHBLQSs4V1l1ZEJHeFBsa1R0bXVoalVuWjRlRWM4c05rWXNXYVF0?=
 =?utf-8?B?ejU3MXo3bHpPLzlkRkVJV2JNNkEyby96R2tWbUlJN3pWMUFSYW1tSGs4ajlx?=
 =?utf-8?B?TUhQMTViaVF2bHV5UGVoNmM0a0E3S1BCZWJJTW03NXc0T1M4dmloalQwbXpi?=
 =?utf-8?B?TEJaNTF6cnNFQlNPTWNZMndUQ25qT1hLVGxxN3IvbGVnenJUc1QyMkl1QjhS?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cecb10-3a89-4c98-87df-08dbe5e9035b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:41:55.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GolvJld4IpvpAhB6KVocV9RMruuiW6s1GjPnJ2pgj3XcxRnUMCPXVcCrjZTJmnLk4ZhoVCVB8zdyLE8YPbYZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:42:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13586

On 10.11.23 09:05, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> When artifacts are signed with sbsign the images are not reproducible
> because the signatures includes build time-stamps.
> 
> This can be avoided by creating the signatures on fixed time-stamp
> (SOURCE_DATE_EPOCH) using faketime.
> 
> Fixes: #83
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb   | 2 +-
>  .../ebg-secure-boot-signer/files/sign_secure_image.sh      | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> index 546fded..57ad1be 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> @@ -15,7 +15,7 @@ inherit dpkg-raw
>  DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  
>  DEPENDS = "secure-boot-secrets"
> -DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets"
> +DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
>  
>  SRC_URI = "file://sign_secure_image.sh"
>  
> diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> index 0c9b898..213cf8a 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> +++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> @@ -30,4 +30,9 @@ fi
>  
>  keydir=/usr/share/secure-boot-secrets
>  
> -sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
> +faketime_cmd=""
> +if [ -n "$SOURCE_DATE_EPOCH" ]; then
> +    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
> +fi
> +
> +eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


