Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96614C77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:31:10 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.59])
 by mx.groups.io with SMTP id smtpd.web10.53270.1684337461600480050
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 08:31:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bmzLkO0b;
 spf=pass (domain: siemens.com, ip: 40.107.6.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzn9SYi/vvUYTfTYye/3QQeA1ePt9Q4HJLYUHccYtrdtGTNYRJ15RUc/j8VK0nX24K1x6cNAu21ygiEEBQb30YCiVpuClPqCTaR8U0JXNukoRLdRJdG05DZ96B+DuNJI4amrCB4xf8zS2r4AqdaQCiYmPZiRHq/4vnUQpqhZ9rw5+2TalfOCEYiArq1Z4A6AmFsJ+3fOXLhwiHFHfXsOB5Gzr0vhvt+gtRWuv7gMH66fr/QHTqis3Jb/U06p1CMH8xR6eHT4epUw3t4Bn77AU3o3lzsXKMUWA3fYRc3GQPD00yYauZ3RGddXf6QYouMmJneVqKhKihYwGD26C07C+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ8AAUXKtmWt7/QSkKbl9x6EfL+UN2Wchguj2IlBDJg=;
 b=JS0XaUUIgHZRGbOKdUHfwwsLxX6y9HJ6+EtWn1yTXPIYdcX0vI0UbjlhkKXhDkp/6DqWTKVF53ShhKMwAI4h0mQH/Pj5ZTCfq6QPJeIhVTMF9Z2rRh2lJzpjV6CKN39cVeBboG6XcdJNDpYnIAHt1+oXS3NgdIld66FlWDMPRoM500HXzqyOUYI27fFs5Lo1qJ9C6fTEMIMaDcHK5tcBZr3qgfGXwSlKV1h90XHJ7K4yAjpiB4R1ObXs1Mfz5wNiDJAKgFSm9ZKTUTiFrpU9yLxc4khQlQSSs40w6BRHcKZOMh8iSU3rxWykPv2HBzDSMX9pBgxpMzkKIzZt0zSiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ8AAUXKtmWt7/QSkKbl9x6EfL+UN2Wchguj2IlBDJg=;
 b=bmzLkO0bbJARMmBbWof4niULLGMF/Vsy+JsguQr3y6yxqm2PGx8EuKNKzvX27zQtL4JJQN+8pWL/l2q2XYA873x3Ajg2abNEPxhRot8leX6yY1U87EWECBt1Atj0toNw0rBj0b/bqo539LB0ihmrOwqmgqWmEvgw6Aprq9sftp8M3oNt7p+HZ4cU3K+qz4XiuJXWC4H89uYuUW3+oomekJkKiuiJnrOUE/hlhomlH2mUTGkIB+2i8N0vaeESEk6EH0RKAeltNWOJN5XK9m21L2mJ/TZ8tmGreIyzTU6e5acRzsPHxeQ/YhcI2v92jTTkRL5K6HZbSH09N+8d1Cerwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 15:30:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 15:30:58 +0000
Message-ID: <5eb8d24d-2686-773c-6e6d-fb4313b7ee37@siemens.com>
Date: Wed, 17 May 2023 17:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [isar-cip-core][PATCH v2] recipes-kernel/linux: Update
 cip-kernels to latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230517134206.1517172-1-srinuvasan_a@mentor.com>
 <20230517142148.1526129-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517142148.1526129-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4480be6a-88fa-40e7-b26a-08db56ebb6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f9ZMh1ASpFx7UqrToLqx3uV+vsonNmjbHPiOVKt/ztP7ZhlS1tNgQJMFb297xHl4gto9ajndWYAfWzyytRiObfe6nKgSrHeQH5uANfAgl3FDQlXLthmeWhnSfDTzct8qKHoeRZB8B+I0PU1XouhEPXxhdmIl+L6m255pQ8yhiqYzt3K+r0hT8ikKHIYo+Apv8iOSEQnuxE56dHU6OlTuJ3io9eV61wmeTkxLg1N4us4LZ+x8eqyF2Zss9mdWWFF7Lp4dAmricMe/oU7gtDE/lZwCQOAJ0wPCztdEc93qCggSQx/4WdBasx0d9HR2yilvwp6laLEM4cG+7diLhiKhE6JJQ+Y9b3+uKT9LPvaie30UavBdt+Dkda17w5NUjyp3xj8ChiW/9HUJrKKPNeSP1h9hP/RHJQ1ZUdej4ndLscG4MAfUW+X+aGId5EqwDn9Jdq1DpfzKgUQr3LF+5SlAT/TDKbxF4V4jxBsP/9t+RIuzTSVsuXcCkm9UafjXWdkcIRpwbpF0n27+jqFirzB4gIFsgfzJEDiPFGjY8gs9XIXvwZ8vXNwvW+o5rdStwwnt04gx2yRYEqu+DcJz8v+ANFtzLuueMZQ1C9+moHv455nXJoJOsXogxN+CxIr5dPELhlnxn+5S59VgIQJLLsdsfg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(31696002)(86362001)(6486002)(36756003)(316002)(478600001)(4326008)(66946007)(66556008)(66476007)(2616005)(44832011)(5660300002)(2906002)(8936002)(41300700001)(8676002)(15650500001)(82960400001)(38100700002)(26005)(53546011)(6506007)(6512007)(107886003)(83380400001)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2cwNldhbUJUSXZkWXYycDh0YTIwSWhxMkd5dEdWcmFsNG05Sm02MjRoSGJD?=
 =?utf-8?B?NFVBbXp0V3Fsc0l5S0E0K0hYYzcxYTNmUmRyZTdtckkxYWFVcFcydEE5Vlp6?=
 =?utf-8?B?cVZMTk9DMzdZRmhIY0l3QkNmbEJlR3V1ZlFsOWIrbTF6WFdkMnkvakM5YURJ?=
 =?utf-8?B?Q3Z5RHVkektBRjRuRWkxeSsvWkM1b29ySmp0bzBaZ3B0MWZNV2tFNncxVGc2?=
 =?utf-8?B?SDVrS1VSTEY5eWI4YVROOTVYSjBTWDgzMmQ0UTNKZktEV3hhNG9jUnVuTWVh?=
 =?utf-8?B?WUgyWjB2VllkRU1qcGdqZFlSNUhob0FGVU9pTGpGeHEveVM0L05YVWZNRjd5?=
 =?utf-8?B?T1lkZ1pjck5LTWxWR1grcFVWTVNtTlhDYmFWWGxCS0N5N3pUR24xWGlsNVgw?=
 =?utf-8?B?SHEwUzBNNTRuTjZxcUZORTBUM293Y3hCZWtrdkxVOENVbnZVbFczWFROQTA5?=
 =?utf-8?B?dzRVSTNxdmcwR1NOdjVnNUN1cTRibFdIY25kZFNwcG1tNjZCcDVKeWpjcXpX?=
 =?utf-8?B?Mi8rVzF1TFJLWDhGM0JNT2w2L3JkQkwwY1cxNzVPZTNDOEhrUURLQW9zTjlp?=
 =?utf-8?B?cFdtb0QxZS9pblFBZ3EyWTV0TkpQK2pxOHVhb2FJUWtNQ2dFWml2Ni80WXha?=
 =?utf-8?B?UTJVZzJobzhkQWN4ZDNsY1NodEV5aUphVFprOGZCNTJQMUR2cjNId2RqM1dl?=
 =?utf-8?B?NG9lRGwyZE02SW9aMDZvUmNDandYeDc3S1FhMnE4eEQ1STBrTkxGQWMxVy9P?=
 =?utf-8?B?OVRzWVU2aVJvd2IzNDhYSnE5NFhNZDI4SDJWdWlYYzVnUlJlVmJSTS92SEFr?=
 =?utf-8?B?UTFLcldWaXg0SUg4alRJSzBiVWxjZWlDKzY4Ym5lSEdmY0tFamdFN3dWMlhJ?=
 =?utf-8?B?VUw4QW1VNkVCRVluMWgzVDlmSHpCOS9EcXhWTmFLNmFMa2tSSUgvV2RYOStN?=
 =?utf-8?B?VEZNZk5rWWhDdERIRWd1alVNbGM5STdYNHdFUDJSSEdqdDQ2UzZ1WllBdCtk?=
 =?utf-8?B?NVE4THpVbGt1ODZKSHN1cXpldjBEN2VLM3gvNlJmNmx2RFpuOWZvTlZLb2x2?=
 =?utf-8?B?S3FWclc5VDluamhhSVpIZ2ErUUJpd1cyVENhMFRVRzVaellZWmE3VHZESGF4?=
 =?utf-8?B?dkp4a0FPazZXcnNDRUQ5QkNleFVxazdyK0orNC80R1F3NTRJRFJZdWl6NGQv?=
 =?utf-8?B?OVVZbmxsMmUrTmlsa0tqQXV2QlZDaHhaY09tcjgvTlEwQTFzcjB3bCtVRzVL?=
 =?utf-8?B?eVgzc3hrekVHeUpjY3N4MktIUEgwRlAydjVkb0hpb0E1aVN3LzRNY0l4UmR5?=
 =?utf-8?B?bmN1aENRTnZvTkdnZ0U4cHNmcWM4WG1QNFA3b1A2SUNOblVmcjdxL1cxRkww?=
 =?utf-8?B?OVUxZVhUekxuam9WSWRkeDJLU2RmV0F5eXlYeC9jd00xY0xzSkdWNVZSdzdF?=
 =?utf-8?B?L0JtbXhqYU5MeG91bndsQkQvYlU0SmZRUlczK2tSSVcwVmxTcmwzRjhmT0do?=
 =?utf-8?B?Y2VwZHRtU3F4c1gvcHJXTG1zWVpOcXNMNHBXTUZnbmU1UXZRS3k4dkR1NE53?=
 =?utf-8?B?a0RvMlAyNW14Rno4dUlyL1BiZEhUUjRpQWlXZCs4V2xvYzMvMzBTZUh3clda?=
 =?utf-8?B?VFFadTVVTmkva2dzZkNmYlpwU2hXQitSQWhVZDVrWHZwY1cyZnQvakphcVJq?=
 =?utf-8?B?OUVkRlhLRnZxay8rWGw2aXNtQ1ZnSStBSWFrVzBKdGF3MlUzU3owdkU3bGZV?=
 =?utf-8?B?TmloYzFodTJKM2JQTlpybXUwbk9GZ2JmV3d5dm4wRXA1NUpHTk5aS3Z0MGZq?=
 =?utf-8?B?ZHQrT2cxdHpUL0dlQldTOW1VM1ZSYjVSaUtqM1dTVDUyUVJmcFF2UEdzVUJR?=
 =?utf-8?B?RTZKcEVSUWN1T2RzS3dTRGxIRlF5WDdOUFA1cVlOSUFYZjZkZVJMbUpOOTZU?=
 =?utf-8?B?OGcyQ0JrTURadE9GS2I4Z1dsdlF1bDNkbklDVm8veXlMNEtKVUlpbUZ2ZEdJ?=
 =?utf-8?B?QnREd2w2eXpPL21XWVJVc05sZy9iMHFPeUVxU1c0RmhFVDhXa2VHMnE3T2pE?=
 =?utf-8?B?dE44UHJKVVpTQ2srQkswaFB5dEp5bjRVSWExMDhhcndOeTdpZkRnNUk1V2lQ?=
 =?utf-8?B?VEpVckQ4WnF6S01WN3BQN0cxeWZ0bEhPdVYxckU1NmpvVG0xZFZKSHgwZG1n?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4480be6a-88fa-40e7-b26a-08db56ebb6af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:30:58.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLqW1TxyQeKfJg9mjPNX4jN2QKmiV+2jZ1mrxDIELjWpMIqJ9c5+Uh94TQOHzRB/YQG3j18bmQgR6eF4uO9mVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5701
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11505

On 17.05.23 16:21, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update cip-kernels to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} | 2 +-
>  .../{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb}  | 2 +-
>  ...{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-kernel/linux/{linux-cip_4.19.280-cip96.bb => linux-cip_4.19.282-cip97.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.4.302-cip74.bb => linux-cip_4.4.302-cip75.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.177-cip31.bb => linux-cip_5.10.179-cip32.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> rename to recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> index 0a1af14..6585a58 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.282-cip97.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
> +SRC_URI[sha256sum] = "823a355cf0d6bf39c5ad96cfd2a6dacf652ac445d61bf61b0dc3754e7a24dc05"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> index 4b6a548..fae6e12 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip74.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip75.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "0758c47f454d51fa80e3c63aac919d04ab4e6dc1a6ef8c34807e1e180d44d9d4"
> +SRC_URI[sha256sum] = "b7616ce99de5f9f29065c8adb4a9465d118b7f4c89276f95b9de755c99cb3f61"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> rename to recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> index 08bc8ad..cc06549 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.179-cip32.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"
> +SRC_URI[sha256sum] = "526ce38dfee520233b9af1ff714ee69ad528c986c7d051aabe6b3726ea53832f"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


