Return-Path: <SRS0=qH8y=IW=lists.cip-project.org=bounce+64572+6325+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A2EC433C1
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9D61A02
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9D61A02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6325+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yihpYY4521723x2jbVwcvsPS; Wed, 24 Mar 2021 05:12:27 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web10.4768.1616587944336535671
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Mar 2021 05:12:26 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id YVHR01149A;
	Wed, 24 Mar 2021 21:07:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm8FUr5b9y65zFBwVbB8vTeJteSdGp3oHjATbrlGD+4i1VsiZiZ54YN5utMpeDIncF+7CafuAjUs9mlYh26zV27nsU/v0YAZLXNFu5uaY6Ku7QFoEJHmA/HIqAeqUsG7g2o49IIhFCnSfA3PxJirywDX4kq4+dVxjGoT2nGdnW3Pd0dpTWObNqXua7OzKGXL9kwO2toHCKWoO/IXWfPs2I4N8f5N0dNwq6JPBgB8tTiHSR7Dfo3CxAFep7jE8/Bw3KVZHRjnLactGVxthfTNGoUUEd76qSda1HUWfjwYO02bVoTL7+D7dhLsGLFOzsJkZYBNpOXKuiQXb5K/2LiYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhpwSQlabC5vwGCutrS5F4/J5L4vqBGJKMqUHWbWKc0=;
 b=RQlKrOOf88mI3hukzK5/egRs725MhfcBa1NEdHam/oX/dpQsH5d3Vk6XY5yl/vpnQWRbFt5qtfYz0XS9o2mXM0+aRwWBXPk1MOuHNgHRdjmTAyRaR764z09KHbXM/3kVQ4SkkpDnNVxSngwl0l8ccLy950GKKIIZrfRhpYd0B3+wKnhRt0N1gKRJcx8wv1pqP47NV7VkAbUuiFQog24vBjNnd6YEs5MhbmScg95jwLHKEN9c7U9yCGJxae7P8NqpTPEJdKWJ8mIycPc8XbFOpwmYVf2xn7e3551PUfFIX5uVM2wSIfPVGMBFJbUErDgAr5K2Xi0SMRHMMGe/DTwsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSBPR01MB5143.jpnprd01.prod.outlook.com (2603:1096:604:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 12:07:13 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::78bc:52e0:d095:acbc]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::78bc:52e0:d095:acbc%5]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 12:07:13 +0000
X-Gm-Message-State: 0R1dLgrkee9YgkO3qtXBPhwBx4520388AA=
X-Google-Smtp-Source: ABdhPJyPlS5gWQRyuGHPnUdnts0HosCqMgY2C7Fyc8bdLrqu8by+UnBshXZEZZCkMjjeMM7u014LlcW7J/hHxLv0WwE=
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr3151020pjt.226.1616587626012;
 Wed, 24 Mar 2021 05:07:06 -0700 (PDT)
References: <20210323225455.GA22020@duo.ucw.cz> <166F29397571E962.16188@lists.cip-project.org>
In-Reply-To: <166F29397571E962.16188@lists.cip-project.org>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Wed, 24 Mar 2021 21:12:18 +0900
X-Gmail-Original-Message-ID: <CADPJy8WAk_09zkOgmBK6Ufw5BRM_NkGCReOEy9LEhCJfVtiKiw@mail.gmail.com>
Message-ID: <CADPJy8WAk_09zkOgmBK6Ufw5BRM_NkGCReOEy9LEhCJfVtiKiw@mail.gmail.com>
Subject: Re: [cip-dev] 4.19-rt tests on zynqmp
To: cip-dev@lists.cip-project.org
Cc: pavel@denx.de, Chris.Paterson2@renesas.com, 
	nobuhiro1.iwamatsu@toshiba.co.jp, masashi.kudo@cybertrust.co.jp, 
	yoshihiro.okada@cybertrust.co.jp
X-Originating-IP: [209.85.214.173]
X-ClientProxiedBy: MWHPR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:300:6c::18) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-pl1-f173.google.com (209.85.214.173) by MWHPR04CA0056.namprd04.prod.outlook.com (2603:10b6:300:6c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 12:07:11 +0000
X-Received: by mail-pl1-f173.google.com with SMTP id q11so7813638pld.11        ; Wed, 24 Mar 2021 05:07:11 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0eba453b-6b78-4914-a006-08d8eebd5b20
X-MS-TrafficTypeDiagnostic: OSBPR01MB5143:
X-Microsoft-Antispam-PRVS: 
	<OSBPR01MB5143F82E7E8627E725F34EBCBD639@OSBPR01MB5143.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	f3kkkzKw1mK/6DpdHCb29cG8TWtk+x3/MdfYx5ejQydl1f1wI+63rH1cjcCvyb2VKTRwFB1jGpF0qm2mzLaauU0/RC65fmTXN4/qYa/bfAAi9F3r9wYxPHSWSZ+5KgLiOK9nLlbRPAPapUIyVJFey/u+hxdd3O6S50T44G7HvWz0e+vOnnmZNE8Vhh8h3MIAE0J6/KYlwUjOsAivPcm+ir8VTjeSIQ0ZusN47xnM8SeM6Wlhqjzaxq3yX2lqvdOt91tlGfITtpzm90qRFzXJwWSFwVw5DX54KOeLIwQWa7Ty23leV22ED+tpcLdBKUY2dOyLN+t/L8iDQKHPWraKRm//yMr6GVz+sa/6BN9cnjpfLsgj+zYta78Te1avAXtvVlSk5jKnvUXW4lwrINXy+B39mhR4TsVnemqyCX0qXNxUZNhdqsYVALkfddb3xaEBnaL5OrdJAX0kCV7RyqcD8rKNdObXLEXStJzspMEEvtKzLGZ1XLexkTpeCf3Tb93qM4xcHyfwjLV9s+rBgfXBVjA+HZA7EKP36vvZS/T7eYm+isxVlukj4J5ICfFdT31bOucTfapLab9QY2jlEnNZfMFe+iRNNmVIwmaF3JIK+Tf9qsrdDPH/zwiqTpq2jzFpchIW0TzXZ/q1yFPF8K/yMxqWyfTGhJ3qXKC9wEAHM5DwOsQ1Wqf2IYdhMM+OtSU4cAFpwYrhT5PxL/lILQXtSAlqW00MmZXN81Y5anDMrqo=
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?b2tyd25aZ2F0eDBIQXRFb0VkRUpjczdXdy8wMlNRRFhrOG5QOXd2b2Rmbksv?=
 =?utf-8?B?cm9OdTduTzlTaW9pVkYvSVJyK2NUbWhQcE9aclUxWkt3N0JQWVFla0g4UUp3?=
 =?utf-8?B?TUNDVU52Y1pRQW41VXRDa1FLNVNPZldLVGhLTDhOZGpUbkozT2RySzNtdjUv?=
 =?utf-8?B?RTJKYmsrQWJNdVBTZWJEYVpDdkZXQVhyU2JsSjdNVjIyWnZuRTZCdldVOVhM?=
 =?utf-8?B?bndHVytESkFHcUVuSlFVbGdIQU5BM0xrcGhOMjFvZlY1bGxId0R4aFhkY3dL?=
 =?utf-8?B?andsR3cxYlNzaWxGUFo4ZSt3ZWVrUUpFdHpBU1JDYXNYK2c3MFd2dGpuTHVE?=
 =?utf-8?B?QU9tSWJRZGtLVHhPUTZPVDIrOW9WdUdoRVNwVkt4NTdjS0VteGVmekN6OUR5?=
 =?utf-8?B?M0tGc002cUtOTkhtTTJPN2lJWVRFc0Y4VStRRm1UYkowUDFyWDZBVmpYaGVV?=
 =?utf-8?B?bzNjRjJTZGVtY05rVjA2aU9qVTlwNkRlTkdLN0Y5VVY2MVFlS3Q2VXVmL29Q?=
 =?utf-8?B?YXVQUEg4S0QrOGhPaTNhMHd0RThIcFVmYVYwTmFBcmNIUjNxenlRVjBPbUpK?=
 =?utf-8?B?YWoxLzFETnBobHcxOVdybFkwYndObEw4MDl0MXBXQnBMdlgzeExSaHRZT1hj?=
 =?utf-8?B?S0F3Q3lPbVVLZWYvOVJTZFpyRjgybFJ0U2E2bmZ5cGdxQVQwWlRxZ2FORThD?=
 =?utf-8?B?TVU2N2RWempHNzhOV0UyV3hLSGJQNEFuQ1A5RHY2MGZRSFdRQVNaVU41bjJB?=
 =?utf-8?B?YjBvMlB3dDBUYkhuRFRGNEdEVGtjRXVTeDlBNGlHVklqRWhpOEEvNUt3REho?=
 =?utf-8?B?NDliUjgxcjloMVNLektFZnpRQjI5SUYvSndSeDZnUFcyb2g1akF0MWs4VW4w?=
 =?utf-8?B?clRveWRRdWsvcEJwcTB3R0liWmxoemQ2VFBoVnR3bGYvc2MzbHBtSWdNdGt2?=
 =?utf-8?B?UVVrcG0zZ2FlUHQ1bXJCWFB1R3ZPUExDR0YrK0l1Zm9iQmVjbTJ3dlVFR0FG?=
 =?utf-8?B?QXpLcjUxbVE2TksxYzdGN3NVaGorSlpPS2dBU2ZKbldNSzluU1BSRUFqcUlk?=
 =?utf-8?B?VndsdkJrWDYxYXBtOTg2bHl0Q1MyVDVXWEJnVVErZHk0K2NCT2FoMUpneklJ?=
 =?utf-8?B?M05ydE9uTS82bVhZZ3RxMDNzTDFXam5MaXVEQTVYQXduNHlyTm43c21UZVVS?=
 =?utf-8?B?T0tWSWgxRkMvemNLSkVTYlVrczdFbFlZVEJKNHZkUkMvaVJ3OC9MRjdGUW45?=
 =?utf-8?B?RE5iOC81bTJMM1lTaXFjOGFtQStzVVhnMVBIS3M2ZENTMEdSTUNSQVNVejE4?=
 =?utf-8?B?NDlmVDZnZGlNT1BOTDVVZU5oOTJsMlhFK3A2WWJ1dFduN3BsVXcwUG1BRVFV?=
 =?utf-8?B?Z2NuNHEyZHhCS3Z1Q3BKRTQ0YmdlQWluMTVmUkp3ZTNxbVkwQnRDVUVNNGp5?=
 =?utf-8?B?OXNBUDZ0UXN1dXoxWGFrUmRzdjhNaHp2NXpCVDRyYk1lR1BUcThEOFhSWUs1?=
 =?utf-8?B?K3BlMXNhdGdVMi94MStaRTJHOG5WaGEzNWtSWlhrTkpMKzdLSStpdTkwVHhs?=
 =?utf-8?B?cmxqSzFSNFUwcjUwLzhodVhEWE8xRjNBWEd1Lzh1S1JudHpTaXpOQnN3NkJW?=
 =?utf-8?B?L3pyYXUvZzRjQ3pDc2V3dHRWcFB1QVNhSHN1M0NDVFM5SmFSQXh0Y2lBNWlv?=
 =?utf-8?B?T2g0ZWMrY09QTGpLc3FlckdieEhLRlZ1bXpTeEJGMjVyaDZZdm1ncmFzRkNV?=
 =?utf-8?Q?wioq8K8mn38utpaSAcB2/FTO8PNvy7AD8ffvGVL?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eba453b-6b78-4914-a006-08d8eebd5b20
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:07:13.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNvtiKhFnFMNg9nKe9POJbvuVBInlDFRGXp0n1OyUSVNSqnFIZPuyGSXWjhK035URzf5n1pvMjbhACuwwfxQxv7WSa4mvOo8J1z0xYexMVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5143
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="5DuhrAP2DQUUD2p0HUkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616587947;
 bh=5ie/zMVHFP3B2PyIy5PnwB4GwucbDABiot6hnqJAlbQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZT71SZSKsAHCBKCkuzxvo8s5D/FCQsLAv78ixN0Bdci84Rfxa46ggvoTZ7+lrP4X8J9
 lWRWs3TZemzgm3DBO0XnkHXYaNmJB42EbQcxaf3tfMQdfuRXqFKO4PNVFQ8RGMc02wZds
 GZUDEAvd8A/94dLyoSzKJI2rJPSSM0EPN0g=

--5DuhrAP2DQUUD2p0HUkS
Content-Type: text/plain; charset="UTF-8"

Hi,

I found that the TFTP transfer of the kernel was terminated in all
failure cases.
So this is at least not a kernel failure.

For example, https://lava.ciplatform.org/scheduler/job/191862
 TFTP from server 192.168.11.5; our IP address is 192.168.11.9
 Filename '192436/tftp-deploy-4hdvrfd6/kernel/Image'.
 Load address: 0x80000
 Loading: *#################################################################
 ...<snip>...
 ##################################T T
 TFTP server died; starting again

I will continue to investigate the TFTP issue.

Best regards,
Hiraku Toyooka

On Wed, Mar 24, 2021 at 12:22 PM Hiraku Toyooka
<hiraku.toyooka@cybertrust.co.jp> wrote:
>
> Hello Pavel-san,
>
> I'm sorry to give you trouble.
> It looks "Infrastructure error" and happens intermittently even in 5.10.
> I will investigate the cause.
>
> Failure case: https://lava.ciplatform.org/scheduler/job/191862
> Success case(Resubimit): https://lava.ciplatform.org/scheduler/job/192183
>
> For a while, if the same error occurs again, is it possible to
> resubmit of the LAVA Job manually (or ignore errors)?
>
> Best regards,
> Hiraku Toyooka
>
> On Wed, Mar 24, 2021 at 7:55 AM Pavel Machek <pavel@denx.de> wrote:
> >
> > Hi!
> >
> > I'm preparing new 4.19-rt release, and I see tests failing on zynqmp.
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/275281028
> >
> > But they fail on old release, too, and IIRC 4.19 simply does not
> > support zynqmp.
> >
> > So I believe this is not a kernel failure. If I'm wrong, let me know.
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
> 
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--5DuhrAP2DQUUD2p0HUkS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6325): https://lists.cip-project.org/g/cip-dev/message=
/6325
Mute This Topic: https://lists.cip-project.org/mt/81564242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5DuhrAP2DQUUD2p0HUkS--
