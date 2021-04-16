Return-Path: <SRS0=huVY=JN=lists.cip-project.org=bounce+64572+6379+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D279AC433ED
	for <cip-dev@archiver.kernel.org>; Fri, 16 Apr 2021 16:11:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C391610CE
	for <cip-dev@archiver.kernel.org>; Fri, 16 Apr 2021 16:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C391610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6379+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uur7YY4521723xRGlkSlbftg; Fri, 16 Apr 2021 09:11:15 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web09.11288.1618589472254165078
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Apr 2021 09:11:14 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id RBGD10859A;
	Sat, 17 Apr 2021 01:06:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH+EQgMx6s92MItkkf0WnITGiSoRAr3vnDBSEbVwKasRwOkqZ8ViQhTbpFx1vzjnkeGSHcm97bQP2ERjdKmlUzSpwaKPEsUD7CtIn0+lU1R/QnSKFqx/lvyq/8z//3G1LbF5tkyw3CPOhFxZxQove5Bi7iyItybxmsjdLPwXcFbpFWeH91745JM+h7N6eyX7iDNfiAhVDZtnxeTeIGHZnhKyZ4WnOtQzIxQjQWyEuEzVX/JAx+6QUjVJEjkzNVtMS46EeObnSMoFQ4Qoq8hJQStEp5hfsq0msHadEDrYcvOsnM4s4BCTz0Uh3KxHd5tC1qPx5AuKzZAFTGjIcpbNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZMDWO7ymJnm4U0PR2xgoZMbTr6zSGrenFRK+YvHetY=;
 b=hX2eqsvupd5COcLdtVAQsVYZFJEEOat9wdUdtwEZ2CQnrXPa3WxjTYs8JMjjOB4RE+6a32uB19OGuGSaerlmvDvyLAtSyZAua+aXzIA6c7aZdik5L62grI2yA1DyKDWAIJ1/ZR7YeDn750MS0kJGYy32JcpLo7RBhvgm4zmV5S5P3ulV/Dibj1iP6g3h3sADJNn0yXuaY3hVsrIuGpS1V4CkssrsVFxZzZBEvSXlznmSlIBRTWw87hyJSJD9353j+TXmdgxwU5GrBnl6zra42PlQV2OnIvAmCWRsElN6JCmTWFHVD4jCEMFOKaZj/zp7mxItyOaKc6yOoT+yvY2/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSAPR01MB2977.jpnprd01.prod.outlook.com (2603:1096:604:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 16:05:58 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::78bc:52e0:d095:acbc]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::78bc:52e0:d095:acbc%7]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 16:05:58 +0000
X-Gm-Message-State: DOrxjfAGqiOKKsibx8Sq3ckax4520388AA=
X-Google-Smtp-Source: ABdhPJzNRPI+3CLoXIgIU2WOc60VhITqHw/Ss/Cnf7KobiQtUeyu8nveiCF1DOO4VgxhF12t9b+KSwqiGM+m/IoRQoM=
X-Received: by 2002:a05:600c:4e8c:: with SMTP id f12mr6082025wmq.123.1618589148679;
 Fri, 16 Apr 2021 09:05:48 -0700 (PDT)
References: <20210323225455.GA22020@duo.ucw.cz> <166F29397571E962.16188@lists.cip-project.org>
 <166F462C2FF9F4F0.22720@lists.cip-project.org>
In-Reply-To: <166F462C2FF9F4F0.22720@lists.cip-project.org>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Sat, 17 Apr 2021 01:11:08 +0900
X-Gmail-Original-Message-ID: <CADPJy8Vvx7TZVaTt6yRQF7BijYKi3Qoax0gCzKmjgRa=PN-bBQ@mail.gmail.com>
Message-ID: <CADPJy8Vvx7TZVaTt6yRQF7BijYKi3Qoax0gCzKmjgRa=PN-bBQ@mail.gmail.com>
Subject: Re: [cip-dev] 4.19-rt tests on zynqmp
To: cip-dev@lists.cip-project.org
Cc: pavel@denx.de, Chris.Paterson2@renesas.com, 
	nobuhiro1.iwamatsu@toshiba.co.jp, masashi.kudo@cybertrust.co.jp, 
	yoshihiro.okada@cybertrust.co.jp
X-Originating-IP: [209.85.128.51]
X-ClientProxiedBy: AM4PR0302CA0024.eurprd03.prod.outlook.com
 (2603:10a6:205:2::37) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-wm1-f51.google.com (209.85.128.51) by AM4PR0302CA0024.eurprd03.prod.outlook.com (2603:10a6:205:2::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 16:05:57 +0000
X-Received: by mail-wm1-f51.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so16828550wma.3        ; Fri, 16 Apr 2021 09:05:57 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa917f3e-f475-49fa-ed1e-08d900f1855d
X-MS-TrafficTypeDiagnostic: OSAPR01MB2977:
X-Microsoft-Antispam-PRVS: 
	<OSAPR01MB29775CF026AC2F5DA5413094BD4C9@OSAPR01MB2977.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	9uZ52Jdexu3hNVPxZ1f/TFkeLL860KIURQAqxCgvuRXsribO+ok1EEdwP7IvWvH8AQpKYopXf3NjlA5YQmnoV5knNELFSyUWvlktdRSHWORTJ9LlJIBy9o4DPZ5LTmSknNrVrj0F3cDuQHIKB3ZML8wii7TXrtKG5REhWqSEsqIdhnmnmGbEoMSafRMVJeN9O3oa5wiKBvcULz7vGNme9go8qdC1r9a0S2cAnBW8H6K6MfiejFWl3eVBo/B2nveIn3jb0Au6xW4ywh+AM18Ty+O0b6fn/JTpA+Z+irnZurQN6WxUEOUGT3ChgzmmviFTR0fwQNpKDcleap67BCN4Lbyyox/v/nOhcGgXrouCZO010LcsLcSn+132EFLL+OiiF8Fx4rAVQA29VKQDxC4gvIi1SI8H9sF0CjnRz9/O0w3GMijNoczQttzRjm3Q2RoeR0V7GTvFpECY7nhaH1msV04GhIEXhS3y9lC+cDtS29ZOscU7w3zvhLfcHRaKRt5tt87l5GEfgd0UoW71wq96OBcjy2EaxNvx5mzOkLxGPHs9X6lXYF3RqhI7o1DKrKBUU/NRETfUojEERNaAnWIqLqvLY2tD2/4YNgo7YH5iBYmQnck63kMuKQNfblegHRQWtZV0nRCx00XN7tbAQgeH0nfzONq2VkKRtSLD0k5A87JmM9mtBbI7x8jQMu+HfIVp29/2QBEVoLmaYTWcAqSjtaoYOWXt6ohgbEj9WFJmQ8A=
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?WHVSVmFCZ0dwc0M5Q0o3N05UVTdIQnpZbTQ5QU9qQjdzM1kzZ0s5OERvbmdB?=
 =?utf-8?B?RVIyOCtkQ0ZvSTFyYUtVeUF4U2VycllyUW85alBmTlJVREI3ZlVTNVFGRkFv?=
 =?utf-8?B?RU9QU1hBVW13TDNIVnBXQ3Rzc04zOFBwcUs1OE9hb3ZwT0Y3RjAxRnplUUFM?=
 =?utf-8?B?ZTdIUDArT1RiUHpCZWpFR2RxRjAwTXFwWHl6RGJ5dFA2YnRTWkl5VTU1OENK?=
 =?utf-8?B?ekFkN1I5dHQ2RkNHS3hzRk5zK3JLRlBKNWFPVjArdVRVTWh1MTBnemRIcWoy?=
 =?utf-8?B?c21uT2RSL0Q4UnBLUXpJNXJrV3AyOEFmM0p2VFBQNmN2UkVCbjFWUEVIK2FG?=
 =?utf-8?B?cThtSTcyT3VCdjJJK2IvWmk0T0IwNUxTYjRyMzgzd1BYQ1hsVk41LzZqbHow?=
 =?utf-8?B?cnNsQnhoQ1drUFVsWkJCQ0xqREZic0dPRHgyY0hmRHdqK0tmL0g4bFRVMHBp?=
 =?utf-8?B?bFd4SUxzV1h4YWNzWkNYRENFRUlZc0xITmV0WWNLZUJtUWVCdHhJVmNkY3NK?=
 =?utf-8?B?NXgrbFh0YlB2VWpPcW8xM0dGamIyQU5ZRmZZdlZFdkhaVGxuUkx5QjhUZGlE?=
 =?utf-8?B?aDdFZmVmRTQ3SGQwMjhrU1dac25yRHJlVTBIS2E5d0djZ2djWjlTOE1NUTVu?=
 =?utf-8?B?N0dPc0pJT09pRG0yYTNucE5KSkxnMlJUYlZqcUNEY3FXSCtpcDNKd3Z0S1pZ?=
 =?utf-8?B?b29PY0l6cndoR0kzL2c3RG9GQ3VmQWNycHF0RUtFWjdUdXg2UlFLdXkvWTY1?=
 =?utf-8?B?ai9oMENKQXVPc0RtbTBrcVlzVEorOVZVRm1zbk5LTHhWSThObkJlN09uRFVo?=
 =?utf-8?B?VUJHS1VhL1BnVFd1QW5RL25lakhqUWUvSmJnMm5ZTVdtNzlrbEIwYndteU9V?=
 =?utf-8?B?bTRzbkNPbFhKM2xoZmRmcmZPR1FDSjYzT2dUYVZQalRwbUxCNkpBeEY4V1lV?=
 =?utf-8?B?UXgwN2RuL2ZUMFJFbDlmdEZNck5Hd093Nk9nZFl0anRUMThvNXdlNUhOSWpB?=
 =?utf-8?B?bFBJWTUwOWwxamp4Y2FXQk5aTjlFNlBzYUJaSXBHRlJWTWxTOXUvcFovMFYx?=
 =?utf-8?B?T3JmVHU0WkU5clB1YUZVTWZ3ZTQyelkxNm5iTnhZZXY5aUljS2tKblJMWHAx?=
 =?utf-8?B?NGhQS1NKejhHbnZ3My9VdTl4Y3RWb2syL0NRYVZMZ1BjRTA4UDZuVTIrUG5Q?=
 =?utf-8?B?dFF2cGRDUnk0N3IydFZKQ3l3Y1JFcEdCSXhYdTVQUC9rSG1Nc2hDSjNlY1py?=
 =?utf-8?B?K3dqWnZXajRocm9Ud0FRSmQ0N2k3bWxpdSs2MEt1cFdYNmpjNm12a2VHYXVM?=
 =?utf-8?B?OEVtdElBZ2w3SlRYbnIxQmI3SlNBN1hiMk56NTdXc3JNZXFDd3JlbE9iT3Bx?=
 =?utf-8?B?UU9oamJ4a0o0b3dON3pLMG42azlUdUJMYjVYaHFjaFU1L2FkaVpDVGlUcHhX?=
 =?utf-8?B?UzFjMDhidGJQYVFRRW5Wa3RweDM0RFA0aG5XbGJQL25tdG81NUdRT3FrZUR6?=
 =?utf-8?B?cnRkamtVMS9CeXY3MEEvV2V0SEVPZE1iSjhiWEtBQlJUQyt2eDVCMmNkajFL?=
 =?utf-8?B?UnloRTZ1eDgrTm1kMWFsU0QzR1JoS2RBb2c5blhhZHJzbWJ3bHBEVHdZb29q?=
 =?utf-8?B?YWxkTGpKVEI5OCs2OGdjWnhyQ05pMFFFTVc2ZFFPeUNmYm9KZmJrNGF2alpV?=
 =?utf-8?B?TlVIWkVxOHgxQXdNVTIyQ0NGY0lpazNpOVloeHVPR2liSmtMU3QvS2Y4YVNl?=
 =?utf-8?Q?I6ldxhF8djtC5UVsAoaHd03tjEFujNpzNHED5vd?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aa917f3e-f475-49fa-ed1e-08d900f1855d
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:05:57.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nwDsviwdhD/hKpKqf+HeZd23ViOfATzpHY08djCPdhnvYFxT0s9TCTWwO7sYNL2Zq0g+G/shxDYUUFK6g6SCfCr79lfMuiEmdx2tM7wDbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2977
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="gIxhgxsGVCvOH96zvln1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618589475;
 bh=4t3OHxu1pnlzH3Es0QJY5XxI0SIRvuwqH95jBlmqRUg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AmsJ1RfoWeqZplC9Lo9b9vjtytwLqd7EZ3O+mvzUlsaGtg08Y9rNmMMSoLywU8Afjm3
 LGR3Gjh5BJhQD1Htbpt2Uu7laFMzUpH2ajH/BlVDQTJCLEWVTIXefmq+D2tKwWfMamT26
 MTB6QnJwFScDrx1bb8gSvu4CI6aTvVbhIrY=

--gIxhgxsGVCvOH96zvln1
Content-Type: text/plain; charset="UTF-8"

Hi,

After staring at the logs, I noticed that duplicate MAC addresses were
used on the
two zynqmp-zcu102. I believe this is the cause of the intermittent
TFTP termination
problem.

So I made those machines use a unique MAC address. Now this problem has been
resolved.

Sorry for the inconvenience.

Best regards,
Hiraku Toyooka

On Wed, Mar 24, 2021 at 9:12 PM Hiraku Toyooka
<hiraku.toyooka@cybertrust.co.jp> wrote:
>
> Hi,
>
> I found that the TFTP transfer of the kernel was terminated in all
> failure cases.
> So this is at least not a kernel failure.
>
> For example, https://lava.ciplatform.org/scheduler/job/191862
>  TFTP from server 192.168.11.5; our IP address is 192.168.11.9
>  Filename '192436/tftp-deploy-4hdvrfd6/kernel/Image'.
>  Load address: 0x80000
>  Loading: *#################################################################
>  ...<snip>...
>  ##################################T T
>  TFTP server died; starting again
>
> I will continue to investigate the TFTP issue.
>
> Best regards,
> Hiraku Toyooka
>
> On Wed, Mar 24, 2021 at 12:22 PM Hiraku Toyooka
> <hiraku.toyooka@cybertrust.co.jp> wrote:
> >
> > Hello Pavel-san,
> >
> > I'm sorry to give you trouble.
> > It looks "Infrastructure error" and happens intermittently even in 5.10.
> > I will investigate the cause.
> >
> > Failure case: https://lava.ciplatform.org/scheduler/job/191862
> > Success case(Resubimit): https://lava.ciplatform.org/scheduler/job/192183
> >
> > For a while, if the same error occurs again, is it possible to
> > resubmit of the LAVA Job manually (or ignore errors)?
> >
> > Best regards,
> > Hiraku Toyooka
> >
> > On Wed, Mar 24, 2021 at 7:55 AM Pavel Machek <pavel@denx.de> wrote:
> > >
> > > Hi!
> > >
> > > I'm preparing new 4.19-rt release, and I see tests failing on zynqmp.
> > >
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/275281028
> > >
> > > But they fail on old release, too, and IIRC 4.19 simply does not
> > > support zynqmp.
> > >
> > > So I believe this is not a kernel failure. If I'm wrong, let me know.
> > >
> > > Best regards,
> > >                                                                 Pavel
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > >
> > >
> > >
> >
> >
> > --
> > Hiraku Toyooka
> > Cybertrust Japan Co., Ltd.
> >
> >
> >
>
>
> --
> Hiraku Toyooka
> Cybertrust Japan Co., Ltd.
>
> 
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--gIxhgxsGVCvOH96zvln1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6379): https://lists.cip-project.org/g/cip-dev/message=
/6379
Mute This Topic: https://lists.cip-project.org/mt/81564242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gIxhgxsGVCvOH96zvln1--
