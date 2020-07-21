Return-Path: <SRS0=E0u1=BA=lists.cip-project.org=bounce+64572+4952+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFEDC433DF
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB8720702
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="g4DEJ5aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB8720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4952+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1FaCYY4521723x8xpy97R8J9; Tue, 21 Jul 2020 06:59:56 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.100])
 by mx.groups.io with SMTP id smtpd.web12.19291.1595339449030953717
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 06:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmvhosIpg2pwUlIqSVganRoX31YSOR9vmkRel4OhWihpoWMU0Wq4tfY94WkjiwCLgTdsd63mhaWdLKlfl7baFeCekOBRiXhYVbb8ClyYInDudGBg0I6+f7fJCf1mgU3rUyIAOEXsjlI07H26C1tJalQiMyJkxVBqu6Q4C62citi/ZIRnYl/kvitV/0HMsdpuMfwrPlgKTxHoZ772GRavDgJt3/wSJnrRJTVMFriOGCdlK+JAeJvr9oR2Z1JST20nAHBCePW5qxzX0boB0iUG+WX09u1SC8RS96ZOOZRn2L9jl98cu7ehQZpXKwBLclij7FikF1l7s6PkQhSZ1XuHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CEnM8XnYRUWYMOMCaHvu4YwaE2aiswhEhoFvHHXVw0=;
 b=IcAEqfQedkuFi0yKIGhI5FB+9l4oucxqJMppUKKkXCES9kCo2mzBv9gZbR5G9RcQcjVoagj+PBJqxim/eMzjSOUf1ayWcXceqvs90TCWon7LVYhkzttM63M/PsDhMrT2c6D2QsPBn5oFLnEhLx7G5uHlFdxf8meOyAE7I6jyd+Ddib5lEwQSFjYtqMXDVBo2Kr4nVFpSY99AKaEMjqOssShCUBkx5E+w68nBd6DIhoOhIiPRXVDmyb3FdqXGvcYJ3jJJ22CaUPYCwzW/YdcjDJUp/7Zh5eo8YXILyjj7qNTJSr4G81cSLeKSIShu5Z1XltFuDDT+/Mx8ZdfAbMVmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB3404.jpnprd01.prod.outlook.com
 (2603:1096:404:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 13:50:46 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 13:50:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Thread-Topic: [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional
 support for Renesas platforms
Thread-Index: AQHWXr8Oe1+8oPc+cE2rAWnENJSSjqkQ9AEAgAA+ZYCAANmygIAAAG8Q
Date: Tue, 21 Jul 2020 13:50:45 +0000
Message-ID: 
 <TYBPR01MB5309D9B125FDB604E5843A5086780@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
 <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
 <20200720210008.GB9879@amd>
 <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20200721134237.GA11801@amd>
In-Reply-To: <20200721134237.GA11801@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65e0ee61-4b30-40cc-55ed-08d82d7d1195
x-ms-traffictypediagnostic: TY2PR01MB3404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB3404DB7459F8E23DF34CC33286780@TY2PR01MB3404.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NCWiUEWNcLwX0szAky6uqHSkQRbDopN1ylHZ7+2eO2wE7BTNmE1bn50RkcpOI9uRVTRBSC/1a68NJ51Z2ev1DYJ9BprecHJbOLfloA0SeGDXuTT7+jV8m0vdcPgFktuEojKINPFOmdxgoBNnkc5mGCi2RI8XyHVN+nvu37bl6skcfmCHoQZHvGt0ORAAdS/6pIlP9Ulkr1pN6W3Z8+tOCC59B9xNTsY2P1PnQPcXXTUGyvFZLWOd+agotG77B+2kmcE4ols2WiXokRCoFpzDJLmA44NRDCbBW+gX49DpghrnW64CZytLCuh0EwyMXx10qo4lVJi/R+V0UbtcIps00w==
x-ms-exchange-antispam-messagedata: 
 MnpAhJHbVTyTHyXd6RlP1O1whQIKbTKKH3lCd27bPKVnVf2nRx6I9po52gnGxJVvdwCy+dlPUqhkEYock4L3Uk2gNoA0L9LzkrqqUHmsdi7dCeXsM0CasBJylijW+rbJcBlOGFMdHbjnJ2Z+a+8mGyZoj3TS7anVfxczbfaq8pxlssaq4mPmfxONSUUsX2ToNVF1lG7dW8Ch5E1mauUuTH2uQq7MNo8x+Vz4rhurq9LO28nnvjNnYGVi3AmmRBHmfGfUS2ee5SdEGbItyhtyvkDpmcoWoYpPvYUdT9nSBIE8pikhOoz4Ootgv9fBxnYgLh/94ZldOcLu4irsUX1hdGmK5thBDzFVChCnamwhdFfjHcrGdkhgizkqUtJxwIpPOa2Bl4rk6SI8vrmlf3ZTCVmT71KQ+22LLijAUzHK8RaZ2CkHm7FoXNFe1UMcwhGFbiYN6rVPv1Y/mN/xKkpc7idD4pkFBGrjp4tYJ5PbCww=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0ee61-4b30-40cc-55ed-08d82d7d1195
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 13:50:45.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiE48J8rTZPycnB+B8kzrhPKSo3mKjUHaDHYIGah98wKF3fVTl2Sc3GgH+MdrDRifevUM3ndBQ6qmflAI+KYDhnDW+leoquRhR6lVlddiaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3404
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6DU1s3dareLO1vDIh5Unab3kx4520388AA=
Content-Type: multipart/mixed; boundary="Te6M0DJG5nFnmH7SMRl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595339996;
 bh=cdhGReCoLVJFoYoK2sKUsxLPMj4YxZVmVK0jLf9GcNs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=g4DEJ5aQC4YpalEC8aNG2L8RbJg/1ImNRvTSq95AOFN7tFYJHPknHgFNX1tc0bpP/R5
 mDZ+yzlpAborocofsmqZunOyk/A5v64AmkUsMvV8mD8C5vRgYl/m/ZnglV0Rnw3zjlJBo
 mOXW352Vn6/w58Mo8KIcmMJoNLLy8//JdSM=

--Te6M0DJG5nFnmH7SMRl0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional
> support for Renesas platforms
>
> Hi!
>
> > > On Mon 2020-07-20 18:52:23, Biju Das wrote:
> > > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > commit bf9e333ec0d54f7428d9192ad403c3cb523584c7 upstream
> > > >
> > > > Increase build and test coverage by enabling support for more
> > > > hardware present on Renesas SoCs and boards:
> > > >   - R-Car CAN and CAN-FD controllers,
> > >
> > > Ok, I can apply this if there are no comments.
> >
> > Both patches seem to be okay to me.
> > I will push to repository if there is no problem in our test.
>
> I see it is already pushed, thank you!
>
> Biju, the first patch seems like a bugfix suitable for -stable. Can you s=
end it to
> Greg (etc) for inclusion?

Yes, Will do.

Regards,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--Te6M0DJG5nFnmH7SMRl0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4952): https://lists.cip-project.org/g/cip-dev/message=
/4952
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Te6M0DJG5nFnmH7SMRl0--
