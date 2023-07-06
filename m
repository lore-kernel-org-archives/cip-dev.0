Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786CEB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 06:43:38 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web11.15920.1688625812566971663
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 23:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b+fbGjl8;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcGHVeXvYdFRj4PT2DdVsdUdwkPD3q7lYQlQXta8MpxDH6X3dE3arhKy0+hxjLwLHQLfIDtDXK5BuRI/j7A0zKpP1U5cSGpfO3Ipm212KslmgnHIkEk2JDHotURww8lzO2lJnY+DYmy3fIpYnaKSAtRiguCgte3k50zj2wWzeHumCwkxAHD1EcF7hT4zAowuixAwQ+5+a3TxyCrNbXetzFuuxmkAy8P2UuI7qzu1SN77WCk+seAXPsSbCaPZ1cVU/NQ73SqYfBLAGNKWHBP30rx9EcHXiUTGxWBEo2I/GEmlFq2PZPWCSEj8y0/19YSEOVrsVIDS4OBDPCPaDzWhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5QOWD11gmBhWSnKO0J0A3EkTiu+D8QMV57XfZTg/uc=;
 b=h6MwD6NLgzI92hJeKcskWgMkX4MRBHEPQaHF24QoQ2n3/OX0CkXKNlXv10/jcpiKBWQF7LodKUcJl+/LUqUUbjaQQFgDoMUyeL5/9RJgVXw5/2uddqyPJfH4u+LuoQmIMZ2TEMZ+fqPmSbhoLQPYI350aIl4Im71mXwRhvAO6HprySCuKlqCQGBKmHJDzED+qG91eiYf/BJl7TOj4RP+pEcz9/Ky3OQDgEkmTxIQnHHlnco0eV094tLs2Y8G+jPWOygtxVzjGGruu/E2hglAEQgnzVXy6bwfemszc9XfrQOFujZRI3EO4qcr/7b0YkAcWNym1Pyq3sVchoRlSn8/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5QOWD11gmBhWSnKO0J0A3EkTiu+D8QMV57XfZTg/uc=;
 b=b+fbGjl8nYwkrF8MSOadfYhBIecvrIkmLCrKP43fXhUZEEgS/0bDqSCx+cgmPLsthbOqzKX0Wt0PhZscPj4uoSaf0HsSF3KB41ndNoSAdTL0f59wkwpZKkozG8nt5QUhfmkDA2Th1rEU31Ys5sw+6nVRp/bO5O0Teno7g7+NyPCnxLXRHHfxviTgakLWY6//yEvFir3InUaLIXluEOZs60sP+77oyqoQeK0SD4VFZ3bKTzF/t62A0JvrS5QiniKIf0zQARCDZJq2p+2btGbxp6sq+HO26nyxaK9fKYwjPdyI2ZGlejGs+lHJYLgrCVtDW6LOLKwZRJdiFGQZhlr8Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 06:43:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 06:43:29 +0000
Message-ID: <7ed593c9-2998-31a9-fcfe-61df5ce8d7a0@siemens.com>
Date: Thu, 6 Jul 2023 08:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfc7c52-739b-4a3d-47bf-08db7dec4f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f/v9NlckUiKO6UGQkuThh3vetHqsmBIuyx1pUFzqBlUji847iejrKfpf1OTafMPwqaN6MVV3hb4T3VmFtM542L9adg/9AXCnZr588F2LJIUCR/NUQD9+05ICTDmN3yCRCk0Yum4NeDAQabJ5Ho0kZ3DAKlIto8ruGiwqdcHY3ueRTsl0okRlVqyXcwkY16k45qfUYnbwRJ+3cvMqfPTIStjMKiF4KRDj8gxRLTjrPMpsYhFi+R4Jtgue+C0CPahqeeSTWa/WW94qq6MaEyb/tuUo5mzuIWlHdNGKU4oekJoocI+JLWzvA+moOjy35f5ROSz9MLi4ZlIsZ9mHcFf5DcO/kV7TAYwrp+L3IUJ9YFw6pS9CygFYB9TYF/CqYw4rEFg4dDypihmyGI5GRfz3b/hQ079lZuV135YjMk1unRDpDNXIAvynkZzDH1eSYkt2m6ajSXN9FPs+RJkeZdEvK1eyPdo3waKYQaGDrJB+ow3VqxnLMq8Agi/BPvwb9JIMM6+JSZGZxS3JjwC/4tM3QKgpsshqngb6T23MpYVSl05Qv4sdCNcd/BPVpBvOD8CGbibucgp0pZQRVsiuVG1zWfqDUVSNu0Koyym/xbIKeuKPf48nT949rH96NeIMBQSn7dKdb4BtMSJ6Mb6Y+AlK6Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(83380400001)(966005)(6512007)(86362001)(31696002)(478600001)(6486002)(66946007)(82960400001)(6506007)(38100700002)(316002)(186003)(6916009)(26005)(66476007)(66556008)(31686004)(2616005)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1VzUktIR0t0eGc3eVpKSEtWS2hneFdSMUlLWWduL2V1a29NcWJsRkpXMGJl?=
 =?utf-8?B?cmNpZXJOV3VjUFVwN0U3UFczTUlJOHJWR1g5K3U4YnQrWG14cjFxRkpDbDB6?=
 =?utf-8?B?aE1SYml1VGdSUE9wckxtYVVlckhkeEJYaWJTcW4xaDI1NFRBUmtXWWtDNm1p?=
 =?utf-8?B?TkNUalV5VkdoUGxPZTBOeFJEWk5nV1JwMm5SbXRqL0tadXIwMThGUUdCZHdt?=
 =?utf-8?B?bzlvRllBTVpDeGptcEVQV0MzbE9ubEsydTNhdVI4L1B1TkU2amNSY294Y1RR?=
 =?utf-8?B?cmhDc2w1YWlhRlNtZGQ5YlZkWWNiRDM2R2RsYlVuMDhUcmpFcnNkNmsyMEdZ?=
 =?utf-8?B?NE9zMzJoSjVwYnZEWEtHSXFHT0ZkeU9CSkM4RFdlalpLVVBjbDZZUXJSR1du?=
 =?utf-8?B?SGNBRjUrekJoUE1FZStsOGhWZ2JTSk9nWC9TbFExS0Y1TkN1N2lyQmJpL29x?=
 =?utf-8?B?MllIeU1hbWZyeFlBVDc4UFZBWGlPYlIweURmVDcxS05jVTBRdXJGdVlRMDJS?=
 =?utf-8?B?c3k2bXZWdWJJcmNCK2kzVTZSc25XODdBeHI2Qm1TUERveXZaTTRQNFhHcWo1?=
 =?utf-8?B?cHZwalUwOXkvbjZQeUpxd0tjZG5nQllsSG1UVjRKeDFPRWFHMHV3ZGVlblFV?=
 =?utf-8?B?Y3VLZWNSOW16L2pjVkpMb3lXSFZhM2Q4UkJHWFRRTHNteFVxcUgycHAxdk1j?=
 =?utf-8?B?SUhBQ2dIRHF3c3JmYlFkUXNRS0t1RzlRTHRNVjZRcHVSUVh0OForOGhwelU0?=
 =?utf-8?B?eGlIOXN5TEwwOVdJWVZrMEtLNkRnZ2NnUHpQbExZRUZ0NnROZ0c0Y0EzM1Iw?=
 =?utf-8?B?RnoxUlVpK0VKSEgxOVMwK3N5T1BEbHdOWUlhVU5tY2U4bWovOXJaYmhiZk1J?=
 =?utf-8?B?Qm5YNFhCakJka2V1MzN1bG4yTVFyWTNLaWhXSVpiVlloMUJ6UUFaa2JjZXE3?=
 =?utf-8?B?UnY0YmcvRmRvUS9ONVkxeFl3TDJ5blNWWmNOTThnSTducllvS1kwdnVFMHo5?=
 =?utf-8?B?a2lJL3ZndTQ3bU95S1h3MHovS0tnOHhaYVZIZGtXdUlCM0phY0VoVUJRcFh0?=
 =?utf-8?B?anljV3BoS2V0UU1zYk5UYzhSaVpHVnFCcXA2R2pFQ3RBWXBGOTNUS2x5UVlI?=
 =?utf-8?B?ZHVQSmJQZDZxS3ZKSy9XZWNCcEZkaDRUL0R5SUsxLzJWZmdKbkhPQUIyN2cw?=
 =?utf-8?B?elE2U0ltbHJUTzNUUlpsMmlMRmVLcEtNOUw0MEE0Y1NLK1RUU25vQ2NybUdV?=
 =?utf-8?B?YS9hR0xlSlJ3cDNtQ2V2eVlkUExrdHNaVURXV3h0dW1WZnU4Y216TzEzVUVQ?=
 =?utf-8?B?TU9rdTFoYjNsODBqdlNZQTBkUlFYcFBtZWhNNjBDVlVLV2J5cXVIRGZjRUVJ?=
 =?utf-8?B?VUdQMmJuYy95K21DK2w2MGp4Z1JHR1BGb280ZkYxdWtSLzZWV0F3N2ZodkNE?=
 =?utf-8?B?SFdwKzhzRW8zcmI1QlNneUtGRVRaQnJWNUJmNmZIQXRDWjF6c0gxWjRwMjA3?=
 =?utf-8?B?MWFJSWtwUHNVMmphbWt0Z2FLaEJ4UEJMZ2kzb1hBNG5EVFlkTGI3SHVwZHdP?=
 =?utf-8?B?UktCSm9NYS9vUlZ6czhwOXBCRHU4RmRKMnYxMkZPZkd5djQ2QXV1YStxdjF0?=
 =?utf-8?B?YU9aeFYrTEVWVTg3MHI0RjV1VUg2MWxUM05JZUpBUzVsWWVaSjdvbE5Ybm5j?=
 =?utf-8?B?VE1FbmRFZUNHMnEvcW1SWUJOaEhjeVRUYXJ0b3ViMkFveW8vUzVhRkp2MU1P?=
 =?utf-8?B?ZzZMUTBubzAxM3Z4VEpWbHdFcnJKdUc1UlQ4U1JzVnRNNnJXU3Q3bUxDODFB?=
 =?utf-8?B?NnhxYVB6TkNvNitKVmpwRGd5YTMvcGR6WExnWDZiODBxUVNsUC9JQ0tEMFV0?=
 =?utf-8?B?WmMrZDVzUlAxNTJCRUNoRW1ZRjBab2NLNSsvUDVLd05YZjgybG55cm9BWXRt?=
 =?utf-8?B?M1NqTGViQU1VWEdyWUowU2FKcDlUeXJ0Wjc5cWpFakx2TWlnWHJrVkV6NTlV?=
 =?utf-8?B?TkdHZkVlQ1ZCOVBtcGFRaUtQSTBsVVdaK2RQMWVTbTI1a1dESUtxd1N1UVdl?=
 =?utf-8?B?TWdWWFFJeHl2YXZPT3dNMXA4UzVxd0R3VU1VOE9DejVXTWxFL2ZHV0htWFd1?=
 =?utf-8?B?bnIwbWpVMWxMQkpGM2tTa2Z4OTR3Q2ZzYTc5aldpY3A0N29xVzRidndBTzJB?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc7c52-739b-4a3d-47bf-08db7dec4f03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 06:43:29.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/jCUR8Qr7mu8iZFtwQd6SHKSjeS4zSUMPWD3UdQiJFlc1jLDlV7OqrEIKqoBkx1ax+fO+aPToyirB8UKFNFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7713
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 06:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12251

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=7&day=6&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/06/cip.2023-06-22-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

