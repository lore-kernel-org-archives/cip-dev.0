Return-Path: <SRS0=kG+Y=GB=lists.cip-project.org=bounce+64572+5980+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78BAC433DB
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 21:27:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23330221F8
	for <cip-dev@archiver.kernel.org>; Tue, 29 Dec 2020 21:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23330221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5980+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V9NwYY4521723xSFrv79WcT4; Tue, 29 Dec 2020 13:27:16 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.113])
 by mx.groups.io with SMTP id smtpd.web08.18255.1609277232189072518
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Dec 2020 13:27:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIpDgp5I6+Ei1v67YLK9vgvwO56wTB8Lw4huUFOIEfWUMN14tKyzWsWtLUwKoPsKgCVhotZE10L8vIVudhr27jZbapAy1wTYkjKTxaZ6FGE14fx0TfnnEtosTNP/ZfqadTmqyREmOvN2JkykEBcF+tu5nmE0q0j4XQHoZ+oQ86sJVBflzghKQv0ceVaxuYHDWTk6rkFe+Cv2tvVlFrDvrNjRtc1YogOwqMn3uwOol07ThqEeSaB8S51paFPoqwWFQRG2JYFMsqK8v2QG35XfYB0jTBfIgJwSYL5i3k2jVPbtfkeI10vDSSe9Bskk+K9E3ay3kApmfZvkEPV3BiADwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bcub+ieUfSR95HwLuu+rOm6zYzoQp3+u6DNKQ7VBGg=;
 b=miA2Plseo172yzwHgx7RX2xFVzc7/ncuZCv6lobW/wwS/USkkqEKlfCaGp/twR2a88jF3bHK4dtkzIiRkKPfav4Y8MQdhDYHeAKdDc6pJtkjHci3pAOogsznB9GorSarcqRHvLBV/vGBqzV70mx87r9EgYFcd6bGoYdPIhtlpuqimHOBsGZaUhBKyNdt/8QpzFQIHwA0Nc52T/nYkHnAWcnczHb58NyyADetIDK3fVfx/Rda5sEbhBHid+6L3Lp4tqGhF/nt9JY7B33j5LxYTWPFk80qZpV6YsuK+9ZblOw+R0CU9SXbO+jjvlsKxIv9LyrM3I2U6uBLbfj2j29hWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB5176.jpnprd01.prod.outlook.com (2603:1096:604:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 29 Dec
 2020 21:27:08 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b%5]) with mapi id 15.20.3721.020; Tue, 29 Dec 2020
 21:27:08 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Testing of -stable-rc fails completely
Thread-Topic: Testing of -stable-rc fails completely
Thread-Index: AQHW3cAqGx2BtgYAFUK+ZC9Y19q8n6oOjelA
Date: Tue, 29 Dec 2020 21:27:08 +0000
Message-ID: 
 <OSAPR01MB23857C22D82B59C59F0AD25BB7D80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20201229085357.GA17217@amd>
In-Reply-To: <20201229085357.GA17217@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.164.55.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bec5f7f-0b8e-47b1-76b3-08d8ac407f34
x-ms-traffictypediagnostic: OSBPR01MB5176:
x-microsoft-antispam-prvs: 
 <OSBPR01MB5176EABA47C5A54018090D71B7D80@OSBPR01MB5176.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 /Xbbtj/yW7tlLDdryojsijnZEUoP30F5+eEPYR/MRJ9XCeJXzl0KOFHhEToV/hvG6sWzKYp+Ea6EcEIDq05UQIA5swNGktl2kB5s+gKJwdQvV+tUg5/5HINpt1WmmTl4UF5BWwW8JwwANdBbfKfd/eMIy2pnH92JlzQMgqvJDoUN/duDLRqP+DWPNzHuWG2mH94qjNKZjVYl1SiQOuXSgwGhwUa5bWqWGqm1PB2r4v+YozUQ/5T0Ezr3+gPW8dRRAQ4L3bNYIsIsRuurWQkRjBIgW0fVVveSCpejGHDVlg7qw2FGYzAFldxsQvrO4jiB9bRVnjirbdU7K+5OBBA+3ev98JT89YJtmX2SX6hrjVRidcqVFGLQxj30MX2rUoHGyRuHlDYakmYrpHHAFcMZJGSTa1y4ivGzp8WBo55NTFhgBbMIuUCgGDXgDlh4cnfERQZOi+xVp4MQNjuUyjEe2Q==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?DY22WIWWXhrc4/2n5eUq9AHOBFz/Nh47h/y0wipiujR+C+WQ83jf2jvI?=
 =?Windows-1252?Q?K0t6wky43sjmNKx+saFk62jA7ihAfY0JL6zUecc4OfKWS2rdrXiCdUiF?=
 =?Windows-1252?Q?LjtUI7YF5jRsPHSCgWV+tzNMLZFTin2+9t69rRbJqO5OdqlR5RLf/JhL?=
 =?Windows-1252?Q?VUHEJKjCHHV07Uzovkd+Q4uUKUxSEftNsK0mFZXxctC/+nUhc9CmFVPQ?=
 =?Windows-1252?Q?cWRq7U++KykAljC7uvd29IsOwswtgVcNw+qCclh2AZjS2VZZtfjXQqhJ?=
 =?Windows-1252?Q?Fm1MgS6r7YZu11KKhTsx4/AczzyhgT7OkhA5F9BaGPuTpN1weScCix+J?=
 =?Windows-1252?Q?KHHE+IWJpLHBn7HX6DOGiKQ02kXFCh1sYTkVQbLLE61Kvhbc24SQ5nOD?=
 =?Windows-1252?Q?IFlLnYvUn+OdsaHGxn1RN5yYVKYYrd89AHZoOiBklrGo964DvpjzVtyH?=
 =?Windows-1252?Q?3JhIPbucFuXqUZJ3HFJ/KxbEcCM9Hrwgo1L4C1NC9unsSjEBFMhJZwcY?=
 =?Windows-1252?Q?5novVyla/fUYlRnYn0aCc88KB+teCyoOk80FthxNBd2yCKJc43lvzP1Q?=
 =?Windows-1252?Q?ttMuC6OgAiQ+m+X+IxNQ9qI3MrJpJnJgZ5VjjsmST7I5hCBRyAVdmbpT?=
 =?Windows-1252?Q?e5mLpp9aVUh4lZJDer9RGMThPo6smw8M2+54ifDPGpQ+9nSYpSyF9f9p?=
 =?Windows-1252?Q?7uHtmkJMKpXvBco/RqCr4uazQ8wuSrcfUAqoIlJhShbDrurTFGXAwg3Z?=
 =?Windows-1252?Q?AEq3448FtGgfNPSU5cD0BmC3jwmj4jkjI+ln1XU59omQ7XDiyaaO/1W5?=
 =?Windows-1252?Q?0sOo4bb0kXrZUvl5Y/sP0Q5YSwDBApz6BduuVCIuRzh3cwPUs9s07SKt?=
 =?Windows-1252?Q?yhvmuWd4LfH7NyNQJZ+zlB53DLvdsh/cI7OUYkIeWrBoiq2XKyTAoeFw?=
 =?Windows-1252?Q?G6ZPMrlgff9SXYEcMVwVT1/AlaqBVQC1euWXvwbcTG6heGD22AhHt0Ko?=
 =?Windows-1252?Q?31IVqZMplRvJ125yJJi0ua93ww9xylspYvPCnk3Xizj1nh0NjMA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec5f7f-0b8e-47b1-76b3-08d8ac407f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 21:27:08.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfMO96Juoi/NI4gDCK3xCNrylqiGENkym+7tFi9nYEKhTOr+A7OKmEBbXICINYD48UIdhxi7Ot2nKxxJsTZQSOyGz/cuzbFqMaNVl2p5N24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5176
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Vx98AFWyyYQmzqebWNupbD7Ox4520388AA=
Content-Type: multipart/mixed; boundary="8EsXq6dmAxFdmXcfHfuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609277236;
 bh=tx+9NEt0nQn7hwEp9Ty2cuz4B7mE5o15j1Uc2z7PfrU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=f8V6sf1Hr+FEfKrvWQsf8RZAL93KahwNiLas6MTwk5ZIWuvMsQvF0+RPd6oC01dShq6
 lPYQaNxpl4foZdnLVEJzdKbAQ/hTtaIsUeSpF1g4hrFKKsmR/AidevlyxWLEJTixqWvEa
 0raIkzrbHKgcPfinfhvro1z5tcaxEm4AvGQ=

--8EsXq6dmAxFdmXcfHfuq
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 29 December 2020 08:54
>
> *** gpg4o | The signature of this email could not be verified because the
> following public key is missing. Click here to search and import the key
> 30E7F06A95DBFAF2 ***
>
> Hi!
>
> It seems -stable-rc tests are now failing completely in "cloning
> repository" phase:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/934209886
>
> Skipping Git submodules setup
> 99
> $ echo "Cloning linux-stable-rc" # collapsed multi-line command
> 00:30
> 100Cloning linux-stable-rc
> 101fatal: repository '.' does not exist
> 102fatal: repository '.' does not exist
> 103fatal: repository '.' does not exist
> 106
> Uploading artifacts...
> 00:00
> 107WARNING: output: no matching files
>
> Any ideas?

Thank you for reporting.
I had a typo in my latest change to the CI pipeline ?
I've fixed this now and the latest builds are going through now.

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

--8EsXq6dmAxFdmXcfHfuq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5980): https://lists.cip-project.org/g/cip-dev/message=
/5980
Mute This Topic: https://lists.cip-project.org/mt/79287435/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8EsXq6dmAxFdmXcfHfuq--
