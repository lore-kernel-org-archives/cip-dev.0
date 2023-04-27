Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB8C77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 07:17:31 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.76])
 by mx.groups.io with SMTP id smtpd.web11.14627.1682579848289516246
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Apr 2023 00:17:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h7A4fSl+;
 spf=pass (domain: siemens.com, ip: 40.107.249.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhFj107hG1/8GxLn4XFP8clvQLf/ZVMbHbqRsZz5lmMcI1WDEjRdla0O30LiBQUj0Z2JhO1TF0XGq3t8LMOshH1jDQ8H6Dimkzar+34wi1f2b+wKfdLMzEqu2iKh6alyXFIXfQEu4WR5vHyLsysirH/xZIXcwfh3416XZjyS2N2ZN3BJB3RCJLTRpL36T9qqtHOTAC9j/oqEAKPiYVjNYt9Bzcfl82cRwfDDhUeia1yx0UF1+OB0IjFr5EJp/vmTxo2Zz/xSX2JI7EWd7Zm97gagC6imIVkCt2l8VGt9iAwgWk/QAqSVUt7QOCUvcDrM26t/gzyP81PB13wMkCgZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjghaPi+lmt12WnspeWuf39fOhGY9O94uq+DR5qYTH8=;
 b=NSqwXP2jhhEJ17sdJ9nbjwnuLAHuiiM4AH8yR7PVD0RwONShzvfJiwf2OXo1WK/Hb8Nn5DMOayyh7jaBMJ9i8fWmEn69S8Cq2AttN/GwLBVj48+4k+zqTNJ5/4J76YStyes/eRE6uA00JsVQfuvM+gdRT3XfcBekWFc4a8wITULnVUUfRPOdt0BPDHPw1Gg/82xfV3tFzfZzb0MMl+rE13kZl8W2nek6lilWARl1ml7erk0WyH66DK8krWXGx5EjgWDbcLqfnQScr1KyPUxThEVxu/D7VJ4Aup9gH8YfbZ5zkZjBT07FKkN83lwFscFvq+Y+nzVHJlVoToVYx7fijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjghaPi+lmt12WnspeWuf39fOhGY9O94uq+DR5qYTH8=;
 b=h7A4fSl+p58IMZuZMZT9A1Xdlve4D2AArDZUUsDQi9u11ZT2ON0sLjY6Mc9C+G38zWDPsgR1spKE7G9uElMxyJWBngtuW6g2sVfihZMqFX6cjAqXCVeLpQ5RC8Z9izHqUa/5BwqXosr1BJhA3FheyopMeAuVW4TPsYo8kDzRDxllOqSmH9QeksKRpZOdFhfk1Hbprcfm/6dAjUVVE25JkKHwntolymDVcAAn3UEBjjIcDwUMQtJipV40Q8AsQ7Gl5kVSM1SD7VneOHJ6CusODOhMlxRX6lU7rj6TBVPjxRbq7w8QuEXUi/O4wkxQldjm0ASMxEJg7JLrnbsYpdUtGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 07:17:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 07:17:24 +0000
Message-ID: <cbb01d78-4efc-004f-59fe-1403f7dea35f@siemens.com>
Date: Thu, 27 Apr 2023 09:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: c105d135-141f-4f4e-dffe-08db46ef7301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SNS3OvqMAYEgIV0b0RMiA0J8Qoy69rhTfoEoFY5nLLNQCEsiW5xYuuUacn5fXly0cs40oZlOhrU9loOIgML2PDSCYHvQTkC3ZSjEVdVIsmtwwDP2p7Wjm2Nnwwv+jsLRIskqRSXJvjYjk9YPDWWyt2McLKdwoGSDbU78m5nxcgwb1ARtLXy1eBVdlctl6QzwgSv9yeP+g1asVn99X5xZg375eMkdvGoJw+O33Ut9ruKA7aMR7WwVYR4LBvvV37PW3Uxex0iYtPyqTIRNhNP1n+SdW5csfgRQrsnaQX4iFId1FnnytEg5ODeASGQnS1ai2KCTwuFrMRqqXT8IbrYSD2bxWSkJYmWcrrTC6rElea9/WW4DK9nlNVhGGI8vjRdn4lYnfzpCR14n0/DRKbINq5623A7RVSPxZYF8d6dVvmplYDdFrVT06gkiy+W/bpk28yJUuI6/k4Cu8ZVJC8uQSLUBRLrd4FIFFier1GnvHqNS518bW82K4Qm1exA3n6rBXUG5VP4qR1sqgCJ/hwxUjlAaQVie8VKURrjA6z1GN9u7hdFFBjBJrEOEZMYODOC1pXEHmiviyi0od6krI6RTt1eR543CD8TqjJRoOYAvGrxlsv0WqPvr1ZUU7C8T0VjfaV4Av+Ys7IB2QfO01mubAw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(38100700002)(41300700001)(2906002)(4744005)(44832011)(8676002)(5660300002)(8936002)(82960400001)(86362001)(83380400001)(31686004)(31696002)(2616005)(966005)(6486002)(6666004)(478600001)(66476007)(66556008)(6916009)(66946007)(316002)(6506007)(36756003)(186003)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?allLR1lUL25JM2RvSkZYUDNkbnhsV1V2d2N0WXlwVFNvQVhrbDRMS3hyL01j?=
 =?utf-8?B?MTFoQ25keGpyNlJJMzNhRUxIeXhwWVE5KzRCeDJzeVNJbEN4bXlSRHhzU2Jw?=
 =?utf-8?B?ZzVoQ1ROUFdWcE1HVm5DVFFVSWtjYjZxY24xTEVFK2VzVzZKYjJpRTVuNGJu?=
 =?utf-8?B?S3l5aGlIUXJxdk5XOU1BMTZlTjV5cnl3RFNZQm1pck5HOVAwU0FpeFVZYVp4?=
 =?utf-8?B?blExbWhpL05HM1M1bzFFd3JiNjVGVGR6VWtlSFpOcU9OTDJjdHBnSURLRllz?=
 =?utf-8?B?bVJLZ2ZPRUg4eFUra0F1MXpqNlQxV1BwZ2cvaXNMQmwrbFcxV0s3NlRxOHdH?=
 =?utf-8?B?WE1RMXlNajN2T3piOTBqdlJnOHh1SjdnMzFMWi9HekZRZVBUNnRTS3RkcXBP?=
 =?utf-8?B?NnlweDd4d0lsZFBTVnQrWnVidkkyUi94OFI5ODRPNmlrQllSMUhVZjg4bE9I?=
 =?utf-8?B?RU1uWGM4cVNUYlZsNEZjd0VWQ0FCVU5CM0tQRXVtc0ord05sVU9QT1dvNEYy?=
 =?utf-8?B?MHJkT0NPT084bERrcU5XYStneTBsVWFISDR6RTFrazFxMWk2Q0hJUlVxRVVz?=
 =?utf-8?B?bTFpY3R6b2lTek1ma0gwQkM1MXFlZVBaVFpjUWFYa3BmQzRVbUtXZ3VpaCtQ?=
 =?utf-8?B?Y3FvK1d3UnU1TXRKS2Z6UjBrbjdWa1AzOXc5aUFNb3gweXFNWW5IaFAzMTlw?=
 =?utf-8?B?WEkrY09WNFZUeGhFQkFRVUFuZjNUSVhhcHBYbW40WXdJZ0Y4MFRka1RkTG9l?=
 =?utf-8?B?dnQyLzRoM2xEdmFVc2VtSE9wN2QrR3ByanFoaDBUK0JFVnRGcTNSbmkrb09m?=
 =?utf-8?B?bHI3S056RDkrQmcvWmd0VGp5b2xBUXYrd3NxQm5tTVJ1MzJnNlNlVldvbmNn?=
 =?utf-8?B?RkJEZStJRHdsb0tPQ2xISEFJcVFtTG1tS1pUdlJ6ZzZvb2lTalhvZnJmTXBa?=
 =?utf-8?B?ejZiKzk4Y1MyYjlFOEpBQ2VtNkNlMlp2RUltVzVhZWlFYW51Y0FPaVkwSFBK?=
 =?utf-8?B?S2hadlM3UjVacXkxZ3pXV05oTHFMMzRqL3lHU2h2OHMwWWlHNnpPNmFrckg1?=
 =?utf-8?B?eXlId3BoMjJpbmIzcTBjUUVUWi9qcGRJOHJsWFdXRVVrWkRGM0N5YWUrQTdT?=
 =?utf-8?B?TFZQdk1xTk04cE1KMTgrUkRzTEt3NnF1UEFIcXdaRUtBWGhCWGhHTjVqRFZN?=
 =?utf-8?B?enNTaEltb281MHltdmVaWFZ6ZTlRNUJ0dVZIOTR5aGdJZmkyRnJ5am1XOTEx?=
 =?utf-8?B?TTllZ2lXUkJna2J0SS96bXlzVHcvSWdGV2FvRVZjZmRmV1lXZ0JKM01aUks4?=
 =?utf-8?B?T0pHUHN1TVhFVERzUTFIK0NzMmVYbDdlSklWeXVoa2NMR1BiSm1BcHJLOTlM?=
 =?utf-8?B?eGd2RHNGa3kwQnZnZiswT1k2bUxrem5oUG4xUDVsMGlmc1d3Vk5HSnZVUk9m?=
 =?utf-8?B?ZXBrZzR3NTJNMmlDWEZKVUI3bktIWVBoM1VyZStjSDVuWmhvUnN2OEZ2YnVC?=
 =?utf-8?B?eVIyQWVWT2gvWVFheGZONys1SXpSdU0zWE5QMnQ5VXVhR29jdWlOeXUyRUxS?=
 =?utf-8?B?SzRmeXBFRkRNbUxTSGVZTFRVZTRJS3FVeXlGUitpWGljcng1MDk0NjQ5MmE2?=
 =?utf-8?B?Y1NmZmlaY1Y5R2xUdEwzTHc4NTdsRC9RWHFVMEdMOHZ3elBPRVhpMldFYmtq?=
 =?utf-8?B?bEFSWlg1MzQ4RjFTQTF3M1JMbmNlbjJJWmJrWWlKVkRvakNvZ0JWOTYxeHVy?=
 =?utf-8?B?c0k3ZXJHeThSdU53WlVrU1IzcmJyUC96YVZtdUJZeTZLMTFnWHJIWUFlMXc1?=
 =?utf-8?B?QUxFN1ZFRDZIRWk5aHpVdm1IcGRYamZSUW1icFN5WkdZamN2OVA3eUJ3V1JR?=
 =?utf-8?B?Q1QrQ0F1TjlkSmJ2KzdlN05oeWFoSFRTR0pPZkFaNkw1WTU0RkliY3M5a0I4?=
 =?utf-8?B?UE8yc21MTUhDSTk5ZTc4SWhqbE5vOWZjUUJGdFd0UVF4NzhvU2YwdGt4R2x6?=
 =?utf-8?B?T3VITEVCUGdXaXBadERZQ0JHYTUrVEl6RkZ2azVPbEQ5QjJZdklicWJpNGpk?=
 =?utf-8?B?MjQ0UGpmYXA0ek8ySTBsbW81VWNOQ2JqaVFKMVd3aWp0eU9jNU9BWmhjWm45?=
 =?utf-8?Q?tWIWKlpkTPU+agsnGfemmCouv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c105d135-141f-4f4e-dffe-08db46ef7301
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 07:17:24.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBj0w7wDbRxNh/oNpALgG/vCN66oMVtQke3tzNq3yfULeD0935SPpdlmUFicyOBx+tUy6gs5QIb3HkCtd2CZWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7572
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 07:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11360

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=4&day=27&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-20-12.02.log.html

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

