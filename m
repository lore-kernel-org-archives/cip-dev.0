Return-Path: <SRS0=Cz7I=K5=lists.cip-project.org=bounce+64572+6490+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C6C47083
	for <cip-dev@archiver.kernel.org>; Thu,  3 Jun 2021 01:28:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C10D613BF
	for <cip-dev@archiver.kernel.org>; Thu,  3 Jun 2021 01:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C10D613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6490+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yB5IYY4521723xHPDmrC5UQo; Wed, 02 Jun 2021 18:28:52 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web09.2138.1622683730753504166
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jun 2021 18:28:51 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id DKXT18271A;
	Thu,  3 Jun 2021 10:23:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl4ABtZBsujKIlpBvFMV2+NQilKqE/5FN18QJq7XYdj+Y/sCAeBjSVbUudQNAZWM5maJElcyS+zFZLR0ovw5gPAN40tuaettYk7gBck2HjQPL1NP1pQVzNepzCzswVct0uVjL2wPbjNyAkVLlhJ7MCws7OEs412YNwVgSVVrvkIERVsrO3arvunm7rm2bWmWWAeZSX1j0y8yh0ChXXi7pEkquZNXENDD3pOiTjjI26gurWXeAFxCbg9nFCngmAFK4V2JuUxz3y7006H0YhnIgi2NMWiSZIOvqm1O11wYgF5B94fSk0Q06F2mR0NmJkSMTGiyKjrhLMhyAkMUsDhnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0NU9ogQZQsfbCO+64+rFm4X5feUqxd9QT5ejyyGNxs=;
 b=nB9oQpNSPNBVClWGXLCM+hIvul0YAivzrON9fmmgmjK0cnzQBf0AzsDzM63jw/HwrIQgu2CLPmJbIdL7eLl758YofoSx4BokvJ2R62R/0tBFtXnrwZnNu0Y+IBhZnKPs7ToK1aRzGHWWVohFtY9h7JnFJd33jdtbzVJQqCWPpMeeuqX6NkHpmTPy6amV7WrZL94ltTPbNjslA6gPhADLdXQ6UCzZpN3MRyVbAW4aemYRpleRR6k9XTu5fWc0qfyxY6xBqJ9P89tKLslLzDEJdwIWIoqbYJ4LShSwZIuvQi7eVB0JYFniCnAE70MhkpeQKMlUVQRO2R1ZuyLwIdhqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYXPR01MB1599.jpnprd01.prod.outlook.com (2603:1096:403:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 01:23:06 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4195.022; Thu, 3 Jun 2021
 01:23:06 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AddYFu7xpGcvCrDGRAGPwq3Q+b0jqQ==
Date: Thu,  3 Jun 2021 10:28:43 +0900
Message-ID: 
 <TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 400bbe6c-7a9e-418a-632d-08d9262e23fe
x-ms-traffictypediagnostic: TYXPR01MB1599:
x-microsoft-antispam-prvs: 
 <TYXPR01MB1599DB728032BC77A51B8C7EA03C9@TYXPR01MB1599.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 eQRLq8gg+VyT2GvIl0yKXA8UFCN+oJ7IwvuOwFRBT7LAm595h0TSgVbkpXmethLWMjzOKDi8Af4oh9E26eZhOTDWn1F17/nszyD36UbqjOkmiJNnQqW7AczxemcNlPFL8Ie5zSCofwkmTAH5XrIIjPd7XpNZKgRWxHQjSZ70gl3drSiGlRqZ35ebteGSvNdVDPU0L6YpZI0n4GYNrSZGiJe4DTh622b4d49lsTsdvI7DvsejhKxhhJza2ZtLP65dgJiyg9n0hfFzyPWT03L1k/fa+R/MU1CQHF/mJMG78+QiQSr5kZGZ9QnMMAGFnWbRij47NaQYqK8AeezUAWaRdu1732Axt2Kd5D7Lqi2AM6zT3PO8GMXfgKzTOY/VLj/5iBU01Q+NBN0Xnqb6vs8mTLtZ299jJTXAABR1XHlmTQAouR015rWQOvWGAI0Sanr/5bCIJZynKw8Tz1+0oLNc7AZfPW7SX0dEvLBeM6kGerOrz4jkPevobrUA38gm2y3LBdL38ZBcpS2TDIswKG+KaFJepgccqeq/Zeq9FrX3wwNbAXdDDHk3ccAQAwuvXND/1mrH6m28tmDMirNh4xuHer22QSauPG6OJMm8SJv/vRlYW05EJMK1uuwlEfqgVjX8TMf0zOjxO+0PbOrvy/V73nWu7YEEkOp38FOUdG01xyohLTtXO/esqmQ+oosdqAE89+s7gt5Dh2HdDlaq7GtOlrM6ATZGEC03azScjK1k3aOQstSH0G3oEZBTTgqs40sQ5pRP/DXpkjrjObZMk92nGIDEKmGhwV9Av0+sAuY2nQSSaSAcueJm5rpN60BIfm+T
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?b3hWVU8yNVNpYlNzTnlzcko0N0hUektwblZTWGtuNmZ4WDRKN0tpd3Bk?=
 =?iso-2022-jp?B?aUlDalZJZGpYNFV3ZmFvTEh0bU5hcy9MRExiQVZud1ZaWDA0VURmdjVE?=
 =?iso-2022-jp?B?c0NBVVJDUUdMeGZlS2FCSExtYXFBQ1VCTGxaY1dYNC9aNXprQTlTZEVs?=
 =?iso-2022-jp?B?U2gycktMSExIbHNiMDFCdkpyOTNHakpRS05FR2FGTWdGY1M5UVRvL0FV?=
 =?iso-2022-jp?B?MGIyYm03b3g4MXpGSXFxWHJ0YWN5bHY1OHRsRXVoUHBXN1E0V0lmVXUr?=
 =?iso-2022-jp?B?T2RjRXFTbnVaN3dqSGhCQk9MTDUzZ0RRVDhSTUlXeERSTFNtNlNDb2Q3?=
 =?iso-2022-jp?B?TkxIVzBXcXJ6aXFGZWtJcGlGSTluZnA4S0NjU0p6dUZWYmxNRnllaWdE?=
 =?iso-2022-jp?B?WVprLzdGeFlJU3paMWJLOE1xNUJoQTBrZmJocnJRN3hNMjhUS284bUZW?=
 =?iso-2022-jp?B?NmFwMGN0UTkxUld6a1MraE5yTmlUemxoeTZycUhZU0pjMTdLM2VGejI3?=
 =?iso-2022-jp?B?NDB2OWFucCt5QmNRampqT2RramQvZFdndTkvSlo1a2hpa2FIQUlkSmNO?=
 =?iso-2022-jp?B?Y0dEd3EwNkQyRy83S1QxOXVVeGVaMFEwTllxYThhZWtJN2FqSFVXTjB6?=
 =?iso-2022-jp?B?VCs0MnduWk9VRGlreGlSRmU1TGx4blBFY0NtL1RsQy85dEpETXY5OGNN?=
 =?iso-2022-jp?B?QzNnREdtS1VLZmxEZDEvbUNORUtQZFg5eEVoN3NhTXRDY2RuSlhwandV?=
 =?iso-2022-jp?B?RDFmY3FxT3NFeTNSTTVsaW5aTW9UOTA2dHRvWndvUTloSEVrZFJhYWhT?=
 =?iso-2022-jp?B?R05CQ3pJWExIam8xbm9BVjdFMXkyU2I1bGlucFVEOHJnV1dpY2ZBeHJQ?=
 =?iso-2022-jp?B?czJBeEV2SlQwalBmckhnQ1hmcW4wTGozWEhNWGREZDQ2QktHMFllOHZm?=
 =?iso-2022-jp?B?eUl1UHZwSHk4VUM4NnNnNml0MTFnMnJoTXFudUc4MU1ENEkwSCtWdVdV?=
 =?iso-2022-jp?B?MW1PSjl5a0JyVnQxTExZZ1pjZFdRbStYc3BVZC9TaHRzTlhMWms3cE5y?=
 =?iso-2022-jp?B?RXNpTlhEb29Td0N1KzZDOHlCM3BpeHdibE1hK1psNzRZRFVlV1ZiRHMr?=
 =?iso-2022-jp?B?YVd5S2gyOHQvcEloc0dZaW5ZMEw2SncyYk4wSmhzenMvbUFBdXhZRjk4?=
 =?iso-2022-jp?B?RjN1OC94dnNTeE50NzJRYlYxVXYyS0NiQ0pMaVMzRnljMG9tZmt5RFJS?=
 =?iso-2022-jp?B?OEtqSTdQeDJEdjhKTUNjMXdqOXptOWZhT3pIa1lrMnRXcHZtMG96Sm5k?=
 =?iso-2022-jp?B?R3lJS0tuMHFjOTNzOGR3VlN4QURkMHRGOWpuT3FIUVVQUzZFK3YxdkV1?=
 =?iso-2022-jp?B?MWpPMHNEUkVHZTl6ZDkzNWwvV3o0eEk5eEZMUTQ2dWhQbGlBaWRDNlJV?=
 =?iso-2022-jp?B?cHpXNGxqVUREdlJHbjVZZkR5eWdsL25qWExEZVBSRFFtdGpveGJsdG5t?=
 =?iso-2022-jp?B?OUZQTlY5S05naEdScSt0Ukh0NnJiMUlOV25VbWxRYVQrRnBxck54Sm5O?=
 =?iso-2022-jp?B?ZkU2Z1hvbDN3NGVoNzFOZjk5UXk0NE9rMUFVSWF6NmtWeGFFS2UxRkky?=
 =?iso-2022-jp?B?a2VZbGJnemdoZWtDdjU0cEZkSG1xUEVreFZXdFh1dFhpQlBJQi9wQ2Rs?=
 =?iso-2022-jp?B?d1BGVVRyMGVTbGpudmpsbG04eWRhTDlSZ25lYmZ2QjNtNXo3TVBmaWxa?=
 =?iso-2022-jp?B?RzFKcTFhT2pveWF3T1l0Y2drekhiT2pDekwxZkRVQ1hERVNZOUdNMXZq?=
 =?iso-2022-jp?B?OEI2eXBFa3FuQ1RJVnkrVGVuRG9FWGpia1lpblBhSVc2b3B4WjZJSHU4?=
 =?iso-2022-jp?B?ZnFLRXFkNUVGKzczam5QcE85SzRaNzZCRzZ6SFJZWFhFYXJrSFBpekJI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400bbe6c-7a9e-418a-632d-08d9262e23fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 01:23:06.2731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZOeJqAzofEaax72c2b/tY5ZuamXkv9GUWAhTsHpEWrgkxbddzIbv3F7wRKsYAo9WqvvFutSoLskqJrokH7BKEtH7WIyZlc6LjTzismwj9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1599
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UTkATT9gLANeFNKpoYkSrLMex4520388AA=
Content-Type: multipart/mixed; boundary="Qg4ENhLTqpi6Ytbx2d09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622683732;
 bh=Bn0kbscjGY+ufemaDU+62MQcpNr7TFpkd/66qIroKtQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MGNblY6zmL+Qhbdq3iXqNJyzKFTQlDweQQRJQUzv8lrJXf0iKyt/DfaP+tH1NoaVyqf
 Wh3sdIf0nEZDce9wulqEQei8qlIdbVFZy//2vqiEQ6ar06yYyc1O+sD0bC7FNRgM+touB
 nK7yEuLRBNlLp5Beb330YUxzRuRMgFp74z4=

--Qg4ENhLTqpi6Ytbx2d09
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9TY2PR01MB4972jpnp_"

--_000_TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9TY2PR01MB4972jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

Please note that we move from Freenode to the new channel (libera.chat) as =
follows:
              irc:irc.libera.chat:6667/cip

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D6&day=3D3&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest USEast  UK         DE         TW        JP
02:00     05:00     10:00     11:00     17:00     18:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-27-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu
  2. Do some experiment to lower burdens on CI - patersonc
  3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kernel=
 Team
  4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team
  5. Update Testing table below with 5.10 info - patersonc
      https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesti=
ng/centalisedtesting/cioverview

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

--_000_TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9TY2PR01MB4972jpnp_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi a=
ll,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Kind=
ly be reminded to attend the weekly meeting through IRC to discuss technica=
l topics with CIP kernel today.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Plea=
se note that we move from Freenode to the new channel (libera.chat) as foll=
ows:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
irc:irc.libera.chat:6667/cip<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">*Ple=
ase note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting f=
rom the first week of Apr. according to TSC meeting*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&amp;mont=
h=3D6&amp;day=3D3&amp;hour=3D9&amp;min=3D0&amp;sec=3D0&amp;p1=3D224&amp;p2=
=3D179&amp;p3=3D136&amp;p4=3D37&amp;p5=3D241&amp;p6=3D248<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">USWe=
st USEast&nbsp; UK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; JP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">02:0=
0&nbsp;&nbsp;&nbsp;&nbsp; 05:00&nbsp;&nbsp;&nbsp;&nbsp; 10:00&nbsp;&nbsp;&n=
bsp;&nbsp; 11:00&nbsp;&nbsp;&nbsp;&nbsp; 17:00&nbsp;&nbsp;&nbsp;&nbsp; 18:0=
0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Last=
 meeting minutes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">http=
s://irclogs.baserock.org/meetings/cip/2021/05/cip.2021-05-27-09.00.log.html=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ac=
tion item<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 1. Combine root filesystem with kselftest binary - iwamatsu
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;2. Do some experiment to lower burdens on CI - patersonc<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 3. Monitor the status of CVE-2021-3444 and CVE-2021-20292 (3/25) - Kerne=
l Team<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 4. Monitor the status of CVE-2021-29650 (4/1) - Kernel Team<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p; 5. Update Testing table below with 5.10 info - patersonc<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; https://wiki.linuxfoundation.org/civilinfrastruc=
tureplatform/ciptesting/centalisedtesting/cioverview<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel maintenance updates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* Ke=
rnel testing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">* AO=
B<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">The =
meeting will take 30 min, although it can be extended to an hour if it make=
s sense and those involved in the topics can stay. Otherwise, the topic wil=
l be taken offline or in the next meeting.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Best=
 regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">--<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">M. K=
udo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Cybe=
rtrust Japan Co., Ltd.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9TY2PR01MB4972jpnp_--

--Qg4ENhLTqpi6Ytbx2d09
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6490): https://lists.cip-project.org/g/cip-dev/message=
/6490
Mute This Topic: https://lists.cip-project.org/mt/83274323/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Qg4ENhLTqpi6Ytbx2d09--
