Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5818EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 01:49:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.2494.1689644981181750029
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 18:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36I1ndZA4083729; Tue, 18 Jul 2023 10:49:39 +0900
X-Iguazu-Qid: 2rWhW3wiOWV8xcbtzD
X-Iguazu-QSIG: v=2; s=0; t=1689644978; q=2rWhW3wiOWV8xcbtzD; m=Mqyamh2xyPY2CCrZSDhp3F6/j6NWsmJASlAs3ZWO2GY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 36I1nbBH2467248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 18 Jul 2023 10:49:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwcyFX433xMztx2dW3PsKUZCBDgJOqyGbG3LgPX03Zl8Vq7CR5IPcHflz6PW4AfF5bekHF3gSeAwrkNgVa979ru3OX0E8q+ZA9onRJuHq0clyMgiwknGP4O4Pdwv4/TqqakqPCXK5DZLCkmup31hLSCamdDnkSHxAJOFOKFi+u0owtpCv9nd1pKEPgN0VO825QXmamUWEuyk0c3iIlas6xTjTO5T7u1h+Wxi5OygYaU/QHaGyTJRMbwS1kiXraesFtsMY07HHOXJTjXNoRYaHUIKUpNdPsdaqbzvoeT26Is9Z938k0LhrJBJzuNqxU7y+kJvEu/93P1TcluwN4CBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZKLgFLLN75VVE5F7YAc/Xc2BXzIHC9sLbvOvaP6nX0=;
 b=RzL7KYMGdE9COYkNq4hD4ZirCHGgDu+34Bc3TXPsebjBIC7YOUB1hNrmhBhpjkodO0yNHYFvt0vTA+giAwKWwLcS57K341J6RQAfJkYAXyt+lgIt9fmNWU0+jI0lTUn5vd2/Bw5OGsuwRk0yABK87I5pGryQeKh+9qDBXizjSsO47imGvtFMw83e0KsqXrgvVL7GnpH/A95xkxyoY6HRDVoJQ/rdj4uxuzYUWU/N3FTJeaX8SxT9QSo6M96Hyu5Wvqh6O7XmhqAi4+nzlsFOK7CLvuT4H/pitX1cnWI5m5MSRcSdsxs8zWP/5MCX1EYznwd0xJwcreCSkvZhXt+x3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add support
 for access control lists
Thread-Topic: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add
 support for access control lists
Thread-Index: AQHZsvQL8eUthuDB/Ua931skGoFdfK++zjyw
Date: Tue, 18 Jul 2023 01:49:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420F48913E71CA393A6194C9238A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230710060156.10348-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230710060156.10348-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS7PR01MB11836:EE_
x-ms-office365-filtering-correlation-id: 5c8fa41a-8a08-44e1-73f6-08db87313dc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sceOyc8/2IyU0reIy7P00W95qItoEOqxUTapfAKA1KHlQUpcWox3G//R5eO973Dxql0EtxcjlJx2B7EzYV+V5JiN3biZuVt/54gqiCUFsuwf8vswxI8lek0x7he8Z/u7js/GmKapjtXuq621jMayNBskNu3feZOrRDcdGLrPFyoZZG1iGxr9RNO7pSUOFd841lsAnHbWVWRMCBJ7IbL/9MJrr5FCJ95uhxWaoy5isfv3YVjExxJdZzZYIf1W6NKKBqIUmNa+6MIPrY5E7ZKBMwEyj2moBwpOcKZmNSfpKvnfiGDVLElq76o/JxgFbIfnEefBF+OdXIG/Dr/s/gHqcK95rqh7t9UL3CY/IWV2+i+fmkPa3lWQdErEVgHjLRk6B1qPigFGclYH0adAljYHygiOJ0tIgMh5Yz84MTNGYd/KHAf35wrH4Fam6DVXDAXAuN4kzZuQBYL+2Qn335K5McXxjHUYybiNP7wApD7HG3YaV9hlrRlx6gpeDmJF1xPRQ4McAmf+dzP0W5r4v5lIm6RmRJ5sDOYWM9XdPL6aQ1NX6P9yp1EuP5+izOuPlh62evaRyENG7vqeVsDbM70uRclgKw65viBlJlt4nUz5OQzFKkVPlh09ssjxKoevylePdEpGdUJ5gmWiNBeapZMKyw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(478600001)(71200400001)(186003)(83380400001)(26005)(6506007)(107886003)(53546011)(9686003)(55016003)(41300700001)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(33656002)(4744005)(316002)(2906002)(4326008)(86362001)(7696005)(38100700002)(110136005)(54906003)(52536014)(38070700005)(8676002)(8936002)(5660300002)(122000001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VWlnclpsRnhYUjh0Z1lObkVGWHJiSlhQeGp3ZUdoRzQ2enE4bjZLNjFP?=
 =?iso-2022-jp?B?cUgrSmFLMHZ4NWRzMkdOUERDaDVYQk9vYXRhN0kvVkhvUlprS2Vobno2?=
 =?iso-2022-jp?B?S2pWU3NpMjROYVZuQlRhMUg2V1plbmdNaytwYnNtWHVPQ1E4Z0RTRWV0?=
 =?iso-2022-jp?B?MkM5ZlN3RVhGMkhIL3NDRFJxVU9LSXBrTkdaL0JsVml0b3V1T0Y4cDkr?=
 =?iso-2022-jp?B?akZsaUNjeDUyUXJEUkxpZXdBNjVxRnZRUm9xZk1wb3ZyVkY2OUlmSVUy?=
 =?iso-2022-jp?B?bGFuODhUa2FBOEg4aDlDM3BseVgyd3VHYlhXSHl5NVZHUEMraWlBMDJC?=
 =?iso-2022-jp?B?YkU4ZVhLVzJyT0o5S2lsMmU1NWN6MnMrODRiQjgrbzdybXlERnNGMDl0?=
 =?iso-2022-jp?B?bVVWL1RldGw4QjQ5ZFlNSytjR2VCZ0VRbGRScTZYUHI1VEFhNXJhbGNI?=
 =?iso-2022-jp?B?Q09YQ0N2M29EU1lxeUpsSnkzenJ3VmgyNkl6ZEh5OVBwTFJ2Ulh2ZUdX?=
 =?iso-2022-jp?B?OThta1E1QmtqUVZjNUN5RHRrTnI3NVZmaG56RTV3VkdRU29xWlI2aUlS?=
 =?iso-2022-jp?B?UzdrRW13NVJscUNpeXBrTXhPWm9VTWRxTU1RV1NZMEJrNGtRVStvdXZK?=
 =?iso-2022-jp?B?SldUcWZ3OEcrcDBxbzU4dWg1b2lpS0xyZUlGcUpnUGlTYnVrYXI5U3VG?=
 =?iso-2022-jp?B?MDRyL1g5TEFUM1NhU1p2U21qWWh4emxHUHNQQ0lOa2d1cWNjR2grR1hl?=
 =?iso-2022-jp?B?SkVoZ2RaOWdVMTM5cWhNaTU0Z2wvVEJOUnZUSVczaVg5bDZFMEpnOHdU?=
 =?iso-2022-jp?B?WTZ4eFM0cEhuUWJlL1kyQTY0YzhFcS9vSjExQWJadGZaZHV3QitxcmRw?=
 =?iso-2022-jp?B?cDJSVU8zSEJkTnhaRTlZS24xSWhBbDBROWR1bEkrVVFJbWYxNHNHWnc1?=
 =?iso-2022-jp?B?Y3MwaVU2QlptbXkzMndzSW95bS9mSVZXK1kzWmRjN1dmWVY3ZDlpaEVS?=
 =?iso-2022-jp?B?Zm92TzZza21CY0ZySlJXS1Q1K0IyOE9HRlNIeWhOcFVSQ0FkNXY5aVYw?=
 =?iso-2022-jp?B?Z21EM1dEUDZxRzdlQzJVRkl3QWk1OFVuZ2RBRlBVYW1IMGdoM1hBRjU5?=
 =?iso-2022-jp?B?WlFTanZtWWh2eXdER1VkRU5TaGlVOENkZFlpb1pkWUc1Q21QN3BLSnNl?=
 =?iso-2022-jp?B?aTR1YUE3QklsV1I0MERnR01TbnNPRXhFOEx3TjVPZzh6ZnlabEJFMWwx?=
 =?iso-2022-jp?B?N1VvcEpUUUZVUEszaVhybVRZejJxSml1RG1EKzE1K0ZXSDZrbDU4b2lD?=
 =?iso-2022-jp?B?QUZsVDlzLzNlTmwrSThpRUtmM3Q2YzlkVDUyTlBDSjVQYTE5bzJGbnJY?=
 =?iso-2022-jp?B?Tm9zWU9ObTcxcmR0WlhuSk14dnFZZFNKS29qemhnc3VqbFA4dmtEMm9z?=
 =?iso-2022-jp?B?a1YxVWg4Y2lleFhZQ013dmJGbUhtRmZ3cVpyUEdxWDQzWG96Uk5HOUZo?=
 =?iso-2022-jp?B?LzU3MTZ2S0xMdFREdmdFZHJ3a0hzQnJJNnNPQnVHZWpVWEdKWk4xbW5P?=
 =?iso-2022-jp?B?dDNRM0JsY1pIS0VjNTJxMEJHRXJvZTZFdTdYK01LekVQUXFNM05aRHpC?=
 =?iso-2022-jp?B?bjJCSXRBUkpZTUlJaU13WjdGNGFJeUpKMGNQaFZQeHBGSi9rSS9udjNk?=
 =?iso-2022-jp?B?VHFuQWRlUUpZb292WUx1d1IvWmRNNmNGUzVBaVNnTSthbEtnbElmZ0N3?=
 =?iso-2022-jp?B?dzdPd09HUVRHV1FwZ0tvbDZCdUlYalk4Lyt1elhrU2NDTDIwN0NZVGdX?=
 =?iso-2022-jp?B?WUNha21WbVpQWUhxWFp6MUVhWEFHc0lCZ200eFc0YStudDlNdm9BWU9S?=
 =?iso-2022-jp?B?aTRHd2h6YmVja2xYVVdjdEhCc3h1Z25RM2lrdXdrZGF5T1BXeHNOZU94?=
 =?iso-2022-jp?B?L3cvclpxVm00c0VaWVUycFc3S0I4dW5mMUVJaVFrRzkrTUJDbDlTUnZw?=
 =?iso-2022-jp?B?dTVYRncxVUltMnhBZTNIRXkydmNuN2NJRFpadDNPNmxtRFdjcnFMb1lv?=
 =?iso-2022-jp?B?TFVrd1A5N3lZSXY4Q3dXWE1iOW9tUEpuYU1NSHAyYVozSEFWSzB5dUhs?=
 =?iso-2022-jp?B?SEg2V0h1aGd6V1RpcXJ1My9oQUxZaCt4aldMYk9JbUJ0a3NaZVBpcTNM?=
 =?iso-2022-jp?B?TlR0UFEwTFNDUlpERy92NE9FcUxtbzNyTjNtY0JNTU5IOUcrMlllR21V?=
 =?iso-2022-jp?B?RHNnSHM2QkVpZXdjME5zdzllWW5iR2ZITm5oL05BYW5pL3ZkWisvdHcv?=
 =?iso-2022-jp?B?QWZsQ1pRNDRORDgvSXJJcXpWbjhVVVpDY1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+2lmhrrOp7WtTUnKvq2VXpTNLTdkVI7pZOP3pwplivIegRXtMdArfDaF1RKPPpYjgRMwHhDzCUhlX7Kt/k9aQSLkeNew1vGcXpk2NZ+KwP2rFVcctvqMq7fiLtYAe+IG8/aAP67CrOcZNR0FBVA2ht76Sk61D9z/AR0nqp4QRzNGEZKQAWG3BtaJzoCV15m/iXAmuAtuGwJtzNAPHVlOxCxCu+C0dkSbehiPSo7lcSIjxEWdA9CFrWZM+/oOrQSblmdXxjQ0t7Q6YKt3qt+OuI3i0G8Gm3oxfreSQx/QTxmZQqllrocUPof18lLGJL5uGbS49EEMtBzYD4dAKis0x9RPWWNF0mcJ61Ekm4v3z98qQbaf0IVTvkWwVsJjjVoOf+/lkOkLmdHrdeke+nRxDvHE1ypQvX9p/vXfDvDpT9dbwB4Vp2j1pwc7dJKOK0fShVEoyv/qKfsO2LXdrvUVBtHg7rOxbs5mWoQiN5+JZh3cpNocZ2jeCVSrK/EiIPLLk6h5A/fQ5amZRKPyUiBqa450JduPWLsH2/tYfGEFnbJwXOiL1WZTI1uyI+AtzW3CAKOvWJIxw6AUuiNHWEqKUE5DsexSALbAdNdqicS4GueRHfGsZXMbVUFr4aiSuNup1VnW/WfdhF/3k8hvsWNlNduFvh6td12+309kXTEg4ySnPaI+oyiNhmMh2RMwqpxnK7mAoQepMGMmK3iCqp2xvhqGfq0PIRI8Isl281cK8jmX+sTD8Edc5Wc4nrs37Yup6F8iObi7KKVMueeyppPs09W+pkEbg7p5zEVk+hS5lN3SrziXTV75NpAJG2WrIePn
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8fa41a-8a08-44e1-73f6-08db87313dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:49:36.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAZYxeeIpDXnScTFQUOQmmhzBPP+3jzo0nOYnx4pIMNesEjNoDlJgevD6gQc2FjQ1OuQqA2AFtowXUCuZ/rUEuF3KS7pqCeQMSTafLdwvLaWeDSwaNyFOVjvErFqiF7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 01:49:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12375

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, July 10, 2023 3:02 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add suppor=
t
> for access control lists
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> This config is required for acl package to work which is used for IEC-624=
43-4-2
> evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Applied, thanks.

Best regards,
  Nobuhiro


