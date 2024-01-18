Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A25BC47077
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 08:02:03 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.57])
 by mx.groups.io with SMTP id smtpd.web11.6603.1705564919026230366
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 00:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lKE/a0YI;
 spf=pass (domain: siemens.com, ip: 40.107.6.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVyo7BzX+dtoAq9EEjCZI5Qeyj1BiF/ztQmUZXUQ0tUW6o5n2SomT3PF+7ak6T5Dd4z46n3ngMU6Sk/f2uYABfxuAVvNo67TGp2SPuxvP3r8+FLgqMd0W1Z8pKYY3Ui05DWIm2TzU1i9cwYoTw7QNtlmiw5qIqVtnvYgDwsdV3Arh8nNCU4bZlfDSH1yVN7zNP8xE97a8T1JaZCFiCQq5ip7AvR37om6BTwXnMmxMc6cCw6wM7kyfudg3Necoon6kDbs91dMp5TRVO9dk2+1hNIaMOhRBOe1VvSKEm3g2+6morRQLUVFspSeSsit46CcPIvABcoxxJqOQMUE05DJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIA2X0HYvdNgCV7QvgSbYo1Wgw0myR8C5/+T1e1fvwI=;
 b=aU0fxEzE23UMOylfrBEQEXfKxPAIyuLT8ezf8uYWMWT7HP2GMGi44+cZmFwzSI07lY5ubWLaOsLkyQhuxXSMWMlZ9l2bdbecUOoGuRV/PPDogJI8J+ZPCJwSXMWdrRSyorvLpId6TTG4j9KBygreGbCfk4+KkVrV3UF5k+T3zUmYF/lSnJvNmFR+JCAgqPiVMKzcvoe0zuLcfL/Lhw6PY01UmgO93hbxJKIJw2RT6hgwkLhkmk4u+fMTWwMFTDf5MlkKxXcLxsoivPXzqlac5FBGihapXC2K35KA//LtpvsPytlcdgIUbM2EGfQpjElglMq+/hza73NqrQ5iMv8fBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIA2X0HYvdNgCV7QvgSbYo1Wgw0myR8C5/+T1e1fvwI=;
 b=lKE/a0YI+eCRk9WlFCsrs3ykr10xtoVhPbCDmvfmsxfg0hGROgNLPk56vDADa46dZCc78+52p6HijfNxqSZdrRrvEzGfrUa+vJWuQQ1k7rA37dkY57J4W70bxNiUjAhwSg0DZlUF50H1b3a5ezzRsgjHvdUHNGTb7JZ+qnA73EP7BUGIl2ZVXx0eEaDagxLpkGS5FSkhibigc0Jv04l2NmN2uCTYQmHbuXHpWrcK8Yr79s1c+tFjRpz+g49MlpG09eI8kGRuTcZvKm14AE5EPteOPklvEGccbuZ3Lo3evJcywqOBpnpGWffDjY0DqtOHsbKwTLs2+ihg+rh8zOXbHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:01:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 08:01:55 +0000
Message-ID: <c7852f34-8a1c-4a35-bafe-a859eb5ce91f@siemens.com>
Date: Thu, 18 Jan 2024 09:01:53 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 288d9f26-a972-4b26-ac85-08dc17fbbceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c8jfssSn9euS9eExIBsmHtl4ZiUhOiJSBE0/HMRANxWBp0yVpaD4dg9Rq4Rc5iGMdL1zNvesOR8NvimhFW4TRuXGUIuS3L2wPcVXW1aMcJoPqLszRSLI+/B3iFJkIkAnTMfHLqDa1AO5uBaLY8WuHTctNZo/fpxc4+JvT7ejtsQ0q0u2eYHC6vrJcE8FPkMMA+kbesToDYORgs6pxh3Dn6kIHdilyOzXL2Dt9b3pSWOlS5iOhwcCqRNybWBB/EWWR16oBxDEFqsfiFA4TXGutpU6QE36lUkNWVt2feZ0DFwmjaEtotlnw3+OplbCPB/xzpkCvW9Gs4LtnjKYCvwDEIhlVw/u7G9MxC/KivQvplHUpnM8DBzgPtAXbXGQSIvaQAF1yMiHmj0i5ooYrPIW0wmbjpj6MPEJrb8e8iLh56EdYj9uNFT0cC/4u2u+YKLE2rEKA59jAucHI3jiZgMOXzRwWXZRFDhpzqkQnH7JXuICR1Iucs0I30mXRaZ2nBWe/KQKA+Azk1N7xN639uB08Y3TAuYerTLcKRM2vkv3BOB9kqQ5qdFs/QiKN4jo2Y6Wh/mwOQ5q0wkGUTWihs2ts8KUSZf9dyYH6xuttzkr+fVwqs4M0Wn7xOGnE2aIHL1AD8QEWX8f4fDs/TJhlyNkQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4744005)(2906002)(5660300002)(41300700001)(38100700002)(31696002)(86362001)(82960400001)(478600001)(6486002)(966005)(36756003)(83380400001)(6506007)(6512007)(26005)(2616005)(6916009)(316002)(8936002)(8676002)(44832011)(66946007)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1Y1Tko2all0dnowb2JXcFNpVXQwOXVnQTU4VTVlb3VDdmpyWmlpbndrVXQ1?=
 =?utf-8?B?WkpvZnQrQTFwV3huRVgrbTN3RVV4cUN4cmh0QzYzTW1yMHNwYkVsNk9xQmRJ?=
 =?utf-8?B?b1R2Sit1L0ZMTmZYdzcrTTNTc0JoSTBkMEEycW1SSmluZFRBTGlUd0VrMG5F?=
 =?utf-8?B?UjFXNlNya0VZYnE1ZWo0SlRVWHFyVWc4MHhWR2NwT2c2bi9hT0pUUEhpOGVM?=
 =?utf-8?B?WkpXc21EMUtGNEduekJMVlB6SmhFQWwxVTUxYVAwZGZCcE1YTGpTU05HcVND?=
 =?utf-8?B?eUFFK3JDRVFBV21zOXF6OFByMzM1eHF1Mk1keDNxODNORVpUYmJnTVN2blJF?=
 =?utf-8?B?ajJXM3ROb3FHd2RxbTlYQmVHRjZ6eHhKYjZOR2g4dXYzZTJRNHhBY0lhZFhz?=
 =?utf-8?B?NlBNRC92N0xEeStKMDNoTFM1Qm42VUR2c3cwTXZMbWNaT09WM1lSUkYwYzRE?=
 =?utf-8?B?L0hCcGJQWnhzTmtycVIxZ3pEMzJkSXR5ZWExOURaN0dkOXdWVGg5Mk9MK3U0?=
 =?utf-8?B?d3ZFK3l4YXdFTXV1QldIbkJvYzRhdUQyc1dBYitpU2ViNDlURHRpNDREODBO?=
 =?utf-8?B?Wlo3Yks1ZHphaWc1M2ZpV24zN2tvRjNnZUREZUgya09IM3MyWCtMQXpZbUw5?=
 =?utf-8?B?K2hST2Y5NlRWYjJsUUNZL0QydmxjS3RVWjJCdlA2K1hZd3RZcWRTcE9Ud2s5?=
 =?utf-8?B?UEF1eU1tYkljTlhId2w3TVUxYmFDZmhnWnpVNmtXeGJCUXd4V2JXWm4vZkNW?=
 =?utf-8?B?WEJrMVcrKzdFa0tuM2JrbUNsVGNCZ29QSTNQZjZTVUx5UXJhbG0vYy9rM1I0?=
 =?utf-8?B?djRmTFErbSt5ZTJ0dGRMdWREMG9uRVBBQ01Xa1lQamd6U3ZXZitHK1NYQ2ZY?=
 =?utf-8?B?VHprV01aTXY1eVJ4NU44c1Jaeks1QWRLS3VEbmJYektnLzNzeEFCeWtXeE1E?=
 =?utf-8?B?RUJtVHBnTFkvbXRUWE5waHNBa0xtWm8yUDQ3dHJzYTRFRHhnNkxrU3MyblV0?=
 =?utf-8?B?RWliOU4zOStnb1JEK3J6TlNPODhZamhuTUhnN0hKcmFqUlpaaFJ3ZmxQWTlK?=
 =?utf-8?B?MERZUHIxMWNra3ZsOStOc2NUc0g4Z3J4cnloUWw1UjBUZ3NYUCsxdjByd3I2?=
 =?utf-8?B?UnBHQkxRRlZQTUJNRFc1cjY0S2ppdlU4UFl2TlFyZ05JNXVXWGlRZDQ1UWRJ?=
 =?utf-8?B?cm9FT1ZoZGFna2JOSzIzTEY2V2djRmU3bXdCWFpwMm9QOUhPRVJ5ZXZqdWRw?=
 =?utf-8?B?aVZ5bS9naEpBQ1BJdm9acWtwcDkxVVEzNU9VcDdjV0lENDFRMy9BNTNHWGxU?=
 =?utf-8?B?L2VSKy9RZFNVZDVOVjVjb3lPT1dZblByRkpxRmwrL2VRcm1MTGdvNkI1di9W?=
 =?utf-8?B?THpsWWdkcUl1cTIvUVo5N0pEcG4zR3BsUGtKMXVDMmRLQ2Z2R0tXTzh5RXJO?=
 =?utf-8?B?ZkV4WjQzVDdkSGxsWHpWNjlUV0xpZkpRTm9YaWl0Y0JuKzFiT2QxTEpzdnF4?=
 =?utf-8?B?TWpVeStCNHdyOWZwcE00V0d0aVQzZ2M4N3BHdmpYczhuQlZPU2sxaDFMeTgr?=
 =?utf-8?B?dzF3Y0dxV09ULytpd0lXdUsxVFFETjVvLzlaaDl1dkdiVEVYS2UxVzZtRTNq?=
 =?utf-8?B?ZUErQWpaVXlDTlI5RG1RbVN1bFNGZk9OQWRMNWNKQlB5bjRlRkJJVUpsNGxa?=
 =?utf-8?B?Ym9zQ1QrWHVQZzBhTWtXWXVCYXF5YU9WZ1VTeGJqU3NCUG9WUS85Q3BnUjRl?=
 =?utf-8?B?THcwU0phcjdMOTY4Szh2b0tiOUlld1dmaGhrdERQRG1JQkEwN3J3c01wajhm?=
 =?utf-8?B?YVREc0FaSlVieElXMzN1b1g5UjVnRDgvWTdPaEF2R1NQRHBvWm1VTXBMOEQz?=
 =?utf-8?B?MjRXU24wT1ZEa2paV05HTVV1YWNOREl3SnlaVWFMeTlSK0h5YnN3bXhMcTJO?=
 =?utf-8?B?S1YxU1hNNnd6VUdML1VCQXpRYnpZaEVGT2plN3Z6QmMvRERZb2JpOGdiZjY3?=
 =?utf-8?B?S0RoVlhMc0JiMUtVV2FHN0xxdm0zeThBbXRSMW5WdWd2bHI1c0Fwd0V2THRj?=
 =?utf-8?B?eUZuZ0hHczczcGlpU1VKR0NwYVozN3c3SE1yRitMWTNuSE9MNGVaY0puSklK?=
 =?utf-8?B?eXpOb0YwbU5wam9Mb05kU1JtWG1lZDU3RjRWMmpHYW9RZ0lMdDJtWHJLcmQy?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d9f26-a972-4b26-ac85-08dc17fbbceb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 08:01:55.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEtkr7cNpHYEuJ7J19aiFnZNnDxhT53mBqbZ2LNLLHverc5O472l13WoWOJdhiDAJu9KJJVj0melLi9Af5sWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8128
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 08:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14399

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=1&day=18&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/01/cip.2024-01-11-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

