Return-Path: <SRS0=O2WK=B6=lists.cip-project.org=bounce+64572+5162+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B7C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 09:16:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4024207DE
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rGwaOjJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4024207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5162+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id r7vSYY4521723xWBfYtEduZI; Thu, 20 Aug 2020 02:16:34 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.121])
 by mx.groups.io with SMTP id smtpd.web12.106405.1597914993092908856
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 02:16:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov2HRmQscuh+KGTEyOEe00MkwkCoHXtSjDuP9HjM0vU4MsxO/8Y26P9Dy15OVYwCtoS/VoDqpnPH74/gHwj+lhMfUeFM5UHRKbZL+fRz5I/2jLHi0qaP9vT07br2A7Y36s76UHtBUy9smiwl0jW49LcFSr1weY6wEMePvZhwEn6zaqnV1KLoCrUymPvKTglpqkR4lhsxXfYAhRRd2Tk5O8hnF0G5nd/ImYkY04lLc6D0Fs5/6L9925t7qjVe3OFf/WkT6Ufj+4ba+y0+pwP1DOVSe0FUQHF4dUscS8AyTbua/+cG36wvL32SQvbLicGqkD42e5bElffDFCUEdaAfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QrkNEx/0DExKyrKldpvqX7VhjQrdcOeXTKc2ap9DpE=;
 b=miGRgTzvWn6ThqN9cKYpOaas3u1Q8M04hUV/zjNeV/br6QI7lR3SIclRghy97kIeLKAORzYOECf5/aL8y5Stl1LWirN9Rlu54HHT92x+D2gSFeUEM5nJnBcvpvCW2WJu0UMxPJncNsVQooe/tyvRFPfosQhA+99OClaekqjgToEG4wtajPV3Av3Bg2rAVXTSkme6833q3uLiW7EXmDFPyhCnqXCK7BM3vdQsKj0hkuD2rMbPOIIl9GtqnSSmbopFwIkiK46uo56SbrTskftkOGDRYx0mPlB9AZRy3LcMcaXKkHbstAtNBmUFq6UVSKGHVES+Gd5jqJIca8RAfP+bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2388.jpnprd01.prod.outlook.com (2603:1096:603:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:16:29 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::7952:269c:e89b:8a89]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::7952:269c:e89b:8a89%7]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 09:16:29 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Thread-Topic: [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Thread-Index: AQHWdkbpmsaTVEF6E0uILsax8LRuOak/sq2AgAEEcVA=
Date: Thu, 20 Aug 2020 09:16:29 +0000
Message-ID: 
 <OSAPR01MB238513FFAB73D179C17BDE5CB75A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819173857.GA5567@amd>
In-Reply-To: <20200819173857.GA5567@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.147.56.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e5a2ed1-ca4f-4e3f-6602-08d844e9b8dd
x-ms-traffictypediagnostic: OSAPR01MB2388:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB2388B291AB251F84F60BF994B75A0@OSAPR01MB2388.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 gpa/UviYFYBQHXVD51Ese5mwT8w6NGqLyYEABBGkHJ/J7CIXzGVtLjhsg0z4y0X6t37oBj8o7F6FDsuFEjVb8FBCLuYhp3/iYeTCXDTNwnlXA7k4VUGFi1llOvUghAIg8/z1pCRvYXPHzZf3ND5Ly3EM5L6eyQdq8O00rHScglizvTvRTcp/4RNFK1XSM+h98IWE2Fl+H+z+z0lrfWDTSM8AvA+TZtPtxHHO+ftfSPtM4rzWPgvtkn48UUlcMWcwRWR1/RAAtSia2GJNXrfStHv3ZDjnwnsm6qhFuUrhwgy/1v1RMzBdP3C1BkDlBnaN
x-ms-exchange-antispam-messagedata: 
 psmbm6WthWguYEzeKQjM8n7IyLXCxJTJ2PXvZmQ+jnjXi6l1trCSJufWKVCs89aBZtsxhCDT3oSaM3gJHMXtCZvXl67a6tFsdG9vbQ8/LkgBt30dXdtWBNUVS2t2gWlXaGTP8t80ol3pIPa7j2BBy4DMTlY3pZreFuDCpbiyAfwzl/Mzd7Yrw71Vdv3+PpgmdEiQizRxqI6noQW6Wr5t5KezQVyK/pjPnG3V7Nuk5Vjj55tiifdd+qhhx+7HsuxTw5WI/RQafIVxl8IVSMQKvDPBNZwCYvoXzvF1VhaunJPpA8KxYfXnQ+mfjoAbg5AMxLksMR80UqZmtvL8aUqcOgaXxrQmnvYnrw09Et78E7cs5LrfpuiKgSV8ClT2Lt1hXJlvUVa7MxS711gs0FdkuIbMXW3FA1SdQH84V7BDCDvCB3dCox4g8jsjJNRjxK4O5LDdoAbWL9k5c6Y8htD+99O2qn7ED0Mi4iAMtC998795SVuF+Vj0LclkocPtI1Yl5QejFvBho9b5kMsNCJgbH03eifLzV3MDfuq4xveYBfdp63T+IkJvBwdsh+YbOsI1Xr5QprOjtFR/tUu1Zzf8OsdaT4hbH8sfgSC08kFCl9zkKUnKMzZubnTaH8R1muPKbFiWs/hVAMU70FkgnVv+qQ==
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a2ed1-ca4f-4e3f-6602-08d844e9b8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 09:16:29.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CG5sBu/3j0QoMQ+z5NsHakFfa3PFnQy86iUhsc0Y5Xw3TxopZMbtnTn/yuOSYWOvpfZJ0S4NDs6LBokubWQQmv0d8KOh0OebvFO1ExYPbtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2388
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eCZZ9KeFLi9yPmc2ZSOlC6C2x4520388AA=
Content-Type: multipart/mixed; boundary="4rGnEvp1v4eEoLJ4a0B7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597914994;
 bh=XTQLhtTc0FqU2mub1w8Hygtj3t++2YfQH4JWvLFyla0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rGwaOjJOkwnpo0BALGIIJ7oqqB3zWh2bOM1qI3S6cPD3nSnJ4pMoQOu8K4GBOx4/UEK
 6M5yQj4021Ky4Ht04YOBvdSY2seVttQdjNyAbpZucc0UlO5Oew39an5rSlpGMFb6jxzsJ
 1WHmqgomw99lYcPznY1WXPxRYpMTjuTPzco=

--4rGnEvp1v4eEoLJ4a0B7
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 19 August 2020 18:39
>
> *** gpg4o | The signature of this email could not be verified because the
> following public key is missing. Click here to search and import the key
> 30E7F06A95DBFAF2 ***
>
> Hi!
>
> > This patch series for supporting RZ/G2[MN] rev4 board to cip-4.19.y
> > kernel.
>
> >=A0 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 11 -----------
> >=A0 1 file changed, 11 deletions(-)
>
> I'm pretty sure this is not the real diffstat.
>
> Let me go through the changes. One concern: you are renaming dts
> files. New names make a lot of sense, but that will likely break the
> users, including our test infrastructure, no?

Technically yes, it would cause problems. However this seems to be the way =
of doing things upstream.
I guess upstream is a bit different though as users would expect such thing=
s when upgrading Kernel versions.
For SLTS perhaps users wouldn't expect to see such changes? It may be easie=
r to keep things in sync with upstream though.

FYI the "rev4" dts does actually boot on "rev2" boards. It's just that some=
 functionality like WiFi/BT and audio won't work.
(and the rev2 dts will boot on rev4 boards)

lab-cip-renesas uses rev4 boards, so from a CIP testing point of view there=
 will be no issues.=20

Kind regards, Chris

>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4rGnEvp1v4eEoLJ4a0B7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5162): https://lists.cip-project.org/g/cip-dev/message=
/5162
Mute This Topic: https://lists.cip-project.org/mt/76290780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4rGnEvp1v4eEoLJ4a0B7--
