Return-Path: <SRS0=vq8W=M2=lists.cip-project.org=bounce+64572+6647+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53023C4338F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 04:30:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FE861037
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 04:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8FE861037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UNk4YY4521723xv0y6OeTiw7; Mon, 02 Aug 2021 21:30:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.970.1627965050780119824
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Aug 2021 21:30:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1734UcBd005736; Tue, 3 Aug 2021 13:30:39 +0900
X-Iguazu-Qid: 2wHI1WtxBykAuxXmCr
X-Iguazu-QSIG: v=2; s=0; t=1627965038; q=2wHI1WtxBykAuxXmCr; m=TT4g5I9fMRdJ0K6fx+q1DAhH6PmlxkfemXteda01rAI=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 1734UbhQ007802
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 3 Aug 2021 13:30:37 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 2D1DD1000E4;
	Tue,  3 Aug 2021 13:30:37 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1734Ua4F025237;
	Tue, 3 Aug 2021 13:30:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuT/kpel9n/DgMsneffGg5sTvZbP+T1/jXN0HuLHqTCA6zgZLxKACDUCfl6dExC+dTIT/tfYI3pcJdb5ENp5YOnzQNt2VW1LcEisJJbshJHDMYyItQ5p//QG9lwMS3lVPydz8sqDiEEikNK+PErXs/tHRvnPsEIPJdmpckzmxxyJRvLtyRoXbECk4L1HdghT/M2CiL4OmuXLswIourYsN/j8xw5oLLe7Hc8jx9BCnkvBLnKn5pH4qM4KvWRcRM6RJxsc68dzPRL+XrPPiUUN49uvOA2AnZEPaoxXJc58hO1OjPDeyk0ky4LxOjS322zy6a42cpqFz6BM9wroXBuhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZEAOgGHM95EQJoyuUs3eDlRAtoc4PdgzH9aeIN1ks0=;
 b=bewswhSgFK691IlFDb35sN+NlXsGqU9XIohLoufZYKIckBnpfm2jQ8/TXAAF6Ix3HUIJ2bwKcYUbmR8yQS3G9Lekcp8RmTZUqRKro+Vqilc5kLTkjmfx6NYv1gzZiSoVSaDlKPQ6IlDjSssyZiv7AMHFTHpCbcsKra3JGBzITd9VZR2BgUML2mQIcScM3l0kF+t3gkjMzvbkEAZYWh8oYLdoxKipy/PD0I1xVbe5Su/gXCd4X3VqGGCsc0npW/PPfCVRLvnX/RLE4u3uXrUHBqlol6f2PYMBRmRNvPS4bO8PO5TZG9u2UEx3zGimn7aYS1Ne7JU7zTeKjB76+qUHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masashi.kudo@cybertrust.co.jp>, <masami.ichikawa@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.4.277-cip60
Thread-Topic: [ANNOUNCE] Release v4.4.277-cip60
Thread-Index: AdeIH7TdD5rscGiqR6qJSo767eFa/A==
Date: Tue, 3 Aug 2021 04:30:34 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62521F8D2A41BC0B6DEEDE3F92F09@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac16ca7b-03d7-4408-ecf7-08d956376fb5
x-ms-traffictypediagnostic: TYAPR01MB6314:
x-microsoft-antispam-prvs: <TYAPR01MB6314E3C50A23DFA7BE1E736792F09@TYAPR01MB6314.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 3UM6suu8e17VpxKLUoZgYds5tZhXYCvz+VcRDo6EODRqsbwKp6PsxoGCsq3W8qHY9CrBm+H5M/9Njsn0sr14H4BfI+X6YsBlrqfe5loLLSu88sPaxnnHU6XGrfBachNvLiXWaHGEQRMJsRqKg0knM46syVH3wpzIzonhatI2UdrY6pJT+hVwuqvpHcWxqey+lsPq6RBBAK8lAxlTyAltKyjcYBsj8VVwgNrI6gqPWRjQLe4vlnazSdyPTgkn19vNRbx1YiCGoN2nck3OPagbNlkkfVSXq0VSKvGIOMp5yyk/Uq3012K+1WW9L0Z8AqqmU7Z6tkEHwjZR3emg+rEsEjlcz9MuHVZYdaAeDCamGafhcI8xNM+x+pzfggv3npsLJxq4AY7pJFbRD35qLYRvcQM3Bjg8w+lcy45FVq4oRxtvbUcWPLqbSo6WXwTCOJ9MDw2ktg1L/1W/8owAWRaDmbBPrdoOc18P0XHwrFEgWDO/hFJwqDqXMXGRH+58Oj+is6UarB2OUIJoQIVMvHDCnFYOSCsTEsNiGMHf8dYHOn45Ybgyv6INPDPJDiWydid0hpvgxC6omvPCF96dKaPbDJWEEYQxUFRd0drrKKtD7zxwUD3yKg8tq8lR1hVtsEEC+PS3tqMpDjO7061UI6Be6xmj0JAvNGRTuAFtnDAY/aCi7eV9zW2tw1bSDNa8og0toByAb5cL2cB4Nt8RpxJ3B3sROyiI7iHwaytnBvqLywSh8Yx71QF05SUF5sMiK8Qfx72GNvemNVptE8q3DfKd3qHzfrpEUQOVugTGGMdS3gM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGRtYy9tdTdOSXByWXRlR005c2Z3dmV5RkN6K2VhWitIVFdqZUJzZFRmTlpI?=
 =?utf-8?B?ZTJJM0xpc0szSHJNcXhoVUdEVVIyYk1odTdMbWkxbXZDZURDMFc5b2toMUEx?=
 =?utf-8?B?UVdzdTRNSmI4dzdCT0lMd3NPRWhPTGtxdGZzZ093NE1rcDBNNXNsREVWTjh2?=
 =?utf-8?B?dm1XMXJ2OGdMbm5CMzV2RW91a3NqWVE5RWdtdXBVejA0Ym5DM24vemEwYkRX?=
 =?utf-8?B?ekdxeGY1QUZLQ3dqZkZlRGNCendpcm5jQlkwaWpzR0ZHVUpMcm8ybVFBV0wy?=
 =?utf-8?B?aTNWTzU5cWwzNWp6RDNrNWt5SXZiTHM4a1pwaGpCZzJ6c2JZRytwdjBLUmsv?=
 =?utf-8?B?WmF2Wi85V0dnT0lWSk9FSjRoUEJMNUh2SlRnOHQrM1VxYkVuclpXMUVUY05i?=
 =?utf-8?B?WkZXR2h3T0dRbHhZMXRualJYSFZtWnhpQ2ZEMnBhcWtva0dHNUNYcVdaU205?=
 =?utf-8?B?MXIrZWZHVTlNdHl2ajNsRWFXb1Jhb3VjenR5NDQzczNFSVVoclJwMmVURXZZ?=
 =?utf-8?B?UDhkaEUzbGEwUkcwZkw2VnFOa29rWmkzZmR1WUZqeUZQV2Y4TXJIMkxDM2Vz?=
 =?utf-8?B?aG5wMkRsaXFFSGx2YjJDRGFNanBHdllOcWhmV3hyZXRudE16RytDYlRGK3E4?=
 =?utf-8?B?WjQ2c3FONG80UmtOL3FwMGhUNGdOVTVVUE1DZ2w1aXhoZm5ZUXJRLzFYS2dh?=
 =?utf-8?B?NGhjSWVpRDBpUXdpU2pLRzNXcjhaZUd5S2FDWFBWLzZJYkY0RHNta2I1ekhw?=
 =?utf-8?B?UUNRZS9odytlNGhlRzRQS21CZU0xSUd2MUgvUmNsLzJTUU1TVFUvSElOVWNX?=
 =?utf-8?B?ZDNxc3hCOEVxR0lzY0lmejkwcnpNSFRnNXRCdjZQa3UvUDQxRHkvT1ZEcWpX?=
 =?utf-8?B?a2JBdDVxRS92WkFVcTc3T2ZETG9CZ21yM3NFUjQ5VnhrK1dPcUhZSTNadjNu?=
 =?utf-8?B?ZVJ3bnVTd0l3anZEdjBHeWpDb0R3MkdoYVdVbDQ2MXNVNkhwMnM5SGNYM3Rm?=
 =?utf-8?B?STIyY2xTUUhHZjNTcmxLSXk5bHZxaUVabVdpWmF6bnlYdHZDckRISTdsTjRq?=
 =?utf-8?B?MkVhbW5Qd3E1eTJBVS9rYjltZ2ZBQmhTNnlJc1dtaXcwaU1MVDcyV2dNekd3?=
 =?utf-8?B?SmZGU1RjZzQ1Y2JLbUc0K2JFY2E1eDJMSEZuNE9TelQ4M2xiNVBxVmcvQUkv?=
 =?utf-8?B?L2puSEl5NFFTSFJ4amxjWlRqdDNmOGVCWi9tSHlZTjltQ1krUUNlZElRazdV?=
 =?utf-8?B?SVoxNTNMWVpZQW9TSkw0a29teVBLTFQxT24yQ0pnUWRQMExDZC9ITjFBTnJt?=
 =?utf-8?B?c0VUMEYyVSsvY1h6WE9zVHBYRTZZQ1IrWnlpK25qZkc0ZFErc3Z6WW92RWpW?=
 =?utf-8?B?V3VwSG5scGdDd0hxdWdqOGVYNjJ2Nk9zVjAzTklSQmRIZFNJY1A4NTh0RERS?=
 =?utf-8?B?K3N1RWlQYVpsQ0JvZ3RwNmlYZnVGWmJIcERnVmpJTzAwbGhZV2ZwOHg1aU1E?=
 =?utf-8?B?TkJBTnBjMEwyamwwSjNRSGNnb3UrWGtEOW9lWUtuK1JlUHBlQkxYZUU1Wmpr?=
 =?utf-8?B?WlloMGJrUjM1Sk5uTXhJQU9lNDJuUGZxTzBmUUdyeW1waG9ieXJpZGNkQVpU?=
 =?utf-8?B?NlpHWEZQaWNndG4yQjFJMTdLNUZ3UlJNK2lNVzJxd2g2cUJNeExKU2Q5Q1pZ?=
 =?utf-8?B?ZzdKU3ZBNFpWbnh5RWw4UTFhbjNtL2NXd0owTHhNQ0haQ3NtWjF0QWpwSVJY?=
 =?utf-8?Q?pLnAkLLQWHS8XVJfd8=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac16ca7b-03d7-4408-ecf7-08d956376fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 04:30:34.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzCOh5YVhci5BzWfGh6zdkBpJ8X69bNbdWz0Tx5OQN5Y/4h4OAWY/eoYaeLi8ha30C9LfzmQuzfvek6soyM2aSynFHYAZ2in8oPLn9WI/wMGHiad25z2uQOwjEupLwNg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6314
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Paqq5nlk8LJFJlyscp7LVckKx4520388AA=
Content-Type: multipart/mixed; boundary="V0TLO4GXx3v1JtsO4aMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627965053;
 bh=lAmIUjYDIvhYaky79I0/WfcjqCyjitk/j+W48dMoTkw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=AJmMhY6h5YNcv7tpCdx4CFQyrNn1gjaGwydaJvGFzNjEkxeWqJ3yLEiJqXc2YOXGHy/
 4SCVBEu2hEQCHc0aLM1WWhERYrZAAcSYpaHOMry2H0mVGQaMsIHHMp6af4Y+of8fU1vPw
 KUw28PNFpAO19gZae911l5DBAMOAxeQTulY=

--V0TLO4GXx3v1JtsO4aMF
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjQuMjc3
LWNpcDYwLg0KVGhlIDQuNC55IHRyZWUgd2FzIHNjaGVkdWxlZCB0byBiZSByZWxlYXNlZCBuZXh0
IHdlZWssIGJ1dCB3ZSBoYXZlDQpyZXNjaGVkdWxlZCBpdCBmb3IgdGhlIHJlbGVhc2Ugb2YgdGhl
IENJUC1SVCB0cmVlLg0KDQpUaGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRl
ZCBiYXNlIHZlcnNpb24gZnJvbSB2NC40LjI3NA0KdG8gdjQuNC4yNzcuIE5vIENJUC1zcGVjaWZp
YyBwYXRjaGVzIGhhdmUgYmVlbiBhZGRlZCB0byB0aGlzIHZlcnNpb24uDQoNCllvdSBjYW4gZ2V0
IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjQuMjc3LWNpcDYwOg0K
ICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4
LTQuNC55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNjAxMmQyYzMyZWZhNzBhNTQ4ZDZl
NTliNzYzYzM5YmIwZDM4ZjJlMA0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAg
dmVyc2lvbiBzdWZmaXggdG8gLWNpcDYwIGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg0KLS0gDQpOb2J1aGlybyBJd2FtYXRzdQ0K


--V0TLO4GXx3v1JtsO4aMF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6647): https://lists.cip-project.org/g/cip-dev/message=
/6647
Mute This Topic: https://lists.cip-project.org/mt/84632315/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--V0TLO4GXx3v1JtsO4aMF--
