Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1CAC25B67
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 23:33:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.136307.1698104009842435099
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 16:33:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 39NNXJYo1691023; Tue, 24 Oct 2023 08:33:19 +0900
X-Iguazu-Qid: 2yAaQ5iWI4AzdhGZST
X-Iguazu-QSIG: v=2; s=0; t=1698103999; q=2yAaQ5iWI4AzdhGZST; m=tqb1BgmoFc7a7SOE9t5vKOtiWxoo4acsUu2d8Vkf9dg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 39NNXH0r2866938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 24 Oct 2023 08:33:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mApWZsxZYgozx9lmLAXrk6Xt7fiTMV8MqJgSYJg6gV7ksCw1zdNL+JprDBVETxHawZbJC7WZBM8fgzLAH5plGB15Po4QiEe7vWfxCQv3eTr1JJP7ho7GDQjq+D7dDwXNsGiRVKILfqp33n+18Sl31sjoOU7GuP0qBEHHGuWglZYNg3yMJUonnpHn1nzE5GfCAGAE6b3pUD4ZjIPWXfL28DYq32DldPJNbOuF0Q3szqErAY1jQKr+nyAg9iJ6tsmTmcyqmI2r6LCBBXjY6xtjc15Wryz36XgvU+9PGGf4viKLlVtUWQPOPtQ5jXFPXVf8n75sekxkq5y5tkBKI1GLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiYx9hnGqQ6p4LPxK71CEMhu3L8+WPrrX9QnDlNg2mc=;
 b=Poz6dvd2cC7rFEw8IJ07zicq/Dhky3vzAGAPHFSIb7ptu+HFGaMQ4nbqDp02B63dDIF+LKtmr/LFtT4NSV7kYBaC54cGPHEl64bOWunWZQ5/kkqpGb214J46LRGYffIKNNf4qN/X2E7+qTarbXMuwYGQfjzqwjrJjdms1xyPiiqwQoz1d676DhIJnAkphVz0CT8YakMDxNNvjqzTl2LJSK5bfm5EfMiHKGL2srXBxc1pBb0v3U9D1r4rVv95i6KUBxOZE7AAT+ULct9FWsi93y1Xjk2/zy+zViAsZORg1dnttbsBkGu08UBM4wP2jpb7kkzawH+N8nWI+WBZd5rCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 6.1.59
Thread-Topic: 6.1.59
Thread-Index: AQHaBXkqCpRMRkE5BU24PO06fgc+dLBYBnBw
Date: Mon, 23 Oct 2023 23:33:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245C3B05F2A4BC59EDFA80B92D8A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <ZTYQ1dStV2p0A8GB@duo.ucw.cz>
In-Reply-To: <ZTYQ1dStV2p0A8GB@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYAPR01MB5963:EE_
x-ms-office365-filtering-correlation-id: 9a2574a5-a8ee-4231-5384-08dbd4206e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1MIyUficxwx3klWfIJD8FtzfP1EEVHDapIuhMAHttyfEY7LaiE0hnhMXQGRjY+TmQ1UCUG/Nfx3OXJPfISdMvFeBZ4eKKugmvmXKmZL6HfPw3awsYS5mt5WksKIiIZ5WJuDFNblAnszjK70QFZZ15mKhMNZgFr6kLRrVwBUjt/G1cFh86MCECZX6DVR34h7dEAwDj1Qm8EFTDwyYONpjXfTgpuE89CPvXnQo4hiA3jprU+jipWs/azqmYdx2dkci116vQay6yZj6qWh5dVJpzX2FXVN2ecrnnJbrrg5db0yU9LiGom8MWFAls/NuAV+s3DhvLOSty83suJ9omUwBeddXSgjgdB1YuGjmthkRcDzUYy/o2yw6nfLbc9RSnQ+gqIOwQCoZhrxrT6Uno09yTX3j40hoblT4u8aWvx0O9D9z9LKN88sZjaBdCGxNRT9Uh724RQL98pgeYnUVEhtUldxz8wQdtzY6ZwB9Wh2y3b+5yIGgq30ln7vtaIbAERW1g9JHsrApyc7w2AsI9x3TAOC3MbFrGZ50vo2O5IUZX+4w2mnDXGYU/Y/ga+8nVTkVCj14B4j7RAzwoKJEvq04L6NACGzC8lSeKHxlJlpIeSO8CzEX5VwPJ3SHzZsV2tF4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(478600001)(7696005)(9686003)(53546011)(6506007)(966005)(71200400001)(83380400001)(26005)(2906002)(41300700001)(4744005)(110136005)(66556008)(66446008)(66476007)(66946007)(316002)(76116006)(64756008)(52536014)(5660300002)(8936002)(8676002)(38100700002)(122000001)(33656002)(86362001)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WFZMcDJFbGFNVXVqK1hpNEdSM2I3TGxhRlhLSXQxZkdLZE1VcmpSQkRC?=
 =?iso-2022-jp?B?NWRmLzVBWFZVNE9RZFlxbHJaOFRGemM4TXc1SndwLzcrQmxKcDFXeUtp?=
 =?iso-2022-jp?B?bmgxaVNDeWVueDFxRTdXeldHYmRBK3dmWFFLc2hteWN3NzI4VEVaWDc5?=
 =?iso-2022-jp?B?K2JzSkg0dWs3aTZxNjhEQXZnVkw4bG9ibUFlWmM3SitlMnRLMVdRdnNn?=
 =?iso-2022-jp?B?cVMwS09xc3gzNmNPZUJqd1dhbHRWbXBGSGx2ZVZseUUydzVHMThpY2NV?=
 =?iso-2022-jp?B?VEVQUW9MbUZCdzRrWnZqY3FWeTZ0WWJGQ2dMdDNDWm1zY3Y0Y2VSNjND?=
 =?iso-2022-jp?B?aEZ1M3luWjR2bGNtWWdVUm8yMmM5bDR1eWJMd1kyTWRTdTFQWG5nd2Zr?=
 =?iso-2022-jp?B?ZnJud0YveE85dy9BaU82TTB5Z1lWV2ZEVDRtOHU2VHNlczJoWFZLOVVC?=
 =?iso-2022-jp?B?ajZodzB6VlpONm4yQmhLS0QvNGUzdFJsZmpXaHNidEZBTEozMUhVYXdN?=
 =?iso-2022-jp?B?UFo3ME9wd0F3MzA3emdQN1Q3ek80VHdRQnBISVlNVGJ1MUpHS2xvS0tC?=
 =?iso-2022-jp?B?RVV6L2RQWTd1allhdVVoNUszWW5Eb3RRRm5LbmU3Um1vUW1RRzBvRVVy?=
 =?iso-2022-jp?B?a2V4ckRGZklBMS9SNlJNMkl5ZTdyMUdQbTBjWndIVlViK2VhM2YweDgr?=
 =?iso-2022-jp?B?R3BXNW9ROTFKM012WEYvV1hQS3ZDelV5cXNZZ29DVFJzTHA4aEtBNTZ4?=
 =?iso-2022-jp?B?MlJ2Y01KSzdUU3psSlkrVkd3by9rb012ZVd2d2FZWi9FTHhyTHN1NDRy?=
 =?iso-2022-jp?B?eUtCQjU0Rzd1RjZFMWg5MWNjaHhGeTVGNnlJWU1aNmd1MEh0WGhNTWdC?=
 =?iso-2022-jp?B?eWhzTDRRUTlIRk9tcENiNUVDZkFEYnFSSlBBM3Jrb0gzOEdsaUhFN0ZQ?=
 =?iso-2022-jp?B?MHJtUHVJcWs1cStSdXQwZG9aeTMyeW1ibVExZnNON0hyellNK0RNWm1r?=
 =?iso-2022-jp?B?MXlNSVV5aHhweGdqUzVReTNKWVFGSUlLTm41OTN4NGV2V2pPWFZQTTlx?=
 =?iso-2022-jp?B?RmREZk9keURiM3l0ZUNGcXl0NlRoQUpTTVVIbHM3Q3FacWI2NllnZElE?=
 =?iso-2022-jp?B?dyt3TG5ubzlWSHp1NDNidG5SaDJrYWVVbjQwR3NmbStUVy9LZVIrQ1g5?=
 =?iso-2022-jp?B?NGtvbmthMlI2VEdkcWR1cklIWm5pTXB1c2p1NEpvNDV5dzVVbHI2VEha?=
 =?iso-2022-jp?B?SFFZOUQvclhKNTYvcCtTM2l5Tk1kOENxWGhvUHd6WTdLSUg4QlBwRlNK?=
 =?iso-2022-jp?B?Ti9LUlFodVRDQzVnR2p2M0o0OWk0UGJ0L3p3SHIyaWNOL0VVMmdhM3FF?=
 =?iso-2022-jp?B?R096UEpyNVByK0hkcU0rVWZKQjVBVVNMVzNtRURGMnRlR3ozdlFmMUho?=
 =?iso-2022-jp?B?Mk9Zeld5NTAzTzBlcEl6UVBhbFhOMXpTZkl5RngrRWdBSWUxMlFEbWpH?=
 =?iso-2022-jp?B?a0ZYTUFPdGtZcjIrb1RSSnpmOVVBVFJuamxvL0dvTEJMYlFKRTdVUXNR?=
 =?iso-2022-jp?B?eERLQ0srS2RWZHdlUmh0V0YwcjU2MmdZQ0xxeTAxWHRYNUZ1UUladmxB?=
 =?iso-2022-jp?B?bDZzUkZvTEk3R2d2eE9TcWQ0VXJURm9mWGxtK0JYdEJwbGpNZHFXL0FD?=
 =?iso-2022-jp?B?YUFLMVYrOXoyelZnc2pDR0ttZmdpbGlNdjlqYVVBOU1aTUhmOHc2SWc3?=
 =?iso-2022-jp?B?eUw2TG51QUVaNEkvVXN6NkpUY200aEQ1dStyZmdHaGUwQmJVUGZRNnBO?=
 =?iso-2022-jp?B?YlFNL2s5dnRiZmZnbWZFTFgxRVpuRWRDRFI4RVg1cUIrUG9TcUdzY3BQ?=
 =?iso-2022-jp?B?U1V2UnNtczgvSXI2MFZ1dHZDbVNhVEViWDVhbGsrTWUwWWZWRUVxbG1X?=
 =?iso-2022-jp?B?YTdUWXR4Mk5lV3VHT0dNdGd2WU8weGNhamJGODRLSkdyRGhVUzl2THdt?=
 =?iso-2022-jp?B?NndCQjkxcExmc0VROXdDWUc5enRiaWN6VnZzNitJUThwL3F3eXlDUjcy?=
 =?iso-2022-jp?B?dC96dHppTlF5NEpEbUVOZnNDczJWTVF3Y0hzVWlMLzFMcUd5MU1tM0ZI?=
 =?iso-2022-jp?B?Y0FMblhKT1lCODcyRE5XQXdRTHJRS3VCZEFjeVBKbGhNSFErbjdvdkZB?=
 =?iso-2022-jp?B?TTF3SFRNTW94d3Y3VXZmWmthbGRsRXhibU5sZ1UrVFA4UjdlQVBNa2xM?=
 =?iso-2022-jp?B?MExIMmhVbnptckVCcEszSVBTV1YxMlBSVDhPekx6Ris5ZUgyWXRRNk5x?=
 =?iso-2022-jp?B?ZThkSTJjVkk2UFkvMFlLRkhiRVNYekxReVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2574a5-a8ee-4231-5384-08dbd4206e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 23:33:15.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAs+90G3L2j169gOXx01QRydsEsWJ/QuN7tqdQhtRgBsYUjHIZ9r08TG+vfsucEQaeN2JnLnK+GNxAQvmI/ACSguVsAFbSdJREGGzOtt8fMKUtYbTWW35h56Ei5XnzLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5963
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 23:33:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13443

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, October 23, 2023 3:21 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: 6.1.59
>=20
> Hi!
>=20
> There's 6.1.59 out, and it would be nice to have matching -cip release, s=
o that I
> could do -cip-rt.

We have a release date this weekend so I can release accordingly.

>=20
> Alternatively.. maybe I could try to do the regular -cip release just to =
test out the
> process?
Yes, of course.
Testing with automatic merging of 6.1.59 is performed below.
If this is OK, we can release it.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1043140413

Best regards,
  Nobuhiro


