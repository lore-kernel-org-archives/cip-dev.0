Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28762C7EE24
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 23:32:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.6508.1684193550275539099
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 16:32:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 34FNWKli003409; Tue, 16 May 2023 08:32:20 +0900
X-Iguazu-Qid: 34trKxHUsKzmWhmJX7
X-Iguazu-QSIG: v=2; s=0; t=1684193540; q=34trKxHUsKzmWhmJX7; m=nXvbn5Az2H7ntM7Uo+pdJ8MGzu2tq733tIwTJPjc+ew=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 34FNWIlx010054
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 08:32:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk03/vQ9pK91mJ/KGFLqStE+7/PPlrXJnqEpK/OOGDZS8IV4q2kmiA9jwvUsTDLoIqoFglHDkCSXB/9udTWMWxnmzugyEcBUeDCRfQG7LL1w/Lft+NRxgzmo6Ekfnaj3zZizxbH8wtkYFFVvWnHLHDtHu9LDsvMzKdb6k7CDhWXIlLg9984bbKW2X2H/g5sl8ak3QmOxpLrMbYAeyCKPkAs4PmoS4Blm0mHmx9pSm13omQ9AJq8qIKhOwZjvrPHrWF9rwd5dqP+TEL6PK6JxorHnnvNuKhPlTehOaUhyES0YxAqkZlWre2KBXfW+HpnwKXgbBobZn1VU2jeCYtezOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c/0BBoG9HItGdPvF0eUa3wMai6wgxuWalC5xluipsI=;
 b=TxX35GkXd6fNW40VqZmXWNg6qsj3HOZeUbXUutTxWrmT2B6kKtEpsVXIR62T0DPP4DtzkYoILspVgRN5iDos2ZJ9qHhyjxfI9oToEpClzM3Yhf9tUNeImDWIoXz7FTffWWa45OBD0eCwv5PBOX1svXYx0jjjPGs9bVyT2xVW/DMT7EPbpuNvN5U3hl1FQAXuSm7JyLh7NoRc8VslRMdc0wfq49iMF4anv3hN/6lXGtkXrs3ahQR5Jl3BHWWXPcQQOqo0SkiwpKdZkGY6adFZQCOFfy90xte83XXf8vZ9gXYc4uZAVbugalwdrLb6fcaTatToVyc6wOP/Fm1YDIG07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
Thread-Topic: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
Thread-Index: AQHZhwrNcSadp26Tm0urowzu3AdBU69b/Jdg
Date: Mon, 15 May 2023 23:32:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94208EECEE9BAB87C9725F8692789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9674:EE_
x-ms-office365-filtering-correlation-id: ba3f67eb-d12d-4268-8049-08db559c9e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kigL89RSCMEa5C0DYrUaZnWkWBV586VuZtiKo3HSHBVZHfPgFDZD4JQZ9SYohgqzgWQPin1z1l5SwMov8acadPXhPgdXca03MyajoB1QT3Oh3pijaYk6ztLJt+M+LBPtYEHDqKm7Rn1QflNl2qkSzFdDIxhnhfRzKff/2jcj3xo+MYg1E+j+oIEh3OMXincNsh30wYZ0HdrEtOXO9vcdlH+laoaTHBxiaTnAexgEk2LY2+VEJDwcYqtXDieJ4CUnk07dxtidPDfivn7OjUqgP6cSCMYbYnh2hHCxo/dPEd8EbchHcCDPcp4N7wBAy5Ia4R2iZWPQSJ3/fWEPPHxqhGHf+fK26a7EG5ojTbJAwPR0SZ3hwozzztxTzgrw58uRskbPPye3aJohDHP51qaLaQkKdx2xkRIvLSowHvUMzJX3KGXMdsVsPvhmm8fvqniKo1FiK7uKfrIExkVYDtDR5CuQLx5ctE5qZitUKHyoOcqQ836bZMWR/RxKqCA7wFZ+mx9xDkCc/VjWFRDBoUfmZukYzJWdXBDD7Blu5D0BVwRxJmJf27GotznXxAqr/FrbR9qvYci1Zt1nWtwMwJWiv9VT3sCPaBbJ8CTxpLSpa8Y66zDQ2qZGFAC5y0vbcGp9wPMnSlTPXMZewvr5za4tig==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(26005)(9686003)(53546011)(6506007)(83380400001)(55016003)(86362001)(33656002)(122000001)(38100700002)(38070700005)(186003)(54906003)(110136005)(478600001)(2906002)(316002)(41300700001)(52536014)(5660300002)(8676002)(8936002)(4326008)(64756008)(66946007)(66476007)(66556008)(66446008)(76116006)(71200400001)(7696005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VTJVVm5FMGxKZ1Q4ajBubFpEamRTNkxsWHQxWHdJWUozeE1uL0pTNlJz?=
 =?iso-2022-jp?B?UXFVR3FMZWtYVG1YT3NNbDViKy84a2hSVXhmckl2dTBHT1lrUkcwbHNR?=
 =?iso-2022-jp?B?V0xqWDl6SzlwV0xyczVmTDZ6VGpJbTZXWDBaZjVyN2VIQ3BsTUtPcTh4?=
 =?iso-2022-jp?B?d0g2YVNKVEc1eGVCMEFCRjZwVjc4a05CU2lNZ0d5SzU1RzRQOTdOTzFU?=
 =?iso-2022-jp?B?NjFZenJ0NkU1a3NHc2dXRkZLY0xwTzhhTCtrbUpWY1hjQmlZNnJ6MDB4?=
 =?iso-2022-jp?B?dkJvVG5JYis0L3RNOHdBbjJsSFJLUkYxNG5ycW5DZC84Q0pPbGZrNW43?=
 =?iso-2022-jp?B?THhMSU8xZ3RYdDdEdzh5M3VQQkhpcXIzQk9Vc2wrMXNvZHpiRnZNYUh6?=
 =?iso-2022-jp?B?Nk5GYUx5V3BwNGdPL3lSMHJZYmFGV29jdnp1aDkycmJacllPZDA5YlM1?=
 =?iso-2022-jp?B?Mjg2MkVLVVduOElBNWxSY01EV1ZpQ0g5bTIrQk1WOHlYYTNSTXdudmxV?=
 =?iso-2022-jp?B?YjdVL09KR1Fkb3ZlZzdXVWowZ2UwTkFxeVJaVEJSR3hmMTJXdWdGMVhH?=
 =?iso-2022-jp?B?MG9NcEN2UHVZZS93K1EyaDJhQ3ZlUDBOSXMzZk1GYmxqcDlmbnFxQVRx?=
 =?iso-2022-jp?B?bkVmd2FjY3AzR0hoSFFqVXVsQWk1QnBqajFZVmMwYlpVc21xR1RYWDNq?=
 =?iso-2022-jp?B?VWlLTGNWbVZTdDN6MjRld0hTWHZNcWdmMWZNQ0FrY1VIcTVObUpkY3Fp?=
 =?iso-2022-jp?B?ci9tZHBHcHNLckEyQytZR0YreEVvQm9hU1FGcXRmYkZWa3g2cVFRbEFa?=
 =?iso-2022-jp?B?M1J3UHFKc2I1M2lkZWxaSU9FcHc3MEQ1aG4xdkVOV1VYN2NzMWh4QjVC?=
 =?iso-2022-jp?B?L2Y5K3V5S1hXSmE0YUZpenpOT2RFcWM0UHp5ZE5VQnRXUDM2MHoyYUV6?=
 =?iso-2022-jp?B?VlFwNnR5V1R1bVNpYTdTR2QwNjBpV29sUDFkcjNNTWYwUWRHS3VuUnh4?=
 =?iso-2022-jp?B?cHVWTFByZmozTWVpaXhFTWJiSGs0eWlSMHdQY3JCQXlrY2xlT1pZRS81?=
 =?iso-2022-jp?B?U2QwUjhaZElBMGNoQUVmYWI5M0pHdGE5Q2J1cGQ3ZElhNkxISXhQWmk2?=
 =?iso-2022-jp?B?WW5tRlE1clhJZEZzM3lLZkhPVVYzdmVKdVhNZVd3M2J2b2hmb1E5K0JS?=
 =?iso-2022-jp?B?K1doYllRb2VjWnlmUDJ3ajVqNGxWZEZNMFJnSW1PRzJZSld3QnhnRkFL?=
 =?iso-2022-jp?B?b0pmL0o4TmxpRmFDb1dRN3dqTkFTS0RpNXFvOUZSODVPNWt4OVNPSzhI?=
 =?iso-2022-jp?B?aGVjZTR4R0tRZEkrYll6clBucWpqSXJzZ2JCOUtpaGlMRllscE5WS0k0?=
 =?iso-2022-jp?B?eUViczQ1OGF0dS9VL2FHRUpWaW5SenBTOWlseGFiMU1Nc0wvSFBPVlM0?=
 =?iso-2022-jp?B?NFhSMTBjRFBhVmtDOGdZNzk0dEtQZ2ovWklhQjl6NE1uWHpQaklsSmxM?=
 =?iso-2022-jp?B?dlZLTTJJOFdaQWFUT3d2ZkJKZzB6WFFSa2tTcGlCZ0tQc1QxUHIyZTVI?=
 =?iso-2022-jp?B?T0dwM1VYZ0NON0FiSUIxai8xeUFuTDN2NSt3YUVZQS8xR2RiVjZvSWtN?=
 =?iso-2022-jp?B?emR0WnNsYXcrcWRNK3YweUVQdG1abmgvcFAvbHk3NVpHcEZqNXRnaG5y?=
 =?iso-2022-jp?B?SCthUDhhTmZlamp1ZnhGL0dqYTBNcHA1TTZOZHRlazZnSWlJWC9kbXdz?=
 =?iso-2022-jp?B?akEwa255V1NLeS85WFN3NElKMEEyR0U1K3NxVmJHNWVhb1huc1FnREta?=
 =?iso-2022-jp?B?eVZCL0M3SXZoNkNwRkxwTkx5RFJTbDhRc2JjZDR2cklLYVlBZFRSeTBs?=
 =?iso-2022-jp?B?WXlYbmRjVHdFS0grMHZhWVp1bXYreHd0ZnFzUkRYaVRqcUZtY013cEd2?=
 =?iso-2022-jp?B?MFh4bGJnVndUMGpBSVRZNVUzVzBob042YjdpSWhBVGFoV000RlRCU1NP?=
 =?iso-2022-jp?B?SS85Y0dwaEdiL3p2RUdYdTNkb2hEb2c4VDAycVd2YjdYSXBpNVoyVXdZ?=
 =?iso-2022-jp?B?SSs2cnVqMEQxLzYzRDVJcGREdHhKWDVScFdEaGMxdUIvRkNOMkVYQ0do?=
 =?iso-2022-jp?B?MlhPOWV3OElWakd1d2FqNXNWdjgyLzE1RTIxcS92bzhnN3NVdmdqSjBX?=
 =?iso-2022-jp?B?elBUdi9NQVV3am9iOGNQcUdIMjdIb1lZd3FRMFhzSElZdTZRRnMyR0Yw?=
 =?iso-2022-jp?B?NldhSjBmc212cjluZC9yc1QwZ1lwU0FkUk9ZVGpqcHN2bVFMcWtDak9t?=
 =?iso-2022-jp?B?ODFjQWs4TjBITFBTTGZuRUxkZTh6dy9vZGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DqTWhnnAKkJ5/pUMKSdojY0VbeI6pyC4BD5s9SiPH8S644xSMdQtKjBhL0oKvFLdeaK1sCYdcmTdntem7FOnHy+lzxobj3oZQPszHyKoh0/mxo8zA2svi5+mv2CwuC9GVNT7fYFJxL9MCRWxfGSzXF4zQii+DODBIW2tzm9G58QHVI+27VbL/9FUr6QKdiDF4SaICWKjg6FUtQdkR0l5iNJa02xKyA+o8ODhiMdTD/KcdikkCxqt6pladhc7zwjd5NTnE9xqZKM7iB+WQDAtFXjo+odyrAFP/xzo4Ami/OkazVAFfBQmahZG5EID7Y0IW7M52BgNqtXBep/2FKOKTO9JcNmgnRNJ5VJKHXad+H2JaNjvEE7BVRNTwSO6NIBOA/oxZ6nPWSwy22jKjAfJUv6xao9GzYFj9fRBrynmPws/Y17catP0FNiJNQPwav/GJ3zapkHDtH4abiseTZcugsomDaFKG/06NUTCNyETAmcZIwQxKn6RZtDxOyKu27RNKJolB7n9rBcKKQ4bJTwCtrtZrxuBSOKIogl2Hyf63Gvf3fN4ljWV5XdYj+Y1mlLih1DiRJeJDbc6PQgCvOGJ69PShVqOW63SQHaJow5ks56OWSwEOZz1BBYgozvJx9s7ZEyTr0Yq0VA95JhQyRWQPAQjGJspkOUOHcMFHDPYFkxhJAZkxkcqiZxvy60UwaHzy2F3WKJRJxv85Eaph9G4Sw1JXX3q7Ky7DxarayTuN7FBDo+qhsu0C/+xK7fuWiZ1pCzfbKXFGH/QkOF4HYnQWisCf88Zn3nyIn4/O173/kk9T7N0w1o+DME3Tb3Mg23OIWU5qlbdVJF2bI55vNLQ2d3/7Q7V1ym23d4dPnIQpZImkoDbVuTpjlmToKINLdOANWGjYlUFsbG+S8AhpjMdGQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3f67eb-d12d-4268-8049-08db559c9e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 23:32:16.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhdXEW2zfftYqRwEVs2mQ/k14ngb0q6u6eSaU3kfDzo0wCE7HBaswyKk0rLvyIVTY3LmVo7cOpQVO+GK6ECP/Byqw9ksNwBO1IhGQFZ8R20BArPjoeCj0bBGG+YI8uMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 23:32:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11460

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, May 15, 2023 5:54 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
>=20
> This patch series aims to add DMA reset support fot RZ/G2L alike SoCs
>=20
> Also added a patch to remove unused variable.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Biju Das (3):
>   dt-bindings: dma: rz-dmac: Document clock-names and reset-names
>   dmaengine: sh: rz-dmac: Add reset support
>   arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC
>     nodes
>=20
> Geert Uytterhoeven (1):
>   dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
>=20
>  .../bindings/dma/renesas,rz-dmac.yaml          | 14
> ++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi     |  2 ++
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi     |  2 ++
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi     |  2 ++
>  drivers/dma/sh/rz-dmac.c                       | 18
> ++++++++++++++----
>  5 files changed, 34 insertions(+), 4 deletions(-)
>=20
This series LGTM. I can apply this series.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


> --
> 2.25.1


