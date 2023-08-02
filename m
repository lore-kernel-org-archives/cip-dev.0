Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E78C00528
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 12:26:28 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.90])
 by mx.groups.io with SMTP id smtpd.web10.13600.1690979180220696022
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 05:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Rl7anMGt;
 spf=pass (domain: renesas.com, ip: 40.107.114.90, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYEKBSZYjIvGvp1jkEszNQT3C92PhdLekCc9PqW3ruhN017mTS61u6766sSJAAg/Spd64PeuVrRgNc7jHLnENTm/Qa885J6O75bRYeCAB1g/pEko76mBgjT7jKMDrHB6tNL/n1EE7IVW9rbVzqoUPZod5FSFfen84KyPEteP5Klu0z55uvStzeDfVP3CDHOvuWN6DfQRj+PtbhBZrutXDhUYRyMbGgkys5wIB9aa9/orA8xG+s21t/3R3tzaR96FO1lpBY2Ws+9ObU1W2hcJWYmmUfAEwFqLVdBgdQcU/WoJTtK0XaEXIEKWRZ2aK0oUe6beX9v1hUw/L59B8zH1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYRo7To7rJp4L4wYT63ch+fovgBSYXR0iM9mstvFDgM=;
 b=cqpFuqd7PhLGhA/vpoDA205om65WrI9RDipylSmy2DGkve27GSWdM06+viVGpEDuxeDBDA8YKs8j+AIFqHMMfSG1ybLVkBj15+dAI47F/m/QZ2hBmsC8dgO+mbZGMe7dqW7wkCVnPF81cPxgODzyOVdCBXpgFJJRJV6JkaJuhp0/PXccHgQLgZbV3hTEz4dOIZ6g5ei9+tOJpiBW5HjsS0jNzhCYci8mASxQ0hBtdhDiOTHmMIu5m3mpzDfGZjAjOwzGACbrO1S12+9hBTIJJO8HA4IHc8TtTAZNW3p2t9Jdb2NNOMmVeK3P2PCGDh7vUhjyUKdVlnO5cz8u5OS3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYRo7To7rJp4L4wYT63ch+fovgBSYXR0iM9mstvFDgM=;
 b=Rl7anMGtpiRwg1myEciTYlPPtG7aC6mg0tPxoFuizgmqXikT11910mjPskb4EKWrqmU3qflxO1Pmnx/IlegNpyMIx4XNTuCDJG7GeFKu5jkGagpS5y2OC7dZ+J0PbakbJg1EjCmpTcoEBtpZDeQdcTEWQ9Zvo9aFr8LZkFbSj0o=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB5997.jpnprd01.prod.outlook.com (2603:1096:400:48::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:26:16 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:26:16 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Michael Adler <michael.adler@siemens.com>
CC: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] stable-rc-ci tests failing
Thread-Topic: [cip-dev] stable-rc-ci tests failing
Thread-Index: AQHZxR9ONsUbi57YE06aGQY191NQb6/Wtr8ggAAJXbCAABYEgIAADyMAgAAIJ6A=
Date: Wed, 2 Aug 2023 12:26:16 +0000
Message-ID: 
 <TY2PR01MB37884D4B59558455C2F991C9B70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
	<17778648DB0D91E2.2497@lists.cip-project.org>
	<TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
	<20230802125753.4d2e6225@backstein> <20230802135204.1e883f3c@backstein>
In-Reply-To: <20230802135204.1e883f3c@backstein>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB5997:EE_
x-ms-office365-filtering-correlation-id: 423d4f9c-47eb-4f07-24c4-08db9353aafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vPa7W6no5W/nWMm1s4ZRcqt55FGlXw4gNyOK9V7tfOCV8Hfo0FYbm6NKe0hHUWDVjBunqf1D+X/QuwiY3FB2Yi04a3Kwk5PfF+Z/Y8mh/8UpyaGe2obfzUgqbXFpsKY9B1EU4tLfyzl/MY6WmT5kjY8YMjoRyKRWTVG/6rdPQ3NS9HNADOyqco/ypK4ePbbSv9oWw7M4/vb8L0kpBpa8tvUJhmySfBa4wgGknH6gdsRocjd1Fl0gHTk7JvMGTkOYIV//kmj5fF8XozRbw+dDFerbu3+ntKTS+o4LzTVH0Ni9OKxCSq70FEzfAG5hV48GI9ROti1O7izVopLm4LOe4LCqdD/E+xhbvwMbzD9HQhQqimIRzJDcfGzpXDnvzlqPE1+rDoVBmCwGd5a4Ai+vwCUDnFPaLE3R1hxG5n0trSDD3s6Kh1AhkXU4iRKRpWBxYCMslxJzaOkhJmFeHBXf8eOvpVB9SL4CymQ5c6qXJXcp6WuJKtepi4puO1KqdXKVIYX54rSJohPl55746e8fNxXmfydsXW0rhg84EdUdHrwuxj4dI2swVpi0jA4/Kx79pYuoqjMh+aJHAr7uUV9cS/mSz89t3H4CjYo8LgBAbTIJ2hS4Jz8nVTBl3Uxyh6+j
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(52536014)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38070700005)(4744005)(55016003)(478600001)(54906003)(122000001)(38100700002)(316002)(86362001)(6506007)(64756008)(7696005)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(4326008)(6916009)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?BsyQAFfaMB0avpF8qkyaEBHZSm4L2RZZJnbaHVh/6LTFXSAyLUaL4WhQ?=
 =?Windows-1252?Q?0U8fnwONdLXUXtEgoFCX4QOtGlU2sqzH3q6XNz4CzY/yDARbGtxVa8FW?=
 =?Windows-1252?Q?I2HcFHZd0yO4DpZWMyqnc5ElqydPHxN3fYFi7QFM9E7KrZwd1hCUT576?=
 =?Windows-1252?Q?9qoXU8uu1qaTxArfS4bpTtKy8zOcZsvnOfZSwq+HmMflpR1jdLz9hxIg?=
 =?Windows-1252?Q?9Mf7MsiZkzAOy2w1ERrEMgAp9bAEYlDfyUpXXx+2WNQXwk9oKD0s6ISv?=
 =?Windows-1252?Q?9MbYjTVGbt2JpJPDPE6MiCnGtAwWIQB0S/jltrIRmtqCJJa2BQRyQ+V2?=
 =?Windows-1252?Q?Owax6DAhD3XD5GXH07Kg9uItYFO5opt/RCVkpENsDSt5/rRjlI6XL9EX?=
 =?Windows-1252?Q?k2kGH6rmTm4EVuJd4PDUpc4JqP9Va7kNvnaNDNBt/iW7ZGgGI2QQYgEG?=
 =?Windows-1252?Q?pEAtDu5eKsySOcoLc53dX+oLPmTRiGprNpdjVGXeOqcGkNT3Omus4kZq?=
 =?Windows-1252?Q?MvttNdhfWhVkPxQWoWkwkcBYx27ILD2+zN7BbSZAtJ+W8bsDLpB7OJvm?=
 =?Windows-1252?Q?jWE+LIaoiWB8GX/jPxo11KHLO7/sRQnVYpehVCJnIaZMgOqKQh0P833K?=
 =?Windows-1252?Q?9awnR/X6+qSIgkXQY7M2MfJEWrtQweikxJbislTNnN7/XFL6tkKqzFal?=
 =?Windows-1252?Q?kNI/ce44LduG4AoFbzYOQ47hRgg/Sj5Q9PdxYLDgn9emh5E6T7OL2YBc?=
 =?Windows-1252?Q?6DIW+1E1nX64Kb6pgjrI5fjCVP9AuUI1A61zYzXsvJFaoEv7hoinLCgp?=
 =?Windows-1252?Q?vTwswkTTeoYjYNgF6Z1xlIIoqAx/kjry5U+DHxGYwlRLRkdyIXrZbjUx?=
 =?Windows-1252?Q?RfZb2oJa95Eyhhp1lYB9G2xlqPzdanxvwFI83XpKpHYHdI0jWqcoyekY?=
 =?Windows-1252?Q?SDarVQcrYDfz3e1Yh1DCPpxoihqjgqcTwuK4qRhoOEAhy8uwutOQStar?=
 =?Windows-1252?Q?Tc0IgEKAdL8+HY1yDyCgslp8XxEBXjfO1t9gq0yW/8bi5C9oCgsUjcz4?=
 =?Windows-1252?Q?Z2WZJWnf5kWCIKgJY7HNVDyZoTJLMvX+wR23sV62wRYyR9vn1hFWCdQ5?=
 =?Windows-1252?Q?Zv0iVNYOnB0VC9AqV1OaqLtGsTLOmf2pdI1OhL/nmyBjF3UGCL48sGiT?=
 =?Windows-1252?Q?5cDqW0ezBfPaT+qrn8ZnhIpFIe+4KkMEZfpUyLVOe1+tzCD8P06IFM+c?=
 =?Windows-1252?Q?Lz/8Wb4Z+YSNNcAeqO3eVMoyCGIAbdX3tn/l6sE+UtAZazbw63NDv+BI?=
 =?Windows-1252?Q?BR0/NWw0Y6gQndHVB2qp+ckUdovqXVoB4Yh1xUEcgnzw7VLYenS/P1qv?=
 =?Windows-1252?Q?bt6c6Pw3RR1V2hh8oHbyKeEa898KWHuWmNHvsmJZ83fJerH3p1h0RkyE?=
 =?Windows-1252?Q?9cNy/3dRf0L2ZANLeWbfcO4lZR5fb0YQpZzmhEo72Nc1Z02wESJv6Dd5?=
 =?Windows-1252?Q?q/xn6xnXi+vlVJzz9OW/yD2xI5/iEDwD6RZ+vUGF7NHgi+urU+6GxqJr?=
 =?Windows-1252?Q?xfhE85tUIGyjrvw/PMjxraod1TwNRzp/Iq9oZZ96Cb+vbPsV6MSv5ydq?=
 =?Windows-1252?Q?DyI09mSjE5VQJKUjf29UUcrrTDZy96Bc3OqbJIrztheH0n39kElUWD+K?=
 =?Windows-1252?Q?1oahb3QbZ9Q=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423d4f9c-47eb-4f07-24c4-08db9353aafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:26:16.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VHyF3q+5qBE6N9hB8f6RNqmfzePrB8Cg8cLEzlCYclryzNoLkURjdnKNO5FzDCVlQwSMsuVHUADxUrur/ItQld8QhUCNLJD4lIWXQqg8Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5997
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 12:26:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12536

Hello Michael,

> From: Michael Adler <michael.adler@siemens.com>
> Sent: Wednesday, August 2, 2023 12:52 PM
>=20
> > In general it seems like autoscaling has some issues in eu-central-1a
> > since I can also see i/o timeouts. I'll try to spin up a new cluster
> > in zone -1b.
>=20
> The new small cluster is up and running. Auto-scaling seems to work in
> this zone.

The new cluster seems to be working.
I've paused the old "cip-project-small-v14" runners in GitLab.

Kind regards, Chris

>=20
> --
> Michael Adler
>=20
> Siemens AG
> Technology
> Connectivity & Edge
> Smart Embedded Systems
> T CED SES-DE
> Otto-Hahn-Ring 6
> 81739 Munich, Germany
>=20
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
> Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
> Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
> 6684; WEEE-Reg.-No. DE 23691322

