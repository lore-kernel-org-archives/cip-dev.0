Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABAC4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 07:05:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.44])
 by mx.groups.io with SMTP id smtpd.web10.7545.1670483119733178884
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Dec 2022 23:05:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yUlcc+n2;
 spf=pass (domain: siemens.com, ip: 40.107.21.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKSYA3i/3T+22VIiZPRRkbeycTZfCOyyMQLnvb4gU1veu+3kQM8RHeqyLpqwOodaODzN/EdQnb/eS3LtPu075MjCDWzwasrkH+2255jHf6yI5k3c5N0DC1gnV4As//p8PGpp9qfQmTiQ/IBLauJCS8r4kD9P2664W3tOqvJOqHxEvur1JzkxrgpQ+PvOygQFlgjZGFu+txOivIqF7mLPkgTrX+iZ8Z9LXhkvOIdiFKO4hqtubxNR4w1stoPgOsNgGhEMVp1lJ11C72LwjZENugkKpwNrKqzqH+RyZj/1IQp5NewG8DQc8ajA90FuK7Ozj6CY0JOlXAh0u+LeoFaGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B74OGnK28FApHOQltLn4oAQh0C97iLQpDWSMLRE5XXo=;
 b=nDqvaHsUsTi53Tznh4HKf3xZQH4dH+kufE+fhjG1SMIpZ97goU0tgc8HG0NV0PrHHa4p2cTHQpskhBb50TK2/UI7tTteu/zKlOIjGOaHqdTPt6q1/rkUPii+YA7V7VXXKaqdLl/r+i8lOZnXl6Jafy4TGG3ElV1hEbWlTsmvuaB1bCzPYWJvGvPLiOcEGN1zORENt8Ko/Z9vLRymKM1G2GdhS3gyesuI2FRpaPeSZskNWqCgO/z3af0TkxrPxS0i68oT6pdqWTB6GR2reI9CO/doo+fz0bvUWOTJzQ6hwKh1AFqzljed8Q2bkprP48E+ucHcGwZ3aPKiWVMlHAkQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B74OGnK28FApHOQltLn4oAQh0C97iLQpDWSMLRE5XXo=;
 b=yUlcc+n28X6FzNvSfgPhZ+l33LzpvwdydOSpVjVY86BogJ/KxenIzzATtdIFr8U8TNygU19OneT4gs4VU1DzRaC5/hyoozxyUjub2Ymeut+vZnK/Ekd3NZqthIC8OyJOQzQuhv4q0sVEkSbwLJ4CC/IeZ/Zc6WhtAXtxLxK6KVL/6ohnLsIjrbihQb04KYqoi3P0C+tBDv4cQBWZmGHbNAmpdhRFOIvYOru6zhd1zITsQ92zG5UW7iDgX3xcoLQaeg0UgxlcWL3kGo5UTtxryiH01iPGCgdRH6oyjrVRb4OTj9Cmf2jgkQQMq5KnlLaH34SHSkZGuCEm6Dl5uW6xWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:05:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:05:16 +0000
Message-ID: <fd0c5bb2-34f9-43ac-46c7-61d632a0a0d6@siemens.com>
Date: Thu, 8 Dec 2022 08:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3899:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f7d789-f878-4064-9854-08dad8ea8f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RkSQh2Fj3FTd8eZEW8x2QJcFbH01OS3sXub+if85WzN9WsYYgxq+nQbLXHmXQ5/p8xu66DH89xBWa9SF3KpfCZB5tdAP8yyX63afTdwgTpr8MYG4tMgNvmyHYy3eWBHAV4SZDCtlzYgDHQcgafAHbCVrB8jfoPZzR32s1zyvDkbezB7w2Bp+W6AQtn9lOj/X4pIbzu7wTvYZObVf7Hr9F2YoRR9xeYK2YpsyU9neqRB75pm3oepgTkqbKGDIWFGW6MgDjkyFuKuedYmxQ06jQSnUVg++FrBP5vjd7083HLApfJFtLe2xGWMKId8hZkaXUdB3m14V+OgZ36uyLFwVMOwKHTZfiDXvj0e508bdeYrfeDYrEHh6Rk+P1NYBy1bmXUhVdvSXpWBCmzHB25aqI2D4BzqOoioqUrhlp9RqxT4kJhQeCRA9kgC1SO4NfvA3xeti3NEgwtQLnsNpHV/pfowABGY8ib+cCcshoNpMNNoIPrxExSoekwUnRxoUbImKrLPA2xdAxrJFDt4ruQjZeBijaI1AU0Rs+amZ+qKiJ7MFpBqMa6Rm8cAEaywaKba7lOWqGYuryPs+0pjgthgkIpfNbWI7OwtowZEa5RBtoFUNYAqoCTlzIT28YYUhla03wmc3CMn9uYVcNAfmJkPXtkJNQNsoHe5hRcrOvV9shXxZJV82JfGYntBxLXY882xX10slL75v8om7ebqKhhVe2VtW0Z6kCyca+hUTTzKj+f29jpC+53/gKtrGB4ytu7GlDGykrQXMEHMcbtBu+7sqAQyQr7ATvCvw9z4lh5Yxw0Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(36756003)(31686004)(82960400001)(31696002)(8936002)(86362001)(44832011)(41300700001)(4744005)(2906002)(5660300002)(83380400001)(66476007)(6486002)(316002)(966005)(38100700002)(66946007)(2616005)(8676002)(6916009)(66556008)(478600001)(186003)(6666004)(6512007)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emdQbUpIN3lweFNmTE1GbUxFWVh3SFgxazNvSDlaRVFGT2FWYng4U01oc3pL?=
 =?utf-8?B?Sm9tMVAxTk40U0NpU3pKbVROMVFHaVNPc1N0akVUb0owVHdGRVBUSUxzTHJ3?=
 =?utf-8?B?Zit4ODU2cGJ5clhSbHFrT1NsQjFlc253RHRYbDJER0FQd0lqbHR0QjBHb3A4?=
 =?utf-8?B?OS9vWE5aWk1kSHlPYkIrYnV5OFZOVGtqZmZhYllrRGZyVkZYZVFDbTgxWDJr?=
 =?utf-8?B?MTFLMjB2TC9VbE50d1FiMi9EZnBSQlhUNGUvL0tpelM3NHhuTVRPSXVIZExY?=
 =?utf-8?B?K0xLZ0t5cUorRTZPeVFxcG5xejBRZTdHbFlrVk1VTkF3VXpTU2c0RWhLT0FR?=
 =?utf-8?B?Y3hKa1B4MXNhYmptQUExN1hUZUkxWkxKdzloZUR2aWtQSGVyUmViV3owVmJV?=
 =?utf-8?B?Slk4aVN4U21OWHRvVGt6TEw0NXhDWXdCdk4zeTFYZFIyaTdpMUI0eVo2TlJI?=
 =?utf-8?B?Q2FJVSsrMGZoZWlDVW1YL1htaUthb2VFSXhGYlcyOHZrSnRqWnM5dmNiU1ZL?=
 =?utf-8?B?RjBYMWw3RUZWMjR0blhpYU00S21NbHJRT0dkNEZrQWU2bUFDY09MNlAwSFdU?=
 =?utf-8?B?YTl4U3VsMzd2R1pjTjNSVU85L3Y3UnRzaWRRNDZuMnp2UkhyTFZoU0oxVWtP?=
 =?utf-8?B?eXgwa3dTZ1luVm9GTGJQeVBYSXA5aHR5cGxucGdESzFKQjk5MFZuN1hBRXpP?=
 =?utf-8?B?d3BrMUxROUkrNDU3SFJCOTFEd1l5Rjg5VTJjYjg0MmMwWmVEYVlnNjJVWSs2?=
 =?utf-8?B?TnN6TkNlZ2tqU3ZGOUFOaFZPanRzMkhqWE5aMk9Ta0lVK3BUc2l5VXR4b29Y?=
 =?utf-8?B?c1dTck5GN2o5RDFQQnEzNzZmNFJDL093KzAzWFVuTUkwRFRwcVZWRTFuSlds?=
 =?utf-8?B?czNOZ3FQYlZkUmpDTWJIYms4aWxuQnJWOER3NGlXUVV5WHE0Tm5ud1drM0hw?=
 =?utf-8?B?amlnTGg2cU0xb2JMN05BT2czbGxYazVrUmdBdzVPZFkyZERqdWhyMUIzNU0w?=
 =?utf-8?B?TVlRTFlPdlBpUFlHcFlOT2s0UWdpVEZ2SDNvWjhrL0kzUkVkT1B2MnlkdWsy?=
 =?utf-8?B?aGF0TFBrUm80Z3NjNEhSdDNrZjAvRmRzVnFIQU9BY2ZoM001RmFNQmtGa0Zn?=
 =?utf-8?B?WXBMVDg0dW5lbEdJNVF2V01XV1I3bStHQXM0anFoZ25LZkdWREJ4TmIzcVFo?=
 =?utf-8?B?eDNhU0lCZ3NUR3lwNFhXTG5MSEFneitweEFXdEFrSXg3MWNCSmRhN0U3bkhD?=
 =?utf-8?B?V2gvdWdMK2RGVE8yV1U1ZGdYbUJTdGtTTzNZUC9JdEJnazIzOGUxTDA2eTdQ?=
 =?utf-8?B?N1N4ejhJZElRVmVnRnVDUXN4VHZ5MXNLY05uT05Yc3FaVmlwbWlQT1AyL084?=
 =?utf-8?B?aVdoSmRibER5UWdxK1lBVFFYbDVOUnU5NkdJUWVvb2pkc2pGcTVDNVp6S1J3?=
 =?utf-8?B?SVpsNHRvZlo5UzNUeVozQk5oOEpPeDBrbithMlFhSkIxczZrY1Rpc2JxNnV4?=
 =?utf-8?B?UGZFdmdGSFUrcHVkWWIyMk56a2JtUzNKYndSSnhPcFY3SjhwRXNHbGZ1MHNZ?=
 =?utf-8?B?R25oNHN6MXNnN215d1VzVHM3MlhpbkRGY08vUklFZVJJY2FkWC96VytXNzE4?=
 =?utf-8?B?WEwzOGZKSUNUMEhZeTBGaTlRa1l0SmtWZEdvY2FQOTNNaEZQczdjQ1RnUzda?=
 =?utf-8?B?QVROc1pMNzMxUC9abXQvZzA2d29PS0JXcmlyc3BZNGU1Z2wzVW1nRVpGTWlN?=
 =?utf-8?B?d0tuS0NXdmJtdzlTWW9iWkp0Q0JyNXVjZjZPUlFVakhJU3FKalV0Q3ZKQ25P?=
 =?utf-8?B?b3o1KzFMYVNxODJWYlB3WmpvQTRKVTEya244M1RWKzlEc05odGdBT1pSSmow?=
 =?utf-8?B?UlJ2S1Ayakx6aVlEYmRrY1FuSTZDNE8zSjJvSHVMNm9NMmk5cWNnT3ViY0Yr?=
 =?utf-8?B?WHJld2JrMGVveGdUNFp2Z0VPeVJtZnpWeWJwV0FjSGtRRG9MUURvMGg1Vktv?=
 =?utf-8?B?Mm1lNUg3ZnJGNGpNeFpCTVNDKy92ZEFkcmxGMXNnWXZIZEdZTDZJTTZrT2sv?=
 =?utf-8?B?V0cvWG1mTmVwYVo1QUZBVXVLeDlVV3lyNVB3bEFZSmxqTzJBOWVFeWd0MW16?=
 =?utf-8?B?TzU0aCswU3FpWkFnVUtYL1BxdjV0Kysrc25oQjdOQjNWTjEwSXZrQTVtY0xS?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f7d789-f878-4064-9854-08dad8ea8f0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:05:16.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAy8CBJn08tT9IGDWa7/+ZXeKcv5gXkrH7LS7EA77ClMt9yv0Jm9Dzl8EsyKpoo9OiKSJ0+7lfP0ju/D9X55aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3899
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 07:05:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10163

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=12&day=8&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/12/cip.2022-12-01-12.04.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

