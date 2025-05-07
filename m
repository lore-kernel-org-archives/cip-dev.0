Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4EC3ABBE
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 00:56:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.761.1746579364977849533
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 17:56:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=MIxQD1RD;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1746579343;x=1747788943;bh=W3Rwnzx65OUaO0NamSYtCy1n1XNe14nkEYBw0BV
	6BAE=;b=MIxQD1RDm3oEyLvH8Ks/FOegdL9kzLsODM5w/l4h5v49rLFgY2itba9jLHAC96U7ByFCu
	P477L1gkJ695YI1KOQdZyPsbR3ytPbs0c9Loy1mnVX5yVu3xht1gAFE3XSah6L2Aq1hsy8uhpZ8j4
	J9763cGOqt5Sq7wpxqEpgYDyED9lYJr9tpmFL4UwJqF5Gw07WyoUKV8kg6HcjDdS9dtaxFC2rUWNn
	fP68gKxjKDAwThKbLL/21qprBkZsix/8iVj2PmjAkUygl/UmzpTXK/qIXWxJkpQp6nAZd6qfTD+7C
	HtfunWvdtkCGtlED3eCYlsrlZ9GjYIQSJp5sZ9jiKw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5470tgca216158; Wed, 7 May 2025 09:55:42 +0900
X-Iguazu-Qid: 2rWhyCKR75gLv4Gilc
X-Iguazu-QSIG: v=2; s=0; t=1746579334; q=2rWhyCKR75gLv4Gilc; m=sL1AESjRrCvT3o1vegFebFl9d3Yc2KoLZvR2KPI+X18=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 5470tUIo1311798
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 09:55:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtRH55syXxiiu+u0ypJZdP+xOxTGCaT4gIr4hqxuR8GWmNxqUrpbeMSF8dzp/Au01tu2pq53YfQvNqBTnh93YkvmUpPD/AzyDn3pzpx8Dt4SwKDVLRrONeMParQKZWw1om4p/pmnPosy5R1mz5A3eUhQu5lsRwiFhi3ekyQduyZ6YY/kfDNwb/tTxtcqgCrdLl5MfPk9o0F5SV+aHrZq1rhohGgeCQIQRiVD7iLE98lfXLllX8JSkdGa142O0Qtj6qxG8He51RmCdsPjpdlQR3yfmJPD/SwLdHUetWCyduiZndIMTTLr5eqQL+4J5wqNS6NRsS8Tg/zOU2iLGOc9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INNGhY42ekA0UAXS2odNf8dsMOYWh2c4mwieupBX1O8=;
 b=JwNudqCocsWTvou0g1au0tAbot8cQUSLD3GWGheItAGZ7PjHA/FzipX/lHBz3ZaWYw7K5je9YResW/lqUfWgzageswP6nvGd8KJGFudyHYZuCC3cLr1mSOeylQPxlXZfe1i7R6yWiQpzoQ8afeOxRcNTxdDNcqG7N+88RJJKXPq6XtXtrJWzDCfH/fB1cPiNYHSipibLUfTW3kxtHPfT04VCfaKoV07F6mJf3ZOBJmgZNNSgL/PZSURAkjIS7r7oAuz5Wz+S5N5Yw3fUVs++kvClNjtRL6we5v35qi1CS463DbWFsyeHH4hdBvSX6ywvhR2WmMZEqdQuJYe4eu9tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <uli@fpond.eu>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: AQHbpUgQJ4XZlFPttEOjVvE3iV3PDLOmMT4QgAFA6XCAEJsfkIAOfH4A
Date: Wed, 7 May 2025 00:55:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481851C84944731CC67B05D19288A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019C7990FA3543B1F69A6CFAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB7019C7990FA3543B1F69A6CFAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB15060:EE_
x-ms-office365-filtering-correlation-id: 823c4482-54ae-4592-4188-08dd8d01d741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WkRDR1RlS2Y4MDVtUDZsVjlFTGtEVGU4UlcyT0RRdzllN2Z4SndyZ21T?=
 =?iso-2022-jp?B?a2ZtejZGWnUyN2xCSmdXOWZ0d2krZE9UQW5QanlFbzVLZE41Q1E4RElI?=
 =?iso-2022-jp?B?WkRiTjVMWEFIdktzWlJ4NXN2YmZkbWIrNlA3eDZ5T21aR04vczRIK1NW?=
 =?iso-2022-jp?B?SVdFeWQ4UnNwQXNCZnB5dzJ5bnN6dmlBcXBBOXZMYnN3WWtBeFEwZVRS?=
 =?iso-2022-jp?B?alVheWRFdjY5dW9ETTlabUdZWWxYSEhIYUs3Szd0cFlvaTRrNmJvU2NK?=
 =?iso-2022-jp?B?RTlzdytzMnZyT2JoODlYcUFvSDIvTCtjRE5yRHBRYzZIVngwMmxhZWdt?=
 =?iso-2022-jp?B?aElGQXVIOTkrNFdBanF1VDUwM096VzVxMTJvL1RZeXdia1RaNmloVm02?=
 =?iso-2022-jp?B?SmtmZ0dBZFFra0Q4SDIrUHcvUldOaElUcllHRStjSDU0a0dpbWlqSE5E?=
 =?iso-2022-jp?B?b3oxR2pnbWNTZ3RXTHk3SU1oV3FuMW9BMmxOS1lEcFRhelhjWGpqSW9i?=
 =?iso-2022-jp?B?QStRQk52WkwvSmFIQVFyeEJobWJLY2g4Qk95KzVHWnJRZ2psdElHVnlZ?=
 =?iso-2022-jp?B?VU5aUjhhdGUzMGhxQU01L0hvdm1Gc0JxTDhVTmU2aXpUQ1R4cXB1dzNa?=
 =?iso-2022-jp?B?bzN2YVJVTVNmanVmV3pVV1AwN2lmZ2Zmc0YzelVJMUduM2p0bDl1RGFE?=
 =?iso-2022-jp?B?L1htL0VhS2lkZ1B1QXRoMytPRS9MKzV0eXZNSFp5REhqR25pYlpSNUh6?=
 =?iso-2022-jp?B?SSt0WnV3ZWd2OCtZZ1VSM2owbU1IaDUvdVA4Um9oM3dqejhoOVJhMHcy?=
 =?iso-2022-jp?B?UlROdzNNMENsbEp0cHNIZ2JlRjZEdVZ6VVVyNzFQalgyQmI3ZEw1VUoz?=
 =?iso-2022-jp?B?OTQyOU9ZU0FkbFFKSkl6bG8zcVpZSkhwVDdDRUxYWm9mRmx0dGNBaVJN?=
 =?iso-2022-jp?B?Y0dYcTNycENVenpzWFRQZ29XT2kyRHdoOGtaZjhWa2hJSGVyV3pFemlN?=
 =?iso-2022-jp?B?b1hPY0FvT3hiL2pJNkpJUzR6RXNEY25tcTlMc1hDY0d2Y0ZMbXJWS0di?=
 =?iso-2022-jp?B?RVJpQXBIZitXaktrVmdkM2tBaTMrN3Fja2JCOWw1RTNzUE1tUGpNcTly?=
 =?iso-2022-jp?B?WU9kMVRYMm1OdVRtQlZpYWtHUzFPNm8yVUhKOGd2b3BodHFkaW9ZWStl?=
 =?iso-2022-jp?B?Y3Zhd2xNZGh0Z2NSSWFEM3NMSVBVT0l2TnRpNFpuaDVuMG1xajJ0R2ls?=
 =?iso-2022-jp?B?eFVPTG9YMEZ5cWg5aGh3N21hN3JqS1VnUmR3MzhDeEkxRWZVOENiUjVo?=
 =?iso-2022-jp?B?UVdUVmRjdEtzT2xsbjBiL3ZwRms1aVVIMmpxZzVWSWRram5WcFJWa1Br?=
 =?iso-2022-jp?B?WkFHeXFOVzJGblpTVEVBNVI3MkwvdWV4RkR2V1RpZmViK2xPZTNRWDB4?=
 =?iso-2022-jp?B?WW5JQVg5YWwramc1TGJ5NThHVW1kN2lKODhyaE9RU3RKb0l5NDVCU3FT?=
 =?iso-2022-jp?B?MVdNZCtpcEpXd3JmZ252VkdMbWNSRC9JSDh2MzVtb0h0K3FHSy9uRmRo?=
 =?iso-2022-jp?B?QTZOejY2THlKc1ZsQU9hQjEySEhWV3cybFZuVEhrdkozTlpCN3FQbWJ2?=
 =?iso-2022-jp?B?cENRRk80YStiYnlJL0lLM2RGcVpObUFmSVNyWW5vSVluLysvOVlnV29Y?=
 =?iso-2022-jp?B?MEVDbGdrQ2NxbmZtNlNjOTdOd1VyZUJRZnJJa2gxNjdFayswOEhzNWRp?=
 =?iso-2022-jp?B?SzlreWxjT3BrK1dXZXAyNVdJMzNONjU2QUdpRm11cEg3TXVDZDYyRDRy?=
 =?iso-2022-jp?B?SnhYZjZXVkFYOG5WMnJqZC9lS1NXcVhBNGgxWWp5eVEwSzNhVzdUK1R0?=
 =?iso-2022-jp?B?SVViMDJHYmlBbjk5RWljaVdLU2xtdm1KZVZsYWw0aWNvRG44V3pkQzJC?=
 =?iso-2022-jp?B?d3hJdHZoU0xsengvY3hPZm1YZ2dOaWVSWGNyaTZTV1VKUDNmUW9oRHp0?=
 =?iso-2022-jp?B?RTRHc1NKRDVaUGhTMU1VdDZ6ODhEcVUrNVVoVkhBR1RzbmF3UG1xaDIy?=
 =?iso-2022-jp?B?ZWw0NER3NWFaemRXc2FsQU1mMEE1UTlEMm1DZXkvR0c4R25ybHVJVzZN?=
 =?iso-2022-jp?B?bjFaeHFTREZPYmpjcTdQbDdGTng3ODZGMjMyZFZBbU42SVZ0THQ4SVRI?=
 =?iso-2022-jp?B?OVVvPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bWZ6Qlc0ejgzZjc3RTNrbWs5ZW1aK3ZKWUVWeXE4RlJjeUlUZjVCRTRB?=
 =?iso-2022-jp?B?b1p4RCtLaXFBWnc1cG5mSTRuTTYrcFhFSXlhcXUzdndCamFsUHBHdUUr?=
 =?iso-2022-jp?B?S3pQK0VuNzdHb1ZwTzRhSW43SmpFemhUb3htdWJ1UkJiMGMxMUt5a3hi?=
 =?iso-2022-jp?B?QU54aEdrMWtPY1l6M3dNc2NUQW4welZaQks0a3hLeU9FckJkSVYvUXdj?=
 =?iso-2022-jp?B?c2VHWTFEc0U2TDJUbEYvcUkwTmgrQ0s2bzNhK3MrQVQvWHlnWFZnL2Rz?=
 =?iso-2022-jp?B?M3ZWYjNxZXlYSFYxVVJ3YXUyWnZaSHBuMlVPem1OOEZqclN0K0doQ2Fn?=
 =?iso-2022-jp?B?UlQ1OXcwN1ltNTZXRlRKWlVFRkVvdm1GL0dVWDg5VkJ5OG5ISmdOQzBG?=
 =?iso-2022-jp?B?S0FQY1pxcHdJY2x0Sm1jVi9Gb25yNnZ4WjE4WEgyWXVrTkVWTVZ1T1Bz?=
 =?iso-2022-jp?B?azF6OTd2dFZPYndlcUwwaXpNc2VZQXE0TWM4cEVIWWJMb216NDczV0JV?=
 =?iso-2022-jp?B?bkhoOUNZRllGdGdXK0diWjE4SjRMQzhyL0pjNWpFeER1cUlLenNRc0l0?=
 =?iso-2022-jp?B?VTRwN2kyZytmbVZVSXB3YnZObjFWaUVvalZJdHo4M3RKdTBGRXl1QUQ0?=
 =?iso-2022-jp?B?cXVMQnVIL290Z2orYkRmRkFnRFdoTExYVnBpbi9ncS9vYU9hRnlDUS9j?=
 =?iso-2022-jp?B?SENXMnc5Ri9ad2RqVDZoaUhVTk5iR2ZjdVNickh2NThYL1FjUHl4MEtM?=
 =?iso-2022-jp?B?S1NwMDBRUkxGM0hyN3haa3EzRDh0bHpJUzgvVHE0d3FaUUlsVEozOVBH?=
 =?iso-2022-jp?B?eng4TWpyQ0JKaXlaWG4yU0dGTjIwZlU0eGJrMzJ5TzY3VlIrc1Y2ZFFL?=
 =?iso-2022-jp?B?QmRkeEljSHAvNnI5YVh3Y1h1OWZoTCtwWW5jZEZGL1RpWjFKeHNsU0dn?=
 =?iso-2022-jp?B?dnAyOGVvU0lsQTd5RSt6dDAzeVpnYW1JS0FaaGFtditobFJzdncyUHQy?=
 =?iso-2022-jp?B?YWE0aUhmU0g3UHdXbnpsNWxQUjJtb29lRUlRWThySzlZMWtSdCtlVVp3?=
 =?iso-2022-jp?B?dE8rVzA4cFd6MGFPNWhxUHdnQ2cyUzFNQ3JHc0FaR3BBam0yclkydGpw?=
 =?iso-2022-jp?B?eWI2ZW9QNUoxdFRJOXJaMGMrYTNic1lGNmF0OVROM0ZsaVkxT1hXKzU0?=
 =?iso-2022-jp?B?N0Fub05Ic05aYnJuNXRLL2NJdUdFenZQSDl0bCtvbG1pN3N1dmFNSmg3?=
 =?iso-2022-jp?B?VGZMeUtWdDd4SXJmM05iSXhSSWR4Q1A4Ulh0cFFpVXZRYUp6NE9lYllC?=
 =?iso-2022-jp?B?L25wUlh6NjgxWTQvdlZaY2ErbGRTcGdFdDZhMVF3djdrQlQ1RWl1WlVi?=
 =?iso-2022-jp?B?QWxySHAxV1JEckhic2hYbmwrRlBuS3NKQzNKeXAzWnNpajc0cXBUQVB4?=
 =?iso-2022-jp?B?UVEzUnFsN0puWnMrbXdXdFp4MEsyZmlpUnRhclozeHczWFVXYjJBbFR4?=
 =?iso-2022-jp?B?bHVSRndCdW1nMUE1YWVZMXNCSkQ2M0JXbVpMdWJvNUVMTTRGMmVHK29N?=
 =?iso-2022-jp?B?TFJxL3NjMHE4bmRGdTNxRjFhSE5wNVkwOTY2WHAwc1hRN0oxZnZhZXJJ?=
 =?iso-2022-jp?B?NTF3S3U4Rm1uSkhrR0svbkxFUnRGWHpTS1VJNVRIT1Z6TlNPZHdVcVNU?=
 =?iso-2022-jp?B?ZlppTDF3TDBYbjBtVDNFalVhcklrUmJWa1p1OFNqdzFRdlY4bEVXMzlP?=
 =?iso-2022-jp?B?UWpnQ1BpaHkxUVMveXdXdDkzbHpwM0lKQlBkVkV1Z0l2RTVGeEtuRGd6?=
 =?iso-2022-jp?B?STlDbGNaTng3YUVZNnc3dDdSZzA1M25FaWNHalN3ZVMzVkxBeGJaT3hv?=
 =?iso-2022-jp?B?TGY1cE80MUZtbU84SGZ6cjRmMGx6SmVsN2FiZEdBcXptaC9jNEI4ZUxN?=
 =?iso-2022-jp?B?RVZsUStBK3YvZUtuMjZVblA4ekZia1VQK0FsM2Z6bjZtY2FDd094WmJa?=
 =?iso-2022-jp?B?V3l1UUpHM2RtTlNFbkRpUnlyYS9ERDlNMmdOajNYZFNKMkJTMUlOSHVW?=
 =?iso-2022-jp?B?UWZYUFNGRkowZmhtdHY0bS9YYWZPMmEwRFY2OWRieE5IQzIzYkdpMHFu?=
 =?iso-2022-jp?B?bmpEMXd2bjFjQ2E4UkRqRk1RSzlSZVdRbkdXaDNEZzB0OW1uNXd4Skxj?=
 =?iso-2022-jp?B?akhTZ0o1YTZYQ0d2TWxSOUl2RWRQc1N4anRtenhLb0QyMlZCWEV3TlVm?=
 =?iso-2022-jp?B?U1RMVHdGQ2VsZTBvNjdGOHZ5bDk0M1g3SlNIZUZZZ0lXeGpsWm5oNTNQ?=
 =?iso-2022-jp?B?YitYVzI0UXZ1ZXB1aW1RS3p6dTRSL0VudlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c4482-54ae-4592-4188-08dd8d01d741
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 00:55:20.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/celYqyLOMp6368+0rTfJE+kz5kXN0vGTpSetPF1nP8QJvsqtuPFgIu3lFUwOPgFjkd7CItOMhGjTJTIIGgwRqgO+3/JTxhMjVRF+TF0unk9bmUv2CZLXye4+xNYxLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 00:56:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18770

Hi,

> > > Gentle ping for review.
> > >
> >
> > LGTM.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >
> Thank you for the review. This patch is missing in 4.4-cip.

Perhaps Uli does not notice because he is not in TO and CC.

Uli, could you pick this patch to next 4.4.y-cip release?

Best regards.
  Nobuhiro

> -----Original Message-----
> From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, April 28, 2025 4:40 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> shmobile_smp_* alignment
>=20
> Hi Iwamatsu-san,
>=20
> > -----Original Message-----
> > From: nobuhiro1.iwamatsu@toshiba.co.jp
> > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Sent: 17 April 2025 07:05
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > pavel@denx.de
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>;
> > cip-dev@lists.cip-project.org
> > Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > shmobile_smp_* alignment
> >
> > Hi Prabhakar,
> >
> > Sorry for review is too late.
> >
> > > -----Original Message-----
> > > From: Prabhakar Mahadev Lad
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Sent: Wednesday, April 16, 2025 7:56 PM
> > > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{=
#C#P#T=1B(B)
> > > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > > cip-dev@lists.cip-project.org
> > > Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > > shmobile_smp_* alignment
> > >
> > > Hi All,
> > >
> > > > From: cip-dev@lists.cip-project.org
> > > > <cip-dev@lists.cip-project.org> On Behalf Of Lad Prabhakar via
> > > > lists.cip-project.org
> > > > Sent: 04 April 2025 10:58
> > > > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > > > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > > > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > > > shmobile_smp_* alignment
> > > >
> > > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
> > > >
> > > > When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn,
> and
> > > > shmobile_smp_arg variables are not multiples of 4 bytes, secondary
> > > > CPU bring-up fails:
> > > >
> > > >     smp: Bringing up secondary CPUs ...
> > > >     CPU1: failed to come online
> > > >     CPU2: failed to come online
> > > >     CPU3: failed to come online
> > > >     smp: Brought up 1 node, 1 CPU
> > > >
> > > > Fix this by adding the missing alignment directive.
> > > >
> > > > Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move
> shmobile_smp_{mpidr,
> > > > fn, arg}[] from .text to .bss")
> > > > Closes:
> https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-
> > > > Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Tested-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Link:
> > > >
> > >
> https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.174
> > > 16
> > > > 1220
> > > > 8.git.geert+renesas@glider.be
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > Hi All,
> > > >
> > > > Note:
> > > > - This issue has been replicated on 4.4-cip with older compilers
> > > > and CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
> > > > - The offending commit 4e960f52fce16a3b is not present in v4.4
> > > > release so this patch wont be backported into 4.4-cip by stable
> > > > hence just sending this for 4.4-cip only. Please note this patch
> > > > has been cherry-picked v6.14 release.
> > > >
> > > Gentle ping for review.
> > >
> >
> > LGTM.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >
> Thank you for the review. This patch is missing in 4.4-cip.
>=20
> Cheers,
> Prabhakar


