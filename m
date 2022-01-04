X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.128])
 by mx.groups.io with SMTP id smtpd.web11.4895.1641291920409531966
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jan 2022 02:25:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=tCYYBBYN;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.128, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncJI5mEovNls/YKjOs0FcZIOWwmepbjLTlsNb5ajnaJZJ4np9CVzUZBcYadHfe0H8UAglBhczrpphd+wO08lj8m/WMk5XMaM1XcAXdEt8IlG29bjeevmenpIxwraZeSmy5fnkz/VbTdV7pJXgYe/II8lSq0HDZDFLUEMJycBVaI3Oddr66QnVwstmSAseFXoxxEXtCwgZbCTg+QUnB6cOhQRJmrH0nMx8jZGwXLuwScNquN9lYVKOkjMegvhEgEcGZAs4HybZ15Czk2WgbyHLa1pcKTJO8aUVUIhBo1E+P+Eq53wOFFrFlE1hLfVRbb08ZjDBw3pr45OjILvYuEHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itvRhkSQDBha/kYGgMVuC+huuhVkTksleHvLLIBB7DU=;
 b=G8FJXia8wKw1drbX167bulysYpfkJG5h4AfFPKXsbumiCqLpzDwlPusrQCttC/0YQjS/pCFjZKW/zQaGEY7Zjg8fxV/27Qom1qPCTXtl96YIfFqtYAIi+OYGYElDkEjg9vSSi0ALfWMEufCizeN0sXW4Zir5+LVEe1I+rpx/61Ik4H/TZFqfRSIR9xGaF/Rt7lY0mY00Nw0H8Qipl+5Run7JnTYYI/CdmREJZphSDcCxlVXWiy/bMSR8xLwg8Dn/8BzuRcJxgBtZV+Z1FDm6NvXrAJPFYbjlq+ecYPq3BEiwOyxZhhlb7M9OehH8e55NfIG3W/KwhFWZsZzvQlyWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itvRhkSQDBha/kYGgMVuC+huuhVkTksleHvLLIBB7DU=;
 b=tCYYBBYNbUJCx7lzNcEvYsZ8qEGy9kTMBxlCUgo/NDYVjxcVA6UNkWsw21ae//CP0Ir+KDhHBMtegOc2ogiyF6XxAmrgl82U4J7d3SwEkUJrMJ7gwHdOPlVvYHuGt7khacxo274ju6DrkBcfaQaVk09Byj4xbtA6dPOhmQ2fzfA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2936.jpnprd01.prod.outlook.com (2603:1096:604:18::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 10:25:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:25:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi: Update slave dma channel configuration parameter
Thread-Topic: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Thread-Index: AQHX/J0HP9lPQ++CME6E6R4yX4bAkKxK3i+AgAfS5HA=
Date: Tue, 4 Jan 2022 10:25:15 +0000
Message-ID: 
 <OS0PR01MB5922FCC356872BA2E9901DA3864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230105507.GA9799@amd>
In-Reply-To: <20211230105507.GA9799@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e944f40-76cc-43bb-9dee-08d9cf6c7ff6
x-ms-traffictypediagnostic: OSBPR01MB2936:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB2936770F8D967E806E1E2CA8864A9@OSBPR01MB2936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RxT7LS7j+ShgojFIBVn20OlpedBp2+wFkfQgz229GtyCnyX47xmkVR+39AwLcgiZGNI49aabrlfSh8Qr259vU0qN1GHVBFqytTSi+ztMYbq52q7v5N1LtKwdR33+j/0TvoRzBXcY7NDCx6K1Pk6ZxtcopVp8SILguwB1HiakYdM0qePKdA9sI2xUihbwByef5N6cX3YoMMU4+pqiVGxuRo8wUtSda62TtKuT3e1TOhR/LmK1pyRDnyEzPz8wpEPbB0bir8MkwyTg5eox2ThEaYBoXUWKEbaWffM247MCos9bbBkjPk8SJd+6/UDSbEMej5ey11h8ReukF3qqqpdVFYuzYkOVFsC/wkakgsPbMNpWfR0Zysy0WS468rWSyTfJTkSciL3hN2kmPWlXHSQpE70TWhgZhLmAIxtjBDTLUlk169VJPYhBvHPxK7IXGdSXWSdmnS+gF8Ht36g2AiTZmbQGwEPwFBEMo3c0RJfRUGcJJWZX1vHEVfUN0HyZ+VwtPcitzVJAlbgvz4ZzLCx+lb+EHnzvL/JbJDXYoxfXdMJPSqiD0avAkN4olDFGC2m16cYudeESGF88VpprEwjAVwJ2/AgNVmQDut4KFRHq8rNj8cehhO2vDD2EYnov2g5dkpApa99Ddi6XzB338fe97HQTIt9WwKedfeufceier+uj1XSHf49I25nznzjCMJslCcUNF8bFxSH8azICVk0Kjg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(33656002)(55016003)(86362001)(8676002)(26005)(508600001)(71200400001)(8936002)(38100700002)(4326008)(7696005)(52536014)(316002)(186003)(66946007)(66446008)(76116006)(38070700005)(83380400001)(15650500001)(5660300002)(66476007)(110136005)(6506007)(54906003)(2906002)(9686003)(66556008)(6636002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IHPXn3h95ZlYrwfttz4RMBDdcZ17m3ZAEfEc7ySRjS5QTe+cLuByRqbiAO2o?=
 =?us-ascii?Q?UMS9+CALUArPUDS2YiyXkS6ZEiddkZJJaVzfb7lTY/+Y1KfzDR7KfqDAHByi?=
 =?us-ascii?Q?2VxieUilXaH8lMLUjutC1/d4bwn9H39C4qN/Sufcp6Z0thPlD5oI6EjKcPd0?=
 =?us-ascii?Q?EGITnn6VOc07uKypR7p6N3mAeas8+/ydOeuZlNyLSb2keUGlkVYdX8NACCjL?=
 =?us-ascii?Q?4FgiX8gtcJ/EiPUdfZ4KDEEQHpFa2igqVNmBnuuHsum5nhfMjae5s5NLRB99?=
 =?us-ascii?Q?ZnNk9g6oFZ+Cxy4dcUGhrf3sdFEjookqToOsmXQadBNDMa9MZ+z6ro4LfWvB?=
 =?us-ascii?Q?qvK0+TrV0wUjkyZ1aC6M9SLdOKDWYYY5pELR3Ba//Kv/6GYX/Kz1iY6ZdKK9?=
 =?us-ascii?Q?zj1tvrzN5qZNoOTZyrRw94QgjBkquRnso0eSTglKv+4jq2VQwwscJ51zZZwo?=
 =?us-ascii?Q?rGU6+9/vO/zwhwXu43TGTxt6REGXSGeDj604UraERLTMD6HqaGOg/3ittNf0?=
 =?us-ascii?Q?d/HAbzOYKZGVj8v0JUuLodjUcySUK6GtyTh+TQVI8W7XabF79O1kV/GcG9ZO?=
 =?us-ascii?Q?A2kSc3MldzZcSgTzk+Z6MFd+hnBvBK/cmuLk4vOUVbNbiNF2XqahFNwpBS3D?=
 =?us-ascii?Q?nyIVHzS8DBWCUZUKd2wDKwMfgJGJLIAIGzFUJqXMzuE9NioyRuvap3U0r0bJ?=
 =?us-ascii?Q?Nbj5G8jAYpvZZIKG5JL0ox5R7gJ3+3D2godNdsmS2JlrF7amsqNPDFjIjYQm?=
 =?us-ascii?Q?APsrvW/qwBfFUl7sg6e7Bwe9ICSSxa+w+C8+22hxBreL3Wd13Diwn+fFvT5v?=
 =?us-ascii?Q?88ohSAjnkLZVGeGBQ7oZlvYuc/XxY6hO88uRfN5LFt0ajWl+C6GrLWMKRYeo?=
 =?us-ascii?Q?hLCPkEKCE1XS7QrjaxzQa+WkIRuzIJxYxo2z12ZV3V2njQLDLEPBADMA2sgQ?=
 =?us-ascii?Q?uAyZQbJbH9p9anz7+3XyCSGQtiUCvY1JycInnCZ4gEOuV9ZqgRZpAWlri5hc?=
 =?us-ascii?Q?X4q/EBX2W7XgFPWA1vEntqIeFCrUYPqzuAetGqWqQhtJivt0kipsLADfHCOO?=
 =?us-ascii?Q?vdAVR1cky7lwlxMOcCC+auXZ0cTPGEWGGT+LuHEzln47qhiPP1f9VFLPcJVF?=
 =?us-ascii?Q?O+Y0LJaRXbGd9v5n9MitEkBxt0EpG61eumeMBaO383PzPfSMCJpkOlZmu73i?=
 =?us-ascii?Q?yt2bq3GGzvW0X21uTrgbunxRqP9Gti+WTRr4Docizg8X5MOU/kjoiExkBoyY?=
 =?us-ascii?Q?8DtfxC18EC7FR0Kve2ZvPVgw0KQZ7lmoJ0Jifny/frUFBbKnaPb54w3ctESy?=
 =?us-ascii?Q?m2/hM5GMZHZVJS7B7YatwPwefFIY9KBZRqDbVaU160MukEx1zs4d5WlqtW6E?=
 =?us-ascii?Q?4Zsghlj93a0hVsK3B9mkMKMHGBvp2H2Q1oPXNVTQV858CUEsm5LO+12h45wI?=
 =?us-ascii?Q?iNKrKt0tanrB4CzXltcIzc8pRKiu2sNq7q1cCbOuNwL5w/fv2G3UmMnF97DT?=
 =?us-ascii?Q?PjfAdHKflC9AcWhmwh96S1MQ4DIKz5gioV/TG1J0uA0E5x1JZ8SigLBfuwal?=
 =?us-ascii?Q?K/SRROkC9yp2sRv7wyNtnLe18pSLub/7rXnPiCFY6okRHAqT/7FxvYm5UTB8?=
 =?us-ascii?Q?PaDbBqucqj13ZEC+sza0ySWrw1JvYENKKz5n0SXIoJ3DJ9vUUBzoaVgZWlz3?=
 =?us-ascii?Q?v05m7A=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e944f40-76cc-43bb-9dee-08d9cf6c7ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 10:25:15.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inzKuGH2vbFZAlR9nyv5Urx0nrZhts3leQZR3Vfifd5CqJQiyLpir5e4TSyIi5KcteTDLS8HvUPIxwu4hPe5m4F6NVhbULtXNyjcYA4JIrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2936
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 04/31] ASoC: dt-bindings: renesas,rz-ssi:
> Update slave dma channel configuration parameter
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit bed0b1c1e88a27b76c74584128cadebc6fa58622 upstream.
> >
> > The DMAC on RZ/G2L has specific slave channel configuration parameters
> > for SSI.
> > This patch updates the dmas description and example node to include
> > the encoded slave channel configuration.
>=20
> > +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > @@ -48,6 +48,24 @@ properties:
> >    dmas:
> >      minItems: 1
> >      maxItems: 2
> > +    description:
> > +      The first cell represents a phandle to dmac
> > +      The second cell specifies the encoded MID/RID values of the SSI
> port
> > +      connected to the DMA client and the slave channel configuration
> > +      parameters.
> > +      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
> > +                    MID/RID value of SSI rx0 =3D 0x256
> > +                    MID/RID value of SSI tx0 =3D 0x255
> > +                    MID/RID value of SSI rx1 =3D 0x25a
> > +                    MID/RID value of SSI tx1 =3D 0x259
> > +                    MID/RID value of SSI rt2 =3D 0x25f
> > +                    MID/RID value of SSI rx3 =3D 0x262
> > +                    MID/RID value of SSI tx3 =3D 0x261
> > +      bit[10]     - HIEN =3D 1, Detects a request in response to the
> rising edge
> > +                    of the signal
> > +      bit[11]     - LVL =3D 0, Detects based on the edge
> > +      bits[12:14] - AM =3D 2, Bus cycle mode
> > +      bit[15]     - TM =3D 0, Single transfer mode
>=20
> I wish there was better solution to this. Device tree sources are quite
> human-readable, this really is not.

Can you please suggest the better solution?

Cheers,
Biju

