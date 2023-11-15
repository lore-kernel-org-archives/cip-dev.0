Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39406C54FB9
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:55:37 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.49])
 by mx.groups.io with SMTP id smtpd.web10.15189.1700060135353987743
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:55:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vX2abeuE;
 spf=pass (domain: siemens.com, ip: 40.107.7.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEhJiyW4r6u8w6VHvIwsQJANBys9OLO+EP/kb0U4BdkhySLkekLy8HMrInoaSQsdbaCiDIc0IOcAwd0EhTw2pIHNFKq8gl/lRLERcqp04hAPovJxiHDZSn2JHoXWCObM7CdGA0IxHBgMEY0JxlouFQ3px5+N7g0IlOl+lyEvlG7fgLIJZaVWSKyRy6pUROoz7Duyq8SfVTXBqydCxVTrFwQ2Lww7ePdsHHwIfm7RW1MkmksjSUXDVCaQthPOO+yqWR2ZGYeoQJlbKAcle6lUd8b87tg1nCrrxkWymYpkaRozrg1xx17/5MXBcc19AiLrUnuAbp36IvkYRGVSRNVqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHxXuuGGuyJb1jdU0Y35/rL1n8lhWk6tGsNU8IFSlsk=;
 b=ZG+qiYGNvB2f/niLmiRWcYWhfn9y7D1TTW63R1juw1OoDFmnu3BPDa6jcWS4zwE3hZeDq0qXS5ptwUNHxhOLtHWBHe7ngJGycAT9gLajRkIN30dB2IS4EzKH+Kw3FTOjKcDvdq8ubgkhkXGGqY38jHj3HrAdrwJElLT/CIXDeFl6ACbcGv0yDcCe+fpSjKYiv0gjsUeOHdlbynPHoZOthb7/8VHRyebkljHFvi/tfnM1wNFadPPEoPXmbGTJ41+6m8ITfEpAGXahfGNil8rdguFqN9NuaGata598Nzfe4dUI/uVm1RDNSP82Vyx0LDjP3vgRK7+y1MVoJb9jin+k2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHxXuuGGuyJb1jdU0Y35/rL1n8lhWk6tGsNU8IFSlsk=;
 b=vX2abeuExwCsZUkvOo/aCauI9tvSIX7m7iAkxtXRmufIIC44Eu5vsgaf+xVjL6gQL2CafEUJ1TFTOWAu9puAnhgtfrCbknDdypGnm7geN8GjMFFodDovZWhfo1dwNjq7gCScw0SBgSr1SQ3yqvs5vifo6JDq0ZhlQtr6iHR3KsX/0rzCc2YJAzDH55kNgpnRJLRszF4vQU/5Tb5xJMSVZwx/unRKhmiKvaSj/LjmmMWH37de4eUL0tW2KQK1RlEkYhfANdslRqktKzNBoDSy2SUolt+Uq39zxADCTmQFOzkr+zM7E5l9FkmNj6we4GRcOXQIipWwq6FRzWGZZKzdzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 14:55:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 14:55:31 +0000
Message-ID: <445986cd-4714-456e-8117-e349b2860c8b@siemens.com>
Date: Wed, 15 Nov 2023 15:55:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update debian folder to
 2023.05+dfsg-4
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
 <eb98a52d-9bd0-4583-a148-81ef1253c6ab@siemens.com>
 <6e0de253-9504-4de8-8b23-849d6dd2bdcf@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6e0de253-9504-4de8-8b23-849d6dd2bdcf@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 03709c90-2565-4850-defe-08dbe5eaea30
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+PQgBP4FR+9FvDVi3FaP/nlrsLKFdQHTLo7rZ5sXR496eOVtgWfZKWXcfNBtF/X1c9q6EA19hV5XW8dM+HQ5Gp1C5Yui6mvXjIKUxF1xzafALW2I0y1ctvvibNDj8/2b3hCq9hAD4W1af0DLvrC5eMZC3sJaOhWPiKBNeUJ6YwCS7AMxAmhVe+sMKe4lXTSeV2FibFUvaeDe0iGsy9vWTcpqUMaer8QRoBGeu8iQK8a/Th1EUL2zUh1VqFGefvvW5fagHhIzA/PcIfdGgWagLgwzt9UEFm2YiGPTEsOPVg4MsYHvGfOn1HT9KYAyMLQFadAaJ3owkCC/E40rdhzbc6rDykyUCz5BAmeuXumNQ/z2QV4lthUIQjGUIod32aHvGuGrh0oxSgZLt3mPTgcfcv99ma2c00lgQgsTocvRWvlVDVRK9d2Y/kE8YI8KIY5CgeYPbSaOH3mM9W/EEWV/yjMXlRWPq03fl6M4ZstKs2WGnYrbYN6bSucU9yMaHrqI8/rf1XVWVEoJkl+n3i+Guw6ZgQNYlylncAJ+0I61RQg0a5LQ3HUiyTfgxpG/FIJnqHsKtzNdPiTkKH9yArhmWlt76E/8UNDfxY6a9Yw6qY45bJ7ue5bidXR/VeJmIfYjcK55CYBvxQ9Vm6pUnhDmFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(2616005)(44832011)(53546011)(6512007)(83380400001)(8936002)(4744005)(8676002)(26005)(6666004)(2906002)(478600001)(6486002)(38100700002)(31686004)(6506007)(5660300002)(82960400001)(316002)(66476007)(36756003)(66556008)(66946007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1h4dy9mWE5MSmRiSjEvcEhQRVNsMUxCc2ZwUDVLbU9yM0dWODJQbEY5MGUv?=
 =?utf-8?B?NmVGODZla1ZkalkxcWJiVEk0cWhCRW01dlJuVlo1UklvQW1hWGNVV3VWM0NQ?=
 =?utf-8?B?Q1BQM2lHS0tKWVppaUc4RDlxUlByamVzZ3VCUmdMTHcvdnVxSkpRTkRtSkxU?=
 =?utf-8?B?TENycG93NFpaWXIwL1FmeW5tRFNia1dHYzBpR085Y00wZ1k1dFVxd01Za1Bu?=
 =?utf-8?B?YlJJR0JHVThpakx1enlNWUQydWcyNExTSU94SnVxVzhLNlRvOWtzYVZ1NVNq?=
 =?utf-8?B?V1VBTERQZXlVeGl3SGdNWndyZ3EzWTJoV0swQk1oZ3IzSzFhRnNwbXRKU2Rs?=
 =?utf-8?B?dms2TVlzUEFyK0pKK3FoY0sxdWRtM25lRTBIdUhhSW1jcm51ZlY0NlJid1lC?=
 =?utf-8?B?VDdXcXQvNEwvZVV3MzZ0a0R6RlpqN3RTLzVwa0cwZEh2T1hRVjRKN1hKYzVw?=
 =?utf-8?B?RGx2L3hQdXJyZlZmaGN3QnRkWHRDUlpneWtKaDg0NVZ6N3MvK1BzZmJyam1B?=
 =?utf-8?B?ak01d3RwQ3FkRnIyQVc3L0FsWDVXQnpjTDVEV2NyOWdpbFNjaEZSWlhrWUU1?=
 =?utf-8?B?MU9LMHNaL1ZjZTBHWkU4RVFOQmVNajQ3VmI1UitrcFJPYWpiYTB6RGhQQzFI?=
 =?utf-8?B?QmNMV2U4RW1QK21XdHpGMjFrcSsrSHdOcmdibTJjZitLRm1BKzJSVVA3WHVH?=
 =?utf-8?B?WHJ1VjI0bU9HSlVjVW5WYldHN3daTjFuUFo4WVBadVN3Y2JXQ2sydjRnVnZy?=
 =?utf-8?B?RlpwaXlEMmEwbjFNMjdUS2Y4NzdWMHFkeGh4MlA0aEdYOStlS0ZKSkJSRHkz?=
 =?utf-8?B?d3pMSkVOVDZIRy81N2M0TktSdm9RY0M3cmd6cXozY0NhTGZOeE45K0hKZ1JT?=
 =?utf-8?B?MUFQNjFMNU1Na0Y5a21uVFp6dk53cXhiMkpBeE14SVBEZnpoSjZhcUVhTDNo?=
 =?utf-8?B?eTU5VG4vNlJnblJuMXp1MnZQak1ONzNCcks4dFJ2T2F6VXlOaldYdFg1OGFZ?=
 =?utf-8?B?Y2hJOXpOdGlqcFR3OCtRVWJGZ3Yra2Z4V1Zpa1NSMHhFRUphbmhRME9Zcmkw?=
 =?utf-8?B?MU4vQmNTeVV6d04wTE1IKzZ3ZHlpcXRCb0ZRU2c2SHQzakhPUWpqZEJxTytp?=
 =?utf-8?B?MHNKY2t5cE04bVM4d21VbThoQ0JRNGZzaDMwclBVZ2xnNWdFQW9kRnVqYnFY?=
 =?utf-8?B?NnpQVHlROTljUXpPMWZhSFR2MlY3SjliYVIrREFMVFNpZVVzVFFrbWdmYlpV?=
 =?utf-8?B?TjlqaWxFMTJNRERqSVVESVhmMmtSa0x2elBqeSt5V3FwT1BxZUNLODFEbDl2?=
 =?utf-8?B?d0RUWEdlZjQ0Q09ySVNsb3laRWhqRHdIR1prSlA4R093UFFBRTMrdWpEMTB4?=
 =?utf-8?B?ZjhuUlhFZ0FXMmRrb3UxdE4vVXVyQ2NDakdSSGw0REQvSzJHbEwya1huclls?=
 =?utf-8?B?NnEyL3lGdWprQTkwQUN4MStDVkpFRWxKMDZaNWR3NUcxbXJtQ0VqY25mTHQr?=
 =?utf-8?B?RjlmUGVFcW5qSlMzYUU4Q2hUSys0S1FzOFloUmJkZkpZTHBWTkd2eWZXWXYw?=
 =?utf-8?B?ck9UTkk2MEYvcE1ETUZXV05WSWZzdmYyMnllY3FINGVRVTB3WjBvbVh2Qllr?=
 =?utf-8?B?a0lpM0owNUdvbEd1bUt0Z3dVNlZkL2kxcGtCTVg3UHBNT250dHdqUGNlTEhk?=
 =?utf-8?B?THc3S2NacmlidjhsUW42SFpya0E3Q01JOVN3NHllZWt4Y0IwMTg0TkF1Nnp6?=
 =?utf-8?B?dkRySE5EWDhCTmRuZjFPcFQ5MEJacFJpQmxCMUd3anNYYk56dFlqT2oyRXNp?=
 =?utf-8?B?WDZtYzFXc0tic2xGUWZsTXhWT0RHbWs1ZWpFL1JNU0xYUFVDL0p3bUhsc0hI?=
 =?utf-8?B?TnZTcXdIbFdsU1RVRmNHQUo3azZGRWptdmF2aXBIY0pWTlZ5MmVRZnBrTXFW?=
 =?utf-8?B?QTJZaFVkOEF1YlNHS2tLU0xoNnVpOWVxeFQzTU9MQ0gvaGQxNFNZa2l4SFBP?=
 =?utf-8?B?M0k1aGdzNDMrQVV5ZVhzRWlScGtmVXBtQXZaN1FwUGQwdWhJc3VvZXdONE1X?=
 =?utf-8?B?YnNFNjQrSjJpcFZwanZXRWdaMlpSc3ZwU3U4TDl1cnIzSFRJeUlQaFZNdWE2?=
 =?utf-8?B?OTZ5bjNjQzkybE16aXJqaVdobExieVBZd3I1b2gxUWsxWmhIRzg4ZjM0dGRx?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03709c90-2565-4850-defe-08dbe5eaea30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:55:31.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6JMJTIJ8wwDwD8xJCBkJtLLFS0Ewn5zHmMkPWchlxVImxKHV2qCHk7aA9DQr6YVg5faaYtUSrN4ZzusMFGWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:55:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13588

On 15.11.23 15:45, Gylstorff Quirin wrote:
> 
> 
> On 11/15/23 15:40, Jan Kiszka wrote:
>> On 14.11.23 17:37, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This adds the system user swupdate and changes the permission
>>> of the sockets to 0660 instead of world writable.
>>>
>>
>> Stefano had some concerns about the best aproach. Is this Debian
>> revision already reflecting those?
>>
>> Jan
> 
> This reflects the latest communication I know with mode=660 and an added
> swupdate group.
> 

Prefect. Applied, thanks.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


