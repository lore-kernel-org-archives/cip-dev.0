Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B33C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 09:17:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.5519.1666775870608567024
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 02:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 29Q9HfXr016591; Wed, 26 Oct 2022 18:17:41 +0900
X-Iguazu-Qid: 2wGrYy8wQju8WicFXs
X-Iguazu-QSIG: v=2; s=0; t=1666775861; q=2wGrYy8wQju8WicFXs; m=7WhfaR16MwXikbMzvRkpQ3H40fkQGJnWNPW2qXmPBIc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 29Q9HdpW011858
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Oct 2022 18:17:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCnByuf6mC2UORntOFF5b2hCo5ItlarK0+ojnUePvGsz1c04Mn2zunT4SQ3JtqwvVS28zYpb3xtlEegxlSt7Dqd1osiJjPtv6NH7rm+FtAghWsuuaTNlVXRSP9KNiCo400hmRxf9POdI/RcJotZChR4oqfr8dj8HuOxlybkHu1JhkDiH9tZkPsXk/Hep4hjJ/H3bysFa6Yp2cUzNvW8vd6wU7kO8/lCTf18OV/VdNPm/ItFnnE1XrgZENL1UCv5KVRnlUlaI/vqHGlxOwzujL6KowNYwHd8Uo7pMw/z9wMQkfCGRbGO1HCLyAdv+Or2pHTML56IUSuiYknHPdObaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgdHz9CpFvSL+F5A6QXOgkmzt4dtWTjgZjYeemg3EOE=;
 b=KqOqw/ilg2y6VKBSVbN8B491wflUzDkfkhbvn5DLKj1H+nf4fNO2hH10Au6tExIJEF+MB59ojnvnQR6erkFgxnDUWjjEPd2eZcZheYVHV3rFVda9jwG2Vus56Woujx1p/qJ2FH9hEoOXFYrxHr1BkMmL/x0qiTVOGWTVOlHvCuFRaTz2rj38CQKFQDBF5uRfDpjlEvwR4+M8mxVOCjS/YCqBqmpWn3hB5lse3C9wvJ2qn7Yjx+hfDLTwno8qSKD6SNIFRVJ0S688WSQd8uLNw8eeThBvhrpZh3GPNes/M1v0/Yn+WmcPTHLAiAb4llUzBkrMhiyhzeMnVhxoxMOgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <Chris.Paterson2@renesas.com>, <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Topic: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Index: AQHY6H/2vC16E8yKCU+FOCnGG15fqq4gX1hAgAAFFYCAAACFcA==
Date: Wed, 26 Oct 2022 09:17:36 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94209F1AA169B44A1D9B289792309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
 <20221025144131.1309463-13-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94206965A39B29C0CA0F5DBA92309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OS0PR01MB592279F2C193D52F724D777D86309@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592279F2C193D52F724D777D86309@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8421:EE_
x-ms-office365-filtering-correlation-id: 991f7e48-b2e1-4384-4434-08dab732ec41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HyR33rYnWrRND1A6J4U2G2rbWY3QdmoznFe2p/O4kZzDw5RCkbb2n58sqbC23n2XG+oO1qgwdYBxVqOWJVsXFWAGmn42l9rODZILW/sXo4h31IdffRxc/5Pz3Gis7Ln88XV1j95te58v+P1rCy4uBv7lns1eHBpchJYdoBu4MwvVBlbyHqEGnXKTFqWSBzvYvXBr5SIh5fxpCfjOF96mhRPsL95iyfSMvB/ZySdLWxTJhXuMEbkLgaW67f+syK/xqklfQZBAsisxTmyrZJxHxMtNxJN8GlKSX4zmDhckK8oY3hzimv2edqp/huM/SxWI8hPZuXgl4Dj8wo7VUTCW9hX6I+pw/IzDx1tB+hoFlFMrCKzOKehNiZdeI+k41l+pZQrteUaOEWmp65SWAg9MXd86QZ1Yu/AD1B1Zek4HmXhA9q0SQIav7Rmp11kCDAZ+hJ+ggDzqzAJ3LsGDez/j6L9/0VwrmCdhf0zfoN0/BZEX7NBQ1tuC9xoSTyQdU2f6i7dA8I53iAaSWdl+q+fvji5gDWYp3BVuoaKhTHx7cDJg/JUJMU8ppZigWBjj66cC2puXnB830eWqwYmgKZPnledCFdlgDRqtBzMPFzunRqcsNupvhpJkwp/iBqdBPrge1dBtUmhzCi01bzEPxFdFmzrHT/+hvOTL+7O9qkkFckI05kdBDBwNX6W6mX+BwaFHJfz5pIwYpG1smHUiXYK2G4bsQPZHFfC0SoO9nHKnJyRsKf4bulzGp8JHwNQzvmwTbBTdyhttV7xToEqXkcz3wdEZU1uWZdAAO8me0pMi6l4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(52536014)(86362001)(5660300002)(8936002)(41300700001)(9686003)(122000001)(26005)(38100700002)(38070700005)(186003)(2906002)(83380400001)(33656002)(4326008)(966005)(71200400001)(76116006)(478600001)(110136005)(54906003)(55016003)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(6506007)(55236004)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NG5wQUx3MUxUeGdrZmg3eDZ0QUkzRElKRk4zclMzYVNsb3lnL1lkOGJl?=
 =?iso-2022-jp?B?S1hBSHFBZ1phM1FaOENwNWxtbGdiSUZ3ZW5JNTNmSzNZM3hucURnSTJK?=
 =?iso-2022-jp?B?Ynh0SE85S0d3czc2ZW1HL2tmTi94Z2huK2p2Z21IRWtqRW96aTZSSnpa?=
 =?iso-2022-jp?B?N29rQjkvZkZVZDE3MWpZRSt2TWxUOWpKNjdXT0hPSGtRa0dBNFg0akJV?=
 =?iso-2022-jp?B?Wm1SdnVvK1FkWVNrUnF5NTFEUW5JTkFaUTc0bXpUR2k3ZEJDeDlEZm9v?=
 =?iso-2022-jp?B?R24rWGZOZEtydHNUZytUU2xLWURtN2t6UE9BNGxWMFh1T0hFUWJLU2dM?=
 =?iso-2022-jp?B?aEMyMjExQXN5WTlldlVNSjlHdnVYZDU3OGMxbWhnSGNZTFVPd3h0UGdM?=
 =?iso-2022-jp?B?QWtmbzVKWCtBYUJlZ2xnZk0wa1RqcUVLd0MxMzRrVi90UWhiMHpqVTRF?=
 =?iso-2022-jp?B?MkhwVitCNlhZRFJPZVVUM01FVVkrbzRmanN4YUJ5MnJsY1JxNVBlL3l6?=
 =?iso-2022-jp?B?STBEUWlnbk81ajFjMnVUTC83eko4YWo1QW1saWQrZWJuRlpDVmdTUnFL?=
 =?iso-2022-jp?B?SXJtSUZpRk1wOXkxSTNyQUMvcDVSU3BnbnRHZ2FnWGVLZXZScXFTTzFR?=
 =?iso-2022-jp?B?SEtNU1dIQUhRb0JiZUcvRFJ1QjZ2NnlqNDRDQnhEcW1TMjhEaks2dUJv?=
 =?iso-2022-jp?B?YjJHUHlNQnZ1THoyS2JlbnZRaWZDUUt6TGc3Ymg5Zk10NkRsbzM0NWZp?=
 =?iso-2022-jp?B?M0RONnlRRE1yclVKT1JoTi9iS2k5bitSakp4eDRlVVFCc1R6SW9WZmd5?=
 =?iso-2022-jp?B?aWlFdFlVaHFYdzVIVkRGYWhTcU10UmdZZWJTaXB3U2R4bnJVSXlZVkM3?=
 =?iso-2022-jp?B?WTZxbzlGbHVXRGIwdHQrVVhQZDRMOWpza2NZczhjbCs3Y054VEE1cmo4?=
 =?iso-2022-jp?B?LzlNaXVIYTVmVCtTcDdSNG1TcS91U010UVV3UXRsZ1JpUzZ6NmoxMWc4?=
 =?iso-2022-jp?B?VGFNRzM2RDEyWnV0VHpWVlpraFBST052VEZoaEJhTWZyUCt1UXArVHcy?=
 =?iso-2022-jp?B?cUh3c2RLcFQwWDRRZVdhYmtFemFjakNzZHRhR0FqUG92WTFmWkNMRkE3?=
 =?iso-2022-jp?B?SjZQTEJTMFhkS0g1QS9pRndsMUJwUTFoOVhtaUVBcEtkMUFBOHQ4S1ZU?=
 =?iso-2022-jp?B?cEtTT3RXSmd3TktSMzFzZURLZUxUeUlwY2xUQ1ViOFlROTdTNkxWSC93?=
 =?iso-2022-jp?B?YXFWNWxKTmtKZDJYdStkUnJMbUcwQ0hHSDNOcVdreEF3NU5KZU5rRG55?=
 =?iso-2022-jp?B?SFlyK0tTV2xteHBpTFJncVI1U0I5VkFwZDdvd2tSQTJOQ2lNL1pFc3ow?=
 =?iso-2022-jp?B?TDFxR1FPVTV0TC80cGNJRnRNQ0xYWkwxa2hRY1gxTFk1MklNcWVWbDlx?=
 =?iso-2022-jp?B?N2NwUHlNU2JOMVpOTXh6azVYaTRqVVpzTVRzYkd5RUczK3FjMFFQS28r?=
 =?iso-2022-jp?B?eVU0S0hlcXA5N1Z1SlRKT2RlTk5lNysvRWtVdlBQRUZldXU4d2hsR09H?=
 =?iso-2022-jp?B?K2UwNmR1NE5MU0lhbXpMemhwaURxSXpKb2JvYlpCOWc0Z2l4TXF6dkZm?=
 =?iso-2022-jp?B?b3ppSWtvL2w4dTQ5Vk9xVlJjZ25nM1hLYVpIV0F2SlhtY2V5NmJlYW5K?=
 =?iso-2022-jp?B?bUt1ayt2UjFjNGFSRGc3VzRad2RBaElGN1BkZk9haFEzV1krWlBRWlRR?=
 =?iso-2022-jp?B?bHZCMFcxQnBLMGdsUjhzZllkUFZQdWxycnlaQ2pwVUJvc0ZRRjVoa2pK?=
 =?iso-2022-jp?B?ZWRDZFpBTWJaSTRVMHV5ajlVWmk1QzhPMTNaSGoxYUtIZWJOSjQ4bHdi?=
 =?iso-2022-jp?B?SWhyOTBFaXZHV2VaUHpCalpGRHpkb1dmZlhxU2VzRlVtVUZoeWNmK3A4?=
 =?iso-2022-jp?B?OWtPMHlVa2dTaGwwVThvbFg2eTc4MVB4cGxTbVRuN2w5ZXNiM2hkNFhD?=
 =?iso-2022-jp?B?Y0FvUVVKbjFxNEh3T0lPU1JyaDloclpJOUxEL1l6ZHVYaWs3NmF3R1h3?=
 =?iso-2022-jp?B?WEtxZDZibmNPK1ZMaEZ2Wis0dmE5OGwwdUprMW1WN1d5bXA2U2d1UDVt?=
 =?iso-2022-jp?B?c25RamU1NE1SckhkRmU4NThnaGRnRHNCWjU3UHF5RTFqQmc1eFpPZXBW?=
 =?iso-2022-jp?B?NXk2Z1VVdllHSHVWQ1JUVEdEZzFRc2FybGhrSnZCUkdWODczODRYNS9C?=
 =?iso-2022-jp?B?aS9pZHpSWkt0ZWh2ZXlDeGlrZGs2MURodzFXRzlIbXh6MzRrQXJ4YWxr?=
 =?iso-2022-jp?B?T0xNSTBzdWpNS25xdmV0VjZUS0l5bXZNaXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f7e48-b2e1-4384-4434-08dab732ec41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 09:17:36.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiBi9b7Og9PBxk17uu3Z2GL+bQdjmmsuwGU4SGfNzKUFhCWpj0cLKtZuEmZ4uA5gUa96pvjFjWjr7/zgJAO1BxP5XtA/1VSJl6O9/eygRIl34b45GPJTwGeAXl3wFXPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8421
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 09:17:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9849

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, October 26, 2022 6:10 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>;
> biju.das@bp.renesas.com
> Subject: RE: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface supp=
ort
>=20
> Hi Nobuhiro-San,
>=20
> Thanks for the feedback.
>=20

<snip>

> > > diff --git a/drivers/net/ethernet/renesas/ravb.h
> > > b/drivers/net/ethernet/renesas/ravb.h
> > > index 0b5801f7e961..76ae3b5c568e 100644
> > > --- a/drivers/net/ethernet/renesas/ravb.h
> > > +++ b/drivers/net/ethernet/renesas/ravb.h
> > > @@ -189,6 +189,7 @@ enum ravb_reg {
> > >  	PSR	=3D 0x0528,
> > >  	PIPR	=3D 0x052c,
> > >  	CXR31	=3D 0x0530,	/* RZ/G2L only */
> > > +	CXR35	=3D 0x0540,	/* RZ/G2L only */
> > >  	MPR	=3D 0x0558,
> > >  	PFTCR	=3D 0x055c,
> > >  	PFRCR	=3D 0x0560,
> > > @@ -965,6 +966,13 @@ enum CXR31_BIT {
> > >  	CXR31_SEL_LINK1	=3D 0x00000008,
> > >  };

<snip>

> > > CXR31_SEL_LINK1, 0);
> > > +		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII,
> > > CXR35);
> >
> > "(1000 << 16)" is a magic number, so I suggest defining it or writing
> > a comment.
>=20
> Renesas RAVB reviewer doesn't like macro, he wants plain number here.
>=20
> See [1]
>=20
> [1]
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220914064
> 730.1878211-1-biju.das.jz@bp.renesas.com/

Thanks for letting me know about the email you discussed.
Got it.

Best regards,
  Nobuhiro


