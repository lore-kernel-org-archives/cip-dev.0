Return-Path: <SRS0=IpSo=LD=lists.cip-project.org=bounce+64572+6499+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF7C48BCD
	for <cip-dev@archiver.kernel.org>; Wed,  9 Jun 2021 23:58:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE12613CB
	for <cip-dev@archiver.kernel.org>; Wed,  9 Jun 2021 23:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE12613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6499+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TXLiYY4521723xLx6l9ypKt9; Wed, 09 Jun 2021 16:58:51 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web10.3369.1623283128421615841
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Jun 2021 16:58:50 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id KI1M17351A;
	Thu, 10 Jun 2021 08:53:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNT9sIvtiTom3rHvOcmPlYfhvvwzK/yfrERBAR72JKZonqFogdTNs9aXdnYk2iZUyfHqFNysS0qrZVbp6TowbZEKLXE0QSzVuXSv1Kiwkakd+GNzIxx851yVLxeA7wRixB48/y3KP4KqdgRMkj5NB2A3BY9hQQoMjFI659N5ZX0zI8VTXod2m+mvUZ7tHEwb3Uar8/CDfj668aYorgAdzk8Xn8L31lPGAoaxzaHUwXqyVjbfq8f7lCKBC8eTjBiRJ7HKMKaTzqKkXBlGuw8UlFGA76Q4zVZUnACgzrhY6BYHp+IQZtNF9VMEnLBR4vEXcVWwioHI3vs9EJj/7mIhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=walrWx4nETvvx3FU7CbPkxS5Goqa48RIaN5Nc1w00Pw=;
 b=D2OV0IT7RT7063hEJh+Cr95tDIYRhTmyjqItZsXEdgPVtIoM/7BfVXRAo1Axhu/HuIaZMHLh0fF+gN8yyGR7ezy5dTEDY+gu1hReDE1FyZXNtMHv7/SsRoM/3mXNcxcIguGsA2RanKVAMgHSIeRLA/jFKoAQB9J8lWs55OvxV8JMkb5+jCyxT0bBlXDQ828umIcPd31cbLVPAthedpF8wmhnQS+P4lE4SOvEOb5ia4GO+/rfzxeDWVH55kGcHt7p7ZLXaTEBFwcVcGzEENghMJG5RFa/TNOcUP280lkJ9ZhNppFJbxQTCmN0UNc8gnmVkZQx64eHFFVEJnzicNbsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYYPR01MB6748.jpnprd01.prod.outlook.com (2603:1096:400:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 23:53:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4219.022; Wed, 9 Jun 2021
 23:53:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today (libera.chat)
Thread-Topic: CIP IRC weekly meeting today (libera.chat)
Thread-Index: AdddioHGJKjwY+RqREeDzyWvLrYGPA==
Date: Thu, 10 Jun 2021 08:58:43 +0900
Message-ID: 
 <TY2PR01MB49721C32D2CAC601E0AEE2C2A0369@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b83a0373-30c2-4034-0e1b-08d92ba1bc64
x-ms-traffictypediagnostic: TYYPR01MB6748:
x-microsoft-antispam-prvs: 
 <TYYPR01MB67487BECC138FAE9FFCA4F15A0369@TYYPR01MB6748.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NKJXIzYzYE/mFO2p0SliG1qd1YcHQklBW+cKHuJ0aC3HkSklUAZv9JxUsBw33x+DEEaKl2eb01zwwbFRbYG6V026NhSL25mRyaqAhkq9TDCY0n2nsza22T1yiTtA4lXMIrrdy9m1LxAZuYT0HMekhkN2PNI1UmyQz1ZFfBJVHUMWzDluFpY+y5CHHCiQqUCnSjjNUzZ5WNn8oQqLTZ39HLQ4v5CSBhCvERXhAVyPX/gyA2UYlvvVez8b1qg9dGsb9nrTB/5l8Mek9evWuTtJb6EV9joXAYgryWgVvY4A0MgDCyJwTSsZ0J/mXRsiQ4mqejRHJIVSbxz90vk7134BQWYJd7PLi/qiGg9Xq9JC6hcXEbPJOn+Hv677EKugGM/Xl/Raq984elhAwN47sgVEkL0Co3ZbpnAqUGCnF0Av/KCfWcAThtft1r/cKfX76EV9bldKzt6bJ5HFLQXVsduc2lE92xMPXQdDvPkR6SRrq9Lx4rhDu4hEKO0+65RVTN4r7gRZzdTdNZScJmkeeIkrtQeUlLUdOL0D05bIjxltJwKdpWdDkAxrsPoDhN6B5E82x7269k8NeIjkFN4MNRRkzDui/Qxwfs1cV3JX/v32q7RQrlZnaOtYN2AU4uysWOx++eY0OcvnGpsZTyhuKUqhFCx+36gNU+qtVwLATIg3yA0+Q28gTzRwAKSH7uMIXWlebKKQt9lhJ9iRDR5q9nuD3SdAKt218ixhlV4g8757O7+h3aX6bFCMab/KZcuI9mrTXoJHZXHHVUMT5t70x4QPFwMaLoj9/A1oBi6qvQZkVHc4o4EnLqzUbOgOMutB8lXC
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?N1J4UXNHT01UTUhXZHVNc1VzaFg5QTVobDM1QWFHZDM5NUJaT2s0S2Z5?=
 =?iso-2022-jp?B?aDRkNHVyRHRPVTBLL2pqQlZ2VHVocktmQ0hKcXR1bFVGQldXQU5CQnlO?=
 =?iso-2022-jp?B?TG5aZ1lSL3BNRW5xNmhvbnZldUdXZU5QZDZsMnpRUW1YR2xUWjJGUTBh?=
 =?iso-2022-jp?B?TjY2TVFXVEc5VzMvc2FFNE0reStDVzNhWDl5OTdvcFRkK0ZzRS9FdjRU?=
 =?iso-2022-jp?B?WjFHNTlUdUhYMktmblFJRGd5ZTRUN0IyZjVDUmRWa2piQmpRREp4Qk9z?=
 =?iso-2022-jp?B?Q3k0Z1RWelhUc1JvYVBVa01udGpQb2dCRVBHMERSeHB1WkMrRXJBQ2Z0?=
 =?iso-2022-jp?B?aE91aUo5QUt2M0FMekZRQ2VlWDhXamRUU0ZibGFaK0ZCb0FZSWMxbFZO?=
 =?iso-2022-jp?B?ejNUVnMyazJwdkFHY0hDc3JRZHpnOWZqdkxGbERrWHBvVlJjeS9DNzdM?=
 =?iso-2022-jp?B?TE9wYmZGSDliSnhVOC9mVXFpbkxxWTVyemJmRnhTTXg0MUJ4UTM0V1Bq?=
 =?iso-2022-jp?B?S1ZJQWw3eWp0a1F1SnZmVlhrSkNEV3FCREZvR01Cd3RwWTNBWWhncFQw?=
 =?iso-2022-jp?B?V0o0NzV4dEJGRTVWdUdoaThDclZocGczeUtObExKWjlzV3NHZXJDakcz?=
 =?iso-2022-jp?B?L2pSck5qa2dBYUlPWVFiSWZRTW94SDB2TzFqbzlnYWpCTFI1NWRRakhE?=
 =?iso-2022-jp?B?czUzNzlVZUFFTXkyRUIxWE5jSkYxY0dWaCtraS9yMG9yTkhlS0tlc3Aw?=
 =?iso-2022-jp?B?clBxeUlOMmNNVERlaXlRaGtNdUxnK2lXRUwrUjVsSnQrSUkvSG5UazlM?=
 =?iso-2022-jp?B?eWR0d0ZITUJjZGRzOHg1OUdpVW81Skp5Mm9rcTZFdUlIVEdsQzdEZEVw?=
 =?iso-2022-jp?B?Yll0SFUwZ3l6akJweWd4bm5wYzdXZ05xZnVxT3l1Mm90L3JIbitjZmxt?=
 =?iso-2022-jp?B?RC9mMC92bWwvcWp4S05kNGJrRGFaU3lwTHdzdzkzVzZsT0NOaWU5MmxD?=
 =?iso-2022-jp?B?elplWStzSGxtQm5sWUhTcTZmZWZrQ3c3elV5Z0VSL2wydzkyQm5mTk5s?=
 =?iso-2022-jp?B?emlTaWRDeWE5dkJxS0JaM1haUkdCWk8xbTl4UzlzdnFqT0s1SFlURGMw?=
 =?iso-2022-jp?B?VUErd1BMZzVmd285Yjk0YVdpNTZLRzRTY0ExQm1aUW1RREhJeXNWN3py?=
 =?iso-2022-jp?B?TG95enZTUTFIaHhtdlZZZjZ6RGRUeFJmYlRzNUt3VzRzV0JQWGFubDlT?=
 =?iso-2022-jp?B?b0hJdTNoT01meUE2UmRqbk1MSit1SHYzVEo0Z2pkOHBXK0xrdnJUc0hX?=
 =?iso-2022-jp?B?cFl5a25nZWRYNDdEZ3FWd0xCYmF0Zk9YMElrRHdZQTdNNi8xWmt4YjNu?=
 =?iso-2022-jp?B?aEhHTC8rLytoQ3AyR3dzcFVzNVVzOFAwL1k5b0RQWlY3UFptZVd1Z3N6?=
 =?iso-2022-jp?B?R3BEd3g0UTlFWS9lNmUxV1hmUjRuT0pjUzAvaXZVN2RVUkEzZW0wZVRm?=
 =?iso-2022-jp?B?R3NkVTc1UTV5R2ZJWFoyK1J5VUcyN0VTSmRjSit2Y1dXMGxucXdXcmU5?=
 =?iso-2022-jp?B?Y2xsMTZIa0NvVml5VTlPdDljY05US1VUMVZqek52dStra0tneWs3OG5E?=
 =?iso-2022-jp?B?RTltaHBhYktuZTBYY3FqWHFiSDB1Zk9KRGZnTTN3MWhJQ1NuVXl3S0ZD?=
 =?iso-2022-jp?B?UWdJK0RZMklZSytCN3UvYUZoUk1qYTExamMyM0hLOWxUTnlFVzNrc3Fn?=
 =?iso-2022-jp?B?YytuMndPemJ4K2N6WnJTK3IzZVFPcDBadHF4cGpkNVREclc1RG5FYk51?=
 =?iso-2022-jp?B?eHIrdFlnQ1g2QUkvekkvM2tIT0VXTUJYUkhWdlhLYXUrekZjR2EzMUt4?=
 =?iso-2022-jp?B?MGkzTGlTOUVGQ0pZT2N6UlZndWpobWRQNysxZTBVWitlTlk0ZlpML3hx?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83a0373-30c2-4034-0e1b-08d92ba1bc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 23:53:09.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGQgbGCjv2S2iaONVR661Pay6i6XNiRaf1Nbe4Rhyt42qgnkstkTHEz3Cf4WqAym3u/pzesMPNeCq0wcogJgAT8BbMHIYhlXUp7+ks4ZAkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6748
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7uhLhb0qfeH20cKhBw8sDIWLx4520388AA=
Content-Type: multipart/mixed; boundary="U3HVxqcixV4mCLJdREH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623283131;
 bh=plN9VylepLRAjasfmmY0BMhrwA4OL+bgUChzQA95hyw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=roiCWFfmMRfIqz1kNQnADZm8WfZ7Z1xzAj09b+EvEz63KkTvi+ynyLIQ51u1x+Hy+Wk
 oc/P0Nz5oNK1hiCsGcXoOWGuO8Irtjo8b8SFNB0/vrumJG6PgJGAr5b6brl8nR1AhFWn2
 +6QCSXYsHIqG1XzTzJMOZ8rbPmNhybG+wl0=

--U3HVxqcixV4mCLJdREH4
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
h=3D6&day=3D10&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/06/cip.2021-06-03-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Update Testing table below with 5.10 info - patersonc
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cen=
talisedtesting/cioverview


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

--U3HVxqcixV4mCLJdREH4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6499): https://lists.cip-project.org/g/cip-dev/message=
/6499
Mute This Topic: https://lists.cip-project.org/mt/83434074/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--U3HVxqcixV4mCLJdREH4--
