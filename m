Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12003.1795497223600930339
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 21:13:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Y/qPOHmy;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1795497219;x=1796706819;bh=GPS1MDSu4RSz7R5gO/XQqMTKZ5csUk4XoiBrY
	qS+Qx0=;b=Y/qPOHmyG6O39+yYiF2zdIRl/qhX819PPgEUkFuhXPBdwt4IARwYxKfCoMapNMMP8Hw
	cm2Ra0nRdgOCUmOIeWOZG/YnYVl8z78tW66uooJb5CLhZ4P2oWjBeQAiFv1jFWcrQObK0BCOAW0Rz
	QVZ7D+4txD2Q5vix5SNdtCnA4S8KC5ZQu8M7uDw8Bb9zSprKRJkWWJZ8tVaf0fF7POBExwOkSDmMk
	/wm7FEpyJdVjWiVxm0bhaRpcvAd5RYml1sCk5FxLpcLi7S1h0UGwXcslD4aaL297+iBHN8rRKjr0N
	w0YJ6dJzgPgo4WcTSC0vxhHJX/7znxXl8Gbsp71blk7A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AO5DdwQ2654957; Tue, 24 Nov 2026 14:13:39 +0900
X-Iguazu-Qid: 2yAbSJ9ntGFyA85aWO
X-Iguazu-QSIG: v=2; s=1; t=1795497219; q=2yAbSJ9ntGFyA85aWO; m=o6vlfrhNdqvr1YCsCsA13kkybChlWLiG1QcXZV4/c0c=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jYWDf5yszzyPZ; Tue, 24 Nov 2026 14:13:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI5RhaZJ+9Xc9qNvV3e/JL40VRsPYSzvYuvq93cF+I99HhU8QZl/CTxDPsGrLD09RCeOD8dhQ8MU0d/by0/X7OH2C7F14lAlBqtphr/7jLDbPVq2ro3avA6dzNd5i6RatQnnr3H49NOnuBQQhxNveGZL/VZE7z9ZE28yMCT+1yNmBq665PD2ohfLXFzf3ZoE3vhNhm2uJGeoTLd8NreFNWdnppcIINb/OXHuqp96GPUngDuIlm7jcoK9u4zxMkCa1s9h4gztivEGFAmt8U+CqF7KGOsfgU9vDqKSUjb/JePVRP08D0iGhSDpFqDT2hxF75n6e9k20MZtUxcN5RKJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwv/TQ18oKQUROT5S9d6M9rydPJaGq7d8NOl4lR1A/Y=;
 b=f466qT2IbsAvv81sC/pfGJyPLC515wZ6cppkGD9g5QWiBo4IsZo1mfKRxCefMyq/lgvzjKfc57Vf0sToTwsiUn6bCh0msWzFITFkmA5H1rAf9Kd1V40JY6fa7fOuBAME6VZkWI1VIVdH3C94k6ibJ0vYf3q1jTkpEONREDpaib1oHkMeHme/geQFP9Sv95gQXOJwxS1hhbzvdDGUmlxJRYjF3FwvMnyhazchPi5nlQuxRyHrZrXMJCvPHlpUnQhoo5HDPhhBsAUDyO0ScTE8Be7dKWiGrDcx0MHgyQgtEnf4B7Qxun2W5DIwAtafMGuvRwbI1iqhuCKk1OUvt8dMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Topic: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas
 RZ/G3S
Thread-Index: AQHddom2pbs0wdMjjkSmArvtQuXBJbc8Mt+AgACExWA=
Date: Tue, 24 Nov 2026 05:13:36 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481815D9A300F44E1C64853ACD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
 <awStSzX0cNPoVR5E@duo.ucw.cz>
In-Reply-To: <awStSzX0cNPoVR5E@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB18582:EE_
x-ms-office365-filtering-correlation-id: b6a2d25d-3f64-484c-d836-08df49e9b15a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: B3xXLAQ0V96Ko711aVW+yZxzjt5sGsoNaXF2Wy2Ds40IzW72z5Xw8oXnRB5judSlbSl7BIJJQgGsPDHTeDh424cOgIwNEXcMBeIN16vZA3zyYKaJGtdTeGSt9G86/Dsl5MVtXMVmrZvojRxrbAhAkgC26Xb3fn75vF6chkutLVxKIA2Oj1yKB5pn6cP9QszSDgOq2CNuZ00hT9zZj3RS2rZSB+doXlKuTiBcFN/VSnIEVcaGUO3xGZ857FdXopn+ygOvj+HQZSUpxKx8UtxipJvQ6/REVydd6NYD1XbSHFHcibsDQJJUfh42OHF9N+RRbjcEblt7xxebdPfNnY+K2jCRNrFqbAUdBoprx1zC6nvI34t4qNwGEomsV90yMdd1cFTEetKl+LSBtqQR492c+wipbuFHZDUSt69QD27qD+tKnENYjTDedaMCCyamVE2tXD9jzYPS8cXgLrR5zvDDD7RxnoDicPGRcw0ol/gpsIJ4PctXFOaf8+Hpu8N5nJqApcE/nXjz7Ne41YqKzO5wxQ8NaFEniUqyvQQOpB3VfIE07Uv35fB39MLgljk3pxwBSriTznLW8Ps5/LcYMH+qhz+gacndRrdmM9xPkST7Ayp6pkcDVXkkCYyzBplzF9+RNmVoXx+WXTpPtRv4TlFutfQvHeCPrmLQ1rwUyKkmUZ67iDBs5sERQO9m0sUWn4lziPcYUS2E1QWcggH0XLwLHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bGdkQnRvYUZSZ0drRE9SNzd3eStTK0JtOVZhWFphTHRrVXA3QWFpOVlF?=
 =?iso-2022-jp?B?Uy9JcWtZQ1pUSEVMTGQ4NXZwWkNJaWkwdkdBVUMrdFQ4eHZOaTVvaVBI?=
 =?iso-2022-jp?B?YUlzSkF3djIwYlB4V1hGZ0pxNGVXUFlVYStFOTdDMXZ6OGpvbWxLUThF?=
 =?iso-2022-jp?B?cmN6ejQ2TGxOSWxzcFQ3MXNvUkUvSEpPeUI5eHJZN0tGYjUyWlZsWHJi?=
 =?iso-2022-jp?B?T0FGZ2U4RU1WUEJEYlVFN0kyclFybkcvR1dveHh1elR5T214SVlCUHg3?=
 =?iso-2022-jp?B?OTQzWklEbDlZL0F1R3R6OGxJTlZoRnhNcWltQVlSQjlmdXBqakFPR3hu?=
 =?iso-2022-jp?B?Qk1GbHZmUXZITmFhRXlQS1NMcVpCdWNBaE1MNU1LVytDcUxnd1hsRU5E?=
 =?iso-2022-jp?B?S0FKcTFndHg0SzhqSVlWVXhvQzhMMmE3cW9pS05OSVJlMkdMbXkxL0tn?=
 =?iso-2022-jp?B?YjhsZG5NZElrTzZ2MCtvZEdCenhydklZZ3AwZnlGR2U0SHlmMDBla2VX?=
 =?iso-2022-jp?B?K1BUZ2VtTFBRN253TzI2UE8yN21EUllxbjhrMEM0bERJYm1nWTFCY29O?=
 =?iso-2022-jp?B?dGNPZjFmeGFROVJob2dmRWMwcGN5dkFtNTFVSWI3VGkvVldkb2psT2FV?=
 =?iso-2022-jp?B?YnZhbUt3dkJOUWM4dXd4YllQQktjMUJWeHlYZGRQNVhZQzBWa3NIRWZ2?=
 =?iso-2022-jp?B?QmhXbWdrMG1UL1lIQkc1RHhOVFRzQkxpRXhDdW54TGZtck43L3Mwci93?=
 =?iso-2022-jp?B?MGMxTG4veHhtQ1ZIY3dGTStYMzRVSUhHWTdRYnIrT0ZOVVdEQWRBK1hD?=
 =?iso-2022-jp?B?b3JkSWM5S1FaWjlIeXZRQVVxUnlyRUptdFFGR1pYVzFoQU5NMEM1djZY?=
 =?iso-2022-jp?B?TFQ0U1RwdVlCTG9QTlE3OUJVL0JOeGx1anpGdnNBdlZ2aFVNbTNxSFNZ?=
 =?iso-2022-jp?B?Y1ZabjR0cXAvL0pGVnZzaUJqb3ZmdkNaN2lKYThzdFl0WjVqMG5wNjAr?=
 =?iso-2022-jp?B?MEtjTVcrZnVodTNEa0xYSDIwTWQvZm1pMk1ReC9sUEIvejFqeFFTWld0?=
 =?iso-2022-jp?B?NG5JOTZKU0RBTHRDTkRkQ3plU2crRFEyV2d1VkxJSVd4d3RYS3lSOVJS?=
 =?iso-2022-jp?B?UVRJOXVPS1FIU1FBWUMvcElqRStITHZEdC9OOS9jL2dUL3JIcWwrcnhL?=
 =?iso-2022-jp?B?TGladW8rd0hJS1ViNDJveUZ1THdHY29NTWJ3L0tNNmhTRWlvK1JwNFZ0?=
 =?iso-2022-jp?B?YmVKTU8rRS9YVVV3RHdtU0J1UnZ2K0JJZnNjSmdhalMwSndyWTZaRTNM?=
 =?iso-2022-jp?B?K2p0alpHdTJoTUEwa0RMSmFvaGZxKy9kZDNlbGJrWWZMQlRWR0xhUkdr?=
 =?iso-2022-jp?B?YTRTSW9XOWVLeHRGWU9KRjIzRHdxYlNKTGtrQW9vNG1rbkZCYUJYSTcw?=
 =?iso-2022-jp?B?SkdVVUh1VTA2MkYzNzEvNDIxQlNhSzNFWmRzc1hyTkxhTm9iQ1JWR01Z?=
 =?iso-2022-jp?B?dUZ0L0t3VGx2Q2dBMmdzVXRSd3hBcURwQWhSMHNObkdvZS9kUVNaNk5S?=
 =?iso-2022-jp?B?UkRpTGhEdUR4T0YwTkZIRmhIUk9CcWVBeVBxY2lqTkdiVnZnL0tnLzhn?=
 =?iso-2022-jp?B?ZU05UXh6cXZqa3B6Z0txVnpSbDJDSERMUVU4eXdDVlhjVElsdDQ2NGpu?=
 =?iso-2022-jp?B?dFNTUW5zbFJ1M3VOT3pseTVOanJjWDNCa2E0NkZIMEZLS3dmMk0xMnBO?=
 =?iso-2022-jp?B?dDUwT3JQSTZPR1Y2b0ZRdzI5dnJZR2R3NXRJRGxrQzJPOFN6TVNyTi9M?=
 =?iso-2022-jp?B?aC9laGwxandWbkpSTGtUL1kvYVJmY3pYZ0JkU3Zwa1MxblhiTUtrNEV1?=
 =?iso-2022-jp?B?UjViT0txa1NzZ3FIc1lmMm9rc1gzb1dpTGgrYjVlZEUyWmlqcTlheE9W?=
 =?iso-2022-jp?B?ZkdzaE0xU3kvSGZiSE5tTGcrdkxRS3NJdGtnbVkzWVBsbXl1MWNyVnZB?=
 =?iso-2022-jp?B?alBzK25laC9MTTFtYnFReENxNElLdVRSTTJ2WGJ0MlRMbStkV0hXbWc3?=
 =?iso-2022-jp?B?bmN4VzlwSHMwa1RtbSsrU01zUWN1a2EwdU9PVFlxK2ljVXpjUnRnaE85?=
 =?iso-2022-jp?B?UUdoVlFid3pLeDA4WldicjlZU2lWbjA2NWhTL3ZjdkxGQnJsSDhDQ1dS?=
 =?iso-2022-jp?B?SVozZXhmdDFmcnErc3FMUVl5VE10MG1rbGxBcXRjNDBWMFE2dDloYTZW?=
 =?iso-2022-jp?B?YklVc3ZoNS9KQVlhbmdMamxtRmk3c1A5eXVVTE1lclY2OEtteTlieFhy?=
 =?iso-2022-jp?B?ejNWK0s3YUx5OW0rZXp1WkcxRHlWQTdXWDVEOWRUdnUvSktxT0hUTjhp?=
 =?iso-2022-jp?B?VURqanh0OWtYQS9hR3NXc1pyT0Z6WGhPMTd6ZW9nNFdKV2ZPYkNqQWpK?=
 =?iso-2022-jp?B?QUliVTk5ZzgzMlRXODBJR1psd3Z6dlZsVTFrSGozcmlEZUdNQjR6SHR0?=
 =?iso-2022-jp?B?UFAyV28zMGpXK21GWmk5QUw0c2VVb0FXakVPekRHRnNkbGljZy9vVlFh?=
 =?iso-2022-jp?B?a2I4cmpBMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b7hZaXSrq6juTW3UGx7jP2reOemprJ8xomPtfxDCDbU+5ydiaw3UlUBzkt36oqdCsdWhzN60kf0FmT3Nybb5/U95cVMEc4dVQuGf417up7v0NoIrQZDkEADI25UA1Rfw0nlKO1HdKgyljthe3YgJn6OtBBiRVK6AkYZq+geL2tgpKn34PVy5o1DddyQppcoO0WV3OEYldaYEOV4e9wg+CzSpbB5g62qNh+JSZQ9HyoIgCHpySRV+H+llt3f/9SOA4Tv3Km8OV6F9VQlxaRnVDqrwyHtFf4seefgTzZzjDzNK2wsvteQFD7NnKolgZ0UxbS0gkCHdZmuixyOKzx8HhQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a2d25d-3f64-484c-d836-08df49e9b15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:13:36.1403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNHXHc6OlTwLi9NWfFlb4sqHJGpzifO1RQSEI6UuSQsV6rF4S6wG6zBL0k9O20wf3uNE1S9rdUeYIhh4Jm5ByBAJtsUsxkYuEKIJ/mNU/olmZ+003xv8VrPbRrREShy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 05:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25054

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, November 24, 2026 6:17 AM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesa=
s
> RZ/G3S
>=20
> Hi!
>=20
> > Series backports the I3C support for the Renesas RZ/G3S.
> >
> > Please provide your feedback.
>=20
> I'd be happier if series were closer to 20 patches than 35 or 70... but I=
 got
> through this, and besides few poorly formatted comments, it looks okay to=
 me.
>=20
> I can apply this if it passes testing and if there are no other comments.
>=20

I reviewed this series, looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

