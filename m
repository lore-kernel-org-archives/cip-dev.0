Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860BC27C65
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 05:37:54 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web11.2719.1718084265786388758
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jun 2024 22:37:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tnPuQr3+;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTHERoEslC8DJlC0/lGSoYMDoLHNYLs3ixigdobanGKugQvoK6Rf/dNPjx4XkcybUbNJ05zcDX1XWHJ6LRlzow+DVScPBbdcKxwAEilFSqmW3N0CZczgivED3ckvfhiMlcRRyvD5/XTQ81dRnWVou5LUZ0m0tqQhKTHQPdixS+nx9122AJuts+8mfZVDyHPuHdEm+j0Y4U2YVh6Appp43HZOmK/W5fdoqpRyYw/T3ubX2/SjwOh7/aawarVWwI3ac0AZyfT5w6MB3G0Kaxd5NQ73LTT1xJGRHW9Ve0rYnVg1Q3wws43EeGxuZA4wNpG735A7P/IA9AiBh6AZ/kP3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usWMsIuvrjRZlgS9BwtV0Lxc3uDXaSkpM5mybC3ZJpo=;
 b=D+QWYIdfpSI0bRTPCGWKPypWPr8+rPuWtGdDFfyj8rmoN/kpOuXsAdwVWau7VGhVDljHlOLvuiRS8YtyHEFGyqmLGBXLCXYcVb2xJKhIaMLINsGqmJ22oMAHM6bvCaAQ+H2BC6mN2mmygXtQBHPHWR1zBFdCirRokgLMdensOau2DI7XWlIvztMXuapNyu7ZbPCwXGIs95ldRGS534C6t3gyJ2etDigYgUG/XzIaH2mj/LYFAP1veEEfO4xjFR6szm02MlSI5VQWID1YLLeG8mlpT9aN7YJdIot/aOX8larbnkxQG8zPYmCxsKlasPNnTu4+XoJmqQsa9Qv6gMPzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usWMsIuvrjRZlgS9BwtV0Lxc3uDXaSkpM5mybC3ZJpo=;
 b=tnPuQr3+ljpSG7KcbxAOT84+1oqvB2d9jKRpME6J15U/Kmg4X0n52AVgZpa482fB1NsARouzpLQ7a6v0HHOA0Ny6DTpMnr5qApGIPvPyw/edG0kiGIJZOynbAlDWjlmDGWbeLRBoGgWSyiX+/GGLg4N012vLU+W3NryiRMu7TUP/hB0iSl0oH8B0YCL2+YCVoUIgPlMgPK79/ktbOlKhOHmEk9LZ0ouwH+huQmouteGWGPYko4eP/dfcDJu50PFKmSi/YgFz+WI2er6H3J1/r5E26kcUhS6OCVZPVStKQdc6soW8iQiSNc4WuHr/TlPjMT8v+wQ6KrElQ0sBVchedA==
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 05:37:38 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 05:37:42 +0000
From: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Adding swap space to the encrypted partition
Thread-Topic: [cip-dev] Adding swap space to the encrypted partition
Thread-Index: 
 AQHaseh/JPXX8y07VEOu1ZMyXHtipbG6cD2AgADzlQCABWFAAIAApAKAgACS2oCAACHzTg==
Date: Tue, 11 Jun 2024 05:37:42 +0000
Message-ID: 
 <PR3PR10MB40965C14B1B94F5ACE3EBD1081C72@PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM>
References: <26684.1718045165094836518@lists.cip-project.org>
 <19666.1718076701122955939@lists.cip-project.org>
In-Reply-To: <19666.1718076701122955939@lists.cip-project.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-06-11T05:33:11.4333609Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR10MB4096:EE_|DB9PR10MB7338:EE_
x-ms-office365-filtering-correlation-id: fdf2abdd-ca20-45ed-83e4-08dc89d89d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Q/wB9B1LDXnLaV6g0Dk3HaT+fhdbUgEdaFZXI8axgzMiiUepTyq4pB4/8FLk?=
 =?us-ascii?Q?7Ol4MILkuCiyVUJKo4fCZJwTeCH1WvELf8cZ5UAGmyElrBv6bCkYyvUyv0eo?=
 =?us-ascii?Q?0/UWN7Kzu/Wo4GSMJN0rphppPMX/JUyEVHsideIyoihoLh6qfB5nkuQtAEP+?=
 =?us-ascii?Q?ZfzfzcIkcLTwB4qoGeA1qcwKIgf9+8IPp+s4SKpj0e2K+OeHUOXNOFAVFHpx?=
 =?us-ascii?Q?RL7ym4i9jzGj5J6zbIFWhTN75csVCcX4EhHRSFRS6vWpGpqRUGP/noDkjjQG?=
 =?us-ascii?Q?XzRjiADMhVRg5FevrlXzuqIf51SpJRIPpUpdSMYEdmD7I1p1+6tHO3J/0EPp?=
 =?us-ascii?Q?hnHfNafuvgYKJU6l+MSd/Z1bQ3nTY1dIr4roa4U/Lm/Jth5irR0Fcq6n5Lqf?=
 =?us-ascii?Q?GkubkI7kWCg2gUJb6a8cRsLymdFuimdHY0AwMbQE6iEy2r1CCTqPrKCCuIh5?=
 =?us-ascii?Q?aLCaLNtyygwRyJiPir0R0DXoGkJZrS/ScbX0amjJeBO0uTE9ZA7+Ibi+7NfC?=
 =?us-ascii?Q?FcnNjH0y7G7nASZmdjx9kEnjD3Y4eDecV8ot5AAcQLNrjhX7WWb11/Lps7fm?=
 =?us-ascii?Q?MWkC2seiXJgPxudewztWGwd4qZd7tMhQ2GXsUYn2FdfSQBPKXlhqh2BwhXQ2?=
 =?us-ascii?Q?tVsT5vaxWV/M/+edSoIW1VKiTzDGmBmIPU8/OuLgRL9teErkM+fAW+gF3A6e?=
 =?us-ascii?Q?8Tu8Uy/PEOnkKJC0YaZykOneoTgfmWRPKMj8LAvwGULfoSDTbgI/d+foeqk5?=
 =?us-ascii?Q?+tYG8qQg7Tj9OODsvzEjJvqhgxCAX7hZHglpkWLdJMXG6ueR1z6WNh+7n4kO?=
 =?us-ascii?Q?TLs5qjUMzk3GB5V3acfyBgqlK9y1qiEFu3MUstykVVD+WIqggFT9OFWJ/bLX?=
 =?us-ascii?Q?4ddKsh6jF+9rHDWGoqPbO1YHyGWwZuEEVgpagkcsnh804ExkLImm1h/gKs77?=
 =?us-ascii?Q?9ZGCHJTS1qBXsRSbzk3exDD4VLQgM8taT7UWZYL3S4Foi+LMvXmBaE0udmNQ?=
 =?us-ascii?Q?oPlMlwulMG97tE5IIsaBWpjx5Ag5hdlywc8+rlkQNclb87RwgsGgphE5ZY2R?=
 =?us-ascii?Q?yJ9DIczJxN2fVJy7gIeC3S33H2RtnoPtbHz7rJOumpYLQ6HVW8AltZh217un?=
 =?us-ascii?Q?ReFKP8mKRoVeuy6Mjw+4tmQHIbqxerSPj00Wp5oHktAtJUDbNLXfoHg5Wi7U?=
 =?us-ascii?Q?5a0dSSChZLnZ8U4sTqyp6OnqNeKFsh3KOSpfqQmdF/a32wRMWKmOzGP6+cMt?=
 =?us-ascii?Q?mDaoM2mYidxDulM+wJjdOSnlvSlpJtBT9ILzjnDnqAxMxeBU2xDLT2ma1uav?=
 =?us-ascii?Q?iMCHvFKWa/A/oRLG6DgYdWgS?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?T162hKhnMalyuQjeVeEw0UmUBCPblM+8oWypT3zIpxdFa3fdDLY+EYYAMmK3?=
 =?us-ascii?Q?gjWHqS7ZwQljeMPsERe2Y9Nv3ucGL1bTKXcgABJJOxNTZ7HDkVdhQ1YamUrG?=
 =?us-ascii?Q?+dp9l1iWW7VMfSARs1wXIbORoW2uDBrelOTQqwWc3XeYok5tmsHHpO4+zgSx?=
 =?us-ascii?Q?aeq5UcreSRQzbDI0/QjFjmgtm+TQsGkCXq/KSvqZA5xEHyaScGrKcW+WSvx9?=
 =?us-ascii?Q?TGPRfHR7a55OVs21LFXvtPDV2PmHKvVIwISbUmuOqsVe/tQcRog5o8KAEB/g?=
 =?us-ascii?Q?5n4gGvVPTdZwWPReJ7gSBLkggfqSZLbQ5aHQ70zRxr79SgkOE8RJZumgMEgZ?=
 =?us-ascii?Q?Qk7Wph5rvOarKalKRN1NgE5xjniWoO5lYrYDgutIzAPh+h+DEGX8qiLlPbb5?=
 =?us-ascii?Q?9iJ8kqNnfF+EDmUEnNTKzwUi8BxfmJQwtPeHviIecKCKo6GmtO1vPQKN13ht?=
 =?us-ascii?Q?rLt8EXc9U+KUY16slDDff+3kP217fybJAFO9jnZSTgsFfAKsoCHLGyZSxaXU?=
 =?us-ascii?Q?qrPFTDRqR+SjHJ58Df+8hYLhdu+fnNIVq47UIVy/HQbB1oWcTEsJMhWonUxo?=
 =?us-ascii?Q?WJgDnOLYM6Feyw3nUeAcMRdjthAOVW/c7OV1CWyG95B5YCCjHF952zzXS+UP?=
 =?us-ascii?Q?FfE2E3j2VfsYGOwb3w6CFh2HxS4QtkjAM3RQ5EqggBMw0+wG6UpO6PQ9Meg2?=
 =?us-ascii?Q?d0PhT/vabBx+Oop/KOFEfoEUrg7nK0VSbQMJa3/EcY99qZ/KPMSCiNiqJdUA?=
 =?us-ascii?Q?nvMfpblhFx0OK48m2G0srf57aXFbnqxSgSINSPHM2aLvFAI+qSvyq87wFGQQ?=
 =?us-ascii?Q?HDYDu8BBypQMUxcMkdleoudd+pyEBZOj8h122KthlbA5+cztBsakdFEG0D8c?=
 =?us-ascii?Q?FvsM3ftqlbgx1+azzZPGaIeKwaOBreS6Co6TVY7IqH1kEoghAAEZ0NgsszeY?=
 =?us-ascii?Q?rbkMm71GNWWidacFxaCP98LY+0un1Zu8aKwYZGrYfG18fZapi2WTblT7qaZh?=
 =?us-ascii?Q?jb8WB5gSdZh5mqSVlDiCtiTipZ1RFhr/TyE7iFASi4VDyoNykUpv/LogPnIW?=
 =?us-ascii?Q?9mHqU6jlxi9PNbikm+uJJvc1C8MrrOtyA1IGzPno7IiSj+Tgc2/Vj0AHeK3S?=
 =?us-ascii?Q?bUD6rkPwJ+EMwYUcNBBPbMdJh0fw2Kpto7NrLBPumnHyON4HUX3/S2IBCcZu?=
 =?us-ascii?Q?9tvBJ29mVhMHYAadgROlpUCpXnRPuGYmt6ZVSHc8EVf2ickIpCW5SuU4xhD5?=
 =?us-ascii?Q?cY0ykwcknAuxwaBB8BW/lpJSSo1UcBs7NwGyglRmxQfAXRo4zgrIyk7SeYG9?=
 =?us-ascii?Q?yst2bWf48Dx+9qVMxjfJ4pvFD1JOE6ZUMIpEqbhGbhqIaaebPE21Fd73BDuK?=
 =?us-ascii?Q?XkMd7qtEzqnOTqR/x6HS4CYR6nLOpbJFLszOfvH9aRjro+I6AaUNZzSVlAYj?=
 =?us-ascii?Q?uC2A1G5CVq5nBJY2hF7UlpUuCCPGnl6WjB6q9v8tUWdnku4fKaX13q5W6r4i?=
 =?us-ascii?Q?RjsNXGvCTFsOK/bQnJNT8wcpWer5uU5a0v0+M5Za+ProarkL9I+T8F+u8cBs?=
 =?us-ascii?Q?jHWaRxkwA1mFVRSsYH6S5+kowy9R9fBVGFMubbAXhLy7qXV2qrrFCveFpBkq?=
 =?us-ascii?Q?xrrrnjQMSlqww0jcFQvjIz5ldok+A34YI6q2Tefr3fYAeoY3pED+Gd3mDVyw?=
 =?us-ascii?Q?+o1mXDY5n2Y0iktdb3B/HMzMAv0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PR3PR10MB40965C14B1B94F5ACE3EBD1081C72PR3PR10MB4096EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf2abdd-ca20-45ed-83e4-08dc89d89d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 05:37:42.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/Sb4DXW8sTlKaeCFaiksmb0+fmAT0OxftOul/xDjjbqisy5AAZrbXmE7nbaa0hlayiF/j4hUdPwKxLUfSRYBjqFM0w1ntmo0sihoN5FykE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 05:37:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16187

--_000_PR3PR10MB40965C14B1B94F5ACE3EBD1081C72PR3PR10MB4096EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi John,

Ok that is fixable we need to add an additional case in the crypt script fo=
r resizing swap in https://gitlab.com/cip-project/cip-core/isar-cip-core/-/=
blob/master/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
script?ref_type=3Dheads#L80
Can you send a patch ?

Best regards
Quirin
________________________________
Von: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> im Auftr=
ag von JohnW via lists.cip-project.org <johnxw=3Damazon.com@lists.cip-proje=
ct.org>
Gesendet: Tuesday, June 11, 2024 5:31:41 AM
An: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Betreff: Re: [cip-dev] Adding swap space to the encrypted partition

I tried adding the following before the rootfs partition in the kickstart f=
ile.
part swap --use-label --size 2G --label swap1 --fstype=3Dswap --fsoptions=
=3Dsw
and also tried updating https://github.com/ilbers/isar/blob/2c76d889035ea05=
114b1a31bb73b025c0247a278/scripts/lib/wic/plugins/imager/direct.py#L105 to =
allow swap to be added to the fstab. CRYPT_PARTITIONS has been updated to
CRYPT_PARTITIONS =3D "swap1:swap:reencrypt platform:/:reencrypt"
also tried
CRYPT_PARTITIONS =3D "swap1::reencrypt platform:/:reencrypt"
The image booted into initramfs and based on the debug log it says
Begin: Encryption of /dev/sda2 ... cannot resize partition. unsupport fstyp=
e: swap
Regards,
John

--_000_PR3PR10MB40965C14B1B94F5ACE3EBD1081C72PR3PR10MB4096EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">
<div dir=3D"ltr">Hi John,</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Ok that is fixable we need to add an additional case in th=
e crypt script for resizing swap in&nbsp;<a rel=3D"noreferrer noopener" hre=
f=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/re=
cipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script?ref_typ=
e=3Dheads#L80">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob=
/master/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.scri=
pt?ref_type=3Dheads#L80</a></div>
<div dir=3D"ltr">Can you send a patch ?</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best regards&nbsp;</div>
<div dir=3D"ltr">Quirin</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> cip-dev@lists.cip-proj=
ect.org &lt;cip-dev@lists.cip-project.org&gt; im Auftrag von JohnW via list=
s.cip-project.org &lt;johnxw=3Damazon.com@lists.cip-project.org&gt;<br>
<b>Gesendet:</b> Tuesday, June 11, 2024 5:31:41 AM<br>
<b>An:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Betreff:</b> Re: [cip-dev] Adding swap space to the encrypted partition<=
/font>
<div>&nbsp;</div>
</div>
<div>I tried adding the following before the rootfs partition in the kickst=
art file.<br>
<blockquote>part swap --use-label --size 2G --label swap1 --fstype=3Dswap -=
-fsoptions=3Dsw</blockquote>
and also tried updating <a href=3D"https://github.com/ilbers/isar/blob/2c76=
d889035ea05114b1a31bb73b025c0247a278/scripts/lib/wic/plugins/imager/direct.=
py#L105" target=3D"_blank" rel=3D"noopener">
https://github.com/ilbers/isar/blob/2c76d889035ea05114b1a31bb73b025c0247a27=
8/scripts/lib/wic/plugins/imager/direct.py#L105</a> to allow swap to be add=
ed to the fstab. CRYPT_PARTITIONS has been updated to
<blockquote>CRYPT_PARTITIONS =3D &quot;swap1:swap:reencrypt platform:/:reen=
crypt&quot;</blockquote>
also tried
<blockquote>CRYPT_PARTITIONS =3D &quot;swap1::reencrypt platform:/:reencryp=
t&quot;</blockquote>
The image booted into initramfs and based on the debug log it says
<blockquote>Begin: Encryption of /dev/sda2 ... cannot resize partition. uns=
upport fstype: swap</blockquote>
Regards,<br>
John </div>
</body>
</html>

--_000_PR3PR10MB40965C14B1B94F5ACE3EBD1081C72PR3PR10MB4096EURP_--

