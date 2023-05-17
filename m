Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6921C77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:36:20 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.64])
 by mx.groups.io with SMTP id smtpd.web10.53412.1684337774464983961
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 08:36:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rt0t7iu1;
 spf=pass (domain: siemens.com, ip: 40.107.249.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDy2YAMe54f4eGJz8ETQvZFURQUoP6BhYsWT+rpu5PH+BaUvnyvbQoVja0SFy0Psug9K6QwaVOc5xag3WS5//j75RKmdk7CV49XSo2yQwA/R4A5SA4pACJWmDEWE27JUlcVmZoRrpPpmHQ53UACbe7bzdtseizaQ58kcNaqHsK1V1f/7b1KScL9IbPE4ZpHv2oyzmQ1cllU9vgBzTTr8IuE/VlIPq+XwBd0R14GZb4SLIPx300nVJhn/ZhI0vwpW4pDZX8zKC91pYMI93yyOV8iUJ9020Z3JJNeb2RuvUZnReRyeDKMMvTMuGVJlSEVmfem1y/ADi7AoOTn19MhgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R85FlDUmah57YTJRGtnyWemd591EQPwgrJ/MnlV4Fg4=;
 b=MZth4G1Oo++0KbTsHLuFd65WWg0HJHvrjSAhnR8OgT/J2PAj3tHUYKQzNfHwljOGbSONzUyQPPU9Xnsl/IXeRmBL8GpMm6ZDoMpU4PJFDHR+VODoP8QvLy/FHprS+yJlefVglaFgdDk/gLb+VLQekQshNzh8nBq25oyhKmFgwjdAZEYt3bAvZLCRnjfA8refdB4EdHUWIcAo1Z9Qt59eFhlYqHPRXbOpHOE7oPjoF97dv0an2EMc1y+A1BFwUJSk7/+Xpc4Ff+OH+EUnxYPJxoWVqOswCevsKciJkIaKfkZnQUmwQaGjmlwg1cJ+ml5KgnPIyWJoM01Ptm72HFUzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R85FlDUmah57YTJRGtnyWemd591EQPwgrJ/MnlV4Fg4=;
 b=Rt0t7iu1qS9QoEM1d++ZmrjcrJjRol4O7i5hwT5WCrhAdFYHKcRSzPekiumBclnuJZRu3IDkaG99QGyt+4EL6ZwXeNeEs1gCaktFMiWwy1REGf+a+ug3DrMIf9MyHeuYUKPiXyiIfFBLnc9X8NZvwMBi/bWm5od6QWD9PkXRR7VS/pYfV/QWbG1SIp8FZ6fZPlKi5OHMxptK0z7GI47nv7jWK3rozqGvQmZCvoem6uagcQuJDapKobC1tFQXzHY+KpRsalbvIP/fAAmKVrsTFj0BrfSgvsdEk66sDMe8siPyqbWdhxBmvHzntHzLo/CRhkKS9NVyPvClEOP13HmJ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 15:36:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 15:36:11 +0000
Message-ID: <547a0376-7793-60fe-60d7-1095f32a27f9@siemens.com>
Date: Wed, 17 May 2023 17:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-crypt-hook: Fix Error
 Messages in case of missing binaries
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230517115722.1415937-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517115722.1415937-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:610:4f::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 70433d79-9bcf-425d-f1b0-08db56ec712d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qa0m/5G3C9qfD/a8j5lVp3FWmwGLBMFtQVXVS6if0hFF1/XViMmdap8RJkQELP9TSuslLzyGIriPV7IIF6TYthgVIPW6Qw22ASPKDK5r9BGNFBEuT4l15KCo5sTfETzdF1zgPC9WK5oYDq30Oz6Fdj6Dj7wgAqwfa5zwporWDkI8pagsvOeBfQ3Lp/gUDdGAz3Y9Li6EzEQCrGvvP27lys0tQ6SwR2D2Nk+zYJzmX8SxWT120XRhtH+Iz5fLjTRFiHq8FriqRteNn4rKfatmgKLz+Osa3DJbIaORLC1U61VvDI80347Z+nmKkpewi7vBrzqoQdaYiFx+sOAYLH+9dztoBVkPNyYcoemhp9gEadKYQkE0ryZrve2iYVMF9BdGoGPRzEBo7xHE3FZPJDyfE1U/ZchS113Fr1JWr+aoia8JcV/GaTI2MU1E4lRFD4pTacBNKeBy8hzZL8xmG/9lLORQdxnYq9gQsRTHkdpgj/XlcxyYFGUUfuwy7s9N99g3e5mPd9pdL0gVwooQODZVtgB2Ajsl3twotf44xxImBlDViXq7SsalwrkzVAXDKpJ7UqMGXE2PrZFwUZMUMgExd0W+SLYsDwX7zPCoRslC/J0rBfBuN0NA5Sxd5AlnBEJpji5eychulVWT4T2xJW/S2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(31696002)(86362001)(6486002)(36756003)(316002)(478600001)(66946007)(66556008)(66476007)(2616005)(6666004)(44832011)(5660300002)(2906002)(8936002)(41300700001)(8676002)(15650500001)(82960400001)(38100700002)(26005)(53546011)(6506007)(6512007)(83380400001)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGpsb1FjemVjVmIvM1JWWXB5U0NRemZBS0pPcFVYZ2ZVaEJES1k3U3ZFbWtS?=
 =?utf-8?B?aXlKZ3VCMXdzM0d5aCtlWmVIRDVTSW1EU3JpOCtGQVVuZ0srTThUWTZyWjMz?=
 =?utf-8?B?SjVGdlFXSGwzaVFyZy83UEZ5a3luMU1mV0puTG5JaWhVWDRDRW5qR3loMWdi?=
 =?utf-8?B?VjVraEtuS0VsNzhRdXcvbGxMNXg3YTlDUi95OEpqUWhNWTA4U0FOanJHYVRQ?=
 =?utf-8?B?ZUtXSVNLOFBkck4xWjR6QVNJVzNPbjBDUmNETWYyaWZFUDQzUlk5c29sN3ZK?=
 =?utf-8?B?SVJnS3NxcXUyeFJ6NTEyaERSRzFTK3lMT1p3cEpnY2E3eWpHVDdlcjM0eGJ1?=
 =?utf-8?B?NGpOaXR6Q2NDZHQ5MFMvU1gyblFQZFYwaHFHZ2lHNUdrVU5tenVsVWcrbnJP?=
 =?utf-8?B?SjltWklvRXA3WmxpcmJTanVra1NPLzdiZDdKVDg5U21Tb1I4dmdTRnNZNlZM?=
 =?utf-8?B?TVNnbzROeC9IRlZrcjI5OGFSWFVxTUFPek90OU9kSzhpVEF2Y1p0T0JVYVF5?=
 =?utf-8?B?cDlpU2N4QWw4WWVoMnAzZHlrL05HMXFIbUpiaHJPOTBNNVN2VjJWY05YQlJD?=
 =?utf-8?B?VHZVT0x1bERhbGRHcEp4VzZOK054akJ5M3NxTXNHNFJYK29QZVREamFIL293?=
 =?utf-8?B?ejRFNzgwb3hUelVLZEFrQTJxakFjNFQvZjgzZ09GZXhoR05kL1gvaFJ5TlJJ?=
 =?utf-8?B?R0FlS1ZUK0kvWmhhSTlJU1hpVmlZbjhQZ2g1eFpPbFlJYSsyajc1VDRzdjRX?=
 =?utf-8?B?L0JzaTk1bWV1UHVjOURXYlU0Y2lkK0FYY3Q0NTUzWVU0MUM1d1BMWkh1eElT?=
 =?utf-8?B?bC9pdE1zc3phYXUyVG1IVlZqOC9sR3FOK3Q5NXhkZUJOTzdpRjRTaS83bFA5?=
 =?utf-8?B?L2Z1bGwyN3U4U2l6MW9ocXh4UkprOFVpRENDMjVuRlFES1NiajZhdysrRWRO?=
 =?utf-8?B?aEtIMXZJa0VJaGR4MWVScnFvKzhtMHhtV0E5NjNMN3dLL3UycWc0dHRzaFZ5?=
 =?utf-8?B?NFBoL1hRcXp0OVFLbjlZODU2WVM3eFhXWEM0ZTQ0SEdIb0U1NmlNMzNJR1R3?=
 =?utf-8?B?QllNOFErSHJ6aWpsOEpCQjEwdWl4S1AyRnk5ZDAvVWZ0a1piL2JrSGZRemlH?=
 =?utf-8?B?VkdGRDlGdjBSVzlpNTdMK3BpcWticUpRK3pMUHprZFdRbmFKQnlVK3ZLSTNZ?=
 =?utf-8?B?SmhTQnBKS2srL2xOQzM2ODF1SllKVVEzNFBVN2o3TkdzRS9NVmZDbWxBa3hr?=
 =?utf-8?B?M0lLVmdXUHlwSzlsZTlOd0pWVktWQzIyL2FodlRUMFBCT3M5TlA5Ulp6S3l4?=
 =?utf-8?B?ZVQ5clpackRyUTI2RDFZdTZQdXVLMHRQaXNHa2lldVdYQ29UVUNpVDVhdllj?=
 =?utf-8?B?Ris5WEhwQmNoVGw2VThRZGJRUk5nY3NtWDRsSXV6T3JCRythTjRrbERqSThD?=
 =?utf-8?B?em41UEVUUDQ1QTJvNmZUWTR1VzA3OC9vK2I4aUFmU2ZRVHNjTjFQL2tXWG83?=
 =?utf-8?B?YmdSRTN0cGR6YjZBQUFBOCt2dHVySlI4RDR2ZjVpZm9lT1ArS2d6a2Jkb3dK?=
 =?utf-8?B?d2pnY04rSFVuYTRZNUZtTGtBSVN6UWtDSHh3eXdCd2dHRkZoVlREVU8vU0k5?=
 =?utf-8?B?akRpbFArOUtMWTBBV21MclY3eUVnYXA4Mkc2cDBkejlKWFp1RXdFZVMycEhC?=
 =?utf-8?B?eDVpNjNVYVNlUFFKN3pmRXhHWnJUWDErQ1dqb3JsN29ycDZqWDZaeGxEc1Nn?=
 =?utf-8?B?M0FYZ2o0QUhVSGxTUTZ2VFNRTzA3YzlkRExVN1JqK3Zwc21Ea0lhRmFtdURT?=
 =?utf-8?B?dzlUQkVMbFlWSnJxUUc1Y2xHMEJja3ZhUFRQS28zS3hLeW5zRmI2dUZuS3dp?=
 =?utf-8?B?Yklvc1FuY0V2aS9zUk54ZWZOUGdIdlFqQXBGUmV6Y3gzMkV5blk1d3pLWkM5?=
 =?utf-8?B?RHRDZ0h2dzNNOFNQZ3htTGhickVrU2dybXhwZlpGd1FTejZRRTdkWmFqVVJS?=
 =?utf-8?B?eFUzWWg5OGxaaFMwemYxTS9sNjh4SmZPeWJranNlbzVOaTVLL1V4ZGVWMW02?=
 =?utf-8?B?cWxiRllDa2RzeFdEVVF3SklVeDZUMlhyM3dCY1pTalhENWlTRjhWQ0VldWpx?=
 =?utf-8?B?RG1GTEs1b2hoODRQZlZiZWFxVWllQTlycjRMeU5ueFhNZDRtYm45aE9xSXpN?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70433d79-9bcf-425d-f1b0-08db56ec712d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:36:11.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2O+Y0ET/QYfRXfmp5R3eORSM5hfIZyiExBJDqFpZSXDu//P9vaLw9Gg4jCTZRWp9Rfq/Tc38RRnLglkgIUiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5701
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:36:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11506

On 17.05.23 13:57, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This prints the error message correctly to the log file instead of only
> printing "(ERROR):"
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook    | 2 +-
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index a034d5d..23dce93 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -23,7 +23,7 @@ if [ -f /etc/os-release ]; then
>      . /etc/os-release
>  fi
>  hook_error() {
> -    echo "(ERROR): $2" >&2
> +    echo "(ERROR): $1" >&2
>      exit 1
>  }
>  
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 077f43a..e3a296f 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -20,7 +20,7 @@ esac
>  . /usr/share/initramfs-tools/hook-functions
>  
>  hook_error() {
> -    echo "(ERROR): $2" >&2
> +    echo "(ERROR): $1" >&2
>      exit 1
>  }
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


