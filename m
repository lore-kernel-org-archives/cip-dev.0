Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F77CF31BF
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 05:29:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.4776.1727933344349065618
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 22:29:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=B4bEOU5c;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727933335;x=1729142935;bh=zIxflIbX4nCoc65DOsbMYBxUrH0ec1a03FkJAXM
	t+I8=;b=B4bEOU5c7mXw8+ihUPTaNf+udv1Ll4QOPkNqAcdOVBwhVyR1A7ISLuakfBJny14722Cf1
	VRKw5eQ9aQSXRwgYgFq7LESgkj2cqSNEipJZDEbLyJ2gtfa9foM6ABvaLJDEnyEHegpgBVOH4eIdE
	7SWiFQfkUT1KThG251ZEsRPNO9Yuk1zrBQnJU3o7JloeJbGRzx1DMC4L9y9WaBE11F3eBtSjr7xZY
	T36BQ9TJ4wzbEy1Tmk21jo1mYlmDUrlKmcozcdXvPI94y8HtTi/p9OOI5wGAlkj9GXaZQPFshICen
	b6JjQ6XsDUByCAjuGyAdyLDesdgp4Db1v6HLoDLSJA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4935SsiJ316533; Thu, 3 Oct 2024 14:28:54 +0900
X-Iguazu-Qid: 2rWgGN9FKWW1kcBXzk
X-Iguazu-QSIG: v=2; s=0; t=1727933334; q=2rWgGN9FKWW1kcBXzk; m=RQ6kSBiAD8lYSANSo6p4IhTUIx1ys2pJPnwBH0TQ6zQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4935Sqjt757318
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 14:28:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFsRM/tt/NedOId9HRcYaaWgkSeSPUTXOAh2Nzk9kRnd0lfrZ9vzRtquHECfy8dGae1jxTN0j3tF2+Nk69hGU/X/bZmxZQpnDf3rUxV9jYBNvATXMoLKmRCMDy/YnltXqnwQyUTqsnNkYxRq3mhA5rqs/anpCMrRU5qwm1OB8auk/uVwI6jfcxvW7cOYv1sdk3Q3WROHOBIjP/cwD3KecrirdzLiOHY22TJ2mA69WioeTtPq0iXnhhWprJzOVZoiEYyO2Za6n5qlh3LoHiWMuDrBsUD7D+lgXRknA+90CMgCukJDH6NB84Htu32oKDU6VPtH4DYETZV2X2TTBG2tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6I/Jewvo7DlFDuept43Tyc+E+c5jMsV9/g/nctoGyI=;
 b=MMNp/cYTfPnoW+KzuiEn7zZZYcrmy0FR9HTk15g/SgzklJABUWVsj0mBZ3c4OX2nYi/UcPUdVwwqeP16mXFKNvkzkenATfTWoCATXtJO2cWMi+/5KJVGEFa6bHFUsEPw9tK8II4x5YLY4howalgQFN//sTOGm2QYdhnYqa0imtSnij2q0LaKyEFRwa3gKDZ2bvcfaUTuGoO4uUXZi89y2NLoqVqbG0dO2R5L+sX9iPOFtKs8NcIPSa04BJcbfgjI5bBFW7GSw8U3nBViFr4Znf83gmoAxKimyfUlJadF541FQDkkt+4ZvZtHW2ytdhC7Hp6AvPfOHv0RgKKZzHOsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Topic: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use
 dev_err_probe()
Thread-Index: AQHbFO0oFhZ4e4Daa0moi4dWCw9YgbJ0fs8Q
Date: Thu, 3 Oct 2024 05:28:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63884F86BC0E7A6D2E3F980092712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
 <20241002170417.655339-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20241002170417.655339-3-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB9830:EE_
x-ms-office365-filtering-correlation-id: 2007b08a-7b7d-4f38-92ee-08dce36c4341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aERoQ2hlNEh0SEV6RGpuSXk1UjdGY2x4ei9HckEvdEc5NzVlYThEcVZr?=
 =?iso-2022-jp?B?VUtQdXZEZ1BnbEdvVEZVVjR5THVabzdmZCs5MnJXM2hGZDBZem1IT3hK?=
 =?iso-2022-jp?B?UzZybGkyT3ZXYVlna0J0TFBDMXgzL0ZwM2VQNG44dlo3eW9OZjJUYitu?=
 =?iso-2022-jp?B?clAybE5QM0VCM2tXdFNLYU1pczllYTRRaXZPaUQ3T0VraUk1aGhRSlla?=
 =?iso-2022-jp?B?eGQ1Vk5TWHlFN043QzFpMGZzR3VicE5BcnpSbUVOd2tSMXdzUy8vbUty?=
 =?iso-2022-jp?B?V0ZlZzVtU3RCRHZNelBFdGV0OUJNTjU3eVVEYnF6Y2E2ZlNXUmJhQ0xY?=
 =?iso-2022-jp?B?QWFNV2h0dXJwd3RKVWxRdWtaUGpVN096VWFmTjNWZ3p2Z01Tb3JJOEZt?=
 =?iso-2022-jp?B?d1ZsN1lweHl0L29oSUQ4SFd5NXlzWHh0V0pQRzZjOENOTlNuWkYyUlVD?=
 =?iso-2022-jp?B?TStIWk93N0pUMDFDNGp3YXAvbkQ2Mi9GTTlJRjdoSHVlZ3F3cUt1cXNJ?=
 =?iso-2022-jp?B?VmhVc3R4RHRMcG9SakkzSEloOWhmQnNjOXpJbUFrSGhOZlhnNDZBOGhi?=
 =?iso-2022-jp?B?M3haYlg1dFpuNnVYWG55bmxpUWw3b29PY0VJVjlFbGcwcVlOaVpiazdu?=
 =?iso-2022-jp?B?dHZld3duWGlXOGhocFJLYmVqL2tkemtlUXFKRHBaRjhmKy8rU0Z2bEJ3?=
 =?iso-2022-jp?B?cjRvbkN2L0RtVnJKYXZRK21mWkFNYTE0MWdmL1h0dktKWTNlbkpwUERw?=
 =?iso-2022-jp?B?OGVqQ0RDMzl6bUQwTlNLUHdPeGZMekNWM2x1VTlrQmRTcnZFMis3YW5L?=
 =?iso-2022-jp?B?MGZXVE9wQ3JuUFQwWmZDc3B6eTFTbjRrZW9nY2s0T2xhV1FNaC81K0F0?=
 =?iso-2022-jp?B?RGdLNDIyZDdZZ2c3NVdDTk80S3BLbGtwa1RyeXpDRHZ0UTdmT2NkVVF3?=
 =?iso-2022-jp?B?bDdkOUUxR0xDaUxqZllUczNDMmxjYXRJcEIrcUZCeVhZeGlseFF1S3NN?=
 =?iso-2022-jp?B?N1NqTkJ5RFhwMTFZMDVabG1SdXJyaER5NUhOSGx5b0lKc1lGZUdZUmlL?=
 =?iso-2022-jp?B?dXhQQzVxOTVzSXZjMjIzTi8vTWk0QlN0VG1OTnJxblRqME84dUV4VGtF?=
 =?iso-2022-jp?B?dW13cFVic2drSkJDUGQ5eXQ2WXBLUS9TU1lIanZJU2ZKQW5Fek90ZnN6?=
 =?iso-2022-jp?B?d01QRWNwMCt4bHhpSVM3dmw2bHFkWHVTc2ZORk9NQktldjZlVS85OG95?=
 =?iso-2022-jp?B?cnVIY3ZBanVIOTM4YU9XMjFnRGhnUE9rMksra1Uva05majhPc2RPbjBK?=
 =?iso-2022-jp?B?MFZwRXdFNU9FdDZBWkZuVmJ0VSt3UjNTaldwdnN5NllES2VJQzcyMndY?=
 =?iso-2022-jp?B?eGdEOHkvUE1tbDNmRjQvOENURW43Z2Z3dWM1Y1dNdzZOUWZJSjAyTUxo?=
 =?iso-2022-jp?B?WjFHNEtoUmk4WDhFckZKWHJ3enhBMzBRVnphWjgySHNVb1dDT2g3UnlL?=
 =?iso-2022-jp?B?M054MkxCUDI4aGw0cUJ3Nml6ZUpwNW8zSWZtY0c3cy9QNE52a2dNSkZQ?=
 =?iso-2022-jp?B?QjdOMW45MUJjUE55UGpZRUhkdU9mc25vU1BmWVFEM3VwamFkdW50RVBY?=
 =?iso-2022-jp?B?RnB1eWg2NHh5czRYYjlmMkIrNE90OUxucnBtdGpYQ1BUS3dEMmNpN2dO?=
 =?iso-2022-jp?B?Tng0cERRM2kzMjhkNjc2dFVDZEwyUUp3NDZFQmlnVDllc1lycW5WbjRB?=
 =?iso-2022-jp?B?Snh4dlRuOGNsNmYzeXV1YXlzbUo5bVdiL2hMY1RxQzNVTm44S0JKc280?=
 =?iso-2022-jp?B?OTlLa1IwOWJheDB6UHgyemcwWW84Qm5rN0d2MFV2NTFBRXUwazhhWndJ?=
 =?iso-2022-jp?B?QmI1YStlTU1sNStkZzMvUDBTRzZJSi9IcTNhVWR6ZlRLS05FWnB1Ti9h?=
 =?iso-2022-jp?B?REplSHN6MVBFc0I2THNZL3Q2U2J2dnlwdW5pM3c3dkFDYnBUcHVjYVZo?=
 =?iso-2022-jp?B?Y09CQlJRRnh1ZTY2R1R1T2RpMFB6Ug==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YlZjT09zY2syMkVVeWdxT1V4YmJOeGN1YTlSTnhZZFgrU0ZwZGFIZll2?=
 =?iso-2022-jp?B?cFp2Sm0wUGt6V3BRN1JiNXFtdXhEd1FUSnhSdGRLMWp0aURINkFnYkxC?=
 =?iso-2022-jp?B?VncycVFhQ2lMQW1RbGJpMHFSdHRNUTMvUDNQb05lOHBFSVZ0V1VqU1Rn?=
 =?iso-2022-jp?B?cVl4R3p6Mmc3RFRaT0NvUXVBeXY2Ykk1ZDBRTW5YeFRPd2ZjYjAzeXlW?=
 =?iso-2022-jp?B?Z1FTdXE3ejEwTDh3QjRGMno0aFkxMUVJcXBrN2l2Yk44MmYzM0lqUHF6?=
 =?iso-2022-jp?B?dk1iWDFvNkFrODZKbHFSMjJycnpIMFFRb3JWai9Od3JrZDFjOVM3MmNs?=
 =?iso-2022-jp?B?VkcraFU4bk1SNVhOWlRXRDY2WTdHeTR0RzJvdGRYQVpvUW5vcEgwSzVj?=
 =?iso-2022-jp?B?MGRDSkZoQVB3cTFJVFRwVzJDMXdwazl4YW13Nm5CR21VM0hwSDRQQzZz?=
 =?iso-2022-jp?B?c0IxTmZaUUFRSVVqQ0JTcmkzU01KQlRvSm1CQWdpb0tPYkgzSUJVQm5u?=
 =?iso-2022-jp?B?VkttTE85bkVpTGFkbzdseHBVbnhVNUZ2VHdKWEFxZmFOQ1VJYmZTSGR6?=
 =?iso-2022-jp?B?UUFISFI2TjhDYWdFblkyTXVBYThrVmhBU2RFT1Zkck5YUHAxbDdlM3Fy?=
 =?iso-2022-jp?B?NTNHWlExa2JZNXNUVTEvdDhWeGpNNmIyKzhncExEZlpWblJCSlVTa1NC?=
 =?iso-2022-jp?B?eitZUUgvVXlVNXBlRTZtNHdLRGdScUxCOGRnSk5jZHBWWk1PN3d2eFIw?=
 =?iso-2022-jp?B?ZjdzSTNqYTliQzlFSnJ5N3BVRTdLVk55K0NwUTE0S2d5aVF6Qndtd0Y0?=
 =?iso-2022-jp?B?ZzBJUENoOVZtdjZlOWVycitIUEQrMnloWEw3Y08yNnZMWjRhWFg0SWtE?=
 =?iso-2022-jp?B?aWtBUGVsSUZIUWYyR052bXZyRElSNjlCWXFtdnpsWHZFSkV2Vm01aWxM?=
 =?iso-2022-jp?B?UkVMajBIZVlQYUFNTENGTXNUT3JWSzhKZzZDRmJ1REgzV01UTHFocm1U?=
 =?iso-2022-jp?B?WUFwcU8waXVaSjU5UlcvZmJDbkRMT25KV0UrbzM0M2VXcVBrcjBtTkg0?=
 =?iso-2022-jp?B?SkhaRlVVc3pmK2ZJUCtWdWl0MTVXYk5SblMxelZkeWVQc1ZjcWpBeEhQ?=
 =?iso-2022-jp?B?ZkIzN0R3TkhCK1R4S0NYb0ZQcElXWkpDYXRzUUszd3NnVmNFODFKR3Jt?=
 =?iso-2022-jp?B?dzBXV2VYbmx0SHYyYTA3U3h0L2k3cG1kTkdzL3cra0svOUxLREd6cm01?=
 =?iso-2022-jp?B?ZkZTcnpnWTRvQTNabHlhdjM1YlNFWVNSYXpDR1dwQWtVOTh6ZmlleE9P?=
 =?iso-2022-jp?B?QmtmSGZYcmxBS3RDOGdrbkpYZ3ltbEZYL0ZLdVVTb1MwTW9wZkEyS0Zk?=
 =?iso-2022-jp?B?dFQxYnpoeVlnd0Rob3RrVXVLbWVUTzJUZWgxUER6ekdtSDFVbHVtejhZ?=
 =?iso-2022-jp?B?Z0pYc0NtZkNKTU9FYjBkek5MR1hzenlqK1pwdVFUUFozYi80TzFwRUNr?=
 =?iso-2022-jp?B?ZmhrYjlzMUFHNHZyMjc0RCtJbWFQUHRUem9pWGVUZ2M5MnNrR1A1czdZ?=
 =?iso-2022-jp?B?ajNMbGU1dHJMWTVPR3hTa0FXU0pJZk1YaytyWWJ5S1gvU1h0VmZyM3Js?=
 =?iso-2022-jp?B?bXYyUklTYkVKZDVUMTI5YUp0SnZnZ1RIc3g4MVIzTE8yaGhBTmJtaGw4?=
 =?iso-2022-jp?B?UTVvNWtXbkRlMm00d0xkWWlyVlNGRjZ5MXI2Mm5Bd3lhRVgyYUxjTG9U?=
 =?iso-2022-jp?B?N05NMmsrNFBJV09lZ09EdmJwamkrNmFsQW1ReGtEUWVIQ29CMmpaMHc1?=
 =?iso-2022-jp?B?bTdQQWdaNWVSei9MeGF3bnI3alJSdWduWCsvOXp2bHVRYXVwS0I3Rysz?=
 =?iso-2022-jp?B?aHh5TTNnWVhoQ0ZscWxyLzBKRktUbkdQQjVybEJCeGREbjZKRVg3bitF?=
 =?iso-2022-jp?B?M3NLYWp1N3VvUSt6VjBmUExLYmdkYm5zVEU0QXQzamhSdlpFSkk2UTVJ?=
 =?iso-2022-jp?B?VG1PNEQzc1RpVHBvaWJnZ0tjVEtVSVZqY1JWUzdpVUFjSTl0c1dub01E?=
 =?iso-2022-jp?B?MnAyRU14NnN3eE1KOHVabUpjSy85WEhMZUQ1ZXYxd1lMcjBjTUhnN0V1?=
 =?iso-2022-jp?B?STZabWlXV0lsanlJam1hbEsweFc0andDdTBESWhSdHJ0cndIWkdWVDdR?=
 =?iso-2022-jp?B?SUQ4MUc4NTRuNUY4VUlaOWJ0NGJOMGNqODRNczQ5MVVkOVViaE5qTmJJ?=
 =?iso-2022-jp?B?cURKdFJDQm5BVmUwRzkycEF3czBJUXdyOGlCUnZ0R0djcjJFVGRmNDVt?=
 =?iso-2022-jp?B?azBHeFgvQXBmT05qT2NEY1ZVVjBJTElCZ1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2007b08a-7b7d-4f38-92ee-08dce36c4341
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 05:28:50.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiY8A8cHkeYOAb2p+gyyU2umw/hrV3WWjDhX1OFZT4m8MEpkcFoSrr/htl8aobRtalVSjaJaUkgwQMyXiSc+2NWCnKjOYQg43MpPicpu6ak/ndQeSapUerFQxhnTjun2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9830
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 05:29:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16982

Hi Biju Das,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, October 3, 2024 2:04 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 02/16] pinctrl: renesas: rzg2l: Use dev_err_pro=
be()
>=20
> commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.
>=20
> Replace dev_err()->dev_err_probe() to simpilfy probe helper functions.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++----------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 6f49da4bd327..0cae3e75b26a 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2200,16 +2200,13 @@ static int rzg2l_gpio_register(struct rzg2l_pinct=
rl
> *pctrl)
>  		return -EPROBE_DEFER;
>=20
>  	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> &of_args);
> -	if (ret) {
> -		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "Unable to parse
> +gpio-ranges\n");
>=20
>  	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
> -	    of_args.args[2] !=3D pctrl->data->n_port_pins) {
> -		dev_err(pctrl->dev, "gpio-ranges does not match selected
> SOC\n");
> -		return -EINVAL;
> -	}
> +	    of_args.args[2] !=3D pctrl->data->n_port_pins)
> +		return dev_err_probe(pctrl->dev, -EINVAL,
> +				     "gpio-ranges does not match selected
> SOC\n");
>=20
>  	chip->names =3D pctrl->data->port_pins;
>  	chip->request =3D rzg2l_gpio_request;
> @@ -2241,10 +2238,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctr=
l
> *pctrl)
>  	pctrl->gpio_range.name =3D chip->label;
>  	pctrl->gpio_range.gc =3D chip;
>  	ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "failed to add GPIO controller\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO
> +controller\n");
>=20
>  	dev_dbg(pctrl->dev, "Registered gpio controller\n");
>=20
> @@ -2325,22 +2320,16 @@ static int rzg2l_pinctrl_register(struct rzg2l_pi=
nctrl
> *pctrl)
>=20
>  	ret =3D devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
>  					     &pctrl->pctl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "pinctrl registration failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(pctrl->dev, ret, "pinctrl registration
> +failed\n");
>=20
>  	ret =3D pinctrl_enable(pctrl->pctl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "pinctrl enable failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");

return dev_err_probe ?

Best regards,
  Nobuhiro


