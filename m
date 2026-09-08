Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1546CC79F99
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:30 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2469.1788892879605030235
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2026 11:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l4bcOe6s;
 spf=pass (domain: siemens.com, ip: 52.101.69.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip8+3TIoB9DrsaJFkHL9+xQ3E5FMr11tDsrrq0ECfXLv7Fu1lfio9ER0Ho/nkHu+4JxRPRiCW30kyHwc0pLTjmmBX1Mqg+DSR0p27o8etz4vAgU09jJN4oGloB+91gOA3heSXWIUmDVVZaqyx4dhfZN3nLpmqLKykZCncB6oYbaIr1YqoDi6984p0F9BZFCwfCBdDPzXiM6cVFw6TTSxz5ZCRjZV+cXRsSNEvi7aIPqZWKhANoq4iuZivZMpXXLYiCk0LleKHyz7dqpT7AdLIhxoq/55+VWxL6mH7A3FwbrjHxD99r4ZqsAu3Rm0TXLzztV8uT04h5f4oV8paCwKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GDrj57ukqiOCkBShp8mXutySJWq9NRSbr4qlxlwKJw=;
 b=p4DS7WH6ULyAEtC/FzPVvEPiumz3iA3gLUr/P3CALbJdzD+O//Sc9T+x9KgW2/gjmP6PqtqEiGSxDwxSNjc7A5Q9imlIwSCtdaZHdK6u4lmwOt35Fh/r4lPnB7eVh0Ok4wIfY8lOo+HtzjqzcrwzzjJBY/mN31mZUAEKCqy8Z+tK5u1nSIJr1sxa4Jss8OswMqoA7njca/wOKBH1FUVlSuFz3rx4oBUzN3UBRmxzy8+BbK+B7Fok9XTXPfOpplK2hrmEeJfolU++7vobKbxZmklTMkQYIpeWuDPKZRrIjJGUv3ymC26kcYp++0iORpQcut6pOjcvi8al4r89Tfy2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GDrj57ukqiOCkBShp8mXutySJWq9NRSbr4qlxlwKJw=;
 b=l4bcOe6sQvjGg0Qer9Ht6AqI7VeVbeRltVrA7KZWTKoGoa7XwF5QC2UK38BvbqQbAYg5yjU7QhTQfjkrEnLLXZy+G3QYM5TvVXr8npJCb1qcpYdx2RCFXFTObiFMzBWDtqDvUbGvdgrSmk2efuV+Fago7V0z2F1xR+yPWN/Vph3YOhIj0OhmjgEUARKTxTIIqPOa8cmEr34vkOVvU9X/ubuP9DQ2rKxVAr9tP77gUw7V4WvKqvCu2QyWn0DzBi5vTzT4V/MkGtW9AMxNTUTwnYVphFHh7upAP6vd8GdtQeWsvRoeHn/lo8UrluGzTU1Y/AThYMvXDXLitrgYKQEv2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:41:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 18:41:14 +0000
Message-ID: <44bb5467-186d-42d5-8e24-3789ad8a8b7d@siemens.com>
Date: Tue, 8 Sep 2026 20:41:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ci: Use debian:stable for reproducibility
 test
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
References: <5e3f44e0-ad5e-45b3-9b68-b476cec7a05e@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5e3f44e0-ad5e-45b3-9b68-b476cec7a05e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc705c1-df0a-4ce6-cac3-08df0dd8c275
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|55112099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YiqW1lUNI21wlapUZquz0vf5nHhO1tDpg9fuU4o9/XfUw2ruz3ryXBbhAOXYGzkqqKJpbTmEP5CCSEEi5bLeQw4L1IQSCPhwbs/bL/qsK0w8HdE0nOv0x/F+bKrdLrRAgZHY61g8QN3XtROwdKC0CCwFN5CiuJ3h5qtwl42gEiJOGQJ8RX8Yg3cA8PjfX3Z3bX23K7Lv7GI9ipM494EqPDuUQ1DNsKInkKwXZUOYaFg2RufbXmpNbzgbXuLSjaZHvUTZ3STM1VRqknarog1PuFHsiN6mtKfY8fWXslf/ly82rRAc6DZxrcBqw5szO0qKLZF/8hNzwusDFm4bBK/5zyCcm8jsyBYHzh9vgq1KF42Vx1Mt67l+LTNjblGpAEpLdHzNwjjQ3srrElpnv9lf9/6c7xmv5tUnZUP+dKqBjxaJ1hd0Cs0Xh04LOVrSZclHgU177LVlcwtF6zAq8WgKF4B8yC01+6H33SzqgtxRdUPw81Ji2MTlB0HJQ+lRPldXYm41tdL9/IIZsgyJqr6vI3ysg8Rxc3uBoW7sJ+w3iNzyhCVu3i2tLh38T5nFHEgOZyNgkjXfKipJ+v+aNRNAaFs8Wh/Jburp2Om4ab37bJINDBfoOZgtOgKq7+E5PRiNhtlM/akGIY425j/Z2wAt7yaJoO1gi17lXet8GmjlpwI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(55112099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KytEUC9aWVNOMFg2aFRzdUdaejRuSCt2QmNZMDlxdzhKUjBqVmM3NHJmTURE?=
 =?utf-8?B?aEl5ejIrTFdtakxyZDlXdnFMRFdkTW1yV2F1MTh6NmNCOENNNUZUaG5JTy91?=
 =?utf-8?B?c2dNZkt6VGVjMEVTQWVlb2xMZ0hGNW1JNGRUb0Q3Q2tSUzd4NnBpcWtabGJq?=
 =?utf-8?B?U09pMVpkWndTM3BWUEJ6WUp1V3hmOGNqamY3a1NDRUtNZjNWdlhlRDNDU2RH?=
 =?utf-8?B?Y0U2QWFBeTZ3L3VGYzhhVG81WkRheU0rc1pYWE1DRTdSTnJLSXlzUUNDT2FZ?=
 =?utf-8?B?dm9uV3VjOFlNcy9XZHo0Y2F3cGRuQTByZDcvbm1kZ203dEtEK0dKdXdSMnhN?=
 =?utf-8?B?aTJ2dFlkRGY2SzE0d05qb0k4UHEzSnhacWFRSXhBcExCUElLVGFDQUJveldx?=
 =?utf-8?B?Tks4Y0cwYWoyL09MUUpiQmc3dmltdUNiN01IeU9rbHo5K09uUjdiU2RFTFVz?=
 =?utf-8?B?eWZESndWdDJ2WUJLRXBIaHRkWE5ycjZCRUVjUUJSaWhqc1M2dFgzbVV3b3VW?=
 =?utf-8?B?dFd6NUdlNE81YnFBbytycWJuZE8rNU9UL05oVGNBMmNwRkM5UXFOUzYxUkRZ?=
 =?utf-8?B?RlV0ZXhOelI1aUJUc2RoRXhGdDNteHhZZFFhT01JSHhOdzZQT1FRVGxYTzNJ?=
 =?utf-8?B?RHA3OERYd2VhdGVqNWVRZFgzcDM2VW1oSXdPcm1Fclp5MmNBbnJCa20weGhU?=
 =?utf-8?B?UFFhSVFCWG5xZVhQVDlBeVB2SlpudmsxTXluTmJoRHNtUGF3dGxCUjFLK3BC?=
 =?utf-8?B?WFE4d21xN2Z4THlFemVMM1hNN3h4ZEJRdEVLZVFVanlDTThBYlluU1pCYklh?=
 =?utf-8?B?WXJjL0JsejU3Z2cvYUZsMFRTMjlENUZjZUtDZzFoMzZYS21qbzBzSEV1NC9E?=
 =?utf-8?B?N2V5WDlYcDlMYWl6YWE2WnQ4RVhHdUFTNnFmVHN2ejh1L1hGVXpDb1Q5U2Vu?=
 =?utf-8?B?Q2hLMkVSRFcrMWNzczdIMHNXalVsejdtU2tZTEtCZ1MyZ2pSTU03VWZacnJV?=
 =?utf-8?B?SUQrRGVoSjAzNm12TnBoc1o4TUo1Y2liSFZhRmo1ZDVJTWpIQ1cvVk1IaUlw?=
 =?utf-8?B?T1BUUDZPOGtCZUtldTlRdmFvTWFLekRma3RGYSttbWlHeERCcmlpblZjOVJu?=
 =?utf-8?B?alFLSG56VldCQm9HU0hhVVBCWnJhVGFuS0hFNk1YY3B1SVFiTWRDY1d0Q0NY?=
 =?utf-8?B?L3NnMzR6T3ZJTGdEZXB2NFhFTHNBTUE4NWF6YzRvSis3aFI4NmlIQlpCVUJm?=
 =?utf-8?B?S2lLZktvWVZ6REdHR2pVSUY4cFlLL0QrVkVKdjRHUEpoSTk3aEdFa0ErR1Rj?=
 =?utf-8?B?RnJ2MGl2emF3bCtOalhYT0Z5MTdvQ2JDa2xRWVdmanN3QVRwYnFtNm5ldzNa?=
 =?utf-8?B?NTRLeFF6UFRoY3J1M0tuOVFRS0lDSXFvUHZwWDhUdEpaVjFxMEVWaTJMeFdC?=
 =?utf-8?B?c1Ira2JrdTJWR2V4UWxBRmV3SmZrWkFwa0J5OXJKZU02S3VqL2JQZlF1cEkx?=
 =?utf-8?B?VWxqMnRSczczWVRJTElSQkVzemNJbitVak45KzI3VFdYeUlpTFl2ZlUrLzBl?=
 =?utf-8?B?QUZUVUhweHlZazlyT1g1MTUzKytMQ1hhVUxPQ1lNanNzYkloMzNtemcvZUlq?=
 =?utf-8?B?ZDFxUlFiMnMrcy90SDV1V2QvU2Q1a2FVQVVkbVhXNjBLbWdPYnp2VXFERUZx?=
 =?utf-8?B?S3VNMFJRdnU0d25FVG9IQkpyZUxCdDhJR05jZjZqWmhIaDJORWpBandVejh3?=
 =?utf-8?B?NGhwNzRBdVk3MWs3eTJ4NHVURGJMNnJEZ0h5TzMxZFgyNWcvdHdWY3pLYmN2?=
 =?utf-8?B?UFBuN216cElpZGZRME00NVBUMUh0aE9TY2pIazNJNW5CdEFxTXNRT0lJMWxP?=
 =?utf-8?B?UlovM2FTdlUrNkZvZFpWbWQwSC9HVlVSSlZ2OU1NZ0pLMldRUWQ4LzZJQnFN?=
 =?utf-8?B?a2p5Zm1qQzBnQTV1RXIxa3UzLzZpb1hFN2dla1ZaM3V0aENWQU1RTkQrVUV5?=
 =?utf-8?B?V3Z2ZkZEN1ZaQk5DWnRzN1JFNnR3MHVQc1U0ZFJaOG9kejBIUGZPVUxxdTdh?=
 =?utf-8?B?OHU4ZVRiVjFFTThLQ1hzbVFPQ3VpSUNFeEZCRjFDWmI3dkNjTk9sdFpncmcx?=
 =?utf-8?B?dGJmMDBZUjZHRFhEVm1Ea3ZQUUppVkF3eVZWd1dWaTRsV2kxLzlvd0lUSTAx?=
 =?utf-8?B?dWJsRHRrR3hOckV6MXliRlFxczJOSTluTUJzdDZLcHBPdUlvWmR1RnJwdHov?=
 =?utf-8?B?UmVUalVYejJrUHJMakVwUGpmT2tySmkwanpHcWR3bU84NFloYVFNSTIrdTdX?=
 =?utf-8?B?UThOdmx0VnV5ODZJNExCU1oySWlBa2lYeHRHSEFQcGs1TGZCaEJjUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc705c1-df0a-4ce6-cac3-08df0dd8c275
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 18:41:14.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeOD+9olj5GBqUiMTaTvLPKBJAMzCEslyNfzKD9+s2UECMtRhaaEyi2yzzFIWU/AvEtSfgkwr1vtJWHnyzYJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7645
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Sep 2026 18:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24105

On 08.09.26 19:31, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> That should save us from future surprises of suddenly retired releases
> while also providing a more recent diffoscope version.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .reproducible-check-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index de9f3fbd..f8a79527 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -51,7 +51,7 @@
>  
>  .repro-test:
>    image:
> -    name: debian:bullseye
> +    name: debian:stable
>    tags:
>      - large
>    stage: test

And while this allows to run the test again, it is still failing in some
constellations:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2830417509

Something in the EBG FAT partitions, as I already said in the WG meeting.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

