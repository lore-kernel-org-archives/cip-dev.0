Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B4C982F1
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 07:36:18 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4800.1790062575234814861
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 00:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ciYTRYJK;
 spf=pass (domain: siemens.com, ip: 52.101.70.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1u5cWmWMW/avcLkH7HWt6tjevPu3t8cqDummeshvna4sYN417yxpw7JqN07KooZm9Lt4hdhl7H8s7n8bEsZgicMWrMYwnWGV8qu5ppgM6NWceurNzb9QZ3sMprsho49HAkczcZ7ms/Gga0cfn3p3MHGhA5w1TqUBA0AEd3pXEfQMxauEh0rLPMVqOvQ+DAOaS4irgtVOInf6aSvKleQ6rLpuMpvGOyOVZPUeG7a+GWqMJjOidNpkIHDrBf2dmGc1XhxlQnvUfVcV4ihFEn1TKDgxjE37zrB9NJ44nZqTPa/iHwNDDC1C+vaHmZNL9WSlgM8gaKRYp3SzE6a/E+jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cMEUV18T8JOmZMXRPVHShgmo2KYKSyJnCGKra3+2SQ=;
 b=XsfJZrMEHzwjbxkbahyYGtdzqUwx1HK11urvM6EL9Pju4rZrdu3h79JUlvtf2NeijylOC5BjlUVJl5z151XVbAbI5YDrE+KslBBy71lg6WTvfQ37To6LJif/wQLmNt5DltFuhyWYuYnoYR3Vk0Jb7rk/k/t6NxBZ7vER0i/046/F/P1YxTXY1ngtlT/gf+lfWHxDITAR+8JIVldraO4uzeduH9GCpuTA9Gzyr850fA2Uq3m2Wr+aGHatc3P/dr64ZXvPmE7YaZ6196roqWvK7OikAqRnrLglfaKuTf/BkR0AKcfGZNSVn0xOG6xfNYSXNj+4G0amy90s1WxcMW7K8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cMEUV18T8JOmZMXRPVHShgmo2KYKSyJnCGKra3+2SQ=;
 b=ciYTRYJKQH1IGGTl2DzFPz1lzeKiYYQZOxlNQFNOyLFlYhOmrHY1qVHh4lE1lkdaCy4Xulc1MEgtJDR1GyCgLt/RcOZMY5zyysWH710++wBEU+ZPHpMwPhwI2gse0PUtE1PlBrsqB7u/h0ohWkiPm+T2uInL7aPQshwMsLluRpO9F3z55L4qcaNKMohk+wX3IyUg/O9dqCjDYdx3fXlITHwidwJaL5QY/y/mI8CiRLyeM9dc4M4/MjYf3RuOjw2YEfB13leVGh03wTb42NeMASG1UeyzUY27MImcpYc/yHfzYeU6bx2E9K99bs0wgjW/GhtrQjjPx8rOClpzZZXXTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 07:36:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 07:36:11 +0000
Message-ID: <391c9693-e07c-4b9a-b9cd-8adc0ce8584c@siemens.com>
Date: Tue, 22 Sep 2026 09:36:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core: roadmap for next release
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: a624f891-c10d-4821-069c-08df187c2c4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	QVxTPTSuXWX0TYw191VsTbosM1oxjOG3GFJp4eFR8gPZjyaJt8Y3QX5rIOJRmX20MIF3Pa2lezt+7+uHWvzu/0gAxzBbIt+uQ45BnL1oZS9RMbMAdxyEVOOHW6tPnUkHsBkrqu0jeBB5/tLBfUF9x4nwdYI82X/Bc+AKv7gxqGByAtcpwCcmVo+3TUxncfHid7Tf1CjDtbsRnJy1UCi8fFg29bcu6z3axnfKmiDx9pL5K9EaddQaAXfOOCrPlmN60ms6QKrdxTNJm55ZSOJAiLcmRrcQm9pPtJvJ5GT2uFJeHXK3obowEu9BVGKcnig46A/ZKV8KAuhpURgMt2BZbxdtnbX8uW73NsURP1Ngf8UD7nKtdce7xeqKKm45dbjuxWMH810sxf3GYLjiM56UP/zlky6Wrg5gSyDIQPXd6x+gRj5Z6MVmIxYYHK6WKSjz/hlJjkVF0uedVRl0KD0J8eI7MyD5vpfOdDSg5Ouar0EzsQtj2m7Iz9pxYS0py9Mp1yAcWK/zIztkyK6r6lWMdPkr67WiWucW8wXUaPAfWBko44yP9jGUpFJvxL5Y/W2MqLXaeJmhsxndKVQjtZrRkjmZIecEYH6rvA52yBorZiRJ2KrnjKZ5UO4W0LHdki5mXhrA5OiU6/kMAyupGksj8a+f1B39p/7STaKxOErOKEM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3lzYmRSODRNOENiMHRhVnRZSzlKenhTVEloSkZrL3JDN0ZHK0FZZ0tFOUM2?=
 =?utf-8?B?MFlja05wL1ZxZU5RTFJTSmFwVEFHR0lZeEdNZW1ITmxuNEYydkNuRW0xKzlL?=
 =?utf-8?B?djlSODB6eERlaU5ZOE1ZY05ZWGI4YVZCSk8rcjYvUkdYaUZZTk9nQkdndTBM?=
 =?utf-8?B?clNSYS9zckZPY0Q3MXBwNlBBSmFmMjNUeGFUMmgzWnJaa0IxTUpGNDFpZmly?=
 =?utf-8?B?K0VJa2ZKUW9lYlEvempaUGFPeXFNcUVwSWtxRDFnb0Q5NGt3c0wyTVRhb3c5?=
 =?utf-8?B?SWYrdzJDcGdnVFRWU09zcFFUZjM3MkFnZmV2RXlUUTROVThxOVY2RFUxUUkz?=
 =?utf-8?B?dW43d1FGN09JcEtlaWtMRGNVTk1WMi9VZ2Yzbi9nZm43L1NOZmtKZ0d4SVdZ?=
 =?utf-8?B?WGlybjZXQWZxNVVBc0FMOWFXSEpVWEVseDZPdUt0U3I1RjQ0VkE5MFM5ZHBF?=
 =?utf-8?B?VC8zSHVUTmR3UTBScVYxWjlkNlBHWGpGUlB1TFJma3h3RzdibUR2cVVUa1ZX?=
 =?utf-8?B?VkJPc2JRcHk5aEY4THRydkpDSFZzaGRHL0RNa0ZPWG1yRFhBeldZQWJ5dUE2?=
 =?utf-8?B?dU1TNGhteDN0dVY4WWw3WHFrck5yUDMyUG14ODNvNDZoUE96OHhqUzQ2UWFP?=
 =?utf-8?B?cGNZWlRucmlVSjVld21wNVpYSkY2dGRLYWlrZ0o4bXBtSGdGbkt3VWJPM2RW?=
 =?utf-8?B?Y2J3K1ZBeEJ1ckdPOURlTGdFck1aUk0xZ1YybHpEZzlSK1FaaEFncVd1bmNT?=
 =?utf-8?B?ZVZUVUpRSWRUMzVVV1M0VVg3b25lbnpQS0ZJRUdHd1JYbFFlQ2QwNHZDRnBp?=
 =?utf-8?B?YVVIWC9nN2JwVXRlVFJOV29EKzRSNHdPaGxwRHlOTWZ5N3BoY2UzbFozamVW?=
 =?utf-8?B?YzhGRCtMTXZIWHJQU3VTZXNjejhDMVFHQTJXM2NYd0hnN09PeWwvZ2FBZGcw?=
 =?utf-8?B?TmdJdlJOdDRXalpDUENiU01OcEpVR0NHdHNqNi9sWG9weFNCMjYyVHRhZU00?=
 =?utf-8?B?WXZYRkowbW00aWdPbytMV0xnTDJyOTdvRFNPb1c4WUJCSHREOFk3RUJjaFdI?=
 =?utf-8?B?QVpndmx4SEtnOE42UG04NWpLc0lpZmFBKzhMUVhCaHVZSG9MaEZBWXpWUHor?=
 =?utf-8?B?NEh1Q2RjelVsT0FsaUZ0WFd3SEZ3SWU1R1Vzdk9KY2JWeFhyV3EyQUVJMDVq?=
 =?utf-8?B?MGlhYmJNUVFrVjQ1d1pTQzFUdHF0MVIzOTJLU1d5NVBHNkE1R0RiKzduK1JJ?=
 =?utf-8?B?bmlOTTNLSi9GSXJMeUhHVCtnVWsyb2RQbUcxcWZIT3MvRjJVaUhnbVBRS1ho?=
 =?utf-8?B?Ym9HMUU2QndhQWJMY2RDa29xVEFmT2dYSmlYdHBmdFFOamhHOUZWUWJUZ1Rk?=
 =?utf-8?B?eTl4WmhRK3g4eEp2Snh1Yk5LRDg1QUxjVEJXTmFuQjdrS3U2ZlpPT2huOGRK?=
 =?utf-8?B?TVM0QlcrTzE0WjVUdEU0TmoraUpzZHVKdWJ5YW9TWmxCdUJ4VGtMK0xiODVT?=
 =?utf-8?B?MHZTRTRBalQreFRWdVJHd1hiNDdrOTEwQ1RXdzdBNHZjazNURGtRSlRndjg3?=
 =?utf-8?B?dXhtTFJPV01sZitxQ0UvTDdZQTdacStSTnpXUUw5NDJoOEF5MVh4RUZMS0Jo?=
 =?utf-8?B?aFE0QlVrK0FacWRPaFhtdk9MOEJ5eGFtMXRTMGZLUWZ6UmgrZVhrNkZtWkdH?=
 =?utf-8?B?Q0RrYVpsZ2IrQlgrVzM5eSt1bkYxWm5sZCtrVFJVZnhYNVBLYTR4S3RHbE8r?=
 =?utf-8?B?d0xOR2V2MFUzcnhoRTVWWGhjNzUzNHlKRXJoKzBWS2VnZ3hLV0FkNXJKdGNN?=
 =?utf-8?B?dFJod0NvcG5yemg0ODJBVFlDV3B4UmFKVk93bm0zVnczOUVVblZuUVdrNzRF?=
 =?utf-8?B?bmdGbExPMmlzVnFRdFV6bVFnOTllUEhVSlM0SXlFVW53OWNiT3VNQjJ2NWpj?=
 =?utf-8?B?bmw4dlFFd3BYTUx4VTBJUFNtbE5FMU5yUUhuTzhydUtHTFh0YUF0RkhIU0lM?=
 =?utf-8?B?Qzd4UlN3U1ZtNmxhcFhUOE9oNzBTWSs4Ky9tV0lCYTB1VjhZNWhVOHcxUTMw?=
 =?utf-8?B?MEV2Unc4TnpzYkJkbUVWNjVFN0YyOTFYcmV0QmxOMDVRcGNadURXczFhRjFS?=
 =?utf-8?B?cjZWY0Y2dktlekZQTUsvdUkxd1pyWEE3Q3VsN21WcURJNVZISnVWcFl4Si81?=
 =?utf-8?B?NU9EeDNaSzdmN0lFTXJuWlN3SmdEN1B0QmlnSTgwbC83Q0c2RWNMYW10OXAw?=
 =?utf-8?B?R0FoOWF1T2t5ZXRRT3ljd0d6Uk1ocVpPcXRqa0ZOM3BhdjRZaDVRcm5iWEE1?=
 =?utf-8?B?MElVRmFDQ2tkRTRHZEs4QkZhSGM4VEkzelhseUR1K3VZYnkyVXlmdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a624f891-c10d-4821-069c-08df187c2c4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:36:11.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twW+sEdluvpULbDfyvLfn6fEGpxSnWHGeNwlkWypzd1xZO8aW9LuoN2IIL73/7UwfzzOIONzsrWVz3gbc4OIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 07:36:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24260

Hi all,

in order to have a isar-cip-core release around our mini summit, I'm
planning to tag 1.13-rc1 end of this week, giving things a chance to be
finally tested over the next week.

We currently have a long-standing unmerged and sometimes still changing
next branch. This is due to the number and impact of changes in there,
regarding the privileged->rootless switch but also around fTPM
pre-integration and secure boot enrollment for arm and beyond. For the
latter, I was hoping to get more test feedback, but in the absence of
it, I will finally merge that to master this week (and tag it).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


