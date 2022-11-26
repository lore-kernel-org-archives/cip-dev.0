Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADADDC4332F
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 08:54:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.66803.1669452859275247151
 for <cip-dev@lists.cip-project.org>;
 Sat, 26 Nov 2022 00:54:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 2AQ8runw018793; Sat, 26 Nov 2022 17:53:56 +0900
X-Iguazu-Qid: 2wHHnz0I7mnsYnwz8S
X-Iguazu-QSIG: v=2; s=0; t=1669452835; q=2wHHnz0I7mnsYnwz8S; m=OfAk14xPdKivgHr459+/xZf8sSFXPKRQpDC5uzKnfVc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 2AQ8rqof031245
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 26 Nov 2022 17:53:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYM6dXcIGSt96QUbzrDzz7SOB/wh/MValXZYnMZ+4Jw4TDedI0ShevXxDHIxjqPoZJoj0DsgMkgi2tQlwEP/+DOOjkGY1oX4HQJVxr+XI6JE8jh5oyykcGwh4klsOhsvSlMTiOae2bYGqBT/aazdphj4snmhR3FmXuoGzySuckblr18Mu9Mw3QuPYC68XiamNB52Gl2ivr89MeFa8zEWmb1WTb6Tji+hjNqpZxGpoRHeXsRYaG+YpxD8iGVVBhuWges1L7Rd94xn0KxUCTUgme0gWdOlCThwkY1GBWEZz3a0bBH20x5If3mZwuHXUkCtCv6jkRTn9bSC6G8pLf0yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il7C5w7ig4p5V+vY6/kZMi2ITtQwE/Nni0BA9rOzQgU=;
 b=ZUzLNHGDn6w1BpVi/NBzf9ccZPpw37eFRucJ0zahFPouNvx5FpPwrBiC5IgQ3+TbZiOfDV/jECdn7ufGF5jiQebY1fH4jSEHrQ8Z/GnD6L1lEh77mb7TISYrmDoLCz1jYwLOy0gn5dhr6/o4zTm3TKl0bBSVj8r8+ox40tX2ke3B1MvtsXis2dvNmvkTkBcD8YarPQr3PIL9gWkvnjrDesA5y/HjqUsg7jFB/3Go6MJc6MfTYXTkGwZJ521QYW/PjDtPbY3CjtMdvaoU1pij0Tg5OrudG42mLcJvb0TuqZUmhQhdYKuDr1QC+v98iIt3w78kQ8Y570qcLusCwyuhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Thread-Topic: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Thread-Index: AdkBc8qo2Dln9WnvShO00aTT5Rkiig==
Date: Sat, 26 Nov 2022 08:53:50 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420817574A7EE194819701E92119@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYVPR01MB10702:EE_
x-ms-office365-filtering-correlation-id: 49a5d4ba-baea-45b6-6156-08dacf8bbcf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/iD4g5Cz+HpZpvvHaKn3hD9N9rGX3rKMSGbwnPsng1gEcFB7P4IKxGGu6dM4ULaBj7Bo9le2gLDfrA5uyAFxxju5E7kcQqGw4WTo/uTs31YBPqF+zLqV23T9KJmourzTya6Lj6p1JyBGB9Bq4nvWOhfWBIS2AGhoCS9AgRF4714Zgcm9BjFHqkjtr8MJlplLfQk0oEhqNUzRCeoGRWANiOHKfcBzI6nMVklLSoMAczw887ci97mXbRQ1h6pR4BCfhCWWYuU6tDpr5m5bnu1KzLEdKSoBKe+8Ayfd82bQYacBLygkmE4zXPZb4DrsMcvRo9pQK72dubXLQ/DeRlPN+uDexZSdXAz3tWO8kBipSVLzMGxHUEzTrKyuU9c6nsY5I5eeZh41Rx38y28nApOayy0gJpRG113Z0ftNbZBUqMAIxY39DfSaMQEgVz/O0xchj5SZwzYgPKym/qfu+NDjCCde7EtMP5LGY8GpW3cvBsTQLl/7X1sj0LPdJTM6bwA2Ayh32q94zYGE4LN68eQSkdVPNP8v/savbWto8E/n2a3pRqh/YXa9LTTQWfjRnlyEG6SkxS5guVOTh9JIhh/FQGMEYONXAb/mL8D+9Smv12/xzmV5tcB2tGpRGYuPtZkPgyfTX4A7EqbQBg8mSQI8wjzPy9jZ8sDlz+WJGI2Wnw9w8yqnaqwNhw2rBwcepegdlgtkVtPvPvAPEqkA8ZY+cIHxcy4WQ3qMKvQoVejKvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(41300700001)(38100700002)(478600001)(966005)(54906003)(55236004)(6506007)(7696005)(316002)(9686003)(26005)(6916009)(71200400001)(76116006)(66946007)(55016003)(122000001)(86362001)(186003)(66446008)(4326008)(8676002)(33656002)(66476007)(64756008)(66556008)(5660300002)(83380400001)(38070700005)(8936002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cDBJcVlOTCs2Z0tseE1qVndkQXNmNFZkb3NJd2ZMYzBHNU5FWktaSHE2?=
 =?iso-2022-jp?B?MHluK0dTYXlXSlVmRFl5Q1krYWV5VldZakxNSllxclZHNzI5Y2lNNGdI?=
 =?iso-2022-jp?B?d0hidjVaZ3R4S2orOHVRSmRoTktuV3d6MGQ3QjRkemM2Z2xqajlmN3Ru?=
 =?iso-2022-jp?B?ZVhlVDhjMElBNlJGNW02Ky9Sak1NTk4zWXVWejFGQU5JNUd0K3ZubFFw?=
 =?iso-2022-jp?B?cG9senFSc2dpeksyczU0ZHpaNGRCR3dTUzNBOTk0bVJqc0M0OE5KT2cy?=
 =?iso-2022-jp?B?QlozczI3TlB6NE4zQzd6WG5Wb0VxUXhzSnhkZ1VOV0loYkxkdUtNNHFs?=
 =?iso-2022-jp?B?SnFvVVliRE5rVldicTZvdEZyNDJmT2xWZGRSaFNpOE1BU0pxMmZ4QU9r?=
 =?iso-2022-jp?B?VFgwSUtIbk5oa3N5WUlsalZHaHkwSHVaMk5GeXdmbUF6dDlwQlhuNFpo?=
 =?iso-2022-jp?B?MjJEWExCbnlGUzY2RXRFVnRya3ZHMk5saGpMUXNuQ09nVXlPMHEraW1U?=
 =?iso-2022-jp?B?RVFOaU5TVTZ4TnRFckpGYWJLbEoyejh3YVhlSnV3Q04ybnJYZ1JzQjJ3?=
 =?iso-2022-jp?B?UEwweXRkc09SY3Z1UlVaZEVSU0FuRlFCS2xnUDRKZ1V0K3dlWUQ1WERo?=
 =?iso-2022-jp?B?ZXl1YzdRdHc1NTdkYTdmVDhyMzZLczJOdHpHVjVobnhwczZTdHltSVJO?=
 =?iso-2022-jp?B?VDlWU2pLV2k5Yy9SdGQwOWpDekNYRDhsZUo4eHNvY2hESUl1Ums0K1Zy?=
 =?iso-2022-jp?B?b1FmbWpkaVh6bjdVWTJ3TEtSMnpwVmV0ZjN6ZThsTkh6Mmx5bHR2UHFM?=
 =?iso-2022-jp?B?c0tyZnV4TEp0MloxWjVhaC9oVjFGTVR1RWRiai8xbUs2VWFqUWhTaytx?=
 =?iso-2022-jp?B?UC92ajdITmFKRXEyMkgzYzFBeVlFMlFCOGRYcC83TGZHWnVlelI0cDJi?=
 =?iso-2022-jp?B?MklrUjJuam0yNC83NkFXNjBiVlhkRGlTb0dsTUE5RzI3Smx0bGVRNU9y?=
 =?iso-2022-jp?B?MVdvYVpxbW9BYTlOWTVrdHMrK3lQdEdQUlZ0a29MeVAxWDBkeHdYSW9I?=
 =?iso-2022-jp?B?elYzYk1MMlgzbWpEcWVOTjNwYjdFSXo4aDREZ1Vsa0xZelFDTUUyTGVP?=
 =?iso-2022-jp?B?WjEvY0U3WkM5ZUlUTisxY2xKSUZNSC9rd2FFcml1NVozSWo1YU5uSld0?=
 =?iso-2022-jp?B?RjAydWIzVEtsV1JWWTFHS0c0S1Zoa1IrYW94QlNvdXpXd2xjMWtrSC92?=
 =?iso-2022-jp?B?c0RoV20vYkhTS0czSFdxdy91OFZZUFhUV25oMkRWZmt1TEo2SVBYZTBo?=
 =?iso-2022-jp?B?WnFPcjB5cUwyZFZ2ZlIyOGx5eTZ4YUxKZ2pUbmhwNDJKNGFBQWFhczN6?=
 =?iso-2022-jp?B?QXZpaDFncE9VR3l3Sk1NMGJjNm1RUm1KMkgyTGVPVGxUQnY2VU1BWkJm?=
 =?iso-2022-jp?B?Mm5WNHBnYnNjcFN2V3J4Zlk2YWJRZjV0aHBoVHYwYlU2bTE4NkxET3Rl?=
 =?iso-2022-jp?B?YTNGRkdXRVQ1NDVuYmVicmptbHJOQTh0U2NVUVVJS05xOGFrV2xqTXVF?=
 =?iso-2022-jp?B?Z252c1VwcmhSbHNnSFZjYzFsMExydzl0ZlpiL3l1OHIwMHVjWklTQ1Nm?=
 =?iso-2022-jp?B?UXNzWGlzUW9paUJ0UUxqTndyTU9DL3V6aXpraUMyM3MwZ1JlZlZoUlNP?=
 =?iso-2022-jp?B?Ly9YMlNyajlHelRDb01tSkJlZGlZWDgxVEVudk1NbDRVWGxaYlVYWFFz?=
 =?iso-2022-jp?B?ajRzYmp6ZjZvN3h3NUtUK3pRRHRGZDdrdUVrSzJUQUlIV1hreU1lcnMx?=
 =?iso-2022-jp?B?eVFaSnR3NzVoT1lmQUQ1eU5GRDAwam55aEVNenZGMnFzWVNEMlpLcUVO?=
 =?iso-2022-jp?B?TEtwUzBseFNCQi9CRkZqL2NabTk3UUp0enRZVjRHTVZsUHlESk9BVFZH?=
 =?iso-2022-jp?B?dXhsZ0xBK1VXYWpVMFljMU95cTMrL1lXd3BIQ1VZOGlHUlljNnoxdmZt?=
 =?iso-2022-jp?B?YzFUYWdPM1NQWEZQRjQyTEJzcWhnVWdRUHhmNlpkRlF4dCtYNGd6VUZk?=
 =?iso-2022-jp?B?dGhYOWZhSkxnSnZRSE5Ma08xMXQxTVRRZXhNSGI4WnB5SkM4Si90QlMx?=
 =?iso-2022-jp?B?dFJQbkxoelo3c3JxemJFUVVHbU1vY1lVVXNWbmZNZ0pxM09aeEtqem9N?=
 =?iso-2022-jp?B?V1dRWHZDTVkvSkFYNUJlUlZMaWRBNGFSVTJBRitiNGtYaUh2ZUJCczE1?=
 =?iso-2022-jp?B?czlCTFE4MENzVVRZVzdKeXBrUWRheXNvc0lBWGswcDVIVFpXUVo2aDFz?=
 =?iso-2022-jp?B?ajZqbWlYaHc5SFQ3SUhSMVFhWCtXYyttcHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a5d4ba-baea-45b6-6156-08dacf8bbcf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 08:53:50.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfWEjgts6tJAKFhNgSmhV7MOhXSpmLZACNsz9+wpSutVws+Jk4gcm+N2Z4utqpaxMMXUwjSz9OHNj97UkPR+AlwfcpnIIT/DE0ZwkCbqndDVYAhi9nlFo2C/gB8aVG1z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10702
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 08:54:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10112

Hi all,

CIP kernel team has released Linux kernel v4.19.266-cip86 and v5.10.155-cip=
21.
The linux-4.19.y-cip tree has been updated base version from v4.19.265 to v=
4.19.266,=20
and the linux-5.10.y-cip tree has been updated base version from v5.10.154 =
to v5.10.155.

You can get this release via the git tree at:

  v4.19.266-cip86:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      8c8d57a3cae5b94b0a26c176e2a32f260fc529ae
    Fixed CVEs:
      CVE-2022-29900: Information leak through mispredicted returns on AMD =
processors
      CVE-2022-29901: Information leak through mispredicted returns on Inte=
l processors
      CVE-2022-23816: Mis-trained branch predictions for return instruction=
s may allow
                       arbitrary speculative code execution under certain
                       microarchitecture- dependent conditions on some AMD =
processors..
    added commits:
      CIP: Bump version suffix to -cip86 after merge from stable

  v5.10.155-cip21:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip21 after merge from stable

Best regards,
   Nobuhiro


