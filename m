Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B59EE49A5
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 11:53:50 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.41])
 by mx.groups.io with SMTP id smtpd.web10.7808.1692446029302912331
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Aug 2023 04:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NYOD73Pj;
 spf=pass (domain: siemens.com, ip: 40.107.7.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDye715L9dwO2H9l6ncQgpPCgbnuvvyt8DBv4L5n/7z4//HamuHCW2rX+x0fhybM66NGLyXhbIc2SylVmPz6pkjV6PEHYHLpHbZF/YtO31aDg/ps2uFjYGQSCU3GH7ibJb7DQQoEZuhWUWxKZQyuozQtiCZrlF46eV06yy0HxVM9VF6o6wlCF2XT2bjNPQeP645jNH1uvv+vx0PoiZT6T/bjmusN/FldZlndbcNCSAh+pGVMghZ/OYHn8PJJ/z/JcpY4Ud5XpsNErRQQY37lVgcp70PldXKaAWC3S527EyZRGOllhdUf550LEsiScvZfWWtdSgIdxPreHgZihrp8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqG9XVZuW7owfo5h1faBjBXT19IHn5YXvgl+K5gOm+Y=;
 b=dNjJD05Iy4BeR9eewYGpWiHKTUySUqoin90HOM+heQVJYQUbM1H9ZqLvOfBAgOIbuhBlHTCeFyz3y/sw1JiCy73E+bGJXOBqadFb4t+iQxjYTBDry9Ec7Mt7sEDheWykVaaErO52B9ksEhQEK9HJURZbYctUr37AzxqLg6chFdZPZQQQg7kjJtwsZcBSIycbs0eZrHDE5IY5FATM0NsQ4P1XSyFDCLHQzG8Sc17wo0m/+YoUlk13gdn1vlMnisjP3SaSIMIJSVJVZYoc8VGDhJJU84dc9YslAfd7vu2GUe/gQNTD5yu8cyfg7V8tC+J4kLwrrWAJubIsNdJbb06eYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqG9XVZuW7owfo5h1faBjBXT19IHn5YXvgl+K5gOm+Y=;
 b=NYOD73Pj6URT8v2pDdbrJGAg9C3sAU1AYwjH8jiRhzdxIUv835NPYITq2gA7IrtHeGEQvBZpA60AGBODyzE6dpPK4cf6/HgBwM+4+vYbYnaHJKe4uwNtDPEYGkj7xDGFC8mboj0Yg3bB44barFHsjQb/jR1fG+p0FqmyguzeJl1omsRFqp/O8M0DW3GwXOejPWOexU1G+6HfL3JJQE1E/r2PIef1xAABdYNfqk2VJt1pmaUvJ+2ssgDXv/EC2Sx9wrG6AE6IbS1LKSOLJnjhu1AQ9GI1uEyBNKdgoqo0K2iYj7Fr//DHXWr0tA/R+KQrYMJyYuZLAjJbrxrPcl8NHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5519.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:53:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:53:45 +0000
Message-ID: <1c4494da-028a-449c-b796-280fee653bd7@siemens.com>
Date: Sat, 19 Aug 2023 13:53:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci: Create amd64 release
 variations for KernelCI
Content-Language: en-US
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Cc: cip-dev@lists.cip-project.org
References: <20230816080300.5559-1-arisu.tachibana@miraclelinux.com>
 <e4fb5477-18a7-4c65-9caa-4d647dae6a07@siemens.com>
 <CANgtXuP_=UBMwaVu2UOwnzmJpQPJdsJh2tJKqDP3LCoWy_Hbkg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CANgtXuP_=UBMwaVu2UOwnzmJpQPJdsJh2tJKqDP3LCoWy_Hbkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 4403d1a3-48ce-4774-34f4-08dba0aaf11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uI2NYcxgPdXwkNI6ziOqEg18sXPw2Jxa4cI5OsciIE4MVPlYX4Vr0b4fY6j87N7b7ZydmTEV7iMkWYFPmhv09wb/XxTDBktqnuyx3QNLDm+OdsKIRubGeDbPpRBeF712qN2VV6FmveXhVNi4pp0/bivp1I748bYhNbi6f8KrpRvTVXRdHd+bgbdVShAczZS8Kscvv08JfLuchuZfq3YNMWqWQZ4zBd8VnJTA796RHr90JNowqfs4+2Yt1jdQ0dVBZHILvV8CZKX8TQKc7rIY3SLXNCz2yFdlPLiSDYl9nrimTRZE4rkd8TKxLPDoksTj8lP4F+nkKscs6/e7I3wHOS8S/2hdylVo+WC0+p5YqWWiPIRjvlzuJdZqHdUFIDL53TBEUgc/ke2AmUz5sMEqEQnhAqhRUXghw5Z/IXjRmqmoy0bgPmVzTwvIwE4eLP8yytt9YdovsevKSRMZWqov17vTYJL6LTUHO4L/Gdexyp50pkbauL50G/riX1/nXzUaU2Ga6/lELmbWnGhwUxz7FxcAdhgiwXPs5heLnO/HdZmSsNVfLx0dsudgYCSvUO82PVvz2PjDkjsVCoNRJvkAdIM85yGgzsYo+/1MJZ0B7CB+5H418Zr7q+/NXbwjUoaU0EJ3My0vekU/biNxmrwCCw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2616005)(26005)(6512007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(41300700001)(316002)(8936002)(8676002)(66946007)(6916009)(66556008)(66476007)(2906002)(5660300002)(44832011)(4326008)(4744005)(6666004)(31686004)(6486002)(6506007)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEhWdTVnUEtrcFBrazdZVjRYVDhkUGQ2M3VuZ3MzczFqcDl6WjZXOVNYREFV?=
 =?utf-8?B?MUdubVhUK3U0WVlTU2p1TEJEQXdNNUtNWUdyenFTSXArdThGMXUyWjBHY2tP?=
 =?utf-8?B?VDM0ejFNZnFpdUc2b1ZUTlJxU1dCZFhtZ1c1Z3Ixd3RCOVVxR1NybEpFMDFG?=
 =?utf-8?B?bnFKbEF6SXprdU5DdDNFQ29BRUtUYStzOEFzaXdSdi81bkhmNk5DODZQMDlT?=
 =?utf-8?B?aUF2MHc0N201ZHQzeVJNMlZQSUtiN0l1bjYyYSt2N1UvNEM5eEVheUZ3cXdw?=
 =?utf-8?B?TnN5Wm51bFVKdFZDa3FGZk1FSWZiaVFQUUFsZzc1TEZySHZ6Zmd5aFFuZVhs?=
 =?utf-8?B?QitHMjVGNTg1aGw0Y0toMVdFbnFZOEVzRTc0eGdEc0lkaU15QU5wZUtDTWly?=
 =?utf-8?B?VEh0VC9NaG5aVWRFY2owd2txMHQzUjE4Q0xvSHd0Wll2elpSd3VTSEdrMVNl?=
 =?utf-8?B?SGlSMkFLS3YxbUNMNUFnaUVrckVCSkdXZElYRzFZVDdWMk8yNGVhUnZTaTBE?=
 =?utf-8?B?Nk5UUVlVK2xSdUo4U3JuUVhzZktpWUJIUUp5bTUyTDVpU1M3WmxQR0FYWEpO?=
 =?utf-8?B?Q0pYWjF1N3VuaEt3TU1ydnRrbFFuTzJ0SDVxdUNkSWNtVHhiSG90T3o2eGs4?=
 =?utf-8?B?WXZRYUR0T3F1elRiQnhJb015bmtGUlBXVzRITnlVU0VqRkJJODR2dHdwd0Vt?=
 =?utf-8?B?QVBvMFJBT3grSHU3STRydDBFQTBBOWhJeUZEdzBSQm82UCt4dkozcWhmY1Z0?=
 =?utf-8?B?TEZRVlQ1WHg1bHh1dlNsQi80NlBKczVjL3JWcnQ2OXRGREwzZm5YQkFYbWhq?=
 =?utf-8?B?cDhUR2gxMG1DdVI2N2lOQ3FHQnVVVG5HRlg2OGhBeUZkTU9xQ09hRCtYZTlX?=
 =?utf-8?B?K29hbnNmYWZJUGpsWWt1NGtuRUhjWG1iTU1HNERzMFhSazhFdlpLWWZFWlgx?=
 =?utf-8?B?cCt4dktVQ21EYWNhN2docUwyYjA0RmRuYk1HaUJkdEdlOElQMEF5MVcwTktU?=
 =?utf-8?B?SHBXb3czd2orOUVpS2Y3aU93Skkwbzkwc3NwdEJ0Y0ZKaTdoUnkvL3ZyZ2RB?=
 =?utf-8?B?alFhejlSYWp1aExRbE9SVFhsOFZyNkpzSlpXNHk5azd3Y2piY1ZZejNFSEU4?=
 =?utf-8?B?Si9aMjFvdHc3UjVxUS9kQ1dTVXZhZy9XL2tIb0k5dU9KRngrbVVmMmQ5NzUw?=
 =?utf-8?B?WHlkTzVKZDJ2WVlNVWJ4NEUva3Azc213Zm9CQnRXaGN3VFpTNmtVc25iVEFJ?=
 =?utf-8?B?cmMxeUh4UnJNWk02OVdneFM4OXJQRStqdUNDL052UUJERkZjVXlJOWlMVTVM?=
 =?utf-8?B?bUNMTnJVRWV3OGJqWENEV0RiMUhtLzk3Wm9raTBLL0tERmRhTGl5ZDh3MG9x?=
 =?utf-8?B?SG10RXNSS1p3aXU0ODNXajlRREhGckMvK05sWm5CTXVQSUMzK2MwdWI1NUUy?=
 =?utf-8?B?VFZGdmVaQWVwbjF6TWQ0VTg5WWpKOUhoZWIrbVVJZmtyOWp1T0tGa3Fjdm0v?=
 =?utf-8?B?MWdESE1CRmtsUFFDT2dWTm0yWWI0Y2pDTlYrSVVXK2hGMVF1ejlVUk44Lzlm?=
 =?utf-8?B?cTVieXFBSlRqLzRyaWVXOTVmc0dNb0gzQmZLYk9PM3M5N1UrNTdDaTlhd3VE?=
 =?utf-8?B?TTQ0a0FlUWpWMGt1amRXclh4emlKaE5wNHZ5cWs2UWgrZ1VDaGp6cWw2ZVd1?=
 =?utf-8?B?U0Erc1NMNFluTzNBclBlaFN2dGxHL0JKRjhGY2JiRERpMFRhc0VycWsxK1Js?=
 =?utf-8?B?c3NaWDlhMkZhRlNPS3hrNHM1NzhEc1RoTTg0TEhPRno4NTBRUjdYcmpnZDNh?=
 =?utf-8?B?T3AzVHFtcVNCVDZaVmcvY1BHUjJ5dms3M1BEdXpWM1RHRlNQcnpyRVluSkp4?=
 =?utf-8?B?QXV2clhuQnVtMzhNMXY0ZWRqYXBXMWp0QjM1YlZ5TUVGalQ0akF2VnNRNEg4?=
 =?utf-8?B?Y1pSTUUxRWxGUHdpS3J5Z21JenA0SlRnSnU3d0Z3K3hQZEVldjBYUEVPWTJZ?=
 =?utf-8?B?WWtDenFqMWhiY3hDWjdxbittQis4RHFlUlVkaWVHZDM2SDlKRDA2T3doZDg2?=
 =?utf-8?B?Y1d2R25tYzRKVGplbnFraFpIYWM2czhlNXVCcG55Sy96VGY3R3kreU5pVUFy?=
 =?utf-8?Q?hbgEXLF76pFi7BFUSBjlz9crr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4403d1a3-48ce-4774-34f4-08dba0aaf11b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:53:45.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHUwSqDdM197O3+bnav30Bk9W+bkOBN/874CzLG803JjXd66V5mqTpqrdGbiN3Z4VVdxjLaClIim7RFoENKPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5519
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Aug 2023 11:53:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12789

On 16.08.23 16:40, Arisu Tachibana wrote:
>> Happy to add that - just wondering if adding those two targets may allow
>> dropping one or two others which are implicitly covered by this now. Did
>> you check that as well?
>>
> 
> sorry, I'm not sure of the meaning of your question.
> could you explain it better? what are you willing to drop?
> 

Our CI tries to cover representative combinations of isar-cip-core's
configuration variants. We can't cover them all - too many. Now, when we
add these two, later on also for non-x86 archs, it is worth to think
about if those obsolete other CI targets without creating a relevant
test coverage gap.

We currently have 33 build targets. Makes 33 runners that are started
when even just a simple change to isar-cip-core is pushed. That can sum
up to relevant costs if we just leave that running, adding more and more
targets.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


