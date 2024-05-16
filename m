Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363BFC25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 10:57:37 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.69])
 by mx.groups.io with SMTP id smtpd.web10.10563.1715857046905132123
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 03:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R0Eiu7VT;
 spf=pass (domain: siemens.com, ip: 40.107.255.69, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvHF8/jb4JYskZDkF7wj67pxEYgcoE6giQcKSMbyttm0siagS4dgcfi4htFKYhvOfpFDvoZ7nOkWStGzQutDlSit7XNYJz7S4RaCkzN0hnBCLKyxeXqytoKgTYt09GDEAiK53x5g+w+EUuFiZaeiflvkBr0yUWFcopJ/t8IVtmSsh+4PXcA8Q0qKuiQ3Rpq5mN+VfxkRnmRNhx7QNrGeUIEwxmvR7Kvc8KlLN4PJF3o0nbDseeCOYNiAbDwXXpahFxy3O5eb3Yx+cVADt0TEkEiKMpUJlQM7AV/w0seRsZBSjZ+d57yAVsfGCiHj33/RygI3JwYViqkVu6MeY7aF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYv2kKA6xA+v7g542TXLKPC9lj5rUfVrPPzedfDtiX8=;
 b=FgiXdafhQwf9yMgpsuncOGU/9WvxRylP5cFyp2GUyjBTUPgGv8YFhAfKNsxXUr9DJjHk6lIgun1e1NG8xdkI/TCk4Qie/nNoNXL+N3kelpadkXUTNwZnvJPds4Hp9veeTDH/e8HL6d4/oqYwL2v+GShVYHQ5l/5wFfmybxBQxkrW1Gd3sEBghDDtzrdZZMGu3ajt5WvIfSzyF3NzHhOqzSel6FMEqdfY71m5gc+qkhEYT8e9xbrIua83sMvRnpejQ50vJqs+Q+BJdcw7P8ztpayaZIWVYMu8BTWUewxu8K+aZAdk8PrZlg0TQNxpjmVlwM9N5n679c3WCspX3kSZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYv2kKA6xA+v7g542TXLKPC9lj5rUfVrPPzedfDtiX8=;
 b=R0Eiu7VTl5X/hLUaxMIywCFstiL8kNCWF91D1UYQ1gpLN97zEw8s3vuJ5bRpcUZC+fPrhsa4s7ViAybjaW6wEAoaZoDrzCS8qJL5R8PpfY9o6CjscKCZKYj3RZsUWx/qDaydT9egudSLAAsyIbFCrWTjkg4GsW1Fq7iGhQRx8STAe26nNufAhDTRfV7RLSZShIvw+/6Yt/+1y+x60qCCwjVsJ20193ihuL7hHqC6b7WApZ5nEvLPooi9k2Ahs3/Y94Ft5TFFup3s+m+PLIPR28tK4EiYnSmK/vyvlRM9iQtI8nyWeCqcdKB4qJwlSXCAPe+Dq492sgAGaAm4MMy9cQ==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by SEYPR06MB5016.apcprd06.prod.outlook.com (2603:1096:101:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 10:57:22 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 10:57:22 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an
 optional expand-on-first-boot
Thread-Topic: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an
 optional expand-on-first-boot
Thread-Index: AQHapp0IfIQDyga5lUOTCUxBTcQB+bGYn3AAgAEPjZA=
Date: Thu, 16 May 2024 10:57:22 +0000
Message-ID: 
 <PUZPR06MB57479D4D64AADC96C2DF118388ED2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240515075548.852777-1-srinuvasan.a@siemens.com>
 <035c94ac-4ad6-434b-9eb9-94fd92e80a07@siemens.com>
In-Reply-To: <035c94ac-4ad6-434b-9eb9-94fd92e80a07@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-05-16T10:57:20Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f369a90c-2372-4970-bf13-2d4a3be1a55b;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|SEYPR06MB5016:EE_
x-ms-office365-filtering-correlation-id: a538320d-865c-485f-6d52-08dc7596f6a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MUpEUGxUazYwVG1OQytsbHFBdnhRU055bmoycE1rTzlhdklkMFJ5ZHBFSnU3?=
 =?utf-8?B?V1liNTNMbGZSeEFlaUFabkZ3bjRabWZvWm9WVUVIeUFzYjEwZlI2QXhmUjRP?=
 =?utf-8?B?TVJSU2E2QUlkRmhiYTYzaHo1U25ycWcrM05pSy93YUREaGtKV2l3V2QrS0Ex?=
 =?utf-8?B?V0pqZ2ZvZjFWb0NxN1pxMmducVRXVVlyT25abWNFVS91WlZxZ3pmYTdEVDlY?=
 =?utf-8?B?ZVlITjV5STIyLzdvOHNNdWR5LzRxYzczUGJKUjlwRUtuM2p6N2EwOGVjellu?=
 =?utf-8?B?dWhNWURxdU4va1JBeExLMXJFQ0dhdDhlQXF2YmdqbHhTWXZTOURsS2cyaXVY?=
 =?utf-8?B?OXpNTmE2RWhGbW0vYmZqUjBPMVVRSEV0TmxsTnU2U1ZxN2dNRGdrUTNGVE5u?=
 =?utf-8?B?UFM4K3pCVEorS0xOVnFXN3paakdBck1BMHRmVlhoTnBuaGx5dlRUTEhnS04z?=
 =?utf-8?B?WU04a1M0bGt6ci9RTmlmbU1na05LOHN4VFV1c3pzYVFxZzZJVkRGK2JCQTBk?=
 =?utf-8?B?L1hITlNTalN3R2xUUE1TR0R1M0FFcGJvcTMyNXd3dEg0WWhXSWJ4elFDL0VL?=
 =?utf-8?B?N2tIMG5ZQnFUQTBsQ25RS1ZiNE5aamlIdDhKbHlrMWRvOVA0R1FTeCs5SkxC?=
 =?utf-8?B?Y2U3ZnNPOElhRXNRaFNxRlVRRkw4eUJnWEwzQ2UwSy9kWUVNbktjZENiNUVi?=
 =?utf-8?B?Q0RLemdqcnJzbDE3RHZCL3hxSEdORnRhSW9JZlltWWdKM3BveGpLTjdjeDJI?=
 =?utf-8?B?eWRUMXdvM2RZQVczeUxwVVYwNklLYm1UcUlyOXBBbThHYkZTcnhqYkkzSVNT?=
 =?utf-8?B?UHhMUlFoVGFlbmt1M2NOL2FFQS8rM0l1dmFsNGtoN1l4VWs5bncrdVZMOGhm?=
 =?utf-8?B?L3FRZmVqUW1rL1AwelpIKzFEVWhXQ3YvdUJHVFEvNTdVckZWZUFySW9wVnR2?=
 =?utf-8?B?V0ZaZFk2RFNWNlBMYzFXdnBLcjdvODJJaGo0T0hocG9TTnBDc0I5c01SRk1F?=
 =?utf-8?B?UWMvbXNrS29ZL3BsQld3RTdSUVJYbW1qeGx6NzVZa0NLazZhMXpRemZUNXkr?=
 =?utf-8?B?WGNmWTlINVl6aTcyUE91L2Evb3p2c3c3Yy83dTJIZTVHUkhIVEM5TXRDOWg5?=
 =?utf-8?B?alp6eWJPUURLUUdNSnNUc25icDlHMDRmSkNQNVp0SnZPTHpaZE1IcHRETExL?=
 =?utf-8?B?NUx5Nk9oeVl0MzloZlZsREFLc3RSeC82dHhMYnArSG1LRHMrYzduUGVYeitS?=
 =?utf-8?B?cGhRQzk0bjlTaXpuNEd2WTdrWE14ajRiemhFa2NleVliZzFCV21GbGN1Nzdq?=
 =?utf-8?B?NjNEZDU0eTVWRjlJd0lOQlZ2WHFqQzFUZnFQNy9weC85UFlZdWk5WDRDSTNC?=
 =?utf-8?B?M2laVmhsdTJhdFhNMXNrSXM5OEpDKzVkc3dJSWM4amdyUE5RTnpLY1ZUTG96?=
 =?utf-8?B?Y3luY2VJVFdtb2lTMDRWeGNBY2FuWGprYmw1eGFkbnA0cEhubkFQL3poNWdi?=
 =?utf-8?B?b3MrNnlqSTFjV2RibGJhNEdOZ0hwUWFNb3dvWVBTeWhtS3EzUVFGMjdjdFJK?=
 =?utf-8?B?eU5ma2w1NGc1OTMwbkFmZ1RPbXVOSEplaTNXdmNBZCtDZmpMNVZYY3poY280?=
 =?utf-8?B?YkFlRVRIODgxRC92M1VYVzdRMDNVRGNCSVRMK3dxUnllZHJWemNLOExZNDla?=
 =?utf-8?B?UEQ1a0N5dmszV0pLekIzdFREVzBTSEpZayt3U2hVb0RTTW91cFVOQU9rdUdm?=
 =?utf-8?B?blhWU0dZdm0zQ1JkVzFKdkJBMm9XT3Y1Ym1SWXZEeERCTGlXdE5oZTMzbmt5?=
 =?utf-8?B?YmNzSXMxcUcveHdxdEhYQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VU1zcHR2cng1OHpaYVVTM1A2N2JmTjUzYUh2eXNuTCs5SHpkWlRkc3ByYjJz?=
 =?utf-8?B?WDZuUE5TSVVuVVdGRHZiSUNKVjNQT3pqc1V2Nm81YndaZ2lyZGhQc1ZtUmhi?=
 =?utf-8?B?N2FZVEtkRTU5YnEwU3RWdTBPMW1zMFNSTDdnR0hrS0NIbXFEeEg1ckpBdkk3?=
 =?utf-8?B?RzlMaU1DblFLTys1cWw3R09BVzhyZTNwSGE4cDNlNEdUQW5rUXZsa0l6M0hu?=
 =?utf-8?B?SDZSNk1FbE1Fa3puSWhxcGkzR0IzS0FFZ2V4Z0dJVDVvL2dVK1I2V2x6UlZQ?=
 =?utf-8?B?SGtOc3FLY2c5Vnp6SlUvdk9lc1c3dFVlcTR4U0xVNk9hdWdxekw5aldlN2Qx?=
 =?utf-8?B?anE3VHdUZFl0VWhzMWI5amFDbGxWWnRmTnZmNlYxai9DMzZhT2dIUTUwQmph?=
 =?utf-8?B?dzBkUVZ2cTlUczZSMHl0TWphUUlUNzZOVmdTeFI4VzRKM3lTOXFxM2MyWTVy?=
 =?utf-8?B?WFNTS2JjWE96a1NPWmgxS3FZYmx4K1hRWld6dDBiaUhBS3pLMzhRMGRSQmQ5?=
 =?utf-8?B?MHBMTmwzdENSQjhncXVmM2NpM2RtV29sdEFKbUxDWWJSYVJDdEhXdXVvQjZm?=
 =?utf-8?B?aTR2WVhKeWFTaTJyVk5lbDdkcG9KZGtWMlViaHI0M0NBNktSVW1MNDN0MWwr?=
 =?utf-8?B?QXJvSDVQYTB0V0ZzMlVnTjM0a2pCeUxTU1NhSkIvVmN2dURtbXRIK1IvZ3dm?=
 =?utf-8?B?T0tZUm5mS096bklEZnR4RVQ5c3YyMWMrb0FDbVhKd2ZJNy9ucXRPTlBTRVh5?=
 =?utf-8?B?RUZIQVdxazlTVkhHbXRIaFVWeTRnemJXNWNhTnhKWHJzUjArUEpVbWwwd1hx?=
 =?utf-8?B?dzgrN3JKRzd6Yi84WDE5NjVqVHBaaU00MTNhZHJnS01WTWxGakVwWkIzWUQ0?=
 =?utf-8?B?dWJnSFVCVDU2WkVuMGNSLzQwaFoyOWJhVzU3QkUreEp2NW5sUjlQdkJnVGJJ?=
 =?utf-8?B?Zm5Ud1I2YjluU2I2MVpYSGtSWWdMRUUrc1grN25IQ3ZQczUwQjlmMWxiTlFT?=
 =?utf-8?B?VkFDbFI2QU94OHZxdGkyK1JiZlJYa1FFcTBjNmp3NEhoTVpqR2pXdXN0d0FY?=
 =?utf-8?B?ZnA5dTNrSE1VVFhGWUVBNThGT0FOZmdFYzlucUtxZDZ2cjNwYmlXazBwRENq?=
 =?utf-8?B?UGpycldjelpoNzRCM1FSOU5Mb1BkcFJFMzZRdHkvSTRwQUNVdFFoaWVHY1kr?=
 =?utf-8?B?L2E1YmlPTzFtNXhxL3lxdG1XRE5qQzZBbWlmaE50UXBPWm9ncHA3UFRMeWJG?=
 =?utf-8?B?Z3hjczlPUVhGK2FBbldLVHJuK2dUVHprTE9kZkRuTFRxK1AwYjhteWQzVmtJ?=
 =?utf-8?B?M1N4WHUyUjZxOEl4LzY2M3F4UjNZSlNoaFBhL1RGOFJPWjgwYzdRbitTVmlx?=
 =?utf-8?B?MzFtakF6YUhNaEwwb3YyM1l5T05NU1hrMWZFTjN5TlU5VURsOG4wMGpDWXo1?=
 =?utf-8?B?U3pOOXJHNFBMSUMycC9EN0xmTjNWdnBORHVaT3AyZ2VqZ0pBbGxtUDRrbXp5?=
 =?utf-8?B?aUJNUTRSMTRZaGcxdFlXcC9iQm5uMTAwWlhWT2I2MEx6RjRUcWtyb25Rd1VM?=
 =?utf-8?B?Um1icmJuY2RxWmF2cGFYbDQvb3hDOFoxSS9YTTFKVzdMazVYZStoV3Q1SU01?=
 =?utf-8?B?NmF1TnhYTHEzVlpMUDIzWHFnVC8vS2F5MFkzMlNPZ1dpV0FsbFkzSHZXbDgv?=
 =?utf-8?B?b2V2NTdtTTR0Q014V1dWdmwwNTFnNHJvQitIVkNmSGRnSm5Fd2lJa2ZFc1JX?=
 =?utf-8?B?SUljT21vZ24rY3BvdnppTk5YTGRyY0E3OEpLVWl2eTJsK3pRWURVWUVYNU1w?=
 =?utf-8?B?UmRvTUVOM3RiYnNrQ3dBeUkvM0xtWnBlK2toNzc3MlMxR1ZESy94d1Frc1hQ?=
 =?utf-8?B?dzhrS2wrZ2FyMEZ3aHBJTU9ZYm5TcW9ta3Z0VGlLV2dQdHczam9Qd1JBWFRT?=
 =?utf-8?B?VTBXbGZpQ3diSEJkYlIvUUtKaGZIeG9wcVMzcXRCUElDdXFEWkhoamswa1ZW?=
 =?utf-8?B?dldseWN6R2VGUEk5MmFDYXhjT0c0YXk0VElnWllGaWhGMkZRSGtiY09HTm4w?=
 =?utf-8?B?dHVaaHhxTThKYWpUdlR3S0lsZlU3MXl4SXpYTG9FZVlkdVVDek5BbnpkM0hm?=
 =?utf-8?Q?zWdldSVYoaBRv/JhjyFP59q0g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a538320d-865c-485f-6d52-08dc7596f6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 10:57:22.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xldYGDrfO23yGDhqxcQYrkYwBkQKIXkAy9qojXSW9UjCzBFs6t/Le62MCDAzIqh8g1WwB1YrUFoPwqfuGL7W0IVevzMwbRP2I0XZid+Xi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5016
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 10:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15904

SGkgSmFuLA0KDQpDaXAtY29yZSBhbHJlYWR5IGhhcyB0aGUgZW5jcnlwdGlvbiBzdXBwb3J0LCBp
ZiBhbnlvbmUgaW50ZXJlc3RlZCBob3cgZXhwYW5kLW9uLWZpcnN0IGJvb3Qgd29ya3MgZm9yIGVu
Y3J5cHRlZCBwYXJ0aXRpb24sIGNpcC1jb3JlIGlzIHRoZSByaWdodCBwbGFjZSB0byBkbyB0aGUg
YW5hbHlzZS9maXgsIFB1cmVseSB0aGlzIEkgYnJvdWdodCBmb3IgdW5kZXJzdGFuZGluZyBwdXJw
b3NlcyBvZiBob3cgZXhwYW5kLW9uLWZpcnN0LWJvb3Qgd29ya3Mgd2l0aCB0aGUgZW5jcnlwdGVk
IGZpbGVzeXN0ZW0uIA0KDQoNCk1hbnkgdGhhbmtzLA0KU3JpbnUNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEtpc3prYSwgSmFuIChUIENFRCkgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IA0KU2VudDogMTYgTWF5IDIwMjQgMDA6MDMNClRvOiBBcmp1bmFuLCBTcmludSAoREkg
Q1RPIEZEUyBDRVMgTFggUEJVIDIpIDxzcmludXZhc2FuLmFAc2llbWVucy5jb20+OyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF1baXNhci1jaXAtY29y
ZV0ga2FzL29wdC9leHBhbmQtb24tZmlyc3QtYm9vdC55bWw6IGFkZCBhbiBvcHRpb25hbCBleHBh
bmQtb24tZmlyc3QtYm9vdA0KDQpPbiAxNS4wNS4yNCAwOTo1NSwgc3JpbnV2YXNhbi5hQHNpZW1l
bnMuY29tIHdyb3RlOg0KPiBGcm9tOiBTcmludXZhc2FuIEEgPHNyaW51dmFzYW4uYUBzaWVtZW5z
LmNvbT4NCj4gDQo+IEFkZCBleHBhbmQtb24tZmlyc3QtYm9vdCBwYWNrYWdlIGFzIGFuIG9wdGlv
bmFsIGZpbGUsIHRoaXMgc3lzdGVtZCANCj4gc2VydmljZSBleHBhbmRzIHRoZSBsYXN0IHBhcnRp
dGlvbiBvbiBhIHRoZSBib290IG1lZGl1bSB0byB0aGUgZnVsbCANCj4gc2l6ZSBvZiB0aGF0IG1l
ZGl1bSBhbmQgdGhlbiBkZWFjdGl2YXRlcyBpdHNlbGYuDQo+IA0KDQpTbywgd2hhdCBzaG91bGQg
dGhpcyB0ZWxsIHVzPyBHaXZlbiB0aGUgY29tcGxleGl0eSBvZiB0aGUgY2hhbmdlcyBiZWxvdywg
dGhlIHRleHQgYWJvdmUgZG9lcyBub3QgYWRkIGluZm9ybWF0aW9uLiBBdCB0aGUgc2FtZSB0aW1l
LCBpdCBjb250YWlucyBubyBpbmZvcm1hdGlvbiBhYm91dCBXSFkgd2Ugd2FudCB0aGlzIGNoYW5n
ZS4NCg0KSmFuDQoNCj4gU2lnbmVkLW9mZi1ieTogU3JpbnV2YXNhbiBBIDxzcmludXZhc2FuLmFA
c2llbWVucy5jb20+DQo+IC0tLQ0KPiAga2FzL29wdC9leHBhbmQtb24tZmlyc3QtYm9vdC55bWwg
fCAxNyArKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBrYXMvb3B0L2V4cGFuZC1vbi1maXJzdC1ib290Lnlt
bA0KPiANCj4gZGlmZiAtLWdpdCBhL2thcy9vcHQvZXhwYW5kLW9uLWZpcnN0LWJvb3QueW1sIA0K
PiBiL2thcy9vcHQvZXhwYW5kLW9uLWZpcnN0LWJvb3QueW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDAwMDAwMDAuLjAzZDY2NmINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9r
YXMvb3B0L2V4cGFuZC1vbi1maXJzdC1ib290LnltbA0KPiBAQCAtMCwwICsxLDE3IEBADQo+ICsj
DQo+ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChj
KSBTaWVtZW5zIEFHLCAyMDI0DQo+ICsjDQo+ICsjIEF1dGhvcnM6DQo+ICsjICBTcmludXZhc2Fu
IEFyanVuYW4gPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT4gIyAjIA0KPiArU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IE1JVCAjDQo+ICsNCj4gK2hlYWRlcjoNCj4gKyAgdmVyc2lvbjogMTQNCj4g
Kw0KPiArbG9jYWxfY29uZl9oZWFkZXI6DQo+ICsgIHBhY2thZ2UtZXhwYW5kLW9uLWZpcnN0LWJv
b3Q6IHwNCj4gKyAgICBJTUFHRV9JTlNUQUxMOmFwcGVuZCA9ICIgZXhwYW5kLW9uLWZpcnN0LWJv
b3QiDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoN
Cg==

