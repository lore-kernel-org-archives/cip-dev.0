Return-Path: <SRS0=MSQH=K2=lists.cip-project.org=bounce+64572+6485+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA542C47082
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 13:14:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C1961287
	for <cip-dev@archiver.kernel.org>; Mon, 31 May 2021 13:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C1961287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6485+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NSQtYY4521723xMetrVIchp6; Mon, 31 May 2021 06:14:47 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.43926.1622466884815769346
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 May 2021 06:14:46 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 14VDERXv004260; Mon, 31 May 2021 22:14:28 +0900
X-Iguazu-Qid: 2wGrbz1dNcZXudoT80
X-Iguazu-QSIG: v=2; s=0; t=1622466867; q=2wGrbz1dNcZXudoT80; m=lG3UPB34//91uYKVIdsJhlN8k58cgZREbERr0JVUoBE=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 14VDEQQj036407
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 31 May 2021 22:14:26 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1892F1000C0;
	Mon, 31 May 2021 22:14:26 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 14VDEPlE022165;
	Mon, 31 May 2021 22:14:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAertpFdz2hHI4CUvVBs1lDNilhu6RaWH1Q6hAtSc93XB0zbvaqZ7dGvy9C/7ibUACitUxhB7r3nRnCQQN/YK7RDoY/bRaC1z90ao8n1CDYPnU77/u3mUtidbs5/RSr1zdaU3oypgZ66TPH2e2i74TLUfRyPieYLjwGmd24A5Trpv9Z/h9jgisfcX3RWM+7eGsx1cIe8tDr8JmiiOycOjQ4z6tA6Xak3FggD+YjdBb6+ZpjVpxOg3TS9tEg5nvnT2wqAYMclUJyy6muh4t7z1oPPxzQXJCKA9v8zrB+ADVzcjW5pSQzNXx/aRiR9uukKRNhPzrNFsK9LaHb7a6jnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad933VB5/FuYrVvkiGicdMlabhq/zD5gGlaxvPHDYe4=;
 b=ISFjrUcko2hwWCj2uyW6W61UfML0VEOvdD0JxFyd14XySccSNd4YQTKrvWuJBwRlX3jzR94p2ujss7pbthx0f4HbV79/mGfCkWnjG3hL7MGGYZEq9f3jf8emtKNLRVQUPzt8xck8gvRGbqisttsLs4Kz0yBNHu9ev3BiGYUNmusFI+kfh4Li86odaRCU8xgsmieiZS6gZsELWnhLeL2dfhmk9eCaL6GZ76oijjQmR1P2TtCBkvSajWMjunCNJVUUxV8y4QSBowfshfisMmYVNqdv5pv8I8ER26YHV2WWm/+lBWTS883z6u8URpW25FpoLEXMx/6qUkieVFX2cG/3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <pavel@denx.de>,
        <chris.paterson2@renesas.com>, <wens@csie.org>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.192-cip50
Thread-Topic: [ANNOUNCE] Release v4.19.192-cip50
Thread-Index: AddWHo6a6cM8TrC7QFav1BfAjCGiBQ==
Date: Mon, 31 May 2021 13:13:31 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625269F3F9844C35A05B2911923F9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d6cc3b-3e0c-4663-fb69-08d92435e364
x-ms-traffictypediagnostic: TY2PR01MB3244:
x-microsoft-antispam-prvs: <TY2PR01MB32440EABC4658066E08AA4A8923F9@TY2PR01MB3244.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7TGyjU/HUAEAjQe3NwsroMZ4MrXRZ3KN7rOvA9B+P4GJeLx+undE38s1rms2JMluEV0e+f2mAXzxXGMmv8cmkw1Ot48hoYti1jG7Jiw6Qc9Y/5aag0slym9dLefCkGzCN+ucZAUY83DRDp/ZcF64gS7PkSbfl49By4FtSt5sM9niVnuNTeefi/aIWaQGi6HYdAVSW1TQE9Gm8lzlxQLiSphbnYAVNiXaxKi2J/MylEMz3AAHW4+GBd3ckMRn9HbUgxHa3nrS7ZQZ79vOBXWuPEnqgHuso/DKqY5gu4U1YdZvtm7n/B6OJm2bHz0c1L6tjpRsP9yencS7IUZkgeDL2V3y6WkB6g5oG/GPI443TmxBgdxurjNE7egzC5WqONffqsH9tuIqcRSQ+0ieHjVkh1oi49WaOOulhuOFPsefIkb7czUqjxB38SfGtnOVREYliL38dPoQaTTEeFc37TITlRNlAUnzrbESf6nP05A4CYTqleth4rWEUp21F/DK6V1tUpKiBRztd+q9QONUghsQ/QihlRfNqhQnUSDap/fqcz4h4mMAw9BrLLoIJpr6r0WumS7fLLLV+mabK8r3udqNAUPYbLci4A7E1VBJHGysfjvv4U6Kq5zeGonmv0p7XA5bLSmNXoVkfkhOmcoJUX9VyXSnjOyFDURfrWT2x4QEFA0JFklEUH7dXI/GYQkPrijRNh+vws972CMOiL7tEiAu0g==
x-ms-exchange-antispam-messagedata: =?utf-8?B?cjdOWGJIZ29oc2dLcU9GOWpzM0lWVE1oMm0yMk15S3hWQVdMbHhXdENhRHdy?=
 =?utf-8?B?SUoxNDVIeFV0QUpLVFpZQXllUlZiY0xyR3FYMGNiVVV3UFBaQ216WjFHeW9q?=
 =?utf-8?B?ZEk0amNiVU1INXBKMWtRMEFBVFZveXh2RWJiVmdIcGlwbGwrUDlSektKdUhH?=
 =?utf-8?B?cWpTVkp5MHdMT0VtdWVyRmd0Y1ErQXc5eGlqMlFWQVIrUVdNR2Q5ZHZSdjVa?=
 =?utf-8?B?dlNuV3NVdk90WXo3Y3Q4b0VtYTlHTURpTmR5VS9rMGt2WkQ4R2RLVkR6M25o?=
 =?utf-8?B?SUtvVm1SWndlUkVaKzhIdDAwbEkxNy9qYWVwQVl2c1hDT29ES1gyczF6NHMx?=
 =?utf-8?B?ZVg5c21ydHY3dW00UHNBRVV5Ukp4U1pGc1Jwcmx2WlVBaGpmYmZlaGlmVEtZ?=
 =?utf-8?B?a0NhWStSWSs0MmZxMlN5WENKRHFpQUhQNk9sMVJqNU03bzExT050VmlHK3dI?=
 =?utf-8?B?YVZURlYveVlsUncweVZ0WWRJUG1xd3JQMlZnc3BxSEY4NnVVbThOWkVrMURY?=
 =?utf-8?B?bUdTMlJ5U1FIc091cHJlSWlxZ1pndi9pVTFLUElZNmJWUXpFaVNNQVVISDdn?=
 =?utf-8?B?R0ZHdEJkTE9UYk1qMnBhZy9oc3FMRFRCdzN4clZieUVtMEh2M3ltVnJqMC8y?=
 =?utf-8?B?YXFXalU3RFlrTFNsUWFKSHRDS1JFclZXampyRTNlWUQ3T21wb3JTNHVkVTJW?=
 =?utf-8?B?MG1PbHVHUkNHM0NDbVZjZktqZTJhOGV3TFlyay91ZnBpMWVyT25wYVZDbEho?=
 =?utf-8?B?UkxTbUxWR01QSXJ1dnZEWFE4bFE5cUk2ZUF4UGtLdXV2SGxNUnUyZHVvV1RJ?=
 =?utf-8?B?aTVLVEpySjV3NmhCNmc5N08rMzU4MFpMMkhtSlFGdDh0aG8vN2JTajNWL1Bo?=
 =?utf-8?B?MW9LaUV4UjdWb1RaVkphV2VVQWhmMkgwN1FTRjdPc1FvNUpVTXBncUtKZHRs?=
 =?utf-8?B?eTMzSkRTYXNTMit2dllUY3F4WldCQ0ZjbEFsMzJrZnFSaXcxWStYUHN0OGFP?=
 =?utf-8?B?Si9RSWR6UUJPbVVUanBPTlYzR1c1ZVdpOU9RQ2tpNWNQd1lYNGdBNVJJUkIv?=
 =?utf-8?B?NVF3MmZkMUlHaExvMEswTVp0SGU2WEZySmxlODBhZmU4WlZmcWZFSWhXT3c4?=
 =?utf-8?B?MHVYZUpEbnY2RWNtaitxTk5MZUZaRHAyUlpJc1U5SnBnZ1pubWU3ZzJwOVpR?=
 =?utf-8?B?OWtHUlNKa0Z6TzI2Yi9KNjRoaEg2TnhvYzBOcmlRbFk3MmVjQnRZQWFVVlAx?=
 =?utf-8?B?MEJpeDhEN3ljdnZoVUpwSlh3dXdUc2Q1MHMyRkhEWHM4Slc5TEloR1JpWkZE?=
 =?utf-8?B?SFovdGVnZ0VJRTA2YlhENG9KYjEyU05MNVBMUnJmMjN6VmZoMXhRRTRuMkZl?=
 =?utf-8?B?UUtSOU1MNFVUYSs2STIxeENBTkN6QjFBb01QT3JyeVB3YUtLVG95ZnlmK3hh?=
 =?utf-8?B?SldVcmg4ekdteFJjVTQrTFl4REtjZWJsUW5HMzBmcnVvZ2tBS0xMSTVhdCtH?=
 =?utf-8?B?UWRzM0cyKzJncnlvQ2pQYTYzejRFUXlJSkZyVUN3OWV4WVJFMVBaU2ZNUHov?=
 =?utf-8?B?QXc4K29uczFvb0U5SFNMN0o1L3pQck9BQXdURU5EK1NTaXJvR21qeWlRTGpC?=
 =?utf-8?B?MUZzUVAzR2VGcFMzWXNMT2E2SFgvUHlNalJHSHovZ1VyNTNXL3hUOVllMElt?=
 =?utf-8?B?SzNSL1VzR2JKMllWRlRuU2s0VGQ5RDYyRjNMOHdERzhxKzQ3VjRQbmh4Ulp0?=
 =?utf-8?Q?qNOgdB9oTphUoIsH/4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6cc3b-3e0c-4663-fb69-08d92435e364
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:13:31.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf1cBednUclUT+03CLcb+elbbjv6MkUnvI/vC+YZvNz6GM6SDrGWcAS5c+j4P2xdtHSJfNuX9fTKNt2gZZ5SXZtomYbxhOO/LT+gKxEYTjdVn0DQ4Ftc8l0/n42j5eh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3244
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dsEwBryTK7kFMLXGHyjulKOvx4520388AA=
Content-Type: multipart/mixed; boundary="CbIrOjpv3Er9HyYLN9sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622466887;
 bh=bWncU3PrqJzQCIAz75yPxFhUiWOHrS5n5sgfijnZvS8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=NgaeZTiK2gzpY3gMHHiFg0uaAjtKnDM1wgVM2WTWnvrXMf00HdzGm3o7l5w74YY05d0
 isLN8ub/nB5pMOzrVXTu8FNCR0JlgLRpAFdxmc82AywJaJgrgpsthYobtRTy/vznECkRz
 +iIAVQDS/B4nc5uRvim44S5/jS64rb4sMus=

--CbIrOjpv3Er9HyYLN9sb
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xOTItY2lwNTAuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTkwDQp0byB2NC4xOS4xOTIuDQoNCllvdSBjYW4gZ2V0
IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE5Mi1jaXA1MDoN
CiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51
eC00LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICBiMDcyMDhmNmNkNTY2NGZhM2Ey
ZTVjNzQwM2RmZDNhMjdlZjVkYWFjDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVt
cCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNTAgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVz
dCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg0K

--CbIrOjpv3Er9HyYLN9sb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6485): https://lists.cip-project.org/g/cip-dev/message=
/6485
Mute This Topic: https://lists.cip-project.org/mt/83209309/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CbIrOjpv3Er9HyYLN9sb--
