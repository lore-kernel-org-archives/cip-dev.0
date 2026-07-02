Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00640C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 09:13:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65418.1782983594637120664
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 02:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lfoslYKD;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7w+Su902wyq41+BXnYRKCPwPKPy2ZqybViGV4unlLGjj3Ut+OIKHPUPVvVSINIziU8lrTEqAU/KcI7WCEZkJx+cb5Bp+EtGYkj6yfZOt6wTeAfOKQy7JC0SwZiHheM4v88INvqeeDAlxeDvOJCPcPfvXyNFzCxoWJTp8ilFhkNrYEECVOME0rbMqBCUI5I+Z+f2wGAVMNYrjzCkmJwOT56MJSbs70yyeIj5owU+6FBsP465SaDFKziGfqKlFmwoqoQkNfTPaeLn6icyBUphEju6sfyFN0mxrxVstTrZlv6Az4jRff5CwUIhsLrEc6FThzBLXffWfF6zh2tmPVSvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW3paC9H1IYX0q3lLV3xZuX9x0d36v8ax32Y+l2iIxI=;
 b=Xh+PLnbNI8NCasCyGDi1cAunmjsvD1EbIB67C81Qo7A4zESNBUrdCEGmFt03UpuRFTJw9aRfGmZXb99e/dpUBpWnaM3vK0a2/W0oLd8Oyjcs7Uakkzu9GJTGS4yL2UcG9sw35EyoczWx8Cg4qxvZKK2zu/Z101bd6lnEVbHlwlQ2UDq5xc9nUZuJix7mOhT0uxbP6HrdeSIiao3WJ6Esg8/cJuaeDVIpoqheRH5CL6eaiX4EB2Ns8X6gxotb7WKbAbTQaCT7xqyRhmDRPoIfMER8VJIuFEozvTVSRhxoovfvgT11VQJFot3y9oNGBR6TOUJBGEpgk7STg3jbDgE4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW3paC9H1IYX0q3lLV3xZuX9x0d36v8ax32Y+l2iIxI=;
 b=lfoslYKD7N0pBa2XtxBhZGYxDiYHfN+AEiRs2PluvJxnhbbqO/igZV9AH/Sp9ih2YAl7Wwbiu3f2w5ssPirL7biV6o3RZ9uP/Nfb568CRwJu9nwcOsDGFLTFuTbFFGgvC/fwQ4n4bRhiQ56QUfx0QlpadTepIBogHd5i1chjVSXPyEFYKOvq03BobTI4+7NPoeGDnFCHm7TaRLLKX/CJ9NR686CR9UIa51dqtBFWXvNDXJSmu2Nyl9VyfDt/GzLgGtPLy7IwsXisyMPFIP6Ei7HiiveGpa81hcRnSyTO78PWBBc6hx/dNrux+XUg/CvU7YJ/icHgN4mW3qCqoYrujA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 09:13:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:13:06 +0000
Message-ID: <cf44e61a-f46a-43c3-ad2e-10efe82f2bcd@siemens.com>
Date: Thu, 2 Jul 2026 11:13:02 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: CIP downloads not available
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ba836a-946f-4baf-6b31-08ded81a1f5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	vDEw+tc2Q/qxWtORK9aLIWwTH7q/MP20lv15gsXzQ/fqd7eNWWgMyYzWb+bbWx/U+mQoNO15z3Gwfl5Ks9wfNsVVgyUghvGQMQQXLZf6L4ddM+mZoWpkXtCvyZIyKAWq33TMjSZunMZzru3rtDdjpRniof1Vl9F1b7z9WVL/zy4wzYpB9AEyez+86zoGdgY5Q8ezT4kjDYUXabmfLMTnKzDByC9aiDUKlhWePORy8cz5JGNN8AXXyR65BQwSIGfbg2X0zaGqQti+q7LetLlRvfIMeZKNNjiuWzMdEqfXiU5Kp6ybQ653isFLnTTSsMwEeFI52HeCC25EBv3BiiGAHULmRtJeEyRndkDhg4/lax4tlNDMIlZPqr8Ca8Bvd4DHoq9eHNrk1zxrqXkj1sktnrz9PyTUTbzVstz0192aHbQvk2s5J/GZFEN+bam1rdAvloBMXV0cS1JULTsRB7Vbh4cprowTUk4c5e+t1ndmlIz9KExzvdg/Qkb+Xmm7CzqGXwTAD5FgESrOjGrx9UtTopnD9Xhbg/9DNLCGuAIFEvvRcv1JE3+BC+efSfQDdmNlyoK1P31d15BjCX/OalkTA8WavEbTP3wo106t1n52rS3TCxux/24upz09thkWkZgWc69az1OxeTzs5oZJLiXwrHhg6HdNcq92tT5Ai9/FZD8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWIxMUlnazN3YmNyRVVDck9WL2JORmtuTFVGZTNkVzZ5VkxOVGxzRlNhaFBP?=
 =?utf-8?B?cTZqWVJraTBoWDZYQ2NIT0drQTZVY01XYWhxVTR1dCtKZ28rYmVXckpKUklX?=
 =?utf-8?B?aTNsdTB0WmVmdkdGa1JVeWRBUzlCTzJ5enRvNHV0bEh6WTU2SkwwZGVsSmw2?=
 =?utf-8?B?cW1yS3JNdGc1R2dYaUZRNTlpQ3N6eVdoN3RoRFVBSlRwL0NGcEhoWGNPWFNa?=
 =?utf-8?B?OG9LU0lFbFExMGs1dmZ6R29NaGRBUTJLT3lIT2xudGJSYVVCbUdwaGZ3UXNI?=
 =?utf-8?B?aHIyMEEyR1p1MExZcmJVaUtXYXROYndpYWdSOGNHcW03L2ZtUFB1V2RtTFlW?=
 =?utf-8?B?WFBTYllSakwybkd6d3RnQTBUL2V3RGpmdk14cTFWK3huaDhwUE4zdzk5NENx?=
 =?utf-8?B?SzQ5R2piU0pKcTBVWUNSQWl4T0J1ckFtSEswWGRVdDlCUkZFelB2RGpOcElJ?=
 =?utf-8?B?eldpVmhTa0Y4bTFBN1Y1WlNENVYvM3hjWHdFU3krM0pYUGNDSFZoU2kzZXV2?=
 =?utf-8?B?NEk2aHBhY3JWdncxbWEwWVY2RHNyalUvTDQ2cTh1NFd5TmtCci96NUYrUm0x?=
 =?utf-8?B?V24zSFl4VXlWK2hJbnQ0VER5TUtrekNrU2pYcXFZc1dHUG1pa2FEbHA3ZTBl?=
 =?utf-8?B?VUprN3VkMXdqNHk3TXVURnh2QkNpWlNWYnBpVzlqMWZlVG1iVStaeWxRNGJ5?=
 =?utf-8?B?ZXVwSi9xS2ozV0FvRXk1RnBJN2ZJSG5lck5NcXZQSUwrRjBXQVdaR0N6SW1H?=
 =?utf-8?B?NENDN2tUN3dDb0RmcktHUHRvLzJFSmFuZVVIK3BXT0FiOTlicWVHdWhIdjlE?=
 =?utf-8?B?U2czZG9CeC9ZUHhjdEVqclRTVEEzTWtoek82MGJaM2h4cG9TeE5tTEh6cTA4?=
 =?utf-8?B?THo2WHd0cENVNURydWhyOVprcG5ZTTBibFlGS21wSW9KWlJtN0hzOWVYVCtO?=
 =?utf-8?B?czYxTlhuUFRqTnhxcFZlV1RvY2FhZG85OWovRXNOMHlQYXY1NWxSQVpzU1FK?=
 =?utf-8?B?M2dIOG1PSVdZZ2NWeUlMbGlHeDVuaVZKVktOUlQzOHlxVXpIbU8xemEyZ0Uy?=
 =?utf-8?B?RDNiczRtc2NteG1kbkFBcHJMTnk3SFhGYW5LV2I3QXZrcEU2Vm1LNDExQzRX?=
 =?utf-8?B?R1A3V1ZHcXovWmNDMjYzbDRqQkxYU1ZqUlAxbklBRzNhM1NoVmhPUW10eTdR?=
 =?utf-8?B?WWlhZi9iTmlqQlg0V2pUdU1pZHZvQnNUdXlGZTEyaHRSMkJMYjlPRFF5dzhz?=
 =?utf-8?B?Yi9XSmhXMzBCOFhoT0VWREpLWnpXTk82MVZPYlpKVTFKSEYzQlFtcUFCQ0Fo?=
 =?utf-8?B?T2ZqZ051TGYyMzN0N0ZKa1ZUS2lzS0FEVUhCTHo3dmFjK2Y0SzdxUDhNeklF?=
 =?utf-8?B?czRBZG9IWEM2V2FtSHBSNzBDellacHdIOS9UQk5ibkV3eEErN29lQjl1NFNN?=
 =?utf-8?B?SUNzMjM1eVVHQUpYTWtpUnZDcmdINURvYzlNUFFWaDF0MGZCY0s4MERjVTdJ?=
 =?utf-8?B?Wjd4M2NBY0I5RG1JTWxFWTRYMFpyZ0J6akJmTkJDVzhybDdta3M1eDVvZzBO?=
 =?utf-8?B?NytLR0UvRFN0eUpUd0huYi9nOHc5OXJKcmVKSDNOcWJBVmNIakIxT2R2eTBq?=
 =?utf-8?B?cTJPSitLemx2MTArOHhxdjBndnNpODladUtTWUluNWZOY3Z0TGFvUjIyblpt?=
 =?utf-8?B?bkQ2bkRnZkxTdE52ZGl3bXBKeUNwNU1JV3lWQUNOTkNEZVg3Ni91WDVpaU9J?=
 =?utf-8?B?RzJ4bVRiUURsZzBpZXZLL3gwaDlTWVZvQ09CSU53bWxZekp1TUIyamdKalc1?=
 =?utf-8?B?ODlWRHhuaExDQ0h1S0RZTUhvbG16U3U2aG5JQThlSGQ5OTVNVEJONkJUVDJr?=
 =?utf-8?B?WldiUnc2ak9MM3F5b2t6VU1KOWprS2IvYVkvQlRrWjdqYlZSMXo2c0JpTEJV?=
 =?utf-8?B?bm5BRmR1NFloNFlRSmN0d20rcVR2MUxvNy9ZbnE4YmJZU01vOUcxZlNtUnR2?=
 =?utf-8?B?M2lVRUV2RUsxZnFmOHRKSVRnalBQWG9vdWNLaVp4aG5VdjVoWEtYb3NSd1JZ?=
 =?utf-8?B?QTcveUZEQXB4QnlFWE9OQ0RxcVFuZUphT1lTNnVScHNDSXFHMTZBTlJtVjlT?=
 =?utf-8?B?MmhYOWVQZG5CN1ZDODIzb3FTSTllM3d6ekM1NjVWeGtoM2JqcGU2Q3BmZkhw?=
 =?utf-8?B?MWExcE1MZnJydmJyeXpMT2pvME9tS1pHSmZvVGZmTldZS0ZJbEljUUJ6bDJw?=
 =?utf-8?B?MTZpSXF3MWJIb3hQejJZUWFBUW1jRWhRdFo1OXZYaUk0U2VTWS9wZHovaFZx?=
 =?utf-8?B?aVFzUm4yUWMyYVJ3d0E3WDlkQ21Teld4UmxWbjczSlJpM3JGOTF1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ba836a-946f-4baf-6b31-08ded81a1f5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:13:05.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABdbM3NVWRD5C2i0yTtaiVxyJjzgj6hs0/EOvJfdRtfhD7Rhx9AxPBYASTa8Mksm8EibPUZmXXaGc8bhOGTU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7173
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 09:13:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23377

Hi all,

https://cdn.kernel.org/pub/linux/kernel/projects/cip/ -> 404

We are getting complaints that download links are not working, and it
seems that our as well as other's content is gone right now. Known
issue? Has anyone heard more about that?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

