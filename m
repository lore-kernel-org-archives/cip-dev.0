Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF9CCD185
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 06:08:20 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.43])
 by mx.groups.io with SMTP id smtpd.web11.9192.1760508493358398863
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Oct 2025 23:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N4Ach1QQ;
 spf=pass (domain: siemens.com, ip: 40.107.162.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkuCU9eiUcTr+PJB37O0PkxQOFgQ14qF22JrEYpSX5/MsGie0d6O1u92JDXfAkesd4M+Fshwok/1fBjizDHVBkyxPpg4n4yJRuKI2NO6jjzHoJTotqWRAWLcF0vTw/n8XMCmgfMg5tw3u63EPk4T7nsFqAw5C02SzNVnrFtQ7FWHQ4poh1TkDj+I/+Kk+/tc7YVFpFHthclXzs0okoaAJeRwgqL852kTNkCMhws0MO4WHfdor+muTm8UesvW2/i8OW0WftYsrmgYz6mVGpbUlB/rYjKeEVpljnZw8DjZgkj+ZXcruXMKVQPWGJwK2K5+YoqETY5MwzSDq8ZB0Ulubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+CqF+JhoWXFOBZf2s1ejweP7YY0POBmodGDZ3+zInM=;
 b=Sq8ThuPFRTAY1X3J2YyfdgC04utIuMzCErHQs2q3Szm8749cBWKK2UmrDYkUK17M/73cKkSuEnBF2cfanp6COPeqrdwXSxGBHAGluIK2muSB7mQstgzZs4AfYy16lQGqRcudEsmERIm9+nZE9QV6TJO1dWL4CRVJUo7AxBQh1B2Y+f5Hs6C4k81FZTqcZvBhVjybBcsgcoZGkq/kb9eGMph13fGWsPaz/uMdwMH/rECXbYWL5/ev7ZNj+99MAevn5EBh+xyN6i7c6+Cr+8SJvgrM7Xr8qEy7jmCZDvJYYvm9t6+X7BBKxdsaoAJxp7sLXM3NlO0fOgXwVlcCWejQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+CqF+JhoWXFOBZf2s1ejweP7YY0POBmodGDZ3+zInM=;
 b=N4Ach1QQIOwrrrPANVo28qrCndgPe+JL5Qm+RRK+U13p4Z6JxSijGCrAWxNhiWpnHxHTSr3IEC19+/yEQMhevJVbp8305YyrVcajqqOgpaD/6Z73Rvk8WQPZ3bmmOSH1v4YwVr4ZGExHPoELaqSIQk4qsWnxMKso0yCaf/iGW+IGk07XUk8BkIKMM1Yi1AJSfggYhnddzNex5vynuO8MlLgTVDFiJs/SjdvN+aIkuEKa5l3NNUmu2N4m5TlUYSMNAyNPg0kZ3y8wS8agOxkApyJ1+UJ+Y5z7AW5d+u229vYqsQONeEWf+SuIh8puPzaR6aFRiBCuA/Uv1k/U4szX3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 06:08:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 06:08:08 +0000
Message-ID: <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
Date: Wed, 15 Oct 2025 08:08:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Shivanand.Kunijadar@toshiba-tsip.com, quirin.gylstorff@siemens.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3469ddc7-d294-43f5-1066-08de0bb13685
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHMrWkM3Wm56L1g0c1d2WjBsbFJWSHIrR3BlNytYbVM1WVo2eEV4b3lGcm11?=
 =?utf-8?B?WGpmSHJqemRKSm8xVVVwazBveFJ4eWlxcHdqZkQwZGRMS0FveWFJRTJRL3NE?=
 =?utf-8?B?WEZodmpaUzlua0JMaEVIak9xTWxZY2ppTXpIOUVNa0FIaFFnU3RkWjg0SnhD?=
 =?utf-8?B?VVUvbGZ4U0dROVdFcmhBYTI4bEUza3lnSkRGTlRZVUZJOVYrZmZZc1RuZzZS?=
 =?utf-8?B?UUdlNEZEZ3ZUOXV1YUU1QUVjeTg3T2gwdm1Od0VOK0UxTFBCM3hsdzhFNkdn?=
 =?utf-8?B?Tmw1V3dVOWw0MjEzUVBuWWovYTgxaGdzVXhzRndjMElXZmlLZlhHdlMvSnJy?=
 =?utf-8?B?dTFkejRQbjczKzhQb0pRcEgwczdtM2pzNmRGSmVTMTlsdzl0S3RvcUFFK1ls?=
 =?utf-8?B?TDNRSUorOUdrNW9mTGNnYzl5aVFuWE10NlZ4blpKU1ZXOE1vZHlPS1lndEdw?=
 =?utf-8?B?dEVBcjRjQkY4SnlPQUtXSGlmOVFPVVh2YjNpSGVWNjNJVGVZSjUrZVpNaFRU?=
 =?utf-8?B?V0xlVnZ3YVhZMlJpZ0RzcGhHVjMrb0dGalVyRlVOOCt1YVpOSHczVmVaaGhH?=
 =?utf-8?B?YkRUajduanZVOFZBVkRlbGJudnNISWdDbXc3OWVpbFRrbStWd1p2ckdURlpW?=
 =?utf-8?B?VzJpTWtoUzUwUy94eG9WWWhNWk5GMWh2U1JrZ0xNbGZyTzhjNzNFVHl4cjBK?=
 =?utf-8?B?MFNDNS9Pb1ZMMWFSbWVhY1BTSUl2V0ErUCtDM0dpZTRpNW5Na2huZzZiQnZB?=
 =?utf-8?B?VkY0dkJTaXlFeU96aEtLcFhsckNqKzEvQmVHUExBbmdDWTQ5TU02aVJxNitY?=
 =?utf-8?B?Nlc1K1JUNG50OWJ5TlN3dHIxcjRYN0J6RG1Ta3FHUGMycHZIc3dPNWt1bUly?=
 =?utf-8?B?cHRLTW45RkQxbVJvVXUzakZ1eVZmVDdhbFdjSU5sV1hLK0NpdGRCYW80RTkr?=
 =?utf-8?B?RTkyTFRRTUttWVVSV3R2NS9BWFNmNUlSME1PTFE3TnYyb3FJR1FWZG9wUk0z?=
 =?utf-8?B?NEU5T2JxVW9ETlNxWE85UmVoTFV3NlBvS0M3aVczckFaWnR2aXp5ckx0Rm1Q?=
 =?utf-8?B?Sk0xWGYxOXhDQWhKOHVQcUUwUGd5NmkxWDhiVHcyS1pVTzZwNFBUVGVDNHVX?=
 =?utf-8?B?M3lmd3VWTldFWnhNL2t3NlhGaURqQnRIV0VKSzJpZEpKcmVrbml1NlVCMDA4?=
 =?utf-8?B?Mk5UQ3dQSVgyQWJ0TjNwaWtFNVZDZmhmalJRVjRSL0c2cjBpczR0UndDaGdO?=
 =?utf-8?B?ejY3dnpRMmx0b3hoUGN1bjh2QW9FaS9rUXh2dTV0MitXcWh6WUh5ZnliQ3VC?=
 =?utf-8?B?Z1poRGZ6QlhObXovMnAyREZSS2ZxS1pLK2x5QVVqeHQzTnhNbUJ1dTl1dkxF?=
 =?utf-8?B?QjhTWUFBeVBDMEpHT3RvR1ZlWm5raHhROUFkZWk5ZWEwaEFyZWpsUVh4TjVr?=
 =?utf-8?B?SjY4YXBjcklFTHgxdStSVHQ5TkdhM2pRV1o4Z1U1REphY3hCbVZrT0pKbGFZ?=
 =?utf-8?B?ek9WVnRZM3lQS3hra0ZFQWhJcTdWR2VhdTZVc2ZRQTIySVp4S1JVWmRUVlJD?=
 =?utf-8?B?OWNlUFR4aURFM3V4Vy9sVlpTVVI3ejlGZHVhL3F6UG5xQ0l5MUJPQ3pFU1Jy?=
 =?utf-8?B?V1ZXYVpCNUt2OEQ4V3pKN2IrL1VkTjQ4dHhZVXlMb3U4OFB3UTdpaG51d1c5?=
 =?utf-8?B?Mms3Q0F3RjNVQ3g4WnR1VVE5UmNIVTFsSFRQL2crK2JFTDdaT3JySVBGMVhV?=
 =?utf-8?B?WXR6R1lLSzBnQy84MGUzZU9uV0JudmE4eS8xQTVVSEdNNVZFYi95SzgxU2ZZ?=
 =?utf-8?B?TTJqUE1mdCtTbUlYb0w4Ny9qTkd0ckhia1pzclZGM3djZU5GRUh4a1V6YjRV?=
 =?utf-8?B?QVBzeWxNcUliMUdueXJmdGUyWVNnQzNCMlh3UUo4VGl4Y1BxenI3UEdsV0Ru?=
 =?utf-8?B?ODM0bGY1RHQxaGsvd21lT25HVElpMG9BL2NBR2RvUFZsbHRScG5nSHNOTWtZ?=
 =?utf-8?B?ZnBuRjB2NDZ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2F5OGhiWHNjcVVsNURPRnF2YmRnK1VBWGRkUEQ0d1J2VWxCcEYxb3JNOW10?=
 =?utf-8?B?OVFKOTBtS001T2R4c3MxUmduTjhlemNISjg1aEozNHRzWlRJOHZlWVFYa0Nr?=
 =?utf-8?B?ZlR6VnIzQ2MwWlFDVit5bGpGZ3ByYVRrYm5DWkR2ZmlRRExFR2dwcVlwd3lK?=
 =?utf-8?B?WkMza29CTG9odUpIS3hCR1RpeVAybHNoV1JNazVQQnZIb2UxYm5KYkRoNkht?=
 =?utf-8?B?cU9TVUZ1QmdQaUVwcnhwYVBlS0hvbU9rTHJ4a1pid3grdjUxVHpNODI2UW8z?=
 =?utf-8?B?WW5KelhHR1hrYk9mTThzUGJsK2Vxem1PdmVETHJGY1hhdEI3MTlYL2l3QzNi?=
 =?utf-8?B?eDYydlRNRTA4L2o5TXB1WUhMSWozaFJlT2l1VDk2UzZuVnhBeXBJZmlIdGhP?=
 =?utf-8?B?N0dwSGdHdEJ0MGZHeHh0QU14ZU5CbENLRTFkTENITWdkdU1aL3NMRE9JQ3dw?=
 =?utf-8?B?OURtbENwZzc4ckdRMlhtYjVjRUdkRlNkWVZkNVh3bkVaWlF5OW8rYVVxU1BQ?=
 =?utf-8?B?LytwaVJhMnIxK1EwSGQ1M2lzZE5YUHZES3lFalI3aEdOUms4MjY4SmpwSHNR?=
 =?utf-8?B?OHdFSzg4cExqeWVjVkFIRGVHTmVjVGxzRnc3YytVNnQxVVJkbHlSQStoL3lk?=
 =?utf-8?B?Nlk3S2FzckEzak5sam9Ocm1IMkNtUkFvdFdlNTcvNzdiSjdMYTVLWnA4b1Zx?=
 =?utf-8?B?cmQzbzZGVkFodVlsY1NzTkwzdHdTenBkay9tOG5mQ29ETFBFVFRGbG16Umdk?=
 =?utf-8?B?ZVpJYWRjQ0lCVUZYMy9KNUYyZTNHZkhhbFVGUUJJRU5PeGVXajVSUkVVMkk0?=
 =?utf-8?B?c3ZHM2xSeHFUdllQOE45VjBXc3grWHlvZ2lzODJtMXZYODlYaUN2YWxlQTVC?=
 =?utf-8?B?Z1JITTBrQWZmbGJjVTg0SG5HQnc4VWhQbm5aSC96WnJ0MVlhTXJJNWpHMGdI?=
 =?utf-8?B?WUxLZ0NzYTRIcUF1N3Y2ZUMxL3djQ3g4MElyR3E2LzJCZ3V6VW9qQUlGYnh2?=
 =?utf-8?B?OEpzd0t5TXNVbDJTdTZtTEExMFM5TklYZVJCSnh4UExkVFBMY2VZbUxFZlJ6?=
 =?utf-8?B?VTk1VjdjMUZDVnlrL1lsUGhGaW90YUVwWlRsZGxlMGxXbkoyZGVteTVKL3Ri?=
 =?utf-8?B?K0lFaitsdWhNZUltTDhTeGVWemF2eWhVVEhLMytWZGlUcENWOVJrNjNhanIv?=
 =?utf-8?B?S0Vkc3FOa3ZQUjJlOVVNZzRsK0N6alZwcHBobXFhRjNVSjRLNEd3c2YvSS81?=
 =?utf-8?B?RzlGeml5d0Z4TkM3OUpyMEFWbENzM2loeXJLNmFObW9DQ0dxVzRLZGpUL2d6?=
 =?utf-8?B?MGhyQ2grRWRpbnlWRjBpOFFIZ015TGQyeDVpV1Y2blNqdDFxNDE5Z3U1NEx2?=
 =?utf-8?B?VzVuVnNFazFpMG1HbmN6VklGZGtqZzY0eVFxaUljTmljK2lPUEp4L1F0SDlN?=
 =?utf-8?B?Rm5nZzJKd1VqSmRpY293Y0tSU1BiL2lOOE8vT0JTdjlHNnhNMlFTNXBpQUFS?=
 =?utf-8?B?RFNSdmVXYkx5YTlSQ0UyVDRLR3crcisyMVpZcFFhdGg1eko5YlhkV2Z5OWlm?=
 =?utf-8?B?SVFOOXJUQWdlVkFLYm4xMUsyVlB0UEVhVXhBd3A4S09RU2tlUVg2c25XSVYz?=
 =?utf-8?B?dXNGczFsZ2dTSWJuYVlwOWZ0aWRaOVZ0VXMyZzI4VllFdlhUS0Y2eVFSL1l6?=
 =?utf-8?B?dG1tb3VyZ1BUNnFWUjlKQ3E0a2FmSnIvNTRpK3d3eGRqeUFid2E5d0RqRk9h?=
 =?utf-8?B?c0lkdTJoMS9NY0NJK1lUQk01ZEJqdXJRdjMvVjl4cWdGWVpDRGU4TlBTRjBX?=
 =?utf-8?B?dVFyQUF0dE13QUpQeVdiOG1JUERzVTVlN1JiVXVTN0M3Z0x2T0FiSCsya0VN?=
 =?utf-8?B?L1NwM2JhbUxQeUp4aGg2clFud25LR3JBN2d1ZndyOWNSb1RjMkk2akc0QzNT?=
 =?utf-8?B?TE95cFBnSDNBOFpvQS83VkZwMjZOWDE5d1hrQjcxazROR21uTFYrOHlXMHNN?=
 =?utf-8?B?M0NsVEhhc3ZnUG4yNDZTU2lORlJIUmx3R282Vjh1QkplblV2aTVqYXB2VU5U?=
 =?utf-8?B?R3FJQmllbFBOZTQ4dWJsUlJGS3BncE5Vb0pRN1hxTHhRWXRNR1pyRGo1a2Jy?=
 =?utf-8?Q?Q8FRgj/3w2HRnd4T+vyN5dRkl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3469ddc7-d294-43f5-1066-08de0bb13685
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 06:08:08.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpyp7FE8QcHd0xIkI85tTqjRK+0/A+yG3wQvWUfvfSrKZp3z1wzkDXAThnRGsgiHyQcs0buSzgJ/9ieqNbk79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 06:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20175

On 14.10.25 15:54, Jan Kiszka wrote:
> On 14.10.25 15:18, Jan Kiszka wrote:
>> On 14.10.25 12:45, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>> Hi Quirin & Jan, 
>>>
>>>> So, this is apparently no longer an infrastructure topic, it's a test case thing. Next question would be if anything related changed recently, possibly in the shadow of our general lava issues?
>>>
>>> We checked the LAVA lab for M-COM IEC test execution details. Last time, the test case completed (without timeout issue) successfully on Sept 22nd [1] after that all IEC tests which are submitted on M-COM are incomplete (timeout issue).  
>>> There is no test code change after May 27th[2] so I am wondering what is the cause of the issue. 
>>>
>>
>> We updated the kernel afterwards e.g. Also some Debian package update
>> could have brought a relevant change.
>>
>>> Additionally, today we tried running IEC tests on local M-COM device (booted from eMMC) and found that all the IEC tests are pass, taking around 79 mins and 99 mins to complete (for 2 iterations). 
>>
>> Ok, but that was the eMMC, not the USB-attached emulated disk.
>>
>>> As pointed out by Quirin, we checked the CR1.9 tests and observed that the CR1.9 related tests are taking more time compared to other tests, 
>>>
>>> TC_CR1.9_1+pass+758
>>> TC_CR1.9_2+pass+554
>>> TC_CR1.9_3+pass+391
>>> TC_CR1.9_4+pass+642
>>> TC_CR1.9_5+pass+712
>>> TC_CR1.9_6+pass+1
>>>
>>> +758 --> This is the time taken to execute the test in seconds. If we combine these values the CR1.9 itself taking around 50mins. 
>>
>> So, the other tests, which are slower because of the emulated disk, plus
>> the very slow CR1.9 tests kick us over the edge.
>>
>>>  On the other hand, QEMU amd64 completes the same tests in less than 2mins, 
>>>
>>> TC_CR1.9_1+pass+19
>>> TC_CR1.9_2+pass+31
>>> TC_CR1.9_3+pass+17
>>> TC_CR1.9_4+pass+9
>>> TC_CR1.9_5+pass+24
>>> TC_CR1.9_6+pass+1
>>>
>>> The CR1.9 is requirement to verify "Strength of public key-based authentication". As part of these tests it generates the CA keys, User keys and certificates using ssh-keygen command. we think that this command might be taking more time on M-COM, need to check more details on this part.  
>>
>> This is indeed strange. We should be running the same kernel, so should
>> have access to the very same set of accelerator drivers - if they play a
>> role here.
>>
>> But maybe you could try out if a stock Debian kernel performs better
>> here when using the otherwise identical image.
>>
> 
> FWIW:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2098796623
> 

The CR1.9 tests ran much faster over the Debian kernel, e.g.

"The time taken to execute TC_CR1.9_1 is 30 seconds" [1]
vs.
"The time taken to execute TC_CR1.9_1 is 448 seconds" [1]

We may have a kernel configuration issue here - or a real CIP kernel 
regression. Going back a month to a passing test, we got this back then:

"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]

That was isar-cip-core c792ad5f with 6.1.148-cip45, while the slow 
version was with 6.1.151-cip46. Debian used 6.1.153 above. Our cip-
kernel-config repo was not touched between the two versions.

Does that ring any bell?

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11714010579#L3077
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11650227707#L1957
[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068159#L1724

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

