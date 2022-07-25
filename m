Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF1C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 06:24:55 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web11.24957.1658730289335572546
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jul 2022 23:24:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: cybertrust.co.jp, ip: 202.241.206.55,
 mailfrom: hiraku.toyooka@cybertrust.co.jp)
Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp
 [10.16.47.42]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id
 ZPTY31344A;
	Mon, 25 Jul 2022 15:19:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkmI8ssYynn63FL9vIH56JxzsWm8TkhRy6oOSn5dUhEmFPS7BxO8AtouEVJGFMMeFRb8VJiMNgdZ6MXD/LHTa9MhWgY3d4L34njCOxyjjZH6bXjBLEAQ0heagtZcLNWo3DhYOfXr0Ak8HQvrYCPVdrQGsYLJ2r8ywDYdaWb0kOEhrWdkHO9Ro1sF/m+L9nCsUPpJmUevOo9iPWGQtEG+pqlE+UxQqhHxDGT8/N2Bav3VwEW0T+RlOOFB106hNbCMALobahMP+g644O9ZnoRrGazNa9l029j8Sy15dfpTdkHtSxyS9K7jMYpjc4m4ZMlE+bN3RQff8lk5PPcO6zNIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRJioibsHxjAt6pLNHO8zaTqcmCsC6FAqwIdu5nZmSQ=;
 b=HL/sXa20piOPN5hWsjJxd6Rj8QUeulNtkyOVeBTn/nYIikypIJrwnW0Koa3Wg3lejFGnzFuhO+szVpTToR0Hy711YbWp7gk5Tt8bQ58VX+5JpneLSa5zuCzz107mDnncNG8ExTEmiiXbJYaisYvKv0VLiM2hIpyQUcp+oKYdApBI1ovMwrZBFEfRsRTv+Z/lWcrCsbHYjmMc2TgVR1KUOMtlpQXEiQRkNGvTkQRKR74pUIu42i4hrAr7d5ipnXYacWwmflHuweLQnj6DaFhLdaNnt5/nIh7q23cDfCpdQG2OaKmikIuDRF4WFl8epR9mCgYCYRyScF23FHlal2eJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by TYAPR01MB3550.jpnprd01.prod.outlook.com (2603:1096:404:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 06:19:02 +0000
Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::246b:97a6:97e6:a33c]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::246b:97a6:97e6:a33c%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 06:19:02 +0000
X-Gm-Message-State: AJIora9RDKU+cV3uF6A7EMu3+T+0xfaKSr8PBJNkY3c5s/KSg5U5tT1V
	0TzLfTcUoi7mkKhZA79q+ZVKJ3sqfCFSL98IsyID9g==
X-Google-Smtp-Source: 
 AGRyM1uiaQjHRngUZ5nU9bgB1PrOYBVgBtO9uti1eWbUKwnLg6QwEfCRqqa/vXtFS8fRpgB4ah/Ymz1cBDoyFu38SUw=
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr6733993wrh.193.1658729601188; Sun, 24
 Jul 2022 23:13:21 -0700 (PDT)
References: <20220723210456.GA7918@duo.ucw.cz>
 <CABMQnVK74F-VbNUecaNFqP4CB-fCns4ZBkyovkvqn9v_xpo0tg@mail.gmail.com>
In-Reply-To: 
 <CABMQnVK74F-VbNUecaNFqP4CB-fCns4ZBkyovkvqn9v_xpo0tg@mail.gmail.com>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Mon, 25 Jul 2022 15:24:42 +0900
X-Gmail-Original-Message-ID: 
 <CADPJy8VTzdF9oO+sD_SkEPeZcWd_K=CiJnPGyaSnsPG6ib3Vdg@mail.gmail.com>
Message-ID: 
 <CADPJy8VTzdF9oO+sD_SkEPeZcWd_K=CiJnPGyaSnsPG6ib3Vdg@mail.gmail.com>
Subject: Re: [cip-dev] Failures in 5.10, 4.4 testing
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com,
	Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>, Sarath_PT@mentor.com,
	Manish_Kumar2@mentor.com, hws@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV3P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::10) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb1a875-2959-43af-65e7-08da6e0591bd
X-MS-TrafficTypeDiagnostic: TYAPR01MB3550:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O97FUH2NY3Gv0OZJP4+im2Um1g0jxiDkWbv7nUd0XdJg/HcmSZUPJcMtleHq+aKs0q+xVnb0drSBb/p4ptLUw2Um3DUxwWBfOz1UZ2HRYEtoONZJ2KeQijtQGz9B9sxS0li/h2nST4Vd8o/tEmQHaYIwVxW2szhe9RaKrT2jljrF6LddG1nnuL2cgVWUY/HJtAzOWpCyzZD+FXhMT1WaDBARNQCMzvMltv30m4KXpB3dxusu4UTgVBa6I+nk1UnoE/62/7cgrtMhlAmHExcYf3dC1j80a1fLwHlod5BVh7+cXwSPUb2XIuM/QW9C5AcCEk03kItYZ2RLxR3U031JY+q1S9hm1iKwFR5J7WQYU1ULaNY9+LCL/VTCC1iZQQRW2qKRwJewSxZOW9NdHRr0SxDIsKHvU/8T5yXmU0MmefpHrhpC1iHzlzfpFofjzhEXtOGk8y9lOnk6sGmR0udSbQfJClcVJV6gge5ELtuFlUvnfTeLZp7LzQyAuDwvj57gFSDUjc60rhnPQBxFummxQ3HKpYXQl4unCLu2kssPBnxgWouceDDQWzgTW6lYu7YuwjPYAjavyUojIcE3f9sHo7E7orP1s1jKp6P7+pJy4FG51Y63ecAprLgmwMvBMDDeeiNXVj7NCorZXLhggQYZyd28JTA6R8EbIZCP6A+UeZcWTDRtNKymQF8sUKUnZx8649EMl0swipMrHwXuBGT3Om3E8+xzUSBf1NASCgp0BNewKcjCIBuQiQUZBsUAfq0KnQjtLhJooAEod06DKd8K/rzHuMf6yQsJBEmfNC6Z56BC5WpynYXHV2U35nV02OoMVGjAUa7ZmwmALuNRuOeK6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5333.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(6916009)(55236004)(41300700001)(6506007)(52116002)(6666004)(478600001)(6486002)(9686003)(6512007)(53546011)(316002)(44832011)(2906002)(8936002)(5660300002)(966005)(26005)(8676002)(66946007)(66476007)(4326008)(66556008)(38350700002)(38100700002)(55446002)(86362001)(82960400001)(83380400001)(107886003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDlJMWlKVlcxZXVzVXhvQzVuc2JNb2k2UHpoTnRtbDVjYlNGZ0NmOENqNm4v?=
 =?utf-8?B?aUpLSVlqSFk1ZzlNY0ZVcEJvbmZrQzNHMlBrTUdOcjRVamNaVmJFWS9ndjJZ?=
 =?utf-8?B?L0V4OWlBK1pnMkxEcHRiRmpnZENreUpNRUdqeEtKa1Vtc3NCTlp6aFkyaVRx?=
 =?utf-8?B?QVFXTzR3aG1Ybi9kZndMN0VsSDVQMnpVNytMZXRuYk42b3Zub21NdGR0QmZj?=
 =?utf-8?B?d044VDgxRXFOY2VUR0lnYytUOWlETUNVM1g3a0hWS0tldjRzYmZiL1prRndJ?=
 =?utf-8?B?bmxnV3QydU04ZWUvZlE5ZDFHcFlYWENGdDU1YURIbC8ramN1c1VkVUd0VGYz?=
 =?utf-8?B?NDUySGJxNnZWbm1vSVh0OXNhcDhTbmUrVVlhdlNYOHZzWlZaRWo1QmlVQlVT?=
 =?utf-8?B?VzVBUk5Xem1KbktVYStLL0dycU5ONXpIK0c2ck11c05TUTBteSs5aVZxK0hh?=
 =?utf-8?B?eThlNW1wcDFpSXRQVSs0bStHZExDL3IrLzljRGVnU0V5TFhjRThpQ1hqdk5L?=
 =?utf-8?B?Vmh1cml1c2JpUzFma0FpMWYvbHMvUjJaVEd5cjZYZGxocVdBb094MGM0bGtE?=
 =?utf-8?B?N29ndUhwRVRkUTBBQTAzN2kxdlBad0szZ1lsMm5ZWWFYcC9KMnJyMXVDeXor?=
 =?utf-8?B?UUNaYWtyZGpqcHJlckkzbWdkck1vTWtlczBzVjNyT3dJQ2x1SWx5SEpzUVlm?=
 =?utf-8?B?VWJ3RHBDOCsyYy9tTDl6Q05JYitrTWt4OUxJU0VkQW1LanRYbGNIWjJKaWxV?=
 =?utf-8?B?Vk55V3BXck01Wk15TkFJVGhySWZtSU1haVBTUWZrUnc1aDJicU1ya0ZWZ3NF?=
 =?utf-8?B?SDRFVlZjK2gzM1lRTG9FWk5FUFViaXBNeVZkbkZjbFFTbGhxanVCbXVkWnc2?=
 =?utf-8?B?aG5kbmZBNzliRm1mTXhkcFJWcW14ekVIRzZrV3RQYnJRQlFEejlpZ0FkSklX?=
 =?utf-8?B?RHdJZTQwSFZpcmJBWDlLZDdnWDNJM0dmZWhiNGhsUndtZElUTnRjamRPdUdy?=
 =?utf-8?B?Y2F4Y2h2NmF5QUlWdVE4ZzJwVUV3T2NSZ09mRjVEVkhvOHREUXI4dHZiRHJW?=
 =?utf-8?B?WjdySFlmZWxoZ2NoMUFRcndScWlJZ1VsTXNFNEhXZ1NYV2RDc2k4UzQ0MThW?=
 =?utf-8?B?c3RSMzRQZ1NmNkQvMjdTdE53ZnpCU3lqenFnL2Vzcm1tYVBEKzB3bnI3VGhQ?=
 =?utf-8?B?djFsRnBjRTBwTlVJd3YxbkdzanVNdi9Wem44NEpQa1UyNFMrbzBwWHRVMTNV?=
 =?utf-8?B?alJxTUlnSzM3SE5GeXZEdThpcmFoVmNycDMybi96WmVDN1RTVzJzQkJHTFhN?=
 =?utf-8?B?d25ZanR2T3U3L0V6Q05jVGhZL3k0QmxXSXJmRFcxZm8wYTEycVRKNkM5bksr?=
 =?utf-8?B?K00rTlllNEROUUU0bmNCb1A1MGxHQXJybVRyRTREbG95dEIxNXdwK01TdGIr?=
 =?utf-8?B?RkJYamptaVVEYXNwR1B6N3ZTc1pxaEEyWnYrUmpLRGpPeVpXL1ZPUm9vaWxJ?=
 =?utf-8?B?MGJWandUd3hteXFnV1NYTUhWSnpIY0hFY2J4b0VlV1NzZFpRRTIrdkNBQmVM?=
 =?utf-8?B?dXdFNHRXdHlqSzdvb3B4eWdSL0xzcUl2V1N4N3l2V3NiVUpWZGhWYnlpdy9K?=
 =?utf-8?B?SDdDUUFTb1hNdmRoemtHTUhacC90UGt6MndmUXViQkJoZitYVWp2ZVF6U0ZH?=
 =?utf-8?B?NXNrL0pvRlg1cGVGRFNZT01MWnN6cmpSMTBHZHpBU1RkY29RSEpVZjFpb09B?=
 =?utf-8?B?ZFc0M0wyK3dHaEQxUXNsZDFOUk50RzBmdklsRVNzT0xoNEVzUzl1ZmhDdmlw?=
 =?utf-8?B?U2ZwOW9nYVlISVFYZzYwd0MvVGxlY3V2SVFaUC9VZm84YlRmd0JKZlFNZC9v?=
 =?utf-8?B?cE5NbmtvanF2UXRudkhaSlNZYjdkV2FsSUZJQm5BVWZ1cUd1dko4dmlDWGdL?=
 =?utf-8?B?R0xwL0E1T2NGTGdLc25LMW5UTWIya2ZGaGNjOVZlREQzZWtoU3kvNjRSbm9P?=
 =?utf-8?B?MGFaNnhxMldhUjZ0eEVzc1JSTll2WWo2K3FBUExkeTNsZjFnQVlob1pVbTlt?=
 =?utf-8?B?MExoQVUxOUFxU01ML1ozTWNSWGNLZmJVWkoyR0pYZEUyZ1ZGaDRIdTZWeW54?=
 =?utf-8?B?Vzd5cUlHVU00cEd0RmhadWhJMlhKbGo4TG1sZkxlOEEwVGc1NGF1WlNXTVNP?=
 =?utf-8?Q?fKzbTTJmyGAF/9hbmqKHi90=3D?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2cb1a875-2959-43af-65e7-08da6e0591bd
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 06:19:02.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 28qCIfphI5eddLPhl2fqWuppAj6B3r1G3ZgDTC8+PYKTNxBH1bQRLH5QX0A2gSiglZAcBrIvPsKzm/MNN56zSpCVFFPIgdeGKzYUYtblEqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3550
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 06:24:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8900

Hi Pavel, Nobuhiro and lab maintainers,

Some of the labs are offline now due to some problem although I'm not
sure if it is related to
the failures found by Pavel-san (because labs seem to be online at that tim=
e),
https://lava.ciplatform.org/scheduler/allworkers

In any case, lab reboots (the rest are lab-cip-mentor and
lab-cip-renesas) will be needed.
# I brought the lab-cip-cybertrust (includes bbb-03) back online a
little while ago.

Best regards,
Hiraku Toyooka

On Sun, Jul 24, 2022 at 8:12 AM Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wr=
ote:
>
> Hi Pavel,
>
> 2022=E5=B9=B47=E6=9C=8824=E6=97=A5(=E6=97=A5) 6:05 Pavel Machek <pavel@de=
nx.de>:
> >
> > Hi!
> >
> > I see a lot of failures this week. 5.10.133-rc1:
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/595045922
> >
> > 4.4:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/5950364=
39
> > (renesas failure is expected).
> >
> > Is bbb expected to work in 4.4? What is going on with 5.10 testing?
> >
>
> Lava slave (Lava lab) seems to have NFS problems.
>
> Best regards,
>   Nobuhiro
>
> --
> Nobuhiro Iwamatsu
>    iwamatsu at {nigauri.org / debian.org}
>    GPG ID: 40AD1FA6
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8894): https://lists.cip-project.org/g/cip-dev/messag=
e/8894
> Mute This Topic: https://lists.cip-project.org/mt/92574939/1050894
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129075/105089=
4/1100095814/xyzzy [hiraku.toyooka@cybertrust.co.jp]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

