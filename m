Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F9C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 08:17:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.web11.10178.1714465041262091816
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Apr 2024 01:17:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=CDZSkgvA;
 spf=pass (domain: renesas.com, ip: 52.101.229.0, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6f46FHWS6WaVpp3iVmWDKngHWEH9HhL8ssmg4K1DZYWlCw8ASaQdiMKXQsIUD0ctthC8+wTAW61ZhYpQnWjLzCtM7O0ITDlbAk2YqQZw0+6sbyqmjYlJURNZLW3jSPWQNaXmSe6w7IwYuwxT5yUpE9vZMNcLQ528dk0biSUqbwDNN6LxjtuHTidIqeoW4vBuLLkPYBKnSYnTcBXGw8wDm6d9nVBSPIv5NhZODK65S6tT0pXVPPro4j+jOFZqWayYwljc77E9BwdKv0MM23z/0jiW2/AvbyuppPe2OjnEPzz6K0IxdM7qYW8Ff28vv+WF4d7Ig8Msi60ptEXbWh1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TMTrbWrJKB62DdtfvDMCFrMmDsZMVWIbesCpmhfwz0=;
 b=njofgY2GPmL9ISZQEj42LreO7reanoVUaldZW7Vg6PtgiBml+dHsVhznt8S7JUz7ETc59sL3Ob0LGv9Es3rC3hgjpRd9qcuFgdrfVsi8E1FrbdTUldCFI5A22VOGiECaAy40/b3HXD9mH/zuDtL3HlTzXpLZcCisV6BSgRzzy4zIsOrxFl8oebMrkilHu/wN6kj82dNmgjNo8jjxHbz2MjT6eHPP7rjLRBjU4J1rS7ikXDJummaGjarqEMJb/SVmSANARycf9+W5cFdgvPC0pMuAYjmOmhOuz1HWF9qcTRxEo6zjUTVY5KXEQFAYLSTfPeIJk3m82b3W3fsDWYw4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TMTrbWrJKB62DdtfvDMCFrMmDsZMVWIbesCpmhfwz0=;
 b=CDZSkgvAYIEHqU0cX1yWhq2Jg1iDnsInEY4OgVq0f4OBxXQ6r3+qhb6i0fRjnomvvgfMPKMQyGGJ0DxodtTg3qsH+F4AWH3oQCJlfw1xytvIkatrxczDLnZHauLPXCkzOJi0iM5x5Lof656Ob3oFn8OD9nzcDhNTqoqJ/JL9AyY=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS7PR01MB11759.jpnprd01.prod.outlook.com (2603:1096:604:23d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 08:17:17 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:17:17 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Sai.Sathujoda@toshiba-tsip.com"
	<Sai.Sathujoda@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Updates about cip-core-ci repository
Thread-Topic: Updates about cip-core-ci repository
Thread-Index: Adqav3IefljCpDvdTAeZaFSlAVlLnAAFf/CAAAA1JPA=
Date: Tue, 30 Apr 2024 08:17:17 +0000
Message-ID: 
 <TYWPR01MB1186277BDD52C052FC9B76BD6B71A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103C363AE0853268133CBDBC21A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <a7be2c45-c48c-4fd6-8e19-daeb07896c8e@siemens.com>
In-Reply-To: <a7be2c45-c48c-4fd6-8e19-daeb07896c8e@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS7PR01MB11759:EE_
x-ms-office365-filtering-correlation-id: 07318443-f574-4ed4-9faf-08dc68edf2de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?6EQSRbUzYZNfVImHcjuU8zqFd4ViOpt/2BhXzMBuND0Xav2ecM/R1djE?=
 =?Windows-1252?Q?cmYToDUCvKwXNbHr0YHmXl28J0tBUgRKYAf+8RQy382FcjERjBAfDleR?=
 =?Windows-1252?Q?RlLFGHvTxHXvdOxWlLgcJ6xCSh5iUZ/oH6EWBIDVxdJD/oi882cAPyjh?=
 =?Windows-1252?Q?nj7MyhDFmtE9TH1i2AZUo1JsbszAltMV548mUdy8j0YhIqSS4gMNnm1/?=
 =?Windows-1252?Q?CnhBxmDNOuiV/UL+iCGZLluZJdBfYkb7hyVcPVsgnWIixZIZQ5ziy1bQ?=
 =?Windows-1252?Q?ygMlJE9WacGE0Vv7oW2eCz9oJELa7PIXLk0zzPfan9xhlAwynIi88k7f?=
 =?Windows-1252?Q?vG8UqB74mEM5XM8e8NC/0mYd1VjBNRry3DN04X1xsedi+GrGvtLIhAUb?=
 =?Windows-1252?Q?/XnBbeWE68ST4bzlJlKhTKJ8WK7ICiT22ICt4PAkvDptaKDLO4bvPMlQ?=
 =?Windows-1252?Q?7L5j7Y4+LH6WxdU6o21LmdkrgbMxQo9e4wwr9uznjkByHKN1Qz5UwW4b?=
 =?Windows-1252?Q?1EpUK3tyrgrO45UNCFq5Ry9oM+IzbpmcYb4VnDf3s8Ingc6eOHtgcWdF?=
 =?Windows-1252?Q?GIpOs7NuQe2mDLeWrzX/9zcWi8FqzkUoRnthQOXM9aZ0Us36LTs2TrU/?=
 =?Windows-1252?Q?lWY5j05ZuLT72hse1EQfgfLocElX6/XFO9CVYyRTyA/k2DPXQkV6c2a1?=
 =?Windows-1252?Q?znxugwkvqg+U2CgAsLMeSM37W8jGyjPNDjJgyXV4fQYelG2WP5YW+D1p?=
 =?Windows-1252?Q?K7o+PQo1nL0F+pGSSCZxGz7uKYpu2Af9Qn+2bu27mVyYhgMozVuKXNXJ?=
 =?Windows-1252?Q?F7PNx/H5Xz7m3yEgDJvnoK7DTgV/dRdUUDgWNhB/eVcudJPhmZtEB5AG?=
 =?Windows-1252?Q?aSQraKR5OnJjQ7605jhbkg4/i2emzqq9b27Hiqiux+nGe8vmnhrj06Pk?=
 =?Windows-1252?Q?DTsE7c2dLmTNMb8zXNo3s6pqgfAy97ej6R5MRYnBi94uGuRQCoSoc3t2?=
 =?Windows-1252?Q?PbN5a//HfTbwODL/ajVPCEYuXGaFoklf8XoOSicxQxKQBWvoiXHPkL0e?=
 =?Windows-1252?Q?5pGm/1dhl8QxUod7rMUS39AE9NBhRxSW7M25RyD/rRwXwj03JNjhukx7?=
 =?Windows-1252?Q?MASTv3O5cBs6rqwJVbjgqqS96UPiYNuY9qjxgWndEQ+p0mOsy93yaUv2?=
 =?Windows-1252?Q?cWGU+9RSk0o8etBMKbEHd3BwIlEYZxUYP94uleCEHRS+c60M8Npx/xti?=
 =?Windows-1252?Q?zWDS8iAGJdQgQSuP6dHvGz7GuX3i308thAREsHc/5vwB9OMJCvhuOqeW?=
 =?Windows-1252?Q?sm+RpR202RwIw4PBQ098r9QHFuhJMT1E9nZPjPeWnjDbrsOeRFXrwuF0?=
 =?Windows-1252?Q?UScwGtLsP1i9v1g1tMLiTNsCBaARzvfAUqJg47GNQUe2A0iysE3cTGxC?=
 =?Windows-1252?Q?7PWQ4cdSQE+5t8f63etUEg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?pn6fXZo9CJbChsSOmMO0h1rQMq1o3v2a7k4Jc5Q5pakOlpbJXuCO5BgD?=
 =?Windows-1252?Q?birF83hr2rewGBz1BzmvMGywKxk6W7zASz+Ar/z3Z5wo4TOYo1YVgNOS?=
 =?Windows-1252?Q?vrpozIBVbFj5cpDa+T1SPw3pOiw8V9IViVNSi3afriLwV372Ip4TPs4G?=
 =?Windows-1252?Q?0D4FdM7BfpFmL2+RI816f4ErY0PBaB6nhBhuW7fQjGpJ/vLdTosPfi7q?=
 =?Windows-1252?Q?CXF9wmdf+ocz7pxns1im45fUGs/wTcqCb1D8jJGGEentnOY/ha39DX/p?=
 =?Windows-1252?Q?0ooLPluY0tOH9UWWveRoAkHdNXW2P+EaWz6YLypE2BHa+FXm63qswD69?=
 =?Windows-1252?Q?YLS4O+/gstNQmn4icTjWh6tEBv+V6l9O43HtpA1nRbNujM20ZhLosVvS?=
 =?Windows-1252?Q?S4xV/WpV22s8qDK7KHdKftJVTRZ5KaK5Q8r0ZoldkNEu2ym3JBL3dPN2?=
 =?Windows-1252?Q?1SLxvoYVsmq6/x3cQ36nQKMkfYrZGbu06+LP1M93wtDBqEKweohBjxgx?=
 =?Windows-1252?Q?hFBF36Q9Vr1+SE2sst47/EdcXiJy8F+mzAG0kKe6feySYXoQRprlHdPC?=
 =?Windows-1252?Q?O3IPFB5CYQ2nlRk/K4fczYYmhU5aM7VTmDQs/dK8icfK7h9EQ5+sywGR?=
 =?Windows-1252?Q?BqcWwVQda+J/hern5ZFjh9dF5leJTp/NWNjVJl2P49RiX54KBRyvRVvI?=
 =?Windows-1252?Q?mNfeWQOvPWut4WcfKiNhfUjHNzCVTS03rLrCuKCGq68cYUP3OO+nhP8n?=
 =?Windows-1252?Q?QvvUDnrBSorAVpLCG97Vm8koII9hl9t24dpBEuzq4JCsrDIR1z2FFY0d?=
 =?Windows-1252?Q?jVGsE9+wDFaniNCNbP4ohIdYcwNnDhcNUyFuUuu8vpWmCrEHHc/y7HQo?=
 =?Windows-1252?Q?Rc3LX7x8Mx2PpzlwD8Ra+l2XWFPi46gAx5YoPm7CxkmymSmQRIFbP3jy?=
 =?Windows-1252?Q?SUkRfVBlVQGeuCVh8AR0Nu4GeBXFdWJ/xZGB6OoKaAnG0DOxF3WdL9Dj?=
 =?Windows-1252?Q?hpVsZ60eH29HvPN3+sBxy6hYQRH8odhuQW3xhxyLAJJLnGjjz4EGUQRI?=
 =?Windows-1252?Q?L5npkVmOnr7BYk8n6ziSWUftbSHlnT2czvAU6hFpyz/yKT0w9PalxhOY?=
 =?Windows-1252?Q?mkZjgJFuJsAw6FdFotqt0mCttmU67BT8ZLeyHxU/ZCOqqimeDVdYRFLJ?=
 =?Windows-1252?Q?Ys6/Oo5CqaptMWP7afUzk4mIhwvUC1i1/SKaIA/lZFH5xxXdAdJaPvvB?=
 =?Windows-1252?Q?46wHiLmmysv4cQb72lPX5pWk9jrCxsHGFlpiYyB6sS0rEGmUMK482tMh?=
 =?Windows-1252?Q?4JdPoVftOw+j/WEWr1t9KRXg82vO7P4bs2FXWlDTKcFDAju24j1jO2gg?=
 =?Windows-1252?Q?UYb3pDaPUxl1zcaXOT0wNXWpgbaUYAbiAhvL7iowIGY75EKeDqWcSU+K?=
 =?Windows-1252?Q?y5DMWhBWMB0mueEG7zU5HnDfR7LDO7odOBOv4TzMJ9T8E++i6ky56VnC?=
 =?Windows-1252?Q?Tc66X3RJTMS6tvq7FrexlOMmwP7SRLcpwnUZCjtSgbKs9Z3diDtibVvO?=
 =?Windows-1252?Q?SNHFFj1+wHwDdpP2gBTr1IROLqW0ovPwYebxVqUrYrYvF7jxyiTQWtz+?=
 =?Windows-1252?Q?DWLyTG20BukW+XA9kU7uSP4P854ot3o5QxMYeNGfglvqku1pLzx31msi?=
 =?Windows-1252?Q?bK39gLMLKaQElQBLIqknG2MM69taTwJOih7UXxMvrQBNlB0QIGiwFg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07318443-f574-4ed4-9faf-08dc68edf2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 08:17:17.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHHeRhZtyx7yvUTG9/6lNKJHinvRyL/jQSjIE34xPivGhdTF5BFnsniM6qrL8e34Lcbh0q31kPFgAx4TAc7BOidrSZB0owXBJReMftoDVnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Apr 2024 08:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15786

Hi Jan,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, April 30, 2024 9:07 AM
>=20
>=20
> My long-term vision is rather folding that pipeline into isar-cip-core.
> I would like to perform tests when changing code, not only after it. We
> do the same in the Xenomai project, though there is still room for
> improvements regarding filtering of what to re-test.

I fully agree.
I find it much easier for users to track the CI status if the pipeline is r=
un within the original project, and as you say - before code gets merged - =
"shift left" and all that.
At the moment the CIP LAVA labs aren't at capacity and it costs next to not=
hing to run tests - so I'm not overly worried about redundant tests being r=
un.

Kind regards, Chris

