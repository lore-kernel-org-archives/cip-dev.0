Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F848C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 04:22:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.54084.1753935721398683384
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 21:22:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=BdX3uToT;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1753935719;x=1755145319;bh=Ku
	RIUc86rLB1yDNvMxPjHf7YIxrz2Q3RVFN9Q+B5s4s=;b=BdX3uToThIoi6vSB4KewX4ySSDcPxCzQ
	ajyhEIye0IyWDcbPfm/mVAK4+ozX2fksaPn2Y7Q0EFQyY8zwnm7PPBeSc4FVPCFKqJXd7YgYzwYYu
	KSndOIHwy15JsnZFNTm5EFG+XnJEXxI68p4yzPudd4iEZOQA43+94W5xeSMVc0t28doPo4igL/lj2
	mApzoSAVai139dP0NN++kMUjC/8MDjyydmZVZfGsAXq1aBgtTUm2jicQKrPMOCU8piZdYyVMHYai4
	G0dSp2ID1tCMkRatLe9/Hw/feFpzbRhW9x3BFdCdQZUQji7Q6y+4Zhli0UHvzcgndRZ4QEgyKiXIz
	SQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56V4LxJY2940766; Thu, 31 Jul 2025 13:21:59 +0900
X-Iguazu-Qid: 2yAbRDIdyBN014ikCb
X-Iguazu-QSIG: v=2; s=0; t=1753935718; q=2yAbRDIdyBN014ikCb; m=uckkkSfg+A/rPvPztBimhMpBhml8mZxfV2ZtZSwSAFU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 56V4Lvwk662010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 13:21:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1F8ru3eHT3RkrsKo6DuFY1cwBeQJ7Xh613gyida2NHNiduCB2HxB65yUBV7l5yVO9fFcuR4VNB7hVHF6hjSY+wkzX66IeBHZTIKeoQ883odHc3FitDGKr8mhV22IrtkUxGrYAsRWeKbYYDohCxtCKpsEAl3nDDPUw1QBGwI9k37Pxib6TDqrFDFIE9b3rXKC+CK2XxSLSQym6703p4vi/AwTOil0rTm9Tj3+ZN/VvbZnYfQgzvYJR9HfLob1aKCQPddNnKFLTDZoVgQEAWxEV2++m7BaOG5kZdX2kZRwngJXuGOjnVF2VrC6xDehOZZWMUj4rLAWv/teWLUzSER8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RgvU73JP/syTl7B7Tg0ZLLANGyeZ39Di4Nw7/QIXX0=;
 b=t25wDbXatRBui5vg8Zju+t7TgihCg4UZPsS0uBXoO4ucvq+RpowjtvCa10oDwGd/LBQvtn5GhuJp0Alj6RmkabedM6SVdYmctB5vqSQ6KqYOYwwaXn7tNpT/JQ2t3g48djrAwdDJSJbUKr01H1MYxpFt4WJzUpraoi9jSp8cv4GdY6cpkYibc6YoUT6ruPd8wkgkq54ngh35ro49pmJg3CVHP+1LyLqCsuhnFDni0aMwT/TXQQPlRYOW3qpcKwPYALzgPKl6+uS7upzdlv1DJ6S3Xk0NogQR8puZj6CGLMiQmNOuOj1EVWojCZph/s6L/SIoJRcUO5wVLleAG/BJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat (2025/07/31)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2025/07/31)
Thread-Index: AdwB0nPK913FmSqPRj6yoTXTZkgi0Q==
Date: Thu, 31 Jul 2025 04:21:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CF0E3406FC3C670241449227A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10957:EE_
x-ms-office365-filtering-correlation-id: fea98e32-bd76-44b7-70f5-08ddcfe9c869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TEhxcUhJMkF5TktYT3U5K3BSUXBiOFlFc1NUZWkzT3dGVUtzMjVNbGt2?=
 =?iso-2022-jp?B?aFU5Z1V2VHJWc2hieDJxRzFGdDRpRHBucmpCVHlVZmZuaFNxNTRhYzgx?=
 =?iso-2022-jp?B?TDIzY2h2VmtQQUtvTTdXb25NWWhMMEpxUzJTODhNTkVTQUQxVUwxeUww?=
 =?iso-2022-jp?B?dmZDREdBZ1JpQmc0aG5McTFmRFhib245R00vM2lCd1dqZUcrdHdhanlm?=
 =?iso-2022-jp?B?QzlFTEtWTkFXck92T05xekJxcXR5dkJUdWdKWjBjczhKVjNUTndxditw?=
 =?iso-2022-jp?B?a3dUbVlOL2JFWDhHcXRoTCtVamZ0RWNONnZKK3FjTnZHa1FVYXNoK3Q0?=
 =?iso-2022-jp?B?NjNIa2tmZWNPcUJEemxsT1FjNDJFd0JYUU11UElJeW9MblV5cS9WbTM4?=
 =?iso-2022-jp?B?SUh3azZkTUhnbTlUaEtZbDJRTFNDc2kyS2ZYdVRCSFlWU214ZXZWakNF?=
 =?iso-2022-jp?B?bzVFSE04UFAvSDJVV3lLSDA1d0xPRGpDL3Mzbm13QlZpWnZ5eHFEK2k5?=
 =?iso-2022-jp?B?SzMxa25zZnY1Vzh3OURjYzBUb3hCTngyUXBqbnFEaWhFaElmRWFSVVdS?=
 =?iso-2022-jp?B?clpqTEhPMkdNR2hxQ0hYbklMWTlJQTQ5WmtPcUtYVnpQYUhSMDRyYkxh?=
 =?iso-2022-jp?B?RE5WdkFUajNhdmJObW05YVZ4dXBJdlU2ejBZUXVTN3Y2cmkraVJlckgy?=
 =?iso-2022-jp?B?UWd4bTRGQzNaNGgxNmpWTHVUZDZHSUNDUTRpQUo1S3dCQ0piVHMxZk5q?=
 =?iso-2022-jp?B?MG1PMHRScTVHclltNFpVYzROTlhDb1RXbVZuT1hQUFRIdThHdkYvSVo0?=
 =?iso-2022-jp?B?clIyZVVZb1dqejNmc0I3U01nNXY3RkxWVHBWN0F2VzZyN2E4bitmOWN2?=
 =?iso-2022-jp?B?Nm5ja3Z1NnBMRG9IY2tTM0Q4dkZvT3ZPc3NQcFdlbDVJR0xkYzl3THkr?=
 =?iso-2022-jp?B?Ylh5N05adDVvencwWVp2TzdkQitQcWlmTW9vb2hmMXV2aVgreTRsY3hy?=
 =?iso-2022-jp?B?aEFNYzlYN2F0azh5NGtpQ0R4a3l3ZTl4STVUYXA4MDE3eXAwbzV3VzZU?=
 =?iso-2022-jp?B?Q29VYlhJSE1JdWN3RGVHcjRyUUlqTXZPelkzRlZRNHBJUmREMjFjWWw3?=
 =?iso-2022-jp?B?aU1EMkpyRkJSNXNwcmpoMHVPaEdSdDZ5c01ZYmpmMlpndkRjSExNWkNm?=
 =?iso-2022-jp?B?em1qMm0rdEZWK2dFcVIyb1dmNCt0ZGc4UFhBWmlxeTNzTlRNNVJ3andT?=
 =?iso-2022-jp?B?ZVBCdlhFMHJvYm51U2pTTnlaZkxJay9LOS9kdyswbEdnUVprdmZZQzQ3?=
 =?iso-2022-jp?B?c2ZnT0RvNFlyTHVJd2ZZOGc4OTE3bENYbi85bUFodE85TUNjSVc0UDF2?=
 =?iso-2022-jp?B?M0p4aEtFbi83a0ErczdCdGczT04wMnpTMmxpemFoa2Qxd3BRTThKVjVU?=
 =?iso-2022-jp?B?VExvSHN6NE9MamMyRXNMbUFTVWI5MDRoY2M2dXJ5MDBvZFlTZy9meStz?=
 =?iso-2022-jp?B?bTlpL0J0K0JpU0xNVThXRmFTay9iTVZncFIwOVdLRHR0M2lkYW8zWUxa?=
 =?iso-2022-jp?B?OGxPUnplSWh4QnVJSkd0OENXeGEyOWJ5MnlQS0pvQitBdjlkbVZKN3dt?=
 =?iso-2022-jp?B?cTVDT0NwVVhxR21QdkFpUGlYWDhTbzgwclVtMU9PbXZFa2VvcjRjVzFn?=
 =?iso-2022-jp?B?aUJBRWdqK1ZBRW50azhqeDJGTngwbmY0U1Y5TlVwa0kwNFJBYys0RFRG?=
 =?iso-2022-jp?B?cU9ITkpET21tU2tKV29iTDZNT3kwWHJjT001TXlQak1FZ0VqSEQ3WEIz?=
 =?iso-2022-jp?B?N0hGcmVXdWhRM2kwczJqVVEyNFN0c2N4OEUyTjdzelhHN1lZdjc0VVFF?=
 =?iso-2022-jp?B?Y2FaaDhQNHEydUM3ci9sZGdBZHh6UVNnV3dUek9nN3BZQXhpK0R1V0J0?=
 =?iso-2022-jp?B?T25lQm8wN3Y2OGVEWHhnWWtZSmdMblpyTStFNTEyY2J3WTlkMENzdklr?=
 =?iso-2022-jp?B?bEFVWlVsVTFVYVVVZkd2T0RTU3d1VEhuQlU4NnJNdk1YQy9yU28ySW1s?=
 =?iso-2022-jp?B?VVRXand0MUMvQjZzNmxrVVJpRTRDcjQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cS9SRDBtNW5zZWdNT0lKK2pIR1FMSER4VDBLNGpMT1k5WTRaYWt5aDJT?=
 =?iso-2022-jp?B?dG1KdTFacDA2ZTZmbVdOdFl5NWQxREpKcHQzNjI2Y25HVUQyTE81cGxu?=
 =?iso-2022-jp?B?b2toTFdLell5Y1VnZEY3N3F2dzltem5CS1RLdjF3WE1GRVRPL3RsbGQv?=
 =?iso-2022-jp?B?MnlUbDArUjFWQ3BjS2RrOXI1TytLc1I5akNXelJtVzc0WUV3MnVoODFh?=
 =?iso-2022-jp?B?RmtUMzRrQWZUTTFyZkJ5VDlkb0NUdmRra0VsK3AvUWJTcUNxN0RuUnFR?=
 =?iso-2022-jp?B?Nkt1S2drZUV2TWZIUEZjUzMvRThoUkJZOU83Z1pTR0JkMUZxTkFpbW10?=
 =?iso-2022-jp?B?d2k0M08rbWhmcmZBMzk2WlVsNEd2aFU2WCs0UXNJMjVHS0wwa25lamRo?=
 =?iso-2022-jp?B?YjZOZUw5QnZoc0VlQ0FNQ0V0UDliK2IzRXFPMExpNDRyWGRNQ0FJNTZi?=
 =?iso-2022-jp?B?K01TOXh2eDdsL1FDNXBPNTR0NEpaM1g0QlBzWTMvSFM5T2VhYWViTnBl?=
 =?iso-2022-jp?B?MlVPZG95NURYY2JhRGxYWERaNXdtLy9PeG11ZEo2ZTdqWG9kTXJTUlpy?=
 =?iso-2022-jp?B?ZkxtMDluM0U4SmpwRmZVWjFaSm5sZGRuYVZxZC9OaXdwQlQ0WnY5aDBU?=
 =?iso-2022-jp?B?TXpWclZ2K2tnZit1bG9lS0JheENkYllna1V1T3VZZnJhNzE1c3lFeFdV?=
 =?iso-2022-jp?B?SFJZT0JRTGNLbjlyaVpDR1lSMzUvVTltWVpiYVBCcktMQ281WmpwYWs3?=
 =?iso-2022-jp?B?N2YxWXA5OU9paHViMi9BcEUyMmgxa2pMUStlUmhVbGxpUUFhRXN4RWFj?=
 =?iso-2022-jp?B?NWljZDhDcDdHejFwNnNtU3IvS0N4bFhEck02SWtXYXNaYzIxc3FIT3pj?=
 =?iso-2022-jp?B?WlU5bmtFV09WSUUzelZBU0ZmTmxlRGd0cGZ1ZXRabWlaV3BHMk1UUjRY?=
 =?iso-2022-jp?B?ZmpFZUN1NThqYlQzQmFKQll1ZXR0N3hNNjZGbjkwRTV3bVNXTUgxSitJ?=
 =?iso-2022-jp?B?bmRLYnNpVFpUYTI2NDlsdUlRc3RLcG8rWkFGdnpMM3lPaitUWDIwaWZP?=
 =?iso-2022-jp?B?ZTBVcld1dDArQTVoZjJ0NzJCb2NuSjdBdVdhSXI0OGxKSnVwNHpRYkRr?=
 =?iso-2022-jp?B?VlBDYUt5bmxnQTJRYVM5S2dUQjlvazlkaFhtZS8zYW9FWXk1YU1pT2Zl?=
 =?iso-2022-jp?B?QTFJM1dnYXJ4M29qeHV3ZVF5MDIvL3NBTUN3c1A5NXp5VzFFU2RTVThQ?=
 =?iso-2022-jp?B?a0dsWEVmMmdsNVVVZC9aYVNLcEplV2hnancxWkh2ZlhsdlJUR3p6Zk9k?=
 =?iso-2022-jp?B?Sm0xYlNLa1ZQY1AxU2M0cUtLcXBnWFR3Q284SzlnWUg0Q0htYW5DL3JV?=
 =?iso-2022-jp?B?L3JDemZZRFZrZXZoZVpJdmkzUVFDRCt1R09aRiswVnNoeHpJUkJlWWoy?=
 =?iso-2022-jp?B?WUlyWUVWYWx1TzNkVGwwdWVmQUVKQlZFVjF4Yjd1NzF0TU8xeEhYZzAw?=
 =?iso-2022-jp?B?amNMaTNreDBuenNwK3E5aURtS1U5T3Y0Uk9tbk5DLzNQUm90endZL3Uw?=
 =?iso-2022-jp?B?aUFuenRMNURBbVltUk40QUpYQzFyRDJoR2NtRUJ3YVpFdzYzMVRsZ1Rk?=
 =?iso-2022-jp?B?cVFaeHIrZWxqdUJUVzlZWnhvOE0xRkRJRmJnMGx6emZINU5neDEwRXFy?=
 =?iso-2022-jp?B?SFNZb3Z5RytyQjkxbzFhY1NHVUhVMHRGRndrcWhtYVhIY2xIQlBEQWRp?=
 =?iso-2022-jp?B?czk1Z0RnblZYbWpTL1hLUVJoNHlTQkNYWDc1d1dLbCtPS1pHcWZVUzYr?=
 =?iso-2022-jp?B?NTJ5ZFNiWWxnRHJtYTlxVkg3aGgvOUFvQ2ZqNzZyMmJhSW9DVGFsNWEr?=
 =?iso-2022-jp?B?N1NpNEVsa2JuR2N3bTBuL0RnRnl6ZDJZaHRYTkxLbXpyNjNvSUs5bWw1?=
 =?iso-2022-jp?B?aVJrTkR4S200MVk4elR2bXR4RUFzRS8zTDF4QVZjbnVkZlZqa2RydWFi?=
 =?iso-2022-jp?B?RUJyZDBydW1UTkd1aktwYTBEelJXb0wrTHEzNjNPSENBamRTWlM2TUFq?=
 =?iso-2022-jp?B?SVBHYThFbWx5SElqVS9LYlZIZXVRaVM0RStldStqZ2pUSDZYZDlTa0VC?=
 =?iso-2022-jp?B?NEdlNzRYS28wUGRPQUZTSUNKTDVQR1g5L3JWUTZ1UXgrOWgzYnIvMnRO?=
 =?iso-2022-jp?B?S1R1QW1CNEVBK1ZSL3lKSnNRVEZCbi82bXBwU2RISzJrN3hrbEF5VHdG?=
 =?iso-2022-jp?B?YXBXTXlMblRQMFdFNmpUUlc2K2NMYkwra3NYcEcxU0VVcEZRSjhNbUR4?=
 =?iso-2022-jp?B?bitTbDh0UWliWk9Yend1UDlQL3Z1dUZMdVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea98e32-bd76-44b7-70f5-08ddcfe9c869
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 04:21:55.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rERwlsKcbkXBSmByaX/LMJXY9f9Kr281fTYL2HL9gECydxcWxSQ0HkEzrO6SJnVOerb93K6ecmkY3KLztbLc72pY0/MWbGf53YgwV9G2xIoZowgvY+JKPwSY06rwyWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 04:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19625

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mont=
h=3D7&day=3D17&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/07/cip.2025-07-24-1=
3.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

Date the data is created: Wed Jul 30 09:00:01 PM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip101
  latest version release date: Wed Jul 30 11:27:27 AM UTC 2025
  limit date: Fri Aug 29 11:27:27 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip100-rt56
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip122
  latest version release date: Thu Jul 17 08:30:58 AM UTC 2025
  limit date: Sat Aug 16 08:30:58 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip122-rt43
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.239-cip62
  latest version release date: Wed Jul 16 05:30:11 AM UTC 2025
  limit date: Fri Aug 15 05:30:11 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.239-cip62-rt27
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.145-cip44
  latest version release date: Tue Jul 15 04:51:02 AM UTC 2025
  limit date: Thu Aug 14 04:51:02 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.141-cip43-rt23
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.39-cip5
  latest version release date: Fri Jul 25 07:26:07 AM UTC 2025
  limit date: Sat Aug  9 07:26:07 AM UTC 2025
  Status: On track


