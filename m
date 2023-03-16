Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA04C6FD19
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 07:27:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web10.6791.1678951619602978437
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Mar 2023 00:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RD0bVJMR;
 spf=pass (domain: siemens.com, ip: 40.107.20.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnqJAdGWf1BCKlL8msM9DMMg1VsW+KVKyIUMge97dIGKp9zEdopblz0Wthakm3zWOu1Pnf159NusVA9O3QSv8VlXrNWKf3tBIxgMfFsHtVdmKsSPzWFj50iuuAAtpZ/iZikq6099OoluomEf8mOi1L/Tz3kEZBXw05eHsUtlfOvjz5vty2f+5hQw0Or+pwg129LfJEWuy8+bW8z86kSbVfxl0zCz0TzUiQUBFlzm8WeugfeO7rAvPpUSnvJE3puinM21DTg09E+EyWUppERLt6ETqkucuHWNCt2KhBizbtGbQfw+b2cunP0dx71XKeEzDBVw/qsabjbkG4Yr8eMPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8hhVSqclQA0/Rcl1oomy75GUwf8m/ZzubFDhHT0bNo=;
 b=DqUkSH6HLyE7CFKvylX+xSijIMepCz+8C1HBMfj0KjwBWvQP7PCc2nAk7busfUYBQca4vRmTtg9tW6wYYIS45m2rk06dlWd70+ft/c8tOoua3Yl/BlEo2+SU8sYzMY2REciXdQTuj0feUzYhZ7lIo6fhU2A9Tb2/I6wP/TdCM7blridaIoNkSegOMDK3nQ1PFln/SkcaXyAo9IW4iydE6evDz6fhBz2uZWvqWXcODD4pDyompjGGdbA1hVlzVSCP6NTsCS0EK9EYPTF5ZV7UFzTu6IFVaWEHh+Y77m6xpd8Mudr5YKD13N2rDVFAJDslxafQwiuEx1l6iAo9Q4geDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8hhVSqclQA0/Rcl1oomy75GUwf8m/ZzubFDhHT0bNo=;
 b=RD0bVJMR966fb3n6fJ0+MlFIMpRPojq6vmv436CbQ7s0soQrFmBu2Np9cQoFje6kZMPtYYdaWouXbQ70aN2E1FNkJ3hQmZ/s64O5fZxVSM1nX3HGL5UuAHJRIfOqxPD619GtFlSfqF6tzDXlOlh7qhYp30js8BuBea3l6+kDIngo7DFro81lxZDB+utsAP6rimph+hixFTw9ba4SWh0QvffL4N53OT0mnvE0Wi+ts4WcGAwtAKQc/34EFa0gMP75AJNCBqTYlYyDvBxLj4XOCXGuXunYq3pSLzNZNNE39JZFjm7EYrLheheXxhQdECVJueUswSB3nhsnUM7RfUVDYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 07:26:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 07:26:56 +0000
Message-ID: <3cda366c-3b58-291f-42f2-4e8bb6069aa5@siemens.com>
Date: Thu, 16 Mar 2023 08:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fbc41e-07a5-4a30-13b3-08db25efd2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JQSmkhT+egV0VzKbqVqisQH8IQs7hmBBaYDxUiMZ0p3vKuv7bKuFb//w2MGxo8FR3+iHgfZjG0v7xEz45kxgvvsa+dhPiBDu4asmsxy9vS3+rcL2LxjnFhedoeN6tHr5Lteqvbav3VHw7DSABKnHZArjY9lckkt+inYqtnbt1CKDNeMjWZ4SZi164j2Q32HKPGFjxo8/Y1OfalUXOOoJwaiwhlftpbgQI5nGF5ZKDWPde3cKs9dneAelIwwreQ9286+FHT9iBBJ4/5AnpLEOwc6k7rJKIEhcAQ7K9DatlqPMuHfD1BaYbv4q81USRRTNBn/SGFP8DA/QplsCR1qpWm92hIrRjdd0HIcFJmFfpFau8OVGuZhy4BdQUsSEJLe09CGk9BlBJqeMG7b0HRVKwZ+9srG+xfntk6baTzEtoL7FHUuv4TkNAwYn9PDngvO10RfGa/hzTGLvBn5FTcqF+s3BiFNrNfboiLossk+sNlGdsCaY6wBt/KRwBlN3zQ7gYeO7INHlTLA92ihf+CNaUNASDT0ROnVOoAv1jOEDP5xaADDiUaRErOdwPy9riCCVD8hciLRre6k/FL5ZNi1nxu6AMS05dUeNBeGmoD/G6/s31ZQUxTMkJeYUhfZtHOAp3rtKivAFk7wFes8K2EdvRrmHyjaNatUse4/JF8yZ0FyZIQMtzHdi7O2hRfr9r6bYNY1skOn/BxdO19+nFYFDsS8RjJnddxayxGQLDkOj/gX43BgssjPRHHEBOiLbxW8j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199018)(5660300002)(36756003)(41300700001)(66556008)(44832011)(6916009)(4744005)(186003)(83380400001)(31696002)(6486002)(6506007)(6512007)(478600001)(2616005)(966005)(26005)(8676002)(66476007)(38100700002)(8936002)(66946007)(316002)(86362001)(82960400001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0J6NkJTNmNXWnhpYkNwSERVN0hjaXRIeXVCQlBWb25wZ2M4ZDRobWVoajhl?=
 =?utf-8?B?cy9uOE5hM0JLUDh5NGxLV1MwNGxpR3h3LzJGOCtWdk04OW5OM201b2tEaEtk?=
 =?utf-8?B?U2hDSFZhcE02c2hVR0VudFdnVFR2WjZESVBxaFdxYkZtZFQzQkhscWlKOEZn?=
 =?utf-8?B?d1A0eUo3cjZSQjRlMVZYQ1YyQ09iMlcxYXV1Nk1Mb2IvSzVrMnNYSjYwUzJn?=
 =?utf-8?B?SkhpT2ZndFJNcStJcWVqUk50bEFaRlo4eit0MXF5QnFheWsrVmczUTBzS2Mw?=
 =?utf-8?B?aUdaM0QvVFFQNkJidTU3RnZvSFJUekNNNVV1aFFXN1daT0dId2JLOTNjUzha?=
 =?utf-8?B?b2o5dE50RmFLRnl3cVVTM3BiK3phUk5VVHR4MzdMSERuREw5TVFyQUVtZVhU?=
 =?utf-8?B?RU1EMzBUNWUyMWRtaVNOU1R0M2JtcjVEMHoxYUZiNjA3OUhJOENnNkxPbUdt?=
 =?utf-8?B?WWM3eXcrTEVrb3NpVnZkc0lCUm1YMEpkbjJWNDJET0NHRUNyTWpNeExDSUdR?=
 =?utf-8?B?SVQzSnlubXY3V2MzOTNDa3FaZTZPZFVUV0ZTOWs5K3M0UVZHNHdiTk5kOXI3?=
 =?utf-8?B?eTJaWUtoVHlDSkt2RE0rWk1IMlJXTUdTd3pWN3ZqdGxIMlVFeStWN3huVkRm?=
 =?utf-8?B?c3RwS3VUZmhQSndRYTU4Y3RIRy9ld3BYbGFSUW5NQlVWelBQNXFoZFB6cnd2?=
 =?utf-8?B?U1JBUjZYVWJOOWNLdUNqUnZ6RjhzbWZMemZlcUVHa1Y4c3M1YXM3Q3h6d09U?=
 =?utf-8?B?VWo1VXJzOGNwQUp4eWNDMTBPLy9Jc2orUzlLQjN4bmN1UC9JUDVEczRVdjFa?=
 =?utf-8?B?MUdQSHFHemc5anhhekR3TENPbVBIaEFEMy9ORE9uTy95ek5wbDc1MnIzK2dx?=
 =?utf-8?B?SFpzU0xZb09TczdhR0RCMkNpbjJwTit3ZU1rNGorenNmaGdWUjBkd1ZtZHp6?=
 =?utf-8?B?akU1bW9tNVB2bmNuWlhQVXh4NklzdkhmUURQa29ob29XN1pIQnArUkxGemRY?=
 =?utf-8?B?bkZxcUhlVVJSMTdtbVRrTEdUTERRaGNSRHVUcEU1OGl3ZlRNU3Znd0tiUDRI?=
 =?utf-8?B?LzRDd0ZHZEdwK2lzRjlEaUg5eWJydzRHcmk2bEdpNE9lR2pFcWR2UDZlaUcz?=
 =?utf-8?B?aUJHWkhsV29wUmVRRTUwYUtCWUxVU1JFemFZQ1d1RnJCRC9wZlFJTGs4TWQ0?=
 =?utf-8?B?bGxiY2Z2T0c4UHp3OWF6RVZnNXFtSnNEUDhhZjgvWUhpKzhaekJlQ1FXMHhX?=
 =?utf-8?B?M2RrKy84dmZERnM1R2MvUkpXR0FpTUY3SFNiMFhHYzEzdmdwWkRzcjg4TGwz?=
 =?utf-8?B?SWZPQjlRa2JnK1U5bWtjMU4xQ3JJOVpLTWNFMEdYQ0k3N2UrQ1VJUmJScHFD?=
 =?utf-8?B?NURGRDZoOTJWMmRtRTAvZElQbWRUUVROUmlhWCtYc28yVEc3d1JVUFpFQWFX?=
 =?utf-8?B?eW1YQ0IrRlo4aUFnWTgrTTREbGpwdk00YjZZSExQWW5BT09ra2RNU25mTEJm?=
 =?utf-8?B?UTNNYWlFZDVIYm91czAzUFlzZHBKRThJd0tDbVRoZGFGWFVYNFdNWXNBUnZj?=
 =?utf-8?B?dVFBRE5TdEdEcWkwNE12ZVBnTCtFNmFQeDZycW9pRWxUYnZwaWlSTGJXZ3or?=
 =?utf-8?B?Nkp3MkFFbDRyenRRelhxcFFsWFBDeWJzNXhIby9HRGpsQjBhTnNzNXVYU08z?=
 =?utf-8?B?QXo1NWhYNHc1VmowNU5FRFhSRTZlRzZSYS9aV0xYSjdlSTVZbjBIYnRSckVK?=
 =?utf-8?B?MXVkTGtDZVY5a0tGek9PWE4zYW4xaTJ4TEwzT0dKUWNMMSt2ZlpjRDFuQWpn?=
 =?utf-8?B?OWQ4ZG5pK0swNzRiUGZRY1pBdENRc3NMUitYc3JGNk9IQ1pyRGdLRVZmS0c1?=
 =?utf-8?B?TGttVURJYms4TXZmeHNNdmYrQ3c4QmhPYVJFalFXNWVEalQ4ZjBEMEV4RDV2?=
 =?utf-8?B?ODdxM045cDNmNnZSODBBODh6cHdDaVAxUFJNWG56Nkp4dTYrNjY0OHhRZUF1?=
 =?utf-8?B?UHhXUWZEaDJsbW5iUHZiM1dZalRPY2pHYm5TR1liNUhVdzBzdm0zVWZwVHZl?=
 =?utf-8?B?cmc1OFJSVW5ET3NwSldGZ0FZZWZaK1VRcFNKQzgxSmovY1VndElWLzZmWDBB?=
 =?utf-8?B?a2xhRDRqREJ1dTBxL3ZlaVZqUEoyeG5OTElKa1ZDbXNHK1E0eFFGR2ZjSjFC?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fbc41e-07a5-4a30-13b3-08db25efd2dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 07:26:56.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pysCZHLT/42bRKGaGULHvEx/CTp0+fS8RNRG7UEBWQnlFagMqU4Ii7pdqHrFMxqfAzBxjYSuvNeb9RAbqX11oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5593
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Mar 2023 07:27:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11029

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=3&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/03/cip.2023-03-09-13.03.log.html

* Action items
  1. clarify usage of .sources files in cip-kernel-config (patersonc)
  2. reach out to Greg regarding LTS (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

