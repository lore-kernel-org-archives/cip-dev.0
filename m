Return-Path: <SRS0=Zfho=FA=lists.cip-project.org=bounce+64572+5880+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C114C56202
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 00:25:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9221520872
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 00:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EXUK90tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9221520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5880+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id W7VXYY4521723xHbzabQNtPA; Wed, 25 Nov 2020 16:25:55 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.109])
 by mx.groups.io with SMTP id smtpd.web11.5058.1606350354357130024
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 16:25:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnkh3pbJvcksq3MhPD+n1arnf1pmT6pfU2GQ41BJXVWacZnxZQRJ4DT+Sl2iu09ad/QQGs16nz/c+KsRUr6sTyPPYT1CNdVxIZkMhGCbCIZ0RA3vDkCxtkftNIaHyygShdFpURWKQqFHd7LkqWebvyZ1fbB88BzTFVNW0aN8v07VWdRQnb8iR8l+Bw5tkHMpdUK3KYmaAIPMbFUZlUPUp/fTmKyhAo6IOTGFs71nOUyto+lQhOyl8NIyLU/il4PSwfoF2eYtNy2Pj8+XWY4x0g5FT1hD1MkVz+vObMMJQ2rGkFYAK+ZxSwGFrOYnRbCxFtbxChB6Dwgg+WWQ4VpVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q3sFLbJrJV9rXHLoB2wN4Ew/HGXWG37tw1XnHJRepU=;
 b=iGCKY3pjqkNKw+3y7MkekMhJfCGRiaUgZFl6mvW3gFk95e4U4j91ByLb8yp5GNNjaysLZWvUPjX3ZLSDAsb+3ISoS5DlAiEvo4wHwEvWctJpZ8kB+R6kQvV5U1JHNu3bWy5cyS1fhJ0x7TNP4f36UUSn0TxGOu+8oz5/JJnSDERnKjAR53n9xFvRt8YFe9/rQJ7dors0aFsSs4QweWNZG4YB/ErBr9qu3d/gW2MHIKuIgzahp3h6SkITMfAIH7gNKw+M3LT4/Qx4X0lHjvtlh1vWP138RtrDshauwXi8PIjVF+KL+hrIHK8/ztuXN+pujKk/Jt3MH2otJECnzhHbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2303.jpnprd01.prod.outlook.com (2603:1096:404:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Thu, 26 Nov
 2020 00:25:49 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 00:25:49 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdbDiqOuLLmzHUvHSyiYO6qJiyFCEQ==
Date: Thu, 26 Nov 2020 00:25:49 +0000
Message-ID: 
 <TY2PR01MB49721B56F8D5E13638D4D8ABA0F90@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ca67144-c4f8-4329-181e-08d891a1d392
x-ms-traffictypediagnostic: TYAPR01MB2303:
x-microsoft-antispam-prvs: 
 <TYAPR01MB2303D65E410194DBCC2E206FA0F90@TYAPR01MB2303.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 utkpFBtX9l87gZUiRNH1pRu9WxpeuD+XrKB9vieDk8jWxJErRBt5XBp3tziIDcf5Gg17C1wtvZghyZWLctWzH2B3zxPlKXLrYFM4ALBS97z+sWIxTdO4vCuitcVY0RIwbWQBkBK+KEdrMc6yHokjh3tSi4I2VE9Rm398ydnFtocv1usIo0QafFV77n02bXXyZxdNldyXsfY8sIP/eVmrQ8kscD2Q5HoCPJ1Pzww90ymfdQ19xQSmSQPmy4buCW97sLOsDdJ66A++gRTUoVdrKf/98k0Q5qVvmLXpYxzNwFkunv1Ojo4BFwoRLAeDmyMFGlbsI4VVWE0LySxW4gEOlRexS9gi0Uiud3E/qAY+fgaVOkEUD9mCmFRAlAQh3f0xl8vJHxAr6Ilwr0FflET+kQ==
x-ms-exchange-antispam-messagedata: 
 MihGGyRtBWCPgaid8wLP98OMPExsTFzrVm0vpH0Qi/hq8W7DlyF6zWwttwLzU+HNoPjhsfnutKkmw6HiW98OTFs77JbSIXu2s0B/u4h6sYjOjpA3N3Ihg6SKmzpRyS45SOfJgNmucwTqaLhoFnC5eHP+ver7tqZm3ePXjMR9pfjnXKZM2VkLdks+J5qMJFzzb8eYxQYvAIkek0AG/pKKz0lXJSK89DRQZhPdRj3v3F3KCWO5m9TmF6B+Rhh7ENs8imRv4C3nY5CEi9z5lawfwfA47DfkoFYH/PIkEqD4/UqQbSn5zHTyVBtmkGf0BkUssPHqatMxTEIuetR4hXWU2OocNC+0EoOipHdWNQ0sMVE7fIIkyExe06pFNnZ7Ctu+c7w77UIA/krLm9B00gb1clEesvToDMfGMiP1CqxBmgrkmxSYCIUXwy50TEmkkOjn/ENYqGrxe5QOfaGLnujgBH3Jh9ucX4kcEmC8Iq6lrdhMU9wFsrlUIiPCgSS6Qc2UPuUVWUXCSQsfe03zzKMI/EeQjQ+A3ZYZ3zbQCXp2nYFf+CJUrYEpl7Mq8EL1ENWlfxpqaQX0FRjWWUa8RNPb2QKYAhByK8cKU37mZZpMX6oU2yi0BU0DYvJ3cL2bq9oAySY14nDY8uoeYJ/L2ymXpRSI7UyRQ+EyYP0qDayw1oiGZVjjyreSWt4YlsdxkaUoum4wTW+1MDW2YOftzBCGhLHe/G7VgiZcDTKCLbRdQ0o12d8L+On1M7AxmDNChY9gKMVXjZuYysFIJ8dRiAvQhVcktme7psRuqpkcIh8788do62RBXVz0b7+Uz0o5yaRHP/xGhGKwTtw3xnFcz531VdBj7jXauf2dB3k0tp+leD9n6E1TYIfBVAY0A9jdB6348iE8pEpAswxHKFqFtPq8yg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca67144-c4f8-4329-181e-08d891a1d392
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 00:25:49.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV1APCiDPEU1tIcOv0DwQBhcBg5Hl/lh3CIb4Zo7h8lIy6UxVIBHQtGouamUfPkdh6L3hW+uOCFUTm0OHmlPbdYMxcAl3HHC1YnJwt6CJBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2303
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dAWFjvhKy4b34Ij60dHl6wFnx4520388AA=
Content-Type: multipart/mixed; boundary="pRaDDRjlsBFjxznOfYaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606350355;
 bh=UWv6481b9cOw9x7u/Ynlc1mYI6TvqzZdfRpIuBhDGHQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EXUK90tBXIuQt+dQARuVXmjGQqG+AUdsEvv2vM8mp0Q/BjZJjjAUklGAjJO9CnLfqzg
 URwP5CmkuamE6B6sh7HB30wkt167K3d3wC+WSjaoZBgbiVNeHc4X8xPbnkDZ1Gb1PNs+Z
 R3qL5siuJAtm89j7kn5h1pHljespqpE7+zs=

--pRaDDRjlsBFjxznOfYaW
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D11&day=3D26&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/11/cip.2020-11-19-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether SUNKBD is still used or not wrt CVE-2020-25669 - iwamats=
u

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--pRaDDRjlsBFjxznOfYaW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5880): https://lists.cip-project.org/g/cip-dev/message=
/5880
Mute This Topic: https://lists.cip-project.org/mt/78512961/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pRaDDRjlsBFjxznOfYaW--
