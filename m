Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFFC46467
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 12:53:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.74])
 by mx.groups.io with SMTP id smtpd.web10.44205.1674132781097510186
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 04:53:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aFXR0K7g;
 spf=pass (domain: siemens.com, ip: 40.107.21.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl7qbHYQ6jyVaHQdP9O/yU2/htGlQKGb1Wb5ZzBSt0dqVtKbN/1fb4OWb26aAWe5Ww3zje1mMyfkdTtTkEovABT5zwO6pgWeUutZY03QShVMyfbqHGgIVQhnM7u8QI7gDVPq+aISrEyr/CU+HrVAYAMSg5j4GKiFVL4Yokau5L3Tpp2k/MH9pR22bW1JgM8LDA5wgrvMhQDqs40UAV+3UIour+37OvRgDMultwXD7rLhQW2vSJTt7LvHrVG/sx3o3e7CfUlBbkK3EQGIlZJofDTFUnguEuyyNGnrvNdIvJO1up1Cy05Bnlehku3Z+J2XJEii9zWbXlCR7K9AXK0Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbsIirPM7/ceHsWlEl9tO73v6zh69EApfNkVNxIQ6xw=;
 b=AYohmQYeL8kHNPGqa3noXa44RtCAwgQcdODtkSBJvEtbK2hXxewDc5pSrNqmn3I5XCbtwJsewVEnYRWWxS3fL7RmNInr/nK+T415ldyNRcavJpyg/HFHHKoMaJQHTIFLTw3wFIgD41popsnFYt4pQNHcc2XuWSyx4hlzeisDgpULlilussP831VOXPAmdjuwo16sq9ZcYzRNSbvAspt9e9iLyDug/wPvn+gLXeseA9Qoq0Am/gvFUHREEixmZuGfwpxm+MheZenwxiYn/Pco2kl6EtuYhdORrflntWkay15EkU9EALD7EqKYXcp+q32WE39niy26la1vHx+vbesLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbsIirPM7/ceHsWlEl9tO73v6zh69EApfNkVNxIQ6xw=;
 b=aFXR0K7g+YuDJ9KCojRUlGPIEDI4C3AOnOGpl2gpedJ4VcroZ7sD+4P+oglzlWswIhfLS8+agSHo41Ef7l7P/S4Uzbo6/lffscBMJfum0ZJ8zZW0kvMEqGtwecuu4am/E0FWEugPkp8qXTRN7Lf2tj15u4pxkiFjsMFy76KIMAXMVfBKBycZ4qg/SeKbbKrdnwkK7JMzDI2jrAw+sjBKIGqVrNqPd58u8y7dHMoHwGigLTO7DyAOTFCt9NCZvxNCgXTDG+hYJbT91vS2zK6ilhBWhDFOqLuy/AdW0F0LM6DrdCX6LGyKWC9w6JaRBUM9/3DEJ7nJnHkEH18eONxacw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 12:52:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 12:52:58 +0000
Message-ID: <d7a4cb3d-a75d-e32f-4939-6606134d6d61@siemens.com>
Date: Thu, 19 Jan 2023 13:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] fixup! only copy "A" version of
 rootfs part for ab-rootfs
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230119115936.528466-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230119115936.528466-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3032a4b3-b1e5-442d-c371-08dafa1c16ff
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VHKousycwSb2VyvAMvA/dmuUKLb9kQGJibRmNWTd2A0CrGhPm9VtpsZalIQIV7Rk6Kir9Z1DSWqn0MTLrYjoXIb/QBf8OZtvJJjm311ICj/T0VYkZ6NovXaJXFSreYpVLuT6pgSLExJ/M71fut7FoPcI/uK7glFENpZ5xQ2by5xsxqIxHT6JabQ4UlRDiV648b3vARZ9boxJ39+aIV+JhAL4mcYHaJxQ8mH/f8nYzVcCa1NlWnJzpbjOfJWYUvCg2e+6kVztOhQOKNieMW8DUqx5Rb5eC8DqPYi22JfILEoLtgUM/k/m/iMhOQ4loefTapk6UIyeTQOl8or9K/35goD2ZEuYjP0CPIYy5IGubVDdrw5uE3iG7tPCJC9LuDLN0w6uY5jQq8681IYt6mtgzud9HW6ts7wrvmXCmlV8hpnqUQBvT0geX2UDVZqWcoi7oG7ekoDSMVG1X9UlIqDTAhhD4x5nwUIzO5Ccn921HADODAuzVflkkiZHrYqGrPhT1yDdMueRly33BH19VGCvSWGcKjrM+5vJKUMGyGAXr/8MEH2CCaE4webx1FKHBO7cy7V7vOiGxP/WxLjTaFQ6/Qh6Vlu3WwHDaH4L2cWdUNsWyN/Btjn/VrqTctK3LVj8A9ng9QUfgX4hG/bhBnlWcE3GtdkZXX86gXsVl3aiOFKbn98wPNfC0ng0deD/c9QQmXGPtJcFoa1buqGced+2gHr29Gdpuh8QdNZ3GeRsAjd0w3uZ+0WHp4b5S/QS4XW0b6pHUPE5KL5D0/yStEtLaA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(36756003)(83380400001)(41300700001)(2616005)(8936002)(316002)(2906002)(66556008)(8676002)(66476007)(66946007)(82960400001)(38100700002)(31696002)(86362001)(44832011)(5660300002)(6666004)(53546011)(6506007)(26005)(186003)(6512007)(6486002)(478600001)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFBLUi9RUUlhcjVLQ0VZN3doejJJZjlBeE1jQkFiZlcxN1hlQmpwbnd0aFRi?=
 =?utf-8?B?Sm15c08rUjFTZURSaEowdEhtcG5XZkNLUnd1ZWx4bmVhWVdyRnljcVVyLy9F?=
 =?utf-8?B?a1hmSUFtS3AyZDBSNVJBMEFueWtrSUZBdXExOHY1L0lYTU92YUZXVy80WFpB?=
 =?utf-8?B?S0dsOFdQTkJCdWFPNFBGZlJwUVp0MnFEclVEai84ZUo0V0Y5Rm9aQkFaYmVD?=
 =?utf-8?B?RFZpVnJ6QWdKT1YvcFhpN0VxY2ZxTUdWZzJGeE50a0lUWTI5aTd2ZUg1THlD?=
 =?utf-8?B?dERvbGJnTVJBZzQ2K2xlb2dQOXFjZEJRQklaTTZxb2pRaHFrMkJqSlZZbnhs?=
 =?utf-8?B?YWtnSVRMd3MzS1lVQ09YYkVKaHIvVnBjd3BNbDE2bzlabVFLU1FIcWtTTE0z?=
 =?utf-8?B?ZVVHVjhuZUZFbjJucDlMT21ZeGtIWHRHa1FucndFY2RHRWNvQkVWNjVuaHZ2?=
 =?utf-8?B?Tjk0REZhNnUzTFV4QmJFSTBZVTgyR2JBbFBvVUx5R3RxN3NucERsL3MzSjR1?=
 =?utf-8?B?SzJxeDBCZVFKMFhiMW04dm94aWdBL3NONXBhUjJZdmZITTBtT0UzS2wvVk9L?=
 =?utf-8?B?THJocWUzSUQ4Qy9haUJ6QnNkdzkxYXQrY1NrYnRNSzJjeldXUnVTZE9xSmlM?=
 =?utf-8?B?c3NqcDN6ekZZeWx3RThUTm5EWnVXdXpMbXBmY2pkMG5GRWxFMy90Yk9pYmxQ?=
 =?utf-8?B?WXllWmNWU0UranBmVFpxQUtRY1dIS3BaSytTb3A1ZERybU1oTXIvaXBmaGFM?=
 =?utf-8?B?OE16aXlPYm9rNmxJQUJFZWJURmk1VVVPQU1scHV1R0s5VCsrVmFaU1lwSmgv?=
 =?utf-8?B?WlAyZHNUbk5qNUlLUVQ1L282aHdPcllVbWNWc3Z5SjROYnlEM1l2ZDc0MjZ0?=
 =?utf-8?B?c0ZRMjdYUGVJMTFKYURBWi9hNmlYVWpHdnI0QUJnZzhSbHdBUGE5Ync2RkdY?=
 =?utf-8?B?ZDFDZUxvaWh1Z2htQkFnd2NpRGhLenl1TStqcC9QSEtRUmtiVGIrbjFibVB4?=
 =?utf-8?B?U20relErV0tEamNqTjRTVktxMFNxMlNwYlRzdnJZcUZTQndKeGFjSTZSOCts?=
 =?utf-8?B?MWVnaUFuWWhEakRVYWFRMlhTOXZzUkdLZkxtK2J3NitsYXg2MWVjWmVmZkxY?=
 =?utf-8?B?YjNXNk9Oc2c0UVNydHZ0NDJzK1RtZjZOVjNha3hNRTBnL1ZyUFBzYjBJY3lX?=
 =?utf-8?B?ZnpPTUNhOXF4bUpja2ZJcFFDc002bUovci9xOUswVEdLSGw3VmduVTl0TWR2?=
 =?utf-8?B?T1dLM09oN1QzbU1ja2RrNmhPQXA0cUFnc1g3NnNTeWRzY0Q3TkpGdEFESXRT?=
 =?utf-8?B?WlZwVWEwYjlKWjdISHFlc1lKV3RUY283K1htUExWUkVJYjRPck9yQ3JoMi94?=
 =?utf-8?B?UzhjM0M0aWx0bElhYndGcGVZL0phQ2NFejFXVVo2b1RSUWVaR0QvM05xNjdj?=
 =?utf-8?B?Szd0KzJyTW5EbFhpdUgxcXdadHB2UVI3dE1Ndk9nRTdyWGk5Y0VzYWRUdStX?=
 =?utf-8?B?ZDJiNTF4U2VrNndXUEVmRmZYRUJwVUN3dW5TZmJUcXlYNmxaU002RG1NR1Iv?=
 =?utf-8?B?TmFJRjBSV2NHK2FIanIxcFNyVTF3N1VabWxuMllsOXIxSVVZVUZlOHd5MTBF?=
 =?utf-8?B?NTlmVllTL1lwVXJIc1BSZGFZWHQvMFVJRFViSjYvdEtKaFBQTllVanlKYXpl?=
 =?utf-8?B?bDVGV3N1UTlrNEg0WjZQSGdjek9iZkxyM0FZOW5DdDNrZEdvYjZMODVvSndy?=
 =?utf-8?B?eHFDSEZpT2Q4bTJDTmR5VGluRFBXeVR3RXlkRnNPcVNUb3dwdzc0R0tUMGdB?=
 =?utf-8?B?MVpzbUVJbHFSQVJxUFh5cWhGS1ZEcFh1V0dlam9NQ1pKRnNtT0k0R1Fyb2gv?=
 =?utf-8?B?S040V3VRd1hrWWhoM05FMGIyQjFhdlJ4Mk5xK2hsc3dHN2FJMzB5NmJkRktv?=
 =?utf-8?B?elQ0dm5LZ3YyY3l4MVJUNm1jR1BOa1lKNWRXWE5najNmbERvZGY4N0dFVnJ6?=
 =?utf-8?B?djQwTjJmeVM3SVJTUGFSWjBOakw0a0xhamVYZmltaU5CZEtqb0FhOWtuZ08v?=
 =?utf-8?B?SFZnOCszV3lQaS9UQUhkZFc2MmgxSjBPODROcDQwcHF3MjZheDg3d2dyY1Jr?=
 =?utf-8?B?aDVSUWJvK3ZndWRneUJnYkYya1pkTGNsWHpEMkRqbW9IbTJwdmVNOUhSZHZD?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032a4b3-b1e5-442d-c371-08dafa1c16ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 12:52:57.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/XEsSPYJ+jioA4eq2OoReWG8QY0VgXCcTlTeTaPT9ZbDZu6fX1K1Z0iUV/iNTb8y4OdVFPSQKsh0DNNHihZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3476
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 12:53:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10439

On 19.01.23 12:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes a typo introduced in 231ccb71878e8b2a2fd64b31f4b522c155930147.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  wic/x86-efibootguard.wks.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index b4a320e..e48ba01 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home1 --align 1024  --size 1G
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
>  part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
>  part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
>  

Thanks, folding in as the problematic commit was still in next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


