Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBCCA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 01:25:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.29453.1756949151598033888
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 18:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=smeAhyMn;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756949127;x=1758158727;bh=beMXHhDvaNqRZ+90yOjXBGbs+HzdM/c5Ze3LR
	3b+sjo=;b=smeAhyMnLAXqqiMDSaLO14RHZGu0lF8Qhepb+ZL4OgBlhR30Yvv0OstNXyh4eeXPGDi
	5d1lV054cK+I/oHgb6TH9PkDhiZavCJjD999atCWDlxFsMm5+8GrM+HlZ7og/VPmdHFT+Mrptzh22
	V9QX3idTgZweV0fEv8zlYJPlXknOrTgv16pEoyXVxljBv2VTdk5reA/3dyA2wI0JID8ebvK775wBR
	EJluwyCzB4KXBKlI3iqxSvNSLppSezybQ0SgN5DWWZSjrsYQc8CGwE5NQhzIzYTX2awJX38YKKOPi
	UoypwL98rKpl9ldXrRfeOb/li1wNpSc4aogbm5g42Fgg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5841PQsR3435348; Thu, 4 Sep 2025 10:25:26 +0900
X-Iguazu-Qid: 2yAaaopxgvnarVHyWD
X-Iguazu-QSIG: v=2; s=0; t=1756949126; q=2yAaaopxgvnarVHyWD; m=iKF2MCGOJiMh+AyjTAQ3FLwuDY685XUTDdivdz5nrQE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cHMH92tCmz1xnc; Thu,  4 Sep 2025 10:25:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzGh1IzFuifnxXYH2jDejmI87ebFm/5Tss5QneQzKKJ5Gj1MqHTr2XoLrZ3A2Mek7h2u8DrWNztDRV9/Iym0kBWGRlPqmxh9QiBAYWTHh/+6XGyjGV2vvAf3Jjhpd883slP5ICoJji79M1JbVjtKoGvVRt577Cd0Ap87OeuzOjjOO7n4OVrJ7JR9msufVsNwesEqQarer51EVigN1qni3YO54tLy2NPMYkb/A0JPjqEBSviyTq8HKSw9NYnxCbehLX7L99T5OK9r6Nv2n5lYFQqur+xDZgr9J1A6tm3ccvIIHfXxRk7zs9WCeqpvMuGPlmZ06/Ul/Ul7dg+Ga7NsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beMXHhDvaNqRZ+90yOjXBGbs+HzdM/c5Ze3LR3b+sjo=;
 b=troDyiMF4r6+5Huh7ybvSr4FYsALrGpcNkq0SV8to/OQG/ryS37xKcyTvB3d2na+77QxlBubj0LgiS3ciE2KvrNDRg3pGTpbWD5YHmWb/rC4lsWU4OP124lvIz8MXi9UAplvyAR7cIKa4nHSFSPFuTBkcLQLNwQq/I9O9+HZvc50OcW9YDhz59YXCGXPP72dfD9WrxGHKnGrOncFeffpCkXGX3kfs4GB2J+w45vZohb6MGlitg9Q574M2Hxm86+pgZwiyrm5cDpopQLqUNqOiDXzVpTFS6HHOt6sM4h3/euCsqjh6stQPYGFBoldbwUSVaghW5MBbyOP9ZJSWSvChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>
Subject: RE: [ANNOUNCE] Release v4.4.302-cip102
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip102
Thread-Index: AQHcG+pbfwnyb+jhWEiR4LOnXQdTwLSCPLSA
Date: Thu, 4 Sep 2025 01:25:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808FF4B6303383C05F05D27CD00A@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <2089869981.61985.1756804608743@webmail.strato.de>
In-Reply-To: <2089869981.61985.1756804608743@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|OS7PR01MB15385:EE_
x-ms-office365-filtering-correlation-id: e3513f1e-6244-4e36-43a3-08ddeb51eafe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RGVYaFBiN3FWRERvNDZ2eWRIWkpFbFh3RVlCS2JYaVg2OHdBbXp1L2NFbm1u?=
 =?utf-8?B?TnZxdDQvcEFEL09PNmMvamJERGNDRi9ma25ITUhPSEtBTDFkTElzVTF2ODI3?=
 =?utf-8?B?R3FCOWtWRVJ3TE9oU3FlaVVOWGxwaVQyUlkxaWgzOGxSa0t6d1JITllLemVI?=
 =?utf-8?B?ZzQxV0h0c2kyRXd6UG5LUzNzK3ZnNE5JOWRTMTJLYXFPK0Iyd3lLSG5ubW41?=
 =?utf-8?B?eUhIWEVZb051M0h0d0pZR2tWaGhoNExINkNRSmpGM09aaEtBVEtoNVFwRFFW?=
 =?utf-8?B?bzNTem13L0RERitsUnNIMGY2Unpxb2Juay9jeVBqZ1RVSWk3NWNHalBRSzZs?=
 =?utf-8?B?dlIyemdidXdBNlVVcW1Sc3RtbjF0SWczTCtQZTBnSnpERlV4VnRXMGtFdldI?=
 =?utf-8?B?RWt0d21lSkVIamZBVWMveXA1Q0N6ZEdid0xoRURJOUl1MWIzWFE5T3d3eTM4?=
 =?utf-8?B?RWw2RXRaY3c2Q1NqRFNnc3F6cTlBV3hYZGZjb3B6dUZ2bVRIU1lsMWpBMito?=
 =?utf-8?B?b1hybVhZWllRcExqTTQ0UjF6Rm5Xd3FUNTkzbDhJRTRCZGlBTmJuTjNqOTd2?=
 =?utf-8?B?ZnJHZzF0bzRwT0dmZWVaL0toQ3loQXZMMTJwdHUvR2d4bWF5K1BGVGFMSStQ?=
 =?utf-8?B?RGtmVkNPOFUvMHAvK1VBV3VkKzI5endJU1VCb3hSSUUvS01ubDMvZnVhbUhi?=
 =?utf-8?B?Zy9SbUVKamNNVXFnL09tWWljZ3hWaVFWay9pZjJjRUhmTmhnNWIzd3FYNjIx?=
 =?utf-8?B?cFo0MEd6MkJCenFRMjQ3UTdqbzVudk9PZHRIQzNmMmlvdEsybGdLcitHeEJt?=
 =?utf-8?B?UHgxTi9XVUtSOTRXTHgrK2lwbkNNTXB6NHJDcXhBWjBjbkVaWVJJN1N3cy9m?=
 =?utf-8?B?T0tybHMvU0lNYnRZV1JzWnJhblF4akx2UWdpQzlCWlRjMFBlZ3orNDh2Nldv?=
 =?utf-8?B?VUsrN25NK2pUVW01dmgyQXdTYnI4VGdXSEc3MS9UMlQ1NDZKUk1mZDUvcmxR?=
 =?utf-8?B?VEF2bjFZTlhWVUhvUHlqenplV1AxOExZQjE2NGtCU3JZNVkzZWxKRXowU0hW?=
 =?utf-8?B?ZE5BSTZ0ZDFhS0VHc3lTcndHSW9ldDlZUDVVRDNENW9yUFBQci9lanc5RVBh?=
 =?utf-8?B?TzZJWlFyZTB1ZGpXb1JybVR3TDdqNWgrem9BV3ZzWmFrTTQrbWdZb1FpYVE4?=
 =?utf-8?B?c3lEb01rY2NtQXVrQTZnVmVudlhVWWF5MzdXWjJPS2QyYnRaMW14SnptUHgz?=
 =?utf-8?B?MWIvSDVERFZ5a0QyN2tlL3RkeWY1SytQNlVpMHdBRjFQT3dNQUdEYUVUbkhZ?=
 =?utf-8?B?STlxZmZGSmdUa2Q5OHQ0bUVFMDA4cVljVHI3Q0JkNUwrQUMyMUxNdVRLVnlq?=
 =?utf-8?B?RktIRUpiMXRzU3JZWm40RHcrUCtmUmdiNmtwVnE3WllsZnl2UTNDOWFXcitP?=
 =?utf-8?B?ajRtUE5OTmtNUFpnQWlyWUtmamRXMThJSFdSTVZheXFSWktGUFVWOVV1RHNo?=
 =?utf-8?B?SmF1dktLR25ZRTVxa1h6MC9vd1NzOUhQNUpqbG9kaENuWWlaUjJyUGpBRTlo?=
 =?utf-8?B?SWpheFhWeXlKUkhDS3RJcDBOdWdueDBXMFVnMURxZWQ4blphVXVNNFRKTjYz?=
 =?utf-8?B?cHZaaDRCZCsvbTh4eUd4M3lpdnlvSlFCcjhvbXpuVUNOWTF3MTRnS1N4OFU2?=
 =?utf-8?B?T1lNclVOZUVYVXY4Sm80SWFBRk1NUDlxem8yeExRT0RKcXFqUUdBWTZKTVln?=
 =?utf-8?B?eGxDTDQwTGZueEE2ckx3NGxUMG5PSUtRSkw0UGRUZ3cvbFg2TXpHU3pPNlph?=
 =?utf-8?B?UjJoZEppVU9QZE56d1FXdEZhTzhXUU1zMkRZNzhVSnZWVmpMSHU3ODhEMGtr?=
 =?utf-8?B?WVZqMndMV2NidHpVZ3hPdEhXL1RPQzZlbEwvOVdvVnVlaUJPeVA5eHpMZjI5?=
 =?utf-8?B?U3M1ZUhqZnVGVnhBVDlrV3V1djJOYzJKaU5rWExXMjJvcWJtVkl4R3JLekhq?=
 =?utf-8?B?Z3h6MlY0MnVBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UjJIZjVQMytOb0grbzFMWWg5bE15c21ZZFpMeUZDRTJwVGc1cFRxOVR0b1dW?=
 =?utf-8?B?Y1g5enR6NTdWTUlSSVRyTDV0M2N6Q1VFOFFqUkpqWnp5NDh6cEZXZ2k5eTRn?=
 =?utf-8?B?bUk1T2NyclJ1ZGZRWWY5MTM2eldkckNiZ2lMNzNTYnRTRVhDOExkNWtrSVRk?=
 =?utf-8?B?SXMvV3BrMHR0b0pXaWY2TnFxcWhQS3JFcy93MGVGejZsVm5MeWFNQnllSkow?=
 =?utf-8?B?OW4xSWpTYy9GeDhiZ08rT2pCL3ViTVIva2tLSmZKTWtBalp3ZEMvOG5jL013?=
 =?utf-8?B?eGZ1U0M3RlY4bkI2MVViclhKZmNmczVXRWwrWm04dk1xdHAzRkRzWDR1S2Mx?=
 =?utf-8?B?WXNyY3BSd3hmb1QzVWw3bHVYUVl3RXVUNmpiQk9zdWc0UmxkTXZjVnNMV2Q5?=
 =?utf-8?B?ZGFZYzVTRnlOeEpsTWRaR2NZT25iOFJNcDhpNHlVNW11VGpEWTVZekJack5E?=
 =?utf-8?B?MDlrTWZxaXpiLzF1TGF0UUFFV3AxYTFha1k0V1QxUVFYcmF3WUpLMUd4RDk1?=
 =?utf-8?B?L2FFOUlXMklWc1RTZ2lsZjhqc0J3SXlOU08wZlZLTEdKOVgwNUJJOUNrNkRR?=
 =?utf-8?B?dy9KcjFsZmdMUDVRSC9JREpLUGcrd1d6c3UzV0tINXVkcFAzd3IrTnJnek1H?=
 =?utf-8?B?cjU1MUkybzA1SzhMYlJqNlFwbGRvNWtpUE5tUW5yVWozdFVJWm1wWjNJNG9U?=
 =?utf-8?B?MzBGMHA4SjB5K1Z1YnpzOEoyRjczUEtxcHVJODVxU1BFVXFGSmQzbzlFY3hu?=
 =?utf-8?B?WTBVU2U5YkJHSWJ5U3AvUFQ2TTJtRmg1S3dvMHlPanZVbEdTdDJnWlVielBX?=
 =?utf-8?B?WWdJVEJTVkduSXFCUzc0NDErR2tqZVBPT2VMdnFtN0lOQ2x1TnhBR081WkFB?=
 =?utf-8?B?T3Q3a1BMcjFDcUt0ZzhSbDNNaDdiSkhGVDVjTkp2V1Qwd2JVVG0xUHV3UGxW?=
 =?utf-8?B?dUJRWU1hSVVKMHl3THYxclFGVUZMaE52VjdRWWt3dER6SGRJVUZPWGkxNE9j?=
 =?utf-8?B?akNSL0I5S3ZGTXM1aHRjSjFBM2VLbzhGY2pWVVhYaHZXUFJyU0xtcXdVKzlG?=
 =?utf-8?B?UDJsOU1qa2YzZUdQQ0dFNlNUeU1kS0dkRVhHS0Nvak9NNjRKeVozRGNUZk1j?=
 =?utf-8?B?b2NOSXpTanVJWndoTkNFSmMvb2NZTGJscUdkQkJjY2lPeHlkdXV1Rlg4bW84?=
 =?utf-8?B?ZE5FSHRvb01KOVovbkNVblhDaEVLYkRaMVlIelEvZHNHNnFPTWhxZ0txNXUx?=
 =?utf-8?B?aHFpWXJxQlhOY2xDL1JhQTdTdE1VQU5RSXhUSldjUThjOVF0Y2lZMURMNEtT?=
 =?utf-8?B?czBUaTljcllNUmZVNnQ3b1htT01Qa1AzUlo2bkdyN3lwTHhyY1A0SVNCYnV4?=
 =?utf-8?B?REZiaW5jNnFHTjVpeG54bHQzbnoxbUdLbHUwbkRIODZ5d05HUC9nM3lqZ0JH?=
 =?utf-8?B?ajVWeXEzd3lDaXAxTHBtbEw5NXcwcXZua1ZBWTFZbWZLemtMWnY1RG5MRXZ4?=
 =?utf-8?B?cWo1cWorUUpRS24yaE5uNDJBWWZubFYwQy8ybDgvbDZiMDFiek45VEdxMWxT?=
 =?utf-8?B?d3ZOUlNDc25tN2xXWE96b2FQeVFCUmp5K21ySzBvL2pKK1RscWZhZWkyd21l?=
 =?utf-8?B?VW1JY1FraktyUjU0czdQQTgxUlI5NmxJZWRVYjJpazlMR2FmR0xHdjhKUEJD?=
 =?utf-8?B?ZFhqYTVWZURzcTdFS2pZSk9rZlhMNkcyZyt5VTVCV1hDU2lnaGxaeVNHcUsr?=
 =?utf-8?B?MXoycHFwZGlUMjBYTzlMaGY3NzhiQWhrRTNQaGNNSmJyZ1prSXpqYVdwMXBS?=
 =?utf-8?B?TUhXZmdneEVyb0ZmTkQ5bU1ySEFaNlhLWXhDVC9TbjhBYmNCZ1hvQVAySTVp?=
 =?utf-8?B?YnlHL293WWVBemxUM01yQjczbDRaa3I2S1VKbUZsam9sRk12QXB6bk1rbWdI?=
 =?utf-8?B?OGs1VTNLaVkzdUUvMTBiYk5kbk1tZm5mM1FrRGFVbWVtU3ZoQzk5UWpyWnhx?=
 =?utf-8?B?eFFpdU1mT21mNjljSnBtN2tZZWl2UjZoM1hlZkVKLzJVMHBYcVorQUVNVDMx?=
 =?utf-8?B?c2F1VkQwRUVEYzgyRXp2dDdOb1NJdk5LQ24xN3pESVpSMVV1Y0srRmppNm1z?=
 =?utf-8?B?eXlPdnBZUXQrQVlxRW5FN2pWRFg3emtMR28wcHFwSkNLMDBpQlI2VHpOc0hL?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3513f1e-6244-4e36-43a3-08ddeb51eafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 01:25:22.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X12D+o+lp2XGmFxU1LW9YGX0F6A2B7Q9ihkNMIp0PjdwhrLTV87NyPjfwkyZwjtu3xSVep+0V1nVp5X0+qJHYGI/mWTVZ86knrFc9IN3k2uHU8jdOTlhaM6iAhN61gr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 01:25:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20002

SGkgVWxyaWNoLA0KDQpQbGVhc2UgcmV2ZXJ0IGNvbW1pdCAwODk1NTM3ODhmNWYgKCJmaXJtd2Fy
ZTogYXJtX3NjcGk6IENoZWNrIHRoZSBEVkZTIE9QUCBjb3VudCByZXR1cm5lZCBieSB0aGUgZmly
bXdhcmUiKS4NClRoaXMgY29tbWl0IGlzIGNhdXNpbmcgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJv
ciBpbiByaXZlcnMvZmlybXdhcmUvYXJtX3NjcGkuYyA6DQoNCmBgYA0KWy4uLl0NCmRyaXZlcnMv
ZmlybXdhcmUvYXJtX3NjcGkuYzogSW4gZnVuY3Rpb24gJ3NjcGlfZHZmc19nZXRfaW5mbyc6DQpk
cml2ZXJzL2Zpcm13YXJlL2FybV9zY3BpLmM6IEluIGZ1bmN0aW9uICdzY3BpX2R2ZnNfZ2V0X2lu
Zm8nOg0KZHJpdmVycy9maXJtd2FyZS9hcm1fc2NwaS5jOjQ3NToxNzogZXJyb3I6ICdzdHJ1Y3Qg
ZHZmc19pbmZvJyBoYXMgbm8gbWVtYmVyIG5hbWVkICdwcF9jb3VudCcgDQogIDQ3NSB8ICAgICAg
ICAgaWYgKCFidWYub3BwX2NvdW50KQ0KICAgICAgICB8ICAgICAgICAgICAgICAgICBeDQoNCiAg
Q0MgICAgICBkcml2ZXJzL2RtYS9scGMxOHh4LWRtYW11eC5vDQptYWtlWzJdOiAqKiogW3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQ6MjgwOiBkcml2ZXJzL2Zpcm13YXJlL2FybV9zY3BpLm9dIEVycm9y
IDENCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODc6IGRyaXZlcnMvZmly
bXdhcmVdIEVycm9yIDINCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uDQpbLi4uXQ0KYGBgDQpUaGlzIGlzIHJlcHJvZHVjZWQgd2l0aCAnbWFrZSBhbGx5ZXNjb25m
aWcnLiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBU
dWVzZGF5LCBTZXB0ZW1iZXIgMiwgMjAyNSA2OjE3IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgcGF2ZWxAZGVueC5kZTsgamFuLmtpc3prYUBzaWVtZW5zLmNvbTsNCj4g
bWFzYW1pLmljaGlrYXdhQGN5YmVydHJ1c3QuY28uanA7IGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbTsgaXdhbWF0c3UNCj4gbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPi
l4vvvKPvvLDvvLQpDQo+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiBT
dWJqZWN0OiBbQU5OT1VOQ0VdIFJlbGVhc2UgdjQuNC4zMDItY2lwMTAyDQo+IA0KPiBIaSwNCj4g
DQo+IHRoZSBDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC40LjMw
Mi1jaXAxMDIuIFRoZQ0KPiBsaW51eC00LjQueS1jaXAgdHJlZSdzIGJhc2UgdmVyc2lvbiBoYXMg
YmVlbiB1cGRhdGVkIHRvIHY0LjQtc3Q2Ny4gVGhlIHRyZWVzIGFyZQ0KPiB1cC10by1kYXRlIHdp
dGgga2VybmVsIDQuMTktc3Q3Lg0KPiANCj4gWW91IGNhbiBnZXQgdGhpcyByZWxlYXNlIHZpYSB0
aGUgZ2l0IHRyZWUgb3IgYXMgYSB0YXJiYWxsIGZyb20NCj4gaHR0cHM6Ly9taXJyb3JzLmVkZ2Uu
a2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3RzL2NpcC80LjQvDQo+IA0KPiAgIHY0
LjQuMzAyLWNpcDEwMjoNCj4gICAgIHJlcG9zaXRvcnk6DQo+ICAgICAgIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQo+ICAg
ICBicmFuY2g6DQo+ICAgICAgIGxpbnV4LTQuNC55LWNpcA0KPiAgICAgY29tbWl0IGhhc2g6DQo+
ICAgICAgIDExMzUzMzBlMGZlMzMwNDFhNDRmNWNkMTQ4MTk4NjZiMmFhYjdhMDgNCj4gICAgIEZp
eGVkIENWRXM6DQo+ICAgICAgIENWRS0yMDI1LTIxOTE3OiB1c2I6IHJlbmVzYXNfdXNiaHM6IEZs
dXNoIHRoZSBub3RpZnlfaG90cGx1Z193b3JrDQo+ICAgICAgIENWRS0yMDI0LTI2NjQ0OiBidHJm
czogZG9uJ3QgYWJvcnQgZmlsZXN5c3RlbSB3aGVuIGF0dGVtcHRpbmcgdG8NCj4gc25hcHNob3Qg
ZGVsZXRlZCBzdWJ2b2x1bWUNCj4gICAgICAgQ1ZFLTIwMjQtNDk5MzU6IEFDUEk6IFBBRDogZml4
IGNyYXNoIGluIGV4aXRfcm91bmRfcm9iaW4oKQ0KPiAgICAgICBDVkUtMjAyNS0zODEwMjogVk1D
STogZml4IHJhY2UgYmV0d2VlbiB2bWNpX2hvc3Rfc2V0dXBfbm90aWZ5IGFuZA0KPiB2bWNpX2N0
eF91bnNldF9ub3RpZnkNCj4gICAgICAgQ1ZFLTIwMjUtMzgyMzA6IGpmczogdmFsaWRhdGUgQUcg
cGFyYW1ldGVycyBpbiBkYk1vdW50KCkgdG8gcHJldmVudA0KPiBjcmFzaGVzDQo+ICAgICAgIENW
RS0yMDI1LTM4MjQ1OiBhdG06IFJlbGVhc2UgYXRtX2Rldl9tdXRleCBhZnRlciByZW1vdmluZyBw
cm9jZnMgaW4NCj4gYXRtX2Rldl9kZXJlZ2lzdGVyKCkuDQo+ICAgICAgIENWRS0yMDI1LTM4Mzg2
OiBBQ1BJQ0E6IFJlZnVzZSB0byBldmFsdWF0ZSBhIG1ldGhvZCBpZiBhcmd1bWVudHMgYXJlDQo+
IG1pc3NpbmcNCj4gICAgICAgQ1ZFLTIwMjUtMzg0MDE6IG10ay1zZDogUHJldmVudCBtZW1vcnkg
Y29ycnVwdGlvbiBmcm9tIERNQSBtYXANCj4gZmFpbHVyZQ0KPiAgICAgICBDVkUtMjAyNS0zODQw
MzogdnNvY2svdm1jaTogQ2xlYXIgdGhlIHZtY2kgdHJhbnNwb3J0IHBhY2tldCBwcm9wZXJseQ0K
PiB3aGVuIGluaXRpYWxpemluZyBpdA0KPiAgICAgICBDVkUtMjAyNS0zODQwNjogd2lmaTogYXRo
NmtsOiByZW1vdmUgV0FSTiBvbiBiYWQgZmlybXdhcmUgaW5wdXQNCj4gICAgICAgQ1ZFLTIwMjUt
Mzg0NDU6IG1kL3JhaWQxOiBGaXggc3RhY2sgbWVtb3J5IHVzZSBhZnRlciByZXR1cm4gaW4NCj4g
cmFpZDFfcmVzaGFwZQ0KPiAgICAgICBDVkUtMjAyNS0zODQ0ODogdXNiOiBnYWRnZXQ6IHVfc2Vy
aWFsOiBGaXggcmFjZSBjb25kaXRpb24gaW4gVFRZDQo+IHdha2V1cA0KPiAgICAgICBDVkUtMjAy
NS0zODQ1OTogYXRtOiBjbGlwOiBGaXggaW5maW5pdGUgcmVjdXJzaXZlIGNhbGwgb2YgY2xpcF9w
dXNoKCkuDQo+ICAgICAgIENWRS0yMDI1LTM4NDYwOiBhdG06IGNsaXA6IEZpeCBwb3RlbnRpYWwg
bnVsbC1wdHItZGVyZWYgaW4gdG9fYXRtYXJwZCgpLg0KPiAgICAgICBDVkUtMjAyNS0zODQ2NTog
bmV0bGluazogRml4IHdyYXBhcm91bmRzIG9mIHNrLT5za19ybWVtX2FsbG9jLg0KPiAgICAgICBD
VkUtMjAyNS0zODUxMzogd2lmaTogemQxMjExcnc6IEZpeCBwb3RlbnRpYWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlDQo+IGluIHpkX21hY190eF90b19kZXYoKQ0KPiAgICAgICBDVkUtMjAyNS0z
ODU0MjogbmV0OiBhcHBsZXRhbGs6IEZpeCBkZXZpY2UgcmVmY291bnQgbGVhayBpbiBhdHJ0cl9j
cmVhdGUoKQ0KPiAgICAgICBDVkUtMjAyNS0zODU0NjogYXRtOiBjbGlwOiBGaXggbWVtb3J5IGxl
YWsgb2Ygc3RydWN0IGNsaXBfdmNjLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBVbHJpY2ggSGVj
aHQNCg==


