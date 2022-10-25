Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4DDC38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 15:23:40 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.79])
 by mx.groups.io with SMTP id smtpd.web08.8409.1666711415035498148
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 08:23:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pVSTs/kT;
 spf=pass (domain: siemens.com, ip: 40.107.6.79, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByfGYd/xS7PWWHC/TyLFjuE2Sm/HioqorCaS9A+eKPEum/0XIEvnuR7XnEQ9Cox2nXugrOJJKjGO71jiPsk1ghJuxn66BZFQL8TRTlAwSUOJLSluge66J8xffXizAJ2kQOylOof64iuPmmi3CTkbl7q0JCgEWdBaRnfjoSDIM1UaRdB0m/szXYQCVzVD9GtP9bNdojn1KoiuWkJbsUO3kvPOguOzOkqkwCnEuUo7KX1H6GCXjAvq/I9+xIeimfITvKrMCC3X2fAyBDZLPUE/jwYzSCGug/ttIduFQ7ycoVi/U0zoJyGfnJuSfrOAO7F4f+hoQET38OXsHGGaZ7GRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVk6fW53E1FGlti9fmrlRjtdHZ/2DxZJZHsD4mRRGDM=;
 b=jMCyfYg3RJqubK2mFWvgcbgDIJkU9WfkkCZDWP+Y4KdANXZn0HAcmS2IvX/ZQr1I647LV/EOaNCyv5c4zA04xLoQ1NSpioAu/4OBRMVALXIbiAl5vv4wqtRLb2T+ApWLOPPtp1kOlAzYxBV1qvLbeLBLPAmOYLuIA7H8E9PkHjaPKqURZSlJfTyoSUpCfEta3FpHLGj3wiZW9I/zG47wnLX6caiIZKAdvkNOVzlsr4T70yI05r8TkrVRCGg+1olWsCHyE3NdGbeFHbT7N0GgK7/LIb7kQjIvZ3GL2RTW19Kl7TNS8oAazkx+9cItP0Kzz0cOJPjNugcwctn/PSIlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVk6fW53E1FGlti9fmrlRjtdHZ/2DxZJZHsD4mRRGDM=;
 b=pVSTs/kTcUcdlPc10cZzm51hy3GhmTitnv88kQpBCWz1NC1WDkDrZRRnsCqTnaN8bqXflH4F/w3N3nFwV1qRH5+3HCh5hOynxVvoBcFFysSU1t0gHucrXCuaVzD4LFLFjOWt7nh+43665suyEtnY5MwyrHk9FNbPDTAmX05C8C88wd4Y358fPMEjPqqKpZ0AYgOWVtHHR4q9bfDv4ocCTE+rbdk29jldz/hfz/o3R99WMb0uers57pr1lqQ0YxJckIlQJRF9hwUTFpPc/dKMetxovKjqonMzf2P5uP8vQXSTOrfm6UoUEOh+FJhhZ7rc3GgtMeFYpgKcDjslxaZtHQ==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 15:23:32 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 15:23:32 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "baocheng.su@siemens.com" <baocheng.su@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: AW: [isar-cip-core][PATCH 8/8] no merge - manually instructions test
 secure boot
Thread-Topic: [isar-cip-core][PATCH 8/8] no merge - manually instructions test
 secure boot
Thread-Index: AQHY56QxecXPZHAl/0e2jJ2CT3vxIq4eyoSAgABw8UA=
Date: Tue, 25 Oct 2022 15:23:31 +0000
Message-ID: 
 <PAXPR10MB5037C9EE65A0E3975A87928590319@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
	 <20221024122725.383791-9-sven.schultschik@siemens.com>
 <f2c5abe1356656fd0c5863a6442bebd0c9eeb785.camel@siemens.com>
In-Reply-To: <f2c5abe1356656fd0c5863a6442bebd0c9eeb785.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-25T15:23:30Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=68379b5b-0127-4b4d-aa36-3e5b69aed94b;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|AM7PR10MB3543:EE_
x-ms-office365-filtering-correlation-id: 82bf2cb7-59a0-4692-9ec3-08dab69ce04e
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 R/SmudaLw2KmOafr7YdXBZsYabAEB2IyCQxMzIuPF0AuPK2mN9kboBySBa8zvh7ZG72Z8PWOpIBZ+rS32q7dJhggmYIWRiCWCdCaiCGjxCuknrsaZpq7MC08UuyD/gicmve5j8+igRQiUPNciFp6zm/wFhf8jn6lhWib52xMZefI/yxiTjIOzSyeqrQjRYGEkRC1GzEFEe39CrD5KukqikoxVveptKZ2RM8TTreu+Cp71Y3gZWs5P9WGvNuWaJ4qSh7/ZPMMSKpPSSagJZK7bIH/2XzU7zZbhyeVj614I+FgAfSP8z7XSbnCYlLBn5ltVs9CCbwy5Hp/Lef1GCgZKjLg8oJQdTkILWxF7eTI2Th47HEKv90CrFTphzd+x/B9G3skWwfuGfNVAo7sJHvR64G8jtYUFZh9rdDm1S1I3kOyrWPZrGF+Qc7oshPdOKkTUAFlACZcBhvya+G3jrwzRfobccmDco7qDH6pUgcK/JfY4DLMQrqIaipMTYQTfAOH2qUazZhO2ZawanrK+YF46TSxAXr5IviyM9qy09nGMdf/vq9/P1HzCeA013ADHg5w1x4FFdWUUp7lpImZ5EEJbxW1ylDabLV4inirBsLtDTLiWFD3PfKWImXIXTG2OKAJVNA9FrsyLfy+JTiriwb0V9XKYsdSgzUjD54HIDZ8c3wM1i649Yw7jLAuwuZMTRJGT8S4lonpL+Ep6qiVHCeRZNuTbuc45sfDFm48ZCeQXylzCTEHQ7PImKrRkOX+nH3vLRXcSnPjz7pQk6OdDVL8ZA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(66556008)(41300700001)(4326008)(8676002)(122000001)(82960400001)(33656002)(86362001)(8936002)(2906002)(66476007)(38100700002)(186003)(107886003)(4001150100001)(52536014)(9686003)(38070700005)(5660300002)(6506007)(26005)(66446008)(76116006)(55016003)(110136005)(478600001)(7696005)(64756008)(66946007)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b2g5T3Y0NEs3d250WXo5WXhMM2x3TFEvY1RaeDhFc3dQTHFQYStOdW4vcmF3?=
 =?utf-8?B?b1JET1FoaGRQODNteVpKVkdON2U3YnNRNm4wYkVWUnhNSHA1TmoyTzV5UFlR?=
 =?utf-8?B?ZU9pTXNWM05maGNDQ0NObEJscWdVM2VjR21pZ3FlV2xrUEI5cDBUTGkrVjYv?=
 =?utf-8?B?WnlMOGhJR3NxR2pHOSt0L3I1MHVLSGZIalJ0R1o4NHlRbTVjYys2NFkxdjFK?=
 =?utf-8?B?dDlLN1Q5amdTUlVteGsxTDVtSTZub0VVMXFJODhvMTF5RWgyMGxxWkRzU2ZJ?=
 =?utf-8?B?NFRYL3pMVDFscnRzTGV1R3Q4UUxFdjZPMkZraE5aY1I2bkpiNDhiaHU0R2da?=
 =?utf-8?B?WGFvRmdLd3BlUmMya0Y5RW5ONGFqTkl1YWMvZWtPSWJ3QW92U2VNSXV3TUFT?=
 =?utf-8?B?K0hCenprczdIOVM3V0xFZXhUUnFONWkyajVLVVJZQ1I3WjJiQWhsWlNFZWlT?=
 =?utf-8?B?dnBQUGxmZDBwWWtmWjVrYkE3cjgrSVdiWERJWVdLSVcxcFJucXVYK1dxSll4?=
 =?utf-8?B?b1JMUkN4YTV4Y29OS3pWT29sTFl4ZEtLdnZ0ZXVIbjdYMWlVbzVMZ0hqKzlZ?=
 =?utf-8?B?L1o2SmM5dzRVTW5PcFlQTnZZcXFRb1ZERHhMb0hnSzRsaENibWJseWl5R29N?=
 =?utf-8?B?RzM4UHpYY3BsemJwRnBGaWhYaUZaV29FeXZIZzFkZlI2ZURncFR0ZFBocE4w?=
 =?utf-8?B?cDYveXpIeU90aVc3S2Faa0dBVHN4dFE0YTAvdGxYZG5YVGt2U2FGUGt3VURF?=
 =?utf-8?B?aG5sNXl4V3hQSXp0R0RwVmRaYW80clVsWHdLQmpOOU9ZaXVnTGd2L1FkbkRz?=
 =?utf-8?B?Z2N6KzdTcUhEZkYyYk1ZdituVjhjVmhFd1BLa1ppb3ZRcjlXbHAvMDlVQm9G?=
 =?utf-8?B?dndEN0tzd3JWWkdwMEhka3M4SlYzaEpJWHhDdHdxbE81aFRKeU9WRllyZXRl?=
 =?utf-8?B?cWQ3cmR4SndaRjFDK0JDdDBRM0JHMFhmQWQvRXVtR0Q3bE9WRTNKenE2VjlT?=
 =?utf-8?B?cytMenMzbnZqVkFlR2NwL0ovc2xJWjB3bmoxcmxHR0JSc0VkM0l3ZnR5OC9D?=
 =?utf-8?B?OCtlc2k1THo5YWVydUtxdlZRRzRXOGNjREwyb1A4TWxCUCtFc2tZVWtFYnkx?=
 =?utf-8?B?Y0V5OFZqSzYzdHIxRHUxMUFVUmYzQkRpd3pvblRHdmI1WHFTV2dOa0crM001?=
 =?utf-8?B?TFpzR1ZnU2E3OUd3MEEzZTY3V0VOc3RoV2RaRzk3amlMSXhWZ093Um5iYWRu?=
 =?utf-8?B?SmVBZWpJTHZaMVlzSXFzcndrTnQzMHJKaDNuWEs3d3pVOGVFeWtuQjFlSzVk?=
 =?utf-8?B?dFlYblpGU3RDd0NwR0NkQktqUStCRXEvL1ZtT3NoZTU0eDAwYUErVUhRQ1d1?=
 =?utf-8?B?cU0wZml2RitoMjBCaHF1dnlXdVoyZ295aTdibnlJOU5sYitXaWwxMnpRSHU1?=
 =?utf-8?B?dkJlcWR1UUR3cFJLd2Vpa2JWRzBIM2U2LzQzdGZFc0tENWRDLyt6aThJK1Zy?=
 =?utf-8?B?dnNPWTN4UjJDL3YxeE1qSW5pemY3Z1VVelhzcUM3S3hUeGRnL0xTUWZZZi9D?=
 =?utf-8?B?enBWNERESVg3cURqTUhVMnBNQ3ZwTFE5dEpua1VJQ29ENFBYcW54WUIxWmFq?=
 =?utf-8?B?ZWprSEJGRmJyQVRNTVN6ZVFpRWdDRkFkUnMzV1FIYmNzcWllVkN0aFFmZjhY?=
 =?utf-8?B?cEhoVDBEK2lGRGx5Ykc4R3dKKzRjQzhpNVBZSGFidkNjUWx6ditaWk9teHRF?=
 =?utf-8?B?aWYva1BITURESVVubTMxa2Vnb0k0bittc1M3QUo3TlM0M1o5T1lQaW5zWHZB?=
 =?utf-8?B?a1luTUp3M3dydktmVlhHNy84RXVUeXV5ait2NWVWMGxQMXlRU0JTTHJxcG4x?=
 =?utf-8?B?eFNEWFByeGkvWWdjQVA1L1JiM2ZlVVhaWVZUTkJ5c1ZHOENKbmxEelJselhj?=
 =?utf-8?B?L0E3WENpUkdINGhGK3J5N1ZpZmliVHBCOWd0MmxlWXJMT2p1K2NYQncrbTVj?=
 =?utf-8?B?UlErblJScm1HZHc3Q0s4ZnR1N1hZQUFwcE15MTRTTnlGTFNrQzJaWTBQKzdF?=
 =?utf-8?B?N2dzeFR0SlBJWHJvNkJUZ3lHb25aMHB6NUlWQTk1V0RGcDFGTEZtQ05GM0g3?=
 =?utf-8?B?YWoyVDhLbk14NVFUd3pIUU16d3NPQmphTkhyL2ZFZmg2RWZsb1I5MU95eEQr?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bf2cb7-59a0-4692-9ec3-08dab69ce04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 15:23:32.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/dA0DCYUQ+M3NiCnpj7uqVXloLPgHdSnekcSvtboPZ2dQsdi8fHi30vQeRQGAB3kLhFgffOxvNtqv2aPT/FKeZiBUu5OL68QzNPkPWfr/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 15:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9834

DQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IFN1LCBCYW8g
Q2hlbmcgKERJIEZBIENUUiBJUEMgQ04gUFJDNCkgPGJhb2NoZW5nLnN1QHNpZW1lbnMuY29tPg0K
PiBHZXNlbmRldDogRGllbnN0YWcsIDI1LiBPa3RvYmVyIDIwMjIgMTA6MzcNCj4gQW46IFNjaHVs
dHNjaGlrLCBTdmVuIChESSBQQSBEQ1AgUiZEIDIpIDxzdmVuLnNjaHVsdHNjaGlrQHNpZW1lbnMu
Y29tPjsgY2lwLQ0KPiBkZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBLaXN6a2EsIEph
biAoVCBDRUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBCZXRyZWZmOiBSZTogW2lzYXIt
Y2lwLWNvcmVdW1BBVENIIDgvOF0gbm8gbWVyZ2UgLSBtYW51YWxseSBpbnN0cnVjdGlvbnMgdGVz
dA0KPiBzZWN1cmUgYm9vdA0KPg0KPiBPbiBNb24sIDIwMjItMTAtMjQgYXQgMTQ6MjcgKzAyMDAs
IHN2ZW4uc2NodWx0c2NoaWtAc2llbWVucy5jb20gd3JvdGU6DQo+ID4gRnJvbTogU3ZlbiBTY2h1
bHRzY2hpayA8c3Zlbi5zY2h1bHRzY2hpa0BzaWVtZW5zLmNvbT4NCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9yZWNpcGVzLWJzcC91LWJvb3QvZmlsZXMvc2VjdXJlLWJvb3QuY2ZnLnRtcGwNCj4gPiBi
L3JlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy9zZWN1cmUtYm9vdC5jZmcudG1wbA0KPiA+IGluZGV4
IDhlNjQyODIzOC4uNjNkNzNmNzBhIDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMtYnNwL3UtYm9v
dC9maWxlcy9zZWN1cmUtYm9vdC5jZmcudG1wbA0KPiA+ICsrKyBiL3JlY2lwZXMtYnNwL3UtYm9v
dC9maWxlcy9zZWN1cmUtYm9vdC5jZmcudG1wbA0KPiA+IEBAIC0xLDUgKzEsNSBAQA0KPiA+ICAj
IyMgU2VjdXJlIGJvb3QgY29uZmlnDQo+ID4gLUNPTkZJR19CT09UREVMQVk9LTINCj4gPiArQ09O
RklHX0JPT1RERUxBWT01DQo+ID4gIENPTkZJR19VU0VfQk9PVENPTU1BTkQ9eQ0KPiA+ICBDT05G
SUdfQk9PVENPTU1BTkQ9InNldGVudiBzY2FuX2Rldl9mb3JfYm9vdCAnaWYgdGVzdCAtZSAke2Rl
dnR5cGV9DQo+ICR7ZGV2bnVtfToke2Rpc3Ryb19ib290cGFydH0gZWZpL2Jvb3QvYm9vdCR7RUZJ
X0FSQ0h9LmVmaTsgdGhlbiBsb2FkDQo+ICR7ZGV2dHlwZX0gJHtkZXZudW19OiR7ZGlzdHJvX2Jv
b3RwYXJ0fSAke2tlcm5lbF9hZGRyX3J9DQo+IGVmaS9ib290L2Jvb3Qke0VGSV9BUkNIfS5lZmk7
IGJvb3RlZmkgJHtrZXJuZWxfYWRkcl9yfSAke2ZkdGNvbnRyb2xhZGRyfTsgZmknOw0KPiBydW4g
ZGlzdHJvX2Jvb3RjbWQ7IGVjaG8gJ0VGSSBCb290IGZhaWxlZCEnOyBzbGVlcCAxMDAwOyByZXNl
dCINCj4gPiAgQ09ORklHX0VGSV9WQVJJQUJMRVNfUFJFU0VFRD15DQo+DQo+IENPTkZJR19FRklf
VkFSSUFCTEVTX1BSRVNFRUQgc2hvdWxkIHNldCB0byBOIGluIHRoZSBwcmV2aW91cyBwYXRjaC4N
Cg0KSSBkaWRuJ3QgY2hhbmdlIHRoaXMgdmFyaWFibGUuIEl0IGlzIHRoZSBzZWN1cmUtYm9vdC5j
ZmcudG1wbCBjdXJyZW50bHkgb24gdGhlIG5leHQgYnJhbmNoLg0KRm9yIHRlc3RpbmcgcHVycG9z
ZSB5b3Ugb25seSBuZWVkIHRoZSBCb290ZGVsYXkgdG8gaGF2ZSB0aGUgY2hhbmNlIHRvIGp1bXAg
aW50byB0aGUgdS1ib290DQoNCg==

