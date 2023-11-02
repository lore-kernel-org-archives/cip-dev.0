Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BEC4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:34:17 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.63])
 by mx.groups.io with SMTP id smtpd.web11.25192.1698907530172668469
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Nov 2023 23:45:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XCf2WwYK;
 spf=pass (domain: siemens.com, ip: 40.107.6.63, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVJiwBWQzbxFqex2pV7wj9qLnu9GGz1vD4kbR5Ua17OK83a3TWC0sc3banFy4WuhXaqDGOYUWw1GqPJOtGuCx0OwThmS+PCWz2FcU/W97YdnotQspRFcTscwphISghBZg6ZFeGxu1x94/aYV2GHUQntzlrRt0nCtzuL3D9XpYKlwCvWKDYL/YsCOlwNbj16JfhW71F9LkSHtmy9vk+oafckxGrfzQ0Z2bggNTYemNMNPdIMdfplmZRLVrEIlXpNbd8J/iFJjgxoiJdWGpk8XsQMDu1KH6AelUiAqsqJjbmYUS+j3owEQ+XvcJSvCeZvvgFrZJmHc/X5VmBlClZww5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6KlMshGOSnVexAthJup1wWh8LjqjEFGKueXOAzDWYk=;
 b=HnV1YtQ0AyDk7HUXRvufkD0ZgQ+/F4/TxnDxJjV9F7uDnkgkpHcJmcx8FhA9YHzx30rmotWw6W8gKqBjhHfWDFzxsqe+0t7stNUI0HG2RnWoWbAN4ASbuYRlDj7BKwOiak+QN/kXKG7zM6Isx3Gwa1qnCiZ1jdnL1Wnx3dyxnay4yIpa7Z4h3a8XGm2Vo4Cee0LFkkBEPfLRCN6T6TrGGn2CnPnhIEHvn448mACakEdKMCcioCuMN/pP+OeVwoU/KaUn6Zooy/7hqpPuFfIfNbsC2WLIBStCFWuzXY8OThwXPbnfn77SFXZfV3NRQgpR9adBdQmr4vl7w/+y9whZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6KlMshGOSnVexAthJup1wWh8LjqjEFGKueXOAzDWYk=;
 b=XCf2WwYKF1xIeqZgCyO9xQgoDZW6O+JunvTpyhi/7B3rC+0LsJ+0Cul5jlpJkA7gFW43xevarAThpstuACKb+EgdtNES6uD7EF6+vsAb0CkBgrw1vDpduXBwmzjwb9HuhdC4fFpcKyNChtC2JN8+M4guhYNZC1JXfoywz+Uvg8W8yB+9S2fdOA6F8NJp3ch/6Wu6hp7GdsawakHz+Nju2MQlEvURLd8riEO1NIUnyU/IbLPA0HWlybP1hfr+fV/DXR364NWyUqy7yODsPriEA6Fd+xSrJ2lbXx49+owZvHCVIyex+ljPpv3PhUhCh8n5y2uxn8pGqBaf7Jel8ml65g==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DU0PR10MB7286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 06:45:26 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 06:45:26 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: AdoM5xnui5+ATTT0SDWBKqFXTIkKDgAbCr2AAABS9HA=
Date: Thu, 2 Nov 2023 06:45:26 +0000
Message-ID: 
 <DU0PR10MB6898C5AF36094F948A282906F0A6A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
In-Reply-To: <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bf279d1e-a18f-41a2-b65f-96f0f96fbb49;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-02T06:19:41Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DU0PR10MB7286:EE_
x-ms-office365-filtering-correlation-id: 7e76741a-a815-4a17-6d81-08dbdb6f4c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fhwa7ncFTgqCr3hTSI1LfVKVlVEaM2y1hxUGQTFbAI6/OSTdO9qAqb7FiqTkxJk6C8kOEaCaAALnlvFk7fy8ydvEUmE5Y5iZaQGs9mieA6CR2W1siAZX1KMTkwmmwe2GHM91ArMMY4kdF8aOs+p7TPbaF5PxoRBuTtlBGfVWlBm9aPL/1Xyb2zc5DQ65N1FXu1Dhxk1fQWhigwexi+/J3Wuhk+SPJRT9kqYo0Ibyp5Rlri7SJ75RYlR/GpFHKYowXjLj3sWKy25CyTwAYBzmd2mGeswjiCF08J1Z3B813qmqDdxzzgEcnTAfvCiBGSGvPFA7E+gEFKxUdWhy4wFlaV71gvv5LTCQP/g/OCv2QyMnewHIDOrE78sUJadohKhaGwTa4x5dZGMrT6OVyDW6OGB4/v6aEC1tnanIr7KNzzg8PTI9r20AL1n67Bq93/d6+l3XMpWlqdZUpkFhQKBMrW9F9zCVreMnSHXZq4i1WUikxlQZCRSQPwxhotwyD+Uuo5IaNk7H4byqAZ5m5v6Ue4i2TbLxy4Q66AT3Sp207Pr67RzXTn8yAWiIguifqOrpVnercoB7mt1p6ZtHEmeVm1h6MwHkHqjxKKLPocZRUjlitRvybu/pZksbWqsHLn1dgzXG/6ye7+xrAdTr5W1DWg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(5660300002)(6636002)(316002)(64756008)(41300700001)(66446008)(66556008)(110136005)(66946007)(76116006)(66476007)(52536014)(8676002)(8936002)(55016003)(2906002)(966005)(53546011)(55236004)(83380400001)(33656002)(71200400001)(6506007)(86362001)(7696005)(82960400001)(26005)(478600001)(38100700002)(38070700009)(66574015)(122000001)(9686003)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1d3dC9qM0tiUzBqVzQ4RHJGajlnWUJtTlh6cloyalM2NCtsV3dEOS8xSlF6?=
 =?utf-8?B?Zlp3VkRRWmI5MCtsc1p1OWZuNFNocmxydmxSOG1PUkVZakxzTTBUaXY3OXIx?=
 =?utf-8?B?UHVtWjdQMGtIb2l6WDhLclZzLzBCNENaOUc5YlRSbnZjK2t4djhYd1dCM0Ra?=
 =?utf-8?B?VG4yRzQrQmZ6bko1UXlhTnZXcEVrY2x3Q1pZWGRCNnhvWHFTR2huY0VmZEhv?=
 =?utf-8?B?MVdwQXU0ZWJOU2s5WFJnU2Z0WVhvS05JeUNDUWVWVXBSOUZHdkZ3UHYzNEJ5?=
 =?utf-8?B?Wk96SUFwaEY1U1hYd2NrekR1NTZ0Ykt3akFmdkMvWlRldGM4SDRqUmg2YmdC?=
 =?utf-8?B?NUN5MjJFODZpbUYyY3lLanRHSFBPaUxETENWa3U1dU85MHo4TmtZS3J5ZVJl?=
 =?utf-8?B?UlRUeFJpY21PMEZuNDN6eHg0cFhaWG5qd3Jid3RyV3QvQXpVTGc5b3Iyb2hk?=
 =?utf-8?B?Y1ltYUNqQS9ldE5PMndJY0EvMldsRjdZdGt4NWY5di9tQU16UEJaVDlZanpt?=
 =?utf-8?B?RVYxLzlmVjE3ZGk3bjJhdTBYVDlGZXZGTDJCUjk5VEpldW1UV1RPNlpROFhB?=
 =?utf-8?B?YmZDV1hHSC9VNE9BTVZQQ2JnTkdZOEpVb3ZrMGc2TEEvMUl0LzNRNUJkbTd5?=
 =?utf-8?B?Nm1LeXpiaXlGRG81OGkzMnFmemJSa05maElUNGQ0RzduZ05DQXRMZUtONzlQ?=
 =?utf-8?B?NVlFcmZsVm5KM1k5ZFR4dTJBOEJRTEh0REdWMGdFZ2h4dGhvTUdOeXNZVnRZ?=
 =?utf-8?B?M3FOUnlDTkVvNDh5UGxwd21HSmhFMUszb3dRR2h2dVRlK0drUTk3eElPL2hJ?=
 =?utf-8?B?VXM0aVpmdzlmeDVyd2t0d1QrQUhndG55WldYdDFOSkJ3VmlPTVlQdk5HbE5a?=
 =?utf-8?B?UUs2b0o5RkZSMys2QXBzSkVCTmFkTVdNcVZkRitOVmc5YkN6OUZoYStvZFdW?=
 =?utf-8?B?T0hsL1VNTGxWd0duUVlIVVllaEpnRlU3b2pJekdWZVVkbjRpdWpRSC9aRy9k?=
 =?utf-8?B?T1JrY25LWVFtNkE4VllmYVpCQXRYYzE5WVB4WFFHVHBtWE13L1Z3RW1ndmRU?=
 =?utf-8?B?VTNuNXJ3NzFsZ3NUazIvdjJFZWFXWlFJZndwbUM0TFZzenRNOHhEQ0o2dXRZ?=
 =?utf-8?B?R05sV3hvS3lsWUMrUU5zdFJHWGpsWXRMU0hyWkJiQUNzQk9jS3lpYWRHL0p3?=
 =?utf-8?B?bDRzQ0o3R3RlaGRDaWJqOUFBK24zWWJXTWY4bjV2OHU5TGJ1TnpOTWJobitr?=
 =?utf-8?B?RVRBcjZ5ZXF2aHo4bTJ5bnZ1RTl2bGZzZ1dRWG9zYjBOeDV3Qjh3UlhweDIz?=
 =?utf-8?B?Z3BzZjkrN3EwUFQvYXlYNmVBN2EySkR5dlFXYlNYQnF5cm93Wm1maW5uRXB4?=
 =?utf-8?B?U3VsNlJQR09KRm5wUXFCeFV3Y2Y5NWhoaGhGNHRZNTdMMU9TQkZwY0YxWTVU?=
 =?utf-8?B?cTgybVVqejZBMkFUdE0zTHlFSnZjZ2U4OCt1VDM0VHExdXEzb2czVzBBRzRj?=
 =?utf-8?B?d3RNRGdxejFJeW1DQWNqK2xSMldhRFpPVkhkSXFEQ0pYWS9wMGxnYS9TdVBR?=
 =?utf-8?B?UDNDVmtmNlU4VmhhTERuellxd3cwUEZrYks2dVBPV0pEZHN0QmtKa21TWmha?=
 =?utf-8?B?VDE2aHF2V2d6Mm84emhLaytFUStvL2MxVU5LbkFXenFDWVVFTTNNcGdiVE5U?=
 =?utf-8?B?YkxKL0pHYTZHdCtGN3dzc1hiZWs1RmJ1M3dYdFNMdXh2TzBuM2h1VjBNVG1D?=
 =?utf-8?B?Q2IvWXdvWFkrVHd5OTNRN2RoQzlpY1F0TGpWdUxJaHY4RGRqSTRUSlNBMDgr?=
 =?utf-8?B?eDhQUGhmUmsvZkJONDFLalhFL2s2bm5lZ1k3eEZpeWxYbHJwL0ZJTVEvTmNF?=
 =?utf-8?B?Mzd4ZXFDa0FJWmNpSmJFNVVWckdlQ21lMXhscmtPTGE4UUtoaU8rdDdIOURB?=
 =?utf-8?B?U29IN2lzUEpUcExnZndYSzBoaW42Y0JRVWFNbHh4OFdZNzN0NTZvRDZMQ0Rk?=
 =?utf-8?B?andSRklDelhZRkhiUlAxYkFhQnUrOHZ5QSs4aDdJN1BKVWk2YkJwQUZGWGMw?=
 =?utf-8?B?Q3BTd2Y2NnBHZUFTTm4wUHlSc1FBQTNtdEhkRWdaVU9kOEUrYjJRSDdKTVFt?=
 =?utf-8?Q?0UFgkhV23j/viKJCjE94EDLdd?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e76741a-a815-4a17-6d81-08dbdb6f4c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 06:45:26.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZAG1Ecx5ubL5R0ntFH5jArZ+gtB2j1BD2qtdFCLlXB7ZonUUMVinWknXyW00djKwNBqaFRNjCyQawWjIPN3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7286
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 12:34:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13517

WWVzLCBpdCBpcyBkZWZpbml0ZWx5IG9wZW4gdG8gYSBkaXNjdXNzaW9uLCBzaGExLCBvciBzaGEz
ODQgbWF5IGFsc28gYmUgYXBwbGljYWJsZS4gDQoNClBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUg
NC43IHNlY3Rpb246IGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy93cC1jb250ZW50
L3VwbG9hZHMvUEMtQ2xpZW50LVNwZWNpZmljLVBsYXRmb3JtLVRQTS1Qcm9maWxlLWZvci1UUE0t
MnAwLXYxcDA0X3IwcDM3X3B1Yi0xLnBkZg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogS2lzemthLCBKYW4gKFQgQ0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50
OiAyIEthc8SxbSAyMDIzIFBlcsWfZW1iZSAwOToxMA0KVG86IFNhcmksIFNlcmNhbiAoQURWIEQg
RVUgVFIgQyZFKSA8c2FyaS5zZXJjYW5Ac2llbWVucy5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZzsgR3lsc3RvcmZmLCBRdWlyaW4gKFQgQ0VEIFNFUy1ERSkgPHF1aXJpbi5neWxz
dG9yZmZAc2llbWVucy5jb20+DQpTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIXSBh
ZGRlZCBwY3JfYmFuayBmb3IgY2xldmlzDQoNCk9uIDAxLjExLjIzIDE4OjE3LCBTYXJpLCBTZXJj
YW4gKEFEViBEIEVVIFRSIEMmRSkgd3JvdGU6DQo+IA0KPiBjbGV2aXMgd2lsbCBmYWlsIHRvIGVu
Y3J5cHQgZGF0YSB3aGVuIHRoZSBUUE0gaGFzIG11bHRpcGxlIGJhbmtzLCBzdWNoIGFzIFNIQTEg
YW5kIFNIQTI1NiwgYWRkaW5nIHRoZSBwY3JfYmFuayBpbmZvcm1hdGlvbiByZXNvbHZlcyB0aGlz
IGlzc3VlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VyY2FuIFNhcmkgPHNhcmkuc2VyY2FuQHNp
ZW1lbnMuY29tPg0KPiAtLS0NCj4gIC4uLi9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9lbmNy
eXB0X3BhcnRpdGlvbi5jbGV2aXMuc2NyaXB0ICB8IDIgDQo+ICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgDQo+IGEv
cmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0
aXRpb24uY2xldmkNCj4gcy5zY3JpcHQgDQo+IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZz
LWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uY2xldmkNCj4gcy5zY3JpcHQNCj4g
aW5kZXggODk5ZjIwZS4uOTU3YTNmZCAxMDA2NDQNCj4gLS0tIA0KPiBhL3JlY2lwZXMtaW5pdHJh
bWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLmNsZXZpDQo+
IHMuc2NyaXB0DQo+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29r
L2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLmMNCj4gKysrIGxldmlzLnNjcmlwdA0KPiBAQCAtNjEs
NyArNjEsNyBAQCBvcGVuX3RwbTJfcGFydGl0aW9uKCkgew0KPiAgDQo+ICBlbnJvbGxfdHBtMl90
b2tlbigpIHsNCj4gIAlpZiBbIC14IC91c3IvYmluL2NsZXZpcyBdOyB0aGVuDQo+IC0JCSBjbGV2
aXMgbHVrcyBiaW5kIC1kICIkMSIgdHBtMiAneyJwY3JfaWRzIjoiNyJ9JyA8ICIkMiINCj4gKwkJ
Y2xldmlzIGx1a3MgYmluZCAtZCAiJDEiIHRwbTIgJ3sicGNyX2JhbmsiOiJzaGEyNTYiLCAicGNy
X2lkcyI6IjcifScgPCAiJDIiDQo+ICAJZWxzZQ0KPiAgCQlwYW5pYyAiY2xldmlzIG5vdCBhdmFp
bGFibGUgY2Fubm90IGVucm9sbCB0cG0yIGtleSEiDQo+ICAJZmkNCg0KSXMgc2hhMjY1IHRoZSBv
bmx5IHJlYXNvbmFibGUgc2V0dGluZyBoZXJlPyBKdXN0IGFza2luZyBhcyB3ZSBhcmUgaGFyZC1j
b2RpbmcuDQoNClF1aXJpbiwgYW55IHJlbWFya3M/DQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywg
VGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQo=

