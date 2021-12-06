Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0FC433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 09:08:44 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.90])
 by mx.groups.io with SMTP id smtpd.web08.49096.1638781720912277412
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:08:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=WFiVmNQT;
 spf=pass (domain: renesas.com, ip: 40.107.114.90,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWIq91svVLg2lfu+NgvVUx7WiAsLTJtEbCcn7zAJ/346Tvcr2BovQlKM1Qk7dwHCHveUZc6p+56owNDlO1y3FhrFB6yHK34W0oT4TtlIBWdKSY3tHrYnPzMSsNxgyN696eu6LjsfET8gkRz0REfJbqO9HvHvW3UR7eC51YjLaZqmEWyruGcT13ExoHWXVVAfhIKGR+BYfD38W8yf1Nk6ct5c877R60IARvGrA3ZnsoKLSW/rMaaIFsvkCD9Q9ZpJYrO3bo2RVhQe2dyWz8WAIbZpPZNCGhBwwwnTAA+6jMylVxWlhTfIi79RfVF9aBvvx8dVzkecpZcy7LuJq5DPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGl27HYChHpxtcLUtdM3vkbbFJQgs2NqEWMhzRDZc6Q=;
 b=TgDYbOdymA95XD/SwthOTEThkAruTCwa3OMwXl+i+P4JkyNgj2Mv128p7BRNWqxaWu6Qy0nQT7x7LzAW6iapCoBTMmUcaailA5X4lF97WgsfSukM1gO5mZRjLOhJ5icXl1yaP5/fvPDMrj9Dp61raKjlU79ZBl9F+74huusvMyPUrgHcrZZQG/ouK8RlSuwu1igaKs0eJMqI5E71EJW+/E2thoq2sMJG7Ienu5otPI/WaBtdmvTpSY07YM3BOuSh6voXm8E5ValktVaG1jC5XBoe0a73JEQtkieNgS08rMtE4i84HK75LfjANnPTij6IvNm32JuDLfnK8cfrvfCF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGl27HYChHpxtcLUtdM3vkbbFJQgs2NqEWMhzRDZc6Q=;
 b=WFiVmNQTJTpk8lC+z8itOPPaO4a3ygSzSPpAJZQcEIfIGuyyWaIJ3sXxqhE7oP/Pyn+EPFy3H7g3hZ5giSmRpy/js/ddRDmcTB0FBwCACL8Vu2YHn3TLkWHDsdY0GLBt8Hj2BaqcoqKQxnFBh+iUlnyB7mG+M43FBA7tnOhH0tI=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB4087.jpnprd01.prod.outlook.com (2603:1096:604:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 09:08:36 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 09:08:36 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Topic: [cip-dev] Planned maintenance for lab-cip-renesas: 4-5th Dec
Thread-Index: AdfdQY0ruckuk3pKRXmKZHiU8njZGQLPw/GAAIAK7UA=
Date: Mon, 6 Dec 2021 09:08:35 +0000
Message-ID: 
 <OSZPR01MB68771C64F1E64D3A47F3472AB76D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <16B8F29B24FD30B5.32206@lists.cip-project.org>
 <16BD574183886849.11393@lists.cip-project.org>
In-Reply-To: <16BD574183886849.11393@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 742bc9d2-36f8-487e-0425-08d9b897fc31
x-ms-traffictypediagnostic: OSBPR01MB4087:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB40870EC71A5660F3A6CD341AB76D9@OSBPR01MB4087.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1Po3hPAtjY3HI2NRJ7X8uM+yUMZSNZ/VZWAUOKBzLVT8z0BCcSr2QwdAjPa5OK355bwkhqKk6p6/ycreJf9hm1S0G6YOabBBQ9vDXbc02f/T+tz2sIZjUBY/vIXBuq/8/nH7w04ye5FBBWtr2D+ewtM73EAFplRKcUPTJ/cURbUOsUUNDkO8tW6BiLBVNIAXq2cWngu+swKcbTdYLstsP5Hg7Fqi+xnu+7b9Tgo3uWHWtDfRPqEwSpjxY7sMlSRau8koLTqxrKOzDP5y5Pl6LOsBC9CLbE7O+anFp9PVX/jZfW0uSp7B+Ouvqn0k8+/icMPRGbCPQq1wDeN9m8ptG3phMgKVOi6LaGdRqGqQ6zApK9pWbtj+IsrjsNjptZiJ7dF5sOf4wmfcEKpjZ8gR+4+8YRPnOs82C+YpezoMWG8aKtbxr+AuJyDSSV8AfIOa89OvZfYqcew97Eo36amRGpgbDFn8FYPY7AdX4uyu0Fvzb3dQXQLsuijo4+U9ftkOt0L4Es8FCp4DjQpj2/sY1J/d9+rC4Sbi/CIxEdtV53Yy96IwoQTshjHMC3SQqU/SocDUR/br3okbUSnLBKejt7CGhi73/CffBTXfwFtN5TR44cmUT6XJn+A9RJEm2sIUjw1MUdw2cz9S6hbtk3DPnR8PxZcN0oyWqyPJrGnrtYco8CLRqdnFWbTln37t1wGVKH6lUWxHRwjW+ji3pRqH6Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(5660300002)(7696005)(2906002)(38100700002)(38070700005)(186003)(52536014)(9686003)(6506007)(508600001)(86362001)(76116006)(71200400001)(66476007)(316002)(4744005)(6916009)(26005)(66556008)(66946007)(64756008)(33656002)(83380400001)(122000001)(8936002)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?cDZVdQ15SlEbpHJvJzhMC+lN9h7ElyLlul7xaOiZPp3T4LAfXtUxmMVR?=
 =?Windows-1252?Q?mGgiGrYYFvlqIvYVTWChXnl3V1EbQUD79s9Mp2yf0jQ9dGFz9r4v93dy?=
 =?Windows-1252?Q?uyJIUn5F9ZYV87o/fEDoJ0apsm+IAT0UB8zf57IFblFGbsV/okGyypQg?=
 =?Windows-1252?Q?o/JZYuHQbJJa3rnebWpbcAlBtST42AGBBDGTo/T33DfRpExle+xlA4jp?=
 =?Windows-1252?Q?FdbAv5ayGZ44E3C8A/9EpMgspaUjwoTTCaOtza0d01R+vB0JU1DGHxre?=
 =?Windows-1252?Q?mMQSju4ZNdSevwH9B5tPjoiA3Oq65o5EofkNaDiKgs6qJGs3MrJUeiQ/?=
 =?Windows-1252?Q?S9ldw3qezK2MGZNEI+L11h/Hjv70HZgDQT8pHJI/e9ncDEBbZDB6zurN?=
 =?Windows-1252?Q?tTYXKmteYCC2ptClI7mNG6HyvNHNA5qIiebVicze4u8AlcVnZmXTD2KP?=
 =?Windows-1252?Q?oVv+58D4outVw6X1CzZ0MmYPlmjNertuIpCTIhCya9T9dmtxwqvNHdsl?=
 =?Windows-1252?Q?jfQ+D6PNNFLZTzhO2LtDqYS1dL8AVH1z2rueSGIkhPoQoTKz0KMbmwSK?=
 =?Windows-1252?Q?w0VvUN1ylHMEfWz0Xqx1HojsLyhV01AOI0Htc6B2MjBnEAzeZX/i8ywu?=
 =?Windows-1252?Q?Vou2fnMZBPpowyULazR4bRIRUnTHWwRRFlhT1rE+1A8icyHEx2m1HjNA?=
 =?Windows-1252?Q?o/ILek/VwegrGy8qtEutn5InDxdMEYZxkSvyod8ZIlxqAgFqWR6w01JS?=
 =?Windows-1252?Q?O7cW2PSlN5aNsuXHw+Evcfi5p9p4GFUO7ODg7ohKBon9hseM/QHvCc+P?=
 =?Windows-1252?Q?vvLXgUrHycxu2t2eegAJpMz7TF+nK0gMubbcfB8DjM2zDQ0WsEuf1ghA?=
 =?Windows-1252?Q?HcR5xwcax1umaOZNa3jQWISWve1Y7t5pNPjXRTAjeUwsb939pFt4HcjZ?=
 =?Windows-1252?Q?Kw1sh9mdTvLBfxy659OhrRv8BjTxlHM2jPksfo/B0COoyhNdHkVQBRrW?=
 =?Windows-1252?Q?GUltSmZDm9xb2WTDTxSZo1zjGcg4bKB886w7QxwHlw96VCPVKYA7/Cvh?=
 =?Windows-1252?Q?Qh+CBT7ecQY1SpOVPNAJQrTaOldl6hgOvqhtEIRUi/N08TbCcR4zkVgi?=
 =?Windows-1252?Q?I9SkdhKFRJZj+zp4/ERm4ucWP1CpB6GYZ2pYx6piGpfk2w4Cly/oHBXO?=
 =?Windows-1252?Q?DNZwfttVOZfcO6IqRbP0GrK/kwUS5TxGjewq/Pwpi0voTYsFzy8wKx+l?=
 =?Windows-1252?Q?kvjhnjCQjcpZUZRLsGEXrVSeqBt9MZeEU7EVETLIDg5l3znF5i0VITWl?=
 =?Windows-1252?Q?O2KeEWi3h2BXE9QDDAk/IE4YCHQ5M9H/NYlhq4Y0DPHkbw4fuAA8ErLx?=
 =?Windows-1252?Q?XaUUvXVfrstpC5B7iGY48DVbc4276tCYtla/7PMxWbZE9LjYDoXolipp?=
 =?Windows-1252?Q?Om8G1QpyI7sGer0ZFQBY+qPmb0a/ZPfLuEybAOw0hs2Wh0CDKWRJlkoF?=
 =?Windows-1252?Q?OAxUiWAVcxVh2sHcBHpuBftgusPm31qA/xFLwhhMBHI9yjA11d9UBIcL?=
 =?Windows-1252?Q?R7yaxA/ItgtzGKpQSnC1CLFXu2P3RIPX1YyCeRQPlpiLKVBKcihPJpBE?=
 =?Windows-1252?Q?HpPO0I5qx/iLKW+zQ2PykGXPM5QZVhh2tnPahGGq9rf/AqQNiWeWC003?=
 =?Windows-1252?Q?uYOarX+5EXfaqOisCXICayojIMYDZT1ZR8rKLdpcYtZUtU0aFXvaeI7s?=
 =?Windows-1252?Q?3tzo5KvibhzljZ1OGlJIUeqBBqylyIxinmUqhfmRYWEcZNs/Dr42JhFj?=
 =?Windows-1252?Q?I6lAIw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 742bc9d2-36f8-487e-0425-08d9b897fc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 09:08:35.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 fZym/3OYlm7vvkp4qzk2rhyMLNZOl0ShwoWseezn7mpzGO0p8tnOG2hLUkSt69wBm1VyTEsGow+5nsUeaEzz7jC76qMrY1d0rhYfzqVUCjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 09:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7067

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 03 December 2021 20:03
>=20
> Hello all,
>=20
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Chris Paterson via lists.cip-project.org
> > Sent: 19 November 2021 12:33
> >
> > Hello all,
> >
> > Just a heads up, on the weekend of the 4/5th December the Renesas UK
> > office will be undergoing maintenance on its power infrastructure.
> > As such I will be taking lab-cip-renesas offline for the weekend starti=
ng
> from
> > Friday evening (UK time).
>=20
> lab-cip-renesas is now offline until Monday morning (UK time).

lab-cip-renesas is now back online.

Kind regards, Chris


