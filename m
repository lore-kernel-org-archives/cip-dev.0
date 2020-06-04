Return-Path: <SRS0=hZf4=7R=lists.cip-project.org=bounce+64572+4671+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0CC433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 02:18:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F47207D0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 02:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HP80KyPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F47207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4671+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OMc6YY4521723xpMUzeCq73y; Wed, 03 Jun 2020 19:18:48 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.54])
 by mx.groups.io with SMTP id smtpd.web10.5745.1591237127051942304
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 19:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcuYU7pNSakI3GoQ84QaNjmcF9sQ5E2TX+SFGDLY7xdYXhOVKlKoeKBA7YFL6XYqoejH5Dgtmtilab/vWVs4vZtagZ8LbOwSPu8mfj5t/dLOPskeTpqhof49EVFcABWHGzg3vihyqpFJgfGg3/5A6F3bgcR/Hc6wTJKrM009ExfAXgQlyDB2iQKi1YgSf7rZSDv2Tn92BWw4ZvBp5Jzl5ioX7eGJv2Iqx7MBzqIhigz7DwdoWhDtwX3mUPnHH7WifLWDYJ8P3hETKzxgSYRC87GVX5kA/vabV7Mh7MXBP1WLyoNft2cSb6XwqWbRoj56l7VQKrFj05ghE9KRtfTiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RIiyb0tRcGqTzdmDwXw3890I//t3s6DW8z1ezLxeGU=;
 b=Uugas3ZhHpl9tnxLRV8xZxSz6Wyh294F7RMmuSjOvdUOvZ9P28N7xiWSta3vOFEj4yiy9Ufbr12cJWSdTlkDOJsjtLSN8RZ4q6Xiym+kXtIT0rpdJNcnAhdMg73wFwNkoDKovW+kKbcBF1xDKhnexbd//bxjNvILztTNJiVYyiiloheiwRb1m1NQ5iDdet0vsULoPBhypP4NKP8GfOiK9KroY5Q3n/N3UnQlR7hASKp+TpKTw++zzftwIl+5BNPEmYnc7KhSX7uK5sdgB63t3AQRTHBuMn2nV/n3z+Rou9fd4uegOOiAFJvqqSaXWDRb8MoKsGYOxwbbxRAY552dCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3361.apcprd01.prod.exchangelabs.com
 (2603:1096:202:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 02:18:43 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 02:18:43 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: am33xx: Added macros for numeric pinmux addresses
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: am33xx: Added macros for
 numeric pinmux addresses
Thread-Index: AdY5jdtBYOtEcblRS1K1kelKMGMrcQALS+4AABagSYA=
Date: Thu, 4 Jun 2020 02:18:43 +0000
Message-ID: 
 <HK2PR01MB3281CFB804E62921FC4E34BFFA890@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB3281497DDEAFCA27D58CB642FA880@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200603152416.GB16550@amd>
In-Reply-To: <20200603152416.GB16550@amd>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7da02f30-3646-4bc7-d926-08d8082d9a89
x-ms-traffictypediagnostic: HK2PR01MB3361:
x-microsoft-antispam-prvs: 
 <HK2PR01MB33617D0AEE65C7624561DD94FA890@HK2PR01MB3361.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 JBrAMWPYYgKawDpXeMNfy4ZuyvmHxItes58VaZOXgLy5C5fo9pyql8wzB+GIrfV1Utvb4x/c5HUlZcoL8jzvl0mZpq/KnOJSHHBPX8hAkvJXBLbcpCok+kfBSK96SRRqN7g7GZxRWuuJ+1CcDgSYk+8et5nttkZ/5mKnN5x/DDeteBZRjRrz9EgffELqpTLOBpkTAgAAR9wCQGFqE6NLjfvfgHrX/WIAk3OFO3N8+7Ok3SM8m3RL8LmP6as/hTD3r2D+uQ19IAJyIMrVtDgXxDW6U5eUwMCrKD8Y/h4g1cZdIi6V6+wa3PLwy0iTq92npQ6HguG70CuHKAyFuwOm9g==
x-ms-exchange-antispam-messagedata: 
 BxoYpp5+xnTgFxFhtisXhPsyMdf+zHxzp7+U0f9wGonEMpH8wtKVNUcPVrqkgnd71nW4sFqy8WQYW+6JVtb1CEIhC6UZibwFC8iedDu4hi4kBC7xVUbGIMh1qoRSvtHMWwGPJz5kNBI7EQu4cbRZ08iJzGfsz+vs+OHy5TpBdXvADUWUJ0nfsxZJrJFLvmmQHulry6KHjS40BCjN5JyKdogdgHPBhMRF9ezP2znSlA/09tfaMItJ4PpTA440XghXeGAd+/FM4d9PJiD5CVXiMfVFkYMUYohNaW7Q04g8rKe09NfhpPXMuuc0n8Ie+uxupvv06GD1cXHIPjbZa2Yu8++Pnb3pkGefMkA5/m772BQRJMyi+rlGYAQb6XdW81RJPT2vfsH+vE4utBmunlOgue94iLSlEvdI+vPmMPRvd86iQvFhjem0urCrVCqaEYLDTUDaeKGiKu7/22heXrAQvaqIuxhlpTg4K5W5B+peTzo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da02f30-3646-4bc7-d926-08d8082d9a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 02:18:43.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mk+BX8J4MtZ4d06YOedrei9joR/sKMVJbH33wJ5WPMGEZFLAd7qEKfZ5SKkyGA7jX41SFWwAJedcTBkNXUpDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3361
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 40dFA83fIoeDL9Ulluz6kuHbx4520388AA=
Content-Type: multipart/mixed; boundary="Q3Zko3v2X9DUhSsj2Psc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591237128;
 bh=e4cC0sNXdV5bk26LIy1IpoJhlz9aU7zuJks0b8mg5A8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=HP80KyPyj4qV5z1pATsTk6AnIe+MOt/1o6CE4aOnN6vZoAECYZkzx4XI9ESQ+8RkrBi
 /KA+dj7nvp+QQaco2+EgPg07n5OlqFkiXOGRBVBH1S6Sidm0rZI4zBx73Z3fLta2R+p6V
 Yy66gMEywsQfmTYhOJkD1hNVXBOJNJ35pN4=

--Q3Zko3v2X9DUhSsj2Psc
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

> Hi!
>
> > From: Christina Quast <cquast@hanoverdisplays.com>
> >
> > commit 7ebd1ea798a4932231b18499df136fb552f6f648 upstream.
> >
> > The values are extraced from the "AM335x SitaraTM Processors
> Technical
> > Reference Manual", Section 9.3.1 CONTROL_MODULE Registers, based on
> the
> > file autogenerated by TI PinMux.
>
> I don't see anything wrong with the patch. OTOH I'd expect to see this in=
 a series with the code actually using these defines.
>
> Is there a reason to merge it on its own?

It sounds better to send a series with using these defines one time than se=
parating it with defines and using codes with two times.
I will send patch series later, thanks!

Best regards,
Johnson

>
> Best regards,
>                                                                 Pavel
>
> > Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>

--Q3Zko3v2X9DUhSsj2Psc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4671): https://lists.cip-project.org/g/cip-dev/message=
/4671
Mute This Topic: https://lists.cip-project.org/mt/74646578/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Q3Zko3v2X9DUhSsj2Psc--
