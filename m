Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86908C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 11:29:24 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web10.12003.1741951755226939904
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 04:29:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cybertrust.co.jp, ip: 202.241.206.54, mailfrom: hiraku.toyooka@cybertrust.co.jp)
Authentication-Results: ss11.sbt-mailgate.jp; dkim=fail(No signature) header.d=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id OUYI18044L;
	Fri, 14 Mar 2025 20:24:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSChzzTD9LjtAfRNtYX9U14orbhrm993ZW3EWmuyvRY84z3WS0BssoQMVawlERqj9f7JmO4CvbE4bPn2hZwIzMY1F9Fo+lwt94J3RsdkVmOVZ+Lv7cMcqVyiOpH8gqbiDU/ISV09Os/lmlhmJYsAmM95PoToDXTxR1nMPXyrPm9FFX5j1DeKdDcjK+JPjVANaT+hA9Nz3cAQ4/uOhf5md1g/HXzAVAHwd9hcPW2WUXrkQzb3inNM3BMHtnqjCKL06QBU99uCdU9qLxasT4iTScTufbXtgWF4ySs/p74lX+ZsRpS9h5cOHgxlZwl7Dwj4inQqZFa7vpRoLqqfYZhw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AFfzeeKZKo8K0IHhUrC4EQjfwk8jDHiTwb1fcPtHbA=;
 b=pkbSUMskoaW3wV9WQwrRraktCDtNE6MykJBS5DY6k9WtsU0oxnAFIbdougJnKBlClPO0DEtOOIn3+UjTv/6EYNeOLMl7u2C233F/jlKgJdN7qpqQeRdD2Qm4Hzcckn2PRxrxKN2njaYgVJLC1y02IylRV8thAqyIpJGQbp9SFE5f4CxoAw/+F4ByE/hKD1m5mXsjkCtoQ1S96ADBuJNZQS+kReULwkaEtmK0fMTQgZ3sh19gI1em8lI1EIV6FaNZzCvW3Zp9RPLpWKwb5JQrsa5PCPvwCiaOwakisuqMgu5fiMWJ+Ujo9oEiP5TIC/Frd+BlqDrN23F7mx2kB/0Q5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from TYCPR01MB7459.jpnprd01.prod.outlook.com (2603:1096:400:f6::13)
 by TYVPR01MB11214.jpnprd01.prod.outlook.com (2603:1096:400:364::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 11:24:07 +0000
Received: from TYCPR01MB7459.jpnprd01.prod.outlook.com
 ([fe80::dd95:77e8:f9:c199]) by TYCPR01MB7459.jpnprd01.prod.outlook.com
 ([fe80::dd95:77e8:f9:c199%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:24:07 +0000
X-Gm-Message-State: AOJu0YwAm1B2NZ+JAQWCjlSBNoaKtQDsIyWwv37xEQbe0AkNHsg5b67t
	Hk41StPA0lqQqxTuNonV1hiF8wRGnjDgjbSbwRDo4ukbceTBijLHj6rWUR6WjOuL9dg1uGimtYQ
	xLvJu1/KQpjf2Yzl/OzrpqyEmmYtB2r0locIX+w==
X-Google-Smtp-Source: AGHT+IH8QSJYInEFOwnfl5v6Lid69L/LN7I98O7ZvGZncD9l3Lr6dJ1tGAUX4em0laO3XRR/JGY7gnwp4TvY+dsaSr8=
X-Received: by 2002:a05:6902:2685:b0:e5d:d6b8:2317 with SMTP id
 3f1490d57ef6-e63f65ed7a0mr2134203276.44.1741951443268; Fri, 14 Mar 2025
 04:24:03 -0700 (PDT)
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Fri, 14 Mar 2025 20:29:09 +0900
X-Gmail-Original-Message-ID: <CADPJy8XoZ2656ueriu+a44bLQbCKOWB+_a4JcvBr-eARPbb-Yg@mail.gmail.com>
X-Gm-Features: AQ5f1JqDeB15uzquMN1DaVfcg3ySoTtK0Mkg7y3p4d0z5_p8iHUaZgtWycmkVrQ
Message-ID: <CADPJy8XoZ2656ueriu+a44bLQbCKOWB+_a4JcvBr-eARPbb-Yg@mail.gmail.com>
Subject: lab-cip-cybertrust will be temporarily offline (2025-03-20)
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: LV3P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::10) To TYCPR01MB7459.jpnprd01.prod.outlook.com
 (2603:1096:400:f6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB7459:EE_|TYVPR01MB11214:EE_
X-MS-Office365-Filtering-Correlation-Id: 925c1337-e7e2-4efe-fa09-08dd62eabbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T2cveXNndjdBK1g5dG13TC8wUGRoM3lJbjQvN21KVXpTNWxoSldlMnFuUXBO?=
 =?utf-8?B?OXN2NWhuSkZKclZnMWtTN1FuVk5Da2NtOFgwRXE0eEdMTzBBQ2t2cnBrajFH?=
 =?utf-8?B?MXFnNm11Nm1OMzF4NlhkYmc1QXU2bDVza1FIbmFGTU9BQS91bmUvcGdNTTRw?=
 =?utf-8?B?Z2JGdFMrb2F4Z01rK2ZoN3dHVU81STR4VExnS2tJeWV6ZTN3OEN1UDQ1QkNJ?=
 =?utf-8?B?VE1MMUdRWDFGdGZJMEs0bGdabDZ0SUdFOUVVckRHWkw4bDZxYlFLcHdZM29P?=
 =?utf-8?B?TElUNnEyak00ZlFPY1pkbi9teGc1emp2R09iaFMzK0hmVDVQQW0wbk9WMW9j?=
 =?utf-8?B?cTFiaTlxRFpmZHhqcEJHZFRsL2UyRE5PMGg2bEl2MkRJR3hjUjBqV0FZVkNl?=
 =?utf-8?B?TVYrNFoySlF4VUpEb0pjL2tzcU9PdUliRTFOWVdxYlhBbk9ZYTZDN2xNUFBB?=
 =?utf-8?B?NFg3WHhpYklUMmtib3BTNTZNNkNPRThIZDg2L2k5ZDcxbGxjYW9iTUYzYk8z?=
 =?utf-8?B?RlpzenVGNERTdU5YQmt1TlZoNTg2eXJRQm0yQ21rWEl1WTA2NEJsRURxK0Fy?=
 =?utf-8?B?ZXJOdmU2L3R5dWRWWkVKQU1wY3pPQnNNNitiaWdzS1dHdUVBN1BrVzhialAv?=
 =?utf-8?B?YmRkTUI2L3UxRWdtbGFwOG05V0F0RlhHM3ZyVUdZb0dlZGgxU3VsTmkwUDdY?=
 =?utf-8?B?NC84d3dDSERPd0toZytSSTdtRFpFTTMzems0Y3cweTNHY2FxVDRmeG1LeTFR?=
 =?utf-8?B?KzNBcThwVFJZNWs5QmJyMG1MaHY3Rm51aXNJRXl0eWM4UDhGd2lKNTQzb3dt?=
 =?utf-8?B?N3k0R0pNTzM0UTN2cW8wSzZMMUtjRVBsYmhVR3F3ODhEakVOOTdXVkJIamFw?=
 =?utf-8?B?QUdnSm9lVmx6L3oxMFl1SnQvZjAvNEluMFZuTjNYY1ErTFFXM3gxUVI0ZVN4?=
 =?utf-8?B?QWFndGFPUHA1OFpleHg4dzNFQ3B2ZzhETU9IYTlpdFlGU1ltZVRHUXAvOGRH?=
 =?utf-8?B?Q2FwQ0ZuaDM2WkttR0ZwUUR4azhvTEVSeGlmbmVhV0VaUDdTMk4vNTZIYjF4?=
 =?utf-8?B?K0RHbTg2aHVmTEtQS01ram1DYWZXeWRIM2RPcEtMcEZ3aENpUmRaUjAxWUhp?=
 =?utf-8?B?OVBIekkxQTNxdXdhNytRem5mMk1kSUdqalFEVDFZS3p2ekNWZWc0amhaWTVm?=
 =?utf-8?B?bE8rYXBud0RpWkIvTUlraXNNaFY3SEMwNFdHNnY0MFg2N1RyMWEzcWRGb05q?=
 =?utf-8?B?bEsxOS9kUWVTSEkwbTRpdU9GUVV5RVdwNnIxYnczWk1jajZhcmE3T0svZTZU?=
 =?utf-8?B?cTV0VEk0dit6VU1nd2pqUDVoNng3d2RQSzNLR2p5V0NqUmRWcTBkM24rOVNC?=
 =?utf-8?B?TkExUUxFU2dqTEhtNmlDa3Y3ZWwyUi9oSFdCWVd3bUZNcGdYTk16SFZ5M29a?=
 =?utf-8?B?c3pTV3MxNUhLaGlYZ1l2OUgyWjRLRVdmWmhkWXZHblRTRTBGRDNBc1VhbDRK?=
 =?utf-8?B?WU14SHhaOHJUN0doWFhnTlJ3SjBxQXVJSm5venZWRCsrTWoxckxSY2FoNXZo?=
 =?utf-8?B?Z09ZVFRIcCtLcFFRcUZGWHdRa2VZY1p5cHhSYVlXT2Z4TTBVQVpUSTJtSDBv?=
 =?utf-8?B?T0w3bVJnZS9CNjBqQ3NoWVRyZGw5eFdXY0QrL1l5elhqZm91Q2hKaHZudlo5?=
 =?utf-8?B?dUNPVUlYQjd5MkZFa000WXl5bzFONHBKeFdKcHFsQ2pmUTVDT0ZuejZobkli?=
 =?utf-8?B?YkdERjVFWUJId2Zad3I0eW9qOVNRZHRHZ1Z3dGpURXQxYXl5QzZsSEI5bmc3?=
 =?utf-8?B?bmlpdGdXVWdGY0c5Y01VSmdWQ3ZrY1dlajRYYUhFWDcvaXBKWXM0a05kaVJU?=
 =?utf-8?B?NDFhRWJPcENSUHRwVm9yZWtuSmw0UCtoMmcxbVRRL0hnZkkrbDRIRVhGTzV0?=
 =?utf-8?Q?3ssgza70M0gou30xRGF2gGQRvi7YmnLO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7459.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1FaRkNZMDRUckdEL3ZHR04zeE9tT2xDVFgrZ2ZvL0cwZmE4UHE4bnR1ZjNN?=
 =?utf-8?B?UUhrRUNlNmdJK3VDZUZFZU1hNTRaa29MMGs5NWRaYzUveElObXNJRElyT0Fn?=
 =?utf-8?B?cDBBUlBOdzZxMzdGZ0RHTWVadmtxcTdxaTZqZCtSMUltR1gwYkxQSFNWVFRu?=
 =?utf-8?B?R3FGUm9JbnhObGFxSzE5R25zZmhaTkVOc3NUVXgrQmZKZjViQ0VOK2ZiKzVY?=
 =?utf-8?B?QzIrV0ZPNGdjRU5qV3M0Qm1YYXEzWjZBQmI1K3F4bk9uZURjdmhLS1Y3VUVH?=
 =?utf-8?B?UG1rT0VYRUZCV3luK2lIWUlqL2J5ZWxURDNjSFM5RG12ZEpCZGZhbktyU3VR?=
 =?utf-8?B?VHhmMXZ3UThENFRuNEt1U20zcHBkQlZsa3JLN1dWMVhuSVh0d0VRR0ZmVHFh?=
 =?utf-8?B?aW1yRW1MY0puYmJZUFNpa24vQ0V1VCtydHl0WTQ5blZQaUFScUtCWFBBd1kz?=
 =?utf-8?B?V1JKMFZ6RnJXMFFMVHkvSFRkcy9wSjlzbUtESEdQSEttS1FVQmZlRUk3T0lo?=
 =?utf-8?B?MUtRL2R2eGRmOTZZeHpDZ0tndkJmWC9RUXZhTjFEWWFwOTJxbmtnUTl1bWRn?=
 =?utf-8?B?RGgwL1NlcVJ3NWFPQkVqbGxGcDAxUm95Nkd4c0YzR1kwdW1lM3E0Q0pkMkdI?=
 =?utf-8?B?WkhwSEtBdzQ4SnZMY01IVXFvUkVqcGhZZklMdkFEVlc4bVVrQTQ2am9rcWFO?=
 =?utf-8?B?UkZGaHBpcDU0V3MxeE8vNkpHQTZxcUErdy8xaXNRSEcxVnAzTGUzL25kcTZh?=
 =?utf-8?B?bkNpYnFQSEFPMFcydkxaYjQwSy9BOG1kZ2hLaGNhaDJROFFYQXUrMEdYZ1Bh?=
 =?utf-8?B?YWVLaXZEZVE1Q0JFTThMajZGTkpTZlBSTjZ6QS80bEd4U3N3cmZ0eEN5YmFm?=
 =?utf-8?B?WlBHU1BrNTVNd0hUWXp3WVgzQTd4SktTdko2V0hBQ2NXUjV5SmJoTmMzNE5D?=
 =?utf-8?B?MEtQcTNqTlJhd1Q5VW11WGg1SWpnTGJkNVkwdFljQ1VKeW84cG1Nd2gyY0dV?=
 =?utf-8?B?OU9XNDRiYndlblVGNU1ERzMvdDhhUXNvNDdIc1pjS1hKV05ORlRVTE90RURu?=
 =?utf-8?B?NnA0SFJNV1BUdXE4MkN0NENwL2Vaa29BYkdGWGVEWjRBV2FyMDlqSHRzOXJn?=
 =?utf-8?B?QlZXYnpIRnZnenQ3dVZmUzBISDBYQzhSbmM4N29zM2RQVGpOdkdERGE5RE4x?=
 =?utf-8?B?WDhRNzlISVhoWWZnNDJkTGdyZnlxOXdxM0lsOEhXejAySDdzUndIRXV2TWdk?=
 =?utf-8?B?T1VSTUM1QWtKZmc0Y3dGNTBPcTJjbml4UW1RZ0ZlQ3YvZzZqZVRmTEhHc2dj?=
 =?utf-8?B?SnlpZDd3WnNnaHRRUjAwaEdsSlc1S3U2YTZZVEgrRjY0dVpaTHV1RkpzaEZl?=
 =?utf-8?B?RldkZXpIYVVWRzVVSytjTytVeFFkRFhhazdlWWFSOTBQb1FFb1lmdm16cHdT?=
 =?utf-8?B?QVRsdWFDblBUNHBBS2V0WEw4eFo0YlFxQmJpTDdUaEozRWxSU1hsbGZ6UHJs?=
 =?utf-8?B?YWRpZmdjcFBqZ0lNVU43dmFmUlQ2WTV3VjRBUWtJR3FPZzJxZ09TVkNJdVNr?=
 =?utf-8?B?Z2ROd0Izb1NQZURwUjBaTy9KK3VpdkpoeUltMXgzWmg2Zm5DVDR2YktiekpY?=
 =?utf-8?B?ZDZiOXJYc3hRRWkrKzk1RDYxQ1U4TUtVVmRSTUxNYkp3N1BBSVhXWWNGVHpE?=
 =?utf-8?B?UjJEUVZ6OXJNeVR3Nk5oZmpNOW84bW5veE40Y04rODFNNzA2UlVUdXZNUnU2?=
 =?utf-8?B?VFRXK0hBZjlQckVrVEtBWDMzR0F3eDRlcG9TandNNWhieFBUNnd3RDR4NzBN?=
 =?utf-8?B?bnVvOGhFcG9ac2dhYTlwLzN3SVJoUWNsQ0Z6OUM1YVdQOWo5d0cwZEdXTG1V?=
 =?utf-8?B?U05wVVdMb2ZOeHNtcm45a2ZZeG45Y1RrLzZaREFXak9jMXpkayt5eXRtVDNM?=
 =?utf-8?B?MEdiRjRwZnBNUW51Q243Z1BZUFIyMGlOelNPTUFlY1locnFmcEFLWUJjQlh2?=
 =?utf-8?B?RXEyWHF0WnFhMnBvN3FmcHpYK2ZPSVg0dGJ3UU54S1lOTGRITy9wTlhrV1RN?=
 =?utf-8?B?N2JzNzZBclJ0M3l3TldHc25aM3ZGQzhac3pKeVlwR01EWUtVdHFvWW81MnJR?=
 =?utf-8?B?ajdlYjlCZFZKUStiZUQ0emFvOHU1bDF5VzBHNWc4RFdHeUp5YkRhWmNTN0VR?=
 =?utf-8?Q?5gyIdbKvbpUZae4VdwicJ24=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iG/zr6grigT2IOy0y38tym+flEeXT2w6W1/W0+NozLNntcCT9N+A6DTNHeHKRkiA0w0uh2vw0+2yeuc3c2dHZdHcMbcrbzAD97uuu6YbclEc8OyFv2t8qUXNBQf52q5TGVuAaaLx00/QrAXqcDQejf1mlfneow+TMnbwx8Mc7wJNNQV9SXPq8PjHIELERZrxBzaj5/YgwQThNm6fSUHsLXoE5G3iwo2McLrzGBxk4hMdhQaP52Y3+QnWN9tS12HnvBBx6GFctn1ksPs9wnSgEApy09ER9QMifeaF/7vD8NeD0S2raL6dUlHpNZRN/GvXKq/hJHNZUFDg+n+3abt4LjkQREEdXxVkIUKrSjKXrS6Xu7xgucIt3ucUuUkmFwW0d7gAufK9kA/ePh4bO/umtuRBOjRKyfVwt0/VYBvprTDtGMRD+ROBMxm2K0BWJxHEeFz4tlWnealCyfoCG1tWDf52hQs1rY9uBKmF4qIDe7e5BBb1TiXeojsGbuC6jXtNuV1CZ1xsLjI13y43eKeXMw1SpMjCNXM6TDg4Kcel4dc5oDKd7NWGKe/5UNe6r5jE5qx6Q+PfsdU+pzpFTyA5v98pB6Ac03FUJ3vtowIVN5uDgEBWkTOcax63GH6Vp1g0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 925c1337-e7e2-4efe-fa09-08dd62eabbb1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB7459.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:24:07.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRku+tbjWEAOKUyF5ak3CmfYr5hmuHnStqxsMishXTW+Wyp4Bo2DviqPbuYp/VSvx5rc6u+e3lfp0EnB6mzG/2BF6ynuVxONDYRS09HjXjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 11:29:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18214

Hi.

This is a heads up.
The lab-cip-cybertrust will be temporarily offline for 5 hours from
2025-03-20T23:00Z
to 2025-03-21T04:00Z (UTC) due to power maintenance. I'm sorry for the
inconvenience.

Best regards,
-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

