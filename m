Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A43C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 06:45:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.80])
 by mx.groups.io with SMTP id smtpd.web10.25390.1698907521217124152
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 23:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OAEmrC1h;
 spf=pass (domain: siemens.com, ip: 40.107.7.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFIWlWUMNuVM7SKeCPuXlQlOZDCY/XKkqic6pwbr/4lPaaOUv9sRLkSCKOZTxu0RLD7fhB4tQ1+dUuCqcIoMVML2RWKo2DC12lN2qOduq1cTQRuZLMgTCL4UyPLqBjA+BWYWp5Cmerb+EqGeH2mnz/S2yWHDmDgTLHGvn5WAJDgWtw6/VAbX7rlbDLkWxRX8/M1pUu6AJhP+GG5u/YrwEhLq3sPj2a2deyW3C8/Iku2JVrhddOQduu9z/D5EXn714/vub+sxik0qi6lVdkxSR4U5srAhzSjH+L0rxk7S8yoE4KsSfGrFsP1tQ+WJLSRbnjkRuoawcSGb2rqs7fVMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18kpGn6x5TV7qKaAw2quxfEcwt+9NwneGhm5TcgJewA=;
 b=NIR0dStRjmQ3OpKbeoAwrdj4DcJqkrdPADoaFEm+PvhmOHdH0R7oBiAoRlbo3jBVoDvAY1nJ1oSgGFiVcvilLKf39sY3evszD1GptvBk07m9qf/S0PyqCMxTMHZ64nAQhV7urtzRoHs55ezlDpg0zbuf+a38MyJ7YYGZ0hdOSK55upJ5c97qGl6fjnlUIIBD/suBrSe5iJerO4moU0IiU4S32ZtmFEXMfsxs2r5j3DnJWSI9T8JqjQWmfcOpSvhYh1HX7zfxir1TffPCTQba9OfobCTQ1yhzAD1LeAbXGJCdQMgT0Fpg6DsXCwivv4aNqfzpliylhS87ktf4Bfbbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18kpGn6x5TV7qKaAw2quxfEcwt+9NwneGhm5TcgJewA=;
 b=OAEmrC1hNPomF1PSJ4GWb/DLtYFVacADtixY2GL8MdQ6nFAJBtEn/vR9pwb3rGRZeXV8FBs1MResEr7dMVmtS+qAR9aSy/jplJzqQYsLuRk0WwqtV4x+1p9EPs8/YnHQOpEG8RQZexFZGG2aZgcYkki7+voNcVxXFqk0gM2hAAi875UQRt0BE8xEwWeBKAA9zo+/59mC4SCtyEc8m5rINqAw8S7FbyJUsRn+fy8G2qG+D5LfH+XlV7wpjE9VIPzJBk0St4tUTlI0YHbuqCer5JkDnaay7a+4VHo4ppMqOHbU/DLKro0vZa6F8rgOiQs1gwPxvtGIPfDolTTG3K2sJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 06:45:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 06:45:17 +0000
Message-ID: <67c7d06d-d2e4-4a54-8f58-af44989174b3@siemens.com>
Date: Thu, 2 Nov 2023 07:45:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat (daylight saving
 changes!)
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3287:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dafbc0-0d9d-4538-61c9-08dbdb6f46ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FwTzdRFakMwzMz409IZarpzYLcifFvX2Ycfvb/nQ6JUtBCWVhQ/qxyHjgWsRWV32gszarrKv+m7c+Pe0DMNv/GG4rOD8eS91D0pEI3IUBtGwbQhRCHxyj+btm8tkIM7/rtiIUoJh5dGcxNkbYCZUuJcFRKyzoGF0Kpy3lGGxFTmEvP4O3R3rfocDsQPsaHxrXeD+r38du57ZUyzvWT5Z4MJBPZZZkCJPAj8vWDd1kKJDq5p82+oAdEM1TAFLIXjZcYHppmQqA6JeX/f96oN+xLwTHC3tQNNw8XHaIikN7X0gLiksmR7SxegP7KhnaAJmuoTyODE6cHOAY9sUndocNWNFy5kgccKMjzEm4VSmNt/KpctQtQCpBgbGh2dY7vMde26oS6f+HxeEm9qNYfIIc1RjatmuQSbATPSkzQMMZ2XWGyeWv5UefshuJvX5tXfnhYYlffoo7zf7YHI/EmT5UfyzWLOGIRiX02VXEQcrPlWvBj62iL9JTKO0E1kfySzGhBse4tMCn9SDl5V2Exhw9ALCQg0Aa8BwhI0phV5gST8DUifRvJgxj062odtWYZ02CCH+1Nm94THHnZNO05m/DD5+XrlWZFg/jJguI/wfrsmNvFSXTV/8NBDS0DzVRUs1Kia+SLMIo8VaAasqVJC13Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(31696002)(8676002)(8936002)(82960400001)(31686004)(38100700002)(41300700001)(44832011)(36756003)(316002)(6916009)(66476007)(66556008)(66946007)(83380400001)(5660300002)(4744005)(966005)(2906002)(6486002)(478600001)(6506007)(4001150100001)(6512007)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmNYd0FJcVNPM29nRVJqSUpRcGIvUFJwTFpEa3hhZS9tL09FMDdDc000K1Jz?=
 =?utf-8?B?b05SSitDRy95R1FEdlNTMzVUd2twNy81NnJZQ2VMS0dNR3M5RTVJN2M1aG40?=
 =?utf-8?B?Z2U4a1p5MUtCUnJldzdOK0lqZFExWnl0YmV4Zkw0VDBaL0RxUDBPdjNhU0dq?=
 =?utf-8?B?V0dSWS9rbGdybTdFQStzK2Q4bE9yRldObnd1S2p2WG1mZ3VwSURaakZlQjRv?=
 =?utf-8?B?c0EyVUpDbTlLVkJ4eCt4OTNmMk9IOUNqaUtIQ005L1ZpdlBhSTRRMllnL1dx?=
 =?utf-8?B?VkpzZXFldTBQU2N4ZTBsZFB1N3pyMzNBcGwyQVNKVFlGenp3YmNEY0x3SUJy?=
 =?utf-8?B?eDRlaUgzanpVZVVmbVlueXdEaCtna1lTd3cwalZ4RXJDd0JYc3FweFo1cGdR?=
 =?utf-8?B?K210SkpFcTU3MW83ZHlPTmJ5V1JnV2NZWk15OVlQbmlhS2psd1Q1REVLNndY?=
 =?utf-8?B?KzFBdWNFOFdNZXlpb1dpYXRDTTk3MnlTM2l5YzRKc3NGQ1BtRm4rVG9ueGdN?=
 =?utf-8?B?K3p3alZGSk50Tk5KNDROUkp0SHJUMkJUTGVBdkFhVTh2YmM0TlhXU2gxclpr?=
 =?utf-8?B?SG5PMkR0Um9nemltTlQxWnM4RUE3RGUxZEl3cEhVSjM1bEsySFlydEVOZmZo?=
 =?utf-8?B?RmRZNXBVMjYyNlk2ZXlxczNyZEF2N2htbFVkM1dyU0l1RmZHZHdFRmZVS0tP?=
 =?utf-8?B?OHZGVXltYjVtWDdGOVZQeFJvN1d2RXFDUks5Z3JyakI2T0Z1ZW9kbTRvM3Zv?=
 =?utf-8?B?TnRKQllVZVFtRW1YRFdLM3RCZHg5dUJoT1dYcGRqRlR6Zm5vdXdNbjNLUlFT?=
 =?utf-8?B?d0oxNlVCS1F3b3ovSi9YOTRvOEVndGhGNGtOa2dGNVhJOEdzVURzNy9LTTdt?=
 =?utf-8?B?SnpaRTN6NDkrNUZ3cWZ4L3gzM2JRd01rcFZFajNFOWlXMHltUHhkL09UTkJz?=
 =?utf-8?B?VnNZWDAvRnhINzQxOCtCWmNBODlySjJLTmYzU1hYSWtDaG9FTm16OUU4bW8r?=
 =?utf-8?B?WllsRWZOSWhheTJFN0pnbUFZWng3bCtoTk43d00waTFXQzl1VFhwQXhDbVJt?=
 =?utf-8?B?NEo3TkVkVUd6VGZaUW42RXllQVF2U1VSZWpEOU1Ec1NtazVxRSt5S1VsSFRU?=
 =?utf-8?B?Z0gybU03M0hMSWUxa0dOU1BuNGR4WTEydWw3V1lpNlRHOTJsUnR0bThuWWsx?=
 =?utf-8?B?TmhzekdXekxqa20rSEhiV2pGYXFHK01UQWFWcWVCQU9lMk1qZ1p5V3NKZUZ5?=
 =?utf-8?B?YWdDY0xpMUtNK2w0TW56SkFDUUQvMTB3aGJKOUtXcjFXdUlpaEIyOTE4dFZK?=
 =?utf-8?B?ZDZqclIyV0xXYWkxVTRyejE2bVRJSStsVnVIUDhjUDgyUGNtai9zUTk5NFAy?=
 =?utf-8?B?YWowQ0Y0dXBic0xvK2pCQURxZzByZGVjVksxS2MzM1locGxlZFFSdkFMaGZD?=
 =?utf-8?B?eTVuTlpWalQ4L1JqUUcxVldGeWxha2ptUlpPT1JZUm5xSmtPVGk5TjZySll6?=
 =?utf-8?B?cFMyQ0RSajFDTEFpSmtlOWFLV2FObXpPTEwzMHplNE94QXRMR3ZoMHk0WDdk?=
 =?utf-8?B?SWZrNllpR2FvOG5zOFk4dlgvemFrS3pXN2c5TVl1ZHlPRXpCTVhld2pIS2F6?=
 =?utf-8?B?NzJiWmJ5R08wcUMzcVlmZ09QekxZMkh5TmxXMTVVQkFwbGRzWHdCTXpXTFV4?=
 =?utf-8?B?RXlRdmFQR3lsZ1FKY3VGUjVXZVlaTzJoRGNBRjU1emdSV1NKalk0Q0c0dTJu?=
 =?utf-8?B?SWtSWkxycTF2anNQODVacUtiKzJ4N2tuY2dkZmw1Z3RLbHZsRWNMK3dHSXB2?=
 =?utf-8?B?OTBZQXNRb2FtQmJiMitOb3ZrWWdrUnFZWEZ3dmU2amhNU2VKNmhsWjhVR3ZP?=
 =?utf-8?B?dy9Ec09Yem9BNjY5MWhlVGU2WEZzbHZURVlUVXRzNDllOFZQZW1QVEZVRksv?=
 =?utf-8?B?L1ppb1NyS01RRmxlUjRlVHdoZkJocXdWaHZiS1lIclpOYkJlSk5VYTZST2Z0?=
 =?utf-8?B?RGNuanFqbEtZM2VIRHc4elVhVzQ0N2pCZlY0S3k0bnVDMzA1SWs2UkEyTExi?=
 =?utf-8?B?NzErSlQ4MEhob0xrYjZ2a3FIKy9HSSt3b1RVVTEzNjc1N1Bna1J6ZHdHNWNu?=
 =?utf-8?B?aTNBMGpudFNNd0kybzdRTHpnYmtRbW9CaEpkc01RVkM4VW02L2xxZXpzc2ZX?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dafbc0-0d9d-4538-61c9-08dbdb6f46ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 06:45:17.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: airsjl1pzYb2b2Q2bcwbHZJapTs86Gz9poFWeMsFLri+8aHLKOcAdx/4BxaLUlgzWiI+OerdR08ECyR+2j4vfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3287
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 06:45:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13511

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=11&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

NOTE the changes due to Europe moving to winter time and us following 
this.

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/10/cip.2023-10-26-12.08.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - re-check if CET-anchored time slot is still fine for everyone

Jan

