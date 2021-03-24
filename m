Return-Path: <SRS0=N0yR=IW=lists.cip-project.org=bounce+64572+6322+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6456C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 03:21:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08678601FD
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 03:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08678601FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6322+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sc0MYY4521723xusvlYQTfrs; Tue, 23 Mar 2021 20:21:58 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web12.1001.1616556115559975111
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Mar 2021 20:21:57 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id YMQG02191A;
	Wed, 24 Mar 2021 12:16:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkWwL/cG1RcUX64fHxayI4n3obZeUGVgM1kjt8gmAv1IdFs9amQIgWMkmMU8azKiu4JTzIs7P5NkZB1iVJmMEZwLPS1Hhb3ON9Jhga/be4Ho5P0mIVSnty9ekvSpgTYsSGlfxafyGMmoIooV3gqsXYb39bLU8GFJm7B2Nm3/2vT00gosoj7K9rRtR2VMaN/IUyHm5u/wuCBcpBxDwiPTUslNL2qHmuLIqURCF9ruGYnq8yhusa3xDT2N9BRaD8bnZNjV1DHerqA7RPue6f461DlCE3R5c9Dh9YKPFvVmB6ZHFlNRJrI/WtkD8nixmazJ0C3E+ECjZNq1CYJ2s7bZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i+Er3yHQ1RLH21p5o58z4ksq0liCzCyGUaUxep/b7s=;
 b=gABRVI2zbaxgvm2l0dDjGsRxEWxezB/oueW6Z1G/y6SGRi2svV+dslS8n4ggtZs6J80D/pR3zEo7rsJhyMHqChUmeKUG912e6WjB9o8x7AJ9eH/OcWImb48xysHB9tr61iHs2NlequS2zlPcrAMHSmpccU0Wc/pa0lNWb2lQPJrwD9Djr6bXS8EVgMQPoU5MLIlgpT5dNQSg3OvmXe0+uR5gIzGxH0/yx0z2Fh4Y8mwKbWNwKUtJb2XG2js7LN0XMKJgeUDtDLyxuLDotuEUY8UXigT1/pOkZTucv+4OhPz/HMYyy1YVX+TPW+4dLRazk6psusJIHuJAkvHkIUu4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TYBPR01MB5344.jpnprd01.prod.outlook.com
 (2603:1096:404:802f::14) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 (2603:1096:404:803d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 03:15:52 +0000
X-Received: from TYBPR01MB5344.jpnprd01.prod.outlook.com
 ([fe80::284c:ee11:5324:1c11]) by TYBPR01MB5344.jpnprd01.prod.outlook.com
 ([fe80::284c:ee11:5324:1c11%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 03:15:52 +0000
X-Gm-Message-State: OChAGQzmlkHTlOrj8t5H2pwOx4520388AA=
X-Google-Smtp-Source: ABdhPJxGnihsIUu5PC+iW48DY3YEgDuDqUKPCWgH7x3hwNtwl3Tj/jRdqcPEcD+HLVeuT8T2pgja7kF7f9FyHnsiK0g=
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr1207433pjo.61.1616555745839;
 Tue, 23 Mar 2021 20:15:45 -0700 (PDT)
References: <20210323225455.GA22020@duo.ucw.cz>
In-Reply-To: <20210323225455.GA22020@duo.ucw.cz>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Wed, 24 Mar 2021 12:21:48 +0900
X-Gmail-Original-Message-ID: <CADPJy8UnGv9x0fO9WeqxQyzFYDH=0L0XYug0rpLd36-4aiHHjg@mail.gmail.com>
Message-ID: <CADPJy8UnGv9x0fO9WeqxQyzFYDH=0L0XYug0rpLd36-4aiHHjg@mail.gmail.com>
Subject: Re: [cip-dev] 4.19-rt tests on zynqmp
To: pavel@denx.de
Cc: Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp, 
	cip-dev@lists.cip-project.org, masashi.kudo@cybertrust.co.jp, 
	yoshihiro.okada@cybertrust.co.jp
X-Originating-IP: [209.85.214.177]
X-ClientProxiedBy: MWHPR01CA0035.prod.exchangelabs.com (2603:10b6:300:101::21)
 To TYBPR01MB5344.jpnprd01.prod.outlook.com (2603:1096:404:802f::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-pl1-f177.google.com (209.85.214.177) by MWHPR01CA0035.prod.exchangelabs.com (2603:10b6:300:101::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 03:15:51 +0000
X-Received: by mail-pl1-f177.google.com with SMTP id e14so7176624plj.2        ; Tue, 23 Mar 2021 20:15:51 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f12cfb35-3dfb-4130-ed1e-08d8ee7320fb
X-MS-TrafficTypeDiagnostic: TYAPR01MB5353:
X-Microsoft-Antispam-PRVS: 
	<TYAPR01MB535349A0D650C343D398D302BD639@TYAPR01MB5353.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	GJ31mHFEXCyy43DXUEHCeD8OzCGOwALNebv+CpBR2ns6Sz1li4HYNvhCgehn47fn7Vel2kFNih9ke3R2cEK5p+duel1PZb9AL0Ll6eOFUCXLXonzd2KTsf06wm2MZwaBszl7lqHtlgOfJxdy1x+XNMFsAGI4uKb8O9miqwa6yBlzlH2A/x35fDGgimDBYL8koTMYq+BQq2fxKEqyIVqVrvHr/LQ2Ae0vGiSRDfDWfHtECyiCYPCigJ9A7UxWYNAIuN4/9Hs2vMUn23eayxr6XOBhV1cRIO+a35cYFgCyo/7miO+uEOFZ0EOPc+vRmEIAxY4Nk2O0XZq9jSk4VeORwPHfyiFeIeqmlJKBwX6Cn2m7bTgCrCXIisgF74lts8WdICavvpPEXf+qUjk1+je/VdF2h4E9GQLLxoUNX87IO8sB2QG30fmlvoHsEStUu7OGKNxTMexzl5lPexGPMKo96zofP3Dd04j/JnrxY53h9PuHmRokaczH36td6gtVzgqQ7yZPPcQ9MuguNQKI11Wvaf+dsbwtWTvWscqJje03esqfAiEokwZe/qmL3mxu4CM69C+rPqAQLHA8cQOdEIL+V023gAFP/RsIKtPMqhRbeMPlaVSJxSEzB5G+7MyhgknY53cUIacCZ3bBlUwOGLXD+fFlnapdlB4vedaWxrETbuYDvDBgnWHIVLrxOAQXrjVh6geyqNb5KKtAXR8pnQAZfQn9zlOD88jpiP+50KPvYSZ6pka+8I0NT7WcH74AiqO6
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?Qm1hZ3R0ekJmSmZsL09MTlBNcGlxVzRJRWZzMDB0c0prZkFIMlQybnJzZm5O?=
 =?utf-8?B?dkZtRExTL3AxR2dZb1ZsSHZsK0hvSm95MGhqdkZyN2kyUW1QOVFPdzlsMVlD?=
 =?utf-8?B?bjNUU2FkbStaRDJ1YWxxWTBPVzZIbFpJZ0VnbCtab0NSS3IzTGM4SC9GeUVB?=
 =?utf-8?B?TkdQTGF3MFNsSGx0U29RaHFsdmY0ZzJEWFpMMWIyNDJ0dktSSXFVOXR5RDJF?=
 =?utf-8?B?RG5xeFZOUHNoTWFhU2JWRHhwQWlCelhteXRLTVN0MjVRdURaQzNhTVdFS1gx?=
 =?utf-8?B?dXprQXRtS0ZmT2Q1Q3JSRXBBSE1yOWZCcTBZM1ZVREVxN0xFaWFWRzduQ21s?=
 =?utf-8?B?b1prRUtmMWluUTRJS0pOcWZCQVZBZXU2Ti9xV2hMKzJzb2hPWFpxd0s0bGdk?=
 =?utf-8?B?RjV6WFZsTy9nZUdBZE5wZGIya0dYNmROWUxyM0ZjQWNpd1E3YUxUMGVMb3Rp?=
 =?utf-8?B?Y3NqempyM3QvUnlRZ3NjQkxkbHNlbXhEYnZDYnU5V3RqS2lTeUpPQ0psVzU2?=
 =?utf-8?B?dzE2MFBvbVpHSnE2M0t6L1MyT3RoeVdZamVYMEZ5cUFhQUltZW1OMXlXdEo3?=
 =?utf-8?B?YXJzNnZqdDVHUlhiSWVzQ2I5SHc2SG5GcGlmN09UbGNaM0svdDV2STloaThJ?=
 =?utf-8?B?anJ6NU55N3l0dWpvZm83b3IveE9Oa05EZWcza2lxNG9PTGJZdmszeCt5YmtW?=
 =?utf-8?B?bG4wZXBXbjhVanRYcURWbU1uTTlPcVlid3R2VTF2RFZscVBPQ08yZnBRZklX?=
 =?utf-8?B?VkxFYlJJUys1Nm4yaUdGM0p5OTUxeEhJT1BtMDRuMzNzMkhXWUVJWXkxUWNj?=
 =?utf-8?B?c0paQlF3eUNkVHVHcVpTUG5BeEZja0Y2OFdOeUxoNVVkRDhISVFkVmE5V3do?=
 =?utf-8?B?NEtMMjJ3OWdsdi9MUGhkZHorM3VQbnJURWZidUdYTG51VHpVU3RIZElrNG9I?=
 =?utf-8?B?UzJqK3ZQdGNuRzFJOHJ5ZmIwb1A4akJXUC9SdVN1VWVqTkxjdUo5RGlISUZR?=
 =?utf-8?B?N0VibkVmYWs2Y00yQVNsenpSY2xDcnVJSEVBNzdPODZwTTVNWm9XUTdremd4?=
 =?utf-8?B?N0NmaG05bGduaUh6SHBLekpxZ2wvTFU2dW9XdlcyZ3hYazkvNWErYmUrOXhq?=
 =?utf-8?B?QnFuTVB3RXFSRUZJLzZ1bXVodThDWmhCQWJ6NUxqSkFqa1owZ0NVL3lxVlNQ?=
 =?utf-8?B?amhLckhsWEhZQzJkTnllYUV5cHlOamRIeXJCWUd1ZzJwYmFxMktUODZVMlZO?=
 =?utf-8?B?QnUvdDRpZDRiVXk5N0xyaXIzaU16ZzRyUnlrYkhqNGR3NlVIZzc1MjM2M0hk?=
 =?utf-8?B?SG1Yd08zdTRiYUNlVWNMcS9OZmJoTkZob0ZnKzRkdi92T2FCSEx5NGhCZ1Fi?=
 =?utf-8?B?NmNlNGJjandhdVJoTE1rU0xoTXhOTlVyZTRTZGlWU0U3MnI1SkVPTnMzUGN1?=
 =?utf-8?B?em5Ud3dtRVNsR3h6RTMwSFV6U1FZOGV6TzVFN3VtNGVFdkcycTdpbmdkOFE1?=
 =?utf-8?B?dFltR1V5UDFsZDJGYjljR2wwc0sxUWFCaDdvdG5ILzlMcmc1eVZybkdEYWNh?=
 =?utf-8?B?MFBnVUk1YlFXbTJ0QVJ2RXB0Z2JYRlBoMU1aUDZNa0tIeDBvNHVxaHpQcWI2?=
 =?utf-8?B?Q3Nhb1Y4MXFLZmpvWWIwWkttL0VTQ0NSbzdyWUIzTGgxZVhBMTFUb1JBdTkw?=
 =?utf-8?B?VGRvY2JJa25mUU40K1NDeFJyVVpOcCsyZjB0aWdWNUROTStHRVJEVCtXcEhq?=
 =?utf-8?Q?eCUx7Fawki3EsXs9I+pbZSsBAVyVAInYjXz3VNC?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f12cfb35-3dfb-4130-ed1e-08d8ee7320fb
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5344.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 03:15:51.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVTgdMnO0gipg4oqwP4GP5js9iIdnRjzGIcWJfV4kfTD02RSKVnBVBxwRErFrin20cek9VY1FXu/MXue4IpxoF4C5GzTVZYTuufuV9FFico=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5353
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="vuTAfgZmRco1hlWCAMoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616556118;
 bh=etT5w4kvAw3Ub98cb3ArOikAKVa22lYWcih0Fdvk02E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fPphNH/Dpa9hikdMjsRhHotVeRESTWgvgmXwlJB2owk+FidLXQy/1pJlO+xcY2dJmEH
 Hq1u+EQBkkDEb/rQIlHgscZcdsfG5ZyEDdrKsSJ8vRoQg9di6J9HjWLOjqmmEm3yq6UdS
 4EOyFZvTq3QgE/+qkwA4FDXIK+Bh2tN5Vtc=

--vuTAfgZmRco1hlWCAMoh
Content-Type: text/plain; charset="UTF-8"

Hello Pavel-san,

I'm sorry to give you trouble.
It looks "Infrastructure error" and happens intermittently even in 5.10.
I will investigate the cause.

Failure case: https://lava.ciplatform.org/scheduler/job/191862
Success case(Resubimit): https://lava.ciplatform.org/scheduler/job/192183

For a while, if the same error occurs again, is it possible to
resubmit of the LAVA Job manually (or ignore errors)?

Best regards,
Hiraku Toyooka

On Wed, Mar 24, 2021 at 7:55 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> I'm preparing new 4.19-rt release, and I see tests failing on zynqmp.
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/275281028
>
> But they fail on old release, too, and IIRC 4.19 simply does not
> support zynqmp.
>
> So I believe this is not a kernel failure. If I'm wrong, let me know.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--vuTAfgZmRco1hlWCAMoh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6322): https://lists.cip-project.org/g/cip-dev/message=
/6322
Mute This Topic: https://lists.cip-project.org/mt/81564242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vuTAfgZmRco1hlWCAMoh--
