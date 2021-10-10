Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10200C433F5
	for <webhook@archiver.kernel.org>; Sun, 10 Oct 2021 06:52:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.15817.1633848765990269156
 for <cip-dev@lists.cip-project.org>;
 Sat, 09 Oct 2021 23:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 19A6qLsq008104;
 Sun, 10 Oct 2021 15:52:21 +0900
X-Iguazu-Qid: 34tKCZN8KWxg69BF5M
X-Iguazu-QSIG: v=2; s=0; t=1633848741; q=34tKCZN8KWxg69BF5M;
 m=TKw/0qcwgv4tuvHxpVrhOwC8/WFmjyZL5fpSSzsqI3E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 19A6qIbP030428
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 10 Oct 2021 15:52:18 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id A77311000DB;
	Sun, 10 Oct 2021 15:52:18 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 19A6qIN8015753;
	Sun, 10 Oct 2021 15:52:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp6PvT2u/T6716qWWE4ERbIJL4UdWVbZ7Szie1d8u6pSWwd0v69Q5jW8cBSaltsioFZt8RWK+VXOxgwstFX8f9McuJUBnID4Tkk0D7R6UR9eb47A4JTsV9TjI1FsYPcb8VgFl8UNg6HUz9j3PWK67/YFo0sIzRrPkSGaWaO7QiIngPdEwLPtn8uVbIunnZnh2mXXhaspFlWArFvqfSGG2r5hxdC0rZOdt7i5mydV4GpmYuV4zVi6WlmyDT0WO4pwYBGP06AYhs7kR74p+Ir4Bc6M0GLOg2JNUMrGjfc3WppWihuXNNeXXjW7h7ZiUtSj1gJ91vEfeRc2rqmBcsj+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR9ryMVhs8EAUI+gFRkaVzrrApoegSz4y5TLrXjcH88=;
 b=ACFeZBaxWWFeqTcU1MEOoYTlohiJHiSr7w0Y8/0CsW4iswmOFQVUkuw3FNNtpPffHV1HwKybdIBDtbEXFtts8kVyYB6OL2EdcDxmln8700UcMX7pa1dNRiTTvHKLfrOmg0YOvwcxsJm847lrw28hFqAQS32eDFd17brI0u2vZDTWh6JiomtceazBu8aH57AOK0xlBsYTTnPFuDaPPXH8NYYdYxtTvAbvuGQMpVleDEQrJjxGXig7i2zeqCW5vESps5j0u1Cxg4D7qXvR3HG5PuOs5nT+2GgdbT5DzxsJn4XQ9DhIhHP2/Hlq7TLXj4Wnqd5dnuSCgT9RVozAsYn/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.209-cip59 and v4.4.287-cip64
Thread-Topic: [ANNOUNCE] Release v4.19.209-cip59 and v4.4.287-cip64
Thread-Index: Ade9ou0QXhp9MtswSraPMkVctoTUrw==
Date: Sun, 10 Oct 2021 06:52:15 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252C0AD8B5118090A1A0B5092B49@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e562764e-143a-42ea-9768-08d98bba7ea5
x-ms-traffictypediagnostic: TYAPR01MB3312:
x-microsoft-antispam-prvs: 
 <TYAPR01MB33121E0BD7DE9C359E38165C92B49@TYAPR01MB3312.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WRZ/VmQ2SEZNzOV0YXIEQomyF0FAxmufB+4vUaITYzW6213s1MFhT7pndXb9PAUnKi7g750RhmmltxbgypwUtJfOyPhqOQG8NJ6DYuC1odNxN2WAHpJj9MQakZPkd0bNfJWbjlCaP6/jV5R3204dE2wPoNJSU2Vey9WKf/B8s4b/vSA4SKcIqJWV32CbCNx9Tb/XX+2WiFP0wilUjUbg2IMp3wKRZJAZYa89qK/vQZpvCczzbPhvdPQvl0ThoBdohfbEAjevgugwdkPK5TEcDdgqj40E9yZYPKJQooarjdIb+QX8Ri/mCZTQip5QXtFFTYc6v99SublMlhf/ZM1A5lCusbtas3ywoBDZywSp6EPHSOAC2awoADinxjcovzkhfktDPkNRLwtgfUXWhEdJ3LVSOjkvWt5ztFdpc5ZZvZxd0G3jUzRnFrC1g3BPTK0xXx/oD61kLtfsufuf38RBtkZAXJUdUpuqA24pGg7ILxDHABHrUKTm1rlrKFPvIk2znM1a/aopxQBmP90qKdJhQ04QGo6Q4XaHlfPAQGzMxR6Q53A6Peu0mKFWqCFOG1wNAAjFK4wBu//iQTUYR/e0Dcc2aMzgcGMVf6xiipkj/53Fpif7pcWB+xsjPurKgk+AhchrvAsHqZ4sVVTqZJ1l7zVLavitNAlBcymYem0Xz5vwyBVzYzAbF4TmL7nHbZctnjBd/4rFG1Kp5NQiII0gYg4ZnpQ/PoCpmDHXZMeig4IoA9ONv9UCTKLCGDuPmeNmraDhRB1lyGQXAD/OB+zk5Wy4zxLyimzPhD6UANsPVzE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(4744005)(8936002)(8676002)(33656002)(54906003)(52536014)(55016002)(9686003)(2906002)(86362001)(38070700005)(316002)(6506007)(71200400001)(4326008)(7696005)(38100700002)(5660300002)(122000001)(508600001)(6916009)(966005)(55236004)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WkpLU3NJU3d0S0xYM01HWjVLK3FwTVV0ZHpEbCs0cXdRdnIvbEFsVFp4QmpS?=
 =?utf-8?B?eVBreS8xT2VFcWNiZEVRNlRBT2VBRlMxc0xqckNkb29sdjNJRnpLcTU0bnRz?=
 =?utf-8?B?Wk5ZWnF3VncwUTc4SW5rSkwreEJJSzFTY0ZlWnNHV2JiTmJQQTUwYktGTU9v?=
 =?utf-8?B?WlBTdWtMZ01XM3V1cjhDYVJ3cUJRV1MvL3BlSERuakN3RHpPeGVJcittKy9G?=
 =?utf-8?B?cFNCcXF2bDhoL25Rc1huTnlBdkp2d0Q2NUZmSDQ1cFB5aS9oQ0dBQzZlc1FF?=
 =?utf-8?B?QkhFMXNXZ05NeUNuWitkcEN3YTN1ZDdoVHg2WjJUKzQvUDZrc2J1NUdCV1lR?=
 =?utf-8?B?ci9xYWprQVBlVEpQbXFONzBPeHhPdkxaSWJiaFBwdXBKYnJZS25yUTR6alNx?=
 =?utf-8?B?dEF6KytYdDdyMVREa3FDMWFGU1g3M1hQWXNjNWg3M0dMa1JIejlWdUNsQ0lE?=
 =?utf-8?B?N1g5VDdweS9GeHYzbmdKZlFiUCtFSnpNWWdDVDVpTlJmV3pMOW40UUtoSU0x?=
 =?utf-8?B?WUlLSFZmMGl3eTFjZGU0T0t1SVkzRGUwVTNGdFJkeUk0cnpwZDVwc3k4ejRj?=
 =?utf-8?B?TW5uV2NrQ0h1czk3alJUSmRtZWoxcHRLbWtjTVVjckxBRkR1eEpnOWZrSy9u?=
 =?utf-8?B?cG9SVXFFK3ZqdTYwRllGZTc4VmRJTEJXaGd6MUZ5MXJqMCtUWEd1WCtKMGZa?=
 =?utf-8?B?M2RNRHczZGlqWlV3RU5IUDZoOHFJcVdCdEFSWE1ST29qOUdmdXRHdjRlWSt1?=
 =?utf-8?B?alRZM29COEFCMVQ3c3EzTktwUU92cmNyd1lMaExOdXZybzVlN2VIblBKZTd3?=
 =?utf-8?B?aDNGS0FEVVRhazRwQW15a0VtRFQ5djZaOFJWOFdTdmhDY0lyNEM2YkxtMEN2?=
 =?utf-8?B?ZVcyWXg5V1cwaTA2WE9JckdKOGxydG51M0swcmoxNjlkS0dYREplUkg3Z0lm?=
 =?utf-8?B?elpPR1NYUnZlc0RjckhqZ2lWcXVvOEVMSXk2SWRCdXdYNm9pTXVsWWQvdytQ?=
 =?utf-8?B?cy94WEJTc1NCYWI4ek11eEdrZ1NxYlA1ZXdueHpOdCtjWkdGMWZsb1dhVTAw?=
 =?utf-8?B?ZHhQa2JGakZSM0ZkTlZwVTdGQnhTTnNTdDFyckhCblVVSzFyVEVXTXVjaTh0?=
 =?utf-8?B?WVhHNzJsZ1ZZS2RzMWxOWkQzR0hPVE9ZcjBHWUgvWGRyL1I2T1c4YTFpUHQ0?=
 =?utf-8?B?TnlFdzJ5bzR4N3pSTUVUOXhjcGVSZjNsK3huc3hFbHBVOFFtS2RNY3UrelBy?=
 =?utf-8?B?L1pMTzNxWnFDd3ZXeWpvOUpLNXV2aGdnVFI5THdjZ1p3QTJnVUVlbk9uakRq?=
 =?utf-8?B?elpIUDNFL3N5eHRUNTBWSUFoUjFmSXpEclFjcHFJalU3THlIUFRRZTN4T3Bz?=
 =?utf-8?B?ZnYvQnEwS01WdjlUNXRLNkxNVk1hRnZaaVk1QkFNam0zUzJpWm93Sk9NS2Vr?=
 =?utf-8?B?VG1STXRtN3l4Y1FqbDZQQTdpTVNOTXl4eEtKWG5DWG1kQjJibkszNXJXUWRJ?=
 =?utf-8?B?dzRzQWpXUElsZjF1NW1zaExDRFI2RGM3cHNOOGVReWExR01zMDhkQXB5Sm9G?=
 =?utf-8?B?aW9saUNkTDZtVzhud3E0S0VkV1NHTmZHT2NmRTJyYW53bmY3d0ExZVFLcTBa?=
 =?utf-8?B?OFM2UEhUemRMR245eUdkVCtaWnJac2t2RGpTRzR6ZmVycEo3WnQ5WkQvRVZB?=
 =?utf-8?B?RS8wd3hoT0pueUJWaWlhbkJVRnd6L1JHS3RaQmRsUkM4TEZLT29nRlRSMS9B?=
 =?utf-8?Q?7bX3MpYgysflcQ7KDanvIWK/Nmwq2TTXyjKFO0p?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e562764e-143a-42ea-9768-08d98bba7ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2021 06:52:15.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Ix8p/86HGYv9ynNforwR1MtbvZudNKPmZkCbn9YmLwqCBc6xZdAxXxje9qi7hUbVvx5CjW0qnwIACZZhZUFTp6PdpH+FMGM4ntHRvvJZuSxnFITqpFnsFbbDMjcOwBXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3312
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 10 Oct 2021 06:52:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6805

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4yMDktY2lwNTkgYW5kIHY0LjQuMjg3LWNpcDY0Lg0KVGhlIGxpbnV4LTQuMTkueS1jaXAgdHJl
ZSBoYXMgYmVlbiB1cGRhdGVkIGZyb20gdjQuMTkuMjA3IHRvIHY0LjE5LjIwOSwgYW5kDQp0aGUg
bGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBmcm9tIHY0LjQuMjg1IHRvIHY0
LjQuMjg3Lg0KVGhlIHJlbGVhc2UgaW5mb3JtYXRpb24gaXMgc2hvd24gYmVsb3cuDQoNCiAgdjQu
MTkuMjA5LWNpcDU5Og0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5j
aDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDExZTgw
M2UwNWUwNjFkYzMyZTkyZGViN2JkNzNjMjBkZmJjNDhhZTUNCiAgIEZpeGVkIENWRXM6Og0KICAg
ICBDVkUtMjAyMS0zNzE1OTogdXNiOiBoc286IGZpeCBlcnJvciBoYW5kbGluZyBjb2RlIG9mIGhz
b19jcmVhdGVfbmV0X2RldmljZQ0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAg
dmVyc2lvbiBzdWZmaXggdG8gLWNpcDU5IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCiAgdjQu
NC4yODctY2lwNjQ6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNo
Og0KICAgICAgbGludXgtNC40LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICAxODU5OWZi
YzczNzExMzYxZDI4ODBkMjA1MWIyZTFmMTViY2ViYzEwDQogICAgRml4ZWQgQ1ZFczoNCiAgICAg
IE5vbmUNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4
IHRvIC1jaXA2NCBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJlZ2FyZHMsDQogICBO
b2J1aGlybw0KDQo=


