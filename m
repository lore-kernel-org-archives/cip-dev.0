Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4403C433F5
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 07:37:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.88833.1638344218739452771
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 23:37:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1B17ab2Z031352;
 Wed, 1 Dec 2021 16:36:37 +0900
X-Iguazu-Qid: 2wHH6YFlXy71pZ7jrW
X-Iguazu-QSIG: v=2; s=0; t=1638344196; q=2wHH6YFlXy71pZ7jrW;
 m=WINWsrGiXkLXnGr1UHE+pzFquGZafPo/gZNrVbhDJfg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 1B17aX7o026833
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Dec 2021 16:36:33 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 9AE8C1000D3;
	Wed,  1 Dec 2021 16:36:33 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1B17aXHV030750;
	Wed, 1 Dec 2021 16:36:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huWpPmgesjB4S+oAKSICxTVa/PolKTqXk4Ki/Fxv2g+ppqA3R9P/xxVu6y24otSSnzCDRpMzmGxEjtTj87CQjehGhBjRb3TgalzgwWWR/3rnNIB2fqdCKL3nPcVgS5GBulZRKrzXbG2P9icPa181WblvHK8Z0nwx9ipas0VQ9DQjFsA1J5j+zPPHrawlkSV38EJNSwpTKFLnc/FODffRCogvslulihFoKISJGNhwxaViUFN7kz9Txk0AGBm5MuXLYIUPVVEACtpPVRbpn5WVzMHKzeCyggRN1sNCzb+cbR1jUr8Eb3qSM1rAM6YKvmiuV1hM+OnDSHd+qgufHqsyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCy+BWuMRluCmVJIS81VresjYo8aZcNcQNlB6OZBgac=;
 b=ihaNM/umfU9sb8Ae/QE4HN+fwNF3zzTimnSz/X1OJGQC2NRJchoTOexD/2Mb3jQkVtAlC8aA3BszCS0/yAZtv4TftA4vevnpfuJroWTCppSXEyx7Zv35i7ZZ2Ws1TtwTEd9BAkczeibmZuAg22PTHho8hH6Hgf1ew9GhHYdiZx/9BAKRWuArMvSuTEQ/fPadGekvsSaDhcG2h8gXvr9a7Ck4ZKYblxamDECorXHbVjZowb1kcATG5CJv+zJ96e2U8CkMS2GO8MblKD4EXEVfUQXarIuwYf789NiVRuBk0Ud02E8b2PVltIBwJrNUHoSJXPe/gyAVzqHqjZGOaQ2AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.19.217-cip62
Thread-Topic: [ANNOUNCE] Release v4.19.217-cip62
Thread-Index: AQHX5oYVK+xBUSrxm0KAegaN7eblhw==
Date: Wed, 1 Dec 2021 07:36:31 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252E819CB2A588B05DF0A8692689@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9d4d69ae-4e3b-1c17-03d3-2b146cca46e5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2997ad59-6be7-4a44-1ebd-08d9b49d4b09
x-ms-traffictypediagnostic: TY1PR01MB1546:
x-microsoft-antispam-prvs: 
 <TY1PR01MB15465174C7EBAF2497E8FDCB92689@TY1PR01MB1546.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MUp4uhtLybwATmMzrky2nv9PhGnRrpf3eU72TX9b9oTP5hShXZs2bUm/ZGV+/lw8iR6pf1qHbbr+PWIih3yy6Kd1r5Ktr2aPMyeiYUpcXH6K6lgkeuiF3CYY8b2LAkMIoI/YmIFpfA+9ggm7+EGz35uSWGw2kFXcoPizaCSJ/v3ZTXiSf5yYt49cnlDkxMUU3k/iCfVJ3M+lBkDJ2CcPISJr5E/dWm7/kXX6alpXgqsdHzo4WyM2lcAKB1lUTOQKHaENBrmi5TYZQd4OEka77OdZ06hE+o5jUSw0dGVNthW30/CyIXyQoJUSLN9S6VWy9UYk0JEtp4b4E2zo3QOFT2N5uhPRSmiL4Ap1HRik7153nUWXY8KYLvnwFKCG/OrDw11N+k28gcTvQFnjykaRzGwRfqPZmC5lFStUDN4/qwkkHr+XEOXDWsqh9x6PWDaxjafA6kZ0veS0s0uFeg7fgSLBzerhZ4Lx9GEV8Da968eI7NOo13cKk4E5M3z6uLHZEoDOfyvLFw+VB9/zAWlCPSUt2uMOenl2fUMem8IbODqrc1gfuAEemybwlYUePPsB3xeDThYiRjM8lllifi08/BzMfjgb0cp3uJwDeSmCJGPigOSKSSiB5vnt463Kx0OgNpKlT3RiO/seMAQy2IZyW0lG/5LhcWOccjYLW8zTT3iymYV05ZnPoADzsrsS/T0uxTQYXdnX9DMvNihXUl0sEb0Wpm8fBQmW5q+M2mTHCKeUwuRQtoUGpYyw/DDqPVVDfolyE2ijH+CA8J0LYAV1aUKbS2OzaSUd4LJUz1Xu4LQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(508600001)(26005)(33656002)(38100700002)(8676002)(6916009)(6506007)(4326008)(4744005)(966005)(7696005)(122000001)(5660300002)(64756008)(66556008)(55016003)(316002)(8936002)(66476007)(38070700005)(52536014)(66446008)(54906003)(2906002)(76116006)(66946007)(9686003)(86362001)(71200400001)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bWhxWUhtcEZtS3JYdy9zTUlaZCtpQXdlUnArTW93Zy9VTUhGTkxwNkh4?=
 =?iso-2022-jp?B?aGZMbEJaVVR4RFlJTEpYbWpwbmpldURqdW95OXJ5U1BMdDNmakdKRThF?=
 =?iso-2022-jp?B?RHZENlhoa2s2Y0JnZWczRGo5Z3dHZjZhZFVDK1RwMlZhQXJUdTl2YkF5?=
 =?iso-2022-jp?B?Z0xwWUhNdU5HNjJ2dk5qdGZkN1FLdGlVamwyMmNoUlhyM1lrVHhHMWZB?=
 =?iso-2022-jp?B?czVtYjEvK2NNWVdMU3E2V3l4V28zM21MVUoyL1MvVXlxZU0vOVRNSnFX?=
 =?iso-2022-jp?B?M3d1MFVRTFU2cVBZNmE0L244TXREY0lISy9ES0o4eVVKNGtsWklldlZF?=
 =?iso-2022-jp?B?bXg2TWtRalIwVnR6MHduNFJ1UkVBZE5pNi9XS01SbndMSjBjRWVqZXhl?=
 =?iso-2022-jp?B?dllaTDdJckxPaUhmbFZpbE56NUlqbGlDdFVZcXBwbW9CcmxOcFlNLzI0?=
 =?iso-2022-jp?B?d3dlTHV2ZWRuMHZTc05HczhmN2JkbnBRUGlha1U1RGFuUk0xOFZkY0d1?=
 =?iso-2022-jp?B?NXRPb3Y5djNvRWk4TzhsV2FRZVRaQ1NOTXZ1cVYzb2hhaUZtU1JTWC9j?=
 =?iso-2022-jp?B?bWRXV0FseURQVG9uZitqT05NeXZaQVB2ck1SMjJPRm5ZRmRieXNwNm9G?=
 =?iso-2022-jp?B?WW9NcXNRVHZtclFkN3MwZVBCZXE1Qm40Tm5lWHd0STNkbmdrOHdKWWkw?=
 =?iso-2022-jp?B?a1BFbm9zRThIYUV5VFFoQTE2bEwyZXBMMFEraWFyOEc3WEE3aThtWmtv?=
 =?iso-2022-jp?B?bFlMVW5sTlhFdjBxQTVNL21WUWk0bDJXZkdTNWhoZVB4dGR2WEFTSk9z?=
 =?iso-2022-jp?B?U0JtS1dxWEN4Y0QxQ2NKNDh5NzNXem9FMzdKd3Z5VktiQytUd25YU01z?=
 =?iso-2022-jp?B?Vjl5VDJVdkRPNFhjYlo1NUgrd0F5WVpMS2M4NWs4SnJhditpODRFTk9y?=
 =?iso-2022-jp?B?MmtZdWNzK0VXUXVpQnRVRlc4TFA5VEkrWUttbUwvSWcwbkVRaFowelZx?=
 =?iso-2022-jp?B?Z2NSNlVuR0ZrWHBXR2F3RE5JeERwdGk0ZW5acEJYZjVVbmFMR29aV2Vy?=
 =?iso-2022-jp?B?OTJpTkRBSHhtQWJuNmxZZGR3WmJKRm5IVExTaWRSZVdKWFF1N2M0N25r?=
 =?iso-2022-jp?B?bHlNRG16US9zV0NNODIxZ3N4N3loL0xhd1JMRUlQaDdZdVlVMEpSSTFz?=
 =?iso-2022-jp?B?dW10OUw1cVN5S0dzK2c1NFg5RWltMEVleEJTQVFMTHBQeEs4WFozN0M2?=
 =?iso-2022-jp?B?TUlKNzhudk93TVAzVWNnLzFVVDhMN3kvbDh3RlZHTGVCZnFHcjlURGVV?=
 =?iso-2022-jp?B?eTRTQWpVbUcya3dFWGo0K2h1NGZEQjZoYzFhVkM0QnlwaXFVNkFtV1BM?=
 =?iso-2022-jp?B?SUs4bzRRSjlQT1hwR2d0d0FRV1kwMXc2MVpOdEFPMUtuM2ZBK0o2MEZY?=
 =?iso-2022-jp?B?Wk5lbDZqck9GZVh4ck5MR1FUa2haWHl2NXRrYjFTWVFDNmtlNGdZR2Vj?=
 =?iso-2022-jp?B?VXhIYytoL2YrSGx1a2pFUnR6MGF4NnVWTzd3SCs4T0tpUDRyRzk1eTh5?=
 =?iso-2022-jp?B?NHdwaEtBY1BoU1o1OWhDb1VkaVM4aHMwT1pISFdmR1EzMEdwUUl1VEQ1?=
 =?iso-2022-jp?B?b08rMGV3QWQ4MWptZ3RjVlBmRWNzcFNjTXpWWURWSkV6YndNTFRnSWpy?=
 =?iso-2022-jp?B?ZGR3alNPTzEyRndFc1dza2pQWTBYZWRRN1VZZzhjV1JhTkZmSWY0Zjhs?=
 =?iso-2022-jp?B?bS80OHpHVzlVSHQydTg1c0NtVEVZNVVCSTk1UkJRNGtLRlh4WnNZRkpv?=
 =?iso-2022-jp?B?K0M0OHIwSGI5SUt2elN0eTMzQlJSWCtUdnJSNk1wWTN3T0x0NEpaV3No?=
 =?iso-2022-jp?B?K3IwblJtZ2xiNU1MaEdQaUF6QXZKTjlwbjBUM1pDcW5YbUNhdXJ4SmE3?=
 =?iso-2022-jp?B?NHRlMllXMmVKYUh0TytVMFBrRWQ3THNoMVo2ZWdtMlVvUUJmV1R6REhQ?=
 =?iso-2022-jp?B?TXhSUXlnLzZ3OG1iYWZUUnRaM3hnWDZxZWN6a3YrTHRKWWdsVHdoR1k3?=
 =?iso-2022-jp?B?YXROVm5BMnZzRVF6Rnc5Qm9kSXp3Y0JiMGJBRFdxeGtwb3ppTm14eEpG?=
 =?iso-2022-jp?B?OW5DYUxmQlFEb3RhNUUrZDJoR1BHcEdBYnB6WXN3NVV5RUlqYUNRRWhr?=
 =?iso-2022-jp?B?VlBpcXVDT2RlWXZ5VFZCS0dNc0N5WThQYXdleDdUUWhKZ0Q4Wm9ackVF?=
 =?iso-2022-jp?B?diswNjBhQXk2THhHUzA0Qk9kc2JhSjlVZ0p5S2M4emI1b2w0ejNpR2Ny?=
 =?iso-2022-jp?B?K3Q1aUwzUEkxaFBvdmcxR3pkMGhrRVF3QkNlbjBvUXlNRzdVU3FiR0Fq?=
 =?iso-2022-jp?B?R0szYWxwWVNDc0FGcUpiUWRIZ3REbTRTMDdSQWZBUlBtRkRTNS9NM2NO?=
 =?iso-2022-jp?B?ZnRSeCtyYncxY1JIVWZ1L2JqNUFKaWx6MkExUndHaXU0a3hCMXF5R3Bt?=
 =?iso-2022-jp?B?bENOMDFD?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2997ad59-6be7-4a44-1ebd-08d9b49d4b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 07:36:31.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 qTxilmNvgNKo/kbJVu58cwvbXipoehTePBSJIZSOd1nFBHRBzE86HJDepOZj1O/04PqdI6cIKljyJTtM5Z/yGPm8YDfM8jmMAPu/DEufvy243mrBpey++R07zMFafVey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1546
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Dec 2021 07:37:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7049

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v4.19.217-cip62.=0A=
The linux-4.19.y-cip tree has been updated version from v4.19.216 to v4.19.=
217.=0A=
=0A=
You can get this release via the git tree at:=0A=
=0A=
  v4.19.217-cip62:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.19.y-cip=0A=
    commit hash:=0A=
      dc62e26e3be875a7324b85b8274c13a335e610dd=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip62 after merge from stable=0A=
=0A=
Best regards,=0A=
   Nobuhiro=


