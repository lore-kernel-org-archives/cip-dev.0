Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBBC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:13:56 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.47])
 by mx.groups.io with SMTP id smtpd.web10.17390.1702541631600259692
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:13:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ue2fenst;
 spf=pass (domain: siemens.com, ip: 40.107.104.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6JRUQLQYTjnk+3O0hsVDoGHliW8zUs26UUrtVXwcTXE11jtyvyG6muGolO+8F14oytyz+tFNSBCIkTkNjW9werI+e+wH0PbLlwYakoz5D1lB9ECxbV9InQTw9RGuKjVDMQIorGMG0t2Mno+EsyKWdbeCcyFLcAhNv5PPLguzQN7sQQQSWr3bH02ddrNDvQ6gSq1uo6MQ5dX28XezdbBfJ8if1tLyUNk6j73AFnvRipYShI0lhz2MNnOvpYfweMkbzSCPT7VJGNUEJtg+Bi2LleYAwM2sGnngI7dQkELI9XrZlCKhPb36W4O0QzQMwteHyK5oyebRYlBLgDewE60wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMkFi747kpc5XP7v+UGIiYxIDwJza4lw3H9X/4zsvFA=;
 b=FKSQk/iP8y9DYtaQRJP9o/DaU/gy+ssn1WMrzBo11lXeBWNC7VS+3TjB3Vw7DfcQaMWR6oMkux76E99FFceTJJkvVXf5x5cxbDrGD/umQKUXYHuXHktpupM/nJUdpgM+FieIW4dzh/kba1/sI7Q+5K/bmnW0gAbIeibbHd6floIJ2HiSgd+Y00XsZTZKzubvR1ywEpBw0HmgL3qA4jzg8Rb60I3FCGOUxCNy86q1lgCnweN7+t/OpAPO4kWyZxoPHmxf+j3zsBVDqne1dR1Q1x0v49uXiksQHf/Vpzz5vjtucHIIeHg/0VkDqUSEYdoKUnTZ+Z/D+gs31VHwwPoiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMkFi747kpc5XP7v+UGIiYxIDwJza4lw3H9X/4zsvFA=;
 b=ue2fenstf0XZOx6A2vwTyCOe0HPFpfC04D850/0BatuPZjPZKHahdlw3lmBLkAHMoITF+e6NiGiAv6w83nkfgO7ZVOzP2W4zi5vLf2rd7VbLnpLgTcB87tk2Shhz8V/owP7zg3XXR3gOANLs/PRRRksQC7r5Qagzp4VHCWnoIu/hJcbBrefoVcPM3oWQxEr2vsddjpR7Wf+WZQcALyLpy/uUy+iJ/YimvHsuLDROq9ik+SD8colNkBdwmtHZY9IPlkuN+RWBqurJsrQv6Hs3HjR2WZjXhbj8p4kZKhkcc3n0BanQHYk1q3Qp6RuYumJPvpPKwKZBtdJL6dE14WP3WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:13:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 08:13:47 +0000
Message-ID: <d1055a42-e31e-436a-ae87-8b253a55ecee@siemens.com>
Date: Thu, 14 Dec 2023 09:13:47 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b09cfb-ebdd-48c4-bba0-08dbfc7c98df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dCcENXPLhfCe/rFdkT9JhSkXzyql7wuAjfSN9PUr4IZwTYSWDvwMi8KPn71DcSOqi2GuQd4t3e4eau+8yML0Lx9p9QBKQw+nQ5/3J1lGMpj9qAA9UFBuSfZit3imrX/ntg5AjEUy2DOteQv6WV31THXA7K2SLLh7U95IQtjrC9mQ544zVgyEp78JN23s8GQe5IjmOaLFMVuXr5AjH3xMO8sMp3E7pIgdgCLSTyKaZrzp/jmwio10vHep5mkHMc9ODSZ0MdAsWTnkORON+arj6I8JRPmBReWPjq+PaXSHfmRhDP48WrX5IzBJX5vfIUSdN9PT2ayzz8QFDOEuBmnyktOC9AgDwgnjEPtJIur5S8Y3xbbEgwSf2A9IV6iaoDXu6qmprtEC7nS8hpj777v5ULa86HJQGH3ZpzKjoB1Lh8/ZaAAtIaWEfjFpy7X2Y4khCxH3MQIg+ZkoQEEqZAvBLxbqO3aNWddA/2V0ejWX3RmrXxW5YpuAydEvEBVhGrwc2lfzxrNGRPnucfRmDWiqCXZfpo6vrKbwJMXBzIuemuzajxKGwUnlA26yEHYsnJPydcRm17LjPgWN/8UZmstij9AJPg1yflVUxYuuKqpXHx9rTivniPQL4iprYMUTrOf3KWAmAZRYb+JI/rr/vke79A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(6512007)(6506007)(66476007)(83380400001)(2906002)(5660300002)(44832011)(4744005)(41300700001)(66556008)(478600001)(6486002)(966005)(66946007)(8936002)(6916009)(8676002)(316002)(86362001)(31696002)(82960400001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmU0MUllWEhIbWZLSmRNUEFkUzJ0ZnNsc2pSMkxzY0hTcW1GbDhtQm9neEtj?=
 =?utf-8?B?VEJDSk54MUlFd3hSUi9FcG9RWFlKKy9vOEpKeEdkVy9GUUtDa3F2K01kT1Mz?=
 =?utf-8?B?RTMwRGF6T3VPT2dCL01sUUpjdlB4bXN4Vkw2bE5tVE12WkR1WkVHU0NVZkI4?=
 =?utf-8?B?VTBOVUo3QzcrU2RMb1IwQW1Bb0RRcjUrZGZTVnR4a0FQTFptVXJkZ3haNUhO?=
 =?utf-8?B?d0hVZlFZenJhc0FOZnRvWjI4czZuUGduRkpJUkRIeFlLbWw5L3NWcHFuQ1FQ?=
 =?utf-8?B?V0gxa3JjNTljRmtFVGZ2OTM5YWdGd0ZacWNadjUwRFc1eDhwcXhMZDRlVmpV?=
 =?utf-8?B?L2doN1dEa2JvNjU4VHJNbUZEbVRYVGFHZVJkYmVxc1ZmelFRbXgwWGR0dFNs?=
 =?utf-8?B?dHlNd2QxcTdsL2Jac2UvNEhTc2xNT1cvUGt1UHM3QjQ2ekozRG1hbWZPZDhH?=
 =?utf-8?B?STUrK2wzQTVENlhHOC9raDZiQmdlcWFYL21ZbnRsRnpzQTZpU0lCNU1VbVZ1?=
 =?utf-8?B?cmRGdGZSRXpXazNEVXRKNE50M1NWak1JeTZqMkFUcTFVY09TZEZaMS9DT1Vq?=
 =?utf-8?B?b3ZXbU5EbG5iVTRqQjR1VDZqaTI2Z1VCVGRwcFBxUGhjM1JhSndPVFQzZGN4?=
 =?utf-8?B?ZHpWRHdKTytvT1p2ZlA3UkE4UGF2Z2Nqc3lHNXZBTmVmM25zdTVpZkNnQWlD?=
 =?utf-8?B?SFdxUGVkL0ZYQ1RvMzc2dnVxeWt1MnREam1NWFRJcC9ydzV3c3YxWHAvc0VJ?=
 =?utf-8?B?YVRmL2NIUld4YllqU2JLZ3hmbDBhQ2hjL1gvN2JHcklPK2tBTmNDRkttWkVa?=
 =?utf-8?B?MGJqRlY0TEpLOUhTcSthd2syYlRwdWcwRnoyeEJWQlZhaSt0c1FMK01STGNn?=
 =?utf-8?B?OFI3K2JhTzVxczJqV1dmZDQ0UHQ1WmQycGFwVnZqQ2t5QWVOVXg4c2lnY2Mw?=
 =?utf-8?B?RXE5ZFB1VFFrMjluc05sRFRSWmUyWHNHTXpRbm1pT291VXd3VzEzSHZRQXBH?=
 =?utf-8?B?dDhEYlppTTlvZ1I4bFhBOGEyZll3ZUE4NmFVTzh1ZXoxOFpmbEgyT01LYU0w?=
 =?utf-8?B?QWhENlZwbDhTSFYvMmJBWG5KaUpqeHYzWVA0WHZmWW9nZkFVeHpVTEhvZHZM?=
 =?utf-8?B?WTE2SmZLbFJHSHBhMkRBdDltMDdwL2dlbXNtWi92VGVJeVBMbmFobmRoSk8v?=
 =?utf-8?B?SUJIZjJKQ2tBbHZxbGJJV2NhbWpJMDc1VE1yMVBoYnZJdk52STlwenhkK0FP?=
 =?utf-8?B?RS9Cd2hna29DNThVYlNDazNtMTJMeUVOQ2FCeG1qYm4rcUNKbVAxbldWMWlQ?=
 =?utf-8?B?dFQ3bGNiTnVjMFVpaXhwcGxvUUNXYnE5U21mQmZUcWkyRWlwNklIN3FuMm5y?=
 =?utf-8?B?cE05MWhTNXBwK1ZEQy92ZDZTK29LOXJITEJla0Y3SjhRM21ObVprZGN4WG94?=
 =?utf-8?B?UHdYczN6MHFuUFRIdEJPWnZQUXNMZVc1SlZ2dkVSRWx0TlMxMHFHVzh5NzlL?=
 =?utf-8?B?S3BSR2tlT1ArblFwcTRNQjQvYTZoV2cwMGlmK3FvaW1Tb25Bb0lKaTRRRnFj?=
 =?utf-8?B?U08rMWxRTDhpc2Z2Yi9tNko1dzFJdk5ud3dndElCUzFNdFM1d3BHampYY0Zs?=
 =?utf-8?B?dVRlblVoZWxsaEFjTTI3OVRZNlVNRjFXWlFNUlNaZ1hoSnRzQTJUZ1FVWmM0?=
 =?utf-8?B?V2prbmNQK2lGYXpBTDNIZnByQ1FxSVo2WkExaURoOEpDRjdjWVg2NW5NUnVl?=
 =?utf-8?B?SmpoTms3S3VmejZiSjlZbnJ4MjVGY0ZlTlEyREFaTFN2SUoyWCtpdXNyN3hC?=
 =?utf-8?B?QWlmSEU2cmFyN2p1KzFyT1JhRHRaekJPWXF5MUZZTkl2WlNiVzh6KzJjSHkw?=
 =?utf-8?B?TkdpOUxJRUZjU0lpUUZXWFJ6KzR5d0s4R2toSUZxV1ZKTTQrdEFVbTlSbzRm?=
 =?utf-8?B?dWU2MU5kK0cvUnJpY1lqMHZnUGVGVHU4QzkwMEFBZXBIL1FKRVlvd3d4Z1N5?=
 =?utf-8?B?czJMS1J4eFpqVGVXaDUreU5sSmExS24vcXJ4a0VhUGJoZzlYR0VTZUh4QUYz?=
 =?utf-8?B?N0trSkF6VUFXZUNIbmxVUURyRC9jcTVrcHZDaG9BQXVoZUZCdElDMDJUdUc3?=
 =?utf-8?Q?xJtpwmhvrEG3JvMkOTB11M/zL?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b09cfb-ebdd-48c4-bba0-08dbfc7c98df
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:13:47.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ektt8SnuYExArg3ONFBf38UT/TNQgowjVnqEHzfKxHPajeaDPD0hbd4yegxhO+W0tvt6Hr9Rn7waPOLVtjxtLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:13:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14091

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=12&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/12/cip.2023-12-07-13.01.log.html

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

