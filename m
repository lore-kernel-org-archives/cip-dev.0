Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43BCC982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 06:16:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5245.1789712189304695770
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 23:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=qACVqVT0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789712187;x=1790921787;bh=wy6vFp+UREyejN83m0+OTjt8A9rci1cBlqCCT
	VosNJo=;b=qACVqVT0cqxxu7hwXpohOQiZD/bfmkL2RYfdGXWuHkLHQPmnpohA8Ke3tc3ri11rUMl
	Sh4Ls5RA649xkLlNoCEnuwdAScMFGlybElQk40mVePUh3fqWkfkBbNgeOD3omzyyf3bZ7UIAs3ufm
	w8Q0tsRLFvSjafltspvlpdyRFcqVbILLvpUYRTLT6CmPzdz7CTIZadPR73vuwfWhkZK4g60CHSRWH
	9Cdbk4IA/qpyCVVAkGk17jML1//bndRyCQOMXEDiU7Vaf+/SpTxejo9vUZIWBQC2hKCOl9gSO3wm2
	upAti5XapJr+M4stlDviEcCWOvQRnVAiFJ3VJRG1+CLA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 68I6GQlW428466; Fri, 18 Sep 2026 15:16:27 +0900
X-Iguazu-Qid: 2rWgdPSRE3biTyyNKL
X-Iguazu-QSIG: v=2; s=1; t=1789712186; q=2rWgdPSRE3biTyyNKL; m=LoUZ8JStOCKWqWFqC+RLVf3JzyIi5Jtf3VKd5HCbALw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMp23Vgxz4vyt; Fri, 18 Sep 2026 15:16:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMWi1MLukp2EsIpcpyB2G7TxG4hFvZbDE32fY/Ig3GbHnQS1nJSHsA2hvZ/bcJEaw/iqYz36kyHz/19eXEj/+3A8z8chnIJRJ/CmUdIjNwKrOWBElOnh2Ew87WprpJD7s66qP5OBYqqD2MNhAnt8aD5GHbvYqRvyyck7k9npGGENfEbp7eN5auuEioF7eUMMkE6MmRFjI0dZjxPW5YdkRgN9+NeHdiPGYwvvPQ9gT7O9lM44waXRehI6y5Nz4sYcKQETr72iO+XffZNO+RRDHVs2roTXE0617z5Mh4rFpR8aKpOgAiDgPbph3f9mIdvQ3G9Xqak1axL4JsUqWe1Rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLkDSfSn60XjbFX8fFZ5hzWvY0dJ9FTQ84upR/5HQlg=;
 b=xEsqKmr7/JB2F+hJbRZq+eFlF+/WV5XPVhLntk64FbhzS4mrAG7sf1cpklzHHz+WPAwBFrhTJ+pUwT+LBPmCxRwfNbTZYN/6M6nl/55iv04NWM0GHza/dHcX2CmbqwYugdVwYSvFaWZVSxoktDdycEDpmANcIAjorlZNsoAW3zPumbdaYIiQhfwQAPEd3rVK/wAaCkBEL1y4wh+FAFbQqrNKmXoCAwvuc9QMHIOwMkruBUaFp6PLAG65NlOhvP/rsSkldYJs7ImPTWME1KsOZaLsqgj6rXmiQGsytiU4dVeVw5xywI5Tfk/DM0YfJ9Z4S8plVarj37SABBh4dhLybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH linux-6.12.y-cip] pinctrl: renesas: rzg2l: Populate struct
 gpio_chip::set_config
Thread-Topic: [PATCH linux-6.12.y-cip] pinctrl: renesas: rzg2l: Populate
 struct gpio_chip::set_config
Thread-Index: AQHdRQ0UqI+Vlx6YxUGAH+xGST87ZbbPpbWAgAQ6mFA=
Date: Fri, 18 Sep 2026 06:16:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818150334719D2DE8D2652DCD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260915122343.2531425-1-claudiu.beznea@tuxon.dev>
 <aqlLB4blKkpNfSCx@duo.ucw.cz>
In-Reply-To: <aqlLB4blKkpNfSCx@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15894:EE_
x-ms-office365-filtering-correlation-id: 6d38d258-b96b-41cb-47a1-08df154c5db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 R6+dh/FphLalu2JHceUThFY1p8YFLxsm2Zq7s7kMGR37bQkqAdz5hbjTy/452r8l8qOJipoTgKyKf0jECkSxg46ktGoHO3wyaiqxkKCOdKDOOv0pIhdW48j3rrYOUUKCTABtm78kMiRyHx9Qg9RxPHK4SGeOelquxiJ1K97hSRUg1sMIfEz6BFXZk1gxaLo6J9GOrvCby8ht4Ju57+/ufFX4ZP8MRAiEMCOua38XWtgwicGT4Ee38sxO6gl1gZJtcpkX3v+Q2sDQO+2n/dXMp1fydhy1dUtFVJa1l0sY+zoVJ/eJWiTsK+o45iXFWIrQ07Z2pTS0nhKj73La8Frmda0bpgjmFa+xOGTSNGo917Pk3hmkobZZhEM5v2BAOa/oafo4IcEPyw8BWQqwN5uUuyiKQbvcVFenbLY7IBw58AlmYlTxs60M2UtE8PqIUJIbEmVx536EZCJgx9DhBfTSb+JdUS3BLQo8zJtP1lacATopQzSEyjW8dnU4InwsjdEOQnPJd5yDPxxgYHE4dmkaFuuwse1K5YKHJQ3jb5W7lZex55BtWKj9eC/yFTObL2UnthLe2kf4Y8V11vY4ppAnYu+ZKGCftRYKidGRrsxIuADelOahmluE9VhH8OZZphaG+RnBmtmXzNxRGDYyHBFeJn2HNA4VwjIjvrNF0zJzpYjVmKtI1pZYtASZnM9BRXb8XlRhagHnt/yysZu1/z5ZBdSiX9sB3zB/SINf5pBjPIg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MFdBU21iRHUzMzNsa1YxQUpnQ3lwdEhlZDAzODBybm9rTGY0cURPaklz?=
 =?iso-2022-jp?B?NWJkeUR4M3g3YnlKbXhDY0ZsKzFVK0hmTTRZd3JqZFIvN0RISFVsZTVJ?=
 =?iso-2022-jp?B?UEhrMExLdEV1Q0Z1ZDFRWFlOR1hHWkR4NlgyTmxzbFpvVG1sT3J3VUtU?=
 =?iso-2022-jp?B?Y1UyTnVpTmFFeFpMd2tLM2NmOWdNNm9LTXZxWkQ2V3NNc2M5c1FQRG91?=
 =?iso-2022-jp?B?NDZtSjRReGEyNnFNT0tHcEdqT2FUUGo0cU1WR0xmaHVSdWxFUFhmOTlY?=
 =?iso-2022-jp?B?OWgrZnlYemdJQlpwYWxxb1hBN0JCaTlPN1ZqelpNWDRPUEZ5bGMxcjN4?=
 =?iso-2022-jp?B?MjBTcktaRWNudGJYVXJWU2tNUUFSNVI1cExDMW1ZaFpDZHU4cTZIVVI1?=
 =?iso-2022-jp?B?c2JJV1BNdUpjMSt4NElPQTVmbjZxOEdZbUtjclo1YkZ3OWRJRTFDNzFj?=
 =?iso-2022-jp?B?NkMyZnY0ZlJiTWdrUkJLd2lyYllSbXN4YXM2dm45MmNvc2IyL3FQeW9K?=
 =?iso-2022-jp?B?SnhCV1FUTlhtMzBVWkowSWo4Si9BcTlMZlJ0QlgwdnBpQTMxT2p4NFlX?=
 =?iso-2022-jp?B?U2xiY3E0K0EzZEY2VkEzbE5YcWZJT3FNWTZZZzBrbm9yYU9jaEVmSU5F?=
 =?iso-2022-jp?B?Sk1sbWpXQ2RSWkNtaHd0dzJiaFU1RVd4YTgxN1AzdGh4MmFoY1dDQnph?=
 =?iso-2022-jp?B?eFcwOElUZ1Jvd0lscnNFRGZCR2t1c3MvV2FEbVp5V2c1VjQwbEs2VVNq?=
 =?iso-2022-jp?B?QnNQcGdRejZsdXNoQWxYV2RYb0dFQ2loaU5LRkI1RXRTNXo3QlZIV1JK?=
 =?iso-2022-jp?B?SW94ZDRyd3VQQzhIYjlYUHNmdVI0RlpUa1k3MC9NRnFuZXhzRGlFa1cw?=
 =?iso-2022-jp?B?OGM3QWR3S2FvekdwZTZFOWhRQ3M4UkQ2ckRxWnhMaTV6ekNhYkRWT0ly?=
 =?iso-2022-jp?B?cGNhc3A5STRVTi8yV1QvUGw0MStlN3REZEZlcFlJSHM4THhTbm9ablJx?=
 =?iso-2022-jp?B?cThkTCtvWHcweFdpOWl1RmJ4Z0dIQ3liUGFqWTNkVk1LY3NpZmx0aWFx?=
 =?iso-2022-jp?B?eWlDa2dGei9qbXZFS2svcDhXbFk4TVpmZHBSaWtMNitLczYvcDhCRStk?=
 =?iso-2022-jp?B?KzhjdjVJWk9Hd3hNM1RKS3ArNVhxVjNKRFhWWlBFTHNNMUw1RW8zM2R0?=
 =?iso-2022-jp?B?MmFlMEJPWXdEbEVNZ2dzckJyRzFMU09uWWtKbHVQaUhqcHl0ZUd6NGZt?=
 =?iso-2022-jp?B?SGRJb0U3YTl5N2NZdzJlb0tIS0lFQXliTWY5YzAzejh0eFFNWWMwSlZK?=
 =?iso-2022-jp?B?dzAxcm1zS1c2WCtVRGc0SWIxbGJ4Y0sxSWcrTmdXem5SUVkwb2Z1UjNY?=
 =?iso-2022-jp?B?eVNRNDFhRnE0STRWTzl3TzlDcGV6NWh2ay9Id2pLenkrdUVpQlBoNFJQ?=
 =?iso-2022-jp?B?OEZxbmlhbk52VHZFRHdoMXNRSkxzd25EYWh4QmgvcGhSYnFDdVRCY0lF?=
 =?iso-2022-jp?B?NjF1S081ZWRXaGMvdGd5c0k5eHBxOVpjeGIwV3VOTXM3THFwcE1Ya2dp?=
 =?iso-2022-jp?B?NGNVUmkyUmFTTWljcjZWQjlrM3hxUnN6WDNPTUxGNXRQOHpEVml2TlJu?=
 =?iso-2022-jp?B?MXNoKzkwK211cWVSSzhNTkRNVWd1L0wzcWhraVhPbjhhbVBNVWNSZmNT?=
 =?iso-2022-jp?B?Mlp6RitiRGVBRTBFQ0lRbkNaQzFTdmZock44SlFGVzBIbDFrcmpOajBz?=
 =?iso-2022-jp?B?V2hHdHdHQjJTMGlqLzlqZS9rdHVqdG5PYzdDMi83NzM3Ykc3TDhxa0Fx?=
 =?iso-2022-jp?B?R1ZHNktEanRGU1NLaC9UQW0wSy9FejQ2NDdmYmdoOXNVOFN0MXhZdVd2?=
 =?iso-2022-jp?B?empFN1hyWDJ2M0JneDVTSWxmbUVjT2I1RTNpb2VVMTJjSzFyamJiU2VI?=
 =?iso-2022-jp?B?dG9vbS8wVE80NDdWNUdwdmJwZHFXRzZDWGhyRzV6OTQxMWNlUDZ2TVUy?=
 =?iso-2022-jp?B?ajYweDVhcVFkYS8xL3NrMGRCWWVuTm9jWmJseVpwRjRUMjQwaHNvSVMz?=
 =?iso-2022-jp?B?NFVqc1lKTExSOHFQblNZRkRNK0drR1V3NXR5U0pJN1hFNCthRkZUMHZz?=
 =?iso-2022-jp?B?U1ZwQzJKcnYreGpJSVFuSmc1TktDeUFtazR2RSsyTXdZSjYzclhZVVpo?=
 =?iso-2022-jp?B?OUViNzIzTEE3ZllIUDNEcEdQU3FuYi9vc2VpNEZHWnZLaVZXd1l2NnRY?=
 =?iso-2022-jp?B?RGJKakJJb0FmL1QxMzNwekx2ZmN0NkJFaEdTYnFmaFVqY2RVZmNLclNq?=
 =?iso-2022-jp?B?SXczYmJvOXc4ZkNwVDBwRnFvcDR4cnZRK0JQTjd3dXdJOFl3L1lnKytY?=
 =?iso-2022-jp?B?MTByV2o3akJZNFNPZGhyMGpjUXdZbjhZZlROQWVVeXRaUlhSbEdiOG9L?=
 =?iso-2022-jp?B?d3o4QVNnU1FuTkV6aHo0TDRSR0lDQzN1ZzNFcHBNZ3hUcGZ4RTRoVU80?=
 =?iso-2022-jp?B?diswTS82S3M4L21yVGJ4MVlvRlMvT3YzTDVEOVNJMFFmdzh5bUYxYlpO?=
 =?iso-2022-jp?B?YTBIMEVWdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	4ro7a5tdXi33WvNbrMEJkl06vPe3wLMyyqClhcQ+WfINIpEboMmATXzDh9kdlUQNzWVFzOunLhfho9on76vaMKtI7lJ/R2SYJkMEde03a4no250nSv5KXDTc7Vl3lYbk8m1WqB1ASAWmRygdvpXebPVVDeSWaYML3k9YiZt1rB1tOL/KANduBFKOKL+JYRACRoluBAhypQTNpR3sjmfE+fQli2FP2wM7ChmkmJItDflsLbvs2z7IJsjsSpFFdtwG1TJxPJI4By1vNP1/AcSsJLJkd78ZqXXT3rPqvmtw7imjZG3iLA0+992iOfUlLHrL+rtGy+rXdWb1N/j/pCkdiA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38d258-b96b-41cb-47a1-08df154c5db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:16:24.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we+msU41ljUNlRmitOo89EiVpZ12R4Nxn19dj3V2fro7yQARjr1+kt71jnb1Ww8ZAm/iXR+tBiWHcOpNziCrtHT9VAqD4wqPGzr/VZn6Vo2fBbSCP/X4ZycmQ5KPS4RE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 06:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24235

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, September 15, 2026 10:41 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH linux-6.12.y-cip] pinctrl: renesas: rzg2l: Populate s=
truct
> gpio_chip::set_config
>=20
> Hi!
>=20
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > commit 60a19a68779b1f24e3160c8e4317d0334a397687 upstream.
> >
> > Populate struct gpio_chip::set_config to allow various GPIO settings.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply it if it passes testing and there are no other comments.
>=20
Looks good to me too.
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


