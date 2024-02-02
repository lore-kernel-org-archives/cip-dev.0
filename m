Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFCC47258
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 08:47:47 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.45])
 by mx.groups.io with SMTP id smtpd.web11.18783.1706863657049028116
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 00:47:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qW2mzkeV;
 spf=pass (domain: siemens.com, ip: 40.107.7.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZTXaNXH+J5XeswuadX0MKGhffI7U/ODVLo0rNHw5ce+cO8q6+Ff1i8AW8BnbnQg1zHWUz7PP/jxyKKpgTDwb0b+IVOz40Us6kn9HdJQEs1irnvrxXxck/CZmM2quPN88R/HKNUSpQirNeRuGiCrbVFZefWB6xcc8PO0FixiEdngEIcOuMcKoux9J3pmoE1uw2G910NmuQnPdwSXAmNdxrmpKvYgzp9D5fNTvvD0O/uof/Jw+lTJ65Hph0uW/hHUnDV3OQIiBFWrrIlVqn7I8x/q6oRJbJJItbrQz/ErwhQrXBxadv/RiumGAr8gICEz5QiFOHtBDjDdz6M8HWICEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1MQZRTlSibFMMAcRt9cvhZWeT5w4s1gFzHjm0BhiL0=;
 b=U+aARsH8mwNtocaN4BMrojUyln8lCvDD076Kf0RP1d6/5IolIThf6rLr3KqC6L9jATjmyY6Nq5ROKbISGrto50EDP/4rE1TopR5XnNsBO7ygtOYkt0c4fRGHE4xa17sl70RU8rsWF8TIV+HlJ4LuMH2q09RACsmIv4jN33bstkqPStgxnpjmj9sP4+pL6dnYztoq/M93ocUAMoZiRa97htlxH1OLVVTOwPnDBuPI2iSiS2zud8EsCCLDNiZizIAaCAXq//P/yqxKERUWeqdqzb9dTZq9clOqnW9W4JdrgAyAaGNykDP9U3WfmYgeeMOCuAfqnV/BkqBr9S1KI2pl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1MQZRTlSibFMMAcRt9cvhZWeT5w4s1gFzHjm0BhiL0=;
 b=qW2mzkeVa1zQPz3WBBBVtMD7vYcQjrRCrKF2znTXPLqHqCMq3STDQ7GEoqCxX+EYRvFpcgfgqurwu+v1wfKQz/jiK/ECSD1K5KuDwN9fw1eFUoT/xYVtqwPqN/pBul8nhpKELmUUexta6Ghhy0n05PsNe0InFGTpk8M5HROLf0ojqG50DlGZGENqn3nrrZqbQuNNloJFdSrrND2lXO7SXgQuEL6VrEL5A+qp7y/D6qF8F4OUjXpyE7bfO27gjpwNzMzsKJgtdpVadQRhpz5DyN4nemcg8N//ReLwcU1SFIVA345HXajhKegksNuFpWgyuy17uZBXmIfiQ7GqMuXItA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27; Fri, 2 Feb
 2024 08:47:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 08:47:33 +0000
Message-ID: <8bb73c06-6bcb-482a-bef5-7f45e8902c31@siemens.com>
Date: Fri, 2 Feb 2024 09:47:30 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Subject: Glitch in isar-cip-core build
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c77903-7fd4-4cc1-5f4a-08dc23cb98ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JOj5NGFEOHRJukJ6aSdBLB/qwkDeeSHmkB+cx0TXUsjNZsBUcTRGOIC/3uQdHoly3eTZJKfveoBIlpSG8KWtdXDPB026l5g/DPfvpMiMQzpAV6eO54cH7cbn442hQrFeY+I8WMO8O/GMsNpI3fPjRwIuFurXJUqRKS7T6kQIBtfbfcU8UxHFt4PTj5pgt2nKFng1YtDUjVuxErlUXiR4d6oQrrlqnppKUglmXZ3lAsRP74QAY+m9hFn0mFO05F3GUKmCTkphnE5RFMUff5mjESZ80DVm0YKyfpswQ9boKcMcp8zIJROvAro7VhLI7/SX9NIe/1arePX1xjezwnAxsGVF69vNQHIiNlQcbOw1rEwqVF1BmizWu8v5RLt9TK3CiHTVabgSSQfjqtCyxSXDCUIIZi4BTEWf98xcNv9vCIxpGmFE2F2zVWiiF6Q1I9wGTYW48x+6K7wQ6W7b+z3lzpVpG8Ez13En1Yzt2SCwQ6aYf0I8hdfz2bHeAR3XEV4ouwXxah68/pFLpCm/JH59tJkousjG4+qCY6O03HKhbusmrpAMeD7JcYhbOehaqa2aLhmhxapcTnuBo9ZV/s0nkDlkyxqFXPV/5p7rDiTHLnonzgZCFX1CrnXB6juT/ZXblsY8GnR7zfZ8b6WS/FI4Tg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(966005)(478600001)(86362001)(31696002)(36756003)(6486002)(41300700001)(82960400001)(83380400001)(26005)(6636002)(2906002)(5660300002)(66556008)(66476007)(6506007)(2616005)(44832011)(316002)(66946007)(110136005)(8676002)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djBXMTlzWGJaa296ODFCK0NseFhaSXNnVFJoUmw3TWZPRkRhNXJUWHFVK1Yr?=
 =?utf-8?B?bEVNSFFEQytYVWUwUVlGdXRSa3FnODBKU1NQOXZTRU9sVlQ2cjlVZzUwNTc5?=
 =?utf-8?B?T2kxVXdWNmIrdmZldE9oY1RZY1Budmo5WE9GelRpTjRpcW5melFOZks5Z2NN?=
 =?utf-8?B?Y1k4cE44S1oyWkZFS0h1THo2TFNLa3psOFVaQXZlR0czWk9VaTlvMlVhYVBJ?=
 =?utf-8?B?Tys2dm95VFJPc3pTZU9jZ3h6UmVGVm8yK1JNL2pqRE4rY2hwT0pVQVJiMjZN?=
 =?utf-8?B?a1NPVGhyS3NEVHpjb1lPS1I3SWtoUXF6WnR6Z3lVVG5KK0s3enkwRUhUNll6?=
 =?utf-8?B?MEkrVnIxRk5oNDFyWXFIV0NWS3Ryekdra1VRVDhNV3ZUa2piUVpsd3pHd1Zx?=
 =?utf-8?B?R2xvdldTNVFISFNIOFd0OVp5ZDhvN3dYaVhiL3BjczBiYWxieWNxdGxNbVM1?=
 =?utf-8?B?Q015RWl5NkNsSFV0VDhVdERYUm1mQ0dUdWNNZWRtNWg5SDBhQmR5KzhvR01X?=
 =?utf-8?B?RUZPZXJ3QUhpZU5va1AycG1VRnBtS1ozSlBzOGkyTW9LRFZ2ZmtONlpNdWlt?=
 =?utf-8?B?bm9BRlRRTzJqVjluamR3MHhRVzVzT2NkSXYzcVQ5NklwQmthQlArUWJHU0xv?=
 =?utf-8?B?TkczNWxhMHl4TGxRdStkTVl6V1ZNM1VnU0VxK05jOHRHQWg0aDNuUEJudFFL?=
 =?utf-8?B?YXJKTDRtNkk5SFZUNFFwQjlHZ2NydGkxTmV0VXUwb01qaWdJWjBrK1JRaDZk?=
 =?utf-8?B?S2p2b3doWGZENWNpUVFqTHdSNVY2Z1NkRVNMamo1a2V0dWllN3ArZXI3bnIr?=
 =?utf-8?B?ODBmK2JyTjdWY284RDJuTUplOVdFYnY1L3ZjSkNybzBmcTdPekJtYUJGbkVn?=
 =?utf-8?B?RXlTT0dMbm1KMC9hVSszSnBJZ1ZJNWhmNnRyMEk5cE5sT2I4K1V0ZlJFalN2?=
 =?utf-8?B?VHFld0t3QllSdi96T1h2dDU1SDRSUXlLSTZBK1BIZWFWSnRjZlBIVE0rSEph?=
 =?utf-8?B?ZXlaTzBmRFd0blM3elZ4anhjc3FOMVZHZGl2eE5rRURRN1BvK2VldmFBWHZE?=
 =?utf-8?B?eks1K3IzZDB4QWZNeHIyaWY3LzZvZlFGaFY1Y1I4dW1MYjRxNUpwejJsZThh?=
 =?utf-8?B?VHVBRkpRZ0hKcko4SUJOWHVwTm1BR2gzUERvQnNHdmFPRlhJd2g1aHY3VzdD?=
 =?utf-8?B?aC9kTmNwRWxrVVFSN2daeTYrVGRpV0lPcDV6alRHaGczNnFsdE5UYWRsSFdD?=
 =?utf-8?B?dEhOSnQ1N2pTNlZZWk5ORnNFWi8ya0VwM2xKd05pZndWNmp1VjJxL2owbDR0?=
 =?utf-8?B?TkVGUlVCMCs0dGozNHBDQVUwUit4MG90ZWE0Z250QmhweWJYU1Z4clRaU2Fj?=
 =?utf-8?B?cUdDbWxkWE9GUThEamt5em5HK1Btc05LdE1CZm5jZkYzelVKQUVUWGw1TzNF?=
 =?utf-8?B?bTNzSEhocXdpWFNDNFZubzBkVXFJZktUQjRJSndzc2libnZIRlJlYnhXZFBI?=
 =?utf-8?B?bmJYdDJLWTNIa0pTdDd0NTY3dXFkSS81UkI5dElnZHllN292a0k1bkJ2Q3ky?=
 =?utf-8?B?RHAwdmxpbzcrQnVEajFodko0MG0zN1FRaSsyZVVwREx2WCtOVEhtbkFiUTB2?=
 =?utf-8?B?TjUrTDNobHJNUnoyaHlIMVdkaThVaWJkT1pEaStwREkwUXN4QXVic2w4a203?=
 =?utf-8?B?eGNWcFp5SDYvdlBtcHFOWi9LZHRsVzNqejZHL3lzM0czeDhHdldwQUNKNzd0?=
 =?utf-8?B?c1ZzYlVyUjNTSDc4QzdlNTQzZ2dsS3VqUk9uUnJucUtMSHRsZ21tTVdVZmJI?=
 =?utf-8?B?WWtNQklZUFdVVlNvYUIyK1FKazVZbVRhbXV1MkxtM3c4bFJrcXRMZTY3YSt6?=
 =?utf-8?B?OGFkOXN3ZnJGM3RuUWVHbXdMUW9DZ2ZhMm42cis5dllZaURqUmI5VEVwYjZG?=
 =?utf-8?B?QldiZmI1dldMbkQzRGw3SkNkdGRZY0M1dVFDbldYVTZ1SUtXQUhWV3BTSVBO?=
 =?utf-8?B?bmwvOFEvMXVtZStsczJyRWFsckRaV0d6bGtvb0Z5S2h1c1RsWHV6bTk4aTlY?=
 =?utf-8?B?SHlpTmhVeWRZR2lOSlVhcGptZWw1b21DRHU4YWpnTlZhZ0lJbVdPRXNXOHY1?=
 =?utf-8?B?OEtWV3MyeWxrdDhTcnNxNWhiOWdvWXZEcGF1RnpETDRjRUxYdnJTSU5hRUNp?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c77903-7fd4-4cc1-5f4a-08dc23cb98ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:47:32.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHZC/eQYjzb7h+ScjEL8LIRCz820Zl/zr1tlaH9Zl7CmE+gPSUwUm6xtESLI2NLbKPg4wk/Henquss1osvACnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5277
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 08:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14602

Hi all,

was about to tag the release, but now this:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6079744871

2024-02-02 06:30:45 - ERROR    - ERROR: Task (/builds/cip-project/cip-core/isar-cip-core/build/../recipes-core/home-fs/home-fs_0.1.bb:do_dpkg_build) failed with exit code '1'
2024-02-02 06:30:45 - INFO     - Log data follows:
2024-02-02 06:30:45 - INFO     - | DEBUG: Executing python function sstate_task_prefunc
2024-02-02 06:30:45 - INFO     - | DEBUG: Python function sstate_task_prefunc finished
2024-02-02 06:30:45 - INFO     - | DEBUG: Executing python function do_dpkg_build
2024-02-02 06:30:45 - INFO     - | DEBUG: Executing shell function schroot_create_configs
2024-02-02 06:30:45 - INFO     - | DEBUG: Shell function schroot_create_configs finished
2024-02-02 06:30:45 - INFO     - | DEBUG: Executing shell function dpkg_runbuild
2024-02-02 06:30:45 - INFO     - | sbuild (Debian sbuild) 0.85.0 (04 January 2023) on runner-wjyrh54g-project-10191315-concurrent-19-od3c74bz
2024-02-02 06:30:45 - INFO     - |
2024-02-02 06:30:45 - INFO     - | +==============================================================================+
2024-02-02 06:30:45 - INFO     - | | home-fs 0.1 (amd64)                          Fri, 02 Feb 2024 06:30:44 +0000 |
2024-02-02 06:30:45 - INFO     - | +==============================================================================+
2024-02-02 06:30:45 - INFO     - |
2024-02-02 06:30:45 - INFO     - | Package: home-fs
2024-02-02 06:30:45 - INFO     - | Version: 0.1
2024-02-02 06:30:45 - INFO     - | Source Version: 0.1
2024-02-02 06:30:45 - INFO     - | Distribution: isar
2024-02-02 06:30:45 - INFO     - | Machine Architecture: amd64
2024-02-02 06:30:45 - INFO     - | Host Architecture: amd64
2024-02-02 06:30:45 - INFO     - | Build Architecture: amd64
2024-02-02 06:30:45 - INFO     - | Build Profiles: cross
2024-02-02 06:30:45 - INFO     - | Build Type: binary
2024-02-02 06:30:45 - INFO     - |
2024-02-02 06:30:45 - INFO     - | E: /var/lib/schroot/session/isar-builder-6dae8870-44f8-4bab-a37d-8801811b384b-19385-33c2924e-dffa-4784-a2b9-07c7ab49096d: Failed to stat file: No such file or directory
2024-02-02 06:30:45 - INFO     - | E: Failed to create build directory /var/lib/sbuild
2024-02-02 06:30:45 - INFO     - | Failed to set up chroot
2024-02-02 06:30:45 - INFO     - | E: Error creating chroot session: skipping home-fs

Likely nothing new, rather something rare, but still: Anyone any idea? 
Is our isar too old, and was something like this recently fixed?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

