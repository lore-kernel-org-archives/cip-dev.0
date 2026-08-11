Return-Path: <samarth.atreya.k63@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01872C5AD7B
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 05:46:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48088.1786427187867680607
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 22:46:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=samarth.atreya.k63@mail.toshiba header.s=key2.smx header.b=KIFbYoAr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: samarth.atreya.k63@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	samarth.atreya.k63@mail.toshiba;s=key2.smx;t=1786427162;x=1787636762;bh=NHw7i
	3Hpv+O1kNC0DeeTU3MGuSLSosRZOPRfuXjJ4oY=;b=KIFbYoAri4rsGCCgwwd/N8VTAKYKCIQcjQX
	P8qYV0j8tXMKhJMUQnFEHCJ+1bO4nlDGhhOnkn1G/+idXAbkIOwej5Zsk1QslKIJQHlS8T9rQ39pd
	0xX3iKtO8ovVAHVgRNF278JiC9SYGQGNzW1HthEW+AB2iN3q28M0adIxifFKdH6gw7L+gNAoqVGCM
	ydnCkjwT+rWMzeUDGyOyoj8Zdpzo/3xsfmY6XmBFDCNlyHgYoa69VTI+lbsACnEDtTUsr6r7RL4zY
	gmIHnu0fwdObNGUsAgMA8sDSdLgPCyHmdLzehqFtEeXPw0cwMutwU+k4KNDYg5z6gdPzg8LXVYaA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 67B5k2Uq1502950; Tue, 11 Aug 2026 14:46:02 +0900
X-Iguazu-Qid: 2yAbeCtgwZSV4T7qoy
X-Iguazu-QSIG: v=2; s=1; t=1786427162; q=2yAbeCtgwZSV4T7qoy; m=Si66zuhZGnKE47GckiV3FNjCh82RjWVA7EBveEMbMas=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hK0wT4RjqzyPQ; Tue, 11 Aug 2026 14:46:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb7t2CUWrnQcUvVeqFk0JUubtodXf79c7iC1Je7XAvq2Wv6N9njSFpW0kPLU47fhlPW2Gu77ep3De1y+czFNsXJ7iD+WqnfYCumcuc336J2xTWl8SKtJWFoiINqI5Rub4ahrJiokgT4ujo2VLowLtC2V96xNahkG87RjZ1HVPfBM2oRMWeUIVSORr6EuMmaBwGLhgPmn4KElO4xae7NgPznHhG/WL0GCIQBXIu0+s6Veayf9pSiW5NK+Oq4USejcQTQMUfLnzYmbmMAOZsrH5hjfFe6XK/3lr2W1pPlL/8iEbzyxGDL+QQeQ5IsmPUpHlP4hwMeiW2MNe1eNtuqKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1rwpYD3I61nsMOxfQuAXqWMZJgwi2BFSjVgzOgyROU=;
 b=cUEyuD1RJdR33EhrRMz6vNJfKLtjxCqzH9X0c0ELGTGknQfmUKy+PQta775ALvN5sqRDLx8fh3pjAgIim8y69J7XB8RYXJEFzmLzoAJFN43T0qiUm7fGI4IbAN1CsPmK7VrMZawyZa4tettqQ8orz2ihyrNtt9eczp5QTLGW+X3r7rX3DDXy69X6lPW/7Y8hhuJUwvuI/n0TT7sMpdBOc6xEnYKafZcIv1SKRwB+KOp60DmszHQiEE7CF9aP0KM86APcNr732nApO6dH8LVD23n9h0P4oYui5K8+YoonFSpPrWUGEsJ7ZJ9fcey+7IF9aZCOtXSfKFv1z60tw2fPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <samarth.atreya.k63@mail.toshiba>
To: <submit@bugs.debian.org>, <josue@debian.org>
CC: <adithya.balakumar.f33@mail.toshiba>, <kumar.dinesh.h95@mail.toshiba>,
        <cip-dev@lists.cip-project.org>
Subject: [cip-dev] PATCH: xxhash: Enable Autopkgtest for xxhash package
Thread-Topic: [cip-dev] PATCH: xxhash: Enable Autopkgtest for xxhash package
Thread-Index: Ad0pU83OFsFZxpGYQzSYbSmtKBXc2A==
Date: Tue, 11 Aug 2026 05:45:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY4PR01MB15624E3CCC418F638F690F1ADB3DD2@TY4PR01MB15624.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB15624:EE_|OSRPR01MB11857:EE_
x-ms-office365-filtering-correlation-id: df69ff9a-721a-4eee-fc02-08def76bd1aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|6049299003|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|38070700021|8096899003|18002099003|13003099007|4053099003;
x-microsoft-antispam-message-info: 
 hIldFzLkia/uhHWNRqYqUXY7sSFslkrhRjABdNZV1/EfNvlr9UhTxctbUMb7fFylXFmTsqmoU7tl/6v8bAAtdc7wz0oqaFHj4kdRlVP5G92AoWXHDcSdMk5iSiYvb2ISmPQFYyQc6wKzenQ0VEWCBR0pKr7MdBoGXohNz/J1uIPDz0XRadNwxOQNbgqOneDj9WYeXyQvD2rO1D1eV0vTemxxlhC6YgDsu3oc37APv2gDQAkwulr0vT1QhDhIDOgS+LLk4ByiRFlFYitGOZIomEq4nbEveHxKTvqHVc/NQTOJVySkpXHpko3h7zWm5s4npcZvq/psWfmj4CkaTVPvL3DyCsMDujsEQtPDKv57Fe53jjVoC3pCzlL6jp2uECS0T0bKySJwQslDgB5hF1qQDVs+tkuU7qWUEkpSDpKktCJGQOfTi75uKl9WElNet/tuerD7m52Nz96Iqd/SVADB/gege+jpiubMJJUbhgQ9l9NkSjZFMFeeN6mggHv8lHPJg68VZ+ib5b7HSF8uD2rKlnGZQdVG4wNH8uXnPVd8WKkaYNPRVC0XNYYJ2yFobZ/MDaoP7eiS+UgpnJgCRNF3SgyYzoP26bKyVY7G798Ogax8inibrqZf9FtJ14UKMu/QWjaf4ZiuMuryIvkVJBgL2vCHGr2GtvsxeUc0m0/S1d9bDjjilrY7NzWbTCufQA3nN+jjKbul8NUWohLm4db5rDY6R93wf7MW84N9hMdI/mA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15624.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(38070700021)(8096899003)(18002099003)(13003099007)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OUM3VkZia2N0b0MzWDJZRXRDWGJlU3BiRjRLbGRFRmNUbFZCU0FjUUw4?=
 =?iso-2022-jp?B?VWowVDM4NDM1RDV5TlpWcU5tYTFod0wwWDdkQXp6M0ZPNDU1ZktaNU1V?=
 =?iso-2022-jp?B?bzY2NFdoS3dTak1sVUh5OXNzeWEzMCtHNW5XeEtKWlpTOTVDYWY3YTBC?=
 =?iso-2022-jp?B?RWhQZ3NiV0lqZXVhSnhHMXZEV0ZjK2tEMTBaajZxK1ppdU1xbVJOaDk5?=
 =?iso-2022-jp?B?OUJVVG5PRGJyQzBnQk1rV050N3EvKzQzZGMxV1VzTFk2UlMrVFhDWm5t?=
 =?iso-2022-jp?B?c01pYmlSMENaVDdJZEVGT0xDNjdEQVl6d0ZWc2hvbkkzbTRBa0doYitk?=
 =?iso-2022-jp?B?VVBIQzdjcnBJclBUUjZRK2ZrTCtYSDh3Y1I1by9yMzUwbGF5R2ZBT1J6?=
 =?iso-2022-jp?B?T2xrb0NPa1E0cXEzcWJ6N29pMnJ4ZXhVQWJjYTlSQ0IyVHM3amtqNjM5?=
 =?iso-2022-jp?B?cS81a0ljRmY4dnpGMWI3bG9aWkpRekZwdmVoR0taMks3ckVqR2VCYWwx?=
 =?iso-2022-jp?B?SWJ6S2NPclV1WitndkxLZnJuem5teklUVzdhMmx1aWpLZ3cvUysrd0kv?=
 =?iso-2022-jp?B?cWl1TWJiOU1FSVNmTm5LcS9yNkkrWThGTisxN0Fudy9ELzg1ZzdKdXJh?=
 =?iso-2022-jp?B?OTZyZTFsUCt5ZlNKQzJzSG11c0JBUXR6ME1OeXh6UDJ6c3RXTmcwNnA4?=
 =?iso-2022-jp?B?dEZMRGtZdWRVbVJjM3RqL1NmV3duV0ZnRHJ3N005cVlPNFB4SDJVc0hW?=
 =?iso-2022-jp?B?VWRxVnp6TG5keGFQUXRsWWZsVUt0azNzNUI4ZTRraEtwVEJhc0VuQTRo?=
 =?iso-2022-jp?B?dUpJVG1iUWtwR250L05maTRLakxQQWo2V2xzdW1jb0E4QnE0aTdKdG5a?=
 =?iso-2022-jp?B?OW5rNjI2NHNkcGNhWmhVU2tRZEdRWm9YUFJiMXh3UmFPR1RiZS9heThM?=
 =?iso-2022-jp?B?ak03czAwOWxmUEhCaWdvSWh5eXB5VzZnV2V3V2J4TmNQNGEydTF6MlV4?=
 =?iso-2022-jp?B?QnRQZGJ4UzVvS2I2RHZKb3ExdnMxNVhkanBhTFY4ZmxQd0JmSmlIRHhZ?=
 =?iso-2022-jp?B?NWsvc0ZCRTcyMEUvRzNTZEo0NWZ4cTdmWE1KUjhLb0VUSFhZQjh0RnB6?=
 =?iso-2022-jp?B?SEN4NW5oRGJLTnp2VFhLWmV3Y2d1UzVBR1pnTDZON3JubmVvTWJDdFpY?=
 =?iso-2022-jp?B?dTg5MmZ5K3FlUzQvYTZhSHpXNWNUWGE4eEQ3NGljTXZpQlFwM1A4WmR5?=
 =?iso-2022-jp?B?eGd1TVNaaW1IejZpNE1CcUN6UVJ6R1hmV0phU00zeWwrMHJLeU1PRUZD?=
 =?iso-2022-jp?B?RUpzVlFHQVpMNUhyS1VUaGdYdVcrS093R0U2eWRKQ0hBOTBMeDJFR2Nx?=
 =?iso-2022-jp?B?VUpCVUZYUUREVDRNOVRHdGRxUE10Tlc0V2xHbnBHb1hlSlhXS3BqOXk2?=
 =?iso-2022-jp?B?dGczcktWdEsvU0Uza1YwbTNzV2NGQ2wyT1FWZUxYaFd3c2Y1RkRmRFM3?=
 =?iso-2022-jp?B?NytkVS8zQzNveVNHSUNiQnNXQWVNLy9iVHA5OGcrQXJ3d1ZxT0hRekNR?=
 =?iso-2022-jp?B?WHMzb0lwR2FjVDQwV0UwbjNuZ3EyZUtYbWlFNkJCZjY5Q0p3T0djSUoz?=
 =?iso-2022-jp?B?L3RycldIT2xSaFUzaXRSNVpyQ1Zrd2ZtMXlMYWNTT0tFSXBtZVJ1bStJ?=
 =?iso-2022-jp?B?YkpVMjlvL0RlV2dVRGNubG9mazNXRmhZT3RybDhaYTh4NW12cFJzbVJ3?=
 =?iso-2022-jp?B?b2hTSVFycUthL1ppVjZhN0lxU1JlK0VPTUp4NU1BbVBKcTVxcXlweXBZ?=
 =?iso-2022-jp?B?alY0TGs4VlFyaVcvQktHSzZiYXdsMmRYV1BSNUJQSklzcjR6WGZPcElG?=
 =?iso-2022-jp?B?QzM2QmQybVp3VFZ0RDRBdVpjOU1DRGJVSWVhS1o5VVh6TmxYbGFwUlkv?=
 =?iso-2022-jp?B?aGFSOC9nNDdZOS9WdFNhUi9zZVNKTlZhOHFBTjhYbWVERU5oUC9XTnZE?=
 =?iso-2022-jp?B?MkNSY1p3MWU0djZ5V1dkQVdqaCtYblZVUmE4UlRSRVI3ZGprZnZMWDlT?=
 =?iso-2022-jp?B?Y2lPRXdKV3pMS1FHdjZZdzBpSzNKYjMwdGZIOHBKZXBmME9ZWXFOMVRI?=
 =?iso-2022-jp?B?WUxMY3VjY1h3R2lxS1pNSmVKWmNJSW9tYzQvNjg5V0Q5SkNFbDE3VlJi?=
 =?iso-2022-jp?B?VmhCMzJRR0N2WlF0NTZta2RrY3lkNGg3dHFMV1Blb2MySHBXMXkvR1c3?=
 =?iso-2022-jp?B?Y2liOFFKOXlYc1o4TTFoemFFNTJWeGdGRTI2S0dvaEdhWFZhajA4L01v?=
 =?iso-2022-jp?B?TDg4ckkwM1hDNTJHWU5qOUZ0L1Q0UDNsNmxSNnZyaFJoWTJtWDZpeWFm?=
 =?iso-2022-jp?B?WHZlRm1zVzlJUW56Vm9VZlZ6Y09mTFNVWHpuQUxJbWhwRWhGYXVLMm1F?=
 =?iso-2022-jp?B?aXd5SmhZS2J4ekF1NVlnUis3SVpFQTh0RzBtZmtrdTd4QnZrOHEwams3?=
 =?iso-2022-jp?B?ZUUwZjdPSFFlRFNMYWEzM0dnQjcyU1N2T0lWbm1tSXQ1OURpVFNtWms2?=
 =?iso-2022-jp?B?ZEdMTEk4ND0=?=
Content-Type: multipart/mixed;
	boundary="_004_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	b+pu78OUnNoQ+qGtXKQOi0crpYm9rBIV0Ebs1Dnb5QhrjLMI7+jBEX5J1w0NTYXBH8ZKeD8eUjpo3sXV6MLcGeJ0GXOJs2r/9UrKwaFAqGNt7EpweGd+owBgaOyeQxXsxsbu34z7Og2z1Xz0/2wq193FAkByUF60H0D2DOWtS7KiuYOVj1pZSzaZeq/PRGtYrayrzxmFywBbgCnJKT2q+blBSqoaYeS712E9D8zqvTmTpARjGFzlHxSv4VLbrxxf5/aYVLvzne36mDv0iFOlgzIezKJ9BQvE8DaCOJdX+9NUU2crW64Y+1bGs5ih76Il5FdOvSUGDsPADY1EXxZCEw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB15624.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df69ff9a-721a-4eee-fc02-08def76bd1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 05:45:58.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hv7YRqsVq9uuunaXGUnUXzGMQgAlLyjsLMCDlfCUDzestcrsrRlV0ojblTmQUs547TwxRC7XmM676jsoiJ6fiCSIpDEaSYOph19NoRfZLJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 05:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23888

--_004_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_
Content-Type: multipart/alternative;
	boundary="_000_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_"

--_000_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Source: xxhash
Version: 0.8.3-2
Severity: wishlist

Dear Maintainer,

This patch enables autopkgtest for xxhash by adding a control and upstream =
 file under debian/tests/.

Also created MR:

https://salsa.debian.org/debian/xxhash/-/merge_requests/3

Please review the patch and provide feedback.

Kind regards,
Samarth Atreya


--_000_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_
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
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Source: xxhash<o:p></o:p></p>
<p class=3D"MsoNormal">Version: 0.8.3-2&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Severity: wishlist<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dear Maintainer,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch enables autopkgtest for xxhash by adding =
a control and upstream &nbsp;file under debian/tests/.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Also created MR:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://salsa.debian.org/debian/xxhash/-/=
merge_requests/3">https://salsa.debian.org/debian/xxhash/-/merge_requests/3=
</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the patch and provide feedback.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kind regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Samarth Atreya<span style=3D"mso-fareast-language:EN=
-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
</div>
</body>
</html>

--_000_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_--

--_004_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_
Content-Type: application/octet-stream;
	name="0001-d-tests-Enable-unit-tests-via-autopkgtest.patch"
Content-Description: 0001-d-tests-Enable-unit-tests-via-autopkgtest.patch
Content-Disposition: attachment;
	filename="0001-d-tests-Enable-unit-tests-via-autopkgtest.patch"; size=1438;
	creation-date="Tue, 11 Aug 2026 05:39:53 GMT";
	modification-date="Tue, 11 Aug 2026 05:45:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhOGQ5MjZiNDY0YmZhZjMwZTg5MzhlYzZiNDk1ZjlhYjkzYTdlZDcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZXJuYWxvZmNvcm4yIDxzYW1hcnRoLmk2MDBAdG9zaGliYS10
c2lwLmNvbT4KRGF0ZTogVHVlLCAxMSBBdWcgMjAyNiAxMDoyNDoyMiArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIGQvdGVzdHM6IEVuYWJsZSB1bml0IHRlc3RzIHZpYSBhdXRvcGtndGVzdAoKLS0tCiBk
ZWJpYW4vdGVzdHMvY29udHJvbCAgfCAgMyArKysKIGRlYmlhbi90ZXN0cy91cHN0cmVhbSB8IDI4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0
aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRlYmlhbi90ZXN0cy9jb250cm9sCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZGViaWFuL3Rlc3RzL3Vwc3RyZWFtCgpkaWZmIC0tZ2l0IGEvZGViaWFuL3Rl
c3RzL2NvbnRyb2wgYi9kZWJpYW4vdGVzdHMvY29udHJvbApuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi41MWMyOWVhCi0tLSAvZGV2L251bGwKKysrIGIvZGViaWFuL3Rlc3RzL2Nv
bnRyb2wKQEAgLTAsMCArMSwzIEBACitUZXN0czogdXBzdHJlYW0KK1Jlc3RyaWN0aW9uczogYWxs
b3ctc3RkZXJyCitEZXBlbmRzOkAsIGJ1aWxkLWVzc2VudGlhbApkaWZmIC0tZ2l0IGEvZGViaWFu
L3Rlc3RzL3Vwc3RyZWFtIGIvZGViaWFuL3Rlc3RzL3Vwc3RyZWFtCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjA0M2VhMWMKLS0tIC9kZXYvbnVsbAorKysgYi9kZWJpYW4vdGVz
dHMvdXBzdHJlYW0KQEAgLTAsMCArMSwyOCBAQAorIyEvYmluL3NoCitzZXQgLWUKKworbWFrZSBj
bGVhbgorCisjIENvcHkgaW5zdGFsbGVkIGJpbmFyaWVzIGludG8gdGhlIHNvdXJjZSBkaXJlY3Rv
cnkgYW5kIHVzZSB0aGVtIGZvciB0aGUgdGVzdHMKK2NwIC91c3IvYmluL3h4aDEyOHN1bSBcCisg
ICAgL3Vzci9iaW4veHhoMzJzdW0gXAorICAgIC91c3IvYmluL3h4aDY0c3VtIFwKKyAgICAvdXNy
L2Jpbi94eGhzdW0gLgorCitjcCAvdXNyL2luY2x1ZGUveHhoYXNoLmggLgorCitlY2hvICJSdW5u
aW5nIG1ha2UgY2hlY2siCittYWtlIC1vIHh4aHN1bSBjaGVjaworCitlY2hvICJSdW5uaW5nIG1h
a2UgdGVzdC14eGhzdW0tYyIKK21ha2UgLW8geHhoc3VtIHRlc3QteHhoc3VtLWMKKworZWNobyAi
UnVubmluZyBtYWtlIHRlc3QteHhoLW5ubi1zdW1zIgorbWFrZSAtbyB4eGhzdW0gdGVzdC14eGgt
bm5uLXN1bXMKKworZWNobyAiUnVubmluZyBtYWtlIHRlc3QtbXVsdGlJbmNsdWRlIgorbWFrZSB0
ZXN0LW11bHRpSW5jbHVkZQorCitlY2hvICJSdW5uaW5nIG1ha2UgdGVzdF91bmljb2RlIgorY3Ag
eHhoc3VtIHRlc3RzLworY2QgdGVzdHMgJiYgbWFrZSB0ZXN0X3VuaWNvZGUgLW8gLi4veHhoc3Vt
Ci0tIAoyLjQ3LjMKCg==

--_004_TY4PR01MB15624E3CCC418F638F690F1ADB3DD2TY4PR01MB15624jp_--


