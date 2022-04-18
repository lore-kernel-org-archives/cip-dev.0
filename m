Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA1FC64E93
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:01 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web08.36840.1650264180794937848
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 Apr 2022 23:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 spf.haihaimail.jp}: limit exceeded (domain:
 cybertrust.co.jp, ip: 202.241.206.52,
 mailfrom: hiraku.toyooka@cybertrust.co.jp)
Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp
 [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id
 SPlL13713A;
	Mon, 18 Apr 2022 15:37:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+A6Q5+e4VcyvWKgKVqd3inbEgEwaXXLGTKFlI2LayRMxUadtOERnuAF7nBfKy3IMA1d5D0zJbvQxkjk3DscN4EPcX7frb/LZSOXiTFF1pvyZCd/LmGlNKwyAavG4VwT7YwQMhNVDrVXvpiV88SPquN4A/mkXi89H/kYJ8wordeZnUhDNZBJIIBKJc20Yj7EzTcG565FMkTXn+xOcbilQomL3ctH3pl4wfCzhA84q8YLbenlCFwMYk8cFaC3E5+g0fseBmCsBC9Rr5Cw3BLsr/eBO0FbBvp0sxjRHgNxnBGb1r45ojOYB/aIkA5Y0CbAXTlP4xa+LBH1YTzyc7Q/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOWT5MB9ufC6BgLSKt5RQ1dnVL0Vkj5RPQNmrsqvK+k=;
 b=WiWTqGcnuV3ht7NnlUQu/nvhtutONR5iCsMmrEHFgf8UGpYjb1Gnqcb94kOIsVd4knPcvUScZVHpiAb8ykqy9INpmGFYCoSoi/nN7D39QkTPpMT+bSkz0wXpwEUDeFvIdAeDxFJ5uYfPDzlt5Wx2/9mxDraBF3b2NC2QGfLg7rtMOKqJ1QvrrAvYaAtAnV768iDPK3T3fLc1KqboTHzfApPA07xIM53KiTw6qHOiq7LoKBOsto4m5C2Pxto8BZ8AwCYEhMMHysPnRtg3V6aV01AHitWXmq9VoJ1oVpWEHK4ROGjz9Q7UXoVEaQSTkPClCOhm9E1SkGcUiHEn5TeoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from TYBPR01MB5344.jpnprd01.prod.outlook.com
 (2603:1096:404:802f::14) by OSAPR01MB2867.jpnprd01.prod.outlook.com
 (2603:1096:603:3b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 06:36:52 +0000
Received: from TYBPR01MB5344.jpnprd01.prod.outlook.com
 ([fe80::a4ad:2477:4906:1590]) by TYBPR01MB5344.jpnprd01.prod.outlook.com
 ([fe80::a4ad:2477:4906:1590%4]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:36:52 +0000
X-Gm-Message-State: AOAM530+SSIAlXoH4CXdCC1bol++5KKvG90wWgKXIaQxHIiZEeWeCSEw
	ivJSEOF6OCf7ezq/UeuhEYEsrmAO4Iwpy6mHzNUxdw==
X-Google-Smtp-Source: 
 ABdhPJz3tAJvDQG/FPbeMCQnUsx/WGc82/KmNKz+HlVDLAOyWtOSf7STANBzvKHIbVrX+i3OpP4itobXiTN12F30yYI=
X-Received: by 2002:a05:600c:1e89:b0:390:ba57:81c6 with SMTP id
 be9-20020a05600c1e8900b00390ba5781c6mr9970427wmb.29.1650263803011; Sun, 17
 Apr 2022 23:36:43 -0700 (PDT)
References: <20220414165618.GA8670@duo.ucw.cz>
 <16E605D19AAD240C.11564@lists.cip-project.org>
In-Reply-To: <16E605D19AAD240C.11564@lists.cip-project.org>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Mon, 18 Apr 2022 15:42:56 +0900
X-Gmail-Original-Message-ID: 
 <CADPJy8XD849gBoiQO7tMmqVG9P2c+M3+ENqC+-=OyKMntJ+hpw@mail.gmail.com>
Message-ID: 
 <CADPJy8XD849gBoiQO7tMmqVG9P2c+M3+ENqC+-=OyKMntJ+hpw@mail.gmail.com>
Subject: Re: [cip-dev] zynqmp board has problems with 4.19 testing
To: chris.paterson2@renesas.com, Sarath_PT@mentor.com,
	Manish_Kumar2@mentor.com, hws@denx.de
Cc: pavel@denx.de, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: AM0PR03CA0104.eurprd03.prod.outlook.com
 (2603:10a6:208:69::45) To TYBPR01MB5344.jpnprd01.prod.outlook.com
 (2603:1096:404:802f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d107d09f-c9d3-4129-2102-08da2105d220
X-MS-TrafficTypeDiagnostic: OSAPR01MB2867:EE_
X-Microsoft-Antispam-PRVS: 
	<OSAPR01MB28670EF130045525586620FFBDF39@OSAPR01MB2867.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kmgeE4aeLb6uGXWUVYRsY+VSU9CwRoAhZdWywqp20bYlmwFPmF6V4hfUi5TtkFrNzO8kkFG5u2c/9N5IuvSd+lIISAwmeiFVtM7/h/+BALBeiJF4KGE7xJoqSKzza01a36EvBokBEx10bBuHmSdGekDG/DKg3IFwox5AitYgHxWN615wdtOZ5SJcq8fftePmwMtsuCgqRiRbmEhOet0LtCz3oVI0avLmvg+LKUnZodcm8cKmPxyc+HhQMHRf2HSHGz1TmXqQZJNqwrZoHuiXeKyY9jMSWeFDz2eASsjNHXhLFdaNc9oDkn3tDqWiE2ZLuZpUPLOtdwiokTf/y1/dCx7otJEeNVULnBEe+vZwmdBBl+0eXWzp9DzvWrBkOtQ9p5FCplY3tQgIVVUEXDuJ+HfHkA7Y2jtS71xut7vpWQfwVjY6RFDuyWiEdexgiTLjXdM9Rn5Y/pG3p8OHkcgvUEOhS6cZIU2NqH1VmHv4n6AbIlFUJXQ6bNszEVzPXS5yZJowdX37cOD86MKXb5cnmW1HPE+xaRu0GcaTu68tqTngxBchrgxZTbpIR2uNE9AtKPPzxa3j7k/K+js1Ut8R6qhivVk9+8Ir9sFPqKCaH0cyGTro6gZ6cvF34ombegvK5DmUeUoKfI+zwfqDLL/mrF3capBDCV+NsUms0gxXaR0KdgH9wp9USKcCHo2y+WyRMaTR76w747N0EDW2ybL9YQJK7WHEryBodBNccyP0KQSfAccspN2B8WhEI0eA+n7TWvkN0hLV0WlX++xCZjrkVLurvRu31u4uUgIB6T4sN0s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5344.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(86362001)(6506007)(4326008)(8676002)(66946007)(66476007)(66556008)(6486002)(966005)(8936002)(82960400001)(52116002)(55446002)(9686003)(83380400001)(6666004)(2906002)(186003)(55236004)(26005)(44832011)(6512007)(316002)(53546011)(38350700002)(38100700002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1ROK3IxTzBObXJFdTdBUVNpZVRmQ0UxSlQybDdvNmdnbUh2RGg5WCtldU91?=
 =?utf-8?B?MXRNYURzTHl2Z0pYRkFGb3IyUzBXUUhMYXR4T1UvRzU1emg4S2p0RDBRQTFp?=
 =?utf-8?B?bFY0MGZQQUEyTXhOUkpjUGJXM3ZESWgxTElqa2JHV2UyL1o4V1RmNE9FdnZq?=
 =?utf-8?B?OE40eE1nNFNQeEZzVUI1bUpGQTk0Q3h0VVI0TGthNkJrVXVNSHVCbWRMUnJR?=
 =?utf-8?B?U1lsbFVTT21aUUNXR3NLQlZhT1NzMnVpWGgvN1FBYTdaRlkva2RqeU5WYm81?=
 =?utf-8?B?b3NNNmdqU3pFTDFlSkJPUTZsMUQ0ekVkZFVybnJRd2J3bm9uaDlaS0Zzbmhw?=
 =?utf-8?B?UGRhbXMxcUNQcVpqanhlbGUyZDIzTUdvelZ2alE5WGVBZUNlVVRCTmdUVHpO?=
 =?utf-8?B?REtQUk1WeDdsMmY0alVSWWhVWGNmRmdoZjE3WFJhWHlGN0hRem1zMTF4WmlV?=
 =?utf-8?B?K1NqaHlFUmRnMWllYWpTKzQ3TUhndEFubk1yZXlEVTd2eS9yVFpRdFh2OG0x?=
 =?utf-8?B?ZlBjdjlDVldxVzlXZElqU0lmci95ODZBQ3BYeG43OG9PemV1SUlyc0xyalhl?=
 =?utf-8?B?ZTJrVXpEZGt2ZkF6NnZldy9sdDdGUWRLaW1PSjFTSnlVL0dQd0pzQ0VvRnlL?=
 =?utf-8?B?a2JXaGZJQmNtUUFrM2Q3bjlncUFUWVI3WTRCSnNnQjRKT0ZJbE1jcW1XMVZP?=
 =?utf-8?B?WENmbjVTcDF5KzZEZVBWa3EwU1BGeFFaL0YwSXliRWxBbGpJeFNBWUw2RkFR?=
 =?utf-8?B?aXcxQzBuelVibzlWODloMmZhQlhSQUV0VUtWWHNnVWlkckppbVkxeHZzKzFQ?=
 =?utf-8?B?NXFrc0VRK1hJLzBZa0ZJK0EweFB0QmZHc3paNHFrUWtBbmc4cHpRYmxCTFh1?=
 =?utf-8?B?WkVUV3haOEpqaFl0TVp4V2dxR3d6enBVa240R1c3RGs2Y1ErZHQ5Uyt4U21H?=
 =?utf-8?B?UFU3TlJJc2JjUHMyVnhKYU9hNXhuU1Y0Tm5yZWQwdTkrMUptdldUb1BmaXhy?=
 =?utf-8?B?Ukp0Y2RNVDA3YzVMMDBtcHJ6RGxuTGxKN1d4Uy8zbDlnUGF0T1NSL0RCR2Ry?=
 =?utf-8?B?aUIrOVVMNVBrRVZ5V0R0VXVWN2IwdzRvYi82dzJMV1NCWG1kb09ZNXF1cWQx?=
 =?utf-8?B?WXhVQzZEQmlxY0dDSytHTU0yUEgrTmVDMXZqWDhLeFExMU9mOFUvSHVmRXVO?=
 =?utf-8?B?VXVPV0d0K0Rvb0VYdGtuOWZYWnZlRXdvQXFHNWNxSDVGdWY2U2pjZ01ncWMv?=
 =?utf-8?B?QlJnSTIvMksxRDdsSUFZS21HSHFnRG5UU3hXbFdBNUdXQmwwMit5Y0dheDgy?=
 =?utf-8?B?UEwyUWIwWmNhSDNRajdwbkRFSEtYV1M3amQvOStwSEl4ODFFU1ZvdW13dlJk?=
 =?utf-8?B?V2ozZE9ML093QWl4UDl2dmovaUlidTV6SnRZM3NzZ1pTZVZIMGN5SzZQVUQ4?=
 =?utf-8?B?Y3dRcFRRN0NvMFRJU3VvdzVMNHoybjRubS9VdGhpQjl6d3I4aFgxakFsQk53?=
 =?utf-8?B?OXcxUy9YOVBQcFVhNU91QUF3UXRtU0tac044aEU3U3pVTVNPME9mQ0kwU3pX?=
 =?utf-8?B?WXZxN1hVYUhMaXRJS3BSNHdXVWZEQTlXcmxkTDNWMVhIajlDaTUxQjdIWHdh?=
 =?utf-8?B?WFpMWXRqRTNhcjdsZ3JxTzNLMHluTG4vOStxRU1udktES0l1Q1RROGJUQmhD?=
 =?utf-8?B?VWFQUTdiZTExT0FWaFNoNW9VUzFhWkNQM1p3MXBNaHcveElJUXFCdVllT2U2?=
 =?utf-8?B?RnI0Ky9wSStpdmticDk3RUpOZW1xNmVpdmFJNUIwYWc2TWZpUFpueWcrN1pq?=
 =?utf-8?B?N3lWTTVuRjZPbWNuTWdQckx2ZFB1MGQ0RjJIVE14UnJOZG9GekpXZ0dmKzAv?=
 =?utf-8?B?dEZWTFpSM2I5Z3N2VEJxZlRUSzhhbk11blNUdktjbjg4eTdpNklPenRDTzdB?=
 =?utf-8?B?YkQ5Q0ZPSUZyMEpKR3Q3MWt5SXBkMEZEMEZjam1Ea2VVNnQzVnlybk9pN1BL?=
 =?utf-8?B?ajR1TlMxblVDRHAxbFFpOEgxMks2Tk9rdGpjZW9XbHVkZDlVUXhScGNSNVhQ?=
 =?utf-8?B?ck5yeUlRMHhhZUt4TnFLWVlzaStkQm8vbFBjc0xvNTloM0NvdW1QNkw3ZHJN?=
 =?utf-8?B?MUFydE9SMU8wby9LREFxMXZMRkhSZ0hVUks0cmUzd2FFbjZPaW9sMk9ZOEsy?=
 =?utf-8?B?VXZVYzlQWXpUdG9rTmlGZDlzdkdENU42S2Qwbkp4MDhSdE5RM1doREl6Mnll?=
 =?utf-8?B?M0pzQjNLMWVlQkl6NXJEb3ZINXF0dXRrRDl2bjVHTVR0WVZFOUtIZmczUFkz?=
 =?utf-8?B?ZC93VU4zRzZzYzBzVWxWQmx6ZzNzWGpMQm1wanZKSUN0d0R0cXFuRVNUODBQ?=
 =?utf-8?Q?4Vcai2HGJhyIk6IETUpd4OkQsAPY2vbRx9Mtd?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d107d09f-c9d3-4129-2102-08da2105d220
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5344.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 06:36:52.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 WP6VpZNv7u/qT6TB/+I/LMBl87dbVRDXmOLHc+c1gv2ULnrxtPvoM/z0S46Bx74y5crFZUyBHMFtQ9/4k79pNqFISMCivDTk1+ZHb4GyXaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Apr 2022 14:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8104

Hi Chris, (and lab maintainers)

I noticed that the labs other than lab-cip-cybertrust are offline now.
I think lab reboots will be needed.
https://lava.ciplatform.org/scheduler/allworkers

Best regards,
Hiraku Toyooka

On Fri, Apr 15, 2022 at 5:52 PM Hiraku Toyooka
<hiraku.toyooka@cybertrust.co.jp> wrote:
>
> Hi Pavel,
>
> I'm sorry for the inconvenience. The lab-cip-cybertrust was offline
> with an internal error.
> The lab is now online and running the submitted jobs in sequence.
>
> Best regards,
> Hiraku Toyooka
>
> On Fri, Apr 15, 2022 at 1:56 AM Pavel Machek <pavel@denx.de> wrote:
> >
> > Hi!
> >
> > It seems that zynqmp has problems:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/2336993733
> >
> > Job #663506: Submitted
> > 67Health: Unknown
> > 68Device Type: zynqmp-zcu102
> > 69Device: None
> > 70Test: smc
> > 71URL: https://lava.ciplatform.org/scheduler/job/663506
> > 72
> > 74ERROR: Job failed: execution took longer than 2h0m0s seconds
> >
> > https://lava.ciplatform.org/scheduler/job/663506
> > Invalid job definition:
> > extra keys not allowed @
> > data['actions[2]']['test']['definition']['definitions'][0]['timeout']
> >
> > Best regards,
> >                                                                 Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >
> >
> >
>
>
> --
> Hiraku Toyooka
> Cybertrust Japan Co., Ltd.
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8099): https://lists.cip-project.org/g/cip-dev/message/8099
> Mute This Topic: https://lists.cip-project.org/mt/90469122/1050894
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129075/1050894/1100095814/xyzzy [hiraku.toyooka@cybertrust.co.jp]
> -=-=-=-=-=-=-=-=-=-=-=-
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

