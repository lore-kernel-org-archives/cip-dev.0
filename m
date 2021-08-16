Return-Path: <SRS0=6JUc=NH=lists.cip-project.org=bounce+64572+6682+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E835C4320E
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 22:50:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B2C60ED5
	for <cip-dev@archiver.kernel.org>; Mon, 16 Aug 2021 22:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78B2C60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i3NxYY4521723xB92pj1c4Ju; Mon, 16 Aug 2021 15:50:23 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.31587.1629154219684269739
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Aug 2021 15:50:21 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17GMoFSf016513; Tue, 17 Aug 2021 07:50:16 +0900
X-Iguazu-Qid: 34trdvrI6hiA7Gm73C
X-Iguazu-QSIG: v=2; s=0; t=1629154215; q=34trdvrI6hiA7Gm73C; m=FT4ucucwVQ+BJkp3mp7Qw3WLG1zI3UbKC36TaXKcLkQ=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 17GMoFJZ039251
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Aug 2021 07:50:15 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0482C10008D
	for <cip-dev@lists.cip-project.org>; Tue, 17 Aug 2021 07:50:15 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 17GMoEax021771
	for <cip-dev@lists.cip-project.org>; Tue, 17 Aug 2021 07:50:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYQex2NsVfqzFd6uQ5A7JKLeWrvlmBV3FqfJT9vinqoyy2jLSsrm48dQktPr+d4H3xxyOnve+icFOsMVQPmBHbiiZKhyAqm+ypkgljrcUJhX9iCtvlkloTm6TOI0lzIhM/K1oBlS66sQZP5kIcBdPWYB3dhqHyucmsruofV+jITvRMxPSSypU3/sDuRz2RFyRjTX2RtD5XqOGTCFIWRA7svxDFgvvCA7i3kuioJwTGoaSZpzw9IDGMMl2haaktrYiwsuXD+nGEevIjDnZMDK8H9l5xX+C/q/7bpXlUptzSWqodI1iGCxMFp7mx2M0B2zvQ/FuJLGx9MTtqhEyX9wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srNNOltk7dErzguvfCdl48tKsS0hd5Zb5nTTWoaNSKk=;
 b=ZFmRxXebU5r8SInCIHMVOzvvKcHreq/82IBRwSTETbyRtsjx03WS4z11nUkVcyobM92EYytA0SpSzfcRr2yOYxU+OOnZ7ckXaISoHd5/sCcidKSEKRbDFzBsVxIcMpGgTR0wYROOCXVr/hxozgqZyXOinYu5nCdYmGT1L+NB++erHJd74pAOwxFseiU/ti00wo/I5kHp3d9wc6QqEd7F/dLZMjukePgGu7AQ1m71Ps8z0jFdSmligJjUsdOcboguiuKVveXIJE17LwWxWGAkWVK+i41cLgnStdZbH4YMrUgYVSU3bu9zjALQDl1D0xYc+/QVFJMvcjVy8tEZUBYX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: [cip-dev] -stable-rc tests failing
Thread-Index: AQHXjnvAnZW454Fq80SVq3nBye0P7att8RzAgAPpxYCAA17qgIABZm9wgAAFPQCAAB+CIA==
Date: Mon, 16 Aug 2021 22:50:09 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252D1BA52620A914646281292FD9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210811063943.GA23723@duo.ucw.cz>
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20210813194635.GB23237@duo.ucw.cz>
 <TYAPR01MB62529F6AAF0B05B25FD8DFB292FC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <169BE3F8982B564E.22901@lists.cip-project.org>
 <OSZPR01MB68771A99C8228B8DD42D8679B7FD9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB68771A99C8228B8DD42D8679B7FD9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 860ac07d-af4c-4a8b-5724-08d961083386
x-ms-traffictypediagnostic: TY2PR01MB5017:
x-microsoft-antispam-prvs: <TY2PR01MB5017C24DC5CA5BD034E0ABDA92FD9@TY2PR01MB5017.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: nXgpm1Ut0op7QbrmvG98PRGzoZLArj5xmbNaeUGUrWK8dzQ5fmbPCZUp7JqZJRAPjVYvLoQ/BcK67X44M7YR0Y5njVwgtpwDSqx+DhmpZqMvQQpy0qK6DiaZ+52zkCF9p4Hq3b1sEI8xVfUWSbkp1FmvW8kurPRPFxxnaZTzV+/fWshKCTOdGKEOBJnfqSH5WaLuO6z0foCDhrNw8HRAfncr238Q2A2mmbUELdoYBgDGeMpDoSPQ7x+raFd5xSlpdIFw7mcyoyCLWR396qz+QhSObOSCfuvg8qdzePFv1sQ6R98oNdBQDlm8alUDQHeZiG1thzXxmg8EdwiZVnZiOSOqMXMZdUXemBqlA8wYjAT6i91+Mcn169lTA6rydQ+A+coIe0j5DFiDqQKDuI+KDK1TgLdgkAmIc2eIv7vWurqjuxfOU0spPagzl6oPnSA6WJePMyra5zfwdM46vMbafqIk+JGTQorZoXtdjz3yCaVvwy+WSmZ85yN71lkSruCkmmSYCP8AIjJByitZxZ7vVULrH9wG2XOE9kZof4GhBMtA3axOrGAMDI1JJEWLLjOzrELkOwtRhvOxbCstaCkaLGfKsxawM65Q7+6krlWNRvu7+8BqtTcG20axjBkYniT7yyUgXCBhSs1rRn1d76r8vIJF4WiZXt7ZPWmc4JQ11qyx51mNwrXhZ4yXz/qS2+367faqYLuZb+V3fokXoAocfg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjZJaThJN2NTcEJsVVVheXRvTnJrNTdEejNkb2VWRytMNmVFR1p3aXFXcTRC?=
 =?utf-8?B?MHo3eXYrRlMzYUhqZllQalF3bEZzbm0rWFhONm9Zc3VIRHpFT1ZLOXlJZnlQ?=
 =?utf-8?B?dnlGa09BMFNqaE04MW5ZY290VGRQSmd6QVRqYzhQbWxDd1lSTDdsNmV6ZjJm?=
 =?utf-8?B?WGErSVVjS0svUUFKZVB0UXlrOGlFNWh6WDFGU3NXVS8ySk40Rk41TXNsN2lE?=
 =?utf-8?B?YXZqS2lVczRlVE9EU0RBaWNFM1ZCRDdSNndtbE1PZXc2eWtSRXRoT2lpOElw?=
 =?utf-8?B?YzRZSEpxZXJrUmVRaTJVWnVFUDZmZzArOVRTZ3duTEtMMHF2SDJkb1JsTW9v?=
 =?utf-8?B?SVJlWG10N2NmT1k5SCtWNDN4UEJtdmVSSEgrL0cwMHBmRnpjcVU2VFlpMW1u?=
 =?utf-8?B?cjRUQUxCYjZhSHNkcXFMRDMrOVVBZzFlU1V6VUJueTdPYUt5ZFJhVG1OMjdw?=
 =?utf-8?B?cHNzbUhNdHUzUzlpVktuZXZUQTQyN1lENUl0RDZOZDNxd3VlTjlzWUptN2Ew?=
 =?utf-8?B?ZmlTS0hNaUF0VG9vTzV0MlVBWkFwR2FpT3pDYTZvMkFWTTNvdno0dmdmeXE5?=
 =?utf-8?B?YTFpZEE5Qk5FaGJSbW13aDFtRzRxOHJSUVRseTFNR2l1bGxNcTFORndyaDAw?=
 =?utf-8?B?b3hPMzlvZGFML2xmNGRVM2JwWEJPZEliT3l5Z2dEazZYTDEvcHdqWFBROXhi?=
 =?utf-8?B?cWc2bVdTNkwxTW9QSVdQYWRiSWdONTJMR3UvZnZZODRMSTgwSlF6YnBaU2Np?=
 =?utf-8?B?NVZPd3RldWNSVjl0MXkvZ1g3aGdQWGZQZ1ZaOEs3aGlmbnlLeVoxelhwUDRO?=
 =?utf-8?B?eTNXZzRWSlRZTWlCSHRxTkVOVXZtZmNHOFVZZnFkTUQreGhITlp3ZEpKcUV4?=
 =?utf-8?B?RjBPUEVEdDQ0OGRmMmV0NytZVm45KzhzaFRLUWUwOFBlTHVtVXZlT2lCdVlI?=
 =?utf-8?B?VDlIbnBKanFNWlVkaHNpNzRwR2s5WVRHbkRNNzQ1YktMVit4bGtZQm40eDV1?=
 =?utf-8?B?alJCSkNpME5BNUtURGVuRkRqS3RxVk8wRk5tczhNdExRb0dwamRERHVCTkN3?=
 =?utf-8?B?MklxWUNSTHVFNW9nN1RtVFB5UUV5MmdzMjdhT2xQT0NGWWV1UGNjc3dxWUVX?=
 =?utf-8?B?Q2FDZ0h6VnJkZFlweUpmZDJ6VmlFUUVVSU14d1h1QklYQ1diZllTZEg2dWNs?=
 =?utf-8?B?MGJFb1d4ZkFiY2txNkpYMjdHTVdUWmhZR0NLUjdHZjVwVjV2VmpaRWR4aThC?=
 =?utf-8?B?UnF0ZkFYcG51QUFRQnlUUzVyM04vbTVrMlplY05sWkxYeGpKWlBEK2c0clly?=
 =?utf-8?B?SHY2NlpsVEZzS00vTDMxQURxV3hyV3NWL1E4M2s5ODRBZU5QVnNYK01vejJC?=
 =?utf-8?B?WkxVNDFtMDBBbDJPUytVVnA0WE55RVoyRnFKamp3V3FaUHJtTVRJcDQxUmdy?=
 =?utf-8?B?NGhNVDVWNTQvSDF2RjBtVUdHZXg3amxWekpwdjM5NUVLYXhhQ0ozdXFkd3Js?=
 =?utf-8?B?TWsxY3JmVzMwbGJ2a2RBT3M5bzhhWnlTZGxGVTVQZmFId1N3WHFpRTdhbUVI?=
 =?utf-8?B?d1RkUU5tLzJ3S3ZsTFBvUmFJM25vR1hiT0JEWmtJM0VwNzk5cmhqM0hKS0Vj?=
 =?utf-8?B?c3EyelIvNWdLVDNvY0RZSjdJMStHMFpEaDA3WklBRkFNdEdFYjZBOGl6M2h2?=
 =?utf-8?B?WFFKVVRQdWIwZ1N2R0M3RjNUdDEyV0hiS0I2SlRWSFE4bDJLVGRxMjZOWDRk?=
 =?utf-8?Q?3Bj+bqti3+uPlv64CtvYPz5SKKL+U5RRgKmX9IC?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860ac07d-af4c-4a8b-5724-08d961083386
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 22:50:10.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFSA8IVU+4O6t16KD6EBdJFAPQ9zMUf6U/GzmyFzQiKpH/rxtnYsyQDKOCw+CgvAmh+WjMVhpKA/Cz89cPDV8uy9SVmV4f8h0afLdXDpuH7pvVzx34KQOqcoml9HfxLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5017
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
X-Gm-Message-State: FJmnFsC9lZASWkff5B8ZQi4Cx4520388AA=
Content-Type: multipart/mixed; boundary="d1durhUjzbMpOIRI8box"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629154223;
 bh=IMCRF4Je7UVCkfPGKEMAG58jkpDbcIywfngpjbR2hXg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=B22mO4wRfer47WMYF6Mva3ldsFT7gXc4TqRp6aTNpqMD22JUZUMWbW0kiUxRcdUfWGe
 x159L5DFsvXD1EXWejbzdtHFowUrFsBLvqmYVeTRfSykRrLNFbeL7UqViVO4p8yTw+lc4
 GXJ3I+4NWDgkRa5qUbDWkQqkIfXIZR3dO0M=

--d1durhUjzbMpOIRI8box
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIENocmlzIFBhdGVyc29uDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxNywg
MjAyMSA1OjU4IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJq
ZWN0OiBSZTogW2NpcC1kZXZdIC1zdGFibGUtcmMgdGVzdHMgZmFpbGluZw0KPiANCj4gSGVsbG8s
DQo+IA0KPiA+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gPiBCZWhhbGYgT2YgQ2hyaXMgUGF0ZXJzb24gdmlh
IGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+IFNlbnQ6IDE2IEF1Z3VzdCAyMDIxIDIxOjM5DQo+
ID4NCj4gPiBIZWxsbywNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gPiBCdXQgSSBzdGlsbCBzZWUg
cHJvYmxlbXMgd2l0aCB4ODZfcWVtdS4uLiB0aGUgIjJoIHRpbWVvdXQiLg0KPiA+ID4NCj4gPiA+
IFFFTVUncyBxdWV1ZSBpcyBmdWxsLiBBbmQgUUVNVSBvZiBlYWNoIGxhYiBpcyBub3Qgd29ya2lu
ZyBhbmQgaXQgc2VlbXMNCj4gPiA+IHRoYXQgaXQgY2FuIG5vdCBiZSBwcm9jZXNzZWQgY29ycmVj
dGx5Lg0KPiA+DQo+ID4gQWxsIG9mIHRoZSBRRU1VIG1hY2hpbmVzIGhhdmUgc29tZWhvdyBnb3Qg
c3R1Y2sgaW4gdGhlICJyZXNlcnZlZCIgc3RhdGUuDQo+ID4gSSdtIHRyeWluZyB0byBmaXggaXQu
IFdpbGwgdXBkYXRlIHlvdSBhc2FwLg0KPiANCj4gSSd2ZSBnb3QgdGhlc2UgZGV2aWNlcyB1bi1z
dHVjayBub3cgYnkgZWRpdGluZyB0aGVpciBzdGF0ZSBpbiB0aGUgZGF0YWJhc2UgZGlyZWN0bHku
DQo+IEhvd2V2ZXIsIGluIHRoZSBwcm9jZXNzIG9mIGRlYnVnZ2luZyBJIHJlYm9vdGVkIHRoZSBM
QVZBIHNlcnZlciBpbnN0YW5jZSwgc28gd2UnbGwgbm93IG5lZWQgdG8gcmVib290IHRoZSB2YXJp
b3VzIGxhYnMsDQo+IHdoaWNoIGlzIGRlcGVuZGVudCBvbiB0aGUgbG9jYWwgYWRtaW5zLg0KPiBI
b3BlZnVsbHkgbm9ybWFsIHNlcnZpY2Ugd2lsbCBiZSByZXN1bWVkIHNvb24uDQoNClRoYW5rcyBm
b3IgeW91ciB3b3JrIQ0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMsIENocmlzDQo+IA0KPiA+DQo+ID4g
Q2hyaXMNCj4gPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==


--d1durhUjzbMpOIRI8box
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6682): https://lists.cip-project.org/g/cip-dev/message/=
6682
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--d1durhUjzbMpOIRI8box--
