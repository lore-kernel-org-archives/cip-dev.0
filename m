Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD60C636D7
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 20:36:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web11.54247.1677011767729220836
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 12:36:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M11CttdY;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T79fwgHqbQHFrl4oayaW0t7IZiqaZiQqO2CJcPRc8utBEth7GaVXb++mW0AguazuFeSj4eE7kwnhD9RuxChaquLDSo5EuFRWqSgky/mSakigm0af9LTOulmO4WRhzDh8NJlDywETpVrATmSPYks2A/uqvrPjozVyBLrc4Tk3pRtV8MaE5wANPXWh3CBqutEAoGJhBIgavfCKORoVUCpz1wzV6jeEtA7o6e/sBsJ4886IEaDjG0OC18agWACctmsIeGOOl+DdAytIsb0hcWjsyh2LP21fxkFbynIGsyqKhG6rkJ2UamoRb7wGbnIeWXsTscqyUWMGaXNrUETxeRgiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSrccSDyJryMQxMH0+hIwhoBRq4ioVY5gHzME5cgiKk=;
 b=RtbFkYz4XQyKAHyxnRKDUOI9DWjQYm44iBuuRvLJ6QEed8fxvfJlDB9QnYpw1PdHZYBUrJf8d0eVmiDL6nOneyCEuyZGpPFENPFZafJEFC9bZXObH0Yu7b2bVtGNJMlCwYpeBkmFAPdlwrZ2M+Yib1n8QmmqQi81gHeIb0k966ZC4asw00X5Z/avmUSSxuoZ1pZ/qwTPM/iqAU+007PQeY5+QkPWseSTta4Ar2kKok9W4FPNgzVbQqTNSSNjAEzqgM8zZPX3Ff28IpcHqr7oE/4L5ZMaBwJ34Sf8wpv3g1q7TeBJGnzhf4mPIoNiWIqWJfp+ExUvILXefuRql0bDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSrccSDyJryMQxMH0+hIwhoBRq4ioVY5gHzME5cgiKk=;
 b=M11CttdYBnny8oGccZH89XEFESCSQWCwW2KcrPd3rW37HNVGp76Ofm5u8j4QzKGqGLVEsrjMHXTJDG6ucjKJtPPopk8QBDferRuROYNg0hVEF3gl/NsdnkRd2Y9g1s8o592CZFPgS1ICeWpOXEqSvEl8RRjojas5edSEC6Qk9BnYQHgbHPcCtSjaNajv0lzjIzLLhJ0AI8IUqxFjfF5ubWfGuvlowBl/iW0iAfwUoDsbxQ8ZcYuIWXYqed2c1466J47oe3LLz23byIXdtKYyJ2QISj9zq1ZpczlUNF3tkUXMek98Z3kw3WAeR8aCkyA5ev3/b2m8HQGaFpAQi8Lh5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:36:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Tue, 21 Feb 2023
 20:35:57 +0000
Message-ID: <7457dda0-5ce0-bcba-7882-903cec858de6@siemens.com>
Date: Tue, 21 Feb 2023 21:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest
 one
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230221135032.1850174-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230221135032.1850174-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3635:EE_
X-MS-Office365-Filtering-Correlation-Id: d42c5783-0335-4521-293f-08db144b3c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R1j2SOLQbZWna9jpf91KdE41OzGe+QH3k/vALZ+elTa4WOQUk6c4b0FlfgvnWD06JiGRaZebRwAJ8nFuvxoXsYZ+4xQpNOgzdic/ERtij4W/+BNrVwSDSwIAQu/KpXax3WZxl0UZp0yCMlcZErhKNuwBpGaQBzEj7kr436mCpSAvke8Paw6t7bgRxipmC/Eq7XXSg8xTNcJhXUvh5OTHVBxK4z947Te/l+ZHwbQCbwTt8WLh/URvVfb6xBwCTaqQ8yVVU0zBhUg9jR/4o5uHrJcPfz48WekFxGAAHj0W5DlKl430mKU7sSlEh/j1Fk+77TrKjUpgiF3xIFMyUWm9ly834/pe/lbjZD/97F4BrEcqxm4z+xBG4eXEauQpflTmbw/lTbwNVFG33snEzj29/i1sqinIiPhMbVj5/gIM0Rlz0wkv/IUL9M5j0BUfv+HqcMOvDXBjF58pNWq2RDXK6teK8PaRzdcR21T3526p3RG5Dtgkf7oH55ojV73/w/tgU+l8TdWt1PtXZC9mmopOcsspA7YWt5/rziR1kgWHBe9ZDUtuuAxCUthK1LivAgApo9QQWr2Q3oZysLokly7gOwbnsffa3SE6IWxN9t1TrRL2spHXrmJuBLZqWJp+2FfrTsi5qy81awJJqszO6hKy1Fvo4/tZXM5M/MpZn00CT7R2WPI4hsWqsZLk8QpmpVzpf7P1/UbJ6PiJ/NW60eOVSxzR3lMeA7jMsEnmFPlWfFc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38100700002)(31686004)(15650500001)(2906002)(82960400001)(8936002)(44832011)(5660300002)(26005)(6512007)(186003)(83380400001)(41300700001)(2616005)(8676002)(36756003)(4326008)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(6666004)(6506007)(107886003)(31696002)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cllYZ2dVRTB6ZFdNRnpWUUlxMlg2MVlwQ3VLVFozbFRjWUU5R2VZb05lZFc1?=
 =?utf-8?B?dEZzZXVnWnh6aVJBckpsaXRIblNDOG4yK1NhK25pTTEyU2tPMjJ2Q0puTmpq?=
 =?utf-8?B?UzdUTy9uNzFtQzB4ak1qSVZwSFVpQ1BLNnN2ajBkNldsc0lFcGl0empYOTJ5?=
 =?utf-8?B?QnNiaHVobUFzTE9sOWozSGh0R3JGMHRaS2NXSVJkdWhVQnl0K0F6SmRJYnlw?=
 =?utf-8?B?dzhlb2ZCVkF2VmlLL2FrQzQveEt5a3c2UGlkUWs2ZmFjREptR3NpcmxJUVZL?=
 =?utf-8?B?UzNHTU9PYVFDTldDSSs4cEFjakVEdVJjaG12M0FJWXlQK0VZVFR2NGJkRFc0?=
 =?utf-8?B?SU0wbDAyRTBPN1JwMHBnQ1JrdGRwWGR4MHg1OFpLZzQ0N3crTVc2SU5QaXBH?=
 =?utf-8?B?NktQamx4OS9jOWQ5MDZ6RUZXMW1ySW9rYy9jL0xMbFBJN1pvejJ2RmVPaEVt?=
 =?utf-8?B?bjhqc0JCSWlCclgzOUJOMjJjQWt0TEFlaG5OOWh5eTZtVWJuSzNDeTFmUVJI?=
 =?utf-8?B?OWR0bXlwVkFROElCTTBuOGpVTElyVEhUenFRWTlQa1NCbnhveC84TmplbG9p?=
 =?utf-8?B?T1g3WC9vQzduNTNSajVJUWNWUlBpdEpDTDEzbExQWW1Fck5obm1LY3dGNytl?=
 =?utf-8?B?STF4Yi9JN3pHbzlrK1Y3bXpjRkh0S2oyK2lvcWNOK2g0WEhLN282ZFNNL1Fs?=
 =?utf-8?B?UWxpa3FBRnQ2L0c5SUd6Q0taTjZHUXJjSEVrYitjUFhYZVhPaHdzbzNVWHB2?=
 =?utf-8?B?RkJKU0lMTmFKbEgrZ0s4ck9EQStWQjBIU0o0RTQ4Um9NbExVRGxJTEVhSXJK?=
 =?utf-8?B?YkkvWkh4ckROZDh2QWdMS2IySWY1N0FJRExvOG5BbVZ6YTNlaGx6TGNBRzlP?=
 =?utf-8?B?OTR3RlZodmYwVUUxZ0JvcXVXY2hpMWVtMjFNZ1VoczVlaHRBSW1tOC9takt6?=
 =?utf-8?B?V0FTUUtTaXl3TmFkWFVsd1podzZRVE1ZZGFEK0R1b1Rvd0hmMEErQ2VaQk45?=
 =?utf-8?B?N2hkY0FhV1lUcFlLeTBXSUxEanNlYjhiVnEwQkYvMENmRDBGdVpZVkxlVDBG?=
 =?utf-8?B?UEFSYXgrQ0Rub0lhanVnVFpxUndIeEFDM2wvbTBDd0xLOENOUjVZSERTYTFB?=
 =?utf-8?B?dEN5ejFiM1cyRS9XdUtTZE0yakVwM2pLckpLRVRhR2duN2NzVmhyanVSQWc3?=
 =?utf-8?B?VHNFd1dzY2FUK0R5U3BFaVIyTFBMMGVQUWpRWGxCTWF2Q3BrZWN6dEQ4SUla?=
 =?utf-8?B?Y3VybzB2dlhhYjFvaU9SdkZZZzJXaHlBMTdJV1JoUjdvejd5azAvT1g1Wmo4?=
 =?utf-8?B?ZkxNOS9LU0l0NlVZcDJ2dklkWVdncW5qazNFdGZuTjU2SWFIWkJPdjBoWHdP?=
 =?utf-8?B?UHZPbG9yY2xlWGFxeHk4NWNNQnpsVS93WmpTdFJva3BTTEVyRFQyeWtWbHZE?=
 =?utf-8?B?VG9qYm1ZcEF3ZmFFdEVFN255bW9TUmpveVZDWnRMRFN2NXFpR3p4RFJPdkhK?=
 =?utf-8?B?SzBOTmNkUFo3b2E1VHB6L2p3N2d0SWNmblg5UWdLYjE2ejJ6SDBuWitEMWsz?=
 =?utf-8?B?RUQ4QjhubENHQjBtTWJ4K0FjOXpXY0h1OFpZWFVpR1dteUxPZm5FZmxnbnJ2?=
 =?utf-8?B?RVBUdUhNQ0EwVmtLZElFdXB6QVpPR1EvVjEyVXc4THJoZkgxdStFM3orOVBp?=
 =?utf-8?B?bFJKNm1hbjg0ODFoaHQ1dlYyL0dxTmZIZFBkY0h1R29BZk1QOFZsTTJaNkV1?=
 =?utf-8?B?b29BYWl2WDlMcjJEUmlmbDhEejU2cTlGZEVIQWRxVzdCNFhKeHpGQlFxM0ND?=
 =?utf-8?B?QlRTdFk4a1pNL0RmWWpleUlqbzNWRDNsL3I0QjNlNEVOYjVoVTYxYU1XMnJQ?=
 =?utf-8?B?SFhMTW5JMTN5QTFrR2wrdHpyMGVmMFg4aGpaM29HRVFESWRvdUdLZy9aU2lp?=
 =?utf-8?B?YSt1aTU0Y3FxcVh2ZUwvMUxHUlM4ZDJDQ0JIbDI5b25BZVBrc0g5eWp5UlAr?=
 =?utf-8?B?NENCcnpveTVTN2hYTGFoZEVzb0tzdXMxTlhMSmhsNlpEcXp6dFVJMTdMMXI0?=
 =?utf-8?B?d3k5eGNTT1ZORHgyU0RhT05JM3piVFpKSnBkWkpSY0tocThZQmtOMWpaUEZ6?=
 =?utf-8?B?YzJRNjcwd3o4NmdLN0VWaDFlVEJWU01XK1pFNFhUcXdXNkppYjJKREhlVTll?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42c5783-0335-4521-293f-08db144b3c47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 20:35:57.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIbbYhY1Py1xw3dIDLn7kMKf3SobQz737/lnm7JJKfLSBQ/kOKMB+a54BwLeiZzxO8Rau6xSozm+j1mbXXGH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 20:36:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10761

On 21.02.23 14:50, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update cip-kernels to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...4.302-cip71-rt41.bb => linux-cip-rt_4.4.302-cip72-rt42.bb} | 4 ++--
>  ...0.158-cip22-rt9.bb => linux-cip-rt_5.10.162-cip24-rt10.bb} | 2 +-
>  ...inux-cip_4.19.270-cip89.bb => linux-cip_4.19.272-cip91.bb} | 2 +-
>  ...{linux-cip_4.4.302-cip71.bb => linux-cip_4.4.302-cip72.bb} | 2 +-
>  ...inux-cip_5.10.162-cip24.bb => linux-cip_5.10.167-cip26.bb} | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip71-rt41.bb => linux-cip-rt_4.4.302-cip72-rt42.bb} (60%)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.158-cip22-rt9.bb => linux-cip-rt_5.10.162-cip24-rt10.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.19.270-cip89.bb => linux-cip_4.19.272-cip91.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_4.4.302-cip71.bb => linux-cip_4.4.302-cip72.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.162-cip24.bb => linux-cip_5.10.167-cip26.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
> index 5635eea..d6d0a52 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip71-rt41.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip72-rt42.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019 - 2022
> +# Copyright (c) Siemens AG, 2019 - 2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "324f821e4df5f2b364e318e37266274432f3057334f5bc841d7bf49a9dcc78c1"
> +SRC_URI[sha256sum] = "f06c3048ec3a18e3d25268374396a74b64c55cb858d3b4eb98ecc3b87e8d871c"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb b/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
> index 571e840..4cb3389 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.158-cip22-rt9.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.162-cip24-rt10.bb
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "98a83e5727b64081e6a90b9713b182ac5ef0a3957a76c695a9d71822d6a70d86"
> +SRC_URI[sha256sum] = "b5539243f187e3d478d76d44ae13aab83952c94b885ad889df6fa9997e16a441"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb b/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
> rename to recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
> index ca64a76..7b321e4 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.272-cip91.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "e91ca34303d01ed9e366f4d0a171f96eef61242623e20bf3e175a8ce10f0a386"
> +SRC_URI[sha256sum] = "680405742299138b53247569855d13c737e07af1fd191aa69ab60ce9e65f51c8"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
> rename to recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
> index 8d6ab64..7f4a386 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip71.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip72.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
>  
> -SRC_URI[sha256sum] = "864d7e10e123bd0888018279d5f61257eae2c11465fb1ef2d0b10dc42b81d513"
> +SRC_URI[sha256sum] = "35ca43e814bb87b0da610b9682fe10494c54436f6de563bf3cd42d20746ca4d7"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb b/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
> rename to recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
> index 566caf6..7b0667e 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.167-cip26.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "fb0edc3c18e47d2b6974cb0880a0afb5c3fa08f50ee87dfdf24349405ea5f8ae"
> +SRC_URI[sha256sum] = "982381137420cdf4ef96b95ebdf6654973bcc1238f497c455fcdbc272981b883"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


