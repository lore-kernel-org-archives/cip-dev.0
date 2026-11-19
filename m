Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11401.1795083355542000755
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 02:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=GOMJ7gVX;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	shivanand.kunijadar.v45@mail.toshiba;s=key2.smx;t=1795083352;x=1796292952;bh=
	md6d+PN2/0UxCVPeTopoBxLNCP3X9sbhW0vZHgSvM0k=;b=GOMJ7gVXWChqEDREiA+xSp9pv1fz6I
	dBATbiZbA1P1XBZVzg7HULcLx8mRAWcBAKZGTmPVep4d+L5Qk4Ky5IP2SPtQyGU9RCCwIxQI6vgEa
	kBNXSDDN30svIbTLFXwbUBI/bYgWWroCgvVxCLpHnyAEx9GYUp193/BnLkEKWRfbEA7ABgzy3itOJ
	TEx1MEAuGvGTTukkmJGAsdN6liBRWSAiJcdGYJqpMrDUMHkRLPJ5h9dU6zo+zhc+wj+TbbI8cPvpZ
	+n5SLzthukWvRmMEDWccZJJmWR6cu9xCcZamQMKMOFG7Nz57YSfRZ1mGt5Msd5Znp8Wev/GeTMCWr
	fa+w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6AJAFp2c732092; Thu, 19 Nov 2026 19:15:52 +0900
X-Iguazu-Qid: 2yAc0F2ngcfoUo9PZC
X-Iguazu-QSIG: v=2; s=1; t=1795083351; q=2yAc0F2ngcfoUo9PZC; m=Md/YhlLvZL0HR/j8KKPiU6/UHctmqtm8YhoPK0E6Wds=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jVZ9g2GZfz1xnh; Thu, 19 Nov 2026 19:15:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUKaTVGoCVWVV622Tu8qFt/8qslZEe0/f2nTGGcxlDNCLzh+Q9les25jeku1ncR2N181cflqiTIwG4JHBeYLwkQzpgVwlu1jpjvRevcEXn2DuQ0Lf1hmr3DUyYc4bwZc1QSB3WZMFdyehfX0vq4l6fPjdmygHXq7Q8M0h/v3/eHlEd29QuwJ+7HRzhTVoEfU7RxNDxZ0Ywh9iT2ZJJqaET/n0S8a7sPfcQq85Wn+DOROTaSMu4EDVhyW1G+KDWkkkh0yNL1CTXb/+Z24dwXzwbNBp1Wwa6qz9uif9EtmxueZ21tUXFY/ROjZjoX8b57XeOTa4Fck3Q8Foojx2CaVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In7DYT6oUWdKLxPxIEYYcQ7uXUP1qrBWxIvv6URmcJs=;
 b=fkKcA1nnKrEA1Pa9EdMPPrZ+xobi4TjGAWCS9rbyMmQJ/4MALERkwRgv9zK5Bs9HwhrgedUMzdJ/PrUyrptCTSCC2AapQVXntj07xP8F3G/FN1Hoxo8MjnZRAyam7Rea9BopYHaVi5GoNMSA3EdJyVdLHzPgi7gG061+o2qFSPq+HRrjm7A29f9Y7Ah+17DApVn8EwGAUjtbvO7mVjMXmxt0VMhptPHxtx2TJVjeWYQsgXEXH7KwpoRUjJf6/m0VCk5bjEig/dUHlijz7Yr3ONEF3Bsz67FAH60AF5pzmY3B3h8WVN7tAQU7ts+icQnBIgxFI8nS7BOR3PV4sDzJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <shivanand.kunijadar.v45@mail.toshiba>
To: <chris.paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kumar.dinesh.h95@mail.toshiba>,
        <kazuhiro.hayashi.f74@mail.toshiba>,
        <adithya.balakumar.f33@mail.toshiba>
Subject: Review request for AWS s3 artifacts lifecycle policy & add forky/sid
 OVMF keys to lava docker
Thread-Topic: Review request for AWS s3 artifacts lifecycle policy & add
 forky/sid OVMF keys to lava docker
Thread-Index: Ad14Duo8+d8o2LadRE+SqxEZ03Crqw==
Date: Thu, 19 Nov 2026 10:15:48 +0000
X-TSB-HOP2: ON
Message-ID: <TY3PR01MB1107531C6E4E9400A3F5AFAA6C5792@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY5PR01MB18158:EE_
x-ms-office365-filtering-correlation-id: 07c96016-2074-4404-6e20-08df462614f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|261009223027099003|13003099007|8096899003|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022115727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: KhAS2hgF0tv2ASXnNx19W+vVnlcJfPSZc6ViYhwTUu9wDsrQe/0lQ3EEwnfSwjar6wypqmW3rDhA2SrpEU22AsoNZdfwvjSf1C2Vm2pWNqLjd0TtTkcXFFyk96Ckl3MHxuANeK/8k37Wm5eg3AslZJ5GLNnFRwsQArt9R+UNKY/UYTifCyxlmv+jxS7nvHyR/36lv0Puq5s31yAqJeBdMG4boK6LmaJD1hF5ZGg0wamfMZaPO5uZOfY/Nj5VJzfHVHwSLWR9EF8V3UN/YBUs/5jT+1cdVsmzFcT76ViFXasTB6DtYyhuy6TVsCAwWFiqZmscs3P64Qdee0G0pOo2l5rXsqY274VlUlpmShu0TVh8Ct6Ao81asee5nYhqIgmU8wFExpnV9WKyOVRBQbmkBTwkFGVo5ge8p52nY6eGnFGhm/NNxtVV74y5KrxBmft50objgBK679CrjdgbKYBidKnca3CuCoM0uxLiL0wS9oNesAMh2fR/x7Hds4NODFZ+QOeuodFdZYI0+0Q938a/M5Aov/HgnKI9T+Y7ULkXmNBuFcd0N4bLxiRX4sA0kATZ/09h6kKfgRczYL8KnAPm3gP59nNVQgpX9neHCObdxjUGdae3EeXP6MK3Tj+zDZgoNnZa50JyHMj+KlIpEhNvtgfXfaHD6xy6VoNzJkc9z8tuQupusWSAwx9ASvQJDql7gnaVLr72FEgKnl1WE7ttXiLQE4peeWFiIGH5bDngYHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(13003099007)(8096899003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022115727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b3AzbG91c2tDdEUrSUJKMlgrbVJzMVNucHFGYmQzQ29UNzQ4dk8vdXVm?=
 =?iso-2022-jp?B?bFZsb1VWcjZ0ZXF6dGRob3NLMmJhdURsMEVYMkJ0QWw0YXh6OFBoaTZm?=
 =?iso-2022-jp?B?bFdYR093Um80cnpwbGxZRnp5dzI3OUEyZzQ2UllWeHUzYlM1TnZkVXNE?=
 =?iso-2022-jp?B?QXVtbGJwT2wrVXRySDcyV21wTmhFUXVDUXdzYlgzZkxJdTZKZ1QwM3My?=
 =?iso-2022-jp?B?LzdaZ0h5S2JVUTNqSmZoQXBGcEJrSFNNakRDN0pFOWVMUDMwOUVqVkpu?=
 =?iso-2022-jp?B?aEc3aGhqRDFXU2lPYmN2NjlvWjljOXpJSW5jZWRuN0w4bUdWQWtvQjRq?=
 =?iso-2022-jp?B?eDIrVkhBK1N3OXNjaGlEMTdYM001V3JIaTdpanFsSmJDeUQzT2lVWUZO?=
 =?iso-2022-jp?B?ZFJiVkNjRko1WlRGbVlDTmpJeHV0aEpPN1J0SnY3b2ltOTllekVubm41?=
 =?iso-2022-jp?B?YTk4TEdMb0dGRGRQejNITU1JME0vTDhXQlZlWFFOZ1FDRFdGWis1enhQ?=
 =?iso-2022-jp?B?NUR5N0ZzTHV0L29CU2lCdFJCS3VJaTJqdXFoYlZ1NEt1dmNDdzd1U3RQ?=
 =?iso-2022-jp?B?R3NxcStkUGNFNk5JelNPUHhNMnJJSkh4WTV5alNLUjI4YzhoMml3WkpO?=
 =?iso-2022-jp?B?Wld2cE11S25LbWN3TnhuVUhUMHpWZ3FUYzBPcWxlYnZWakdEMGE1N2Q1?=
 =?iso-2022-jp?B?NktvQVd2dUQ4Ky9CbXJEOFhiODl2eTdnWUNMSUU0U2NjcVpHWmltbGkz?=
 =?iso-2022-jp?B?T1EyQXIrNklPaHJNUlhKTEVPZHNGQWF3K05VSjZkbjc4bUcvMmdhWVlw?=
 =?iso-2022-jp?B?WWlIZFhvTW9SUUprN3F0azBZcHAzaDhvNC93czREOWY3MkU2ZHFtYXA3?=
 =?iso-2022-jp?B?bTVjK0haUWZYdHFVVWVHQzJUNGRqS09mTUZ4VDNzbHp1WVF5Q3U2S3Yz?=
 =?iso-2022-jp?B?Z24zWC8vQ05meWdCeTFjNko1OHB2TTljYlVDZkpMUk9jQVJZT0FLbnIz?=
 =?iso-2022-jp?B?QXd0UHNaQmJVbDhtMmZMSmV0UTdPQmpIckppSVpOL0sxVm9sVkVkVnp6?=
 =?iso-2022-jp?B?RUJFdFVlSFhrK0FqVVdQQUFpVW0wNFhwa25kTHdvcytvYkQ3VnBlTXU4?=
 =?iso-2022-jp?B?Yjh2eVR3bUhqNlN6cmFzV2RVRkJTVmQ4eWExc0pvNk05TzcrSVVMYmIr?=
 =?iso-2022-jp?B?czFSSnlQam1CdTZ0MFZRSkVBMjI4QnUyZ1hYZjNIenJlQVQ1U0R0Z2h2?=
 =?iso-2022-jp?B?V3NBbGdsU1dNb3pFU0xHUWFOY0x2VFlxaUtSQVJVelEzS2I3ejVqZytv?=
 =?iso-2022-jp?B?OWdvSFNSY1ZmdXV6L1RyYnAxZGNhbVdIcDNSTlhBRjA0RlZUUS9admFu?=
 =?iso-2022-jp?B?Q0E3cTdqcHB6OFdvUnJVZFp1M3lsMTN4dUhYeEw3bFZmY0dXeGtob0t6?=
 =?iso-2022-jp?B?K3dDTVBnNGYralFhbWdVZ0lOYlFWWjNIblV1ZnhwcUFnWWUzWDFieEdy?=
 =?iso-2022-jp?B?a0ZMVnJDQXBPMElWSDkxeS9aLzJNYWNoT3ZvMk1jMWNCWUtOdk9rVVhK?=
 =?iso-2022-jp?B?UDhvdWlyb2FuRStCQ0Mxa0dkcmMvT1pTcC9MU3htTkpXaWF3MEVUc01x?=
 =?iso-2022-jp?B?ZWhvdjRPekRKL21yeUNpUU5GYllWdGxjZ2dZSmhUMSs2eDVJNWJBZFE2?=
 =?iso-2022-jp?B?UjVRUHk4QUhubTRURzJjc09jRytCc3lyRmhnMmFWaU4zbU1RTUZRZTRi?=
 =?iso-2022-jp?B?bmF0Ynl5MTBDSEtZN2Iyd1NaUFBuZ0VlK3pBV0dIVTRNTG5OTy8zRWIv?=
 =?iso-2022-jp?B?LytOZG9ha2hnaUEwaVEyYVhjM2Y4elVPbWljRTR2NGlOdzZDZDZKYUJx?=
 =?iso-2022-jp?B?dlpEQmFURHB5dmlRR1FESjgxZk1lUzdaTVFNdXZLNmJ6d2lNMVBEQnVP?=
 =?iso-2022-jp?B?OHNCTk83VCtXMlBTVTZhMHhzNUliZVFSdVZ0Sk9nQitXOVVqSTZxMUhE?=
 =?iso-2022-jp?B?cGgvSVpyejcxZ0M2WlZTL0F5ZWRBQUptMi80RENUK0V3UXNzYWFDYm53?=
 =?iso-2022-jp?B?OGo4MVVSbjkwQlRMRlRjdXVsN0RoQjhTL3cybE5hSnk2bEhDY21SREN0?=
 =?iso-2022-jp?B?UEw0Ly96T2lJV2FLR2lhZEEvd2F6bVBnckppMExGMGJZNWFsNmdCNzBj?=
 =?iso-2022-jp?B?N0FWK3poKzdqNlpiVTY5cnk0Snd1YTlwaDRvVVFxenl4U25FVzYxdDdY?=
 =?iso-2022-jp?B?cEVQc0xNTlhlZWxtZjRGTUtqSEFTeEtYQ2M5eUVvRVd2cGJEQTVwRDg1?=
 =?iso-2022-jp?B?OVFjVk5ZT3JYbUZETU1UTVlHbG0zOURlVXBQb2ZXenIrcHoxTnVRV09t?=
 =?iso-2022-jp?B?cVVvb3h4VDcrNHdzVjJqa3JuY2JCZEVpMitZdGNmS0xab3lualB4TVIz?=
 =?iso-2022-jp?B?YjlZMmRvSmNnUXFkcERaSXQ0bUhyYm1wMWgvb2FOVlVCSE1NdUQwN1U0?=
 =?iso-2022-jp?B?WG9CaHRQTWtpeHRNZHoxb1ozL21BZXpUNnNzOU5KMTJ6d0NaY0t0Unlj?=
 =?iso-2022-jp?B?K285bXA5TT0=?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB1107531C6E4E9400A3F5AFAA6C5792TY3PR01MB11075jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mV6WNK/KMq4vuqd2d60kXDXO3P4gUXVsMr9T4uH3gSej5FyWn55tgswA5gWc31nrrbiDTMIDNBiGUnMQExMwUcg2OvvjCpcBKsq6lqjGQuJOMoepZcOY43MEVhZSOsOIdXsyJipqv/NbX58i116WM24uWTjX5Z6a2lK2pzY1U9EFYY9vxlJ/0ljIqKBgZmT3V6gOnju68plXwmgtGpbr7FgKi4NMTz5JYZ5PBWLQqQvo7QEzdAXomDWECOVvVXHjvxWHc1umxJj76PFZiEpZA4NMhv30b312UP+VJuBDXbax4tbxTt40RkKiGYh2cUSUXTNa9oe3AJREi6qEznSPOA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c96016-2074-4404-6e20-08df462614f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 10:15:48.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Gis73yQ+wqO9ds9YXzb8lFetByqdD4onLLD5Bz4ejnxJZyVSzjyuOhXyWlzWTA9xhDEUtzisRubcFVQlBFIqZQzxKFErQeXAblA+J/MEdQhhecYcL/fNX8zcPZDrAQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18158
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 10:16:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25012

--_000_TY3PR01MB1107531C6E4E9400A3F5AFAA6C5792TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope this message finds you well.

I would appreciate your feedback on the following issue and merge request (=
MR) at your convenience.


  1.  issue: CI: Pipelines can race test
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/134

For this issue, the CI pipeline is already configured to upload artifacts t=
o the AWS S3 bucket using the CI_PIPELINE_ID.

As a result, a large number of artifacts may accumulate over time, leading =
to unnecessary storage consumption and increased costs.
To mitigate this, it would be beneficial to configure an S3 lifecycle polic=
y that automatically deletes older artifacts after a defined retention peri=
od.

Could you please check whether such a lifecycle policy is already in place =
and, if not, apply the appropriate settings if you have the necessary permi=
ssions?
Please ignore this request if the lifecycle policy has already been configu=
red or any past artefacts needs to be maintained for some reasons.


  1.  MR: Deploy OVMF for Debian sid & forky
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/57

The isar-cip-core project has already been updated to support Debian Forky =
and Debian Sid based builds, along with minimal validation testing.
This MR adds the required OVMF keys for Debian Forky and Sid to the LAVA Do=
cker image, enabling the execution of Secure Boot (+security) tests within =
the LAVA test environment.

As this MR has been open for a considerable period, I would appreciate it i=
f you could review the proposed changes and share your feedback when you ge=
t time.

Thanks & Regards
Shivanand K

--_000_TY3PR01MB1107531C6E4E9400A3F5AFAA6C5792TY3PR01MB11075jp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:565457396;
	mso-list-type:hybrid;
	mso-list-template-ids:-1351996336 1074331663 1074331673 1074331675 1074331=
663 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:606620023;
	mso-list-type:hybrid;
	mso-list-template-ids:-821258654 1074331663 1074331673 1074331675 10743316=
63 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:2081369457;
	mso-list-type:hybrid;
	mso-list-template-ids:-323867206 1074331663 1074331673 1074331675 10743316=
63 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope this message finds you well. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I would appreciate your feedback on the following is=
sue and merge request (MR) at your convenience.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l2 level1 =
lfo3">issue: CI: Pipelines can race test<o:p></o:p></li></ol>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><a href=3D"https://gitl=
ab.com/cip-project/cip-core/isar-cip-core/-/work_items/134">https://gitlab.=
com/cip-project/cip-core/isar-cip-core/-/work_items/134</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For this issue, the CI pipeline is already configure=
d to upload artifacts to the AWS S3 bucket using the CI_PIPELINE_ID.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As a result, a large number of artifacts may accumul=
ate over time, leading to unnecessary storage consumption and increased cos=
ts.
<o:p></o:p></p>
<p class=3D"MsoNormal">To mitigate this, it would be beneficial to configur=
e an S3 lifecycle policy that automatically deletes older artifacts after a=
 defined retention period.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could you please check whether such a lifecycle poli=
cy is already in place and, if not, apply the appropriate settings if you h=
ave the necessary permissions?
<o:p></o:p></p>
<p class=3D"MsoNormal">Please ignore this request if the lifecycle policy h=
as already been configured or any past artefacts needs to be maintained for=
 some reasons.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l2 level1 =
lfo3">MR: Deploy OVMF for Debian sid &amp; forky<o:p></o:p></li></ol>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><a href=3D"https://gitl=
ab.com/cip-project/cip-testing/lava-docker/-/merge_requests/57">https://git=
lab.com/cip-project/cip-testing/lava-docker/-/merge_requests/57</a><o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The isar-cip-core project has already been updated t=
o support Debian Forky and Debian Sid based builds, along with minimal vali=
dation testing.<o:p></o:p></p>
<p class=3D"MsoNormal">This MR adds the required OVMF keys for Debian Forky=
 and Sid to the LAVA Docker image, enabling the execution of Secure Boot (+=
security) tests within the LAVA test environment.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As this MR has been open for a considerable period, =
I would appreciate it if you could review the proposed changes and share yo=
ur feedback when you get time.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB1107531C6E4E9400A3F5AFAA6C5792TY3PR01MB11075jp_--

