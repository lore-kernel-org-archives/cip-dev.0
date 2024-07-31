Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A0C3DA64
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 20:23:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.67])
 by mx.groups.io with SMTP id smtpd.web11.52697.1722457390488419862
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 13:23:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=kPCBKCtg;
 spf=pass (domain: renesas.com, ip: 52.101.229.67, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1firtdC/UysRXik8N4ZhedqjqH+7wsdNjowrbYdm3HpT46vAskEMRHByXvek/KxylGKe66ufMY5WQOqQmcDxOKwswOIaxyUtaZ2f0kyDSWxO70UqJQ8ECu2V2TrenSm2b9UUvIFUlvneGjjS3uSk5yi+6F3RXf4GnX6qrRNo24/t+qMwiKxK+evSw0lddyWL3iEm1msa4vRdUca1k51rDIMbiLCHvCfut8/E+/0MOP6poCBG6z927Qa1ANJNEC6uNsekViEHOpwHFFjuhM4VPNj5OOPJFNFMUVuFoF+DvzFUHNhnEGpuTSr1kSc+Pf3G3XQcx68V8a89O4h/0BrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/msXrDvl2GSM0O1+zwcNlGZ0iDrrtoDqSgr7oFq2p1Q=;
 b=CGjzi7l81K7b+S7YXKfCNm5GMnGsYvhJiNCVjBX+72YhgYIUmz7hFVpOt3DLoiK4PSpO38a1plRczNWzUbxgBk7/H4qsyeJjr04KtfiZQbqNEI3/0sPf9LZy+9mKEFacTF5kVZF8aAOVxIUD6ayTyCRCPl+bJo+2/mCmXTugPJfgix/mKi+dbj+QOOUh+FzeVos9nmI5JU1nEj8Xc/seMVz329F7PwOHCahPTJY8M/xSh0oF7U2NL8HEt7BjcTETMVo89TpCtw/FIAdgyG3cacW+Dp3k2blk1ThqlYMBiSiVFd9FJBp6rrEw0Ltrwg3odW3uCE8A7osc3JmuOLUSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/msXrDvl2GSM0O1+zwcNlGZ0iDrrtoDqSgr7oFq2p1Q=;
 b=kPCBKCtgw3Cj9mG5KzTB+/23owSQV7tB0RlEK3d2I8Sdu13MZqWIwOVZ9Kn0ak5sbtZkACaUN5qDJzfsc1FanD9+CfyH+HtLr2anqf1cV8MHdt+h4gXCBR3HP9W+/odXqQ1IdShz9mxeIP72lXXolCiHRwvSRjKkV/kk1FhtXJg=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OSZPR01MB6245.jpnprd01.prod.outlook.com (2603:1096:604:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 20:23:05 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:23:04 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Something wrong with gitlab-6.1 testing
Thread-Topic: Something wrong with gitlab-6.1 testing
Thread-Index: AQHa4xaFnWfFEUHYe0qP0Qb+/mV2TrIRCJQQ
Date: Wed, 31 Jul 2024 20:23:04 +0000
Message-ID: 
 <TYYPR01MB124025E975C0221918222F46AB7B12@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <Zqnfq6ZqUiZbTAT+@duo.ucw.cz>
In-Reply-To: <Zqnfq6ZqUiZbTAT+@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OSZPR01MB6245:EE_
x-ms-office365-filtering-correlation-id: 9c5b4334-f66b-445e-57b8-08dcb19e956a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?UV+TaHyI93r3XLBdwqkUCPPthVdEI2JQrwoSx+2K7V16hyr/TQ40E75V?=
 =?Windows-1252?Q?ty2QAy1IyJ0pq1C73JqMl3+0dZxE93xPw2qL4fNLirj2ZjL0MhL2wwRx?=
 =?Windows-1252?Q?KvFi2AbrPkxH/mkVFg112d2J9EmpmrGQQ1eu17HhQY2IzH4nhklfPAsY?=
 =?Windows-1252?Q?8tGG+dnaQYcRid69TOOBO01kj9UJHFyLNqfU2uLcRPkPZMEgR0bdU/vX?=
 =?Windows-1252?Q?um9Ur9Wl2x/nGliqS8brczc3S+myEYkND0ireB7DYZ4cOD2pxKG6GnCk?=
 =?Windows-1252?Q?PAX7MoxE23Y8DVrsR6cVCkyCJouzbIWyfwMBQVIPnBDoWFF2Yxe4n3OG?=
 =?Windows-1252?Q?68oHO+XIbYGw3pUDKl5xwc3/x176FUntq5EOrsoiyv13ElH9KG1vEdw2?=
 =?Windows-1252?Q?QaA11LPuPbMSu8qycPUUYEdHCw+bUDtJ2HBtPeFJ5RutstEqpifqc6JU?=
 =?Windows-1252?Q?coibMDh+AwDMl6gef90s2NlOq6iSOmQ2+31mk5xWmIdHbu380JskW4U9?=
 =?Windows-1252?Q?yN0yxdqa7OfGSN0syUR/QTx4BDjgOZB5Bum9c2yuPFBPJZbFr7TfpHjh?=
 =?Windows-1252?Q?9dctTGRzO/xBloQUZ9hafIdcwiW3gptnY0NihDeDLDV27QhAE3fE1vo/?=
 =?Windows-1252?Q?4spxt5CyqFMFus8YW5+uzY6kFnO7TA3QL9IkpNBq2YK+uVLkvToqxcUS?=
 =?Windows-1252?Q?6N6bg1VlcKRMI6BT0S5WuNarEKwMI2cL9CwJcFol9/x7tw4X4OHg3C7i?=
 =?Windows-1252?Q?bQWtHB13rZfITnrzh8ac9nvYll/fOYLFFZxBSkhegGx3s52i+LyT3FCs?=
 =?Windows-1252?Q?M5T7PLQ9G10kcBW/jTUQDzLiN0IkjoQK8rURPgCJ7usbnaYkA9dFEqvg?=
 =?Windows-1252?Q?pWgF4k6shRXBwDrWV31VYCII19eaDTadYI9Adj2YqQoCQvjAW/aDoy/M?=
 =?Windows-1252?Q?RYKSwTfZ+jPAXeAfrABc1nBTj98QJ9I1kvmL22eLzbDzoGiXKO6zCNtW?=
 =?Windows-1252?Q?asumnC7arcs14hiFtjKIYL9AjAqL7v9k71cUVtIuY3eoc2fyP6gHJqjm?=
 =?Windows-1252?Q?tzuznEkeALlxTVFlbdfOYEmvH77xrIMYcg9GjastP6tdF8NBzWJEaUcM?=
 =?Windows-1252?Q?Y9r0eGz7qRoUDa2DdFfoh3sTSI5J0zfPDoVlOlxdI9iv+Oc2P7blDktf?=
 =?Windows-1252?Q?I55WsOd3qLroecxm86p8t026yAFg1QJXjK1BsOXjNKMwg0rbEuq1jD1P?=
 =?Windows-1252?Q?sBcOnTtjsqfiVzAjJlR432hFj1LZLhez169u6BO+JBy4cXJz7SB8rzm2?=
 =?Windows-1252?Q?aPh02sqfcKDiA8EwCUsxiENp+9CtmAAlYOqWx79YZIRLIFqNTnWyfTYZ?=
 =?Windows-1252?Q?kqxUp0CH7TjWKgmdLuYn/QdC11aJV6KV3yCrIJCiNTzctulcyFGCXI43?=
 =?Windows-1252?Q?EiPrgc67mrIJOW+RJIeHHjAhsvri/TJsg1GnKYh1U1o=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?EZ4JP3mO1xgMT76YV03nIVW3gRiHshOC5ShuN76E35CPRW8FO9R3ixgW?=
 =?Windows-1252?Q?0CC+fEwjnLv0LDUVSxddzWdPTNcxJRNxd05C+8bO7+4w2W3mB9/nzKUX?=
 =?Windows-1252?Q?mvvujHfSwUc6QB7jTLbcGac2oQZh4Bwtrk1pbVVF0QSlw9QjM3vLtSvG?=
 =?Windows-1252?Q?uRHgG80Yattr+tIDQBOIepy/2fpBELRopKkv7lTgNK4VNV7cfQnggu49?=
 =?Windows-1252?Q?ZDPCDCEr2tngYRDgcOPwAFT0BGwYch5OuliVKGiZK8b7/gFgqBrosQOu?=
 =?Windows-1252?Q?59L0ihMbCob5z3lGGHPLOeajUXsBKaGHBZL9swyJxKiaWtxGHx6cJ4hI?=
 =?Windows-1252?Q?5q1dOAmGzoV5Q7FoMBLjDugIb6v+/7VTWnAG9AJ/G8TO/NoO0rvFh+VD?=
 =?Windows-1252?Q?k1EKm142F5/Zq4EUNDAfu622+bSBlA4c1iA/FS2p8gl/2l49bgY8XXob?=
 =?Windows-1252?Q?eG78QLPBOyaXFI8z1RALadSSQLhehnNxzpNRtvIdTkRW+uVzoWmCzFKT?=
 =?Windows-1252?Q?C6L+ymIdlSqoeYS1ueIVZd/PZJOMf1r/d8rlxApBzkIRrKpk8LxT+INA?=
 =?Windows-1252?Q?pkBGaGk7mAGkto4o6f3FzwgdTBLEJuEjkpRGmPqyV+TfkSAByXfLEJ17?=
 =?Windows-1252?Q?DtxYK/W0VKnQHkrNCT9v7njVYZVh8XH3zRo5FUdWAG7qDUB4XxyrzaER?=
 =?Windows-1252?Q?wW5naFkvfuJ5L0c8JgawcwyUTqoSpZOW+QrOnDmOBr2xfLSXcRFIKUPY?=
 =?Windows-1252?Q?jgIiiaArslbzF5REHacuMKBIM8VytaFmBmAk2eC2enDvAzFXIFQnP9vj?=
 =?Windows-1252?Q?+cT1En8iSDz5gwHHxFM3YdHpJ89Gn92GJgTphbb3jV4PKtxiWvFYwV2R?=
 =?Windows-1252?Q?0lHOtLGJVKZYd/F5qAXQgbPxNZTbLwih77jaedcV+SjyMvW3S3SBMd4I?=
 =?Windows-1252?Q?0MKYr2/rtKXY+e6tkQGYFcGZ4by06fphPytFLU01IyntSPn3KjFLfoMC?=
 =?Windows-1252?Q?IGUvV0GmV61ppFz5xXDRfWqLNJFOyQG8FcKLdn/Ct5xVUE3olVPZ9s8K?=
 =?Windows-1252?Q?JfpaF50AecocgE3lWKmMBCRWSBDxPnuxjYNpvWk9VgasXAuFD/a8GG7t?=
 =?Windows-1252?Q?pipEQrZqwaJ1ee+rjucCaFXpJGcmsxa9e+g91AphqSWwhNFoW4XZbaz4?=
 =?Windows-1252?Q?stnVFOQHxT7UmBl/AWht04SPdFW/5OqYvHHEkIBwXewpBFyl6gO88Q8m?=
 =?Windows-1252?Q?QkMa9gWnXoXlHiVam5MfIEwMqyWqM4Xt2dEAy/d984xq/i/kA2MRFIwc?=
 =?Windows-1252?Q?QtYqavr1rOHGmNErFMALGY+T2jkWrhecUccu4+og2gIcbj8CM9Fidh+O?=
 =?Windows-1252?Q?7hEVwUJ/LRTIfAE8sqhvEaTIF+Gs040/d6HXDVah8NIGKJDDVO2HYgs9?=
 =?Windows-1252?Q?QJ3Op5Zey+a6MFoeVSZAnHeHkVIQGVL31f/IZd7iVF5lGH+V5bxiOJNB?=
 =?Windows-1252?Q?vdQn/XsHmT1qxOnpmpog0AzEvEIQjJ/53VyMLPHQdrm2+5YzCamnllTF?=
 =?Windows-1252?Q?dIoR00DmhrQ3ilosPjgcGidg2o7n0ci7WGH/1SooVJIf93qYzVmm3AJ+?=
 =?Windows-1252?Q?jnGb0lrf/OygBbB6l13KiwCmOuSuDNFRFNs6m2/qKfd03/cWDFGkQ6D0?=
 =?Windows-1252?Q?Kr+Oz/XM0Yj8D+aZ1pNy5rGAjXV1juPqq2hL8KtZ0ni85dACZWA5FQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5b4334-f66b-445e-57b8-08dcb19e956a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 20:23:04.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KACPdM151ukZ9NJo7IToFjM0MEWYgc9H9akbTyxhjAqNooqPxUfD0MWSoyHvcAQdmnGV6Ug9IJ017DOuTRqCiKILqSQMTz6r61NTafKqJ4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 20:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16699

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, July 31, 2024 7:55 AM
>=20
> Hi!
>=20
> Example can be seen here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/7467016656

Thank you for reporting this issue.
It was caused by the recent addition of 6.10.y configs to our cip-kernel-co=
nfig repo, and our build script inadvertently using 6.1*.
I've improved the script to handle this better now.

Please let me know if you see any further issues.

Thanks, Chris

>=20
> + git reset --hard origin/
> 264
> fatal: ambiguous argument 'origin/': unknown revision or path not in the
> working tree.
> 265
> Use '--' to separate paths from revisions, like this:
> 266
> 'git <command> [<revision>...] -- [<file>...]'
> 267
> +...
> + '[' '!' -f /opt/cip-kernel-config/6.1.y-cip/arm64/renesas_defconfig
> /opt/cip-kernel-config/6.10.y/arm64/renesas_defconfig ']'
> 277
> /opt/build_kernel.sh: line 169: [: /opt/cip-kernel-config/6.1.y-
> cip/arm64/renesas_defconfig: binary operator expected
> 278
> + [[ renesas_defconfig =3D=3D *.config ]]
> 279
> + cp /opt/cip-kernel-config/6.1.y-cip/arm64/renesas_defconfig /opt/cip-
> kernel-config/6.10.y/arm64/renesas_defconfig arch/arm64/configs/
> 280
> cp: will not overwrite just-created 'arch/arm64/configs/renesas_defconfig=
'
> with '/opt/cip-kernel-config/6.10.y/arm64/renesas_defconfig'
> 281
> <!DOCTYPE html>
> 282
> <html lang=3D"en">
> 283
>   <head>
> 284
>     <meta http-equiv=3D"content-type" content=3D"text/html;
>     charset=3DUTF-8">
>     ...
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

