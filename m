Return-Path: <SRS0=YLkO=NH=lists.cip-project.org=bounce+64572+6680+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42AC4338F
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 20:39:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BE360EFE
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 20:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8BE360EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 87liYY4521723xIDCHL7Wbwo; Mon, 16 Aug 2021 13:39:07 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.134])
 by mx.groups.io with SMTP id smtpd.web11.29992.1629146345167260234
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Aug 2021 13:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRpzZMQGBz6SrUgaYxhK0RWi1F4YeFjPmDWYCrGiH4QuJoQdsmdc6pQMITdayZ1P2wWE7aM5AgUf5cF0H9IRQLHmwcFX8nG4SJnlBS2kw6OoBa5PLKv+P+yFZ9OEQyAzFg1bdcrSazETj0E2kE3y8MKmln+2OVoVgSjrT39Zx2eSPY2RgE3GM/Bj6LI/GWvxPxaB2vKm9cjzZsEtPnhdfMygHkQ+60cUmGUDYjZLIXCn3CFG16XNPH8qqruMGDnUI5HwpO7TzMBpIDJ9tZi1VjuSePITlU8NwIgtTFQIHUkiKt3CR5YpKvknjGUhUFeldgLaWXcYx+9P0avESf3dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqAZG02Ofol0EEcicbu1Ouy08/6hr/0krAVXot2E/nY=;
 b=V/frBrmghpjd+ZIplHyXo3L6FL2agfIEdPQ7uE5QYi7jC3Pn+JfJUuytLz48ZbzH3ZPNuNdeNFWWaS/Qqz83B3zBZ37+oWS0q1Wkmwx8p2uOGDk4gjeLOSYGXe3lHiHuDvWHHrlBB6GjGRs+rtPmORnFg2eqm9sWzIs+l3V5bwJbogVJKt2wEuc/YDlJtduHVFguPf6Ubo8xIyd1x1+0oFjd9RRSn1qsG2iPh2MOJtS8Tl5SzXhU8NCQ3LhXDgPRo+k7BlUMXu8wq8hEKQLVRXdLb5jbwozO+M3vk98pT5ExsU6Vc53CUCPUJGeJkIjLa0pqWUuGLjNPrIIqqOI+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB3844.jpnprd01.prod.outlook.com (2603:1096:604:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Mon, 16 Aug
 2021 20:39:01 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:39:01 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: [cip-dev] -stable-rc tests failing
Thread-Index: AQHXjnutwozlPbvn0kGggfTL9fZabatt8RzAgAPpxYCAA17qgIABZm9w
Date: Mon, 16 Aug 2021 20:39:00 +0000
Message-ID: 
 <OSZPR01MB687744CD27CF595225C265CCB7FD9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210811063943.GA23723@duo.ucw.cz>
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20210813194635.GB23237@duo.ucw.cz>
 <TYAPR01MB62529F6AAF0B05B25FD8DFB292FC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB62529F6AAF0B05B25FD8DFB292FC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a6fd82-ac25-44bb-3c17-08d960f5e126
x-ms-traffictypediagnostic: OSAPR01MB3844:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3844E8CC168A60563E058409B7FD9@OSAPR01MB3844.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 rd83SMsBj8UYmC5G91sgP7r799u16XEQaBt2CfEz5730XZvOyN/PbcC05JTLiiTjZuz3AuBpMSjhR0Hv+l1ZSjZjVWCI1CviIt75yhhqQA4I5/IWf1/98cArLksPg4JM5905ff6XVFwg0elMkDM5lTPXfouZ7xFVvcj2el0jWdBSuniQ/D6O2D+7zzEjriohQB3JYAYs7tqEHQaT7Peditbu1icyELb1m+OoRheEixrSXteUUpFQjzuCCut06iC/VOh5N/3r0wPrt73KMkGj+MHdFtbYLgduBDVPLHhtv090LG3iuBdQDSaB5DSrDNYY12LOcIhQ8ukPfYQJ4/9h5O00OB76pDtRiBhkGPwq9spKVEtIECA9cAHMwRtRaucYeRHNWqFtjIqitI9FFhWb0S+63qPWEGowMEMvtDhrrCje9kKjxtKXXsX+AOZM33/+5Qv/bBQu1bsYDJuRiJKlW2ikYlVDtUHUNKedcmcIjindzDpI/zC0ddPNrbDAxhkxSiAevdz4X2yaAXMZ2iBuWlj89SMTPR/Tp4+JEJPeuYKtae+TmOmS+6+77LyBF+QoagLuczY/qGVL1A9r3V34z27p+dK36m6CD1Ahc9vzAWh2yciND5VgXN5hSPJkjuR0pWrst4hE8Wup0QofrD8i8ujLK+ISes4s8vAfCGtmUwEPcd3ZuyTXMlTT6T7HziAUcuu+gvljH2kKrq5DXcU6ekBTwPS8r7OkyA4bgdnvcFfusLH8nYaCwiz4f3BglHtwXAvWuXSojRZQCko27q1M8neec4pLKZfQOmntc2nCDgE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?e0FLEDl9S8gNXJM5rZ2GuEEBQGIAv+cJ+EtHdndGNXC6FRVsAMFRRiL3?=
 =?Windows-1252?Q?bUUGJw90GDqnHZo2hzIOSackiKLRcoH8kHGzUYeofpskbpIGa/WehwTX?=
 =?Windows-1252?Q?vjNSLQ6GvRKv8lJmf2mmkOLrDOrb4ISAuAOHdlC0hnNCK/BIQZ1Kqo0M?=
 =?Windows-1252?Q?f6T7SeihyXHZ8TV1JFByTcWChW7/xiVmXRvOAfMAZZ/xZRhL6Jmv6WI6?=
 =?Windows-1252?Q?VT82rFqa5uU7vJ5WFiZ7aY/4QhvpeIYU12pbhwb831eRlpLlaUPNpzeA?=
 =?Windows-1252?Q?bYu/Lc3gF0EG2EB5RqG7DsNX3km+HmW2DqjEiUXuUOkuwxj1ZimsP2VV?=
 =?Windows-1252?Q?tsxnu2UE+FzFemLzmksXnzUA1OcVyJL0UVnrcbdOY09KLtF2LU15SAl0?=
 =?Windows-1252?Q?bCDA0x8983xMAkW7F9bKz5LJw53/8Wf9102A4sShDfeW8Is27varPvQB?=
 =?Windows-1252?Q?3N3X3BNRh72H45nJR8sjMYK4pnYuwRdA//mLWxZ7wMShYF/J5NgTFLcb?=
 =?Windows-1252?Q?jkqVM/dJ49QeoOMtsjfgnmBvr/szYXILW4HFaZMhRN67StHcH/4S8P00?=
 =?Windows-1252?Q?HsWAHohG1GdqXdnhFIBgiX49M4csyT4t4/0RLFCiPj0PlSzItht3ymiH?=
 =?Windows-1252?Q?B9YdkKEEEXBzOqJIAla4TrHRliJtoqlu//42s+ArB5wIi29forMC6jgf?=
 =?Windows-1252?Q?xoBXqeqFnrzxdvyYOFEYZkYJvrwiaX3hUFRB/hwOGSTPEYvTKuGpUdPN?=
 =?Windows-1252?Q?bi4TIJpaC6o2wHEpjgwKOYvd49o5E3+oiyc/1XbZYJxY2YSSMklFEMn+?=
 =?Windows-1252?Q?PA0KZzuFq2JTTT5mZIF8zxEsmbzaszB91Ht/gpluyNYUjKLOn9xht/HW?=
 =?Windows-1252?Q?3v3gdF9++pdz6C4kZC3xuM04cy6zHb7A40VHALbi67irR3+zN48/qe4u?=
 =?Windows-1252?Q?YSv0Vhf9qD4WmChufjmqmW9egsc1FNLGbcIKwJY72gRLxNSLTMflBsQj?=
 =?Windows-1252?Q?IBCDlgqnnGHt9P+vzFFDcgUXwivy9dNTfgN4gx4qrTrv8L7kzDe2stZb?=
 =?Windows-1252?Q?c2qJb4nEIH/HwsC8vMy8OcfIMi100PH1gLnc42eKolYjK62ltlfFgwjg?=
 =?Windows-1252?Q?N8CBWBq5oILa/CBiMuA7fHnAaC5zC29BBnr7FfXJNhwtsFTS0MJUGyXP?=
 =?Windows-1252?Q?n5FcfiUUdiCk+QsaZRZxXCnTCZhhpKqq9yroAhkD8imYpQsHl6NuV0p3?=
 =?Windows-1252?Q?kVQFu45p6Oy+zxkbfJeLGYpiR/gl8vi5x4rr2hUvaHV148azpp9/WkK1?=
 =?Windows-1252?Q?p8LFJzAFAyybMCRX7n89n0mzcnrSefUgrc9p24nq/8UO5uS99MPW/qeR?=
 =?Windows-1252?Q?pYZfU9QH0tBNo3Eci9Us7V/5Dru7XFNIMkwuneXI7N9NIRwMmrJ23JUL?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a6fd82-ac25-44bb-3c17-08d960f5e126
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 20:39:00.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+xZ0bPUFVt0J9Wq4n2q+617euIN2SvRJ0aOSkhLcPy0BlDaBOxn7z2zz0xnjOOB7Sb2xkJKNtSgNNt1pPUAVg77sRY5qKQlpt6fUtHevks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3844
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SdXrrJFRo08uthlKQtY5EpOtx4520388AA=
Content-Type: multipart/mixed; boundary="PkEdmZEG2vCpKh60tieS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629146347;
 bh=XI7EOl42d9EZrD7rL9PZpK1jtsR82vRBcSMisNtouPA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=XsRRRquDgfcd5NGewz/uAFAsljdJfbwkzt95udgPIA8e0a0bumMXUxLNQHSLch5GipX
 BHdQx0Kl8GEC9HIDSSG/dBe69q4qb9BIZlcdSac5QVRJHyMfSeD5ZUNjEYq+yIBNkkVkH
 h7udhHpSPA34q5FWi6mJ/JjJp5nJ1i4qhik=

--PkEdmZEG2vCpKh60tieS
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: 16 August 2021 00:15
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.o=
rg]
> On Behalf Of Pavel Machek
> > Sent: Saturday, August 14, 2021 4:47 AM
> > To: Chris Paterson <Chris.Paterson2@renesas.com>
> > Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org
> > Subject: Re: [cip-dev] -stable-rc tests failing
> >
> > Hi!
> >
> > > > WARNING: Retrying...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error=3Dinvalid argument
> > > > 2170ERROR: Downloading artifacts from coordinator... error couldn't
> execute
> > > > GET against
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fapi%2Fv4%2Fjobs%2F1492901612%2Fartifacts&amp;data=3D04%7C01
> %7Cchris.paterson2%40renesas.com%7C4479c8657b2a40a46e3108d960428bd
> 8%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376466612029063
> 02%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DqwhRPtRSueYf9
> 7CTKC1JVJbJGJWHpfwkWq9GebqwLs4%3D&amp;reserved=3D0?: Get
> > > >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fapi%2Fv4%2Fjobs%2F1492901612%2Fartifacts&amp;data=3D04%7C01
> %7Cchris.paterson2%40renesas.com%7C4479c8657b2a40a46e3108d960428bd
> 8%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376466612029063
> 02%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DqwhRPtRSueYf9
> 7CTKC1JVJbJGJWHpfwkWq9GebqwLs4%3D&amp;reserved=3D0?: dial tcp: i/o
> timeout
> > > > id=3D1492901612 token=3D9gNGsuaZ
> > > > 2171FATAL: invalid argument
> > > > 2173
> > > > Uploading artifacts for failed job
> > > >
> > > > But I don't usually see this one:
> > > >
> > > >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> &amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C4479c8657b2a4
> 0a46e3108d960428bd8%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%
> 7C637646661202906302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
> ta=3D7bk5d%2FyboUuOw0l12NBKvIDvsnVLmzwvyVSniEUOjI4%3D&amp;reserv
> ed=3D0
> > > > /jobs/1492901660
> > > >
> > > > Job #371616: Submitted
> > > > 219Health: Unknown
> > > > 220Device Type: r8a7743-iwg20d-q7
> > > > 221Device: None
> > > > 222Test: boot
> > > > 223URL:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2Fscheduler%2Fjob%2F371616&amp;data=3D04%7C01%7Cchris.
> paterson2%40renesas.com%7C4479c8657b2a40a46e3108d960428bd8%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637646661202906302%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DMkr7BDJRwjM%2F1Oeg4Q
> GEOpN%2Bj6%2B8C2%2BZ8mtbOppdhY0%3D&amp;reserved=3D0
> > > > 224
> > > > 226ERROR: Job failed: execution took longer than 2h0m0s seconds
> > >
> > > It looks like the LAVA server has stopped processing jobs. Our queue =
has
> become very large!
> > > I'll have to see what died and no doubt reboot it and the labs.
> > >
> > > Sorry for the pain.
> >
> > Thank you, it seems to be better now, and it looks like ctj_zynqmp is
> > available, too (I have not yet seen successful test, but it at least
> > tries).
> >
> > But I still see problems with x86_qemu... the "2h timeout".
>=20
> QEMU's queue is full. And QEMU of each lab is not working and it seems
> that it can not be processed correctly.

All of the QEMU machines have somehow got stuck in the "reserved" state.
I'm trying to fix it. Will update you asap.

Chris

>=20
> Best regards,
>   Nobuhiro

--PkEdmZEG2vCpKh60tieS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6680): https://lists.cip-project.org/g/cip-dev/message/=
6680
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PkEdmZEG2vCpKh60tieS--
