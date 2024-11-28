Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86AD66BAD
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 06:24:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.89219.1732775058103876737
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 22:24:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=Dhs4mN3z;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1732775055;x=1733984655;bh=QDcZ8gIVtZwBmh2+CxBa3KaOgOTaqEXXwb61+J/
	W9W4=;b=Dhs4mN3zFVIjZLhOgS2RbEm1gpkJwnRVtOArheV4nc5r4v5nIp21jlIpFIKrIxd4UbGZm
	OhLCyuwJCDVRDxbcc0wBBTdv6sekPJbjVuHWGvHIaMTJ13IF13tUf+Lv8CQKgCW1cs8z70d/+dVFH
	XADwjcYeo8xHqWbxGnlVZ2DAbapP4hP85CL+eOeduxh+uN2k4sx+9DJVkPyEi256zQqLLPyvUiIFL
	ozGYf+epF0/H20Yo6KmGkb5parbJyyGJVEv4qMqxVEuERTSkEnQoUQxTHeIKFj2Qt/M4N5mZb9Wdi
	JhfvBPLUuseGFejBqL5w3wM5/02rvIhn5YquZIZftA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4AS6OFrP1168640; Thu, 28 Nov 2024 15:24:15 +0900
X-Iguazu-Qid: 2rWghK4kt02kGRZ3zO
X-Iguazu-QSIG: v=2; s=0; t=1732775055; q=2rWghK4kt02kGRZ3zO; m=D9pAkwFfjWH75oTCeBLEJUwayY4dxj5LCjslEduPDcY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4AS6OEYb2700669
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 15:24:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2w+uv4/HlyzOc6LrHE35P0IYOcqfGhp5YeRs25JO7n8CS8HbKhPeyY260Lc0PyVgsxd/rvLcgfv2oxBimj5zmPMgRl3tUR0lFZqXuUK3vYCTB13wP1aTCcmLFkw048TZ5l7SwCzQaMP6BMoJGNwxBmol2pfyBHSXx1Ztv/pGLap3H+0yDRbafnSJ0XnNls1JImRjUmMhy9B8s0aGOiirXrT3F/z3uJ9dJpoka251Gfg70srCteABHITjeydlhc5y0masKW/en0HWnvhvY33AGizhUyiS1vzUx3wvL8aCLVRw4Y+vTMFqNfbsErIS3AblSPw4EWLZImGzxwkJTB8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vMdY8gspe73ZDn+lBZbbR1w5Z3ugYgYLsdsunP60Ds=;
 b=apMmpEjSYNNEGMUDMBNdJRwc5b+a1ingWAdpIsVxKs/DH/Y+wHOsvg5hJtHzHdTAn/aF2XDM+avs+WnaM+dj1xMvaeBHcYp9X/LWQv+pMLok4mNl6R0pkxWwrRrYJ1VV/SoYPSwJai3uJbDw3icys75C0Z80l+l8HP2/5BIBoF0tezDbf1EKTDe75QBiIcZ0qomx/cjV+wfx0gCGuPycHMqYLar1D0MPSvX6tjsZHbKBAVJJVzblE3hqfwe/S3RgFi2szww+VzOYjSGEIeASuJ7OxDySdB+5nksNAuGSTxRT+Vqf64H3gEVtJMObwP1T9PlBsbNVTrvOP1Lb37ln3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeA=
Date: Thu, 28 Nov 2024 06:24:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
In-Reply-To: <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TY3PR01MB12051:EE_
x-ms-office365-filtering-correlation-id: 0e24c44d-260f-404e-7fca-08dd0f754618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aUpZcG42a3BKWkw1M1dCc0YwRVFzekFEOHRNQjJFeTdES3pKQkJQYTlY?=
 =?iso-2022-jp?B?WVF4NnQ4MkJjdUtyVlVpbXlqSzJpOE9UdTE3dWxrMFl4N1RsRW1lVkJC?=
 =?iso-2022-jp?B?aGdLakxqeEZDSWM3MzlMV2M2dTFiVjhyd0RZY2hUSFlHUzJKRVFQRzAy?=
 =?iso-2022-jp?B?ZDFpMVpFMVVZUmt3N0RJeHlLV2JkTlFHR2twRmVYam9FbDVpVzhBTG9Z?=
 =?iso-2022-jp?B?U3pOU2VJVktPSXVidEdlR1lRcTZUYTc1a3VFa0pJSXRkYmNySTcyRytU?=
 =?iso-2022-jp?B?b05UVmdBUjNkU1NrWm96Rjk1Y0pCWlZhbWFQMURaK1JBSXFvKzJ4SjBQ?=
 =?iso-2022-jp?B?ME55eWlTVFo2R1hoRk9nSlF3VXF2VjBaVlBYYllSd1lUR2xpeUN3L2My?=
 =?iso-2022-jp?B?bHhDYzBYV0s1dUc4TjBzUWE2M1RydUNhWXRNSW5meFZpNFk0T1pnNUhE?=
 =?iso-2022-jp?B?Vk5SOGhKekdybWt6ZUdGbzBwY0JrNzdHQUVUeDhXczAwR0pyOUVycVNM?=
 =?iso-2022-jp?B?OHU3R0JFb256M2k1VjBjNDVMSHR0NW42VnE0UTJZNklnY2laUDN3Uml3?=
 =?iso-2022-jp?B?UkRlWlFaTmZqMUloUmxMalpRU2pxV3dWK1Z2UGUwODJXL0tOZlkwMEtP?=
 =?iso-2022-jp?B?Y2pLUm1UakdTMFlwTGFhUGFGVkxjMElrVHFnNk5TVmwzdFhMK05IdFBt?=
 =?iso-2022-jp?B?Njg5WFVWM3VTYThJQ0d4bXpwNVJ1OW9RTWdSSk84TjRFUzE4U2lCSzZP?=
 =?iso-2022-jp?B?NXM4RHh3MC9JOWc4bEhLWS9YZUt0R3V5MXhieDBoTXJoakExMkxpeno0?=
 =?iso-2022-jp?B?Ry9CbVBHc0toSVRUMmNJWjUvczBLQ05TUEc0eUM1ZWpObCtvMU9IdTQ4?=
 =?iso-2022-jp?B?Z2JGcGc0d1J1VUEyNlAwRnBtNGg4Z2N2ZFJ3Qko0K1NmSWVpTjlDN2dP?=
 =?iso-2022-jp?B?dXd6WGM1ZjVVeHFBOGdMUDZaem1tOTRzdVZJalRGZllBZWF3SUREbHdo?=
 =?iso-2022-jp?B?SmNpYzhPeTltL3Nsb2pOYTVQNnNLeEJ4TjVFL1N5dWI1QkM5aDJGamZT?=
 =?iso-2022-jp?B?Qkp1ejRKVVZpVjFTek9iUHJabmlCNVRXVnlWeE9RTVRJQmV1VFlKd0Rt?=
 =?iso-2022-jp?B?QlBJR3VCYlgzTXZvT2RFKzlEbHpwNWRuM2VRV3JTUTFEZFNOVDhORm1Q?=
 =?iso-2022-jp?B?cWtUVFhLdHlFVnFsYndpVUVzSjZGc2ZBRkVQeTZpMEp2Qm5kS1BXcExL?=
 =?iso-2022-jp?B?MDNJWGJJTUk1a3JtS2ZzZ2FGbng3cnJLWU1BT3hyc2lITjA4RW1zOG9r?=
 =?iso-2022-jp?B?MFBZK3NTb3FhaXU4VjFvd1cxOFpER3JoZUZTNFpFMjhReG53Ukl0c0V2?=
 =?iso-2022-jp?B?WUtHRTdkTFk3NGxmN2VxWDM2aXRzbE9qTUlxcDY5RG9CMFZHT1dPVktQ?=
 =?iso-2022-jp?B?MHZJRHpVNkw3UTE3SmtkSHM4ckJjaklCbmZoNi94Ymh1ZXU4V0ZkWlkv?=
 =?iso-2022-jp?B?U2QwMGxFMXZYTjNQZ1h1bVNTb1VuZUc3RzJpd21XeWhEMmVoQjdPK01L?=
 =?iso-2022-jp?B?aHg3aVp5Ynhua3pFdUNpMUJZMUdaRUZTK2g5NzF6Uit6WG5RZ1Zha2Uz?=
 =?iso-2022-jp?B?WmE5WUJndkVSckFqdnArdTVFRTErR2pSUnVjRStRV3R0MU5EVDV4OVd3?=
 =?iso-2022-jp?B?QWV2czBPSkthcTUwQ2pDVWJvZHNJZjY4Z2pRdG82ejJwdUM4RE90cUJK?=
 =?iso-2022-jp?B?cjdNd1EybFdxeDBMQ25UTUYvU1ozbFMwK3RnM3lteXd3Kyt3U28zQ3o1?=
 =?iso-2022-jp?B?YXhIMytPd3UvZ2RpOHdzUFFQcTJVdXpGWmRSQVJpVGNFNjMwTGp0a205?=
 =?iso-2022-jp?B?Y1ZTd0ZsVjNPTVh4VVNnbi80Umszc1NwSkl2QTRWZWpVekNid1NScXRy?=
 =?iso-2022-jp?B?SnJ1NFppemdCSVJTMFZ6K2ZWNG95Q2lYWDFGblRWdEhONUFHTlNzUENR?=
 =?iso-2022-jp?B?N0JieVJFMCtNK1o1UDRUMnhMejdocHE0MlRVdDZxN0phWEpxMklKZUNh?=
 =?iso-2022-jp?B?UlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VGlRSDlMTnIzVWxOSE1EYytyRTNFQXd4Nll2TEMrUnZXYUJEOG5DVmln?=
 =?iso-2022-jp?B?a3NhT3E0UitDaDRoNEdNOGJXeSszejR6YXAvdFhBNk5aV1NuMUVNdk15?=
 =?iso-2022-jp?B?TXRjYnJyVzdoLytNcUFoZU5lVDh4ZmYzNDBQbStjNnNvT3JpMmlCRnov?=
 =?iso-2022-jp?B?by9pcTgrODdkQTZGOUVkT0tZYU1JL1dyeWdPRVhZM0xYN014dGFremRn?=
 =?iso-2022-jp?B?R1pOUTBxNGlrODVWSkExbE9Sb0dOeHo3bmRMQy9iam5hWE9zRExTdXR4?=
 =?iso-2022-jp?B?VGd6U095N3lYNDFCYVVqOUN5NE5pdTVqTVd5TURBNWdSMW4zQVkyU0FN?=
 =?iso-2022-jp?B?ZlFKMXpGb3J6dm9DSEhzbVc3VE0rTWJHY0YrY3VIN2Z5bHpVUXo2QUtX?=
 =?iso-2022-jp?B?aGlDRGxEdVJPUWl6QVZ6ekdUdERLOElsaHZ4Wk5VdThRb2orZHQvV1Fo?=
 =?iso-2022-jp?B?NlB5SFcrUElUL1MwbWY2MU1tVWo4QW5YSXoydXRVVjNVM0FqaFpxQVNh?=
 =?iso-2022-jp?B?QTZTb0N1VjNmczNJZDMrYjRLaFBYS0RqTFBYVEZWNzB4bDdnZjF5MWhh?=
 =?iso-2022-jp?B?a2hmcXZVc3Y2OGVnaDd2d0VsWWdpRnA5Y3hvQjlPM3ZMY1dyV0VXa2RC?=
 =?iso-2022-jp?B?T0VnemhFOWFhb2dRZ1dxZWZFdFFRS2I0UmoveXdGSS90QkdQUzUzb1Br?=
 =?iso-2022-jp?B?NHIzTGlpeDlDMnBNV2pzcHlPenFNN0ErdXVmVmluN1dycHVyKy9oSWZO?=
 =?iso-2022-jp?B?NnVoanRCenU0Wnh0cTFjd3JkaFdrbzBHR0tMaEtLbzQ1V1l3T0kwYzcr?=
 =?iso-2022-jp?B?OE5SZ21CK3AyT0syTWlqcVEyWEFqMXFRZkFrWmZtSDQxRld0ZTl5SzM2?=
 =?iso-2022-jp?B?NlFueXp5VVVLR1pqUTRjeGZZTStYRko5SU1GUnlyZS81SXNMYmJGVEo0?=
 =?iso-2022-jp?B?K2VDUkVvOTVjdUpQek5rUnp2THNsOTI0dk1MWllkaWdxc3RxUHdMS0R1?=
 =?iso-2022-jp?B?dXNicVJGMXdnbVBVd2djU0Vkd1ZWOXdCQ1VzTmtRM1lyTmFRbHBoQlNr?=
 =?iso-2022-jp?B?R2lCeVVueWpaT3ozd1ZIN2l2SXY5aTcxNmFMUWx2TVhtMHV2R3pTNnd4?=
 =?iso-2022-jp?B?Nk1VcFVkYnlGMnFKUnM0dzNoYmVjRlBGT3lWNmVaY2VLdlJaa0J0a2FC?=
 =?iso-2022-jp?B?dGYvcENXZlVIOElmSnVsSnc5YWJocGNFb3lpVEdvb2JDMWRwVXVOVVVJ?=
 =?iso-2022-jp?B?V1R1OVh6MkwzTGduMFYyWE9VUWZYVXBCZHhaU2hvT1BPUU9nRW9DN3ps?=
 =?iso-2022-jp?B?RnBmVXB0WFF4TGg4WElqTlFoZmJkWmxUMk5VaHp4Ym93c2VHVElRZUls?=
 =?iso-2022-jp?B?K0c1SlFhOWs0WG42bW5JOGZlL2Nnd3ByR041dXBWMTYxZWxpbzBRUGlP?=
 =?iso-2022-jp?B?SkZZeU1ibzhFS0JDeXp5WE50MlkyNks0VzE3ck5lOFRuSFRKeGRuZnQw?=
 =?iso-2022-jp?B?eGI5SWorb2UzcUNzM01kdU9TTXArbnhkYklDQ3B4UW9sd3E2OTZwZ1pr?=
 =?iso-2022-jp?B?di9vMTZ5amplRDJGMHZnL2tUSVlMRVhrQlIyaTVjVmZxdmdCVHA4eXVY?=
 =?iso-2022-jp?B?TFNNY0JRL2hLT1I3WFNwenVHbC9paTBDVUNVK204STgwRXJEK1ltcE03?=
 =?iso-2022-jp?B?Q3FnVTlieDJHV2RBUFI5dm1xWlFqYXhPbGNmb0U2UU1RSzdnSEM3WVRx?=
 =?iso-2022-jp?B?VXdrZjlidDRYSUZtUVpnTjZudnRzMjVsOXBSN3VkTnBaRnRpRDdjaXFD?=
 =?iso-2022-jp?B?YWpud1BMQWt5enF4MkZmMCtjdFV0M0VlcGR3ZHYwUnp1N2Z4cUV5ZnMw?=
 =?iso-2022-jp?B?L1dySVQxbWs1MGxpY2paRzEwUGU0Q3ppRmNET2hqeXhnQjZjU09JaUVs?=
 =?iso-2022-jp?B?eklrdkJNc3FQeUpUVmNhNk9sU0NaQXlIMEIzOVRrQ3lENFhmSU5kTjlS?=
 =?iso-2022-jp?B?TUpMTVFvQS9Qb3lBNkRPdFYxOExQckFwVmNWZ1dEL2FwSUcxUW5MdVhz?=
 =?iso-2022-jp?B?bDE5WExnc0FOWDVTR2EwTE1mWnJyYTR2Y29PY3BNVUlDMzZNTGJxYitF?=
 =?iso-2022-jp?B?RC9ZdnZsamRpcUdubC9CNmxrRnczRncyZ2NGMmc1WlJFSUZVUXJPMmxo?=
 =?iso-2022-jp?B?UkRkWEJremJFZXdsejE5S0FvUTNyWEdacG9zUXdpOG5qeHV0RUxYeTZO?=
 =?iso-2022-jp?B?d1NkbkpibDBUZER4a21BRmo4WW1PZi9CL2I2ZkdDTUtraWloWmNqRHY1?=
 =?iso-2022-jp?B?QXFjalZ4MGFYWDRwN28vVmFpSTFwTURoU3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e24c44d-260f-404e-7fca-08dd0f754618
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 06:24:11.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpN7VyFWUqFH59QWJCkAmbWIzu4MT+LpGGpZDniiWl5RLYfPn17TNG4Bb3p3jrpxWzaMGu12xmw0F7vfJtTOMplZXUqZBgTsAGm/Y/nqpqtFKJeA+X8cfN1+Kcks6kNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12051
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Nov 2024 06:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17297

Hello Pavel,

Thank you for your comments!

> >  	if (gfpflags_allow_blocking(flags))
> >  		enableirqs =3D true;
> >  #ifdef CONFIG_PREEMPT_RT_FULL
> > -	if (system_state =3D=3D SYSTEM_RUNNING)
> > +	if (system_state > SYSTEM_BOOTING)
> >  		enableirqs =3D true;
> >  #endif
> >  	if (enableirqs)
>=20
> Ok, so this looks very simple, but without SYSTEM_SCHEDULING change,
> this will be nop and will not fix anything.

Yes.

> So you already have the backported series. Could you share it so we
> can take a look?

The backported series are in the directory "1_early-might-sleep" in the
tarball attached to the last email.
Could you check that? (or do you need email format instead of tarball?)
Please note that only one patch ef284f5ca5f1 (3/17) [1] for arm64 is not
included yet because it would take a bit longer to check its dependency.
Also, note that "2_allocate-slab" is also required to backport but it's not
a part of the might_sleep() patch series.

You can see the most patches (14/17) are just to adjust system_state checks=
 in
existing codes accordingly to the newly introduced SYSTEM_SCHDULEING.
Core parts of the series are:
* [01/17] init: Pin init task to boot cpu initially [2]
* [16/17] init: Introduce SYSTEM_SCHEDULING state [3]
* [17/17] sched: Enable might_sleep() and smp_processor_id() checks early [=
4]

Those changes can be applied to v4.4-rt & 4.4.y-cip-rt without modification=
s.
The No.16 & 17 introduces SYSTEM_SCHEDULING and sets system_state to it,
but other parts are also adjustments so there may be no big impact I think.
It seems the No.1 is also a fix for smp_processor_id() users by pinning
the init to the boot cpu, which makes changes in kernel initializing though=
.

> Would we need whole series, or would some subset be enough? Hmm. If we
> are adding STATE_SCHEDULING it will be intrusive. Does not look great,
> either.

My understanding is the whole series are necessary due the reasons above.

> > (2) "Fix" memory allocation callers' behavior while kernel initializati=
on
> >
> > Instead of backporting.
> > It's mostly clarified that there are some wrong behavior in some
> > initialization codes that call memory allocator (GFP flag usage?)
> > within SYSTEM_SCHEDULING ~ SYSTEM_RUNNING.
> > It would be one of the ways to resolve the problem to fix such behavior=
.
> > However, it will need more investigations (the early might_sleep() enab=
led by
> > the backports may be useful for this :) ) and the feasibility is still =
unclear.
> > Also, I'm guessing there is no upstream works corresponding to such
> > fix.
>=20
> This would require fixing 20 callers you identified in the next
> email, right?

Yes.

> I guess it is not easy to prototype this?

Yes, it's not easy if there is no related fix in the upstream RT.
I'm trying to check actual codes but will need more traces and code checks.=
..

[1] https://lore.kernel.org/all/20170516184735.112589728@linutronix.de/
[2] https://lore.kernel.org/all/20170516184734.943149935@linutronix.de/
[3] https://lore.kernel.org/all/20170516184736.196214622@linutronix.de/
[4] https://lore.kernel.org/all/20170516184736.272225698@linutronix.de/


Best regards,
Kazu



