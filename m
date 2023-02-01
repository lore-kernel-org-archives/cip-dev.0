Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4951C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:33:52 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.40])
 by mx.groups.io with SMTP id smtpd.web10.24687.1675262022337874874
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 06:33:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QE+syWEv;
 spf=pass (domain: siemens.com, ip: 40.107.249.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCU9WPMJxtBm7hrpesNvZQ+kufwif96SCrE9azdEt4BhXiqnEPuffoW3e+t3Sh9cWltjwMfZjiYugnX+duxA2rhGgilr0wG+UcaRrNHGmmUvK/0qdNL4bkmeGEpn+A0AcPIJk1LTPf2kj3tnbiiex/aPbW/cqsnJEJLRuFY/rxMM6LMqH9zQ0wIte03a+WGNfca9JDH0GrclX0sKydLiREadA22SlDree5hCBDuZ+2qghmJoD7lC0VEpjYMf2UeduW96DH/Axgi89FOgQPop+WKfClXvtO+LRZQHHjZUYN448eTpVvAQNjctXmOVP1X31sRxl5ilqZK8jpPZKPSPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHKl3XVtj0lD9emSlDoTtpUZx1uINbNR5NjCPzlyx0g=;
 b=YBu7NVcuuU+Elxx2wigy5JA/QH+oDUkdaF6LUVXNyXIbp/ga1TbZB0sJkmE4PunvMJg1NedObgvJadYzHCs1r7Kda8tI8j2h+uwvuyDLJomlt+z11dnHoWMs03eNfKnPiGASWRtPFAkvM55Wzlaz2NQS/Wb/z85erY3eOE/+ZXFGZdK6CZICPjBBB2zk9U150vkaDeEuFxQuyL5wX6lDFyUD4f3x/oGNDYtuLroEFfYR21gQdAJAWENh1u3blnbGiEvOEEUw66fuFnG9TeEhW4667iJ+Y3qiAiCUNFJHvdDV43ierIudP0+sht/x/7PdPrIg+dtJduQcDgXCeTYycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHKl3XVtj0lD9emSlDoTtpUZx1uINbNR5NjCPzlyx0g=;
 b=QE+syWEvs3myNAyv7t9o/oBLmqA5L5xB/JJsfsKgMJNuvlw3xDzvt9VelOd4r+3eMLjWQQz+OIIQ34iDmMVoYgR1JAwJV5xcNbjU0xWfOlmwnninShsZDDXysusnOOam6yChEo0hm2f5Th4bPlV1C7CcQ88WZXdap7gh1efInk98A0dU7PHbJS2ke161WfXri5D1BZbfq2Gfgj+BQED8/vw7y/A8J4yuOvO0DbD+u0Ag/mlpcpSjZMEoR/9ofFp8NSnEj8I1wVTqqZnQ5ZmpXvFO6Bd0GOQumQ+z7cuTfjqyX+LxOavdd9/2REbcjCtg+Zw944aH5W7fYznbrqOQ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 14:33:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 14:33:39 +0000
Message-ID: <96644dd5-6b3b-d367-98ee-a1e8432a922e@siemens.com>
Date: Wed, 1 Feb 2023 15:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core] kas/opt/swupdate.yml: Add tar.gz for reproducible
 build checks
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230201142946.25192-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230201142946.25192-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2f9239-e181-4cb2-8d3b-08db04614f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YzSPkHsqcgHRYNCmGS9CLTxVMCECrsdNecDPT7+Icnlssj/uNiWkUYVt0s7N3YcY/lQDJAXE3hPvVL/0y9HZEOyDTSiza/6KHmX6GRObgIDC/4OqdUdIcqFKndnt0VdyaUU+n9rGKKfl04JjU0wQSWa8v1vripbyoxEwCCYW+8Ne4YPux58OWC9hHyhwiUJpW/tm6MWt62Wn7fARjyy56DSELnd5HMOKgerVa6X296SRDk0hYMOOX6Hd7VzOge1wPGDRhq85/BXfqWTyyWtSSssSCw0cEd/+DoYvwBtFz++jcUfrjjrfuNGfgTGiLWv/lZARiBLzTSf57JNZbg18gpdhdhoBCab518lC0JKEfdqa2u5Riu0Iz3YgWJxmPytYj1IBqcm6EgfUoiPxOPC/L7sBc1WHABWC1ecnUiFR+41TWM0KDQjJI55bs0N1SHbOs/nF8SO4SdSLY9LfXaQKuDuQ5GMGZO0bth0iKQ6EJYRCQW09ZYVEiQlTHD8t6pFbDgqGcFaBTBmlnAn7MJkMioGvkXL+WhD6PLahFwOZoGU1cBkrutKinzoXeo+2od/tfra3qvRzm+iGFjK6czTq9KoRhkReC7O7KXjg5Qmio2TX3eGuKR8tdMzE3cqh622z/bt8WeEu9BX2ZdiTi48yfw3iH1zp556WsWsAWk24U97Nb57hucIaSGL0SHwHkyjyL0IxCwI7Mlr6mWh71ZLHUFrfozPh0+8XYVz/xgARQ2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(66556008)(41300700001)(31686004)(66476007)(6666004)(66946007)(8936002)(4326008)(8676002)(316002)(5660300002)(6486002)(44832011)(83380400001)(36756003)(53546011)(186003)(2906002)(6506007)(26005)(478600001)(6512007)(86362001)(2616005)(82960400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUN3dnRtU3RZMDJRQUo3UlBkT0IwTEwvTTJES1VlR0JsTCtNd051L21lVDZB?=
 =?utf-8?B?MS9GQm5FU0REelpkR2NSbEh3TXpLVEV6T3JqSzErQ2JUcVl2dStzUHYyKzFJ?=
 =?utf-8?B?Q0tLdGdQZWZkMnRUSzM1bDUvNkhIc3BxVlhGNkRVRFNLMjZPd2pQaXd0S3NW?=
 =?utf-8?B?a0tUNUNqTkZxUk1NK0oyb1hxaDY5Y0xQd3AxbWdTeTFKRkNIVVMvWkNORUZY?=
 =?utf-8?B?R2ZZNWo2bDgrTS9TZHlmMTcreGhocVJDYjNiYUZvRVltQkpKU1hhZ0tTeFUy?=
 =?utf-8?B?ZEFrS01WT1ZIM3JpV2M5RG80REpPR1I4WVFXQnVtTGc0UmhuakxuNWd1Y1JL?=
 =?utf-8?B?RDNyT1JmRktsQmRpK2R6aUwxZnV6QzhXWXN2YkRoc1V2cHk1cmZwcitoTU1M?=
 =?utf-8?B?TzlyYWVQbXBYUGlZYmkvOVIvRThBY1pYbzJaYmViYmJzUWx2ODlaem9qM3A1?=
 =?utf-8?B?MnNORWR3Z1U5bVRrN21LNzVVUlhldkJzS2M5Syt6Tm9CaEgwSUFvbGdqYVlu?=
 =?utf-8?B?cmhycWZIeExDNlo0NHNzOC84RHNvNnExUnNQaGpIMzJXWXgyZjhKZTl6NEph?=
 =?utf-8?B?S1JjUHd2UGNGZDIxb0srNG10ZWdVOHRwbWN2UmtScUFMTy8vZ1RnKzNZYmI2?=
 =?utf-8?B?cVFjcmhSWGJxWUwxSG40RTVWREpNYXZTd0lCQ3JKa1l3SmJkc2JzVEVKcndv?=
 =?utf-8?B?c1ZoeG1BZ094RzV5amhxZGNHSGJwK1FsTkEyUGp0Zm04SXl4QnUwYmNyTVc2?=
 =?utf-8?B?R2lCWUpMc3hSS1pVWTllOEw2TS8yS0szNzZEUUkwZ25oYTRpS2c0RzFNOXZY?=
 =?utf-8?B?ZzZBRFAvNGRySDRKYVprSnRTcVh1dW5SblNtUWtlSSs0R3Z1NnhkMHVYYnBx?=
 =?utf-8?B?aXNvZ0lqYkJwUkxOcWZLZkdkSEM0M3BRV05TSmlmTWhzbTNKRUhiVGk5SVVH?=
 =?utf-8?B?UEZ0YmlFK2h5aEJneVpLc2pKUGM2VEl5R2FtUlRWaFhNTTM1MnQvUFIrN1JT?=
 =?utf-8?B?ZXFQWldUdVp4ZXhjNDgyL3E0SUNTRjB4Wmw1bGZKUVRlZHFyek0xaU1wSDhy?=
 =?utf-8?B?aUducmdzclZRNzlWZlhZcDA1WUFSS25Dbzlwd2tsU1kxMkNwUkduQUNmTWhn?=
 =?utf-8?B?MTZXT295UWtLMlJNbG1BZFVmOFdJUHFGbk9BKzRIYUlvRTJJbGtobVVQbnJp?=
 =?utf-8?B?U1B2ZFZGZ0trb3VTL0I2TGVXOTJaTldpc2w1ZjR5Smh3R0tyaWMrZkJVWHJM?=
 =?utf-8?B?T05SNlZkK08vSlQvRVZTaU9JbVR6eXdSZzlaZkJHVjI5TVA4L0dEc2p3VDF6?=
 =?utf-8?B?MUV4NlFLb1BmaXVvWTlwaDYyM3FlZGtPSjFoVGpVeHdHdCtCV1lGV2k1Tm5N?=
 =?utf-8?B?M0JhaGNwK2FvNjdZeFE3OTdORUJJV0tLOGFGdkZqZlc0NjVFbXBrNGNnd1BV?=
 =?utf-8?B?a0RXSzhOQXg2Y2JueUhIV1FRckV3N2t1OTg5ak5qRy94TGpUekxVUnpudUh4?=
 =?utf-8?B?UFZVK0U0TDJzQ052UUIycWpRQU04dXpJWjBvY0k2dTl3RFgwKzFjenpYanEv?=
 =?utf-8?B?dWFrdEM1SVpwNlVRV0NtRDhRL2V3aStoN2wwcUpoYllReldSV3k1Umovcmxr?=
 =?utf-8?B?NGpkQm9XNkNBZWt5UHB6SUNCMGM4cUxsVVRwRTY3NE92L25kNzJsZlIwZFp0?=
 =?utf-8?B?M1c2eUNmS25zdkFVdUJiNWNtSjJ5cWh0YzFSVTJPZk1Zd2wvblBhdExxUENQ?=
 =?utf-8?B?K24zeTB4d3lnN2ZubEhXTE5sVEU0NmJ5azVpODhCOUVxUi94cmp2b0xjZ29V?=
 =?utf-8?B?eXJDZDVVU1RJNlFJdUJlRFZ3UFEzVUZMVmErbm5YMjJJMm9LWGg3TlBGa2NB?=
 =?utf-8?B?M0dhMTFkVEptVlJ1R2pLeFlkU25XWDRncVVBa1dKRGtqVXRNdHVxV2ordS9k?=
 =?utf-8?B?RllhTFhucUhudVJLZkhVd0cyWHUwdUxpSjFSdkNOTXpZWEdSMUxadGRqaGFZ?=
 =?utf-8?B?YVdMaSsrclp0d0MrK2VtcDRwQ0pQOE1yOU5oemZLa0NvSE9RVFJadW92UUlw?=
 =?utf-8?B?TEpQRVdwMjVPVVRJaEF6bTdoRUVxalIrakRQdmFqNi9ZS3JKRW93N1psVitr?=
 =?utf-8?B?WndEbEhwUmUvaHNrUDg4aTRJTWtQS0hUN1lwK1lmQ01LYjNFaVVNQjNXbENW?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2f9239-e181-4cb2-8d3b-08db04614f27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 14:33:39.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc1TqeFqHQdghkSiLlJwMLsJZFGVYAQQuhiuZHihcoEf0Oqp6GsiYnNnLNF9aHe06uqQsdxaKlEzMR+Eq4vmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 14:33:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10560

On 01.02.23 15:29, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 

No reasoning given.

> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/swupdate.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f0d3f1b..7941769 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -21,7 +21,7 @@ local_conf_header:
>    wic-swu: |
>      IMAGE_CLASSES += "squashfs"
>      IMAGE_TYPEDEP_wic += "squashfs"
> -    IMAGE_FSTYPES = "wic"
> +    IMAGE_FSTYPES = "wic tar.gz"

This makes no sense for the original purpose: Building an swupdate
image. At least to my understanding, that tar.gz will solely consist of
the rootfs content, can't be used for anything related to swupdate.

Jan

>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
>      WIC_DEPLOY_PARTITIONS = "1"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


