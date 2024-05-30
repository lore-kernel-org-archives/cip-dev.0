Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E10C25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 06:49:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.2283.1717051744529597306
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 23:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=J3mltH5U;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717051735;x=1718261335;bh=5Sn8pyI6zfXfHioHOWXVHIWuUhlVUJJtw2a6utk
	clkY=;b=J3mltH5UMr/49mDXOswZtVDwmc0nQTn0oGwPyIo2VJG/oIjyX4IfKYIf3+Towr5uc3uBL
	nO3xIXH8aKW01A4WKw41vkAePXQjIPyOA5BBswpO+whWfCcDjzu//9R+57gGa5EWbgchc424EWXyD
	LTZVX3NPEwNRAQnARUPQRdTEt2DxaCGNw3iFiIKl7sa6YxyF7wr1HYYnmVbKuiJUz5UgLcaZOX/Us
	/FeFzG/st5tGOGdSLuW3ljBWFR9YMVrA/OUfCB3gSXj0Xf0mPIec4+fat0You/ter6Et1NphR2XHG
	Y8QfsuCc/5GrN1OYqTFjUJYfMACixP8JCtaHRgc/ZQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44U6msvl1778247; Thu, 30 May 2024 15:48:55 +0900
X-Iguazu-Qid: 2yAbdMiuZNG6uqrmk7
X-Iguazu-QSIG: v=2; s=0; t=1717051734; q=2yAbdMiuZNG6uqrmk7; m=ONXmTJ0LzCt0KdhyIETlr9DL0P3T69EXutLU97AXqkI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 44U6mr5t3580978
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 15:48:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq/wNpZR7eThLqSaUopsBeg3xTzibAmdFu++Nd3g2NXnyGV+YdPX5xqjZjpOlwCC9aI83J3ed0PjMqA9oa5JSiZfB+ROIgA8Rznrg3XieH3XSg2WRwUkx7RptoOD5YJXGfLU3TJ9mg/1yajSQDCwV26dIUbPchRP2cz16NGqJ3N8AmjoGkg5I+PF9w755XkRkkPSz7MDUAiRD6Hgf1iUcWmCdWcB9shdct/S3UrbrE5pqTU0efxn/vM27avipFBWdSDgoDyABfFJzNlLXUgbjFUQfHnIemsFlfh+LtbWU+nE5vNU/ZRiJ1hLLmeCPHXuHVAyiQu0lUYlk8mYhahiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sn8pyI6zfXfHioHOWXVHIWuUhlVUJJtw2a6utkclkY=;
 b=haup08Q3vH9VawBjQGKxfF6wpHQrw/+Y/2CHO4YQ7/m11JwwgMnP94yBBpkt2PO7EsxD2eqrmtnNIOHE1Q5WUxk9zNrkZ1t4imoHd5BZ4fS6GAx25R61Liy30RvsQnaIkLyzkvKfvOg+WZS4cq4291b9XuuvNLqakX/64/z+f/zaDWsA2xwjEOYeTQR5A6/ynvIqR55QWcZYdz3iiFC4RJqfDOY4lw6vjHU7zrN7e4T1QPnPvX7WmKABlJnbMX/jI0DxHZnD0UROTdP4ZrImK5knT3RANnv7mZRPWOEGUjMnFwzeAbvNAnHSzfuB/Xsu6RWVl69/2wWRcPj99tmhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/47] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Topic: [PATCH 5.10.y-cip 00/47] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Index: AQHasZ+56yAkZGhPGkSEtENJ2teLWbGvUrEg
Date: Thu, 30 May 2024 06:48:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63885CC33A00E94C4BCCC37092F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB10240:EE_
x-ms-office365-filtering-correlation-id: 62dcc3d7-cf2b-439c-90a4-08dc807490bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MWo0bks1bmFrVEdGdGhTLytMOXdVYUNqK256VXdzbllUSUY4c1FCMTlmbGJW?=
 =?utf-8?B?NE1tZFpxdnBvV0EzZ3IzRnhvQVRvaC9VWTdGMHAzQXF4Wlg3L2dFYTY0NlZ3?=
 =?utf-8?B?Nzhkak56N2huQzcvNWQrbWlFbWVjYVhNUVlDbzUyMHBZKzdoMzZhbXNwcjdq?=
 =?utf-8?B?dXVTL1FkSGlxbmZuWmZLclE4VTdtbTBFZ2ZDTVFVZll6RlZMZGRiYjhYOTRk?=
 =?utf-8?B?QkZDdkpZRUIraENlZEF1djVxZlRaYmpmL3pvQlhtRVhsR0xKWDlNSjZQdWNk?=
 =?utf-8?B?ejdrb0N2U3dYS2x5MlltL3JZa3VtWW5LS1BlbXEvSEdNeHNhbWV1ajN0RXpS?=
 =?utf-8?B?VXZOR3BNMTFvU3F1cXpjbzJPSVhwRSszVzJpbzVMUHM2c0h1L202Wm5EdG1B?=
 =?utf-8?B?bGplUitha0poRlhpMUlXcmM5bFp3OEU1K1A4WWVHOTBDUEthNzJsSVFyRE8z?=
 =?utf-8?B?TFNpck5sRDA4SHcrZkcyRjRRMlpMb0J0eWVTUCtGZVY3MkZVVWhWWU5Nb1FE?=
 =?utf-8?B?YWxqeUFRbjdPRzVyZHFFY0gxTVBhZHRXekhDS3F6c0F2VkUyQk1IMmlPbkN1?=
 =?utf-8?B?TlZSTWhkVUxqSW0yM0MzbVMwaGNsTUw0OVJtVWNlemZEV2NzZVJJNFlMWFkx?=
 =?utf-8?B?bEt2RGs2VzZ2YzNhK3NjK1RxNWZiTkdNb09yS25COEhHaGtRZ0FRZW9BVTk4?=
 =?utf-8?B?eDh6OVNzU0s0elp0c1AxMytRUklRdHEwMHlReUNRVU9KNDhRTzRRVlNkaWR3?=
 =?utf-8?B?bmJpckNpM2dCczdwNXNCbG9nMUxGbFRTV1NMZlJoY1BjeUtBcXhRKzlhS1Vv?=
 =?utf-8?B?ZGxuMDdTd2l6K1A1K2ZGbVQyYWhQdk9hSTUxc29OanhTanQ2OTFYOFFJVThu?=
 =?utf-8?B?bHh6VDRhWWt3dk05dldLa0dxS25vWk1sMEtiTXhQZTJNS2VLT2VNQVhFUTJI?=
 =?utf-8?B?Tnkra0I0MVU3c0pSdXRxZUxVUUdNYWErY0FtcE5RODRqUEpoNWJhVGRPTkVu?=
 =?utf-8?B?bThIMGI5YjhRcjJlSEVNaWVIWWdsbno1YTQ1NHRpNGRHQU9XRWhVb3NoZFA1?=
 =?utf-8?B?SkxWREdFK2hSWmQwekI4WHN4eTUvTTkyVllRVGVwNGh3S0ozM25EcTYxN01a?=
 =?utf-8?B?NGVxL21GcEplaDdvK0tuTjhXSGZCRHkzaEh6SFE2QTdYaCsyblllQ1oxOUts?=
 =?utf-8?B?SEpNdm9SWGpCY0h1bVJBQWRGeVdKSUNITm1BbmxwZGpndzhDRS9xRk5LZDE1?=
 =?utf-8?B?bS8zYmZHV0ljZHVJTit2akFhVUczUlhJWUlRaTlNcHA0Q3IxUXVCOWhhUk9Y?=
 =?utf-8?B?cERqcWdrVFdRc2FCdVl4SVlRZXowS1JvOWVOZ3lud2I5Qk1oT3VyV1QwLzdG?=
 =?utf-8?B?MGF4dWdTNGx2bWM3UDg0c29BYm54bzVrYmgrelZaQmxQV05VZWo5Q0FxdkNY?=
 =?utf-8?B?T2tBMmY3N28vbmNqbHhMaEV0Z1B0VzI1SVRETWNFT09VS1dLRmFMMEdnQ2Fo?=
 =?utf-8?B?THNIZFF0RmZYaG5kTC9CSVhLaUR3cUF1TlIwU0tEOVdjbGJDcUJMdnJwVVlU?=
 =?utf-8?B?TGs1TENSTEhFaGl6ODRTaG5kLzNqenlGYjRpRG5oU3BWQWlMTkNsNU1KcEth?=
 =?utf-8?B?NUFYUWRReTBOcmxpd2h2L0QwZ1ZUMW01ZjJ1cVBNcitkVTFTbEJneXJ4alhw?=
 =?utf-8?B?emZwS2FJazgzSEVrUjhNeGh1cXdISUZKRlQzTzgwU3BRQmRvbklhOG1BPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UG9meTRFSlNzeklHL2dodExwdmh3ZEgxSGp3ZXVlakNxcWsrSWFzbUhDUVdK?=
 =?utf-8?B?R01PYUdKSTJ3Y3dkSEFFRXlLdFdSenY0VGFOMjdxbG5NMDZRMHNhL3h3SE1U?=
 =?utf-8?B?bmdRNlJ6VE1YejBHZXFJU2NKaDdEVU9aUGZTY2M4VlhTeU1KOGpxNVhvaXlD?=
 =?utf-8?B?eStUamI3dnJwTnVOdWVIbzFlUUpEdGJnMWt4SEM2L3RpQTc4RUZZclNaZjFl?=
 =?utf-8?B?V2lYaUtlM0NOcXNQM280TVQ1eHRTNUgwN3JuZWphVEZRQmZtemxGazJlY1R3?=
 =?utf-8?B?UzE2OW9aRzlqZHNQSmtyOEpPMXZNRlBWVnA2MHBOU2VHTi9xY05ISHZZNjRH?=
 =?utf-8?B?ZDYwVTJmMXdxamZhV3k3MXMwSmFST282aVRmcWE3YUpSb0hnYUxzM25IeW1n?=
 =?utf-8?B?dTllOE8ra2ZkOUVLdmovcVZ3Yy9DbUlBb2d6aCtxRVlEcHlDL0FLT2hIRHVJ?=
 =?utf-8?B?SDVMc0lGRHlIVUY5eHY1aUFZMzJHUktBajY3SDV1cWtTQm9lcGNZcFpVNy9I?=
 =?utf-8?B?b3hyZUNNVFlkbm1jRWlBSXRvMklmbWtQUCs1WFgvZW1DVnVjZU9ueUErdmNo?=
 =?utf-8?B?eDltN2FJaTRmRWUxREFRb0FWbUk2UTU1SElleWdHZ2d4ZHM3SXVNQWM0Vm1p?=
 =?utf-8?B?K1Y4Y09zZ2RoaEd6bEsxY3BjY0tMYjg3Y2t6V21VM05GZ0JJY29waEMwUTJu?=
 =?utf-8?B?WEpUbDZjWlBPdHd4enRCWjRYYytEbEtTYjVzZjJ1ZHQ2RG9TVEpibFA1ZnNv?=
 =?utf-8?B?VWZsY0I1Vm1uZGZkaHhSOTVydFRVQVZWaWkrOFFqMFh4bVVYM2d6YjdRQkVS?=
 =?utf-8?B?dHhhR2xqRHJXa3pMUWhPMjJLanRLSm5EbHdEcS9iWitUTk5acXB1UllQdy9X?=
 =?utf-8?B?UThzb3pTZVZhVjd3Yi9iMTZFL2RocndHOUtUb2FJQnhCYXl4ajJiQjdLRHhP?=
 =?utf-8?B?SzU0OUtyUEpSeTdCUDFON2tTMkxpLzV3bCt2dTBkbUFYNk9lSEhjZWN0RHpZ?=
 =?utf-8?B?UUd1V0ZkclMxNnBrc0hFc25ZQVpCNDlxN2dUc3Bwd2p2Tm92WWZOcUc3dVpH?=
 =?utf-8?B?Tmc0dk9Na0cwYkdJb3VxVFhIVjVZeWxUZ2cxUTRNNUt1NExTTVl6bi80Rk8x?=
 =?utf-8?B?S0N1OG55TVNMYUMxRjE3cUVnZEpKU3J3QzRoV0I3NjBOL3l5VWxOaWJPKzFl?=
 =?utf-8?B?SzBFRlhuTTBWd1hzbFE2M1I3Ykt2UjlsVTZkMUwwY2lRb2ZVVEJZeSthUHlp?=
 =?utf-8?B?bklvdFJiVnFidGpmZEFVazZUaFJjbnBJa0ZpRzdjVVpQUWtJaUIxSmVQZVJX?=
 =?utf-8?B?WUpVTHNUUnFFd3lYK0QrQ043YzFIS05XKzU2amhYWXFvUFVKMXoxSjk2RzBT?=
 =?utf-8?B?U2FPZ1dabityNUhrWkFoKzRvV2syRkpsQUVXMm5wcGRLTk10SlE4N3JFVDlZ?=
 =?utf-8?B?SUNqcXBLanQ3QW9BTDRKZzRiRUtCcGlSS1ZQQkdtclVsRndBZWxSTXZrRC9Y?=
 =?utf-8?B?MlNRdjUrOXp0cUlRSTBpV3pEUkZyTllnaW9UQUhJMFFtbWt5c1lnTzZQcERm?=
 =?utf-8?B?R0QwVWNBNkdWZHoySERxRGt0aktjekcxcDczM3RmLzF2b0lDYmtMeWpiL29X?=
 =?utf-8?B?c2pBd3c0MURkaWduREhyWFlkMmF3SXZwODZha2hPdktpM2l1dnVlU3padHVi?=
 =?utf-8?B?cDVqQW4zYU9qYkc2UEppdENIN2NCMTgwRTBYYlNpaWxxbTFRQ2lLRzQzWFZj?=
 =?utf-8?B?bWxOSUxWVUo3NEVabjR2UjRqdTBEN0pUMkF3TllpWnlzWWlHNGx2S2ZaSHZH?=
 =?utf-8?B?anl2dGN4R0xPWE1Nc25VQWdPNlBQQ3hXdTRmUVRxazZLT3A1VVRRNFJubXVF?=
 =?utf-8?B?Zzd6SHpVYXlHckNaZ1pBR0YvbUh5eElGakIwcmFLSE54OUh1b1R4ZndzYmVa?=
 =?utf-8?B?NVFqYzRpQStQUTNpSWNqSDhDa3UvUzBVT3c1WG9RWWFQY3FJZHBDREE4ZFp1?=
 =?utf-8?B?ZU5Ka0FzaTNlSHozZFVER1lRQnJCNGZHNUtlQy9xT2tTaks0QnNZcmFzTE5Y?=
 =?utf-8?B?bzl5dU9HeG9aV0xLbG9xVnBSUkJZNG1KZDRDdXQ5eGtFenZCcWRyQzBsUU1Z?=
 =?utf-8?B?RUtrNTI4Qk1vemphN09JZjFsckowTWNYZElmeGZjNzJHUndVUnFYcDNtVm5j?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dcc3d7-cf2b-439c-90a4-08dc807490bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 06:48:51.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2uCKKks1F6vfj0VQOhACgFms/UdNt8KD8Vw98Njn5lqAEa1wLCzu8SDTY6bmZk7eLKeCTqWo1x5xoePX1dXJ2qsh8LCK+J8Y17kqkVZ+vMEo/h816Ur2K8UczHGlY++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10240
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 May 2024 06:49:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16071

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSA8Y2xh
dWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAyNCA1
OjEwIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8
tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPjsgcGF2ZWxAZGVueC5kZQ0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc7IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tOw0KPiBwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb207IHBhdWwuYmFya2VyLmN0QGJwLnJlbmVzYXMuY29tDQo+IFN1
YmplY3Q6IFtQQVRDSCA1LjEwLnktY2lwIDAwLzQ3XSBBZGQgRXRoZXJuZXQgc3VwcG9ydCBmb3Ig
UmVuZXNhcyBSWi9HM1MNCj4gU29DDQo+IA0KPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRp
dS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBIaSwNCj4gDQo+IFNlcmllcyBhZGRz
IEV0aGVybmV0IHN1cHBvcnQgZm9yIFJlbmVzYXMgUlovRzNTIFNvQy4gRXRoZXJuZXQgZHJpdmVy
IGhhcw0KPiBiZWVuIGVuaGFuY2VkIHdpdGggcnVudGltZSBQTSBzdXBwb3J0LiBUaGUgc3VzcGVu
ZCB0byBSQU0gc3VwcG9ydCB3YXMNCj4gYWxzbyBpbXByb3ZlZC4NCj4gDQo+IFNlcmllcyBpcyBz
cGxpdCBhcyBmb2xsb3dzOg0KPiAtIHBhdGNoICAgMDE6ICAgIGFkZCBjbG9jayBhbmQgcmVzZXQg
c3VwcG9ydCBmb3IgdGhlIEV0aGVybmV0IElQcw0KPiAtIHBhdGNoZXMgMDItMDc6IGFkZCBwaW5j
dHJsIHN1cHBvcnQgZm9yIHRoZSBFdGhlcm5ldCBJUHMNCj4gLSBwYXRjaGVzIDA4LTQzOiBhZGQg
c3VwcG9ydCBmb3Igc3VzcGVuZCB0byBSQU0gYW5kIHJ1bnRpbWUgUE0gb24NCj4gICAgICAgICAg
ICAgICAgICB0aGUgRXRoZXJuZXQgZHJpdmVyOyBpbiB0aGlzIHNldCB0aGVyZSBhcmUgbWFueSBw
cmVwYXJhdG9yeQ0KPiAJCSBwYXRjaGVzIGZvciBydW50aW1lIFBNIHN1cHBvcnQgKGFzIHJ1bnRp
bWUgUE0NCj4gZW5hYmxlL2Rpc2FibGVzDQo+IAkJIHRoZSBFdGhlcm5ldCBtb2R1bGUgY2xvY2sg
YW5kIHRoaXMgaW5mbHVlbmNlcyB0aGUgRXRoZXJuZXQNCj4gCQkgbW9kdWxlIHN0YXRlIGxlYW5k
aW5nIHRvIHJlZ2lzdGVycyBzZXR1cCBiZWluZyBsb3N0KQ0KPiAJCSBhbG9uZyB3aXRoIGltcHJv
dmVtZW50cw0KPiAtIHBhdGNoZXMgNDUtNDc6IGFkZCBkZXZpY2UgdHJlZSBzdXBwb3J0DQo+IA0K
PiBUaGFuayB5b3UsDQo+IENsYXVkaXUgQmV6bmVhDQo+IA0KPiBCaWp1IERhcyAoMik6DQo+ICAg
cmF2YjogQWRkIFJ4IGNoZWNrc3VtIG9mZmxvYWQgc3VwcG9ydCBmb3IgR2JFdGgNCj4gICByYXZi
OiBBZGQgVHggY2hlY2tzdW0gb2ZmbG9hZCBzdXBwb3J0IGZvciBHYkV0aA0KPiANCj4gQ2hyaXN0
b3BoZSBKQUlMTEVUICgxKToNCj4gICByYXZiOiBVc2UgR0ZQX0tFUk5FTCBpbnN0ZWFkIG9mIEdG
UF9BVE9NSUMgd2hlbiBwb3NzaWJsZQ0KPiANCj4gQ2xhdWRpdSBCZXpuZWEgKDM2KToNCj4gICBj
bGs6IHJlbmVzYXM6IHI5YTA4ZzA0NTogQWRkIGNsb2NrIGFuZCByZXNldCBzdXBwb3J0IGZvciBF
VEgwIGFuZCBFVEgxDQo+ICAgcGluY3RybDogcmVuZXNhczogcnpnMmw6IE1vdmUgYXJnIGFuZCBp
bmRleCBpbiB0aGUgbWFpbiBmdW5jdGlvbiBibG9jaw0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6
ZzJsOiBBZGQgcGluIGNvbmZpZ3VyYXRpb24gc3VwcG9ydCBmb3IgcGlubXV4DQo+ICAgICBncm91
cHMNCj4gICBwaW5jdHJsOiByZW5lc2FzOiByemcybDogQWRkIHN1cHBvcnQgdG8gc2VsZWN0IHBv
d2VyIHNvdXJjZSBmb3INCj4gICAgIEV0aGVybmV0IHBpbnMNCj4gICBwaW5jdHJsOiByZW5lc2Fz
OiByemcybDogQWRkIG91dHB1dCBlbmFibGUgc3VwcG9ydA0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6
IHJ6ZzJsOiBBZGQgaW5wdXQgZW5hYmxlIHRvIHRoZSBFdGhlcm5ldCBwaW5zDQo+ICAgcGluY3Ry
bDogcmVuZXNhczogcnpnMmw6IEZpeCBsb2NraW5nIGluIHJ6ZzJsX2R0X3N1Ym5vZGVfdG9fbWFw
KCkNCj4gICBuZXQ6IHJhdmI6IENoZWNrIHJldHVybiB2YWx1ZSBvZiByZXNldF9jb250cm9sX2Rl
YXNzZXJ0KCkNCj4gICBuZXQ6IHJhdmI6IE1ha2Ugd3JpdGUgYWNjZXNzIHRvIENYUjM1IGZpcnN0
IGJlZm9yZSBhY2Nlc3Npbmcgb3RoZXINCj4gICAgIEVNQUMgcmVnaXN0ZXJzDQo+ICAgbmV0OiBy
YXZiOiBTdG9wIERNQSBpbiBjYXNlIG9mIGZhaWx1cmVzIG9uIHJhdmJfb3BlbigpDQo+ICAgbmV0
OiByYXZiOiBLZWVwIHJldmVyc2Ugb3JkZXIgb2Ygb3BlcmF0aW9ucyBpbiByYXZiX3JlbW92ZSgp
DQo+ICAgbmV0OiByYXZiOiBXYWl0IGZvciBvcGVyYXRpbmcgbW9kZSB0byBiZSBhcHBsaWVkDQo+
ICAgZHQtYmluZGluZ3M6IG5ldDogcmVuZXNhcyxldGhlcmF2YjogRG9jdW1lbnQgUlovRzNTIHN1
cHBvcnQNCj4gICBuZXQ6IHJhdmI6IExldCBJUC1zcGVjaWZpYyByZWNlaXZlIGZ1bmN0aW9uIHRv
IGludGVycm9nYXRlIGRlc2NyaXB0b3JzDQo+ICAgbmV0OiByYXZiOiBSZWx5IG9uIFBNIGRvbWFp
biB0byBlbmFibGUgZ3B0cF9jbGsNCj4gICBuZXQ6IHJhdmI6IE1ha2UgcmVzZXQgY29udHJvbGxl
ciBzdXBwb3J0IG1hbmRhdG9yeQ0KPiAgIG5ldDogcmF2YjogQXNzZXJ0L2RlLWFzc2VydCByZXNl
dCBvbiBzdXNwZW5kL3Jlc3VtZQ0KPiAgIG5ldDogcmF2YjogTW92ZSByZWZlcmVuY2UgY2xvY2sg
ZW5hYmxlL2Rpc2FibGUgb24gcnVudGltZSBQTSBBUElzDQo+ICAgbmV0OiByYXZiOiBNb3ZlIGdl
dHRpbmcvcmVxdWVzdGluZyBJUlFzIGluIHRoZSBwcm9iZSgpIG1ldGhvZA0KPiAgIG5ldDogcmF2
YjogU3BsaXQgR1RJIGNvbXB1dGF0aW9uIGFuZCBzZXQgb3BlcmF0aW9ucw0KPiAgIG5ldDogcmF2
YjogTW92ZSBkZWxheSBtb2RlIHNldCBpbiB0aGUgZHJpdmVyJ3MgbmRvX29wZW4gQVBJDQo+ICAg
bmV0OiByYXZiOiBNb3ZlIERCQVQgY29uZmlndXJhdGlvbiB0byB0aGUgZHJpdmVyJ3MgbmRvX29w
ZW4gQVBJDQo+ICAgbmV0OiByYXZiOiBNb3ZlIFBUUCBpbml0aWFsaXphdGlvbiBpbiB0aGUgZHJp
dmVyJ3MgbmRvX29wZW4gQVBJIGZvcg0KPiAgICAgY2NjX2dhYyBwbGF0b3Jtcw0KPiAgIG5ldDog
cmF2YjogU2V0IGNvbmZpZyBtb2RlIGluIG5kb19vcGVuIGFuZCByZXNldCBtb2RlIGluIG5kb19j
bG9zZQ0KPiAgIG5ldDogcmF2YjogU2ltcGxpZnkgcmF2Yl9zdXNwZW5kKCkNCj4gICBuZXQ6IHJh
dmI6IFNpbXBsaWZ5IHJhdmJfcmVzdW1lKCkNCj4gICBuZXQ6IHJhdmI6IEdldCByaWQgb2YgdGhl
IHRlbXBvcmFyeSB2YXJpYWJsZSBpcnENCj4gICBuZXQ6IHJhdmI6IEtlZXAgdGhlIHJldmVyc2Ug
b3JkZXIgb2Ygb3BlcmF0aW9ucyBpbiByYXZiX2Nsb3NlKCkNCj4gICBuZXQ6IHJhdmI6IFJldHVy
biBjYWNoZWQgc3RhdGlzdGljcyBpZiB0aGUgaW50ZXJmYWNlIGlzIGRvd24NCj4gICBuZXQ6IHJh
dmI6IE1vdmUgdGhlIHVwZGF0ZSBvZiBuZGV2LT5mZWF0dXJlcyB0byByYXZiX3NldF9mZWF0dXJl
cygpDQo+ICAgbmV0OiByYXZiOiBEbyBub3QgYXBwbHkgZmVhdHVyZXMgdG8gaGFyZHdhcmUgaWYg
dGhlIGludGVyZmFjZSBpcyBkb3duDQo+ICAgbmV0OiByYXZiOiBBZGQgcnVudGltZSBQTSBzdXBw
b3J0DQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgRXRoZXJuZXQgbm9k
ZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IFVzZSBzd2l0Y2hl
cycgbmFtZXMgdG8gc2VsZWN0DQo+ICAgICBvbi1ib2FyZCBmdW5jdGlvbmFsaXRpZXMNCj4gICBh
cm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IEVuYWJsZSB0aGUgRXRoZXJuZXQg
aW50ZXJmYWNlcw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNvbTogR3Vh
cmQgRXRoZXJuZXQgSVJRIEdQSU8gaG9ncw0KPiANCj4gR2VlcnQgVXl0dGVyaG9ldmVuICgxKToN
Cj4gICBuZXQ6IHJhdmI6IEZpeCByZWdpc3RlcmVkIGludGVycnVwdCBuYW1lcw0KPiANCj4gUGF1
bCBCYXJrZXIgKDMpOg0KPiAgIG5ldDogcmF2YjogQ291bnQgcGFja2V0cyBpbnN0ZWFkIG9mIGRl
c2NyaXB0b3JzIGluIEdiRXRoIFJYIHBhdGgNCj4gICBuZXQ6IHJhdmI6IEZpeCBHYkV0aCBqdW1i
byBwYWNrZXQgUlggY2hlY2tzdW0gaGFuZGxpbmcNCj4gICBuZXQ6IHJhdmI6IEZpeCBSWCBieXRl
IGFjY291bnRpbmcgZm9yIGp1bWJvIHBhY2tldHMNCj4gDQo+IFNlcmdleSBTaHR5bHlvdiAoMSk6
DQo+ICAgcmF2YjogcmF2Yl9jbG9zZSgpIGFsd2F5cyByZXR1cm5zIDANCj4gDQo+IFlhbmcgTGkg
KDEpOg0KPiAgIGV0aGVybmV0OiByZW5lc2FzOiBVc2UgZGl2NjRfdWwgaW5zdGVhZCBvZiBkb19k
aXYNCj4gDQo+IFlvc2hpaGlybyBTaGltb2RhICgxKToNCj4gICBuZXQ6IHJhdmI6IEZpeCBsYWNr
IG9mIHJlZ2lzdGVyIHNldHRpbmcgYWZ0ZXIgc3lzdGVtIHJlc3VtZWQgZm9yIEdlbjMNCj4gDQo+
IFl1ZUhhaWJpbmcgKDEpOg0KPiAgIHJhdmI6IEZpeCBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUg
aW4gcmF2Yl9yeF9nYmV0aCgpDQo+IA0KPiAgLi4uL2JpbmRpbmdzL25ldC9yZW5lc2FzLGV0aGVy
YXZiLnlhbWwgICAgICAgIHwgICAgMSArDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMv
cjlhMDhnMDQ1LmR0c2kgICAgfCAgIDM4ICsNCj4gIC4uLi9ib290L2R0cy9yZW5lc2FzL3J6ZzNz
LXNtYXJjLXNvbS5kdHNpICAgICB8ICAxNzcgKystDQo+ICBkcml2ZXJzL2Nsay9yZW5lc2FzL3I5
YTA4ZzA0NS1jcGcuYyAgICAgICAgICAgfCAgIDEwICsNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L3JlbmVzYXMvS2NvbmZpZyAgICAgICAgICB8ICAgIDEgKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVuZXNhcy9yYXZiLmggICAgICAgICAgIHwgICA0MCArLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYyAgICAgIHwgMTA3NA0KPiArKysrKysrKysrLS0tLS0t
LQ0KPiAgZHJpdmVycy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1yemcybC5jICAgICAgIHwgIDE2
NCArKy0NCj4gIDggZmlsZXMgY2hhbmdlZCwgMTAzMCBpbnNlcnRpb25zKCspLCA0NzUgZGVsZXRp
b25zKC0pDQo+IA0KDQpJIHJldmlld2VkIHRoaXMgc2VyaWVzLCBMR1RNLg0KSWYgdGhlIHRlc3Qg
cGFzc2VzIGFuZCB0aGVyZSBhcmUgbm8gb3RoZXIgY29tbWVudHMsIEkgY2FuIGFwcGx5Lg0KICBo
dHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9waXBl
bGluZXMvMTMxMTM0NzgwNg0KDQpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQo=


