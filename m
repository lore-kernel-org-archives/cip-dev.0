Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5AFEE14D4
	for <webhook@archiver.kernel.org>; Thu,  7 Sep 2023 05:46:36 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.80])
 by mx.groups.io with SMTP id smtpd.web10.6989.1694065589207330621
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 22:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RBaYWGo4;
 spf=pass (domain: siemens.com, ip: 40.107.104.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRsYBikSnnabDNkeLjHc+6523PS1aRNkoZNwnHNpK8zejPHi8I0V6o8AvW/ryMhxRozaGgbe1aiFLz2UFdQycCHnO/BJSh+FtEH13uc0gZ05Ra0kK4GP3feZtTZ9jmxK3spq45ZJfn2oZAQeg2LJECUqiKHM2mD8ORQhZs/EvMOn8qpp4AEvy0JIYyjDApxhg4WTdizGXB7QSJmefm3SVqqTJNV5FsMs5ucud7KCFbHimd6kEhafaTZseYE/1T5mfIChljqHBQyrDcTdaXGKIvYL7BL6e9GMhXBpO0u7ei/f2RnMpHqjCb7RihDvKTuyk4Ulf6/+MWszk6BzR+xVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHCXpfYfk1LnwkxTg8q+6460eSl9l/3KKhfAHffpe3Y=;
 b=GmJX/07WqjO/lQyz2O9fI/ALRBySXdnNGGefnQgBWjfPe6dz4kyDAxv92hdN2+bjt/4kos70P1XeLprDa91ePDIKbfel9vn8kTo4cRrwtydD4ffsLmAQGbHchDX68XNvc7jJUeho43yFNQS9AAD5Jj2eqPW3GJdh3XigteKqMWsN+9nLewqAQWTXahn8pRRPg8hgKHCenZ9RamFM1KMiDGTOEtJRfiMWsgPCXP8OR6UK6fIGLTOrY7Coie039FFNb0z6n0eY56bCga1tkr0PZxBNIwNiOTU5/FZK6/7xhaOQRr5nwmaCat0o5ZHwqQeaRW5UsFWo0hFQbiRdUmZV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHCXpfYfk1LnwkxTg8q+6460eSl9l/3KKhfAHffpe3Y=;
 b=RBaYWGo4gV0tXrymqV6VtSEEBZ8AlxZW/dsu6tT6+iJuxB1UzzSy0z9uCPUtUbundFHe3WiOA5T05UBNZEzt/z3fnvQzNf7bB9UdhfvXNH15LyKRowjzlIx+ilyJEntIGJAVQhT36jhp4rEIjcLtgMiJ0nsxyRRD6CJfJKWso3RnV0dxT766t9l4T/5BFgDlP1bqnuGXTCxh+Hlntp1kXVLa6e8XZHBtqwFBUmqP1gin9bJjzygJMa9a6yM/13cKNftwnLew1mJ7OJuNhB2T3FJAY1rZjdGrN+7xJQJHJn8PKeI0cA+MNwOPUTJdRAGe3RtdAwZvZxn7muj7bLqv0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 05:46:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 05:46:25 +0000
Message-ID: <261b35bd-3e2e-4841-a6ce-b6e95479c131@siemens.com>
Date: Thu, 7 Sep 2023 07:46:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 624d0b6d-1585-4740-35d4-08dbaf65c640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vqfPQbASlJNKMtaHIHHzYVibspWMqcB9hLBO1eD7gvfdlquFuWfLAgvNStK1pXFpaYYYvRgSIVL6PYgueYrH5qosISyhVNsjJUCOzOaxoxs+oJRtHLyOC6FSjCHO4/zCRrVbXAtBq2C89D73+2BPQ0TZvvVydb+QuUdWNogXEZmOkKqhNiPsEdeY5brxLHt3oRLhBulTYtDYLHXP7Jw1SU8bh7l8IIBJL5aSzhDl6XEeCmh++z4fjFYR6eKTx1s4H5kTfsvDBUbquZXJLm+4kS/lYDR+K1bjp04ZhwBsRVnxK/V1I3eoHqPzvbm2XaN1OCYDd3jz541IuTEIXOFBiVunLsd/IYA8poj0FAN9eoCRuyMZCikih83JVvLiOUiMpX4DDquJnV5m+WlIY+AK54QR3DwQq9NZR+7opSn+6B41RPEgazOLuuGV7VysGZRptvyjnfr2q+YfJ9khTV1clmQmFzkhoOCLkiWr/ZP1TE0j0qFvDThla5OetUN80uEeyozeLwHflgyH4SetyYoMPZWRt7WwrxIHvqvvLEJIJkmxVeQeFGl/4k4H7JPS0AnuEG+CqstymtX6NPT46zQVg9PCDGWbar2n8yHiQi5KNGkY+YM2Ytsw8nNxBqFeSe20P7ajMsBAh48f0cv/biDhug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(31686004)(6506007)(6486002)(82960400001)(36756003)(31696002)(86362001)(38100700002)(2616005)(26005)(4744005)(966005)(6512007)(478600001)(83380400001)(66946007)(41300700001)(316002)(8936002)(8676002)(5660300002)(2906002)(66476007)(6916009)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHU4c2ZJTEZENDJ2cE5vT2ZHYzY0Y0hTN3VmdTVGY0JoNTdCRkdndHBYVUcx?=
 =?utf-8?B?bEZKazJOVEdESUdKa0hwYXZPbkhlTWFLY3A2UzN2RjEwZVk0eENxU0NieS9J?=
 =?utf-8?B?WjBpTm95N2x1SWF4eHkwdFJaUzErSkFMSnU3em04NkhEZlVmZEdFbmxSOGdN?=
 =?utf-8?B?dUxlbWhvY0JMVE12aWVCeW1SekVJWHIvQ3ZsZk9iUDlxcWFKZHBVSll4b1JN?=
 =?utf-8?B?Ty9UUUNNQ1NQd0JiSU5rTVlIK2ZZckVkYldvME5tMUl5cGVySkZ1NjJ2NHYx?=
 =?utf-8?B?dHI3Si9XR2pDUWltYkpBWDNDcHlQREdoRlZGbjd1ZlJpeUN1YXFSQ09qd2Z6?=
 =?utf-8?B?YlY2OFRkdUFNSTJNYTF3Y1B2VGdnRVlJTVJFdzVzUUl6VCtOcEx2aHBGb3Zm?=
 =?utf-8?B?WEVIWTYybmxDeHBHR1ZMcmFYVlQ4N3dlNGVobHFVeDFPVlduQUJpb1IzSUpQ?=
 =?utf-8?B?R3orYWEzU1dlWG15RHB0SmZvbTgzRlhHYldyZ05XNitSaC91V2o0Uitrb0FM?=
 =?utf-8?B?Ti9kVzFhRDNGazFSckZFOVk2SERSbkRUdFVvaE5wSGhTV1NWYituKys1eWcx?=
 =?utf-8?B?WERsa09QYVMwZHk1WDBQQnBGWmM4UVdoSERUUjdSSXRMSDZGT0pSbDg2Zm1n?=
 =?utf-8?B?NThNVWVkMGo2QnpMRWVGV1prdCtyRjNUcUNHSUp4UnUyRkdtQy9wRlhOLzll?=
 =?utf-8?B?eXptMUNtSE5tZk1icFZwVHdSTitvYStaRlhka3E2Sit1V0orbG9mYkpoU0g3?=
 =?utf-8?B?aHQ1YkFrcjU1SWUzZTFwc0N4THMycDJPaCtVdkxZK1l1N0lmUHNmYVhFTU9L?=
 =?utf-8?B?bk1zNGFNNEFxVS9mTi9XRmN5MStxSWxPOVR1Snh1Y0RvRUVJcEFrSUpEYzFM?=
 =?utf-8?B?S1RoOHEvUjZUOFBjWmU3ZUI5U3NZOXlxZENocG5EK25idTA4MFNqUWp1eFRK?=
 =?utf-8?B?eWp5Wkt6a3Z2c05pOWo2WVRYNUtXMjhxTUc4Y1FDOWQ3OCtwTnZ2UVZMYTkr?=
 =?utf-8?B?cVpRTFdVSjNsVXVnT2NPc3FiK0txc1owVHpYQXdGTS9zM1NaeCt6dlZLclhL?=
 =?utf-8?B?Nlk5UTJyUUwyb3JMOUo5UC9MMFEzQjREMjRhcTdYbnB2emVWZncydDZlOU5m?=
 =?utf-8?B?aGIwWnF1b1ZzZHhxMUpCbytJZGdYL0NzSnZIdEJGVEpseGVTZmFlSm1hU2J2?=
 =?utf-8?B?bkxOZ2tndExnZTRhTDMrNGhxbElscEczS3RzTzJpK3dPVkNqQWRhZWNVdUJP?=
 =?utf-8?B?Q250RDgxTkpEK3MvbWZiclhIV2IzQjdCQW5vNHplUEpadlRSenN3VFk2WFZp?=
 =?utf-8?B?OWNWcUx3SmFqd1ZFZTgyaUdtb2NJSHhlbDdFaStkVkhqTWhPdHRrcVE0NEpV?=
 =?utf-8?B?Ym1KYzhjdXI0NjBDUWRKVldCb3lGMXJKK2ZpWUxBQjRSUGowem1WSzhJUzQv?=
 =?utf-8?B?dFhZNk11Mm44TWpza2thWGduS0ZET2pPbHVjNjhPOXpZYmdHOEZ2MkhlOVp2?=
 =?utf-8?B?Qm52TDVHdDV0djNFa1oyOHRrQ0tlMnJEeTRqM1dRT21GL2licnF6eUR1eFZP?=
 =?utf-8?B?czBrYm5OVldXNmtzTUxXYjlCV2hXb00xYm5kOXRwaHA3NDJCTkFIU1U4aFVN?=
 =?utf-8?B?MVlFV3o2M0hTQmNESnJwK3RwSFE1ZWRqVVlFdS9pMjIrN3RzaUpTdjZCcGN5?=
 =?utf-8?B?Sy9aM2U2aUVML1lmYWJIa2dUWG9mVHlRZDF0enh0bHNXZ1ZUR3dRUU1FN1Ar?=
 =?utf-8?B?SExHWGpPT1Z0WWtKMnNCQ2lQTGZDQm1LRkg2VGNSckI4aUFUelF2SDZsMGNY?=
 =?utf-8?B?S0s4N3J1V2NjeU9NRStUOWdDQ20rcFNUNlZGTjBBRVFFSHRmVzdXTW1vMnEr?=
 =?utf-8?B?aDBtdS9EbS9uVVRkQ3doamZzMkhyMnpTdGV0M3lsajYvMmtXM0E3QjcxV0JI?=
 =?utf-8?B?L2xvQWtmR3pibjJNM0h0RU5TWXUreElzNWxrRG5kNnMxWWwrVUJ5RDFHVEVE?=
 =?utf-8?B?U0E5VlBDT09jNitPRnRwcnhaQksvZjVUcDNIZ2l2UHNpcmoyRURKQTVzZVJV?=
 =?utf-8?B?QWUxWGlic2I5Z3JCTWx4Ry9BS0pqa21ma3BqV01ROEhBeHN6Y3FoZWgwUnB5?=
 =?utf-8?B?aXozZnRGYXFvZTBEdkJONXMyTnVvNlBMczNKbVFhbjFtOEIzV1dDcjdiSEkz?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d0b6d-1585-4740-35d4-08dbaf65c640
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 05:46:25.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv7bf4P4U4i8jwL5+q57d/Cu1CapElcEGn9qbG80h7qmtYZYh2U+I2H1fOYerse+pzki5irFShev4YM8fyK1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Sep 2023 05:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12999

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=9&day=7&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/08/cip.2023-08-31-12.01.log.html

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
  - kernel.org tarball hosting

Jan

