Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BDC19F2B
	for <webhook@archiver.kernel.org>; Mon,  1 Aug 2022 14:48:19 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.115])
 by mx.groups.io with SMTP id smtpd.web12.25886.1659365291739218796
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Aug 2022 07:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=PtqmNaKI;
 spf=pass (domain: renesas.com, ip: 40.107.114.115,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7e7yt4mFCovxmDVshVqHrls7vUPDFr+PptIYaM4udhcYn8U2eiqdPNSY7pyZTPMXXSNgE+Ts/oy13J6RKBYlE7TPPHC+Cc56595noXVJmtEhDKBjH/OBHyHqWWWqd0txJ8/QtKah2mbjmnbKBkO/A8YFDXsOGkjQQX4q4sXt0ZMQD2f4v4QdLfLnQ1PWWxJKd52vpid+xWL0GQ2foauYPDgA4gH02B7XUyjIkoEVKrUEaVG8+nQL1mroPF9klte6UEOHPJdSYbaPDN8qtxzVyA3rW2XzodPIGdIJqQykjrgOQViykDNLphsrwQHo0C5bI8kOLGytDXvthu9QQqE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T8J6Xy5GY8PsbINIaeuulBsxbc8/U2mcL4/M6g1RGI=;
 b=M9NnUgJsoneF3srZJ83HcgdUJjJin8kfk1vHRCom48Jgw1FjJ9sAGKnxV0Ug3gqSRXZVga/L1xC7JjWEV1ME7ww3PxjGmupa4syPflAXBfIBsSbELr9ZbJOCks0lJ+SnN6HnJrP/c00CJdNHAOV1loBv5Ycvw3JAX4OXHLh71crACjKdxJuhOu9lFWp9O79ZGlfb8MiC+aD1UmY4EqMOkqjoixT/mJ1MfmNu9ekFlJSxmFfKbCEiFXMrpKFTy4SRNHQclE94bp8OkFJutWI1y1GVQeILeNNxXfQD6pAuNKQt6wjdBZhFmjk02ju8BFLNUni2VhT7uVDSXX4botuf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8J6Xy5GY8PsbINIaeuulBsxbc8/U2mcL4/M6g1RGI=;
 b=PtqmNaKINn1Rwel14H7uJMqR8CnQYlbbNdATyCI+E5NucpFzYW58RF65AX1SOUoE3kj2RTPvYc9HsohKGag97W9cWBgJiv9koRrd3drfevq4jxN6ut50hM2iEKAJ/Hv6K3m7/FFGIkgJ6Q8geBgd0bqEIhqz5kANdIREx2VcGsM=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by OSAPR01MB5090.jpnprd01.prod.outlook.com (2603:1096:604:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 14:48:07 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::b5df:34c4:52ae:80ab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:48:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: lab-cip-renesas offline
Thread-Topic: lab-cip-renesas offline
Thread-Index: AdiltYy100MbHMb8S+iw13ruOkT5zQ==
Date: Mon, 1 Aug 2022 14:48:07 +0000
Message-ID: 
 <OSZPR01MB8124BBBE939249259ACA396DB79A9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f609f2d-fd49-4e41-620a-08da73ccd8fd
x-ms-traffictypediagnostic: OSAPR01MB5090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nhJw65YYgcqxxjql05+M3Y6oF/vumbwW/+JzQiCXxuU2lOEsD1EPKesK7Pq2XHlXEvhimI1Vqnr4XfVF45Z1TTxos3G5/mGzTzZIPUqXq6B8pcBO6AoGKIuoiprmJdscfI+mKrSPf5hS4KFB3FrlNNrA6+cgYcvoi0jPA1BjwfP1UenWnu4LXVO9HpkFplgrwH4HWRGisNwWD7TD3HI1407CBpZS5EBzCaILaGQJBp0DhygZ3o3MZGENq2aHqLP91iBG+6kwyiTJ8lR55PIRI2BG4ha4rGgNWmA8G8K7QuIPMVeGeguCLkj/YED/MKifRbiQtapT3Dmau4rjtl64wJA39nbqIb6lkW8zepeZd/yXyqr0lXW+Qp9ZgexBbRAXRH/LmEtaVB+zhDFNq6JAPhdIYh5k040fi/b0cAH+iaPQx30yPTar6+oIrh8R05+Dpm1gSzpk8tXwotulbOfJjzyJ9sp0YdTKGPYzGDmK08pRsIM3Ew/Il+6oB+P5EsRw806DLrSF+dwGVH/ThK/1gRocq1H25l0UJaBSmuBCqzZvq/qzyOaWCQpmeNSCduv7J8UhXqR5/AQ5ZvlfOITCEv+uGXPrczqMYkqlBnpHbni8TMqlhbE1FkUf0aRMuSGQYxiBgkdb7UEihQaquVaUzc4/P4lGTyA98VvfrJ7jJ9OWTGfzzYV01O+D+RZ3ok7mkW2l/UzpcXGKtqNn/FUwEffMDs/x6RAFKU3Z32wjmbG7OV0ck7HnzDbDrtE62neiUHH47aE5wTzyWLOp0GAwnkomC6pB1Q50dQsJbzqs7PYHmYIFIKhUNYqCVaZ8WcMa
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(2906002)(55016003)(66446008)(64756008)(41300700001)(76116006)(8676002)(33656002)(316002)(6916009)(558084003)(478600001)(71200400001)(66556008)(66476007)(7696005)(6506007)(66946007)(38100700002)(122000001)(38070700005)(186003)(26005)(9686003)(86362001)(3480700007)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Hf6/h7/JXSNrDZ13/sRCOkA/eHerOr4E2Xzsnwu51z0+po6VI5/DXZS2IS?=
 =?iso-8859-1?Q?hyu42fGMLkmAItV+AMybUyYspB/R1igK0Jr/CjgtAuq9m/zFH4grgf0cES?=
 =?iso-8859-1?Q?6lBwxVx0FO0Qp2j3832+ODTwBDwKPBWGhNiy2ZgUBYzTRvRKer9PbH1g8Q?=
 =?iso-8859-1?Q?VHXzygORD4iXqREQSd7854lm2gv57Ol6jVZR0oX/VZPpb4ipnQRgcfmaby?=
 =?iso-8859-1?Q?nRXWtSANvIcGDoLiXJLYg571H6rJf4L5xUYQHsp1v6ja3yY2dQRRwkEuv3?=
 =?iso-8859-1?Q?WOdndeynOqaVJPwFmrFGk5mk8jyOMw2SzlXhMFz/C7IvaGCeZPtQTcT8nG?=
 =?iso-8859-1?Q?gzIQ74vyZS39aqUlOKsPkB46HoejI0LOt9UylreoAXOmXuQ777Ps/FFeZL?=
 =?iso-8859-1?Q?jRmNhj+DXeAhYq823MehQRRTn52FrruSG6S3Or2Q1RTjmbjzmvTPEMXoMz?=
 =?iso-8859-1?Q?40KLxNYVWth193w1fpRLmfB3KAGRVto6uL7c2grXtvsvVDCjy1MGZKfseh?=
 =?iso-8859-1?Q?Vpg2dOgf8PJJMZABkL7S5vmDumKNghyDS/2lqM9yrW9nKk0MaZwvEsyKkZ?=
 =?iso-8859-1?Q?ef4fSjJcBtTi1038Ns9VBJJoY5csMt9HzLzvEOt6ClZ0qPlwwKCjFz/H8y?=
 =?iso-8859-1?Q?t2cPuM96tdi4+SyGH2pQj8AyP5H2uMK/l3oAONoM98bu34ANv1rBWDyMUn?=
 =?iso-8859-1?Q?3cn3+mXmJ2uM0ipW7d1of0VONC2uwEDR40dDFqGzFtfswtNlkiUsbxkvzw?=
 =?iso-8859-1?Q?BtWJlY4yJxAnX4Yx8UJ7bgbVR8PqqAxDEhs11gWXVQEAB81u96Luw3NRV8?=
 =?iso-8859-1?Q?QjQ3LVySpk8D+PS5m8hpMg3wnlMF2ADu+FqpRRgcaqqzcHBtJq2HtFAgkI?=
 =?iso-8859-1?Q?xo0wMhr+nZBvTancFLNA+e1EYhnPEbSYpy98g8B/enpZxau4CqQgol8hhT?=
 =?iso-8859-1?Q?LX/eyPIswFEa3g8uYiAFV76P1Umc4b6VCUFtBg5v/RX7M635WEUTDTuoTr?=
 =?iso-8859-1?Q?9inLhQD+AVSoZwoiEJrvI51vyChrmKPhhnIgkyytmWIVBhltNk3KoaTQNl?=
 =?iso-8859-1?Q?El+gaZvzVJaqGdO/gaJRebbFJ0y0ObNqxDBiyMJ9QZeXAlgy71ZzE9dMzG?=
 =?iso-8859-1?Q?NHmeeSApams7w3W3WTVyGaZHW9IKI4TpoR4XmXLdWXWeyF+TM/frHkNtWl?=
 =?iso-8859-1?Q?fHSFgLBpTnrixPJInkzst4zATp4AieRpOHWWJzI29k6x9ZNFua6Y4DDOS4?=
 =?iso-8859-1?Q?GgEnqMukzBrBEE/h4wiLT7VGgLk5LEU1zPn7fqYR079wpkwMvfAT1et6Vc?=
 =?iso-8859-1?Q?/pVWY5uZcAaPXHQU1mxjxzd2ZhV9SDNSzdjXhmD7yoFSd6J7DMb3r9/5KW?=
 =?iso-8859-1?Q?khXgILWGI62/M7EjNdiLQFo/L1jOVZJ85rRo1ZengRDaZF3q+F+jv9S9v1?=
 =?iso-8859-1?Q?RNx51MDHAmLLDvU4Wqx2OfsNgtUtb1e8uSiEkpbbeJiqM3x5wOVLf0VvET?=
 =?iso-8859-1?Q?B7zIWqOiH+qQrvoPiL9YyuAERLfiboPCAYrY2BcZGwsFMNYuhnITClfX3n?=
 =?iso-8859-1?Q?o8cBIGsrcKnsMZ4Yk4gFEdK/7vD269XQJYlPkMlR1bCUvbmAWVbDLcZoIf?=
 =?iso-8859-1?Q?+i/EvuN+1j8gQQ1gX5CREO4Ply6SUY/UjoIU1p/We+LrEtlhioMGA1EA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5f609f2d-fd49-4e41-620a-08da73ccd8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 14:48:07.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 orZERhZxu3G3j1FR6TdogixOlHjvIIfyAU7k9kjboM1aoKTN8Af8w73HXBwb01We56gEBv/hw+mwBoRGnb/07YRaVDOR5v8wy6dPBeagLkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Aug 2022 14:48:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8990

Hi all,

Just a heads-up that lab-cip-renesas is currently offline due to some netwo=
rking issues.
Hopefully it'll be back up again today, IT gods willing.

Apologies for the inconvenience.

Kind regards, Chris


