Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B2C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 08:04:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.5150.1657785838578550533
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 01:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 26E83n7P022069;
 Thu, 14 Jul 2022 17:03:50 +0900
X-Iguazu-Qid: 34trbfQWNMK4sbfN9t
X-Iguazu-QSIG: v=2; s=0; t=1657785829; q=34trbfQWNMK4sbfN9t;
 m=p/Llk+dkHDNMgNkscaEv6axhsNwpRkAmlpHlvMOC88g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 26E83mIS024790
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Jul 2022 17:03:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O22k12uM4Hpcc9yDA1t1hXQUH2Me4wgdwIzg4M1mTBv17xPvQvJaC95vpgtTI+tSS0/y4zO1WKvAqOkPS2oZXRkDEHklCTS1lvgitAgOnfO3AMjeY10W/gKfMsf78va9yOTteUCebYOCox1cvJeiQ9YrhFTfyLU6SN2RwnVnA+YN0xEhYJyVMahCqeRYVGSfbpaOOdkBR98zBijMAwe3O3iUH6aMb/Z5kWpZMzn4AUD+mLi2EmhaKizz5b0tlRNvbxUCeOBgw8FVM5krwHC1FHx05nyQARzjzqsl3ytAcGLRIhaNe/ekN9VU7SROhHSio5YhruqFNs0mFGzLhJlbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBgMs9H4wCLIhEf5ZlE4kXMYeRi+vpBhnDwslqEi8mA=;
 b=f67V4uGLeq0n8GFN4cbY9QD4AoThnzEm/hMSnmsYQmg2igxccxmtZFQylT34raDUtJTRbVxLlnphiOUqBDrj+hPilyReL4BL8PQS3DuZ4CSY1L/olbvWuRnijJjWp6aPTrYZT1wV9PAuO2GaeWsweEo2CYPZwCjBNkpgtB/rQm98/N6APtnCNLt6TJ2Ej91Oe+Eq6LVWe2f2EjB8bZaOwdUP9zreOOOIbeneexTfcrUiqqbNoUqs5pc+hGBQRQlYK335QNzRJEes1g6zeRM4RcYbL7wN3d+ydCDXNVmePDKSN9a8Gk300WQtDwAXu0t6tsXk1r4/CYSfOuO65R956Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [5.10.y-cip] Build error with defconfig
Thread-Topic: [5.10.y-cip] Build error with defconfig
Thread-Index: AdiXVI9B/xxyxtJrQnq1UezaIf6MeQAAb9Fw
Date: Thu, 14 Jul 2022 08:03:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942081ECE72594BFE12A5E2D92889@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB59221770F791E070A85C623386889@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB59221770F791E070A85C623386889@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a308acf4-c330-446f-215f-08da656f5e65
x-ms-traffictypediagnostic: OSAPR01MB3347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 em8gNM6dNI9Tmzq3YcuhopirLwVZlBLPeIM4QmFsgfxOkfQMUUysUJCRKfy0IE+uLE+V5MLukfD+hAzz3dJoNKjkAI84XlsNH2YSiPArSAH//4fVRllGdR3rcZyOzUP2aWBXgBqBHaSTGz0w5Hhpnrnmpyka6dSWpB2Z00+pY5lf2CZxe048A6soXNsBK1rookXaLSx1XNKy3k/1RBR+WMOntOT9eY9DKU/b4kF3OuEEgYWyDGrKwwzDKrg30m6Rb228dNS7/Augnr/J1Pt0Nwq8KsOAvJUIUELJlw7X//s/xhK1ghb1uATpREQ8qwGbr0o8aH+uNnxf8dM9wEwOD06pbXAyQLbn16epGUkgktM5kxrU3dfHGF6x9Aw6sufpvtR6mVGVSZ8tukLsm8F9F2EgxA5QWT3Mu7dfdjAy4uY+iH5ij/wBNYcUbQ+5ZogOdUFz8yGcS3LUY7DHpN29owiePBR6BbmbCY2vqonH9rDYSmJkCY2SXits+jI61lACvEwnW9VySYnK0Bco8zYORNqgkBqp3aceRNP12FopJajH+YAOTWjEko+3RyppSwepJ91M3AEnDDOCTkElq01agcmJhFow+k4bx1GKAlwiioLAXXF27fWnBwtYjYQZIKfjsHWKMGKPDSCIKoajlRkpZTSxeEA1i74faTAnhhKarSMHxEOb7D+qbrUsy3fas3umon2IvpW9tnePbLyTyEcBe8bvAyaqIycTm397nSI1nK9W2hAtrjzS8YoCq59Yb9wTBhTGwBQI12lkEEs0OU7YxkxIlk9Keao0z1N9Qd3d2DfvE9TM3jDfYmJoMThehqr8
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(9686003)(66476007)(6506007)(66556008)(8676002)(26005)(66446008)(5660300002)(66946007)(38070700005)(83380400001)(316002)(53546011)(122000001)(478600001)(55236004)(186003)(64756008)(2906002)(86362001)(52536014)(33656002)(41300700001)(55016003)(110136005)(71200400001)(38100700002)(76116006)(8936002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MmlkWUtET01pWjc4ZzBFbFp4N0VxZjQranZWSkxJQ1dGeThaS2JrbFcx?=
 =?iso-2022-jp?B?bjBPaFRZMXdNVFVsS0phSDZKVW1EWmJyMGQvNFB3a1huMWVrK3hSOStp?=
 =?iso-2022-jp?B?NHdUendzUmZMSDk5dXYvUVhDN0xLQ3J2NnZjOWdMQWkxYnFKS0FHZ1pq?=
 =?iso-2022-jp?B?MHdzcG8yTy83MlRhVmM0dTl0L2V2cDVBdWJMdjg2R2lXeklrNzE0UjJO?=
 =?iso-2022-jp?B?NTVCaXZiSGhsVCszalp2elpnQUJzR0MvRWJaLzBDaE1CZDBkQW1TRTVW?=
 =?iso-2022-jp?B?VGxHTkhtcGxGUjE5T1lwcHI4SGVHY1ord3ZoRW1ldjI0cjdScnBjV2dj?=
 =?iso-2022-jp?B?R2Y4ZHhoSjNuSjFPQmZrT1NCUjlGSTdDZURpMy9lZW1wcVo2MDFzM3J1?=
 =?iso-2022-jp?B?QjlnQUk4WkVNVUE5dHhMdUhRcFdCL21kMGdNWmJWQ3ROQjdXWlc1WTN0?=
 =?iso-2022-jp?B?c0xGRjJuTCtpaDI4SkFpV3FaQjBRTU9ET1BRc2lyYzF2Y0MvS0QxSkV3?=
 =?iso-2022-jp?B?YUEyY01MejhON1NQTUdpZFZxckFCVkM4VTBQampta3B3Y0NBR3NQa3B0?=
 =?iso-2022-jp?B?VnYrQWwrYkFGK2RGUVVSWWFKL2FtMDFEdWwzbjVKMHFhcldzWUw0NU1Y?=
 =?iso-2022-jp?B?Z3lBTk9KK0ZMTExmcXUrSUtEVHV0ZjVyU3hsV1M5SFYweFpZbkhOSHFH?=
 =?iso-2022-jp?B?TnNtZG1xSnh5OEFVOXFtQzAvVXJFR1MzS0ZyTmJGR2dxRU9JVUgyRGpL?=
 =?iso-2022-jp?B?NmJEVEwvZTY0aEtkZ01aRGQwci9IK0lTcm1mZU5YZFpzNDJ0UVNjWGF6?=
 =?iso-2022-jp?B?ZGpmdUtlOGcyN3pZaUpPK1dWRThvS0lNbzRycWVDcXQ4V2xzVDBTbWN2?=
 =?iso-2022-jp?B?cFFwWlNXMmR2T3F6V1NtZGZHbHExclYzL2FvNnJvY0k3M3ZnQVoybkxS?=
 =?iso-2022-jp?B?QUMzSHpEcVFQNWlIM3BFZmN5Ny9Ga2lOYVo0dndUR1pXc0ZYajdDYzJh?=
 =?iso-2022-jp?B?RlVHbGd6dVlRdFdsNW1KUDJ4NlFGSTJSNUEzK0h4NHdkT0xJNTZxSTY2?=
 =?iso-2022-jp?B?bzd5RUpzb0FYTjMyanFHdmR6MzFURTZ0RC9BRk1NY3dXYXdkQm9JZHBF?=
 =?iso-2022-jp?B?YjMzdVhiWjlTVHlPMW5yVXNwVmJkNnF3M05Ta1U3eVBjMHBpVCtmcEIv?=
 =?iso-2022-jp?B?YkVKYmxWWFFrdkxxWkczTFd3K3UveVRpdUwyL3J3R0hlVUwyYmdEc1FY?=
 =?iso-2022-jp?B?cFk0N0ZqUnR6UGZjRTNRYkdqOFhHM0xrVlllcU01VElIbjhzWFN5NWRk?=
 =?iso-2022-jp?B?cW1zbzVLVjdSYmwxMzJkTWUyN1FId0V0SFRkaHJ6QzdQbkNMaGtrS0JR?=
 =?iso-2022-jp?B?YlMvL21Xc1dRaUtLMDc5YSs2ekJwYUQ3NGZ5dHVDcVJybkZOVzVmTUJZ?=
 =?iso-2022-jp?B?U2J2QXh2eElybXI1cmV5ZDZvbHIvd1JYcGo1Y1VTYUp1Si9Mb0ZyZXMr?=
 =?iso-2022-jp?B?V042RlJ6SzJFZGpEWjM2ZnNsS0d3d3UzTVh0NXptTytvaE9yWmxUNlgw?=
 =?iso-2022-jp?B?U204QlJHS2hnNDh4UmVJdlJZZjV1cXpaUzB3dmVZTy9MVXRIaEtOeGwr?=
 =?iso-2022-jp?B?YU0rZGd2TExjTXFnajVSZHl1Qy9XZnB2SkNIR0tHNU9mUk41RGJxVUVB?=
 =?iso-2022-jp?B?SFVhSHRpQlA0TURDOGtQeFBQMmRNaWMydnZUNFQyMFQ1MkRCUFU3OE1j?=
 =?iso-2022-jp?B?aHVWYzlNV0ZxU2JVRDk0a2h3VFUrbTgwZEtQbEVROEYzeWxDYXJiOXIz?=
 =?iso-2022-jp?B?ZCtBbHpTRkY3aFdQUzl5UDd5cGVzNDFzbXN4R05pOG9QeWE3c1dkdFor?=
 =?iso-2022-jp?B?MmJUWjhKOTgzeElPeG9EK241ZThHZXBtZzBaYjNJTmxpYTF2QmpRSE03?=
 =?iso-2022-jp?B?S0NReFBUT0hoRUkrc2xpcDJyYm8vcjlCN1U4UUZjWGs2ME1tZVAxMFRN?=
 =?iso-2022-jp?B?dElHdURYSVN6M3VuM0tQdyt1L1lCMGFTVkVsaGsrSWZic3lOeW00ZElk?=
 =?iso-2022-jp?B?UmdnUmdxd2RUSHk5UGlybWNhTUJEdWJ6TC9ROGNxM2JWZ0ZUTzErUkFw?=
 =?iso-2022-jp?B?VUI0dUZBK0V2cFgvbmNBR3BoT1IzVU15MTE0K1ZIc05YbWZyOFhtNjAr?=
 =?iso-2022-jp?B?eGlPZGlhdmJjT0VIWjU0V1VDRTZLVHlYbnM3ZWJ5N2dnOXovNlhNa3Vl?=
 =?iso-2022-jp?B?RkV0bi9aanJqT2NvdDR3VFpNVG4ydFB4aFBjQ2Nac2pMd3djdFpVZUY0?=
 =?iso-2022-jp?B?Qi8xcGgyLzFqTytoZkdYNFZzQ0xYeVRVTHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a308acf4-c330-446f-215f-08da656f5e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 08:03:42.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 htzzOQRTqiffMLkGpfuMmnMUnLeDGIauZgzsx0kKffGr0Jr/tYbXXURoFIah1az3JLe7kFOHqRM1ddQCLQymgIy+Y0UrIEfpGm4GPLSOXBO4AMxUMTQwtnVQRhljeX5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3347
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 08:04:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8753

Hi Biju,

I built v5.10.129-cip12 with defconfig, but I didn't have the same problem.

```
$ gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/x86_64-linux-gnu/11/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Debian 11.2.0-18'=
 --with-bugurl=3Dfile:///usr/share/doc/gcc-11/README.Bugs --enable-language=
s=3Dc,ada,c++,go,brig,d,fortran,objc,obj-c++,m2 --prefix=3D/usr --with-gcc-=
major-version-only --program-suffix=3D-11 --program-prefix=3Dx86_64-linux-g=
nu- --enable-shared --enable-linker-build-id --libexecdir=3D/usr/lib --with=
out-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib --enable-=
nls --enable-bootstrap --enable-clocale=3Dgnu --enable-libstdcxx-debug --en=
able-libstdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew --enable-gnu-u=
nique-object --disable-vtable-verify --enable-plugin --enable-default-pie -=
-with-system-zlib --enable-libphobos-checking=3Drelease --with-target-syste=
m-zlib=3Dauto --enable-objc-gc=3Dauto --enable-multiarch --disable-werror -=
-enable-cet --with-arch-32=3Di686 --with-abi=3Dm64 --with-multilib-list=3Dm=
32,m64,mx32 --enable-multilib --with-tune=3Dgeneric --enable-offload-target=
s=3Dnvptx-none=3D/build/gcc-11-RK3FrC/gcc-11-11.2.0/debian/tmp-nvptx/usr,am=
dgcn-amdhsa=3D/build/gcc-11-RK3FrC/gcc-11-11.2.0/debian/tmp-gcn/usr --witho=
ut-cuda-driver --enable-checking=3Drelease --build=3Dx86_64-linux-gnu --hos=
t=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu --with-build-config=3Dboot=
strap-lto-lean --enable-link-serialization=3D2
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 11.2.0 (Debian 11.2.0-18)=20
$ aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3Daarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/aarch64-linux-gnu/10/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Debian 10.3.0-8' =
--with-bugurl=3Dfile:///usr/share/doc/gcc-10/README.Bugs --enable-languages=
=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=3D/usr --with-gcc-major-=
version-only --program-suffix=3D-10 --enable-shared --enable-linker-build-i=
d --libexecdir=3D/usr/lib --without-included-gettext --enable-threads=3Dpos=
ix --libdir=3D/usr/lib --enable-nls --with-sysroot=3D/ --enable-clocale=3Dg=
nu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --with-default-li=
bstdcxx-abi=3Dnew --enable-gnu-unique-object --disable-libquadmath --disabl=
e-libquadmath-support --enable-plugin --enable-default-pie --with-system-zl=
ib --enable-libphobos-checking=3Drelease --without-target-system-zlib --ena=
ble-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-chec=
king=3Drelease --build=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu --targe=
t=3Daarch64-linux-gnu --program-prefix=3Daarch64-linux-gnu- --includedir=3D=
/usr/aarch64-linux-gnu/include --with-build-config=3Dbootstrap-lto-lean --e=
nable-link-mutex
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 10.3.0 (Debian 10.3.0-8)                                       =
                                                                           =
                                                                           =
                                                                           =
                =20
g$ it log --oneline -1=20
19dd4538e81e (HEAD -> linux-5.10.y-cip, tag: v5.10.129-cip12, cip/linux-5.1=
0.y-cip) CIP: Bump version suffix to -cip12 after merge from stable        =
                                                                           =
                                                                           =
                                                                           =
                                                    $ make ARCH=3Darm64 mrp=
roper
$ make ARCH=3Darm64 defconfig
$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j32    =20
[....]
No error.
```

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, July 14, 2022 4:41 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Subject: [5.10.y-cip] Build error with defconfig
>=20
> Hi Pavel and Nobuhiro,
>=20
> I get build error[2] with defconfig with this commit id[1].
>=20
> Q1) have you seen this issue?
>=20
> [1]
> commit 19dd4538e81e4019bc96ac6521af3a4ec93e110c (HEAD -> test, tag:
> v5.10.129-cip12, rzg2l-linux/linux-5.10.y-cip, origin/linux-5.10.y-cip,
> linux-5.10.y-cip)
> Author: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Date:   Fri Jul 8 14:30:34 2022 +0900
>=20
>     CIP: Bump version suffix to -cip12 after merge from stable
>=20
> [2]
> Build logs:
> biju@biju-VirtualBox:~/linux-cip$ ~/compile_copy_rzg2l.sh
> *** Default configuration is based on 'defconfig'
> #
> # No change to .config
> #
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      arch/arm64/mm/dma-mapping.o
>   CC      arch/arm64/xen/../../arm/xen/mm.o
>   CC      arch/arm64/mm/init.o
>   CC      kernel/dma/mapping.o
>   CC      kernel/dma/direct.o
>   CC      kernel/dma/ops_helpers.o
>   CC      kernel/dma/dummy.o
>   CC      kernel/dma/contiguous.o
>   CC      kernel/dma/coherent.o
>   CC      kernel/dma/swiotlb.o
>   CC      kernel/dma/pool.o
>   CC [M]  fs/btrfs/disk-io.o
>   CC [M]  fs/btrfs/inode.o
>   CC [M]  fs/btrfs/file.o
> In file included from ./include/linux/dma-map-ops.h:75,
>                  from ./include/linux/dma-direct.h:10,
>                  from arch/arm64/xen/../../arm/xen/mm.c:3:
> ./arch/arm64/include/asm/dma-mapping.h: In function '__generic_dma_ops':
> ./arch/arm64/include/asm/dma-mapping.h:32:26: error: 'struct dev_archdata=
'
> has no member named 'dma_ops'
>    32 |  if (dev && dev->archdata.dma_ops)
>       |                          ^
> ./arch/arm64/include/asm/dma-mapping.h:33:23: error: 'struct dev_archdata=
'
> has no member named 'dma_ops'
>    33 |   return dev->archdata.dma_ops;
>       |                       ^
> ./arch/arm64/include/asm/dma-mapping.h: In function 'get_dma_ops':
> ./arch/arm64/include/asm/dma-mapping.h:45:10: error: 'xen_dma_ops'
> undeclared (first use in this function); did you mean 'get_dma_ops'?
>    45 |   return xen_dma_ops;
>       |          ^~~~~~~~~~~
>       |          get_dma_ops
> ./arch/arm64/include/asm/dma-mapping.h:45:10: note: each undeclared
> identifier is reported only once for each function it appears in
> ./arch/arm64/include/asm/dma-mapping.h: In function
> 'is_device_dma_coherent':
> ./arch/arm64/include/asm/dma-mapping.h:64:22: error: 'struct dev_archdata=
'
> has no member named 'dma_coherent'
>    64 |  return dev->archdata.dma_coherent;
>       |                      ^
> ./arch/arm64/include/asm/dma-mapping.h: At top level:
> ./arch/arm64/include/asm/dma-mapping.h:67:10: fatal error:
> asm-generic/dma-mapping-common.h: No such file or directory
>    67 | #include <asm-generic/dma-mapping-common.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Cheers,
> Biju


