Return-Path: <SRS0=nFUb=KB=lists.cip-project.org=bounce+64572+6432+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A0C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 00:59:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E2E611AD
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 00:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E2E611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6432+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Kbt7YY4521723xYOH3E0EGZ0; Wed, 05 May 2021 17:59:08 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web08.2565.1620262745445178148
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 17:59:07 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id GJ0431287A;
	Thu,  6 May 2021 09:52:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwJgdiOawWAlqzmojDQwziWVNQgf4QcMi4sIJPziXj/SZYLmHTF1LbAhuN9zup5ILmBXA1yVc/d1QMQl+O2AQqmEmylioSLUVFODX17331Hqe216SSc3zNqAkI9ylhgxK7h2E0mvcl6VCCxuW32zRH9FPpuK+LbuT1H2zbw3M7wj8B2dQRV6QGf0RrWyO8F13tK37L+L4S7icOU/LKvI0CVJlX5DnPozQd0UZ9LCmbwQ9HREARQ/PDU18TLaj6p31Hdvrs033RWUr8bW5h4OSxZM/RDvP0e6kmBsYSXtfI1TRC7Zru6dl/61g7BYfGJqZDCsFuEMpmh4i70YVHO5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGiH4+NUtgKH+pzipLJ/OdFaLlWg6am2n7EWIxcYhMU=;
 b=jFLfz60XDFJZV8+Tzc0EcdoE9GMwF24Nc/d0YmlGIuQRip+nHVzhjx/9ifR4xk3Y8+MkFal+j3wjfZpmRScMpct3mgrIBf8z/F/SBi1NGo3HxntC55rwdwqY9i/sL4fh9tXjJF+9B3GcBLjHf2tJ+uhhK885rlkFYwX2cVTLnVT+DenkpgNOFLeeMsFAQQAunxDmiu/2COQp6FYTJl5/b4PviCQujmBkyUk5fkYLAPYQIsczN3gGuP1SnlDOOSV+z17SGfgQ7LCzA3ap70u6WJ2f7Yx/iF559/c/PRk3KW4+idaL3W4OE32qzCymJQqyp8wDCNx6l3sGp1cgD4Hqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3146.jpnprd01.prod.outlook.com (2603:1096:404:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 00:52:28 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 00:52:28 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AddCEhDuTjdiaHYXQZmbQrPKo+hywA==
Date: Thu,  6 May 2021 09:59:00 +0900
Message-ID: 
 <TY2PR01MB4972DD4E37698F846628FF9BA0589@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baab542f-584a-4e5b-195a-08d91029392d
x-ms-traffictypediagnostic: TY2PR01MB3146:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3146BA47D36EB41DE9053A75A0589@TY2PR01MB3146.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 TJs9Ge/33IDTs0bsNcufQ7h9KsMOsw2d4d3YCk3xhfhj0K9w8x78gU4mHWgzTLIK8JvqKo4wZDgRRiL0L/Otiyr7ODtFyFG3Qqp5ZPccqk9FVuaPhBA1k0zKwXsFaBl41aXOJbn4BQz+iO81bDl2aDqjoXURxY88EveNYOEvT4hG8jIASvFqqeblBPhShaGGUAKeg3IbM9VWREJ0GcwMuY1jU+g2BAlMVy+k3ZORPZ7Th0hkcTBpo36vBMPTDIF3Mzv9v2VpQ/iUScRUNDbj6Fn3WrxyWHq/D7daavQW3AXrHI7dWDm6dug9Sw3vKfiBLunqFx8KWhI65IxVYwH4hDlq5DgKzzRkGKVOcCS5yEGgwHuiej7Xa4lcy/BChv/AxGRNMCGqt1fYzc8N1BOaCdidIeF3e+ECbW31TxHY6mlkv19OsUeSx601rY/+MIwQ4Ljyj+ldInSAy7sbPMfCVPKDufPhvcCN61aZd4TGCfv/Nz4xWhdKGEgYHjLEvJnlskKfJ3eoNwdsl5paJkneeTBHP+48g5/Nboelm8KVB9pJ0nzw4ELURtbOh8mq0g+tHFRG3E+n/qzysoL/QeFSrbBYA2UU+JzZvnhMPskxXccPUA4fZvSn3tN9Q951Ig7TObRXj9TMnAhqjGlEZXzGNal87nS2cjE6do/EwzzwiLoBdoxHrmAzVn0DyDNQ2GJg5d0jrJaiG+thwZR06UwDc0rt77XUJo+qmjuylKzV7ftbWINeeizkyZHBvQ5xXsTm
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?a1VpajlEcng4VWxQTHdvbk1YL3paaEtnOUwvSVc1V3JMek5BM0N3enBR?=
 =?iso-2022-jp?B?RUxVeW1OajV6L3hZc2xtZjBaVDE0SkFaZWpMRHRMVXMvUEVraUNBN2xT?=
 =?iso-2022-jp?B?ZCtsUzNydXh5ZGhzMG81QzYremlYUzVqRkp5UXE3UnBRNW1NSXMyQ3NH?=
 =?iso-2022-jp?B?aXZZcWJQUlpsaEoxbDJ2Wnd5T3FHOGZjelFxVTFSYzdqTHlJOFRLMEJ1?=
 =?iso-2022-jp?B?eVBsRCtUVmUrMkFmVW02K01lVVkrVGJtSGI1MFYzcnNKNFBsOTlHRDJ1?=
 =?iso-2022-jp?B?OFZBOWQ0M0NYNDRvdjJLYS9oaVh1SDE0N0d5N3RIdHIxWUx2cmp3TE9S?=
 =?iso-2022-jp?B?bW9Hd0lPckVUa2tlZFgyUnZvREdQODRoem1LU040WlNSdnU5MW9HNjVj?=
 =?iso-2022-jp?B?ZUpaMlRvUWl5U3g4dUM2WWxyQmgzT0psWlBkYmhCeWQvMHIyanpsamth?=
 =?iso-2022-jp?B?S2Q5emNhdVZqRm1MTjZQZ0szMHoyZzQ0dUpSTk11VUcvaHk4Y2xoSGFS?=
 =?iso-2022-jp?B?bU9ucGF0b2I0TjArYWZHN1FLb2w1cWxiMDRXazVkUTlJNElNY3owaUhI?=
 =?iso-2022-jp?B?WFMrMjRtTlJPdktSZi9LU0pYRXlWR1pMc2pRaW10TEdtVkgwVUszcWx3?=
 =?iso-2022-jp?B?eDhJdlFMbCtoRWR2dmsyYmhLMFhuM0JJSW5ycTR1VHNycXFOZ3VxWkNU?=
 =?iso-2022-jp?B?eDdUTEZ0K215dGlreUJCbWxLdzRidTh2NUFJQ3pYNS9DRCtUczY0aVZP?=
 =?iso-2022-jp?B?a0lCcm1DTW5CTzE1a01QQkRRT1pYZ3NDQW80Q3MxZ3lGUnR3V0pvQkxR?=
 =?iso-2022-jp?B?SkdLVjFOTGtYNUQ3Mkt1ZkdvdW1maE5RNDBIRFU5bWpQSFErbFZOc1N5?=
 =?iso-2022-jp?B?K0FaUVpmb2taYUdMWnIyeG0yK3p6SEhaV0VOdkRGOVJ3ZFUwMDRFVE5t?=
 =?iso-2022-jp?B?Q0krVWV6WTJOL2VLK3haazQ1UGhidGJSYzBTNG1UQWxJcFFUS092T3ls?=
 =?iso-2022-jp?B?QkhzdUZmZk1YL1VFVG5LakpBN0dqbUtENy9zajBER2dUZ0VGUWV0QWV5?=
 =?iso-2022-jp?B?ZThXVzdJbFNaZGVJN2oxTU8vc1ZYc3Q1cnJGRTNyUWFsdUZVd0RsZ0NL?=
 =?iso-2022-jp?B?Y0gzcTdRNGFBWHp3MXlzNHRic3BHZUhIdkFDQ0tSVmdqYVFYek0vTEhC?=
 =?iso-2022-jp?B?RHRQK2pZbnZFb21nRzhRdnpheTVwblFUSnRXRmZaZkVqczR4SXFCZWZB?=
 =?iso-2022-jp?B?R09jcTNmSjRKK1NnYVNnano1ckNsTkhxRHZ6eE9nOEErdHpkY1NuNk5o?=
 =?iso-2022-jp?B?empiZ0lENmIycnJ5U2RYUmpFd3ZXVloyYmZnckJaNVZHckpmVnNrTjh1?=
 =?iso-2022-jp?B?aUhVMVNLbm1rSFJ0Sy83YnFaa1Bzci9Wc01VT3NJN0NyRkJmSzhtNU5h?=
 =?iso-2022-jp?B?UFN3alNGWGRQL1dtaDJNMjRnenZuRUFDUmN3cktLazJxc2pyNllneDl1?=
 =?iso-2022-jp?B?N2JRRitRQ3pKVkNrd2lQazBtUFRRMmJLR2tOQjJNUXJMdFluS3lDTXJH?=
 =?iso-2022-jp?B?TVRLa2I5ZnFIZnBUemFLWnFWeTQ2cC94WTBTYlVLRnV1eWpmaWZqQTA2?=
 =?iso-2022-jp?B?ZDFrVUtCa0hIb1crVFZUZzFHUm4zYWprZk1MVG0rbWc2K2t0S0laWFpy?=
 =?iso-2022-jp?B?N1RobHBvN0hjSk9UVHpLSkVCU1Q3NjhiblpNbFdzUy9ONCtGK0wyWlBS?=
 =?iso-2022-jp?B?bkY1WTVybktWeU80QUo1ZnRpWHdKNnJCL1ZIRWFUYTJVOVVldnZTSzR5?=
 =?iso-2022-jp?B?K3UzSDNZYWdrOHZKMjZDTlptdUE0UWZMcVkvekJmNDdGY2dtTlFacWxH?=
 =?iso-2022-jp?B?Uml4OGY5WEl3QzBueXpoVzNUZzc4Q0tkaVR0aVUzZFk0a0lkSWZiWjlk?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baab542f-584a-4e5b-195a-08d91029392d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 00:52:28.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRQFxDRd6Lq5XOy2HtAoOB6ziiA1K5FWSh35C1vRtoSDD++tWhv13JCNfHDnLC7WJJh4rUWLDUOlvShE+Jmo2R6wAnONh9/gSPayGmzsdfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3146
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LchI0CDSrZTdwxYH0O1tYocyx4520388AA=
Content-Type: multipart/mixed; boundary="WxPAETNlH7AzpIyp2vC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620262748;
 bh=LrKpU9+m9Bzaq6t0pim5XRucOwt69Z/Qe3Bof27o0Tk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rkEXrxxfufxst4wB4/49wzcNgw1JVKByCof9Pu2kGNpfkCykjSnmk0DBoJcuHlShvpy
 pOznYO/4OtpSOaEO+3UxKsdt7i1ABlOn8K/jfV8yFdWpYHogERyVfRjDBo+uX1eZrbC+1
 N1Kh8/wJB4nn4D70wvo/P3VotKef4P5wZpw=

--WxPAETNlH7AzpIyp2vC5
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D5&day=3D6&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/04/cip.2021-04-22-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
  5. Update Testing table below with 5.10 info - patersonc
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/centalisedtesting/cioverview
  6. Ask the needs to backport CVE-2021-23133 [net/sctp: race in sctp_destr=
oy_sock] (4/22)


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

--WxPAETNlH7AzpIyp2vC5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6432): https://lists.cip-project.org/g/cip-dev/message=
/6432
Mute This Topic: https://lists.cip-project.org/mt/82620554/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WxPAETNlH7AzpIyp2vC5--
