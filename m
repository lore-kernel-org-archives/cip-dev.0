Return-Path: <SRS0=4x8b=IR=lists.cip-project.org=bounce+64572+6297+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB6C433E6
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:06:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF3C64F62
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF3C64F62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6297+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vp6SYY4521723x7s5oneuvim; Fri, 19 Mar 2021 00:06:12 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.99])
 by mx.groups.io with SMTP id smtpd.web12.2927.1616137570808504329
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 00:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEiWzGcP1N79czoDF+jPGTkud6hg6rP/K56/6BPcaEW2zv6p/kIhGpFFZUYGfPD0y9FHS7jfAXGpWjkGF3ZS2n0hjUODmdJmJh31c6ogByMoXomPOOemv1S3rb8Pefm4q0oGYWHZv+YiYL7vuaxWNpJcdQr/A2qKs5Gt6ABjj34LIvAwEu/t2kXGgAexI5DYK640HcEiVTRoN3iZB5TTtBZUziuXy0r71Rd1RA3rW/Vq35NyjANPVdoFnMneDVqFskR7OpfnUP6wQLj2vvcqmqtDP6nTF/Xaq5NNNlw/XWX4MUvQO7B8d+aWZLYu85BUsJirgNWK2FpjIgkjktSpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqwhz/juTJpxoihTOIyOoukynhG3x5UgXdFcjBlegsY=;
 b=UonXff1AuFFeap/R/l+mtvtLHYE46mAanPqe4L63zZNdnHT873RfDmh/1/sUI+jDGD+E83zgPtR7mcKu8teG5pKIp5ZWZMmdt2G+p5GTTEI7nIqwpZJa6KM+3/zvYGx5H0noNfUoNY812az9i6HkQR+3Tlo1/Zqggt/mosXhPJ30EiJXimVabkgm8KfUINYAXpaeSZi3nyrygKAmNPgEmHteiHVEhyeWk8/bD7jLN0Wtt4IGk456ReQqK3gt8xgt8Vcz7i8+kQPMCCP2bQNA8BfDj6tOQn9FLRLz17L+D45MV4mMePVrA3XIZtQkkej0oB9jjRJKmq2ypprwPAWk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSBPR01MB2392.jpnprd01.prod.outlook.com (2603:1096:604:1e::9)
 by OSAPR01MB2692.jpnprd01.prod.outlook.com (2603:1096:604:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 07:06:04 +0000
X-Received: from OSBPR01MB2392.jpnprd01.prod.outlook.com
 ([fe80::ad93:a607:e841:de3e]) by OSBPR01MB2392.jpnprd01.prod.outlook.com
 ([fe80::ad93:a607:e841:de3e%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 07:06:04 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] CIP LAVA maintenance
Thread-Topic: CIP LAVA maintenance
Thread-Index: AdcbzkOQKf6QAN7RRByXfiJr+ZwsYQAv/28w
Date: Fri, 19 Mar 2021 07:06:04 +0000
Message-ID: 
 <OSBPR01MB2392E14F337E62A92502D5B1B7689@OSBPR01MB2392.jpnprd01.prod.outlook.com>
References: <166D61BDF351CC05.5206@lists.cip-project.org>
In-Reply-To: <166D61BDF351CC05.5206@lists.cip-project.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2bfd70d-1b9a-4a2a-e877-08d8eaa57647
x-ms-traffictypediagnostic: OSAPR01MB2692:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2692BDDAA9B88C5491512DE2B7689@OSAPR01MB2692.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KcKCt8W6bu2P8GMRFLGy5y7O9cMNClY/cnuwoEoyNUdTgxl0HM/kVuCLYrTDvt8QIiTt6Z39lBE8l8trhJ0BXn08QSa1VXdLgMP/rzD7i1Bkvt6rKCr3c+viRfCT96+BVG9Ka6tfIAOoPPfofxxlxjNT21NY4hKfIbQJAYo9/M1OLDkM85zMdOe5ega5pDm2EUsH078dq3sPAgflDOM/KrdNl7ytNKPJD6k/1p8ape0oHBShzOmmzWQakMdkfxPbiSGVv5bczGq33SgcF0dcypkY7RCZuhJJe8uNm5fMKL9Ah6tqSi0WzYodQ9C5EnRZpCgUldP6uLzxdTm7rykWU0QV3QbRDm4zhDWFL05d4seuFXm6a8t69piugsv9mz429oNsbhhas10bI+oZDo6ht3BG0AMbiW9UdDnz7ONJcLMifg1s4NFY+sXRu9c0mxI0Z04hCqlfIPDjkhbxwwb5kHd/5dIlV8a/3y2zQKJyNGR9bRzzWJP8kinX3Dfrah/p+FGpycon7DxjyZcsVBgwJU5oknRkbZPG2S3+FUKCBDxS8aRzhSsqRU0ZRaA5frIICjOUgOE324ZemMvupmcWwLCJLNx8aYte+pmy//+7VWWDr00VcpGnPx9KtdwpD1WcJD8x11hAft8LzwZ5vD097q9UXQ8j4P+F1WqJhxP2Nz4=
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?Aq4pCu2VlAkw5d2Qw4AwvSbS4qyGS+UNFvG6yZxEywq9xTMWxq09m0HW?=
 =?Windows-1252?Q?aYPHdPi/Tna9FU19yXSmF7CRUiwdo1+5bXl+FLQgoN2J8y+bpCYryiJr?=
 =?Windows-1252?Q?yl3RAxJRFAxRuZKRaENcbdwGXuW3gxX/ax3gkb1YOOeiWwk9RsDfMvVv?=
 =?Windows-1252?Q?dMxmX+Tlv8jz9cuti+7zIbSh+EEiVs+lQ9IbotRmwdvWFK0DCCMOYMiF?=
 =?Windows-1252?Q?3G2xY/gMrpbixB0SI81j3IoMIl0J5N7vTzh/rPRd3dxl1f/6HOHR/nyM?=
 =?Windows-1252?Q?bXqQMPGzXXen+NamCYN9C5BdX9wQbFUv8ORZjGgGyliVqJ28etcAyNn9?=
 =?Windows-1252?Q?qTnGGPhmSYZgJOp1CT6vfsURma1K3up+Ws8vxaI3JR56iyX5tHvc/ZPg?=
 =?Windows-1252?Q?J9ixaDUpPeyZ8iP9TQAZmb4h0UiDeC2ths9Oiwv/+WN4cufjuRaDEk2E?=
 =?Windows-1252?Q?Q/49cHWC87kQZu2F+ixkLdY2kXqwBgzBn+vRLhWD6dXizme0JkmVG9Q9?=
 =?Windows-1252?Q?HTDLKWzsFKYVT4brBVcb3gjPSLIBTUWwR6k5aHari3gi/Yyw9SFtFyZy?=
 =?Windows-1252?Q?VmegBBOCvLcONh3hL1D/TYD8+lF6QyWm5/p4xa0GdLsEHe8/GoKbyf9Y?=
 =?Windows-1252?Q?OYgGKftiSkxEEVsbzkC5qrulPOWB0uuu3omTMMQZRLU4EFGFXdRkMnBi?=
 =?Windows-1252?Q?8yLiPLD5fb1aYZ8w99bdOO7NVAdSsIGRQrR1m4yzgVAM96R9IMG35V+e?=
 =?Windows-1252?Q?iZ5NiuJSR2EAUDUXoPdvmNGEUFuFQ6yeVWYKNe+DskAZHT/yFwVwKvPO?=
 =?Windows-1252?Q?/qz76YSDLlMRIcv2CW0jb+1rn4LqfjNyeICYo6p4/PyLFPMlUeSgOEtQ?=
 =?Windows-1252?Q?DcG5jXrRJzMSWTUZYvw4E5nChrco6DfdFPKzbPaEOkNJoMszcuwzWxGp?=
 =?Windows-1252?Q?fBV5W0ijuNi4BTxsSZZ79LwrBzOKVzWDaKD5J4/W9IL6kSe6ntK/h2xk?=
 =?Windows-1252?Q?ehikX1G85QlC7Bhb5RXz1ypEscREXY7iuFq0PWrKUnwkmgvydIyc63Jm?=
 =?Windows-1252?Q?QeRM/MnbiQyCvTiyG5jioOa+uwCamToBbgnE4dGtCN+Tlz5iG3ypeOq5?=
 =?Windows-1252?Q?7x1REFLjCK3Lol1I3prrJfQ37/e/1InQ/b24ncfBIuzhk7d5y6zchFrb?=
 =?Windows-1252?Q?072ky+0MrSaFIRuq2+ztavAO4l2HmhYSNR+WKNq0/Y7J68gHeu59Urfr?=
 =?Windows-1252?Q?uCuQACTW2QAIiJxVBYYt0f9iVjEPpGU/RJakvt2m0ZCoYXEx4KqXbpT9?=
 =?Windows-1252?Q?VSsl27MruRMlAYnc86b5QsOP3xM5C3eH5Od2gNHQPO6MDCKAtbofVtRP?=
 =?Windows-1252?Q?d92OdYaC4v/piSGPFcKi2UPd8/4Hudji6kGI7Y8fx7QA2E5TtFNvyIWr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2392.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bfd70d-1b9a-4a2a-e877-08d8eaa57647
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 07:06:04.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tp4myL3XTHEDw6CPSLFLzMlIJL6on4f9YQT3uZuTIANdxUFuoJFwbDQE/twBm0bfyqbTllKFaeJp8njbTAf2NHnEcuEFkrMAo94PTJnGikg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2692
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KHWQtNuzGJAGajVEdE9zx9cSx4520388AA=
Content-Type: multipart/mixed; boundary="RlrwFeq9WFBxcObCum2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616137572;
 bh=kA/NNNGKxcKRYKcC2q8yY7yFFTEWFdFxEs7N/M6uyTk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=X1rq/DgD8mkyfjwV2p8pDqBU8wlZJSa5BFIRcvb1lZxmqBzhRLu+5B4cSJk1GAVQN3A
 ziBmi7Hx7XwNr8FsEno6npiNFjsUk9daxUVx0ozOVVLPncreIXsUWcTJMzTncBuwG8u7j
 Fw1aab7wSDkavDdkHbOJxOuzQ6wiqTNpf3M=

--RlrwFeq9WFBxcObCum2C
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 18 March 2021 08:15
>=20
> Hello all,
>=20
> The CIP LAVA infrastructure will be going down for maintenance very soon.
> Upgrade Gods permitting, it will all be back online later today.

Sorry for the delayed notice. All of the labs are back online now.

Kind regards, Chris

>=20
> I'll keep you updated.
>=20
> Kind regards, Chris

--RlrwFeq9WFBxcObCum2C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6297): https://lists.cip-project.org/g/cip-dev/message=
/6297
Mute This Topic: https://lists.cip-project.org/mt/81424532/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RlrwFeq9WFBxcObCum2C--
