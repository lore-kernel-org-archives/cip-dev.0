Return-Path: <akunuri.sahithi@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F717CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 14:24:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20819.1781792688767225955
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2026 07:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: akunuri.sahithi@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65IEOj1B4069477; Thu, 18 Jun 2026 23:24:46 +0900
X-Iguazu-Qid: 2rWhvgZcO5oTE9yySO
X-Iguazu-QSIG: v=2; s=0; t=1781792685; q=2rWhvgZcO5oTE9yySO; m=rQq5WMHOZN0Kku3bhPgCwSRd/a8Bm8BbjRiQ8kNweiY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gh2zx36bpz4vym; Thu, 18 Jun 2026 23:24:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow3tG7fAJhxCB1tX/ETwOAb6ZqyYk3b//n1b85u2rjVQyfKqYN3W36efP6yiGmES4lexCrcGWHuoFBLMLNkRtzN4jWG1qcMVxwQcUDUHPHk/jB4pU57nnev6IT5lKWKB+cfakhrMPVmmimDd12j5+xYuA9FI6aKmGkpk/hSXoVmxZS0/f4EyCDv+DSAo0147eKNz7Gj/2A4qXo3PVTKUGD/+FEguDBBhydCTQ32mb1w12sLITV75Ur8XneZt/kBGlqV3h8K5oJK7n7FZtp0bo2fh+lFKoupmdur4FnrFZ06HAM3mnbWf8PNp5AY3sdp+VVeBRlcy/9/0wZypiMQdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wduqCxxdFJvKJxro+jsFrMAkd86mis4Pt5YEkZjOfR4=;
 b=b55fWi+VXXMLTNrDqxBv+m6hG+8cwjMPSoDya60gs6qIxY6v2V2oSlfsLuxpxzKKpkeoX6Q+WBSvmdQvkfoek2uqJUN6edXInFLijBkFDRRMEx7lN/GEF4oZRQBzPzi3JJIYSdH/LeUo7KrTavccKoy+AIP/FHiw8CdULubmF7hd0Awpv8c7coCie+/ZJCMCiLuNutbL+U5XuBYRVPyBAQ/NQBi2fQFfh4mgqb3MxcFBGN3at6gKyH+vy1T6rucqQgpWMNCulCJZ39qMzHnV1cvKDXkuZtYeu76lMQ40u4ylBP7/woTzMZCTAui2bS/USzBByAUHHfLCP77p9xkwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <akunuri.sahithi@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <TSIP-Skelios-Dev@ml.toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>
Subject: [ cip-dev ] Enable Autopkgtest for passwdqc package
Thread-Topic: [ cip-dev ] Enable Autopkgtest for passwdqc package
Thread-Index: AQHc/yvqFIEP+UaloUCuZx37TwFSdw==
Date: Thu, 18 Jun 2026 14:24:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYYPR01MB10592D65D23BA0EDC6A01ACF9DBE32@TYYPR01MB10592.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10592:EE_|TYWPR01MB9510:EE_
x-ms-office365-filtering-correlation-id: 79659ee6-0d2d-4123-f916-08decd455049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|11063799006|8096899003|18002099003|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 t0ak/VAKRxvEyc/hsAWByrPXSTKcYa6OMu4wrMxH/sZq2qUfXPuUDQ0CE742FpNk4r9Hh3vHyk0OMFDTS5KsVAOfP1iifYGlVE3hTcU7bfrirEjGOk/1ctRpS/+GRAUFjSUYbk4N/DXBNcDB7DFrja4k0SlHMKT27epQLvmz0Mbux525W50I11mXpJkePDeoJ2WhmQF9rmAv2vXgFSbVDKeqPEQZE4FhnCKC/wXhmKahzM0FZsGLH/h38D2/HLduFsun9ZJb79BuOkFpT3wHpk4cc/hxYgK2TBH+KM8PJWV+gAjYWpqDGzk4qesV/5RGhJAFsGgI5VH08zd/lYj5K3kq+GJiRIkXmwcGFpqrcsOIEoos8xvWD+OztuFJJ+AfyXTE0uCz0hf3sjQsIUzQLxspsA9CsgauL403/iq2B5m9g/ABLNelC6ysnjVi6VTpVjkRKCkI38JPGf0BDM9dm65YrdCzOzSIjlpp4EuE0zhOLr/63Q7QzhDdvgdKR3xvQJ/aMSkvif3W8gN6MxoikCw+7C79dWc09KPBVyQhyquk44JyjVuPghS9mk5SywP+ASPskUzR9y0RW9G15ZqvlR7fyjDRbgcjVGXm/9TX8+m0bHJ8sb3Hh50GhdteiEjutvok/M46ufL6cppmWiUr36JAmGj97/2K4jSKv8rNZGzeaApdIv1JDOChKB8kjOJbLksPLCX6QirLw1/YaR+z4RSCnXHfla++H/UoGYcpQOzvyTF9nN28Pq7UbyEWaNRe
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10592.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(8096899003)(18002099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U3Q3cFBFM0ZJaldwTklocEt4MmNLM2ViQk5vbm5FN2ZKWFF3c1NDVWZC?=
 =?iso-2022-jp?B?VlpDUk83dzFCSk4wY2V5c0J6dTVYeEo3VmUwMGZtYUZpelIzd0RrZXJn?=
 =?iso-2022-jp?B?UU5RVjgvbDNWdTliSDNNdGVKZnVOYzZrTXZLay91VTMrcWYyM056SHdv?=
 =?iso-2022-jp?B?OHVmd1g3SS9rWFBzc3IxeEYveHZqb1VuMUtibmNpaHZmcGdvTTFDbjRP?=
 =?iso-2022-jp?B?WVh5UU5COHQzeVhXd1hJc2gzbUZVTWx6QzNieVBEL01tNS9obWVFNUky?=
 =?iso-2022-jp?B?SDFTT2hGSjdheGRZN1N4RGFsSVI3VE82NWs0UnZ0eWQwYlZaWkJLUzdi?=
 =?iso-2022-jp?B?aTJNbzMrZjUyV0I5SC8vWDc2M01hREMvL1pHRjYvRTlrSXlkM0tIS0JX?=
 =?iso-2022-jp?B?YWZ5SjE4eGR6OGtGdExiVVk4UExlMlJ2aXpPOEJ1UVREdEYwR3MwOTY0?=
 =?iso-2022-jp?B?QkUxN1A0cnRkZHlRSStOS3lWbVE4c3RVUUEzKzByVkFnSjJzNGtwOFVj?=
 =?iso-2022-jp?B?VjdLQkpiUVBodlphNk1WYkpNR0lPWFluUVhueVQ1TndERUtBTm1RZ21D?=
 =?iso-2022-jp?B?SkJXaEw0MzM2Rm9rallxdE05UDVhMVF2dzZwZlJmRDFWMUFNM2g5Q1JV?=
 =?iso-2022-jp?B?aGUvcVBPTFN1VDM4RXhzSFhQL2FtLzdDd1Q5NUJHbElPNjlTbkpyZjYw?=
 =?iso-2022-jp?B?clE4VnpqRC8zREpyQjhMLy9RWEVRb09tbHFhN1Nwck9SQWRHYTVtdUpC?=
 =?iso-2022-jp?B?dHZTdEhBaUZDcXlhOHQwZWpmOGxlbkNZMWZtUFlXNGJBN2dVQUczcUds?=
 =?iso-2022-jp?B?TDZLTDd0YnRpU2wwT3FYSU9Da0JzZS8xd3ppWXlHK0NyZ2JHTVovdXo0?=
 =?iso-2022-jp?B?alpXeHZySENobDdzNWtETW9INW01RlFkWTRUcWNhbU1NbHZVa2xGUVRZ?=
 =?iso-2022-jp?B?NWZYWm5seGJtRG8xOHlHbHh6alNrVjkvTVZaUnorTWFpRmtMRE5aVnpB?=
 =?iso-2022-jp?B?WTJxb05UT0Z1cUg3b1pzUE9lcmVDQ3dpWnp4WXF2VUtMckQwVmFEYmZl?=
 =?iso-2022-jp?B?N0t4UCtHSkljbnhsNktVRENjUzNpdmRibDJHWTBSTlE0SHdnS3RiZFNw?=
 =?iso-2022-jp?B?cnFkSVlleFUyT2hVb2dvalBveFBnUzJJSmttT2V5cE1zZjlSL09HOUVG?=
 =?iso-2022-jp?B?QThVQ0pnMnJUL0lBNXIwM1UxZWZtVzJ3OWpKT0ZFTUVmb0hjU0JzTk0z?=
 =?iso-2022-jp?B?N0dQaDdsbTJXSlREd0F5SGw4SEYvZGVMRlBKUTBWNmFXQ0RUVzZQSHox?=
 =?iso-2022-jp?B?LzdQN011OUNRN0Y2eG14c0cvUm9BUEFtZmR5VXFVWXJ5eXM2Ykc1a2xv?=
 =?iso-2022-jp?B?NGZ3RGJGR2tHa2FraFZFZVg3YldOaXh5TGdZcVdtUjdhMSs3djdsd2xC?=
 =?iso-2022-jp?B?ZVRRa0NJTEQ1a2E0S1NQV2JhMkppZUtJME5MVUR2dFV5dG9meEpuZG04?=
 =?iso-2022-jp?B?Ni92MnpZYjBjSDZ0b3hlVlpIcG9hMmpRS1MzSnd1T2V1TERDVmNYSHZr?=
 =?iso-2022-jp?B?K2kzNW9WZDBmTnIwMU1uTUdMTzFaOW14RmE1TE5ZbnEydjBhSnVjbjZz?=
 =?iso-2022-jp?B?M2V6U3FEVzJMZ1NmVU9JZ1R6dEdRL1ovaVI5bXUrdldxZGFMck4wTk14?=
 =?iso-2022-jp?B?QnB2OFVVZnNsMzVUZkNzK1VXbVRHTVlVQis5REtPdFh4Q0xoNFFCQUkx?=
 =?iso-2022-jp?B?Y3hKeUJObm9vNUFjOXVTVFZ6M3A2d1ljSUJ5VGcxS1gyUllNTU9HRDJ5?=
 =?iso-2022-jp?B?Y3RzZmJNOGNWczgzUk9kSTQxK1ZKTlc5MlJ4Kyt5aXNORGpTeE1rakNJ?=
 =?iso-2022-jp?B?WUJ4K2I1OHNwMExudDJSMzZXT2ZrL1N1cUZpcjFEZnhONm9qbDgxQ2FD?=
 =?iso-2022-jp?B?RGI0d2tWWE8vb1VVeVByalA3V1Nmb3JRQmJ4RlR5VVBuT3JGQitVRXZw?=
 =?iso-2022-jp?B?Zi9sMlpqWTFjalZDdzNNWllibGM2N1lWN2s1TXMvSVM0SjhBWCtGYUht?=
 =?iso-2022-jp?B?VDBEV2txVzh4MnErc2ZzR2N5ZUJHSy9RWDNyOHoraHorN1JOWElrSEtV?=
 =?iso-2022-jp?B?Z29GSjFKRzUyY2F0MEFZZUtHQ1pXR3VzZHpEc0FoZmFuanBVaDlTMG9R?=
 =?iso-2022-jp?B?V0tvUlErdGpJaHV0MDVoY2k2T0swVjdpeHpEZkFhd1IwYVZIem55aTVG?=
 =?iso-2022-jp?B?SU1ZUE91SkhzWUNnWGpUYUVHbFl6Ty9ldXNCbnY1ZHh1K25XSjZLZHp1?=
 =?iso-2022-jp?B?M25GRXBISkp2b2tsZXZ6dHFuVUttVCtZSG9BOXJPaDdmSVFHdlc1TEd1?=
 =?iso-2022-jp?B?ZUZlWGNKWXdSYUZXdVRQT05LdzIyU0tESWRlRXkvc3V3UmlDNk1PVkdG?=
 =?iso-2022-jp?B?eWtHU0pUcTcxMUR1blJPcFQzamVZTHNSVmoyYld6UzJFaDVtQUxweS9Y?=
 =?iso-2022-jp?B?SWZTQkpXanc5bTlOMUlUYUJwYW5tYkd4dTJ3Wld4K0toUXp6VXlKVXd6?=
 =?iso-2022-jp?B?MkNBSFVtND0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB10592D65D23BA0EDC6A01ACF9DBE32TYYPR01MB10592jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	XNC9mXSWegBcwRKInEvRByI9G8Tg0kuwN3NyL6QMcBfzYojc4BbqyYPhkAqXq5qrhfKaoy5modwn85DTWHxn+qVz6CnYCZn+5yxPfNAHm9IWOdXjRt961jm/UvHDy945nj2MH3wv5nk/Xuc0TS9ysmrMM/2j+WFfRccYk05tMAZ6ORd7TwcXxW6J9nrUg5RlIJIrbhQOgIU9CuAlWDlgEUPOFp9F6pY/OEWzv7BZkcyM43a9yA/SE6/qAGBInsrLPuSXKmy3GbER/+MiYoMfxjpwHeY3eWkAueADGtu92OejWrsGXOt8dKXtiK2w5IdoI73MjThjuwXoNYbdF5hx+A==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10592.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79659ee6-0d2d-4123-f916-08decd455049
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 14:24:31.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4HtDR1hbpo609Ayej6Wqy/s1xuY7PvFDxTTc9CRJrImwWFODV1Q/VS/M7Sk8pG+KWxgAYZDsUSdyVVrE0MhpIkEa3QE6qpQooqG2ZG6k2AJ7EFNRm0d4Qy0i4QO7XiV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 14:24:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23225

--_000_TYYPR01MB10592D65D23BA0EDC6A01ACF9DBE32TYYPR01MB10592jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Please find the autopkgtest related MR link for passwdqc package:
https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requests/1

Kindly review and provide your feedback as soon as possible.

Regards,
Sahithi

--_000_TYYPR01MB10592D65D23BA0EDC6A01ACF9DBE32TYYPR01MB10592jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi All,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Please find the autopkgtest related MR link for passwdqc package:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requ=
ests/1" id=3D"OWA9cbb5dd6-91ef-2493-7a5c-4b7fdbc76818" class=3D"OWAAutoLink=
">https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requests/1</a=
></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Kindly review and provide your feedback as soon as possible.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Sahithi</div>
</body>
</html>

--_000_TYYPR01MB10592D65D23BA0EDC6A01ACF9DBE32TYYPR01MB10592jp_--


