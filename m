Return-Path: <SRS0=iMf0=A3=lists.cip-project.org=bounce+64572+4929+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C04C433EB
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95FD20791
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WmpWLG98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95FD20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4929+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iBh1YY4521723xB8aZ0aY240; Wed, 15 Jul 2020 18:29:56 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.92])
 by mx.groups.io with SMTP id smtpd.web10.6523.1594862994094109600
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2020 18:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLqegXYB+LE2imPRx/VceqGrYNf0UZCWefO/y0Ng1EyAMV7BOFyyIkpl4TgLoEBcUrvsCadoqq5Qf0v/OAP9S8pxfyw9u4cRrYLE/WpF0HwrS7Gq6z6a6FwulrC2sDMsIuVQsAUg85ZhwLThDUlTMKFI3JnK+aNfOTSYc+tZOcStIBQMFqQoQCpGlc+r5rfWUF31ASxUZlWevKOTQvlgdzc/Sb+1hdy0F6k1jZvLZCaEZIBKDVHCdxS4czVhueOtRCsi9b92sf4RLP8gXWjqG9OAM/B+iBNSkZbZZcQccWRE2rqxeIVRiEbUbHtDbvb67pPEEKUTLpoF6igrrzUDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd5pFDAUmsujjnpmHRKnnbhWtZ2tFXIVpCjQnY/kV2w=;
 b=FEVl02xjzHRB50BNmev1Zb+ZgbWVqiYpxy4vpdPCwcq9kXPozWM0gA9ZRFdkBP0vFcCtw81Etau/5WD8qX/q7n3OlVDEsUt1wMakYqhkDqGwENiYm9goePZ+juBa57ng81iAZOFcoYeeK7miCsiqqOUUdtECdIWAvDVLobPhYfDdBxJ7kf1EZ8kO2m9zU8M2LieuihhFLQvc+qLyDtR4zmVhdJooUTxqDrP4mNcsNjMEl35SsoaZIqkySKZZHAf72RYZ3l+hf4GZc+tC/CDCvON985F3W7ohAqMvHFWO57UH4tr2inv+6GjjosgPRtBRi1xfEHcuznsEFKGhDsHNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2889.jpnprd01.prod.outlook.com (2603:1096:404:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 01:29:34 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 01:29:34 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZbEHjVmr+4nIOmTZuqD6Y282OipA==
Date: Thu, 16 Jul 2020 01:29:34 +0000
Message-ID: 
 <TY2PR01MB497247C1E04F817F6E364E73A07F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 595621c0-ca62-4f10-2ae7-08d82927b24d
x-ms-traffictypediagnostic: TY2PR01MB2889:
x-microsoft-antispam-prvs: 
 <TY2PR01MB28897325B43419FA8C48BBF9A07F0@TY2PR01MB2889.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 YvLJMYPOAtn3VTZUFMHIVv1NXkia15/dENxY5S39JAFCR4KcLR5TlDimcnMBP+U08ME11UkxF5Jz/hRU+1qoKP6kgoJCQogJ9zvRrv22438hMAYX/dqomPk7ZMbZsTnqv1mG7gY61sjxcxJrqYacHP8Jmach3ywXTzI0AncPMSTDFOA94nejwk+lBluUzZ8AKYLTLzU21Gq8xcASeU8tgmOhOcfstrJxxDijNxMRIuaL1qG1gi/VjF91++r0lYEKYRwGEQJbzYe4cTjZCPNHvG0/+LGHb3Tci2e7dsDZrPLxswkpsNNx+62yt7gr3CG12DPAUCLhSepPZCO9EXrhLCePyQdOWL/gdWelwq3dUCogGI/jjjvBLU/J/Fgt6z5Ok1PsuYJzDBogS5XKPg2/Zw==
x-ms-exchange-antispam-messagedata: 
 2542QBpwF1LrPiQOnf7XNaGlDpVgFdoho+Ji3P1xyIogT+9gaW86rpYXOmV36HVyaFN6IqB/dcmPuQijvQq/C4f4EGo8HuoirSVaTCYfaOHazxJbPWkeG3UHDE/h3hDGo0HwC/WlTSOmO6pc2d5OMDM2W3t5pnVDj6teEqWEb2f+z+aiX/Qab8zh1TUJ9OfhH1d2ufMJwhDow3Xne7AOyA3oNqTSEH8rwtDqaJoAe06DvQIbPr2c+WvCsWu41305b/RZmb9wktxlL6/ukAMsWsN/SzWpTmM6rVdMx+lArp8foJTTiq9HgaGgNVl/s/zITvEv8c4dChNJTs8B2MQeTg5gOdQVusVrF341/Bq6+ehB3NGZR9BSdIrksDcgYhN6SVc5b9R3/KzDymUbcptTXaaL7daspTDY9W/O5hfqv8i5l2qwexaqy5ellk23NOh15mmYrojvaFdQNMu85nNpQuUh7L3zRXtVdaGdnHqYEkgxBs+7TIpIshVmkx0FE3YB
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595621c0-ca62-4f10-2ae7-08d82927b24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 01:29:34.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwKDkTY/DqGCPbmNQG1fJZwzXfYpwqFquFLGD76UYbeOj5cYCP2NRnYRnIU1QSHGkLTKDzabLea3PyejSLOrJww5Iu1jz0LCN8aSvIpYc8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2889
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eS0ho94jMiLeB8GSJezCxXs1x4520388AA=
Content-Type: multipart/mixed; boundary="mTMtP6YouddZV0ICCMbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594862996;
 bh=Pl0KYzc2cgd9b5qVClplL6Fx+c5QEAXDtZvkQlpOU70=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WmpWLG98MeFgvoV80SFSsdJ0Oa0zbzFAl6dhEdk6K1djOuuLSdSw7zgWXJkNfBzx4r8
 zNcSjQDGboW+uVFLe5Amw3KLPBSn1OCKebbSyOc/O482K8zexxm882yuYCXFEUuHMCRZ2
 qdexs9vajBiFA7ZDhVetYm/nL6eTRtlqaUc=

--mTMtP6YouddZV0ICCMbP
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D16&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-09-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

* Kernel maintenance updates
* Kernel testing
* Software update
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--mTMtP6YouddZV0ICCMbP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4929): https://lists.cip-project.org/g/cip-dev/message=
/4929
Mute This Topic: https://lists.cip-project.org/mt/75533779/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mTMtP6YouddZV0ICCMbP--
