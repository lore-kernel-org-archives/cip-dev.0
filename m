Return-Path: <SRS0=vaJ5=H6=lists.cip-project.org=bounce+64572+6202+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2ACC433DB
	for <cip-dev@archiver.kernel.org>; Sun, 28 Feb 2021 23:28:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2578E64DCF
	for <cip-dev@archiver.kernel.org>; Sun, 28 Feb 2021 23:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2578E64DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6202+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 92U7YY4521723xJo11DGwWuz; Sun, 28 Feb 2021 15:28:32 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web08.5154.1614554909805413389
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Feb 2021 15:28:31 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11SNS16S018309; Mon, 1 Mar 2021 08:28:01 +0900
X-Iguazu-Qid: 2wGqsXjpwft6zmUnaK
X-Iguazu-QSIG: v=2; s=0; t=1614554881; q=2wGqsXjpwft6zmUnaK; m=w3fAMqOtpcvYgYAneb0CAW+q/WK1UJl7EWiyI4WPhPk=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 11SNRwdf038785
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 1 Mar 2021 08:27:59 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 625DB100083;
	Mon,  1 Mar 2021 08:27:58 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 11SNRv3d026011;
	Mon, 1 Mar 2021 08:27:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqx8y7xyN11JjSsMiYKznsQfQMOm5cDkVOA0OZPXhFBk6mTpCIBlfuM/qzgufnOdND3s0q4GdIa9dtWyWQHaAWyBDvOcB1OlcIeYh9im1+yMyQTgjwq4504i49lqh7Df3uos16z2eO9KeRaopunrR4HynzYSTiPchB89Y9xDl4yVPUCD78i2KM+Hs686W3ZNquSncIQXf0GItJqriknXDIG7BYwjImL5oDmuC5Tm+boY7uPEwHApPUqiOm8+fB0QJNBFjQEjhQIYNgO/Q1/OFrcTqEA+EEWc6BUq+e1yGLQwTV+EHVOginTW3r4KmSD92I9u2m+RCOakXCyK1CdyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W6F0+knPioaIWb/dUtY1wYimTLQ7XfKG/r/r/iK8fM=;
 b=OYnI093D22Z46bKC9k7su9pM17MsEsEkVkH2YtadQhLxmCuk8R+qYS4uTSsCUjw5WsQjP13WNSOSxxV3fRoIIKJbiMAzxdmB2uvYmCRFOEpr8lWRf6U85JQqjvxw/0QJTn8oLir1d3Yw1cWmuuMx91SeJVpwG+PL1J4rvIxJPep1dGN/5IA+IaNFszyXik00e9oP18V6Qm12OX1gGxJJ18+B2glkSKHhrGXg8AnurhAV3IC7VZMTBR56pTMfpurQVKVMWRUFDRmdGhE7iS74grAf017bCP7EUrleiAo5r8mt69nHXKd62V3waE/GY6iEgFB3EXg2hqcJnB8sKeF0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <wens@csie.org>, <Chris.Paterson2@renesas.com>,
        <masashi.kudo@cybertrust.co.jp>, <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.177-cip44
Thread-Topic: [ANNOUNCE] Release v4.19.177-cip44
Thread-Index: AdcOJ+veHm1qhgTCQPO06etUABNF2w==
Date: Sun, 28 Feb 2021 23:27:40 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB2990DAE24A3152118E57A358929B9@TYAPR01MB2990.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37ec3318-4a1d-4a42-55a8-08d8dc4070f1
x-ms-traffictypediagnostic: TY2PR01MB5258:
x-ms-exchange-minimumurldomainage: kernel.org#8759
x-microsoft-antispam-prvs: <TY2PR01MB52587792F8E6F955780676B1929B9@TY2PR01MB5258.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsm6/6zQIDZwbV6PBp40Np5As4IonX6+lGMZDBe3NQjy0VXfF23ay3zTssPmtNd4nP5x/y0Fes33bqz/vgCWYQnTuPZEGQbQlG8ZXs1iqVrSUwUMmBg5HY5gyoCmZEl9UUj6sQRYwrclyAwRxQldcZEjpgIyKAMNub9B09p/Qsfl2r/lu075fqCMpJYLai3S/paDwRAbNjfh1ICodzhphEBKsl8fFkMcxzPGXCcDDqU5pTkIOKf8C9PiARTOZxEucn2tNLTXj3CO5jQrgkQWpHTlpzi7tEB5quSqFQkS/7x2wtFLzwFJbv8PrOuh2gqYYUXTqvD/+E6VzJ4AnYelbN36zi+STdAxYT9xxxt9AUkBUEUt8N6u4c6Srg//rfeFruS2qGV8Og36wWvFm+uh6q0xJebNVDRIb2cJD5sKOxNMYLFHhSjRd6iNeChJ8ob1U0oheJj+OUf5ELYwekTiH/BYKT/BSwogzjefguciQsvLmI6I1oaykjntVNaylDMeOC8UeqQbxChBfIafxVXbLUN8uIIuakTLydKozUqKUnO5kYniUHPJm808v5+NLJC7HhYpLrUojHSsqMMKzhhnP/4GLblwuXzJJEDOq1fBPmA=
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWRWNlFNbzArZFB5QVh3c09kNUNBMGJGdUlhMlJGckJMN2tHL1ZiYmdVSWFn?=
 =?utf-8?B?NzJ5enh2UC83WVlESzRwT3B0ZXY0WU03bDZjdzVLUVZ5UjNQRjdmaDMrY0xa?=
 =?utf-8?B?U3ZGb2pweGRxZmZoMm16OEpDRzVjM0gzNTVrdXhQeE1aaHJTUVE4c2tjTnJs?=
 =?utf-8?B?aXVYYVhkVDhrb2I1TXdOcEJSQ3NCcm4zZGFHdlg2bmdpMmpPa2VaK2NHckVU?=
 =?utf-8?B?UE1sajNTL1FYOVZCMGJLdHY2RmxsTU9hYzBiM1R2SVY2b0poT2hjc1F4bjVu?=
 =?utf-8?B?TWZTeGxLSkl0ekVyeEY0eWJJQTlJeFo0dlVNLzNVK2luTGZualJiaURMWEJI?=
 =?utf-8?B?b3B1KzhQcUJaeFRSdm1kL1BjTUFuTXM3K3JYaE50Y1hDTEpXeVNYK25rWlpr?=
 =?utf-8?B?aGU0S3NMd0VRd3hIRk52amV6dlc0Ynp2ZGQ1bnlHaVdOd0krdEpCSmE2VGE1?=
 =?utf-8?B?M1NhakljY2ZzVWhzc2FUTUdrZzMxVkFaWnZuSEZ0eFhyU1g1b1lVRmh5SFFh?=
 =?utf-8?B?Q0N5bVlrOWFXNzcxWmZJOUY0S3hEclZtZURIM0VrU0ZVYnlaWUYyVmpaWWh0?=
 =?utf-8?B?dCtwZGU3enJqamNCMzQ3UFd4OUxkTkl1bjRzQzFtZzNQVkgwWC9LSU1udXNO?=
 =?utf-8?B?TG5mVFVVaWQ0dGw2NTRhRVE4SDdCNHRDV3Y0OFNDc2xJNllKc1VjNy9kZGtu?=
 =?utf-8?B?OGFnb3BacXN2Nkp4aGV0UzZkUk9iZ09tcXBaWlp5cm5yN2RFUDFqZmFOQW93?=
 =?utf-8?B?VmVjd2U2bzkxNkUvVFc1SUJBZjJzYW95T2ZpT1FmZjh6Rldzb2w1ZGJjTVhr?=
 =?utf-8?B?Y2JObDdoY2lGMTY4dDh2MzhBN2tXY1hia1k5L1E4UVQralFudnExaElZcWYw?=
 =?utf-8?B?eTJUSzllcCs3a1hIOTdkeTRWbGYwZEIyRjNRL3RyNTFtdnBhL2J6dFdCMU5S?=
 =?utf-8?B?cWRQZnBERDdCdlVMOURHaHMrdURHRzhrY1ozcTNiL01yeE5mRnRUYVRZQU9j?=
 =?utf-8?B?UTdZeWJLZ3NmRkJFL1dWRVV0eDFnK2dFMmRMWGV5eHAxbi9yblI1eStlSjh1?=
 =?utf-8?B?NG1LcHpaR2pPek9aYnR5RG5tMk9TOWdvL1VnOFZuZ3ZuWmJhTEVWQ2xsN0ty?=
 =?utf-8?B?SDl3ZHpYeGN1WjZHNFJtd0VDN2xRcGJPOHo1ODJkM2hqRVF2YkNDTkhhY3ZU?=
 =?utf-8?B?WU9xUGhWWFpsNFNYcExDSnN4ckJGamhraWtGRWN3NGd2NEg5TlJsTHB3d0RY?=
 =?utf-8?B?Y293WDJKcG4rNTdhbVl6MHBCc1JLZ080TjQ3Mzk0WEl3N0JJZGZTUjNLZjVH?=
 =?utf-8?B?dGlFNW1JZHlTY1VVVlBzRHZ0ZUtlUWRSd2VORE1tVjEvRTRBdGY3bEJXRmd4?=
 =?utf-8?B?M2k0TERkZ2RyS0V2dzdNZmpJUWp5ZERQbm9qRWlkY3Rhemc1Sk9kbUlYdVpi?=
 =?utf-8?B?QklGN1hIU1JNN080dGRmUFZuUnk5VGM1VkVxOCtWbVZuQ0dXZzl5a1VQOEgv?=
 =?utf-8?B?RDM5SVVaZEZBMzdoVkdCdkw2RG5DWGsxdmJGOU83b1dMS0gxWFBjdHl3QzR5?=
 =?utf-8?B?cTdZWXdUVXZoZUdNKzRta3V4Ymw0Mi8xZE1ta0s0V2grNG1zc1Rwc0FlWS9t?=
 =?utf-8?B?OGpBNTM5Y2M0bXZZc1F5dUJ2U2g4NW9WM1ZSNkNsMlZYTk9zZXN3c2tWMXZM?=
 =?utf-8?B?NGpNajIxUjdVQ3E2MDFURWlYSWZsOEM5b21LZkJUSlRsT3Z5U21KWW56UjlI?=
 =?utf-8?Q?8qZpUrMRiYRylim1Cc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2990.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ec3318-4a1d-4a42-55a8-08d8dc4070f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 23:27:40.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgrTZglWVWpYkEo7gl8mqV8li23UD7FyMymTNeXiJv7aC+QkoPZLOfgv86dDKEx3pyWhMhPLHKGvE0NndiOqKL5sQN2OJw3HBMxdCGeSy33+gQdByy3nqPLSu2OvttcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5258
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jfy1vG75ZlFzNahJT95FdVipx4520388AA=
Content-Type: multipart/mixed; boundary="GjOUqHxO4dLbfvCc3t0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614554912;
 bh=g56/noUi41aZaXzOt2AT4TteqSpNOSfIorzXIUaCz6c=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=QtSDxNW1+JBPtCXWf1SrR+fkqVX/2uJ8Xbn1R6sEwv42MixF/8nbKIvjbr2kcNEmCPz
 EIDtOagl8NeY6ns1WjG8Z6MVpT+6Riy6XVEq0vlIjJZxs73kh19sVhKKsOxT7o3lJc9X7
 cmRfEi+QKOGG/E41xJ42ZDW00iRcwwFKuxU=

--GjOUqHxO4dLbfvCc3t0o
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE3
Ny1jaXA0NC4NClRoaXMgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0
LjE5LjE3NSB0byB2NC4xOS4xNzcuDQoNCllvdSBjYW4gZ2V0IHRoaXMgcmVsZWFzZSB2aWEgdGhl
IGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE3Ny1jaXA0NDoNCiAgICByZXBvc2l0b3J5Og0KICAg
ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xp
bnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjE5LnktY2lwDQogICAgY29t
bWl0IGhhc2g6DQogICAgICBlNDhjMTgyMTEzNTU1NjY5YTAzZWMxMzA1MGVlZDAxZDFkYzY2ZTlm
DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0byAt
Y2lwNDQgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVzdCByZWdhcmRzLA0KICAgTm9idWhp
cm8NCg==

--GjOUqHxO4dLbfvCc3t0o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6202): https://lists.cip-project.org/g/cip-dev/message=
/6202
Mute This Topic: https://lists.cip-project.org/mt/80984922/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GjOUqHxO4dLbfvCc3t0o--
