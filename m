Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40103C7EE23
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 20:37:24 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web10.24908.1685911041829995213
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jun 2023 13:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r9TlXYjb;
 spf=pass (domain: siemens.com, ip: 40.107.8.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xuh/7GfuidsTCjSW5yeZBx2WkJywqnVkj6sHDAUeCRyvrUdV60T27CbQMrChIIpLl/quM7TxH2n8YxQ4GxNiX+RaaQD7AqX3VVd/TrUZFOxmOYikX+IjOw+iFmWO6EGyn2aK0rF6TrOP/3hvkhz3Gugld14ZwbqdaHKeYRO+CNpDSbd1oHUJEyJ3Crv0vjAYm5+iJAUh1/LxqVlca14+Y1FSDSwm7xL7E/IbywWfCM+C5Jaif+3HyF0c25HIKSkBnr9JY1+mN2ldlcHJsuRXTEi2V3beGWrgWmE3V0zUYog2vWcQ6NJ7M/3fjakoUsNw5NVq9y/RwTDrZOi2yEaKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGfCgUkJnbXEvpWdCtuTKRdqF8OOuNCKElSn090BvuE=;
 b=CIgigdc7uhrjPTAIHx6giIOShopxR5HSAw+dK7kjAcsLNvugFoyJwv65yv0o6Zpu/9+5sVjOiudYgaZF/gOsAWnWka+um5ZfyfxoY1c4MlEW34tQPohvRadkn347Y0sWTUhWKDxU5tD/3o0c5i5b0F2ou+zgPUPrUXVqe/1AooKWqlnHxIak+UmUn/5hEqgQYCY+A8W+D4FByWJ71JNb6E9OiHLa0Xj/Zzwsstfx1QJLQHFmX7+IoBQnwAoKaIfp+0yrhmHA+2L2DgWS9gVsrK28llXxxb3SOiX/3ZuSLkRH4/yeXkrSpiDtTCw3+1PKTtsLNogN/yfqB/b6kgRWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGfCgUkJnbXEvpWdCtuTKRdqF8OOuNCKElSn090BvuE=;
 b=r9TlXYjbqBBV3tq4/AAhAWz2BwOnnIXD2afnKaXffyko4Euk/Vj9qO7yXrShmSPsjV+PH2uqoQteJWQrxs++TNU1dsRiVp3dFccxaG9rRJksC9jDcMxaBN5xt563tmoqIzqGVzHim+Uq3R15Gd2UCkFQxEGxD+1u3qKJm74CKk8r7gZNixzgRSJq/pFAyoCnc8pwqTB2WDtYUWeQRPKN0TYWZnQ9ClyVYBldw4RjxYXnhhr3sB8EEAjWEgZmKs+WbZvMMeiHILaE6DOOk/m/bR40uqZswXR/q0Ztc3qpfL2QmnURXikGvlN5BUJ2o/U6SX5GXh4QdFK/nwNs1alXRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sun, 4 Jun
 2023 20:37:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 20:37:17 +0000
Message-ID: <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
Date: Sun, 4 Jun 2023 22:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Content-Language: en-US
To: Uladzimir Bely <ubely@ilbers.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <20230516085018.26436-1-ubely@ilbers.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230516085018.26436-1-ubely@ilbers.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f056bf-2189-4305-312c-08db653b7ca1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MxyaVjr/d241GYCFzH+/RegK+Xcb9W6xvjA0zi6sAecKa7DI7+06/yvD5+PzhKzo+UUV2scNkKyXralliGy2ZfT4gqoZV/kM17na6kpurko82nbaP8IORHao45/0EeKr8EnwNwXk+H3/1HbZk6t8nzruqOD0hb4tp9R+0b3DvGQ9+whDdYBmfJd28/P7BMmkcJGBfYTF4ASPDOPXS3QZRwCJhYy5Ng4CY+Vja2hx889mrGQGz/E6gky5GXoxxrkXqNFBCfbmOH5ihYmsmfFMkEs2Z2jU2KwtTS+W9LgR7KS3SCEpGCSHDaNbGj8UfJGyKq524p2mVOPP0cxTU2F+/KKrVq7RaRA/yYV4WCBk1BeODxkq1HFB+1yMIZnITAAcvW30FOCrZwZkjF3piC2CegOSrU12MIRkb6R2IILE9iurM/zhpGUyHUnPq8iSBcL8NbdNZRZNhN+Sqf2Km38b6y3dNNj7ndK+UGDv7aSedk4Y9zUhSulXrqzva33x/h3WvtP6rmJqbfaCOfNAxP988L+2nj7vSMSKLa6ZHNsxSYv10MgKDHo7jsscGnLcLcbXNuNyF/SDduYEQruuVt4M1YfebJRg4lM+OsFys45APejJbzTsTKJiN/RZSTdIgQqO000NfM0M5NWQtocamD0HrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(6506007)(186003)(26005)(6512007)(53546011)(2616005)(31686004)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(82960400001)(44832011)(110136005)(478600001)(5660300002)(38100700002)(31696002)(6636002)(86362001)(316002)(41300700001)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFQvRU1RRUZ0QXczWW4xVU53cDZvWS9IWGNGMmlyQTMrOG1zUWRlMEY5NHFn?=
 =?utf-8?B?SEcyVUw2SUxyV0drVU5YcEQ0YWdJd2xrUzlyOHZ0OTJCaVJ0MG1DUk5ad2FL?=
 =?utf-8?B?QkVaMUkrUGx2aHRtVGJZeUlEQ21md3VVTGRPS0hzOE4zU0xFbWkyRnFTdmtD?=
 =?utf-8?B?dXJnMUtzTGFkR1FNRVE3VmtSL1h0bThJNk1ud3JVOG9aVG9WanVNRjZOUnRL?=
 =?utf-8?B?Y1RsUEZNNURLVldKSTd3d05vYjU3N0c0L2xWVXg5aG5xdCtIdFFWQTVnV3Bm?=
 =?utf-8?B?djFuYkthNlArYnl6VnF0UTJlSVNXYXRhcXQ3M1VqcmFSc1JWai84QVZ1SVBN?=
 =?utf-8?B?TThOREFwNGRpWmVMZG1MV0FWOUJjWHZJUUlyNkZHK2Y3TWNlVDVjdzhaN1VF?=
 =?utf-8?B?YmFLYk5oNGpDOWI0MnRhckl6d0d1UWF5SFBBWXE2SkNjZ2huNklvZVJ6V3JR?=
 =?utf-8?B?NVpvT3Z0OHJvczhyMndCb214S1ZhQ3p0K0syVW9idG1mTVdKV3BCa1daRGZ0?=
 =?utf-8?B?Nk5ZQjh3ME1Na2Mzc251ZFVQU3FaKzJieWI4emgrUHJrMk5KaFdVSVF1NE5p?=
 =?utf-8?B?Qkk3Z0QrSVQ0aGdBTjBEVklnb01EYnVPRHJrZEd3cW1TaytPb0xVbXRpTnBV?=
 =?utf-8?B?YTAzUGg1SDZ1TDQzTWNrQWViWUNFcExFb1RsMXQ0bFVjNjBiUlhHcG5DOVE4?=
 =?utf-8?B?QVhVS0piMGxyQTFuL1p6aU1yNmd0OEFnM3VaSzdFdjgxY05JR3lMSDBTMEV1?=
 =?utf-8?B?WU8wNnRMODI0UGJHY0ovS0ZsNThpa2NQVzl2bDJ0a0EvcUZ1bDJDMVdyODg2?=
 =?utf-8?B?MUcxVy8zR1FVVFlwdXhiTHRMSHZ2NzBUTHpwMTZycSthUXI3UHZCeWhzUUlX?=
 =?utf-8?B?bGx4UTdhV2NGYVFNYTYwOXo4VGpXTTBSMXhKdXhvSVJTbUF6SVBneVlTNzNH?=
 =?utf-8?B?ZlZlbTlGMXI0djhtUFFpR0VHY25uZHV4emVIU0hLTWlGRVpOd3ZpQk5TZ2xl?=
 =?utf-8?B?UnVQVjVjZ05zZjkvRmdPWjRsM2Z5MlVmMFM2c3JpRjhaV2U1UUZ2aERLOUxR?=
 =?utf-8?B?SkRjYWZib0JacDgzZkVsdmIzaFhZUVhFRjZ0MHU5eTJPd0tGU04xUmdXeXlD?=
 =?utf-8?B?QnZPTldhbVI1K1lTM01uNUswVWlHTG1VZEFsazNWK09nbFhHbFBDUFRnelhN?=
 =?utf-8?B?S1dKWWlGdENCeHZPbTR0MEJlMjI2NCtKVHd1SjRwSEJsdTlzdXJkNDNHVkls?=
 =?utf-8?B?dVIyeEVaMGNOMk54bEFuWkg5RTZpTkE3QWtvbFJUNTV2LytQVjQyUUtXSGxa?=
 =?utf-8?B?MGxKaEdOTm5KTEN5YXZJbU4yejhKTGhWVGZMWTUzZnhPcENrV3JoMllpVVRK?=
 =?utf-8?B?OVQwRlN2TGhqRVpvK1F3dkVPZGhUUHN0ejZjUjZsc0ovZG95YlF5M3kya1dN?=
 =?utf-8?B?a3NvRjVSUE94aUVPdGFHQlgrSjdCS3BLSjlhNy9vdFR0R2Y3clpEWHFxbGJ1?=
 =?utf-8?B?NS9qRDlNNTN4TUZSZlJqeThKUm1PRjNXVXVOL2ZhOFA3UlZ4R1Z3anVnTTg4?=
 =?utf-8?B?ZnJ2cnRsbG1qc0JDb3lQQ0oyN3lsZ21XcnZ6UCs3ZVduWnY5OUVkOUdDdmQ3?=
 =?utf-8?B?M1dCN1A4Vk1ueURCOW8vUlExYTZGU0RnMWVoUWRlQ3BDYXhOMU1qOHM5RXhD?=
 =?utf-8?B?YldTK01LQmljMG4vbDNnR0NCZmdsZmhNdk5KeGRtOTBFeVpRdHN2QmZnclNM?=
 =?utf-8?B?MTJ5SnQ4Y1ByRTVzR0RhN1Z2Tmh1cU1tdGYxRERST1NmMmNROFV4cm8ybXlj?=
 =?utf-8?B?cXF2bEJ0SnJpSkxERTB4dWNyWGJHMmg5MStHR2VrMW5FMEdUVGtIbVN4OG5j?=
 =?utf-8?B?MXQ2d01SaW9hMzEyNy8xMXJMdXFRNFU4RVBZNjRIYzNTTkd2WTQ4b2N3TjlU?=
 =?utf-8?B?bGtMU3VtNUdIYXppcFdXQ1JwWkQ2NXNrVUNmdVJNNVZlZ01ZQlJObXh0TXRi?=
 =?utf-8?B?aThYRVlsRCs0N0VucUhvSU9DdHdTNmU3bS9KZ200K3JnVXFNM0hObkdjTjJQ?=
 =?utf-8?B?V1l0cjNiWEg2SzNhalJLdkZXTTIvRDdaSXpEelltQlR0WUNmSVRJQ3JXM0tz?=
 =?utf-8?B?R2tZRkVvaVcvM3g1VlB0OEROUVdDU1lzVDZKa2F0TC9TazZpT0JyWWRLS1RB?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f056bf-2189-4305-312c-08db653b7ca1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 20:37:17.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn8CIdhMa07fpabHR401qKUsHXm6FnQuKROlkW9EO4PEvU4d5NJAlD4GCfR1GJwWFr3oTx0Gg/wAEUHzjSZmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jun 2023 20:37:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11760

On 16.05.23 10:50, Uladzimir Bely wrote:
> Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
> causes uncompressed '.wic' image left non-removed after the build
> finished. This is caused by indirect dependency on "wic" in swupdate
> bbclass that can't be overriden by the user in local.conf.
> 
> This patch removes this depencency. If the user want to use some wic
> partitions to be packed into .swu bundle, they could simply add
> directly add "wic" or "wic.xz" to IMAGE_FSTYPE.
> 
> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> ---
>  classes/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 9a4d509..6f034c1 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>  
>  SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>  
> -IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> +IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>  IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
>  IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"

Oops, this almost fell through the cracks.

I'm indeed not seeing anything in this class referencing wic, so this
removal seems logical to me. I'm just concerned if we have downstream
users relying on it and then seeing a hard to understand error. Any
thoughts?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


