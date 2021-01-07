Return-Path: <SRS0=PsUc=GK=lists.cip-project.org=bounce+64572+6048+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD7C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 00:50:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B6B23118
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 00:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6B23118
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6048+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Um0LYY4521723x1kY7PdlyfC; Wed, 06 Jan 2021 16:50:00 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.125])
 by mx.groups.io with SMTP id smtpd.web12.1940.1609980598372527438
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 16:49:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQeJLriUEwZRGkw10T6N6SxhkmQDzOBcUOPWNsPLqjLrl0j9UtzQG5Zba5ayTz1iWdyewBk+kDGLId1lm3TOCfpOo8Bpo8IjsvtKuY6UvXsZxShLRzmaC1KxaNxjtaOb2SJSxfpp3jIl/kG4Qh6UsB3I3Cfrfc85J9axeWsqFaKKqQYjo/nZtDtkIvHokNhbhyF965TAwx46R3iJG45p0h5enbx+ZNeplR9H2+bHjDwT1IkYsh0luNAaRR1W1DJse36cicy2uA5fQot2v90Lo607T94lLj3zql9qVOJyKw/NzCS6kIWFJSbaAD2YuwRRi4HG145oXnSQYH0Bh4bt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdTNQhKO1gPyhDLSly20Hnaa6xqtyKCSzrKKkAMmerM=;
 b=I9eKcZThmJ93k3H3qIWaH1G/z0n0DtOX3nD9nllklVZLSrE6ZtDqmInZMvDJeMPVO07+jdkkDryIM6PMCnP5Q8+M1Q2uz/5/K4S8mTctgJjj8axXHwOeCob+UGkVr+kLTFuphwXikZPdZGeZ3+R3mEC/LhgdLrUaxyHeBzYYOLfuaG0qfqIGsFLorYRhYnWmrRWC0HJa6Ts8yOqT1fE/hPJNHZd+GXvYdh7MGz7pAGX4phhDXHKG4M7h2S0ER2AsZ628SIcjdAQxgu0drZhcJcN+9jk9ErJ7AI24istqqEszAkn88+ZtuOi6r8wDBmLlWtKRstTILcGMEJOXVz7q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5498.jpnprd01.prod.outlook.com (2603:1096:404:8043::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 00:49:52 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 00:49:52 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbkjrfVac9zsCLBQhmidfrQ7pedFQ==
Date: Thu, 7 Jan 2021 00:49:52 +0000
Message-ID: 
 <TY2PR01MB49728B38AA0FEBD2B2AAAE7FA0AF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a23dfcfc-5dda-4b25-0224-08d8b2a624f1
x-ms-traffictypediagnostic: TYAPR01MB5498:
x-microsoft-antispam-prvs: 
 <TYAPR01MB54988128D0EC39117646D041A0AF0@TYAPR01MB5498.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 DUXg0h3hKqZ0/mRv82Nxo1xwjoYwyk+Z4Uap7BHt83tDzSIFQWejxkT80K0Hx4nxttY7fx6TUYdXzikjIhP0g2rYwzPVyH3r0Kb31WT4F1nLFA1cag0ZYFbL+Q41qDVkh41FdFQcEHDB519ED4VDfw8evje8AkkVvRM0O60UOEs+inEMwAO2haGbEWkA8bDlW0DD1MVdrkyfRyln5kXUuxH7By4SCNdP16LxD415vEuTxEV4KWxLeP5DNJWMoJs6yEBUOE9xdjqgp/98Fu22xRldRQu8mBSMaNlGQIVb0vaopyx7cqE9YpS4rmss6nQsR8yH1Ki7PrRvUO987DS8XpUTf3CrbnlAmStQVDcjWM+RVBDB31zndQ9P+63q2ZNNbvMlKyyowuB6NbJX5FbzRIaZ0Ma55ZAXmdzGiVVcTQki1x3aZcx/h++dBz0d+15yKxgOGCfh8waAcWWoJAUhKg==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?TDVhYmgvLzZieWM4Um9BVjlhakdUbWVHT1d0cGJjRlNVcjFFenJkbk9k?=
 =?iso-2022-jp?B?VXZiNHZSL25pTklId1Fya0lvMWVQVjJTMEgrbCt2RHkxNVk1SXRZakIx?=
 =?iso-2022-jp?B?d3JEQzFFSFlkbk1JWHFiV2xCSzBVMlpqdG82aUM4UDVaWHlUcldlOGJs?=
 =?iso-2022-jp?B?THplS0pMTzZjOHEwSllFWldaT3FQbzdhWnUvY0N1TENQOC9vYWdkR2pt?=
 =?iso-2022-jp?B?Mkczck82NkVkRWsydkRFNGNaaDczdEpBWE5aRHpwcUZBV1NLN0hobDNX?=
 =?iso-2022-jp?B?RllOTUQ1UGdsWFkwczFzT2Jmc00yY05LSDZ1dUc3SGhVTnZiV3p0TWh1?=
 =?iso-2022-jp?B?c21SMThRMEgwYTlEWFpBM3RWVkM3S3NvazIrK1F3NzA5ZndzcmZjK2xG?=
 =?iso-2022-jp?B?bXJtMDlLWkZvUjBSWXBJTGRKZi9ZbThHSlJ1WGtJN0FMN3o5ZmMzbVZL?=
 =?iso-2022-jp?B?OC9vVFpWc3NlbGNDQUR3a1daYitRTmpaSW9yaERlcmoxR3doQ205TTJJ?=
 =?iso-2022-jp?B?L29FMkkxS1AwaFN2WkNHWmtqSlNWVndVN2xZbkFLOHZKSzRtdzZoSm9l?=
 =?iso-2022-jp?B?eWhJckplYWZibGVsYnQ0RDNOazY3ZHE1WlgzQ1p6UEZBaE9SSDlJaE1V?=
 =?iso-2022-jp?B?U2I5UHNIem5vdityaWJjTXhBbGNHZVJhME1CazNoUEwwVmlxVnBJbTRk?=
 =?iso-2022-jp?B?SFk3NCtuZUsxa3A5ZU1lYjQ1UnpWSUhhbC91SWN3akdCU1ZaMjk2V3pL?=
 =?iso-2022-jp?B?Yyt5VnlwMWk5VkxRZTR3bHRnai9VN2V2bFZPRytGRUdWYlkwU0RpZElQ?=
 =?iso-2022-jp?B?WXkxWWg2ZVJ4N0NxaHhueFpQTjZXdWl5NTJSOFE0bHpSak03VVpCckRv?=
 =?iso-2022-jp?B?ajFkY3JmaC9oZ04rQlowcHRqelJKdEl3UWtOMWFiN1liSXlGVS9jK2t3?=
 =?iso-2022-jp?B?NVhwdG1HVDBiSmFEN1FoRmNZb1ZrUjNEQ3J3cklrN1o0L2ZFeGNnRDdD?=
 =?iso-2022-jp?B?ZTJ1SlRnbDRnMFViTGphVnpFRm94emJqMDBkWWpqNDY4Vit4UWNPM00r?=
 =?iso-2022-jp?B?YmsxR0ovM1NuU1d1V2l0R0JaRG5yb044RVpWeTdLMTBYUzN0ODFWajQz?=
 =?iso-2022-jp?B?MUtyeUUvV09uVUdHRUlKSVZ3TVBmeEZMUzVIQ3hrbTlWL0E5ZHJGckxz?=
 =?iso-2022-jp?B?NTM4TnVacTVaWEFpYllTWmlveFpQRTdMM2dyUVdubXYrVFJLaU9zOVFJ?=
 =?iso-2022-jp?B?SnZ2MjNaeVorWkJUVjFyRzNaUWVpOEF2SjVuWS9Kb1FZckhMN1h2djk1?=
 =?iso-2022-jp?B?SVd4Qm1VTk5DS0tXSStiejhJQndZUVhHV05vbWt0RXRJcnliWnNYayt5?=
 =?iso-2022-jp?B?djk3aGFIZUFBSkV6WGlHUnZBRzQ0emhacy9KT0p6RmRTd09nVT0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23dfcfc-5dda-4b25-0224-08d8b2a624f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 00:49:52.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMO3mLjc5KwFr5W9Pfh3BwyFZ6XN1QsfLBJjiAwLmb9iiRJFvKTE64eG1PL97mHpEbkyEIUcqO4Eou5IZjutzSCVsI//YIPonWBV3TjtcTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5498
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gSCp9dwn0z85GUFhBfwqeE0Bx4520388AA=
Content-Type: multipart/mixed; boundary="ELBtr7B05yZfswHMaTfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609980600;
 bh=QwzrcUs7CztCFyDESm8gTa/pgz1ohhYsS7ZeSG4t4ZU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mspIABiu5KhuFrpYZ4C7bfExmhQa6BoYyn/r5RXE4b6lwnnEsnU0Za+l64ejjeEia2G
 F8Ow/dcw7Ivs+bJxXZBkdgtv8OqaDIWPqftJtHkOwm/1WjgqsdYqlepSqZcVF6IYptkRV
 RyUaWZ/0GrFt4UcYIAeF+jR6L1+9VzIhncs=

--ELBtr7B05yZfswHMaTfo
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D1&day=3D7&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/12/cip.2020-12-17-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Discuss an open issue (https://gitlab.com/cip-project/cip-kernel/cip-k=
ernel-sec/-/issues/8)=20
      - the necessity to track issues that have been retired by distros - K=
ernel Team
  5. Decide the timing to branch 5.10 to start CIP development - Kernel Tea=
m

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB
  - next meeting

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--ELBtr7B05yZfswHMaTfo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6048): https://lists.cip-project.org/g/cip-dev/message=
/6048
Mute This Topic: https://lists.cip-project.org/mt/79489211/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ELBtr7B05yZfswHMaTfo--
