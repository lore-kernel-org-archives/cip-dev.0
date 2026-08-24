Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C0C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:09:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12766.1787562594448046449
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:09:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=uovPCc0s;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1787562591;x=1788772191;bh=HdIqj7Ltv2HjppPEGsx6BSOr1AB66jCfyjryj
	qkqJ6A=;b=uovPCc0s+jm3PXn8TzwOLmdvxcEOTPedrXtKyHoQn92PeQ3fY6aqsMRyIpwXvWuiuKp
	Of0Qqb/lMaUk5WQQJnM3Tdw0+UFxJJjeQkXp4yJxj0+4VrtOKmSymcMjh80/0hNpaV/eHKDmtTnte
	mgcWQEU3F3neiE33laca5wCR+nGtwU/HEksjs5YLcqKoutBf35GesRiYQazRPMHGt6UVhqttOxfn2
	wbdTVEmudKEc6fX/refBihYj/ZMK8Ai76zKVAWtvlMSshPqVEtkhpCGWwUoay477oyCnHmdadn0Mh
	5rEO1WTVF4KbRkuuKQO/5rABVS3xUsWAU1+sQlWs+J2w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 67O99pWj760642; Mon, 24 Aug 2026 18:09:51 +0900
X-Iguazu-Qid: 2rWhW3h7paA4cob477
X-Iguazu-QSIG: v=2; s=1; t=1787562591; q=2rWhW3h7paA4cob477; m=BQSWTfe66YUnoV6U0G1jPTSCThj5hFuRkm+8QK4jR1c=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hT4qf5wsVz4vys; Mon, 24 Aug 2026 18:09:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nedatqOMDalJOdikmLLRfOWj/oYcrYxtSa/oQn13m1ecRoO08EyqpJ9XsOGj7xsRTdJMdHJHsi0+hVCDkPlieF0YIag1RZCLDCOgtyQuLwtqT0f+tPC6H1pfmw6ZaqLqrr4wyCDKandCAFhAXM35IFABJYVqQOASdNDK7tUdcnAqH6CgWaJ6MvWCpVAsH/REG81rIfgwgoxzEEA2h3drPp3pTV7IDbKgIl6qrWnXm3EtRpxRzsrt8i5hBkv1Y8QR4VSpkBo3IVx21rfrmUFBnpn5BPLdp8kbS6IKNJoPz6/W8SXBcBqdo+9tHE6GibuB6S6Ytwa/6gvcMrVrGww6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXa1WO8ZSP7PRhiNe9szpaPUVQYJxdzHgHzyu5a9TZc=;
 b=OhoHEvSrSyeVRdZrjaNmOcoYWDoZf+GRLIIn8l2Vr7VXKQecNdw8TInh3INrOtaYnjLZ5ioBWQFNyTUBUHe88/mIky6kDn6OjAnCAWCyvcVOpx7RtS/koF1OMFmCKbhKHZN/heN2t6nn4F3U3xNL86EJgtIDOYHxw3ZaVVz1iHoJrco3lhm8mNr3O0cY57BOo3LZ4d9fB92TZg+ovps/SYSbx4g19ai5j73vGcLtjBbBBkyCfPk9OtybQFA1MH+IzAe5s0PVFk4lvPjpG1u/BWGtU3rqS8OifQLmjABXsL47O0uc8VWKmO4/GubaSD+zZ3rPB5O30OqprXvb/k17XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <cosmin-gabriel.tanislav.xa@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H and
 RZ/N2H SoCs
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H
 and RZ/N2H SoCs
Thread-Index: AQHdMW9bo/4wiqdVmkKQtP/RxxP0pbapuMWAgAK13SA=
Date: Mon, 24 Aug 2026 09:09:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186ABF5271325B7E7E7AD9CDA02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <aolZq2gonRLG4U4k@duo.ucw.cz>
In-Reply-To: <aolZq2gonRLG4U4k@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13449:EE_
x-ms-office365-filtering-correlation-id: b6659b5c-bc30-4e1d-3990-08df01bf7272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 kK7ktJHGAISPjfKo5Zp8OL6idV1M64W5iW0+V7+AAynKG8knlVVADkk6EFmSseJPC9bT++UcmiikXuc/4aVoLSDg8cdY8N0yQTiauXkcWyUsdssgUdIH+wuFVoIw814Ok6Zm9DOR2gHRbw5yU6/9pjQj6Z9H0XhKIDmvAISbpns/ixxXFPXdfPWNT/IGVWpBAR3dffWrggarIo4DP6qyWQnGurraVJm2zZE7s/U5x7ovRfZrgEmkS6+UGrBH3w5JP71VswaxfSqB3TqXxV1Qgr0Z+AXjjgqsjXCxTdd84FQkx1UlCexubbdNrfokSwAcq368FcPbFRaBymWIR8TtkUbzVGPOEEsFmmq47NgPtMLDz+1hXJY/sRp6u6S5xsiMCCceTh5pudaKp/9XtPdTjFdoPMb+RktWkLZlFSchUPYLdOxU9LRFgVZSkLOBgUNJJX1Q8nYiE6MQieuGIz8937tkYDtrLhBFEK6NVZAWrJuDQqqwiYPPs1lJwSY5l4pOEZvlfCsq9bDiKBgjIP3q8+0P9+tB0sa/5pCBIAXFLKJDZmZEriGYoqzsZMlY/rnM7DqZKjgUAGOgAJH1Q83ybp/4uau8utpOqwXwff29f92I1upbYDvBmRi66P/zycaf7Ea/1FhDo4nQvtGWyGCnFaVbLnqJJrTW5H+mRK+jiR4iTBAokJxeHHSXgQQL3Txu2/2mX27ptt2q+U6siBfUlQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ckIxNlBaMGczN216d2RFcjJYNkhYT2NtaUhkNlJCbFF0QkJKL01YbWd5?=
 =?iso-2022-jp?B?aElaa3pYS2ZIaXRwaFpZRlZEcERhaTk1cDdrMVpnL0crU3RhK3BLQXR5?=
 =?iso-2022-jp?B?RS9ncnZzTnZFY2JpSEJtaCtsZkdHdlBzbkNldk9FdEt4SDF4M2g0ZE90?=
 =?iso-2022-jp?B?bXp4NVNGWjNLY3lTcUdVSVF4TU5jMHcvSW9MMkh3OWNjVWt3VHY3SGtN?=
 =?iso-2022-jp?B?bGVsamcwaE95WVI4eUtaSXA0SHRvdjUwbTVUREhqcFJVQWFGSElqNXpR?=
 =?iso-2022-jp?B?czV3VmE5TytlaG8yK1ZFa2I0WStxSXc1bi96RXZKVWxCSnJTUDE5Z3Nn?=
 =?iso-2022-jp?B?aFRiYlgrb3pxcjFqRXRVUU1ZK0RjVEZKdmRtaHpvdDcvMTRqL2J1eHk1?=
 =?iso-2022-jp?B?QkZ1UzNQTElBZmQ2Z0tpQS9mMjZPQUE0QlkxSFp0YUg1UGdSTVUwQWJO?=
 =?iso-2022-jp?B?OGV6OW83NERxNlZYZEJNNk9vd0FzNDlVVzlsN05UYS84bFg1d1IrM1ZY?=
 =?iso-2022-jp?B?WGthZ3NWMEhubERRU1ZwVXdEQmgvZS9rWXJITERTQUM5U09mZHc3eXcw?=
 =?iso-2022-jp?B?cUNCTkFiRTE5T2NCNlRyZTE4anI1QWtUVmtKUWlVYVNhYUpUWklWRGt5?=
 =?iso-2022-jp?B?UjhMaTRaQ1RvVXY4N0NWUGhzdStNTEFGLzNlMnJIZzZuL2M2MDdyaFVG?=
 =?iso-2022-jp?B?UlFmNUVXUVBOdDVoMi9rQXZtSTBtV0p4eXp6d01TMUd6Q2hKRE9FZFV3?=
 =?iso-2022-jp?B?TklmNXBLSEg1ZDhIUjdKNWRtdnhNUDFjYUVHUlFaN28xSmx2N0ZiVmRE?=
 =?iso-2022-jp?B?NDEzaVJpLzlyNFp3VHllYTdFSHMrVGpHN0pvZmVnT2RITmoyd0Q1Wnpi?=
 =?iso-2022-jp?B?VTBEdm9ZWGY5b1FvOFF4QWRGNU5MbG0yTUswbkNYOU9YMlR5OENUQkRO?=
 =?iso-2022-jp?B?SC9wNTNBV1JNdkZMZ0lUcXZnVWpSTkcweWd1bGJYdjN2U1F0bVM4eWw5?=
 =?iso-2022-jp?B?Qk1aTlZrL3o2NHFIYkJFNHFDdHJWVzBtSTd1TXVmc2ZNeDM2ZnQrRytU?=
 =?iso-2022-jp?B?aXhjTUhMSUJTdnNXd3JzS0NVNm9KRTBIK09HKzFlN0NpTWV6NVhXNXBn?=
 =?iso-2022-jp?B?TFJRRmhMNWc4QTlQMzduelh3alZsUnc2YlR2RzhPTG5VRldOcTFERGxX?=
 =?iso-2022-jp?B?VzM4YytNdW9CdVdHdW15VlZ3aXVqNFRjSGxDRjNPVUZVd3RXd0dwbmdq?=
 =?iso-2022-jp?B?WHdjU1UwZ2ppQW1WRUVvQ2Nkd1ZiMVlLLy9KNnVqY3VnbGxVVHV4UmY5?=
 =?iso-2022-jp?B?ejRhK2ROL2NscGpGbVQyRFlUUnk1M1ovOVlSTEI5eWt6WUdlamliY2w2?=
 =?iso-2022-jp?B?WEZyWTh5RDcycWwrM3FzL2J3M1krSDMweE5MNW5qV3dxZHJxL0RLK0dY?=
 =?iso-2022-jp?B?VlBxM0lBdzJpdXc5RXlzTllCeWN1enRCWWhPMnpYZkpLVkt2bmcxK1pL?=
 =?iso-2022-jp?B?NXdZelltRzEybDYzRE41eGVUZnRtWXpBTk40eHNtRkdpVUVINUR5SmhW?=
 =?iso-2022-jp?B?eitBVTVyVzJ0b0RPUUFhMVdkUjFMSEFJWnd5MURnSjdpNE00dE9XME1H?=
 =?iso-2022-jp?B?c0tSWUZGdUNHTTVraTBkUUtpcEhZeEhBT2VlM0pSSGhDdXYxRVdOWVFE?=
 =?iso-2022-jp?B?QWw3Sjd0QjFaelNLeHRIT3E4YUYzZitXT0VnMkN4R2dyeUN2b1Jsc0lu?=
 =?iso-2022-jp?B?VmZWMHg0S2VSc1A4cWF5OVhGYU9QR3dMY1Q0d05sMnVuZ0ZrMm1nTHQx?=
 =?iso-2022-jp?B?QktsejFOaXVaY3hncEtpSU95RTUxWHBybE1IVjhpQ3RzL2JVQmtpZ2VB?=
 =?iso-2022-jp?B?eTBPWU5rTUFRYm05SUhJM0V6U0FCREprS0NVRjFmaUJjZmxmbGNVVWda?=
 =?iso-2022-jp?B?dVVZdW9PZHJ1dFk2cTVFUEZTbWlpamc4UDJPZ2VJdHhXYVdXTmpOZkdD?=
 =?iso-2022-jp?B?WHg0ekZWb0VtYjhJdENycEhvZ1lDZVAzYjZ2a2JWdlNWSVc1Z3A1bjNk?=
 =?iso-2022-jp?B?eEpMSUhHNTFvRm4xQlRYSHhleXVmMC9GOFlEWFJ6ODJ6NnZTa0cyZlRD?=
 =?iso-2022-jp?B?OHFvSGFxclhwdldLOExVK1o5aEJFeEZvRGdKRmhsSlZYQXZYUXB1YnBD?=
 =?iso-2022-jp?B?cmtFZDFWTm51b2ZqRXlKY3ZnMlZZa3VBRmgrL2QxOCtPWjhCYUh5Q2hv?=
 =?iso-2022-jp?B?N0FrejVuWEhhVDE1dXJ4OFNTV0lzcjVUSlFOQ3U2c3dQVkpaVDZGa1oz?=
 =?iso-2022-jp?B?OHIvcmY2NXNnSUhEalhJYWhEaXJGK2pyNkt3Y0FWRmZDeWhwSW1TRFVi?=
 =?iso-2022-jp?B?QUR0cWtVTEx0TTk0aDBzUC84bjJHb1M3anIvOW9Fc1dxMzl2V2wyWGRx?=
 =?iso-2022-jp?B?Mkd5elFGd3czMHBNR3lNbEw4SGo1eC9GVHN6dlhmdFpIaS9SN0RoWUd2?=
 =?iso-2022-jp?B?c0tMbTFac3dOV0FlL3F4Vk1TTHBDcmd1TmJ0aC9yVUMvVlB3UkhiMXpr?=
 =?iso-2022-jp?B?Q0MvSWxxUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	lqrL5O930SPI6EgTUZa8YWMZjsPAxn0KXMyJ2Mup9KArHXCmBTuG9iEEDXlZHhaKxyNvTLqboh4mjvrxVkqQ17UiKDniLRkZqZCebK5URNlBXq7h/Wg+G6QR346imdB9PUa/d/zOKB09DPxM7pYo1+XMGk5noRS/fNa0DCPetibkp6KHCEXGeVT3nJsNtt/kxbY82JHrr5Af6oJ99jpSP5mjjA8o+7r9Hk74bHI5kMgrPKYnXUwHIg/dPrTxs5y1Sk9/FM7m9kmk2rypjep1telpQHHWngTSMfRqL45e5Hpy6uSIS9hueSzatdB2DkxrOmrESZHUmYEx60Ef3LOdCw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6659b5c-bc30-4e1d-3990-08df01bf7272
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:09:48.0050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnCFntOawM8yVwfeywAFhZtbzgtDzIfyRKarYuZmGeQWjSR3YhOLKDcUNM0VYyETUAbHgDtCA8xQup4KE4ca1mYSaBJi51AkUQSFplMbvx/ngkH1P4zk7qN6IC7Ha8TP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:09:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23979

HI all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Saturday, August 22, 2026 5:11 PM
> To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2=
H
> and RZ/N2H SoCs
>=20
> Hi!
>=20
> > This patch series adds support for the ICU block, including
> > software-triggered interrupts and error interrupts, as found in the
> > Renesas RZ/T2H and RZ/N2H SoCs.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I also reviewed this series, look good to me too.
I applied with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


