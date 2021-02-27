Return-Path: <SRS0=NArd=H5=lists.cip-project.org=bounce+64572+6201+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F1CC433E6
	for <cip-dev@archiver.kernel.org>; Sat, 27 Feb 2021 09:27:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8397464EB3
	for <cip-dev@archiver.kernel.org>; Sat, 27 Feb 2021 09:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8397464EB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6201+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XgWiYY4521723xvIxCVukbfZ; Sat, 27 Feb 2021 01:27:43 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web09.2121.1614418060411935144
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Feb 2021 01:27:42 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id bSVh18820A;
	Sat, 27 Feb 2021 18:21:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFmcwLShbm1b5u+cl7bHJQGpi7WjF92qv0RXR3XVEZWh4mPkPeM8pvzKMId8/r+IOmD/C0RskbaPIP0pMMsDMdKh9eh1yjB/N+hPc2PXp36tVXo5oHMnUziFEC+HJn21C7ZASD9u8q71+FzHIezE8w7d+/nKAU412P5n+W/O4pd23o8pXuv9mQWsfNdvzlhGEVT/tmmgvpgyM2qR0QeDMu9JQxzw15JeGFy1SgtY9jEsMofpCP/AEeL8RT4zbjybwVR1jblSp1ApLjwlCwZj7/W9d6OCXH7KD/SlrRwcQPloy7A5mB82rNPtHpmEeyLZ30JTtspThv2l9MQyLgz8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1qT3h0g5UkAZ1yrn2hc5m2MfFhrWZek4EcChneWuUY=;
 b=Yt6LCuSxdlaw30XWd+mZch00fLkykrK0ZIFsSf1U0WvGKUG2UPvyBPxOdcPL+ZByXwgcszWV0zwUHI842Sc6A5WvxScDazWZe1LqJ69gsSN9QM+rCxzb9hvNYNouPeSMYYaFALBHJWHx738UXWc5CB6IGQVjLI9XOTjXikAkJ2qvrl7NkjSgSvu7wYbPzJ//ZpGmf2ddw1UVXrNrVAprn16+9xFtmkykuaqxzKoSSg07vPyW8UMjm9h9T6MuTC7TeZoJn8+E8ihgcsthIRmLclJCiny2sBwARpn5Kh6ybwIV/PdlN/miSYwFcE6f3dL+1QCi91iaz/Y/X/AiWXNZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB1935.jpnprd01.prod.outlook.com (2603:1096:404:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Sat, 27 Feb
 2021 09:21:27 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3868.032; Sat, 27 Feb 2021
 09:21:27 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <hidehiro.kawai.ez@hitachi.com>, <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>, <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: 
 AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtgANHIwrAABi+8sAwq1QNgADwkvVAAK3xikA==
Date: Sat, 27 Feb 2021 18:27:37 +0900
Message-ID: 
 <TY2PR01MB49724E20915CAAB860B9A471A09C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <16529B035A24E529.13568@lists.cip-project.org>
 <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
 <TY2PR01MB497225A38DD561DEFF392ACAA0DC0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB4972C67E512FDF94724B1B8DA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TYAPR01MB24298D6F0B079B2FD04EDFB5B59D9@TYAPR01MB2429.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB24298D6F0B079B2FD04EDFB5B59D9@TYAPR01MB2429.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47449684-111b-45ce-79a5-08d8db010fac
x-ms-traffictypediagnostic: TYAPR01MB1935:
x-ms-exchange-minimumurldomainage: symantec.com#10322
x-microsoft-antispam-prvs: 
 <TYAPR01MB1935B9C4791F48593433708FA09C9@TYAPR01MB1935.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Y3QscRDssmAypHpX0Eql9IjgzBnpNCu6/d3pxnI6tZLgBkvX41RdVZVy2BdLtDAGgM9BO0xE9o6ofbFe3aR90s9Gyb/bQGJHIFK3rT9kHJEu1ZRF6BLYfURoDrRN6fWY3YOC9JGsHiU92JIfCwAdiVF2bxBL7M1UN3K9rvO5DHrfBiYBLeWSljwNoauKPsTPUxeBYM6twlWNuuf2kF/iSTHQnZch9xKTK2BdKw3rWJMqL1FawznQSjp1k+FOBvkioXUVU9UuO4NpFVL4kddmgqM32r1STHh5MGt3Vai4kcpK3M7yIZUVPeD9OdkB9YgqzK3ZoBcnJdWtHw5NTKLfQnDzO4UiKfxJempjrSfSL0DUVtPyDxSuiBIn7rgBym6G4Vs9sByYQiX9ugTOg9gCl9VJDsUIjzzOeFTnDBSw34nqm/AR+F3U9h8u4pGsxwVRYo09UP8P7LWJJyRtlzYU7qZDxsBtzQ8aj065azammZ2M61TtzwzY8qJs9m6ObZFMw7pJdzJwxb4JC/joFDIxSoTKl+XpBd2bUmAXTNvDM3yNTymvYHm5fXaa+fx8TqCK9AYuSGjo6wuiCgiJPoJWXFJ5Wyb+ePW5IMEXAwNz48o=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?a0FjMUNkVUJxeXVVeUVPSHNTbHBURmxxL3JrSzNUcWZQTlIwNUNNTXFx?=
 =?iso-2022-jp?B?dXoyRUFMM3BkTk83SVBERVNldW0zNGtGdHNEVTJvM1JqWnRPZUVKaG1S?=
 =?iso-2022-jp?B?TG5DZk1qMHg3MjdIcndIV2tCMnRxN05uazEzWGxBbkJhazhaZGp3NHg2?=
 =?iso-2022-jp?B?b3lRbmRWamY1WDJsaGtEcWNrSnJNaDR0WEQ0N3BOR3JaWTBiTEVxbzI2?=
 =?iso-2022-jp?B?NXRaZG5JbnY5SEFnbHB2b2svVUNwdkNwR2lKS2p1U2wyWCtjb3ZKQjR1?=
 =?iso-2022-jp?B?WTJrYWp1Q3JDQ2tjdUhSSXR5bDhkK3piQ3ZmWWRGdTdmaG1QUWFZU3ZV?=
 =?iso-2022-jp?B?NVJld05lditKNW5yRXVZRmVQVDZ5RVRlS1NXVFVaVDZSMFEwZ004OCtJ?=
 =?iso-2022-jp?B?MTI0WFZ2RDFiUUFxeSsyNHRuaHFUQTJTeVBKOGNrOGFNMjFmQWhaNWpB?=
 =?iso-2022-jp?B?cFE1eDdId1phNFVnV3FTcnYrbGJ3a0pVcXJua0hSWHpWK3QxWmtBWlZi?=
 =?iso-2022-jp?B?aWhJRS81dmoybkFZRzR2aTY2Sm9YUnNtRVgweXc5WjBJblJGRFo5a3BX?=
 =?iso-2022-jp?B?UVB5TFRmWk8yeGZ3QzZmMlh0TEdYM2JNVGlQY1ZJeWVFOENwbTIyTERJ?=
 =?iso-2022-jp?B?QXNlNkhPbElvcFdtNTdxa1h0TnVYeUlrUEFXVG82SHJWTHBYUjlRUHRa?=
 =?iso-2022-jp?B?UUs2cFZWU2E4L1NLWk1Zc0tEQ3JkWmRaalBWNVlnMzJFY2ZTZE12dzFq?=
 =?iso-2022-jp?B?WDNFR1FsOGdpdXFZWlk1dlRlS0lnN281Q2o1ZXYycVBJU3Q0bHk1SnFw?=
 =?iso-2022-jp?B?ajJ4NFZFdDRZRGwxOFJFR2NrenY5NWlBWkllNTkwREFJUVh4c0lVSHdO?=
 =?iso-2022-jp?B?TWlzRFMxNHVNSll6dHEwcjNMQ3BYQUhkVjlYTm03R2NrNlFxd29vZzFZ?=
 =?iso-2022-jp?B?VUJXeVNqK0NMK09vdG9pVkMrdlYvc1FScXJnSHRVMGNDOWFLdlhRQkVK?=
 =?iso-2022-jp?B?bjhPajdhQVRVZStnUHZNeHhXb0ZzZ1dYd2lsakxLZE5WYjQvaklnNmtT?=
 =?iso-2022-jp?B?WFJQQmk4a2pIQ0xvZm9VS3VjRjlMWVlPQ3JJdDlXTlpYalhtbjhodE1D?=
 =?iso-2022-jp?B?TlVJd1p5a2pVdWdHb1hOOWlBSmZmbnBLUlNzM21iRm5aWEdmN1Fwc1hC?=
 =?iso-2022-jp?B?dHhQR3ROdWFEcGNJOGlUWk5SelVQN0t6TjkraVkwamhRQ1dEK1UvYllX?=
 =?iso-2022-jp?B?cHBjWHcrL0Z3SUxrbG51MmQ5QlpRT1RiL1JiWGZvbUJ6Z0VjODJqTy9V?=
 =?iso-2022-jp?B?ZVNUVnhXNmpJL1ZtNFg4eDVGcUJJS2dhYmltVVBpOUs2T1BPTVppUG01?=
 =?iso-2022-jp?B?QXhLQ1NUSHozTTZzRWt1cGVXREtMSDdTRko0L2RTZUlUd2xiWFhTMjVl?=
 =?iso-2022-jp?B?WFlqWng2SUx4N2c4cVZibFhSNEU4RlQybkNhL0pMNm9sNHRiN3ZZWk5k?=
 =?iso-2022-jp?B?cDRrNWl3d1hvQklkazg5b3Q2Z3VuSVRabGhZUzBJQThpNWV5NFNvVERa?=
 =?iso-2022-jp?B?TjJweHV2VW5XdDIxeE8vYnRvTGQwd0dvNndzWVBGNU9LcHZtKzF2TXh4?=
 =?iso-2022-jp?B?NlBtM0hYOXVaM1ZrMDBRaVFVbngrRmhYMU5jNzRjNURIWGZnc3o3NHla?=
 =?iso-2022-jp?B?a3ZEelBxVzlSeHZVMS8xdStaYk15bzZ4d2FjRU9wQlZpaWtySUNRUmNG?=
 =?iso-2022-jp?B?ME1IM1RHQURqbjR2YThGOUtlc05NSjRtNEVwZ2EzVmFwNUlFTUxIWE1l?=
 =?iso-2022-jp?B?M0IwWkFQb25MdlQ5cXNZdSs4eWM5c0Jhb1VTWFU4cEtkOUR5cnYxeGRV?=
 =?iso-2022-jp?B?eFRPbDlKSGpialdBRnJVVk5yekxwVWRVODUrS1JkNERsUmJwc053RmhO?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47449684-111b-45ce-79a5-08d8db010fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2021 09:21:27.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CtFyvjpz1rztPiu8qJU50UYov7Ua/AD89hAFubzfJhp8pmbE9ZoD4K1nlWs/LCN3RpZDHvsnAwTff8L54cHZb/mC9MsBApK4EPDse6JQig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1935
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pBqIlGo27vQ9GkonNjnkLDMOx4520388AA=
Content-Type: multipart/mixed; boundary="2WKhxKTEVGSWOn8krazn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614418063;
 bh=WXp1jgjjBlelBGKaFpM8SeOKNf4HB6ralTFQCg/c0ko=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KgAxwDBB/AE8VJfq5aw4e0hnhOGwY0/tIPRXkH2lXYz3okXB4i4gwIcik7mAjkDIR4L
 wOPXluXdQ2FMf11hr2GScjjX+gXBbkpedY+KuHCc7HDUXoL6p/l04Yx63aCWkZQmfO05G
 LQ1lK6puqL0yDg00ZOfqmD75jvsSnlRkY6U=

--2WKhxKTEVGSWOn8krazn
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Kawai-san,

Thanks for your response.
Then, for now, we will disable nouveau driver.
If we need to re-enable this, please feel free to let us know.

Best regards,
--
M. Kudo

> -----Original Message-----
> From: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.ez@=
hitachi.com>
> Sent: Friday, February 26, 2021 9:40 PM
> To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masa=
shi.kudo@cybertrust.co.jp>;
> wens@csie.org
> Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> Subject: RE: hitachi_omap defconfigs
>=20
> Kudo-san,
>=20
> I'm sorry about this.
>=20
> I think we can disable some DRM drivers, but I haven't received response=
 from
> related persons yet.
> So, please simply disable nouveau driver.
>=20
> Best regards,
>=20
> Hidehiro Kawai
> Hitachi, Ltd. Research & Development Group
>=20
> > From: masashi.kudo@cybertrust.co.jp <masashi.kudo@cybertrust.co.jp>
> >
> > Hi, Kawai-san,
> >
> > It's been a while since we last chatted about this issue.
> > If it takes more time, shall we disable nouveau driver as you suggeste=
d?
> >
> > Best regards,
> > --
> > M. Kudo
> >
> > > -----Original Message-----
> > > From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B
> > > Sent: Friday, December 25, 2020 6:28 PM
> > > To: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.e=
z@hitachi.com>;
> > > 'wens@csie.org' <wens@csie.org>
> > > Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> > > Subject: RE: hitachi_omap defconfigs
> > >
> > > Hi, Kawai-san,
> > >
> > > Thanks very much for letting us know the current status.
> > > We will wait for your response, so I would appreciate it if you can =
keep us
> updated.
> > >
> > > Best regards,
> > > --
> > > M. Kudo
> > >
> > > > -----Original Message-----
> > > > From: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kaw=
ai.ez@hitachi.com>
> > > > Sent: Friday, December 25, 2020 3:34 PM
> > > > To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B=
 <masashi.kudo@cybertrust.co.jp>;
> > > > 'wens@csie.org' <wens@csie.org>
> > > > Cc: cip-dev@lists.cip-project.org;
> > > > cip-members@lists.cip-project.org
> > > > Subject: RE: hitachi_omap defconfigs
> > > >
> > > > Kudo-san and ChenYu-san,
> > > >
> > > > We are sorry for the inconvenience.  The confirmation will take so=
me time.
> > > > If you'd like to solve this issue quickly, please disable nouveau =
driver now.
> > > > After the confirmation, we'll send an updated defconfig.
> > > >
> > > > Best regards,
> > > >
> > > > Hidehiro Kawai
> > > > Hitachi, Ltd. Research & Development Group
> > > >
> > > > > From: cip-members@lists.cip-project.org
> > > > > <cip-members@lists.cip-project.org> On Behalf Of Hidehiro Kawai
> > > > >
> > > > > Hello Kudo-san and ChenYu-san,
> > > > >
> > > > > Thanks for reporting the issue.
> > > > > Including nouveau driver, it seems that our defconfigs have some
> > > > > unneeded drivers.  I'm confirming this with our development
> > > > > team, please wait
> > > > a moment.
> > > > >
> > > > > Best regards,
> > > > >
> > > > > Hidehiro Kawai
> > > > > Hitachi, Ltd. Research & Development Group
> > > > >
> > > > > > From: cip-dev@lists.cip-project.org
> > > > > > <cip-dev@lists.cip-project.org> On Behalf Of
> > > > > > masashi.kudo@cybertrust.co.jp Hi, Hitachi-team,
> > > > > >
> > > > > > Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by
> > > > > > the
> > > > following email.
> > > > > >
> https://clicktime.symantec.com/3HW3CdVzyukGSgx2iFmjhKS7Vc?u=3Dht
> > > > > > tp
> > > > > >
> s%3A%2F%2Fclicktime.symantec.com%2F3Hrgtrrm6ninbLpVgrZpbS37Vc%
> > > > > > 3F
> > > > > > u%3Dhttps%25
> > > > > > 3A
> > > > > > %2 F%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> > > > > >
> > > >
> > >
> fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2
> > > > F%23
> > > > > > u
> > > > > >
> > > > > > According to the kernel team analysis, it seems that the
> > > > > > nouveau driver is enabled in hitachi_omap defconfigs for both
> > > > > > 4.4 and 4.19.
> > > > > > However, the configs are for OMAP platforms which, according
> > > > > > to our
> > > > understanding, don't have PCI for a graphics card.
> > > > > > So we think that the hitachi_omap defconfigs should be
> > > > > > corrected to disable
> > > > the nouveau driver.
> > > > > >
> > > > > > We could be wrong, so please advise us. Once you confirm it to
> > > > > > be corrected,
> > > > we will go ahead to change it.
> > > > > > Best regards,
> > > > > > --
> > > > > > M. Kudo
> > > > >
> > > > >
> > > > >=20

--2WKhxKTEVGSWOn8krazn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6201): https://lists.cip-project.org/g/cip-dev/message=
/6201
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2WKhxKTEVGSWOn8krazn--
