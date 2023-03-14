Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58328C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 07:54:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.3604.1678780451038887791
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Mar 2023 00:54:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x7F7mk4g;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV4OiPymP4PWWod+yeZvvznD1lAylaltplWHpWAuRq+LVbcwOUm1QzXfFSoyRWzECPCEgO+t7zS/TU2fxKnDKQq+eteCItMFumpLwhE6y+m/jDFDshJ5Scyik5KlaXNz/CQANcYcOc5Sf2mmyYk29hsKH9YwDPjQA+RCggFH12fiSwQTE4yYrEyJzm5yxoi1TEUKgeYXjABm3C0P2ZOpY9ZkUbvaXx4/6poQgORldSQHfgqkwRjONWqN6fopoMuxG/KlcPmidm2TM50bOGz0kkHjjQHzTDWozrNvUN7WvedP0xEczEpd+iWSHYfm6H7EmFq2lAkm7lvAEBlc7wuHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXBEeSIJKVToSEpcXYMmgCsdnKQKg0ftnYphxYhbhu4=;
 b=WvX0LpsCZBr9aqs9imrFhLHzqFs81ZuFcGNw3o7CyBcewS+ACQcbdo30X10r73u6E/3FhhE+FRhXBTpYLCNZAvKHZzdElBBtjM8B9G8ZPyCuW+OjLgqy98D8FmzVOkRNWxLgmpHpRQaCbwbTHozBpKUipEckxmN/OLtNuJAAKTuB8mbHFFt/IkJS/JbWiTMkHuy8lLZGU11yx6T2ixMfL7Npsl6fu8ie0l3XJO4oHdHyV9muPKPcAckJxMEbj8LRO06PtMkF40RBtv2dT5FkE3NnZNDLUEdHcvzyoaMbJoMwV6i32c8MzkDGtTdJYjYkL2X0/PQmVfI6YmAtUpgnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXBEeSIJKVToSEpcXYMmgCsdnKQKg0ftnYphxYhbhu4=;
 b=x7F7mk4gu32muc6/ipCumRr2rKe7pAaeyThwx6Jvy2KfJn4x1fyMqmSidMINKPtmE7uLWL8ome2enfGkBAIApj5lQimIoq41XrjmLuU3eDKnvOCI+a0Hi4Svq1+CGGu4UVt/yrMSXwo44mcRKWmbgfpcC/x41fUuOf9XI90iG1CymLEmyFsi+HmtcmLCOnc0+nAUPywlttou5WFQf9iOj52fxzFEa9syuaRqZBQ/ADshm9P4esycSH7aOKFE1Ue/gdb7fiMnF0vE33j8j0VA1lvof/6plMEFAzwmYRATf36d+tNSQQ9JLTpuhRM5Ttb07Cdy7hTMwaX2rJhuG5iZmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 07:54:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:54:08 +0000
Message-ID: <29b3a6b2-1988-0470-45fd-12ed7ab14262@siemens.com>
Date: Tue, 14 Mar 2023 08:53:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: FYI: efibootguard is available in bullseye-backports
Content-Language: en-US
To: kazuhiro3.hayashi@toshiba.co.jp, quirin.gylstorff@siemens.com,
 christian.storm@siemens.com
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <TYCPR01MB8295463B41D4D1D9317FD779E1BE9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYCPR01MB8295463B41D4D1D9317FD779E1BE9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: a4796712-2c23-4f45-4691-08db24614a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GKGZnq2UvDSj4FJ2CSRi9s/widSvdZDuZYIj7JtZ54PFtxUIs0PQmuYpvUUzea7c3IjgmvM7tFJn5dzKZ856qIg12iymv8S/tTpJ3MyacizrsckOkfrssu1agcPlZZGfWC1sW11HQuUYwY5NKjE4lt+DqLgmLR+SBXTlDLCiW32es479ICaku/IOuBbvd0jhYQbmVDT2IR9/2B3L3I6y6hw7+2k5dw/O3GgBFP/KmM85FML8fz0BDoMWrRhwlw4rmgZxVJbFjhI7F9KZwksIobCTt+z9uZaNu/s4Q6ory38YhdzawxXie1GZ+DUOYogOd1YEiTTNdA3d21ArkXv1u3ZBcED/K5/y5RWmao5Y7cLuZUmmHTeLIzMppLBe9v4g+BJXg8e3gXXZVR65/qazAKV3wGCqtt+TL7TKaFAXDuQqD/lSingzfCd0VQ9dLimLr0T+maIlygdDezs2zMTL83vWm5ENPVMMQ1PFvXW5MLL5bGxENiCSXY1hkwrG0+nd66PKVkvUJ8pYV4T0W5DrMHclrqaPVKt98UizXVbgemj0EVZRbNY44Q5SxNn9cGOVhL3y91TA991yKWEMt+qbtQsheGK9goWykdcf9cHeu5PnN3z5aztebQS/pi5hW+mnXhXOaCf+HGQznyxw9RCZlGTRbG/vnU89TSEGDXEF9bsnyDN6dL+VbfTFCBKmM7eypVdhD7acXSgbV+war321O1y0ZLf66Maw6jm2HFSptYM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(86362001)(31696002)(82960400001)(36756003)(38100700002)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(41300700001)(6636002)(478600001)(316002)(6506007)(5660300002)(44832011)(2906002)(2616005)(83380400001)(6666004)(186003)(966005)(53546011)(26005)(6512007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rm5zRjVIbU5HOGowbTJRbFl2TCtxOHU1RjNuMXNXc0lMZDNHRW9RMzN6RElM?=
 =?utf-8?B?QjVtVURxUTNCY05qM3l1eVNjWHRmeVRkaytBc0NTYlhDcXhvUG0zYmJyRExq?=
 =?utf-8?B?c3RYZ1g5NjBGWHVqdUZJbklvWFY2R0l2bEZzd3FIWU9wbjhzRWVoTCtNeE5w?=
 =?utf-8?B?eHhzWkpYa3dZWHdVODlJVWtsVGVabXB4ODhyRW14WklpUHdsdWl6Q3lEejRB?=
 =?utf-8?B?ODJ3dEJmZnhLQzFRcnQyYzNEQUZ1dmlVVmNTcnl5aE1NOTkwUGV5QVErdDUr?=
 =?utf-8?B?OElmTk9YU0F5SkZaS2oxRGtVeDAxWGhBQVBYUzJUaTRGbHlqRnBQb1A1d1NQ?=
 =?utf-8?B?d0E5SVhIT2QxOEFrUlA2QTQrNUVVbXkzb0Y3dkc1Q1RvcmRHVWQvK3RHWWFm?=
 =?utf-8?B?bThmaVJlM20rdk9iMnEyQyt5dEpmQVVsZVRFbStHY1N6b2UyWThOclp3YXdW?=
 =?utf-8?B?cmVaNHd2b1VIV2ZlSUVsUjVZQ2x4Ti82b3JqQjg2Y0pYVy9SYWk3R005YVlU?=
 =?utf-8?B?QjZ1QmRCbEhOQWpaelpVT2Fnd0hxZFY1VWo3R1hhWFhEcjYwZUVSTjJNU3NB?=
 =?utf-8?B?VzB0L0V4QVRPdWFSY0FuVTdTeU0wVE1QQXoxcUIzUVhQdHNPQklDTTdtdytj?=
 =?utf-8?B?SGRYR012RHM1MjBnSitoOFdTYWdUWFRSSTlTdnJ5SXljNnJEa3YyVTgvVXc4?=
 =?utf-8?B?bnkxbU1DQlVacENIdXlYR1BHUnNNckVnNGM2TW5ocEltZzZIVFk5bm1WaHEr?=
 =?utf-8?B?NTZJeWRrb0wrWWU0WHVYaFQvU24yY0JDaEU0VDdsU05KbTVxbHpNRHl6MjNK?=
 =?utf-8?B?eGhOOWZGK2RiUGtqNUF5RWcySjA0d3RBelJndWtYM3UxQ0lGR2xGUVMzK2RK?=
 =?utf-8?B?VHF6Q3dGenhNSk80WmoxY0RXejg4RmFmRUVKVnV5ZURaamtTTS9WcTRoenhZ?=
 =?utf-8?B?bnhGd1pUcnVrbVhtcE5RLzc0emhWa1VwbkNvcE1ScmlXSjFGdENIOCtWL1Qw?=
 =?utf-8?B?YXVkZ2VRdmxYdFdwTUgwTlBvSlFnTTdRd0prUldqS0NmQVZMYmlmdkFHd3NC?=
 =?utf-8?B?dVU2OC9tMmcrZW5IVndXbVgranZvdG9GTU4xQWFweWgxT1RHcTRmVGUzcXZz?=
 =?utf-8?B?UFVEbHFEaXN5bTFKNGlSZlordFJrRXAzcldNSHBuR2JKU2Q5L1REc2V0dEFM?=
 =?utf-8?B?UGRVcXBCUHFEN2N0cng5NFc1UUtKbVlPaWNkdzZRMmZadE5Fb0F2Z0NwNDlk?=
 =?utf-8?B?a0hGSmVFVTNPZ0V6dUw2bmV3b0JTcGRhNjFoQXdVVndPZ0d0VmM2TmhaZ3dE?=
 =?utf-8?B?K2FmdjlhZ1dCdkw3RHhlTTAwQnZxSUNJWm5qMmw4ODNPL283ZlZkMURlM00x?=
 =?utf-8?B?M2RhUDIrajdxVldtSFRaN1ZpN05tMGZ5NE40ck11L2hPaU5NQ2R4bElzM2gy?=
 =?utf-8?B?NERjQmkyWVNVUnRxUmRhMVdhalhOQ216Rko2NXo0dE9SL0FlVTBhL1l3YkRE?=
 =?utf-8?B?NFlrUWNOWUhLV1BFa2doRUlBNXFvYmNndTlQOFhad1lhMXBWZ2p0MFBMS0JQ?=
 =?utf-8?B?aDZvZTVsdzhtZjUrc0RoRWIrcVZWMmE1SjlCMWc4MkhLRHRGTG1DR3hhYWFj?=
 =?utf-8?B?eHlVNXFOekNubTVzME1wYzNXek1xaGt6OWpKeEliSEpsbi9xVlFCOEZDbkw4?=
 =?utf-8?B?YnQ4eXlWL2Q5bHR3VHZDMDZjR2J3K2kwZnFQWWJiRCtZMWE3RWJwZGlvQ3BZ?=
 =?utf-8?B?U1dMR2h5NEdDclNMcFBKZS9EWVNZOUtrNXhCWmRhQXdXaDViTHJaSmtUZUFl?=
 =?utf-8?B?ZDRTWFpTZVVaN0J1aFNadG5xZGdJT2dmeSs2UlhacmgvUW5VbXpXYlhVZ2lT?=
 =?utf-8?B?Y3FTZU5SNWU3RE1PVm1aVFBmSGc0bEh4dElsUW9pTWpobXFoNXlIbk15WFNz?=
 =?utf-8?B?aDNiY2Z0azlkMG9iWHovN0k3alErU3NlUFl0L085RldIM0FHTWNhRS9KWS9t?=
 =?utf-8?B?MjNndm1QcnB1b0tDVFYvbFFrT1BRVmtuaGFJaGJOM3JBMXArT25ucndMZmJ0?=
 =?utf-8?B?YW5aYlRmU0FYTWZQV1F5K3BEbnRuL1FsV0M0WmFqWUh6SjFYNjZpaVJGUzBW?=
 =?utf-8?B?N2x4RVoybllyajh6T21tMGJlOCtlZnlyeml5U2JFWnN2azM3a3hDUTkrWkE5?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4796712-2c23-4f45-4691-08db24614a44
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:54:08.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPLay0tVBZk0TB3U/JvL2qnBa+q+K54UFfdEhwWie4/OTthLcM8RqcTBz9VLMs0c38dc4Rdz9plWRne7erQAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 07:54:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11024

On 14.03.23 08:45, kazuhiro3.hayashi@toshiba.co.jp wrote:
> Hello Jan, Quirin, Christian,
> CC: Iwamatsu-san,
> 
> Just for your information, based on our internal requests,
> Iwamatsu-san uploaded efibootguard package (and its build dependencies)
> to bullseye-backports [1] and it's now available.
> 
> In response to this, efibootguard is (will be) enabled in bullseye-backports swupdate [2].
> We internally tested the both (efibootguard and swupdate) in bullseye-backports
> then confirm the basic A/B update is working.
> 
> Though backports packages are less maintained than the packages in the official releases,
> it would be that the packages are used more widely.
> I'm not sure if you have plans to replace the current efibootguard/swupdate in isar-cip-core by
> backports ones from now, but let me know any possibilities.
> 

Thanks for the info and for enabling this. It's surely valuable in case
there are no needs for patches against EBG. Currently, the only reason
for a self-built EBG is RISC-V support. That may change again, though.

So we will keep both options, using the official package by default but
permitting to select the self-built one on per-machine basis, e.g.

Jan

> [1] https://packages.debian.org/bullseye-backports/efibootguard
> [2] https://salsa.debian.org/debian/swupdate/-/commit/6b833d909145c74c050e1934cc573c3b380d4f19
> 
> Best regards,
> Kazu
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


