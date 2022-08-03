Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6FC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 12:54:03 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.128])
 by mx.groups.io with SMTP id smtpd.web12.8128.1659531233920524891
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 05:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=i0pjAWfl;
 spf=pass (domain: renesas.com, ip: 40.107.113.128,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcuY2HUaVE5cYyiW9KmdtLaDACs0gqEweuvDnzBdirl218hmYlIUZfpbPzwTJNJdJBqG34p4/t4Xy4wHGO2ZCORoQ641rpjgQ2ViflYzOVoOsD1aCQrODzMHQkc6P+wufHLvUDKbNP6p7L8c/noag8f6ULfNm8PP8m1U9nl15oSkk8QsMqnOATFvvedrwvNE+86sB9hnjtQsgx5MM7u4WdBYH6IfwDgZ2T29gO/Am+B7Tbd7xBi3nBNZyOl5SvYL6Jfafqyfkl5C27u9/mjmjASpw96OZffhhjJazs+xGJ+LV0APjSQFaqHEY9NofVZpZGh5uJ2o5bEB1njdJU6RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxjg5xfn/ZiLbE9LTNPOooVpjkULy3Rr9LF24s2dx6I=;
 b=lPrMxNdOyVimuBE85dl+KHWWwwtMf/AwJ0SOKBIB7htXN6t/lveK+9NvLhr69/ifONTNUOkLFY19BnPPYpX8mOm6LhT9Deut6PGKo4UuFICROmp90FxUDLIJQX4qR5uSjQnAqr4huoiEKj+9tie2TlXl4BFG1E4NbTRL9ICmZbUPcwkdlqBgE0m5wiyG91IkPStHhFRS1CfXxvInKU9fRiKIOHbCW2PuXDM4Mt/AbTFRppE/Rk3dL/AuEn/EIW7sHVETyOnWrFvrh5F/ceB8FxOK5xIMUymXCtAz9ORQgt77F6izmmiJrt4fCx95dFM/dlA2o26kz1XB4DF7VTDunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxjg5xfn/ZiLbE9LTNPOooVpjkULy3Rr9LF24s2dx6I=;
 b=i0pjAWfl9JXAoImAev1twAJ5gfkeZ5Dk04Agdw3bEpwS6ZZwqwz3qWz9AVf+3VMroaGWAMMgPRQ8fmQShHjyrhvnM1zSTu41Nd73SPRI/eCyYTxbqAJCMIG3gG1Cr9ipzxtDVJsWASxRqc9S/vMSWKYxjPG2Tn6xr5yCHGjk7gk=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by TYCPR01MB9783.jpnprd01.prod.outlook.com (2603:1096:400:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 12:53:50 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 12:53:49 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: lab-cip-renesas offline
Thread-Topic: lab-cip-renesas offline
Thread-Index: AdiltYy100MbHMb8S+iw13ruOkT5zQBgnqAQ
Date: Wed, 3 Aug 2022 12:53:49 +0000
Message-ID: 
 <OSZPR01MB81242BC432276E17980915DAB79C9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <17073FF13822324E.4434@lists.cip-project.org>
In-Reply-To: <17073FF13822324E.4434@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2598beda-79d3-473e-b620-08da754f3640
x-ms-traffictypediagnostic: TYCPR01MB9783:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vsxzsOR7Q9gYG3+gs8YxIYwkPoTY2JLgYsZx7yrehHXeEv2/lBo2DI9RNpkGq2lToE/UDwoGWHoqVdOj/BJWyZA4BI65HHXKd1fa7kTB2R/HQ/qZak9FBGkBGKSGCLAXtDtjeJRtDi34/TzAnUdu8O+war2Q6HrtIJUWHlMb8wNFJBSeg6e1A/qdqN9LDQagV9OhaBrvpAHm2WbDecr6LHHd4M1PpnrZ9WJ/zsfjJYfuHwyZ8pmENZyFP9jL63SK7IJ4Ckq1boyz9t/BzOBO5fT3p3y029AEIOPHI7/U0tIV68OueBT/RTPuW2v9tXLQVnIAe/d2fB0B6UrnBVCFHVK9lML+hLm3vIytIjLw52RrbYYB0jyJc16myu4I9xGAmHOsIDok/CM/tNufPDS1LIBVT1Fces+KLPhmLxyP8DxsIwxhecR4JzlFRePbned0Gwz3Ff6Dz0A7eLlglxswa1xPBx2hfiVbt0hnMaqSJl8q3lSnutFyru6XWeJUp0Mh/Keo0aD0FmgzxfutK2Bk5X88iul1JDc0Hz+iokcF9DB7lm/WFw1ZrM7aXYsdfgrYb+umOj+L2t8lDWwPEFIZrr2MxBLGIRDgDjtICi4eDTk4fhQqGlseBJfoypplpTnx0Y+YFnQ3S/a6cxs9l8IhYWmaQD0ER75RPdAqLRu9dl0SwXwf5RdQymDZtZ1iDBvDUxa35E4/uPN1PXz/qTPFf50xLbdAlaSzTVOupwWcYZ/vIn79UTJUIEqOOjDAyT76/75A+FF4Z0zQRIHAYBUY0NzlzqEv98aPUr5QekBr8RtyOma7YN6TGEGTpDrX8q4x
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(4744005)(33656002)(5660300002)(86362001)(71200400001)(64756008)(66946007)(66476007)(76116006)(52536014)(66556008)(316002)(6916009)(38070700005)(55016003)(8936002)(26005)(186003)(9686003)(66446008)(8676002)(3480700007)(38100700002)(7696005)(122000001)(2906002)(83380400001)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?40RcJ7olTn0VWrU6fQzTBVH1Du/ElHe24CqDyLt95vYcOwkgQzih2UMF?=
 =?Windows-1252?Q?mlhafm5Nk9r+bIFTct5x0TgCwLKT20cxyMULdNLF1UPkLtjmKq/HJJAj?=
 =?Windows-1252?Q?QKILWc55cEmuI6huueOzPEMGFWyzi2V99saNociNYOnJZ8XAxVqXFjjn?=
 =?Windows-1252?Q?alDYOKFW07UT81rHQ+n5Xs0kH+85TM1CaoC9kY8hpl/fx8hYcy2QC9BZ?=
 =?Windows-1252?Q?SLmjKevpPbzPQU53OXdoLPs8Exw2gjmycuJawAqHGPNygPrcSJftaTlC?=
 =?Windows-1252?Q?UWoWC4RQH7z5G3Jg9HwVvpyZXKS0s5jNv8qqn5i7Z8Gq9kgoux5N11p2?=
 =?Windows-1252?Q?8QKKF6bqSUqJBllMliQqDZHurM8vwiRFvHCCRBQLjlDo7+B3j1HONVEo?=
 =?Windows-1252?Q?bhrD8UVKPW9gMyyjtjAtzGGAp4ukPt68TAgkjMrD8+mWzNh64RsD3S10?=
 =?Windows-1252?Q?mUfBaEFhgqF6jMiI9snV0c1NZHds1uq6gyMM/vKiYfXTGK4yUd6EXkv+?=
 =?Windows-1252?Q?uCAVFfthsJ+qMwHxVcGkeLq6y5THl9MOFEqp0FBILDfD2uBbRky4buZ6?=
 =?Windows-1252?Q?+T8e5VkpxLbTm3QBMqiI5pVBpzKnRAKncyNhgEUZT3J6LGYBmuQLW/kj?=
 =?Windows-1252?Q?W5HaQbw6zFvuM+A92a9HU1M60ysyDgzyxv6pQzAtSWhPfCdu6UgRYioJ?=
 =?Windows-1252?Q?GH3iMApQYN4QNTyGxfBmXvGaU8DMGn1yH8x1cawEjNO7NNAJRktpE/tC?=
 =?Windows-1252?Q?8zkSbxEgEf3CdF1M8JsGvsEtCDHjQKvN0K1Sk9cG3q0vmT4scu6vP9E7?=
 =?Windows-1252?Q?biXnDQaAfmrnH+KsVFFkqkfQVn24IFfX8IAksQROY2YFyPdMIuyVKUk9?=
 =?Windows-1252?Q?9K8LSRp8zKaPRmAH0pn/g+EaSqMrgs/Dkcqr8UVFdlkvvyRBNsVwISIy?=
 =?Windows-1252?Q?UtNkaHJ6q1M/Mb1E3b56roey8fxF6kU5Jnht6J+fHUUqRdxjQV0BbuHo?=
 =?Windows-1252?Q?/AHnBNLX5gGL/H2fhjsBePCN+0CUwveUMSfAisN3r3imoxSIBTOLg6D3?=
 =?Windows-1252?Q?HZNXmG55uZ3DGjeUNijvidXRR78FW8GQb7XNLWI3gq3n8l9kF1kul1Ed?=
 =?Windows-1252?Q?OUJilOddBffeJs33Pzrce7nzlr22mcju+unCsWHhRltMsSI2lI3kZ/uk?=
 =?Windows-1252?Q?8rpqdgCKvs9nFOecn3dukSIESDZRvFcGtvKV9gG+ea5edM1FOd1rK/jg?=
 =?Windows-1252?Q?4ziN6ZZ1HzUxmIcR0VK1oFlX2YjKlOD7ncP82UmsMkxMwburoUQ9fnlk?=
 =?Windows-1252?Q?C+DAisAXBmYUXtu3LPXueWLjDiYzUeN5X9zSg4gzyn9bINP2DiJ7t2jg?=
 =?Windows-1252?Q?2hZ1Db4dxREimcSuMXS+SbxkcIRt6UVbnZGu29YG53YtRmBddFCv9hFp?=
 =?Windows-1252?Q?8O60K/vjbhlQMbQ1iCV8lJ+dL+rpErVZ8qj9Fk9rq6Kt/ghaQz/mSS2h?=
 =?Windows-1252?Q?RRraLl+A/G8dOoYXBQvWjq1AMCatZXIha98uoVCCQ7IF8BaS3xbVXdHc?=
 =?Windows-1252?Q?zVJLdmVdqUvZ6gYum00BpntSrBJV7YJ2RqX5/UPOIxMNHz7bLi7YdVN6?=
 =?Windows-1252?Q?7nA9zxBzCH0TtckrfLm/QFEyTI6lemAYX2k24u1iJ/nBN94GIA4gMjNq?=
 =?Windows-1252?Q?IoP6K24jYHrJjiQvEBO+GL4KMl8PPLHUglnDGgAoftrmytzkFAjR9g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2598beda-79d3-473e-b620-08da754f3640
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 12:53:49.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 7HS/8Uf2Q6siERlH8RVmp4nV0hMUGxiDwZyEiDtpsyYR2VRCuOhN/Q9vvFj5ByyYONRa61Yq04ntt6uZySC5iDDtSKUsuWaBtTZycAjBhE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 12:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9046

Hi all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 01 August 2022 15:48
>=20
> Hi all,
>=20
> Just a heads-up that lab-cip-renesas is currently offline due to some
> networking issues.
> Hopefully it'll be back up again today, IT gods willing.

The lab is back online now.

Kind regards, Chris

>=20
> Apologies for the inconvenience.
>=20
> Kind regards, Chris


