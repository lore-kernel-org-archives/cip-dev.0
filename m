Return-Path: <SRS0=2i85=DT=lists.cip-project.org=bounce+64572+5519+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC11BC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 11:50:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40CB208D5
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ijKOe212"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40CB208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5519+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8bGoYY4521723xLZPibcwTyM; Mon, 12 Oct 2020 04:50:11 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.115])
 by mx.groups.io with SMTP id smtpd.web12.38935.1602503410045646051
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 04:50:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=entCeLpq272IyqbcW8jzg1iyZSIlFxaAZMNyvG0nwDWXNXlALGUvLn+i0Ly93WU2OVgXz8ig1nITbXlAhzry2AMgTdBQ/ZetXGYac6X8u0aKqqhN3reiteJVjzo2KAJ5cnZ3XZm/H00EV91tM4+ZwZXLar5fjfk4aSNktEecXH8rf7OM68FDsQHu5GtWhPP/aFhVNlzG3KnoMfRbIURIYn/Rk1wAH53EAXVOhuPLaGMcihksDF0t5emqjUph+MM8ozhUlirqmk1GGw+sOmQ67QMAUb9KFoJ62M5k5KsEk8ypTti5TOlM4oz+VYMLqwjwJJzZTeor8Oy+pNvqbLvUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqfwHkJswU6sfjHF3jdearBIDspI7kCr0AqRA+IkCi4=;
 b=AVz9Lnm7tt2eoNOfQJSShHfiywEzfp5zIE0gdoL0pVvcB2CISzUwdtfjdLxu0cWONfb9U64QfTbe1PlWBz7/eiLEqkcqYbLKccDqM3dJYAhhBbLRet5Hd096mHvBotS0lMUR4j3V2gpp6oEES1i0GvgcGT5MzZ59s6aOuk2a4WMtNYt/odgpd3V79ougGh7sY18jOeExrvZYEo6Dij2UCzk/lXaRtjztcUsM+OPYJK51qZ+z2b/3fx10BBTQFtgE8jbD2KM97qLyW9YY2+BnSLNOA6BUx8MqxK1Dw6Ma/erdE8PLRdqO1DEsJBXCmG4NFoWcxKaNiXPlenMTFw+3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB4645.jpnprd01.prod.outlook.com (2603:1096:604:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 11:50:05 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6d93:a69d:8f48:6dc4]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6d93:a69d:8f48:6dc4%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 11:50:05 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Harald Seiler <hws@denx.de>, Hiraku Toyooka
	<hiraku.toyooka@cybertrust.co.jp>, "Gumansingh, Smita"
	<Smita_Gumansingh@mentor.com>
Subject: [cip-dev] LAVA infrastructure: Planned maintenance
Thread-Topic: LAVA infrastructure: Planned maintenance
Thread-Index: AdagjP2fqXG+9YX0SMmmd/ymZHewow==
Date: Mon, 12 Oct 2020 11:50:05 +0000
Message-ID: 
 <OSAPR01MB238551759AA7B06001357642B7070@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.164.44.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac6636bd-a8d9-4e79-5750-08d86ea4f605
x-ms-traffictypediagnostic: OSBPR01MB4645:
x-microsoft-antispam-prvs: 
 <OSBPR01MB464514B9CC9A920D5760CF0DB7070@OSBPR01MB4645.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 wDoIJlIfEdR624hieGwLYjmRnPwSX/aS2Xm4jhX8FyVPlgFfPW5G3p2cA1AgtCuxQlzDHVVQSY07zGMMS/N4jQGLzakavhcotHHgvw3eAa6DRFeUvfquTpF3AzqURUIMQ4R4cdzfPdU29/AsqMEn2D2SZRTxD/qSWRYtoGtU56CgL2ezwmXdbIjiPc6pjCD+cqM5Df3yPngok5RKPO2vkuK+fAi4ESurMQFOsO+cLxbrii2EcZ9bRWbUbg6kXOsnxoyJh9FeB5Ki5z4Hmq3tfFYpV7lNpJhkIKE9UHIa8muE7vtfVCd65plGM+ZwyXIv9z+pZTjiAYXaB4NX+u4dMw==
x-ms-exchange-antispam-messagedata: 
 F5epRWSlLaANnQRqcvglMcxc8pzBf1qOYYJYs5GBGmLGblNu1T5V2llqiTj0+EoGOHfffZaaTIyfpJwUDcMTku55Bk8xUW1g1M+s2zR1hjTTJRAQi9mq9g9XVI9aHvTUodPr8P1mrAI/d9EXanS57j1xXJSOuHLRLIaXxE6tHwGKP0EDa6/8xXlXFeyNGEaX86xH0n4dntY8o70htRAO4uKlmh7g3F3yyYGFQ3wEd7e/IpaoVV9YetKVmld21+kh9lK6Q9AgndyQRDysUPNjPmnWXSmIUm4/+ZkWw9PsUR+kAwaJAKhYS1KiWUyaT/oRjNybflhoBQuV8xe/jkXZ0OGuaNtTbOIa+jSAqyOoYnZnGZXfzxsZbUuQgqVUsd8z1jLG0WhJAkb5E40xlsdeV70yllpJqeY7tTFKt5UOy8rATUrDcX0Wri9LVNtjbGxL7MDW18AW4ySm3Qrt7uihzK1Znb/APIbNW2lfGWHC3Z2QEU29RlShxYVRh5M+xAm2vZqIlPZm/wef9Ch6N4EleBZCZxpFd8d5Mt6V3ANueT9cq2JfEQ+vC0lqFjC7q16pceTT6VAMYJQ5X7/U/2NWQhEFVWLTAV9xawASRwOp7Gj5bcrgNR3bpq2kOyKKsuuLS1V7hpQ5nS7ZSgCR/TP2mg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6636bd-a8d9-4e79-5750-08d86ea4f605
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 11:50:05.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoPpS6v9xk9jOXNI287m5EaBXIanFS+axP4nJwF9XrlkJifbsFy+GFQrlWnbj+UmSGQeFoO3lxsmPVUZbfq+jo/8O08oyOtnYtsieo5BBs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4645
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hAKvoFmg2J7mmrllTHJvCOvZx4520388AA=
Content-Type: multipart/mixed; boundary="0mUKZdXk3CJDzn1Rvzuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602503411;
 bh=+JuF9x+xx4xiaQekxR0SjRK9YKa7QTde+WTcI7t2L7o=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ijKOe212MHWCb4TvEq3Y6gY017j7wOL+8xfPX7hm7HJrHWR9EtQV2MAJgp7o8wlUdPB
 XG5N/IOFIOceuutbWExN841J9WbvO8EhnOmblZ9gm8ed1yGJjP7FVkhQFonHtqTzROXJO
 EerGFZcqUmQN8JsOXLGZZDnX6uCsUeBX+iY=

--0mUKZdXk3CJDzn1Rvzuc
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

Just a heads up that the CIP LAVA infrastructure will be offline for a coup=
le of hours (maybe less, maybe more) on Wednesday 14th from about 0700 UTC.

We're going to be upgrading to the latest version of lava-docker on the mas=
ter and workers.

If the downtime at that time is going to cause any headaches please let me =
know, preferably before Wednesday...

Kind regards, Chris


--0mUKZdXk3CJDzn1Rvzuc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5519): https://lists.cip-project.org/g/cip-dev/message=
/5519
Mute This Topic: https://lists.cip-project.org/mt/77458577/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0mUKZdXk3CJDzn1Rvzuc--
