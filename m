Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42AC5B552
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 06:09:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.9699.1749017388212335973
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 23:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=DwAPY6V9;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1749017379;x=1750226979;bh=z8zdbPw8QMYaQYsFT4QEQjKV3GlINdXrvynuTDd
	z6yw=;b=DwAPY6V9aB2Rj8dXJO9+ZZqmHCfeWpM7G2sx/lL65dgHjYNqKk6xDu8mUek+6+BMYT4Ea
	yITj81aYdZ6DbycqcLybfoTaw2YcxgqI/F47k83e3QS6liXvj3PPdwhYcyMI86iRu1N6wnSrp2Aav
	L3tSUv/HA71NgvJnVJUszPsoWunU6hZEDZepD94zbNMYCLWeTB5YFpPHnQygYx5E2vzdfBkhvENrv
	xW7rZsCXHuFgHqYbsHEccfwVryWFU8JuJTmZWzHH4e2Ro1Agvp+8XzJ1o6X9c0dHTpkjUlHd0ZpFw
	hygZxyKOBTyVmPvgFpJS1h+jBazNClsus9D2ohk1Aw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 55469cjl535272; Wed, 4 Jun 2025 15:09:39 +0900
X-Iguazu-Qid: 2yAb5TJli0YzX2zH5r
X-Iguazu-QSIG: v=2; s=0; t=1749017378; q=2yAb5TJli0YzX2zH5r; m=XIsXJ4FDjNHyTYyJIm2voIofm9HLg7Nt4G2IbFBsUR4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 55469bYV4042966
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 15:09:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDrZHr7Seafbst36CFWChbNVHDK3vaFjZeyd4KfVkLZ+pdk4PP3DN1943Gi7SqKiXenh02quxllnSR4L2U9aQgS8aDNeE0lkb7RLhDXHGqibE07ZF+aXKM0eYXtjw6aVO1OU2YP/nA7K0r2vYln8Pc0wdTzLgN+fV2LVo7QtL5wlbpghsoToboM0u9FILCik0fZ9JCnjmSX8a+dP6KdHCuXZxoG3vcc7WUzTSwdHI0rIsMNqW7nRHRqSuD4BhCEYdmD0GcryegwDt1aiTX1iqL3ob0m4+LtTbzSzTEe1SARh6yidn7nBAKiiRzNBWsvZJ8Dpxi+qAOR+lpex2z+n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RGbvoRer3dQw51kWOIawtPrBiG72rsvB5OA4PJnIjs=;
 b=HEZ48g8RgkzfKUnYUpORxYNZedqC+AYI5aQbsWMSoYYSJqtMDv+iTKbyV0bw/FLm0gb1ibQWysmFeKNqWuQG1P/bskcK1+Z8SGbJpC+f9NUjNTm1VfeRlpZ6FK0zvH/7VHP1KI4It6k8W7BzhnmmiqIexx1jSWXYTCE/ab3tvI1NT4GWx9m9YPaDd933tJg7X1udq7tKbMppwvPkYVGnJTr3+h7ivEUiabMtJHOueVrOrSt2zN2HAv0UuqFmca8AHEoJUvEOatLF64fFpR7tDMn9So5PGMBP4J95qJz46jfjNPfp32tWtLm1522+Ao0sBtjG4D6KLAVKMNAVb6rdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Topic: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Index: AQHb1GipN1cO6uv4Jk6AKTwQmigop7PyhYGQ
Date: Wed, 4 Jun 2025 06:09:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481886E2F4073789E4561908926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14718:EE_
x-ms-office365-filtering-correlation-id: c5915ecb-23d8-4535-1fd2-08dda32e6005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WXNYdnJEK21iakRucGJkZVg1YkRVc29ObURDOHhWU1BxM1BQN2ljbjl5?=
 =?iso-2022-jp?B?OEEzSjljUHNBajNPZ2puWTFmSkhVQ1E2T1BXWG84SW1ZNmUvV1UycVRh?=
 =?iso-2022-jp?B?VU9qL3IrYWZOUWVYcEh5Y2RvSkNZQmo2VGpiZWRucHpjVkVIM1R2czN5?=
 =?iso-2022-jp?B?UlVRU2RSeXVINHduRWN0UU1vNW03M0RiVjc2bk5tZjJZK2ZmbnMxRUo2?=
 =?iso-2022-jp?B?NVJLc0tFTEY5cmVJSi9ydDdqbFlCekkwdTBrWHNnU2k2MWp1SEpFUzF0?=
 =?iso-2022-jp?B?VmgrU1NCUkZjWkxNRGpzU1JLcmxDOWRqRmRQWStCWDVEek9wTTNBaWs4?=
 =?iso-2022-jp?B?aGtHNFRLRkFobmIyS21sUWIxWWQ5MWkzbU5QTk55b2QwdUJxODNtbmJp?=
 =?iso-2022-jp?B?Q0l5SE40NkR1ajRFYW5NRDBPakFrQU8rQ25YQjhGK2FJeXlUa0VYSEpv?=
 =?iso-2022-jp?B?RW1kVUF5TXlKR1pTSXNQNEFyVXNodjQ4RGdlQjBSUElMSGtVL1oxVUF0?=
 =?iso-2022-jp?B?VlFuNWZ2ZWY2bUZYK2IrR3A3QkF2K0N2MDZSVXdMdVVWR0FoR2s0eGNC?=
 =?iso-2022-jp?B?VE4xSkhzcDUzNFdKbEdqQUw5YkZRZ3NVaUU4S05nZ1BBaXBEWnpsRCs5?=
 =?iso-2022-jp?B?SU1ORVZ3Vmt3MGlxYi9OV3Rhd2VyWHZrOVpkL1JWMWZBdGViWncyRDZk?=
 =?iso-2022-jp?B?Um5GMnNhZ3N1K09kMTR4bm43TnRnRGsraFpUZjlFd1NmWHA2d1ljV0pH?=
 =?iso-2022-jp?B?Rk4rQWRvbm5HWDdvQS9zWGVBd29adno1ZmdWL2lKbGphckFpc281dWdY?=
 =?iso-2022-jp?B?Z2xCMTJITVcwdzRjdldjczFLd1g5eGJ5VVF1NmdNSTdKQVRxd3pqa3Bw?=
 =?iso-2022-jp?B?QnNpVVd3RmYzdHF3c0M0SmJzWGlyRlowQzVLUzkxT1YxN3pOUjlpMWhY?=
 =?iso-2022-jp?B?dG84akdsaUwvOHRiZ01YTFB3U2g0YUZ5aGhkNkZCVUxkS09oNDZGWlAy?=
 =?iso-2022-jp?B?VHhYeVk5LzRUTFRQN1ovL1BiQjc4QzBMbThFQ2lrVUpob1FOVE9TZjJx?=
 =?iso-2022-jp?B?UUo0V08xVzNhZU1LWlJBUVBiS2Y1RG04RXpSaDZIL3RxK3ZtR0JMcnhp?=
 =?iso-2022-jp?B?UGw4VkF3TlkwY2tDd3RBYTNzRVlKS3BUekxjZU9jZGh6bXF1Q0JSc3JB?=
 =?iso-2022-jp?B?K1VPOGNTNDlUYTBTQ29mVDlnY25uc1VqamhMM21sT0t0UEt5Z1hpenVY?=
 =?iso-2022-jp?B?RFpDU2JXVjRON3JVdGQzNVgxd3B5M04rMDdBRU11MWFwelAvdE9GL2I4?=
 =?iso-2022-jp?B?TWlORzZ2djNWYW1PZ3p6Z1VuRFNSWTlSSm00RjhDK3VhUnYwbU5KTmRX?=
 =?iso-2022-jp?B?NE1uS1FSUERUZ3ExblN0MDQzem9mV1hDaWRtSHRMRlZ6anNXbnJsUnJH?=
 =?iso-2022-jp?B?UjJ1d1pVck95OVBhQmQ0MVBqdmtmUUpyYVV1N0tFa1BmRjBrZ0UzeEFW?=
 =?iso-2022-jp?B?Zk0wNk5OdXBjK3F1WnpMenhSQzFEYXBRalV4Y1ozS3ZBMDIrclNKbUo4?=
 =?iso-2022-jp?B?WXU1S3JBVmZDT0dsVmZrOVpMM3JFR1h4WXFvUGN2L003TEZmcjRrWS9Q?=
 =?iso-2022-jp?B?RjZDMW1DM0srd2FIb2V4NXVGTmNzK0R5M09lUVBCbkZxYllhWER1Nysr?=
 =?iso-2022-jp?B?RWlBK3ByNFdoZmMvbnIrYU9xTFhPOWxyOTVTTHVLd3MxenlWeVB6NDhs?=
 =?iso-2022-jp?B?S0tHMHVrTVc2QlhVYXJHdTJzMHR0VWFwb1BxWFNGNFQ1MC9OdDhIODZD?=
 =?iso-2022-jp?B?ODBEM2J6d0tFVEgreFVFVDBKVERhenYvYkFOUUJoTjRjclhpcE5VdTE1?=
 =?iso-2022-jp?B?eVBuUnhtbnZmVWZkWUNVUFFYMm1WVU5ZbldoZHpteDl4eEN6Y014MzBP?=
 =?iso-2022-jp?B?V1hid1ZJY3B3US8vYWF0R1p3SitwaEF0K1VSdGV4bnI1QXp4VWpzaFkr?=
 =?iso-2022-jp?B?M0JjeHVKOU5OU1JpUFlyOU8wZm81SGZodWpPNS90OFczd2J3S0JNQ1Bp?=
 =?iso-2022-jp?B?K0NTNmxWUFh1RnZZcW1OSEx3L1lwTnc9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dExwdnlHdHJzN3hPcmtoV3BBTmpwZUxtMGUvSStlVVVvYzRaYUp2VGd3?=
 =?iso-2022-jp?B?M1FpZGpJU2dzVHZ5V2M4MUVGbjRvRHBPb3dMRXptdXhwQzZlQVc5VnBj?=
 =?iso-2022-jp?B?WHQ2UFlSbVd5cmdPWGNLMVF2Y1l2RVJSbXZDRVZJY1l0MG9GYUNoRHlT?=
 =?iso-2022-jp?B?UzgxdXplM3NuU2FjZEVUU3B4WWdHemFvclJVWjdPTG0xT0dKYlVUNElM?=
 =?iso-2022-jp?B?ZG50T0RCSzVMSGFTWTFQSmhKU2tHVXpxZTh5eXA5Y3JDRTUwdDRjb24y?=
 =?iso-2022-jp?B?M2NhcHRZa3FQS3pDeHlqaHh0Wkc3K2NlTklvOTBtT3ZnbzBLZjEwRjYz?=
 =?iso-2022-jp?B?ZDhTSElwbmFQU0pDK2d4M1NlY2lyMFZGTllMekhjK3EzMSt5STdMd0tB?=
 =?iso-2022-jp?B?S1I3eDJRSVBzK3JFV3ZJWElNRDR1NWs0dmJ0WlVQTHlIWGtCVk9sZk5R?=
 =?iso-2022-jp?B?d1VwcC8rcjRUR25rSk9XQ3pHaUphb2FKOTRxVTR5OWFyWXNGWmJ4eGx4?=
 =?iso-2022-jp?B?MUpEZkhEMzMrOFBTWEZPVFBFb1d6RFprZ1JuYVNid2FvYlJmVnJjMzJu?=
 =?iso-2022-jp?B?V0tzb0NKcGk2a1hyS2tzTHJBSXZBcjAvTFI1QjFSSW9qQ1IvaDlPMnZr?=
 =?iso-2022-jp?B?YVdTNjEvaEZkRXJrTWRQOGlXc3puaHN3M25uaDhUTDhBZ3o1STNZZEJN?=
 =?iso-2022-jp?B?WFVCcGFUQlhaYkQyck8xa0Y5dktuYW9IQnRUb0djLzI2ZG5QRWVydy9v?=
 =?iso-2022-jp?B?ekV2QXVmTndvckVQbkpOVzYwSjJKZUVYcFk5Z2ZCd2JGVlR6ZWJ4Wnhk?=
 =?iso-2022-jp?B?WklEV1RQWmQzWnNTMDd5RnBuczRQRXJwLzB6ajlReWpERlJRbzlCNkd6?=
 =?iso-2022-jp?B?SmRtWU5KMDhDMFFqL0dHYVVvTG5XSWRheml2Tk9LM2hrNjRrV1VJQUxn?=
 =?iso-2022-jp?B?SFJaVE9kdU5ncEYyT2FjYWhGTTRSd21CckpQMkNDSFlTS3kxK1NFTEQ2?=
 =?iso-2022-jp?B?b0VDQ2dkN0taS2ZkQkkzcVlBcTNxb3hHdFFEamQ4UC9WWjNXT3lUa1o0?=
 =?iso-2022-jp?B?RGtkNC9VelJ0bXBqLy9sV1hvamdNQ2JMcllrYzN2US9lVTB3YjFLZkg3?=
 =?iso-2022-jp?B?azgyMmxkcE1ubXVITmUwdkV5eU9yN0pwZEcvcE11S1ZQR2EwaHlzb3lu?=
 =?iso-2022-jp?B?Qkd0OXNpOEZiRmVyQWlzOC9CVlFsbkJleGhxOTAvQXpQS2ZXaUdkcm5J?=
 =?iso-2022-jp?B?SFFGU1lBQkNkTE1KQVB4V3pkZnZXY0JHQldzNXlpTEZuU09FdS95NXVp?=
 =?iso-2022-jp?B?dmhVbzQ4SDB1L2lJS1RuQXVkbjRLcE4zZDBQSnVDbk1BZ2hHcU41dm5v?=
 =?iso-2022-jp?B?ZnZtSm9od1lQSmQwNldPYUxIYVJaSmwvdXp6MEJaNVR1NTJZSmVEVWdx?=
 =?iso-2022-jp?B?dkFrK21qNE8zVzE5UHZRaVQwenRLdm15YzZjU1dTUnQwRERmdXcvUDBz?=
 =?iso-2022-jp?B?QmJPaXNWdy8yeVVGRWIyOFQxMjYyTjMrOTMzMzNsU3FmNnFqVWZ6eG5I?=
 =?iso-2022-jp?B?b3o1SHR3RVcxM0ZvUkxiZUR5M3hsUzRKNGhTYmNjOVhsLzhxRTRQMVQx?=
 =?iso-2022-jp?B?OWw4cnNoU3ZSR2hpVTZuMnBhTy9OaktIYitDNDd3M0lwcVNxNk1IWG9U?=
 =?iso-2022-jp?B?YUcwQmpqbEJTcHlDQzJGTTRlQnVLM0ViMzgyNnlIU3M5ZEpiRkxGeDg3?=
 =?iso-2022-jp?B?cWlHSDBxakx5UDVsWUZLaHFnRDNLdFRUY1NkZHZiQnRHTXJidjJEcytq?=
 =?iso-2022-jp?B?S0xvV3hmMjlXaXA2enJZTklHZXNUR2FGRVU2MWprVE83dG0yVitIUzVP?=
 =?iso-2022-jp?B?UC9ZRlRMNTFnV0paa3BFTFNlK1RwVk5HbStKeVRwWk50cTRvWWMzUDU1?=
 =?iso-2022-jp?B?N25JVTNNcVFrc1ZRSiswVU5tWVNsTFh0VlExdisyQ2prUkY2Q2dNSVFE?=
 =?iso-2022-jp?B?TTQwelU0TFN2aXlUMmVqVVVGaUNISTFXcHpBcWtpM1BFeTBVSCtZRVpp?=
 =?iso-2022-jp?B?d3E0aDJDRGdxRmRzLzdnbmNVVC9TZms1Qys2dTJDN2FLTXhQNWI2TkVj?=
 =?iso-2022-jp?B?djNpeTdKSUFPYTZYNmRSNjBjZ2M4S2NJK0JMUWdoNHcyRXplOGtETFU1?=
 =?iso-2022-jp?B?U1NMTVJ4b05QeDA4ckdTdlVGSklOdjh1WFhueUZLbi94SXM3NlFUdmdF?=
 =?iso-2022-jp?B?bHVIeWpkdzZKekVvNFBuQkUvNnpGTG1BOTI1WmVUb2hMSHNMUUphYXRn?=
 =?iso-2022-jp?B?c3NKaHVrZUo3N0F6RTd3bTVvWWg3bEkzVkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5915ecb-23d8-4535-1fd2-08dda32e6005
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:09:33.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eQsDjHmb1hyIxZavAnpr/b25WGEKO4anZmd6k+Htikcm2gRUJSt1boVH7XH4hmTWqEVw1E4PUhwRy4ynFj7OpePO4hiqYKo8X5Gf/GguXBDr7sh6c9gIzEABRl0c53r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14718
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 06:09:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18997

HI all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Tuesday, June 3, 2025 6:20 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (7):
>   clk: renesas: r9a08g045: Add clock, reset and power domain for the
>     remaining SCIFs
>   serial: sh-sci: Update the suspend/resume support
>   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
>   arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
>   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
>     different switches
>   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
>   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
>=20
> Geert Uytterhoeven (1):
>   serial: sh-sci: Save and restore more registers
>=20
>  arch/arm64/boot/dts/renesas/Makefile          |  3 +
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
> +++++++++++++++++
>  .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
>  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 20 +++-
>  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
>  drivers/tty/serial/sh-sci.c                   | 96
> ++++++++++++++++++-
>  8 files changed, 305 insertions(+), 27 deletions(-)  create mode 100644
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

I reviewed this series, looks good to me.
I can apply these, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/185234969=
7

Best regards,
  Nobuhiro


