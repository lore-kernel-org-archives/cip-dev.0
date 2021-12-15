Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F010C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 10:34:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.136])
 by mx.groups.io with SMTP id smtpd.web08.38872.1639564495955363802
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 02:34:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=e4JljlAa;
 spf=pass (domain: renesas.com, ip: 40.107.113.136,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwDzR+nY63hnmzrXKWjrvozTzvfyRWkOIhYwsICcwlPSRiJN9h7u5bX7kV7jTNgTyYai2hVHl/RyofHvDLp5uetJzkOSxDHNgZiL7+qDFRP7+oMW0jJqz+cHKrK9By3GgJY4OOXIwH5Cexl1T1H81uTu0HN9u/7R4FjvpRYSUmsmn1/b6Kzx1Qr7bRxKtQhyCfMnZ5JNL8RE7YFX5uOrl4bTIMEsWZybFs17I1gI2/HclMRmOSfiYO444A3sjwkFJYFB6biRDcmaXLg6nbCAbLXMg1DvB0FLZ4jspTIOrKd4sSuHsTPaCvhhjf1KNuhP8kRCRaRu1hzYlFgfRyaPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giIgIpoXfAtbeb4kBLP1axlLNDPa1LpBNX+6F+x0d3A=;
 b=jxfK7GF9CCXsbEtE4PC/0QFq6wR+GQFgKWv5+8hfI0nzZGlM9Sena1GCRFel0OagzWasfZA1OeYA5s8/+M/vj1waY16zLI2ztuDOhtLaZFBgJ7ANjOmnPi1Lj7nkSGVWz+9EpW/mdzbEqhhSAFWLBcHgOPUX3atEC16RsiIrc+PIN8c9/MzxUUO/Nyt/xIU2WwgSkeaFPt6y9KHb5MsG64r0t/75ldb2thovVDqJsnWS/iDxQGdG+8CD5sg+ApPu+7abb/jim90TtNrxYse6JM4jk4BupOMLeBHIgmhWZ0zC1o4nCXve8eM5qllBh3B1zis6p05mBaUgNr/194e0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giIgIpoXfAtbeb4kBLP1axlLNDPa1LpBNX+6F+x0d3A=;
 b=e4JljlAaCWDha5IZ9eId+bEDya8gnVIcCT1300Lz+QOslb0aA36GZoRzKoWNLHVkQ0ZOcjbTi9Lcvo86Qh658vvryPV2QWwnvWIJO9RZ84qrS7SRnZ7rGBzsC6dsfNmcZEcXLiS1jLnM5CwW+v1zmgO7P+xCeXKW0w85Uw2hdN0=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS0PR01MB5876.jpnprd01.prod.outlook.com (2603:1096:604:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 15 Dec
 2021 10:34:52 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 10:34:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U0yXDMWkTY9nkegXZHak/5YsqwzVAKAgAABXpA=
Date: Wed, 15 Dec 2021 10:34:52 +0000
Message-ID: 
 <OSZPR01MB6877AA575BACD21ED96F9B53B7769@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211215100537.GA18047@amd>
In-Reply-To: <20211215100537.GA18047@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a519a4e0-52cf-4eb1-6574-08d9bfb68740
x-ms-traffictypediagnostic: OS0PR01MB5876:EE_
x-microsoft-antispam-prvs: 
 <OS0PR01MB5876ACF9648ED24D384420B8B7769@OS0PR01MB5876.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 L/A6SVAhC2Mu2Ym07np+1R3ZcmmmqNNyispWwmiHUUAq02LSLuA1GxsmJj+PiPjVxtbQIii3aYv/PcqFv6D2ZIK9nunNqYe7OV2wMGeOGg7KKq5ejxc7e2LT95XBX8tVIDkNFYdjATWZpRwMSZ49Qx7fVG8099WNis1z7HT2oNE37+r9Iht0D6kqGTE7f6hRoJYkBKCWlnS1wBnF7las1HilexwdiIwWC9so/sZ789ZpHMf5+1qnZlHedBIgznEfyzV1LS+Jw82vmpim9Be1e0CZKcBs+WgIinqreaCzX6aPSGmql28Ox5DrZPHbaLDc+UKsQdabuTZ0zDMhyYyupACLRpe2eHpPeivQeZ4KBaRYBjC3wUW3lc2fXlaaRyreCMsfavmtCkRDJRM3tLFWnpl+ll5quh3ptmZjrfKCSZYzJ+fVibiDtJDHRt3mmT6kjF9CtTaqa0cK/zjeI3UhK90blCbP6QVl4UyIa5y8zi0dXHN4VpQHg7LFWlL12WNfWOULBINbsSGGbGCNGRho+v4r1gfbIbzf6G9jc8SI6td7y/vdN/Zxp0cPxcputQxB1SasUDb5a9xgADzlirazFSoGgnzOLleDx0FUC9p25ma94fP53uWd+wr6NCFsnh542OnF0NpfxiXANd/Z3h+OCC/mRlmcWiasvC6zggbpbpmjttBnScqcNSJYthASXW3cx4Ql7OC9D1ull7R8ucpDOw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(76116006)(54906003)(26005)(55016003)(316002)(52536014)(66946007)(122000001)(186003)(66476007)(8676002)(9686003)(66556008)(64756008)(4326008)(110136005)(508600001)(33656002)(38100700002)(7696005)(5660300002)(86362001)(8936002)(71200400001)(38070700005)(2906002)(6506007)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ip+j6aS1+7K1LNaPMBBAGggscYBzz//tJX1yM3fS1wo/PRRyw+zXAb8g?=
 =?Windows-1252?Q?bx/IZU9CGv/6hKR2Def6XpPdsVIUK9903aD4KcDXfE6kcL72zBVrGRpZ?=
 =?Windows-1252?Q?UkTUGF3m6l6Re1h9K4wMeT/rWRYi0i/8sBZJaYCoQv6dKGOjnlPTQr3k?=
 =?Windows-1252?Q?iwMIlDzws7v43bMaSGt5Ruap/3G2D4g00VvfK5SHqfhQcYAweKv7JUGn?=
 =?Windows-1252?Q?jDSHO1xg8HjSOnyNfUdpivw8NmwGFqdC8hzITDUTw04T8quUuw7HF4My?=
 =?Windows-1252?Q?rpW3jhR0QOwBmFvc3ILjksyf9KoxLEeB1lXRpS+mE3s0Emb56HDtDUkx?=
 =?Windows-1252?Q?OCu6ptZHIO1rnHp/l+1dKqLM8xHVQr3GGgBl6OuJ7nw/QCxAA2xLxJ50?=
 =?Windows-1252?Q?bZN2VsmgC70WXhzBM26m9NUE9qa3R9+KvQQ8iqXHpVV9BdQ234yh1714?=
 =?Windows-1252?Q?5x//TXWXOImI9IYHpKjmtn+okWkC2I0NktrmpgFh7EwAvP7u6GYIfFfo?=
 =?Windows-1252?Q?Fm8l1amZyFg9DHcXe+OH/wlys4cVVxPGUgsSRsVDqW62wsgh4gAiNPEj?=
 =?Windows-1252?Q?jik0c5Vanzj8T/MpAQPXapIMMecZXEztDgyjUvX4YZXReI3+6wrPPhiJ?=
 =?Windows-1252?Q?RFJXLSvKyMdLvjyCEQUbRmLdMhzgiaklB6GNhVmrrjWRMRFahlpJnorJ?=
 =?Windows-1252?Q?sVKJz5343k69IBuVpv5PObOQKs37arrTszvbvY2Jiq++hY9qTMHOIm+V?=
 =?Windows-1252?Q?l4NDNe/T3I7X/JQLJw7rlFHP98knDoA5er4vI2zhxPZtG5KV3zY1mB2l?=
 =?Windows-1252?Q?1a+LiulBtvH5eXTIpGWTc7oK5sEEG4v3CeBIuQ2XIsOxDWCepKL/VkGJ?=
 =?Windows-1252?Q?2R9lPt4POSCc56LTX5pzHfx4sLNIhNNjObsTvpj7NK/ukUOgZ8A1U0eX?=
 =?Windows-1252?Q?gPIXbhyRstShjvSZgKDGuFNQ/+bGWU2R7qdZfGCZrIWVT/AriITTMAAp?=
 =?Windows-1252?Q?PLrioaZukU9ovPV2/OHvFZ9j2bb/dZPftOECY5yKzqqnuxS8tjzNuCVx?=
 =?Windows-1252?Q?vPo+MLNMoDTL+ZFYxb0O1MscnbGzzw7UMVgt6RmfxW1iQ3kKXfoiCrRq?=
 =?Windows-1252?Q?OOAqCrGe0Vbqd0smPcrtOKkZJKJIr8rdUtybnJG+njWtqh/CRl51oh8Y?=
 =?Windows-1252?Q?bsLsT/o1LnNAzPWmvf4GQPGTOLE1wRD/t4/v/NpPFKZ8Ue9qqPiLVln2?=
 =?Windows-1252?Q?Sg2k8pOxpsrYD1QjqMLx+9H53tZy020TRUpBYyyDIzQVGGjHQeDsNjI9?=
 =?Windows-1252?Q?Ea7+v0SQpxBp+jry/MIXjZpBxaVDnxlKkxb3hRBAS1HhoNXGxeapOqRQ?=
 =?Windows-1252?Q?pAU2a/g/MXYnOCHS8IfHZeFc+gP7R0Tr6W68WNFxXV17WRiWVH1/EQbp?=
 =?Windows-1252?Q?WjHAafFAbx6hhMCY2E8JfWIEvHxynApzkF8MBKjRio4PAZBPOjVbI+2L?=
 =?Windows-1252?Q?69KM8PmWyhl2XIwG7GEGVUD+84IoK7Td57tIEc93hlSt2fQe6YWkmatS?=
 =?Windows-1252?Q?Cboi4/rdaPtAa9IhM06d7BFyXoCZuFbaPj9rJeu6mtaeEC3PTEHfCUFd?=
 =?Windows-1252?Q?/2hU/vtde86P0/XPLrutiek9GOkOIksawOYlndQYG8KEkCc3wyK2dFwr?=
 =?Windows-1252?Q?5nxPwgIdj6zWyBeQlEWbggq6XzUqusN5sgBU12fed25SFCYi8TQ2cgL0?=
 =?Windows-1252?Q?5Ds36kYCmh8393lI96Jb9MfEfy96xsJ9X2UXEEIwMHuimjPLIOYmqGCX?=
 =?Windows-1252?Q?MblRPg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a519a4e0-52cf-4eb1-6574-08d9bfb68740
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 10:34:52.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 X1vFGoYNuHosN8DjDAaDPJUNLVwLSBGY2X/4pD9Qmn6PZMekZRvfyUe7PFFcBvpQjYGom2hU8WNXqgiolMkoX0YIl1r8ULNOHtlcrETSktk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 10:34:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7110

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 15 December 2021 10:06
>=20
> Hi!
>=20
> > This patch series adds initial support for Renesas RZ/G2L SoC [0] and
> > Renesas RZ/G2L SMARC EVK [1].
> >
> > The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
> > DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video
> codec
> > (H.264). It also has many interfaces such as camera input, display outp=
ut,
> > USB 2.0, and Gbit-Ether, making it ideal for applications such as
> > entry-class industrial human-machine interfaces (HMIs) and embedded
> devices
> > with video capabilities.
>=20
> I have reviewed patches and they look okay to me. I'll proceed with
> testing.
>=20
> Do we have suitable board in the test lab / is there plan to add one?

We don't have any boards in the CIP labs yet, but there is a plan to add so=
me.

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

