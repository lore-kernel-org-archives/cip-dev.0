Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414ECDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 06:01:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.74])
 by mx.groups.io with SMTP id smtpd.web11.5254.1697090506755466804
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Oct 2023 23:01:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CrrNv2tA;
 spf=pass (domain: siemens.com, ip: 40.107.22.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5CW3CZ7uOh4MOiehMbV+Cj3yG3ysN7UgcpVUF7+Ols/aB10jiZCzunBOmtVo27huOPDJMH3ZYmISTskElTxlkevhuL/mpGuXlp9rfHSUdkj2BUYf+1axeHIjfwXogK/TyiyAssdNHTgUw6n5fLfI3GJGAXd1I4OKpE3NqVF9bjec9v4PRK68iYumcOFMqgH1pTeDaDCBlf4lkUlPOL/I/er0r3GQa6XaPPEMoVVsVwJYiWEjgHyPDdeapHvSQvXJfEabRmqEd9XyH4H+x1QffXqTDdwqklerRckuBAtJ/Q9m9+PE379QLN8Lo/kGtKcqBibe18XHimB/BQ5QFQODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL92EIwJP4T9rEQgFRn0yGqIznrkRm4B57yxiCTuiIY=;
 b=VrTp3bDleRdGwpNvT1lS+bv3zFfsPXyc+4ipCtM9bF7wsHJhT455Ft2RHoANlw1UoucKLNn5GWrk7KwSwHwCPKayayHIA/wa8zAGlgz1+620oZJuX7bJEuhJJlqYywCo/ouqV4AHf0tUrBcqygF+HSWOy+jh/2MNRmyFgXDfi1j2/xoDBP6l2HMsvuf/kvVP6wSKkJx3zkePtdUJXXraEd5yRnCuX4UnyK6EeVIpuIu1lg45ALuVEwI9YU/d3CL6CA5Pn03Tl1bnKA/lSq7Bmxg7AuzhoJpc30gFbLqDEusat5L/BzkQEDHKybMRBFBtvYijSvtFOwIQ6UbaJlvyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL92EIwJP4T9rEQgFRn0yGqIznrkRm4B57yxiCTuiIY=;
 b=CrrNv2tAs7Y67UUmAzgFNORYZ+CYQLXFBQTwJvknLgSi0QeV4ZRVecAW+OgTJOlmTdwmEfrLNNGrm5BfW0UDQr1Aj1ti/pE2mJxKFTb5YSQdksSKtNyGUKaJudkT1aHdVvY95Bg3HlpJCBCPFA8HzF9YQW/8TwB5tQ75iX6uPKo65qOZjOck7C2Xu9P3qp3QM1UKSk/M+15bBEFJt+gMnaabAYhvl5E9fwJqkoysjrVoqVeB9PBmaBjBzJV0WhREDstYIw6ih/va0kXKyW6lKwKLLgEQOOOfO7xwt8ig7+/SMl3hnUK+edia3KmiS6UxWc+O8NGFH5faEsY7FdQqig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Thu, 12 Oct
 2023 06:01:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 06:01:42 +0000
Message-ID: <b0f56e28-9efd-4f56-b7f8-f1d4c0c154b9@siemens.com>
Date: Thu, 12 Oct 2023 08:01:38 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce245ba-c57d-4be3-84a3-08dbcae8b4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QtnYX3ao5sKPx+puEas+uxq7xdhJzjIqfNLvAu+xX/hZM++A4ipQZFnRAHJCPgg1y7vWeXKY4Vx0tR4/aGvFqIKpX1z3m2KVV4TLhB1DaeUAPMro2/uH+ULDOCK3tVo5zLK3helHCpAJKkHiDsWNr+pKzxewoTOUPvydtIEKzKSmwh220b6ltdKbDePT+HymShrbsXqsk3qQIEhWOJAaU58yJncjM1ETtqrnTgMKXGDURIPvNhjfxx/+Lp3dyUcL2qwii08uIHD33DsnFf6juaLEAyLDYpo1rb9HVfMvluCNN4QBGsCi0nJJeV0SsJO2OpeQbjAr8iIrI6YLw4AW4GO6cJhblOL7FE1qoyNRBd51/qbiY1NATh84VW9ir28rRtTETh/f5PtCglnhYBSo/2Whsp8N1WDU/CgE3CvNvnV7rd9K28uEgXxXXGi3ufZQKRShaUKt++jE6mPyG4/siSuWUZKLUiEwM491ny05bfq0SnfAgvNLJAQD2i5xmd/K8BE/D60wJrstOj19kLYyNmiQvlJGLbBFioJo5Nzw46esM4qG0FCRY7ORyDpzI4eVAaWpBbC3CRx91LKsK/cQQNB243JqTGksa5uzx8AqVevPzlBaD++QVA6qmmxXjI2NGIB9JrCNdlqJ2SPoEJ8dRg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2616005)(6666004)(6512007)(6506007)(478600001)(966005)(6486002)(26005)(4744005)(6916009)(2906002)(8676002)(316002)(44832011)(41300700001)(66476007)(8936002)(66556008)(66946007)(5660300002)(36756003)(38100700002)(82960400001)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFNjMDYyQVcxMVB3RFoxWHhEWitGWUdoOVdlRlFBVjdyTDlkeDI4b3ZUeTho?=
 =?utf-8?B?Wnlpc0g1SVcvQlZpdGpNb3NiWnM4SkZJMCtodXJ2eGRZNGFZRWgxWGdvQXV0?=
 =?utf-8?B?ekZ6M0xzSUh0RHFiUkgxQkhkSXRPelRUemMvVVkwZmlMTkZyR1VnNXNuSUFq?=
 =?utf-8?B?ZUF0eTRSeTBNWnhuaWtQVEt0MEg2RFQxVkNRdDI0L1YvSlRjRm81Wi92NENY?=
 =?utf-8?B?OVB4Ump1dnNaSGNGSUtEUTA5MS9SczZYREYzOEpqbWZoUGRwaXhhK1VJVlow?=
 =?utf-8?B?RUxiWWtvUyt1STNKd0d2bi9BRkdzdm5lWS9FZXowcG9hLzlhZVkrMkxqYUd1?=
 =?utf-8?B?UDg0QTZ4MjZkV2ZGMjhYWHFOaHdtaVV1dC9UMDVMVGZzMmVsK29NWlRTSHk2?=
 =?utf-8?B?MklPdUJOQU94dTZqVzFCUk50S3dZNk5XRnV0cWNNZ1A3L1NsZXRPbGkvbVd5?=
 =?utf-8?B?OUtzR2ltV2FjK0h2RENFZzZzc0dzMTVVSzM1ZUg3L0pIbnVySitqN3VwaGZn?=
 =?utf-8?B?ZUhyZElvWHlPV1kreGJhdWU4Ym5wMFJPVVVxb05TemFJZmd4bFpJckhiMnRL?=
 =?utf-8?B?SG41SDNMUTl6TVJtdDVBT00yRll4QUc0dmJhSm1UcnVlamlucVdFdHZhQzNJ?=
 =?utf-8?B?U2dqUitzR3hOLzdRa2RIdnd2L3N3WUtadUY0eEhncmpDakNvYjFZZktNUXN2?=
 =?utf-8?B?ZVhwSUJjYytGaEExa2dkZjhMRU9YUjdzOWFUaVJiZldSdWJDeFh0TUt4dTAx?=
 =?utf-8?B?ZklxaWN2UU9LSW1rRmFxU0NMRkpMWTNmQ1kzT0pub3hHdkRidXozbFJQcTFI?=
 =?utf-8?B?VUdZVXZBaVJrM0NyRUQ2TmFoaWQzV1NGQk9KbHNMSHBSQ2dUdlhkWkVUWDRK?=
 =?utf-8?B?d1JIWThWZEtiWjJVMWUydGlaRmZzREdYendVbHhmREFBbVhKbUVSM0UzaWRB?=
 =?utf-8?B?a3puYnZyei8xaU1GQjFVbDlFZjF5WEZEbGs3d0s5dU9MT2QyTm9NUlE1bC9S?=
 =?utf-8?B?Mmx2Q1NQYXJOVnFLekJkakVIQU5FbUgxVmhaUm1IQlEyTnhvS2M5dUpUYkd1?=
 =?utf-8?B?eS9IZzZONDhuaVllb2RiQWpEOHlKNEVzODZsc1ZpMC9hYUJ0Z0VwL1prYXp2?=
 =?utf-8?B?UjZwVDJ1VDhoSnNzWEtWZTAyc2p4ZDlBckRYcEQwZ0ZQZmhsRk83VnlXUFQy?=
 =?utf-8?B?T0N1N3NqU3JmNFhoUVJRRElNQ2lTN0tXSmVTU1VDK0xGYmd5eFNjZ3FhM0xy?=
 =?utf-8?B?Q2RueFVnSHYxWHNXamI1NllueG1saGRaQlNvN1RlNm9HZmo0OTh0T29LRWNO?=
 =?utf-8?B?TjUrT1JSM1lrbGw5UDI0YU9hVk52UGc4NUROV1czRldNYS9JbnRZY1kvT1pa?=
 =?utf-8?B?VldEZm4vTEh0VHd2UzhET2loYTN6U09RNk5vb1RPUnl5MFozM0FEcW1BZCtQ?=
 =?utf-8?B?YjE3aVdHZCt5bk1FcXdPOUt1Rm9BRlVTSGxBQ3MvRGM2UmlKbWhYRXlZcjJl?=
 =?utf-8?B?MDh6QzhEOGVtc2cvSnpCSklhaE4yZExManhYbGNnVTZ0c1pXa3RhendCMHQw?=
 =?utf-8?B?YTkzOWh0dDlySWNtVHMwbzBnN0NPb3RINjJBYWZCeFJPQWlKbTBabWQ0cFZ3?=
 =?utf-8?B?OHloaEhFSEpkU2ZEYi9iVXZITzVFcFVJSVlKVzJZdThGQjRneW9HeE5RanFi?=
 =?utf-8?B?dGVrYnpwT1ZjY1NCdHF2SUZmZTVUWXllWk5CU2dicDlhUHFVUGo0OWs4SVp0?=
 =?utf-8?B?eDJDbEdCUzJMKytLRHUrWVFjNkdqbTQ0SDEwMmMwNjBwemk3VkxNQmh0T0lT?=
 =?utf-8?B?dzNDcUx2c2t0YUk0Y09OMGVWTXViUEhsQ2xlcllXcW84OUNyV1JuWmNoMWpZ?=
 =?utf-8?B?YkdRYVg4YmovWmovdDFSb0xWRnZwUUc2bUhzSXpMQkFGL2hTMlZMWlVpck9y?=
 =?utf-8?B?MlBUQ1krZGpJampoMkErNkNlZlRsemE4ampPdVRwVFpnWEVKdjNldFBLa2RJ?=
 =?utf-8?B?Ky9GV2dYQzhPM3QvTHZSMmRVOGtrbC9UdWE3dnN2UHFROVdEWWlRTVE5eE5w?=
 =?utf-8?B?aU5ZdDhyamFuM0tMdVJDUTFKd1VrUWpJT0daVGZhSVZjV2lOVnNoQVBTay9y?=
 =?utf-8?B?SVZGb0t5dGJNQmNDN3FKQWZpWTlicW42RTR5QUllbU16bGZCZjhsWUhlT0M3?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce245ba-c57d-4be3-84a3-08dbcae8b4f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:01:42.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG6cuB3u7yMmkPXaSO27cqriBlJjxCWE2Te3Lcz7ay7BhPAWd0OZgNHqsalq5o3PP21KHbQ5/D7ZqYeN3i7UgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Oct 2023 06:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13390

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=10&day=12&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/10/cip.2023-10-05-12.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

