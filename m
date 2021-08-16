Return-Path: <SRS0=bRoa=NH=lists.cip-project.org=bounce+64572+6681+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0EC4338F
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 20:58:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1801B60EE5
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 20:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1801B60EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q3MWYY4521723xp6UjK2Q4uh; Mon, 16 Aug 2021 13:58:36 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.133])
 by mx.groups.io with SMTP id smtpd.web12.30571.1629147513763425431
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Aug 2021 13:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh08N7LgOfqHicNVTM8ZA1GpMIQPgRSuGNq64eZiRLIQG2mr8WSSlZgjuvmZB3WPKYtby3/qr2fhrMop/b3j8UcpPI1/x93i3Yy6+kPKuo7fRFNsOWJlNLxQd2UgaREYw5hBfq8JKyPiX++/yN8mI9eLisYShYwu34yF+W1tGd9IwEhKf5CmNgSNhMhs1JSXgii0qCnaBxdupr91WFCHnyoO5Vzul1RzRtOJaRMf0oareXn5gU6YVYYHsCg5Pg4+Du+/t0J8mjw14qAcmtwHceyJmNkqKBpdXsW7s18erBkJZCoPUarH4YlkhcLS4Pu5H80B1NvxlUSQG9dDi00qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft6Od8p0ANX2oApWgFowlGR1Whh8Q+RJw9WaW7gfgoE=;
 b=HXvYmljrUYH9O8M9lrDZx1BmC6ZbAwuIVcO84VzoXAxc3xxbQFMjgiBLmlyqDsyOFX/3azY5LM0tDl+Mf+fW59iy7xoDvr8EJUeJk7nc+I7FoDkgA/UAMame3hAhqS0ZwNK6BlcR67Sue9q9eoPHQiZoooFOyMbHhZTo4IFCAJxOpKIzTSZaanXk3jejETNcK+14HNHIlYjklkIQx/HKsr6n6aBvmdXvv2ffgoMOjac+lMkUhUMIRMQhYt4hc6YC85PLP/BNFroj04ucWWLOl0T65MOuocUPr8R8t+fSb93D8fXSwolXjr1E2JXr7J4LPrIEODfy0KehORgQ69ygpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB3601.jpnprd01.prod.outlook.com (2603:1096:604:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Mon, 16 Aug
 2021 20:58:30 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:58:30 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: [cip-dev] -stable-rc tests failing
Thread-Index: AQHXjnutwozlPbvn0kGggfTL9fZabatt8RzAgAPpxYCAA17qgIABZm9wgAAFPQA=
Date: Mon, 16 Aug 2021 20:58:29 +0000
Message-ID: 
 <OSZPR01MB68771A99C8228B8DD42D8679B7FD9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210811063943.GA23723@duo.ucw.cz>
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20210813194635.GB23237@duo.ucw.cz>
 <TYAPR01MB62529F6AAF0B05B25FD8DFB292FC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <169BE3F8982B564E.22901@lists.cip-project.org>
In-Reply-To: <169BE3F8982B564E.22901@lists.cip-project.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 699a25a1-5558-40f3-77eb-08d960f899f1
x-ms-traffictypediagnostic: OSAPR01MB3601:
x-microsoft-antispam-prvs: 
 <OSAPR01MB360150607C02A521A389FB0DB7FD9@OSAPR01MB3601.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 NcLuVU62tSYx5KzUBWI5BHRnRWAc+05vOq2i13FcIZV52gtPdz60IwKRmb5bDTwyQsdeX0p0iEPPCb4HH0PeSjx7sqRS01B8vJkfnQzMUS7dWTKq0aCLK08AWkcSbM4ntYH98EO6GaWhLVenvnq2UQrlF4COGb5JDIkhrqrA6aDa1mM5jt1hNcgPWBGqfM+ELOsLz1hJrlh+BtWYGfyeSJu68XMCwQyIrsozIkA7KmvEB6aDnq9qz6pDGb4QETNaTd4Xgs8Hjxx4YJgO6m/9iKrP5IRurhFYshcGJi+2BRkhzaaHJK6UJRfK6+NvonWZLayHdPextdRcyMP51FOtG/RUpcyCeZaC4hBvpLuu5JG5mCJAHvwaPAxwvrUje2IPhr0bzfcYeNe7HSvkl8TbX4LFryPgJYUHyPmKNhK+g/+CqmwGUEDmKQ7EYFb5LUmhfB+1z9mKiBv4atUdT8lOmKjA7/PbGLJD5C/d+s6+SIkBc5y2d0XCjwJS8vrfSzZ4RCR8FK9Lz8vN5Q314KQ0rWNMp13Nytjvdl8tWC6A7FEEol6PAl8f4/h0AP1CIA2v5t9DbaOQydD5yegBlUt7RbmPfK+kEPgnuS4HMdKSR/MBH3Dtc3uYMyF7vzjjDIkPEMnCmiD03pDnlXGbZMLTheQTk2QLMSROC5ltuS9BFKMH5e+yMeghYHhs3KWWkJN3ZeDsy497372B+7mvq4r6wQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?i6SYhVWyt74AFD78yKje89bF6l1cJOZ+bOAtqSzt/1QTFAsaqQ8gyZfV?=
 =?Windows-1252?Q?pH6K5e4rtD93uQ6NHhPdff7HbfcYboF/jJOG+5ryt1oSpef4rrTc3xD4?=
 =?Windows-1252?Q?3yRhTl7m2DmlccgmpO+VOWNcdtp//oGd0ig2HHF2zcykP1o1/KTP1/uY?=
 =?Windows-1252?Q?d/aZz9SRBXMYGUW4Hdb3oZsFv5Sb5e3O2w+1MOxEgJ2D6a1t50/oxfOI?=
 =?Windows-1252?Q?ykCBKAl+Xfu3mDUnB0CHuIbGQs59JJrxAt0UO1AcQlB5XSlJ+Y/cqsex?=
 =?Windows-1252?Q?mkIJHfUeOnYeUyrqJmkSeyAkGKTF5cpcv6q6KVXtTLZQCz28c+VAhVMy?=
 =?Windows-1252?Q?NmwKtQDq0Vvv5S/o5myOxT4jOzPRAH3lDaeSd5mRdN+hwLj1huhLjrKX?=
 =?Windows-1252?Q?4AKev9zkVghUPh95hnvq8S7eaov6C3YqUkar5SEAVEdehDgGyQqOy0eQ?=
 =?Windows-1252?Q?JthKFDgcAdzyxpXSw6WoZvOgObgE+uKLRlM3tz5OfaspgW+EPuyIN0Aq?=
 =?Windows-1252?Q?apMvQgHBf8ukS4KKcz6wwmwanNDmK3T+ONzPvwsZe8sDJROhoqiKUNSY?=
 =?Windows-1252?Q?CeQ0yxGtvqvv9Kshl8rruBgv67Ub9/9Ltz28hIj1kH+ng5SBwlENfi+W?=
 =?Windows-1252?Q?xNnSKWMnlOAy1QpXuCeBcHnAed7otoQqiFg804GwCvRmeoryNYT9L7E/?=
 =?Windows-1252?Q?MGNlc8FO5rzp5KVtG7begPC69AYtj4sKurbeIZ1gThXbxzDQKq2EeZBR?=
 =?Windows-1252?Q?gvHv80DaDYOb4emsjBCgIm7urNeEm3XRHEY8UiB6pI21Iq5B9jkE/TBQ?=
 =?Windows-1252?Q?Ya7PJBYQDyzPB1r+ckwkVLCioDamX+SkldrJBsOreB6WHUfi8W+yVVHC?=
 =?Windows-1252?Q?o4y3SpWvZsj7J305Otr/+w3R7+7k9+b/oFz5U9s98pnI8j7WnPRqEA+V?=
 =?Windows-1252?Q?LAPj8I6PwSg6UReB3rsCS75UWpEe+/7z7MkP5Qn8+14HZ4Tov4NFNt18?=
 =?Windows-1252?Q?cH4NfspXQ30H0mp8+8B43FCo1ZiDqXOEJGhsDb5zW31fw3rXqkIg7H5o?=
 =?Windows-1252?Q?n8PQwGhG4fbB1TGuL99QzRkBNdCLuurwNmu8FKz8J6VGzbJzmKiUrw1R?=
 =?Windows-1252?Q?TTADzyK9g4zWRCDSAsioa4zdUcNJ/GHmy2Oa5dRPPgqB9EXgcstZNENL?=
 =?Windows-1252?Q?RT/MuIQWxo0uttaDOJoYAmbgfTn59CjdgTXUqlozs9qIVRVpFHQn1tUU?=
 =?Windows-1252?Q?05dXGR2BffQeNuAs91NHbIDeNXt3VBmN6bjMIfeGJjGYvAyTE9oJHixe?=
 =?Windows-1252?Q?F9//PrAT3p6mgxPmLaCQ6EMoe22GoNEAWxSs40iWHrnPrcFbbEORv8Ww?=
 =?Windows-1252?Q?Ewnc5lJL8aDU+mC85gnE50FIF7+6q689gLuY8K3fo1EAxGp/2MFJZ3Ex?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699a25a1-5558-40f3-77eb-08d960f899f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 20:58:29.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2In8Als1hLbSxw5hN1wBrnzb/S1F1NmfqBWzDrAGFXeTCKNrAbFplZaCkbWgBeDMb3YeQ8EDHz9hK5hLLDlR9B7GLyIiVO60Ha6oEk8lNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3601
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gbpeBRDbCHraBhUWIJzx5A7kx4520388AA=
Content-Type: multipart/mixed; boundary="pj6JPGJgzIc7BYk7QPGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629147516;
 bh=D29MtRewPBM6sWcG/UkoKhNmBfF8Xdi+xhQ1CS/GE/U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=I4hnG3w9B77f6xQqBtjAS1OJ7bvA8SPaHY70XMEKWIVvy+tvsB+jAN76En4HLLT+GJc
 touelfeZyBWjPcUp8v9ext9cjPMJE56vr+iBT6oNCWlk2ZOCFQ+6CgtlKcYGEP8ozs3ir
 Cik+3mDgOoTC9cuwQojFJ5GdLKaOWO7OaAk=

--pj6JPGJgzIc7BYk7QPGA
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 16 August 2021 21:39
>=20
> Hello,

[...]

> > > But I still see problems with x86_qemu... the "2h timeout".
> >
> > QEMU's queue is full. And QEMU of each lab is not working and it seems
> > that it can not be processed correctly.
>=20
> All of the QEMU machines have somehow got stuck in the "reserved" state.
> I'm trying to fix it. Will update you asap.

I've got these devices un-stuck now by editing their state in the database =
directly.
However, in the process of debugging I rebooted the LAVA server instance, s=
o we'll now need to reboot the various labs, which is dependent on the loca=
l admins.
Hopefully normal service will be resumed soon.

Kind regards, Chris

>=20
> Chris
>=20
> >
> > Best regards,
> >   Nobuhiro

--pj6JPGJgzIc7BYk7QPGA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6681): https://lists.cip-project.org/g/cip-dev/message/=
6681
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pj6JPGJgzIc7BYk7QPGA--
