Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700D3C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 12:39:45 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web11.120258.1699532821396772979
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 04:27:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xOTMm5q6;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Uo3/zRRKND5G4W+jmJ/+y+6CzhOz0Gm7h7s4J+x/mesN3I6ML7czTc6jn9x9iZFFM3X17NtPIN9JFJogC5/7hjUkiQIl1OnB6y1MFRvkPZtHjn3LGE7aQRpnpysKSiGcn5lzRV/RFRdlnd4z7U3VTjd1qnellnhcaMKZb6ezk3BSjiCWHfiEy7slpXPi1cy6363EeUKCqMW0cBVCckMNikarD6pt4Ot7Ua37TJvadcKpJI6ZpITmOIJi5nBBkSBXZk8uHyqrhLtTm+pIDX7i8IyFrFFfJJ0dQBi3CVzKZ+U0N4g6dOLEToCdIekEUkIoOtwcBORX0Q7TS65qXN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc6RCOE/o1zpfxNsUZtfbRfxzSLZHLlux8YPLfXj1Bg=;
 b=TC6FRzVL1IidmC4GwYdrGkMdvYi2AanT/D+ypa7mhG6KN1e2zQ3yYq+nGHe9duPv6v1fG8y0QeZk1724vXcQok6tXM1VJZiW9cYRdzh7noNfAPWFOF6ZM5BqY3Wwfq2e3ci6IUB7R1+0FuPbrbGCcANq3+Ci9C3aPiGB1GTBr43Pqe3h/WFV3z/0hi55renHNv5HfeWgwp8F4RgxKcB+AeKZI2TRTly97JKbibA+dcsaV40VfxGIZeQkaTu7t4fP2mUDW+Tjrwe4Z0aAR0gamLdUk+cCf+JIzbI4neba2122Lk/uFkONDKiEzfx7BnO93GNNpY2uSJ13w6R16ClPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc6RCOE/o1zpfxNsUZtfbRfxzSLZHLlux8YPLfXj1Bg=;
 b=xOTMm5q6f7RHggHNYscIb23ESnxDFj6ne3zQ7Xgw65zMcHCkBDtn7OaUDUNZJeH6hxMnOMpx0FEst9rHWkLdJouZF0o7AwNLelxmHAnS0on2vETE9VHqke3DTbDSwrnYrsnerNc2uILmXL/1rFD/Y62Evzk2TGBvWCFZUbB+Pru0y66oEdhkoa2rB9CYFtD/KYbNB5iXuLq4IWuWcC+PPPZxIdrVyGXAv7rNRZ/avdNhPdHKV2I76FxT7eaCuCKY8vxR/LuWwyZRnlLlFDnJcP4juHOyr8LZmTuCSxKodT/argY8Uy0XyLlS5C3/+7GEAc7rzB1OQhXKyiZ0pZULgw==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by PR3PR10MB3961.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 12:26:58 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8%7]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 12:26:58 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: AdoM5xnui5+ATTT0SDWBKqFXTIkKDgAbCr2AAAQcUoABZuRjgAAAM3KQ
Date: Thu, 9 Nov 2023 12:26:58 +0000
Message-ID: 
 <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
 <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
In-Reply-To: <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7c9b3be6-e530-4951-8bd1-2740b56bcda4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-09T11:30:04Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|PR3PR10MB3961:EE_
x-ms-office365-filtering-correlation-id: 2fab925d-860b-48fa-4381-08dbe11f2ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gT4P1EbvFtLoifJqIsLvPReBJVEER7qO6lD+MeVt8SmY80IOMgt2WAc5HaXWRg1qkJ3DlDHnFgc3XKWCz+s0kFDV9/DtrzlujD6H5tBoBn+bJ63p78/WammZMnhFxFxUopAvA2Uvv9rBFS3Hg/Auy6PDnKKCoCvK5WfWcp80rrxJ3HUJ6ljFMU5oYQAVkVEBIbEjD4gK3bFwvuVSKTYlHj6ygqumFdTYs6ARyg6YRMhzf3WTuu4UAzk9jzeYzDsBR5tBPTg4zhJ19xqFfIYcTByCMrMzq+RkDFrEIy/w0nlgNLhzcfB1Vt2WjmErXrwTKvOTpSkvepvCcQkOR58tLcYEhomyl5LwCytHaiX73sonn0egb0K2Qg/CT/6Dlzldzr8FYasx67C0396rBE3TkUE8iuUcL/GDljj36ul0hqVLk/TPkVNFW8SIK34QlyKUi/Akl+KHkKGbVRO9rNMWabgqE5nQWf/X5ITOTjtn6V7WgiOFrB4OAwTEM7t6cdEEsaUqlKLTY/SgOVJs4f44f0/wF7SPSw8k6DwIYaCzxbvCUhVAEJEp0FbgUpdQ+b5vQN9mM+2vTDUDNaBwzXNkyFWbB+pcA1MME0QCezyLbDG6nb22nXIdzIVEK2GZdCJI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(55016003)(53546011)(55236004)(9686003)(71200400001)(6506007)(478600001)(7696005)(38100700002)(33656002)(86362001)(122000001)(82960400001)(54906003)(26005)(6636002)(64756008)(66446008)(5660300002)(66556008)(76116006)(52536014)(2906002)(66574015)(4326008)(6862004)(66946007)(83380400001)(66476007)(316002)(8936002)(8676002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZTZ3a1ByV1E4Y2QrN0VWYnd1TzFLcGl2VWpjWndmdGx3eFVzSDQ2dUVPbVg0?=
 =?utf-8?B?dlN2R3BWNWRhZ1Bjam9FY3JNQkcvc1NuWVFSU1RsbVc1MGdac2t5L1hOT3J4?=
 =?utf-8?B?UEZWeklJMytVd2NubnF1aDlDVldDUEtqUnFpdnNVdllYUHJzNUVnR2VOakgv?=
 =?utf-8?B?L3daSnVERURsZnQ4QktkRUgvdlhMOUlaTVBSNlROTmxySjJjaTZJdjJqREI1?=
 =?utf-8?B?ZEt1blVXUEc5OVRzWVNYZU1BWXYwelF6RXRuSWg2dHpJcllkcnNBRlQxMFdM?=
 =?utf-8?B?U0VReU1lTU4yeWZTNjFXS3htK0NFamVVV0k5N2tVM2hVcEVjZ254QTM1d0pB?=
 =?utf-8?B?MDY0MkVaVmhqMkNPS1FWR0ZWWlJ1Wml4ZFlsZ2hOTGhlOFVBWUV5QW03YlRk?=
 =?utf-8?B?ayt0NGVQa1NBOENsa21jUEM5REVJejhLZHFQT0lTejVJeUptQmtCUWZoUm01?=
 =?utf-8?B?NEYzRWJobzBUUzIwRTFxMWc0VGFvTFdPUy8reHlGbTd3cTlwbkhrdE12QkJU?=
 =?utf-8?B?a09XdmxBVytUbEt6Ym9IRHNFMjVhbnZVbWgrOGpwcE15Z0lCbzlNTVFPTG5W?=
 =?utf-8?B?cG5MZXBkOFFrb3FXZkZpV0RhT2MrdHlha2Fwa204cjc1SFM0SlM0d2hqMjVh?=
 =?utf-8?B?K1JpYURmdzNrb3BCTWE4TFJzMzEwb0JTaDV4L2hvWmhLMFdibWZqajdOUDBG?=
 =?utf-8?B?WG9XTzhCVUV5RXlOWDd6YUdoV013akk4OGxXaDR2blM0d1lVQ3lYNFpmOUVH?=
 =?utf-8?B?L0trNzE1TWsrTTFqcm1NRVRma2RWTDBvQ1F3NWY5cnByYzFsd1FQNXFpN0Ew?=
 =?utf-8?B?bkpJZFZuRnBCSlpDQktLeEdxc29STU5zQWZVSnhFL2Ezb3Q1aXRxQ2ZwOXpJ?=
 =?utf-8?B?OVQrZ2d0aHB2M2l3MFRCNmkvbWdaSGpRRFlYdUpURnEwMW03UXdkVjZSRzlS?=
 =?utf-8?B?TCtKTnphWHdwTSthZ01WeVdNdUNyc3UxczVPK1FQKzc3KzFxU3FlVm1uOUdG?=
 =?utf-8?B?ZXVONXRpeVQ0NGYxMXNXUmNYZnNMeXFXalc2ZUFIWjVMUitIZ2JGeDBIWGRt?=
 =?utf-8?B?VVVaSUkzRHlwTi9hOUZ6UnBUMHh2R0loS0IxaVBhY3F5dDdEbHdnSFZsQTlK?=
 =?utf-8?B?dWtmNHFMRTFhUFVzV3VxUWNZS3RtSG1RS0hTUldTakFiS3pLMFBFQmttNElX?=
 =?utf-8?B?Zk9Mejc3Nk5OWlllRDR3Tkc1bkRXeXRWRzdJdFRoNE1KSUMzeEZoSGU2ZVJ5?=
 =?utf-8?B?ZnBKeVUwQlNsWmdVS01WWmthaHp0NE5ialoxQTM0U1pWOWxVcnpLeDJVOFhU?=
 =?utf-8?B?ODhPeVlwZFBDUlkyK3BPdSt3M2FjQVBZSFBBa2d0ZmVPSkI2eDlOL3RueUVY?=
 =?utf-8?B?WnRwNldwcXRUeFBiS2ZOTzhjb0VHZzhYWU5JNkhRSUhvVHFWd1ZwUVBzcmVD?=
 =?utf-8?B?b1ZmMUtqSlJXS2ZzQzdBRjVCZnZId1Rqd2dlaGM0V2NzVS9QOE9aT0pGdmhB?=
 =?utf-8?B?dUZBRDhkVVBjbm84UVBjUXp0OE1sWVl2SnN5NmFZdUFqTlpoYmJyR3JCaEo3?=
 =?utf-8?B?Rm52eE1WWUQ5WFBGV0t6d1BINFFGcFU4b3h0eDV1dVZKV1RtbkF1bExzMTBL?=
 =?utf-8?B?TmMraEovcHhrUUxEVk9WSzZ0RUh6T01OZjdTdjVGZUlDcGJkQSt0NUNDNjVj?=
 =?utf-8?B?dzc2aFpVZ1lzd2EwcXgvdC80NElUcjhYMHNNMDJMZUpiK2tocmpOcXduS1g5?=
 =?utf-8?B?WDV2OThPditOb2VLL3kzWUxlZDhmMjlaZUpHRDlSVTRNNjI1VUZ4VnhQTXQ5?=
 =?utf-8?B?ZFFUU2VIYmhlUEtQQnNMTE9JcU43azNGQkowdTR5ckg5RkFhRlVUTzBmM1l5?=
 =?utf-8?B?QUp5YXAzaHA4Ym5hTlcxZXZvVU90TkxYVUNsSkNta1N5V054MHdIOEJNWmU5?=
 =?utf-8?B?d3owN2NiTVZxQndXbmxDb2ZhenpZR09FNyszNkFCa09jMXBIWGJzSHVrTlFO?=
 =?utf-8?B?QS94cTl5ZVNCa0NIZUF6NjBGVFk3eVlwaXBra0RWeTVEc00xRW1oYzJrR0U2?=
 =?utf-8?B?eEt4b1pKUHE2NlI2bzVxekg4YlRVZUxSTVI2a3hhUWtMc1J5aDRPWTZCK3lQ?=
 =?utf-8?Q?81//WepuWC1Pyff+G3dOnI9NY?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fab925d-860b-48fa-4381-08dbe11f2ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 12:26:58.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhY9VI4R+bioh5cnKNT3A0CQT7KgJKqbBypDzUwnvk8CmXErlEQl2nUwFrB0LIVp54awPRpEB7ZegZI4Jgihqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3961
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 12:39:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13550

SXMgdGhlcmUgYSBwb3NzaWJpbGl0eSB0byBoYXZlIGEgVFBNIDIuMCB3aXRoIHBjcl9iYW5rOiBz
aGEyNTYgdW5hdmFpbGFibGU/IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgZXhhY3QgcmVhc29uIHdo
eSBpdCBzaG91bGQgYmUgY29uZmlndXJhYmxlPw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS2lzemthLCBKYW4gKFQgQ0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpT
ZW50OiA5IEthc8SxbSAyMDIzIFBlcsWfZW1iZSAxNDoyNA0KVG86IFNhcmksIFNlcmNhbiAoQURW
IEQgRVUgVFIgQyZFKSA8c2FyaS5zZXJjYW5Ac2llbWVucy5jb20+DQpDYzogR3lsc3RvcmZmLCBR
dWlyaW4gKFQgQ0VEIFNFUy1ERSkgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+OyBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQ
QVRDSF0gYWRkZWQgcGNyX2JhbmsgZm9yIGNsZXZpcw0KDQpPbiAwMi4xMS4yMyAwOTowOCwgR3ls
c3RvcmZmIFF1aXJpbiB3cm90ZToNCj4gDQo+IA0KPiBPbiAxMS8yLzIzIDA3OjEwLCBKYW4gS2lz
emthIHdyb3RlOg0KPj4gT24gMDEuMTEuMjMgMTg6MTcsIFNhcmksIFNlcmNhbiAoQURWIEQgRVUg
VFIgQyZFKSB3cm90ZToNCj4+Pg0KPj4+IGNsZXZpcyB3aWxsIGZhaWwgdG8gZW5jcnlwdCBkYXRh
IHdoZW4gdGhlIFRQTSBoYXMgbXVsdGlwbGUgYmFua3MsIA0KPj4+IHN1Y2ggYXMgU0hBMSBhbmQg
U0hBMjU2LCBhZGRpbmcgdGhlIHBjcl9iYW5rIGluZm9ybWF0aW9uIHJlc29sdmVzIA0KPj4+IHRo
aXMgaXNzdWUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTZXJjYW4gU2FyaSA8c2FyaS5zZXJj
YW5Ac2llbWVucy5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgLi4uL2luaXRyYW1mcy1jcnlwdC1ob29r
L2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLmNsZXZpcy5zY3JpcHTCoCB8IA0KPj4+IDIgKy0NCj4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQNCj4+PiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1o
b29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLmNsZQ0KPj4+IHZpcy5zY3JpcHQgDQo+Pj4gYi9y
ZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9lbmNyeXB0X3BhcnRp
dGlvbi5jbGUNCj4+PiB2aXMuc2NyaXB0DQo+Pj4gaW5kZXggODk5ZjIwZS4uOTU3YTNmZCAxMDA2
NDQNCj4+PiAtLS0NCj4+PiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29r
L2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLmNsZQ0KPj4+IHZpcy5zY3JpcHQNCj4+PiArKysNCj4+
PiBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRf
cGFydGl0aW9uLmNsZQ0KPj4+IHZpcy5zY3JpcHQgQEAgLTYxLDcgKzYxLDcgQEAgb3Blbl90cG0y
X3BhcnRpdGlvbigpIHsNCj4+PiDCoCDCoCBlbnJvbGxfdHBtMl90b2tlbigpIHsNCj4+PiDCoMKg
wqDCoMKgIGlmIFsgLXggL3Vzci9iaW4vY2xldmlzIF07IHRoZW4NCj4+PiAtwqDCoMKgwqDCoMKg
wqDCoCBjbGV2aXMgbHVrcyBiaW5kIC1kICIkMSIgdHBtMiAneyJwY3JfaWRzIjoiNyJ9JyA8ICIk
MiINCj4+PiArwqDCoMKgwqDCoMKgwqAgY2xldmlzIGx1a3MgYmluZCAtZCAiJDEiIHRwbTIgJ3si
cGNyX2JhbmsiOiJzaGEyNTYiLA0KPj4+ICJwY3JfaWRzIjoiNyJ9JyA8ICIkMiINCj4+PiDCoMKg
wqDCoMKgIGVsc2UNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGFuaWMgImNsZXZpcyBub3QgYXZh
aWxhYmxlIGNhbm5vdCBlbnJvbGwgdHBtMiBrZXkhIg0KPj4+IMKgwqDCoMKgwqAgZmkNCj4+DQo+
PiBJcyBzaGEyNjUgdGhlIG9ubHkgcmVhc29uYWJsZSBzZXR0aW5nIGhlcmU/IEp1c3QgYXNraW5n
IGFzIHdlIGFyZSANCj4+IGhhcmQtY29kaW5nLg0KPj4NCj4+IFF1aXJpbiwgYW55IHJlbWFya3M/
DQo+IA0KPiBJIHdvdWxkIG1ha2UgaXQgY29uZmlndXJhYmxlLiBjbGV2aWNlIHN1cHBvcnRzIFNI
QTEoZGVmYXVsdCkgYW5kIFNIQTI1Ni4NCj4gUXVpcmluDQo+IA0KDQpTb21lIGZvbGxvdy11cCBh
bHJlYWR5IHNjaGVkdWxlZCwgU2VyY2FuPw0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hu
b2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0K

