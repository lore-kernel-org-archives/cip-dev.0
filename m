Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64A6CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 20:48:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.web11.4416.1759438086603987687
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Oct 2025 13:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pjQTlgIh;
 spf=pass (domain: renesas.com, ip: 52.101.228.65, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3gEytE7fvOLOyOjlC3SPbUymMuolv5as0vKwEfW5kcZejZ6sWnqbvz/Cb1CJ8wcS7FBTj7b5fgspC6e4fBHhNlV0ILpo9DIjCsQiuMrzAu+6DeDPTPQJfYKI6PRjmY1a5EXgPOOkJmsSNOzg1WCLrizfJIfxPOOpWg6dJkKrAWMR0axNVNkBxoIcXfqVNzGuOVzuxG992e6LpFrG6H4HpglyjhAOrmPpQkGhlrj0YB0+jWX3+S2DA6XCaY4/DAQ0EE6XuIfM/AZBm62I9y3umTKWOrIs15DWrNCqh73fqSGAINsWWaq3mH+w2e2OTk2BgZ90vqFTjR4frf+8swhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mARHA1kKZXYasqcIrKYZoA1qgWsnaX2t9Ffg5LwuLGo=;
 b=NY+u2C7r7tEkyNhDSDI+7md9aAGYb/RIiTDk+00Dxc1iUj3+qqgqVeSnPBNagInUs1izqXrUFjIYSvQ04DOFKxFgdbLtD+A2bL3ZAEFLOSfOPkEy0rCPgtVuq1KECEwLE4btOr0ZG7pcCVbyKlTAIZrbEJqjlFTz65X9rTRaXcoq5yooIApghsPgRy2UVq3YYnSdx1qHJo1ZNstk9BzqYS2NcHkg+9fJjTITVr7TFPlt7kAay8azFEfEIahSoUJrQyt6fyipbGAi5vA39EtdEgv7/0vMUiGfpNzPXuzyWIT90II9Xf+qibMtIsR+QQ0JpEawvk1rieeV+LZlSav+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mARHA1kKZXYasqcIrKYZoA1qgWsnaX2t9Ffg5LwuLGo=;
 b=pjQTlgIhNSxKa9/IlrwUuyTOii8ZppXwD/Zi++oArT3OWKsFrO1/UfujxKH7qwYM5yeFsB3Y52MmMvnmowKQTxDpijy8C3QnMXQYGnEa1lmWWiRzQD7KUZtHY4JFDX9DBVOzPWQtPxpsFKb6pSERVnoypohgTetyvmorsHW6B5A=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYYPR01MB12208.jpnprd01.prod.outlook.com
 (2603:1096:405:f3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 20:48:00 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 20:47:59 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, cip-dev
	<cip-dev@lists.cip-project.org>
CC: "Nieddu, Pasquale" <pasquale.nieddu@siemens.com>, Hiraku Toyooka
	<hiraku.toyooka@cybertrust.co.jp>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Gylstorff Quirin
	<quirin.gylstorff@siemens.com>
Subject: RE: LAVA server downtime for maintenance
Thread-Topic: LAVA server downtime for maintenance
Thread-Index: AdwzacbopE60FdCIQySfni/uDU6DQwAc8snA
Date: Thu, 2 Oct 2025 20:47:59 +0000
Message-ID: 
 <TYYPR01MB151329C576BBE5B2E7FE0FCF5B7E7A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <186A9A867A0D5C69.24709@lists.cip-project.org>
In-Reply-To: <186A9A867A0D5C69.24709@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYYPR01MB12208:EE_
x-ms-office365-filtering-correlation-id: e0a01ef0-babf-4bec-2b9f-08de01f4f94b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?+kuI9e4BmGOs1UrBYLJUZFVdU1bLhM1KMiCDxeTrj+mkRWRkpWhtdMiB?=
 =?Windows-1252?Q?MTTWyio0TNfP1+w3JD0CEGRPQF94jDrxQbNEDU+3N1mScb2APYMpyqxg?=
 =?Windows-1252?Q?E9AMBp36cPy0UD8isffwtgnpf7Lfh/EkjscGQkOFCLRlAgx1TFgl8ghn?=
 =?Windows-1252?Q?qTh0fDK9VvfEY0YFubD5gCjFZVZYN2AFN2VA2TtLmvzd+agLMQ0djb/k?=
 =?Windows-1252?Q?h2pv4uAg3umolg0AcP3SwxsJXD9xbQNBHP0Kk0F0YVnICqYtLjwYl9bp?=
 =?Windows-1252?Q?KhP0cEa5iRYoZec2Wa8kP5JWprQIVrYRp//A97KKu0kfYoiOViUtGYXR?=
 =?Windows-1252?Q?mufN4eQX0OzXfR0JhbeJ8MjymbdlUVwph5Wu+U7m/g8ZymlUrEYs/BpL?=
 =?Windows-1252?Q?Dsrgnu1UK8c5pTAC40YrcVF7XD6DyiGNjUWoP9jWSdhvR2humnmct67n?=
 =?Windows-1252?Q?wN0SIsPX27ppWCSXJCTEjcb2MEL8EB4e+O271GB1OvIl8fuPpxNzOx83?=
 =?Windows-1252?Q?g4Jd476TOyboiLSZAU+7Z2JXPQuhe1qnPYgERSpCz5MgYXm2y67GoI8V?=
 =?Windows-1252?Q?335gc9agN0BfH7wDa33wSbpmN3VsUEh+1Lbiny9a7+RTD7FT40+ssy0p?=
 =?Windows-1252?Q?m3IDqNw1Iz5fNpqRVOueSoLCwCQnFN4aCslk2r43h64Y0+qg6lavu5sO?=
 =?Windows-1252?Q?Eg6m5JYSJBvWkik5/1WgFDlX4XCU7QlgMLvNWawWE0WNihWgKXees1iA?=
 =?Windows-1252?Q?QrN1hK/O6z+geS576lZ8aAdvpyxTLuovb7arM5Q+33IuIisjkZu4Kfc+?=
 =?Windows-1252?Q?VmhkVL3hBg93zkxG2IywKg/cnBPOyvZLjOMcsbM7jjtoKGebnLajHiZ6?=
 =?Windows-1252?Q?/0tiZqRjChxw3HV8cUce0Omz+HZbXys4fEEGDJGLLKWBJUcpfwqp1jDe?=
 =?Windows-1252?Q?IAn6BTc/+iLJNSrfGhcCxPX026deMXJ6Eq1t9A7WqVtsm1as28OOL9sB?=
 =?Windows-1252?Q?3tXPpCvhOxByj1C1oGSvlmLFCHBqe6r61NeTKXULjwUXYiV32vbQ0IeK?=
 =?Windows-1252?Q?pCgHhkPfdEhspdpmDJ6eBO+c6colUhKKZ66ZBkM5xlKJgABrDPlaUXmm?=
 =?Windows-1252?Q?mxseILK+p8oGduxtKcOjaprc+4sUviHn+6a1voiYXbsQg00Mc+DkPo+y?=
 =?Windows-1252?Q?2hb9C+cGKzx95QoJHDxT2NTA/BFsAAuHIjKTuZQXoe71D4D6p/4U8hIz?=
 =?Windows-1252?Q?FAsd6kYvxhhV/znsuKsANNu47TCBAN5cnDcaLYsLFIRhtja5hHilvtrp?=
 =?Windows-1252?Q?9r+QnzZQjevN/vSLZbin70QJCqlrr31WlE0aYSNvZvDV9RSrTneCIXdq?=
 =?Windows-1252?Q?nBhYIqFCJcZLSrVfTw8Ygw+Fw2iYYrfEsfuMeDWcJFjbubxHJyGlrXfs?=
 =?Windows-1252?Q?xLXMauI+Fo96o/wZZ5J9Z1paGmLEroZgRhFfzqt6fS6IblQXDRA/CPl5?=
 =?Windows-1252?Q?NwuaAMEZGCgr3QcJ2GZiwRYRtcst8C9yFaI/BSyef5WQknl5GfOg5uvz?=
 =?Windows-1252?Q?04K0C5aFpvGwHMxKBUUsC14nzUYWY5zQPiwd6wODWFOiTA6GLt1jbp+E?=
 =?Windows-1252?Q?c1q9Gc6dcoOv2aN3LsSHkjzX?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?6TuB2vo9CKwC7KYUo0AnOygJd5UN0IW6knEPW0JuSa31A2rbIjujW3z9?=
 =?Windows-1252?Q?sX0YpIlo+DUaehEdxuDExrpAVOJpViklst9ffgXWdMyHEBd7JjoYZiYZ?=
 =?Windows-1252?Q?Nk6LD679u8yfbkw81X5p51/GWE/QZJsZJhSyCwwApvCDX73VR2j9h3KD?=
 =?Windows-1252?Q?ZIJgBsyRCBVRbS8znVOSaYhp6pIVQruKFscVeFbuLYGJ396JsyRGFM/x?=
 =?Windows-1252?Q?m+jkftVyHtspUzDFX4eijqX76FKwlwzaBGFEmmZccvT9Aox3KMQYsmh6?=
 =?Windows-1252?Q?NxUJnHh/4j2HD+3saiaPU5SWHrRQcQ4MaB9Or15VNcrSIAjFeRZygeEI?=
 =?Windows-1252?Q?cB40hhJSxDgCQBCkskmsbxC3HHwffRQkxWW+yplkCnAZluMpCRUlrbVZ?=
 =?Windows-1252?Q?W4/WrAH+lF3ovt/tA4QAEY1xXZVqisLrrdE9Wz3OkmXijMa6vB+m/vuC?=
 =?Windows-1252?Q?TR0r9e1GRPnj9TRIExh3vX/E/2Ec+xx5SDUROT9Pmbg4d0MYoOk9yYdc?=
 =?Windows-1252?Q?CEJh1Y9OEnTZpvhDZdRUa145huav0vr25xEQmn453YmAoaWBvXal+Yr0?=
 =?Windows-1252?Q?VX+kapGNirfVwhMiumKu3RQjGE35UMPMrYXSjsGqJI5IGjtpbQ8WunBe?=
 =?Windows-1252?Q?mQJ678esG+u772nHVq6zDMT0why2A7Z0KhBmaK3sLtXZ1NMDESidlOQN?=
 =?Windows-1252?Q?FVXg5q71AQDk1xbMsOlJcTZfTwkWzR8aa3EsW/lsYHEJ+vmRaNfO+a/b?=
 =?Windows-1252?Q?5VsuJ5LgRbqxtxJRaHFNRqxdeJsSOqb/atXewaUzLb/cNzvsXCe/gy9r?=
 =?Windows-1252?Q?AannceedLs784pG8tqAuzPx1B6nujKlqY4cKNeV1MCOWEOmq1BMqfVY1?=
 =?Windows-1252?Q?pFLwCE56I5loeL2sEr4J8UsGZ4peHDzbQn1jjvT2EmMw3Dsy4kmrxXOj?=
 =?Windows-1252?Q?7aJQ9WM+TzHOwLy1ndvRRfJw3r2azKhoPVaARkvqLojLg2f/BVS9Ulqp?=
 =?Windows-1252?Q?tD1LjVIPkZbUiBoCDAxx7UVYqc3QZd6gzvAN9KuE54wc6DWclFj8KYpN?=
 =?Windows-1252?Q?2rmD7qquzDuMpY4jLPV25v9N/vfd5bqSOY0iO64BAmRoG2tdUEnRRku5?=
 =?Windows-1252?Q?Pv/wXZ+ANY63UOxNZ+3bYuWAuC8wy+uur+On41j49cfebKElFrs/TlWs?=
 =?Windows-1252?Q?jgun2ESOA6ghQtIrnGIq7vefqyX7WzmtTyZ4XBx42Yf9rxtz3zmC9jbT?=
 =?Windows-1252?Q?j7I2TejPpA1xjNXQP6yYVWE0OUIjHYo4RV9CrR4yb0B+irvjy6JitLNu?=
 =?Windows-1252?Q?WuLPTQJyXtgQnrvT8ecqA1U1TDrbo7xLXsXTWtwvt/4/TKSp4LUpIkvO?=
 =?Windows-1252?Q?IofUybzpI+odSmzbVs0DiN9wAb396EuvXfRTenl8wmBH5L3ywLBOMyYt?=
 =?Windows-1252?Q?4Apl2YbcSb+pLUlTF373k5Ggk0BGZT2Khm+S1icKx/bDZIdRbsmU9aY/?=
 =?Windows-1252?Q?CIXBpwefmyBhrzJ5kJGxIoDEyikcM16U5j57JZMF0L8WdAcQwgvKjNMp?=
 =?Windows-1252?Q?cCxhlejOYbAIdjXkWPJ37cmkqC2Z7QdHbhEboj2eVAvN0E6zmh/Zousq?=
 =?Windows-1252?Q?t0UXRfkkx+WVlt5c25Z5pn0RiUThFWmDn/2MZdqlBiQb6zp3ZME0+S08?=
 =?Windows-1252?Q?tNSnpOzfiq8tk5tmJ97Wbg47tdUytwjLXP3oLeCrs2eZIzgovXOZ8A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a01ef0-babf-4bec-2b9f-08de01f4f94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 20:47:59.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHjsr3SrjEMf2suowHAmqiaSq528QwqhIoUZnEGZSg/bx+XooNKXXjMtcAOmBtwlzbco20Eto5FApOqJ9PGTGsazXs26nILvMLPoLzy0WiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 20:48:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20158

Hello all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 02 October 2025 08:02
>=20
> Hello all,
>=20
> The CIP LAVA server will go offline later today for some scheduled
> maintenance.
> It will go offline approximately 2000 - 2200 UTC.

The LAVA server is now back online.
As an added bonus it's been upgraded to the latest version of lava-docker, =
currently running LAVA v2025.04.

2 of our labs have already been upgraded and are online again.
The rest will hopefully follow in the next day or two.

Kind regards, Chris


>=20
> Once the LAVA server is back online the LAVA labs may need to be manually
> reconnected.
> This may take a bit longer due to timezone differences etc.
>=20
> Apologies for the inconvenience.
>=20
> Kind regards, Chris


