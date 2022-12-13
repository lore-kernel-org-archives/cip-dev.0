Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D931C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 13:01:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.48])
 by mx.groups.io with SMTP id smtpd.web11.72760.1670936487413380532
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 05:01:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O345uqGf;
 spf=pass (domain: siemens.com, ip: 40.107.21.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6jQFtsMS7VmBUcz1nIpHAhvBIG3Gk3EVUURYb9E3QUJRs1pWdpB04eAQwUxp0He0y/iQDnuFM9tqc9XvM0FwXTELMVvVc3K+4pV3RLymy+3RY6aUYUkv7B/IEjIqoKTaDStJklAp4k7yWisOMzc5tEaOTKdLIlUoRK7P6vK6HyDQBqK1O0od9CZfBDsTBEoYykBswmIRt9pqDI1oXmr+NoG+S2d075YWpSHZuCJUCLx02uy343JT2stH0nBh8LBioCRqPBfTGpJn5KP+2mKMFeRI8KlePtoZSeOM0sPAX4dpYY8sWarLXG35pAcoqpM8ttHX7d1vC6Bvednmmi/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jZ3kAaAFuOEnuT/Bb++U86d8lP6rCN5OnO9waohlt0=;
 b=HKx6xEXpli7KAnUvAF77oXA73BtseEEy4RP/PNmZM8ASn4ud2u62Wbs8ugZ63fa1lsP3C094nWnfAE1uM0ah+u+WZcLBmcJupI7isiKeyYWMbBtS7+nK8by6r9dVuIinPIBEHN4qnB5o4WP6YZxeQ0Wx1Q4P9iI1qeFChIl9BcRlGWa+w/V39GDBr/H5Ks7gMTj1G+yInLN99bndILJDuZ/fIYuIhna04H3j9AbjuSVriJMCSGHyBcHnMofsaJ+tI2lqm4V2UOBD+aPhNdVGsFnd/8uI+8sTEwFYG8jl4w7NX3anoYBh0hsbEfTbO8IsZfaA0aemaAm4h+dluHRc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jZ3kAaAFuOEnuT/Bb++U86d8lP6rCN5OnO9waohlt0=;
 b=O345uqGfpr7qij8We1TgeAQP6l+CP3KSR0wv4Gls8DfJyTGRYf4GoKJz8TcWE8c7NHJXdgJZSFoeyhQNok3zfBs09zzyad+Qh5k4vUNgpjn7bZsP5S6dws7IM0ljSbGFwvu7QhDdSkMZQbMM0Oldkx4mWaZkFW+WXSFTu3rGL9umFB16X6jN7eGoWos29Ld4tNNPNyuGJ9zS0q6JlZW7AdJcJJ3Y8k2EQDF2Iwp6JlpYaUptQ9n+u7jhuQmS0i7pR8eCHRHdgGTDBH/CCrD6/Chsmkq/EeqhWLB8prPsbLFuLEtNc0LVhRIcH09BpPTPoRt+vThm1rItK6tYaXcaZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 13:01:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 13:01:24 +0000
Message-ID: <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
Date: Tue, 13 Dec 2022 14:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/4] SWUpdate abort on
 installing indentical image
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3143:EE_
X-MS-Office365-Filtering-Correlation-Id: ee80cdf3-f2eb-45f3-2464-08dadd0a236d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ps1otDy/wGDG0r4QbDmoq5cfq8b1OihiWHThxYddNtKLa0YFZUuBmUQyA+Cb2B8oh0kbnlkcX72vWUJtrZX62DwiXRs1yVBm3uuNFLM6ROmCg0/vqh0PYTH2w/QxUuNRU0JxNCnE43nOffbYvJH4QBQy0GNh/YVnBVjRKxP9ZBAceLjNJgVJUUYoJu7mf++X83yxkUgUaajwjIOpxxya0k2WgGtTUPZmlmRpGienWX47oPr00R0AN/Au7QURHDK9KVHdpdWWlaCjP/Rmv83G1IUhqbkgudl/XAiPBdjHorpCA/TOHJYo7MiBO1+X393PwFqQKcWDCOsyPX34RBz1aKod6ILkyhGgOGk3+Pp3FQmtZPfltttlphZh+LqtspaPVwcMdyj5+sd1tjFjYiVsytO6qmug1lJyEbEFJwltbHQpOVw5CM4AkWEZsLdhKu8QCMuF40lLK92osZkrS6ihIcs4xGUFgEb4RxTwjMc5QefqrRx8ztpJSy62aABRgJQ6ox6n22YcAaQo3f6+iUKDSviGvHv2ZawYrTIioM5USqicWJWeNxhIfB4dORgWTpxAXetCe38enFif9Uhr+1hIhN+SwsJvSYZnPD2zvvsdNA9EA7QCX4R82uw+c6s8IptLWqnLA+eb3HY9FLTqV/5wO78IzudCHxYQSFVeq6YymSt+zpTaRL1RW5f+5237ipQLmfPUvtVf6u30VJ2IX8yMH59WoR6RVfY3yuF3+XR26wBdDX8ZgoL87OS7P4owtR/RhIk/wkIDUepunAjJ2FHGNw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(8936002)(8676002)(316002)(36756003)(6636002)(66476007)(66946007)(82960400001)(38100700002)(966005)(6512007)(31696002)(186003)(2616005)(86362001)(66556008)(478600001)(6486002)(6506007)(26005)(6666004)(53546011)(83380400001)(44832011)(41300700001)(31686004)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTczWlQ4a2VzMG9wOVdYbkt0S3hjRmdGb1RsVVFmbXFrY3lNaGY0ZXJFSlNM?=
 =?utf-8?B?a3Z2WURMVWtUVldRSkpWYWVjcmo0QmJPTTZ6dHFRSHhFSnprdjdtN3NrM3Zq?=
 =?utf-8?B?dVdRV1F5dWowMmFsNThJQ0JwYXJmZXJnWkwzb0tGVXpYNkNvVDFBVm5GTjN1?=
 =?utf-8?B?YmpNdzFVc0pYbnI1YU9PT3J1d21JdFNaRHVhWjlrU0RFNFo4RnVjbFdJaFdm?=
 =?utf-8?B?MU9YYlEyOUFOWElDaG8xRXVYaFllNlJMbUc1LzE0TmZ1bDFtRzZZSTNjV3Nh?=
 =?utf-8?B?VkdaaXNlM21BeEpEbWJQR2VOakZtSTBsZjY0dVhLTzlFUlc2UlEwTlJvaGQ3?=
 =?utf-8?B?TDVTaWVObW5RcndJUi9LclBwdVcwdENDR3Z2YmlVbUpHazFOOUpNbG5JZWJp?=
 =?utf-8?B?aXJzSjdhNzk3WnNocENuUWV4YlRKMXJyTGtVR05IeW1sT3BTMFE3QXBKZUhI?=
 =?utf-8?B?QVkvcEErUkozTXVSZDFUQkhkcllOdStUNGFLcml3M214dGhEMkJnUUhVMVl5?=
 =?utf-8?B?Zzh5ZVlaSzh2dWhZWC9VblFsQ0p4SGVVcjdBcDg5YUFaK0dJbnJydERSaEhD?=
 =?utf-8?B?NUhaSVpmWlJaUW82alhQNWNkMVVWc2pPQkJuNmd6eFVoRHlhakRqK1d0eDFq?=
 =?utf-8?B?QVh3Z0F6VW9YdUFiRHBNQlZXODU4VEE5S1BJQ3VBSFBya3Y5TFBVWmVyRkJ5?=
 =?utf-8?B?eXM0NjRTT245TGNkdHdMc092cWhabk1NZXN6TGdvckVFWWl0QUZucTBxQzBy?=
 =?utf-8?B?a2ZXU2JMMU1oMCtVckJDeWlnV0V0SG9IYjNWNXVnZzNYeDd4SVJ5NEhjdG9s?=
 =?utf-8?B?L0R6WU9Jaldua0QvRlNHTDQ3WGwwSGV4c2FBYTI5dXR0QXpYamsrK29wS09M?=
 =?utf-8?B?YWpGdjljUlBESTY4SzNwVVRVMUtJNEF4S0dPWjhzWXNXZ0dOb0VOSzVodHg1?=
 =?utf-8?B?T2xqdTV6T2pNRXpyZUZnUjJYM0s1eElHSHUzOVNxUG9qNzdTU3g5ZGFRcXVm?=
 =?utf-8?B?ai9kZFI3V04rR3UwaHB2cXZGaEllZktmRVQ4d2s3Z3plQzlLMGpHTktESHVu?=
 =?utf-8?B?cGNoQVBodHYyK1YrVU4yWTJNVGtsUk1KY3FIcjdhVW5wbTR6SS91QWgzUWE2?=
 =?utf-8?B?eENPVkV4ZU5uVUQ4bUxGM3RYclMvSi9hV2JRS2taMlhobGlPTlA2a01ONjhY?=
 =?utf-8?B?L0k1cDJMOVBVaSs0NWtqWWMxdHZZVG9ROEJmZXpKcUJaV1NPK1ZnMXE2RlF1?=
 =?utf-8?B?eEMrd3BjbTdGc3VFQ0JuME82SG9wajlaSy9KeDBQSmJVL2tJZDI5MzZmWk42?=
 =?utf-8?B?ak1IQkxVQTBpUFg1ejBDOEhoRDdCa3dENDJuUTB2ZERVb3Z3WFU0YldZQVFn?=
 =?utf-8?B?MVBka01wTnRQZXJ5aktnR3hHQXk1dTBpa3pUMHVpY3RMSGFsMlFLRHBUZ3Nu?=
 =?utf-8?B?SkI3bXE0eURBUW5POUxIRXhJU0JoSlMwYTFzelZaV3B2TVhxNUxNeGpOR2Ny?=
 =?utf-8?B?d25DdnZRV0ZFVDNFa3g1bWRDd2pJV2gxd1FobEFkN0RmNEdtQUtnanZJQUVL?=
 =?utf-8?B?YWM1RnBLd0cxRUw0c3ZucVdadUlDd3FZMmZxSHpxbGs3Q1pydlZ4a29aNHJK?=
 =?utf-8?B?UkdkOEVPWHFwazArS29FeG4reVBZamxZNmljME0wbzlDZ3BBTnloZUtmRzds?=
 =?utf-8?B?NHlCb0x4cHkrYnMwZVUxZnpzaStxdWdVNDZLeVpKRmQvWGxacHlyUHdhSGIv?=
 =?utf-8?B?VWZ4ZzZ6ek9hQ3ptT2ptY290YjZlZGgwV3JiTGF4UlczbTh0V3UxZUVVYURw?=
 =?utf-8?B?UCsvcCs4MFFzS0FJM3hkN0VyUkR5YmsxdG1GKzZaR1Y0VFp1dWxlQjNHc1lv?=
 =?utf-8?B?RnNEWHJqME9memxrTUNLcDRsd3owK05BV1ArZGsyNm1KTTcxa0EwTW84TU5u?=
 =?utf-8?B?cnBucWYzeHB5MDVUS3dkbTZRbk4yNGtxdmw4M2Jzc25zcXM1ejIvanhkbytM?=
 =?utf-8?B?c1Z0c2pWaTRmb0h4dTVXY2EwWm9GaEliWjUxK0JnSTNoOVg1UHgrdzVhY1Fp?=
 =?utf-8?B?NkpSb0VmajEzVGVqQ0FqOVIwQ3p0RFk4dEhNSUNWV2hHQWJYNHgvVll5UjhV?=
 =?utf-8?B?L2s5RzFJTkpOYzZPTUpjNTROVWs5bVBWa0tjaVorb1ViR1doNnYyNy9JSlM0?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee80cdf3-f2eb-45f3-2464-08dadd0a236d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 13:01:24.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWyXiF0aCmU26MwvlXTe5ytJ0sogNreplrW2bhNYUAWYzCSmzYL+oNBs6PmnJSHHhA06sYqD3NhqHbqTUVGHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 13:01:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10215

On 09.12.22 15:58, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Use a pre/post function of the SWUpdate handler round robin to check if the given uuid
> is already in the current root file system and abort if the uuid matches.
> 
> This fixes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/43
> 
> Changes in V2:
>  - remove RFC
>  - Use upstream version instead of patch
>  - add comment for variable expension
> 
> Quirin Gylstorff (4):
>   core/images/swupdate.inc: Move image_uuid to swupdate.inc
>   swupdate-handler-roundrobin: Increase revision for configfilecheck
>   image_uuid: read target_image_uuid
>   recipe-core/images: Integrate configfilecheck into sw-description
> 
>  classes/image_uuid.bbclass                    | 19 +++++++++++++++++++
>  kas/opt/ebg-swu.yml                           |  2 +-
>  recipes-core/images/files/sw-description.tmpl |  1 +
>  recipes-core/images/image-uuid.inc            | 12 ------------
>  recipes-core/images/swupdate.inc              |  6 +++++-
>  .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
>  6 files changed, 27 insertions(+), 15 deletions(-)
>  delete mode 100644 recipes-core/images/image-uuid.inc
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


