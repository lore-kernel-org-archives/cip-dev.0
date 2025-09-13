Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD1FCAC58E
	for <webhook@archiver.kernel.org>; Sat, 13 Sep 2025 06:54:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.web10.528.1757746486923296458
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Sep 2025 23:54:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N1e+O+It;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov+uaH6j1mVYJ4id8jn0IVSgWcgJYO02ehnSLI3LN5gDW6CCwOVkvaTe/aAEl7Iw6YLbYcyVSdonqEjhwcrZvy1dNphmMSLfIUGI/8Er2XU9kkQOT0IVIXzshWTldDxGtgUMNPOHoGlswmDA+iQEpQP9jtZ+a4fYwn/qtLbOHZo0EndKrsUECu2NUOc2Mkl2xiW1nT7osjESSN4uac2u9Tb2b+WGoGb7N/RbCjct8PzfyfOWWXRgFtdnKMu3orvAi9wrZHKpoECX7KbhT10M137Akj+GF6ElLNfHk5IQQ55RnGFbBcs5thezMPmox8wCADFoJ1AHrXtBGtQ6mxGLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuMfpoJhiNswKyrCDjnEHb51H5X08/JXOAwEY2ulGzM=;
 b=oCRGKlZG6WWS2I+WFpaXDJHREmH4qZZ/FY1SsGOa0vYqeSfSBWvp5P5rOB/6wKkoTSUl5BE1eDkjqA/qjdUrR7JL2NcEBoCVi/edr+9vuQ2kwD3ow86XruKHShIgrq7eU5ZxG1I6NVIG3WSyHAUkWZLGBDt6luCR1fjR1oMLC0rxayj5T9q7MFOVmmmtitstEwraRqItaOXRgN0lEWipLRjgxuoTTCCAXGh0YTFytYb3PNXi6N1fxxEkFSG2C2ESQu1iXY9GVSN9LMYYz9Xdcmcavw8Y//Yho69bSBvNCnqbwkF6PIm5dajrtVlhGHA7KsNHb1W/6FG2s/edjmwuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuMfpoJhiNswKyrCDjnEHb51H5X08/JXOAwEY2ulGzM=;
 b=N1e+O+ItikR4iZ7TdCAkp7aFRX7dbM936iPtesnlLys3a7QOjyttgvPDy5DGui7IWSKj2/E0GYewCzT5Kaut5qIm6/mwfW4BjuRjfi822TqIZHgSPZ21z9g7s+YnofsLxSRWT04u9FgnPwG/1Yd+SPJiuLGdcsPnWVLB2uqPXSVpUs+s4vW5BFjqmK3CFi276X0qQccIgneir12+STcseBH16KOBZCXVhYLPrtvTQsgvrcbcBX7EZOQnNRuRp58pdjsVfzUI8aMASfyF2FdFgzl0MAtwog1iAhUvXhKKdreLXI/VotHLHrNUewvL6XZyxANYzkco/IbChGivqgg7Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB9058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 06:54:41 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 06:54:40 +0000
Message-ID: <f21c1149-65b3-4dfc-9212-49e4db3abc28@siemens.com>
Date: Sat, 13 Sep 2025 08:54:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip102[-rt57],
 5.10.241-cip64, 6.12.46-cip8
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7468da33-4cff-44b4-a287-08ddf2926979
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WXpaTFFaaFNadEtRL0Y4bVl5cmJEY2x0S3BJeHNLMjF6ZlJvUWlmOWE5a0U1?=
 =?utf-8?B?UkdwVWdla0pUSTg3Szc2SHduZkZNK2dKbDcvWTBRNUswOEphTENSY1hYRHRs?=
 =?utf-8?B?ZFZoYXcyYUo5ZGhyNFdQbHkyZGRmQkhmSXFUbEVXcUVPYUdFT3didDBSYkIv?=
 =?utf-8?B?T3pCclFFTDRUZUVIVWtsSnFWaFdYZ3NIeGpSb3VUdWpDUzgwNWYyUHJXeGZG?=
 =?utf-8?B?M0xxQ094bFFPSVpZRHdTU1NZVUxONjd5YzlrUlRvTk5qVXRneS9tRWV4TDdn?=
 =?utf-8?B?VW9zVHNybll0d1o0VXhzTkxPSXE0NDVoTVdITUVyelMyZXplRDlwQU5yUmt2?=
 =?utf-8?B?TGVmejk4SGlJTzBIWXhYcTV2eFJCVlFsSUVIYXZIYlBIdzZ2aTI4d1BEUEp2?=
 =?utf-8?B?aDlFaHpnWkpBY043T1JCWEtxczFnbklUWGYrd2RzaWNKdjNDS0JJYWo0dmNC?=
 =?utf-8?B?dFIvbHJaYlJHd1pHL2lxUDBaMjJLM1pua0tJaTVUby9nRmlCcDVrVUUreUtp?=
 =?utf-8?B?cU44bUxJa3QxeUJqQnFpM3ppZ2dXbStiZHZoT1JjVGZmbDVwajd4c2RQNjdz?=
 =?utf-8?B?eU02MEdVYmx0NXJqWm9tY0RiVHBoK3pLdks0SEhMd3ozUVJtcEJUUU9CSHha?=
 =?utf-8?B?QTZ1SVJtMzlXVFAvZzUrQVRMc053YlJxQy9hNVFrWkVrUUVlNGt3cFkxdlJC?=
 =?utf-8?B?RTl3eTdhSE1KU1UxSjFUSnY2L0ZwdE5WOFQyS3Y5aWE4Y2ZELzNuWkJJZkwv?=
 =?utf-8?B?eGNDZjZSbHY4YU1BL0doeDBXU09wem5NS3Y3UlBJYTFlMTY0SGVYckl2K1dV?=
 =?utf-8?B?bWJDSWFaNU54SkpRNVBLSmFXSFhQRlV0UXpvVXAvNE1acVRDclZnQStRYjNw?=
 =?utf-8?B?eEdZU2h1UDN5VnRTbGpoS1dOMW5ZQkJrb0RzcWF3RmhlZHI0cUY5eldMWnZT?=
 =?utf-8?B?SE9hSFh5MDhLVFV2ZjBuNHJtQlVubFpxeHVseHg4cm0xbklDMTZadThGUExI?=
 =?utf-8?B?Q1JWWTFlcTMvL2hmNlNseXU1R0x6enlYUG5ERDgwWDF3YWJSSHA0WkZrNUE2?=
 =?utf-8?B?eE1EakRFczQxK01YUFdlRHViTkRrRSt6NDMxazdHWERWOFJ6NXhpUDlyU1R1?=
 =?utf-8?B?bWNzUWFBVHZBYWNIS3psS1lVcW42Vm9vZzhyRHNkSXpLOXJtL1c2R3llajRO?=
 =?utf-8?B?VjlCQmVZb2pudDVMOVJpSHNnV0VzbVhtSWN1bVI1TStiVytPcnd3bGVwVHJh?=
 =?utf-8?B?dkVNMFB1dFJ5cGFTNTdmZXVxRDNOZTNNejEzcVc0eWNLY2ZSSjBYM3hMOVRp?=
 =?utf-8?B?bWNKTFNWS1c5cS80Q1hnanRwQTZSWklwVFpBRHlGbnZrcS9xbkt5TTQxVitS?=
 =?utf-8?B?Nm5aUzFyai9icmxOYi9iSWhtNm53Vmg0WG1HYUZuZ2QzQlFSVHUzV3ZVNnl3?=
 =?utf-8?B?VDNOK2QxdnhpTVpHclFpRnJ0dHd3c0FjaldCWFZMZTJNYTJXUWpiZ0VkbTEv?=
 =?utf-8?B?S2Y1KzJ4bWFueXR0eUVZUmNTTk9oaG5LbVE0VXUyd0VtbHBQVHRkVVRmU3Fs?=
 =?utf-8?B?eXV5OUIxdCtzSnpZbFJHWU1Fa0VtV3RwUEV6ZDRHRGR1QzZ5bzNnTFp0d01k?=
 =?utf-8?B?R3p0MkJGaUZjOFQ4RnJQR00zdUJFUGRZZitEMmhpVnBQT2pLRmI5U25Oclp2?=
 =?utf-8?B?N3pwV2ZtaVdPRWxZeTlWQTUzcjN6dWNVNzE1SEFzWHRwaEcvZWo5cUhXcHFZ?=
 =?utf-8?B?Y1RLVzdTbEU1c3ZoQVl4UlhHa0xicmY3Zlk5NHh2R3RsUG56TkdEQXNhaTlY?=
 =?utf-8?B?Yzl0aEhaU0F6a0xTaG10U1ZwZ0FxcGFGRWlsbW9ML0t1azVKdjFMUVBaVG5G?=
 =?utf-8?B?Qm00anVuN3pzZ3ZTTVUzYWFNZU80c0hUc3Z5UHhmRDNZaS9nQmxoaWJxS1M4?=
 =?utf-8?Q?N+RMwHgB4iA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmtuczhQRW8wemh4UnBteXp3ZXVxLzJiaHgwcE1DUFJFWWdlOXJSWWxQRVhC?=
 =?utf-8?B?TTcvaGV5UkFGSUVpSjBNYlhCV3VGZEQ0d09HeWpLN1NkbWVTQ3llS0MyNXJL?=
 =?utf-8?B?UXdQUkd1NUppUzBZbFRYclR1WEtkdmpPSzVIK3kxQWg2WUFBeS85bWdlNi9i?=
 =?utf-8?B?TXV1SEhqNDdjN2xLRHdyUmZYSUtqZ2NqYmNQZnFQZmljU1JxeGVxcXBSUjF0?=
 =?utf-8?B?Y0owdjNFTXZ5UGhBcFFQcWhRWVJXRXhnM1c0UWZnVklWbDY4SHpJbklwODFs?=
 =?utf-8?B?Vm9WWFRDRlkyNXBNS0JyWlA4THFseVB3a3laeFVYUXVTWlVRenhCN08xcHM5?=
 =?utf-8?B?ekQ3S1Voc0xlNnl3bTJOaEM4aXZBb2Y3L3dZQUhNRVNJbzVuVWF2R1hxM0U1?=
 =?utf-8?B?c0VPTk10MEd6VkQ3Ykg0VUd0UFpLTmdVOTBvR1o3K3pSbTE3VjBJblFwY3pB?=
 =?utf-8?B?NCtpcXFuNGh2VXJoWE9DWDZESElGbCtneFc2UjI5a3BJcERwRVhCbjIzcTlt?=
 =?utf-8?B?Vnc1eXU3NHdlYVovcXVheVdEc1pPb1ZoM2doV3FQVzVTQzk4L1hiTUNlUUFl?=
 =?utf-8?B?MHJMNkFZa0ZLdFJzRlQ1cnIvS2I5KzhjdHNJenhCYnBBOTFodkZQZGZFWjly?=
 =?utf-8?B?SDkyZDdKR2piMzZTTEErZHI0U25qeGFkQUVyaEswQlQ5WTdxZjdtczd3Tjkv?=
 =?utf-8?B?WERmbzRLOTl1ZHNiY2c0cGlmeElsSWcwUE1KVG5oTjFNQXJsSUlJOFhHWDdx?=
 =?utf-8?B?UnB6N1UvK1dQMS8vSkZPTFdBRjNYNGkyMHRmMUNWdjJiQ2tYS0JZS0ZzaTlH?=
 =?utf-8?B?VEoxMzkxM1dwSzkzSGJGQ1J5c2VtS0tmT3hIbDZIUVdxc3NIZVNNYVBRZGc4?=
 =?utf-8?B?ZzRZMmN1czdLYnd5OHRrNjluNXZkL1lrWm4rR1RxQTY1VStEYzZBeUVNcmh2?=
 =?utf-8?B?WDI5MUY1U0ZjVHJCWVVzSjJCMUJyREIwZ0V1Q0NUZno3ZGVQWG1HWENVY2I0?=
 =?utf-8?B?c1FZMzFZcTUyOVdYQ2VUWkw5THM0R2laN1NIcFlRTHdMWUxJUDN5bEJlZ3l0?=
 =?utf-8?B?SGdJZ2w4azlNSlFrUDZ5WlpPWXRMVzMwdklBcGY4am4xTHZNVWF5Y0J4Y2dM?=
 =?utf-8?B?WElnekM4clgzdWFVOFJGU3RzR0ZXUGIxOFNKdlplWmlmK3JYUDMrQUFraGNL?=
 =?utf-8?B?UzlRc0ZCSytLTVV1eG5DeGRQMkIrTkhhZFJYbXkySlpvZC9McHB5d3lDVWhu?=
 =?utf-8?B?eHRHTExVUXEwQ1Uzb01YeFRIRlBoRnAxQkxDeU80U0F0QzB2ckxUSThvWDFK?=
 =?utf-8?B?Wm9qZmxVd2RVVlhsNGdjTnlVbVFqaWxpWEkwYVYyS1hKaTNJVHV3TG1WdDNU?=
 =?utf-8?B?LzZvK3V6ck93eCtzOFlSYWpqU0dnbHIyMk5vdncxdFJJVmRwSVRsUHN4L2FM?=
 =?utf-8?B?UTlDVUNzRStzS2h3enlKMVU0NjBpQkpNQ2d6YldIeS9rZnlNOVhEOXQrSHVI?=
 =?utf-8?B?cEZ6aEY4ejBaRmtQNEdHM3EvVUh1N2R4MzBCZ04vaWYvejR3c1htMHJPTWli?=
 =?utf-8?B?WUdSUkJzejU4ekNmUEx6WDI4RGppNERpUmpuYVJvZytSVk9ZdGhSTncrY3Mw?=
 =?utf-8?B?dmF5UVB3aVJQOFdOK0JZKyt6WGhrRzVGYTdBeG5JN2NYTE1kVmhXS254akV0?=
 =?utf-8?B?bE5WSUxBYmRFamxtWUVMZDRUL0svVmk2NUFCenU2Mk5pMWJaN2pURDZYZ0J6?=
 =?utf-8?B?TkJJZFRjd0ZDTDlFQldxbE9OQWZBalhoRzROZzJ3ZEM1Q3I2TmxabDBBVHBo?=
 =?utf-8?B?d0RNdlBhT0c4ZUdtNzJYaS80M2pYSldzS0xrOFdNbmVJdXVtSW9UVVYwclA5?=
 =?utf-8?B?em9ibUpFVDc5NTVKQ0pnM0JTbmU0ZW43QlRTUGF1ZmFnREd0OE1VWDFvRk1q?=
 =?utf-8?B?RTFObEwvVkRvbXNlL215M2svQ0xSK3kwMGdyT1pyc2YrbCt5STExb3A2SEZP?=
 =?utf-8?B?dmxrMk01Rkw5dXVNMnB0RUhiSzlKNit1Wm5jQ2RIOUZVQnVVdWRPU3V1bEJH?=
 =?utf-8?B?cDF4eTB3ZDA2QUJoV0VkK1FJaVhENGRqRzNaU1ZtVUdvUUMvcy9RSk81QVpL?=
 =?utf-8?Q?UfG137Bx02EOCCkWRrDx9X8tQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7468da33-4cff-44b4-a287-08ddf2926979
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 06:54:40.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akp1Q9G84iEZnnw/KqOANy7zDiDl6k8nc/JoyHc7jro6ELlznCsTcoxefwhQCJMNgy4wpNMg+ENwWV3uP8JBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Sep 2025 06:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20045

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip100-rt56.bb => linux-cip-rt_4.4.302-cip102-rt57.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb               | 1 +
 ...{linux-cip_4.4.302-cip101.bb => linux-cip_4.4.302-cip102.bb} | 2 +-
 ...{linux-cip_5.10.240-cip63.bb => linux-cip_5.10.241-cip64.bb} | 2 +-
 .../{linux-cip_6.12.43-cip7.bb => linux-cip_6.12.46-cip8.bb}    | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip100-rt56.bb => linux-cip-rt_4.4.302-cip102-rt57.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip101.bb => linux-cip_4.4.302-cip102.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.240-cip63.bb => linux-cip_5.10.241-cip64.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.43-cip7.bb => linux-cip_6.12.46-cip8.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb
index 5d94f7ee..9800cf9c 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "313cf525f5ce70b5ef99ab329360f5beba3d82a594a896d041d9c17c4b1434d5"
+SRC_URI[sha256sum] = "1d6cc128cdc0e763dc645364b1f49ecc4d6d31f9be15bb31774a9c4e2dbaed49"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb b/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
deleted file mode 120000
index 091db61d..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.43-cip7.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb b/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
new file mode 120000
index 00000000..07b718bb
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
@@ -0,0 +1 @@
+linux-cip_6.12.46-cip8.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip101.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip102.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip101.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip102.bb
index c1e0efd1..6a58804f 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip101.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip102.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "631eb00305c944e6f10d7f9227962d8d468d60c9bb83d9a78901074a05007a96"
+SRC_URI[sha256sum] = "1dfeb1f5efd4636a652acf1d42fde90f39c1381269b23d91697b5b3dfac20666"
diff --git a/recipes-kernel/linux/linux-cip_5.10.240-cip63.bb b/recipes-kernel/linux/linux-cip_5.10.241-cip64.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.240-cip63.bb
rename to recipes-kernel/linux/linux-cip_5.10.241-cip64.bb
index 40841607..9c206f1b 100644
--- a/recipes-kernel/linux/linux-cip_5.10.240-cip63.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.241-cip64.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6a84a1f1395b99040b06fcea02f8884ecee6da85b345edd2b160e47838a374ce"
+SRC_URI[sha256sum] = "b629bb6a300d5204baae478b3f80434f43cced6a500aae356d57e38c2956cb95"
diff --git a/recipes-kernel/linux/linux-cip_6.12.43-cip7.bb b/recipes-kernel/linux/linux-cip_6.12.46-cip8.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.43-cip7.bb
rename to recipes-kernel/linux/linux-cip_6.12.46-cip8.bb
index 4a23b9fc..dbda1fe6 100644
--- a/recipes-kernel/linux/linux-cip_6.12.43-cip7.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.46-cip8.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d85bb43cc091d7cd1b860dceeefad4345d5a9bd39d81c1abb24fd962e21d537f"
+SRC_URI[sha256sum] = "5a6ffd6c3c98e578c066d3e0864ac12cdbabd5dfdad1f86ee9eb532099db5f14"
-- 
2.51.0

