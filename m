Return-Path: <SRS0=pK+w=C2=lists.cip-project.org=bounce+64572+5456+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312B9C43461
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:20:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CAC20732
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AikB8AfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CAC20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5456+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2ZdJYY4521723xl6KozyHmP5; Wed, 16 Sep 2020 18:20:57 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.123])
 by mx.groups.io with SMTP id smtpd.web11.5336.1600305655990218078
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2020 18:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS6sLzvD4qMyVPudjEoWZUONekOIObBvwM2UZgPIeq9y5xdt+ywhjAyco/9UD2V0FLi/6MRg9h4sAAWQvmR4X9hijO0b8ELrLVJBGEEYviSnP9hAvQntbvcJouU4SD36Ev+WOVh4qyV+oiDFCQ/9roEHiWx3zCWXYY86LLzYZTpHNVAshdkFlDBnxqHLHKpnenSSJOBlLU5u69ZJrzSdib14RSuWcOGZmtFwBK3ls7a2IM4AMaMkBoNUxvQMgwOJA5yCJc8RlVlbxxt/8rOOZfR0vQ1qQtmm5S7cUfnkLl4EvltOBtZy2/oDtJzbZ7SKH5jxbfTVBqF+hrFF31C7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06YECXLhenlGJXjbTmKgfxFAZUGn7bmS2SNvNwwtA+U=;
 b=Ui2a5H3sI5O3FVLdcPEfSjBUWCLJroQwtcuCtOU2sBuY2cYPivRyrSg9nDr9ODjIK7WzPts7bv7tRdy8u1sMxfsqiG0sluO40Jaciv/RO7V6yYeOessxQCHQMs0jBsWEmUALENVWKO95TPqebUpIEuyiVe3rLPEZHPDd9FmeCUZV91u6wdjG9pCkcm8BGm4N7MPKKW5aWti8oF6RuTpAcACfCg74ycgHGg+rQzpYUnxq2jhU8na6sh+TYn/XbKv95F8cKM6QdBB6vvQWN5R42NGaX3N8lZYQqdzqSrzgjB5CkYciTXrALGKX36mZOo35d/jWMJGSNaGGh4IoQT9uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 01:20:40 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 01:20:39 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaMkEoenc+64zJuQ2SouSfE5reZ2Q==
Date: Thu, 17 Sep 2020 01:20:39 +0000
Message-ID: 
 <TY2PR01MB4972733139BD136E3DF656CCA03E0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbc96d5a-2f70-403a-96c5-08d85aa7e3ba
x-ms-traffictypediagnostic: TYAPR01MB5353:
x-microsoft-antispam-prvs: 
 <TYAPR01MB53537D18AEBB964B4F7D90FDA03E0@TYAPR01MB5353.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 69poy1Hkt2dapLDGDt+wLNtTnxwFLUA0Zp7h0FpwJBcjKOjtmhRPH7m8uqQsyr+xn9/dn8/kaiteSEQkat6QVFzw25uoBLguUNrBM1bPDM66g5ZfvEkp/mcA2owdHxbeLb/yA1xkVQBtljoBYRbCRxz78k6EdTBi9uin3zK2jeRjEhJEzJFDkHKb5pf+l0chQIcdjDFMyjz0zm6tXsb3XBBkS/HkgXgbz2KVIOWDPvuFyJr0FX2flZff5hr6CtDzg/953Lmw9US3sOTZB0v6tXkTJOlzowAU8BerAmYeVWYlZ7AI6dkRFNUsB6zY4Ws8+j8RiOSxS4IrClo9EXAOH7pcZr6kognQAYjltc7SHQfISt+4Wg/ZiR9PLsKTCU1hUkjDyyUapVli7nqcvkUjtA==
x-ms-exchange-antispam-messagedata: 
 G9npN0z/gIMc/G2IGkW1+tJZKa5tvtlufCOU5S0IAdf8arqU7uuwyRAP14VPTL0z4ShuamJGpgmIc18X/6qnR+srXPdu5scS+WWN3BMG6fGA4PCIT1NktUBKwGduNLkl6KRnsUKiqjVt0uJjn8OrHkQUujsVysuXqtj3qDUBThSseLuvfvTXKODSw4VcuI80ZYNzMWtqWw4/0jGITvuXVstN1gynhFFD1+gKA9AQ6TC6Og85pV/x69dZVuYWP+FjonKzdtA1qzmf6Mcdz5Vh+D6sCf6+UKR/U3aXELSRECSuchOvqGni5Z3oAsBTwUPdVtBDyNM39aNr/jY3f82f0N/Mkzf502RMjP9J2/g6f0Pt/wRWB7x9t8vBGbxUeccYva/qRonzcbyusLgyfScQXih/SEajLdSxPQqRuyQjCAX5GzRdkVaMYVfyUlA2KbNC/hubxOsMbgYUTKwseoudQJl9LAQ4ckiN6Msq/3T7HtRk35P04vAAM7YdtSwY6UVkKW/xsGi4UYVKw/n/tULsSjtgjgBmeqMlWvQLUpoS7hmfS3RZOyNis3oETcPh2XKjsDmOp1n9jtGeJwO1cG7/Ie8X88pfX14c1b8YUJKxNgCsPSGDCMx7xQFc1CSFdPd+qEufptYFQyHnf5pC1E44OA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc96d5a-2f70-403a-96c5-08d85aa7e3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 01:20:39.8820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hTehz/RDEJG0N9nuRYJAASysUHS9x6jLLD6Pn1aBuJK80xbv9dISJTY2t6UApDPqSHjPiXEQO91TxBKjze3W8uoFOEUS+8wS8TfJwuRI4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5353
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nMLSHTkwFUzHCrAZU2hNh7tHx4520388AA=
Content-Type: multipart/mixed; boundary="doBncHpcJBfT7Mz0uzdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600305657;
 bh=ECnGapxUbkf0fT3ivwOXe7MPYHHilAxJjMF6fvjlSdU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AikB8AfD8z6DoI3YgqpMyToRFyGebU6MT1rfsCRYKgQgRmDQ6dmFiMMM715qwzHFWUi
 jCbSyZHDZmKgLwD0V3ptsgX3ArKthpg8aig7EiPk+Y9mcpR3q6WwNsJ+3Uo2J0fZIBOCV
 EKGOuRc+eyAWhgX/t/IJWKz5CUhwHd1PDEs=

--doBncHpcJBfT7Mz0uzdk
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D9&day=3D17&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-10-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20

* Kernel maintenance updates
* Kernel testing
* Software update
* CIP Security=20
* AOB

Since there will be another meeting at 9:30GMT, the meeting will take less =
than 30 min today.
If some topics may take long, they will be taken offline or in the next mee=
ting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--doBncHpcJBfT7Mz0uzdk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5456): https://lists.cip-project.org/g/cip-dev/message=
/5456
Mute This Topic: https://lists.cip-project.org/mt/76901376/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--doBncHpcJBfT7Mz0uzdk--
