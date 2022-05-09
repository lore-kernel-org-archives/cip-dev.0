Return-Path: <takuo.koguchi.sw@hitachi.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED70C433F5
	for <webhook@archiver.kernel.org>; Mon,  9 May 2022 04:55:51 +0000 (UTC)
Received: from esa.hc514-86.ap.iphmx.com (esa.hc514-86.ap.iphmx.com
 [207.54.83.18])
 by mx.groups.io with SMTP id smtpd.web08.28225.1652072146547343801
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 May 2022 21:55:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: hitachi.com, ip: 207.54.83.18, mailfrom: takuo.koguchi.sw@hitachi.com)
IronPort-SDR: 
 JV88tOJx2fGXdHyKHoihTH+oQ+2WtXAnTbD//tYn8f6U7zJGvwoj9IZPQBPlb6iNr+BwgbVy3L
 z67y8Z1tbRdzWBA36SYBs0tU26pHtTbO1gzmfWMiw7dNSM9ckueNaHu1zyd50WNmbomzdAGAp6
 5Wk23EnQeiljliRyCugS2yMXOeCoK0rtGg+/5yytj2XvH63YzrgxqVEUTawXJYhK5TkiGTRzOu
 gr4WT4eKPR2MWp4FtBcAx5iou+C3ccZSXziPpyd/0H3Sa6W1D6dhAZaCbcho8gegtwMh8IH0l0
 tIY=
X-IronPort-AV: E=Sophos;i="5.91,210,1647302400";
   d="scan'208";a="95000846"
Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp)
 ([133.145.228.57])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 09 May 2022 04:55:42 +0000
Received: from mlsv12.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 132953C004C;
	Mon,  9 May 2022 13:55:41 +0900 (JST)
Received: from mfgw12.hitachi.co.jp by mlsv12.hitachi.co.jp (8.14.4/8.14.4) id
 2494tbhd019797; Mon, 9 May 2022 13:55:41 +0900
Received: from GUjpTKHDCemcs04.global.hitachi.net ([158.213.210.77])
	by mfgw12.hitachi.co.jp with ESMTP
	id nvQqnLHpuN1lmnvQqnava8; Mon, 09 May 2022 13:55:40 +0900
Received: from GUjpTKHDCemcs02.global.hitachi.net (2002:9ed5:d24b::9ed5:d24b)
 by GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 9 May 2022 13:55:40 +0900
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs02.global.hitachi.net (158.213.210.75) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32 via Frontend Transport; Mon, 9 May 2022 13:55:40
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6CZDe68iJJ16R+RyKo+VN/ZEGMhV/ktbAv9cKAa+RkZY+FtyVZLq/mRrJDbtaVGJneCoCg0NGAS6kSH/R8HnNZXIyBjqM72S1a6G/HVwM38Ufj1B0F502k5xDU5w7YmQWfq1mkHB7RY7Yq9LI2cfJEJxNrncqLAn2ngnQp5JctHzooY16fCOJyPeqGXISj0D0HsCWWueYcnebWualrSkSu3KnciXb252Dwp1/Qk9MOa6Ig66RBeNSYIXWLwWSEBwzRSMFMBFaMatP9hdevj4fMajofTybiKlriZ40iSIlSagFBdHkL1H5jVzeDrSyqxYFW5Y16ajSDC5Sj+o6Xa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6taodGX9mBSFAWkROVaxDD0FNHoqIwH81uelpXodAA=;
 b=TZVVZckC/YLPLKE4J9XBxa/1EuZrsmvLgx82WujKsdAHd1nMcwNYoj2G7CtqkjLIC2cZY0kbSa3A5zl8nsQnLFx/bYwDYiwgZh+ek3O2RwtEekBqiuFOQOxRqRsH5QUGW/GJczbrMFNgu8iJIS3XkTGWTutaH6RPDo9EiVZKoHqSzCVVHsgG7ofsJwsA7vnXc3K+RYUEvdB2GjvmVnt8qDl4y6HN57mJ0SkuikDzDQVJmYKq7mLLN0v/WOUzqJEuXh5SA8imF5m8pLpxReqnKYd7gfLuYeRyd+rhaPF4oyhXyy2XymVymVuErr43BLsKwoL7LTOkH3H+Yos/D7MyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from TYYPR01MB8000.jpnprd01.prod.outlook.com (2603:1096:400:f9::13)
 by OSAPR01MB3602.jpnprd01.prod.outlook.com (2603:1096:604:32::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 04:55:39 +0000
Received: from TYYPR01MB8000.jpnprd01.prod.outlook.com
 ([fe80::7591:ce92:72f7:ac13]) by TYYPR01MB8000.jpnprd01.prod.outlook.com
 ([fe80::7591:ce92:72f7:ac13%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 04:55:39 +0000
From: =?iso-2022-jp?B?GyRCPi44fUJ2SVcbKEIgLyBLT0dVQ0hJGyRCISQbKEJUQUtVTw==?=
	<takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>,
        "alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>,
        "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: Re: [cip-dev] 4.19 oopses on socfpga
Thread-Topic: [!]Re: [cip-dev] 4.19 oopses on socfpga
Thread-Index: AQHYWyZs9BTpjff6t0ycLWIXj6Vt6K0GASyAgABnUwCAAqbDgIAM+lqA
Date: Mon, 9 May 2022 04:54:20 +0000
Deferred-Delivery: Mon, 9 May 2022 04:56:00 +0000
Message-ID: 
 <TYYPR01MB8000262CEE0CB266FCD00B21D7C69@TYYPR01MB8000.jpnprd01.prod.outlook.com>
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
 <20220428173525.GA32556@duo.ucw.cz>
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
 <CABMQnVKzp7B+EF+9vFPLbT0qjfYk8-=_UgFVk6afq3AOO+vPWA@mail.gmail.com>
 <CABMQnVLKZ6XW+mvOb2JbREz7RR42faZ9QDfAquLAi8-CXjmGGA@mail.gmail.com>
In-Reply-To: 
 <CABMQnVLKZ6XW+mvOb2JbREz7RR42faZ9QDfAquLAi8-CXjmGGA@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachi.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c49c2a23-dc3c-41b2-a9b4-08da31782a07
x-ms-traffictypediagnostic: OSAPR01MB3602:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB36024856882F66A7CB7AC2A3D7C69@OSAPR01MB3602.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6sdOVlIf/QsH6g/khXMngHkGj8Wybu0w4yDqeTM02MtqSdXfAGMQFEs/5WCYnj1bog9QhmVYNbjM82+k7mcPx8YdKd/REwzktwitTvUjLxns19UjDMTuJ84QAaz/0sMvthllLcEzXQqOI7g769rqL5qXDgbqeF7r9I7xcoeRcyDeMZOKujNd02vJONWx0scvTqj7+V7gjGOpolBvBK1dEuhd4rubXjTpUsVC4dZg9oJWqjkqj9WMh8qxx0hhCsDPc7asnLWZ/aqShtc3tpJD4uyMMAwXQS+2Snq3I2Xdljl2bYJSoh2kkor+1WjodeCWAUoiwac4KeOeq2qJxxGrYj2O3fNc5bYqsmOgpzzriVcEvRlBKaXfr11azEtR7Jb8/tQcfkd+cAhvgFCaZKg84/Ruz4qTm9wrpC11QSJkeHlz23VwocqIGbn2002FkqtFHUp8pBuszGYCeS192lud658i4Gw6kO2+Gg0d8OqEKzIoqe+hlYae3ZRguS4tmKZFYZtoa3n4ZL6mTN2pqmS7K8eETjzJgZz5seD4AvoHPf7q/QMnWDX29Vf3/hyeSb3ceSzFEftwQeJgadY8FtP/a37n0MwAcSiwqWfWVlJBMxAJS6cjIIGvJKSdTRfYFT+MAwuqwfDjFDVy70BVfz0j22sdHqrFmKD+vVElykRxTk8b7iQPbQBKPESnS5qwO7sdU/3DLIIYEiIrSSJF97kEeB3ylF74am8YGy68zKbJUHt5mGY0XwJRBKV5ePIIb6s+1MpqtIv4aLSCazD66Qe3WzSqvp+IL/0Eccn8D08MigautW1wHCp+bN9QHxG7WenbLgPzJW4Es5Xlj5nwKT2ZzQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB8000.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(76116006)(2906002)(66946007)(52536014)(4326008)(38070700005)(8676002)(66446008)(64756008)(66476007)(66556008)(38100700002)(53546011)(508600001)(54906003)(33656002)(85182001)(6666004)(7696005)(316002)(55016003)(6506007)(71200400001)(966005)(6916009)(9686003)(26005)(5660300002)(186003)(86362001)(122000001)(8936002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZW4yMnRsMHBjNFNEa0RDSGt0WWhrMTNYblFFWXdRZkRzcTErbytuc3hR?=
 =?iso-2022-jp?B?MmpUSWZOdjlrQmEwNkpXK0UxSFhpSU1Sa0s2MERCYTlYN3lUcjdaeS9v?=
 =?iso-2022-jp?B?SU44YThqVG92VzczS2lRckt2Mms4U09mZ3lwcXFhc2NHVDQ5NVhoa3h1?=
 =?iso-2022-jp?B?NlZLNVUyQy9tZGF4Ly92MFpDQ29tVlpmUGZaZXVTdjltaWRtUmhJSUsx?=
 =?iso-2022-jp?B?eFRGZWphYm1OWEUyRGUyQ0JpenFOdnRGUVlVS1VKTmE4WGJWQTNNTlEr?=
 =?iso-2022-jp?B?enhvRHVPbVFBZmMvNHQ2WHc5cjI0cGZoeW9Wc0kxbDhIdU1jV3BaZHZm?=
 =?iso-2022-jp?B?YmtueExrS1JDd2M4VDA1ZjhtT21GdmoyNk9RWUNQVmMwS0RhemZCMUI2?=
 =?iso-2022-jp?B?aHBNSXRLUXA2R0dNTnBycmFaNXZKdFVFbzhkc1J5WVpIbXdCRlJrOXA3?=
 =?iso-2022-jp?B?VXVGTDV2MS95OHZYY0dRV2lPcFpSRVJBOGpGbEgxUmRwQUU5VDN0VnQ5?=
 =?iso-2022-jp?B?QnhWeU1OUEtCdFVzTlBPWmU3K3dZY2JmZ2lNUExET2ducXh2RlJ6OXR0?=
 =?iso-2022-jp?B?aWZxaEQzOWF4VmZJQXFPakZSMGNlemxpYS9DOXNHeUE0VCtyUFFDcUJt?=
 =?iso-2022-jp?B?NTRWNEV6dHJlVnJFaG54QTUwWllQSnVMbXV0REM0WmxvazBET2tkQlB0?=
 =?iso-2022-jp?B?Q05iZitBeG83WTR4ZFdiK2NLckI2N2IydENjVkEyUUQwVU1OUGNsSWtm?=
 =?iso-2022-jp?B?NnVjK2lQNElsRUxyRlFzYTlNdDgwdCttOFV5TlhYdGdVS3A0YkNkN2FC?=
 =?iso-2022-jp?B?c2JBVjJtYmh3eFBLU0R6MFc3eEJhNHYzWXRySSs1MC81UXp3Ry9MVVpl?=
 =?iso-2022-jp?B?azdsNTlTemNCOGw5eWpjWFAxYkk0K0dnalRONFhFSmhBSmdOL1paUTlS?=
 =?iso-2022-jp?B?dEIwd3RsWm0ydnhZMmhVRVRxYXVqckFRYXk2LzhOWEkvdFFmUGVxZWZ1?=
 =?iso-2022-jp?B?Wm1nR3VMYnFDU3JMc29yRjdreDhSYkhTNXI0cHBuUXZxOG5OQlBlbjc5?=
 =?iso-2022-jp?B?QXdjN05oM2wyR0hxWm1QUXNtZVZCc1BYYmpSOTlkSFhKNWNIWURSUGVJ?=
 =?iso-2022-jp?B?TzZ3MmVDYmFBSS96R2xCQkw3dW43RktMZnZVcHhNaGVhR2V6SjczVHFr?=
 =?iso-2022-jp?B?K1ZJWERCMjlBSERuYTMxTW5WeEFIaXZzSURnV1haTHlGa3hkZnJiaHlU?=
 =?iso-2022-jp?B?VzRFemIwRzJ2amthQWxzVm51NHNub1dLM25laFQ4ZmE1OFhtWkpPcUtQ?=
 =?iso-2022-jp?B?YlJtYng5THZTMkVVNUJUSVB4TUNSNFF2T0FaSFJ3MHRDTDF3VGJTUDRa?=
 =?iso-2022-jp?B?YTA3MVIvUEwzTFlHdU80TmljTm9NVXZjYzNSaW5Veng0dncrOTc2YURs?=
 =?iso-2022-jp?B?ZU9RY1ptZFZ6VG1SV3UzSGpWZnBHeHEzNG1FSzlkOC80NE9oMUlRMUgx?=
 =?iso-2022-jp?B?SXFJV0k4VkFvV1hpZ2ZkOWV3UVJKY0prczBhVEdSUks2dzh5Ri8xYWRv?=
 =?iso-2022-jp?B?YmpMeVdGcmtvcTlvMXNwT2VtcVJ4dFFrOS95MUJoSXZoNXFtMVBVU3VW?=
 =?iso-2022-jp?B?MU5iVFNmTHVBWUI1SEM5OHJJbjdMbHFKWTRrUlA0UzZwOUpsSWhENCti?=
 =?iso-2022-jp?B?WjJheGQwK09EZ0M2ZnVyRGVJeC9VUEh5a1JuRi9Ld0R1cHN6MVg1ZjEw?=
 =?iso-2022-jp?B?anNRaTBSN1RwN1o5UHpIRzZkM1RxV3p1TGF6UkY5U1d3UmxkaTZyNjdh?=
 =?iso-2022-jp?B?V1l6UDFDanhoT3BPWW1QbE1ZbEFVc3F1MVNjMkcxUUxsMHBXVVBLb3Q1?=
 =?iso-2022-jp?B?Yy9kQ2JVblU5ZmZNcnBmTTByd2VQN0lTL0pMVUxLakZnSTRzQnlLLzlN?=
 =?iso-2022-jp?B?RnFneHN3bXlJOWdTVWgzdk90WUNITVFFT2JiMEZoZkhLOURUeFU3emtK?=
 =?iso-2022-jp?B?RlowVVd6ZUR6UEkvcjR6N3VZVVI4RGVzdzJXdS9QdUpRbXZqNmZnRlRw?=
 =?iso-2022-jp?B?M3FiVk5tTUlkRWtpTlMyZXh5c0kxb3VwVHcxM0hBNnJML2R2Q0k1cUtm?=
 =?iso-2022-jp?B?UzhOK3JSbzVjYTFJenhmaUNtbEVDYW9FU0tFK2tPZkt6dWN4enVyMnZp?=
 =?iso-2022-jp?B?czRDbTRyV1ZtdTNORXl1UG1ZZVZUdDNNZUppMXpIdjYzLzJ1bGlhZXNq?=
 =?iso-2022-jp?B?SmdxWnN0L1krbDV4ZXZkT3BkZU0rMGc5b2RMK2I3VTIrVktrdVlNVXRG?=
 =?iso-2022-jp?B?eFlra284MGJqYTVBWlhXZHRKMFVhMFc3ZmZDNUh2TlNNY2dLUmFQdzRa?=
 =?iso-2022-jp?B?cVJYekVPcjcwNFdtMGJTb1Z6N1kzWG1FcHpZbW1VbC90eUhkY3hud3Av?=
 =?iso-2022-jp?B?aXRBZzl3TlAxbEVxYUluWGdBZHdHbitTL09hQ2hJWGxTWFYvYUZpUkhF?=
 =?iso-2022-jp?B?VmJVeXM5QjFZRjFWWWtrMzJiSkQxelJsUGRxWWlXaDFKK0YwUTBOc1BN?=
 =?iso-2022-jp?B?Y2g0d0tiST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB8000.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c49c2a23-dc3c-41b2-a9b4-08da31782a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 04:55:39.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 MwKHzxxJPxF/jsTJY4CO1l28SurLNJe2X4D6rxypN0dmnrX5x73mNaa0Alu3GMBNfla1uUKEFWpvgcdADpYawI1ZovS7QMO1D7gMjjyuiqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3602
X-OriginatorOrg: hitachi.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 May 2022 04:55:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8269

Iwamatsu-san,


> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Nobuhiro Iwamatsu
> Sent: Sunday, May 1, 2022 7:37 AM
> To: cip-dev@lists.cip-project.org
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>;
> alice.ferrazzi@miraclelinux.com; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: [!]Re: [cip-dev] 4.19 oopses on socfpga
>=20
> Hi,
>=20
> 2022=1B$BG/=1B(B4=1B$B7n=1B(B29=1B$BF|=1B(B(=1B$B6b=1B(B) 15:07 Nobuhiro =
Iwamatsu <iwamatsu@nigauri.org>:
> >
> > Hi,
> >
> > 2022=1B$BG/=1B(B4=1B$B7n=1B(B29=1B$BF|=1B(B(=1B$B6b=1B(B) 8:57 Masami I=
chikawa <masami256@gmail.com>:
> > >
> > > Hello.
> > >
> > > On Fri, Apr 29, 2022 at 2:35 AM Pavel Machek <pavel@denx.de> wrote:
> > > >
> > > > Hi!
> > > >
> > > >
> > > > > There's oops during boot on socfpga:
> > > > >
> > > > > 4.19.240-cip72-00010-g0ffbb4b1066 --
> > > > >
> https://secure-web.cisco.com/1jOfbkhAUdCz4mo_YgK84zAC5ffFZ9KzMin
> > > > >
> 8BNNUdhQIx6Hrly24tfgtFgWgKCijx3qeXp71JLjo7Rmpu_IwilMXdaLGXPImDXY
> > > > >
> voBqMHK4Y9plWRw2jBxopiWvlvg7iX9mpdqvVU0jS16P2V9_aGIyr3dAMDKsbFg
> _
> > > > >
> wvYdlQdRnNIcRWOG0K49tdixTN9BxlsMdpHMJtxTs2SR1t6IFW_vVAj99XXTqZab
> > > > >
> BsqHykkcdft2cAnMIBIqlvKMd1aWily5NH8HKrd93MWrgpF0_Ky8ZhmWn1mMw
> mGJ
> > > > >
> SR_z4rQTYUEVDmJ4l4xslRv-YKwqVT/https%3A%2F%2Flava.ciplatform.org
> > > > > %2Fscheduler%2Fjob%2F669893
> > > > > 4.19.240-rc1-g5e5c9d690926 --
> > > > >
> https://secure-web.cisco.com/16pAhVK6fBCFbfXvcMmuJrzhLUlKDpKQ4ca
> > > > >
> dquSiRHleedrp6gMEuV7GU68R9y_jKFbMKTMTzp__T2GziUzr9vCYDvFQU1fwfx
> q
> > > > >
> 8JyMtzLF3VcBWtZRG_lADpGlM44gTWbpGLCoRhCUgGb_n9WbXH_GUV7VfUV
> D0kL4
> > > > >
> 0gRECOYpMq_vsL1lct3WZUHyKCt3I7tYBGlyh7t8UTUKQkKNehHlj5F47ud8ElVi
> > > > >
> MQjBxKlaF9na3flHA6Qb5XsgKYYgQnsrPCWf6ixjkod6E2cSBD00wPDnVp0PWV
> 6s
> > > > >
> s3_n4hiUleclye_88ynPk5VYPa8PGJ/https%3A%2F%2Flava.ciplatform.org
> > > > > %2Fscheduler%2Fjob%2F669259
> > > > >
> > > > > This commit may be relevant:
> > > > >
> > > > > commit e2423aa174e6c3e9805e96db778245ba73cdd88c
> > > > >     net: ethernet: stmmac: fix altr_tse_pcs function when using a
> fixed-link
> > > > >     [ Upstream commit
> a6aaa00324240967272b451bfa772547bd576ee6 ]
> > > > >
> > > > > Let me investigate a bit more.
> > > >
> > > > I tried to do some testing, but it fails on two targets:
> > > >
> > > >
> https://secure-web.cisco.com/1i3aTbv6J7f-CwAS1j7J6eSciyhrD1xxeOgs6
> > > >
> HWkBPlbreVMAXnm7m3NB4XP02FJ44P6gb3eC8y-4atP0IPwiVnyKmvZuPM7dM
> yv3Eo
> > > >
> IfyrlI6lzG5f3agR_zkIX7MFdsLrOpC7fjUzsiA3nU4qIBKE43MEkUWBe3B-S6Vuya
> > > >
> jh9XDxFGwZjrbYCcLg5KenRKzEY9D3fnBSv6zEskWiTArr6HqHzcThqiuQvjesAm
> lO
> > > >
> QNf5-O9GO1orFh9aHALU-gg-UxDZQuRvlaWK9W8rUknQ-IuOocywYul70bww6
> bF9bO
> > > >
> 1sOzxvhVK0W-Nfch7cuF/https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-
> > > > kernel%2Flinux-cip%2F-%2Fpipelines%2F522211501
> > > >
> > > > And failed test says:
> > > >
> > > >
> https://secure-web.cisco.com/1osB1u3XwFWfEVdNTDFt8PFk3VQn3lsJny4Dt
> > > >
> ytDWi_4uGjB0ILyQqN5BQjlB7Igd11fBZ2NiU3nzq6umHnyp2vo0WC3BafS4faC4_
> 4
> > > >
> ESKeyjPyg8H_OctweeK2EAqJdYY3MaFxML9YfE9uwskFKJuYaECNLOPTWdBB
> QWWPIN
> > > >
> 9LoTg3y_3Vf1SXiABLgy6vKph4tpMehAOOS8k_0fbSVXhdqpgI95WLSjKKQ_4iTu
> Eg
> > > >
> lH6axQ2dRBEjSi1631jcilAugrSadnSFqmZdjo6xPCyXqplqwmHgZ5rjEguk7NJRXb
> > > >
> JtUwiyNCM9u_MVtuG4fo/https%3A%2F%2Flava.ciplatform.org%2Fscheduler
> > > > %2Fjob%2F670508
> > > >
> > > > ob error: Invalid job data: ["Resource unavailable at
> > > >
> 'https://secure-web.cisco.com/1rmmxEhS_emdbxkeY7BMSkhhKd2LpA6ygwed
> S3KiFTTEKaDdBsB5GrNFn9NQK8qkji2BmfaT9KVD57mLTfZWvHST3ZKst89z
> MgcvEL_gUyDRRQUYq_CySuyBILBZv1B1ZxxRHVPdxYUoB0mzOZvhhApJmalcu
> mYEJIgFUkJOid3xp-3_R6RVh2dXA0eckky10qnkYAln5dqlDfZUXBjNYBVMB1l8VT
> qqOjBX4IuETWqS-NxC51TuZTJW6jahSNdBXBZ43B1WXrHeiQPRQYVKNeq57K
> UPyviIUI6iAw-tKjHvHgLjCHzSQ1tYQxvx3SKqy/https%3A%2F%2Fs3.eu-central
> -1.amazonaws.com%2Fdownload2.cip-project.org%2Fcip-testing%2Flinux-cip
> %2FzImage_siemens_de0-nano-soc_defconfig_4.19.239_e5e741fbf%2Farm%2F
> siemens_de0-nano-soc_defconfig%2Fdtb%2Fsocfpga_cyclone5_de0_nano_soc
> .dtb'
> > > > (404)"]
> > > >
> > > > which sounds like a test problem, not kernel problem.
> > > >
> > > > Any ideas?
> > > >
> > >
> > > It looks like the pipeline 522211501's build job didn't build
> > > socfpga_cyclone5_de0_nano_soc.dtb.
> > >
> https://secure-web.cisco.com/1A642org3Qm5HN30l_4ROLIGL5W2Ab88JM0Ha
> Ij
> > >
> mjHVUNECJy4KkZJ9kQwpwJeNcB2zuVQJUodYZvM7Rmt03MBCOUB7HQcfpjN
> odhosbBC1
> > >
> I9IewJWYRRxG8Dmc2tyfdlfuSPosWN1jUtN1ymWINJeaJBkK6xPh6VD6v0rYNiBY
> n9Ue
> > >
> 05j1-GRyAeKZUOoBd6PPk433wDVueaHS98VHasCDJpFpznvorpwl_3_a2zuk1fip
> VJWh
> > >
> FIZCue1eSDc_EKpa-3_EJiSLnhMc3gl0c2iB4sed22i4rn_8Qx6vF5yhc4LjydIQEu
> K9
> > >
> 7AT9jZoiI1/https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-kernel%2Flin
> > > ux-cip%2F-%2Fjobs%2F2364180684%23L2417
> > >
> > > An old build job(pipeline #523704627 . kernel 4.19.239-cip72) builds
> > > the dtb file.
> > >
> https://secure-web.cisco.com/1VU4bPqh7VgbVJP9jU93GuJlHMPpDNQiepTxed
> k
> > >
> bBE9YF1SRM0dNMe07in9Bc87ce9qxhLC3Vjfm4Du65tIP6lQy7EOvKO64xpQOEu
> SqCYb
> > >
> gCbJp9_InjkaIdUOVG9ESgt-bE75fKnblDG1hvYbjyI4pjat8kMpXhajYlS3DKc17Wx
> H
> > >
> MoarFjEGeYYN5BWNq2BlRBlFsGD-iF_QuBZaEhNi0InwishFl98a6q8QPGDLo83
> vESJp
> > >
> s3AfYymY1dbmEztJ4QyxsoHH91ZJ1ECNKQ-aLGYVdcDKWyQEEzdzDRatgblVqS
> HJSezm
> > >
> JNr5h7EJax/https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-kernel%2Flin
> > > ux-cip%2F-%2Fjobs%2F2371451342%23L2907
> > >
> >
> > This is the backport patch is imported into the CIP kernel.
> >
> >
> https://secure-web.cisco.com/1ApuiGL_0xOwfNNZcvULWOERf-s4HL6xZzlZ8t
> zOY
> >
> eaV9h1EfF5R7PUodJJz0QzKqnf8CWLe0HgfxAbDYCxJQS9CaymOLUSxwNCadU
> 6EyGM-2g8
> >
> cml5kl9T_1EF43sJNlBumX4QCQe4me1yZp4gV7iszMA-0OjWcNUOpEEthuARXe
> 8uVhR4IN
> >
> 3mPrq1qxkkVwcmLv8esU0mFU6QSuMF-y6WRxoPKHKFhSgknCr9Hdj3i-T4IZ2
> RQdMrKiww
> >
> awNUyqjZZ9aFpY3MPYs1ygrZyq3_w5IoT-klGU7OgGiN_TuL9xpojOXZKN-yruHr
> RdUbPw
> >
> /https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2F
> cip
> > %2Flinux-cip.git%2Fcommit%2F%3Fh%3Dlinux-4.19.y-cip%26id%3D64729dc
> 0be4
> > 847961550cdcca4ddc66adf556aaa
> >
> > I was revert E2423AA174E6 with a CIP kernel and confirmed. I think
> > this is the cause.
> >
> https://secure-web.cisco.com/1ZTiYQ1MlKN8-SRgBNnYLLSDw5yArMWHWW
> MZdAmylKtYlap7PTxOBUlyqxkPH94yM8jKYiaO2CcmXSGchP_Q-nuLLfRWWXV
> GOetLFf5d9hTpPOtRJw47SlicuiJGwXG1pg1RCwr8xI0idTaNChyacjoKxttcWGVB
> YaRVXU3Yn6qNFcKHBxdu5WfD0uIdnmq2XD1So8rtvuKnim0__v35HUCAzHmU7
> YA0okYZ0oKt5jairZG4c0hRW3sjFlSwX2A2wp9U6qtKw_D29aSv5xa9z_yfouO8n
> Ty4qbZXo8uHk63rDk00sp_rRNanm-wP3DHjI/https%3A%2F%2Fgitlab.com%2F
> cip-project%2Fcip-kernel%2Flinux-cip%2F-%2Fcommit%2F009b7940a6ca52f2
> b39099c2c4d10bab337829b5
> >
> >
> https://secure-web.cisco.com/1tK76i_ga9LliaGRryilcwTYWTMd2i-p3ZlQy_g5
> 0
> >
> qQVX_0IbwD9lubuPagOHOEK9napv3cu6BrVkN372e7-ryX63dyFyxXLpVqBB4jfo
> AQo-Ka
> >
> MAo8SnlV--XsCRjJaeLiNMGF7K3LKuxvAAN-9QO5RxcwxJ3KrErvnygSk6wfNifn
> K_L2XP
> >
> YNLaHINjNbBJm2MyB8Q_9F2aRfMblpRjftg4NL_8dZj8aHWwswhTX4tOYrJoV0P
> RmP6BFK
> >
> DYyMp3Sit0-uuPtLRb995hq15CgzZH1YzWU7VQd7YImNJF64YptC_uhZlod-gJrX
> wnDBqy
> >
> /https%3A%2F%2Fgitlab.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-%
> 2
> > Fjobs%2F2392927535
> >
> > I will check the board supported by LTS.
> >
>=20
> This was also reproduced on other SOCFPGA boards.
> And as you know, this commit has already been Revert in LTS.
>=20
> Best regards,
>   Nobuhiro
>=20

One of my customer has reported to me the same issue(oops) and the same rem=
edy(revert) for v5.10.112-cip6.
Is it not recognized yet by the upstream or CIP?

Best regards,

Takuo Koguchi

