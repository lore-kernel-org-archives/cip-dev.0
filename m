Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE887C3DA7A
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 07:03:19 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.54])
 by mx.groups.io with SMTP id smtpd.web11.7682.1672902196679155653
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 23:03:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yKJdfYkz;
 spf=pass (domain: siemens.com, ip: 40.107.21.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLDSEIQihWYY4HxJuCSup0fKAIlzhr3FGU2R/QtEQYki5fPoAM9GxGOzT7ub7jk10T4x3tOs2sVbvPPqGbnGqFke4se4x5lCUHsqsS26uJ6mnJ/6Hx1yBiymBW+24by6MLLGtCb649slyj/Bi47PUEz/uEQTXuEUahhN6Yj7TPQzXA5NBMGJFQSKBQd656OrpFnT+oYGKZBWZEb2yeTJ317AAVMKumAyD5t35uqSIGSms7AeP+MjHXR4rILz0DdrZNGXSo/29Ihy561cqtmRKo6qISBJ0eG2d0A4b/9P2JRHdt5MMiUp10AR63XkfgSWmKSaT+qidgJpDvvZOfQDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EomvMcqz7ri2Lcszc8kz6JqHlpM4bw4wEy/qBO4aj0E=;
 b=BeTn7gUdCXyCYH40gWJbjLCta+yjREJoVk+5Wq/sEsRDse2KD7JETyDVUAc8h3HZ1Deo+R/l8zZc5LJDzoKQc1aNwN4yrPMgFwD/FNgJN9R3zbXkD6QyFQbsrgmYrDTIOmKh+Xj53ZjG4UYi/G96b5FSmQPjN0occI/F6Eknl5cEGnH7m2xKlyGZiyDZhYtDN6+T9vFCoIrgZbkbzt5gN5egv7gfgdXQ92pgIC9uHvWdgJSiI43ASSuMTrONEIqEQqzvFhND+OAzMFh5YJaYAibuDuSN5Ccd5tpnkA0CySToHkbiH3hV9n+GJDoXroUAFNTU6gbKxCBS6GH8wRSKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EomvMcqz7ri2Lcszc8kz6JqHlpM4bw4wEy/qBO4aj0E=;
 b=yKJdfYkzoRLYwbIa+Tguoyfs8DLASixCQoWbQnwVxZvcHuIedPWyM0/jthQVVzyXDy1p/wDMiNU1roCZse0iwvkPwdpWZqUEkDvqBJy8wPq7SYZhJEteHbU88g6nuyIjqnH1AinxFsUg1hEFzYpNV+2JRnNupccTeT6m8EnrTDbcoFqavLlhDUMkJ3Elik0MnZHq4P/7kd8zMV4lDhjUfeMT769taBQOfaQyFf2G8oFeogZ32GWt+P81P45eabPA5upLqwB91xJoaBele4ohVgVm+7z+1oFw1bcV4D2qoGIPs8m5PNWu8kUyqVcFBO+gGU1rWk3fqy91+5G/PGUDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 07:03:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 07:03:12 +0000
Message-ID: <a599db4f-8df5-3021-b610-3442d6059b01@siemens.com>
Date: Thu, 5 Jan 2023 08:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb61565-2010-48a1-7bda-08daeeeae90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H3yj1u9JC7xxSKO5iePPmv1zmDbq4HFOH0cam9iLR5NNufetstzJqSq8FBB1MqCEZx+5jHVDyfqAdI3KiR7iQocTA2zn647bP/OAf+NwtGzULSNf1HsFZYJb8IriqNNc5/z/8MnTyD5XFo6rRBs/vvYpo7iCA8XkyQcs7JER2wmBtGWS/KHjM5ehF1YbZnaG7g+ej05ZBK2MOIqej3hWQUWcf4O17RPcRxNKUUpPSR4t8r07VnDobF3cJDZx3PCx2P/VYjRtPrFb2pAuYFyudmZZzWYaaei5t9LmPWbdx8y83py7t5bpfgoQS/y2LbD8epT6vbAg/FdkN+TbiSF4ce0GISAky6KNpAtB4ZAxSyuU1sR6lC1dysTLMERWydES0JbbTVlIgWLGLfqGx88m44qEL9Nj5V0nn89hj3BFDLeLIEEg+pKBGDcGemoHm3TI5JBINXEvTrbuDq43Vq9EUQc/HlMutyUQLnglYbD5NTErdaJyDSxeb6Q+Zx9QFCHWuXSMMKllGfP2IVAjK6afR4tuEEDEkdeEV7F3Z/ztrhWkNboYiKfPxuTQtteFaM+vv1HTHcs2Kmm8hwrs7JXoOleqg+FGWJ20MXVc6OnxJM0ZH4nxCQYeeld1BMS+f4BmWndoIspIw7ILsHqrJcqO49Lu9DKFcYWGBPN6Qc+OJrh4f8UPrnY1g5JfN+lSL+JOmg/PbjK74rwodV5nu9wm3SNkkvoCLr3fwVI7V2OR4jIDSr6+lt4NeTTTcPYd1IUPEmDf7RXVNzDT10zJjLcJ+g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(36756003)(6916009)(86362001)(316002)(31696002)(478600001)(44832011)(6486002)(4001150100001)(5660300002)(2906002)(966005)(66556008)(41300700001)(8676002)(4744005)(66476007)(66946007)(8936002)(82960400001)(38100700002)(26005)(6512007)(186003)(6506007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nm5YQ05uN3k1Q3ROWFgvRC9sRlUzdktSTm1SaCtpaVBjWExiT012Nmg5Zmdk?=
 =?utf-8?B?RXY5Ujg2b0JnbVhPUktyNVpQK1B5am5zRDRKSlZiWW5pc1FCOS9BT3hMdHU2?=
 =?utf-8?B?ZDlzUkpEZEgyV0ZaSFE4ZnN0bGNuU29hN1pKYjY3eFdHdFF1dldJdEx4Qk84?=
 =?utf-8?B?a1dFamxJZXFkbjM3b05xWHE4VENyZ0hmT3h2REFEU1RLTDB6cVNmNWE4UUZo?=
 =?utf-8?B?QjlJUWs1OTlMUEJoNkx0R2FCTzBmZFBBSjFIbmN0cFlkY1ViNHlrd1RZTi9Y?=
 =?utf-8?B?dE1vNmVzTE4yQTJ4c2JyOVFZWkNjMnd2alJkTkN0aEd4elNZcEhtcXl5ZElP?=
 =?utf-8?B?OHlodDYrUVlzR1RSUzRsckVpdzJPVkNsSVlhTEdUV1FzUE9lN0syWGVGS1NL?=
 =?utf-8?B?Sm53RjA1M3F4blRFR2JDSGVZL2ZicXlpWVV0MHFQaERpc1B6WWJiWGdmZ1pW?=
 =?utf-8?B?YmN0dW5TUGU5YktBK0FaeHJyK1B3Y3lGVFJvTlFHeUVCMDhBckgwc1ZZV2tF?=
 =?utf-8?B?YnpuU1p0bGhpSmViOUhuQmwzQzlQVW1SdCt4Y0tEamozZDRIVnNHZzFaOUZL?=
 =?utf-8?B?QjQyc2FaK3l5bVFqeXBCL3pzMHErVE5qWnNIWVBuVHYwMlBTa2JCK2Nocm9K?=
 =?utf-8?B?Qjh1MHhQbXZjcjlGQjBTc0F0OGM4K1orNDVlMHFnTHJlcWN2UlZDN2xRMjl5?=
 =?utf-8?B?V1BrbFhvUEpLN2xkc3ZodVdrKzhqRjdGdDZTSjhMM0lSdjhYU0xYUEpzbkxS?=
 =?utf-8?B?L1pDeTMxcGRJRHBDUmg4OVBucHFhclB3ai8waHZ3aXAraU5ZdHFLaURQOGRH?=
 =?utf-8?B?SHA1QlRNN1V4eEZvNXlFcmVEMElsK3VwTFlWU2RVcVFhemdpKzlnTnUvazRt?=
 =?utf-8?B?WGpTZHU1TWJqNS9Hcy9hTmhMbDllZ0ZQWXQ0R2FNeURVaHNIUlcrTVpHME91?=
 =?utf-8?B?dnRnby9tMk5VQnlpUStZTjBFYk1TNGk4R0tUNFlvVVBWN2laV1pISnlqZi9O?=
 =?utf-8?B?OTEzUTlzL250ejllZmVrZ3UxMXlLQ2FNSUFYUWxDQUg0cGZQbjFNWnlNMyt1?=
 =?utf-8?B?YWYwdjROdGsxekJpUVUxekYwUzIxcE5uMHdTZ1ZTelNRR0p6YzZEL3Q5VUVy?=
 =?utf-8?B?K2lZN3VSWGZYV3E2ZFM5amNnNW5jdmRsZjFOUDlQVy9jRW11MmV1TUlYcDB6?=
 =?utf-8?B?dGJ6OTJTQjBTNWE1ZXgyaWNJZ2I3ekNQVjhlTGV0OXZOU2NOcTRkTXYyUC85?=
 =?utf-8?B?clpoZVR6a0RhRnpkOHYzTitVVGFtMUMvTmpNRkUzREZ4OUIycHNJUThEY083?=
 =?utf-8?B?ZE9qOGhDSkJ6VjMyOTBUeVV0MUh4ZEdmbjEzdi9zUVBzNkV0TGRiWTFOeEFR?=
 =?utf-8?B?dGRDM1BOS3dSdXVyY3dOUHpMZm9UZnpUWk15TFVIQ29yVjRQZzQ2RTBCU21m?=
 =?utf-8?B?c0orV2w2anRvZ3ZmYXN3REhJczdiOUM4ZWVyKy95cWV2ejNRM0o0czA2U0dj?=
 =?utf-8?B?WFpNWTJJV3dhWmdXeTlBMmV1VFloTUxsQmR2QmpRVXc2aW13djBjVHFVZmRt?=
 =?utf-8?B?NnAvM2VxYVluYWhRdGM2N0lFVXdxWU42MW8vVCtsQ01mdmlqSGZtaFM1WEI5?=
 =?utf-8?B?RUZGS2hScEZxejRGYVBQMTJtaUZTYlBNUG1mRy9hREdTM0R1Z095NVg5MG1F?=
 =?utf-8?B?cEMzc0pUWmZ3R0V0eTlmWEFQVGwwNEN3eXI4Z3Rpd3l5YVNpenNsZURLQVJi?=
 =?utf-8?B?ZzhrMUUwSmJScXQ1Z2RYUlF5c1RVQmNXSUI0WUpMR1U5MGNqZnVnSG94UWlZ?=
 =?utf-8?B?MnliNFBrRlFNak5TWVBMVCsrcUp6TVlmdlY5bFNNaHV2WFFtTTBKQVVLdzVy?=
 =?utf-8?B?Z1hlVGt5dUZJSXhoYzhIQ0xpM00wc0RTb3F4blJicnkremhTSGI2bXJoZWlP?=
 =?utf-8?B?c1JKNlJlUXVzQUlscmZvNW8wMVlyL2RoSWNJUjNMNWR0bloxdjV5Z3QrTGxC?=
 =?utf-8?B?eEh6emM0djM4TmxmY2FDcjU2cWxjYTVKT3RYWTlTZkJQb05uQXpXK3UvWFhN?=
 =?utf-8?B?eS9ySlNUUDlsdmlLeGZ6ZzgweDd2MmM0cEtWelZ1enl1bmpCTVNaUFRYb3RL?=
 =?utf-8?B?RllqWjU3QXlPMm00Zm5jZDEvWUxjY0pIaThNejVIQkZmUWk2UTIzeDBrU3Vv?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb61565-2010-48a1-7bda-08daeeeae90d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 07:03:12.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQHMdLYPRhvzwIV2HgvQk5VtRR0crtEc9fGZUhqYYuc/Xvzm2WvDv9V8zVm9vokTeVuHkrk/C1gOhJ4mqdDQqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 07:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10321

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=1&day=5&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/12/cip.2022-12-22-13.05.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan


