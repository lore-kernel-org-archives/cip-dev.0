Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD9C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 12:56:13 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web11.34481.1702040168356151094
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 04:56:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=a+Wi0faH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.127, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGJnX6SXQR/7nSK76BLA/dC9o9AoB3n0myC44esogCpszW3PKmG1cRL5TqLNDugAfQhVCMEg+MzegIP+dDGvZBVomAHWDL4EkeWj+avnniXKgySSGC1ZULO5W623kH4WHXiNzeBPDqGJx04Iokizx5GHHIwNQ03IgtbMBfdtRFqb8SI+ii9d3aFqB8SH383PXYxwbrr7b0bXq/C73EDF+you9rklYf5eJ167Aq7mzPTbJQSxHVHyKWfM2sKH5MnCUnqSJeLAFqRZyBPDnwBgLcsLOtIOSwcRxbXuHuIZi2VhFJS5G5ifZ0XsXJDExjNBZ/z0ve2xPfPQjgMNgMdWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C79c8Foq0aR2eaUhRnOwCHQqmx2Mc3lsKX9U0k8ps0I=;
 b=f9OMsHfXUubP6IbbyjBz9Txi7uyr+0sR6XYWcEj6DKSlCD7ZP086vNmaz/KVuX+BdvFkhDiJbzpyuYIrh5IA2sjMb8macsG3noqTc6ivZPG+SiwOhJi/tFTxYeQa5j3p61WoQz+TyEYLB7mvEtAWOuuydwVWIf2voaIo/EQqjXCYfK3Zml+6PHm4sZz0RUM3k2/SXYL9I/UWjWOLTFgSoN/Om6saFFgk2fUeXYlBB1J2pA/kH72pv+3bePhvcQW/K3h0TgqCGR5MlO49flXMBThObY5+tYajX/ueHtBoNm3ATV27ICQGoRo5BEZDz6l6WAERdNSYb5P2UuTRPhsV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C79c8Foq0aR2eaUhRnOwCHQqmx2Mc3lsKX9U0k8ps0I=;
 b=a+Wi0faHGo3OFkqtyR1u12tDMrcA9MrfqchFzIGpx1veRGSznjE6XT33YOYDNwOPOytbmAtwid7M9fRJBf6XtBBCDjR4qpWJ/ETTlfehE5DpC0BriVihjmvkbTiDgzT3gxopwkLOXrBld9BQUvdndSacE+M3tENWQECBDyAKoHs=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB8221.jpnprd01.prod.outlook.com
 (2603:1096:400:102::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.17; Fri, 8 Dec
 2023 12:56:03 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.017; Fri, 8 Dec 2023
 12:56:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Thread-Index: AQHaKRktq19Gr3VJJkGFymjyi+1WiLCfQ/EAgAAISiCAAAxasA==
Date: Fri, 8 Dec 2023 12:56:03 +0000
Message-ID: 
 <TYCPR01MB11269F077DA6442CC5B953138868AA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
 <ZXMAOPmuU1J+JCtw@duo.ucw.cz> <179ED9F671D9670E.16398@lists.cip-project.org>
In-Reply-To: <179ED9F671D9670E.16398@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB8221:EE_
x-ms-office365-filtering-correlation-id: 55a13d34-e850-4e87-8aac-08dbf7ed08f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5spLTUmzAI3xjxhW907Vief8Ex4kYy4UFzUQfuXwZuuH2GpJhxq4Qt90ufyB4g1FBQbhFoGnVppRFb/JUuRPwPDvc9Guoa3qYGzLPEUqEQtfq0AUX2kdR5fnzQJ7iCskf2L+gxPXyxNTGLYni3m1FZ8hm0ue5WdebvyqeYaT4ty5K+68QPFKXTykFmKQfGWV0m7jix+eflPJCDHHA1I/QfC7FXnE8TdzGFso6BliNSBp09+TTBY7ZpKZinGsPwCoamoQRNHSY/hhT3d1yK8PelXs+8wNp8564gDx4YI40bwnCJq+i9rusSPS9kiQpAZVAA/cL/cr16ey80kYBFKhHW7EB7vgCE/WaT10n59LlGMc6DplOAl1B4gBK6VG/p00mNWyO+M8RWEo5FUX9Ma4iMDHfLrLWu0IvHpzbeMEc0KYFDESZUm10BeHKRKWTZFYchzJIr13QCgADgchSvv1wRyjbSDhfQNdXY2FHe8ZXqqfiwXJ3TDq0i7Y63/L9KBn1srb0DZxY7BzACVKSZqp8z/OMZCtBJyXmxYq01QF9sEfIyrBnQZnRUsATJNeO8h9MOUexaROdtlLcDbX5IsCXv8v8cYpFpIVK0giWX9gbzLz6NMroPF2Hqzh/At2R1EvhfopWUErC7DdvWTsOPr3ZQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38070700009)(41300700001)(38100700002)(478600001)(5660300002)(26005)(107886003)(45080400002)(110136005)(71200400001)(4326008)(8676002)(8936002)(66556008)(52536014)(66446008)(66476007)(316002)(66946007)(76116006)(64756008)(966005)(54906003)(55016003)(33656002)(122000001)(53546011)(9686003)(6506007)(7696005)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?p0bMMDFZm1eyrrgMj11nPpQdylwXCSofSoV4bFFNL4tS7+kP6tRgMaQ3mGKc?=
 =?us-ascii?Q?6jWTKoLq7hBRTrgizN5Ao3rTM+/YkkvE5sOIYRAzZpiq76xGCpY3X63jy2L0?=
 =?us-ascii?Q?CRTQXUAqhj9MnfBZaPlew/WZbktDWZNdYWV9KjFq4YBqOm3PLz1BZy7+107j?=
 =?us-ascii?Q?UhWU4yzoyj7SuLPph6Cr28sNkx+5arrXndU9l05/fkro5GeGZYEHoqzPDcuJ?=
 =?us-ascii?Q?4pdy+bcommG7FNa3D6y8UhsnMiR+6+kIVOTR8E1gPPYttz6EjeJkxl5iu2jo?=
 =?us-ascii?Q?Gu2Ii0VI6bJCs9t3LTHh0/+yCbB38tnW32eNbvXXcb/maz8YMhxU7CSyhMy6?=
 =?us-ascii?Q?57CTG+4Xn0DyeettNC6AaOQxXWrsx8UD4D1UW17exAOCF9cZvzTJcsDz/WbL?=
 =?us-ascii?Q?dNfx0RWCH21YFJ03H5AHhHMZJo3cEo51yYyHMXmuSMYNBRrQAdTAuo5CLNdO?=
 =?us-ascii?Q?vaB8F16YHnNzNxgjfDfB6MWfUvz4u0gH5IQatFjW3UUwYe/ltevtIdUa2Sze?=
 =?us-ascii?Q?YTuNpbAw1YSqF2h5dHvhOKzkkhgsHhMdCnqTh819wtdl7qxTq79cbFY9Yt0M?=
 =?us-ascii?Q?NliWbItyn0VPWZY6Sm0AcrrIcwJWP3TshuQqF6rrvml1Jh9X2yI3/g59e0Wm?=
 =?us-ascii?Q?AB4jSAxN8kTnVbyCR2m0tm5zeYQyBoqJccd+u3o1HcPKRcVa7eYOUgUxhTxj?=
 =?us-ascii?Q?mqkRu059j5CNcN92k9XkflwlDWCdpT2eqbA1hNxyALMNAFIeF1qxz6crQsZX?=
 =?us-ascii?Q?6zz/ltGTFv+HrlTa5kcKntt4A8hBeg1cJF2zv6ZBZ7jbV0f1+hCLvlVORDph?=
 =?us-ascii?Q?b4/e5uZyf+29R/VD0xOxNEdJGKkto2Rjt6syN9vlgydTdcNZDahsCjGvL9XN?=
 =?us-ascii?Q?CALt3AVi79rhMFUjb7UFjHNJjoW11fmuM7vTn/DA8w3LmdlTmHBe1E+9I7/f?=
 =?us-ascii?Q?P0Qc0C8zFUM5KX+TSR0Enzy2lfeLebF5hIx+wzG9vdcBg1Bg0xXbabHycJn5?=
 =?us-ascii?Q?+9Yhe/hEduxQIusCS9gpwr0u/OsUU/EvsAJSMmtw839rVykfEmgLKrRJ95/m?=
 =?us-ascii?Q?G3P+freIgrzHsCrDD/nXcEUmIoZELBJR8GkfI1kphnANqGr1+/IrRcBS7Mfx?=
 =?us-ascii?Q?3bm6LXnD7hx9+SVw8Q3cOAUXdotFjmZumm5ltIFqO7TebQQMJVuZ3WOvFv0B?=
 =?us-ascii?Q?k3S2ZaJKMsiHQTK6fn9zgNF08nM54+rFmo6L1ueXpraIjpLh0hGj6So57PGz?=
 =?us-ascii?Q?Gbg+3BMgjJ9b9omt2SwZQn66rtplFjPA+23mvW6ockgTTU/qHAziogwJIN6o?=
 =?us-ascii?Q?78K+1EBcCz+KWUuJQUXllG/oE/MUAEn3t02g67pdLA3LMTNzt3xmWefQhHcE?=
 =?us-ascii?Q?4IrGMjbAiKw3fhPaus5BAFTtmV3lrFMM+zExg+WYmAvvVD9Z/AEu6zxY3Gr6?=
 =?us-ascii?Q?9/oZChkTOaTWkYF+rf3YdWBeliD1Rp/qrUB9TEO6mozLosIT+Om0inFWVKbw?=
 =?us-ascii?Q?CV+WcJIZ/Pc7uHM7xVt3kZ+VC0xzcTUIADws8ZVxwnSZzC9rkc29g/uQIrlU?=
 =?us-ascii?Q?TPsdEOOTkMvosOUtN8HKT5u+0Po9UwmG7rBOBCmJxLYUgigabNtjeniqkd8w?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a13d34-e850-4e87-8aac-08dbf7ed08f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 12:56:03.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXVxF0ZKmZ3dt3J2pRaPW8Almqk+VN0qVrDO96XtdZfpZL8ybpx3tz4LuQDzDj1e3HoJEtXODWQ15kf0PorGaLTpK1bEXWswFcEFq+UxA4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8221
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 12:56:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13939

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Biju Das via lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
>=20
> Hi Pavel Machek,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Friday, December 8, 2023 11:39 AM
> > Subject: Re: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
> >
> > Hi!
> >
> > > This patch series aims to add RZ/G2L DSI support on RZ/{G2L,GLC,V2L}
> > > SMARC EVKs.
> > >
> > > All the patches are cherry-picked from the mainline, except [1] and
> > > [2]
> > >
> > > Without [1] DU is giving probe failure as the encoder is not able to
> > > find all the connected bridges due to the framework changes between
> > > mainline and 5.10 kernel. So just restructured the bridge handling.
> > >
> > > IA55 IRQ driver is not backported to 5.10, so defining it in dts is
> > > giving warnings, so drop IRQs in patch[2].
> >
> > This series fails testing on x86:
> >
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-%2Fjobs%2F5706662029&
> > data=3D05%7C02%7Cbiju.das.jz%40bp.renesas.com%7Cab1879377b15488f4c8f08d=
b
> > f7e68432%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6383763416551582
> > 43%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D9A%2FwCfd9i0XsElIxzSShy=
U
> > J%2FIE0FS5e6yqRz26tOjkM%3D&reserved=3D0
> >
> >   CC      drivers/hid/hid-lg4ff.o
> > 3346In file included from drivers/gpu/drm/drm_bridge_connector.c:11:
> > 3347./include/drm/drm_bridge.h:903:34: error: static declaration of
> > 'devm_drm_of_get_bridge' follows non-static declaration
> > 3348  903 | static inline struct drm_bridge
> > *devm_drm_of_get_bridge(struct device *dev,
> > 3349      |                                  ^~~~~~~~~~~~~~~~~~~~~~
> > 3350./include/drm/drm_bridge.h:894:20: note: previous declaration of
> > 'devm_drm_of_get_bridge' was here
> > 3351  894 | struct drm_bridge *devm_drm_of_get_bridge(struct device
> > *dev, struct device_node *node,
> > 3352      |                    ^~~~~~~~~~~~~~~~~~~~~~
> > 3353  CC      drivers/hid/hid-lg-g15.o
> > 3354make[3]: *** [scripts/Makefile.build:286:
> > drivers/gpu/drm/drm_bridge_connector.o] Error 1
> > 3355make[3]: *** Waiting for unfinished jobs....
> > 3356  CC      drivers/hid/hid-microsoft.o
> > 3357
>=20
> I can reproduce the issue here with x86. I am looking on to it.
>=20
>=20
> In file included from drivers/gpu/drm/drm_bridge_connector.c:11:
> ./include/drm/drm_bridge.h:903:34: error: static declaration of
> 'devm_drm_of_get_bridge' follows non-static declaration
>   903 | static inline struct drm_bridge *devm_drm_of_get_bridge(struct
> device *dev,
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~
> ./include/drm/drm_bridge.h:894:20: note: previous declaration of
> 'devm_drm_of_get_bridge' was here
>   894 | struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
> struct device_node *node,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:286:
> drivers/gpu/drm/drm_bridge_connector.o] Error 1
> make[2]: *** [scripts/Makefile.build:503: drivers/gpu/drm] Error 2
> make[1]: *** [scripts/Makefile.build:503: drivers/gpu] Error 2
> make[1]: *** Waiting for unfinished jobs....


The build issue is related to patch [1]

[1]
https://patchwork.kernel.org/project/cip-dev/patch/20231207142502.401651-3-=
biju.das.jz@bp.renesas.com/

I have done some mistake while fixing the conflict.

The correct patch is below. I will send v2 soon.

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3c640e704186..6bfc13b69475 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -891,9 +891,20 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct de=
vice *dev,
 struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 						   struct drm_panel *panel,
 						   u32 connector_type);
+struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge=
);
+#endif
+
+#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
 struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct devic=
e_node *node,
 					  u32 port, u32 endpoint);
-struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge=
);
+#else
+static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev=
,
+							struct device_node *node,
+							u32 port,
+							u32 endpoint)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
=20
 #endif
--=20
2.25.1


Cheers,
Biju


