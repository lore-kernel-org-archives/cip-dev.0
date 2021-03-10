Return-Path: <SRS0=VU3i=II=lists.cip-project.org=bounce+64572+6263+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFEC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:08:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA9164F76
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA9164F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6263+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x52lYY4521723xKcuGq5zkqL; Wed, 10 Mar 2021 00:08:07 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.5864.1615363684017202307
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 00:08:05 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 12A87puq024743; Wed, 10 Mar 2021 17:07:52 +0900
X-Iguazu-Qid: 2wHHpnh2s1ZDHG65dE
X-Iguazu-QSIG: v=2; s=0; t=1615363671; q=2wHHpnh2s1ZDHG65dE; m=LSfD0W2/7sqcyoo0OLsDAzuX8P5P2xlTvVUImOkxxKw=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 12A87oPt033421
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Mar 2021 17:07:50 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 4AC8D1000D3;
	Wed, 10 Mar 2021 17:07:50 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12A87nE3014847;
	Wed, 10 Mar 2021 17:07:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A542gPyQVpD1lQUkXYNqer6v+I0fxyITtz2Fqxh9vGl+6HWkw83t3dH5Frlh3LLLyIeD0WoBNhe6twXMDhWJouVgfZq2pxnxXQjXVLrgbpyD8yxqP9vKdb107wi31z7UJOeba19x3vI1hdHikJZ7FgxxUvrFU1fO1mAN9J/+TBavYLfgYiQGmrklnt6KT5WwDppK00q+lAPwytR+Xzi/+pFpP95riy2SWUs0TGJdXh+wyJ44agH3EcWb30+qrrYUOcet22DB9q5Ou1ceUXUH0C8V4xyUXgVl+tHbtwQHjwiUeJU7Z5uvsuqBzUehJswzCsroJ3VNDtM3FdEhZ5Lcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/VIQWkXJ9iDiSEfHy/MBEP54QFfYL6oMbtUP5n1Wv4=;
 b=MEgx2BBWExAAVboTVwXpTsFqJCSinDD2g4KPhJvN3PyTMuCrz9mIKB3ixbsqAzUBXksrSmAYBZF5nQ+UlgfVdo62DbXckLFPe5K7FaBlERg1qJQN2qqV3jJeRgpBFjJTd5WpoP21YBJ8QaKw7GqoUp5hmy/ZA0vlC9n3K0WCM9GjpYxctF/mLZ8l/KLcg2/YnYnwaGUSa5txPOk5yDh5WwAJRtEbhk/lqHCWaBMdG2poIQlNPHfD1ya5rK9w0ITO+qaTl9znEzdJyYiIgP+jKpWgpdSHf/TsY+xW45Jjk+PoID3IorJRP7xTnyFDLtmu+hbLul9oiZjsMHeqNlc6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2 support
Thread-Topic: [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2
 support
Thread-Index: AQHXFQKCeNUxx4cvSEGqy5bT8tjj/qp83XbQ
Date: Wed, 10 Mar 2021 08:07:46 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E11EB3496D43C5B6DC3892919@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e83840-1f43-421e-e694-08d8e39b96f0
x-ms-traffictypediagnostic: OSBPR01MB4133:
x-microsoft-antispam-prvs: <OSBPR01MB413393A9D005053DAAFB25CE92919@OSBPR01MB4133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IV9+Hg6orvrMbKJAujO+Yhuy1+NpYAT5zvAfLpYGQPUMFbgMhnMcj6tb6JW0uc6YXZ4PVnMqF2SQv1+focTgt5dKz7P8gBZS0P2h+lJnKrhJeWHBBiOOw/cFIzD8YJNApOQfw5Ans2oqtxHId9YVEP/3sqpfvKgKsB/El+fJ0+QFGKGPlAiVil9rqBJEaOes9mZTllahLOqZbvJuN/qnxyQwZF9O09pXCOVEYtZIfEa/ImNyS9wKOfv3uxccqFjE/oyoeRc3mpVyx40zRZ2ACni+XBaMz35x6GclTHezBVFLJkFMk9t6gogs97EmJJaHDxxSiNbyrXsmsvGd7WsFzvkM5hjYdKc7HuYj3s5k0er5ZfDBJprbu0v7G5eDbFdrTpjeURqPwhDUfyQ3ieJYGIE2UWSBD2jE1y4TDXAAtMrcyvyjNqprTZWRgYlB2L48NwYvU+b2XaTvVJ5Bl9SfMiC/LFjF1xfonjUasnyoqROj+DBRwGvecoSqYQXR3QuxgAdVJaren4+pyh2XUxAeQg==
x-ms-exchange-antispam-messagedata: =?utf-8?B?TXZodVlCUDVhZnEwNzkxZUZSZDE4K01RTG9vMkR0ZytiWFAraytJeWlHTER2?=
 =?utf-8?B?TXpIMHdaZ1ZJeklldDcyOFNMcHVtdjYxQTRjOEJKUXo3cS9xUVJUck9IODNG?=
 =?utf-8?B?S2ZxU3lBdjlDOUJNSGdBdGlpTkZrU2FoMDlBUTdrYlZUaGdnM3dpVG1ybEh5?=
 =?utf-8?B?WklRa21PQUNkNmNSRUIySjJ6SDNmdmEraTJlODdGeHA0NlVaU2hiVk5Pb3VQ?=
 =?utf-8?B?Y04yZzN1dk9MQ3g5enllMkkrNGlvdG80ckVIYVFMVjZPc09nMTZsMDRrL0Qx?=
 =?utf-8?B?ZHBjUXdlMHBLUnZva0hjbjJiVGdWbkFmUmZudTJQOHpUVEVsQlNtTGtwTXFJ?=
 =?utf-8?B?NWs2M2tkUUZkdksxSFMxcTh3b3A3M0RVUnVYQU9Rd0Zsa0hBaXMvNjRNdjVX?=
 =?utf-8?B?cllPbmdsYkFZQW51Q1JiSlNrL201WHRwdzFUOTJ4ekcybnV1OExaYURyQlIw?=
 =?utf-8?B?N1g1Q09DNEdGOURmU0ltRUJxMGJ6R3dsMzFMM3VwdXZnbU1lMFBvZXFPVHA4?=
 =?utf-8?B?cDZueTFNNnpxaFJsa1Q1N1p5UFJXRjdPb292L25wNDl2d2ljWkxTMzNleVFG?=
 =?utf-8?B?cExrcUszRWpYam8rTUdoYnVlR1ZyVDlSWnBscTQwa2tPdEdNUU9WblZZTUFX?=
 =?utf-8?B?VVZaWVQ1K3pHWVFHYkRhQ2lxbVdRbGIvcXBTYzRiNGNCZDdwVDBldW1iM1Bs?=
 =?utf-8?B?bW5TVEZFQ21Wamx2S3JEVXRMY1FJZTg5NjlnWFM2R2d1SVEwOE5keW1pSFdD?=
 =?utf-8?B?SndmOEV5aVRnb2NWWU1zc0RwdFY1dm9RZGNNckIzVkRsaStaTS84RFNkNDgy?=
 =?utf-8?B?ZmwyNkVXY2FXTUZVVU1HRnhvV1RYdlhIanRzZGZJTzZ2anlEdDBuUkhodlEz?=
 =?utf-8?B?YnBCNkVtL1dDRVRkSWJCZ3ZOUFhVeW1BVE5uMGtkcnJ6Wm82dFV6WlhiaWs1?=
 =?utf-8?B?aEpvWkxabXlzWEI5eFF0dUlNWUdZaDR0QXdpc2IvdmpCY2xWa3QrY2dKYkp1?=
 =?utf-8?B?M3lQTnUvSERDcm54SHJMaHdITUhzUCt2bURSTnlxbWJFankxb0dlUHpNNUp1?=
 =?utf-8?B?akJTWjZNTzhGRStIUkNScU5DSkNRL0dxNmtkaU1ISlRZWXZRMCt6RWNVMWFW?=
 =?utf-8?B?QjdCQ3F5amdXOFh1M2dITEpuR1pZdm9QSlhJaFp0MkE5TWt0N1A5a3NQRGZ4?=
 =?utf-8?B?eko0eWdqWjR5emNna3lLOVpaY0RwYXZpTXZjV3FoOWliMFhPSFdJK2M1YUJD?=
 =?utf-8?B?QjdoU1Z0dUhsbkR5V0UwakFMVy9FMEg4U0lGQUFDbjVyOHZJNXNvdWdETkJW?=
 =?utf-8?B?OFFUSSs3VDRXSUFvbnhpenJ1eVpoVzgwS01VSTNDWFdyRkpVZHlnMDQrTGJC?=
 =?utf-8?B?bU5WWDdXZW9kNHJSUjFaRFlDN0pJWTA0V2hzL09iV0lDeFdpT0xWSEpiQ0xW?=
 =?utf-8?B?TTJBaVFIU05MMkVYVTlCZ1I0c1BLY2htd1BFUXZVL2FOVGYvU3NOMFMvVk5G?=
 =?utf-8?B?UVphbTlEZ3VBa0sxMThieG1OOTZlV043am5qWktkWXN5STBnMHE2d0FWVGU0?=
 =?utf-8?B?OHc4Q0d5RE4rQlp1ZEFuWm0zc1RjbzBuRGZUcTZvb3lHdEhqa2o2VU9tMXl3?=
 =?utf-8?B?V1NoWlV0UmRLcmFkV1BZRDRMOVNhQjllZys3YVhpV0U5S0dPM2JNOHJvc21O?=
 =?utf-8?B?cEV3WkNFd0ovTEJNMVpTVG5MbkN0V1V4YVh5dU9nbVZqQk4vcmxCQ2x6ZCtJ?=
 =?utf-8?Q?7C9W/VbYyianlS6we8=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e83840-1f43-421e-e694-08d8e39b96f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:07:46.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0ZVGxscP20gkOt1gLeGuGA+AKQ46bMBtR0wWbjdThlhTOhTLY+QAGtw4wYKF8Ai2yHXg181xmsedA2FgFLFU1RDLcj6wExE1JK98KxpZxMbLSU+8SyajUB/EBawkDpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4133
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gVxjizJBb5mwEg1XTjSOANzwx4520388AA=
Content-Type: multipart/mixed; boundary="KdJs8I5MYWQccEzAyrUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615363687;
 bh=d1ZWHr6h61Bkj7lnlVfH75xt4e5Ac7uhyHKmHPcbmSQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=qZMWzsRabjmFoOauIBK4iuDg07hxnugcV0Qm3iq8zghneM7TTejJfhP4iioWgTBEVDt
 Ot2BA3gm5+glYoKnjFgbWwZw9tqdWWemIDhSJmGP0h0u8CubjGMxvceppRzb+S8Y0Mz8Q
 zdzLja4af7sxotSzaaswLh6vYlQ3/X/84EA=

--KdJs8I5MYWQccEzAyrUA
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAxMCwgMjAyMSAxOjM2IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47
IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDQuMTkueS1jaXAgMDAvNDBdIFJl
bmVzYXMgUlovRzJ7RSxILE0sTn0gYWRkIFZJTiwgQ1NJMiBzdXBwb3J0DQo+IA0KPiBIaSBBbGws
DQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBkb2VzIHRoZSBmb2xsb3dpbmc6DQo+ICogRHJvcHMg
dW5uZWVkZWQgcmVndWxhdG9yIHNldHVwIGZvciBPVjU2NDUgc2Vuc29yDQo+ICogQWRkcyBkcml2
ZXIgZm9yIElNWDIxOSBzZW5zb3INCj4gKiBVcGRhdGVzIHY0bDItYXN5bmMgdG8gYWNjZXB0IGVu
ZHBvaW50cyBmb3IgZndub2RlIG1hdGNoaW5nDQo+ICogVmFyaW91cyBmaXhlcyBmb3IgUi1DYXIg
VklOIGRyaXZlcg0KPiAqIFN1cHBvcnQgdG8gY2FwdHVyZSBSQVcgZm9ybWF0IHRvIFZJTiBkcml2
ZXINCj4gKiBTdXBwb3J0IGZvciBSWi9HMntILE0sTixFfSBTb0MncyBpbiBWSU4vQ1NJMiBkcml2
ZXINCj4gKiBEVFMgY2hhbmdlcyBmb3IgSGlIb3BlIFJaL0cye0gsTSxOfSBhbmQgU0kgTGludXgg
UlovRzJFIHRvDQo+ICAgZW5hYmxlIFZJTiwgQ1NJMiBtb2R1bGVzIGFuZCBPVjU2NDUsIElNWDIx
OSBzZW5zb3JzLg0KPiANCg0KSSByZXZpZXdlZCB0aGlzIHNlcmllcywgSSBkaWRuJ3Qgc2VlIGFu
eSBtYWpvciBwcm9ibGVtcy4NCkFzIFBhdmFsIHBvaW50cyBvdXQsIHRoZSBSZW5lc2FzIGxhYiBp
cyBub3cgc3RvcHBlZC4NCklmIHRoaXMgcmVjb3ZlcnMgYW5kIHRoZSB0YXJnZXQgaGFyZHdhcmUg
dGVzdCBpcyBva2F5LCBJIHdvdWxkIGFwcGx5IHRoaXMuDQo+IENoZWVycywNCj4gUHJhYmhha2Fy
DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo+IA0KPiBBbmRyZXkgS29ub3ZhbG92
ICgxKToNCj4gICBtZWRpYTogZHQtYmluZGluZ3M6IG1lZGlhOiBpMmM6IEFkZCBJTVgyMTkgQ01P
UyBzZW5zb3IgYmluZGluZw0KPiANCj4gQmlqdSBEYXMgKDEwKToNCj4gICBtZWRpYTogZHQtYmlu
ZGluZ3M6IG1lZGlhOiByY2FyX3ZpbjogQWRkIHI4YTc3NGExIHN1cHBvcnQNCj4gICBtZWRpYTog
cmNhci12aW46IEVuYWJsZSBzdXBwb3J0IGZvciByOGE3NzRhMQ0KPiAgIG1lZGlhOiBkdC1iaW5k
aW5nczogbWVkaWE6IHJjYXItY3NpMjogQWRkIHI4YTc3NGExIHN1cHBvcnQNCj4gICBtZWRpYTog
cmNhci1jc2kyOiBFbmFibGUgc3VwcG9ydCBmb3IgcjhhNzc0YTENCj4gICBhcm02NDogZHRzOiBy
ZW5lc2FzOiByOGE3NzRhMTogQWRkIFZJTiBhbmQgQ1NJLTIgbm9kZXMNCj4gICBtZWRpYTogZHQt
YmluZGluZ3M6IHJjYXItdmluOiBBZGQgUjhBNzc0QjEgc3VwcG9ydA0KPiAgIG1lZGlhOiByY2Fy
LXZpbjogRW5hYmxlIHN1cHBvcnQgZm9yIFI4QTc3NEIxDQo+ICAgbWVkaWE6IGR0LWJpbmRpbmdz
OiByY2FyLWNzaTI6IEFkZCBSOEE3NzRCMSBzdXBwb3J0DQo+ICAgbWVkaWE6IHJjYXItY3NpMjog
RW5hYmxlIHN1cHBvcnQgZm9yIFI4QTc3NEIxDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhh
Nzc0YjE6IEFkZCBWSU4gYW5kIENTSS0yIHN1cHBvcnQNCj4gDQo+IERhZm5hIEhpcnNjaGZlbGQg
KDEpOg0KPiAgIG1lZGlhOiBpMmM6IGlteDIxOTogRml4IGEgYnVnIGluIGlteDIxOV9lbnVtX2Zy
YW1lX3NpemUNCj4gDQo+IERhdmUgU3RldmVuc29uICgxKToNCj4gICBtZWRpYTogaTJjOiBBZGQg
ZHJpdmVyIGZvciBTb255IElNWDIxOSBzZW5zb3INCj4gDQo+IEZhYmlvIEVzdGV2YW0gKDEpOg0K
PiAgIG1lZGlhOiBvdjU2NDU6IFJlbW92ZSB1bm5lZWRlZCByZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uo
KQ0KPiANCj4gSGFucyBWZXJrdWlsICgyKToNCj4gICBtZWRpYTogaTJjOiBpbXgyMTk6IFNlbGVj
dGlvbiBjb21wbGlhbmNlIGZpeGVzDQo+ICAgbWVkaWE6IGkyYzogaW14MjE5OiB0YWtlIGxvY2sg
aW4gaW14MjE5X2VudW1fbWJ1c19jb2RlL2ZyYW1lX3NpemUNCj4gDQo+IEphY29wbyBNb25kaSAo
MSk6DQo+ICAgbWVkaWE6IGkyYzogaW14MjE5OiBJbXBsZW1lbnQgZ2V0X3NlbGVjdGlvbg0KPiAN
Cj4gTGFkIFByYWJoYWthciAoMTYpOg0KPiAgIG1lZGlhOiByY2FyLXZpbjogSW52YWxpZGF0ZSBw
aXBlbGluZSBpZiBjb252ZXJzaW9uIGlzIG5vdCBwb3NzaWJsZSBvbg0KPiAgICAgaW5wdXQgZm9y
bWF0cw0KPiAgIG1lZGlhOiByY2FyLXZpbjogQWRkIHN1cHBvcnQgZm9yIE1FRElBX0JVU19GTVRf
U1JHR0I4XzFYOCBmb3JtYXQNCj4gICBtZWRpYTogcmNhci1jc2kyOiBBZGQgc3VwcG9ydCBmb3Ig
TUVESUFfQlVTX0ZNVF9TUkdHQjhfMVg4IGZvcm1hdA0KPiAgIG1lZGlhOiBpMmM6IGlteDIxOTog
Rml4IHBvd2VyIHNlcXVlbmNlDQo+ICAgbWVkaWE6IGkyYzogaW14MjE5OiBBZGQgc3VwcG9ydCBm
b3IgUkFXOCBiaXQgYmF5ZXIgZm9ybWF0DQo+ICAgbWVkaWE6IGkyYzogaW14MjE5OiBBZGQgc3Vw
cG9ydCBmb3IgY3JvcHBlZCA2NDB4NDgwIHJlc29sdXRpb24NCj4gICBhcm02NDogZHRzOiByZW5l
c2FzOiByOGE3NzRjMC1jYXQ4NzQ6IEFkZCBzdXBwb3J0IGZvciBBSVNUQVJWSVNJT04NCj4gICAg
IE1JUEkgQWRhcHRlciBWMi4xDQo+ICAgbWVkaWE6IGR0LWJpbmRpbmdzOiBtZWRpYTogcmVuZXNh
cyx2aW46IEFkZCBSOEE3NzRFMSBzdXBwb3J0DQo+ICAgbWVkaWE6IHJjYXItdmluOiBFbmFibGUg
c3VwcG9ydCBmb3IgUjhBNzc0RTENCj4gICBtZWRpYTogZHQtYmluZGluZ3M6IG1lZGlhOiByZW5l
c2FzLGNzaTI6IEFkZCBSOEE3NzRFMSBzdXBwb3J0DQo+ICAgbWVkaWE6IHJjYXItY3NpMjogRW5h
YmxlIHN1cHBvcnQgZm9yIFI4QTc3NEUxDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0
ZTE6IEFkZCBWSU4gYW5kIENTSS0yIG5vZGVzDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogYWlz
dGFydmlzaW9uLW1pcGktYWRhcHRlci0yLjE6IEFkZCBwYXJlbnQgbWFjcm8NCj4gICAgIGZvciBl
YWNoIHNlbnNvcg0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IEFkZCBzdXBwb3J0IGZvciBNSVBJ
IEFkYXB0ZXIgVjIuMSBjb25uZWN0ZWQgdG8NCj4gICAgIEhpSG9wZSBSWi9HMkgNCj4gICBhcm02
NDogZHRzOiByZW5lc2FzOiBBZGQgc3VwcG9ydCBmb3IgTUlQSSBBZGFwdGVyIFYyLjEgY29ubmVj
dGVkIHRvDQo+ICAgICBIaUhvcGUgUlovRzJNDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogQWRk
IHN1cHBvcnQgZm9yIE1JUEkgQWRhcHRlciBWMi4xIGNvbm5lY3RlZCB0bw0KPiAgICAgSGlIb3Bl
IFJaL0cyTg0KPiANCj4gTGF1cmVudCBQaW5jaGFydCAoNCk6DQo+ICAgbWVkaWE6IGRldmljZSBw
cm9wZXJ0eTogQWRkIGEgZnVuY3Rpb24gdG8gdGVzdCBpcyBhIGZ3bm9kZSBpcyBhIGdyYXBoDQo+
ICAgICBlbmRwb2ludA0KPiAgIG1lZGlhOiB2NGwyLWFzeW5jOiBBY2NlcHQgZW5kcG9pbnRzIGFu
ZCBkZXZpY2VzIGZvciBmd25vZGUgbWF0Y2hpbmcNCj4gICBtZWRpYTogdjRsMi1hc3luYzogUGFz
cyBub3RpZmllciBwb2ludGVyIHRvIG1hdGNoIGZ1bmN0aW9ucw0KPiAgIG1lZGlhOiB2NGwyLWFz
eW5jOiBMb2cgbWVzc2FnZSBpbiBjYXNlIG9mIGhldGVyb2dlbmVvdXMgZndub2RlIG1hdGNoDQo+
IA0KPiBOaWtsYXMgU8O2ZGVybHVuZCAoMik6DQo+ICAgbWVkaWE6IHJjYXItdmluOiBmaXggd3Jv
bmcgcmV0dXJuIHZhbHVlIGluIHJ2aW5fc2V0X2NoYW5uZWxfcm91dGluZygpDQo+ICAgbWVkaWE6
IHJjYXItY3NpMjogVXBkYXRlIFYzTSBhbmQgRTMgc3RhcnQgcHJvY2VkdXJlDQo+IA0KPiBTYWth
cmkgQWlsdXMgKDEpOg0KPiAgIG1lZGlhOiB2NGw6IGN0cmw6IFByb3ZpZGUgdW5sb2NrZWQgdmFy
aWFudCBvZiB2NGwyX2N0cmxfZ3JhYg0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
ZGlhL2kyYy9pbXgyMTkueWFtbCB8ICAxMTQgKysNCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lZGlhL3JjYXJfdmluLnR4dCAgICB8ICAgIDMgKw0KPiAgLi4uL2JpbmRpbmdzL21lZGlhL3Jl
bmVzYXMscmNhci1jc2kyLnR4dCAgICAgIHwgICAgMyArDQo+ICBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA4ICsNCj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvcmVuZXNhcy9NYWtlZmlsZSAgICAgICAgICB8ICAgMTAgKy0NCj4gIC4uLi9haXN0YXJ2aXNp
b24tbWlwaS1hZGFwdGVyLTIuMS5kdHNpICAgICAgICB8ICAgOTYgKw0KPiAgLi4ucnpnMi1leC1h
aXN0YXJ2aXNpb24tbWlwaS1hZGFwdGVyLTIuMS5kdHNpIHwgIDEwOSArKw0KPiAgLi4uL3I4YTc3
NGExLWhpaG9wZS1yemcybS1leC1taXBpLTIuMS5kdHMgICAgIHwgICAyOSArDQo+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YTEuZHRzaSAgICAgfCAgMzY3ICsrKysNCj4gIC4u
Li9yOGE3NzRiMS1oaWhvcGUtcnpnMm4tZXgtbWlwaS0yLjEuZHRzICAgICB8ICAgMTYgKw0KPiAg
YXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGIxLmR0c2kgICAgIHwgIDM2NiArKysr
DQo+ICAuLi4vZHRzL3JlbmVzYXMvcjhhNzc0YzAtZWs4NzQtbWlwaS0yLjEuZHRzICAgfCAgIDcz
ICsNCj4gIC4uLi9yOGE3NzRlMS1oaWhvcGUtcnpnMmgtZXgtbWlwaS0yLjEuZHRzICAgICB8ICAg
MTYgKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGUxLmR0c2kgICAgIHwg
IDMzNCArKysrDQo+ICBkcml2ZXJzL21lZGlhL2kyYy9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgfCAgIDExICsNCj4gIGRyaXZlcnMvbWVkaWEvaTJjL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICB8ICAgIDEgKw0KPiAgZHJpdmVycy9tZWRpYS9pMmMvaW14MjE5LmMgICAgICAgICAgICAg
ICAgICAgIHwgMTU4MiArKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9tZWRpYS9pMmMvb3Y1
NjQ1LmMgICAgICAgICAgICAgICAgICAgIHwgICAyOCAtDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL3JjYXItdmluL3JjYXItY29yZS5jICAgfCAgIDQ5ICsNCj4gIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vcmNhci12aW4vcmNhci1jc2kyLmMgICB8ICAgMjMgKy0NCj4gIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vcmNhci12aW4vcmNhci1kbWEuYyAgICB8ICAgMTcgKy0NCj4gIGRyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vcmNhci12aW4vcmNhci12NGwyLmMgICB8ICAgIDQgKw0KPiAgZHJpdmVycy9t
ZWRpYS92NGwyLWNvcmUvdjRsMi1hc3luYy5jICAgICAgICAgIHwgICA4MyArLQ0KPiAgZHJpdmVy
cy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy5jICAgICAgICAgIHwgICAgOCArLQ0KPiAgaW5j
bHVkZS9saW51eC9wcm9wZXJ0eS5oICAgICAgICAgICAgICAgICAgICAgIHwgICAgNSArDQo+ICBp
bmNsdWRlL21lZGlhL3Y0bDItY3RybHMuaCAgICAgICAgICAgICAgICAgICAgfCAgIDI2ICstDQo+
ICAyNiBmaWxlcyBjaGFuZ2VkLCAzMzMwIGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZWRpYS9pMmMvaW14MjE5LnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jv
b3QvZHRzL3JlbmVzYXMvYWlzdGFydmlzaW9uLW1pcGktYWRhcHRlci0yLjEuZHRzaQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9oaWhvcGUtcnpnMi1l
eC1haXN0YXJ2aXNpb24tbWlwaS1hZGFwdGVyLTIuMS5kdHNpDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGExLWhpaG9wZS1yemcybS1leC1t
aXBpLTIuMS5kdHMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
bmVzYXMvcjhhNzc0YjEtaGlob3BlLXJ6ZzJuLWV4LW1pcGktMi4xLmR0cw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3NzRjMC1lazg3NC1taXBp
LTIuMS5kdHMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVz
YXMvcjhhNzc0ZTEtaGlob3BlLXJ6ZzJoLWV4LW1pcGktMi4xLmR0cw0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbWVkaWEvaTJjL2lteDIxOS5jDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K

--KdJs8I5MYWQccEzAyrUA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6263): https://lists.cip-project.org/g/cip-dev/message=
/6263
Mute This Topic: https://lists.cip-project.org/mt/81205345/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KdJs8I5MYWQccEzAyrUA--
