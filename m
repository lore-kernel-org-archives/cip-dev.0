Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F160C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 15:19:08 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.91])
 by mx.groups.io with SMTP id smtpd.web10.75953.1670944740882619319
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 07:19:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Ftxd6zrO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.91, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2pWB1xxPuhRQm3HtfTS7ICt2Qo8jUO6RPyNhnbIkx+4De8ouQxd3r002MFcGy3QbBAvgnkHVAoce/uisB1mXctFyp1Op2QdisONHUXk1CgCAF98a+YDX51ak45nQEKk1GT/u6k37MdQXbS7LFROjDk9AVd8DmWZTJ9IpDOueZi6mjwpmZDhFIsX54KaVL5psVYX70PfGNYxl8UVKTz//9dpKOPd3kvwg+x30pbltKc/lXZqh1VlOkpds72sh1cLTmiLUSJQh/oP3rORTNUZu2oLCDgX6f5MZCQ9K2OAKxpxvjX4Vgrt8foJOhKM3VrRy2IzvpAHdSXu/H+cYq40fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8loahhksOE6MKhq0A0Y0PYXQjdqv3XsXZCO2kFQPoc=;
 b=icYdLoM/FDBBJ1UvlJqzmMDJ3koYvmvXmhSyZum2dcqnyQoCiSFg1ybqUv7hWXoKMigikgn/iQo8jHXTKCCrknhjx1WYkaOEAjoFEswGHE51WpZ04uSb0jqzM7kwZKHHm0RVeDxsQTHkP+f5KoQ/vwOrUyS/S0u2OXF81CBCZ7QIRxROFtvUBqFaxtESzBSkTG2owtBsYfVcYwIElSndAnJBRlKQn3vipHZ6INVnuTGmxpZCu3S4Tm9eqOACa4MQD64AaqqTogBwyZeKx4DT6jIg2RNBtCtRuwb19goQvN+h9Ldf48Cs/60vHyrcQUmpKnDIcTTZgXzl7Q8HIr0zuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8loahhksOE6MKhq0A0Y0PYXQjdqv3XsXZCO2kFQPoc=;
 b=Ftxd6zrOC0E0GbVkNYc8fw0vvJDmuHefM6QnDwUv59Jzs75tsvS3LY7xTD9OB/HtOmC1clsZaaEPdjOsDxzw1hlUMZveMg365JLxom+xjwzFlW+UdtGVhp5f7qDeknqFfhSkSGCzJZeqxmMLASIRFdTcvK/2jfBBuN2FWP9NWXQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5975.jpnprd01.prod.outlook.com (2603:1096:604:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 15:18:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:18:57 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Topic: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Index: AQHZDwY4hOYrVHZLX0+FYgabGelo+g==
Date: Tue, 13 Dec 2022 15:18:57 +0000
Message-ID: 
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
In-Reply-To: <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5975:EE_
x-ms-office365-filtering-correlation-id: 9e27a209-cb82-4cfb-c2b9-08dadd1d5aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n4/9ZiUMyFTshtqK4hvYP6D53u7ja+e0QV//bpJ8ED1xapp+c/khltonuGL2bUlsoeygjbPGv44r39kHkMLViLw1tiP7gt6ikODBuZqRc03iPMZh7d+gc9+AleoOROCyjroaejUIrb1KGuWUqLtjuXHM+A2ODzLLvYUl1Z7rrn1bmWfm7n89Z6IkTaInWVLai5t0CpPbuF/kSwlOmnwd+SrEqYVmZJnrRISOlfxeg4yV+r8UZckSh5h2W4RkhQFU4UxKkwUhJGG4nzGYammz/p7UETN2YREuLVAepQ3Mh7tY4X4jhrFDryMA+C5sEvHAKOvfkCiR/6P4B8M270sDHJ88b6dZ/zV3qAb7wU4dKqZGo6RcAJHNV8WlFlGOmdUs8XGgH1CamK03D29R0gOyMeLRMDOP02GMymF+FB2ZYQmQCihtinkIQGdU0Bl1PSwMXts5JTgvHcSR47cyPEjHPt+EjqB3EmsOMNV+NEv+SwI9fNZIfMRhmbV+0hPdsr9kw6T2cX/B2Hz5W0Xw3qGTYsZozVgrrwPLi3asEe8am7AOB115wtqNEPuhm2+qIS5SD8y98+seG7nris6fOlmQytL3zSAl6NM3WEgzGxki8tz/Bst9XI4oHeZD+I4hXKgHbcs23GktissTqTmQERdcL87MTrDQXpLrRxw/7dQUAoE4xqkYEt/h0mJ7YscIhQ8c4xTGdy397rWW9TLNarlsO3SlQNp3S4tOh7K9KTilwbUgvzmXjEspQd89wuqZ2+W3jgtA5ABpQ272zf1tgVCSZw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(4744005)(33656002)(5660300002)(52536014)(8936002)(55016003)(966005)(38100700002)(41300700001)(478600001)(186003)(7116003)(2906002)(6506007)(9686003)(71200400001)(64756008)(66446008)(122000001)(66556008)(76116006)(110136005)(86362001)(66946007)(7696005)(8676002)(66476007)(26005)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gAClc8r2vguHorzpn6050XqOnZMmtWD7Wem3gog1Nd2t2vovh6cbS26Y+qxk?=
 =?us-ascii?Q?Z2d5+mQsPjf2byIPkpczjFx6wT1uqPYKaS51XaGlE5zKNaV/lmA0qiQ/htGy?=
 =?us-ascii?Q?bJukwTxiF03p4pPkncn9ZIXVLrHPu7kWKK01K6lasQZ1gTuNP7UfIQx+izkJ?=
 =?us-ascii?Q?A3rUZI9nuRyJeB9In976GYK4uEp2nvKu6EJL4aUfeZXGRBGrnCwXdrPgcUIo?=
 =?us-ascii?Q?LfW+aPqEosPo//13FngWxDnSrh01B2W+bORjMAjspNcXuaSKnQAPxCJX0y4u?=
 =?us-ascii?Q?y1Xm5dZ85wNIhrwsmy7FSPgqQtqtjgy+5KU3pJ0cRx0Pz9RbIJgcYTJfO5ZP?=
 =?us-ascii?Q?gDXYU6Q1dGwbr7Cd9AWlkViAcwt3snlbFMtrhkqnSg7qfD+sw8Ra6Ol0spUA?=
 =?us-ascii?Q?TqLkWQRU8TXGsyU5zS93f5UX2CrkoLtfOt5lnMqR3Jw0J3CKjRZrTbOH/D4d?=
 =?us-ascii?Q?wH4IwZCVEcyIilHo9J9nOLVtuzrxs7wK6mMMbFleCr3VJ7Ub+ygHi3uV5erX?=
 =?us-ascii?Q?4w2f9Yzi65PMPBXmLG3rtfFYsVhj3UP2QtDXmOKjcQ6WobgvtWpRJd70ZfXO?=
 =?us-ascii?Q?dZQ57UP/bxZo4U/9mZ8NSec+0zS1zXq2Ludn0xzAFOtL0rtjki+zp/N1TT/m?=
 =?us-ascii?Q?d80o1qN6OcY89c9puCh1slzmP8ARLY+SIJP6c8cyPSf72P+yIntUFUuLBS4x?=
 =?us-ascii?Q?ZDFCM+CwUzaoSJ0MbP5jB/RZtcFzCzeV/HIq5uYPxhhAl356lwsFbxdt8B/F?=
 =?us-ascii?Q?DjRTwm6WKqaIrKt8PEZ15pz4DwmUGvgRCGkhQrCYo35Miby+2L403d9yByzK?=
 =?us-ascii?Q?gvtEafkyj3RWxECe5ueKYQgBgHKAhCNvcw6pctvLWZPQktU05CfT5NJOuWfD?=
 =?us-ascii?Q?29l1n0f/2Ftn9F22g5f8jBlxTWV23ZeeEIFkZlmlKFEFmgw9vo7btkkQ1qPP?=
 =?us-ascii?Q?E1Le43TSciGUxQDpfp2Qx+YJxJvcUHsm3ByW5ZDB/If2DOe7lgc/BZjvUD9Y?=
 =?us-ascii?Q?m3OHqVMeoLP0e8/niBcaUrvz3VaQMJEH/TWIxI0ZATeIdlPFPI8a3TTq2V8l?=
 =?us-ascii?Q?YNootb0wQ0/fdNXBc0lyCPTzQA7wqfgiskPo9OtD2H8VZA0slrVYxLn5o+qD?=
 =?us-ascii?Q?LLBoesvZWb/UHWEe6fKFatO0lLEr/xBzekd8z8Up/6KiD97QhceEaFjwDkvH?=
 =?us-ascii?Q?WgFQ/mcnGaliEUH3WS8QYhOshpSKmWjh1BMtBlxxlbZZOUYaDpDeDmCO/VPf?=
 =?us-ascii?Q?zmeXEzmB6/A4VhKJ0A5rapWNz+1FUGV4SaBYyYWtqmAWT/+NSXZJXECNPdPk?=
 =?us-ascii?Q?OOm5tDjObI8+epXQRe6dU1369FlWB10zipbZKIX5QGPe3Fsd9LDddo4mzawG?=
 =?us-ascii?Q?KPSp7W/gU4tgkdz+4F99JWQosg/sz7YA2E0G1nQmSKaGUYywq5KcGnnzrOIm?=
 =?us-ascii?Q?PWL0SV3vuzg5VFia5HFtV9l4jwNjTrCSj71K8ZcNaWS2x0cqLb+q2YuICwMT?=
 =?us-ascii?Q?DffSgIl9WSB/t+cd4GionsLD6tKT5V4Ty97ehbYb9vjHy8hzYj6nqt6Z6myq?=
 =?us-ascii?Q?ipIys1HOnNCe0JFGB/7o6yF5ZawcPa+wkqPJMWn23D0f21XM12U/nNU0L58Z?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27a209-cb82-4cfb-c2b9-08dadd1d5aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 15:18:57.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0+mm2NP89Ox0lKB5hhpPIE0v7rXTmuOczn5TR/PmbVTrEeC+v6T4aXZs+vWEJL9cLxLMV0ZpxS5dL9UikfSwMSEbfTX/2A2wfOpnBCj6G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5975
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 15:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10216

Hi Pavel and Nobuhiro-San,

We are missing this patch from 5.10 stable[1] in 5.10.y-cip[2]. Can you ple=
ase add it?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv5.10.158&id=3Deb69c07eca22ffd8621d9de9378e4b3ce7965190

[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/d=
rivers/net/can/rcar?h=3Dlinux-5.10.y-cip

Cheers,
Biju


