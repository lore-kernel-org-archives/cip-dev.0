Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6D1C77B6C
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 07:00:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web10.6556.1681369240636424923
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Apr 2023 00:00:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MlfF5PP/;
 spf=pass (domain: siemens.com, ip: 40.107.20.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuSY4dOc/sqQhYgZOu4K/S+xg9DQ9O3Z319VoEYoMWfoMLYYh9GzRPzuG/QUvdREi+3gnCzLZvEkYmU8V+RM1nH/i0sxVhfVSLdvSf8KnjokqQtZ2pA+yBaGZ6MxYxDW17l1mA8YhEUpMHOB7AD2h5pQPePQ+VsrLxfq7OQDHZT7UMUCeLGXji3hfQoC+psFjivn/JYQlJO5bc4/kr16kofaquzcU6gbEOTD2QBUbA+qSZcMBQFpy62b/RZZotNooldNRBhV6Z5xfHS0EMrKiCw6XEpJqO7aD7ajE7N4asdTiYc3oNdPv2UcM8QGDKryjFWPKYymUbajnUO9c6iscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCmELwMJQNXMrzU0dpqFCGTgk0dvK8DQjtEwA/GFdgo=;
 b=Lb4eLnS+Gv4QKfv0uiwdnvSx60eYOypBjKJ2kI+mG18WtyxncooDV5LoKCzY7K/tmBlxKCcZmVzyOdgn33ApfN45kuhFj4sWowqWmOWo3iZV7qn2tjkym8dJ88pT3DWVEhIv1OhXKcer6WmZV4fwE9WYbbpDMWEYMudCZBoL/hw81a3X7sbsPS0Isng7Gifnw1PJTpHvkwHkru6HgAjVj5CZTPuDoHAfUdJ1G+EhzwgJwYZ68BXAlsMFHxLzg/8ZzInaJihvc/Iu2hLy9J2neozsg4Nzy7r08TH20wtecNMlpUO9l5EBSIBxlVlaRiVcLlE6YA8lVTkXy8SzAbD4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCmELwMJQNXMrzU0dpqFCGTgk0dvK8DQjtEwA/GFdgo=;
 b=MlfF5PP/qAfJSff6smRZ5T9vlEsJ7kwZGwX2pS5bszEZj3n9qhCQVcYWjjZovoOKWMbGSuCcvAP73Gq2yUqyary0EehUPShlr0gVguY3U90I64tOjpm/AyJsmjXXMvufP88hUgvWftpYGFIC211fxUJ3MzcXnxu2wOxbjtNhFdIhk8dJ/gJ4bKDkQ+jEMjBBlmKYpcoxQcxRnwH0ZJsv8v/YxS1uPXcf7xyJHVIfS2jy7TtxoDL9xl9MRKV/HZyjzLINdrWH81qNn6UHuzttngyMcxbfT25p3mnQ7l4GOn5CECkCl7HDcjWbZsravc0iWL5ho6oHR4lCxlP/FsNxyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 07:00:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 07:00:37 +0000
Message-ID: <2a71e5bb-297f-9613-99ce-0d3cec20785f@siemens.com>
Date: Thu, 13 Apr 2023 09:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8687e5b4-293c-4feb-87d6-08db3becc93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yctM3OQUXBpPgmHyeh3hRHEECTVnu8Zilxd1nZ8lYZ+/+vgi92lVkAtEvxlP33ZWyzlUd4QJ0w/blU5jPbSSw1BETtEVmOWBL38amH4ubj1XB2/tJN0xMhPenNX4NA6LnjkaptCyWDxEobj4gRz8fAZSuOMORc8qC92aWQAuboqdtQJhvDjosrR0V1TCQGiwBQc/IHsdAwplfVEwlWKbnxkVwqSFRtoNs6XPedroqDTLaY34ZFqU+mUuExOExqm4JSGE9MJqu2JGnegIjzu8JUSkt2g9CcmGHYIl/xAyDYeGidkxwhQiYDGdrxFea/hQaqeOAaPIs/pia9IVWkoxw1XfhGdM20ujVO93s0HbMVjsDIfQvTflCHyYpk/IToQran3IKkuH/l7VJL60tjXjBOSIQzhlT7V3yRuXi0ZYA6UyZ7WP0IP2lG2OmVrIrhM49tMUCOdHoMCq4iDfMKBIazhoAOu40IYlUCqzDwXmrc29ePIezj4YYqUGb2YW3EiLQcHV7/VQCN5P0Fnv9VWz4+fHoHSnpdcbFtKfwQF3HefcX6ecO0+WElNO1VeNSyg64w1KMzHsTPv0bo+fu4wkn5PlOTWRG67o+LDvIDDohI67hpd7XoyXM2F03m1AM4D6Z5t23xpfBXHyUrOfE+1yEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(82960400001)(38100700002)(186003)(31696002)(6506007)(6512007)(8936002)(26005)(2906002)(4744005)(2616005)(44832011)(5660300002)(8676002)(6486002)(86362001)(478600001)(66556008)(66476007)(36756003)(316002)(6916009)(6666004)(66946007)(41300700001)(966005)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUwwS2NnaGZDQWxVYVB6dXdkQ1IraERIUlE5Z3ViZndFM2lrcnk3QmxDTkxn?=
 =?utf-8?B?OWh0by91NHFhZW5aejB3UlVJL0p1TC9zcDU5cENnNkl0K2ZNbnUxbldicjZp?=
 =?utf-8?B?OGFoY1Zzc0YxdXhqb2FsdHc3czdGZ2hHOHB6Nnh1Z2tPc2EweWNjMHlUZWV3?=
 =?utf-8?B?eUlJUys2UmIvZldrT3hQVVpJYk5OamtTOE14bSt6ZzhWRGIvUEdGVGdhdmVt?=
 =?utf-8?B?MVl6dEExOUd6TkpWVDlURGlGMXdDYnBSZW5xOGxNc2FGV3g1SGZsNE5OU0tJ?=
 =?utf-8?B?WWNhaFNGRTdYSzRJRHJON0lESTRDekZNWmFnT21UMFp0ZGVNQ0xFTGVIOGYz?=
 =?utf-8?B?VEhWcjgxSnJsci94U0ZsdXdUb05qTkxOQWdzVVVlSXkrbWVnMERDd3BBK2RK?=
 =?utf-8?B?MjkvaEF3WGpabjNzT2U5ZFYvMS9ZbXZEWXFGWmRpV1BVMVBEblhnZGRJOFZ0?=
 =?utf-8?B?bkdFSUVEY29Bb1Jaa3lOdTdPTFBvVUdqNzZDZWlvMzBDaGdZRXRDZ2xhT3dJ?=
 =?utf-8?B?WmF3dHFqUHhYVHdsQW55K0d0Yi9nZjR3UDNhUkxEam5KZTY5ZXp4V1BieGpS?=
 =?utf-8?B?V3pXVWFpeU12eXpFYXVjdThLdFBmWHBISVRpVmJRL0w2WlYrYnJhS0UrQUVQ?=
 =?utf-8?B?NUNMYU43RndwdFIybGZKN0hXa1grQnJ1NG82dk9zM29PdW5IcUFOTldpUmVE?=
 =?utf-8?B?WU5ITnpvNlRpbzBsY1l2ekF3S0dlSUxMbmZoS3RZRjBwL2tDVXZiVXlyS3pw?=
 =?utf-8?B?STdMUklHSEI4ZmdaeVZ6eDFDcjFJMVppRlAxKytYZnJMcURxaHBpZjA0cFpp?=
 =?utf-8?B?R0t2VTdRZEsrSGZRS3BEZU9ha1NKMFRLRlg5cTR1dXIvemdidjNUNmthYmIx?=
 =?utf-8?B?RmZUT0p0L2VIcTNFRWR4SEhKc3FzUU1mcDdZcDlJZ3ZDdXkxbHM5RzJpOWdX?=
 =?utf-8?B?ZTdNdnU1OXo5TE1HWWkzY1libXFqSHZLb051Yll4QlUwSG1JNWxwOHRDQzlF?=
 =?utf-8?B?SWNsRDgyaVJDb2UwZE44OTk5cnRObklKWGRiQ3FiWG1va1RhMVJPZEh1bzlC?=
 =?utf-8?B?SEV4d0g2d1VqRlZ0R3Nnblg2VGRNMlZIK2lWWjFUM1dVVkE2VUJHSXJkd0RV?=
 =?utf-8?B?SW1wTFYvdUdSVFEwdWJSOFpkZlVIUjZNK3dCR3ZSTnEyZmpHS3c2dFNGNElM?=
 =?utf-8?B?ZVNhV0Q2UFhzRUo0WFltaVNOamZGQ0VpcEdVQTVVdTZoTXIzVllBQVMvcWFX?=
 =?utf-8?B?bmd3UTgyRlliV3IyZjE0ZFJlV0pOM2ZHbTZuVVQzNVpBT0xuOU55c2tGK05u?=
 =?utf-8?B?Wm5kUUhtazFKR3EzdkRRc1RSQk1nNXpKL2Y2M0kyUm1aU3pQUDdyeHRIblpl?=
 =?utf-8?B?azdWeTY1UktyUGhOemV4SitIT05PZ2lGMkNwSHA2TUtoY3Z2NnhLb1FQYVRv?=
 =?utf-8?B?OFM1dlBBK2pjTjhtY0RDMjRtbjROMnB0dmFyOU1hMmVGMGNWendMeW9YNTZl?=
 =?utf-8?B?RTNFdG9wTUFqbnNzTWJBT0FFODVlT3VBMWhtTkJONjFKeS9aZjVVcUtrMUdD?=
 =?utf-8?B?N3hlaVNGVHMwOGY1QzRqdFh4bGRtcjBjZ2xIZDRnbWhGbHVJZldzZHJkc05i?=
 =?utf-8?B?NEFlQnNFOVkzL0paUHlKcjNuYlM5eDFhUndLaDlBRW1oL2tQaFZIVndZTkdX?=
 =?utf-8?B?NzBHODNvdGE0QkE2TjY0dkJSL3lyeVlOZDgzeStHT2pBMFZLdUlqeTVsREcv?=
 =?utf-8?B?Y0szTWJ3TG9uZFRHSzVHTllCNW81dFI1c0xCMU9HbjFvYlVNa0VoTEZjZzV5?=
 =?utf-8?B?azJyRjJzR05XcWd1bWJXbVlSTnQwOVBOYnlSZE5QNEx6ZkdyalQwYmh4SzZr?=
 =?utf-8?B?d29kN29CWmpVemRFY0NPS0w1UVBFQSs3VVJsOXZSb3VoVzJGY014c0hqNmhT?=
 =?utf-8?B?WHllMEZ3UWFKcFBYQmpPYlJUazIwRWJHQnhxMkFVblluS0RXYjJETG11dWxB?=
 =?utf-8?B?SEJVV0hUdmE2UWd1OTRLa1FoWXBPMnJQalE1TXJiQ05uZWZRdk5MbEZSanpC?=
 =?utf-8?B?S1RaRkNkRXFXQXhoZ2hNVlF6YkZsNDhVSlp6RkRHL2xjaVNuS2Q5Y3Y2akVQ?=
 =?utf-8?Q?qCH6b8kJhcL0tHTaSUsNK+Uh3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687e5b4-293c-4feb-87d6-08db3becc93d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 07:00:37.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrldCr+wOXGXGZRoXegOh9TmEFGEzenfJKp7QID0p7a02DcJlNDF+nAaql4ZPPkrjKd5guW64DqcFfDcH3d0iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7091
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 07:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11195

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=4&day=13&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-06-12.02.log.html

* Action items
  1. reach out to Greg regarding LTS (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

