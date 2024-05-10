Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B8C25B5F
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 12:22:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web10.11257.1715343551130598371
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 05:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X7wLOlVZ;
 spf=pass (domain: siemens.com, ip: 40.107.7.73, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3M0i0+7NVkgXOZm8xJh6rjKSy8BUbApvGOeojfMBrBY4u/S3x8TuIxRtxl/6Q4Pfwt61tuFx+Lt0vsRcZLbqNwvJHt6oSyV2fCB/AW9NgiA0Hu5TZpya9cF7Lz9KsTxdQ36c9E5//FNhdZEI34We04HxIbSKhCajtx8M4KdgxRd4GggzwuIhV9uw38AD+eQKgoBjR3kj3rqrnXknxD4wQaZLcPmYEbeydYc5ozDM4jGUo95rXIwkLm9l72OuaBoXlkezZZdv/7E3T6mc8ooxJ1Icg4syiQ8v9uM2PROf5d3sDL8+KIoS5O9Urkb+WiUksZeK1Bs+YOJhp0TrmKj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKyknJfNy1yZ9y47u1Ys+JEqZbdlaO3/ILEidozdKz4=;
 b=Um92OqmBu4SOut0xmEYMbELp1AhLSiyBDnC/0fgBlDj8zOcRiOV33VlQF2Lcm9bDFvmfcFZkDc4FIZP21ltH800qZocfE19S0dsZmCIUlafL3Qvo+XYuT9j+XzUIHOwoe5DZIOI8g5GYxIfwKBrihVYmJKyYKyFk3L780eenTEh3oqSKC1aZENIJeHgnbOOTEflcplK9oS8qrELP/XlMmqyzKspFS7nwfmrVB38pMXkCkIZ4gGN2TFd7Y3jyzWbggTKEruc9LOqzK8l540HsGwV6e/OJcPjvlObX1fCqalQzpZSLz5MRIOL1ln6lt9/ISbQ8f0vYWgviZ1hssvhmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKyknJfNy1yZ9y47u1Ys+JEqZbdlaO3/ILEidozdKz4=;
 b=X7wLOlVZEjXiVAmh9jC+AR49uM64HH+FspmINFj8gtwradKIwaGubfhEv4OjZKLTcsLPPBehn494RzEreT6lQ47adLXi1jHSjz5URGsrEtpkc3KqkJOZ9x5usMVVu4xnTXhX3lo/Rl3w4gOCiOkQwUpIgsQ4IT1a+QuE4zLz9vAdRBKqikUbVbSqKebYDAwVKOlP3ZOHBQq3cQAeRchTRFdr76fvZAuxpsuMUlG5gBPztq6vjxqYOnNr+KCBG0aOJCRVhPWXPhW/yIo2n6Xm1/qkterDkusIueJ/FhJazVrU7zOykban2CzSSnOKgjne4nXEreFYGPtYr5YTR55X4Q==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAXPR10MB7927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 12:19:07 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 12:19:07 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
Subject: Re: [isar-cip-core][PATCH] Enable APT snapshot for reproducible builds
Thread-Topic: [isar-cip-core][PATCH] Enable APT snapshot for reproducible
 builds
Thread-Index: AQHaosvyO0kuj38ga0Ggxsa0z8judbGQYukA
Date: Fri, 10 May 2024 12:19:07 +0000
Message-ID: <a008e3175c8a0cdcea515f4ce3bf3aef38f1b463.camel@siemens.com>
References: <94e8b177-e56e-48d8-b5d2-880758658b6a@siemens.com>
In-Reply-To: <94e8b177-e56e-48d8-b5d2-880758658b6a@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAXPR10MB7927:EE_
x-ms-office365-filtering-correlation-id: 4457c7c4-aff2-489f-80f2-08dc70eb63e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TmtDSHNNbUhKVm9UYUtlMytCNDBPNWtzSVVPM2UxdmtVSXlJL2txbHozZmRo?=
 =?utf-8?B?MGRweTZsVExWbHpvMW5GZlBEdXlISUt1enJPMWRLR2F0ZktTTVI0Z1RXcnNm?=
 =?utf-8?B?T3JrVmJic3VhZDNadUt5MFdPWldIT2p5dHVKMFhiY0lHc1BmcVVsUEl6Vk5u?=
 =?utf-8?B?Tk9pdlh5Zm9aNVhMdndHTlM0a2xveko1RVd5ZklDQU9ENnBoWUg5d3pQNytk?=
 =?utf-8?B?ZjR2TTFiclBteWM5cENGMjFBK2J1TC82ZUhrcmROOVFNa0lQRW82RDhYcTJD?=
 =?utf-8?B?Y2Y2WVlMRHVkWEtrQXNSZmZPQm9DMDNrS1ZlSS9WMEVyS1ZmVFU4RVFpV2U0?=
 =?utf-8?B?d2V3SlNNelpwTWFSNFNrRUE0d3o3STM5RVhQeThNOFpCQ1lteFNJZFgzWHpD?=
 =?utf-8?B?RERIYUk1WDlxUzN3N1d3QXVjTk5nWDZpelRYNmJmTXB2Y0xXL1dPMzdKbFk5?=
 =?utf-8?B?WTYzYlVDWE00RzRMUGRrVHpDRUtCcFgzUXR4blJ5L0oyZ3NGZ2lOS0JJemo0?=
 =?utf-8?B?c1E4RDRKOXduZnVXS2QzSEd4bjVqMTRYS2RiTzZGZzNpOXlZT3d2UXRSSzNS?=
 =?utf-8?B?bFhncXFad0g4KzN2TFczWDdKeG41V1J3WFYzalozcWJhc3ZBNy8zZS84byto?=
 =?utf-8?B?djFaaHdKYTk3b3NPRjBDT1NKNGFOcmFYaTR1WUZIYnRhRFNUTkYvd1dwOGs5?=
 =?utf-8?B?Z2c5MUVteHU3UVpaK0Yxb2xyL0JmUG5uUnVSdXhNUG9qY3hKUmg2VFBNNDdx?=
 =?utf-8?B?RmhhaU9uRHA5cnB3NVlENnFKQmRuUHpubko2TitkVElYSFczSGk2eGlsL1Rj?=
 =?utf-8?B?Qm1hSmlNeHZzSnlXaUNjTEhhdzdlVm01cHB4eFRnVENUd3AvYVlMZG5SaXlq?=
 =?utf-8?B?WExKdnMxSW5zVndVUmx5ZnBoWnU5UU05eThhZzNqSUtoSHBzT05LSDgwOWFl?=
 =?utf-8?B?N3NLcCswTlVKM2JKcGFwbXNjWFJtN21jczVDY2RwYTJZaWVKR25KNUFhekJo?=
 =?utf-8?B?eHVkQVJYZmoxY3Rza3Q1cTJFS3JYUFVaNi80bEtiWnN0WEowS0M2UkhReXB5?=
 =?utf-8?B?YUtyM3FhYkpNS3Nlak1LNjY5WE5QQS9ZR3g1dDhRNHozd04xWjdqbHprdVB1?=
 =?utf-8?B?WnQrUjhiYzVkN2VJKzZxZUZ6cXNhMjlCdDA2STRaS0wxbzhSS2lIcy9iSjd3?=
 =?utf-8?B?Z3hyR2NjQ3REazlRbjNpTmNPV3J1ZUx2NFdKb1c1TjlONmNMcTkrUmJKd2l4?=
 =?utf-8?B?cWxEN1lmTUVjVVZ1ZU90UU85bk80dTc1cFZaRng5bVFVZGgyNVN6cFFyRFVp?=
 =?utf-8?B?Vjh6U2NqYVkzZ1RNdHpKNUlyeE4xY0NvSWM1Z2xhelBIcG5oYU4vTDBHdXAv?=
 =?utf-8?B?R1dXVlhUNzhsOUE2eUtRcGFnbUl5NWI2cjFCTFNSU2U5endwZFFJd1VUSWNZ?=
 =?utf-8?B?UEVEMG8wS0ljak9CcFJRVVo2VVNqNllnckw2L2I4NGxEVDhJcUVqN2NxckhS?=
 =?utf-8?B?T2J6enNjRWhhc3pyUGdKYVBCbkRFQ0w3a3ZJRGhlNXhXaGx0WktBZzh6ZkNN?=
 =?utf-8?B?b1RTcVhMRFVndHc5aGtCUjIrTXZ5Tk56ZHJhd3AzQXJ3NzBzbGNwRTJET1gx?=
 =?utf-8?B?dEs4aWp5UkQ5V1JVRzY0YlRYOWFHbGxuakRmWkpMejZCaEhZZmJkb1ZOV1Uz?=
 =?utf-8?B?NHpUSTBETUl5TElkSDNVd0ZtUWZtdFZYYUZiNDB5OXRzd3dEREJVMkkzWmJn?=
 =?utf-8?B?bkFXazFzVE5ReE9xKzNoOXg5eUN5SlJ4V05oelRGTDZtTnFZMWEvbVlZaStq?=
 =?utf-8?B?ZFp2YkU5Si9FVjJwTTEvdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dk1OWlJQUG9IMG5XekJQamJ6VGJuYU0rTlJTaW5DNVF0RFJwLzRFZ2orYUdF?=
 =?utf-8?B?UHg0SkpmTUJIa3F0YnIzaC95NVR3MGFmYlFSeVhKZnc1WXFHL3g2M2IwV0ww?=
 =?utf-8?B?ZHJ1aVVkK1Awc2ovelppRm5jSDB4TkphR2Evbk82Sm93UGYwQWFpT1BKd3FX?=
 =?utf-8?B?K3BRRklQYzdzMWs0eEc0QUkwaDVmSlpzY3BmWDlwSWdGZk9janF5QXQ1S3Rz?=
 =?utf-8?B?aXpMUDN4V1JaQVpyQ3ZuQlcvYXR0Q3hUQUxJeDh4ZDI3YllOUTJhcjM3ZFlF?=
 =?utf-8?B?VFN5bit3bSt5bmlaYnRITTB4bzQ5RmQrMDIxYmZTckFpdWt3bnlEam1oY0R0?=
 =?utf-8?B?SnY4TUpsOFhZa2xyRlFVTGtxVU9DNVplQ1M3OUsxdk9adEtDcC9wekwxT0Yv?=
 =?utf-8?B?N0YxTHd4Ly9TRWZJWjJmb2JLeHhIdmRwQVhwVEthVXlVMDUvRWlmeTlPWmV3?=
 =?utf-8?B?cDRaSFVtOUlzNjBrWFZjOGxkTVV0NlpRazR0NmNjbDI4aUlNZnBUSTBZampj?=
 =?utf-8?B?QjFHTW5DNU9FS3l1c2ZjYjlaS3F6SXZic1R3THhocDNCdHFyRmlWUXI3VFNt?=
 =?utf-8?B?c0g0ZHFvRHFiQzhZT3AvcWtZRFJPdzVXRU9kWkpOaVh1K2FjU1dpUm9tOEs3?=
 =?utf-8?B?bWhCZmZjcTBZeVZSOGZtRUpVdS93Ry9kRnNvek9ha3ZNRXNvUTdZR3JkazEx?=
 =?utf-8?B?dzRDNFhyOEVQK0pFTUVhR28yT0p4cVYxRzAxVk1pOUhjLzRSa295K3AxZitE?=
 =?utf-8?B?Nk8yUVdrOXdPblA2TERTSXFkd2FSc1pTUmhjaFpLbDkyVjlTWW43Zkk0MkZj?=
 =?utf-8?B?VVgvUmROdjhVUERDRlhuNzQwNk80Q0xyMTVYOUlZZVJ0UzJlaEZoWm9PaWx6?=
 =?utf-8?B?REZ1QnBkZ2U4bVUraU1Bc0lNeU1iUjFjSmh4WUJSVDRib1I2eG8wT2RsVHh2?=
 =?utf-8?B?ckREeEN3aWdpK0dtSWQ0UlVJR1Byc2VOTHo1OHJkTHNTaWhkd3VKd3VUVnNS?=
 =?utf-8?B?RDYvNWdKOWV4U2VWMjNhWEhUUnRpdC9DK2ozVkh2WDE0cUYrNFc2SEo1eWNP?=
 =?utf-8?B?SnhWQzZyZXRZUU5jdU5IUm1PRHp3MUs4eVFieHgvcVB4WTBJdGcvMS92Unp6?=
 =?utf-8?B?N0VJVjk2Z2NoOXo1aWFRdEZ0OVZHbXljL2t2ZFpPdHRQNXBBVUg2SXZacXl4?=
 =?utf-8?B?K2dYNVp5c1lqNDdRcmpOOG9xdmhnTkdKK1pBajVqZFJudE1nV045WlZjODBJ?=
 =?utf-8?B?c2lDbUJ2MVhvMDRrOW9PMGZwam5Gejg5S3RITmRsYXZjTjdXd2E3UnZHUTRL?=
 =?utf-8?B?SVVTZUN2RDZXK0N3K0NLd296bXNWazZyMmtLY0ZGYUlhUXNUTURaUndTbGVu?=
 =?utf-8?B?UnVwVGJNUzlqTmlUTWhIZjVTUFhiME5MdGFiUGM1LzFtNUk1NEdoR2kwY20z?=
 =?utf-8?B?ZDJQOHZwbHZxcjlldHZSanI1djFGeHhTbGlIMlJWeHFHMWVVcTJMdDc2RXF1?=
 =?utf-8?B?Z2ZPUEZ1Ylo3cEhnOHhLN1RNS3FEMFlBSCt1dzVhWlRyNmk0ZmtrcGhxWVNY?=
 =?utf-8?B?N3VvYnNxWEYwcnpKUlBXUUIxWi9nWWpkd0tsTlp1RTh3cllKZDkvZExiZUhP?=
 =?utf-8?B?alo3MmxGYWJPMklqbko0U3ZEMCtwRnVHcHMrdWd6RXM3bjlOUGpOWlU4VERX?=
 =?utf-8?B?OVAwWS9saHVlQ2pGK2M1VkZVTmVmSFhNK1pSYllFcVpON09BZS8yMllvaDVx?=
 =?utf-8?B?RFpnUWYzdzZoYVpDbnZOTTVIODVOaExXVzhmYktqTTRvR2h4emQ0bEkxODVk?=
 =?utf-8?B?NkFveEJUSnFSamtJSW5PKzdEYW10ZzFVSERHWHpaQ1plYzBnNWFCZXQ4bXdo?=
 =?utf-8?B?bHNLQnVPK1dnRzh2YTNsdGYrcmFjNHJjVmw5NmNqb0Fma3gvT1RKaHBoQzJo?=
 =?utf-8?B?bGs5akNHQ2t5VWFzYkJXNkNtNS96NjExZmI5U0tXalVWMGttcVNmK2k3aUt4?=
 =?utf-8?B?YWVyU2VLclZYTFBhVEtjVzdZK3k4bVNhdTc3N09lTytLTmlBTTFSc3JBMXIx?=
 =?utf-8?B?QXU5eUY0WWkrWDlYWVdrU2g2NWlKbXN2ZEk3UDFVZ3B3ZFJYS3UvTVBaRmky?=
 =?utf-8?B?SVNidkV5SlVSZC9rZXVNUjc5ZUh4Y3ZSRDFQUldZcTlEYlpOMXpYT1VnYzFv?=
 =?utf-8?B?VW91RDgveHg1SzY3UGt0b0tsclVSajBXcGRtTVhOSHFSdVl0NkJjeGxBcHgx?=
 =?utf-8?Q?7B21DhIm6PK/lvPCv7kYI4czEVdLaUGuC/vtRuduqc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4457c7c4-aff2-489f-80f2-08dc70eb63e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 12:19:07.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzgBlidU6HEHdWBcwVSx8frytLdhBfsdsMGd4RvGOgRCi9haHrAKlBiWXvnExaABUSlNYyhxunUk3KIHSMeD66Ru+25gNx1iMGbbA94T3fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7927
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA77E8E1627A641A4E990C920FADFE5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 12:22:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15877

T24gRnJpLCAyMDI0LTA1LTEwIGF0IDEzOjE5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gRW5zdXJlcyB0
aGF0IHJlYnVpbGRpbmcgdGhpcyBpbWFnZSBsYXRlciBvbiwgbWF5YmUgb3V0c2lkZSBvZiBDSSwN
Cj4gd2lsbA0KPiBzdGlsbCBnaXZlIHRoZSBzYW1lIHJlc3VsdC4NCg0KU2hhbGwgd2UgcG9ydCB0
aGUgc2lkIHNuYXBzaG90IGxvZ2ljIG92ZXIgdG8gdGhlIG5ldw0KSVNBUl9VU0VfQVBUX1NOQVBT
SE9UPTEgYXMgd2VsbD8gVGhlcmUsIHdlIG5lZWQgdG8gcGluIHRoZSBzbmFwc2hvdA0KdmVyc2lv
biB0byBhIGZpeGVkIHZhbHVlLCB0aG91Z2guDQoNCkZlbGl4DQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoGthcy9v
cHQvcmVwcm9kdWNpYmxlLnltbCB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbCBiL2thcy9v
cHQvcmVwcm9kdWNpYmxlLnltbA0KPiBpbmRleCBiYzcxZjI4Yy4uYTE0ZDU5YzIgMTAwNjQ0DQo+
IC0tLSBhL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiArKysgYi9rYXMvb3B0L3JlcHJvZHVj
aWJsZS55bWwNCj4gQEAgLTE0LDMgKzE0LDQgQEAgaGVhZGVyOg0KPiDCoGxvY2FsX2NvbmZfaGVh
ZGVyOg0KPiDCoMKgIHJlcHJvZHVjaWJsZS1idWlsZHM6IHwNCj4gwqDCoMKgwqAgV0lDX0RFUExP
WV9QQVJUSVRJT05TID0gIjEiDQo+ICvCoMKgwqAgSVNBUl9VU0VfQVBUX1NOQVBTSE9UID0gIjEi
DQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoN
Cg==

