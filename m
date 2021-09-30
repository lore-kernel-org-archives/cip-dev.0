Return-Path: <SRS0=Cx9M=OU=lists.cip-project.org=bounce+64572+6766+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51038C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 16:13:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B57613A9
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 16:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95B57613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sN9SYY4521723xpGbzKH2loc; Thu, 30 Sep 2021 09:13:27 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web08.14767.1633018405575401858
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 09:13:26 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id BBIT30580A;
	Fri,  1 Oct 2021 01:08:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG1RSq97HT+p689cXnmmpOajzbikz46wVR6nw5WLRFqYLQaG41dtbhsRngsvh4SW3nK9Oft7G1shvZUbK2tVx2LrgH/Z2ljdieudzxMkSNrZHjVBMpOdxpEWCKGTe7gBhtOUrJVluROvVdtj8asxFoD5OzMiNgb3wZ0SxlU+G78DiPoBV1B9QVYyVDSJzjx7Ab3BI81rQay4iaLSkPR59WF3WehvoxBYlsH9qTH7zq7lBLXfnKXb5ndqJsPyX7Dln1gSyxJcA810l4g4Kx/K/8QnFgXUbzoSS5Su2XTkwWFub4NK1F+K/H5PmStYPzOXBx7M+GQvKYYja8apEeTFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Acn2UeBcR7QycZqOyhsc6Dc6AWYGG0Yeqxe98OEJiq4=;
 b=JgN9OwhHmD1EPvd9q3AsGuErwjQ5hVD843Ni0RO1RLVQbYVzgNEyoGzf6Inj2X15nedPix88LdYoAeP5XKIAvEjrVIvnXXP7Yh7IB10OUlyzPbSgNBbQFL8ZDqu9YD9VUlS+wN+2p9yNnmo1rBYlJfz/qZC8q098Sz+MZwcR0vkM02LHnvzGmaN1/5TQZUMMJi8ydKtw7XpKO33KMyvULEQfH9ZREOwGGS/fNZZ6lZUmFu7Iw84nKTw5h6yxEb0hF6XClrYUc8TT7a68O04ptqdNdAeBx4MnZKS4gUD6tNC+DpflE0nhTER+dQGzu9CDzE5XRaQ7mdha/ef+cigVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSBPR01MB3973.jpnprd01.prod.outlook.com (2603:1096:604:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.19; Thu, 30 Sep
 2021 16:08:05 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::d5dd:d52f:613d:22fb]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::d5dd:d52f:613d:22fb%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 16:08:05 +0000
X-Gm-Message-State: sE2oIRKeVKNgUOFXBI034enXx4520388AA=
X-Google-Smtp-Source: ABdhPJxF8SW70AdMV+efYUUYzhAA0iZU3xOMviB3ZdEp7c3KL/8uDuqA4IZvFXq2evd54cL+uX/WvDTUGJoZ2waJZXM=
X-Received: by 2002:a7b:c001:: with SMTP id c1mr39104wmb.182.1633018076768;
 Thu, 30 Sep 2021 09:07:56 -0700 (PDT)
References: <20210929185624.GA12171@duo.ucw.cz>
In-Reply-To: <20210929185624.GA12171@duo.ucw.cz>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Fri,  1 Oct 2021 01:13:21 +0900
X-Gmail-Original-Message-ID: <CADPJy8XVnAVAcfgxYQtEvCkAC3jN4Pt_PmQ2xUSxN8Z1CjrU=w@mail.gmail.com>
Message-ID: <CADPJy8XVnAVAcfgxYQtEvCkAC3jN4Pt_PmQ2xUSxN8Z1CjrU=w@mail.gmail.com>
Subject: Re: [cip-dev] Quality of wireless drivers (rtl8821ae, ath10k, wl18xx)
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, yasin.demirci@siemens.com
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-Received: from mail-wm1-f51.google.com (209.85.128.51) by AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 16:08:05 +0000
X-Received: by mail-wm1-f51.google.com with SMTP id f78-20020a1c1f51000000b0030cdb3d6079so4724474wmf.3        ; Thu, 30 Sep 2021 09:08:05 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0e391b-9162-4de5-041f-08d9842c7ca3
X-MS-TrafficTypeDiagnostic: OSBPR01MB3973:
X-Microsoft-Antispam-PRVS: 
	<OSBPR01MB3973AC3A6B4DDCDEA87F38A9BDAA9@OSBPR01MB3973.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info: 
	itmO4vm5LkazS3TCTqmjnI1rLO9Mz84cBamARf7P0y8FAVc+6BiL8fmBFyTVUoniDht+ccLJMFsmarMLkTjXiB163E8/v4X0h3yDre3x6L6pr2cPvYJn4twD7MICaj1l2O0XuXE6wQLB7Xfjx3vfTeDjy6eVABGzPaTA8rBGeFuGTIt0B+p8hallciqgF8WaLG1NUcfvsKEOqh57F70EnkeKblEvkrCmGxPzogpTwrlG3keg6zLAfUhnKnkgP58dwprlqDRyaKmx8d9pms7+g+Z7Pw74B/G82xbCg8jq0l5mBQlNAR4TRwfOTjrJoJL+gKH5DPK238arzTxEdA8RRllJ9sqTVDJpX4uokZ0gw36bSfeP0o0QnLnBaYAuwL3SZxIHXjjlmM841V0emfwjtsEdIuyjd+gRluFtyu+rR7wKmcyRBPLGdqONPX5rPw2C5mbU1RivQsXVapa0Cwa+Izj4mKq+7aAVPFcnWIRHeqH/XOhp77i7PKBq5GK+0C7ScoX8/Oc8UEhTC/ESuso4+ITItFRuI9i/XWIiySnNMSWAwE+vCijXG3D2vKDZnCaQBVECBzP4avvt5EpNq5Buc+kckTJ2VN+p0f0669XTBoF7ZCKBfhhzHPh69LCpmyMlPBnA5NObfDJG4RlgwC0jxM3yvn1MoOtP9zzJRUUCGCRqzB7VdneLdjX1XzbVnwTpqx/KszMOfiLE7E7Wg9b+Sg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTdGMlo0UktRNURlcWNYT0Nyb0t5cEk1QmQ3aktnYjZzOFZqYUdYZ1JkN0Z4?=
 =?utf-8?B?RVcrYldXTjZFRDRaaDF5cG9USGZram5FRVZWNXY5WGFJZDE0TGpILzJRM0xW?=
 =?utf-8?B?MlZzMnh6bENmekgySm9LbFZ3d0d6NTBDZitPWTREMnRkamVFdG41VEFtVTdK?=
 =?utf-8?B?YTlrdStIUDYxUVlXY2NTaXdEQUN5TEFJLys4U0JuWnFlc2hRVndEblFRckJS?=
 =?utf-8?B?cnpCMk5lc205UFhXWnVsaS8rZFgrVjkyYUlhb3RYOGFlZUI0RmxkdVRZb2xE?=
 =?utf-8?B?QTUzWmdBTHZZMFMvUTE1aHB4WEhhdzF5blJjcjRQTGJnOXUyekEvTjkzcnRR?=
 =?utf-8?B?NllKZWU1SXpBWUhrLzR6TmpKTzZYc0VKTjU1MGo4N2JrTjJ0Mm1VMnRya3hR?=
 =?utf-8?B?K3J4SDF6ZTQ4Sm9oWmhaSUs3R0VRR0VZUytUdGsxYU96ckU3TU01ZkdRU1VX?=
 =?utf-8?B?UzNRMDJkVUFiNTVyRDJoVkEzSEwxTHRBVFVsUWxIQ3NPUzNCa09FNHM0c3d5?=
 =?utf-8?B?TVVQTTl5aVoreFhaMkFSMXUzMysvVWwzZGJNeHRMV2dTdmhSZG9uc0tZeFFS?=
 =?utf-8?B?Z1FpQ3lrNGlNTVFRTU03WVViL3BVdHVBcDlLaXdDSE9sS3h3T0Nua3hUWG5O?=
 =?utf-8?B?SUFRQVlCMEErQzNlREtaKzRVeGpGdkUyQTVrUjBYS2s4aFFJWHJMU0lTYjZK?=
 =?utf-8?B?RVorYUpXa1oyYmZWTXRkYm1PbGhlMVY5c25KMHYwMHFYQys1akFRZ2R5N3p3?=
 =?utf-8?B?QW1UWUZJR2lwWi80dE14aGN3bnRMWDJCbXo4TUtnODBYUitIaEw0M2VXZjZw?=
 =?utf-8?B?V2lQRmhPMzM3TEhDVTFnZ21RY05CdmEwcGV3M0dyQWlKWnJHTkgwZjVIUjQ5?=
 =?utf-8?B?RTB3VURZRzhZUXNaTmJZajBNVWZnUDh0K0FrY0t3eFgxTTZTRGhsQ3R6czFy?=
 =?utf-8?B?dFkrSDBhTDVhN3NkRExUOEtjWU5JM2djd0EyNGhQQzFjMEVvcVR3b2dJdGph?=
 =?utf-8?B?K1pRY2dhWVgwWVF4eWJsTUtvSUs1blZ1VUFraldnekw2UjB1M2xLNnI5MXNT?=
 =?utf-8?B?QTFlNVJqcGhaTndLM2ZiN0g5ay9wSlVFUlpyc3FoU3NpRVVqTFBmZGRINUpL?=
 =?utf-8?B?cW8yYjlndnlZN0N3K0VXMmZET1lGYU1GcG1DOTBuQjgzSUl3cHJSY3JMaTBN?=
 =?utf-8?B?L3VKNGcyR2E3eU1GbUNQZ0pjMGYzWDBwRk5BR2gyZnMzTE1oUjIzRzVyaTFp?=
 =?utf-8?B?MGdpTlcyRVkra3pWc0dwelBxOEx4UTduSU45NUFVVjFLVHl0YSt0RzBWSTRO?=
 =?utf-8?B?WW9heVcveHErdWxGbWlzTytaMDVkUlhvTHlGV1lGWTlCOUZFY2xHZ1FJUGJy?=
 =?utf-8?B?WU5HWGRaYnYzd29lbXdaM0ZBTWNJVFYwOWM2Ky91Rmx2SlRYSFN3WHlpb1FH?=
 =?utf-8?B?bkVKMDhTUi9zWVVFV2FRcW5VUnNjTUg5dHNVUjY5d3V1cnNnVDVkendDMVdo?=
 =?utf-8?B?NTltMkhmeGwzUkh1NVNPR1ZLZTNhZkV0REJiYnJhOUgvZXNyb09JamY3OXZK?=
 =?utf-8?B?RWFyNy9LRWt3TEtJeHVjaUpub0ZDRHUzekEwbHBQdlJQcjl1N2dPS0dreXlV?=
 =?utf-8?B?eTlRbkhneUpjaXYzYXhiMlJnTnN4WmlwVGszODdHZGU2YmtSYTZ1MkllYjFK?=
 =?utf-8?B?YUttWHhiSysyL3QyTjU3WEZzOGNxVHlFckRhOFlwOFdaMGFOcW1FaC9DaW1F?=
 =?utf-8?Q?2hZa1oTLK6Bg1xLXhvNXGhjNP5b7/4V40QRzwZX?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e391b-9162-4de5-041f-08d9842c7ca3
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 16:08:05.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boBkIlmNQfpD9fzGu4tZHISdCreqTcxT33pSWIf26C7k3RVdH474LeKtbQqdk/fO5Yq4iGzzzEUNRKdnzF7jnXEYdoa2qnbQYYmW8frBuvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3973
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="cgQJioom1VUXNRbTeMKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633018407;
 bh=2mxdAaXhObCSG+c62pqE8Whs7IkHurwPdOC9OpaINe0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rgurqhwbA4YcWQoU/7BzCDjXsBjwBMNToNhUYoTW13GJKpE86GCMvxzD02+VCvEh2zd
 Avk8J32aU1QjtoY3lpQOSeKuWLfOv+7IBQ7EyMhaTTA1QB++krfpXYP+ks7njU///GyJ5
 cvdBoixG0/N8rwo0SsQUJxVrjM4xMLaJuEY=
Message-ID: <20210930161321.1sHFVunTFQDJp0FiOfws32oHUJNEuZWR7tcjA4Y-oJU@z>

--cgQJioom1VUXNRbTeMKS
Content-Type: text/plain; charset="UTF-8"

Hi!

On Thu, Sep 30, 2021 at 3:56 AM Pavel Machek <pavel@denx.de> wrote:
> AFAICT we are reviewing changes to those drivers on -stable series
> (good). We are not testing the drivers in any meaningful way, and it
> may be good to mark them built-in (=y, not modular) in some configs so
> at least probing is tested. Proper testing would be quite hard, and
> ammount of changes to them in stable probably does not require it.

I think functional testing for wireless drivers in CI system is hard,
so building and
probing seem reasonable tests currently.

> * wl18xx
>
> (wl1837 hardware is handled by wl18xx driver.)
>
> CONFIG_WL18XX
> CONFIG_BT_HCIUART_LL
> ./drivers/net/wireless/ti/wl18xx
> ./drivers/bluetooth/hci_ll.c
>
> ./5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_WL18XX=m
> ./5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_WL18XX=y
> ./5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_WL18XX=m
>
> ./5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_BT_HCIUART_LL=y
> ./5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_BT_HCIUART_LL=y
>
> => We should be reviewing it. We do some minimal testing by compiling
> module in ZYNQMP configuration. No changes in 5.10-stable. Very few
> changes from 4.19, mostly treewide cleanups.

zynqmp-zcu102 which is connected to CIP LAVA doesn't have the wl18xx
device actually.
On the other hand, RZ/G2 boards (r8a774a1-hihope-rzg2m-ex,
r8a774b1-hihope-rzg2n-ex,
r8a774c0-ek874) have the device. So these boards look suitable if
probing is tested, although
wl18xx is currently not enabled in the corresponding config files.

Best regards,
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--cgQJioom1VUXNRbTeMKS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6766): https://lists.cip-project.org/g/cip-dev/message/=
6766
Mute This Topic: https://lists.cip-project.org/mt/85956701/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cgQJioom1VUXNRbTeMKS--
