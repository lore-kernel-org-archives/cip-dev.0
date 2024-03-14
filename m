Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342EC54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 06:56:54 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.47])
 by mx.groups.io with SMTP id smtpd.web11.6479.1710399409760651895
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 23:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rt8w8gcn;
 spf=pass (domain: siemens.com, ip: 40.107.14.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U86MYG8pALNfeOhsTFc+VwP9X4jS0kVyu2ojCKT5TwPDxhPZyj67H56eneGSoi8/XNuiJDy3XcWzRI0bKpe89SgH2vJoyigegYuDLs5WfFD84VlokNk/v3dHxw33EMjyW45Ywe7Rp2Q+hUPw/TPubDnCaPfaxPEL8yonABZl4lu1oO45RBDGEbBTRj739t0BO/KEEB65HKzKmCJj0QzLQB5tplZnxp67fVqnOhiPvcres+JT+3sUyTZh6kjtd1i29IjdAV4GuWNsftLoePfxJliGGDJ4UBlnh0bhrJhaH29EaD0hEgcEt69gGIHZkS4MPRPeaS8q2469n2aCYPvwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E++bhQ1cMLMpy16rEucChVfLeLFP5Gsu1wbUh4vztiE=;
 b=KSaJeu6GHGylqI267nr4GANCTA1cg/yNdQETJOt1SFpQ0K5ik1e4CyMyDqA1S3Wud2lvCqnd0itp1S8hrmVlZd+15cI3ZToyQK54zw2T3GwqswCjUOWRPS7rraewyUp/sKOOmfTDOhDel4vp74Xtl67juFXoD7enjXIf+KFX2Nu86VWNkKxrpID2BYbSrpPuIckFzx0eUDDINRJ1F40XraxXeWvXBC8gRLlT6qQFNsUcDXHUazLJ/TQuXYjHf1SjoC90rDa83//LRWDdGcYgjdIlVf+GCT15CiifbxFGH5kU0ieVZNlQrnS5VM5D99n+bnUzQYlLei2SOwSH+VLm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E++bhQ1cMLMpy16rEucChVfLeLFP5Gsu1wbUh4vztiE=;
 b=Rt8w8gcnPEXbYin0w+btezACjWZqFDnVcyfsbYOVET/I7u4rpBRtgfbuovdGNIeZOrXMQFRlXSWVcrWUwo0PW0DcobCGDaI4xfJxQaOFMuYD+Tc9/Z45dE3e3GCN6CONuwSeEYJNb6qZVH0w2O5kJHV0C4rcCchYHevx3x+ERKVvBOUsqhcfRMYIhlJrWemDTVnYHuoo7xH4SCelFr6Ns6LNgcAQmQ2+O6Oyt4NHyfFh+ryVUvKo1SirVmDyxltKLmKEoUk+HRFQhuv/Xn7sVzw1dssBSKxwI4boOlWGl0jawSvzuGM5nvUPLFuE38UC18UvynsSkcXZKYTtatyUJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU2PR10MB7646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:492::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 06:56:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 06:56:46 +0000
Message-ID: <c0b04b38-2760-4ef0-ae45-b57dfd7c5b5a@siemens.com>
Date: Thu, 14 Mar 2024 07:56:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta
 handler in swupdate
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
 <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU2PR10MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b9204-b335-4125-f9bb-08dc43f3e9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	la0NArA/hq5h8JcWfTcm7ZEAYskwH9O42TfL4LicEVoWgIacSu8wm66uDx/+LJL87bSbAqSfB4x9wc4yeXgPKswbbF8g7o3NgRdu+I4VRWqcGK8jBejCOP2kiRjc3QfOOnh8sB5CocCdcMJomwAc1WKlnf+ckLOEXMr+ATucoeYtjsyLFY0AusAbkoN5Y7wh7jxQbWs5vX9dNVyxCNbSp8DxxaqakeVG86WloONQYjP7v1X7/gmBuS8VDbv6KgD9fwv///wNQhMJYBLULjYWLNbGsZq/8rlzTvJ8F1cWp/w4D2DYJE5At1C44jSC/1CLNr8kWPt+2Q80jADWsbmg3lfSXRS7vCNqrC8OcRXStVObjgBva8o7l1RYn+G89LXm5D3cActFASPCvxIuO+37Kx7a+3XYClagaOJ4ueI4axCHMoyX81nl1ogYmU3+Y94qfj5ghQBqtgW8niPtkSvnWimBKPTaWEoX4nKF5/vlAwXljlbL1xFdlvcCM67Mo2yKMQl1THj0hEebyFn13SdlNQDO6sjKJDHJG1R0zPud98LBSXP94gAl1SMl8OBqYNzsicubiGAsCt3KIsm+YGUp2upGjrJH8M5TIYCeLw5eZZE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDdSTXRwVWwwSUpXYzhTbTk3RE1BNFN2WUdRQXhwVUZxUjA3Q09vbkFwc0J0?=
 =?utf-8?B?SGd2UUNDVkxzcUhBQjZSZ2dibUw2MWNJYXp3NkJYRVY4QzBuUS9yWTc3TEtN?=
 =?utf-8?B?dWFqRFljMk5mSFI1d0lId3YzNW5lYm9nRXBqOG81TjBkZldXVjN2N3VXeENG?=
 =?utf-8?B?bHpTUm40ZzlVTUh5OHR2MkppenpWcitWMWlqUlJISEVtWktSQ1h0UHlJaDd3?=
 =?utf-8?B?STFQMDJmRVMvRVdidDFRcTgrZUx3bjBTRm1idXBBaDdEMGFXOXc3bjlSQmdU?=
 =?utf-8?B?TDBjdHlWQVkvZ2djMjM1S2hIbnF3RVFGdldZdlN0M0ZTb1Y0WC9pc1lublln?=
 =?utf-8?B?N0RtenQ0NitJU1ZsV1dUd2pmTlJRRVlYSjJRWXJpSTRkTG5leHZsUVl5Y3E5?=
 =?utf-8?B?bmx6RnIxTTF4ZDc0ZHNlelBQWEUwelA1TmNIRGdQME94cG0yZC9SOWhHK0Qr?=
 =?utf-8?B?Q29LTy9POXU1N0lCK2szZVVFMWd5QWpRVTB1WFo5L3NMb3VQekpDVVo3cjky?=
 =?utf-8?B?bFJQUTVzWTZUTDkra3AxNXlUMzdYSG00WTdMOS9EaVFzRnNVMTRDWFBER0NT?=
 =?utf-8?B?VzhHSHhOWnhoVEE0WWdTS3o1bXc2eE5DeUFLd2xzdnV2ejB0ZTY5aUVGdllB?=
 =?utf-8?B?Y3VBVzdDOFZSeU5JYmxDMm15aGpjY1EyYmd1aWpQYWlLRVdNc2lJTm5hVHMv?=
 =?utf-8?B?NEVrY1BNd2lWTi82N1kvZmJqekpJMUdnRlpCNXB6WVFVaUViQzNnRVRQMmhk?=
 =?utf-8?B?QnFXUXFESlFnNVQ1V0JWZE5td0VvV01haHh4MU1PVDdvSVJCOXFUeENYSEhW?=
 =?utf-8?B?YXdOQ0pBMC9zYmUrbDFWR1hScjdKOEZhZ25nSEhMRFdENDYzbmtWV1FNNFlC?=
 =?utf-8?B?SjNCQTlMSlBJREpYMzdYZFBWWCtKVzVOeXZuL09lSmIyREI3SllvUWxWeHR2?=
 =?utf-8?B?NGhDYWhiNTlpK0hkSS9LUHYwQS9Ta2FNb1NacWZ6dVZNM1U4VVBCUWVMKzFx?=
 =?utf-8?B?Z3d2dWhScnM5L05ncE1VSWg5MmRLWFRqZkMyR2hPc2Rra0JYTWI3aklyRk1t?=
 =?utf-8?B?Wjdscnl3OHVCbWRPeExZT0VhTEJWQ2VtYUtaSmk0akJ6a1FiUFh5UWo3REJv?=
 =?utf-8?B?d1ZhL2JxSzNTL0F2QVcrRjQ1Y3Qrb0VFbGFvc3pUaDViYlRvZjdid1NpYzM4?=
 =?utf-8?B?Z3psN1RLZ09uNTJMSGtKL1QwaVp2R3EyeUtQNEtBdVAyNHRVMVFjdDNlZnlz?=
 =?utf-8?B?ckRNbSt1Y3dTVUkwNFp5WjMyQ01sMTVzSmNXMXBLSXo0T1dxa2dCZldqSjFX?=
 =?utf-8?B?VWo5YUoyL0kwRklSOGMxU1R0K3NmUitTbjh2MHpCdjIrMG5kbWVsNmE3ZnRH?=
 =?utf-8?B?Uks1c3JLQW5qQ2NKVVJuVkovcHdLVnVTOTh2NVY0UmpQYzd3N0N0N3U0Nmxk?=
 =?utf-8?B?SXJuZE1TUEdFc1lPTzVvWU43SWxUYVBHV0g0VmdQTTZ5YVNpTXl1bElCdG9U?=
 =?utf-8?B?c092MUxFeHZldVNGQnVtRjY1aVlmZ1hFaXhTL0t5aGM0U3hIWGpxRENPZ0RY?=
 =?utf-8?B?NVZHR3ZodHIyK3dZQ0xyTG5VbzAzS21OQjY5YmF2eStBTldCLzJuczZNeGJG?=
 =?utf-8?B?MzBBcVF5bStXME5VVDRBTjN0K2l0aDlxSU40VjI3TVJ3ZVNaR1F4UUJ6N0VZ?=
 =?utf-8?B?QkFOdnlzMW1yNG85cDZSc0JzaFFlQy9WaEZsSC83eFdjZERxZlpobjBrcnFY?=
 =?utf-8?B?L3dPY3hYcHdPUFROWHVscEZCZHZEemFacGQrb2hDSnBpKytXc09DMEVXZE55?=
 =?utf-8?B?Y1F3TGYvR04velBHbVZtT1kzSi96MmNmdkVCWnFUVFFTYWwyY3JUY2JsZXZG?=
 =?utf-8?B?aDJnanBaL1RNNy9yZ0VNYWpZeSszUk0zdzVNMGJBdXZ6cFlzaitwdmhWZThQ?=
 =?utf-8?B?blk3WWQ1MHQvK1FnWDkzK01mZ2N3TXpBRWtCd2RWeTd5Tlp0SHl2N2VtTk5s?=
 =?utf-8?B?OW8wUnorR0RqRUl1RHJLTkhsZkJtbXNKQjIzVk4xUzFkMjlpL1dCQ2ZGREdS?=
 =?utf-8?B?WkZKdjZUNGxWSllUVkJkZURSOHVaazJzWXFyNmloY0x2amREUk1UY0RWZ21Y?=
 =?utf-8?B?NEtYNThOZjZ1UTNVbzl0YUYxL29VVmdiZENuSitCcDdLVTBsUGpYUC9aenRT?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b9204-b335-4125-f9bb-08dc43f3e9e9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:56:46.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6B7/+yaIKjZuPgnozP0Hmq/gSULYESZmxyEfBVSRVlDMXHd1Qels7EjMe/eZDq7Cq+bI90232ZB79V0XLuCV88e5U6sFufb3MSed0AXfLXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7646
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 06:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15296



On 3/8/24 12:36 PM, Jan Kiszka via lists.cip-project.org wrote:
> On 07.03.24 08:46, Adithya Balakumar wrote:
>> Enable delta handler in swupdate for bookworm and disable cross compile
>> for arm and arm64 on bookworm to avoid build issues
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>   recipes-core/swupdate/swupdate_2023.05.bb | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
>> index d1fe1fa..7a22947 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -36,10 +36,13 @@ SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debi
>>   DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>>   # add suricatta wfx
>>   DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>> +# add delta update build profile for bookworm
>> +DEB_BUILD_PROFILES:append:bookworm = " pkg.swupdate.delta"
>>   
> 
> What about sid?
> 
>>   # Disable cross for arm and arm64 on bullseye
>>   # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>>   ISAR_CROSS_COMPILE:bullseye = "0"
>> +ISAR_CROSS_COMPILE:bookworm = "0"
> 
> This is unfortunate. Why that?
> 

I tested swupdate 2023.05 on bookworm with armhf and arm64 it currently 
needs no backports.

My two cents are this is an issue with backports.

Quirin

>>   
>>   # use backport build profile for bullseye
>>   DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15265): https://lists.cip-project.org/g/cip-dev/message/15265
> Mute This Topic: https://lists.cip-project.org/mt/104783337/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

