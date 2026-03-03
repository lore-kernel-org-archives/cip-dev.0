Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65517EC1438
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 12:14:48 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16977.1772540079767621023
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 04:14:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=czx6Ia8u;
 spf=pass (domain: renesas.com, ip: 52.101.125.50, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUg3UtNrd7izBZdgmwcnMuDW+JteLJCY4WA41XzRXM2m3CisrVDk7rD7ZbRVypBInN4Nw3VHlV9yYH81t7ILB8Qr3naYJmdjLqLSNSBvLYWBf/S/yoJyL+mQr4vlFUeQsARVCCMDyI1m2MZqCoAaqFRZzNFi/hj6Dm3Xq85LQSpdgEmbfT+SpfQmNynljS7zVFjbETfcuPtauoB1bIpU0ALsQPOXhqwvZ/BnlfS0krIVYFgSOoFkap0DXWuaxPdBVrIXiVN7LmAVJniTpwrT2IK9YWR69NOFs69r2SXZndAAlrrU09IjR9LIBgdLQ+cTXohlG5gzbHFduxKcekgwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeU8Ccunase5aE+/+tjluyEuZHguOWSE1cP1noyDtzs=;
 b=b/THydtvgJom9dGfCZvBsEeCRAoXSKG/oz1Syy8w+P5l9uPSe0ZfHE0OL3ppLlbFrXrtEgiBNvzGS+eiz6JhNxmY62q47eQ0uvZr9RHgLkklLY7xU9nsSk/PHmuYkatfOE2BtJWg7SVoUzEG2qoT6xK7OnCSsh6hcS3sd4TfUYMFRccsIUCLZ4h2Nuk+ZyYum4MTrZ00GkUehQwczOrzbmoICOdEXfUu2gNKTNGv7bhZGh9EKNFpEBYTTRdep67CyvwMwBJRN7CmF53G2hnIqSKyy/UePt2kfzh49oZrrLZhrrfnwiO3KrrUN7XUH5evQ/ovKVvLd37UvJg+aJtySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeU8Ccunase5aE+/+tjluyEuZHguOWSE1cP1noyDtzs=;
 b=czx6Ia8uGBcXv+ZRG9nJgZ4D/1ImOyMISOucrvpaRnbjp69iu2/AJ1GCbyM3nE8eg+yoY54N2JxX6VALeei/dmK6LwRg2rgxIB/96ROETKnXWjrXnHUZ4HztDpP3kcEvI3NpskmA8ZMfgxQza3EFDrOcnkHh0Sau7FzU2JTEE5I=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS7PR01MB13669.jpnprd01.prod.outlook.com (2603:1096:604:359::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 12:14:35 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:14:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>,
	Pavel Machek <pavel@nabladev.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-members] No boards available for testing -- everything
 failing on gitlab
Thread-Topic: [cip-members] No boards available for testing -- everything
 failing on gitlab
Thread-Index: AQHcqiu46lDHNCoGREOzcBNN9z9gIrWbBoqQgAGzajA=
Date: Tue, 3 Mar 2026 12:14:35 +0000
Message-ID: 
 <OSZPR01MB81232AC2602973A6A27DB11FB77FA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <aaVgOTtbrrgEHL2A@duo.ucw.cz>
 <1898FECF736AF5EE.1454197@lists.cip-project.org>
In-Reply-To: <1898FECF736AF5EE.1454197@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS7PR01MB13669:EE_
x-ms-office365-filtering-correlation-id: 030bc226-5e14-47d8-d0cf-08de791e6f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|4022899009|38070700021|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 hwrjjoIEpPfsTpecKVyfjLqAWLBi+c5JsqoxHbAZBPJnnkJv12N1WQHpholuBHw6QiHtdasLQfsYQFBBkPVcOUMzwW0rk39vDLZXvYHZcQvBZfrRn5yaUN7wGJPuwO277EVKJHdt/1wJxxs3ZVeecMIETeychNpeG7T3pqoIcwUSeRh57Hr4pLiwD/M0RTy4LIacPJfpNwzPR3NrnauYz8Lcm89oUKr19K1lH0C7LcoE5/WRqz2yLKC6AvoX/IxnoFBTrt6stXQxB4FLBwmvs1Xe0Qsg4nEQ2OfkqNIfrq62akAo2TYMwhLu1osgWRYPw6CJ6/AzM1IRCCUV/+RBHKtsxKM+4+HXGPopwb4NADQHHsLaAtX0fBy8A9HGAe/aVBLwpi4Kx0JjjyYqpJhb4Pb9G6NI1Gl1fCjGcKc8tU6Jrc4jmrDeg/M40maqYDr2SXrWFoKLNco+m08ooWfztsfb6vEc/2qi2KypmSuZ5VsSCqTBr1kB0/jH18sdKvXLP149ieaQ8zijpjbrIZk3zJ5kCI4cAAfGlkd/EU3DTOlrTCAwaW+0WVX4YXmyJ6EEBB4khkR6q0GVT1pAiq+S4UJgAry5kZkAXvGwpl0fIE8Tf/9JARAPuYQnnSQZcbYbqIHTCVi+/I2L0Z/zEhPC3vykiMDHxmJ17Lwgx7SqgEcnvYGXtirFJ1T2x9BuhTH1I0SzH/p0guVi2rx3VEaQjgF4KnDTbe5hSSO9zJgtKBIjfRcvAkXNmILpCJOzULEB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(38070700021)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?3ogJB5wNz4Vnhp1GSdiDoYJn5vjG71xJJPLYAtRVEmfNLcX4bvfuTmTX?=
 =?Windows-1252?Q?5QknqPqY6eurWOr8bCzD4wspxyown4fzvSQ4GIMr37ULjhf4dARz0K3k?=
 =?Windows-1252?Q?PyCmCaegu3aV5nKApQXGATd1D/C+l4e5BPrXS0Qni8pLsJomtDOlXLhB?=
 =?Windows-1252?Q?N5vMrxsmZd93xPJyxX7U0ZqZendcty9zA86T6c2OfbCFJ4IZkQiteOWK?=
 =?Windows-1252?Q?L3aSKviFRL6Te3dzw3b9hPuIHkV64w9rt8K9ZTZoarifNLpdyoVBlj36?=
 =?Windows-1252?Q?vzZ0qEC78BzktoUmQdjZoBjQ5KZNk4jdBqQJF2sxa0OewEKAn96ITqYL?=
 =?Windows-1252?Q?XTix0DQMObjEkTZb02sIYvUQTmM3smbkn4lUkVFC8bBVQKSI4qqCc2OF?=
 =?Windows-1252?Q?WUelxZBhFn4bzr5tvtjrWvxfLEd2mMFYbPiuYU056NkoOKrGgbf7/R/H?=
 =?Windows-1252?Q?vv1+8X6s/XTyjEPSzDL7HbcYvkh6ngp/bQR/ouP6mxxWyuXMN7GOf+++?=
 =?Windows-1252?Q?9TvxxeABtf2H1QkScFL0T+y3sPQkggkm03kbO4HFBnW6N+JuaCCuqtg4?=
 =?Windows-1252?Q?cthkqpGP1XqO6RYPFB5woienUN7cn8Zhe08di4kDmgkIxH6awzYwhyIo?=
 =?Windows-1252?Q?wvzn3nJ2H/hUQvH1lS8NqXuZdidt3rNXU/rWksYSO9W6+8tLgWXGUAVb?=
 =?Windows-1252?Q?3XHBFpRHlgBT8uzTYpigAYxyl/2+unxb+8egJhjqWwHU9KDUbWMOmvAZ?=
 =?Windows-1252?Q?XJD+f3cgn8s66Wxi34lTWMIJvvEPBQFSi31mHI+P116jWhTQRxQEijoD?=
 =?Windows-1252?Q?s2SqVx/JDKEeMLeYx8l7qeEGCezi0MCgslfkI2MBPSQRsSPVs5t46cv4?=
 =?Windows-1252?Q?A4IuhbbqBAAPYLVdj9lHK5utQ7amUY3Ak/SriJ8z9fI7CHp5EQoaS42A?=
 =?Windows-1252?Q?NRV3SYvcbbgWjGx9+SoN7PdE6BjHXCOR+ZZMYUW+MjeHsa0umbKi2WeX?=
 =?Windows-1252?Q?wOOr2/tQfK5QEjKu/A+Eyy0znwFkqBxMzd5iSw3GNNpOyFAkV3EdgYJG?=
 =?Windows-1252?Q?ZhIbUiVrBp597ZMwLR19V7IWKQWIOtQJZVxXc4BXLw82p/OtnwdhkeDs?=
 =?Windows-1252?Q?xVPrqW6Wam8zmaEjUaZ5j+rTQ/E67obPK+xZc1Q1sTKLVtvNp2cT/5ZW?=
 =?Windows-1252?Q?CndFO3lcaGkbOioqQCSQHW4M9dy2U+4MWENCgmKwhtQwChX8r30OEbDE?=
 =?Windows-1252?Q?XalYtgavyC4SBdz84vda0u3GZJOWXiknQE2wQU7XCNBlVbaMmX53j/IB?=
 =?Windows-1252?Q?Sq6vYpIJmuxeZBcvUcGqoOLfQJcmk6OojbqYeUOdsDVy0hGoNTDCcj0J?=
 =?Windows-1252?Q?CctaR+dV3VSyOTpHE6ofnPWUWfGSPPJcuBf669MeZQbSmi+JAsYa7g3R?=
 =?Windows-1252?Q?R41HNpvNkj9D8nKTYiGLdpQ48Zu+YIg7IGqX03nPwtUqkCOnLuAKULrr?=
 =?Windows-1252?Q?GhHmOo9/zjuoIiQQk0qphv8MRwuEQ1xamtKSSKsjD4rvi5ec3Y5hmjX5?=
 =?Windows-1252?Q?3RRyl/rok6UUAGhBZRsSmmLlYfVp0uVJlTfHHrVOkpoaft04Yh60uUGt?=
 =?Windows-1252?Q?D87geTmDwdWt2SlcGhofpEwf7nNgZ5Kb5nkk/Nxem5hFxx8Pf5kCVIM8?=
 =?Windows-1252?Q?n6QriYAoT0ihwM9mLdbQPLMDyK79+Z7isKXwfCH03ZoEAYIiA/ynIICC?=
 =?Windows-1252?Q?JMP1hVPgnnXpbnL/Z319IgYpVR+vvYcahwS/fKbzKNrLBLG3uUEpjfpc?=
 =?Windows-1252?Q?mu75KKugbZefF1ELkChMLsHctl/W/Bcr3nmQbhtZTrjNEG/ldfHXMA2S?=
 =?Windows-1252?Q?Xo81r5vgagIYNA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030bc226-5e14-47d8-d0cf-08de791e6f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 12:14:35.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4g3mHo+aTrZGm4cHL1hJkS2pzus8fLkiNWui/BMCOtTcnhfdzJ7U6FR5JoY/mMHYr1iDsbInl+xPsO0sxmEvWCIFkI3CXSRNr4rF3GUnxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13669
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 12:14:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22059

Hello,

> From: cip-members@lists.cip-project.org <cip-members@lists.cip-
> project.org> On Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 02 March 2026 10:17
>=20
> Hi Pavel,
>=20
> > From: Pavel Machek <pavel@nabladev.com>
> > Sent: 02 March 2026 10:03
> >
> > Hi!
> >
> > I see all the runtime tests failing on gitlab (compilations work ok)
> > -- 0 boards available.
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/2357934585
>=20
> The CIP LAVA server is currently offline since Saturday due to an AWS
> issue.
> I'm currently waiting on LF IT to investigate.
>=20
> I'll let you know once it's online again.

It's all online again (has been for a while - sorry for the delay).

Please let me know if you see any issues.

Kind regards, Chris


>=20
> Sorry for the inconvenience.
>=20
> Kind regards, Chris
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4833): https://lists.cip-project.org/g/cip-
> members/message/4833
> Mute This Topic: https://lists.cip-project.org/mt/118091156/881120
> Group Owner: cip-members+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-
> members/leave/8129226/881120/1568160156/xyzzy
> [chris.paterson2@renesas.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


