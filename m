Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16687.1792647977997632601
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2026 22:46:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=MWGD1mNU;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1792647965;x=1793857565;bh=vvjIeWtU1V8kFQcb5U5L7yMgWSmOHw3Au82f3
	ePBedU=;b=MWGD1mNUQFLtLNHEF9MaTzETN/R+3K+NOZra1x+/8OYY4q1mOTcjotsR3BDSgnpfGUl
	ABt9LLgaitPI3VfiM/Gss1I6huGDnWlVMua5MK7FJVa36RMFFuwhFjGjoUiCduVfjFvuhqArnpN2m
	fo90OLmqP6K+hL5ecSjVPjzws+2pvovK/E0Dou56EE1w2y30b43yyhpv41wX5FjddU2+R3Px/4PB0
	ZlPuwwiOopd6zFQ5SZl174D8BX2uAB4/mCG+O4eAcqMF2VHPcCXC4FQ4BFyuuQgyUB6ylGKFLr7va
	0TnZo8/1s4f+xyP5w6HeXDvMf7UTxVTaN17qZRtng3+Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 69M5k4vx105780; Thu, 22 Oct 2026 14:46:04 +0900
X-Iguazu-Qid: 2rWgtwVk7K2NNzXtIX
X-Iguazu-QSIG: v=2; s=1; t=1792647964; q=2rWgtwVk7K2NNzXtIX; m=VLHXJVIzWkrpTU2gE0sGPLS/aC1ugB/elhU1cSWAUP4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j9FWH0PDmz1xnj; Thu, 22 Oct 2026 14:46:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYAtsqDEMsBYwsaHPzdCEMmHzJxipsd8t8/ID9sNpm7d3s/0jXeqUDZRtzUIeDAHssJdrR3s5FcGB5Jb98lDxM16TUbdFozU1XedSONEio5legrb2qbbGFjpwG3G5u2AhNLHsWpRTQmnb09aOba2aS8kHfro9jE3dyDq/fRN5J7w6iUxFZm4rrHLctPGzkLvzQN+kY6d2POiYmVh6+eSgWTMLriKiqcqIEh9rLLNFY7QhFNsZEVwaMo4iljfcOrkUUjQY/lV3n6C3Oi4ib4fgRDgbq+Jp/If7zUWMlJsiD5u0B+KuzV/vvRH6IQn1WUlCdhqyJN1/Hj+CCAWajwchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0wsEAnOQM4yRK9GnAPEfL+CgUZqysFTWDQYtpLvXrk=;
 b=KmIJt5bk4Sbo9lwRI+fD1Tas7gRvho/Uxaoht0D4cudW0rP+qNfydPgrGHN5hzCn9omUPzTQLb6wJ24XxWggInmZjm+00RVDiV2XfgHwdsLV+TBCKI5yms0ujysmj7n40Y97RD+oy7w04iLh7rjGQTc9D98jGd/N0Kbb+d1GY6UFBXqEh+umGEl1SH8tDN0Ytk5VF2W84y0tmGCqXlX6weMIEyJbHyQWMUz3LxEnrZO+LGvhpYwqos+VojAldKKL5f0Y1lYQ4GwIJhVHIm8jpgmcVUpWL5BfZmSZHZlABYerCX19067iYiOpt40kxXhx+8YNmpdhvRkrU98VXXBFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <john.madieu.xa@bp.renesas.com>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/3] Remove duplicate field_get()
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/3] Remove duplicate field_get()
Thread-Index: AQHdXVaI/4YlKHdY6EaGeJq8E8wBXLcJFWcA
Date: Thu, 22 Oct 2026 05:45:59 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818958EE1D049EA2BA65561CD652@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <atH33BfCxojSs-AN@duo.ucw.cz>
In-Reply-To: <atH33BfCxojSs-AN@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB12035:EE_
x-ms-office365-filtering-correlation-id: ebd895c6-aa11-4e1e-c591-08df2fffc04b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|38070700021|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: jFBpj4UkJIIuPJATIwC6QQI27nISgqFOjbsAOKHVl7Q8BtVp59YzJi3d2Ay1uYMvxs+QUZyyGxMYRK5/g1+xV3TOEVU8tz6a8KJr5QkvpWekLzLdoGZX2DYQfo5sM4YujtHLzyo6osoIt1eLdTt8Z6fjxk7Mc7nHYthuAnbfvCpQrXdVNsDvw/lr7advW0dzmB13C3oM1Nql9EKWsx3+axV3tKBWVLyqXQCVvqu56xT1JSHeucKikwy/oa70YI6CTl6K7yabY6gpkNVNMZXQ5PKwmFNl6iFkH9hFQll7TBvw5kw9F5+IkO8vY57sPD5r7pMF10UqyIBzANqFD6/Qd68pewemf1hA/o/BhnJlN66SIOUWwAa6Q15g5eO4MGsssrIPKTmrA2qhh1W2iuAkFijfsaMz2qD9tqcGVAmi0P7qKyqQm3SAhE0Y69lsgr0evdlOh7uRSWRmZi7o5R5+nZgECiPVUvwyBd43Q7mHO+MzBzjNYSlW8t2O2qYa6o9My3zF+VYOOIjBwgy2WIEDSD0mBLRvDVT3EuA49Z3rEBHP0OGGVG4/PIhpEQU3Hjg4jxexoJRUkIDEvZajPfkU28WR+lFEtx8ORSX1CJPl0t8yku298TFuiwLg04K80iVbGlMUhnHnIre3QVS+5hvxNwPJv8/BMGrg+vuSe6U/jLHWAkKRKF59PcmMOWkxE21y+CjoWBC7Fo8lbaoqQ00AEWRrZwDUfiP5nDJy6qXC0f0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UnBlWko0VVdKREM2enoxN1lwYnFiZkNlMDV2dWlUNjg2RE5yUHh0L3N1?=
 =?iso-2022-jp?B?WXlCOEJpb01WSThjZWVZejRwN1dFUk1XQjJZMDZsT2VYSCtJL3B6cXVP?=
 =?iso-2022-jp?B?UitHNFdZR0hrc3lJdVRKVVFoK1dXYlQ1czI1V0NuMDVKek9od1A1WUh2?=
 =?iso-2022-jp?B?d2JJNTJneGJ3RnVMejQ2cUE0TXRPRUlyZ1FXMGh4N3hwdHEvd1VYaWtl?=
 =?iso-2022-jp?B?SGJQVUdFNGVucWlJY1Yyd0FudXRQcmlzZ0JleXJWQ3J1VFR5ZStnL2xQ?=
 =?iso-2022-jp?B?ZnJGQlo3aVpJdnRCV1gvQjZqT096TGJvZk1WUVM3ZlRrNm1JNHkxSzdt?=
 =?iso-2022-jp?B?RDJ5NlRldW9wbno0VzJwZkYxV3B4T1RzRks2TkpoRDlsVVk0MUpsQkx4?=
 =?iso-2022-jp?B?THArZVNOY1R3RUpTWW9sdlEwTU9WTFM4M21OV3ArdnVtMm9YRTNzUGtJ?=
 =?iso-2022-jp?B?WlRCOUdQckZvVEsxdVNQMXI5WFBEWWFod2svQ0pOME91MUNMZ2JvV3hr?=
 =?iso-2022-jp?B?MVhjWmZiUGJNWnlvNkJwQ2NmVTRHR3pIZjZtYlY4N1pxaHRyTUpNc1ZD?=
 =?iso-2022-jp?B?RUtQd2t4OVJFYUozRWJmR2h5OWR0SFNvdWJDUjVuYmFrN1YyNkI2R1VR?=
 =?iso-2022-jp?B?VWZvb083aHFOV3BQc0Uxb0VVUzBNdDlNaHZmcnU0L0gwZ0tHMDFuUnpM?=
 =?iso-2022-jp?B?K0RTVHBBSkp1SWdTSEpuRk05Sk9BRzZReDZwTy9SUXBiSjRQMnp1dU9J?=
 =?iso-2022-jp?B?T2xKVExCbm9tdnQ5YUhpM0w5cmtVK1R2Y2xTaHQ3TGwyaTJQVTRGYUt0?=
 =?iso-2022-jp?B?NWMvcEExaExkUTdHUzRKMi81bGs5ZDBwSUZ5N2ZGWGtoQncwWTM1V1J6?=
 =?iso-2022-jp?B?eGhiaWtSdjIreWc2V3lZUFI1ZHZFRXlFSE5RUDlOREZmN1ppT0E1cmFK?=
 =?iso-2022-jp?B?VVM3Ung2OEZxdlFqQkFJaUJ0dUNLL1duSVZpYzczZ2lCdFNmdTlUbmRs?=
 =?iso-2022-jp?B?QTRlWDhxWU1UemFFWDNISWUvYjVDQWNkZ2NCditDd3I2Z0crSmJBbzVD?=
 =?iso-2022-jp?B?UnZwbC9SZ2N3NllHcjU3ek82Z1UrS21NY0xWb3c2Umlyd3RMaG11K0dB?=
 =?iso-2022-jp?B?TS82b2xJVitpN0ZtaHNMYlIxUlkxRm5JQ0pHS010Wk1yeTdyaWlReVAy?=
 =?iso-2022-jp?B?Nk9lNWxnNEZhTUpoM292eHhpeHkwVUpXcnNQdDhJMnBvRWN2dkowQTVT?=
 =?iso-2022-jp?B?SnpPbVFsa29XRzQxMTVYWjFWb1YwWlRuZysrbnFjUTMwWHowdzZkZ1pC?=
 =?iso-2022-jp?B?YXhSWHNXd3pnZUx5Z00yWm1QZU5wZ3dMeGRaT1dUcStBUVVGRXBwVnh5?=
 =?iso-2022-jp?B?bEI5UjF1TVp5dkRZWG1aNERvaGVKaTQyOFZycEVTSGFHd044VG0xT1lZ?=
 =?iso-2022-jp?B?cUtTcFNFblhXNUJlaGZPd2NOSlY1QjVZdGljQXh4Ty8yeUhReSszNXl0?=
 =?iso-2022-jp?B?aVMvUm9TNWdYRmIrYWFDYWR5UU5TS1lFemMvSlp1ZDBzejN5RHhyenhp?=
 =?iso-2022-jp?B?amxiMnhwRW9zSUN6ekNHNkZFUExpeVdQU2doY2xXeGJoTEx1MS9wZEFP?=
 =?iso-2022-jp?B?VUdaeGFrN0d6aUlUa1NFbjkwNWdHWkNDNWRyaSs2R3ZrekNpcEx5cGxn?=
 =?iso-2022-jp?B?blVMa2lCRVlSTlVyMVlnNUJYVG5PL3l0UmFUZ01Md1lmMnVRczdqOWZh?=
 =?iso-2022-jp?B?QW9ZS3VFeTBpY241aWVDSEpiQ1NmVEdXSzJoYjNWYnNhU0VHWHdtZFpQ?=
 =?iso-2022-jp?B?SUxwMVBDbDI3U3FyZGw2cUI1aERjTHdPNG9mRkU3bmp5dTgzbjVkSUNX?=
 =?iso-2022-jp?B?WkdkNHpTMSs2QUVYUlAyTHFhWFZHZ204VVlydFhHc1pFazBIenBMbEwz?=
 =?iso-2022-jp?B?SmxmRW1CeVNjbW0vUFY2QUFkdjF2ZkthSzdDOHBYUzR1TXNqMis4S1VK?=
 =?iso-2022-jp?B?WlAyUHM1ZWNubi9ra0xHS3F3VTE2MGd0aXJtVVlKaGxOZzFzb1VoZUI3?=
 =?iso-2022-jp?B?aDhGcnMxMmVIR2lENGdzaTcrMkJuRjdkeXh2cHpYU045bURwNDdHQ0JV?=
 =?iso-2022-jp?B?ZUF5dTM1ZSt4dVpkdTBTSmEwdTh1QUg5OWZJazNwN0dBNmVxcFJCMVc0?=
 =?iso-2022-jp?B?WWduVmtOY3lLTForUGZUYUxjSnhPdDRXeGpFTVVtVEFjd3NxTG1SVmJV?=
 =?iso-2022-jp?B?aGFBbnBXWHhDbVRVMmcvWDBkZDlDazd0d3hXTE4zeDdDZTlURU5aU2JP?=
 =?iso-2022-jp?B?RWwxVlpsQVo1OWJNK1REZzl3aEp5N2thbGFTc1hta29WL3lNelZVYnFh?=
 =?iso-2022-jp?B?emJBcStjQzhPeDlpSDJYWUhjRkZ4RTMrSURvdXN0ZHh4VUhqbThKd04z?=
 =?iso-2022-jp?B?RGJCcThaeUw3emJ4RW5XNWt1bi9ndndsUURKQ3poemloWDJrSGY3SEFC?=
 =?iso-2022-jp?B?MXFyVnR3cFp1YmlFb1c2Nzd6cHU5cXp5RXptZ2IxSGkzSC94dWFSV200?=
 =?iso-2022-jp?B?STNQOUtFbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T++zcD4U4gHWALidM1ar3bSwGl5l3CNG7pd6VzVn888kOKPuVUvIdrWZirArdPOg5fnzcEvU25d7EIQZVbsZAxRZtM/DCelflwo0bA0f4OyHj0PcQFzvMffFM33/qd01rXAqtAyY/5UOopOTcYi1V+wEb05A3QNd/mXQFIUcXk2opGWJkL3I4bevoh7w0snP8wnzn6CKs9BMdM9huIE5JbCBPaq5zriqiMiROMIuLsDf0C1kTVAk+VhpkacLLupQErRIYKp08HPEk4iEVrzJKZ5pQ2Ssl5uvhvxmv6fWivvyD0hA+KcNKOgpIx8pA+CD84LeuO6hekMwJ6TLjpGvBw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd895c6-aa11-4e1e-c591-08df2fffc04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 05:45:59.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEI+YHbJDlZAbpvmS3i8uBX2YxJQGCmKixI2KXUOA5NVIqp5kHqkzXicIVtD8ta5V7StolqsI3+mp37Y3ybnnEx/7qJyXxgMsu1igsJeqb+Yc63JtZz55rJGRv+1P9Bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12035
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 05:46:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24506

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Friday, October 16, 2026 7:10 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; uli@fpond.eu;
> john.madieu.xa@bp.renesas.com; biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] Remove duplicate field_get()
>=20
> Hi!
>=20
> > This series fixes the duplication of field_get() introduced by the LTS
> > commit
> > 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
> > helpers").
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20

Thanks for review.
Applied, thanks.

Best regards,
  Nobuhiro

