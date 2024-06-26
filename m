Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B85C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:44:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.26924.1719409447284409150
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aS5Bpulo;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+sT4r06dX/RFDcMBlfxVBASb3a8ABjwk/vzU+dGbjJX4kHXERKL3JRQ9RDT5QsayOUEX/CwBy1lNnBKj8Vg5zBxVlvteLHRt2MmGk1UHSiDJoy5EZiDY4YVTa+7cAdya/IMesK7P1lPMUMcmcXCq4ZYEetvKUG79Ov+s/7xyKjTZimxQVD7P0Njh43FWhcIkobPYAH+vY/zE/JTdnF3W1kuF0/HFdDHDVqqsvWJJ7aUQnn00XDveaeLizFuqLaM9wc0/PuXPc3hv8LiqDBmoJ/8V+WHR8iiBrnLAuqsYU4AQQvRz2MMvJNji9QwyeKAG+NyICaSmOfaARx5nP2XIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGI16Asco34LfEVjFHOEWQ3rFuOPChtZRzEB5M4OcQw=;
 b=brd21UXXy8Nj7GDph2HanyeAhuc88IYnCy5+NWp9I/ml5s/Z2bUmcZzfJtKqERyCb0A05HOQhEPsND/l686ypxzA/IstVLqMg3tfm/YDTwqJJbatOQO/+DujVIUj7JkKTHuO0iI7xWJir9qtqs/4hn1W4f246oPwR4PE481JSiZXvpG4Nl5Be/+ZBS/nsGJKhD6/Lbl6RQhLSBbyRw7/TWyB/cafQGMgt0c9012FCXbXor7/DBbQfs/NHz2KM0lP4P2ZoyPkOjpEjp4OD+tMXQKDWgAHZKpxCKC+ZK6fEpD6gBNvkzLRQXiskNa8n87yHLIuavgJak7QjqcKAcV+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGI16Asco34LfEVjFHOEWQ3rFuOPChtZRzEB5M4OcQw=;
 b=aS5BpuloyzBLcVSmdjt3QQolUunNpGiP5cX356H5zbmykuLJaFTbtOl29XgroNredMKBIgIJe63eVqXNYyjIB2ayvbS58v5sGYrROsKH7K6WmUVyOEKtGkUYNkNeSe1Avowbvl+FVQzJwa6qFIsxxzVwQgRvSrpre1QcCH/sRT4PqF2wMmGaHzQH3584xZkiazqVIEuDE6G4Se6849Vi2c8h+CdkuJ/n/jyjeUINDAlZz1ORusRFAN99w7Sd8M+RN4ViGMitOWNmudwtG7bWdzR2MhtQ6/+za+n+qgILWfGKc0TrS48TRgy1YIc5aEMTetWpU3ipdTiiMou86PxyeA==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by VI0PR10MB9074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:44:03 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:44:03 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev][isar-cip-core][PATCH 1/2] initramfs-overlay-hook: Add
 INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Topic: [cip-dev][isar-cip-core][PATCH 1/2] initramfs-overlay-hook: Add
 INITRAMFS_OVERLAY_MOUNT_OPTION
Thread-Index: AQHax76fR+HGVFWSuUOozIA9pOt5irHaB6eAgAAGl3A=
Date: Wed, 26 Jun 2024 13:44:03 +0000
Message-ID: 
 <AS5PR10MB8173FFEE13E6C63A3B2E1D2593D62@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240626114715.70823-1-clara.kowalsky@siemens.com>
 <ba0d9144-d183-4e1b-a46e-7f6c47140c38@siemens.com>
In-Reply-To: <ba0d9144-d183-4e1b-a46e-7f6c47140c38@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=e2b38d25-1d33-4c3b-a8bd-085de14d1f8d;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-06-26T13:43:45Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|VI0PR10MB9074:EE_
x-ms-office365-filtering-correlation-id: 6b20bc5f-689b-4613-321f-08dc95e60ae0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|1800799022|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MEVzNEVVVWFtWCtVc2gyQmVMODZYbGlJUVlFQk04ZFEvSXltdWpDeExBTExy?=
 =?utf-8?B?REtLRjU4bmpDR0ZLZ0UvZU9WcmFqa0pBa0JyUnBhYlc3RC9LNDhLdFc3bElG?=
 =?utf-8?B?VGMrYjlVWXpPMThGMDZZWHVpTXM2YU5saUU0TkhmWC9BczJvOEhlcE9zY3JM?=
 =?utf-8?B?WEhaTGFOWG91R0o3cGtid0Rmb2JKeWV3TjdISGZYUWNwTlA0ejBaSHNpcEtK?=
 =?utf-8?B?bDJic0N6aUxFdkVJell6NzhGSUI2azh5OHRoVnZDVWpxc3FKcmFmQ3JJbkNq?=
 =?utf-8?B?RnoyaU1nNlpUckdPTms1YTFXbnpsMWlLbGJwZkRCUVlaeXVUMU4wU3gzNWZz?=
 =?utf-8?B?QmxmMXFmQ2NZN0RJcjdibk90RFZmYTRxdUZ6L3Q2VHhULzJDWkdGazJIQnF2?=
 =?utf-8?B?Zi9CK2o1bjN3RHFNc1M2cHl6cjgwWHYyR2NVdXByQ3dRQTBVeEZoanVSZXox?=
 =?utf-8?B?LzRTNEZOV1ZmV3B3bTJBYXNRQ2ZxaHE5TXRpRklsN0dhTm4vL1BHeVl0VFFN?=
 =?utf-8?B?TUhleUdDN1Uya1pyeTV5bDBzQkZ1bG9LcHVXekV6SitEL0N4bVl6RUZGd3JE?=
 =?utf-8?B?VGtzRXRTaHo0eHgycWE5bU5nRXpaTFhrK3hDeFY0aldrRmVoVmtXWmtvNjhV?=
 =?utf-8?B?Y2JYY0dMSzN5RTZxNkY3VGFaQ2hmMHl4cVZWVCswRkc4MTVhMzFkdGVaZ1Jz?=
 =?utf-8?B?KytmSmp4OEJ5aFFGVUVVZlh6a2doMytVM1djcmVld3dwcExOa09rUGJLVENB?=
 =?utf-8?B?Uzl1b21OTXg3aVE2NklTRk84ZzVaZTN3OFYzWEhSdVVCL3EwdDN6WUxiTWJn?=
 =?utf-8?B?RllpamJweWJYV0l1UTBMbkNNSERYNFhLbzJVbWJ2NDVOb3hZcFVheFJtZFpj?=
 =?utf-8?B?KytpWUxWSmJLNER0c0s4NVdMNnhib1F5N2svcHNMUlBDZFlDSFBhK0lhS0ti?=
 =?utf-8?B?ZndXcHRPNHJnK2FFWXRlY2RCT0FFUGw4ckFQbTVWTWdYdndqNDM4eXozNmwr?=
 =?utf-8?B?cTFhT2M3Qk1WVVNZSmhXQ0xldFNUV0RRTzkzTHVEL2NGSEpsbzQ3YkcxSlRw?=
 =?utf-8?B?TU5PdjY4bzJPaURtc0MrbDAxbzZrN1hPb3o5eVkvdWlYckdINk9hWURweHpm?=
 =?utf-8?B?TWpsM09yZ2gvSEh2VitydjVFemZFbXlJTjl0SStwN2pFSHB6U0RwcFlKek91?=
 =?utf-8?B?UXNLbHQ1UzFXYW95NHh0dzB5ZTVSWG5ENXBQWG5xVEhodFFHa3RwTElPdzhW?=
 =?utf-8?B?U2FwNW5YbTNDaG4wOGFxMEZ6RGE4TlJkL28waGlESmFmM2NYMmNMazNOY25B?=
 =?utf-8?B?MW9CMit3Zlptc2RrRGhMSFM4WDFZNHVNQm02cE9UUnJCYkxjbEtQNCtJd3E0?=
 =?utf-8?B?N0MrMHpEUmtQbUZseGtHZDFadlFLcEZRcXI3eEx0dEt5QXRrY0FqODhpQ21S?=
 =?utf-8?B?RDNPdkdKdENlSmJEVzRxMUg2Nnd1VDI5T1hJUzdMRjJCOVNVb21seVMvVS9R?=
 =?utf-8?B?VmNXdG8rdE9LQmZ6QmJQZVQveFpSQ3NFMUwwQnJMR1IxUjBqZ3QxZDE5bksz?=
 =?utf-8?B?WEFHMm1sR0xhYnZFNWt5S0xVMmJRTVBCVzRTSXM5dWxvU2RqSmNnOTRuc2tt?=
 =?utf-8?B?MCtYb2U5aDFUQm85TmJnNElRWWVzTm5UUjEyL1I2U0g1VWtOOWk5SllrT0Uz?=
 =?utf-8?B?RFdGYmdmN3dJN1BnYWFXSHFKOVBWTHluVE1iMWV2TWVDcnZsTUl1VzFOTEpp?=
 =?utf-8?B?RzZGUzlORkVuU1lMbE1aQUt5S2NFcjdLYlVtSVlWeHBoYWNMRGxHUkplNGxz?=
 =?utf-8?Q?B5KPduAHh1rpJ64glR3yH/7aLygfyM/2sT/k0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0kzTDZsOU0zbVVwTFZ1by9JZWhRM2VvV25WMGZBTzNHbGpzZXBuSWJ4aFZI?=
 =?utf-8?B?cklQU2h5WUZXZ1BpSzdBM3BxRDJKeXBkOGovT0RuUXVnRTBjWDVISFh5WW5N?=
 =?utf-8?B?R3h2VjBGZGtobmgxSW52Mk91OU5CSkdkcVRqd3RnOUtmTWx5bEFjMSsvTWdG?=
 =?utf-8?B?WTA4MlNIbGRodHNacEdIVUhpWFlXTk5YTWtUOXBvZlRKaDZueWpEMDVWSTNh?=
 =?utf-8?B?Y0F0ZWlLWVlWd2xtSUVRQ210c3Q3eWYvOVl3aGE3aUg1T08rUEkxK2J4WnNJ?=
 =?utf-8?B?YlhvSE1oL2dGWXlPMFBmNFpPTmZ3azljYjhmZkZkc0ZsR2pWUW1pNktJSlVT?=
 =?utf-8?B?UUR4L3hldyszYUZ6RFQ3RW9yNUJ0ckVVcXFjTkdUN0tjd1JqeWFIdU9YWWZ1?=
 =?utf-8?B?SW1LTlYzTy91cnB4SkVOVHBvaWxuZzNadklJZ2JDbzBLVnhhTWxwYjB1Z0d4?=
 =?utf-8?B?N1ZZQVBpTEtoZFJYWk5SVk5tb2laZzluSzkzL1VYUUFQK1FHNTJwRW02VFI1?=
 =?utf-8?B?T3dsa2cyUDBvOElXRnlCRFZaWHNsKzhHUXhYN3R4U3VJckZENDU5cmpIM2hH?=
 =?utf-8?B?NUtKNWt6NlR6b0J2RllYcGVJbXIvMHFmV1JYSmd1SFZxaDdhQU5YbXd4d28v?=
 =?utf-8?B?RHhpajJkYktuUERFdzNFY3Bjbk5LZVh4YmdxaVZSMDFlREFBbFVyV3hvTFFG?=
 =?utf-8?B?NnpEUEFFNll0NW1pZUFLT0VYVlJzQlFWNlhlaHp1azM3Z0pzUFFSODlhalVo?=
 =?utf-8?B?Zk1iMWpuaGxaMjFCekhoeXZsWks3R2RYYUE1S1pIMzV1MXVXc0tTemt5dHZs?=
 =?utf-8?B?OHJjWktBYXFsYU9ySHc0bTZQQVFFUHNjZlNOaGdsTGpZRC9FdWxlemFFSFZR?=
 =?utf-8?B?VVJUVjlYRGYxc3ErNkZ1a1V5S2xtWk1GMWpPMldlcC9UMEZYbzQ1TmtMcUZN?=
 =?utf-8?B?U3VUTnFlRjZpSWdidHJpUUtyODJmNDJIbWNZQ2N0dHRGYjJDdGlsZ0ptMEd3?=
 =?utf-8?B?THo3UC9QUnE5eU4xR3JmZyt2UkpkcHBUNnRUWUhUQmcxTXd1WVhXRHN1bWZL?=
 =?utf-8?B?UUhpdnVkVEFuOGY1VlpWaVVka0xjcjY0RFZacXFsVFRPVW50cVJMVmJwTEIv?=
 =?utf-8?B?SnJGb3RLSmd0bytic0dKSWlzcDZvQjhLYVluV0dvUTRKeTV0aFFHc2pZUzJp?=
 =?utf-8?B?UCtidTd5WG50N1N1Q0x1b05OQlcxQitDaHZSKy83Szd4N3ROSUpxMml2R2J2?=
 =?utf-8?B?eWw5aG5UZjFSOC85OTdxaUZxeFcvditRVVJQNTdBWHFtVEE2RlcvYTJ6c0Zi?=
 =?utf-8?B?QUhpOVhyVGcwOTNiWlFEWmV0Y1l0dTg0ZSs1RDJSR0xrbTFvUGJmZ2pVaHg4?=
 =?utf-8?B?cUNqTytzYVBvZG55cUpVejVvdjhqY08vMEZ2cFRlbUE2Wm1TMFRPY0Jsd2VK?=
 =?utf-8?B?U2I5NExUMmIzRXUreTd0YjJwK3ZKTnY0Snk0a2JpV2ZNOEV1TGgvUlJyR05N?=
 =?utf-8?B?MHFoOFU4ZzdlbVdXUi9vWGk3Y0J1dkUwUVJrV0kwcUs0aWhBa3ZLT1N5YVd3?=
 =?utf-8?B?Um5YRTBhLzJYeGJraUZiSkFrdkJLMXVCSlNCZVQrSHZDMVNuaWJRU3dGOGRI?=
 =?utf-8?B?YmQzN1V5WUhRY3dUR2tnT0pMZHdYMGNuWi93aWlRZW84cnprb3NSOXlBYlFU?=
 =?utf-8?B?SDBMTHRHd1l4ZWxDM2NBUXZGOUlxekM2eU92L0pSMVZYTUZCNWJBMlhXSE9U?=
 =?utf-8?B?ZnhRQUhLRG5oblM4N0JLZUo4bjNlYXVwbzZ2MDFsSnRYb3RlUWlLNHlITzdV?=
 =?utf-8?B?TnV0ZFpmMksrMzRFcEd6VGtiaTZud3ZwcEFsSitqU0JTc05HRDJwdUMycTlo?=
 =?utf-8?B?aEIzeTIzVTF3TklGWUE2YTdQSmZWNUZQVEJHT1ZvRk03eGxyYU8za24xalZP?=
 =?utf-8?B?UVJNdFJ5L21kRXdLMll5RHZ6ZzBycGtCNC9vWGx3V2Fmazh5NUlkSTY0YTZw?=
 =?utf-8?B?SlhMenhGSC9yRWhNdWhQTkY4anVYazN4SUpwVXFvS0FBMWY2UG4yS2FEaTN2?=
 =?utf-8?B?WmRJUHpLbWpsaGZIcnFuVms5bysxRDVNV1U5TlNSVHRKRkdnRWxSaC9LSHZX?=
 =?utf-8?Q?dHSHGhKe2O0HLEtRM56w4OThP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b20bc5f-689b-4613-321f-08dc95e60ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 13:44:03.6970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5EmEOrJno6qWXIhR7yLcJxfS5GnCbfwWJ39P5roB5rTIdoOLEVIPupDCgUmOKUwrnUCMb98lUXnwAKgZmJ3371E0RWDfIVw3o08mVqVkyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9074
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:44:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16330

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3lsc3RvcmZmLCBRdWly
aW4gKFQgQ0VEIE9FUy1ERSkgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IFNlbnQ6
IE1pdHR3b2NoLCAyNi4gSnVuaSAyMDI0IDE1OjIwDQo+IFRvOiBLb3dhbHNreSwgQ2xhcmEgKFQg
Q0VEIE9FUy1ERSkgPGNsYXJhLmtvd2Fsc2t5QHNpZW1lbnMuY29tPjsgS2lzemthLA0KPiBKYW4g
KFQgQ0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl1baXNhci1jaXAtY29yZV1bUEFUQ0ggMS8y
XSBpbml0cmFtZnMtb3ZlcmxheS1ob29rOiBBZGQNCj4gSU5JVFJBTUZTX09WRVJMQVlfTU9VTlRf
T1BUSU9ODQo+IA0KPiANCj4gDQo+IE9uIDYvMjYvMjQgMTo0NyBQTSwgQ2xhcmEgS293YWxza3kg
d3JvdGU6DQo+ID4gVGhpcyBhbGxvd3MgdG8gb3ZlcnJpZGUgdGhlIG1vdW50IG9wdGlvbnMgZnJv
bSBmc3RhYi4NCj4gV2UgZG9uJ3QgcmVhZCB0aGUgZnN0YWIuIFRoaXMgYWxsb3dzIHRvIHNldCBv
cHRpb25zIGR1cmluZyB0aGUgbW91bnQgb2YgdGhlDQo+IG92ZXJsYXkgc3RvcmFnZSBkZXZpY2Uo
L3ZhciBhcyBkZWZhdWx0KS4NCj4gDQo+IFF1aXJpbg0KDQpBbHJpZ2h0LCB0aGFuayB5b3UuIEkg
c2VudCB2Mi4NCkNsYXJhDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENsYXJhIEtvd2Fsc2t5
IDxjbGFyYS5rb3dhbHNreUBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9pbml0cmFt
ZnMtb3ZlcmxheS1ob29rL2ZpbGVzL292ZXJsYXkuc2NyaXB0LnRtcGwgICAgICAgICAgfCAyICsr
DQo+ID4gICAuLi4vaW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMtb3ZlcmxheS1ob29r
XzAuMS5iYiAgICAgIHwgNCArKystDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvcmVjaXBlcy1p
bml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9maWxlcy9vdmVybGF5LnNjcmlwdC50bXBs
DQo+ID4gYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtb3ZlcmxheS1ob29rL2ZpbGVzL292
ZXJsYXkuc2NyaXB0LnRtcGwNCj4gPiBpbmRleCAyNTYzZGZkLi40MmViNTljIDEwMDY0NA0KPiA+
IC0tLQ0KPiA+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9maWxl
cy9vdmVybGF5LnNjcmlwdC50bXBsDQo+ID4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJh
bWZzLW92ZXJsYXktaG9vay9maWxlcy9vdmVybGF5LnNjcmlwdC50bQ0KPiA+ICsrKyBwbA0KPiA+
IEBAIC0zMCwxMiArMzAsMTQgQEAgZXNhYw0KPiA+ICAgb3ZsX3BhcnRpdGlvbl9kZXZpY2U9IiR7
SU5JVFJBTUZTX09WRVJMQVlfU1RPUkFHRV9ERVZJQ0V9Ig0KPiA+ICAgb3ZsX3N0b3JhZ2VfcGF0
aD0iJHtJTklUUkFNRlNfT1ZFUkxBWV9TVE9SQUdFX1BBVEh9Ig0KPiA+ICAgb3ZsX2xvd2VyX2Rp
cnM9IiR7SU5JVFJBTUZTX09WRVJMQVlfUEFUSFN9Ig0KPiA+ICtvdmxfbW91bnRfb3B0aW9uPSIk
e0lOSVRSQU1GU19PVkVSTEFZX01PVU5UX09QVElPTn0iDQo+ID4NCj4gPiAgIHJvb3RfbW91bnRf
c3RvcmFnZT0ke3Jvb3RtbnR9JHtvdmxfc3RvcmFnZV9wYXRofQ0KPiA+ICAgc3RvcmFnZV9tb3Vu
dF9wb2ludD0iJChlY2hvICIke292bF9zdG9yYWdlX3BhdGh9IiB8IGF3ayAtRi8gJ3twcmludA0K
PiBGUyQyfScgKSINCj4gPg0KPiA+ICAgaWYgISBtb3VudHBvaW50IC1xICIke3Jvb3RtbnR9JHtz
dG9yYWdlX21vdW50X3BvaW50fSI7IHRoZW4NCj4gPiAgIAlpZiAhIG1vdW50IC10ICQoZ2V0X2Zz
dHlwZSAke292bF9wYXJ0aXRpb25fZGV2aWNlfSkgXA0KPiA+ICsJCSAtbyAke292bF9tb3VudF9v
cHRpb259IFwNCj4gPiAgIAkJICR7b3ZsX3BhcnRpdGlvbl9kZXZpY2V9IFwNCj4gPiAgIAkJICR7
cm9vdG1udH0ke3N0b3JhZ2VfbW91bnRfcG9pbnR9OyB0aGVuDQo+ID4gICAJCXBhbmljICJDYW4n
dCBtb3VudCAke3N0b3JhZ2VfbW91bnRfcG9pbnR9IHBhcnRpdGlvbiAtDQo+IG92ZXJsYXkgd2ls
bCBub3Qgd29yayEiDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5p
dHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMtb3ZlcmxheS1ob29rXzAuMS4NCj4gPiBiYg0K
PiA+IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMt
b3ZlcmxheS1ob29rXzAuMS4NCj4gPiBiYg0KPiA+IGluZGV4IDI2OTQ3NjYuLjk1NTc0OGYgMTAw
NjQ0DQo+ID4gLS0tDQo+ID4gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtb3ZlcmxheS1o
b29rL2luaXRyYW1mcy1vdmVybGF5LWhvb2tfMC4xLg0KPiA+IGJiDQo+ID4gKysrIGIvcmVjaXBl
cy1pbml0cmFtZnMvaW5pdHJhbWZzLW92ZXJsYXktaG9vay9pbml0cmFtZnMtb3ZlcmxheS1ob29r
Xw0KPiA+ICsrKyAwLjEuYmINCj4gPiBAQCAtMjksMTEgKzI5LDEzIEBAIElOSVRSQU1GU19PVkVS
TEFZX1NUT1JBR0VfUEFUSCA/Pz0NCj4gIi92YXIvbG9jYWwiDQo+ID4NCj4gPiAgICMgb3ZlcnJp
ZGUgdGhpcyB0byBzd2l0Y2ggdG8gVVVJRCBvciBQQVJUVVVJRCBiYXNlZCBtb3VudHMNCj4gPiAg
IElOSVRSQU1GU19PVkVSTEFZX1NUT1JBR0VfREVWSUNFID8/PSAiL2Rldi9kaXNrL2J5LWxhYmVs
L3ZhciINCj4gPiArSU5JVFJBTUZTX09WRVJMQVlfTU9VTlRfT1BUSU9OID8/PQ0KPiAiZGVmYXVs
dHMsbm9kZXYsbm9zdWlkLG5vZXhlYyINCj4gPg0KPiA+ICAgVEVNUExBVEVfRklMRVMgPSAib3Zl
cmxheS5zY3JpcHQudG1wbCINCj4gPiAgIFRFTVBMQVRFX1ZBUlMgKz0gIiBJTklUUkFNRlNfT1ZF
UkxBWV9TVE9SQUdFX1BBVEggXA0KPiA+ICAgICAgIElOSVRSQU1GU19PVkVSTEFZX1BBVEhTIFwN
Cj4gPiAtICAgIElOSVRSQU1GU19PVkVSTEFZX1NUT1JBR0VfREVWSUNFIg0KPiA+ICsgICAgSU5J
VFJBTUZTX09WRVJMQVlfU1RPUkFHRV9ERVZJQ0UgXA0KPiA+ICsgICAgSU5JVFJBTUZTX09WRVJM
QVlfTU9VTlRfT1BUSU9OIg0KPiA+DQo+ID4gICBERUJJQU5fREVQRU5EUyA9ICJpbml0cmFtZnMt
dG9vbHMsIGF3aywgY29yZXV0aWxzLCB1dGlsLWxpbnV4Ig0KPiA+DQo=

