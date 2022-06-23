Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F5C433EF
	for <webhook@archiver.kernel.org>; Thu, 23 Jun 2022 18:15:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.426.1656008153512247751
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jun 2022 11:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 25NIFp4r018928;
 Fri, 24 Jun 2022 03:15:51 +0900
X-Iguazu-Qid: 34tKTpc1JgXbv8xaPQ
X-Iguazu-QSIG: v=2; s=0; t=1656008150; q=34tKTpc1JgXbv8xaPQ;
 m=PiL01/Mt0frPoMlh7jE4KKkqWidskK3OXhWUqzOykSk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 25NIFnQ8016161
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Jun 2022 03:15:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSsFC8yJzp4teDRAj1OdrFlso2woAYuMs8qpAkJZrAzcVe/CaKRu0VqhtrRQY0GsARUzV1sb+O/QlJfZdrCxztqaK7c9t72W9gwuZiYdPe9TayNSd/MXEC+bWfGW+ziXyqe/uHeO7PGMMMgMXCUU35iOIXLCWkc4/InAp9oTeCMk5CkXzjCCnrkN+ytPNo/s2QE+ztP2FfMqX3szHzf17sBI6KzTvH6hVfRK1E3NPOhMUV4x2LGCQSNO6RcHBn17tfeXJYhHK0qiMCN0Z7vfp1maTPuHTFJ5RaD0eBBbYaAYlsiFrqcW5poXBMgr3J5PhMVx9viK/U5XOAXD9Zlyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkhUBBMTiDObUdm8YGcc3CWidiKfllhbk/wxEh+uVTE=;
 b=M9Dsb07Z6jnZBszawbAO65uaYQhS77eyPFgFmCmRIPO7vWb+wGFJzrnKePnBFb33pZMnOobrXFh8EZpMLcSyO7a8B6AF8lP4dzG8UkPsZ+MtQCMw+XOinf+uwFBnHnmWeubvWJT65HqSKsnrsrMqiPSRNWg4Zjp8vgXD+mBNDJVn3YXTjUPIDdxSBxMNqf3gHTg84U0r7roj2wsCFESSQ2mZ2ElLbRXT7sUcCGDfZLaiaLj9eXc3mYtYbKXrMtR972TnB2OSDe/gPZXTFW0bxZBCbOBtgpEGkg7whTNUA9uPa8sUeC4AB8NqNiqV0hu8NqZOwS+JCQFQZR7Qg6VrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
Subject: How to increase the size of the rootfs in the isar-cip-core image
Thread-Topic: How to increase the size of the rootfs in the isar-cip-core
 image
Thread-Index: AdiHLEE60rWXvhuPQIiktp+GultvCg==
Date: Thu, 23 Jun 2022 18:15:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542D88313015EC03720450DA4B59@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea8b59f-525d-464b-2036-08da55446540
x-ms-traffictypediagnostic: TYAPR01MB5183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jx8EarkOH54mbyxPJMC+FXZadqJg7CTYMSaaUF0hY2EtcsB0uPhbQyo1eOPOSq1SzjssSK+F9kR+C2DZi4M1V5zTbp1LWgQSMsgptEZDD41GoBnq/zzpkbnlsvwghpuTN8PRQ0a9veWSFYuv3OVz+a314Y7/i2D8C3Y4vxN/ybl0cPditOIcjZ2NVJCDlUIq1hIFLPegi9P4WRW7SeGOfFfNLggsFK3AED3nBUFC9NFI0lu/iRPgRZHpHlKVm/aut+nY5YaAlPREInKuSWmwPdueD72sRuSQvLPzS+snOzvMRGURAHODeGSpoMb8wwmkaiMcY9tYdidVu5f1viCftoWeCHKtEMfk0KwiO3T2pwgPVG9ziuVg4L0od/tywnQ596eXwSAF/c/SzUvEUfaIqfoVExQmvebZSSqGoum7xVTWNQpf3G3pzmDB4gGEl0+yy8+yrmy2Ld1atly+JfmKtLQS0G0GEODWAvZiArFuoLKlYnmKoBgJtRELqM0bF4FbCbrCaoNiHyrGSKZI3dgw6XGgnKT1ZFrNgWbEPNCJBPezfA6DFiPN2EVcKk2dJSaXY/OT3Kop6dWE9pIU8c9lh4IV4hDK0ZOVEOvJAhGPgFmmBGqqHn+Q1i45TrFtzPQgwxMxQVL0WeahE8lW/JniSjOznmA31dS5B75hoSsVfGIyfjS6U0+DWyzaGhu1eeV28/f7WNkPdfbuXsYtx2GDahbGfo4XQb5rNloLHGAJD3/dS8hfqqdxTLfm+vnU1iWiPBaupE/g4QEJ9/iMTjpVY/KvIvx1SLhY50i8xaia1xs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(55016003)(2906002)(33656002)(186003)(4744005)(9326002)(52536014)(8936002)(64756008)(122000001)(41300700001)(5660300002)(38070700005)(6506007)(478600001)(71200400001)(86362001)(76116006)(66446008)(66476007)(66556008)(66946007)(38100700002)(8676002)(6916009)(9686003)(26005)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ejhqSXhrRjg0RGFwdGxlSzlMNkt6VVRLakpvcUpkMGFIWWpPTWM2cXFY?=
 =?iso-2022-jp?B?THdDY3Q2M3pGL3dvTitUa0s1WFpKRFRiMkZtMG5Qd3JOQW5TSkRuUC92?=
 =?iso-2022-jp?B?SXlabzg1MG82ZTZ5ZFU3MWMvbkQrcXlOU3NPcDlvMnhkZWZXMklYU0tV?=
 =?iso-2022-jp?B?Yml5NGFPS3RxaXRic2FSSU50dTZyeGIzM3RKT1ZNa1lxcDlRTnNPNVVi?=
 =?iso-2022-jp?B?anBLZ2k1VE1uSzJFUVBGb1pSNG1SZDI0a0VQMnVwUDJTMlZZQzgzNFpL?=
 =?iso-2022-jp?B?QXRTNVZoVUdVVWh4VERiaU1UOXVJL3Vsc3RUdWZaUVJhMXlzdmJJNG1T?=
 =?iso-2022-jp?B?dUxMRU1uOVlnSmtpcHFjRjVTcTNDQXQ5WHN1SXZzZnRsRGlsVmJWZzlj?=
 =?iso-2022-jp?B?NzRXVzJUYVpCcFA0Vys4QnovbHlhbDRpQmhwOHlwOXUzSks4MVBZWG9G?=
 =?iso-2022-jp?B?cE5tZ0JaVnk1R2VrQ3VpbW91K0NFSjVxTFdUVk9VRUtJbHMxNVlkVjhO?=
 =?iso-2022-jp?B?Y0ovVUwyTkZ1bTZoZTIrc1BWYmo3OWQrNGdVeElqNGdFL0QwdmRWckFk?=
 =?iso-2022-jp?B?cCttQlhYQ1N3QmdhMmJIOStCSUlDZ2RvUlBmNmhhSFF5bWdETHB4Z1U4?=
 =?iso-2022-jp?B?OXRIUDZiSFcxekdubE9uZHo3a3UxSGFrNHVFNG9JTUFTT2c2cmNneTUw?=
 =?iso-2022-jp?B?R0JnWnY5SmFIQXZUcC9UbXMrYWdDVzkvZjdsdE94YTBwTXBwSnZYb1Jn?=
 =?iso-2022-jp?B?QWhlQ1dtSlJVaFNkZzdRVkl5dzIvZlFGQ1BiWks5OGpuSlJzZEtHZDJF?=
 =?iso-2022-jp?B?YisrTjNpSXErYU0rRGo3YnVXTTlrSFYyUXYwUjNJaXE5Vmh3UWdlc0dE?=
 =?iso-2022-jp?B?Vm52bzNkTHNUL1g1UXFMVGJJQUlSNFlEeGd0M1BuV1crSFFqVTlCM3Z1?=
 =?iso-2022-jp?B?WFdvS3M1MTV2dFRvQnRZMmxlU3RwTXFDVVhOY3V3OE9HSE0xQlZYS3gx?=
 =?iso-2022-jp?B?TUFJRDFQeW9iQ0g1d1Rncy9kL0dOMG9NbEtvaDFDaHJHUkt1dE5FWnlC?=
 =?iso-2022-jp?B?ZXNaQ3ErcGoyNUpzQm95M08yZFhhRVArRzlTVGFxc0lmN0x5SjRPeUpj?=
 =?iso-2022-jp?B?cVBwdGJFbXNJY3dVR1NzMlNWdXpvTWdiOE9JcFpicm9Xb2JPeFR2c09K?=
 =?iso-2022-jp?B?SG1xbHJmR1ZhSTl4MUdRdkM5Tml4VHNHMnVzN1dxd0NQV2NkV3NDZ2Fh?=
 =?iso-2022-jp?B?OWI4czFHQkdHTGZ4U2wwaW1nSklsN0E2eVBqYzFUVmFCSEZTRjY5UmtN?=
 =?iso-2022-jp?B?L3dpUjJxK1U2K3NnRC9QRVR0YXVFTVRXNVJNV1VTZTBLVTRNdmowb0V0?=
 =?iso-2022-jp?B?UGNHenF1OHRTWERjRGJuVjd1ME8yWXM3cTRoc0hpSVZTUG00Y21zaUFk?=
 =?iso-2022-jp?B?elhSZTgwQVQ5ZFJFWllreXU1U1hWaElJLzdnaFBxKzhKTVVNSVc4TytY?=
 =?iso-2022-jp?B?TFpQWERWTW9wamtPSU8ycUpwYkVzTWhrRXdOb2lQSVZza01JSGNHWWRH?=
 =?iso-2022-jp?B?RHUxS2hpc0ZmcXd1NTlRUTgyRkZzNEdBN3dtY2FRc0dueGUwYjR6d0lF?=
 =?iso-2022-jp?B?S3RLSHFSV2k5bThZM1l0RElhMVBWSWZ6Y2wxQ2h6dDczRUF2K1YzTWpK?=
 =?iso-2022-jp?B?NFJQMEJvb25tMHFOeFo3eG90SDBpMnZqWWVuU0R5akxtdkM4UzZ3eEJo?=
 =?iso-2022-jp?B?U21heGMyYXFmTklYMjU5K1BJZG1hYWZSdkUySDRCZzVxMForTUdMemJY?=
 =?iso-2022-jp?B?Ujd1a1NVeUpFOElSWjJpVUhiRTAxNGpPUWtMZDFIdG04Nm1PaUJCV3VF?=
 =?iso-2022-jp?B?ZUpxdTFzQzNpMHRMSkNyK2YzTjI0aHFqdC9aUG9NMnF4M2VyNFBYZUJm?=
 =?iso-2022-jp?B?bVlOR0NhWWpCZW9yOUlsNkpac1g4R21mNVo5QjgrU2tidE9jblk3Y3E3?=
 =?iso-2022-jp?B?QTNBOStEbWowUFhKRmpZK0RNWXBGUzVJZWNCQ2g3TStraVRkVVBucTN5?=
 =?iso-2022-jp?B?UWFLKzNoaVoyR0FyajU0dW0zMnFsclUwVXBUb0lCalBvOWZKSm96Wng5?=
 =?iso-2022-jp?B?amdmYVJCV01JeWNsWDAyRmUvNVZCT2tpZnZWNFpiVCtIT3pHdTZIaDF4?=
 =?iso-2022-jp?B?UmVRN0VQbS9MWG82OWFpM3M4cmI2eENSc0I4ZGFIQ2V4Tzl0OG9zUDd6?=
 =?iso-2022-jp?B?ekZGYjJJa2xYRUFNN0xZakZ3NzhmZG1VUjlldWdYSjBSUVdaRFFkWWhM?=
 =?iso-2022-jp?B?eFB3NloxbXlYd1pCNnkxcFh4VmkwQnpIT1NGV1JhTnpLMTNEbCtTWUNQ?=
 =?iso-2022-jp?B?UkdweUMxZzVhVGVXelhncndpZ0Q1VFF0QUQxVk13R0c3U1hDZXF5OW5V?=
 =?iso-2022-jp?B?aWxkcUs0bG1ndkZoblNycmtZaFg5alYyTlBvRE54Qi9sU1FCeXBnWjcy?=
 =?iso-2022-jp?B?NVRYcktrNnZGSHhBV0lXRXVjOUFmQnlvSjJLaXBOWDlKMGE3bFVMU1pv?=
 =?iso-2022-jp?B?OEFFOC9pcz0=?=
Content-Type: multipart/alternative;
	boundary="_000_OSYPR01MB5542D88313015EC03720450DA4B59OSYPR01MB5542jpnp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dea8b59f-525d-464b-2036-08da55446540
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 18:15:47.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 UlMM+Ty/7yC2aRj5xvgRCaCuxlYhkqgKy0idNEe1pJ2WFk9a+MbUzs7lmzi5+XWdTvApY7/asbZymxZjtUmY+7MRKLVKrUuUoyDGa+V2/7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5183
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jun 2022 18:15:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8587

--_000_OSYPR01MB5542D88313015EC03720450DA4B59OSYPR01MB5542jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

For my experiment, I am trying to increase the rootfs size in isar-cip-core=
 image, but I am unable to do.

I have tried the below variables but no luck:

+local_conf_header:
+    rootfs-image: |
+        IMAGE_ROOTFS_SIZE =3D "8392704"
+        IMAGE_OVERHEAD_FACTOR =3D "1.0"

and also below variable is not helpful.
+        IMAGE_ROOTFS_EXTRA_SPACE =3D "8392704"

Could anyone guide me how to do this.

Thanks for your help.

Venkata.

--_000_OSYPR01MB5542D88313015EC03720450DA4B59OSYPR01MB5542jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For my experiment, I am trying to increase the rootf=
s size in isar-cip-core image, but I am unable to do.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have tried the below variables but no luck:<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+local_conf_header:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; rootfs-image: |<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_RO=
OTFS_SIZE =3D &quot;8392704&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMAGE_OV=
ERHEAD_FACTOR =3D &quot;1.0&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">and also below variable is not helpful.<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;IMAGE_RO=
OTFS_EXTRA_SPACE =3D &quot;8392704&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could anyone guide me how to do this. <o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for your help.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Venkata.<o:p></o:p></p>
</div>
</body>
</html>

--_000_OSYPR01MB5542D88313015EC03720450DA4B59OSYPR01MB5542jpnp_--


