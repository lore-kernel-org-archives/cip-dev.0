Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08406C54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 07:11:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web10.49144.1673507455711146806
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jan 2023 23:10:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cSn2VlCD;
 spf=pass (domain: siemens.com, ip: 40.107.21.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW4+lomptJP/qUyfGbRigQ8Nn4+SNS2FHsOtSOm0qitJ+wkVt0IiRupSqJItYcZEeE/10k2tib7PiX0+62VvkTJdWtJgjlDetnvWZLLUI4XonPV0xJ5Gipzi2WzfC5chJbSFPOTR1UoV76VG4D2xP/EyQvTHYTqyAzLKrrLxKxliEgU9QZ39IKC+EJWfWR65UoSmZUh46bz3tJyvw27PmnYBtHXjwFs3ls76rAy8esSwBJivbFMzR+OEzxSuh9BorB1wWdLq/rYAdHhB4Jn+/gquZw4cwT3sUL3Qpj0rJvREA/T37xnKRjsNTQhOQWkgYM0O1DPjWGKfFA+eyA1xqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylCPlc6KwNsw9OIAxBZqMpuiVxOPRWCkHw7fWBzrjFI=;
 b=npZqPbN5ixpHPHNlda6pYQ6TPfgavNBRRqJqkvIL+bliUiAWm61rPmUEo5abt5wIXUoaBlSIkAJj3wX2SVH0j8SkdG6D9M6f3AmpJcFhg+z5sBVfmQt0wBnd/aeUhQoWqiAx00AGACSiFqP/ZMGmiw3/xaYtloKNp/+qPTOnBnA0xEtQxGt8nP0SCxojGBqPOR+GZGJ7jMHtHbTWSd06qHmc/g/AAuHfEayloJT57syc5giXXKuSkHO/HAP7BYse9jbuTgPJhP1anXNSpxest5cgvor4mf2hsF57wUUZ039MbuTSUhARVCD3Oy4/04FwCimTHiHKA0P+QSzeu1j48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylCPlc6KwNsw9OIAxBZqMpuiVxOPRWCkHw7fWBzrjFI=;
 b=cSn2VlCDxYgFHyP7XkhIqmSVtRmN1ViHDAFf+SZ6I8go31ak89qt2x5+Nxi0k6Apo+OpL/tp4il09gp+kvpf9sSIRwGhN0JJ8Hn0EDEHmzv7lpNm7Q8gMJNKi37hbN4s7fBD5qoVlcwmxJHM1Ir2TMZavsdt3ROCbXRfREfb/fV1T8d/pGsRbsARXfGbFBmD9X8r03qF+JJ6wlLNim2bDP5TIy4U2y0RZSajec+eJAdqx/dt5rycHGop6RQyQvV5yeC4F30+R1gi1dfK61mctWoUd90V4g4FJxh6Ev7vA6Zoe5tVc6J2ZvoYp3WLP2SAeg/2C35S91FxoxRu2RyO6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:10:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:10:52 +0000
Message-ID: <ce45cf7c-5e68-9887-a87c-ee8424f43260@siemens.com>
Date: Thu, 12 Jan 2023 08:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: b95cce69-d7e1-4f97-dc1a-08daf46c242b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q8GUOZvpZoLR903iqFsLquIa1fn3fMjvBLBxAYDGiwmMlJnV8mTFqvXoxqwoA9FDs5nPE+AXCDkIISBD6KKh7xmPys/MCa5DWEYEnywNVbwsGwjcFhsd6YXdzq8jRGKaix9xXhpuPwDbf3AZREaqWFlH49rJE4STucJGf4TFAbN7VcitCJfjKX38dyk3pStuJE6DPo0GOElX96TTkBGItoCEMq8VxVpKaMa77NBxH0bo6fKXVCouewe6Oq3nJHVqrKbFd6e/FgbUHcWmx+yVKhqSPHCqmwZagX11o5AYUd16rDxBaeP2U38DrrW4Gz7DG3UY/jCfrjkGJ9SHOLeS9P96S77aEeWV4SN36KsO7TWG8UeMMEYv0w5rgZZLNkJI/wppik+nquAqKF1wNWJ3YtvVw1WU4T7eGTtVhtjaZNOlYzWmrJyo8S1VBHEJ31o1q8hDImH8dYtL4lwZLKUqae8iI7SwYIcwB3AqG5gkszQ9t/uYrko8Lj+hQoE8Y34i74XpFE/A0KdY0PMCu5h6sYttCgIohVxpP0PenCywcu1aw9BvdWyr92Juc++D21jkVZE/lE0+cWyBBV+YlmACqsqS1Xg+n551d72B0HU62bbczr24Vj0qDlDUgM1ZtNdFjQXXTFfl1QAlI4MBdHw2cio4Q0nt8l3klxns8R279dGzjOjLsUI+L0Tvx+QZHREZzJdxHM3CJsDKYm4RlXJvICXd82AlmicYlt0niPOIQG0xLP45cFXJ9cdq6PHAax2TmxUDaA/rSSWkfClsSSNcXOcD6wLRdpeyrPK1T5ohv7g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(6506007)(82960400001)(38100700002)(6666004)(2906002)(31686004)(2616005)(6486002)(966005)(4744005)(186003)(6512007)(44832011)(5660300002)(26005)(478600001)(316002)(86362001)(8936002)(83380400001)(36756003)(41300700001)(31696002)(66556008)(8676002)(66476007)(66946007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjJNb1VBNVVNRHFCRUJZckNHS3MxUDE4QitUUHNVUjBvLzNJM1FrRDh1T3VF?=
 =?utf-8?B?UXE4WHFXLzlSKzVWcit4aTFuU3JndHpMcFNUaVArS3dHcWpJUlFVbnBZeFZR?=
 =?utf-8?B?S0RBd2x3RHUzRWdEOWhGQTlJTi90VmhseCtnc29OUi9OcU1INDdkbUZFWS9P?=
 =?utf-8?B?U2tqV2dWSGRrVllTRExVU0k3aHBob0x0MlJ3c1VXUTcrUDdPL3NvdkVJSkVs?=
 =?utf-8?B?WnU2d2NVVlhHOUswcDRoS1o2eXhjTGcyOXhtcFN6anRQVk81cUQ5anVhS2hi?=
 =?utf-8?B?WmIzOHJ4V2QxakdYR3ByMFBweFRVRitsUk1lL2pLOFBGWWtXRDV3cFI5Rzht?=
 =?utf-8?B?SFYvWlVkMzRWMXpxTHQ2UTRUR3JhN2swRXN4ck4zOHY5azF0Y0tUUm0rY2Ra?=
 =?utf-8?B?NGo3WnkyRUpDb1hqT0M2cVMvVVVuVlNRWUI3bzdTaTlDN0JYZFZNcjR3cVhS?=
 =?utf-8?B?OTR0djBETUE1MklhYVZYWm9VeVRRVkE0WGVnbVk4WHY3bk44ODFyK0ZvTTF4?=
 =?utf-8?B?bU9XYWRWd0xXc2RYeE0zME9sL2VDMTViTWk5L0xrU1dwNDFpViszaVFtYkl6?=
 =?utf-8?B?QmUydUJEMzhvd2JIWERBaUZWYlFOb1oxL2l2dkVXMHpQNTBQM3BNMVlOcFB3?=
 =?utf-8?B?UlhsaW9hQW43M21KYm55TksyYzdBY2s0NWFwc0luNHlTcmcrbEUzZFRCMllS?=
 =?utf-8?B?ZU1ZRWlzam52TUswbk44L0UwQmVQVzNTeFk2RnRXN29FRHRDQ01qTk1sSzBi?=
 =?utf-8?B?a016N1F6aWttaUd5cEM1M1JBNmxIbXZmb2lyZm9xQmtuSE41ZGpwM2dPd3RH?=
 =?utf-8?B?VFd0SVl0Z1lJeTRFMm1IZ3ZjUGZ1dFl0QmZZK3p6QUtBOHpLcG1BeFRTc3ha?=
 =?utf-8?B?WldBa1hDazk4WlcwTHp1K2NjSjhDUXJkVnduVldpb1IwQmR1M0pyWjBPQjU2?=
 =?utf-8?B?OGxucU0ra1VZSDh6QmxlYjdUN3hQYXg2U08xM3R1YUN3S2FBUUgrM2F1b0Y1?=
 =?utf-8?B?WVk2ZzhCSUN3Y2dTTE1uM3Npa1gwR0xtVDRKdnhqaWg1S2tyY01GWGhXZ1Vt?=
 =?utf-8?B?LzJ4WUp6VjloMTg4cW5xdkJPWWxVbGpoU0tkZE53YnpSRSt1U1BPaU56TGpH?=
 =?utf-8?B?LzFnWkdUQUltd2xMbVpHSzV2UmZuYXNNcTZHRWVmZzkzUTJrUVhUOWlUUERC?=
 =?utf-8?B?a0kvTStYRUNPaDNJN1cyczl1NlJkdXl1UVNzVCtMY3NxWEVMNnVxczR0azZ0?=
 =?utf-8?B?ZU9BQ1RzK2dyYncrL21PVk9sZTYySFdaV3A2SUxCemRnYmpRSTdWb0llRjRk?=
 =?utf-8?B?d09sWGtFTGxiSHk1NW5vZnluTjM2ZkFiMTBqWmUzcVc3bTNNQlYzZUxMdmhF?=
 =?utf-8?B?VUE0Z3F5eit0SENQMTRQb054aFR3VGpPcFc4cVg5dVUxSldMVW51SGJ3Z2l3?=
 =?utf-8?B?aXB0Ri9mV0UzUC92YlN4VW1wZ3VsZjdqdDQyREN4Wkw1amp4UXVWTkt4OXdZ?=
 =?utf-8?B?NzhEU3kyWGlQMzdFS211Tk5wSUNoNkdscE9UcVdWN3podUNDZkVUSmRYbGxp?=
 =?utf-8?B?Qmo3Wm43Q21Ta3BDMTVHQ1VZVlViT216NjZLTFEwQW1KL1c2OXc4dlUwVGtQ?=
 =?utf-8?B?cDN2b3hqNCtVUHE5VitPWlJyMllLQ1ROWDZQMnNhbXpkMDV0Ry9YV2V3TmVt?=
 =?utf-8?B?cDRBenhaemsyMWlBRnUvNnh0Y05PNnNYT0xUUFEyS2lpZG5GNjBWUGg2bVcz?=
 =?utf-8?B?cmJqNmUrSkw1ejZCb0FROE13OUFsL3RuUm5PWnpuT1k1STJ2NEdYcDgxZGlR?=
 =?utf-8?B?R01vSnZJamVmZFBHcmc0akx3MmowR0xmUjJNSCtKTXJzUGtpV09abjVqVlF3?=
 =?utf-8?B?VTJYN0NuekhJSDhLclF1Q1lhVUNhaXFxeEdaVFArN0E0ZGg1WUpnRm9QRnVN?=
 =?utf-8?B?YnZaQnpISkM0LzVwZW5mczh1djRwenR2d21HSkE0TFJiOWtRQ1c1YkU2Zzlh?=
 =?utf-8?B?ZlVJSGtkajZpV1B5YVN6NW9CREF0SGFVUnlkWmZJd1pPNTZVYS9xTm9iNG9a?=
 =?utf-8?B?UVFkcDR3VUg5R0FjaU0wNmt6ZzliY2FHaTErUUUrOEgzM3JRRXNLTVBsNXlB?=
 =?utf-8?B?Tk1WYVhkbE1YVkRIbHRtSGh6Mzh0UWp0RXVaWUt0c0dYTEk5bzNHMlpLa3F1?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95cce69-d7e1-4f97-dc1a-08daf46c242b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:10:52.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UpzmEWf/JA4oGhmfwNWGcCByh3Fn9fWw+y/d82UvnYs5vhfnzrUyg+p5jZRf78MUaA/ifBfXt+xSw/b74+aTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jan 2023 07:11:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10345

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=1&day=12&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/01/cip.2023-01-05-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

IMPORTANT NOTE: I can't run the meeting today (by now 2 conflicts). 
Someone else would have to take over, please. Sorry for the late notice.

Jan


