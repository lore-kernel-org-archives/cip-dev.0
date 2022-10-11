Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2BC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 08:57:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.5039.1665478638939958449
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 01:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 29B8v9TP031000;
 Tue, 11 Oct 2022 17:57:09 +0900
X-Iguazu-Qid: 34trKYV6udtHuqzwX3
X-Iguazu-QSIG: v=2; s=0; t=1665478629; q=34trKYV6udtHuqzwX3;
 m=jVGZDEc7yhuUebGiXaCNArAiNCGyj3KMFMDYPJUaZ2w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 29B8v8Gd008852
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Oct 2022 17:57:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDNtbu41xe1QIH3t+LFLyB2tEtvwiWCpTihXc9kFjYDx/Yc5fuZGXvcWj0n0aHyGi6ucFZMLbmBupQ/QS++EZBuX6YdXe8pkTR+8vgFPwsielcgWfODiGxXCQhTHh2uAcryIVUEf8lPijrT4DcR0urrv7iaE+PETnJCRTt9M+hP1SYrMs+3wQi56Vd/6z+kCAK3VcwCOsNw24xzZTiwnbkHDzzuJNbb2pWF2EU4GIoV5m6YfvVss3oFERpQ0G36mAXInKatSwKP9hIHRq9kATL5HxRQW0ZcpXj0V7nTjLynHWQE55/xxtgOZlHU5oEgu+QwvaDvuUauuV7Qisdgy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pbN80fE7CRRCbxIKSwssAaYPafZINPP6vJ7cMSpzz8=;
 b=Dk2ntN4YOQ+CT/Xjb0AOiR9HGV/WlRANY2vtyZ/viLazTbzAnnveyvXVxUGwh181Ybetq9DP/cW0ef3c3m7AopjBiZ3UuSioEZHRSywfICNTBLXhtI32cuiOyKDownwxny3bHFjXygaxduNpiVaQbk+HLKXnSiR5tT8J/HOpoJJkjr4b3Wogyluftf4leBcyTY2mWzWdgzdujbr/2WATA/bEs+7VRdeF+uNEHe5VqEjHbgwx/CEQa3KZ5Tp6BxowWcvv9yD/Ns8I/O3/qwNIDfHotmYYGJ+NOkGpACeEBRkTz7vRWqUE4vb+AuZxUaklqmz7qtyV8Ixb22P8Xadu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_probe() error path
Thread-Topic: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_probe() error path
Thread-Index: AQHY3M8lBWQOvAec0UigSBt/jE7st64I45pQ
Date: Tue, 11 Oct 2022 08:57:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94209F22CB57D9DD527D3FDE92239@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221010173833.1375381-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221010173833.1375381-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYAPR01MB5737:EE_
x-ms-office365-filtering-correlation-id: 47bdcaa4-6f6c-4a15-cff1-08daab6692b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 53JdkqYg9+iOvwD2fqPIOutk2VMChEdARksO+31HvLTpmeR7KtYOkUWMeQr5+YD6oyX0/Mq5rlbbsmAefe9/GXD7SexxyhDcncGf22AvBvxsmMnV/EhPUIZmC0uXxk2qPaUsekXjX6ABryqiEZEnrtYSfkVrzME+nKGnNv/m41l2FdojSDi416ycAUzalMBENs6uv+tJp+9EnfxyEbg9pZvsn3mf0mpjgQrlfocJW1uDT3jiQmT8xxV7LEYbC4Kl8J8tOIN5Cb14QhPmfTACVlfA5+nOjDqUy5qz+3+sj1yh1FwGrid1dCUXyhvLaUNVE+fyboM+0pl4twnk2CeAuvit1MGk46t7WotrdJeBIblFP/yRV0tXuGYFQJhRipG4hScdRnhsJrjRSooZRyaeymVBZNaJgmylKlueldWN+ErJZgoEGevK8U5aov+1C2ozS1Dqnf1d36pbd/rkKUxemduP+iKCTcZ2RU2xBhw02cKsdWqKIyexkQuNFVoVVsFlgsxX10UIIzLQZ1BYAMHnXnqK5oR58kITUy9L4CngXchcCcgc5GPV7aUVKKZoFLUfMNLqybfnzraqwIZKLv6ICf4Ny5eIhDXAPPY3ie0JDNkzgMbqPnZjpQ2NytiAASLEBhptx61xtOD66FWLHwJ6C2xW2pGs8FpzbJ1YBLvgVX5FWVRKWkodh80e4zM+msw+0vQvJ2/j5Z8h98v8QPok+DK8lUjs5F90II2hAssOOCwp1mvuVq1zIZaIv6S42PqCkMqFJzLMJvmxj6kLin6ADHsA+r1XU6zszX7KGm4vYIo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(52536014)(8936002)(5660300002)(86362001)(66946007)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(110136005)(54906003)(76116006)(316002)(38070700005)(7696005)(71200400001)(966005)(55016003)(38100700002)(478600001)(33656002)(41300700001)(26005)(53546011)(55236004)(6506007)(2906002)(122000001)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aCtEN0VNY1B3MW0vVmY0QmpCTmxnaWtZSnNrY1pLeWVBZXRZR3BJZ1Mx?=
 =?iso-2022-jp?B?amViSE1JVFM4cDVwQWZsM1ZOcjltdnE1bmtMTVNXanN1Nzh5dWF6aGxj?=
 =?iso-2022-jp?B?RUZKbm96bmhDaWpSK2hROTU2bTA3RUkrQXZZa0paWGJ2SExhUUF6eEo3?=
 =?iso-2022-jp?B?VjBsVGpxNmZVRVNNWkxTWWtmcDZGdGRHcS9LWTZISG9WUUttOVBtL1Nh?=
 =?iso-2022-jp?B?dzFXMVFCMUw5NkRPRERZR2pzQ2QzNW1YR2JaSisrZ0V2VmthV1ZqcjNx?=
 =?iso-2022-jp?B?OTBiMVZmMUx1bU0xeXFPOXhVemtNdFIxQW9MY0g5ZzF5NTJMM2tzQU1u?=
 =?iso-2022-jp?B?bklyS0ZBNWVRRlBXZ1QrMnZuY1owSy9wRlp6MXdRTTB0dXdKbmtXUW5G?=
 =?iso-2022-jp?B?elozWDFpTVd3UUd0YzRoTEVkZUJPdmd2OW5xdnVpSGw4M1NPbC8vTkcx?=
 =?iso-2022-jp?B?WVlkUDl4bUVCSW1rSUZiTFlIcHE4RzFNR2hHWHJqdEVJM2FZQXNlREJl?=
 =?iso-2022-jp?B?RzlNelY3TkllNzNGOVJlQTAxUzRRVGdJQnI2ekt4WVJRL3E4am8rNGNM?=
 =?iso-2022-jp?B?WG1DNzQ5VUs4TkJaWDhYT3ZmRmJTUmRoTTAxMmQ4QnE5QUtoakJNYTlQ?=
 =?iso-2022-jp?B?R0ZwT1AySll2NTJUVCtRYy93UXRRdythc005K1JkeXpxa24vYlJFcnd3?=
 =?iso-2022-jp?B?UkljSTd0Sk5halJDdlI4THlmZ2NuZW00aURvMHQ4MVZZWk1FZFl1ZFF0?=
 =?iso-2022-jp?B?S1RlTlZ6clhYblp6VDlzWGpEZmU3YUQ2bk1mUWtZWHBYcld2dFNxTTZa?=
 =?iso-2022-jp?B?bzd3dFpyVERzWFUwZk9wankvWVA4YTVkS29YeUhVTXVNSHRpcHA3aU9v?=
 =?iso-2022-jp?B?QWc2RmFuV2R6cmFrUEY3TnBSVStBYWdxS0w4U2YvMVB4UjJCK3phZmRX?=
 =?iso-2022-jp?B?LzVSOERVUldYcHFZWkYrRTFTVkQ5RFhnbEhBMmNyRmI3MlNCSDFaSDJD?=
 =?iso-2022-jp?B?TmlVOXU1emhDdVFBeHpIUjJ2VmtiTkUrekFBK0hOMHZ5S3BYeTJLa0hO?=
 =?iso-2022-jp?B?NkZkRGU5eWd1QVN4aVZtNkRnbWo0cmN5bCs3OEtmTEJqZ0llU1FNUVpj?=
 =?iso-2022-jp?B?ZTJiUWxFM1dYTGdPNzJ5aWwwZHhXUTM3c2E4VVBySnlRWTVIOE00UEpR?=
 =?iso-2022-jp?B?clN3bTJWWk5BTk1Cc2xFK3NSaXVEVXVJc1c1Rkk2MnlCbVpCUjhZYXhZ?=
 =?iso-2022-jp?B?NW0wMFg2c0MzODRvREFTNERKSzQzRFYxbTRmVlVHWURZUW5UdWlVdHBD?=
 =?iso-2022-jp?B?UWNmb2ZYV25ZMjFRd29MdnlHS2V2NzNTQ0YzODQ2cUloTWE0enZnbjZm?=
 =?iso-2022-jp?B?NnZ4bFpUaGZQSWtJdFZDMzVnSE5sTmNxZG1oZzJCK0hVVUN1cFovOVRF?=
 =?iso-2022-jp?B?ZFFJQzdSYmhnbkxzSlFxbmVzTUZiS2RudHdwWFUybC9MT1FybTltcXpv?=
 =?iso-2022-jp?B?L3h2MlBmeWVuWEg4dXdhNGpPUDE2a2lOMlBEKzFSWE0vclRaVFJBSi9p?=
 =?iso-2022-jp?B?WnF1WlZjMnF2VE80NGZaWWxNTXhDNGlsTy84NnZuWFBkOERKaWVkbzE5?=
 =?iso-2022-jp?B?UW40TGgyS1ljVUl5Szc2QXU0MEh4YzUwbzZDV29HRkNtMFBXbWtFUklh?=
 =?iso-2022-jp?B?Y2VDbVFicGI2RTNTZ1UvRG5zUkRHTzY0YVpjdzRNa0puN1NtTGVIWHk4?=
 =?iso-2022-jp?B?bC8rUHhRK0tGS0pjUTJQeUlFTDJCMW9FWFFNNnBHRDkyZDVhNlpaTGU3?=
 =?iso-2022-jp?B?L2hmY0lCR0dlMnFZSnhCMGtWYTRtWGlJeWZ6M0J0dWNVOEszUHJyaTR5?=
 =?iso-2022-jp?B?MUdIZ3BpTVJKOVVlRFhlWEdBU1JFakQxK1pnOEdtVkgzQ0JqczRNTmRT?=
 =?iso-2022-jp?B?K2xBdjY4YnYwZXFYVWNITVZiRkhhcEcxUlZBcHozTk5ZS052SjBPU3Ix?=
 =?iso-2022-jp?B?YjVHa2dtZzRJY1M0bGltRi9VOVJKNys4S2V2T2xPOUk5OEFENjNXdVVC?=
 =?iso-2022-jp?B?ck9sMy94aFdjdXFGVjFpUGpNN3E0OHN4MWZ4YkcvUDJhbEdVNERFZ2lS?=
 =?iso-2022-jp?B?TFAxYXFnYklMcWpjR2hlZFBjcU0zOE91SlRSMmo0YnNkNEdYbFpiMnkv?=
 =?iso-2022-jp?B?TU9uLzdhazZKTGkxMWpCRlJDNnBZbm9rYXhNamtyMnc5Q2lJU2JvSnFK?=
 =?iso-2022-jp?B?QVJpWEF5d2F6RmxoTkQ1VUlTYkx5dUdqb2dCa1hVT0pjOVpyTjlOU1lG?=
 =?iso-2022-jp?B?SVZVaTd4YkJGMU1sbjQzQWdKVkFNTUx5Z3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 47bdcaa4-6f6c-4a15-cff1-08daab6692b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 08:57:06.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 kUkM2Gicd0ikpG2yKYm6Hh0QADks9R6ZHhgc82c1yHaiuHYQ0SdK/ixFLZqg575kMkhlEkBeMkBCUqFII3HJmIl68iHUP2mRZOYwwa9cxKXI+V4CDdfknT/yrYda1LW2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5737
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 08:57:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9707

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, October 11, 2022 2:39 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] ASoC: sh: rz-ssi: Improve error handling in
> rz_ssi_probe() error path
>=20
> commit c75ed9f54ce8d349fee557f2b471a4d637ed2a6b upstream.
>=20
> We usually do cleanup in reverse order of init. Currently in case of erro=
r
> rz_ssi_release_dma_channels() done in the reverse order. This patch impro=
ves
> error handling in rz_ssi_probe() error path.
>=20
> While at it, use "goto cleanup" style to reduce code duplication.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link:
> https://lore.kernel.org/r/20220728092612.38858-1-biju.das.jz@bp.renesas.c=
o
> m
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  sound/soc/sh/rz-ssi.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Looks good to me this patch.
If there are no other comments, I can apply.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/66354=
8693

Best regards,
  Nobuhiro



