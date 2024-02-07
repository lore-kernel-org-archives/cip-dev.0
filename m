Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1F3C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:45:02 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.64])
 by mx.groups.io with SMTP id smtpd.web11.4415.1707345897303410445
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 14:44:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=U16aaK0a;
 spf=pass (domain: renesas.com, ip: 40.107.114.64, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+j/BoZ4Tm+l5a3CJWf8S3xyC9J9xSKdmP2mazhYMHbxNkwunDOEw+hZSmIA7QtHyG6BgzNJWSh9kgndjzePb8bU2/8eiSeSnaVhcBdHUHUacm3zo9pxOpknPp5DP01VM0SelUCZIDsxn2CVA/YXMMLCkxg4jgB3s0dyOUx/OgNrSgYZbBA4O0LT/hfJvYsLNl6SuwkBAt8jlLvpqtUi1KB/QAm23vBo6MgZwkXFG080w0w1EE5zvctJSWLOSf9JbLKw5RXmkqn8K5lRyHbfYCIpcjK1njgAhq1Bof1xTIvIrlOE4ohZ5v3ex4/ZMWO3KDuU7fmpZMrsamTQpDZqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtynLpYYWjw/x9Q+zUORLih+nwOKxrJ02kyV145s+74=;
 b=bRK76yA4EsuTn9eF7nFd+kkadvnir8KbB2BsmzPTUb1RxIpeaMxQUdLIuvIFd0LehCxc717ZeEtWGMCGWd9MOlQRFA5sN7UaGzO89eBGyX3K4os96VfQLLLpMtcK9NDJBL2QvfJsote80f0EVU+jMK2wxbe4kGc8AibriEBlSy2S1p+AjdwevRFd3sXK/HU2cgGClNTZyUq/yXVOmjlOgt6YioGRKbfpob/rb4lRqfExWH9/OcHM4oU8UgJZOl4wXyj3W5kA9K43fEJjrLaSWIOZEU8Bun/jZlsrnRvxZA/2xZE+yJBS0289eV/B2jOFgdyO1bPN2XKWHQGu7SRkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtynLpYYWjw/x9Q+zUORLih+nwOKxrJ02kyV145s+74=;
 b=U16aaK0aeB434CeI9VRQqna4qIKDSSaS8pVjynklqLvRbyvwQm2ORT+zQin5iVztOXUYJinbrXb050L2wRAQVnvt5yAtbxhrDh4O5K4WEKVnrRVDgNIGvooEMaaloz5pyd1idocMEU5uOlQMNtjkbtUFgvzZbFn9DyGc5BvtF/Y=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB11988.jpnprd01.prod.outlook.com (2603:1096:400:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 22:44:53 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.039; Wed, 7 Feb 2024
 22:44:53 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [ANNOUNCE] 5.10.209-cip44
Thread-Topic: [ANNOUNCE] 5.10.209-cip44
Thread-Index: AQHaWDnEKtUuGbAoE0aIef64t29+crD/fYgA
Date: Wed, 7 Feb 2024 22:44:53 +0000
Message-ID: 
 <TYWPR01MB11862333D0062C32F655DB570B7452@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZcDmwxtTFhDKprTI@duo.ucw.cz>
In-Reply-To: <ZcDmwxtTFhDKprTI@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB11988:EE_
x-ms-office365-filtering-correlation-id: 56cb56d1-4a84-4b7e-6550-08dc282e66d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2xWVH0uqiPZZYqitS7RxG7/YUOWxAJw/jVNI8toaJoWatcM94F4Ui0IYGU8ok6I+OnL36+QKXm6fRoNWsn7vFovCY24wGe9AYhIDtl52MdJhyUDOIUk61cOArGLcj35F56PFCI3sc7rNUCCgFQIiODFKqg9Ya/DmaKzAFfcn1WzwtfhSwRNo0sQKTiBrZhzZxu3WQumANpAF8T72wUlc800E9oUG5+OM59vlGAVU8AQ+GKo+92vnL0ITEV1ok1myYkvnGpqokkk8W+Hzl3r0iIez62z1QloX8EhsNHAQD4Kf4CyLuuruMLSjLgIWnmh4NeYdl4rmQoIgvG6s8An/UXo+wEX3RL2kGuA9Mb1sR1As7tzy6q0pf9vxAdQFmVP6ReV8T3pWoeCFvH8YOqM4uxG46Xr4nHb+YOpZKdI7fw2uStNTwn85oA6UOIg3hr4w2J/9tQHO2v/QnIDCHz42Xd2gG+G1DYXJ7I6KQQpmn9MmQht2tMV7ZcDwxVPvaw8TgXeFrf0t1l6qlmIC1Yb4m3ro4yzwSDx/Kf8zmDjO8PDtFu/KWkbRo8DerNvys1rFSMuPWZRhNJT4LNXev9ZoO5R+Zfq4Qe4dkrHjOOpXvTg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(38100700002)(55016003)(84970400001)(122000001)(41300700001)(966005)(478600001)(110136005)(2906002)(76116006)(66476007)(64756008)(38070700009)(316002)(66446008)(66556008)(66946007)(71200400001)(9686003)(33656002)(6506007)(7696005)(8936002)(8676002)(86362001)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Gt4ZjtGe6q6h8d/qrk2CGFOCeGELfqfMb/d+InsHhhPYlie6EJz2DOsN?=
 =?Windows-1252?Q?8zzwgvi6V4jsaOYLXlwBYs+x2KUp6oQu3YjpCWtK8Mzc2hcrY9SLkxqj?=
 =?Windows-1252?Q?qKMol1dJnNGFE0B4f73VSp4XWOHYAFewtKETtYxOYxzUEPrqFAj62yVu?=
 =?Windows-1252?Q?4yRZm/QYWMdEa2i9QD7vUd3Q8sAP1b4Ctuu+Z3Co5M4eP6Yu2htuorwB?=
 =?Windows-1252?Q?vpXcaOvQJ2ZmKFMuB27a9itFngqTEMLT9dLIsqxa48WJGKybZ2+DNbOt?=
 =?Windows-1252?Q?lL9Us3BzMl5jrksUodJYVrBDuuMZO1xcqFxp0m04gDMcpdfwDU/TydUH?=
 =?Windows-1252?Q?8Ukq7nC2J86fwPFZmTk4CWVgXNEnVXF88ygwqMXI9A7O7ZGlWk9cv144?=
 =?Windows-1252?Q?Q/50QjWm3sPghm/tWSYz0Z7DQ2YqatN/LAzKvlGr1e6D8jxMBRgzuwFa?=
 =?Windows-1252?Q?1kk681iZvPS5Xj1J2mylniwIUgqYb85qtcFbs1cYDFEu5MvTgkMCxIk5?=
 =?Windows-1252?Q?E7r7duhUANgOGgO3OaKOMu0dvHwiiivwmILEU07F+tWb+DfD/asV0pLR?=
 =?Windows-1252?Q?W8s5OCQsGodYIgqh+JgAnoc991gr65EA1Gqm/gPWEHEpw5SN/FvqcKpN?=
 =?Windows-1252?Q?wXp5yLSODnc8XqgosuMxUqNZjLiAlg1OM3eACIGo51hTXQrs/aQMQEUk?=
 =?Windows-1252?Q?8J/6HfmlBIlYpamMWn6yxdt72dEzFG40SmMFL+VLYMAQsFW23IUTeDjL?=
 =?Windows-1252?Q?dBBqLf3vCOCfVu4o4ju8wNrHM+uviz8olNJBQNnhVJMvgckKh2iG/bGA?=
 =?Windows-1252?Q?PTjzwNdzFMOYQ91GA9CFqRTq2cJw6UDnQ/ybjxAlqh5zgRugBDJIL8dw?=
 =?Windows-1252?Q?nCS1x8MyI+BUq1UarPfeiTLnWLkHqdebYpmkd6PdjDCe0QlF7Gu3TnkT?=
 =?Windows-1252?Q?vmzt19bEWflyfSs6wMZZdsirIsFUR7/y5G3dhATIS4AOUul5JxeD/r87?=
 =?Windows-1252?Q?WlT5n8iQ4I5u9zFqvIfESPa7P3t0eUqjaSqFIBfqzE/b6Eq6ozewzuOI?=
 =?Windows-1252?Q?rHhJF2puZrPe4wcIyix8jLyglkQnzILk8WHv4HswRTfPuYCPnvNlOTxs?=
 =?Windows-1252?Q?2+PNmntgiyPDSNbf5B1Pg4GVBcRCbtlty1ddhPrj8f36iBehpW9W4ILX?=
 =?Windows-1252?Q?tJ70suRxZM0hw8b1R60QgCjGAqBLpJSCnPw8+/tt4SjaYnJvLRIa6TEg?=
 =?Windows-1252?Q?UesB0Zc604v6yR1WrJ3RgA4twpaD0LW97MDjpRWhXUQnpepicdLQX77u?=
 =?Windows-1252?Q?vherdk3qNJ/d4f28U+jz0zUT3uNnxyyjceqKaqru4Y1vBFg1fJx/fc4p?=
 =?Windows-1252?Q?m0EhDAfCf5wdrrTehF/XS3zVd9pGOg0F1WXxbB14QS7jvbETDG5d/Y1O?=
 =?Windows-1252?Q?Me42eDM2nc3L3r2DS9p4ymqWOoUbOxi+09xoyT8Ja77bXpSxG7eVXXlq?=
 =?Windows-1252?Q?GePN/7QPzuHZ8O8PXLNREzGmSwFeBR7ZdA0P3fgIQz0F3OAQ5EsFJ9a/?=
 =?Windows-1252?Q?lIJUjjNrFMDv8HowDLBlR6ViZDxFxFar9MMEkq2NEyQ5xB97wknAo++u?=
 =?Windows-1252?Q?78k23lX+xpTRnlZyGLwWQlGMAT9D3CXJxe5eHyASbqnbtitsruds/KP+?=
 =?Windows-1252?Q?idIea0N7dL6+0rcXYoUKmFGaRWuBu0nYam3gw9xRYkd44Tojtpn0oA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cb56d1-4a84-4b7e-6550-08dc282e66d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 22:44:53.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9YC0SxDxMPpj27rNF9+qi8XlQ+NtoppJNxs26jtxNIZ537y012JZSFoEYTohELn1lbCn3leFbw5sUnJrT/zkf6lh81ftMHD5diu/NHrVRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 22:45:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14913

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, February 5, 2024 1:47 PM
>=20
> Hi!
>=20
> New -cip release should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-5.10.y-cip
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-5.10.y-cip-rebase

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-5.10.y-cip/build/=
5.10.209-cip44_2fa4c25ee/
- Results comparison with previous release: https://squad.ciplatform.org/_/=
comparebuilds/?project=3Dlinux-cip/linux-5.10.y-cip&baseline=3D5.10.208-cip=
43_b445cc998&target=3D5.10.209-cip44_2fa4c25ee&comparison_type=3Dtest
- Summary: No new regressions

Kind regards, Chris

>=20
> And their content should be identical.
>=20
> There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

