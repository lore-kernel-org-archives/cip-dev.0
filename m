Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB2C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 15:34:08 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web11.8694.1654270444757388529
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 08:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fU4mLqXC;
 spf=pass (domain: siemens.com, ip: 40.107.7.51,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd/VGSS3BI5M0ICyxUXNQ6ZwbGVOHrc0Cr83aIhNcWCnBGbVSqHLexaWYtjZTDFxT17rRxRb1ixcN1qqOiHPeVD6JNBr2BGnj13Pu3SJtOyh7cBaUi5wB3pB3X2JC2qbkTt/FD5qSfAJnPoQbfft13vsJrcb0AWlGsX2iIJgx1V3go6i9n9H3jwuN46dCi2zWhexajARKG0z+NmfU0nsFehWQtvuop5NqSAiTwgNxFeTKQIQXGtTcrz5QTQ/iEo1f5BVCnkXZtt7W6FszUi230fMlVLlqQ+5H66UxBQY3yoKDEUjFtQWhoaoGGg1AwcdMPqb0qPqudt72UEtZw6OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe6pdQAzMKbTfkbKhDmXlvTLpQy0EaxBMtCHAqWKodo=;
 b=hBvrzqBMqRvzV6JodVAmN2A3c79fLA+p25HE7jq8jzqXADjMg/JfiPpJfg/bDNAIeDem7gapSdzeGDbsNB87UnfE2HuSBe2yEPyMnlxQ8feO+g0a6cbeis/J8UmLJ3CNfRfm4bKyc2xgLU5qjT5+1vdOiynjNrgX5KDp8Fm6UzafOMoesmYU7D0DIQgtGrQNx7OHLW7r2ecKGwIXTOXRzbObzpLNqL9gD1jzB50w+mxawdUKZt8Y6A60MVaOSrLOMEbiPbANofId4RNyO+RhHpo/+YMTtPaO7l0jlp0nNiplfJX0fSE+2NpcNW5zGHoadzJGonVQyG+4Za3nAXv4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe6pdQAzMKbTfkbKhDmXlvTLpQy0EaxBMtCHAqWKodo=;
 b=fU4mLqXCscr7wOwxjWoNjmp+uJp9UhcramlPC9cDpvC6Ty+xiraX/q5FvYHUCyd3M8v1qY2ysCPakQmQmyLYyb/0w4omMkX60mphSOSbMFGow6CRtMnknnRtDgHUb6Fy4TEJYp3MJsdtFxWHg3cVdJTcPxVC41PLwRf8DQC6j2vGxi/uMLoscysq0jnALlBw8nA8dpkWhbE6FKT3ZZz1Cw4pOa50T8DWFCvAmw7HaW1Ui8dQ8WkCc5taaTOM2dqZ59fnkDm/Wm/62Vtn1t+qSiss76VilhHxdhvZkH4ZjN4lvRQV3Tx/oUHSzD1gQo6fjt7rrfCe8h5rblHfejEebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB2829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 3 Jun
 2022 15:34:00 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e%2]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 15:34:00 +0000
Message-ID: <c44a302b-67c9-caa6-1ae0-6808539fa612@siemens.com>
Date: Fri, 3 Jun 2022 17:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/4] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 adriaan.schmidt@siemens.com
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0560.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7459053f-51c6-4d2a-496c-08da45767b35
X-MS-TrafficTypeDiagnostic: VI1PR10MB2829:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB2829EC61065B83594646B6E581A19@VI1PR10MB2829.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4ivloECH+XgVqy8I2VdO9fWCnLDyRAEYyZ7VxVzXK5G0Rg1i2uiINcRVaOrfcMiaojSoL2xkJBvryrj3lJTDIQpcs5ECmDQ+BJ6qohqBpKLIXA/aRPGWHUxAoJ6rxdZGiHET6PK28Ug6/L+/vCrmnlNWrwvx+ZPV9fipxFZ6j+oWLR9b7Gie7xXDfYTfwWJ6Wsi1ewUVh15cbcjuTEt7HXEOQmiHfodv6PW5TtcPN8FRRn+vrgAAOLolJ4PguEueLK1fZufvC1QgYh0mytdkbYMnFv/zGK6QSMB4rc8dvK3sLVY7UKM+FI1J6UB5n9vc/x3tHlg/mXrnTZ0MjBZW3S9HaOgTvhNWlfqJQIRwFSvF30jdqf4YykWPWXuMmbeEGcx40vBx2A+vWqVXN2mv/WzZ2mOL6z0H9EegEQ1iyfDdMy9L72ny7R8WYC1bDWV3GgADQl+PA6bOdnZ42xLxC/ZFC/y0hAYP2deHCZ1ZyYzuwzMaGRImQDQslOQUsFPuYeKaSwssuCkSP9i4hAay4GoFINQEAhhhhne2//7bhSWzL8UniH6mcbJb/Nc5M6QwImf+F8z2CoHDXq+OCGxCCANMdgMxgE6TKJVhXKAz/zpiJp1q819sZIHNQseZAdRPgfU4TPph0aBS0NmQRJt25VfxV4bvPGdOPVaCIDrta1IDc0Muy0sEycNOLeqUrV+5gTU+96JhMNIUt2qH2YToIdx7w+pF2PaXO/aQ0riKmdflLODGDIBkDs8v9uhJvJGqvktVZ+L2CwaF8DoL6cW+PHlbni5us7bCSSffPMdSODX68BtGIhAmPj0q9rsIwEdBDN77IDygQ304KW/YRKCbRbGuH2yoUn0hEbDMUSSZHqw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(31686004)(36756003)(2906002)(8936002)(6666004)(5660300002)(8676002)(66476007)(66556008)(66946007)(86362001)(36916002)(966005)(2616005)(186003)(31696002)(6636002)(508600001)(6512007)(6506007)(53546011)(82960400001)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blpYaWhlOE9qOExEUGNtY2Qxb3NMZWVOdVNNcGR5SjJkUEFGdEMxT29vSWx4?=
 =?utf-8?B?b2J2SThVY0ZwY3JCVVZ0VkorM2ZNMmRhNTM0Qm1lTjgzNU10R01FaFFlbklY?=
 =?utf-8?B?c0JQeWIwMmd2R0xuaUEwQVB4cXJUbjkzWDBPY0pHa3VOYzJVKzNJUCtkR2dm?=
 =?utf-8?B?SnJtRXBVVU9UMWN0bTdnRGx2YmJhazBhaldqUW1FWGRDek1PY2UxdWhoOUlq?=
 =?utf-8?B?RERoeS9jRmdOYkVLbk54RUF1Y1RGYzRqRUFoY2lUVCtFZTBsVUYzRjNwL1po?=
 =?utf-8?B?ZktGbWZrc0V2MTA0SzVGcmlrVVcrVDd6a045NkMzSndCUm91Y0hKSng4L3pX?=
 =?utf-8?B?bC9kQTRTemdkZmNoMW1nbzkwbS9qTEJzNFRGWmVFeXlHS1pVY2RJd1dIVXY4?=
 =?utf-8?B?Sk9Md05PcnZsUm1vaEtNWXMxVmQvai9yZlB4OGpabWxVN0drUStBZElhNUtF?=
 =?utf-8?B?TFBqRGFqcnZ0b1hVT1hoR3h5eXFHK0phNzV6MFlkQkRBMmZ0ZlpqZ1p4eTVN?=
 =?utf-8?B?RHc4MXJMNDduNUxuclU2RGJzdTZuS3NLMko0THlTc0NwQ1F4RDJER21WUkxB?=
 =?utf-8?B?akZoWUpxb1M4YUpFa3dHQ0pvZVR1SzNsNlE2aXpmelllanpnaU8yREk5YUFV?=
 =?utf-8?B?aUFJejdRczRQMUdEK2xOZ2w3QklDL0cvOVpjbUtLVFNNWElPTytYMm1BNXFa?=
 =?utf-8?B?QzdId1NaT3V6SHM4enBPRTRjVlJkODVzeXdhWVVaY1dhQXUvZ1Z4N2U3QitC?=
 =?utf-8?B?cGpSdDVBbjhPQ1plemdPNWtLblRsMzlLZUx6a2JmZ0dhSWk3THB2TjFWdSs1?=
 =?utf-8?B?UEtDZ2NwRXZmZkMzOHJUd05lWHBuQlp4cjFyU3drckNKQUM0V3E5dW5RZFRy?=
 =?utf-8?B?LyszNGxsbXVtMkZaSlZ4NnEyOHpEU1pBbWk4ZGVoNURraXdhaVo5blhTRzhW?=
 =?utf-8?B?NGdrOVZxWHZvT1NWeEw2ZzliK2xlaDF3YTVoSE9OeDUyVFZ3SlpLR2tpVDhm?=
 =?utf-8?B?MW16MnBpb1I2QmFFQ2dVdXNxKzBlOGI4cjFMTDFBdDhGS1E0MW1ybEI3MXNE?=
 =?utf-8?B?NXVOcU5lZ0kxQUZtUlV0Y09DczlBYnZvYU1Wa0hZK05ZWTlsY0V2bGdvcHZX?=
 =?utf-8?B?TjlxRmJIVmFqN0x4a09sdmx0Uk9PUC9XVkVqdUlqVW0wTGxPM3J6ZzY5Y2Rt?=
 =?utf-8?B?dUlQcUpOKy9RaFFqalhjM25ocXBxR25WV0tVbEUxaC9YN0lDZEd4N3Eyc2di?=
 =?utf-8?B?OXlqS3JvUExoYUpNZkZrZGVhVXdwamd5N0Z4MTZIWWdGeTJ1d1dVekozZTNR?=
 =?utf-8?B?YTZPZ0xHS2RJeFUzdlRJbDR2MngxQnFlZjdnWEFmYzJjaW9RMFhKejZneThS?=
 =?utf-8?B?U0RPcW94bVNua1doYjJhSmIrMlpuQm11dlJwTHJLckZwZVpnaUZmQTFra3gy?=
 =?utf-8?B?cWpZUXVoYTl5VWNabkhCYiszYUtSaGNuWGc1ejZzTGVYR2FZZjVNZnpzNFZE?=
 =?utf-8?B?QmkreVBXOVplMWdLblJpOWZPRWxxQkh5UnNOdVpGS2QrMDF0UVpRMm9yOW8x?=
 =?utf-8?B?OUlneHh0amtkK2hwZFNCM2NQTjZ6WjVhMEFRWitVZzBTbm51VXpDZEk5Qm9B?=
 =?utf-8?B?MDhXbTZDcTFvQUwrYUFhZEpUWkJsMGk2TzI2SUxLS3o5RzhkZ0lpVGN5NWpS?=
 =?utf-8?B?NFdkU2FIN0pBQWtvajlia2d2dTlYL1E0QUMvM2RsNUhlczNiY2FxMlEzeWlB?=
 =?utf-8?B?NUJIVHdDR011NlIzM1MyZmZUV3JSVitaSFF5bXRkV2JEc2NnaFI3NWRrQ2xt?=
 =?utf-8?B?ejZMckl4OFBoRnpabXJlOE9oUHl1aGZzTmFqd25qaC8rU1JhU013ZDVuSU9o?=
 =?utf-8?B?Nng0bkdSZDRsdERYZmpNd0ZZVThsV1FSZmllUFlzNmpPRys0N2cvL3dXaWJl?=
 =?utf-8?B?SmZlZHVqNlU4VkJJa2JQcFlmK2ZiREhMVFRyaExzUzl2eUp2UHljWjBaMlU2?=
 =?utf-8?B?SWFTMmlPR2JjYU4rUjNCbHF3SE5pR253bDNyUnFpNUsyZzdxaXhUWW5YZ2VW?=
 =?utf-8?B?M0MwNzYzZVBNaHdhMEhPc0Z2R0N0UnpnVVBJZU9LSFJwZVZtNWZuNm9wRGtK?=
 =?utf-8?B?akJNMElkMnV1TWJlc09WUlFzS1JSUnRTcEFiN3plV09OSmwwbDZEMUduRml4?=
 =?utf-8?B?NjdDejh3RWg3T3BWUHBUU0xQNjRTUnYvS21JTG9uYjRzOXNndnJRZTl0bnhS?=
 =?utf-8?B?WFpFbDhIUE5GTW1hZGFXbnFReDlGUmtJRXFZdSt6NXc0OUVRRlNvcGN0OVRv?=
 =?utf-8?B?Z0U4MkJYZzJTUzl4UUYwZUpvY0hLSG5LM25USmtueGJBdEd1djRHZzZpdWZz?=
 =?utf-8?Q?oUDQaJeOS52bDcHpc16fVtpJaZJybqYC/47MLM6BV1x3F?=
X-MS-Exchange-AntiSpam-MessageData-1: qwBfJKsNRcb7nPn8Q/D1sHkXgvWkDyVHvfg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7459053f-51c6-4d2a-496c-08da45767b35
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 15:34:00.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 DZ70qfK88//e970Z2Lj1NWtJYlvPMgHjTyF2733KpXX8vmpkRm94vU6RqSXJuhrtT7ABvA44mhJjXMObbnoRb7hMNZMJOazR+VMfV/S+C5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2829
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 15:34:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8491



On 6/3/22 17:27, Jan Kiszka wrote:
> On 03.06.22 13:56, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
>> ISAR commit [1]. See also ISAR API changelog[2].
>>
>> This new feature remove the *.img from all wic images.
>>
>> Also as new naming convention image recipes no longer end with `-img`.
>>
>> The image types wic-swu-img and secure-wic-swu-img were removed.
>> Rename `squashfs-img` to squashfs according new naming scheme.
>>
>> To use squashfs include:
>>
>>      IMAGE_CLASSES += "squashfs"
>>      IMAGE_TYPEDEP_wic += "squashfs"
>>
>>
>> To create a verity based image to following line need to be added
>> to the local.conf or similar configuration:
>>
>>      IMAGE_CLASSES += "verity"
>>
>> The modifications for a read-only root file system are now part
>> of a bbclass which can be include directly into the image
>> recipe.
>>
>> The modifications to generate a SWUpdate update package are
>> also no longer part of the image build process and in a seperate
>> bbclass. This class needs to be included in the image recipe.
>>
>> Please check/test the interface changes for swupdate and read-only root
>> file system.
>>
>> I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.
>>
>> Quirin
>>
>> [1]: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
>> [2]: https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#changes-to-image-types
>>
>> Quirin Gylstorff (4):
>>    ISAR update
>>    start-qemu.sh: adapt to new image names
>>    Adapt swupdate and verity to use new IMAGE_CMD_*
>>    scripts/deploy-cip-core: Adapt to new image names
> 
> Thanks for this update. I'll have a look and also try to apply it to
> meta-iot2050 as test case.
> 
> One question: Is the series bisection-safe, or are the patches 3 and 4
> needed to build again. Patch 2 is likely needed to run the result again
> after patch 1, right?
> 
I tried to make the patches bisection-safe. The build should work but 
the verity and swupdate functionality is not available after patch 1.
patch 1 and 3 are the main changes.

I will re-oder the patches.

patches 2 and 4 are adaptation of scripts (qemu and ci chain).

I found some errors in the CI build and will send an update. The errors
are in kas/opt/wic-targz-img.yml and kas/opt/targz-img.yml.

Quirin


