Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB0C7EE2E
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 08:22:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web10.53985.1686558131010597701
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 01:22:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.133, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 35C8M26u004602; Mon, 12 Jun 2023 17:22:02 +0900
X-Iguazu-Qid: 2wHHWgyRzcqPGDUkbs
X-Iguazu-QSIG: v=2; s=0; t=1686558122; q=2wHHWgyRzcqPGDUkbs; m=PnPlMxjLVS5g8AQyxRofa9mbCEPHqQkH2Yh3EWlGjSk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 35C8M0ji025954
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Jun 2023 17:22:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWJFyjnMaTYkZ9Avw1AR8vJ6Cl0tcBxDusnqlVxHeSBqxnhISrE5qDcUa1of/h4NbZgrsCz9jAP/SSMe/9jWRSB/BsXeu5ro3Tn8nTmQD8eRAMl6vJLnAhjGzRAu3FuocgwpgRKdB3e0iI/uec0ws6MeqD90DVrdteRpR7AUT7B6kbkrcQc4s71srG8AByChHUceOqirYTQLmenh+soiQ4BVn10slmBdf2eQEwaCL2l6sp+h2JGz49O2BtM8xvHrtY9xb33xHvASz+dMAs2Byjr0PnxD8CXgdb1kidwiJXwHVyZsQeo8NjDWx30/ME5yrDFIjapX9rjrX7mvBAoFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aeg99a2F35tce/wJbGl1dCoeZzOhgJU3wvr0mTocI8=;
 b=Ma6OCd7spgvx8K3xIDF52dSoTtXJShYuezOalh7KBEzeMY3jdvgCJ3dko4N6MvgeTzHR2gnDzkMF63vDTWtctkXVXwwdH/La4ADcsjcLrZfbQDiJAGoa/BaFlxD7uTfkYTeuEeh/VZJtpDKCkl60GjYNso86TZFRiOT1KGPKUrkJUq2RD9K9eeBDG1ZU3k1bvIHKa9ji79tYUdCiCb5r27FKWV8tjbdzPat26b9sTbsYthnGOorQcEgS8+9eAvEkzKCx/m5f6o+yHdKGNiWZpMOCaiEwSbrEDf5j1JF18DU2jl+RKOIl5arD02s/PLJJ5LYbh2dM/nwjAjQZT0PPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip] dt-bindings: usb: ti,hd3ss3220: Update
 interrupt property as optional
Thread-Topic: [PATCH 6.1.y-cip] dt-bindings: usb: ti,hd3ss3220: Update
 interrupt property as optional
Thread-Index: AQHZnP8h7aCRZIJn/kOl3jzO+5TidK+G09yw
Date: Mon, 12 Jun 2023 08:21:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942090D9FB9D207AB142B59A9254A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230612072546.80479-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230612072546.80479-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB6195:EE_
x-ms-office365-filtering-correlation-id: 25ca33aa-8722-435e-a53a-08db6b1e16b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UDbZoo3Q1ggLfKMnsJ0VrAHraehqF+FK/cDvPegj4f5UXGeHWi3JoHfm9NSe2RFK6hrbIo9ye/oCQkQ2EslOZqNGywvsZnvzWnctnkwtgvw3nfExI078ypg9lJIAUgK1sCTYYOpxz/OC9f77m0LEdhRWOnAeoKrfH5z/pBT0JgS6UeK8+nYC5ETy0YullikY+YbLnLvWveVZvrxzP/sj0gZf8nKVIzHGW2Lr7L/tpEgrkjDCvmidKFlMqrG2rCIaYSJ9JFcIbtE4/MwhzijEzAD/eAXIatyuG5JTcQ4/b9hSG1bOfoxHBN0tZlOuQkjWiI7y4jajZPXP48Kaxsf/D45oKTITIuUXITbFxWpGAptmLPIf/3DnsYAgdC1tZgb+LtcA6NetaMHGohMe3nNL30j3vZ3m6nJhytYoBqaMMqhUayvOdds4T5UVZRx5oVHDu3hlU+FDRYkWRBj6YF4BCG05LB/PXhE7Nqj3rKIR2ao/EjqWmpCR4I8GFzGImQM03Xu4Hx0MJlgzVCAoVieVyHOKsAb+fkFytMJE2h+9CqlP+qS7lhUVw6noVhnuGpsyyH0EylbMdVdj6sA1B97wE0tP/FyJ2RskUwVKlTVdJnnZ/XOt4AF9Kzuz9KRHvxYnkW5u2Ko9V9BnzR7erjZkSg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(2906002)(38070700005)(86362001)(33656002)(15650500001)(52536014)(55016003)(966005)(7696005)(186003)(83380400001)(6506007)(26005)(9686003)(53546011)(122000001)(71200400001)(110136005)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(5660300002)(316002)(38100700002)(478600001)(8676002)(8936002)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RGI4RUFaSWY3UllrYktrWCtjMHhYUzEzSHdWbEE0QUpzeGVmeGwwTXdK?=
 =?iso-2022-jp?B?MVkwdTgwZFJJYVM1WU9tQXY5bjNpTTZaY3dsVlFVSFlscFphcXNMNUlu?=
 =?iso-2022-jp?B?dXIzdTZJcjQrWHR5b1ZSem1HN3pTakNyeG5tVFFVbmkyaHhLdlZZYlYw?=
 =?iso-2022-jp?B?dTBZUGZsTzhZMlBCcUg1ZTIyQzVrWnNUN3NTdm83QUdhNHhkbGU5dEpH?=
 =?iso-2022-jp?B?TjdYWm9UcG50eEJRaVFITjhHNjBOMXduZUFkMzVVYnQyV3JFMng0T2xX?=
 =?iso-2022-jp?B?Q3BhQVZpRFhLUUpROEZiWVRnenNLajNxMDdnRjA3R3EySStVYkF5WkRu?=
 =?iso-2022-jp?B?eTRlSkZvOStzUnE2dHhUN3Bwa3MvWjkrZjlqZnpKS1d0R1lLUHhpNVo4?=
 =?iso-2022-jp?B?b1F0WWxWbENPYmlyQTNEU2FNek54bUhjSXRnSFFnSWQvcEF0SHFZUHZP?=
 =?iso-2022-jp?B?Y3crWXdlK0VyVXcrdDJxQXJGL2wyUmwvTnlCWnMwVUEra1F1L05kM3pj?=
 =?iso-2022-jp?B?L2pzV1dXaG1ZRHpNR0NYV2RmY205bmF4M1oxRWZ6d3QzWFl1eUt5aHBF?=
 =?iso-2022-jp?B?cFk3RURjWk9NN1hIS0NVelcwZ3g1QzNlMlVrNHBIMTMrNjhRa3EwUnBI?=
 =?iso-2022-jp?B?QXh1YnlKWGJRTC9uZXQrUWx2V0NlK3ZJTlF5TXllMmJVcUN3bERWS0FR?=
 =?iso-2022-jp?B?a1ZDVDZ0SG1kYTNiZEhKYmRrTGZJeUFsaGhkZzlrOUVld2JUdTlvWGE5?=
 =?iso-2022-jp?B?bFVpa1BJVVhhdUx2bGhTem1Tb3RKK0J0QjMxMDB1ci9yUU5VWE9SQ2JN?=
 =?iso-2022-jp?B?R2Q4d21VUEZVTFRmZXJzQU5uMnlnZEx3eDU5dkpXb2YzNHNmT1FtdDZL?=
 =?iso-2022-jp?B?K3pvUkFGSEtNT2hTRjBUSFRxVEFLc3BpcGJLTkFvdFQ1a3hTVTdzTENh?=
 =?iso-2022-jp?B?R1BFcDFieDNtYUdTa1EvZGxkbUZzTFVkTVhldGNTTzZQV1RiVGtMa0FN?=
 =?iso-2022-jp?B?YmY1d0Zkc3pvQjVDOXlxUFpDcE9GNGh5aEw5YldJRUJtS3dwNEEvM01F?=
 =?iso-2022-jp?B?NGU1NHhDQWF5ZGh5NzRFRTkxNDhrYjBYUkNkWHJKVW9zUHpjd1hReEdC?=
 =?iso-2022-jp?B?dHkxVUhRR1JWdENnSXNnMlE0cDdHWE5nU1RtUzdBU2crb2g5cXVBemw1?=
 =?iso-2022-jp?B?MldMa0pMN0hDelVXTldkWHJVa3g1aDY3ZVBiOEUwWUFMYkdISWFXY2t1?=
 =?iso-2022-jp?B?V1pNMlZVK2cxOTY1NWZLOGtIZ2tzTmpkdVd4cVpSYXRzL29hTXU3elFt?=
 =?iso-2022-jp?B?T2VUNklYVEcvMlNGbjZsai84cTdNNGlqK01pN2k4TWc2R0N4QTVyVEFn?=
 =?iso-2022-jp?B?dHlqUkllS2M0YWN5Z1NDREhQUGpRK2FrQVZ6a0x1aEZjM3dBa1EvcmV6?=
 =?iso-2022-jp?B?SE02LzBuOEV1V0h4RTVKeUtab1ZrOG1McHY5MXpGVlRLQjdlUkdGendw?=
 =?iso-2022-jp?B?emtnUTduNDBJRXNzU1hsMTA0ZG41d0hNTFN3enZabzVrWlVDMEJYSFU4?=
 =?iso-2022-jp?B?YkxKRzBYclhOa1JjMjU2eVMwdFhhdktqTmE4Q0lEWStJdUUxay9mUTZo?=
 =?iso-2022-jp?B?ZW5JRDcycXRNQXB1UnhKUjhiQkpZVUxTVGgxeWRUNzlYOWJwWUNjYTNP?=
 =?iso-2022-jp?B?Q3IvcGdmelBKZXZYdzJWNzE5UnRPdGRQeklVQWUwWStiaWU2TS9RQUdu?=
 =?iso-2022-jp?B?VzR5bmJsMWkvUzM4ZzhXVjRSbjlHckhkaHFERVpCTG5RcURzZmtBRDFD?=
 =?iso-2022-jp?B?WGwyZUFuU2RnUEV1UjE3cW1PT0hsN3M3aHVXRUhtSUJQYXY0aG93OU1o?=
 =?iso-2022-jp?B?YnkvTXR6b2xjaUhEVENzVWFtY1lZZGxjNmh6Mm1kYVErTTNpanJJT0dZ?=
 =?iso-2022-jp?B?dUpUc29YUy9BMlVPR0h6VXJYQjJsaWJwMEpEamdLWnYyc25HQ3RJaDZ5?=
 =?iso-2022-jp?B?VWxvYU13R2ZBVE9xa2hPMmZyNVJDck51RUdXdGVDcGRBMUJrWVFlcGtR?=
 =?iso-2022-jp?B?WENmRURJakdmNHRLWW9qV1B6eDcrMmswdmRNQnF5b05uaVZLMCtSMmEx?=
 =?iso-2022-jp?B?NmE5N0RaY3NwMWtSL3dvbjlESGVYNXAvUDBHcElyb3NoV0w0ZWtoK3ZO?=
 =?iso-2022-jp?B?dEovbHpUNDNPTGJubkQyZWJuK3EwK2xJckIrZ1FLQ2JvUnNWL3krcTZj?=
 =?iso-2022-jp?B?NTVEQ2IzbWNWRmwzOElxdVZsQkdFdEpnNGtwNnZvdG81QmN4OTZ1Rkoz?=
 =?iso-2022-jp?B?cFZ6TVJTaVRNYUp2K2ZvdHFLZ1JialkrUnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	banyCFJ453HSye6Sz0AYRzYSDTXmdW+m4+2B6aaQFe5TChDByAPzj4vsWcuOnxlrhzy6o/iU3tyQcDimp/+zctDhLvxUSztMASeWxrHs5dGrW81U21QeyTzitiiq3PjF+/KRd67FGDAdkp9HlkHpKVOeIxeeXv44bRkWRahHPgyUdE+fTNJkz4kLnmQhWDxVNkep0Zdx/oxmrbGJ+40JhAqfBWNIVI60zsbua+3qFzDQls4iPxK4hGzz5neprZtPDWAk5QXiBeKNXPUjtcC75tdcLfiY6gHqLvdh5nTzTdaeqMqrg9paxkJF8X/xN9Hs1+V8ut+gueEr9HIwSLhupRDkV1GtjXJXzq28VMff1bkhakBDg44gdL1UR/c17c9GmuO6gvsBebx1XjXPtPTzqDO2Dgq7FuuB+8eyYY2E6nD7T6t/JET+CE/gR6Ow9NM84VkueNnufwLio1dXmWmpHz45YQqTAi4Mo0X5SDk2czSQWDpM7raILkeupTBk5pvrkU7Vs2mrz9x8OYMnyaEbq39972TkmOtezmTNjT/cSYr1lkJASEufqbl2Dymz3Ha0IWLHJVBKktGb/4w5uun2lkQCJ3n4vkdFA1l9E+3z5GsQc8Qq6CAvZWicaJEABJeBe/FMglVabRsfa+MgVbSoqGi9tR/7uyriw88Qt+xUwZ38zv4oWgpJV2QHBnKlU4LEVc5qaN4HIwRyUo6tIIVxTzGwz74LhM5xUPDvpchuQVNHPhrvsNNbw4xBcYp+lYznwqp/x+CUjzjeT9szz3xmbxLcQoARXMccow9M6Mqs5AlxVcYM+sDGH0Ws5+eZi5l2E76mbr6sgrsDbQN4P4nRIzhyCn29YyJNZvJcTKGzSTEL9sn0u3JuhsAbK2blE/DcifpjSrpImT+TNzKG6F7KeA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca33aa-8722-435e-a53a-08db6b1e16b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:21:57.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+XhKNCUaM+Ykc5rlO0dJtuTzz9J2uEA6NWm0ytrbFLhSjTGwPgXxUY0WHmgTS9jZB0g4SCe+I43Dn85BX84jwpd6baF3bLi8QT/30XF+mTqujnK/bXftw2g0OfYzx+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6195
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 08:22:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11976

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, June 12, 2023 4:26 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip] dt-bindings: usb: ti,hd3ss3220: Update interru=
pt
> property as optional
>=20
> commit bf58a687db232e738105244e34a85d21f5e2598d upstream.
>=20
> On some platforms(for eg: RZ/V2M EVK), interrupt is not populated. Update
> the binding to make interrupt property as optional.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20221209171836.71610-2-biju.das.jz@bp.renesas.c=
o
> m
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> index b86bf6bc9cd6..a1cffb70c621 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> @@ -46,7 +46,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>=20
>  additionalProperties: false
>=20
> --
> 2.25.1

Looks good to me.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


