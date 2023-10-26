Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2FC25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 05:02:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.87])
 by mx.groups.io with SMTP id smtpd.web11.63771.1698296543789685284
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 22:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b0p9Fucn;
 spf=pass (domain: siemens.com, ip: 40.107.20.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuVIjmjKzSc9FPFGs3yYptRmfM9avbGp8n6ekuMyPKHw4cJovonvqPBZYEGMH8P3Ib6SfqWfR5n7pxGnsfbkxh1bPlsSthiRgjb2DML+v6+jSYtcX7QLajOihxeTkY3mx9xOBHX+JPutdA7k2+z3Sf4jaGUyBgjv382C8T0EDixRmYTLpx/U0dJzhAI63tACOXroWv2KYZ7J/CUHxFV+JJrUmmpukBiaZzbdjsqcN0ZVeyhxdQOdky3w7kWaOSpWjSi0Xa19HwcbzTyMzFH6wRlNfPdYrcewzkVv0mklIWY/ScRM3aWGt3j9dJf3KX4yL64Y3L2yssE+K7RaqKFGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzt3qSADatoB51PcFk9w/yiZj4BXhQwfxPgQeKy7dU4=;
 b=lDN4y/KZdcEijHmmw+W2i+lVH8iuBenDq/QcnesQsmQ+X2RQVNNcb6CzXLgVB948ytdxOpS7BkTscyXMm1x/OLUBuvFudtrgX3EPVOH4E7Jn+YCDaQjyDHNI+ZveYFfQJqYe0S+9iZc8m3PvoMEKM2Md0ZvCthIiyEyAGReXZ+fWfw+i65WX0VnRvO9pH+4LI90ISihcCBGCpYV3rINVNyvwD5HahOrOvulkRi8zzcASTtf3lzoQw+TMcbCB9zkVB+OdUQAvCK/zOMd5nfW7XjIeaO2m78N/sBJX1ZYukHLHD+a37YZdnDYrf//60vCFfcJlJwKZgVxGFuR9FZuk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzt3qSADatoB51PcFk9w/yiZj4BXhQwfxPgQeKy7dU4=;
 b=b0p9FucnENEHdqUPrYWX1rMmUctYY9VqdUWJ+oo/qS/2qpZc5jhROncBQ4l3ne9lc0LnFTWQrRdqcn1ToAMjbYJZmRUeNFOvAeakN8XNG8IdJI3vdlxEVAV3bQlmRhAopzzGYJBtJE9heEALd16C5Dl5LCWwSSv6V24IYraNiUSpB5FqYUxdg2IH3oMWIgTFpGZdbTQ8NCw0NJbRISEfzlDdR0zcvhz/3MkxNoC5lfSfVCj/f8psMnB4Bu+7GOM2W0wdx3CJmN/QMu3anTpyIIpNl1j1GIJ5euJ0lQcP/5Akxaa/fMMtBwG3I8jtHMav6Edm8lwuER0ZTrlmPDNh+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 05:02:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 05:02:20 +0000
Message-ID: <4651dfb1-7c93-4a5f-b268-9f59f736292b@siemens.com>
Date: Thu, 26 Oct 2023 07:02:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a51cf6-0e5c-4516-03c3-08dbd5e0bbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ixqD+K5+dx2EjSWPODHWNnIxLsHY7S8BuS+oDMRM+i1/Siu6T1O9MTJbbsuK3OMFjkgSsXnrXaHQybnBoSbIxMBaRtr4JlDEVCJpF8o9ZorxCvnuCEAJFJi2+nZ7vSELuwJnfs4Qsz1vHalV0lCWZCIc8f8hQBKKrjtqUZniF2izD1FijjO+/H4BUHJ9ahHXZyCqpC3p+9XLXnvu2ipfRTYsTDvifOa6Z2K9TsR5n8STk3hH3P8Dp1GRDnnjAAVowm7HJ2Tg+YPWooWJKY5TgHLNH/0yynaTJLySrPXHARDYPZd+E1ZM++MkSn15b4KL/3sYH7TZO/Gdt6e/daoxugl4/qwYxJK6amfus+NluWK4x7JyJ3NEU6QeEhJVTnpROqMfscAk05/C5dD6KCOqH+h9GJ5Ul41plKJh0n82q8kd/bL2g5V8yggaT0hKeCPs42l3LfjUmYuulTfzp6mYfxrni2nGF/YnFq4K76UeTshD0Sd32oU1PITqWoyGnjWGkWQHFL/66BtHvqVj3H7vBS9pF95ZNLPxG1dcGNVvM4F3qTWbgj1XiXe8QMO+ZS4smE+JakkD4bPZ0fbZgFCQDCtC8/JYOEltqH8p3amckplC4JApdbYdR1+55PenOs7sumz5IyA/RK1Db7naJB7TaQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(38100700002)(2906002)(86362001)(6506007)(31696002)(44832011)(4744005)(4001150100001)(83380400001)(6512007)(82960400001)(26005)(5660300002)(41300700001)(2616005)(966005)(478600001)(6486002)(36756003)(8936002)(66556008)(66476007)(316002)(66946007)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWhVQmVENXdRSTJvSUZPZmtHOWxCbjNtNlhRSGdORWFRdCtXcmI5bDFic1Mr?=
 =?utf-8?B?WmNua0N6K0ZmU2RXRUo0QWU0N0pETURnUmNwYmJsazQzZDk3SzdMbWlLdWVz?=
 =?utf-8?B?ajYvTHhiUmc4R1krZDlod21abGVRY3ZUODVtMmtFY3B1blMvV1lUVTZuNDVV?=
 =?utf-8?B?U3dWZ0VwL1Y2RHprVThWT1FoUHJNZVlKVG1URUpBckNCdExKUFlCb0VMZUxL?=
 =?utf-8?B?Z21rLzU3MVdSSUpVRVk4Yk9Wc25aWHlQOFZWaTYzWDV6anhrUDJ5UElZcjV5?=
 =?utf-8?B?K2pzZGRkNzBQNXRyTnRmREtpc0Z6ZUJvWVJZYVg4SEtHSDc3UGR0Z3dCbmNv?=
 =?utf-8?B?RytuSEsrenM1eU9DamhZR1hEWHlISGdwV2gza1VqZWh0UkQxN0dsKzRNVUdj?=
 =?utf-8?B?YUwxQTJLUFR3VEt4bXNnUXBEa0FKUHB2aldsdndzRjNOSzlmd0lUMEZRSzZL?=
 =?utf-8?B?dC96d3dDVWRaT1dtUlN4elJ1RjFDTlhObDI1b254RkFhSERFMkVLV3NyTGtS?=
 =?utf-8?B?OEMzRGpqYTRaZGJzWGNIdVpiaW05andPYmZiT2NXWWRjMjU2anZ4MWhRY0lT?=
 =?utf-8?B?NEpmeFNIT25mb0VJaXRyWnBNUEJYcDUwUXFoZmJBSGNuVFNYQk5sbTJBbzlK?=
 =?utf-8?B?aFJNOGUzRTdZY1pUbmRpSTBrSFRoc1I0YUV1RWUxMjcrU1J5MzUydkNuNlhw?=
 =?utf-8?B?ZklUMzBYOS94ZU9HbkJCazBMSWtxcnBQK0hFYlVEN0JKd0V3VW14UXBmQUtn?=
 =?utf-8?B?bEJoOGJmRGpmUHdraTRJVHo3RUIrVW42WktYSURQWDVBNFFhOXFOWGZoVkM4?=
 =?utf-8?B?ZlZKOVg1TUNhYURNMFhJZXpSdEx3bytReHYwUEpiQVNvUUVzZkwxcFEzbXkz?=
 =?utf-8?B?US9QMTAyYlRtWDJKYVA3OUExckVsUS9BakxhZGNaM0tDeU1yeUIrZEFyN3hV?=
 =?utf-8?B?VHlJV1NVZmx5TnVWVlB1UStFSVlxLzVvWTk3MHVJdWFUYzVDVEwvSnc1YmFw?=
 =?utf-8?B?NDBQNUVBK1VWbkxHa245VlErS2NINDl1Rk1meGxtSCtNbDQ1OEU4MHdjK01w?=
 =?utf-8?B?ZTJGQUd5dWVzNjBOZEVhZ0tHSzUzOHY2TklBVS9qMHNyTXhkWUVwVW53eHMr?=
 =?utf-8?B?MEJsaVV1TGJLWk5JM08rUjVJVHdLNG5hVnlBY1hnZU03eld1WHk3M3VNRE9M?=
 =?utf-8?B?N2JrNmNPZTh6dGZTWFlvaXN1M2VoVmhxUGhsak5WVml4YVpqSWp4ZTZLd1dQ?=
 =?utf-8?B?b0UwZUhOOVBaWlFVZ3hNdXZnRzhvQW5jL09YS1RuaDRuYVZmeXdpdVkvSzY0?=
 =?utf-8?B?SXErUHdhWERvUnhCK1B3MFNoazkxVThtdTl0TFR4WmIyd2dybGd6djRQK203?=
 =?utf-8?B?Z1grMHJ0blM5eUlUQXJ4ZTIxM2M2WStMaHhzZUtLUmRhMjBnVWtGRW9rZExt?=
 =?utf-8?B?TDFtS1lUdGFTczU3UTdwOVdlZ3B4aFduQkMvTkJtdWM1d0FJZ2NReHdYRkk0?=
 =?utf-8?B?ODdzUjUzVXJLRG1EK0dtUmd6SDNxQjBXNnBTOXVKYUJyODYzREsxVFczYVpr?=
 =?utf-8?B?YzdzczZZMzNxaVlvUHlKYjN2ZEcwUVgzSllMUzdSY09jSk9ZZUthVnVCMDNW?=
 =?utf-8?B?Nm1xbjZBUVBDNWdMUkc1d3NrTFpFd1ZvTjFVK0JIcDJ5eGRrb3Fsd0JMenhD?=
 =?utf-8?B?YXBOMzVqWnVDL2NBb0xTbWVJaTlVMzBnLzlhbjJHSVNLR0RFTW1XRjVrMUxV?=
 =?utf-8?B?azZKRXE5Y2dZVWNBNnJuMG41OVFPSHpDbklFTGRKa3BpVjVnQUdUUVkrRmhz?=
 =?utf-8?B?V0NNM1RsTWpMKzk1QXlaTUwrWXpTNE5TR0pBa3hUc1ZOOE9tWm9KZWVNUDhu?=
 =?utf-8?B?TUN5TXpQN2xjc1MvSkxiUk1ERXRoZDFOSk1zSEgweWVOb1h0OHBPdWJCYTl2?=
 =?utf-8?B?SnU1Ly9yM25GemlSWXFCSGxZb3k3ME5iVGRTc3BYTk5PRmF6SXAzNm11UHVD?=
 =?utf-8?B?bnNmU29FWURzQWdmcEsza2MrTXhrUVl6dVRQTEEvU0czVW4raTVMSzBteE4y?=
 =?utf-8?B?OGFHZEt3QkpFTEZqUS9WN3VtYXhBQVM5UXUxdjY5UnEzLzV1eEdaQU5XRHZz?=
 =?utf-8?B?S3FET0FqOXYwS0l1aGl6Slh1QTBMelRNSGdMaUVXZVl4UDVIby9oUTlyd2cy?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a51cf6-0e5c-4516-03c3-08dbd5e0bbb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 05:02:20.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBJQSfLFhBU1tlbMsauKmZ6D7aLDEJx9+r+ppe3P3rFPMBQycHbLlqyB9UJstwrLWXrxOchPG8Xd52CmQjjWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 05:02:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13456

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=10&day=26&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/10/cip.2023-10-19-12.02.log.html

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

