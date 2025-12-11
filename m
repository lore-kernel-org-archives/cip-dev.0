Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CFD3E785
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 02:01:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12876.1765418473846821090
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 18:01:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=xexsRZI1;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1765418455;x=1766628055;bh=
	AD4iZ9kmI2I54FcpcN1vx/uDJwY7vSqljNpJe+YCP20=;b=xexsRZI1UUx+0ehQXIcvq47mVO8l7U
	+p30LGz5fc1rgVGf6hYqCnirc77VxJyZ/Da8Uq9SqG/+D0lt/8pBvqP+V1T/mLVe9INx2A7FtQivn
	i1H28p3DgC2jrgYrEcKMUKjdc9uT+WToV5YleWu13pbmXPuUcx6HF+WcZDbfW9N6bXh8Ce+zmjmfV
	XEUklPJZp+on2rL0noOhfaTa8q2E2bRNtDQM63Q8bgT2+wimTr3lzqbAMdgypwRS7kRvxBE0S/ekQ
	3sVp+JFLmw63mw8dEPDycIjpNqyNBAe24XywuYJMe8MR3wfm+ATNsYpu2RwmSwGsZuyjl21fCI1Km
	Tu9g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5BB20snk2598727; Thu, 11 Dec 2025 11:00:55 +0900
X-Iguazu-Qid: 2rWg9DyHF8sy9FAum3
X-Iguazu-QSIG: v=2; s=0; t=1765418454; q=2rWg9DyHF8sy9FAum3; m=DkG+4la0zpa1TK6PurbgC7nQc5lflEmEJ5wBpem33RI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dRbQs4NVwz4vyk; Thu, 11 Dec 2025 11:00:53 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRwvFVkgePL+jqKlw2Rv1vaJ8NTiMykbCAQp7JHJndV7EIdjE4n6TEsYeAILHDDrpn46Y8G3q0WxSoqYARW5LhY3SzfR0E2aDakxv8LrU1M/Qz82MSEiYA0B4DW/pvc5B+MILE/vZIcGQmDdAo0NFhfz0jCgHh43RhssZ1Gsq5+6LkDX3WWlmyjR07kAs65h393xGoYvnsiG7WoGlmw/suC+pcTPubVX08zLH6n8P24MPW9lstyQcj7e9zeN70DX3XHacPunbWpXsbD4UsXiUbuVqrczHkbajwCd6R5XSF/j2IXBOn5bhKy78WXo4D6UcGjhak2jjiIdouclUF7ZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgWbdq36EfnEiqb0RCAL1prZeYl1rjuqWdpXCIStHeE=;
 b=g7c8qLDgjqVtrZ+oqeAl+6lwwqOzdh8yWF/7qTtAQvihCM9MiR0xupJBdR57WIuUE1FaMUwH+ljoTj0n7RkvkH8J66Tofe7bvC1FIAApe0oO5rjifq9V7YzoUhWovB6l3Eb66+AeV/R2qC8iG+GOpn3l5Lblyg7ywcaB/evuxTcvJMn5cQLbLy4WuB+WrW7b8rlGFfBDSfflJwNTKtM5h2JK8wclzYPiye3FHJIcuPPd9Q+4JJuTyvqxDkm968yqhpPsaFcTicAynB+xUqlI4Aqluu8qMq+OUuQaSc41L45bTMScV1/d3pFO7tq9G615NwBkAFNWHICXts8CtgN5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.159-cip49
Thread-Topic: [ANNOUNCE] Release v6.1.159-cip49
Thread-Index: AdxqQez9bkKjjS9iTE2HH6+RF257hg==
Date: Thu, 11 Dec 2025 02:00:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188874B523B92180CDFBBCCDA1A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14393:EE_
x-ms-office365-filtering-correlation-id: 88954fcf-0ec2-4bfa-c6c5-08de38591b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Rm14NFN5SUhuL0FBelpHd3FxVUNQeEV1TmRjMjUydXQ2bjM5UTNmRXhR?=
 =?iso-2022-jp?B?VysvUXNGMXhVWFgwY3VkMHlmazBQT0Z6bUQ0REV6ZFcxUTltR0tZUXhT?=
 =?iso-2022-jp?B?TnBaVGhPUW5MVHVTeUI2WUhFNERsbmxYUS93bjBXcGJsR05WUVpTakcw?=
 =?iso-2022-jp?B?MStZclJCd3Z5MC9jdUp4VzRrb2Z0L3hBYWs4czRyVmF3Z3lKWndBMFBF?=
 =?iso-2022-jp?B?d3dGa3crazRHalRPQ1A0cEhua3ZhVzBqWGdubXNQRXh4RFNYV3JJRU9n?=
 =?iso-2022-jp?B?Yk8vMzBsc1lQN0J2VlgwMVJONk5sUHJFSVRjYkVXTVNjQjFxc3h1R3pE?=
 =?iso-2022-jp?B?TTRGTjdCUWlYTnRvbjRlcWZET0x6am5aaTdUdENIeXM3RE50RjRFT2VW?=
 =?iso-2022-jp?B?Sy9ISkxvSmFiWDFFN0QrSnduN0M0WDY3Z2JJbUl3VHZURXkzSHdaMmUw?=
 =?iso-2022-jp?B?bzcvV0V0UVhOOVpleGZPSmFPRG5Da01pMWJFVGFEYzZTRW5hdThnOXpo?=
 =?iso-2022-jp?B?MUg3bmZmZ1NmcGcvbDI5NDQxeEo0RE40bWNzVEMvNEZwTndyc1VsWTZX?=
 =?iso-2022-jp?B?QnBLYXFxb2VWTmwxenJmZUZWTEcvYk9yL0JsbElWS1RBWGxtRjU2Z0pj?=
 =?iso-2022-jp?B?eDJpeFNDVVVMZG9yMkhNRHJvWkJRdHBQSXdRNVBZTjhVWXpGYkxEL3VU?=
 =?iso-2022-jp?B?STFVZjZxNHRHUHhBYStTQmRJakdvdFFkYU1iaklVVmZ3R2JRQXJrQ2Rr?=
 =?iso-2022-jp?B?MzIvVnFYdTdHemdWZnhtaGNzcDNvdUNaWmhWM1NQdmF2K25CMTJPVlpH?=
 =?iso-2022-jp?B?eDN0Tm9nWTlabFYxbE0xU0JNRm1VTkxIem5YeUxxUVBqZjBCdFpoSFcv?=
 =?iso-2022-jp?B?UGNmMmFzZFU3TDNkZ0lkbUlTcURlZ3ZtNXhLbEdnbUtZREVNMkNicDVE?=
 =?iso-2022-jp?B?cXhETzVQaFJjZHlqSUFGaFVMazU1NGprRDZ5K0xGeWsxbUJRNUoxSnA5?=
 =?iso-2022-jp?B?SVRSd2h0bm9ObzNyeDA2dHBQMWk0MkFDWC95dkdPcHBSbHJOWjhUc1JC?=
 =?iso-2022-jp?B?RWc1OFBRWDVCN0d2dHFmdG1CQzNneXlwaG9DNFFpMCtkV25Hc0NEUXNp?=
 =?iso-2022-jp?B?QmZ2VWdTUWZvSDN6R0lDUVVIUVJ0THczd2FLNXljZTRpWkdlWEd6clI1?=
 =?iso-2022-jp?B?SW1RT0dxdlNzbWVPZ2g2cjV3VlFGNXZtR2RwWnhmdEF6NEI2Skt3Ukc2?=
 =?iso-2022-jp?B?RVNQU0VMT280YWpGNjJuRTNMMXVrZUJQNksyWnVpeHdvWG8vRnJRU0R0?=
 =?iso-2022-jp?B?MzR5STZxZEpvZjFNMkZQNWxiSWJJekVTOWdpc2t6cHkvOThHWEdyNHpY?=
 =?iso-2022-jp?B?N2hhWnFRZSswc3pjUjZSVVdvOGdqaGJYVjBLL0xzNkpFM1ZYeVVRTjBI?=
 =?iso-2022-jp?B?L1lJSkU2M1FoZHR4OEdNSnFpdHlnMk4xSGtzTWFudS9oOE1lVDFDNGdB?=
 =?iso-2022-jp?B?TVNyRDFxSGg0VCs0eWtsM0JFUnRoY2srTDBBQTdleUFxczQ0RVdrbjJv?=
 =?iso-2022-jp?B?WTcxVFRROFFWMUxyVzF6QW02ZlJuQ2x2NXpxQ0t4WnFJRHB0QmI1OGVV?=
 =?iso-2022-jp?B?T0tYZnEwVXBiTWlWZmJVYU1TY1UwSGxuMnF2Z2xRRHc4emxaKzcwdU85?=
 =?iso-2022-jp?B?UFZOQmh4eXpLRGdQWnhOYzVEbUpaZ2pxRHBGdlk1dTVhaldCMmhucHNx?=
 =?iso-2022-jp?B?WGplZFpsdDRXdmRIWlJjVGRVK1ZjalRVcjJCZkg4VGZYMHJORHJMZkll?=
 =?iso-2022-jp?B?U2twTVhDTHA1bzVJZi9ZY1ozWXpsc2VtMVFDVytIamtjSExSUFJOM3pH?=
 =?iso-2022-jp?B?MHZ3c21Ddk4vV2I3V1p1RkluYTZuUmx4SzVvYzlPU1h2cnl6ZmJjNE9C?=
 =?iso-2022-jp?B?RkVrWEpLZ3hRdFY5UHZXRUhmeEhxNW1zTG15VSsxa1FyT09HcHpKSXc0?=
 =?iso-2022-jp?B?c3lua0NjNDUwS2VWbnhyenhwMWs2TDEzSUwxeFdTcVcwRzRVb1BlOUxs?=
 =?iso-2022-jp?B?YkFYQ2dOYk1zL08xODVzR1ZQSkJyeW1vS0dkbXZPZWN4ZlZPYTg3SnVj?=
 =?iso-2022-jp?B?Q2daYlhTcmI0MDFjdkI1UjdLbmpTVURFN3Y1RkY4bFJvc3JzdlZ0MHRj?=
 =?iso-2022-jp?B?ajhWcXFtNlFubHFzdDZwazNHNWdiWVFy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M1ZNTmRFaDNLejROWWFud3R5SGxoUlFGSWlZeEZMQTV5M3Vsd1l2aFl3?=
 =?iso-2022-jp?B?QkQzdUEyb0Qra1grK1RBdGdsTG0zZVRqOHRSU05xWVNqOWRVLytRcWd0?=
 =?iso-2022-jp?B?eXJydnNDVm4xMjRkOEhERnlETWZVQ1RkQThZWU5IQ0U0QlVxV3NEMncr?=
 =?iso-2022-jp?B?M3JIUXFGTkZ3Qmo4S1lCYmF2UEFIcWVGbmVocWxVbHpYRHVld1JWcDcw?=
 =?iso-2022-jp?B?SlhUYUJxbFluSkd2eUM5YzUwZkRjSk5mbGpUN2phb1F6OWxSSTBCT3g4?=
 =?iso-2022-jp?B?K2tVWmZxSDVzNWxrNytlNmFlclRlVjlYZC9nWEl2V2g5RzV0TmtzOHBI?=
 =?iso-2022-jp?B?UVZTMFVJZzlzeG9IL3lyTkFOZVhZZHdTVDhFUnN3OHZsTkQwekZOMmkx?=
 =?iso-2022-jp?B?TXYwT3pHOVZ0N1RrQnNXNlFIczAvY3Z6cWViUWNHNjMxa2x4QkUxTHNY?=
 =?iso-2022-jp?B?YVNTYnl1U1N2RDRhckE2UGJURVJFbVZHMmpWVmhOU2hseGFSeUR1ZFZ0?=
 =?iso-2022-jp?B?VlhZcG0xeXIzUU05MS9zVkJqRzc0Nk9xTmF5Z3VJa2g5WWsrekV1MXpv?=
 =?iso-2022-jp?B?VzhRT3pqc1A3Yy9sWUpCQWt5N25NcTFiOGxtNmtNd0I0dWsrbUJERU5o?=
 =?iso-2022-jp?B?aGFTNXFURnBrVnhFbmRrY04yZ1AzU2t6cjk0c1FNY0xXdElUUUF5MXl6?=
 =?iso-2022-jp?B?VXFpeWpSLzNKNGtRY292b0dDbHVBay9ocm13QXZ1UHRHb0xsVUh2R0sx?=
 =?iso-2022-jp?B?ajlkcVpEaFdLbHNONk1jYmRQTWk2Z3BqZVhIZUZHSHRWWTJ6c1NiZEVp?=
 =?iso-2022-jp?B?WnhMRW1QWkRPa2hIYW50TjU3a1dqQ2k4cysrdExOV01XVUM2UCtndGNw?=
 =?iso-2022-jp?B?OFFYSUYyM0V6SEF0WU96bk5LSU5VQkF0UXF4OWRKUjdMOFh3VFo2b3M1?=
 =?iso-2022-jp?B?bnBWVFVHMk04MjdpbGpWOThxYjFYNEUrSUJJRm93NWNRK05DMnJ5UHlm?=
 =?iso-2022-jp?B?allPaVN6ZGY2TmNsRk9kWUgvaHZwSEpacXpXbW1kMmtTbldzeDB5TzRC?=
 =?iso-2022-jp?B?bmJBdzZFZzc4Q0dwRVZibERVKzdCTzIyNWQrUG9wUFoxeFA5aUVoM0lQ?=
 =?iso-2022-jp?B?WVZqOXI1dCtEZXRKTkxIc0toZW1sUWtNckRBS2dyRSt6aCtrZ3lzL2J1?=
 =?iso-2022-jp?B?Zk5aODE1VC9iL0FsenFzV0QwcDZZenhFWXlHVnJZN1FEU3pxTmZ0NGFU?=
 =?iso-2022-jp?B?NXAwY2JxdDlXYXEySGxlRDR4ZFM3RndDOXVFTEhrUll4elMxUVZnMEVq?=
 =?iso-2022-jp?B?REZIWm9EZC9Memt1WFBrNjlwb1J0Y3owczhFQjUxUHkrTlR4TitzVFBQ?=
 =?iso-2022-jp?B?Rk1oa1NIRmtzRlQ2MG9lbGJYenpySGY1dkRlM3hPYVBHaWcvUmZWb3Bl?=
 =?iso-2022-jp?B?R1ZlQXUzNm01SXBBMU05TUlwNVpVOHg4TGVvbE9ocmpOaHQwdXFnNU5s?=
 =?iso-2022-jp?B?MHBJcmcvWFJ6bm1xVi9ERkpxY1lERUh4QjNVRWlyaXI3NkVxd3BmT1Zz?=
 =?iso-2022-jp?B?UXpWTXBZTzkvTzAyUzlPampZNEhlV1NvZWJITitRRnd4S2FQL1Q3S09k?=
 =?iso-2022-jp?B?SllaOWN0andTems1R0xIQWtWY1N5V1A3dWVxbjQ4WEEyMnlucStndUsw?=
 =?iso-2022-jp?B?ekZ6UmdjQTMyb0JiUWs2d1FJSUVVSndmeWdyMXhHL2ErbVJoLy9haGtr?=
 =?iso-2022-jp?B?MDgvVlZ5SG81RmpaajBOQWVWOHFOOXlKOW9SWC8xRkJXMUROdHJlbDBo?=
 =?iso-2022-jp?B?QTJ1Z2lMNFVJeHY3MG5jbGswc2R0dk1mVzdtaGh1YmNXZkFkaWwvUUh2?=
 =?iso-2022-jp?B?ays1bW9vRzFMaXFLNTk5OC9NRlVpQUVYZWgxbHpXMGRMd1QrRmNQYjdk?=
 =?iso-2022-jp?B?QlhOWTQzMktPbkhtcVE0VGpOc04yNVBkZStoMGl2dUttUk1reis0d1Nr?=
 =?iso-2022-jp?B?WmdTVlcwTW9BNmZpZXY1Y05YZXk3QU5wbmk5N1pjY3dxY290SU9jUjQ0?=
 =?iso-2022-jp?B?VWUrNndoekI5NTB5ZFdJbTBHdWQ1UFdQSzJEcFIwdEVSc3RBY05sMThF?=
 =?iso-2022-jp?B?WXZibXhJeWZQNm5aQXJQVUJISUkxOGpnK2k0MnhlVWhZV3cxdGZHMHRW?=
 =?iso-2022-jp?B?Z2gzam5rMWdjakdkNmZJZEY5TkZBamNIOVVkcDhwWTdZaWIvczV3SkJx?=
 =?iso-2022-jp?B?bWk5ZVFjRENYWC9Rb3FPa0hnelllQVJUUEZadWxsNnBDczljYW1WMkJ3?=
 =?iso-2022-jp?B?VEdOa2JVWEVPY2M3cE5jRTR6T1N4VWs1QnIxRE84U1JPWDRvZ0hHY2pm?=
 =?iso-2022-jp?B?Z0VGc2c9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88954fcf-0ec2-4bfa-c6c5-08de38591b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 02:00:48.9728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoYPiSJkUvILsi1tZSoNa353pusfUSu7ZCON/9HqPF/ezb0RP5l8HFrrxVTP5uhUIKAKSL40BCM6viG5fnfVmz6JyP5FOLUsy4Qhg0Xj+udQu//eR5FXaFAggSkuIDPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Dec 2025 02:01:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20965

Hi all,

CIP kernel team has released Linux kernel v6.1.159-cip49.
The linux-6.1.y-cip tree has been updated base version from v6.1.157 to v6.=
1.159.
This update adds device drivers and dt-bindings for the Renesas ARM64 SoC R=
Z/V2H and others.

Information about this release is as follows:

  v6.1.159-cip49:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      9d36b7fe666eb2770c401e719d0ab30c14f8dfa7
    fixed CVEs:
      CVE-2025-40095: usb: gadget: f_rndis: Refactor bind path to use __fre=
e()
      CVE-2025-40096: drm/sched: Fix potential double free in drm_sched_job=
_add_resv_dependencies
      CVE-2025-40105: vfs: Don't leak disconnected dentries on umount
      CVE-2025-40176: tls: wait for pending async decryptions if tls_strp_m=
sg_hold fails
      CVE-2025-40092: usb: gadget: f_ncm: Refactor bind path to use __free(=
)
      CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise
      CVE-2025-40084: ksmbd: transport_ipc: validate payload size before re=
ading handle
      CVE-2025-40245: nios2: ensure that memblock.current_limit is set when=
 setting pfn limits
      CVE-2025-40094: usb: gadget: f_acm: Refactor bind path to use __free(=
)
      CVE-2025-40198: ext4: avoid potential buffer over-read in parse_apply=
_sb_mount_options()
      CVE-2025-40100: btrfs: do not assert we found block group item when c=
reating free space tree
      CVE-2025-40173: net/ip6_tunnel: Prevent perpetual tunnel growth
      CVE-2025-40231: vsock: fix lock inversion in vsock_assign_transport()
      CVE-2025-40240: sctp: avoid NULL dereference when chunk data buffer i=
s missing
      CVE-2025-40243: hfs: fix KMSAN uninit-value issue in hfs_find_set_zer=
o_bits()
      CVE-2025-40099: cifs: parse_dfs_referrals: prevent oob on malformed i=
nput
      CVE-2025-40103: smb: client: Fix refcount leak for cifs_sb_tlink
      CVE-2025-40088: hfsplus: fix slab-out-of-bounds read in hfsplus_strca=
secmp()
      CVE-2025-40167: ext4: detect invalid INLINE_DATA + EXTENTS flag combi=
nation
      CVE-2025-40093: usb: gadget: f_ecm: Refactor bind path to use __free(=
)
      CVE-2025-40106: comedi: fix divide-by-zero in comedi_buf_munge()
      CVE-2025-40244: hfsplus: fix KMSAN uninit-value issue in __hfsplus_ex=
t_cache_extent()
      CVE-2025-40233: ocfs2: clear extent cache after moving/defragmenting =
extents
      CVE-2025-40085: ALSA: usb-audio: Fix NULL pointer deference in try_to=
_register_card
      CVE-2025-40223: most: usb: Fix use-after-free in hdm_disconnect
      CVE-2025-40087: NFSD: Define a proc_layoutcommit for the FlexFiles la=
yout type
      CVE-2025-40104: ixgbevf: fix mailbox API compatibility by negotiating=
 supported features
      CVE-2025-40220: fuse: fix livelock in synchronous file put from fuseb=
lk workers
      CVE-2025-40301: Bluetooth: hci_event: validate skb length for unknown=
 CC opcode
      CVE-2025-40271: fs/proc: fix uaf in proc_readdir_de()
      CVE-2025-40297: net: bridge: fix use-after-free due to MST port state=
 bypass
      CVE-2025-37899: ksmbd: fix use-after-free in session logoff
      CVE-2025-40313: ntfs3: pretend $Extend records as regular files
      CVE-2025-40341: futex: Don't leak robust_list pointer on exec race
      CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bi=
ts
      CVE-2025-40282: Bluetooth: 6lowpan: reset link-local header on ipv6 r=
ecv path
      CVE-2025-40277: drm/vmwgfx: Validate command header size against SVGA=
_CMD_MAX_DATASIZE
      CVE-2025-40321: wifi: brcmfmac: fix crash while sending Action Frames=
 in standalone AP Mode
      CVE-2025-40254: net: openvswitch: remove never-working support for se=
tting nsh fields
      CVE-2025-40281: sctp: prevent possible shift-out-of-bounds in sctp_tr=
ansport_update_rto
      CVE-2025-40262: Input: imx_sc_key - fix memory corruption on unload
      CVE-2025-38678: netfilter: nf_tables: reject duplicate device on upda=
tes
      CVE-2025-40253: s390/ctcm: Fix double-kfree
      CVE-2025-40294: Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_=
pattern()
      CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue
      CVE-2025-40318: Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue=
_once
      CVE-2025-40293: iommufd: Don't overflow during division for dirty tra=
cking
      CVE-2025-40323: fbcon: Set fb_display[i]->mode to NULL when the mode =
is released
      CVE-2025-40314: usb: cdns3: gadget: Use-after-free during failed init=
ialization and exit of cdnsp gadget
      CVE-2025-40252: net: qlogic/qede: fix potential out-of-bounds read in=
 qede_tpa_cont() and qede_tpa_end()
      CVE-2025-40331: sctp: Prevent TOCTOU out-of-bounds write
      CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we=
 wait for it
      CVE-2025-40273: NFSD: free copynotify stateid in nfs4_free_ol_stateid=
()
      CVE-2025-40280: tipc: Fix use-after-free in tipc_mon_reinit_self().
      CVE-2025-40278: net: sched: act_ife: initialize struct tc_ife to fix =
KMSAN kernel-infoleak
      CVE-2025-40317: regmap: slimbus: fix bus_context pointer in regmap in=
it calls
      CVE-2025-38073: block: fix race between set_blocksize and read paths
      CVE-2025-40261: nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nv=
me_fc_delete_ctrl()
      CVE-2025-40309: Bluetooth: SCO: Fix UAF on sco_conn_free
      CVE-2025-40315: usb: gadget: f_fs: Fix epfile null pointer access aft=
er ep enable.
      CVE-2025-40304: fbdev: Add bounds checking in bit_putcs to fix vmallo=
c-out-of-bounds
      CVE-2025-38057: espintcp: fix skb leaks
      CVE-2025-40284: Bluetooth: MGMT: cancel mesh send timer when hdev rem=
oved
      CVE-2025-40211: ACPI: video: Fix use-after-free in acpi_video_switch_=
brightness()
      CVE-2025-40286: smb/server: fix possible memory leak in smb2_read()
      CVE-2025-40214: af_unix: Initialise scc_index in unix_add_edge().
      CVE-2025-40259: scsi: sg: Do not sleep in atomic context
      CVE-2025-40275: ALSA: usb-audio: Fix NULL pointer dereference in snd_=
usb_mixer_controls_badd
      CVE-2025-40312: jfs: Verify inode mode when loading from disk
      CVE-2025-40322: fbdev: bitblit: bound-check glyph index in bit_putcs*
      CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC
      CVE-2025-40292: virtio-net: fix received length check in big packets
      CVE-2025-40257: mptcp: fix a race in mptcp_pm_del_add_timer()
      CVE-2025-40263: Input: cros_ec_keyb - fix an invalid memory access
      CVE-2025-38593: Bluetooth: hci_sync: fix double free in 'hci_discover=
y_filter_clear()'
      CVE-2025-40285: smb/server: fix possible refcount leak in smb2_sess_s=
etup()
      CVE-2025-40343: nvmet-fc: avoid scheduling association deletion twice
      CVE-2025-39805: net: macb: fix unregister_netdev call order in macb_r=
emove()
      CVE-2025-40248: vsock: Ignore signal/timeout on connect() if already =
established
      CVE-2025-40319: bpf: Sync pending IRQ work before freeing ring buffer
      CVE-2025-40279: net: sched: act_connmark: initialize struct tc_ife to=
 fix kernel leak
      CVE-2025-40342: nvme-fc: use lock accessing port_state and rport stat=
e
      CVE-2025-40306: orangefs: fix xattr related buffer overflow...
      CVE-2025-40324: NFSD: Fix crash in nfsd4_read_release()
      CVE-2025-40272: mm/secretmem: fix use-after-free race in fault handle=
r
      CVE-2025-40283: Bluetooth: btusb: reorder cleanup in btusb_disconnect=
 to avoid UAF
      CVE-2025-40269: ALSA: usb-audio: Fix potential overflow of PCM transf=
er buffer
      CVE-2025-40308: Bluetooth: bcsp: receive data only if registered
      CVE-2025-40258: mptcp: fix race condition in mptcp_schedule_work()
      CVE-2025-40288: drm/amdgpu: Fix NULL pointer dereference in VRAM logi=
c for APU devices
    added commits:
      CIP: Bump version suffix to -cip49 after merge from stable
      arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/=
V2N EVKs
      arm64: dts: renesas: Add initial device tree for RZ/V2N EVK
      arm64: dts: renesas: Add initial SoC DTSI for RZ/V2N
      clk: renesas: rzv2h: Add support for RZ/V2N SoC
      dt-bindings: clock: renesas: Document RZ/V2N SoC CPG
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2N support
      dt-bindings: serial: renesas: Document RZ/V2N SCIF
      soc: renesas: rz-sysc: Add SoC identification for RZ/V2N SoC
      dt-bindings: soc: renesas: Document SYS for RZ/V2N SoC
      soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
      dt-bindings: soc: renesas: Document Renesas RZ/V2N SoC variants and E=
VK
      dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
      dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
      dmaengine: sh: rz-dmac: Allow for multiple DMACs
      irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
      dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
      dmaengine: dmatest: prevent using swiotlb buffer with nobounce parame=
ter
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
      ASoC: da7213: Use component driver suspend/resume
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g057: Add XSPI node
      dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2=
N support
      clk: renesas: r9a09g057: Add XSPI clock/reset
      clk: renesas: r9a09g057: Add support for xspi mux and divider
      dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support
      arm64: defconfig: Enable RZ/V2H(P) USB2 PHY controller reset driver
      arm64: dts: renesas: r9a09g057: Add USB2.0 support
      phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/V2H(P=
)
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2H(P) SoC
      dt-bindings: phy: renesas,usb2-phy: Add clock constraint for RZ/G2L f=
amily
      reset: Add USB2PHY port reset driver for Renesas RZ/V2H(P)
      dt-bindings: reset: Document RZ/V2H(P) USB2PHY reset
      dt-bindings: usb: renesas,usbhs: Add RZ/V2H(P) SoC support
      arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/=
V2N EVKs
      kbuild: Allow DTB overlays to built from .dtso named source files
      arm64: dts: renesas: r9a09g057: Add ICU node
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name fo=
r GBETH1
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
      arm64: dts: renesas: r9a09g057: Add GBETH nodes
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
      dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts'and 'int=
errupt-names'
      dt-bindings: net: Define interrupt constraints for DWMAC vendor bindi=
ngs
      clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
      clk: renesas: r9a09g057: Add clock and reset entries for USB2
      dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP=
 core clocks
      mmc: renesas_sdhi: Set the SDBUF after reset
      arm64: dts: renesas: r9a09g047: Enable Tx coe support
      arm64: dts: renesas: rzg3e-smarc-som: Enable eth{0-1} (GBETH) interfa=
ces
      arm64: dts: renesas: r9a09g047: Add GBETH nodes
      net: stmmac: Add DWMAC glue layer for Renesas GBETH
      net: stmmac: provide stmmac_pltfr_find_clk()
      net: stmmac: provide generic implementation for set_clk_tx_rate metho=
d
      net: stmmac: provide set_clk_tx_rate() hook
      net: phy: Add helper for mapping RGMII link speed to clock rate
      net: stmmac: platform: Add snps,dwmac-5.20 IP compatible string
      dt-bindings: net: Rename renesas,r9a09g057-gbeth.yaml
      dt-bindings: net: renesas-gbeth: Add support for RZ/G3E (R9A09G047) S=
oC
      dt-bindings: net: Document support for Renesas RZ/V2H(P) GBETH
      clk: renesas: r9a09g047: Add clock and reset signals for the GBETH IP=
s
      pinctrl: renesas: rzg2l: Fix OEN resume
      pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks
      pinctrl: renesas: rzg2l: Add PFC_OEN support for RZ/G3E SoC
      pinctrl: renesas: rzg2l: Unify OEN handling across RZ/{G2L,V2H,V2N}
      pinctrl: renesas: rzg2l: Remove OEN ops for RZ/G3E
      pinctrl: renesas: rzg2l: Unify OEN access by making pin-to-bit mappin=
g configurable
      pinctrl: renesas: rzg2l: Parameterize OEN register offset
      pinctrl: renesas: rzg2l: Fix invalid unsigned return in rzg3s_oen_rea=
d()
      pinctrl: renesas: rzg2l: Add support for RZ/V2N SoC
      dt-bindings: pinctrl: renesas: Document RZ/V2N SoC
      pinctrl: renesas: rzg2l: Suppress binding attributes

Best regards,
  Nobuhiro




