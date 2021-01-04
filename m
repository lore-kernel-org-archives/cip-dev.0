Return-Path: <SRS0=QiMD=GH=lists.cip-project.org=bounce+64572+5991+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838FC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:48:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DED121D93
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED121D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5991+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XmhmYY4521723xJkYxQyqYHO; Mon, 04 Jan 2021 02:48:05 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.123])
 by mx.groups.io with SMTP id smtpd.web12.12120.1609757284577911542
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:48:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbuU7bfcQNREijEdNmGK0iyFvOI2BIbl8wMUay74Wt50uO4RP9hxK5MVINCVmP5ToJ0WZQ1shfEk9y7PbNbIzU1dfqboWCEjNuCHQ5UD4cM7xa5nk1vclANJlnN9vGpmfw5fCoJ83nSY7rFsPJ/VBJhiaQrY5TQNn1t77mIDHjVBCCFCkN88Jk1ox6//uH1PVoPJcPUzoYl2we+3qI3ixcAAGTJxvtBoa1MkoJwNXHYiWZut7Gbi7S9nXHiir3PnRpDByfEb3ntZvwOWuN4VnxW/gLwJYxCT2ZeRmuP2Nxot2svPL+DkVVaSemgcDNa3dPIEXEOLnbr0cNtAIk1xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb0o8lRbtzKxOprYDm3OivqcTaSSqgV7q3zV9IMuKCk=;
 b=TsNZAXftFf+qgctR1+qNVzM7oJ9TLRYI77EYNkTGJf5MXDxiUrz5Wf3ZNyWUUTvFw2+vm7nrcvZmdxeOi70dPxJSjsZkcHQ1JKMDzLvDf9mUALWgkghf7ocI+fCzIQVrncWZ7/cMZzUJAFNg18OVb2KtPaNDr1NzVJJiNo9beiWKYO0oNarDNiAkHKK2BHJ8B717sjGgV5akJ2eOH1DRHurDN32c3eK6DjRB4Qb4+tdVBtUlCgnG0tGJUVGcHKdnvT+3TGmUVqejFgOrWeslOxhJGHvoYeeP0jo6QJfGYohCRUGY+fwjCx702HO8BwFsY5Ay6wFeoaeK64hqGibrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB4756.jpnprd01.prod.outlook.com (2603:1096:604:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 10:48:01 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b%5]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 10:48:01 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Starting testing of 5.10-stable? was Re: [cip-dev] Testing of -stable-rc fails completely
Thread-Topic: Starting testing of 5.10-stable? was Re: [cip-dev] Testing of
 -stable-rc fails completely
Thread-Index: AQHW3cAqGx2BtgYAFUK+ZC9Y19q8n6oOjelAgAEJ5gCAB7odYA==
Date: Mon, 4 Jan 2021 10:48:01 +0000
Message-ID: 
 <OSAPR01MB2385B98A7415E26F2FECE904B7D20@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20201229085357.GA17217@amd>
 <OSAPR01MB23857C22D82B59C59F0AD25BB7D80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <20201230124530.GA13161@duo.ucw.cz>
In-Reply-To: <20201230124530.GA13161@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.164.55.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef117214-f249-4aae-ba7c-08d8b09e3505
x-ms-traffictypediagnostic: OSAPR01MB4756:
x-microsoft-antispam-prvs: 
 <OSAPR01MB4756BEA63C55ADD1334FEAB3B7D20@OSAPR01MB4756.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 MHb35CiyjJyClsNnZ/1lK8DgLkGJpG82jL3Q0acKNqXKvTNnLhQGEqtWYD1liEcAF20J2dNRnBbXKia6jSf2SzaWsHnJNalwtJdPqoZRI0W4fSWR/X/vbt0a4ZmpEqKcsNV9QabUeKReZ0MOeXP76bVxKh3P9HcwHpx5vBxAmLQ0ixhdCgAO4ZAWRw4Rj6t7Fm+sfAonFqn7/JS5wdoJQ9qcQCEnje2E6v/iPKNmo7o4SeQoCG5VqP6fDF2877as99HQ0ZWgBoTW36kKZsQ+9Umq1PDtptp69dtjpbSGon6kjVXfcQ8sEvklbBXgIr5UZdcCU3vHhDONXfDvljaIx8OhlDgPxxeL0EFACbiCPxDSitRXhDREbvOS+D7oSGMZz0QROAFVfw5MuTB33rsZDg==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?ESRhCFFmNv5W+fdvcRdZspich/J3dth2alddYrtIZ7HlJeo2jqLkIhye?=
 =?Windows-1252?Q?pHujfWTX5NRXM/Y1PVi63vlv4Xizj8LnIVh+1i/4BXlSRKe1Dd912vPJ?=
 =?Windows-1252?Q?JIZfMOhewiRRRlhBe3SwlYsEhcFRs/s91gGP2jSQiNkdlj44Xggjmwf1?=
 =?Windows-1252?Q?xomzLGcKYMpGxZVIpoEIpqHrPfjLnsBtY+7QuGXNAWBkVzWzIuDNnwie?=
 =?Windows-1252?Q?SnoJWbjfdnFpzaHMMbo8aT4GTUdVZc+sqhWxmA4CBpTQfhiFUj6qR63E?=
 =?Windows-1252?Q?HDUohLELu93Xl7Rvk57f8QiSKIuM/dcZ8nv7Ie67Q1AqEVNIqb5llgrE?=
 =?Windows-1252?Q?uKTqURPbnFNHYuvRIJ+tn82+Fk9uSQjh8WY7fA8YbEqIRVFPtLJWxPg2?=
 =?Windows-1252?Q?sPxG43/F/r52mag3r8U5HiLA+xFmNXkg9o75crcgmc2LVf1mP5wAtm0y?=
 =?Windows-1252?Q?Wh3QCstgGi5PgqD238Dqv9wGwguQae41w2yYENgRtVm5iPyTrnV0N2gB?=
 =?Windows-1252?Q?FsYkSQW6aXwKLW1PjkUZDOCz4PBAompbAXJZlgWSHBrwnFpSlJw979Cw?=
 =?Windows-1252?Q?4kWMh+f0HNx/FUBnL5mgL0lJFAmRonVApKx8tpocXipRXE9UXanN4rRp?=
 =?Windows-1252?Q?/dEX0RrhNiMj/8brAFE+gCoHyN5Ap+dfFDigKh99WD7YwSYT/2pelKHX?=
 =?Windows-1252?Q?vHbe+fCWqKNmXhvqdRZMSqTYtroVCexD5eZtS6Px7NaTDob3EiOEixAW?=
 =?Windows-1252?Q?uIT4CIVecBgBrCL18BIJfRm28+vW4P0ISx7Ar+jJctzdNPV3SWRYjt9n?=
 =?Windows-1252?Q?dGoZK+bkFqcfNyCyn4ODVYhJUuju9mgHlV/++di3XAIT/XYzeLhTtmCK?=
 =?Windows-1252?Q?+XYdALJLOa9mJky9L77CiHA37jaWWZ5dCqy8iz9G9/9R2EjJWIpJhDj+?=
 =?Windows-1252?Q?QoXhYE0Kk+vcpPAlbQ1Y8+222ZjrGO0bTUezkPcZSrd/Vx4aiOJ5o0WC?=
 =?Windows-1252?Q?qMzDbXvHE5oMFINA7ppgMOdW36Tu1/g06lAKphC5n12Cn15/Q5A=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef117214-f249-4aae-ba7c-08d8b09e3505
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 10:48:01.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svsvXP0Z2O8UhTAGS+bgOLs6FOs9dAKmGJqIIhqNfa0XQ6qm8vaChYESOElYZW2hXcwyt5WEA4LSylCeVEqu8ix2Wnwp9M90CYJbitzB51Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4756
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cnGU1opfHYXfV7cX5oVq7H9rx4520388AA=
Content-Type: multipart/mixed; boundary="H82dMtWxZgFsk3m2YwXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609757285;
 bh=mpMRrq0jeEKLM4Lmm8U20ixNa3X21iwcqiur7MPOyvA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=bNXarTk4ezuNpiX9Hc8fTEJrXI8tdB/QRQ+OgV35lwtqJzJUqzbXcbKwczgrq6e19Yy
 gwHy0N5lmJFUCPpTvwe7Piih7ipuxzrmybcedp2G5dVeEmc62zLtwVoDXcvURxhRgSqdP
 3u/YriN/rCwC7b87K15F79aDFdbclwtuS7s=

--H82dMtWxZgFsk3m2YwXa
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 30 December 2020 12:46
>

[...]

>
> Now... I believe we should start testing 5.10-stable trees, as we want
> to maintain that tree "soon" it would be good to know how we are
> doing...
>
> I guess it will need some configs.

I can use some generic defconfigs to start if you like.
But yes, ideally we need CIP configs added to cip-kernel-config.
Perhaps an email needs to go to cip-members for this?

> I believe we could just take 4.19 configs for a start.
That's one option, assuming that all relevant platforms are supported in v5=
.10.

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

--H82dMtWxZgFsk3m2YwXa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5991): https://lists.cip-project.org/g/cip-dev/message=
/5991
Mute This Topic: https://lists.cip-project.org/mt/79311303/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--H82dMtWxZgFsk3m2YwXa--
