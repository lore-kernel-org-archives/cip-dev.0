Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5732C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 11:29:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web11.12325.1676287753189693760
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 03:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fQFjFKwe;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeCTStSA1y4AJVLr+8vsQSG+H1rtUO5rahabGyQ0LZnI/ZSxzIql0Hfhq7h4G9ZUsJNHz1YvrXa+cKGi2wFQ8Z7sXR4WCkEhAfLfkOiLpPhgnk2XhDRj27VkKXnbuQWS6v7ZNlXcZu85zDqZmbpIHQQGXSmhhT8UG5DIuZzXq1K/7ra6j/sQ8dTnJkoCoSYQsKLQisG5VZ7GhcxMmNnkvzm9z3Zytq1n+djT00gNRYn7F3O2gYKuQ2byn2Wgu/+GJFkoLkL/cXl666E1P/6ZMBT26yKoijBdg3jc0KajXgcSqD/2X9k1dCKZC2TSNMzzLpmoV36DFJufoCAL1wdB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mlr74ODXVh1TbpA2LNI8qvag5oPLv+DdMuwhPyAzgzM=;
 b=ef8ph2B0hSvP/FxqgAbIbGUtoaFMNMAtOwwkio7J+RlFfkltGutXbjflALEAB+ph1rbONSf9Sta81+78d2DRL+XhGdJAJJ/mcCLEruyW/UIeynKwBNyZN8aBOe8hp0BYQv0/CmW6goawPVf7oCP4GRK09EgvuL4+1N4+SL6YOIyFeMMg8EYmBtkhvafTvO70YS8a7++gC907KUaDn1ONodCvkBMRsbp6uKD5DSy1QA/ODdqlO4tgTcl8ckYwnbKbiz+achSNw9xzHrmmByVpNY+WAgAxOtG9yNpFl9w9ady2rS/bILxSYWCboUJMBp+l2hZClKo+4TzAg5Ugo2Durw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlr74ODXVh1TbpA2LNI8qvag5oPLv+DdMuwhPyAzgzM=;
 b=fQFjFKwelvCFoDhwKVNFMfMXExIejlRd4QjijhbkKXXFdGXIEc1uC9ZuuGnq00/xBaVuWQokyBRayG28FpoiF5+hiwPs7KgFuDhZI8pCgCnhxJn6arTFR9UQEdWc/FCfRmL5qOr+BjvxkSpmM94rvewrqalWZaoEPVQJWRVWdeXR4cYen4RwGoaOMiKiFoK8uqFYbTmFTRnV3GsfDcehAQe0h9iSGVBzrLjAc9VSj2Z+Wr9E1i36qmYJBr1405ZRmFzTMMuA9wp6LfWpSGABaRgRzgxMKbV4tFP0Ok2uthhEPHlmkoBAnl37OEhkEHpHmBPZhz29qV9vdgw102qShQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 11:29:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 11:29:10 +0000
Message-ID: <f2a2f503-c85e-bd28-aae7-4624283f018d@siemens.com>
Date: Mon, 13 Feb 2023 12:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3920:EE_
X-MS-Office365-Filtering-Correlation-Id: 54082bd6-78af-470e-2a5f-08db0db5866e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o/acIuPQ0+mRHpKeAM5ZLXDTb7Ket7FG8UuW62HUIEIve7nmnrjWrUKtZUgpfS/bLmII+rcLx6tCI6yHYlSO+BT2Iyw5mZrU+HMA8cTYfj83BV55Ap/Zb9dxDpW5SeUezdg1WxgcsfCmeqyhddeF4xYqdRCBRT3nxqB1gFzgpmLM+wiVQr3fHHO26yrWOtWiHdsIPHbHyn2NV0d3zOqtkbi+gqZvoEfWi1PSQcbniWO/MxH4INdx0k598+Hsa5lVj1J5HOimcQu+zl1qdrgoDp2graa1SQ+Jf+hAA6IwQB4sQ9vyTMcBOlkteCHK7rdFPOZZtQle0TcADgJDP/xdU/UlTzVszl5DleOGI46XCKEkdwrje4TzCec238YOMynQ2ezedaA95dd3feiBEfWeS0pjnasWmRRbrnKjm2mPD2dbJcQ4XJsBobuCpa1hix3zIIKgViou7EX/ggbHBRqj1vkFcFXYI1vY1uDCPtK6M6L4KtLv30aLEQyNsdJJH9zYZ4iqL5dCdcp+fNNwsWsSLPSJYKlLW3+bIie6Q/kRetIw1IOzccrXQGETpfAwYjYT7ile5RJ/FSjZsiKeemF5k+yZzkHBLQoTwfDQceezxuF6zFzHwLDXbfAovFRaOXVf3G/rzH55mK91YJnEu6A6rSDyI5YtpXSdScpYpIr5kL8cvEMuE9SyT+G/d2QHnNr3G+5o2Az2LbyiMkFcWX1sw31Vlw7Okl3CitsBDUbyO4k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199018)(38100700002)(83380400001)(82960400001)(36756003)(2906002)(31696002)(86362001)(44832011)(41300700001)(5660300002)(8936002)(4326008)(186003)(26005)(6512007)(107886003)(53546011)(6666004)(6506007)(66946007)(2616005)(316002)(66556008)(66476007)(478600001)(6486002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czhoYUIzRTdaREwwSWc0Mk9QVWg2aVc2WWNUYWErTDVaWUhjMjMyUkdvTnpK?=
 =?utf-8?B?K2hoVjR4SitsaVR1TFNUQkNoSWhoanJ2V3NsKzFjRndaQmVvRGlQRHlSZDlo?=
 =?utf-8?B?NHJjYm9OTHFGR1QyRGRPOHBKUVNscEE2UkRkOGYxQ3BuTlFsSUM1cWIvMmQv?=
 =?utf-8?B?OXlOQlcrdXR3ekQ3UVRCeE5RTTUwSksyZzVwY3RRODJ2Z3JKREJOSnFNSFR0?=
 =?utf-8?B?dmpnVW1xV2FDeUpzb0p1SU43enpYbHdua1F1RU5zRkxjRzM3N2kzeXg5Ulcy?=
 =?utf-8?B?Nkk1MCtPV3h5eTBzeVhVc1FLdjFmVksvTVdkYlBQRWduYTh2RmY1Y3pZbUtN?=
 =?utf-8?B?ZFNxTFlFeitjeWRFNW1YWFR6UEZXZXJXdEJxai9TT3dhMFNjaEJ1aUhzRTBB?=
 =?utf-8?B?ZThtaHJWaG45eEFxUFB5MmQ4WFhMQTUxVlZZcXQ2OUQ3OFZ0djY4azN6NWps?=
 =?utf-8?B?Z0tjVnlLMHFCRnA4U1ZtQUU0dUhWM0xwTGJCNEIwVE5yeUdITE4xQ2FtR0g5?=
 =?utf-8?B?bzRZbjNsUmNReEVWZ1RMUTI2STVIVk5PMUJYYjlFdmhlQ2lHTnNRbmx5VjJo?=
 =?utf-8?B?S0RBS0ZUUXQ0UjA0VFp6QS9nZjZoUlRHWjA4dFJoQTZJTFFqekpCaWFscHdv?=
 =?utf-8?B?cWJQYU0ybld4UEdOd29kMzlCcCtjRjY2U2VrbEJjVG84QTFQVUMrNWRQbkVH?=
 =?utf-8?B?YlhtY1BGcHZGaUluNFJBT0c4SEN4RmsyWS9YK3R5RnNxdkJOMUwyUUUzN1NG?=
 =?utf-8?B?em5obVdwbS9iWTFWZTdjMnhhQUVIZGhQbXpJZGMxOXlEUjlJc0p3Y0xoaWxh?=
 =?utf-8?B?UDNoWnlXZFJqTVJvK2ttWGZqaXN5dTE2eGduVElhUTd1QVVOU0VlRFpJSlpR?=
 =?utf-8?B?eTI5UkE3VENodjZwQk5xa2lUTTk3YXE5TlVwVGxDQkFsY3lmc2gzT2s3amhD?=
 =?utf-8?B?cmMxUjkwdFlmRUJ0WHFGZHJkSHIyUitZb3pCZG5zWVJKK3VCbm5FdFVYNUxP?=
 =?utf-8?B?cm5KSGRlcnQzWkhLNHhtd1N1Q3pqTC9lcmIrOUllelFBVllxYitLSTRvTXhD?=
 =?utf-8?B?OC8rMnVBaEN2ZkRpWnVYRUdmTFppVVhZWTlwMDl1dE1OazhQT0hxcURScU5z?=
 =?utf-8?B?K3BHaWt3Wm5sZ1lndUtnZWUrN1dtcXZXQ0RrTG83MHBjN1NUZDFyb0dpM3FB?=
 =?utf-8?B?WVgyNWdUNjBoTEZSdVRzUnlFSllGZXh4bnpqT1RVVlZpUW1mUlRHdWVkQ0pa?=
 =?utf-8?B?dU82Um9Cb014MU9pUTNEbVpQN2pJeHpvWnZ3ckN5czBoZ0tSaXFvUHRCVkdZ?=
 =?utf-8?B?Y3BnUmRGTnRlNWdLUGRVNFd2MWJ0MnJrd3VYUzl5WXF2SHBoVGkzbGFRRG1P?=
 =?utf-8?B?TmdybXJqUmN2K0NCNys3dEo0M1NnK1pONWoyeEVUb3RodkpNM1h5bXRmc2hY?=
 =?utf-8?B?Y2tjWHk3VjRrNEFWMFFLSFdUbW5jYUpEWU1MSUtNeGpia1B6dDBwNzNhQWdI?=
 =?utf-8?B?azVZS1dyUUxIWHpmUHBvNFo0QmNTUWVBL0w5OUpkQTRxVGVlV0dRYnFud3U2?=
 =?utf-8?B?OVhyRkNjREhIcHNYb0FmdHBhbWllUURCaFdyaXFPbTl2anpXUi9yOWtVcHFS?=
 =?utf-8?B?Vmh6WXo0TFNSLzZMTnljUVFva1BnTE4zK1pNM21SZXk0MVZsL1ZicmN1VGZM?=
 =?utf-8?B?QlE3UUI3VzMxQmpOa3ExeEFiY2pSSnkzUWplTkJ4YTh3bXAzUndTVjRGREQ2?=
 =?utf-8?B?N2xZUWdTN2NhaWk2bnVZaGRsM1V6dFJKTnVUdWVBbGQ0WmViTFMrbFluWERj?=
 =?utf-8?B?YlV2cFp3dDlKWXovNThwOEkzSFZOQmw1T29mWFJLOGZ4UVcwRXQwSkY1eHEw?=
 =?utf-8?B?SmIzRVpVck5EZ2YrRjVDdGZoNDhZYzZaU1MyZklzcng4cTF5UkhXc2Q1M2Zm?=
 =?utf-8?B?cCtlcmd1dm5VNkxvU1QzMHZRc0JzRk94aUlMeXY4bitOUG53TVo1TnQzK1dr?=
 =?utf-8?B?WXNzSXh0aTFUSkNFaURiUUl5OHh3TGZSUVVIUVE2VVZrL2syazNNa0s3NzBM?=
 =?utf-8?B?SU96QjRLSDdhditsSXNUN0Y0K2poQnd0S243TWdpQm5qNzkycTh0V3JsNjR4?=
 =?utf-8?B?U3NZTzZXVVlpWXZQaTdsSTBDWmNwMUJKTTZPSG9hbjB6bThiNVhyV0RaRUdN?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54082bd6-78af-470e-2a5f-08db0db5866e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 11:29:09.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoP5YJzcM8wHQE+c0GXIGNNm3jTmm0gIc8tjmhU3GdkBddgBaLCC8MN8QZwtOoOC9fk8soeiYB9PuDWEzQScZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 11:29:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10678

On 13.02.23 09:57, Felix Moessbauer wrote:
> The efibootguard package is architecture specific (similar to the
> systemd-boot package). Hence, install it for the distro-arch, not for
> the host arch to make cross-imaging work.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/images/efibootguard.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index 26026dc..b3fe911 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -11,7 +11,7 @@
>  
>  IMAGE_INSTALL:append = " efibootguard"
>  
> -WIC_IMAGER_INSTALL:append = " efibootguard"
> +WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>  IMAGE_FSTYPES += "wic"

When does this bite us? Current master is not affected as it seems.
Bookworm/sid, when all efibootguard archs are available at the same time?

In any case, another regression from the switch to buildchroot-host in
isar. I had fallouts from that as well, and they are all subtle to
debug. Must be documented in upstream's RECIPE-API-CHANGLOG, with all
its aspects - please fix (you caused it in the first place ;) ).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


