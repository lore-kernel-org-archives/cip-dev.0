Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCEAC25B08
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 07:28:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.26046.1660721277546740039
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 00:27:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 27H7Rla5021906;
 Wed, 17 Aug 2022 16:27:47 +0900
X-Iguazu-Qid: 34tKIuUqqAFxg06JKK
X-Iguazu-QSIG: v=2; s=0; t=1660721267; q=34tKIuUqqAFxg06JKK;
 m=mb+i5NpJ0n+lCjiV5Tl8cbTDfh6sKhbEZom/5bxuQUI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 27H7Rkl9026203
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Aug 2022 16:27:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpYgoOQIedZVKjNVW5xuNA8GF5r2utM3DRSf1jOF3YCNYEWct328bNauXGLH34WqT8QSEjJBo6HA64B2XXVsethRghYIwB2gfQcKuQsKKfGXPQjzo7IDzICQ0UEdWxvaitfvmbA57MCblvr0D0gqb9CfrUIZ2ek3YLUt3ZfmtknvFJclk7G9AyQJNsCUg6jCkNrzMCp6MhHrLxOjIfk9bC3leIXFrzS2ptyXsLsPioieoURofm9MvqtONBL+hvARTFRNxzPwUIoHVA+WTZC3rL3qPbaOwgrWofm6bsEUoCLhsX2Ufb1ElAj9nX9ZYEG+9xMK+gl01z9fh2d12YGK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH6eOhTYNXQb7dX3fAv4Y8vW4lwl+wchuvEvTSxDCHI=;
 b=n2QTyr0pL3ft38q5Y0zNScB+mvREXfULrueYaDdVtXuWEHMcLLs7gbpifETEsTmf03qeDwC/8n+8i744grOVGUPp+xa034J6KbamknbmVENIELMiJk+nJFgqcjliA4FsUC0DvZpwSPlXsxvQfkA/6NrJ8eM2Yl2hWqB4nA8qgZbQmv5RvoaGr8pQDgYcBr82cjB4mjKAF+GK1HjxxoKJgsO8zOBfeHwbEL4rrn5SH90uk9In6GYLZSJ3kI/wUGVnFypqGXBnpZ/y1UOmPt1OE672Md0PzxRA8nLCk5KNaKsAbZZBlNs4k7Fma03g/sgrKySjOhRacGP8MfM/UoFUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Thread-Topic: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Thread-Index: AQHYsWWRwTxC7igFeUuVDosPyVkrGq2xajkAgAFEItA=
Date: Wed, 17 Aug 2022 07:27:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A171F93C36354A27F9CC926A9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220816114408.GA27428@duo.ucw.cz>
 <OSZPR01MB7019E251B422E91203D2F7FCAA6B9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB7019E251B422E91203D2F7FCAA6B9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0f091a7-00df-4dfa-a2e8-08da8021f91a
x-ms-traffictypediagnostic: TYAPR01MB3967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Wfmrvw3mHIzL8mn5rH8e3JAXDkAIiJuZ9TzPntP6kxU3yhLb5AOCkQIEd4Sr2pitKfr7jwY9Mdo61/rnSW1SrgfZgcbEbu9nnAiOCt4YYSXkGKf99Jsl2HNmUvGWNI3yDuS4SWbsh8hwc64yCtFpEBnNFz8uGRio2DGbQDqmfAsU0on9aMObFcOf2UZybGpwor/CpWwT8+6lsEwgWVzuakvEKrGQ3vT84iUWXCV99FgdWrZITl+sojTqqzpNya/sQooZjt5c5aHNs5KTRIDxYlFwQ+Pk+sVVnkbkJdidrMUotln90dA3sVFolqAQ+dSZ8/ezNkMsGOjHNcp/4kD2U2fPgqrgEBsaHb4/TFyT0RgPGVB8rUJPcn08bnBwf9V5HFE1Rc3jKJClN/9rQ5RDWRZGecTsufuxW7b/K6G24b6xQrTkFIveHl4ERJmDGqFLJwYOj1Taic6In9uHL2Pgj/BtVljafOcDAPjiJVAwqr1/aA7FZWgz1o3ZhDbwc6GbsBzz/WQuiyVXDLgTazmKBY1ZEBgntaFm3EiuE5oHUcwtD+8t8rjtBh0gGQBDKvrO8jtvD5i6S4HJJUVKQudfuE957RwO3unMt1KaZGIdyIi+Gi9gzEGN//L7cs2guYtGt4bwZyQPwYZFJxip66II6ijvlqrzayyFMf7kxy6oHbI7bRpVoF3xMAh6R5wTvCayW9dFe9tbvrueoPZ8qJ2RHFcm+eQCvEsYqY0AccG+wXMKMWBZuJ6+RAPoDsOGhnTyB++9R6guXWZ66K6hZV9r42hPfZpoecdICeyy34rOxBbHApK1l0nXhU+PPb8wyZ0o
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(110136005)(66946007)(2906002)(8676002)(66556008)(64756008)(66446008)(66476007)(76116006)(55016003)(6506007)(71200400001)(7696005)(33656002)(4326008)(54906003)(316002)(41300700001)(52536014)(478600001)(26005)(122000001)(38070700005)(53546011)(9686003)(86362001)(38100700002)(5660300002)(8936002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eUVSLzVneXBLc05vN1cwcGl4NlN6L2tiTTZsQ2Y2NVFoT0tWZG41SkRr?=
 =?iso-2022-jp?B?a1MwY1l6L2U0Lzlia3R2cHVmVzllaHo3MHRESHFFN1NGeHM4MDhhQkFz?=
 =?iso-2022-jp?B?WHJDWkxmN3FXSllweEFwQXd1bDlqS0oyOEtCSVUxcTFUd3lBWDBwT2Zu?=
 =?iso-2022-jp?B?WWxLOVBKZ1M5bmtRUnU2Q1NOd1lnN2FxajNjQnhsZ0hXcFNkdkRubmFh?=
 =?iso-2022-jp?B?a3pXbXB1dnJLa3QrWEtvY1B6YlJnWWlTVk52WUo1QXV3RU9Vek1aelZr?=
 =?iso-2022-jp?B?a1BxOTVlbHQwNWtKczBFcmdTSnMvNGxTbnBJSGhpbHNEc3lWWW5CREhp?=
 =?iso-2022-jp?B?ZW81TXlTeGMrMjFzZGljRHc2YXBZK3pDdkJoMXdQL3lxNVdIdW1hNzJP?=
 =?iso-2022-jp?B?TXAvSy80UXd0TGtHK0NLQXlVVWFPY2VpazBTc0N2MVhacmV0S0g0a1No?=
 =?iso-2022-jp?B?aS90ZUhRY080YTI2ejRQOERYcnNoVzdTSVBCWTR3ajBBSDBsZUh3UFh1?=
 =?iso-2022-jp?B?dzI5VlZ4WW1pRkJoVUpTdldjcS90Ui9pL3AyUm9RUU9qRElremduR1dq?=
 =?iso-2022-jp?B?UUVWN1VrVjBWTzdvNGhyczZSWFNvSFlmeEpFbmtzOTRpSkNRRW9STUJM?=
 =?iso-2022-jp?B?c3krcS9ZUG1JOGVPTHpQSWhkRDNWTHZMc0J3MXFPK0pxRkpGWXJPNXhy?=
 =?iso-2022-jp?B?NVUyTSsxWXk2c01RZ0o4cGMwVXFqeEZOVzBxUkZZWGNqcGdoM0VQd0hG?=
 =?iso-2022-jp?B?MkQ5N0xyRTlLMHVkVDlkelRnRkFYaGJFYWVtM3FNWmJpajJJLzcyQkk3?=
 =?iso-2022-jp?B?UzJDbHY5WlU1TXR6V2VZeHlFcSs0dmFITHhDZU56ZkJtMUlHbHRqQ1dv?=
 =?iso-2022-jp?B?c0VIM2c1dm5FNkVYYU1sWEQ5VG1vM0JzMHJhY1poeWVTMFNTMjVIa0dE?=
 =?iso-2022-jp?B?OHN3eS9ONEZ6YWs4Uno5N2paUnlrMm0wL2FneTQzN3hlZllTV3RXZlM0?=
 =?iso-2022-jp?B?dktpNGZKL0ludkI1N1UzSENBTE02M1ZVY2dGdW1iZkJraUEwL3NoTmJ1?=
 =?iso-2022-jp?B?aHN2UzY1bmlFcEFzVHNSMUdZdHlLOHlQTm0vWUF6NVEzU1FRdGdjUC9S?=
 =?iso-2022-jp?B?aFc0Q3NUT2o2bnl4ZGdmWnZydU1iVzFoS2Z2eGUreWd3M3pvMWxRYlAr?=
 =?iso-2022-jp?B?Q3djaVBsWTVyQWVBa1lRYUJuRHovdUxRbjFOWCtPVXNMeG05ZWVVN1FM?=
 =?iso-2022-jp?B?ajJkZHpnMnJFWFdRanQwNnFxaVk3bzdTNVdQb1NSUmdjdWt1OUJuZ1Zz?=
 =?iso-2022-jp?B?c2pCLzEyTnNkaXdJVHhWY3RreExUSmpNSkpEY05oV09xUGtQdFlyRStw?=
 =?iso-2022-jp?B?Qk1pZW0zMVE1NjFzOTBxUHhXcVc0b2VSREJxbml6UUp6ZjlaYmZZbGY0?=
 =?iso-2022-jp?B?TU9yd0pDdENsM1JhUXZEUlR3cFN5QUhqdXI1Y2FmZjV5S1pvcitEZy94?=
 =?iso-2022-jp?B?R2lvWWFIUTZJMXVGUHAxdEE4Vmc0U2pGUGprdUhhUGprand1T2UwNEJj?=
 =?iso-2022-jp?B?Y2ZkaVoxeGY4QmtKYVV0TCtkZFlSSmRSMThKYjNHT3dsZjFSSU5rc254?=
 =?iso-2022-jp?B?L01CTlkwSE42ZEZob0Jicmd1WnF1cUpacDRJRDlVSzl6VWp6ZGY4cHc5?=
 =?iso-2022-jp?B?Qnl3dVlXQXBCNXptYTVwODBFTnhWZGVKdUVOSFZpRUozK2xIYm5kd09O?=
 =?iso-2022-jp?B?b2lIVmhkdUtiVzJMNms4OGVRK3lud2JCVGY3dDZoRUNRaVExY3hXelgr?=
 =?iso-2022-jp?B?M0FGMHhKQWM4bmdnYlBmS0w4bWJHUjZzOCtqdy9Cc2ZYNFkvYkVLMGF5?=
 =?iso-2022-jp?B?QXlnL3ZGWEFSRG1MN05OZWVRRjhTNzJTUTNnQkRCL2xxUldWbVhzNWxQ?=
 =?iso-2022-jp?B?ZXVTc21yeXFsYWdGbHY3dzdJUUF1RmlOSWN6NUI5U2NGOHh0cnZTRFZn?=
 =?iso-2022-jp?B?cTZZOXZHeTBVNWEvd2JiMU03YkJNS1kzS2htNzk5bWsrVGpzWDh0MkQr?=
 =?iso-2022-jp?B?UlcxemxNK2wzRXZFZXFqY1ZTYXg3bk0xN3U3OTM1dmp5UHlOeldnTVlJ?=
 =?iso-2022-jp?B?SlJFTVlaMnBMRG5sMldwam9sZzEvLy96Tnk4MFRnTVM1QUl3WjJoODcy?=
 =?iso-2022-jp?B?NWlIQmwzRE9SMmpwYm8xY1ZjdXlOMWpHWWhRTnoxOU5jeU1lS3dXa2U3?=
 =?iso-2022-jp?B?OWZWSE5CK0lLMlNGNWdxYkJTL1FGcVVIbEpzRnl6UHM4RFZmdFlYNlhh?=
 =?iso-2022-jp?B?amtPRENwMU5KbzI5YUtua0Fac1lNZnhqY0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0f091a7-00df-4dfa-a2e8-08da8021f91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 07:27:42.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 z4xjomy8qJHATWSDGdYU7VoHVcCFwSyUHI29QG8jzez65wsbNu7knuZ7NHJHGTZpmb9G/QwVLFZzxyRj27I0Zfp7sqyKVp/vrldGgRvnk2gQ8VIdjSVb+6gWFtQdl0di
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3967
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 07:28:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9270

Hi all,

> -----Original Message-----
> From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, August 16, 2022 8:51 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes
> and improvements
>=20
> Hi Pavel,
>=20
> Thank you for the review.
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 16 August 2022 12:44
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Biju
> > Das <biju.das.jz@bp.renesas.com>
> > Subject: Re: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver
> > fixes and improvements
> >
> > Hi!
> >
> > > This patch series backports SDHI/DMA/thermal driver fixes and
> > > improvements.
> > >
> > > Note: All the patches have been cherry picked from 6.0-rc1 kernel.
> >
> > Series looks okay to me. I wonder if we have code using
> > rz_dmac_device_synchronize from 4/4 in the tree?
> >
> RSPI uses rz_dmac_device_synchronize from 4/4, I am waiting on the patch =
to
> be available in -rc release. I have tested it locally hence posted it  ea=
rlier.
>=20
> > I can apply the patches if they pass testing and if there are no other
> comments.
> >
> Thanks.

I also reviewed this patch series, looks good to me.
I applied to linux-5.10.y-cip tree.

Best regards,
  Nobuhiro


