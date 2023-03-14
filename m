Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B1C7618A
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 12:43:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.7569.1678797811837385388
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Mar 2023 05:43:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 32EChOsg020159; Tue, 14 Mar 2023 21:43:24 +0900
X-Iguazu-Qid: 34trpHMSkrtLFkG8Zc
X-Iguazu-QSIG: v=2; s=0; t=1678797804; q=34trpHMSkrtLFkG8Zc; m=tue9Pp3QsyN4/8X/RKjQwd57vnY0MhNbrmSvmVKckgg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 32EChNED002443
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Mar 2023 21:43:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzHVI5vPdy2ZO00b1wODKRx636U7HD4uRyzdDlgvQSXsgjJ+4QJJkXM0IC0edc4rHsQNEiSbihfbWup7DTC7KevisMIR2yP6id7oAFOpBBzC+Hh2Bt4dcfgrFcoAiYfKrA9rA+l3KAAUY2jupu/E0TKdxSoPPdG+gM88ksAfzBukK5uNX7pi/s+EIaSoB9PC/7twNZXQb+uQU1bWJiDfpOp0wm2DkceU5nK84hUehOltHtEugmt5mTAWoOvO0l+QXepFauCMNspvufyRWs4yZGt+3Oi/lw6Q5NSlCrGm2cFaANJ3LUyNxLgXhIfaTRqqszeBU2NzOP8LQoQQFFMKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hAx2XvUd4gdlqF64m6+P7nkFr2HSiTzkqmxTt1sdBM=;
 b=EbavbUO0ul3yXV8Qs2uiqwjP3C5ipBDPxsqTWdRuPrR10Ua6uj9DPb2jjJ9EzA5WJIRGw2wiWgIPHkgpuWy1/duSfrzExdCqPrDb1bOlVFwrAlUQ9rt8k+0/67PPTc1JI/3Se18HgFaqzY/71tHFdQp1ceOPutvRHZexcb7j58mOXrwNXVb55hZSbxpTPvQeFUnrnW7rDOkC0vbMpWG/KF9+4yVWrbkTJAFPge/y6dXCmqlZzlysSBuql2yVbvtgghRscP+Tr3iNrzn8Y2453Ft5Ofu//UTyl4VFYP4CujIofbJ9c4G76WIjA91/q5H9NRSdLOIDIwhVk5AGXw8HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <stefan.ss.schroeder@siemens.com>, <GeorgeY.Hsiao@moxa.com>,
        <kento.yoshida.wz@renesas.com>, <Philipp.Ahmann@de.bosch.com>,
        <sandeep.shivaraju@toshiba-tsip.com>
Subject: About CIP Security image generation
Thread-Topic: About CIP Security image generation
Thread-Index: AdlWaUPbaGgryGgHRRCdsfXTRcaqSA==
Date: Tue, 14 Mar 2023 12:43:20 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB85155EAB6B807A73E6A201A4BFBE9@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|OS3PR01MB8129:EE_
x-ms-office365-filtering-correlation-id: 8f4191f9-5b30-4a3f-ea26-08db2489b125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ar0GEd2tADL95xeQPbjuULH5AbQVjAhfqjkxeDncKJlsfFaCS2ytvBklJzC0Xaqfdhhsh9BXzR/9Wz5wf9wpstKjfEhTdWCrTHCRgmv8yNfE0CAEN8TkMAB5hrhiFlweJgv+L+vYAug4Pxc4Ka2KP6JJylkgVpF/q9CVK0R8I38SCz6xI77aMSA66gLRqG0D5h3uIrw8EmIpoOwsmF0xCVd5lNbIf2mHuCSdxF8gSuRs+29mhid8UrEgy2OEH0H2I2wkqi3wyjgI7dqwFi3lqnXO8QawfggOK+u1yIkd22MV5b+rIah1xW9792Zh1NQRz9xZFN/ISnML287mhMrg9W39XztJE6qtKONV5rNxH6NK5CVGmJM0DLeaJstRvzg0YYooMMUfs4jwQKiRQ+C6bumqgQq7WRcHlJNUz/Ug6WSd7zDKdLpYYojR8WOWo5O3AJMkjSbG+BBB8062QsPSJOSo0MykQPuZ7Yej5gt7sVEktVD/oSsBeV10m5s9c9iggwfr7qkbdfpepuiO2ZS5pl9NMOeqNJJU3wX1JEQmGsWW86VYG4l5nxVZ0uvD81+Ue2j8w+XtFsQ6tLPkpL3E6zAbChTs5G/tJpvXw1fqVSV1NN5VnG4SLu0NRoh4fITJar7EQLCoqLaAgd5Avb7nAgj94ibTfNComVPdOL+ZXhZ3PJyl3BVbJ9xiPH6ifg5P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(86362001)(166002)(38070700005)(33656002)(122000001)(8936002)(38100700002)(2906002)(41300700001)(15650500001)(52536014)(5660300002)(9326002)(55016003)(4326008)(7696005)(6506007)(26005)(9686003)(186003)(83380400001)(316002)(54906003)(8676002)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(107886003)(966005)(478600001)(71200400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b0xtaGhWT0JEeDJ3NDl2ZTZvOFkrem9ZeVgzSXdEUyswSW5DMUlJWWl2?=
 =?iso-2022-jp?B?QmZ0UnEycGZsTDRvZFZKWUViM2tlclNnbGVWZVpNTVhscUxJRWlGNTY1?=
 =?iso-2022-jp?B?TmZSVG90aEtWOGFvdFNpM21saEZBcDBpb29TdUJnVi91Wk03TlhMV0M0?=
 =?iso-2022-jp?B?MlVxdVBXcUZiaUV3MTF2eFdSaTRZY1cxemRSalRWM012OWlpQXRkY01N?=
 =?iso-2022-jp?B?V09iblZnWGN1YmJtb1dpRDRzblVsTFJaM21HejJjcUtFa1FPN2hNUkU5?=
 =?iso-2022-jp?B?ay9PRjc2MUZzNjBhdmVSam5Bb0dmRjZWQjBnMlREMUozc2pTTjgzSWZu?=
 =?iso-2022-jp?B?UHBYM1BuS0pkOXdibnA0MmxFNHpxQXV1YStYMnYzRERoZE51MnMvcktB?=
 =?iso-2022-jp?B?RVBSS3ZZeXloS29rU0NEZmVSNVRRSlNYaGJkdXN6bnRGbURBTjNHZHBZ?=
 =?iso-2022-jp?B?elY5YUNHQW1HNjlaSnJuUU9LOWgrc1VVN0w4RHNZblBKaUhlcy9TVWFq?=
 =?iso-2022-jp?B?ZXdDZStaMUhxc0R6WlFwSVlqRVRrTjBKdEx3Wjk2YkxhdGRWSWhQMi95?=
 =?iso-2022-jp?B?bHJLNWhrMnBtZkFsckNCU0Rsdy9yWVA0eGl3MHZYVEkrMTNDaGdzYkJU?=
 =?iso-2022-jp?B?bnBtTVhGN09nd2ZYeVg1bmxVejF5dTVFa1hPa3VSLzMxRkdUNkF4aHdp?=
 =?iso-2022-jp?B?R2ZQRzk1TnBoUFk1aVo5TmpSd1BXYytMTjJySVRacG1pOGg0L2lGeVFl?=
 =?iso-2022-jp?B?Tnp2Z215QzFzSzcrUEhTQlBSNG0zZytCd0Y5RXhndHhiVElMZ3NYZWUz?=
 =?iso-2022-jp?B?YUtvdnBMNXVxTy9iV0Q3a0ZqVGhVcHpyeEcwSS8wTlI4aGRJa1FtRUZY?=
 =?iso-2022-jp?B?aUR5M2lxWFFVdjlUSlBQUWFtM3J4M2JVaXBXTGNja0JWYjU1emdxeXlR?=
 =?iso-2022-jp?B?bHhyYUQ3dzRodDFEU2l1d1hiQXYxc0pnQjlNODR1NTgvdzUzVi9EYnlI?=
 =?iso-2022-jp?B?emlYRW1KUFJxNjJzY0ZxOVpaSGhsM0E1VFcrbkJPeWdkMG5DbEFRRHFT?=
 =?iso-2022-jp?B?dHRoNFJLQ3BkMTZ0YjRzY2EzeTduYzdwM0k1RG5KREtoaThoNUlmNVhK?=
 =?iso-2022-jp?B?SmxzczJqY2k2RUpJaDg1M0t0dmQrdGpoWEVGQkdmenNuUFhMTjNwQWh2?=
 =?iso-2022-jp?B?S3dkVXVoa2VNUmRxd1k4elNsSHNDSldjVnhkNThQNjJDeG9ROGZDRU9v?=
 =?iso-2022-jp?B?bXZWUkxpK21DckpCdHRKckxubHh5N0pzUUNoRVZvcENoYjNWU2szU0tY?=
 =?iso-2022-jp?B?d05FME9KU2FSaFl3cEt6MjdyeEsrcmVwNENWbC9Ea0NVeGtyelIveHNG?=
 =?iso-2022-jp?B?dFpBSWx5TG9TSEdreGNJY0JGR1VEQjgwT29tUFY1NDlIYUR3ZW0wRlQ4?=
 =?iso-2022-jp?B?dDJGdzZrbXRrTU95bGJJY0s5MDRHeExIL0hSTzc5RkcrSUtONmNMTXFx?=
 =?iso-2022-jp?B?WCtpdUFRbUMyQ0lZN0FLTU5BNVUvaklzZWR4T1FtVk56ek1MbXFnTGJC?=
 =?iso-2022-jp?B?b29ubENVTDN6RzlSNGVXWUJMWElzTE1YS2hNOENtL1BjOW8xM3FwaS8z?=
 =?iso-2022-jp?B?Zlc1SFJGSG9EZm1jMVFsOU1mcU1GVTU3RmcvQVJPUFJQZFhjQVZ3RU00?=
 =?iso-2022-jp?B?V1NWbkVuQnFMUGg2RFBIdXVEaFVKbHhtbWVXb2FMN3MyaWZLZzVqYzdi?=
 =?iso-2022-jp?B?djNnMStrUzU2NndzdFdndENEZW9HMjZaVHhwKzllV3ppUHF6RVVOd0JI?=
 =?iso-2022-jp?B?MFZoSVk1ci9vb29zMkdndkttRkNtZUkvdDQwQ01mNTBrVFBYQUFBWXFQ?=
 =?iso-2022-jp?B?K0hpaXkwSS9saFhqUDVmVDROWFBYeFYxejRaOHFCTDliUUhucmNGNHdI?=
 =?iso-2022-jp?B?eEs5SVM2emtSdUZ2NndnRzBub2NrY1N2YVptOGdnLzY0KytrcUpwa0I3?=
 =?iso-2022-jp?B?Wi9wc2ZIN1lRWnpJcmVkNTZ6a0NnNmZmc05QZGVRZGMvS2FGd3h0aDZI?=
 =?iso-2022-jp?B?Z0YvOTBiMHRUbStUQk9vZVZWcEw0R1lTODVvTmhtQWVTYmZqelhYVlc5?=
 =?iso-2022-jp?B?NWltQ0ZrNDVVM2oyalZzRVJmRGlJSTd6aVVlRTlCQk9DRkVVVHNTZGNo?=
 =?iso-2022-jp?B?U0IvNUVicHlHS2RWZ2F5aFpvQ0liK1QyRFVxTjZidXZZZlhpbzN0enRP?=
 =?iso-2022-jp?B?MWdJRDdOSEF4dE1RSlgrSnIrcTN2U0M5OFRYdGNEWEFZMDVWcEt2NXo0?=
 =?iso-2022-jp?B?RGtvU0NWc3pEUmNKTU40TXpKTm1hSlVOMEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB85155EAB6B807A73E6A201A4BFBE9OSZPR01MB8515jpnp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4191f9-5b30-4a3f-ea26-08db2489b125
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 12:43:20.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whfzjzHpb1wFy8ASovUhDn/BaQQF8PXCxpQ0XPqTPFrHLDXRgZGNHZnWqX0UPwLDdMFMtAyPRNN0wBZ4bodTuuwDhxIkCl9TdU89JUwOwSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8129
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 12:43:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11025

--_000_OSZPR01MB85155EAB6B807A73E6A201A4BFBE9OSZPR01MB8515jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello All,

We would like to know if anyone has any preference or specific opinions abo=
ut how CIP Security images should be generated from isar-cip-core meta data=
 [1].
In current configuration, by default no security packages are added for IEC=
-62443 compliance, user needs to explicitly select cip-core-image-security =
or through KAS menu security image option to generate CIP IEC security imag=
e.

From IEC-62443 perspective it does not matter how security image is created=
, it=1B$B!G=1B(Bs up to CIP members to decide.

If we want to use current approach then in my understanding we have to test=
 two images in future (one default image and another Security image).
The options which we have are. (Feel free to add)

Option-1: Continue to use existing recipes/meta data and generate security =
image on need basis (Already supported)

     Pros: 1. Only those users who need security enabled can generate CIP s=
ecurity image
               2. Default image remains minimal and smaller footprint
     Cons: CIP Testing WG needs to separately test each image.

Option-2: By default include all security packages & security customization=
s (Currently not supported, needs recipe refactoring)
     Cons: 1. Users who don=1B$B!G=1B(Bt need security packages have no cho=
ice to exclude security packages
                2. Larger image size
     Pros:  CIP Testing WG can test only one image

Option-3: Create a small debian package which will include all security pac=
kages & security customizations (Currently not supported, needs further inv=
estigation etc)
    Pros: At run time security packages & customizations can be enabled or =
disabled.
    Cons: May need lots of extra effort for development and maintenance

Any other options???

Please share your opinion or suggestions which option is preferable by 24th=
 Mar.

Note:  1. As CIP Core WG is planning to make release of isar-cip-core meta =
data very soon, we need to finalize the approach.
             2. In case of no suggestions/inputs, current approach to creat=
e security image will be followed in future and accordingly CIP Core WG wou=
ld proceed to make isar-cip-core meta-data releases.


@Chris, if you want to add any other perspective from testing point of view=
, please feel free :)

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/master

Thanks & Regards,
Dinesh Kumar

--_000_OSZPR01MB85155EAB6B807A73E6A201A4BFBE9OSZPR01MB8515jpnp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
code
	{mso-style-priority:99;
	font-family:"Courier New";}
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
<p class=3D"MsoNormal">Hello All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We would like to know if anyone has any preference o=
r specific opinions about how CIP Security images should be generated from =
isar-cip-core meta data [1].<o:p></o:p></p>
<p class=3D"MsoNormal">In current configuration, by default no security pac=
kages are added for IEC-62443 compliance, user needs to explicitly select
<code><span style=3D"font-size:10.0pt">cip-core-image-security </span></cod=
e>or through KAS menu security image option to generate CIP IEC security im=
age.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From IEC-62443 perspective it does not matter how se=
curity image is created, it=1B$B!G=1B(Bs up to CIP members to decide.<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If we want to use current approach then in my unders=
tanding we have to test two images in future (one default image and another=
 Security image).<o:p></o:p></p>
<p class=3D"MsoNormal">The options which we have are. (Feel free to add)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option-1: Continue to use existing recipes/meta data=
 and generate security image on need basis (Already supported)<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Pros: 1. Only those users w=
ho need security enabled can generate CIP security image<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Default image remains minimal and small=
er footprint<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Cons: CIP Testing WG needs =
to separately test each image.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option-2: By default include all security packages &=
amp; security customizations (Currently not supported, needs recipe refacto=
ring)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Cons: 1. Users who don=1B$B=
!G=1B(Bt need security packages have no choice to exclude security packages=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Larger image size<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Pros:&nbsp; CIP Testing WG =
can test only one image<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option-3: Create a small debian package which will i=
nclude all security packages &amp; security customizations (Currently not s=
upported, needs further investigation etc)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Pros: At run time security packag=
es &amp; customizations can be enabled or disabled.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Cons: May need lots of extra effo=
rt for development and maintenance<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any other options???<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please share your opinion or suggestions which optio=
n is preferable by 24<sup>th</sup> Mar.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Note: &nbsp;1. As CIP Core WG is planning to make re=
lease of isar-cip-core meta data very soon, we need to finalize the approac=
h.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 2. In case of no suggestions/inputs, current approach =
to create security image will be followed in future and accordingly CIP Cor=
e WG would proceed to make isar-cip-core meta-data releases.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@Chris, if you want to add any other perspective fro=
m testing point of view, please feel free
<span style=3D"font-family:Wingdings">J</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/tree/master">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/master</a><o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Dinesh Kumar<o:p></o:p></p>
</div>
</body>
</html>

--_000_OSZPR01MB85155EAB6B807A73E6A201A4BFBE9OSZPR01MB8515jpnp_--


