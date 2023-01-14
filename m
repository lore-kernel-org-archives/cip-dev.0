Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDAC3DA78
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 10:26:21 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web11.113063.1673691974792189885
 for <cip-dev@lists.cip-project.org>;
 Sat, 14 Jan 2023 02:26:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XMyhTMJF;
 spf=pass (domain: siemens.com, ip: 40.107.8.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpAqwkEfk+h5/NJSY0s5ifJOG5OsozRt+BNHZS5KdGOE8OOYvimnk94foMzcKO0IeOnuRb0NUUSWNmAz3DOPNM7VqqpL9U+Dk2bvGOBgCltkvRDO397M4fnZLFP3iPiELrwMAQtNSuWsnMbF08AqOvgrNA6CL5nKGoPu0DMOl8tQ2aNxmDxoPtawEJAu47JWiSkmSigJDZjPShgPtdeFtRnj1S0w8ZQtoUD4H3SD7Kkxx/x9gbxSK3WqLN5Tms7vJWcfFv8ncREVt1Ph9pMrAC5fgPbZDRZGG346jUyYhCdKYEQBFnCFUX+lO3zYMUgfKtpzsRdav9lRHX6ADHQP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ8GNPSFSAZIMEX1PGaaY3w0KfEOrSUeva37l9QRUXw=;
 b=a/f8CaNH+7kuTroOxlzWfOe/k+ZZuRaS827WN44lUnoiu98wuUTz5TzxfnK+OrEzI2nAzEhW3sUcHoapWHZhM1yIJ5p/sV/4ZOO3FQzXSemZvxBca/wLSIp0fxcufhZEsbJPrT/A8j1RH0tjyVyHqthEq+8jdUDkgDdaxdyL1AcBzy/ptXcmHddsEyxjo5rq0Qza2EJ4U2j0Y3GQDF8GYcdEXFKzAhb46P8RxMHvDWmHrciX9T0Pnsgh9sjDzXLsSYo/RbB/5GHlWS9QTryscyB8h5QaXdPPEvdmUqqkRFA2cDHuhkCY1JocikDvQhzjZGt5THNpAZkz9jWH4jbLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ8GNPSFSAZIMEX1PGaaY3w0KfEOrSUeva37l9QRUXw=;
 b=XMyhTMJF6l9nBuZB5Yt7FOF81/wC8uJqXtHcnhwvzIE1k4A8HrUx9PM1pu0Ey0yLvAwrgqCBBEwKVLI9mazvftzgABcM+UMVS16pTX3sG01lqwuBEIYN7/0bP4zXfqJk4HZFMENcLj174WqHbVjjlbC873TtGjBV4IJU1NLSsla2f+65N2pYnwlPVp3UNIQ0p2LoI+/OKn9et8nWHQNU6h/JB7qpxXZHI1SwzTZtS6StqlXoikxoEL7wGHYC7UAE0t1Txu6dfm1RIrEKZ/ouSOI9O07NQT6Zjg+n5QXPlde5W1Ll4WXW343sZLteTh+wmxGY+nkjVoy9Yf+8jmVDLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5655.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Sat, 14 Jan
 2023 10:26:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 10:26:11 +0000
Message-ID: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
Date: Sat, 14 Jan 2023 11:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
X-Mozilla-News-Host: snews://nntp.kiszka.org:563
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: 6.1 LTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c69edb-23a6-4f06-c7f9-08daf619c1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e+GNKqPp6Ymf92WPg3sOiduQsmimOooY5JkYJVBBOh1t6hLBIPeZgmzNcssBiWtdD39qxk2zv5Ro0kCV+ycSPQpuGZKBAtceB0AxdgQGRwdLu/4Ry0Qj2jAjxBnMRhtKSIzjSwuyOgB72JzY4i2PSSRTgHgEzx4XurZPehuiTmgU6wS8rrw8qACqY11ZXDLdHiL3hKls616tchtvAl3SYFyk+Lo8N+HVrjSB/N8YmxbnvXiBBohzPUORS2NgQVXLvcPl6EK0baZkfr8V18WRlGNyy1vZtl1dHUlE1HEJsBn1Jg0JEktL6SQK4LI2gCKTFSWkaDgDNraOrKk7p4/GbIj3yR8oSo5+UscQzBzm4pJsk2cg6OdJtZWdfVNvuToiBuocgLCrEKo9VSxLdJIlr0cF68VHro2K9mH9scpoHZ5SlfP13JkBG3Wb3Hstg6lmHMc3ZKseBvqRkRw0pfWzxtLbGbsHT7EnuaofLzqSy6rmS4yJX/IDnwd6Vcaevs6Pmp7P04wxiDwfwabiB3Van3W65Aoz0bwasv5DLbk9fv7e8xPSaeUTBkV1iiJQr8bigTYf3pmkFY7EIECAhf6GrxuUlW+U39Ju1vnVHz/rBtqt0wvD3aDw5xj41WdFGqIxTx4/kT3NUsd5xsnht6faswEtS2QpmJRwQyYbNyPoEO9dxih/p2sMd7jolQ0aqbhlE739rt2O+BHFsrgn+h/R29Snx1unxT2mGdysyeLDl+kE3OrWa5eWiNUeV74Iei1V
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(316002)(558084003)(41300700001)(8676002)(7116003)(66476007)(66946007)(66556008)(6916009)(36756003)(86362001)(2616005)(82960400001)(38100700002)(478600001)(966005)(6486002)(31696002)(6506007)(6512007)(186003)(26005)(44832011)(31686004)(2906002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHJWOEVWODEvUk1ZUFE5ZEQwK3U2ZVU4alM5TzdFVXJ4WXB6KzFqeDhydHd0?=
 =?utf-8?B?ZHhrdWZ5anc0bTFveisxRFJkMFBUY0YwZEtxZVhxbUFFRVpWWlE2QVliWTRa?=
 =?utf-8?B?eWNJM29EV2RrR2EzYVpKR0VJNnJGWmhrVGxHdy9sNDA0UzF1d2F3dUsrU3Vr?=
 =?utf-8?B?WkFnUkRZdnZ0U0N2VnN1ck1HSDBqVFRTbVhsZHhRTzF2MlVTSlJvRGRaZlhz?=
 =?utf-8?B?cUdhTDFmZG5uMWtYOEdKQW0yRFJ6UFRPKzNDRkl6akdManNJVEFoSzZydkVt?=
 =?utf-8?B?WlVZWUIrSlZkeFFPbHFYc0FVNklIZktoOFJneGFxd2xUb2FCZnZYZENUWXZT?=
 =?utf-8?B?VXdyaXlXYk1DWmJXNkZEbCtmclhFMlNOUVVxSGtWYTFGakMvQ084K1JqNW1r?=
 =?utf-8?B?VTZyLzNEM2lBaUljM1VlRStSb3ppcmlHQnRGZ25zMFhDQThscEJHQ3hxNVNY?=
 =?utf-8?B?RW9kMytEUTcrYXNLOGtJQnZ1Y1FhOGViWk4wWmRKRTh0Nk1kZW1HY3lkd3Bj?=
 =?utf-8?B?dXl1a0FPbEE5cm5Md0RpVk9iclRkTWVjSEtjMnRnUVVRTHl1N2xQU0pRN3Vp?=
 =?utf-8?B?T1VzV3hOMk1uSjFKU3IybzVVWXl4bFN2NGRzUUcwckFPRFRXTmk5SHA5c0Z0?=
 =?utf-8?B?VEtYelVQcFBMSkUxRzhuQ1M1cm0xZkhIZnlueUNUMzNhbzVXOXltZWYwVGk5?=
 =?utf-8?B?blFrcmFVOHFRWDlDRDdVc0hubkk4NU9CalVsdVpCcS9GbGZVRzNEOUdTSEdL?=
 =?utf-8?B?VEhtT1d0S0Z2bGJRTUdKR0JtR2FmZEticEcvbnJ3YTN2MDFoOVhUc2tORndN?=
 =?utf-8?B?cEJWdG9ObUVXOXRrR1NSUEdWcE42V3RZQjA5QU52cHBSRDdiVWRGRmpQcEli?=
 =?utf-8?B?bDhZaXdaS0k4by90UXpKWlQ0a2NVeWkrbk5BSzRDanpVK2FNcXBRbHdycmlG?=
 =?utf-8?B?WFdCb28wTnpRTzlLODVNRDM4dXJ4Mi9udkphc2pmREd2d29MdUFVbHF2RHhI?=
 =?utf-8?B?TGV5OW5vTktRbVI0QStvUmh1QnQvcmhQTTFhMEZDL0pNWjd0MGIwT3lEVTNK?=
 =?utf-8?B?eC9vOFU5bjduTFJWcHl4a2RwQ0xZOVZFRlRGMmNMelA5a3p3YmlvSlBIU2Mz?=
 =?utf-8?B?WExBSEhLaDVadmQ4QkR3UjBQajBqY0ROeGNxTzU4b3hWNHV3cHlxUmlySXlE?=
 =?utf-8?B?KzlHNVVyMWhHREtIVzdpL0dHSEtSZU0vMDE0LzRkMVJDUTE2bXZLdzE4c2F5?=
 =?utf-8?B?OWRLbVpQeklvUmx1ZVRUWHFiQmZzMS9xUWwxcC9hd3N2VnRkZUJVRWtENTNz?=
 =?utf-8?B?TUhDVWxJRTVRUEoyLzdMR3pPejJVTjVsbldRNEVHM0ZLTEZkckx1MTBFVUJa?=
 =?utf-8?B?T1l1c2hVT3FtZGZlMjFWR1oxVklkb0JHMjE1SFNSYS9ETm40bVdKQy9wZjJo?=
 =?utf-8?B?azlXWXlBYW1JWDkralh4Q2QxVmsxNkRGSC9PMGFZemJZMlBZeEk2eUZ3cDlt?=
 =?utf-8?B?bGxHRmN4amoybHBFbEV6eUlVS1NEajRYVFFRcjhpM2JKZGJYTnFuRUJxdFJ4?=
 =?utf-8?B?TWZiVU9SYmVYVHZEM0dhN0FDVG9jUHJJYkJ1bFZtTEpwTCs5Nm1IcjNXR1hm?=
 =?utf-8?B?YjF4YUR3MUFPZm5CK2x5dEg3MzlPWWNZYUxKbVBpS0ppVUNMUTFzTEFZb1Jx?=
 =?utf-8?B?UGdEaHZ1SnJyODNGSDNiQVRWb3poV3lRd2lDQ2UyL2h2TTB6MkdEQVNoUlQy?=
 =?utf-8?B?L0daK1o0Z1NhU2ZocUpZaGxYVlBibGpnR3dBaTQ0dHJuQWFDT2tNUU9PYXhK?=
 =?utf-8?B?QkJIcjhnc0tUem1pcmRzc3RjcmtsSXg4azJJMFgwZVhkZTloOThTY0ZiOTBC?=
 =?utf-8?B?ODRyb0ZyaGc1U21uamczY0RrRGkxaEdEUlJ0ZTJJWG43cmpZSTAwN2M1c2Jj?=
 =?utf-8?B?cHNPeC9OR3hycmtzOWJoVCs4WGRKaVFnTjk1RzRoMS9TYVBzQnNKcmZ1cW5R?=
 =?utf-8?B?azIxQlNJRHEyNW5WQnBWVDRwd0ZENXZNMTAyU1RKMXREemZzWVdMZTVKcmMw?=
 =?utf-8?B?bXY0Y2g1TjI4aXFOaGZLczRlZDdYdXFBalZtN2NXSW9DTmtMdjN3OFBhdFlI?=
 =?utf-8?B?WllQNUJ3R0p4amRHSElkVTMrTFdVNGZrN2tmOW85dXVvWU5lSjh3YzBqb1d3?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c69edb-23a6-4f06-c7f9-08daf619c1d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 10:26:11.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/JUYpf/wsclLT0Nzvofposlw+Qt+xk2whsXrgcrqqYQ5vpdW+4ImD9V/uty35r80ymBw26VWLHvJ8Mrxo74rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5655
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 10:26:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10360

Hi all,

in case you didn't see this yet (thanks to Florian for pointing it out):
https://lore.kernel.org/all/Y53BputYK+3djDME@kroah.com/

How could we contribute to this as CIP?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

