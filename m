Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A91FC4167B
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 05:38:24 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.62])
 by mx.groups.io with SMTP id smtpd.web11.6899.1702359501147917606
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 21:38:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s1YO6jv9;
 spf=pass (domain: siemens.com, ip: 40.107.105.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md9P8QHSeshE6mQfcTgfxKV/P55cvXwLJ0S4OYoSJZXHsxJSrdPRj7KEvwJUveXOiLjRrnlm9J1fZqH2mhMAsoxMzn51cjdYy9krIxnQLe+lZ5azXZlGc4ZJWRX7bSC53EYEbZELfCLqbUOLlXaA4OlWieO2KGGjGwskte3ax0YdhTDdYdMJKlXnIwVudTF8ukOhyBugEHrOjjEN4j5ZdAZkLNhnU+zDHnisCGkPDCWxrt31CBXe3hGc0Ecfe0gkCL8YD2qZg9hX8s4ufPfloaW55uDg0bPEPASDrjKQQznflZhJ7z2kemHkV04BQr9NbLO96FzJ0QV/j4gJ11xUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cfKvoMGrNjtoQXvqvyxttewngpyehmLVwt/RglXpdM=;
 b=M2ifB7WyJ/9XhdslKkRavfOtfsgucmYHOHbKB3XWjOZ6uyhaxzFM8O1sO3lrngqEQSReIkyPYVLk7YgKgWcHcVEsGv0wwCtj842hm3YeNTsrKy6JkKjaiTZ20BpelzbAFpI2T59FS6gjnMmwU9GBSYtDU9e4H4sge5Ksf+pr8/8H2pBiq4heVVP19EMADAFxV2Y75RW5orpKXF+z4W744jwy+6XxyxeyElnvLG0p0+CorSNEEvHbXRV8OPQB3ERr97n/IATZlTJQeo+mx13y0vM0fv8DICGFEGFZKJA0BkQ9LLIiJrYBTW9/ExwvKL1ATQiwgjgvw36kehtgfcj7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cfKvoMGrNjtoQXvqvyxttewngpyehmLVwt/RglXpdM=;
 b=s1YO6jv9zbl97karEjBmFE0uHJZmxQwDMVfTJjrF9Pe3YdRthrKf4R1KpcEiJR1docUlkz5Ps7yxbUzzf1KkPPnUoCeyVXnuQn2Al9E5tlCfY+vtxqazcUXLWtteD7eFMyqMLE68OlnAsOV7Cv+VxEOrUfhE5JmNnOSfpCvRK4JKgihtaDRINplyllxVNXx/SvJDJtfFSf8APO2prEJXc6D7FrW9sV0FzcO11n1xD5RlwePEhyVtyZmQ/hi6/6UToKerBHh8oDUemALMKWRekiFVhISqFng/dYUS3UHAHHlVh8T7GCNS69tXDnYvcVwUjC6mRiqDVU8CAkDzgHVYbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:38:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:38:17 +0000
Message-ID: <b5c05ce7-1548-4dbb-8917-c677e15958eb@siemens.com>
Date: Tue, 12 Dec 2023 06:38:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: WIFI in 6.1.X was Re: Potential ext4 corruption in 6.1.64-cip10
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
 <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
 <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
 <ZXbb/i1HuG0yPHXi@duo.ucw.cz>
 <df30a458-00c9-4b64-8963-27c556603981@siemens.com>
 <ZXdwwdiA6lh3VcYR@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZXdwwdiA6lh3VcYR@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe3b294-56ae-4bb5-95b2-08dbfad48ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AcGAB+TZNRGMTZIZp+0Trw7rhg/ZpYyC6YOMHwz4PWGtpE0amZ7y4NYSt9OuNUYNdoPLERsCC2maDnQDTGWfq/o3x+gHL+3heuVh1E9juPLcfVkjfZ5TIoBK4NFntySzBHV5rM7Lw6UGIxyGSCV1K+S6fIxeSzNT0NkjT/0omR5YYqpmB1pha7SeMNhyUnuBp+S2IsEgzq0IDj8rC3Sxhq4MT+062nv1YM4R9GNTH+f6M9jTFB+8dXaWKdx30Yg5UImjrEfzgoJ0QAva5sw0NhxbmSZRzNVJME8nsF3g2T1xYumvU+OOZtVLLSo5DoWkLXuqMelQOr4fEYJCpelRQ2t35BOxiMnQHoIY6KCCX4tcQwFLVSrhuu96DrNhzJsz6M/VGyJgyJJxCqaHHY3x5AethbRTsTZ/3DjuK8GcW/j8fJfr7cjxnstLidXlouyEhN8IV+EVPZSPYSWTPnjO6qI/a0YSz2NwMV/B+sAqc/IjT5DSnVqXKLx0fAGCSJrnk7yo8G0vcOtRyOb4b7eJ/2iiHfk5yQu1N9fDatPIzZsowV7HYB4gGi7Rvuo4uX6XFl57IaR7baB1dImcQ9NqOmRfW4Y1jXxXAj1E9s/3DTb2C17P6BO5EAmt/Th8rSXxGHXHYdiEkVI+1tr99o2bbw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(53546011)(6512007)(6506007)(2616005)(38100700002)(44832011)(5660300002)(8676002)(4326008)(8936002)(41300700001)(4744005)(2906002)(966005)(6486002)(478600001)(316002)(6916009)(66556008)(54906003)(66476007)(66946007)(36756003)(86362001)(31696002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2hGdHljUllUZ0FtbmxHN2daQzFCK2hjalNrNFNHWlM0WkhRWGwwOFFRdTNT?=
 =?utf-8?B?SVRtdXcwaUtPY2N6TGlaSE15Vm9pMkdZVGtmenVIVWNyUFFyVFg0MkJLZ0F3?=
 =?utf-8?B?aVBRRmdRRFBJR1F2aU5HZ2VlU0hkSEl3UnlvT3JHbXFhemdYanNQQkVGczh4?=
 =?utf-8?B?cldaM3hZYlZ3VTFKVS90ckZqR3hrRGNrZy9DbERwRHBKS1RVZTF0ZXorclN0?=
 =?utf-8?B?M0d2b0p4bHpuMHRiL3l6MkxRYnNBdDVqQzNDN3Y4OHJDSjc5WmR5Ymc1RjdU?=
 =?utf-8?B?TXp0dXhSTFVEb2pMNTBheWNXQjFDM1pyWFdOdlVicTdOMVlJTkNjdkx3U2o4?=
 =?utf-8?B?SlZhMmR4aFc2SjJITDUzaUxkaEFMRTVLU2hxVWVrMlJlRWx1bG9BK3ZuK2Vm?=
 =?utf-8?B?d04xdVY4QzJQd01Xb0tyRWFNdGVOTEFQYUxVZDUxOTdxdjd4MjQ3dUFiREx6?=
 =?utf-8?B?U24reVZDWkliT0l6WUhUeXFyeE9yQWlhdlFWSWF5R0ZsdW9XSDBJT0Ezc1hH?=
 =?utf-8?B?eklwTVRjdklSV3Z0U1dOVitBMWI3b09ESlRzSVlQOW8xWnFzcEhpR3FxYktl?=
 =?utf-8?B?MTBqUnVLWmFUTWIzOTZ3dnB2UHRYa1cxcmRFdGJZeHMwRjZGMnVXcGFPc2NB?=
 =?utf-8?B?ekNiNm1TV2Z1cUJsWDNBbmRYMzg1YmFwZ1FjUnN6WjFxWDRvVVJLYVA1ajhC?=
 =?utf-8?B?OWtmSFBiSGxxS3F0cFV5b1B6RUZMTE1OTXhxUHpDODVURi84d1h3aFBvY3Rk?=
 =?utf-8?B?WUpmMGdLTDRDbFZPZ1FqTEgwbEJNOE9teE4xTUZpUEdlQ1NNNEdrNk52UTlQ?=
 =?utf-8?B?ZTREUTBWcjA2OGt2OExnZ2E3SHNscEZiK295SGZNd0xZMGdnb1NsLzdPMk9Z?=
 =?utf-8?B?c2JaM0l1ckdxV2V0K1ZjWTk5dFR0cjg5MnVlejV0ZUw0WG9SMUR3UUh6TXRQ?=
 =?utf-8?B?M0JDd3YxTHVRa0ZIbkZBRFR4QlJxZW96eVBFakl2c2IwVllqR2g0WGNzbEl0?=
 =?utf-8?B?dHdUVHNYZXhXY0lpUko0dkkzY2p6dXFQQmsyWENRK09DdnZxbFUzd0pyTGNz?=
 =?utf-8?B?U1F3cEZrWTV0K0lMdUhBV0oxRnp6UFhRK3dlMTRKMnlDeXNIL2Q4QmpXOTc3?=
 =?utf-8?B?ZE96K0lWQWZqVGNnbXkyS3l3WGN1empjT1dWdnJNZXd6cysyWUxpcURmYUdQ?=
 =?utf-8?B?SG9SRW9MbVEzenREVzROTXRuMkxCYnF0M3lMV1hlR3hjaU5TcE9mZDd1cWRF?=
 =?utf-8?B?WllzelZyV25WdnhPOVI0MzNFditudkpVa2Uxb2ZFSGl1WVZmdlNQVEU5a1ZF?=
 =?utf-8?B?SHFBOHlSWlo2M09aYkswaEV2ZTBWNXAvNUNEQkdFL1NoS2NUVHZ3aS8vTkVU?=
 =?utf-8?B?WXhob3N6bmlrczNMRWNDZU9scFF5ODBUK1hsMWJ0dHl6SnhyeHlmdFRXaGdX?=
 =?utf-8?B?ZjBqdEZ1SGRFRGk5ckVoV2xpV1BwMkt0YTdwL0JKQ3NQV3p3emwxbVlTeXRP?=
 =?utf-8?B?a1NvMHRlL0VkNU92SjB0L29tdUkyUzI1YjZpWEwvMnlDd2VROE1hVGdYSlNa?=
 =?utf-8?B?SFdyMWVrNmF6MVVXY3BocGhwbVhRUlY5UUErSnRpcTlvTTRUbUVzL01Ucy9Y?=
 =?utf-8?B?ekVYOUkxYzBhQzNWV0RPV3FHelR2d3E2RTFRckd2YkpLMTZUWWZlbzNjeHZ1?=
 =?utf-8?B?bzZCTTlSQnRORTBFVUMyL0d2R3BsYmVxNTdxcHZqNVdCcWFkWkZFclVTcDdp?=
 =?utf-8?B?a2ZCeWJkUTBqVWxGUHB1NlozdnoyYkJaUFJjRk40SUxlYml2U2xndU81bHVz?=
 =?utf-8?B?cjdhT3NPTCtFN3RKSXFISVN4UWE2U3hZL2Y3VVoydi85eVdpZGxkS2svMTlu?=
 =?utf-8?B?SWVKeStHVnhWR09nT1hyeldjVmlVQ0U1WFVzS2ptbHhmWDJZMjUzQTIyRTdn?=
 =?utf-8?B?ZWFPZUVqdXNVQ2FOK2o2N2FHMmtWalhNeXZsdDl4b21pRGdaeUhzUjdNa2JQ?=
 =?utf-8?B?MGVqUlpDU2RPNUhubHc0OUNjQllxeTFCci9LQVJrdGdoT080UlVob3l2TDg0?=
 =?utf-8?B?OEpwR0ZTSGJrNzdrbkpubVBqbEVGNmFRZ0ZMMHhhTnhQcXRJbU9HSXNFZk9l?=
 =?utf-8?B?RGQzY2p6NE9nZG1iVmVJNXAyQ0dDUGZWR01Lby9ld0l1d2VKT05LOHptajNi?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe3b294-56ae-4bb5-95b2-08dbfad48ad3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:38:17.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRgJyk+SmkqjZmPdAshuAktBD2GzKlvlG+CbjDTSWbtxZGoMeMBrqAKe8KlCbj6TddS1uSiHr/61M56d4fbZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 05:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14041

On 11.12.23 21:27, Pavel Machek wrote:
> Hi!
> 
>> Ah, that missing dependency of the patch - subtle as it was written.
>>
>>> I'll just do 6.1.66 based -cip and -cip-rt releases, unless someone
>>> stops me.
> 
> Ok, this is not good week for 6.1.X.
> 
> https://www.phoronix.com/news/Linux-6.6.6-Released
> 
> There's wifi regression in 6.1.66. I guess that's better than ext4
> regression, and 6.1.67 is not nice round number, so I guess we do not
> need to do anything just now... but if someone is affected by the
> problem let me know.

Yeah, time to generally reflect on testing and other workflows, it looks
like.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


