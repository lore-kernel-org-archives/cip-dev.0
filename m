Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.537.1794203055363931515
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 21:44:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iFfYRNw/;
 spf=pass (domain: siemens.com, ip: 52.101.72.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwC5UtgRFGCX4lhndXSxwV6YjkCitJPaZ2DAyN3QG2cWWXup8NiHRK/QUIIJ5aA3pY+pec9axckx8+tVouQES/C03FvIHpJOTZYD5Zr2grUBmcf7P6lJ6WxBqdQ8lAIrNkN3IsvtDximZU2wSgTbSCxhe2M3p9AwMBz4DK5cDVDpM0kcd8Cm9kcqwj4Yq/wU8bauBj96E8qG6lRH79LoIlfAEXdNJ5sFZvSKYDRYkCHASzOcgEFynP7D6JYn/Yo08qdanXxMWpmHwZNG0BG4eRT9gGp7TFr5Os0bdTzbzjQRX6IyiY0EQaQ4NcTHQBZhuNNiGqg5R7GiQprhxCz8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwGQU2MZzZxn1cLoBO0gNBs973fFGHna8Zregk20xNE=;
 b=ABRYK8NTeSgov5Te5T1oYhbBX3RB/YQ03cx8vZK6moGYs3ve/mejidw+SHXqt1GvfWCzLxpXmQCEeiyymRZ523sh4ZiPCvNVVfKdGSMX5g51e9ryIUjJUrJrH5Eb7nwh9IPhzM1YTNkK6zD+F8WGVw/AKz1+mvEnnQjEbSp2RN+dNbW6DcfXAAUWqk0jWuvf3f5NY8LE1HESq9I8OIfuI4EDXqGAV3XOUCO5ZO14WqVranEadjbVqVAdBA2os/pmOAqlanbpYNxgfKTAxHZwinAvhiy8qtgdrK0HSSNnCYoi4R5kYv6u1rBF5AQWaN56uZjBY1WoM6kpVKtphX+wTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGQU2MZzZxn1cLoBO0gNBs973fFGHna8Zregk20xNE=;
 b=iFfYRNw/ySBoahjR7/8M3QUyGfg1JmNuD9qc1My5dPVDAjcFCdMDsSPqdwfq4XLkipyy2exrFAVRvFjKDpt/IE+t2s7Zg3OZflCYmeaSSigtRBxtQDsU3IUXxKcp4kbojxURzkt8zNtAMBHgKUEx5ZTPjH9TOB4ejR6qICFzUtYJpBCnjrwZj/ElhHrGBFzs7n3YhJdmt+zOL6hha6ZJ33SiV+KTI9Hi2YwfLZR9tEg2yfv5csW+haInma8SzRodVyLS4fUxi4rtK8HljbwLLbKaeOthXBtbeWbD/M7tuT+SdEkSYvzD6H750CIz6qUcQhWUSrgrZVF/xvaAuPeweg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8337.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:41f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 9 Nov 2026
 05:44:11 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.005; Mon, 9 Nov 2026
 05:44:11 +0000
Message-ID: <d140afbf-cc17-49f9-9b21-2cee0fb6a9b7@siemens.com>
Date: Mon, 9 Nov 2026 06:44:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/4] Fix build images for buster
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
Cc: cip-dev@lists.cip-project.org
References: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4971c6-846e-441a-6805-08df3e247ab9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261022115727099003|11063799006|18002099003|22082099003|55112099003|6133799003|261102123227099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 3fWwAdY+AvCpNI6Zu9o5yVOf4U2/2Osj9nKpDCmoVN+dJfXPVXirGLLWYY0uTF2cs0Knc2gf5ls2ufr6TKOTptog5Oa46/gBG6FqXCclh/qMw+wZiskclBq6ERgvGvbO9zoaRQHGsId6sofUykRL05n65DnOiLasUGkc8RzikMPm4EUPWh70dsrTlk7YUvuzb+5dAoqxuVuoZ3+PlfjtnctTKOkcJjjBgzE/bT+8hyQDKD8q05HwSUngPFoH+2s7d4AveLv8g+OecIjqUFKdNx/MPqrSq4jsn7lnLe848NvoeKn7os5UXSHtyzEjVjOD22xeuFdm4w3XJANhbvzhHIG13dq36+24obVkL7OCwNqziuy/WzZ7q5v0D5+F2lYQ97JpoAqVti3hp3VwXt/QP+/Psv0PZ9ZdBYGHrxyb0y/0/96o4C4HSoNBpTiM5qj+Hlz4lJap6j3vkQgfDjnd0Llqpcs8wGVlt7XcvQGxvrqXCja3PxmM/K7NJf7l5esAfyd3DNaAaO+NvPHL1RNTYMMFmK3iDKIbaeQEAp3fQQrv4hFZT3/BGRr2U2MUm8/lvIdg/Mom/BNIuTKfMyQ3gYCBeWv9hOd+HBXnWQusGAerpi5WjgXJmpz+5GsBKQabvhRI2+eUh7kFxm59lBS/OMgxQCLOtQPy9uBAmz50zvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(11063799006)(18002099003)(22082099003)(55112099003)(6133799003)(261102123227099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRqZkNzZG5VRnZmV2t6Z3AwRThnQnhjZS9qTW96aU0xUStkbWV5bk4vaWY2?=
 =?utf-8?B?MGFoSGZ3bVhpcGpDOXFNZzdBMmxuNk5YVWI0STFrbURYNFk2MndsY1Q0TS80?=
 =?utf-8?B?SVE3TW5aY2JKUGpDTG8raGVDcHppU0ZNVWt5cDVQd1NsMDRmVjc2Ujl1bVlU?=
 =?utf-8?B?MzJBVllYVGZEQnVnNUJ4Yk9mQ2NSQTZVRHBpRm9EUzhHYXg4M0h1ZUphTFdN?=
 =?utf-8?B?cUdJTHJVUGF5NEVZRzNVanlJdThlN1lWRWVBdlhVVC9YNDFoY2tZOVpYcXBF?=
 =?utf-8?B?bitabyttUFR4QzczYVBQcXVxQmZLcURwTVpYOEJnVm9CL2MxaE85VjA0Qlhi?=
 =?utf-8?B?Nnd5N1Z6NDMrSnloZzlSbmdyU1lHNmtrdnFLUkJHSHdQRjlDWVhJby9Rbmxt?=
 =?utf-8?B?RTJYdnRseE0vaDZnU0JFdUZJcjlGK3NwZjUxSWtqd1QxN2tKaXdZVTZnVGd3?=
 =?utf-8?B?anE2V1BHVUp3bUNQMlhJZ1VsTklqZ2dySm9KbGYvdmtxTjJLNjEyYnhoR256?=
 =?utf-8?B?VkJ6SE5kYmVHS0RrdnZsQWxQZXdVS0wvSkpSZmJJU1BQMUtIUUwxQjZXMlV4?=
 =?utf-8?B?b0RueXZMY1RtSlJDZ3dkZ0hqM2hBeXFkWWQydVJSTEc1Smk4bkVqUkp6dWVy?=
 =?utf-8?B?cFV5dUZ4bFRHN3MwUkhmL3ppVm42R01JOHEyOUFjYVRQY0FacE80U2tZOS85?=
 =?utf-8?B?TVhVNnppZ1dNd0g2RTlEY2dHV2hlcElVa0h2bHV6emhhVTViNDZ2OW85MVVF?=
 =?utf-8?B?RUNyM0RxSjV1c1JFVE5EdmY3cXlqNExsb2hodG80RU5QajE1K2VOSVVaVFZw?=
 =?utf-8?B?SUljYjJCQjJtMXg3RU0wNjVGVnRuYnBzUThNK1d2L1hjc09KVUZneXJkQkZo?=
 =?utf-8?B?UFo4R2sybWFPOEFrZ2s5TVhYWk90K1RTQjhURmJ3emt2T1Fpd2trTnNkanBX?=
 =?utf-8?B?THBnU204Nm5XR0pFNVBxUGQzbU96ZEtMOUhvNGtUWCtQWmpmV2tCWjR3Uk5h?=
 =?utf-8?B?ZC9rT25vdGJhTWxLUjhjRHc0RDZhUzJyQlZvU2F6cU43WEQxUDN6ZFBBa003?=
 =?utf-8?B?dFdLeEg4QTdtTURUUUdQZ3VlVnJwdVhNM0JhMFdDV3dobFltMEhqYWhVYmt4?=
 =?utf-8?B?ak5sYnRra0RTUFJjbGxqdVJwVkplU29kTDVFZ1E3L3VVNXZDcTRiK3hsb05i?=
 =?utf-8?B?ekRQbmx3cURtaHIvK3JId3RRRTIrT2ZnU3BQZ2FCd2dZNXNpdXNvWHd0elBC?=
 =?utf-8?B?ZTlhOG5CRlNOSUZHYXpkakxlb2FIWkNEWHhxRlBtbmp6cUdJZm9YcDlvcWR2?=
 =?utf-8?B?cE1WRGkvdFRPbFBiYTk2bTc0Z2w4U2o1Y2FVSE1odmhsMWgySk85aXhjN2xU?=
 =?utf-8?B?SmpuRjRySncvbVZjdWN0Q2RjUUJGNjZORUlOT3k1N0dsZFhvZlQxU0NMeTdG?=
 =?utf-8?B?WVhBWklrNlVQT2pWZ3g2cU9VenlRVlNOZUVDM0xJdlVwSTFkdXgxaHBIV0JZ?=
 =?utf-8?B?clFiZHpXTldnVDFYaDZCb2FmVHlDM2FtUVVFS05uekVVbEI1QU9GWnVjMDhu?=
 =?utf-8?B?dGZsY0F4QVp1WmJuWE5vODJSN1lvMmZRbzlHVXJpczNUV2NXUGJDL3BLK0E5?=
 =?utf-8?B?QVQvNVF4VndFVEx4UnhONkd1V0ZYSkpGRjh4Z01TQUw3bzA4R0RUOS8yMVl3?=
 =?utf-8?B?cjRwcGc3UUdrdjkvUXU0WnJZK0I3WThiY3RrSlFHS3djeHZGdnpVMllzTE1k?=
 =?utf-8?B?OE82c2NSNEFpWVlMcjRTOVgrU0VjMlZTcHJyOU8rVng5OWE5b3ZHNVptUjBZ?=
 =?utf-8?B?R3N0ZWRIbjAzUjd4NDR6SkpSblRxdERJTW0yZ1hIbmdSZVBOd1pGdkRwaXBF?=
 =?utf-8?B?SEpLZGhPcUR2SEFNa0d2V2h5b0JTQTB2MFVDeDVFSnhVNERLMWo5VWhGaVBx?=
 =?utf-8?B?a2ZNSlIxOTJZS0w1SlhUNUR6bWlHQ2dZbytaZ3hUaXNDNTg4YTEwZDc2T0xV?=
 =?utf-8?B?dE1ERFZwazdQd0dCa3JMZUlURkVWckhFa3NDOTQ4VCtuS1FDQm0ycmNkZm9j?=
 =?utf-8?B?NmhIdURCQ1psejREM2MrbmcvYnRuQVdsUlNjUzFxdUFheEp0cUdMT1k4ZXNS?=
 =?utf-8?B?R1FhNzRKeWdqcFg1ejBySEc1dS9EZUhWbjRYa2hnQmhEanFETE5SMkpaNVdG?=
 =?utf-8?B?RlE5RnlNb1RLd3c4dlcxempQYWZaR2p5OFlJUHY0TTZWeXBOb2R4QkpObC9p?=
 =?utf-8?B?TS8zRXRtMVliQTNVbWVsVHZnUnA4UnVPWjJ6OWRLSENTRkh2cVl5VVVzSU1x?=
 =?utf-8?B?bjJKRU1meWJVU1o3WkpTY2xiNkkvNFd1akVjVnNRbDA5dzZQeEZ5QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4971c6-846e-441a-6805-08df3e247ab9
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:44:10.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnGvo053+xscHX/s9p13/8ExNGZURzlHIlLeKCZ7MoskBTtVYCfna6dl1UCtA/ruTSOTG+rqmS3u7+/fkcdQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8337
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 05:44:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24680

On 09.11.26 04:58, Nobuhiro Iwamatsu wrote:
> This patch series fixes U-Boot build errors for images targeting buster.
> The build errors occur because the version of GCC provided in 'buster' is 
> incompatible with the requirements of U-Boot 2026.01.
> This change adds U-Boot 2025.07 again. And when building 'buster'
> images for the BBB or de0-nano-soc, version 2025.07 will be used.
> 
> v2:
>   Fixed commit message. Change from 'revert' to 'add'.
>   Removed unnecessary patches from the U-Boot for BBB and DE0-Nano-SoC.
>   Removed the recipe for QEMU.

Why did you drop QEMU from this list? You can still configure
arm+buster+qemu+swupdate, and that will not build. Same for arm64.

One can even configure the am62px for buster, but there we cannot
downgrade U-Boot. We should limit that board to trixie+, I guess.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
