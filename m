Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A45C5320E
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 07:34:39 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.61])
 by mx.groups.io with SMTP id smtpd.web10.13179.1724139269460620259
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Aug 2024 00:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JhuZX2vV;
 spf=pass (domain: renesas.com, ip: 52.101.229.61, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0H2GRKAGHc+rohfnWIhRrc7FYsW/6oRynr7RqqwVPc5Hk7k1E867FrMjeT13jKaGUAsaHbMY3gre9kfAQKxTEZnbhpWwWurqN0NRfnmxgbYmzLVLLMNazzlsgcL6HTAK1wNZ8wYdtqpU15rEYBP5npCkvypbmrx9/GXHHY0Tmy9GfyO2Y9bZs06vN1kqLoYYNFPBr+5OGhZOfvCEHCxn4VDdOj6xDI8ms1QzLybRdtq4LnEDf2QkbECCFabloOndgcpqoWNfvD/y8uvzjqKG8TNu5ZB7h/iQDq2ro4aWjn1A590HSQGH+xxUrpg8L8nNSuMNgENR/tEn0C2syS+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVpDKmsr/938zf5HowfcD3JemH7VJ5NNNm9rewy0mlo=;
 b=EMuDnHU5LuKJrkoxE5UltUXR6+45t0Ed5mKtyiHHFiQeL4rkTvDg8a7eWUS8AN4s5Dqat3n2oIBkLCXkOVRyFOHne1+bTCEfNNTu1VTjcoFK31Ggg/KTSSJVKp1VilOwJATfcr/IgIrhwheq00JB3XKF6XG8W/AGt84/a+pd1Kl3rYDTAieuu3gJKCCX/dDeNpGV2bjQZwkh+Lq78CCb6qEGAX3BksoNXKhjVBZERdm0hFuf4QRg37xJb82AR4omjt/r/etR+seIy3VyhDeNZGZ5MZUB+2i6OHBL6ePo9XLufcNEUjkD8lLudurGea/eqTZNkmzqw3CSu2PSMKeFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVpDKmsr/938zf5HowfcD3JemH7VJ5NNNm9rewy0mlo=;
 b=JhuZX2vVijFbEnhG+mD9Tbw9t11a1MnBMA5qTyjGZzhkeAJPmZvuFVuHc69wgHLN/eXqRyfF9NZvOxA+xeVefATYpldoLoN48SFWEUm+OIiiYps2CV95Mwh5YnumPdRyl1WpehqhOVBnUNDf5unKJAZah8LXvPbs3pArENO+QbA=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TYRPR01MB12221.jpnprd01.prod.outlook.com (2603:1096:405:ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:34:25 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:34:23 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Request for review
Thread-Topic: Request for review
Thread-Index: AdrwqfOJexZyUCBeTkaCBtxP0Npn+wCKV6Nw
Date: Tue, 20 Aug 2024 07:34:23 +0000
Message-ID: 
 <TYYPR01MB12402C28814E543F207F25FFEB78D2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FF8F52601E0BF4BE297DC2822@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103FF8F52601E0BF4BE297DC2822@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TYRPR01MB12221:EE_
x-ms-office365-filtering-correlation-id: a33144c3-ecd3-4791-5712-08dcc0ea8338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?UzIRgwOhLyzm04t1HeumoyqhOr5P1fkUFeaV9TtZyNhtxN4G3y58yeLG?=
 =?Windows-1252?Q?D9EtiZmmXOn1FjIpAovROF0tLaWrW10vKUF3kNd0aVzVJGU3XeMycI6F?=
 =?Windows-1252?Q?wRKyqslBQiQOoNsPkdaZIk4xjl09o5HmLjWsGFvnuU49TCJc4Bw4XQ/v?=
 =?Windows-1252?Q?YkY4lGCsv4RALkVPIRng2w5dM9HASd2EJPvcEhYL6cTx46/sRuca6gy8?=
 =?Windows-1252?Q?TYZNPr/H7xI7dJFNuEbMgtC9h1La6blZzrXq5FOHwKtFFNUKxLkhz0Ra?=
 =?Windows-1252?Q?/hBDGStlvvmLvCjrn6fVXTE+VwC5IP4Ea772oSI6t7SdK6g1NSxbmFcH?=
 =?Windows-1252?Q?uezKdLK3vqNSQPN4ZOvOi0yG+rXhdPFXdfDMb/JzPWK1HH+siEFABaem?=
 =?Windows-1252?Q?8UPxrYgrOFn5K1fPhAX2g0sjgjCUYWPrtRfXCMcMHLp8bhdO6oEpD4GW?=
 =?Windows-1252?Q?9gRAOjPI6FQBb6N+l3dIm37XgmB/UohXU/my33RGhnTF8Mf2yD6492GP?=
 =?Windows-1252?Q?zFvWofWdqS7NueT3UieK4P51sBuNREtDlwMETB1Do+sEYCyVHbrvmhEK?=
 =?Windows-1252?Q?pKq7vcRgMXE3uunp20XbD0BmDTfmFyYp0/CCzKMFDVy9XbyeEMijNH9A?=
 =?Windows-1252?Q?A014d64urwv3j3RPCvo9NecfWCb5A6QGWQWN3JYiZyFj1KePmWCAgPjQ?=
 =?Windows-1252?Q?utbpmPxP+FHcCCMPJgj2LCa730WZLHTS7DXizLzJDuntkrXwb3y+avl0?=
 =?Windows-1252?Q?kuAm31nU/NF3nh1RCUokYUzNXffyaSsxCKUpcvKIJKe3m1Zukl+RHaFS?=
 =?Windows-1252?Q?RBLuCN2FUzWPLTpOMizF7LSxANSCz7q+FJeUwDQ4aD5o22ZnoE8Kuy+e?=
 =?Windows-1252?Q?reMzUuYeqDO4AeZh+zxJ32Od1Q7UW5OC5Z0qsuQxkVi47zfOzC0i/w0Q?=
 =?Windows-1252?Q?1fVGGucq4conr0/Wren8k3BtixN36bGR3+si7ScrX9WRKLRQmv2HN4Zq?=
 =?Windows-1252?Q?q5N2+IzX6Ycvpr+Wz5MXiBNIDNzemhsdPKnB7HY4RMX+L/74L1pmK5Qz?=
 =?Windows-1252?Q?qutKq3PHnauEWn45dnoNTCxm2gsju8op2XqJ5X3UfHEkC++mGBx2XzDH?=
 =?Windows-1252?Q?fp23xpgBa5MYsHc2Nj6KoorUdYy+JDAuqfYdTdp757feCILnqbYAa1Y2?=
 =?Windows-1252?Q?+OvDscNfi7bLb5M/dI1nBocpIxEnuDxoGlOh4oLKWj+tphlOS5XmS5OW?=
 =?Windows-1252?Q?bSWyfeXWtTU68MBLWv+/zOy48YlbjkFtzaZlctUa+YFudgnM7PBTbon8?=
 =?Windows-1252?Q?1enWAd01nuDKCY06+E1o9GAic9pMZ1oCqPYwhwr/R/kNHKX4nydwcO7y?=
 =?Windows-1252?Q?IkWoZtyLDfyK53aAs+am6GpMm5EpcWE9cmwQkrh92ilWYLfIVhqbzR7C?=
 =?Windows-1252?Q?+8ta0WSTD3C07fVKn54QPwRRcoBrWVPieuAg1tXhV/J90tAB+ucjWfoB?=
 =?Windows-1252?Q?8ghqAspWh8PZ+rs5cj8+xFTzDZ1aCw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?52SetqczkUIIJXt2kA/Cc+tUdQDyGufhtiXsYQYVlNKaAWqqh1CGU1i3?=
 =?Windows-1252?Q?tJs6MCxb/VLDnfciIJNnXbV9HeLqulIwbfNcMBVUUcrawnzNoJUu40yF?=
 =?Windows-1252?Q?+XH6iDytre7YMP5L3LfLbRPHd9qkQSZg59VEwZiZvtDvbO6rkOOMyghF?=
 =?Windows-1252?Q?W87dnXoL93YEG0UhIAySp+jeF6mlJFZFaa/WOcTy+F71xG//Trs4GvRX?=
 =?Windows-1252?Q?z6VODgQiCnGMQa1+lx8LHzgRZQ3h6weZLQ/3CUuhOlynIdZ+OjFa+qAh?=
 =?Windows-1252?Q?miblwPi4fvwjNBgewqodZq6uu8x0cAI7YeYjKH8TiEFkrQqJlJU52k5/?=
 =?Windows-1252?Q?ie4oh5iIRb1ICgqiStLbVU/cZiHxXACz0es16QbWUsQEvyy6U+LJZEiR?=
 =?Windows-1252?Q?uiNLXlQa7Swfaiz4kTwUt/BCKcF5btkkjfNfWEURW63Yzu7xSc4tEKAs?=
 =?Windows-1252?Q?WNc1X1V3b3pi8D3Y42dOuzW1Svsk7pEeQf9W948mV4kR2ozNdvGdxAov?=
 =?Windows-1252?Q?WCanbl+7y45TXom9E/3nxrPiTEbb0ClNj/QIp/zQ8erEf4cvc/N3PeEs?=
 =?Windows-1252?Q?mWuQjTshRpplv/Dtn6RAoZ/mI/W6Mq3SaYXX+pdju93wekTO3tWb71Zt?=
 =?Windows-1252?Q?gsPncgfgAuSmmMZsfz6YoGUVjGW/n0sN4DpPVDOeKTuXEkJazNLEjGf9?=
 =?Windows-1252?Q?SYN7vG91Hq4TIkj/lQA7ERYgbClNq07qKAf7LPPdb1tubIcwJ7oX3+d8?=
 =?Windows-1252?Q?RFOWQJPGVvXEAD/MXJb/StArTRC9gpmBFasRvweSyu67lbPB6d8w0awj?=
 =?Windows-1252?Q?9/6uqzWpgAf4Ik0OuQBw3gwfE8h4icKb7Dl0pZwoRktkL78eHWZ6nKYj?=
 =?Windows-1252?Q?6N1qu92citvv+BGJUdAdnQz3mpkzVFEjP6vjncFSNPi2pKlk0jBCniuL?=
 =?Windows-1252?Q?kBSoorq+eFCFgCF2SmhNHL0koF0AZ1638Lg9d7IsUvoFrEvEUhw45dO/?=
 =?Windows-1252?Q?K/KAAJ2Y53A2jYGeVpXD2rvV6vKgzYqT66HsV4ABReiFeZ08moO17RZE?=
 =?Windows-1252?Q?LDDkqpg8H7ZVcGpj/aXlwP15hbikrOKvjUNiMy+1Zc7yNLuTtafH+0NV?=
 =?Windows-1252?Q?yi9D4TqgBvRJtxsZsQf/9zSxfGAJp9BG4bLl8HgxAj/qp/cnH9ffBS4w?=
 =?Windows-1252?Q?0gv3250ZvGFNdK0/eLn6UscS2FoCFNoDDH70HCObyiiHcCcEomRYIhi5?=
 =?Windows-1252?Q?MyfwCpQe9PmiqoQSoMGBXd0Y5r0/FLzYcSYzVYLZJQ39Wc46uHi21enz?=
 =?Windows-1252?Q?3xfejZiSIYKyXIcwneuGZ2NyYNQ83yuxDG/+CcFpfwftn+lsfdpNz4U4?=
 =?Windows-1252?Q?mBujg55hD1NKtjCXXX5ckM+GyYv6/6Tsqs4MRJ3m5QAanWDZ2GskkjF2?=
 =?Windows-1252?Q?uaPkIynVvHM3pKl6JxfaJcwKCvVvQgHW1Rj1l/H16PbtUsTxyqt2svb+?=
 =?Windows-1252?Q?wvRZZrcsLisMLWKwY1UvL8lTFtL7EykX3bGWYn9710mMzKQelATe8VZI?=
 =?Windows-1252?Q?Ydh9HgvaQQh9Zk5AwBf0M6m58VjciZl8wTWtxhK2DkFQB0aqpVGN5yXN?=
 =?Windows-1252?Q?o1RJtxaEf6B7pJ5KfXu2hwFlFGM2jzydr9v5Rypyu/iQAZMEXJIXDq0Q?=
 =?Windows-1252?Q?JbU8gKmbFYQFgqqai8upZd97X0pXDi9bbFMK9Hravn1OalWB4KsApQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB12402C28814E543F207F25FFEB78D2TYYPR01MB12402jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33144c3-ecd3-4791-5712-08dcc0ea8338
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:34:23.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXJNdXYysiwggiBduBmWe7JGNWkzDW1LJ+6RQUJgOHREhjfaiW7CKdyeU9+ihP4SFlP3q/8sRvmGMj+wOttlNhz/A6KmbSk3GDpNwaj1z28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12221
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Aug 2024 07:34:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16806

--_000_TYYPR01MB12402C28814E543F207F25FFEB78D2TYYPR01MB12402jp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Sai,

Apologies for the delay I=92ve been away.
I=92ve taken a look and added a comment.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Saturday, August 17, 2024 2:35 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; cip-dev=
@lists.cip-project.org
Subject: Request for review

Hello Chris,

Hope you are doing well.

I request you to review this MR Generate IEC layer test reports from SQUAD =
(!4) =B7 Merge requests =B7 cip-playground / SQUAD Hacking / cip-release-re=
ports =B7 GitLab<https://gitlab.com/cip-playground/squad-hacking/cip-releas=
e-reports/-/merge_requests/4> and kindly provide your feedback.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_TYYPR01MB12402C28814E543F207F25FFEB78D2TYYPR01MB12402jp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">Apologies for the delay I=92ve been away.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US">I=92ve taken a look and added a comment.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:#7030A0;mso-ligatures:none">Kind regards, Chris<o:p></o:p></span>=
</p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-fareast-language:EN=
-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none"=
>From:</span></b><span lang=3D"EN-US" style=3D"mso-ligatures:none"> Sai.Sat=
hujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Saturday, August 17, 2024 2:35 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Request for review<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello Chris,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I request you to review this MR=
 <a href=3D"https://gitlab.com/cip-playground/squad-hacking/cip-release-rep=
orts/-/merge_requests/4">
Generate IEC layer test reports from SQUAD (!4) =B7 Merge requests =B7 cip-=
playground / SQUAD Hacking / cip-release-reports =B7 GitLab</a> and kindly =
provide your feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda (T S I P)=
<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB12402C28814E543F207F25FFEB78D2TYYPR01MB12402jp_--

