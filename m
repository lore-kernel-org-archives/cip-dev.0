Return-Path: <SRS0=+ayr=LT=lists.cip-project.org=bounce+64572+6584+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B2C2B9F4
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 15:26:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289DB6193D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289DB6193D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6584+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G7taYY4521723xNhSCWUEtec; Fri, 25 Jun 2021 08:26:32 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web12.9270.1624634790508251438
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Jun 2021 08:26:31 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id aAVX16598B;
	Sat, 26 Jun 2021 00:21:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpUCGAfZn7NI9GqB76y3SmofR75ysMzc1AEM76A7DsAXbHe1abhS7hlMJ1Lu8PGV1l1FZLZIaC9dzEOkHec0SuELJYE83Uh2GnM5D2+iRGzlY7cz7F2I227VLOJeaAD6UA88tyBxODZRu58/JN5+PzmkBVI0VmQwb8hdKU7k4XylGBN8kHrRInS+SmK7mHHJCEN616qntTzLq/iF3Gsxgo/HVKuJBssifVW0E8Gj6BodgPYTt1MBCnKJ2Dn9p0OlJLBlR4autp1oudzQ34vD6OAG6WRItzcoJ6AZsCLs8XL8aOMOrygL4m1iXgbKyq9kNADs1I6vN5wkJOvGY4KMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj84LQet0jhtXKiOhJJG/jN7+Vjv5gDyMixplM7UP3U=;
 b=Wo26Imvj+/zouCeF7kRsEUPjlVyUwAYlPjWGqgmXPYOlvA2Y20bxWc6iMpxPFuppwEuamkFRNcz/sRuqDqy9XiknMSW5Yf1CooWN0krfG/8e62Lh7AQE3nqL8akGuu30mlij/0M00Qw50AlgecKUVPH252C0AnnHlFX48SIKsEuEzTqsaPB7XLuofoIYP6njyLR/TurwvYhvf5wgr2rCd6i62h3rQkAM4aT3y6Vcmoa1b6+CVTrLZtxAJFRYkyQozcbRHSrZnD/A46yKCI/lruQC/Yy2WoXkjF7YSVQHq6DzhrQSdP+iooPPjXGFqjlaLAkBHJXORzkH4L4QSB2JcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com (2603:1096:604:84::16)
 by OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 15:21:21 +0000
X-Received: from OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::51f5:d598:855d:a1cc]) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 ([fe80::51f5:d598:855d:a1cc%6]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 15:21:21 +0000
X-Gm-Message-State: NNf1G8wiLv5E7lzZ8LT31h3Cx4520388AA=
X-Google-Smtp-Source: ABdhPJxNbPy+TWTakAgTXfs5GnQAU1dT7kaTq7UdTgZs3FatL5KKbZHdHBeLBNDREspv4EXRXh7tC+nwXj5T8RtxjQY=
X-Received: by 2002:a5d:6710:: with SMTP id o16mr11794650wru.205.1624634473132;
 Fri, 25 Jun 2021 08:21:13 -0700 (PDT)
References: <CADPJy8XpMaqq+PsX=LmZJzmsu0o3Rus=_Tho6F684M_LbtMbjg@mail.gmail.com>
 <OSZPR01MB687770E7EDF300D434CF1259B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB687770E7EDF300D434CF1259B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>
Date: Sat, 26 Jun 2021 00:26:26 +0900
X-Gmail-Original-Message-ID: <CADPJy8U5_ymOv7r8Umcr_c6CaDLJBjz0Q7Zx8OKF_qZ5U+VY1Q@mail.gmail.com>
Message-ID: <CADPJy8U5_ymOv7r8Umcr_c6CaDLJBjz0Q7Zx8OKF_qZ5U+VY1Q@mail.gmail.com>
Subject: Re: [cip-dev] lab-cip-cybertrust will be temporarily offline
To: cip-dev@lists.cip-project.org
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, "hws@denx.de" <hws@denx.de>, 
	"Smita_Gumansingh@mentor.com" <Smita_Gumansingh@mentor.com>, "pavel@denx.de" <pavel@denx.de>
X-Originating-IP: [209.85.221.49]
X-ClientProxiedBy: AM0PR04CA0141.eurprd04.prod.outlook.com
 (2603:10a6:208:55::46) To OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from mail-wr1-f49.google.com (209.85.221.49) by AM0PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:208:55::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 15:21:21 +0000
X-Received: by mail-wr1-f49.google.com with SMTP id u11so10980221wrw.11        ; Fri, 25 Jun 2021 08:21:21 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6e29263-cae2-4a21-84bf-08d937ece330
X-MS-TrafficTypeDiagnostic: OSBPR01MB4967:
X-Microsoft-Antispam-PRVS: 
	<OSBPR01MB49673CC1E7A483AC5E046076BD069@OSBPR01MB4967.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	q04657W9MOMZgUK6g18vj+i43I2S4lB0oiDKtAUnnRpfmOZeWgrI4vERHsw6rrfvMkJfx3fGyGNmg3CP15/bSXWmeTitFhfbbrZwvCva87hnkUAGqHmS4e40GydI0/5Xk/CjIpePAcrEZ9ZwcGbFzlY2/vUBcB68PspZG7kzQldzp82eKRCKkiI499QHoeSh5PmBDxKaV+qKdy7SanmrKrpJdrM2K6LfLcCU2blUCFCPh6BwcMUiStJzCitQurmxQo2hkPAfVOytNzLmIsxgfY3yvRXd/uykwszvn5i+76CC9iVYxdxbM8lfDx1RyhZQgK0BRQE15uey7txL8FlwPzQBXfJsT+XyZqKbUJXiwvq8XV6tYIlwMw+h0zN62yIaY4SIMNb4sJuNEkOyQVspxcJF6AyahHrkF0ZmyAi4j+ChZj+Qfs4BPXyn2E8/tbfvEXllBZts+BqVVmUEJEedSXKy12Uauf6fbWdNuM0siizz2Vznh3DeaXzQQ1a0RwOX2dGZgaUESZl1XC0Pf7TvDyxvYoVd5o41kN8x6KuRh4p+grKK5R1mgR6eaqC2Kmpdkp4Ro6SwuStXw/rk6GFhshDhz1qjoeNgu/MujvVhnknHckK/6CYB9CyPw6qc7IW9e9fNh31YRWaicShwc/khXl13CtQgwfw0zFuoGiTtCwIoMbREvOfiLqISfooJDTXR2NwkxV4aFKFj2tlTXJquDgoVxwT+4ZdfZ+ieIigxFEUDd1fbuY9WaCtHwB6Z471ogt61JQP7ki9FgC4STdN/1avCsmsG9Ouqg/oHo7eFM0kJObhaG7VykKGM5fTIs9bn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkMvTmJpYlBhTy9xQmVVb1RiYmROYzVQbGRJcHdkSGVNektzS2JTMSs2dkw3?=
 =?utf-8?B?Y0ViSVpseUdPTVlSUTNtcjdOTWpocENvT1FWY1NqWVg0emRtSmpYK1hCbUJz?=
 =?utf-8?B?U2ZURlloTnh5MFNtMm9GRlhJcnIrRUwyMHFMVytPRE1BNWhaZmhUaE1NNnd3?=
 =?utf-8?B?MnVVSmRGWGg2dlh0NXQ3dWFzcGFHcENoSEE5TEtaZWs1VEY3TWdVNWw2NGU1?=
 =?utf-8?B?eWdPMnlhbXMralRxSmFCZnBBTUhzWFp6bnZ6cytiTlA5QnhzMzI1eEk2N2Ft?=
 =?utf-8?B?LzlscTZNWTVjMWxzbnlZWm9vZmp3TFdSWGhZaWs5VHdneGFLUG0vTEVjT0Jp?=
 =?utf-8?B?M1l6UTBRbUFNOE0xazgrbUNwZ1g1blROMTlyK3duZnFkSWZVN21GQkRVRUdV?=
 =?utf-8?B?bEZJenNEeDNqbVJHYS9QU3dEMDFtWFhvSWlydzdMYVArN1orMWtITlZxRnZH?=
 =?utf-8?B?N0JXeS9RSmdaaUludFNOckp5QWZsSUdaTGpERkdUVThPNTY4OTk2eU1sb3lv?=
 =?utf-8?B?NmFIVmlYN2NtaTAzVFdJbmg3eFlMSnRQd0xuTjNoVUR3OW5Jenh1RW92MTBE?=
 =?utf-8?B?THVQZngwZkttZHk5V1NFTGZnNXNBVHh4UGxyY3BDQjZaZzVraFNnTXdRQ0Ey?=
 =?utf-8?B?TEhjNk1TbGFCNlZCZ3N3ak5jM2wvNlVaNTF0ZCtNV1JaUGJoSnh3emF2NTBI?=
 =?utf-8?B?dlB0aytoUjNUS0lMK0pqc3YzWC9GK2g2dFpuYk0vMUZkWHRiRkVXeE40bFV4?=
 =?utf-8?B?bE9YbTY1ZkVFWU5nOGR6LzROVXM3OXVCY3NiMXUxNkN4SndoMURjbUV0TXZG?=
 =?utf-8?B?bGRvWW9WTHFpeUFYMEluMFdsbUNyakJZdTFDYzJ4QnliM0xKdncvK1ZNdWxl?=
 =?utf-8?B?LzVEVTJNZWVQTitQcEJHWFc4b0NKUm1LaE9EeDQrTTkxSkNxaTZwdklJZDFQ?=
 =?utf-8?B?NmtvaGU1QTZMWnhwOUpPT0R6MndDZkIzamc1cmFKR3ZnbmE2VlhzOWVxTGJC?=
 =?utf-8?B?K1RwRUcyZTUrM3VMRk9NeHpyUU1ZaFVJTzExVXRRazBtMDRWWm9ISnBwMzRm?=
 =?utf-8?B?bXNvQ3g3cW1zSGxPZ3NTaklVbVNIdGxBSXYwU2dDWEV1QVBLV2xFNkx1TzF5?=
 =?utf-8?B?NnQ4YkNNcmYydXp6MTAxWUthNzlLTWV6SUlzWll2TDZYTERtajgzUldwb3cx?=
 =?utf-8?B?cmI4QUQ4bkcvSnhEb2lISkxvUzJYT0xvNVN5K3VLWjlpR2FaV3J0VHZDckhS?=
 =?utf-8?B?cmRGdG9PSDNnZGgyMVF4aG1mR1JhOWZkYU1COG5XVyt0V3JBdmg4cU1sOXFM?=
 =?utf-8?B?dWFPZ2dNNVJVUk5WVWpQd1oySnI1ZmFKRmwyeEpwMXU4M2FGZU9OVzhMdmox?=
 =?utf-8?B?VExaN1RWOEdkUnNtb1J5Z0hyM0xpK08wKzY0SnY0Z3dmbnZkWTlyTEFJRjh6?=
 =?utf-8?B?VkhUVHdhdVdSTGFyM21rcW9IWm5hSWJFK2JzSER3SUF2ZmRsa1VnN0d2cHpj?=
 =?utf-8?B?T1BYNElwbEpLTStlL1A3YWJyUzd6Wk9wOXVpSkFGSG1zREt6S2ZLYjR3dTZM?=
 =?utf-8?B?dlpwckVUNE1DMUJDMWc0TWxEOENuZjRiMkVBZ28wM09pZGdOV3oxL2FlUEx5?=
 =?utf-8?B?R3JEQlRHMFpPQWJtMmd5WW80QXNobE5Eem5oKy9jOUJNaWhZdFBZenVxbkJW?=
 =?utf-8?B?R1ppQURKeFZHbEcraS84Z0VNN2IrSG93eTRtWHNheHFQNnoyWDVJaGJmRi9l?=
 =?utf-8?Q?2i2S4pTPhqVL7auNmG2TEc5idIPoSHDub+e2O+K?=
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e29263-cae2-4a21-84bf-08d937ece330
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5333.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:21:21.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE8Jg991ZWLCkcn9NInXVeOv1hT3qdYepzTyjGU194Aa1JrkYM41rZg+YwAhH+ylx46yS0jxumQt4DOBEOuxSkdRNfb8CQO1r4KWyBMQZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4967
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="IKofvsG8AxKmuRmRDPzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624634792;
 bh=2JgubupTLq5sfPIT8MSPxPingccd9t28Wuqk1GP5jJY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=stWiFIIUmB4J7fl3AcvowfXOmJJ6kT7nwcSofrNfZTPq4Yigya/fPbMUVvun+QllRKH
 vkgVN8x3fxLxTWqeO9IlSdR3upsdR9pkise1WO2mvNGDkIHqsz7z/Vfur7H0dYr0N949J
 eDLrh50Q67XQHZq880eL8VOW//5JeAM5BLk=

--IKofvsG8AxKmuRmRDPzX
Content-Type: text/plain; charset="UTF-8"

Hi!

I finally finished physical location change of the lab and zcu102-01 is
online now.

Thank you very much for getting the testing done before going offline.
And I'm sorry for the delay in the restart.

Next, I will online zcu102-02 and bbb-03 tomorrow.

Best regards,
Hiraku Toyooka

On Mon, Jun 21, 2021 at 4:09 PM Chris Paterson
<chris.paterson2@renesas.com> wrote:
>
> Hello Toyooka-san,
>
> > From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
> > Sent: 21 June 2021 07:43
> >
> > Hi.
> >
> > The lab-cip-cybertrust will be temporarily offline on June 25th due to physical
> > location change. I'm sorry for the inconvenience.
>
> Thank you for the heads-up.
>
> @nobuhiro1.iwamatsu@toshiba.co.jp, will this cause any issues for the next v4.19-cip release (Friday)?
> Can we get the testing done early?
>
> Kind regards, Chris
>
> >
> > The schedule is as follows:
> >
> > June 24th (Thu.) 10:00- (UTC)
> > - zcu102-02 and bbb-03 will be changed to offline.
> > - zcu102-01 will be still online.
> >
> > June 25th (Fri.) 01:00- (UTC)
> > - zcu102-01 will be changed to offline.
> > - lab-cip-cybertrust will be changed to offline.
> >
> > June 25th (Fri.) -10:00 (UTC)
> > - lab-cip-cybertrust will be changed to online.
> > - zcu102-01 will be changed to online first.
> > - zcu102-02 and bbb-03 will be changed to online following zcu102-01
> > (within a day).
> >
> > Best regards,
> > --
> > Hiraku Toyooka
> > Cybertrust Japan Co., Ltd.
>
> 
>


-- 
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--IKofvsG8AxKmuRmRDPzX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6584): https://lists.cip-project.org/g/cip-dev/message=
/6584
Mute This Topic: https://lists.cip-project.org/mt/83683050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IKofvsG8AxKmuRmRDPzX--
