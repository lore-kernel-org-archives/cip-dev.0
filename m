Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935EC4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:42:32 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.73])
 by mx.groups.io with SMTP id smtpd.web11.4775.1702287744004224520
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:42:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vgkvuTzJ;
 spf=pass (domain: siemens.com, ip: 40.107.249.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqTW8CQu3NWoswog94kmRKPo7Em2iwx6kr+WCitQIh+OdYqCRPGlObYUskEe3EEI2/aJ8H5ArK2SxvedzjtbFWzyvNnKVj1D6oyIvw64O0Z9L8uYkJgUjzINp61aI+W6+9vqcaGSKi9aHxFv94+ixq3pmltWa8gBiqZmGs+o6MlfnBuHx+SGWkXYOaypvpaKlnwJyMzl3LIbL0nohwT86lNRfD/+V1G5DRmdpYg0ntEXFEciDk+o2e7TlDmqY/fdYwIZsagk31devbn88M4+CYa+7O5su1A9bZxDs5xHRnRpW52IP/hT5bSM+W9j1TNmpZux3Am7xjlUJ+QKGW5C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ng4RNrZLYMlMenDsYVtWr/oZjY6dB5WzuPU+v5jdwQ=;
 b=XArN3k+zeu4LMCPoMPORlSe52V9SXtoGUDc1eT5IYWE0fhAOyMg9OcH0P2j/+/OQwOddocWCpXjADYR/jJoi4HbAyXpbAlThkdKU86NYDTO1C9zI75sP2heZXnPSt+DyVJuyEEAidIhSfjgIQU3BwRQ3zKiXNJKepfQrDFesLHtwoHPEv+97LEk7c4t/P71b3nZcwrnbg5v0kYvTqoY8hy4dm0DqZLjljvzIpqkdkG2c/VG7HPlqNNW/ZL66OyybQdjZ4ZoOCQsmS7QpXSoAsGk/PYCYNKlg92YvDmYGuJJRvRBE6p4bVRxAuwZ24LmMoGzz5Euk9NLGo4wJ+ctkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ng4RNrZLYMlMenDsYVtWr/oZjY6dB5WzuPU+v5jdwQ=;
 b=vgkvuTzJk0pmknPFFw99xIa5Cuu7Yjvu86i4/CyJ8ebxTRvI+BxaAMZWb6ZB9N423L6AhNUi8Zo/9lUMcDWDOvXSIAXfI8P0WFHHdLyrPY9T/5fZHKbrlbClrdY5u5GJQ2yXBmZ3VWsn50ElsxlHLs6QKSyZD7TH0V0DjvSMGo8jdTZ+eLwUQl1iEChm9BLeyFLZAEu+uD6MH2nivhjxEzNweHygVfO6CFyx5nhhE5+aHAF2RbOUlq9u/mSKLN1Vu+Jsd+Sf3Vk46Nsg5LsLmXq6LKoDhpQSSPbkWkNXiBZJ944AszAB5fCQsPwOQNzP3TTw/31CmUpUfDfn2SCnKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:42:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:42:21 +0000
Message-ID: <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
Date: Mon, 11 Dec 2023 10:42:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Potential ext4 corruption in 6.1.64-cip10
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
 <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d167894-2fd2-412d-5998-08dbfa2d78f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2vw4VUpk/08q1oV0FTp5YFDahpFQL2R0FDHHp9qHMR6OOSyn7IpyuCOATs8aTwtchENGB3fWuNYoOCpeX9R4g2sYYP2u1iSj5BJ+R7DXzf8wgxXO6fpvNyvHzLp2V1BreI6igjDvZHdjw1GjaRJNmojP0XRuOF5APazWQgx+4xvozZ3Oub5NJABbXgka8BJ3Nh+49eZno8RSaoIkk79RAr85+wGy3d6o55dJ2CETNCYb+bzT/1aa60WYdSPvG888stOGcJ+DKR3wsi/Ier7kvFVNu3D92rMTnMqwS0NCJ47OpS+sHxuL6KX9xWc4lIWUlAaAvkWINf9wNfPKk/uyeZ75q9g8Bl5J/bsvl4Uq9eL0f1PSaaTV6yYZrV4Vm/w9/a+eq0c4UkC4sYrYuyKArLCm62ylF9UsfKeiwSGhNyX4038gYMmf9hpKzfdQBDAQ2Efwc5yP9px8MX+3gsXEajNIoVd5PEo5sHUE/TlFr9HQSKDKSNV4iRrrgRWnN1H4UldwJ/d5Ir+i3xWy7iLEu22cBUnbr9wvxJEyUre70vjxdyCdqxq9ddZAMGjHnNkJErGj9scSZQd4xAdC9Z8cH6QCSNixkbY7YOA/KXxGhm/d0DT1+H62UiH2LDqfk3H695ZeV7w+p8c3rB5VHbcQiw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(2616005)(26005)(6486002)(53546011)(478600001)(6506007)(966005)(83380400001)(4744005)(5660300002)(44832011)(41300700001)(2906002)(6916009)(54906003)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWZFYkE3dFlLZ1ZLT3pTYnpzNzh1SG9WYXdZbThKdHZZdzNwbGs3S0JTbFFL?=
 =?utf-8?B?YTJROXJETzQ0NEM4a0RsMzVMVkxmYi9idVBXQXBkOStLdERWLzUwcTlZODM5?=
 =?utf-8?B?OEhQSEYrSnNDQmR1ZzhhTXBjR2dqKzFIMi9QS2Y2Z29kSnptbUVUWktFTmNa?=
 =?utf-8?B?anN3NHkrWFo1UTV1dlhJNEIwVE1ZYzdlWnFPVkNWVXZlRy84UTRveUtOamhG?=
 =?utf-8?B?ajRnL1lsdEs5ejhXVTVQaU9vV0hUNWtaMnAzZHVEMndBaEFHeEgvejFCQWF3?=
 =?utf-8?B?ekI0OFNaanc5SngzQjBPUHp2TUhQNXZoZHN5QjVtWnFRc1V6ZkU0bVJwMHpI?=
 =?utf-8?B?VENzWTU1TzRzNXUxcGx5Z0JMTmlrWjZ6YlUyd00wWVRCU3Y5US8rRXFGMFZs?=
 =?utf-8?B?c1YzRlhxc0xSTzRFUUZHSTdabVhuN1JhSWUzTTlHZkxzeGJXR1RJTS9vNHdT?=
 =?utf-8?B?N2l5UEJYU2lwTWdHT1Z5T0F0bHd4K2RPQmNpekptVEtHYXBhWUVBTG83eEd3?=
 =?utf-8?B?aUwxRnpMYXI4RlpTZ0k4dEhtcTZsRVVqd2VNL3pQekx1Zi9Pd092UDVSRU96?=
 =?utf-8?B?S1g5VGNiQWFRUnhWWDF6RmhObkVIVzk5U2VIQXRMZXkyWnBveTlIaTNlOVk0?=
 =?utf-8?B?M3ZTZ3RGNVJnN0xoeDB5QWowMVc2S1JpT2JLb2JKOGpXV1dlbm9EaDRJeW96?=
 =?utf-8?B?NWp0MVczTGV4d3lXak9ZZ2hQdjJWQUFYWUV5eXlFenlYd0ZHdnp2TnMyUEhM?=
 =?utf-8?B?ZEFkeTM0Q0F0QXBvVGpkcS9nV1I5VkRIS3dkVTJDZUZoMHN0WnB1cHdaancy?=
 =?utf-8?B?STQ2T1EwZ1lmTm9uN0FqZE5DSWRwWE41cjNnRk5TZDhQQ1BKWkQwL3JpelF0?=
 =?utf-8?B?OFZ1dGVaQS9oSXd1Q0JXWTJoYjcyZW9Yem1RWFNWcS8zTk8rSVhDaklUclpy?=
 =?utf-8?B?R3lkU0pYUnh0SW01QUlNcXlpVS9oYUlxQjFmaUxOU2dLQTRkak5GTERrTnpk?=
 =?utf-8?B?VitEajM1N1pVQ2NoN0VqZWwvc0VyblYrSVVtMCtYMVYzQW9tOFBNOGxMWFh5?=
 =?utf-8?B?QjN4M29HTjVBbVMrd0NMdU9TSElwY0NuQzIrM3k1bzJESTMra0pZY3lFc3dJ?=
 =?utf-8?B?T1I1REgxZS9aNG9IM2NNR28vRjVJbmUwVUdWOHdsN0NrL0d1OGpBRzREVDV2?=
 =?utf-8?B?MGFZTnRZUkVSY0FUTlYxWkZzSThvMVRXNUMvWm5qTUgwL29QTGFKZzc5U2RM?=
 =?utf-8?B?MnFTSHIwT3Z0SlhYUkVNWmFPdWlvTURnajUxUzkxRFdheTBIblkwS3ErRU8y?=
 =?utf-8?B?V2lueXdxbWVSa2JkYm1OR3piS2IwWGNTL3dHOXR6amxoUnlMVnRyOGtheXhL?=
 =?utf-8?B?SEU4NHlTQ0Y3TDZLVm9ETHdKQnNsZlMrbVhzMGVNL2ZLS1VyQ0NTaDUyV1dn?=
 =?utf-8?B?ZU9zcGk4bm0xSk5yVXNCNUtKM083Q09lN29hK0MxWERmM2s2emdFZ202am9m?=
 =?utf-8?B?YVcrVWl4VVhJdTQxVGZWYzFrVEpPV0QxV2dKekUxQ3kwcnB2TGhCaVk0WnRi?=
 =?utf-8?B?TzhGdysra3B3ZmxwamUxQWxEM3IxUUZ2MGJZRmRtd2krMmNVVmFpekxLbW5t?=
 =?utf-8?B?Ykx0cXVoWFBRY3BaUlkrSUFORk93a0JnNzZHcmxNUzFrOGNrNU0xY1NCSDVr?=
 =?utf-8?B?R084TEgwcm43djltTEc0Uy9pcFBiZ1lzdDRscDZoV2RQQk1CQkxwd0t2MGxo?=
 =?utf-8?B?TWZDZEFrMncyVURGTHlUOWN4RXhUSUp3bVNTYmkwWFU4ZzRtcjMzWVhFOFBS?=
 =?utf-8?B?UzFOM0VlTTdIN2hpS3dYRnNkVCtGT0pqbjhXWTl3MUxLSWZIOXEzZ2FHTm9z?=
 =?utf-8?B?NUJZdk1NWllLQWZxOXhsMWlYd1cvMHR5TGVvRTBhK204cktqeE1EcWh6dHA5?=
 =?utf-8?B?N2xPaTY4N3JDbW1YMHlhd3FzUGh0LzRSNkEyMnNLbFBQUWtXUnd2NU9va2xt?=
 =?utf-8?B?eHNDNDdCZjR1ZGRxdzUwZWE2OG1tVDkwSkR5NE0vakMzM3IyNjV1WVF2MG5R?=
 =?utf-8?B?RGRMNU5Xc2dpSG1nVm5SNlExZyt5QUthOWNDVFlRN1c4eHN2UHI0dCtKL0Vr?=
 =?utf-8?B?OFRURjdCbWpRT3hIdW05eUttQThWVDBqVkZ3MmtGbjljQUFOa1VCS0JlR2dE?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d167894-2fd2-412d-5998-08dbfa2d78f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:42:21.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pi8m2ix3iGYE8wwVWz3G7g8bQjMl/Fp73ATGPWHPRuzQZl/uzTEYWLW/Q7EAtOQ8P1Gxn9lTfh6kVdO09i1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:42:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14001

On 11.12.23 10:36, Pavel Machek wrote:
> Hi!
> 
>> seems also our 6.1 CIP kernel is affected by [1]. Please do not use in
>> production if you have an ext4 filesystem!
> 
> This seems to affect O_SYNC / O_DIRECT users, so I'm not sure how
> common problem that is.

Well, Debian considered it grave:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1057843

> 
> 6.1.66 is out, and there's matching 6.1.66-rt. I can release one or
> both, but I don't see any confirmation that it is fixed in .66 or how.
> 

I would expect some reference to this commit in 6.1.y as well, but there
is nothing yet, no commit after dc4542861ec8dde92c3c8a5139bc412860aebe60
touching that file.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


