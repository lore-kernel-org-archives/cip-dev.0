Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F568C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:59:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web08.7639.1668088736434135773
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:58:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=whTJGWsX;
 spf=pass (domain: siemens.com, ip: 40.107.22.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcWfvmpo/ffoXX4hbuzwBMf6epWp2c5OX7xGKC1ocGIVRVl4dONOUpyvXUh6CPIMhPBQiIxyNyAUtZ+UWSZWeJ917/2RDObvUuOl2qywMI67CHYC6Q4FsSjym4Bciha2QrnV8EUeIqgwnIUaWK5vWUZAqhB49RUOB4X9TmGo4+/cK++qYO7PdZgdBTLyuCqP+IGWUcCFqUqVM+CWlJkZexFOJQ1eA0wDkfqsZaZOqNMmSEs/CCvRs/oMDlSdI3JXs/NJgQoWdx4BIP5sAX0ZcwshgxMGBkShrkrU431lZLoGmoB28R18c1uspBI0xfBDSSbqZo8OEpMc04XWw+fHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c0388lM0ktv0FVH4bW9GchD1b8htApcyI0ShIfhVQY=;
 b=Nz2fCHffGHMFY/mx8Kzc5Ugozy19MdMAD6Oz8SLcLH1yAhxgc57Ez6OifbvW1BHM+WCC/aEuroGwIm8WjPB2o27vPldRP45h9sIbvymDEpBYRm55wiXJUpUiNVFIKijUbgMdzAnz7LYQcrxGsvk4CRHvA+p6KhvaFftfQkJRoS3eNmFb6j7hxGb3SzKO4kuO2EXhuTUd6OuaBolpjVWjuSaaRUavLtbnJMF+RzgTC+LSXbDCHVhs6QkclCW5VpPiK7s3lasVZ7Hz3U28wy77UorX0UqN2wRWEkAQL1vMjCHTCeTclSCp2wjb2GRDZaoFBi2GaVHh70fWmBLnYcqDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c0388lM0ktv0FVH4bW9GchD1b8htApcyI0ShIfhVQY=;
 b=whTJGWsXMipfPbmVcCvcC36jvcZ1XE0qEG/tofUfM1crxc07loq8CB8TeOlEBdlUrwHUtSLErl20e6krDcAqI9H2QY/mccx98DztaQAHCImTfGZnC8rLuCFZKfys0z4zPDVpXFHNTCMwkGHgkbAg6sYANcDKaLc5pv1+1AacCxaJ3eD/wbrEDbXwIL9CCoTUPO/ydBJCwF7QoQ65cOo6/Bthoq5aJlXkdibcQzEQ7Tu08ESc6MB1uajOKJzHyJO+9P50sZVE+K51TYMzFBi1Uei7gtlhEFlg2cYesH+DnKVPMlic/9aWH6J5Rb8BFMHCypvRVQBc/AIv0mS6excP1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 13:58:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:58:53 +0000
Message-ID: <5eff709b-2022-8caa-7951-061cc273dd8b@siemens.com>
Date: Thu, 10 Nov 2022 14:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][RFC 5/5] recipe-core/images: Integrate
 uuidcheck into sw-description
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221110124503.274124-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ea816a-d37e-440d-5cac-08dac323b3c4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6LChuNYp2j+JwT8OTSh7PxT3oOdGXAAlYImGcpBaXbkDs0me7sAqTtp/rMxguudcjpYVtxAT8WEJ2hnyOSlxDukeaqsx7V7cTopoCMR6VLEqqxKEL/7oDKcpNS+nxRhri5l9GbG7FUJ1vGwSEg/qb98pEaPQaziXK4wuQyhBn6+M8WMx+otCoRj4vo3H9qsD6yBWbKCgiArYeEbqPz+5ZTAm9eeq0UISXQMncYNfJaaQieZbTyO21q/UalrPlgWjt+SiMc46brab9FL63fWfcWgMny7wUDTRc80Zm3ub09IxXQY+ZmOsR2jAA2XLSmKLUXU3dAj0bbVEVXT/7mE95zAbPguANuDhDXwkWFrsEAQje31G025a4UfAcfzv3Y8c+vBR5nxVVQ4ysNnoA8qwleyx9ETUgDgqFMW68n3HUPtXsxnJWn2ZwIXQbvUEbFPGk0P3DtvjJyOReXIIri8rByoYoh6wUWMx6hd689nFex23wv6WRGJEsp2xrjl8PyhceefW7+kZvcpL4ehfYplgMo7k9Squ8R0g20kAmFgmrPSfUrTcze7mWpj1iPIIFpomn1PxQ7Cf5Fdc42LDLTeX4hEBEOzLfxgemu2hxYKHAs3fFLhf3SVSktUxobodtmNmIMkXa/Q0/QCNn1Wj7+NKAtpyeKjvCFysPsKL7QTLxHx7WS1yf018Srvsa5Ze1PqRDBWT56w+dCdfL6mJIuc3vF85ezsBkRS9rZ9JMy0eTiidFYukWjo3/9TjVN0fokA7JsK9X9o7M9icGD+rcCjx8p9q3GCBLdm0fBgKYILjN2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(38100700002)(2906002)(44832011)(86362001)(31696002)(82960400001)(6506007)(66476007)(26005)(2616005)(6512007)(316002)(478600001)(53546011)(66556008)(66946007)(6486002)(8676002)(6636002)(8936002)(5660300002)(186003)(36756003)(41300700001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MSs1NmZGZk1CaGd1M1FsSzJ3NHArUEVxaGtoYUNwZHlMU0haWTRUeXN4VVNj?=
 =?utf-8?B?NGd1d0lGa21UbDhvelQ4eDhyNzRrR25oUmlTTGhzTGplZTFwT2htNUEwOWZQ?=
 =?utf-8?B?ZWxkNzRnd0VKUkdoQ2hjSFM2aHM1VGs1a0JDdGNjL3lnYmZqTkFRTjZKQjR2?=
 =?utf-8?B?alB6SlBac0xBbkhxeVhvUGtBUUtWMmE5SWpscnhiU0FSTkZUQmE5NitzZkI4?=
 =?utf-8?B?cVkrMTVlU0E5dC9LYjMxQlhWTEI0SVNlSFNrOWV1TGpKZDJWamx4SlJ6U1Iv?=
 =?utf-8?B?ZGcxME8wL3d1b3Z0WHB3S01LNnYxcC9hNEZTUnROTDlJTFpVNnRqMmxKZFNh?=
 =?utf-8?B?VXBjR2xCa2dFbHFwUk9Rem94S1RSTW1zeml1Nzd6UEVQOXlRVmRBK3lZUHpC?=
 =?utf-8?B?YXZSclE0aEdOa3pDSWZqajNXKzRNcFJ0bUFhRk50Z3NrdktydExtUS9TeXpR?=
 =?utf-8?B?S2ZPcW16SHg1ck4zbDZNdFdSUFFXaDJPLzhVNEhVMitQODNpVGt4MkFWUERL?=
 =?utf-8?B?RnhRTmZVczlOWlhvZ0ZoVy9ST2E4OVpGeUhlS0c2VkxWK3pGNitHVmJ4bFQ5?=
 =?utf-8?B?N3VBSDZzdk5SRi80dVh6Y01MTjU1VWRPeWU1bGVFOGRDNEUxWDNwaFZEVWFF?=
 =?utf-8?B?NEc0dTl2SWFtak1EQkJEZG1HWTZaa1FLdFFVMDRod0JYeTl2cWZZSWRzLzlv?=
 =?utf-8?B?azh5ZWpIUFRmQXVGSEhGQkxyZEpteXE5Nlp3RmF3VGdpRzhubEkvZkRRekxy?=
 =?utf-8?B?RmxFUEo2TFBDSjhFVzFxNmticXo3M0xCRUNOVGJiTnBrS2Ixby9sRjk4MlV1?=
 =?utf-8?B?YnVySlBKYzc0Mlh2TVk0bUxsVTJiYWV1UWl5dTZjUE5VZ1p4UDNud2cyWVdT?=
 =?utf-8?B?dExVMFVZMlNxOWY3bkozdmxRenloYm9VVFNTNnlpTDlaTGJDVjFUd2NSZElz?=
 =?utf-8?B?MEo4WHZxRU5WendRM01WSXZiQklvN3h0MWpyT2FXVzgzU2Rzd0tmVW9QTitz?=
 =?utf-8?B?cFg1Q1VCeWtwSG50NUJ4Mm0yME5odTJRYnNSV0tDUlBmS0V3QXJhU2lJUU5S?=
 =?utf-8?B?VTRyMUJqOUQ4cGJFdnhpVVhRMXd3Y2FaT21yRUorUU5tV2NESGFuWjNYOFJh?=
 =?utf-8?B?eW8vZlVQaFdvSFFFeEU4aDRCOWJIcmliV2FMTFpSMUdib1Mra2xYaXJZRisr?=
 =?utf-8?B?N1pwUEFLT0I3S3hscng0RzlmbFEyb2lSalkySnR1U29aRWdqMmhrUFNjdnJn?=
 =?utf-8?B?cnJjV2ZBVXJGRnM1S2g1YVNocVZoZlRoV0JYMVVhK0ZocFdzQjdFS1VvQmE2?=
 =?utf-8?B?MkZXVDhNOXlEQjh1NXIwdTFoeFZla1VENVRSZksrL0V6UFJXRTR2OUJwRGp4?=
 =?utf-8?B?ay9RQmtZb2svMEErMnJMbm1iTUpxeEM4N3BMYmVSMkJnR2M0cGYxUFpIUjNJ?=
 =?utf-8?B?ZVFwOVZDSVFwandVSEo0Y0lmNE0xa3V2dG5JLzhGTnlFNmJ0czNvRy9BM1Ni?=
 =?utf-8?B?OGpQa0s4eE9tSDRJdnFVZWE4SlVaV1VOUC9HOUExV3dFbEdpbStmOGxPNkd0?=
 =?utf-8?B?ZmhwOE85c3ZXcGlBV1VJaEE5SC8ycEZQajkwREpwVitzRHlxcC9KSU9SV3do?=
 =?utf-8?B?WFd4dThmR0gyRmw2YzJWSlFuRHJCOVA0WmNaMkl1VDZkTUM4b1hFbVlqcEkr?=
 =?utf-8?B?Zi9qOU1IdmRiaWQ2cTBJYXZzOFBlWFFwZE5jRDlsejFqcWxVV0ptQXpHZE5h?=
 =?utf-8?B?c1hZWnYwYndEYStCOTVhNFo3UENIV1ZIaUhZWkVpVjNYVFJ2ck85TlMybjg3?=
 =?utf-8?B?YWV2aHdVMW5ncTR0anBmU3ArU1ZGKzdUZWVLYW9zK0U1UGpyYnV3T0dzU1o4?=
 =?utf-8?B?eS92YUxDU003YkU5LzZEMzZDbXBGbHdaTXVsYkszSlhqWHJhb1pTQ0YrOFFi?=
 =?utf-8?B?RGJHVkdlaWRobHJHY0JHdVlSM0RCWldNbEJiYk5EZURzQktKZ000WnJIdUFN?=
 =?utf-8?B?MmNUS0k2bEZiYllIbXY0UHYvak40UVFBSmQzZm83NGxCUnhRNUZYRGcyUVZD?=
 =?utf-8?B?YVBjK1JVYUpIL0RzZFZXb1pPWVRzWlpUdFgrbGlxWmt2d3k0RklkRkswWmlw?=
 =?utf-8?B?S1B6SzdiUTBnaHA3eHE3QTUzYlZ1VlA1S2NydHNrRWRSU0ZUcEQ5WVlNNTZQ?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ea816a-d37e-440d-5cac-08dac323b3c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:58:53.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2mxUF2RJB6a/IzXFiAjZ0zxQkfe5hSB46xsF04eQFenzdjZc5g03WWIUjy8e+8fHeGl5GFE7ksOIg9OaCkW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7765
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:59:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10008

On 10.11.22 13:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/files/sw-description.tmpl | 1 +
>  recipes-core/images/swupdate.inc              | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index 1c0db02..a9a6069 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -20,6 +20,7 @@ software =
>              filesystem = "ext4";
>              properties: {
>                          subtype = "image";
> +                        uuidcheck = "${TARGET_IMAGE_UUID}";
>              };
>              sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
>      });
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 6cf9bb1..0ba3a0e 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -23,6 +23,9 @@ FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>  SRC_URI += "file://sw-description.tmpl"
>  TEMPLATE_FILES += "sw-description.tmpl"
>  
> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
> +do_transform_template[vardeps] += "TARGET_IMAGE_UUID"

This continues my question on patch 4: Does that work as one would
expect, ie. TARGET_IMAGE_UUID is executed again, right before
do_transform_template is supposed to be run (or skipped)?

Jan

> +addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
> +
> +TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
>  
>  SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


