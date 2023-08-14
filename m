Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138E9C001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 07:28:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.102751.1691998101310396418
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 00:28:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 37E7SIAv106649; Mon, 14 Aug 2023 16:28:18 +0900
X-Iguazu-Qid: 2rWhuF4KhgYwE0wyTR
X-Iguazu-QSIG: v=2; s=0; t=1691998097; q=2rWhuF4KhgYwE0wyTR; m=tezQxVaTQbIM6HdbMR7iqad4jF14T+1paCzHCbVzCGs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 37E7SGCu2402769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 16:28:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+BEtK36aD1vlHJBi54dGKQ9RdHnzWL0bEjRZOEyTP+NymVzxYlTs6RRZgZs3Fr/aif3fTadEPXrZRcZJPq76c3UBr5rFa3Ui1oollO4vxlStxhnrO0OF9TsYjs4icg3XznRm/aSzJSvIHV6+EiPGRtCbGZP6Z0JtDvgmqyHSzdJrYjQNK/rssq4sGDxY32/RTfI1+OQP7xuzRn02ZOM/VOGcyfGTeexG0fqb7mzYg+Lg38xbYM1cRd64KUGSB/zqjC+vy5gbeO1rD+sCcoLUPP4MAeoXtzHCY7FErhHesGPQHaM/nviB6vVwRNss9jF5rbPcJShGsOK73S6zDes4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz+VxzRjML+Bs96EoOED2VG1b7pZRXzyw2JlX7fQARg=;
 b=hqa177eNFWgNQSMnya6KM4WswuyxbFTD/CAiuhbF/YXc7EouLro11SjoMdoGNAL2SafBucWK/rnEA5IO8YOrrnFPAmXX3pYYYBmCKCqQUIfQumgzjbAiH2QvKt5PBtpT1keZvdE24p3PHdJea+029ypBY2X4KLiPrsKNrWENQoZWrWTb2NyhijiNBECyiuwxRtzWz5AsMrnsGfpNB1wT33d5XawSC1XsDMeJY4sQ+mLt4czYp6BKCQDYnGyUc3n1snt2czX8ATkylIxnZ0VsSpGNxoAc+6Nzy2x1P1OHJm8x9ulV8SDcyyWEYNy6TX1hpD1eaZeFMDeyOCzfV3BmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Query regarding image-uuid.env file permission
Thread-Topic: Query regarding image-uuid.env file permission
Thread-Index: AdnOfxFeqpE0OR81RBmbfx3scpu3wA==
Date: Mon, 14 Aug 2023 07:28:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB494549CD00E03E7B64EDAC71C217A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|OSZPR01MB9298:EE_
x-ms-office365-filtering-correlation-id: 54ee63d2-a23d-421c-6d94-08db9c980572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HnzZqQpQ4h9E6yGJhoyJ6L+TxFKw1qQk48ngSJlZ7A2XkNSeCuIb1/0FCMLHi8NsLdrp/rHe7smz6JyVavuOprrpCwkshdGRF4JLUogKjmZX3Kugw97AdjxVVsMop7iRMwVd95qh3X2mw1VyecNdzFu3acoJt/SyBPxvGns8rvntByYJG7/0lpj9fvfa8dd9QprdgfQg1oRTFkT/0+HvRbMljhUkUZdnhoqZIgTxoVv9EjD+WWDc0pSKnHr8U3v667Ul8q3mqOcfpqjdexSTNB9wkhcag0zu2RP/yIhBii1cgNWvLMaXh8Q4gyNi9V94hwpRo7orRFW+a5MOVcIDyI+7B2QxhGFGuPZ/iCwJDlwOtExEdJKygkmJ6G79XwOqEHZVQHI+FoKwOx9SDAqKcG+OoHqEU6jNw3cv/mmyYDH9jqtvoAVa2sFAmZoRoKZQGKGG4D2wicDAIieg1M91QoGmsKZ99ZvtsQzmC+fMDwSwv+8+pLyAzRwf5I6QjXlRYYqisGEoq2OeyuI40VnbuIxipsMzpqCu4JHIxCFF0yCGhpaPSQYOYiskSW1xIXzKPdlED2p1FPLhyodSmiaICBtXkZiJhwwZ3F7r7SiQPp4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(186006)(1800799006)(6506007)(966005)(478600001)(7696005)(55016003)(38070700005)(4326008)(4744005)(9326002)(8936002)(316002)(9686003)(8676002)(76116006)(54906003)(122000001)(66476007)(38100700002)(41300700001)(66446008)(64756008)(66946007)(66556008)(6916009)(26005)(86362001)(2906002)(52536014)(5660300002)(71200400001)(85182001)(83380400001)(33656002)(166002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YzZYbGJPeUtvcURYOHJuanMzNEJDY0kxV0ZWa0ZxQStBLzAwYzVyWWFH?=
 =?iso-2022-jp?B?dnZqUkRKOFZpT3IxKzV1cDhoN2RkS3BwOXU2VStqUmhTOStKVVgzK2sv?=
 =?iso-2022-jp?B?S2ZkUkRZajR5YjZ3VUtCckN5L0VZc2N4YTdPTkdUM05kb1pvMTUrOUlz?=
 =?iso-2022-jp?B?SXYxNGdIT3N6V0xuMlJ6TCt5NGd4cFhSQUNMcHBaOWkzc3hVNW45cEk0?=
 =?iso-2022-jp?B?cVN0Q3E0eG94VmllWXZ0dm1WWllTL2JlOXJ1eVR4MVdxcGd2OXRtYVRN?=
 =?iso-2022-jp?B?VjJuWVZYL1JvS0N6aGVyWEp1Yk5IMXIrY3UzOFUwUjZvWDFxa3ZKOWg2?=
 =?iso-2022-jp?B?UnBUQnVYaVZOdVJCeUFRNURpNnV0SnF0ZytQUGhHZDZnaHNpS3gzdy8z?=
 =?iso-2022-jp?B?VXpNdHZqVUp4RWFxQnFwTjBKcHB6bjhMcXBkS0tnTjZ3dFkycXRPS2lB?=
 =?iso-2022-jp?B?VjcvOWMrdXk5cEV5MkM5TlZrTWllYksvMkRMRmJudU5mT3ZhWTVaeDF3?=
 =?iso-2022-jp?B?c0lKZk8xUGlVN3l5TFppUW9JK3FqTWpFMEMvYnVQa2NNUFErdnQ2SXhU?=
 =?iso-2022-jp?B?aUx4RWx2VEFDK3IyWmh5VFhZZlZ2SE54K3NBbk5tVzJGQnpLTDNUd0tX?=
 =?iso-2022-jp?B?NDdDVWJ0ZWZ2VXoxUklGM3hNZ2gycE5qVnJPNDd2d09UQk9JTmhqSWx4?=
 =?iso-2022-jp?B?Zlc2NjZPMmIxZlc3NklCSkcyWUJhOVNtRTB1VHVNZ283MHM5N1pnZ0J6?=
 =?iso-2022-jp?B?MDJtMUN6eXhKakFMNmlkemE4RTl2c3YzclpBaDMvMTNjbFREdGVDR2xu?=
 =?iso-2022-jp?B?LzJVVFlaaURIQzhSZm84S3B5RmFGcDMzUkRtZW1hSVVoUXdRdUFGbzlQ?=
 =?iso-2022-jp?B?VjV0MkErL3N0SU1XbFNFTnkxa3pJaXArdnhSNEpDb3VaMGdiT1lQMmcr?=
 =?iso-2022-jp?B?bFRmMUJJcVFMQ3VsUmRFdWdzdW8zcXUydVV6dFBHdGNTT3FhUDlwWXJp?=
 =?iso-2022-jp?B?TDVMYkxkWkQvbkkxODhRYlVhVTRLUkdWTHZabUExNDVtK3BVOFBLdUpM?=
 =?iso-2022-jp?B?QXdOM1hrK0FTdDVwN0t5Qm1nZXlTdERmZGZJLzZucUVrVUxmNWo5QVRa?=
 =?iso-2022-jp?B?U0dMcEZQSXU0czBiSHdKTGZIMld5SEczZTBDR3Q5OEhvLzdyNE1UMGVH?=
 =?iso-2022-jp?B?Rlkwb28zNUYrQWxsbnNlS25QMHhVL2lET0ozVGhvclVwa2gyMVpLRlVH?=
 =?iso-2022-jp?B?UDY3dVU2Q3dNUUdnZDZ3MlVuZUUrbHVRYUR5VFhQUUlZc1BPU3ZPNXRk?=
 =?iso-2022-jp?B?NnNEeU1Lc3pQZ3IwN1FQWCsxazNCaU40ZTI4ZDlneVAwazJ5b2l5S0t1?=
 =?iso-2022-jp?B?dzNteDVGSCtVYVdMT25MZndnSm8wWXh6UVUrWXBLTHZIOVA4VkxuUHBY?=
 =?iso-2022-jp?B?WTZpS25oeXgwU0svR3RJNkxNT2Zra2dmUEowaG04VWtNbXFVc1FJRlJD?=
 =?iso-2022-jp?B?dnJyR3Rva1NKYjdFQm1sK0dFWlhJMExMeEFEazY2Q2pocm5kQ3MwK0hp?=
 =?iso-2022-jp?B?WVE4bXd5anF2bXM0NHFRN3NFbUlsY0R5ckZQNTlnZlJiQUdZeW1mQTRI?=
 =?iso-2022-jp?B?OXNhSU45R0RvNGlFT0NiNW45YW5rdkE0eWpuUzkrUk5NQXNNL1l0ZXo2?=
 =?iso-2022-jp?B?YWNBZmFLRkltQmp1R1JTK1J2a2FkY1pLWVZkTzJYNnJIVUlsOWhsZHVH?=
 =?iso-2022-jp?B?NlQ1NkJxQThjc1FMZzJFTDBVWGkzdTlxM3ZDVDJ0NWp5WEFJN3VQOWNm?=
 =?iso-2022-jp?B?REkraHI5bVNobUM2cjhHR1NTMTFxOUhjTFJ3VWRCaVdmTHRQN0hPelln?=
 =?iso-2022-jp?B?S2xnSkI5ckU0UVBablQ5U0k3RnFSWUVTNmNHNmxFTURBc2twWGlPdHpV?=
 =?iso-2022-jp?B?K0Mvdll0aG0xN1ZNa0RpWFVjazNvNnBpc2VRT0dQTi9TQWF1VHRMek5X?=
 =?iso-2022-jp?B?YUFUaUZ6dmdRejhpdGVPeDJkR2VOWDBUc0plVFlJdXBUZ2RQN0FveWMy?=
 =?iso-2022-jp?B?WC92eUtzemd6NkNNTlBwMXY5WTdMcm1nNTc0b2NrSFJWNVZzVU1HSFJL?=
 =?iso-2022-jp?B?MDBpdDFWUzdvTmc2YktRL2lBYlVBUEhMaEtoWVA5dmpKYS9oY1FGUWUw?=
 =?iso-2022-jp?B?N0JGdHhaRXRQdlM1WXA1aXgwN2wrUE9iOEhjSWpka1gxcnRhTE5yVE5L?=
 =?iso-2022-jp?B?WGlTRkV0WWRQdHg2NkIydlJyWEZvMVlsMDRrcWIzRk1pR2t5d0tKL3NZ?=
 =?iso-2022-jp?B?eWVUQy94Q2tndUxRTHlxV1pMT1R0VjFKM1E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSAPR01MB494549CD00E03E7B64EDAC71C217AOSAPR01MB4945jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gYZh+evq5aQFbVtNnk7yN+FeuNFXuWnv8aaJEoJ7Ost0paVbXshI77Yty5Shvu5bR1jo07Q4wV6fnA9apn7EQmVkhnFngjIE82OoH0AJFSUADc6K8Su/FcA44kHvG1ZZH9JjjjgSKO3WvmmksDhX8ou0YhvRID1kM6RJLIR0wT0C81R3TYlRgg6hfUs/hd1xjjQXT2AnWelY0CqPALzAHQj3GJ9VeFfGSVb0rSaplnKZDWSCsp8q0iroUzb6gCeYXFHPquJ7HLmNHewssp34vilTljaHgh97D78MNq3tR8igIXXuqqi+IfgEfHvtLu2K8C0iooop2yMYeY+m1Ib73pW+mCiIYsxGNMeXtnl6OquIcTH2shhbsaqVeAFEZbrOBjav8tnhNt6SkT8zfWJf8o8wdAz9/9rJ5nTXD/DkHWPSMhWyQ5KKOfu50z0zU8UQnR30AhoJUkrKWmFKcmvyH7HInIyiPxCxMGByIMSt2VW5SkJUe4xbDxqqUhTD1yI2zLICKrgLZqsLg09EnJha8iYCvfn7GCzdpExu0iimt2YYZ2cLWVwSYJbFbC3args8sM5BgXusu65wdsmp4UV/X5F2CLNgm/+F4e1mH4JKcEba4AdNP4Yb+8/mqVSYt3OL93+Ok5MsAOY+nhMEyWdCqi0EAFSphLO2m2+v/NK8kH13vSzOitTRGMj2XC8JE9KdonV2cHq4h8rDNcF20KyL84qUFsuNlCoLkZKOpCC1onqnPD7AKilecfUKFw/tujQjKh1RBHC4PSWKD4CgDMggl/91s8IRYFzyO5/Nka/EmeiffKooDfYoBepAX/u/pXNMjjfnsMeORskZzapcayjctA==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ee63d2-a23d-421c-6d94-08db9c980572
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 07:28:14.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNGrbMbY7hadWXYEcFrNW9eMni4+CoePH2omJYER3cn7tp0HgdZizz7FNmyqshlU/L3OgEH9mnf2xanVzOLJmakcz6aRIbkOEHc9vKQ6lew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9298
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 07:28:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12624

--_000_OSAPR01MB494549CD00E03E7B64EDAC71C217AOSAPR01MB4945jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Can you please tell if there is a specific reason why write permission is a=
lso given to the image-uuid.env file along with read permission in the init=
ramfs-abrootfs-hook_0.1.bb. https://gitlab.com/cip-project/cip-core/isar-ci=
p-core/-/commit/f1e559498116cd358277d147c008758b86f7fc0e#b69acba1c08d84c2ec=
fc3b8b5a60f7338876fa77.

When we verified with 400 permission code, even then the swupdate and parti=
tion switch are working fine. So is there a specific reason for giving 0600=
 permission to that file Jan ?

Thanks and regards,
Sai Ashrith ( T S I P )

--_000_OSAPR01MB494549CD00E03E7B64EDAC71C217AOSAPR01MB4945jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Jan,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please tell if there is a specific reason wh=
y write permission is also given to the
<b>image-uuid.env</b> file along with read permission in the <b>initramfs-a=
brootfs-hook_0.1.bb</b>.
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/f=
1e559498116cd358277d147c008758b86f7fc0e#b69acba1c08d84c2ecfc3b8b5a60f733887=
6fa77">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/f1e559498116=
cd358277d147c008758b86f7fc0e#b69acba1c08d84c2ecfc3b8b5a60f7338876fa77</a>.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When we verified with <b>400 </b>permission code, ev=
en then the swupdate and partition switch are working fine. So is there a s=
pecific reason for giving
<b>0600 </b>permission to that file Jan ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith ( T S I P )<o:p></o:p></p>
</div>
</body>
</html>

--_000_OSAPR01MB494549CD00E03E7B64EDAC71C217AOSAPR01MB4945jpnp_--


