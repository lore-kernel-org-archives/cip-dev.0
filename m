Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB02C83F2E
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 06:08:04 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web10.10723.1693462075809102361
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Aug 2023 23:07:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H+gGecqd;
 spf=pass (domain: siemens.com, ip: 40.107.8.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EphQzaI3XCd6UuImDZ3saUpPC1E5rSux+9UZFiD/HQDtpfGMpKfJoiKywRq/PZBflq7jgpdG0gCI/jj8dmPKihD5SMDOMXa+i/A/pvIQnbTXqnTEJVxK9kzyscKe64Ee9xWm9I6n6x1I5tPIaSpnYh7f9RUaR5TWriURy5cdGZsaW9wkXiBXUCh2lQCqTRhQLViAfasMDnA20ptT66l/6VgDqxYbwAgZqgXj9BDXIEgUIcNsGIm30XfZvqDvVBLk3OWL1ew/alNyocqVvg/bI7agzRJhJy1VOQcvpzJPrLgVTWcGSKGsXbneoFQMB0Dp1x5PIUM42d7U5tE712fkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg9RzZKlZF6zmdTbkLERxAiLYHwdiyUoS4Yg+WpPSGU=;
 b=Yma6RWm1exb1tuMnZouDDwMkq7UalNe/Ck84t5h8u34kJL759LW9TISrNR54YfibMgYsM4eG5LlSXWR8qYjzg0NgBBB7B2Y8adt5oJFqUKSqnMnHtHQQm+piq9idP7G7slxAehpcDySFP8qZT5F+E4xPs9/NmQAfIunQ3BPy5jaFuipFEBZwwfFlFfEnyEbTSVohS4jRjty0skKOCsiE4n9u/epdjM23/t36MWjjtTqDib5nnF7XGb93NtKWVotZ9PpD/QXzPDlFUL6hqbEspeqQXYw1PxgjbTY9fS6cnKjcUVJCaw0YI8NlQXzKHx75jTaOokbVOxwOFGMQwgvC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg9RzZKlZF6zmdTbkLERxAiLYHwdiyUoS4Yg+WpPSGU=;
 b=H+gGecqd+71lmtaBNjrx1VJlZttj7Cwqy2fveR7Nd7NhjNwK57Ryr4T/zNYdoXG18ryA/6H677OUcotmOU3V9Vq9ffAVAbf17e3XtUwQwJw+LVzQpFovJPGfIPKkgSiR4hB9EcXxsIGvyIT6Qac4xXZTezBz3U6JnvhAzNilJMqXUd6W4PsM5XQ2tQW84YMv4U5zuEPvancMXpncJP0jMwgcKrd1Q3id8hV8IGMjkZZtGN6sjhJjtV/lpn4ja6+vInR+VdABafMpNdUq8eg32WiBzdeWWaVw/Y1ABTLTjl/U7JbzfChR4+il0s0SLNXh5hoFM8Gna8WjsGHv4TARqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 06:07:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 06:07:51 +0000
Message-ID: <4f31d6d4-9ea8-4f7d-ac61-0ef41ae37464@siemens.com>
Date: Thu, 31 Aug 2023 08:07:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 792a5f70-1366-4ddb-2985-08dba9e89be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HonZKpDKSl5SQq5Cy5doUzjG+qWPBsrAKAQGnlE/cfr9qBj/NPxsTu8gAwsXo/4WgjDjYp6cWDPvEH+aBkTz2XGiT3Q7a3bNqu1tw8SV6+/zSopLnlQJcLCPm/EHPGPV2CS3s9rhirZOJUtuLId7qIN4iUU7dsugDmPXcNtWt3F+lEQJMRNSQORnVOwr0XQq+LFs/+2kuCy+aQm1XCQagI3yMeFetkY7WLtx1008QcfRE9qdCBBasCDHnZFxT9C6O76+2/+oDWF4z4eYLCOyK1AEEIrkDPELxNWCTGYhWARdulcBIarag0SSSZlpLwpyrB7vApAab/GAanAtVORCSR8ZaoqR2sZe4ndownzCCPBA0rdUPge99+3H2msq8Fr/qbaM06qr+V1VtxHBOZ2G2zUW3fcRPaWmSr0d9rsNOtbKqCpMccvEIOIIHkTUEo48P0AzjY2Vrdt1alfW84rih4MbO8ibgaCMJefvtoruh7OhmHc9lmirpo1LjEvjPNCph9/H5dZlbscMNS/KYXcokWuiOMBartvqfNLS9KbE/uGboVc9lEDluJX/dbNyjk/830soNaGxeEjBrHiGWqnf2p6gUkbvgv2Y+DxxQwhLNEAorvz6E+hJK97nAkhnHtiNc6YAPyB6b3mRDsI3OjCbsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(1800799009)(186009)(6486002)(6506007)(6512007)(966005)(478600001)(83380400001)(2616005)(26005)(2906002)(4744005)(6916009)(44832011)(316002)(66476007)(66556008)(41300700001)(66946007)(5660300002)(8676002)(8936002)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bENSN0JtaVlCSDl2R0xremV4bUlTTWJwb2EwOUl4L09yb0REUW1oRDArVmpO?=
 =?utf-8?B?bTBDbCt6UlV5QStYZ0ZuN3pSVTlXKys5YXMrdkFGUFZ1NGtFV2dVV0VKVXJS?=
 =?utf-8?B?VzM3alpqU3I4NXdVL1BXK0Noc0VteFZJWS9SekNUdHc0TFcyczc0NU5lZExE?=
 =?utf-8?B?bW1mZVhDUFpCWVhBa0t2RytaM1Z0b01taVNKaVY4WVNxQlg5VG9abGw3azZG?=
 =?utf-8?B?aHYvSHRFVW5LLzBiVXVaS0x2ZS96d0NvcHl2UC85eXg1amp5UmNwNGRMNnBW?=
 =?utf-8?B?NVQ0RExQSTdvb3A3ZThDNEJrMHVYMVBudnV4ZmY1VW1qcHU0OTlDcVFoRCt0?=
 =?utf-8?B?VWFuK3VYY2IvWU8wLzhPamxhMXcraGJOTXNaS1dmbnJHNXQrVXIwUk8xaXFm?=
 =?utf-8?B?L0JFMkxGQnhvcmFlV002RXcrOWMwU1N5Zmp5SitpZ0VLaFNEUGZTT1JTQStl?=
 =?utf-8?B?N2Rsbmt1TS9iTGhZMmNqZk9QM2xZa2YwZkwxNDZlWUZuY25xQkYwVFpURlMz?=
 =?utf-8?B?RjJrbnAwZUdaY1gvais4bnh3Nld5cS8zdklrZGFLZ3BMN3VZMEp6OHdDTFUz?=
 =?utf-8?B?dkpJUmRac01KMTV2SFNxUy9QQ3JSaFdCYkV0WU5ueEtDTkxkaVAvUE1mZkFi?=
 =?utf-8?B?QmdCbEI3amQ3cW5tYllGenVGYktUV094cDg1SmtYT0l6VlF6TUFTNWdKMUFN?=
 =?utf-8?B?Y3g4alhkcWxaVnh5MW9XWm4zUVc4NXUzQzJmdHRDNG1jWThheWlPVmRwZDA0?=
 =?utf-8?B?VzljcHhJNHpDWFRaZVhlaWkyYzhPYkdIVFZoY1JMcTkrbTZJbXhOVWNXTjVX?=
 =?utf-8?B?eUduakdiOThVUTVscXBxTFVaTHBMZzBGd1QvK0JmZldOZWJOT0dVOXhjanh2?=
 =?utf-8?B?dG5YTUd5aE5KZ0FMdU00bjIyVGVyeGFub05FbGQ0by9rN0JaeTBOdStSMFMz?=
 =?utf-8?B?NVg5bmNnWk1BcGJSWDBvRHlxZGtBQllwSzVvS3ZrQlVGME5IMGNqRk5lY3BC?=
 =?utf-8?B?NzVVblNpT2FGbVdUVVNWeGJwR1ZheUh6V0crY2hLSXBpb2hKbXZDQStmZkFq?=
 =?utf-8?B?dm9sMlZibUdUV0hNNVVlU3g4SWVpOVhXUVFPMWlDUFA3K3h0Qk1lUjdjR1h3?=
 =?utf-8?B?Q1RRTmN0aXFrQkpzMm1hbEVKaERPQ1B0VXhoclhCYjZqSFJGMjJSdnhZdVoy?=
 =?utf-8?B?TVRLL2QzQnQ3QUZ5R3R1NSt0TTFoZ2FUN1B5NzJhbnFzd3VPLzdVdWg4dFoy?=
 =?utf-8?B?aDdaUGJBc1dMQTlhNmJDN2lWVDh5azRCNVpPdW5uU3BvcmZoQjcyMmhVM291?=
 =?utf-8?B?WTR4S0o0WDN6Rlp5SC9aVGlUUXNGUlNvMDhoYXRnNitkOWl1eHRIRHRCTVJS?=
 =?utf-8?B?VjRKNTNnKzJNZkw2R1hiSkNPOTRVejZWK2lUSis1cmM2dGdnSHhIRjZTeHpt?=
 =?utf-8?B?TkZqM1JxSFNKRlVBZlh5a3REeUwxYkw5L2hnenFlN2tnYXFrNXM2Q1h4Znly?=
 =?utf-8?B?R0VIclgzQWpUOTk0MG91YUszMTFHRzljNWFKeVErNG9JWExlUVRzNDlQTTEr?=
 =?utf-8?B?d21QemlMVXJYdkpYenpWZDJCTWVoTVJjS2lxUGZic2ltY1RvUUNFbWFLVm9u?=
 =?utf-8?B?ZUlIeGxvYTBaODdjQnpsMTNMM0FOK2hxTU1qQ0U3UTFFbDE5b2tkNFBiZm1m?=
 =?utf-8?B?YUw0OTJVbFdGZFMzMmJQY1hxR3lDZExCdDhQWHR6YllCMjc4OHc0aVExK2xu?=
 =?utf-8?B?RXdDVXpFTlFTUUFsSktKVnk2SXZsQ3RuZTROVlVmckJ0cWc5TGR0OURqenFz?=
 =?utf-8?B?SThmeGxhdm5lSmRGM25aM003cWdGQzhRRUZYZCtuTms4U2puQ2QrblUrdzdr?=
 =?utf-8?B?UElBTk93UDVQcVVxNjVmeVJ5czFCVXY2cnVuVjRiQTQ5SVhoNVpUUXAvQlVp?=
 =?utf-8?B?RnVzNTVDUGg0U1VxWngxR1lRaXoxUEMzd3hNc1c0angxQTU0OHBYbHZrVXJN?=
 =?utf-8?B?Z2s0U3k2dnA3NjAvbExZTFZrTGxzNHNYUVU3TmlnU0pEUWc1M1BWRThqNnhw?=
 =?utf-8?B?YzNkaGxheXI2TENGcjVKSlY2TVZZNC9yb29aSnpra1RDdHV5dkprWTB5SmhK?=
 =?utf-8?B?ancvSWttZHpwOEJCby8ycGpiWkN3b2FMQ1JPNkUrMzV0SUhYdDFsRCtRMUsy?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792a5f70-1366-4ddb-2985-08dba9e89be0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:07:51.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOctpvC/BTxfz7V0gKRbF5qJkviPDlQuh5fvqNmAxsxOvnyHnMFsx4SnPIDDdgUmWDzKitvdH/cLNcJDulZs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Aug 2023 06:08:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12928

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=8&day=31&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/08/cip.2023-08-24-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
  2. draft press release on 6.1 release (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - kernel tarball hosting

Jan

