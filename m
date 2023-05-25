Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F2C7EE2C
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 06:22:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web10.5830.1684995766832482333
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 23:22:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Gf8H8153;
 spf=pass (domain: siemens.com, ip: 40.107.21.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir/RShy8k1D7xM4tcmFz+wzzxYRwCSKCe9HnMkuBSL1CyqBtZjppb0Ca2bqVCRBxo3QMfjGJfKD90w2WFtOreuiYr0rjamwYc6nIgMSNB4on32wjQWEiINRHGPe02UvPng9kbPVC5n3DzKHjmXCKG/Pm0EsBBpJsbP3L6u4ozsDxmLShNR8Iv6g+XhFv+ciOQs3VTNmjgM4CsFaq0y5X8qm7R9nnQHrfCDbLZzeLF65QBiTTA9PRTHnVO1o0ZLhU2uFU1SIJ8S0P9xwAGcPZsQbbtfsswRHZjDAlcY/yidwjJEC/ZL4CWJrCmV1GSNhBecxQKRfhN1QVQDBhSxra9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z0SvPiQMsqKIIUGhKP/lyQkBaJWzUpgtNS7GdX+3GA=;
 b=JX5nPwKbJxhIAj1z1GLEN8B2/Tfw4SUalX/IMTG0QdNFRTcpFIJFA4ELRYy7Rs0Zk45NAvepv5m6TGr8A8wXeDqXyGfKErADwr/Afhl5V1a1u9njXq1V0cOai39ELyouKo5wdjQOy7XY9gh1WYFGa5rESaS1GIH/TcG+Qk+RZfWGlOv+FAHYJQU/wR9HZnunoK9Qw6UHXfV+MmGTNSRHuo8XctXgxp0VAzuPQ0VFQ/Gat+4SSbZj92X4EsVTrlrZshisfXI/yomksOGQQgPhjKRIXnvipBXEO5BXLbSHNkSG7jKvrONr/+GpDLBqApxXgRpga6lcyhlLikh/6YmZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z0SvPiQMsqKIIUGhKP/lyQkBaJWzUpgtNS7GdX+3GA=;
 b=Gf8H8153NCdjvAqVqYSlfa8RD2fqAD6rKpD5dFr4oeuNc8WlE5fNVXzAjUYGPtHYZvxsQ0AELyHNKrHxf3yeILhABYuZ3InAbAdq0gAY+MnGpNCkyHZ4ZZbI4GoExdwWWCqtQ7/84r/bJhO1NAW9V/vVBLq8pxpFxJJiJWYzzJlNVy5aMNLVIMk18PdruyC5Kt7kv1uOhJdz60wDOTnxonaJbzqBevD+I0w5FBiIk5LtytcwkOsXyVw/vcouZ2DlKXs0NKEmM3Sl0PbxN2P+CPitcV0aKQ/tOoKZg+zR9O6h9i4il71bCsnb8Hab7RgQfXJsCb5pXGrI8ul8QuQn8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7407.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 06:22:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:22:43 +0000
Message-ID: <a499735b-f1aa-e7ef-74d9-e29a0616329f@siemens.com>
Date: Thu, 25 May 2023 08:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd47ad7-47ee-41ed-010f-08db5ce872e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h7alJjTt3EHvpJ2/88ptxf1zO7XYNax7n2CgrwDpParyw0YZ+79FjSSL4p5AkZKQF7O943+sDgKZCVTdFtrnFnJt+iRQocuw3/I1taD1tMcJi7e38S4fMwadnQF0Z8CJfAH+/9kIwZq61G3LgDWgPdoS4w2PhypXterq5e4DBVVmNEwC1ZPlRpFHqZngVfawnvqGrVIJgqrPZjXHKrc3FIuO40HWTnvnVFK2z2hGhvaWxhRI+y0l9eLk5rlHd2GoWIxTrzeoPN7WI6ruknbKraFA9duMV+svxTFbo1ZCTAcbWVW40gfE8nJveCv+F/gLk8sdboBqQOj50zCeOS5rnLRXE8KR09qVeddMeUDoioJRkz41JOVewQV13/qi3jPjm7Ib8h6sOEGz3jFmExt0DgNJd6HGs+T+h5MmkRH3HHDcBY88y7TciBQfBbL7c1eryA4FhqF2944mHXqPV427pDRC19I9180GRBoV28GAHM+BbORqnuoPrilRLkQ04uDrNt2Pl+w56i93UdBBDXs3NIlDpdePP2d6451ZWVUGMxj9V5t0zp3kiimtlPDo42QAHrbpXYzd3uLeAfQmSJVSstpZTbfvJJ5k4D16vuLzU0ko9qK2XxFPk52vP7ivV7Ca1Jrt4gnFLO122AvL4yWG6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(2616005)(6916009)(5660300002)(82960400001)(8936002)(8676002)(31696002)(86362001)(38100700002)(4744005)(2906002)(44832011)(83380400001)(316002)(41300700001)(36756003)(6666004)(478600001)(966005)(31686004)(6486002)(186003)(66556008)(66476007)(66946007)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U25pSWp1ZFpNU1Y0YWpRTXRSMllvZFVnQXdaeFkrdnF5aytZNkZISUMyd3Nt?=
 =?utf-8?B?R3F1Z3J6TUsyVDYvS1hMWXRkcUxFOHRleU1LNTJtQUF4aUNPdm16WkJKYUdY?=
 =?utf-8?B?T1pqdXBLdVorSkV4WXZKZTFZcm1DTmNiRzdWUVljR2pZeC84SUpVWW0wMkds?=
 =?utf-8?B?cmc1Um9CWmJ1djVoeXhucFRhUC9EUkN0TW5mZ2FoQkx5QTlwcVBUc0ZtZnVF?=
 =?utf-8?B?cDNGZEdHd2EwMFlDZGJjWEd0emEyaDJYM2R2WExFOXBXWXl4YjBKOGNDSHZq?=
 =?utf-8?B?eTdvcVdmd1ZUcGM1ZlpvN3l1QmJGSi9oL2UxMHFpSnk2akMwVEZwcUZNMlJj?=
 =?utf-8?B?YkpjTG1mUHNtSms0TDBrdlk5TEM1L1ovQlAzc1hhZVdLYkJxbmRmZERpU0Fa?=
 =?utf-8?B?eTFBWk5tSUkzLzhTajh1aXdZcUhXY0JHQldJUERvWGthZXZvRHZTSWc2MTRR?=
 =?utf-8?B?aEtpV25EUm5XcitFbGhiUGU0d2granQ5d0ZuS3l1RW53SU11MmNhU3EzblY1?=
 =?utf-8?B?VVBTNzdab3VhWGVyRUMzMjNRd20zKzM2UlZ3Z2w0UVJKdVJkS3VFeDB1OTRR?=
 =?utf-8?B?Ti9UeGJjamZpNkRLYURucXpScGVnSWtaYWl0M1JCdWxTbDdaLzN2VVU3Mkpu?=
 =?utf-8?B?M0RxSjJTSnhiVHg4SFlkNXlCekpNeE12eUJPWUZRRnlWSjFVcDlhRktveUJ3?=
 =?utf-8?B?QWN2RUNEQXV6WHgyaVhlZFhWWGNmTVhDZG9VdnYra0dEa003MmxZUzI1VFpu?=
 =?utf-8?B?dGFKaVZNajh6L084T2xUREw5QWJnd1gxWDdJUU13clJDcWJqU3lJbUpwQ1dt?=
 =?utf-8?B?TlpqWnRjQ0pkTk11cXJGQnBMWTFkdnE1RllHa3FiWWhLeUJ6dTIxT2J1TnhY?=
 =?utf-8?B?MFlkRHZ4RloxeHlicWZPZnNxQ3V0K2RRcnFEZ1NWNmY1TjlrWDh5Z1JXRE9k?=
 =?utf-8?B?bkpGdGVUMHZTM1R0WmlQSnYxSWxqUGVDRTVUZGQybXVReEVpUVZldC9DZlUv?=
 =?utf-8?B?QThRNld2aTA3cmdtNzgxS0d0d3NBWFUvN1UyU2F3bDNOMlRVWEwxaUR2a3lB?=
 =?utf-8?B?VGNQOUNrOWJiK1BlY2VNQU53aVpWZWZMdnI5YWNFVTUzYkpmUzNOdndGR1N1?=
 =?utf-8?B?bVgzQU5RRXFjZ0gxZnJvanhxL3RUUHhxekk0cTZkWGtNcDd0RHZldGc1M0Zp?=
 =?utf-8?B?Q1ZkdmJERW5UeXpQd0Q2K1hHRm4zWHhHODhZRHVKWTlsZXhMNG1zYkpRWi9C?=
 =?utf-8?B?a3lsOFkrOGNKcjRCTm1vTGdEb0xyUFJwSzNKY3hlaGtvZzh0eGJEaStKTTAv?=
 =?utf-8?B?emxySUNWTWo3Q1c2bjgvUXUrZmhXeHg2K216N3hKYmtndGYrejczOXRCQnBs?=
 =?utf-8?B?VmhONXVLM2F6Z2xmNGRaVjFiaUtjMDN0RlNWRnRscHhHMUZrYklxa25jb3cy?=
 =?utf-8?B?WlBjVlM1RjBjNXBpSzlxZnppTXI4cTlLY2dNbmVkNWRDbHovdlJ6bkI5dTNK?=
 =?utf-8?B?VTZyZXRhMUhkd3N3NEtUOXp6bVRkbFJVQmI5eFlwSi9pT215TzR2Vk94V0Np?=
 =?utf-8?B?eFZZVGFEN2xrdUJvZHJScFlQWGVuQXFjdVg3aWwvTnlLc01wYXBvRnRpb1hy?=
 =?utf-8?B?ODlSNDZhR2twY0huVE4rcUFnWkdxcXA5Vm9JQkczSng4SFBKemVzZFdJSE5x?=
 =?utf-8?B?Y2FUalUzUHRTUmhrK0N4czdld1V0M3ZPc2xNRGFoU05zbEg4M1o3T2NRcXps?=
 =?utf-8?B?MXdDak8yNnFFd3dWb0tKVzdsdE93dGdmWVJzbXpjNW0waEFrMVphSS9mYnFF?=
 =?utf-8?B?d2xPajdQa2RJL1V0ZWVYTlh3Qjc1WWp5WE81STMvd1NpYmZJdVBhQ3kvUk9J?=
 =?utf-8?B?bFV3K1JESEZUYTVzZUxVM1Q4TFB6VXBxekp2ZjN0YzU0eDhXTWNleEY0SWRC?=
 =?utf-8?B?d2tRQ2xyQkswNnNxMEhBRW8rYVhvaGRHdDhtRnB1Mmh4bHhaZEt0RW1mMUV6?=
 =?utf-8?B?VlJRMUNrNXNPejZYUGIrclBkRTZKOEtCZktzUmF1bnNrNVRlc2ZkejJIc2Jk?=
 =?utf-8?B?MkFRQU5SNEFvVlNXU3lFVkRHaUw3dVhiOTltN1AvSms3MnAvNnpnWWtBYmI2?=
 =?utf-8?Q?ibMf3mT/Qul2RBYWnh/2qL5p6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd47ad7-47ee-41ed-010f-08db5ce872e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 06:22:43.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOHXEJH4zEAvlZh+9TAFBgvlhqI9dnuTz6vApEPfG0ZjYFwxZD7g50QuG7FeWku0Saj3MagREGOZ1ZHZ2XW7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7407
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 May 2023 06:22:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11646

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=5&day=25&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/05/cip.2023-05-18-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

