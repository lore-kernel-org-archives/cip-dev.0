Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448BC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 13:51:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.17560.1716472263317572222
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 06:51:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 44NDp06x945145; Thu, 23 May 2024 22:51:01 +0900
X-Iguazu-Qid: 2rWhGbqYiq4GebOBY8
X-Iguazu-QSIG: v=2; s=0; t=1716472260; q=2rWhGbqYiq4GebOBY8; m=2TybNlIFNwucpbKRIa8xNpRjifz3VEeOmUK6c1YBe4g=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 44NDoxjS179919
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 22:51:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR1fkjUt2STo7BaKeGjWmU0uVxM5SZVL1jr98+w+VA9P0qShIzVrjn3VOl+4KiC/8xcDjG5hv6bwvupY+AGY0LNXmr3wetjCBK1FWvv7aiUc5su5E3VeQl0hpmf6Zdy0CD5HmXryWilByCJGR6QuFYIRrgYxR0ghVD2CJGdoomr8UnHoMTjwXczahoigbUKfH4vBb2AriCi+0ri4n6xRBDIcOvqqG5fYqudTACbYzbuK1/zbyqV+iQ9Qy4hYn1LzZD5sjDT1IikneXhsyjKMHIXcrohTcfBnH5Po974TN+TJdthvfTGNWQYah/6JYpEnJlkO/yyfVjswzRAuI4MvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDfPwcTuV3rQ0WalO2PbgVePY35pcWdpympassZrVQc=;
 b=LNDKfAdmUHshMRQfRluVutaqnp8PqHPMcant726wQNNKSKcLFFwxMpj6u4f/040azTH0Mh7ElkaRCIhzBbqQ+WjWusdYq/49danI7pETPs5aAkxD2mAUtEtH1MQmXntLy+TvlfjEgm2WI/JVRbdXyGHA73ZjPyk/oyFquxyORXUmnMv3BNBw27FgyMC9owc6fafrXD57qB6RxbStXwgpFd4+8JptVJTA+AQi60fb6Vfd2N4OucG2LIERDpNJwJu0MWWdCECzBccXwlF0HNLgD9IM6dgloql25riYFhtBnYNlWw5LfcGoMP1PMYbd39Oech369qBoMi8EAPXMGlYUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] Query regarding SQUAD watch job submission
Thread-Topic: [cip-dev] Query regarding SQUAD watch job submission
Thread-Index: AdqsGtXhN49/gNbeSoqkT+RmP+DvBgA7UV0gAAOj+fA=
Date: Thu, 23 May 2024 13:50:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103E2AEBB85AE6C60213D7DC2F42@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103E0981B612912E2324AA4C2EB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862579C41345AE192CA8CA4B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11862579C41345AE192CA8CA4B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYAPR01MB6219:EE_
x-ms-office365-filtering-correlation-id: d789d971-ac8e-4ffd-7495-08dc7b2f5f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V09lK1RNZTVXM0FNYy9QbDlaeVgyNVU5VExlYWpQNkh6cmdJVDFKWTVo?=
 =?iso-2022-jp?B?NWdJSTUrallHY3BCRVFmaWl4eUV6UE1qakRNcTltMWs4c2I3TmhFNlF6?=
 =?iso-2022-jp?B?clNPR0t0SDFBdU5tM1BRR0doK2VrUWtUYklObGdBWE1WS2lycVgzQncx?=
 =?iso-2022-jp?B?OTNGWmwyS1dlaVlFQVVzK01rMWJmU1pmRDZ2S2EwOWFjTUlqc1pIdERE?=
 =?iso-2022-jp?B?bkdkdm5RTk1vcmxHYlhBdUhRalFpZzlKcU8ybUFBTkkvNHY1bWJId3FU?=
 =?iso-2022-jp?B?Y0hOTXVlbTM2VUZ4MjBYeWpBTWw1K1o4Q1crOTVuZ3ZURzY2OEJtb0h4?=
 =?iso-2022-jp?B?YTM3MlFCOEJwQWJuQVFxaWpkOFFoUktOdlZlZVBTNXJHb2ozTWRvSzNX?=
 =?iso-2022-jp?B?Yk9KWjZDZkhVNUw2UWt0ZUgvd3o2bGlMRUJTTy9yeXJmaE1rblBJbXo5?=
 =?iso-2022-jp?B?Y2s1QTErTTQvRklIZXNvZXQ2d1R1ZzM0dmZ3RXc0eHEzRDl1Y240dTF5?=
 =?iso-2022-jp?B?d1kxSG1Fc01nWHhobGVYa0twc3BmbGc2bDZhQW1kYzFzZEVKUGVOaFNm?=
 =?iso-2022-jp?B?SVFXN2hramhvaW1raXRMWEVYVm5NTVhBcFJWZGkyT3ZJaWNONWYzellP?=
 =?iso-2022-jp?B?ckwxVm1DUDBEU01pN2dqZUpORGtmUjVqWTVvVjRtaGIzYklzc1ZaQjlG?=
 =?iso-2022-jp?B?cy92eVZqYlhDZ2hqdWUrUmRiUzV4VTdLMm1tZkJ3MTBNWFRYb1NuYUx0?=
 =?iso-2022-jp?B?THlSOHh1Yy9PY08rYVVvM2lIYmE1U2NkU3ZhZ2JTdjJLL0ZGWWNKaThJ?=
 =?iso-2022-jp?B?SUk4djBhcDFjWmhZemoxYnJMd24wVnJsQ29jOFFnWDZhQlIwTUo2OTUy?=
 =?iso-2022-jp?B?ZGNUVStLakYwblllKy80d1ZIOWpPWE5VN0dNaElCeWRiRUpIcFlpeUxJ?=
 =?iso-2022-jp?B?TDRySlpHd09KNk8rVThTM3E3R2pZUGtHWStpS1I5eDhzSU9OblRuUFVW?=
 =?iso-2022-jp?B?VDBqTysyRjhCa05vRDFaZklBVFlaYXFzR0ZyN0I4a3plbjAxVmdFQm1J?=
 =?iso-2022-jp?B?a0tiN1pCQkpTLzlneXM3Uk51U29TeUkxcHo4UTBiSDAzaWpod2FtdHpv?=
 =?iso-2022-jp?B?Zno3YWFsdGoxcmZqT1EwK21qVS82MzVIRjdGek5XOFhnOG1PRXcvMzhJ?=
 =?iso-2022-jp?B?ZW91OW04M01YOTFSVmhQQkV3UzNiL2huS2pTNURSK0FMYmxuTGcrdFJz?=
 =?iso-2022-jp?B?OVJBSEdUUEVtTmtNSWc2ZTY2eUhVQjRyN1RpUSs3cEU2cUFzOWtnb3ZR?=
 =?iso-2022-jp?B?WW9iNWhCRnBzU3N0dXNIVUZNNjdTLzFpdm15MkVPRnh0TVRyclFTdTZw?=
 =?iso-2022-jp?B?d1RIbzAwVzZCY2lPN1BuUkZNczJxeWNRbGZKQ3loampBYm9CZjZCTHZh?=
 =?iso-2022-jp?B?ZGVnOVJVc1g1N1d1NU90c0piT3U2K0JEc0IzRmppODdUcFI1WWM2RVo2?=
 =?iso-2022-jp?B?UTZ3ZEJqd2U0a0Y0QjJmaTltaFdJaWs4YVk3ZE10akR4Mlo4dzNjSllX?=
 =?iso-2022-jp?B?dytiY2luQXliSEtyclpjTUlucjVGTlpsRjBKTFRxait3NDZIalpuTVpu?=
 =?iso-2022-jp?B?ZzVmb3RUdjJHMVFhTUJ1QVR2OUNqbDFkclhhYVVEZ3JBV0kvK1N2Z2xq?=
 =?iso-2022-jp?B?SG51Snl1eDNTdzJrWHpxYU1TUFBrV3Rnakc4UHp4MC9CbmtOUXlhMFJs?=
 =?iso-2022-jp?B?SGVBRzh4OTN4bXFaR2YrSWN4U05aVVR0ZURPM1lRY2RwVmwxeGw1alQ5?=
 =?iso-2022-jp?B?VGtJdmtubnBLOUhZajFlYUF5a21pUHZzUUJvbis4N0JkREpSck9NZ0Fa?=
 =?iso-2022-jp?B?MzJSbFcrVC9Xa3B0bkF3M2dYWGZNPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ai8rQnpZUGpNT1NJZVpnbUxzWW1CQ0MzVlVzOEUrQXZOZkV0RXUwZmtD?=
 =?iso-2022-jp?B?NTBSMDBRVlhWT0c4UlJvZ0tpRmc4L3ZPSUU1MEJnR1VRajVKTjBHL3VH?=
 =?iso-2022-jp?B?YUZnYkU4S3dGWjdXUDlSSCt1emowMUgxNTYrc2ZDS2RFMlJwaXJ3T29F?=
 =?iso-2022-jp?B?QzhJUmJxUDVKdjNUSE5ndzBGalFkTGxFaEhFKzRLbWJ5TTFROVVqbTJ4?=
 =?iso-2022-jp?B?akVIQnBPVTRXZmpUclJzVWN0ZlQzcjhOWWNYbXhzbjZZb0F0MUlOcWlX?=
 =?iso-2022-jp?B?Z0x3eVRSRXRWVE1vdjY4VUhuZHd4dVBoTjdvK0JaV21xZzduenNjOXpq?=
 =?iso-2022-jp?B?bWlrNmtOZk9sVWZSYUIvMzI2ZDZCT0FDMzBCT3hEbytycWlxY3lXNE1V?=
 =?iso-2022-jp?B?OTFSSjE1R09SL2d2c01idnplRWwwZnc5QWdOdmc1cTJtb2RnNEZZR1hB?=
 =?iso-2022-jp?B?ZUplSGpCaU9xZUpzQmxYQkJwazJkcE5CTGY4RjNCSng2b3hkK1Y5aGtm?=
 =?iso-2022-jp?B?WDRuajRoYTJQSTAycXd2ajhJcXBLc3FXaTNpT1kwSzNDR1FyUElCcGkx?=
 =?iso-2022-jp?B?dmFLRDB5YjVycUkrWUllbG5ocGFIWnVNa0VsQ0tGc3lOSUV4aWtOVFZS?=
 =?iso-2022-jp?B?U0ZXYnR6YWFyMHpXUnRjUXNiclFUUFFNUWE3c0taakZpQmd2d3FxK1NU?=
 =?iso-2022-jp?B?Y2JTV1NBbXlZck0zRlA3WXFqTXM1Mnh4L1VwcUxuQmE5Z0dQNzVVMEtY?=
 =?iso-2022-jp?B?TGh4WkQ5RHNSUEVDd08zYkNBZHdBVVEvb0lUVzdTOGRIUHhFZm5LcEM0?=
 =?iso-2022-jp?B?U09VajRjc1FXOFNiVzRTWEJFYmlBUm1zS2hCWXJKZnRyNjNwK2pNeFFD?=
 =?iso-2022-jp?B?c2pLRlVldlN4d3M3SHd1TEkyeU9nWE9NS1ZQN3JUKzVsQ0JVVEtqbks1?=
 =?iso-2022-jp?B?a3AzcWRpRW9rS2NlTm1VdG4zSm9ONGQ1eVJIT21xZ2JiQTQraXJyUTJa?=
 =?iso-2022-jp?B?MjZ5WFBCRmt2aUN3TzAxWUVIekIveUtSWnZRdWJDU1JoL3hBdXYzU2ho?=
 =?iso-2022-jp?B?RS94M1BwTEdySEtpTEZjLzF5VVlLRXFNZlBCVFF2bm9EbDZhSEJLUzZ5?=
 =?iso-2022-jp?B?SDdqRWxXS3MrRmdBV3dST3g2cXZQVGcvVzNCTGRvOW9wZHppc1Boc3FE?=
 =?iso-2022-jp?B?V2lVSzhUMlF2WjY3d3IwMFdGUHZ4alJrQUp4bnRaSjc4TDRrN0hTTGFJ?=
 =?iso-2022-jp?B?QnJQVmFwTUZRbkQ3VWNxeFpaQ2lubHVXQjdTZVBYUm5YYTJ0dGtVVCtZ?=
 =?iso-2022-jp?B?bG9VZ2FFKzh1enErdFNpbS9PNTMxQVF3S1ZFWHN0RVVuV3BxRjdHempm?=
 =?iso-2022-jp?B?eGV5ZlZjbjU5eVBVT0wvWXMvRW04TFNoamZkTlpUb3VpUXVvTEwxK0F0?=
 =?iso-2022-jp?B?cWlpckxST0ZBWGQxT2VxVGR6N2xLWTNKTFpudW5jUW9vVDZ2R0RyNmJV?=
 =?iso-2022-jp?B?elg2U1o2ZVJxZlpWMnU3WWw5c1g3dWZ5SmhRQ3BPNDFaN21BTTF3dTB2?=
 =?iso-2022-jp?B?UFMzWHZrVDFuVzFoUmdPSGVnODRWcGVyQ21xNlg4UndSaytLem4vcWxz?=
 =?iso-2022-jp?B?dGdxS09kYVBrRkFETm9jSzVhSGlDTkZPZVQzczZoTHZaZFVoTHByUXlB?=
 =?iso-2022-jp?B?Z2lyZ0NwLzIzQTB3SmkzaXVxdU9sQ2RxbmthcExkVEVBVGdVR0RXT0lm?=
 =?iso-2022-jp?B?QUs0c2hxbXZyNkVLaTR1d3Vad1dIY2daQVRyaEZtNGsrcUQzQWJKT0tw?=
 =?iso-2022-jp?B?a2JSbHRBSGtvVkZnSWZYMm5UMmFpNnZtK1hsclY2NVo5d2dwK01mbDY2?=
 =?iso-2022-jp?B?WUZ1YzlVdVBpeUJrMzRJL3prZ1VBREdFZUtOWExobTFUNG5KZW1xdGFL?=
 =?iso-2022-jp?B?cnlobUZBYkdNUkJJQlZaQjJ3dnRRNy9FUzllcXhzeVR4WlBpUWFUNm1B?=
 =?iso-2022-jp?B?a1YwSHBNSElsRXBOcWlTMTdsKzYxbERaL0RJRWJFRnVBRjN4ZUFhTUV4?=
 =?iso-2022-jp?B?anVrWUhvYXkwZFVmdDFhUHZMSDlHWlJvdnIyeUZxRDFSdmR1eXlSV2pB?=
 =?iso-2022-jp?B?MjFXSlo3QzZTRWMxSVVtYlhQN2hhcitPK2lhTVZYMkp4RWpMRXFPNkVs?=
 =?iso-2022-jp?B?M3c4UnBsTG94U0VadGJ5UHlmdTlyRnZyaUhhQ0FObXVtenBPSkxtcFgw?=
 =?iso-2022-jp?B?am9UK00wSnR6UW5mMzBkWGFYdkx3TXIvNnZ4cEhsaWZoT21HRitIMlo0?=
 =?iso-2022-jp?B?bDdHdlVzQU5SWUFDMWFUMHdDUU5KemxTVFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d789d971-ac8e-4ffd-7495-08dc7b2f5f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:50:57.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIXEmTamD34BAkkGuIwJo1oTVAq81SW797w/iLe0OMcJliaO/Glr6b7jfip7djeFunat/7JA9ZiqqMmdZ9OY7JyuxG1eTmF2LPJaBDP7BSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 13:51:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15936

Hi Chris,

Thank you so much for your great support. Now I can submit SQUAD watch jobs=
 with CIP_SQUAD_LAB_TOKEN.  Chris, can you please update the device diction=
aries of "swtpm-jobs" tagged devices ? The problem is now the jobs are gett=
ing submitted to all the tagged devices and except qemu-renesas-01 the rema=
ining ones are unable to start the job.

Kindly update the device dictionaries like qemu-renesas-01. This will help =
us to run our jobs all the 'swtpm-jobs' tagged devices.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Chris Paterson
Sent: Thursday, May 23, 2024 5:35 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Query regarding SQUAD watch job submission

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 22, 2024 9:08 AM
>=20
> Hi Chris,
>=20
>=20
>=20
> I made changes in this script to attach a watch job to LAVA job
> https://gitlab.com/cip-playground/cip-core-ci/-
> /blob/toshiba/squad_changes/lava.sh?ref_type=3Dheads#L135
> <https://gitlab.com/cip-playground/cip-core-ci/-
> /blob/toshiba/squad_changes/lava.sh?ref_type=3Dheads#L135> . When I=20
> trigger this from isar-cip-core, after the LAVA job is submitted=20
> successfully, I am facing this issue while submitting the watch job ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> /jobs/6909129906#L161=20
> <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/jobs/6909129906#L161>
>=20
>=20
>=20
> I am using the right SQUAD token (sorry I initialized it in the=20
> script),
_Please_ stop exposing tokens publicly!
I've deleted the tokens in question. You'll need to create new ones[0][1].

[0] https://lava.ciplatform.org/api/tokens/
[1] https://squad.ciplatform.org/_/settings/api-token/

> but still, I am facing this =1B$B!H=1B(B{"detail": "User needs permission=
 to=20
> submit test jobs."}=1B$B!I=1B(B issue.
Strange. As far as I can tell you should have the permissions you need.
Do you face the same issue if you use the new $CIP_SQUAD_LAB_TOKEN in the i=
sar-cip-core project?

Kind regards, Chris

>=20
>=20
>=20
> Do you have any idea on how to fix this issue ?
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)



