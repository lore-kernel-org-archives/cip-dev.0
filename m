Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E306EB64DD
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 06:26:24 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.67])
 by mx.groups.io with SMTP id smtpd.web10.10943.1688538375453623802
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 23:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rlZwJqNV;
 spf=pass (domain: siemens.com, ip: 40.107.6.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMhkYD/f62cCx8iQxFrUyc0X4BpsT/ua9gU00hv9VGPkd9C0qSojoRBLqAmG++IJFt+tb71GHtI2eZkfIvEO8jvME8HK/JTe4q0gD5UE4t5w5TFb8qiuBE4odvAOG1zeT8sNmcemDiDL/TQKch2uW8BPI4SrKHbJaTWhz05olirJ4AlxULTFzpdt+z7sJuUusnKy8VUJMI9QFSDevnSIpLW2+mDyrVHKuj1AHXMvvyPqJHGjkmfAam2cdTLKGZxAyggIrzi6WaMJYxkD3MvzRVbbENBvzIUs68l+Yzv02138p/flmtFZR2GbKG69FyWJA3hQ+HIR5INQ9CqnZQW66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DjZn28NXP/0qEyAr5GOtMb/eBTYBPCC+8yGCaMaOhE=;
 b=Kxx3nWmDvdU/r46rabYYsjDolmp2hoH5JxiUeapS1Cq+tPmC275pmc3ZOFb2c9QASYoMmIpbp8JbD9OYJAPRyvysvzABFhqQPpuT8pr6tTn/D90bLMDeRQ1YTTxZpVwZsiw9toA0PqnIl84b62SJP7/R5ValAB+srWMwe0aY5qMctQ6+ysbrz81r7IwcfJISvZ6p4i/j/UZkkSYTnWhJWaFBtTW/trsz5m68dlYpeGuVVK22AIvM6VbzkuXx0kCOmOYFbfYoQAIXbFvlymOIfMbg5tXWCGYsNOuRu1FIj5RtAdFks0hYT+6f/tR7Y6ir/jKK+oJu3xr/Y2Vy50LyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DjZn28NXP/0qEyAr5GOtMb/eBTYBPCC+8yGCaMaOhE=;
 b=rlZwJqNVbYOrZFH1TlfgYcM2oD+gKg3T8+oHB5nZi9kSj+iPr2qHO75a7KvH+OXIQ0YvAlsbiN7ixV1O81Jz8nrLbhJ981KV/DeyFPeuiUAzsBPf9m6nd6nd0biT6x2LKNKs4Mz1aU35/aRmCiFijO8cVJl7kD2sFHwplhJE/I5LHaX4gYonwRlS7OOwnMLCQYZ2JZYcFdkqzCLnSwix0Rs73E+FJN7WsTpUiZdHGdLR6/ZKzQ7sq7YFhpmOd/7WQmkdMmPOOzjLOd+UwKQpLjvQsew5Ce29BLUM1MYKOVuQcwl69X2/Fu4EuW5izuhFABjnhFNjv0oQfekgKGXH8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:26:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:26:12 +0000
Message-ID: <4eca63ad-8b8b-eced-414d-b122e039c6a4@siemens.com>
Date: Wed, 5 Jul 2023 08:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core 2/2] kas/opt/security.yml : Change password to fit
 pam_passwdqc policy
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230705061611.20080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230705061611.20080-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230705061611.20080-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7424f9d6-5802-4d92-1c36-08db7d20ba9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YcXb+PbAqfFJo0Gv4SaIOXM4ORj935UThQq9HJJywOeEwfwaDf+vbOJ/37mk21Df9FS7DFGBlZpwKsvwGrzz587H12lhjIhloRgPJ3FiMsX+REerYuPAg+SP6w+V51VBIHbB0VRBtbmzZioQGjp5O2jLn0miNIxpERHalgZN2VBspqFRO6Hbmlldrb3IfVqPBq6u7XuwckwjQ4m6ZP9Cu07CrJ7vuKORx5WnO+Be8tZ5vjxHQ9KwQPa6236LVx23szyCxUUZksQs8OeBmzTejgLACwlm+7ymkAiNJG5NHgmk8tLZ4GihLm6hMwvIenvyADZm1BdkWKGDVqydvruoZkIVRDUVFSCT2BSYUBNt1FtGkpZLYlfHkO5Xh3hRHTMyh1Tt3EL1XKZXsgkZZnDQ7Iho2eGQzIZHmHSVSDCGzhPHbhF6F1slTEeefXFVIjhie70uzCL6sh2QrQSUUwNSmDm4Ywu8xP1QeQWolvQ5TWaX3EfTN20bvXxzsl67/H8ApkBey2Cr/zKpjAGSbeidwTcF52Uazzk0qk+eiQ+Emg2na/FSp8BXmBz7me7sEjkiH6N85lGTxhned22ACaZhBq7tioRyvcwqcBEnDRw3sxDtad3uYgEYk9sXm0PraqTBkraekPzYFGGL47+E+gZM3w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(44832011)(8676002)(8936002)(31686004)(15650500001)(83380400001)(41300700001)(5660300002)(2906002)(316002)(2616005)(82960400001)(66946007)(38100700002)(4326008)(66476007)(66556008)(86362001)(186003)(6512007)(478600001)(6506007)(53546011)(26005)(31696002)(36756003)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnhhMGpxUDhlRGRGQ1g0N25URXAyeG1MUEhzN1BSYWpFd1NQZUV5VjBvVGN2?=
 =?utf-8?B?SU1LRXczbzRaMDBHdFRhekdHaFdIVDNBRHUzSjZrczBwUS9ZUDcrbUsweWov?=
 =?utf-8?B?ZklvNDdLQzU1YnlwZnltWFI5bDMwRFljL0ptM2JqekIxSnpxREVMclpvVEpj?=
 =?utf-8?B?aC9QcDV1dFVJZVpTVmhFd0svd1hQcFh1YkRndlJzaUlGK3pmSEhGZUtFdVh3?=
 =?utf-8?B?NXc0RWdwRmZRZFV3c0RrdzZMYWttR0p0VSt5MlhYOCtnYS9sM3NEbCtBaVI0?=
 =?utf-8?B?ZmZodEFhVytzNEk2cFhpSnZybDhpOHdPc3AwTWFaZ01sTm1oM3NsRUpWWDNK?=
 =?utf-8?B?TkNsTmozWHNzQmpFNnFyYUlQcktyUDhjMHVxaUMrNFJ1MkZwZXYvc3dyZ3RD?=
 =?utf-8?B?TXljYU1IeGJZNGNObnBtRUVxUEp0WjQwU3UweXBEQllzVXR4RFZrOCtWaTY0?=
 =?utf-8?B?OUs5MTJZdXJZcUtjdUI0MERZSG80R3N6bVdtZWwvU2JsZC9uV1UxSEpsWVJW?=
 =?utf-8?B?R2tIVHp5SUdtWiswUFI1aTROK0dvZlhPNGlkcitDQ1liWVVRWm5WazloQlV2?=
 =?utf-8?B?VGNFZ2ZYWjRDY3BncjAzVkk0L1VBeXVjZjNQTm1Ubk1TMkFwVGluY3dXajhq?=
 =?utf-8?B?NW1semtDa1BnRGFHb2sxYjNDNTIrZkRCcmM0N0RZYVBoZlhvMmMxR3VBRnlS?=
 =?utf-8?B?MXpiUEZzek9ad1UySUg3bURwZGcxcjBDRFJxV3BzdlRDd0UrNmNKS2VKSjYv?=
 =?utf-8?B?VWxOT1NrYkxRK2ZaeDFHZC82UUJkT25CaFowRmFKeEtERU5GOGU2YTRIdFNk?=
 =?utf-8?B?S3pKeldWZmVHSzJLZGpReUZUUjN3S29BU0pqMDYwdlh6VkkweklobkFoVGp5?=
 =?utf-8?B?NDM2TVhUbGI5dzFKY1NEUkt1ZTh0VzN6WUdmaExzRUs1cDcvNFdNbEVLWS9q?=
 =?utf-8?B?R2k5d1h0bzUwTWMvZGZVY0pad2p4VFVQTkNjUjhMc2c5SWxlWVJ6SE5EckY0?=
 =?utf-8?B?bzVYWnhPcVdEMi9zTmt0bW9tQ0tRTUN1TGpIUERGZUVYSFFUbmV3M2xvQjJk?=
 =?utf-8?B?aU5TNmlpMFZhSCtKUWI0K3hEUU82M0dFMStaNFFObi9iRGRtTlhYWnQ5b0NH?=
 =?utf-8?B?akFkMXBlMmdVZ01STFhTTWNVMlBDZ3ZHaXlOd09nTThZSWRGdy83L2RaTnA1?=
 =?utf-8?B?YXF3R3hXbVd3blhMb0ZkQzdPTndxNlVvQXdWNzBadVY4OWNnYUMvSlRLTisx?=
 =?utf-8?B?akduNlVyUEJ5eWY0T3dENjF6ZU45bHZRUkk1MTdqUlRpZGRMQjRUMEVlMlls?=
 =?utf-8?B?U2RHUW54bHZBbXJEM0JlNTdYT3VyUGQxTWZlcnFXMnBhRHE2bWxkQTNmaVpS?=
 =?utf-8?B?ZGIwYUI3OWN2SzErMTZXQVRQQmJlT1owa2hKaFFwblpKczdhdk4yZWdmejN6?=
 =?utf-8?B?TVZ1eDBpS0Y0NXVCaFVmMmRvTExYL0dPN2hCbFh1bU5sVHFiV0VUbFRPSEFl?=
 =?utf-8?B?SU9tbU5VM0RHQkRsMkpaZkordWcxWkFPNXFmcFV3ZG9OZ1UwNmFZTnFqQzdS?=
 =?utf-8?B?MUtGVktJeVVtZUhVZ3I2TVJYMS8zQWZhWDVaRnFEeHAyd1F3TGtQYnl4Skgx?=
 =?utf-8?B?SWVpZWRleVRzUWd6TjJCTFFjZkVha0JiTWhmNThMUDQ2K3luMjlFb09oWjhI?=
 =?utf-8?B?bnFYS0Nha2J3aTFYY01vR1JFWmxNNHQxdXB1SmVBcDFIclhvV3RzdXM1V01O?=
 =?utf-8?B?M1dnamNpYmlhVDlNSTErS29LaUthbTlwUU9mUy9uRWJHTzhDOWVjNzRTZm5z?=
 =?utf-8?B?aXMwV0NTdVYxQ3dCRGY2b2RSUjBOZE1oQlAraVRNcHhhenRWcWw4WFFVTWJo?=
 =?utf-8?B?VWlJU3FDaG9IL2VENXF0L01uMmJtMWxQMk1vNGF1QW5CZUpJREN6V25leTkw?=
 =?utf-8?B?K2J1Qm1xRHB4NEJ6aHdudFFsNHY0Z0tKMFlPQmpaaHkralJRRmFmSGhtWnpx?=
 =?utf-8?B?eFhrd2dUOVdYdWJ3aHhKa3crMy9qRENxQmw0QzRwU0JkUDdCTHhJVmszZ0xl?=
 =?utf-8?B?ZDJzQTlDc05tWmpCa3JPL2F1aHNEV2MrUXZmUVB6YjBMaGtOZkl5NVZ6ejlN?=
 =?utf-8?B?RWFFb2J6N0Zzclk5U2w3cWxkUHpZdlBVYUtkTytUVVVVRUJDRExoMFlaMzhq?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7424f9d6-5802-4d92-1c36-08db7d20ba9f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:26:12.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnCzaJjS/p4hcoHLVzjUa/m8RZaLjT0fCZOal3jdPKrSOaOMrUfLORPzg452/6id18JKwSjolOIcq7cfAXkF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 06:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12224

On 05.07.23 08:16, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> Since we using pam_passwdqc from bookworm, our current security image login password
> does not meet the requirements based on the below given pam_passwdqc policy.
> 
> When calculating the number of character classes, upper-case letters used as the
> first character and digits used as the last character of a password are not counted.
> This makes our password to have only 3 character classes. Hence we are adding multiple
> capital characters to make the total number of character classes as 4.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  kas/opt/security.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 4d11905..1f3745b 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -16,7 +16,7 @@ target: cip-core-image-security
>  local_conf_header:
>    root_password: |
>      USERS += "root"
> -    USER_root[password] = "Cipsecurity@123"
> +    USER_root[password] = "CIPsecurity@123"
>      USER_root[flags] = "clear-text-password"
>    adjust-swupdate: |
>      ABROOTFS_IMAGE_RECIPE = "cip-core-image-security"

I suppose this should be first so that the build does not break after
applying patch 1? Or was it already broken for the security image due to
the missing dependency in bookworm?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


