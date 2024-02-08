Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B75C4828F
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 08:24:24 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web11.13496.1707380656979714080
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Feb 2024 00:24:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CSfgXPG9;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJKg27J4eKKfjtrcgnVpg8LuXQu/EJEc0MtAZpLuVOPFn0ymMfL4Tw/akeIrc1G7wWEkAS2HQfyXya4ceEyfEPq/isykNIdfQuE4etpBkp2RUiiYw4b+GzgOHn3Cf8rP/vRZap3kxhRF+vHMnsoaw4/loGmi9DGFFSQRH4zWoF7De9OYNmh3r4Ap556lMXcqXCxuy0Cp0SxYcuwxlTZHfXNVzr4YFpsHohYEYQWeIjbpeLhyFHrr6w6dkU84kpcPHqVu921SFz+x/jOG9n7KxD+6Q3yuYMVvgmFbH5n+VA471Z9vOtjafPuSFiY4KF83JoPmjMpMcYVlMDSuoL8LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVU4TaIlpkOpfEX68WF+ULFUZTezs7tXuMMsQSfxPQA=;
 b=DrGDbogimjrV8rQsFtNfkXFcN/rNRvgnYTHi6Z4HXWIrm1if6i4s5sQ8YAZfiqDkCerVDHyTg1qwX//c7VD9ONKkF+Vgl5TYdVtqjOK61l8NASCgKlrFb/I6Pe7lniNg55zAQZYYl7QPCGDErdLsfk0JsEu5o34RaYhhvZl1ct4yfe8p/SwgYRewizT0ctIY9Lzx/9K1PLhGG86AnPPWsM2Z9Xuot01u+57JqSrHBNbSu5QMDvp7HpDAlVrfApAQhfNp5Q4Pll+PRpg0Vbl6MnFWdbvw8wIVwZlTJT7qAQpck+5mGO1zne4zk/DcH0Z45elWE2IYfP3RlV5R36PXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVU4TaIlpkOpfEX68WF+ULFUZTezs7tXuMMsQSfxPQA=;
 b=CSfgXPG9BT6InKri9k9Wi/PwUrKUqiC1KB6BU16KIHSeY9J7LuHEQonRJt5PTBtNmuTrSvofuCCFYPSa4kpHs6+hrXtPaMp0xO+AZqNn0sFgq11OcLi97/qLcHwl8K2Iyf/7psSb1L6WQJAw25lBIiUBsiK4zky1FZQU6h+R8Dsz8lg/8x1dYpRA2LQmlet7ixpvSBY+Dm2LNrPmVZD225/mFzdTjEDb3e7TuKgYQrussHaUCalhfJztC1s6O3NXqTe72OUJM5TD3VR3P7WcT+lzGfDAT0rRDsQpQP7LZIPKD1DoHEDqVEfRCkE4tOYzzU6eVe2bI88niUkeozxFyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:337::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:24:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 08:24:13 +0000
Message-ID: <d841fd8e-fe0d-446c-a82c-7e6f27751dce@siemens.com>
Date: Thu, 8 Feb 2024 09:24:11 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: f83c3c3d-52e3-4955-9188-08dc287f5521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y/uY/b6hbueMct9FvppvyRH35014LZP8416LOadZus+TjYQN1oBJWOmgdcMBE9y0cwDmIQpXHsP89DqDPgSOBsQLk59bm7wz+cmEpCTAHgnLx2sJN+WrGByVZtbR0FMHLwrRvX1srHgS87LvUexT+xEx+7dmk8RuyrWJr3ZmynZfaPo1I2kFQra+G8GwG1c0amBrfM+4loG8kw2lwnAyIPZm0P7ujfABPHgev9fxt5QpdxDvB3L7+NO5vNPiEEQHgDKMx2NHgqpOfWtkOLyvc+kmHre99YEDVUJiuIsHWSX9fqHjs/pR7HVm5RGDklLICywmbkXbj42n7R+ogdWKjTb/KFzfKIKrkbHBLAAOePkyO0TGgUBsTj4wGeqlVMcnyF4EooM1peSDJvRajuhi018fZJenMa/fv8AELlZQJxsXqdBgWK1B7DfCmCAyffCq9UzcbtnUxvJjRpVW2QpKw88lDCOnv5hTxLrzUEXAJccz9uAwkZlkw9MfdiMpMEHnAY6qjE9ULcH8t2N6YYtoUOSuc4VwerDcGWVbkq5vaUs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(2616005)(6512007)(36756003)(26005)(38100700002)(31696002)(86362001)(82960400001)(4744005)(2906002)(66556008)(966005)(6486002)(6506007)(83380400001)(316002)(44832011)(5660300002)(8676002)(8936002)(66476007)(6916009)(478600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFlBb0JJemovK0xsek56ZlFsQWFBNkppU2dRUXl6c2tMRnYrQXRoOHRpdDhH?=
 =?utf-8?B?dXVtd1FZOFkwWWhyZWJhOTlMSWlzeXo0TUNRdGhaR2NEcEo0WitHbVdXZS9v?=
 =?utf-8?B?VkVqQi9USEhoWHdwL25DVk41QnVWOE11ZG1JdXdlQ1BFSHlvcTh5b3VhY2xP?=
 =?utf-8?B?ajRFdkVWdmI0SW1iVTdMU1UzQ081dHNFempRMWdpUWx5VEZSU0x3MGt2RlV0?=
 =?utf-8?B?bTVYK0xRa0dxNnVnYTRSME1aUVVsNzFjM01laW5yUThyQ08vZXlyckp5YTIz?=
 =?utf-8?B?VDVheW5JT0RxSnhSWktGT1Y3eHNUQUdtOHNtV1RiWFRKZXptNkdIbW9BVnlI?=
 =?utf-8?B?S1dVVEdLVHZmalBzTjBZeGdnamNNYktHd0FtdXJIUzN6MGNSTkswN2hOWjNO?=
 =?utf-8?B?TExJUjBSSzJjbk9VVklTNk0wb3JUQm5tNThNaEtYL3JHOEo5a3RtSk1hSm1B?=
 =?utf-8?B?dXJualUrajZSR3J6d0ZBc2ZPa0xvLytrbGU1Uzlra3U4UDBMTzhFaFZxc0JN?=
 =?utf-8?B?QUxWUUZYMTExUWRyTG5jZVVwSU9oZWw1d1lRTDRCVWQvREpCTzBxbXlnQVBl?=
 =?utf-8?B?YktyUmtGcS8yM3VoYU9ram9uS0RQNnZmNVJ3MGM1NXpQRE91WVNEUjBVcFRs?=
 =?utf-8?B?ejFmbUlURkU0ZENNNm1vczJURG5VNjFNNlE4bm9tVlFBVFF1SXVJRUxKOHpo?=
 =?utf-8?B?QUo2T0NQOEliTDgvUEVydDB4VGJneGdNcDVTUXh4d3RGQmtzM3NMMUw3NDJO?=
 =?utf-8?B?WWlzaUhZQnoyZmZhd25UdTdWMWF4cXZUZkJDdGRsd1g1S2d2eGo4UE1pVHNi?=
 =?utf-8?B?a20zaDFNeEd1UU0xeW9zRm91RVRud3NsV240ZkxwcnFRY3k1c3l0ZXk0RFEy?=
 =?utf-8?B?UTBJMEhqSmlyc1ptWjRtWDNvODJjWUpmMDgxazVpRWlIZmpsc0tjK3MwS2VG?=
 =?utf-8?B?Z3FMclc4cWhXcGFHRExXT2RqODF0VnZKZ1J6bWpUa0Jpd2J2bHZpb2EwQVpO?=
 =?utf-8?B?cFpWZmQ3V1hRZjJFaFpzbWU1TTVSQlNlYTNXV2VLejJVQTNrclZVdHZHOGxa?=
 =?utf-8?B?VngwYVpsWE9FV3FmcW9iUncybGhmNXhpR2ZVRm1tMVRRcWMvb3FWd2paenZQ?=
 =?utf-8?B?ejhlY1RQWjlvb3NvZW5vQ0dRaVkvTjRlWU4yVFhiRTRQdFBMY1hWMFd3VDBh?=
 =?utf-8?B?UTA2NkgxTi9Xc1J0WVNpRXkrNzdYUzhhWkN2RCtka2VyOGNOSm9mdmhVN2dD?=
 =?utf-8?B?NHBVU1c3WncrOTFuRTNwdVlWNHVvdkpIZ0syd0dLV2VDdFE0dDdZSCtJOWR5?=
 =?utf-8?B?ek16QWV4WEhPUTAyTWc0NGFBYTN2dEgxalZLaUpLZU5pNS9pVURxTitQWllB?=
 =?utf-8?B?Z3o2amoxZVE5b0N5bXovSjBTc0FtWm9DTjhRZHJMTjIrUVBPa0c3aDkvMCsy?=
 =?utf-8?B?S0VJQVRZMCtLQzZoa3BSQ1IyRzQxaTFnV1A4V2NRUDhKSUVKZ2ZOOGJKWnEz?=
 =?utf-8?B?N2o3OVJMcHJFWWdJUVlQa1ppUW55L1NveElmNVREc3hZRm41NitsQVV6V095?=
 =?utf-8?B?LzFFNXVTYXJ3NkxHaGd3Q01wSU9FcEppWi93cURJZ2NQYlFIWkNBcm52QllC?=
 =?utf-8?B?LzZtZkFXcFlBR3dEeS9LL1kwVmhXd28wM2Q5ZjJSeUdlblhKQ3U0RkVwZVJW?=
 =?utf-8?B?ODdLeXlPeVA0WmRkdEhKWC9IVG5XWTk0dFgyT1hqR0ZmcjVUeWxGUlppSFZS?=
 =?utf-8?B?N2NZc0R0blhMdFcvT1FQYjhmQU5OV3JlbFVINVpsd0JOc2pYOXN6dEFBM1RY?=
 =?utf-8?B?QkhkZ0UzZnpPbDlHUmNRdjY5SU5OWERUQWwxb3NJeXZTcm8xMzMwNzd1Zmgx?=
 =?utf-8?B?RWU3TEVpNGdqeUFXSlRVTUFtVjFHNjdjRlA2OVV6Rms5NFNnSjhSZnRKdThh?=
 =?utf-8?B?ZjlTbFMxbGtkdjFTeGFXWTYvVU55eXdpdUg0MXRkWldPcHdvTlE1eldlYW9P?=
 =?utf-8?B?ZThjS3g4TWhhdE9WQ245N0ExelYwd3JoVGtXTUdrOXYrWk9ZdVdDZGxHUEFx?=
 =?utf-8?B?eVFrTlJxYitGUmpVbDNTS2pjRGFhTUdWbkVwb1lSbFJCdWcwdG4wUndKQVhi?=
 =?utf-8?B?WWYvQnVET1ZYYW55UmVyREVjb0NjWVlyK2luN29IMjBJMS9hTnlCM3c5N0c5?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83c3c3d-52e3-4955-9188-08dc287f5521
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:24:13.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1Oax416ZN4ug5ehYiTiXUDUtOrb7S7jWppHeTwHbK/HcGhmYm6VEmYkQxibKzifOzcupfGyqrRqXq35pil+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6807
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Feb 2024 08:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14916

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=2&day=8&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/02/cip.2024-02-01-13.02.log.html

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

