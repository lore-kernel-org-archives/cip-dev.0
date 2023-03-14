Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F5C6FD1C
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 07:46:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.3545.1678779950821189905
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Mar 2023 00:45:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 32E7jl9V026539; Tue, 14 Mar 2023 16:45:48 +0900
X-Iguazu-Qid: 34trEg1Q6XVYl8iVU5
X-Iguazu-QSIG: v=2; s=0; t=1678779947; q=34trEg1Q6XVYl8iVU5; m=mhvlR01RsvupWRpoMT9778x4hTQx1iN8nrFlw74PmOA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 32E7jkOW040705
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Mar 2023 16:45:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJa3LtkKOvRq1XyKcdGzGNt83QW5zIewR4dJIHVlrLUJM/84Jk6iGbDrw82WuqWk0OOwHoqDd1ah13OwwW9YLwnoMleZcU5hBpmtfefUbK/ZXHrLoPafqS700uo3/Y6ivefyVcmi3aO+sHAgubS0rJo4vOh0tWiEeMd4c9u1TeYSLVBhVbalVksGHiqscRfLJEZCZXukXDp7LdgpGbRU6h8c8wO8VCRGZv0dFwm+rwBGtZz4RNIyBGCQNQMf5ZMwB/NHGVTv/DXHqO0iueJw5dv+aHHMy8HPwPkXkEb/zikL4MrMGZ7PxBFrtFQLlVGpqcyvw9SxjGgYVxyjW9yFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrKhK0lWxpj27qH2IFjhLhonfFe4MV6vOpeW66xnVfQ=;
 b=HnBV1aXFs5IrAKGpcXdS1iVEReYPAmgcvbsHAWWPCkmzCPlLtrqVFeiDXLHZGUQ5oy3YXznzyhq3yg+bAlUdJeXi00dCywymDhiv/7zlus5Ascv9r7hgCkqswuJX3DaASjAGnOEc5cFnuVxzbCvvX0zS01P93zVVAV6xtZG8VhbB4B7fTFyMKlxYngF39wYwq88FOXumkiheZdU4LmZNJcaWys8Yt3qcQP4xO/m3HAjRtBpHBde5lKhP7MjAU2d+IzCDbX4WmUiA8EywGtcvgXc5cEj+25Vaug2hWjCS+N3LBSpcSU75kF3aMcWebDMn2rW6sMPStL+XHycrdcArzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
        <christian.storm@siemens.com>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: FYI: efibootguard is available in bullseye-backports
Thread-Topic: FYI: efibootguard is available in bullseye-backports
Thread-Index: AdlWRyXxmxuTXKC0TIiQE9BuVT231w==
Date: Tue, 14 Mar 2023 07:45:43 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB8295463B41D4D1D9317FD779E1BE9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|TYWPR01MB10328:EE_
x-ms-office365-filtering-correlation-id: 72b6d258-74dd-4e56-96f5-08db24601dc6
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJIcFPivc9Jsd/V10T1CJWV+mJYoVNp4jMgG6wHB9nRXuPllNKvl962Jjz7oidxigEdTt8Z6e8YzmLfTF09Z9dlkeFLUwoSYcZllP28RWoARBuef0tAOKyu0l6uhAO8H5zUrmkxujn+vMrGrt9ZGHoSVbWCdCNWZWB4oSxQhL9lqmnCzw0pnzpdzm0TEcNfKz39tOkj8eQThq1XQ+ArjGb8NyaBU2eRZRIk7FKEtCX5PFw8j7LkF6boOGhu7P/l0vA0My8vu32wvl2Ux89Hmm7guVYwP/PuQqMH2YqDEELBY5ZllR9o3jVg+ynj6YcwukXBbC3dK6W0Y5XAWBuA86+yOb/kos4XtnXL2WzpD6wescusbu0rcToXTaGkNeglSkeNN3N0f668nPmkPMZ4pEylBXdnnZ5se0a3Jz+pmu6QnpM/PZjfpe3E4LSni2pCQGFIChz4sDNJFdneGmAizOy4yXFDGIEL/jTV/k8a96+9pS6zZp4iG6orUzPQbVG9RLhAIK9Yu9F4f/6vs3lHkFCJZ3wJwpNUicv0/vvSnfhmmBq6DPFkdTLOYmk4JUSkxceAB18ozMGIMV69PzyoZ0V4h1POzgM2esJ5A/Pa3pZAc0ZzChfaTUMUbbAINiKq5YjIPsksx/nr9VyzZZ2vhv/UT36REbuA36pT6G175dD4ox5dfexwef9s39n9bQQEj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(186003)(9686003)(6506007)(26005)(8936002)(83380400001)(52536014)(38100700002)(122000001)(4744005)(38070700005)(966005)(5660300002)(64756008)(33656002)(66446008)(66556008)(71200400001)(2906002)(7696005)(8676002)(76116006)(41300700001)(110136005)(66476007)(316002)(478600001)(55016003)(4326008)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UzZ5MHJYWEFyV25ET01Gbnp4eWdkdUY1V0I2R05Nc0ZMaXBIaVdiUk14?=
 =?iso-2022-jp?B?c0JxeXpneUZKbTUyemx6NzJ4N0JrOVgzZU5PRnpKL0ZlVzhCTE5LbWM0?=
 =?iso-2022-jp?B?TlFvMHVhVVBtaENYUmVYYi9uN3dlRlhGRmJPalk1U1R0WEZmMDk4SzU4?=
 =?iso-2022-jp?B?S1hDS3E3UG82WHNiZ1VIeGlFZHVFNzg1QnhYaTFWbENtWVl6eGRseVM2?=
 =?iso-2022-jp?B?ZTFYUCtDYjg0ZExqcEduODRzRDVYelkwMGk5bTJIMDZESDBDTGdmU0Mv?=
 =?iso-2022-jp?B?SmxHNkFZRWJXUFZHZDZLMjNlbmFnMnkxV0ZTdlpnQnc4NGkrN0YxWmFT?=
 =?iso-2022-jp?B?V1R1N3pnU2hGVXpwQjYydjJJRU56cS9tdVVXTmhGUUc0bFJqaWliUldo?=
 =?iso-2022-jp?B?Q3VaNEY3b1c5cCt5WXNCSFJ3cTg3R2R5SzkvcHNqcm9nbDlOQm9HMmZ5?=
 =?iso-2022-jp?B?MUNxbk5Dc01hV0VDNE4rczc2WWp5NmV0VlcvbFI3ekhIM2VXd3FnMmly?=
 =?iso-2022-jp?B?a09yaUQ4M0s1eDhxT2VJemt5UHg1MGxPdDJ4OFFQcmI4Z1plWEJzL1J5?=
 =?iso-2022-jp?B?SjB4MmtlUEZXU0pzdzJzSVFXZGorTFFydEhzRHBXUC8xTDgwbmsrV05G?=
 =?iso-2022-jp?B?dGMzQnVNZ0FkMCtHazFPcDdHMWo2Z09wUEdraHdtS3ZMaXZSQWF4TlFl?=
 =?iso-2022-jp?B?Z3ZNUDVmTFFkOFpweDBBS3MvK1BnUVNoOG54bUdlVmRVMEJ0c1JUcEZp?=
 =?iso-2022-jp?B?MkxQdTFGVjFtMjZ4STRPb0hrSVIva2RFNmx5WHF5WElUSHZ1eHdINkdw?=
 =?iso-2022-jp?B?amxCOG1GYTFEUW83aVpwbWdEWjdNMmtCTUZ0RVBrSGRvbmNYZ2Z3M244?=
 =?iso-2022-jp?B?R1h0Sjl0ajl6M0xQSS8xSEd5Nkd4UUExaHlYOVE2eitTaFNYNUhsNjhj?=
 =?iso-2022-jp?B?QktUMUxNMThXQzFPMWo0MG9EdllpWktmbS91RllHMWNLT2Ntb1ZXaVFN?=
 =?iso-2022-jp?B?ZzVnVG9VZWErR0tsekNaeHNBa2UwZW4zVGQzRitYOWFSVG5JWTJmU2tm?=
 =?iso-2022-jp?B?YVZXcW8yQkV6Z1E3RUM1TzZHTlgzWWNhNGhzUklXek1CZkppTWNRcjlS?=
 =?iso-2022-jp?B?MTJlK203aU9PMm50MzBZYUVsQU1iMWRmMVlpNElrbXY1Mi9UbDF3Ni9B?=
 =?iso-2022-jp?B?TFFLdlFCeVdnU3M3L0RPN2VydExNQ21vVmE2U2tlZitpT0VpZXl6bUoy?=
 =?iso-2022-jp?B?MGJybFNwYWxCOW9sem1mMjVnU1JndUduYXU3dkxPRXdCUlpKNXRESEZS?=
 =?iso-2022-jp?B?QmpiOThiTnBlaG1wb3BwWkxIbnVsTTBDdGpvL29lamRjeWpKaU1hZ3hP?=
 =?iso-2022-jp?B?OWxZaklRM1FDZHdBeFhvcHlTdUpsRzNLanN4L0l4UnEwVWh5ZWlZWW5q?=
 =?iso-2022-jp?B?Q2puUTg5QXFKOHN3QVY2ajUydnN3b2MzVml1Z2g4T1g3LzVmYWZqVzhU?=
 =?iso-2022-jp?B?UUErekJ5bWlXazRZSWVoMHlCc0M3NXUzL3ZGc0VMRVFtVWJBZDlyd3Qr?=
 =?iso-2022-jp?B?V005eG9hQ05QSy9kS2h5VzBYWjJJOGtEekZZYXpEWjA4ZDVrNkN5OTdq?=
 =?iso-2022-jp?B?WldnRmFSQXc2c2tDNE0xQzMrTzhCbnNIUkVFZ3RMSWEyNnVPb3EvcE1Y?=
 =?iso-2022-jp?B?bEpRWDIvY0YzWitzeHIzbjg5L0xiRTRjRG52WWNxNnJ4Q2ZvY29RWktr?=
 =?iso-2022-jp?B?SXNtRU5WckF6bnAwYkFSYkhBR09nNlArOWVzNjZvT0x6ZHBlZ3puSjhn?=
 =?iso-2022-jp?B?MGVYSWhPZ1R0VnZRL0g3WStLemtZRUlLYTZvVml4NWNURVppLzJlcWdm?=
 =?iso-2022-jp?B?WmM4NXpFNFdxMFRvdmp3UlJOTXpkc1RPbGIySHdSUjdvczJiYms3cDQw?=
 =?iso-2022-jp?B?UlpXUmhoaGttVUpTdWN5enVjRTJXSFk3TXljUkdjU0N3NWdCWmpnZDRV?=
 =?iso-2022-jp?B?SGdhWC9oRHFhTllJTUF0VjhUMU9MVmZaZmVwV082TEhaRmlPT1ZFMEkx?=
 =?iso-2022-jp?B?cEtISWI2a2lPUzF6U1Y0Z1NQTWMwNkx4Y3YzOGZqcG93OE1Rby9RRU9K?=
 =?iso-2022-jp?B?ZWxzRWZ3N2cydlArYWZWaTFHMWdOSnZ3WkVjdmZJNzlteE1pVHg5cFlo?=
 =?iso-2022-jp?B?dDRIVGFtQnlVMlByYmNJR3dodTM3OFZBRU45anRQRy9IeWxxMHpOWFpW?=
 =?iso-2022-jp?B?M243bWNHMk9NRWt3cXBENnFzUHFRSGg5angwanVqRExyQ1ErNVRMdkRB?=
 =?iso-2022-jp?B?V1dqZVJoQjZITExGc21UalRhV3lMMGdldXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b6d258-74dd-4e56-96f5-08db24601dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 07:45:43.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QbCIz6TrZJ5CF5wzhX+Io8hEOsGOEel1U4p1Y1RTt0QdAsR9kBAoJMwkI8kJIIqeyQdeYgYVOZXipE/wE6RZXtqiFpRDUhDl6QZZG9giIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10328
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 07:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11023

Hello Jan, Quirin, Christian,
CC: Iwamatsu-san,

Just for your information, based on our internal requests,
Iwamatsu-san uploaded efibootguard package (and its build dependencies)
to bullseye-backports [1] and it's now available.

In response to this, efibootguard is (will be) enabled in bullseye-backport=
s swupdate [2].
We internally tested the both (efibootguard and swupdate) in bullseye-backp=
orts
then confirm the basic A/B update is working.

Though backports packages are less maintained than the packages in the offi=
cial releases,
it would be that the packages are used more widely.
I'm not sure if you have plans to replace the current efibootguard/swupdate=
 in isar-cip-core by
backports ones from now, but let me know any possibilities.

[1] https://packages.debian.org/bullseye-backports/efibootguard
[2] https://salsa.debian.org/debian/swupdate/-/commit/6b833d909145c74c050e1=
934cc573c3b380d4f19

Best regards,
Kazu


