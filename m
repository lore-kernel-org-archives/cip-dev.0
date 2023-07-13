Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2365FC0015E
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 04:43:21 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.51])
 by mx.groups.io with SMTP id smtpd.web10.1594.1689223395205627477
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jul 2023 21:43:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z1zciR3S;
 spf=pass (domain: siemens.com, ip: 40.107.105.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHYfM5bCDSfcpE5YxJOhlBLLD0916GYwedEVzLDF9eeTUk8o/jmDVzLuOAe8/MfSAUcCp2g/5kD8F7bta1fFLdkKyTRmEA64sYyXaVqoveEU4LoXIUfkyCsTnBioVHlKsnmcaMMcoWG+dN27sS3GdfE7YRSx8YuKbOk6/mGj/Rytt9gEIdAv//Hru14WVZg6fDoaYK5rLfFpoXj57iFdq46ubhV6Atgn4wO4Pk/dsXh7ycvgwnLyaLG5aOU7sp0gg8I70y+FL8AF6ML+SEIih9uC0Er9UlWvSbJnymAAov/aqFIwyLZj0tHsug0iQXY6+zEjFuEL8/1wkI/oL9yQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIdTmI9HZIw2LYF+LMT+twpYMs2nQ77206n02yMPG4Y=;
 b=Y2ij4g0BzGV3POiYwre3f7QUCkwQ94xHxeoyYGjosnlw6RLQNgdz9tm1H34uKpseyumJrz+SXXkqa6auxmLFBYZJON0cpe1vJIEAfYB2guw74Uw2mKHtTx2Xln8OvjinvqyKNCINetov3P5RDgRGx4DZrWrt7akgbPl3LA0IVjce2/40EhNuC3/K28P0VhRZDQOrw+gI/eRb9Ny1VAFP/HmTgnpPF6wVZvh9IIuNDrUSAegeeBCRy6J1DiGiLit/v782uYdq7JhPtf2h340S06JimwU83DcpQgQVby8JKlQHLsPpF5A73HRR0mZV55MBRtFqTlNHqfTyIlajNtA1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIdTmI9HZIw2LYF+LMT+twpYMs2nQ77206n02yMPG4Y=;
 b=Z1zciR3SoYMnvxuMm8usEy6imaGGLRJocE0NxXOlUefKvZuAp3v3ne5KZXiylXbRWtBiMhqFoV4whDiFLHxlzEzkSpakKrtd5ynazLL+a64R/nqPOnqQkVRuSQvnkAgv6Daz2mOM/4jkshA8qlGlnCIrO4LP1Nu0lP2utD+1GsEkX3jKpJshiVI6/V5481Ett9K8l4Wx0gvx0QGUc6wicGAXrgrglqecxGO7CUoqIfr5xCfHrGkhRwGKnDv3aQu6xZbhlL+jjMj+FRsDoA/LPyTm0fYwJzHOZSNm7SrAtNV6YE+91tW30nOZlQTjCL687PqZQW9qDIwyTW1b5tQFHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7991.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.36; Thu, 13 Jul
 2023 04:43:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 04:43:11 +0000
Message-ID: <59b819d1-28e7-66ef-5a60-27ac186eafb1@siemens.com>
Date: Thu, 13 Jul 2023 06:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Cc: Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 105cdccb-3cd9-4237-742a-08db835ba977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	90P3IU1vDEmxPxFUm/jC9iJuNkILx+hgzq2dbJaLfrk+DThCKe/tTjyFyIFbq1mxnfH4IO814xf73qHGnA9US1qB6gs1gAiWq68+Yj/tAQ8T6PemMAWc8x5VyXpqmohTFMgtY+HmJBosJ2xwy/hNVqbIYY99wygtiL9FgRL8PBYr9g43atC/vlG2ujYw9WkmIkY1xkJ+h1H9cvIqIUIVcxJLsNS7Ez/StWcwa6tqgvi00cL6+u2vnc4xmdiPizAXjGH6k/uS53Wl10zpaWf2zdiAZ8ckOpPNDT5lwM5nTSZmeTcK0fXxQyDLktpztjzL83U+NrG/8FM+9+oOZOTKeotTdw/mh1m4B+Xl9au6x4gClAp4iF19/cdifmK8kjRGzbu7WuLN+OrQYu5zW4cQQKADGXoDK/PzY/4nkp+WGaL3FQVjlis9EcqpZ1xG72rER4zb1aQYVt/svBp19c3Sr7Xq7xpgoN++nTRyo/Jm9NLXvzg6grhEFPJYfjrEeRdbEjvFGwrhG9jYMauMIxVpaI8tw6MeUGdwDmQasSfqImJTGzNbSr5tkGkMts1tKcjvtsekfPJBypNVZBWWjoILQC0HNsTrhqSXCz74itf97HbmYKTwA6Mo/K3bIwi+FQNvTevlNAY4NM89uMzJMb5B/A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(8676002)(8936002)(83380400001)(2906002)(2616005)(36756003)(4744005)(82960400001)(38100700002)(86362001)(31696002)(5660300002)(26005)(44832011)(6506007)(186003)(316002)(6666004)(31686004)(66476007)(66556008)(66946007)(6486002)(4326008)(6916009)(478600001)(966005)(6512007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czFjZjZKV05Vc1JaSlVRdjh5Wkp6QjRIWFQxM1FER2VFbFQyaXZFOURmMXB6?=
 =?utf-8?B?NUp5cUlrYUJiaHo1VC81MTcyZVNVdEdxQU9Bb1ExZGd1NGl1YkpwaE1RNy85?=
 =?utf-8?B?d1FOblBvQVRBSThvc1VTNU5BZjJLMlhnMndReTdvZ1hSL0RQUjVlaGRoTXhh?=
 =?utf-8?B?aFZmVTBtQmdpZFBFMmRFQWVKaXl2QVg4OUNDaXRxUWZZUEpZclhHdEhtbC93?=
 =?utf-8?B?MFZHMnc0blpxYXZaWnpXeVpCd0s0M2xaUVhUOGE0SGVxWmhURGE2dmZ6djla?=
 =?utf-8?B?V0xTSTV6WUQwUUJXa0tFZmZ3dGJoUXBzaVRSVnkya2hGK2ovWk5lUEVUZ3d6?=
 =?utf-8?B?Y2ZXdk41eFhRMW9KckJBK3g4L005bzhlSzhkVHdHRUl3cDBhYVVvaDQxejI4?=
 =?utf-8?B?ZXRoQVVrdTBwL3d0UHlJZ1p1WS85ZjhmR1lCRXE4MUhST2VkeGhpZjljVHFl?=
 =?utf-8?B?cUVlbHdSQTlxVUxDQ2p4N2dxK0NQMWk3Und2cUhQUXBxbi8vbFVPaFNDYUcz?=
 =?utf-8?B?YkYxTDJaSUhrS3ZDdi9vZG1LalpxT1QwU3JCR2JXMlJLQm5DUWZuZnprMi9U?=
 =?utf-8?B?SVV2cGJ6eUc4bEd5Q1dsWGk1TVVva1FYb2ppVVYyajJzeGc5T3JTaHJWQjBx?=
 =?utf-8?B?Y2lJb2tCRGFsQ250ZXMzZ2Y4MFhNdGJqV0VIQncvTFFvRFc2eVpLU2FzM21S?=
 =?utf-8?B?T3JjNGZPajVvSmgyQXF5MEFhSEx6RVJsWWxUbW5qVm9ZYVdHVWRsdFd5aVMz?=
 =?utf-8?B?d2Z0c0EvczlOcUU3djNwQVRTemdqbzh5WUZGWUFsdW90VC8rRml0WnZ6NVNH?=
 =?utf-8?B?SklFV1YvVkNnUXNhWkVyZHBGNDM1a1d6Q2crR0htT3VuRHJtT0JmK1Npa3Rq?=
 =?utf-8?B?Um9QZVRxZGRqZ09kd3EzU29Ocys4MVlPTFJCTjJnYis2MXFKaTBDUW9ueWQ3?=
 =?utf-8?B?Q1NON2oxTzVVQ1I5emIvT1pCT25nUGtKNGVBNDY0RnY1SjVIMEhJVEk2Ulcr?=
 =?utf-8?B?dklCczB0QzhnWVhGOWdlZmxtOWlTUzFrbDNNQzVDNzVpWXpqVGJuTVhYbFZX?=
 =?utf-8?B?RHNsdSs0ZytLVHJZYWpWcitjNFdWV2ZqTFU0ZXFxMkcrR1k1dndvMFdSUk1R?=
 =?utf-8?B?bTA5Y0t2Um13TFVIbjFOUXhJdHUxVnlsM0p1U1lPSU9ObGZIbFgyQ3liaFZu?=
 =?utf-8?B?ME5GZm5nL3BZNGRXK0E0cG5jckx6QkNlVFgrREN3WWo4WDRXVUhRSHRyc3hY?=
 =?utf-8?B?Q3NpZUFyY1FGZkpMamZtSVgzTDRhWmx0RndUbFZWUzlFWUFqaVg5NG91eUtH?=
 =?utf-8?B?ekYxZm9NVTJzelVYUzd0RUp1OFJoK0JSeWx3ZnU4V2hxTmQ3dm5BTElRdGFS?=
 =?utf-8?B?b0VkUHZ6RUQ5NVRnK2dWQk1lZ00zSG5CTFc0UENBb2x2ZVZkU2w1QjBMczFS?=
 =?utf-8?B?OFBnbloyRG9SelB4SWNQT0tDcEQrL2owUXdYbGdkY2ZBWU5QTHZiVUFISS9z?=
 =?utf-8?B?dVEybWpJSjJNdml0TlBEUkxlYXVTM1JPUGpPVjBNaFFxS2J0a2d4UnIwb0F2?=
 =?utf-8?B?dy9iQ29rbGU1bjBpMlZoUGU5ZTQ3VXU1dWRtajNjUjlHdnl1Zi9xUHNPMjJ5?=
 =?utf-8?B?ZXNmbkF6Rzlhajk1L2JqTDlBZnQvYmp6R1g4L0Z3SFcvREltNGVWVFduaTRo?=
 =?utf-8?B?N0lPUVVudER2cjBydk9YWWRTejZxRWtlbmZrL2VVL0JZZDl5MWhDeXJ6U0sr?=
 =?utf-8?B?Z1ozUm00cjlpMTFIMTFVYUsvODM2M1pMNjg0SEkvRzBYdEVyTGR3RDJ0NVlU?=
 =?utf-8?B?MjFKdUFOZm8vZ1FjelhnMGpBS3p3cEk4UVdpY2VyVVZCbjlla3MzN2lpbFZy?=
 =?utf-8?B?MFRUbm5RbGZzRGNqbkdvcTJSMUdiRlF4aWozU3k5MHdnTDFxTndFRG1ZeUFZ?=
 =?utf-8?B?OEdZaXI0Zzh0a1ZMNmdTUzBMTUFHc2ljV28wMkxDK09JL0ZoMXFFc3U1bktk?=
 =?utf-8?B?VFAwZlB1cG4rOEp2bXFXeFVkOURLMmxXVlhhdWxvM0pzc0laRkVSYVVEdEti?=
 =?utf-8?B?cUFZMnZyTGdmazhVdy9MMnpTZ25Ha3RXeitXMEdDL2tOdFdZOFRiTzU3a2c4?=
 =?utf-8?B?amFoNk9YazFzeFhoR253R0NhVHJCNDd2UVYyZXV3RitEVzlINk5Hc0RhSXI2?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105cdccb-3cd9-4237-742a-08db835ba977
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:43:11.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0XMZHc4pcBKQYZg0HOKNJ/rtrH3zKIAZKEYfgTAHvGntYIL/56Zpl1GqtHuAyzrcPPhmsxcJJj5iCHpknEp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 04:43:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12329

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=7&day=13&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/07/cip.2023-07-06-12.04.log.html

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

Pavel will run the meeting today. I will very likely not be able to attend.

Jan

