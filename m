Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710AAC19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 13:58:55 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web10.5042.1659621529337478937
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 06:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BkhRxAXh;
 spf=pass (domain: siemens.com, ip: 40.107.7.54,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf/p5g4+vn2oGGXHocD4/YIrEG2vkV46mLMkemNZ4fbbBaVrFWgN3QDIGgUh0BMbay0deQUFWzwziKZrCHzKHmApwd2KRBqwV1fbUspmPWKvhgIhWWDylEJLmzNPk0a4t5IkBVIqqJODWXQ7bSc0BIgxUYH4rIB62tfSIHFUuA07e0sVN17jUYaP2fuUF89x1+7I9XeH7skJ8RxV5Mc12uWND22X8oLvZpTGWgN9iNTi9ubZ+I1BNtVRyZmes87pws22Ea1XALJEOJjhgje8/w0U2ySVcEubIe6Y15j9U88UynOy9YI1+Zitkh1p+skXDeZUX/cIBRB0+LxoAOx9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njRRsiyCDDBrjz7Vpq64X/jil4c8SO5h6U6BLSYGy2k=;
 b=HAyDWA3I9pVJ3ZAGyyE5+mW7s49+8lgAbkC1mDBmF8wtWHXYZmMnFmI2qrc6vPXovgnz+YLBC9pO3esFXiWwvpF/xb4WOPouSVOQvVWVYmzkp+YOyYWhLMfWK4U7+CBDDI40F5foL7WdEoBRIckxiKTJPAz0kBf1kLZDdsAy7kItax+IBr6xcq6Yh5HiDaFNiN1DBFE8o1Bds9nE1JeR+C4vLkNemCQu/lLFQ3uhCA7sapcnVZh7nAMydpzOBq1tW5+U/f0mpFsSH5beI/HhPsCpLdrhWmNZ/DA0oynV07uz+Lvm4RUKVbjm60N++K6NWPNcAJOTnpk3N78dgsGy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njRRsiyCDDBrjz7Vpq64X/jil4c8SO5h6U6BLSYGy2k=;
 b=BkhRxAXh9L31SpxCbRAtyTZLYMz18WtnVRD64O1QGBL1RBryS2/vbMjL3xNGxpcWXAvTkmjiu1mb/dYzwbyo1wJaVGd2k2G6Ed1+0r2eytcot2/rgIN6eASenEAWXaI1W9KuyQOodD3AbvpUiQvhLS3u37qtGnhUVOnvE/a4qpfFtgKAYM1I/aFHkaSigad35rDkfueca08HwPpB09GOqP8I5C9E6gaEnwg+nutQbFkGmaqUY/tratG2YoHvL/awTirLu5+E2wlb7wWACmbtIxlOL3NPbpXMMbD9wMq8E1LwoK3BkvCg2CF0k7mAwn0RjRhQCcFXCAr2nALqudXWfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM7PR10MB3512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 13:58:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1%8]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 13:58:46 +0000
Message-ID: <22d19878-b710-61d0-bd47-0a9c861228aa@siemens.com>
Date: Thu, 4 Aug 2022 15:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] bbb_defconfig: Add missing SDHCI
 Drivers
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220804125437.715852-1-Quirin.Gylstorff@siemens.com>
 <05d75b54-bd6f-e23b-e40d-c991f664d4c4@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <05d75b54-bd6f-e23b-e40d-c991f664d4c4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a9d4ff-600a-4558-8dac-08da762172fa
X-MS-TrafficTypeDiagnostic: AM7PR10MB3512:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RF+uzCkKiX/51u3THmcWruLdFTeNnz+gmFkUiS21c+JoD0az+m2lcJhQks5YrkC5Yum0CN/887VN2TAaNMkctt1G7tBHyQ5WVmJyKbxZwhGlInJd4Ett64c//Nxr5OSeXLBn3mgLG7WLi86zAIoihIjWi8uPhYbUu+1UU4lI8sLPHCSD8IXtKP+UL/Om+XJGWBMSBv1V1B/79j2ceX6eWrimrpOY1RNfok6UXfa2UpV25i+2vGTJCgW8uFUKSV+V25dqPSt1X9KcCYIiz5CMkWtHpSw+A41Xi8itZqx0NWLbtG/vNcBz4GDPlIWtIWNRK2ewjZPzcXu3fGPFgfaIvbw0+qBx8AvyVL83glDibvlBW3txZQCn/GcoNZml3vGlGxdv5e1DSpL/Z67kBTnnhGI/pQItO/N6pwQaLZpcI60RVxUzvt0Og8wUJCnYAztuUQJWfrEgWvM5Nn6GZnzXRbHo5lhroCdfny0vwNj2d3dVt+KN80jqxSgQj5XyeC8Qbeh+pA3KnXAYT75ZIoip9OLldYxdTWIXzxcB4W4FWVzOYMGJUZlpWnneBqDRn/niWrN5qhFhxYedRTEDW/jC8TJ9iLNUs4j2GsGJMPF7D6jN9UHDiR3gqgPNW+dhzyf8tfDmOxVoF07n7Hr3YXyigKMwvfVNqWVvCNWKbTC/diUHuIt8RmVlmxqujsH7MnTQh/rRO/ckKPW2R86y6sxtaahTKDFVnkc+qNEe9aJAeyQ010a/Ev50UMpcsVY0/+qomaHnQiOLjya2+KFc2rnIeWLwkdje/TNTxXnF8Skx8H5C45AOxsWpLZb7s3r/mJo4DVZAW5cMdyTx+rdDeHjlbg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(6486002)(41300700001)(478600001)(31696002)(82960400001)(36756003)(38100700002)(53546011)(36916002)(2616005)(31686004)(6512007)(6666004)(6506007)(186003)(83380400001)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(86362001)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHVJUGM5U1p3U2xpNHFyek4zV1FyUFZZcngvWjhERlQvUm00aXBqS012dUl0?=
 =?utf-8?B?VEMwZ3ZNcFI5dnNqNHhSb1ZHOEUxdW5Ra1h2clNWUURhOVVVZU1qOWE3TExS?=
 =?utf-8?B?Tk1Ia1JRMEQxVFd5bVdiaDV6NnFJQWF2WGdRZkMwUVhTSmVHTHdIdm4yT3JX?=
 =?utf-8?B?K3hsNXlyOC9oQytqTmNZWEl0UnhMZ0tiWjJrMEdqTjh4bkpFZzRBeFFNa1Q4?=
 =?utf-8?B?eEVmd2pmZ2d1OThOOW1SM2hRa056T0c1L1B6S1lTaTFaY1BSRUJkQnVhbTBp?=
 =?utf-8?B?ci9NNUpyb3laTHVqQ0JpRWlFTVlxQXFoaUpINzNUV2dFMmlzWTFtT3NRdEVE?=
 =?utf-8?B?U0lsZVRDeDhlRXZDbU9SdmZsLzFqdkZTcWtuNDA3eGtTazUwRFVYc1ptR0ZT?=
 =?utf-8?B?MDg1cS90Y2Y1ZS9YR3F0SXhZM1drbmJ3aytEM1p1a0IzZ0dKdW5mTmViN3RX?=
 =?utf-8?B?VElkVTByU2Z1TFljTmpIN1NkdWVNMU1JbzNhQVNLR2JzUjM0SlM0YnFNenhJ?=
 =?utf-8?B?RWRFTFQ5aHBkSTRzNzBYaEIweHZBTlZUWlQraGM3bzJYM0I5a0gxQ3paSGRK?=
 =?utf-8?B?UzNkU3hrWmNEREZuR3dQRW5kZ3BFcTQ0T2VHdGhnWlM2V3VpMGJORUVDNzFo?=
 =?utf-8?B?V0tJOHdjajFHdmw1dXpjMGNrMStPamNpdTFVanpiRkYzakY3V3ZlUktQMkRC?=
 =?utf-8?B?U0tIQnBPM1FyckVuR0FOTC84M3pJaVdBNXBQQmVRVHQzendMR2ZZK3Qya3kz?=
 =?utf-8?B?cExINENWY2hrWFB4VHE3eks2WEJ2Z2tVZHdjS21uOWFIOWFvZlZad3oyYlpL?=
 =?utf-8?B?aUVuek5rUlJkaDJ6V1JMZldodm9lYy9hRHlCZXZ1Tk50RlQwRm5HTnY1VUpa?=
 =?utf-8?B?ajlvRWRsQ1FIS2h4RS9ITDg5MjNsT0xHZHVLcDhLdWxNaGlmSk95UUMwcEV4?=
 =?utf-8?B?RnIwakJzLzFtOVpYQy9ibUNDcXJsb1FFYUxiSktzWTdSbjVTNVF5R3ZUSGZC?=
 =?utf-8?B?Y2V2dTRhK3FtMXFwUGE3NE96MVViUHBzS1JYK0NaUDIxMnZxV2FJdUY4R1RF?=
 =?utf-8?B?VitNTkYvbXdodk5SRTZjdzBWN2JWTXNWN1kwdVZkN3djOE5zTGIwODM5eUVs?=
 =?utf-8?B?a09kS1p4elJRSE9tS25sR2VLemNhN2JwL2VXV0podmxxWkhvYlZHREZyUDR3?=
 =?utf-8?B?YnpNK2lOenZva2JaNmdDcldhTm9pbWMwVlRDNU1Uais4QitwdmlySHVXTkxP?=
 =?utf-8?B?Nzdnei91RXppMjQ1YnlRQVYxMW1nZU5ReWJ5QU1YMlNRQTlZV3hOdkxrakt1?=
 =?utf-8?B?UzBmQlM5YUw0SjNaRkRZNEtxSXhrZENtYWMrWnFvMTN4TitrRUo4R1l0b0RX?=
 =?utf-8?B?Vm1XZnNMQ0RPTmgrSldqVjBPdDQ0WmlyUll3K0JzMWsrNU9RMEVKRVRUU0Zo?=
 =?utf-8?B?WGs3MlJ3N21xUDdTQ2xnZWtKSkVNOGRsa3JVSWhPdTQxWTdNUWZjRUs1REVI?=
 =?utf-8?B?bWJDeHlLSTkyRWNnSFZaeGc0VjhNd3VsZTBOWXg0ekhINXhrN3dEZTFrQUxC?=
 =?utf-8?B?K1JYd1VsS1JRNktLYlZCdFRIVEczMmJWTlg1TzNCZ3JzdGdkMXdxRnlXVy9R?=
 =?utf-8?B?V1laM0RObUVDRmJmUzAybStIenM3TnFLQ1MrMzF6MG0yNzVka1ZLOC9WQUdn?=
 =?utf-8?B?bEZzWnVNS3RLM3dtd1hpTzdScW9JZzlWb1R2bFQ5S2swRTVuOTMzanhPMFA5?=
 =?utf-8?B?N29neURqTDRsaC90VU40bmFWKytKYWlRaktJS0xjT01sQ2dTL1FVOXpCYTVv?=
 =?utf-8?B?VDRKanRZazF2Yy90YllBOW81QUVsREJaSWhEZitIZW9hS1NkVi82eFZCY1h6?=
 =?utf-8?B?c3hqNXpqWkJQSFI2bGt1anVlSEE5c3J5WktnOUxuMVpDZEtSV2hQekwwR1BI?=
 =?utf-8?B?ellZUDVlUmdma2dMM0dteWdXWnRYc1I0dnE4NzE1bG0vQmdKbUtYSXlTQ205?=
 =?utf-8?B?L0hteENFRUx2TVBRS0k3azhjdzkva3dycTlkWEE4SzYzb3ZHK25TYVBkK2dq?=
 =?utf-8?B?b0U2ZXNwYUovMmljNUd0S0N1aVNuaG85d2o5a3lmVjRCTTlEbXY4RGtmYmcw?=
 =?utf-8?B?eHM5R2ZSbGhqNnhtVGF0QU85VWhNT2pDdU1vOWFNVnBDY1NxVkJMOUhhclV2?=
 =?utf-8?B?bU9hUjlhTTRBNi9hK2NuNFJyUXhGK0dVMjFtaWQ5UEM1aWN4Znl0NGVqVGJU?=
 =?utf-8?B?M0RXSGpQK0VoanlVV0FxNk1adHN3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 47a9d4ff-600a-4558-8dac-08da762172fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 13:58:46.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 8+qn9d4xRXpLeIK3c7T98rFsa7dMmhsFvsnyycSnbgy3twF0MWlF63gsnQn6DBYg5N36MQv9PD9LG0xDP0r/T4F9tfl5MZPGjXP7/7RfsQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 13:58:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9121



On 8/4/22 15:29, Jan Kiszka wrote:
> On 04.08.22 14:54, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> To boot from SD/MMC wit kernel 5.10. new config option need to
>> be enabled.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-kernel/linux/files/bbb_defconfig | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/recipes-kernel/linux/files/bbb_defconfig b/recipes-kernel/linux/files/bbb_defconfig
>> index 31e15e6..8f8f1aa 100644
>> --- a/recipes-kernel/linux/files/bbb_defconfig
>> +++ b/recipes-kernel/linux/files/bbb_defconfig
>> @@ -374,6 +374,9 @@ CONFIG_USB_CONFIGFS_F_HID=y
>>   CONFIG_USB_ZERO=m
>>   CONFIG_USB_G_NOKIA=m
>>   CONFIG_MMC=y
>> +CONFIG_PWRSEQ_EMMC=y
>> +CONFIG_MMC_BLOCK=y
>> +CONFIG_MMC_BLOCK_MINORS=256
>>   CONFIG_SDIO_UART=y
>>   CONFIG_MMC_OMAP=y
>>   CONFIG_MMC_OMAP_HS=y
>> @@ -453,3 +456,8 @@ CONFIG_LIBCRC32C=y
>>   CONFIG_FONTS=y
>>   CONFIG_FONT_8x8=y
>>   CONFIG_FONT_8x16=y
>> +CONFIG_MMC_SDHCI=m
>> +CONFIG_MMC_SDHCI_IO_ACCESSORS=y
>> +CONFIG_MMC_SDHCI_PCI=m
>> +CONFIG_MMC_SDHCI_OMAP=m
>> +CONFIG_MMC_SDHCI_PLTFM=m
> 
> Thanks for tracking this down. But why still massaging this config? We
> rather want to switch to cip-kernel-config and fix any remaining issues
> there.

I am on it, until I find a fix for cip-kernel-config this can stay.


> 
> Jan
>
Quirin


