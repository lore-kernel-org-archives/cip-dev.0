Return-Path: <SRS0=zvlI=6T=lists.cip-project.org=bounce+64572+4615+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B909C47254
	for <cip-dev@archiver.kernel.org>; Tue,  5 May 2020 11:08:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6827A206B8
	for <cip-dev@archiver.kernel.org>; Tue,  5 May 2020 11:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ENfudPXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4615+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DjiRYY4521723xJqwODk4tE0; Tue, 05 May 2020 04:08:49 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.70])
 by mx.groups.io with SMTP id smtpd.web12.5522.1588676928173133812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2020 04:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=didhhxQFjo1N70AtNd3q6wwJxkucj8kOld+/SSTi+UZqMWnXBOrtqLsSokLNtY1m4l8h4gAlVM3vZ2P35v4WDSHuuAOcUOrcATuTVJLF5QOKbWR5KVJmaS/706Ks9esIf+3qdJyg4N4uYl+wS3HVq8FbpKB3F6uiItHcteLrGkzyh28RFHxuhZVs0UxkkFgIt5cFZOc5NYunXFIWOQysQfD2DVNThAN2nj8pvLCX16DX9ZY3ner0q4YgGNPHLMndmGgsWtxUDlGh4fgpbArlOzcPc1isaIcaS7J5ylv0lQV8swKPofAcrSqphpFNQVQM3AZ/BclGrdnCcfIqRH6juA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ZaAMzxLGbAX5g6MDoWAa0PBiknuM4v3hEWWmqWa4Y=;
 b=ErM3uQiQtWTjPxmjYAP8BMei6X45csrupk+TIBf7u7H6GEDtj7kahyzYAfkVo9in4po3TFTyC9Yslmu4DKwl/cikOfwWI4AQhWgiq8PRDB0bJbLPeQhEIRVW2TQi30O5EEColzgxiXUtVEwYnt7nXicpV79d6P+zBE7c3J5wZunyTJC2JXpK4DxwfNEFkeVx9fe/j9dGRRUXIwFFZY66eN0FCDPCIsfPi7OUC13Esiin6Pjayrf65ftT1AqVGrNxQuwkJ9RF6nSNUV3Kyd9wg8wR1n9TCJu/h8q9ZA06qsCwNYHR3janaybULEhfceCs+nKgxoGL6oLGOqIMFv8CMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK0SPR01MB0013.apcprd01.prod.exchangelabs.com
 (2603:1096:203:7e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 5 May
 2020 11:08:38 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 11:08:39 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 1/3] PM / OPP: Add "opp-supported-hw" binding
Thread-Topic: [PATCH 4.4.y-cip 1/3] PM / OPP: Add "opp-supported-hw" binding
Thread-Index: AdYelkmhTIoqm5ktTaWUSfW6YJsImABA2aIAAMzUq6A=
Date: Tue, 5 May 2020 11:08:39 +0000
Message-ID: 
 <HK2PR01MB3281BBECDE660B7384454549FAA70@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB32812E5997579D3A664F3F45FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200501092000.GA11782@amd>
In-Reply-To: <20200501092000.GA11782@amd>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f021e96a-387a-4099-724d-08d7f0e4aa38
x-ms-traffictypediagnostic: HK0SPR01MB0013:
x-microsoft-antispam-prvs: 
 <HK0SPR01MB0013AFD8BF3C8EE65BBF104BFAA70@HK0SPR01MB0013.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yhFROvRN8Xf4uJ24dRj4aKItdrelu2iBaMn02cFJdaWEv+UDxBcuR9uwmwTNvJ3LBdh4wCYEPxLlNqMzj1Vv/BUD3awBEEn9e/7bpu7QAPs8HDs3JAg4ofqwZeCPhzrhTV2ZxGa98mLahHXQYOgqez/jmmFcS3MO6pHRalEUjjyHfoqG33bgoEd4NWTZj4ixsNwntq8MjC+G+3zgjDn4kjdGTXOOJcWaIi5ezoedo/Q65lOxNaZwUJkmofa97UYTe99O6q4H3piBMZ6VI4zCNiY49ZPPU8z7OXaIOdGlnQgAFDR6EPby2rFUxLpSfO0E5D+GybWCPeJIFYJIqm+joK03f4OFrBpjoVBkoE2APSPu91Emvf4zdohrd2OVSMjYD8BZdBLnzWWJs+tYGCcSMYYYjEvg1tWaB2sOS43gTbXNvHdQ3sAPvXKPgpTn0JYCwgcCscurDWYWH8AN1wcrIA0v2Ed1k0Xd6FAFJn6VZTBSUi6BtUf8LQMhM6JPguyT/A4BRUuvGWe+BClEm+/zDg==
x-ms-exchange-antispam-messagedata: 
 rTwQC2cSulNId3TXNG99f5R/0S0nex1ntTxezBbA786keidAi5QhLySmZEM3zfiSxayuWxzn+gfInk3WIAVu6P415ajKFPAxI2xjZI6mI5TYnhQEDFGYWRpU90Ho2Y/Gow2+LPNW4yykb2e4jlP3D2qTdkre6oxMFY7b80zwCAeHTRSk6xWSVzUSON5Wv9wuAgbPBCQdiYtoe/6RRwLWnsSUhlIMltTASo/0BEt3WPrQ6t6xt4e6Nwaa7P94pbRu7KG6CCCxwqfExR8CRHtLJl3bd062aPUg3ixgOZWvYtSp3NsFdZ2/7Zzg/Gtd8vhM75v3802SRRiTz88T3anrwUuxRbjEXA9QWSnUKG0ugtw2l72CV5KlRE6QjT614hq4XpyGCBRmCK37sd6YUryU/E8YOrNenO1UHS6ZtrTBuDDQev4G8hikMKu/PSOEO3aa/+u2zeHEI/N8evISWW6vqECvdoZ0JCJecpain6l2cGw5KhBFQvHYjVUa8ZVZpMWvMmkY5mr1mPfRaR3GxvN9MVR4bMHaAWraEUBARj3wYCprJRcvgcxDTZV5k+aKLgpolPn+G8LgHqRYkPjSh6SLyc5JtXMaJrPKboHu7BmgSh9454ZXEicX8rVsw9g7mvmu3fHpZHFqxe8gVH1Zi+soGd/v9xmlNhkWs3pmgslUyuBNMUST7poJqeVkBsHuex2fZ7OEFox9XVZKyA6Ip2CaFWOaqUcZ5YiMFjCmznRi9lJGLR6qne/PVJZDjeqmiQj20lCD1z6wQdt3WmRTEkjcszZNkqeMHzeiR7LKols0PNg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f021e96a-387a-4099-724d-08d7f0e4aa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 11:08:39.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9g3kZMgkfPNlqRbDjpl7BR9b1vas2/FPyA2Wgr90vGZurb05GZO8aO35nBCAM6zI0Z4kNOMhKFU10EoMmUggKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0SPR01MB0013
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CnHH5z4KPFL4y0hVNoki9T4Vx4520388AA=
Content-Type: multipart/mixed; boundary="FNhKCF8lDnzXnGY6ixLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588676929;
 bh=YrHo0cHJfexkGWQPydONdKoiKu8HzuYMUGbhq9/JnZY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ENfudPXyRMu1u2xkbMRa7gPdNEFtHxFb6D9wacHIgqkd8aYlnxjP8IjxwySaHuZscVc
 6mIiZ7VCNvfNMKzgzvsdgdtdnBvG876i3nQNsQk3HGI8cmoUQyEo3JresN/ERNLV6Nroj
 5cG6PG2Q2yV02BzBhRkcqWQYmw7EeAIhaZ8=

--FNhKCF8lDnzXnGY6ixLE
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi!
>
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > commit 1c4d12de2719dfdf27c6dab31e7a5641ee293c94 upstream
> >
> > We may want to enable only a subset of OPPs, from the bigger list of=20
> > OPPs, based on what version of the hardware we are running on. This=20
> > would enable us to not duplicate OPP tables for every version of the=20
> > hardware we support.
> >
> > To enable that, this patch defines a new property 'opp-supported-hw'.
> It
> > can support any number of hierarchy levels of the versions the
> hardware
> > follows. And based on the selected hardware versions, we can pick
> only
> > the relevant OPPs at runtime.
>
> Few typos mentioned below, but this should not block merge.
>
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt
> b/Documentation/devicetree/bindings/opp/opp.txt
> > index 0cb44dc21f97..d072fa0ffbd4 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -123,6 +123,26 @@ Optional properties:
> >  - opp-suspend: Marks the OPP to be used during device suspend. Only
> one OPP in
> >    the table should have this.
> >
> > +- opp-supported-hw: This enables us to select only a subset of OPPs
> from the
> > +  larger OPP table, based on what version of the hardware we are
> running on. We
> > +  still can't have multiple nodes with the same opp-hz value in OPP
> table.
> > +
> > +  It's an user defined array containing a hierarchy of hardware
> version numbers,
> > +  supported by the OPP. For example: a platform with hierarchy of
> three levels
> > +  of versions (A, B and C), this field should be like <X Y Z>,=20
> > + where
> X
> > +  corresponds to Version hierarchy A, Y corresponds to version
> hierarchy B and Z
>
> "Version->version".
>
> > +  corresponds to version hierarchy C.
> > +
> > +  Each level of hierarchy is represented by a 32 bit value, and so
> there can be
> > +  only 32 different supported version per hierarchy. i.e. 1 bit per
> version. A
>
> "supported versions".
>

"Version->version" and "supported versions" will be added in patch series v=
2.


> > +  value of 0xFFFFFFFF will enable the OPP for all versions for that
> hierarchy
> > +  level. And a value of 0x00000000 will disable the OPP completely,
> and so we
> > +  never want that to happen.
>
> > +  If 32 values aren't sufficient for a version hierarchy, than that
> version
> > +  hierarchy can be contained in multiple 32 bit values. i.e. <X Y
> > + Z1
> Z2> in the
> > +  above example, Z1 & Z2 refer to the version hierarchy Z.
>
> Above it claims that there can be only 32 versions, then it explains=20
> how to do more than 32 versions. Overall, I find this text rather=20
> confusing (concept is quite simple, but I'd not understand it without=20
> the example).
>

Me, too. It doesn't have example of multiple 32 bit values.
It seems to be used for hierarchy of three levels and 32bit of each level g=
enerally.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>

Best regards,
Johnson

--FNhKCF8lDnzXnGY6ixLE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4615): https://lists.cip-project.org/g/cip-dev/message=
/4615
Mute This Topic: https://lists.cip-project.org/mt/73369239/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--FNhKCF8lDnzXnGY6ixLE--
