Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38918EDE987
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 06:26:29 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.61])
 by mx.groups.io with SMTP id smtpd.web10.5945.1694672782767968524
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 23:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=diOJIYdw;
 spf=pass (domain: siemens.com, ip: 40.107.249.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqL/FPHCFk2kulHE25rBHSpJQxZ4uurjwrYfxRo7OyTSzeiI0NAahvxvj9Zq7knmnAbMyTP9WLiPJaocHPVrzwDwSZBbm8UXr+ZGRujmLXYurlv/pimc/kkoiZXVBOLmOhzlSHBulxO/xQqbndqaZqHfDrKFmOYCA//TCq7wzv8Avel2+MuYCO3E/J0XI43oR52FY8FRT+aALh1GyQYfS5b2d71mmw8sptjMyxgLem4DhM4o3cO4w1p1Aykgj+r0d1I2YohkQySKdewt0TY6KHjN4TrfKaSQZG3J6pC0g3CjRLDbDyGhTH3do8G88fNXzvbDvIaz7756HxGIVHGy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWcE6IdW2Gq3Ld9BQqH4i7xAF6DKdrtZau0VijCmFvQ=;
 b=H+YqSyHyFZCSvigr3FY+ihigiNtocdx2c0jgDNf6eu1aqP0OOcY1PXRkm4kWiQbi8N0+QQB+Pcf9HPu7IM96bZnrZmjfBcDmYCdgHPk5FiN1W5Zb3KhBaZLxqZba0RHEpv3xCOHOY0VC4PNRvydg51nx4JRrl6XwCxsVTvLOjMzCQGHlxgpoSSK+xVfgT/c/+WxILmGceXSHgVyP5fLVNJvfJj6umEgE3JWww2KjGIG9u1dlL05HxucjPoJsFCgSi5amn5KXvhoP2aMcc7acOb28kIvaoq6kE1ZmNfrVZq/c6i+02gaUfJx5L0wWU1IJT1R4fkaI2VEoy3pkf6TxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWcE6IdW2Gq3Ld9BQqH4i7xAF6DKdrtZau0VijCmFvQ=;
 b=diOJIYdwDLtAXEnQEPrxmsnSEhdyma3KWUMblOARHKGR2yL0X1JPLnRpyf6jp8qpyNwYScid4OHRbsRnNIkPF5jVEUlw3YWtKh6T9mtoK1t9JFO6M+G8VCkn/GA3NnphzsxRdX0/BM/D8DueR73jyY6sb/OXnA7xVVcyGUy6LrQ/06EFX9VHjRG7DLn9x7RldLhWq9n+XUby8QoNOzUijK2Oxcy90+HUdn7WxVlq6jiAQCjzembFoHB1Provm6KTI1hxZPX9yEiwKnv6xEDETyLchuJ4sAdoHEbX4ZGfFs+tkHaSwZlKMY6ks2/rBbwzcEA8IrzBgPoDzcwFWCR/Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 06:26:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 06:26:19 +0000
Message-ID: <b0a75a9c-727a-4af0-b3df-d28dda57515e@siemens.com>
Date: Thu, 14 Sep 2023 11:56:10 +0530
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 28603308-b3a0-4d84-0011-08dbb4eb8209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sbtsOyWsPtSHKa2wuEvJwXtDPw6bYakkgOFvWZee1H3d37lLJG7WatoKOFeFmy3vYeMAOyiPv0sLrBSRhQKW8h/Qa+0jLCcioUBDlMuHSRbgbJZH6EDW7qqTovkF5UsD/vAKbjRWtYuDR4nsMt60agVJNwKJw8tZILQk2DvWHnEd3MJPm07NVuL0OzuNXuYxFIzhBQdSXdhRV+8MobFhGolgvrpktIDTUzMkvqPU0d0VO/178zuFK0SuS352UwPI+Bl/b28UbbJQoHdcjmKP0g6iE+vixfKQ5jLGIlHH8fcDJ2015e3DWHc0Kqm5jGglvhogE/2w23CBc2a6Ggk9PanpTKHNNG1eHd/Z/6ShXXUezCnxaX7QDbEYhXh3qWA+qqbsfkB5hZ+k0aJDlTvDEARAOOeHMk6DiU2dpjf/6qaUyOx/Bo81u0qyXfLFz83Ybd19vGfvUb0pTNvqTXDtA1FGknyxSC7U+WHZnqGeva0F+GIQzg72T0xj7NqEIfdY5C/DfyVi66ATdcTLwuT9azagt8COj2s00m/ryuooO5x2nDB+Z94d6L7LA5Xueyg5n90aZchY4ZbGC+5caRtAMBDfGEtboXYc0KZ7Bx7x2i1Xmc5LZxum4EgyJxMZ7O9ngh9cyheoW2aUZvHOeHM+yQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(1800799009)(186009)(451199024)(26005)(2616005)(44832011)(5660300002)(8676002)(8936002)(6486002)(6512007)(6506007)(6666004)(83380400001)(31686004)(966005)(31696002)(478600001)(6916009)(316002)(66946007)(66476007)(66556008)(41300700001)(86362001)(36756003)(2906002)(4744005)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjdyNXhWK3VzbzZKblozYU9oL1c2Y1dDc1hjM2NBS2ZaOTEyQ3ZsUXArTGlR?=
 =?utf-8?B?S1locEJjT08rSWwvQTMyYTFQaUpVeEdaM3R5ZE1YT29mV090UTV4c2wzamdw?=
 =?utf-8?B?eE5GNzRKR0dFRlhSbWcybFRUR1hHYlJOeUtoZGp4QW9CTm8ydFN2NDFQVmlq?=
 =?utf-8?B?cjVqaHZ2WjRQZnFmbE0vRlQ3TGpVS253Qm1STlFsZ2RKTmFsa0gyek1vaWZD?=
 =?utf-8?B?MGxSdGJpZ09RSm52UytJV0pwRFRWcDVPaXB6S3I5ZUJhcVlTcjc2MGRqT0cr?=
 =?utf-8?B?bFZpRG1WN0VPVE5wRWk1NFRlQS9JdFlGZEZuQlhuZlBaN3JheVBOMk1JcURZ?=
 =?utf-8?B?SXBjbzAvUGxubHBvejJ3cXRHODMrcEVQMmZ0aXRRV0xTVFpHL2x0QkE1cWQ3?=
 =?utf-8?B?Z1VtODBSbUhzbTlNSE9PRXhaSUZZTU45MjB5NCtCS2xieE5yTVVOZ2NzWFg4?=
 =?utf-8?B?ZG5Ja081YVR3WWFRUUV6WVc2NHpsQmd0MkN3QmRHeTVLZnB2aHdBeStzUVlr?=
 =?utf-8?B?VUJ6dHlnSkFYSmdERStqZ0oxbXZreXIyclFpbDRsREZRcU5ZMmpjak5PcjNp?=
 =?utf-8?B?T2lGbFYraTJ5VS93MWZHTGZ1Q2swTVBjVlZDdGEvQi84ak9CbzFndXBnQVRH?=
 =?utf-8?B?NFhIaWdLMU9HVDRHRlJTVkpRbzVjcWtpVzd2QXFTb202T2RBYmpFUDNiOHNC?=
 =?utf-8?B?YXp5U2JHbW9vK0VLVjFCd2VYT1BEYVdrL1lmanBpajlQbnUrQ3FpWTd5bVVo?=
 =?utf-8?B?TUxkdUlqR1F4UFVzR1JRQk1INGNYUldpRStyUGhNRW9XcUdUMXB5Z3RENDVG?=
 =?utf-8?B?WlhBRDBNUU1lVDdLZ1FSMENSbWI5MVRjQ01UOS9zOFZSR0F5Wml3TXlpTFY3?=
 =?utf-8?B?ck5xZzZLQ3paS2lrS2RzaXpUOWtyVTZyaHhZMTV5Vk1hVDlRdUJwbWZzOUY3?=
 =?utf-8?B?V1M0amJjbnNiWEROVWtiTFBtUXB3c09TNnBjTWN6VmNzTVMxcUs3d3FPTklm?=
 =?utf-8?B?dGRaYkJvRnhwQnZJcmd3VEpYMXBtQ2JoQzBGRmE1UUNCOERUb25YcTF3clpV?=
 =?utf-8?B?di9oR3pBOGdtT0UyS0c1TFB5V0R5ZVZ5TU5HVy83SzFpL3VJcGZqWWFyeEtU?=
 =?utf-8?B?QXZDZUtXWU1FeXRTbTUxVTIrL0VXTk1YbVZWZGVNemV5NW84dHZsbDZIalVO?=
 =?utf-8?B?Z0ZpWE5NNHdkN2FYZmpueHZMNDRJcmVzVGZNWCtML1FKT2NPQ1dPRk5BUDZQ?=
 =?utf-8?B?dkxFa0tBc2pYM1JrWlNHeEh5dmtzVU43czFvbWs1d1lRMElkc2Q2STFVSVdV?=
 =?utf-8?B?SldlMzdycTdKU1VwbXdWd3lDN2ROSmRrZDlTZFQrcnZMVE5CakRRaFIxcmU4?=
 =?utf-8?B?ZVNuNWxvck1GQ0FLazQ4eGJNQWE1Qjg5UlNrZmpEdlV4bTNzZzVIaWFpYmJa?=
 =?utf-8?B?VUlvV1l5WFVRUSszK1dOR2ZhbzNHNEF2M2lRSnJTb3ZmQUllbWc5U2I4OVdP?=
 =?utf-8?B?VEhHTjBIaGY2clZkSnR1aDUvdEMxb1NlbStWL3lSMzRMa3BvNXRxVWhOS2U1?=
 =?utf-8?B?K1p2ZzExODZMc0JjbW52RTcwbXd5aUsvbENYT3VZZ3hhdVlhaEtYVHAwVTlF?=
 =?utf-8?B?VkpGVzFETVZjZVIreGsxQUwwcFAyYm5FZVFlMVRKL3VxcG1sTFJDWlNneHB4?=
 =?utf-8?B?dzBzdk45TThRYmtTZ0N0eWY1L0VndU1JaTZVRXVNSVduYnVIV1lVUjB5WXBZ?=
 =?utf-8?B?S0o2eEcyYjJ0Y1dDZ2V3ellUUFo0NEdmdU1XUDhQMkFwdUZZUUpHRGd1SVhi?=
 =?utf-8?B?NFM1c0l1TzVKY2h4NVA2UHgvNi82cVdaYmMvbDQ0dElZUHJiWk13Nm40RmIy?=
 =?utf-8?B?b0lzelJNUjQ5czlKMGJUQUJ0dE1Ybks5c0ozaEtqd2hWREl1ZXhHcnJZVnpN?=
 =?utf-8?B?QUFXc2ZFVTB5QlNJdTBEWTNBSm5BaVdCTHNoQjB2MVp2aHNud3NGZlJ6Njht?=
 =?utf-8?B?UXg4c1J4WHBXRGp4aFBvaE41K1E1VTV1amVVUGwvN2hSNEVGc1RVVXU5b2dQ?=
 =?utf-8?B?U3VWMEsvSFo4dVRmdm1wVVorOWQvUGNhcnB3WHVydmRmZ1kwYVJqTURoMUJz?=
 =?utf-8?B?Y25hSEZXTlJJZlpYK0U1QzFLdUV0OXQ0UXVycTZPK0w0UkpmSldFTUVMWGNH?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28603308-b3a0-4d84-0011-08dbb4eb8209
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:26:19.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV8u4+TYfBqFcRFeiB3y2XXLpnMClY5lRnQbql8FVJ+DFyHJFvffNMDlC+WBIoV7gS1USTBkWZ0r7W+2g6oVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 06:26:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13131

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=9&day=14&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/09/cip.2023-09-07-12.02.log.html

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
  - kernel.org tarball uploads

Jan

