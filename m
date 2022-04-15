Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41531C65C15
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:03 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web12.5153.1650012710214589372
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Apr 2022 01:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 spf.haihaimail.jp}: limit exceeded (domain:
 cybertrust.co.jp, ip: 202.241.206.52,
 mailfrom: hiraku.toyooka@cybertrust.co.jp)
Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp
 [10.16.47.42]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id
 PRuD27565A;
	Fri, 15 Apr 2022 17:46:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUzgGggmMGszidi/kCJGUZOh1dKtyeX4smmrQrru0aGdxbA7V+piSmOqH2gME0hPt1mcRAU5c14/KTbjUOONFTm5dmYBvMIYYF1veRjvG5n08JDjp//KwPxx0xnzroeW+bHtDg02VHSV9kSgIhh0HFu/FIroJscn1EqfUVvpSC0m6x90wBsg5unt1R+GeKXiHDpIYZxeca6l+sEdxZJlxtFZ2qhXED5ypi7H6T3GTqfA46Ev6d6q9o77ddlUjhbl2S8ZsulGiTzkBM9bjcicbvc1iqVN7Xv8r+ph6Q4IlJuVpRE+6oC69qaMjdRX1ZKcyola9hdjVfP8IVAEpm5fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSec1v+i5h7m6SQpS5xwy4BF5TXFjTsWaHf7IzZWf7c=;
 b=ltuKc7mmSlikmVaROni+rlQZ8AjPU2VcW4oQf4OuZUNI0mYp4YX6tprsqZmevrHiwdLOBesiJyRrzD+Sj/jrndp0ZMZEmZdLblEgCXm/F0dBHygF35qm7x9IUhdAQKxbcXHXwjEssPope85kn7M9VzVQMovaUJA7aegds37TYn+1Jfai3zzZ3YRgsdl4XnC/uisWK9SPBapUuuMIoLydzaQsO5hf4f+u362Vlw0Q4QXGeNVwDQu6cAaBp2f0zi5H/ZPkxTZSAncVGiICiJDjUvOpnhcFS1sjW6AbtOe/xsk3eJcUKnKggG1XOsHBcbQP8E/1se8jdas7N5y/NXz3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by TYWPR01MB9373.jpnprd01.prod.outlook.com (2603:1096:400:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 15 Apr
 2022 08:45:59 +0000
Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::b01c:8ec5:cad4:e722]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::b01c:8ec5:cad4:e722%3]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 08:45:58 +0000
X-Gm-Message-State: AOAM531/RIGjK0pAssuBeqDSJ4zV8TZGrY9FO33fz/fdyShBRptcqYp8
	GgY8PkFN/QK/g+0cRxXPSCCJ1fh/rRzxi56bL5r4EA==
X-Google-Smtp-Source: 
 ABdhPJyAYXVPuNK8FTy0gU0hPXbzseOIR4oxw3iIwWLx/mrnqMeSTKyME0cqKEQhS4PEkjqHBHctMbIsSoxQjul83HI=
X-Received: by 2002:adf:e541:0:b0:207:adb8:aab2 with SMTP id
 z1-20020adfe541000000b00207adb8aab2mr4744188wrm.67.1650012348721; Fri, 15 Apr
 2022 01:45:48 -0700 (PDT)
References: <20220414165618.GA8670@duo.ucw.cz>
In-Reply-To: <20220414165618.GA8670@duo.ucw.cz>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Fri, 15 Apr 2022 17:51:45 +0900
X-Gmail-Original-Message-ID: 
 <CADPJy8W6DsFyjSHOPhg+jWkLLXkQg7o-98=ZpVFOmCt_q0dbXQ@mail.gmail.com>
Message-ID: 
 <CADPJy8W6DsFyjSHOPhg+jWkLLXkQg7o-98=ZpVFOmCt_q0dbXQ@mail.gmail.com>
Subject: Re: [cip-dev] zynqmp board has problems with 4.19 testing
To: pavel@denx.de
Cc: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: AM0PR02CA0132.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::29) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05cfd326-9002-4b10-279e-08da1ebc5cc0
X-MS-TrafficTypeDiagnostic: TYWPR01MB9373:EE_
X-Microsoft-Antispam-PRVS: 
	<TYWPR01MB93732CA8E074C4BE882BBE4CBDEE9@TYWPR01MB9373.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IstAI3P7+L86UXwMcz5bbE1EJEOKWNHEMJ0UZ5DQUhuXbVe3pC97ve4ZTyHf+TvhxJiV9dPQOsNM9XFDfuaDKI8t1vA96+sZk9e7zchLwKuvCvzQZZA/Lkv+O0gOmWzpvdRT35EI26+2I5xJoQsIyCTjBjEhAvJ5ErnZ+OCT/1OhVGplSmXIB14tvVuW8vK5evQosw1kD91IYAus5x1KxvY4KC0+OdTsJMTZMu4weikeFzij3Z89X7RwrCTn9JV4NNOc/beDNpwcpYuxknIwI2vUeJYGjJCHAAKgHItP5eQj+rOUEfrpsUhc08qCInC11XVLeGwstBJ2E+njocVR1zRCdGUdlTSPv/Xj2wzkutpGmYJwOX/liRE/LyqnyUiKlDz31J58t0VQBrObn3pg71UTEsbMJyXXP+DeF8yWJEryE3486OLTEGjdHn1mK3yiXwgei2OLzD/NRUKDHCDwdjW/zY923fkbNP7YIhIrBkYqpyH682FooeoAfsxv3nbs2taRrmuoFzkpsOemSksTZpMlrwzmOWMDq59E9IG8B4nBlZCIr5VS8fnnKhKhhgCfl9to7AGmuabWTEjTF57B97P08GNSMtNMsgaaivK4Fwf87GtAPhUgiGd9bVp3YUedYBResW16EqwJSg/vXV4Ho4CbVeQ+hrWh/eTwvz93d3kSTtct8OOMtyq89L8fRPrEx76kRe2tMnaR0Xfht5IogZyAsWgt9Cm0kHbOu4mHcAGlXJYW7OweEtCUOOFppfXnu4yKmOQIH6tKMD/AkuxuV+nJAbc4f0PbqpebqP5apw8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5333.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(53546011)(55446002)(6666004)(26005)(52116002)(86362001)(55236004)(38350700002)(9686003)(316002)(966005)(38100700002)(66476007)(34206002)(5660300002)(508600001)(4326008)(8936002)(66556008)(66946007)(8676002)(6486002)(6506007)(44832011)(2906002)(6512007)(82960400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVB4Tmd4S0RnZ3RpWDZvMVNqYThNOGRKVE5xQmlHUElxMERzVG5zMGpSMWFH?=
 =?utf-8?B?MWo0ZGJHUTlCQW9ZRzBEVmVMSkRzaWpqZlljbnMwaE5XdDVSOVBHbnBGNm9x?=
 =?utf-8?B?MEpGZ2orLzcyL1B2TFJLNmFpVkptY05CRkVJU21hczVlNEd5V1d6ZlNKcGtG?=
 =?utf-8?B?aE14Z1l3ekVYdUZKdVRHT0ZyZDBreHVvUEd0Z3VpREF6VXhUVWFhQ0YrL2Jt?=
 =?utf-8?B?Mnk3ay80K3NZOEpQaWpaN0s2ZXBJQ3l6RG50c0h0UHJYMDVzWERiTlBBc0g4?=
 =?utf-8?B?R2JCOFgwUWdJYXlLYUFFSExVSlNrRGs3K2QxcnFMMGZkejRBd3JKY2R6WG9t?=
 =?utf-8?B?VU4wOWRjd0xjeWUwdFNmSnQ0NXZoemNnWVpZd1B0RStHSStLTmRYSnlyM3hv?=
 =?utf-8?B?a0kwQUdGMUM5eXo0eXlxaTZzdlVsWlN1MEhCa3NQZ0dmZjNHc0NIaVdpc1Za?=
 =?utf-8?B?Y3E4dXRIOC9ZZHFJWWdWMWRYOC9WWUw5QW5OakpGYmxoR2hRZVBHdEFaNUUw?=
 =?utf-8?B?STVrMDJLaXpseUNud2IzaG5NR2V0by9KYUxINE1oNm9aVnFvYjRMaEtONGEv?=
 =?utf-8?B?NUc2b2xCUFRMZW5RcHRQVWc1c1dEamdESnd1UmR4ODRnbnVuMFJ1N055V0lS?=
 =?utf-8?B?R2c3bkducTJLU0Z3MFRJdFI1c243YVFVK2k3RVIzZkNJNEgyT0pwUGI0T2U2?=
 =?utf-8?B?M3V6d0U0Tkh4Yll3VnBoTlppY3BEOG5Obm9sUFI3MnF0QlJsWE82UFF1bi9M?=
 =?utf-8?B?Y0tkazhXR1ZCaWJTUytVUnRUUVcyM2NRQnE3Yjk4SlVKUUtlb3F3M1VsS3Fq?=
 =?utf-8?B?K2dVYWJyZThNSEFUUmM5eGI4bXdyR0M1dzRBTmtKS0x1TTBuR1F5UkRMYzF2?=
 =?utf-8?B?cm53aUhwQnRFMTA2bzN4eEUvbkxWdGg5eFJmMlBmUDhBalpzSmFBMjE5WlZw?=
 =?utf-8?B?R3JXS09Ga0tZdE5PdGtaaXp1R3MwQTJHRjU3QXA3ZXdyb0RqbVZnT1FJWkox?=
 =?utf-8?B?ZlpGWlhaNW8xTUZXN3JUKzVoZkN5ZzFpRWRjalJ5aXRmV0xjNGJzdUU5RDNQ?=
 =?utf-8?B?bCtxaFI4Qk96bUxjRDl5dnVUNVMxbUQ5MGhkZ2RiQnZnTEZMZ0IwdnRjRVVE?=
 =?utf-8?B?ZStjNUxOZGJ0WTBXWXZKeUpsaFZINlV4ZlErbW55Q0ZOVnZWUitIdU9kZy9Z?=
 =?utf-8?B?Q2JBSWhRK0JyVS9CVzBEVGJUZ01WdnFvTWEzN3JHWEVGdG1rcjM4dm5sZlN4?=
 =?utf-8?B?eUJOUndzNjdTWmRZRXZrTlp5R1dBYjhLbFQwVG9HN2p1Zmx3SjlaNnNYUUs2?=
 =?utf-8?B?Qlp4M1ZCb2dkdGU1MHUyZ0FlbWQyMklvYzU5K3N3SzNsd1B3OW5LK2V4UnFy?=
 =?utf-8?B?RHp1WjJTYXRoOWNGZGZpOUhwNnN5cFZqRHRYTGplZDZJWnBDZmJhZjhSNS9u?=
 =?utf-8?B?d0JIaXlJS2h4YVQ1MkIrVXpQOVV1QnNxUmRZdzFoL3BoaEthWjBtWWlNMkEv?=
 =?utf-8?B?U3N4empBeE51b0s4Qk05N09udGZjaExJWUhRZ2tYdzdscTROVUlRTGZYd2d1?=
 =?utf-8?B?eTlsWmg2Wm90QnYvWHNqa0JmQXBLU2lWRmNkMW05L3JaanF6c1NSL1BxTHFS?=
 =?utf-8?B?aEdILy9YOFdxUldFWktrZDF3UEo3bjd2K2FPMEdTdG8rVWI2cHNYUlArTWVk?=
 =?utf-8?B?dU5hQVFrMXI1RVRhUG5oZXBzK0JyNEtnTEhNMHhwOUUvNk1EVnR4dzhtRE41?=
 =?utf-8?B?MW1wazUwV1lZK3NaeTYwNzVjYnFwQ0J0dEQwSWw5RTByajQ2VnRJbEQ5Y3h4?=
 =?utf-8?B?Vkx5dFRkSDB4QUxqWmd3UGxmMmpsQ0RXbEo4S2ltV1BIRFcxbXhUYVcrR2dU?=
 =?utf-8?B?RDZNRXIvcnNFdjJlQWlWalYzYVYvTHhVWmhRVVNXdmI4SmdOUGpuemcrcGtD?=
 =?utf-8?B?SWo2V1RyNlFoblNuZk53Z1dEU1MrSmxtZVBud1JrZzRWMlhQcmNsaHFQNGlE?=
 =?utf-8?B?Z2o2a1djL1ROSnhMaDRwd0x0NFFXNld4QkdLcTVOVEs1SDgybDlCTXl4M3Uz?=
 =?utf-8?B?NjZ4SW9uRnNhWHhLeDA3SnJQWHlEZ2c5a1VRWTIvanVXZnBOM0tuMHlObVBQ?=
 =?utf-8?B?WFdncUVZTEE4LzgyOTRlTFhBeEtRVWI3TGtZY3M1L2VZQUNqamZMdVlLSERB?=
 =?utf-8?B?OVF0TFBya0t0VERqVFpEQjhVVHRPdUVPWjNKeFBzRzhWNXRpVm1KR1RrMVl5?=
 =?utf-8?B?ZWxHWTVQWlBDaVF2VUdnT0tqTjFaN3p1SW9NSVdiMlYxVXVhb0krWEQvbStH?=
 =?utf-8?B?U05BUkNkWE9MNTlMNmt1L0UyMmZ1elFtSnVZc2pETU5pN2hDNEpSaUxVLzBk?=
 =?utf-8?Q?5K2eCcnu2AKRbMgkjGjKoTtK5860Z06+vPdkt?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 05cfd326-9002-4b10-279e-08da1ebc5cc0
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 08:45:58.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 xBKD9Ehl1sboWAlxDLmkdnj2Q7HlthlC1q/WmpYiAbvlZEA9sJtjw4QEnlCSl0se9K/wg9LURrAEg0MEmMNNWYz81HlWg5XrdWZO0YdxGaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Apr 2022 14:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8099

Hi Pavel,

I'm sorry for the inconvenience. The lab-cip-cybertrust was offline
with an internal error.
The lab is now online and running the submitted jobs in sequence.

Best regards,
Hiraku Toyooka

On Fri, Apr 15, 2022 at 1:56 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> It seems that zynqmp has problems:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/2336993733
>
> Job #663506: Submitted
> 67Health: Unknown
> 68Device Type: zynqmp-zcu102
> 69Device: None
> 70Test: smc
> 71URL: https://lava.ciplatform.org/scheduler/job/663506
> 72
> 74ERROR: Job failed: execution took longer than 2h0m0s seconds
>
> https://lava.ciplatform.org/scheduler/job/663506
> Invalid job definition:
> extra keys not allowed @
> data['actions[2]']['test']['definition']['definitions'][0]['timeout']
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8097): https://lists.cip-project.org/g/cip-dev/message/8097
> Mute This Topic: https://lists.cip-project.org/mt/90469122/1050894
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129075/1050894/1100095814/xyzzy [hiraku.toyooka@cybertrust.co.jp]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

