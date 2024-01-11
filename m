Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F33C4707B
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 06:59:49 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.87])
 by mx.groups.io with SMTP id smtpd.web11.6348.1704956381956989625
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 22:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GClrW30K;
 spf=pass (domain: siemens.com, ip: 40.107.104.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfNpBJFEbmtAacNdX9OeSF+5BJHYzPQ/f46yCcH3fNZKwMiiTgAGzejMwshZ6E/fyE3urYXJkFIzyRj6zgVpC6P4KO/+TrBCsUO9qdJ/JUvDNPwCt8IQDLg14JaEKF9e1FEakqUF6Qgt8ZeHTEFksdQr2nvWgpZ6MvUHLvLSGTmsfEF+cPjALTQOHmGT7jnCuMW6quATbB0jUFqL1IJ0P4tNS0utCdNUidgpJt/R2Y8GzE9xSIP74gLxWa1jTSmzxkSymBEl5hlN0je+l5pTU2Ryo4Q4YxdnNDXhyR7krHGE3sVvdJH+TWE2Hwza5lb/ZSe/f9lHJmuX9S6UdnnHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nejN57NK3CFIlNsLLZLTkhLKpuQH50Z21JWjpIGRFu0=;
 b=NGU3wE3Zkz38P+tv7FslfqLb48Pf54bwvLZRObfqXw1L/V6Qr3qprIP6YGyPoZcoRnnlCpMXBqn8/Kra8MYDjkdkRzeCTvpbhr8rYdRM4+DQUJq8jdftjo5akLBPUU+uMj9pGpHulb72IN87aV9QtNTuuDffZqvv0DFcI0r88jkW1pX6Qjwu1mA6zyasjn+lFJ52SSfeu8i6bNS0ZgPczSmU3PI5RgfnrxfZ86LFAMOF50DYmkbMY/rcg1oZxHPaDiliYDkFRHON+J1xDEseg60cy2UBTvtYwcxckHAsAHQoBEcTOfKI2MHLYotghTO2+urCzzExcNj33SlDqdpf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nejN57NK3CFIlNsLLZLTkhLKpuQH50Z21JWjpIGRFu0=;
 b=GClrW30Kxy71BmiDPIlgaCA3SJkh+XXYvdzdJzvfDpPKDwA/p8X3oY4lUdZZ8Kd38SEMLC41VQ3ylMo212YgnUUucDC/4Fcqm20Hx4TJQ6SFNXf9akbeB/cDM9u3EQ7mkPqdyMFnnfTOVq8ST2d+s0pBlxDInarU3yCvnEGSrWXNJ0DxSwQfT3+QA23MNYbWeiMkRkou6oUPR2rnMmBuN4Z9AamiDVTzdr6oY8adBQjX2HZaTz74le9ajEQxcZKk3GACRtxZcyiH37ccjPvoGcV07tQn/Pheqm4KCf9/K5Hsi0IBBo+8lgcICA6kZT9xTv3sU/gnzz0cMoTVzBnuNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 06:59:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 06:59:38 +0000
Message-ID: <6b54a065-4259-429d-99dd-a202971fc43d@siemens.com>
Date: Thu, 11 Jan 2024 07:59:36 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3262:EE_
X-MS-Office365-Filtering-Correlation-Id: cee94ea5-259a-4fcc-78cf-08dc1272e08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1OdYWWvBk542xN73YbAjRSYbOvYP58wnhQKFLC1xcpa83RPwBEVi04LmkKTwlh968RFIZw6IdGIPEnwP/P8kCbagik2a4z6/NPlFcSuohNMIHNV92Z05sDvGel7k7aOi7TFvl/H9xjnet8+Culma0+zyoVZ3TDlWvFEpckKWx8wIVmmdVH34zghd8yaJfpaab/2Hu65MG8xr/fscBlOxMPwR6mBwEmAdTRLfVwcwnBolWhhunnk5J6sbNsOA7OLVFLTeIfz/FPT6ZYiJfmwpq9dP0VU5bAEv+mgC67Kxg/IbQ1V9MZBM8Y1VGHAvEdlYO7YXQdjvyxmApcoWTdXqX8Kk4YiFYxsrJ7hAP9kKm6VimbOWMmw5S4YBa9vW7FsG7jEOZBXRZa63IdvYTfrKZ/yZfi5lIynst+8MaL9323QgoMl4DtwCj5RlEbKgjGyGRqafgZDuImv0fwcaEaVVC3OKNdbwGBCXkNoU3xJF8u41bjBk3vTK3bx/kubwPfeikaZbWbg/pGA/BMaCvuJSrp8X3Se74TsjAG4IXUQjhoUEAtvzjU+RIQR5Jm3H24D05RBX5wmYU/Kc53XjDsgO2r11ZKmyzei2TQa+JsBQmEN9O5d86ROSPCJ+yIepJh1O
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(6512007)(6506007)(2616005)(26005)(38100700002)(44832011)(8936002)(8676002)(4744005)(2906002)(966005)(6486002)(478600001)(5660300002)(66946007)(66476007)(66556008)(6916009)(316002)(41300700001)(82960400001)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnJOUmZSVHYyaFlpNmQ2VVZSNWxmc1NyY0pibDBVLzlhQ3RSRThlZEd2cnZz?=
 =?utf-8?B?S083WnYyYnFGZ3Fjd1JUc2hTSmJZaFE3N0hOMlVMMElkSXlhQXVJQWZVOTI3?=
 =?utf-8?B?QlJyTmFXa0tSemtSeUdTOE53b1cwODBoUlRsSHcrZThmcElaMUY5VGRlVzFQ?=
 =?utf-8?B?bzRNMjlZNm5ibGNJS2UyUWIrYnRvVzQ1WmZtN01XQTZISlhqN3g2RnZmVHZo?=
 =?utf-8?B?Rk1JODVXY0psdXAxbXlWK2xkY2JRaU5sSWluOU9sNkRBd3YrbkUxd2w4cHVI?=
 =?utf-8?B?TzFaZ1JQMjFHWUpIUXovWGRsREVKWjJzcm1CR1U4TmxiYmovVEwreW5wekN0?=
 =?utf-8?B?WmM1OU5vLzMwcDZ4ZXRiWVZrNjlPT1JrWGJENTJZUEQ1c3MyTlg5S3MzVDZH?=
 =?utf-8?B?RjhDZnFwT0grckRoUUpEMk1aejc1dnFCNWxvLzB0M2R5QXp1TnZzSG93bE44?=
 =?utf-8?B?NWowbHA3Ylg4Ukh3cHNtdEZ4aGVDR2xQNllyUG8rNCt6MzZ4VDhQdFFEMWhU?=
 =?utf-8?B?RWRRWDVSUW9hZGRiSkVpZTBTdEMwRjhIOCtDLytXY3FBbm5yOXRTcHFZSnNT?=
 =?utf-8?B?dlkwaVh3QjY0UDF4WE5tKytKNU9iUDlJQUpvdW04b2M2OEpvUXBLcXZwL1hL?=
 =?utf-8?B?ZW9lT2psY1dBM2ZHVFE0blRERkpyTi8yOU9uQnVFRlcrVGQvS1JjSzRoOW9U?=
 =?utf-8?B?anE2cWppVXl3OGRrWnEyWHNMcHVXb0pBaEovdWFDTGl4NUlxRWNtTmJmZXFl?=
 =?utf-8?B?Y1R0amg1K3hocTNFQ1IvNWtaMlRSM250Y2ZvK3lsaVZZVWY3c2pMc1Y3OTNJ?=
 =?utf-8?B?SW1Md3NmVmgzcm5nbzNnamFDNWRxa1g2TEwzYXJCaUs1ZFVubHZFYTk4ZHlt?=
 =?utf-8?B?MjU5MjF5QWZOdHBkVlRSSGZKTmF0WSt0cVFYY0YrRkltaUJ4eWkrcmR5dkMr?=
 =?utf-8?B?SWZ6ellhRHQ0SnF6TEhheCtNQVVlLzJBSWtyb2ZQUXYxVkxIOFFFbkVkdE1s?=
 =?utf-8?B?M3JUemhZSW5RVjVGV0h3NXFaZjBsajlHTVVkZVdhQnpnYWFwQU1ET3JDeUZj?=
 =?utf-8?B?NlFTcjRoaXRUS1UwOU9nalJOT2tuSlZhc21xNDgyYW80aFNsZHRhYlA1RVp3?=
 =?utf-8?B?NEVEd3BpcFFmUW83QkdmN0N3ZU5FL3ptejJsdHVMS2pUS1YxazdrYThhM0Fq?=
 =?utf-8?B?YlJNUGZJUGFJMWJYUW1UUzlveWwvc1EzbEcvdmtlNmZFQllXY1NNVFFUNmlB?=
 =?utf-8?B?Y3VYTnRTL1JhcmQ1WHdRbzV3TDhhVm43QkYrdy85ajVzSFlmK3h3U25Qbm5C?=
 =?utf-8?B?Wk80a1pib2x5ODZpV1hoejBDeEQ4N2xmUy9SYzV1QVNoNlBOa2NnL1EzL3pw?=
 =?utf-8?B?UER2Nld3dEM5dVdIWmcrSWYyblZjL3Y0Mzc0RHZQN3hrSVFiNWpLWkhvRnVX?=
 =?utf-8?B?RFVGNEJhaGNOMjkxVFR1VS9nVVBxd21WYXRmRFd4Uk1oQnVQMHVjbFJTVDM2?=
 =?utf-8?B?OEpkWU5ZZm1pWmFzcGNhMERjSXFhZTQwemFGNVJkZFhlMEFCYlc4L0FISHNX?=
 =?utf-8?B?N1ZSQ3k4RkdOa1JYRTVWbUFVeGluYk5JOWh3bFcra1NJOWxiZHNzMXYvQ2Zp?=
 =?utf-8?B?Skk5QlNvTHhaUjB6emZ0cmtVWWdxelN4WFd4Vzc5dnlXZEZ6bXFad3k4TzMy?=
 =?utf-8?B?WW9oYU9LR0RyUS9IQVA2Wkp2dHVDVkpBL0JJWmMzaUdvVXdjSGNrUHRxNGhm?=
 =?utf-8?B?TjJjaFQ2bG5tNWh2ZkZEb1lFVTA2QTJ5ZmRuMXcrMnVtU3c4NTQ4NFVPNXkz?=
 =?utf-8?B?MXY4K1NVNVRPVE5rSUpRcVFyeWFBMkFvSllUTGlDSE1SVzFiRVZZNTlFeWdy?=
 =?utf-8?B?THJJWU1Dc1dkcVhQa3JzM1Q2SnpHOU1NdEhtRisvYy9xOGpoSEpkY2lUemw1?=
 =?utf-8?B?amsvSGZTZjA1QlVxZ2d1MWFCRWl5RndxVmlhSmdKWENkeXdtYnBlb2J5YjEy?=
 =?utf-8?B?ZHNjUTdDY1h5MmNIa0JucTFkMU9vQytJY3h1T0FxZ01qWUlSeHowanFlM20z?=
 =?utf-8?B?RG1iWFFWNDU5MUswY1hNSWNqTGRlUjFDQTJXemZueG9hZTZCVEppMzhSVklP?=
 =?utf-8?B?cFlUNDBJTHBXS05EVXhnVGJFZk1BMGI5Skc0cHUrYlRtRlRDQUZ4aEg5SE9N?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee94ea5-259a-4fcc-78cf-08dc1272e08d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 06:59:38.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8zggsunPpF98H3HApL9HVm/qLDt8utUDb+quE/gzrTWh2nbstFTHgILN6qkgnH2iM/6UVXJFvw+p6aNg/MWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 06:59:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14328

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=1&day=11&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/01/cip.2024-01-04-13.01.log.html

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

