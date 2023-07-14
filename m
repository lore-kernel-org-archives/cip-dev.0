Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4FEB64DA
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 06:10:21 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.52])
 by mx.groups.io with SMTP id smtpd.web11.12813.1689315018213570500
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 23:10:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eI8ig40d;
 spf=pass (domain: siemens.com, ip: 40.107.8.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8zOcVbUMjCo9zGqn9eoeynxXHDjLjVqn0j0Ljfc20De7qbWtsucJRrc43w0v+caOQgesdFYLc1JUDiEWITTgMRS3yCWK/IUCCyjLLcbJuBT++HvEF/YSPjuRDh28T+dDvyFmPSDbtJWwVit5VPPoT8+sU8VAbYDqUlZELcRRyaStg48TF+O2ngwlhRP72U0pWmy36+6U+5uJHBCzfMnzyURDuYKSG95WENUiOWoZ6T1cKMoZsJiroGnqYOrhJud3eRxUdiWEaUzscpA/y79zU2FGPBheFro7RGxaNdy8m/Tt6Tnw3HP+rSbZp08Yl2NS7NNeJjbStqJmsDMj/vTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsTVfLisqV3P+Kp8se3F7kB0pL2fhpM9u9gB1NGXjnI=;
 b=MQbYcuRLpRucjF8JpXWlre0THyS03S0tEiO7oLuyyZxbjwLT8TZG9u6OdTGckDjJkYZCuXletY9clO7Aus5ygPS20edfFYLcA4440yXwnjAPrKnTW3mYQPi0SPKZV+6qabD3yNCdCFUd/5MnTXXECkht1KH9rpnWVbywt7XY3cDe4Z39NbB3QOiPd8QXAFSsxlfXFweWGdM/RqX3g5gm7rUww68h7voU1R0sqLBwFPfB56zuiNWmh7YZeCo8fRJB1sDVOqHu093d5KcGhT7HTSlLJGuhJ7obylePHkT4xegSVoF9OVZu3knGR9bz267RfPoD1UiFHRsrm9XNQOGzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsTVfLisqV3P+Kp8se3F7kB0pL2fhpM9u9gB1NGXjnI=;
 b=eI8ig40dHKKV0K6FZJAbnKY0i8OaGmTY3eIzjCCh9Kbm2kbYv7WpIPIy8kbNGR/MB9b4Rdb5cIDwEDXUA73T4dpD/U9Cc7qFnpChvXDymph1u4ZdyhqhsMzTdnztXBZPZMLOIXY2XovPYikgLFybAX59Kd0rOqIhDKSftqB0bD/Da1+M2/zWHBMjxAgkBAmeaUkd9tmx5g0jrIe+N0C0oZZXukb+JLITLdBMIMkkdgDGM+dthK8oI1iQ7AewS0AAnGFl5hZp/Lg9lbdyZvb9KCQ3tV8r67bEXs/PqOov2EXiLwIwXqufxczUP4jmOPTO3NX3BLJPD94BsF0UiZHALg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Fri, 14 Jul
 2023 06:10:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 06:10:15 +0000
Message-ID: <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
Date: Fri, 14 Jul 2023 08:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core] security.yml: Add additional features to security
 image
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
 <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
Content-Language: en-US
In-Reply-To: <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa82840-155b-454c-c37a-08db8430fd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A5a4g+5FfRapblvzixzSTEZGrHOoU9wK3xIc9S1J0rD1TLwTZ1u6aAMgoMQY5lT2TPzlxgUv73k2OuUfciH81/ryFrnJKpGWhZJXAFHXuD5hFElzNGPNu1Zbv00WEwwiJ8vfjTZbs0bIiJW0CxYn03RjtYf+0HhQrS0Hyb6C4lj90jEC0s5Vv3L3qpBCzHYv2wXZy03UAtCg7TJUNe6ZYyU4CQ20xuHGia0SxhmTj67J7BMx6XoK/T0TDeHSfJ7eERWZbrxiD/W2irIM1ydHs2Wpfw/y+CnmszITaZjCUgOhiLrScna0DAOSyVQZNUJBpmzuSbieI0d7G0+3uwQ1AtwUh4KSpyr8baVr0GWzAfJUjLeVZcbLEnfanSeU+jsSP0+6XAwEqeRKd6GQMGjmMnPNZBaK2R39Ga86G2BTpf5BDC0bluhVsSmQlRXhaejAlQMRk1M0xeyGZ+aCzuqc/Mo/d5c0GTHF4WetfJCmRxVbOnvxUTAW4WuvwqKDDseSytXko7YeiWP/r8HgazQ/hGFkIOG6tbN7YC9Df5ngJo+MOD+iDs7O//WoaVDGVIQRS5LtKyZaS6Y0pCKXH5VwoZbNFf66uGqVOjeH4W+ej73k5T/eZ5miOAWt1VqZrK6P19ifivvdJwbCfAtq5wxiEQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(83380400001)(2616005)(478600001)(82960400001)(6666004)(31686004)(186003)(6506007)(53546011)(26005)(6512007)(4326008)(66946007)(66556008)(41300700001)(86362001)(8936002)(316002)(66476007)(2906002)(6486002)(36756003)(38100700002)(15650500001)(44832011)(31696002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1FqUVpMdUxlYUJNN1Zab2wwMUlFVHY5dVhaZjlNelFhcFdBU0FkTktNL3RH?=
 =?utf-8?B?UVFTR3VFV1dpK1E1QWhlZHhmNjNJbjd3NE9jT3J5VWxUKzdQNUZReUp4K290?=
 =?utf-8?B?YlVHZExjSUw4bkJybTFrMFZ5YmtsaXVNN09sUWJ5T0RleUF5UUtkN2ZRMFl0?=
 =?utf-8?B?U05JQzR1eXZwdkx3OUJ2WDNZR25TSXF0YWVNdWQzMWt6YnAza2dwTTRlY3R1?=
 =?utf-8?B?dStYTDZTdWIwS1JNQU8yMUlvTG1SdlZVRjNBQ0lKTlJlMElCTnFHeElaVldn?=
 =?utf-8?B?NlJNcW5BbDJHUlM1MkFybnJuaERpMlRPYlQ5UXpWWm5ldkZCY3Z6eEdLRmJ0?=
 =?utf-8?B?WFo1L29UaWVqR0hua0Z1UWlENjYzOVhSZktvUlQvS281aC82SjFHK3U4NjJs?=
 =?utf-8?B?SWZkMVRkZFcvcDcvbC94Wmsya3hjNnZUdnRWdnVyRnZzWXk3RWxWYVNxRWZp?=
 =?utf-8?B?NGN1NlMxMlg4TVRwZk82OU9BbHpnRmpkWmtja1lOa1ZBQ2hCQm1FbXA0NGpi?=
 =?utf-8?B?dzc5Zy9GM2tBam1pdTRkZmtLeCtHd1pkZ0hTRHVPRXNsa0lDdEhKTktOeDhG?=
 =?utf-8?B?bnVLVUFjTUZuZnMrbUZJamhXMDArOHVVbmoyaDJKOWRxaG9jTE1MWENkdmsz?=
 =?utf-8?B?R2s5RkxrSEV3Q3hLTE5hM0pacDd3Rm1FMEQvZ3NNTjd0SkVVL0Y0Z0FaVnhB?=
 =?utf-8?B?S1VMTjFsMnFqZjFKNGN0U2xub1QvSTAzQzgvY2w5UW1WSFVhWEwxL3BTYVl0?=
 =?utf-8?B?a2VSaVRia0ZESXRlbHVqRzV5NE1zUVIrZythQXg3b283cTB6SkFaVXZGVDBH?=
 =?utf-8?B?cTE1MmlidDgxN3BNNDBTUUpsZEFtZ2c5aDlvYlVBT1ZuT2hIUXJOQjV0RU5S?=
 =?utf-8?B?K1FZSFU2M21QY1F6UERvQ21MdFRGQ0ROcWJIZWJFa1M5cUFPanZPdjkrenRR?=
 =?utf-8?B?bU8zMFBadEpsUWQ0NkV1MlE1cUdKaFJPUENnTlo2VC9lUjFNbUxjZUx3ZUlS?=
 =?utf-8?B?YXhNWW1wZUQ0V21aVkc0UkVBOEcvZTFrNDd0RVhPUlZEeGtmTG5XR0txem9y?=
 =?utf-8?B?YlNDczRyS0xCMm9zNk9aTGZ6TXVvWGliY2pOOVB1UGJ2V2FWZEZuTzlZTXpZ?=
 =?utf-8?B?QWtGSDl2bXhEcWwrYmNwSEdnTTlZWkJ0ZFZ6NmFzUXdlL2h2ZjJHckZrNEFV?=
 =?utf-8?B?ZUh1ZUJJZlhCOTFhS2NSWWpJQXN2MWYvL0ZUemNnaTQzeGNHRXJybUhWT1B3?=
 =?utf-8?B?OFBHelladmdtcmQ1NFVrakRqb1NidUk2c0xFWS9Nd3BraS9uVjh0M25FWSt2?=
 =?utf-8?B?dWdkS0VQZDNPL3hnNDZoeEJxaFdlL2NucU1rY1BtanBCR1BLNzVzL1FZWXpq?=
 =?utf-8?B?WGxTZWI1Mm03SUs5aVlib0k3eWt6TXFFai9MNXREY2VHRXFDVlNKOE9HS2dS?=
 =?utf-8?B?Y3RhNFRYaFFucGZhbkJ0UjQ0VWprWnRzOVl3d0ZLL1BoUVFCdklUb25VcWtJ?=
 =?utf-8?B?S0dHL25YWjZlZXhUOEtIdHRLS1E2NER3RWlncmUxS3RWVnlrVFpaMGt3ZWhx?=
 =?utf-8?B?bkk4YmRGUHlaS1NrS1lZV1lQRThHZHRHeVl1YTEyYUcwOHlSMnFhTGJvSyth?=
 =?utf-8?B?MnlVNmk4TDhQVFRacUVpbDZZUU9HajhYSlJvUXd3SzNqU3Rzbkw4RVFhdEdW?=
 =?utf-8?B?cGhIR1ozaENVcEpoM21qaVpuRWxlbkR2bzVkTVNuS3lOM1ZUOTJDUUp3Wko5?=
 =?utf-8?B?cDlXd3loRnRyVGpWczBCMWFvK3ZZeG9tNlNUUjRZMEZFSXdDaEd2UERhU0Zx?=
 =?utf-8?B?V2c2Y00wUW1xUUhacHNOaWk1MC82Z3p6c0ZsYjlFdTQvRStFc29Na0xHNmNK?=
 =?utf-8?B?UEhPbmZYWW0vRzQwZVJrdHo2eGJjSmVscURNT0tIcmlMcUZtdGt6Qy9HaEdJ?=
 =?utf-8?B?YmVUaTZpZjBVWWhTYTdIZXZtR1Y3VlVyV2I3V09YMitPVEIxaXZ5amJUcWc2?=
 =?utf-8?B?OU9DeE1DRnU4aGhvckc0VzlxMDFYamVGQ04wb2MwQytIcSs3VHJyWXhtSUVn?=
 =?utf-8?B?SDMvK2NyVDBBRXozdjVLVkRENmYvcUFtTkxMaXNqWjc4SjhHMmZrTTRxUWpY?=
 =?utf-8?B?cGlEcG9zdG53UHRFaXF3aDJ1SENBdnhDbUQ5VjJtVG16SnE1aWVKSmh5MFpt?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa82840-155b-454c-c37a-08db8430fd7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 06:10:15.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: athjFiwa/ILUuZD44t61jdDaP8K+brJeUZ03s1SybkHd1BNcyxppu+4oLFwkbcIHV+0VMZGEVRdMy0+FvZ2VJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 06:10:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12341

On 13.07.23 19:32, Jan Kiszka wrote:
> On 12.07.23 13:31, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>
>> From IEC certification perspective, a security image is needed which has the below features along with security customizations.
>> 1. Data encryption (CR4.1)
>> 2. Secure boot (EDR 3.14)
>> 3. SWupdate (NDR 3.10)
>>
>> The config.yaml will not have the extra enabled features as true. Hence they
>> should be passed in the image run command.
>>
>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>> ---
>>  doc/README.security-testing.md | 2 +-
>>  kas/opt/security.yml           | 3 +++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
>> index c9540be..97000da 100644
>> --- a/doc/README.security-testing.md
>> +++ b/doc/README.security-testing.md
>> @@ -33,7 +33,7 @@ Save & Build
>>  ```
>>  # Boot the Linux image
>>  ```
>> -host$ ./start-qemu.sh x86
>> +host$ SECURE_BOOT="true" TPM2_ENCRYPTION="true" ./start-qemu.sh x86
>>  ```
>>  
>>  # Copy security tests in to the Linux image
>> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
>> index 1f3745b..b21f330 100644
>> --- a/kas/opt/security.yml
>> +++ b/kas/opt/security.yml
>> @@ -10,6 +10,9 @@
>>  #
>>  header:
>>    version: 12
>> +  includes:
>> +    - kas/opt/encrypt-partitions.yml
>> +    - kas/opt/ebg-secure-boot-snakeoil.yml
>>  
>>  target: cip-core-image-security
>>  
> 
> Thanks, still applied for the release.
> 

Artifact upload was broken by this. And the should still adjust Kconfig
to reflect the implicit selection of security.yml.

I'm dropping this for now, it's more complicated, likely too much for
this release.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


