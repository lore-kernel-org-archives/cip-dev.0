Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862FC61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 22:15:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.108506.1700777724746297665
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 14:15:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3ANMFGPH1029392; Fri, 24 Nov 2023 07:15:16 +0900
X-Iguazu-Qid: 2yAaQ5iWIulrZb88IK
X-Iguazu-QSIG: v=2; s=0; t=1700777716; q=2yAaQ5iWIulrZb88IK; m=BnJKQ2dHDHyl9uJhRRqxrL2bj8syHt8DW1Mz8qFahKQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 3ANMFFlW3063990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Nov 2023 07:15:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX+G+YuiRtXl6qea/q/jt14i2bUOXKGxCtHRr1wt8VPsquojTuQ/WiQxfMa1c+9xYDIQEuZjgDG5n6d7U5nlbY07CmNga2J982WD2diEmN+SpTT4bZkRo601IWEqc/go3qh8dgz2P1C+MPny7UpTrMQikbqTqRdWpxyJDEq+HcwvlLiAfXp+4yXDKESfalaixYFCAN8RDKiOkMGmFoE64u5NWdE7uAMlhbH/jHRXe2NZzOTq3uWy/yJxl9/46ZQ0rOvb0XN/jNOMO33eqpR65i3hJ/FOXRXvC9im7+M9mz7CyQZQek2ejBIYYQcfzvfkFKQHCa1TcMwIFtN96na26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AaEJ8IFrTUBWfJTCN1JPBMb+CRgDeHrYIVxJm18Lmc=;
 b=KWjza/Lw9X7BXV6zjRPrWPzDGvCjaXxTUrl0VAzA6QD2MtEsnRJEmFIBR0MguQhq8AFVlcjxmqMYSRBL9dh7yL7mrt/nEdCgMEuH/RgG2zrI9bcW1CtAAwIgCkRd/gDjjw5Fg9QxjcUUPoz0n6ITBbXxccmsE9X/q9j0zB7tjl+o4VjIdbBn64EyH0sXmIuCyV4xA4DEqEf5oFbEaN7CE8YdPhXkGfXZIrj2P4v3KfDx41jU3qt0Y342mXFbbMlMwvRrH69a6OExQetI6q0Gs20AxOgFm9IwsypdFJtwzCsVg0RASNM8Tt8QE076q0zj5Xc1Nq4pbGT2HFwKojypZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Thread-Topic: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Thread-Index: AQHaHVAsLU2oevDaok2HjCHT4c6hx7CIebFA
Date: Thu, 23 Nov 2023 22:15:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB1124586158EA9F30C835538AC92B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB10925:EE_
x-ms-office365-filtering-correlation-id: 322e1b81-7985-40c9-8ecd-08dbec71aa12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 e/VQcU+iXlj7GAoVNepBSXksiHqVeRRRUtcTPUyCOesiatF6azUuomCUCB/ldLPZaIS0dDcBp/Plel+JnSJ8B05sEC7i/ZwCoESUNFlHcomzQhUEzIPYjSZ0BLtyEh0kn72YO3BKEj6zqX+X9gz03SohXS4RE3/3xUFrwfw9pE4Ue5nP+s497LAq6vCTBtcjQiIF2kXzemKtRsw1Ev3XfzItrysc5Uo/9+NU8g7i/IEEJ4SUndYhtOaluM3aBdKn++IS2mWSOxG5+Gin6K0dfS5Q/zaqJRLX5+9+ILWc5DAcGulMa1AZj7nJbhKDeQSiD4gdOOPT84+0Y71PR2UbpTvghNPtv1iRuD6fHq+C/B+cqFdmn16dYqf0LsPwLUAhQRFg8CQNhA4YWNlL/aMGxob00VWhKP8q8h4V6NHl/SAH7rsplOcbXK/kd9DdLoCxWvA1+QdByawPrjeXQoPr2MiUznnsEJCRvDaBUY+PnGGmeIhONqNOuxdP59zOu9miTTGsN76ZHTf9oRgdeCmsyM4DM/v5SKEMZAWPYvFIIHYTuhgZlEe4Qqt67vk9/PUHuhW9ftCJkPwM9Il6bTtRS0+qLMrISpwmSWwtq2zJWJbBIN02vPygYbexVL6suFYFD4IECM9U2+NgVs3L/fjnyw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(55016003)(26005)(76116006)(110136005)(66946007)(66446008)(66476007)(66556008)(38100700002)(64756008)(52536014)(2906002)(8936002)(316002)(8676002)(4326008)(122000001)(478600001)(5660300002)(53546011)(38070700009)(6506007)(7696005)(41300700001)(9686003)(33656002)(71200400001)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TWlSMjA5LzhVSk5pQTY0MWtmYmhZbGoxQ01xcHEvajhBODZ4SWEvMGxu?=
 =?iso-2022-jp?B?Q3c4UUcreTA1Vk5laVYyVGpIVENzSjRXSEFnbVF6VzY4V0U3SFBYMHQz?=
 =?iso-2022-jp?B?TExVMjQyYUdOd2hrZDArTTNCcVVCUWF4K0pNdjA4VEdVTkYrUHdKK3Bu?=
 =?iso-2022-jp?B?SS82QmU5RDNZMmZWbFNIdU5tVHdyS3hKaU41bjVXM3NTUTJHdklMbHJF?=
 =?iso-2022-jp?B?MmY4Ly95OUR6ZTRVWldxUm9rM1pIZXM3V0oyTXdWbVpsWTdTcEFkTnNL?=
 =?iso-2022-jp?B?TUZ0YlpGNFY2ZEIyc01UbGt5S2NBU2xxc3haVXRLRlBSWGZkbnRPUVR3?=
 =?iso-2022-jp?B?WXdXWTA0MngyMWhkelNUMU50Zm16NU82OGJwL3lLcDhnbEJEekdGNU5G?=
 =?iso-2022-jp?B?Wm5wRUV4L3NTTWJKcVhLWDI1STUrVS9iVG42ZnRHVEVDTmMwNHFjRnZW?=
 =?iso-2022-jp?B?ekZ3ZU5KUmNoaUhZNVc3Vlh3dmxYamR6dmtzM08rMEh3VUNPL3k2RGRO?=
 =?iso-2022-jp?B?MXM5NWlCV1Bvcmx0R2Z0ZHRPdGxCUjBIRFZkUXB3YlBPT2IxbWFXcm81?=
 =?iso-2022-jp?B?ejRDSkF2NkpnblJ5QkM4VGVTdE1QcDlXclRxMG9jUW9VUklZT3J1anRG?=
 =?iso-2022-jp?B?WjhEbEZYQUR2OG0vUFlwMXJHVXQrMnNDT05NMlZmUHdTbVZWVTFUd295?=
 =?iso-2022-jp?B?emlnQndpam1BMU9oMlNpN2YrNkw2NDlwcmlBY05HNEh4ay9FbFg5bkd5?=
 =?iso-2022-jp?B?UFY5bis5UEtVajFrODZFS1ZDMVhnZGxZVWk4N01qbzlKRE56c1hzbEx5?=
 =?iso-2022-jp?B?ZnlESzVJbG5IMmZiR3JuaitzMWNROERWSk1FSGszZnByMUJ6bUVOS1RG?=
 =?iso-2022-jp?B?RU5xSm5vVjBWOGNhQW82aDJKUXdONFNVdVR1UUJQNGtRczVMY1JuSEFY?=
 =?iso-2022-jp?B?VmlHeVRPVllvSHpxOUsrS0k2YzJqZ1IxM0pwQ0hJL0tOd2pRRVVKU0NK?=
 =?iso-2022-jp?B?MGtLcHd2UHlXWXErOGptc3kxSUhPdXYvUitsT3FPb3NUeXdWZWRjWWpu?=
 =?iso-2022-jp?B?YmpJWWJlaTZ3aXFucG9oZ0VUZ2E2WTdYem5oTkF0a0dUZmRlMzJZaFJ3?=
 =?iso-2022-jp?B?Y3BXMWVBSnlJaFp0V09DUEM0UWNEdHR6OTBQQ1M0Yi8vWU1sWE4rRnQ4?=
 =?iso-2022-jp?B?MmkwZE5mYS9XL3dkOTk5Q2FNRUhUU291V2MvQ3hDUXdyMXJhM1RVdFdn?=
 =?iso-2022-jp?B?NldyNU9mNHJ5VHVuWGx4Yll6WjFkTC9ZS0tMRnA1N1grcm5WRVpvVCtm?=
 =?iso-2022-jp?B?YWF5SkV5L2xraDZMNUV4eXJPZGJEcU9DaUNubWlNRFcrVjhDKzdTSHRX?=
 =?iso-2022-jp?B?dEJsUzRvVGhxRVlSbElicmFxNnA5RzZMendMVlFuNklsNGwrZG1iR1Rn?=
 =?iso-2022-jp?B?VHQ0Q2xnNFJvSEU1UTNkM01xbHJoMC8zcE1xcHZQYnFRY3drR3ZTUmZ0?=
 =?iso-2022-jp?B?bWVIRjUxYUY4RTlSV1J0RHIxcDVMZWQrZERWOFZidXJJUVEvR3FpWEVD?=
 =?iso-2022-jp?B?ZWlMSmhKbGdtQ3E0Q0VwQytsWXJMemxJZ2NOZElUZjA3c2krSU5Ca25y?=
 =?iso-2022-jp?B?ZG5Qd09oM1BJcUZFak9OaGd2Z1Ryak45MEFva1BHTm1IbVczZXF1YllH?=
 =?iso-2022-jp?B?Q3VLUGU1L2J3WklNVTJsVFJKdTZra0hLV0t1VWJVTmYrOFhNcy9sVzRU?=
 =?iso-2022-jp?B?YzhEei9JN2Nva2ZoWXZYb1paazkvS2NPLzJZbkN5MjlmMjJYS012aTlh?=
 =?iso-2022-jp?B?bHpneXZmSVkzaHp1NXJROHR1UGw5L0E1NVN6YmpSd1ZXYUJCV1RGZWMw?=
 =?iso-2022-jp?B?ZkZxVTBnN1dBUkV3MCszMS9GUEdOaEExVng0NStKSk5LaTNXaWpRSnps?=
 =?iso-2022-jp?B?c0wyd1ZEZC9mWGFmRTA2a1hpdk9obTkvQ1VWeDFIak5lZ1NTMVpWNkxy?=
 =?iso-2022-jp?B?NVJ1bC8xcXRsUDY0bjhob285cjVxSVFOVnBMdXFoV2RvM0lxaXhzVzNZ?=
 =?iso-2022-jp?B?aGRFZ3U1ZVVKcmhwMnJsWUlZOUV3SkxDaWRJSFBhZjI1bGZxeUE4dnN1?=
 =?iso-2022-jp?B?QnIrR1FPRGkyV0JKTVVHL2JMM3cxR2hjaXlOTWtDOXpqZDJiOHhYRzVp?=
 =?iso-2022-jp?B?UWY1MTV4Q2RKdTZIWFNnVmt2YVJnT1FNbS9rNXFoQ25nQXBKK1hmVVFX?=
 =?iso-2022-jp?B?ZDNMaHdmY2lmZ202cEhyN0RUNWJhZFJBK0pyUWVua2l0M0MrTThLS2p1?=
 =?iso-2022-jp?B?OWZCWDB1U1RZeVdWS2xKajN3N29QeUR0NGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322e1b81-7985-40c9-8ecd-08dbec71aa12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 22:15:13.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjOrCk4RXcwYztgaDRUY92FL2hWqP4LPJoEi8WdECKf+WWa03stcujymITvNrUYdlT6rz5gVGhAFKQxr5L6qW/2Qzoz2hQDLao2cGzs8xqmR8ldqVeKZWdbAsWeBFd74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10925
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 22:15:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13689

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, November 22, 2023 11:28 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
>=20
> This patch series aims to add versa3 clk generator support on
> RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (7):
>   dt-bindings: clock: Add Renesas versa3 clock generator bindings
>   dt-bindings: clock: versaclock3: Add description for #clock-cells
>     property
>   clk: Add support for versa3 clock driver
>   clk: vc3: Fix 64 by 64 division
>   clk: vc3: Fix output clock mapping
>   clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
>   arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
>=20
> Daniel Palmer (1):
>   clk: fixed: add devm helper for clk_hw_register_fixed_factor()
>=20
> Marek Vasut (1):
>   clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
>=20
> Marijn Suijten (1):
>   clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
>=20
> Samuel Holland (1):
>   clk: fixed: Remove Allwinner A10 special-case logic
>=20

I reviewed this series, LGTM. So, I can apply this series.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


