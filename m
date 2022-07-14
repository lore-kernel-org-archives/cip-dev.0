X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.119])
 by mx.groups.io with SMTP id smtpd.web09.6056.1657795303954589968
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 03:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=wugNwdTh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.119, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVFYVO09yrWOMutMPSZHAXCcAutsuYSDpRhAtKAN/vqqXjBNFFS/KXVCx5W5ugC++hdD6b9EABjeG6DL9nrJ1ZxjDPJ1rBpokhDhwwLT7qlae91xAwtuCLzICiQfDVJao/RKORNLoQaBUPQ9JAWs7yTYdkqloH17ItN89x0oSWPhWN41EGTlGo25mEN8UTnNC63OEugLizuoR2+JlOwtcCBwde+QPfRWdNZGf8NaOssQbYDCNusrzXnypDyoe6TqkWzfdrR7H7p2Jwo1tX991WOlu0v+r9MRDz7d+VEoiEdk0vJ3NIVsL/AUvmYsrvDjM1wlGc+EYy948+VLGpj2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPLRkNnae+P/xCbHUvxW5jo3JvEIzGXx7SLzoOADLS4=;
 b=amOwj7cEHNBenV5KAlBNtfZiSU9CFKjposEjBAHhoRw4cz4OE9ChNsgDDW3A2QZm7fHUTDM9tJzclmKk5xjKWThiExny0+/lIWAxpyixyUMse/QNnQre6lDwqK0opYUOdykLOg47urvu6cTUkuwp5xWn9XDIxdr9WfWtEb+KzZuVl7UtWiVc2PO/MTG3Fk3esZ/AzZy4hTm7CAVgCaMCzaEfTzwCkP4YASzCL7MiM5b/gMD+I1vD9OXuCm3Ss6F/hCLyFb1Zx24FUPSZtnjAblaT+IxLHJ34pvZESVEPFoCOvIQslGCvCBuM8sLHoIj4KccxOZvE6JwwwFSQqHYn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPLRkNnae+P/xCbHUvxW5jo3JvEIzGXx7SLzoOADLS4=;
 b=wugNwdThD7gvMNvrLI89mOwJxFXbHyaA/6URPhUDJfknKVuTAmARSB4n0dTM3PEAU2uLGC6GGr9plCffiIfw2sbVyQgOaaDDUZ5vaw0TEIFGTyfAISOtDZ/WuSiIYwPgCvPI2AoAyq5PB9JKqiPuw2GotOKGT71tFHMlME7AmWI=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYYPR01MB7735.jpnprd01.prod.outlook.com (2603:1096:400:119::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 10:41:39 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27%3]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 10:41:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: [5.10.y-cip] Build error with defconfig
Thread-Topic: [5.10.y-cip] Build error with defconfig
Thread-Index: AdiXVI9B/xxyxtJrQnq1UezaIf6MeQAAb9FwAAX2CeA=
Date: Thu, 14 Jul 2022 10:41:39 +0000
Message-ID: 
 <TYCPR01MB59336A9AB413EE1E9786C5EF86889@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB59221770F791E070A85C623386889@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYWPR01MB942081ECE72594BFE12A5E2D92889@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB942081ECE72594BFE12A5E2D92889@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a54a29ff-867c-4fe7-8e8b-08da65856f01
x-ms-traffictypediagnostic: TYYPR01MB7735:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zENrm7X42bEVPMK0mVHZE3FbAqRjnZ8VU8hLQ2AY5mU6LT731eev9ImD97gaGKd4nMuBlcMpkfjlDjZWqK5WMdQcYl1V5SzK4nSEAAr3jVGpxD3PdB7lvD3XrtHaxPWoDfBizeYLjGJ5aF3Y0BhNEVIBhcfvtXOpGF4Q1m/t97CWgUn04hZ70+HHR3bJNtmePhfZNDK/cr0GKE+EjPa/9dSDfxpnkDgf829l00iSJLRm6PHMXgJkkq8X4+oLxnz9z5YjPt0mLBRqUxP0ZpSS5RGSnf9cJ5ZJQlLht00X1Zre50hxaz+6JKXE9rYeYvBvdPRcXVlmWoRvjkUJIXgNjBXtBsLild/Usva1+26S8yX54MsIjQzD32WRatjED+c16m73JChiwHgUml1pG8cW8l22AMVbIPcnpgHZey5FIbcJpyfwrL+0VjCv8Eilp7xzlVXrITyp55BVLeOVJZGfY4YRvUx2MNkysThIKTgTSD6BigKlVKUnhGEaWnJVdssba/PWJdgWrfqzmrMpf7fv9PiQIpe8TOnVT8/cXdUPRxfBONEGOF/PvT60vMlBJ5ZLWKw9kS6FhrzMxf5h1z5BaVXtGtc0m2rBz44xzF8OUiAB1bo4Gb9HoXdh1e3Z2+eyAmcJqzJoCW8pFenXWHn5bCEoCJ/Glw/E0phRkfeunWTfRlC/+nvY4urtd6nQZbUcKZ7M0f2L9BzFk3u5sH3RoDz5U7ohcz12Bc9prNHQXydKZklKoVn+jWWUWCniniO0CQ0m4uBgk1RYGl3RWckQH130FXCbdWCKC6CBC3g/I+2cBCBVf2MLSTIJ87FOocqY
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(55016003)(186003)(38070700005)(41300700001)(122000001)(38100700002)(83380400001)(64756008)(71200400001)(316002)(66476007)(8676002)(66946007)(110136005)(76116006)(66446008)(66556008)(8936002)(33656002)(86362001)(26005)(6506007)(53546011)(9686003)(52536014)(5660300002)(478600001)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OHozbkFkVlE0NUV1ak5EQVcwL0pTNjFTMlBSZGxDQVRGQjZ6WVY1cG9I?=
 =?iso-2022-jp?B?OW5OVms2RHZNeFRMczFpaFIzeElxU1RXcjZONmo4aC9rZExyUFk0dUoy?=
 =?iso-2022-jp?B?QndQY3FZNmE1YzFYOHdrVStSU3UyTWF3WXRUcHA4TmdDVHNyUHhGRmFy?=
 =?iso-2022-jp?B?U3dPem5uRGV2amxjM2dpRE9TVXo4em9Ca0puRjBjZnZSb1krdExVdi9M?=
 =?iso-2022-jp?B?NFVNNmdBYU1GUWxXZ3lQRVJkeUdwOURyMGt6Q1NXUUo1cUtVMHhrUzFB?=
 =?iso-2022-jp?B?R1hhYXVVS3VYMEpubUMvMHJmQ0ZjUFJrWXR3THpxLzVaQzg4c3B5emdu?=
 =?iso-2022-jp?B?R2h0aCt1bXNVOHgxNWZNOThaeDBOTGRFZVVmT0MwalpjdUt5emFNY0NV?=
 =?iso-2022-jp?B?L1l5RTU1N25KRlFweFM1OGhGcXk3TEJtUzVZWnhIRG5vWWxyNVZPWnov?=
 =?iso-2022-jp?B?dUlIMjhKNTF5Y2Q1RERzSkltM01oaXF5eWdEUmZmeEZDajJsYXhWU0lS?=
 =?iso-2022-jp?B?YmhVdTlzVC8wcTkrZFpoWjJsWVVRR1p3OU8weUhtVjFwUWptd1hwbHJ6?=
 =?iso-2022-jp?B?NVlkR2lkWFNBRThvaWcvZml5TWluWEExSEpTd2JyZWt5UjVkSFRUUXpZ?=
 =?iso-2022-jp?B?ZGV4TXhQYVQzUU8raklhNEU2U3lWWDBPbDhOSTFQNU9rQjFKS1ZEVmdG?=
 =?iso-2022-jp?B?ZDUyM3BiMW40WTBZUHpUYlphQkhiekZnem4rZ05uU1NOM2g5Q29qbVha?=
 =?iso-2022-jp?B?L2wwRk9IT3hycXJhV0hMd0k2VndiUG9uNnliR29QZnhIcXYzZmMvWVBT?=
 =?iso-2022-jp?B?V0VrNDBmQ2hDY0piMFBuMXoyRDRtMW5nWDJpcHpPeUxYYzZIajBsL2Ev?=
 =?iso-2022-jp?B?OGhLNEhMNTdxY20rbThQUDk0Wnp6bEo2bjFSVTNIS1dleE93dkxZQWx0?=
 =?iso-2022-jp?B?ZnIwdVZMd3dSelcycDV5TXhwcmN4TFBwTXk2NjZEcXhmbC9WMmFWb1pH?=
 =?iso-2022-jp?B?S0J5Tno5b2RqeWpNN0VmcXBEbkZYU09qdzYvYmcwMUREdENZSFduNDgv?=
 =?iso-2022-jp?B?WVNGTGhRQ2RwTFByeUcwVkw0bVJNbElJUjlXcllTYWRvdnRVZXArZ0RU?=
 =?iso-2022-jp?B?QmU0MlRhMVBuYU1BVmlmK0pQMTAyb1daSDM1a2M0OEI5dm80SGlxT1Rv?=
 =?iso-2022-jp?B?MjcycDdqdC82L1kyRElaZ3NLaTBUTU1tV0N1NnAzVHVNMU04bzFqMlRl?=
 =?iso-2022-jp?B?UnBnMXZuTTUyQVJrS0s1WXAxcjk0aTdETjgvQ2pMR2cwMnBKd1hRZTY1?=
 =?iso-2022-jp?B?RGk0VDNjRVRSU0dPcGVwSFFmRlA0c0wvdUI0YkNpUVNFK3ByTmtaaEZp?=
 =?iso-2022-jp?B?U2dJczUrTWVlNXQxS2trblBBOHhlR0tZem1td3AxcXU5RlBwK04rV0Zo?=
 =?iso-2022-jp?B?QlRMVkZxd1dORGtvV1ZrM2JCSnhneWJ3VXNPSXZ4NlRqWlNvWmdLaHBt?=
 =?iso-2022-jp?B?TFZSVTNRc0FTaUJPQXNzV05rdmkya2tub01wRDI3bGRMTEV0M09lYjFm?=
 =?iso-2022-jp?B?d01MS1FCSG9BQWZnc0hYU2svUEpUODlXYTR2aEJNZE5KUUJwMnBFRzlP?=
 =?iso-2022-jp?B?d0R1VDM2UEREek10OG10ZExZTjlQZmVJUXdiUjZIRmN2WVU0ck9nUDNz?=
 =?iso-2022-jp?B?ak1OeVB0L2h2UWZJUTQ2YjJTL0J4Z04zUUV0RHY2bjFVKzRJdHhINUNZ?=
 =?iso-2022-jp?B?QS85TkRSajQvbWk5TXFOV3B0bXlaOXpjdFU1NytLQ05vR3B0UGlEV21Q?=
 =?iso-2022-jp?B?TDN3Yjh2aG9VQUNURVoydGR0MEhoM0Rsdzl4RXV0S0g1RFBIMjZ4emIv?=
 =?iso-2022-jp?B?UTJnYmc5S0pIaHM4NDdvckt0SGNlWG5CcjNSejlUdzRjdGxVTHZqOE15?=
 =?iso-2022-jp?B?Rm9yN2crUTRTL0xOcFRxaEFxUXVNb2NMYWJIZlN3bGxUN1V0L3Y5azVl?=
 =?iso-2022-jp?B?SkxFcTV0S0NoYnh3TTZiczNZK3JpRXBuZWdOc2JGWFVvMDNObHZtTGVh?=
 =?iso-2022-jp?B?NU1Lb3YxaXNOOUthTEV0REhtRjRQYUNMYkdmRnpBVU1PSnF1TzNrdnpI?=
 =?iso-2022-jp?B?SStyWnRlaTBWeVdOZ1ptcS9wTXh1WDdnY2RVSGg4UXA2VVJCNDNqSEtw?=
 =?iso-2022-jp?B?aXVYUlhJN2ZBWjNicHk3c2l1VmhvNDdSeVB4Zm1jR1FUSjl2Y2t2ZDhR?=
 =?iso-2022-jp?B?Y2xhcHRISWd4ZWpYYzQ3ZHhqajZBekY2OGYzN29ZK3lXcElvOG10L3RV?=
 =?iso-2022-jp?B?alFLTGpiNURLZWRGakxiQ2EyN1hhZzh2T1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a29ff-867c-4fe7-8e8b-08da65856f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 10:41:39.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y60FBvLOcY+xwV4W+ZbX2rR+FXbMVxd2KW7Ze/bfmTiGJUasNpJGVbj4ZrR/LANLZyOfPzHtn8wglMk6UiZBRu8jBYVzNtfmBwsciY4q6Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7735
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>


Hi Nobuhoro-San,

Sorry for the noise. It is random issue.
I cannot reproduce the issue now.
The build is ok now.

Cheers,
Biju

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 14 July 2022 09:04
> To: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Subject: RE: [5.10.y-cip] Build error with defconfig
>=20
> Hi Biju,
>=20
> I built v5.10.129-cip12 with defconfig, but I didn't have the same
> problem.
>=20
> ```
> $ gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/x86_64-linux-gnu/11/lto-wrapper
> OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
> OFFLOAD_TARGET_DEFAULT=3D1
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion=3D'Debian 11.2.0-1=
8'
> --with-bugurl=3Dfile:///usr/share/doc/gcc-11/README.Bugs --enable-
> languages=3Dc,ada,c++,go,brig,d,fortran,objc,obj-c++,m2 --prefix=3D/usr -=
-
> with-gcc-major-version-only --program-suffix=3D-11 --program-prefix=3Dx86=
_64-
> linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=3D/usr/l=
ib
> --without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib -=
-
> enable-nls --enable-bootstrap --enable-clocale=3Dgnu --enable-libstdcxx-
> debug --enable-libstdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew --
> enable-gnu-unique-object --disable-vtable-verify --enable-plugin --
> enable-default-pie --with-system-zlib --enable-libphobos-checking=3Drelea=
se
> --with-target-system-zlib=3Dauto --enable-objc-gc=3Dauto --enable-multiar=
ch -
> -disable-werror --enable-cet --with-arch-32=3Di686 --with-abi=3Dm64 --wit=
h-
> multilib-list=3Dm32,m64,mx32 --enable-multilib --with-tune=3Dgeneric --
> enable-offload-targets=3Dnvptx-none=3D/build/gcc-11-RK3FrC/gcc-11-
> 11.2.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=3D/build/gcc-11-RK3FrC/gcc-11-
> 11.2.0/debian/tmp-gcn/usr --without-cuda-driver --enable-checking=3Drelea=
se
> --build=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu --target=3Dx86_64-li=
nux-
> gnu --with-build-config=3Dbootstrap-lto-lean --enable-link-serialization=
=3D2
> Thread model: posix Supported LTO compression algorithms: zlib zstd gcc
> version 11.2.0 (Debian 11.2.0-18) $ aarch64-linux-gnu-gcc -v Using built-
> in specs.
> COLLECT_GCC=3Daarch64-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/aarch64-linux-gnu/10/lto-wrapper
> Target: aarch64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion=3D'Debian 10.3.0-8=
'
> --with-bugurl=3Dfile:///usr/share/doc/gcc-10/README.Bugs --enable-
> languages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=3D/usr --with=
-
> gcc-major-version-only --program-suffix=3D-10 --enable-shared --enable-
> linker-build-id --libexecdir=3D/usr/lib --without-included-gettext --
> enable-threads=3Dposix --libdir=3D/usr/lib --enable-nls --with-sysroot=3D=
/ --
> enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dy=
es -
> -with-default-libstdcxx-abi=3Dnew --enable-gnu-unique-object --disable-
> libquadmath --disable-libquadmath-support --enable-plugin --enable-
> default-pie --with-system-zlib --enable-libphobos-checking=3Drelease --
> without-target-system-zlib --enable-multiarch --enable-fix-cortex-a53-
> 843419 --disable-werror --enable-checking=3Drelease --build=3Dx86_64-linu=
x-
> gnu --host=3Dx86_64-linux-gnu --target=3Daarch64-linux-gnu --program-
> prefix=3Daarch64-linux-gnu- --includedir=3D/usr/aarch64-linux-gnu/include=
 --
> with-build-config=3Dbootstrap-lto-lean --enable-link-mutex Thread model:
> posix Supported LTO compression algorithms: zlib zstd
> gcc version 10.3.0 (Debian 10.3.0-8)
> g$ it log --oneline -1
> 19dd4538e81e (HEAD -> linux-5.10.y-cip, tag: v5.10.129-cip12, cip/linux-
> 5.10.y-cip) CIP: Bump version suffix to -cip12 after merge from stable
> $ make ARCH=3Darm64 mrproper
> $ make ARCH=3Darm64 defconfig
> $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j32
> [....]
> No error.
> ```
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, July 14, 2022 4:41 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel=
@denx.de>
> > Subject: [5.10.y-cip] Build error with defconfig
> >
> > Hi Pavel and Nobuhiro,
> >
> > I get build error[2] with defconfig with this commit id[1].
> >
> > Q1) have you seen this issue?
> >
> > [1]
> > commit 19dd4538e81e4019bc96ac6521af3a4ec93e110c (HEAD -> test, tag:
> > v5.10.129-cip12, rzg2l-linux/linux-5.10.y-cip,
> > origin/linux-5.10.y-cip,
> > linux-5.10.y-cip)
> > Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Date:   Fri Jul 8 14:30:34 2022 +0900
> >
> >     CIP: Bump version suffix to -cip12 after merge from stable
> >
> > [2]
> > Build logs:
> > biju@biju-VirtualBox:~/linux-cip$ ~/compile_copy_rzg2l.sh
> > *** Default configuration is based on 'defconfig'
> > #
> > # No change to .config
> > #
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/arm64/mm/dma-mapping.o
> >   CC      arch/arm64/xen/../../arm/xen/mm.o
> >   CC      arch/arm64/mm/init.o
> >   CC      kernel/dma/mapping.o
> >   CC      kernel/dma/direct.o
> >   CC      kernel/dma/ops_helpers.o
> >   CC      kernel/dma/dummy.o
> >   CC      kernel/dma/contiguous.o
> >   CC      kernel/dma/coherent.o
> >   CC      kernel/dma/swiotlb.o
> >   CC      kernel/dma/pool.o
> >   CC [M]  fs/btrfs/disk-io.o
> >   CC [M]  fs/btrfs/inode.o
> >   CC [M]  fs/btrfs/file.o
> > In file included from ./include/linux/dma-map-ops.h:75,
> >                  from ./include/linux/dma-direct.h:10,
> >                  from arch/arm64/xen/../../arm/xen/mm.c:3:
> > ./arch/arm64/include/asm/dma-mapping.h: In function
> '__generic_dma_ops':
> > ./arch/arm64/include/asm/dma-mapping.h:32:26: error: 'struct
> dev_archdata'
> > has no member named 'dma_ops'
> >    32 |  if (dev && dev->archdata.dma_ops)
> >       |                          ^
> > ./arch/arm64/include/asm/dma-mapping.h:33:23: error: 'struct
> dev_archdata'
> > has no member named 'dma_ops'
> >    33 |   return dev->archdata.dma_ops;
> >       |                       ^
> > ./arch/arm64/include/asm/dma-mapping.h: In function 'get_dma_ops':
> > ./arch/arm64/include/asm/dma-mapping.h:45:10: error: 'xen_dma_ops'
> > undeclared (first use in this function); did you mean 'get_dma_ops'?
> >    45 |   return xen_dma_ops;
> >       |          ^~~~~~~~~~~
> >       |          get_dma_ops
> > ./arch/arm64/include/asm/dma-mapping.h:45:10: note: each undeclared
> > identifier is reported only once for each function it appears in
> > ./arch/arm64/include/asm/dma-mapping.h: In function
> > 'is_device_dma_coherent':
> > ./arch/arm64/include/asm/dma-mapping.h:64:22: error: 'struct
> dev_archdata'
> > has no member named 'dma_coherent'
> >    64 |  return dev->archdata.dma_coherent;
> >       |                      ^
> > ./arch/arm64/include/asm/dma-mapping.h: At top level:
> > ./arch/arm64/include/asm/dma-mapping.h:67:10: fatal error:
> > asm-generic/dma-mapping-common.h: No such file or directory
> >    67 | #include <asm-generic/dma-mapping-common.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Cheers,
> > Biju


