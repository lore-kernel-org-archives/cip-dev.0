Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB51C61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 07:29:07 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.52])
 by mx.groups.io with SMTP id smtpd.web11.5102.1676532539846530476
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 23:29:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IieLd8dH;
 spf=pass (domain: siemens.com, ip: 40.107.14.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOC31BoJw/ARdTsMQayPpbudCYJcY+sI3xV6way869cig+LE9cbKLPrf84Y0FsxafUd19wezDBOuGggS6Ic0xoOeW+tvC2fmiaTcLWpJy/DALZLGFxtrMn/YPepgyHb/1dsQp35ydH5hlhNhatsrNQ/SbleKt6y39rXZITF6ZKxO0uQ3B7v7KTXbNAXLV8calAJGPVaJP6widcM7BlgPKRT3YWHUx3RrD8Fhst4/IKJYtar+ZrVgXxd6rQW6HUcXppuRwpq/7T1zemBcRUuiMKIrVJKDpuAWv2ScH7gm1DfLNA4VaZsxfRhna7rjM0THBFlnDVd+Qvbhuq7olD/6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXQ0JiB3BjaUuT9VTRQmHSCUuM5/goMh8pNro99Dg4A=;
 b=ni6Sz5nkzaz6gLNq3t3b2tqPtQIRpohqjIlwESecRsI97Q8Jt40iBoEraDLrkmKGtzyTli5Q11OqEVKEg7fTeiJ58GvLwTFH62Y1Smuo6K88tnA224wy0QbpxGxUCNezJCjO5b+ouSkN06PI1HEodIunl/KLxaVELiiVON+nsFSaHrHA2ime+i7G2JBeEw5Rngtg7g5v4xZ3JaL4W62IHYnZssQPS/vdBb72xzIwPoCjTRlZqLutuUP3l597lIup5//wrEZbGXQdpNE9Y7MqLE0GtRwLNNTk5QfVJQ8UUOPsMRdwdLuKeZbtekzc8+eWJN9p//HTK+YkGfaSRgNVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXQ0JiB3BjaUuT9VTRQmHSCUuM5/goMh8pNro99Dg4A=;
 b=IieLd8dHpAYsbd0c0XKvvhrTHhJrTsRH68SbEebHQAmIc2AOmxZfvZGp/uevKg9Xc5rn/5T19tHhgawQVamarNswJnGK7iGUshT7yFJHE0VuWTsSnEUImIZr4uxIEceHNyGeoOmS11LQB0/BZTWvKw5RfBkQCJKncMCpJJiUf6izbZqkMXaiUgOzhMD7ilViLUjWKWnyTLzXnJ5sR4K6aWdEfXCx7pYrIyw4s2rf8AH05sIcBKSrrWj/EmsPQKZWAvrh0gnMTLE1qlbV7d0nUVNiQuEtQktNM3glcZO7VCMKO3lNmedxuWO0J5y2KL5mzR97IZt5frjOSq2gywFAjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 07:28:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 07:28:56 +0000
Message-ID: <eeb6bc4c-f6a3-f439-4f63-ff87e36a85b4@siemens.com>
Date: Thu, 16 Feb 2023 08:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f952289-d64e-473e-ba51-08db0fef76a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aebluv+vL6djzbQT4vNQGhF7+yVFkPF18BfyFjDb9iuoiiAVQ46QvkU5VzHQSJnddDxBMwul+EBBM9U6f7fAY/0O2WQ8bxChEoY4I3cVgBT+dBu++Jhx1B4q9tGCBlA+64k/jnMr7Bn2QWCmqC7/GLVVyUqatbua2KjgBOapidgKsiZhp4Mk/jaS19hjTvsqIO+iCQFwKU4etP6pn92gMR9/oX3LDpMoUvxT/3rqPSK4uoywBF+KI0Wk/A49w/l5zycEd9afnD5sgW/m4PB/2dDv6VULmed8q5i3z9XVpdeK+2OxeoKRScRsApdLDoEz+tHbhZPBeraPWuiVYxgki/NA5YLRxPMhawv2jxeHvXa9hnA6baFGmPNgxQOlpbzg1nGX7iNvjH4cJ+tnnSP6KSsRMdvAj1+6FT+F/sZFSA0vwZlqk7DUZtyqK6vYDLIceT/a0mC4KByGMHg+OQAEHnpAhA/v7dXTu/pKAZ0GV2z+M0Q4RC4/sYyawPZuQn8/rIbsoVu+WDRdY1NaVJHbZ4Pi7Ar/v1gbN1WEcgNWMlmV636Hh7D0IGwLBV7D0h50y9tdqWvgBWtQ3yXtcrRZ2sEs+TzzmoML7jj/MAQjLpGanBApRz/z5GlPpc6bqLik4xju5XwRyTv9Apx8ZeR5ySIqHWW3DKICubLRuObScTWS61ougZ3t2/PjDQxHebqXKguNmJ2JhxJ6iUaQcenATgrB0vFLTgXRTg/mBI2JJkgrvSDmcpviQb32/TTRmEyogBAXrCyLx8a7x3s8q8CnKA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(44832011)(4744005)(6512007)(31696002)(186003)(26005)(6506007)(86362001)(83380400001)(2616005)(38100700002)(2906002)(36756003)(966005)(6486002)(82960400001)(478600001)(316002)(31686004)(8936002)(41300700001)(66556008)(66476007)(66946007)(5660300002)(8676002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVFGVHVUSXRBa3R4U0c2RkVydktJQkN3cjBMais0QlAwZklkVlFJREJLaFFN?=
 =?utf-8?B?TVQ4M1oxTnpqYUtudUUzSDM2RXlMRXB2TGlGaVk4R09rM2lScEZnSUd3RnhV?=
 =?utf-8?B?dm15SDRoaE5HUnpoWHVBVE5WK2dNN2NaditSOUhWeWYvTHVidmxXTDFoeTZm?=
 =?utf-8?B?Y2JsWFpVSVYra1oxajVnWTVDL0Mzb3lWRmQ1cS9sV2xnalhRWi9UWmY0aUJ5?=
 =?utf-8?B?ZXREZW9pelFmZkE4clgzRnNkNVROSGdhTGZDQU0vdmprRlFCREphbkhWVVFC?=
 =?utf-8?B?QjJmMWJ6aEtWak5Yb21wTU9HZzJ0UGZDbTNKRk8zRzZFelVmaSsvYmk3dnJT?=
 =?utf-8?B?RlhkU0RnemlLRkVlQkUxTXpsOFFLTUwvMzIyL2lGWUlEblg4dVJjVXJvaTR0?=
 =?utf-8?B?MTR1MC9va3hjSmZsMVJxWm1aRm5aQmxFaFF6S0JHZHpPNlpmcXo1YzJqS1lP?=
 =?utf-8?B?K1h0S2UxTkRqNENhZDVqY09xM0s4S054UXZRaC9hVFgwRzZvRU8vYXJNVEhW?=
 =?utf-8?B?bFAzL2xlOGZCZTg3UGtPd01ydTFDaE1tTHRScWNEWG1GNlZBLy9EZXRoK1NZ?=
 =?utf-8?B?WS9GcS94blcyb3JCeUN1YmRxRjBVdE56V0VqUU5UV3pBUVExbFJBMVFhaU1T?=
 =?utf-8?B?ZkMxZ0RRVWZSLzVnSWMvdFQ4TDU0NlVPVUFSOC9MU0cvWW5tQzhGNVcyZUxT?=
 =?utf-8?B?NmkrMUluVVNzU0dDYU8yMlhZS3M4YmZmTjZRQWc4aHJ5YjdZSEpWQzY4b1JQ?=
 =?utf-8?B?alVoK0w2QnNBK0RqVDFnQ3Z3eWtHdTBZU0pSWFN2R2hXQnpuVkcwMXA4WEYw?=
 =?utf-8?B?NHhxclZ1NkE4RFY4QnNSNCtOTmwrNXlnQUZTdE1XZnBWUlc3a09TeGRXSGcr?=
 =?utf-8?B?NjY4d0V3ZStaRlJDWTZZZVl3bjlWVW43aERJZmxzeTFFYk5Tb2ExQVhibmVu?=
 =?utf-8?B?czVubzFhL09TbDhyVXhPb1NKUlZPZlM0d1hKYW5JSVZWV3JMamdzcFd5bUtF?=
 =?utf-8?B?Q3doVXVuZFFZdDNLZ1g4SDUxTlFyUmlXR0hMeTA1YWhHQ3ovOHUralp3NmN3?=
 =?utf-8?B?NWdROFozb2dhWVNRNjFCRjJKWFA3YitPdkIzWTBWMHRmZmpaNGtlUFNQQmN4?=
 =?utf-8?B?WTkrY1VCT3JnSVZzRUJJbmQ1VHozSC85bTczMExmZUdrcVF4NlczY3QrREl3?=
 =?utf-8?B?U3BpdGt1VmFSSzVzV3FNNmhPelQveVloRUJ1K05qUmxwaEdBelBoMEQ4elhJ?=
 =?utf-8?B?ckYyeTIrcHJ1R1UwM2JQV3BJd3pBRUhkODRsaU1scFFlclk0RkVCN1A2VVV5?=
 =?utf-8?B?N0hsWTAwcXY4Y3FSalNnUUZiSlVwRVN6enlPZUtpUFRDVjQwTWJXTitNMURJ?=
 =?utf-8?B?NjBXUDBRb1o2bldWYURidkpOT01rOWlxeFdQK0p1WU9rOTN5VjltMGtiaXAr?=
 =?utf-8?B?NmliczdZcVl6aTNROWhQdnRxVFpxRmQwVFp6TXljajdZUlNaSm9sQWU5NThx?=
 =?utf-8?B?Q1pLL3BuZjVUdGQ3cWlNa2pWREpuUG5GRy93bE9kYTFEQUZnaFd2WldnaVVF?=
 =?utf-8?B?OTNDT3g2NE9IRzBVaUxseHFHTFlPMy9rdmRSOG1aOG5JWldJOXJmNEd4bUxa?=
 =?utf-8?B?K0pGQXdjZlhCdUp0dC9GL3E3Tk1jWG05bGc2dVB1dHZQdGxnRUdLbE5UbVFO?=
 =?utf-8?B?djdMSHBndDZtOHZxS1Q4OFg1R0dmYURpYUY3dUxhZkdOUzlzRTl0WXJUN3g2?=
 =?utf-8?B?NnNlWU1jVWhTTWMzS2oxT0cxWVlRSHlEZTNCcjRWT1J4RVBxRTBraWF3Y3Ir?=
 =?utf-8?B?MlhZS0RHcDVsVkNVdGlaTjdRYlRWeVZzOUhKaDVnTGw2UnJ0RzkvRlFNa2VF?=
 =?utf-8?B?ckVKZWVreHdUVVRBUHRPRTJkSWE5czFvVGdGYngyczhOVmdVejlSUks0NGI1?=
 =?utf-8?B?bjNVUllIN3Rtd3plTVFQb1hiVGlrNGVVY3YzakhIaW1kMm90Ui9ySTBUT0pu?=
 =?utf-8?B?YVUxQ0dLNDB5RElTVkNESXVLRThpdzhlMzRRQkl0LzlMK0xQdmRCL3l1VmZ6?=
 =?utf-8?B?c2tHQjBSOXZ1eXdCSTVFaHR0UHJRQktOY3dmK0MxYytqMVVoaXJZNVNtNDUz?=
 =?utf-8?B?aWtiTTM2RmtGcW9NUDJrbnR6dndVK1MzUm9YcThIekllMDI4ODZ6TDBpNGNs?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f952289-d64e-473e-ba51-08db0fef76a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:28:56.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eemtASSipd9W9JGSeC7Hmj+wg3JrSkvKDGAsT/Ne20oT4XS52n4ZiyMquVqm8ldMgSfDwLAXtd3KOgRh3UPxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6658
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 07:29:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10710

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=2&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/02/cip.2023-02-09-13.02.log.html

* Action items
  - enable more stable trees for testing (patersonc)
  - report 6.1 test plan to LKML (pavel)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

