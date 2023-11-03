Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A3C4167D
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 09:12:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.44136.1699002723319694465
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Nov 2023 02:12:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3A39C0xw1168422; Fri, 3 Nov 2023 18:12:01 +0900
X-Iguazu-Qid: 2yAam8fxyV3mFfYUxU
X-Iguazu-QSIG: v=2; s=0; t=1699002720; q=2yAam8fxyV3mFfYUxU; m=SbCY8KeEoAcNaafYv4lL1o+Rl41mg9McGt6kz+vYlw0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 3A39Bxpp1041841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 3 Nov 2023 18:11:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn1iZQYyF3J/ft7i8GF9K27cLk8Lb1Dt/9XUODaUwOQDUptsCXPCU8PwKtfyehrZpDIKpDtlZESaF/w6YjskTpCRv/Mcn41x7Awb4pLjbSadQI7bykwLOQ1B21jB3bLm5C3amIc7D6DYYnlLExp7UX5tnOQswo9N4008ipO9mT/C4llbpiVKuvswt7ZvD1W39x00I6BtiL3ipOKGrO72Jy+m2aPjgMRVpjIcimgh/VXrDiiZmrPw1B3gFis4sWO3Xg6sRdoFDPsHs9zbOQGaJ+F5QL0cpPyEYvE8mCtogjtzax87vWQHxGIldjkXtwafoR2oAIN/GQYekyuVOAIi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsHEY+PaGuOEufeE82KFTxjN3RBNCKLrega4eJLVYkI=;
 b=KDJBFjVc3Pw9RQc3l+dD6AiBQujq36kNlScT3rt4+aBDkXvGsVCXK5AGrEFGKuoCj8P3sG43FAi4+IkxhRnr6iCwLN4A5jS3HwQr5M8QqUv6ZQUNtdkKFWPm+LQSXeRKb8S7AXPCAnUsU5S2W0joS8fPkEoTYQsJTPSZKmwBerfuNw2/NTLjLll/MVrxicOVsuJbbldR7TmN2xIRTYR0Nk3n5HDB8VrhFuaCtiW9yXGuUapkr9GMVRt3YQ5EG4nnxSM091CjD/koNttfDLGX/KxJRrUU1c0/8KQFJGRDfoBzkl9geUnXqc9gZ/Rg/ZLztHfpQ/oVGpt5f/TS9qMejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev][isar-cip-core][RFC v2 0/9] cleanup of customizations
Thread-Topic: [cip-dev][isar-cip-core][RFC v2 0/9] cleanup of customizations
Thread-Index: AQHaC9c9+LIbKCKSNkqQiE7T6S2y4bBoU7vQ
Date: Fri, 3 Nov 2023 09:11:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6856197D0023695191876D9CA4A5A@OS3PR01MB6856.jpnprd01.prod.outlook.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6856:EE_|TYAPR01MB5835:EE_
x-ms-office365-filtering-correlation-id: 81c8d332-bb17-4e07-0564-08dbdc4cee12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TMckpBKrhR+QOFlaDX036rvEqOJII0nyuGf+07pM6fbx2ve5fhxP79lYLSP1UATri40k1MDX+OtxsHMoMioNA0XmmErJGE6JSKea3WME0a6umFmyTFYklfsS1IZpMTfS5s+5jbzpQ5ifS3WyN89XMBfaF5mwRLCLe7VlEKENRa6dlRrxil8IDp6QsH9UPGJ3D+wdBmsUhzipU79o8hmj69xcNP8HG7vKGPMX96CBsSfMvcM04JGhq68lAQ0+HNF5EF3FY6sFm3RKbi0yTGqDn8rlyPYsnt9AMWA66eb8iHblVoEoyOAOGb3vAspKYptUIk5S9WElGo73HHf69xoJsIYM+aUv0h//nI1AmaeHcrtuCnxvW2i1HZ6l3zf/IpuSBSOt2iv2Km3ipj+xwF8WDFONFRPy+FH26IdR2RrMhEtpaFP8SdFVFDhGd834gw8MED1xS585q1pbDPjUWOHF36u0JTC9L++/hvEGynL1XCC7d35MXvrcgygRg7DJCnKh8GJFh3NZNTyHkdNmPEMZNuw+j+/ucJKlBZeaboVjPngvOzibcB57TfNcWq4ZKwfcAl3s4Oou00Ub3a4RNlh8j6Ff1/yagCEj9A6kdLocyE58MWR8l48J0k2S5vPlyuoW
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6856.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7696005)(8936002)(38070700009)(8676002)(55016003)(52536014)(316002)(66446008)(66556008)(66946007)(76116006)(110136005)(66476007)(26005)(41300700001)(64756008)(38100700002)(5660300002)(86362001)(6506007)(9686003)(53546011)(71200400001)(122000001)(83380400001)(2906002)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RjF0K1U0RlU0TTRUd3QwT1pZeDd5V09LaVVHNVVtdTR1Ty9FZ0lxTVVm?=
 =?iso-2022-jp?B?R25tWFhEaDRkcE5wQnppNnA5N0xDdDBmQXMwSFlNdkFOUU03SjAzVFBw?=
 =?iso-2022-jp?B?L0xWUTc3TGtBaFQxZnZMaXVjUlFpSFRQRVBiOWlITWppdHRZUEZUQWs0?=
 =?iso-2022-jp?B?N053ZFZRSWlJZEdUTUFPQ2dsNDFENm9KWkZlRVlyRStDTTc1cGxvUHRN?=
 =?iso-2022-jp?B?c0t1WFdYUlJtWmI0QTBqa3IxMTFjUitDWXdkeHFndjV3eUw2cm80d3I4?=
 =?iso-2022-jp?B?TThxSmFBSU1QUW4yM0hYWXhYODl3T2xvT1BKeUJoQkdYcGxQMGt6dHk0?=
 =?iso-2022-jp?B?WVpDeUtETGRvYlo1WnJsWnA4OWhpSk9zNDBEaVhrZnh6ejlhMjB1ajBP?=
 =?iso-2022-jp?B?VjlBNUdIR0Y4b2NjamlzVjJHYUFLQnlqRS83N3NIQXFHMEZ4dEIvU0tJ?=
 =?iso-2022-jp?B?cGpSckRYS2JnR3FKanMxejV6dDl2TzE1eEF3bDRxMVo0OWorWngzZ1FQ?=
 =?iso-2022-jp?B?czB6UkdFQ29PVE8rL3ArcGYzQXJCQ291bjRCVE1EdXRkUW1QVXFqVEYy?=
 =?iso-2022-jp?B?Ny84WStQUm5NN29RVnN2NGV1OWFYM1pSQWFBUENkaTlOVkNndDZRTFRj?=
 =?iso-2022-jp?B?a2pYWS9DanVrQ3ZRMlJJL0VJNkxVVWkzY0piN2dTQ3ZSQXlqQzFTVHh3?=
 =?iso-2022-jp?B?N0ZtaER4RktjbzBMOGU3eklUZytGNG9ZRmJ2QjBaV2JRTkY3cVNuOTl4?=
 =?iso-2022-jp?B?RXNlOTNZdkgyMVlmcW9lMUJDM0dEYjk0SlFudUdRNG4yTUI1YUxBaXNz?=
 =?iso-2022-jp?B?c3RjbEwvZnNNUDFZTHpwNkt3TnV5YlQ2MTJtYzZRSDR0T05tczNBa0hl?=
 =?iso-2022-jp?B?MWNZcXNKRTUyVGxzNldxamZpWFZmSHRWNXZmYlJGS2xGUmgxSGRaMXJV?=
 =?iso-2022-jp?B?WUEybVZuRmtzcncxUXh2enh3TjlPOXg3VGNJTkhwVkdvU1ZMeHE0Z0RK?=
 =?iso-2022-jp?B?L1FXYTZXMTBmTDl2UytBU1RxVzl2UEFrRE9rS1lhbGxHWVV0QlIvTnha?=
 =?iso-2022-jp?B?SGZSTDRyUklvNHNtRTU3Vk0yRlVqVVUvWW12QkpaWVVJWjhaMHNjZzB2?=
 =?iso-2022-jp?B?QjlEdExoVTZEdzJMNVlpZFdXbldnR1pqY0JLSVp5c0hyN3lkWkljRE9F?=
 =?iso-2022-jp?B?TUl0czZzaDg1U0dlT25lT1ozbWlaN0ozUHZNVTF2MXpNbTJYYzBUYldZ?=
 =?iso-2022-jp?B?RWN5Nmlzck4zOWNCMThjclNFQ1pidWdRelozdzBONzFONkJIR1lHendF?=
 =?iso-2022-jp?B?UG9hcU5WRWJOVE9RMUx3WHdqVUpyOEl3VWdicXFQTTJqZDRGZ0VBN3Vq?=
 =?iso-2022-jp?B?dW13TjdpUUErd1RxZFMyQmlKWkVLdis0MnRXT21MMDhMdTRLSnpPRzhZ?=
 =?iso-2022-jp?B?UUs0WWZkSFpWS1FwYXgrMHc3cnEzVHg0eEFsYXpJY2xpczhFTFBYYThN?=
 =?iso-2022-jp?B?c09JTHZNRzV4a3N1dXZPU3BJRCtsbWRJK1FRUWFJY080K0hldHJsRG9L?=
 =?iso-2022-jp?B?eFZqSUFzcmlDVC9nNDhNY1BQVFVKSkZrM2tFRjB2dndsQ0h2V2UxeDJD?=
 =?iso-2022-jp?B?bjVsMVZUN3l5TFFjY1pMa3pVQlg5R1haZFp1Q2U2blgrUG1Na05vS2FX?=
 =?iso-2022-jp?B?dTZwWEN3U1orVndVT2ZaWUJUWEFZbVFwMDdNTHdQenVROVcvUjdaR3l0?=
 =?iso-2022-jp?B?NWhjbGJKQ000eXhSekNpVFlSekFaWUtzbnFHRFk1bnV5WTU3R0NrK0F2?=
 =?iso-2022-jp?B?VjRpR0t2SGRaeW5iZUU1bUx1YVRTQ2NJOFNiR3J3RWFYUEZSYWVwMGRv?=
 =?iso-2022-jp?B?Sk00WGVBVjhlVHgxc2tXY3BQRlJFN3JhdHgwY0wza05ORXBsWHBKWE5h?=
 =?iso-2022-jp?B?VktZM3V0eVFHSEVkRVBFLzNGMHZPeVZHUlRsNWZGSitxTzkxNlk1Y1RN?=
 =?iso-2022-jp?B?Ym1xaEgrOUlDRm5PLythbm94Nmwya0prWVBwNlB0djRZaTAyQ1dGMEI3?=
 =?iso-2022-jp?B?ekppTW5TdHc1V2kxUTZCUG1PamdpeVBvZWIyemRJSVlJUllUMGYwMkpx?=
 =?iso-2022-jp?B?NEVMR0cwaERKanM5cjIwNmhUNTNxbmk4QXplcTRrUTNZZDVwK2ViUmFJ?=
 =?iso-2022-jp?B?N2Rrekd0WDZFbC80cU1DUElwWmthWkQvcGQ4ZHZvZU0xMGMzRkRwTmhO?=
 =?iso-2022-jp?B?dmgyekxyNVFmajBEN1ZOdWpGQTRPMjNyZkpzcjYycmd6WHBncnN1M3Q4?=
 =?iso-2022-jp?B?Q2JhVjZ3U1dpQTgzZFdlb3ltbWZCajNja0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6856.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c8d332-bb17-4e07-0564-08dbdc4cee12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 09:11:57.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i10XFmSFYY44bWQx0YThyfVkIkXBHkH7o/kRDT1kUQPtulSytHaa37CRrPqvvvAAxOyym157Sc5aKZJ71H2FjE9zI8TWg5oFbMMIxbHrrYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Nov 2023 09:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13531



> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Quirin Gylstorff via lists.cip-project.org
> Sent: Tuesday, October 31, 2023 2:08 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; pyla
> venkata(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Venkata.Pyla@toshiba-tsip.=
com>;
> dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-
> tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-dev][isar-cip-core][RFC v2 0/9] cleanup of customizations
>=20
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> cleanup the customizations scripts by:
>   - Move the ssh configuration from postinst to /etc/ssh/sshd_config.d
>   - Move systemd service overrides to files instead of setting it in
>     postinst
>   - fix formatting
>   - fix scripting error in security customizations
>=20
> Changes v2:
>   - Remove explicit installation of libtss2-esys* as it is required by
>     tpm2-tools.
LGTM, I don't have any other comments thanks.

>   - Add note about used style checker
>=20
> Quirin Gylstorff (9):
>   scripts/deploy-kernelci: Format python code and remove unused import
>   customizations: Add variable to set the HOSTNAME
>   customizations: Move ssh configuration from postinst to sshd_config.d
>   security-customizations: Add dependency to customizations
>   security-customizations: Fix shell error
>   security-customizations: Extract sshd config from postinst to files
>   cip-core-image-security: Move packages to security-customization
>   customization-kernelci: Add dependency to customizations
>   kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
>=20
>  conf/layer.conf                               |  2 ++
>  kas/opt/reproducible.yml                      |  1 -
>  kas/opt/security.yml                          |  2 ++
>  recipes-core/customizations/common.inc        |  6 +++-
>  recipes-core/customizations/customizations.bb | 10 ++++++
>  .../files/{postinst =3D> postinst.tmpl}         |  8 ++---
>  .../customizations/files/ssh-permit-root.conf |  1 +
>  .../images/cip-core-image-security.bb         | 12 +------
>  .../kernelci-customizations/files/postinst    | 11 -------
>  .../files/serial-getty-kernelci-override.conf |  3 ++
>  .../files/ssh-permit-empty-passwords.conf     |  2 ++
>  .../kernelci-customizations.bb                | 18 ++++++++---
>  .../security-customizations/files/postinst    | 24 ++------------
>  .../files/ssh-pam-remote.conf                 |  4 +++
>  .../files/ssh-remote-session-term.conf        |  5 +++
>  .../security-customizations.bb                | 22 ++++++++++---
>  scripts/deploy-kernelci.py                    | 31 ++++++++++---------
>  17 files changed, 86 insertions(+), 76 deletions(-)  rename recipes-
> core/customizations/files/{postinst =3D> postinst.tmpl} (62%)  create mod=
e
> 100644 recipes-core/customizations/files/ssh-permit-root.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/serial-get=
ty-
> kernelci-override.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit=
-
> empty-passwords.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-pam-
> remote.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-remote=
-
> session-term.conf
>=20
> --
> 2.42.0



