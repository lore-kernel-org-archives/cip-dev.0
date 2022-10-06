Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577BC433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 11:36:48 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.94])
 by mx.groups.io with SMTP id smtpd.web08.4666.1665056206421883368
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 04:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=GrXXgJbW;
 spf=pass (domain: renesas.com, ip: 40.107.113.94,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrY7uZcAdntGgTRDkdpKP96lbQiJZTKy4ARDRlhlZu2sz+zfd3SKnXMGoADgIoy+RIHDv1lkzc2Q1Da1VEfyWrOA6fOnAaQ8p0j82go1ar7EufTly230nhgfvbI2xklfmIKeVY4ghYUnmJFAi5ut1mb7/UULbiPmUQeDlYcMjwmAasG27Rxl3sC0999uQyMs5FPPDS2VZdD22Xt0u4tauD+XH4Hr7CHDrke4oUyLM+SPpRlUrdAxV3c1IR0+FZjhUBWTw7Z5EdnQ7Kbdotyfj9V7gaLAxK/vkxUlWVnROvMcg/kqUH7uNO5NlQN+pHoqGkn44ghuA7ruT4DySgT1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/evt1HPD+/ZMz8zcKlzNF+OUF9pAdEWeoFqT7NRHLg=;
 b=bf2zq893SFaQ7TihGzxLumJOXJUUuFRU3ecNDS5VhWsrjmSPaqvBENUuZWQPY28yqzbqjmVuPo7/EP9jd9Xf/8+m1tlxiQWiSKVvP5NB8SOwt/usJzy6r1ZpndOHzBFElGqQXBr5CYe+36issy4O3AVOCWKi7mvqsXAEOp4WPiW8WGLxOZmW6w3DjC5IstG7K0Oc0oNm4Jzb2HTpFlb8wKHcZas2QUkGj3AsQuNW4Ho9fXA12LM4ihyJcQ19a38QyRELbN7pFGHKlpZt67gV8ThCOrJkJbaGS3r8li/uZSejkuOOKtQ1ZeB75BQvX+UbKFLjO2ptRYXzYHNPZy5Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/evt1HPD+/ZMz8zcKlzNF+OUF9pAdEWeoFqT7NRHLg=;
 b=GrXXgJbWeZ5RhPCfPoN0lq21XSeqSvazCgsBNgHh0C+3EO0seP6Mw24LcVXK1AAaVq34LXUGCTSt3/+PZchFpDc/T1e/L/7TtrA7hhFyMUP8i494PcKPUIynBFbFqJNWsGpCS5xio7pK5e2Ka2wwxb54vz4gNLxRZx/5uvLR6M0=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 11:36:42 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%6]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 11:36:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Realtime support for 5.10 on RISC-V -- not there
Thread-Topic: Realtime support for 5.10 on RISC-V -- not there
Thread-Index: AQHYvrJ/c4GsPcTNx0mmAqpz9XEiZK3MOF6AgDNG3ACAANM6gIABHlnA
Date: Thu, 6 Oct 2022 11:36:40 +0000
Message-ID: 
 <TYCPR01MB10588BCF13B39AC8C98D0E886B75C9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220902095754.GA18026@duo.ucw.cz>
 <19ae27fc-592e-e3a7-09ce-c258e2e42970@siemens.com>
 <d6824d9f-6416-6d78-545e-a9b425cc1b20@siemens.com>
 <20221005182603.GB16437@duo.ucw.cz>
In-Reply-To: <20221005182603.GB16437@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS3PR01MB8460:EE_
x-ms-office365-filtering-correlation-id: a3e84cc4-a9ec-4c40-f58f-08daa78f0967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 63MfpXY4MxlHJlVV5ump47Gc/B9IdO1kWXSn7XUmUv6TztaYfcQUEGX2QIKHl/M2UOH+1GPx5zS91PZPn6Mz1nTaj25djpd15Xt1WFFTw56xlEUSSJvTFmM1cmuVgEDy9MS55QqJktPHRIZ899negcRBBOGtEU5kE6D3TS5Xd38RWSPlW2f1NhwWQJCGuu5b1/Ac33GhlDkZZJe/sh7+ijjdPW1VtqH9bwYul7vO7XinnUUsGudwEQVpdNrNjIjeG9ofpyU0QUcdN6qe/xUaau1byN3dnm0EATYWclXjft/MgjGg4iWnQq0hQMikiFoyQt6y4FNP/w1A3MgqDEkUmdQHSnzeZYriXGANPc83DmAEtp4Qk1pAx6CH/wmePx4td7MbN53O+2rnqoh7eoM1cykynt90Lmm6vs9vZEQAZp3wO28OTcZqiM19rNIQjqex+AfsFfIUeOEgoKKXyMnloy2V0Zbll6BdfGQ25YT4UYcmHtnY/zPN3fp6eBFDV/cJ+218yerd+oPba0wXVcb9Ganj6lojE7T3DBLk0e7GKJ1TAcDlZOl9wHCOF6LQfrHa4XeCj40PN4KKf/oyqGJX82qj2TLScwVJ0cj5QnpzGvD6H3XrajVPVxaUuzybWiuNvKGKjuGaWMgAfYuvgE7s4V4WpxVNJZs1/W0OSfbyfYCqxtemJUYypPH+t9YPZ5pKCVHVPdRohQCX0DxXL6sGrGjv62k2Dm9BPi6yw6BaRGYdVEG25EjAXwOHpIu7P7v3s3usP8bukErMNJ+JaUg6K/m7HNXCJsiks6/uphWvMHE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(86362001)(122000001)(52536014)(110136005)(478600001)(2906002)(316002)(38070700005)(186003)(38100700002)(76116006)(9686003)(26005)(4326008)(8936002)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(5660300002)(33656002)(966005)(71200400001)(41300700001)(7696005)(6506007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ygbzArfaYlXwZzrXoQnlzXXXXKGbNQ8fEtVgjETsQ7etHBNuj8Yr3Wvf?=
 =?Windows-1252?Q?kxr/2k8KWmUX8h2r/Riu5qpKIt6SWLei0wAGRULaF5LnbUJtRV94Uw26?=
 =?Windows-1252?Q?c2Z+rrBdLoW6or0Zix4EwBdMYM8a53OzBuIB4rF9d1CsHCmywpDp85Re?=
 =?Windows-1252?Q?CljwxqEHTgRF4z6ijKY0t+IoHs60usmqorf7ucOz010dh2S8+/EvdCRm?=
 =?Windows-1252?Q?5gNEmQiNKXBbKlk12lYVVfN/nCcBjCZHzgXYfbr0X6mDiAWuvp4/annV?=
 =?Windows-1252?Q?5ZFpPwEyYLS33ZVfjSMSXk1L5DUmjRYbOybFF+tHi3fZU0cKNZDTFfpQ?=
 =?Windows-1252?Q?K08S3nujV1og3uUUseEU7Wq6NCahvWru2SIreeoI5ZTvPgECC+VP65si?=
 =?Windows-1252?Q?II9hKq8CTX326Q11vbQpDfnEA8bb7X5WYs4q3NH+WCxasJ/cXii+UqVg?=
 =?Windows-1252?Q?ADJV/Y4XBb1vSBQfMlSP2r9o3DwPevv2KL8aUmoxyt623+VyFGBuY4hO?=
 =?Windows-1252?Q?wOpkxoML9gjk0tPOuiDLBv4sTN23rP29AHL0GY5EkcNdVKlo2VrYZAFG?=
 =?Windows-1252?Q?b65RLOvTPp7GlBkgeZyu9a5K7dqgNZ0KF9Ex3OCSAabHDQGQ3mdqXkEw?=
 =?Windows-1252?Q?Si4AOphO6dGSrhqRer0BIN+z5mzrEGO2cMtnIxY+3TiRIKQIhKaChvT1?=
 =?Windows-1252?Q?IKUqSwFDT8/UVEW4pUdYnvdUcvV0as3QWObTQc3rtJx++kjp7czq/YWr?=
 =?Windows-1252?Q?fEwk9T18wT9Vo7mcBFnG3RIIsDi6CqQnflr2RuklOUsgJuK37sCi0Gd5?=
 =?Windows-1252?Q?O3tnUuu/rEbwOESwXqtQfBDYXJ69RLjnClYhJZd0jhfC3OFxtAJTdbjj?=
 =?Windows-1252?Q?Ic1cKYMVoU+hIJ+V9oWMVcpjyQ1zKPmUK/MiuCJEljtTDz2WxvQ2TVYT?=
 =?Windows-1252?Q?yUdnidQ+cLi7ybrA4LZ3GbffR+d8zpFSKe8nORa6Dq4FxQlEOz1P0H9H?=
 =?Windows-1252?Q?+idX/EOwyw3tbVackfc+FnTvSGHK9nF8P2GJzmjl2bK2gfo9JlYPV6Jc?=
 =?Windows-1252?Q?3CfXXoe2L1dvJipumPt0OhVrpv0qKhshEYFi9iIY19NMb6giJncaph/I?=
 =?Windows-1252?Q?FbpOmZpMQ7TzV4iJvvXuOR8LZXb6ALcqQHzHd9VdoVMX+qfLPF7ufO4d?=
 =?Windows-1252?Q?ayzJNylD45sDkwg7iKOprCNbgNzkvJKKd1/XthFq4YPpZa7JKAI7xp8J?=
 =?Windows-1252?Q?EhjE9cQ9akblz7ghjv4sAv/TZzCjbfPom2dLLN9sGVEIRKeC8sVA3Y7v?=
 =?Windows-1252?Q?7beq7d8rN8uBXcYdLVQ9jumd5VySG5GgwYzU+uYdEeWqbAXk4QUqfTeh?=
 =?Windows-1252?Q?sxYrNUAAhdjFS9VGRbwWnvnYUZpRnOz5CBWFjgrF47ngSn/xi9eLJNq7?=
 =?Windows-1252?Q?Zjjod7WplfqaWAoCcpSi0Ddi922dkpNNsejHeoZPLjLu67Ka4mUNDNW6?=
 =?Windows-1252?Q?LtfiJipXwyU+PVeheUegyfmlHM9yuhcZF6YVp0jwm82eot4gMoKxzb/f?=
 =?Windows-1252?Q?jCbcuKSV2NwmZuIfgNlh/gH+Lw91ZbvWy0Pv4JeastUc+c3eoYZIZcPA?=
 =?Windows-1252?Q?Ge+8x6TJRynh2hkXoopJcXdmSn00ipKMCYO/Nz/Kk42nW+Es0DnPr+Pt?=
 =?Windows-1252?Q?nFIG9bSmi9H6RVG4csmuPcgl5OxpSIDYVu6h0uo01NyY1cwUNwPCOw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a3e84cc4-a9ec-4c40-f58f-08daa78f0967
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 11:36:40.6004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 un18GBTQ3bGknwh/t0s51B/AzWQZDqXBko5O7IWr1iK9IrVaCgiNqrzq3KitzT80YswI6BorynWTwHGBwvS5xZcsPjszdcF80APCbM5M9C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8460
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 11:36:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9660

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 05 October 2022 19:26
>=20
> Hi!
>=20
> > >> I do not think we can or want to support realtime on RISC-V at the
> > >> moment.
> > >
> > > In fact, we couldn't realistically commit to such a non-existing feat=
ure
> > > /wrt long-term support.
> > >
> > > If there is interest in enabling this, we can start a development eff=
ort
> > > in upstream. But if that could then be backportable only to the next =
CIP
> > > kernel, would even be open.
> > >
> >
> > http://lists.infradead.org/pipermail/linux-riscv/2022-August/018823.htm=
l
> >
> > Maybe there is a chance to have this in 6.1-rt so that 6.1-cip-rt can
> > pick it up.
>=20
> Yes, that can happen. Plus, the patches are surprisingly small, so
> maybe -stable-rt tree picks them up even if they miss 6.1.
>=20
> OTOH maybe if would be good to have feedback "is someone using -rt on
> riscv, and if so, on what hardware"?

We're not currently using- rt with our RZ/Five risc-v SoC.
However, if CIP started supporting it we would integrate it into our BSP,
as we have done with our other (Arm) products based on the CIP kernel.

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

