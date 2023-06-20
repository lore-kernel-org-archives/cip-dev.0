Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F90AEB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 17:03:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.51])
 by mx.groups.io with SMTP id smtpd.web11.1460.1687280633459845687
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jun 2023 10:03:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DHBKjtOm;
 spf=pass (domain: siemens.com, ip: 40.107.20.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd71PJ2ryQZVHCvyrr1UcFAD/25nxSpPfN/nkxqHVJzxFFnDn7iZXGkpBEpgK/I27LxdAJ/IypWTpAOtfMw6XqxUvH6vgmkOfotxIjzT/qg7xzaWkXViHuh8tIi0Q0oxfD0GcNNrpgdxSDRhV8m4caaCE2YG6LC6NQaFxHKbaQKsQ8c04vImiciHINOYirNavdxwL4ui4ExKZ9hlZim65nG/VD6Bovydqhvr1bKZTHyGKQT3c8zT/vnUHRf/8gBdjmOD+BG7dz7f2JOVFvR0ibmxAiHDNNlpziEd0oVnrVakUutqoiOZCgyABSW3WwzYtBiP6hEb9LdP0DiDbgMhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm5yPOtZR191jjH1kRrUtAFEig24XmyDK0rwvUpvfiM=;
 b=b7gfFyjrusj3WC5IuZ1xesOshn2xi/DnbOEmMTAJyaZVR4R2nVSdfxUtPwiqyisiZL18Xk479oW13xyRbTncbqWzPUJbKpy8IjuunILIGArNVeHqPsE0SeS5TaHYJSyUR2/UidV/w2JuvxFQszVCcCnJ4H2LYl23/9J1yrT/M1x4MhNxmPUdzhAyNRoBQgigqXUkgiU4S7Duo2sz3rCixWHZ7DgyqnPSl+hcFOrupE9L05L3p3OQz3Zfm99MB56pxsyTQjnUuZ0oQSPM1YE7WmoBKE+7cBo7b4tUPXLzq4hmEDLSWwp1pMPqzCTavMMxRt5up/ZZwi/t9D9mjzrmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm5yPOtZR191jjH1kRrUtAFEig24XmyDK0rwvUpvfiM=;
 b=DHBKjtOmbgJPKXqasiHz2P6bZqFkxd1YbNa2LR+jHzlBXG/faqykJ5qPeKkk8wnuQnIZHFz/gTrih48eetP1KQKPCCSKSoXRjp4USjurgOZnxabbpnWTA5m04FCe39AKkDJ63qyD/UobkWZi1bFdU6HIa0jJcbMNn+PHM+hK3HYKS5/b3p/Xrr8edrO+OFeE6mEJkeBhHBf3akgnwPhiq58nJojZcEwn7Vo+tCRQomlMbcyYoZq/EDk/G4wEOuxA1E1V8559KKUxHrwFvSYbVAAVhn4zTw2su3lUWjs0miz3yY0uECPwBZMZ+R3RpTM1Ew/XdCfPNXtMiqsegPh7Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:03:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:03:50 +0000
Message-ID: <ab761cf3-2792-b05d-635a-fd5ff5a7991c@siemens.com>
Date: Tue, 20 Jun 2023 19:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core] kas-cip.yml: Update isar reference
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230620135657.4585-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230620135657.4585-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:610:20::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: e770835f-339b-4b61-43e3-08db71b051de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1H7i7FpIAqDbcEMCFc0PtpeW31u3Kitl3b0CvnOnKzCnfHNlvE64LhlrFWPPu4ZIVS4uZsDRg+CXTVK6t5qdzrtIKGftgzgcs9gR/QtCE0i5II2yN1nFQpddAnL5ipLY7K2QXL8ZOXxxajz9zmTRTJed4+Pvw1YN+cEKSEBDRoKf0+QVPvkfoKGEsqlFq4yj+d+iRvPeeKBG300DlzynFqOXdD3zJjfn3XRlW4gpYr7XVP+nWmTg4TkvMABEn7+e0p2e3gdWKGNEx6tL1/U4UshMics3QMJ7QRBfQi5/XkXQquOQOS7fDiX0gpoKclYaaWZCoGOW7fwNvPq7opVvFLdg4nNo/O16eCGviWXchA4xsAgnRzykJEO1HhSt/1GHr0vJsjGJLNAA4ULUskjOJZ8TLOC6oOmjTsEa1ly2TT6MRwbS/EsrjDCHtsvYvzL7c3aRN+EP2b5kbSuRuDzogpIcgpMzyvIisqZU/EHsF8NEPWiMCJ+4XXNnF0aqjbV0DfHdhGsEIELnrlWcs3Zd4LE4SvFDCLYeMKt0sHOOoRolYzULb/7+6xEJRkuUViEo5e8jkk5dQR640wlPauEIs5zkT+I/SvxVj1NcKb4uWNr0vtE1hq9/bNQczb5WbEeJs77m9LNsSfroiVNbGbHYOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(66946007)(2906002)(2616005)(83380400001)(8676002)(478600001)(966005)(6486002)(6666004)(5660300002)(6506007)(6512007)(53546011)(8936002)(44832011)(316002)(66556008)(66476007)(4326008)(26005)(186003)(41300700001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTZORHBxMzg3WGYrVktjNnJ6Y3hJNWFWUDBlSGFWKzVEcFNTRTVaQnd5UGgv?=
 =?utf-8?B?eVk4RFhSYmFEVW9EWXMxRUxhYkgyM2I5WXNMS3NoVGl0ZTBKVVc2THlGN1lS?=
 =?utf-8?B?MklHNWZ0cGZNV0taT1NVUEt3SldPZ0pQOGxYU254T01xSTdyOVZVK0tlZ0d5?=
 =?utf-8?B?L2lHenpydkEyZ0pJbkR4b3RZYmpPSitBcDl0eVpIL2pSYlJ0WFRTK1A3YTdG?=
 =?utf-8?B?cVIwcFl3Z0RrYVY2TStBa1JIc2RHY3BSb0RjNlpGUk5RbVlENEN6OGQ3UkhS?=
 =?utf-8?B?S2dEK2ZJTWxPZEREcXBaNk1xd25TMlBJN1JmTTM2ODFjUlNLSkxTSklMak0v?=
 =?utf-8?B?TTA2WTk3VGxCY3ZRMGh0K1p3aHZzNXd1bTA1eWY0M2J6K3pUQTZCaC9NYTc0?=
 =?utf-8?B?dDA3UTVITXVtbWNCUnpST0EwbHY4U1hBRlRIT1ZHOFpBOGVQVllQNHVpeG05?=
 =?utf-8?B?bWV1d0JsL3M1TFdMM0xnQzBvc1hzS2xRTEpFU2NNVHhoU2pCZUZWbTJnZit3?=
 =?utf-8?B?aEUvYU1wZmJTb2RQRlhDMnhMNTdIUll2RDRHU2RoUjB2WU1zRXNkYXV5ZjJN?=
 =?utf-8?B?OGxuNDNUdTNKNDZJYTVtbTJNOWpXbWZBTkhzcEpUREdwQ2w1TzJjcUJNVVcr?=
 =?utf-8?B?bUhRZnB0SlFWS2J4djd5YWNjclFVbW14OG5yeWtDdHNMaURmZUp2TG1pK0Iw?=
 =?utf-8?B?Q21VVWhUUmZhdUJmVkZLdzg5ZkxpeGcrSkpTWCtOY2t0YU1qenlxQlpCTDZI?=
 =?utf-8?B?RUV4K1lHckhlSmZjWGdzU3JiRUZ5bXBTUlY2OTU0V28rUllmQTdTWnpMelVJ?=
 =?utf-8?B?L3dBTTlTRk41UVQ2a2s4Q0NZUDdPOWtWOEU1ai9qa2VPZHNtN2M5dmFFd0Y0?=
 =?utf-8?B?Zlc0MTZXSUN0SzRXeGpEM2ZIUTB4WjJUeW5TanlsRVpNT09KWmxERXM5Zkpy?=
 =?utf-8?B?ejVJbno2Q3IrSU51SCtNMG1VRytGWWFTekJqQm5qY2R6UGpKckhqVm4yaDVl?=
 =?utf-8?B?ODRrSSsvOHZ4ZlJDcXdmRTVEREpyZC91emZRejF5ZncvUTB2TU4zOWlJRDAy?=
 =?utf-8?B?MncrNldjZ0puNkdFUGdhaCt3RGpMbnlZZ29KckN6ZUNNV3Q5K0VpRThON29t?=
 =?utf-8?B?eitxQTZSd1RPNlkvVkF4STl3YkdKaHFNNEVxa0lsUHd1L3FpWUdwMnNtbEUw?=
 =?utf-8?B?NDE2d0Zrek5yc2VkNEJBbmdBZUNSN2NvRTJkb3ZKc1BCQkNWV21DaGVvaDc4?=
 =?utf-8?B?NHJQcERYNTNFZWtnZzh5N2ZsU09TaDNmLzVDY0JpYzIxblQxNHhJU2xQZnA0?=
 =?utf-8?B?TGJvdW05ZUFhV1dFYnB4U0xvYnh5MU1Gbld4L2hnZEd3TTNGdFJ4SVlHNlZl?=
 =?utf-8?B?YVF6Y1pOOThUTWgzRnl4SEx1eWNYWFpHRHQrMldkRGNySnhVT2tMYUZ6QlIr?=
 =?utf-8?B?NjIzcENwd2JuZUQ5QnQ1VHVFVG9sQmpGQjBtbnVJeVpTYmtlaWM3VXR1RzM3?=
 =?utf-8?B?NkhmTkExK3ZaRTBwTEFQeEVNRGpHQTZvcFZjYmhXcytsQmNkT2V4eit0cEdj?=
 =?utf-8?B?MHp2UkFvMzkrd0Rlb1ZnNC9EUmQ3dU9sUjBMZ2x0QjJDQU13dkZzb285OHFu?=
 =?utf-8?B?L3B6dlI3ZTZ6ZFhucXF6NFM2OGtaaVZuUWdnZmY2c3NkZXkyQUtiWHRzZllh?=
 =?utf-8?B?eVBHdVZOM1lmSzdoTUVVajF5cVBsK0d2dCtPT3pheDZRZVFVL2dBeHFHN2ZT?=
 =?utf-8?B?SVZVdEpycDY4VmRWQXhUMmlISkRBaW0rRmNvTnVoY0pxTHAySjF0THNRSVAr?=
 =?utf-8?B?bXhTc2lzWDdWL1daaE5xQ2d6NUdIQndvWnZhbzlTNEYrRkxEL2ZsVldsVnl3?=
 =?utf-8?B?OUtYVEs1cTVTZHFuMWo4VHV2c1hKTkkveWZQbFVzdnBTcU40eUk4Ri9IaUNY?=
 =?utf-8?B?Q0J0SW02aEptdk54MjhsaTBCeHVVNTJNaVlZdzVkT1EzdERFc0tPTHY2N2FT?=
 =?utf-8?B?S1NEMTRLaWxWamI0SEdEbFVMaW5HL3RBM25pQUZLMkNOSlhUczNxTXdwZmxx?=
 =?utf-8?B?eS9PTjBBcjdTaEwwUGpvMnQvTS9MMndXeldEd28rVExhcnpaV1VsZGI1RHE2?=
 =?utf-8?B?V09ZclM0ejNzNFNtbkRKRDBUbExQS2VMZkJTOFUvbDNZRUZmSGpNY2g5ODRQ?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e770835f-339b-4b61-43e3-08db71b051de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:03:50.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrNG8sPCBBbDeLSPIpFo519xbeXUz/Nd7e4wdCe5djJ9j9FZomn27qysFnTckSjpVLMSSX1ef0bOMtbjrvgG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jun 2023 17:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12086

On 20.06.23 15:56, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> To bring the reproducible build issue fixes from the upstream
>  e.g.: vmlinux files are not reproducible in case of arm architectures
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index b6a3ded..454fe04 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: f95f69d3b83cc28976ef81eeefb5ec5dd17e544f
> +    refspec: d2b961746be788f0f35f8297ed3a8d2292704a4c
>      layers:
>        meta:
>  

Is this urgent to move on? Or should we wait for the Isar fix [1] to
move to master or even beyond (there are some changes coming for OP-TEE
& Co.)?

Jan

[1]
https://groups.google.com/d/msgid/isar-users/892c6e34-bd87-04fa-1155-dad3fd060b93%40siemens.com


-- 
Siemens AG, Technology
Competence Center Embedded Linux


