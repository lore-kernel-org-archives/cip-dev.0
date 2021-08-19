Return-Path: <SRS0=0Zzy=NK=lists.cip-project.org=bounce+64572+6695+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06CC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 01:00:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F352608FE
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 01:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F352608FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lTV0YY4521723xcvhMSkDmEO; Wed, 18 Aug 2021 18:00:34 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web08.63487.1629334831798826662
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Aug 2021 18:00:33 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id TJ3T22142A;
	Thu, 19 Aug 2021 09:55:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eglg/HF8QoviyAhhisNQ855KhIMe9zGDD4NpnAlLFIhIgqaapCMCzwj6QbV6zP2Cgpmb3fIZvtEWjNUar9wY0qX5aLQTFaxf9lYlQv8fLGAeJOBmz8nCpq7qdttLNa0yO4UY45DePODnvfo5mWPRHuCQgKvEymdKa1ysuBP3mMfPha6hT1304A7ifx4hUxWr5iZDozQmevsOkZtQPr4Lxt4uZ9jAmvgNQHLarHvaGiYLeuP0MbXsDanTScYHg3rdw7iC7c3/4A7CdNT6c26u5VTzhaUFoJK8kAsr3RexUWY36e1XU74EVJfIX1S1SZyIIHZXzAHGkTQKgdBQcG4DDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMNp+Zwt/K4YBZH2R8HVGQWdzGzENGhdqEEI4uro7ro=;
 b=FaQEkDZwty1wU5N7YLpSQLTB/CY6C7E7wu8Odk9Pwl+h2eFoNx9dUVYWTgk7/28L8C2Cx2t96Nu6o4sRSq+U3Zf0p3Yd+KmZt8gdhREB5QoitewagbC6T4HlYDSgzvJTfrY9yd+4Yv19nBC/X87iHakQNTsKDdyKMQmQirxz0IZnnSn3egDTnqRuPdLzt925v09iNYcyOLtL65M9dIYsop/PHuZtfkIEl9mX7FnChhnCdjVmDhIGVj64s7vE0BvEGutSodWI04X3vNA9qgjaoIc9MumyYiCbM6vd04lqLnSb7AAZSWWJ1L7gfM5SpEnOvD8ZA2T+gDzMKAf4q3ZZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB4413.jpnprd01.prod.outlook.com (2603:1096:404:12f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 00:55:16 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:55:16 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdeUlJcJzHRpEqm8Q+m+1o/dJuj3Ag==
Date: Thu, 19 Aug 2021 10:00:24 +0900
Message-ID: 
 <TY2PR01MB4972B0313A43F09AC6722AD7A0C09@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3cff49c-5986-4ad5-f8c8-08d962ac023c
x-ms-traffictypediagnostic: TYAPR01MB4413:
x-microsoft-antispam-prvs: 
 <TYAPR01MB44131245964D222D896239F9A0C09@TYAPR01MB4413.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 Xd/5KgiCrq0fQZ8VDQfqodVoDsTaqAjbTFb8MtMw/q9fWyZ6NMoODNZjCIREHyqIPoHtvHjBSIK0UlmKazZqmNBWuh1jz1X+dzIaU30gcUBzM+QPA1DBwVZ/ReYyIVWpApMrJ9E6R3SuBxzVoLK1TL4NF+lZShPFB29giSijFkfYkk7dubHUxqAYNBB5MEZ3i/MqxeW3HvvBZSS2mtF3dEAfmEbtTwYavI+KR1lGOZrWb9rG7bfxjrUiW5RNO8jBIO+utCKIiv8hwfnaKe5DaOtjy31iLYFK+qAH3lrDmceOD0vJTQCZnCNVofBYSy4yEM4rJt93Mp3wY3l/HdEUlT2SZD6nuI4tdQFW2iBA615R5BvXfAbNsDrAvhgt7JiDDcEZVk/sHMnsZHpiQ7kjBBa8veG3l8P0MGfSoYrS7NQJf/vQ+1tNaoEOBGJscxNmTb9+yDJukRjndyF5kZXJGlDScEBCYK4LpveFe93s5PQigeVeMVCp2vcaRb7gt6/TaCpBd6L5T3O++y4HIFQH2HVBE2jdYeM5mAJXOUshH+jbdglldYgbvBzeCygxRtVGBrGy5Ghz6+Vnzil2yy6n0PhoBVj1d410Q1ud9n8j3ICwY30b4wB9LwJSpGSmJ4c3Ra8W1W2+RiBZvdu9RuZFOQRKP25TvOz6DeoM/Wt3Xw4UAZDgkvGuFy2pMZ6qEyY4SKZ4Oiq0G0VC+f0cqWwOCURWbRtw7wgi711ZxcZY4kuebLe2I3/zcZZLaeSZaLdx1BE6YDzDROmcD2bXZuZOZJGsdEKqOdK31IpLaLyNrCaZIiUb4mJv1zk0aRNIxIgj24F3X8fUGvpRVsvfqYnP7w==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bzNEVUZBWEcwK1crNVR4UWJYeTNmSGw4V01IZ1hjMWFVbU8xd1Z3RHlu?=
 =?iso-2022-jp?B?VlVxQTlZbmVKS25pdE5qaHY4UDNKcHBBVEpZMnFWa0FQUHp1Vi81UGV6?=
 =?iso-2022-jp?B?RE1MNy9VRzJBQ1JIck9ZekhqVVdmRXhRMXVweXRoRFdKMTkwbWVFQ1ZC?=
 =?iso-2022-jp?B?WkxzVHU2a1NiVmJQQlVzeFJtRFIyK2JBVU1qZUdSRFZGV3ZIY0NBdmZE?=
 =?iso-2022-jp?B?MXNmQmwzZEw5RU1tcVNCd1FoYWF2SnVFdnpoaVZkS2xYU01ZNU83S3do?=
 =?iso-2022-jp?B?SFJVNjdjYXhzMFFxZ3JVVW5ya3FmOUJWLzNBd2w0VUVDNlh0dGRxSUtZ?=
 =?iso-2022-jp?B?NGQwNXpvV2pZSjkveklidHIyOWIxdU9seXBCcjhmZjd6TDBuSk5GeGpE?=
 =?iso-2022-jp?B?NFhSQXM4Qjc3bDI2dDlUQ2h1Um0wbXlnN2NBZFIyazgxZEZnWEEveEh2?=
 =?iso-2022-jp?B?djk4QmdwK2s4Nk1nN0hOODBxNkQxclViU1BYNUx1bVJVNjNsdnYzSlhp?=
 =?iso-2022-jp?B?Y2Q4YnRMbnNLbSs3b0dpejVzaUV1WG44d2ZGclpmVW94WmFaMG1oMm5z?=
 =?iso-2022-jp?B?cUJTNnZ4S0ViWWVyeTVNWjY5Rjl6OGVmeXNFWFhZeUhjVEErMmVuNFlR?=
 =?iso-2022-jp?B?Ry93RUYzZ3RRN0xZd2Zkc3pYdVBGQXpxb29ZZGxXcmQ3V0FGNWk4TFJm?=
 =?iso-2022-jp?B?L2hHZElyaGp5dm9WNldLR285TXBtVnZ3RVBRTFBSSzNUZDlqbmJOR1Fh?=
 =?iso-2022-jp?B?L3B6ZTRuS3RTcTd2dGttZW5hYXJkUjdvVEtORlpINkt2c2RmQkV4M05v?=
 =?iso-2022-jp?B?ZHZ1ZG5XNXBWdmduQmoyTkxyaUQ5UHR0bjJoSjdCZXpmYlZPdlg3Ymxt?=
 =?iso-2022-jp?B?czdmWmFCSmxRblJ4VGQ4elJHS0lJOUJpZm9YMUF1cFFWTTJsc3dYVXFB?=
 =?iso-2022-jp?B?WWdlK0k4alZvNnlISTZ5OWkwSG9rdjllTmdFK3VjK2F3QWh6a1FQS1N0?=
 =?iso-2022-jp?B?Mll1Y0o1TWF5Ry9TZS9FU3RjRklnNS9NYmFNK29OOVQ0NVJVdFIyMENY?=
 =?iso-2022-jp?B?NGd2R2t3MXRkR0tLcFVQcGtENk4zRG5JNnovNUxuaTg5QXJJTXZwN01Q?=
 =?iso-2022-jp?B?dDZjNnZpWnNLUjlkL29Wa0UycEhweGZxQngra2c2NHJ6ZDhGM082MXNV?=
 =?iso-2022-jp?B?bVh1bjdxV3p0UE1BbzVVV0hReU9IL3h5WnRYazVaRWhMdEFtTTJOQm93?=
 =?iso-2022-jp?B?S0h3OGtQekdLVktUN3ZoT25UOE5NOHJET3B2UWZwai9Tb3p6cTNFNE9R?=
 =?iso-2022-jp?B?WXFkR1hieUdaN0xheVF6Nkorc3ZTc1pqSXdFQTJ6b1dtQnpHUldEM2lx?=
 =?iso-2022-jp?B?QWQwaWRGSnpvVVR3eXczalJ0NjNXWWhRbHUrQ0ZTY2hGcG1JZ0lhazhr?=
 =?iso-2022-jp?B?am10QllhNDk2RU4zMmpsMjJ5RElXdzk1QVg5bzFtaGdwLytoY2RobTFN?=
 =?iso-2022-jp?B?UytpY1h1TGVOY0JXR1dGdWFTamdVVVFoSkc2dEVoTzhnRXZtLzV2ditV?=
 =?iso-2022-jp?B?MFRtWjlYaXY0ZjZYR0JCYjRYOVpVSy9nRmlxVHlFNzN0T3RSYXdZT1RT?=
 =?iso-2022-jp?B?aTBhNGFpNmhxUnkvaVZyUTJ1MWxGUEFzcUNuTEIvYkFJeUZXTzJHSEcr?=
 =?iso-2022-jp?B?d3ZlT25DQjJISzljSXUyeFFwbGV5bGlQMlV5WDYvdnRBRTFtQ0FBa21i?=
 =?iso-2022-jp?B?U2VMbDNGc1ptejROM0dqbUxlcXBwZ05ZWVdqOTgzS3E2ZUliL0l1WXY2?=
 =?iso-2022-jp?B?TG9ReDJpZ1VWZXA4R2Zsa1NBaEphNE9jbm9nbXV5a2VUWDlPL3RmQmFU?=
 =?iso-2022-jp?B?OS9LY2VvYWlCZkN1bDBLMnBObXNVYUVYSVBXZENZeGZUd0JHRTFuVWlG?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cff49c-5986-4ad5-f8c8-08d962ac023c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 00:55:16.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPBp9ljgNUiFr1JOThYmDj1viOywYPOPBFefO9krsf+kK3EdftupcbR0+5jo5oz3QEySXjrNz/z2xudFo7Z4OI80LbSetdbwhzpID8DOomY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4413
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6V4HZZcrFO4fpUDC3OIVLUzxx4520388AA=
Content-Type: multipart/mixed; boundary="KT4mz9HyoHLDdUNXQCCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629334834;
 bh=H0cGgwghizZ/2YS8fSID9/a6cQa0rEn/lEoZunFInkk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EcVqc7LjXZuZCyWpGCaBzc9dqEWNxMljffg9ZrNTMz7kh/TfQv2FReix5YdQeYHO4+0
 mDdiNXcX7rl6hxy6LZ2XkW5MtmuU41EBPWJlQql9ZH2EsHUqsDPXM77YMRs1HR7vke1vd
 rxM+Pln32FTQ7TIwwBKLM6ZmQcFvPjzqNBk=

--KT4mz9HyoHLDdUNXQCCa
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

There seems to be some confusion about the change of meeting slot.
And I admit that it was too sudden.
So, this week, I am going to host two meetings at UTC (GMT) 09:00 and UTC (=
GMT) 13:00 as follows:
  1)  UTC (GMT) 09:00
	USWest	USEast	UK	DE	TW	JP
	02:00	05:00	10:00	11:00	17:00	18:00
  2)  UTC (GMT) 13:00
	USWest	USEast	UK	DE	TW	JP
	06:00	09:00	14:00	15:00	21:00	22:00

Please join whichever convenient for you through the following channel:
	irc:irc.libera.chat:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/08/cip.2021-08-12-09.00.log.=
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

--KT4mz9HyoHLDdUNXQCCa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6695): https://lists.cip-project.org/g/cip-dev/message/=
6695
Mute This Topic: https://lists.cip-project.org/mt/84986980/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KT4mz9HyoHLDdUNXQCCa--
