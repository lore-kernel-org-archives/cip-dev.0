Return-Path: <SRS0=pC4D=BV=lists.cip-project.org=bounce+64572+5108+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44AC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 11 Aug 2020 13:58:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF49D2076B
	for <cip-dev@archiver.kernel.org>; Tue, 11 Aug 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U5tHZj41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF49D2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5108+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eNQyYY4521723xAahArI4S1j; Tue, 11 Aug 2020 06:58:49 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.102])
 by mx.groups.io with SMTP id smtpd.web11.15130.1597153301627094647
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2020 06:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/AktX0vdS2MXK59CACe8k8Ymg3CmA6+6dk+de34CbIN/Eneur8cLDJqsn+ZAu0fCtKVhSu+1CorqKRh3La/N6zHmKB7o7yswvj68k7sdEdeh3H/XgjBaJhbY07+rn4C99gfNdLy8WuGQ9M2MaJD/PTLHY/rvEgk819mDjc7MxSP6NSN8ZK4tQAAkvCxN5blqmeq0xiYJPGlIc5fYGMUnxUMGrBZjCuaKQkIryNS8DxO9pRWBqhvSdKp+gO8WaKQRP/sm8EAFoeB79GfxMF4iAI1wwZ+5QBjzRWuNI1gv3pU78rBR3s0VePEJzDemRjYk/6fZhFPiOfXikVMGFICkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxle9t4xNJz8wsZKD7XoVjYCVuySGfGKghZrShze7Gs=;
 b=O5KNgOQ0NlczVEoZP4GC2z0QsGCax9i2fYDp5uGA7sQ828soEAARn3r6nIXArXgFREJQtDe22cM8D9bxN94Yp5CQAnk2x1VRqvfLyg4NglKLVislkaiW/9yVCxAg9IcyhUDRCA0VRORRUiG87FEnUJAoVM5b/iSgB01dJ1mJzUVEVsFX1rwsMb/PbuJNcgy12wZETAIX1kz6jXrG7giYAWmhLM0/iTm6pf9zmyQnu4lbnHbcF/HRVXuetyQjHY5+J7TgGDt3FTZOF2VzHSdIHtGsoEt5xj5qtcHHYABKDRNAnxC6JnCgfcz68OBUosRpH0p0BXOYKLoz5CjjMaamzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYXPR01MB1776.jpnprd01.prod.outlook.com
 (2603:1096:403:12::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 13:41:38 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 13:41:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [linux-cip:linux-4.19.y-cip 7/17] drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for 'drm_atomic_get_old_private_obj_state'
Thread-Topic: [linux-cip:linux-4.19.y-cip 7/17]
 drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
 'drm_atomic_get_old_private_obj_state'
Thread-Index: AQHWblc6UyTwUPv9eECCBW1u6/T3Caky6F9A
Date: Tue, 11 Aug 2020 13:41:37 +0000
Message-ID: 
 <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <202008092247.i5TR1Oel%lkp@intel.com>
In-Reply-To: <202008092247.i5TR1Oel%lkp@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b9a9bd2-2176-49a3-287d-08d83dfc4574
x-ms-traffictypediagnostic: TYXPR01MB1776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYXPR01MB1776105FC81554E2F67DB0F886450@TYXPR01MB1776.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 r7AtT5utPuKcqkOsOozuOf6Tlqitbspar0ZamrACdqFYlvMONOB9Mw3tD5fA84Uuo7c6Vkv1Hx4gXKYWTQHG3tdT2E+dX+C/I40Q+KNEWqoDbr7nJm6nRmVGsIJ0xKKUsBSt46n/y+GZinw5/SgRR9cdi9FgMNfootU/iRyJcmQrV+XF6gysVlP1M+uT00aklUh2TWGmVYmcPr2srtZtM8NgYIEoZPwf/MoX38tP4gzXaiBFe7bdYD+D6RSZr39WzlmdX4/rXvbkDR6lnk7jUR2f94J3Q5dyqtmfMHzxnx3lr3Ceroqx3dgxkrI9FnNM2CIIcxbXoQqyaJ+K40kYklqdpPgDUbImkVT9jj32o66klBNyY1VUYHF0TSLe31t5YvfOGLjep+qzdZCbh6NjoA==
x-ms-exchange-antispam-messagedata: 
 qQ4jOPzmvuC319/B0FhNWcfvk1N0EZHF8umh/Td8ZXLb+OYwLdI76K41YGCKFUuiVuM/fWgOh94xsYfTpCmwA1tYhBkpEenPHpq0snl6gPttoH8MO98EiSljFZ1ky+COFeRRuImBkNYyFT5fRdoaZOCb29oUtX19Q5Mrh7vY2JMfZXIOundkjJozQ1CzHXa7K7rc2pmdpyqJFXAjkizkkmiNuP9ZmB6OCFc5DQvYCNMCBgWWJvXLQh7sPJRGE7go0v6kSzoLnJk0rf+OcGO2iH9EfK8daUnFcKyWOl9jsyZW8ThGWxjFuDaIKSZKNVoWL4UKwBUxifvdLwG7ahIkJwN/EepbiuTQHgdcR2B1om+FpN0VvjoWsWAsI8k6mQPGcZ/z3vRKqrJp/Sa9ii81qfEqxoNQAIlx8gH7Afk6jrvA1TIO6xnoO6JrwQeh2ge98LUNs8Vehmwuu2Utoo+fEoCj5EQET3yQMN5s4Dsh6/C+jwlhLIlhkPnpAuMswP9Gc4TClImqGuf7iPyhWi4BKFByGtucBuLq1zp8q6g/QKqv2Y1pTSNT3nYb9shpJWT4f/eMDVpDb/fmBDzCglkPYNJCtRZ722BbbSHYUJdBJqEOPAFlpDg97rPeZ+RvpdBm5t0oIJNuSJC9+2YDIT+Efw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9a9bd2-2176-49a3-287d-08d83dfc4574
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 13:41:37.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqCGNRlJoZa8mINEH+WOEiNm2bJxZw1zN3QzonT5wmzfSDv6SRPUs0kSMT+zym4pzREX8Jh9ftvyjpfhdzCuaSUasSu/oTgKKhg2WKvSyew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1776
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: M7hqwRuh6eYdiY0VHC2Rssaux4520388AA=
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597154329;
 bh=Kpg1CSce4sMimhIZKQuxVzD9p8PylOatrnPHrPdcKPE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=U5tHZj41JmlAMrnzMXLBj4n5eqGJ9VDD/y7MQZgrYpgOTJc+Mng+dOO50p0ySid+/vM
 XQC0+RTSD38dqPwuLZvxKgTf81O8f1viWJTN9SxV0ALggYsVM2hPHRkCdBv0OW3tBn+hy
 Yu3ULXeJfWkQl5+UAtTIjYyfiGqis9NQ+jA=

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I have received a warning message mail from Kernel test robot. I have inves=
tigated this issue and found there were lots of warnings with architecture =
by following the steps mentioned in this mail.

Then I investigated this particular issue and found that issue is caused by=
 bad commit done by me while backporting. The below backport commit has
extra functions from patch1(0001-drm-Add-drm_atomic_get_old-new_private_obj=
_state.patch), but the corresponding header is missing.

cip commit: cacc2a81b9872aa8830353110b1252021f124ae8
upstream commit: 1b27fbdde1df172dba604855c45078d741f8c858

I have attached 3 patches, that looks like fixes the issue mentioned by ker=
nel robot.

How do we proceed here?
drop cip commit: cacc2a81b9872aa8830353110b1252021f124ae8 and apply the 3 p=
atches to fix this issue?

Please share your views.

Regards,
Biju



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: 09 August 2020 15:13
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: kbuild-all@lists.01.org; Pavel Machek <pavel@denx.de>; Daniel Vetter
> <daniel@ffwll.ch>; Sean Paul <seanpaul@chromium.org>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: [linux-cip:linux-4.19.y-cip 7/17]
> drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
> 'drm_atomic_get_old_private_obj_state'
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=
 linux-
> 4.19.y-cip
> head:   72750517bc5f1718ce3cb3fa75d4cadc05d27eee
> commit: 60b4667275b60d92c760d48df95f5b80bbcfde6e [7/17] drm: Add
> drm_atomic_get_(old|new)_connector_for_encoder() helpers
> config: riscv-randconfig-r034-20200809 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 60b4667275b60d92c760d48df95f5b80bbcfde6e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0
> make.cross ARCH=3Driscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype
> >> for 'drm_atomic_get_old_private_obj_state' [-Wmissing-prototypes]
>     1264 | drm_atomic_get_old_private_obj_state(struct drm_atomic_state
> *state,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/gpu/drm/drm_atomic.c:1286:1: warning: no previous prototype
> >> for 'drm_atomic_get_new_private_obj_state' [-Wmissing-prototypes]
>     1286 | drm_atomic_get_new_private_obj_state(struct drm_atomic_state
> *state,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/drm_atomic.c: In function 'drm_atomic_print_state':
>    drivers/gpu/drm/drm_atomic.c:2184:24: warning: variable 'connector' se=
t
> but not used [-Wunused-but-set-variable]
>     2184 |  struct drm_connector *connector;
>          |                        ^~~~~~~~~
>    drivers/gpu/drm/drm_atomic.c:2182:19: warning: variable 'crtc' set but=
 not
> used [-Wunused-but-set-variable]
>     2182 |  struct drm_crtc *crtc;
>          |                   ^~~~
>    drivers/gpu/drm/drm_atomic.c:2180:20: warning: variable 'plane' set bu=
t
> not used [-Wunused-but-set-variable]
>     2180 |  struct drm_plane *plane;
>          |                    ^~~~~
>    drivers/gpu/drm/drm_atomic.c: In function 'complete_signaling':
>    drivers/gpu/drm/drm_atomic.c:2624:19: warning: variable 'crtc' set but=
 not
> used [-Wunused-but-set-variable]
>     2624 |  struct drm_crtc *crtc;
>          |                   ^~~~
>
> vim +/drm_atomic_get_old_private_obj_state +1264
> drivers/gpu/drm/drm_atomic.c
>
>   1254
>   1255/**
>   1256 * drm_atomic_get_old_private_obj_state
>   1257 * @state: global atomic state object
>   1258 * @obj: private_obj to grab
>   1259 *
>   1260 * This function returns the old private object state for the given
> private_obj,
>   1261 * or NULL if the private_obj is not part of the global atomic stat=
e.
>   1262 */
>   1263struct drm_private_state *
> > 1264drm_atomic_get_old_private_obj_state(struct drm_atomic_state
> *state,
>   1265     struct drm_private_obj *obj)
>   1266{
>   1267int i;
>   1268
>   1269for (i =3D 0; i < state->num_private_objs; i++)
>   1270if (obj =3D=3D state->private_objs[i].ptr)
>   1271return state->private_objs[i].old_state;
>   1272
>   1273return NULL;
>   1274}
>   1275EXPORT_SYMBOL(drm_atomic_get_old_private_obj_state);
>   1276
>   1277/**
>   1278 * drm_atomic_get_new_private_obj_state
>   1279 * @state: global atomic state object
>   1280 * @obj: private_obj to grab
>   1281 *
>   1282 * This function returns the new private object state for the given
> private_obj,
>   1283 * or NULL if the private_obj is not part of the global atomic stat=
e.
>   1284 */
>   1285struct drm_private_state *
> > 1286drm_atomic_get_new_private_obj_state(struct drm_atomic_state
> *state,
>   1287     struct drm_private_obj *obj)
>   1288{
>   1289int i;
>   1290
>   1291for (i =3D 0; i < state->num_private_objs; i++)
>   1292if (obj =3D=3D state->private_objs[i].ptr)
>   1293return state->private_objs[i].new_state;
>   1294
>   1295return NULL;
>   1296}
>   1297EXPORT_SYMBOL(drm_atomic_get_new_private_obj_state);
>   1298
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_
Content-Type: application/octet-stream;
	name="0002-drm-Add-drm_atomic_get_-old-new-_connector_for_encod.patch"
Content-Description: 
 0002-drm-Add-drm_atomic_get_-old-new-_connector_for_encod.patch
Content-Disposition: attachment;
	filename="0002-drm-Add-drm_atomic_get_-old-new-_connector_for_encod.patch";
	size=6257; creation-date="Tue, 11 Aug 2020 13:23:00 GMT";
	modification-date="Tue, 11 Aug 2020 13:23:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MzVkMjZjMWQ5MmYzNWE5ZTBiYmEwMjllYWZiNDNlOThiNzg4MDNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlk
ZWFzb25ib2FyZC5jb20+CkRhdGU6IFR1ZSwgMTEgSnVuIDIwMTkgMTY6NTE6NDMgLTA0MDAKU3Vi
amVjdDogW1BBVENIIDIvM10gZHJtOiBBZGQgZHJtX2F0b21pY19nZXRfKG9sZHxuZXcpX2Nvbm5l
Y3Rvcl9mb3JfZW5jb2RlcigpCiBoZWxwZXJzCgpjb21taXQgMWIyN2ZiZGRlMWRmMTcyZGJhNjA0
ODU1YzQ1MDc4ZDc0MWY4Yzg1OCB1cHN0cmVhbS4KCkFkZCBmdW5jdGlvbnMgdG8gdGhlIGF0b21p
YyBjb3JlIHRvIHJldHJpZXZlIHRoZSBvbGQgYW5kIG5ldyBjb25uZWN0b3JzCmFzc29jaWF0ZWQg
d2l0aCBhbiBlbmNvZGVyIGluIGEgZHJtX2F0b21pY19zdGF0ZS4gVGhpcyBpcyB1c2VmdWwgZm9y
CmVuY29kZXJzIGFuZCBicmlkZ2VzIHRoYXQgbmVlZCB0byBhY2Nlc3MgdGhlIGNvbm5lY3Rvciwg
Zm9yIGluc3RhbmNlIGZvcgp0aGUgZHJtX2Rpc3BsYXlfaW5mby4KClRoZSBDUlRDIGFzc29jaWF0
ZWQgd2l0aCB0aGUgZW5jb2RlciBjYW4gYWxzbyBiZSByZXRyaWV2ZWQgdGhyb3VnaCB0aGUKY29u
bmVjdG9yIHN0YXRlLCBhbmQgZnJvbSBpdCwgdGhlIG9sZCBhbmQgbmV3IENSVEMgc3RhdGVzLgoK
Q2hhbmdlZCBpbiB2NDoKLSBBZGRlZCB0byB0aGUgc2V0CkNoYW5nZWQgaW4gdjU6Ci0gRml4IHVw
IGRvY2Jvb2sgKERhbmllbCAmIExhdXJlbnQpCkNoYW5nZWQgaW4gdjY6Ci0gVXBkYXRlZCBjb21t
aXQgc3ViamVjdCAoU2FtKQoKTGluayB0byB2NDogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0
b3Aub3JnL3BhdGNoL21zZ2lkLzIwMTkwNTA4MTYwOTIwLjE0NDczOS0zLXNlYW5AcG9vcmx5LnJ1
bgpMaW5rIHRvIHY1OiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvbXNn
aWQvMjAxOTA2MTExNjA4NDQuMjU3NDk4LTMtc2VhbkBwb29ybHkucnVuCgpDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3Jn
PgpUZXN0ZWQtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+ClJldmlld2VkLWJ5
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+ClNpZ25lZC1vZmYtYnk6IExhdXJlbnQg
UGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4KCltzZWFucGF1bCBy
ZW1vdmVkIFdBUk5zIGZyb20gaGVscGVycyBhbmQgYWRkZWQgZG9jcyB0byBleHBsYWluIHdoeQpy
ZXR1cm5pbmcgTlVMTCBtaWdodCBiZSB2YWxpZF0KU2lnbmVkLW9mZi1ieTogU2VhbiBQYXVsIDxz
ZWFucGF1bEBjaHJvbWl1bS5vcmc+Ckxpbms6IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9w
Lm9yZy9wYXRjaC9tc2dpZC8yMDE5MDYxMTIwNTE0Ny4xODEyOTgtMS1zZWFuQHBvb3JseS5ydW4K
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljLmMgfCA2OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIGluY2x1ZGUvZHJtL2RybV9hdG9taWMuaCAgICAgfCAgNyArKysrCiBp
bmNsdWRlL2RybS9kcm1fY29ubmVjdG9yLmggIHwgIDkgKysrKysKIDMgZmlsZXMgY2hhbmdlZCwg
ODUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWlj
LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jCmluZGV4IDViYmY5NjllYjQzYS4uZDM2
NzQyNzYxYWRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljLmMKQEAgLTEyOTYsNiArMTI5Niw3NSBAQCBkcm1f
YXRvbWljX2dldF9uZXdfcHJpdmF0ZV9vYmpfc3RhdGUoc3RydWN0IGRybV9hdG9taWNfc3RhdGUg
KnN0YXRlLAogfQogRVhQT1JUX1NZTUJPTChkcm1fYXRvbWljX2dldF9uZXdfcHJpdmF0ZV9vYmpf
c3RhdGUpOwogCisvKioKKyAqIGRybV9hdG9taWNfZ2V0X29sZF9jb25uZWN0b3JfZm9yX2VuY29k
ZXIgLSBHZXQgb2xkIGNvbm5lY3RvciBmb3IgYW4gZW5jb2RlcgorICogQHN0YXRlOiBBdG9taWMg
c3RhdGUKKyAqIEBlbmNvZGVyOiBUaGUgZW5jb2RlciB0byBmZXRjaCB0aGUgY29ubmVjdG9yIHN0
YXRlIGZvcgorICoKKyAqIFRoaXMgZnVuY3Rpb24gZmluZHMgYW5kIHJldHVybnMgdGhlIGNvbm5l
Y3RvciB0aGF0IHdhcyBjb25uZWN0ZWQgdG8gQGVuY29kZXIKKyAqIGFzIHNwZWNpZmllZCBieSB0
aGUgQHN0YXRlLgorICoKKyAqIElmIHRoZXJlIGlzIG5vIGNvbm5lY3RvciBpbiBAc3RhdGUgd2hp
Y2ggcHJldmlvdXNseSBoYWQgQGVuY29kZXIgY29ubmVjdGVkIHRvCisgKiBpdCwgdGhpcyBmdW5j
dGlvbiB3aWxsIHJldHVybiBOVUxMLiBXaGlsZSB0aGlzIG1heSBzZWVtIGxpa2UgYW4gaW52YWxp
ZCB1c2UKKyAqIGNhc2UsIGl0IGlzIHNvbWV0aW1lcyB1c2VmdWwgdG8gZGlmZmVyZW50aWF0ZSBj
b21taXRzIHdoaWNoIGhhZCBubyBwcmlvcgorICogY29ubmVjdG9ycyBhdHRhY2hlZCB0byBAZW5j
b2RlciB2cyBvbmVzIHRoYXQgZGlkIChhbmQgdG8gaW5zcGVjdCB0aGVpcgorICogc3RhdGUpLiBU
aGlzIGlzIGVzcGVjaWFsbHkgdHJ1ZSBpbiBlbmFibGUgaG9va3MgYmVjYXVzZSB0aGUgcGlwZWxp
bmUgaGFzCisgKiBjaGFuZ2VkLgorICoKKyAqIFJldHVybnM6IFRoZSBvbGQgY29ubmVjdG9yIGNv
bm5lY3RlZCB0byBAZW5jb2Rlciwgb3IgTlVMTCBpZiB0aGUgZW5jb2RlciBpcworICogbm90IGNv
bm5lY3RlZC4KKyAqLworc3RydWN0IGRybV9jb25uZWN0b3IgKgorZHJtX2F0b21pY19nZXRfb2xk
X2Nvbm5lY3Rvcl9mb3JfZW5jb2RlcihzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCisJ
CQkJCSBzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpCit7CisJc3RydWN0IGRybV9jb25uZWN0
b3Jfc3RhdGUgKmNvbm5fc3RhdGU7CisJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsK
Kwl1bnNpZ25lZCBpbnQgaTsKKworCWZvcl9lYWNoX29sZF9jb25uZWN0b3JfaW5fc3RhdGUoc3Rh
dGUsIGNvbm5lY3RvciwgY29ubl9zdGF0ZSwgaSkgeworCQlpZiAoY29ubl9zdGF0ZS0+YmVzdF9l
bmNvZGVyID09IGVuY29kZXIpCisJCQlyZXR1cm4gY29ubmVjdG9yOworCX0KKworCXJldHVybiBO
VUxMOworfQorRVhQT1JUX1NZTUJPTChkcm1fYXRvbWljX2dldF9vbGRfY29ubmVjdG9yX2Zvcl9l
bmNvZGVyKTsKKworLyoqCisgKiBkcm1fYXRvbWljX2dldF9uZXdfY29ubmVjdG9yX2Zvcl9lbmNv
ZGVyIC0gR2V0IG5ldyBjb25uZWN0b3IgZm9yIGFuIGVuY29kZXIKKyAqIEBzdGF0ZTogQXRvbWlj
IHN0YXRlCisgKiBAZW5jb2RlcjogVGhlIGVuY29kZXIgdG8gZmV0Y2ggdGhlIGNvbm5lY3RvciBz
dGF0ZSBmb3IKKyAqCisgKiBUaGlzIGZ1bmN0aW9uIGZpbmRzIGFuZCByZXR1cm5zIHRoZSBjb25u
ZWN0b3IgdGhhdCB3aWxsIGJlIGNvbm5lY3RlZCB0bworICogQGVuY29kZXIgYXMgc3BlY2lmaWVk
IGJ5IHRoZSBAc3RhdGUuCisgKgorICogSWYgdGhlcmUgaXMgbm8gY29ubmVjdG9yIGluIEBzdGF0
ZSB3aGljaCB3aWxsIGhhdmUgQGVuY29kZXIgY29ubmVjdGVkIHRvIGl0LAorICogdGhpcyBmdW5j
dGlvbiB3aWxsIHJldHVybiBOVUxMLiBXaGlsZSB0aGlzIG1heSBzZWVtIGxpa2UgYW4gaW52YWxp
ZCB1c2UgY2FzZSwKKyAqIGl0IGlzIHNvbWV0aW1lcyB1c2VmdWwgdG8gZGlmZmVyZW50aWF0ZSBj
b21taXRzIHdoaWNoIGhhdmUgbm8gY29ubmVjdG9ycworICogYXR0YWNoZWQgdG8gQGVuY29kZXIg
dnMgb25lcyB0aGF0IGRvIChhbmQgdG8gaW5zcGVjdCB0aGVpciBzdGF0ZSkuIFRoaXMgaXMKKyAq
IGVzcGVjaWFsbHkgdHJ1ZSBpbiBkaXNhYmxlIGhvb2tzIGJlY2F1c2UgdGhlIHBpcGVsaW5lIHdp
bGwgY2hhbmdlLgorICoKKyAqIFJldHVybnM6IFRoZSBuZXcgY29ubmVjdG9yIGNvbm5lY3RlZCB0
byBAZW5jb2Rlciwgb3IgTlVMTCBpZiB0aGUgZW5jb2RlciBpcworICogbm90IGNvbm5lY3RlZC4K
KyAqLworc3RydWN0IGRybV9jb25uZWN0b3IgKgorZHJtX2F0b21pY19nZXRfbmV3X2Nvbm5lY3Rv
cl9mb3JfZW5jb2RlcihzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCisJCQkJCSBzdHJ1
Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpCit7CisJc3RydWN0IGRybV9jb25uZWN0b3Jfc3RhdGUg
KmNvbm5fc3RhdGU7CisJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsKKwl1bnNpZ25l
ZCBpbnQgaTsKKworCWZvcl9lYWNoX25ld19jb25uZWN0b3JfaW5fc3RhdGUoc3RhdGUsIGNvbm5l
Y3RvciwgY29ubl9zdGF0ZSwgaSkgeworCQlpZiAoY29ubl9zdGF0ZS0+YmVzdF9lbmNvZGVyID09
IGVuY29kZXIpCisJCQlyZXR1cm4gY29ubmVjdG9yOworCX0KKworCXJldHVybiBOVUxMOworfQor
RVhQT1JUX1NZTUJPTChkcm1fYXRvbWljX2dldF9uZXdfY29ubmVjdG9yX2Zvcl9lbmNvZGVyKTsK
KwogLyoqCiAgKiBkcm1fYXRvbWljX2dldF9jb25uZWN0b3Jfc3RhdGUgLSBnZXQgY29ubmVjdG9y
IHN0YXRlCiAgKiBAc3RhdGU6IGdsb2JhbCBhdG9taWMgc3RhdGUgb2JqZWN0CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmggYi9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKaW5k
ZXggZDJmZjQ1NmNlNzJmLi42MzI5ZWQ0YWYzMTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2Ry
bV9hdG9taWMuaAorKysgYi9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKQEAgLTQwOSw2ICs0MDks
MTMgQEAgc3RydWN0IGRybV9wcml2YXRlX3N0YXRlICoKIGRybV9hdG9taWNfZ2V0X25ld19wcml2
YXRlX29ial9zdGF0ZShzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCiAJCQkJICAgICBz
dHJ1Y3QgZHJtX3ByaXZhdGVfb2JqICpvYmopOwogCitzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqCitk
cm1fYXRvbWljX2dldF9vbGRfY29ubmVjdG9yX2Zvcl9lbmNvZGVyKHN0cnVjdCBkcm1fYXRvbWlj
X3N0YXRlICpzdGF0ZSwKKwkJCQkJIHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2Rlcik7CitzdHJ1
Y3QgZHJtX2Nvbm5lY3RvciAqCitkcm1fYXRvbWljX2dldF9uZXdfY29ubmVjdG9yX2Zvcl9lbmNv
ZGVyKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKKwkJCQkJIHN0cnVjdCBkcm1fZW5j
b2RlciAqZW5jb2Rlcik7CisKIC8qKgogICogZHJtX2F0b21pY19nZXRfZXhpc3RpbmdfY3J0Y19z
dGF0ZSAtIGdldCBjcnRjIHN0YXRlLCBpZiBpdCBleGlzdHMKICAqIEBzdGF0ZTogZ2xvYmFsIGF0
b21pYyBzdGF0ZSBvYmplY3QKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9jb25uZWN0b3Iu
aCBiL2luY2x1ZGUvZHJtL2RybV9jb25uZWN0b3IuaAppbmRleCA5N2VhNDFkYzY3OGYuLjZmMGEw
NWI2NTgxZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oCisrKyBiL2lu
Y2x1ZGUvZHJtL2RybV9jb25uZWN0b3IuaApAQCAtMzk3LDYgKzM5NywxNSBAQCBzdHJ1Y3QgZHJt
X2Nvbm5lY3Rvcl9zdGF0ZSB7CiAJICogVXNlZCBieSB0aGUgYXRvbWljIGhlbHBlcnMgdG8gc2Vs
ZWN0IHRoZSBlbmNvZGVyLCB0aHJvdWdoIHRoZQogCSAqICZkcm1fY29ubmVjdG9yX2hlbHBlcl9m
dW5jcy5hdG9taWNfYmVzdF9lbmNvZGVyIG9yCiAJICogJmRybV9jb25uZWN0b3JfaGVscGVyX2Z1
bmNzLmJlc3RfZW5jb2RlciBjYWxsYmFja3MuCisJICoKKwkgKiBUaGlzIGlzIGFsc28gdXNlZCBp
biB0aGUgYXRvbWljIGhlbHBlcnMgdG8gbWFwIGVuY29kZXJzIHRvIHRoZWlyCisJICogY3VycmVu
dCBhbmQgcHJldmlvdXMgY29ubmVjdG9ycywgc2VlCisJICogJmRybV9hdG9taWNfZ2V0X29sZF9j
b25uZWN0b3JfZm9yX2VuY29kZXIoKSBhbmQKKwkgKiAmZHJtX2F0b21pY19nZXRfbmV3X2Nvbm5l
Y3Rvcl9mb3JfZW5jb2RlcigpLgorCSAqCisJICogTk9URTogQXRvbWljIGRyaXZlcnMgbXVzdCBm
aWxsIHRoaXMgb3V0IChlaXRoZXIgdGhlbXNlbHZlcyBvciB0aHJvdWdoCisJICogaGVscGVycyks
IGZvciBvdGhlcndpc2UgdGhlIEdFVENPTk5FQ1RPUiBhbmQgR0VURU5DT0RFUiBJT0NUTHMgd2ls
bAorCSAqIG5vdCByZXR1cm4gY29ycmVjdCBkYXRhIHRvIHVzZXJzcGFjZS4KIAkgKi8KIAlzdHJ1
Y3QgZHJtX2VuY29kZXIgKmJlc3RfZW5jb2RlcjsKIAotLSAKMi4xNy4xCgo=

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_
Content-Type: application/octet-stream;
	name="0003-drm-atomic-helper-fix-W-1-warnings.patch"
Content-Description: 0003-drm-atomic-helper-fix-W-1-warnings.patch
Content-Disposition: attachment;
	filename="0003-drm-atomic-helper-fix-W-1-warnings.patch"; size=4621;
	creation-date="Tue, 11 Aug 2020 13:23:00 GMT";
	modification-date="Tue, 11 Aug 2020 13:23:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiOTRlOWRkNTcwMGIwMDY2OWFiYTZlMDZlMWQxYmQyNjI5YWIzNzM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRA
c3QuY29tPgpEYXRlOiBUdWUsIDggT2N0IDIwMTkgMTQ6NDI6NTQgKzAyMDAKU3ViamVjdDogW1BB
VENIIDMvM10gZHJtOiBhdG9taWMgaGVscGVyOiBmaXggVz0xIHdhcm5pbmdzCgpjb21taXQgYmY1
ZDgzN2EwYTRjZWQ3Y2MyMjNiZWZjOWU3NmQ0YWQzMDY5N2QyNyB1cHN0cmVhbS4KCkZldyBmb3Jf
ZWFjaCBtYWNybyBzZXQgdmFyaWFibGVzIHRoYXQgYXJlIG5ldmVyIHVzZWQgbGF0ZXIgd2hpY2gg
bGVkCnRvIGdlbmVyYXRlIHVudXNlZC1idXQtc2V0LXZhcmlhYmxlIHdhcm5pbmdzLgpBZGQgKHZv
aWQpKGZvbykgaW5zaWRlIHRoZSBtYWNyb3MgdG8gcmVtb3ZlIHRoZXNlIHdhcm5pbmdzCgpTaWdu
ZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPgpS
ZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KTGluazog
aHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoL21zZ2lkLzIwMTkxMDA4MTI0
MjU0LjIxNDQtMS1iZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20KU2lnbmVkLW9mZi1ieTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPgotLS0KIGluY2x1ZGUvZHJtL2RybV9hdG9t
aWMuaCB8IDE3ICsrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fYXRvbWlj
LmggYi9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKaW5kZXggNjMyOWVkNGFmMzEwLi45MDQyZmRh
ZTkyMTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9hdG9taWMuaAorKysgYi9pbmNsdWRl
L2RybS9kcm1fYXRvbWljLmgKQEAgLTY2Miw2ICs2NjIsNyBAQCB2b2lkIGRybV9zdGF0ZV9kdW1w
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fcHJpbnRlciAqcCk7CiAJICAgICAo
X19pKSsrKQkJCQkJCQkJXAogCQlmb3JfZWFjaF9pZiAoKF9fc3RhdGUpLT5jb25uZWN0b3JzW19f
aV0ucHRyICYmCQkJXAogCQkJICAgICAoKGNvbm5lY3RvcikgPSAoX19zdGF0ZSktPmNvbm5lY3Rv
cnNbX19pXS5wdHIsCVwKKwkJCSAgICAgKHZvaWQpKGNvbm5lY3RvcikgLyogT25seSB0byBhdm9p
ZCB1bnVzZWQtYnV0LXNldC12YXJpYWJsZSB3YXJuaW5nICovLCBcCiAJCQkgICAgIChvbGRfY29u
bmVjdG9yX3N0YXRlKSA9IChfX3N0YXRlKS0+Y29ubmVjdG9yc1tfX2ldLm9sZF9zdGF0ZSwJXAog
CQkJICAgICAobmV3X2Nvbm5lY3Rvcl9zdGF0ZSkgPSAoX19zdGF0ZSktPmNvbm5lY3RvcnNbX19p
XS5uZXdfc3RhdGUsIDEpKQogCkBAIC02ODMsNiArNjg0LDcgQEAgdm9pZCBkcm1fc3RhdGVfZHVt
cChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX3ByaW50ZXIgKnApOwogCSAgICAg
KF9faSkrKykJCQkJCQkJCVwKIAkJZm9yX2VhY2hfaWYgKChfX3N0YXRlKS0+Y29ubmVjdG9yc1tf
X2ldLnB0ciAmJgkJCVwKIAkJCSAgICAgKChjb25uZWN0b3IpID0gKF9fc3RhdGUpLT5jb25uZWN0
b3JzW19faV0ucHRyLAlcCisJCQkgICAgICh2b2lkKShjb25uZWN0b3IpIC8qIE9ubHkgdG8gYXZv
aWQgdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgd2FybmluZyAqLywgXAogCQkJICAgICAob2xkX2Nv
bm5lY3Rvcl9zdGF0ZSkgPSAoX19zdGF0ZSktPmNvbm5lY3RvcnNbX19pXS5vbGRfc3RhdGUsIDEp
KQogCiAvKioKQEAgLTcwMyw3ICs3MDUsOSBAQCB2b2lkIGRybV9zdGF0ZV9kdW1wKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fcHJpbnRlciAqcCk7CiAJICAgICAoX19pKSsrKQkJ
CQkJCQkJXAogCQlmb3JfZWFjaF9pZiAoKF9fc3RhdGUpLT5jb25uZWN0b3JzW19faV0ucHRyICYm
CQkJXAogCQkJICAgICAoKGNvbm5lY3RvcikgPSAoX19zdGF0ZSktPmNvbm5lY3RvcnNbX19pXS5w
dHIsCVwKLQkJCSAgICAgKG5ld19jb25uZWN0b3Jfc3RhdGUpID0gKF9fc3RhdGUpLT5jb25uZWN0
b3JzW19faV0ubmV3X3N0YXRlLCAxKSkKKwkJCSAgICAgKHZvaWQpKGNvbm5lY3RvcikgLyogT25s
eSB0byBhdm9pZCB1bnVzZWQtYnV0LXNldC12YXJpYWJsZSB3YXJuaW5nICovLCBcCisJCQkgICAg
IChuZXdfY29ubmVjdG9yX3N0YXRlKSA9IChfX3N0YXRlKS0+Y29ubmVjdG9yc1tfX2ldLm5ld19z
dGF0ZSwgXAorCQkJICAgICAodm9pZCkobmV3X2Nvbm5lY3Rvcl9zdGF0ZSkgLyogT25seSB0byBh
dm9pZCB1bnVzZWQtYnV0LXNldC12YXJpYWJsZSB3YXJuaW5nICovLCAxKSkKIAogLyoqCiAgKiBm
b3JfZWFjaF9vbGRuZXdfY3J0Y19pbl9zdGF0ZSAtIGl0ZXJhdGUgb3ZlciBhbGwgQ1JUQ3MgaW4g
YW4gYXRvbWljIHVwZGF0ZQpAQCAtNzIzLDcgKzcyNyw5IEBAIHZvaWQgZHJtX3N0YXRlX2R1bXAo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRybV9wcmludGVyICpwKTsKIAkgICAgIChf
X2kpKyspCQkJCQkJCVwKIAkJZm9yX2VhY2hfaWYgKChfX3N0YXRlKS0+Y3J0Y3NbX19pXS5wdHIg
JiYJCVwKIAkJCSAgICAgKChjcnRjKSA9IChfX3N0YXRlKS0+Y3J0Y3NbX19pXS5wdHIsCVwKKwkJ
CSAgICAgICh2b2lkKShjcnRjKSAvKiBPbmx5IHRvIGF2b2lkIHVudXNlZC1idXQtc2V0LXZhcmlh
YmxlIHdhcm5pbmcgKi8sIFwKIAkJCSAgICAgKG9sZF9jcnRjX3N0YXRlKSA9IChfX3N0YXRlKS0+
Y3J0Y3NbX19pXS5vbGRfc3RhdGUsIFwKKwkJCSAgICAgKHZvaWQpKG9sZF9jcnRjX3N0YXRlKSAv
KiBPbmx5IHRvIGF2b2lkIHVudXNlZC1idXQtc2V0LXZhcmlhYmxlIHdhcm5pbmcgKi8sIFwKIAkJ
CSAgICAgKG5ld19jcnRjX3N0YXRlKSA9IChfX3N0YXRlKS0+Y3J0Y3NbX19pXS5uZXdfc3RhdGUs
IDEpKQogCiAvKioKQEAgLTc2Miw3ICs3NjgsOSBAQCB2b2lkIGRybV9zdGF0ZV9kdW1wKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fcHJpbnRlciAqcCk7CiAJICAgICAoX19pKSsr
KQkJCQkJCQlcCiAJCWZvcl9lYWNoX2lmICgoX19zdGF0ZSktPmNydGNzW19faV0ucHRyICYmCQlc
CiAJCQkgICAgICgoY3J0YykgPSAoX19zdGF0ZSktPmNydGNzW19faV0ucHRyLAlcCi0JCQkgICAg
IChuZXdfY3J0Y19zdGF0ZSkgPSAoX19zdGF0ZSktPmNydGNzW19faV0ubmV3X3N0YXRlLCAxKSkK
KwkJCSAgICAgKHZvaWQpKGNydGMpIC8qIE9ubHkgdG8gYXZvaWQgdW51c2VkLWJ1dC1zZXQtdmFy
aWFibGUgd2FybmluZyAqLywgXAorCQkJICAgICAobmV3X2NydGNfc3RhdGUpID0gKF9fc3RhdGUp
LT5jcnRjc1tfX2ldLm5ld19zdGF0ZSwgXAorCQkJICAgICAodm9pZCkobmV3X2NydGNfc3RhdGUp
IC8qIE9ubHkgdG8gYXZvaWQgdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgd2FybmluZyAqLywgMSkp
CiAKIC8qKgogICogZm9yX2VhY2hfb2xkbmV3X3BsYW5lX2luX3N0YXRlIC0gaXRlcmF0ZSBvdmVy
IGFsbCBwbGFuZXMgaW4gYW4gYXRvbWljIHVwZGF0ZQpAQCAtNzgyLDYgKzc5MCw3IEBAIHZvaWQg
ZHJtX3N0YXRlX2R1bXAoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRybV9wcmludGVy
ICpwKTsKIAkgICAgIChfX2kpKyspCQkJCQkJCVwKIAkJZm9yX2VhY2hfaWYgKChfX3N0YXRlKS0+
cGxhbmVzW19faV0ucHRyICYmCQlcCiAJCQkgICAgICgocGxhbmUpID0gKF9fc3RhdGUpLT5wbGFu
ZXNbX19pXS5wdHIsCVwKKwkJCSAgICAgICh2b2lkKShwbGFuZSkgLyogT25seSB0byBhdm9pZCB1
bnVzZWQtYnV0LXNldC12YXJpYWJsZSB3YXJuaW5nICovLCBcCiAJCQkgICAgICAob2xkX3BsYW5l
X3N0YXRlKSA9IChfX3N0YXRlKS0+cGxhbmVzW19faV0ub2xkX3N0YXRlLFwKIAkJCSAgICAgIChu
ZXdfcGxhbmVfc3RhdGUpID0gKF9fc3RhdGUpLT5wbGFuZXNbX19pXS5uZXdfc3RhdGUsIDEpKQog
CkBAIC04NDIsNyArODUxLDkgQEAgdm9pZCBkcm1fc3RhdGVfZHVtcChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCBzdHJ1Y3QgZHJtX3ByaW50ZXIgKnApOwogCSAgICAgKF9faSkrKykJCQkJCQkJXAog
CQlmb3JfZWFjaF9pZiAoKF9fc3RhdGUpLT5wbGFuZXNbX19pXS5wdHIgJiYJCVwKIAkJCSAgICAg
KChwbGFuZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tfX2ldLnB0ciwJXAotCQkJICAgICAgKG5ld19w
bGFuZV9zdGF0ZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tfX2ldLm5ld19zdGF0ZSwgMSkpCisJCQkg
ICAgICAodm9pZCkocGxhbmUpIC8qIE9ubHkgdG8gYXZvaWQgdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGUgd2FybmluZyAqLywgXAorCQkJICAgICAgKG5ld19wbGFuZV9zdGF0ZSkgPSAoX19zdGF0ZSkt
PnBsYW5lc1tfX2ldLm5ld19zdGF0ZSwgXAorCQkJICAgICAgKHZvaWQpKG5ld19wbGFuZV9zdGF0
ZSkgLyogT25seSB0byBhdm9pZCB1bnVzZWQtYnV0LXNldC12YXJpYWJsZSB3YXJuaW5nICovLCAx
KSkKIAogLyoqCiAgKiBmb3JfZWFjaF9vbGRuZXdfcHJpdmF0ZV9vYmpfaW5fc3RhdGUgLSBpdGVy
YXRlIG92ZXIgYWxsIHByaXZhdGUgb2JqZWN0cyBpbiBhbiBhdG9taWMgdXBkYXRlCi0tIAoyLjE3
LjEKCg==

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_
Content-Type: application/octet-stream;
	name="0001-drm-Add-drm_atomic_get_old-new_private_obj_state.patch"
Content-Description: 
 0001-drm-Add-drm_atomic_get_old-new_private_obj_state.patch
Content-Disposition: attachment;
	filename="0001-drm-Add-drm_atomic_get_old-new_private_obj_state.patch";
	size=3338; creation-date="Tue, 11 Aug 2020 13:23:00 GMT";
	modification-date="Tue, 11 Aug 2020 13:23:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4Yjk2OTJiOGIzMWI0MmRlZDRjZTI0NzMzZmI2ZjE5OGMxOTdlZTg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiamFtZXMgcWlhbiB3YW5nIChBcm0gVGVjaG5vbG9neSBDaGlu
YSkiIDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4KRGF0ZTogVHVlLCAyMiBKYW4gMjAxOSAxMTow
NTo0MSArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMS8zXSBkcm06IEFkZCBkcm1fYXRvbWljX2dldF9v
bGQvbmV3X3ByaXZhdGVfb2JqX3N0YXRlCgpjb21taXQgOTgwMWE3ZWFkZjRjYzI5Y2RjOTA1ODNh
NDlmMTJkZWNiYjgzMmNlZCB1cHN0cmVhbS4KClRoaXMgcGFpciBvZiBmdW5jdGlvbnMgcmV0dXJu
IHRoZSBvbGQvbmV3IHByaXZhdGUgb2JqZWN0IHN0YXRlIGZvciB0aGUKZ2l2ZW4gcHJpdmF0ZV9v
YmosIG9yIE5VTEwgaWYgdGhlIHByaXZhdGVfb2JqIGlzIG5vdCBwYXJ0IG9mIHRoZSBnbG9iYWwK
YXRvbWljIHN0YXRlLgoKUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBHaGVvcmdoZSA8YWxleGFuZHJ1
LWNvc21pbi5naGVvcmdoZUBhcm0uY29tPgpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBRaWFuIFdhbmcg
KEFybSBUZWNobm9sb2d5IENoaW5hKSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+ClNpZ25lZC1v
ZmYtYnk6IExpdml1IER1ZGF1IDxsaXZpdS5kdWRhdUBhcm0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2RybV9hdG9taWMuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
aW5jbHVkZS9kcm0vZHJtX2F0b21pYy5oICAgICB8ICA2ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDUwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21p
Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMuYwppbmRleCAxYTRiNDQ5MjNhZWMuLjVi
YmY5NjllYjQzYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pYy5jCkBAIC0xMjUyLDYgKzEyNTIsNTAgQEAgZHJt
X2F0b21pY19nZXRfcHJpdmF0ZV9vYmpfc3RhdGUoc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0
YXRlLAogfQogRVhQT1JUX1NZTUJPTChkcm1fYXRvbWljX2dldF9wcml2YXRlX29ial9zdGF0ZSk7
CiAKKy8qKgorICogZHJtX2F0b21pY19nZXRfb2xkX3ByaXZhdGVfb2JqX3N0YXRlCisgKiBAc3Rh
dGU6IGdsb2JhbCBhdG9taWMgc3RhdGUgb2JqZWN0CisgKiBAb2JqOiBwcml2YXRlX29iaiB0byBn
cmFiCisgKgorICogVGhpcyBmdW5jdGlvbiByZXR1cm5zIHRoZSBvbGQgcHJpdmF0ZSBvYmplY3Qg
c3RhdGUgZm9yIHRoZSBnaXZlbiBwcml2YXRlX29iaiwKKyAqIG9yIE5VTEwgaWYgdGhlIHByaXZh
dGVfb2JqIGlzIG5vdCBwYXJ0IG9mIHRoZSBnbG9iYWwgYXRvbWljIHN0YXRlLgorICovCitzdHJ1
Y3QgZHJtX3ByaXZhdGVfc3RhdGUgKgorZHJtX2F0b21pY19nZXRfb2xkX3ByaXZhdGVfb2JqX3N0
YXRlKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKKwkJCQkgICAgIHN0cnVjdCBkcm1f
cHJpdmF0ZV9vYmogKm9iaikKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBzdGF0ZS0+
bnVtX3ByaXZhdGVfb2JqczsgaSsrKQorCQlpZiAob2JqID09IHN0YXRlLT5wcml2YXRlX29ianNb
aV0ucHRyKQorCQkJcmV0dXJuIHN0YXRlLT5wcml2YXRlX29ianNbaV0ub2xkX3N0YXRlOworCisJ
cmV0dXJuIE5VTEw7Cit9CitFWFBPUlRfU1lNQk9MKGRybV9hdG9taWNfZ2V0X29sZF9wcml2YXRl
X29ial9zdGF0ZSk7CisKKy8qKgorICogZHJtX2F0b21pY19nZXRfbmV3X3ByaXZhdGVfb2JqX3N0
YXRlCisgKiBAc3RhdGU6IGdsb2JhbCBhdG9taWMgc3RhdGUgb2JqZWN0CisgKiBAb2JqOiBwcml2
YXRlX29iaiB0byBncmFiCisgKgorICogVGhpcyBmdW5jdGlvbiByZXR1cm5zIHRoZSBuZXcgcHJp
dmF0ZSBvYmplY3Qgc3RhdGUgZm9yIHRoZSBnaXZlbiBwcml2YXRlX29iaiwKKyAqIG9yIE5VTEwg
aWYgdGhlIHByaXZhdGVfb2JqIGlzIG5vdCBwYXJ0IG9mIHRoZSBnbG9iYWwgYXRvbWljIHN0YXRl
LgorICovCitzdHJ1Y3QgZHJtX3ByaXZhdGVfc3RhdGUgKgorZHJtX2F0b21pY19nZXRfbmV3X3By
aXZhdGVfb2JqX3N0YXRlKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKKwkJCQkgICAg
IHN0cnVjdCBkcm1fcHJpdmF0ZV9vYmogKm9iaikKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7
IGkgPCBzdGF0ZS0+bnVtX3ByaXZhdGVfb2JqczsgaSsrKQorCQlpZiAob2JqID09IHN0YXRlLT5w
cml2YXRlX29ianNbaV0ucHRyKQorCQkJcmV0dXJuIHN0YXRlLT5wcml2YXRlX29ianNbaV0ubmV3
X3N0YXRlOworCisJcmV0dXJuIE5VTEw7Cit9CitFWFBPUlRfU1lNQk9MKGRybV9hdG9taWNfZ2V0
X25ld19wcml2YXRlX29ial9zdGF0ZSk7CisKIC8qKgogICogZHJtX2F0b21pY19nZXRfY29ubmVj
dG9yX3N0YXRlIC0gZ2V0IGNvbm5lY3RvciBzdGF0ZQogICogQHN0YXRlOiBnbG9iYWwgYXRvbWlj
IHN0YXRlIG9iamVjdApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2F0b21pYy5oIGIvaW5j
bHVkZS9kcm0vZHJtX2F0b21pYy5oCmluZGV4IDFlNzEzMTU0ZjAwZS4uZDJmZjQ1NmNlNzJmIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKKysrIGIvaW5jbHVkZS9kcm0vZHJt
X2F0b21pYy5oCkBAIC00MDIsNiArNDAyLDEyIEBAIHZvaWQgZHJtX2F0b21pY19wcml2YXRlX29i
al9maW5pKHN0cnVjdCBkcm1fcHJpdmF0ZV9vYmogKm9iaik7CiBzdHJ1Y3QgZHJtX3ByaXZhdGVf
c3RhdGUgKiBfX211c3RfY2hlY2sKIGRybV9hdG9taWNfZ2V0X3ByaXZhdGVfb2JqX3N0YXRlKHN0
cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKIAkJCQkgc3RydWN0IGRybV9wcml2YXRlX29i
aiAqb2JqKTsKK3N0cnVjdCBkcm1fcHJpdmF0ZV9zdGF0ZSAqCitkcm1fYXRvbWljX2dldF9vbGRf
cHJpdmF0ZV9vYmpfc3RhdGUoc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLAorCQkJCSAg
ICAgc3RydWN0IGRybV9wcml2YXRlX29iaiAqb2JqKTsKK3N0cnVjdCBkcm1fcHJpdmF0ZV9zdGF0
ZSAqCitkcm1fYXRvbWljX2dldF9uZXdfcHJpdmF0ZV9vYmpfc3RhdGUoc3RydWN0IGRybV9hdG9t
aWNfc3RhdGUgKnN0YXRlLAorCQkJCSAgICAgc3RydWN0IGRybV9wcml2YXRlX29iaiAqb2JqKTsK
IAogLyoqCiAgKiBkcm1fYXRvbWljX2dldF9leGlzdGluZ19jcnRjX3N0YXRlIC0gZ2V0IGNydGMg
c3RhdGUsIGlmIGl0IGV4aXN0cwotLSAKMi4xNy4xCgo=

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5108): https://lists.cip-project.org/g/cip-dev/message=
/5108
Mute This Topic: https://lists.cip-project.org/mt/76126617/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--_004_TYBPR01MB53096578ABB1E74E2E2153DA86450TYBPR01MB5309jpnp_--
