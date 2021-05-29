Return-Path: <SRS0=s0GI=KY=lists.cip-project.org=bounce+64572+6480+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5AFC4708C
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 00:18:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE793613B6
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 00:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE793613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6480+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PSpKYY4521723xdOwMBblkuS; Fri, 28 May 2021 17:18:24 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web08.15999.1622247501560533597
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 May 2021 17:18:23 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id dJNO19743A;
	Sat, 29 May 2021 09:13:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/kG5mYIRIkMgIIccKmzc4hvxYQe7I/7n+gCS0ZDSqNXZLM25dAzm2KKVN0blTAJXJ3V/R3ztlDAShUI9CswdPa1ctN4rkgJLvoeoX7pP3n7AJOfYdAOO7C9lWbB2RlQdMc1hnD0Y6FK8P5qnP6P3u9mjpgEXDnr7jkTDEySvZtxml4isGb2sLBJAcijuGHEtRNaxmdfuYLqig/RQjnpA1Ene7h++tEnuhHd+fH2dL7HD06avULW++QELn8dveJs+d24zUmcN4T1q9s9fUkJoIugd7sAVWZDk6JCgRwStwPqK0Kly/pYa+OfH33egXiQkoC/xDxE2YkEmnihlSPhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnlpWBjeriitrYXr33+CMNTvnLUiqAlz4GeqWYgjvF8=;
 b=iul0GvhDlEbFZB1/b0k9pIZAfXhjOAVcqqvuH18WU/XSSP8uKxGTt3OkYW+7Pst7Qhn7+Z5rG/3azkXlROY1ffV4MxROJqYN5p0M2v6YHuJD39oN12piAy7rZkZfcAGXPKCXjAOeFY9+22A0TXUTfGXnAwow+3hKaWo26ALSilhOUYN0MoSUvVSJc8QCDm2rSXKKaC5axQs6wAD33475hbJwu90i9jvwL+9d6xvBx4DfEeL/PcxZJZIXsdjLEtzcwr+WN6GefD0BV45uMQEw1R72CpaawTDFaihDjZpcdeRfgXFAQqdr6wX+0QhbRQzxsWCLkyTKPsfF1gZtMzZu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB6521.jpnprd01.prod.outlook.com (2603:1096:400:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sat, 29 May
 2021 00:13:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4173.027; Sat, 29 May 2021
 00:13:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] IRC meeting will move from Freenode to Libera.chat
Thread-Topic: IRC meeting will move from Freenode to Libera.chat
Thread-Index: AddUH2du2ux4534KSeODCEfiheGgig==
Date: Sat, 29 May 2021 09:18:15 +0900
Message-ID: 
 <TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41c16170-5e99-4881-5dd0-08d922368acd
x-ms-traffictypediagnostic: TYAPR01MB6521:
x-microsoft-antispam-prvs: 
 <TYAPR01MB6521D5DF3D75594540FAAA4DA0219@TYAPR01MB6521.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 v88MH7+IDk2txzAv05KPegBOQXIeAfY5DUI6i4klmAJ3vzwNZ3mdRx2ehCgFKh8ZysXqinBsAZpKdhWlQkzoOaxXHyJDN9qSw3tulpmUGZCOxexvfEdLO1LzOV+WMrEi/bwrYZqPkEDSErz4bbTiXQT4kwNUTdEgl8BZROQrx39FoPy/58uHjYnrYKs9naR7not7iiJ2Lsyzi00DjKYFD+6QvJP9jPVeWYeVKrPTI9hN5SFq7Qq0vtUM6co0MQJwhMboStpOLk+0OpPmaIgNUm5IYOMDUhyVHsgaokp5ob8hJdqFxIUpZOOTuVaR4yr5quzAp2bE9pgCm3+9piN/bWbzw7cUw4TSgiHosq2Ya+jiYEsYPYy57Mo8oz/8gQJhdBFzVN8iJnJyfA1khbEdXQ+HbbwJcdYBGrvD4FPuf8pGden2pV8oGJpUaLgyj8XpP3XcsT0XJ+z/2b3BEUMM+q+t5GYVk1E4899JrzHHe3SXUkBkRWnXWxVnT9W82oV40Ww40LesirQEMvaO2ALRlIFlhE1hsBA5brODKtCguVqCV7uqUpZfbZ60CDFcvl/vEBnBgjYjcPTR7lurUPU9VwJUZOcWu85fZZn8T1DZkZQkRVdA7eQ9GmqZ+y8ieOloJnHXnnJgTPG1/5sjyCqQVhhmU/3e5JjU+BR1OPGLm24=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?L1hXVWFCVS96RitrVHphaWFkN3Jtc3JxbkpLSFdDOE1vMnpKcVN2ZS9N?=
 =?iso-2022-jp?B?OTM0SlBCODV6YnpPNHJhLzVFaEFSM243Y2hPaHZXRy93djUyTld6bWti?=
 =?iso-2022-jp?B?NEFxTXU3TFZranQ1RXdDQWdkQTR0L1Z1UmpnbjBjVDhNNXphcFhwVWVS?=
 =?iso-2022-jp?B?eHVTM2U3Z1NLQlpVQkYwZExFa2tzaDR2T1J5UDhiVnlwSEtZZ3F6Mlhw?=
 =?iso-2022-jp?B?ai9GdXBLS0hCNXFVakxZUGpRVjg5ZFYxbWpvaHdYdjc5a0lUb05DaFlh?=
 =?iso-2022-jp?B?Y2NQMkw2Q20yNENWblNsdG9GM1V1aGVaQmZKSU5pdXZVdVNqVzJBUVJ3?=
 =?iso-2022-jp?B?aEk0NXE4WWw3REFCeXJKSXpKajA3QlEzbmdyN0ZobmM5Kyt2bFJzY3pr?=
 =?iso-2022-jp?B?Qk5QdDJJVWE1YU8za1U1V1d4di9NNDhkbzYxSUxGVUZydjBCZXVjSEt3?=
 =?iso-2022-jp?B?dGVqN1NteW9SbU9uTGxiYk11d1ZqNlJsS3hvbmE0SWlWM3JGZlc4aHNu?=
 =?iso-2022-jp?B?SVBRblUyeWNNL3VaS2graEh3REJCSUh0NjRIN3RJdmQzT1Zxb1NpVkh0?=
 =?iso-2022-jp?B?RUVNRVQyMElLc1JxWUhFWTB0REZGaFUySCtINlIwQ1llMUdQc29uVG16?=
 =?iso-2022-jp?B?eXc0Sk50cm00VGxJYzNyK3k3MDFrdy95WWtoaUl6OGc3dlVPNDdIUGg0?=
 =?iso-2022-jp?B?ZTI4YU5MZ1FVS0EwTExqL1BSYlF3aEV4QlIyU3B5cGt2WmFMSmcxMkJP?=
 =?iso-2022-jp?B?T3RUbVRGTDBYSUF0d2VZQjNOMW95clh4YjMvRkNPMms0dld1aFQ1aGFv?=
 =?iso-2022-jp?B?M3ltb25oNWVrVlpVdC9XRXRXYlJybmdjcTVac1YvQzJ6ejhSMlRiY3Nh?=
 =?iso-2022-jp?B?R3lhYndsM1UyN0M5RFUxd1FIQnVrQ055UGF4SFBZQ24vSHpGYktlNDBK?=
 =?iso-2022-jp?B?UFc1RjU1VDQzYWFlZHUzbTRFMGJydFcybFhUZVA1UURzcHJuekt1TnNB?=
 =?iso-2022-jp?B?RUVTVzBZaXplbi9iRkZvL2FXc1E2NmxZWXh0WjdISzhjNWF0Q21Pd0x1?=
 =?iso-2022-jp?B?LzE3YkpNRWVKUzJNQTI3bS9OZXBxQm10VzBtQjVGWE9PMG1rRVk2YWFh?=
 =?iso-2022-jp?B?blc3ajNDWTJ3SFZkT09HL2dUWGlZdDlITFNLS2d0M3M1V2RhdTJKSG8v?=
 =?iso-2022-jp?B?czJMang5bDZ3TmZ6YkdZVHBpWG9zN1ovT0w0MTcycEFHNmpubnRUQ1VQ?=
 =?iso-2022-jp?B?aVExcjdWcE1abmd5ZnFCeVcwVzEwcG9VSXlZeitNa2I4YWwvU2Q5VElE?=
 =?iso-2022-jp?B?YUlkUEd3bENLYXRuU2YxeXNhUXBCRjJWRElTVVdpVWZ5cUJnMXU5OU5I?=
 =?iso-2022-jp?B?NGVwa2EwVVlwbXRQUlFMaGw3Y00yNUZ6WWlNZnFHd1ZGNmVxcThMWFBm?=
 =?iso-2022-jp?B?OEE0enVmWXZqZFdjMnpleHd5L1N3UlpSWERoUUkvTnBKdEczU3hzajhK?=
 =?iso-2022-jp?B?bmFWNjkvMlFlUkFYVllQdDZnZGExVWV0QWxyTmlPYkloWnNnaWFMZmc1?=
 =?iso-2022-jp?B?RnZQTytETksvdHh0TXdTdytyTmtiRW81NC9MSTZZOW1hdXExMEg2Njd6?=
 =?iso-2022-jp?B?K0UyZzY3QjlsNEk3NzM3cjBQcjdlNTZIaVJCZ3VFY1ZRQ3lOeVk4NDd6?=
 =?iso-2022-jp?B?UXRHMFM1d3VRNW15U2lscEljYXpGR0U1YXRIVjNwbndld05BNE5OYXph?=
 =?iso-2022-jp?B?Q050ZmlBeXc5dG5WeXRhNVJiVDdScEUvaHZsWURGUDZUa3NBUmxSNlBm?=
 =?iso-2022-jp?B?cEJWeVJEZktudi9WaGowbFNYN2ZTYTl4Mk9Sd0JwNG1XS1lGS3E2N0Yy?=
 =?iso-2022-jp?B?Y2dpeEdkQXh3ZUdLSTFoSzJ5TDZvcFhmWnFJRElCNEZuQ2FKOXBublRN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c16170-5e99-4881-5dd0-08d922368acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2021 00:13:10.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9s3UWzhyCHo3Mr9/cFWZGbIeSIMFt12Zo9VKpdGn2D6ISJa4FiwBWGu43HNZNmaUx022mMycE8AmDXZgCIF8J1oBDJBmwik/q0QKdTJXDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6521
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KdiV2eEhiCVfpgBoweLatVs6x4520388AA=
Content-Type: multipart/mixed; boundary="cehU9oKKKEk3RvazHwK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622247504;
 bh=FXkbTPL/om7/zmNO7k6yqRKOOVPFtLa/2fgKErjZMHk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gG1vrGibx5l9K1xZ0jFEds1zdEe0BW9+V/rUKKbWzkF4tOFrcaWS4/XdL3nVJLwDAn8
 VqIaphZ0xTAo4KmckSxseyK9zsfzO/XLxc+aijYpHeVVHUoZCH1uKo0UwylamKIJOOHzm
 mD8HYHppW+B/Cuk3SlCZbxhBZra1A2KoA/A=

--cehU9oKKKEk3RvazHwK4
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, all,

As we discussed at the last IRC meeting, we are going to use Libera.chat fo=
r our IRC meetings starting on June 3rd.
Many thanks to Alice for this setup.

The new channel is as follows:
irc:irc.libera.chat:6667/cip

We will see you there!
--
M. Kudo

--_000_TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219TY2PR01MB4972jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
span.17
	{mso-style-type:personal-compose;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi, =
all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">As w=
e discussed at the last IRC meeting, we are going to use Libera.chat for ou=
r IRC meetings starting on June 3<sup>rd</sup>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Many=
 thanks to Alice for this setup.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">The =
new channel is as follows:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">irc:=
irc.libera.chat:6667/cip<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We will see you there!<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">M. Kudo<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219TY2PR01MB4972jpnp_--

--cehU9oKKKEk3RvazHwK4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6480): https://lists.cip-project.org/g/cip-dev/message=
/6480
Mute This Topic: https://lists.cip-project.org/mt/83162075/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cehU9oKKKEk3RvazHwK4--
