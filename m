Return-Path: <SRS0=IaJc=GY=lists.cip-project.org=bounce+64572+6126+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C7C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:09:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906382395B
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906382395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6126+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uAQjYY4521723xQfW0yrCa7c; Thu, 21 Jan 2021 00:08:58 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.97])
 by mx.groups.io with SMTP id smtpd.web08.4166.1611216537701611551
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jan 2021 00:08:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKFg/dO2P4hJUz4ZiD9Gjxcy6uW5hNQPHqIo5BNRBXIE0RmnDGY9r1LPGYNjpbJyrXHm05TUqa2Ub7HEc4PCx/dIqh948eeKFVXWFILBkhUH3ap3FqZIoRR2CayjG6SdGykTlSqA0quLfe76Pc+aHnR5X7L6hbSEMi9W3Yb8QbAgP/3KiRePINUAgPxasEC06fqwgD3HjU/q2tJanzpYg9BLlhnJ/7T1P3y0hO367vdKKjI3GzUptBbY+sfkrU25DwEuQD8jVSEluKEWXUWaAIKv6zuHzdOsYWfhjtOxmulk0DSnBzWkYySB4WqD4cborGFISC6O7CUXScP33NxLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nXJZG4E7vqrelv+VvhkyMvGvOlBxdOJkhruFvDPers=;
 b=mNPuPIFLt5fP6o2LiUOLcMXyI6fxmVKL+JzpGdXEtez28NqWHr66q07Cb6s6sIn/DLaD8aO9XPSuZ9OEHFaDGEXHCbCcM+QBZqBCpDQ+IGe3rGehEMIzpMnWHTIvwo1WAwX+RdbP2Q+A1DNq1OVWzRZYW2bGcEW+NeJUkiWfJy4qcw5p+SohJax26LilMBoGpOar//KdilCkXDulw0uCoR8f2KV0mEJt/L7Vh9Pl31GEYmSmS+IophkDF28Wun5UuzH1dpkcK88B5YPl2UauqoNBg94dZTTkE/a4cBSzN3h2vR8OcgZFcLvq/oQv/AX8Z6voKwT5rC9iiTqNvsE35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OSAPR01MB2450.jpnprd01.prod.outlook.com (2603:1096:603:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 08:08:54 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::2d3b:7953:6e1d:5889]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::2d3b:7953:6e1d:5889%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 08:08:54 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adbvk9JVW1w2dVc9QxSCh5YNHy+VaAAOC6xg
Date: Thu, 21 Jan 2021 08:08:53 +0000
Message-ID: 
 <OSYPR01MB536661AD32FC8D2B76C5FA42DFA10@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497266C89234AEF0BB171F6FA0A10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB497266C89234AEF0BB171F6FA0A10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.44.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ae5ee2c-4980-4bc6-f250-08d8bde3cb61
x-ms-traffictypediagnostic: OSAPR01MB2450:
x-microsoft-antispam-prvs: 
 <OSAPR01MB24508574A62C20F4F525913EDFA10@OSAPR01MB2450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 dqbIxJOECvi+IKlq9zg9OU6nCG6gxCOoLfpJqlrYThar1g+OQ/hu7vrUhqRjHFMp/OV51omnz4UJb4wcqyP0KdzAKyvqMqGzuxbu/dti8cDowy8uVPOUNJmISnbdOQz0aGTTqZ/c/7pfOiytfMMKiZ2UwoFNGBbRBh8EIrJxM/jsBmsMncABIM35+HWjVSTSVr5vvFDVpb9dvOFbUSLRh8UfQ9QV/M/fsfxX7/ExlFplfJN8B5YeehF1tGEVV4mzRnJRPDghRNeCowuTOu7cafKVOyh5sBISl1egBg7oMVE7zvkgqlT5zdzsGaQpLmHeap9UCDfzgLSD9cmFZgajmBZRrlV3BZ4nOJWvL5gQgmeU7Vobgd7LfYx0ftG3O38+vhnGvGlBF+MqvjhfRO/lIE2wglSzAMFaKtjbzWB59xrYu3YLf5O+JNFinenjqSpDX0MUxk8DE2Drgu8YU3Su+yt4dlCG8zG+P3ri6XSpZWBmqymTlS3Af8AMNnzZdD391ketIonGCyOEcWHm77IWpg==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?0UlzfZeOWNnQlpAT0IKvSgcgUiin6nzR4LQArTtAqBDjUkeKnNJM+LQ3qrKh?=
 =?us-ascii?Q?nO0GPUdgcOExK5TqOA/GRiq4CTXxuV1AYva1ScrxzXajOWcA2L1NIjfzR4QP?=
 =?us-ascii?Q?0+5waz0kRpg1k+u7DI2vzz8FT1O53Mgi05dqp8T0Oig5yJIBjZl8TW4OhTed?=
 =?us-ascii?Q?4FNPrXkqEwQDvfvoFGUuO0vTLlkTzIafXJqQPqqLe44t0c6GdcxcvauyjsC5?=
 =?us-ascii?Q?a+LhQYecH+UfEpqRnEo0AfxG1ci2NzrZWen7v+yKsk9hZAqIWfXPPvpPmXps?=
 =?us-ascii?Q?gAEbJ7gXZJgiGYAZr9BPtjhdAE4rPHZJ8j9/S/jV6r0Gu96dfbOx6cow0Iz+?=
 =?us-ascii?Q?YjUvq5QYneTWa8ImDYXpjFbbUFZGVUvdBySZK9hjvF8CysQnC2cN5Xt5yoOl?=
 =?us-ascii?Q?7z3Qj44XBfMJDF4T8/6AahCxFufVDFp7jeyFOM12zh6tASzNwX91G6Eo9XyP?=
 =?us-ascii?Q?/SHKRYYxEDZO3pg+eoqI+t/NqGkiO5MW6nXeXx6yi6RFVehxF9NSIatT7IVh?=
 =?us-ascii?Q?bZ/uAMCfjDtc7F6l7D7Bmr4hwAnaEycVqVW9pRb16udW0/m/ZPVyEEoazPQF?=
 =?us-ascii?Q?mq6IR/brnkQKUj0hdpXE9NLJsJAzqjNC589B9CC68iTjViODTxqHSANoMjwP?=
 =?us-ascii?Q?dDqeqDap/85uYxGso32+hmvjeX7Z9xegDIKKBMDoTRlcNYzBePJ3ArYmRmg0?=
 =?us-ascii?Q?m7aeFzAdx9hrjDPhQpa78FUOVJkN35LJg+uB0BrYfhbU/Qj0iu8CN5hh8Bnu?=
 =?us-ascii?Q?Hv16eCVFTEmdjBVRzA9abL5/NGvSEOcMiWhF+npHAO7ywjWVXTTY0UUUvRFZ?=
 =?us-ascii?Q?8BzECEjz/Dj+2mXWxlVJrw0vywnObYaIDS1p5CSRLW/VkMg8+/cOAWbR4OB2?=
 =?us-ascii?Q?RN9qhr9WAK6/DIotFC/pRobQVPZAWc7dRlX5hCxWYaEiouI98Phql54T58P+?=
 =?us-ascii?Q?PCvDhgs65StqA2bYdJzQ0B/p2Qb9YciuRhlw1e4DZ80=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae5ee2c-4980-4bc6-f250-08d8bde3cb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 08:08:53.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFi9laTNVn0YnzPnPXlNPti6T04oAkX0cVid3eSOT76XMM5IeiyKrX0Q9VOC5k9vjqgsnXWFrho52HsQ9mQKkSsHv0XMLBauTJtPSt5UOAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2450
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JSSbXIe4p0gbrknMa69OJGZfx4520388AA=
Content-Type: multipart/mixed; boundary="vDGApleykmvR8HwGO82K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611216538;
 bh=D+J7EO/ManGVg+kske5DWiKBNvxuOSK0LWnG/bppVbc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YFsjC1Thm99PUC9+D+3w4D6CpxNG/7B+Da7gBwKze34r31xZnGzK3CqVh4H7CLZeZSY
 u/9xsZM2LC6YO1xGXls6tIqWhFtVazml8pQxICJafP/2geSQqSTIJgTL+WJwJcmtXMPaV
 +RcU4D+8mdYsXrka9MllP9DluEMgZC69xnM=

--vDGApleykmvR8HwGO82K
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

I'll be absent today due to conflict the schedule. There is no major update=
 from Security working group.=20
One thing, we plan to issue tickets about action lists to meet the certific=
ation requirements for development process on gitlab soon. Let's discuss to=
 handle those requirements.

Best regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, January 21, 2021 10:23 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ti=
mea
>nddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%26month%
>3D1%26day%3D21%26hour%3D9%26min%3D0%26sec%3D0%26p1%3D224%26
>p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;dat
>a=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7Cde6cc5d42aa34527690408
>d8bdab15a0%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637467
>889799190797%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
>oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DLYgU0hBf3lY
>tqrIVaknjNWpmEFgaRBKSmfieWNkpqTQ%3D&amp;reserved=3D0
>
>USWest	USEast	UK	DE	TW	JP
>01:00	04:00	9:00	10:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclog=
s.base
>rock.org%2Fmeetings%2Fcip%2F2021%2F01%2Fcip.2021-01-14-09.00.log.html&
>amp;data=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7Cde6cc5d42aa3452
>7690408d8bdab15a0%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7
>C637467889799190797%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
>DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D9V
>seWH8AHSx%2BcvLlUG9gke3EvY6e7bi%2FPNOUMMmnzQA%3D&amp;reserved=3D
>0
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Do some experiment to lower burdens on CI - patersonc
>  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] -
>Hitachi-team
>  4. Decide the timing to branch 5.10 to start CIP development - Kernel Te=
am
>
>* Kernel maintenance updates
>* Kernel testing
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.

--vDGApleykmvR8HwGO82K
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6126): https://lists.cip-project.org/g/cip-dev/message=
/6126
Mute This Topic: https://lists.cip-project.org/mt/79994083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vDGApleykmvR8HwGO82K--
