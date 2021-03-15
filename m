Return-Path: <SRS0=4CUJ=IN=lists.cip-project.org=bounce+64572+6285+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558BBC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 21:49:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E30C64EFC
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 21:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E30C64EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6285+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9dT5YY4521723x3Tn8gdvX66; Mon, 15 Mar 2021 14:49:09 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.121])
 by mx.groups.io with SMTP id smtpd.web09.17.1615844889385528449
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Mar 2021 14:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyaHWPtQxKkK7G68lm0t0LctLNkSZnU6BMsYbnK5lXTivU3/AWXDuUNv5t1QkHZXnkgpdWqg3S5OmlBRjN8y0T4EJ6FgfInuTDWq4EbQR/FrEMC/hIEzhLfcvZYQV3buYkZyuwB0tKRGYUcvZkWBjiVXc/eaK0sM8XAt18A/Wq1BubqnkcTHXrJkUl1g/X31pQHeTmxH9BrJ8WeMz8ItEGzypOCgE/nLn1GLZiH0F7qAIq9bEbKkJGR11KaS97JwgjZXK0snRHOU09igqIuyJEHCRwg4tkDGhqFTBp3k9O7ioCRz6YVqvMKktAgB3R4zii+14swI1WiD7DL9cWTnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLCYF/cUngRiL6uUMV4B4CFi3yDEtBiVC5FTtMcLD9g=;
 b=LyROSS9Z9d1ygbtFtJwFRIaSaoBTj5Hxr32SFa7WXAU7K6EWKkAEDIouh+LAV9Je624LlZN6xfeuoWHk7r5t97i4bE19UbWACl3FEV1kpEzSQ80q2ERdhyjrxjYolVULaUF0TRGqFQ71Zl1dPu3YKSbn+poLaOAXbds8TWa0lscFvwniYDJV7xifiOvvFR8lnV/UAqojilKcroxQkDer3udqAoYkNJiV09DuUgffmwZ+Rn3HMtz5MPMctUFuELmVjPLGGeQjrKpqL3DmZT8LmjJ9+H+DNQF5O/VgI5aSCQNp6Iyl8DjtcI1HsVdhXHA8oFdyFqmV1OHDfVorUhoQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB1633.jpnprd01.prod.outlook.com (2603:1096:603:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 21:48:05 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 21:48:05 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP kernel release delayed
Thread-Topic: CIP kernel release delayed
Thread-Index: AdcZ30rmCF8G3MqFRVu5PsqAniOjgAABWLgA
Date: Mon, 15 Mar 2021 21:48:05 +0000
Message-ID: 
 <OSAPR01MB23857F2E8E3D81B2E6C0FD07B76C9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <OSBPR01MB298370833E6B71F34B37CEDC926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298370833E6B71F34B37CEDC926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99a097fa-c3d4-492c-f57a-08d8e7fc03d4
x-ms-traffictypediagnostic: OSAPR01MB1633:
x-microsoft-antispam-prvs: 
 <OSAPR01MB163372177725D173EF04757EB76C9@OSAPR01MB1633.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 g5F7KRvc5Pl5I/8pnJHO1bfy5olR0fNVchLadwG8x2AwSttM1bIFLOEIk7jvhJa64+WYEgiD5bxBO/Nr27HjxEusHErELMhjgqZoLBWosR1sExnKPjtn+bOLCsmf58BjQm4yp9whkGVGyDtEdKSIOpx/LyaPY39uoCnFk67kjxrZxdevkNfjBIX6NhfUxgUR8zKZUBeL3AKMsdhJa2dOmF8CnjoOrsiG1aTR5xhKz9yUJHQyNM7sZE5JEf65KKlqixHiKtGKd7oc8cJ2n4r5lxDPKE+r3wDdBSfxKGcrjPhMtw+4IjQ5mzQ6VWDbwN6A2qmkmC3v2QGzdBGIdhbt6yoTmdzLZotEo1W+KJtJx6iHPf8D/IP2ZloN0vq3lwvg/HrA8DWT+D3p+s9qoEb0Stcu2jiuhL4jX0TbXobpg4iyJ7jGXDoOJngZN5Q4chwLgkLEVXlL6ShYWceiGN8fyJDooVIXz0zJsdKk+58sQTF87a8jaqvOW7lMSwHl6nirw682iEySoH5/5mGYnii5MFaUPwrtgDlvEcNQeE8CQrH4l+/sIcixHPBCsBQgGx/Ja4KaQfvy8dLWFMzTLLUXojMz4Pu8IQdP3uwN9nW0xMde4fPOHRSLZIbmkcMM+9N7CWREtD1IYvxAI906sdVVJw==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?xoNEliD0PajgpbPIwZ7WAeDYl7+G2pjb8/CsaLenGGUwR9VXXnh/rMdi?=
 =?Windows-1252?Q?43q/E6VYh79TMsZLZKRQdXH9YMWD3yxDtDZ7dWmlY2fXPuWvw+SITACc?=
 =?Windows-1252?Q?vtJ8lub5ks8HJm7jK+wIl8YdWd7nnnAIIQeXEf8uOOwXgUCGs66bmlMn?=
 =?Windows-1252?Q?dPcGgstCHYy/qPjXjX4GKbfAjquyhnA5I+gRUD/fH5pNQIQPL8gNWglp?=
 =?Windows-1252?Q?+bH7o70A7qN3Hbzempt/EkZwOKlgrR4grVWbhAW8NeU4hpxwtcFBRg26?=
 =?Windows-1252?Q?VTwI35Fiez8OKIxkwQkKn9DVVScDDE1atJgtlDMwgjL2xffsAdN0szZo?=
 =?Windows-1252?Q?bS9koIO3awTiMoR0Exm/5yxaUleHShXLXBT0F97yKS6mCzrm8cVpmg/w?=
 =?Windows-1252?Q?YVvQTtU/yQc4RKjJOkJ8TWLhla6Os0cwOnNjD8CudUqduPxSbEzAPoG5?=
 =?Windows-1252?Q?W7dbB92aLd+IaYF5jh1OH0jkvqpqxw9qZJD64klCYECP30Hr7TWT0ZQD?=
 =?Windows-1252?Q?5E7YzXFFUb+xNpjYu+L/hh1QJPRe34azC4F59SV4LLQIjgl1YKFappx9?=
 =?Windows-1252?Q?/TMx9KV1RgzVClMJg3B1+Q8/GmZ1J1IcxNwitDIJWGbth+Ojz1MNaPhh?=
 =?Windows-1252?Q?Xg+pOuEdkFanrTA9+ryF7u0EnlSnCCJAFTGPb6LVQbf3ILoZWA4tZ6ee?=
 =?Windows-1252?Q?Grk7SryHcj41p1afKZ5GygMHZsg7k9uucIqO1m1M5OhEjERnhKzCyz/P?=
 =?Windows-1252?Q?yTxT+OrfL+ftw0Xl1gPMmnMSHgfVAWisv3r4pnD6WJsWvNvRrKvBK+kE?=
 =?Windows-1252?Q?Mc1vLRD/QsHV5TrR9vAz8qkWg2R2yXko7EK+Jq3fjZ8egCr6BARE7NxB?=
 =?Windows-1252?Q?OliMV4pMB3XKFpMnSQ6BFIqPRzoEcPMz/KhuD8ktSe4JuAoT2bvoQXHZ?=
 =?Windows-1252?Q?fjOzfkoe+tpNvmXGE7AMlbz2dFtJiHOcbTZxaH/TYU5UmWFm0HskpSvx?=
 =?Windows-1252?Q?pS+Ks5IYjM8tNf4GeQA3FrShlPnExNYmV0JmvbQ7yOn97GfoZ94GXCX1?=
 =?Windows-1252?Q?QXP/9H5tv9WKhMS6lzjRhjpBm5fJb+jJOvpBPIxzgBd0ahkfVaNfdaF2?=
 =?Windows-1252?Q?mZ51geWs/io71SxgY0SGsS35gQrGdlQz/tQvX7tCEaO6gwbS8lUF74vS?=
 =?Windows-1252?Q?HhmHSDSYkJU13+1JoeyVp2Gv92HbEzq0/zpz+JuhfBpfYzQI9R6PNORl?=
 =?Windows-1252?Q?6halTNzFtVIP5hr9tyNzl0jCa5wEazUNmAm5ruR1730VFDyAq/uWO1Ic?=
 =?Windows-1252?Q?J9odla/GEHmM1QH8M0wreew2+Y/ia10GsA427PKT77NgZ4W8+nA1+W4N?=
 =?Windows-1252?Q?krzo0ouFmDOeYkAKOGOA1wuE8NDZFoKteYC8BvbULvybswBL5bptRCtS?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a097fa-c3d4-492c-f57a-08d8e7fc03d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:48:05.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7JL3NgUGL4i7uNLfE4btKaGVDn3UMiUEIpnVeXzEk3gb3ULjC2DlVI8SAaN3fgLizd3CzHv4SEEF9wCk7enSP9aFK3eI8pMTnm5UzxjSwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1633
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cw8WMsloctLfODdvPixbQAqTx4520388AA=
Content-Type: multipart/mixed; boundary="n5xBvEHjelJDCrTGJ175"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615844949;
 bh=+PyHhCoXng7N0/73fFqcjjUNwok2ZI5Da0nbUCiTNb8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=opqwkSw/dbzIjSJdtWUU77BVJihNMN0++eCPRC9k0Bh2nUiEKV9dAoGcC0B4+2pRhG9
 zoIdwx31c1njcjlIglxsU3YZAJAcmqqgaBwybJvisFcvBJSUCjZdy/fxStxNjB8GpAPZp
 kDD+yGHLgef0M82X/G09RYUEPOzYQXSo4Uk=

--n5xBvEHjelJDCrTGJ175
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: 15 March 2021 21:08
>=20
> Hello,
>=20
> The kernel team are planning to release new CIP kernel last weekend, but
> we are currently having problems[0]
> with the LAVA lab and can't run test it on some reference boards. Therefo=
re,
> the release will be delayed.
> As soon as LAVA lab is restored, we will test and release it.

Sorry about this!
lab-cip-renesas has been having network issues. We installed a new router t=
oday but it didn't fix our woes.
Discussions with the ISP are ongoing.

Kind regards, Chris

>=20
> Sorry for contacting you late.
>=20
> Best regards,
>   Nobuhiro
>=20
> [0]:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2Fscheduler%2Falldevices%2Factive&amp;data=3D04%7C01%7C
> chris.paterson2%40renesas.com%7Caa69b8b4019844448bc708d8e7f67837%7
> C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637514393074524293%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DnWs9tSorSmUA3j9A
> bhIUc8hk08fDdiNfKNIUNrNlH74%3D&amp;reserved=3D0

--n5xBvEHjelJDCrTGJ175
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6285): https://lists.cip-project.org/g/cip-dev/message=
/6285
Mute This Topic: https://lists.cip-project.org/mt/81361444/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--n5xBvEHjelJDCrTGJ175--
