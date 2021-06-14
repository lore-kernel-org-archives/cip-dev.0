Return-Path: <SRS0=lxTf=LI=lists.cip-project.org=bounce+64572+6520+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575BC2B9F4
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 23:19:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE4161246
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 23:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE4161246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6520+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6T7sYY4521723xubAnqqeI2e; Mon, 14 Jun 2021 16:19:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.2285.1623712742575051136
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 16:19:04 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 15ENIppt025059; Tue, 15 Jun 2021 08:18:51 +0900
X-Iguazu-Qid: 34tMccFKPm0svx4CG4
X-Iguazu-QSIG: v=2; s=0; t=1623712731; q=34tMccFKPm0svx4CG4; m=fFehZTRPOg1UQiTiK7TNBvhHsgAl6SyNEd3sjpZsKCM=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 15ENIoTS013936
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Jun 2021 08:18:50 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 25F1E1000E2;
	Tue, 15 Jun 2021 08:18:50 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 15ENInfb010961;
	Tue, 15 Jun 2021 08:18:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh8MOYmy/cBEXo6TVCUy0KtZjpNnBBAhZ/dbA5S378f4/0ECsAn4ogS7fMH9N6tYaWswrQhybI5MzYSIHqJbt4hfGOXt6SLpCwPv1IDlOE//EWPtcxMq/KslfP5usrR1cQCq3rrGrLKpCYdHozBqdLf87BCBKkdzCF54/69ARp7g5dyAbXcMBmfoxT+Q/ruHLpCvZFFBQs8ySog1mdkWBmChUI9DUhNcE5qO/+TaJoyn7JBbRuInBN5JKpY8wu4ZpSUX9sBYSzwog19ohqDQaKJk1AoJ6UvuoXo/i/ZRiJfWJia+uwP9KZxqY47TCrRmrJeTdxVj/vzOQ7j9+Dwfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdrZxrLUa4OWYhr2ir1TrsciBf22bFAy4hKgHgfZ/zE=;
 b=Tagk76Dv1NPm03TKB5u+UnbWwqtY71YlwdNN17r6JrH2OaKDf7G0+qN6Dnmb6JCLnQmKIuQ1itSQJZzHrGi+MkcgeFv95vzUBRqbeS0qDhAxdaXYjSzyMWfm9EQ+vAy+GnDLBIhoL/unGw52YMrcjPHdjv5+ADlHXIzJo6DQtKxZI31kTELtQEjLFOO2CQNv16nLhvEUrthXP32EyfoXM3ChH7wGu3OeMl7bZoDGG/LPmPyhLqbR8AO5XIBoeQIeK7Laf4n2eqydcTfkiRDTD51i/3RB0PkDIXS6P1DkVMEC8SytBKh7qS4hC98nas57Ng9/iLNFB5JBeQQMYJFMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <pavel@denx.de>,
        <chris.paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.194-cip51 and v4.4.272-cip58
Thread-Topic: [ANNOUNCE] Release v4.19.194-cip51 and v4.4.272-cip58
Thread-Index: Addhc4aqkoj9VLhQT/GqEjRFbXpgww==
Date: Mon, 14 Jun 2021 23:18:47 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252C39CBE10D8037972149792319@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f23f2ff-d6e7-420c-c710-08d92f8ac35a
x-ms-traffictypediagnostic: TYAPR01MB4319:
x-microsoft-antispam-prvs: <TYAPR01MB4319861CD251D83D63A0F4CA92319@TYAPR01MB4319.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q0LhOiYVlI7R1MKHdB7L/eLemHvQDE1bjWgct4NduFWiT0SG4c4P8fdxRYgGg4TIwLoy7JlXIizNGi4BVHNp7xmhRa3OGYDVWcPlPbCBh3m06Utfcizzjzqwg/Uw0H10IDPNGlfhH4OfVaWX4eR3GL3nEhftpI/dISZrHikjDPmwnPqGu7M/j+dfSE3Wba+dKRNjVeJjAyK9OYkKaq2LZIhpYZp2EyRzn68kOtHMgPKbnJIZt7hXGB0ulE22btQZUjF11NmaJPlCF814+IZgAJf/WyAS47NWajtK28KJh2LgdBkL4dIYhBQfH3egic0TMjqbsz/EfAxif2s8WB8qCp/+90MkRYb3m15zjHiOGsK8lCw+CjUMQaVS9zNJ0FBJyGU1LbkNfPYhEv6EA/8xjRE0b+5KYajirEpMo0HXOR666x7grjGGhe3rdob/oXXEF7Crpga8Zm9wznigyg/iLsTWbJj/K6qbT078qr+RAIZ51qpNM+LJ19upHZcftzZq1xkNSaLKF6y4jO7zaTqcbvbfyddY+zTMwMQOz07FXuNm4FB1GXBm8nABMUg3/YosHairZU9lKblMnpUuab3M83CiYbgbyfQjaupCvtqmmzfl23x8hhH7dRGlmbf1wqjt3y3iJ2lfvVn9KPY8wTcvzIBKwacmI9RLo7U/S80bPlsq6leZJPj6YKcJ58oAzg8G8F/JgTy2CuNW6WO6HN4Mmw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWNQRU9BM1FlYmVObms0OGxSZVJWYitCMnZDcUNYZGI3cHNhTFU5ZGZZOFI4?=
 =?utf-8?B?d2d5YytqNFF0aU1EaDB1T1ArQjhtbWpoRXN0N25iV2ZjZ2RhaHJZMEsxREl0?=
 =?utf-8?B?cXdnR0RzSmgyTjBqaS9iVWkxb0NCMDA1cFFwdW0yR0JmRHBTbXkzTFBzaHNT?=
 =?utf-8?B?dzg5c0tVNThKWVZNRHFvdmFpWWlEL3dVdTJyVTFhRE9Fb2JsMUZyNDdkS2Jy?=
 =?utf-8?B?Nlo2UGc5UDNlNkVHNklXN01YcTlYSFBPN3BON3diaEtaUUl1eHZDY2UrVDYx?=
 =?utf-8?B?Yklnell4U25uRlRxalRaemlwODZvcFkrWk1kZkgrdDdSS2hFcXd4b09HQjRF?=
 =?utf-8?B?WUI1SFRTMGMrUStVWFVHSkFxYzNOZkQ0eDAraW5qdTBCckRldWtFdjRtbjE2?=
 =?utf-8?B?bnczR24xajFYUG4vOHVDRGRtSmZFRVozcXVTcVVYQWpkN09tdnltcHV6N3p2?=
 =?utf-8?B?akxiaXZGRUE1SHFmK2RwNVUvdzhLUi9BMjhiaWVydEw2Wmx3dUt5RGlFRVFv?=
 =?utf-8?B?aTRZNjdxcnQ5U0NhR2YySzVKRG92MkdWejF0WlZUc2pybzRScWk2dGQrQUlG?=
 =?utf-8?B?RkdvZkhGV3pTbkxwTnJWV0s5VVM3Zkk5QzJyUjZ1WWw2ZjdIdmlITDIxMHM0?=
 =?utf-8?B?cG8zd3JDWFBmVFRmNWdhd1JBMjJza1BsbWl0Rmp6dFAzVytZZEJKZVhhalN1?=
 =?utf-8?B?bWNBTFArYWpwOW5iMi85eGNCeHAzaGR6RlVGSmVRZm92UkM5UDM0aGpKQkt1?=
 =?utf-8?B?QUQ2OFIvcDFUUXVuMTIrcDAzbnByNkJlU1hVNVZ5WVVLSDZ1Nk1pYm02VDRz?=
 =?utf-8?B?ZkJsSitoMDNwOTRyakIydGZRVW0zbUJUN2wwMWt3VGpZVUhsYUN4K042SjJo?=
 =?utf-8?B?RmV6Z1dMdDFBRktUY004L2NCYU8wSktQMTVJbXpBOVBRM1ZaYzFYM3RmdVlY?=
 =?utf-8?B?S0tqRytlMllOcUJDbm1LOU1mOC9PUFdMWlhUaDg4dVdMNWsyOWpPaFBCSy96?=
 =?utf-8?B?TU1iTFM2Mm1TazEwRTZZL0cxcG5vZ1hGbzRIQ1JjSFVLOGxDWGlkb1JSRmJq?=
 =?utf-8?B?Q3JSRDNtcEdoRDVBK2p4ZkFyTHRnODYrOU9XUndpWkVid1FDNjBHNVI4MVhH?=
 =?utf-8?B?YzhOaDZTZ3NZTlBnYkZpVVM3WE8ydTBKKzhLUE5BNUVzZVBYRzUzVlBSR3Uw?=
 =?utf-8?B?bTBpdlFTZFkvM1ZvTnpPQi8yQWhab0trLzlyQmNVOFRDcTUwbUNRWDdKand2?=
 =?utf-8?B?WXhZMW5xN3dJbXN2OU9YUTZjSXlXajlaZ3kraEhxbDlrNGVzNXFqU2NSU2FK?=
 =?utf-8?B?OGJEUVdNbnVFSkxmZCtoZ1hZNzlsZ3NIdXk4dnFPRkIxdnhNcHd0b0cycVRm?=
 =?utf-8?B?Vk9tU2RvQUZRcUQzaWIwc2luSUF6UE9kbjNqUm5qdVBtZlIreHNIeERFOFRp?=
 =?utf-8?B?M0tYdm9adkR1eHhtZnRpeGg3NURDbnRvTXBjSlpVSmNDZzNQSUMxNzFJeE84?=
 =?utf-8?B?Z1lOelJzUEVwcS92VTJGWllXZDU2M3hUS1NjbENlbjNTS041VG9LZ1lqWU4v?=
 =?utf-8?B?QjRMek1USC85WkdmL2o4Wk1QS2xJbmxUcHF4WWtPeHJXUmlGeWRsdnB2bm1Q?=
 =?utf-8?B?ZEZUVDNLa3N3RDl1YzNSNzhIT3hoeVlXaGVNZm5JSWgwZlVYWmNSTndVZDB3?=
 =?utf-8?B?RUFVZXZnK2w4bkE0UXJmMDl6b3k2VHFCL0M2T2xNZ1JPdHhhQWVrUmVvTE9t?=
 =?utf-8?Q?df5q7/zIIq/yaHe3a0=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f23f2ff-d6e7-420c-c710-08d92f8ac35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 23:18:47.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVDqEZK5N6n6BtIApneU9sJWY0pbVYgIoat53MVC5xV8+zqXnM+GYmMQB4S0aQf3mLP/EqRu1oZCdBHmorUTQeTsHBWK8nOyeCkxnyp/exPjEt24p3eapSDls5nxgD2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4319
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
X-Gm-Message-State: WSPnJACBbSBs9Wdntao44IXSx4520388AA=
Content-Type: multipart/mixed; boundary="CRMWSmgpLUO0VUuEBr4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623712745;
 bh=M08ierqMmnKMmX1QGHN8eaKNk++IdZrsuLAVxK4viEM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wRkwtcJFizo6BBHQgquoQqMkuVWJSbviwJLR9WjJUm/oj5rXKJxIiFBkZhnw605d7sG
 PCC9OU9118FlSq8o6uXE76GP7kf+9jRX9WgEGnaU0/xLVLyeWqNdh4A83JV6XiLiOjkbG
 kV45DFa/bPGKhawu9EDnYMVU2s0wb5E3eqM=

--CRMWSmgpLUO0VUuEBr4I
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE5
NC1jaXA1MSBhbmQgdjQuNC4yNzItY2lwNTguDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTkyIHRvIHY0LjE5LjE5NCwN
CmFuZCB0aGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbSB2NC40LjI2OCB0byB2NC40LjI3Mi4NCg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNl
IHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTk0LWNpcDUxOg0KICAgIHJlcG9zaXRv
cnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXAN
CiAgICBjb21taXQgaGFzaDoNCiAgICAgIDc5OTg1NWFmY2U5N2JkYmFiNDlmMWY0ZmViYTUyMzM1
ZGY3ZGFkOGYNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3Vm
Zml4IHRvIC1jaXA1MSBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQogIHY0LjQuMjcyLWNpcDU4
Og0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxp
bnV4LTQuNC55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgOTFhOGU5NjYwM2Q1M2MxOWIx
MTIzODg2MDIwNjY5NzhjNDJjZGM5Nw0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1
bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDU4IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJl
c3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQoNCg==

--CRMWSmgpLUO0VUuEBr4I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6520): https://lists.cip-project.org/g/cip-dev/message=
/6520
Mute This Topic: https://lists.cip-project.org/mt/83544444/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CRMWSmgpLUO0VUuEBr4I--
