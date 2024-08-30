Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485BDCA0EE0
	for <webhook@archiver.kernel.org>; Fri, 30 Aug 2024 04:42:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.5645.1724992973424021928
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Aug 2024 21:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47U4goO3654160; Fri, 30 Aug 2024 13:42:50 +0900
X-Iguazu-Qid: 2rWgAOE2Of4CkYxZrP
X-Iguazu-QSIG: v=2; s=0; t=1724992969; q=2rWgAOE2Of4CkYxZrP; m=au1sVuBaG/yKuYroyRv30Ogb7b6oYhN2tchZV0wrtcM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 47U4gmgT3278194
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 13:42:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk1GrhG9GeUtxs+F8kkF+MLR092Tky/KFAqUgTsDQA0lnE9KtJMuBrv6otvJ18wyxMaa9Zjv0+zzG60AVDAUwPNfBrRgoSOyxilaAIH/cLOfZe4eeRLjLYHQ3qwIUXKAfQKXoPccURiJrd4Ny8H017nGlBPmvoQieRHJXddtQO3r2uy2NJj21WZuUPAIRbO8a8YQLPo+pqHwinMu5MKORhMTUg5sr94siEbmPRhTFtv2PvvXMwAu5gSKdK68vGHEpJjBJb4FOPpq8zDKabAQFC20VugwqyKkwjlK+gdzp9e+l3Ezx/ovNxW/wEUyk9HnNJJSV5mLtwzVltKpfeoSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYOwVacsbgHpuE+2/Ylv4bzkyF3S6g7I9HurxmUwaZs=;
 b=bO9uLRg6wLgN/rZY6wGStkPdXJeGlNffF9kOUlO+wayCRyKyehyuYvH+zO9sg4t6KYrYN2ycDBuT+nCahhW47uUdQPdPSH8kfmKIBwJrFt66X4yw1kjlgWcRza4zX742k8/EsBIMeSqv/fcxkxLAtqsVCWX6Hra23f9OgTz8ILbrgGNunL7hwIjKLTNknIlIHKDDcbGhYD5hcNfw93m+rb9DX0HXj5+pJ3ySGVjaIPMqNzceHHZN8wBWrW6MYNAQAZoLFvLLrlkG3eg8Oe2pJKm6C/Wn87zTcHevmXUhkKbcneARMjj70DBe5AUlzQpKZ7NPMT8LUtS5wpazfGzAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <michael.adler@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfA=
Date: Fri, 30 Aug 2024 04:42:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB13055:EE_
x-ms-office365-filtering-correlation-id: 5fd49f6b-3c49-4d98-6e84-08dcc8ae3123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SStseUpSYUk1VGJSenZHMGhMcXpSRDdnMSszUGJta0tIdGVRNVAzUlBG?=
 =?iso-2022-jp?B?N1pNS290TkcrUGljMVpPS2UyS1hzZk9MTFdVT1BhRzJDYkthVStZM1lo?=
 =?iso-2022-jp?B?YlEvRSsyWW9oK3A5MGJFWWdiMm9GYkcyME1RWUlNY094VVlUWnhEaGc2?=
 =?iso-2022-jp?B?bkVDT1hYb1k0R3l2ZUV4RFV0ZWZMK3NtZ0lqbGQ0RmdYWDBsckhucHVx?=
 =?iso-2022-jp?B?SU8vdDNzUXZKanpDZWFDRys4QnBxcmo4dEtvdkcwemx2UlJBS0RXWTJ1?=
 =?iso-2022-jp?B?MjNZNjNISnF6VlNyRzhOTkZMQnNERWdCZGZpaVo2Z1Q4NkQxTm9UUjlj?=
 =?iso-2022-jp?B?WkVQOXA5aUlNS1NNWTRnY2VxcHEvWjBZdnFKMlhvY3NnZnZVbERkb3ZG?=
 =?iso-2022-jp?B?ckpSdmY3bmNoODcrcGlPdzB4YWVZSEJtYXY5RzBxVWhBTWhST2tGVnpm?=
 =?iso-2022-jp?B?Zi9FNUFtSWxUL1dLTnZkaXo3Q1hUYmlPNUszMlBva3dlY1dmZG9MUVBK?=
 =?iso-2022-jp?B?SlVjOHpIRC9odExIbE9hcG1tcDVHSHhlcUdYUjJOanhrQXNQQTNPZGNV?=
 =?iso-2022-jp?B?ZlpGTDEvek1wZUdXV2s1Zkc1WVVwbVhQUkRnaW1VeFJ5VUdSM0RhMGZV?=
 =?iso-2022-jp?B?ZXJ2SEpRWkE3dmFXL3NyS2R1TFROY1IzbFVXWTBQQ1hLek04M3lxbkVK?=
 =?iso-2022-jp?B?YVdza3Z5ME1ZeUd4WGVUdTJuM2xZV1FKUTl1Z2E2cUV4UWNTS0xWWi9o?=
 =?iso-2022-jp?B?UzBGRzhhWXdHbzk1ZmJ0QVF5RUxwNllZVEUyb3pTaHZCTGpNR1NJQ09C?=
 =?iso-2022-jp?B?MnBvazh2RUFDdlN4RkcrVnV6NnkrRlJjTE5KaGR5a1RTV1BDNlBmczZ2?=
 =?iso-2022-jp?B?M1o4R3lyNWk0bEtTeUgzcFlpODZMOHliOWMwTG9OSlhjSUVDUXkycFpo?=
 =?iso-2022-jp?B?Q2tWR1ppeU55VEpHa1VMUkIxWld4Wk4vREZwUEhlcjVvamdBSEEyV09r?=
 =?iso-2022-jp?B?a3hvUWFIT0tZZ3JySUlCVmh6YVl6SDNxVFZlS1oxdVI0bmZVa2c1SnA4?=
 =?iso-2022-jp?B?TUVnNDNodjZuUmlQRFdkeC9iMCsxLzh6VGdxWEo5N2Yzd1lzQXcxYmFm?=
 =?iso-2022-jp?B?dkN6aVVKcWc4R2hmWWVMOWpXZkpKbjY2b2FuS2wyazBLd2VXR0Qxb0k0?=
 =?iso-2022-jp?B?K3RyMUNGQzhUaUpGUFFndmNxVmxGYTUxUFJtb0xmYkhhNmZsZ2h1WXkx?=
 =?iso-2022-jp?B?cm4wMjNZdE1xTk5KNDIzRkdwbUZaWFgvaFJPbHJrVGZVZjNVQzBhVnBP?=
 =?iso-2022-jp?B?YXRaK0NQSTU5VHZmZC83M1N6dnlRc2c5alUvSU1HemJJbXh5MmwyY0hG?=
 =?iso-2022-jp?B?Tk0vd3piYk9nT0M4cU9kRDhWME1sZHI3b3kySW1Rb1Z5elJmNmpaZzI4?=
 =?iso-2022-jp?B?eXMydkRlNUdzMGEvNlorL2VlblVjQWluVjZRdnJBL3FudjlRL3Z2U0Fo?=
 =?iso-2022-jp?B?SytuNUJMRUdDZThMazVkWnZBZTN4aFdqQzBQOElybnp4eVhORGZQUCtl?=
 =?iso-2022-jp?B?ajA0ajd6OEJRNUFYNERMYS9hbEd0Rm1tZStsaGQ3NitRY05XOGRxM2g3?=
 =?iso-2022-jp?B?ZER5eE8zZGJpUGN3Ny9KVUs1TzFEM09mWEJFUkQ3b3B4MGR5dUYzSTR6?=
 =?iso-2022-jp?B?ZG9IeS9IYTJNNzdLUDN0d3phMUdiNGhSenozamVwQmxUWjA1UUJWWVVk?=
 =?iso-2022-jp?B?VHFiVTRMckthKzZaUk9McTBmVE5ZYVhmSHQrU1Q0WGZTaUpwL212OU9m?=
 =?iso-2022-jp?B?cFVCR1JHZFcwUEZaTC8wS1c5dVoxdmdYZjlsT3AyVjRSQTNqRlMrRmIr?=
 =?iso-2022-jp?B?SDFRM2ZVd09GbFU1Q0I3bXZZSEJLaDBFMUcreE5XM05JaGt0Z2MrZ1NK?=
 =?iso-2022-jp?B?bDJGQi9neDFEd29WTXBsWGJLNkZZUHREcUVWRjZxMUVTYmJaRTJnTVhT?=
 =?iso-2022-jp?B?ST0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cTJueGozV2Y3YzUvby9BbEgwd1A2amZrcmJveHpxRHR6OVN5Q1JvL3dV?=
 =?iso-2022-jp?B?REpXVWZjbXMzcVlFSW1oZDJub1JvWlNubzh1M3VDY2pmZDdnN1l0L2RL?=
 =?iso-2022-jp?B?aEZxVm1YZCtiYS9lZmVqaXV6a3o0bGtTWStSdERwLzR5WmVDUTZCSmox?=
 =?iso-2022-jp?B?YlV6Y1ZKNnRjajVRTXhiYzZrNm9aMzI4MmQxdTNMZFZRUEEzSXVuMUhX?=
 =?iso-2022-jp?B?NzFReDlCejB1KzZhS0NtcGhINEpiZ2wvTGREbnhjZHQ4Nk93SEY2VU03?=
 =?iso-2022-jp?B?QnNDcUQvRm5NL0M0ME5Sc0NMb2pjQ1piVmRseHJlVkdUSFJ4WldXQ2t2?=
 =?iso-2022-jp?B?bTRGcWZ0c2FDUnEwVEFyZ3pjWmgycHZYaWNiTVdETFBFVm9tZnN0SUZ6?=
 =?iso-2022-jp?B?RTBaWU1ra1pZZzNEbUNHeVQ3SWF3bFpPSzVtYWpCc2NzRUdWWTlvZjRM?=
 =?iso-2022-jp?B?bG1yeTFHekVjUVVtQWkrOUZpdHJ2c0NLbW9OWTRWSE9qZkZSUFBYTytj?=
 =?iso-2022-jp?B?MTFuQzRHOWhadmJtQm5pMVZQNzJxbTEzUUNSdUcvWGlXNGdLeU5VSUd0?=
 =?iso-2022-jp?B?aGFYVXlSR0Q3QStTVFJ1UlZQVmNPS3dGUDM3YjExRUNwUHUzaXRxb01m?=
 =?iso-2022-jp?B?U2xkSE15V01SbEpMQ0ZoZlR4OTZEazE0R21NKzNNY21Cb0x4WlJZYWpL?=
 =?iso-2022-jp?B?RGtsMkFFdHR5NjNSeHZTejFNMEZNQnZXS2VYYi9oMkJnTjdGVkNUcExi?=
 =?iso-2022-jp?B?dGFIOHpMTkpRaEttM0xianFaUU1NcW0rV3J0YnBmOW5EK3FxZVZHMmJt?=
 =?iso-2022-jp?B?d3BWN0E4bnl0MnpYeHRQa2tqMTVyNUluSERNZzkzaUR0L09ZV1FFUWhj?=
 =?iso-2022-jp?B?UHBiaTNUdWt0QVpiYjRhNHplVVU3amZkdmgzMnNkZTk3VysyNWJvSUlY?=
 =?iso-2022-jp?B?RGFGZDNaWTRSSEhrRHJyUVoxeEJCclFPTXB2Sk80dDNCMVEzTkJReHg0?=
 =?iso-2022-jp?B?T0ZGQjhqMGNXUWtSQTZqSktMMlZHUDg1K2ppQzNkMUtDL0ZESGpnOFZF?=
 =?iso-2022-jp?B?T1RyZVlmUmVKVngvV0xLRnNWYVpHZXh1bVJZSGxvK2dpVE14UERKYUdq?=
 =?iso-2022-jp?B?MkpmbGtwM0g1OHIwQXFwbHVsRC85MWNIMnpyS3grNmlIMHZ0dmdWR0R6?=
 =?iso-2022-jp?B?ekQ1ZmhtZDFpOE0zcDlzQlhsNVE1bEcwQ2I2SHV5Z0pPV1Y0cWtDdUg4?=
 =?iso-2022-jp?B?QTRZaGF0MHErcHNBQlZPdHc3dlVidG9zc0xvMU5GUDVjdm1RbENoRWJ0?=
 =?iso-2022-jp?B?SldDaGZUSG5XVXFOOGZvWFlWOXZTU2dub0FlVFZQWFpMZGVEeFZwT3d4?=
 =?iso-2022-jp?B?bEZUR2RVTHFBYVZ5NzA2aTZsdnNIVmRoT0FERW5LeFZoZ0kxdW1ZdGFD?=
 =?iso-2022-jp?B?eHpXbkloa3p5dVFGNnErOFdKZVcycG1wNFlXUzcvaXJnNnhMTXVDSnZI?=
 =?iso-2022-jp?B?OFduR2FTNll6VWxGZDEvZmZmRWRkMWY2eHQzc21pUGIycEF5eHVJVVE4?=
 =?iso-2022-jp?B?SmN6eUNvajExL3dFRk8wdkJDTzhnWllycGZtTmtMYVhoc20vN0pndmRr?=
 =?iso-2022-jp?B?OHgralV0OGFGUHdzOEJUOE9TR0lrYlhINXhBWnY1T2lUOVpRWEsydFRJ?=
 =?iso-2022-jp?B?QjZQT1piY3VHSDhKL0VSM3ZISTdrWmgvR0czalVLT2NiSGk0cUswbGE1?=
 =?iso-2022-jp?B?WUNIVzY5RTI1ejlhbWI1VWMwR2RFUHpUUUR6QUlZdXBESzI4cDR4cDcv?=
 =?iso-2022-jp?B?WTVnaEh3U3Vzd0JhZWNWb2pYVC91d0UrRTEwV3BRRXZTZ1ozNUQvZndH?=
 =?iso-2022-jp?B?bXptcEdPT01yWnNndHpQVGxjMHNIOTU3dFQ4TnYrSEpudjNkdEZXRDhp?=
 =?iso-2022-jp?B?cGVWSExHZWpUbTBQMXdVVFZLaXdhZWxNK0xWSk9iWmhpUXFDZ2hzZjd3?=
 =?iso-2022-jp?B?bEd0WGtxdWZOWE5scUNhd3Y4ZVl2dXk3SHRVeUd5d3dCcXpVdWxpUExi?=
 =?iso-2022-jp?B?R1F4OFhRb05wMEUyclFLaDZub0VGdWZRdytpM2VXT3JuRlJQTWhXT2Fu?=
 =?iso-2022-jp?B?K2cyMVovVnM2MFkxL2ZuWWZQbW9WTjRVOGRKZVlDd0NpUVFPcHBzcFk4?=
 =?iso-2022-jp?B?T3VNUlA4YktkQ3hsWDZ0ancwNm1kWkdnR2d3cDUxeUprOXpEWkpZQklZ?=
 =?iso-2022-jp?B?UmE3c1h3VWhtR2FuVGdVT1ZwenB3TTZGQUkvVTJrSFJXSWxWamFrQVJP?=
 =?iso-2022-jp?B?bnhmWG5VWDlEcnF3Rm1Ca0xoenRCeFBVRHlLd2lzaDFRczdUM1JMUEd5?=
 =?iso-2022-jp?B?Mk5KNkh3Wm5UV092ZngzUGV1RkhKNDg5SDRtL2lMVlZTSDR5NDNDdkxP?=
 =?iso-2022-jp?B?VkVsNlFnPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610349E8EFC2F9E8ECEBD450C2972OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd49f6b-3c49-4d98-6e84-08dcc8ae3123
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 04:42:45.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Trelkohz32HlmtrRpzDY5u0pslGp/9XUwrrYuV940N4kiR2aFxMdSFG8qUdA6h5Tq/9o0t1v8eGYBecdN5ctSxhRvmMMyBmaco/AbmmJB1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Aug 2024 04:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16835

--_000_OS3PR01MB610349E8EFC2F9E8ECEBD450C2972OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Here is a job which I ran while submitting the patch. I used =1B$B!H=1B(Bsm=
all=1B$B!I=1B(B runner for the job, and it ran successfully. Yes, aws sync =
happened -> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/75=
60258605#L664.

There was no issue when I run this job with =1B$B!H=1B(Blarge=1B$B!I=1B(B r=
unner but since that is not a solution to this problem, I thought there mig=
ht be some issue with the runners as the job failure message said, =1B$B!H=
=1B(BThere has been a runner system failure, please try again.=1B$B!I=1B(B

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Chris Paterson
Sent: Thursday, August 29, 2024 7:35 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>; Adler, Michael <michael.adler@siemens.com>
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners

Hello Sai,

I=1B$B!G=1B(Bm not sure of the cause of this.
The job is quite happily running on that very same pod. I=1B$B!G=1B(Bm not =
sure why the pod would be destroyed before the GitLab job actually finishes=
.

Do you know if the final aws s3 sync actually happens?

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Thursday, August 29, 2024 1:54 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; dine=
sh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>
Subject: Issue with 'small' Gitlab runners

Hello Chris,

The cve-checks job in isar-cip-core uses =1B$B!H=1B(Bsmall=1B$B!I=1B(B Gitl=
ab runners. Previously, there was no issue but recently it is getting stuck=
 in the middle with this error message -> pods "runner-zwslwy9eu-project-10=
191315-concurrent-0-n51tahuh" not found.

cve-checks (#7693633828) * Jobs * cip-project / cip-core / isar-cip-core * =
GitLab<https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7693633=
828>

Can you please look into this issue ?

Thanks and regards,
Sai Ashrith Sathujoda

--_000_OS3PR01MB610349E8EFC2F9E8ECEBD450C2972OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:KO;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Here is a=
 job which I ran while submitting the patch. I used =1B$B!H=1B(Bsmall=1B$B!=
I=1B(B runner for the job, and it ran successfully. Yes, aws sync happened =
-&gt;
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/756=
0258605#L664">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7560258605#L66=
4</a>.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">There was=
 no issue when I run this job with =1B$B!H=1B(Blarge=1B$B!I=1B(B runner but=
 since that is not a solution to this problem, I thought there might be som=
e issue with the runners as the job failure message said,
 =1B$B!H=1B(B<b>There has been a runner system failure, please try again.</=
b>=1B$B!I=1B(B<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> cip-dev@lists.cip-project.org &lt;cip=
-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Chris Paterson<br>
<b>Sent:</b> Thursday, August 29, 2024 7:35 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span s=
tyle=3D"mso-ligatures:none">) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; hayashi kazuhiro(</span><span lan=
g=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:no=
ne">=1B$BNS=1B(B</span><span lang=3D"KO" style=3D"mso-ligatures:none">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"KO" style=3D"mso-lig=
atures:none">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligatures:non=
e"> =1B$B!{=1B(B</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&q=
uot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span style=3D"m=
so-ligatures:none">=1B$B""=1B(B</span><span lang=3D"KO" style=3D"font-famil=
y:&quot;Gulim&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P#S=1B(B</span><=
span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><span lang=3D"KO" styl=
e=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P=
#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(</span><span lang=3D=
"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG Port=
ing) &lt;dinesh.kumar@toshiba-tsip.com&gt;; Adler, Michael &lt;michael.adle=
r@siemens.com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners<o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">I=1B$B!G=1B(Bm not sure of the cause of this.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">The job is quite happily running on that very same pod.=
 I=1B$B!G=1B(Bm not sure why the pod would be destroyed before the GitLab j=
ob actually finishes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Do you know if the final aws s3 sync actually happens?<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none">Kind regards, Chris<o:=
p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Thursday, August 29, 2024 1:54 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a><br>
<b>Subject:</b> Issue with 'small' Gitlab runners<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The <b>cve-checks</b> job in isar-cip-core uses =1B$=
B!H=1B(Bsmall=1B$B!I=1B(B Gitlab runners. Previously, there was no issue bu=
t recently it is getting stuck in the middle with this error message -&gt;
<b>pods &quot;runner-zwslwy9eu-project-10191315-concurrent-0-n51tahuh&quot;=
 not found</b>.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7693633828">cve-checks (#7693633828) &middot; Jobs &mid=
dot; cip-project / cip-core / isar-cip-core &middot; GitLab</a><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please look into this issue ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards, <o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda &nbsp;<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB610349E8EFC2F9E8ECEBD450C2972OS3PR01MB6103jpnp_--


