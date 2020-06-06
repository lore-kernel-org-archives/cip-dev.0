Return-Path: <SRS0=yILX=7T=lists.cip-project.org=bounce+64572+4728+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61BC433DF
	for <cip-dev@archiver.kernel.org>; Sat,  6 Jun 2020 11:49:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD911206A2
	for <cip-dev@archiver.kernel.org>; Sat,  6 Jun 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ud4Szcjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD911206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4728+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K7OnYY4521723x4Z5A3LT8z6; Sat, 06 Jun 2020 04:49:12 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.58])
 by mx.groups.io with SMTP id smtpd.web12.8608.1591444151016601762
 for <cip-dev@lists.cip-project.org>;
 Sat, 06 Jun 2020 04:49:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJWLWFaap0ouzxV5KxXjmwZ2sp4A4hqan0GoyImC4eOFFJWDMnSxjLxxh2Qrw4AsZl9vv9onReVIrslL8IuemqUEFpyv6L1GOPpAJdT42bbVgH4U1WuNJJfnlMY9y6ELtUy/UEcfw2JetIykr4f/q5/t9Zfg3ofetxRSsL7DlaWl4q5NoBmjqIy5Da+yC5fTIRMP++swsM1+7Vq3KI7i5Bd0DJEMq/EzWIQvSn9R2RQAi4IHyj4CJgfyesi9vfI5+JS1A/Y8cu/dkcYmYUGYj7wsgp92REWVnNjBtwQqOAvTbUFyBt230nuDYAwJ3anPpnqrvyUBsBSuHPnWHHcNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMtlRCnAX2opcBmqy0Su2HE27IabpUxWBaUQDiZrKH0=;
 b=jRDpbMKU/g+x0lg2BKjXyLtX4CQecEvbSuYLhfDBgunfhh16+H2djeAmKUwqAiOZYQw92w4lmW0xf+kVvnXFamc2Vyxx5Vtom8HyCihIATsRnN3o1TWvey5mmTzqQYr+tBqZCbbpWuwB4KbfchclDWzCz9n8jsFkZUUjrB3DT3NX94lFxlUMXl/tjzigAjEcLcB5Yhx5ukxSo4uSYZ81ZK5llf8zfIn1l7sN7xX+sD1zKllNCLpdEEONi9O3ub8DiFd+GN26CZJ8tEycSswx17htsGrPLOGxm85/u+4CbxEH76pzuMHG7CyH4kdTVZysH2eDbCDmz19JnjBGeS6zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3107.apcprd01.prod.exchangelabs.com
 (2603:1096:202:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 11:49:07 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 11:49:07 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Thread-Topic: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT
 bindings for the eDMA3
Thread-Index: AdY7G8WKfCaPk2RlSCampVV/E3SVxAAYwyCAABv7wRA=
Date: Sat, 6 Jun 2020 11:49:07 +0000
Message-ID: 
 <HK2PR01MB3281A7EA2FB6A6F76A592234FA870@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB32816B8BCBF222E046FE5524FA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200605211813.GA8852@amd>
In-Reply-To: <20200605211813.GA8852@amd>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a99cbf-872c-4696-aee5-08d80a0f9e78
x-ms-traffictypediagnostic: HK2PR01MB3107:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3107C0833F9028312A9FAA4FFA870@HK2PR01MB3107.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 L7mOFloL85fqriGibxw+LjROV2FlJeVWAG/xWVNWmcOx/wLGL6dBNpVNE0qAKbU3nq+iRK4bjR5N6x+EQG7jbxuqE0FfUnd4Jay1OOn0TVQtf7bZLDhWf1m7jwqO+S+ADUQ11AZ7atYMRyDxlRCPlTfU7FlDJ0YqDbJa0+xy9tJbGem2qGTCc8EEZQM/F93MOZBIJRIZDQNGaQ9SkslDkaJo7bGqjUnAoaEF1OzQoDr3Bj+Ns1FrkDYJVmmpJdJz84wkkzBQypCLPGnTYbaZQUWlkrfn3s6eCzd7uP6xBhagDjFY31LiuQwpBnkQZSDgkxPhmC+zOBDjw88Iqv9kfw==
x-ms-exchange-antispam-messagedata: 
 TdUhJ9ig4qIoG8XKpxh/8gSYQ3qkdh/zOU9QpN+UlogRoWNKRW4JUlkLcHI8aoFo3dWFYZsQaRT8XkclssD13BCJwQ2sLR96AVp7pd40/fFD6ioQTeFFD2i4tGcKBtre+LytRA6D4BQ9ymzFcabgdNIS9dmiFseXejx8lTExIvh8c3ok+IvsSGodyrP6yG+fQv8ikEYRdsteb0ZaeJFukVF0zxZIcmxmjvshFQzwbJLRTUFAa7zxNnUxh9243ZcUdk4jezkHQccWpz0G8MtkVsqYtacgZryrroZAKkw/mCn+CR+qBkMSrPc10fhK8a85Eyw7GWuXVqAHGjmT7jAXVPmKOUrDRyRK3/Yghkn95z0eXDUxgPnrp6F6oXp3w1ZIsGlzRoatDc1kBGZX95jrfrXTKQ4qvSipEfQh4J3hfdyqWA+fJ0ZXzUSqrVeXkLhxmfGg0Aq7GyU9Nx42iLRX9HOfcO+ze2BdFj2cCEwJwZ0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a99cbf-872c-4696-aee5-08d80a0f9e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2020 11:49:07.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClSR2PXCFZOE7jCSw6fjyLKKs0oLNy1hoIRfl4nogNRfT9Tk0bCTSuf8F/nNTuNNyH179+c/l/CdVHmC++d6PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3107
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZdVsoPOyVfcCOaFCYhw4ISAhx4520388AA=
Content-Type: multipart/mixed; boundary="HK1pru3xg4l0rWOopi0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591444152;
 bh=KTcWSM7lnjv++j/3cf48EWmEescVcreijJdjanDf/8s=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ud4SzcjcTl3K7OwAFbgnOYxtUI3hkljHfwss/wtR4T7ERZUSjn0Nt6RN7QgTO+U9DoG
 voaLzF+3TaA3uQdWXA+91S3vqZi5mtzBaUFscQoWL0q64tgLlXcugTlkzxTK8/4qrAddY
 +PZEytdtL1A4nvBCG+QpJH8Dd6PySo3ShKY=

--HK1pru3xg4l0rWOopi0x
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello,

> Hi!
>
> > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> > commit b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5 upstream.
>
> I get quite a lot of complains here, if I try to apply patch automaticall=
y using git-am.
>
> Applying: ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
> .git/rebase-apply/patch:17: trailing whitespace.
>         dmas =3D <&edma_xbar 12 0 1
> .git/rebase-apply/patch:18: trailing whitespace.
>                 &edma_xbar 13 0 2>;
> .git/rebase-apply/patch:58: trailing whitespace.
>         dmas =3D <&edma_xbar 12 0 1
> .git/rebase-apply/patch:59: trailing whitespace.
>                 &edma_xbar 13 0 2>;
> .git/rebase-apply/patch:71: trailing whitespace.
>                                 edma_xbar: dma-router@f90 {
> error: patch failed: arch/arm/boot/dts/am335x-evm.dts:743
> error: arch/arm/boot/dts/am335x-evm.dts: patch does not apply
> error: patch failed: arch/arm/boot/dts/am335x-pepper.dts:339
> error: arch/arm/boot/dts/am335x-pepper.dts: patch does not apply
> error: patch failed: arch/arm/boot/dts/am33xx.dtsi:162
> error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply Patch=20
> failed at 0001 ARM: DTS: am33xx: Use the new DT bindings for the
> eDMA3
> The copy of the patch that failed is found in: .git/rebase-apply/patch Wh=
en you have resolved this problem, run "git am --continue".
>
> And it seems to me problem is in CR/LF line endings in the patch:
>
> pavel@amd:~/cip/k$ file .git/rebase-apply/patch
> .git/rebase-apply/patch: unified diff output, ASCII text, with CRLF=20
> line terminators
>
> I believe I could somehow convince git to apply it, anyway; or maybe to c=
herry-pick commits from mainline, but... Could I ask for a patch series tha=
t can be applied using git am?
>

Thanks your respone!

I am sorry about this problem. I find the same failed situations with my lo=
cal part. This problem is similar to commit patch again, but I can copy thi=
s problem with editor's operation with Windows.

I apologize for your inconvenience, could I re-send correct patch series ag=
ain? So many thanks!

> Thanks and best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>

Best regards,
Johnson

--HK1pru3xg4l0rWOopi0x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4728): https://lists.cip-project.org/g/cip-dev/message=
/4728
Mute This Topic: https://lists.cip-project.org/mt/74689397/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--HK1pru3xg4l0rWOopi0x--
