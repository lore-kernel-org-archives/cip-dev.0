Return-Path: <SRS0=3FSm=NC=lists.cip-project.org=bounce+64572+6672+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06DEC4338F
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 23:31:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E429C60E97
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 23:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E429C60E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ySAWYY4521723xuliIsl22Lb; Wed, 11 Aug 2021 16:31:15 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web08.15365.1628724672420396490
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Aug 2021 16:31:14 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id MIY707182A;
	Thu, 12 Aug 2021 08:24:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBqhSjZBLEeGUZST13f6omfdu7yp127Yn+g2Pq33uAFOqJFtFyonF/LtKu9RdjX/4rRdcKlfiFDXYDUm2wl5QN7A679FlWoRelwE3Xj2XIhWWb12RLYGG229AMdoUiRjv6z62L2YHgW/wt4FKyPnKvZOk77ydF+Z4fv1H9U2Doy0FgBwDhi6p33Y/zt1YkV0BQwdIG+QIEfwIXPpZ+uXdVIt2Z41WQ+uCjw7tXqrNsP/qRoBnh7Fvu67oOHqxwAmPfmOh4nitcNLohBQTaAwp9nlXtQqj/SxKBfOjK69eCIyIhHeFrDL001a4mR8u5HA1y3Q0qpjmAlDPwLR/+iF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eewuhjpmNXHVDb6EWLu7dpaFMahO4H9/cI7QUKYNnyQ=;
 b=UiI/b6lHUQTi1Hd3eA2YZ9rVtYQGVqdEXVeSg7dH5OJaWsKWbEotkF+tU5MP0A9sfpKQ18d1Rn0mO0T3em2KL9vfvRktX4+OCdNTiYjy93u6CMa4I9M5f2X1OXIbtD0nRvYhDl92uNaWMtFIV5eAAVRm0Ro5HnkThUGuI7tQxiPmJXqQ9wZizZeBaaLlsbzHU6OxVG0drxAljLBpawU0WqV1Lu+dj/B35jKDFHa1CUZR8bA7S2pZzYPr30/Vrv1OCiD/3dAKedXXL+AGvJs9lK+IPU1NlZj2FkyaMZsCZzIYt/OvnAkHVqpDNCchdrWtbI4yuUfJSiYIhWmFoholcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3145.jpnprd01.prod.outlook.com (2603:1096:404:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 23:24:42 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4415.017; Wed, 11 Aug 2021
 23:24:42 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdePCAAelkdEykLMSk+eGkv6e88j1g==
Date: Thu, 12 Aug 2021 08:31:03 +0900
Message-ID: 
 <TY2PR01MB4972784FC7DC1168ADCE21C4A0F89@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 730494e4-28b9-4016-7b1a-08d95d1f32c5
x-ms-traffictypediagnostic: TY2PR01MB3145:
x-microsoft-antispam-prvs: 
 <TY2PR01MB31454447B72830F455BA432AA0F89@TY2PR01MB3145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 oNHC2x60IRy0r1R2FekymYEB85aw1gEEZ3U40cPDjTll7t2BzHQza6HDkAEFcA6ao4xjNVuM2W2maRPlhqblmOFRETGtiMKzmjPpYJ4y9+/Y8PXfERIVQBqrkafKq/8VsA0+FaS28LGLixHv4j3vr+TAsLzw7ZzjkmHekf8UiYpHH1oGHt0mhXqSfOWAnGWh6OR8ribl6ocIYTl+DXhAOHC6zy7bSzZja4M2DjWPhuKqodqDGwyTC22+pWPdTdJLQLR6AfDccX3QBAIHwmWIK6sMyxXjna7q8XAx+gQP0cxuG94E75ZXSy9+Im3koe5zcAn9jEQnNR9Kn5p9yvfUgA4RF/0TSYvOkjCIfR4FGBtCEdRRAM99EujBlP4uGAIXNAMnM+y9RNJHYgD/fRM6CRvA/mBpWcJzUb8EFGTSJJaoo0t0X252EK53BPZ6UqmCb0b1ohxgfsl3az6bv5WNEjDBIqJvq8kuL7n1xsoOcXsEKs4kfiZ6QO0ZpDehc3fslzJT6HiLE40HwSnS03FfHwv35fCFf/vRrCM+KabzWSOLKhcLxbskP2NNFtuIf68rQ8vS1W4YCKJlabx/wXwjbMivb4RENVnYos0buwX4tI7AQCgsF6GT782KwcHtTrWWOQCdluLTxhiA0qQ0mFZ5ux65B2CmzM0r/4i1FmFPr6DZNOChloc8JtP0HYdSUt/bxSU2NvXVvOs1H3BU3z8YKa3yl2YpiTEpoyZZcSXMZ6ATRWLSu4pKMNCC3QN/vsrxju3dtRq9xqnT7O46OqlBc0Bzvcobq4uGb4qX/RJigdHjszdn6Kz8dD7DRWvnPkYjUp/KkrctstIt5D7BShHMSBdIJWisUEx1OwIenTfmvcM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aW5kLytxVkp0eTdZaHMrVktWTDE1b2VmemJSVSsrTVppNVdGYWpaT3l4?=
 =?iso-2022-jp?B?ZUxacjhMamZMaG5MS0lrQ05peUE3TUk2VXBpWHJmbGwwVUo2K21FSlFn?=
 =?iso-2022-jp?B?bURzRVlSYzFsMVR4UWQrSTBIQ0dBcm9zTXFhdFVsZzJPL0tVZEJiamNu?=
 =?iso-2022-jp?B?ZXNzbW9pcWhadlJKUm05ZjlySTZ2a0VsYWptR1VHaG83U0ZlRzlvVWRm?=
 =?iso-2022-jp?B?NFdHK0kyWG9QVnVjYWpkeUZHZzdyZWQ5Z0NweDBEenJyc2k0NVFRRE9T?=
 =?iso-2022-jp?B?L3hNRElYUTlCaG56VStMb0RheklhbGxDaGZDUzltUktYUEh2SlZ3Nlhx?=
 =?iso-2022-jp?B?dC93SzFzYityMUZUNXptZlRrd0RDbUlLOWdNN3ZHNVlJUHpqQlY3YlI4?=
 =?iso-2022-jp?B?MDQyTlkxOUtjdzB5MDJqbnNOS3dONEVsdzNrMzdJMGZUQTZxNVZwMFEw?=
 =?iso-2022-jp?B?WTVpSEc2T09KRDdPTk0zOG9XYkJobk5IZmZqVFJTdnEyVVFxVVdZRWNv?=
 =?iso-2022-jp?B?U0hkd2JaVWNWbzlXOFA3UzY0RXk0Znp0QUFLSjdybXJZNzFMNE40Mk5z?=
 =?iso-2022-jp?B?a2lFbDRLc1lkbDh6bE1DLzYrRklUNkxyUktvQUdmam9EOFJjZEFIamVV?=
 =?iso-2022-jp?B?TWVPaGVHMXRnZWZVb0FLdzJPVGRKOWI2bDNETCtXRCtMSWZpSHlSNnFw?=
 =?iso-2022-jp?B?R2U2RHBBLzljMFdLYnM2YWlqUlNnMlM2M1FJMnExZmQ4em1CSjBSdW00?=
 =?iso-2022-jp?B?WFN1cDVSeU44Q243L3pUSlhEOGJ3MjkxWnIrUlNhMklEd0x1ZDBLVW1X?=
 =?iso-2022-jp?B?bzJnUHQ3bzFxNEM5NkgxMDB6OFBJTUFiM1lRNWN0RzZhalBjSzE5NHhV?=
 =?iso-2022-jp?B?bXNtNlcwZ0dVdUxhSEIwZ2VKd1dQMlF5b045ckZTejVtamdOc0FUR01z?=
 =?iso-2022-jp?B?Q2VZdHYzckFhZlNGWXFnMGpiNXdnaDJNd2M2N1JZZ0JRc0VYSmVkSlpW?=
 =?iso-2022-jp?B?T25KU0MxWVhWcTNnNGFKSGJMVXNxZEJiTjdQRW5lY3VPZUJia1VFUmlM?=
 =?iso-2022-jp?B?VVBuVGZoUWEyRWlOSk1nZEwwcUFSeWxSaVgxV3RhdHRDSXpKTmc3YTRy?=
 =?iso-2022-jp?B?VGFLS1E2ejhTZ25CRC95REFKRDVVM0sxS1hNalNBbFQ3TDRWRzhUQVpL?=
 =?iso-2022-jp?B?SFBRdVhsTkV5eUxON3RQYnl4QzVPc3EwWkk5ZGJPanlvQVJ1NHk5dlh6?=
 =?iso-2022-jp?B?TEN1ZndmTVppaHIzRlNhSUNScWJPZDdHN2UwL2ZncmRtSERFclNTaXFP?=
 =?iso-2022-jp?B?R2ptVlh0VjE0NWt3eTEvaG96Z2VENkFpSmJ3RTBjbDlIYzZRcnd1MW0r?=
 =?iso-2022-jp?B?RElXbnRaWFdqTEI4blpGbHk0VTJjU2JQMDhrd0k3cUFLTmNVTitocWpK?=
 =?iso-2022-jp?B?aHBya0k2REJYY1dReEg5T1NVb2VybDZCNTBxemMzVXROZ2RmaTVyU09i?=
 =?iso-2022-jp?B?QjVWTkxJZ3RWTjI0aEZKOTdncW5zbGo1cmVHZisrU0dFdTk3Q0N5TjVa?=
 =?iso-2022-jp?B?eVk3RmJNK2x2REovdkMrYkx0bHhKcXF5RzZGNFJhMEp5WXNYYkRrdGVB?=
 =?iso-2022-jp?B?U1AzVHJoMVJ1RFFkUXN4UkFlcHpJUmltWXBQbDc2TnJNKytTZGR5bzFP?=
 =?iso-2022-jp?B?d04rT241SkZyYlF1THRnU2NUemw3ZStMcW1pTHlHL2pqRHo0eE5QYU1Z?=
 =?iso-2022-jp?B?eFB4SXo2MGdHd3YyWGxWTTVIeHV1ZzMwN3NHQTdISW5tZXAwUnYvU2Zn?=
 =?iso-2022-jp?B?SGdGT2FuenRVYzFQRmV0QWo0WE5PWDVEYmozUTI1VUVEemd5M2lvYjB4?=
 =?iso-2022-jp?B?blNlSFI5WFBnVjR6akt5MzRvK0Q4YzM0aVp2RnlhUm9mVzRzUXVHNk5D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730494e4-28b9-4016-7b1a-08d95d1f32c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 23:24:42.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjO/92EG3s4PUXzcBkCYxd6cvi0ydyJp8Qd7pQyi3XkU42fqnNgNgBxNcii/I0eqPZZ0gOOM55mQMz2kEU3PlASd8QFn5DtMDGx+CtUzWdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3145
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: le6KwXNY1vMsa4p3QUBwOawpx4520388AA=
Content-Type: multipart/mixed; boundary="mB6mIQaCgTcuCiyIPtpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628724675;
 bh=T3bXQuunze3DJ9CsinZHLAOo1uuzy9EIRe4HZ0W4gKg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HsroL1lUIQF2SAYROvHHDjCQOM5d0eLYKhUDw8sjRetJsmSNfq7y1cc3x1KJRgGipeX
 5zABd1t/cGxCInjgUA+NY8LCVh54MjAa5UyDYg2uJylTksPH1eXq6HkiF+oZRntUBulCg
 UrKq9qE8oo0T5BLjXtnymicqGeBEK6Mo+Os=

--mB6mIQaCgTcuCiyIPtpf
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

Please note that we already moved from Freenode to libera.chat, and our cha=
nnel is the following:
	irc:irc.libera.chat:6667/cip

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D8&day=3D12&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-05-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--mB6mIQaCgTcuCiyIPtpf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6672): https://lists.cip-project.org/g/cip-dev/message/=
6672
Mute This Topic: https://lists.cip-project.org/mt/84829145/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mB6mIQaCgTcuCiyIPtpf--
