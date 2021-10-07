Return-Path: <SRS0=xed0=O3=lists.cip-project.org=bounce+64572+6803+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C26C433F5
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 07:52:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CFB6112D
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 07:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9CFB6112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2eQlYY4521723xKwZCoMlWyg; Thu, 07 Oct 2021 00:52:47 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web10.8557.1633593165505762893
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Oct 2021 00:52:46 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id HQvE04962A;
	Thu,  7 Oct 2021 16:47:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K21tRbvxP1WtR9W2nGJvpM1WL5G1CzAGvnRtqiJyDtsPGKcQN0MJAP3biWWGYs3ZdnyW90jHn2wLkoyDjIwROKokazXgh5DP34vj9KYgAe5ZRoztqkWsBTZH9NPUdSCXE6qXXEF3VLu6/KnK1TOnhyYnYcqVvgWrIggRze0JmAlYTlc/eYYFOt1Oqd7pTemny/k4bvVkj4H5HQ+RxOcNhIhQZVXUZRh9yULJyszybkN6YnBmb1GJHzunK3pF8sUW2Jba2GXcW/nA9PlG6vG/lSXwl/cKir1IZM9bevACitgpVXTPmueSz6sjLMfZrQZ1lFMhJFA3eL0nJ2wobFVpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxhLt2Y+dE1iY8KAtW4qyhyrtf2Ns7uxet3OAtfbfEs=;
 b=BESa1NGpWGarybehQC7Ea/5f9kG5vc1SMWSGw+M6ERB3/PEpLrO7GisCZIRYxirX1xPRBkAKyOJIbsTmDcOuipAirPNxJ8zTTzdY9tfdWCW3oNq1CUXtJLWjaHBUe6IfXWw8Ko27hy+tN7JWLjapgILdlODVJxryNQ8l82gZNtKOoSY0b+qEvAnxopdOsH/k6nmXttXAJe/o2UTZTG74hC3L2roL7c9I80k8R+qYOo5cZhP9XHoNnruhDtvlH2qZjycI8T/v2L/I2mvE1DEVTEWNq3OyqE8Y0kqjnpzWXhAw4wygFgApERzLdjVUy3pC0BSODMB4k8hjC4Zw0g5NeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSBPR01MB5143.jpnprd01.prod.outlook.com (2603:1096:604:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 07:47:02 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::15a0:f73c:381b:ddb2]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::15a0:f73c:381b:ddb2%5]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 07:47:02 +0000
X-Gm-Message-State: SjjaAtdSfIos9LLpyP6zfYd5x4520388AA=
X-Google-Smtp-Source: ABdhPJyjhFTkhMHLa0dauezjYWc4RLzjQGWe1UNn8ZztioUUBTFTY14fRFhM/LzobFthNOW6AHVSPs7N6WwDL+2MjjE=
X-Received: by 2002:a05:6000:1112:: with SMTP id z18mr3273060wrw.349.1633592813122;
 Thu, 07 Oct 2021 00:46:53 -0700 (PDT)
References: <TYBPR01MB5502233ADF8F0D953396F0C2E1B19@TYBPR01MB5502.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5502233ADF8F0D953396F0C2E1B19@TYBPR01MB5502.jpnprd01.prod.outlook.com>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Thu,  7 Oct 2021 16:52:37 +0900
X-Gmail-Original-Message-ID: <CADPJy8Xaoe14O1CtKShe90qf839tX9w2DzQJkVR_4edoXbrVAA@mail.gmail.com>
Message-ID: <CADPJy8Xaoe14O1CtKShe90qf839tX9w2DzQJkVR_4edoXbrVAA@mail.gmail.com>
Subject: Re: [cip-dev] deby: No certificate for https://git.yoctoproject.org
To: cip-dev@lists.cip-project.org
X-ClientProxiedBy: AM0PR02CA0224.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::31) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-Received: from mail-wr1-f54.google.com (209.85.221.54) by AM0PR02CA0224.eurprd02.prod.outlook.com (2603:10a6:20b:28f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Thu, 7 Oct 2021 07:47:02 +0000
X-Received: by mail-wr1-f54.google.com with SMTP id o20so16148944wro.3        ; Thu, 07 Oct 2021 00:47:02 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78287d07-ce2e-4869-f1aa-08d98966a69b
X-MS-TrafficTypeDiagnostic: OSBPR01MB5143:
X-Microsoft-Antispam-PRVS: 
	<OSBPR01MB5143365364678213B12E3A25BDB19@OSBPR01MB5143.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info: 
	8xRdTql6Qoh98yCbWT5liKs9EzJEAj+Yag9XSt3Xv/HKrCL9Kz3V3sezWqwwpZXD/AkKL4U6zNNDH46vvjNCio3uQ+4BuSik0tIcS5AyoWvKX2Z/x6uLgWMs+c15hKkm7NE6EeXGTe4RhEgaQGCwZW8j5Vxl9QOSq4u+V0qvm6d2Wk06DWmoaLjXQuUBtgIBMkVa0PtYDNtjKQuYsWk1yv0oIwxgrnl+kmpB8D17tkVXlSLpiASRXMzrMRMa9iGKZ8oBfYVjnXhYB3XdIzYeHsxjJ6sTsJuSjUtIS9VuRx7jD1pGXjHRie1XjcgVzJlIZbTuWYNwB3Shq8/fXH7TMTYzN3lxbwfix3qOqz/GVCoS7dJBq8ZfzclymCB+IrEJvRg56evMUhK9kSdtpnP6nQnR3gSonZ7gGG/b+BV4jmvfSC0tzXt+apD7g5XeITR6gffNixEBMegIqbWR+HRu7bCuek+OHwCCOTkskA07Bm5+LRxVpIFZMUjXEHbChG4MUvZQ0Nr0byJVZL7Cs4SwuYcwDy+rRGIAeB5dq8IRCArQCfXh4Fz7jLDbWf0C1AUvMDma2KnXzrPwhZy06MpRsDt3gsJuFmiKqYwNNXRDst6Qn2SlYNHFYLIlh7a6RAigoTtv8lfrClhSt/X32ahEu9bRf46let/wO7VMRPeKJbeGTBmOmxtKoBSI1Vfmb/rbYYAbK/vdOyc4vrUi2usP9ro/WrtzF24W3UUDbgzO8lnsAbACmfYjRyTs52cegwZiyzMLnH/Qc4veWbzFr0EftXh9/aEpWutDkl1vbxQu5AA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3k1OEFkcHJkTnFFMjFBOEdnekRUaHVETS8yU1c3MGY0R3hVVGJvZlE3SnVB?=
 =?utf-8?B?QzVRTzcxdzBkOWY3U2d4dXY0Q2lWVXhCTGh6VXRtWTd0UkRVaHY0SUovRy9v?=
 =?utf-8?B?QTNzQ0NXZkpCK1pBL29ZV2dqU1ViTFBNb1lPQ2NiV3FUY3NrUnQySUxlOGs4?=
 =?utf-8?B?YzhsZXVXUElDZnRzSSs0bVZsOFB4TklDUWJjWUFZTG1adC8yaTM2QkV6ZjQz?=
 =?utf-8?B?d1p1VkU3Z0cwYUJPOUU1bnFwSWR5K2g1M2dOb0VvVkt3Z0dETFUrNG5Xc2Jm?=
 =?utf-8?B?SldwMFpEb2xhUnBPT1R6TE9IbFo1UWtyRG9vWkcrTlZZN09saEZqbmgwZzVY?=
 =?utf-8?B?c3ZyeVlidVdUbDB6WW1iMGlEZThQdDJQV0QxeVVIaUV3Y1NTRGRmdzBMUVBi?=
 =?utf-8?B?Qkg5TTB0eVpaRytwSk02ZS9PQjNhZ1E4NE41Wm9tcmhSU2g4YTk4c3hJeGxh?=
 =?utf-8?B?Uzd1ci9nT0xZc0ZHK2JVejFUV3ZOZS9MNVNyVlZJKy9KWmVvWU5UQm1rcDVN?=
 =?utf-8?B?Rzlyc2Fwa01LU3huY3JKV1ZzY3RCYkJPTnEycjNPczBvcndLWTl2UkNoSG5I?=
 =?utf-8?B?YzVEZ0hjdVF0SWtrTXp3TGthRVVKTE9yL1hWUC9WVjNEQ0t4SWpEb01rQmpG?=
 =?utf-8?B?SzhLYUY1eWF5bXk0aEFyZG1oRno3TE9kVU5YSTNGL0JPYlFIbFBuRFhHUU45?=
 =?utf-8?B?eEsydnJLR2ZsRFZzSTVFc0lvU3FNM2lnMzBzbzIvN2lPNlNmZHRKSnZkaytP?=
 =?utf-8?B?Wm9NSE1HeWVMbE9Nc0tvamUzbDZ6R25rM0hTL0RzajRYV290SGxlbzZsTmJR?=
 =?utf-8?B?R3lkRTZhdjYveVEwY2xGc21HRFp0cFM2TWpoNXRuNmRCQlRsc2dlaWdDTmZr?=
 =?utf-8?B?T3M4cGdDZk5vYmRtcldwQ0p3YkZOUVJ1ZWhSVHB6aTVDanVHVnlMaUNhbVBm?=
 =?utf-8?B?UVFHQkNRMFNqWCtMY3F6M29QdlBuWWJ0WFZkc21NUFRDSzRQNTAyWi9vQmtj?=
 =?utf-8?B?eVhFd1FKOUVXR1FOM0Y4WWxLSWhuMXM1d3JWL3NlcWUrdS9oU0tHZG5nUDVP?=
 =?utf-8?B?MFVaMjBnQi9oRTV0Ny9FQ2hERGpjZ043bXJuS0lXZFNUZnFiT0t4bEhmdXJW?=
 =?utf-8?B?TFJmWFFDdEhRVzdEREVQZERPWHp3bDY4VjNwZzh4ZVd3RU5sMjNEME5CRUdV?=
 =?utf-8?B?aWtzV3VUR21aN0JvSDl6a283OG92NFdCRGtPakoxT2EwVEtQdm0vTWxmRnow?=
 =?utf-8?B?eXVsSjRLbTFpTnozaVVLT0tXZFhGaTB6cVJhOER3TVF1a1ROdW81OEZETmt2?=
 =?utf-8?B?Mkt4Q0Q0QjdUUVVMTUZ0bmJYNmNzcHpwQ3pSYVVJa0M2ZnR5RHZKeGJpTzg1?=
 =?utf-8?B?QlN5bUJvbG85c1A1U0RQSGR3dnB3dE00RUhraUtKY0tKaTVaRElPTFFXWDNi?=
 =?utf-8?B?T0NuQis1Sm5UeVpvS2d5U1lqMmVQSUxLendlZlFjVU5JeUI0UDlYM3BTRUZG?=
 =?utf-8?B?Q3dWb2RuWDlxV0l5RmkwVzhHMXhUMnJLMEJnakg2Ym5GQ29CcGJlTCtRby90?=
 =?utf-8?B?cmV2SStnYTVKM1Q0bTZrRVNqL0YwelU4cHNKUVQ2OUlhdTkwWEc1OVZWdWpW?=
 =?utf-8?B?UFBkRFFsRWdPeUpCa3NJM3A5MFNVNGc1UWJhVVBXUkIvSXp2WFRJVGVaYkJ0?=
 =?utf-8?B?RC8wR0xUWVdySElaZmg4VVBOVDA1cW8xa1lJSWI1RzBmeDQxbXo1MHR4YXhm?=
 =?utf-8?Q?OL177AVjQo88X2rPHfPdsV/sQX6xH+XhhQB0a8b?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78287d07-ce2e-4869-f1aa-08d98966a69b
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 07:47:02.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VutUZHjLe4e5gU7UEzg8XWemCUa+QsFhqz9Os5wfBkEmHGVjvzmJcRnZutTNAwCm9vHuC3wv3oQkFcTza25k9FAc89E4nIBHSJ+inWOnnbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5143
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="NEvvdFsdcjY4xw6FhaS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633593167;
 bh=AQ19jlNR9nqIbPd48fr/8o/AiZF62YLmb3CfsLiyUvI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QdTYgQGUCpHIrQysv7VwAa6fePEXs/I0aqemfBNBeZ1tt3kbEdMfcWLoTg+TGD+H8Hr
 AtbtUCFf1e0EjF0Ykkxn0jzpjglKOCC7rmIcxQajLlKJu1hta7H1KtaFmBHCQ3XuqE8tw
 zdvmDotgp2kGe1b+yonlyax6+9q18+Eli+8=
Message-ID: <20211007075237.Zq-eYzvmNHetv6NPAnCKoRxjwALUhhRGp1N1nf5U5dA@z>

--NEvvdFsdcjY4xw6FhaS4
Content-Type: text/plain; charset="UTF-8"

Hi Kazu,

This seems to be related to recent Let's Encrypt changes.
Please see my comments on the issue.

https://gitlab.com/cip-project/cip-core/deby/-/issues/15

Best regards,
Hiraku Toyooka

On Thu, Oct 7, 2021 at 2:08 PM Kazuhiro Hayashi
<kazuhiro3.hayashi@toshiba.co.jp> wrote:
>
> Hi,
>
> In deby CI, cloning repositories from https://git.yoctoproject.org is now failing (for a development branch):
> https://gitlab.com/cip-project/cip-core/deby/-/issues/15
>
> It was working on Apr 13, 2021.
> https://gitlab.com/cip-project/cip-core/deby/-/jobs/1172425075
>
> Do Anyone know if there are any changes in certficates in the containers?
>
> Best regards,
> Kazu
>
>
> 
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--NEvvdFsdcjY4xw6FhaS4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6803): https://lists.cip-project.org/g/cip-dev/message/=
6803
Mute This Topic: https://lists.cip-project.org/mt/86138478/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NEvvdFsdcjY4xw6FhaS4--
